unit IWBS4Image;

interface
{$Include IWBootstrap4.inc}

uses
  Classes, SysUtils, StrUtils, Graphics, Db, IWApplication, IWRenderContext,
  IWHTMLTag, IWBS4CustomControl;

type
  TIWBS4ImageOption = (bs4imResponsive, bs4imCircle, bs4imRounded, bs4imThumbnail);

  TIWBS4ImageOptions = set of TIWBS4ImageOption;
  {$include IWPlatformAttrib.inc}
  TIWBS4Image = class(TIWBS4CustomDbControl)
  private
    FActiveSrc: string;
    FOldSrc: string;

    FAltText: string;
    FAutoFormGroup: Boolean;
    FEmbedBase64: Boolean;
    FImageFile: string;
    FImageOptions: TIWBS4ImageOptions;
    FPerfectCenter: Boolean;
    FImageSrc: string;
    FMimeType: string;
    FPicture: TPicture;
    FUseSize: Boolean;
    procedure SetImageFile(const AValue: string);
    procedure SetImageSrc(const AValue: string);
    function GetPicture: TPicture;
    procedure SetPicture(AValue: TPicture);
    procedure SetUseSize(const AValue: Boolean);
  protected
    procedure CheckData(AContext: TIWCompContext); override;
    procedure PictureChanged(ASender: TObject);
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InternalRenderStyle(AStyle: TStringList); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ActiveSrc: string read FActiveSrc;
    procedure Refresh;
    function GetFixedFilePath: string;
  published
    property AltText: string read FAltText write FAltText;
    property AutoFormGroup: Boolean read FAutoFormGroup write FAutoFormGroup default False;
    property BSImageOptions: TIWBS4ImageOptions read FImageOptions write FImageOptions default[bs4imResponsive];
    property PerfectCenter: Boolean read FPerfectCenter write FPerfectCenter default False;
    property EmbedBase64: Boolean read FEmbedBase64 write FEmbedBase64 default False;
    property Enabled default True;
    property ImageFile: string read FImageFile write SetImageFile;
    property ImageSrc: string read FImageSrc write SetImageSrc;
    property MimeType: string read FMimeType write FMimeType;
    property Picture: TPicture read GetPicture write SetPicture;
    property UseSize: Boolean read FUseSize write SetUseSize default False;
  end;

implementation

uses
  IWTypes, IWForm, IWAppCache, IW.CacheStream, IWVCLBaseControl, //inline
  IWDbCommon, IWURL, IWFilePath, IWGlobal, InCoderMIME, IWBS4Common, IWBS4Utils,
  IWBS4ImageUtils, IWBS4InputCommon, IWBS4InputForm;

constructor TIWBS4Image.Create(AOwner: TComponent);
begin
  inherited;
  FAltText := '';
  ImageFile := '';
  FImageOptions := [bs4imResponsive];
  FPerfectCenter := False;
  ImageSrc := '';
  FMimeType := '';
  FPicture := nil;
  FUseSize := False;
  FFriendlyName := '-';
  Width := 89;
  Height := 112;
end;

destructor TIWBS4Image.Destroy;
begin
  FreeAndNil(FPicture);
  inherited;
end;

function TIWBS4Image.GetPicture: TPicture;
begin
  if not Assigned(FPicture) then
  begin
    FPicture := TPicture.Create;
    FPicture.OnChange := PictureChanged;
  end;
  Result := FPicture;
end;

procedure TIWBS4Image.SetImageFile(const AValue: string);
begin
  FImageFile := AValue;
  FActiveSrc := '';
  Invalidate;
end;

procedure TIWBS4Image.SetImageSrc(const AValue: string);
begin
  FImageSrc := AValue;
  FActiveSrc := '';
  Invalidate;
end;

procedure TIWBS4Image.SetPicture(AValue: TPicture);
begin
  Picture.Assign(AValue);
  FActiveSrc := '';
end;

procedure TIWBS4Image.PictureChanged(ASender: TObject);
begin
  if not IsLoading then
  begin
    FActiveSrc := '';
    Invalidate;
  end;
end;

procedure TIWBS4Image.SetUseSize(const AValue: Boolean);
begin
  if FUseSize <> AValue then
  begin
    FUseSize := AValue;
    Invalidate;
  end;
end;

procedure TIWBS4Image.Refresh;
begin
  FActiveSrc := '';
  Invalidate;
end;

function TIWBS4Image.GetFixedFilePath: string;
begin
  if not TFilePath.IsAbsolute(FImageFile) and Assigned(gSC) then
  begin
    Result := TFilePath.Concat(gSC.ContentPath, FImageFile);
    if not FileExists(Result) then
    begin
      Result := FImageFile;
    end;
  end
  else
  begin
    Result := FImageFile;
  end;
end;

procedure TIWBS4Image.CheckData(AContext: TIWCompContext);
var
  LField: TField;
  LMimeType: string;
  LFile: string;
  LStream: TStream;
  LFileStream: TFileStream;
  LParentForm: TIWForm;
begin
  LFile := '';

  if FMimeType <> '' then
    LMimeType := FMimeType
  else
    LMimeType := 'image';

  // if there is field data we show it, if not we fallback to other sources
  if CheckDataSource(DataSource, DataField, LField) then
  begin
    FActiveSrc := '';
    if Assigned(FPicture) then
    begin
      FPicture.Graphic := nil;
    end;

    if (LField is TBlobField) and not LField.IsNull then
    begin
      LStream := IWBS4GetFieldBlobStream(DataSource.DataSet, TBlobField(LField));
      try
        if FEmbedBase64 then
          FActiveSrc := 'data:image;base64, ' + TIdEncoderMIME.EncodeStream(LStream)
        else
        begin
          LFile := TIWAppCache.NewTempFileName;
          LFileStream := TFileStream.Create(LFile, fmCreate);
          try
            LFileStream.CopyFrom(LStream, LStream.Size - LStream.Position);
          finally
            LFileStream.Free;
          end;
          FActiveSrc := TIWAppCache.AddFileToCache(AContext.WebApplication, LFile, LMimeType);
        end;
      finally
        LStream.Free;
      end;
    end;
  end;

  if FActiveSrc = '' then
  begin
    if Assigned(FPicture) and Assigned(FPicture.Graphic) and (not FPicture.Graphic.Empty) then
    begin
      if FEmbedBase64 then
      begin
        LStream := TMemoryStream.Create;
        try
          FPicture.Graphic.SaveToStream(LStream);
          LStream.Position := 0;
          FActiveSrc := 'data:image;base64, ' + TIdEncoderMIME.EncodeStream(LStream)
        finally
          LStream.Free;
        end;
      end
      else
      begin
        LFile := TIWAppCache.NewTempFileName;
        FPicture.SaveToFile(LFile);
      end;
    end
    else if FImageFile <> '' then
    begin
      LFile := GetFixedFilePath
    end
    else if FImageSrc <> '' then
    begin
      if AnsiStartsStr('//', FImageSrc) or AnsiContainsStr('://', FImageSrc) then
        FActiveSrc := FImageSrc
      else
        FActiveSrc := TURL.MakeValidFileUrl(AContext.WebApplication.AppUrlBase, FImageSrc);
    end;

    if LFile <> '' then
    begin
      LParentForm := TIWForm.FindParentForm(Self);
      if LParentForm <> nil then
        FActiveSrc := TIWAppCache.AddFileToCache(LParentForm, LFile, LMimeType, ctForm)
      else
        FActiveSrc := TIWAppCache.AddFileToCache(AContext.WebApplication, LFile, LMimeType);
    end;
  end;
end;

procedure TIWBS4Image.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;

  if FActiveSrc <> FOldSrc then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + AHTMLName + '").attr("src","' + FActiveSrc + '");', False, True);
    FOldSrc := FActiveSrc;
  end;
end;

procedure TIWBS4Image.InternalRenderCss(var ACss: string);
begin
  if bs4imResponsive in FImageOptions then
  begin
    TIWBS4Common.AddCssClass(ACss, 'img-fluid');
  end;
  if bs4imCircle in FImageOptions then
  begin
    TIWBS4Common.AddCssClass(ACss, 'rounded-circle');
  end;
  if bs4imRounded in FImageOptions then
  begin
    TIWBS4Common.AddCssClass(ACss, 'rounded');
  end;
  if bs4imThumbnail in FImageOptions then
  begin
    TIWBS4Common.AddCssClass(ACss, 'img-thumbnail');
  end;

  if FPerfectCenter then
  begin
    TIWBS4Common.AddCssClass(ACss, 'mx-auto d-block');
  end;

  inherited;
end;

procedure TIWBS4Image.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;

  FOldSrc := FActiveSrc;

  AHTMLTag := TIWHTMLTag.CreateTag('img');
  AHTMLTag.AddClassParam(ActiveCss);
  AHTMLTag.AddStringParam('id', AHTMLName);
  AHTMLTag.AddStringParam('style', ActiveStyle);
  AHTMLTag.AddStringParam('src', FActiveSrc);
  if AltText <> '' then
    AHTMLTag.AddStringParam('alt', AltText, True)
  else
    AHTMLTag.AddStringParam('alt', FActiveSrc, True);
  if not AutoSize then
  begin
    AHTMLTag.AddIntegerParam('width', Width);
    AHTMLTag.AddIntegerParam('height', Height);
  end;
  if not Enabled then
  begin
    AContext.AddToInitProc('setEnabled("' + HTMLName + '", false);');
  end;

  if FAutoFormGroup and not (Parent is TIWBS4InputGroup) then
  begin
    AHTMLTag := IWBS4CreateInputFormGroup(Self, Parent, AHTMLTag, Caption, AHTMLName);
  end;
end;

procedure TIWBS4Image.InternalRenderStyle(AStyle: TStringList);
begin
  inherited;

  if Assigned(FOnAsyncClick) and (Cursor = crAuto) then
  begin
    AStyle.Values['cursor'] := 'pointer';
  end;
end;

end.

