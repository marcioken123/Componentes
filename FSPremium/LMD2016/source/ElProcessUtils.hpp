// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElProcessUtils.pas' rev: 31.00 (Windows)

#ifndef ElprocessutilsHPP
#define ElprocessutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.TlHelp32.hpp>
#include <LMDTypes.hpp>
#include <LMDObjectList.hpp>
#include <LMDSysIn.hpp>
#include <ElVCLUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elprocessutils
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TProcessInfo;
class DELPHICLASS TModuleInformation;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TProcessInfo : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString ModuleName;
	int PID;
	int ThreadCount;
	int PriorityCls;
	bool __fastcall DiffersFrom(TProcessInfo* Source);
public:
	/* TObject.Create */ inline __fastcall TProcessInfo(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TProcessInfo(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TModuleInformation : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString ModuleName;
	System::UnicodeString ModulePath;
	NativeUInt hModule;
public:
	/* TObject.Create */ inline __fastcall TModuleInformation(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TModuleInformation(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall IsUsePSAPI(void);
extern DELPHI_PACKAGE NativeUInt __fastcall GetProcessHandle(System::UnicodeString ModuleName);
extern DELPHI_PACKAGE bool __fastcall ProcessExists(System::UnicodeString ModuleName);
extern DELPHI_PACKAGE void __fastcall CloseProcess(System::UnicodeString ModuleName, bool Forced);
extern DELPHI_PACKAGE void __fastcall FillProcessList(Lmdobjectlist::TLMDObjectList* L);
extern DELPHI_PACKAGE void __fastcall FillModuleList(unsigned PID, Lmdobjectlist::TLMDObjectList* L);
}	/* namespace Elprocessutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELPROCESSUTILS)
using namespace Elprocessutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElprocessutilsHPP
