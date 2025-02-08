// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDAssist.pas' rev: 31.00 (Windows)

#ifndef LmdassistHPP
#define LmdassistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDButton.hpp>
#include <LMDConst.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdassist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAssistPage;
class DELPHICLASS TLMDAssist;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDAssistPage : public Lmdcustompanel::TLMDCustomPanel
{
	typedef Lmdcustompanel::TLMDCustomPanel inherited;
	
private:
	TLMDAssist* FAssistControl;
	bool FInclude;
	Lmdbase::TLMDStandardEvent FOnComplete;
	System::Classes::TNotifyEvent FOnBeforeShowPage;
	System::Classes::TNotifyEvent FOnAfterShowPage;
	Lmdbase::TLMDStandardEvent FOnNextPage;
	Lmdbase::TLMDStandardEvent FOnPrevPage;
	void __fastcall SetAssistControl(TLMDAssist* aValue);
	void __fastcall SetInclude(bool aValue);
	void __fastcall SetPageIndex(int aValue);
	int __fastcall GetPageIndex(void);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	__property Visible = {default=0};
	
public:
	__fastcall virtual TLMDAssistPage(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDAssistPage(void);
	bool __fastcall CheckCompleted(void);
	__property TLMDAssist* AssistControl = {read=FAssistControl, write=SetAssistControl};
	__property bool Completed = {read=CheckCompleted, nodefault};
	
__published:
	__property About = {default=0};
	__property Align = {default=5};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property bool Included = {read=FInclude, write=SetInclude, default=1};
	__property int PageIndex = {read=GetPageIndex, write=SetPageIndex, stored=false, nodefault};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Transparent = {default=0};
	__property ParentBackground = {default=1};
	__property Lmdbase::TLMDStandardEvent OnCompleted = {read=FOnComplete, write=FOnComplete};
	__property Lmdbase::TLMDStandardEvent OnNextPage = {read=FOnNextPage, write=FOnNextPage};
	__property Lmdbase::TLMDStandardEvent OnPrevPage = {read=FOnPrevPage, write=FOnPrevPage};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnContextPopup;
	__property OnMouseActivate;
	__property System::Classes::TNotifyEvent OnBeforeShowPage = {read=FOnBeforeShowPage, write=FOnBeforeShowPage};
	__property System::Classes::TNotifyEvent OnAfterShowPage = {read=FOnAfterShowPage, write=FOnAfterShowPage};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDAssistPage(HWND ParentWindow) : Lmdcustompanel::TLMDCustomPanel(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TLMDAssistOption : unsigned char { aoAutoBtnSet, aoSuppressLoadEvent };

typedef System::Set<TLMDAssistOption, TLMDAssistOption::aoAutoBtnSet, TLMDAssistOption::aoSuppressLoadEvent> TLMDAssistOptions;

enum DECLSPEC_DENUM TLMDAssistButton : unsigned char { abCustom, abHelp, abCancel };

typedef System::Set<TLMDAssistButton, TLMDAssistButton::abCustom, TLMDAssistButton::abCancel> TLMDAssistButtons;

enum DECLSPEC_DENUM TLMDInternalButtons : unsigned char { btnCustom, btnhelp, btnPrev, btnNext, btnCancel };

enum DECLSPEC_DENUM TLMDInternalButtonStrings : unsigned char { asCustom, asHelp, asPrev, asNext, asCancel, asFinish, asClose };

typedef void __fastcall (__closure *TLMDAssistPageChangeEvent)(System::TObject* Sender, TLMDAssistPage* NewPage, bool &Cancel);

class PASCALIMPLEMENTATION TLMDAssist : public Lmdcustompanel::TLMDCustomPanel
{
	typedef Lmdcustompanel::TLMDCustomPanel inherited;
	
private:
	TLMDAssistPage* FActivePage;
	TLMDAssistButtons FButtons;
	System::StaticArray<Lmdbutton::TLMDButton*, 5> FBtns;
	bool FShowLine;
	bool FCompleted;
	System::Classes::TStrings* FCustomStrings;
	int FLineMargin;
	int FBtnWidth;
	int FBtnGap;
	int FBtnMargin;
	int FBtnHeight;
	System::Classes::TNotifyEvent FOnCancel;
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TNotifyEvent FOnCustom;
	Lmdbase::TLMDStandardEvent FOnComplete;
	TLMDAssistPageChangeEvent FOnPageChange;
	System::Classes::TList* FPages;
	System::Types::TRect FCRect;
	TLMDAssistOptions FOptions;
	void __fastcall SetActivePage(TLMDAssistPage* aValue);
	void __fastcall SetButtons(TLMDAssistButtons aValue);
	HIDESBASE void __fastcall SetBoolean(int Index, bool aValue);
	void __fastcall SetButtonCaption(TLMDInternalButtons Index, TLMDInternalButtonStrings aValue);
	void __fastcall SetCustomStrings(System::Classes::TStrings* aValue);
	void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetMoveBtnState(void);
	int __fastcall GetCount(void);
	Lmdbutton::TLMDButton* __fastcall GetButton(TLMDInternalButtons Index);
	System::UnicodeString __fastcall GetButtonCaption(int Index);
	TLMDAssistPage* __fastcall GetPage(int Index);
	void __fastcall OnBtnsClick(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Winapi::Messages::TWMEraseBkgnd &Message);
	void __fastcall SetOptions(const TLMDAssistOptions Value);
	
protected:
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* aControl, System::Types::TRect &AnRect);
	void __fastcall AssignBtnCaptions(void);
	void __fastcall AssignBtnProperties(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall DoCustomStringsChange(System::TObject* Sender);
	TLMDAssistPage* __fastcall FindNextPage(TLMDAssistPage* CurPage, bool GoForward, bool CheckInclude);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner(void);
	
public:
	__fastcall virtual TLMDAssist(System::Classes::TComponent* AnOwner);
	__fastcall virtual ~TLMDAssist(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	void __fastcall FirstPage(void);
	void __fastcall InitPages(void);
	void __fastcall InsertPage(TLMDAssistPage* aValue);
	void __fastcall LastPage(void);
	void __fastcall MovePage(int OldIndex, int NewIndex);
	void __fastcall NextPage(void);
	void __fastcall PrevPage(void);
	void __fastcall RemovePage(TLMDAssistPage* aValue);
	void __fastcall VerifyNext(void);
	__property int Count = {read=GetCount, nodefault};
	__property bool Completed = {read=FCompleted, write=SetBoolean, index=0, nodefault};
	__property Lmdbutton::TLMDButton* Button[TLMDInternalButtons Index] = {read=GetButton};
	__property CtlXP = {default=0};
	__property TLMDAssistPage* Page[int Index] = {read=GetPage};
	
__published:
	__property About = {default=0};
	__property TLMDAssistPage* ActivePage = {read=FActivePage, write=SetActivePage};
	__property Align = {default=5};
	__property int BtnGap = {read=FBtnGap, write=SetInteger, index=0, default=8};
	__property int BtnHeight = {read=FBtnHeight, write=SetInteger, index=1, default=25};
	__property int BtnMargin = {read=FBtnMargin, write=SetInteger, index=2, default=12};
	__property int BtnWidth = {read=FBtnWidth, write=SetInteger, index=3, default=75};
	__property Color = {default=-16777201};
	__property ParentBackground = {default=0};
	__property System::Classes::TStrings* CustomStrings = {read=FCustomStrings, write=SetCustomStrings};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property TLMDAssistButtons Buttons = {read=FButtons, write=SetButtons, default=4};
	__property int LineMargin = {read=FLineMargin, write=SetInteger, index=4, default=4};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property bool ShowLine = {read=FShowLine, write=SetBoolean, index=1, default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property ThemeMode = {default=0};
	__property ThemeGlobalMode = {default=0};
	__property Visible = {default=1};
	__property Transparent = {default=0};
	__property TLMDAssistOptions Options = {read=FOptions, write=SetOptions, default=3};
	__property System::Classes::TNotifyEvent OnCancelClick = {read=FOnCancel, write=FOnCancel};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnCustomClick = {read=FOnCustom, write=FOnCustom};
	__property Lmdbase::TLMDStandardEvent OnCompleted = {read=FOnComplete, write=FOnComplete};
	__property TLMDAssistPageChangeEvent OnChanging = {read=FOnPageChange, write=FOnPageChange};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnContextPopup;
	__property OnMouseActivate;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDAssist(HWND ParentWindow) : Lmdcustompanel::TLMDCustomPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdassist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDASSIST)
using namespace Lmdassist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdassistHPP
