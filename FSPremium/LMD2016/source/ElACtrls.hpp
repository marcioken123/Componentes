// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElACtrls.pas' rev: 31.00 (Windows)

#ifndef ElactrlsHPP
#define ElactrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <ElImgFrm.hpp>
#include <ElVCLUtils.hpp>
#include <intfLMDBase.hpp>
#include <LMDProcs.hpp>
#include <LMDClass.hpp>
#include <Vcl.Themes.hpp>
#include <LMDThemes.hpp>
#include <LMDVldBase.hpp>
#include <LMDTypes.hpp>
#include <LMDUtils.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGraph.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elactrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElAdvancedMemo;
class DELPHICLASS TCustomElAdvancedEdit;
class DELPHICLASS TElAdvancedEdit;
class DELPHICLASS TElAdvancedListBox;
class DELPHICLASS TCustomElAdvancedComboBox;
class DELPHICLASS TElAdvancedComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElAdvancedMemo : public Vcl::Stdctrls::TMemo
{
	typedef Vcl::Stdctrls::TMemo inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Vcl::Graphics::TBitmap* FBackground;
	bool FFlat;
	bool FFlatFocusedScrollBars;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FMouseOver;
	bool FPainting;
	bool FPaintingTo;
	bool FTransparent;
	bool FUseBackground;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Lmdgraph::TLMDBorderSides FBorderSides;
	bool FHandleDialogKeys;
	Lmdtypes::TLMDString FHint;
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall CNCtlColorEdit(Winapi::Messages::TWMCtlColor &Msg);
	MESSAGE void __fastcall CNCtlColorStatic(Winapi::Messages::TWMCtlColor &Msg);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	void __fastcall DrawBackground(HDC DC, const System::Types::TRect &R);
	void __fastcall DrawFlatBorder(HDC DC);
	void __fastcall DrawParentControl(HDC DC);
	void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetFlatFocusedScrollBars(const bool Value);
	void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetUseBackground(const bool Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	bool __fastcall GetUseXPThemes(void);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	bool FParentThemeMode;
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FPreventStyleChange;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	Lmdvldbase::TLMDValidationEntity* FValidator;
	System::UnicodeString FValidationMsgString;
	bool FErrorIndication;
	Lmdvldbase::TLMDValidationErrorEvent FOnValidationError;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall SetValidationMsgString(Lmdtypes::TLMDString val);
	Lmdtypes::TLMDString __fastcall GetValidationMsgString(void);
	HIDESBASE Vcl::Controls::TControl* __fastcall GetControl(void);
	Vcl::Graphics::TBrush* __fastcall GetControlBackBrush(void);
	Vcl::Graphics::TFont* __fastcall GetControlFont(void);
	Lmdtypes::TLMDString __fastcall GetValueToValidate(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall DoMouseEnter(void);
	DYNAMIC void __fastcall DoMouseLeave(void);
	DYNAMIC void __fastcall DoPaint(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	void __fastcall UpdateStyle(void);
	
public:
	__fastcall virtual TElAdvancedMemo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElAdvancedMemo(void);
	bool __fastcall IsThemed(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	bool __fastcall SupportsDefaultIndication(void);
	__property Vcl::Graphics::TFont* ControlFont = {read=GetControlFont};
	__property Vcl::Graphics::TBrush* ControlBackBrush = {read=GetControlBackBrush};
	void __fastcall RespondToError(int ErrorLevel);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* Validator);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	
__published:
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Align = {default=0};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property DoubleBuffered;
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool FlatFocusedScrollBars = {read=FFlatFocusedScrollBars, write=SetFlatFocusedScrollBars, default=0};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool UseBackground = {read=FUseBackground, write=SetUseBackground, default=0};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property bool HandleDialogKeys = {read=FHandleDialogKeys, write=FHandleDialogKeys, default=0};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=0};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=0};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property Lmdtypes::TLMDString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=FOnValidationError, write=FOnValidationError};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElAdvancedMemo(HWND ParentWindow) : Vcl::Stdctrls::TMemo(ParentWindow) { }
	
private:
	void *__ILMDValidatedControl;	// Lmdvldbase::ILMDValidatedControl 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {ED0CAB4C-DBF2-4078-8C06-000841566690}
	operator Lmdvldbase::_di_ILMDValidatedControl()
	{
		Lmdvldbase::_di_ILMDValidatedControl intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdvldbase::ILMDValidatedControl*(void) { return (Lmdvldbase::ILMDValidatedControl*)&__ILMDValidatedControl; }
	#endif
	
};


class PASCALIMPLEMENTATION TCustomElAdvancedEdit : public Vcl::Stdctrls::TCustomEdit
{
	typedef Vcl::Stdctrls::TCustomEdit inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	System::Classes::TAlignment FAlignment;
	Vcl::Graphics::TBitmap* FBackground;
	bool FFlat;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FMouseOver;
	bool FPainting;
	bool FPaintingTo;
	bool FReturnPressed;
	bool FTransparent;
	bool FUseBackground;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	bool FHandleDialogKeys;
	Lmdgraph::TLMDBorderSides FBorderSides;
	Lmdtypes::TLMDString FHint;
	bool FParentThemeMode;
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool __fastcall GetUseXPThemes(void);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall CNCtlColorEdit(Winapi::Messages::TWMCtlColor &Msg);
	MESSAGE void __fastcall CNCtlColorStatic(Winapi::Messages::TWMCtlColor &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	void __fastcall DrawBackground(HDC DC, const System::Types::TRect &R);
	void __fastcall DrawFlatBorder(HDC DC);
	void __fastcall DrawParentControl(HDC DC);
	void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	HIDESBASE void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetUseBackground(const bool Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	bool FNoHandleEnter;
	System::WideChar FPasswordChar;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetFlat(const bool Value);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoMouseEnter(void);
	DYNAMIC void __fastcall DoMouseLeave(void);
	DYNAMIC void __fastcall DoPaint(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool UseBackground = {read=FUseBackground, write=SetUseBackground, default=0};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=0};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=0};
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	HIDESBASE void __fastcall SetPasswordChar(System::WideChar Value);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Winapi::Messages::TWMNoParams &Message);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	
public:
	__fastcall virtual TCustomElAdvancedEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElAdvancedEdit(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property bool MouseOver = {read=FMouseOver, nodefault};
	bool __fastcall IsThemed(void);
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	
__published:
	__property DoubleBuffered;
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property bool HandleDialogKeys = {read=FHandleDialogKeys, write=FHandleDialogKeys, default=0};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property System::WideChar PasswordChar = {read=FPasswordChar, write=SetPasswordChar, stored=false, default=0};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElAdvancedEdit(HWND ParentWindow) : Vcl::Stdctrls::TCustomEdit(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TElAdvancedEdit : public TCustomElAdvancedEdit
{
	typedef TCustomElAdvancedEdit inherited;
	
__published:
	__property ActiveBorderType = {default=1};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property Anchors = {default=3};
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property Background;
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property CharCase = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Cursor = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Flat = {default=0};
	__property Font;
	__property HideSelection = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=0};
	__property LineBorderInactiveColor = {default=0};
	__property MaxLength = {default=0};
	__property OEMConvert = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PasswordChar = {default=0};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Text = {default=0};
	__property Transparent = {default=0};
	__property UseBackground = {default=0};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseMove;
	__property OnMouseLeave;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TCustomElAdvancedEdit.Create */ inline __fastcall virtual TElAdvancedEdit(System::Classes::TComponent* AOwner) : TCustomElAdvancedEdit(AOwner) { }
	/* TCustomElAdvancedEdit.Destroy */ inline __fastcall virtual ~TElAdvancedEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElAdvancedEdit(HWND ParentWindow) : TCustomElAdvancedEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElAdvancedListBox : public Vcl::Stdctrls::TListBox
{
	typedef Vcl::Stdctrls::TListBox inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Vcl::Graphics::TBitmap* FBackground;
	bool FFlat;
	bool FFlatFocusedScrollBars;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FInvertSelection;
	int FLastTopIndex;
	bool FMouseOver;
	System::Uitypes::TColor FSelectedColor;
	Vcl::Graphics::TFont* FSelectedFont;
	bool FTransparent;
	bool FUseBackground;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	bool FInVScroll;
	bool FInHScroll;
	bool FTransparentSelection;
	Lmdgraph::TLMDBorderSides FBorderSides;
	bool FShowLineHint;
	int FCurHintItem;
	Vcl::Stdctrls::TListBoxStyle FStyle;
	int FMaxWidth;
	bool FHorizontalScroll;
	Vcl::Extctrls::TTimer* FHintTimer;
	Vcl::Controls::THintWindow* FHintWnd;
	System::Classes::TWndMethod FHintWndProc;
	Lmdtypes::TLMDString FHint;
	bool FThemeGlobalMode;
	bool __fastcall GetUseXPThemes(void);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall LBGetTopIndex(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Message);
	MESSAGE void __fastcall WMNCMouseMove(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	void __fastcall DrawBackground(HDC DC, const System::Types::TRect &R);
	void __fastcall DrawBackgroundEx(HDC DC, const System::Types::TRect &R, const System::Types::TRect &SubR);
	void __fastcall DrawParentControlEx(HDC DC, const System::Types::TRect &R);
	void __fastcall DrawFlatBorder(HDC DC, bool HDragging, bool VDragging);
	void __fastcall DrawParentControl(HDC DC);
	void __fastcall IntMouseMove(short XPos, short YPos);
	void __fastcall SelectedFontChanged(System::TObject* Sender);
	void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetFlatFocusedScrollBars(const bool Value);
	void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetInvertSelection(const bool Value);
	void __fastcall SetSelectedColor(const System::Uitypes::TColor Value);
	void __fastcall SetSelectedFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetUseBackground(const bool Value);
	void __fastcall SetTransparentSelection(bool Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	HIDESBASE void __fastcall SetStyle(Vcl::Stdctrls::TListBoxStyle Value);
	void __fastcall SetHorizontalScroll(bool Value);
	void __fastcall ResetHorizontalExtent(void);
	void __fastcall SetHorizontalExtent(void);
	void __fastcall CancelLineHint(void);
	void __fastcall OnLineHintTimer(System::TObject* Sender);
	void __fastcall HintWndProc(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	bool FParentThemeMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	void __fastcall UpdateStyle(void);
	virtual int __fastcall GetItemWidth(int Index);
	virtual int __fastcall GetParentCtlWidth(void);
	virtual int __fastcall GetParentCtlHeight(void);
	virtual System::Types::TPoint __fastcall RealScreenToClient(const System::Types::TPoint &APoint);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &R, Winapi::Windows::TOwnerDrawState State);
	virtual Vcl::Graphics::TBitmap* __fastcall GetBackground(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual Vcl::Controls::THintWindow* __fastcall CreateHintWindow(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TElAdvancedListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElAdvancedListBox(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	bool __fastcall IsThemed(void);
	
__published:
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Vcl::Graphics::TBitmap* Background = {read=GetBackground, write=SetBackground};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool FlatFocusedScrollBars = {read=FFlatFocusedScrollBars, write=SetFlatFocusedScrollBars, default=0};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property bool InvertSelection = {read=FInvertSelection, write=SetInvertSelection, default=0};
	__property System::Uitypes::TColor SelectedColor = {read=FSelectedColor, write=SetSelectedColor, default=-16777203};
	__property Vcl::Graphics::TFont* SelectedFont = {read=FSelectedFont, write=SetSelectedFont};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool UseBackground = {read=FUseBackground, write=SetUseBackground, default=0};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property bool TransparentSelection = {read=FTransparentSelection, write=SetTransparentSelection, default=0};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property bool ShowLineHint = {read=FShowLineHint, write=FShowLineHint, default=0};
	__property Vcl::Stdctrls::TListBoxStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property bool HorizontalScroll = {read=FHorizontalScroll, write=SetHorizontalScroll, nodefault};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=0};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=0};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElAdvancedListBox(HWND ParentWindow) : Vcl::Stdctrls::TListBox(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TCustomElAdvancedComboBox : public Vcl::Stdctrls::TCustomComboBox
{
	typedef Vcl::Stdctrls::TCustomComboBox inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FFlat;
	Vcl::Graphics::TCanvas* BtnCanvas;
	int FDropDownWidth;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	bool FAutoCompletion;
	void *FListInstance;
	void *FEditInstance;
	int FSaveEditWndProc;
	int FSaveListWndProc;
	System::Classes::TWndMethod FListWindowProc;
	System::Classes::TWndMethod FEditWindowProc;
	bool FHorizontalScroll;
	Lmdtypes::TLMDString FHint;
	bool FThemeGlobalMode;
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetFlat(bool newValue);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	bool __fastcall IsFocused(void);
	void __fastcall SetActiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetInactiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetHorizontalScroll(bool Value);
	void __fastcall SetHorizontalExtent(void);
	void __fastcall ResetHorizontalExtent(void);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	bool __fastcall GetUseXPThemes(void);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	HWND FListHandle;
	HWND FEditHandle;
	bool FMouseOver;
	int FHorzPos;
	int FMaxWidth;
	bool FButtonFlat;
	bool FButtonTransparent;
	bool FButtonThinFrame;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	bool FHandleDialogKeys;
	bool FParentThemeMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DrawFlatBorder(HDC CanvasDC, bool DrawButton);
	void __fastcall UpdateFrame(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	HIDESBASE virtual void __fastcall ListWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall EditWndProc(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetButtonFlat(bool Value);
	void __fastcall SetButtonTransparent(bool Value);
	virtual int __fastcall GetItemWidth(int Index);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	virtual void __fastcall CreateWnd(void);
	void __fastcall SetButtonThinFrame(bool Value);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall DoAutoComplete(void);
	virtual System::UnicodeString __fastcall GetTextFromItem(int Index);
	void __fastcall ReadBtnFlat(System::Classes::TReader* Reader);
	void __fastcall ReadBtnTransparent(System::Classes::TReader* Reader);
	void __fastcall ReadBtnThinFrame(System::Classes::TReader* Reader);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	void __fastcall UpdateStyle(void);
	
public:
	__fastcall virtual TCustomElAdvancedComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElAdvancedComboBox(void);
	bool __fastcall IsThemed(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property HWND ListHandle = {read=FListHandle, nodefault};
	__property HWND EditHandle = {read=FEditHandle, nodefault};
	__property System::Classes::TWndMethod ListWindowProc = {read=FListWindowProc, write=FListWindowProc};
	__property System::Classes::TWndMethod EditWindowProc = {read=FEditWindowProc, write=FEditWindowProc};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property bool ButtonFlat = {read=FButtonFlat, write=SetButtonFlat, default=0};
	__property bool ButtonTransparent = {read=FButtonTransparent, write=SetButtonTransparent, default=0};
	__property bool HorizontalScroll = {read=FHorizontalScroll, write=SetHorizontalScroll, nodefault};
	__property bool ButtonThinFrame = {read=FButtonThinFrame, write=SetButtonThinFrame, default=1};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=0};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=0};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property int DropDownWidth = {read=FDropDownWidth, write=FDropDownWidth, default=0};
	__property bool AutoCompletion = {read=FAutoCompletion, write=FAutoCompletion, nodefault};
	__property bool HandleDialogKeys = {read=FHandleDialogKeys, write=FHandleDialogKeys, nodefault};
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property DoubleBuffered;
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElAdvancedComboBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomComboBox(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TElAdvancedComboBox : public TCustomElAdvancedComboBox
{
	typedef TCustomElAdvancedComboBox inherited;
	
__published:
	__property ActiveBorderType = {default=1};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoCompletion;
	__property BiDiMode;
	__property ButtonFlat = {default=0};
	__property ButtonThinFrame = {default=1};
	__property ButtonTransparent = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Flat;
	__property HandleDialogKeys;
	__property Hint;
	__property HorizontalScroll;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property InactiveBorderType = {default=3};
	__property ItemIndex;
	__property ItemHeight;
	__property LineBorderActiveColor = {default=0};
	__property LineBorderInactiveColor = {default=0};
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Sorted = {default=0};
	__property Style = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnStartDock;
	__property OnStartDrag;
	__property AutoCloseUp = {default=0};
	__property AutoDropDown = {default=0};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property CharCase = {default=0};
	__property OnCloseUp;
	__property OnSelect;
	__property Items;
public:
	/* TCustomElAdvancedComboBox.Create */ inline __fastcall virtual TElAdvancedComboBox(System::Classes::TComponent* AOwner) : TCustomElAdvancedComboBox(AOwner) { }
	/* TCustomElAdvancedComboBox.Destroy */ inline __fastcall virtual ~TElAdvancedComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElAdvancedComboBox(HWND ParentWindow) : TCustomElAdvancedComboBox(ParentWindow) { }
	
};


typedef TCustomElAdvancedEdit TCustomElFlatEdit;

typedef TElAdvancedEdit TElFlatEdit;

typedef TElAdvancedMemo TElFlatMemo;

typedef TElAdvancedListBox TElFlatListBox;

typedef TElAdvancedComboBox TElFlatComboBox;

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elactrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELACTRLS)
using namespace Elactrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElactrlsHPP
