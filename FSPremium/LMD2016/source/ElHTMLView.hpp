// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElHTMLView.pas' rev: 31.00 (Windows)

#ifndef ElhtmlviewHPP
#define ElhtmlviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDTypes.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <Vcl.Themes.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDProcs.hpp>
#include <LMDSysIn.hpp>
#include <LMDThemes.hpp>
#include <LMDGraph.hpp>
#include <LMDClass.hpp>
#include <LMDUtils.hpp>
#include <ElSBCtrl.hpp>
#include <ElHTMLContainer.hpp>
#include <ElImgFrm.hpp>
#include <ElXPThemedControl.hpp>
#include <ElFormDisplay.hpp>
#include <ElVCLUtils.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elhtmlview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElHTMLView;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElHTMLView : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
private:
	Elformdisplay::TElFormDisplayChangeLink* FFormDisplayChangeLink;
	Elformdisplay::TElFormDisplay* FFormDisplay;
	bool FCheckFormDisplay;
	Elhtmlcontainer::TElHTMLContainer* FContainer;
	int FIndex;
	Elhtmlcontainer::TElHTMLChangeLink* FChangeLink;
	bool FCheck;
	void __fastcall SetContainer(Elhtmlcontainer::TElHTMLContainer* aValue);
	void __fastcall SetIndex(int aValue);
	Lmdtypes::TLMDString __fastcall GetCaptionText(void);
	bool __fastcall LinkEmpty(void);
	void __fastcall DoCaptionChange(System::TObject* Sender);
	Elsbctrl::TElSBController* fSBCtrl;
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	__property Elsbctrl::TElSBController* SBCtrl = {read=fSBCtrl};
	int FLineSpacing;
	bool FFlatFocusedScrollBars;
	bool FUseCustomScrollBars;
	Vcl::Menus::TPopupMenu* FLinkPopupMenu;
	System::Uitypes::TCursor FCursor;
	System::Uitypes::TColor FHighlightColor;
	System::Uitypes::TColor FHighlightBkColor;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	Lmdhtmlunit::TLMDHTMLTagFoundEvent FOnTagFound;
	System::Uitypes::TColor FLinkColor;
	System::Uitypes::TFontStyles FLinkStyle;
	Elimgfrm::TElImageForm* FImgForm;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FFlat;
	bool FWordWrap;
	bool FMouseOver;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	HDC TmpDC;
	int FGradientSteps;
	System::Uitypes::TColor FGradientStartColor;
	System::Uitypes::TColor FGradientEndColor;
	Vcl::Graphics::TBitmap* FTmpBmp;
	bool FTransparent;
	Vcl::Graphics::TBitmap* FBackground;
	Lmdgraph::TLMDBackgroundType FBackgroundType;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	System::UnicodeString FDummyString;
	System::Types::TPoint FViewPos;
	System::Types::TRect FTextRect;
	int FScrollStep;
	bool FVScrollVisible;
	bool FHScrollVisible;
	Lmdgraph::TLMDBorderSides FBorderSides;
	Lmdtypes::TLMDString FHint;
	Lmdtypes::TLMDString FCaption;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	System::Types::TRect FViewRect;
	int FMargin;
	bool FRightAlignedView;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorWindow;
	void __fastcall SetRightAlignedView(bool Value);
	HIDESBASE MESSAGE void __fastcall WMSysColorChange(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Winapi::Messages::TMessage &Msg);
	void __fastcall SBChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle Value);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall SetTransparent(bool newValue);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetBackgroundType(Lmdgraph::TLMDBackgroundType newValue);
	void __fastcall ImageChange(System::TObject* Sender);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetGradientStartColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientEndColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientSteps(int newValue);
	void __fastcall RedoTmpBmp(void);
	void __fastcall DrawFlatBorder(bool HorzTracking, bool VertTracking);
	void __fastcall DrawFlatBorderEx(HDC DC, bool HorzTracking, bool VertTracking);
	void __fastcall OnHScroll(System::TObject* Sender, Elsbctrl::TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);
	void __fastcall OnVScroll(System::TObject* Sender, Elsbctrl::TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseWheel(Vcl::Controls::TCMMouseWheel &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	virtual Elsbctrl::TElCtrlScrollBarStyles* __fastcall GetHorzScrollBar(void);
	virtual Elsbctrl::TElCtrlScrollBarStyles* __fastcall GetVertScrollBar(void);
	virtual void __fastcall SetHorzScrollBar(Elsbctrl::TElCtrlScrollBarStyles* const Value);
	virtual void __fastcall SetVertScrollBar(Elsbctrl::TElCtrlScrollBarStyles* const Value);
	virtual void __fastcall PrepareText(void);
	virtual void __fastcall SetViewPos(const System::Types::TPoint &newValue);
	virtual void __fastcall SetWordWrap(bool newValue);
	void __fastcall AdjustScrollBars(void);
	virtual void __fastcall Paint(void);
	void __fastcall UpdateFrame(void);
	virtual void __fastcall SetActiveBorderType(Elvclutils::TElFlatBorderType newValue);
	virtual void __fastcall SetInactiveBorderType(Elvclutils::TElFlatBorderType newValue);
	virtual void __fastcall SetFlat(bool newValue);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	virtual void __fastcall SetHighlightColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetHighlightBkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall TriggerLinkClickEvent(System::UnicodeString HRef);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	void __fastcall TriggerTagFoundEvent(System::TObject* Sender, Lmdtypes::TLMDString &Tag, Lmdhtmlunit::TLMDHTMLItem* &Item, System::Classes::TStringList* &Params, bool aClosing, bool aSupported);
	void __fastcall TriggerRenderChange(System::TObject* Sender);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE virtual void __fastcall SetCursor(System::Uitypes::TCursor newValue);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetUseCustomScrollBars(bool newValue);
	virtual void __fastcall SetFlatFocusedScrollBars(bool newValue);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetCaption(Lmdtypes::TLMDString newValue);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	void __fastcall DoLinkPopup(const System::Types::TPoint &MousePos);
	void __fastcall SetLineSpacing(int AValue);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetViewRect(const System::Types::TRect &Value);
	void __fastcall SetMargin(int Value);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	void __fastcall SetFormDisplay(Elformdisplay::TElFormDisplay* const Value);
	__property System::Types::TRect ViewRect = {read=FViewRect, write=SetViewRect};
	
public:
	__fastcall virtual TElHTMLView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElHTMLView(void);
	DYNAMIC void __fastcall Click(void);
	__property bool VertScrollBarVisible = {read=FVScrollVisible, nodefault};
	__property bool HorzScrollBarVisible = {read=FHScrollVisible, nodefault};
	__property System::Types::TPoint Position = {read=FViewPos, write=SetViewPos};
	__property UseXPThemes;
	virtual void __fastcall LoadFromFile(const Lmdtypes::TLMDString AFileName);
	
__published:
	__property Elformdisplay::TElFormDisplay* FormDisplay = {read=FFormDisplay, write=SetFormDisplay};
	__property bool CheckFormDisplay = {read=FCheckFormDisplay, write=FCheckFormDisplay, nodefault};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property Elsbctrl::TElCtrlScrollBarStyles* HorzScrollBarStyles = {read=GetHorzScrollBar, write=SetHorzScrollBar};
	__property Elsbctrl::TElCtrlScrollBarStyles* VertScrollBarStyles = {read=GetVertScrollBar, write=SetVertScrollBar};
	__property bool RightAlignedView = {read=FRightAlignedView, write=SetRightAlignedView, default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, nodefault};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, nodefault};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property System::Uitypes::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, nodefault};
	__property System::Uitypes::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, nodefault};
	__property int GradientSteps = {read=FGradientSteps, write=SetGradientSteps, default=16};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property Lmdgraph::TLMDBackgroundType BackgroundType = {read=FBackgroundType, write=SetBackgroundType, default=2};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, nodefault};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=FLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TColor HighlightColor = {read=FHighlightColor, write=SetHighlightColor, default=-16777202};
	__property System::Uitypes::TColor HighlightBkColor = {read=FHighlightBkColor, write=SetHighlightBkColor, default=-16777203};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
	__property Lmdhtmlunit::TLMDHTMLTagFoundEvent OnTagFound = {read=FOnTagFound, write=FOnTagFound};
	__property bool UseCustomScrollBars = {read=FUseCustomScrollBars, write=SetUseCustomScrollBars, default=1};
	__property bool FlatFocusedScrollBars = {read=FFlatFocusedScrollBars, write=SetFlatFocusedScrollBars, default=0};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=0};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=0};
	__property System::UnicodeString Text = {read=FDummyString};
	__property int Margin = {read=FMargin, write=SetMargin, default=4};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
	__property Elhtmlcontainer::TElHTMLContainer* Container = {read=FContainer, write=SetContainer};
	__property int ContainerIndex = {read=FIndex, write=SetIndex, default=0};
	__property bool CheckContainerLinks = {read=FCheck, write=FCheck, default=1};
	__property int LineSpacing = {read=FLineSpacing, write=SetLineSpacing, default=0};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property Align = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentThemeMode = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
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
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElHTMLView(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elhtmlview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELHTMLVIEW)
using namespace Elhtmlview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElhtmlviewHPP
