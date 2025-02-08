// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdcomboboxHPP
#define LmdcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDThemedComboBox.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDComboBox;
class DELPHICLASS TLMDLabeledComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDComboBox : public Lmdcustomcombobox::TLMDCustomComboBox
{
	typedef Lmdcustomcombobox::TLMDCustomComboBox inherited;
	
public:
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {index=0, default=0};
	__property Enabled = {default=1};
	__property Flat = {index=0, default=0};
	__property FocusControl;
	__property Font;
	__property Height;
	__property HelpContext = {default=0};
	__property Hint = {default=0};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ItemHeight;
	__property Items;
	__property Interval = {default=1500};
	__property Left;
	__property MaxLength = {default=0};
	__property MRUList = {index=1, default=0};
	__property MRUMax = {index=1, default=5};
	__property Name = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentThemeMode = {default=1};
	__property PopupMenu;
	__property Search = {default=0};
	__property ShowHint;
	__property Sorted = {default=0};
	__property Style = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Tag = {default=0};
	__property Text = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Top;
	__property UseGlobalTimer = {default=0};
	__property Visible = {default=1};
	__property Width;
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnCloseUp;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEditClick;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnSelect;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TLMDCustomComboBox.Create */ inline __fastcall virtual TLMDComboBox(System::Classes::TComponent* aOwner) : Lmdcustomcombobox::TLMDCustomComboBox(aOwner) { }
	/* TLMDCustomComboBox.Destroy */ inline __fastcall virtual ~TLMDComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDComboBox(HWND ParentWindow) : Lmdcustomcombobox::TLMDCustomComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledComboBox : public TLMDComboBox
{
	typedef TLMDComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property ItemIndex;
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledComboBox(HWND ParentWindow) : TLMDComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCOMBOBOX)
using namespace Lmdcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcomboboxHPP
