// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElAdvPanel.pas' rev: 31.00 (Windows)

#ifndef EladvpanelHPP
#define EladvpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <System.Math.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Types.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Themes.hpp>
#include <ElPanel.hpp>
#include <ElPopBtn.hpp>
#include <ElVCLUtils.hpp>
#include <ElHTMLPanel.hpp>
#include <ElImgFrm.hpp>
#include <ElStyleMan.hpp>
#include <ElCheckCtl.hpp>
#include <LMDProcs.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDElConst.hpp>
#include <LMDTypes.hpp>
#include <LMDGlyphs.hpp>
#include <LMDPNGImage.hpp>
#include <LMDPNGImageList.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGraph.hpp>
#include <System.UITypes.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElBtnCtl.hpp>
#include <ElXPThemedControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eladvpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElPanelCaptionSettings;
class DELPHICLASS TCustomElAdvancedPanel;
class DELPHICLASS TElAdvancedPanel;
class DELPHICLASS TElAdvCaptionPanel;
class DELPHICLASS TElAdvCaptionButton;
class DELPHICLASS THackCheckBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElMinButtonPosition : unsigned char { mbpLeft, mbpRight };

typedef void __fastcall (__closure *TElBeforeMinimizeRestoreEvent)(System::TObject* Sender, bool &Accept);

typedef void __fastcall (__closure *TElRestoreHeightEvent)(System::TObject* Sender, int &AHeight);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElPanelCaptionSettings : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FVisible;
	int FHeight;
	bool FShowCloseButton;
	TCustomElAdvancedPanel* FOwner;
	bool FShowMinButton;
	TElMinButtonPosition FMinButtonPos;
	int FButtonWidth;
	System::Classes::TAlignment FAlignment;
	Vcl::Stdctrls::TTextLayout FLayout;
	System::Uitypes::TColor FButtonColor;
	bool FShowCheckBox;
	bool FCheckBoxChecked;
	System::Uitypes::TColor __fastcall GetGradientEndColor(void);
	System::Uitypes::TColor __fastcall GetGradientStartColor(void);
	int __fastcall GetGradientSteps(void);
	void __fastcall SetGradientEndColor(const System::Uitypes::TColor Value);
	void __fastcall SetGradientStartColor(const System::Uitypes::TColor Value);
	void __fastcall SetGradientSteps(const int Value);
	Lmdgraph::TLMDBackgroundType __fastcall GetBackgroundType(void);
	void __fastcall SetBackgroundType(const Lmdgraph::TLMDBackgroundType Value);
	void __fastcall SetText(Lmdtypes::TLMDString Value);
	void __fastcall SetVisible(bool Value);
	void __fastcall SetHeight(int Value);
	void __fastcall SetShowCloseButton(bool Value);
	void __fastcall SetShowMinButton(bool Value);
	void __fastcall SetMinButtonPos(TElMinButtonPosition Value);
	Lmdtypes::TLMDString __fastcall GetText(void);
	void __fastcall SetButtonWidth(int Value);
	void __fastcall SetAlignment(System::Classes::TAlignment Value);
	void __fastcall SetLayout(Vcl::Stdctrls::TTextLayout newValue);
	Vcl::Graphics::TFont* __fastcall GetFont(void);
	void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	bool __fastcall GetParentFont(void);
	void __fastcall SetParentFont(bool Value);
	System::Uitypes::TColor __fastcall GetColor(void);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	void __fastcall SetButtonColor(System::Uitypes::TColor Value);
	Elimgfrm::TElImageForm* __fastcall GetImageForm(void);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* Value);
	void __fastcall SetShowCheckBox(bool Value);
	void __fastcall SetCheckBoxChecked(bool Value);
	bool __fastcall GetCheckBoxChecked(void);
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* const Value);
	Vcl::Graphics::TBitmap* __fastcall GetBackground(void);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* const Value);
	bool __fastcall GetCloseButtonTransparent(void);
	bool __fastcall GetMinButtonTransparent(void);
	void __fastcall SetCloseButtonTransparent(const bool Value);
	void __fastcall SetMinButtonTransparent(const bool Value);
	Lmdpngimage::TLMDPNGObject* __fastcall GetCloseButtonPngGlyph(void);
	Lmdpngimage::TLMDPNGObject* __fastcall GetMinButtonPngGlyph(void);
	void __fastcall SetCloseButtonPngGlyph(Lmdpngimage::TLMDPNGObject* const Value);
	void __fastcall SetMinButtonPngGlyph(Lmdpngimage::TLMDPNGObject* const Value);
	
protected:
	bool FInvertMinButtonArrows;
	bool FAutoSize;
	bool FFlat;
	bool FFlatAlways;
	Vcl::Graphics::TBitmap* __fastcall GetMinButtonGlyph(void);
	void __fastcall SetMinButtonGlyph(Vcl::Graphics::TBitmap* Value);
	Vcl::Graphics::TBitmap* __fastcall GetCloseButtonGlyph(void);
	void __fastcall SetCloseButtonGlyph(Vcl::Graphics::TBitmap* Value);
	void __fastcall SetInvertMinButtonArrows(bool Value);
	void __fastcall SetAutoSize(bool Value);
	void __fastcall FontChanged(void);
	void __fastcall AdjustHeight(void);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetFlatAlways(bool Value);
	
public:
	__fastcall TElPanelCaptionSettings(TCustomElAdvancedPanel* Owner);
	void __fastcall LoadDefaultMinButton(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Vcl::Graphics::TBitmap* Background = {read=GetBackground, write=SetBackground};
	__property Lmdgraph::TLMDBackgroundType BackgroundType = {read=GetBackgroundType, write=SetBackgroundType, default=2};
	__property Lmdtypes::TLMDString Text = {read=GetText, write=SetText};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Height = {read=FHeight, write=SetHeight, default=19};
	__property bool ShowCloseButton = {read=FShowCloseButton, write=SetShowCloseButton, nodefault};
	__property bool ShowMinButton = {read=FShowMinButton, write=SetShowMinButton, default=1};
	__property TElMinButtonPosition MinButtonPosition = {read=FMinButtonPos, write=SetMinButtonPos, default=1};
	__property bool FlatButtons = {read=FFlat, write=SetFlat, stored=false, default=1};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=15};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Vcl::Stdctrls::TTextLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property Vcl::Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property bool ParentFont = {read=GetParentFont, write=SetParentFont, default=1};
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, default=-16777201};
	__property System::Uitypes::TColor ButtonColor = {read=FButtonColor, write=SetButtonColor, default=-16777201};
	__property Elimgfrm::TElImageForm* ImageForm = {read=GetImageForm, write=SetImageForm};
	__property Vcl::Graphics::TBitmap* MinButtonGlyph = {read=GetMinButtonGlyph, write=SetMinButtonGlyph};
	__property Vcl::Graphics::TBitmap* CloseButtonGlyph = {read=GetCloseButtonGlyph, write=SetCloseButtonGlyph};
	__property Lmdpngimage::TLMDPNGObject* MinButtonPngGlyph = {read=GetMinButtonPngGlyph, write=SetMinButtonPngGlyph};
	__property Lmdpngimage::TLMDPNGObject* CloseButtonPngGlyph = {read=GetCloseButtonPngGlyph, write=SetCloseButtonPngGlyph};
	__property System::Uitypes::TColor GradientStartColor = {read=GetGradientStartColor, write=SetGradientStartColor, default=0};
	__property System::Uitypes::TColor GradientEndColor = {read=GetGradientEndColor, write=SetGradientEndColor, default=0};
	__property int GradientSteps = {read=GetGradientSteps, write=SetGradientSteps, default=16};
	__property bool InvertMinButtonArrows = {read=FInvertMinButtonArrows, write=SetInvertMinButtonArrows, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=0};
	__property bool ShowCheckBox = {read=FShowCheckBox, write=SetShowCheckBox, default=0};
	__property bool CheckBoxChecked = {read=GetCheckBoxChecked, write=SetCheckBoxChecked, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property bool FlatAlways = {read=FFlatAlways, write=SetFlatAlways, default=0};
	__property bool MinButtonTransparent = {read=GetMinButtonTransparent, write=SetMinButtonTransparent, default=0};
	__property bool CloseButtonTransparent = {read=GetCloseButtonTransparent, write=SetCloseButtonTransparent, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElPanelCaptionSettings(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCustomElAdvancedPanel : public Elhtmlpanel::TCustomElHTMLPanel
{
	typedef Elhtmlpanel::TCustomElHTMLPanel inherited;
	
protected:
	Vcl::Graphics::TBitmap* FMinButtonGlyph;
	Vcl::Imglist::TCustomImageList* FImages;
	int FSaveHeight;
	bool FMinimized;
	Elhtmlpanel::TElHTMLPanel* FCaptionPanel;
	TElPanelCaptionSettings* FCaptionSettings;
	Elpopbtn::TElGraphicButton* FMinButton;
	Elpopbtn::TElGraphicButton* FCloseButton;
	Elcheckctl::TElCheckBox* FCheckBox;
	TElBeforeMinimizeRestoreEvent FOnBeforeMinimize;
	System::Classes::TNotifyEvent FOnMinimize;
	TElBeforeMinimizeRestoreEvent FOnBeforeRestore;
	System::Classes::TNotifyEvent FOnRestore;
	TElRestoreHeightEvent FOnRestoreHeight;
	System::Classes::TNotifyEvent FOnClose;
	Vcl::Forms::TCloseQueryEvent FOnCloseQuery;
	System::Classes::TNotifyEvent FOnCheckBoxClick;
	virtual void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	virtual bool __fastcall TriggerBeforeMinimizeEvent(void);
	virtual void __fastcall TriggerMinimizeEvent(void);
	virtual bool __fastcall TriggerBeforeRestoreEvent(void);
	virtual void __fastcall TriggerRestoreHeightEvent(void);
	virtual void __fastcall TriggerRestoreEvent(void);
	virtual void __fastcall AdjustButtonSize(void);
	void __fastcall OnCaptionSize(System::TObject* Sender);
	void __fastcall OnMinButtonClick(System::TObject* Sender);
	void __fastcall OnCloseButtonClick(System::TObject* Sender);
	virtual void __fastcall TriggerCloseEvent(void);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	virtual void __fastcall CreateWnd(void);
	void __fastcall SetCaptionSettings(TElPanelCaptionSettings* Value);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Msg);
	void __fastcall LinkClickEventTransfer(System::TObject* Sender, Lmdtypes::TLMDString HRef);
	virtual void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall AdjustInnerSize(System::Types::TRect &R);
	int __fastcall GetBevelAdjustment(void);
	virtual int __fastcall GetBorderAdjustment(void);
	void __fastcall UpdateMinButtonImages(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadExpHeight(System::Classes::TReader* Reader);
	void __fastcall WriteExpHeight(System::Classes::TWriter* Writer);
	virtual void __fastcall SetTransparentXPThemes(bool Value);
	virtual TElAdvCaptionButton* __fastcall CreateButton(void);
	virtual Elcheckctl::TElCheckBox* __fastcall CreateCheckbox(void);
	virtual void __fastcall SetMinimized(bool Value);
	virtual TElAdvCaptionPanel* __fastcall CreatePanel(void);
	virtual void __fastcall UpdateInterior(void);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMTabStopChanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DoClick(System::TObject* Sender);
	virtual void __fastcall DoCheckBoxClick(System::TObject* Sender);
	bool __fastcall GetShowFocus(void);
	HIDESBASE void __fastcall SetShowFocus(bool Value);
	virtual void __fastcall DoDblClick(System::TObject* Sender);
	virtual void __fastcall TriggerCloseQueryEvent(bool &CanClose);
	HIDESBASE MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	__property bool Minimized = {read=FMinimized, write=SetMinimized, default=0};
	__property TElPanelCaptionSettings* CaptionSettings = {read=FCaptionSettings, write=SetCaptionSettings};
	__property TElBeforeMinimizeRestoreEvent OnBeforeMinimize = {read=FOnBeforeMinimize, write=FOnBeforeMinimize};
	__property System::Classes::TNotifyEvent OnMinimize = {read=FOnMinimize, write=FOnMinimize};
	__property TElBeforeMinimizeRestoreEvent OnBeforeRestore = {read=FOnBeforeRestore, write=FOnBeforeRestore};
	__property TElRestoreHeightEvent OnRestoreHeight = {read=FOnRestoreHeight, write=FOnRestoreHeight};
	__property System::Classes::TNotifyEvent OnRestore = {read=FOnRestore, write=FOnRestore};
	__property System::Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property Vcl::Forms::TCloseQueryEvent OnCloseQuery = {read=FOnCloseQuery, write=FOnCloseQuery};
	__property System::Classes::TNotifyEvent OnCheckBoxClick = {read=FOnCheckBoxClick, write=FOnCheckBoxClick};
	__property bool ShowFocus = {read=GetShowFocus, write=SetShowFocus, default=1};
	
public:
	__fastcall virtual TCustomElAdvancedPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElAdvancedPanel(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D)/* overload */;
	virtual int __fastcall GetCaptionHeight(void);
	virtual int __fastcall GetButtonWidth(void);
	__property Elhtmlpanel::TElHTMLPanel* CaptionPanel = {read=FCaptionPanel};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElAdvancedPanel(HWND ParentWindow) : Elhtmlpanel::TCustomElHTMLPanel(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	DYNAMIC inline void __fastcall  ChangeScale(int M, int D, bool isDpiChange){ Vcl::Controls::TWinControl::ChangeScale(M, D, isDpiChange); }
	
};


class PASCALIMPLEMENTATION TElAdvancedPanel : public TCustomElAdvancedPanel
{
	typedef TCustomElAdvancedPanel inherited;
	
__published:
	__property OnImageNeeded;
	__property OnLinkClick;
	__property OnTagFound;
	__property Cursor;
	__property LinkColor = {default=16711680};
	__property LinkPopupMenu;
	__property LinkStyle = {default=4};
	__property Background;
	__property BackgroundType = {default=2};
	__property GradientEndColor = {default=0};
	__property GradientStartColor = {default=0};
	__property GradientSteps = {default=16};
	__property Alignment = {default=2};
	__property Layout = {default=1};
	__property ImageForm;
	__property TopGrabHandle;
	__property RightGrabHandle;
	__property LeftGrabHandle;
	__property BottomGrabHandle;
	__property Resizable = {default=0};
	__property Movable = {default=0};
	__property OnMove;
	__property Align;
	__property BevelInner;
	__property BevelOuter;
	__property BevelSpaceColor;
	__property BevelWidth = {default=1};
	__property BorderSides = {default=15};
	__property BorderStyle = {default=0};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Locked = {default=0};
	__property MouseCapture = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentThemeMode = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property ShowFocus = {default=1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property TransparentXPThemes = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Visible = {default=1};
	__property SizeGrip = {default=0};
	__property Caption;
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
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockSite = {default=0};
	__property DockOrientation;
	__property BevelKind = {default=0};
	__property DoubleBuffered;
	__property DragKind = {default=0};
	__property Minimized = {default=0};
	__property CaptionSettings;
	__property OnMinimize;
	__property OnBeforeMinimize;
	__property OnBeforeRestore;
	__property OnRestore;
	__property OnRestoreHeight;
	__property OnClose;
	__property OnCloseQuery;
	__property OnCheckBoxClick;
public:
	/* TCustomElAdvancedPanel.Create */ inline __fastcall virtual TElAdvancedPanel(System::Classes::TComponent* AOwner) : TCustomElAdvancedPanel(AOwner) { }
	/* TCustomElAdvancedPanel.Destroy */ inline __fastcall virtual ~TElAdvancedPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElAdvancedPanel(HWND ParentWindow) : TCustomElAdvancedPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElAdvCaptionPanel : public Elhtmlpanel::TElHTMLPanel
{
	typedef Elhtmlpanel::TElHTMLPanel inherited;
	
private:
	int FDummyInt;
	bool FDummyBool;
	System::Classes::TShiftState FShiftState;
	bool DoResize;
	Lmdglyphs::TLMDButtonGlyph* FGlyphButton;
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Msg);
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* const Value);
	
protected:
	virtual void __fastcall TriggerPaintEvent(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	virtual void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TElAdvCaptionPanel(System::Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__fastcall virtual ~TElAdvCaptionPanel(void);
	
__published:
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property bool TabStop = {read=FDummyBool, write=FDummyBool, nodefault};
	__property int TabOrder = {read=FDummyInt, write=FDummyInt, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElAdvCaptionPanel(HWND ParentWindow) : Elhtmlpanel::TElHTMLPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElAdvCaptionButton : public Elpopbtn::TElGraphicButton
{
	typedef Elpopbtn::TElGraphicButton inherited;
	
public:
	__fastcall virtual TElAdvCaptionButton(System::Classes::TComponent* AOwner);
public:
	/* TCustomElGraphicButton.Destroy */ inline __fastcall virtual ~TElAdvCaptionButton(void) { }
	
};


class PASCALIMPLEMENTATION THackCheckBox : public Elcheckctl::TElCheckBox
{
	typedef Elcheckctl::TElCheckBox inherited;
	
public:
	/* TElCheckItem.Create */ inline __fastcall virtual THackCheckBox(System::Classes::TComponent* AOwner) : Elcheckctl::TElCheckBox(AOwner) { }
	/* TElCheckItem.Destroy */ inline __fastcall virtual ~THackCheckBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackCheckBox(HWND ParentWindow) : Elcheckctl::TElCheckBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eladvpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELADVPANEL)
using namespace Eladvpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EladvpanelHPP
