// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTray.pas' rev: 31.00 (Windows)

#ifndef EltrayHPP
#define EltrayHPP

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
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <System.Math.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.ShellAPI.hpp>
#include <System.Types.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDProcs.hpp>
#include <LMDUtils.hpp>
#include <LMDShUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <LMDHTMLUnit.hpp>
#include <ElBaseComp.hpp>
#include <ElVCLUtils.hpp>
#include <ElTimers.hpp>
#include <ElTrayInfo.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltray
{
//-- forward type declarations -----------------------------------------------
struct TClickInfo;
class DELPHICLASS TElTrayInfoSettings;
class DELPHICLASS TElTrayIcon;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TElTrayExtHintShowEvent)(System::TObject* Sender, bool &DoShow);

typedef void __fastcall (__closure *TElTrayExtHintCreateEvent)(System::TObject* Sender, System::UnicodeString FormClass, Vcl::Forms::TForm* &Form);

typedef void __fastcall (__closure *TQueryEndSessionEvent)(System::TObject* Sender, int Action, bool &CanClose);

struct DECLSPEC_DRECORD TClickInfo
{
public:
	System::Uitypes::TMouseButton Button;
	System::Classes::TShiftState Shift;
	int X;
	int Y;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTrayInfoSettings : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	TElTrayIcon* FOwner;
	bool FEnabled;
	Eltrayinfo::TElTrayMessageList* __fastcall GetMsgs(void);
	Eltrayinfo::TElTrayVisualScheme* __fastcall GetVisualScheme(void);
	void __fastcall SetMsgs(Eltrayinfo::TElTrayMessageList* const Value);
	void __fastcall SetVisualScheme(Eltrayinfo::TElTrayVisualScheme* const Value);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetInfoType(Eltrayinfo::TElTrayInfoType newValue);
	virtual void __fastcall SetIsHTML(bool newValue);
	bool __fastcall GetIsHTML(void);
	virtual void __fastcall SetMessage(Lmdtypes::TLMDString newValue);
	System::Uitypes::TColor __fastcall GetColor(void);
	Eltrayinfo::TElTrayInfoType __fastcall GetInfoType(void);
	Lmdtypes::TLMDString __fastcall GetMessage(void);
	void __fastcall SetEnabled(bool Value);
	Vcl::Graphics::TFont* __fastcall GetFont(void);
	void __fastcall SetFont(Vcl::Graphics::TFont* Value);
	
public:
	__fastcall TElTrayInfoSettings(System::Classes::TPersistent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, default=-16777192};
	__property Eltrayinfo::TElTrayInfoType InfoType = {read=GetInfoType, write=SetInfoType, nodefault};
	__property bool IsHTML = {read=GetIsHTML, write=SetIsHTML, default=0};
	__property Lmdtypes::TLMDString Message = {read=GetMessage, write=SetMessage};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property Vcl::Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property Eltrayinfo::TElTrayVisualScheme* VisualScheme = {read=GetVisualScheme, write=SetVisualScheme};
	__property Eltrayinfo::TElTrayMessageList* Messages = {read=GetMsgs, write=SetMsgs};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElTrayInfoSettings(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElTrayIcon : public Elbasecomp::TElBaseComponent
{
	typedef Elbasecomp::TElBaseComponent inherited;
	
private:
	bool FPopupVis;
	unsigned FExtHintWndStyle;
	unsigned FExtHintWndExStyle;
	TElTrayExtHintShowEvent FOnBeforeExtendedHintShow;
	TElTrayExtHintCreateEvent FOnExtHintFormCreate;
	bool FHideTaskBarIcon;
	unsigned FExtendedHintDelay;
	TQueryEndSessionEvent FOnQueryEndSession;
	bool FPopupWhenModal;
	System::UnicodeString FHint;
	Vcl::Graphics::TIcon* FStaticIcon;
	bool FAnimated;
	Vcl::Graphics::TIcon* FIcon;
	Vcl::Imglist::TCustomImageList* FIcons;
	int FInterval;
	Vcl::Menus::TPopupMenu* FPopupMenu;
	TClickInfo FClickInfo;
	Eltimers::TElTimerPoolItem* FClickTimer;
	Eltimers::TElTimerPoolItem* FHintTimer;
	Eltimers::TElTimerPoolItem* FTimer;
	Eltimers::TElTimerPool* FTimerPool;
	int FImgIdx;
	Vcl::Controls::TMouseEvent FOnClick;
	System::Classes::TNotifyEvent FOnDblClick;
	Vcl::Controls::TMouseEvent FOnMouseDown;
	Vcl::Controls::TMouseEvent FOnMouseUp;
	Vcl::Controls::TMouseMoveEvent FOnMouseMove;
	System::Classes::TNotifyEvent FOnAnimationStopped;
	Vcl::Imglist::TChangeLink* StaticChangeLink;
	Vcl::Imglist::TChangeLink* MyChangeLink;
	bool FInWndProc;
	bool FSet;
	_NOTIFYICONDATAW FIconData;
	unsigned FIconID;
	bool FLClick;
	bool FMClick;
	bool FRClick;
	Vcl::Forms::TForm* FExtForm;
	System::UnicodeString FExtFormName;
	System::Types::TPoint FExtFormPt;
	bool FHideForm;
	bool FExtFormInt;
	bool FNoShow;
	Vcl::Controls::TMouseEvent FOnDblClickEx;
	Vcl::Imglist::TCustomImageList* FStaticIcons;
	bool FAnimateOnce;
	bool FUseStaticIcons;
	int FStaticIconIndex;
	bool TrayInfoVisible;
	void *NewMenuProc;
	void *OldMenuProc;
	void __fastcall SetExtForm(System::UnicodeString newValue);
	void __fastcall SetAnimated(bool newValue);
	void __fastcall SetDesignActive(bool newValue);
	void __fastcall SetIcons(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetInterval(int newValue);
	void __fastcall SetPopupMenu(Vcl::Menus::TPopupMenu* newValue);
	void __fastcall SetStaticIcon(Vcl::Graphics::TIcon* newValue);
	void __fastcall OnClickTimer(System::TObject* Sender);
	void __fastcall OnTimer(System::TObject* Sender);
	void __fastcall OnHintTimer(System::TObject* Sender);
	void __fastcall OnImagesChange(System::TObject* Sender);
	void __fastcall SetHint(System::UnicodeString newValue);
	bool __fastcall DoPopupMenu(int X, int Y);
	bool __fastcall DoDblClick(bool Perform);
	void __fastcall SetStaticIcons(Vcl::Imglist::TCustomImageList* Value);
	void __fastcall OnStaticIconsChange(System::TObject* Sender);
	
protected:
	Eltrayinfo::TElTrayInfo* FTrayInfo;
	TElTrayInfoSettings* FTrayInfoSettings;
	Lmdhtmlunit::TElHTMLImageNeededEvent FOnTrayInfoImageNeeded;
	Lmdhtmlunit::TElHTMLLinkClickEvent FOnTrayInfoLinkClick;
	virtual void __fastcall TriggerClickEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerDblClickEvent(void);
	virtual void __fastcall TriggerMouseDownEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerMouseUpEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerMouseMoveEvent(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall PopupMenuProc(Winapi::Messages::TMessage &Message);
	bool __fastcall HookWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DoSetEnabled(bool AEnabled);
	virtual void __fastcall UpdateIconData(bool remove);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall TriggerQueryEndSessionEvent(int Action, bool &CanClose);
	virtual void __fastcall SetExtendedHintDelay(unsigned newValue);
	virtual void __fastcall SetHideTaskBarIcon(bool newValue);
	void __fastcall DoHideTaskBarIcon(void);
	void __fastcall DoShowTaskBarIcon(void);
	virtual void __fastcall TriggerBeforeExtendedHintShowEvent(bool &DoShow);
	System::Classes::TComponentClass __fastcall FindExtForm(System::UnicodeString Name);
	virtual void __fastcall TriggerDblClickExEvent(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetUseStaticIcons(bool Value);
	int __fastcall GetStaticIconIndex(void);
	void __fastcall SetStaticIconIndex(int Value);
	void __fastcall UpdateStaticIcon(void);
	void __fastcall TrayInfoShowHandler(System::TObject* Sender);
	void __fastcall TrayInfoHideHandler(System::TObject* Sender);
	void __fastcall SetTrayInfoSettings(TElTrayInfoSettings* Value);
	int __fastcall AdjustY(int Y);
	virtual void __fastcall LinkClickTransfer(System::TObject* Sender, Lmdtypes::TLMDString HRef);
	virtual void __fastcall ImageNeededTransfer(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TBitmap* &Image);
	virtual void __fastcall TriggerAnimationStopped(void);
	void __fastcall PerformIconHiding(void);
	
public:
	__fastcall virtual TElTrayIcon(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTrayIcon(void);
	void __fastcall ShowExtForm(int X, int Y);
	__property Handle;
	__property Vcl::Forms::TForm* ExtendedHintForm = {read=FExtForm};
	__property unsigned ExtHintWndStyle = {read=FExtHintWndStyle, write=FExtHintWndStyle, nodefault};
	__property unsigned ExtHintWndExStyle = {read=FExtHintWndExStyle, write=FExtHintWndExStyle, nodefault};
	bool __fastcall ShowBalloonHint(const System::UnicodeString aInfoTitle, const System::UnicodeString aInfo, Vcl::Extctrls::TBalloonFlags aFlags = (Vcl::Extctrls::TBalloonFlags)(0x0), int aTimeOut = 0x2710);
	
__published:
	__property Vcl::Imglist::TCustomImageList* Icons = {read=FIcons, write=SetIcons};
	__property bool Animated = {read=FAnimated, write=SetAnimated, default=0};
	__property bool DesignActive = {read=FDesignActive, write=SetDesignActive, default=0};
	__property int Interval = {read=FInterval, write=SetInterval, default=200};
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
	__property Vcl::Controls::TMouseEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property Vcl::Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Vcl::Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property Vcl::Controls::TMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property Vcl::Graphics::TIcon* StaticIcon = {read=FStaticIcon, write=SetStaticIcon};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property Enabled = {default=0};
	__property System::UnicodeString ExtendedHint = {read=FExtFormName, write=SetExtForm};
	__property bool ExtendedHintInteractive = {read=FExtFormInt, write=FExtFormInt, default=0};
	__property bool PopupWhenModal = {read=FPopupWhenModal, write=FPopupWhenModal, default=0};
	__property TQueryEndSessionEvent OnQueryEndSession = {read=FOnQueryEndSession, write=FOnQueryEndSession};
	__property unsigned ExtendedHintDelay = {read=FExtendedHintDelay, write=SetExtendedHintDelay, nodefault};
	__property bool HideTaskBarIcon = {read=FHideTaskBarIcon, write=SetHideTaskBarIcon, default=0};
	__property TElTrayExtHintShowEvent OnBeforeExtendedHintShow = {read=FOnBeforeExtendedHintShow, write=FOnBeforeExtendedHintShow};
	__property TElTrayExtHintCreateEvent OnExtHintFormCreate = {read=FOnExtHintFormCreate, write=FOnExtHintFormCreate};
	__property Vcl::Controls::TMouseEvent OnDblClickEx = {read=FOnDblClickEx, write=FOnDblClickEx};
	__property bool AnimateOnce = {read=FAnimateOnce, write=FAnimateOnce, default=0};
	__property Vcl::Imglist::TCustomImageList* StaticIcons = {read=FStaticIcons, write=SetStaticIcons};
	__property bool UseStaticIcons = {read=FUseStaticIcons, write=SetUseStaticIcons, default=0};
	__property int StaticIconIndex = {read=GetStaticIconIndex, write=SetStaticIconIndex, default=-1};
	__property TElTrayInfoSettings* TrayInfoSettings = {read=FTrayInfoSettings, write=SetTrayInfoSettings};
	__property unsigned IconID = {read=FIconID, write=FIconID, nodefault};
	__property Lmdhtmlunit::TElHTMLImageNeededEvent OnTrayInfoImageNeeded = {read=FOnTrayInfoImageNeeded, write=FOnTrayInfoImageNeeded};
	__property Lmdhtmlunit::TElHTMLLinkClickEvent OnTrayInfoLinkClick = {read=FOnTrayInfoLinkClick, write=FOnTrayInfoLinkClick};
	__property System::Classes::TNotifyEvent OnAnimationStopped = {read=FOnAnimationStopped, write=FOnAnimationStopped};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int TrackInterval;
extern DELPHI_PACKAGE int HideInterval;
}	/* namespace Eltray */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTRAY)
using namespace Eltray;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltrayHPP
