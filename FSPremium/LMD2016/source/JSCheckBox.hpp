// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSCheckBox.pas' rev: 31.00 (Windows)

#ifndef JscheckboxHPP
#define JscheckboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Themes.hpp>
#include <JSTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jscheckbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSCustomCheckBox;
class DELPHICLASS TJSCheckBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TJSCustomCheckBox : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	bool FChecked;
	System::Classes::TAlignment FAlignment;
	Vcl::Graphics::TBitmap* FCheckBitmap;
	System::UnicodeString FCaption;
	bool FMouseInControl;
	Vcl::Stdctrls::TCheckBoxState FState;
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetChecked(const bool Value);
	void __fastcall SetAlignment(const System::Classes::TLeftRight Value);
	System::Types::TRect __fastcall CalculateCheckRect(void);
	System::Types::TRect __fastcall CalculateCaptionRect(void);
	void __fastcall InitialiseCheckBitmap(void);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetMouseInControl(const bool Value);
	void __fastcall SetState(const Vcl::Stdctrls::TCheckBoxState Value);
	bool __fastcall GetTransparent(void);
	
protected:
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	HIDESBASE MESSAGE void __fastcall CMMouseenter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseleave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextchanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall BMSetCheck(Winapi::Messages::TMessage &Message);
	virtual Vcl::Themes::TThemedElementDetails __fastcall GetThemeElement(void);
	virtual void __fastcall DrawCheck(void);
	virtual void __fastcall DrawCaption(void);
	virtual void __fastcall DrawBackground(void);
	virtual bool __fastcall HitTestCaption(const int X, const int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	virtual void __fastcall Toggle(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall DoClick(void);
	__property bool MouseInControl = {read=FMouseInControl, write=SetMouseInControl, nodefault};
	__property Vcl::Stdctrls::TCheckBoxState State = {read=FState, write=SetState, default=0};
	
public:
	__fastcall virtual TJSCustomCheckBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TJSCustomCheckBox(void);
	__property System::Classes::TLeftRight Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
	__property bool Transparent = {read=GetTransparent, write=SetTransparent, default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSCustomCheckBox(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TJSCheckBox : public TJSCustomCheckBox
{
	typedef TJSCustomCheckBox inherited;
	
__published:
	__property Action;
	__property Alignment = {default=0};
	__property BiDiMode;
	__property Caption;
	__property Checked = {default=0};
	__property Color = {default=-16777211};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property Transparent = {default=1};
	__property OnClick;
public:
	/* TJSCustomCheckBox.Create */ inline __fastcall virtual TJSCheckBox(System::Classes::TComponent* AOwner) : TJSCustomCheckBox(AOwner) { }
	/* TJSCustomCheckBox.Destroy */ inline __fastcall virtual ~TJSCheckBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSCheckBox(HWND ParentWindow) : TJSCustomCheckBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jscheckbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSCHECKBOX)
using namespace Jscheckbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JscheckboxHPP
