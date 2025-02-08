// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSChangePasswordDialogFrame.pas' rev: 31.00 (Windows)

#ifndef JschangepassworddialogframeHPP
#define JschangepassworddialogframeHPP

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
#include <JSConfirmPasswordDialogFrame.hpp>
#include <Vcl.StdCtrls.hpp>
#include <JSEditDialogIntf.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jschangepassworddialogframe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfmJSChangePasswordDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfmJSChangePasswordDialog : public Jsconfirmpassworddialogframe::TfmJSConfirmPasswordDialog
{
	typedef Jsconfirmpassworddialogframe::TfmJSConfirmPasswordDialog inherited;
	
__published:
	Vcl::Stdctrls::TLabel* lOldPasswordLabel;
	Vcl::Stdctrls::TEdit* eOldPassword;
	
private:
	System::UnicodeString __fastcall GetOldPassword(void);
	
protected:
	virtual void __fastcall LoadCaptions(void);
	
public:
	HIDESBASE Vcl::Controls::TWinControl* __fastcall ActiveControl(void);
	HIDESBASE void __fastcall AdjustControlLayout(const int AWidth);
	__property System::UnicodeString OldPassword = {read=GetOldPassword};
public:
	/* TfmJSConfirmPasswordDialog.Create */ inline __fastcall virtual TfmJSChangePasswordDialog(System::Classes::TComponent* AOwner) : Jsconfirmpassworddialogframe::TfmJSConfirmPasswordDialog(AOwner) { }
	
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TfmJSChangePasswordDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmJSChangePasswordDialog(HWND ParentWindow) : Jsconfirmpassworddialogframe::TfmJSConfirmPasswordDialog(ParentWindow) { }
	
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
extern DELPHI_PACKAGE TfmJSChangePasswordDialog* fmJSChangePasswordDialog;
}	/* namespace Jschangepassworddialogframe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSCHANGEPASSWORDDIALOGFRAME)
using namespace Jschangepassworddialogframe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JschangepassworddialogframeHPP
