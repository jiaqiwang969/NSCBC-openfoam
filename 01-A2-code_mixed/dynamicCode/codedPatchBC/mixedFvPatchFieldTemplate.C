/*---------------------------------------------------------------------------*  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     | Website:  https://openfoam.org
    \\  /    A nd           | Copyright (C) YEAR OpenFOAM Foundation
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

#include "mixedFvPatchFieldTemplate.H"
#include "addToRunTimeSelectionTable.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "surfaceFields.H"
#include "unitConversion.H"
//{{{ begin codeInclude

//}}} end codeInclude


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * Local Functions * * * * * * * * * * * * * * //

//{{{ begin localCode

//}}} end localCode


// * * * * * * * * * * * * * * * Global Functions  * * * * * * * * * * * * * //

extern "C"
{
    // dynamicCode:
    // SHA1 = 590c5c451fe15dc07eb76be2e1a9d960fe687e77
    //
    // unique function name that can be checked if the correct library version
    // has been loaded
    void codedPatchBC_590c5c451fe15dc07eb76be2e1a9d960fe687e77(bool load)
    {
        if (load)
        {
            // code that can be explicitly executed after loading
        }
        else
        {
            // code that can be explicitly executed before unloading
        }
    }
}

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

makeRemovablePatchTypeField
(
    fvPatchScalarField,
    codedPatchBCMixedValueFvPatchScalarField
);


const char* const codedPatchBCMixedValueFvPatchScalarField::SHA1sum =
    "590c5c451fe15dc07eb76be2e1a9d960fe687e77";


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

codedPatchBCMixedValueFvPatchScalarField::
codedPatchBCMixedValueFvPatchScalarField
(
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF
)
:
    mixedFvPatchField<scalar>(p, iF)
{
    if (false)
    {
        Info<<"construct codedPatchBC sha1: 590c5c451fe15dc07eb76be2e1a9d960fe687e77"
            " from patch/DimensionedField\n";
    }
}


codedPatchBCMixedValueFvPatchScalarField::
codedPatchBCMixedValueFvPatchScalarField
(
    const codedPatchBCMixedValueFvPatchScalarField& ptf,
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    mixedFvPatchField<scalar>(ptf, p, iF, mapper)
{
    if (false)
    {
        Info<<"construct codedPatchBC sha1: 590c5c451fe15dc07eb76be2e1a9d960fe687e77"
            " from patch/DimensionedField/mapper\n";
    }
}


codedPatchBCMixedValueFvPatchScalarField::
codedPatchBCMixedValueFvPatchScalarField
(
    const fvPatch& p,
    const DimensionedField<scalar, volMesh>& iF,
    const dictionary& dict
)
:
    mixedFvPatchField<scalar>(p, iF, dict)
{
    if (false)
    {
        Info<<"construct codedPatchBC sha1: 590c5c451fe15dc07eb76be2e1a9d960fe687e77"
            " from patch/dictionary\n";
    }
}


codedPatchBCMixedValueFvPatchScalarField::
codedPatchBCMixedValueFvPatchScalarField
(
    const codedPatchBCMixedValueFvPatchScalarField& ptf
)
:
    mixedFvPatchField<scalar>(ptf)
{
    if (false)
    {
        Info<<"construct codedPatchBC sha1: 590c5c451fe15dc07eb76be2e1a9d960fe687e77"
            " as copy\n";
    }
}


codedPatchBCMixedValueFvPatchScalarField::
codedPatchBCMixedValueFvPatchScalarField
(
    const codedPatchBCMixedValueFvPatchScalarField& ptf,
    const DimensionedField<scalar, volMesh>& iF
)
:
    mixedFvPatchField<scalar>(ptf, iF)
{
    if (false)
    {
        Info<<"construct codedPatchBC sha1: 590c5c451fe15dc07eb76be2e1a9d960fe687e77 "
            "as copy/DimensionedField\n";
    }
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

codedPatchBCMixedValueFvPatchScalarField::
~codedPatchBCMixedValueFvPatchScalarField()
{
    if (false)
    {
        Info<<"destroy codedPatchBC sha1: 590c5c451fe15dc07eb76be2e1a9d960fe687e77\n";
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void codedPatchBCMixedValueFvPatchScalarField::updateCoeffs()
{
    if (this->updated())
    {
        return;
    }

    if (false)
    {
        Info<<"updateCoeffs codedPatchBC sha1: 590c5c451fe15dc07eb76be2e1a9d960fe687e77\n";
    }

//{{{ begin code
    #line 35 "/lustre/home/acct-medgm/medgm/01-dealFoam/Workspace/24-codedMixed-boundary/coded_mixed/0/T/boundaryField/codedPatch"
const scalar t = this->db().time().value();
		const scalar pi= constant::mathematical::pi;
		
		const fvPatch& patchs = this->patch();  // Actual boundary/patch
    		label mixedPatchID = patchs.patch().boundaryMesh().findPatchID("codePatchBC"); // Desired patch ID
                const fvPatch& MixedPatch = patchs.boundaryMesh()[mixedPatchID]; // Desired patch

    	        const volScalarField& tMixed = this->db().objectRegistry::template lookupObject<volScalarField>("T");//Desired field 1
    	        const scalarField& tPatchField = tMixed.boundaryField()[mixedPatchID];// Desired field on desired patch
                
                

                if (t<=1)
		{
			this->refValue()= 0.01*tPatchField.value() +273.0+100*sin(0.5*pi*t);
			this->refGrad()=0;
			this->valueFraction() = 1;                   
		}
		else
		{
			this->valueFraction()= 1;
		        this->refGrad()=0;
			this->refValue()=0;
			
		}
//}}} end code

    this->mixedFvPatchField<scalar>::updateCoeffs();
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************************************************************* //

