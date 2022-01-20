/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | www.openfoam.com
     \\/     M anipulation  |
-------------------------------------------------------------------------------
    Copyright (C) 2011-2012 OpenFOAM Foundation
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

#include "NSCBCFvPatchField.H"
#include "addToRunTimeSelectionTable.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "EulerDdtScheme.H"
#include "CrankNicolsonDdtScheme.H"
#include "backwardDdtScheme.H"

// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

template<class Type>
Foam::NSCBCFvPatchField<Type>::NSCBCFvPatchField
(
    const fvPatch& p,
    const DimensionedField<Type, volMesh>& iF
)
:
    fvPatchField<Type>(p, iF)
{}


template<class Type>
Foam::NSCBCFvPatchField<Type>::NSCBCFvPatchField
(
    const NSCBCFvPatchField& ptf,
    const fvPatch& p,
    const DimensionedField<Type, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    fvPatchField<Type>(ptf, p, iF, mapper)
{}


template<class Type>
Foam::NSCBCFvPatchField<Type>::NSCBCFvPatchField
(
    const fvPatch& p,
    const DimensionedField<Type, volMesh>& iF,
    const dictionary& dict
)
:
    fvPatchField<Type>(p, iF, dict)
{}


template<class Type>
Foam::NSCBCFvPatchField<Type>::NSCBCFvPatchField
(
    const NSCBCFvPatchField& ptpsf
)
:
    fvPatchField<Type>(ptpsf)
{}


template<class Type>
Foam::NSCBCFvPatchField<Type>::NSCBCFvPatchField
(
    const NSCBCFvPatchField& ptpsf,
    const DimensionedField<Type, volMesh>& iF
)
:
    fvPatchField<Type>(ptpsf, iF)
{}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

template<class Type>
Foam::NSCBCFvPatchField<Type>::updateCoeffs() 
{
    if (this->updated())
    {
        return;
    }

    Field<Type> newValues(this->patchInternalField());
    this->operator==(newValues);
    fixedValueFvPatchField<Type>::updateCoeffs();
    
}




// ************************************************************************* //
