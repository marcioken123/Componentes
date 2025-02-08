// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDClass.pas' rev: 34.00 (Windows)

#ifndef LmdclassHPP
#define LmdclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <LMDObject.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDProcs.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdclass
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDApplication;
class DELPHICLASS TLMDTimer;
class DELPHICLASS TLMDTimerItem;
class DELPHICLASS TLMDTimerPool;
class DELPHICLASS ELMDOneInstError;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDThemeMode : unsigned char { ttmNone, ttmPlatform, ttmNative };

enum DECLSPEC_DENUM TLMDColorScheme : unsigned char { csBlue, csMetallic, csHomestead, csBlack, csVistaBasic, csCustom, csDefaultScheme, csUnknown };

typedef System::StaticArray<System::UnicodeString, 8> Lmdclass__1;

typedef Lmdtypes::TLMDString TLMDHTMLString;

typedef System::UnicodeString TLMDDateTimeFormat;

enum DECLSPEC_DENUM TLMDDlgPosRel : unsigned char { brScreen, brScreenWorkArea, brMainForm, brActiveWindow };

enum DECLSPEC_DENUM TLMDDlgPosition : unsigned char { bpCustom, bpTopLeft, bpTopCenter, bpTopRight, bpCenterLeft, bpCenter, bpCenterRight, bpBottomLeft, bpBottomCenter, bpBottomRight };

enum DECLSPEC_DENUM TLMDBoundsChangeState : unsigned char { bcSize, bcPos };

typedef System::Set<TLMDBoundsChangeState, TLMDBoundsChangeState::bcSize, TLMDBoundsChangeState::bcPos> TLMDBoundsChangeStates;

enum DECLSPEC_DENUM TLMDDockPosition : unsigned char { dpBottom, dpLeft, dpRight, dpTop };

enum DECLSPEC_DENUM TLMDDlgEffect : unsigned char { deNone, deExplode, deExplodeExt };

enum DECLSPEC_DENUM TLMDTimerMode : unsigned char { tmNormal, tmGlobalTimer, tmHiTimer, tmThreaded };

enum DECLSPEC_DENUM TLMDCharCase : unsigned char { ccNormal, ccLowerCase, ccUpperCase };

enum DECLSPEC_DENUM TLMDApplicationOption : unsigned char { aoAutoRealizePalette, aoMouseCtrlActive, aoLogAlwaysClear, aoLogException, aoLogHeader, aoLogNr, aoLogTime, aoLogDate };

typedef System::Set<TLMDApplicationOption, TLMDApplicationOption::aoAutoRealizePalette, TLMDApplicationOption::aoLogDate> TLMDApplicationOptions;

enum DECLSPEC_DENUM TLMDLogAction : unsigned char { laNone, laClearLog, laBackupLog };

typedef void __fastcall (__closure *TLMDExceptionEvent)(System::TObject* Sender, System::Sysutils::Exception* E, bool &Cancel);

typedef void __fastcall (__closure *TLMDMaxLogSizeEvent)(System::TObject* Sender, const System::UnicodeString LogName, bool &Cancel);

typedef void __fastcall (__closure *TLMDOnHeaderWrite)(System::TObject* Sender, System::Classes::TStringList* const Target);

enum DECLSPEC_DENUM TLMDExitCode : unsigned char { ecQuit, ecReboot, ecRestart };

enum DECLSPEC_DENUM TLMDEditMode : unsigned char { emInsert, emShift, emCtrl, emAlt, emCaps, emNum, emScroll };

typedef System::Set<TLMDEditMode, TLMDEditMode::emInsert, TLMDEditMode::emScroll> TLMDEditModes;

class PASCALIMPLEMENTATION TLMDApplication : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FForceAnsi;
	System::UnicodeString FMask;
	System::UnicodeString FCompany;
	System::UnicodeString FVersion;
	TLMDApplicationOptions FOptions;
	Lmdinictrl::TLMDIniCtrl* FIniCtrl;
	TLMDEditModes FEditMode;
	System::Classes::TNotifyEvent FOnEditModeChange;
	System::Byte FEffectDelay;
	Vcl::Graphics::TBitmap* FMonoPattern;
	Vcl::Graphics::TBitmap* FPatternBitmap;
	System::Uitypes::TColor FLastColor;
	TLMDTimerPool* FTimerPool;
	Lmdprocs::TLMDPathPrefix FLogPrefix;
	System::UnicodeString FLogName;
	int FLogMaxSize;
	System::Byte FUpdate;
	int FCounter;
	TLMDLogAction FlogAction;
	TLMDMaxLogSizeEvent FOnMaxLogSize;
	TLMDOnHeaderWrite FOnHeaderWrite;
	__int64 FTimerFrequency;
	__int64 FStartTime;
	Vcl::Graphics::TBitmap* FCheckBitmap;
	System::TObject* FMsgBoxStyle;
	NativeUInt FMHandle;
	bool FIsPrevRunning;
	NativeUInt FPreviouseAppWin;
	TLMDExceptionEvent FOnException;
	int FCheckHeight;
	int FCheckWidth;
	bool FLMDOnly;
	bool FUseXPThemes;
	bool FManifest;
	bool FThemeUseColorProperty;
	TLMDThemeMode FGlobalThemeMode;
	bool __fastcall GetXPThemesSupported();
	bool __fastcall GetUseXPThemes();
	void __fastcall SetXPThemeSupport(bool aValue);
	void __fastcall SetXPLMDOnly(bool aValue);
	void __fastcall SetThemeUseColorProperty(const bool Value);
	void __fastcall SetGlobalThemeMode(const TLMDThemeMode Value);
	bool __fastcall GetThemeModeSupported(TLMDThemeMode index);
	int __fastcall GetCheckCustomWidth();
	int __fastcall GetCheckCustomHeight();
	void __fastcall SetCheckBitmap(Vcl::Graphics::TBitmap* aValue);
	Lmdtypes::TLMDString __fastcall GetUnicodeTitle();
	void __fastcall SetUnicodeTitle(const Lmdtypes::TLMDString Value);
	void __fastcall SetLogPrefix(Lmdprocs::TLMDPathPrefix aValue);
	void __fastcall SetLogName(const System::UnicodeString aValue);
	void __fastcall SetEditMode(TLMDEditModes aValue);
	Vcl::Graphics::TBitmap* __fastcall GetBitmap();
	TLMDTimerItem* __fastcall GetTimer(System::Word Ident);
	System::Word __fastcall GetTimerIdent();
	System::Extended __fastcall GetTimerFrequency();
	void __fastcall FindPreviousInstance();
	
public:
	__fastcall virtual TLMDApplication(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDApplication();
	void __fastcall DoThemeChange();
	System::Word __fastcall AddTimer(System::Word wInterval, System::Classes::TNotifyEvent CallProc);
	System::Word __fastcall AddTimerExt(System::Word wInterval, int iCallCount, bool bEnabled, System::Classes::TNotifyEvent CallProc);
	void __fastcall RemoveTimer(System::Word Ident);
	void __fastcall STWStart();
	int __fastcall STWStop();
	System::Extended __fastcall STWStopExt();
	Vcl::Graphics::TBitmap* __fastcall GetBrushBitmap(System::Uitypes::TColor aColor);
	System::UnicodeString __fastcall GetDefaultRegPath();
	bool __fastcall QuitWindows(TLMDExitCode aValue);
	__property bool IsPrevRunning = {read=FIsPrevRunning, nodefault};
	__property NativeUInt PreviouseAppWin = {read=FPreviouseAppWin, nodefault};
	void __fastcall HandleException(System::TObject* Sender, System::Sysutils::Exception* E);
	void __fastcall LogException(System::TObject* Sender);
	void __fastcall LogWrite(const System::UnicodeString aValue);
	__property Vcl::Graphics::TBitmap* CheckBitmap = {read=FCheckBitmap, write=SetCheckBitmap};
	__property int CheckCustomWidth = {read=GetCheckCustomWidth, nodefault};
	__property int CheckCustomHeight = {read=GetCheckCustomHeight, nodefault};
	__property System::UnicodeString Company = {read=FCompany, write=FCompany};
	__property System::Byte DlgEffectDelay = {read=FEffectDelay, write=FEffectDelay, nodefault};
	__property Lmdinictrl::TLMDIniCtrl* Ini = {read=FIniCtrl};
	__property System::TObject* MsgBox = {read=FMsgBoxStyle, write=FMsgBoxStyle};
	__property TLMDEditModes EditMode = {read=FEditMode, write=SetEditMode, default=1};
	__property System::Classes::TNotifyEvent OnEditModeChange = {read=FOnEditModeChange, write=FOnEditModeChange};
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetXPThemeSupport, nodefault};
	__property bool UseXPThemesLMDOnly = {read=FLMDOnly, write=SetXPLMDOnly, nodefault};
	__property bool XPThemesSupported = {read=GetXPThemesSupported, nodefault};
	__property bool XPManifestAvailable = {read=FManifest, write=FManifest, nodefault};
	__property bool ThemeSupported[TLMDThemeMode index] = {read=GetThemeModeSupported};
	__property Lmdtypes::TLMDString UnicodeTitle = {read=GetUnicodeTitle, write=SetUnicodeTitle};
	__property int LogMaxsize = {read=FLogMaxSize, write=FLogMaxSize, nodefault};
	__property TLMDLogAction LogMaxAction = {read=FlogAction, write=FlogAction, nodefault};
	__property System::UnicodeString LogName = {read=FLogName, write=SetLogName};
	__property Lmdprocs::TLMDPathPrefix LogPrefix = {read=FLogPrefix, write=SetLogPrefix, nodefault};
	__property System::UnicodeString LogMask = {read=FMask, write=FMask};
	__property Vcl::Graphics::TBitmap* PatternBitmap = {read=GetBitmap};
	__property TLMDApplicationOptions Options = {read=FOptions, write=FOptions, nodefault};
	__property TLMDTimerItem* Timer[System::Word Ident] = {read=GetTimer};
	__property TLMDTimerPool* Timers = {read=FTimerPool};
	__property System::UnicodeString Version = {read=FVersion, write=FVersion};
	__property System::Extended TimerFrequency = {read=GetTimerFrequency};
	__property int CheckDefWidth = {read=FCheckWidth, nodefault};
	__property int CheckDefHeight = {read=FCheckHeight, nodefault};
	__property TLMDExceptionEvent OnException = {read=FOnException, write=FOnException};
	__property TLMDMaxLogSizeEvent OnMaxLogSize = {read=FOnMaxLogSize, write=FOnMaxLogSize};
	__property TLMDOnHeaderWrite OnHeaderWrite = {read=FOnHeaderWrite, write=FOnHeaderWrite};
	__property bool ThemeUseColorProperty = {read=FThemeUseColorProperty, write=SetThemeUseColorProperty, nodefault};
	__property TLMDThemeMode ThemeGlobalMode = {read=FGlobalThemeMode, write=SetGlobalThemeMode, nodefault};
	__property bool ForceANSI = {read=FForceAnsi, write=FForceAnsi, nodefault};
};


class PASCALIMPLEMENTATION TLMDTimer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Vcl::Extctrls::TTimer* FTimer;
	System::Word FTimerID;
	bool FGlobalTimer;
	bool FEnabled;
	System::Word FInterval;
	System::Classes::TNotifyEvent FOnTimer;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetGlobal(const bool Value);
	void __fastcall SetInterval(const System::Word Value);
	void __fastcall RemoveTimer();
	void __fastcall UpdateTimer();
	
protected:
	void __fastcall Timer(System::TObject* Sender);
	
public:
	__fastcall TLMDTimer(System::Word gInterval, System::Classes::TNotifyEvent gTimer, bool gEnabled, bool gmode);
	__fastcall virtual ~TLMDTimer();
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property System::Word Interval = {read=FInterval, write=SetInterval, nodefault};
	__property bool GlobalMode = {read=FGlobalTimer, write=SetGlobal, nodefault};
	__property System::Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=FOnTimer};
};


class PASCALIMPLEMENTATION TLMDTimerItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FCallCount;
	int FCounter;
	bool FEnabled;
	System::Word FIdent;
	System::Word FInterval;
	int FInternal;
	System::Classes::TList* FList;
	TLMDTimerPool* FOwner;
	System::Classes::TNotifyEvent FOnTimer;
	void __fastcall SetCallCount(int aValue);
	void __fastcall SetEnabled(bool aValue);
	void __fastcall SetInterval(System::Word aValue);
	
public:
	__fastcall TLMDTimerItem(TLMDTimerPool* aOwner, System::Classes::TList* aList, System::Word aIndex);
	__fastcall virtual ~TLMDTimerItem();
	void __fastcall Timer();
	__property int CallCount = {read=FCallCount, write=SetCallCount, nodefault};
	__property int Counter = {read=FCounter, nodefault};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property System::Word Interval = {read=FInterval, write=SetInterval, nodefault};
	__property System::Word Ident = {read=FIdent, nodefault};
	__property int HitValue = {read=FInternal, nodefault};
	__property System::Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=FOnTimer};
};


typedef System::Word TLMDTimerInterval;

typedef void __fastcall (__closure *TLMDTimerPoolEvent)(System::TObject* Sender, System::Word Ident, int Counter);

class PASCALIMPLEMENTATION TLMDTimerPool : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
public:
	TLMDTimerItem* operator[](System::Word Ident) { return this->Timer[Ident]; }
	
private:
	bool FActive;
	bool FFLag;
	HWND FHWND;
	int FPCounter;
	TLMDTimerInterval FInterval;
	System::Classes::TList* FList;
	System::Byte FUpdate;
	TLMDTimerPoolEvent FOnTimerEvent;
	void __fastcall SetInterval(TLMDTimerInterval aValue);
	int __fastcall GetActiveTimers();
	int __fastcall GetCount();
	TLMDTimerItem* __fastcall GetTimer(System::Word Ident);
	void __fastcall HandleTimers();
	void __fastcall UpdateMainTimer(bool aValue);
	void __fastcall WndProc(Winapi::Messages::TMessage &Msg);
	void __fastcall InitAttributes();
	
public:
	__fastcall virtual TLMDTimerPool(System::Classes::TComponent* AOwner);
	__fastcall TLMDTimerPool(System::Classes::TComponent* aOwner, TLMDTimerInterval MinInterval);
	__fastcall virtual ~TLMDTimerPool();
	int __fastcall AddTimer(System::Word Ident, System::Word wInterval, System::Classes::TNotifyEvent CallProc);
	int __fastcall AddTimerExt(System::Word Ident, System::Word wInterval, int iCallCount, bool bEnabled, System::Classes::TNotifyEvent CallProc);
	void __fastcall ClearTimers();
	bool __fastcall HasTimerProc();
	int __fastcall IndexOf(System::Word Ident);
	void __fastcall RemoveTimer(System::Word Ident);
	__property int ActiveTimers = {read=GetActiveTimers, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDTimerItem* Timer[System::Word Ident] = {read=GetTimer/*, default*/};
	
__published:
	__property About = {default=0};
	__property TLMDTimerInterval MinInterval = {read=FInterval, write=SetInterval, default=1000};
	__property TLMDTimerPoolEvent OnTimer = {read=FOnTimerEvent, write=FOnTimerEvent};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDOneInstError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	__fastcall ELMDOneInstError(const System::UnicodeString cName, System::Byte aValue);
public:
	/* Exception.CreateFmt */ inline __fastcall ELMDOneInstError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDOneInstError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDOneInstError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDOneInstError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDOneInstError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDOneInstError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDOneInstError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDOneInstError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDOneInstError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDOneInstError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDOneInstError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDOneInstError() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::WideChar IDS_DEFAULTDELIMITER;
static const System::Int8 LMD_DEFINTERVAL = System::Int8(0x32);
#define LMD_DEFAULTFONT L"Arial"
#define IDS_INTERNAL L"Internal"
#define IDS_CTLXP L"CtlXP"
static const System::Word CM_LMDPROPCHANGE = System::Word(0xb12d);
static const System::Word CM_LMDCOLDESTROY = System::Word(0xb12e);
static const System::Word CM_DEVICECHANGE = System::Word(0xb12f);
static const System::Word CM_TRANSPARENTCHANGED = System::Word(0xb0cd);
static const System::Word CM_LMDBACKCHANGED = System::Word(0xb0ce);
static const System::Word CM_LMDAFTERENTER = System::Word(0xb0cf);
static const System::Word CM_LMDAFTEREXIT = System::Word(0xb0d0);
static const System::Word CM_LMDBEVELCHANGED = System::Word(0xb0d1);
static const System::Word CM_REDOCK = System::Word(0xb066);
static const System::Word CM_LMDDOCKED = System::Word(0xb0d2);
static const System::Word CM_LMDSCROLLBOXSCROLLEVENT = System::Word(0xb0d4);
static const System::Word CM_LMDTHEMECHANGED = System::Word(0xb0d6);
static const System::Word CM_LMDPARENTCTLXPCHANGED = System::Word(0xb0d8);
static const System::Word CM_LMDBOUNDLABELCHANGE = System::Word(0xb0d9);
extern DELPHI_PACKAGE Lmdclass__1 CBuiltInColorSchemes;
extern DELPHI_PACKAGE System::StaticArray<TLMDThemeMode, 2> LMDCtlXP;
extern DELPHI_PACKAGE TLMDApplication* LMDApplication;
extern DELPHI_PACKAGE bool __fastcall LMDCheckForSameClass(System::Classes::TComponent* aOwner, System::TClass aClass, bool AllowDataModule);
}	/* namespace Lmdclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCLASS)
using namespace Lmdclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdclassHPP
