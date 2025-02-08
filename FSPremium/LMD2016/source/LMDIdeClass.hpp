// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeClass.pas' rev: 31.00 (Windows)

#ifndef LmdideclassHPP
#define LmdideclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.GraphUtil.hpp>
#include <LMDIdeCst.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdideclass
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef Vcl::Graphutil::TGradientDirection TLMDGradientDirection;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDGradientFillCanvas(Vcl::Graphics::TCanvas* const ACanvas, const System::Uitypes::TColor AStartColor, const System::Uitypes::TColor AEndColor, const System::Types::TRect &ARect, const Vcl::Graphutil::TGradientDirection Direction);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDGetHighLightColor(const System::Uitypes::TColor Color, int Luminance = 0x13);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDGetShadowColor(const System::Uitypes::TColor Color, int Luminance = 0xffffffce);
}	/* namespace Lmdideclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDECLASS)
using namespace Lmdideclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdideclassHPP
