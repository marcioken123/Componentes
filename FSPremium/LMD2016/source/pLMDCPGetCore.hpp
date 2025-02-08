// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDCPGetCore.pas' rev: 31.00 (Windows)

#ifndef PlmdcpgetcoreHPP
#define PlmdcpgetcoreHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.RTLConsts.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDButton.hpp>
#include <LMDWave.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCont.hpp>
#include <LMDFillObject.hpp>
#include <LMDGradient.hpp>
#include <LMDShadow.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDTransparent.hpp>
#include <LMDBevel.hpp>
#include <LMD3DCaption.hpp>
#include <LMDFXCaption.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDCaption.hpp>
#include <LMDSmallBar.hpp>
#include <LMDGraph.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcpgetcore
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDCPGetDateTimeFormat(System::UnicodeString &format);
extern DELPHI_PACKAGE void __fastcall LMDComLoadCustomColorList(System::TObject* IniFile, const System::UnicodeString Section, System::Classes::TStrings* aList);
extern DELPHI_PACKAGE void __fastcall LMDComSaveCustomColorList(System::TObject* IniFile, const System::UnicodeString Section, System::Classes::TStrings* aList);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetBitmap(Vcl::Graphics::TBitmap* aBitmap);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetBitmapEffectObject(Lmdbitmapeffectobject::TLMDBitmapEffectObject* aBitmapObject);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDCPGetColor(System::Uitypes::TColor aColor, System::Classes::TStrings* aStrings = (System::Classes::TStrings*)(0x0));
extern DELPHI_PACKAGE bool __fastcall LMDCPGetHTMLString(Lmdclass::TLMDHTMLString &Value);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetFont(Vcl::Graphics::TFont* aFont);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetStrings(System::Classes::TStrings* aList)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDCPGetFont3D(Lmd3dcaption::TLMD3DCaption* aFont3D);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetGlyphTextLayout(Lmdglyphtextlayout::TLMDGlyphTextLayout* aLayout);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetBevel(Lmdbevel::TLMDBevel* aBevel);
extern DELPHI_PACKAGE Lmdgraph::TLMDBitmapStyle __fastcall LMDCPGetBitmapStyle(Lmdgraph::TLMDBitmapStyle aBitmapStyle);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetButtonLayout(Lmdbuttonlayout::TLMDButtonLayout* aLayout);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetFillObject(Lmdfillobject::TLMDFillObject* aFillObject);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetFontFx(Lmdfxcaption::TLMDFxCaption* aFontFx);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetGradient(Lmdgradient::TLMDGradient* aGradient);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetSmallBar(Lmdsmallbar::TLMDSmallBar* aSmBarOptions);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetTransparent(Lmdtransparent::TLMDTransparent* aTransparent);
extern DELPHI_PACKAGE bool __fastcall LMDCPGetSettingEditor(System::Classes::TPersistent* aObject);
}	/* namespace Plmdcpgetcore */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCPGETCORE)
using namespace Plmdcpgetcore;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcpgetcoreHPP
