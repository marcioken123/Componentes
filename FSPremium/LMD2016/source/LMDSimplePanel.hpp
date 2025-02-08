// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSimplePanel.pas' rev: 31.00 (Windows)

#ifndef LmdsimplepanelHPP
#define LmdsimplepanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDClass.hpp>
#include <System.UITypes.hpp>
#include <LMDFaceController.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsimplepanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimplePanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSimplePanel : public Lmdcustombevelpanel::TLMDCustomBevelPanel
{
	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Winapi::Messages::TWMSize &Message);
	
protected:
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	
public:
	__fastcall virtual TLMDSimplePanel(System::Classes::TComponent* AOwner);
	__property CtlXP = {default=1};
	__property DockManager;
	
__published:
	__property ParentBackground = {default=0};
	__property NoHandleUpdate = {default=0};
	__property AllowMoving = {default=0};
	__property AllowSizing = {default=0};
	__property ControlLocked = {default=0};
	__property SizeGrip = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnMove;
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
	__property FaceController;
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
public:
	/* TLMDCustomBevelPanel.Destroy */ inline __fastcall virtual ~TLMDSimplePanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSimplePanel(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 defSizeGrip = System::Int8(0x10);
}	/* namespace Lmdsimplepanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSIMPLEPANEL)
using namespace Lmdsimplepanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsimplepanelHPP
