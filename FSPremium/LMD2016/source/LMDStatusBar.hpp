// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStatusBar.pas' rev: 31.00 (Windows)

#ifndef LmdstatusbarHPP
#define LmdstatusbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomStatusBar.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMD3DCaption.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstatusbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStatusBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStatusBar : public Lmdcustomstatusbar::TLMDCustomStatusBar
{
	typedef Lmdcustomstatusbar::TLMDCustomStatusBar inherited;
	
public:
	__property CtlXP = {default=1};
	
__published:
	__property Alignment = {default=0};
	__property Font3D;
	__property SimpleText = {default=0};
	__property SimplePanel = {index=0, default=0};
	__property SizeGrip = {default=1};
	__property OldStyle = {index=2, default=1};
	__property AutoSizeLastPanel = {index=3, default=1};
	__property ControlGap = {default=0};
	__property Panels;
	__property OnOwnerDrawPanel;
	__property OnPanelClick;
	__property ValidationPanelNumber;
	__property Bevel;
	__property Align = {default=0};
	__property Color = {default=-16777201};
	__property Cursor = {default=0};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property Font;
	__property Height;
	__property HelpContext = {default=0};
	__property Hint;
	__property Left;
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Top;
	__property Visible = {default=1};
	__property Width;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TLMDCustomStatusBar.Create */ inline __fastcall virtual TLMDStatusBar(System::Classes::TComponent* aOwner) : Lmdcustomstatusbar::TLMDCustomStatusBar(aOwner) { }
	/* TLMDCustomStatusBar.Destroy */ inline __fastcall virtual ~TLMDStatusBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDStatusBar(HWND ParentWindow) : Lmdcustomstatusbar::TLMDCustomStatusBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstatusbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTATUSBAR)
using namespace Lmdstatusbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstatusbarHPP
