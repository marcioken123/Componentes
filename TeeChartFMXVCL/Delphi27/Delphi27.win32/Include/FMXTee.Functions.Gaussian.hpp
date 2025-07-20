// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Functions.Gaussian.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Functions_GaussianHPP
#define Fmxtee_Functions_GaussianHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Functions
{
namespace Gaussian
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
}	/* namespace Gaussian */
}	/* namespace Functions */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS_GAUSSIAN)
using namespace Fmxtee::Functions::Gaussian;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS)
using namespace Fmxtee::Functions;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Functions_GaussianHPP
