// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWindowListDlg.pas' rev: 31.00 (Windows)

#ifndef LmdwindowlistdlgHPP
#define LmdwindowlistdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <LMDButton.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDExtListBox.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwindowlistdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWindowListDlg;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDWLFormEvent)(System::TObject* Sender, Vcl::Forms::TForm* aForm, bool &Accept);

enum DECLSPEC_DENUM TLMDWLOption : unsigned char { wlAddInVisible, wlAddDialogForms, wlAddMainForm, wlAddParentForm, wlAddNoCaptionForms };

typedef System::Set<TLMDWLOption, TLMDWLOption::wlAddInVisible, TLMDWLOption::wlAddNoCaptionForms> TLMDWLOptions;

class PASCALIMPLEMENTATION TLMDWindowListDlg : public Lmdbasedialog::TLMDBaseDialog
{
	typedef Lmdbasedialog::TLMDBaseDialog inherited;
	
private:
	System::UnicodeString FDescription;
	Vcl::Forms::TForm* FForm;
	TLMDWLOptions FOptions;
	TLMDWLFormEvent FOnShow;
	TLMDWLFormEvent FOnList;
	Lmdbutton::TLMDButton* ok;
	Lmdextlistbox::TLMDExtListBox* lb;
	void __fastcall lbClick(System::TObject* Sender);
	void __fastcall lbDblClick(System::TObject* Sender);
	void __fastcall okClick(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDWindowListDlg(System::Classes::TComponent* AOwner);
	virtual bool __fastcall Execute(void);
	bool __fastcall ExecuteEnh(Vcl::Forms::TForm* Main);
	__property CtlXP = {default=1};
	__property Vcl::Forms::TForm* Form = {read=FForm};
	
__published:
	__property About = {default=0};
	__property CaptionFill = {default=0};
	__property CaptionTitle = {default=0};
	__property Colors = {default=32};
	__property CustomButton = {default=0};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property Effect = {default=0};
	__property Hints;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property TLMDWLOptions Options = {read=FOptions, write=FOptions, default=1};
	__property Position = {default=5};
	__property RelatePos = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property ShowHints = {default=1};
	__property TLMDWLFormEvent OnShow = {read=FOnShow, write=FOnShow};
	__property TLMDWLFormEvent OnList = {read=FOnList, write=FOnList};
	__property OnCustomize;
	__property OnCustomClick;
public:
	/* TLMDBaseDialog.Destroy */ inline __fastcall virtual ~TLMDWindowListDlg(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwindowlistdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWINDOWLISTDLG)
using namespace Lmdwindowlistdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwindowlistdlgHPP
