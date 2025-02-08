// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctSource.pas' rev: 31.00 (Windows)

#ifndef LmdsctsourceHPP
#define LmdsctsourceHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Consts.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.TypInfo.hpp>
#include <System.StrUtils.hpp>
#include <System.RTLConsts.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDSctScripter.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctsource
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDSourceUtils;
struct TLMDSrcUtilsParam;
class DELPHICLASS TLMDSrcUtilsProc;
class DELPHICLASS TLMDSourceUtils;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDSourceUtils : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDSourceUtils(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDSourceUtils(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDSourceUtils(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDSourceUtils(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDSourceUtils(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDSourceUtils(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDSourceUtils(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDSourceUtils(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDSourceUtils(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDSourceUtils(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDSourceUtils(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDSourceUtils(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDSourceUtils(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDSrcUtilsParam
{
public:
	System::WideString Name;
	bool ByRef;
};


typedef System::DynamicArray<TLMDSrcUtilsParam> TLMDSrcUtilsParamArr;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSrcUtilsProc : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::WideString FName;
	int FParamCount;
	int FParamCapacity;
	TLMDSrcUtilsParamArr FParams;
	int FNameBeginPos;
	int FNameEndPos;
	void __fastcall AddParam(const System::WideString AName, bool AByRef);
	TLMDSrcUtilsParam __fastcall GetParam(int AIndex);
	
public:
	__property System::WideString Name = {read=FName};
	__property int NameBeginPos = {read=FNameBeginPos, nodefault};
	__property int NameEndPos = {read=FNameEndPos, nodefault};
	__property int ParamCount = {read=FParamCount, nodefault};
	__property TLMDSrcUtilsParam Param[int AIndex] = {read=GetParam};
public:
	/* TObject.Create */ inline __fastcall TLMDSrcUtilsProc(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSrcUtilsProc(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDEnsureProcRes : unsigned char { sprExist, sprCreated, sprRenamed };

enum DECLSPEC_DENUM TLMDValidateProcAction : unsigned char { vpaDoNothing, vpaResetEvent, vpaCancel };

class PASCALIMPLEMENTATION TLMDSourceUtils : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::Classes::TList* FProcs;
	Lmdsctscripter::TLMDScriptLanguage FLanguage;
	System::TObject* FTraits;
	System::Classes::TNotifyEvent FAfterRefresh;
	void __fastcall RecreateTraits(Lmdsctscripter::TLMDScriptLanguage ALang);
	void __fastcall CreateProcParams(TLMDSrcUtilsProc* AProc, System::Typinfo::PTypeInfo AEventTypeInfo);
	void __fastcall CheckProc(TLMDSrcUtilsProc* AProc, System::Typinfo::PTypeInfo AEventTypeInfo);
	void __fastcall CreateProcSrc(System::Classes::TStrings* ASource, const System::WideString AName, System::Typinfo::PTypeInfo AEventTypeInfo);
	void __fastcall RenameProcSrc(System::Classes::TStrings* ASource, const System::WideString ANewName, TLMDSrcUtilsProc* AProc);
	void __fastcall AddProc(TLMDSrcUtilsProc* AProc);
	TLMDSrcUtilsProc* __fastcall GetProc(int AIndex);
	int __fastcall GetProcCount(void);
	void __fastcall SetLanguage(const Lmdsctscripter::TLMDScriptLanguage Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
public:
	__fastcall virtual TLMDSourceUtils(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSourceUtils(void);
	void __fastcall Refresh(System::Classes::TStrings* ASource);
	void __fastcall Clear(void);
	TLMDSrcUtilsProc* __fastcall FindProc(const System::WideString AName);
	void __fastcall GetProcList(System::Typinfo::PTypeInfo AEventTypeInfo, System::Classes::TStrings* AResult);
	TLMDEnsureProcRes __fastcall EnsureProcAndRefresh(System::Classes::TStrings* ASource, const System::WideString AName, const System::WideString AOldName, System::Typinfo::PTypeInfo AEventTypeInfo);
	bool __fastcall IsCompatibleProc(TLMDSrcUtilsProc* AProc, System::Typinfo::PTypeInfo AEventTypeInfo);
	TLMDValidateProcAction __fastcall ValidateProc(System::Classes::TPersistent* AInstance, System::Typinfo::PPropInfo APropInfo, const System::WideString AName);
	__property int ProcCount = {read=GetProcCount, nodefault};
	__property TLMDSrcUtilsProc* Proc[int AIndex] = {read=GetProc};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdsctscripter::TLMDScriptLanguage Language = {read=FLanguage, write=SetLanguage, default=0};
	__property System::Classes::TNotifyEvent AfterRefresh = {read=FAfterRefresh, write=FAfterRefresh};
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
}	/* namespace Lmdsctsource */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTSOURCE)
using namespace Lmdsctsource;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctsourceHPP
