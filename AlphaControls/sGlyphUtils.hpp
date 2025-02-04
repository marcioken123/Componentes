// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sGlyphUtils.pas' rev: 27.00 (Windows)

#ifndef SglyphutilsHPP
#define SglyphutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <acAlphaImageList.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sglyphutils
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsGlyphMode;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsGlyphMode : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcl::Controls::TWinControl* FOwner;
	Vcl::Imglist::TCustomImageList* FImages;
	int FImageIndex;
	int FImageIndexHot;
	int FImageIndexPressed;
	void __fastcall SetBlend(const int Value);
	System::UnicodeString __fastcall GetHint(void);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetGrayed(const bool Value);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetImageIndexHot(const int Value);
	void __fastcall SetImageIndexPressed(const int Value);
	int __fastcall ReadBlend(void);
	bool __fastcall ReadGrayed(void);
	bool __fastcall BtnIsReady(void);
	
public:
	Sspeedbutton::TsSpeedButton* Btn;
	__fastcall TsGlyphMode(Vcl::Controls::TWinControl* AOwner);
	void __fastcall Invalidate(void);
	int __fastcall ImageCount(void);
	int __fastcall Width(void);
	int __fastcall Height(void);
	
__published:
	__property int Blend = {read=ReadBlend, write=SetBlend, nodefault};
	__property bool Grayed = {read=ReadGrayed, write=SetGrayed, nodefault};
	__property System::UnicodeString Hint = {read=GetHint, write=SetHint};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property int ImageIndexHot = {read=FImageIndexHot, write=SetImageIndexHot, default=-1};
	__property int ImageIndexPressed = {read=FImageIndexPressed, write=SetImageIndexPressed, default=-1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TsGlyphMode(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 iBTN_OPENFILE = System::Int8(0x0);
static const System::Int8 iBTN_OPENFOLDER = System::Int8(0x1);
static const System::Int8 iBTN_DATE = System::Int8(0x2);
static const System::Int8 iBTN_ELLIPSIS = System::Int8(0x3);
static const System::Int8 iBTN_CALC = System::Int8(0x4);
extern DELPHI_PACKAGE Acalphaimagelist::TsAlphaImageList* acResImgList;
}	/* namespace Sglyphutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SGLYPHUTILS)
using namespace Sglyphutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SglyphutilsHPP
