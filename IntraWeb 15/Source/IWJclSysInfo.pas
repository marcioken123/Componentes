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
{ The Original Code is JclSysInfo.pas.                                                             }
{                                                                                                  }
{ The Initial Developer of the Original Code is Marcel van Brakel.                                 }
{ Portions created by Marcel van Brakel are Copyright (C) Marcel van Brakel. All rights reserved.  }
{                                                                                                  }
{ Contributors:                                                                                    }
{   Alexander Radchenko                                                                            }
{   Andre Snepvangers (asnepvangers)                                                               }
{   Azret Botash                                                                                   }
{   Bryan Coutch                                                                                   }
{   Carl Clark                                                                                     }
{   Eric S. Fisher                                                                                 }
{   Florent Ouchet (outchy)                                                                        }
{   Heiko Adams                                                                                    }
{   James Azarja                                                                                   }
{   Jean-Fabien Connault (cycocrew)                                                                }
{   John C Molyneux                                                                                }
{   Marcel van Brakel                                                                              }
{   Matthias Thoma (mthoma)                                                                        }
{   Mike Lischke                                                                                   }
{   Nick Hodges                                                                                    }
{   Olivier Sannier (obones)                                                                       }
{   Peter Friese                                                                                   }
{   Peter Thornquist (peter3)                                                                      }
{   Petr Vones (pvones)                                                                            }
{   Rik Barker                                                                                     }
{   Robert Marquardt (marquardt)                                                                   }
{   Robert Rossmair (rrossmair)                                                                    }
{   Scott Price                                                                                    }
{   Tom Hahn (tomhahn)                                                                             }
{   Wim de Cleen                                                                                   }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ This unit contains routines and classes to retrieve various pieces of system information.        }
{ Examples are the location of standard folders, settings of environment variables, processor      }
{ details and the Windows version.                                                                 }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date:: 2012-08-22 17:40:33 +0200 (mer. 22 août 2012)                          $ }
{ Revision:      $Rev:: 3843                                                                     $ }
{ Author:        $Author:: outchy                                                                $ }
{                                                                                                  }
{**************************************************************************************************}

// Windows NT 4 and earlier do not support GetSystemPowerStatus (while introduced
// in NT4 - it is a stub there - implemented in Windows 2000 and later.


unit IWJclSysInfo;

{$I IWJcl.inc}

interface

uses
  Windows, Classes,
  IWJclBase, IWJclResources;

function ExpandEnvironmentVar(var Value: string): Boolean;
function GetEnvironmentVar(const Name: string; var Value: string): Boolean; overload;
function GetEnvironmentVar(const Name: string; out Value: string; Expand: Boolean): Boolean; overload;

function GetCurrentFolder: string;

// Processes, Tasks and Modules

function RunningProcessesList(const List: TStrings; FullPath: Boolean = True): Boolean;

function LoadedModulesList(const List: TStrings; ProcessID: DWORD; HandlesOnly: Boolean = False): Boolean;
function GetTasksList(const List: TStrings): Boolean;

function ModuleFromAddr(const Addr: Pointer): HMODULE;
function IsSystemModule(const Module: HMODULE): Boolean;

function IsMainAppWindow(Wnd: THandle): Boolean;

// Version Information
type
  TWindowsVersion =
   (wvUnknown, wvWin95, wvWin95OSR2, wvWin98, wvWin98SE, wvWinME,
    wvWinNT31, wvWinNT35, wvWinNT351, wvWinNT4, wvWin2000, wvWinXP,
    wvWin2003, wvWinXP64, wvWin2003R2, wvWinVista, wvWinServer2008,
    wvWin7, wvWinServer2008R2, wvWin8, wvWinServer2012);

var
  { in case of additions, don't forget to update initialization section! }
  IsWin95: Boolean = False;
  IsWin95OSR2: Boolean = False;
  IsWin98: Boolean = False;
  IsWin98SE: Boolean = False;
  IsWinME: Boolean = False;
  IsWinNT: Boolean = False;
  IsWinNT3: Boolean = False;
  IsWinNT31: Boolean = False;
  IsWinNT35: Boolean = False;
  IsWinNT351: Boolean = False;
  IsWinNT4: Boolean = False;
  IsWin2K: Boolean = False;
  IsWinXP: Boolean = False;
  IsWin2003: Boolean = False;
  IsWinXP64: Boolean = False;
  IsWin2003R2: Boolean = False;
  IsWinVista: Boolean = False;
  IsWinServer2008: Boolean = False;
  IsWin7: Boolean = False;
  IsWinServer2008R2: Boolean = False;
  IsWin8: Boolean = False;
  IsWinServer2012: Boolean = False;

const
  PROCESSOR_ARCHITECTURE_INTEL = 0;
  {$EXTERNALSYM PROCESSOR_ARCHITECTURE_INTEL}
  PROCESSOR_ARCHITECTURE_AMD64 = 9;
  {$EXTERNALSYM PROCESSOR_ARCHITECTURE_AMD64}
  PROCESSOR_ARCHITECTURE_IA32_ON_WIN64 = 10;
  {$EXTERNALSYM PROCESSOR_ARCHITECTURE_IA32_ON_WIN64}
  PROCESSOR_ARCHITECTURE_IA64 = 6;
  {$EXTERNALSYM PROCESSOR_ARCHITECTURE_IA64}

function GetWindowsVersion: TWindowsVersion;
function IsWindows64: Boolean;

// Alloc granularity
procedure RoundToAllocGranularity64(var Value: Int64; Up: Boolean);
procedure RoundToAllocGranularityPtr(var Value: Pointer; Up: Boolean);

// Public global variables
var
  ProcessorCount: Cardinal = 0;
  AllocGranularity: Cardinal = 0;
  PageSize: Cardinal = 0;

implementation

uses
  SysUtils, {$IFDEF FPC} JwaTLHelp32, JwaPsApi, {$ELSE} TLHelp32, PsApi, {$ENDIF} Registry,
  IWJclWin32, IWJclSysUtils, IWJclStrings;

//=== Environment ============================================================

function ExpandEnvironmentVar(var Value: string): Boolean;
var
  R: Integer;
  Expanded: string;
begin
  SetLength(Expanded, 1);
  R := ExpandEnvironmentStrings(PChar(Value), PChar(Expanded), 0);
  SetLength(Expanded, R);
  Result := ExpandEnvironmentStrings(PChar(Value), PChar(Expanded), R) <> 0;
  if Result then
  begin
    StrResetLength(Expanded);
    Value := Expanded;
  end;
end;

function GetEnvironmentVar(const Name: string; var Value: string): Boolean;
begin
  Result := GetEnvironmentVar(Name, Value, True);
end;

function GetEnvironmentVar(const Name: string; out Value: string; Expand: Boolean): Boolean;
var
  R: DWORD;
begin
  R := Windows.GetEnvironmentVariable(PChar(Name), nil, 0);
  SetLength(Value, R);
  R := Windows.GetEnvironmentVariable(PChar(Name), PChar(Value), R);
  Result := R <> 0;
  if not Result then
    Value := ''
  else
  begin
    SetLength(Value, R);
    if Expand then
      ExpandEnvironmentVar(Value);
  end;
end;

function RegReadString(Root: HKEY; const Key, Name: string): string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := Root;
    if Reg.OpenKeyReadOnly(Key) then
    begin
      Result := Reg.ReadString(Name);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

function RegReadStringDef(Root: HKEY; const Key, Name, Def: string): string;
var
  Reg: TRegistry;
begin
  Result := Def;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := Root;
    if Reg.OpenKeyReadOnly(Key) then
    begin
      if Reg.ValueExists(Name) then
      begin
        Result := Reg.ReadString(Name);
      end;
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

function RegReadIntegerDef(Root: HKEY; const Key, Name: string; Def: Integer): Integer;
var
  Reg: TRegistry;
begin
  Result := Def;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := Root;
    if Reg.OpenKeyReadOnly(Key) then
    begin
      if Reg.ValueExists(Name) then
      begin
        Result := Reg.ReadInteger(Name);
      end;
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

////=== Common Folders =========================================================

function GetCurrentFolder: string;
var
  Required: Cardinal;
begin
  Result := '';
  Required := GetCurrentDirectory(0, nil);
  if Required <> 0 then
  begin
    SetLength(Result, Required);
    GetCurrentDirectory(Required, PChar(Result));
    StrResetLength(Result);
  end;
end;

//=== Processes, Tasks and Modules ===========================================

function RunningProcessesList(const List: TStrings; FullPath: Boolean): Boolean;

  // This function always returns an empty string on Win9x
  function ProcessFileName(PID: DWORD): WideString;
  var
    Handle: THandle;
  begin
    Result := '';
    Handle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, PID);
    if Handle <> 0 then
    try
      SetLength(Result, MAX_PATH);
      if FullPath then
      begin
        if GetModuleFileNameExW(Handle, 0, PWideChar(Result), MAX_PATH) > 0 then
          StrResetLength(Result)
        else
          Result := '';
      end
      else
      begin
        if GetModuleBaseNameW(Handle, 0, PWideChar(Result), MAX_PATH) > 0 then
          StrResetLength(Result)
        else
          Result := '';
      end;
    finally
      CloseHandle(Handle);
    end;
  end;

  { TODO: Check return value of CreateToolhelp32Snapshot on Windows NT (0?) }
  function BuildListTH: Boolean;
  var
    SnapProcHandle: THandle;
    ProcEntry: TProcessEntry32;
    NextProc: Boolean;
    FileName: string;
  begin
    SnapProcHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    Result := (SnapProcHandle <> INVALID_HANDLE_VALUE);
    if Result then
    try
      ProcEntry.dwSize := SizeOf(ProcEntry);
      NextProc := Process32First(SnapProcHandle, ProcEntry);
      while NextProc do
      begin
        if ProcEntry.th32ProcessID = 0 then
        begin
          // PID 0 is always the "System Idle Process" but this name cannot be
          // retrieved from the system and has to be fabricated.
          FileName := LoadResString(@RsSystemIdleProcess);
        end
        else
        begin
          if IsWin2k or IsWinXP or IsWin2003 or IsWin2003R2 or IsWinXP64 or
            IsWinVista or IsWinServer2008 or IsWin7 or IsWinServer2008R2 then
          begin
            FileName := ProcessFileName(ProcEntry.th32ProcessID);
            if FileName = '' then
              FileName := ProcEntry.szExeFile;
          end
          else
          begin
            FileName := ProcEntry.szExeFile;
            if not FullPath then
              FileName := ExtractFileName(FileName);
          end;
        end;
        List.AddObject(FileName, Pointer(ProcEntry.th32ProcessID));
        NextProc := Process32Next(SnapProcHandle, ProcEntry);
      end;
    finally
      CloseHandle(SnapProcHandle);
    end;
  end;

  function BuildListPS: Boolean;
  var
    PIDs: array [0..1024] of DWORD;
    Needed: DWORD;
    I: Integer;
    FileName: string;
  begin
    Needed := 0;
    Result := EnumProcesses(@PIDs, SizeOf(PIDs), Needed);
    if Result then
    begin
      for I := 0 to (Needed div SizeOf(DWORD)) - 1 do
      begin
        case PIDs[I] of
          0:
            // PID 0 is always the "System Idle Process" but this name cannot be
            // retrieved from the system and has to be fabricated.
            FileName := LoadResString(@RsSystemIdleProcess);
          2:
            // On NT 4 PID 2 is the "System Process" but this name cannot be
            // retrieved from the system and has to be fabricated.
            if IsWinNT4 then
              FileName := LoadResString(@RsSystemProcess)
            else
              FileName := ProcessFileName(PIDs[I]);
          8:
            // On Win2K PID 8 is the "System Process" but this name cannot be
            // retrieved from the system and has to be fabricated.
            if IsWin2k or IsWinXP then
              FileName := LoadResString(@RsSystemProcess)
            else
              FileName := ProcessFileName(PIDs[I]);
        else
          FileName := ProcessFileName(PIDs[I]);
        end;
        if FileName <> '' then
          List.AddObject(FileName, Pointer(PIDs[I]));
      end;
    end;
  end;

begin
  { TODO : safer solution? }
  List.BeginUpdate;
  try
    if GetWindowsVersion in [wvWinNT31, wvWinNT35, wvWinNT351, wvWinNT4] then
      Result := BuildListPS
    else
      Result := BuildListTH;
  finally
    List.EndUpdate;
  end;
end;

{ TODO Windows 9x ? }

function LoadedModulesList(const List: TStrings; ProcessID: DWORD; HandlesOnly: Boolean): Boolean;

  procedure AddToList(ProcessHandle: THandle; Module: HMODULE);
  var
    FileName: array [0..MAX_PATH] of Char;
    ModuleInfo: TModuleInfo;
  begin
    ModuleInfo.EntryPoint := nil;
    {$IFDEF FPC}
    if GetModuleInformation(ProcessHandle, Module, ModuleInfo, SizeOf(ModuleInfo)) then
    {$ELSE ~FPC}
    if GetModuleInformation(ProcessHandle, Module, @ModuleInfo, SizeOf(ModuleInfo)) then
    {$ENDIF ~FPC}
    begin
      if HandlesOnly then
        List.AddObject('', Pointer(ModuleInfo.lpBaseOfDll))
      else
      if GetModuleFileNameEx(ProcessHandle, Module, Filename, SizeOf(Filename)) > 0 then
        List.AddObject(FileName, Pointer(ModuleInfo.lpBaseOfDll));
    end;
  end;

  function EnumModulesVQ(ProcessHandle: THandle): Boolean;
  var
    MemInfo: TMemoryBasicInformation;
    Base: PChar;
    LastAllocBase: Pointer;
    Res: DWORD;
  begin
    Base := nil;
    LastAllocBase := nil;
    ResetMemory(MemInfo, SizeOf(MemInfo));
    Res := VirtualQueryEx(ProcessHandle, Base, MemInfo, SizeOf(MemInfo));
    Result := (Res = SizeOf(MemInfo));
    while Res = SizeOf(MemInfo) do
    begin
      if MemInfo.AllocationBase <> LastAllocBase then
      begin
        if MemInfo.{$IFDEF FPC}_Type{$ELSE}Type_9{$ENDIF} = MEM_IMAGE then
          AddToList(ProcessHandle, HMODULE(MemInfo.AllocationBase));
        LastAllocBase := MemInfo.AllocationBase;
      end;
      Inc(Base, MemInfo.RegionSize);
      Res := VirtualQueryEx(ProcessHandle, Base, MemInfo, SizeOf(MemInfo));
    end;
  end;

  function EnumModulesPS: Boolean;
  var
    ProcessHandle: THandle;
    Needed: DWORD;
    Modules: array of THandle;
    I, Cnt: Integer;
  begin
    Result := False;
    ProcessHandle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, ProcessID);
    if ProcessHandle <> 0 then
    try
      Needed := 0;
      Result := EnumProcessModules(ProcessHandle, nil, 0, Needed);
      if Result then
      begin
        Cnt := Needed div SizeOf(HMODULE);
        SetLength(Modules, Cnt);
        if EnumProcessModules(ProcessHandle, @Modules[0], Needed, Needed) then
          for I := 0 to Cnt - 1 do
            AddToList(ProcessHandle, Modules[I]);
      end
      else
        Result := EnumModulesVQ(ProcessHandle);
    finally
      CloseHandle(ProcessHandle);
    end;
  end;

 { TODO: Check return value of CreateToolhelp32Snapshot on Windows NT (0?) }

  function EnumModulesTH: Boolean;
  var
    SnapProcHandle: THandle;
    Module: TModuleEntry32;
    Next: Boolean;
  begin
    SnapProcHandle := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, ProcessID);
    Result := (SnapProcHandle <> INVALID_HANDLE_VALUE);
    if Result then
    try
      ResetMemory(Module, SizeOf(Module));
      Module.dwSize := SizeOf(Module);
      Next := Module32First(SnapProcHandle, Module);
      while Next do
      begin
        if HandlesOnly then
          List.AddObject('', Pointer(Module.hModule))
        else
          List.AddObject(Module.szExePath, Pointer(Module.hModule));
        Next := Module32Next(SnapProcHandle, Module);
      end;
    finally
      CloseHandle(SnapProcHandle);
    end;
  end;

begin
  List.BeginUpdate;
  try
    if IsWinNT then
      Result := EnumModulesPS
    else
      Result := EnumModulesTH;
  finally
    List.EndUpdate;
  end;
end;

function EnumTaskWindowsProc(Wnd: THandle; List: TStrings): Boolean; stdcall;
var
  Caption: array [0..1024] of Char;
begin
  if IsMainAppWindow(Wnd) and (GetWindowText(Wnd, Caption, SizeOf(Caption)) > 0) then
    List.AddObject(Caption, Pointer(Wnd));
  Result := True;
end;

function GetTasksList(const List: TStrings): Boolean;
begin
  List.BeginUpdate;
  try
    Result := EnumWindows(@EnumTaskWindowsProc, LPARAM(List));
  finally
    List.EndUpdate;
  end;
end;

function ModuleFromAddr(const Addr: Pointer): HMODULE;
var
  MI: TMemoryBasicInformation;
begin
  MI.AllocationBase := nil;
  VirtualQuery(Addr, MI, SizeOf(MI));
  if MI.State <> MEM_COMMIT then
    Result := 0
  else
    Result := HMODULE(MI.AllocationBase);
end;

function IsSystemModule(const Module: HMODULE): Boolean;
var
  CurModule: PLibModule;
begin
  Result := False;
  if Module <> 0 then
  begin
    CurModule := LibModuleList;
    while CurModule <> nil do
    begin
      if CurModule.Instance = Module then
      begin
        Result := True;
        Break;
      end;
      CurModule := CurModule.Next;
    end;
  end;
end;

// Reference: http://msdn.microsoft.com/library/periodic/period97/win321197.htm
{ TODO : wrong link }

function IsMainAppWindow(Wnd: THandle): Boolean;
var
  ParentWnd: THandle;
  ExStyle: DWORD;
begin
  if IsWindowVisible(Wnd) then
  begin
    ParentWnd := THandle(GetWindowLongPtr(Wnd, GWLP_HWNDPARENT));
    ExStyle := GetWindowLongPtr(Wnd, GWL_EXSTYLE);
    Result := ((ParentWnd = 0) or (ParentWnd = GetDesktopWindow)) and
      ((ExStyle and WS_EX_TOOLWINDOW = 0) or (ExStyle and WS_EX_APPWINDOW <> 0));
  end
  else
    Result := False;
end;

//=== Version Information ====================================================

{ Q159/238

  Windows 95 retail, OEM    4.00.950                      7/11/95
  Windows 95 retail SP1     4.00.950A                     7/11/95-12/31/95
  OEM Service Release 2     4.00.1111* (4.00.950B)        8/24/96
  OEM Service Release 2.1   4.03.1212-1214* (4.00.950B)   8/24/96-8/27/97
  OEM Service Release 2.5   4.03.1214* (4.00.950C)        8/24/96-11/18/97
  Windows 98 retail, OEM    4.10.1998                     5/11/98
  Windows 98 Second Edition 4.10.2222A                    4/23/99
  Windows Millennium        4.90.3000
}
{ TODO : Distinquish between all these different releases? }

var
  KernelVersionHi: DWORD;

function GetNativeSystemInfo(var SystemInfo: TSystemInfo): Boolean;
type
  TGetNativeSystemInfo = procedure (var SystemInfo: TSystemInfo); stdcall;
var
  LibraryHandle: HMODULE;
  _GetNativeSystemInfo: TGetNativeSystemInfo;
begin
  Result := False;
  LibraryHandle := GetModuleHandle(kernel32);

  if LibraryHandle <> 0 then
  begin
    _GetNativeSystemInfo := GetProcAddress(LibraryHandle,'GetNativeSystemInfo');
    if Assigned(_GetNativeSystemInfo) then
    begin
      _GetNativeSystemInfo(SystemInfo);
      Result := True;
    end
    else
      GetSystemInfo(SystemInfo);
  end
  else
    GetSystemInfo(SystemInfo);
end;

function GetWindowsVersion: TWindowsVersion;
var
  TrimmedWin32CSDVersion: string;
  SystemInfo: TSystemInfo;
  OSVersionInfoEx: TOSVersionInfoEx;
const
  SM_SERVERR2 = 89;
begin
  Result := wvUnknown;
  TrimmedWin32CSDVersion := Trim(Win32CSDVersion);
  case Win32Platform of
    VER_PLATFORM_WIN32_WINDOWS:
      case Win32MinorVersion of
        0..9:
          if (TrimmedWin32CSDVersion = 'B') or (TrimmedWin32CSDVersion = 'C') then
            Result := wvWin95OSR2
          else
            Result := wvWin95;
        10..89:
          // On Windows ME Win32MinorVersion can be 10 (indicating Windows 98
          // under certain circumstances (image name is setup.exe). Checking
          // the kernel version is one way of working around that.
          if KernelVersionHi = $0004005A then // 4.90.x.x
            Result := wvWinME
          else
          if (TrimmedWin32CSDVersion = 'A') or (TrimmedWin32CSDVersion = 'B') then
            Result := wvWin98SE
          else
            Result := wvWin98;
        90:
          Result := wvWinME;
      end;
    VER_PLATFORM_WIN32_NT:
      case Win32MajorVersion of
        3:
          case Win32MinorVersion of
            1:
              Result := wvWinNT31;
            5:
              Result := wvWinNT35;
            51:
              Result := wvWinNT351;
          end;
        4:
          Result := wvWinNT4;
        5:
          case Win32MinorVersion of
            0:
              Result := wvWin2000;
            1:
              Result := wvWinXP;
            2:
              begin
                OSVersionInfoEx.dwOSVersionInfoSize := SizeOf(OSVersionInfoEx);
                SystemInfo.dwOemId := 0;
                GetNativeSystemInfo(SystemInfo);
                if GetSystemMetrics(SM_SERVERR2) <> 0 then
                  Result := wvWin2003R2
                else
                if (SystemInfo.wProcessorArchitecture <> PROCESSOR_ARCHITECTURE_INTEL) and
                  GetVersionEx(OSVersionInfoEx) and (OSVersionInfoEx.wProductType = VER_NT_WORKSTATION) then
                  Result := wvWinXP64
                else
                  Result := wvWin2003;
              end;
          end;
        6:
          case Win32MinorVersion of
            0:
              begin
                OSVersionInfoEx.dwOSVersionInfoSize := SizeOf(OSVersionInfoEx);
                if GetVersionEx(OSVersionInfoEx) and (OSVersionInfoEx.wProductType = VER_NT_WORKSTATION) then
                  Result := wvWinVista
                else
                  Result := wvWinServer2008;
              end;
            1:
              begin
                OSVersionInfoEx.dwOSVersionInfoSize := SizeOf(OSVersionInfoEx);
                if GetVersionEx(OSVersionInfoEx) and (OSVersionInfoEx.wProductType = VER_NT_WORKSTATION) then
                  Result := wvWin7
                else
                  Result := wvWinServer2008R2;
              end;
            2:
              begin
                OSVersionInfoEx.dwOSVersionInfoSize := SizeOf(OSVersionInfoEx);
                if GetVersionEx(OSVersionInfoEx) and (OSVersionInfoEx.wProductType = VER_NT_WORKSTATION) then
                  Result := wvWin8
                else
                  Result := wvWinServer2012;
              end;
          end;
      end;
  end;
end;

function IsWindows64: Boolean;
var
  ASystemInfo: TSystemInfo;
begin
  ASystemInfo.dwOemId := 0;
  GetNativeSystemInfo(ASystemInfo);
  Result := ASystemInfo.wProcessorArchitecture in [PROCESSOR_ARCHITECTURE_IA64,PROCESSOR_ARCHITECTURE_AMD64];
end;

//=== Alloc granularity ======================================================

procedure RoundToAllocGranularity64(var Value: Int64; Up: Boolean);
begin
  if (Value mod AllocGranularity) <> 0 then
    if Up then
      Value := ((Value div AllocGranularity) + 1) * AllocGranularity
    else
      Value := (Value div AllocGranularity) * AllocGranularity;
end;

procedure RoundToAllocGranularityPtr(var Value: Pointer; Up: Boolean);
var
  Addr: TJclAddr;
begin
  Addr := TJclAddr(Value);
  if (Addr mod AllocGranularity) <> 0 then
  begin
    if Up then
      Addr := ((Addr div AllocGranularity) + 1) * AllocGranularity
    else
      Addr := (Addr div AllocGranularity) * AllocGranularity;
    Value := Pointer(Addr);
  end;
end;

//=== Initialization/Finalization ============================================

procedure InitSysInfo;
var
  SystemInfo: TSystemInfo;
begin
  { processor information related initialization }
  ResetMemory(SystemInfo, SizeOf(SystemInfo));
  GetSystemInfo(SystemInfo);
  ProcessorCount := SystemInfo.dwNumberOfProcessors;
  AllocGranularity := SystemInfo.dwAllocationGranularity;
  PageSize := SystemInfo.dwPageSize;
end;

initialization
  InitSysInfo;

finalization

end.
