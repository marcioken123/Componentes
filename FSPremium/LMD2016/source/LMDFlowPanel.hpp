// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFlowPanel.pas' rev: 31.00 (Windows)

#ifndef LmdflowpanelHPP
#define LmdflowpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Contnrs.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDTypes.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdflowpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomFlowPanel;
class DELPHICLASS TLMDFlowPanel;
class DELPHICLASS TLMDFlowPanelSeparator;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDFlowStyle : unsigned char { lfsLeftRightTopBottom, lfsRightLeftTopBottom, lfsLeftRightBottomTop, lfsRightLeftBottomTop, lfsTopBottomLeftRight, lfsBottomTopLeftRight, lfsTopBottomRightLeft, lfsBottomTopRightLeft };

class PASCALIMPLEMENTATION TLMDCustomFlowPanel : public Lmdcustombevelpanel::TLMDCustomBevelPanel
{
	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;
	
private:
	System::Contnrs::TObjectList* FControlList;
	bool FAutoWrap;
	TLMDFlowStyle FFlowStyle;
	int FControlsPaddingX;
	int FControlsPaddingY;
	Lmdtypes::TLMDMargins* FBorderMargins;
	Lmdgraph::TLMDVerticalAlign FVerticalAlign;
	void __fastcall SetAutoWrap(bool Value);
	void __fastcall SetLMDFlowStyle(TLMDFlowStyle Value);
	HIDESBASE MESSAGE void __fastcall CMControlListChanging(Vcl::Controls::TCMControlListChanging &Message);
	void __fastcall SetBorderMargins(Lmdtypes::TLMDMargins* const Value);
	void __fastcall SetControlsPaddingX(const int Value);
	void __fastcall SetControlsPaddingY(const int Value);
	void __fastcall SetVerticalAlign(const Lmdgraph::TLMDVerticalAlign Value);
	
protected:
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual bool __fastcall CanResize(int &ANewWidth, int &ANewHeight);
	void __fastcall DoBordersMarginChanged(System::TObject* Sender);
	virtual void __fastcall DoThemeChanged(void);
	__property bool AutoWrap = {read=FAutoWrap, write=SetAutoWrap, default=1};
	__property TLMDFlowStyle FlowStyle = {read=FFlowStyle, write=SetLMDFlowStyle, default=0};
	__property Lmdtypes::TLMDMargins* BorderMargins = {read=FBorderMargins, write=SetBorderMargins};
	__property int ControlsPaddingX = {read=FControlsPaddingX, write=SetControlsPaddingX, default=3};
	__property int ControlsPaddingY = {read=FControlsPaddingY, write=SetControlsPaddingY, default=3};
	__property Lmdgraph::TLMDVerticalAlign VerticalAlign = {read=FVerticalAlign, write=SetVerticalAlign, default=0};
	
public:
	__fastcall virtual TLMDCustomFlowPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomFlowPanel(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	int __fastcall GetControlIndex(Vcl::Controls::TControl* AControl);
	void __fastcall SetControlIndex(Vcl::Controls::TControl* AControl, int Index);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomFlowPanel(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDFlowPanel : public TLMDCustomFlowPanel
{
	typedef TLMDCustomFlowPanel inherited;
	
public:
	__property DockManager;
	
__published:
	__property Align = {default=0};
	__property Bevel;
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property AutoWrap = {default=1};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderWidth = {default=0};
	__property Caption = {default=0};
	__property Color = {default=-16777201};
	__property Constraints;
	__property Ctl3D;
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property FlowStyle = {default=0};
	__property Locked = {default=0};
	__property BorderMargins;
	__property ControlsPaddingX = {default=3};
	__property ControlsPaddingY = {default=3};
	__property ParentBiDiMode = {default=1};
	__property ParentBackground = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property VerticalAlign = {default=0};
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
public:
	/* TLMDCustomFlowPanel.Create */ inline __fastcall virtual TLMDFlowPanel(System::Classes::TComponent* AOwner) : TLMDCustomFlowPanel(AOwner) { }
	/* TLMDCustomFlowPanel.Destroy */ inline __fastcall virtual ~TLMDFlowPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFlowPanel(HWND ParentWindow) : TLMDCustomFlowPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDFlowPanelSeparator : public Vcl::Controls::TWinControl
{
	typedef Vcl::Controls::TWinControl inherited;
	
public:
	__fastcall virtual TLMDFlowPanelSeparator(System::Classes::TComponent* AComponent);
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFlowPanelSeparator(HWND ParentWindow) : Vcl::Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TLMDFlowPanelSeparator(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdflowpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFLOWPANEL)
using namespace Lmdflowpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdflowpanelHPP
