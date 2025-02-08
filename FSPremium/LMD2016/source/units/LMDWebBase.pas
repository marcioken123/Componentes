unit LMDWebBase;
{$I LMDCmps.inc}

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

LMDWebBase unit (DD)
-------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, LMDCustomComponent, LMDTypes;

type
  TLMDWebVersionRecord=record
     Major:Word;
     Minor:Word;
     Release:Word;
     Build:Word;
  end;

  {-------------------- TLMDWebComponent --------------------------------------}
  TLMDWebComponent = class(TLMDCustomComponent)
  public
    function getLMDPackage:TLMDPackageID;override;
  published
    property About;
  end;

function LMDWebGetFullFileName(const szFileName: string): string;
function LMDWebRenameFileEx(const szOldFileName, szNewFileName: string; var NeedReboot: boolean): boolean;
function LMDWebTerminateProcessByName(const FileName: String): Boolean;
function LMDWebGetFileVersionRecord(const FileName: String; var vr:TLMDWebVersionRecord): Boolean;
function LMDWebGetFileVersion(const FileName: String; var VersionString: String): Boolean;
function LMDWebCompareVersionNumber(const szTest:String; const szBase:String=''):Integer;
function LMDWebVersionToStr(const Version: TLMDWebVersionRecord): String;
procedure LMDWebExecuteFile(const FileName: string; Wait: boolean);

// ZLIB support, Win32 only

function LMDWebCompressFile(szOldFileName, szNewFileName: string): boolean;
procedure LMDWebDeCompress(InStream, OutStream: TStream);

procedure LMDWebClearData(var D; Size: integer; Ch: byte);{$IFDEF LMD_INLINE}inline;{$ENDIF}

const
    // LMDWebUpdate const - do NOT localize
  WU_MAIN_DIR = '%MAIN%';
  WU_SYSTEM_DIR = '%SYSTEM%';
  WU_WINDOWS_DIR = '%WINDOWS%';
  WU_COMP_SIGN = 'WU COMP';
  // Other const
  MAX_SERVER_THREADS = 30;
  SE_EXCEPTION = 1;
  // LMDNews const
  LNEWS_IMAGES_ROOTKEY = 'IMAGES';
  LNEWS_ROOTKEY = 'NEWS';
  LNEWS_TREE_ROOTKEY = 'NEWSTREE';
  LNEWS_URL = 'URL';
  LNEWS_SEL_IMAGE = 'SELECTEDIMAGE';
  LNEWS_IMAGE = 'IMAGE';
  LNEWS_IMAGES_BASEURL = 'BASEURL';
  LNEWS_IMAGES_INDEX = 'INDEX';
  LNEWS_IMAGES_FILENAME = 'FILENAME';

implementation

uses
  Windows, SysUtils, IniFiles, {$IFDEF LMD_DEBUGTRACE}Dialogs,{$ENDIF}
  TLHelp32,
  LMDZLib, LMDStringsSupport, LMDStrings;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

{ TLMDWebComponent }
{-----------------------------------------------------------------------------}
function TLMDWebComponent.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_WEB;
end;

{-----------------------------------------------------------------------------}
procedure LMDWebDeCompress(InStream, OutStream: TStream);
const
  BufferSize=8192;
var
  ZStream:TLMDDecompressionStream;
  Count: LongInt;
  Buffer:array [0..BufferSize-1] of Byte;
begin
  ZStream := TLMDDecompressionStream.Create(InStream);
  try
    repeat
      Count:=ZStream.Read(Buffer, BufferSize);
      if Count>0 then
        OutStream.WriteBuffer(Buffer, Count)
      else
        break;
    until Count <> BufferSize;
  finally
    ZStream.Free;
  end;
end;

{------------------------------------------------------------------------------}
function LMDWebCompressFile(szOldFileName, szNewFileName: string): boolean;
var
  FSI: TFileStream;
  FSO: TFileStream;
  CS: TLMDCompressionStream;
  lSize: longint;
  ftCT: TFileTime;
  ftAT: TFileTime;
  ftLW: TFileTime;
  hFile: THandle;
  szTmp: array[0..Length(WU_COMP_SIGN)] of char;
begin
  Result:= szOldFileName <> szNewFileName;
  if Result then
    begin
      FSI:= TFileStream.Create(szOldFileName, fmOpenRead);
      LMDWebClearData(szTmp, Length(WU_COMP_SIGN), 0);
//      FillChar(szTmp, Length(WU_COMP_SIGN), 0);
      FSI.Read(szTmp, Length(WU_COMP_SIGN));
      FSI.Position:= 0;
      FSO:= TFileStream.Create(szNewFileName, fmCreate);
      lSize:= FSI.Size;
      if szTmp <> WU_COMP_SIGN then
        begin
          FSO.Write(WU_COMP_SIGN[1], Length(WU_COMP_SIGN));
          CS := TLMDCompressionStream.Create(clMax, FSO);
          CS.Write(lSize, SizeOf(lSize));
          CS.CopyFrom(FSI, FSI.Size);
          CS.Free;
        end
      else
        FSO.CopyFrom(FSI, lSize);
      FSO.Free;
      FSI.Free;
      hFile:= CreateFile(PChar(szOldFileName), GENERIC_READ, FILE_SHARE_READ,
        nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
      GetFileTime(hFile, @ftCT, @ftAT, @ftLW);
      CloseHandle(hFile);
      hFile:= CreateFile(PChar(szNewFileName), GENERIC_WRITE, FILE_SHARE_READ,
        nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
      SetFileTime(hFile, @ftCT, @ftAT, @ftLW);
      CloseHandle(hFile);
    end;
end;

{-----------------------------------------------------------------------------}
function LMDWebGetFullFileName(const szFileName: string): string;

function GetAppFilePath: string;
  var
    buf: array[0..255] of char;
  begin
    GetModuleFileName(HInstance, buf, sizeof(buf));
    Result:= ExtractFilePath(buf);
    SetLength(Result, Length(Result) - 1);
  end;

  function GetSysPath: string;
  var
    buf: array[0..255] of char;
  begin
    GetSystemDirectory(buf, sizeof(buf));
    Result:= buf;
  end;

  function GetWinPath: string;
  var
    buf: array[0..255] of char;
  begin
    GetWindowsDirectory(buf, sizeof(buf));
    Result:= buf;
  end;

begin
  if pos(WU_MAIN_DIR, szFileName) > 0 then
    begin
      Result:= LMDAnsiReplaceStr(szFileName, WU_MAIN_DIR, GetAppFilePath);
    end
  else
    if pos(WU_SYSTEM_DIR, szFileName) > 0 then
      begin
        Result:= LMDAnsiReplaceStr(szFileName, WU_SYSTEM_DIR, GetSysPath);
      end
    else
      if pos(WU_WINDOWS_DIR, szFileName) > 0 then
        begin
          Result:= LMDAnsiReplaceStr(szFileName, WU_WINDOWS_DIR, GetWinPath);
        end
      else
        Result:= ExpandFileName(szFileName);
end;

{------------------------------------------------------------------------------}
procedure LMDWebInitVersionRecord(var vr:TLMDWebVersionRecord);
begin
  vr.Major:=0;
  vr.Minor:=0;
  vr.Release:=0;
  vr.Build:=0;
end;

{------------------------------------------------------------------------------}
function LMDWebEqualVersionRecord(v1, v2:TLMDWebVersionRecord):Boolean;
begin
  result:= (v1.Major=v2.Major) and (v1.Minor=v2.Minor) and (v1.Release=v2.Release)
           and (v1.Build=v2.Build);
end;

{-----------------------------------------------------------------------------}
function LMDWebVersionToStr(const Version: TLMDWebVersionRecord): String;
begin
  Result := IntToStr(Version.Major) + '.' + IntToStr(Version.Minor) + '.' +
                   IntToStr(Version.Release) + '.' + IntToStr(Version.Build);
end;

{-----------------------------------------------------------------------------}
{ Helper function to get the actual file version information }

function LMDWebGetFileVersionRecord(const FileName: String; var vr:TLMDWebVersionRecord): Boolean;
var
  Info: Pointer;
  FileInfo: PVSFixedFileInfo;
  InfoSize: DWORD;
  FileInfoSize: DWORD;
  Tmp: DWORD;
begin
  Result := False;
  LMDWebInitVersionRecord(vr);

  if not FileExists(FileName) then exit;
  // Get the size of the FileVersionInformatioin
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Tmp);
  // If InfoSize = 0, then the file may not exist, or
  // it may not have file version information in it.
  if InfoSize = 0 then
    raise Exception.Create('Can''t get file version information for ' + FileName);
  // Allocate memory for the file version information
  GetMem(Info, InfoSize);
  try
    // Get the informationM
    GetFileVersionInfo(PChar(FileName), 0, InfoSize, Info);
    // Query the information for the version
    VerQueryValue(Info, '\', Pointer(FileInfo), FileInfoSize);
    // Now fill in the version information
    vr.Major:=FileInfo.dwFileVersionMS shr 16;
    vr.Minor:=FileInfo.dwFileVersionMS and $FFFF;
    vr.Release:=FileInfo.dwFileVersionLS shr 16;
    vr.Build:=FileInfo.dwFileVersionLS and $FFFF;
  finally
    FreeMem(Info, FileInfoSize);
  end;
  Result := True;
end;

{-----------------------------------------------------------------------------}
function LMDWebGetFileVersion(const FileName: String; var VersionString: String): Boolean;
var
  tmp:TLMDWebVersionRecord;
begin
  result:=LMDWebGetFileVersionRecord(FileName, tmp);
  VersionString:=IntToStr(tmp.Major)+'.'+IntToStr(tmp.Minor)+'.'+
                 IntToStr(tmp.Release)+'.'+IntToStr(tmp.Build)
end;

{-----------------------------------------------------------------------------}
function LMDWebCompareVersionNumber(const szTest:String; const szBase:String=''):Integer;
var
  v1, v2:TLMDWebVersionRecord;
  IsNewer:Boolean;

  function SplitNumbers(value:String):TLMDWebVersionRecord;
  var
    p:Integer;
  begin
     LMDWebInitVersionRecord(result);
     // Major
     p:=pos('.', value); if p=0 then p:=Length(value)+1;
     Result.Major:=StrToIntDef(Copy(value,1,p-1),0);
     Delete(value,1,p);
     //Minor
     p:=pos('.', value); if p=0 then p:=Length(value)+1;
     Result.Minor:=StrToIntDef(Copy(value,1,p-1),0);
     Delete(value,1,p);
     // Release
     p:=pos('.', value); if p=0 then p:=Length(value)+1;
     Result.Release:=StrToIntDef(Copy(value,1,p-1),0);
     Delete(value,1,p);
     // Build
     p:=pos('.', value);
     if p=0 then p:=Length(value)+1;
     Result.Build:=StrToIntDef(Copy(value,1,p-1),0);
  end;

begin
  v1:=SplitNumbers(szTest);
  v2:=SplitNumbers(szBase);

  IsNewer:=false;
  if LMDWebEqualVersionRecord(v1, v2) then
    begin
      result:=0;
      exit;
    end
  else
    if (v1.Major>v2.Major) then
      IsNewer:=True
    else if v1.Major = v2.Major then
      if v1.Minor>v2.Minor then
        IsNewer:=True
      else if v1.Minor = v2.Minor then
        if v1.Release>v2.Release then
          IsNewer:=True
        else if v1.Release = v2.Release then
          if v1.Build>v2.Build then
            IsNewer:=True;

  if IsNewer then result:=1 else result:=-1;
end;

{-----------------------------------------------------------------------------}

function GetProcessID(const ExeFile: String): DWORD;
var
  Snapshot: THandle;
  ProcessEntry: TProcessEntry32;
  FileName: string;
begin
  Result := 0;
  FileName := ExtractFileName(ExeFile);
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot <> 0 then
  try
    ProcessEntry.dwSize :=
      SizeOf(ProcessEntry);
    if Process32First(Snapshot, ProcessEntry) then
    repeat
      if SameText(FileName, ProcessEntry.szExeFile) then
      begin
        Result := ProcessEntry.th32ProcessID;
        Exit;
      end;
    until not Process32Next(Snapshot, ProcessEntry);
  finally
    CloseHandle(Snapshot);
  end;
end;

{-----------------------------------------------------------------------------}

function LMDWebRenameFileEx(const szOldFileName, szNewFileName: string;
  var NeedReboot: boolean): boolean;
var
  IniFile: TIniFile;
begin
  DeleteFile(szNewFileName);
  NeedReboot:= not RenameFile(szOldFileName, szNewFileName);
  if NeedReboot then
    begin
      if GetVersion() < $80000000 then //Windows NT
        begin

          MoveFileEx(PChar(szNewFileName), nil, MOVEFILE_DELAY_UNTIL_REBOOT);
          Result:= MoveFileEx(PChar(szOldFileName), PChar(szNewFileName),
            MOVEFILE_DELAY_UNTIL_REBOOT);

        end
      else
        begin
          IniFile:= TIniFile.Create('WININIT.INI');
          try
            IniFile.WriteString('rename', 'NUL', szNewFileName);
            IniFile.WriteString('rename', szNewFileName, szOldFileName);
            Result:= True;
          except
            Result:= False;
          end;
          IniFile.Free;
        end;
    end
  else
    Result:= True;
end;

{-----------------------------------------------------------------------------}

function LMDWebTerminateProcessByName(const FileName: String): Boolean;
var
  ProcessHandle: THandle;
  ProcessID: DWORD;
begin
  Result := False;
  ProcessID := GetProcessID(FileName);
  if ProcessID = 0 then exit;
  ProcessHandle := OpenProcess(PROCESS_TERMINATE, False, ProcessID);
  if WaitForSingleObject(ProcessHandle, 5000) <> WAIT_OBJECT_0 then
  TerminateProcess(ProcessHandle, 0); // Hasta la vista, baby!
  Result := True;
end;

{-----------------------------------------------------------------------------}

procedure LMDWebExecuteFile(const FileName: string; Wait: boolean);
var
  si: TStartupInfo;
  pi: TProcessInformation;
  Cmd, Params: string;
  CurDir, FN: string;
begin
  LMDWebClearData(si, sizeof(si), 0);
  si.dwFlags:= STARTF_USESHOWWINDOW;
  si.wShowWindow:= SW_HIDE;
  FN := ExpandFileName(FileName);
  Cmd := '';
  Params := '';

  if SameText(ExtractFileExt(FN), '.BAT') then
    Params := FN
  else
    Cmd := FN;

  CurDir := ExtractFilePath(FN);

  si.cb:= sizeof(si);
  CreateProcess(PChar(Cmd), PChar(Params), nil, nil, False,
      NORMAL_PRIORITY_CLASS, nil, PChar(CurDir), si, pi);

  if Wait and (pi.HProcess <> 0)  then
    WaitForSingleObject(pi.HProcess, INFINITE);
end;

procedure LMDWebClearData(var D; Size: integer; Ch: byte);
begin

  FillChar(D, Size, Ch);

end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}
end.
