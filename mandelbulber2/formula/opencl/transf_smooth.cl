/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * abs add  constant,  z = fabs( z + pre-offset) + post-offset

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_abs_add_constant.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfSmoothIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(aux);

	REAL OffsetS = fractal->transformCommon.offset0005;

	// the closer to origin the greater the effect of OffsetSQ
	z = (REAL4){native_sqrt(z.x * z.x + OffsetS), native_sqrt(z.y * z.y + OffsetS),
		native_sqrt(z.z * z.z + OffsetS), z.w};

	if (fractal->transformCommon.functionEnabledzFalse) z *= Zigns;

	REAL t;
	if (fractal->transformCommon.functionEnabledx)
	{
		t = z.x - z.y;
		t = 0.5f * (t - native_sqrt(t * t + OffsetS));
		z.x = z.x - t;
		z.y = z.y + t;
	}
	if (fractal->transformCommon.functionEnabledy)
	{
		t = z.x - z.z;
		t = 0.5f * (t - native_sqrt(t * t + OffsetS));
		z.x = z.x - t;
		z.z = z.z + t;
	}
	if (fractal->transformCommon.functionEnabledz)
	{
		t = z.y - z.z;
		t = 0.5f * (t - native_sqrt(t * t + OffsetS));
		z.y = z.y - t;
		z.z = z.z + t;
	}

	z += fractal->transformCommon.offsetA000;

	return z;
}
