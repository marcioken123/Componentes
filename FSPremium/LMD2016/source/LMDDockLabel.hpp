// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDockLabel.pas' rev: 31.00 (Windows)

#ifndef LmddocklabelHPP
#define LmddocklabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomDockLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDGraph.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddocklabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDockLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDockLabel : public Lmdcustomdocklabel::TLMDCustomDockLabel
{
	typedef Lmdcustomdocklabel::TLMDCustomDockLabel inherited;
	
__published:
	__property About = {default=0};
	__property AdjustDockedSize = {index=0, default=0};
	__property Alignment = {default=0};
	__property AutoSize = {index=0, default=0};
	__property Caption = {default=0};
	__property Color = {default=-16777211};
	__property Docked = {index=1, default=1};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property Font;
	__property Font3D;
	__property Margin = {default=1};
	__property MultiLine = {index=1, default=0};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property Position = {default=1};
	__property ReflectOwnChanges = {index=2, default=0};
	__property ShowAccelChar = {index=2, default=1};
	__property ShowHint;
	__property Transparent = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TLMDCustomDockLabel.Create */ inline __fastcall virtual TLMDDockLabel(System::Classes::TComponent* aOwner) : Lmdcustomdocklabel::TLMDCustomDockLabel(aOwner) { }
	/* TLMDCustomDockLabel.Destroy */ inline __fastcall virtual ~TLMDDockLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddocklabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDOCKLABEL)
using namespace Lmddocklabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddocklabelHPP
