// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMemo.pas' rev: 31.00 (Windows)

#ifndef LmdmemoHPP
#define LmdmemoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomMemo.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <LMDCaret.hpp>
#include <System.UITypes.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>
#include <LMDSBar.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmemo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMemo;
class DELPHICLASS TLMDLabeledMemo;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMemo : public Lmdcustommemo::TLMDCustomMemo
{
	typedef Lmdcustommemo::TLMDCustomMemo inherited;
	
public:
	__property Column;
	__property Row;
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property AskForLoop = {default=1};
	__property Bevel;
	__property Caret;
	__property Color = {default=-16777211};
	__property Cursor = {default=-4};
	__property DragCursor = {default=-12};
	__property DraggingAllowed = {default=1};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Flat = {default=0};
	__property FocusOnMouseAbove = {index=6, default=0};
	__property Font;
	__property Font3D;
	__property Height;
	__property HelpContext = {default=0};
	__property HideSelection = {index=0, default=1};
	__property HighlightBack = {default=-16777203};
	__property HighlightText = {default=-16777202};
	__property Hint;
	__property IgnoreLastEmptyLine = {default=0};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property Left;
	__property Lined = {index=3, default=0};
	__property Lines;
	__property LineGap = {default=2};
	__property LineStyle;
	__property ListIndex = {index=1, default=0};
	__property Margin;
	__property Name = {default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {index=1, default=0};
	__property ScrollBars = {default=4};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property TabChars = {default=8};
	__property Tag = {default=0};
	__property Text;
	__property Top;
	__property Transparent = {default=0};
	__property Visible = {default=1};
	__property WantReturns = {index=2, default=1};
	__property WantTabs = {index=1, default=0};
	__property Width;
	__property WordWrap = {index=0, default=1};
	__property HorizScrollBar;
	__property VertScrollBar;
	__property OnAfterEnter;
	__property OnAfterExit;
	__property OnChange;
	__property OnClick;
	__property OnCurrentRowChanged;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMarginRowPaint;
	__property OnModified;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnRowCountChanged;
	__property OnStartDrag;
	__property OnTextChangedAt;
	__property OnCursorPosChanged;
public:
	/* TLMDCustomMemo.Create */ inline __fastcall virtual TLMDMemo(System::Classes::TComponent* aOwner) : Lmdcustommemo::TLMDCustomMemo(aOwner) { }
	/* TLMDCustomMemo.Destroy */ inline __fastcall virtual ~TLMDMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDMemo(HWND ParentWindow) : Lmdcustommemo::TLMDCustomMemo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledMemo : public TLMDMemo
{
	typedef TLMDMemo inherited;
	
public:
	__fastcall virtual TLMDLabeledMemo(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomMemo.Destroy */ inline __fastcall virtual ~TLMDLabeledMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledMemo(HWND ParentWindow) : TLMDMemo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmemo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMEMO)
using namespace Lmdmemo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmemoHPP
