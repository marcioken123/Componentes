// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sStyleSimply.pas' rev: 27.00 (Windows)

#ifndef SstylesimplyHPP
#define SstylesimplyHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sSkinProps.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sstylesimply
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsSkinData;
class PASCALIMPLEMENTATION TsSkinData : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	bool Active;
	System::UnicodeString SkinPath;
	double Version;
	System::UnicodeString Author;
	System::UnicodeString Description;
	System::Uitypes::TColor Shadow1Color;
	int Shadow1Offset;
	int Shadow1Blur;
	int Shadow1Transparency;
	int ExBorderWidth;
	int ExTitleHeight;
	int ExMaxHeight;
	int ExContentOffs;
	int ExCenterOffs;
	int ExDrawMode;
	int ExShadowOffs;
	int ExShadowOffsR;
	int ExShadowOffsT;
	int ExShadowOffsB;
	System::Uitypes::TColor FXColor;
	int BISpacing;
	int BIVAlign;
	int BIRightMargin;
	int BILeftMargin;
	int BITopMargin;
	int BIKeepHUE;
	int BICloseGlow;
	int BICloseGlowMargin;
	int BIMaxGlow;
	int BIMaxGlowMargin;
	int BIMinGlow;
	int BIMinGlowMargin;
	bool UseAeroBluring;
	int ComboBoxMargin;
	int BrightMin;
	int BrightMax;
	int TabsCovering;
	__fastcall virtual ~TsSkinData(void);
public:
	/* TObject.Create */ inline __fastcall TsSkinData(void) : System::TObject() { }
	
};


struct DECLSPEC_DRECORD TacConstElementData
{
public:
	int SkinIndex;
	int MaskIndex;
	int GlyphIndex;
	System::StaticArray<int, 2> BGIndex;
	System::UnicodeString SkinSection;
};


enum DECLSPEC_DENUM TacSection : unsigned char { ssMenuItem, ssToolButton, ssCheckBox, ssTransparent, ssGroupBox, ssWebBtn };

typedef System::StaticArray<TacConstElementData, 4> TacSideElements;

typedef System::StaticArray<TacConstElementData, 2> TacBoolElements;

typedef System::StaticArray<int, 6> TacIntSections;

struct DECLSPEC_DRECORD TConstantSkinData
{
public:
	int IndexGLobalInfo;
	int ExBorder;
	TacSideElements Tabs;
	TacSideElements ScrollBtns;
	TacSideElements Scrolls;
	TacBoolElements Sliders;
	TacConstElementData ComboBtn;
	int MaskCloseBtn;
	int MaskCloseAloneBtn;
	int MaskMaxBtn;
	int MaskNormBtn;
	int MaskMinBtn;
	int MaskHelpBtn;
	int MaskCloseSmall;
	int MaskMaxSmall;
	int MaskNormSmall;
	int MaskMinSmall;
	int MaskHelpSmall;
	int CheckBoxChecked;
	int CheckBoxUnChecked;
	int CheckBoxGrayed;
	int RadioButtonChecked;
	int RadioButtonUnChecked;
	int RadioButtonGrayed;
	int SmallCheckBoxChecked;
	int SmallCheckBoxUnChecked;
	int SmallCheckBoxGrayed;
	int GripRightBottom;
	int GripHorizontal;
	int GripVertical;
	TacIntSections Sections;
};


typedef System::StaticArray<System::UnicodeString, 6> Sstylesimply__2;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Sstylesimply__2 acSectNames;
extern DELPHI_PACKAGE Vcl::Graphics::TIcon* AppIcon;
extern DELPHI_PACKAGE Vcl::Graphics::TIcon* AppIconLarge;
extern DELPHI_PACKAGE bool aSkinChanging;
extern DELPHI_PACKAGE bool __fastcall SectionInArray(const TacIntSections &Sections, const int Value, TacSection RangeMin = (TacSection)(0x0), TacSection RangeMax = (TacSection)(0x5));
extern DELPHI_PACKAGE void __fastcall CopyExForms(System::Classes::TComponent* SkinManager);
extern DELPHI_PACKAGE void __fastcall LockForms(System::Classes::TComponent* SkinManager);
extern DELPHI_PACKAGE void __fastcall UnLockForms(System::Classes::TComponent* SkinManager, bool Repaint = true);
extern DELPHI_PACKAGE void __fastcall AppBroadCastS(void *Message);
extern DELPHI_PACKAGE void __fastcall SendToHooked(void *Message);
extern DELPHI_PACKAGE void __fastcall IntSkinForm(Vcl::Forms::TCustomForm* Form);
extern DELPHI_PACKAGE void __fastcall IntUnSkinForm(Vcl::Forms::TCustomForm* Form);
}	/* namespace Sstylesimply */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SSTYLESIMPLY)
using namespace Sstylesimply;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SstylesimplyHPP
