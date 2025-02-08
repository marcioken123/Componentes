// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTipDlg.pas' rev: 31.00 (Windows)

#ifndef LmdtipdlgHPP
#define LmdtipdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <LMDButton.hpp>
#include <LMDCheckBox.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtipdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTipDlg;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDTipsDialogMode : unsigned char { moNormal, moStart };

class PASCALIMPLEMENTATION TLMDTipDlg : public Lmdbasedialog::TLMDBaseDialog
{
	typedef Lmdbasedialog::TLMDBaseDialog inherited;
	
private:
	System::UnicodeString FCaptionHeader;
	System::UnicodeString FCaptionHelp;
	System::Classes::TStringList* FTips;
	int FFirst;
	bool FShowStart;
	bool FHide;
	bool FFirstFlag;
	TLMDTipsDialogMode FMode;
	System::Classes::THelpContext FHelpContext;
	Vcl::Stdctrls::TLabel* tiplabel;
	Lmdcheckbox::TLMDCheckBox* showtips;
	Vcl::Stdctrls::TLabel* tiptitle;
	Lmdbutton::TLMDButton* prev;
	Lmdbutton::TLMDButton* next;
	Lmdbutton::TLMDButton* ok;
	Lmdbutton::TLMDButton* help;
	int Actualpos;
	System::Classes::TStringList* Last;
	bool show;
	bool FShowRandom;
	void __fastcall SetTips(System::Classes::TStringList* aStrings);
	void __fastcall SetTipsCount(int aInt);
	int __fastcall GetTipsCount(void);
	void __fastcall nexttip(System::TObject* Sender);
	void __fastcall lasttip(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall DoChange(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall helpClick(System::TObject* Sender);
	System::UnicodeString __fastcall GetListTip(int index);
	void __fastcall GetTip(void);
	
public:
	__fastcall virtual TLMDTipDlg(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTipDlg(void);
	virtual bool __fastcall Execute(void);
	bool __fastcall ExecuteEnh(Vcl::Forms::TForm* main, TLMDTipsDialogMode Mode);
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property CaptionFill = {default=0};
	__property System::UnicodeString CaptionHeader = {read=FCaptionHeader, write=FCaptionHeader};
	__property System::UnicodeString CaptionHelp = {read=FCaptionHelp, write=FCaptionHelp};
	__property CaptionTitle = {default=0};
	__property Colors = {default=32};
	__property CustomButton = {default=0};
	__property Effect = {default=0};
	__property bool HideShowAtStart = {read=FHide, write=FHide, default=0};
	__property int FirstHintNumber = {read=FFirst, write=FFirst, default=-1};
	__property System::Classes::THelpContext HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
	__property Hints;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property TLMDTipsDialogMode Mode = {read=FMode, write=FMode, default=0};
	__property Position = {default=5};
	__property RelatePos = {default=0};
	__property bool ShowAtStart = {read=FShowStart, write=FShowStart, default=0};
	__property ShowHints = {default=1};
	__property bool ShowRandom = {read=FShowRandom, write=FShowRandom, default=1};
	__property System::Classes::TStringList* Tips = {read=FTips, write=SetTips};
	__property int TipsCount = {read=GetTipsCount, write=SetTipsCount, stored=false, nodefault};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnCustomize;
	__property OnCustomClick;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtipdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTIPDLG)
using namespace Lmdtipdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtipdlgHPP
