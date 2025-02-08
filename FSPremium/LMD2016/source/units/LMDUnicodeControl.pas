unit LMDUnicodeControl;
{$I lmdcmps.inc}

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

LMDUnicodeControl unit (YB)
---------------------------
The way for creating Unicode controls in VCL. Behavior of unit utilities
depend of LMD_UNICODE compiler switch state.

Changes
-------
Release 8.0 (January 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, LMDTypes;

type
  {$IFDEF _LMD_UNICODEIMPL}
  TLMDHintWindow = class(TCustomControl)
  private
    FActivating: Boolean;
    FLastActive: Cardinal;

    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    function  GetCaption: TLMDString;
    procedure SetCaption(const Value: TLMDString);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure NCPaint(DC: HDC); virtual;
    procedure Paint; override;
    procedure WMPrint(var Message: TMessage); message WM_PRINT;
  public
    constructor Create(AOwner: TComponent); override;

    procedure ActivateHint(Rect: TRect; const AHint: TLMDString); virtual;
    procedure ActivateHintData(Rect: TRect; const AHint: TLMDString;
                               AData: Pointer); virtual;
    function  CalcHintRect(MaxWidth: Integer; const AHint: TLMDString;
                           AData: Pointer): TRect; virtual;
    function  IsHintMsg(var Msg: TMsg): Boolean; virtual;
    procedure ReleaseHandle;
    property  Caption: TLMDString read GetCaption write SetCaption;
    property  Canvas;
    property  Color;
    property  Font;
  end;
  {$ELSE}
  TLMDHintWindow = THintWindow;
  {$ENDIF}

procedure LMDCreateControlHandle(AControl: TWinControl;
                                 const AParams: TCreateParams;
                                 const AStdClassName: TLMDString);
procedure LMDCreateMDIWindowHandle(AControl: TWinControl;
                                 const AParams: TCreateParams;
                                 const AStdClassName: TLMDString);
function  LMDGetControlText(AControl: TControl): TLMDString;
procedure LMDSetControlText(AControl: TControl; const AValue: TLMDString);
function  LMDGetCharFromMsg(const AMessage: TWMChar): TLMDChar;

procedure LMDDefineUnicodeProperties(const AFiler: TFiler; const AInstance: TPersistent);

function  LMDSendMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM;
                         lParam: LPARAM): LRESULT;
procedure LMDTextRect(ACanvas: TCanvas; Rect: TRect;
                      X, Y: Integer; const Text: TLMDString);

implementation

uses
  TypInfo, Forms, Themes, Variants, LMDUnicode, LMDProcs;

{------------------------------------------------------------------------------}

type
  TWinControlAccess = class(TWinControl);
  TControlAccess    = class(TControl);
  TCanvasAccess     = class(TCanvas);

{------------------------------------------------------------------------------}
type
  TLMDWideStringFiler = class(TObject)
  private
    FPropInfo: PPropInfo;
    FInstance: TPersistent;
    procedure ReadUTF7String(AReader: TReader);
    {$ifndef LMDCOMP7}
    procedure WriteUTF7String(AWriter: TWriter);
    function NeedToBeStored: Boolean;
    {$endif}
  public
    procedure DefineProperties(const AFiler: TFiler; const AInstance: TPersistent; const APropName: String);
  end;

{------------------------------------------------------------------------------}
{$IFDEF _LMD_UNICODEIMPL}
type
  TWndProc = function(HWindow: HWnd; Message, WParam,
                      LParam: Longint): Longint; stdcall;

  TVclHackHandler = class(TComponent)
  private
    FControl:          TControl;
    FDeleted:          Boolean;
    FRecursCount:      Integer;
    FMainWndInst:      Pointer; // For _InitWndProc.
    FWin32Inst:        Pointer;
    FDefWin32Inst:     Pointer;
    FOldWin32Proc:     Pointer;
    FOldDefWin32Proc:  Pointer;
    FOldWindowProc:    TWndMethod;
    FMsgFromWin32Proc: Boolean;
    FText:             WideString;
    FTextAssigned:     Boolean;

    function Handle: THandle;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;

    procedure Win32Proc(var Message: TMessage);
    procedure DefWin32Proc(var Message: TMessage);
    procedure WindowProc(var Message: TMessage);
  public
    constructor Create(AControl: TControl); reintroduce;
    destructor Destroy; override;

    procedure AfterAllocateHandle(const AParams: TCreateParams);
    function  HasStoredText: Boolean;
    function  GetStoredText: WideString;
    procedure SetStoredText(const AValue: WideString);

    class function  Find(AControl: TControl): TVclHackHandler;
    class function  Get(AControl: TControl): TVclHackHandler;
    class function  GetControlText(AControl: TControl): WideString;
    class procedure SetControlText(AControl: TControl; const AValue: WideString);
  end;

var
  InitingControl:  TWinControl;
  WindowAtom:      TAtom;
  ControlAtom:     TAtom;
  VclHackHandlers: TList;

{$ENDIF} // _LMD_UNICODEIMPL

{------------------------------------------------------------------------------}

{$IFDEF _LMD_UNICODEIMPL}
procedure _InitAtoms;
var
  was, cas: string;
begin
  was := Format('Delphi%.8X',[GetCurrentProcessID]);
  cas := Format('ControlOfs%.8X%.8X', [HInstance, GetCurrentThreadID]);
  WindowAtom  := GlobalAddAtom(PChar(was));
  ControlAtom := GlobalAddAtom(PChar(cas));
end;
{$ENDIF}

{------------------------------------------------------------------------------}

{$IFDEF _LMD_UNICODEIMPL}
procedure _FinAtoms;
begin
  GlobalDeleteAtom(WindowAtom);
  GlobalDeleteAtom(ControlAtom);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

{$IFDEF _LMD_UNICODEIMPL}
function _InitWndProc(HWindow: HWnd; Message,
  WParam, LParam: Longint): Longint; stdcall;
var
  ctrl: TWinControlAccess;
  hdr:  TVclHackHandler;
begin
  ctrl := TWinControlAccess(InitingControl);
  hdr  := TVclHackHandler.Get(ctrl);

  ctrl.WindowHandle := HWindow;
  SetWindowLongW(HWindow, GWL_WNDPROC, TLMDPtrInt(hdr.FMainWndInst));

  if (GetWindowLongW(HWindow, GWL_STYLE) and WS_CHILD <> 0) and
     (GetWindowLongW(HWindow, GWL_ID) = 0) then
    SetWindowLongW(HWindow, GWL_ID, HWindow);
  SetProp(HWindow, MakeIntAtom(ControlAtom), Cardinal(ctrl));
  SetProp(HWindow, MakeIntAtom(WindowAtom), Cardinal(ctrl));

  Result := TWndProc(hdr.FMainWndInst)(HWindow, Message, WParam, lParam);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

procedure _CreateWin32Handle(AControl: TWinControl;
  const AParams: TCreateParams; const AStdClassName: TLMDString; const AIsMDIWindow: Boolean = False);

  {$IFDEF _LMD_UNICODEIMPL}
  procedure _RegisterClass(AParams: TCreateParams;
    out AClassName: WideString);
  const
    CLASS_POSTFIX = '_L_M_D_UNICODECLS';
  var
    cls:      TWndClassW;
    cldregd:  Boolean;
    initprog: Pointer;
  begin
    initprog := @_InitWndProc;

    with AParams do
    begin
      AClassName := WinClassName + CLASS_POSTFIX;
      cldregd    := GetClassInfoW(HInstance, PWideChar(AClassName), cls);

      if (not cldregd) or (cls.lpfnWndProc <> initprog) then
      begin
        if cldregd then
          UnregisterClassW(PWideChar(AClassName), HInstance);

        cls               := TWndClassW(WindowClass);
        cls.hInstance     := HInstance;
        cls.lpfnWndProc   := initprog;
        cls.lpszClassName := PWideChar(AClassName);

        if RegisterClassW(cls) = 0 then
          RaiseLastOSError;
      end;
    end;
  end;
  {$ENDIF} // _LMD_UNICODEIMPL

var
  hwnd:   THandle;
  {$IFDEF _LMD_UNICODEIMPL}
  wndcls: TWndClassW;
  clsnm:  WideString;
  hdr:    TVclHackHandler;
  {$ENDIF} // _LMD_UNICODEIMPL
begin
  {$IFDEF _LMD_UNICODEIMPL}
  if LMDIsUnicodePlatform then
  begin
    { Set correct Unicode DefWndProc for standard Windows controls }

    if AStdClassName <> '' then
    begin
      if not GetClassInfoW(AParams.WindowClass.hInstance,
                           PWideChar(AStdClassName), wndcls) then
        RaiseLastOSError;
      TWinControlAccess(AControl).DefWndProc := wndcls.lpfnWndProc
    end
    else
    begin
      if AIsMDIWindow then
        TWinControlAccess(AControl).DefWndProc := @DefMdiChildProcW
      else
        TWinControlAccess(AControl).DefWndProc := @DefWindowProcW;
    end;

    { Ensure Unicode window class is registered }

    _RegisterClass(AParams, clsnm);

    { Create handle }

    InitingControl := AControl;
    with AParams do
    begin
      if AIsMDIWindow then
        hwnd := CreateMDIWindowW(PWideChar(clsnm), nil, Style, X, Y, Width, Height,
                                 Application.MainForm.ClientHandle, HInstance, LPARAM(Param))
      else
        hwnd := CreateWindowExW(ExStyle, PWideChar(clsnm), nil,
                                Style, X, Y, Width, Height, WndParent,
                                0, HInstance, Param);
    end;
    if hwnd = 0 then
      RaiseLastOSError;

    TWinControlAccess(AControl).WindowHandle := hwnd;

    { Hack VCL control }

    hdr := TVclHackHandler.Get(AControl);
    hdr.AfterAllocateHandle(AParams);

    Exit; // Handled.
  end;
  {$ENDIF} // _LMD_UNICODEIMPL

  with AParams do
  begin
    if AIsMDIWindow then
      hwnd := CreateMDIWindow(WinClassName, Caption, Style, X, Y, Width, Height,
                               Application.MainForm.ClientHandle, HInstance, LPARAM(Param))
    else
      hwnd := CreateWindowEx(ExStyle, WinClassName, Caption, Style, X, Y,
                             Width, Height, WndParent, 0,
                             WindowClass.hInstance, Param);
    TWinControlAccess(AControl).WindowHandle := hwnd;
  end;
end;

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}
procedure LMDCreateControlHandle(AControl: TWinControl;
  const AParams: TCreateParams; const AStdClassName: TLMDString);
begin
  _CreateWin32Handle(AControl, AParams, AStdClassName);
  end;

{------------------------------------------------------------------------------}
procedure LMDCreateMDIWindowHandle(AControl: TWinControl;
                                 const AParams: TCreateParams;
                                 const AStdClassName: TLMDString);
begin
  _CreateWin32Handle(AControl, AParams, AStdClassName, True);
  end;

{------------------------------------------------------------------------------}
function LMDGetControlText(AControl: TControl): TLMDString;
begin
  {$IFDEF _LMD_UNICODEIMPL}
  if LMDIsUnicodePlatform then
  begin
    Result := TVclHackHandler.GetControlText(AControl);
    Exit;
  end;
  {$ENDIF}

  Result := TControlAccess(AControl).Text;
  end;

{------------------------------------------------------------------------------}
procedure LMDSetControlText(AControl: TControl; const AValue: TLMDString);
begin
  {$IFDEF _LMD_UNICODEIMPL}
  if LMDIsUnicodePlatform then
  begin
    TVclHackHandler.SetControlText(AControl, AValue);
    Exit;
  end;
  {$ENDIF}

  TControlAccess(AControl).Text := AValue;
  end;

{------------------------------------------------------------------------------}
function LMDGetCharFromMsg(const AMessage: TWMChar): TLMDChar;
begin
  {$IFDEF _LMD_UNICODEIMPL}
  if AMessage.CharCode = $FF then
    Result := WideChar(AMessage.Unused)
  else
    Result := WideChar(Char(AMessage.CharCode));
  {$ELSE}
  Result := Char(AMessage.CharCode);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure LMDDefineUnicodeProperties(const AFiler: TFiler;
                                     const AInstance: TPersistent);
var
  LPropCount: Integer;
  LPropList: PPropList;
  LWStringFiler: TLMDWideStringFiler;
  i: Integer;
begin
  // TODO: Add WideChar type properties
  LWStringFiler := TLMDWideStringFiler.Create;
  LPropCount := GetPropList(AInstance.ClassInfo, [tkWString], nil);
  GetMem(LPropList, LPropCount * SizeOf(PPropInfo));
  try
    GetPropList(AInstance.ClassInfo, [tkWString], LPropList);
    for i := 0 to LPropCount - 1 do
    begin
      if Assigned(LPropList^[i]) then
        case LPropList^[i]^.PropType^.Kind of
          tkWString:
             LWStringFiler.DefineProperties(AFiler, AInstance, String(LPropList^[i]^.Name));
        end;
      end;
  finally
    FreeMem(LPropList);
    LWStringFiler.Free;
  end;
end;

{------------------------------------------------------------------------------}
function LMDSendMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  // Can't test LMDIsUnicodePlatform here because if the message
  // parameters is Unicode, it just incorrect to call SendMessageA().
  {$IFDEF _LMD_UNICODEIMPL}
  Result := SendMessageW(hWnd, Msg, wParam, lParam);
  {$ELSE}
  Result := SendMessage(hWnd, Msg, wParam, lParam);
  {$ENDIF}
end;

{ ---------------------------------------------------------------------------- }
procedure LMDTextRect(ACanvas: TCanvas; Rect: TRect; X, Y: Integer; const Text: TLMDString);
{$IFDEF _LMD_UNICODEIMPL}
var
  Options: Longint;
{$ENDIF}
begin
  {$IFDEF _LMD_UNICODEIMPL}
  if LMDIsUnicodePlatform then
  begin
    TCanvasAccess(ACanvas).Changing;
    TCanvasAccess(ACanvas).RequiredState([csHandleValid, csFontValid,
                                          csBrushValid]);

    Options := ETO_CLIPPED or ACanvas.TextFlags;
    if ACanvas.Brush.Style <> bsClear then
      Options := Options or ETO_OPAQUE;

    if ((ACanvas.TextFlags and ETO_RTLREADING) <> 0) and
       (ACanvas.CanvasOrientation = coRightToLeft) then
      Inc(X, ACanvas.TextWidth(Text) + 1);

    Windows.ExtTextOutW(
      ACanvas.Handle, X, Y, Options, @Rect, PLMDChar(Text),
      Length(Text), nil
    );

    TCanvasAccess(ACanvas).Changed;
    Exit;
  end;
  {$ENDIF}

  ACanvas.TextRect(Rect, X, Y, Text);
end;

{**************************** TLMDWideStringFiler *****************************}
{------------------------------------------------------------------------------}
procedure TLMDWideStringFiler.DefineProperties(const AFiler: TFiler;
                                               const AInstance: TPersistent;
                                               const APropName: String);
begin
  FInstance := AInstance;
  FPropInfo := GetPropInfo(AInstance, APropName);
  try
    AFiler.DefineProperty(APropName + 'UTF7', ReadUTF7String,
                         {$ifndef LMDCOMP7}WriteUTF7String{$else}nil{$endif},
                         {$ifndef LMDCOMP7}NeedToBeStored{$else}False{$endif});
  finally
    FPropInfo := nil;
    FInstance := nil;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideStringFiler.ReadUTF7String(AReader: TReader);
begin
  SetWideStrProp(FInstance, FPropInfo, LMDConvertUTF7ToUTF16(AnsiString(AReader.ReadString)));
end;

{$ifndef LMDCOMP7}
{------------------------------------------------------------------------------}
procedure TLMDWideStringFiler.WriteUTF7String(AWriter: TWriter);
begin
  AWriter.WriteString(LMDConvertUTF16ToUTF7(GetWideStrProp(FInstance, FPropInfo), False));
end;

{------------------------------------------------------------------------------}
function TLMDWideStringFiler.NeedToBeStored: Boolean;
begin
  Result := IsStoredProp(FInstance, FPropInfo) and
            not (VarIsEmpty(GetPropValue(FInstance, FPropInfo^.Name)));
end;
{$endif}

{$IFDEF _LMD_UNICODEIMPL}
{****************************** TVclHackHandler *******************************}
{------------------------------------------------------------------------------}
constructor TVclHackHandler.Create(AControl: TControl);
begin
  inherited Create(nil);

  FControl      := TWinControlAccess(AControl);
  FWin32Inst    := Classes.MakeObjectInstance(Win32Proc);
  FDefWin32Inst := Classes.MakeObjectInstance(DefWin32Proc);

  if FControl is TWinControl then
    FMainWndInst := Classes.MakeObjectInstance(TWinControlAccess(FControl).MainWndProc);

  FControl.FreeNotification(Self);
  VclHackHandlers.Add(Self);
end;

{------------------------------------------------------------------------------}

procedure TVclHackHandler.DefWin32Proc(var Message: TMessage);
var
  len:  Integer;
  text: WideString;
begin
  with Message do
  begin
    case Msg of
      WM_CHAR:    if TWMChar(Message).CharCode = $FF then
                  begin
                    TWMChar(Message).CharCode := TWMChar(Message).Unused;
                    TWMChar(Message).Unused   := 0;
                  end;
      WM_DESTROY: begin
                    { Store window text for future use }
                    len := GetWindowTextLengthW(Handle);
                    SetLength(text, len);
                    if len > 0 then
                      GetWindowTextW(Handle, @text[1], len + 1);

                    SetStoredText(text);
                  end;
    end;

    Result := TWndProc(FOldDefWin32Proc)(Handle, Msg, wParam, lParam);

    if Msg = WM_DESTROY then
    begin
      { Un-hack window procs }

      FControl.WindowProc                    := FOldWindowProc;
      TWinControlAccess(FControl).DefWndProc := FOldDefWin32Proc;
      SetWindowLongW(Handle, GWL_WNDPROC, TLMDPtrInt(FOldWin32Proc));
    end;
  end;
end;

{------------------------------------------------------------------------------}
destructor TVclHackHandler.Destroy;
begin
  if FWin32Inst <> nil then
    Classes.FreeObjectInstance(FWin32Inst);
  if FDefWin32Inst <> nil then
    Classes.FreeObjectInstance(FDefWin32Inst);
  if FMainWndInst <> nil then
    Classes.FreeObjectInstance(FMainWndInst);

  VclHackHandlers.Remove(Self);

  inherited;
end;

{------------------------------------------------------------------------------}
class function TVclHackHandler.Get(AControl: TControl): TVclHackHandler;
begin
  Result := Find(AControl);
  if Result = nil then
    Result := TVclHackHandler.Create(AControl);
end;

{------------------------------------------------------------------------------}
function TVclHackHandler.Handle: THandle;
begin
  Result := TWinControlAccess(FControl).WindowHandle; // Do not force handle
                                                      // allocation.
end;

{------------------------------------------------------------------------------}
procedure TVclHackHandler.AfterAllocateHandle(const AParams: TCreateParams);
var
  text: WideString;
begin
  Assert(FControl is TWinControl);

  { Hack window procs }

  FOldWin32Proc := Pointer(GetWindowLongW(Handle, GWL_WNDPROC));
  SetWindowLongW(Handle, GWL_WNDPROC, TLMDPtrInt(FWin32Inst));

  FOldDefWin32Proc := TWinControlAccess(FControl).DefWndProc;
  TWinControlAccess(FControl).DefWndProc := FDefWin32Inst;

  FOldWindowProc      := FControl.WindowProc;
  FControl.WindowProc := WindowProc;

  { Set stored text to window }

  if HasStoredText then
    text := GetStoredText
  else
    text := AParams.Caption;

  if not SetWindowTextW(Handle, PWideChar(text)) then
    RaiseLastOSError;
end;

{------------------------------------------------------------------------------}
procedure TVclHackHandler.Win32Proc(var Message: TMessage);
begin
  Inc(FRecursCount);
  try
    with Message do
    begin
      FMsgFromWin32Proc := True;
      Result            := TWndProc(FOldWin32Proc)(Handle, Msg, wParam, lParam);
    end;
  finally
    Dec(FRecursCount);
    if (FRecursCount = 0) and FDeleted then
      Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TVclHackHandler.WindowProc(var Message: TMessage);

  function _IsTextMsg(AMsg: Cardinal): Boolean;
  begin
    Result := (AMsg = WM_SETTEXT) or (AMsg = WM_GETTEXT) or
              (AMsg = WM_GETTEXTLENGTH); // No WM_CHAR here because of
                                         // special handling.
  end;

var
  isVclMsg: Boolean;
begin
  isVclMsg          := not FMsgFromWin32Proc; // Message from Perform, ect.
  FMsgFromWin32Proc := False;

  with Message do
    begin
      if isVclMsg and _IsTextMsg(Msg) then
        begin
          Assert(TWinControl(FControl).HandleAllocated);
          Result := SendMessageA(Handle, Msg, wParam, lParam);
        end
      else
        begin
          if (Msg = WM_CHAR) and
             (TWMChar(Message).CharCode > Ord(High(AnsiChar))) then
          begin
            TWMChar(Message).Unused   := TWMChar(Message).CharCode;
            TWMChar(Message).CharCode := $FF;
          end;
          FOldWindowProc(Message);
        end;
    end;
end;

{------------------------------------------------------------------------------}
class function TVclHackHandler.GetControlText(AControl: TControl): WideString;
var
  hdr:  TVclHackHandler;
  hwnd: THandle;
  len:  Integer;
begin
  if (AControl is TWinControl) and
     TWinControl(AControl).HandleAllocated then
    begin
      hwnd := TWinControl(AControl).Handle;

      len := GetWindowTextLengthW(hwnd);
      SetLength(Result, len);
      if len > 0 then
        GetWindowTextW(hwnd, @Result[1], len + 1);
    end
  else
    begin
      hdr := Find(AControl);
      if (hdr <> nil) and hdr.HasStoredText then
        Result := hdr.GetStoredText
      else
        Result := TControlAccess(AControl).Text;
    end;
end;

{------------------------------------------------------------------------------}
class procedure TVclHackHandler.SetControlText(AControl: TControl;
  const AValue: WideString);
var
  hdr:  TVclHackHandler;
  hwnd: THandle;
begin
  if (AControl is TWinControl) and
     TWinControl(AControl).HandleAllocated then
    begin
      hwnd := TWinControl(AControl).Handle;
      if not SetWindowTextW(hwnd, PWideChar(AValue)) then
        RaiseLastOSError;
    end
  else
    begin
      hdr := Get(AControl);
      hdr.SetStoredText(AValue);
    end;

  AControl.Perform(CM_TEXTCHANGED, 0, 0);
end;

{------------------------------------------------------------------------------}
class function TVclHackHandler.Find(AControl: TControl): TVclHackHandler;
var
  i: Integer;
begin
  for i := 0 to VclHackHandlers.Count - 1 do
    begin
      Result := TVclHackHandler(VclHackHandlers[i]);
      if Result.FControl = AControl then
        Exit;
    end;

  Result := nil;
end;

{------------------------------------------------------------------------------}

function TVclHackHandler.GetStoredText: WideString;
begin
  Assert(FTextAssigned);
  Result := FText;
end;

{------------------------------------------------------------------------------}

procedure TVclHackHandler.SetStoredText(const AValue: WideString);
begin
  FText         := AValue;
  FTextAssigned := True;
end;

{------------------------------------------------------------------------------}

function TVclHackHandler.HasStoredText: Boolean;
begin
  Result := FTextAssigned;
end;

{------------------------------------------------------------------------------}

procedure TVclHackHandler.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (AComponent = FControl) and (Operation = opRemove) then
    begin
      FControl.RemoveFreeNotification(Self);

      if FRecursCount = 0 then
        Free
      else
        FDeleted := True;
    end;
end;

{$ENDIF} // _LMD_UNICODEIMPL

{****************************** TLMDHintWindow ********************************}
{------------------------------------------------------------------------------}
{$IFDEF _LMD_UNICODEIMPL}

procedure TLMDHintWindow.ActivateHint(Rect: TRect; const AHint: TLMDString);
type
  TAnimationStyle = (atSlideNeg, atSlidePos, atBlend);
const
  AnimationStyle: array[TAnimationStyle] of Integer = (AW_VER_NEGATIVE, AW_VER_POSITIVE, AW_BLEND);
var
  Animate: BOOL;
  Style: TAnimationStyle;
begin
  FActivating := True;
  try
    Caption := AHint;
    Inc(Rect.Bottom, 4);
    UpdateBoundsRect(Rect);
    if Rect.Top + Height > Screen.DesktopHeight then
      Rect.Top := Screen.DesktopHeight - Height;
    if Rect.Left + Width > Screen.DesktopWidth then
      Rect.Left := Screen.DesktopWidth - Width;
    if Rect.Left < Screen.DesktopLeft then Rect.Left := Screen.DesktopLeft;
    if Rect.Bottom < Screen.DesktopTop then Rect.Bottom := Screen.DesktopTop;
    SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, Width, Height, SWP_NOACTIVATE);
    if (GetTickCount - FLastActive > 250) and (Length(AHint) < 100) and
       Assigned(AnimateWindowProc) then
    begin
      SystemParametersInfo(SPI_GETTOOLTIPANIMATION, 0, @Animate, 0);
      if Animate then
      begin
        SystemParametersInfo(SPI_GETTOOLTIPFADE, 0, @Animate, 0);
        if Animate then
          Style := atBlend
        else
          if Mouse.CursorPos.Y > Rect.Top then
            Style := atSlideNeg
          else
            Style := atSlidePos;
        AnimateWindowProc(Handle, 100, AnimationStyle[Style] or AW_SLIDE);
      end;
    end;
    ParentWindow := Application.Handle;
    ShowWindow(Handle, SW_SHOWNOACTIVATE);
    Invalidate;
  finally
    FLastActive := GetTickCount;
    FActivating := False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.ActivateHintData(Rect: TRect; const AHint: TLMDString; AData: Pointer);
begin
  ActivateHint(Rect, AHint);
end;

{------------------------------------------------------------------------------}
function TLMDHintWindow.CalcHintRect(MaxWidth: Integer; const AHint: TLMDString; AData: Pointer): TRect;
begin
  Result := Rect(0, 0, MaxWidth, 0);

  if LMDIsUnicodePlatform then
    DrawTextW(Canvas.Handle, PLMDChar(AHint), -1, Result,
              DT_CALCRECT or DT_LEFT or DT_WORDBREAK or DT_NOPREFIX or
              DrawTextBiDiModeFlagsReadingOnly)
  else
    DrawText(Canvas.Handle, PChar(string(AHint)), -1, Result,
             DT_CALCRECT or DT_LEFT or DT_WORDBREAK or DT_NOPREFIX or
             DrawTextBiDiModeFlagsReadingOnly);

  Inc(Result.Right, 6);
  Inc(Result.Bottom, 2);
end;

{------------------------------------------------------------------------------}

procedure TLMDHintWindow.CMTextChanged(var Message: TMessage);
begin
  inherited;
  { Avoid flicker when calling ActivateHint }
  if FActivating then
    Exit;
  Width  := Canvas.TextWidth(Caption) + 6;
  Height := Canvas.TextHeight(Caption) + 4;
end;

{------------------------------------------------------------------------------}

constructor TLMDHintWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Color              := $80FFFF;
  Canvas.Font        := Screen.HintFont;
  Canvas.Brush.Style := bsClear;
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      Style := WS_POPUP or WS_BORDER;
      WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
      if NewStyleControls then
        ExStyle := WS_EX_TOOLWINDOW;
      {$IFDEF LMDCOMP7}
      // CS_DROPSHADOW requires Windows XP or above
      if CheckWin32Version(5, 1) then
        WindowClass.Style := WindowClass.Style or CS_DROPSHADOW;
      {$ENDIF}
      if NewStyleControls then ExStyle := WS_EX_TOOLWINDOW;
      AddBiDiModeExStyle(ExStyle);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.CreateWindowHandle(const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, '');
end;

{------------------------------------------------------------------------------}
function TLMDHintWindow.GetCaption: TLMDString;
begin
  Result := LMDGetControlText(Self);
end;

{------------------------------------------------------------------------------}
function TLMDHintWindow.IsHintMsg(var Msg: TMsg): Boolean;
begin
  with Msg do
    Result := ((Message >= WM_KEYFIRST) and (Message <= WM_KEYLAST)) or
              ((Message = CM_ACTIVATE) or (Message = CM_DEACTIVATE)) or
              (Message = CM_APPKEYDOWN) or (Message = CM_APPSYSCOMMAND) or
              (Message = WM_COMMAND) or ((Message > WM_MOUSEMOVE) and
              (Message <= WM_MOUSELAST)) or (Message = WM_NCMOUSEMOVE);
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.NCPaint(DC: HDC);
var
  R: TRect;
  Details: TThemedElementDetails;
begin
  R := Rect(0, 0, Width, Height);
  if ThemeServices.ThemesEnabled then
  begin
    Details := ThemeServices.GetElementDetails(twWindowRoot);
    ThemeServices.DrawEdge(DC, Details, R, BDR_RAISEDOUTER, BF_RECT);
    Exit;
  end;
  Windows.DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT)
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  Canvas.Font.Color := Screen.HintFont.Color;

  if LMDIsUnicodePlatform then
    DrawTextW(Canvas.Handle, PLMDChar(LMDGetControlText(Self)), -1, R,
              DT_LEFT or DT_NOPREFIX or DT_WORDBREAK or
              DrawTextBiDiModeFlagsReadingOnly)
  else
    DrawText(Canvas.Handle, PChar(string(LMDGetControlText(Self))), -1, R,
             DT_LEFT or DT_NOPREFIX or DT_WORDBREAK or
             DrawTextBiDiModeFlagsReadingOnly);
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.ReleaseHandle;
begin
  DestroyHandle;
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.SetCaption(const Value: TLMDString);
begin
  LMDSetControlText(Self, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.WMNCPaint(var Message: TMessage);
var
  DC: HDC;
begin
  DC := GetWindowDC(Handle);
  try
    NCPaint(DC);
  finally
    ReleaseDC(Handle, DC);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.WMPrint(var Message: TMessage);
begin
  PaintTo(Message.WParam, 0, 0);
  NCPaint(Message.WParam);
end;

{$ENDIF} // _LMD_UNICODEIMPL
{------------------------------------------------------------------------------}

{$IFDEF _LMD_UNICODEIMPL}
initialization
  VclHackHandlers := TList.Create;
  _InitAtoms;

finalization
  _FinAtoms;
  VclHackHandlers.Free;
{$ENDIF}

end.
