// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sConst.pas' rev: 27.00 (Windows)

#ifndef SconstHPP
#define SconstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sconst
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TacOuterEffectStyle : unsigned char { oeNone, oeShadow, oeLowered };

enum DECLSPEC_DENUM TacOuterVisibility : unsigned char { ovNone, ovAlways };

enum DECLSPEC_DENUM TacSide : unsigned char { asLeft, asTop, asRight, asBottom };

typedef System::DynamicArray<System::Types::TRect> TRects;

typedef System::UnicodeString ACString;

typedef System::WideChar ACChar;

typedef System::WideChar * PACChar;

typedef NativeInt ACLongInt;

typedef NativeUInt ACUInt;

typedef char OldChar;

typedef char * POldChar;

typedef System::AnsiString OldString;

typedef System::PAnsiString POldString;

typedef System::UnicodeString *PACString;

typedef System::DynamicArray<System::Types::TRect> TAOR;

typedef void __fastcall (__closure *TPaintEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas);

typedef void __fastcall (__closure *TBmpPaintEvent)(System::TObject* Sender, Vcl::Graphics::TBitmap* Bmp);

typedef System::UnicodeString TsSkinName;

typedef System::UnicodeString TsDirectory;

typedef System::UnicodeString TsSkinSection;

typedef System::UnicodeString TacStrValue;

typedef System::UnicodeString TacRoot;

enum DECLSPEC_DENUM TFadeDirection : unsigned char { fdNone, fdUp, fdDown };

enum DECLSPEC_DENUM TacAnimType : unsigned char { atFading, atAero };

enum DECLSPEC_DENUM TacAnimTypeCtrl : unsigned char { atcFade, atcAero, atcBlur };

enum DECLSPEC_DENUM TacBtnEvent : unsigned char { beMouseEnter, beMouseLeave, beMouseDown, beMouseUp };

typedef System::Set<TacBtnEvent, TacBtnEvent::beMouseEnter, TacBtnEvent::beMouseUp> TacBtnEvents;

enum DECLSPEC_DENUM TacCtrlType : unsigned char { actGraphic };

enum DECLSPEC_DENUM TacAnimatEvent : unsigned char { aeMouseEnter, aeMouseLeave, aeMouseDown, aeMouseUp, aeGlobalDef };

typedef System::Set<TacAnimatEvent, TacAnimatEvent::aeMouseEnter, TacAnimatEvent::aeGlobalDef> TacAnimatEvents;

enum DECLSPEC_DENUM TacImgType : unsigned char { itisaBorder, itisaTexture, itisaGlyph, itisaGlow, itisaPngGlyph };

enum DECLSPEC_DENUM TacFillMode : unsigned char { fmTiled, fmStretched, fmTiledHorz, fmTiledVert, fmStretchHorz, fmStretchVert, fmTileHorBtm, fmTileVertRight, fmStretchHorBtm, fmStretchVertRight, fmDisTiled, fmDiscHorTop, fmDiscVertLeft, fmDiscHorBottom, fmDiscVertRight };

enum DECLSPEC_DENUM TvaAlign : unsigned char { vaTop, vaMiddle, vaBottom };

class DELPHICLASS TsHackedControl;
class PASCALIMPLEMENTATION TsHackedControl : public Vcl::Controls::TControl
{
	typedef Vcl::Controls::TControl inherited;
	
public:
	__property AutoSize = {default=0};
	__property ParentColor = {default=1};
	__property Color = {default=-16777211};
	__property ParentFont = {default=1};
	__property PopupMenu;
	__property Font;
	__property WindowText;
public:
	/* TControl.Create */ inline __fastcall virtual TsHackedControl(System::Classes::TComponent* AOwner) : Vcl::Controls::TControl(AOwner) { }
	/* TControl.Destroy */ inline __fastcall virtual ~TsHackedControl(void) { }
	
};


class DELPHICLASS TAccessCanvas;
class PASCALIMPLEMENTATION TAccessCanvas : public Vcl::Graphics::TCustomCanvas
{
	typedef Vcl::Graphics::TCustomCanvas inherited;
	
public:
	HDC FHandle;
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAccessCanvas(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TAccessCanvas(void) : Vcl::Graphics::TCustomCanvas() { }
	
};


struct TacBGInfo;
typedef TacBGInfo *PacBGInfo;

enum DECLSPEC_DENUM TacBGType : unsigned char { btUnknown, btFill, btCache, btNotReady };

struct DECLSPEC_DRECORD TacBGInfo
{
public:
	Vcl::Graphics::TBitmap* Bmp;
	System::Uitypes::TColor Color;
	System::Types::TPoint Offset;
	System::Types::TRect R;
	System::Types::TRect FillRect;
	TacBGType BgType;
	bool PleaseDraw;
	HDC DrawDC;
};


struct DECLSPEC_DRECORD TCacheInfo
{
public:
	Vcl::Graphics::TBitmap* Bmp;
	int X;
	int Y;
	System::Uitypes::TColor FillColor;
	System::Types::TRect FillRect;
	bool Ready;
};


typedef System::DynamicArray<System::Types::TPoint> TPoints;

typedef TPoints *PPoints;

typedef System::Int8 TPercent;

typedef System::Set<System::Byte, 1, 255> TsCodes;

enum DECLSPEC_DENUM TsHintStyle : unsigned char { hsSimply, hsComics, hsEllipse, hsBalloon, hsStandard, hsNone };

enum DECLSPEC_DENUM TsHintsPredefinitions : unsigned char { shSimply, shGradient, shTransparent, shEllipse, shBalloon, shComicsGradient, shComicsTransparent, shStandard, shNone, shCustom };

enum DECLSPEC_DENUM TGradientTypes : unsigned char { gtTopBottom, gtLeftRight, gtAsBorder };

enum DECLSPEC_DENUM TsShadowingShape : unsigned char { ssRectangle, ssEllipse };

enum DECLSPEC_DENUM TsWindowShowMode : unsigned char { soHide, soNormal, soShowMinimized, soMaximize, soShowNoActivate, soShow, soMinimize, soShowMinNoActive, soShowNA, soRestore, soDefault };

#pragma pack(push,1)
struct DECLSPEC_DRECORD TsColor
{
	union
	{
		struct 
		{
			int I;
		};
		struct 
		{
			System::Byte R;
			System::Byte G;
			System::Byte B;
			System::Byte A;
		};
		struct 
		{
			System::Uitypes::TColor C;
		};
		
	};
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TsColor_RGB
{
	union
	{
		struct 
		{
			int Intg;
		};
		struct 
		{
			System::Byte Red;
			System::Byte Green;
			System::Byte Blue;
			System::Byte Alpha;
		};
		struct 
		{
			System::Uitypes::TColor Col;
		};
		
	};
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TsColor_
{
	union
	{
		struct 
		{
			int I;
		};
		struct 
		{
			System::Byte B;
			System::Byte G;
			System::Byte R;
			System::Byte A;
		};
		struct 
		{
			System::Uitypes::TColor C;
		};
		
	};
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TsColor_RGB_
{
	union
	{
		struct 
		{
			int Intg;
		};
		struct 
		{
			System::Byte Blue;
			System::Byte Green;
			System::Byte Red;
			System::Byte Alpha;
		};
		struct 
		{
			System::Uitypes::TColor Col;
		};
		
	};
};
#pragma pack(pop)


typedef System::StaticArray<TsColor_, 100001> TRGBAArray;

typedef TRGBAArray *PRGBAArray;

typedef System::StaticArray<TsColor_RGB_, 100001> TRGBAArray_RGB;

typedef TRGBAArray_RGB *PRGBAArray_RGB;

enum DECLSPEC_DENUM Sconst__3 : unsigned char { dgBlended, dgGrayed };

typedef System::Set<Sconst__3, Sconst__3::dgBlended, Sconst__3::dgGrayed> TsDisabledGlyphKind;

enum DECLSPEC_DENUM Sconst__4 : unsigned char { dkBlended, dkGrayed };

typedef System::Set<Sconst__4, Sconst__4::dkBlended, Sconst__4::dkGrayed> TsDisabledKind;

typedef TsDisabledKind *PsDisabledKind;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TsGradPie
{
public:
	System::Uitypes::TColor Color1;
	System::Uitypes::TColor Color2;
	TPercent Percent;
	int Mode1;
	int Mode2;
};
#pragma pack(pop)


typedef System::DynamicArray<TsGradPie> TsGradArray;

typedef System::StaticArray<System::UnicodeString, 4> Sconst__5;

typedef System::StaticArray<System::UnicodeString, 2> Sconst__6;

enum DECLSPEC_DENUM TsCaptionLayout : unsigned char { sclLeft, sclTopLeft, sclTopCenter, sclTopRight, sclLeftTop, sclBottomLeft, sclBottomCenter, sclBottomRight };

typedef System::Set<System::Uitypes::TCalDayOfWeek, System::Uitypes::TCalDayOfWeek::dowMonday, System::Uitypes::TCalDayOfWeek::dowLocaleDefault> TDaysOfWeek;

enum DECLSPEC_DENUM TDateOrder : unsigned char { doMDY, doDMY, doYMD };

enum DECLSPEC_DENUM TPopupWindowAlign : unsigned char { pwaRight, pwaLeft };

enum DECLSPEC_DENUM TacOptimizingPriority : unsigned char { opSpeed, opMemory };

//-- var, const, procedure ---------------------------------------------------
#define CompatibleSkinVersion  (7.450000E+00)
#define MaxCompSkinVersion  (9.990000E+00)
static const System::Word ExceptTag = System::Word(0x100);
static const System::WideChar TexChar = (System::WideChar)(0x7e);
static const System::WideChar ZeroChar = (System::WideChar)(0x30);
static const System::WideChar CharQuest = (System::WideChar)(0x3f);
static const System::WideChar CharDiez = (System::WideChar)(0x23);
static const System::WideChar CharExt = (System::WideChar)(0x21);
static const System::WideChar CharGlyph = (System::WideChar)(0x40);
static const System::WideChar CharMask = (System::WideChar)(0x5e);
static const System::Int8 ACS_FAST = System::Int8(0x1);
static const System::Int8 ACS_BGUNDEF = System::Int8(0x2);
static const System::Word ACS_PRINTING = System::Word(0x200);
static const System::Word ACS_MNUPDATING = System::Word(0x400);
static const System::Word ACS_LOCKED = System::Word(0x800);
static const System::Word ACS_FOCUSCHANGING = System::Word(0x1000);
static const System::Int8 BGT_NONE = System::Int8(0x0);
static const System::Int8 BGT_GRADIENTHORZ = System::Int8(0x1);
static const System::Int8 BGT_GRADIENTVERT = System::Int8(0x2);
static const System::Int8 BGT_TEXTURE = System::Int8(0x4);
static const System::Int8 BGT_TEXTURELEFT = System::Int8(0x10);
static const System::Int8 BGT_TEXTURETOP = System::Int8(0x20);
static const System::Int8 BGT_TEXTURERIGHT = System::Int8(0x40);
static const System::Byte BGT_TEXTUREBOTTOM = System::Byte(0x80);
static const System::Word BTG_TOPLEFT = System::Word(0x100);
static const System::Word BGT_TOPRIGHT = System::Word(0x200);
static const System::Word BGT_BOTTOMLEFT = System::Word(0x400);
static const System::Word BGT_BOTTOMRIGHT = System::Word(0x800);
static const System::Int8 ACT_RELCAPT = System::Int8(-1);
extern DELPHI_PACKAGE TCacheInfo EmptyCI;
extern DELPHI_PACKAGE TsColor sFuchsia;
extern DELPHI_PACKAGE Sconst__5 sTabPositions;
#define s_RegName L"AlphaSkins"
#define s_IntSkinsPath L"IntSkinsPath"
#define s_PreviewKey L"/acpreview"
#define s_EditorCapt L"AlphaSkins Editor"
static const System::Int8 ASE_CLOSE = System::Int8(0x1);
static const System::Int8 ASE_UPDATE = System::Int8(0x2);
static const System::Int8 ASE_HELLO = System::Int8(0x3);
static const System::Int8 ASE_ALIVE = System::Int8(0x4);
static const System::Word ASE_MSG = System::Word(0xa400);
#define MasterBmpName L"Master.bmp"
#define OptionsDatName L"Options.dat"
#define acSkinExt L"asz"
#define acPngExt L"png"
#define acIcoExt L"ico"
#define s_MinusOne L"-1"
#define s_TrueStr L"TRUE"
#define s_NewFolder L"New folder"
#define s_SkinSelectItemName L"SkinSelectItem"
static const System::WideChar s_Slash = (System::WideChar)(0x5c);
static const System::WideChar s_Space = (System::WideChar)(0x20);
static const System::WideChar s_Comma = (System::WideChar)(0x2c);
static const System::WideChar s_Dot = (System::WideChar)(0x2e);
#define s_0D0A L"\r\n"
static const System::Int8 ac_MaxPropsIndex = System::Int8(0x1);
static const System::Int8 BDM_STRETCH = System::Int8(0x1);
static const System::Int8 BDM_ACTIVEONLY = System::Int8(0x2);
static const System::Int8 BDM_FILL = System::Int8(0x4);
static const System::Int8 HTSB_LEFT_BUTTON = System::Int8(0x64);
static const System::Int8 HTSB_RIGHT_BUTTON = System::Int8(0x65);
static const System::Int8 HTSB_TOP_BUTTON = System::Int8(0x66);
static const System::Int8 HTSB_BOTTOM_BUTTON = System::Int8(0x67);
static const System::Int8 HTSB_H_SCROLL = System::Int8(0x68);
static const System::Int8 HTSB_HB_SCROLL = System::Int8(0x69);
static const System::Int8 HTSB_V_SCROLL = System::Int8(0x6a);
static const System::Int8 HTSB_VB_SCROLL = System::Int8(0x6b);
static const System::Int8 HTCHILDCLOSE = System::Int8(0x65);
static const System::Int8 HTCHILDMAX = System::Int8(0x66);
static const System::Int8 HTCHILDMIN = System::Int8(0x67);
static const System::Int8 acTimerInterval = System::Int8(0xc);
static const System::Byte acAnimationTime = System::Byte(0x84);
extern DELPHI_PACKAGE System::StaticArray<TacImgType, 5> acImgTypes;
extern DELPHI_PACKAGE System::StaticArray<TacFillMode, 15> acFillModes;
extern DELPHI_PACKAGE System::StaticArray<System::Uitypes::TScrollCode, 9> aScrollCodes;
extern DELPHI_PACKAGE System::StaticArray<TsHintStyle, 6> aHintStyles;
extern DELPHI_PACKAGE System::StaticArray<TacBtnEvent, 5> acBtnEvents;
static const System::Int8 COC_TsCustom = System::Int8(0x1);
static const System::Int8 COC_TsSpinEdit = System::Int8(0x2);
static const System::Int8 COC_TsEdit = System::Int8(0x3);
static const System::Int8 COC_TsCustomMaskEdit = System::Int8(0x4);
static const System::Int8 COC_TsMemo = System::Int8(0x7);
static const System::Int8 COC_TsListBox = System::Int8(0x8);
static const System::Int8 COC_TsColorBox = System::Int8(0x9);
static const System::Int8 COC_TsListView = System::Int8(0xa);
static const System::Int8 COC_TsCustomComboBox = System::Int8(0xb);
static const System::Int8 COC_TsComboBox = System::Int8(0xd);
static const System::Int8 COC_TsComboBoxEx = System::Int8(0x12);
static const System::Int8 COC_TsFrameBar = System::Int8(0x13);
static const System::Int8 COC_TsBarTitle = System::Int8(0x14);
static const System::Int8 COC_TsCheckBox = System::Int8(0x20);
static const System::Int8 COC_TsDBCheckBox = System::Int8(0x20);
static const System::Int8 COC_TsRadioButton = System::Int8(0x21);
static const System::Int8 COC_TsSlider = System::Int8(0x22);
static const System::Int8 COC_TsCurrencyEdit = System::Int8(0x29);
static const System::Int8 COC_TsImage = System::Int8(0x32);
static const System::Int8 COC_TsPanel = System::Int8(0x33);
static const System::Int8 COC_TsPanelLow = System::Int8(0x34);
static const System::Int8 COC_TsCoolBar = System::Int8(0x35);
static const System::Int8 COC_TsToolBar = System::Int8(0x36);
static const System::Int8 COC_TsDragBar = System::Int8(0x38);
static const System::Int8 COC_TsTabSheet = System::Int8(0x39);
static const System::Int8 COC_TsScrollBox = System::Int8(0x3a);
static const System::Int8 COC_TsMonthCalendar = System::Int8(0x3b);
static const System::Int8 COC_TsDBNavigator = System::Int8(0x3c);
static const System::Int8 COC_TsCustomPanel = System::Int8(0x44);
static const System::Int8 COC_TsGrip = System::Int8(0x49);
static const System::Int8 COC_TsGroupBox = System::Int8(0x4a);
static const System::Int8 COC_TsSplitter = System::Int8(0x4b);
static const System::Int8 COC_TsDBEdit = System::Int8(0x4c);
static const System::Int8 COC_TsDBMemo = System::Int8(0x4e);
static const System::Int8 COC_TsDBComboBox = System::Int8(0x51);
static const System::Int8 COC_TsDBLookupComboBox = System::Int8(0x52);
static const System::Int8 COC_TsDBListBox = System::Int8(0x53);
static const System::Int8 COC_TsDBLookupListBox = System::Int8(0x54);
static const System::Int8 COC_TsDBGrid = System::Int8(0x55);
static const System::Int8 COC_TsSpeedButton = System::Int8(0x5c);
static const System::Int8 COC_TsButton = System::Int8(0x5d);
static const System::Int8 COC_TsBitBtn = System::Int8(0x5e);
static const System::Int8 COC_TsColorSelect = System::Int8(0x5f);
static const System::Int8 COC_TsTreeView = System::Int8(0x60);
static const System::Int8 COC_TsNavButton = System::Int8(0x62);
static const System::Int8 COC_TsBevel = System::Int8(0x6e);
static const System::Byte COC_TsCustomComboEdit = System::Byte(0x83);
static const System::Byte COC_TsFileDirEdit = System::Byte(0x84);
static const System::Byte COC_TsFilenameEdit = System::Byte(0x85);
static const System::Byte COC_TsDirectoryEdit = System::Byte(0x86);
static const System::Byte COC_TsCustomDateEdit = System::Byte(0x89);
static const System::Byte COC_TsComboEdit = System::Byte(0x8a);
static const System::Byte COC_TsDateEdit = System::Byte(0x8c);
static const System::Byte COC_TsPageControl = System::Byte(0x8d);
static const System::Byte COC_TsScrollBar = System::Byte(0x8e);
static const System::Byte COC_TsTabControl = System::Byte(0x8f);
static const System::Byte COC_TsStatusBar = System::Byte(0x97);
static const System::Byte COC_TsHeaderControl = System::Byte(0x98);
static const System::Byte COC_TsGauge = System::Byte(0xa1);
static const System::Byte COC_TsTrackBar = System::Byte(0xa5);
static const System::Byte COC_TsHintManager = System::Byte(0xd3);
static const System::Byte COC_TsSkinProvider = System::Byte(0xe0);
static const System::Byte COC_TsMDIForm = System::Byte(0xe1);
static const System::Byte COC_TsFrameAdapter = System::Byte(0xe2);
static const System::Byte COC_TsAdapter = System::Byte(0xe6);
static const System::Byte COC_TsAdapterEdit = System::Byte(0xe7);
static const System::Byte COC_Unknown = System::Byte(0xfa);
extern DELPHI_PACKAGE TsCodes sForbidMouse;
extern DELPHI_PACKAGE TsCodes sCanNotBeHot;
extern DELPHI_PACKAGE TsCodes sEditCtrls;
extern DELPHI_PACKAGE Sconst__6 sBoolArray;
extern DELPHI_PACKAGE Vcl::Forms::TForm* sPopupCalendar;
extern DELPHI_PACKAGE int acWinVer;
extern DELPHI_PACKAGE bool acDebugMode;
extern DELPHI_PACKAGE NativeUInt acPreviewHandle;
extern DELPHI_PACKAGE bool acPreviewNeeded;
extern DELPHI_PACKAGE bool acSkinPreviewUpdating;
extern DELPHI_PACKAGE int acScrollBtnLength;
extern DELPHI_PACKAGE bool AppShowHint;
extern DELPHI_PACKAGE bool ShowHintStored;
extern DELPHI_PACKAGE bool FadingForbidden;
extern DELPHI_PACKAGE int acAnimCount;
extern DELPHI_PACKAGE void *TempControl;
extern DELPHI_PACKAGE bool x64woAero;
extern DELPHI_PACKAGE bool fGlobalFlag;
extern DELPHI_PACKAGE Vcl::Controls::TWinControl* acMagnForm;
extern DELPHI_PACKAGE bool ac_UseSysCharSet;
extern DELPHI_PACKAGE bool ac_KeepOwnFont;
extern DELPHI_PACKAGE bool DrawSkinnedMDIWall;
extern DELPHI_PACKAGE bool DrawSkinnedMDIScrolls;
extern DELPHI_PACKAGE bool ac_CheckEmptyAlpha;
extern DELPHI_PACKAGE bool MouseForbidden;
extern DELPHI_PACKAGE bool ac_NoExtBordersIfMax;
extern DELPHI_PACKAGE bool acOldGlyphsOrder;
extern DELPHI_PACKAGE bool ac_OptimizeMemory;
extern DELPHI_PACKAGE int ac_DialogsLevel;
extern DELPHI_PACKAGE bool ac_ChangeThumbPreviews;
extern DELPHI_PACKAGE bool StdTransparency;
static const System::Word SC_DRAGMOVE = System::Word(0xf012);
extern DELPHI_PACKAGE System::UnicodeString acs_MsgDlgOK;
extern DELPHI_PACKAGE System::UnicodeString acs_MsgDlgCancel;
extern DELPHI_PACKAGE System::UnicodeString acs_MsgDlgHelp;
extern DELPHI_PACKAGE System::UnicodeString acs_RestoreStr;
extern DELPHI_PACKAGE System::UnicodeString acs_MoveStr;
extern DELPHI_PACKAGE System::UnicodeString acs_SizeStr;
extern DELPHI_PACKAGE System::UnicodeString acs_MinimizeStr;
extern DELPHI_PACKAGE System::UnicodeString acs_MaximizeStr;
extern DELPHI_PACKAGE System::UnicodeString acs_CloseStr;
extern DELPHI_PACKAGE System::UnicodeString acs_Calculator;
extern DELPHI_PACKAGE System::UnicodeString acs_FileOpen;
extern DELPHI_PACKAGE System::UnicodeString acs_AvailSkins;
extern DELPHI_PACKAGE System::UnicodeString acs_InternalSkin;
extern DELPHI_PACKAGE System::UnicodeString acs_ErrorSettingCount;
extern DELPHI_PACKAGE System::UnicodeString acs_ListBoxMustBeVirtual;
extern DELPHI_PACKAGE System::UnicodeString acs_InvalidDate;
extern DELPHI_PACKAGE System::UnicodeString acs_ColorDlgAdd;
extern DELPHI_PACKAGE System::UnicodeString acs_ColorDlgDefine;
extern DELPHI_PACKAGE System::UnicodeString acs_ColorDlgMainPal;
extern DELPHI_PACKAGE System::UnicodeString acs_ColorDlgAddPal;
extern DELPHI_PACKAGE System::UnicodeString acs_ColorDlgTitle;
extern DELPHI_PACKAGE System::UnicodeString acs_ColorDlgRed;
extern DELPHI_PACKAGE System::UnicodeString acs_ColorDlgGreen;
extern DELPHI_PACKAGE System::UnicodeString acs_ColorDlgBlue;
extern DELPHI_PACKAGE System::UnicodeString acs_ColorDlgDecimal;
extern DELPHI_PACKAGE System::UnicodeString acs_ColorDlgHex;
extern DELPHI_PACKAGE System::UnicodeString acs_FrameAdapterError1;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnTitle;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnPreserved;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnStyle;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnBevelWidth;
extern DELPHI_PACKAGE System::UnicodeString acs_Blur;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnArrowLength;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnHorizMargin;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnVertMargin;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnRadius;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnMaxWidth;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnPauseHide;
extern DELPHI_PACKAGE System::UnicodeString acs_Percent;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnOffset;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnTransparency;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnNoPicture;
extern DELPHI_PACKAGE System::UnicodeString acs_Font;
extern DELPHI_PACKAGE System::UnicodeString acs_Texture;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnLoad;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnSave;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnColor;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnBorderTop;
extern DELPHI_PACKAGE System::UnicodeString acs_HintDsgnBorderBottom;
extern DELPHI_PACKAGE System::UnicodeString acs_Shadow;
extern DELPHI_PACKAGE System::UnicodeString acs_Background;
extern DELPHI_PACKAGE System::UnicodeString acs_Gradient;
extern DELPHI_PACKAGE System::UnicodeString acs_PreviewHint;
extern DELPHI_PACKAGE System::UnicodeString acs_Root;
extern DELPHI_PACKAGE System::UnicodeString acs_SelectDir;
extern DELPHI_PACKAGE System::UnicodeString acs_Create;
extern DELPHI_PACKAGE System::UnicodeString acs_DirWithSkins;
extern DELPHI_PACKAGE System::UnicodeString acs_SelectSkinTitle;
extern DELPHI_PACKAGE System::UnicodeString acs_SkinPreview;
}	/* namespace Sconst */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCONST)
using namespace Sconst;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SconstHPP
