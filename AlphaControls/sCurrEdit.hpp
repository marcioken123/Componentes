// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sCurrEdit.pas' rev: 27.00 (Windows)

#ifndef ScurreditHPP
#define ScurreditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <sCalcUnit.hpp>	// Pascal unit
#include <sCustomComboEdit.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scurredit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsCustomNumEdit;
class PASCALIMPLEMENTATION TsCustomNumEdit : public Scustomcomboedit::TsCustomComboEdit
{
	typedef Scustomcomboedit::TsCustomComboEdit inherited;
	
private:
	Vcl::Controls::TControlCanvas* FCanvas;
	System::Classes::TAlignment FAlignment;
	bool FFocused;
	System::Extended FValue;
	System::Extended FMinValue;
	System::Extended FMaxValue;
	unsigned FDecimalPlaces;
	bool FBeepOnError;
	bool FCheckOnExit;
	bool FFormatOnEditing;
	bool FFormatting;
	System::UnicodeString FDisplayFormat;
	void __fastcall SetFocused(bool Value);
	HIDESBASE void __fastcall SetAlignment(System::Classes::TAlignment Value);
	void __fastcall SetBeepOnError(bool Value);
	void __fastcall SetDisplayFormat(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetDisplayFormat(void);
	void __fastcall SetDecimalPlaces(unsigned Value);
	System::Extended __fastcall GetValue(void);
	void __fastcall SetValue(System::Extended AValue);
	int __fastcall GetAsInteger(void);
	void __fastcall SetMaxValue(System::Extended AValue);
	void __fastcall SetMinValue(System::Extended AValue);
	HIDESBASE System::UnicodeString __fastcall GetText(void);
	HIDESBASE void __fastcall SetText(const System::UnicodeString AValue);
	System::UnicodeString __fastcall TextToValText(const System::UnicodeString AValue);
	System::Extended __fastcall CheckValue(System::Extended NewValue);
	bool __fastcall IsFormatStored(void);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Message);
	void __fastcall CalcWindowClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
protected:
	DYNAMIC void __fastcall Change(void);
	void __fastcall ReformatEditText(void);
	void __fastcall DataChanged(void);
	System::UnicodeString __fastcall DefFormat(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	bool __fastcall IsValidChar(System::WideChar Key);
	System::UnicodeString __fastcall FormatDisplayText(System::Extended Value);
	virtual System::UnicodeString __fastcall GetDisplayText(void);
	virtual void __fastcall Reset(void);
	void __fastcall CheckRange(void);
	void __fastcall UpdateData(void);
	__property bool Formatting = {read=FFormatting, nodefault};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=1};
	__property bool BeepOnError = {read=FBeepOnError, write=SetBeepOnError, default=1};
	__property bool CheckOnExit = {read=FCheckOnExit, write=FCheckOnExit, default=0};
	__property unsigned DecimalPlaces = {read=FDecimalPlaces, write=SetDecimalPlaces, default=2};
	__property System::UnicodeString DisplayFormat = {read=GetDisplayFormat, write=SetDisplayFormat, stored=IsFormatStored};
	__property System::Extended MaxValue = {read=FMaxValue, write=SetMaxValue};
	__property System::Extended MinValue = {read=FMinValue, write=SetMinValue};
	__property System::UnicodeString Text = {read=GetText, write=SetText, stored=false};
	__property MaxLength = {default=0};
	virtual void __fastcall PopupWindowShow(void);
	__property ClickKey = {default=32808};
	virtual void __fastcall PaintText(void);
	
public:
	__fastcall virtual TsCustomNumEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsCustomNumEdit(void);
	virtual void __fastcall Clear(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	__property int AsInteger = {read=GetAsInteger, nodefault};
	__property System::UnicodeString DisplayText = {read=GetDisplayText};
	__property DroppedDown;
	__property System::Extended Value = {read=GetValue, write=SetValue};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCustomNumEdit(HWND ParentWindow) : Scustomcomboedit::TsCustomComboEdit(ParentWindow) { }
	
};


class DELPHICLASS TsCalcEdit;
class PASCALIMPLEMENTATION TsCalcEdit : public TsCustomNumEdit
{
	typedef TsCustomNumEdit inherited;
	
public:
	__property AsInteger;
	__fastcall virtual TsCalcEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property ClickKey = {default=32808};
	__property AutoSelect = {default=1};
	__property BeepOnError = {default=1};
	__property DirectInput = {default=1};
	__property DragCursor = {default=-12};
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property MaxLength = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupAlign = {default=0};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnButtonClick;
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
	__property OnStartDrag;
	__property Alignment = {default=1};
	__property CheckOnExit = {default=0};
	__property DecimalPlaces = {default=2};
	__property DisplayFormat = {default=0};
	__property MaxValue = {default=0};
	__property MinValue = {default=0};
	__property Text;
	__property Value = {default=0};
public:
	/* TsCustomNumEdit.Destroy */ inline __fastcall virtual ~TsCalcEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCalcEdit(HWND ParentWindow) : TsCustomNumEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Scurredit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCURREDIT)
using namespace Scurredit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScurreditHPP
