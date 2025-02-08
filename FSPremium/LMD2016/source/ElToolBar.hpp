// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElToolBar.pas' rev: 31.00 (Windows)

#ifndef EltoolbarHPP
#define EltoolbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Variants.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <System.Math.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <System.Types.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ToolWin.hpp>
#include <LMDProcs.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDElConst.hpp>
#include <LMDThemes.hpp>
#include <Vcl.Themes.hpp>
#include <LMDClass.hpp>
#include <LMDObjectList.hpp>
#include <LMDSysIn.hpp>
#include <LMDGraph.hpp>
#include <LMDGlyphs.hpp>
#include <LMDPNGImageList.hpp>
#include <LMDTypes.hpp>
#include <LMDPNGImage.hpp>
#include <ElImgFrm.hpp>
#include <ElIni.hpp>
#include <ElStrToken.hpp>
#include <ElXPThemedControl.hpp>
#include <ElPanel.hpp>
#include <ElStyleMan.hpp>
#include <ElSndMap.hpp>
#include <ElPopBtn.hpp>
#include <ElVCLUtils.hpp>
#include <ElMenus.hpp>
#include <System.UITypes.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Actions.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltoolbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomElToolButton;
class DELPHICLASS TElToolButton;
class DELPHICLASS TCustomElToolBar;
class DELPHICLASS TElToolBar;
class DELPHICLASS TElToolButtonActionLink;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElBarOrientation : unsigned char { eboHorz, eboVert };

enum DECLSPEC_DENUM TElToolButtonType : unsigned char { ebtButton, ebtSeparator, ebtDivider };

class PASCALIMPLEMENTATION TCustomElToolButton : public Elpopbtn::TCustomElGraphicButton
{
	typedef Elpopbtn::TCustomElGraphicButton inherited;
	
private:
	bool FIsMoreBtn;
	Lmdglyphs::TLMDButtonGlyph* FLargeGlyph;
	Lmdglyphs::TLMDButtonGlyph* FGlyph;
	TElToolButtonType FButtonType;
	bool FWrap;
	bool ActionVisibleInverted;
	bool FSettingVisible;
	bool FRealVisible;
	bool FFakeBoolProp;
	int FFakeIntProp;
	System::Classes::TNotifyEvent FFakeNotifyEvent;
	Vcl::Controls::TBevelKind FFakeBevelKind;
	int FButtonID;
	bool FOwnerSettings;
	MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	void __fastcall SetWrap(bool newValue);
	void __fastcall SetButtonType(TElToolButtonType newValue);
	void __fastcall SetLargeGlyph(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetNumLargeGlyphs(int newValue);
	HIDESBASE void __fastcall SetGlyph(Vcl::Graphics::TBitmap* newValue);
	HIDESBASE void __fastcall SetNumGlyphs(int newValue);
	HIDESBASE int __fastcall GetNumGlyphs(void);
	int __fastcall GetNumLargeGlyphs(void);
	HIDESBASE Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	Vcl::Graphics::TBitmap* __fastcall GetLargeGlyph(void);
	HIDESBASE void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall LargeGlyphChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE bool __fastcall IsColorStored(void);
	
protected:
	virtual void __fastcall SetUseArrow(bool newValue);
	void __fastcall SwitchGlyphs(bool ToLarge);
	virtual void __fastcall SetFlat(bool Value);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetDetails(void);
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetArrowDetails(void);
	virtual void __fastcall DrawThemedBackground(Vcl::Graphics::TCanvas* Canvas);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadButtonID(System::Classes::TReader* Reader);
	void __fastcall WriteButtonID(System::Classes::TWriter* Writer);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall ImagesChanged(System::TObject* Sender);
	virtual void __fastcall SetLayout(Vcl::Buttons::TButtonLayout Value);
	virtual void __fastcall SetMargin(int Value);
	virtual void __fastcall SetShowGlyph(bool newValue);
	virtual void __fastcall SetShowText(bool newValue);
	virtual void __fastcall SetSpacing(int Value);
	DYNAMIC Vcl::Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SetOwnerSettings(bool Value);
	virtual void __fastcall SetImageIndex(int newValue);
	__property Transparent = {default=0};
	__property bool Wrap = {read=FWrap, write=SetWrap, default=0};
	__property TElToolButtonType ButtonType = {read=FButtonType, write=SetButtonType, default=0};
	__property Vcl::Graphics::TBitmap* LargeGlyph = {read=GetLargeGlyph, write=SetLargeGlyph};
	__property int NumLargeGlyphs = {read=GetNumLargeGlyphs, write=SetNumLargeGlyphs, default=1};
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property int NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property bool OwnerSettings = {read=FOwnerSettings, write=SetOwnerSettings, default=1};
	__property bool Default = {read=FFakeBoolProp, write=FFakeBoolProp, stored=false, nodefault};
	__property bool ShowFocus = {read=FFakeBoolProp, write=FFakeBoolProp, stored=false, nodefault};
	__property bool TabStop = {read=FFakeBoolProp, write=FFakeBoolProp, stored=false, nodefault};
	__property int TabOrder = {read=FFakeIntProp, write=FFakeIntProp, stored=false, nodefault};
	__property System::Classes::TNotifyEvent OnEnter = {read=FFakeNotifyEvent, write=FFakeNotifyEvent, stored=false};
	__property System::Classes::TNotifyEvent OnExit = {read=FFakeNotifyEvent, write=FFakeNotifyEvent, stored=false};
	__property Color = {stored=IsColorStored};
	
public:
	__fastcall virtual TCustomElToolButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElToolButton(void);
	__property bool RealVisible = {read=FRealVisible, default=1};
	
__published:
	__property Vcl::Controls::TBevelKind BevelKind = {read=FFakeBevelKind, write=FFakeBevelKind, stored=false, nodefault};
	__property bool DoubleBuffered = {read=FFakeBoolProp, write=FFakeBoolProp, stored=false, nodefault};
};


class PASCALIMPLEMENTATION TElToolButton : public TCustomElToolButton
{
	typedef TCustomElToolButton inherited;
	
public:
	__fastcall virtual TElToolButton(System::Classes::TComponent* AOwner);
	
__published:
	__property GlyphMaskUsage = {default=2};
	__property UsePng = {default=0};
	__property PngGlyph;
	__property Wrap = {default=0};
	__property ButtonType = {default=0};
	__property LargeGlyph;
	__property NumLargeGlyphs = {default=1};
	__property Glyph;
	__property NumGlyphs = {default=1};
	__property OwnerSettings = {default=1};
	__property AdjustSpaceForGlyph = {default=1};
	__property PullDownMenu;
	__property PopupPlace = {default=0};
	__property DisableAutoPopup = {default=0};
	__property Cancel = {default=0};
	__property ModalResult = {default=0};
	__property AllowAllUp = {default=0};
	__property GroupIndex = {default=0};
	__property Down = {default=0};
	__property Flat = {default=1};
	__property Layout = {default=0};
	__property Margin = {default=-1};
	__property Spacing = {default=4};
	__property Alignment = {default=2};
	__property UseArrow = {default=0};
	__property ShadowFollowsColor = {default=1};
	__property ShowBorder = {default=1};
	__property ShowGlyph = {default=1};
	__property ShowText = {default=1};
	__property OnArrowClick;
	__property Icon;
	__property ImageIsAlphaBlended = {default=0};
	__property IsSwitch = {default=0};
	__property TextDrawType = {default=0};
	__property ThinFrame = {default=0};
	__property DownSound = {default=0};
	__property UpSound = {default=0};
	__property ClickSound = {default=0};
	__property ArrowClickSound = {default=0};
	__property SoundMap;
	__property UseIcon = {default=0};
	__property ImageIndex = {default=-1};
	__property UseImageList = {default=0};
	__property OldStyled = {default=0};
	__property Background;
	__property DownBackground;
	__property BackgroundDrawBorder = {default=0};
	__property Transparent = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Caption;
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
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnStartDrag;
	__property Action;
	__property Constraints;
	__property OnContextPopup;
public:
	/* TCustomElToolButton.Destroy */ inline __fastcall virtual ~TElToolButton(void) { }
	
};


typedef System::TMetaClass* TElToolButtonClass;

class PASCALIMPLEMENTATION TCustomElToolBar : public Elpanel::TCustomElPanel
{
	typedef Elpanel::TCustomElPanel inherited;
	
private:
	bool FRightToLeft;
	bool FFirstTimeOrdered;
	bool FNoReAlign;
	Elmenus::TDrawStyle FMoreMenuDrawStyle;
	Elmenus::TElPopupMenu* FMoreMenu;
	Lmdobjectlist::TLMDObjectList* FMoreMenuItems;
	bool FMoreMenuVisible;
	TElToolButton* FShowMoreMenuBtn;
	bool FShowMoreMenu;
	Lmdpngimagelist::TLMDPNGImageList* FMoremenuItemsImageList;
	bool FTransparentButtons;
	bool FUseImageList;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TCustomImageList* FHotImages;
	Vcl::Imglist::TCustomImageList* FDisabledImages;
	Vcl::Imglist::TCustomImageList* FDownImages;
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	Vcl::Imglist::TCustomImageList* FAlphaHotImages;
	Vcl::Imglist::TCustomImageList* FAlphaDisabledImages;
	Vcl::Imglist::TCustomImageList* FAlphaDownImages;
	int FUpdateCount;
	int FUpdatingButtons;
	bool FUseLargeGlyphs;
	bool FHidden;
	bool FHideable;
	TElBarOrientation FOrientation;
	System::Uitypes::TColor FButtonColor;
	int FMinSize;
	bool FAutoSize;
	bool FFlat;
	int FLargeBtnWidth;
	int FLargeBtnHeight;
	Vcl::Buttons::TButtonLayout FGlyphLayout;
	int FSpacing;
	int FMargin;
	bool FShowGlyph;
	bool FShowCaption;
	bool FLargeSize;
	int FBtnWidth;
	int FBtnHeight;
	int FBtnOffsHorz;
	int FBtnOffsVert;
	bool FAutoWrap;
	bool FCreating;
	Vcl::Controls::TAlign FSaveAlign;
	bool FSortByTag;
	Vcl::Controls::TDragDockObject* FDragObject;
	bool FOwnResizable;
	System::UnicodeString FDummy;
	Elimgfrm::TElImageForm* FButtonImageForm;
	bool FMouseInControl;
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCLButtonDown(Winapi::Messages::TWMNCHitMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	
protected:
	bool FThinButtons;
	Elini::TElIniFile* FStorage;
	System::UnicodeString FStoragePath;
	bool FAdjustButtonWidth;
	bool FAdjustButtonHeight;
	Lmdobjectlist::TLMDObjectList* FButtons;
	TElToolButton* FFocusedButton;
	bool FTransparent;
	bool FImageIsAlphaBlended;
	bool FShowBorder;
	void __fastcall SetMoreMenuDrawStyle(Elmenus::TDrawStyle Value);
	virtual void __fastcall SetRightToLeft(bool Value);
	DYNAMIC void __fastcall ChangeScale(int M, int D)/* overload */;
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	void __fastcall StartMoreMenu(void);
	void __fastcall PutMoreItemsToBar(void);
	void __fastcall OnMoreItemClick(System::TObject* Sender);
	virtual void __fastcall SetButtonImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall SetSortByTag(bool newValue);
	virtual void __fastcall SetBtnWidth(int newValue);
	virtual void __fastcall SetBtnHeight(int newValue);
	virtual void __fastcall SetFlat(bool newValue);
	virtual void __fastcall SetLargeSize(bool newValue);
	virtual void __fastcall SetLargeBtnWidth(int newValue);
	virtual void __fastcall SetLargeBtnHeight(int newValue);
	virtual void __fastcall SetButtonColor(System::Uitypes::TColor newValue);
	virtual void __fastcall SetAutoSize(bool newValue);
	virtual void __fastcall SetResizable(bool newValue);
	virtual void __fastcall SetTransparentButtons(bool newValue);
	virtual void __fastcall SetBtnOffsHorz(int newValue);
	virtual void __fastcall SetBtnOffsVert(int newValue);
	void __fastcall SetAutoWrap(bool newValue);
	void __fastcall SetShowGlyph(bool newValue);
	HIDESBASE void __fastcall SetShowCaption(bool newValue);
	virtual void __fastcall SetGlyphLayout(Vcl::Buttons::TButtonLayout newValue);
	virtual void __fastcall SetSpacing(int newValue);
	virtual void __fastcall SetMargin(int newValue);
	TElToolButton* __fastcall GetToolButton(int index);
	TCustomElToolButton* __fastcall GetCustomToolButton(int index);
	void __fastcall SetToolButton(int index, TElToolButton* newValue);
	int __fastcall GetButtonCount(void);
	HIDESBASE MESSAGE void __fastcall CMControlListChange(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall CMControlChange(Vcl::Controls::TCMControlChange &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	void __fastcall SetMinSize(int newValue);
	virtual void __fastcall SetOrientation(TElBarOrientation newValue);
	void __fastcall SetUseLargeGlyphs(bool newValue);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetHotImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetDisabledImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaHotImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaDisabledImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetUseImageList(bool newValue);
	virtual void __fastcall SetShowMoreMenu(bool newValue);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	void __fastcall RedrawMoreBtn(void);
	int __fastcall GetRealClientWidth(void);
	int __fastcall GetRealClientHeight(void);
	System::Types::TRect __fastcall GetMoreBtnRect(void);
	void __fastcall SetThinButtons(bool Value);
	int __fastcall GetFreeButtonID(void);
	TElToolButton* __fastcall GetButtonByID(int ID);
	void __fastcall SetAdjustButtonWidth(bool Value);
	int __fastcall GetEffectiveButtonWidth(TCustomElToolButton* Button, bool IncludeArrow);
	void __fastcall SetAdjustButtonHeight(bool Value);
	int __fastcall GetEffectiveButtonHeight(TCustomElToolButton* Button);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	void __fastcall StartLeaveTracking(void);
	virtual TElToolButtonClass __fastcall GetButtonClass(void);
	void __fastcall SetFocusedButton(TElToolButton* Value);
	virtual void __fastcall SetTransparent(bool newValue);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	DYNAMIC void __fastcall DoEnter(void);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	void __fastcall SetImageIsAlphaBlended(bool Value);
	void __fastcall SetShowBorder(bool Value);
	void __fastcall SetDownImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaDownImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall UpdateButton(TCustomElToolButton* Button);
	DYNAMIC void __fastcall DoStartDock(Vcl::Controls::TDragObject* &DragObject);
	DYNAMIC void __fastcall DoEndDock(System::TObject* Target, int X, int Y);
	__property TElToolButton* FocusedButton = {read=FFocusedButton, write=SetFocusedButton};
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadImageIsAlphaBlended(System::Classes::TReader* Reader);
	virtual void __fastcall MouseOut(void);
	__property int BtnWidth = {read=FBtnWidth, write=SetBtnWidth, default=24};
	__property int BtnHeight = {read=FBtnHeight, write=SetBtnHeight, default=24};
	__property int BtnOffsHorz = {read=FBtnOffsHorz, write=SetBtnOffsHorz, default=3};
	__property int BtnOffsVert = {read=FBtnOffsVert, write=SetBtnOffsVert, default=3};
	__property bool AutoWrap = {read=FAutoWrap, write=SetAutoWrap, default=0};
	__property bool ShowGlyph = {read=FShowGlyph, write=SetShowGlyph, default=1};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=0};
	__property bool LargeSize = {read=FLargeSize, write=SetLargeSize, default=0};
	__property int LargeBtnWidth = {read=FLargeBtnWidth, write=SetLargeBtnWidth, default=48};
	__property int LargeBtnHeight = {read=FLargeBtnHeight, write=SetLargeBtnHeight, default=48};
	__property Vcl::Buttons::TButtonLayout GlyphLayout = {read=FGlyphLayout, write=SetGlyphLayout, default=0};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property int Margin = {read=FMargin, write=SetMargin, default=-1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property int MinSize = {read=FMinSize, write=SetMinSize, default=24};
	__property System::Uitypes::TColor ButtonColor = {read=FButtonColor, write=SetButtonColor, default=-16777201};
	__property Elimgfrm::TElImageForm* ButtonImageForm = {read=FButtonImageForm, write=SetButtonImageForm};
	__property TElBarOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property bool UseLargeGlyphs = {read=FUseLargeGlyphs, write=SetUseLargeGlyphs, default=0};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* HotImages = {read=FHotImages, write=SetHotImages};
	__property Vcl::Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property Vcl::Imglist::TCustomImageList* DownImages = {read=FDownImages, write=SetDownImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImages, write=SetAlphaImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForHotImages = {read=FAlphaHotImages, write=SetAlphaHotImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForDisabledImages = {read=FAlphaDisabledImages, write=SetAlphaDisabledImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForDownImages = {read=FAlphaDownImages, write=SetAlphaDownImages};
	__property bool UseImageList = {read=FUseImageList, write=SetUseImageList, default=0};
	__property bool TransparentButtons = {read=FTransparentButtons, write=SetTransparentButtons, default=0};
	__property bool ThinButtons = {read=FThinButtons, write=SetThinButtons, default=0};
	__property Elini::TElIniFile* Storage = {read=FStorage, write=FStorage};
	__property System::UnicodeString StoragePath = {read=FStoragePath, write=FStoragePath};
	__property bool AdjustButtonWidth = {read=FAdjustButtonWidth, write=SetAdjustButtonWidth, default=1};
	__property bool AdjustButtonHeight = {read=FAdjustButtonHeight, write=SetAdjustButtonHeight, default=1};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, default=1};
	__property bool ShowMoreMenu = {read=FShowMoreMenu, write=SetShowMoreMenu, default=0};
	__property Elmenus::TDrawStyle MoreMenuDrawStyle = {read=FMoreMenuDrawStyle, write=SetMoreMenuDrawStyle, default=0};
	
public:
	__fastcall virtual TCustomElToolBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElToolBar(void);
	virtual TElToolButton* __fastcall AddButton(TElToolButtonType ButtonType);
	void __fastcall OrderedControls(Lmdobjectlist::TLMDObjectList* L);
	virtual void __fastcall AlignButtons(void);
	virtual void __fastcall UpdateButtons(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall Save(void);
	void __fastcall Restore(void);
	TCustomElToolButton* __fastcall GetNextButton(TCustomElToolButton* CurrentButton, bool Forward, bool IncludeDisabled);
	__property bool SortByTag = {read=FSortByTag, write=SetSortByTag, nodefault};
	__property TElToolButton* ToolButton[int index] = {read=GetToolButton, write=SetToolButton};
	__property TCustomElToolButton* CustomToolButton[int index] = {read=GetCustomToolButton};
	__property int ButtonCount = {read=GetButtonCount, nodefault};
	__property bool RightToLeft = {read=FRightToLeft, write=SetRightToLeft, default=0};
	__property System::UnicodeString Caption = {read=FDummy, write=FDummy};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElToolBar(HWND ParentWindow) : Elpanel::TCustomElPanel(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	DYNAMIC inline void __fastcall  ChangeScale(int M, int D, bool isDpiChange){ Vcl::Controls::TWinControl::ChangeScale(M, D, isDpiChange); }
	
};


class PASCALIMPLEMENTATION TElToolBar : public TCustomElToolBar
{
	typedef TCustomElToolBar inherited;
	
__published:
	__property WordWrap = {default=0};
	__property BorderSides = {default=15};
	__property BorderColorDkShadow = {default=-16777195};
	__property BorderColorFace = {default=-16777201};
	__property BorderColorShadow = {default=-16777200};
	__property BorderColorHighlight = {default=-16777196};
	__property BorderColorWindow = {default=-16777211};
	__property BorderType = {default=1};
	__property AlphaLevel = {default=0};
	__property AlwaysPaintBackground = {default=0};
	__property Background;
	__property BackgroundType = {default=2};
	__property GradientEndColor = {default=0};
	__property GradientStartColor = {default=0};
	__property GradientSteps = {default=16};
	__property Alignment = {default=2};
	__property Layout = {default=1};
	__property OwnerDraw = {default=0};
	__property ImageForm;
	__property TopGrabHandle;
	__property RightGrabHandle;
	__property LeftGrabHandle;
	__property BottomGrabHandle;
	__property Resizable = {default=0};
	__property Movable = {default=0};
	__property OnMove;
	__property OnPaint;
	__property SizeGrip = {default=0};
	__property Align;
	__property AutoSize = {default=1};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelSpaceColor = {default=-16777201};
	__property BevelWidth = {default=1};
	__property BorderStyle = {default=0};
	__property BorderWidth = {default=0};
	__property TransparentXPThemes = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
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
	__property PopupMenu;
	__property ShowFocus = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Transparent = {default=0};
	__property Visible = {default=1};
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
	__property OnDockOver;
	__property OnDockDrop;
	__property OnUnDock;
	__property OnEndDock;
	__property DockSite = {default=0};
	__property OnResize;
	__property OnContextPopup;
	__property RightToLeft = {default=0};
	__property BtnWidth = {default=24};
	__property BtnHeight = {default=24};
	__property BtnOffsHorz = {default=3};
	__property BtnOffsVert = {default=3};
	__property AutoWrap = {default=0};
	__property ShowGlyph = {default=1};
	__property ShowCaption = {default=0};
	__property LargeSize = {default=0};
	__property LargeBtnWidth = {default=48};
	__property LargeBtnHeight = {default=48};
	__property GlyphLayout = {default=0};
	__property Spacing = {default=4};
	__property Margin = {default=-1};
	__property Flat = {default=1};
	__property MinSize = {default=24};
	__property ButtonColor = {default=-16777201};
	__property ButtonImageForm;
	__property Orientation = {default=0};
	__property UseLargeGlyphs = {default=0};
	__property Images;
	__property HotImages;
	__property DisabledImages;
	__property DownImages;
	__property AlphaForImages;
	__property AlphaForHotImages;
	__property AlphaForDisabledImages;
	__property AlphaForDownImages;
	__property UseImageList = {default=0};
	__property TransparentButtons = {default=0};
	__property ThinButtons = {default=0};
	__property Storage;
	__property StoragePath = {default=0};
	__property AdjustButtonWidth = {default=1};
	__property AdjustButtonHeight = {default=1};
	__property ShowBorder = {default=1};
	__property ShowMoreMenu = {default=0};
	__property MoreMenuDrawStyle = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered;
	__property DragKind = {default=0};
public:
	/* TCustomElToolBar.Create */ inline __fastcall virtual TElToolBar(System::Classes::TComponent* AOwner) : TCustomElToolBar(AOwner) { }
	/* TCustomElToolBar.Destroy */ inline __fastcall virtual ~TElToolBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElToolBar(HWND ParentWindow) : TCustomElToolBar(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElToolButtonActionLink : public Elpopbtn::TElGraphicButtonActionLink
{
	typedef Elpopbtn::TElGraphicButtonActionLink inherited;
	
protected:
	virtual bool __fastcall IsVisibleLinked(void);
	virtual void __fastcall SetVisible(bool Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TElToolButtonActionLink(System::TObject* AClient) : Elpopbtn::TElGraphicButtonActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TElToolButtonActionLink(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int DEF_SepSize;
}	/* namespace Eltoolbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTOOLBAR)
using namespace Eltoolbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltoolbarHPP
