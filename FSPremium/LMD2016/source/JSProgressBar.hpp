// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSProgressBar.pas' rev: 31.00 (Windows)

#ifndef JsprogressbarHPP
#define JsprogressbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.SyncObjs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.UxTheme.hpp>
#include <Winapi.CommCtrl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsprogressbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSMarqueeThread;
class DELPHICLASS TJSProgressBar;
class DELPHICLASS TJSProgressBarEx;
class DELPHICLASS TJSProgressBarMarquee;
__interface ITaskbarList;
typedef System::DelphiInterface<ITaskbarList> _di_ITaskbarList;
__interface ITaskbarList2;
typedef System::DelphiInterface<ITaskbarList2> _di_ITaskbarList2;
struct THUMBBUTTON;
__interface ITaskbarList3;
typedef System::DelphiInterface<ITaskbarList3> _di_ITaskbarList3;
class DELPHICLASS TJSTaskBarProgressImpl;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TProgressStyle : unsigned char { psNormal, psMarquee };

enum DECLSPEC_DENUM TProgressBarState : unsigned char { pbstNormal, pbstError, pbstPaused };

class PASCALIMPLEMENTATION TJSMarqueeThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	System::Types::TRect FClientRect;
	int FInterval;
	int FChunkWidth;
	bool FUseThemes;
	TProgressBarState FState;
	NativeUInt FHwnd;
	Vcl::Graphics::TBitmap* FBitmap;
	System::Types::TRect FImgRect;
	int FOffset;
	int FX;
	System::Types::TRect FRect;
	HDC FDC;
	Vcl::Themes::TThemedElementDetails lDetail;
	
protected:
	void __fastcall Paint(void);
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TJSMarqueeThread(TJSProgressBar* AProgressBar, const bool Themed);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TJSMarqueeThread(void) { }
	
};


class PASCALIMPLEMENTATION TJSProgressBar : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	System::Classes::TNotifyEvent FOnProgress;
	System::Uitypes::TColor FProgressColor;
	int FChunkWidth;
	int FStep;
	int FPosition;
	int FMax;
	TProgressStyle FStyle;
	TProgressBarState FState;
	TJSMarqueeThread* FMarqueeThread;
	bool FActive;
	unsigned FInterval;
	System::Syncobjs::TCriticalSection* FCreateThreadCS;
	void __fastcall SetInterval(const unsigned Value);
	unsigned __fastcall GetInterval(void);
	bool __fastcall GetIsActivated(void);
	void __fastcall SetProgressColor(const System::Uitypes::TColor Value);
	bool __fastcall GetActive(void);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetStep(const int Value);
	void __fastcall SetMax(const int Value);
	void __fastcall SetStyle(const TProgressStyle Value);
	void __fastcall SetChunkWidth(const int Value);
	void __fastcall SetState(const TProgressBarState Value);
	void __fastcall CreateMarqueeThread(const bool aCreate);
	
protected:
	virtual void __fastcall DoProgress(void);
	virtual void __fastcall InitializeStyle(const TProgressStyle AStyle);
	virtual void __fastcall Paint(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	virtual void __fastcall CreateWnd(void);
	MESSAGE void __fastcall RecreateWndHandler(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TJSProgressBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TJSProgressBar(void);
	void __fastcall Activate(const unsigned aInterval);
	void __fastcall Deactivate(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall StepIt(void);
	__property bool IsActivated = {read=GetIsActivated, nodefault};
	
__published:
	__property bool Active = {read=GetActive, write=SetActive, default=0};
	__property unsigned Interval = {read=GetInterval, write=SetInterval, default=100};
	__property System::Uitypes::TColor ProgressColor = {read=FProgressColor, write=SetProgressColor, default=65280};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Step = {read=FStep, write=SetStep, default=1};
	__property TProgressStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int ChunkWidth = {read=FChunkWidth, write=SetChunkWidth, default=40};
	__property TProgressBarState State = {read=FState, write=SetState, default=0};
	__property Color = {default=-16777201};
	__property Height = {default=17};
	__property Width = {default=145};
	__property System::Classes::TNotifyEvent OnProgress = {read=FOnProgress, write=FOnProgress};
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSProgressBar(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TJSProgressBarEx : public Vcl::Comctrls::TProgressBar
{
	typedef Vcl::Comctrls::TProgressBar inherited;
	
private:
	bool FActive;
	int FInterval;
	void __fastcall SetActive(const bool Value);
	void __fastcall SetInterval(const int Value);
	
protected:
	virtual void __fastcall IntervalChanged(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	
public:
	__fastcall virtual TJSProgressBarEx(System::Classes::TComponent* AOwner);
	
__published:
	__property Height = {default=15};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property int Interval = {read=FInterval, write=SetInterval, default=100};
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSProgressBarEx(HWND ParentWindow) : Vcl::Comctrls::TProgressBar(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TJSProgressBarEx(void) { }
	
};


class PASCALIMPLEMENTATION TJSProgressBarMarquee : public TJSProgressBarEx
{
	typedef TJSProgressBarEx inherited;
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall IntervalChanged(void);
public:
	/* TJSProgressBarEx.Create */ inline __fastcall virtual TJSProgressBarMarquee(System::Classes::TComponent* AOwner) : TJSProgressBarEx(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSProgressBarMarquee(HWND ParentWindow) : TJSProgressBarEx(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TJSProgressBarMarquee(void) { }
	
};


__interface  INTERFACE_UUID("{56FDF342-FD6D-11D0-958A-006097C9A090}") ITaskbarList  : public System::IInterface 
{
	virtual HRESULT __stdcall HrInit(void) = 0 ;
	virtual HRESULT __stdcall AddTab(HWND hwnd) = 0 ;
	virtual HRESULT __stdcall DeleteTab(HWND hwnd) = 0 ;
	virtual HRESULT __stdcall ActivateTab(HWND hwnd) = 0 ;
	virtual HRESULT __stdcall SetActiveAlt(HWND hwnd) = 0 ;
};

__interface  INTERFACE_UUID("{602D4995-B13A-429B-A66E-1935E44F4317}") ITaskbarList2  : public ITaskbarList 
{
	virtual HRESULT __stdcall MarkFullscreenWindow(HWND hwnd, System::LongBool fFullscreen) = 0 ;
};

struct DECLSPEC_DRECORD THUMBBUTTON
{
public:
	unsigned dwMask;
	unsigned iId;
	unsigned iBitmap;
	HICON hIcon;
	System::StaticArray<System::WideChar, 260> szTip;
	unsigned dwFlags;
};


typedef THUMBBUTTON TThumbButton;

typedef THUMBBUTTON *PThumbButton;

__interface  INTERFACE_UUID("{EA1AFB91-9E28-4B86-90E9-9E9F8A5EEFAF}") ITaskbarList3  : public ITaskbarList2 
{
	virtual HRESULT __stdcall SetProgressValue(HWND hwnd, unsigned __int64 ullCompleted, unsigned __int64 ullTotal) = 0 ;
	virtual HRESULT __stdcall SetProgressState(HWND hwnd, int tbpFlags) = 0 ;
	virtual HRESULT __stdcall RegisterTab(HWND hwndTab, HWND hwndMDI) = 0 ;
	virtual HRESULT __stdcall UnregisterTab(HWND hwndTab) = 0 ;
	virtual HRESULT __stdcall SetTabOrder(HWND hwndTab, HWND hwndInsertBefore) = 0 ;
	virtual HRESULT __stdcall SetTabActive(HWND hwndTab, HWND hwndMDI, int tbatFlags) = 0 ;
	virtual HRESULT __stdcall ThumbBarAddButtons(HWND hwnd, unsigned cButtons, PThumbButton pButton) = 0 ;
	virtual HRESULT __stdcall ThumbBarUpdateButtons(HWND hwnd, unsigned cButtons, PThumbButton pButton) = 0 ;
	virtual HRESULT __stdcall ThumbBarSetImageList(HWND hwnd, NativeUInt himl) = 0 ;
	virtual HRESULT __stdcall SetOverlayIcon(HWND hwnd, HICON hIcon, System::WideChar * pszDescription) = 0 ;
	virtual HRESULT __stdcall SetThumbnailTooltip(HWND hwnd, System::WideChar * pszTip) = 0 ;
	virtual HRESULT __stdcall SetThumbnailClip(HWND hwnd, System::Types::TRect &prcClip) = 0 ;
};

#pragma pack(push,4)
class PASCALIMPLEMENTATION TJSTaskBarProgressImpl : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	_di_ITaskbarList3 FTaskbarProgressIntf;
	NativeUInt __fastcall GetApplicationHandle(void);
	
public:
	__fastcall TJSTaskBarProgressImpl(void);
	__fastcall virtual ~TJSTaskBarProgressImpl(void);
	HRESULT __fastcall SetProgressValue(unsigned __int64 ullCompleted, unsigned __int64 ullTotal);
	HRESULT __fastcall SetProgressState(int tbpFlags);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE GUID CLSID_TaskbarList;
static const System::Int8 TBPF_NOPROGRESS = System::Int8(0x0);
static const System::Int8 TBPF_INDETERMINATE = System::Int8(0x1);
static const System::Int8 TBPF_NORMAL = System::Int8(0x2);
static const System::Int8 TBPF_ERROR = System::Int8(0x4);
static const System::Int8 TBPF_PAUSED = System::Int8(0x8);
}	/* namespace Jsprogressbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSPROGRESSBAR)
using namespace Jsprogressbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsprogressbarHPP
