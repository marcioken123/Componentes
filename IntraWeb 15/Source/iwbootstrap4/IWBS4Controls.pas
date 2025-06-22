unit IWBS4Controls;

interface

{$Include IWBootstrap4.inc}

uses
  Classes, SysUtils, DB, IWControl, IWRenderContext, IWMarkupLanguageTag,
  IWHTMLTag, IWApplication, IWDBCommon, IWBS4Common, IWBS4CustomControl;

type
  TIWBS4LabelStyle = (bs4lsNone, bs4lsDefault, bs4lsPrimary, bs4lsSuccess, bs4lsInfo, bs4lsWarning, bs4lsDanger, bs4lsBadget);

const
  aIWBS4LabelStyle: array[bs4lsNone..bs4lsBadget] of string = ('', 'default', 'primary', 'success', 'info', 'warning', 'danger', 'badge');

type
  {$include IWPlatformAttrib.inc}
  TIWBS4Label = class(TIWBS4CustomDbControl)
  private
    FCaption: string;
    FForControl: TIWCustomControl;
    FRawText: Boolean;
    FOldText: string;
    FTagType: string;
    FLabelStyle: TIWBS4LabelStyle;
    function RenderLabelText: string;
    procedure SetTagType(const Value: string);
    function IsTagTypeStored: Boolean;
    procedure SetLabelStyle(const Value: TIWBS4LabelStyle);
    procedure SetCaption(const Value: string);
    procedure SetRawText(const Value: Boolean);
  protected
    procedure CheckData(AContext: TIWCompContext); override;
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure SetForControl(const Value: TIWCustomControl);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Caption: string read FCaption write SetCaption;
    property ForControl: TIWCustomControl read FForControl write SetForControl;
    property BSLabelStyle: TIWBS4LabelStyle read FLabelStyle write SetLabelStyle default bs4lsNone;
    property RawText: Boolean read FRawText write SetRawText default False;
    property TagType: string read FTagType write SetTagType stored IsTagTypeStored;
  end;

  // Probably won't need this
(*TIWBS4DescribedBy = class(TIWBS4CustomControl)
  private
    FCaption: string;
    FRawText: Boolean;
    FCss: string;
    FOldCss: string;
    FOldText: string;
    function  RenderDescriptionText: string;
    procedure SetCaption(const Value: string);
    procedure SetRawText(const Value: Boolean);
  protected
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Caption: string read FCaption write SetCaption;
    property RawText: Boolean read FRawText write SetRawText default False;
    property Css: string read FCss write FCss;
  end;*)

  {$include IWPlatformAttrib.inc}
  TIWBS4Text = class(TIWBS4CustomDbControl)
  private
    FAutoFormGroup: Boolean;
    FLines: TStringList;
    FRawText: Boolean;
    FOldText: string;
    FTagType: string;
    function RenderText: string;
    procedure OnLinesChange(ASender: TObject);
    procedure SetLines(const AValue: TStringList);
    function IsTagTypeStored: Boolean;
    procedure SetTagType(const Value: string);
    procedure SetRawText(const Value: Boolean);
    procedure SetAutoFormGroup(const Value: Boolean);
  protected
    procedure CheckData(AContext: TIWCompContext); override;
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AutoFormGroup: Boolean read FAutoFormGroup write SetAutoFormGroup default False;
    property Lines: TStringList read FLines write SetLines;
    property RawText: Boolean read FRawText write SetRawText default False;
    property TagType: string read FTagType write SetTagType stored IsTagTypeStored;
  end;

 {TIWBS4Glyphicon = class(TIWBS4CustomControl)
  private
    FGlyphicon: string;
  protected
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BSGlyphicon: string read FGlyphicon write FGlyphicon;
  end;}

  {$include IWPlatformAttrib.inc}
  TIWBS4FontAwesomeIcon = class(TIWBS4CustomControl)
  private
    FFontAwesomeIcon: string;
  protected
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property FontAwesomeIcon: string read FFontAwesomeIcon write FFontAwesomeIcon;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4GoogleMaterialIcon = class(TIWBS4CustomControl)
  private
    FGoogleMaterialIcon: string;
  protected
    procedure InternalRenderCss(var ACss: string); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property GoogleMaterialIcon: string read FGoogleMaterialIcon write FGoogleMaterialIcon;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4File = class(TIWBS4CustomControl)
  private
    FMultiple: Boolean;
    procedure SetMultiple(const Value: Boolean);
  protected
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Multiple: Boolean read FMultiple write SetMultiple default False;
  end;

implementation

uses {$IFDEF  IW_14_3_0_UP}
  IW.Common.SysTools, {$ELSE} IW.Common.System, {$ENDIF}
  IWBS4Region, IWBS4InputCommon, IWBS4CustomEvents, IWBS4InputForm, IWBS4List;

{$region 'TIWBSLabel'}
constructor TIWBS4Label.Create(AOwner: TComponent);
begin
  inherited;
  FRawText := False;
  FTagType := 'span';
  Height := 25;
  Width := 200;
end;

procedure TIWBS4Label.SetCaption(const Value: string);
begin
  FCaption := Value;
  Invalidate;
end;

procedure TIWBS4Label.SetForControl(const Value: TIWCustomControl);
begin
  FForControl := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4Label.SetLabelStyle(const Value: TIWBS4LabelStyle);
begin
  FLabelStyle := Value;
  Invalidate;
end;

procedure TIWBS4Label.SetRawText(const Value: Boolean);
begin
  FRawText := Value;
  Invalidate;
end;

procedure TIWBS4Label.SetTagType(const Value: string);
begin
  TIWBS4Common.ValidateTagName(Value);
  FTagType := Value;
  AsyncRefreshControl;
end;

function TIWBS4Label.RenderLabelText: string;
begin
  if FRawText then
    Result := Caption
  else
    Result := TextToHTML(Caption);
end;

procedure TIWBS4Label.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;
  TIWBS4Common.SetAsyncHtml(AApplication, AHTMLName, RenderLabelText, FOldText);
end;

procedure TIWBS4Label.InternalRenderCss(var ACss: string);
begin
  inherited;

  if FLabelStyle <> bs4lsNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4LabelStyle[FLabelStyle]);
  end;

  if Parent is TIWBS4List then
  begin
    TIWBS4Common.AddCssClass(ACss, 'list-group-item');
    if FLabelStyle in [bs4lsSuccess, bs4lsInfo, bs4lsWarning, bs4lsDanger] then
    begin
      TIWBS4Common.AddCssClass(ACss, 'list-group-item-' + aIWBS4LabelStyle[FLabelStyle])
    end;
  end
  else
  begin
    if FLabelStyle in [bs4lsDefault..bs4lsDanger] then
      TIWBS4Common.AddCssClass(ACss, 'label label-' + aIWBS4LabelStyle[FLabelStyle])
    else if FLabelStyle = bs4lsBadget then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4LabelStyle[FLabelStyle]);
    end;
    if Parent is TIWBS4Region then
    begin
      if TIWBS4Region(Parent).BSRegionType = bs4rtModalHeader then
      begin
        TIWBS4Common.AddCssClass(ACss, 'modal-title');
      end;
     {else if TIWBS4Region(Parent).BSRegionType = bs4rtPanelHeading then
        TIWBS4Common.AddCssClass(ACss, 'panel-title');}
    end;
  end;
end;

procedure TIWBS4Label.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;
  FOldText := RenderLabelText;

  if Assigned(FForControl) then
  begin
    AHTMLTag := TIWHTMLTag.CreateTag('label');
    AHTMLTag.AddStringParam('for', ForControl.HTMLName);
  end
  else if Parent is TIWBS4List then
  begin
    AHTMLTag := TIWHTMLTag.CreateTag('li');
  end
  else
  begin
    AHTMLTag := TIWHTMLTag.CreateTag(FTagType);
  end;
  AHTMLTag.AddStringParam('id', HTMLName);
  AHTMLTag.AddClassParam(ActiveCss);
  AHTMLTag.AddStringParam('style', ActiveStyle);
  AHTMLTag.Contents.AddText(FOldText);

  if Parent is TIWBS4InputGroup then
  begin
    AHTMLTag := IWBS4CreateInputGroupAddOn(AHTMLTag, HTMLName, 'addon');
  end;
end;

function TIWBS4Label.IsTagTypeStored: Boolean;
begin
  Result := FTagType <> 'span';
end;

procedure TIWBS4Label.CheckData(AContext: TIWCompContext);
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then
  begin
    Caption := LField.DisplayText;
  end;
end;
{$endregion}

{$region 'TIWBS4Text'}

constructor TIWBS4Text.Create(AOwner: TComponent);
begin
  inherited;
  FLines := TStringList.Create;
  FLines.OnChange := OnLinesChange;
  FRawText := False;
  FTagType := 'div';
  Height := 100;
  Width := 200;
end;

destructor TIWBS4Text.Destroy;
begin
  FLines.Free;
  inherited;
end;

procedure TIWBS4Text.OnLinesChange(ASender: TObject);
begin
  Invalidate;
  if Script.Count > 0 then
  begin
    AsyncRefreshControl;
  end;
end;

procedure TIWBS4Text.SetAutoFormGroup(const Value: Boolean);
begin
  FAutoFormGroup := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4Text.SetLines(const AValue: TStringList);
begin
  FLines.Assign(AValue);
end;

procedure TIWBS4Text.SetRawText(const Value: Boolean);
begin
  FRawText := Value;
  Invalidate;
end;

procedure TIWBS4Text.SetTagType(const Value: string);
begin
  TIWBS4Common.ValidateTagName(Value);
  FTagType := Value;
  AsyncRefreshControl;
end;

function TIWBS4Text.RenderText: string;
var
  i: Integer;
  LLines: TStringList;
begin
  if FRawText then
  begin
    LLines := TStringList.Create;
    try
      LLines.Assign(FLines);

      // replace params before custom events
      LLines.Text := TIWBS4Common.ReplaceParams(Self, LLines.Text);

      // replace inner events calls
      if IsStoredCustomAsyncEvents then
        for i := 0 to CustomAsyncEvents.Count - 1 do
          TIWBS4CustomAsyncEvent(CustomAsyncEvents.Items[i]).ParseParam(LLines);

      // replace inner events calls
      if IsStoredCustomRestEvents then
        for i := 0 to CustomRestEvents.Count - 1 do
          TIWBS4CustomRestEvent(CustomRestEvents.Items[i]).ParseParam(LLines);

      Result := LLines.Text;
    finally
      LLines.Free;
    end;
  end
  else
  begin
    Result := TextToHTML(Lines.Text);
  end;
end;

procedure TIWBS4Text.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;

  TIWBS4Common.SetAsyncHtml(AApplication, AHTMLName, RenderText, FOldText);
end;

procedure TIWBS4Text.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;

  FOldText := RenderText;

  AHTMLTag := TIWHTMLTag.CreateTag(FTagType);
  AHTMLTag.AddStringParam('id', HTMLName);
  AHTMLTag.AddClassParam(ActiveCss);
  AHTMLTag.AddStringParam('style', ActiveStyle);
  AHTMLTag.Contents.AddText(FOldText);

  if FAutoFormGroup and not (Parent is TIWBS4InputGroup) then
  begin
    AHTMLTag := IWBS4CreateInputFormGroup(Self, Parent, AHTMLTag, Caption, AHTMLName);
  end;
end;

function TIWBS4Text.IsTagTypeStored: Boolean;
begin
  Result := FTagType <> 'div';
end;

procedure TIWBS4Text.CheckData(AContext: TIWCompContext);
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then
  begin
    Lines.Text := LField.DisplayText;
  end;
end;
{$endregion}

{$region 'TIWBS4Glyphicon'}
(*constructor TIWBS4Glyphicon.Create(AOwner: TComponent);
begin
  inherited;

  Height := 25;
  Width := 25;
end;

procedure TIWBS4Glyphicon.InternalRenderCss(var ACss: string);
begin
  inherited;

  if FGlyphicon <> '' then
  begin
    TIWBS4Common.AddCssClass(ACss, 'glyphicon glyphicon-' + FGlyphicon);
  end;
end;

procedure TIWBS4Glyphicon.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;
  AHTMLTag := TIWHTMLTag.CreateTag('span');
  try
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam(ActiveCss);
    AHTMLTag.AddStringParam('style', ActiveStyle);
    if FGlyphicon <> ''
      then AHTMLTag.AddBoolParam('aria-hidden', True)
      else AHTMLTag.Contents.AddText('&times;');
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;
  if Parent is TIWBS4InputGroupOld then
  begin
    AHTMLTag := IWBS4CreateInputGroupAddOn(AHTMLTag, AHTMLName, 'addon');
  end;
end;*)
{$endregion}

{$region 'TIWBS4FontAwesomeIcon'}

constructor TIWBS4FontAwesomeIcon.Create(AOwner: TComponent);
begin
  inherited;

  Height := 25;
  Width := 25;
end;

procedure TIWBS4FontAwesomeIcon.InternalRenderCss(var ACss: string);
begin
  inherited;

  if FFontAwesomeIcon <> '' then
  begin
    TIWBS4Common.AddCssClass(ACss, 'fa ' + FFontAwesomeIcon);
  end;
end;

procedure TIWBS4FontAwesomeIcon.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;
  AHTMLTag := TIWHTMLTag.CreateTag('span');
  try
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam(ActiveCss);
    AHTMLTag.AddStringParam('style', ActiveStyle);
    if FFontAwesomeIcon <> '' then
      AHTMLTag.AddBoolParam('aria-hidden', True)
    else
      AHTMLTag.Contents.AddText('&times;');
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;
  if Parent is TIWBS4InputGroup then
  begin
    AHTMLTag := IWBS4CreateInputGroupAddOn(AHTMLTag, AHTMLName, 'addon');
  end;
end;
{$endregion}

{$region 'TIWBS4GoogleMaterialIcon'}

constructor TIWBS4GoogleMaterialIcon.Create(AOwner: TComponent);
begin
  inherited;

  Height := 25;
  Width := 25;
end;

procedure TIWBS4GoogleMaterialIcon.InternalRenderCss(var ACss: string);
begin
  inherited;

  if FGoogleMaterialIcon <> '' then
  begin
    TIWBS4Common.AddCssClass(ACss, 'material-icons' + FGoogleMaterialIcon);
  end;
end;

procedure TIWBS4GoogleMaterialIcon.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;
  AHTMLTag := TIWHTMLTag.CreateTag('span');
  try
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam(ActiveCss);
    AHTMLTag.AddStringParam('style', ActiveStyle);
    if FGoogleMaterialIcon <> '' then
      AHTMLTag.AddBoolParam('aria-hidden', True)
    else
      AHTMLTag.Contents.AddText('&times;');
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;
  if Parent is TIWBS4InputGroup then
  begin
    AHTMLTag := IWBS4CreateInputGroupAddOn(AHTMLTag, AHTMLName, 'addon');
  end;
end;
{$endregion}

{$region 'TIWBS4File' }

constructor TIWBS4File.Create(AOwner: TComponent);
begin
  inherited;

  FMultiple := False;
  Height := 25;
  Width := 121;
end;

procedure TIWBS4File.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;

  AHTMLTag := TIWHTMLTag.CreateTag('input');
  try
    AHTMLTag.AddClassParam(ActiveCss);
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddStringParam('name', AHTMLName + iif(FMultiple, '[]'));
    AHTMLTag.AddStringParam('type', 'file');
    if ShowHint and (Hint <> '') then
    begin
      AHTMLTag.AddStringParam('title', Hint);
    end;
    if FMultiple then
    begin
      AHTMLTag.Add('multiple');
    end;

//  if AutoFocus then
//    AHTMLTag.Add('autofocus');
//  if IsReadOnly then
//    AHTMLTag.Add('readonly');
    if IsDisabled then
    begin
      AHTMLTag.Add('disabled');
    end;
//  AHTMLTag.AddStringParam('value', TextToHTML(FText));
//  if Required then
//    AHTMLTag.Add('required');
//  if PlaceHolder <> '' then
//    AHTMLTag.AddStringParam('placeholder', TextToHTML(PlaceHolder));
    AHTMLTag.AddStringParam('style', ActiveStyle);
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;

  AHTMLTag := IWBS4CreateFormGroup(Parent, IWBS4FindParentInputForm(Parent), AHTMLTag, AHTMLName, True);
end;

procedure TIWBS4File.SetMultiple(const Value: Boolean);
begin
  FMultiple := Value;
  AsyncRefreshControl;
end;

{constructor TIWBS4DescribedBy.Create(AOwner: TComponent);
begin
  inherited;
  FRawText := False;
  Height := 25;
  Width := 200;
end;

function TIWBS4DescribedBy.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := ''; //FGridOptions.GetClassString;
  if FCss <> '' then
  begin
    if Result <> '' then
    begin
      Result := Result + ' ';
    end;
    Result := Result + FCss;
  end;
  InternalRenderCss(Result);
end;

function TIWBS4DescribedBy.RenderDescriptionText: string;
begin
  if FRawText
    then Result := Caption
    else Result := TextToHTML(Caption);
end;

procedure TIWBS4DescribedBy.SetCaption(const Value: string);
begin
  FCaption := Value;
  Invalidate;
end;

procedure TIWBS4DescribedBy.SetRawText(const Value: Boolean);
begin
  FRawText := Value;
  Invalidate;
end;

procedure TIWBS4DescribedBy.InternalRenderCss(var ACss: string);
begin
  inherited;

  TIWBS4Common.AddCssClass(ACss, 'form-text text-muted');
end;

procedure TIWBS4DescribedBy.InternalRenderHTML(const AHTMLName: string;
  AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;

  FOldText := RenderDescriptionText;
  FOldCss := RenderCSSClass(AContext);

  AHTMLTag := TIWHTMLTag.CreateTag('small');
  AHTMLTag.AddStringParam('id', HTMLName);
  AHTMLTag.AddClassParam(FOldCss);
  AHTMLTag.Contents.AddText(FOldText);
end;}

end.

