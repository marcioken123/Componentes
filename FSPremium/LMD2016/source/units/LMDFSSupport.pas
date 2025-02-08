unit LMDFSSupport;
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

LMDFSSupport unit (DD)
--------------------
LMD File System support

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes;

procedure LMDWebCreateDirs(const szDir: string);

function LMDWebStreamToFile(const szName: string; Stream: TSTream): Boolean;
function LMDWebWriteFileFromString(const szName: string; const AData: String;
  ADataSize: integer = -1; AFileTime: TDateTime = 0; ARangeStart: Int64 = 0): boolean;

function LMDWebStringToStream(Stream: TStream; const Data: string;
                    DataSize: integer = -1): boolean;
function LMDWebStreamToString(Stream: TStream; var Data: string;
                    DataSize: integer = -1): boolean;

function LMDWebCreateFileName(const szPath, szDefFileName, URL: string;
  bCreateDirs: boolean): string;
function LMDWebAddSlash(const szStr: string): string;
function LMDWebDeleteSlash(const szStr: string): string;
function LMDWebAddBackSlash(const szStr: string): string;
function LMDWebDeleteBackSlash(const szStr: string): string;
function LMDWebDeleteFirstBackSlash(const szStr: string): string;
function LMDWebGetWebFileURL(const URL: string; bExtraInfo: boolean = True): string;
function LMDWebGetAppDataPath:String;

function LMDWebFileSetDate(const FileName: string; ATimeStamp: TDateTime): Boolean;

function LMDWebGetFileSize(const FileName: string): Int64;

implementation

uses
  Windows, Math, SysUtils, WinInet,
  LMDWebBase, LMDStringsSupport, LMDURLSupp, LMDHTTPSupp, LMDStrings, LMDProcs;

type
  PFNSHGETFOLDERPATHA = function(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWord; pszPath: PAnsiChar): HRESULT; stdcall;
  PFNSHGETFOLDERPATH = PFNSHGETFOLDERPATHA;

  TSHGetFolderPathA = PFNSHGETFOLDERPATHA;
  TSHGetFolderPath = TSHGetFolderPathA;

{-----------------------------------------------------------------------------}
function  LMDWebGetAppDataPath: string;
var
  hLib : THandle;
  p : TSHGetFolderPath;
  szPath:array [0..MAX_PATH] of char;
begin
  Result := '';
  hLib := LoadLibrary('SHFolder.dll');
  if hLib<>0 then
  begin
    try
      p := GetProcAddress(hLib,'SHGetFolderPathA');
      if Assigned(p) then
      begin
        p(0, $001a{CSIDL_APPDATA}or $8000{CSIDL_FLAG_CREATE}, 0, 0, @szPath);
        Result := StrPas(szPath)+'\';
      end;
    finally
      FreeLibrary(hLib);
    end;
  end;
end;

{-----------------------------------------------------------------------------}

procedure LMDWebCreateDirs(const szDir: string);
var
  szTmp: string;
  iPos: integer;
begin
  iPos:= LMDAnsiPosEx('\', szDir, 4);
  while iPos > 0 do
    begin
      szTmp:= Copy(szDir, 1, iPos - 1);
      CreateDir(szTmp);
      iPos:= LMDAnsiPosEx('\', szDir, iPos + 1);
    end;

  if  (Length(szDir) > 0) and (szDir[Length(szDir)] <> '\') then
    CreateDir(szDir);
end;

{-----------------------------------------------------------------------------}

function LMDWebStreamToFile(const szName: string; Stream: TSTream): Boolean;
var
  FS: TFileStream;
begin
  Result := False;

  try
    FS:= TFileStream.Create(szName, fmCreate);

    try
      FS.CopyFrom(Stream, Stream.Size - Stream.Position); 
    finally
      FS.Free;
    end;
  except
    ;
  end;
end;

{-----------------------------------------------------------------------------}

function LMDWebStringToStream(Stream: TStream; const Data: string;
                    DataSize: integer = -1): boolean;
begin
  if  DataSize < 0  then
    DataSize := Length(Data) * SizeOf(Char)
  else
    if  DataSize > 0  then
      DataSize := min(DataSize, Length(Data) * SizeOf(Char));

  try

//    Result := (Stream.Write(PAnsiChar(AnsiString(Data))^, DataSize) = DataSize);
    Result := (Stream.Write(PChar(String(Data))^, DataSize) = DataSize);

  except
    Result := False;
  end;
end;

{-----------------------------------------------------------------------------}

function LMDWebStreamToString(Stream: TStream; var Data: string;
                    DataSize: integer = -1): boolean;
var
  {$ifdef LMDCOMP12}
  Buffer: TBytes;
  {$else}
  Buffer: array of Byte;
  {$endif}
begin
  if  not Assigned(Stream)  then
    begin
      Data := '';
      Result := True;
      exit;
    end;

  if  DataSize < 0  then
    DataSize := Stream.Size - Stream.Position
  else
  if  DataSize > 0  then
    DataSize := min(DataSize, Stream.Size - Stream.Position);

  if  DataSize = 0  then
    begin
      Data := '';
      Result := True;
      exit;
    end;

  try

    SetLength(Buffer, DataSize);
    Result := (Stream.Read(Buffer[0], DataSize) = DataSize);
    {$ifdef LMDCOMP12}
    Data := StringOf(Buffer);
    {$else}
    SetLength(Data, DataSize);
    Move(Buffer[0], Data[1], DataSize);
    {$endif}

  except
    Result := False;
  end;
end;

{-----------------------------------------------------------------------------}
function LMDWebWriteFileFromString(const szName: string; const AData: String;
    ADataSize: integer = -1; AFileTime: TDateTime = 0; ARangeStart: Int64 = 0): boolean;
var
  FS: TFileStream;
begin
  Result:= False;
  try
    if FileExists(szName) and (ARangeStart > 0) then
    begin
      FS := TFileStream.Create(szName, fmOpenWrite);
      FS.Position := ARangeStart;
    end
    else
      FS:= TFileStream.Create(szName, fmCreate);

    if (ADataSize < 0) then
      ADataSize := Length(AData);

    try
      Result := (FS.Write(PAnsiChar(AnsiString(AData))^, ADataSize) = ADataSize);
//      Result:= LMDWebStringToStream(FS, AData, ADataSize);
    finally
      FS.Free;
    end;

    if  Result and (AFileTime <> 0)  then
      Result := LMDWebFileSetDate(szName, AFileTime);
  except
  end;
end;

{-----------------------------------------------------------------------------}
function LMDWebCreateFileName(const szPath, szDefFileName, URL: string; bCreateDirs:
  boolean): string;
var
  szTmp: string;
  i: integer;
  bFile: boolean;
  urlcomp: TURLComponents;
begin
  Result:= ExpandFileName(szPath);
  if (Result <> '') and (Result[Length(Result)] <> '\') then
    Result:= Result + '\';
  LMDWebClearData(urlcomp, sizeof(urlcomp), 0);
  urlcomp.dwSchemeLength:= 20;
  urlcomp.dwHostNameLength:= 100;
  urlcomp.dwUrlPathLength:= 400;
  LMDWebAllocTURLComponents(urlcomp, ICU_DECODE);

  try
    InternetCrackURL(Int_Ref(URL), Length(URL), ICU_DECODE, urlcomp);
    Result:= Result + LMDWebBufToStr(urlcomp.lpszHostName, urlcomp.dwHostNameLength) + '\';
    szTmp:= LMDWebBufToStr(urlcomp.lpszUrlPath, urlcomp.dwUrlPathLength);
  finally
    LMDWebFreeTURLComponents(urlcomp, ICU_DECODE);
  end;

  for i:= 1 to Length(szTmp) do
    if szTmp[i] = '/' then
      begin
        if i <> 1 then
          Result:= Result + '\';
      end
    else
      if AnsiChar(szTmp[i]) in ['%', '&', '@', '=', '?'] then
        Result:= Result + '_'
      else
        Result:= Result + szTmp[i];
  bFile:= True;
  if (Length(szTmp) > 0) and (szTmp[Length(szTmp)] <> '/') then
    for i:= Length(szTmp) downto 1 do
      if szTmp[i] = '.' then
        break
      else
        if szTmp[i] = '/' then
          begin
            bFile:= False;
            break;
          end;
  if not bFile then
    Result:= Result + '\';
  if Result[Length(Result)] = '\' then
    Result:= Result + szDefFileName;
  if bCreateDirs then
    LMDWebCreateDirs(ExtractFilePath(Result));
end;

{-----------------------------------------------------------------------------}

function LMDWebAddToEnd(const szStr: string; C: char): string;
begin
  if  (szStr <> '') and (szStr[Length(szStr)] <> C) then
    Result := szStr + C
  else
    Result := szStr;
end;

{-----------------------------------------------------------------------------}

function LMDWebDeleteFromEnd(const szStr: string; C: char): string;
begin
  if  (szStr <> '') and (szStr[Length(szStr)] = C) then
    Result := Copy(szStr, 1, Length(szStr))
  else
    Result := szStr;
end;

{-----------------------------------------------------------------------------}

function LMDWebAddSlash(const szStr: string): string;
begin
  Result := LMDWebAddToEnd(szStr, '\');
end;

{-----------------------------------------------------------------------------}

function LMDWebDeleteSlash(const szStr: string): string;
begin
  Result := LMDWebDeleteFromEnd(szStr, '\');
end;

{-----------------------------------------------------------------------------}

function LMDWebAddBackSlash(const szStr: string): string;
begin
  Result := LMDWebAddToEnd(szStr, '/');
end;

{-----------------------------------------------------------------------------}

function LMDWebDeleteBackSlash(const szStr: string): string;
begin
  Result := LMDWebDeleteFromEnd(szStr, '/');
end;

{-----------------------------------------------------------------------------}

function LMDWebDeleteFirstBackSlash(const szStr: string): string;
begin
  Result:= szStr;
  if Result <> '' then
    begin
      if Result[1] = '/' then
        Result:= Copy(Result, 2, Length(Result) - 1);
    end;
end;

{-----------------------------------------------------------------------------}

function LMDWebGetWebFileURL(const URL: string; bExtraInfo: boolean = True): string;
var
  szTmp, S: string;
  i, j: integer;
  urlcomp: TURLComponents;
begin
  S := HTTPDecode(URL);
  LMDWebClearData(urlcomp, sizeof(urlcomp), 0);
  urlcomp.dwSchemeLength:= 100;
  urlcomp.dwUserNameLength:= 100;
  urlcomp.dwPasswordLength:= 100;
  urlcomp.dwHostNameLength:= 100;
  urlcomp.dwUrlPathLength:= 400;
  urlcomp.dwExtraInfoLength:= 400;

  urlcomp.dwStructSize:= sizeof(urlcomp);

  InternetCrackURL(Int_Ref(S),Length(S), 0, urlcomp);
  szTmp:= LMDWebBufToStr(urlcomp.lpszScheme, urlcomp.dwSchemeLength);

  if IsAnyStr(szTmp, ['HTTP', 'FTP'], True) then
    begin
      szTmp:= szTmp + '://';
      Result:= szTmp + LMDWebBufToStr(urlcomp.lpszHostName, urlcomp.dwHostNameLength) +
        LMDWebDeleteBackSlash(
          LMDWebBufToStr(urlcomp.lpszUrlPath, urlcomp.dwUrlPathLength));
      szTmp:= LMDWebBufToStr(urlcomp.lpszExtraInfo, urlcomp.dwExtraInfoLength);
      if bExtraInfo and (szTmp <> '') then
        begin
          i:= Pos('#', szTmp);
          while i > 0 do
            begin
              j:= LMDAnsiPosEx('&', szTmp, i);
              if j > 0 then
                i:= LMDAnsiPosEx('#', szTmp, j)
              else
                break;
            end;
          if i > 0 then
            szTmp:= Copy(szTmp, 1, i - 1);
          Result:= Result + szTmp;
        end;
    end
  else
    begin
      Result:= HTTPDecode(URL);
    end;
end;

{------------------------------------------------------------------------------}
function LMDWebFileSetDate(const FileName: string; ATimeStamp: TDateTime): Boolean;
begin
  Result := (ATimeStamp > 0)
      and (SysUtils.FileSetDate(FileName, 
                                          DateTimeToFileDate(ATimeStamp)
                                ) = 0);
end;

function LMDWebGetFileSize(const FileName: string): Int64;
var
  LFile: THandle;
  LSizeHi: DWORD;
begin
  LFile := FileOpen(FileName, fmOpenRead);
  Result := GetFileSize(LFile, @LSizeHi);
  FileClose(LFile);
  Result := Result + LSizeHi shl 4;
end;

end.
