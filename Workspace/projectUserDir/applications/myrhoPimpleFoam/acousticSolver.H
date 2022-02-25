//acoustic solver
if(runTime.time()>tAc)
{
	if(timeIndex == 1)
	{	
		pMean = p;
		pMean.storeOldTime();
		timeIndex++;
	}
	else
	{
		Info<< "Calculating fields pMean and pFluc\n" << endl;
		pMean = (pMean.oldTime()*(runTime.time()-runTime.deltaT())+p*runTime.deltaT())/(runTime.time());
		pMean.storeOldTime();
		if(runTime.time()>(tAc*nPass))
		{
			pFluc = p - pMean;
		//Info<< "Solving the wave equation for pAcoustic\n" << endl;
		//fvScalarMatrix pAcousticEqn
		//(
		//  fvm::d2dt2(pAcoustic) - sqr(cInf)*fvm::laplacian(pAcoustic) + fvc::d2dt2(pFluc)
		// );
  
		//solve(pAcousticEqn);
		}
	}
}
