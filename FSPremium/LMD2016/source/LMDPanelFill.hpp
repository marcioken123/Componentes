// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPanelFill.pas' rev: 31.00 (Windows)

#ifndef LmdpanelfillHPP
#define LmdpanelfillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDClass.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDControl.hpp>
#include <LMDCustomPanel.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDGraph.hpp>
#include <LMDFaceController.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDFXCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpanelfill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPanelFill;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDPanelFill : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
public:
	__fastcall virtual TLMDPanelFill(System::Classes::TComponent* AOwner);
	__property DockManager;
	
__published:
	__property ParentBackground = {default=0};
	__property NoHandleUpdate = {default=0};
	__property FDSupport = {default=0};
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
	__property Alignment = {default=4};
	__property FaceController;
	__property BackFX;
	__property BackFXPass = {default=0};
	__property Bevel;
	__property Caption = {default=0};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FillObject;
	__property Font;
	__property FontFX;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property Locked = {default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property TransparentBorder = {default=0};
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
public:
	/* TLMDCustomPanelFill.Destroy */ inline __fastcall virtual ~TLMDPanelFill(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPanelFill(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdpanelfill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPANELFILL)
using namespace Lmdpanelfill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpanelfillHPP
