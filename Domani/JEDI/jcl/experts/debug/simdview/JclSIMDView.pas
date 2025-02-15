{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is: JvSIMDView.pas, released on 2004-10-11.                                    }
{                                                                                                  }
{ The Initial Developer of the Original Code is Florent Ouchet                                     }
{ [ouchet dott florent att laposte dott net]                                                       }
{ Portions created by Florent Ouchet are Copyright (C) 2004 Florent Ouchet.                        }
{ All Rights Reserved.                                                                             }
{                                                                                                  }
{ You may retrieve the latest version of this file at the Project JEDI's JCL home page,            }
{ located at http://jcl.sourceforge.net                                                            }
{                                                                                                  }
{**************************************************************************************************}

// $Id: JclSIMDView.pas,v 1.10 2006/01/08 17:16:56 outchy Exp $

unit JclSIMDView;

{$I jcl.inc}
                     
interface

uses
  Windows, Classes, Menus, ActnList, ToolsAPI, SysUtils, Graphics, Dialogs,
  Forms, ComCtrls,
  JclOtaUtils, JclSIMDViewForm, JclSysInfo;

{$R 'JclSIMDIcon.dcr'}

type
  TProcessReference = record
    Process: IOTAProcess;
    ID: Integer;
  end;
  PProcessReference = ^TProcessReference;

  TThreadReference = record
    Thread: IOTAThread;
    ID: Integer;
  end;
  PThreadReference = ^TThreadReference;

  TJclDebuggerNotifier = class;

  TJclSIMDWizard = class(TJclOTAExpert)
  private
    FDebuggerServices: IOTADebuggerServices;
    FIndex: Integer;
    FDebuggerNotifier: TJclDebuggerNotifier;
    FIcon: TIcon;
    FSIMDMenuItem: TMenuItem;
    FViewDebugMenu: TMenuItem;
    FForm: TJclSIMDViewFrm;
    FCpuInfo: TCpuInfo;
    FCpuInfoValid: Boolean;
  protected
    FSIMDAction: TAction;
    procedure SIMDActionExecute(Sender: TObject);
    procedure SIMDActionUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    function CpuInfo: TCpuInfo;
    function GetSIMDString: string;
    procedure RegisterCommands; override;
    procedure UnregisterCommands; override;
    procedure RefreshThreadContext(WriteOldContext: Boolean);
    procedure CloseForm;
    procedure ThreadEvaluate(const ExprStr, ResultStr: string; ReturnCode: Integer);
    property DebuggerServices: IOTADebuggerServices read FDebuggerServices;
  end;

  TJclDebuggerNotifier = class(TNotifierObject,IOTADebuggerNotifier,
    IOTAProcessNotifier, IOTAThreadNotifier)
  private
    FOwner: TJclSIMDWizard;
    FProcessList: TList;
    FThreadList: TList;
    function FindProcessReference(AProcess:IOTAProcess): PProcessReference;
    function FindThreadReference(AThread:IOTAThread): PThreadReference;
  public
    constructor Create(AOwner: TJclSIMDWizard); reintroduce;
    destructor Destroy; override;
    // IOTADebuggerNotifier
    procedure ProcessCreated({$IFDEF RTL170_UP} const {$ENDIF} Process: IOTAProcess);
    procedure ProcessDestroyed({$IFDEF RTL170_UP} const {$ENDIF} Process: IOTAProcess);
    procedure BreakpointAdded({$IFDEF RTL170_UP} const {$ENDIF} Breakpoint: IOTABreakpoint);
    procedure BreakpointDeleted({$IFDEF RTL170_UP} const {$ENDIF} Breakpoint: IOTABreakpoint);
    // IOTAProcessNotifier
    procedure ThreadCreated({$IFDEF RTL170_UP} const {$ENDIF} Thread: IOTAThread);
    procedure ThreadDestroyed({$IFDEF RTL170_UP} const {$ENDIF} Thread: IOTAThread);
    procedure ProcessModuleCreated({$IFDEF RTL170_UP} const {$ENDIF} ProcessModule: IOTAProcessModule);
    procedure ProcessModuleDestroyed({$IFDEF RTL170_UP} const {$ENDIF} ProcessModule: IOTAProcessModule);
    // IOTAThreadNotifier
    procedure ThreadNotify(Reason: TOTANotifyReason);
    procedure EvaluteComplete(const ExprStr, ResultStr: string;
      CanModify: Boolean; ResultAddress, ResultSize: LongWord; ReturnCode: Integer);
    procedure ModifyComplete(const ExprStr, ResultStr: string; ReturnCode: Integer);
    property Owner: TJclSIMDWizard read FOwner;
  end;

// design package entry point
procedure Register;

// expert DLL entry point
function JCLWizardInit(const BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc;
  var TerminateProc: TWizardTerminateProc): Boolean; stdcall;

implementation

uses
  JclOtaConsts, JclOtaResources, 
  JclSIMDUtils;

const
  RsSIMDActionName = 'DebugSSECommand';

procedure Register;
begin
  try
    RegisterPackageWizard(TJclSIMDWizard.Create);
  except
    on ExceptObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptObj);
      raise;
    end;
  end;
end;

var
  JCLWizardIndex: Integer = -1;

procedure JclWizardTerminate;
var
  OTAWizardServices: IOTAWizardServices;
begin
  try
    if JCLWizardIndex <> -1 then
    begin
      Supports(BorlandIDEServices, IOTAWizardServices, OTAWizardServices);
      if not Assigned(OTAWizardServices) then
        raise EJclExpertException.CreateTrace(RsENoWizardServices);

      OTAWizardServices.RemoveWizard(JCLWizardIndex);
    end;
  except
    on ExceptionObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptionObj);
    end;
  end;
end;

function JCLWizardInit(const BorlandIDEServices: IBorlandIDEServices;
    RegisterProc: TWizardRegisterProc;
    var TerminateProc: TWizardTerminateProc): Boolean stdcall;
var
  OTAWizardServices: IOTAWizardServices;
begin
  try
    TerminateProc := JclWizardTerminate;

    Supports(BorlandIDEServices, IOTAWizardServices, OTAWizardServices);
    if not Assigned(OTAWizardServices) then
      raise EJclExpertException.CreateTrace(RsENoWizardServices);

    JCLWizardIndex := OTAWizardServices.AddWizard(TJclSIMDWizard.Create);

    Result := True;
  except
    on ExceptionObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptionObj);
      Result := False;
    end;
  end;
end;

//=== { TJclSIMDWizard } =====================================================

constructor TJclSIMDWizard.Create;
begin
  inherited Create(JclSIMDExpertName);
  FCpuInfoValid := False;
  FForm := nil;
end;

destructor TJclSIMDWizard.Destroy;
begin
  DebuggerServices.RemoveNotifier(FIndex);
  //FreeAndNil(FDebuggerNotifier);   // Buggy !!!!
  FreeAndNil(FForm);
  FDebuggerServices := nil;

  inherited Destroy;
end;

procedure TJclSIMDWizard.SIMDActionExecute(Sender: TObject);
begin
  try
    if CpuInfo.SSE = 0 then
      raise EJclExpertException.CreateTrace(RsNoSSE);

    if not Assigned(FForm) then
    begin
      FForm := TJclSIMDViewFrm.Create(Application, DebuggerServices, Settings);

      FForm.Icon := FIcon;
      FForm.OnDestroy := FormDestroy;
      FForm.SIMDCaption := GetSIMDString;

      FForm.Show;
    end
    else
      FForm.Show;
  except
    on ExceptObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptObj);
      raise;
    end;
  end;
end;

procedure TJclSIMDWizard.SIMDActionUpdate(Sender: TObject);
var
  AProcess: IOTAProcess;
  AThread: IOTAThread;
  AAction: TAction;
begin
  try
    AAction := Sender as TAction;

    if (CpuInfo.SSE <> 0) or CPUInfo.MMX or CPUInfo._3DNow then
    begin
      AThread := nil;
      AProcess := nil;
      if DebuggerServices.ProcessCount > 0 then
        AProcess := DebuggerServices.CurrentProcess;
      if (AProcess <> nil) and (AProcess.ThreadCount > 0) then
        AThread := AProcess.CurrentThread;
      if AThread <> nil then
        AAction.Enabled := AThread.State in [tsStopped, tsBlocked]
      else
        AAction.Enabled := False;
    end
    else
      AAction.Enabled := False
  except
    on ExceptObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptObj);
      raise;
    end;
  end;
end;

procedure TJclSIMDWizard.CloseForm;
begin
  if Assigned(FForm) then
    FForm.Close;
end;

function TJclSIMDWizard.CpuInfo: TCpuInfo;
begin
  if not FCpuInfoValid then
  begin
    GetCpuInfo(FCpuInfo);
    FCpuInfoValid := True;
  end;

  Result := FCpuInfo;
end;

procedure TJclSIMDWizard.RegisterCommands;
var
  I: Integer;
  IDEMenu: TMenu;
  ViewMenu: TMenuItem;
  Category: string;
begin
  inherited RegisterCommands;

  Supports(Services, IOTADebuggerServices, FDebuggerServices);
  if not Assigned(FDebuggerServices) then
    raise EJclExpertException.CreateTrace(RsENoDebuggerServices);

  Category := '';
  for I := 0 to NTAServices.ActionList.ActionCount - 1 do
    if CompareText(NTAServices.ActionList.Actions[I].Name, 'DebugCPUCommand') = 0 then
      Category := NTAServices.ActionList.Actions[I].Category;

  FIcon := TIcon.Create;
  FIcon.Handle := LoadIcon(FindResourceHInstance(ModuleHInstance), 'SIMDICON');

  FSIMDAction := TAction.Create(nil);
  FSIMDAction.Caption := RsSIMD;
  FSIMDAction.Visible := True;
  FSIMDAction.OnExecute := SIMDActionExecute;
  FSIMDAction.OnUpdate := SIMDActionUpdate;
  FSIMDAction.Category := Category;
  FSIMDAction.Name := RsSIMDActionName;
  FSIMDAction.ImageIndex := NTAServices.ImageList.AddIcon(FIcon);
  FSIMDAction.ActionList := NTAServices.ActionList;
  FSIMDAction.ShortCut := Shortcut(Ord('D'), [ssCtrl, ssAlt]);

  FSIMDMenuItem := TMenuItem.Create(nil);
  FSIMDMenuItem.Action := FSIMDAction;

  IDEMenu := NTAServices.MainMenu;
  if not Assigned(IDEMenu) then
    raise EJclExpertException.CreateTrace(RsENoIDEMenu);

  ViewMenu := nil;
  for I := 0 to IDEMenu.Items.Count - 1 do
    if CompareText(IDEMenu.Items[I].Name, 'ViewsMenu') = 0 then
      ViewMenu := IDEMenu.Items[I];
  if not Assigned(ViewMenu) then
    raise EJclExpertException.CreateTrace(RsENoViewMenuItem);

  FViewDebugMenu := nil;
  for I := 0 to ViewMenu.Count - 1 do
    if CompareText(ViewMenu.Items[I].Name, 'ViewDebugItem') = 0 then
      FViewDebugMenu := ViewMenu.Items[I];
  if not Assigned(FViewDebugMenu) then
    raise EJclExpertException.CreateTrace(RsENoDebugWindowsMenuItem);

  FViewDebugMenu.Add(FSIMDMenuItem);

  RegisterAction(FSIMDAction);

  FDebuggerNotifier := TJclDebuggerNotifier.Create(Self);
  FIndex := DebuggerServices.AddNotifier(FDebuggerNotifier);
end;

procedure TJclSIMDWizard.UnregisterCommands;
begin
  inherited UnregisterCommands;

  UnregisterAction(FSIMDAction);
  FreeAndNil(FIcon);
  FreeAndNil(FSIMDMenuItem);
  FreeAndNil(FSIMDAction);
end;

procedure TJclSIMDWizard.FormDestroy(Sender: TObject);
begin
  FForm := nil;
end;

function TJclSIMDWizard.GetSIMDString: string;

  function Concat(LeftValue, RightValue: string): string;
  begin
    if LeftValue = '' then
      Result := RightValue
    else
      Result := LeftValue + ',' + RightValue;
  end;

begin
  Result := '';
  with CpuInfo do
  begin
    if MMX then
      Result := RsMMX;
    if ExMMX then
      Result := Concat(Result, RsExMMX);
    if _3DNow then
      Result := Concat(Result, Rs3DNow);
    if Ex3DNow then
      Result := Concat(Result, RsEx3DNow);
    if SSE >= 1 then
      Result := Concat(Result, RsSSE1);
    if SSE >= 2 then
      Result := Concat(Result, RsSSE2);
    if SSE >= 3 then
      Result := Concat(Result, RsSSE3);
    if Is64Bits then
      Result := Result + ',' + RsLong;
  end;
end;

procedure TJclSIMDWizard.RefreshThreadContext(WriteOldContext: Boolean);
begin
  if Assigned(FForm) then
    if WriteOldContext then
      FForm.SetThreadValues
    else
      FForm.GetThreadValues;
end;

procedure TJclSIMDWizard.ThreadEvaluate(const ExprStr, ResultStr: string; ReturnCode: Integer);
begin
  if Assigned(FForm) then
    FForm.ThreadEvaluate(ExprStr, ResultStr, ReturnCode);
end;

//=== { TJclDebuggerNotifier } ===============================================

constructor TJclDebuggerNotifier.Create(AOwner: TJclSIMDWizard);
begin
  inherited Create;

  FOwner := AOwner;
  FProcessList := TList.Create;
  FThreadList := TList.Create;
end;

destructor TJclDebuggerNotifier.Destroy;
var
  AThreadReference: PThreadReference;
  AProcessReference: PProcessReference;
begin
  while FThreadList.Count > 0 do
  begin
    AThreadReference := PThreadReference(FThreadList.Items[0]);
    AThreadReference.Thread.RemoveNotifier(AThreadReference.ID);
    FThreadList.Remove(AThreadReference);
    Dispose(AThreadReference);
  end;
  while FProcessList.Count > 0 do
  begin
    AProcessReference := PProcessReference(FProcessList.Items[0]);
    AProcessReference.Process.RemoveNotifier(AProcessReference.ID);
    FProcessList.Remove(AProcessReference);
    Dispose(AProcessReference);
  end;
  FThreadList.Free;
  FProcessList.Free;

  inherited Destroy;
end;

procedure TJclDebuggerNotifier.BreakpointAdded({$IFDEF RTL170_UP} const {$ENDIF} Breakpoint: IOTABreakpoint);
begin

end;

procedure TJclDebuggerNotifier.BreakpointDeleted({$IFDEF RTL170_UP} const {$ENDIF} Breakpoint: IOTABreakpoint);
begin

end;

procedure TJclDebuggerNotifier.EvaluteComplete(const ExprStr, ResultStr: string;
  CanModify: Boolean; ResultAddress, ResultSize: LongWord; ReturnCode: Integer);
begin
  try
    Owner.ThreadEvaluate(ExprStr, ResultStr, ReturnCode);
  except
    on ExceptObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptObj);
      raise;
    end;
  end;
end;

function TJclDebuggerNotifier.FindProcessReference(AProcess: IOTAProcess): PProcessReference;
var
  Index: Integer;
begin
  for Index := 0 to FProcessList.Count - 1 do
  begin
    Result := PProcessReference(FProcessList.Items[Index]);
    if Result.Process = AProcess then
      Exit;
  end;
  Result := nil;
end;

function TJclDebuggerNotifier.FindThreadReference(AThread: IOTAThread): PThreadReference;
var
  Index: Integer;
begin
  for Index := 0 to FThreadList.Count - 1 do
  begin
    Result := PThreadReference(FThreadList.Items[Index]);
    if Result.Thread = AThread then
      Exit;
  end;
  Result := nil;
end;

procedure TJclDebuggerNotifier.ModifyComplete(const ExprStr, ResultStr: string; ReturnCode: Integer);
begin

end;

procedure TJclDebuggerNotifier.ProcessCreated({$IFDEF RTL170_UP} const {$ENDIF} Process: IOTAProcess);
var
  AProcessReference: PProcessReference;
begin
  try
    AProcessReference := FindProcessReference(Process);
    if AProcessReference = nil then
    begin
      New(AProcessReference);
      AProcessReference.Process := Process;
      AProcessReference.ID := Process.AddNotifier(Self);
      FProcessList.Add(AProcessReference);
    end;
  except
    on ExceptObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptObj);
      raise;
    end;
  end;
end;

procedure TJclDebuggerNotifier.ProcessDestroyed({$IFDEF RTL170_UP} const {$ENDIF} Process: IOTAProcess);
var
  AProcessReference: PProcessReference;
  AThreadReference: PThreadReference;
  Index: Integer;
begin
  try
    for Index := 0 to Process.ThreadCount - 1 do
    begin
      AThreadReference := FindThreadReference(Process.Threads[Index]);
      if AThreadReference <> nil then
      begin
        AThreadReference.Thread.RemoveNotifier(AThreadReference.ID);
        FThreadList.Remove(AThreadReference);
        Dispose(AThreadReference);
      end;
    end;

    AProcessReference := FindProcessReference(Process);
    if AProcessReference <> nil then
    begin
      AProcessReference.Process.RemoveNotifier(AProcessReference.ID);
      FProcessList.Remove(AProcessReference);
      Dispose(AProcessReference);
    end;

    if Owner.DebuggerServices.ProcessCount = 1 then
      Owner.CloseForm;
  except
    on ExceptObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptObj);
      raise;
    end;
  end;
end;

procedure TJclDebuggerNotifier.ProcessModuleCreated(
  {$IFDEF RTL170_UP} const {$ENDIF} ProcessModule: IOTAProcessModule);
begin

end;

procedure TJclDebuggerNotifier.ProcessModuleDestroyed({$IFDEF RTL170_UP} const {$ENDIF} ProcessModule: IOTAProcessModule);
begin

end;

procedure TJclDebuggerNotifier.ThreadCreated({$IFDEF RTL170_UP} const {$ENDIF} Thread: IOTAThread);
var
  AThreadReference: PThreadReference;
begin
  try
    AThreadReference := FindThreadReference(Thread);
    if AThreadReference = nil then
    begin
      New(AThreadReference);
      AThreadReference.Thread := Thread;
      AThreadReference.ID := Thread.AddNotifier(Self);
      FThreadList.Add(AThreadReference);
    end;
  except
    on ExceptObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptObj);
      raise;
    end;
  end;
end;

procedure TJclDebuggerNotifier.ThreadDestroyed({$IFDEF RTL170_UP} const {$ENDIF} Thread: IOTAThread);
var
  AThreadReference: PThreadReference;
begin
  try
    AThreadReference := FindThreadReference(Thread);
    if AThreadReference <> nil then
    begin
      AThreadReference.Thread.RemoveNotifier(AThreadReference.ID);
      FThreadList.Remove(AThreadReference);
      Dispose(AThreadReference);
    end;
  except
    on ExceptObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptObj);
      raise;
    end;
  end;
end;

procedure TJclDebuggerNotifier.ThreadNotify(Reason: TOTANotifyReason);
begin
  try
    Owner.RefreshThreadContext(False);  //Reason = nrRunning);
  except
    on ExceptObj: TObject do
    begin
      JclExpertShowExceptionDialog(ExceptObj);
      raise;
    end;
  end;
end;

// History:

// $Log: JclSIMDView.pas,v $
// Revision 1.10  2006/01/08 17:16:56  outchy
// Settings reworked.
// Common window for expert configurations
//
// Revision 1.9  2005/12/26 18:03:40  outchy
// Enhanced bds support (including C#1 and D8)
// Introduction of dll experts
// Project types in templates
//
// Revision 1.8  2005/12/16 23:46:25  outchy
// Added expert stack form.
// Added code to display call stack on expert exception.
// Fixed package extension for D2006.
//
// Revision 1.7  2005/10/26 03:29:44  rrossmair
// - improved header information, added Date and Log CVS tags.
//

end.
