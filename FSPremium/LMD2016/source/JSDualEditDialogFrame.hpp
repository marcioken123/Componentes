// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSDualEditDialogFrame.pas' rev: 31.00 (Windows)

#ifndef JsdualeditdialogframeHPP
#define JsdualeditdialogframeHPP

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
#include <JSDualEditDialog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsdualeditdialogframe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfmDualEditDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfmDualEditDialog : public Vcl::Forms::TFrame
{
	typedef Vcl::Forms::TFrame inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Value1Label;
	Vcl::Stdctrls::TLabel* Value2Label;
	Vcl::Stdctrls::TEdit* eValue2;
	Vcl::Stdctrls::TEdit* eValue1;
	
private:
	Jseditdialog::TJSCustomEditDialog* FDialog;
	Vcl::Controls::TWinControl* __fastcall ActiveControl(void);
	Vcl::Controls::TWinControl* __fastcall ActiveControlInError(void);
	void __fastcall AdjustControlLayout(const int AWidth);
	int __fastcall GetRequiredWidth(void);
	void __fastcall SetActiveControlInError(Vcl::Controls::TWinControl* AControl);
	void __fastcall SetDialog(Jseditdialog::TJSCustomEditDialog* JSDialog);
	bool __fastcall ValidateInput(/* out */ System::UnicodeString &Message, const System::Uitypes::TModalResult ModalResult);
	System::UnicodeString __fastcall GetEdit1(void);
	System::UnicodeString __fastcall GetEdit2(void);
	
protected:
	Vcl::Controls::TWinControl* FActiveControlInError;
	
public:
	__property System::UnicodeString Edit1 = {read=GetEdit1};
	__property System::UnicodeString Edit2 = {read=GetEdit2};
public:
	/* TCustomFrame.Create */ inline __fastcall virtual TfmDualEditDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TFrame(AOwner) { }
	
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TfmDualEditDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmDualEditDialog(HWND ParentWindow) : Vcl::Forms::TFrame(ParentWindow) { }
	
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
}	/* namespace Jsdualeditdialogframe */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSDUALEDITDIALOGFRAME)
using namespace Jsdualeditdialogframe;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsdualeditdialogframeHPP
