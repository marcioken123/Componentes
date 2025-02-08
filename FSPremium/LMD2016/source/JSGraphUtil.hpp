// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSGraphUtil.pas' rev: 31.00 (Windows)

#ifndef JsgraphutilHPP
#define JsgraphutilHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsgraphutil
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall ValidPicture(Vcl::Graphics::TPicture* APicture);
extern DELPHI_PACKAGE bool __fastcall ValidIcon(Vcl::Graphics::TIcon* AIcon);
extern DELPHI_PACKAGE void __fastcall RoundRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, int aCX, int aCY, const System::Uitypes::TColor aColor = (System::Uitypes::TColor)(0x1fffffff), const Vcl::Graphics::TBrushStyle aBrushStyle = (Vcl::Graphics::TBrushStyle)(0x1));
}	/* namespace Jsgraphutil */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSGRAPHUTIL)
using namespace Jsgraphutil;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsgraphutilHPP
