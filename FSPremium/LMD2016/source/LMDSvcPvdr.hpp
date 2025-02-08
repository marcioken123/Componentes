// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSvcPvdr.pas' rev: 34.00 (Windows)

#ifndef LmdsvcpvdrHPP
#define LmdsvcpvdrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDRTLConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsvcpvdr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDServiceProvider;
class DELPHICLASS ILMDServicesNotifier;
class DELPHICLASS TLMDServices;
class DELPHICLASS TLMDNotifiers;
class DELPHICLASS TLMDMembers;
class DELPHICLASS TLMDServiceProvider;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDServiceProvider : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDServiceProvider(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDServiceProvider(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDServiceProvider(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDServiceProvider(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDServiceProvider(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDServiceProvider(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDServiceProvider(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDServiceProvider(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDServiceProvider(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDServiceProvider(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDServiceProvider(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDServiceProvider(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDServiceProvider() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDServicesNotifier : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall AfterMemberAddition(System::TObject* AMember) = 0 ;
	virtual void __fastcall BeforeMemberRemoving(System::TObject* AMember) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDServicesNotifier() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDServicesNotifier() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDServices : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FItems;
	TLMDServiceProvider* FProvider;
	
public:
	__fastcall TLMDServices(TLMDServiceProvider* AProvider);
	__fastcall virtual ~TLMDServices();
	void __fastcall Clear();
	void __fastcall RegisterService(System::TObject* AService);
	void __fastcall UnregisterService(System::TObject* AService);
	bool __fastcall IsRegistered(System::TClass AClass);
	System::TObject* __fastcall Find(System::TClass AClass);
	System::TObject* __fastcall Get(System::TClass AClass);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNotifiers : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FItems;
	TLMDServiceProvider* FProvider;
	
public:
	__fastcall TLMDNotifiers(TLMDServiceProvider* AProvider);
	__fastcall virtual ~TLMDNotifiers();
	void __fastcall Clear();
	void __fastcall RegisterNotifier(System::TObject* ANotifier);
	void __fastcall UnregisterNotifier(System::TObject* ANotifier);
	System::Classes::TList* __fastcall GetList(System::TClass AClass);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMembers : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::TObject* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	System::Classes::TList* FItems;
	TLMDServiceProvider* FProvider;
	int __fastcall GetCount();
	System::TObject* __fastcall GetItems(int AIndex);
	
public:
	__fastcall TLMDMembers(TLMDServiceProvider* AProvider);
	__fastcall virtual ~TLMDMembers();
	void __fastcall Clear();
	void __fastcall RegisterMember(System::TObject* AMember);
	void __fastcall UnregisterMember(System::TObject* AMember);
	bool __fastcall IsMember(System::TObject* AObject);
	System::Classes::TList* __fastcall GetList(System::TClass AClass);
	System::TObject* __fastcall FindFirst(System::TClass AClass);
	__property int Count = {read=GetCount, nodefault};
	__property System::TObject* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDServiceProvider : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDServices* FServices;
	TLMDNotifiers* FNotifiers;
	TLMDMembers* FMembers;
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage();
	
public:
	__fastcall virtual TLMDServiceProvider(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDServiceProvider();
	__property TLMDServices* Services = {read=FServices};
	__property TLMDNotifiers* Notifiers = {read=FNotifiers};
	__property TLMDMembers* Members = {read=FMembers};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDTryGetService(TLMDServiceProvider* AProvider, System::TClass AClass, /* out */ void *AService);
extern DELPHI_PACKAGE void __fastcall _RegisterOnce(void);
}	/* namespace Lmdsvcpvdr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSVCPVDR)
using namespace Lmdsvcpvdr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsvcpvdrHPP
