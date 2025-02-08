unit LMDWebUpdate;
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

LMDWebUpdate unit (DD)
--------------------
LMD Web Update

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes,
  LMDWebBase, LMDURLSupp, LMDDownload;

type
  TLMDWebUpdateState = (wusNone, wusGetServersURL, wusGetVersions, wusUpdate,
    wusReady, wusError);
  TLMDWebUpdateFilestate = (wufsNone, wufsUpdated, wufsUpdateDontNeeded,
    wufsLocalFileNotFound, wufsUpdateError);
  TLMDWUFileAction = (wufaUpdate, wufaUpdateCopy, wufaCopy, wufaExecute);

  { **************************TLMDCustomWebUpdate**************************** }
  TLMDCustomWebUpdate = class;

  { **************************TLMDWebUpdateFileItem**************************** }
  TLMDWebUpdateFileItem = class(TCollectionItem)
  private
    FTmpFileName: string;
    FLocalFileSize: DWORD;
    FLocalFileDate: TDateTime;
    FServerFileName: string;
    FServerPath: string;
    FFileName: string;
    FUpdateState: TLMDWebUpdateFilestate;
    FError: DWORD;
    FErrorString: string;
    FFileAction: TLMDWUFileAction;
    FRequired: boolean;
    FUserName: string;
    FPassword: string;
    FTag: integer;
    FData: TObject;
    procedure SetFileName(const Value: string);
    procedure SetServerFileName(const Value: string);
    procedure SetServerPath(const Value: string);
    procedure FetchLocalFileProperties;
    function GetFullFileName: string;
    procedure SetFileAction(const Value: TLMDWUFileAction);
    procedure SetRequired(const Value: boolean);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetData(const Value: TObject);
    procedure SetTag(const Value: integer);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    property FullFileName: string read GetFullFileName;
    property ErrorString: string read FErrorString;
    property dwError: DWORD read FError;
    property UpdateState: TLMDWebUpdateFilestate read FUpdateState;
    property Data: TObject read FData write SetData;
    property Tag: integer read FTag write SetTag default 0;
  published
    property UserName: string read FUserName write SetUserName;
    property Password: string read FPassword write SetPassword;
    property Required: boolean read FRequired write SetRequired;
    property FileAction: TLMDWUFileAction read FFileAction write SetFileAction;
    property FileName: string read FFileName write SetFileName;
    property ServerPath: string read FServerPath write SetServerPath;
    property ServerFileName: string read FServerFileName write SetServerFileName;
  end;

  { **************************TLMDWebUpdateFiles**************************** }
  TLMDWebUpdateFiles = class(TOwnedCollection)
  private
    function GetItem(Index: integer): TLMDWebUpdateFileItem;
  public
    constructor Create(Owner: TLMDCustomWebUpdate);
    function Add: TLMDWebUpdateFileItem;
    property Items[Index: integer]: TLMDWebUpdateFileItem read GetItem; default;
  end;
  TLMDWebUpdateProgress = procedure(Sender: TLMDCustomWebUpdate; iPercent:
    integer; FileItem: TLMDWebUpdateFileItem; Item: TLMDDownloadItem) of object;

  { **************************TLMDCustomWebUpdate**************************** }
  TLMDCustomWebUpdate = class(TLMDWebComponent)
  private
    FDownloads: TLMDDownloads;
    FState: TLMDWebUpdateState;
    FServers: TStringList;
    FdwError: DWORD;
    FErrorString: string;
    FOnProgress: TLMDWebUpdateProgress;
    FOnError: TNotifyEvent;
    FOnProcessed: TNotifyEvent;
    FFiles: TLMDWebUpdateFiles;
    FMaxPercent: integer;
    FInfoPercent: integer;
    FDefaultScheme: string;
    FAutoApply: boolean;
    FRebootNeeded: boolean;
    FUserName: string;
    FPassword: string;
    FVersions: TStringList;
    procedure SetServers(const Value: TStringList);
    procedure OnDProgress(Sender: TLMDDownloadItem);
    procedure OnDProcessed(Sender: TLMDDownloads);
    procedure GetError(Sender: TLMDDownloadItem);
    function FetchServersProcessed(Sender: TLMDDownloadItem): boolean;
    procedure SetOnError(const Value: TNotifyEvent);
    procedure SetOnProcessed(const Value: TNotifyEvent);
    procedure SetOnProgress(const Value: TLMDWebUpdateProgress);
    procedure SetFiles(const Value: TLMDWebUpdateFiles);
    procedure SetInfoPercent(const Value: integer);
    procedure SetMaxPercent(const Value: integer);
    procedure SetDefaultScheme(const Value: string);
    procedure SetAutoApply(const Value: boolean);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetIO(const Value: TLMDInternetOptions);
    function GetIO: TLMDInternetOptions;
    function GetOnInteractiveEvent: TLMDInternetOptionsInteractiveEvent;
    procedure SetOnInteractiveEvent(const Value: TLMDInternetOptionsInteractiveEvent);
  protected
    property UserName: string read FUserName write SetUserName;
    property Password: string read FPassword write SetPassword;
    property AutoApply: boolean read FAutoApply write SetAutoApply default True;
    property DefaultScheme: string read FDefaultScheme write SetDefaultScheme;
    property InternetOptions: TLMDInternetOptions read GetIO write SetIO;
    property State: TLMDWebUpdateState read FState;
    property Servers: TStringList read FServers write SetServers;
    property Versions: TStringList read FVersions;
    property Files: TLMDWebUpdateFiles read FFiles write SetFiles;
    property dwError: DWORD read FdwError;
    property ErrorString: string read FErrorString;
    property MaxPercent: integer read FMaxPercent write SetMaxPercent default 100;
    property InfoPercent: integer read FInfoPercent write SetInfoPercent default 10;
    property RebootNeeded: boolean read FRebootNeeded default False;
    property OnProgress: TLMDWebUpdateProgress read FOnProgress write
      SetOnProgress;
    property OnProcessed: TNotifyEvent read FOnProcessed write SetOnProcessed;
    property OnError: TNotifyEvent read FOnError write SetOnError;
    function GetServerFilePath(szServerURL: string; Index: integer): string;
      virtual;
    function CalcPercent: integer; virtual;
    procedure ClearTmpLocalFiles;
    function SaveLocalFile(FileItem: TLMDWebUpdateFileItem; DItem:
      TLMDDownloadItem): boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ApplyUpdate: boolean; virtual;
    class function TerminateApplication(const FileName: String): Boolean;
    class function LMDGetFileVersion(const FileName: String; var Major1, Major2,
                                     Minor1, Minor2: Integer): Boolean; overload;
    class function LMDGetFileVersion(FileName: String; var VersionString: String): Boolean; overload;
    procedure CancelUpdate; virtual;
    function ProcessUpdate(const szURL: string): boolean;
    procedure StopProcess;
    procedure WaitForStopProcess;
    function FetchServers(const szURL: string; Blocked: boolean): boolean;
    function FetchVersions(const szURL: string): boolean;
    property OnInteractiveEvent:TLMDInternetOptionsInteractiveEvent read GetOnInteractiveEvent write SetOnInteractiveEvent;
  end;

  { **************************TLMDWebUpdate**************************** }
  TLMDWebUpdate = class(TLMDCustomWebUpdate)
  public
    property State;
    property RebootNeeded;
    property dwError;
    property ErrorString;
    property Versions;
  published
    property UserName;
    property Password;
    property AutoApply;
    property MaxPercent;
    property InfoPercent;
    property DefaultScheme;
    property InternetOptions;
    property Servers;
    property Files;
    property OnProgress;
    property OnProcessed;
    property OnError;
    property OnInteractiveEvent;
  end;

implementation

uses
  LMDZLib, SysUtils, LMDWebConst, LMDFSSupport;

{ **************************TLMDCustomWebUpdate**************************** }

{-----------------------------------------------------------------------------}

function TLMDCustomWebUpdate.ApplyUpdate: boolean;
var
  i: integer;
  b: boolean;
  szFileName: string;
begin
  Result:= FState = wusReady;
  if Result then
    begin
      for i:= 0 to FFiles.Count - 1 do
        begin
          with FFiles[i] do
            begin
              if (FUpdateState = wufsUpdated) and (FileExists(FTmpFileName))
                then
                begin
                  case FileAction of
                    wufaUpdate, wufaUpdateCopy, wufaCopy:
                      begin
                        if LMDWebRenameFileEx(FTmpFileName, FullFileName, b) then
                          begin
                            FTmpFileName:= '';
                            FRebootNeeded:= FRebootNeeded or b;
                          end
                        else
                          if Required then
                            begin
                              Result:= False;
                              break;
                            end;
                      end;
                    wufaExecute:
                      begin
                        szFileName:= FullFileName;
                        DeleteFile(szFileName);
                        if RenameFile(FTmpFileName, szFileName) then
                          begin
                            FTmpFileName:= '';
                            LMDWebExecuteFile(szFileName, True);
                            DeleteFile(szFileName);
                          end
                        else
                          begin
                            DeleteFile(FTmpFileName);
                            FTmpFileName:= '';
                            if Required then
                              begin
                                Result:= False;
                                break;
                              end;
                          end;
                      end;
                  end;
                end;
            end;
        end;
      if Result then
        FState:= wusNone
      else
        FState:= wusError;
    end;
end;

{-----------------------------------------------------------------------------}

class function TLMDCustomWebUpdate.TerminateApplication(const FileName: String): Boolean;
begin
  Result := LMDWebTerminateProcessByName(FileName);
end;

{-----------------------------------------------------------------------------}
{ Helper function to get the actual file version information }

class function TLMDCustomWebUpdate.LMDGetFileVersion(const FileName: String;
 var Major1, Major2, Minor1, Minor2: Integer): Boolean;
var
  Info: Pointer;
  InfoSize: DWORD;
  FileInfo: PVSFixedFileInfo;
  FileInfoSize: DWORD;
  Tmp: DWORD;
begin
  Result := False;
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
    Major1 := FileInfo.dwFileVersionMS shr 16;
    Major2 := FileInfo.dwFileVersionMS and $FFFF;
    Minor1 := FileInfo.dwFileVersionLS shr 16;
    Minor2 := FileInfo.dwFileVersionLS and $FFFF;
    Result := True;
  finally
    FreeMem(Info, FileInfoSize);
  end;
end;

{-----------------------------------------------------------------------------}
class function TLMDCustomWebUpdate.LMDGetFileVersion(FileName: String;
  var VersionString: String): Boolean;
var
  CurrentVersionMajor1,
  CurrentVersionMajor2,
  CurrentVersionMinor1,
  CurrentVersionMinor2:Integer;
begin
  result:=LMDGetFileVersion(FileName, CurrentVersionMajor1, CurrentVersionMajor2,
                            CurrentVersionMinor1, CurrentVersionMinor2);
  if result then
    VersionString:=IntToStr(CurrentVersionMajor1)+'.'+IntToStr(CurrentVersionMajor2)+'.'+
                   IntToStr(CurrentVersionMinor1)+'.'+IntToStr(CurrentVersionMinor2)
  else
    VersionString:='0.0.0.0';
end;

{-----------------------------------------------------------------------------}
function TLMDCustomWebUpdate.CalcPercent: integer;
var
  i: integer;
  dPerc: double;
  DI: TLMDDownloadItem;
  dInfoInc: double;
  dFileInc: double;

  function GetDI(FileItem: TLMDWebUpdateFileItem; DI: TLMDDownloadItem):
    TLMDDownloadItem;
  var
    i, j: integer;
  begin
    Result:= nil;
    if DI = nil then
      j:= 0
    else
      j:= DI.Index + 1;
    for i:= j to FDownloads.Count - 1 do
      begin
        if FDownloads[i].Tag = FileItem.Index then
          begin
            Result:= FDownloads[i];
            break;
          end;
      end;
  end;
begin
  dPerc:= 0;
  for i:= 0 to FFiles.Count - 1 do
    begin
      DI:= GetDI(FFiles[i], nil);
      while DI <> nil do
        begin
          dInfoInc:= FInfoPercent / FFiles.Count * DI.Progress / 100;
          dFileInc:= (FMaxPercent - FInfoPercent) / FFiles.Count * DI.Progress /
            100;
          if DI.CheckOnly then
            dPerc:= dPerc + dInfoInc
          else
            dPerc:= dPerc + dFileInc;
          DI:= GetDI(FFiles[i], DI);
        end;
      if (FFiles[i].FUpdateState = wufsUpdateDontNeeded) then
        dPerc:= dPerc + (FMaxPercent - FInfoPercent) / FFiles.Count;
    end;
  Result:= Trunc(dPerc);
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomWebUpdate.CancelUpdate;
begin
  if FState = wusReady then
    ClearTmpLocalFiles;
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomWebUpdate.ClearTmpLocalFiles;
var
  i: integer;
begin
  for i:= 0 to FFiles.Count - 1 do
    if FFiles[i].FTmpFileName <> '' then
      begin
        DeleteFile(FFiles[i].FTmpFileName);
        FFiles[i].FTmpFileName:= '';
      end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomWebUpdate.SetIO(const Value: TLMDInternetOptions);
begin
  FDownloads.InternetOptions:= Value;
end;

{-----------------------------------------------------------------------------}
function TLMDCustomWebUpdate.GetIO: TLMDInternetOptions;
begin
  Result:= FDownloads.InternetOptions;
end;

{-----------------------------------------------------------------------------}
function TLMDCustomWebUpdate.GetOnInteractiveEvent: TLMDInternetOptionsInteractiveEvent;
begin
  Result := FDownloads.InternetOptions.OnInteractiveEvent;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomWebUpdate.SetOnInteractiveEvent(const Value: TLMDInternetOptionsInteractiveEvent);
begin
  FDownloads.InternetOptions.OnInteractiveEvent := Value;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDCustomWebUpdate.Create(AOwner: TComponent);
begin
  inherited;
  FAutoApply:= True;
  FServers:= TStringList.Create;
  FVersions:= TStringList.Create;
  FDownloads:= TLMDDownloads.Create;
  FDownloads.OnProgress:= OnDProgress;
  FDownloads.OnProcessed:= OnDProcessed;
  FState:= wusNone;
  FFiles:= TLMDWebUpdateFiles.Create(Self);
  FMaxPercent:= 100;
  FInfoPercent:= 10;
  FDefaultScheme:= 'HTTP://';
  FRebootNeeded:= False;
end;

{-----------------------------------------------------------------------------}
destructor TLMDCustomWebUpdate.Destroy;
begin
  if FDownloads <> nil then
    FDownloads.Free;
  FFiles.Free;
  FVersions.Free;
  FServers.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDCustomWebUpdate.FetchServers(const szURL: string;
  Blocked: boolean): boolean;
begin
  Result:= FState in [wusNone, wusError, wusReady];
  if not Result then
    exit;
  FServers.Clear;
  FdwError:= 0;
  FErrorString:= '';
  FState:= wusGetServersURL;
  FDownloads.Clear;
  //FDownloads.InternetOptions:= FInternetOptions;
  with FDownloads.Add do
    begin
      Tag:= 0;
      URL:= szURL;
      UserName:= FUserName;
      UserPassword:= FPassword;
    end;
  if Blocked then
    begin
      FDownloads.OnProgress:= nil;
      FDownloads.OnProcessed:= nil;
      Result:= FDownloads.Process;
      FDownloads.OnProgress:= OnDProgress;
      FDownloads.OnProcessed:= OnDProcessed;
      if Result then
        Result:= FetchServersProcessed(FDownloads.Items[0]);
      FState:= wusNone;
      GetError(FDownloads.Items[0]);
      FDownloads.Clear;
      FDownloads.ClearState;
    end
  else
    begin
      FDownloads.ThreadProcess;
    end;
end;

{-----------------------------------------------------------------------------}

function TLMDCustomWebUpdate.FetchServersProcessed(Sender: TLMDDownloadItem):
    boolean;
  function GetText: String;
  var
    P: integer;
  begin
    Result := '';

    if  Assigned(Sender) and Assigned(Sender.DataStream)  then
      begin
        P := Sender.DataStream.Position;
        Sender.DataStream.Position := 0;
        LMDWebStreamToString(Sender.DataStream, Result);
        Sender.DataStream.Position := P;
      end;
  end;

begin
  Result:= (Sender.State = DS_PROCESSED) and (Sender.DataSize <> 0);
  if Result then
    begin
      case Sender.Tag of
        0: FServers.Text:= GetText;
        1: FVersions.Text:= GetText;
      end;
    end;
end;

{-----------------------------------------------------------------------------}

function TLMDCustomWebUpdate.FetchVersions(const szURL: string): boolean;
begin
  Result:= FState in [wusNone, wusError, wusReady];
  if not Result then
    exit;
  FServers.Clear;
  FdwError:= 0;
  FErrorString:= '';
  FState:= wusGetVersions;
  FDownloads.Clear;
  //FDownloads.InternetOptions:= FInternetOptions;
  with FDownloads.Add do
    begin
      Tag:= 1;
      URL:= szURL;
      UserName:= FUserName;
      UserPassword:= FPassword;
    end;
  FDownloads.ThreadProcess;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.GetError(Sender: TLMDDownloadItem);
begin
  FdwError:= Sender.dwError;
  FErrorString:= Sender.ErrorString;
end;

{-----------------------------------------------------------------------------}

function TLMDCustomWebUpdate.GetServerFilePath(szServerURL: string; Index:
  integer): string;
var
  szTmp, szTmp1: string;
begin
  Result:= '';
  if (Index >= 0) and (Index < FFiles.Count) then
    begin
      szTmp:= szServerURL;
      if (Length(szTmp) > 0) and (AnsiChar(szTmp[Length(szTmp)]) in ['/', '\']) then
        SetLength(szTmp, Length(szTmp) - 1);
      szTmp1:= UpperCase(szTmp);
      if (pos('HTTP://', szTmp1) = 0) and (pos('FTP://', szTmp1) = 0) then
        szTmp:= FDefaultScheme + szTmp;

      szTmp1:= FFiles[Index].FServerPath;
      if (Length(szTmp1) = 0) or (not (AnsiChar(szTmp1[1]) in ['/', '\'])) then
        szTmp1:= '/' + szTmp1;
      szTmp:= szTmp + szTmp1;
      if (Length(szTmp) = 0) or (not (AnsiChar(szTmp[Length(szTmp)]) in ['/', '\'])) then
        szTmp:= szTmp + '/';
      if FFiles[Index].FServerFileName <> '' then
        szTmp:= szTmp + FFiles[Index].FServerFileName
      else
        szTmp:= szTmp + ExtractFileName(FFiles[Index].FFileName);
      Result:= szTmp;
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.OnDProcessed(Sender: TLMDDownloads);
var
  b: boolean;
begin
  case FState of
    wusGetVersions,
      wusGetServersURL:
      begin
        if Sender.Count > 0 then
          begin
            b:= FetchServersProcessed(Sender.Items[0]);
            GetError(Sender.Items[0]);
          end
        else
          b:= True;
        if b then
          begin
            if Assigned(FOnProcessed) then
              FOnProcessed(Self);
            FState:= wusNone;
          end
        else
          begin
            if Assigned(FOnError) then
              FOnError(Self);
            FState:= wusError;
          end;
        FDownloads.Clear;
        FDownloads.ClearState;
      end;
    wusUpdate:
      begin
        FState:= wusReady;
        if FAutoApply then
          ApplyUpdate;
        if Assigned(FOnProcessed) then
          FOnProcessed(Self);
        FDownloads.ClearState;
      end;
    wusError:
      begin
        if Assigned(FOnError) then
          FOnError(Self);
        FDownloads.Clear;
        FDownloads.ClearState;
      end;
  end;
  if FState in [wusNone, wusError] then SetDisconnect(InternetOptions);
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.OnDProgress(Sender: TLMDDownloadItem);
var
  FileItem: TLMDWebUpdateFileItem;
begin
  case FState of
    wusGetServersURL:
      begin
        if Assigned(FOnProgress) then
          FOnProgress(Self, 0, nil, Sender);
      end;
    wusUpdate, wusError:
      begin
        FileItem:= FFiles[Sender.Tag];
        if Sender.CheckOnly and (Sender.State = DS_PROCESSED) then
          begin
            if (FileItem.FileAction in [wufaExecute, wufaCopy]) or
              ((Sender.LastModified > 0) and (FileItem.FLocalFileDate <
              Sender.LastModified)) or
              ((Sender.LastModified = 0) and (Sender.DataSize > 0) and
                (Sender.DataSize <> FileItem.FLocalFileSize)) then
              with FDownloads.Add do
                begin
                  if (FileItem.UserName <> '') or (FileItem.Password <> '') then
                    begin
                      UserName:= FileItem.UserName;
                      UserPassword:= FileItem.Password;
                    end
                  else
                    begin
                      UserName:= FUserName;
                      UserPassword:= FPassword;
                    end;
                  URL:= Sender.URL;
                  Tag:= Sender.Tag;
                end
            else
              FileItem.FUpdateState:= wufsUpdateDontNeeded;
          end
        else
          if (Sender.State = DS_PROCESSED) then
            begin
              if SaveLocalFile(FileItem, Sender) then
                begin
                  FileItem.FUpdateState:= wufsUpdated;
                end;
            end
          else
            if (Sender.State = DS_ERROR) then
              begin
                FileItem.FUpdateState:= wufsUpdateError;
                FileItem.FError:= Sender.dwError;
                FileItem.FErrorString:= Sender.ErrorString;
                if FileItem.Required then
                  begin
                    FErrorString:= Sender.ErrorString;
                    FdwError:= Sender.dwError;
                    FDownloads.Terminate;
                    FState:= wusError;
                  end;
              end;
        if Assigned(FOnProgress) then
          begin
            FOnProgress(Self, CalcPercent(), FileItem, Sender);
          end;
      end;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDCustomWebUpdate.ProcessUpdate(const szURL: string): boolean;
var
  i: integer;
begin
  Result:= FState in [wusNone, wusError, wusReady];
  if Result then
    begin
      FState:= wusUpdate;
      FRebootNeeded:= False;
      ClearTmpLocalFiles;
      FDownloads.Clear;
      for i:= 0 to FFiles.Count - 1 do
        begin
          FFiles[i].FetchLocalFileProperties;
          if (FFiles[i].FileAction <> wufaUpdate) or (FFiles[i].UpdateState =
            wufsNone) then
            with FDownloads.Add do
              begin
                if (FFiles[i].UserName <> '') or (FFiles[i].Password <> '') then
                  begin
                    UserName:= FFiles[i].UserName;
                    UserPassword:= FFiles[i].Password;
                  end
                else
                  begin
                    UserName:= FUserName;
                    UserPassword:= FPassword;
                  end;
                URL:= GetServerFilePath(szURL, i);
                CheckOnly:= True;
                Tag:= i;
              end;
        end;
      Result:= FDownloads.Count > 0;
      if Result then
        begin
          if FDownloads.State in [DS_NONE, DS_ERROR] then
            FDownloads.ThreadProcess
        end
      else
        FState:= wusNone;
    end;
end;

{-----------------------------------------------------------------------------}

function TLMDCustomWebUpdate.SaveLocalFile(FileItem: TLMDWebUpdateFileItem; DItem: TLMDDownloadItem): boolean;
var
  szPath: string;
  szPref: string;
  buf: array[0..1023] of char;
  FS: TFileStream;
  MS: TMemoryStream;
  DS: TLMDDecompressionStream;
  lSize: longword;
  begin
  if FileItem.FTmpFileName <> '' then
    begin
      DeleteFile(FileItem.FTmpFileName);
      FileItem.FTmpFileName:= '';
    end;
  szPath:= ExtractFilePath(FileItem.GetFullFileName);
  LMDWebCreateDirs(szPath);
  szPref:= 'WU';
  Result:= GetTempFileName(PChar(szPath), PChar(szPref), 0, buf) <> 0;
  FileItem.FTmpFileName:= buf;
  if Result then
    begin
      FS:= TFileStream.Create(FileItem.FTmpFileName, fmCreate);
      try
        if DItem.DataSize > 0 then
          begin
            if DItem.BufferStartedWith(WU_COMP_SIGN)  then
              begin
                MS:= TMemoryStream.Create;
                DS:= TLMDDecompressionStream.Create(MS);
                try
                  MS.Write(PChar(DItem.StringData)[Length(WU_COMP_SIGN)],
                    DItem.DataSize - DWORD(Length(WU_COMP_SIGN)));
                  DS.Read(lSize, sizeof(lSize));
                  FS.CopyFrom(DS, lSize);
                except
                end;
                DS.Free;
                MS.Free;
              end
            else
            FS.CopyFrom(DItem.DataStream, 0);
          end;
      except
        FileItem.FTmpFileName:= '';
        Result:= False;
      end;
      FS.Free;
    end;
  DItem.ResetData;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetAutoApply(const Value: boolean);
begin
  FAutoApply:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetDefaultScheme(const Value: string);
begin
  FDefaultScheme:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetFiles(const Value: TLMDWebUpdateFiles);
begin
  FFiles.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetInfoPercent(const Value: integer);
begin
  FInfoPercent:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetMaxPercent(const Value: integer);
begin
  FMaxPercent:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetOnError(const Value: TNotifyEvent);
begin
  FOnError:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetOnProcessed(const Value: TNotifyEvent);
begin
  FOnProcessed:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetOnProgress(const Value: TLMDWebUpdateProgress);
begin
  FOnProgress:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetPassword(const Value: string);
begin
  FPassword:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetServers(const Value: TStringList);
begin
  FServers.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.SetUserName(const Value: string);
begin
  FUserName:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.StopProcess;
begin
  if not (FState in [wusNone, wusError, wusReady]) then
    begin
      FDownloads.Terminate;
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDCustomWebUpdate.WaitForStopProcess;
begin
  if not (FState in [wusNone, wusError, wusReady]) then
    begin
      FDownloads.WaitForEnd;
    end;
end;

{ **************************TLMDWebUpdateFileItem**************************** }

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.Assign(Source: TPersistent);
begin
  if Source is TLMDWebUpdateFileItem then
    begin
      with TLMDWebUpdateFileItem(Source) do
        begin
          Self.FFileName:= FFileName;
          Self.FServerPath:= FServerPath;
          Self.FServerFileName:= FServerFileName;
          Self.FTmpFileName:= FTmpFileName;
          Self.FUpdateState:= FUpdateState;
          Self.FFileAction:= FFileAction;
        end;
    end
  else
    inherited;
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebUpdateFileItem.Create(Collection: TCollection);
begin
  inherited;
  FUpdateState:= wufsNone;
  FTmpFileName:= '';
  FFileAction:= wufaUpdateCopy;
  FError:= 0;
  FErrorString:= '';
  FRequired:= True;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.FetchLocalFileProperties;
var
  szFileName: string;
  SR: TSearchRec;
begin
  szFileName := GetFullFileName;

  if  FindFirst(szFileName, faAnyFile, SR) = 0 then
    begin
      FLocalFileSize:= SR.Size;
      FLocalFileDate:= FileDateToDateTime(SR.Time);
      FindClose(SR);
      FUpdateState:= wufsNone;
    end
  else
    begin
      FUpdateState:= wufsLocalFileNotFound;
      FLocalFileSize:= 0;
      if FFileAction <> wufaUpdate then
        FLocalFileDate:= 1;
    end;
(*
  hFile:= FileOpen(szFileName, fmOpenRead or fmShareDenyNone);
  if hFile > 0 then
    begin
      FLocalFileSize:= FileSeek(hFile, 0, 2);
      FLocalFileDate:= FileDateToDateTime(FileGetDate(hFile));
      FileClose(hFile);
      FUpdateState:= wufsNone;
    end
  else
    begin
      FUpdateState:= wufsLocalFileNotFound;
      FLocalFileSize:= 0;
      if FFileAction <> wufaUpdate then
        FLocalFileDate:= 1;
    end;
*)
end;

{-----------------------------------------------------------------------------}

function TLMDWebUpdateFileItem.GetFullFileName: string;
begin
  Result := LMDWebGetFullFileName(FFileName)
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.SetData(const Value: TObject);
begin
  FData:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.SetFileAction(const Value: TLMDWUFileAction);
begin
  FFileAction:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.SetFileName(const Value: string);
begin
  FFileName:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.SetPassword(const Value: string);
begin
  FPassword:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.SetRequired(const Value: boolean);
begin
  FRequired:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.SetServerFileName(const Value: string);
begin
  FServerFileName:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.SetServerPath(const Value: string);
begin
  FServerPath:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.SetTag(const Value: integer);
begin
  FTag:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebUpdateFileItem.SetUserName(const Value: string);
begin
  FUserName:= Value;
end;

{ **************************TLMDWebUpdateFiles**************************** }

{-----------------------------------------------------------------------------}

function TLMDWebUpdateFiles.Add: TLMDWebUpdateFileItem;
begin
  Result:= TLMDWebUpdateFileItem(inherited Add);
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebUpdateFiles.Create;
begin
  inherited Create(Owner, TLMDWebUpdateFileItem);
end;

{-----------------------------------------------------------------------------}

function TLMDWebUpdateFiles.GetItem(Index: integer): TLMDWebUpdateFileItem;
begin
  Result:= TLMDWebUpdateFileItem(inherited Items[Index]);
end;

end.
