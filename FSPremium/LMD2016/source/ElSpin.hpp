// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElSpin.pas' rev: 31.00 (Windows)

#ifndef ElspinHPP
#define ElspinHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <System.Types.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDSysIn.hpp>
#include <LMDProcs.hpp>
#include <LMDTypes.hpp>
#include <ElVCLUtils.hpp>
#include <ElEdits.hpp>
#include <ElSpinBtn.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>
#include <ElSBCtrl.hpp>
#include <LMDGraph.hpp>
#include <ElImgFrm.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elspin
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElSpinEditError;
class DELPHICLASS TElSpinEdit;
class DELPHICLASS TElFloatSpinEdit;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDCheckIntRangeEvent)(System::TObject* Sender, int AValue, bool &ASilent);

typedef void __fastcall (__closure *TLMDCheckFloatRangeEvent)(System::TObject* Sender, double AValue, bool &ASilent);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElSpinEditError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall TElSpinEditError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall TElSpinEditError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall TElSpinEditError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall TElSpinEditError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall TElSpinEditError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall TElSpinEditError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall TElSpinEditError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall TElSpinEditError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TElSpinEditError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TElSpinEditError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TElSpinEditError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TElSpinEditError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~TElSpinEditError(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElSpinEdit : public Eledits::TCustomElEdit
{
	typedef Eledits::TCustomElEdit inherited;
	
protected:
	bool FModified;
	int FBtnWidth;
	bool FMouseOver;
	int FLargeIncrement;
	int FIncrement;
	int FSaveValue;
	int FSavePos;
	int FSaveLen;
	bool FChanging;
	int FValue;
	int FMaxValue;
	int FMinValue;
	bool FAllowEdit;
	Elspinbtn::TElSpinButton* FButton;
	System::Classes::TNotifyEvent FOnUpClick;
	System::Classes::TNotifyEvent FOnDownClick;
	int FButtonWidth;
	bool FUseButtonWidth;
	bool FValueUndefined;
	bool FCReadOnly;
	bool FButtonFlat;
	bool FAutoDisableSpinButtons;
	TLMDCheckIntRangeEvent FOnCheckRangeError;
	void __fastcall SetButtonColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetButtonColor(void);
	virtual void __fastcall SetValue(int newValue);
	void __fastcall SetMaxValue(int newValue);
	void __fastcall SetMinValue(int newValue);
	void __fastcall SetAllowEdit(bool newValue);
	void __fastcall SetIncrement(int newValue);
	virtual void __fastcall SetEditRect(const System::Types::TRect &Value);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMCreate(Winapi::Messages::TWMCreate &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMCut(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Msg);
	virtual void __fastcall SpinUpClick(System::TObject* Sender, double Increment);
	virtual void __fastcall SpinDownClick(System::TObject* Sender, double Increment);
	virtual void __fastcall SpinDrag(System::TObject* Sender, double NewValue);
	void __fastcall SpinStart(System::TObject* Sender, double &StartValue);
	void __fastcall SetCReadOnly(bool Value);
	virtual void __fastcall SetFlat(const bool Value);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC Vcl::Menus::TPopupMenu* __fastcall GetPopupMenu(void);
	HIDESBASE virtual void __fastcall SetModified(bool newValue);
	void __fastcall SetButtonWidth(const int Value);
	void __fastcall SetUseButtonWidth(bool Value);
	Elspinbtn::TElSpinBtnType __fastcall GetButtonType(void);
	void __fastcall SetButtonType(Elspinbtn::TElSpinBtnType Value);
	Elspinbtn::TElSpinBtnDir __fastcall GetButtonDirection(void);
	void __fastcall SetButtonDirection(Elspinbtn::TElSpinBtnDir Value);
	virtual void __fastcall SetValueUndefined(bool Value);
	HIDESBASE bool __fastcall GetUseXPThemes(void);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetButtonThinFrame(bool Value);
	virtual void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetButtonFlat(bool Value);
	bool __fastcall GetButtonThinFrame(void);
	bool __fastcall GetButtonOldStyled(void);
	bool __fastcall GetButtonShowBorder(void);
	void __fastcall SetButtonOldStyled(bool Value);
	void __fastcall SetButtonShowBorder(bool Value);
	void __fastcall SetAutoDisableSpinButtons(bool Value);
	
public:
	__fastcall virtual TElSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElSpinEdit(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall Loaded(void);
	__property bool MouseOver = {read=FMouseOver, nodefault};
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	
__published:
	__property int Value = {read=FValue, write=SetValue, default=0};
	__property int MaxValue = {read=FMaxValue, write=SetMaxValue, default=100};
	__property int MinValue = {read=FMinValue, write=SetMinValue, default=0};
	__property bool AllowEdit = {read=FAllowEdit, write=SetAllowEdit, default=1};
	__property int Increment = {read=FIncrement, write=SetIncrement, default=1};
	__property int LargeIncrement = {read=FLargeIncrement, write=FLargeIncrement, default=10};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, stored=FUseButtonWidth, nodefault};
	__property bool UseButtonWidth = {read=FUseButtonWidth, write=SetUseButtonWidth, default=0};
	__property Elspinbtn::TElSpinBtnType ButtonType = {read=GetButtonType, write=SetButtonType, default=0};
	__property System::Uitypes::TColor ButtonColor = {read=GetButtonColor, write=SetButtonColor, default=-16777201};
	__property Elspinbtn::TElSpinBtnDir ButtonDirection = {read=GetButtonDirection, write=SetButtonDirection, default=0};
	__property bool ValueUndefined = {read=FValueUndefined, write=SetValueUndefined, default=0};
	__property bool ReadOnly = {read=FCReadOnly, write=SetCReadOnly, default=0};
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, default=1};
	__property bool ButtonThinFrame = {read=GetButtonThinFrame, write=SetButtonThinFrame, default=1};
	__property bool ButtonFlat = {read=FButtonFlat, write=SetButtonFlat, default=0};
	__property bool ButtonOldStyled = {read=GetButtonOldStyled, write=SetButtonOldStyled, default=0};
	__property bool ButtonShowBorder = {read=GetButtonShowBorder, write=SetButtonShowBorder, default=1};
	__property System::Classes::TNotifyEvent OnUpClick = {read=FOnUpClick, write=FOnUpClick};
	__property System::Classes::TNotifyEvent OnDownClick = {read=FOnDownClick, write=FOnDownClick};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property Alignment = {default=0};
	__property AlignBottom = {default=1};
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property BorderSides = {default=15};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property ImageForm;
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ActiveBorderType = {default=1};
	__property Align = {default=0};
	__property AutoSelect = {default=0};
	__property AutoSize = {default=1};
	__property Background;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D = {default=1};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Flat = {default=0};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property ShowHint;
	__property UseBackground = {default=0};
	__property UseSystemMenu = {default=1};
	__property Visible = {default=1};
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
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
	__property bool AutoDisableSpinButtons = {read=FAutoDisableSpinButtons, write=SetAutoDisableSpinButtons, default=0};
	__property TLMDCheckIntRangeEvent OnCheckRangeError = {read=FOnCheckRangeError, write=FOnCheckRangeError};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElSpinEdit(HWND ParentWindow) : Eledits::TCustomElEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElFloatSpinEdit : public Eledits::TCustomElEdit
{
	typedef Eledits::TCustomElEdit inherited;
	
protected:
	bool FNoTextUpdate;
	bool FAllowEdit;
	int FBtnWidth;
	Elspinbtn::TElSpinButton* FButton;
	int FButtonWidth;
	bool FChanging;
	double FIncrement;
	double FLargeIncrement;
	double FMaxValue;
	double FMinValue;
	int FPrecision;
	bool FModified;
	bool FMouseOver;
	System::Classes::TNotifyEvent FOnUpClick;
	System::Classes::TNotifyEvent FOnDownClick;
	bool FCReadOnly;
	int FSaveLen;
	int FSavePos;
	double FSaveValue;
	bool FUseButtonWidth;
	double FValue;
	bool FValueUndefined;
	bool FAutoDisableSpinButtons;
	int FDigits;
	TLMDCheckFloatRangeEvent FOnCheckRangeError;
	void __fastcall SetButtonColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetButtonColor(void);
	void __fastcall SetAllowEdit(bool newValue);
	void __fastcall SetIncrement(double newValue);
	void __fastcall SetMaxValue(double newValue);
	void __fastcall SetMinValue(double newValue);
	void __fastcall SetCReadOnly(bool Value);
	virtual void __fastcall SetValue(double newValue);
	virtual void __fastcall SetDigits(int newValue);
	void __fastcall SetPrecision(int newValue);
	virtual void __fastcall SpinDownClick(System::TObject* Sender, double Increment);
	virtual void __fastcall SpinDrag(System::TObject* Sender, double NewValue);
	void __fastcall SpinStart(System::TObject* Sender, double &StartValue);
	virtual void __fastcall SpinUpClick(System::TObject* Sender, double Increment);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMCreate(Winapi::Messages::TWMCreate &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMCut(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Msg);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	Elspinbtn::TElSpinBtnDir __fastcall GetButtonDirection(void);
	Elspinbtn::TElSpinBtnType __fastcall GetButtonType(void);
	DYNAMIC Vcl::Menus::TPopupMenu* __fastcall GetPopupMenu(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	void __fastcall SetButtonDirection(Elspinbtn::TElSpinBtnDir Value);
	void __fastcall SetButtonType(Elspinbtn::TElSpinBtnType Value);
	void __fastcall SetButtonWidth(const int Value);
	virtual void __fastcall SetFlat(const bool Value);
	HIDESBASE virtual void __fastcall SetModified(bool newValue);
	void __fastcall SetUseButtonWidth(bool Value);
	virtual void __fastcall SetValueUndefined(bool Value);
	HIDESBASE bool __fastcall GetUseXPThemes(void);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	void __fastcall SetButtonThinFrame(bool Value);
	virtual void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetEditRect(const System::Types::TRect &Value);
	bool __fastcall GetButtonThinFrame(void);
	bool __fastcall GetButtonOldStyled(void);
	void __fastcall SetButtonOldStyled(bool Value);
	bool __fastcall GetButtonFlat(void);
	void __fastcall SetButtonFlat(bool Value);
	bool __fastcall GetButtonShowBorder(void);
	System::Sysutils::TFloatFormat __fastcall GetFloatFormat(void);
	void __fastcall SetButtonShowBorder(bool Value);
	void __fastcall SetAutoDisableSpinButtons(bool Value);
	
public:
	__fastcall virtual TElFloatSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFloatSpinEdit(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	__property bool MouseOver = {read=FMouseOver, nodefault};
	
__published:
	__property bool AllowEdit = {read=FAllowEdit, write=SetAllowEdit, default=1};
	__property Elspinbtn::TElSpinBtnDir ButtonDirection = {read=GetButtonDirection, write=SetButtonDirection, default=0};
	__property Elspinbtn::TElSpinBtnType ButtonType = {read=GetButtonType, write=SetButtonType, default=0};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, stored=FUseButtonWidth, nodefault};
	__property System::Uitypes::TColor ButtonColor = {read=GetButtonColor, write=SetButtonColor, default=-16777201};
	__property double Increment = {read=FIncrement, write=SetIncrement};
	__property double LargeIncrement = {read=FLargeIncrement, write=FLargeIncrement};
	__property double MaxValue = {read=FMaxValue, write=SetMaxValue};
	__property double MinValue = {read=FMinValue, write=SetMinValue};
	__property System::Classes::TNotifyEvent OnDownClick = {read=FOnDownClick, write=FOnDownClick};
	__property System::Classes::TNotifyEvent OnUpClick = {read=FOnUpClick, write=FOnUpClick};
	__property bool ReadOnly = {read=FCReadOnly, write=SetCReadOnly, default=0};
	__property bool UseButtonWidth = {read=FUseButtonWidth, write=SetUseButtonWidth, default=0};
	__property double Value = {read=FValue, write=SetValue};
	__property int Precision = {read=FPrecision, write=SetPrecision, default=8};
	__property bool ValueUndefined = {read=FValueUndefined, write=SetValueUndefined, default=0};
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, default=1};
	__property bool ButtonThinFrame = {read=GetButtonThinFrame, write=SetButtonThinFrame, default=1};
	__property bool ButtonOldStyled = {read=GetButtonOldStyled, write=SetButtonOldStyled, default=0};
	__property bool ButtonFlat = {read=GetButtonFlat, write=SetButtonFlat, default=0};
	__property bool ButtonShowBorder = {read=GetButtonShowBorder, write=SetButtonShowBorder, default=1};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property Alignment = {default=0};
	__property AlignBottom = {default=1};
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property BorderSides = {default=15};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property ImageForm;
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ActiveBorderType = {default=1};
	__property Align = {default=0};
	__property AutoSelect = {default=0};
	__property AutoSize = {default=1};
	__property Background;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Flat = {default=0};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property ShowHint;
	__property UseBackground = {default=0};
	__property UseSystemMenu = {default=1};
	__property Visible = {default=1};
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
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
	__property bool AutoDisableSpinButtons = {read=FAutoDisableSpinButtons, write=SetAutoDisableSpinButtons, default=0};
	__property int Digits = {read=FDigits, write=SetDigits, default=3};
	__property TLMDCheckFloatRangeEvent OnCheckRangeError = {read=FOnCheckRangeError, write=FOnCheckRangeError};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElFloatSpinEdit(HWND ParentWindow) : Eledits::TCustomElEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elspin */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSPIN)
using namespace Elspin;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElspinHPP
