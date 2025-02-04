// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sCustomComboEdit.pas' rev: 27.00 (Windows)

#ifndef ScustomcomboeditHPP
#define ScustomcomboeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <sGraphUtils.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <sMaskEdit.hpp>	// Pascal unit
#include <sSkinProps.hpp>	// Pascal unit
#include <sGlyphUtils.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.MaskUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scustomcomboedit
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TCloseUpEvent)(System::TObject* Sender, bool Accept);

class DELPHICLASS TsEditButton;
class DELPHICLASS TsCustomComboEdit;
class PASCALIMPLEMENTATION TsEditButton : public Sspeedbutton::TsSpeedButton
{
	typedef Sspeedbutton::TsSpeedButton inherited;
	
private:
	TsCustomComboEdit* FOwner;
	
public:
	void __fastcall BeginInitGlyph(void);
	void __fastcall EndInitGlyph(void);
	__fastcall virtual TsEditButton(System::Classes::TComponent* AOwner);
	void __fastcall PaintTo(HDC DC, const System::Types::TPoint &R);
	virtual bool __fastcall PrepareCache(void);
	virtual void __fastcall Paint(void);
	virtual int __fastcall GlyphWidth(void);
	virtual int __fastcall GlyphHeight(void);
public:
	/* TsSpeedButton.Destroy */ inline __fastcall virtual ~TsEditButton(void) { }
	
};


class PASCALIMPLEMENTATION TsCustomComboEdit : public Smaskedit::TsMaskEdit
{
	typedef Smaskedit::TsMaskEdit inherited;
	
private:
	TsEditButton* FButton;
	System::Classes::TShortCut FClickKey;
	bool FReadOnly;
	bool FDirectInput;
	Sconst::TPopupWindowAlign FPopupWindowAlign;
	Sglyphutils::TsGlyphMode* FGlyphMode;
	int FPopupWidth;
	Sconst::TsDisabledKind FDisabledKind;
	bool FShowButton;
	int FPopupHeight;
	void __fastcall EditButtonMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall EditButtonMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	bool __fastcall GetDroppedDown(void);
	void __fastcall SetDirectInput(bool Value);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMCut(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMFocuseChanged(Vcl::Controls::TCMFocusChanged &Message);
	HIDESBASE void __fastcall SetDisabledKind(const Sconst::TsDisabledKind Value);
	void __fastcall SetShowButton(const bool Value);
	
protected:
	System::Classes::TNotifyEvent FOnButtonClick;
	virtual void __fastcall SetEditRect(void);
	void __fastcall EditButtonClick(System::TObject* Sender);
	virtual void __fastcall PaintBorder(HDC DC);
	virtual void __fastcall PaintText(void);
	virtual void __fastcall OurPaintHandler(HDC DC);
	HIDESBASE virtual void __fastcall SetReadOnly(bool Value);
	HIDESBASE virtual bool __fastcall GetReadOnly(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall PopupWindowShow(void);
	virtual void __fastcall PopupWindowClose(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall ButtonClick(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property Sconst::TPopupWindowAlign PopupAlign = {read=FPopupWindowAlign, write=FPopupWindowAlign, default=0};
	
public:
	int FDefBmpID;
	Vcl::Controls::TWinControl* FPopupWindow;
	__fastcall virtual TsCustomComboEdit(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateWnd(void);
	__fastcall virtual ~TsCustomComboEdit(void);
	virtual void __fastcall Invalidate(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall DoClick(void);
	HIDESBASE virtual void __fastcall SelectAll(void);
	__property TsEditButton* Button = {read=FButton};
	__property bool DroppedDown = {read=GetDroppedDown, nodefault};
	__property int PopupWidth = {read=FPopupWidth, write=FPopupWidth, default=197};
	__property int PopupHeight = {read=FPopupHeight, write=FPopupHeight, default=166};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoSelect = {default=1};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property EditMask = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text;
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
	__property OnStartDrag;
	__property OnContextPopup;
	__property System::Classes::TNotifyEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property bool ShowButton = {read=FShowButton, write=SetShowButton, default=1};
	__property System::Classes::TShortCut ClickKey = {read=FClickKey, write=FClickKey, default=32808};
	__property Sconst::TsDisabledKind DisabledKind = {read=FDisabledKind, write=SetDisabledKind, default=1};
	__property Sglyphutils::TsGlyphMode* GlyphMode = {read=FGlyphMode, write=FGlyphMode};
	__property bool DirectInput = {read=FDirectInput, write=SetDirectInput, default=1};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCustomComboEdit(HWND ParentWindow) : Smaskedit::TsMaskEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Scustomcomboedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCUSTOMCOMBOEDIT)
using namespace Scustomcomboedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScustomcomboeditHPP
