// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElInputDlg.pas' rev: 31.00 (Windows)

#ifndef ElinputdlgHPP
#define ElinputdlgHPP

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
#include <System.Math.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Consts.hpp>
#include <LMDTypes.hpp>
#include <ElBtnCtl.hpp>
#include <ElCheckCtl.hpp>
#include <ElHTMLLbl.hpp>
#include <ElPanel.hpp>
#include <ElEdits.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElVCLUtils.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElCaption.hpp>
#include <ElComponent.hpp>
#include <System.Types.hpp>
#include <ElStyleMan.hpp>
#include <LMDGraph.hpp>
#include <LMDUtils.hpp>
#include <ElPopBtn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elinputdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElInputDialog;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TElValidateInputEvent)(System::TObject* Sender, Lmdtypes::TLMDString &Value, bool &CanAccept);

class PASCALIMPLEMENTATION TElInputDialog : public Elcomponent::TElBaseDlgComponent
{
	typedef Elcomponent::TElBaseDlgComponent inherited;
	
private:
	Lmdtypes::TLMDString FPrompt;
	Lmdtypes::TLMDString FCaption;
	bool FIsHTML;
	Lmdtypes::TLMDString FValue;
	Vcl::Graphics::TFont* FFont;
	bool FParentFont;
	Vcl::Forms::TPosition FPosition;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	bool FUseXPThemes;
	Lmdtypes::TLMDString FPasswordChar;
	bool FShowGlyphs;
	TElValidateInputEvent FOnValidateInput;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	Vcl::Forms::TForm* FForm;
	Elpopbtn::TElPopupButton* FOkBtn;
	Eledits::TElEdit* FEdit;
	Vcl::Controls::TKeyPressEvent FKeyPressEvent;
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	void __fastcall SetParentFont(bool Value);
	void __fastcall FontChange(System::TObject* Sender);
	virtual void __fastcall ValidateInputChange(System::TObject* Sender);
	virtual void __fastcall EditorKeyPress(System::TObject* Sender, System::WideChar &Key);
	
public:
	virtual bool __fastcall Execute(void);
	__fastcall virtual TElInputDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInputDialog(void);
	
__published:
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property Lmdtypes::TLMDString Prompt = {read=FPrompt, write=FPrompt};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=FCaption};
	__property bool IsHTML = {read=FIsHTML, write=FIsHTML, nodefault};
	__property Vcl::Forms::TPosition Position = {read=FPosition, write=FPosition, nodefault};
	__property Lmdtypes::TLMDString Value = {read=FValue, write=FValue};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool ParentFont = {read=FParentFont, write=SetParentFont, default=1};
	__property bool UseXPThemes = {read=FUseXPThemes, write=FUseXPThemes, default=1};
	__property Lmdtypes::TLMDString PasswordChar = {read=FPasswordChar, write=FPasswordChar};
	__property TElValidateInputEvent OnValidateInput = {read=FOnValidateInput, write=FOnValidateInput};
	__property Vcl::Controls::TKeyPressEvent OnEditorKeyPress = {read=FKeyPressEvent, write=FKeyPressEvent};
};


typedef System::TMetaClass* TInputDlgClass;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TInputDlgClass InputDlgClass;
extern DELPHI_PACKAGE Lmdtypes::TLMDString MsgDlgOk;
extern DELPHI_PACKAGE Lmdtypes::TLMDString MsgDlgCancel;
extern DELPHI_PACKAGE bool __fastcall InputQuery(const Lmdtypes::TLMDString ACaption, const Lmdtypes::TLMDString APrompt, Lmdtypes::TLMDString &AValue, bool AIsHTML = true, bool IsPassword = false);
}	/* namespace Elinputdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELINPUTDLG)
using namespace Elinputdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElinputdlgHPP
