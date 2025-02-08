// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShSpinEdit.pas' rev: 34.00 (Windows)

#ifndef LmdshspineditHPP
#define LmdshspineditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshspinedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShSpinEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShSpinEdit : public Vcl::Stdctrls::TCustomEdit
{
	typedef Vcl::Stdctrls::TCustomEdit inherited;
	
private:
	System::Classes::TAlignment FAlignment;
	int FMinValue;
	int FMaxValue;
	int FLineSize;
	int FPageSize;
	System::Byte FSize;
	bool FEditorEnabled;
	void *FButton;
	System::UnicodeString FSuffix;
	Vcl::Controls::TWinControl* FButtonWin;
	void __fastcall SetEditRect();
	void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetInterval(System::Word aValue);
	void __fastcall SetSize(System::Byte aValue);
	void __fastcall SetSuffix(System::UnicodeString aValue);
	void __fastcall SetValue(int aValue);
	HIDESBASE void __fastcall SetAlignment(System::Classes::TAlignment aValue);
	System::Word __fastcall GetInterval();
	int __fastcall GetMinHeight();
	int __fastcall GetValue();
	void __fastcall AdjustSizeLMD();
	int __fastcall CheckValue(int aValue);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMCut(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMPaste(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd();
	virtual void __fastcall DownClick(System::TObject* Sender);
	virtual bool __fastcall IsValidChar(System::WideChar Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC bool __fastcall DoMouseWheelDown(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	virtual void __fastcall UpClick(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDShSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDShSpinEdit();
	__property void * Button = {read=FButton};
	
__published:
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool EditorEnabled = {read=FEditorEnabled, write=FEditorEnabled, default=1};
	__property System::Word Interval = {read=GetInterval, write=SetInterval, default=100};
	__property int LineSize = {read=FLineSize, write=SetInteger, index=2, default=1};
	__property int MaxValue = {read=FMaxValue, write=SetInteger, index=0, default=100};
	__property int MinValue = {read=FMinValue, write=SetInteger, index=1, default=0};
	__property int PageSize = {read=FPageSize, write=SetInteger, index=3, default=10};
	__property System::UnicodeString Suffix = {read=FSuffix, write=SetSuffix};
	__property System::Byte TriangleSize = {read=FSize, write=SetSize, default=3};
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property int Value = {read=GetValue, write=SetValue, default=0};
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
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShSpinEdit(HWND ParentWindow) : Vcl::Stdctrls::TCustomEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshspinedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHSPINEDIT)
using namespace Lmdshspinedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshspineditHPP
