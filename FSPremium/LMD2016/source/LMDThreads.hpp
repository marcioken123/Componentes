// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThreads.pas' rev: 34.00 (Windows)

#ifndef LmdthreadsHPP
#define LmdthreadsHPP

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
#include <intfLMDBase.hpp>
#include <LMDProcs.hpp>
#include <LMDUnicode.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthreads
{
//-- forward type declarations -----------------------------------------------
__interface DELPHIINTERFACE ILMDSyncroObject;
typedef System::DelphiInterface<ILMDSyncroObject> _di_ILMDSyncroObject;
class DELPHICLASS TLMDHandledObject;
class DELPHICLASS TLMDCriticalSection;
class DELPHICLASS TLMDEvent;
class DELPHICLASS TLMDMutex;
class DELPHICLASS TLMDSemaphore;
class DELPHICLASS TLMDThreadBuffer;
//-- type declarations -------------------------------------------------------
__interface ILMDSyncroObject  : public System::IInterface 
{
	virtual void __fastcall GraspIt() = 0 ;
	virtual void __fastcall ReleaseIt() = 0 ;
};

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHandledObject : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	int FLastOSError;
	NativeUInt FHandle;
	
public:
	Lmdtypes::TLMDWaitStatus __fastcall WaitFor(unsigned AWaitTime);
	__property int LastOSError = {read=FLastOSError, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDHandledObject() : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDHandledObject() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCriticalSection : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	_RTL_CRITICAL_SECTION FCriticalSection;
	
public:
	__fastcall TLMDCriticalSection();
	__fastcall virtual ~TLMDCriticalSection();
	bool __fastcall TryEnter();
	void __fastcall GraspIt();
	void __fastcall ReleaseIt();
	void __fastcall Enter();
	void __fastcall Leave();
private:
	void *__ILMDSyncroObject;	// ILMDSyncroObject 
	
public:
	operator ILMDSyncroObject*(void) { return (ILMDSyncroObject*)&__ILMDSyncroObject; }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEvent : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	/* TObject.Create */ inline __fastcall TLMDEvent() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEvent() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMutex : public TLMDHandledObject
{
	typedef TLMDHandledObject inherited;
	
public:
	__fastcall TLMDMutex(Winapi::Windows::PSecurityAttributes ASecAttr, bool AInitialOwner, System::WideChar * AName)/* overload */;
	__fastcall TLMDMutex(System::LongBool AInitialOwner, System::WideChar * AName)/* overload */;
	__fastcall TLMDMutex(System::LongBool AInitialOwner)/* overload */;
	void __fastcall GraspIt();
	void __fastcall ReleaseIt();
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDMutex() { }
	
private:
	void *__ILMDSyncroObject;	// ILMDSyncroObject 
	
public:
	operator ILMDSyncroObject*(void) { return (ILMDSyncroObject*)&__ILMDSyncroObject; }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSemaphore : public TLMDHandledObject
{
	typedef TLMDHandledObject inherited;
	
public:
	__fastcall TLMDSemaphore(int AInitCount, int AMaxCount);
	__fastcall virtual ~TLMDSemaphore();
	void __fastcall ReleaseIt(int AReleaseCount);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDThreadBuffer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FBufInit;
	int FBufSize;
	Lmdtypes::TPointerList *FBuffer;
	int FReadPoint;
	int FWritePoint;
	NativeUInt FEntriesFree;
	NativeUInt FEntriesUsed;
	NativeUInt FCriticalMutex;
	int FEntryCountFree;
	int FEntryCountUsed;
	
protected:
	void __fastcall SetSize(int AValue);
	bool __fastcall ControlledWait(NativeUInt Semaphore);
	
public:
	void __fastcall ResetState();
	__fastcall virtual ~TLMDThreadBuffer();
	bool __fastcall PutItem(System::TObject* AItem);
	System::TObject* __fastcall GetItem();
	bool __fastcall GetFreeSlots(int &AFree);
	bool __fastcall GetUsedSlots(int &AUsed);
	__property int Size = {read=FBufSize, write=SetSize, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDThreadBuffer() : System::TObject() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdthreads */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHREADS)
using namespace Lmdthreads;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthreadsHPP
