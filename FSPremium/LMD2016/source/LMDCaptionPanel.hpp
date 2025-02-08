// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCaptionPanel.pas' rev: 31.00 (Windows)

#ifndef LmdcaptionpanelHPP
#define LmdcaptionpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDObject.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDPanelCaptionObject.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcaptionpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCaptionPanelClient;
class DELPHICLASS TLMDCaptionPanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCaptionPanelClient : public Lmdcustompanel::TLMDCustomPanel
{
	typedef Lmdcustompanel::TLMDCustomPanel inherited;
	
private:
	System::Classes::TComponent* FParent;
	
protected:
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	DYNAMIC void __fastcall Click(void);
	
public:
	DYNAMIC System::Classes::TComponent* __fastcall GetParentComponent(void);
	__fastcall virtual TLMDCaptionPanelClient(System::Classes::TComponent* AOwner);
	__property Canvas;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnClick;
	__property OnDblClick;
	__property Transparent = {default=0};
	
__published:
	__property Height = {stored=false};
	__property Left = {stored=false};
	__property Top = {stored=false};
	__property Width = {stored=false};
	__property TabStop = {stored=false, default=0};
	__property TabOrder = {stored=false, default=-1};
	__property UseDockManager = {stored=false, default=0};
	__property ParentColor = {stored=false, default=0};
public:
	/* TLMDCustomPanel.Destroy */ inline __fastcall virtual ~TLMDCaptionPanelClient(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCaptionPanelClient(HWND ParentWindow) : Lmdcustompanel::TLMDCustomPanel(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TLMDCaptionPanelRequestEvent)(System::TObject* Sender, bool &Cancel);

typedef void __fastcall (__closure *TLMDCaptionPanelDrawEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);

class PASCALIMPLEMENTATION TLMDCaptionPanel : public Lmdcustombevelpanel::TLMDCustomBevelPanel
{
	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;
	
private:
	int FHeight;
	int FIndex;
	Lmdpanelcaptionobject::TLMDPanelCaptionObject* FCaptionSettings;
	bool FExpanded;
	TLMDCaptionPanelDrawEvent FOnCaptionDraw;
	TLMDCaptionPanelRequestEvent FOnCloseBtnClick;
	TLMDCaptionPanelRequestEvent FOnCollapsing;
	TLMDCaptionPanelRequestEvent FOnExpanding;
	System::Classes::TNotifyEvent FOnHelpBtnClick;
	System::Classes::TNotifyEvent FOnCollapsed;
	System::Classes::TNotifyEvent FOnExpanded;
	Vcl::Controls::TCaption FCaption;
	System::Classes::TList* FButtonList;
	TLMDCaptionPanelClient* FClient;
	System::UnicodeString FCustomData;
	void __fastcall WriteInteger(System::Classes::TWriter* Writer);
	void __fastcall ReadInteger(System::Classes::TReader* Reader);
	void __fastcall SetCaptionSettings(Lmdpanelcaptionobject::TLMDPanelCaptionObject* const Value);
	void __fastcall SetExpanded(const bool Value);
	void __fastcall SetCaption(const Vcl::Controls::TCaption Value);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTransparentChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Message);
	HIDESBASE void __fastcall SetIndex(const int Value);
	System::Classes::TComponent* __fastcall GetPanelGroup(void);
	void __fastcall PassMouseEventsToClient(void);
	
protected:
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner(void);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &aRect);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &aRect);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DoClick(System::TObject* Sender);
	virtual void __fastcall DoMove(void);
	HIDESBASE void __fastcall DoMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE void __fastcall DoMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoMouseClick(System::TObject* Sender);
	void __fastcall DoMouseDblClick(System::TObject* Sender);
	System::Types::TRect __fastcall GetCaptionRect(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual System::Types::TRect __fastcall GetMoveRect(void);
	void __fastcall InitButtonList(void);
	void __fastcall ClearButtonList(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	void __fastcall PaintCaptionBar(const System::Types::TRect &aRect);
	__property int InternalSize = {read=FHeight, write=FHeight, nodefault};
	
public:
	__fastcall virtual TLMDCaptionPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCaptionPanel(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall Change(void);
	void __fastcall Expand(void);
	void __fastcall Collapse(void);
	void __fastcall SetSilentIndex(int Index);
	__property TLMDCaptionPanelClient* ClientPanel = {read=FClient};
	__property DockManager;
	__property System::Classes::TComponent* PanelGroup = {read=GetPanelGroup};
	
__published:
	__property int PanelIndex = {read=FIndex, write=SetIndex, default=0};
	__property Vcl::Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property Lmdpanelcaptionobject::TLMDPanelCaptionObject* CaptionSettings = {read=FCaptionSettings, write=SetCaptionSettings};
	__property System::UnicodeString CustomData = {read=FCustomData, write=FCustomData};
	__property bool Expanded = {read=FExpanded, write=SetExpanded, default=1};
	__property TLMDCaptionPanelRequestEvent OnCloseBtnClick = {read=FOnCloseBtnClick, write=FOnCloseBtnClick};
	__property System::Classes::TNotifyEvent OnHelpBtnClick = {read=FOnHelpBtnClick, write=FOnHelpBtnClick};
	__property TLMDCaptionPanelRequestEvent OnCollapsing = {read=FOnCollapsing, write=FOnCollapsing};
	__property TLMDCaptionPanelRequestEvent OnExpanding = {read=FOnExpanding, write=FOnExpanding};
	__property System::Classes::TNotifyEvent OnCollapsed = {read=FOnCollapsed, write=FOnCollapsed};
	__property System::Classes::TNotifyEvent OnExpanded = {read=FOnExpanded, write=FOnExpanded};
	__property TLMDCaptionPanelDrawEvent OnCaptionDraw = {read=FOnCaptionDraw, write=FOnCaptionDraw};
	__property OnMove;
	__property AllowSizing = {default=0};
	__property AllowMoving = {default=1};
	__property AutoBringToFront = {default=1};
	__property ControlLocked = {default=0};
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property UseDockManager = {default=0};
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property About = {default=0};
	__property Align = {default=0};
	__property Bevel;
	__property Color = {default=-16777201};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Locked = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
	__property OnContextPopup;
	__property OnMouseActivate;
	__property ThemeGlobalMode = {default=0};
	__property ThemeMode = {default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCaptionPanel(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 def_CaptionButtonReduce = System::Int8(0x3);
static const System::Int8 def_GroupScrollBar = System::Int8(0x10);
}	/* namespace Lmdcaptionpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCAPTIONPANEL)
using namespace Lmdcaptionpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcaptionpanelHPP
