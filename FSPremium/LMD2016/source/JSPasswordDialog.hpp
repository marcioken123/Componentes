// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSPasswordDialog.pas' rev: 31.00 (Windows)

#ifndef JspassworddialogHPP
#define JspassworddialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <JSEditDialog.hpp>
#include <JSDialogs.hpp>
#include <JSDialog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jspassworddialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EPasswordDialogException;
class DELPHICLASS TJSCustomPasswordDialog;
class DELPHICLASS TJSPasswordDialog;
class DELPHICLASS TJSCustomConfirmPasswordDialog;
class DELPHICLASS TJSConfirmPasswordDialog;
class DELPHICLASS TJSCustomChangePasswordDialog;
class DELPHICLASS TJSChangePasswordDialog;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION EPasswordDialogException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EPasswordDialogException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EPasswordDialogException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EPasswordDialogException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EPasswordDialogException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EPasswordDialogException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EPasswordDialogException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EPasswordDialogException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EPasswordDialogException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPasswordDialogException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPasswordDialogException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPasswordDialogException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPasswordDialogException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EPasswordDialogException(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TJSCustomPasswordDialog : public Jseditdialog::TJSEditDialog
{
	typedef Jseditdialog::TJSEditDialog inherited;
	
private:
	System::UnicodeString FPassword;
	bool FExtendedValidation;
	void __fastcall SetAllowPlainTextInput(const bool Value);
	bool __fastcall GetAllowPlainTextInput(void);
	
protected:
	virtual void __fastcall DoGetEditControlClass(Vcl::Controls::TControlClass &AControlClass);
	virtual Vcl::Controls::TWinControl* __fastcall GetActiveControl(void);
	virtual int __fastcall DoGetControlHeight(void);
	virtual void __fastcall DoDialogClose(System::TObject* Sender);
	virtual void __fastcall DoVerificationClick(const bool Checked);
	
public:
	__fastcall virtual TJSCustomPasswordDialog(System::Classes::TComponent* AOwner);
	__property System::UnicodeString Password = {read=FPassword};
	__property bool AllowPlainTextInput = {read=GetAllowPlainTextInput, write=SetAllowPlainTextInput, default=1};
	__property bool ExtendedValidation = {read=FExtendedValidation, write=FExtendedValidation, default=1};
	
__published:
	__property MainIcon = {default=5};
public:
	/* TJSCustomEditDialog.Destroy */ inline __fastcall virtual ~TJSCustomPasswordDialog(void) { }
	
};


class PASCALIMPLEMENTATION TJSPasswordDialog : public TJSCustomPasswordDialog
{
	typedef TJSCustomPasswordDialog inherited;
	
__published:
	__property AllowPlainTextInput = {default=1};
	__property ExtendedValidation = {default=1};
public:
	/* TJSCustomPasswordDialog.Create */ inline __fastcall virtual TJSPasswordDialog(System::Classes::TComponent* AOwner) : TJSCustomPasswordDialog(AOwner) { }
	
public:
	/* TJSCustomEditDialog.Destroy */ inline __fastcall virtual ~TJSPasswordDialog(void) { }
	
};


class PASCALIMPLEMENTATION TJSCustomConfirmPasswordDialog : public TJSPasswordDialog
{
	typedef TJSPasswordDialog inherited;
	
private:
	System::UnicodeString FConfirmedPassword;
	
protected:
	virtual void __fastcall DoDialogClose(System::TObject* Sender);
	virtual int __fastcall DoGetControlHeight(void);
	virtual void __fastcall DoGetEditControlClass(Vcl::Controls::TControlClass &AControlClass);
	
public:
	__fastcall virtual TJSCustomConfirmPasswordDialog(System::Classes::TComponent* AOwner);
	__property System::UnicodeString ConfirmedPassword = {read=FConfirmedPassword};
public:
	/* TJSCustomEditDialog.Destroy */ inline __fastcall virtual ~TJSCustomConfirmPasswordDialog(void) { }
	
};


class PASCALIMPLEMENTATION TJSConfirmPasswordDialog : public TJSCustomConfirmPasswordDialog
{
	typedef TJSCustomConfirmPasswordDialog inherited;
	
public:
	/* TJSCustomConfirmPasswordDialog.Create */ inline __fastcall virtual TJSConfirmPasswordDialog(System::Classes::TComponent* AOwner) : TJSCustomConfirmPasswordDialog(AOwner) { }
	
public:
	/* TJSCustomEditDialog.Destroy */ inline __fastcall virtual ~TJSConfirmPasswordDialog(void) { }
	
};


class PASCALIMPLEMENTATION TJSCustomChangePasswordDialog : public TJSConfirmPasswordDialog
{
	typedef TJSConfirmPasswordDialog inherited;
	
private:
	System::UnicodeString FOldPassword;
	
protected:
	virtual void __fastcall DoGetEditControlClass(Vcl::Controls::TControlClass &AControlClass);
	virtual int __fastcall DoGetControlHeight(void);
	virtual void __fastcall DoDialogClose(System::TObject* Sender);
	
public:
	__fastcall virtual TJSCustomChangePasswordDialog(System::Classes::TComponent* AOwner);
	__property System::UnicodeString OldPassword = {read=FOldPassword};
public:
	/* TJSCustomEditDialog.Destroy */ inline __fastcall virtual ~TJSCustomChangePasswordDialog(void) { }
	
};


class PASCALIMPLEMENTATION TJSChangePasswordDialog : public TJSCustomChangePasswordDialog
{
	typedef TJSCustomChangePasswordDialog inherited;
	
public:
	/* TJSCustomChangePasswordDialog.Create */ inline __fastcall virtual TJSChangePasswordDialog(System::Classes::TComponent* AOwner) : TJSCustomChangePasswordDialog(AOwner) { }
	
public:
	/* TJSCustomEditDialog.Destroy */ inline __fastcall virtual ~TJSChangePasswordDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jspassworddialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSPASSWORDDIALOG)
using namespace Jspassworddialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JspassworddialogHPP
