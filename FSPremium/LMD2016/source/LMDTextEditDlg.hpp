// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextEditDlg.pas' rev: 31.00 (Windows)

#ifndef LmdtexteditdlgHPP
#define LmdtexteditdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtexteditdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextEditDlg;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDTextEditDlgOption : unsigned char { teSave, teLoad, teModify, teStatistics, tePrint, teSearch, teFont, teLines, teMenu, teAlignment, teToolbar, teStatusBar, teBottomPanel };

typedef System::Set<TLMDTextEditDlgOption, TLMDTextEditDlgOption::teSave, TLMDTextEditDlgOption::teBottomPanel> TLMDTextEditDlgOptions;

class PASCALIMPLEMENTATION TLMDTextEditDlg : public Lmdbasedialog::TLMDBaseDialog
{
	typedef Lmdbasedialog::TLMDBaseDialog inherited;
	
private:
	System::UnicodeString FFilter;
	System::UnicodeString FFilename;
	System::Classes::TStrings* FLines;
	bool FLined;
	bool FAlways;
	bool FWordWrap;
	Vcl::Graphics::TFont* FFont;
	TLMDTextEditDlgOptions FOptions;
	System::UnicodeString __fastcall GetText(void);
	HIDESBASE void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetLines(System::Classes::TStrings* aValue);
	void __fastcall SetText(const System::UnicodeString Value);
	
protected:
	System::Uitypes::TModalResult __fastcall BaseExecute2(Vcl::Forms::TForm* aForm, Vcl::Forms::TForm* aParentForm, System::UnicodeString defCaption);
	
public:
	__fastcall virtual TLMDTextEditDlg(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextEditDlg(void);
	bool __fastcall ExecuteEnh(Vcl::Forms::TForm* aParentForm);
	virtual bool __fastcall Execute(void);
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property CaptionFill = {default=0};
	__property CaptionTitle = {default=0};
	__property Colors = {default=32};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
	__property Effect = {default=0};
	__property System::UnicodeString FileName = {read=FFilename, write=FFilename};
	__property System::UnicodeString FileFilter = {read=FFilter, write=FFilter};
	__property System::UnicodeString Text = {read=GetText, write=SetText, stored=false};
	__property TLMDTextEditDlgOptions Options = {read=FOptions, write=FOptions, default=4135};
	__property Position = {default=5};
	__property RelatePos = {default=0};
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, default=1};
	__property bool Lined = {read=FLined, write=FLined, default=0};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property bool AlwaysReturnText = {read=FAlways, write=FAlways, default=0};
	__property CustomButton = {default=0};
	__property OnCustomize;
	__property OnCustomClick;
};


//-- var, const, procedure ---------------------------------------------------
#define LMDTextEditDlgOptionsDefault (System::Set<TLMDTextEditDlgOption, TLMDTextEditDlgOption::teSave, TLMDTextEditDlgOption::teBottomPanel>() << TLMDTextEditDlgOption::teSave << TLMDTextEditDlgOption::teLoad << TLMDTextEditDlgOption::teModify << TLMDTextEditDlgOption::teSearch << TLMDTextEditDlgOption::teBottomPanel )
}	/* namespace Lmdtexteditdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTEDITDLG)
using namespace Lmdtexteditdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtexteditdlgHPP
