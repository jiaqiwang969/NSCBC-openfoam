/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | www.openfoam.com
     \\/     M anipulation  |
-------------------------------------------------------------------------------
    Copyright (C) 2019 OpenCFD Ltd.
    Copyright (C) YEAR AUTHOR, AFFILIATION
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

// dynamicCode:
// SHA1 = 63cd80aea5fb11094980d31a9e0fe994437d1854
//
// unique function name that can be checked if the correct library version
// has been loaded
extern "C" void rampedMixed_63cd80aea5fb11094980d31a9e0fe994437d1854(bool load)
{
    if (load)
    {
        // Code that can be explicitly executed after loading
    }
    else
    {
        // Code that can be explicitly executed before unloading
    }
}

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

makeRemovablePatchTypeField
(
    fvPatchVectorField,
    rampedMixedMixedValueFvPatchVectorField
);


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

rampedMixedMixedValueFvPatchVectorField::
rampedMixedMixedValueFvPatchVectorField
(
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF
)
:
    mixedFvPatchField<vector>(p, iF)
{
    if (false)
    {
        printMessage("Construct rampedMixed : patch/DimensionedField");
    }
}


rampedMixedMixedValueFvPatchVectorField::
rampedMixedMixedValueFvPatchVectorField
(
    const rampedMixedMixedValueFvPatchVectorField& ptf,
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    mixedFvPatchField<vector>(ptf, p, iF, mapper)
{
    if (false)
    {
        printMessage("Construct rampedMixed : patch/DimensionedField/mapper");
    }
}


rampedMixedMixedValueFvPatchVectorField::
rampedMixedMixedValueFvPatchVectorField
(
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF,
    const dictionary& dict
)
:
    mixedFvPatchField<vector>(p, iF, dict)
{
    if (false)
    {
        printMessage("Construct rampedMixed : patch/dictionary");
    }
}


rampedMixedMixedValueFvPatchVectorField::
rampedMixedMixedValueFvPatchVectorField
(
    const rampedMixedMixedValueFvPatchVectorField& ptf
)
:
    mixedFvPatchField<vector>(ptf)
{
    if (false)
    {
        printMessage("Copy construct rampedMixed");
    }
}


rampedMixedMixedValueFvPatchVectorField::
rampedMixedMixedValueFvPatchVectorField
(
    const rampedMixedMixedValueFvPatchVectorField& ptf,
    const DimensionedField<vector, volMesh>& iF
)
:
    mixedFvPatchField<vector>(ptf, iF)
{
    if (false)
    {
        printMessage("Construct rampedMixed : copy/DimensionedField");
    }
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

rampedMixedMixedValueFvPatchVectorField::
~rampedMixedMixedValueFvPatchVectorField()
{
    if (false)
    {
        printMessage("Destroy rampedMixed");
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void rampedMixedMixedValueFvPatchVectorField::updateCoeffs()
{
    if (this->updated())
    {
        return;
    }

    if (false)
    {
        printMessage("updateCoeffs rampedMixed");
    }

//{{{ begin code
    #line 35 "/lustre/home/acct-medgm/medgm/05-NSCBC/Workspace/run/sineWaveDamping/0/U.boundaryField.inlet"
const scalar t = this->db().time().value();
	    const scalar pi = constant::mathematical::pi;
             
            const scalar frequency_=3000;
            const vector amplitude_=vector(1, 0, 0);
            const vector level_=vector(1, 0, 0);
         
            const scalar scale_=1;
	    this->refValue() =
		amplitude_*sin(2*pi*frequency_*t)*exp(-sqr(t-0.0028)/0.0000018) + level_;
	    this->refGrad() = Zero;
	    this->valueFraction() = 1.0;
//}}} end code

    this->mixedFvPatchField<vector>::updateCoeffs();
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************************************************************* //

