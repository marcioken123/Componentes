// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTrayIcon.pas' rev: 31.00 (Windows)

#ifndef LmdtrayiconHPP
#define LmdtrayiconHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ImgList.hpp>
#include <Winapi.ShellAPI.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCont.hpp>
#include <LMDClass.hpp>
#include <LMDTimer.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDShUtils.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtrayicon
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTrayIcon;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Lmdtrayicon__1 : unsigned char { tioAniRestoreIcon, tioAniLoop, tioDisableCloseButton, tioShowMinimizedIcon, tioRestoreOnDblClick };

typedef System::Set<Lmdtrayicon__1, Lmdtrayicon__1::tioAniRestoreIcon, Lmdtrayicon__1::tioRestoreOnDblClick> TLMDTrayIconOptions;

class PASCALIMPLEMENTATION TLMDTrayIcon : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	_NOTIFYICONDATAW FIconData;
	bool FCancelAnimation;
	bool FIntClick;
	bool FAnimated;
	bool FActive;
	System::UnicodeString FHint;
	Vcl::Graphics::TIcon* FIcon;
	Vcl::Graphics::TIcon* FCurrentIcon;
	System::Types::TPoint FInternal;
	Vcl::Menus::TPopupMenu* FPopUpMenu;
	System::Classes::TThreadPriority FThreadPriority;
	Vcl::Imglist::TCustomImageList* FImageList;
	int FListIndex;
	Lmdclass::TLMDTimerMode FTimerMode;
	Lmdclass::TLMDTimerInterval FInterval;
	int FCounter;
	Lmdclass::TLMDTimer* FTimerId;
	Lmdtimer::TLMDHiTimer* FTimer;
	System::Classes::TNotifyEvent FOnNoClose;
	System::Classes::TNotifyEvent FOnDblClick;
	System::Classes::TNotifyEvent FOnClick;
	System::Classes::TNotifyEvent FOnPopUp;
	Vcl::Controls::TMouseEvent FOnMouseDown;
	Vcl::Controls::TMouseEvent FOnMouseUp;
	Vcl::Controls::TMouseMoveEvent FOnMouseMove;
	System::UnicodeString FBalloonTitle;
	System::UnicodeString FBalloonHint;
	Vcl::Extctrls::TBalloonFlags FBalloonFlags;
	int FTimeOut;
	System::Classes::TNotifyEvent FOnAnimate;
	TLMDTrayIconOptions FOptions;
	void __fastcall SetAnimated(bool aValue);
	void __fastcall SetBoolean(const int Index, const bool Value);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetActive(bool aValue);
	void __fastcall SetHint(const System::UnicodeString aValue);
	void __fastcall SetIcon(Vcl::Graphics::TIcon* aValue);
	void __fastcall SetPopUpMenu(Vcl::Menus::TPopupMenu* aValue);
	void __fastcall SetTimerMode(Lmdclass::TLMDTimerMode aValue);
	void __fastcall ReadNoClose(System::Classes::TReader* Reader);
	void __fastcall ReadShowMinimizedIcon(System::Classes::TReader* Reader);
	bool __fastcall GetBoolean(const int Index);
	void __fastcall GetTimer(System::TObject* Sender);
	bool __fastcall NotifyIcon(System::Word aValue);
	HIDESBASE void __fastcall NewWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall IconChanged(System::TObject* Sender);
	void __fastcall ActivateTimer(void);
	void __fastcall DeActivateTimer(Lmdclass::TLMDTimerMode aValue);
	void __fastcall EnableTimer(bool aValue);
	HWND __fastcall TaskBarHandle(void);
	void __fastcall TaskBarShow(const bool show);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual bool __fastcall AppWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDTrayIcon(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTrayIcon(void);
	bool __fastcall IsMinimized(void);
	bool __fastcall CanShowBallonHint(void);
	int __fastcall CurrentImageIndex(void);
	void __fastcall HideBallonHint(void);
	void __fastcall HideApplication(void);
	void __fastcall ShowApplication(void);
	bool __fastcall ShowBalloonHint(void)/* overload */;
	bool __fastcall ShowBalloonHint(const System::UnicodeString aTitle, const System::UnicodeString aHint, Vcl::Extctrls::TBalloonFlags aFlags = (Vcl::Extctrls::TBalloonFlags)(0x0), int aTimeOut = 0x2710)/* overload */;
	void __fastcall Refresh(void);
	void __fastcall SetDefaultIcon(void);
	__property bool NoClose = {read=GetBoolean, write=SetBoolean, index=0, nodefault};
	__property bool ShowMinimizedIcon = {read=GetBoolean, write=SetBoolean, index=1, nodefault};
	
__published:
	__property About = {default=0};
	__property bool Active = {read=FActive, write=SetActive, default=1};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property Vcl::Graphics::TIcon* Icon = {read=FIcon, write=SetIcon};
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=FPopUpMenu, write=SetPopUpMenu};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property int ListIndex = {read=FListIndex, write=FListIndex, default=0};
	__property Lmdclass::TLMDTimerMode TimerMode = {read=FTimerMode, write=SetTimerMode, default=0};
	__property System::Classes::TThreadPriority ThreadPriority = {read=FThreadPriority, write=FThreadPriority, default=3};
	__property Lmdclass::TLMDTimerInterval Interval = {read=FInterval, write=FInterval, default=200};
	__property bool Animated = {read=FAnimated, write=SetAnimated, default=0};
	__property System::UnicodeString BalloonHint = {read=FBalloonHint, write=FBalloonHint};
	__property System::UnicodeString BalloonTitle = {read=FBalloonTitle, write=FBalloonTitle};
	__property int BalloonTimeout = {read=FTimeOut, write=FTimeOut, default=10000};
	__property Vcl::Extctrls::TBalloonFlags BalloonFlags = {read=FBalloonFlags, write=FBalloonFlags, default=0};
	__property TLMDTrayIconOptions Options = {read=FOptions, write=FOptions, default=19};
	__property System::Classes::TNotifyEvent OnAnimate = {read=FOnAnimate, write=FOnAnimate};
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property Vcl::Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Vcl::Controls::TMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property Vcl::Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property System::Classes::TNotifyEvent OnPopUp = {read=FOnPopUp, write=FOnPopUp};
	__property System::Classes::TNotifyEvent OnNoClose = {read=FOnNoClose, write=FOnNoClose};
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDTrayIconOptions (System::Set<Lmdtrayicon__1, Lmdtrayicon__1::tioAniRestoreIcon, Lmdtrayicon__1::tioRestoreOnDblClick>() << Lmdtrayicon__1::tioAniRestoreIcon << Lmdtrayicon__1::tioAniLoop << Lmdtrayicon__1::tioRestoreOnDblClick )
}	/* namespace Lmdtrayicon */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTRAYICON)
using namespace Lmdtrayicon;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtrayiconHPP
