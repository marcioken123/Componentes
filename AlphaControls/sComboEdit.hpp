// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sComboEdit.pas' rev: 27.00 (Windows)

#ifndef ScomboeditHPP
#define ScomboeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <sCustomComboEdit.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.MaskUtils.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scomboedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsComboEdit;
class PASCALIMPLEMENTATION TsComboEdit : public Scustomcomboedit::TsCustomComboEdit
{
	typedef Scustomcomboedit::TsCustomComboEdit inherited;
	
public:
	__fastcall virtual TsComboEdit(System::Classes::TComponent* AOwner);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AfterConstruction(void);
	
__published:
	__property Alignment = {default=0};
	__property CharCase = {default=0};
	__property ClickKey = {default=32808};
	__property DirectInput = {default=1};
	__property EditMask = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property MaxLength = {default=0};
	__property OEMConvert = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text;
	__property Visible = {default=1};
	__property OnButtonClick;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnContextPopup;
	__property OnEndDock;
	__property OnStartDock;
	__property AutoSelect = {default=1};
	__property HelpContext = {default=0};
	__property PasswordChar = {default=0};
	__property Hint = {default=0};
	__property DragCursor = {default=-12};
	__property OnEnter;
	__property OnExit;
public:
	/* TsCustomComboEdit.Destroy */ inline __fastcall virtual ~TsComboEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsComboEdit(HWND ParentWindow) : Scustomcomboedit::TsCustomComboEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Scomboedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCOMBOEDIT)
using namespace Scomboedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScomboeditHPP
