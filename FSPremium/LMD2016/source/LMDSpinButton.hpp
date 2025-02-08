// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSpinButton.pas' rev: 31.00 (Windows)

#ifndef LmdspinbuttonHPP
#define LmdspinbuttonHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDUtils.hpp>
#include <LMDCustomControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdspinbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSpinButton;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSpinButtonState : unsigned char { sbUpper, sbUpDown, sbDownDown, sbLeftDown, sbRightDown, sbDisabled };

enum DECLSPEC_DENUM TLMDExtSpinBtnStyle : unsigned char { seSpinEdit, seSpinScrollBar };

enum DECLSPEC_DENUM TLMDSingleSpinButton : unsigned char { sbUp, sbDown, sbLeft, sbRight };

enum DECLSPEC_DENUM TLMDButtonPartState : unsigned char { bpsNormal, bpsHot, bpsPressed, bpsDisabled };

typedef System::Set<TLMDSingleSpinButton, TLMDSingleSpinButton::sbUp, TLMDSingleSpinButton::sbRight> TLMDSpinButtons;

class PASCALIMPLEMENTATION TLMDSpinButton : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	Lmdclass::TLMDTimer* FTimerId;
	Vcl::Graphics::TBitmap* FCache;
	TLMDSpinButtonState FDown;
	TLMDSpinButtonState FLastDown;
	TLMDExtSpinBtnStyle FExtStyle;
	bool FSkew;
	bool FDragging;
	System::Classes::TNotifyEvent FOnLeftClick;
	System::Classes::TNotifyEvent FOnRightClick;
	System::Classes::TNotifyEvent FOnTopClick;
	System::Classes::TNotifyEvent FOnBottomClick;
	TLMDSpinButtons FSpinButtons;
	int FBtnMode;
	Lmdgraph::TLMDBorderStyle FBorderStyle;
	TLMDButtonPartState FUpBtnState;
	TLMDButtonPartState FDnBtnState;
	TLMDButtonPartState FRBtnState;
	TLMDButtonPartState FLBtnState;
	System::Word FInterval;
	System::Types::TPoint FCacheDim;
	HRGN FUpRgn;
	HRGN FDnRgn;
	HRGN FRightRgn;
	HRGN FLeftRgn;
	bool FUseGlobalTimer;
	System::Uitypes::TColor FHotColor;
	void __fastcall SetDown(TLMDSpinButtonState Value);
	void __fastcall SetBtns(TLMDSpinButtons aValue);
	void __fastcall CreateStates(void);
	void __fastcall DrawState(TLMDSingleSpinButton btn, int index);
	bool __fastcall SimpleMode(void);
	void __fastcall TimerExpired(System::TObject* Sender);
	void __fastcall SetSkew(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMWINDOWPOSCHANGED(Winapi::Messages::TWMWindowPosMsg &Msg);
	
protected:
	void __fastcall AddTimer(void);
	bool __fastcall checkRgn(HRGN aRgn, TLMDButtonPartState &bsVar, int X, int Y, System::Classes::TShiftState Shift);
	virtual void __fastcall DoThemeChanged(void);
	void __fastcall FreeRegions(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	void __fastcall RemoveTimer(void);
	
public:
	__fastcall virtual TLMDSpinButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSpinButton(void);
	void __fastcall MouseLeave(void);
	__property CtlXP = {default=0};
	__property TLMDSpinButtonState Down = {read=FDown, write=SetDown, default=0};
	__property TLMDExtSpinBtnStyle ExtStyle = {read=FExtStyle, write=FExtStyle, default=0};
	__property System::Word Interval = {read=FInterval, write=FInterval, nodefault};
	__property Enabled = {default=1};
	__property TLMDSpinButtons SpinButtons = {read=FSpinButtons, write=SetBtns, default=1};
	__property bool OldStyle = {read=FSkew, write=SetSkew, default=1};
	__property Color = {default=-16777201};
	__property System::Uitypes::TColor HotColor = {read=FHotColor, write=FHotColor, default=8421376};
	__property ParentColor = {default=0};
	__property Visible = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=FUseGlobalTimer, default=0};
	__property System::Classes::TNotifyEvent OnBottomClick = {read=FOnBottomClick, write=FOnBottomClick};
	__property System::Classes::TNotifyEvent OnTopClick = {read=FOnTopClick, write=FOnTopClick};
	__property System::Classes::TNotifyEvent OnLeftClick = {read=FOnLeftClick, write=FOnLeftClick};
	__property System::Classes::TNotifyEvent OnRightClick = {read=FOnRightClick, write=FOnRightClick};
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
};


//-- var, const, procedure ---------------------------------------------------
static const int def_SPINHOTCOLOR = int(8421376);
}	/* namespace Lmdspinbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSPINBUTTON)
using namespace Lmdspinbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdspinbuttonHPP
