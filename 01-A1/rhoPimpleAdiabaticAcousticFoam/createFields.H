Info<< "Reading thermophysical properties\n" << endl;

autoPtr<fluidThermo> pThermo
(
    fluidThermo::New(mesh)
);
fluidThermo& thermo = pThermo();
thermo.validate(args.executable(), "h", "e");

volScalarField& p = thermo.p();
volScalarField& T = thermo.T();

volScalarField rho
(
    IOobject
    (
        "rho",
        runTime.timeName(),
        mesh,
        IOobject::READ_IF_PRESENT,
        IOobject::AUTO_WRITE
    ),
    thermo.rho()
);

Info<< "Reading field U\n" << endl;
volVectorField U
(
    IOobject
    (
        "U",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

Info<< "Calculating face flux field phi\n" << endl;

surfaceScalarField phi
(
    IOobject
    (
        "phi",
        runTime.timeName(),
        mesh,
        IOobject::READ_IF_PRESENT,
        IOobject::AUTO_WRITE
    ),
    linearInterpolate(rho)*linearInterpolate(U) & mesh.Sf()
);

Info<< "Calculating face flux field phiByRho\n" << endl;

surfaceScalarField phiByRho
(
    IOobject
    (
        "phiByRho",
        runTime.timeName(),
        mesh,
        IOobject::READ_IF_PRESENT,
        IOobject::AUTO_WRITE
    ),
    phi/linearInterpolate(rho)
);

Info<< "Creating turbulence model\n" << endl;
autoPtr<compressible::turbulenceModel> turbulence
(
    compressible::turbulenceModel::New
    (
        rho,
        U,
        phi,
        thermo
    )
);

mesh.setFluxRequired(p.name());

Info<< "Creating field dpdt\n" << endl;
volScalarField dpdt
(
    IOobject
    (
        "dpdt",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar(p.dimensions()/dimTime, Zero)
);

Info<< "Creating field pMean\n" << endl;
volScalarField pMean
(
    IOobject
    (
        "pMean",
        runTime.timeName(),
        mesh,
        IOobject::READ_IF_PRESENT,
        IOobject::AUTO_WRITE
    ),
    mesh,
    dimensionedScalar(p.dimensions())
);
Info<< "Creating field pFluc\n" << endl;
volScalarField pFluc
(
    IOobject
    (
        "pFluc",
        runTime.timeName(),
        mesh,
        IOobject::READ_IF_PRESENT,
        IOobject::AUTO_WRITE
    ),
    mesh,
    dimensionedScalar(p.dimensions())
);

Info<< "Creating field pAcoustic\n" << endl;
volScalarField pAcoustic
(
    IOobject
    (
        "pAcoustic",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

Info<< "Creating field cInf\n" << endl;
volScalarField cInf
(
    IOobject
    (
        "cInf",
        runTime.timeName(),
        mesh
    ),
    mesh,
    dimensionedScalar(U.dimensions())
);
cInf = sqrt(thermo.Cp()/thermo.Cv()*(thermo.Cp()-thermo.Cv())*T);
scalar timeIndex = 1;

IOdictionary acousticSettings
(
    IOobject
    (
        "acousticSettings",
        runTime.constant(),
        mesh,
        IOobject::MUST_READ_IF_MODIFIED,
        IOobject::NO_WRITE
    )
);

dimensionedScalar tAc
(
    "tAc",
    dimTime,
    acousticSettings.lookup("tAc")
);

dimensionedScalar nPass
(
    "nPass",
    dimless,
    acousticSettings.lookup("nPass")
);


#include "createMRF.H"

Info<< "Creating compressibility field psi\n" << endl;
volScalarField psi("psi", 1.0/((thermo.Cp() - thermo.Cv())*T));
psi.oldTime() = 1.0/((thermo.Cp() - thermo.Cv())*T.oldTime());
psi.oldTime().oldTime() = 1.0/((thermo.Cp()-thermo.Cv())*T.oldTime().oldTime());
