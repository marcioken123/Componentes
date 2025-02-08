// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGroupBox.pas' rev: 31.00 (Windows)

#ifndef LmdgroupboxHPP
#define LmdgroupboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomGroupBox.hpp>
#include <Vcl.Controls.hpp>
#include <LMDControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>
#include <Vcl.Graphics.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdgroupbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGroupBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGroupBox : public Lmdcustomgroupbox::TLMDCustomGroupBox
{
	typedef Lmdcustomgroupbox::TLMDCustomGroupBox inherited;
	
__published:
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property BackFX;
	__property Bevel;
	__property Caption = {default=0};
	__property CaptionFont;
	__property CaptionFont3D;
	__property CaptionOffset = {default=8};
	__property CaptionParentFont = {default=1};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowAccelChar = {default=1};
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
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
public:
	/* TLMDCustomGroupBox.Create */ inline __fastcall virtual TLMDGroupBox(System::Classes::TComponent* AOwner) : Lmdcustomgroupbox::TLMDCustomGroupBox(AOwner) { }
	/* TLMDCustomGroupBox.Destroy */ inline __fastcall virtual ~TLMDGroupBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDGroupBox(HWND ParentWindow) : Lmdcustomgroupbox::TLMDCustomGroupBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdgroupbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGROUPBOX)
using namespace Lmdgroupbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgroupboxHPP
