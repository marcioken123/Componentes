// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sCurrencyEdit.pas' rev: 27.00 (Windows)

#ifndef ScurrencyeditHPP
#define ScurrencyeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <sCurrEdit.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sCustomComboEdit.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scurrencyedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsCurrencyEdit;
class PASCALIMPLEMENTATION TsCurrencyEdit : public Scurredit::TsCustomNumEdit
{
	typedef Scurredit::TsCustomNumEdit inherited;
	
protected:
	DYNAMIC void __fastcall ButtonClick(void);
	
public:
	__fastcall virtual TsCurrencyEdit(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	
__published:
	__property Alignment = {default=1};
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property BeepOnError = {default=1};
	__property CheckOnExit = {default=0};
	__property DecimalPlaces = {default=2};
	__property DisplayFormat = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property HideSelection = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property MaxValue = {default=0};
	__property MinValue = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowButton = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text;
	__property Value = {default=0};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnContextPopup;
	__property HelpContext = {default=0};
	__property OEMConvert = {default=0};
	__property ReadOnly = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Hint = {default=0};
	__property MaxLength = {default=0};
	__property ParentFont = {default=1};
	__property CharCase = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TsCustomNumEdit.Destroy */ inline __fastcall virtual ~TsCurrencyEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCurrencyEdit(HWND ParentWindow) : Scurredit::TsCustomNumEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Scurrencyedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCURRENCYEDIT)
using namespace Scurrencyedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScurrencyeditHPP
