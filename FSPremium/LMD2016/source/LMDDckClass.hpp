// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDckClass.pas' rev: 31.00 (Windows)

#ifndef LmddckclassHPP
#define LmddckclassHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.GraphUtil.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddckclass
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef Vcl::Graphutil::TGradientDirection TLMDGradientDirection;

typedef Vcl::Controls::TAlign TLMDSide;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<TLMDSide, 4> LMDOppsiteSide;
extern DELPHI_PACKAGE void __fastcall LMDGradientFillCanvas(Vcl::Graphics::TCanvas* const ACanvas, const System::Uitypes::TColor AStartColor, const System::Uitypes::TColor AEndColor, const System::Types::TRect &ARect, const Vcl::Graphutil::TGradientDirection Direction);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDGetHighLightColor(const System::Uitypes::TColor Color, int Luminance = 0x13);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDGetShadowColor(const System::Uitypes::TColor Color, int Luminance = 0xffffffce);
extern DELPHI_PACKAGE int __fastcall LMDGetRectSide(const System::Types::TRect &ARect, TLMDSide ASide);
extern DELPHI_PACKAGE void __fastcall LMDSetRectSide(System::Types::TRect &ARect, TLMDSide ASide, int AValue);
extern DELPHI_PACKAGE void __fastcall LMDGetRectCorner(const System::Types::TRect &ARect, TLMDSide AHorz, TLMDSide AVert, int ACornerSize, System::Types::PPoint AResult);
extern DELPHI_PACKAGE void __fastcall LMDInflateRectSide(System::Types::TRect &ARect, TLMDSide ASide, int AOffset);
extern DELPHI_PACKAGE void __fastcall LMDDrawTextWithElipsis(Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString S, const System::Types::TRect &R);
extern DELPHI_PACKAGE void __fastcall LMDDrawOrientedText(Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString S, int X, int Y, const System::Types::TRect &R);
extern DELPHI_PACKAGE void __fastcall LMDDrawParentBackground(HWND AWnd, Vcl::Graphics::TCanvas* ACanvas, System::Types::PRect R);
}	/* namespace Lmddckclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDCKCLASS)
using namespace Lmddckclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddckclassHPP
