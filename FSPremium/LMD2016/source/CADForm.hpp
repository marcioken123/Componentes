// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CADForm.pas' rev: 31.00 (Windows)

#ifndef CadformHPP
#define CadformHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <JSDialogs.hpp>
#include <Vcl.ComCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Cadform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDlgSettings;
class DELPHICLASS TfrmCAD;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TDlgSettings : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FTitle;
	System::UnicodeString FMainInstruction;
	System::Classes::TStrings* FContent;
	int FIcon;
	Jsdialogs::TCommonButtons FButtons;
	int FUseMethod;
	System::UnicodeString FVerifyText;
	int FWrapperMethodIdx;
	void __fastcall SetContent(System::Classes::TStrings* const Value);
	System::UnicodeString __fastcall GetDlgButtons(void);
	System::UnicodeString __fastcall GetCommonButtons(void);
	System::UnicodeString __fastcall GetDlgType(void);
	System::UnicodeString __fastcall GetTaskType(void);
	System::UnicodeString __fastcall GetTaskButtons(void);
	System::UnicodeString __fastcall GetTaskDialogIcon(void);
	System::UnicodeString __fastcall GetJSDialogTemplate(void);
	
public:
	__fastcall TDlgSettings(void);
	__fastcall virtual ~TDlgSettings(void);
	virtual System::UnicodeString __fastcall ToString(void);
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property System::UnicodeString MainInstruction = {read=FMainInstruction, write=FMainInstruction};
	__property System::Classes::TStrings* Content = {read=FContent, write=SetContent};
	__property int Icon = {read=FIcon, write=FIcon, nodefault};
	__property Jsdialogs::TCommonButtons Buttons = {read=FButtons, write=FButtons, nodefault};
	__property System::UnicodeString VerifyText = {read=FVerifyText, write=FVerifyText};
	__property int UseMethod = {read=FUseMethod, write=FUseMethod, nodefault};
	__property int WrapperMethodIdx = {read=FWrapperMethodIdx, write=FWrapperMethodIdx, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrmCAD : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* bOK;
	Vcl::Stdctrls::TButton* bCancel;
	Vcl::Stdctrls::TButton* bHelp;
	Vcl::Stdctrls::TButton* bPreview;
	Vcl::Stdctrls::TCheckBox* cbDefault;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* tsTaskDialog;
	Vcl::Comctrls::TTabSheet* tsMessageDlg;
	Vcl::Comctrls::TTabSheet* tsJSDialog;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Extctrls::TImage* iMainIcon;
	Vcl::Stdctrls::TGroupBox* gbCommonButtons;
	Vcl::Stdctrls::TCheckBox* cbcbYes;
	Vcl::Stdctrls::TCheckBox* cbcbNo;
	Vcl::Stdctrls::TCheckBox* cbcbOK;
	Vcl::Stdctrls::TCheckBox* cbcbCancel;
	Vcl::Stdctrls::TCheckBox* cbcbRetry;
	Vcl::Stdctrls::TCheckBox* cbcbClose;
	Vcl::Stdctrls::TEdit* eInstruction;
	Vcl::Stdctrls::TMemo* mContent;
	Vcl::Extctrls::TRadioGroup* rgMainIcon;
	Vcl::Stdctrls::TEdit* eTitle;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Extctrls::TRadioGroup* rgMsgDlgType;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TMemo* Memo1;
	Vcl::Stdctrls::TGroupBox* gbDlgButtons;
	Vcl::Stdctrls::TCheckBox* cbmbYes;
	Vcl::Stdctrls::TCheckBox* cbmbNo;
	Vcl::Stdctrls::TCheckBox* cbmbOK;
	Vcl::Stdctrls::TCheckBox* cbmbCancel;
	Vcl::Stdctrls::TCheckBox* cbmbAbort;
	Vcl::Stdctrls::TCheckBox* cbmbRetry;
	Vcl::Stdctrls::TCheckBox* cbmbIgnore;
	Vcl::Stdctrls::TCheckBox* cbmbAll;
	Vcl::Stdctrls::TCheckBox* cbmbNoToAll;
	Vcl::Stdctrls::TCheckBox* cbmbYesToAll;
	Vcl::Stdctrls::TCheckBox* cbmbHelp;
	Vcl::Stdctrls::TCheckBox* cbmbClose;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* eInstructionVerifyMessage;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TMemo* mContentVerifyMessage;
	Vcl::Extctrls::TImage* iVerifyMessage;
	Vcl::Extctrls::TRadioGroup* rgVerifyMessage;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TCheckBox* cbvmYes;
	Vcl::Stdctrls::TCheckBox* cbvmNo;
	Vcl::Stdctrls::TCheckBox* cbvmOK;
	Vcl::Stdctrls::TCheckBox* cbvmCancel;
	Vcl::Stdctrls::TCheckBox* cbvmAbort;
	Vcl::Stdctrls::TCheckBox* cbvmRetry;
	Vcl::Stdctrls::TCheckBox* cbvmIgnore;
	Vcl::Stdctrls::TCheckBox* cbvmAll;
	Vcl::Stdctrls::TCheckBox* cbvmNoToAll;
	Vcl::Stdctrls::TCheckBox* cbvmYesToAll;
	Vcl::Stdctrls::TCheckBox* cbvmHelp;
	Vcl::Stdctrls::TCheckBox* cbvmClose;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TEdit* eVerifyText;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Extctrls::TRadioGroup* rgWrapperMethod;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TEdit* eWrapperMessage;
	void __fastcall rgMainIconClick(System::TObject* Sender);
	void __fastcall cbcbYesClick(System::TObject* Sender);
	void __fastcall bPreviewClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall rgMsgDlgTypeClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall rgVerifyMessageClick(System::TObject* Sender);
	
private:
	void __fastcall ValidateMethod(void);
	
public:
	__classmethod bool __fastcall Execute(TDlgSettings* &aSettings);
	Jsdialogs::TCommonButtons __fastcall GetButtons(void);
	Jsdialogs::TCommonButtons __fastcall GetDlgButtonsEx(void);
	Jsdialogs::TMsgDlgButtons __fastcall GetDlgButtons(void);
	Jsdialogs::TMsgDlgType __fastcall GetDlgType(void);
	int __fastcall GetTDIcon(void);
	int __fastcall GetTDButtons(void);
	Jsdialogs::TCommonButtons __fastcall GetVMDlgButtonsEx(void);
	Jsdialogs::TTaskDialogIcon __fastcall GetVMIcon(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmCAD(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmCAD(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmCAD(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmCAD(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrmCAD* frmCAD;
}	/* namespace Cadform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_CADFORM)
using namespace Cadform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CadformHPP
