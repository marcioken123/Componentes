// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSLabel.pas' rev: 31.00 (Windows)

#ifndef JslabelHPP
#define JslabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <JSTypes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jslabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSCustomLabel;
class DELPHICLASS TJSCustomMoreLabel;
class DELPHICLASS TJSMoreLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TJSCustomLabel : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	bool FAutoSize;
	System::UnicodeString FCaption;
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetCaption(const System::UnicodeString Value);
	
protected:
	DYNAMIC void __fastcall AdjustBounds(void);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	virtual void __fastcall DoDrawText(System::Types::TRect &ARect, int AFlags);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetAutoSize(bool Value);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	
public:
	__fastcall virtual TJSCustomLabel(System::Classes::TComponent* AOwner);
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TJSCustomLabel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSCustomLabel(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TJSCustomMoreLabel : public TJSCustomLabel
{
	typedef TJSCustomLabel inherited;
	
private:
	Vcl::Graphics::TPicture* FGlyph;
	int FSpacing;
	bool FExpanded;
	bool FMouseInControl;
	System::Classes::TNotifyEvent FOnCollapsed;
	System::Classes::TNotifyEvent FOnExpanded;
	void __fastcall SetGlyph(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetExpanded(const bool Value);
	void __fastcall SetMouseInControl(const bool Value);
	
protected:
	DYNAMIC void __fastcall AdjustBounds(void);
	DYNAMIC void __fastcall Click(void);
	HIDESBASE MESSAGE void __fastcall CMMouseenter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseleave(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DoCollapsed(void);
	virtual void __fastcall DoDrawText(System::Types::TRect &ARect, int AFlags);
	virtual void __fastcall DoExpanded(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Paint(void);
	virtual void __fastcall UpdateGlyph(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	__property bool MouseInControl = {read=FMouseInControl, write=SetMouseInControl, nodefault};
	
public:
	__fastcall virtual TJSCustomMoreLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TJSCustomMoreLabel(void);
	__property Vcl::Graphics::TPicture* Glyph = {read=FGlyph, write=SetGlyph};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property bool Expanded = {read=FExpanded, write=SetExpanded, default=0};
	__property System::Classes::TNotifyEvent OnCollapsed = {read=FOnCollapsed, write=FOnCollapsed};
	__property System::Classes::TNotifyEvent OnExpanded = {read=FOnExpanded, write=FOnExpanded};
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSCustomMoreLabel(HWND ParentWindow) : TJSCustomLabel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TJSMoreLabel : public TJSCustomMoreLabel
{
	typedef TJSCustomMoreLabel inherited;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoSize = {default=1};
	__property BiDiMode;
	__property Caption;
	__property Color = {default=-16777211};
	__property Expanded = {default=0};
	__property Font;
	__property Height;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property Spacing = {default=4};
	__property Visible = {default=1};
	__property Width;
	__property OnClick;
	__property OnExpanded;
	__property OnCollapsed;
public:
	/* TJSCustomMoreLabel.Create */ inline __fastcall virtual TJSMoreLabel(System::Classes::TComponent* AOwner) : TJSCustomMoreLabel(AOwner) { }
	/* TJSCustomMoreLabel.Destroy */ inline __fastcall virtual ~TJSMoreLabel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSMoreLabel(HWND ParentWindow) : TJSCustomMoreLabel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jslabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSLABEL)
using namespace Jslabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JslabelHPP
