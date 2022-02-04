/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     | Website:  https://openfoam.org
    \\  /    A nd           | Copyright (C) 2011-2019 OpenFOAM Foundation
     \\/     M anipulation  |
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

#include "temperatureOutletNSCBCFvPatchField.H"
#include "addToRunTimeSelectionTable.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "EulerDdtScheme.H"
#include "CrankNicolsonDdtScheme.H"
#include "backwardDdtScheme.H"
#include "localEulerDdtScheme.H"

// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

template<class Type>
Foam::temperatureOutletNSCBCFvPatchField<Type>::temperatureOutletNSCBCFvPatchField
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
    pName_("p"),
    pInf_(0.0),
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
Foam::temperatureOutletNSCBCFvPatchField<Type>::temperatureOutletNSCBCFvPatchField
(
    const temperatureOutletNSCBCFvPatchField& ptf,
    const fvPatch& p,
    const DimensionedField<Type, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    mixedFvPatchField<Type>(ptf, p, iF, mapper),
    UName_(ptf.UName_),
    phiName_(ptf.phiName_),
    rhoName_(ptf.rhoName_),
    pName_(ptf.pName_),
    fieldInf_(ptf.fieldInf_),
    lInf_(ptf.lInf_),
    psiName_(ptf.psiName_),
    pInf_(ptf.pInf_),
    gamma_(ptf.gamma_),
    etaAc_(ptf.etaAc_)
{}


template<class Type>
Foam::temperatureOutletNSCBCFvPatchField<Type>::temperatureOutletNSCBCFvPatchField
(
    const fvPatch& p,
    const DimensionedField<Type, volMesh>& iF,
    const dictionary& dict
)
:
    mixedFvPatchField<Type>(p, iF),
    UName_(dict.lookupOrDefault<word>("U", "U")),
    phiName_(dict.lookupOrDefault<word>("phi", "phi")),
    rhoName_(dict.lookupOrDefault<word>("rho", "rho")),
    psiName_(dict.lookupOrDefault<word>("psi", "thermo:psi")),
    pName_(dict.lookupOrDefault<word>("p", "p")),
    pInf_(readScalar(dict.lookup("pInf"))),
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
Foam::temperatureOutletNSCBCFvPatchField<Type>::temperatureOutletNSCBCFvPatchField
(
    const temperatureOutletNSCBCFvPatchField& ptpsf
)
:
    mixedFvPatchField<Type>(ptpsf),
    UName_(ptpsf.UName_),
    phiName_(ptpsf.phiName_),
    rhoName_(ptpsf.rhoName_),
    pName_(ptpsf.pName_),
    psiName_(ptpsf.psiName_),
    pInf_(ptpsf.pInf_),
    gamma_(ptpsf.gamma_),
    etaAc_(ptpsf.etaAc_),
    fieldInf_(ptpsf.fieldInf_),
    lInf_(ptpsf.lInf_)
{}


template<class Type>
Foam::temperatureOutletNSCBCFvPatchField<Type>::temperatureOutletNSCBCFvPatchField
(
    const temperatureOutletNSCBCFvPatchField& ptpsf,
    const DimensionedField<Type, volMesh>& iF
)
:
    mixedFvPatchField<Type>(ptpsf, iF),
    UName_(ptpsf.UName_),
    phiName_(ptpsf.phiName_),
    rhoName_(ptpsf.rhoName_),
    pName_(ptpsf.pName_),
    psiName_(ptpsf.psiName_),
    pInf_(ptpsf.pInf_),
    gamma_(ptpsf.gamma_),
    etaAc_(ptpsf.etaAc_),
    fieldInf_(ptpsf.fieldInf_),
    lInf_(ptpsf.lInf_)
{}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

template<class Type>
Foam::tmp<Foam::scalarField>
Foam::temperatureOutletNSCBCFvPatchField<Type>::advectionSpeed() const
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
            this->patch().template 
	    lookupPatchField<volScalarField, scalar>(rhoName_);

        return phip/(rhop*this->patch().magSf());
    }
    else
    {
        return phip/this->patch().magSf();
    }
}


template<class Type>
Foam::tmp<Foam::scalarField>
Foam::temperatureOutletNSCBCFvPatchField<Type>::soundSpeed() const
{
        const fvPatchField<scalar>& psip =
           this->patch().template
                lookupPatchField<volScalarField, scalar>(psiName_);

	return  sqrt(gamma_/psip);
}



template<class Type>
void Foam::temperatureOutletNSCBCFvPatchField<Type>::updateCoeffs()
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
    // -: const scalarField w(Foam::max(advectionSpeed(), scalar(0)));
    const  scalarField cP(soundSpeed());
    const  scalarField aP(advectionSpeed());

 
    const fvPatchScalarField& rhop =
            this->patch().template lookupPatchField<volScalarField, scalar>
            (
                rhoName_
            );

    const fvPatchVectorField& Up =
            this->patch().template lookupPatchField<volVectorField, vector>(UName_); 

//    const fvPatchScalarField& pp =
//            this->patch().template lookupPatchField<volScalarField, scalar>(pName_);


   // const fvPatchScalarField& pp =
   //         this->patch().template lookupPatchField<volScalarField, scalar>
   //         (
   //             pName_
   //         );

    label patchi = this->patch().index();

    // If lInf_ defined setup relaxation to the value fieldInf_.
    if (lInf_ > 0)
    {
	    if
		    (
		     ddtScheme == fv::EulerDdtScheme<scalar>::typeName
		     || ddtScheme == fv::CrankNicolsonDdtScheme<scalar>::typeName
		    )
		    {

			    Info << "Insert NRI-NSCBC Code  "<<endl;
			    // Calculate the field relaxation coefficient k (See A2.2.2)
			    const scalarField K(etaAc_*(1.0-sqr(aP/cP))*cP/lInf_);


			    // ref-B.2.1
			    this->valueFraction() = (1.0 + K*deltaT/2.0)/(1.0 + K*deltaT/2.0 + (aP+cP)/2.0*deltaT*this->patch().deltaCoeffs()) ;
			    // ref-B.2.2
			    this->refValue() =
				    (
				     field.oldTime().boundaryField()[patchi] 
				     + K * deltaT/2.0 * pInf_ * fieldInf_    
				    )/( 1.0 + K * deltaT/2.0);
			    // ref-B.2.3
			    this->refGrad() = - 1.0 * rhop * cP * (this-> patch().nf() & Up.snGrad()) * fieldInf_;
		    }
	    else
	    {
		    FatalErrorInFunction
			    << "lInf_ must above 0 "
			    << exit(FatalError);
	    }
    }
    else //lInf_ = 0 equal to waveTransimition
    {
	    FatalErrorInFunction
		    << "lInf_ must above 0 " 
		    << exit(FatalError);
    }

    mixedFvPatchField<Type>::updateCoeffs();
}


template<class Type>
void Foam::temperatureOutletNSCBCFvPatchField<Type>::write(Ostream& os) const
{
    fvPatchField<Type>::write(os);

    os.writeEntryIfDifferent<word>( "phi", "phi", phiName_);
    os.writeEntryIfDifferent<word>( "rho", "rho", rhoName_);
    os.writeEntryIfDifferent<word>( "U", "U", UName_);
    os.writeEntryIfDifferent<word>( "p", "p", pName_);
    os.writeEntry( "pInf", pInf_);
    os.writeEntry( "gamma", gamma_);
    os.writeEntry( "etaAc", etaAc_);
    if (lInf_ > 0)
    {
        os.writeEntry( "fieldInf", fieldInf_);
        os.writeEntry( "lInf", lInf_);
    }

    this->writeEntry( "value", os);
}


// ************************************************************************* //
