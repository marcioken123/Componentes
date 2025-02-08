// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSConfirmPasswordDialogFrame.pas' rev: 31.00 (Windows)

#ifndef JsconfirmpassworddialogframeHPP
#define JsconfirmpassworddialogframeHPP

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
#include <Vcl.StdCtrls.hpp>
#include <JSEditDialog.hpp>
#include <JSEditDialogIntf.hpp>
#include <JSTypes.hpp>
#include <JSPasswordDialog.hpp>
#include <JSPasswordDialogFrame.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsconfirmpassworddialogframe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfmJSConfirmPasswordDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfmJSConfirmPasswordDialog : public Jspassworddialogframe::TfmJSPasswordDialog
{
	typedef Jspassworddialogframe::TfmJSPasswordDialog inherited;
	
__published:
	Vcl::Stdctrls::TLabel* lConfirmPasswordLabel;
	Vcl::Stdctrls::TEdit* eConfirmPassword;
	void __fastcall eNewPasswordChange(System::TObject* Sender);
	void __fastcall eConfirmPasswordChange(System::TObject* Sender);
	
private:
	Jspassworddialog::TJSPasswordDialog* FDialog;
	System::UnicodeString __fastcall GetConfirmedPassword(void);
	
protected:
	Vcl::Controls::TWinControl* FActiveControlInError;
	virtual void __fastcall LoadCaptions(void);
	
public:
	__fastcall virtual TfmJSConfirmPasswordDialog(System::Classes::TComponent* AOwner);
	HIDESBASE Vcl::Controls::TWinControl* __fastcall ActiveControl(void);
	HIDESBASE Vcl::Controls::TWinControl* __fastcall ActiveControlInError(void);
	HIDESBASE void __fastcall AdjustControlLayout(const int AWidth);
	HIDESBASE int __fastcall GetRequiredWidth(void);
	HIDESBASE void __fastcall SetActiveControlInError(Vcl::Controls::TWinControl* AControl);
	HIDESBASE void __fastcall SetDialog(Jseditdialog::TJSCustomEditDialog* JSDialog);
	HIDESBASE bool __fastcall ValidateInput(/* out */ System::UnicodeString &Message, const System::Uitypes::TModalResult ModalResult);
	__property System::UnicodeString ConfirmedPassword = {read=GetConfirmedPassword};
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TfmJSConfirmPasswordDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmJSConfirmPasswordDialog(HWND ParentWindow) : Jspassworddialogframe::TfmJSPasswordDialog(ParentWindow) { }
	
private:
	void *__IJSEditDialogControl;	// Jseditdialogintf::IJSEditDialogControl 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {91E6FD85-AE20-4637-A524-5025A236E238}
	operator Jseditdialogintf::_di_IJSEditDialogControl()
	{
		Jseditdialogintf::_di_IJSEditDialogControl intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Jseditdialogintf::IJSEditDialogControl*(void) { return (Jseditdialogintf::IJSEditDialogControl*)&__IJSEditDialogControl; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jsconfirmpassworddialogframe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSCONFIRMPASSWORDDIALOGFRAME)
using namespace Jsconfirmpassworddialogframe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsconfirmpassworddialogframeHPP
