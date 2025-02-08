unit LMDWebHTTPGet;
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

LMDWebHTTPGet unit (DD)
-----------------------

Changes
-------
Release 2010R2 (October 2010)
[+] Added options to download css and script files

Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows,
  LMDStrings, LMDWebBase, LMDWebConfig, LMDDownload, LMDURLSupp,
  LMDWebDownloadFormUnit;

type
  { **************************TLMDDownloadParams**************************** }
  TLMDDownloadParams = class(TPersistent)
  private
    FCheckOnly: Boolean;
    FLoadImages: Boolean;
    FSizeLimit: cardinal;
    FOlder: TDateTime;
    FLoadScripts: Boolean;
    FLoadCssFiles: Boolean;
    procedure SetCheckOnly(const Value: Boolean);
    procedure SetLoadImages(const Value: Boolean);
    procedure SetOlder(const Value: TDateTime);
    procedure SetSizeLimit(const Value: cardinal);
    procedure SetLoadCssFiles(const Value: Boolean);
    procedure SetLoadScripts(const Value: Boolean);
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property CheckOnly: Boolean read FCheckOnly write SetCheckOnly default False;
    property LoadImages: Boolean read FLoadImages write SetLoadImages default False;
    property LoadScripts: Boolean read FLoadScripts write SetLoadScripts default False;
    property LoadCssFiles: Boolean read FLoadCssFiles write SetLoadCssFiles default False;
    property SizeLimit: cardinal read FSizeLimit write SetSizeLimit;
    property Older: TDateTime read FOlder write SetOlder;
  end;

  TLMDWebHTTPGet = class;

  TOnCustomizeForm = procedure (Sender :TLMDWebHTTPGet;LMDWebDownload: TLMDWebDownload) of object;
  TOnLMDWebProgress = procedure (Sender :TLMDWebHTTPGet;Item : TLMDDownloadItem) of object;
  TOnLMDWebGetFileName = procedure (Sender :TLMDWebHTTPGet;Item : TLMDDownloadItem;var FileName:String) of object;
  { **************************TLMDWebHTTPGet**************************** }
  TLMDWebHTTPGet = class(TLMDMasterWebComponent)
  private
    FDownloads: TLMDDownloads;
    FFileDownloader: TLMDDownloadItem;
    FWebConfig: TLMDWebConfig;
    FPassword: string;
    FReferer: string;
    FAcceptTypes: TStringList;
    FUserName: string;
    FURL: string;
    FData: TMemoryStream;
    FOnProgress: TOnLMDWebProgress;
    FOnProcessed: TNotifyEvent;
    FPostParams: TStringList;
    FDownloadParams: TLMDDownloadParams;
    FDownloadDir: string;
    FCaption: String;
    FOnCustomizeForm: TOnCustomizeForm;
    FOnGetFileName: TOnLMDWebGetFileName;
    FDestinationName: string;
    FRangeStart: Int64;
    FRangeEnd: Int64;
    FResume: Boolean;
    procedure SetWebConfig(const Value: TLMDWebConfig);
    procedure SetAcceptTypes(const Value: TStringList);
    procedure SetPassword(const Value: string);
    procedure SetReferer(const Value: string);
    procedure SetURL(const Value: string);
    procedure SetUserName(const Value: string);
    procedure DownloadProgress(Sender: TLMDDownloadItem);
    procedure DownloadProcessed(Sender: TLMDDownloads);
    function GetProgress: integer;
    function GetState: TLMDDownloadState;
    function GetFileDownloader: TLMDDownloadItem;
    function GetError: integer;
    function GetErrorString: string;
    function GetProgressString: string;
    function GetIO: TLMDInternetOptions;
    procedure SetIO(const Value: TLMDInternetOptions);
    procedure SetOnProcessed(const Value: TNotifyEvent);
    procedure SetOnProgress(const Value: TOnLMDWebProgress);
    function GetDataAsString: string;
    procedure SetPostParams(const Value: TStringList);
    procedure SetDownloadParams(const Value: TLMDDownloadParams);
    procedure SetDownloadDir(const Value: string);
    procedure SetCaption(const Value: String);
    procedure SetOnCustomizeForm(const Value: TOnCustomizeForm);
    procedure SetOnGetFileName(const Value: TOnLMDWebGetFileName);
    procedure SetDestinationName(const Value: string);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateFromConfig; override;
    // Process request
    function Process(bFillOnly: Boolean = False; bAsync: Boolean = False):
      Boolean;
    // Process request with dialog
    function InteractiveProcess: Boolean;
    // Stop process
    procedure Stop;
    property Downloader: TLMDDownloads read FDownloads;
    // Download item from downloader
    property FileDownloader: TLMDDownloadItem read GetFileDownloader;
    property State: TLMDDownloadState read GetState;
    // Downloaded data
    property Data: TMemoryStream read FData;
    // Downloaded data as string
    property DataAsString: string read GetDataAsString;
    property Progress: integer read GetProgress default 0;
    property ProgressString: string read GetProgressString;
    property Error: integer read GetError default 0;
    property ErrorString: string read GetErrorString;
  published
    property AcceptTypes: TStringList read FAcceptTypes write SetAcceptTypes stored true;
    property URL: string read FURL write SetURL;
    property Caption:String read FCaption write SetCaption;
    property UserName: string read FUserName write SetUserName;
    property Password: string read FPassword write SetPassword;
    property Referer: string read FReferer write SetReferer;
    property PostParams: TStringList read FPostParams write SetPostParams;
    property DownloadDir: string read FDownloadDir write SetDownloadDir;
    property DestinationName:string read FDestinationName write SetDestinationName;
    property DownloadParams: TLMDDownloadParams read FDownloadParams write
      SetDownloadParams;
    property OnProgress: TOnLMDWebProgress read FOnProgress write SetOnProgress;
    property OnProcessed: TNotifyEvent read FOnProcessed write SetOnProcessed;
    // Get file name for item
    property OnGetFileName:TOnLMDWebGetFileName read FOnGetFileName write SetOnGetFileName;
    property OnCustomizeForm:TOnCustomizeForm read FOnCustomizeForm write SetOnCustomizeForm;

    property InternetOptions: TLMDInternetOptions read GetIO write SetIO;
    property WebConfig: TLMDWebConfig read FWebConfig write SetWebConfig;

    property RangeStart: Int64 read FRangeStart write FRangeStart;
    property RangeEnd: Int64 read FRangeEnd write FRangeEnd;
    property Resume: Boolean read FResume write FResume;
    end;

implementation

uses
  SysUtils, Controls, Variants, WinInet,
  LMDFSSupport, LMDHTTPSupp, LMDHTMLObjectUnit;

{ **************************TLMDWebHTTPGet**************************** }

{-----------------------------------------------------------------------------}

constructor TLMDWebHTTPGet.Create(AOwner: TComponent);
begin
  inherited;
  FAcceptTypes:= TStringList.Create;
  FData:= TMemoryStream.Create;
  FPostParams:= TStringList.Create;
  FDownloadParams:= TLMDDownloadParams.Create;
  FDownloads:= TLMDDownloads.Create;
  FDownloads.OnProgress:= DownloadProgress;
  FDownloads.OnProcessed:= DownloadProcessed;
  FRangeStart := 0;
  FRangeEnd := 0;
  FResume := False;
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebHTTPGet.Destroy;
begin
  FPostParams.Free;
  FDownloads.Free;
  FData.Free;
  FAcceptTypes.Free;
  FDownloadParams.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.DownloadProcessed(Sender: TLMDDownloads);
var
  i: integer;
  szFile: string;
  szHTML: string;
//  DD: string;
  LRS: Int64;
begin
  if (not DownloadParams.CheckOnly) and (DownloadDir <> '') then
  begin
//    DD := ExpandFileName(DownloadDir);

    for i:= 0 to FDownloads.Count - 1 do
      begin
        if FDownloads[i].UserObject <> nil then
          begin
            szFile:= ExpandFileName(FDownloads[i].LocalURL);
            szHTML:= TLMDHTMLObject(FDownloads[i].UserObject).HTML;
            try

              LRS := RangeStart;
              if Resume then
              begin
                LRS := LMDWebGetFileSize(szFile);
                if LRS > 0 then
                  Dec(LRS);
              end;
              LMDWebWriteFileFromString(szFile, szHTML, -1, FDownloads[i].LastModified, LRS);
            except
              ;
            end;
          end;
      end;
  end;

  if Assigned(FOnProcessed) then
    FOnProcessed(Self);
  SetDisconnect(InternetOptions);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.DownloadProgress(Sender: TLMDDownloadItem);
var
  j, k: integer;
  DI: TLMDDownloadItem;
  bFlag: Boolean;

  szFile: string;
//  FS: TFileStream;
  iIndex: integer;
  HTMLObject: TLMDHTMLObject;
  szHTML: string;
  DD: string;
  URL: array[1..1024] of char;
  HostName: array[1..100] of char;
  urlcomp: TURLComponents;
  LRS: Int64;

  function CheckFileName(const szFile: string): string;
  var
    i: integer;
  begin
    Result:= szFile;
//    szFile:= UpperCase(Result);
    for i:= 1 to Length(Result) do
      begin
        if not (AnsiChar(Result[i]) in ['A'..'Z', 'a'..'z', '.', '0'..'9']) then
          Result[i]:= '_';
      end;
  end;

begin
  if (Sender.Tag >= 0) then
    begin
      if (Sender.State = DS_PROCESSING) then
        if (Sender.HeaderLoaded) then
          begin
            if (DownloadParams.CheckOnly) then
              Sender.CheckOnly:= true
            else
              Sender.CheckOnly:= False;
            begin
              if DownloadParams.SizeLimit > 0 then
                begin
                  if Sender.DataSize > DownloadParams.SizeLimit then
                    begin
                      Sender.Terminated:= true;
                      Sender.SetError(8, 'Size limit');
                    end;
                end;
              if DownloadParams.Older > 0 then
                begin
                  if (Sender.LastModified <> 0) and ((Now - Sender.LastModified)
                    > DownloadParams.Older) then
                    begin
                      Sender.Terminated:= true;
                      Sender.SetError(9, 'URL is olded');
                    end;
                end;
            end;
          end
        else
          if DownloadParams.SizeLimit > 0 then
            begin
              if Sender.DataSize > DownloadParams.SizeLimit then
                begin
                  Sender.Terminated:= true;
                  Sender.SetError(8, 'Size limit');
                end;
            end;
    end;
  if (Sender.State = DS_PROCESSED) and (not FDownloadParams.CheckOnly) then
    begin
      begin
        if (FDownloadParams.CheckOnly) then
          begin
            Sender.ResetData;
          end
        else
          if (FDownloadDir <> '') and (not FDownloadParams.CheckOnly) and
            (Sender.dwError = 0) and (Sender.DataSize <> 0) then
            begin
              DD := LMDAnsiSlashAdd(ExpandFileName(DownloadDir));
              szFile:= Sender.LocalURL;
              if szFile <> '' then
                DeleteFile(szFile);

              szHTML:= '';
              try
                Sender.DataStream.Position := 0;
                LMDWebStreamToString(Sender.DataStream, szHTML);
                iIndex:= Length(Sender.URL);
                for j:= Length(Sender.URL) downto 1 do
                  if Sender.URL[j] = '/' then
                    begin
                      iIndex:= j + 1;
                      break;
                    end;
                szFile:= Copy(Sender.URL, iIndex, Length(Sender.URL));
                try
                  if szFile <> '' then
                    szFile:= '_' + szFile;
                  LMDWebClearData(urlcomp, sizeof(urlcomp), 0);
                  urlcomp.dwStructSize:= sizeof(urlcomp);
                  urlcomp.dwHostNameLength:= sizeof(HostName);
                  urlcomp.dwUrlPathLength:= sizeof(URL);
                  urlcomp.lpszHostName:= @HostName[1];
                  urlcomp.lpszUrlPath:= @URL[1];
                  InternetCrackUrl(PChar(Sender.URL), Length(Sender.URL), 0,
                    urlcomp);
                  szFile:= StrPas(PChar(@HostName[1])) + szFile;
                  szFile:= CheckFileName(szFile);

                  if (Sender=FileDownloader) and (FDestinationName<>'') then
                    szFile := FDestinationName;

                  if Assigned(OnGetFileName) then
                    FOnGetFileName(Self,Sender,szFile);

                  if pos(CFSTR_MIME_HTML, Sender.ActualType) > 0 then
                    begin
                      if pos('.htm', ExtractFileExt(szFile)) = 0 then
                        szFile:= szFile + '.htm';

                      HTMLObject:= TLMDHTMLObject.Create;
                      HTMLObject.HTML:= szHTML;
                      HTMLObject.BaseURL:= Sender.URL;
                      HTMLObject.LocalURL:= DD + szFile;
                      szHTML:= HTMLObject.HTML;
                      Sender.UserObject:= HTMLObject;
                      bFlag:= False;
                      for k:= 0 to HTMLObject.Links.Count - 1 do
                        if  HTMLObject.Links[k].WebURL <> ''  then
                        begin
                          case HTMLObject.Links[k].LinkType of
                            LT_IMAGE, LT_FRAME, LT_CLASS, LT_BODY:
                              begin
                                if HTMLObject.Links.IndexOfWeb[HTMLObject.Links[k].WebURL] <> k then
                                  continue;
                                if (not DownloadParams.LoadImages) and (HTMLObject.Links[k].LinkType = LT_IMAGE) then
                                  continue;
                                if (not DownloadParams.LoadCssFiles) and (HTMLObject.Links[k].LinkType = LT_LINK) then
                                  continue;
                                if (not DownloadParams.LoadScripts) and (HTMLObject.Links[k].LinkType = LT_SCRIPT) then
                                  continue;
                                bFlag:= true;
                                DI:= FDownloads.Add;
                                DI.URL:= HTMLObject.Links[k].WebURL;
                                DI.UserData:= HTMLObject.Links[k];
                                DI.Ready:= true;
                                DI.Tag:= -1;
                              end;
                          end;
                        end;
                      if bFlag then
                        begin
                          FDownloads.ContinueProcess;
                        end;
                    end
                  else
                    if Sender.UserData is TLMDHTMLLink then
                      begin
                        TLMDHTMLLink(Sender.UserData).LocalFile:= DD +
                          szFile;
                        TLMDHTMLLink(Sender.UserData).Local:= true;
                      end;
                  Sender.LocalURL:= DD + szFile;
                  LMDWebCreateDirs(DD);

                  try
                    LRS := RangeStart;
                    if Resume then
                    begin
                      LRS := LMDWebGetFileSize(DD + szFile);
                      if LRS > 0 then
                        Dec(LRS);
                    end;

                    LMDWebWriteFileFromString(DD + szFile, szHTML, -1, Sender.LastModified, LRS);
                  except
                  end;
                except
                end;
              except
              end;
            end;
      end;
    end;

  if FFileDownloader = Sender then
    begin
      if (Sender.State = DS_PROCESSED) then
        begin
          if  Assigned(Sender.DataStream) then
            FData.LoadFromStream(Sender.DataStream)
          else
            FData.Clear;
//          FData.Size:= Sender.DataSize;
//          Move(Sender.Data^, FData.Memory^, FData.Size);
          Sender.ResetData;
        end;
    end;
  if Assigned(FOnProgress) then
    FOnProgress(Self,Sender);
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPGet.GetDataAsString: string;
begin
  FData.Position := 0;
  LMDWebStreamToString(FData, Result);

  if  Result <> ''  then
    Result := Result + #0;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPGet.GetError: integer;
begin
  if GetFileDownloader <> nil then
    Result:= GetFileDownloader.dwError
  else
    Result:= 0;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPGet.GetErrorString: string;
begin
  if GetFileDownloader <> nil then
    Result:= GetFileDownloader.ErrorString
  else
    Result:= '';
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPGet.GetFileDownloader: TLMDDownloadItem;
begin
  Result:= FFileDownloader;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPGet.GetIO: TLMDInternetOptions;
begin
  Result:= FDownloads.InternetOptions;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPGet.GetProgress: integer;
var
  i: integer;
  iAll: integer;
begin
  if FDownloads.Count > 0 then
    begin
      iAll:= 0;
      for i:= 0 to FDownloads.Count - 1 do
        begin
          iAll:= iAll + FDownloads.Items[i].Progress;
        end;
      Result:= trunc(iAll / FDownloads.Count);
    end
  else
    Result:= 0;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPGet.GetProgressString: string;
begin
  if GetFileDownloader <> nil then
    Result:= GetFileDownloader.ProgressString
  else
    Result:= '';
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPGet.GetState: TLMDDownloadState;
begin
  Result:= FDownloads.State;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPGet.InteractiveProcess: Boolean;
var
  LMDWebDownload: TLMDWebDownload;
begin
  Downloader.ClearState;
  LMDWebDownload:= TLMDWebDownload.Create(Self);
  LMDWebDownload.DL:= Downloader;
  if(FCaption<>'') then
    LMDWebDownload.Caption := FCaption;
  if Assigned(FOnCustomizeForm) then
    FOnCustomizeForm(Self,LMDWebDownload);
  try
    LMDWebDownload.SetHandlers;
    Process(true);
    Result:= LMDWebDownload.ShowModal = mrOk;
  finally
    LMDWebDownload.Free;
  end;
end;

procedure TLMDWebHTTPGet.Loaded;
begin
  inherited;
  UpdateFromConfig;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent <> nil) and (AComponent = FWebConfig)
    then
    FWebConfig:= nil;
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPGet.Process(bFillOnly: Boolean; bAsync: Boolean): Boolean;
var
  i, j: integer;
  szTmp: string;
  S: string;
begin
  if State in [DS_NONE, DS_ERROR, DS_PROCESSED] then
    begin
      UpdateFromConfig;
      FData.Clear;
      FDownloads.Clear;
      FFileDownloader:= FDownloads.Add;
      FFileDownloader.RangeStart := RangeStart;
      FFileDownloader.RangeEnd := RangeEnd;
      if Resume then
      begin
        if FileExists(DownloadDir + '\' + DestinationName) then
        begin
          FFileDownloader.RangeStart := LMDWebGetFileSize(DownloadDir + '\' + DestinationName);
          if FFileDownloader.RangeStart > 0 then
            FFileDownloader.RangeStart := FFileDownloader.RangeStart - 1;
          FFileDownloader.RangeEnd := 0;
        end;
      end;
      with FFileDownloader do
        begin
          URL:= Self.URL;
          ResultType:= FAcceptTypes.Text;
          UserName:= Self.UserName;
          UserPassword:= Self.Password;
          if Self.FPostParams.Count > 0 then
            begin
              Verb:= IV_POST;
              szTmp:= '';
              for i:= 0 to Self.FPostParams.Count - 1 do
                begin
                  if szTmp <> '' then
                    szTmp:= szTmp + '&';
                  S:= FPostParams[i];
                  j:= pos('=', S);
                  if j > 0 then
                    S:= Copy(S, 1, j) + HTTPEncode(Copy(S, j + 1, MAXINT),
                      '%20')
                  else
                    S:= S + '=';
                  szTmp:= szTmp + S;
                end;
              PostData:= szTmp;
            end;
          Referer:= Self.Referer;
        end;
    end;
  if not bFillOnly then
    begin
      if bAsync then
        begin
          FDownloads.ThreadProcess;
          Result:= true;
        end
      else
        begin
          FDownloads.OnProgress:= nil;
          FDownloads.OnProcessed:= nil;
          Result:= FDownloads.Process;
          FDownloads.OnProgress:= DownloadProgress;
          FDownloads.OnProcessed:= DownloadProcessed;
          DownloadProgress(FFileDownloader);
          DownloadProcessed(FDownloads);
        end;
    end
  else
    Result:= true;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.SetAcceptTypes(const Value: TStringList);
begin
  FAcceptTypes.Assign(Value);
  if FWebConfig <> nil then
    FWebConfig.AcceptTypes:= FAcceptTypes;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.SetCaption(const Value: String);
begin
  FCaption := Value;
end;

procedure TLMDWebHTTPGet.SetDestinationName(const Value: string);
begin
  FDestinationName := Value;
end;

procedure TLMDWebHTTPGet.SetDownloadDir(const Value: string);
begin
  FDownloadDir:= Value;
end;

procedure TLMDWebHTTPGet.SetDownloadParams(const Value: TLMDDownloadParams);
begin
  FDownloadParams.Assign(Value);
end;

procedure TLMDWebHTTPGet.SetIO(const Value: TLMDInternetOptions);
begin
  FDownloads.InternetOptions:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.SetOnCustomizeForm(const Value: TOnCustomizeForm);
begin
  FOnCustomizeForm := Value;
end;

procedure TLMDWebHTTPGet.SetOnGetFileName(
  const Value: TOnLMDWebGetFileName);
begin
  FOnGetFileName := Value;
end;

procedure TLMDWebHTTPGet.SetOnProcessed(const Value: TNotifyEvent);
begin
  FOnProcessed:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.SetOnProgress(const Value: TOnLMDWebProgress);
begin
  FOnProgress:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.SetPassword(const Value: string);
begin
  FPassword:= Value;
  if FWebConfig <> nil then
    FWebConfig.Password:= FPassword;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.SetPostParams(const Value: TStringList);
begin
  FPostParams.Assign(Value);
  if FWebConfig <> nil then
    FWebConfig.PostParams:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.SetReferer(const Value: string);
begin
  FReferer:= Value;
  if FWebConfig <> nil then
    FWebConfig.Referer:= FReferer;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.SetURL(const Value: string);
begin
  FURL:= Value;
  if FWebConfig <> nil then
    FWebConfig.URL:= FURL;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.SetUserName(const Value: string);
begin
  FUserName:= Value;
  if FWebConfig <> nil then
    FWebConfig.UserName:= FUserName;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.SetWebConfig(const Value: TLMDWebConfig);
begin
  if FWebConfig <> Value then
    begin
      if FWebConfig <> nil then
        begin
          FWebConfig.MasterComponent:= nil;
          FWebConfig.RemoveFreeNotification(Self);
        end;
      FWebConfig:= Value;
      if FWebConfig <> nil then
        begin
          FWebConfig.FreeNotification(Self);
          FWebConfig.MasterComponent:= Self;
        end;
      UpdateFromConfig;
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.Stop;
begin
  FDownloads.Terminate;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPGet.UpdateFromConfig;
begin
  if FWebConfig <> nil then
    begin
      FAcceptTypes.Assign(FWebConfig.AcceptTypes);
      FPassword:= FWebConfig.Password;
      PostParams.Assign(FWebConfig.PostParams);
      FReferer:= FWebConfig.Referer;
      FURL:= FWebConfig.URL;
      FUserName:= FWebConfig.UserName;
      InternetOptions:= FWebConfig.InternetOptions;
    end;
end;

{ **************************TLMDDownloadParams**************************** }
{-----------------------------------------------------------------------------}

procedure TLMDDownloadParams.Assign(Source: TPersistent);
begin
  if Source is TLMDDownloadParams then
    begin
      with TLMDDownloadParams(Source) do
        begin
          Self.FCheckOnly:= FCheckOnly;
          Self.FLoadImages:= FLoadImages;
          Self.FSizeLimit:= FSizeLimit;
          Self.FOlder:= FOlder;
        end;
    end
  else
    inherited;
end;

{-----------------------------------------------------------------------------}

constructor TLMDDownloadParams.Create;
begin
  inherited;
  FCheckOnly:= False;
  FLoadImages:= False;
  FLoadScripts := False;
  FLoadCssFiles := False;
  FSizeLimit:= 0;
  FOlder:= 0;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadParams.SetCheckOnly(const Value: Boolean);
begin
  FCheckOnly:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadParams.SetLoadCssFiles(const Value: Boolean);
begin
  FLoadCssFiles := Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadParams.SetLoadImages(const Value: Boolean);
begin
  FLoadImages:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadParams.SetLoadScripts(const Value: Boolean);
begin
  FLoadScripts := Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadParams.SetOlder(const Value: TDateTime);
begin
  FOlder:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadParams.SetSizeLimit(const Value: cardinal);
begin
  FSizeLimit:= Value;
end;

end.
