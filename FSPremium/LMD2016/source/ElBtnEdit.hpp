// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElBtnEdit.pas' rev: 31.00 (Windows)

#ifndef ElbtneditHPP
#define ElbtneditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <Vcl.Menus.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <ElPopBtn.hpp>
#include <ElVCLUtils.hpp>
#include <ElImgFrm.hpp>
#include <ElSndMap.hpp>
#include <ElEdits.hpp>
#include <LMDPNGImage.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDThemes.hpp>
#include <LMDGlyphs.hpp>
#include <System.UITypes.hpp>
#include <ElXPThemedControl.hpp>
#include <ElInputProcessor.hpp>
#include <LMDGraph.hpp>
#include <ElSBCtrl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elbtnedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAltButtonPropHelper;
class DELPHICLASS TCustomElButtonEdit;
class DELPHICLASS TElButtonEdit;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TAltButtonPropHelper : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	Lmdglyphs::TLMDButtonGlyph* FAltButtonGlyph;
	Lmdpngimage::TLMDPNGObject* FAltButtonPngGlyph;
	bool FAltButtonUsePng;
	bool FAltButtonEnabled;
	Vcl::Controls::TCaption FAltButtonCaption;
	Elsndmap::TElSoundName FAltButtonClickSound;
	Elsndmap::TElSoundName FAltButtonDownSound;
	Elsndmap::TElSoundMap* FAltButtonSoundMap;
	Elsndmap::TElSoundName FAltButtonUpSound;
	System::Uitypes::TColor FAltButtonColor;
	bool FAltButtonFlat;
	Lmdtypes::TLMDString FAltButtonHint;
	int FAltButtonNumGlyphs;
	Elpopbtn::TPopupPlace FAltButtonPopupPlace;
	Vcl::Menus::TPopupMenu* FAltButtonPullDownMenu;
	bool FAltButtonUseIcon;
	int FAltButtonWidth;
	bool FAltButtonIsSwitch;
	bool FAltButtonThinFrame;
	bool FAltButtonTransparent;
	bool FAltButtonShowBorder;
	bool FAltButtonOldStyled;
	
public:
	__fastcall virtual TAltButtonPropHelper(void);
	__fastcall virtual ~TAltButtonPropHelper(void);
	void __fastcall TuneButton(Elpopbtn::TCustomElGraphicButton* ABtn);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCustomElButtonEdit : public Eledits::TCustomElEdit
{
	typedef Eledits::TCustomElEdit inherited;
	
private:
	System::Classes::TNotifyEvent FOnAltButtonClick;
	System::Classes::TShortCut FButtonShortcut;
	System::Classes::TShortCut FAltButtonShortcut;
	System::Classes::TNotifyEvent FOnButtonClick;
	bool FButtonEnabled;
	TAltButtonPropHelper* FAltButtonPropHelper;
	void __fastcall MakeAltButton(void);
	void __fastcall SetButtonClickSound(Elsndmap::TElSoundName newValue);
	Elsndmap::TElSoundName __fastcall GetButtonClickSound(void);
	void __fastcall SetButtonDownSound(Elsndmap::TElSoundName newValue);
	Elsndmap::TElSoundName __fastcall GetButtonDownSound(void);
	void __fastcall SetButtonSoundMap(Elsndmap::TElSoundMap* newValue);
	Elsndmap::TElSoundMap* __fastcall GetButtonSoundMap(void);
	void __fastcall SetButtonUpSound(Elsndmap::TElSoundName newValue);
	Elsndmap::TElSoundName __fastcall GetButtonUpSound(void);
	void __fastcall SetAltButtonClickSound(Elsndmap::TElSoundName newValue);
	Elsndmap::TElSoundName __fastcall GetAltButtonClickSound(void);
	void __fastcall SetAltButtonUpSound(Elsndmap::TElSoundName newValue);
	Elsndmap::TElSoundName __fastcall GetAltButtonUpSound(void);
	void __fastcall SetAltButtonSoundMap(Elsndmap::TElSoundMap* newValue);
	Elsndmap::TElSoundMap* __fastcall GetAltButtonSoundMap(void);
	void __fastcall SetButtonColor(System::Uitypes::TColor newValue);
	System::Uitypes::TColor __fastcall GetButtonColor(void);
	void __fastcall SetButtonDown(bool newValue);
	bool __fastcall GetButtonDown(void);
	Vcl::Graphics::TBitmap* __fastcall GetButtonGlyph(void);
	void __fastcall SetButtonHint(Lmdtypes::TLMDString newValue);
	Lmdtypes::TLMDString __fastcall GetButtonHint(void);
	void __fastcall SetButtonIcon(Vcl::Graphics::TIcon* newValue);
	Vcl::Graphics::TIcon* __fastcall GetButtonIcon(void);
	void __fastcall SetButtonNumGlyphs(int newValue);
	int __fastcall GetButtonNumGlyphs(void);
	void __fastcall SetButtonUseIcon(bool newValue);
	bool __fastcall GetButtonUseIcon(void);
	void __fastcall SetButtonWidth(int newValue);
	int __fastcall GetButtonWidth(void);
	void __fastcall ButtonClickTransfer(System::TObject* Sender);
	void __fastcall SetButtonVisible(bool newValue);
	bool __fastcall GetButtonVisible(void);
	void __fastcall SetAltButtonDown(bool newValue);
	bool __fastcall GetAltButtonDown(void);
	void __fastcall SetAltButtonDownSound(Elsndmap::TElSoundName newValue);
	Elsndmap::TElSoundName __fastcall GetAltButtonDownSound(void);
	void __fastcall SetAltButtonFlat(bool newValue);
	bool __fastcall GetAltButtonFlat(void);
	void __fastcall SetAltButtonGlyph(Vcl::Graphics::TBitmap* newValue);
	Vcl::Graphics::TBitmap* __fastcall GetAltButtonGlyph(void);
	void __fastcall SetAltButtonIcon(Vcl::Graphics::TIcon* newValue);
	Vcl::Graphics::TIcon* __fastcall GetAltButtonIcon(void);
	void __fastcall SetAltButtonNumGlyphs(int newValue);
	int __fastcall GetAltButtonNumGlyphs(void);
	void __fastcall SetAltButtonUseIcon(bool newValue);
	bool __fastcall GetAltButtonUseIcon(void);
	void __fastcall SetAltButtonVisible(bool newValue);
	bool __fastcall GetAltButtonVisible(void);
	void __fastcall SetAltButtonWidth(int newValue);
	int __fastcall GetAltButtonWidth(void);
	void __fastcall AltButtonClickTransfer(System::TObject* Sender);
	void __fastcall SetButtonFlat(bool newValue);
	bool __fastcall GetButtonFlat(void);
	void __fastcall SetAltButtonEnabled(bool newValue);
	bool __fastcall GetAltButtonEnabled(void);
	void __fastcall SetButtonEnabled(bool newValue);
	bool __fastcall GetButtonEnabled(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	void __fastcall SetAltButtonHint(Lmdtypes::TLMDString newValue);
	Lmdtypes::TLMDString __fastcall GetAltButtonHint(void);
	void __fastcall SetAltButtonPopupPlace(Elpopbtn::TPopupPlace newValue);
	Elpopbtn::TPopupPlace __fastcall GetAltButtonPopupPlace(void);
	void __fastcall SetAltButtonPullDownMenu(Vcl::Menus::TPopupMenu* newValue);
	Vcl::Menus::TPopupMenu* __fastcall GetAltButtonPullDownMenu(void);
	void __fastcall SetButtonPopupPlace(Elpopbtn::TPopupPlace newValue);
	Elpopbtn::TPopupPlace __fastcall GetButtonPopupPlace(void);
	void __fastcall SetButtonPullDownMenu(Vcl::Menus::TPopupMenu* newValue);
	Vcl::Menus::TPopupMenu* __fastcall GetButtonPullDownMenu(void);
	void __fastcall SetAltButtonCaption(Vcl::Controls::TCaption newValue);
	Vcl::Controls::TCaption __fastcall GetAltButtonCaption(void);
	void __fastcall SetButtonCaption(Vcl::Controls::TCaption newValue);
	Vcl::Controls::TCaption __fastcall GetButtonCaption(void);
	void __fastcall SetAltBtnAlign(System::Classes::TLeftRight newValue);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	void __fastcall OnDropDownButtonChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	Lmdpngimage::TLMDPNGObject* __fastcall GetAltButtonPngGlyph(void);
	bool __fastcall GetAltButtonUsePng(void);
	Lmdpngimage::TLMDPNGObject* __fastcall GetButtonPngGlyph(void);
	bool __fastcall GetButtonUsePng(void);
	void __fastcall SetAltButtonPngGlyph(Lmdpngimage::TLMDPNGObject* const Value);
	void __fastcall SetAltButtonUsePng(const bool Value);
	void __fastcall SetButtonPngGlyph(Lmdpngimage::TLMDPNGObject* const Value);
	void __fastcall SetButtonUsePng(const bool Value);
	
protected:
	Elpopbtn::TCustomElGraphicButton* FAltButton;
	Elpopbtn::TCustomElGraphicButton* FButton;
	System::Classes::TAlignment FAltBtnAlign;
	Elpopbtn::TCustomElGraphicButtonClass ButtonClass;
	Elpopbtn::TCustomElGraphicButtonClass AltButtonClass;
	bool FButtonIsSwitch;
	int FButtonWidth;
	virtual void __fastcall DoMouseEnter(void);
	virtual void __fastcall DoMouseLeave(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D)/* overload */;
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall SetEditRect(const System::Types::TRect &Value);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	System::Uitypes::TColor __fastcall GetAltButtonColor(void);
	void __fastcall SetAltButtonColor(System::Uitypes::TColor Value);
	bool __fastcall GetButtonThinFrame(void);
	void __fastcall SetButtonThinFrame(bool Value);
	bool __fastcall GetAltButtonThinFrame(void);
	void __fastcall SetAltButtonThinFrame(bool Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall UpdateButtonStyles(void);
	virtual void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	virtual void __fastcall SetFlat(const bool Value);
	virtual void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	virtual void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	virtual Elpopbtn::TCustomElGraphicButtonClass __fastcall GetButtonClass(void);
	virtual Elpopbtn::TCustomElGraphicButtonClass __fastcall GetAltButtonClass(void);
	bool __fastcall GetButtonTransparent(void);
	void __fastcall SetButtonTransparent(bool Value);
	bool __fastcall GetAltButtonTransparent(void);
	void __fastcall SetAltButtonTransparent(bool Value);
	bool __fastcall GetButtonIsSwitch(void);
	void __fastcall SetButtonIsSwitch(bool Value);
	bool __fastcall GetAltButtonIsSwitch(void);
	void __fastcall SetAltButtonIsSwitch(bool Value);
	virtual void __fastcall SetButtonGlyph(Vcl::Graphics::TBitmap* newValue);
	bool __fastcall GetButtonShowBorder(void);
	void __fastcall SetButtonShowBorder(bool Value);
	bool __fastcall GetAltButtonShowBorder(void);
	void __fastcall SetAltButtonShowBorder(bool Value);
	bool __fastcall GetButtonOldStyled(void);
	void __fastcall SetButtonOldStyled(bool Value);
	bool __fastcall GetAltButtonOldStyled(void);
	void __fastcall SetAltButtonOldStyled(bool Value);
	__property Vcl::Controls::TCaption ButtonCaption = {read=GetButtonCaption, write=SetButtonCaption};
	__property Elsndmap::TElSoundName ButtonClickSound = {read=GetButtonClickSound, write=SetButtonClickSound};
	__property Elsndmap::TElSoundName ButtonDownSound = {read=GetButtonDownSound, write=SetButtonDownSound};
	__property System::Uitypes::TColor ButtonColor = {read=GetButtonColor, write=SetButtonColor, default=-16777201};
	__property bool ButtonDown = {read=GetButtonDown, write=SetButtonDown, default=0};
	__property bool ButtonFlat = {read=GetButtonFlat, write=SetButtonFlat, default=0};
	__property Vcl::Graphics::TBitmap* ButtonGlyph = {read=GetButtonGlyph, write=SetButtonGlyph};
	__property Lmdtypes::TLMDString ButtonHint = {read=GetButtonHint, write=SetButtonHint};
	__property Vcl::Graphics::TIcon* ButtonIcon = {read=GetButtonIcon, write=SetButtonIcon};
	__property int ButtonNumGlyphs = {read=GetButtonNumGlyphs, write=SetButtonNumGlyphs, default=1};
	__property Lmdpngimage::TLMDPNGObject* ButtonPngGlyph = {read=GetButtonPngGlyph, write=SetButtonPngGlyph};
	__property bool ButtonUsePng = {read=GetButtonUsePng, write=SetButtonUsePng, nodefault};
	__property Elpopbtn::TPopupPlace ButtonPopupPlace = {read=GetButtonPopupPlace, write=SetButtonPopupPlace, default=0};
	__property Vcl::Menus::TPopupMenu* ButtonPullDownMenu = {read=GetButtonPullDownMenu, write=SetButtonPullDownMenu};
	__property Elsndmap::TElSoundMap* ButtonSoundMap = {read=GetButtonSoundMap, write=SetButtonSoundMap};
	__property Elsndmap::TElSoundName ButtonUpSound = {read=GetButtonUpSound, write=SetButtonUpSound};
	__property bool ButtonUseIcon = {read=GetButtonUseIcon, write=SetButtonUseIcon, default=0};
	__property int ButtonWidth = {read=GetButtonWidth, write=SetButtonWidth, default=-1};
	__property bool ButtonEnabled = {read=GetButtonEnabled, write=SetButtonEnabled, default=1};
	__property bool ButtonThinFrame = {read=GetButtonThinFrame, write=SetButtonThinFrame, default=0};
	__property bool ButtonTransparent = {read=GetButtonTransparent, write=SetButtonTransparent, default=0};
	__property bool ButtonIsSwitch = {read=GetButtonIsSwitch, write=SetButtonIsSwitch, default=0};
	__property System::Classes::TNotifyEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property System::Classes::TNotifyEvent OnAltButtonClick = {read=FOnAltButtonClick, write=FOnAltButtonClick};
	__property System::Classes::TShortCut ButtonShortcut = {read=FButtonShortcut, write=FButtonShortcut, default=0};
	__property System::Classes::TShortCut AltButtonShortcut = {read=FAltButtonShortcut, write=FAltButtonShortcut, default=0};
	__property bool ButtonVisible = {read=GetButtonVisible, write=SetButtonVisible, default=1};
	__property Vcl::Controls::TCaption AltButtonCaption = {read=GetAltButtonCaption, write=SetAltButtonCaption};
	__property Elsndmap::TElSoundName AltButtonClickSound = {read=GetAltButtonClickSound, write=SetAltButtonClickSound};
	__property Elsndmap::TElSoundName AltButtonDownSound = {read=GetAltButtonDownSound, write=SetAltButtonDownSound};
	__property Elsndmap::TElSoundMap* AltButtonSoundMap = {read=GetAltButtonSoundMap, write=SetAltButtonSoundMap};
	__property Elsndmap::TElSoundName AltButtonUpSound = {read=GetAltButtonUpSound, write=SetAltButtonUpSound};
	__property System::Uitypes::TColor AltButtonColor = {read=GetAltButtonColor, write=SetAltButtonColor, default=-16777201};
	__property bool AltButtonDown = {read=GetAltButtonDown, write=SetAltButtonDown, default=0};
	__property bool AltButtonFlat = {read=GetAltButtonFlat, write=SetAltButtonFlat, default=0};
	__property Vcl::Graphics::TBitmap* AltButtonGlyph = {read=GetAltButtonGlyph, write=SetAltButtonGlyph};
	__property Lmdtypes::TLMDString AltButtonHint = {read=GetAltButtonHint, write=SetAltButtonHint};
	__property Lmdpngimage::TLMDPNGObject* AltButtonPngGlyph = {read=GetAltButtonPngGlyph, write=SetAltButtonPngGlyph};
	__property bool AltButtonUsePng = {read=GetAltButtonUsePng, write=SetAltButtonUsePng, nodefault};
	__property Vcl::Graphics::TIcon* AltButtonIcon = {read=GetAltButtonIcon, write=SetAltButtonIcon};
	__property int AltButtonNumGlyphs = {read=GetAltButtonNumGlyphs, write=SetAltButtonNumGlyphs, default=1};
	__property Elpopbtn::TPopupPlace AltButtonPopupPlace = {read=GetAltButtonPopupPlace, write=SetAltButtonPopupPlace, default=0};
	__property System::Classes::TLeftRight AltButtonPosition = {read=FAltBtnAlign, write=SetAltBtnAlign, default=1};
	__property Vcl::Menus::TPopupMenu* AltButtonPullDownMenu = {read=GetAltButtonPullDownMenu, write=SetAltButtonPullDownMenu};
	__property bool AltButtonUseIcon = {read=GetAltButtonUseIcon, write=SetAltButtonUseIcon, default=0};
	__property bool AltButtonVisible = {read=GetAltButtonVisible, write=SetAltButtonVisible, default=0};
	__property int AltButtonWidth = {read=GetAltButtonWidth, write=SetAltButtonWidth, default=-1};
	__property bool AltButtonEnabled = {read=GetAltButtonEnabled, write=SetAltButtonEnabled, default=1};
	__property bool AltButtonIsSwitch = {read=GetAltButtonIsSwitch, write=SetAltButtonIsSwitch, default=0};
	__property bool AltButtonThinFrame = {read=GetAltButtonThinFrame, write=SetAltButtonThinFrame, default=0};
	__property bool AltButtonTransparent = {read=GetAltButtonTransparent, write=SetAltButtonTransparent, default=0};
	__property bool ButtonShowBorder = {read=GetButtonShowBorder, write=SetButtonShowBorder, default=1};
	__property bool AltButtonShowBorder = {read=GetAltButtonShowBorder, write=SetAltButtonShowBorder, default=1};
	__property bool ButtonOldStyled = {read=GetButtonOldStyled, write=SetButtonOldStyled, default=0};
	__property bool AltButtonOldStyled = {read=GetAltButtonOldStyled, write=SetAltButtonOldStyled, default=0};
	
public:
	__fastcall virtual TCustomElButtonEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElButtonEdit(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElButtonEdit(HWND ParentWindow) : Eledits::TCustomElEdit(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	DYNAMIC inline void __fastcall  ChangeScale(int M, int D, bool isDpiChange){ Vcl::Controls::TWinControl::ChangeScale(M, D, isDpiChange); }
	
};


class PASCALIMPLEMENTATION TElButtonEdit : public TCustomElButtonEdit
{
	typedef TCustomElButtonEdit inherited;
	
__published:
	__property AlignBottom = {default=1};
	__property CharCase = {default=0};
	__property TopMargin = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property AutoSize = {default=1};
	__property RightAlignedView = {default=0};
	__property BorderSides = {default=15};
	__property PasswordChar = {default=0};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property FlatFocusedScrollBars = {default=0};
	__property WantTabs = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property Cursor = {default=-4};
	__property TabSpaces = {default=4};
	__property Lines = {stored=false};
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property ImageForm;
	__property WordWrap = {default=0};
	__property ScrollBars = {default=0};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property Text;
	__property Multiline = {default=0};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property Flat = {default=0};
	__property ActiveBorderType = {default=1};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property UseBackground = {default=0};
	__property UseSystemMenu = {default=1};
	__property Alignment = {default=0};
	__property AutoSelect = {default=0};
	__property Background;
	__property ButtonCaption = {default=0};
	__property ButtonClickSound = {default=0};
	__property ButtonDownSound = {default=0};
	__property ButtonUpSound = {default=0};
	__property ButtonSoundMap;
	__property ButtonColor = {default=-16777201};
	__property ButtonDown = {default=0};
	__property ButtonEnabled = {default=1};
	__property ButtonFlat = {default=0};
	__property ButtonGlyph;
	__property ButtonHint = {default=0};
	__property ButtonIcon;
	__property ButtonIsSwitch = {default=0};
	__property ButtonNumGlyphs = {default=1};
	__property ButtonOldStyled = {default=0};
	__property ButtonPopupPlace = {default=0};
	__property ButtonPngGlyph;
	__property ButtonUsePng;
	__property ButtonPullDownMenu;
	__property ButtonShowBorder = {default=1};
	__property ButtonShortcut = {default=0};
	__property ButtonTransparent = {default=0};
	__property ButtonThinFrame = {default=0};
	__property ButtonUseIcon = {default=0};
	__property ButtonVisible = {default=1};
	__property ButtonWidth = {default=-1};
	__property OnButtonClick;
	__property AltButtonCaption = {default=0};
	__property AltButtonClickSound = {default=0};
	__property AltButtonDownSound = {default=0};
	__property AltButtonUpSound = {default=0};
	__property AltButtonSoundMap;
	__property AltButtonColor = {default=-16777201};
	__property AltButtonDown = {default=0};
	__property AltButtonEnabled = {default=1};
	__property AltButtonFlat = {default=0};
	__property AltButtonGlyph;
	__property AltButtonHint = {default=0};
	__property AltButtonIsSwitch = {default=0};
	__property AltButtonIcon;
	__property AltButtonNumGlyphs = {default=1};
	__property AltButtonOldStyled = {default=0};
	__property AltButtonPopupPlace = {default=0};
	__property AltButtonPosition = {default=1};
	__property AltButtonPullDownMenu;
	__property AltButtonShortcut = {default=0};
	__property AltButtonThinFrame = {default=0};
	__property AltButtonTransparent = {default=0};
	__property AltButtonUseIcon = {default=0};
	__property AltButtonShowBorder = {default=1};
	__property AltButtonVisible = {default=0};
	__property AltButtonWidth = {default=-1};
	__property AltButtonPngGlyph;
	__property AltButtonUsePng;
	__property OnAltButtonClick;
	__property BorderStyle = {default=1};
	__property Ctl3D = {default=1};
	__property ParentCtl3D = {default=0};
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property PopupMenu;
	__property Color = {default=-16777211};
	__property ParentColor = {default=0};
	__property Align = {default=0};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property ReadOnly = {default=0};
	__property OnEnter;
	__property OnExit;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyPressEx;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnContextPopup;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation = {default=0};
	__property Floating;
	__property DoubleBuffered = {default=0};
	__property DragKind = {default=0};
public:
	/* TCustomElButtonEdit.Create */ inline __fastcall virtual TElButtonEdit(System::Classes::TComponent* AOwner) : TCustomElButtonEdit(AOwner) { }
	/* TCustomElButtonEdit.Destroy */ inline __fastcall virtual ~TElButtonEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElButtonEdit(HWND ParentWindow) : TCustomElButtonEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elbtnedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELBTNEDIT)
using namespace Elbtnedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElbtneditHPP
