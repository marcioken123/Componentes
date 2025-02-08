// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesGraphics.pas' rev: 31.00 (Windows)

#ifndef LmdthemesgraphicsHPP
#define LmdthemesgraphicsHPP

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

namespace Lmdthemesgraphics
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall DrawRect(HDC DestDC, int X, int Y, HDC SrcDC, int SrcX, int SrcY, int SrcW, int SrcH, System::Uitypes::TColor TransparentColor = (System::Uitypes::TColor)(0x1fffffff));
extern DELPHI_PACKAGE void __fastcall StretchIcon(HICON Icon, HDC DC, int X, int Y, int W, int H);
extern DELPHI_PACKAGE void __fastcall StretchRect(HDC DestDC, int X, int Y, int W, int H, HDC SrcDC, int SrcX, int SrcY, int SrcW, int SrcH, int LM, int TM, int RM, int BM, System::Uitypes::TColor TransparentColor = (System::Uitypes::TColor)(0x1fffffff), bool BorderOnly = false);
extern DELPHI_PACKAGE void __fastcall TileRect(HDC DestDC, int X, int Y, int W, int H, HDC SrcDC, int SrcX, int SrcY, int SrcW, int SrcH, int LM, int TM, int RM, int BM, System::Uitypes::TColor TransparentColor = (System::Uitypes::TColor)(0x1fffffff), bool BorderOnly = false);
extern DELPHI_PACKAGE void __fastcall AlphaDrawRect(HDC DestDC, int X, int Y, HDC SrcDC, int SrcX, int SrcY, int SrcW, int SrcH);
extern DELPHI_PACKAGE void __fastcall AlphaStretchRect(HDC DestDC, int X, int Y, int W, int H, HDC SrcDC, int SrcX, int SrcY, int SrcW, int SrcH, int LM, int TM, int RM, int BM, bool BorderOnly = false);
extern DELPHI_PACKAGE void __fastcall FixAlphaImage(Vcl::Graphics::TBitmap* Image);
}	/* namespace Lmdthemesgraphics */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESGRAPHICS)
using namespace Lmdthemesgraphics;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemesgraphicsHPP
