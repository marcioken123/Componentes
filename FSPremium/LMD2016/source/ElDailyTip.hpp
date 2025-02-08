// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDailyTip.pas' rev: 31.00 (Windows)

#ifndef EldailytipHPP
#define EldailytipHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Math.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDElConst.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <ElPopBtn.hpp>
#include <ElBtnCtl.hpp>
#include <ElStrPool.hpp>
#include <ElStyleMan.hpp>
#include <ElXPThemedControl.hpp>
#include <ElComponent.hpp>
#include <ElHTMLLbl.hpp>
#include <ElCheckCtl.hpp>
#include <ElCLabel.hpp>
#include <ElLabel.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldailytip
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElDailyTipForm;
class DELPHICLASS TElDailyTipDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElDailyTipForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elpopbtn::TElPopupButton* OkBtn;
	Elpopbtn::TElPopupButton* NextBtn;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Extctrls::TPanel* Panel4;
	Ellabel::TElLabel* TipCaptionLabel;
	Vcl::Extctrls::TPanel* Panel5;
	Ellabel::TElLabel* TipNumLabel;
	Elhtmllbl::TElHTMLLabel* TipText;
	Elcheckctl::TElCheckBox* NextTimeCB;
	void __fastcall NextBtnClick(System::TObject* Sender);
	
private:
	int MinNum;
	int CurNum;
	int MaxNum;
	Elstrpool::TElStringPool* FStringPool;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElDailyTipForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElDailyTipForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElDailyTipForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDailyTipForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDailyTipDialog : public Elcomponent::TElBaseDlgComponent
{
	typedef Elcomponent::TElBaseDlgComponent inherited;
	
private:
	Lmdtypes::TLMDString FCaption;
	System::Classes::TNotifyEvent FOnBeforeShow;
	bool FShowNextTime;
	int FStartID;
	int FEndID;
	bool FShowTipNumber;
	Elstrpool::TElStringPool* FStringPool;
	bool FIsHTML;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	System::Uitypes::TColor FLinkColor;
	System::Uitypes::TFontStyles FLinkStyle;
	void __fastcall SetStringPool(Elstrpool::TElStringPool* newValue);
	void __fastcall SetStartID(int newValue);
	void __fastcall SetEndID(int newValue);
	void __fastcall SetIsHTML(bool newValue);
	
protected:
	bool FUseXPThemes;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	
public:
	virtual bool __fastcall Execute(void);
	__fastcall virtual TElDailyTipDialog(System::Classes::TComponent* AOwner);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	
__published:
	__property bool ShowNextTime = {read=FShowNextTime, write=FShowNextTime, nodefault};
	__property int StartID = {read=FStartID, write=SetStartID, default=10001};
	__property int EndID = {read=FEndID, write=SetEndID, default=10001};
	__property bool ShowTipNumber = {read=FShowTipNumber, write=FShowTipNumber, default=1};
	__property Elstrpool::TElStringPool* StringPool = {read=FStringPool, write=SetStringPool};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=FCaption};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, nodefault};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property System::Classes::TNotifyEvent OnBeforeShow = {read=FOnBeforeShow, write=FOnBeforeShow};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, nodefault};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, nodefault};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property bool UseXPThemes = {read=FUseXPThemes, write=FUseXPThemes, default=1};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TElDailyTipDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TElDailyTipForm* ElDailyTipForm;
}	/* namespace Eldailytip */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDAILYTIP)
using namespace Eldailytip;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldailytipHPP
