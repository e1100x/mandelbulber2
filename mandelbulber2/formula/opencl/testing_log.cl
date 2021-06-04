/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Quaternion4D

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_quaternion4d.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TestingLogIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->DE *= 2.0f * aux->r;

	if (fractal->transformCommon.functionEnabledFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
		if (fractal->transformCommon.functionEnabledAwFalse) z.w = fabs(z.w);
	}

	REAL4 dd = fractal->transformCommon.constantMultiplier1220;
	dd.w = fractal->transformCommon.scale2;

	if (!fractal->transformCommon.functionEnabledAFalse)
	{
		dd.x = z.x * z.x * dd.x - z.y * z.y - z.z * z.z - z.w * z.w;
		dd.y = 2.0 * z.x * z.y - dd.y * z.w * z.z;
		dd.z = 2.0 * z.x * z.z - dd.z * z.y * z.w;
		dd.w = 2.0 * z.x * z.w - dd.w * z.z * z.y;
		z = dd;
	}
	else // old
	{
		z = (REAL4){z.x * z.x - z.y * z.y - z.z * z.z - z.w * z.w,
		z.x * z.y - z.z * z.w,
		z.x * z.z + z.y * z.w,
		z.x * z.w - z.y * z.z};
		z *= dd;
	}


	// offset (Julia)
	z += fractal->transformCommon.additionConstant0000;

	 // DE tweak
	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

	// 6 plane rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		REAL4 tp;
		if (fractal->transformCommon.rotation44a.x != 0)
		{
			tp = z;
			REAL alpha = fractal->transformCommon.rotation44a.x * M_PI_180_F;
			z.x = tp.x * native_cos(alpha) + tp.y * native_sin(alpha);
			z.y = tp.x * -native_sin(alpha) + tp.y * native_cos(alpha);
		}
		if (fractal->transformCommon.rotation44a.y != 0)
		{
			tp = z;
			REAL beta = fractal->transformCommon.rotation44a.y * M_PI_180_F;
			z.y = tp.y * native_cos(beta) + tp.z * native_sin(beta);
			z.z = tp.y * -native_sin(beta) + tp.z * native_cos(beta);
		}
		if (fractal->transformCommon.rotation44a.z != 0)
		{
			tp = z;
			REAL gamma = fractal->transformCommon.rotation44a.z * M_PI_180_F;
			z.x = tp.x * native_cos(gamma) + tp.z * native_sin(gamma);
			z.z = tp.x * -native_sin(gamma) + tp.z * native_cos(gamma);
		}
		if (fractal->transformCommon.rotation44b.x != 0)
		{
			tp = z;
			REAL delta = fractal->transformCommon.rotation44b.x * M_PI_180_F;
			z.x = tp.x * native_cos(delta) + tp.w * native_sin(delta);
			z.w = tp.x * -native_sin(delta) + tp.w * native_cos(delta);
		}
		if (fractal->transformCommon.rotation44b.y != 0)
		{
			tp = z;
			REAL epsilon = fractal->transformCommon.rotation44b.y * M_PI_180_F;
			z.y = tp.y * native_cos(epsilon) + tp.w * native_sin(epsilon);
			z.w = tp.y * -native_sin(epsilon) + tp.w * native_cos(epsilon);
		}
		if (fractal->transformCommon.rotation44b.z != 0)
		{
			tp = z;
			REAL zeta = fractal->transformCommon.rotation44b.z * M_PI_180_F;
			z.z = tp.z * native_cos(zeta) + tp.w * native_sin(zeta);
			z.w = tp.z * -native_sin(zeta) + tp.w * native_cos(zeta);
		}
	}
	return z;
}
