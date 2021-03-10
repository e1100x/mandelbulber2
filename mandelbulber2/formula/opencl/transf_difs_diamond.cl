/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * http://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_difs_hexprism.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfDIFSDiamondIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 normalTopA = (REAL4)(0.0, 0.81373347121, 0.5812382, 0.0);
	REAL4 normalTopB = (REAL4)(0.0, SQRT_1_2_F, SQRT_1_2_F, 0.0);
	REAL4 normalTopC = (REAL4)(0.0, 0.4472135955, 0.8944272, 0.0);
	REAL4 normalBottomA = (REAL4)(0.0, SQRT_1_2_F, -SQRT_1_2_F, 0.0);
	REAL4 normalBottomB = (REAL4) (0.0, 0.848, -0.53, 0.0);
	REAL4 zc = z;

	REAL topCut = zc.z - fractal->transformCommon.offset1;
	REAL angleStep = M_PI_F / (REAL)(fractal->transformCommon.int16);
	REAL angle = angleStep * (0.5 + floor (atan2 (zc.x, zc.y) / angleStep));
	REAL co = cos(angle);
	REAL si = sin(angle);
	REAL4 q = zc;
	q.x = (co * zc.x - si * zc.y);
	q.y = (co * zc.y + si * zc.x);
	REAL topA = dot (q, normalTopA) - fractal->transformCommon.offset2;
	REAL topC = dot (q, normalTopC) - fractal->transformCommon.offset105;
	REAL bottomA = dot (q, normalBottomA) - fractal->transformCommon.offsetA2 + 0.3f;
	angle = -angleStep * 0.5;
	co = cos(angle);
	si = sin(angle);
	q.x = (co * zc.x - si * zc.y);
	q.y = (co * zc.y + si * zc.x);
	angle = angleStep * floor (atan2 (q.x, q.y) / angleStep);
	co = cos(angle);
	si = sin(angle);
	q.x = (co * zc.x - si * zc.y);
	q.y = (co * zc.y + si * zc.x);
	REAL topB = dot (q, normalTopB) - fractal->transformCommon.offsetE2 + 0.15f;
	REAL bottomB = dot (q, normalBottomB) - fractal->transformCommon.offsetF2 + 0.1f;

	aux->DE0 = max (topCut, max (topA, max (topB, max (topC, max (bottomA, bottomB)))));

	if (!fractal->analyticDE.enabledFalse)
		aux->dist = aux->DE0;
	else
		aux->dist = min(aux->dist, aux->DE0 / aux->DE);

	if(fractal->transformCommon.functionEnabledzFalse) z = q;

	if (fractal->foldColor.auxColorEnabledFalse)
	{
		REAL4 col = fabs(q);
		aux->color += fractal->foldColor.difs0000.x * col.x * col.y;
		aux->color += fractal->foldColor.difs0000.y * col.x * col.z);
		aux->color += fractal->foldColor.difs0000.z * q.z;
		aux->color += fractal->foldColor.difs0000.w * max(col.x, col.y);
	}
	return z;
}
