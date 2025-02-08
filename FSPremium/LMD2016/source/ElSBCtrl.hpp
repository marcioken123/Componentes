// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElSBCtrl.pas' rev: 31.00 (Windows)

#ifndef ElsbctrlHPP
#define ElsbctrlHPP

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
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <Vcl.Themes.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDDebugUnit.hpp>
#include <ElVCLUtils.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDSysIn.hpp>
#include <LMDProcs.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElXPThemedControl.hpp>
#include <ElImgFrm.hpp>
#include <ElComponent.hpp>
#include <ElHintWnd.hpp>
#include <ElHook.hpp>
#include <ElSBHook.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elsbctrl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElSBHandlerCustom;
class DELPHICLASS TElCtrlScrollBarStyles;
class DELPHICLASS TElSBController;
class DELPHICLASS TElCtrlScrollBarStylesTracking;
class DELPHICLASS TElSBControllerTracking;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TElScrollHintNeededEvent)(System::TObject* Sender, int TrackPosition, Lmdtypes::TLMDString &Hint);

enum DECLSPEC_DENUM TElScrollBarPart : unsigned char { sbpNowhere, sbpLeftArrow, sbpRightSndArrow, sbpRightArrow, sbpLeftSndArrow, sbpThumb, sbpLeftTop, sbpRightBottom };

typedef void __fastcall (__closure *TElScrollHitTestEvent)(System::TObject* Sender, int X, int Y, TElScrollBarPart &Part, bool &DefaultTest);

typedef void __fastcall (__closure *TElScrollDrawPartEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, TElScrollBarPart Part, bool Enabled, bool Focused, bool Pressed, bool &DefaultDraw);

typedef void __fastcall (__closure *TElPaintCrossScrollBarsAreaEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, bool &DefaultDraw);

enum DECLSPEC_DENUM TElScrollCode : unsigned char { escLineUp, escLineDown, escPageUp, escPageDown, escPosition, escTrack, escTop, escBottom, escEndScroll, escSndLineUp, escSndLineDown };

typedef void __fastcall (__closure *TElSBScrollEvent)(System::TObject* Sender, TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);

enum DECLSPEC_DENUM TElSecButtonsKind : unsigned char { sbkOpposite, sbkPage, sbkCustom };

enum DECLSPEC_DENUM TElScrollThumbMode : unsigned char { etmFixed, etmAuto };

class PASCALIMPLEMENTATION TElSBHandlerCustom : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int fMin;
	int fMax;
	int fPage;
	int fPosition;
	int fTrackPos;
	Vcl::Forms::TScrollBarKind fKind;
	int fBarFlag;
	int fLeft;
	int fTop;
	int fWidth;
	int fHeight;
	System::Types::TRect fScrollBarRect;
	TElSBController* fSBController;
	bool fEnabled;
	bool fUseSystemMetrics;
	int fThumbPos;
	int fThumbSize;
	int fMinThumbSize;
	TElScrollThumbMode fThumbMode;
	bool fNoSunkenThumb;
	int fButtonSize;
	bool fFlat;
	bool fActiveFlat;
	bool fMouseInControl;
	bool fThinFrame;
	bool fShowBorder;
	bool fDrawArrowFrames;
	bool fDrawBars;
	unsigned fBarOffset;
	System::Uitypes::TColor fColor;
	System::Uitypes::TColor fThumbColor;
	System::Uitypes::TColor fBarColor;
	System::Uitypes::TColor fArrowColor;
	System::Uitypes::TColor fArrowHotTrackColor;
	bool fShowLeftArrows;
	bool fShowRightArrows;
	bool fChangeColorsOnScroll;
	bool fBitmapOwner;
	bool fBlendBackground;
	bool fShowTrackHint;
	bool fNoDisableButtons;
	bool fOwnerDraw;
	bool fSecondaryButtons;
	TElSecButtonsKind fSecondBtnKind;
	bool fIsHTML;
	System::Classes::TNotifyEvent fOnChange;
	TElSBScrollEvent fOnScroll;
	TElScrollDrawPartEvent fOnDrawPart;
	TElScrollHintNeededEvent fOnScrollHintNeeded;
	Vcl::Extctrls::TTimer* fScrollTimer;
	int fThumbOffset;
	int fOrigPos;
	int fOrigCoord;
	TElScrollBarPart fPressedIn;
	TElScrollBarPart fOrigPressedIn;
	TElScrollBarPart fMouseOver;
	Elhintwnd::TElHintWindow* fHintWnd;
	System::Types::TPoint fPressedPos;
	bool fPressed;
	bool fTracking;
	bool fScrollTracking;
	bool fNoScrollMessages;
	bool fAltDisablingArrows;
	TElScrollHitTestEvent fOnHitTest;
	bool fVisible;
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	void __fastcall SetKind(Vcl::Forms::TScrollBarKind newValue);
	void __fastcall SetPosition(int newValue);
	void __fastcall SetMax(int newValue);
	void __fastcall SetMin(int newValue);
	void __fastcall SetPage(int newValue);
	bool __fastcall GetVisible(void);
	void __fastcall SetVisible(bool Value);
	void __fastcall IntMouseButton(bool Pressed, System::Uitypes::TMouseButton Btn, short XPos, short YPos);
	void __fastcall IntMouseMove(short XPos, short YPos);
	void __fastcall IntMouseEnter(bool bRedraw);
	void __fastcall IntMouseLeave(bool bRedraw);
	void __fastcall Invalidate(void);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	void __fastcall SetThumbColor(System::Uitypes::TColor Value);
	System::Types::TRect __fastcall ClientRect(void);
	void __fastcall SetEnabled(bool Value);
	bool __fastcall GetFocused(void);
	bool __fastcall GetHandleAllocated(void);
	NativeUInt __fastcall GetHandle(void);
	int __fastcall Perform(unsigned Msg, int WParam, int LParam);
	System::Classes::TComponent* __fastcall GetControlOwner(void);
	System::Classes::TComponentState __fastcall GetComponentState(void);
	Vcl::Controls::TWinControl* __fastcall GetControl(void);
	void __fastcall DoSetPosition(int newValue, bool Redraw);
	void __fastcall DoSetMax(int newValue, bool Redraw);
	void __fastcall DoSetMin(int newValue, bool Redraw);
	void __fastcall DoSetPage(int newValue, bool Redraw);
	System::Uitypes::TColor __fastcall ShadowColor(void);
	System::Uitypes::TColor __fastcall LighterColor(void);
	void __fastcall SetFlat(bool newValue);
	void __fastcall SetActiveFlat(bool newValue);
	void __fastcall WMMouseWheel(Winapi::Messages::TMessage &Msg);
	void __fastcall OnScrollTimer(System::TObject* Sender);
	void __fastcall SetButtonSize(int newValue);
	void __fastcall SetThumbMode(TElScrollThumbMode newValue);
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
	void __fastcall SetSecondBtnKind(TElSecButtonsKind newValue);
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
	void __fastcall UpdateSystemMetrics(void);
	void __fastcall SetArrowColor(System::Uitypes::TColor newValue);
	void __fastcall SetArrowHotTrackColor(System::Uitypes::TColor newValue);
	void __fastcall SetShowBorder(bool newValue);
	void __fastcall SetDrawBars(const bool Value);
	void __fastcall SetDrawArrowFrames(const bool Value);
	void __fastcall SetThinFrame(bool newValue);
	void __fastcall SetBarColor(const System::Uitypes::TColor Value);
	void __fastcall SetBarOffset(const unsigned Value);
	bool __fastcall RightBtnsEnabled(void);
	bool __fastcall LeftBtnsEnabled(void);
	void __fastcall RebuildBackground(void);
	void __fastcall SetAltDisablingArrows(const bool Value);
	int __fastcall GetThumbSize(void);
	bool __fastcall GetUseXPThemes(void);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	void __fastcall SetUseXPThemes(const bool Value);
	
protected:
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	int __fastcall GetDepth(void);
	void __fastcall SetDepth(int Value);
	bool __fastcall NoUseSystemMetrics(void);
	Elimgfrm::TElImageForm* __fastcall GetImageForm(void);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* Value);
	void __fastcall ReadThinFramesProperty(System::Classes::TReader* Reader);
	void __fastcall ReadDrawFramesProperty(System::Classes::TReader* Reader);
	virtual void __fastcall CreateScrollTimer(void);
	virtual void __fastcall DestroyScrollTimer(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	Vcl::Graphics::TCanvas* fCanvas;
	System::Uitypes::TColor fHintColor;
	System::Uitypes::TColor fHintTextColor;
	Lmdtypes::TLMDString fHint;
	bool fSysBkColor;
	int fStep;
	bool fUseSystemStep;
	virtual void __fastcall TriggerChangeEvent(void);
	virtual void __fastcall TriggerScrollEvent(TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);
	virtual void __fastcall TriggerScrollHintNeededEvent(int TrackPosition, Lmdtypes::TLMDString &Hint);
	void __fastcall SetSysBkColor(bool Value);
	virtual void __fastcall TriggerHitTestEvent(int X, int Y, TElScrollBarPart &Part, bool &DefaultTest);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	__property bool Focused = {read=GetFocused, nodefault};
	__property Vcl::Controls::TWinControl* Control = {read=GetControl};
	__property NativeUInt Handle = {read=GetHandle, nodefault};
	__property bool HandleAllocated = {read=GetHandleAllocated, nodefault};
	__property System::Classes::TComponent* Owner = {read=GetControlOwner};
	__property System::Classes::TComponentState ComponentState = {read=GetComponentState, nodefault};
	__property int Left = {read=fLeft, write=fLeft, nodefault};
	__property int Top = {read=fTop, write=fTop, nodefault};
	__property int Width = {read=fWidth, write=fWidth, nodefault};
	__property int Height = {read=fHeight, write=fHeight, nodefault};
	__property Vcl::Forms::TScrollBarKind Kind = {read=fKind, write=SetKind, nodefault};
	__property bool IsDesigning = {read=GetIsDesigning, write=SetIsDesigning, default=0};
	__property bool NoScrollMessages = {read=fNoScrollMessages, write=fNoScrollMessages, default=1};
	__property int TrackPos = {read=fTrackPos, nodefault};
	__property int ThumbPos = {read=fThumbPos, nodefault};
	__property bool MouseInControl = {read=fMouseInControl, nodefault};
	__property TElScrollBarPart MouseOver = {read=fMouseOver, nodefault};
	__property bool Tracking = {read=fTracking, nodefault};
	__property bool Pressed = {read=fPressed, nodefault};
	__property TElScrollBarPart PressedIn = {read=fPressedIn, nodefault};
	__property Vcl::Extctrls::TTimer* ScrollTimer = {read=fScrollTimer};
	
public:
	__fastcall TElSBHandlerCustom(TElSBController* AController);
	__fastcall virtual ~TElSBHandlerCustom(void);
	bool __fastcall IsThemed(void);
	TElScrollBarPart __fastcall GetHitTest(int X, int Y);
	void __fastcall Paint(Vcl::Graphics::TCanvas* Canvas);
	int __fastcall SetScrollInfo(const tagSCROLLINFO &ScrollInfo, System::LongBool Redraw);
	void __fastcall SyncScrollInfoFromSystem(bool bRedraw);
	void __fastcall SyncScrollInfo(const tagSCROLLINFO &SI, bool bRedraw);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property int BarFlag = {read=fBarFlag, nodefault};
	__property bool Visible = {read=GetVisible, write=SetVisible, default=1};
	__property int Position = {read=fPosition, write=SetPosition, default=0};
	__property int Min = {read=fMin, write=SetMin, default=0};
	__property int Max = {read=fMax, write=SetMax, default=-1};
	__property bool ScrollTracking = {read=fScrollTracking, write=fScrollTracking, default=0};
	__property int Page = {read=fPage, write=SetPage, default=14};
	__property bool Enabled = {read=fEnabled, write=SetEnabled, default=1};
	__property int Depth = {read=GetDepth, write=SetDepth, stored=NoUseSystemMetrics, nodefault};
	__property int Step = {read=fStep, write=fStep, default=1};
	__property bool UseSystemStep = {read=fUseSystemStep, write=fUseSystemStep, default=1};
	__property bool Flat = {read=fFlat, write=SetFlat, default=1};
	__property bool ActiveFlat = {read=fActiveFlat, write=SetActiveFlat, default=0};
	__property int ButtonSize = {read=GetButtonSize, write=SetButtonSize, default=17};
	__property TElScrollThumbMode ThumbMode = {read=fThumbMode, write=SetThumbMode, default=1};
	__property int ThumbSize = {read=GetThumbSize, write=SetThumbSize, default=0};
	__property int MinThumbSize = {read=fMinThumbSize, write=SetMinThumbSize, default=12};
	__property bool SecondaryButtons = {read=fSecondaryButtons, write=SetSecondaryButtons, default=0};
	__property TElSecButtonsKind SecondBtnKind = {read=fSecondBtnKind, write=SetSecondBtnKind, default=0};
	__property bool NoDisableButtons = {read=fNoDisableButtons, write=SetNoDisableButtons, default=0};
	__property bool ShowTrackHint = {read=fShowTrackHint, write=fShowTrackHint, default=0};
	__property System::Uitypes::TColor Color = {read=fColor, write=SetColor, default=-16777201};
	__property System::Uitypes::TColor ThumbColor = {read=fThumbColor, write=SetThumbColor, default=-16777201};
	__property bool ChangeColorsOnScroll = {read=fChangeColorsOnScroll, write=fChangeColorsOnScroll, default=1};
	__property bool BlendBackground = {read=fBlendBackground, write=SetBlendBackground, default=1};
	__property bool ShowLeftArrows = {read=fShowLeftArrows, write=SetShowLeftArrows, default=1};
	__property bool ShowRightArrows = {read=fShowRightArrows, write=SetShowRightArrows, default=1};
	__property bool NoSunkenThumb = {read=fNoSunkenThumb, write=SetNoSunkenThumb, default=0};
	__property bool UseSystemMetrics = {read=fUseSystemMetrics, write=SetUseSystemMetrics, default=1};
	__property bool ShowBorder = {read=fShowBorder, write=SetShowBorder, default=1};
	__property bool DrawArrowFrames = {read=fDrawArrowFrames, write=SetDrawArrowFrames, default=1};
	__property bool DrawBars = {read=fDrawBars, write=SetDrawBars, default=1};
	__property unsigned BarOffset = {read=fBarOffset, write=SetBarOffset, default=2};
	__property System::Uitypes::TColor BarColor = {read=fBarColor, write=SetBarColor, default=-16777200};
	__property bool IsHTML = {read=fIsHTML, write=fIsHTML, default=0};
	__property System::Uitypes::TColor ArrowColor = {read=fArrowColor, write=SetArrowColor, default=-16777198};
	__property System::Uitypes::TColor ArrowHotTrackColor = {read=fArrowHotTrackColor, write=SetArrowHotTrackColor, default=-16777203};
	__property bool ThinFrame = {read=fThinFrame, write=SetThinFrame, default=0};
	__property System::Uitypes::TColor HintColor = {read=fHintColor, write=fHintColor, default=-16777192};
	__property System::Uitypes::TColor HintTextColor = {read=fHintTextColor, write=fHintTextColor, default=-16777193};
	__property bool SystemBkColor = {read=fSysBkColor, write=SetSysBkColor, default=1};
	__property bool AltDisablingArrows = {read=fAltDisablingArrows, write=SetAltDisablingArrows, default=1};
	__property Lmdtypes::TLMDString Hint = {read=fHint, write=SetHint};
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property bool OwnerDraw = {read=fOwnerDraw, write=SetOwnerDraw, default=0};
	__property System::Classes::TNotifyEvent OnChange = {read=fOnChange, write=fOnChange};
	__property TElScrollHitTestEvent OnHitTest = {read=fOnHitTest, write=fOnHitTest};
	__property TElSBScrollEvent OnScroll = {read=fOnScroll, write=fOnScroll};
	__property TElScrollHintNeededEvent OnScrollHintNeeded = {read=fOnScrollHintNeeded, write=fOnScrollHintNeeded};
	__property TElScrollDrawPartEvent OnDrawPart = {read=fOnDrawPart, write=fOnDrawPart};
	__property System::Types::TRect ScrollBarRect = {read=fScrollBarRect};
};


typedef System::TMetaClass* TElSBHandlerCustomClass;

class PASCALIMPLEMENTATION TElCtrlScrollBarStyles : public TElSBHandlerCustom
{
	typedef TElSBHandlerCustom inherited;
	
__published:
	__property ActiveFlat = {default=0};
	__property AltDisablingArrows = {default=1};
	__property ArrowColor = {default=-16777198};
	__property ArrowHotTrackColor = {default=-16777203};
	__property BarOffset = {default=2};
	__property BarColor = {default=-16777200};
	__property BlendBackground = {default=1};
	__property ButtonSize = {default=17};
	__property ChangeColorsOnScroll = {default=1};
	__property Color = {default=-16777201};
	__property ThumbColor = {default=-16777201};
	__property int Width = {read=GetDepth, write=SetDepth, stored=NoUseSystemMetrics, nodefault};
	__property DrawArrowFrames = {default=1};
	__property DrawBars = {default=1};
	__property ShowBorder = {default=1};
	__property Flat = {default=1};
	__property HintColor = {default=-16777192};
	__property HintTextColor = {default=-16777193};
	__property IsHTML = {default=0};
	__property MinThumbSize = {default=12};
	__property NoDisableButtons = {default=0};
	__property NoSunkenThumb = {default=0};
	__property OwnerDraw = {default=0};
	__property SecondaryButtons = {default=0};
	__property SecondBtnKind = {default=0};
	__property ShowLeftArrows = {default=1};
	__property ShowRightArrows = {default=1};
	__property ShowTrackHint = {default=0};
	__property Step = {default=1};
	__property SystemBkColor = {default=1};
	__property ThinFrame = {default=0};
	__property ThumbMode = {default=1};
	__property ThumbSize = {default=0};
	__property UseSystemMetrics = {default=1};
	__property UseSystemStep = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Elimgfrm::TElImageForm* ImageForm = {read=GetImageForm, write=SetImageForm};
	__property OnChange;
public:
	/* TElSBHandlerCustom.Create */ inline __fastcall TElCtrlScrollBarStyles(TElSBController* AController) : TElSBHandlerCustom(AController) { }
	/* TElSBHandlerCustom.Destroy */ inline __fastcall virtual ~TElCtrlScrollBarStyles(void) { }
	
};


enum DECLSPEC_DENUM TSaveWMSetRedraw : unsigned char { wmsrUnknown, wmsrFalse, wmsrTrue, wmsrFalseNeddRestore };

enum DECLSPEC_DENUM TScrollBarTracking : unsigned char { sbtrNone, sbtrHorizontal, sbtrVertical, sbtrBoth };

class PASCALIMPLEMENTATION TElSBController : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
protected:
	Elhook::TElHook* fElHook;
	
private:
	HWND fSaveCapture;
	Vcl::Forms::TScrollingWinControl* FWinCtrl;
	TElSBHandlerCustom* fHElSB;
	TElSBHandlerCustom* fVElSB;
	bool fPreventStyleChange;
	int cxLeftEdge;
	int cxRightEdge;
	int cyTopEdge;
	int cyBottomEdge;
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool fEmulateMouseWhell;
	TElPaintCrossScrollBarsAreaEvent fOnPaintCrossScrollBarsArea;
	TSaveWMSetRedraw fSaveWMSetRedraw;
	int fVSavePos;
	int fHSavePos;
	int fUpdateCount;
	Vcl::Controls::TWinControl* FScrollControl;
	TScrollBarTracking FScrollBarsTracking;
	bool __fastcall GetUseXPThemes(void);
	void __fastcall SetUseXPThemes(bool Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	Vcl::Controls::TWinControl* __fastcall GetControl(void);
	bool __fastcall GetControlHandleAllocated(void);
	void __fastcall SetControl(Vcl::Controls::TWinControl* Value);
	void __fastcall SetScrollBarStyles(int BarFlag, TElSBHandlerCustom* Value);
	TScrollBarTracking __fastcall GetScrollBarsTracking(void);
	void __fastcall SetScrollBarsTracking(TScrollBarTracking Value);
	bool __fastcall GetActive(void);
	
protected:
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	TElSBHandlerCustom* __fastcall GetScrollBar(int BarFlag);
	void __fastcall PaintScrollBar(int BarFlag);
	void __fastcall SyncScrollInfos(int BarFlag, bool bRedraw);
	void __fastcall HandleCtrlMsgBefore(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall HandleCtrlMsgAfter(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall NCPaintScrollBars(int WinStyle, int ExStyle);
	bool __fastcall NCPaint(Winapi::Messages::TMessage &Msg);
	bool __fastcall NCActivate(Winapi::Messages::TMessage &Msg);
	bool __fastcall NCCalcSize(Winapi::Messages::TMessage &Msg);
	bool __fastcall MouseEventHandler(Winapi::Messages::TMessage &Msg);
	bool __fastcall SBFilterMouseEventHandler(Winapi::Messages::TMessage &Msg);
	bool __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Msg);
	void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Msg);
	void __fastcall SetCaptureMouse(bool bGrab);
	void __fastcall ElSBScrollEvent(System::TObject* Sender, TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);
	void __fastcall InitiateNCCalcSize(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	bool __fastcall IsScrollingWinControl(void);
	virtual TElSBHandlerCustomClass __fastcall GetElSBHandlerClass(void);
	void __fastcall UpdateSystemMetrics(bool bRedraw);
	virtual void __fastcall CreateScrollHook(void);
	virtual void __fastcall DestroyScrollHook(void);
	void __stdcall SyncScrollInfo(int BarFlag, const tagSCROLLINFO &SI, System::LongBool bRedraw);
	MESSAGE void __fastcall ELSettingChange(Winapi::Messages::TMessage &Message);
	__property bool EmulateMouseWhell = {read=fEmulateMouseWhell, write=fEmulateMouseWhell, default=0};
	__property bool ControlHandleAllocated = {read=GetControlHandleAllocated, nodefault};
	
public:
	__fastcall virtual TElSBController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElSBController(void);
	bool __fastcall IsThemed(void);
	System::Types::TRect __fastcall GetCrossScrollBarsRect(void);
	System::LongBool __fastcall DoShowScrollBar(int wBar, System::LongBool bShow);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	int __fastcall InternalHitTest(int X, int Y);
	__property TElSBHandlerCustom* ScrollBar[int BarFlag] = {read=GetScrollBar};
	__property bool Active = {read=GetActive, nodefault};
	__property TScrollBarTracking ScrollBarsTracking = {read=GetScrollBarsTracking, write=SetScrollBarsTracking, default=0};
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	
__published:
	__property Vcl::Controls::TWinControl* Control = {read=GetControl, write=SetControl};
	__property TElSBHandlerCustom* HorzScrollBarStyles = {read=fHElSB, write=SetScrollBarStyles, index=0};
	__property TElSBHandlerCustom* VertScrollBarStyles = {read=fVElSB, write=SetScrollBarStyles, index=1};
	__property TElPaintCrossScrollBarsAreaEvent OnPaintCrossScrollBarsArea = {read=fOnPaintCrossScrollBarsArea, write=fOnPaintCrossScrollBarsArea};
};


class PASCALIMPLEMENTATION TElCtrlScrollBarStylesTracking : public TElCtrlScrollBarStyles
{
	typedef TElCtrlScrollBarStyles inherited;
	
__published:
	__property ScrollTracking = {default=0};
public:
	/* TElSBHandlerCustom.Create */ inline __fastcall TElCtrlScrollBarStylesTracking(TElSBController* AController) : TElCtrlScrollBarStyles(AController) { }
	/* TElSBHandlerCustom.Destroy */ inline __fastcall virtual ~TElCtrlScrollBarStylesTracking(void) { }
	
};


class PASCALIMPLEMENTATION TElSBControllerTracking : public TElSBController
{
	typedef TElSBController inherited;
	
protected:
	virtual TElSBHandlerCustomClass __fastcall GetElSBHandlerClass(void);
public:
	/* TElSBController.Create */ inline __fastcall virtual TElSBControllerTracking(System::Classes::TComponent* AOwner) : TElSBController(AOwner) { }
	/* TElSBController.Destroy */ inline __fastcall virtual ~TElSBControllerTracking(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int __fastcall HeightRect(const System::Types::TRect &R);
extern DELPHI_PACKAGE int __fastcall WidthRect(const System::Types::TRect &R);
}	/* namespace Elsbctrl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSBCTRL)
using namespace Elsbctrl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElsbctrlHPP
