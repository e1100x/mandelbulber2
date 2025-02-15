/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * rotation

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_rotation_m3d.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfRotationM3dIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(aux);

	REAL temp = 0.0f;
	if (fractal->transformCommon.angleDegC != 0.0f)
	{
		temp = z.x;
		z.x = z.x * fractal->transformCommon.cosC - z.y * fractal->transformCommon.sinC;
		z.y = temp * fractal->transformCommon.sinC + z.y * fractal->transformCommon.cosC;
	}

	if (fractal->transformCommon.angleDegB != 0.0f)
	{
		temp = z.z;
		z.z = z.z * fractal->transformCommon.cosB - z.x * fractal->transformCommon.sinB;
		z.x = temp * fractal->transformCommon.sinB + z.x * fractal->transformCommon.cosB;
	}

	if (fractal->transformCommon.angleDegA != 0.0f)
	{
		temp = z.y;
		z.y = z.y * fractal->transformCommon.cosA - z.z * fractal->transformCommon.sinA;
		z.z = temp * fractal->transformCommon.sinA + z.z * fractal->transformCommon.cosA;
	}
	return z;
}