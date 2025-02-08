// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDConversion.pas' rev: 31.00 (Windows)

#ifndef LmdconversionHPP
#define LmdconversionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdconversion
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
static const System::Word LMDTwipsPerInch = System::Word(0x5a0);
#define MillimetersPerInch  (2.540000E+01)
static const System::Int8 PointsPerInch = System::Int8(0x48);
static const System::Int8 TwipsPerPoints = System::Int8(0x14);
static const System::Int8 InchFactor = System::Int8(0x64);
extern DELPHI_PACKAGE double __fastcall LMDPointsToPixelsX(double aValue);
extern DELPHI_PACKAGE double __fastcall LMDMillimetersToPixelsX(double aValue);
extern DELPHI_PACKAGE double __fastcall LMDInchesToPixelsX(double aValue);
extern DELPHI_PACKAGE int __fastcall LMDTwipsToPixelsX(int aValue);
extern DELPHI_PACKAGE int __fastcall LMDTwipsToPixels(int aValue, int aFactor);
extern DELPHI_PACKAGE int __fastcall LMDToPixelsX(double aValue, Lmdtypes::TLMDUnits Units)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDToPixelsX(int aValue, Lmdtypes::TLMDUnits Units)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDPixelsXToTwips(int aValue);
extern DELPHI_PACKAGE int __fastcall LMDPixelsXTo(int aValue, Lmdtypes::TLMDUnits Units);
extern DELPHI_PACKAGE double __fastcall LMDTwipsToPoints(double aValue);
extern DELPHI_PACKAGE double __fastcall LMDTwipsToMillimeters(double aValue);
extern DELPHI_PACKAGE double __fastcall LMDTwipsToInches(double aValue);
extern DELPHI_PACKAGE int __fastcall LMDPointsToTwips(double aValue)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDMillimetersToTwips(double aValue)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDInchesToTwips(double aValue)/* overload */;
extern DELPHI_PACKAGE double __fastcall LMDMillimetersToInches(double aValue);
extern DELPHI_PACKAGE double __fastcall LMDInchesToMillimeters(double aValue);
extern DELPHI_PACKAGE double __fastcall LMDPointsToMillimeters(double aValue);
extern DELPHI_PACKAGE double __fastcall LMDPointsToInches(double aValue);
extern DELPHI_PACKAGE double __fastcall LMDInchesToPoints(double aValue);
extern DELPHI_PACKAGE double __fastcall LMDMillimetersToPoints(double aValue);
extern DELPHI_PACKAGE int __fastcall LMDToTwips(double aValue, Lmdtypes::TLMDUnits Units)/* overload */;
extern DELPHI_PACKAGE double __fastcall LMDTwipsTo(int aValue, Lmdtypes::TLMDUnits Units);
extern DELPHI_PACKAGE int __fastcall LMDToPoints(int aValue, Lmdtypes::TLMDUnits Units);
extern DELPHI_PACKAGE int __fastcall LMDPointsTo(int aValue, Lmdtypes::TLMDUnits Units);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDUnitsToString(Lmdtypes::TLMDUnits Units);
extern DELPHI_PACKAGE double __fastcall LMDConvertUnits(double aValue, Lmdtypes::TLMDUnits FromUnits, Lmdtypes::TLMDUnits ToUnits);
}	/* namespace Lmdconversion */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCONVERSION)
using namespace Lmdconversion;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdconversionHPP
