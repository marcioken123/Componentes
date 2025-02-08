// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDApplicationCtrl.pas' rev: 31.00 (Windows)

#ifndef LmdapplicationctrlHPP
#define LmdapplicationctrlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.ActnList.hpp>
#include <LMDProcs.hpp>
#include <LMDClass.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdapplicationctrl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDApplicationCtrl;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSystemOption : unsigned char { soSetHintFont, soSetIconFont, soSetMenuFont };

typedef System::Set<TLMDSystemOption, TLMDSystemOption::soSetHintFont, TLMDSystemOption::soSetMenuFont> TLMDSystemOptions;

class PASCALIMPLEMENTATION TLMDApplicationCtrl : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	System::UnicodeString FCompany;
	System::UnicodeString FVersion;
	Vcl::Graphics::TBitmap* FCheckBitmap;
	Lmdclass::TLMDApplicationOptions FOptions;
	System::UnicodeString FLogName;
	Lmdprocs::TLMDPathPrefix FLogPrefix;
	int FLogMaxSize;
	Lmdclass::TLMDLogAction FLogAction;
	Lmdclass::TLMDMaxLogSizeEvent FMaxLogSize;
	Lmdclass::TLMDOnHeaderWrite FOnHeaderWrite;
	System::Byte FEffectDelay;
	System::UnicodeString FIniFile;
	System::UnicodeString FRegPath;
	Lmdprocs::TLMDPathPrefix FIniPrefix;
	Lmdinictrl::TLMDRegRootKey FRootKey;
	Lmdinictrl::TLMDIniTarget FHTarget;
	Lmdclass::TLMDExceptionEvent FOnException;
	System::UnicodeString FTitle;
	System::Sysutils::TFileName FHelpFile;
	System::Uitypes::TColor FHintColor;
	int FHintPause;
	int FHintHidePause;
	int FHintShortPause;
	bool FShowHint;
	bool FUpdateMetricSettings;
	bool FUpdateFormatSettings;
	Vcl::Graphics::TPicture* FPicture;
	System::Classes::TActionEvent FOnActionExecute;
	System::Classes::TActionEvent FOnActionUpdate;
	Vcl::Graphics::TFont* FHintFont;
	Vcl::Graphics::TFont* FIconFont;
	Vcl::Graphics::TFont* FMenuFont;
	TLMDSystemOptions FSystemOptions;
	System::Classes::TNotifyEvent FOnActiveFormChange;
	System::Classes::TNotifyEvent FOnActiveControlChange;
	System::Classes::TNotifyEvent FOnHint;
	System::Classes::TNotifyEvent FOnActivate;
	System::Classes::TNotifyEvent FOnDeactivate;
	System::Classes::TNotifyEvent FOnRestore;
	System::Classes::TNotifyEvent FOnEditModeChange;
	System::Classes::TNotifyEvent FOnMinimize;
	Vcl::Forms::TShowHintEvent FOnShowHint;
	Vcl::Forms::TMessageEvent FOnMessage;
	Vcl::Forms::THelpEvent FOnHelp;
	Vcl::Forms::TIdleEvent FOnIdle;
	void __fastcall SetCheckBitmap(Vcl::Graphics::TBitmap* aValue);
	void __fastcall SetIcon(Vcl::Graphics::TIcon* aValue);
	void __fastcall SetFont(int index, Vcl::Graphics::TFont* aValue);
	Vcl::Graphics::TIcon* __fastcall GetIcon(void);
	void __fastcall SetLogName(const System::UnicodeString aValue);
	
protected:
	virtual void __fastcall Loaded(void);
	void __fastcall DoEditModeChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDApplicationCtrl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDApplicationCtrl(void);
	
__published:
	__property About = {default=0};
	__property Vcl::Graphics::TBitmap* CheckBitmap = {read=FCheckBitmap, write=SetCheckBitmap};
	__property System::UnicodeString Company = {read=FCompany, write=FCompany};
	__property Lmdclass::TLMDApplicationOptions Options = {read=FOptions, write=FOptions, default=54};
	__property System::UnicodeString Version = {read=FVersion, write=FVersion};
	__property Lmdclass::TLMDLogAction LogMaxAction = {read=FLogAction, write=FLogAction, default=0};
	__property int LogMaxsize = {read=FLogMaxSize, write=FLogMaxSize, default=-1};
	__property Lmdprocs::TLMDPathPrefix LogPrefix = {read=FLogPrefix, write=FLogPrefix, default=2};
	__property System::UnicodeString LogName = {read=FLogName, write=SetLogName};
	__property System::Byte DlgEffectDelay = {read=FEffectDelay, write=FEffectDelay, default=3};
	__property System::UnicodeString IniFile = {read=FIniFile, write=FIniFile};
	__property Lmdprocs::TLMDPathPrefix IniPrefix = {read=FIniPrefix, write=FIniPrefix, default=0};
	__property System::UnicodeString RegPath = {read=FRegPath, write=FRegPath};
	__property Lmdinictrl::TLMDRegRootKey RegRoot = {read=FRootKey, write=FRootKey, default=1};
	__property Lmdinictrl::TLMDIniTarget IniTarget = {read=FHTarget, write=FHTarget, default=2};
	__property Lmdclass::TLMDExceptionEvent OnException = {read=FOnException, write=FOnException};
	__property Lmdclass::TLMDMaxLogSizeEvent OnMaxLogSize = {read=FMaxLogSize, write=FMaxLogSize};
	__property System::Uitypes::TColor HintColor = {read=FHintColor, write=FHintColor, default=-16777192};
	__property int HintPause = {read=FHintPause, write=FHintPause, default=500};
	__property int HintHidePause = {read=FHintHidePause, write=FHintHidePause, default=2500};
	__property int HintShortPause = {read=FHintShortPause, write=FHintShortPause, default=50};
	__property Vcl::Graphics::TIcon* Icon = {read=GetIcon, write=SetIcon};
	__property System::Sysutils::TFileName HelpFile = {read=FHelpFile, write=FHelpFile};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, default=1};
	__property System::UnicodeString Title = {read=FTitle, write=FTitle};
	__property bool UpdateMetricSettings = {read=FUpdateMetricSettings, write=FUpdateMetricSettings, default=1};
	__property bool UpdateFormatSettings = {read=FUpdateFormatSettings, write=FUpdateFormatSettings, default=1};
	__property Vcl::Graphics::TFont* HintFont = {read=FHintFont, write=SetFont, index=0};
	__property Vcl::Graphics::TFont* IconFont = {read=FIconFont, write=SetFont, index=1};
	__property Vcl::Graphics::TFont* MenuFont = {read=FMenuFont, write=SetFont, index=2};
	__property TLMDSystemOptions SystemOptions = {read=FSystemOptions, write=FSystemOptions, default=0};
	__property System::Classes::TNotifyEvent OnActivate = {read=FOnActivate, write=FOnActivate};
	__property System::Classes::TNotifyEvent OnDeactivate = {read=FOnDeactivate, write=FOnDeactivate};
	__property Vcl::Forms::THelpEvent OnHelp = {read=FOnHelp, write=FOnHelp};
	__property Vcl::Forms::TIdleEvent OnIdle = {read=FOnIdle, write=FOnIdle};
	__property Vcl::Forms::TMessageEvent OnMessage = {read=FOnMessage, write=FOnMessage};
	__property System::Classes::TNotifyEvent OnMinimize = {read=FOnMinimize, write=FOnMinimize};
	__property System::Classes::TNotifyEvent OnHint = {read=FOnHint, write=FOnHint};
	__property System::Classes::TNotifyEvent OnRestore = {read=FOnRestore, write=FOnRestore};
	__property Vcl::Forms::TShowHintEvent OnShowHint = {read=FOnShowHint, write=FOnShowHint};
	__property System::Classes::TNotifyEvent OnEditModeChange = {read=FOnEditModeChange, write=FOnEditModeChange};
	__property Lmdclass::TLMDOnHeaderWrite OnHeaderWrite = {read=FOnHeaderWrite, write=FOnHeaderWrite};
	__property System::Classes::TNotifyEvent OnActiveFormChange = {read=FOnActiveFormChange, write=FOnActiveFormChange};
	__property System::Classes::TNotifyEvent OnActiveControlChange = {read=FOnActiveControlChange, write=FOnActiveControlChange};
	__property System::Classes::TActionEvent OnActionExecute = {read=FOnActionExecute, write=FOnActionExecute};
	__property System::Classes::TActionEvent OnActionUpdate = {read=FOnActionUpdate, write=FOnActionUpdate};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdapplicationctrl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDAPPLICATIONCTRL)
using namespace Lmdapplicationctrl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdapplicationctrlHPP
