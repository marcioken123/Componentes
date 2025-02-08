// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDClock.pas' rev: 31.00 (Windows)

#ifndef LmdclockHPP
#define LmdclockHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Forms.hpp>
#include <LMDConst.hpp>
#include <LMDLED.hpp>
#include <LMDObject.hpp>
#include <LMDGraph.hpp>
#include <LMDClass.hpp>
#include <LMDFillObject.hpp>
#include <LMDDateTime.hpp>
#include <LMDBase.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDGradientFrames.hpp>
#include <LMDFillers.hpp>
#include <LMDFigures.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdclock
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDClockHand;
class DELPHICLASS TLMDTimeInterval;
class DELPHICLASS TLMDTimeOffset;
class DELPHICLASS TLMDClock;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDClockMode : unsigned char { cmNormal, cmDate, cmStopwatch, cmCountdown, cmAlarm };

enum DECLSPEC_DENUM TLMDClockStyle : unsigned char { csSimple, csWin95, csVista, csWindows7 };

enum DECLSPEC_DENUM TLMDClockOption : unsigned char { coShowDigital, coShowAnalog, coEnableAlarm, co24Hour, coFixed, coOffset, coShowSecCircle };

typedef System::Set<TLMDClockOption, TLMDClockOption::coShowDigital, TLMDClockOption::coShowSecCircle> TLMDClockOptions;

class PASCALIMPLEMENTATION TLMDClockHand : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Uitypes::TColor FColor;
	TLMDClockStyle FStyle;
	System::Byte FThick;
	bool FVisible;
	void __fastcall SetColor(System::Uitypes::TColor aColor);
	void __fastcall SetThickness(System::Byte aValue);
	void __fastcall SetVisible(bool aBool);
	
public:
	__fastcall virtual TLMDClockHand(System::Classes::TPersistent* Owner);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property System::Byte Thickness = {read=FThick, write=SetThickness, default=2};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDClockHand(void) { }
	
};


class PASCALIMPLEMENTATION TLMDTimeInterval : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::StaticArray<System::Word, 3> FTimeInterval;
	bool FEnabled;
	System::TDateTime FEndTime;
	void __fastcall SetEnabled(bool aBool);
	void __fastcall SetEndtime(System::TDateTime aDatetime);
	void __fastcall SetTime(int anIndex, System::Word aWord);
	System::TDateTime __fastcall GetEndtime(void);
	System::Word __fastcall GetTime(int anIndex);
	
public:
	__fastcall virtual TLMDTimeInterval(System::Classes::TPersistent* Owner);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property System::TDateTime EndTime = {read=GetEndtime, write=SetEndtime, stored=FEnabled};
	__property System::Word Hour = {read=GetTime, write=SetTime, index=1, default=0};
	__property System::Word Minute = {read=GetTime, write=SetTime, index=2, default=1};
	__property System::Word Second = {read=GetTime, write=SetTime, index=3, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDTimeInterval(void) { }
	
};


class PASCALIMPLEMENTATION TLMDTimeOffset : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	int FDays;
	int FHours;
	int FMinutes;
	int FSeconds;
	
public:
	__fastcall virtual TLMDTimeOffset(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Offset(System::TDateTime &time);
	
__published:
	__property int Days = {read=FDays, write=FDays, default=0};
	__property int Hours = {read=FHours, write=FHours, default=0};
	__property int Minutes = {read=FMinutes, write=FMinutes, default=0};
	__property int Seconds = {read=FSeconds, write=FSeconds, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDTimeOffset(void) { }
	
};


enum DECLSPEC_DENUM TLMDClockFill : unsigned char { fmControl, fmClock };

class PASCALIMPLEMENTATION TLMDClock : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	bool FAlarm;
	bool First;
	Lmdled::TLMDLED* FDigital;
	bool FUseCustomDT;
	bool FDigitalOnly;
	bool FDigitalShowSecs;
	System::UnicodeString FDigitalString;
	TLMDClockHand* FHourHand;
	TLMDClockHand* FMinuteHand;
	TLMDClockHand* FSecondHand;
	Lmdclass::TLMDTimer* FTimerIdent;
	bool FIsPainting;
	System::TDateTime FAlarmtime;
	System::TDateTime FStopwatch;
	TLMDClockMode FClockMode;
	TLMDTimeInterval* FCountdown;
	bool FStopwatchEnabled;
	bool FStopwatchPaused;
	System::TDateTime FStopwatchPausedTime;
	System::TDateTime FStopwatchPauseStart;
	int FPosY;
	int FPosX;
	TLMDClockStyle FStyle;
	System::StaticArray<System::Uitypes::TColor, 5> FFaceColors;
	System::Uitypes::TColor FDigitalColor;
	TLMDClockOptions FOptions;
	Vcl::Graphics::TBitmap* FSaveBitmap;
	System::Word FRepeat;
	int FRepCount;
	Lmdclass::TLMDDateTimeFormat FDateTimeFormat;
	Lmddatetime::TLMDDateTime* FFixedTime;
	TLMDTimeOffset* FTimeOffset;
	Lmdfillobject::TLMDFillObject* FFillObject;
	TLMDClockFill FFillMode;
	Vcl::Graphics::TPen* FCirclePen;
	int FSecMode;
	int FOldSec;
	System::Classes::TNotifyEvent FOnAlarm;
	System::Classes::TNotifyEvent FOnCountdownStart;
	System::Classes::TNotifyEvent FOnCountdownEnd;
	System::Classes::TNotifyEvent FOnStopWatchStart;
	System::Classes::TNotifyEvent FOnStopWatchEnd;
	System::Classes::TNotifyEvent FOnStopWatchPause;
	System::Classes::TNotifyEvent FOnStopWatchResume;
	bool FUseGlobalTimer;
	Lmdclass::TLMDColorScheme FColorScheme;
	void __fastcall SetUseGlobalTimer(const bool Value);
	void __fastcall SetDateTimeFormat(Lmdclass::TLMDDateTimeFormat aValue);
	void __fastcall SetBoolean(int Index, bool aValue);
	void __fastcall SetClockOptions(TLMDClockOptions aSet);
	void __fastcall SetDigital(Lmdled::TLMDLED* aValue);
	void __fastcall SetFaceColors(int anIndex, System::Uitypes::TColor aColor);
	void __fastcall SetPos(int Index, int aValue);
	void __fastcall SetStyle(TLMDClockStyle aStyle);
	void __fastcall SetMode(TLMDClockMode aMode);
	void __fastcall SetFixed(Lmddatetime::TLMDDateTime* aValue);
	void __fastcall SetOffset(TLMDTimeOffset* aValue);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	void __fastcall SetFillMode(TLMDClockFill aValue);
	void __fastcall SetCirclePen(Vcl::Graphics::TPen* aValue);
	System::Uitypes::TColor __fastcall GetFaceColors(int anIndex);
	bool __fastcall CorrectBounds(void);
	void __fastcall PaintAnalog(Vcl::Graphics::TCanvas* ACanvas);
	void __fastcall PaintDigital(Vcl::Graphics::TCanvas* ACanvas);
	void __fastcall PaintHands(Vcl::Graphics::TCanvas* ACanvas);
	void __fastcall PaintSmallScale(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TPoint &p1, const System::Types::TPoint &p2);
	void __fastcall PaintNormalScale(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TPoint &p1, const System::Types::TPoint &p2);
	void __fastcall PaintHourNumber(Vcl::Graphics::TCanvas* ACanvas, int x, int y, double cs, double sn, int r, int aHour);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetColorScheme(const Lmdclass::TLMDColorScheme Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDigitalText(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	virtual System::TDateTime __fastcall GetTime(void);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	void __fastcall OnTimer(System::TObject* Sender);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDClock(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDClock(void);
	virtual void __fastcall BackUpdate(void);
	virtual void __fastcall Alarm(void);
	void __fastcall EndAlarm(void);
	void __fastcall StartStpWatch(void);
	void __fastcall EndStpWatch(void);
	void __fastcall PauseStpWatch(void);
	void __fastcall ResumeStpWatch(void);
	void __fastcall StartCountdown(void);
	void __fastcall EndCountdown(void);
	__property System::TDateTime Alarmtime = {read=FAlarmtime, write=FAlarmtime};
	__property TLMDTimeInterval* Countdown = {read=FCountdown, write=FCountdown};
	__property System::TDateTime StopwatchPausedTime = {read=FStopwatchPausedTime};
	
__published:
	__property About = {default=0};
	__property Bevel;
	__property Color = {default=-16777211};
	__property Lmdclass::TLMDColorScheme ColorScheme = {read=FColorScheme, write=SetColorScheme, default=6};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=SetUseGlobalTimer, default=0};
	__property System::Uitypes::TColor ColorSmallTick = {read=GetFaceColors, write=SetFaceColors, index=0, default=16777215};
	__property System::Uitypes::TColor ColorSmallTickShade = {read=GetFaceColors, write=SetFaceColors, index=1, default=-16777201};
	__property System::Uitypes::TColor ColorBigTick = {read=GetFaceColors, write=SetFaceColors, index=2, default=8421376};
	__property System::Uitypes::TColor ColorBigTickShade = {read=GetFaceColors, write=SetFaceColors, index=3, default=16776960};
	__property System::Uitypes::TColor ColorBigTickLight = {read=GetFaceColors, write=SetFaceColors, index=4, default=0};
	__property Lmdled::TLMDLED* Digital = {read=FDigital, write=SetDigital};
	__property System::Uitypes::TColor DigitalColor = {read=GetFaceColors, write=SetFaceColors, index=5, default=0};
	__property bool DigitalOnly = {read=FDigitalOnly, write=SetBoolean, index=0, default=0};
	__property bool DigitalShowSecs = {read=FDigitalShowSecs, write=SetBoolean, index=1, default=1};
	__property int DigitalPosX = {read=FPosX, write=SetPos, index=0, default=-1};
	__property int DigitalPosY = {read=FPosY, write=SetPos, index=1, default=-1};
	__property Enabled = {default=1};
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property TLMDClockFill FillMode = {read=FFillMode, write=SetFillMode, default=0};
	__property Lmddatetime::TLMDDateTime* FixedTime = {read=FFixedTime, write=SetFixed};
	__property TLMDClockHand* HourHand = {read=FHourHand, write=FHourHand};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property TLMDClockHand* MinuteHand = {read=FMinuteHand, write=FMinuteHand};
	__property TLMDClockMode Mode = {read=FClockMode, write=SetMode, default=0};
	__property TLMDClockOptions Options = {read=FOptions, write=SetClockOptions, default=10};
	__property System::Word RepeatAlarm = {read=FRepeat, write=FRepeat, default=10};
	__property TLMDClockHand* SecondHand = {read=FSecondHand, write=FSecondHand};
	__property Vcl::Graphics::TPen* SecondCircle = {read=FCirclePen, write=SetCirclePen};
	__property System::TDateTime Stopwatch = {read=FStopwatch};
	__property TLMDClockStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property TLMDTimeOffset* TimeOffset = {read=FTimeOffset, write=SetOffset};
	__property Transparent;
	__property Lmdclass::TLMDDateTimeFormat CustomDateTimeFormat = {read=FDateTimeFormat, write=SetDateTimeFormat};
	__property bool UseCustomDateTime = {read=FUseCustomDT, write=SetBoolean, index=2, default=0};
	__property System::Classes::TNotifyEvent OnAlarm = {read=FOnAlarm, write=FOnAlarm};
	__property System::Classes::TNotifyEvent OnCountdownStart = {read=FOnCountdownStart, write=FOnCountdownStart};
	__property System::Classes::TNotifyEvent OnCountdownEnd = {read=FOnCountdownEnd, write=FOnCountdownEnd};
	__property System::Classes::TNotifyEvent OnStopWatchStart = {read=FOnStopWatchStart, write=FOnStopWatchStart};
	__property System::Classes::TNotifyEvent OnStopWatchEnd = {read=FOnStopWatchEnd, write=FOnStopWatchEnd};
	__property System::Classes::TNotifyEvent OnStopWatchPause = {read=FOnStopWatchPause, write=FOnStopWatchPause};
	__property System::Classes::TNotifyEvent OnStopWatchResume = {read=FOnStopWatchResume, write=FOnStopWatchResume};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property OnEndDock;
	__property OnStartDock;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdclock */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCLOCK)
using namespace Lmdclock;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdclockHPP
