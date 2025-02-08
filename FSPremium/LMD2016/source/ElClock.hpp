// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElClock.pas' rev: 31.00 (Windows)

#ifndef ElclockHPP
#define ElclockHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <Vcl.Menus.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDProcs.hpp>
#include <LMDObjectList.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDDateUtils.hpp>
#include <LMDGraph.hpp>
#include <ElVCLUtils.hpp>
#include <ElPanel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Forms.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elclock
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElClockHand;
class DELPHICLASS TElClock;
struct TShortTZ;
struct TTimeZoneInfo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElClockMode : unsigned char { cmAnalog, cmDigital };

enum DECLSPEC_DENUM TElClockStyle : unsigned char { csSimple, csWin95 };

class PASCALIMPLEMENTATION TElClockHand : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Uitypes::TColor FColor;
	System::Classes::TNotifyEvent FOnChange;
	System::Byte FThick;
	bool FVisible;
	void __fastcall SetColor(System::Uitypes::TColor aColor);
	void __fastcall SetThickness(System::Byte aValue);
	void __fastcall SetVisible(bool aBool);
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall TElClockHand(void);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property System::Byte Thickness = {read=FThick, write=SetThickness, default=2};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElClockHand(void) { }
	
};


class PASCALIMPLEMENTATION TElClock : public Elpanel::TElPanel
{
	typedef Elpanel::TElPanel inherited;
	
protected:
	Vcl::Graphics::TBitmap* FMemBitmap;
	bool FNeedBmpPaint;
	bool FTimerPaused;
	System::TDateTime FStartTime;
	System::TDateTime FPauseTime;
	bool FIsTimer;
	bool FTimerActive;
	bool FShowDate;
	bool FShowHint;
	Vcl::Extctrls::TTimer* FTimer;
	_TIME_ZONE_INFORMATION FTZone;
	bool FLocal;
	bool FSeconds;
	bool FAMPM;
	System::UnicodeString FCaption;
	bool FUseBias;
	int FBias;
	bool FShowWeekDay;
	bool FUseCustomFormat;
	System::UnicodeString FCustomFormat;
	bool FShowDaysInTimer;
	bool FCountdownActive;
	System::Classes::TNotifyEvent FOnCountdownDone;
	System::Classes::TNotifyEvent FOnCountdownTick;
	bool FCountdownPaused;
	int FCountdownTime;
	int FSaveCDTime;
	bool FIsCountdown;
	Lmdtypes::TLMDString FDummyStr;
	TElClockMode FClockMode;
	bool FIsPainting;
	TElClockHand* FHourHand;
	TElClockHand* FMinuteHand;
	TElClockHand* FSecondHand;
	int FSecMode;
	int FOldSec;
	Vcl::Graphics::TPen* FCirclePen;
	bool FShowSecCircle;
	TElClockStyle FStyle;
	System::StaticArray<System::Uitypes::TColor, 4> FFaceColors;
	System::TDateTime FDT;
	bool FResizing;
	virtual void __fastcall Loaded(void);
	void __fastcall SetCirclePen(Vcl::Graphics::TPen* Value);
	void __fastcall SetShowSeconds(bool Value);
	void __fastcall GetChange(System::TObject* Sender);
	System::Uitypes::TColor __fastcall GetFaceColors(int anIndex);
	void __fastcall SetFaceColors(int anIndex, System::Uitypes::TColor aColor);
	void __fastcall SetIsCountdown(bool newValue);
	void __fastcall SetCountdownTime(int newValue);
	void __fastcall SetCountdownPaused(bool newValue);
	void __fastcall SetCountdownActive(bool newValue);
	void __fastcall SetShowDaysInTimer(bool newValue);
	void __fastcall SetUseCustomFormat(bool newValue);
	void __fastcall SetCustomFormat(System::UnicodeString newValue);
	void __fastcall SetShowWeekDay(bool newValue);
	void __fastcall SetUseBias(bool newValue);
	void __fastcall SetBias(int newValue);
	bool __fastcall GetTimer(void);
	void __fastcall SetTimer(bool value);
	void __fastcall OnTimer(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMEnterSizeMove(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMExitSizeMove(Winapi::Messages::TMessage &Message);
	void __fastcall SetShowDate(bool newValue);
	HIDESBASE void __fastcall SetShowHint(bool newValue);
	void __fastcall SetIsTimer(bool newValue);
	System::TDateTime __fastcall GetTimeElapsed(void);
	void __fastcall SetTimerActive(bool newValue);
	void __fastcall SetTimerPaused(bool newValue);
	void __fastcall CreateTimer(void);
	void __fastcall PaintBorders(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R);
	virtual void __fastcall Paint(void);
	void __fastcall DigitalPaint(void);
	void __fastcall PaintHands(Vcl::Graphics::TBitmap* ABitmap);
	void __fastcall AnalogPaint(void);
	void __fastcall PaintSmallScale(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TPoint &p1, const System::Types::TPoint &p2);
	void __fastcall PaintNormalScale(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TPoint &p1, const System::Types::TPoint &p2);
	void __fastcall InheritedPaint(void);
	virtual void __fastcall TriggerCountdownDoneEvent(void);
	virtual void __fastcall TriggerCountdownTickEvent(void);
	void __fastcall SetStyle(TElClockStyle Value);
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall SetClockMode(TElClockMode Value);
	
public:
	__fastcall virtual TElClock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElClock(void);
	virtual void __fastcall Kick(void);
	virtual void __fastcall GetTime(_SYSTEMTIME &Time);
	void __fastcall ResetTimer(void);
	__property System::TDateTime TimeElapsed = {read=GetTimeElapsed};
	__property _TIME_ZONE_INFORMATION TimeZone = {read=FTZone, write=FTZone};
	__property System::TDateTime DT = {read=FDT};
	
__published:
	__property Lmdtypes::TLMDString Caption = {read=FDummyStr};
	__property bool LocalTime = {read=FLocal, write=FLocal, default=1};
	__property bool ShowWeekDay = {read=FShowWeekDay, write=SetShowWeekDay, default=0};
	__property bool ShowSeconds = {read=FSeconds, write=SetShowSeconds, default=1};
	__property bool ShowDate = {read=FShowDate, write=SetShowDate, default=0};
	__property bool AM_PM = {read=FAMPM, write=FAMPM, default=0};
	__property bool Labels = {read=FShowHint, write=SetShowHint, default=0};
	__property bool UseBias = {read=FUseBias, write=SetUseBias, default=0};
	__property int Bias = {read=FBias, write=SetBias, default=0};
	__property bool UseCustomFormat = {read=FUseCustomFormat, write=SetUseCustomFormat, default=0};
	__property System::UnicodeString CustomFormat = {read=FCustomFormat, write=SetCustomFormat};
	__property bool ShowSecCircle = {read=FShowSecCircle, write=FShowSecCircle, default=0};
	__property TElClockMode ClockMode = {read=FClockMode, write=SetClockMode, default=1};
	__property TElClockStyle ClockStyle = {read=FStyle, write=SetStyle, default=1};
	__property bool IsTimer = {read=FIsTimer, write=SetIsTimer, default=0};
	__property bool TimerActive = {read=FTimerActive, write=SetTimerActive, default=0};
	__property bool TimerPaused = {read=FTimerPaused, write=SetTimerPaused, default=0};
	__property bool ShowDaysInTimer = {read=FShowDaysInTimer, write=SetShowDaysInTimer, default=0};
	__property bool IsCountdown = {read=FIsCountdown, write=SetIsCountdown, default=0};
	__property int CountdownTime = {read=FCountdownTime, write=SetCountdownTime, default=0};
	__property bool CountdownActive = {read=FCountdownActive, write=SetCountdownActive, default=0};
	__property bool CountdownPaused = {read=FCountdownPaused, write=SetCountdownPaused, default=0};
	__property bool UseTimer = {read=GetTimer, write=SetTimer, default=1};
	__property System::Classes::TNotifyEvent OnCountdownDone = {read=FOnCountdownDone, write=FOnCountdownDone};
	__property System::Classes::TNotifyEvent OnCountdownTick = {read=FOnCountdownTick, write=FOnCountdownTick};
	__property System::Uitypes::TColor ColorSmallTick = {read=GetFaceColors, write=SetFaceColors, index=0, default=16777215};
	__property System::Uitypes::TColor ColorSmallTickShade = {read=GetFaceColors, write=SetFaceColors, index=1, default=-16777200};
	__property System::Uitypes::TColor ColorBigTick = {read=GetFaceColors, write=SetFaceColors, index=2, default=16776960};
	__property System::Uitypes::TColor ColorBigTickShade = {read=GetFaceColors, write=SetFaceColors, index=3, default=0};
	__property TElClockHand* HourHand = {read=FHourHand, write=FHourHand, stored=true};
	__property TElClockHand* MinuteHand = {read=FMinuteHand, write=FMinuteHand, stored=true};
	__property TElClockHand* SecondHand = {read=FSecondHand, write=FSecondHand, stored=true};
	__property Vcl::Graphics::TPen* SecondCircle = {read=FCirclePen, write=SetCirclePen};
	__property Align;
	__property Alignment = {default=2};
	__property BevelInner = {default=1};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BorderWidth = {default=0};
	__property BorderStyle = {default=0};
	__property Color = {default=-16777201};
	__property Ctl3D;
	__property Cursor = {default=0};
	__property Font;
	__property Hint;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property OnClick;
	__property OnDblClick;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnDragOver;
	__property OnDragDrop;
	__property OnEndDrag;
	__property OnStartDrag;
	__property OnResize;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered = {default=0};
	__property DragKind = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElClock(HWND ParentWindow) : Elpanel::TElPanel(ParentWindow) { }
	
};


typedef TShortTZ *PShortTZ;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TShortTZ
{
public:
	int Bias;
	int StandardBias;
	int DayLightBias;
	System::Word wReserved1;
	System::Word StdMonth;
	System::Word StdDayOfWeek;
	System::Word StdDay;
	System::Word StdHour;
	System::Word StdMinute;
	System::Word StdSecond;
	System::Word wReserved2;
	System::Word wReserved3;
	System::Word DLMonth;
	System::Word DLDayOfWeek;
	System::Word DLDay;
	System::Word DLHour;
	System::Word DLMinute;
	System::Word DLSecond;
	System::Word wReserved4;
};
#pragma pack(pop)


typedef TTimeZoneInfo *PTimeZoneInfo;

struct DECLSPEC_DRECORD TTimeZoneInfo
{
public:
	System::UnicodeString KeyName;
	System::UnicodeString DisplayName;
	System::UnicodeString DltName;
	System::UnicodeString StdName;
	System::UnicodeString MapID;
	_TIME_ZONE_INFORMATION TimeZone;
	TShortTZ STimeZone;
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool FDL;
extern DELPHI_PACKAGE Lmdobjectlist::TLMDObjectList* SysTimeZones;
extern DELPHI_PACKAGE void __fastcall ShortTZToTimeZoneInfo(const TShortTZ &ShortTZ, TTimeZoneInfo &TZInfo);
extern DELPHI_PACKAGE System::UnicodeString __fastcall TranslateTZDate(const _SYSTEMTIME &ADate);
extern DELPHI_PACKAGE bool __fastcall RetrieveTimeZoneInfo(Lmdobjectlist::TLMDObjectList* TimeZoneInfoList);
}	/* namespace Elclock */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCLOCK)
using namespace Elclock;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElclockHPP
