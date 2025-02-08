unit LMDExceptionHook;
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

LMDExceptionHook unit (EN)
---------------------------
Hook exceptons in Win32 code

Changes
-------
Release 8.0 (Mart 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Windows, Classes, Forms, Dialogs,
  LMDLogMessage;

{$ifdef LMDX86}
type
  TLMDApplicationExceptionHandler = procedure(Sender: TObject; E: Exception) of object;
  TLMDExceptionHandler = procedure(Sender: TObject; AExceptionMessage: string; AExceptionAddr: Pointer) of object;

  TLMDExceptionHook = class(TObject)
  private
    FMaxLevel: Integer;
    FShowCallStack: Boolean;
    FShowSystemUnit: Boolean;
    FSystemException: TLMDExceptionHandler;
    FApplicationException: TLMDExceptionHandler;
    FKernel32Exception: TLMDExceptionHandler;
    procedure ApplicationExceptionHandler(Sender: TObject; E: Exception);
    function GetAppicationException: TLMDApplicationExceptionHandler;
    function GetHookAppicationException: Boolean;
    function GetHookSystemException: Boolean;
    procedure SetAppicationException(Value: TLMDApplicationExceptionHandler);
    procedure SetHookAppicationException(Value: Boolean);
    procedure SetHookSystemException(Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure HookExeptionInModule(AModuleHandle: HMODULE);
    class function Instance: TLMDExceptionHook;
    procedure ShowExceptionMessage(AExceptAddr: Pointer; AExceptionMessage: string);
    property AppicationException: TLMDApplicationExceptionHandler read
      GetAppicationException write SetAppicationException;
    property HookAppicationException: Boolean read GetHookAppicationException
      write SetHookAppicationException;
    property HookSystemException: Boolean read GetHookSystemException write
      SetHookSystemException;
    property MaxLevel: Integer read FMaxLevel write FMaxLevel;
    property ShowCallStack: Boolean read FShowCallStack write FShowCallStack;
    property ShowSystemUnit: Boolean read FShowSystemUnit write FShowSystemUnit;
    property SystemException: TLMDExceptionHandler read FSystemException write FSystemException;
    property ApplicationException: TLMDExceptionHandler read FApplicationException write FApplicationException;
    property Kernel32Exception: TLMDExceptionHandler read FKernel32Exception write FKernel32Exception;
  end;
{$endif}

implementation

{$ifdef LMDX86}
uses
  LMDInprocHookAPI, LMDMapFile, LMDCallStack;

type
  PExceptionArguments = ^TLMDExceptionArguments;
  TLMDExceptionArguments = record
    ExceptAddr: Pointer;
    ExceptObj: Exception;
  end;

var
  FInstance: TLMDExceptionHook;

  SystemExceptObjProc: function(P: PExceptionRecord): Exception;

  Kernel32_RaiseException: procedure(dwExceptionCode, dwExceptionFlags,
    nNumberOfArguments: DWORD; lpArguments: PDWORD); stdcall;

function SytemExceptionHandler(P: PExceptionRecord): Exception;
begin
  Result := SystemExceptObjProc(P);
  //AIH
  if Assigned(TLMDExceptionHook.Instance.SystemException) then
    TLMDExceptionHook.Instance.SystemException(nil, Result.Message, P^.ExceptionAddress);
  // TLMDExceptionHook.Instance.ShowExceptionMessage(P^.ExceptionAddress, Result.Message);
end;

procedure Kernel32RaiseExceptionHandler(ExceptionCode, ExceptionFlags, NumberOfArguments: DWORD;
  Arguments: PExceptionArguments); stdcall;
const
  DelphiExceptionCode = $0EEDFADE;
  NonContinuable = 1;
begin
  if Assigned(TLMDExceptionHook.Instance.Kernel32Exception) then
  begin
    if (ExceptionFlags = NonContinuable) and (ExceptionCode = DelphiExceptionCode) and
      (NumberOfArguments = 7) and (DWORD(Arguments) = DWORD(@Arguments) + 4) then
      TLMDExceptionHook.Instance.Kernel32Exception(nil, Arguments.ExceptObj.Message, Arguments.ExceptAddr)
        //TLMDExceptionHook.Instance.ShowExceptionMessage(Arguments.ExceptAddr,Arguments.ExceptObj.Message)
    else
      TLMDExceptionHook.Instance.Kernel32Exception(nil, 'Unknown Error', nil);
    // TLMDExceptionHook.Instance.ShowExceptionMessage(nil, 'Unknown Error');
  end;
  Kernel32_RaiseException(ExceptionCode, ExceptionFlags, NumberOfArguments, PDWORD(Arguments));
end;

{
****************************** TLMDExceptionHook *******************************
}

constructor TLMDExceptionHook.Create;
begin
  inherited Create;

  FMaxLevel := 10;
  FShowCallStack := true;
  FShowSystemUnit := false;
end;

destructor TLMDExceptionHook.Destroy;
begin
  if FInstance = Self then
    FInstance := nil;
  inherited Destroy;
end;

procedure TLMDExceptionHook.ApplicationExceptionHandler(Sender: TObject; E:
  Exception);
begin
  // ShowExceptionMessage(ExceptAddr, E.Message);
  if Assigned(TLMDExceptionHook.Instance.ApplicationException) then
    TLMDExceptionHook.Instance.ApplicationException(Sender, E.Message, ExceptAddr);
end;

function TLMDExceptionHook.GetAppicationException:
  TLMDApplicationExceptionHandler;
begin
  result := Application.OnException;
end;

function TLMDExceptionHook.GetHookAppicationException: Boolean;
begin
  result := Assigned(Application.OnException);
end;

function TLMDExceptionHook.GetHookSystemException: Boolean;
begin
  result := Assigned(SystemExceptObjProc);
end;

procedure TLMDExceptionHook.HookExeptionInModule(AModuleHandle: HMODULE);
begin
  Kernel32_RaiseException := //GetProcAddressETA(AModuleHandle, 'RaiseException');
  HookImportTableApiFunction(AModuleHandle,
    kernel32,
    'RaiseException',
    Pointer(@Kernel32RaiseExceptionHandler));
  //SetProcAddressETA(AModuleHandle, 'RaiseException', @Kernel32RaiseExceptionHandler);
end;

class function TLMDExceptionHook.Instance: TLMDExceptionHook;
begin
  if not Assigned(FInstance) then
    FInstance := TLMDExceptionHook.Create;
  Result := FInstance;
end;

procedure TLMDExceptionHook.SetAppicationException(Value:
  TLMDApplicationExceptionHandler);
begin
  Application.OnException := Value;
end;

procedure TLMDExceptionHook.SetHookAppicationException(Value: Boolean);
begin
  if Value then
    AppicationException := ApplicationExceptionHandler
  else
    AppicationException := nil;
end;

procedure TLMDExceptionHook.SetHookSystemException(Value: Boolean);
begin
  if Value and (not Assigned(SystemExceptObjProc)) then
  begin
    SystemExceptObjProc := System.ExceptObjProc;
    System.ExceptObjProc := @SytemExceptionHandler;
  end;
  if (not Value) and Assigned(SystemExceptObjProc) then
  begin
    System.ExceptObjProc := @SystemExceptObjProc;
    SystemExceptObjProc := nil;
  end;
end;

procedure TLMDExceptionHook.ShowExceptionMessage(AExceptAddr: Pointer;
  AExceptionMessage: string);
var
  Str: string;
  LMapFileAddress: LongWord;
  i, LMaxIndex: Integer;
  LLevel: Integer;
begin
  LMapFileAddress := TLMDMapFile.Instance.MapFileAddress(AExceptAddr);
  Str := 'Exception: ' + AExceptionMessage + #10#13 +
    ' Module: ' + TLMDMapFile.Instance.UnitName(LMapFileAddress) + #10#13 +
    ' Procedure: ' + TLMDMapFile.Instance.ProcedureName(LMapFileAddress) + #10#13 +
    ' Line: ' + TLMDMapFile.Instance.LineNumber(LMapFileAddress);

  if FShowCallStack then
  begin
    Str := Str + #10#13 + 'Call Stack:';
    LLevel := 0;
    LMaxIndex := TLMDCallStack.Instance.FillCallStack(100);
    for i := 7 to LMaxIndex do
    begin
      if FShowSystemUnit then
      begin
        Str := Str + #10#13 +
          '  Module: ' + TLMDCallStack.Instance.StackFrames[i].Filename + '; ' +
          '  Procedure: ' + TLMDCallStack.Instance.StackFrames[i].Method + '; ' +
          '  Line: ' + IntToStr(TLMDCallStack.Instance.StackFrames[i].LineNumber);
        Inc(LLevel);
        if LLevel >= FMaxLevel then
          break;
      end;
    end;
  end;
  MessageDlg(Str, mtError, [mbOk], 0);
end;

begin
  FInstance := nil;

  SystemExceptObjProc := nil;
  Kernel32_RaiseException := nil;

  TLMDExceptionHook.Instance.HookSystemException := false;
  TLMDExceptionHook.Instance.HookAppicationException := true;
  TLMDExceptionHook.Instance.ShowSystemUnit := True;
{$endif}
end.
