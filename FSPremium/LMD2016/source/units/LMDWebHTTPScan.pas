unit LMDWebHTTPScan;
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

LMDWebHTTPScan unit (DD)
-----------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDWebConfig, LMDWebTree, LMDDownload, LMDWebBase, LMDURLSupp;

type
  TLMDWebHTTPScanProgress = procedure(Sender: TLMDWebTreeItem) of object;
  TLMDWebHTTPScanAddItem = procedure(Sender: TLMDWebTreeItem) of object;
  TLMDWebHTTPScanProcessed = procedure(Sender: TLMDWebTaskItem) of object;
  TLMDWebHTTPScanSaveFile = procedure(Sender: TLMDWebTaskItem;
   var FileName: String; var CanSave: Boolean) of object;

  { **************************TLMDWebHTTPScan**************************** }
  TLMDWebHTTPScan = class(TLMDMasterWebComponent)
  private
    FTreeParams: TLMDWebTreeParams;
    FTaskCollection: TLMDWebTasks;
    FTask: TLMDWebTaskItem;
    Downloads: TLMDDownloads;
    FOnProcessed: TLMDWebHTTPScanProcessed;
    FOnProgress: TLMDWebHTTPScanProgress;
    FOnAddItem: TLMDWebHTTPScanAddItem;
    FOnSaveFile: TLMDWebHTTPScanSaveFile;
    FUpdate: boolean;
    FStrongUpdate: boolean;
    FWebConfig: TLMDWebConfig;
    FOnStartProcess: TNotifyEvent;
    procedure DownloadItem(TreeItem: TLMDWebTreeItem; bDontUpdate: boolean =
      False);
    procedure DownloadItems(Tree: TLMDWebTree);
    procedure DownloadProcessed(dloads: TLMDDownloads);
    procedure DownloadProgress(dlitem: TLMDDownLoadItem);
    function CreateFileName(const URL: string): string;
    function GetState: TLMDDownloadstate;
    procedure SetOnProcessed(const Value: TLMDWebHTTPScanProcessed);
    procedure SetOnProgress(const Value: TLMDWebHTTPScanProgress);
    procedure SetOnAddItem(const Value: TLMDWebHTTPScanAddItem);
    procedure SetOnSaveFile(const Value: TLMDWebHTTPScanSaveFile);
    procedure SetStrongUpdate(const Value: boolean);
    procedure SetWebConfig(const Value: TLMDWebConfig);
    procedure SetTask(const Value: TLMDWebTaskItem);
    function GetIO: TLMDInternetOptions;
    procedure SetIO(const Value: TLMDInternetOptions);
    procedure SetOnStartProcess(const Value: TNotifyEvent);
  protected
    procedure Loaded; override;
  public
    procedure Download;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Terminate;
    procedure UpdateFromConfig; override;
    procedure Clear;
    property Update: boolean read FUpdate write FUpdate default true;
    property DownloadObject: TLMDDownloads read Downloads;
    property TreeParams: TLMDWebTreeParams read FTreeParams;
    published
    property InternetOptions: TLMDInternetOptions read GetIO write SetIO;
    property Task: TLMDWebTaskItem read FTask write SetTask;
    property WebConfig: TLMDWebConfig read FWebConfig write SetWebConfig;
    property StrongUpdate: boolean read FStrongUpdate write SetStrongUpdate default true;
    property State: TLMDDownloadstate read GetState;

    property OnStartProcess:TNotifyEvent read FOnStartProcess write SetOnStartProcess;
    property OnAddItem: TLMDWebHTTPScanAddItem read FOnAddItem write
      SetOnAddItem;
    property OnProgress: TLMDWebHTTPScanProgress read FOnProgress write
      SetOnProgress;
    property OnProcessed: TLMDWebHTTPScanProcessed read FOnProcessed write
      SetOnProcessed;
    property OnSaveFile: TLMDWebHTTPScanSaveFile read FOnSaveFile write
      SetOnSaveFile;
  end;

implementation

uses
  SysUtils, Forms, Windows, 
  LMDHTMLObjectUnit, LMDFSSupport;

{ **************************TLMDWebHTTPScan**************************** }

{-----------------------------------------------------------------------------}

constructor TLMDWebHTTPScan.Create(AOwner: TComponent);
begin
  inherited;
  FTreeParams:= TLMDWebTreeParams.Create;
  FTaskCollection:= TLMDWebTasks.Create(FTreeParams, nil);
  FTask:= FTaskCollection.Add;
  FTask.DestinationDir:= ExtractFilePath(Application.exeName);
  FOnProcessed:= nil;
  FOnProgress:= nil;
  FOnAddItem:= nil;
  FUpdate:= True;
  FStrongUpdate:= True;
  Downloads:= TLMDDownloads.Create;
  Downloads.OnProcessed:= DownloadProcessed;
  Downloads.OnProgress:= DownloadProgress;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPScan.CreateFileName(const URL: string): string;
begin
  Result:= LMDFSSupport.LMDWebCreateFileName(FTask.DestinationDir,
    FTask.DefaultFileName, URL, FTask.SaveFiles);
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebHTTPScan.Destroy;
begin
  FTaskCollection.Free;
  FTreeParams.Free;
  Downloads.Free;
  inherited Destroy;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.Download;
begin
  if Assigned(FOnStartProcess) then
    FOnStartProcess(Self);
  if not CheckInet(InternetOptions) and not  CheckLocal(FTask.BaseURL)  then
    begin
      if Assigned(FOnProcessed) then
        FOnProcessed(FTask);
      exit;
    end;
  if FTask.AutoReset then FTask.Tree.Clear;
  if FTask.Tree.Count = 0 then
    begin
      with FTask.Tree.Add do
        begin
          URL:= FTask.BaseURL;
          FileType:= ftHTML;
        end;
    end;

  FUpdate:= FTask.Update;
  FStrongUpdate:= FTask.StrongUpdate;
  FTask.ActivateProject;
  Downloads.Clear;
  DownloadItems(FTask.Tree);
  FTask.StartTime:= Now;
  FTask.UpdateTime:= Now;
  Downloads.ThreadProcess;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.DownloadItem(TreeItem: TLMDWebTreeItem; bDontUpdate:
  boolean = False);
var
  Host: string;
begin
  if (TreeItem.DownloadState = DS_PROCESSED) and (not
    FileExists(TreeItem.Filename)) then
    begin
      if TreeItem.FileType = ftHTML then
        begin
          TreeItem.UpdateLinks;
        end
      else
        TreeItem.DownloadState:= DS_NONE;
    end;
  if (TreeItem.DownloadState = DS_PROCESSED) and (((TreeItem.Date = 0) and
    (FStrongUpdate)) or (not FUpdate) or bDontUpdate) then
    begin
      DownloadItems(TreeItem.SubTree);
    end
  else
    begin
      if ((TreeItem.FileType <> ftImage) or (FTask.ExcludedTypes.IndexOf('image')
        = -1)) and
        (FTask.ExcludedExt.IndexOf(UpperCase(ExtractFileExt(ExtractURLFileName(TreeItem.URL)))) = -1) and ((FTask.MaxDownloadKB = 0) or ((FTask.MaxDownloadKB * 1024) >
        FTask.TotalB)) then
        begin
          Host:= UpperCase(GetHost(TreeItem.URL));
          if FTask.LoadOtherSites or (Host = FTask.Host) then
            begin
              if Assigned(FOnAddItem) then
                FOnAddItem(TreeItem);
              TreeItem.DownloadItem:= Downloads.Add;
              TreeItem.DownloadItem.Tag:= GetTickCount;
              with TreeItem.DownloadItem do
                begin
                  FreeOnProcessed:= True;
                  NoRedirect:= True;
                  if FUpdate and (TreeItem.DownloadState = DS_PROCESSED) then
                    CheckOnly:= True;
                  ExcludedTypes:= FTask.ExcludedTypes;
                  ResultType:= FTask.AcceptTypes.Text;
                  UserName:= FTask.UserName;
                  UserPassword:= FTask.Password;
                  URL:= TreeItem.URL;
                  UserData:= TreeItem;
                  Ready:= True;
                end;
            end;
        end;
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.DownloadItems(Tree: TLMDWebTree);
var
  i: integer;
begin
  for i:= 0 to Tree.Count - 1 do
    begin
      if (Tree[i].IsTreeLink) and (Tree[i].ParentLinkedItem <> nil) and
        (Tree[i].ParentLinkedItem.DownloadState <> DS_NONE) then
        continue;
      if not Tree.Task.LoadOtherSites and (Pos(Tree.Task.BaseURL, Tree[i].URL) <> 1) then continue; // V.O. 07.05.2003
      if Tree.Params.CheckLink(LMDWebGetWebFileURL(Tree[i].URL, True), Tree[i], True)
        then
        begin
          if (Tree[i].Level > FTask.Depth) and (Tree[i].FileType = ftHTML) then
            continue;
          if (Tree[i].DownloadState = DS_NONE) or (Tree[i].DownloadState =
            DS_ERROR) then
            Tree[i].DownloadState:= DS_PREPARED; //3006
          DownloadItem(Tree[i]);
        end;
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.DownloadProcessed(dloads: TLMDDownloads);
var
  TItem: TLMDWebTreeItem;
  i: integer;
begin
  FTask.WorkTime:= FTask.WorkTime + Now - FTask.StartTime;
  FTask.StartTime:= 0;
  for i:= 0 to dloads.Count - 1 do
    begin
      TItem:= TLMDWebTreeItem(dloads[i].UserData);
      if TItem <> nil then
        begin
          TItem.DownloadState:= dloads[i].State;
          if (TItem.DownloadState = DS_ERROR) and (dloads[i].dwError = 6) then
            TItem.DownloadState:= DS_NONE;
        end;
    end;
  FTask.Tree.UpdateLinks;
  if Assigned(FOnProcessed) then
    FOnProcessed(FTask);
  SetDisconnect(InternetOptions);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.DownloadProgress(dlItem: TLMDDownLoadItem);
var
  TItem, NewItem: TLMDWebTreeItem;
  i: integer;
  iTicks: integer;
  szHTML: string;
  szTmp, szFileName: string;
  AllowSave: Boolean;
  Acc: Boolean;
begin
  try
    TItem:= TLMDWebTreeItem(dlitem.UserData);
    TItem.DownloadState:= dlitem.State;
    iTicks:= (GetTickCount - DWORD(dlitem.Tag));
    if iTicks = 0 then
      TItem.CPS:= Trunc(dlitem.DataSize)
    else
      TItem.CPS:= Trunc(dlitem.DataSize * 1000 / iTicks);
    TItem.DataSize:= dlitem.DataSize;
    TItem.dwError:= dlitem.dwError;
    TItem.ErrorString:= dlitem.ErrorString;

    Acc := True;
    if dlitem.ActualURL <> '' then
    begin
      if (Pos(TItem.Parent.Task.BaseURL, dlitem.ActualURL) <> 1) and
      not TItem.Parent.Task.LoadOtherSites then Acc := False;
    end; // V.O. 07.05.2003

    if (((dlitem.State = DS_PROCESSED) and (dlitem.iStatusCode = 302)) or
      ((dlitem.State in [DS_ERROR,DS_PROCESSED]) and (dlitem.iStatusCode = 301))) and Acc then
      begin
        TItem.DownloadItem:= Downloads.Add;
        TItem.DownloadItem.Tag:= GetTickCount;
        TItem.URL:= dlitem.ActualURL;
        with TItem.DownloadItem do
          begin
            Assign(dlitem);
            URL:= dlitem.ActualURL;
            Ready:= True;
          end;
        Downloads.ContinueProcess;
        exit;
      end;

    if dlitem.State = DS_PROCESSED then
      begin
        TItem.UpdateFileType;
        if dlitem.CheckOnly then
          begin
            try
              if (dlitem.LastModified > TItem.Date) then
                begin
                  TItem.DownloadItem:= Downloads.Add;
                  with TItem.DownloadItem do
                    begin
                      Assign(dlitem);
                      FreeOnProcessed:= True;
                      CheckOnly:= False;
                    end;
                end
              else
                begin
                  DownloadItem(TItem, True);
                  Downloads.ContinueProcess;
                end;
            except
            end;
          end
        else
          begin
            try
              TItem.Date:= dlitem.LastModified;
              TItem.Filename:= CreateFileName(dlitem.URL);
              if TItem.StrFileType = CFSTR_MIME_HTML then
                begin
                  szTmp:= UpperCase(ExtractFileExt(TItem.Filename));
                  if pos('HTM', szTmp) = 0 then
                    TItem.Filename:= TItem.Filename + '.' + TItem.Parent.Task.DefaultExtension;
                end;
              TItem.Object_.LocalURL:= TItem.Filename;
              if TItem.FileType = ftHTML then
                begin
                  szHTML:= '';
                  if dlitem.DataSize > 0 then
                    begin
                      dlitem.DataStream.Position := 0;
                      LMDWebStreamToString(dlitem.DataStream, szHTML);
//                      SetLength(szHTML, dlitem.DataSize + 1);
//                      Move(dlitem.Data^, szHTML[1], dlitem.DataSize);
//                      szHTML[dlitem.DataSize + 1]:= #0;
                      try
                        TItem.Object_.HTML:= szHTML;
                        TItem.Object_.BaseURL:= TItem.URL;
                        TItem.Object_.LinkConversion:=
                          TItem.Parent.Task.LinkConversion;
                      except
                      end;
                      try
                        szHTML:= TItem.Object_.HTML;
                      except
                      end;
                    end
                  else
                    begin
                      TItem.Object_.Links.Clear;
                    end;
                  if TItem.Parent.Task.SaveFiles then
                  begin
                    if Assigned(FOnSaveFile) then
                    begin
                      szFileName := TItem.Filename;
                      AllowSave := True;
                      FOnSaveFile(TItem.Parent.Task, szFileName, AllowSave);
                      if AllowSave then
                       LMDWebWriteFileFromString(szFilename, szHTML);
                    end;
                  end;
                  try
                    for i:= 0 to TItem.Object_.Links.Count - 1 do
                      begin
                        begin
                          if TItem.Object_.Links[i].LinkType = LT_NONE then
                            continue;
                          if
                            TItem.SubTree.IndexOf[TItem.Object_.Links[i].WebURLOnly] >= 0 then
                            continue;
                          NewItem:= TItem.SubTree.Add;
                          NewItem.URL:= TItem.Object_.Links[i].WebURLOnly;
                          case TItem.Object_.Links[i].LinkType of
                            LT_HREF, LT_FRAME: NewItem.FileType:= ftHTML;
                            LT_IMAGE, LT_BODY: NewItem.FileType:= ftImage;
                          else
                            NewItem.FileType:= ftData;
                          end;
                        end;
                      end;
                  except
                  end;
                  DownloadItem(TItem, True);
                  Downloads.ContinueProcess;
                end
              else
                begin
                  if TItem.Parent.Task.SaveFiles then
                    begin
                      dlitem.DataStream.Position := 0;
                      if not LMDWebStreamToFile(TItem.Filename, dlitem.DataStream)  then
                        begin
                          TItem.Filename:= '';
                          TItem.DownloadState:= DS_NONE;
                        end;
                    end;
                  TItem.Object_.Clear;
                end;
            except
            end;
            try
              TItem.UpdateSubTree;
            except
            end;
          end;
        {
            if TItem.Parent.UpLevel<>nil then
            begin
              TItem.Parent.UpLevel.UpdateLinks(TItem);
            end;
        }
        dlitem.ResetData;
        try
          if Assigned(FOnProgress) then
            FOnProgress(TItem);
          if not dlitem.CheckOnly then
            TItem.DownloadItem:= nil;
        except
        end;
      end
    else
      if dlitem.State = DS_ERROR then
        begin
          TItem.DownloadItem:= nil;
          if Assigned(FOnProgress) then
            FOnProgress(TItem);
        end
      else
        if Assigned(FOnProgress) then
          try
            FOnProgress(TItem);
          except
          end;
  except
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPScan.GetIO: TLMDInternetOptions;
begin
  Result:= Downloads.InternetOptions;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTTPScan.GetState: TLMDDownloadstate;
begin
  Result:= Downloads.State;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.Loaded;
begin
  inherited;
  UpdateFromConfig;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.SetIO(const Value: TLMDInternetOptions);
begin
  Downloads.InternetOptions:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.SetOnAddItem(const Value: TLMDWebHTTPScanAddItem);
begin
  FOnAddItem:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.SetOnSaveFile(const Value: TLMDWebHTTPScanSaveFile);
begin
  FOnSaveFile := Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.SetOnProcessed(const Value: TLMDWebHTTPScanProcessed);
begin
  FOnProcessed:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.SetOnProgress(const Value: TLMDWebHTTPScanProgress);
begin
  FOnProgress:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.SetOnStartProcess(const Value: TNotifyEvent);
begin
  FOnStartProcess := Value;
end;

procedure TLMDWebHTTPScan.SetStrongUpdate(const Value: boolean);
begin
  FStrongUpdate:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.SetTask(const Value: TLMDWebTaskItem);
begin
  FTask.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.SetWebConfig(const Value: TLMDWebConfig);
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

procedure TLMDWebHTTPScan.Terminate;
begin
  Downloads.Terminate;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTTPScan.UpdateFromConfig;
begin
  if FWebConfig <> nil then
    begin
      InternetOptions:= FWebConfig.InternetOptions;
      FTask.UserName:= FWebConfig.UserName;
      FTask.Password:= FWebConfig.Password;
      FTask.BaseURL:= FWebConfig.URL;
      FTask.AcceptTypes:= FWebConfig.AcceptTypes;
    end;
end;

procedure TLMDWebHTTPScan.Clear;
begin
  Terminate;
  Downloads.WaitForEnd;
  Downloads.Free;
  FTaskCollection.Free;
  FTaskCollection:= TLMDWebTasks.Create(FTreeParams, nil);
  FTask:= FTaskCollection.Add;
  FTask.DestinationDir:= ExtractFilePath(Application.exeName);
  Downloads:= TLMDDownloads.Create;
  Downloads.OnProcessed:= DownloadProcessed;
  Downloads.OnProgress:= DownloadProgress;
end;

end.
