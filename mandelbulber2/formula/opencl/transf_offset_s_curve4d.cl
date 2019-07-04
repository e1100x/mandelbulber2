/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * offset s curve
 * This formula contains aux.color

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfOffsetSCurve4dIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfOffsetSCurve4dIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 limit = native_divide(fractal->transformCommon.additionConstant0000, 2.0f);
	REAL4 oldZ = z;

	REAL4 temp = native_divide(fractal->transformCommon.additionConstant0000, -2.0f);
	REAL4 temp2 = temp * temp;
	REAL4 offS = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
	if (z.w < 1e-15f && z.w > -1e-15f) z.w = (z.w > 0) ? 1e-15f : -1e-15f;

	if (fractal->transformCommon.functionEnabledAx)
	{
		offS.x +=
			(native_divide((8.0f * temp.x * temp2.x), ((z.x * z.x) + (4.0f * temp2.x))) - 2.0f * temp.x)
			* sign(z.x) * fractal->transformCommon.scale1;
		z.x += offS.x;
	}

	if (fractal->transformCommon.functionEnabledAyFalse)
	{
		offS.y +=
			(native_divide((8.0f * temp.y * temp2.y), ((z.y * z.y) + (4.0f * temp2.y))) - 2.0f * temp.y)
			* sign(z.y) * fractal->transformCommon.scale1;
		z.y += offS.y;
	}

	if (fractal->transformCommon.functionEnabledAzFalse)
	{
		offS.z +=
			(native_divide((8.0f * temp.z * temp2.z), ((z.z * z.z) + (4.0f * temp2.z))) - 2.0f * temp.z)
			* sign(z.z) * fractal->transformCommon.scale1;
		z.z += offS.z;
	}

	if (fractal->transformCommon.functionEnabledAwFalse)
	{
		offS.w +=
			(native_divide((8.0f * temp.w * temp2.w), ((z.w * z.w) + (4.0f * temp2.w))) - 2.0f * temp.w)
			* sign(z.w) * fractal->transformCommon.scale1;
		z.w += offS.w;
	}

	if (fractal->foldColor.auxColorEnabledFalse)
	{
		if (!fractal->transformCommon.functionEnabledCxFalse)
		{
			if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor4D.x * (fabs(z.x) - limit.x);
			if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor4D.y * (fabs(z.y) - limit.y);
			if (z.z != oldZ.z) aux->color += fractal->mandelbox.color.factor4D.z * (fabs(z.z) - limit.z);
			if (z.w != oldZ.w) aux->color += fractal->mandelbox.color.factor4D.w * (fabs(z.w) - limit.w);
		}
		else
		{
			aux->color += fractal->mandelbox.color.factor4D.x * offS.x;
			aux->color += fractal->mandelbox.color.factor4D.y * offS.y;
			aux->color += fractal->mandelbox.color.factor4D.z * offS.z;
			aux->color += fractal->mandelbox.color.factor4D.w * offS.w;
		}
	}
	return z;
}