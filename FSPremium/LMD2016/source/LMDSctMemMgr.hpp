// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctMemMgr.pas' rev: 31.00 (Windows)

#ifndef LmdsctmemmgrHPP
#define LmdsctmemmgrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctmemmgr
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDItemProc)(System::TObject* AItem);

typedef void __fastcall (__closure *TLMDEnumProc)(TLMDItemProc AItemProc);

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall InternalSetObjDestroyedProc(TLMDItemProc AObjDestroyed);
extern DELPHI_PACKAGE void __fastcall InternalObjectWrapped(System::TObject* AObject, TLMDEnumProc AEnumerator);
}	/* namespace Lmdsctmemmgr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTMEMMGR)
using namespace Lmdsctmemmgr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctmemmgrHPP
