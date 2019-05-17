/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Hybrid Color Trial2
 *
 *
 * bailout may need to be adjusted with some formulas

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfHybridColor2Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfHybridColor2Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	z.x += 0.000000001f; // so not detected as a  zero change in z
	REAL componentMaster = 0.0f;
	REAL orbitPoints = 0.0f;

	REAL totalDist = 0.0f;
	REAL totalR = 0.0f;
	REAL lastVec = 0.0f;
	// REAL auxColor = 0.0f;

	// REAL distEst = 0.0f;
	// REAL planeBias = 0.0f;
	// REAL factorR = fractal->mandelbox.color.factorR;

	// REAL lengthIter = 0.0f;
	// REAL boxTrap = 0.0f;
	// REAL sphereTrap = 0.0f;
	// float lastDist = 0.0f;
	// float addI = 0.0f;

	// summation of r
	if (fractal->transformCommon.functionEnabledMFalse)
	{
		REAL total = aux->addDist;
		REAL newR = length(z); // aux->r?
		totalR = (total + newR) * fractal->transformCommon.scaleD1;
		aux->addDist = totalR;
	}

	// max distance travelled
	if (fractal->transformCommon.functionEnabledSFalse)
	{
		REAL4 oldPt = aux->old_z;
		REAL4 newPt = z;
		REAL4 diffZ = oldPt - newPt;
		REAL dist = length(diffZ);
		aux->addDist += dist;
		totalDist = aux->addDist * fractal->foldColor.scaleC1;
		aux->old_z = z;
	}

	// last two  z lengths
	if (fractal->transformCommon.functionEnabledPFalse)
	{
		if (aux->i < fractal->transformCommon.stopIterationsM)
		{
			REAL lastZ = aux->addDist;
			REAL newZ = length(z);

			if (fractal->transformCommon.functionEnabledAzFalse) lastVec = native_divide(newZ, lastZ);
			if (fractal->transformCommon.functionEnabledByFalse) lastVec = native_divide(lastZ, newZ);
			if (fractal->transformCommon.functionEnabledBzFalse) lastVec = fabs(lastZ - newZ);

			lastVec *= fractal->transformCommon.scaleB1;
			aux->addDist = newZ;
		}
	}

	// orbitTrap points
	if (fractal->transformCommon.functionEnabledBxFalse)
	{
		REAL4 PtOne = z - fractal->transformCommon.offset000;
		REAL4 PtTwo = z - fractal->transformCommon.offsetA000;
		REAL distOne = length(PtOne); // * weight
		REAL distTwo = length(PtTwo);
		orbitPoints = min(distOne, distTwo);
		if (fractal->transformCommon.functionEnabledAxFalse)
		{
			REAL4 PtThree = z - fractal->transformCommon.offsetF000;
			REAL distThree = length(PtThree);
			orbitPoints = min(orbitPoints, distThree);
		}
		if (fractal->transformCommon.functionEnabledAyFalse)
		{
			REAL4 PtFour = z - fractal->transformCommon.additionConstantA000;
			REAL distFour = length(PtFour);
			orbitPoints = min(orbitPoints, distFour);
		}

		orbitPoints *= fractal->transformCommon.scaleA1;
	}

	if (aux->i >= fractal->transformCommon.startIterationsT
			&& aux->i < fractal->transformCommon.stopIterationsT)
	{
		// build  componentMaster

		componentMaster = (totalDist + orbitPoints + lastVec + totalR);
	}
	componentMaster *= fractal->transformCommon.scale;

	if (!fractal->transformCommon.functionEnabledFalse)

	{
		aux->temp100 = min(aux->temp100, componentMaster);
		aux->colorHybrid = aux->temp100;
	}
	else
		aux->colorHybrid = componentMaster;
	return z;
}