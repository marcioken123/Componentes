unit IWBS4BlockText;
(** Notes:
     > Need to handle the <small> tag that can now be embedded in headers
**)

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, Controls, StrUtils, IWRenderContext, IWXMLTag, IWBS4Common,
  IWBS4Color, IWBS4Typography, IWBS4CustomRegion;

type
  TIWBS4BlockTextTagType = (bs4bttH1, bs4bttH2, bs4bttH3, bs4bttH4, bs4bttH5, bs4bttH6, bs4bttP, bs4bttPre);

const
  aIWBS4BlockTextTagType: array[bs4bttH1..bs4bttPre] of string = ('h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'pre');

type
  {$include IWPlatformAttrib.inc}
  TIWBS4BlockText = class(TIWBS4CustomRegion)
  private
    FBackground: TIWBS4Background;
    FTagType: TIWBS4BlockTextTagType;
    FHeaderClass: TIWBS4HeaderClass;     // h1..h6 as classes, not tags
    FHeaderDisplay: TIWBS4HeaderDisplay; // display-1, display-2, etc
    FTextAlignment: TIWBS4TextAlignment; // text-center, text-right, etc
    FTextTransform: TIWBS4TextTransform; // lowercase, uppercase, capitalized
    FTextOptions: TIWBS4TextOptions;     // italic, monospace, nowrap, truncate (set of bool)
    FTextColor: TIWBS4TextColor;         // text-primary, text-warning, etc
    FFontWeight: TIWBS4FontWeight;
    FLead: Boolean;
    FCardTitle: Boolean;
    FCardText: Boolean;
    procedure SetBackground(AValue: TIWBS4Background);
    procedure SetTagType(const Value: TIWBS4BlockTextTagType);
    procedure SetTextOptions(const AValue: TIWBS4TextOptions);
  protected
    procedure InternalRenderCss(var ACss: string); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetRoleString: string; override;
    procedure AsyncRefreshControl;
  published
    property BSBackground: TIWBS4Background read FBackground write SetBackground default bs4bgNone;
    property TagType: TIWBS4BlockTextTagType read FTagType write SetTagType default bs4bttP;
    property HeaderClass: TIWBS4HeaderClass read FHeaderClass write FHeaderClass default bs4hcNone;
    property HeaderDisplay: TIWBS4HeaderDisplay read FHeaderDisplay write FHeaderDisplay default bs4hdNone;
    property TextAlignment: TIWBS4TextAlignment read FTextAlignment write FTextAlignment default bs4taNone;
    property TextTransform: TIWBS4TextTransform read FTextTransform write FTextTransform default bs4xfNone;
    property TextOptions: TIWBS4TextOptions read FTextOptions write SetTextOptions;
    property TextColor: TIWBS4TextColor read FTextColor write FTextColor default bs4tcNone;
    property FontWeight: TIWBS4FontWeight read FFontWeight write FFontWeight default bs4fwNone;
    property Lead: Boolean read FLead write FLead default False;
    property CardTitle: Boolean read FCardTitle write FCardTitle default False;
    property CardText: Boolean read FCardText write FCardText default False;
  end;

  // No need for a separate unit for this class
  {$include IWPlatformAttrib.inc}
  TIWBS4Blockquote = class(TIWBS4CustomRegion)
  private
    FBackground: TIWBS4Background;
    FTextAlignment: TIWBS4TextAlignment; // text-center, text-right, etc
    procedure SetBackground(AValue: TIWBS4Background);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetRoleString: string; override;
  published
    property BSBackground: TIWBS4Background read FBackground write SetBackground default bs4bgNone;
    property TextAlignment: TIWBS4TextAlignment read FTextAlignment write FTextAlignment default bs4taNone;
  end;

implementation

uses
  IWBS4NavBar;

constructor TIWBS4BlockText.Create(AOwner: TComponent);
begin
  inherited;

  FTagType := bs4bttP;
  FTagName := 'p';
  FBackground := bs4bgNone;
  FHeaderClass := bs4hcNone;
  FHeaderDisplay := bs4hdNone;
  FTextAlignment := bs4taNone;
  FTextColor := bs4tcNone;
  FTextOptions := [];
end;

procedure TIWBS4BlockText.InternalRenderCss(var ACss: string);
begin
//TIWBS4Common.AddCssClass(ACss, aIWBS4BlockTextTagType[FTagType]);
  // Header classes (only applies to headers)
  if (FTagType = bs4bttH1) or (FTagType = bs4bttH2) or (FTagType = bs4bttH3) or (FTagType = bs4bttH4) or (FTagType = bs4bttH5) or (FTagType = bs4bttH6) then
  begin
    if FHeaderClass <> bs4hcNone then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4HeaderClass[FHeaderClass]);
    end;
  end;
  // New "display" classes (only applies to headers)
  if (FTagType = bs4bttH1) or (FTagType = bs4bttH2) or (FTagType = bs4bttH3) or (FTagType = bs4bttH4) or (FTagType = bs4bttH5) or (FTagType = bs4bttH6) then
  begin
    if FHeaderDisplay <> bs4hdNone then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4HeaderDisplay[FHeaderDisplay]);
    end;
  end;
  // This is actually the style
  if FBackground <> bs4bgNone then
  begin
    TIWBS4Common.AddCssClass(ACss, 'bg-' + aIWBS4Background[FBackground]);
  end;
  // Text Alignment
  if FTextAlignment <> bs4taNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4TextAlignment[FTextAlignment]);
  end;

  // Text Color
  if FTextColor <> bs4tcNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4TextColor[FTextColor]);
  end;

  // Lead flag for paragraphs
  if FTagType = bs4bttP then
  begin
    if FLead then
    begin
      TIWBS4Common.AddCssClass(ACss, 'lead');
    end;
  end;
  // Font weight
  if FTagType = bs4bttP then
  begin
    if FFontWeight <> bs4fwNone then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4FontWeight[FFontWeight]);
    end;
  end;
  // Text Transform
  if FTagType = bs4bttP then
  begin
    if FTextTransform <> bs4xfNone then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4TextTransform[FTextTransform]);
    end;
  end;

  // Text Options
  if FTagType = bs4bttP then
  begin
    if bs4toFontItalic in FTextOptions then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4TextOptions[bs4toFontItalic]);
    end;
    if bs4toMonospace in FTextOptions then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4TextOptions[bs4toMonospace]);
    end;
    if bs4toNoWrap in FTextOptions then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4TextOptions[bs4toNoWrap]);
    end;
    if bs4toTruncate in FTextOptions then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4TextOptions[bs4toTruncate]);
    end;
  end;
  // Card Title -- only applies to headers, as far as I can tell right now. Research to see if can be applied to a <p>
  if FTagType <> bs4bttP then
  begin
    if FCardTitle then
    begin
      TIWBS4Common.AddCssClass(ACss, 'card-title');
    end;
  end;

  // Card Text -- only applies to <p>
  if FTagType = bs4bttP then
  begin
    if FCardText then
    begin
      TIWBS4Common.AddCssClass(ACss, 'card-text');
    end;
  end;

  inherited;
end;

function TIWBS4BlockText.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
begin
  Result := inherited;
end;

function TIWBS4BlockText.GetRoleString: string;
begin
  Result := '';
end;

procedure TIWBS4BlockText.SetTagType(const Value: TIWBS4BlockTextTagType);
begin
  FTagType := Value;
  FTagName := aIWBS4BlockTextTagType[Value];
  AsyncRefreshControl;
end;

procedure TIWBS4BlockText.SetBackground(AValue: TIWBS4Background);
begin
  FBackground := AValue;
  Invalidate;
end;

procedure TIWBS4BlockText.SetTextOptions(const AValue: TIWBS4TextOptions);
begin
  FTextOptions := AValue;
  Invalidate;
end;

procedure TIWBS4BlockText.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

constructor TIWBS4Blockquote.Create(AOwner: TComponent);
begin
  inherited;

  FTagName := 'blockquote';
  FTextAlignment := bs4taNone;
end;

procedure TIWBS4Blockquote.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, 'blockquote');
  // This is actually the style
  if FBackground <> bs4bgNone then
  begin
    TIWBS4Common.AddCssClass(ACss, 'bg-' + aIWBS4Background[FBackground]);
  end;
  // Text Alignment
  if FTextAlignment <> bs4taNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4TextAlignment[FTextAlignment]);
  end;

  inherited;
end;

function TIWBS4Blockquote.GetRoleString: string;
begin
  Result := '';
end;

procedure TIWBS4Blockquote.SetBackground(AValue: TIWBS4Background);
begin
  FBackground := AValue;
  Invalidate;
end;

end.

