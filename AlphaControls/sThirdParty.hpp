// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sThirdParty.pas' rev: 27.00 (Windows)

#ifndef SthirdpartyHPP
#define SthirdpartyHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <sToolBar.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sBitBtn.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sthirdparty
{
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TacDrawGlyphData
{
public:
	Vcl::Graphics::TBitmap* DstBmp;
	Vcl::Graphics::TCanvas* Canvas;
	Vcl::Imglist::TCustomImageList* Images;
	int ImageIndex;
	Vcl::Graphics::TBitmap* Glyph;
	int SkinIndex;
	System::TObject* SkinManager;
	System::Types::TRect ImgRect;
	int NumGlyphs;
	bool Enabled;
	int Blend;
	bool Down;
	bool Grayed;
	int CurrentState;
	Sconst::TsDisabledGlyphKind DisabledGlyphKind;
	bool Reflected;
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Classes::TStringList* ThirdPartySkipForms;
extern DELPHI_PACKAGE void __fastcall (*InitDevEx)(const bool Active);
extern DELPHI_PACKAGE bool __fastcall (*CheckDevEx)(Vcl::Controls::TControl* const Control);
extern DELPHI_PACKAGE void __fastcall (*RefreshDevEx)(void);
extern DELPHI_PACKAGE int __fastcall GetImageCount(Vcl::Imglist::TCustomImageList* ImgList);
extern DELPHI_PACKAGE void __fastcall acDrawGlyphEx(const TacDrawGlyphData &DrawData);
extern DELPHI_PACKAGE void __fastcall DrawBtnGlyph(Vcl::Controls::TControl* Button, Vcl::Graphics::TCanvas* Canvas = (Vcl::Graphics::TCanvas*)(0x0));
extern DELPHI_PACKAGE void __fastcall CopyToolBtnGlyph(Vcl::Comctrls::TToolBar* ToolBar, Vcl::Comctrls::TToolButton* Button, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, Vcl::Comctrls::TTBCustomDrawFlags &Flags, Vcl::Graphics::TBitmap* BtnBmp);
}	/* namespace Sthirdparty */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_STHIRDPARTY)
using namespace Sthirdparty;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SthirdpartyHPP
