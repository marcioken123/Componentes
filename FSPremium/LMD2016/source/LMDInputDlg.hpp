// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInputDlg.pas' rev: 31.00 (Windows)

#ifndef LmdinputdlgHPP
#define LmdinputdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinputdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDInputDlg;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDInputDlgOption : unsigned char { idoAddEdit, idoMaskEdit1, idoMaskEdit2, idoPWEdit1, idoPWEdit2, idoChangeEvents };

typedef System::Set<TLMDInputDlgOption, TLMDInputDlgOption::idoAddEdit, TLMDInputDlgOption::idoChangeEvents> TLMDInputDlgOptions;

class PASCALIMPLEMENTATION TLMDInputDlg : public Lmdbasedialog::TLMDBaseDialog
{
	typedef Lmdbasedialog::TLMDBaseDialog inherited;
	
private:
	bool FDefaultSelected;
	int FWidth;
	int FMaxLength;
	System::WideChar FPasswordChar;
	System::UnicodeString FReturnValue;
	System::UnicodeString FReturnValue2;
	System::UnicodeString FDefault;
	System::UnicodeString FPrompt;
	Vcl::Graphics::TFont* FPromptFont;
	System::Classes::TNotifyEvent FOnEditChange;
	bool FMultilinePrompt;
	void __fastcall DoChange(System::TObject* Sender);
	
protected:
	bool __fastcall DoShowDialog(const System::UnicodeString Caption, const System::UnicodeString Prompt, const System::UnicodeString DefaultValue, Vcl::Forms::TForm* Main, TLMDInputDlgOptions idOptions = TLMDInputDlgOptions() , const System::UnicodeString MaskValue = System::UnicodeString(), const System::UnicodeString Prompt2 = System::UnicodeString(), const System::UnicodeString DefaultValue2 = System::UnicodeString());
	
public:
	__fastcall virtual TLMDInputDlg(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDInputDlg(void);
	bool __fastcall ShowDialog(const System::UnicodeString Caption, const System::UnicodeString Prompt, const System::UnicodeString DefaultValue, Vcl::Forms::TForm* Main = (Vcl::Forms::TForm*)(0x0));
	virtual bool __fastcall Execute(void);
	bool __fastcall ExecuteEnh(Vcl::Forms::TForm* aForm);
	bool __fastcall InputQuery(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::UnicodeString &Value);
	bool __fastcall InputQueryMask(const System::UnicodeString ACaption, const System::UnicodeString APrompt, const System::UnicodeString AMask, System::UnicodeString &Value);
	bool __fastcall InputQueryEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt1, const System::UnicodeString APrompt2, System::UnicodeString &Value1, System::UnicodeString &Value2, TLMDInputDlgOptions idOptions = TLMDInputDlgOptions() , const System::UnicodeString AMask = System::UnicodeString());
	System::UnicodeString __fastcall InputBox(const System::UnicodeString ACaption, const System::UnicodeString APrompt, const System::UnicodeString ADefault);
	__property System::UnicodeString Value = {read=FReturnValue};
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property CaptionFill = {default=0};
	__property CaptionTitle = {default=0};
	__property Colors = {default=32};
	__property CustomButton = {default=0};
	__property System::UnicodeString DefaultValue = {read=FDefault, write=FDefault};
	__property bool DefaultSelected = {read=FDefaultSelected, write=FDefaultSelected, default=0};
	__property Effect = {default=0};
	__property Hints;
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property int MaxLength = {read=FMaxLength, write=FMaxLength, default=0};
	__property bool MultilinePrompt = {read=FMultilinePrompt, write=FMultilinePrompt, default=0};
	__property System::WideChar PasswordChar = {read=FPasswordChar, write=FPasswordChar, default=0};
	__property int Width = {read=FWidth, write=FWidth, default=-1};
	__property Position = {default=5};
	__property System::UnicodeString Prompt = {read=FPrompt, write=FPrompt};
	__property Vcl::Graphics::TFont* PromptFont = {read=FPromptFont, write=FPromptFont};
	__property RelatePos = {default=0};
	__property ShowHints = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnCustomClick;
	__property OnCustomize;
	__property System::Classes::TNotifyEvent OnEditChange = {read=FOnEditChange, write=FOnEditChange};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdinputdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINPUTDLG)
using namespace Lmdinputdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinputdlgHPP
