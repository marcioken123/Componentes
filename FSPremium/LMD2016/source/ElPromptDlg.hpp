// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElPromptDlg.pas' rev: 31.00 (Windows)

#ifndef ElpromptdlgHPP
#define ElpromptdlgHPP

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
#include <Vcl.Clipbrd.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Math.hpp>
#include <Vcl.ImgList.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Consts.hpp>
#include <System.Types.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDElConst.hpp>
#include <ElBtnCtl.hpp>
#include <ElCheckCtl.hpp>
#include <ElPopBtn.hpp>
#include <ElStrPool.hpp>
#include <ElStrArray.hpp>
#include <LMDUnicodeStrings.hpp>
#include <ElStyleMan.hpp>
#include <ElImgLst.hpp>
#include <ElHTMLLbl.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <ElFrmPers.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDUtils.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <ElPanel.hpp>
#include <ElCaption.hpp>
#include <ElCLabel.hpp>
#include <ElComponent.hpp>
#include <intfLMDBase.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elpromptdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElPromptForm;
class DELPHICLASS TElPromptDialog;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TPromptCloseEvent)(System::TObject* Sender, int Result);

class PASCALIMPLEMENTATION TElPromptForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TTimer* Timer;
	Elpanel::TElPanel* ElPanel1;
	Vcl::Stdctrls::TLabel* TimeLabel;
	Vcl::Extctrls::TImage* Image;
	Elhtmllbl::TElHTMLLabel* MessageLabel;
	Elcheckctl::TElCheckBox* ShowAgainCB;
	Elpopbtn::TElPopupButton* HelpBtn;
	Elpopbtn::TElPopupButton* OkBtn;
	Elpopbtn::TElPopupButton* IgnoreBtn;
	Elpopbtn::TElPopupButton* YesBtn;
	Elpopbtn::TElPopupButton* CancelBtn;
	Elpopbtn::TElPopupButton* NoBtn;
	Elpopbtn::TElPopupButton* NoToAllBtn;
	Elpopbtn::TElPopupButton* AbortBtn;
	Elpopbtn::TElPopupButton* RetryBtn;
	Elpopbtn::TElPopupButton* YesToAllBtn;
	Elfrmpers::TElFormPersist* ElFormPersist1;
	Elimglst::TElImageList* DisabledImages;
	Elimglst::TElImageList* EnabledImages;
	Elcaption::TElFormCaption* Captions;
	Elpopbtn::TElPopupButton* ElPopupButton1;
	void __fastcall TimerTimer(System::TObject* Sender);
	void __fastcall HelpBtnClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall MessageLabelLinkClick(System::TObject* Sender, Lmdtypes::TLMDString HRef);
	void __fastcall MessageLabelImageNeeded(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	bool FDisableOk;
	int FLeft;
	bool FShowTime;
	Lmdtypes::TLMDString FSaveDefText;
	Lmdtypes::TLMDString SecondsCaption;
	Elpopbtn::TElPopupButton* DefaultButton;
	bool Modal;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeed;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	System::Classes::TNotifyEvent FOnTimer;
	TPromptCloseEvent FOnClose;
	Lmdtypes::TLMDString FCaption;
	HIDESBASE MESSAGE void __fastcall WMSysCommand(Winapi::Messages::TWMSysCommand &Message);
	
public:
	void *CustomData;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElPromptForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElPromptForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElPromptForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElPromptForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


typedef System::TMetaClass* TElPromptFormClass;

class PASCALIMPLEMENTATION TElPromptDialog : public Vcl::Dialogs::TCommonDialog
{
	typedef Vcl::Dialogs::TCommonDialog inherited;
	
protected:
	bool FDisableCustomCaption;
	int FMaxWidth;
	Lmdtypes::TLMDAboutVar FAbout;
	bool FTopmost;
	Lmdunicodestrings::TLMDWideStringArray* FControlTexts;
	Lmdtypes::TLMDString FMessage;
	int FCaptionIdx;
	int FMessageIdx;
	System::Uitypes::TMsgDlgType FDlgType;
	Lmdunicodestrings::TLMDWideStringArray* FCaptions;
	Lmdunicodestrings::TLMDWideStringArray* FTexts;
	System::Uitypes::TMsgDlgButtons FButtons;
	System::Uitypes::TMsgDlgBtn FDefBtn;
	System::Uitypes::TMsgDlgBtn FCancelBtn;
	bool FShowGlyphs;
	int FTimeLimit;
	bool FShowOnceMore;
	bool FShowAgainChecked;
	bool FTimedShow;
	System::Classes::THelpContext FHelpCtx;
	Lmdtypes::TLMDString FShowAgainText;
	Lmdtypes::TLMDString FDlgCaption;
	bool FIsHTML;
	Vcl::Forms::TPosition FPosition;
	System::Classes::TNotifyEvent FOnBeforeShow;
	System::Classes::TNotifyEvent FOnTimer;
	TPromptCloseEvent FOnClose;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	TElPromptFormClass FClass;
	bool FParentFont;
	bool FParentCaptionFont;
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TFont* FCaptionFont;
	TElPromptForm* FForm;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	bool FUseXPThemes;
	bool FShowAccelChar;
	void __fastcall SetDisableCustomCaption(const bool Value);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall CloseTransfer(System::TObject* Sender, int Result);
	void __fastcall SetTexts(Lmdunicodestrings::TLMDWideStringArray* anArray);
	void __fastcall SetCaptions(Lmdunicodestrings::TLMDWideStringArray* anArray);
	void __fastcall SetControlTexts(Lmdunicodestrings::TLMDWideStringArray* newValue);
	TElPromptForm* __fastcall CreateWndx(void);
	void __fastcall SetParentFont(bool Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	void __fastcall SetParentCaptionFont(bool Value);
	void __fastcall SetCaptionFont(Vcl::Graphics::TFont* Value);
	void __fastcall FontChange(System::TObject* Sender);
	void __fastcall CaptionFontChange(System::TObject* Sender);
	
public:
	void *CustomData;
	__fastcall virtual TElPromptDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElPromptDialog(void);
	int __fastcall ShowModal(void);
	void __fastcall Show(void);
	virtual bool __fastcall Execute(void)/* overload */;
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property TElPromptFormClass FormClass = {read=FClass, write=FClass};
	
__published:
	__property int MaxWidth = {read=FMaxWidth, write=FMaxWidth, default=0};
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property bool DisableCustomCaption = {read=FDisableCustomCaption, write=SetDisableCustomCaption, default=0};
	__property bool DisableDefault = {read=FTimedShow, write=FTimedShow, default=0};
	__property System::Uitypes::TMsgDlgBtn DefaultButton = {read=FDefBtn, write=FDefBtn, default=0};
	__property System::Uitypes::TMsgDlgBtn CancelButton = {read=FCancelBtn, write=FCancelBtn, default=0};
	__property int TimeDelay = {read=FTimeLimit, write=FTimeLimit, default=0};
	__property bool ShowGlyphs = {read=FShowGlyphs, write=FShowGlyphs, default=0};
	__property Lmdunicodestrings::TLMDWideStringArray* Texts = {read=FTexts, write=SetTexts};
	__property Lmdunicodestrings::TLMDWideStringArray* ControlTexts = {read=FControlTexts, write=SetControlTexts};
	__property Lmdtypes::TLMDString DialogCaption = {read=FDlgCaption, write=FDlgCaption};
	__property Lmdtypes::TLMDString Message = {read=FMessage, write=FMessage};
	__property int MessageIdx = {read=FMessageIdx, write=FMessageIdx, default=-1};
	__property System::Uitypes::TMsgDlgType DlgType = {read=FDlgType, write=FDlgType, default=0};
	__property System::Uitypes::TMsgDlgButtons Buttons = {read=FButtons, write=FButtons, default=0};
	__property bool ShowAgainCheck = {read=FShowOnceMore, write=FShowOnceMore, default=0};
	__property bool ShowAgainChecked = {read=FShowAgainChecked, write=FShowAgainChecked, default=0};
	__property Lmdtypes::TLMDString ShowAgainText = {read=FShowAgainText, write=FShowAgainText};
	__property Lmdunicodestrings::TLMDWideStringArray* Captions = {read=FCaptions, write=SetCaptions};
	__property int CaptionIdx = {read=FCaptionIdx, write=FCaptionIdx, default=-1};
	__property System::Classes::THelpContext HelpContext = {read=FHelpCtx, write=FHelpCtx, default=0};
	__property bool IsHTML = {read=FIsHTML, write=FIsHTML, default=0};
	__property bool TopMost = {read=FTopmost, write=FTopmost, default=0};
	__property Vcl::Forms::TPosition Position = {read=FPosition, write=FPosition, default=0};
	__property System::Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=FOnTimer};
	__property TPromptCloseEvent OnClose = {read=FOnClose, write=FOnClose};
	__property System::Classes::TNotifyEvent OnBeforeShow = {read=FOnBeforeShow, write=FOnBeforeShow};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnHTMLImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property bool ParentFont = {read=FParentFont, write=SetParentFont, default=1};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool ParentCaptionFont = {read=FParentCaptionFont, write=SetParentCaptionFont, default=1};
	__property Vcl::Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property bool UseXPThemes = {read=FUseXPThemes, write=FUseXPThemes, default=1};
	__property bool ShowAccelChar = {read=FShowAccelChar, write=FShowAccelChar, nodefault};
	/* Hoisted overloads: */
	
public:
	inline bool __fastcall  Execute(HWND ParentWnd){ return Vcl::Dialogs::TCommonDialog::Execute(ParentWnd); }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TElPromptForm* ElPromptForm;
extern DELPHI_PACKAGE System::Word __fastcall ElMessageDlg(const Lmdtypes::TLMDString Msg, System::Uitypes::TMsgDlgType DlgType, System::Uitypes::TMsgDlgButtons Buttons, int HelpCtx);
extern DELPHI_PACKAGE System::Word __fastcall ElMessageDlgEx2(const Lmdtypes::TLMDString Msg, System::Uitypes::TMsgDlgType DlgType, System::Uitypes::TMsgDlgButtons Buttons, int HelpCtx, bool IsHTML, Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick);
extern DELPHI_PACKAGE System::Word __fastcall ElMessageDlgEx(const Lmdtypes::TLMDString Msg, System::Uitypes::TMsgDlgType DlgType, System::Uitypes::TMsgDlgButtons Buttons, int HelpCtx, TElPromptFormClass FormClass);
}	/* namespace Elpromptdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELPROMPTDLG)
using namespace Elpromptdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElpromptdlgHPP
