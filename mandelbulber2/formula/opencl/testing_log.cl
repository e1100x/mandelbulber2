/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * trafassel
 *
 https://fractalforums.org/fractal-mathematics-and-new-theories/28/fake-3d-mandelbrot-set/1787/msg17956#msg17956

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_testing_log.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TestingLogIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->DE = aux->DE * aux->r * 2.0f;

	// Preparation operations
	REAL fac_eff = 0.6666666666f;
	REAL offset = 0.0f; //1.0e-10;
	REAL4 c = (REAL4)(0.0f, 0.0f, 0.0f, 0.0f);



		if (fractal->transformCommon.juliaMode)
		{
			c = fractal->transformCommon.constantMultiplier100;
		}
		else
		{
			c = z;
		}

	// Converting the diverging (x,y,z) back to the variable
	// that can be used for the (converging) Newton method calculation
	REAL sq_r = fractal->transformCommon.scale / (aux->r * aux->r + offset);
	REAL x1 = z.x * sq_r + fractal->transformCommon.vec111.x;
	REAL y1 = -z.y * sq_r + fractal->transformCommon.vec111.y;
	REAL z1 = -z.z * sq_r + fractal->transformCommon.vec111.z;

	REAL x2 = x1 * x1;
	REAL y2 = y1 * y1;
	REAL z2 = z1 * z1;

	// Calculate the inverse power of t=(x,y,z),
	// and use it for the Newton method calculations for t^power + c = 0
	// i.e. t(n+1) = 2*t(n)/3 - c/2*t(n)^2

	sq_r = x2 + y2 + z2;
	sq_r = 1.0f / (3.0f * sq_r * sq_r + offset);
	REAL r_xy = x2 + y2;
	REAL h1 = 1.0f - z2 / r_xy;

	REAL tmpx = h1 * (x2 - y2) * sq_r;
	REAL tmpy = -2.0f * h1 * x1 * y1 * sq_r;
	REAL tmpz = 2.0f * z1 * native_sqrt(r_xy) * sq_r;

	REAL r_2xy = native_sqrt(tmpx * tmpx + tmpy * tmpy);
	REAL r_2cxy = native_sqrt(c.x * c.x + c.y * c.y);
	REAL h2 = 1.0f - c.z * tmpz / (r_2xy * r_2cxy);

	REAL tmp2x = (c.x * tmpx - c.y * tmpy) * h2;
	REAL tmp2y = (c.y * tmpx + c.x * tmpy) * h2;
	REAL tmp2z = r_2cxy * tmpz + r_2xy * c.z;

	x1 = fac_eff * x1 - tmp2x;
	y1 = fac_eff * y1 - tmp2y;
	z1 = fac_eff * z1 - tmp2z;

	// Below the hack that provides a divergent value of (x,y,z) to Mandelbulber
	// although the plain Newton method does always converge

	REAL diffx = (x1 - fractal->transformCommon.vec111.x);
	REAL diffy = (y1 - fractal->transformCommon.vec111.y);
	REAL diffz = (z1 - fractal->transformCommon.vec111.z);

	sq_r = fractal->transformCommon.scale1 / (diffx * diffx + diffy * diffy + diffz * diffz + offset);
	z.x = diffx * sq_r;
	z.y = -diffy * sq_r;
	z.z = -diffz * sq_r;

	REAL dd = length(z) / aux->r;
	dd = dd + (aux->r * 2.0f - dd) * fractal->transformCommon.scaleA1;
	aux->DE *= dd;

	if (fractal->analyticDE.enabled)
	{
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset1;
	}

	return z;
}
