// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomHint.pas' rev: 31.00 (Windows)

#ifndef LmdcustomhintHPP
#define LmdcustomhintHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <LMDGraph.hpp>
#include <LMD3DCaption.hpp>
#include <LMDBevel.hpp>
#include <LMDNativeHint.hpp>
#include <LMDTypes.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomhint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHintBevel;
class DELPHICLASS TLMDCustomHint;
class DELPHICLASS TLMDCustomHintWindow;
class DELPHICLASS TLMDCustomHTMLHint;
class DELPHICLASS TLMDCustomHTMLHintWindow;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHintBevel : public Lmdbevel::TLMDBevel
{
	typedef Lmdbevel::TLMDBevel inherited;
	
public:
	__fastcall virtual TLMDHintBevel(System::Classes::TPersistent* AOwner);
	
__published:
	__property Mode = {default=0};
	__property StyleOuter = {default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDHintBevel(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomHint : public Lmdnativehint::TLMDBaseHint
{
	typedef Lmdnativehint::TLMDBaseHint inherited;
	
private:
	System::Uitypes::TColor FColor;
	Vcl::Graphics::TFont* FFont;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	TLMDHintBevel* FBevel;
	bool FUseFont;
	void __fastcall SetBevel(TLMDHintBevel* aValue);
	void __fastcall SetFont3d(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	bool __fastcall IsCustomFont(void);
	
protected:
	virtual Vcl::Controls::THintWindowClass __fastcall GetHintClass(void);
	
public:
	__fastcall virtual TLMDCustomHint(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomHint(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	Vcl::Graphics::TFont* __fastcall GetHintFont(void);
	void __fastcall ShowHint(const System::UnicodeString Msg, int x, int y, System::Word ms);
	void __fastcall ShowControlHint(const System::UnicodeString Msg, Vcl::Controls::TControl* aControl, System::Word ms);
	__property TLMDHintBevel* Bevel = {read=FBevel, write=SetBevel};
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, default=-16777192};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3d};
	
__published:
	__property MaxWidth = {default=-4};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=IsCustomFont};
	__property bool UseScreenHintFont = {read=FUseFont, write=FUseFont, default=1};
};


class PASCALIMPLEMENTATION TLMDCustomHintWindow : public Lmdnativehint::TLMDBaseHintWindow
{
	typedef Lmdnativehint::TLMDBaseHintWindow inherited;
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DrawTextTo(Vcl::Graphics::TCanvas* Canvas, System::UnicodeString Caption, const System::Types::TRect &TextRect);
	virtual void __fastcall GetTextSize(System::UnicodeString Caption, System::Types::TRect &aRect);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDCustomHintWindow(System::Classes::TComponent* AOwner);
	virtual void __fastcall ActivateHint(const System::Types::TRect &Rect, const System::UnicodeString AHint);
	HIDESBASE TLMDCustomHint* __fastcall HintControl(void);
public:
	/* TLMDBaseHintWindow.CreateCustom */ inline __fastcall TLMDCustomHintWindow(System::Classes::TComponent* AOwner, Lmdnativehint::TLMDBaseHint* AHintControl) : Lmdnativehint::TLMDBaseHintWindow(AOwner, AHintControl) { }
	/* TLMDBaseHintWindow.Destroy */ inline __fastcall virtual ~TLMDCustomHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomHintWindow(HWND ParentWindow) : Lmdnativehint::TLMDBaseHintWindow(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomHTMLHint : public TLMDCustomHint
{
	typedef TLMDCustomHint inherited;
	
private:
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnHide;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeededEx;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	Lmdhtmlunit::TLMDHTMLLinkClickEvent FOnLinkClick;
	
protected:
	virtual Vcl::Controls::THintWindowClass __fastcall GetHintClass(void);
	virtual void __fastcall DoShow(Vcl::Controls::THintWindow* Sender);
	virtual void __fastcall DoHide(Vcl::Controls::THintWindow* Sender);
	void __fastcall SetOnHide(System::Classes::TNotifyEvent Value);
	void __fastcall SetOnShow(System::Classes::TNotifyEvent Value);
	void __fastcall SetOnImageNeeded(Lmdhtmlunit::TElHTMLImageNeededEvent Value);
	void __fastcall SetOnImageNeededEx(Lmdhtmlunit::TLMDHTMLImageNeededEvent Value);
	void __fastcall SetOnLinkClick(Lmdhtmlunit::TLMDHTMLLinkClickEvent Value);
	
public:
	__fastcall virtual TLMDCustomHTMLHint(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomHTMLHint(void);
	
__published:
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=SetOnShow};
	__property System::Classes::TNotifyEvent OnHide = {read=FOnHide, write=SetOnHide};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=SetOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnImageNeededEx = {read=FOnImageNeededEx, write=SetOnImageNeededEx};
	__property Lmdhtmlunit::TLMDHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=SetOnLinkClick};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
};


class PASCALIMPLEMENTATION TLMDCustomHTMLHintWindow : public Lmdnativehint::TLMDBaseHintWindow
{
	typedef Lmdnativehint::TLMDBaseHintWindow inherited;
	
protected:
	System::Uitypes::TCursor FCursor;
	bool FWordWrap;
	Vcl::Graphics::TFont* FFont;
	bool FActivating;
	int FMaxWidth;
	System::WideString FWideCaption;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	System::Types::TRect FTextRect;
	bool FIsHTML;
	HIDESBASE void __fastcall SetFont(Vcl::Graphics::TFont* newValue);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall OnShow(void);
	virtual void __fastcall OnHide(void);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMShowWindow(Winapi::Messages::TWMShowWindow &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	void __fastcall SetupRightCaption(System::UnicodeString ACaption);
	virtual void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetWordWrap(bool Value);
	virtual void __fastcall DrawTextTo(Vcl::Graphics::TCanvas* ACanvas, Lmdtypes::TLMDString ACaption, const System::Types::TRect &TextRect);
	virtual void __fastcall GetTextSize(Lmdtypes::TLMDString ACaption, System::Types::TRect &aRect);
	virtual void __fastcall AdjustHintRect(System::Types::TRect &aRect);
	virtual void __fastcall InitRenderData(void);
	void __fastcall SetIsHTML(bool aValue);
	void __fastcall SetHintWindowSize(void);
	
public:
	__fastcall virtual TLMDCustomHTMLHintWindow(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomHTMLHintWindow(void);
	HIDESBASE TLMDCustomHTMLHint* __fastcall HintControl(void);
	virtual void __fastcall ActivateHint(const System::Types::TRect &Rect, const System::UnicodeString AHint);
	virtual System::Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
	System::Types::TRect __fastcall CalcHintRectW(int MaxWidth, const System::WideString AHint, void * AData);
	virtual void __fastcall ActivateHintW(const System::Types::TRect &Rect, const System::WideString AHint);
	__property int MaxWidth = {read=FMaxWidth, write=FMaxWidth, nodefault};
	__property Canvas;
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	__property System::WideString WideCaption = {read=FWideCaption, write=FWideCaption};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, nodefault};
public:
	/* TLMDBaseHintWindow.CreateCustom */ inline __fastcall TLMDCustomHTMLHintWindow(System::Classes::TComponent* AOwner, Lmdnativehint::TLMDBaseHint* AHintControl) : Lmdnativehint::TLMDBaseHintWindow(AOwner, AHintControl) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomHTMLHintWindow(HWND ParentWindow) : Lmdnativehint::TLMDBaseHintWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomhint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMHINT)
using namespace Lmdcustomhint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomhintHPP
