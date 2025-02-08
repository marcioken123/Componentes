// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDJoy.pas' rev: 31.00 (Windows)

#ifndef LmdjoyHPP
#define LmdjoyHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.MMSystem.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdjoy
{
//-- forward type declarations -----------------------------------------------
struct TDblWord;
class DELPHICLASS TLMDJoystick;
//-- type declarations -------------------------------------------------------
typedef System::Int8 TLMDJoyStickID;

enum DECLSPEC_DENUM TLMDJoyStickButton : unsigned char { jbButton1, jbButton2, jbButton3, jbButton4 };

typedef System::Set<TLMDJoyStickButton, TLMDJoyStickButton::jbButton1, TLMDJoyStickButton::jbButton4> TJoystickButtons;

typedef TJoystickButtons TLMDJoyStickButtons;

typedef void __fastcall (__closure *TLMDJoyStickEvent)(System::TObject* Sender, TJoystickButtons Buttons, System::Word X, System::Word Y);

struct DECLSPEC_DRECORD TDblWord
{
public:
	System::Word x;
	System::Word y;
};


class PASCALIMPLEMENTATION TLMDJoystick : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	System::Word FCalibrateRange;
	TDblWord FCalCenter;
	TDblWord FCalLeftTop;
	TDblWord FCalRightBottom;
	bool FChanged;
	bool FEnabled;
	HWND FHWnd;
	TLMDJoyStickID FJoystickID;
	System::Word FPeriod;
	System::Word FThreshold;
	System::Classes::TNotifyEvent FOnInitError;
	TLMDJoyStickEvent FOnMove;
	TLMDJoyStickEvent FOnButtonDown;
	TLMDJoyStickEvent FOnButtonUp;
	void __fastcall SetCalibrateRange(System::Word aValue);
	void __fastcall SetPeriod(System::Word aValue);
	void __fastcall SetChanged(bool aValue);
	void __fastcall SetEnabled(bool aValue);
	void __fastcall SetJoyStickId(TLMDJoyStickID aValue);
	void __fastcall SetThreshold(System::Word aValue);
	void __fastcall JoyEnable(void);
	void __fastcall JoyDisable(void);
	void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	joyinfo_tag __fastcall GetJoyInfo(void);
	System::Word __fastcall GetPos(int index);
	int __fastcall GetPosC(int index);
	TJoystickButtons __fastcall GetButtons(System::Word aValue);
	TJoystickButtons __fastcall GetButtonState(void);
	bool __fastcall GetButtonPressed(void);
	TDblWord __fastcall GetPosition(void);
	System::Byte __fastcall GetNumDevs(void);
	System::Byte __fastcall GetAttachedDevs(void);
	tagJOYCAPSW __fastcall GetJoyCaps(void);
	bool __fastcall GetBtnID(TLMDJoyStickButton index);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDJoystick(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDJoystick(void);
	bool __fastcall TestAvailable(TLMDJoyStickID aValue);
	void __fastcall CalibrateCenter(bool flag, System::Word x, System::Word y);
	void __fastcall CalibrateLeftTop(bool flag, System::Word x, System::Word y);
	void __fastcall CalibrateRightBottom(bool flag, System::Word x, System::Word y);
	__property System::Byte AttachedJoySticks = {read=GetAttachedDevs, nodefault};
	__property System::Byte AvailableJoySticks = {read=GetNumDevs, nodefault};
	__property bool ButtonPressed = {read=GetButtonPressed, nodefault};
	__property TJoystickButtons ButtonState = {read=GetButtonState, nodefault};
	__property bool ButtonPressedID[TLMDJoyStickButton index] = {read=GetBtnID};
	__property TDblWord CalCenter = {read=FCalCenter};
	__property TDblWord CalLeftTop = {read=FCalLeftTop};
	__property TDblWord CalRightBottom = {read=FCalRightBottom};
	__property tagJOYCAPSW GetJoyStickCaps = {read=GetJoyCaps};
	__property TDblWord Position = {read=GetPosition};
	__property System::Word PosX = {read=GetPos, index=0, nodefault};
	__property System::Word PosY = {read=GetPos, index=1, nodefault};
	__property System::Word PosZ = {read=GetPos, index=2, nodefault};
	__property int PosCX = {read=GetPosC, index=0, nodefault};
	__property int PosCY = {read=GetPosC, index=1, nodefault};
	
__published:
	__property About = {default=0};
	__property System::Word CalibrateRange = {read=FCalibrateRange, write=SetCalibrateRange, default=10};
	__property bool Changed = {read=FChanged, write=SetChanged, default=1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property TLMDJoyStickID JoyStickId = {read=FJoystickID, write=SetJoyStickId, default=0};
	__property System::Word Period = {read=FPeriod, write=SetPeriod, default=10};
	__property System::Word Threshold = {read=FThreshold, write=SetThreshold, default=2000};
	__property TLMDJoyStickEvent OnJoyMove = {read=FOnMove, write=FOnMove};
	__property TLMDJoyStickEvent OnJoyButtonDown = {read=FOnButtonDown, write=FOnButtonDown};
	__property TLMDJoyStickEvent OnJoyButtonUp = {read=FOnButtonUp, write=FOnButtonUp};
	__property System::Classes::TNotifyEvent OnInitError = {read=FOnInitError, write=FOnInitError};
	__property OnChange;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdjoy */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDJOY)
using namespace Lmdjoy;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdjoyHPP
