unit LMDTaskDialog;
{$I Lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDTaskDialog unit (AH)
-----------------------


Changes
-------
Release 8.0 (December 2006)
 - Initial Release

###############################################################################}
interface

uses
  {$IFDEF LMDCOMP11}CommCtrl,{$ENDIF} Messages, Controls, SysUtils, Classes,
  Windows, LMDTypes;

const
  {$IFNDEF LMDCOMP11}
  // TASKDIALOG_FLAGS
  TDF_ENABLE_HYPERLINKS           = $0001;
  TDF_USE_HICON_MAIN              = $0002;
  TDF_USE_HICON_FOOTER            = $0004;
  TDF_ALLOW_DIALOG_CANCELLATION   = $0008;
  TDF_USE_COMMAND_LINKS           = $0010;
  TDF_USE_COMMAND_LINKS_NO_ICON   = $0020;
  TDF_EXPAND_FOOTER_AREA          = $0040;
  TDF_EXPANDED_BY_DEFAULT         = $0080;
  TDF_VERIFICATION_FLAG_CHECKED   = $0100;
  TDF_SHOW_PROGRESS_BAR           = $0200;
  TDF_SHOW_MARQUEE_PROGRESS_BAR   = $0400;
  TDF_CALLBACK_TIMER              = $0800;
  TDF_POSITION_RELATIVE_TO_WINDOW = $1000;
  TDF_RTL_LAYOUT                  = $2000;
  TDF_NO_DEFAULT_RADIO_BUTTON     = $4000;
  TDF_CAN_BE_MINIMIZED            = $8000;

  // TASKDIALOG_MESSAGES
  TDM_NAVIGATE_PAGE                   = WM_USER + 101;
  TDM_CLICK_BUTTON                    = WM_USER + 102; // wParam = Button ID
  TDM_SET_MARQUEE_PROGRESS_BAR        = WM_USER + 103; // wParam = 0 (nonMarque) wParam != 0 (Marquee)
  TDM_SET_PROGRESS_BAR_STATE          = WM_USER + 104; // wParam = new progress state
  TDM_SET_PROGRESS_BAR_RANGE          = WM_USER + 105; // lParam = MAKELPARAM(nMinRange; nMaxRange)
  TDM_SET_PROGRESS_BAR_POS            = WM_USER + 106; // wParam = new position
  TDM_SET_PROGRESS_BAR_MARQUEE        = WM_USER + 107; // wParam = 0 (stop marquee); wParam != 0 (start marquee); lparam = speed (milliseconds between repaints)
  TDM_SET_ELEMENT_TEXT                = WM_USER + 108; // wParam = element (TASKDIALOG_ELEMENTS); lParam = new element text (LPCWSTR)
  TDM_CLICK_RADIO_BUTTON              = WM_USER + 110; // wParam = Radio Button ID
  TDM_ENABLE_BUTTON                   = WM_USER + 111; // lParam = 0 (disable); lParam != 0 (enable); wParam = Button ID
  TDM_ENABLE_RADIO_BUTTON             = WM_USER + 112; // lParam = 0 (disable); lParam != 0 (enable); wParam = Radio Button ID
  TDM_CLICK_VERIFICATION              = WM_USER + 113; // wParam = 0 (unchecked); 1 (checked); lParam = 1 (set key focus)
  TDM_UPDATE_ELEMENT_TEXT             = WM_USER + 114; // wParam = element (TASKDIALOG_ELEMENTS); lParam = new element text (LPCWSTR)
  TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE = WM_USER + 115; // wParam = Button ID; lParam = 0 (elevation not required); lParam != 0 (elevation required)
  TDM_UPDATE_ICON                     = WM_USER + 116;  // wParam = icon element (TASKDIALOG_ICON_ELEMENTS); lParam = new icon (hIcon if TDF_USE_HICON_* was set; PCWSTR otherwise)
  {$ENDIF}
  TDM_UPDATE_FLAGS = WM_USER + 130; // Custom message to update flags

  {$IFNDEF LMDCOMP11}
  // TASKDIALOG_NOTIFICATIONS
  TDN_CREATED                         = 0;
  TDN_NAVIGATED                       = 1;
  TDN_BUTTON_CLICKED                  = 2;            // wParam = Button ID
  TDN_HYPERLINK_CLICKED               = 3;            // lParam = (LPCWSTR)pszHREF
  TDN_TIMER                           = 4;            // wParam = Milliseconds since dialog created or timer reset
  TDN_DESTROYED                       = 5;
  TDN_RADIO_BUTTON_CLICKED            = 6;            // wParam = Radio Button ID
  TDN_DIALOG_CONSTRUCTED              = 7;
  TDN_VERIFICATION_CLICKED            = 8;            // wParam = 1 if checkbox checked; 0 if not; lParam is unused and always 0
  TDN_HELP                            = 9;
  TDN_EXPANDO_BUTTON_CLICKED          = 10;           // wParam = 0 (dialog is now collapsed); wParam != 0 (dialog is now expanded)

type
  TASKDIALOG_BUTTON = packed record
    nButtonId: integer;
    pszButtonText: PWideChar;
    end;

  {$ENDIF}

const
  TD_ICON_BLANK = 100;
  TD_ICON_WARNING = 101;
  TD_ICON_QUESTION = 102;
  TD_ICON_ERROR = 103;
  TD_ICON_INFORMATION = 104;
  TD_ICON_BLANK_AGAIN = 105;
  TD_ICON_SHIELD = 106;

{$IFNDEF LMDCOMP11}
const
  // TASKDIALOG_ELEMENTS
  TDE_CONTENT                  = 0;
  TDE_EXPANDED_INFORMATION     = 1;
  TDE_FOOTER                   = 2;
  TDE_MAIN_INSTRUCTION         = 3;

  // TASKDIALOG_ICON_ELEMENTS
  TDIE_ICON_MAIN               = 0;
  TDIE_ICON_FOOTER             = 1;

  TD_WARNING_ICON = MAKEINTRESOURCEW(Word(-1));
  TD_ERROR_ICON = MAKEINTRESOURCEW(Word(-2));
  TD_INFORMATION_ICON = MAKEINTRESOURCEW(Word(-3));
  TD_SHIELD_ICON = MAKEINTRESOURCEW(Word(-4));

  // TASKDIALOG_COMMON_BUTTON_FLAGS
  TDCBF_OK_BUTTON            = $0001; // selected control return value IDOK
  TDCBF_YES_BUTTON           = $0002; // selected control return value IDYES
  TDCBF_NO_BUTTON            = $0004; // selected control return value IDNO
  TDCBF_CANCEL_BUTTON        = $0008; // selected control return value IDCANCEL
  TDCBF_RETRY_BUTTON         = $0010; // selected control return value IDRETRY
  TDCBF_CLOSE_BUTTON         = $0020; // selected control return value IDCLOSE

const
  PBST_NORMAL = $0001;
  PBST_ERROR = $0002;
  PBST_PAUSED = $0003;
{$ENDIF}

type
  {$EXTERNALSYM LONG_PTR}
  LONG_PTR = TLMDPtrInt;
  TLMDTaskDialogCallBack = function (hwndDlg: HWND; Msg: UINT; wp: WPARAM; lp: LPARAM; dwRefData: LONG_PTR): HRESULT; stdcall;

type
  TLMDTaskButtonArray = array[0..MaxInt div 16] of TASKDIALOG_BUTTON;
  PLMDTaskButtonArray = ^TLMDTaskButtonArray;

type
  TASKDIALOGCONFIG = packed record
    cbSize: UINT;
    hwndParent: HWND;
    hInstance: HINST;
    dwFlags: DWORD;
    dwCommonButtons: DWORD;
    pszWindowTitle: LPCWSTR;
    case Integer of
      0: (hMainIcon: HICON);
      1: (pszMainIcon: LPCWSTR;
          pszMainInstruction: LPCWSTR;
          pszContent: LPCWSTR;
          cButtons: UINT;
          pButtons: PLMDTaskButtonArray;
          nDefaultButton: Integer;
          cRadioButtons: UINT;
          pRadioButtons: PLMDTaskButtonArray;
          nDefaultRadioButton: Integer;
          pszVerificationText: LPCWSTR;
          pszExpandedInformation: LPCWSTR;
          pszExpandedControlText: LPCWSTR;
          pszCollapsedControlText: LPCWSTR;
          case Integer of
            0: (hFooterIcon: HICON);
            1: (pszFooterIcon: LPCWSTR;
                pszFooter: LPCWSTR;
                pfCallback: TLMDTaskDialogCallBack;
                lpCallbackData: LONG_PTR;
                cxWidth: UINT

              );
          );
  end;

//  TASKDIALOGCONFIG = record
//    cbSize: uint;
//    hwndParent: HWND;
//    hInstance: longword;
//    dwFlags: dword;
//    dwCommonButtons: dword;
//    pszWindowTitle: PWideChar;
//    case integer of
//      0: (hMainIcon: HICON);
//      1: (
//          pszMainIcon: PWideChar;
//          pszMainInstruction: PWideChar;
//          pszContent: PWideChar;
//          cButtons: uint;
//          pButtons: PLMDTaskButtonArray;
//          nDefaultButton: integer;
//          cRadioButtons: uint;
//          pRadioButtons: PLMDTaskButtonArray;
//          nDefaultRadioButton: integer;
//          pszVerificationText: PWideChar;
//          pszExpandedInformation: PWideChar;
//          pszExpandedControlText: PWideChar;
//          pszCollapsedControlText: PWideChar;
//          case integer of
//            0: (hFooterIcon: HICON);
//            1: (
//                pszFooterIcon: PWideChar;
//                pszFooter: PWideChar;
//                pfCallback: TLMDTaskDialogCallBack;
//                lpCallbackData: LONG_PTR;
//                cxWidth: uint));
//  end;
  PTaskDialogConfig = ^TASKDIALOGCONFIG;
  TTaskDialogConfig = TASKDIALOGCONFIG;

const
  comctl32 = 'comctl32.dll';

type
  TLMDTaskDialogIndirectProc = function (const ptc: TTaskDialogConfig;
                                         var pnButton: Integer;
                                         var pnRadioButton: Integer;
                                         var pfVerificationFlagChecked: Boolean): HRESULT; stdcall;

  TLMDTaskDialogProc = function (hwndParent: HWND; hInstance: longword; pszWindowTitle: PWideChar;
                                 pszMainInstruction: PWideChar; pszContent: PWideChar; dwCommonButtons: dword;
                                 pszIcon: LPWSTR; var pnButton: integer): HRESULT; stdcall;

  TLMDTaskDlgCustomizationEvent = procedure(Sender: TObject; ADialog: TObject) of object;


var
  GOnCustomizationEvent: TLMDTaskDlgCustomizationEvent = nil;
  CIsNativeTaskDialog: Boolean;
  TaskDialogIndirect: TLMDTaskDialogIndirectProc;
  TaskDialog: TLMDTaskDialogProc;

procedure  SwitchToPlatform;
procedure SwitchToNative;

implementation

uses
  LMDTaskDialogTemplate;

var
  CLibHandle: THandle;
  CTaskDialog: TLMDTaskDialogProc;
  CTaskDialogIndirect: TLMDTaskDialogIndirectProc;

procedure SwitchToPlatform;
begin
  CIsNativeTaskDialog := True;
  if Assigned(CTaskDialogIndirect) then
    TaskDialogIndirect := CTaskDialogIndirect
  else
    begin
      TaskDialogIndirect := LMDTaskDialogTemplate.TaskDialogIndirect;
      CIsNativeTaskDialog := False;
    end;
  if Assigned(CTaskDialog) then
    TaskDialog := CTaskDialog
  else
    begin
      TaskDialog := LMDTaskDialogTemplate.TaskDialog;
      CIsNativeTaskDialog := False;
    end;
end;

procedure SwitchToNative;
begin
  TaskDialogIndirect := LMDTaskDialogTemplate.TaskDialogIndirect;
  TaskDialog := LMDTaskDialogTemplate.TaskDialog;
  CIsNativeTaskDialog := False;
end;

procedure Initialize;
begin
  CLibHandle          := LoadLibrary(comctl32);
  CIsNativeTaskDialog := False;
  if CLibHandle <> 0 then
  begin
    CTaskDialogIndirect := GetProcAddress(CLibHandle, 'TaskDialogIndirect');
    CTaskDialog := GetProcAddress(CLibHandle, 'TaskDialog');
    SwitchToPlatform();
  end;
end;

procedure Finalize;
begin
  if CLibHandle <> 0 then
  begin
    TaskDialog := nil;
    TaskDialogIndirect := nil;
    FreeLibrary(CLibHandle);
  end;
end;

initialization
  Initialize;

finalization
  Finalize;

end.
