// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMapi.pas' rev: 31.00 (Windows)

#ifndef LmdmapiHPP
#define LmdmapiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <LMDWebBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmapi
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDMapiError;
class DELPHICLASS TLMDMapiSendMail;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDMapiError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	int ErrorCode;
public:
	/* Exception.Create */ inline __fastcall ELMDMapiError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDMapiError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDMapiError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDMapiError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDMapiError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDMapiError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDMapiError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDMapiError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDMapiError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDMapiError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDMapiError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDMapiError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDMapiError(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDMapiError)(System::TObject* Sender, int iErrorCode);

enum DECLSPEC_DENUM TLMDMAPIOption : unsigned char { moUseDefaultProfile, moCreateNewSession, moLogonUI, moShowDialog, moNoSTMPIdent, moNoAddressField };

typedef System::Set<TLMDMAPIOption, TLMDMAPIOption::moUseDefaultProfile, TLMDMAPIOption::moNoAddressField> TLMDMAPIOptions;

class PASCALIMPLEMENTATION TLMDMapiSendMail : public Lmdwebbase::TLMDWebComponent
{
	typedef Lmdwebbase::TLMDWebComponent inherited;
	
private:
	System::Classes::TStrings* FAttachment;
	System::Classes::TStrings* FBccRecipient;
	System::Classes::TStrings* FCcRecipient;
	System::Classes::TStrings* FToRecipient;
	System::Classes::TStrings* FMessageBody;
	System::AnsiString FMessageID;
	System::AnsiString FSubject;
	System::AnsiString FProfile;
	System::AnsiString FPassword;
	unsigned FSessionID;
	bool FResolve;
	System::Classes::TNotifyEvent FOnStartSaveMail;
	System::Classes::TNotifyEvent FOnEndSaveMail;
	System::Classes::TNotifyEvent FOnStartLogoff;
	System::Classes::TNotifyEvent FOnStartSendMail;
	System::Classes::TNotifyEvent FOnStartLogon;
	System::Classes::TNotifyEvent FOnEndLogoff;
	System::Classes::TNotifyEvent FOnEndLogon;
	System::Classes::TNotifyEvent FOnEndSendMail;
	TLMDMapiError FOnError;
	int FLastError;
	TLMDMAPIOptions FOptions;
	void __fastcall SetStrings(int index, System::Classes::TStrings* aValue);
	System::Classes::TStrings* __fastcall GetStrings(int index);
	System::AnsiString __fastcall GetDefaultProfile(void);
	void __fastcall ReadBool(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DoEndLogon(void);
	virtual void __fastcall DoEndLogoff(void);
	virtual void __fastcall DoEndSaveMail(void);
	virtual void __fastcall DoEndSendMail(void);
	void __fastcall DoError(int iErrorCode);
	virtual void __fastcall DoStartLogon(void);
	virtual void __fastcall DoStartLogoff(void);
	virtual void __fastcall DoStartSaveMail(void);
	virtual void __fastcall DoStartSendMail(void);
	void __fastcall Execute(bool Save, unsigned HWND);
	int __fastcall GetFlags(void);
	
public:
	__fastcall virtual TLMDMapiSendMail(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDMapiSendMail(void);
	void __fastcall LogOn(void);
	void __fastcall LogOff(void);
	void __fastcall SaveMail(void)/* overload */;
	void __fastcall SaveMail(unsigned HWND)/* overload */;
	void __fastcall SendMail(void)/* overload */;
	void __fastcall SendMail(unsigned HWND)/* overload */;
	void __fastcall Reset(void);
	__property int LastError = {read=FLastError, default=0};
	__property System::AnsiString MessageID = {read=FMessageID};
	__property System::AnsiString Password = {read=FPassword, write=FPassword};
	__property System::AnsiString Profile = {read=FProfile, write=FProfile};
	__property System::AnsiString DefaultProfile = {read=GetDefaultProfile};
	
__published:
	__property System::Classes::TStrings* Attachment = {read=GetStrings, write=SetStrings, index=0};
	__property System::Classes::TStrings* BccRecipient = {read=GetStrings, write=SetStrings, index=1};
	__property System::Classes::TStrings* CcRecipient = {read=GetStrings, write=SetStrings, index=2};
	__property System::Classes::TStrings* MessageBody = {read=GetStrings, write=SetStrings, index=3};
	__property System::Classes::TStrings* ToRecipient = {read=GetStrings, write=SetStrings, index=4};
	__property TLMDMAPIOptions Options = {read=FOptions, write=FOptions, default=9};
	__property System::AnsiString Subject = {read=FSubject, write=FSubject};
	__property TLMDMapiError OnError = {read=FOnError, write=FOnError};
	__property System::Classes::TNotifyEvent OnEndLogon = {read=FOnEndLogon, write=FOnEndLogon};
	__property System::Classes::TNotifyEvent OnEndLogoff = {read=FOnEndLogoff, write=FOnEndLogoff};
	__property System::Classes::TNotifyEvent OnEndSaveMail = {read=FOnEndSaveMail, write=FOnEndSaveMail};
	__property System::Classes::TNotifyEvent OnEndSendMail = {read=FOnEndSendMail, write=FOnEndSendMail};
	__property System::Classes::TNotifyEvent OnStartLogon = {read=FOnStartLogon, write=FOnStartLogon};
	__property System::Classes::TNotifyEvent OnStartLogoff = {read=FOnStartLogoff, write=FOnStartLogoff};
	__property System::Classes::TNotifyEvent OnStartSaveMail = {read=FOnStartSaveMail, write=FOnStartSaveMail};
	__property System::Classes::TNotifyEvent OnStartSendMail = {read=FOnStartSendMail, write=FOnStartSendMail};
};


//-- var, const, procedure ---------------------------------------------------
#define def_MAPIOptions (System::Set<TLMDMAPIOption, TLMDMAPIOption::moUseDefaultProfile, TLMDMAPIOption::moNoAddressField>() << TLMDMAPIOption::moUseDefaultProfile << TLMDMAPIOption::moShowDialog )
}	/* namespace Lmdmapi */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMAPI)
using namespace Lmdmapi;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmapiHPP
