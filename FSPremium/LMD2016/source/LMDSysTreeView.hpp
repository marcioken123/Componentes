// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysTreeView.pas' rev: 31.00 (Windows)

#ifndef LmdsystreeviewHPP
#define LmdsystreeviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDSysBase.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsystreeview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysTreeView;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysTreeView : public Lmdcontrol::TLMDBaseTreeView
{
	typedef Lmdcontrol::TLMDBaseTreeView inherited;
	
public:
	__fastcall virtual TLMDSysTreeView(System::Classes::TComponent* AOwner);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoExpand = {default=0};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property ChangeDelay = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Constraints;
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property HotTrack = {default=0};
	__property Indent;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property RightClickSelect = {default=0};
	__property RowSelect = {default=0};
	__property ShowButtons = {default=1};
	__property ShowHint;
	__property ShowLines = {default=1};
	__property ShowRoot = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property ToolTips = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnChanging;
	__property OnClick;
	__property OnCollapsed;
	__property OnCollapsing;
	__property OnCompare;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnEnter;
	__property OnExit;
	__property OnExpanding;
	__property OnExpanded;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
public:
	/* TCustomTreeView.Destroy */ inline __fastcall virtual ~TLMDSysTreeView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSysTreeView(HWND ParentWindow) : Lmdcontrol::TLMDBaseTreeView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsystreeview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSTREEVIEW)
using namespace Lmdsystreeview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsystreeviewHPP
