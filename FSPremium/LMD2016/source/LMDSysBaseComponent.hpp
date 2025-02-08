// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysBaseComponent.pas' rev: 31.00 (Windows)

#ifndef LmdsysbasecomponentHPP
#define LmdsysbasecomponentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysLog.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysbasecomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysBaseComponent;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDSysComponentOnProgress)(System::TObject* aSender, System::UnicodeString aCaption, int aMax, int aPosition);

class PASCALIMPLEMENTATION TLMDSysBaseComponent : public Lmdsysbase::TLMDSysComponent
{
	typedef Lmdsysbase::TLMDSysComponent inherited;
	
private:
	Lmdsyslog::TLMDSysLog* FLog;
	bool FRetrieved;
	bool FAutoRetrieve;
	System::Classes::TNotifyEvent FOnRefresh;
	System::Classes::TNotifyEvent FOnAfterRefresh;
	TLMDSysComponentOnProgress FOnProgress;
	void __fastcall SetLog(Lmdsyslog::TLMDSysLog* aLog);
	
protected:
	Lmdsysobject::TLMDSysObject* FSysObject;
	int FRefCount;
	HIDESBASE HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	HIDESBASE int __stdcall _AddRef(void);
	HIDESBASE int __stdcall _Release(void);
	__property Lmdsysobject::TLMDSysObject* SysObject = {read=FSysObject, write=FSysObject};
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall RefreshIt(void);
	void __fastcall DoLog(System::TObject* Sender, System::UnicodeString propertyDescription, System::UnicodeString oldValue, System::UnicodeString newValue, System::TDateTime datetime);
	void __fastcall InitSysObject(void);
	virtual bool __fastcall GetRetrieved(void);
	void __fastcall SetRetrieved(void);
	
public:
	virtual void __fastcall Loaded(void);
	__fastcall virtual TLMDSysBaseComponent(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysBaseComponent(void);
	void __fastcall Refresh(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall BeforeDestruction(void);
	__classmethod virtual System::TObject* __fastcall NewInstance();
	__property int RefCount = {read=FRefCount, nodefault};
	virtual int __fastcall GetElementCount(void);
	virtual System::TObject* __fastcall GetElement(int index);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	void __fastcall DoProgress(System::UnicodeString aCaption, int aMax, int aPosition);
	__property bool Retrieved = {read=GetRetrieved, stored=false, nodefault};
	__property Lmdsyslog::TLMDSysLog* SysLog = {read=FLog, write=SetLog};
	
__published:
	__property bool AutoRetrieve = {read=FAutoRetrieve, write=FAutoRetrieve, default=0};
	__property System::Classes::TNotifyEvent OnRefresh = {read=FOnRefresh, write=FOnRefresh};
	__property System::Classes::TNotifyEvent OnAfterRefresh = {read=FOnAfterRefresh, write=FOnAfterRefresh};
	__property TLMDSysComponentOnProgress OnProgress = {read=FOnProgress, write=FOnProgress};
private:
	void *__ILMDSysDescriptor;	// Lmdsysbase::ILMDSysDescriptor 
	void *__ILMDSysContainer;	// Lmdsysbase::ILMDSysContainer 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {059155C7-51D6-4EAF-8795-76F40E6AABD3}
	operator Lmdsysbase::_di_ILMDSysDescriptor()
	{
		Lmdsysbase::_di_ILMDSysDescriptor intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysDescriptor*(void) { return (Lmdsysbase::ILMDSysDescriptor*)&__ILMDSysDescriptor; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D8DECF0C-3DE0-4E44-AD38-F022380E2970}
	operator Lmdsysbase::_di_ILMDSysContainer()
	{
		Lmdsysbase::_di_ILMDSysContainer intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysContainer*(void) { return (Lmdsysbase::ILMDSysContainer*)&__ILMDSysContainer; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000000-0000-0000-C000-000000000046}
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator System::IInterface*(void) { return (System::IInterface*)&__ILMDSysDescriptor; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysbasecomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSBASECOMPONENT)
using namespace Lmdsysbasecomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysbasecomponentHPP
