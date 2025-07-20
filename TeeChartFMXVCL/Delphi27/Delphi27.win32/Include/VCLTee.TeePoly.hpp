// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePoly.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepolyHPP
#define Vcltee_TeepolyHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepoly
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef System::Extended Float;

typedef System::StaticArray<System::Extended, 20> TDegreeVector;

typedef System::StaticArray<System::StaticArray<System::Extended, 20>, 20> TPolyMatrix;

typedef System::DynamicArray<System::Extended> TVector;

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MaxPolyDegree = System::Int8(0x14);
extern DELPHI_PACKAGE System::Extended __fastcall CalcFitting(int PolyDegree, const TDegreeVector &Answer, const System::Extended XWert);
extern DELPHI_PACKAGE void __fastcall PolyFitting(int NumPoints, int PolyDegree, const TVector X, const TVector Y, TDegreeVector &Answer);
}	/* namespace Teepoly */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPOLY)
using namespace Vcltee::Teepoly;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepolyHPP
