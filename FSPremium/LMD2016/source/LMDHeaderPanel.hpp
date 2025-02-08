// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHeaderPanel.pas' rev: 31.00 (Windows)

#ifndef LmdheaderpanelHPP
#define LmdheaderpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomHeaderPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDButtonBase.hpp>
#include <LMDClass.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdheaderpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHeaderPanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHeaderPanel : public Lmdcustomheaderpanel::TLMDCustomHeaderPanel
{
	typedef Lmdcustomheaderpanel::TLMDCustomHeaderPanel inherited;
	
public:
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property AllowMoving = {default=0};
	__property AllowSizing = {default=0};
	__property BackFX;
	__property Bevel;
	__property FillObject;
	__property Caption = {default=0};
	__property HeaderHeight = {default=0};
	__property Font;
	__property HeaderDropMenu;
	__property HeaderOptions = {default=0};
	__property SysButtonMode = {default=1};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ButtonStyle = {default=8};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Transparent = {default=0};
	__property ParentBackground = {default=0};
	__property Align = {default=0};
	__property Color = {default=-16777201};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property UseDockManager = {default=0};
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
	__property OnResize;
	__property OnStartDrag;
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property OnOpen;
	__property OnOpenFixed;
	__property OnClose;
	__property OnHeaderButtonClick;
	__property OnSystemButtonClick;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TLMDCustomHeaderPanel.Create */ inline __fastcall virtual TLMDHeaderPanel(System::Classes::TComponent* AOwner) : Lmdcustomheaderpanel::TLMDCustomHeaderPanel(AOwner) { }
	/* TLMDCustomHeaderPanel.Destroy */ inline __fastcall virtual ~TLMDHeaderPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHeaderPanel(HWND ParentWindow) : Lmdcustomheaderpanel::TLMDCustomHeaderPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdheaderpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHEADERPANEL)
using namespace Lmdheaderpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdheaderpanelHPP
