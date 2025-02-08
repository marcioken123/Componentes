// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElPopBtn.pas' rev: 31.00 (Windows)

#ifndef ElpopbtnHPP
#define ElpopbtnHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.TypInfo.hpp>
#include <System.Classes.hpp>
#include <System.Math.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Buttons.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Themes.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDProcs.hpp>
#include <LMDUtils.hpp>
#include <LMDPNGImage.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>
#include <LMDGlyphs.hpp>
#include <LMDGraph.hpp>
#include <LMDGraphUtils.hpp>
#include <ElBtnCtl.hpp>
#include <ElCGControl.hpp>
#include <LMDElConst.hpp>
#include <ElImgFrm.hpp>
#include <ElStyleMan.hpp>
#include <ElSndMap.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>
#include <System.Actions.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elpopbtn
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElSpeedButton;
class DELPHICLASS TCustomElPopupButton;
class DELPHICLASS TElPopupButton;
class DELPHICLASS TElPopupButtonActionLink;
class DELPHICLASS TCustomElGraphicButton;
class DELPHICLASS TElGraphicButton;
class DELPHICLASS TElGraphicButtonActionLink;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TPullDownEvent)(System::TObject* Sender);

class PASCALIMPLEMENTATION TElSpeedButton : public Elcgcontrol::TElCustomGraphicControl
{
	typedef Elcgcontrol::TElCustomGraphicControl inherited;
	
private:
	System::Uitypes::TColor FTransparentColor;
	bool FAutoSize;
	Vcl::Graphics::TBitmap* FNormalImage;
	Vcl::Graphics::TBitmap* FDisabledImage;
	Vcl::Graphics::TBitmap* FMouseInImage;
	Vcl::Graphics::TBitmap* FPressedImage;
	bool FFlat;
	bool FDrawEdge;
	bool FPressed;
	bool FOver;
	Vcl::Extctrls::TTimer* FPullTimer;
	System::Uitypes::TMouseButton FPullDownBtn;
	int FPullDownInterval;
	bool FPullDownEnabled;
	Vcl::Menus::TPopupMenu* FPullDownMenu;
	bool FTransparent;
	TPullDownEvent FOnPullDown;
	Vcl::Imglist::TCustomImageList* FImages;
	bool FUseImageList;
	Vcl::Imglist::TChangeLink* FChLink;
	void __fastcall ChangeSize(void);
	void __fastcall SetPullDownMenu(Vcl::Menus::TPopupMenu* newValue);
	void __fastcall SetTransparent(bool newValue);
	void __fastcall SetDrawEdge(bool newValue);
	void __fastcall SetFlat(bool newValue);
	void __fastcall SetNormalImage(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetDisabledImage(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetMouseInImage(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetPressedImage(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetTransparentColor(System::Uitypes::TColor newValue);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetUseImageList(const bool Value);
	
protected:
	Lmdtypes::TLMDString FHint;
	virtual void __fastcall SetAutoSize(bool newValue);
	virtual void __fastcall TriggerPullDownEvent(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnTimer(System::TObject* Sender);
	void __fastcall StartTimer(void);
	void __fastcall PullMenu(void);
	void __fastcall ImagesChanged(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Winapi::Messages::TMessage &Message);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	
public:
	__fastcall virtual TElSpeedButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElSpeedButton(void);
	virtual bool __fastcall InCircle(int X, int Y);
	
__published:
	__property System::Uitypes::TMouseButton PullDownBtn = {read=FPullDownBtn, write=FPullDownBtn, nodefault};
	__property int PullDownInterval = {read=FPullDownInterval, write=FPullDownInterval, default=1000};
	__property bool PullDownEnabled = {read=FPullDownEnabled, write=FPullDownEnabled, default=0};
	__property Vcl::Menus::TPopupMenu* PullDownMenu = {read=FPullDownMenu, write=SetPullDownMenu};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property TPullDownEvent OnPullDown = {read=FOnPullDown, write=FOnPullDown};
	__property bool DrawEdge = {read=FDrawEdge, write=SetDrawEdge, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Vcl::Graphics::TBitmap* NormalImage = {read=FNormalImage, write=SetNormalImage};
	__property Vcl::Graphics::TBitmap* DisabledImage = {read=FDisabledImage, write=SetDisabledImage};
	__property Vcl::Graphics::TBitmap* MouseInImage = {read=FMouseInImage, write=SetMouseInImage};
	__property Vcl::Graphics::TBitmap* PressedImage = {read=FPressedImage, write=SetPressedImage};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property System::Uitypes::TColor TransparentColor = {read=FTransparentColor, write=SetTransparentColor, default=536870911};
	__property bool UseImageList = {read=FUseImageList, write=SetUseImageList, nodefault};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Align = {default=0};
	__property Color;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property ParentColor = {default=1};
	__property Enabled = {default=1};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnDragOver;
	__property OnDragDrop;
	__property Anchors = {default=3};
	__property Action;
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property DragKind = {default=0};
};


enum DECLSPEC_DENUM TPopupPlace : unsigned char { ppDown, ppRight, ppTop };

class PASCALIMPLEMENTATION TCustomElPopupButton : public Elbtnctl::TElButtonControl
{
	typedef Elbtnctl::TElButtonControl inherited;
	
private:
	bool __fastcall GetResizableButtonImage(void);
	void __fastcall SetResizableButtonImage(const bool Value);
	void __fastcall SetGlyphMaskUsage(const Lmdglyphs::TLMDGlyphListMaskUsage Value);
	
protected:
	bool FDblClicked;
	int FNumGlyphs;
	System::Uitypes::TCursor FCursor;
	bool FShadowsUseCustom;
	System::Uitypes::TColor FShadowBtnHighlight;
	System::Uitypes::TColor FShadowBtnShadow;
	System::Uitypes::TColor FShadowBtnDkShadow;
	Vcl::Graphics::TBitmap* FBackground;
	bool FShadowFollowsColor;
	Vcl::Graphics::TBitmap* FDownBackground;
	Vcl::Graphics::TBitmap* FHotBackground;
	bool FBackgroundDrawBorder;
	bool FThinFrame;
	Vcl::Imglist::TCustomImageList* FHotImages;
	Vcl::Imglist::TCustomImageList* FAlphaHotImages;
	Vcl::Imglist::TCustomImageList* FAlphaDisabledImages;
	Vcl::Imglist::TCustomImageList* FAlphaDownImages;
	Vcl::Imglist::TCustomImageList* FAlphaImageList;
	Vcl::Imglist::TCustomImageList* FDisabledImages;
	Vcl::Imglist::TCustomImageList* FDownImages;
	Vcl::Imglist::TCustomImageList* FImageList;
	bool FOldStyled;
	bool FUseImageList;
	bool FUseIcon;
	Elsndmap::TElSoundMap* FSoundMap;
	Elsndmap::TElSoundName FDownSound;
	Elsndmap::TElSoundName FUpSound;
	Elsndmap::TElSoundName FClickSound;
	Elsndmap::TElSoundName FArrowClickSound;
	bool FIsSwitch;
	bool FShowGlyph;
	bool FShowText;
	bool FUseArrow;
	bool FShowFocus;
	bool FMultiLine;
	int FGroupIndex;
	Lmdglyphs::TLMDButtonGlyph* FGlyph;
	bool FDown;
	bool FArrDown;
	bool FInMenu;
	bool FIgnoreClick;
	bool FDragging;
	bool FAllowAllUp;
	Vcl::Buttons::TButtonLayout FLayout;
	int FSpacing;
	int FMargin;
	bool FFlat;
	bool FMouseInArrow;
	bool FMouseInControl;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	bool FDisableAp;
	TPopupPlace FPopupPlace;
	bool FDefault;
	bool FCancel;
	bool FActive;
	System::Uitypes::TModalResult FModalResult;
	bool FClicksDisabled;
	Vcl::Imglist::TChangeLink* FAChLink;
	Vcl::Imglist::TChangeLink* FANChLink;
	Vcl::Imglist::TChangeLink* FADChLink;
	Vcl::Imglist::TChangeLink* FAHChLink;
	Vcl::Imglist::TChangeLink* FChLink;
	Vcl::Imglist::TChangeLink* FNChLink;
	Vcl::Imglist::TChangeLink* FDChLink;
	Vcl::Imglist::TChangeLink* FHChLink;
	bool FFocusOnClick;
	Vcl::Menus::TPopupMenu* FPullDownMenu;
	System::Classes::TNotifyEvent FOnArrowClick;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	bool FShowBorder;
	bool FAdjustSpaceForGlyph;
	bool FIsHTML;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	Lmdgraph::TLMDExButtonState FOrigState;
	Lmdgraph::TLMDExButtonState FState;
	bool FDrawDefaultFrame;
	bool FImageIsAlphaBlended;
	bool FDrawFocusFrame;
	System::Uitypes::TColor FLinkColor;
	Vcl::Menus::TPopupMenu* FLinkPopupMenu;
	System::Uitypes::TFontStyles FLinkStyle;
	System::Types::TRect FTextRect;
	bool FChangeDisabledText;
	System::Classes::TAlignment FAlignment;
	HWND FOldCapture;
	bool FIgnoreMouseDown;
	Lmdglyphs::TLMDGlyphListMaskUsage FGlyphMaskUsage;
	void __fastcall SetAlignment(System::Classes::TAlignment Value);
	void __fastcall SetIsHTML(bool Value);
	void __fastcall SetShowBorder(bool newValue);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall SetPullDownMenu(Vcl::Menus::TPopupMenu* newValue);
	void __fastcall SetDefault(bool Value);
	void __fastcall SetPopupPlace(TPopupPlace Value);
	void __fastcall SetDisableAp(bool Value);
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall UpdateExclusive(void);
	void __fastcall SetHotBackground(Vcl::Graphics::TBitmap* const Value);
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* Value);
	Lmdpngimage::TLMDPNGObject* __fastcall GetPNGGlyph(void);
	void __fastcall SetPNGGlyph(Lmdpngimage::TLMDPNGObject* Value);
	void __fastcall SetUsePng(const bool Value);
	bool __fastcall GetUsePng(void);
	Vcl::Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Vcl::Buttons::TNumGlyphs Value);
	void __fastcall SetDown(bool Value);
	void __fastcall SetAllowAllUp(bool Value);
	void __fastcall SetGroupIndex(int Value);
	void __fastcall SetLayout(Vcl::Buttons::TButtonLayout Value);
	void __fastcall SetSpacing(int Value);
	void __fastcall SetMargin(int Value);
	void __fastcall UpdateTracking(void);
	void __fastcall IntMouseEnter(void);
	void __fastcall IntMouseLeave(void);
	void __fastcall IntEnabledChanged(void);
	bool __fastcall IntKeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall IntKeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall IntTextChanged(void);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyUp(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMButtonPressed(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Vcl::Controls::TCMFocusChanged &Message);
	MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	void __fastcall SetShowFocus(bool newValue);
	void __fastcall SetShowGlyph(bool newValue);
	void __fastcall SetShowText(bool newValue);
	Vcl::Graphics::TIcon* __fastcall GetIcon(void);
	void __fastcall SetIcon(Vcl::Graphics::TIcon* newValue);
	void __fastcall SetIsSwitch(bool newValue);
	void __fastcall SetSoundMap(Elsndmap::TElSoundMap* newValue);
	void __fastcall SetImageIndex(int newValue);
	int __fastcall GetImageIndex(void);
	void __fastcall SetUseIcon(bool newValue);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaImageList(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetUseImageList(bool newValue);
	bool __fastcall GetUseImageList(void);
	void __fastcall SetOldStyled(bool newValue);
	void __fastcall SetHotImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaHotImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetDownImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaDownImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetDisabledImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaDisabledImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall ImagesChanged(System::TObject* Sender);
	void __fastcall SetThinFrame(bool newValue);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetDownBackground(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetBackgroundDrawBorder(bool Value);
	void __fastcall SetShadowFollowsColor(bool Value);
	void __fastcall SetShadowsUseCustom(bool Value);
	void __fastcall SetShadowBtnHighlight(System::Uitypes::TColor Value);
	void __fastcall SetShadowBtnShadow(System::Uitypes::TColor Value);
	void __fastcall SetShadowBtnDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetAdjustSpaceForGlyph(bool Value);
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	void __fastcall DoLinkPopup(const System::Types::TPoint &MousePos);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	virtual void __fastcall SetUseArrow(bool newValue);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall SetButtonStyle(bool ADefault);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetFlat(bool Value);
	virtual bool __fastcall GetChecked(void);
	virtual void __fastcall SetChecked(bool newValue);
	DYNAMIC Vcl::Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Message);
	__property bool ClicksDisabled = {read=FClicksDisabled, write=FClicksDisabled, nodefault};
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	void __fastcall SetDrawDefaultFrame(bool Value);
	virtual int __fastcall GetArrowSize(void);
	bool __fastcall DoSaveShadows(void);
	void __fastcall SetImageIsAlphaBlended(bool Value);
	void __fastcall SetDrawFocusFrame(bool Value);
	HIDESBASE virtual void __fastcall SetCursor(System::Uitypes::TCursor Value);
	void __fastcall SetChangeDisabledText(bool Value);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	__property Vcl::Menus::TPopupMenu* PullDownMenu = {read=FPullDownMenu, write=SetPullDownMenu};
	__property TPopupPlace PopupPlace = {read=FPopupPlace, write=SetPopupPlace, default=0};
	__property bool DisableAutoPopup = {read=FDisableAp, write=SetDisableAp, default=0};
	__property bool Cancel = {read=FCancel, write=FCancel, default=0};
	__property bool Default = {read=FDefault, write=SetDefault, default=0};
	__property System::Uitypes::TModalResult ModalResult = {read=FModalResult, write=FModalResult, default=0};
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Lmdpngimage::TLMDPNGObject* PngGlyph = {read=GetPNGGlyph, write=SetPNGGlyph};
	__property bool UsePng = {read=GetUsePng, write=SetUsePng, default=0};
	__property Vcl::Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=-1};
	__property Vcl::Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property bool UseArrow = {read=FUseArrow, write=SetUseArrow, default=0};
	__property bool ShadowFollowsColor = {read=FShadowFollowsColor, write=SetShadowFollowsColor, default=1};
	__property bool ShowGlyph = {read=FShowGlyph, write=SetShowGlyph, default=1};
	__property bool ShowText = {read=FShowText, write=SetShowText, default=1};
	__property System::Classes::TNotifyEvent OnArrowClick = {read=FOnArrowClick, write=FOnArrowClick};
	__property Vcl::Graphics::TIcon* Icon = {read=GetIcon, write=SetIcon};
	__property bool UseIcon = {read=FUseIcon, write=SetUseIcon, default=0};
	__property bool IsSwitch = {read=FIsSwitch, write=SetIsSwitch, default=0};
	__property bool FocusOnClick = {read=FFocusOnClick, write=FFocusOnClick, default=0};
	__property Elsndmap::TElSoundName DownSound = {read=FDownSound, write=FDownSound};
	__property Elsndmap::TElSoundName UpSound = {read=FUpSound, write=FUpSound};
	__property Elsndmap::TElSoundName ClickSound = {read=FClickSound, write=FClickSound};
	__property Elsndmap::TElSoundName ArrowClickSound = {read=FArrowClickSound, write=FArrowClickSound};
	__property Elsndmap::TElSoundMap* SoundMap = {read=FSoundMap, write=SetSoundMap};
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, default=-1};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImageList, write=SetImageList};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImageList, write=SetAlphaImageList};
	__property Vcl::Imglist::TCustomImageList* DownImages = {read=FDownImages, write=SetDownImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForDownImages = {read=FAlphaDownImages, write=SetAlphaDownImages};
	__property Vcl::Imglist::TCustomImageList* HotImages = {read=FHotImages, write=SetHotImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForHotImages = {read=FAlphaHotImages, write=SetAlphaHotImages};
	__property Vcl::Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForDisabledImages = {read=FAlphaDisabledImages, write=SetAlphaDisabledImages};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, default=1};
	__property bool ShadowsUseCustom = {read=FShadowsUseCustom, write=SetShadowsUseCustom, default=0};
	__property System::Uitypes::TColor ShadowBtnHighlight = {read=FShadowBtnHighlight, write=SetShadowBtnHighlight, stored=DoSaveShadows, nodefault};
	__property System::Uitypes::TColor ShadowBtnShadow = {read=FShadowBtnShadow, write=SetShadowBtnShadow, stored=DoSaveShadows, nodefault};
	__property System::Uitypes::TColor ShadowBtnDkShadow = {read=FShadowBtnDkShadow, write=SetShadowBtnDkShadow, stored=DoSaveShadows, nodefault};
	__property bool UseImageList = {read=GetUseImageList, write=SetUseImageList, default=0};
	__property bool OldStyled = {read=FOldStyled, write=SetOldStyled, default=0};
	__property bool ThinFrame = {read=FThinFrame, write=SetThinFrame, default=0};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property Vcl::Graphics::TBitmap* DownBackground = {read=FDownBackground, write=SetDownBackground};
	__property Vcl::Graphics::TBitmap* HotBackground = {read=FHotBackground, write=SetHotBackground};
	__property bool BackgroundDrawBorder = {read=FBackgroundDrawBorder, write=SetBackgroundDrawBorder, default=0};
	__property bool AdjustSpaceForGlyph = {read=FAdjustSpaceForGlyph, write=SetAdjustSpaceForGlyph, default=1};
	__property bool DrawDefaultFrame = {read=FDrawDefaultFrame, write=SetDrawDefaultFrame, default=1};
	__property bool DrawFocusFrame = {read=FDrawFocusFrame, write=SetDrawFocusFrame, default=0};
	__property bool ImageIsAlphaBlended = {read=FImageIsAlphaBlended, write=SetImageIsAlphaBlended, default=0};
	__property bool ChangeDisabledText = {read=FChangeDisabledText, write=SetChangeDisabledText, default=1};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=0};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=FLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, default=0};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property Lmdglyphs::TLMDGlyphListMaskUsage GlyphMaskUsage = {read=FGlyphMaskUsage, write=SetGlyphMaskUsage, default=2};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	
public:
	__fastcall virtual TCustomElPopupButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElPopupButton(void);
	virtual void __fastcall AClick(bool Arrow);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall ButtonClick(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	__property bool MouseInArrow = {read=FMouseInArrow, nodefault};
	__property bool ResizableButtonImage = {read=GetResizableButtonImage, write=SetResizableButtonImage, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElPopupButton(HWND ParentWindow) : Elbtnctl::TElButtonControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElPopupButton : public TCustomElPopupButton
{
	typedef TCustomElPopupButton inherited;
	
protected:
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadImageIsAlphaBlended(System::Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TWMMouseActivate &Message);
	
public:
	__fastcall virtual TElPopupButton(System::Classes::TComponent* AOwner);
	
__published:
	__property UsePng = {default=0};
	__property PngGlyph;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property Alignment = {default=2};
	__property Background;
	__property BackgroundDrawBorder = {default=0};
	__property DownBackground;
	__property HotBackground;
	__property ImageIndex = {default=-1};
	__property UseImageList = {default=0};
	__property Images;
	__property AlphaForImages;
	__property AlphaForHotImages;
	__property AlphaForDisabledImages;
	__property AlphaForDownImages;
	__property HotImages;
	__property DisabledImages;
	__property DrawDefaultFrame = {default=1};
	__property DrawFocusFrame = {default=0};
	__property PullDownMenu;
	__property PopupPlace = {default=0};
	__property DisableAutoPopup = {default=0};
	__property Cancel = {default=0};
	__property Default = {default=0};
	__property ModalResult = {default=0};
	__property MoneyFlat = {default=0};
	__property MoneyFlatActiveColor;
	__property MoneyFlatInactiveColor;
	__property MoneyFlatDownColor;
	__property AdjustSpaceForGlyph = {default=1};
	__property AllowAllUp = {default=0};
	__property GroupIndex = {default=0};
	__property GlyphMaskUsage = {default=2};
	__property Down = {default=0};
	__property Flat = {default=0};
	__property Glyph;
	__property ImageForm;
	__property IsHTML = {default=0};
	__property LinkColor = {default=16711680};
	__property LinkPopupMenu;
	__property LinkStyle = {default=4};
	__property Layout = {default=0};
	__property Margin = {default=-1};
	__property NumGlyphs = {default=1};
	__property ShadowFollowsColor = {default=1};
	__property ShadowsUseCustom = {default=0};
	__property ShadowBtnHighlight;
	__property ShadowBtnShadow;
	__property ShadowBtnDkShadow;
	__property ShowFocus = {default=1};
	__property ShowGlyph = {default=1};
	__property ShowText = {default=1};
	__property Spacing = {default=4};
	__property UseArrow = {default=0};
	__property IsSwitch = {default=0};
	__property FocusOnClick = {default=0};
	__property OnArrowClick;
	__property Icon;
	__property UseIcon = {default=0};
	__property ThinFrame = {default=0};
	__property TextDrawType = {default=0};
	__property Transparent = {default=0};
	__property DownSound = {default=0};
	__property UpSound = {default=0};
	__property ClickSound = {default=0};
	__property ArrowClickSound = {default=0};
	__property SoundMap;
	__property DownImages;
	__property ShowBorder = {default=1};
	__property OldStyled = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Caption;
	__property Cursor = {default=0};
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property PopupMenu;
	__property Color;
	__property ParentColor = {default=1};
	__property Align = {default=0};
	__property Font;
	__property HelpContext = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnImageNeeded;
	__property OnLinkClick;
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Action;
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered = {default=0};
	__property DragKind = {default=0};
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TCustomElPopupButton.Destroy */ inline __fastcall virtual ~TElPopupButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElPopupButton(HWND ParentWindow) : TCustomElPopupButton(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElPopupButtonActionLink : public Elbtnctl::TElButtonActionLink
{
	typedef Elbtnctl::TElButtonActionLink inherited;
	
protected:
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetChecked(bool Value);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsHintLinked(void);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TElPopupButtonActionLink(System::TObject* AClient) : Elbtnctl::TElButtonActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TElPopupButtonActionLink(void) { }
	
};


class PASCALIMPLEMENTATION TCustomElGraphicButton : public Elcgcontrol::TElCustomGraphicControl
{
	typedef Elcgcontrol::TElCustomGraphicControl inherited;
	
private:
	void __fastcall SetGlyphMaskUsage(const Lmdglyphs::TLMDGlyphListMaskUsage Value);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	bool FDblClicked;
	int FCreating;
	int FNumGlyphs;
	System::Classes::TWndMethod FMenuWindowProc;
	System::Uitypes::TCursor FCursor;
	bool FShadowsUseCustom;
	System::Uitypes::TColor FShadowBtnHighlight;
	System::Uitypes::TColor FShadowBtnShadow;
	System::Uitypes::TColor FShadowBtnDkShadow;
	Vcl::Graphics::TBitmap* FBackground;
	bool FShadowFollowsColor;
	Vcl::Graphics::TBitmap* FDownBackground;
	bool FBackgroundDrawBorder;
	bool FThinFrame;
	Vcl::Imglist::TCustomImageList* FAlphaImageList;
	Vcl::Imglist::TCustomImageList* FAlphaHotImages;
	Vcl::Imglist::TCustomImageList* FAlphaDownImages;
	Vcl::Imglist::TCustomImageList* FAlphaDisabledImages;
	Vcl::Imglist::TCustomImageList* FHotImages;
	Vcl::Imglist::TCustomImageList* FDownImages;
	Vcl::Imglist::TCustomImageList* FDisabledImages;
	Vcl::Imglist::TCustomImageList* FImageList;
	Vcl::Graphics::TBitmap* FHotBackground;
	bool FOldStyled;
	bool FUseImageList;
	bool FUseIcon;
	Elsndmap::TElSoundMap* FSoundMap;
	Elsndmap::TElSoundName FDownSound;
	Elsndmap::TElSoundName FUpSound;
	Elsndmap::TElSoundName FClickSound;
	Elsndmap::TElSoundName FArrowClickSound;
	bool FIsSwitch;
	bool FShowGlyph;
	bool FShowText;
	bool FUseArrow;
	bool FMultiLine;
	int FGroupIndex;
	Lmdglyphs::TLMDButtonGlyph* FGlyph;
	bool FDown;
	bool FArrDown;
	bool FInMenu;
	bool FIgnoreClick;
	bool FDragging;
	bool FAllowAllUp;
	Vcl::Buttons::TButtonLayout FLayout;
	int FSpacing;
	int FMargin;
	bool FFlat;
	bool FMouseInArrow;
	bool FMouseInControl;
	bool FDisableAp;
	TPopupPlace FPopupPlace;
	bool FDefault;
	bool FCancel;
	System::Uitypes::TModalResult FModalResult;
	bool FClicksDisabled;
	Vcl::Imglist::TChangeLink* FAChLink;
	Vcl::Imglist::TChangeLink* FAHChLink;
	Vcl::Imglist::TChangeLink* FANChLink;
	Vcl::Imglist::TChangeLink* FADChLink;
	Vcl::Imglist::TChangeLink* FChLink;
	Vcl::Imglist::TChangeLink* FNChLink;
	Vcl::Imglist::TChangeLink* FDChLink;
	Vcl::Imglist::TChangeLink* FHChLink;
	Vcl::Menus::TPopupMenu* FPullDownMenu;
	System::Classes::TNotifyEvent FOnArrowClick;
	bool FTransparent;
	Lmdgraph::TLMDTextDrawType FTextDrawType;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Elstyleman::TElStyleMgrChangeLink* FStyleMgrLink;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	bool FShowBorder;
	bool FAdjustSpaceForGlyph;
	System::Uitypes::TColor FLinkColor;
	Vcl::Menus::TPopupMenu* FLinkPopupMenu;
	System::Uitypes::TFontStyles FLinkStyle;
	bool FIsHTML;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnLinkClick;
	HWND FWnd;
	System::Classes::TAlignment FAlignment;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	Lmdglyphs::TLMDGlyphListMaskUsage FGlyphMaskUsage;
	void __fastcall SetAlignment(System::Classes::TAlignment Value);
	void __fastcall SetIsHTML(bool Value);
	HIDESBASE bool __fastcall IsColorStored(void);
	void __fastcall SetShowBorder(bool newValue);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	virtual void __fastcall SetTransparent(bool newValue);
	void __fastcall SetTextDrawType(Lmdgraph::TLMDTextDrawType newValue);
	void __fastcall SetPullDownMenu(Vcl::Menus::TPopupMenu* newValue);
	void __fastcall SetPopupPlace(TPopupPlace Value);
	void __fastcall SetDisableAp(bool Value);
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall UpdateExclusive(void);
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* Value);
	Vcl::Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Vcl::Buttons::TNumGlyphs Value);
	Lmdpngimage::TLMDPNGObject* __fastcall GetPNGGlyph(void);
	void __fastcall SetPNGGlyph(Lmdpngimage::TLMDPNGObject* Value);
	void __fastcall SetUsePng(const bool Value);
	bool __fastcall GetUsePng(void);
	void __fastcall SetDown(bool Value);
	void __fastcall SetAllowAllUp(bool Value);
	void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetLayout(Vcl::Buttons::TButtonLayout Value);
	virtual void __fastcall SetSpacing(int Value);
	virtual void __fastcall SetMargin(int Value);
	void __fastcall UpdateTracking(void);
	void __fastcall IntMouseEnter(void);
	void __fastcall IntMouseLeave(void);
	void __fastcall IntEnabledChanged(void);
	void __fastcall IntTextChanged(void);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMButtonPressed(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMDialogKey(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMSysColorChange(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetShowGlyph(bool newValue);
	virtual void __fastcall SetShowText(bool newValue);
	Vcl::Graphics::TIcon* __fastcall GetIcon(void);
	void __fastcall SetIcon(Vcl::Graphics::TIcon* newValue);
	void __fastcall SetIsSwitch(bool newValue);
	void __fastcall SetSoundMap(Elsndmap::TElSoundMap* newValue);
	virtual void __fastcall SetImageIndex(int newValue);
	int __fastcall GetImageIndex(void);
	virtual void __fastcall SetUseIcon(bool newValue);
	virtual void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* newValue);
	virtual void __fastcall SetAlphaImageList(Vcl::Imglist::TCustomImageList* newValue);
	virtual void __fastcall SetUseImageList(bool newValue);
	bool __fastcall GetUseImageList(void);
	void __fastcall SetOldStyled(bool newValue);
	void __fastcall SetDownImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaDownImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetHotImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaHotImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetDisabledImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaDisabledImages(Vcl::Imglist::TCustomImageList* newValue);
	virtual void __fastcall ImagesChanged(System::TObject* Sender);
	void __fastcall SetThinFrame(bool newValue);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetDownBackground(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetBackgroundDrawBorder(bool Value);
	void __fastcall SetShadowFollowsColor(bool Value);
	void __fastcall SetShadowsUseCustom(bool Value);
	void __fastcall SetShadowBtnHighlight(System::Uitypes::TColor Value);
	void __fastcall SetShadowBtnShadow(System::Uitypes::TColor Value);
	void __fastcall SetShadowBtnDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetAdjustSpaceForGlyph(bool Value);
	void __fastcall SetThemeGlobalMode(const bool Value);
	void __fastcall SetUseXPThemes(const bool Value);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	bool __fastcall GetUseXPThemes(void);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall SetHotBackground(Vcl::Graphics::TBitmap* const Value);
	bool FParentThemeMode;
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	Lmdgraph::TLMDExButtonState FOrigState;
	Lmdgraph::TLMDExButtonState FState;
	Lmdtypes::TLMDString FCaption;
	Lmdtypes::TLMDString FHint;
	bool FMoneyFlat;
	System::Uitypes::TColor FMoneyFlatDownColor;
	System::Uitypes::TColor FMoneyFlatActiveColor;
	System::Uitypes::TColor FMoneyFlatInactiveColor;
	bool FShortcutsEnabled;
	bool FImageIsAlphaBlended;
	System::Types::TRect FTextRect;
	bool FChangeDisabledText;
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	virtual void __fastcall SetLinkColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetLinkStyle(System::Uitypes::TFontStyles newValue);
	void __fastcall DoLinkPopup(const System::Types::TPoint &MousePos);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Message);
	virtual void __fastcall SetUseArrow(bool newValue);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetFlat(bool Value);
	virtual bool __fastcall GetChecked(void);
	virtual void __fastcall SetChecked(bool newValue);
	DYNAMIC Vcl::Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	bool __fastcall DoSaveShadows(void);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	void __fastcall SetCaption(Lmdtypes::TLMDString Value);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetDetails(void);
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetTextDetails(void);
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetArrowDetails(void);
	virtual int __fastcall GetArrowSize(void);
	virtual void __fastcall DrawThemedBackground(Vcl::Graphics::TCanvas* Canvas);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	virtual System::Types::TPoint __fastcall MeasureButton(bool LockHeight);
	void __fastcall SetMoneyFlat(bool Value);
	void __fastcall SetMoneyFlatDownColor(System::Uitypes::TColor Value);
	void __fastcall SetMoneyFlatActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetMoneyFlatInactiveColor(System::Uitypes::TColor Value);
	bool __fastcall GetMoneyFlat(void);
	void __fastcall IntWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DoPullMenu(void);
	void __fastcall SetShortcutsEnabled(bool Value);
	virtual bool __fastcall Focused(void);
	void __fastcall SetImageIsAlphaBlended(bool Value);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE virtual void __fastcall SetCursor(System::Uitypes::TCursor Value);
	void __fastcall SetChangeDisabledText(bool Value);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	void __fastcall UpdateStyle(void);
	virtual bool __fastcall GetShowGlyph(void);
	virtual void __fastcall DoClick(void);
	void __fastcall BeginCreate(void);
	void __fastcall EndCreate(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	__property bool ClicksDisabled = {read=FClicksDisabled, write=FClicksDisabled, nodefault};
	__property Vcl::Menus::TPopupMenu* PullDownMenu = {read=FPullDownMenu, write=SetPullDownMenu};
	__property TPopupPlace PopupPlace = {read=FPopupPlace, write=SetPopupPlace, default=0};
	__property bool DisableAutoPopup = {read=FDisableAp, write=SetDisableAp, default=0};
	__property bool Cancel = {read=FCancel, write=FCancel, default=0};
	__property System::Uitypes::TModalResult ModalResult = {read=FModalResult, write=FModalResult, default=0};
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Vcl::Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=-1};
	__property Vcl::Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property Lmdpngimage::TLMDPNGObject* PngGlyph = {read=GetPNGGlyph, write=SetPNGGlyph};
	__property bool UsePng = {read=GetUsePng, write=SetUsePng, default=0};
	__property bool UseArrow = {read=FUseArrow, write=SetUseArrow, default=0};
	__property bool ShadowFollowsColor = {read=FShadowFollowsColor, write=SetShadowFollowsColor, default=1};
	__property bool ShowGlyph = {read=GetShowGlyph, write=SetShowGlyph, default=1};
	__property bool ShowText = {read=FShowText, write=SetShowText, default=1};
	__property System::Classes::TNotifyEvent OnArrowClick = {read=FOnArrowClick, write=FOnArrowClick};
	__property Vcl::Graphics::TIcon* Icon = {read=GetIcon, write=SetIcon};
	__property bool UseIcon = {read=FUseIcon, write=SetUseIcon, default=0};
	__property bool IsSwitch = {read=FIsSwitch, write=SetIsSwitch, default=0};
	__property Elsndmap::TElSoundName DownSound = {read=FDownSound, write=FDownSound};
	__property Elsndmap::TElSoundName UpSound = {read=FUpSound, write=FUpSound};
	__property Elsndmap::TElSoundName ClickSound = {read=FClickSound, write=FClickSound};
	__property Elsndmap::TElSoundName ArrowClickSound = {read=FArrowClickSound, write=FArrowClickSound};
	__property Elsndmap::TElSoundMap* SoundMap = {read=FSoundMap, write=SetSoundMap};
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, default=-1};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImageList, write=SetImageList};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImageList, write=SetAlphaImageList};
	__property Vcl::Imglist::TCustomImageList* AlphaForHotImages = {read=FAlphaHotImages, write=SetAlphaHotImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForDisabledImages = {read=FAlphaDisabledImages, write=SetAlphaDisabledImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForDownImages = {read=FAlphaDownImages, write=SetAlphaDownImages};
	__property Vcl::Imglist::TCustomImageList* HotImages = {read=FHotImages, write=SetHotImages};
	__property Vcl::Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property Vcl::Imglist::TCustomImageList* DownImages = {read=FDownImages, write=SetDownImages};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, default=1};
	__property bool ShadowsUseCustom = {read=FShadowsUseCustom, write=SetShadowsUseCustom, default=0};
	__property System::Uitypes::TColor ShadowBtnHighlight = {read=FShadowBtnHighlight, write=SetShadowBtnHighlight, stored=DoSaveShadows, default=16250869};
	__property System::Uitypes::TColor ShadowBtnShadow = {read=FShadowBtnShadow, write=SetShadowBtnShadow, stored=DoSaveShadows, default=7764576};
	__property System::Uitypes::TColor ShadowBtnDkShadow = {read=FShadowBtnDkShadow, write=SetShadowBtnDkShadow, stored=DoSaveShadows, default=5856328};
	__property bool UseImageList = {read=GetUseImageList, write=SetUseImageList, default=0};
	__property bool OldStyled = {read=FOldStyled, write=SetOldStyled, default=0};
	__property bool ThinFrame = {read=FThinFrame, write=SetThinFrame, default=0};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property Vcl::Graphics::TBitmap* DownBackground = {read=FDownBackground, write=SetDownBackground};
	__property Vcl::Graphics::TBitmap* HotBackground = {read=FHotBackground, write=SetHotBackground};
	__property bool BackgroundDrawBorder = {read=FBackgroundDrawBorder, write=SetBackgroundDrawBorder, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Lmdgraph::TLMDTextDrawType TextDrawType = {read=FTextDrawType, write=SetTextDrawType, default=0};
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property Color = {stored=IsColorStored};
	__property bool AdjustSpaceForGlyph = {read=FAdjustSpaceForGlyph, write=SetAdjustSpaceForGlyph, default=1};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property bool MoneyFlat = {read=GetMoneyFlat, write=SetMoneyFlat, default=0};
	__property System::Uitypes::TColor MoneyFlatDownColor = {read=FMoneyFlatDownColor, write=SetMoneyFlatDownColor, stored=GetMoneyFlat, nodefault};
	__property System::Uitypes::TColor MoneyFlatActiveColor = {read=FMoneyFlatActiveColor, write=SetMoneyFlatActiveColor, stored=GetMoneyFlat, nodefault};
	__property System::Uitypes::TColor MoneyFlatInactiveColor = {read=FMoneyFlatInactiveColor, write=SetMoneyFlatInactiveColor, stored=GetMoneyFlat, nodefault};
	__property bool ImageIsAlphaBlended = {read=FImageIsAlphaBlended, write=SetImageIsAlphaBlended, default=0};
	__property bool ChangeDisabledText = {read=FChangeDisabledText, write=SetChangeDisabledText, default=1};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=0};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=FLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=SetCursor, default=0};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	
public:
	__fastcall virtual TCustomElGraphicButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElGraphicButton(void);
	bool __fastcall IsThemed(void);
	virtual void __fastcall AClick(bool Arrow);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall ButtonClick(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	__property bool MouseInArrow = {read=FMouseInArrow, nodefault};
	__property System::Classes::TWndMethod MenuWindowProc = {read=FMenuWindowProc, write=FMenuWindowProc};
	__property bool ShortcutsEnabled = {read=FShortcutsEnabled, write=SetShortcutsEnabled, default=0};
	__property Lmdglyphs::TLMDGlyphListMaskUsage GlyphMaskUsage = {read=FGlyphMaskUsage, write=SetGlyphMaskUsage, default=2};
	
__published:
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
};


typedef System::TMetaClass* TCustomElGraphicButtonClass;

class PASCALIMPLEMENTATION TElGraphicButton : public TCustomElGraphicButton
{
	typedef TCustomElGraphicButton inherited;
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadImageIsAlphaBlended(System::Classes::TReader* Reader);
	
public:
	__property UseXPThemes;
	__fastcall virtual TElGraphicButton(System::Classes::TComponent* aOwner);
	
__published:
	__property GlyphMaskUsage = {default=2};
	__property UsePng = {default=0};
	__property PngGlyph;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property Alignment = {default=2};
	__property Background;
	__property BackgroundDrawBorder = {default=0};
	__property DownBackground;
	__property HotBackground;
	__property ImageIndex = {default=-1};
	__property UseImageList = {default=0};
	__property Images;
	__property HotImages;
	__property DisabledImages;
	__property AlphaForImages;
	__property AlphaForHotImages;
	__property AlphaForDisabledImages;
	__property AlphaForDownImages;
	__property PullDownMenu;
	__property PopupPlace = {default=0};
	__property DisableAutoPopup = {default=0};
	__property Cancel = {default=0};
	__property ChangeDisabledText = {default=1};
	__property ModalResult = {default=0};
	__property MoneyFlat = {default=0};
	__property MoneyFlatInactiveColor;
	__property MoneyFlatActiveColor;
	__property MoneyFlatDownColor;
	__property AdjustSpaceForGlyph = {default=1};
	__property AllowAllUp = {default=0};
	__property GroupIndex = {default=0};
	__property Down = {default=0};
	__property Flat = {default=0};
	__property Glyph;
	__property ImageForm;
	__property IsHTML = {default=0};
	__property Layout = {default=0};
	__property Margin = {default=-1};
	__property NumGlyphs = {default=1};
	__property ShadowFollowsColor = {default=1};
	__property ShadowsUseCustom = {default=0};
	__property ShadowBtnHighlight = {default=16250869};
	__property ShadowBtnShadow = {default=7764576};
	__property ShadowBtnDkShadow = {default=5856328};
	__property ShowGlyph = {default=1};
	__property ShowText = {default=1};
	__property Spacing = {default=4};
	__property UseArrow = {default=0};
	__property IsSwitch = {default=0};
	__property OnArrowClick;
	__property Icon;
	__property LinkColor = {default=16711680};
	__property LinkPopupMenu;
	__property LinkStyle = {default=4};
	__property UseIcon = {default=0};
	__property ThinFrame = {default=0};
	__property TextDrawType = {default=0};
	__property Transparent = {default=0};
	__property DownSound = {default=0};
	__property UpSound = {default=0};
	__property ClickSound = {default=0};
	__property ArrowClickSound = {default=0};
	__property SoundMap;
	__property DownImages;
	__property ShowBorder = {default=1};
	__property ShortcutsEnabled = {default=0};
	__property OldStyled = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Caption;
	__property Cursor = {default=0};
	__property Enabled = {default=1};
	__property PopupMenu;
	__property Color;
	__property ParentColor = {default=1};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnImageNeeded;
	__property OnLinkClick;
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Action;
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property DragKind = {default=0};
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TCustomElGraphicButton.Destroy */ inline __fastcall virtual ~TElGraphicButton(void) { }
	
};


class PASCALIMPLEMENTATION TElGraphicButtonActionLink : public Vcl::Controls::TControlActionLink
{
	typedef Vcl::Controls::TControlActionLink inherited;
	
protected:
	TCustomElGraphicButton* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual void __fastcall SetImageIndex(int Value);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
	virtual void __fastcall SetHint(const System::UnicodeString Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TElGraphicButtonActionLink(System::TObject* AClient) : Vcl::Controls::TControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TElGraphicButtonActionLink(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE unsigned MenuCancelMsg;
extern DELPHI_PACKAGE HMENU __fastcall GetMenuHandle(Vcl::Menus::TMenu* AMenu);
}	/* namespace Elpopbtn */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELPOPBTN)
using namespace Elpopbtn;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElpopbtnHPP
