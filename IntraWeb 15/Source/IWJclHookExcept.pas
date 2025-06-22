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
{ The Original Code is JclHookExcept.pas.                                                          }
{                                                                                                  }
{ The Initial Developer of the Original Code is Petr Vones. Portions created by Petr Vones are     }
{ Copyright (C) Petr Vones. All Rights Reserved.                                                   }
{                                                                                                  }
{ Contributor(s):                                                                                  }
{   Petr Vones (pvones)                                                                            }
{   Robert Marquardt (marquardt)                                                                   }
{   Andreas Hausladen (ahuser)                                                                     }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Exception hooking routines                                                                       }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date:: 2012-09-04 16:08:04 +0200 (mar. 04 sept. 2012)                          $ }
{ Revision:      $Rev:: 3861                                                                     $ }
{ Author:        $Author:: outchy                                                                $ }
{                                                                                                  }
{**************************************************************************************************}

unit IWJclHookExcept;

interface

{$I IWJcl.inc}
{$I IWJclWindowsOnly.inc}

uses
  {$IFDEF HAS_UNITSCOPE}
  Winapi.Windows, System.SysUtils, System.Classes;
  {$ELSE ~HAS_UNITSCOPE}
  Windows, SysUtils, Classes;
  {$ENDIF ~HAS_UNITSCOPE}

type
  // Exception hooking notifiers routines
  TJclExceptNotifyProc = procedure(ExceptObj: TObject; ExceptAddr: Pointer; OSException: Boolean; StackPointer: Pointer);

function JclAddExceptNotifier(const ANotifyProc: TJclExceptNotifyProc): Boolean;
function JclClearExceptNotifier: Boolean;

procedure JclReplaceExceptObj(NewExceptObj: Exception);

// Exception hooking routines
function JclHookExceptions: Boolean;
function JclUnhookExceptions: Boolean;
function JclExceptionsHooked: Boolean;

function JclHookExceptionsInModule(Module: HMODULE): Boolean;
function JclUnhookExceptionsInModule(Module: HMODULE): Boolean;

// Exceptions hooking in libraries
type
  TJclModuleArray = array of HMODULE;

function JclInitializeLibrariesHookExcept: Boolean;
function JclHookedExceptModulesList(out ModulesList: TJclModuleArray): Boolean;

// Hooking routines location info helper
function JclBelongsHookedCode(Address: Pointer): Boolean;

implementation

uses
  IWJclBase,
  IWJclPeImage,
  IWJclSysInfo, IWJclSysUtils,
  {$IFDEF HAS_UNITSCOPE}
  System.SyncObjs,
  {$ELSE ~HAS_UNITSCOPE}
  SyncObjs,
  {$ENDIF ~HAS_UNITSCOPE}
  IW.Common.Threads, IW.Common.Lists;

type
  PExceptionArguments = ^TExceptionArguments;
  TExceptionArguments = record
    ExceptAddr: Pointer;
    ExceptObj: Exception;
  end;

  TNotifier = class(TObject)
  private
    FNotifyProc: TJclExceptNotifyProc;
  public
    procedure DoNotify(ExceptObj: TObject; ExceptAddr: Pointer; OSException: Boolean; StackPointer: Pointer);
    property NotifyProc: TJclExceptNotifyProc read FNotifyProc write FNotifyProc;
  end;

var
  ExceptionsHooked: Boolean;
  Kernel32_RaiseException: procedure (dwExceptionCode, dwExceptionFlags,
    nNumberOfArguments: DWORD; lpArguments: PDWORD); stdcall;
  {$IFDEF BORLAND}
  SysUtils_ExceptObjProc: function (P: PExceptionRecord): Exception;
  {$ENDIF BORLAND}
  {$IFDEF FPC}
  SysUtils_ExceptProc: TExceptProc;
  {$ENDIF FPC}

  // IW_NOTE: Only one notifier. We don't need more than one. We don't want list locking here!
  Notifier: TNotifier;

{$IFDEF HOOK_DLL_EXCEPTIONS}
const
  JclHookExceptDebugHookName = '__JclHookExcept';

type
  TJclHookExceptDebugHook = procedure(Module: HMODULE; Hook: Boolean); stdcall;

  TJclHookExceptModuleList = class(TObject)
  private
    FModules: TIWThreadList;
  protected
    procedure HookStaticModules;
  public
    constructor Create;
    destructor Destroy; override;
    class function JclHookExceptDebugHookAddr: Pointer;
    procedure HookModule(Module: HMODULE);
    procedure List(out ModulesList: TJclModuleArray);
    procedure UnhookModule(Module: HMODULE);
  end;

var
  HookExceptModuleList: TJclHookExceptModuleList;
  JclHookExceptDebugHook: Pointer;

exports
  JclHookExceptDebugHook name JclHookExceptDebugHookName;
{$ENDIF HOOK_DLL_EXCEPTIONS}

{$STACKFRAMES OFF}

threadvar
  Recursive: Boolean;
  NewResultExc: Exception;

//=== Helper routines ========================================================

function RaiseExceptionAddress: Pointer;
begin
  Result := GetProcAddress(GetModuleHandle(kernel32), 'RaiseException');
  Assert(Result <> nil);
end;

//=== { TNotifier } ======================================================

procedure TNotifier.DoNotify(ExceptObj: TObject; ExceptAddr: Pointer;
  OSException: Boolean; StackPointer: Pointer);
begin
  if Assigned(FNotifyProc) then
    FNotifyProc(ExceptObj, ExceptAddr, OSException, StackPointer);
end;

function GetFramePointer: Pointer;
asm
        {$IFDEF CPU32}
        MOV     EAX, EBP
        {$ENDIF CPU32}
        {$IFDEF CPU64}
        MOV     RAX, RBP
        {$ENDIF CPU64}
end;

{$STACKFRAMES ON}

// TODO: Change this and use the actual class
function IsClass(Obj: TObject; aClassName: string): Boolean;
var
  Parent: TClass;
begin
  Parent := Obj.ClassType;
  while (Parent <> nil) and not SameText(Parent.ClassName, aClassName) do
  begin
    Parent := Parent.ClassParent;
  end;
  Result := Parent <> nil;
end;

procedure DoExceptNotify(ExceptObj: TObject; ExceptAddr: Pointer; OSException: Boolean; StackPointer: Pointer);
begin
  if Recursive then
    Exit;
  // IW_NOTES: Don't even bother about EIdSilentException (e.g. EIdConnClosedGracefully)
  // EAbort is already treated in Jcl layer
  if Assigned(ExceptObj) and IsClass(Exception(ExceptObj), 'EIdSilentException') then
    Exit;

  if Assigned(Notifier) then
  begin
    Recursive := True;
    NewResultExc := nil;
    try
      Notifier.DoNotify( ExceptObj, ExceptAddr, OSException, StackPointer);
    finally
      Recursive := False;
    end;
  end;
end;

procedure HookedRaiseException(ExceptionCode, ExceptionFlags, NumberOfArguments: DWORD;
  Arguments: PExceptionArguments); stdcall;
const
  cDelphiException = $0EEDFADE;
  cNonContinuable = 1;                  // Delphi exceptions
  cNonContinuableException = $C0000025; // C++Builder exceptions (sounds like a bug)
  DelphiNumberOfArguments = 7;
  CBuilderNumberOfArguments = 8;
begin
  if ((ExceptionFlags = cNonContinuable) or (ExceptionFlags = cNonContinuableException)) and
    (ExceptionCode = cDelphiException) and
    (NumberOfArguments in [DelphiNumberOfArguments,CBuilderNumberOfArguments])
    //TODO: The difference for Win64 is bigger than 100 Byte and the comment of JVCS revision 0.3 of
    //  IWJclDebug.pas, where HookedRaiseException has been added by Petr, isn't very informative
    {$IFDEF CPU32}
    and (TJclAddr(Arguments) = TJclAddr(@Arguments) + SizeOf(Pointer))
    {$ENDIF CPU32}
    then
  begin
    DoExceptNotify(Arguments.ExceptObj, Arguments.ExceptAddr, False, GetFramePointer);
  end;
  Kernel32_RaiseException(ExceptionCode, ExceptionFlags, NumberOfArguments, PDWORD(Arguments));
end;

{$IFDEF BORLAND}
function HookedExceptObjProc(P: PExceptionRecord): Exception;
var
  NewResultExcCache: Exception; // TLS optimization
begin
  Result := SysUtils_ExceptObjProc(P);
  DoExceptNotify(Result, P^.ExceptionAddress, True, GetFramePointer);
  NewResultExcCache := NewResultExc;
  if NewResultExcCache <> nil then
    Result := NewResultExcCache;
end;
{$ENDIF BORLAND}

{$IFDEF FPC}
procedure HookedExceptProc(Obj : TObject; Addr : Pointer; FrameCount:Longint; Frame: PPointer);
var
  NewResultExcCache: Exception; // TLS optimization
begin
  DoExceptNotify(Obj, Addr, True, GetFramePointer);
  NewResultExcCache := NewResultExc;
  if NewResultExcCache <> nil then
    SysUtils_ExceptProc(NewResultExcCache, Addr, FrameCount, Frame)
  else
    SysUtils_ExceptProc(Obj, Addr, FrameCount, Frame)
end;
{$ENDIF FPC}

{$IFNDEF STACKFRAMES_ON}
{$STACKFRAMES OFF}
{$ENDIF ~STACKFRAMES_ON}

// Do not change ordering of HookedRaiseException, HookedExceptObjProc and JclBelongsHookedCode routines

function JclBelongsHookedCode(Address: Pointer): Boolean;
begin
  Result := (TJclAddr(@HookedRaiseException) < TJclAddr(@JclBelongsHookedCode)) and
    (TJclAddr(@HookedRaiseException) <= TJclAddr(Address)) and
    (TJclAddr(@JclBelongsHookedCode) > TJclAddr(Address));
end;

function JclAddExceptNotifier(const ANotifyProc: TJclExceptNotifyProc): Boolean;
begin
  Result := Assigned(Notifier);
  if Result then begin
    Notifier.NotifyProc := ANotifyProc;
  end;
end;

function JclClearExceptNotifier: Boolean;
begin
  Result := Assigned(Notifier);
  if Result then begin
    Notifier.NotifyProc := nil;
  end;
end;

procedure JclReplaceExceptObj(NewExceptObj: Exception);
begin
  Assert(Recursive);
  NewResultExc := NewExceptObj;
end;

{$IFDEF BORLAND}
function GetCppRtlBase: Pointer;
const
  {$IFDEF COMPILER6} { Delphi/C++Builder 6 }
  CppRtlVersion = 60;
  {$ELSE ~COMPILER6}
  {$IFDEF RTL185} { Delphi/C++Builder 2007 were aiming for
                    binary compatibility with BDS2006, which
                    complicates things a bit }
  CppRtlVersion = 80;
  {$ELSE ~RTL185}
  { Successive RTLDLL version numbers in the remaining cases: CB2006 has cc3270mt.dll,
    CB2009 (= CB2006 + 2 releases) has cc3290mt.dll, CB2010 has cc32100mt.dll etc. }
  CppRtlVersion = 70 + Trunc(RtlVersion - 18.0) * 10;
  {$ENDIF ~RTL185}
  {$ENDIF ~COMPILER6}
begin
  Result := Pointer(GetModuleHandle(PChar(Format('cc32%dmt.dll', [CppRtlVersion]))));
  { 'Result = nil' means that the C++ RTL has been linked statically or is not available at all;
    in this case TJclPeMapImgHooks.ReplaceImport() is a no-op. The base module is also being
    hooked separately, so we're covered. }
end;

function HasCppRtl: Boolean;
begin
  Result := GetCppRtlBase <> TJclPeMapImgHooks.SystemBase;
end;
{$ENDIF BORLAND}

function JclHookExceptions: Boolean;
var
  RaiseExceptionAddressCache: Pointer;
begin
  RaiseExceptionAddressCache := RaiseExceptionAddress;
  { Detect C++Builder applications and C++ packages loaded into Delphi applications.
    Hook the C++ RTL regardless of ExceptionsHooked so that users can call JclHookException() after
    loading a C++ package which might pull in the C++ RTL DLL. }
  {$IFDEF BORLAND}
  if HasCppRtl then
    TJclPeMapImgHooks.ReplaceImport(GetCppRtlBase, kernel32, RaiseExceptionAddressCache, @HookedRaiseException);
  {$ENDIF BORLAND}
  if not ExceptionsHooked then
  begin
    Recursive := False;
    with TJclPeMapImgHooks do
      Result := ReplaceImport(SystemBase, kernel32, RaiseExceptionAddressCache, @HookedRaiseException);
    if Result then
    begin
      @Kernel32_RaiseException := RaiseExceptionAddressCache;
      {$IFDEF BORLAND}
      SysUtils_ExceptObjProc := System.ExceptObjProc;
      System.ExceptObjProc := @HookedExceptObjProc;
      {$ENDIF BORLAND}
      {$IFDEF FPC}
      SysUtils_ExceptProc := System.ExceptProc;
      System.ExceptProc := @HookedExceptProc;
      {$ENDIF FPC}
    end;
    ExceptionsHooked := Result;
  end
  else
    Result := True;
end;

function JclUnhookExceptions: Boolean;
begin
  {$IFDEF BORLAND}
  if HasCppRtl then
    TJclPeMapImgHooks.ReplaceImport (GetCppRtlBase, kernel32, @HookedRaiseException, @Kernel32_RaiseException);
  {$ENDIF BORLAND}
  if ExceptionsHooked then
  begin
    with TJclPeMapImgHooks do
      ReplaceImport(SystemBase, kernel32, @HookedRaiseException, @Kernel32_RaiseException);
    {$IFDEF BORLAND}
    System.ExceptObjProc := @SysUtils_ExceptObjProc;
    @SysUtils_ExceptObjProc := nil;
    {$ENDIF BORLAND}
    {$IFDEF FPC}
    System.ExceptProc := @SysUtils_ExceptProc;
    @SysUtils_ExceptProc := nil;
    {$ENDIF FPC}
    @Kernel32_RaiseException := nil;
    Result := True;
    ExceptionsHooked := False;
  end
  else
    Result := True;
end;

function JclExceptionsHooked: Boolean;
begin
  Result := ExceptionsHooked;
end;

function JclHookExceptionsInModule(Module: HMODULE): Boolean;
begin
  Result := ExceptionsHooked and
    TJclPeMapImgHooks.ReplaceImport(Pointer(Module), kernel32, RaiseExceptionAddress, @HookedRaiseException);
end;

function JclUnhookExceptionsInModule(Module: HMODULE): Boolean;
begin
  Result := ExceptionsHooked and
    TJclPeMapImgHooks.ReplaceImport(Pointer(Module), kernel32, @HookedRaiseException, @Kernel32_RaiseException);
end;

{$IFDEF HOOK_DLL_EXCEPTIONS}
// Exceptions hooking in libraries

procedure JclHookExceptDebugHookProc(Module: HMODULE; Hook: Boolean); stdcall;
begin
  if Hook then
    HookExceptModuleList.HookModule(Module)
  else
    HookExceptModuleList.UnhookModule(Module);
end;

function CallExportedHookExceptProc(Module: HMODULE; Hook: Boolean): Boolean;
var
  HookExceptProcPtr: PPointer;
  HookExceptProc: TJclHookExceptDebugHook;
begin
  HookExceptProcPtr := TJclHookExceptModuleList.JclHookExceptDebugHookAddr;
  Result := Assigned(HookExceptProcPtr);
  if Result then
  begin
    @HookExceptProc := HookExceptProcPtr^;
    if Assigned(HookExceptProc) then
      HookExceptProc(Module, True);
  end;
end;
{$ENDIF HOOK_DLL_EXCEPTIONS}

function JclInitializeLibrariesHookExcept: Boolean;
begin
  {$IFDEF HOOK_DLL_EXCEPTIONS}
  if IsLibrary then
    Result := CallExportedHookExceptProc(SystemTObjectInstance, True)
  else
  begin
    if not Assigned(HookExceptModuleList) then
      HookExceptModuleList := TJclHookExceptModuleList.Create;
    Result := True;
  end;
  {$ELSE HOOK_DLL_EXCEPTIONS}
  Result := True;
  {$ENDIF HOOK_DLL_EXCEPTIONS}
end;

function JclHookedExceptModulesList(out ModulesList: TJclModuleArray): Boolean;
begin
  {$IFDEF HOOK_DLL_EXCEPTIONS}
  Result := Assigned(HookExceptModuleList);
  if Result then
    HookExceptModuleList.List(ModulesList);
  {$ELSE HOOK_DLL_EXCEPTIONS}
  Result := False;
  SetLength(ModulesList, 0);
  {$ENDIF HOOK_DLL_EXCEPTIONS}
end;

{$IFDEF HOOK_DLL_EXCEPTIONS}
procedure FinalizeLibrariesHookExcept;
begin
  FreeAndNil(HookExceptModuleList);
  if IsLibrary then
    CallExportedHookExceptProc(SystemTObjectInstance, False);
end;

//=== { TJclHookExceptModuleList } ===========================================

constructor TJclHookExceptModuleList.Create;
begin
  inherited Create;
  FModules := TIWThreadList.Create;
  HookStaticModules;
  JclHookExceptDebugHook := @JclHookExceptDebugHookProc;
end;

destructor TJclHookExceptModuleList.Destroy;
begin
  JclHookExceptDebugHook := nil;
  FreeAndNil(FModules);
  inherited Destroy;
end;

procedure TJclHookExceptModuleList.HookModule(Module: HMODULE);
begin
  with FModules.LockList do
  try
    if IndexOf(Pointer(Module)) = -1 then
    begin
      Add(Pointer(Module));
      JclHookExceptionsInModule(Module);
    end;
  finally
    FModules.UnlockList;
  end;
end;

procedure TJclHookExceptModuleList.HookStaticModules;
var
  ModulesList: TStringList;
  I: Integer;
  Module: HMODULE;
begin
  ModulesList := nil;
  with FModules.LockList do
  try
    ModulesList := TStringList.Create;
    if LoadedModulesList(ModulesList, GetCurrentProcessId, True) then
      for I := 0 to ModulesList.Count - 1 do
      begin
        Module := HMODULE(ModulesList.Objects[I]);
        if GetProcAddress(Module, JclHookExceptDebugHookName) <> nil then
          HookModule(Module);
      end;    
  finally
    FModules.UnlockList;
    ModulesList.Free;
  end;
end;

class function TJclHookExceptModuleList.JclHookExceptDebugHookAddr: Pointer;
var
  HostModule: HMODULE;
begin
  HostModule := GetModuleHandle(nil);
  Result := GetProcAddress(HostModule, JclHookExceptDebugHookName);
end;

procedure TJclHookExceptModuleList.List(out ModulesList: TJclModuleArray);
var
  I: Integer;
begin
  with FModules.LockList do
  try
    SetLength(ModulesList, Count);
    for I := 0 to Count - 1 do
      ModulesList[I] := HMODULE(Items[I]);
  finally
    FModules.UnlockList;
  end;
end;

procedure TJclHookExceptModuleList.UnhookModule(Module: HMODULE);
begin
  with FModules.LockList do
  try
    Remove(Pointer(Module));
  finally
    FModules.UnlockList;
  end;
end;
{$ENDIF HOOK_DLL_EXCEPTIONS}

initialization
  Notifier := TNotifier.Create;

finalization
  {$IFDEF HOOK_DLL_EXCEPTIONS}
  FinalizeLibrariesHookExcept;
  {$ENDIF HOOK_DLL_EXCEPTIONS}
  FreeAndNil(Notifier);

end.
