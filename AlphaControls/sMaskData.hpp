// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sMaskData.pas' rev: 27.00 (Windows)

#ifndef SmaskdataHPP
#define SmaskdataHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <acTinyJPG.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smaskdata
{
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TacOutEffData
{
public:
	System::Uitypes::TColor ColorL;
	System::Uitypes::TColor ColorT;
	System::Uitypes::TColor ColorR;
	System::Uitypes::TColor ColorB;
	int OffsetL;
	int OffsetT;
	int OffsetR;
	int OffsetB;
	int WidthL;
	int WidthT;
	int WidthR;
	int WidthB;
	int Opacity;
	int Source;
	int Mask;
};


typedef System::DynamicArray<TacOutEffData> TacOutEffArray;

struct DECLSPEC_DRECORD TsMaskData
{
public:
	Vcl::Graphics::TBitmap* Bmp;
	System::UnicodeString ClassName;
	System::UnicodeString PropertyName;
	System::Types::TRect R;
	short ImageCount;
	short MaskType;
	short BorderWidth;
	short DrawMode;
	Sconst::TacImgType ImgType;
	System::TObject* Manager;
	short WL;
	short WT;
	short WR;
	short WB;
	int CornerType;
};


typedef TsMaskData *PsMaskData;

struct DECLSPEC_DRECORD TsPatternData
{
public:
	Actinyjpg::TacTinyJPGImage* Img;
	System::UnicodeString ClassName;
	System::UnicodeString PropertyName;
};


struct DECLSPEC_DRECORD TsFontColor
{
public:
	System::Uitypes::TColor Color;
	System::Uitypes::TColor Left;
	System::Uitypes::TColor Top;
	System::Uitypes::TColor Right;
	System::Uitypes::TColor Bottom;
};


struct DECLSPEC_DRECORD TsGenState
{
public:
	System::Uitypes::TColor Color;
	TsFontColor FontColor;
	int GradientPercent;
	System::UnicodeString GradientData;
	Sconst::TsGradArray GradientArray;
	int ImagePercent;
	int TextureIndex;
	System::Uitypes::TColor GlowColor;
	int GlowSize;
	int Transparency;
};


typedef System::StaticArray<TsGenState, 2> TsProps;

struct DECLSPEC_DRECORD TsGeneralData
{
public:
	System::UnicodeString ParentClass;
	System::UnicodeString ClassName;
	int States;
	TsProps Props;
	bool GiveOwnFont;
	bool ReservedBoolean;
	int GlowCount;
	int GlowMargin;
	int BorderIndex;
	int ImgTL;
	int ImgTR;
	int ImgBL;
	int ImgBR;
	int TextureNormal;
	System::Uitypes::TColor Color;
	int Transparency;
	int GradientPercent;
	System::UnicodeString GradientData;
	Sconst::TsGradArray GradientArray;
	int ImagePercent;
	System::StaticArray<System::Uitypes::TColor, 5> FontColor;
	System::Uitypes::TColor HotColor;
	int HotTransparency;
	int HotGradientPercent;
	System::UnicodeString HotGradientData;
	Sconst::TsGradArray HotGradientArray;
	int HotImagePercent;
	System::StaticArray<System::Uitypes::TColor, 5> HotFontColor;
	bool FadingEnabled;
	int FadingIterations;
	System::Uitypes::TColor HotGlowColor;
	System::Uitypes::TColor GlowColor;
	int HotGlowSize;
	int GlowSize;
	int OuterMode;
	System::Types::TRect OuterOffset;
	int OuterMask;
	int OuterOpacity;
};


typedef System::DynamicArray<TsMaskData> TsMaskArray;

typedef System::DynamicArray<TsPatternData> TsPatternArray;

typedef System::DynamicArray<TsGeneralData> TsGeneralDataArray;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int __fastcall WidthOfImage(const TsMaskData &md);
extern DELPHI_PACKAGE int __fastcall HeightOfImage(const TsMaskData &md);
}	/* namespace Smaskdata */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SMASKDATA)
using namespace Smaskdata;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SmaskdataHPP
