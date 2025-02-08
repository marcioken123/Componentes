// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebConfig.pas' rev: 31.00 (Windows)

#ifndef LmdwebconfigHPP
#define LmdwebconfigHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDURLSupp.hpp>
#include <Winapi.UrlMon.hpp>
#include <LMDWebBase.hpp>
#include <System.IniFiles.hpp>
#include <System.Win.Registry.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebconfig
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMasterWebComponent;
class DELPHICLASS TLMDWebConfig;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMasterWebComponent : public Lmdwebbase::TLMDWebComponent
{
	typedef Lmdwebbase::TLMDWebComponent inherited;
	
public:
	virtual void __fastcall UpdateFromConfig(void) = 0 ;
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDMasterWebComponent(System::Classes::TComponent* AOwner) : Lmdwebbase::TLMDWebComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDMasterWebComponent(void) { }
	
};


class PASCALIMPLEMENTATION TLMDWebConfig : public Lmdwebbase::TLMDWebComponent
{
	typedef Lmdwebbase::TLMDWebComponent inherited;
	
private:
	System::UnicodeString FReferer;
	System::UnicodeString FURL;
	System::UnicodeString FUserName;
	System::UnicodeString FPassword;
	System::Classes::TStringList* FAcceptTypes;
	TLMDMasterWebComponent* FMasterComponent;
	Lmdurlsupp::TLMDInternetOptions* FInternetOptions;
	System::Classes::TStringList* FPostParams;
	void __fastcall SendUpdate(void);
	void __fastcall SetAcceptTypes(System::Classes::TStringList* const Value);
	void __fastcall SetPassword(const System::UnicodeString Value);
	void __fastcall SetReferer(const System::UnicodeString Value);
	void __fastcall SetURL(const System::UnicodeString Value);
	void __fastcall SetUserName(const System::UnicodeString Value);
	void __fastcall SetMasterComponent(TLMDMasterWebComponent* const Value);
	void __fastcall SetInternetOptions(Lmdurlsupp::TLMDInternetOptions* const Value);
	void __fastcall SetPostParams(System::Classes::TStringList* const Value);
	Lmdurlsupp::TLMDInternetOptionsInteractiveEvent __fastcall GetOnInteractiveEvent(void);
	void __fastcall SetOnInteractiveEvent(const Lmdurlsupp::TLMDInternetOptionsInteractiveEvent Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDWebConfig(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWebConfig(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall SaveToIniFile(System::UnicodeString FileName);
	void __fastcall LoadFromIniFile(System::UnicodeString FileName);
	void __fastcall SaveToRegistry(System::UnicodeString RegistryPath);
	void __fastcall LoadFromRegistry(System::UnicodeString RegistryPath);
	__property TLMDMasterWebComponent* MasterComponent = {read=FMasterComponent, write=SetMasterComponent};
	
__published:
	__property System::Classes::TStringList* AcceptTypes = {read=FAcceptTypes, write=SetAcceptTypes, stored=true};
	__property System::UnicodeString URL = {read=FURL, write=SetURL};
	__property System::UnicodeString UserName = {read=FUserName, write=SetUserName};
	__property System::UnicodeString Password = {read=FPassword, write=SetPassword};
	__property System::UnicodeString Referer = {read=FReferer, write=SetReferer};
	__property System::Classes::TStringList* PostParams = {read=FPostParams, write=SetPostParams};
	__property Lmdurlsupp::TLMDInternetOptions* InternetOptions = {read=FInternetOptions, write=SetInternetOptions};
	__property Lmdurlsupp::TLMDInternetOptionsInteractiveEvent OnInteractiveEvent = {read=GetOnInteractiveEvent, write=SetOnInteractiveEvent};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebconfig */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBCONFIG)
using namespace Lmdwebconfig;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebconfigHPP
