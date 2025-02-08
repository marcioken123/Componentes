// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDArrayUtils.pas' rev: 34.00 (Windows)

#ifndef LmdarrayutilsHPP
#define LmdarrayutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <System.Math.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdarrayutils
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDArrayOperation : unsigned char { aoAssign, aoCompare, aoSwap, aoSetSize, aoGetSize };

typedef int __fastcall (__closure *TLMDArrayFunc)(int AIdx1, int AIdx2, TLMDArrayOperation AOp);

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDCharArrayCopy(Lmdtypes::TLMDCharArray &ASrc, int AStart, Lmdtypes::TLMDCharArray &ADst, int ADstStart, int ACount)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDCharArrayCopy(const Lmdtypes::TLMDString ASrc, int AStart, Lmdtypes::TLMDCharArray &ADst, int ADstStart, int ACount)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDArrayCopy(int AStart, int ADstStart, int ALength, TLMDArrayFunc AOps);
extern DELPHI_PACKAGE void __fastcall LMDArrayDelete(int AIdx, int ACount, TLMDArrayFunc AOps);
extern DELPHI_PACKAGE void __fastcall LMDArrayShortSort(int AStart, int AEnd, TLMDArrayFunc AOps);
extern DELPHI_PACKAGE void __fastcall LMDArrayInsert(int AIdx, int ACount, TLMDArrayFunc AOps);
extern DELPHI_PACKAGE int __fastcall LMDArrayLowerBound(TLMDArrayFunc AOps)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDArrayLowerBound(int AStart, int AEnd, TLMDArrayFunc AOps)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDArrayUpperBound(TLMDArrayFunc AOps)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDArrayUpperBound(int AStart, int AEnd, TLMDArrayFunc AOps)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDIntArrayCopy(Lmdtypes::TLMDIntArray &ASrc, int AStart, Lmdtypes::TLMDIntArray &ADst, int ADstStart, int ACount);
extern DELPHI_PACKAGE void __fastcall LMDIntArrayDelete(int AIdx, int ACount, Lmdtypes::TLMDIntArray &Arr);
extern DELPHI_PACKAGE void __fastcall LMDIntArrayInsertOne(int AIdx, int AIns, Lmdtypes::TLMDIntArray &Arr);
extern DELPHI_PACKAGE void __fastcall LMDIntArrayInsert(int AIdx, int ACount, Lmdtypes::TLMDIntArray &Arr);
extern DELPHI_PACKAGE int __fastcall LMDIntArrayLowerBound(int AStart, int AEnd, int AVal, const Lmdtypes::TLMDIntArray Arr)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDIntArrayUpperBound(int AStart, int AEnd, int AVal, const Lmdtypes::TLMDIntArray Arr)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDIntArrayLowerBound(int AVal, const Lmdtypes::TLMDIntArray Arr)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDIntArrayUpperBound(int AVal, const Lmdtypes::TLMDIntArray Arr)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDIntArrayBinarySearch(int AStart, int AEnd, int AVal, const Lmdtypes::TLMDIntArray Arr)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDIntArrayBinarySearch(int AVal, const Lmdtypes::TLMDIntArray Arr)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDIntArrayShortSort(int AStart, int AEnd, Lmdtypes::TLMDIntArray Arr);
}	/* namespace Lmdarrayutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDARRAYUTILS)
using namespace Lmdarrayutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdarrayutilsHPP
