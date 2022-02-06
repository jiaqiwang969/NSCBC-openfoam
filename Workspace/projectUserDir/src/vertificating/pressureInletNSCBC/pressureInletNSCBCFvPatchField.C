/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | www.openfoam.com
     \\/     M anipulation  |
-------------------------------------------------------------------------------
    Copyright (C) 2011-2016 OpenFOAM Foundation
    Copyright (C) 2020 OpenCFD Ltd.
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "pressureInletNSCBCFvPatchField.H"
#include "addToRunTimeSelectionTable.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "EulerDdtScheme.H"
#include "CrankNicolsonDdtScheme.H"
#include "backwardDdtScheme.H"
#include "localEulerDdtScheme.H"


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

template<class Type>
Foam::pressureInletNSCBCFvPatchField<Type>::pressureInletNSCBCFvPatchField
(
    const fvPatch& p,
    const DimensionedField<Type, volMesh>& iF
)
:
    mixedFvPatchField<Type>(p, iF),
    UName_("U"),
    phiName_("phi"),
    rhoName_("rho"),
    psiName_("thermo:psi"), 
    UInf_(0.0),
    gamma_(0.0),
    etaAc_(0.25),
    fieldInf_(Zero),
    lInf_(-GREAT)
{
    this->refValue() = Zero;
    this->refGrad() = Zero;
    this->valueFraction() = 0.0;
}


template<class Type>
Foam::pressureInletNSCBCFvPatchField<Type>::pressureInletNSCBCFvPatchField
(
    const pressureInletNSCBCFvPatchField& ptf,
    const fvPatch& p,
    const DimensionedField<Type, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    mixedFvPatchField<Type>(ptf, p, iF, mapper),
    UName_(ptf.UName_),
    phiName_(ptf.phiName_),
    rhoName_(ptf.rhoName_),
    fieldInf_(ptf.fieldInf_),
    lInf_(ptf.lInf_),
    psiName_(ptf.psiName_),
    UInf_(ptf.UInf_),
    gamma_(ptf.gamma_),
    etaAc_(ptf.etaAc_)
{}


template<class Type>
Foam::pressureInletNSCBCFvPatchField<Type>::pressureInletNSCBCFvPatchField
(
    const fvPatch& p,
    const DimensionedField<Type, volMesh>& iF,
    const dictionary& dict
)
:
    mixedFvPatchField<Type>(p, iF),
    UName_(dict.lookupOrDefault<word>("U", "U")),
    phiName_(dict.getOrDefault<word>("phi", "phi")),
    rhoName_(dict.getOrDefault<word>("rho", "rho")),
    psiName_(dict.lookupOrDefault<word>("psi", "thermo:psi")),
    UInf_(readScalar(dict.lookup("UInf"))),
    gamma_(readScalar(dict.lookup("gamma"))),
    etaAc_(readScalar(dict.lookup("etaAc"))),
    fieldInf_(Zero),
    lInf_(-GREAT)
{
    if (dict.found("value"))
    {
        fvPatchField<Type>::operator=
        (
            Field<Type>("value", dict, p.size())
        );
    }
    else
    {
        fvPatchField<Type>::operator=(this->patchInternalField());
    }

    this->refValue() = *this;
    this->refGrad() = Zero;
    this->valueFraction() = 0.0;

    if (dict.readIfPresent("lInf", lInf_))
    {
        dict.readEntry("fieldInf", fieldInf_);

        if (lInf_ < 0.0)
        {
            FatalIOErrorInFunction(dict)
                << "unphysical lInf specified (lInf < 0)" << nl
                << "    on patch " << this->patch().name()
                << " of field " << this->internalField().name()
                << " in file " << this->internalField().objectPath()
                << exit(FatalIOError);
        }
    }
}


template<class Type>
Foam::pressureInletNSCBCFvPatchField<Type>::pressureInletNSCBCFvPatchField
(
    const pressureInletNSCBCFvPatchField& ptpsf
)
:
    mixedFvPatchField<Type>(ptpsf),
    UName_(ptpsf.UName_),
    phiName_(ptpsf.phiName_),
    rhoName_(ptpsf.rhoName_),
    psiName_(ptpsf.psiName_),
    UInf_(ptpsf.UInf_),
    gamma_(ptpsf.gamma_),
    etaAc_(ptpsf.etaAc_),
    fieldInf_(ptpsf.fieldInf_),
    lInf_(ptpsf.lInf_)
{}


template<class Type>
Foam::pressureInletNSCBCFvPatchField<Type>::pressureInletNSCBCFvPatchField
(
    const pressureInletNSCBCFvPatchField& ptpsf,
    const DimensionedField<Type, volMesh>& iF
)
:
    mixedFvPatchField<Type>(ptpsf, iF),
    UName_(ptpsf.UName_),
    phiName_(ptpsf.phiName_),
    rhoName_(ptpsf.rhoName_),
    psiName_(ptpsf.psiName_),
    UInf_(ptpsf.UInf_),
    gamma_(ptpsf.gamma_),
    etaAc_(ptpsf.etaAc_),
    fieldInf_(ptpsf.fieldInf_),
    lInf_(ptpsf.lInf_)
{}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

template<class Type>
Foam::tmp<Foam::scalarField>
Foam::pressureInletNSCBCFvPatchField<Type>::advectionSpeed() const
{
    const surfaceScalarField& phi =
        this->db().objectRegistry::template lookupObject<surfaceScalarField>
        (phiName_);

    fvsPatchField<scalar> phip =
        this->patch().template lookupPatchField<surfaceScalarField, scalar>
        (
            phiName_
        );

    if (phi.dimensions() == dimDensity*dimVelocity*dimArea)
    {
        const fvPatchScalarField& rhop =
            this->patch().template lookupPatchField<volScalarField, scalar>
            (
                rhoName_
            );

        return phip/(rhop*this->patch().magSf());
    }
    else
    {
        return phip/this->patch().magSf();
    }
}

template<class Type>
Foam::tmp<Foam::scalarField>
Foam::pressureInletNSCBCFvPatchField<Type>::soundSpeed() const
{
        const fvPatchField<scalar>& psip =
           this->patch().template
                lookupPatchField<volScalarField, scalar>(psiName_);

        return  sqrt(gamma_/psip);
}



template<class Type>
void Foam::pressureInletNSCBCFvPatchField<Type>::updateCoeffs()
{
    if (this->updated())
    {
        return;
    }

    const fvMesh& mesh = this->internalField().mesh();

    word ddtScheme
    (
        mesh.ddtScheme(this->internalField().name())
    );
    scalar deltaT = this->db().time().deltaTValue();

    const GeometricField<Type, fvPatchField, volMesh>& field =
        this->db().objectRegistry::template
        lookupObject<GeometricField<Type, fvPatchField, volMesh>>
        (
            this->internalField().name()
        );

    // Calculate the advection speed of the field wave
    // If the wave is incoming set the speed to 0.
    // const scalarField w(Foam::max(advectionSpeed(), scalar(0)));
    const  scalarField cP(soundSpeed());
    const  scalarField aP(advectionSpeed());

    const scalarField w((aP-cP)/2.0);

    const scalarField alpha(w*deltaT*this->patch().deltaCoeffs());

    const fvPatchScalarField& rhop =
            this->patch().template lookupPatchField<volScalarField, scalar>
            (
                rhoName_
            );

    const fvPatchVectorField& Up =
            this->patch().template lookupPatchField<volVectorField, vector>(UName_);
    

    label patchi = this->patch().index();

    // If lInf_ defined setup relaxation to the value fieldInf_.
    if (lInf_ > 0)
    {
        // Calculate the field relaxation coefficient k (See notes)
        // const scalarField k(w*deltaT/lInf_);
        const scalarField k(etaAc_*rhop*sqr(cP)*(1.0-sqr(aP/cP))/2.0/lInf_*deltaT*(this->patch().nf() & ( Up - this->patch().nf() * UInf_)));
        
        if
        (
            ddtScheme == fv::EulerDdtScheme<scalar>::typeName
         || ddtScheme == fv::CrankNicolsonDdtScheme<scalar>::typeName
        )
        {
            this->refValue() =
            (
                field.oldTime().boundaryField()[patchi] + k*fieldInf_
            )/(1.0);

            this->valueFraction() = (1.0)/(1.0 + alpha);
        }
        else
        {
            FatalErrorInFunction
                << ddtScheme << nl
                << "    on patch " << this->patch().name()
                << " of field " << this->internalField().name()
                << " in file " << this->internalField().objectPath()
                << exit(FatalError);
        }
    }
    else
    {
	    FatalErrorInFunction
                    << "lInf_ must above 0 "
                    << exit(FatalError);
    }

    mixedFvPatchField<Type>::updateCoeffs();
}


template<class Type>
void Foam::pressureInletNSCBCFvPatchField<Type>::write(Ostream& os) const
{
    fvPatchField<Type>::write(os);

    os.writeEntryIfDifferent<word>("phi", "phi", phiName_);
    os.writeEntryIfDifferent<word>("rho", "rho", rhoName_);
    os.writeEntry("UInf", UInf_);
    os.writeEntry("gamma", gamma_);
    os.writeEntry("etaAc", etaAc_);

    if (lInf_ > 0)
    {
        os.writeEntry("fieldInf", fieldInf_);
        os.writeEntry("lInf", lInf_);
    }

    this->writeEntry("value", os);
}


// ************************************************************************* //
