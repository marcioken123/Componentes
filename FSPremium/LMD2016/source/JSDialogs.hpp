// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSDialogs.pas' rev: 31.00 (Windows)

#ifndef JsdialogsHPP
#define JsdialogsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ComCtrls.hpp>
#include <JSTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsdialogs
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TMsgType : unsigned char { mtNone, mtContent, mtInstruction };

enum DECLSPEC_DENUM TMsgDlgType : unsigned char { mtWarning, mtError, mtInformation, mtConfirmation, mtCustom };

enum DECLSPEC_DENUM TMsgDlgBtn : unsigned char { mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore, mbAll, mbNoToAll, mbYesToAll, mbHelp, mbClose };

typedef System::Set<TMsgDlgBtn, TMsgDlgBtn::mbYes, TMsgDlgBtn::mbClose> TMsgDlgButtons;

enum DECLSPEC_DENUM TTaskDialogIcon : unsigned char { tdiNone, tdiWarning, tdiError, tdiInformation, tdiConfirmation, tdiCustom, tdiShield };

enum DECLSPEC_DENUM TCommonButton : unsigned char { cbYes, cbNo, cbOK, cbCancel, cbAbort, cbRetry, cbIgnore, cbAll, cbNoToAll, cbYesToAll, cbHelp, cbClose };

typedef System::Set<TCommonButton, TCommonButton::cbYes, TCommonButton::cbClose> TCommonButtons;

enum DECLSPEC_DENUM TDialogPosition : unsigned char { dpScreenCenter, dpDesktopCenter, dpMainFormCenter, dpOwnerFormCenter, dpDesigned };

//-- var, const, procedure ---------------------------------------------------
#define mbYesNo (System::Set<TMsgDlgBtn, TMsgDlgBtn::mbYes, TMsgDlgBtn::mbClose>() << TMsgDlgBtn::mbYes << TMsgDlgBtn::mbNo )
#define mbYesNoCancel (System::Set<TMsgDlgBtn, TMsgDlgBtn::mbYes, TMsgDlgBtn::mbClose>() << TMsgDlgBtn::mbYes << TMsgDlgBtn::mbNo << TMsgDlgBtn::mbCancel )
#define mbYesAllNoAllCancel (System::Set<TMsgDlgBtn, TMsgDlgBtn::mbYes, TMsgDlgBtn::mbClose>() << TMsgDlgBtn::mbYes << TMsgDlgBtn::mbNo << TMsgDlgBtn::mbCancel << TMsgDlgBtn::mbNoToAll << TMsgDlgBtn::mbYesToAll )
#define mbOKCancel (System::Set<TMsgDlgBtn, TMsgDlgBtn::mbYes, TMsgDlgBtn::mbClose>() << TMsgDlgBtn::mbOK << TMsgDlgBtn::mbCancel )
#define mbAbortRetryIgnore (System::Set<TMsgDlgBtn, TMsgDlgBtn::mbYes, TMsgDlgBtn::mbClose>() << TMsgDlgBtn::mbAbort << TMsgDlgBtn::mbRetry << TMsgDlgBtn::mbIgnore )
#define mbAbortIgnore (System::Set<TMsgDlgBtn, TMsgDlgBtn::mbYes, TMsgDlgBtn::mbClose>() << TMsgDlgBtn::mbAbort << TMsgDlgBtn::mbIgnore )
static const System::Int8 TD_ICON_BLANK = System::Int8(0x0);
static const System::Int8 TD_ICON_WARNING = System::Int8(0x54);
static const System::Int8 TD_ICON_QUESTION = System::Int8(0x63);
static const System::Int8 TD_ICON_ERROR = System::Int8(0x62);
static const System::Int8 TD_ICON_INFORMATION = System::Int8(0x51);
static const System::Int8 TD_ICON_SHIELD_QUESTION = System::Int8(0x68);
static const System::Int8 TD_ICON_SHIELD_ERROR = System::Int8(0x69);
static const System::Int8 TD_ICON_SHIELD_OK = System::Int8(0x6a);
static const System::Int8 TD_ICON_SHIELD_WARNING = System::Int8(0x6b);
static const System::Int8 MD_ICON_WARNING = System::Int8(0x65);
static const System::Int8 MD_ICON_QUESTION = System::Int8(0x66);
static const System::Int8 MD_ICON_ERROR = System::Int8(0x67);
static const System::Int8 MD_ICON_INFORMATION = System::Int8(0x68);
static const System::Int8 MD_ICON_SHIELD = System::Int8(0x6a);
static const System::Int8 TD_BUTTON_OK = System::Int8(0x1);
static const System::Int8 TD_BUTTON_YES = System::Int8(0x2);
static const System::Int8 TD_BUTTON_NO = System::Int8(0x4);
static const System::Int8 TD_BUTTON_CANCEL = System::Int8(0x8);
static const System::Int8 TD_BUTTON_RETRY = System::Int8(0x10);
static const System::Int8 TD_BUTTON_CLOSE = System::Int8(0x20);
static const System::Int8 TD_RESULT_OK = System::Int8(0x1);
static const System::Int8 TD_RESULT_CANCEL = System::Int8(0x2);
static const System::Int8 TD_RESULT_RETRY = System::Int8(0x4);
static const System::Int8 TD_RESULT_YES = System::Int8(0x6);
static const System::Int8 TD_RESULT_NO = System::Int8(0x7);
static const System::Int8 TD_RESULT_CLOSE = System::Int8(0x8);
extern DELPHI_PACKAGE TDialogPosition JSDialogDefaultDialogPosition;
extern DELPHI_PACKAGE bool JSDialogAlwaysUseJSDialog;
extern DELPHI_PACKAGE bool JSDialogForceWrapperDialogsOnTop;
extern DELPHI_PACKAGE bool JSDialogPlaySounds;
extern DELPHI_PACKAGE void __fastcall ConvertIconValue(const bool MDtoTD, int &aMD, int &aTD);
extern DELPHI_PACKAGE int __fastcall TaskDialog(NativeUInt aOwner, const System::UnicodeString aTitle, const System::UnicodeString aMainInstruction, const System::UnicodeString aContent, int aIcon, int aButtons)/* overload */;
extern DELPHI_PACKAGE int __fastcall TaskDialog(NativeUInt aOwner, const System::UnicodeString aTitle, const System::UnicodeString aMainInstruction, const System::UnicodeString aContent, int aIcon, int aButtons, int aDefault)/* overload */;
extern DELPHI_PACKAGE int __fastcall TaskDialogEx(Vcl::Controls::TWinControl* aOwner, const System::UnicodeString aTitle, const System::UnicodeString aMainInstruction, const System::UnicodeString aContent, int aIcon, TCommonButtons aButtons);
extern DELPHI_PACKAGE int __fastcall MessageDlg(const System::UnicodeString Msg, TMsgDlgType DlgType, TMsgDlgButtons Buttons, int HelpCtx, TMsgDlgBtn DefaultButton)/* overload */;
extern DELPHI_PACKAGE int __fastcall MessageDlg(const System::UnicodeString Msg, TMsgDlgType DlgType, TMsgDlgButtons Buttons, int HelpCtx)/* overload */;
extern DELPHI_PACKAGE int __fastcall MessageDlgPos(const System::UnicodeString Msg, TMsgDlgType DlgType, TMsgDlgButtons Buttons, int HelpCtx, int X, int Y)/* overload */;
extern DELPHI_PACKAGE int __fastcall MessageDlgPos(const System::UnicodeString Msg, TMsgDlgType DlgType, TMsgDlgButtons Buttons, int HelpCtx, int X, int Y, TMsgDlgBtn DefaultButton)/* overload */;
extern DELPHI_PACKAGE void __fastcall ShowMessagePos(const System::UnicodeString Msg, int X, int Y);
extern DELPHI_PACKAGE void __fastcall ShowMessage(const System::UnicodeString Msg)/* overload */;
extern DELPHI_PACKAGE void __fastcall ShowMessage(const System::UnicodeString Msg, TCommonButton AButton)/* overload */;
extern DELPHI_PACKAGE void __fastcall ShowMessageFmt(const System::UnicodeString Msg, System::TVarRec *Params, const int Params_High);
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall VerifyMessage(const System::UnicodeString aInstruction, const System::UnicodeString aMsg, const TTaskDialogIcon aIcon, const TCommonButtons aButtons, const int aHelpIdx, const System::UnicodeString aVerifyText, bool &aVerifyResult, const System::UnicodeString AFooterText, TTaskDialogIcon AFooterIcon)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall VerifyMessage(const System::UnicodeString aInstruction, const System::UnicodeString aMsg, const TTaskDialogIcon aIcon, const TCommonButtons aButtons, const int aHelpIdx, const System::UnicodeString aVerifyText, bool &aVerifyResult)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall VerifyMessage(const System::UnicodeString aMsg, const TTaskDialogIcon aIcon, const TCommonButtons aButtons, const int aHelpIdx, const TMsgType aMsgType, const System::UnicodeString aVerifyText, bool &aVerifyResult)/* overload */;
extern DELPHI_PACKAGE void __fastcall ShowErrorMessage(const System::UnicodeString aMsg);
extern DELPHI_PACKAGE void __fastcall ShowErrorTitleMessage(const System::UnicodeString aTitle, const System::UnicodeString aMsg)/* overload */;
extern DELPHI_PACKAGE void __fastcall ShowErrorTitleMessageWithError(const System::UnicodeString ATitle, const System::UnicodeString AMessage, const System::UnicodeString AException, const System::UnicodeString AShowText = System::UnicodeString(), System::UnicodeString AHideText = System::UnicodeString());
extern DELPHI_PACKAGE void __fastcall ShowErrorTitleMessageWithErrorAndFooter(const System::UnicodeString ATitle, const System::UnicodeString AMessage, const System::UnicodeString AException, const System::UnicodeString AFooter, const TTaskDialogIcon AFooterIcon, const System::UnicodeString AShowText = System::UnicodeString(), System::UnicodeString AHideText = System::UnicodeString(), const bool AAnimate = false);
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall ShowWarningMessage(const System::UnicodeString aMsg);
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall ShowWarningTitleMessage(const System::UnicodeString aTitle, const System::UnicodeString aMsg);
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall ShowConfirmMessage(const System::UnicodeString aMsg, const TMsgDlgBtn AConfirm = (TMsgDlgBtn)(0x2), const TMsgDlgBtn ACancel = (TMsgDlgBtn)(0x3));
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall ShowConfirmTitleMessage(const System::UnicodeString aTitle, const System::UnicodeString aMsg, const TMsgDlgBtn AConfirm = (TMsgDlgBtn)(0x2), const TMsgDlgBtn ACancel = (TMsgDlgBtn)(0x3));
extern DELPHI_PACKAGE void __fastcall ShowInfoMessage(const System::UnicodeString aMsg)/* overload */;
extern DELPHI_PACKAGE void __fastcall ShowTimedInfoMessage(const System::UnicodeString AInstruction, const System::UnicodeString AMessage, const int ATimeOut, const bool AShowCountdown = false, const System::UnicodeString ACountdownText = System::UnicodeString());
extern DELPHI_PACKAGE void __fastcall ShowInfoTitleMessage(const System::UnicodeString aTitle, const System::UnicodeString aMsg)/* overload */;
extern DELPHI_PACKAGE void __fastcall ShowInfoMessage(const System::UnicodeString aMsg, TCommonButton aButton)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall ShowExpandableMessage(const System::UnicodeString aTitle, const System::UnicodeString aInstruction, const System::UnicodeString aContent, const System::UnicodeString aExpandedContent, const System::UnicodeString aExpandText, const System::UnicodeString aCollapseText, TTaskDialogIcon aIcon, TCommonButtons aButtons, int aHelpIdx, const bool aShowInFooter, const bool aExpanded)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall ShowExpandableMessage(Vcl::Controls::TWinControl* aOwner, const System::UnicodeString aTitle, const System::UnicodeString aInstruction, const System::UnicodeString aContent, const System::UnicodeString aExpandedContent, const System::UnicodeString aExpandText, const System::UnicodeString aCollapseText, TTaskDialogIcon aIcon, TCommonButtons aButtons, int aHelpIdx, const bool aShowInFooter, const bool aExpanded)/* overload */;
}	/* namespace Jsdialogs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSDIALOGS)
using namespace Jsdialogs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsdialogsHPP
