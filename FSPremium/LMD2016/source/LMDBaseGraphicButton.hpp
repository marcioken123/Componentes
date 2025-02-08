// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseGraphicButton.pas' rev: 31.00 (Windows)

#ifndef LmdbasegraphicbuttonHPP
#define LmdbasegraphicbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDClass.hpp>
#include <LMDGlyph.hpp>
#include <LMDGraph.hpp>
#include <LMDShadow.hpp>
#include <LMDFXCaption.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDButtonBase.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDProcs.hpp>
#include <LMDPNGImage.hpp>
#include <System.Actions.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbasegraphicbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSpeedButtonActionLink;
class DELPHICLASS TLMDBaseGraphicButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSpeedButtonActionLink : public Vcl::Controls::TControlActionLink
{
	typedef Vcl::Controls::TControlActionLink inherited;
	
protected:
	Lmdbasegraphiccontrol::TLMDBaseGraphicControl* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsHintLinked(void);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TLMDSpeedButtonActionLink(System::TObject* AClient) : Vcl::Controls::TControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TLMDSpeedButtonActionLink(void) { }
	
};


class PASCALIMPLEMENTATION TLMDBaseGraphicButton : public Lmdbasegraphiccontrol::TLMDBaseGraphicControl
{
	typedef Lmdbasegraphiccontrol::TLMDBaseGraphicControl inherited;
	
private:
	bool FRepeatedClick;
	bool FAllowMouseOver;
	bool FAllowShadow;
	Lmdbuttonlayout::TLMDButtonLayout* FButtonLayout;
	Lmdfxcaption::TLMDFxCaption* FFontFx;
	System::Word FRepeatingDelay;
	System::Word FRepeatingInterval;
	bool FDropDownCombo;
	int FDropdownComboWidth;
	System::Classes::TNotifyEvent FOnDropDown;
	bool FHideHint;
	bool FUseCaption;
	Vcl::Menus::TPopupMenu* FDropDown;
	System::Uitypes::TColor FEnterColor;
	int FDropDownIndent;
	int FGroupIndex;
	bool FDisabledGrayed;
	bool FDropDownRight;
	bool FEnterColorChange;
	bool FMultiLine;
	bool FPressed;
	bool FPrepareDrag;
	System::StaticArray<Lmdclass::TLMDTimer*, 2> FTimerID;
	int FInternal;
	bool FUseGlobalTimer;
	bool FAutoSize;
	bool __fastcall GetMouseOver(void);
	void __fastcall SetButtonLayout(Lmdbuttonlayout::TLMDButtonLayout* aValue);
	void __fastcall SetDropDown(Vcl::Menus::TPopupMenu* aValue);
	void __fastcall SetDropDownCombo(bool aValue);
	void __fastcall SetDropDownComboWidth(int aValue);
	void __fastcall SetDropDownIndent(int aValue);
	void __fastcall SetDropDownRight(bool aValue);
	void __fastcall SetEnterColor(System::Uitypes::TColor aValue);
	void __fastcall SetEnterColorChange(bool aValue);
	virtual void __fastcall SetFontFx(Lmdfxcaption::TLMDFxCaption* aValue);
	virtual void __fastcall SetGlyph(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetGroupIndex(int Value);
	void __fastcall SetMultiLine(bool aValue);
	void __fastcall SetNumGlyphs(Lmdglyph::TLMDNumGlyphs aValue);
	void __fastcall SetRepeatedClick(bool aValue);
	void __fastcall SetRepeatingInterval(System::Word aValue);
	void __fastcall SetUseCaption(bool aValue);
	HIDESBASE void __fastcall SetTransparent(bool aValue);
	bool __fastcall GetDroppedState(void);
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	System::UnicodeString __fastcall GetCaption(void);
	Lmdglyph::TLMDNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall ExecuteRepeatedClick(System::TObject* Sender);
	MESSAGE void __fastcall CMButtonPressed(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	void __fastcall SetAutoSizeProp(const bool Value);
	Lmdpngimage::TLMDPNGObject* __fastcall GetPngGlyph(void);
	void __fastcall SetPngGlyph(Lmdpngimage::TLMDPNGObject* const Value);
	void __fastcall SetUsePngGlyph(const bool Value);
	
protected:
	Lmdgraph::TLMDShadowDepth FShadowDepth;
	Lmdbuttonbase::TLMDButtonState FState;
	Lmdbuttonbase::TLMDButtonState FOldState;
	bool FAllowAllUp;
	bool FAllowTransparency;
	bool FUsed;
	bool FTransparent;
	System::TObject* FGlyph;
	Lmdpngimage::TLMDPNGObject* FPngGlyph;
	bool FUsePngGlyph;
	System::Types::TRect FGlyphRect;
	System::Types::TRect FTextRect;
	void __fastcall SetPressed(bool Value);
	bool __fastcall GetAllowAllUp(void);
	void __fastcall SetAllowAllUp(bool Value);
	bool __fastcall HasIML(void);
	virtual bool __fastcall IsCustom(void);
	virtual void __fastcall InformOptionSet(void);
	virtual bool __fastcall IsHotOptionsetMode(void);
	virtual bool __fastcall IsHotState(void);
	virtual bool __fastcall RepaintOnMouse(void);
	virtual bool __fastcall RestoreBack(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual bool __fastcall ActionChangeable(void);
	void __fastcall ActivateTimer(int aSession, System::Word anInterval, System::Classes::TNotifyEvent aCallFunc);
	void __fastcall DeActivateTimer(int aSession);
	virtual bool __fastcall CheckOptimized(void);
	virtual void __fastcall DoRepeatedClick(void);
	virtual System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall DrawGlyphAndText(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	virtual bool __fastcall ButtonColorChange(void);
	void __fastcall FontChange(System::TObject* Sender);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseEnter(void);
	virtual void __fastcall MouseExit(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall StateChange(Lmdbuttonbase::TLMDButtonState NewState, bool ForceUpdate = false);
	virtual bool __fastcall VerifyTransparency(int X, int Y);
	virtual void __fastcall VerifyMouseOver(System::TObject* Sender);
	DYNAMIC Vcl::Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	__property bool DisabledGrayed = {read=FDisabledGrayed, write=FDisabledGrayed, default=1};
	
public:
	__fastcall virtual TLMDBaseGraphicButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBaseGraphicButton(void);
	virtual void __fastcall Invalidate(void);
	void __fastcall EndRepeatedClick(void);
	DYNAMIC void __fastcall Click(void);
	void __fastcall DropDown(void);
	virtual System::Types::TRect __fastcall GetNeededSizeRect(void);
	virtual bool __fastcall isTransparentSet(void);
	__property bool Dropped = {read=GetDroppedState, nodefault};
	__property bool AllowMouseOver = {read=FAllowMouseOver, write=FAllowMouseOver, nodefault};
	__property bool AllowTransparency = {read=FAllowTransparency, write=FAllowTransparency, nodefault};
	__property bool MouseOver = {read=GetMouseOver, nodefault};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property bool DropDownCombo = {read=FDropDownCombo, write=SetDropDownCombo, default=0};
	__property int DropDownComboWidth = {read=FDropdownComboWidth, write=SetDropDownComboWidth, default=12};
	__property Vcl::Menus::TPopupMenu* DropDownMenu = {read=FDropDown, write=SetDropDown, stored=true};
	__property int DropDownIndent = {read=FDropDownIndent, write=SetDropDownIndent, default=0};
	__property bool DropDownRight = {read=FDropDownRight, write=SetDropDownRight, default=0};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Pressed = {read=FPressed, write=SetPressed, default=0};
	__property bool Down = {read=FPressed, write=SetPressed, nodefault};
	__property bool MultiLine = {read=FMultiLine, write=SetMultiLine, default=0};
	__property Lmdbuttonlayout::TLMDButtonLayout* ButtonLayout = {read=FButtonLayout, write=SetButtonLayout};
	__property System::Uitypes::TColor EnterColor = {read=FEnterColor, write=SetEnterColor, default=-16777207};
	__property bool EnterColorChange = {read=FEnterColorChange, write=SetEnterColorChange, default=0};
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph, stored=IsCustom};
	__property Lmdfxcaption::TLMDFxCaption* FontFX = {read=FFontFx, write=SetFontFx};
	__property Font;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property Lmdglyph::TLMDNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property bool RepeatedClick = {read=FRepeatedClick, write=SetRepeatedClick, default=0};
	__property System::Word RepeatingInterval = {read=FRepeatingInterval, write=SetRepeatingInterval, default=100};
	__property System::Word RepeatingDelay = {read=FRepeatingDelay, write=FRepeatingDelay, default=500};
	__property bool UseCaption = {read=FUseCaption, write=SetUseCaption, default=1};
	__property System::Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	
__published:
	__property About = {default=0};
	__property Caption = {default=0};
	__property Color = {default=-16777211};
	__property Enabled = {default=1};
	__property bool HideHint = {read=FHideHint, write=FHideHint, default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=FUseGlobalTimer, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeProp, nodefault};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Action;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
	__property Lmdpngimage::TLMDPNGObject* PngGlyph = {read=GetPngGlyph, write=SetPngGlyph};
	__property bool UsePngGlyph = {read=FUsePngGlyph, write=SetUsePngGlyph, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbasegraphicbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASEGRAPHICBUTTON)
using namespace Lmdbasegraphicbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbasegraphicbuttonHPP
