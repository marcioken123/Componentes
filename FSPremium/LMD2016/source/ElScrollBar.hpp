// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElScrollBar.pas' rev: 31.00 (Windows)

#ifndef ElscrollbarHPP
#define ElscrollbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDTypes.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDElConst.hpp>
#include <LMDThemes.hpp>
#include <LMDProcs.hpp>
#include <LMDSysIn.hpp>
#include <LMDUtils.hpp>
#include <LMDClass.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElXPThemedControl.hpp>
#include <ElVCLUtils.hpp>
#include <ElImgFrm.hpp>
#include <ElHintWnd.hpp>
#include <ElSBCtrl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elscrollbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomElScrollBar;
class DELPHICLASS TElScrollBarStyles;
class DELPHICLASS TElScrollBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomElScrollBar : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
protected:
	bool FThinFrame;
	bool FShowBorder;
	bool FDrawArrowFrames;
	bool FDrawBars;
	unsigned FBarOffset;
	System::Uitypes::TColor FBarColor;
	System::Uitypes::TColor FArrowColor;
	System::Uitypes::TColor FArrowHotTrackColor;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Elimgfrm::TElImageForm* FImgForm;
	bool FUseSystemMetrics;
	bool FNoSunkenThumb;
	bool FShowLeftArrows;
	bool FShowRightArrows;
	bool FChangeColorsOnScroll;
	bool FBitmapOwner;
	bool FBlendBackground;
	bool FShowTrackHint;
	bool FNoDisableButtons;
	bool FOwnerDraw;
	bool FSecondaryButtons;
	Elsbctrl::TElSecButtonsKind FSecondBtnKind;
	int FPage;
	int FMinThumbSize;
	Elsbctrl::TElScrollThumbMode FThumbMode;
	int FThumbSize;
	int FButtonSize;
	Vcl::Forms::TScrollBarKind FKind;
	int FPosition;
	int FMax;
	int FMin;
	bool FFlat;
	bool FActiveFlat;
	bool FMouseInControl;
	bool FIsHTML;
	System::Classes::TNotifyEvent FOnChange;
	Elsbctrl::TElSBScrollEvent FOnScroll;
	Elsbctrl::TElScrollDrawPartEvent FOnDrawPart;
	Elsbctrl::TElScrollHintNeededEvent FOnScrollHintNeeded;
	Vcl::Extctrls::TTimer* FScrollTimer;
	int FThumbOffset;
	int FOrigPos;
	int FOrigCoord;
	HWND FSaveCapture;
	int FTrackPos;
	int FThumbPos;
	Elsbctrl::TElScrollBarPart FPressedIn;
	Elsbctrl::TElScrollBarPart FOrigPressedIn;
	Elsbctrl::TElScrollBarPart FMouseOver;
	Elhintwnd::TElHintWindow* FHintWnd;
	System::Types::TPoint FPressedPos;
	bool FPressed;
	bool FTracking;
	bool FNoScrollMessages;
	bool FAltDisablingArrows;
	Elsbctrl::TElScrollHitTestEvent FOnHitTest;
	System::Uitypes::TColor FHintColor;
	System::Uitypes::TColor FHintTextColor;
	Lmdtypes::TLMDString FHint;
	bool FSysBkColor;
	int FStep;
	void __fastcall SetKind(Vcl::Forms::TScrollBarKind newValue);
	void __fastcall SetPosition(int newValue);
	void __fastcall SetMax(int newValue);
	void __fastcall SetMin(int newValue);
	void __fastcall SetPage(int newValue);
	void __fastcall IntMouseButton(bool Pressed, System::Uitypes::TMouseButton Btn, short XPos, short YPos);
	void __fastcall IntMouseMove(short XPos, short YPos);
	void __fastcall IntMouseEnter(void);
	void __fastcall IntMouseLeave(void);
	void __fastcall IntDoEnter(void);
	void __fastcall IntDoExit(void);
	void __fastcall IntColorChanged(void);
	virtual Vcl::Controls::TWinControl* __fastcall Control(void);
	HIDESBASE virtual System::Types::TPoint __fastcall ScreenToClient(const System::Types::TPoint &Point);
	void __fastcall DoSetPosition(int newValue, bool Redraw);
	void __fastcall DoSetMax(int newValue, bool Redraw);
	void __fastcall DoSetMin(int newValue, bool Redraw);
	void __fastcall DoSetPage(int newValue, bool Redraw);
	System::Uitypes::TColor __fastcall ShadowColor(void);
	System::Uitypes::TColor __fastcall LighterColor(void);
	void __fastcall SetFlat(bool newValue);
	void __fastcall SetActiveFlat(bool newValue);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	MESSAGE void __fastcall SBMSetScrollInfo(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall SBMGetScrollInfo(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMSysColorChange(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	void __fastcall OnScrollTimer(System::TObject* Sender);
	void __fastcall SetButtonSize(int newValue);
	void __fastcall SetThumbMode(Elsbctrl::TElScrollThumbMode newValue);
	void __fastcall SetThumbSize(int newValue);
	int __fastcall GetAutoThumbSize(void);
	int __fastcall GetThumbPos(void);
	int __fastcall GetTopBtns(void);
	int __fastcall GetBottomBtns(void);
	virtual int __fastcall AdjustThumbPos(void);
	virtual int __fastcall UpdateThumbPos(void);
	void __fastcall SetMinThumbSize(int newValue);
	void __fastcall SetSecondaryButtons(bool newValue);
	void __fastcall SetOwnerDraw(bool newValue);
	void __fastcall SetSecondBtnKind(Elsbctrl::TElSecButtonsKind newValue);
	void __fastcall SetNoDisableButtons(bool newValue);
	void __fastcall UpdateScrollingRegion(void);
	void __fastcall ShowHintAt(int APosition, int X, int Y);
	int __fastcall GetButtonSize(void);
	void __fastcall SetIsDesigning(bool newValue);
	bool __fastcall GetIsDesigning(void);
	void __fastcall SetBlendBackground(bool newValue);
	void __fastcall SetShowLeftArrows(bool newValue);
	void __fastcall SetShowRightArrows(bool newValue);
	void __fastcall SetNoSunkenThumb(bool newValue);
	void __fastcall SetUseSystemMetrics(bool value);
	void __fastcall SetArrowColor(System::Uitypes::TColor newValue);
	void __fastcall SetArrowHotTrackColor(System::Uitypes::TColor newValue);
	void __fastcall SetShowBorder(bool newValue);
	void __fastcall SetDrawBars(const bool Value);
	void __fastcall SetDrawArrowFrames(const bool Value);
	void __fastcall SetThinFrame(bool newValue);
	void __fastcall SetBarColor(const System::Uitypes::TColor Value);
	void __fastcall SetBarOffset(const unsigned Value);
	void __fastcall ImageFormChange(System::TObject* Sender);
	virtual void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	bool __fastcall RightBtnsEnabled(void);
	bool __fastcall LeftBtnsEnabled(void);
	void __fastcall RebuildBackground(void);
	void __fastcall SetAltDisablingArrows(const bool Value);
	int __fastcall GetThumbSize(void);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	virtual void __fastcall TriggerChangeEvent(void);
	virtual void __fastcall TriggerScrollEvent(Elsbctrl::TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);
	virtual void __fastcall TriggerScrollHintNeededEvent(int TrackPosition, Lmdtypes::TLMDString &Hint);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetSysBkColor(bool Value);
	virtual void __fastcall TriggerHitTestEvent(int X, int Y, Elsbctrl::TElScrollBarPart &Part, bool &DefaultTest);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	HIDESBASE MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall ELSettingChange(Winapi::Messages::TMessage &Message);
	__property Color;
	__property ParentColor = {default=0};
	__property Vcl::Forms::TScrollBarKind Kind = {read=FKind, write=SetKind, default=0};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Step = {read=FStep, write=FStep, default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property bool ActiveFlat = {read=FActiveFlat, write=SetActiveFlat, default=0};
	__property int ButtonSize = {read=GetButtonSize, write=SetButtonSize, nodefault};
	__property Elsbctrl::TElScrollThumbMode ThumbMode = {read=FThumbMode, write=SetThumbMode, default=1};
	__property int ThumbSize = {read=GetThumbSize, write=SetThumbSize, default=0};
	__property int MinThumbSize = {read=FMinThumbSize, write=SetMinThumbSize, default=15};
	__property int Page = {read=FPage, write=SetPage, default=14};
	__property bool SecondaryButtons = {read=FSecondaryButtons, write=SetSecondaryButtons, default=0};
	__property Elsbctrl::TElSecButtonsKind SecondBtnKind = {read=FSecondBtnKind, write=SetSecondBtnKind, default=0};
	__property bool NoDisableButtons = {read=FNoDisableButtons, write=SetNoDisableButtons, default=0};
	__property bool ShowTrackHint = {read=FShowTrackHint, write=FShowTrackHint, default=0};
	__property bool IsDesigning = {read=GetIsDesigning, write=SetIsDesigning, default=0};
	__property bool BlendBackground = {read=FBlendBackground, write=SetBlendBackground, default=1};
	__property bool ShowLeftArrows = {read=FShowLeftArrows, write=SetShowLeftArrows, default=1};
	__property bool ShowRightArrows = {read=FShowRightArrows, write=SetShowRightArrows, default=1};
	__property bool ChangeColorsOnScroll = {read=FChangeColorsOnScroll, write=FChangeColorsOnScroll, default=1};
	__property bool NoScrollMessages = {read=FNoScrollMessages, write=FNoScrollMessages, default=0};
	__property bool NoSunkenThumb = {read=FNoSunkenThumb, write=SetNoSunkenThumb, default=0};
	__property bool UseSystemMetrics = {read=FUseSystemMetrics, write=SetUseSystemMetrics, default=1};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, default=1};
	__property bool DrawArrowFrames = {read=FDrawArrowFrames, write=SetDrawArrowFrames, default=1};
	__property bool DrawBars = {read=FDrawBars, write=SetDrawBars, default=1};
	__property unsigned BarOffset = {read=FBarOffset, write=SetBarOffset, default=2};
	__property System::Uitypes::TColor BarColor = {read=FBarColor, write=SetBarColor, default=-16777200};
	__property bool IsHTML = {read=FIsHTML, write=FIsHTML, default=0};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Elsbctrl::TElScrollHitTestEvent OnHitTest = {read=FOnHitTest, write=FOnHitTest};
	__property Elsbctrl::TElSBScrollEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property Elsbctrl::TElScrollHintNeededEvent OnScrollHintNeeded = {read=FOnScrollHintNeeded, write=FOnScrollHintNeeded};
	__property bool OwnerDraw = {read=FOwnerDraw, write=SetOwnerDraw, default=0};
	__property Elsbctrl::TElScrollDrawPartEvent OnDrawPart = {read=FOnDrawPart, write=FOnDrawPart};
	__property System::Uitypes::TColor ArrowColor = {read=FArrowColor, write=SetArrowColor, default=-16777198};
	__property System::Uitypes::TColor ArrowHotTrackColor = {read=FArrowHotTrackColor, write=SetArrowHotTrackColor, default=-16777203};
	__property bool ThinFrame = {read=FThinFrame, write=SetThinFrame, default=0};
	__property System::Uitypes::TColor HintColor = {read=FHintColor, write=FHintColor, default=-16777192};
	__property System::Uitypes::TColor HintTextColor = {read=FHintTextColor, write=FHintTextColor, default=-16777193};
	__property bool SystemBkColor = {read=FSysBkColor, write=SetSysBkColor, default=1};
	__property bool AltDisablingArrows = {read=FAltDisablingArrows, write=SetAltDisablingArrows, default=0};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property int TrackPos = {read=FTrackPos, write=FTrackPos, nodefault};
	__property int ThumbPos = {read=FThumbPos, write=FThumbPos, nodefault};
	__property bool MouseInControl = {read=FMouseInControl, write=FMouseInControl, nodefault};
	__property Elsbctrl::TElScrollBarPart MouseOver = {read=FMouseOver, nodefault};
	__property bool Tracking = {read=FTracking, nodefault};
	__property bool Pressed = {read=FPressed, nodefault};
	__property Elsbctrl::TElScrollBarPart PressedIn = {read=FPressedIn, nodefault};
	__property Vcl::Extctrls::TTimer* ScrollTimer = {read=FScrollTimer};
	
public:
	__fastcall virtual TCustomElScrollBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElScrollBar(void);
	Elsbctrl::TElScrollBarPart __fastcall GetHitTest(int X, int Y);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall HideHint(void);
	void __fastcall EndScroll(void);
	int __fastcall SetScrollInfo(const tagSCROLLINFO &ScrollInfo, System::LongBool Redraw);
	System::LongBool __fastcall GetScrollInfo(tagSCROLLINFO &ScrollInfo);
	
__published:
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElScrollBar(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElScrollBarStyles : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TCustomElScrollBar* FElScrollBar;
	System::Classes::TNotifyEvent FOnChange;
	Vcl::Controls::TControl* FOwner;
	bool __fastcall IsSystemSettingsNotUsed(void);
	int __fastcall GetButtonSize(void);
	void __fastcall SetButtonSize(int newValue);
	bool __fastcall GetNoDisableButtons(void);
	void __fastcall SetNoDisableButtons(bool newValue);
	bool __fastcall GetNoSunkenThumb(void);
	void __fastcall SetNoSunkenThumb(bool newValue);
	void __fastcall SetActiveFlat(bool newValue);
	bool __fastcall GetActiveFlat(void);
	void __fastcall SetColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetColor(void);
	void __fastcall SetFlat(bool newValue);
	bool __fastcall GetFlat(void);
	void __fastcall SetMinThumbSize(int newValue);
	int __fastcall GetMinThumbSize(void);
	void __fastcall SetOwnerDraw(bool newValue);
	bool __fastcall GetOwnerDraw(void);
	void __fastcall SetSecondaryButtons(bool newValue);
	bool __fastcall GetSecondaryButtons(void);
	void __fastcall SetSecondBtnKind(Elsbctrl::TElSecButtonsKind newValue);
	Elsbctrl::TElSecButtonsKind __fastcall GetSecondBtnKind(void);
	void __fastcall SetShowTrackHint(bool newValue);
	bool __fastcall GetShowTrackHint(void);
	void __fastcall SetThumbMode(Elsbctrl::TElScrollThumbMode newValue);
	Elsbctrl::TElScrollThumbMode __fastcall GetThumbMode(void);
	void __fastcall SetThumbSize(int newValue);
	int __fastcall GetThumbSize(void);
	bool __fastcall GetBlendBackground(void);
	void __fastcall SetBlendBackground(bool newValue);
	int __fastcall GetWidth(void);
	void __fastcall SetWidth(int newValue);
	bool __fastcall GetShowLeftArrows(void);
	void __fastcall SetShowLeftArrows(bool newValue);
	bool __fastcall GetShowRightArrows(void);
	void __fastcall SetShowRightArrows(bool newValue);
	bool __fastcall GetUseSystemMetrics(void);
	void __fastcall SetUseSystemMetrics(bool Value);
	System::Uitypes::TColor __fastcall GetArrowColor(void);
	void __fastcall SetArrowColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetArrowHotTrackColor(void);
	void __fastcall SetArrowHotTrackColor(System::Uitypes::TColor newValue);
	bool __fastcall GetShowBorder(void);
	void __fastcall SetShowBorder(bool newValue);
	bool __fastcall GetThinFrame(void);
	void __fastcall SetThinFrame(bool newValue);
	System::Uitypes::TColor __fastcall GetHintColor(void);
	void __fastcall SetHintColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetHintTextColor(void);
	void __fastcall SetHintTextColor(System::Uitypes::TColor Value);
	bool __fastcall GetDrawBars(void);
	void __fastcall SetDrawBars(const bool Value);
	System::Uitypes::TColor __fastcall GetBarColor(void);
	void __fastcall SetBarColor(const System::Uitypes::TColor Value);
	unsigned __fastcall GetBarOffset(void);
	void __fastcall SetBarOffset(const unsigned Value);
	Elimgfrm::TElImageForm* __fastcall GetImageForm(void);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	bool __fastcall GetDrawArrowFrames(void);
	void __fastcall SetDrawArrowFrames(const bool Value);
	bool __fastcall GetUseXPThemes(void);
	void __fastcall SetUseXPThemes(const bool Value);
	bool __fastcall GetThemeGlobalMode(void);
	Lmdclass::TLMDThemeMode __fastcall GetThemeMode(void);
	void __fastcall SetThemeGlobalMode(const bool Value);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	
protected:
	bool __fastcall GetSysBkColor(void);
	void __fastcall SetSysBkColor(bool Value);
	void __fastcall ReadThinFramesProperty(System::Classes::TReader* Reader);
	void __fastcall ReadDrawFramesProperty(System::Classes::TReader* Reader);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall TElScrollBarStyles(TCustomElScrollBar* AControl, Vcl::Controls::TControl* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, default=1};
	
__published:
	__property bool ActiveFlat = {read=GetActiveFlat, write=SetActiveFlat, default=0};
	__property bool BlendBackground = {read=GetBlendBackground, write=SetBlendBackground, default=1};
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, default=-16777201};
	__property bool Flat = {read=GetFlat, write=SetFlat, default=1};
	__property int MinThumbSize = {read=GetMinThumbSize, write=SetMinThumbSize, default=15};
	__property bool NoDisableButtons = {read=GetNoDisableButtons, write=SetNoDisableButtons, default=0};
	__property bool NoSunkenThumb = {read=GetNoSunkenThumb, write=SetNoSunkenThumb, default=0};
	__property bool OwnerDraw = {read=GetOwnerDraw, write=SetOwnerDraw, default=0};
	__property bool SecondaryButtons = {read=GetSecondaryButtons, write=SetSecondaryButtons, default=0};
	__property Elsbctrl::TElSecButtonsKind SecondBtnKind = {read=GetSecondBtnKind, write=SetSecondBtnKind, default=0};
	__property bool ShowLeftArrows = {read=GetShowLeftArrows, write=SetShowLeftArrows, default=1};
	__property bool ShowRightArrows = {read=GetShowRightArrows, write=SetShowRightArrows, default=1};
	__property bool ShowTrackHint = {read=GetShowTrackHint, write=SetShowTrackHint, default=0};
	__property Elsbctrl::TElScrollThumbMode ThumbMode = {read=GetThumbMode, write=SetThumbMode, default=1};
	__property int ThumbSize = {read=GetThumbSize, write=SetThumbSize, default=0};
	__property int Width = {read=GetWidth, write=SetWidth, nodefault};
	__property int ButtonSize = {read=GetButtonSize, write=SetButtonSize, stored=IsSystemSettingsNotUsed, nodefault};
	__property bool UseSystemMetrics = {read=GetUseSystemMetrics, write=SetUseSystemMetrics, default=1};
	__property System::Uitypes::TColor ArrowColor = {read=GetArrowColor, write=SetArrowColor, default=-16777198};
	__property System::Uitypes::TColor ArrowHotTrackColor = {read=GetArrowHotTrackColor, write=SetArrowHotTrackColor, default=-16777203};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool ShowBorder = {read=GetShowBorder, write=SetShowBorder, default=1};
	__property bool DrawArrowFrames = {read=GetDrawArrowFrames, write=SetDrawArrowFrames, default=1};
	__property bool DrawBars = {read=GetDrawBars, write=SetDrawBars, default=1};
	__property unsigned BarOffset = {read=GetBarOffset, write=SetBarOffset, default=2};
	__property System::Uitypes::TColor BarColor = {read=GetBarColor, write=SetBarColor, default=-16777200};
	__property bool ThinFrame = {read=GetThinFrame, write=SetThinFrame, default=0};
	__property System::Uitypes::TColor HintColor = {read=GetHintColor, write=SetHintColor, default=-16777192};
	__property System::Uitypes::TColor HintTextColor = {read=GetHintTextColor, write=SetHintTextColor, default=-16777193};
	__property bool SystemBkColor = {read=GetSysBkColor, write=SetSysBkColor, default=1};
	__property Elimgfrm::TElImageForm* ImageForm = {read=GetImageForm, write=SetImageForm};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=GetThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=GetThemeGlobalMode, write=SetThemeGlobalMode, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElScrollBarStyles(void) { }
	
};


class PASCALIMPLEMENTATION TElScrollBar : public TCustomElScrollBar
{
	typedef TCustomElScrollBar inherited;
	
public:
	__property UseXPThemes;
	
__published:
	__property AltDisablingArrows = {default=0};
	__property ArrowColor = {default=-16777198};
	__property ArrowHotTrackColor = {default=-16777203};
	__property Kind = {default=0};
	__property Position = {default=0};
	__property Max = {default=100};
	__property Min = {default=0};
	__property Flat = {default=1};
	__property ActiveFlat = {default=0};
	__property BlendBackground = {default=1};
	__property SystemBkColor = {default=1};
	__property ButtonSize;
	__property ChangeColorsOnScroll = {default=1};
	__property ShowBorder = {default=1};
	__property DrawArrowFrames = {default=1};
	__property DrawBars = {default=1};
	__property BarOffset = {default=2};
	__property BarColor = {default=-16777200};
	__property ImageForm;
	__property IsHTML = {default=0};
	__property MinThumbSize = {default=15};
	__property NoDisableButtons = {default=0};
	__property NoSunkenThumb = {default=0};
	__property Page = {default=14};
	__property SecondaryButtons = {default=0};
	__property SecondBtnKind = {default=0};
	__property ShowLeftArrows = {default=1};
	__property ShowRightArrows = {default=1};
	__property ShowTrackHint = {default=0};
	__property Step = {default=1};
	__property ThinFrame = {default=0};
	__property ThumbMode = {default=1};
	__property ThumbSize = {default=0};
	__property UseSystemMetrics = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property Align = {default=0};
	__property Color;
	__property Ctl3D;
	__property Enabled = {default=1};
	__property ParentFont = {default=1};
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnHitTest;
	__property OnChange;
	__property OnScroll;
	__property OnScrollHintNeeded;
	__property OwnerDraw = {default=0};
	__property OnDrawPart;
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
public:
	/* TCustomElScrollBar.Create */ inline __fastcall virtual TElScrollBar(System::Classes::TComponent* AOwner) : TCustomElScrollBar(AOwner) { }
	/* TCustomElScrollBar.Destroy */ inline __fastcall virtual ~TElScrollBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElScrollBar(HWND ParentWindow) : TCustomElScrollBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elscrollbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSCROLLBAR)
using namespace Elscrollbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElscrollbarHPP
