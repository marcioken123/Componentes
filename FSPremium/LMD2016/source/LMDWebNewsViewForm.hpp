// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebNewsViewForm.pas' rev: 31.00 (Windows)

#ifndef LmdwebnewsviewformHPP
#define LmdwebnewsviewformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <System.Classes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <LMDNews.hpp>
#include <LMDWebXML.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebnewsviewform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWebNewsViewForm_;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDOnNewsEvent)(System::TObject* Sender, Lmdwebxml::TLMDXMLTag* Item, const System::UnicodeString szURL);

class PASCALIMPLEMENTATION TLMDWebNewsViewForm_ : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel;
	Vcl::Comctrls::TStatusBar* StatusBar;
	Vcl::Comctrls::TAnimate* Animate;
	Vcl::Comctrls::TTreeView* NewsTreeView;
	Vcl::Comctrls::TToolBar* ToolBar;
	Vcl::Comctrls::TToolButton* GetNewsButton;
	Vcl::Comctrls::TToolButton* HelpButton;
	Vcl::Comctrls::TToolButton* PropertiesButton;
	Vcl::Controls::TImageList* ImageList1;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall LMDWebNewsComplete(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall NewsTreeViewMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall NewsTreeViewMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall GetNewsButtonClick(System::TObject* Sender);
	void __fastcall HelpButtonClick(System::TObject* Sender);
	void __fastcall PropertiesButtonClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall NewsTreeViewExit(System::TObject* Sender);
	
protected:
	void __fastcall AddToTree(Vcl::Comctrls::TTreeNode* Node, Lmdwebxml::TLMDXMLTags* Tags);
	
private:
	System::UnicodeString FHint;
	Lmdnews::TLMDWebNews* aNews;
	System::Classes::TNotifyEvent FOldEvent;
	TLMDOnNewsEvent FOnNewsClick;
	System::Classes::TNotifyEvent FOnNewsHint;
	System::Classes::TNotifyEvent FOnGetNewsClick;
	System::Classes::TNotifyEvent FOnHelpClick;
	System::Classes::TNotifyEvent FOnPropertiesClick;
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Msg);
	void __fastcall FireURL(Lmdwebxml::TLMDXMLTag* Item, const System::UnicodeString URL);
	
public:
	Lmdnews::TLMDWebNews* LMDWebNews;
	Vcl::Controls::TImageList* ImageList;
	bool bLoading;
	void __fastcall BuildTreeView(void);
	HIDESBASE void __fastcall OnClick(System::TObject* Sender, Lmdwebxml::TLMDXMLTag* Item, const System::UnicodeString szURL);
	void __fastcall OnHit(System::TObject* Sender);
	void __fastcall UpdateOnShow(Lmdnews::TLMDWebNews* News, Vcl::Controls::TImageList* Images);
	__property System::UnicodeString NewsHint = {read=FHint};
	
__published:
	__property TLMDOnNewsEvent OnNewsClick = {read=FOnNewsClick, write=FOnNewsClick};
	__property System::Classes::TNotifyEvent OnNewsHint = {read=FOnNewsHint, write=FOnNewsHint};
	__property System::Classes::TNotifyEvent OnGetNewsClick = {read=FOnGetNewsClick, write=FOnGetNewsClick};
	__property System::Classes::TNotifyEvent OnHelpClick = {read=FOnHelpClick, write=FOnHelpClick};
	__property System::Classes::TNotifyEvent OnPropertiesClick = {read=FOnPropertiesClick, write=FOnPropertiesClick};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDWebNewsViewForm_(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDWebNewsViewForm_(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDWebNewsViewForm_(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDWebNewsViewForm_(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebnewsviewform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBNEWSVIEWFORM)
using namespace Lmdwebnewsviewform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebnewsviewformHPP
