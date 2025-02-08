unit LMDNews;
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

LMDNews unit (DD)
-----------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

{
  WebNews XML format:

<?xml version="1.0" encoding="UTF-8"?>
<News>
  <images baseurl="<-=BASE URL FOR DOWNLOADS BULLETINS=->">
    <image index="<-=BULLETIN INDEX=->" filename="<-=FILE NAME OF BULLETIN=->"></image>
    ...
  </images>
  <newstree><-=NEWS CAPTION=->
    <-=NEWS BLOCK=->
    <News1 (-=UNIQUE BLOCK NAME=-) URL="<-=URL FOR NEWS BLOCK=->" Image="<-=BULLETIN INDEX=->">
      <![CDATA[<-=NEWS DATA=->]]><-=NEWS BLOCK CAPTION=->
      <NLMDTools98 (-=UNIQUE HEADLINE NAME=-) URL="<-=NEWS URL=->" Image="0"><-=HEADLINE=-></NLMDTools98>
      ...
    </News1>
    ...
  </newstree>
</News>

For example:

<?xml version="1.0" encoding="UTF-8"?>
<News>
  <images baseurl="http://www.ceberus.com/mfs/newsicons">
    <image index="0" filename="0.bmp"></image>
    <image index="1" filename="1.bmp"></image>
    <image index="2" filename="2.bmp"></image>
    <image index="3" filename="3.bmp"></image>
    <image index="4" filename="4.bmp"></image>
  </images>
  <newstree>LMD News
    <News1 URL="http://www.ceberus.com/lmd/news/index.php3" Image="1">
      <![CDATA[25.04.2003]]>General News
      <NLMDTools98 URL="http://www.ceberus.com/lmd/news/index.php3?ID=98" Image="0">Temporary price changes</NLMDTools98>
      <NLMDTools97 URL="http://www.ceberus.com/lmd/news/index.php3?ID=97" Image="0">LMD SearchPack 2.0 available.</NLMDTools97>
      <NLMDTools96 URL="http://www.ceberus.com/lmd/news/index.php3?ID=96" Image="0">LMD DesignPack 2.0 available.</NLMDTools96>
      <NLMDTools93 URL="http://www.ceberus.com/lmd/news/index.php3?ID=93" Image="0">Our office will be closed from 17-Mar to 22-Mar-03.</NLMDTools93>
      <NLMDTools92 URL="http://www.ceberus.com/lmd/news/index.php3?ID=92" Image="0">LMD-Tools order information updated</NLMDTools92>
      <NLMDTools86 URL="http://www.ceberus.com/lmd/news/index.php3?ID=86" Image="0">Our office will be closed from 10/03/02 to 10/07/02.</NLMDTools86>
    </News1>
    <News2 URL="http://www.ceberus.com/lmd/news/index.php3" Image="2">
      <![CDATA[25.04.2003]]>Product News
      <NLMDTools94 URL="http://www.ceberus.com/lmd/news/index.php3?ID=94" Image="0">LMD StoragePack 1.0 available.</NLMDTools94>
      <NLMDTools90 URL="http://www.ceberus.com/lmd/news/index.php3?ID=90" Image="0">LMD DesignPack 1.0 available.</NLMDTools90>
      <NLMDTools88 URL="http://www.ceberus.com/lmd/news/index.php3?ID=88" Image="0">Christmas Special: Order LMD-Tools 6 now...</NLMDTools88>
      <NLMDTools83 URL="http://www.ceberus.com/lmd/news/index.php3?ID=83" Image="0">LMD-Tools (Special Edition) for Delphi 7</NLMDTools83>
      <NLMDTools65 URL="http://www.ceberus.com/lmd/news/index.php3?ID=65" Image="0">New LMD-Tools 6.0 download areas were opened and first release was made available.</NLMDTools65>
      <NLMDTools64 URL="http://www.ceberus.com/lmd/news/index.php3?ID=64" Image="0">The final release of LMD-Tools 6.0  (including all bonus packages) delays probably 2 weeks or more.</NLMDTools64>
    </News2>
    <News3 URL="http://www.ceberus.com/lmd/news/index.php3" Image="3">
      <![CDATA[25.04.2003]]>Download News
      <NLMDTools91 URL="http://www.ceberus.com/lmd/news/index.php3?ID=91" Image="0">LMD-Tools Release 6.12.21 available</NLMDTools91>
      <NLMDTools89 URL="http://www.ceberus.com/lmd/news/index.php3?ID=89" Image="0">LMD-Tools 6.1 SE for Delphi 7 (Freeware version)</NLMDTools89>
      <NLMDTools87 URL="http://www.ceberus.com/lmd/news/index.php3?ID=87" Image="0">LMD-Tools Release 6.12.20 available.</NLMDTools87>
      <NLMDTools85 URL="http://www.ceberus.com/lmd/news/index.php3?ID=85" Image="0">News Trials (LMD-Tools 6.12) available.</NLMDTools85>
      <NLMDTools82 URL="http://www.ceberus.com/lmd/news/index.php3?ID=82" Image="0">LMD-Tools 6.12 SourcePack Preview available.</NLMDTools82>
      <NLMDTools81 URL="http://www.ceberus.com/lmd/news/index.php3?ID=81" Image="0">LMD-Tools Trials in public download area updated.</NLMDTools81>
    </News3>
    <News4 URL="http://www.ceberus.com/lmd/news/index.php3" Image="4">
      <![CDATA[25.04.2003]]>Partner News
      <NLMDTools66 URL="http://www.ceberus.com/lmd/news/index.php3?ID=66" Image="0">Bonus for registered user...</NLMDTools66>
    </News4>
  </newstree>
</News>

}

interface

uses
  Classes, Controls,
  LMDDownload, LMDWebXML, LMDURLSupp, LMDWebConfig;
  const
  STD_NEWS_DOCUMENT = 'news.xml';
  LMDNewsVersionNumber = 1;

type
  TLMDWebNewsState = (LNS_NONE, LNS_PROCESSING, LNS_ERROR);

  { **************************TLMDWebNews**************************** }
  TLMDWebNews = class(TLMDMasterWebComponent)
  private
    FNewsDownloader: TLMDDownloadItem;
    FDownload: TLMDDownloads;
    FServer: string;
    FNewsDocument: string;
    FNewsXML: TStrings;
    FOnComplete: TNotifyEvent;
    FOnProgress: TNotifyEvent;
    FNews: TLMDXMLTags;
    FCaption: String;
    FImagesTags: TLMDXMLTags;
    FImagesBaseURL: String;
    FAutoLoadImages: Boolean;
    FImageList: TImageList;
    FCheckInternet: Boolean;
    FIO: TLMDInternetOptions;
    FWebConfig: TLMDWebConfig;
    procedure SetServer(const Value: string);
    procedure SetNewsDocument(const Value: string);
    function GetState: TLMDWebNewsState;
    procedure DownloadProgress(Sender: TLMDDownloadItem);
    procedure DownloadProcessed(Sender: TLMDDownloads);
    function GetIO: TLMDInternetOptions;
    procedure IO(const Value: TLMDInternetOptions);
    procedure SetNewsXML(const Value: TStrings);
    function GetError: integer;
    function GetErrorString: string;
    function GetProgress: integer;
    function GetProgressString: string;
    function GetNewsDownloader: TLMDDownloadItem;
    procedure SetOnComplete(const Value: TNotifyEvent);
    procedure SetOnProgress(const Value: TNotifyEvent);
    procedure SetNews(const Value: TLMDXMLTags);
    procedure SetCaption(const Value: String);
    procedure SetImagesTags(const Value: TLMDXMLTags);
    procedure SetImagesBaseURL(const Value: String);
    procedure SetAutoLoadImages(const Value: Boolean);
    procedure SetImageList(const Value: TImageList);
    procedure SetCheckInternet(const Value: Boolean);
    function GetOnInteractiveEvent: TLMDInternetOptionsInteractiveEvent;
    procedure SetOnInteractiveEvent(
      const Value: TLMDInternetOptionsInteractiveEvent);
    procedure SetWebConfig(const Value: TLMDWebConfig);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function  CheckNews(bAsync: boolean = True): boolean;
    procedure StopProcessing;
    procedure ParseXML;
    class function GetVersion: Integer;
    function DownloadImages(ImageList:TImageList;bAsync: boolean = True):Integer;
    property State: TLMDWebNewsState read GetState;
    property NewsXML: TStrings read FNewsXML write SetNewsXML;
    property News:TLMDXMLTags read FNews write SetNews;
    property ImagesTags:TLMDXMLTags read FImagesTags write SetImagesTags;
    property ImagesBaseURL:String read FImagesBaseURL write SetImagesBaseURL;
    property Caption:String read FCaption write SetCaption;
    property Progress: integer read GetProgress default 0;
    property ProgressString: string read GetProgressString;
    property Error: integer read GetError default 0;
    property ErrorString: string read GetErrorString;
    procedure UpdateFromConfig; override;
  published
    property About;
    property CheckInternet:Boolean read FCheckInternet write SetCheckInternet default true;
    property AutoLoadImages:Boolean read FAutoLoadImages write SetAutoLoadImages default true;
    property Server: string read FServer write SetServer;
    property NewsDocument: string read FNewsDocument write SetNewsDocument;
    property ImageList:TImageList read FImageList write SetImageList;
    property InternetOptions: TLMDInternetOptions read GetIO write IO;
    property WebConfig: TLMDWebConfig read FWebConfig write SetWebConfig;    
    property OnProgress:TNotifyEvent read FOnProgress write SetOnProgress;
    property OnComplete:TNotifyEvent read FOnComplete write SetOnComplete;
    property OnInteractiveEvent:TLMDInternetOptionsInteractiveEvent read GetOnInteractiveEvent write SetOnInteractiveEvent;
  end;

implementation

uses
  SysUtils, Graphics,
  LMDWebBase, LMDInetConst, LMDWebConst, LMDWebXMLParserLite, LMDFSSupport;

{ **************************TLMDWebNews**************************** }

{-----------------------------------------------------------------------------}

function TLMDWebNews.CheckNews;
begin
  if FCheckInternet then
    if not CheckInet(InternetOptions) and not CheckLocal(FServer)  then
      begin
        Result := False;
        FNewsDownloader:= FDownload.Add;
        FNewsDownloader.SetError(DE_HTTP_ERROR,NOT_CONNECTED_ERROR);
        if bAsync then
          DownloadProcessed(nil);
        exit;
      end;

  result:=false;
  if State in [LNS_PROCESSING] then
    exit;
  StopProcessing;
  FDownload.InternetOptions := InternetOptions;
  FNews.Clear;
  FImagesTags.Clear;
  FImagesBaseURL := '';
  FNewsXML.Clear;
  FNewsDownloader:= FDownload.Add;
  with FNewsDownloader do
    begin
      URL:= FServer + FNewsDocument;
    end;
  if bAsync then
    begin
      FDownload.ThreadProcess;
      Result:= True;
    end
  else
    begin
      FDownload.OnProgress:= nil;
      FDownload.OnProcessed:= nil;
      Result:= FDownload.Process;
      FDownload.OnProgress:= DownloadProgress;
      FDownload.OnProcessed:= DownloadProcessed;
    end;
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebNews.Create(AOwner: TComponent);
begin
  inherited;
  FIO := TLMDInternetOptions.Create;
  FNewsDocument:= STD_NEWS_DOCUMENT;
  FAutoLoadImages := True;
  FNews   := TLMDXMLTags.Create;
  FNewsXML:= TStringList.Create;
  FImagesTags := TLMDXMLTags.Create;
  FNewsDownloader:= nil;
  FCheckInternet := true;

  FDownload:= TLMDDownloads.Create;
  FDownload.OnProgress:= DownloadProgress;
  FDownload.OnProcessed:= DownloadProcessed;
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebNews.Destroy;
begin
  StopProcessing;
  FDownload.Free;
  FNews.Free;
  FImagesTags.Free;
  FNewsXML.Free;
  ImageList := nil;
  FIO.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebNews.DownloadProcessed(Sender: TLMDDownloads);
begin
  if Assigned(FOnComplete) then
    FOnComplete(Self);
  FNewsDownloader := nil;
  SetDisconnect(FIO);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebNews.DownloadProgress(Sender: TLMDDownloadItem);
var
  szTmp : String;
  Bmp   : TBitmap;
  MS    : TMemoryStream;
  P     : integer;
begin
  if (FNewsDownloader=Sender) and (Sender.State in [DS_PROCESSED,DS_ERROR]) then
  begin
    szTmp := '';
    if FNewsDownloader.DataSize>0 then
    begin
      FNewsDownloader.DataStream.Position := 0;
      LMDWebStreamToString(FNewsDownloader.DataStream, szTmp);
    end;
    FNewsXML.Text := szTmp;
    ParseXML;
    if(FAutoLoadImages and (FImageList<>nil))then
    begin
      if DownloadImages(FImageList,True)>0 then
        exit;
    end;
  end
  else
  if (Sender.UserData=TObject(1)) and (Sender.State=DS_PROCESSED) then
  begin
    if Sender.DataSize>0 then
    begin
      Bmp := TBitmap.Create;
      MS  := nil;
      try
        try
          if (Sender.Tag>=0) and (Sender.Tag<200) then
          begin
            Bmp.Width := FImageList.Width;
            Bmp.Height := FImageList.Height;
            while FImageList.Count<=Sender.Tag do
              FImageList.AddMasked(Bmp,Bmp.Canvas.Pixels[0,0]);
            if  Sender.DataSize > 0 then
              begin
                MS := TMemoryStream.Create;
                P := Sender.DataStream.Position;
                Sender.DataStream.Position := 0;
                MS.LoadFromStream(Sender.DataStream);
                Sender.DataStream.Position := P;
                MS.Position := 0;
                Bmp.LoadFromStream(MS);
                if not Bmp.Empty then
                begin
                  FImageList.ReplaceMasked(Sender.Tag, Bmp, Bmp.Canvas.Pixels[0, 0]);
                end;
              end;
          end;
        except
          ;
        end;
      finally
        MS.Free;
        Bmp.Free;
      end;
    end;
  end;

  if Assigned(FOnProgress) then
    FOnProgress(Self);
end;

{-----------------------------------------------------------------------------}

function TLMDWebNews.GetError: integer;
begin
  if GetNewsDownloader <> nil then
    Result:= GetNewsDownloader.dwError
  else
    Result:= 0;
end;

{-----------------------------------------------------------------------------}

function TLMDWebNews.GetErrorString: string;
begin
  if GetNewsDownloader <> nil then
    Result:= GetNewsDownloader.ErrorString
  else
    Result:= '';
end;

{-----------------------------------------------------------------------------}

function TLMDWebNews.GetIO: TLMDInternetOptions;
begin
  Result:= FIO;
end;

{-----------------------------------------------------------------------------}

function TLMDWebNews.GetNewsDownloader: TLMDDownloadItem;
begin
  Result:= FNewsDownloader;
end;

{-----------------------------------------------------------------------------}

function TLMDWebNews.GetProgress: integer;
begin
  if GetNewsDownloader <> nil then
    Result:= GetNewsDownloader.Progress
  else
    Result:= 0;
end;

{-----------------------------------------------------------------------------}

function TLMDWebNews.GetProgressString: string;
begin
  if GetNewsDownloader <> nil then
    Result:= GetNewsDownloader.ProgressString
  else
    Result:= '';
end;

{-----------------------------------------------------------------------------}

function TLMDWebNews.GetState: TLMDWebNewsState;
begin
  case FDownload.State of
    DS_PROCESSED,DS_NONE: Result:= LNS_NONE;
    DS_PREPARED, DS_PROCESSING: Result:= LNS_PROCESSING;
    DS_ERROR: Result:= LNS_ERROR;
  else
    Result:= LNS_NONE;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebNews.IO(const Value: TLMDInternetOptions);
begin
  FIO.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebNews.SetNewsXML(const Value: TStrings);
begin
  FNews.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebNews.SetNewsDocument(const Value: string);
begin
  FNewsDocument:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebNews.SetOnComplete(const Value: TNotifyEvent);
begin
  FOnComplete := Value;
end;

procedure TLMDWebNews.SetOnProgress(const Value: TNotifyEvent);
begin
  FOnProgress := Value;
end;

procedure TLMDWebNews.SetServer(const Value: string);
begin
  FServer:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebNews.StopProcessing;
begin
  if State = LNS_PROCESSING then
    begin
      FDownload.Terminate;
    end;
  if FNewsDownloader <> nil then
    begin
      FNewsDownloader.Free;
      FNewsDownloader:= nil;
    end;
end;
procedure TLMDWebNews.SetNews(const Value: TLMDXMLTags);
begin
  FNews.Assign(Value);
end;

procedure TLMDWebNews.ParseXML;
var
  XMLP : TLMDXMLParserLite;
  NI   : TLMDXMLTag;
  NT   : TLMDXMLTag;
begin
  XMLP := TLMDXMLParserLite.Create;
  try
    XMLP.Parse(FNewsXML.Text);
    NI := XMLP.XMLTags.FindByName(LNEWS_ROOTKEY,False,True);
    if NI<>nil then
    begin
      NT := NI.SubTags.FindByName(LNEWS_TREE_ROOTKEY,False,False);
      if NT<>nil then
      begin
        Caption := NT.Text;
        FNews.Assign(NT.SubTags);
      end;
      NT := NI.SubTags.FindByName(LNEWS_IMAGES_ROOTKEY,False,False);
      if NT<>nil then
      begin
        FImagesBaseURL := NT.Attributes.Values[LNEWS_IMAGES_BASEURL];
        if FImagesBaseURL<>'' then
          if not (AnsiChar(FImagesBaseURL[Length(FImagesBaseURL)]) in ['/','\']) then
            FImagesBaseURL := FImagesBaseURL+'/'; 
        FImagesTags.Assign(NT.SubTags);
      end;
    end;
  finally
    XMLP.Free;
  end;
end;

class function TLMDWebNews.GetVersion: Integer;
begin
  Result := LMDNewsVersionNumber;
end;

procedure TLMDWebNews.SetCaption(const Value: String);
begin
  FCaption := Value;
end;

procedure TLMDWebNews.SetImagesTags(const Value: TLMDXMLTags);
begin
  FImagesTags.Assign(Value);
end;

procedure TLMDWebNews.SetImagesBaseURL(const Value: String);
begin
  FImagesBaseURL := Value;
end;

function TLMDWebNews.DownloadImages(ImageList: TImageList;bAsync: boolean = True):Integer;
var
  i : Integer;
  szFileName,szTmp:string;
  iIndex : Integer;
begin
  Result := 0;
  if ImageList<>nil then
  begin
    if FDownload.State<>DS_PROCESSING then
      FDownload.Clear
    else
      if not bAsync then
      begin
        Result := -1;
        exit;
      end;
    for i:=0 to FImagesTags.Count-1 do
    begin
      szFileName := FImagesTags[i].Attributes.Values[LNEWS_IMAGES_FILENAME];
      if szFileName<>'' then
      begin
        szTmp := FImagesTags[i].Attributes.Values[LNEWS_IMAGES_INDEX];
        if szTmp<>'' then
          try
            iIndex := StrToInt(szTmp);
          except
            iIndex := 0;
          end
        else
          iIndex := 0;
        with FDownload.Add do
        begin
          Inc(Result);        
          URL:= CombineURL(FServer,FImagesBaseURL + szFileName);
          UserData := TObject(1);
          Tag := iIndex;
        end;
      end;
    end;
    if Result>0 then
      if FDownload.State<>DS_PROCESSING then
      begin
        if bAsync then
          FDownload.ThreadProcess
        else
        begin
          FDownload.OnProgress:= nil;
          FDownload.OnProcessed:= nil;
          FDownload.Process;
          FDownload.OnProgress:= DownloadProgress;
          FDownload.OnProcessed:= DownloadProcessed;
        end;
      end
      else
        FDownload.ContinueProcess;
  end;
end;

procedure TLMDWebNews.SetAutoLoadImages(const Value: Boolean);
begin
  FAutoLoadImages := Value;
end;

procedure TLMDWebNews.SetImageList(const Value: TImageList);
begin
  if FImageList=Value then
    exit;
  if FImageList<>nil then
  begin
    FImageList.RemoveFreeNotification(Self);
  end;
  FImageList:=Value;
  if FImageList<>nil then
  begin
    FImageList.FreeNotification(Self);
  end;
end;

procedure TLMDWebNews.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent=FImageList) and (Operation=opRemove) then
  begin
    FImageList := nil;
  end;
  if (Operation = opRemove) and (AComponent <> nil) and
   (AComponent = FWebConfig) then
    FWebConfig:= nil;
end;

procedure TLMDWebNews.SetCheckInternet(const Value: Boolean);
begin
  FCheckInternet := Value;
end;

function TLMDWebNews.GetOnInteractiveEvent: TLMDInternetOptionsInteractiveEvent;
begin
  Result := FIO.OnInteractiveEvent;
end;

procedure TLMDWebNews.SetOnInteractiveEvent(
  const Value: TLMDInternetOptionsInteractiveEvent);
begin
  FIO.OnInteractiveEvent := Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebNews.SetWebConfig(const Value: TLMDWebConfig);
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

procedure TLMDWebNews.UpdateFromConfig;
begin
  if FWebConfig <> nil then
      InternetOptions := FWebConfig.InternetOptions;
end;

end.
