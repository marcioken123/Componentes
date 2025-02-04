// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sBorders.pas' rev: 27.00 (Windows)

#ifndef SbordersHPP
#define SbordersHPP

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
#include <System.SysUtils.hpp>	// Pascal unit
#include <sMaskData.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sGraphUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sborders
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Types::TRect __fastcall PaintBorderFast(HDC DC, const System::Types::TRect &aRect, int MinBorderWidth, Scommondata::TsCommonData* SkinData, int State);
extern DELPHI_PACKAGE void __fastcall CopyMask(int DstX1, int DstY1, int DstX2, int DstY2, int SrcX1, int SrcY1, int SrcX2, int SrcY2, Vcl::Graphics::TBitmap* Bmp, HRGN Region, const Smaskdata::TsMaskData &MaskData, bool FillRgn = false);
extern DELPHI_PACKAGE void __fastcall PaintRgnBorder(Vcl::Graphics::TBitmap* Bmp, HRGN Region, bool Filling, const Smaskdata::TsMaskData &MaskData, int State);
}	/* namespace Sborders */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SBORDERS)
using namespace Sborders;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SbordersHPP
