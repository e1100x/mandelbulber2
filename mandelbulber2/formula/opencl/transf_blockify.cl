/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Blockify
 * based on a block of Fragmentarium code, from Adam Nixon
 * analytic aux.DE

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_blockify.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfBlockifyIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{

	REAL master = fractal->transformCommon.scale / 100.0f;
	REAL4 bSize = fractal->transformCommon.constantMultiplier111 * master;
	// bsize maybe shortened to a REAL??

	if (!fractal->transformCommon.functionEnabledFalse)
	{
		if (!fractal->transformCommon.functionEnabledDFalse)
		{
			if (fractal->transformCommon.functionEnabledCx) z.x = (floor(z.x / bSize.x) + 0.5f) * bSize.x;
			if (fractal->transformCommon.functionEnabledCy) z.y = (floor(z.y / bSize.y) + 0.5f) * bSize.y;
			if (fractal->transformCommon.functionEnabledCz) z.z = (floor(z.z / bSize.z) + 0.5f) * bSize.z;
		}
		else // normalize
		{
			REAL rr = length(z); //dot(z, z);
			z /= rr;
			if (fractal->transformCommon.functionEnabledCx) z.x = (floor(z.x / bSize.x) + 0.5f) * bSize.x;
			if (fractal->transformCommon.functionEnabledCy) z.y = (floor(z.y / bSize.y) + 0.5f) * bSize.y;
			if (fractal->transformCommon.functionEnabledCz) z.z = (floor(z.z / bSize.z) + 0.5f) * bSize.z;
			z *= rr;
		}
	}
	else // radial
	{
		REAL rr = dot(z, z);
		if (fractal->transformCommon.functionEnabledRFalse) rr = native_sqrt(rr); // length(z);
		if (fractal->transformCommon.functionEnabledBxFalse) rr = z.x * z.x + z.y * z.y;
		if (fractal->transformCommon.functionEnabledByFalse) rr = z.y * z.y + z.z * z.z;
		if (fractal->transformCommon.functionEnabledBzFalse) rr = z.z * z.z + z.x * z.x;
		z /= rr;
		rr = floor(rr / master) * master;
		z *= rr;
	}


	// post scale
	z *= fractal->transformCommon.scale1;
	aux->DE = aux->DE * fractal->transformCommon.scale1 * fractal->analyticDE.scale1
							+ fractal->analyticDE.offset0;

	return z;
}
