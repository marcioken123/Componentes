// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sRadioButton.pas' rev: 27.00 (Windows)

#ifndef SradiobuttonHPP
#define SradiobuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <sFade.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sradiobutton
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsRadioButton;
class PASCALIMPLEMENTATION TsRadioButton : public Vcl::Stdctrls::TRadioButton
{
	typedef Vcl::Stdctrls::TRadioButton inherited;
	
private:
	Scommondata::TsCommonData* FCommonData;
	Sconst::TsDisabledKind FDisabledKind;
	Vcl::Graphics::TBitmap* FGlyphUnChecked;
	Vcl::Graphics::TBitmap* FGlyphChecked;
	int FTextIndent;
	bool FShowFocus;
	int FMargin;
	Sfade::TsFadeTimer* FadeTimer;
	Sconst::TacAnimatEvents FAnimatEvents;
	System::Classes::TNotifyEvent FOnValueChanged;
	Sconst::TvaAlign FVerticalAlign;
	void __fastcall SetDisabledKind(const Sconst::TsDisabledKind Value);
	void __fastcall SetGlyphChecked(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetGlyphUnChecked(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetTextIndent(const int Value);
	void __fastcall SetShowFocus(const bool Value);
	void __fastcall SetMargin(const int Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetVerticalAlign(const Sconst::TvaAlign Value);
	
protected:
	bool FPressed;
	bool FReadOnly;
	bool __fastcall GetReadOnly(void);
	virtual bool __fastcall CanModify(void);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	virtual void __fastcall SetChecked(bool Value);
	HIDESBASE void __fastcall PaintHandler(const Winapi::Messages::TWMPaint &M);
	void __fastcall PaintControl(HDC DC);
	void __fastcall DrawCheckText(void);
	void __fastcall DrawCheckArea(void);
	void __fastcall DrawSkinGlyph(int i);
	int __fastcall PaintCtrlState(void);
	void __fastcall PaintGlyph(Vcl::Graphics::TBitmap* Bmp, const int Index);
	int __fastcall SkinGlyphWidth(int i);
	int __fastcall SkinGlyphHeight(int i);
	System::Types::TRect __fastcall SkinCheckRect(int i);
	Vcl::Graphics::TBitmap* __fastcall Glyph(void);
	System::Types::TRect __fastcall CheckRect(void);
	int __fastcall GlyphWidth(void);
	int __fastcall GlyphHeight(void);
	short __fastcall GlyphMaskIndex(bool Checked);
	bool __fastcall PrepareCache(void);
	
public:
	DYNAMIC System::Classes::TAlignment __fastcall GetControlsAlignment(void);
	virtual void __fastcall AfterConstruction(void);
	__fastcall virtual TsRadioButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsRadioButton(void);
	virtual void __fastcall Invalidate(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property AutoSize = {default=1};
	__property int Margin = {read=FMargin, write=SetMargin, default=2};
	__property Sconst::TacAnimatEvents AnimatEvents = {read=FAnimatEvents, write=FAnimatEvents, default=16};
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
	__property Sconst::TsDisabledKind DisabledKind = {read=FDisabledKind, write=SetDisabledKind, default=1};
	__property Vcl::Graphics::TBitmap* GlyphChecked = {read=FGlyphChecked, write=SetGlyphChecked};
	__property Vcl::Graphics::TBitmap* GlyphUnChecked = {read=FGlyphUnChecked, write=SetGlyphUnChecked};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property int TextIndent = {read=FTextIndent, write=SetTextIndent, default=0};
	__property WordWrap = {default=0};
	__property Sconst::TvaAlign VerticalAlign = {read=FVerticalAlign, write=SetVerticalAlign, default=1};
	__property System::Classes::TNotifyEvent OnValueChanged = {read=FOnValueChanged, write=FOnValueChanged};
	__property OnMouseEnter;
	__property OnMouseLeave;
public:
	/* TWinControl.CreateParented */ inline __fastcall TsRadioButton(HWND ParentWindow) : Vcl::Stdctrls::TRadioButton(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sradiobutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SRADIOBUTTON)
using namespace Sradiobutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SradiobuttonHPP
