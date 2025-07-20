// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeBlockEditor.pas' rev: 34.00 (Windows)

#ifndef TeeblockeditorHPP
#define TeeblockeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.TypInfo.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <VCLTee.TeeFilters.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <TeeBlocks.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <TeeMakerControl.hpp>
#include <TeeRoundRect.hpp>
#include <TeeBlockFormat.hpp>
#include <TeePointEditor.hpp>
#include <TeeSelectProperty.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeblockeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBlockEditor;
class DELPHICLASS TMakerPropertySelector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBlockEditor : public Vcltee::Tecanvas::TVisualEditor
{
	typedef Vcltee::Tecanvas::TVisualEditor inherited;
	
__published:
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabGeneral;
	Vcl::Comctrls::TPageControl* PageCurrent;
	Vcl::Comctrls::TTabSheet* TabFormat;
	Vcl::Comctrls::TTabSheet* TabRotation;
	Vcl::Stdctrls::TLabel* LRotation;
	Vcl::Stdctrls::TLabel* LElevation;
	Vcl::Stdctrls::TLabel* LTilt;
	Vcl::Stdctrls::TScrollBar* BlockRotation;
	Vcl::Stdctrls::TScrollBar* BlockElevation;
	Vcl::Stdctrls::TScrollBar* BlockTilt;
	Vcl::Comctrls::TTabSheet* TabPosition;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label16;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Stdctrls::TEdit* EditX;
	Vcl::Comctrls::TUpDown* BlockX;
	Vcl::Stdctrls::TEdit* EditY;
	Vcl::Comctrls::TUpDown* BlockY;
	Vcl::Stdctrls::TEdit* EditZ;
	Vcl::Comctrls::TUpDown* BlockZ;
	Vcl::Stdctrls::TEdit* EditWidth;
	Vcl::Comctrls::TUpDown* BlockWidth;
	Vcl::Stdctrls::TEdit* EditHeight;
	Vcl::Comctrls::TUpDown* BlockHeight;
	Vcl::Stdctrls::TEdit* EditDepth;
	Vcl::Comctrls::TUpDown* BlockDepth;
	Vcl::Stdctrls::TCheckBox* CBSpinBy;
	Vcl::Stdctrls::TEdit* ESpinBy;
	Vcl::Comctrls::TUpDown* UDSpinBy;
	Vcl::Comctrls::TTabSheet* TabTile;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TScrollBar* BlockTileX;
	Vcl::Stdctrls::TScrollBar* BlockTileY;
	Vcl::Stdctrls::TScrollBar* BlockTileZ;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TLabel* Label19;
	Vcl::Stdctrls::TScrollBar* BlockTileOffX;
	Vcl::Stdctrls::TScrollBar* BlockTileOffY;
	Vcl::Stdctrls::TScrollBar* BlockTileOffZ;
	Vcl::Comctrls::TTabSheet* TabEllipsoid;
	Vcl::Stdctrls::TLabel* Label22;
	Vcl::Stdctrls::TLabel* Label23;
	Vcl::Stdctrls::TLabel* Label24;
	Vcl::Stdctrls::TEdit* ElipSides;
	Vcl::Comctrls::TUpDown* BlockElipSides;
	Vcl::Stdctrls::TEdit* ElipStacks;
	Vcl::Comctrls::TUpDown* BlockElipStacks;
	Vcl::Stdctrls::TScrollBar* BlockElipTotal;
	Vcl::Comctrls::TTabSheet* TabGradient;
	Vcl::Comctrls::TTabSheet* TabCylinder;
	Vcl::Stdctrls::TGroupBox* GroupBox3;
	Vcl::Stdctrls::TButton* BlockElipCover;
	Vcl::Stdctrls::TCheckBox* BlockElipCoverDef;
	Vcl::Stdctrls::TCheckBox* BlockElipCoverVisible;
	Vcl::Comctrls::TTabSheet* TabText;
	Vcl::Comctrls::TTabSheet* TabBevel;
	Vcl::Stdctrls::TLabel* Label29;
	Vcl::Stdctrls::TScrollBar* BlockBevelX;
	Vcl::Stdctrls::TLabel* LabelBevelX;
	Vcl::Stdctrls::TLabel* Label32;
	Vcl::Stdctrls::TScrollBar* BlockElipTotalAngle;
	Vcl::Comctrls::TTabSheet* TabSphere;
	Vcl::Comctrls::TTabSheet* TabLight;
	Vcl::Comctrls::TTabSheet* TabRoundRect;
	Vcl::Comctrls::TTabSheet* TabObject;
	Vcl::Comctrls::TTabSheet* TabPyramid;
	Vcl::Comctrls::TTabSheet* TabBridge;
	Vcl::Stdctrls::TLabel* Label44;
	Vcl::Stdctrls::TLabel* Label45;
	Vcl::Stdctrls::TScrollBar* BlockBridgeSize;
	Vcl::Stdctrls::TScrollBar* BlockBridgeHeight;
	Vcl::Comctrls::TTabSheet* TabPie;
	Vcl::Comctrls::TTabSheet* TabHole;
	Vcl::Comctrls::TTabSheet* TabScale;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* LScaleX;
	Vcl::Stdctrls::TLabel* LScaleY;
	Vcl::Stdctrls::TLabel* LScaleZ;
	Vcl::Stdctrls::TScrollBar* BlockScaleX;
	Vcl::Stdctrls::TScrollBar* BlockScaleY;
	Vcl::Stdctrls::TScrollBar* BlockScaleZ;
	Vcl::Stdctrls::TGroupBox* GroupBox4;
	Vcl::Stdctrls::TLabel* LCenterX;
	Vcl::Stdctrls::TLabel* LCenterY;
	Vcl::Stdctrls::TLabel* LCenterZ;
	Vcl::Stdctrls::TScrollBar* BlockCenterX;
	Vcl::Stdctrls::TScrollBar* BlockCenterY;
	Vcl::Stdctrls::TScrollBar* BlockCenterZ;
	Vcl::Stdctrls::TLabel* Label54;
	Vcl::Stdctrls::TLabel* Label55;
	Vcl::Stdctrls::TLabel* Label56;
	Vcl::Comctrls::TPageControl* PageControl4;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Comctrls::TTabSheet* TabSheet5;
	Vcl::Stdctrls::TLabel* Label37;
	Vcl::Stdctrls::TEdit* ESpot;
	Vcl::Comctrls::TUpDown* BlockLightSpot;
	Vcl::Stdctrls::TCheckBox* CBDefaultSpot;
	Vcl::Stdctrls::TLabel* Label38;
	Vcl::Comctrls::TTrackBar* BlockLightSpotExp;
	Vcl::Comctrls::TTrackBar* BlockLightInt;
	Vcltee::Tecanvas::TButtonColor* BlockLightColor;
	Vcl::Stdctrls::TCheckBox* BlockLightFixed;
	Vcl::Stdctrls::TCheckBox* BlockLightLamp;
	Vcl::Stdctrls::TCheckBox* BlockLightUseDir;
	Vcl::Stdctrls::TLabel* Label51;
	Vcl::Comctrls::TTrackBar* BlockLightDiffuse;
	Vcl::Comctrls::TTrackBar* BlockLightSpecular;
	Vcl::Stdctrls::TLabel* Label52;
	Vcl::Extctrls::TPanel* PanelButtons;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Comctrls::TTabSheet* TabArrow;
	Vcl::Stdctrls::TLabel* Label53;
	Vcl::Stdctrls::TScrollBar* BlockArrowWidth;
	Vcl::Comctrls::TTabSheet* TabPipe;
	Vcl::Stdctrls::TLabel* Label57;
	Vcl::Stdctrls::TScrollBar* BlockPipeXRadius;
	Vcl::Stdctrls::TGroupBox* GroupBox7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label42;
	Vcl::Stdctrls::TScrollBar* BlockWedgeX1;
	Vcl::Stdctrls::TScrollBar* BlockWedgeY1;
	Vcl::Stdctrls::TGroupBox* GroupBox8;
	Vcl::Stdctrls::TLabel* Label65;
	Vcl::Stdctrls::TLabel* Label66;
	Vcl::Stdctrls::TScrollBar* BlockWedgeX2;
	Vcl::Stdctrls::TScrollBar* BlockWedgeY2;
	Vcl::Stdctrls::TLabel* PipeXRadius;
	Vcl::Stdctrls::TCheckBox* BlockBridgeRounded;
	Vcl::Stdctrls::TScrollBar* BlockArrowHeight;
	Vcl::Stdctrls::TLabel* Label70;
	Vcl::Comctrls::TTabSheet* TabCross;
	Vcl::Stdctrls::TLabel* Label72;
	Vcl::Stdctrls::TLabel* Label73;
	Vcl::Stdctrls::TScrollBar* BlockCrossWidth;
	Vcl::Stdctrls::TScrollBar* BlockCrossHeight;
	Vcl::Stdctrls::TGroupBox* GroupBox9;
	Vcl::Stdctrls::TLabel* Label74;
	Vcl::Stdctrls::TLabel* Label75;
	Vcl::Stdctrls::TScrollBar* BlockCrossCenterX;
	Vcl::Stdctrls::TScrollBar* BlockCrossCenterY;
	Vcl::Comctrls::TTabSheet* TabCone;
	Vcl::Stdctrls::TLabel* LabelCone;
	Vcl::Stdctrls::TScrollBar* BlockConeX;
	Vcl::Stdctrls::TLabel* Label76;
	Vcl::Stdctrls::TLabel* Label77;
	Vcl::Stdctrls::TScrollBar* BlockConeY;
	Vcl::Stdctrls::TLabel* LabelConeX;
	Vcl::Stdctrls::TLabel* LabelConeY;
	Vcl::Comctrls::TPageControl* PageControl5;
	Vcl::Comctrls::TTabSheet* TabHoleSize;
	Vcl::Comctrls::TTabSheet* TabHoleCorners;
	Vcl::Stdctrls::TLabel* Label49;
	Vcl::Stdctrls::TLabel* Label50;
	Vcl::Stdctrls::TScrollBar* BlockHoleX;
	Vcl::Stdctrls::TScrollBar* BlockHoleY;
	Vcltee::Tecanvas::TComboFlat* BlockHoleStyle;
	Vcl::Comctrls::TTabSheet* TabPath;
	Vcl::Stdctrls::TLabel* Label67;
	Vcl::Stdctrls::TScrollBar* BlockArrowIndent;
	Vcl::Stdctrls::TLabel* Label80;
	Vcl::Stdctrls::TScrollBar* BlockSphereRadius;
	Vcl::Comctrls::TTabSheet* TabExtruded;
	Vcl::Comctrls::TTabSheet* TabBlock;
	Vcl::Stdctrls::TCheckBox* BlockVisible;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* BlockTitle;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TButton* BlockExtrudedFront;
	Vcl::Stdctrls::TButton* BlockExtrudedBack;
	Vcl::Stdctrls::TCheckBox* CBBlockExtFront;
	Vcl::Stdctrls::TCheckBox* CBBlockExtBack;
	Vcl::Comctrls::TTabSheet* TabRectangle;
	Vcl::Comctrls::TTabSheet* TabCube;
	Vcl::Extctrls::TPanel* BlockCubeSidePanel;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TListBox* BlockCubeSide;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TCheckBox* BlockCubeSideDefault;
	Vcl::Comctrls::TPageControl* PageControl6;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet6;
	Vcl::Stdctrls::TLabel* Label46;
	Vcl::Stdctrls::TLabel* Label47;
	Vcl::Stdctrls::TLabel* Label48;
	Vcl::Stdctrls::TScrollBar* BlockPieDonut;
	Vcl::Stdctrls::TScrollBar* BlockPieStart;
	Vcl::Stdctrls::TScrollBar* BlockPieAngle;
	Vcl::Comctrls::TPageControl* PageControl3;
	Vcl::Comctrls::TTabSheet* TabPieOuterTop;
	Vcl::Stdctrls::TLabel* Label31;
	Vcl::Comctrls::TPageControl* PageControl7;
	Vcl::Comctrls::TTabSheet* TabFont;
	Vcl::Comctrls::TTabSheet* TabTextLines;
	Vcl::Stdctrls::TMemo* BlockTextLines;
	Vcl::Comctrls::TTabSheet* TabPieOuterBottom;
	Vcl::Comctrls::TTabSheet* TabPieInnerTop;
	Vcl::Comctrls::TTabSheet* TabPieInnerBottom;
	Vcl::Comctrls::TTabSheet* TabSides;
	Vcl::Stdctrls::TButton* BlockSide1;
	Vcl::Stdctrls::TButton* BlockSide2;
	Vcl::Stdctrls::TCheckBox* BlockSide1Def;
	Vcl::Stdctrls::TCheckBox* BlockSide2Def;
	Vcl::Stdctrls::TCheckBox* BlockSide1Visible;
	Vcl::Stdctrls::TCheckBox* BlockSide2Visible;
	Vcl::Comctrls::TTabSheet* TabHoleFormat;
	Vcl::Comctrls::TTabSheet* TabEllipse;
	Vcl::Stdctrls::TLabel* Label18;
	Vcl::Stdctrls::TScrollBar* BlockEllipseSlices;
	Vcl::Stdctrls::TLabel* LBlockEllipse;
	Vcl::Comctrls::TTabSheet* TabTube;
	Vcl::Stdctrls::TLabel* Label28;
	Vcl::Stdctrls::TEdit* BlockBridgeRound;
	Vcl::Comctrls::TUpDown* UDBlockBridgeRound;
	Vcl::Stdctrls::TLabel* LTileX;
	Vcl::Stdctrls::TLabel* LTileY;
	Vcl::Stdctrls::TLabel* LTileZ;
	Vcl::Stdctrls::TLabel* LPyramid1X;
	Vcl::Stdctrls::TLabel* LPyramid1Y;
	Vcl::Stdctrls::TLabel* LPyramid2X;
	Vcl::Stdctrls::TLabel* LPyramid2Y;
	Vcl::Stdctrls::TLabel* LPieDonut;
	Vcl::Stdctrls::TLabel* LPieStart;
	Vcl::Stdctrls::TLabel* LPieAngle;
	Vcl::Comctrls::TTabSheet* TabRectPyramid;
	Vcl::Stdctrls::TLabel* Label84;
	Vcl::Stdctrls::TScrollBar* BlockRectLeft;
	Vcl::Stdctrls::TLabel* LRectLeft;
	Vcl::Stdctrls::TLabel* Label85;
	Vcl::Stdctrls::TScrollBar* BlockRectRight;
	Vcl::Stdctrls::TLabel* LRectRight;
	Vcl::Stdctrls::TScrollBar* BlockScaleXYZ;
	Vcl::Stdctrls::TLabel* Label90;
	Vcl::Stdctrls::TLabel* LSphereRadius;
	Vcl::Stdctrls::TLabel* Label91;
	Vcl::Stdctrls::TLabel* PipeYRadius;
	Vcl::Stdctrls::TScrollBar* BlockPipeYRadius;
	Vcl::Stdctrls::TLabel* Label92;
	Vcltee::Tecanvas::TComboFlat* BlockPipeConnector;
	Vcl::Comctrls::TTabSheet* TabStar;
	Vcl::Stdctrls::TLabel* Label93;
	Vcl::Stdctrls::TScrollBar* BlockStarInner;
	Vcl::Stdctrls::TLabel* Label94;
	Vcl::Stdctrls::TScrollBar* BlockStarSlant;
	Vcl::Stdctrls::TLabel* LStarInner;
	Vcl::Stdctrls::TLabel* LStarSlant;
	Vcl::Comctrls::TPageControl* PageControl8;
	Vcl::Comctrls::TTabSheet* TabRectCorners;
	Vcl::Comctrls::TTabSheet* TabRectSides;
	Vcltee::Tecanvas::TButtonColor* BlockRectLT;
	Vcltee::Tecanvas::TButtonColor* BlockRectLB;
	Vcltee::Tecanvas::TButtonColor* BlockRectRT;
	Vcltee::Tecanvas::TButtonColor* BlockRectRB;
	Vcl::Stdctrls::TCheckBox* BlockRectDefLT;
	Vcl::Stdctrls::TCheckBox* BlockRectDefLB;
	Vcl::Stdctrls::TCheckBox* BlockRectDefRT;
	Vcl::Stdctrls::TCheckBox* BlockRectDefRB;
	Vcltee::Tecanvas::TButtonColor* BlockRectL;
	Vcltee::Tecanvas::TButtonColor* BlockRectR;
	Vcltee::Tecanvas::TButtonColor* BlockRectT;
	Vcltee::Tecanvas::TButtonColor* BlockRectB;
	Vcl::Stdctrls::TCheckBox* BlockRectDefL;
	Vcl::Stdctrls::TCheckBox* BlockRectDefR;
	Vcl::Stdctrls::TCheckBox* BlockRectDefT;
	Vcl::Stdctrls::TCheckBox* BlockRectDefB;
	Vcl::Stdctrls::TLabel* Label95;
	Vcl::Stdctrls::TLabel* LabelBevelY;
	Vcl::Stdctrls::TScrollBar* BlockBevelY;
	Vcl::Stdctrls::TLabel* Label96;
	Vcl::Stdctrls::TLabel* LabelBevelZ;
	Vcl::Stdctrls::TScrollBar* BlockBevelZ;
	Vcl::Stdctrls::TCheckBox* BlockBevelAll;
	Vcl::Stdctrls::TLabel* Label98;
	Vcl::Stdctrls::TEdit* BlockName;
	Vcl::Comctrls::TTabSheet* TabActions;
	Vcl::Stdctrls::TLabel* LEllipTotal;
	Vcl::Stdctrls::TLabel* LEllipAngle;
	Vcl::Stdctrls::TScrollBar* BlockPieStacks;
	Vcl::Stdctrls::TLabel* LPieStacks;
	Vcl::Comctrls::TTabSheet* TabSheet7;
	Vcl::Stdctrls::TLabel* Label97;
	Vcl::Stdctrls::TScrollBar* BlockPieInnerTop;
	Vcl::Stdctrls::TLabel* Label99;
	Vcl::Stdctrls::TScrollBar* BlockPieInnerBottom;
	Vcl::Stdctrls::TLabel* Label100;
	Vcl::Stdctrls::TScrollBar* BlockBevelCurvePoints;
	Vcl::Stdctrls::TLabel* LBevelCurvePoints;
	Vcl::Stdctrls::TCheckBox* CBPosition10;
	Vcl::Stdctrls::TCheckBox* BlockBevelRounded;
	Vcl::Stdctrls::TLabel* Label102;
	Vcltee::Tecanvas::TComboFlat* BlockBevelStyle;
	Vcl::Comctrls::TPageControl* PageObject;
	Vcl::Comctrls::TTabSheet* TabObjectSource;
	Vcl::Comctrls::TTabSheet* TabObjectAnimations;
	Vcl::Stdctrls::TGroupBox* GroupBox5;
	Vcltee::Tecanvas::TComboFlat* BlockObjectAnimations;
	Vcl::Stdctrls::TButton* BlockObjectPlay;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TLabel* LObjectBlocks;
	Vcl::Stdctrls::TLabel* Label30;
	Vcl::Stdctrls::TButton* BSelectLink;
	Vcl::Stdctrls::TButton* BClearLink;
	Vcl::Stdctrls::TButton* BEditLink;
	Vcl::Stdctrls::TEdit* BlockLink;
	Vcl::Stdctrls::TButton* BLoad;
	Vcl::Stdctrls::TLabel* Label103;
	Vcl::Stdctrls::TLabel* Label104;
	Vcl::Stdctrls::TButton* BlockFontEdit;
	Vcl::Stdctrls::TEdit* ESize;
	Vcl::Comctrls::TUpDown* BlockFontSize;
	Vcl::Stdctrls::TGroupBox* GroupBox12;
	Vcl::Stdctrls::TCheckBox* BlockFontItalic;
	Vcl::Stdctrls::TCheckBox* BlockFontBold;
	Vcl::Stdctrls::TCheckBox* BlockFontStrike;
	Vcl::Stdctrls::TCheckBox* BlockFontUnder;
	Vcltee::Tecanvas::TButtonColor* BlockFontColor;
	Vcltee::Tecanvas::TComboFlat* BlockFontName;
	Vcltee::Tecanvas::TComboFlat* BlockTextStyle;
	Vcl::Stdctrls::TLabel* Label78;
	Vcl::Stdctrls::TListBox* ListActions;
	Vcl::Stdctrls::TCheckBox* BlockPipeVisible;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet8;
	Vcl::Stdctrls::TButton* BlockCylinderCover;
	Vcl::Stdctrls::TCheckBox* BlockCylinderCoverDef;
	Vcl::Stdctrls::TCheckBox* BlockCylinderCoverVisible;
	Vcl::Stdctrls::TLabel* Label33;
	Vcl::Stdctrls::TLabel* Label39;
	Vcl::Stdctrls::TLabel* Label40;
	Vcl::Stdctrls::TLabel* LabelCylinderAngle;
	Vcl::Stdctrls::TLabel* LabelSlices;
	Vcl::Stdctrls::TLabel* LabelStacks;
	Vcl::Stdctrls::TLabel* Label71;
	Vcl::Stdctrls::TLabel* LabelCylinderStart;
	Vcl::Stdctrls::TScrollBar* BlockCylinderAngle;
	Vcl::Stdctrls::TScrollBar* BlockCylinderSlices;
	Vcl::Stdctrls::TScrollBar* BlockCylinderStacks;
	Vcl::Stdctrls::TScrollBar* BlockCylinderStart;
	Vcl::Comctrls::TTabSheet* TabCylinderEdge;
	Vcl::Comctrls::TPageControl* PageControl9;
	Vcl::Comctrls::TTabSheet* TabCylTopEdge;
	Vcl::Comctrls::TTabSheet* TabCylBottomEdge;
	Vcl::Comctrls::TTabSheet* TabTextLink;
	Vcl::Stdctrls::TLabel* LabelTextLink;
	Vcl::Stdctrls::TButton* BTextLink;
	Vcl::Stdctrls::TLabel* Label105;
	Vcltee::Tecanvas::TComboFlat* BlockTextLinkFormat;
	Vcltee::Tecanvas::TButtonColor* BlockRectCenter;
	Vcl::Stdctrls::TCheckBox* BlockRectDefCenter;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label35;
	Vcltee::Tecanvas::TComboFlat* BlockTextAlign;
	Vcl::Comctrls::TPageControl* PageControl10;
	Vcl::Comctrls::TTabSheet* TabPoints;
	Vcl::Comctrls::TTabSheet* TabSheet10;
	Vcl::Comctrls::TTabSheet* TabSheet11;
	Vcl::Stdctrls::TLabel* Label61;
	Vcltee::Tecanvas::TComboFlat* BlockPathPointer;
	Vcl::Stdctrls::TButton* Button7;
	Vcl::Stdctrls::TCheckBox* BlockPathColorEach;
	Vcl::Extctrls::TPanel* PanelPoints;
	Vcl::Buttons::TSpeedButton* SBPathAdd;
	Vcl::Buttons::TSpeedButton* SBPathRemove;
	Vcl::Stdctrls::TEdit* BlockPathPoints;
	Vcl::Comctrls::TUpDown* UDPathPoints;
	Vcl::Comctrls::TTabSheet* TabTriangle;
	Vcl::Comctrls::TPageControl* PageControl11;
	Vcl::Comctrls::TTabSheet* TabPoint0;
	Vcl::Comctrls::TTabSheet* TabPoint1;
	Vcl::Comctrls::TTabSheet* TabPoint2;
	Vcl::Comctrls::TTabSheet* TabCustom;
	Vcl::Extctrls::TPanel* Panel6;
	Vcl::Stdctrls::TButton* BAddAction;
	Vcl::Stdctrls::TButton* BDeleteAction;
	Vcl::Extctrls::TPanel* Panel8;
	Vcl::Comctrls::TTabSheet* TabObjectProperties;
	Vcl::Stdctrls::TListBox* BlockObjectProperties;
	Vcl::Stdctrls::TLabel* Label58;
	Vcl::Stdctrls::TEdit* BlockObjectPropValue;
	Vcl::Buttons::TSpeedButton* SBObjPropValue;
	Vcl::Stdctrls::TButton* BClearTextLink;
	Vcl::Comctrls::TTabSheet* TabStars;
	Vcl::Stdctrls::TLabel* Label60;
	Vcl::Stdctrls::TLabel* Label79;
	Vcl::Stdctrls::TLabel* LabelStarCount;
	Vcl::Comctrls::TUpDown* StarMapSize;
	Vcl::Stdctrls::TEdit* EStartMapSize;
	Vcl::Stdctrls::TScrollBar* StarCount;
	Vcl::Stdctrls::TLabel* Label107;
	Vcltee::Tecanvas::TComboFlat* CBCursor;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Stdctrls::TLabel* Label106;
	Vcl::Stdctrls::TScrollBar* BlockElipEccen;
	Vcl::Stdctrls::TButton* BOpenExplorer;
	Vcl::Comctrls::TTabSheet* TabHoleCenter;
	Vcl::Stdctrls::TLabel* Label108;
	Vcl::Stdctrls::TLabel* Label109;
	Vcl::Stdctrls::TScrollBar* BlockHoleCenterX;
	Vcl::Stdctrls::TScrollBar* BlockHoleCenterY;
	Vcl::Stdctrls::TLabel* Label110;
	Vcl::Stdctrls::TButton* BObjectEmbedd;
	Vcl::Stdctrls::TLabel* Label112;
	Vcl::Stdctrls::TLabel* LabelPropValue;
	Vcl::Stdctrls::TLabel* LabelWrongValue;
	Vcl::Menus::TPopupMenu* PopupActions;
	Vcl::Menus::TMenuItem* Manualedit1;
	Vcl::Stdctrls::TLabel* LHoleX;
	Vcl::Stdctrls::TLabel* LHoleY;
	Vcl::Buttons::TSpeedButton* SBActionUp;
	Vcl::Buttons::TSpeedButton* SBActionDown;
	Vcl::Comctrls::TTreeView* TreeEvents;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Menus::TMenuItem* Change1;
	Vcl::Buttons::TSpeedButton* SBAddCustomAction;
	Vcl::Buttons::TSpeedButton* SBRemoveCustomAction;
	Vcl::Stdctrls::TButton* BlockNoScaling;
	Vcl::Stdctrls::TCheckBox* CBTextQuality;
	Vcl::Stdctrls::TLabel* Label36;
	Vcl::Stdctrls::TLabel* Label113;
	Vcl::Stdctrls::TLabel* Label114;
	Vcl::Stdctrls::TButton* Button8;
	Vcl::Stdctrls::TButton* Button9;
	Vcl::Stdctrls::TLabel* LLinkBlock;
	Vcl::Stdctrls::TCheckBox* CBFaceToViewer;
	Vcl::Stdctrls::TLabel* LArrowHeadW;
	Vcl::Stdctrls::TLabel* LArrowHeadH;
	Vcl::Stdctrls::TLabel* LArrowIndent;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall EditXChange(System::TObject* Sender);
	void __fastcall EditYChange(System::TObject* Sender);
	void __fastcall EditZChange(System::TObject* Sender);
	void __fastcall EditWidthChange(System::TObject* Sender);
	void __fastcall EditHeightChange(System::TObject* Sender);
	void __fastcall EditDepthChange(System::TObject* Sender);
	void __fastcall BlockRotationChange(System::TObject* Sender);
	void __fastcall BlockElevationChange(System::TObject* Sender);
	void __fastcall BlockTiltChange(System::TObject* Sender);
	void __fastcall BlockTitleChange(System::TObject* Sender);
	void __fastcall CBSpinByClick(System::TObject* Sender);
	void __fastcall BlockTileXChange(System::TObject* Sender);
	void __fastcall BlockTileYChange(System::TObject* Sender);
	void __fastcall BSelectLinkClick(System::TObject* Sender);
	void __fastcall BClearLinkClick(System::TObject* Sender);
	void __fastcall UDSpinByClick(System::TObject* Sender, Vcl::Comctrls::TUDBtnType Button);
	void __fastcall BlockTileZChange(System::TObject* Sender);
	void __fastcall BlockVisibleClick(System::TObject* Sender);
	void __fastcall BlockLinkChange(System::TObject* Sender);
	void __fastcall BLoadClick(System::TObject* Sender);
	void __fastcall BlockScaleXChange(System::TObject* Sender);
	void __fastcall BlockScaleYChange(System::TObject* Sender);
	void __fastcall BlockScaleZChange(System::TObject* Sender);
	void __fastcall BlockTileOffXChange(System::TObject* Sender);
	void __fastcall BlockTileOffYChange(System::TObject* Sender);
	void __fastcall BlockTileOffZChange(System::TObject* Sender);
	void __fastcall ElipSidesChange(System::TObject* Sender);
	void __fastcall ElipStacksChange(System::TObject* Sender);
	void __fastcall BlockElipTotalChange(System::TObject* Sender);
	void __fastcall BlockConeXChange(System::TObject* Sender);
	void __fastcall BlockSide1Click(System::TObject* Sender);
	void __fastcall BlockSide2Click(System::TObject* Sender);
	void __fastcall BlockSide1DefClick(System::TObject* Sender);
	void __fastcall BlockSide2DefClick(System::TObject* Sender);
	void __fastcall BlockSide1VisibleClick(System::TObject* Sender);
	void __fastcall BlockSide2VisibleClick(System::TObject* Sender);
	void __fastcall BEditLinkClick(System::TObject* Sender);
	void __fastcall BlockElipCoverClick(System::TObject* Sender);
	void __fastcall BlockElipCoverDefClick(System::TObject* Sender);
	void __fastcall BlockElipCoverVisibleClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BlockBevelXChange(System::TObject* Sender);
	void __fastcall BlockElipTotalAngleChange(System::TObject* Sender);
	void __fastcall BlockCylinderAngleChange(System::TObject* Sender);
	void __fastcall BlockSphereSlicesChange(System::TObject* Sender);
	void __fastcall BlockSphereStacksChange(System::TObject* Sender);
	void __fastcall BlockLightColorClick(System::TObject* Sender);
	void __fastcall ESpotChange(System::TObject* Sender);
	void __fastcall CBDefaultSpotClick(System::TObject* Sender);
	void __fastcall BlockLightFixedClick(System::TObject* Sender);
	void __fastcall BlockLightIntChange(System::TObject* Sender);
	void __fastcall BlockColorClick(System::TObject* Sender);
	void __fastcall BlockWedgeX1Change(System::TObject* Sender);
	void __fastcall BlockWedgeY1Change(System::TObject* Sender);
	void __fastcall BlockBridgeSizeChange(System::TObject* Sender);
	void __fastcall BlockBridgeHeightChange(System::TObject* Sender);
	void __fastcall BlockLightLampClick(System::TObject* Sender);
	void __fastcall BlockPieDonutChange(System::TObject* Sender);
	void __fastcall BlockPieStartChange(System::TObject* Sender);
	void __fastcall BlockPieAngleChange(System::TObject* Sender);
	void __fastcall BlockHoleXChange(System::TObject* Sender);
	void __fastcall BlockHoleYChange(System::TObject* Sender);
	void __fastcall BlockHoleStyleChange(System::TObject* Sender);
	void __fastcall BlockCenterXChange(System::TObject* Sender);
	void __fastcall BlockCenterYChange(System::TObject* Sender);
	void __fastcall BlockCenterZChange(System::TObject* Sender);
	void __fastcall BlockBorderClick(System::TObject* Sender);
	void __fastcall BlockLightUseDirClick(System::TObject* Sender);
	void __fastcall BlockLightDiffuseChange(System::TObject* Sender);
	void __fastcall BlockLightSpecularChange(System::TObject* Sender);
	void __fastcall BlockLightSpotExpChange(System::TObject* Sender);
	void __fastcall BlockArrowWidthChange(System::TObject* Sender);
	void __fastcall BlockObjectAnimationsChange(System::TObject* Sender);
	void __fastcall BlockObjectPlayClick(System::TObject* Sender);
	void __fastcall BlockPipeXRadiusChange(System::TObject* Sender);
	void __fastcall BlockPathPointerChange(System::TObject* Sender);
	void __fastcall BlockPathPointsChange(System::TObject* Sender);
	void __fastcall SBPathAddClick(System::TObject* Sender);
	void __fastcall SBPathRemoveClick(System::TObject* Sender);
	void __fastcall BlockWedgeX2Change(System::TObject* Sender);
	void __fastcall BlockWedgeY2Change(System::TObject* Sender);
	void __fastcall BlockBridgeRoundedClick(System::TObject* Sender);
	void __fastcall BlockArrowHeightChange(System::TObject* Sender);
	void __fastcall BlockCylinderCoverClick(System::TObject* Sender);
	void __fastcall BlockCylinderCoverDefClick(System::TObject* Sender);
	void __fastcall BlockCylinderCoverVisibleClick(System::TObject* Sender);
	void __fastcall BlockCylinderStartChange(System::TObject* Sender);
	void __fastcall BlockCrossWidthChange(System::TObject* Sender);
	void __fastcall BlockCrossHeightChange(System::TObject* Sender);
	void __fastcall BlockCrossCenterXChange(System::TObject* Sender);
	void __fastcall BlockCrossCenterYChange(System::TObject* Sender);
	void __fastcall BlockConeYChange(System::TObject* Sender);
	void __fastcall BlockTextStyleChange(System::TObject* Sender);
	void __fastcall BlockArrowIndentChange(System::TObject* Sender);
	void __fastcall BlockSphereRadiusChange(System::TObject* Sender);
	void __fastcall CBBlockExtFrontClick(System::TObject* Sender);
	void __fastcall CBBlockExtBackClick(System::TObject* Sender);
	void __fastcall BlockExtrudedFrontClick(System::TObject* Sender);
	void __fastcall BlockExtrudedBackClick(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall BlockRectDefLTClick(System::TObject* Sender);
	void __fastcall BlockRectDefLBClick(System::TObject* Sender);
	void __fastcall BlockRectDefRTClick(System::TObject* Sender);
	void __fastcall BlockRectDefRBClick(System::TObject* Sender);
	void __fastcall BlockRectLTClick(System::TObject* Sender);
	void __fastcall BlockRectLBClick(System::TObject* Sender);
	void __fastcall BlockRectRTClick(System::TObject* Sender);
	void __fastcall BlockRectRBClick(System::TObject* Sender);
	void __fastcall BlockCubeSideClick(System::TObject* Sender);
	void __fastcall BlockCubeSideDefaultClick(System::TObject* Sender);
	void __fastcall BlockTextLinesChange(System::TObject* Sender);
	void __fastcall BlockTextAlignChange(System::TObject* Sender);
	void __fastcall BlockEllipseSlicesChange(System::TObject* Sender);
	void __fastcall BlockBridgeRoundChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall BlockRectLeftChange(System::TObject* Sender);
	void __fastcall BlockRectRightChange(System::TObject* Sender);
	void __fastcall BlockScaleXYZChange(System::TObject* Sender);
	void __fastcall BlockPipeYRadiusChange(System::TObject* Sender);
	void __fastcall BlockPipeConnectorChange(System::TObject* Sender);
	void __fastcall BlockStarInnerChange(System::TObject* Sender);
	void __fastcall BlockStarSlantChange(System::TObject* Sender);
	void __fastcall BlockRectLClick(System::TObject* Sender);
	void __fastcall BlockRectRClick(System::TObject* Sender);
	void __fastcall BlockRectTClick(System::TObject* Sender);
	void __fastcall BlockRectBClick(System::TObject* Sender);
	void __fastcall BlockRectDefLClick(System::TObject* Sender);
	void __fastcall BlockRectDefRClick(System::TObject* Sender);
	void __fastcall BlockRectDefTClick(System::TObject* Sender);
	void __fastcall BlockRectDefBClick(System::TObject* Sender);
	void __fastcall BlockBevelYChange(System::TObject* Sender);
	void __fastcall BlockBevelZChange(System::TObject* Sender);
	void __fastcall BlockNameChange(System::TObject* Sender);
	void __fastcall ListActionsClick(System::TObject* Sender);
	void __fastcall BDeleteActionClick(System::TObject* Sender);
	void __fastcall PageCurrentChange(System::TObject* Sender);
	void __fastcall BAddActionClick(System::TObject* Sender);
	void __fastcall BlockPieStacksChange(System::TObject* Sender);
	void __fastcall BlockPieInnerTopChange(System::TObject* Sender);
	void __fastcall BlockPieInnerBottomChange(System::TObject* Sender);
	void __fastcall BlockBevelCurvePointsChange(System::TObject* Sender);
	void __fastcall Button7Click(System::TObject* Sender);
	void __fastcall CBPosition10Click(System::TObject* Sender);
	void __fastcall BlockBevelRoundedClick(System::TObject* Sender);
	void __fastcall BlockBevelStyleChange(System::TObject* Sender);
	void __fastcall BlockFontItalicClick(System::TObject* Sender);
	void __fastcall BlockFontBoldClick(System::TObject* Sender);
	void __fastcall BlockFontStrikeClick(System::TObject* Sender);
	void __fastcall BlockFontUnderClick(System::TObject* Sender);
	void __fastcall BlockFontNameChange(System::TObject* Sender);
	void __fastcall BlockFontEditClick(System::TObject* Sender);
	void __fastcall ESizeChange(System::TObject* Sender);
	void __fastcall BlockFontColorClick(System::TObject* Sender);
	void __fastcall SBActionUpClick(System::TObject* Sender);
	void __fastcall SBActionDownClick(System::TObject* Sender);
	void __fastcall BlockPipeVisibleClick(System::TObject* Sender);
	void __fastcall BTextLinkClick(System::TObject* Sender);
	void __fastcall BlockTextLinkFormatChange(System::TObject* Sender);
	void __fastcall BlockRectDefCenterClick(System::TObject* Sender);
	void __fastcall BlockRectCenterClick(System::TObject* Sender);
	void __fastcall BlockPathColorEachClick(System::TObject* Sender);
	void __fastcall BlockObjectPropertiesClick(System::TObject* Sender);
	void __fastcall BlockObjectPropValueChange(System::TObject* Sender);
	void __fastcall SBObjPropValueClick(System::TObject* Sender);
	void __fastcall BClearTextLinkClick(System::TObject* Sender);
	void __fastcall EStartMapSizeChange(System::TObject* Sender);
	void __fastcall StarCountChange(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall BlockElipEccenChange(System::TObject* Sender);
	void __fastcall BOpenExplorerClick(System::TObject* Sender);
	void __fastcall BlockHoleCenterYChange(System::TObject* Sender);
	void __fastcall BlockHoleCenterXChange(System::TObject* Sender);
	void __fastcall BObjectEmbeddClick(System::TObject* Sender);
	void __fastcall PopupActionsPopup(System::TObject* Sender);
	void __fastcall Manualedit1Click(System::TObject* Sender);
	void __fastcall TreeEventsChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall Button5Click(System::TObject* Sender);
	void __fastcall BlockCubeSideDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall Change1Click(System::TObject* Sender);
	void __fastcall PageObjectChange(System::TObject* Sender);
	void __fastcall ESpinByChange(System::TObject* Sender);
	void __fastcall BlockNoScalingClick(System::TObject* Sender);
	void __fastcall CBTextQualityClick(System::TObject* Sender);
	void __fastcall Button8Click(System::TObject* Sender);
	void __fastcall Button9Click(System::TObject* Sender);
	void __fastcall CBFaceToViewerClick(System::TObject* Sender);
	
private:
	Vcltee::Teeedigrad::TTeeGradientEditor* FGradientEditor;
	Teeblockformat::TBlockFormatEditor* ICubeSideEditor;
	Teeblockformat::TBlockFormatEditor* ITubeEditor;
	void __fastcall AddEditAction(const System::UnicodeString AAction = System::UnicodeString());
	void __fastcall CheckBlockNoScaling();
	void __fastcall CheckFontStyle(Vcl::Stdctrls::TCheckBox* Check, System::Uitypes::TFontStyle Value);
	void __fastcall CheckPathPoints(int ACount);
	void __fastcall CheckPointEditor(Teepointeditor::TPointEditor* &AEditor, Vcl::Comctrls::TTabSheet* ATab, Teeblocks::TPointXYZColor* APoint, const double AFactor);
	Teeblocks::TBlockActionItem* __fastcall CurrentActions();
	Teeblocks::TBlockFormat* __fastcall CurrentCubeSide();
	Teemakercontrol::TMaker* __fastcall CurrentMaker();
	int __fastcall CurrentPropertyIndex();
	System::UnicodeString __fastcall CurrentPropertyName();
	void __fastcall EnableShapeTabs();
	void __fastcall FillActions();
	void __fastcall FontRefreshBasicProps();
	int __fastcall Position10();
	void __fastcall SetLabelPropValue();
	void __fastcall SetLinkBlockLabel();
	void __fastcall TreeEventsCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	
protected:
	Teeblockformat::TBlockFormatEditor* IFormatEditor;
	Teeblockformat::TBlockFormatEditor* IHoleFormat;
	Teeroundrect::TRoundRectEditor* IHoleRoundEditor;
	bool IModifying;
	Teepointeditor::TPointEditor* IPointEditor;
	Teepointeditor::TPointEditor* IPoint0;
	Teepointeditor::TPointEditor* IPoint1;
	Teepointeditor::TPointEditor* IPoint2;
	Teeroundrect::TRoundRectEditor* IRoundEditor;
	
public:
	Vcl::Comctrls::TTreeView* BlocksTreeView;
	Teeblocks::TCustomBlock* Current;
	__classmethod void __fastcall AddBlocks(Vcltee::Tecanvas::TComboFlat* ACombo, Teeblocks::TCustomBlock* ASkip, Teeblocks::TCustomBlock* ASelected, const System::UnicodeString Desc);
	virtual void __fastcall RefreshBlock(Vcltee::Tecanvas::TVisualBlock* const ABlock);
	void __fastcall RefreshLocation();
	void __fastcall RefreshRotation();
	void __fastcall RefreshSize();
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* AOwner, Teeblocks::TCustomBlock* ABlock);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBlockEditor(System::Classes::TComponent* AOwner) : Vcltee::Tecanvas::TVisualEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBlockEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Tecanvas::TVisualEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBlockEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBlockEditor(HWND ParentWindow) : Vcltee::Tecanvas::TVisualEditor(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TMakerPropertySelector : public Teeselectproperty::TPropertySelector
{
	typedef Teeselectproperty::TPropertySelector inherited;
	
private:
	void __fastcall AddBlocks(Vcl::Comctrls::TTreeNode* Node, Teeblocks::TBlocks* ABlocks, bool ExternalBlocks = false);
	void __fastcall SelectNode(System::TObject* AObject, System::UnicodeString AName);
	
protected:
	virtual void __fastcall AddProperties(Vcl::Comctrls::TTreeView* ATree, System::TObject* AObject, System::Classes::TList* AList, System::Typinfo::TTypeKinds AFilter);
	
public:
	void __fastcall AddSelection(Teeblocks::TBlocks* ABlocks, bool ExternalBlocks = false);
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* AOwner, Teeblocks::TBlocks* ABlocks, System::TObject* &AObject, System::UnicodeString &AName)/* overload */;
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* AOwner, Teeblocks::TBlocks* ABlocks, Vcltee::Teeanimate::TPropertyLink* Link)/* overload */;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMakerPropertySelector(System::Classes::TComponent* AOwner) : Teeselectproperty::TPropertySelector(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMakerPropertySelector(System::Classes::TComponent* AOwner, int Dummy) : Teeselectproperty::TPropertySelector(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMakerPropertySelector() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMakerPropertySelector(HWND ParentWindow) : Teeselectproperty::TPropertySelector(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeblockeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEBLOCKEDITOR)
using namespace Teeblockeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeblockeditorHPP
