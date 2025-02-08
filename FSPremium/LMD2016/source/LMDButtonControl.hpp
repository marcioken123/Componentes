// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDButtonControl.pas' rev: 31.00 (Windows)

#ifndef LmdbuttoncontrolHPP
#define LmdbuttoncontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ActnList.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <intfLMDFaceControllerEditable.hpp>
#include <intfLMDFaceControllerPressable.hpp>
#include <LMDCont.hpp>
#include <LMDUtils.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <System.Actions.hpp>
#include <System.UITypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbuttoncontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButtonControl;
class DELPHICLASS TLMDButtonActionLink;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDButtonControl : public Lmdcustompanel::TLMDCustomPanel
{
	typedef Lmdcustompanel::TLMDCustomPanel inherited;
	
private:
	Lmdglyphtextlayout::TLMDGlyphTextLayout* FAlignment;
	bool FDownCtrlState;
	bool FDown;
	bool FSaveRes;
	bool FAutoSize;
	bool FUseBitmap;
	bool FClicksDisabled;
	bool FGlyphFlat;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	Lmdgraph::TLMDGlyphTextFocusStyle FFocusStyle;
	System::Uitypes::TColor FFocusColor;
	bool FUseFocusColor;
	System::Classes::TNotifyEvent FOnChange;
	bool FReadOnly;
	bool FMultiLine;
	bool __fastcall IsCheckedStored(void);
	void __fastcall SetAlignment(Lmdglyphtextlayout::TLMDGlyphTextLayout* aValue);
	void __fastcall SetBool(int index, bool aValue);
	void __fastcall SetFocusStyle(Lmdgraph::TLMDGlyphTextFocusStyle aValue);
	void __fastcall SetFocusColor(System::Uitypes::TColor aValue);
	void __fastcall SetGlyphSize(System::Byte aValue);
	void __fastcall SetUseFocusColor(bool aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetMultiline(const bool Value);
	void __fastcall SetTransparentColor(System::Uitypes::TColor aValue);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	
protected:
	Vcl::Graphics::TBitmap* FGlyph;
	int FInternal;
	System::Byte FGlyphSize;
	int FGlyphHeight;
	System::Uitypes::TColor FTransparentColor;
	bool FUpdating;
	bool FGlyphTransparent;
	Lmdgraphutils::TLMDWhereRect FItemPositions;
	virtual void __fastcall CreateHandle(void);
	virtual bool __fastcall fcGetModified(void);
	virtual bool __fastcall fcGetReadOnly(void);
	virtual bool __fastcall fcGetInvalidData(void);
	virtual bool __fastcall fcGetPressed(void);
	DYNAMIC void __fastcall RestoreBorderFront(void);
	DYNAMIC void __fastcall RestoreBorderBack(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall CreateStandardGlyph(void);
	virtual bool __fastcall GetChecked(void);
	virtual void __fastcall SetChecked(bool aValue);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	DYNAMIC Vcl::Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	virtual void __fastcall DoTxtChange(System::TObject* Sender);
	virtual bool __fastcall CanModify(void);
	virtual bool __fastcall HasDown(void);
	virtual void __fastcall CorrectBounds(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DoThemeChanged(void);
	System::Types::TRect __fastcall GetFocusRect(void);
	virtual void __fastcall CreateGlyph(void);
	void __fastcall RemoveGlyph(void);
	void __fastcall DrawFocus(Vcl::Graphics::TCanvas* target, const System::Types::TRect &aRect);
	virtual void __fastcall DrawFace(Vcl::Graphics::TCanvas* aCanvas, const System::UnicodeString aString, Lmd3dcaption::TLMD3DCaption* Effects, const System::Types::TRect &aDest, Vcl::Graphics::TCanvas* srcCanvas, System::Types::TRect &srcRect, Vcl::Graphics::TCanvas* aMaskCanvas, System::Uitypes::TColor TransColor, Lmdglyphtextlayout::TLMDGlyphTextLayout* aLayout, bool MultiLine, bool Accel, bool Transparent, Lmdgraph::TLMDDrawTextStyles ExtFlags, int flags) = 0 ;
	virtual System::Types::TRect __fastcall DrawItem(Vcl::Graphics::TCanvas* target, bool toDraw, System::Byte flag) = 0 ;
	virtual void __fastcall DrawGlyph(Vcl::Graphics::TCanvas* Target = (Vcl::Graphics::TCanvas*)(0x0)) = 0 ;
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall MouseEnter(void);
	virtual void __fastcall MouseExit(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	__property bool Checked = {read=GetChecked, write=SetChecked, stored=IsCheckedStored, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetBool, index=0, default=0};
	__property Lmdgraph::TLMDGlyphTextFocusStyle FocusStyle = {read=FFocusStyle, write=SetFocusStyle, default=1};
	__property System::Uitypes::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=8421504};
	__property bool GlyphTransparent = {read=FGlyphTransparent, write=SetBool, index=1, default=0};
	__property System::Uitypes::TColor GlyphTransparentColor = {read=FTransparentColor, write=SetTransparentColor, default=32896};
	__property bool UseBitmap = {read=FUseBitmap, write=FUseBitmap, default=0};
	__property bool UseFocusColor = {read=FUseFocusColor, write=SetUseFocusColor, default=0};
	__property bool ClicksDisabled = {read=FClicksDisabled, nodefault};
	__property bool SaveRes = {read=FSaveRes, write=FSaveRes, default=1};
	__property bool Down = {read=FDown, write=FDown, nodefault};
	__property bool MultiLine = {read=FMultiLine, write=SetMultiline, default=1};
	
public:
	__fastcall virtual TLMDButtonControl(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDButtonControl(void);
	void __fastcall PaintToControl(System::Byte flag);
	void __fastcall UpDateNow(bool enabled);
	__property CtlXP = {default=1};
	__property System::Byte GlyphSize = {read=FGlyphSize, write=SetGlyphSize, nodefault};
	__property bool GlyphFlat = {read=FGlyphFlat, write=SetBool, index=2, default=0};
	__property Lmdglyphtextlayout::TLMDGlyphTextLayout* Alignment = {read=FAlignment, write=SetAlignment};
	__property Flat = {default=0};
	__property Font;
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property Transparent = {default=0};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property OnClick;
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property Caption = {default=0};
	__property bool DownGlyph = {read=FDownCtrlState, write=FDownCtrlState, default=0};
	__property ParentColor = {default=1};
	__property ParentBackground = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDButtonControl(HWND ParentWindow) : Lmdcustompanel::TLMDCustomPanel(ParentWindow) { }
	
private:
	void *__ILMDFaceControllerPressable;	// Intflmdfacecontrollerpressable::ILMDFaceControllerPressable 
	void *__ILMDFaceControllerEditable;	// Intflmdfacecontrollereditable::ILMDFaceControllerEditable 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {DAF1F323-1814-4CF5-97C9-5B82B945D7E6}
	operator Intflmdfacecontrollerpressable::_di_ILMDFaceControllerPressable()
	{
		Intflmdfacecontrollerpressable::_di_ILMDFaceControllerPressable intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdfacecontrollerpressable::ILMDFaceControllerPressable*(void) { return (Intflmdfacecontrollerpressable::ILMDFaceControllerPressable*)&__ILMDFaceControllerPressable; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {4CF92C4B-8694-477D-8E1E-2F6A2EAAE960}
	operator Intflmdfacecontrollereditable::_di_ILMDFaceControllerEditable()
	{
		Intflmdfacecontrollereditable::_di_ILMDFaceControllerEditable intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdfacecontrollereditable::ILMDFaceControllerEditable*(void) { return (Intflmdfacecontrollereditable::ILMDFaceControllerEditable*)&__ILMDFaceControllerEditable; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDButtonActionLink : public Vcl::Controls::TWinControlActionLink
{
	typedef Vcl::Controls::TWinControlActionLink inherited;
	
protected:
	TLMDButtonControl* FClient;
	virtual void __fastcall AssignClient(System::TObject* aClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual void __fastcall SetChecked(bool aValue);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TLMDButtonActionLink(System::TObject* AClient) : Vcl::Controls::TWinControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TLMDButtonActionLink(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbuttoncontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBUTTONCONTROL)
using namespace Lmdbuttoncontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbuttoncontrolHPP
