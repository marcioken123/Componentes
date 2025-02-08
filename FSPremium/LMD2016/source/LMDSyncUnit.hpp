// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSyncUnit.pas' rev: 31.00 (Windows)

#ifndef LmdsyncunitHPP
#define LmdsyncunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <System.SyncObjs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyncunit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSyncExec;
class DELPHICLASS TLMDSyncThread;
class DELPHICLASS TLMDSyncObject;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSyncExec : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FID;
	System::TObject* FSynchronizeException;
	System::Classes::TThreadMethod FMethod;
	
public:
	bool Cancel;
	bool FreeOnExec;
public:
	/* TObject.Create */ inline __fastcall TLMDSyncExec(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSyncExec(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSyncThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
public:
	HIDESBASE void __fastcall Synchronize(System::Classes::TThreadMethod Method);
public:
	/* TThread.Create */ inline __fastcall TLMDSyncThread(void)/* overload */ : System::Classes::TThread() { }
	/* TThread.Create */ inline __fastcall TLMDSyncThread(bool CreateSuspended)/* overload */ : System::Classes::TThread(CreateSuspended) { }
	/* TThread.Destroy */ inline __fastcall virtual ~TLMDSyncThread(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSyncObject : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	HWND SyncWindow;
	void __fastcall FreeSyncWindow(void);
	void __fastcall CheckSyncWindow(void);
	
public:
	bool bServerMode;
	__fastcall TLMDSyncObject(void);
	__fastcall virtual ~TLMDSyncObject(void);
	void __fastcall Synchronize(System::Classes::TThreadMethod Method);
	void __fastcall PostSynchronize(TLMDSyncExec* SE, System::Classes::TThreadMethod Method, bool bFree = true);
	bool __fastcall CheckOverhead(void);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDSyncObject* GlobalLMDSyncObject;
extern DELPHI_PACKAGE int aGlobalSem;
extern DELPHI_PACKAGE System::Sysutils::TMultiReadExclusiveWriteSynchronizer* Synchronizer;
extern DELPHI_PACKAGE System::Syncobjs::TCriticalSection* CriticalSection;
extern DELPHI_PACKAGE void __fastcall ProcessSyncMessages(void);
extern DELPHI_PACKAGE void __fastcall GlobalSynchronize(System::Classes::TThreadMethod Method);
extern DELPHI_PACKAGE void __fastcall LMDProcessMessages(void);
}	/* namespace Lmdsyncunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYNCUNIT)
using namespace Lmdsyncunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyncunitHPP
