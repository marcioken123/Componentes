// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGlyphLabel.pas' rev: 31.00 (Windows)

#ifndef LmdglyphlabelHPP
#define LmdglyphlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomGlyphLabel.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdglyphlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGlyphLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGlyphLabel : public Lmdcustomglyphlabel::TLMDCustomGlyphLabel
{
	typedef Lmdcustomglyphlabel::TLMDCustomGlyphLabel inherited;
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment;
	__property AutoSize = {index=0, default=1};
	__property Bevel;
	__property Caption = {default=0};
	__property Color = {default=-16777211};
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property Font;
	__property Font3D;
	__property GlyphNumber = {default=1};
	__property GlyphColumn = {default=0};
	__property Hint = {default=0};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property MultiLine = {index=1, default=0};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
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
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TLMDCustomGlyphLabel.Create */ inline __fastcall virtual TLMDGlyphLabel(System::Classes::TComponent* aOwner) : Lmdcustomglyphlabel::TLMDCustomGlyphLabel(aOwner) { }
	/* TLMDCustomGlyphLabel.Destroy */ inline __fastcall virtual ~TLMDGlyphLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdglyphlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGLYPHLABEL)
using namespace Lmdglyphlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdglyphlabelHPP
