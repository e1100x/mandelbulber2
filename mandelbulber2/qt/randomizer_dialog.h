/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2016-20 Mandelbulber Team     §R-==%w["'~5]m%=L.=~5N
 *                                        ,=mm=§M ]=4 yJKA"/-Nsaj  "Bw,==,,
 * This file is part of Mandelbulber.    §R.r= jw",M  Km .mM  FW ",§=ß., ,TN
 *                                     ,4R =%["w[N=7]J '"5=],""]]M,w,-; T=]M
 * Mandelbulber is free software:     §R.ß~-Q/M=,=5"v"]=Qf,'§"M= =,M.§ Rz]M"Kw
 * you can redistribute it and/or     §w "xDY.J ' -"m=====WeC=\ ""%""y=%"]"" §
 * modify it under the terms of the    "§M=M =D=4"N #"%==A%p M§ M6  R' #"=~.4M
 * GNU General Public License as        §W =, ][T"]C  §  § '§ e===~ U  !§[Z ]N
 * published by the                    4M",,Jm=,"=e~  §  §  j]]""N  BmM"py=ßM
 * Free Software Foundation,          ]§ T,M=& 'YmMMpM9MMM%=w=,,=MT]M m§;'§,
 * either version 3 of the License,    TWw [.j"5=~N[=§%=%W,T ]R,"=="Y[LFT ]N
 * or (at your option)                   TW=,-#"%=;[  =Q:["V""  ],,M.m == ]N
 * any later version.                      J§"mr"] ,=,," =="""J]= M"M"]==ß"
 *                                          §= "=C=4 §"eM "=B:m|4"]#F,§~
 * Mandelbulber is distributed in            "9w=,,]w em%wJ '"~" ,=,,ß"
 * the hope that it will be useful,                 . "K=  ,=RMMMßM"""
 * but WITHOUT ANY WARRANTY;                            .'''
 * without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * ###########################################################################
 *
 * Authors: Krzysztof Marczak (buddhi1980@gmail.com)
 *
 * Settings Randomizer
 */

#ifndef MANDELBULBER2_QT_RANDOMIZER_DIALOG_H_
#define MANDELBULBER2_QT_RANDOMIZER_DIALOG_H_

#include <QDialog>

#include "src/fractal_container.hpp"
#include "src/parameters.hpp"
#include "src/progress_text.hpp"
#include "src/random.hpp"
#include "src/tree_string_list.h"

namespace Ui
{
class cRandomizerDialog;
}

class cImage;
class cThumbnailWidget;

class cRandomizerDialog : public QDialog
{
	Q_OBJECT

public:
	explicit cRandomizerDialog(QWidget *parent = nullptr);
	~cRandomizerDialog();

	void AssignSourceWidget(const QWidget *sourceWidget);

private:
	enum enimRandomizeStrength
	{
		randomizeSlight,
		randomizeMedium,
		randomizeHeavy
	};

	enum enumRandomizerPreviewSize
	{
		previewSmall,
		previewMedium,
		previewBig
	};

	enum enumRandomizerPreviewQuality
	{
		previewQualityLow,
		previewQualityMedium,
		previewQualityHigh
	};

	struct sParameterVersion
	{
		cParameterContainer params;
		cFractalContainer fractParams;
		QStringList modifiedParameters;
	};

	const int numberOfVersions = 12;

	void Randomize(enimRandomizeStrength strength);
	void InitParameterContainers();
	void RefreshReferenceImage();
	void RefreshReferenceSkyImage();
	void CalcReferenceNoise();

	void CreateParametersTreeInWidget(
		cTreeStringList *tree, const QWidget *widget, int &level, int parentId);
	static cParameterContainer *ContainerSelector(
		QString fullParameterName, cParameterContainer *params, cFractalContainer *fractal);
	void RandomizeParameters(enimRandomizeStrength strength, cParameterContainer *params,
		cFractalContainer *fractal, int widgetIndex);
	void RandomizeOneParameter(QString fullParameterName, double randomScale,
		cParameterContainer *params, cFractalContainer *fractal, int widgetIndex);
	void RandomizeIntegerParameter(
		double randomScale, cOneParameter &parameter, const QString &parameterName);
	double RandomizeDoubleValue(double value, double randomScale, bool isAngle);
	void RandomizeDoubleParameter(double randomScale, bool isAngle, cOneParameter &parameter);
	void RandomizeVector3Parameter(double randomScale, bool isAngle, cOneParameter &parameter);
	void RandomizeVector4Parameter(double randomScale, bool isAngle, cOneParameter &parameter);
	int RandomizeColor16Component(double randomScale, int value);
	int RandomizeColor8Component(double randomScale, int value);
	void RandomizeRGBParameter(double randomScale, cOneParameter &parameter);
	void RandomizeBooleanParameter(cOneParameter &parameter);
	void RandomizeStringParameter(double randomScale, cOneParameter &parameter);
	void UpdateProgressBar(double progress);
	QString CreateTooltipText(const QMap<QString, QString> &list);

	// events
	void closeEvent(QCloseEvent *event) override;

private slots:
	void slotClickedSlightRandomize();
	void slotClickedMediumRandomize();
	void slotClickedHeavyRandomize();
	void slotClickedSelectButton();
	void slotClickedSaveButton();
	void slotClickedUseButton();
	void slotClickedResetButton();
	void slotPreviewRendered();
	void slotDetectedZeroDistance();
	void slotRenderTime(double time);
	void slotCleanUp();
	void slotAddToKeyframes();

private:
	Ui::cRandomizerDialog *ui;
	cTreeStringList parametersTree;
	QList<sParameterVersion> listOfVersions;
	QList<int> numbersOfRepeats;
	QList<bool> versionsDone;
	cParameterContainer actualParams;
	cFractalContainer actualFractParams;
	cRandom randomizer;
	enimRandomizeStrength actualStrength;
	cThumbnailWidget *referenceSkyPreview;
	cThumbnailWidget *referenceNoisePreview;
	cProgressText progressText;
	QList<QMap<QString, QString>> listsOfChangedParameters;
	QMap<QString, QString> actualListOfChangedParameters;		// updated after selection
	QMap<QString, QString> previousListOfChangedParameters; // updated after every randomize

	int previewWidth;
	int previewHeight;
	int qualityMultiplier;

	double referenceNoise;
	bool pressedUse;
	bool blockClose;
};

#endif /* MANDELBULBER2_QT_RANDOMIZER_DIALOG_H_ */
