unit IWBS4Progress;
// Todo: make fully accessible

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, Controls, StrUtils, IWRenderContext, IWHTMLTag,
  IWBaseHTMLControl, IWBS4Common, IWBS4ScriptEvents, IWBS4BaseContainer,
  IWBS4Color, IWBS4Typography, IWBS4CustomEvents;

type
  TIWBS4ProgressBars = class;

  TIWBS4Progress = class;

  TIWBS4ProgressBar = class(TCollectionItem)
  private
    FBackgroundContextual: TIWBS4Background;
    FProgressPercent: Integer;
    FAnimated: Boolean;
    FStriped: Boolean;
    FText: string;
    FCss: string;
    FProgressBars: TIWBS4ProgressBars;
    function GetProgress: TIWBS4Progress;
    function GetProgressBars: TIWBS4ProgressBars;
    procedure SetProgressBars(const Value: TIWBS4ProgressBars);
    procedure SetBackgroundContextual(const Value: TIWBS4Background);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property Progress: TIWBS4Progress read GetProgress;
  published
    property BackgroundContextual: TIWBS4Background read FBackgroundContextual write SetBackgroundContextual default bs4bgNone;
    property ProgressPercent: Integer read FProgressPercent write FProgressPercent default 0;
    property Animated: Boolean read FAnimated write FAnimated;
    property Striped: Boolean read FStriped write FStriped default False;
    property Text: string read FText write FText;
    property Css: string read FCss write FCss;
    property ProgressBars: TIWBS4ProgressBars read GetProgressBars write SetProgressBars;
  end;

  TIWBS4ProgressBars = class(TOwnedCollection)
  private
    FOwner: TIWBS4Progress;
    function GetProgressBar(Idx: Integer): TIWBS4ProgressBar;
    procedure SetProgressBar(Idx: Integer; const Value: TIWBS4ProgressBar);
  public
    function CreateItemClass: TCollectionItemClass; virtual;
    constructor Create(AOwner: TComponent);
    function GetOwner: TPersistent; override;
    procedure Update(AItem: TCollectionItem); override;
    function Add: TIWBS4ProgressBar;
    property Progressbars[Idx: Integer]: TIWBS4ProgressBar read GetProgressBar write SetProgressBar; default;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4Progress = class(TIWBS4BaseContainer)
  private
    FProgressBars: TIWBS4ProgressBars;
    FHeightRender: Boolean; // defaults to 16px, set this to use the Height property as the Height of the Progress Bar
  //function RenderText: string;
    procedure SetProgressBars(const Value: TIWBS4ProgressBars);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property ProgressBars: TIWBS4ProgressBars read FProgressBars write SetProgressBars;
    property HeightRender: Boolean read FHeightRender write FHeightRender default False;
  end;

implementation

uses
  IWBS4NavBar, IWBS4Global;

constructor TIWBS4Progress.Create(AOwner: TComponent);
begin
  inherited;

  FTagName := 'div';

  // Progress Bars (they can be stacked, hence the need for a collection)
  FProgressBars := TIWBS4ProgressBars.Create(Self);
end;

destructor TIWBS4Progress.Destroy;
begin
  FProgressBars.Free;
  inherited;
end;

procedure TIWBS4Progress.InternalRenderCss(var ACss: string);
begin
  // Core class
  TIWBS4Common.AddCssClass(ACss, 'progress');
end;

procedure TIWBS4ProgressBar.SetBackgroundContextual(const Value: TIWBS4Background);
begin
  FBackgroundContextual := Value;
//Progress.Invalidate;
end;

procedure TIWBS4Progress.SetProgressBars(const Value: TIWBS4ProgressBars);
begin
  if Value = nil then
    FreeAndNil(FProgressBars)
  else
    FProgressBars.Assign(Value);
end;

function TIWBS4Progress.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  ItemTag: TIWHTMLTag;
  i: Integer;
  Styl: string;
  ItemStyle: string;
begin
  OldCss := RenderCSSClass(AContext);
  OldStyle := RenderStyle(AContext);
  OldVisible := Visible;
  // See if Height must be used
  Styl := '';
  if FHeightRender then
  begin

  //OldStyle := OldStyle + 'height:' + IntToStr(Height) + 'px;';
    Styl := 'height:' + IntToStr(Height) + 'px;';
  end;
  FRegionDiv := TIWHTMLTag.CreateTag(FTagName);
  FRegionDiv.AddClassParam('progress');
  FRegionDiv.AddStringParam('id', HTMLName);
  FRegionDiv.AddClassParam(OldCss);
  FRegionDiv.AddStringParam('style', RenderStyle(AContext) + Styl);
  // Render the Items
  for i := 0 to FProgressBars.Count - 1 do
  begin
    ItemTag := FRegionDiv.Contents.AddTag('div');
    ItemTag.AddClassParam('progress-bar');

    ItemStyle := 'width:' + IntToStr(FProgressBars[i].FProgressPercent) + '%;';
    if FHeightRender then
    begin
      ItemStyle := ItemStyle + 'height:' + IntToStr(Height) + 'px;';
    end;
    ItemTag.AddStringParam('style', ItemStyle);

    // Animated
    if FProgressBars[i].FAnimated then
    begin
      ItemTag.AddClassParam('progress-bar-animated');
    end;

    // Striped
    if FProgressBars[i].FStriped then
    begin
      ItemTag.AddClassParam('progress-bar-striped');
    end;

    // Contextual Class
    if FProgressBars[i].FBackgroundContextual <> bs4bgNone then
    begin

      ItemTag.AddClassParam('bg-' + aIWBS4Background[FProgressBars[i].FBackgroundContextual]);

    end;
    // This is the actual text that shows in the middle of the progress bar, usually something like "40%"
    //ItemTag.Contents.AddText(RenderText);
    // If no Text provided, default to percentage
    if FProgressBars[i].FText = '' then
      ItemTag.Contents.AddText(IntToStr(FProgressBars[i].FProgressPercent) + '%')
    else
      ItemTag.Contents.AddText(FProgressBars[i].FText);
  end;
  IWBS4RenderScript(Self, AContext, FRegionDiv);
  FMainID := FRegionDiv.Params.Values['id'];
  if gIWBS4AttributeCmpName <> '' then
  begin
    FRegionDiv.Params.Values[gIWBS4AttributeCmpName] := name;
  end;
  Result := FRegionDiv;
  AsyncRefreshControlYesOrNo := False;
  Rendered := True;
end;
{function TIWBS4Progress.RenderText: string;
var
  i: Integer;
  LLines: TStringList;
begin
  if RawText then
  begin
    LLines := TStringList.Create;
    try
      LLines.Text := Text;
      // replace params before custom events
      LLines.Text := TIWBS4Common.ReplaceParams(Self, LLines.Text);
      // replace inner events calls
      if IsStoredCustomAsyncEvents then
      begin
        for i := 0 to CustomAsyncEvents.Count - 1 do
        begin
          TIWBS4CustomAsyncEvent(CustomAsyncEvents.Items[i]).ParseParam(LLines);
        end;
      end;
      // replace inner events calls
      if IsStoredCustomRestEvents then
      begin
        for i := 0 to CustomRestEvents.Count - 1 do
        begin
          TIWBS4CustomRestEvent(CustomRestEvents.Items[i]).ParseParam(LLines);
        end;
      end;
      Result := LLines.Text;
    finally
      LLines.Free;
    end;
  end else
  begin
    Result := TIWBaseHTMLControl.TextToHTML(Text);
  end;
end;}

procedure TIWBS4ProgressBar.Assign(Source: TPersistent);
begin
  if Source is TIWBS4ProgressBar then
  begin
    Text := TIWBS4ProgressBar(Source).Text;
    Css := TIWBS4ProgressBar(Source).Css;
  end
  else
  begin
    inherited;
  end;
end;

constructor TIWBS4ProgressBar.Create(Collection: TCollection);
begin
  inherited;
  FBackgroundContextual := bs4bgNone;
  FProgressPercent := 0;
  FStriped := False;
end;

function TIWBS4ProgressBar.GetDisplayName: string;
begin
  if FText <> '' then
    Result := FText
  else
    Result := 'TIWBS4ProgressBar' + IntToStr(Index);
end;

function TIWBS4ProgressBar.GetProgress: TIWBS4Progress;
begin
  Result := TIWBS4ProgressBars(Collection).FOwner;
end;

function TIWBS4ProgressBar.GetProgressBars: TIWBS4ProgressBars;
begin
  // Lazy create
  if not Assigned(FProgressBars) then
  begin
    FProgressBars := TIWBS4ProgressBars.Create(Progress);
  end;

  Result := FProgressBars;
end;

procedure TIWBS4ProgressBar.SetProgressBars(const Value: TIWBS4ProgressBars);
begin
  FProgressBars := Value;
end;

function TIWBS4ProgressBars.Add: TIWBS4ProgressBar;
begin
  Result := TIWBS4ProgressBar(inherited Add);
end;

constructor TIWBS4ProgressBars.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TIWBS4ProgressBar);
//FOwner := AOwner;
end;

function TIWBS4ProgressBars.CreateItemClass: TCollectionItemClass;
begin
  Result := TIWBS4ProgressBar;
end;

function TIWBS4ProgressBars.GetProgressBar(Idx: Integer): TIWBS4ProgressBar;
begin
  Result := TIWBS4ProgressBar(inherited Items[Idx]);
end;

procedure TIWBS4ProgressBars.SetProgressBar(Idx: Integer; const Value: TIWBS4ProgressBar);
begin
  Items[Idx] := Value;
end;

function TIWBS4ProgressBars.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TIWBS4ProgressBars.Update(AItem: TCollectionItem);
{var
  S: string;
  i: Integer;}
begin
  inherited;
 {S := '';
  for i := 0 to Count - 1 do
  begin
    S := (AItem as TIWBS4ProgressBar).Text + ',  ';
  end;
  if System.Length(S) > 1 then
  begin
    System.Delete(S, Length(S) - 1, 2);
  end;
  FCollectionString := S;}
end;

end.

