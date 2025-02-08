// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElScrollBox.pas' rev: 31.00 (Windows)

#ifndef ElscrollboxHPP
#define ElscrollboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Themes.hpp>
#include <LMDSysIn.hpp>
#include <LMDProcs.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDUtils.hpp>
#include <LMDGraph.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <ElStyleMan.hpp>
#include <ElVCLUtils.hpp>
#include <ElImgFrm.hpp>
#include <ElSBCtrl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elscrollbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElScrollBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElScrollBox : public Vcl::Forms::TScrollBox
{
	typedef Vcl::Forms::TScrollBox inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Vcl::Graphics::TBitmap* FBackground;
	Lmdgraph::TLMDBorderSides FBorderSides;
	bool FFlat;
	bool FFlatFocusedScrollBars;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FUseBackground;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	bool FMouseOver;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	bool FPainting;
	bool FPaintingTo;
	bool FTransparent;
	Elstyleman::TElStyleMgrChangeLink* FStyleMgrLink;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	bool FRightAlignedView;
	bool fUseCustomScrollBars;
	Elsbctrl::TElSBController* fSBCtrl;
	Elsbctrl::TElCtrlScrollBarStyles* __fastcall GetHorzScrollBar(void);
	Elsbctrl::TElCtrlScrollBarStyles* __fastcall GetVertScrollBar(void);
	HIDESBASE void __fastcall SetHorzScrollBar(Elsbctrl::TElCtrlScrollBarStyles* const Value);
	HIDESBASE void __fastcall SetVertScrollBar(Elsbctrl::TElCtrlScrollBarStyles* const Value);
	void __fastcall SetUseCustomScrollBars(const bool Value);
	void __fastcall SetRightAlignedView(bool Value);
	void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetFlatFocusedScrollBars(const bool Value);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetUseBackground(const bool Value);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	void __fastcall DrawBackground(HDC DC, const System::Types::TRect &R);
	void __fastcall DrawFlatBorder(HDC DC);
	void __fastcall DrawParentControl(HDC DC);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	void __fastcall ImageFormChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	void __fastcall SetParentThemeMode(const bool Value);
	void __fastcall DoPaintCrossScrollBarsArea(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, bool &DefaultDraw);
	
protected:
	bool FPreventStyleChange;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	Lmdtypes::TLMDString FHint;
	bool FTransparentXPThemes;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorWindow;
	bool FParentThemeMode;
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool __fastcall GetUseXPThemes(void);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	MESSAGE void __fastcall WMStyleChanging(Winapi::Messages::TWMStyleChange &Message);
	MESSAGE void __fastcall WMStyleChanged(Winapi::Messages::TWMStyleChange &Message);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	DYNAMIC void __fastcall DoMouseEnter(void);
	DYNAMIC void __fastcall DoMouseLeave(void);
	DYNAMIC void __fastcall DoPaint(HDC DC);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	virtual void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	void __fastcall UpdateStyle(void);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	virtual void __fastcall DrawThemedBackground(HDC DC);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetTransparentXPThemes(bool Value);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	virtual void __fastcall AutoScrollInView(Vcl::Controls::TControl* AControl);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TElScrollBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElScrollBox(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	bool __fastcall IsThemed(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool FlatFocusedScrollBars = {read=FFlatFocusedScrollBars, write=SetFlatFocusedScrollBars, default=0};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=0};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=0};
	__property bool UseBackground = {read=FUseBackground, write=SetUseBackground, default=0};
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property bool TransparentXPThemes = {read=FTransparentXPThemes, write=SetTransparentXPThemes, default=1};
	__property bool UseCustomScrollBars = {read=fUseCustomScrollBars, write=SetUseCustomScrollBars, default=1};
	__property Elsbctrl::TElCtrlScrollBarStyles* HorzScrollBarStyles = {read=GetHorzScrollBar, write=SetHorzScrollBar};
	__property Elsbctrl::TElCtrlScrollBarStyles* VertScrollBarStyles = {read=GetVertScrollBar, write=SetVertScrollBar};
	__property bool RightAlignedView = {read=FRightAlignedView, write=SetRightAlignedView, default=0};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
	__property DoubleBuffered;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElScrollBox(HWND ParentWindow) : Vcl::Forms::TScrollBox(ParentWindow) { }
	
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


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elscrollbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSCROLLBOX)
using namespace Elscrollbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElscrollboxHPP
