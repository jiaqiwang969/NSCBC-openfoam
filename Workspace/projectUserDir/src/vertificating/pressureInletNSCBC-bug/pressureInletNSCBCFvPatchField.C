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
//    uniformValue_(),
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
//    uniformValue_(ptf.uniformValue_.clone(p.patch())),
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
 //   uniformValue_(PatchFunction1<scalar>::New(p.patch(), "uniformValue", dict)),
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
        dict.lookup("fieldInf") >> fieldInf_;

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
 //   uniformValue_(),
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
 //   uniformValue_(),
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

    const scalar t = this->db().time().timeOutputValue();


    const GeometricField<Type, fvPatchField, volMesh>& field =
        this->db().objectRegistry::template
        lookupObject<GeometricField<Type, fvPatchField, volMesh>>
        (
            this->internalField().name()
        );

    // Calculate the advection speed of the field wave
    // If the wave is incoming set the speed to 0.
    // const scalarField w(Foam::max(advectionSpeed(), scalar(0)*));

    const  scalarField cP(soundSpeed());
    const  scalarField aP(advectionSpeed());


   // const scalarField fx(uniformValue_->value(t));

    const fvPatchScalarField& rhop =
            this->patch().template lookupPatchField<volScalarField, scalar>
            (
                rhoName_
            );

    const fvPatchVectorField& Up =
            this->patch().template lookupPatchField<volVectorField, vector>(UName_);



    label patchi = this->patch().index();

    // Non-reflecting outflow boundary
    // If lInf_ defined setup relaxation to the value fieldInf_.
    if (lInf_ > 0)
    {

	    if
		    (
		     ddtScheme == fv::EulerDdtScheme<scalar>::typeName
		     || ddtScheme == fv::CrankNicolsonDdtScheme<scalar>::typeName
		    )
		    {
			    // Calculate the field relaxation coefficient k (See A2.2.2)
			    const scalarField K(etaAc_*(1.0-sqr(aP/cP))*cP/lInf_);

			    this->valueFraction() = (1.0 )/(1.0  + (aP-cP)/2.0*deltaT*this->patch().deltaCoeffs()) ;
			    // ref-B.2.2
			    this->refValue() =
				    (
				     field.oldTime().boundaryField()[patchi]
				     + K * deltaT/2.0 * rhop * cP * ((this->patch().nf() & (Up - this->patch().nf() * UInf_))) * fieldInf_
				    )/( 1.0 );
			    // ref-B.2.3
			   // this->refGrad() =  1.0 * rhop * cP * (this-> patch().nf() & Up.snGrad()) * fieldInf_;
		    }
	    else if (ddtScheme == fv::backwardDdtScheme<scalar>::typeName)
	    {
		    // Calculate the field relaxation coefficient k (See A2.2.2)
		    const scalarField K(etaAc_*(1.0-sqr(aP/cP))*cP/lInf_);

		    this->valueFraction() = (1.5 )/(1.5 + (aP-cP)/2.0*deltaT*this->patch().deltaCoeffs()) ;
		    // ref-B.2.2
		    this->refValue() =
			    (
			     2.0*field.oldTime().boundaryField()[patchi]
                           - 0.5*field.oldTime().oldTime().boundaryField()[patchi]
			    +  K * deltaT/2.0 * rhop * cP * ((this->patch().nf() & (Up - this->patch().nf() * UInf_))) * fieldInf_
			    )/( 1.5 );
		    // ref-B.2.3
		   // this->refGrad() = 1.0 * rhop * cP * (this-> patch().nf() & Up.snGrad()) * fieldInf_;
	    }
        else
        {
            FatalErrorInFunction
                    << "lInf_ must above 0 "
                    << exit(FatalError);
        }
    }

    mixedFvPatchField<Type>::updateCoeffs();
}


template<class Type>
void Foam::pressureInletNSCBCFvPatchField<Type>::write(Ostream& os) const
{
    fvPatchField<Type>::write(os);
 //   uniformValue_->writeData(os);

    os.writeEntryIfDifferent<word>("phi", "phi", phiName_);
    os.writeEntryIfDifferent<word>("rho", "rho", rhoName_);
    os.writeEntryIfDifferent<word>("U", "U", UName_);
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
