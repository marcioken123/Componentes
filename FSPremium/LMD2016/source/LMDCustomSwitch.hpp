// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomSwitch.pas' rev: 31.00 (Windows)

#ifndef LmdcustomswitchHPP
#define LmdcustomswitchHPP

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
#include <LMDGraphicControl.hpp>
#include <LMDCaption.hpp>
#include <LMDCustomControl.hpp>
#include <LMDBevel.hpp>
#include <Winapi.Messages.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomswitch
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomSwitch;
class DELPHICLASS TLMDWCustomSwitch;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomSwitch : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	bool FChecked;
	bool FCheckedLeft;
	Lmdcaption::TLMDCaption* FCaptionOn;
	Lmdcaption::TLMDCaption* FCaptionOff;
	System::Byte FSlope;
	System::Byte FSideLength;
	System::Uitypes::TColor FOnColor;
	System::Uitypes::TColor FOffColor;
	System::Uitypes::TColor FTopColor;
	System::Uitypes::TColor FSideColor;
	int LabelLen;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetCaption(int Index, Lmdcaption::TLMDCaption* Value);
	void __fastcall SetChecked(bool Value);
	void __fastcall SetCheckedLeft(bool Value);
	HIDESBASE void __fastcall SetColor(int Index, System::Uitypes::TColor Value);
	void __fastcall SetSlope(System::Byte Value);
	void __fastcall SetSideLength(System::Byte Value);
	
protected:
	virtual void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Toggle(void);
	
public:
	__fastcall virtual TLMDCustomSwitch(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomSwitch(void);
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
	
__published:
	__property About = {default=0};
	__property Bevel;
	__property Lmdcaption::TLMDCaption* CaptionChecked = {read=FCaptionOn, write=SetCaption, index=0};
	__property Lmdcaption::TLMDCaption* CaptionUnChecked = {read=FCaptionOff, write=SetCaption, index=1};
	__property bool CheckedLeft = {read=FCheckedLeft, write=SetCheckedLeft, default=1};
	__property Color = {default=-16777211};
	__property System::Uitypes::TColor ColorChecked = {read=FOnColor, write=SetColor, index=0, default=255};
	__property System::Uitypes::TColor ColorUnChecked = {read=FOffColor, write=SetColor, index=1, default=128};
	__property Enabled = {default=1};
	__property ParentColor = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property System::Uitypes::TColor SideColor = {read=FSideColor, write=SetColor, index=3, default=12632256};
	__property System::Byte SideLength = {read=FSideLength, write=SetSideLength, default=6};
	__property System::Byte Slope = {read=FSlope, write=SetSlope, default=6};
	__property Transparent = {default=1};
	__property System::Uitypes::TColor TopColor = {read=FTopColor, write=SetColor, index=2, default=12632256};
	__property Visible = {default=1};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


class PASCALIMPLEMENTATION TLMDWCustomSwitch : public Lmdcustomcontrol::TLMDCustomControl
{
	typedef Lmdcustomcontrol::TLMDCustomControl inherited;
	
private:
	Lmdbevel::TLMDBevel* FBevel;
	bool FChecked;
	bool FCheckedLeft;
	Lmdcaption::TLMDCaption* FCaptionOn;
	Lmdcaption::TLMDCaption* FCaptionOff;
	System::Byte FSlope;
	System::Byte FSideLength;
	System::Uitypes::TColor FOnColor;
	System::Uitypes::TColor FOffColor;
	System::Uitypes::TColor FTopColor;
	System::Uitypes::TColor FSideColor;
	int LabelLen;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetCaption(int Index, Lmdcaption::TLMDCaption* Value);
	void __fastcall SetChecked(bool Value);
	void __fastcall SetCheckedLeft(bool Value);
	HIDESBASE void __fastcall SetColor(int Index, System::Uitypes::TColor Value);
	void __fastcall SetSlope(System::Byte Value);
	void __fastcall SetSideLength(System::Byte Value);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Vcl::Controls::TCMFocusChanged &Msg);
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* const aValue);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Toggle(void);
	
public:
	__fastcall virtual TLMDWCustomSwitch(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWCustomSwitch(void);
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
	
__published:
	__property About = {default=0};
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Lmdcaption::TLMDCaption* CaptionChecked = {read=FCaptionOn, write=SetCaption, index=0};
	__property Lmdcaption::TLMDCaption* CaptionUnChecked = {read=FCaptionOff, write=SetCaption, index=1};
	__property bool CheckedLeft = {read=FCheckedLeft, write=SetCheckedLeft, default=1};
	__property Color = {default=-16777211};
	__property System::Uitypes::TColor ColorChecked = {read=FOnColor, write=SetColor, index=0, default=255};
	__property System::Uitypes::TColor ColorUnChecked = {read=FOffColor, write=SetColor, index=1, default=128};
	__property Enabled = {default=1};
	__property ParentColor = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property System::Uitypes::TColor SideColor = {read=FSideColor, write=SetColor, index=3, default=12632256};
	__property System::Byte SideLength = {read=FSideLength, write=SetSideLength, default=6};
	__property System::Byte Slope = {read=FSlope, write=SetSlope, default=6};
	__property Transparent = {default=0};
	__property System::Uitypes::TColor TopColor = {read=FTopColor, write=SetColor, index=2, default=12632256};
	__property Visible = {default=1};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDWCustomSwitch(HWND ParentWindow) : Lmdcustomcontrol::TLMDCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomswitch */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMSWITCH)
using namespace Lmdcustomswitch;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomswitchHPP
