// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysServiceObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysserviceobjectHPP
#define LmdsysserviceobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDSysObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysserviceobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysServiceObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysServiceType : unsigned char { sstFileSystemDriver, sstKernelDriver, sstWin32OwnProcess, sstWin32ShareProcess, sstInteractiveProcess };

typedef System::Set<TLMDSysServiceType, TLMDSysServiceType::sstFileSystemDriver, TLMDSysServiceType::sstInteractiveProcess> TLMDSysServiceTypes;

enum DECLSPEC_DENUM TLMDSysServiceCurrentState : unsigned char { sscsContinuePending = 5, sscsPausePending, sscsPaused, sscsRunning = 4, sscsStartPending = 2, sscsStopPending, sscsStopped = 1 };

enum DECLSPEC_DENUM TLMDSysServiceStartType : unsigned char { ssstAutoStart = 2, ssstBootStart = 0, ssstDemandStart = 3, ssstdisabled, ssstSystemStart = 1 };

class PASCALIMPLEMENTATION TLMDSysServiceObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	System::UnicodeString FDisplayName;
	System::UnicodeString FServiceName;
	System::UnicodeString FBinaryPath;
	System::UnicodeString FLoadOrderGroup;
	System::UnicodeString FServiceStartName;
	unsigned FTagId;
	TLMDSysServiceTypes FServiceTypes;
	TLMDSysServiceCurrentState FCurrentState;
	TLMDSysServiceStartType FStartType;
	void __fastcall SetDummyDWord(unsigned aValue);
	void __fastcall SetDummyString(const System::UnicodeString aValue);
	void __fastcall SetDummyTypes(TLMDSysServiceTypes aValue);
	void __fastcall SetDummyState(TLMDSysServiceCurrentState aValue);
	void __fastcall SetDummyStartType(TLMDSysServiceStartType aValue);
	System::UnicodeString __fastcall ServiceTypeToString(const TLMDSysServiceType AType);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	System::UnicodeString __fastcall ServiceTypesToString(void);
	System::UnicodeString __fastcall CurrentStateToString(void);
	System::UnicodeString __fastcall StartTypeToString(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	
__published:
	__property System::UnicodeString DisplayName = {read=FDisplayName, write=SetDummyString};
	__property System::UnicodeString ServiceName = {read=FServiceName, write=SetDummyString};
	__property System::UnicodeString BinaryPath = {read=FBinaryPath, write=SetDummyString};
	__property System::UnicodeString LoadOrderGroup = {read=FLoadOrderGroup, write=SetDummyString};
	__property System::UnicodeString ServiceStartName = {read=FServiceStartName, write=SetDummyString};
	__property unsigned TagId = {read=FTagId, write=SetDummyDWord, nodefault};
	__property TLMDSysServiceTypes ServiceTypes = {read=FServiceTypes, write=SetDummyTypes, nodefault};
	__property TLMDSysServiceCurrentState CurrentState = {read=FCurrentState, write=SetDummyState, nodefault};
	__property TLMDSysServiceStartType StartType = {read=FStartType, write=SetDummyStartType, nodefault};
public:
	/* TLMDSysObject.Create */ inline __fastcall virtual TLMDSysServiceObject(void) : Lmdsysobject::TLMDSysObject() { }
	/* TLMDSysObject.Destroy */ inline __fastcall virtual ~TLMDSysServiceObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysserviceobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSSERVICEOBJECT)
using namespace Lmdsysserviceobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysserviceobjectHPP
