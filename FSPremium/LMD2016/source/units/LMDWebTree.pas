unit LMDWebTree;
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

LMDWebTree unit (DD)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, 
  LMDHTMLObjectUnit, LMDDownload, LMDClassLib, LMDHashList;

type
  TLMDWebFileType = (ftNone, ftHTML, ftImage, ftAudio, ftVideo, ftApplication,
    ftText, ftFolder, ftData);

  { **************************TLMDWebTreeParams**************************** }
  TLMDWebTreeParams = class
  private
    FLinks: TLMDHASHStringList;
    FSem: THandle;
    procedure InternalReplaceLink(Hash: word; i: integer; aObject: TObject);
  public
    bDontReplace: boolean;
    IsLoading: boolean;
    constructor Create;
    destructor Destroy; override;
    property GlobalLinks: TLMDHASHStringList read FLinks;
    procedure AddLink(const URL: string; aObject: TObject; bSafe: boolean = False);
    procedure DelLink(aObject: TObject);
    procedure AddSubLink(const URL: string; aObject: TObject; bCreateNew: boolean =
      True);
    function CheckLink(const URL: string; aObject: TObject; bReplace: boolean = True):
      boolean;
  end;

  { **************************TLMDWebTree**************************** }
  TLMDWebTree = class;

  { **************************TLMDWebTreeItem**************************** }
  TLMDWebTreeItem = class(TCollectionItem)
  private
    FURL: string;
    FDS: TLMDDownloadState;
    FFilename: string;
    FFileType: TLMDWebFileType;
    FsFileType: string;
    FORTree: TLMDWebTree;
    FORTreeItem: TLMDWebTreeItem;
    FObject: TLMDHTMLObject;
    FDownloadItem: TLMDDownloadItem;
    FdwError: DWORD;
    FErrorString: string;
    FTag: integer;
    FUserData: TObject;
    FNew: boolean;
    FIsTreeLink: boolean;
    FLinkedItems: TList;
    FParentLinkedItem: TLMDWebTreeItem;
    FCPS: integer;
    FDataSize: integer;
    FDate: TDateTime;
    FData: TObject;
    procedure SetURL(const Value: string);
    function GetParent: TLMDWebTree;
    procedure SetdwError(const Value: DWORD);
    procedure SetErrorString(const Value: string);
    function GetLevel: integer;
    function GetCaption: string;
    procedure SetIsTreeLink(const Value: boolean);
    function GetTitle: string;
    function GetTitleEx(const szRelative: string): string;
    function GetLinkedItem(Index: integer): TLMDWebTreeItem;
    procedure SetCPS(const Value: integer);
    procedure SetDataSize(const Value: integer);
    procedure SetDate(const Value: TDateTime);
  protected
    procedure Loaded; virtual;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure DeleteLocalFile;
    procedure AddLinked(Item: TLMDWebTreeItem);
    procedure DelLinked(Item: TLMDWebTreeItem);
    property Parent: TLMDWebTree read GetParent;
    procedure UpdateLinks;
    procedure UpdateSubTree;
    procedure UpdateFileType;
    property Caption: string read GetCaption;
    property Title: string read GetTitle;
    property DownloadItem: TLMDDownloadItem read FDownloadItem write
      FDownloadItem;
    property dwError: DWORD read FdwError write SetdwError;
    property ErrorString: string read FErrorString write SetErrorString;
    property Tag: integer read FTag write FTag default 0;
    property Data: TObject read FData write FData;
    property UserData: TObject read FUserData write FUserData;
    property bNew: boolean read FNew write FNew default True;
    property ParentLinkedItem: TLMDWebTreeItem read FParentLinkedItem write
      FParentLinkedItem;
    property LinkedItems: TList read FLinkedItems;
    property LinkedItem[Index: integer]: TLMDWebTreeItem read GetLinkedItem;
    property Object_: TLMDHTMLObject read FObject write FObject;
  published
    property IsTreeLink: boolean read FIsTreeLink write SetIsTreeLink default False;
    property URL: string read FURL write SetURL;
    property Date: TDateTime read FDate write SetDate;
    property DownloadState: TLMDDownloadState read FDS write FDS;
    property Filename: string read FFilename write FFilename;
    property FileType: TLMDWebFileType read FFileType write FFileType;
    property StrFileType: string read FsFileType write FsFileType;
    property Level: integer read GetLevel default 0;
    property SubTree: TLMDWebTree read FORTree write FORTree;
    property UpperTreeItem: TLMDWebTreeItem read FORTreeItem write FORTreeItem;
    //Statistic
    property CPS: integer read FCPS write SetCPS default 0;
    property DataSize: integer read FDataSize write SetDataSize default 0;
  end;

  { **************************TLMDWebTaskItem**************************** }
  TLMDWebTaskItem = class;

  { **************************TLMDWebTree**************************** }
  TLMDWebTree = class(TCollection)
  private
    FUpLevel: TLMDWebTreeItem;
    FTask: TLMDWebTaskItem;
    FParams: TLMDWebTreeParams;
    function GetItem(Index: integer): TLMDWebTreeItem;
    function GetIndexOf(const URL: string): integer;
    function GetCPS: integer;
    function GetTotalFiles: integer;
    function GetTotalImages: integer;
    function GetTotalB: integer;
  protected
    procedure Loaded; virtual;
  public
    constructor Create(aParams: TLMDWebTreeParams; aTask: TLMDWebTaskItem);
    function Add: TLMDWebTreeItem;
    procedure DeleteLocalFiles;
    procedure UpdateLinks;
    property Item[Index: integer]: TLMDWebTreeItem read GetItem; default;
    property UpLevel: TLMDWebTreeItem read FUpLevel;
    property Params: TLMDWebTreeParams read FParams;
    property IndexOf[const URL: string]: integer read GetIndexOf;
    property Task: TLMDWebTaskItem read FTask;
    property CPS: integer read GetCPS default 0;
    property TotalB: integer read GetTotalB default 0;
    property TotalFiles: integer read GetTotalFiles default 0;
    property TotalImages: integer read GetTotalImages default 0;
  end;

  { **************************TLMDWebTasks**************************** }
  TLMDWebTasks = class;

  { **************************TLMDWebTaskItem**************************** }
  TLMDWebTaskItem = class(TCollectionItem)
  private
    FObject: TLMDWebTree;
    FLoadOtherSites: boolean;
    FDepth: integer;
    FDefaultFileName: string;
    FDestinationDir: string;
    FBaseURL: string;
    FHost: string;
    FTaskName: string;
    FTag: integer;
    FUserData: TObject;
    FUserName: string;
    FPassword: string;
    FExcludedExt: TStringList;
    FExcludedTypes: TStringList;
    FMap: TLMDWebTree;
    FItemID: integer;
    FWorkTime: TDateTime;
    FCreateTime: TDateTime;
    FUpdateTime: TDateTime;
    FLinkConversion: TLMDLinkConversion;
    FMaxDownloadKB: integer;
    FUpdate: boolean;
    FStrongUpdate: boolean;
    FTreeParams: TLMDWebTreeParams;
    FSaveFiles: boolean;
    FAcceptTypes: TStringList;
    FDefaultExtension: String;
    FAutoReset: Boolean;
    procedure SetObject(const Value: TLMDWebTree);
    procedure SetBaseURL(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetExcludedExt(const Value: TStringList);
    procedure SetExcludedTypes(const Value: TStringList);
    procedure SetMap(const Value: TLMDWebTree);
    procedure SetItemID(const Value: integer);
    function GetCPS: integer;
    function GetTotalFiles: integer;
    function GetTotalImages: integer;
    function GetTotalB: integer;
    function GetTotalTime: TDateTime;
    procedure SetWorkTime(const Value: TDateTime);
    procedure SetCreateTime(const Value: TDateTime);
    procedure SetUpdateTime(const Value: TDateTime);
    procedure SeTLMDLinkConversion(const Value: TLMDLinkConversion);
    procedure SetMaxDownloadKB(const Value: integer);
    function  GetItemObject: TLMDWebTree;
    procedure SetStrongUpdate(const Value: boolean);
    procedure SetUpdate(const Value: boolean);
    procedure SetTreeParams(const Value: TLMDWebTreeParams);
    function GetTreeParams: TLMDWebTreeParams;
    procedure SetSaveFiles(const Value: boolean);
    procedure SetAcceptTypes(const Value: TStringList);
    procedure SetDefaultExtension(const Value: String);
    procedure SetAutoReset(const Value: Boolean);
  public
    StartTime: TDateTime;
    Activated: boolean;
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    {.$IFDEF LMDWEB_REFINE}
    //procedure Search(const szTemplate: string; List: TList; bMatchCase: boolean);
    {.$ENDIF}
    procedure AddToMap(TI: TLMDWebTreeItem; bOtherSites: boolean = True);
    procedure BuildMap(bOtherSites: boolean = true);
    procedure ActivateProject; virtual;
    property Host: string read FHost;
    property Tag: integer read FTag write FTag default 0;
    property UserData: TObject read FUserData write FUserData;
    property Map: TLMDWebTree read FMap write SetMap;
    property CPS: integer read GetCPS default 0;
    property TotalB: integer read GetTotalB default 0;
    property TotalFiles: integer read GetTotalFiles default 0;
    property TotalImages: integer read GetTotalImages default 0;
    property TotalTime: TDateTime read GetTotalTime;
    property TreeParams: TLMDWebTreeParams read GetTreeParams write SetTreeParams;
  published
    property MaxDownloadKB: integer read FMaxDownloadKB write SetMaxDownloadKB default 0;
    property LinkConversion: TLMDLinkConversion read FLinkConversion write
      SeTLMDLinkConversion;
    property CreateTime: TDateTime read FCreateTime write SetCreateTime;
    property UpdateTime: TDateTime read FUpdateTime write SetUpdateTime;
    property WorkTime: TDateTime read FWorkTime write SetWorkTime;
    property ItemID: integer read FItemID write SetItemID default 0;
    property ExcludedTypes: TStringList read FExcludedTypes write
      SetExcludedTypes;
    property ExcludedExt: TStringList read FExcludedExt write SetExcludedExt;
    property Tree: TLMDWebTree read GetItemObject write SetObject;
    property Depth: integer read FDepth write FDepth default 4;
    property LoadOtherSites: boolean read FLoadOtherSites write FLoadOtherSites default False;
    property DefaultFileName: string read FDefaultFileName write
      FDefaultFileName;
    property DestinationDir: string read FDestinationDir write FDestinationDir;
    property BaseURL: string read FBaseURL write SetBaseURL;
    property TaskName: string read FTaskName write FTaskName;
    property UserName: string read FUserName write SetUserName;
    property Password: string read FPassword write SetPassword;
    property Update: boolean read FUpdate write SetUpdate default True;
    property SaveFiles: boolean read FSaveFiles write SetSaveFiles default True;
    property StrongUpdate: boolean read FStrongUpdate write SetStrongUpdate default True;
    property AcceptTypes: TStringList read FAcceptTypes write SetAcceptTypes;
    property DefaultExtension: String read FDefaultExtension write SetDefaultExtension;
    property AutoReset: Boolean read FAutoReset write SetAutoReset default True;
  end;

  { **************************TLMDWebFolderItem**************************** }
  TLMDWebFolderItem = class;

  { **************************TLMDWebTasks**************************** }
  TLMDWebTasks = class(TCollection)
  private
    FTreeParams: TLMDWebTreeParams;
    FFolderItem: TLMDWebFolderItem;
    function GetItem(Index: integer): TLMDWebTaskItem;
    function GetItemByID(ID: integer): TLMDWebTaskItem;
  public
    constructor Create(TreeParams: TLMDWebTreeParams; FolderItem:
      TLMDWebFolderItem);
    destructor Destroy; override;
    function Add: TLMDWebTaskItem;
    function GetUniqueID: integer;
    property ItemByID[ID: integer]: TLMDWebTaskItem read GetItemByID;
    property Item[Index: integer]: TLMDWebTaskItem read GetItem; default;
  end;

  { **************************TLMDWebFolderItem**************************** }
  TLMDWebFolderItem = class(TCollectionItem)
  private
    FFolderName: string;
    FTasks: TLMDWebTasks;
    FTag: integer;
    FUserData: TObject;
    procedure SetTasks(const Value: TLMDWebTasks);
  protected
    procedure Loaded; virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Tag: integer read FTag write FTag default 0;
    property UserData: TObject read FUserData write FUserData;
  published
    property Tasks: TLMDWebTasks read FTasks write SetTasks;
    property FolderName: string read FFolderName write FFolderName;
  end;

  { **************************TLMDWebFolders**************************** }
  TLMDWebFolders = class(TCollection)
  private
    FTreeParams: TLMDWebTreeParams;
    function GetFolder(Index: integer): TLMDWebFolderItem;
    function GetTaskByID(ID: integer): TLMDWebTaskItem;
  protected
    procedure Loaded; virtual;
  public
    constructor Create(TreeParams: TLMDWebTreeParams);
    function Add: TLMDWebFolderItem;
    property TaskByID[ID: integer]: TLMDWebTaskItem read GetTaskByID;
    property Folder[Index: integer]: TLMDWebFolderItem read GetFolder; default;
  end;

  { **************************TLMDWebProject**************************** }
  TLMDWebProject = class(TLMDSerializable)
  private
    FFolders: TLMDWebFolders;
    FTreeParams: TLMDWebTreeParams;
    FLog: TStringList;
    FOnUpdateLog: TNotifyEvent;
    procedure SetFolders(const Value: TLMDWebFolders);
    procedure SetLog(const Value: TStringList);
    procedure SetOnUpdateLog(const Value: TNotifyEvent);
  protected
    procedure Loading; override;
    procedure Loaded; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddToLog(szStr: string);
    property TreeParams: TLMDWebTreeParams read FTreeParams;
    property OnUpdateLog: TNotifyEvent read FOnUpdateLog write SetOnUpdateLog;
  published
    property Folders: TLMDWebFolders read FFolders write SetFolders;
    property Log: TStringList read FLog write SetLog;
    property Compressed;

  end;
implementation

uses
  SysUtils,
  LMDURLSupp, LMDFSSupport;

{ **************************TLMDWebTreeItem**************************** }

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.AddLinked(Item: TLMDWebTreeItem);
begin
  if Item <> Self then
    begin
      FLinkedItems.Add(Item);
      Item.FParentLinkedItem:= Self;
    end;
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebTreeItem.Create(Collection: TCollection);
begin
  inherited;
  FObject:= TLMDHTMLObject.Create;
  FORTree:= TLMDWebTree.Create(Parent.FParams, Parent.FTask);
  FLinkedItems:= TList.Create;
  FParentLinkedItem:= nil;
  FORTree.FUpLevel:= Self;
  FURL:= '';
  FDS:= DS_NONE;
  FFilename:= '';
  FFileType:= ftNone;
  FsFileType:= '';
  FDownloadItem:= nil;
  FNew:= True;
  FIsTreeLink:= False;
  FErrorString:= '';
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('HTMLObject', FObject.Read, FObject.Write, FFileType =
    ftHTML);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.DeleteLocalFile;
begin
  if Filename <> '' then
    DeleteFile(Filename);
  SubTree.DeleteLocalFiles;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.DelLinked(Item: TLMDWebTreeItem);
var
  i: integer;
begin
  i:= FLinkedItems.IndexOf(Item);
  if i >= 0 then
    begin
      FLinkedItems.Delete(i);
      Item.FParentLinkedItem:= nil;
    end;
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebTreeItem.Destroy;
var
  i: integer;
begin
  if not FIsTreeLink then
    begin
      Parent.Params.DelLink(Self);
      //    i:=Parent.Params.GlobalLinks.IndexOfObject(Self);
      //    if (i>=0) and (Parent.Params.GlobalLinks.Objects[i]=Self) then
      //      Parent.Params.GlobalLinks.Delete(i);
    end;
  if FParentLinkedItem <> nil then
    FParentLinkedItem.DelLinked(Self);
  for i:= 0 to FLinkedItems.Count - 1 do
    begin
      LinkedItem[i].FParentLinkedItem:= nil;
    end;
  FORTree.Free;
  FObject.Free;
  FLinkedItems.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTreeItem.GetCaption: string;
var
  szTmp: string;
begin
  Result:= URL;
  if Parent.UpLevel = nil then
    exit;
  szTmp:= Parent.UpLevel.URL;
  if szTmp = '' then
    exit;
  Result:= ExtractURLRelativePath(szTmp, URL);
end;

{-----------------------------------------------------------------------------}

function TLMDWebTreeItem.GetLevel: integer;
begin
  Result:= 0;
  if Parent.FUpLevel <> nil then
    Result:= Parent.FUpLevel.Level + 1;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTreeItem.GetLinkedItem(Index: integer): TLMDWebTreeItem;
begin
  Result:= TLMDWebTreeItem(FLinkedItems[Index]);
end;

{-----------------------------------------------------------------------------}

function TLMDWebTreeItem.GetParent: TLMDWebTree;
begin
  Result:= TLMDWebTree(Collection);
end;

{-----------------------------------------------------------------------------}

function TLMDWebTreeItem.GetTitle: string;
begin
  Result:= GetTitleEx('');
end;

{-----------------------------------------------------------------------------}

function TLMDWebTreeItem.GetTitleEx(const szRelative: string): string;
var
  szTmp: string;
begin
  if szRelative = '' then
    szTmp:= Caption
  else
    szTmp:= ExtractURLRelativePath(szRelative, FURL);
  if FParentLinkedItem <> nil then
    begin
      if (szRelative = '') and (Parent.FUpLevel <> nil) then
        Result:= FParentLinkedItem.GetTitleEx(Parent.FUpLevel.FURL)
      else
        Result:= FParentLinkedItem.GetTitleEx(szRelative);
    end
  else
    if (Object_ <> nil) and (Object_.Title <> '') then
      Result:= szTmp + ' (' + Object_.Title + ')'
    else
      Result:= szTmp;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.Loaded;
var
  i: integer;
begin
  if FIsTreeLink then
    Parent.Params.AddSubLink(LMDWebGetWebFileURL(FURL, True), Self);
  for i:= 0 to SubTree.Count - 1 do
    SubTree[i].Loaded;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.SetCPS(const Value: integer);
begin
  FCPS:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.SetDataSize(const Value: integer);
begin
  FDataSize:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.SetDate(const Value: TDateTime);
begin
  FDate:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.SetdwError(const Value: DWORD);
begin
  FdwError:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.SetErrorString(const Value: string);
begin
  FErrorString:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.SetIsTreeLink(const Value: boolean);
begin
  FIsTreeLink:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.SetURL(const Value: string);
var
  i: integer;
begin
  FURL:= '';
  for i:= 1 to Length(Value) do
    if not (AnsiChar(Value[i]) in ['''', '"', #4, #1]) then
      FURL:= FURL + Value[i];
  if not FIsTreeLink then
    Parent.Params.AddLink(LMDWebGetWebFileURL(FURL, True), Self,
      Parent.Params.IsLoading);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.UpdateFileType;
begin
//  DownloadItem.
  StrFileType:= DownloadItem.ActualType;
  if Pos(CFSTR_MIME_HTML, StrFileType) > 0 then
    FileType:= ftHTML
  else
    if pos('text/', StrFileType) > 0 then
      FileType:= ftText
    else
      if pos('image/', StrFileType) > 0 then
        FileType:= ftImage
      else
        if pos('audio/', StrFileType) > 0 then
          FileType:= ftAudio
        else
          if pos('video/', StrFileType) > 0 then
            FileType:= ftVideo
          else
            if pos('application/', StrFileType) > 0 then
              FileType:= ftApplication
            else
              FileType:= ftData;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.UpdateLinks;
var
  i: integer;
  szHTML: string;
  Obj: TObject;
  TI: TLMDWebTreeItem;
begin
  if (FFileType = ftHTML) and (FDS = DS_PROCESSED) then
    begin
      for i:= 0 to Object_.Links.Count - 1 do
        begin
          if
            Parent.FParams.GlobalLinks.FindObject(LMDWebGetWebFileURL(Object_.Links[i].WebURLOnly), Obj) >= 0 then
            begin
              TI:= TLMDWebTreeItem(Obj);
              if (TI.FDS = DS_PROCESSED) and (TI.FFilename <> '') then
                begin
                  Object_.Links[i].Local:= True;
                  Object_.Links[i].LocalFile:= TI.FFilename;
                end;
            end;
        end;
      Object_.LinkConversion:= Parent.FTask.FLinkConversion;
      if Parent.Task.SaveFiles then
        begin
          szHTML:= Object_.HTML;
          FFilename:= LMDWebCreateFileName(Parent.FTask.DestinationDir,
            Parent.FTask.DefaultFileName, URL, True);
          if pos('.HTM', UpperCase(FFilename)) = 0 then
            FFilename:= FFilename + '.htm';
          if not FileExists(FFilename) then
            LMDWebCreateDirs(ExtractFilePath(FFilename));
          LMDWebWriteFileFromString(FFilename, szHTML, -1);//, DownloadItem.);
        end;
      SubTree.UpdateLinks;
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeItem.UpdateSubTree;
begin
end;

{ **************************TLMDWebTree**************************** }

{-----------------------------------------------------------------------------}

function TLMDWebTree.Add: TLMDWebTreeItem;
begin
  Result:= TLMDWebTreeItem(inherited Add);
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebTree.Create;
begin
  inherited Create(TLMDWebTreeItem);
  FUpLevel:= nil;
  FParams:= aParams;
  FTask:= aTask;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTree.DeleteLocalFiles;
var
  i: integer;
begin
  for i:= 0 to Count - 1 do
    Item[i].DeleteLocalFile;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTree.GetCPS: integer;
var
  i: integer;
  iCount: integer;
  iMix: integer;
begin
  Result:= 0;
  iCount:= 1;
  for i:= 0 to Count - 1 do
    begin
      if Item[i].IsTreeLink then
        continue;
      if Item[i].CPS <> 0 then
        Result:= (Result + Item[i].CPS);
      Inc(iCount);
      iMix:= Item[i].SubTree.TotalFiles - 1;
      Result:= (Result + Item[i].SubTree.CPS * iMix);
      Inc(iCount, iMix);
    end;
  Result:= Result div iCount;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTree.GetIndexOf(const URL: string): integer;
var
  i: integer;
begin
  Result:= -1;
  for i:= 0 to Count - 1 do
    if Item[i].URL = URL then
      begin
        Result:= i;
        break;
      end;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTree.GetItem(Index: integer): TLMDWebTreeItem;
begin
  Result:= TLMDWebTreeItem(inherited Items[Index]);
end;

{-----------------------------------------------------------------------------}

function TLMDWebTree.GetTotalFiles: integer;
var
  i: integer;
begin
  Result:= 0;
  for i:= 0 to Count - 1 do
    begin
      if Item[i].IsTreeLink then
        continue;
      Result:= Result + 1 + Item[i].SubTree.TotalFiles;
    end;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTree.GetTotalImages: integer;
var
  i: integer;
begin
  Result:= 0;
  for i:= 0 to Count - 1 do
    begin
      if Item[i].IsTreeLink then
        continue;
      if Item[i].FileType = ftImage then
        Inc(Result);
      Result:= Result + Item[i].SubTree.TotalImages;
    end;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTree.GetTotalB: integer;
var
  i: integer;
begin
  Result:= 0;
  for i:= 0 to Count - 1 do
    begin
      if Item[i].IsTreeLink then
        continue;
      Result:= Result + Item[i].DataSize + Item[i].SubTree.TotalB;
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTree.Loaded;
var
  i: integer;
begin
  inherited;
  for i:= 0 to Count - 1 do
    Item[i].Loaded;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTree.UpdateLinks;
var
  i: integer;
begin
  for i:= 0 to Count - 1 do
    Item[i].UpdateLinks;
end;

{ **************************TLMDWebTasks**************************** }

{-----------------------------------------------------------------------------}

function TLMDWebTasks.Add: TLMDWebTaskItem;
begin
  Result:= TLMDWebTaskItem(inherited Add);
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebTasks.Create;
begin
  inherited Create(TLMDWebTaskItem);
  FTreeParams:= TreeParams;
  FFolderItem:= FolderItem;
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebTasks.Destroy;
begin
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTasks.GetItem(Index: integer): TLMDWebTaskItem;
begin
  Result:= TLMDWebTaskItem(inherited Items[Index]);
end;

{-----------------------------------------------------------------------------}

function TLMDWebTasks.GetItemByID(ID: integer): TLMDWebTaskItem;
var
  i: integer;
begin
  Result:= nil;
  for i:= 0 to Count - 1 do
    if Item[i].ItemID = ID then
      begin
        Result:= Item[i];
        break;
      end;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTasks.GetUniqueID: integer;
var
  b: boolean;
begin
  Result:= Random($7FFFFFF);
  b:= True;
  while b do
    begin
      if FFolderItem <> nil then
        begin
          b:= TLMDWebFolders(FFolderItem.Collection).TaskByID[Result] <> nil;
          if b then
            Result:= Random($7FFFFFF);
        end
      else
        b:= False;
    end;
end;
{TLMDWebProject}
{ **************************TLMDWebProject**************************** }

{-----------------------------------------------------------------------------}

procedure TLMDWebProject.AddToLog(szStr: string);
begin
  Log.Add(DateTimeToStr(Now) + ' - ' + szStr);
  if Assigned(OnUpdateLog) then
    OnUpdateLog(Self);
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebProject.Create;
begin
  inherited Create;
  FLog:= TStringList.Create;
  FTreeParams:= TLMDWebTreeParams.Create;
  FFolders:= TLMDWebFolders.Create(FTreeParams);
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebProject.Destroy;
begin
  FTreeParams.bDontReplace:= True;
  FFolders.Free;
  FTreeParams.Free;
  FLog.Free;
  inherited Destroy;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebProject.Loaded;
begin
  inherited;
  FFolders.Loaded;
  FTreeParams.IsLoading:= False;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebProject.Loading;
begin
  inherited;
  FTreeParams.IsLoading:= True;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebProject.SetFolders(const Value: TLMDWebFolders);
begin
  FFolders.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebProject.SetLog(const Value: TStringList);
begin
  FLog.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebProject.SetOnUpdateLog(const Value: TNotifyEvent);
begin
  FOnUpdateLog:= Value;
end;

{ **************************TLMDWebTaskItem**************************** }

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.AddToMap(TI: TLMDWebTreeItem; bOtherSites: boolean);
var
  szHost: string;
  szPath: string;
  szFile: string;
  DI: TLMDWebTreeItem;
  szURL: string;
  i: integer;

  function GetItem(Tree: TLMDWebTree; const szURL: string; bIsFolder: boolean =
    False): TLMDWebTreeItem;
  var
    i: integer;
    S, S1: string;
  begin
    Result:= nil;
    S:= LMDWebGetWebFileURL(szURL);

    if  bIsFolder then
      S1 := LMDWebAddBackSlash(S)
    else
      S1 := S;

    for i:= 0 to Tree.Count - 1 do
      if SameText(LMDWebGetWebFileURL(Tree[i].FURL), S1) then
        begin
          Result:= Tree[i];
          break;
        end;
    if Result = nil then
      begin
        Result:= Tree.Add;
        Result.FIsTreeLink:= True;
        TLMDWebTasks(Collection).FTreeParams.AddSubLink(S, Result, False);
        if bIsFolder then
          begin
            Result.Index:= 0;
            Result.FileType:= ftFolder;
          end;
        Result.URL:= S1;
      end;
  end;
begin
  if pos('MAILTO:',UpperCase(TI.URL))=1 then
    exit;
  szHost:= UpperCase(GetHostURL(TI.URL));
  if szHost = '' then
    exit;
  if (not bOtherSites) and (GetHost(szHost) <> UpperCase(FHost)) then
    exit;
  szPath:= GetPath(TI.URL);
  szFile:= ExtractURLFileName(szPath);
  szPath:= ExtractURLFilePath(szPath);
  szURL:= LMDWebGetWebFileURL(szHost);
  if szPath = '' then
    szURL:= TI.URL;
  DI:= GetItem(FMap, szURL, True);
  szPath:= LMDWebDeleteFirstBackSlash(szPath);
  while szPath <> '' do
    begin
      szURL:= LMDWebAddBackSlash(szURL);
      i:= pos('/', szPath);
      if i = 0 then
        begin
          szURL:= szURL + szPath;
          szPath:= '';
          if szFile = '' then
            szURL:= TI.URL;
        end
      else
        begin
          szURL:= szURL + Copy(szPath, 1, i - 1);
          szPath:= Copy(szPath, i + 1, Length(szPath) - i);
        end;
      DI:= GetItem(DI.SubTree, szURL, True);
      szPath:= LMDWebDeleteFirstBackSlash(szPath);
    end;
  if szFile <> '' then
    begin
      szURL:= TI.URL; //AddBackSlash(szURL)+szFile;
      GetItem(DI.SubTree, szURL);
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.BuildMap;
var
  i, j: integer;
  TI: TLMDWebTreeItem;
  Links: TLMDHASHStringList;
begin
  ActivateProject;
  FMap.Clear;
  Links := FObject.Params.FLinks;
  for i:= 0 to HASHTABLE_SIZE do
    if Assigned(Links.HashTable[i]) then
      for j:= 0 to Length(Links.HashTable[i]) - 1 do
        begin
          TI:= TLMDWebTreeItem(Links.HashTable[i][j].pObj);
          if TI.Parent.FTask = Self then
            begin
              AddToMap(TI, bOtherSites);
            end;
        end;
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebTaskItem.Create(Collection: TCollection);
begin
  inherited;
  Activated:= False;
  if Collection <> nil then
    begin
      FItemID:= TLMDWebTasks(Collection).GetUniqueID;
      FObject:= TLMDWebTree.Create(TLMDWebTasks(Collection).FTreeParams, Self);
      FMap:= TLMDWebTree.Create(TLMDWebTasks(Collection).FTreeParams, Self);
    end
  else
    begin
      FItemID:= 0;
      FObject:= TLMDWebTree.Create(nil, Self);
      FMap:= TLMDWebTree.Create(nil, Self);
    end;
  FDepth:= 4;
  FLoadOtherSites:= False;
  FDefaultFileName:= 'default.htm';
  FTaskName:= '';
  FExcludedExt:= TStringList.Create;
  FExcludedTypes:= TStringList.Create;
  FAcceptTypes:= TStringList.Create;
  FCreateTime:= Now;
  FUpdateTime:= Now;
  FLinkConversion:= lcOffline;
  FUpdate:= True;
  FStrongUpdate:= True;
  FSaveFiles:= True;
  FDefaultExtension := 'htm';
  FAutoReset := True;
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebTaskItem.Destroy;
begin
  FExcludedExt.Free;
  FExcludedTypes.Free;
  FAcceptTypes.Free;
  FMap.Free;
  FObject.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTaskItem.GetCPS: integer;
var
  Hour, Min, Sec, MSec: word;
begin
  DecodeTime(TotalTime, Hour, Min, Sec, MSec);
  if (Sec = 0) and (Min = 0) and (Hour = 0) then
    Result:= TotalB
  else
    Result:= Trunc(TotalB / (Hour * 3600 + Min * 60 + Sec));
end;

{-----------------------------------------------------------------------------}

function TLMDWebTaskItem.GetTotalFiles: integer;
begin
  Result:= Tree.TotalFiles;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTaskItem.GetTotalImages: integer;
begin
  Result:= Tree.TotalImages;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTaskItem.GetTotalB: integer;
begin
  Result:= Tree.TotalB;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTaskItem.GetTotalTime: TDateTime;
begin
  Result:= FWorkTime;
  if StartTime <> 0 then
    Result:= Result + Now - StartTime;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.ActivateProject;
begin
  if not Activated then
    begin
      Activated:= True;
      FObject.Loaded;
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetBaseURL(const Value: string);
begin
  FBaseURL:= Value;
  FHost:= UpperCase(GetHost(Value));
  if FTaskName = '' then
    FTaskName:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetCreateTime(const Value: TDateTime);
begin
  FCreateTime:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetExcludedExt(const Value: TStringList);
begin
  FExcludedExt.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetExcludedTypes(const Value: TStringList);
begin
  FExcludedTypes.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetItemID(const Value: integer);
begin
  FItemID:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SeTLMDLinkConversion(const Value: TLMDLinkConversion);
begin
  FLinkConversion:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetMap(const Value: TLMDWebTree);
begin
  FMap.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetMaxDownloadKB(const Value: integer);
begin
  FMaxDownloadKB:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetObject(const Value: TLMDWebTree);
begin
  FObject.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetPassword(const Value: string);
begin
  FPassword:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetUpdateTime(const Value: TDateTime);
begin
  FUpdateTime:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetUserName(const Value: string);
begin
  FUserName:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetWorkTime(const Value: TDateTime);
begin
  FWorkTime:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.Assign(Source: TPersistent);
begin
  if Source is TLMDWebTaskItem then
    begin
      with TLMDWebTaskItem(Source) do
        begin
          Self.MaxDownloadKB:= MaxDownloadKB;
          Self.LinkConversion:= LinkConversion;
          Self.ExcludedTypes:= ExcludedTypes;
          Self.ExcludedExt:= ExcludedExt;
          Self.Depth:= Depth;
          Self.LoadOtherSites:= LoadOtherSites;
          Self.DefaultFileName:= DefaultFileName;
          Self.DestinationDir:= DestinationDir;
          Self.BaseURL:= BaseURL;
          Self.UserName:= UserName;
          Self.Password:= Password;
          Self.Update:= Update;
          Self.StrongUpdate:= StrongUpdate;
          Self.SaveFiles:= SaveFiles;
          Self.AcceptTypes:= AcceptTypes;
        end;
    end
  else
    inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTaskItem.GetItemObject: TLMDWebTree;
begin
  Result:= FObject;
end;

{-----------------------------------------------------------------------------}
{procedure TLMDWebTaskItem.Search(const szTemplate: string; List: TList; bMatchCase:
  boolean);
var
  RC: TLMDRefine;
  procedure InternalSearch(Tree: TLMDWebTree);
  var
    i: integer;
  begin
    for i:= 0 to Tree.Count - 1 do
      begin
        if Tree[i].FFileType = ftHTML then
          begin
            if Tree[i].FDS = DS_PROCESSED then
              begin
                if RC.SearchTemplate(RemoveTags(Tree[i].Object_.HTML)) then
                  List.Add(Tree[i]);
                InternalSearch(Tree[i].SubTree);
              end;
          end;
      end;
  end;
begin
  List.Clear;
  RC:= TLMDRefine.Create(nil);
  RC.MatchCase:= bMatchCase;
  try
    if RC.ParseTemplate(szTemplate) then
      begin
        InternalSearch(Tree);
      end;
  finally
    RC.Free;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetStrongUpdate(const Value: boolean);
begin
  FStrongUpdate:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetUpdate(const Value: boolean);
begin
  FUpdate:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetTreeParams(const Value: TLMDWebTreeParams);
begin
  FTreeParams:= Value;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTaskItem.GetTreeParams: TLMDWebTreeParams;
begin
  if FTreeParams = nil then
    Result:= TLMDWebTasks(Collection).FTreeParams
  else
    Result:= FTreeParams;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetSaveFiles(const Value: boolean);
begin
  FSaveFiles:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetAcceptTypes(const Value: TStringList);
begin
  FAcceptTypes.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetDefaultExtension(const Value: String);
begin
  FDefaultExtension := Value;
  while (Length(FDefaultExtension) > 0) and (FDefaultExtension[1] = '.') do
   FDefaultExtension := copy(FDefaultExtension, 2, Length(FDefaultExtension) - 1);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTaskItem.SetAutoReset(const Value: Boolean);
begin
  FAutoReset := Value;
end;

{ **************************TLMDWebTreeParams**************************** }

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeParams.AddLink(const URL: string; aObject: TObject; bSafe:
    boolean = False);
var
  i: integer;
  Obj: TObject;
begin
  if bSafe then
    begin
      GlobalLinks.AddObject(URL, aObject);
    end
  else
    begin
      WaitForSingleObject(FSem, INFINITE);
      try
        i:= GlobalLinks.FindObject(URL, Obj);
        if (i = -1) or (Obj = aObject) then
          begin
            if i >= 0 then
              GlobalLinks.Delete(GlobalLinks.GetHash(URL), i);
            GlobalLinks.AddObject(URL, aObject);
          end
        else
          begin
            TLMDWebTreeItem(aObject).FIsTreeLink:= True;
            TLMDWebTreeItem(Obj).AddLinked(TLMDWebTreeItem(aObject));
          end;
      except
      end;
      ReleaseSemaphore(FSem, 1, nil);
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeParams.AddSubLink(const URL: string; aObject: TObject;
  bCreateNew: boolean = True);
var
  Obj: TObject;
begin
  WaitForSingleObject(FSem, INFINITE);
  try
    if (GlobalLinks.FindObject(URL, Obj) >= 0) then
      begin
        TLMDWebTreeItem(Obj).AddLinked(TLMDWebTreeItem(aObject));
      end
    else
      begin
        TLMDWebTreeItem(aObject).FIsTreeLink:= False;
        if bCreateNew then
          GlobalLinks.AddObject(URL, aObject);
      end;
  except
  end;
  ReleaseSemaphore(FSem, 1, nil);
end;

{-----------------------------------------------------------------------------}

function TLMDWebTreeParams.CheckLink(const URL: string; aObject: TObject;
  bReplace: boolean): boolean;
var
  i: integer;
  Obj: TObject;
begin
  Result:= False;
  WaitForSingleObject(FSem, INFINITE);
  try
    i:= GlobalLinks.FindObject(URL, Obj);
    Result:= (i = -1) or (Obj = aObject);
    if (not Result) and bReplace then
      begin
        InternalReplaceLink(GlobalLinks.GetHash(URL), i, aObject);
        Result:= True;
      end;
  except
  end;
  ReleaseSemaphore(FSem, 1, nil);
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebTreeParams.Create;
begin
  inherited;
  FLinks:= TLMDHASHStringList.Create;
  FSem:= CreateSemaphore(nil, 1, 1, '');
  bDontReplace:= False;
  IsLoading:= False;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeParams.DelLink(aObject: TObject);
var
  i: integer;
  Hash: word;
  Obj: TObject;
begin
  WaitForSingleObject(FSem, INFINITE);
  try
    if (aObject is TLMDWebTreeItem) then
      begin
        Hash:= GlobalLinks.GetHash(LMDWebGetWebFileURL(TLMDWebTreeItem(aObject).URL,
          True));
        i:= GlobalLinks.FindObject(LMDWebGetWebFileURL(TLMDWebTreeItem(aObject).URL,
          True), Obj);
        if (i >= 0) and (aObject <> Obj) then
          i:= -1;
      end
    else
      i:= -1;
    if i < 0 then
      i:= GlobalLinks.IndexOfObject(aObject, Hash);
    if (not bDontReplace) and (aObject is TLMDWebTreeItem) and
      (TLMDWebTreeItem(aObject).FLinkedItems.Count > 0) then
      begin
        InternalReplaceLink(Hash, i, TLMDWebTreeItem(aObject).LinkedItems[0]);
      end
    else
      if i >= 0 then
        GlobalLinks.Delete(Hash, i);
  except
  end;
  ReleaseSemaphore(FSem, 1, nil);
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebTreeParams.Destroy;
begin
  CloseHandle(FSem);
  FLinks.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebTreeParams.InternalReplaceLink(Hash: word; i: integer; aObject:
  TObject);
var
  j: integer;
begin
  if (aObject is TLMDWebTreeItem) and (GlobalLinks.HashTable[Hash][i].pObj is
    TLMDWebTreeItem) and
    (TLMDWebTreeItem(GlobalLinks.HashTable[Hash][i].pObj).DownloadState = DS_NONE)
    then
    begin
      if TLMDWebTreeItem(aObject).ParentLinkedItem <> nil then
        TLMDWebTreeItem(aObject).ParentLinkedItem.DelLinked(TLMDWebTreeItem(aObject));
      for j:= 0 to
        TLMDWebTreeItem(GlobalLinks.HashTable[Hash][i].pObj).FLinkedItems.Count - 1
        do
        TLMDWebTreeItem(aObject).AddLinked(TLMDWebTreeItem(GlobalLinks.HashTable[Hash][i].pObj).LinkedItem[j]);
      TLMDWebTreeItem(aObject).AddLinked(TLMDWebTreeItem(GlobalLinks.HashTable[Hash][i].pObj));
      TLMDWebTreeItem(GlobalLinks.HashTable[Hash][i].pObj).FLinkedItems.Clear;
      TLMDWebTreeItem(GlobalLinks.HashTable[Hash][i].pObj).FIsTreeLink:= True;
      TLMDWebTreeItem(aObject).FIsTreeLink:= False;
      GlobalLinks.HashTable[Hash][i].pObj:= aObject;
    end
  else
    begin
      TLMDWebTreeItem(aObject).FIsTreeLink:= False;
      GlobalLinks.HashTable[Hash][i].pObj:= aObject;
    end;
end;

{ **************************TLMDWebFolders**************************** }

{-----------------------------------------------------------------------------}

function TLMDWebFolders.Add: TLMDWebFolderItem;
begin
  Result:= TLMDWebFolderItem(inherited Add);
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebFolders.Create;
begin
  inherited Create(TLMDWebFolderItem);
  FTreeParams:= TreeParams;
end;

{-----------------------------------------------------------------------------}

function TLMDWebFolders.GetFolder(Index: integer): TLMDWebFolderItem;
begin
  Result:= TLMDWebFolderItem(Items[Index]);
end;

{-----------------------------------------------------------------------------}

function TLMDWebFolders.GetTaskByID(ID: integer): TLMDWebTaskItem;
var
  i: integer;
begin
  Result:= nil;
  for i:= 0 to Count - 1 do
    begin
      Result:= Folder[i].Tasks.ItemByID[ID];
      if Result <> nil then
        break;
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebFolders.Loaded;
var
  i: integer;
begin
  inherited;
  for i:= 0 to Count - 1 do
    Folder[i].Loaded;
end;

{ **************************TLMDWebFolderItem**************************** }

{-----------------------------------------------------------------------------}

constructor TLMDWebFolderItem.Create(Collection: TCollection);
begin
  inherited;
  FTasks:= TLMDWebTasks.Create(TLMDWebFolders(Collection).FTreeParams, Self);
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebFolderItem.Destroy;
begin
  FTasks.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebFolderItem.Loaded;
begin
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebFolderItem.SetTasks(const Value: TLMDWebTasks);
begin
  FTasks.Assign(Value);
end;
end.
