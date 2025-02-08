// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElSBHook.pas' rev: 31.00 (Windows)

#ifndef ElsbhookHPP
#define ElsbhookHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDTypes.hpp>
#include <LMDObjectList.hpp>
#include <ElProcessUtils.hpp>
#include <ElVCLUtils.hpp>
#include <LMDInprocHookAPI.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elsbhook
{
//-- forward type declarations -----------------------------------------------
struct TELSBSyncScrollInfo;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TELSBSyncScrollInfo
{
public:
	int BarFlag;
	tagSCROLLINFO *pSI;
	System::LongBool bRedraw;
};
#pragma pack(pop)


typedef TELSBSyncScrollInfo *PELSBSyncScrollInfo;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE unsigned WM_ELSCROLLBAR;
static const System::Int8 ELSB_BASE = System::Int8(0x0);
static const System::Int8 ELSB_GETCONTROLLER = System::Int8(0x1);
static const System::Int8 ELSB_PAINT = System::Int8(0x2);
static const System::Int8 ELSB_SYNCSI = System::Int8(0x3);
extern DELPHI_PACKAGE bool __fastcall IsHookImpExp(void);
extern DELPHI_PACKAGE bool __fastcall SystemScrollBarHooked(void);
}	/* namespace Elsbhook */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSBHOOK)
using namespace Elsbhook;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElsbhookHPP
