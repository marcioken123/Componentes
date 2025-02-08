// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShPathDlg.pas' rev: 31.00 (Windows)

#ifndef LmdshpathdlgHPP
#define LmdshpathdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <LMDShBase.hpp>
#include <LMDShConsts.hpp>
#include <LMDShPathFrame.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshpathdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellCustomPathForm;
class DELPHICLASS TLMDShellPathDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShellCustomPathForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TButton* OkBtn;
	Vcl::Stdctrls::TButton* CancelBtn;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* InstructionLabel;
	Lmdshpathframe::TLMDShellPathFrame* LMDShellPathFrame1;
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Msg);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDShellCustomPathForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDShellCustomPathForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDShellCustomPathForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShellCustomPathForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TLMDShellPathDialogOption : unsigned char { poSizeable, poInstructionField, poShowDeleteInvalidButton, poHelpButton, poSpeedFlat, poPathMustExist };

typedef System::Set<TLMDShellPathDialogOption, TLMDShellPathDialogOption::poSizeable, TLMDShellPathDialogOption::poPathMustExist> TLMDShellPathDialogOptions;

class PASCALIMPLEMENTATION TLMDShellPathDialog : public Lmdshbase::TLMDShellBaseDialog
{
	typedef Lmdshbase::TLMDShellBaseDialog inherited;
	
private:
	System::UnicodeString FDelimeter;
	System::UnicodeString FCaption;
	System::UnicodeString FPath;
	System::UnicodeString FInstructionText;
	TLMDShellPathDialogOptions FOptions;
	System::UnicodeString FRootPath;
	System::UnicodeString FPathKeyValue;
	System::UnicodeString FPathKey;
	System::UnicodeString FPathIdent;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetDelimeter(const System::UnicodeString Value);
	void __fastcall SetPath(const System::UnicodeString Value);
	void __fastcall SetInstructionText(const System::UnicodeString Value);
	void __fastcall SetOptions(const TLMDShellPathDialogOptions Value);
	void __fastcall SetPathIdent(const System::UnicodeString Value);
	void __fastcall SetPathKey(const System::UnicodeString Value);
	void __fastcall SetPathKeyValue(const System::UnicodeString Value);
	void __fastcall SetRootPath(const System::UnicodeString Value);
	
public:
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
	__fastcall virtual TLMDShellPathDialog(System::Classes::TComponent* AOwner);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString Path = {read=FPath, write=SetPath};
	__property System::UnicodeString Delimeter = {read=FDelimeter, write=SetDelimeter};
	__property TLMDShellPathDialogOptions Options = {read=FOptions, write=SetOptions, default=37};
	__property System::UnicodeString InstructionText = {read=FInstructionText, write=SetInstructionText};
	__property System::UnicodeString PathKey = {read=FPathKey, write=SetPathKey};
	__property System::UnicodeString PathKeyValue = {read=FPathKeyValue, write=SetPathKeyValue};
	__property System::UnicodeString PathIdent = {read=FPathIdent, write=SetPathIdent};
	__property System::UnicodeString RootPath = {read=FRootPath, write=SetRootPath};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDShellPathDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshpathdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHPATHDLG)
using namespace Lmdshpathdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshpathdlgHPP
