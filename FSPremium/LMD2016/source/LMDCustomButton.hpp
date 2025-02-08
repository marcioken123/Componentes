// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomButton.pas' rev: 31.00 (Windows)

#ifndef LmdcustombuttonHPP
#define LmdcustombuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Themes.hpp>
#include <intfLMDBackGround.hpp>
#include <intfLMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDCont.hpp>
#include <LMDGlyph.hpp>
#include <LMDButtonBase.hpp>
#include <LMDGraph.hpp>
#include <LMDFXCaption.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDBase.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBaseController.hpp>
#include <LMDTypes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustombutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomButton : public Vcl::Stdctrls::TButton
{
	typedef Vcl::Stdctrls::TButton inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdbuttonlayout::TLMDButtonLayout* FButtonLayout;
	Vcl::Graphics::TCanvas* FCanvas;
	Vcl::Menus::TPopupMenu* FDropDown;
	int FDropDownIndent;
	bool FDropDownRight;
	bool FDropped;
	Lmdfxcaption::TLMDFxCaption* FFontFx;
	Lmdtypes::TLMDString FHint;
	bool IsFocused;
	bool FMouseOver;
	bool FMultiLine;
	bool FRepeatedClick;
	System::Word FRepeatingDelay;
	System::Word FRepeatingInterval;
	Lmdbuttonbase::TLMDButtonState FState;
	Lmdbuttonbase::TLMDNormalButtonStyle FStyle;
	Lmdbuttonbase::TLMDUserButtonStyle FExtStyle;
	Lmdclass::TLMDTimer* FTimerID;
	bool FHideHint;
	bool FUseCaption;
	System::Classes::TNotifyEvent FOnDropDown;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseExit;
	Vcl::Imglist::TCustomImageList* FImageList;
	int FIndex;
	int FListIndex;
	Vcl::Imglist::TChangeLink* FChangeLink;
	bool FUseGlobalTimer;
	bool FParentThemeMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FThemeGlobalMode;
	HIDESBASE void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetIndex(int index, int aValue);
	void __fastcall SetUseCaption(bool aValue);
	void __fastcall ReadCtlXP(System::Classes::TReader* Reader);
	void __fastcall SetThemeGlobalMode(const bool Value);
	void __fastcall ReadIdent(System::Classes::TReader* Reader);
	void __fastcall WriteIdent(System::Classes::TWriter* Writer);
	void __fastcall ReadStyle(System::Classes::TReader* Reader);
	void __fastcall ReadExtStyle(System::Classes::TReader* Reader);
	void __fastcall set_CtlXP(bool aValue);
	bool __fastcall get_CtlXP(void);
	bool __fastcall CheckCont(void);
	bool __fastcall HasControl(void);
	bool __fastcall IMLEmpty(void);
	bool __fastcall HasIML(void);
	void __fastcall GetIMLChange(System::TObject* Sender);
	void __fastcall SetGlyphKind(Lmdbuttonbase::TLMDGlyphKind aValue);
	void __fastcall SetButtonLayout(Lmdbuttonlayout::TLMDButtonLayout* aValue);
	void __fastcall SetDropDown(Vcl::Menus::TPopupMenu* aValue);
	void __fastcall SetDropDownIndent(int aValue);
	void __fastcall SetDropDownRight(bool aValue);
	void __fastcall SetFontFx(Lmdfxcaption::TLMDFxCaption* aValue);
	void __fastcall SetMultiLine(bool aValue);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetRepeatedClick(bool aValue);
	void __fastcall SetRepeatingInterval(System::Word aValue);
	HIDESBASE void __fastcall SetStyle(Lmdbuttonbase::TLMDNormalButtonStyle aValue);
	void __fastcall SetExtStyle(Lmdbuttonbase::TLMDUserButtonStyle aValue);
	void __fastcall SetNumGlyphs(Lmdglyph::TLMDNumGlyphs aValue);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	HIDESBASE void __fastcall SetVisible(bool aValue);
	System::UnicodeString __fastcall GetCaption(void);
	bool __fastcall GetVisible(void);
	Lmdglyph::TLMDNumGlyphs __fastcall GetNumGlyphs(void);
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	bool __fastcall IsCustom(void);
	void __fastcall ExecuteRepeatedClick(System::TObject* Sender);
	MESSAGE void __fastcall CMLMDThemeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CNDrawItem(Winapi::Messages::TWMDrawItem &Message);
	MESSAGE void __fastcall CNMeasureItem(Winapi::Messages::TWMMeasureItem &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMEraseBackground(Winapi::Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall WMThemeChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	System::TObject* FGlyph;
	Lmdbuttonbase::TLMDGlyphKind FGlyphKind;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	Vcl::Themes::TThemedElement __fastcall GetXPThemedClass(void);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DrawCaptionAndGlyph(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, int flags);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall DrawItem(const tagDRAWITEMSTRUCT &DrawItemStruct);
	virtual void __fastcall DoRepeatedClick(void);
	void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	Lmdbuttonbase::TLMDButtonState __fastcall GetState(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall RequestDefaultGlyph(void);
	void __fastcall FreeTimer(void);
	virtual void __fastcall SetButtonStyle(bool ADefault);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	
public:
	__fastcall virtual TLMDCustomButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomButton(void);
	bool __fastcall IsThemed(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	DYNAMIC void __fastcall Click(void);
	void __fastcall DropDown(void);
	Vcl::Graphics::TBitmap* __fastcall BackBitmap(void);
	bool __fastcall BackBitmapCheck(void);
	bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags);
	bool __fastcall isTransparentSet(void);
	System::Types::TPoint __fastcall BackMapPoint(const System::Types::TPoint &aValue);
	HPALETTE __fastcall BackBitmapPalette(void);
	void __fastcall BackUpdate(void);
	virtual Vcl::Controls::TControl* __fastcall BackControl(int index);
	virtual int __fastcall BackControlCount(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property Lmdbuttonbase::TLMDNormalButtonStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property Lmdbuttonbase::TLMDUserButtonStyle ExtStyle = {read=FExtStyle, write=SetExtStyle, nodefault};
	__property bool CtlXP = {read=get_CtlXP, write=set_CtlXP, default=1};
	__property bool Dropped = {read=FDropped, nodefault};
	__property Vcl::Menus::TPopupMenu* DropDownMenu = {read=FDropDown, write=SetDropDown, stored=true};
	__property int DropDownIndent = {read=FDropDownIndent, write=SetDropDownIndent, default=0};
	__property bool DropDownRight = {read=FDropDownRight, write=SetDropDownRight, default=0};
	__property System::Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property Lmdbuttonbase::TLMDGlyphKind GlyphKind = {read=FGlyphKind, write=SetGlyphKind, default=0};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdbuttonlayout::TLMDButtonLayout* ButtonLayout = {read=FButtonLayout, write=SetButtonLayout};
	__property Lmdbuttonbase::TLMDUserButtonStyle ButtonStyle = {read=FExtStyle, write=SetExtStyle, default=1};
	__property Cancel = {default=0};
	__property Caption = {default=0};
	__property Color = {default=-16777211};
	__property Default = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Lmdfxcaption::TLMDFxCaption* FontFX = {read=FFontFx, write=SetFontFx};
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph, stored=IsCustom};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property bool HideHint = {read=FHideHint, write=FHideHint, default=1};
	__property bool UseCaption = {read=FUseCaption, write=SetUseCaption, default=1};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList, stored=HasControl};
	__property int ImageIndex = {read=FIndex, write=SetIndex, index=0, default=0};
	__property int ListIndex = {read=FListIndex, write=SetIndex, index=1, default=0};
	__property ModalResult = {default=0};
	__property bool MultiLine = {read=FMultiLine, write=SetMultiLine, default=0};
	__property Lmdglyph::TLMDNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property bool RepeatedClick = {read=FRepeatedClick, write=SetRepeatedClick, default=0};
	__property System::Word RepeatingInterval = {read=FRepeatingInterval, write=SetRepeatingInterval, default=100};
	__property System::Word RepeatingDelay = {read=FRepeatingDelay, write=FRepeatingDelay, default=500};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=FUseGlobalTimer, default=0};
	__property bool Visible = {read=GetVisible, write=SetVisible, default=1};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseExit = {read=FOnMouseExit, write=FOnMouseExit};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomButton(HWND ParentWindow) : Vcl::Stdctrls::TButton(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	void *__ILMDBackground;	// Intflmdbackground::ILMDBackground 
	
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
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0068598D-C5C6-488F-8E00-D813525C9163}
	operator Intflmdbackground::_di_ILMDBackground()
	{
		Intflmdbackground::_di_ILMDBackground intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbackground::ILMDBackground*(void) { return (Intflmdbackground::ILMDBackground*)&__ILMDBackground; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustombutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMBUTTON)
using namespace Lmdcustombutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustombuttonHPP
