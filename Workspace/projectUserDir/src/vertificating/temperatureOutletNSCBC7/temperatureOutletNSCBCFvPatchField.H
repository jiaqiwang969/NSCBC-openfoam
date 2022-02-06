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

Class
    Foam::temperatureOutletNSCBCFvPatchField

Description
    This boundary condition provides an temperatureOutletNSCBC outflow condition, based on
    solving DDt(W, field) = 0 at the boundary where \c W is the wave velocity
    and \c field is the field to which this boundary condition is applied.

    The standard (Euler, backward, CrankNicolson, localEuler) time schemes are
    supported.  Additionally an optional mechanism to relax the value at
    the boundary to a specified far-field value is provided which is
    switched on by specifying the relaxation length-scale \c lInf and the
    far-field value \c fieldInf.

    The flow/wave speed \c (w) at the outlet is provided by the virtual function
    advectionSpeed() the default implementation of which requires the name of
    the flux field \c (phi) and optionally the density \c (rho) if the
    mass-flux rather than the volumetric-flux is given.

    The flow/wave speed at the outlet can be changed by deriving a specialised
    BC from this class and over-riding advectionSpeed()  e.g. in
    waveTransmissiveFvPatchField the advectionSpeed() calculates and returns
    the flow-speed plus the acoustic wave speed creating an acoustic wave
    transmissive boundary condition.

Description
    This boundary condition provides a wave transmissive outflow condition,
    based on solving DDt(W, field) = 0 at the boundary \c W is the wave velocity
    and \c field is the field to which this boundary condition is applied.

    The wave speed is calculated using:

        \f[
            w_p = \frac{\phi_p}{|Sf|} + \sqrt{\frac{\gamma}{\psi_p}}
        \f]

    where

    \vartable
        w_p     | patch wave speed
        \phi_p  | patch face flux
        \psi_p  | patch compressibility
        Sf      | patch face area vector
        \gamma  | ratio of specific heats
        \etaAc  | ratio of modified terms 
    \endvartable
Usage
    \table
        Property     | Description             | Required    | Default value
        phi          | flux field name         | no          | phi
        rho          | density field name      | no          | rho
        psi          | compressibility field name | no       | thermo:psi
        gamma        | ratio of specific heats (Cp/Cv) | yes |
        etaAc        |
    \endtable

    Example of the boundary condition specification:
    \verbatim
    <patchName>
    {
        type            temperatureOutletNSCBC;
        phi             phi;
        psi             psi;
        gamma           1.4;
        etaAc           0.1;
    }
    \endverbatim
Usage
    \table
        Property     | Description             | Required    | Default value
        phi          | flux field name         | no          | phi
        rho          | density field name      | no          | rho
        fieldInf     | value of field beyond patch | no      |
        lInf         | distance beyond patch for \c fieldInf | no |
    \endtable

    Example of the boundary condition specification:
    \verbatim
    <patchName>
    {
        type            temperatureOutletNSCBC;
        phi             phi;
    }
    \endverbatim

Note
    If \c lInf is specified, \c fieldInf will be required; \c rho is only
    required in the case of a mass-based flux.

SourceFiles
    temperatureOutletNSCBCFvPatchField.C

\*---------------------------------------------------------------------------*/

#ifndef temperatureOutletNSCBCFvPatchField_H
#define temperatureOutletNSCBCFvPatchField_H

#include "mixedFvPatchFields.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

/*---------------------------------------------------------------------------*\
                  Class temperatureOutletNSCBCFvPatchField Declaration
\*---------------------------------------------------------------------------*/

template<class Type>
class temperatureOutletNSCBCFvPatchField
:
    public mixedFvPatchField<Type>
{
protected:

    // Private Data
        //- Name of the velocity field
	word UName_;

        //- Name of the flux transporting the field
        word phiName_;

        //- Name of the density field used to normalise the mass flux
        //  if necessary
        word rhoName_;
   
        word pName_;

        //- Field value of the far-field
        Type fieldInf_;


        //- Relaxation length-scale
        scalar lInf_;

        //- Name of the compressibility field used to calculate the wave speed
        word psiName_;

        //- Velocity of inlet
        scalar pInf_;
        
        //- Heat capacity ratio
	scalar gamma_;

        // - etaAc ratio for NSCBC boundary 
        scalar etaAc_;

public:

    //- Runtime type information
    TypeName("temperatureOutletNSCBC");


    // Constructors

        //- Construct from patch and internal field
        temperatureOutletNSCBCFvPatchField
        (
            const fvPatch&,
            const DimensionedField<Type, volMesh>&
        );

        //- Construct from patch, internal field and dictionary
	temperatureOutletNSCBCFvPatchField
        (
            const fvPatch&,
            const DimensionedField<Type, volMesh>&,
            const dictionary&
        );

        //- Construct by mapping given temperatureOutletNSCBCFvPatchField
        //  onto a new patch
        temperatureOutletNSCBCFvPatchField
        (
            const temperatureOutletNSCBCFvPatchField<Type>&,
            const fvPatch&,
            const DimensionedField<Type, volMesh>&,
            const fvPatchFieldMapper&
        );

        //- Copy constructor
        temperatureOutletNSCBCFvPatchField
        (
            const temperatureOutletNSCBCFvPatchField&
        );

        //- Construct and return a clone
        virtual tmp<fvPatchField<Type>> clone() const
        {
            return tmp<fvPatchField<Type>>
            (
                new temperatureOutletNSCBCFvPatchField<Type>(*this)
            );
        }

        //- Copy constructor setting internal field reference
        temperatureOutletNSCBCFvPatchField
        (
            const temperatureOutletNSCBCFvPatchField&,
            const DimensionedField<Type, volMesh>&
        );

        //- Construct and return a clone setting internal field reference
        virtual tmp<fvPatchField<Type>> clone
        (
            const DimensionedField<Type, volMesh>& iF
        ) const
        {
            return tmp<fvPatchField<Type>>
            (
                new temperatureOutletNSCBCFvPatchField<Type>(*this, iF)
            );
        }


    // Member Functions

        // Access


            //- Return the velocity at infinity
	    const scalar& pInf() const
	    {
                return pInf_;
            }

            //- Return reference to the velocity at infinity to allow adjustment
	    scalar& pInf()
            {
                return pInf_;
            }

            //- Return the field at infinity
            const Type& fieldInf() const
            {
                return fieldInf_;
            }

            //- Return reference to the field at infinity to allow adjustment
            Type& fieldInf()
            {
                return fieldInf_;
            }



            //- Return the relaxation length-scale
            scalar lInf() const
            {
                return lInf_;
            }

            //- Return reference to the relaxation length-scale
            //  to allow adjustment
            scalar& lInf()
            {
                return lInf_;
            }

	    //- Return the heat capacity ratio
	    scalar gamma() const
	    {
                return gamma_;
            }
            
	    //- Return reference to the heat capacity ratio to allow adjustment
	    scalar& gamma()
	    {
                return gamma_;
            }

	    //- Return the etaAc NSCBC ratio
	    scalar etaAc() const
	    {
		return etaAc_;
            }

            //- Return reference to the etaAc NSCBC ratio
            scalar& etaAc()
	    {
		return etaAc_;
	    }

        // Evaluation functions

            //- Calculate and return the advection speed at the boundary
            virtual tmp<scalarField> advectionSpeed() const;

            //- Calculate soundSpeed
            virtual tmp<scalarField> soundSpeed() const;

            //- Update the coefficients associated with the patch field
            virtual void updateCoeffs();


        //- Write
        virtual void write(Ostream&) const;
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#ifdef NoRepository
    #include "temperatureOutletNSCBCFvPatchField.C"
#endif

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************************************************************* //
