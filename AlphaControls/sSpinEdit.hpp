// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sSpinEdit.pas' rev: 27.00 (Windows)

#ifndef SspineditHPP
#define SspineditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sEdit.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sGraphUtils.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sspinedit
{
//-- type declarations -------------------------------------------------------
using Vcl::Buttons::TNumGlyphs;

class DELPHICLASS TsSpinButton;
class DELPHICLASS TsSpinEdit;
class DELPHICLASS TsTimerSpeedButton;
class PASCALIMPLEMENTATION TsSpinButton : public Vcl::Controls::TWinControl
{
	typedef Vcl::Controls::TWinControl inherited;
	
private:
	TsSpinEdit* FOwner;
	TsTimerSpeedButton* FUpButton;
	TsTimerSpeedButton* FDownButton;
	TsTimerSpeedButton* FFocusedButton;
	Vcl::Controls::TWinControl* FFocusControl;
	System::Classes::TNotifyEvent FOnUpClick;
	System::Classes::TNotifyEvent FOnDownClick;
	TsTimerSpeedButton* __fastcall CreateButton(void);
	Vcl::Graphics::TBitmap* __fastcall GetUpGlyph(void);
	Vcl::Graphics::TBitmap* __fastcall GetDownGlyph(void);
	void __fastcall SetUpGlyph(Vcl::Graphics::TBitmap* Value);
	void __fastcall SetDownGlyph(Vcl::Graphics::TBitmap* Value);
	void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall BtnMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetFocusBtn(TsTimerSpeedButton* Btn);
	HIDESBASE void __fastcall AdjustSize(int &W, int &H);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	HIDESBASE void __fastcall PaintTo(HDC DC, const System::Types::TPoint &P);
	__fastcall virtual TsSpinButton(System::Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property Ctl3D;
	__property Vcl::Graphics::TBitmap* DownGlyph = {read=GetDownGlyph, write=SetDownGlyph};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Vcl::Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Vcl::Graphics::TBitmap* UpGlyph = {read=GetUpGlyph, write=SetUpGlyph};
	__property Visible = {default=1};
	__property System::Classes::TNotifyEvent OnDownClick = {read=FOnDownClick, write=FOnDownClick};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDock;
	__property OnStartDrag;
	__property System::Classes::TNotifyEvent OnUpClick = {read=FOnUpClick, write=FOnUpClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsSpinButton(HWND ParentWindow) : Vcl::Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TsSpinButton(void) { }
	
};


class DELPHICLASS TsBaseSpinEdit;
class PASCALIMPLEMENTATION TsBaseSpinEdit : public Sedit::TsEdit
{
	typedef Sedit::TsEdit inherited;
	
private:
	TsSpinButton* FButton;
	bool FEditorEnabled;
	System::Classes::TNotifyEvent FOnUpClick;
	System::Classes::TNotifyEvent FOnDownClick;
	System::Classes::TAlignment FAlignment;
	bool FShowSpinButtons;
	bool FAllowNegative;
	Vcl::Controls::TWinControl* FPrevTabControl;
	Vcl::Controls::TWinControl* FNextTabControl;
	void __fastcall SetShowSpinButtons(const bool Value);
	int __fastcall GetMinHeight(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	MESSAGE void __fastcall WMPaste(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMCut(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	
protected:
	virtual void __fastcall ExcludeChildControls(HDC DC);
	void __fastcall SetEditRect(void);
	virtual bool __fastcall IsValidChar(System::WideChar &Key);
	virtual void __fastcall UpClick(System::TObject* Sender) = 0 ;
	virtual void __fastcall DownClick(System::TObject* Sender) = 0 ;
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall PaintText(void);
	virtual bool __fastcall PrepareCache(void);
	
public:
	__fastcall virtual TsBaseSpinEdit(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	__fastcall virtual ~TsBaseSpinEdit(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	__property TsSpinButton* Button = {read=FButton};
	__property CharCase = {default=0};
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool EditorEnabled = {read=FEditorEnabled, write=FEditorEnabled, default=1};
	__property System::Classes::TNotifyEvent OnDownClick = {read=FOnDownClick, write=FOnDownClick};
	__property System::Classes::TNotifyEvent OnUpClick = {read=FOnUpClick, write=FOnUpClick};
	__property bool AllowNegative = {read=FAllowNegative, write=FAllowNegative, default=1};
	__property bool ShowSpinButtons = {read=FShowSpinButtons, write=SetShowSpinButtons, default=1};
	__property Vcl::Controls::TWinControl* NextTabControl = {read=FNextTabControl, write=FNextTabControl};
	__property Vcl::Controls::TWinControl* PrevTabControl = {read=FPrevTabControl, write=FPrevTabControl};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsBaseSpinEdit(HWND ParentWindow) : Sedit::TsEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TsSpinEdit : public TsBaseSpinEdit
{
	typedef TsBaseSpinEdit inherited;
	
private:
	int FMinValue;
	int FMaxValue;
	int FIncrement;
	int __fastcall GetValue(void);
	int __fastcall CheckValue(int NewValue);
	void __fastcall SetValue(int NewValue);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseWheel(Vcl::Controls::TCMMouseWheel &Message);
	HIDESBASE MESSAGE void __fastcall CMChanged(Winapi::Messages::TMessage &Message);
	
protected:
	HIDESBASE MESSAGE void __fastcall WMPaste(Winapi::Messages::TWMNoParams &Message);
	virtual bool __fastcall IsValidChar(System::WideChar &Key);
	virtual void __fastcall UpClick(System::TObject* Sender);
	virtual void __fastcall DownClick(System::TObject* Sender);
	
public:
	__fastcall virtual TsSpinEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property int Increment = {read=FIncrement, write=FIncrement, default=1};
	__property int MaxValue = {read=FMaxValue, write=FMaxValue, nodefault};
	__property int MinValue = {read=FMinValue, write=FMinValue, nodefault};
	__property int Value = {read=GetValue, write=SetValue, nodefault};
public:
	/* TsBaseSpinEdit.Destroy */ inline __fastcall virtual ~TsSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsSpinEdit(HWND ParentWindow) : TsBaseSpinEdit(ParentWindow) { }
	
};


class DELPHICLASS TsDecimalSpinEdit;
class PASCALIMPLEMENTATION TsDecimalSpinEdit : public TsBaseSpinEdit
{
	typedef TsBaseSpinEdit inherited;
	
private:
	System::Extended FValue;
	System::Extended FMinValue;
	System::Extended FMaxValue;
	System::Extended FIncrement;
	int fDecimalPlaces;
	bool FUseSystemDecSeparator;
	System::Extended __fastcall CheckValue(System::Extended NewValue);
	void __fastcall SetValue(System::Extended NewValue);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	void __fastcall FormatText(void);
	HIDESBASE MESSAGE void __fastcall CMChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseWheel(Vcl::Controls::TCMMouseWheel &Message);
	System::Extended __fastcall GetValue(void);
	
protected:
	bool ValueChanging;
	bool TextChanging;
	HIDESBASE MESSAGE void __fastcall WMPaste(Winapi::Messages::TWMNoParams &Message);
	virtual bool __fastcall IsValidChar(System::WideChar &Key);
	virtual void __fastcall UpClick(System::TObject* Sender);
	virtual void __fastcall DownClick(System::TObject* Sender);
	void __fastcall SetDecimalPlaces(int New);
	
public:
	__fastcall virtual TsDecimalSpinEdit(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateWnd(void);
	
__published:
	__property System::Extended Increment = {read=FIncrement, write=FIncrement};
	__property System::Extended MaxValue = {read=FMaxValue, write=FMaxValue};
	__property System::Extended MinValue = {read=FMinValue, write=FMinValue};
	__property System::Extended Value = {read=GetValue, write=SetValue};
	__property int DecimalPlaces = {read=fDecimalPlaces, write=SetDecimalPlaces, default=2};
	__property bool UseSystemDecSeparator = {read=FUseSystemDecSeparator, write=FUseSystemDecSeparator, default=1};
public:
	/* TsBaseSpinEdit.Destroy */ inline __fastcall virtual ~TsDecimalSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsDecimalSpinEdit(HWND ParentWindow) : TsBaseSpinEdit(ParentWindow) { }
	
};


enum DECLSPEC_DENUM Sspinedit__5 : unsigned char { tbFocusRect, tbAllowTimer };

typedef System::Set<Sspinedit__5, Sspinedit__5::tbFocusRect, Sspinedit__5::tbAllowTimer> TTimeBtnState;

class PASCALIMPLEMENTATION TsTimerSpeedButton : public Sspeedbutton::TsSpeedButton
{
	typedef Sspeedbutton::TsSpeedButton inherited;
	
private:
	TsSpinButton* FOwner;
	Vcl::Extctrls::TTimer* FRepeatTimer;
	TTimeBtnState FTimeBtnState;
	void __fastcall TimerExpired(System::TObject* Sender);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall DrawGlyph(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	bool Up;
	__fastcall virtual TsTimerSpeedButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsTimerSpeedButton(void);
	void __fastcall PaintTo(HDC DC, const System::Types::TPoint &P);
	__property TTimeBtnState TimeBtnState = {read=FTimeBtnState, write=FTimeBtnState, nodefault};
};


enum DECLSPEC_DENUM TacTimePortion : unsigned char { tvHours, tvMinutes, tvSeconds };

class DELPHICLASS TsTimePicker;
class PASCALIMPLEMENTATION TsTimePicker : public TsBaseSpinEdit
{
	typedef TsBaseSpinEdit inherited;
	
private:
	System::Word fHour;
	System::Word fMin;
	System::Word fSec;
	bool FDoBeep;
	bool FShowSeconds;
	bool FUse12Hour;
	System::TDateTime __fastcall GetValue(void);
	void __fastcall SetValue(System::TDateTime NewValue);
	System::TDateTime __fastcall CheckValue(System::TDateTime NewValue);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	void __fastcall SetShowSeconds(const bool Value);
	void __fastcall SetUse12Hour(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMMouseWheel(Vcl::Controls::TCMMouseWheel &Message);
	
protected:
	int FPos;
	virtual bool __fastcall IsValidChar(System::WideChar &Key);
	void __fastcall ClickUpDown(bool Up);
	virtual void __fastcall UpClick(System::TObject* Sender);
	virtual void __fastcall DownClick(System::TObject* Sender);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetHour(int NewHour);
	void __fastcall SetMin(int NewMin);
	void __fastcall SetSec(int NewSec);
	void __fastcall DecodeValue(void);
	TacTimePortion __fastcall Portion(void);
	void __fastcall SetPos(int NewPos, bool Highlight = true);
	void __fastcall IncPos(void);
	void __fastcall ReplaceAtPos(int APos, System::WideChar AChar);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	void __fastcall HighlightPos(int APos);
	System::UnicodeString __fastcall EmptyText(void);
	int __fastcall TextLength(void);
	System::Word __fastcall Sec(void);
	
public:
	int MaxHour;
	__fastcall virtual TsTimePicker(System::Classes::TComponent* AOwner);
	virtual void __fastcall Loaded(void);
	
__published:
	__property System::TDateTime Date = {read=GetValue, write=SetValue};
	__property bool DoBeep = {read=FDoBeep, write=FDoBeep, default=0};
	__property System::TDateTime Value = {read=GetValue, write=SetValue};
	__property System::TDateTime Time = {read=GetValue, write=SetValue};
	__property bool ShowSeconds = {read=FShowSeconds, write=SetShowSeconds, default=1};
	__property bool Use12Hour = {read=FUse12Hour, write=SetUse12Hour, default=0};
public:
	/* TsBaseSpinEdit.Destroy */ inline __fastcall virtual ~TsTimePicker(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsTimePicker(HWND ParentWindow) : TsBaseSpinEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sspinedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SSPINEDIT)
using namespace Sspinedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SspineditHPP
