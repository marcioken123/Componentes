// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomSheetControl.pas' rev: 31.00 (Windows)

#ifndef LmdcustomsheetcontrolHPP
#define LmdcustomsheetcontrolHPP

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
#include <Vcl.Themes.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDBase.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomsheetcontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomSheet;
class DELPHICLASS TLMDCustomSheetControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomSheet : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	TLMDCustomSheetControl* FSheetControl;
	bool FInclude;
	System::Classes::TNotifyEvent FOnBeforeShowPage;
	System::Classes::TNotifyEvent FOnAfterShowPage;
	Lmdbase::TLMDStandardEvent FOnNextPage;
	System::UnicodeString FDescription;
	void __fastcall SetSheetControl(TLMDCustomSheetControl* aValue);
	void __fastcall SetInclude(bool aValue);
	void __fastcall SetPageIndex(int aValue);
	int __fastcall GetPageIndex(void);
	
protected:
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	__property Visible = {default=0};
	
public:
	__fastcall virtual TLMDCustomSheet(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomSheet(void);
	__property TLMDCustomSheetControl* SheetControl = {read=FSheetControl, write=SetSheetControl};
	__property Align = {default=5};
	__property bool Included = {read=FInclude, write=SetInclude, default=1};
	
__published:
	__property About = {default=0};
	__property Bevel;
	__property Caption = {default=0};
	__property System::UnicodeString Description = {read=FDescription, write=FDescription};
	__property int PageIndex = {read=GetPageIndex, write=SetPageIndex, stored=false, nodefault};
	__property System::Classes::TNotifyEvent OnBeforeShowPage = {read=FOnBeforeShowPage, write=FOnBeforeShowPage};
	__property System::Classes::TNotifyEvent OnAfterShowPage = {read=FOnAfterShowPage, write=FOnAfterShowPage};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBackground = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
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
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomSheet(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


typedef System::TMetaClass* TLMDSheetClass;

class PASCALIMPLEMENTATION TLMDCustomSheetControl : public Lmdcustompanel::TLMDCustomPanel
{
	typedef Lmdcustompanel::TLMDCustomPanel inherited;
	
private:
	bool FAutoFocus;
	TLMDCustomSheet* FActivePage;
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TList* FPages;
	bool FSaveResources;
	bool FStartFirstPage;
	void __fastcall SetPageIndex(int aValue);
	void __fastcall SetActiveSheet(TLMDCustomSheet* aValue);
	TLMDCustomSheet* __fastcall GetSheet(int Index);
	int __fastcall GetPageIndex(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Winapi::Messages::TWMEraseBkgnd &Message);
	
protected:
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* aControl, System::Types::TRect &Rect);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall CleanResources(void);
	void __fastcall DoChange(void);
	virtual void __fastcall DoPageChange(TLMDCustomSheet* NewPage, bool &Cancel) = 0 ;
	TLMDCustomSheet* __fastcall FindNextPage(TLMDCustomSheet* CurPage, bool GoForward, bool CheckInclude);
	TLMDCustomSheet* __fastcall FindNewActiveSheet(TLMDCustomSheet* CurPage);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	int __fastcall GetCount(void);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner(void);
	virtual bool __fastcall GetVisible(int Index);
	virtual int __fastcall GetVisibleCount(void);
	__property int PageIndex = {read=GetPageIndex, write=SetPageIndex, stored=false, nodefault};
	
public:
	__fastcall virtual TLMDCustomSheetControl(System::Classes::TComponent* AnOwner);
	__fastcall virtual ~TLMDCustomSheetControl(void);
	virtual TLMDSheetClass __fastcall GetSheetClass(void) = 0 ;
	__property bool AutoFocus = {read=FAutoFocus, write=FAutoFocus, default=1};
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	void __fastcall ActivePageByCaption(const System::UnicodeString aValue);
	void __fastcall ActivePageByName(const System::UnicodeString aValue);
	virtual void __fastcall FirstPage(void);
	void __fastcall InitPages(void);
	void __fastcall InsertPage(TLMDCustomSheet* aValue, bool Active = true);
	void __fastcall LastPage(void);
	virtual void __fastcall MovePage(int OldIndex, int NewIndex);
	void __fastcall NextPage(void);
	void __fastcall PrevPage(void);
	void __fastcall RemovePage(TLMDCustomSheet* aValue);
	void __fastcall FreePage(TLMDCustomSheet* aValue);
	void __fastcall FreePages(void);
	__property System::Classes::TList* Sheets = {read=FPages};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDCustomSheet* Sheet[int Index] = {read=GetSheet};
	__property TLMDCustomSheet* ActiveSheet = {read=FActivePage, write=SetActiveSheet};
	__property CtlXP = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	
__published:
	__property About = {default=0};
	__property Transparent = {default=0};
	__property bool SaveResources = {read=FSaveResources, write=FSaveResources, default=0};
	__property bool StartFirstPage = {read=FStartFirstPage, write=FStartFirstPage, default=1};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Align = {default=0};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
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
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomSheetControl(HWND ParentWindow) : Lmdcustompanel::TLMDCustomPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomsheetcontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMSHEETCONTROL)
using namespace Lmdcustomsheetcontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomsheetcontrolHPP
