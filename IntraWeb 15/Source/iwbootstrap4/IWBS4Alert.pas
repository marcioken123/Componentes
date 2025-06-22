unit IWBS4Alert;

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, Controls, StrUtils, IWRenderContext, IWHTMLTag,
  IWBaseHTMLControl, IWBS4Common, IWBS4ScriptEvents, IWBS4BaseContainer,
  IWBS4Color, IWBS4Typography, IWBS4CustomEvents;

type
  {$include IWPlatformAttrib.inc}
  TIWBS4Alert = class(TIWBS4BaseContainer)
  private
    FContextualClass: TIWBS4ContextualClass;
    FDismissible: Boolean; // the close button will be automatically rendered
    FHeaderType: TIWBS4HeaderClass;
    FHeaderText: string;
    FTextStrong: string;
    FTextAfterLink: string;
    FLinkHref: string;
    FLinkText: string;
    procedure SetContextualClass(const Value: TIWBS4ContextualClass);
    procedure SetHeaderType(const Value: TIWBS4HeaderClass);
    function RenderText: string;
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property ContextualClass: TIWBS4ContextualClass read FContextualClass write SetContextualClass default bs4cxSuccess;
    property Dismissible: Boolean read FDismissible write FDismissible default False;
    property HeaderType: TIWBS4HeaderClass read FHeaderType write SetHeaderType;
    property HeaderText: string read FHeaderText write FHeaderText;
    property TextStrong: string read FTextStrong write FTextStrong;
    property TextAfterLink: string read FTextAfterLink write FTextAfterLink;
    property LinkHref: string read FLinkHref write FLinkHref;
    property LinkText: string read FLinkText write FLinkText;
  end;

implementation

uses
  IWBS4NavBar, IWBS4Global;

constructor TIWBS4Alert.Create(AOwner: TComponent);
begin
  inherited;

  FContextualClass := bs4cxSuccess;
  FTagName := 'div';
end;

procedure TIWBS4Alert.InternalRenderCss(var ACss: string);
begin
  // Core class
  TIWBS4Common.AddCssClass(ACss, 'alert');
  // Contextual Class
  TIWBS4Common.AddCssClass(ACss, 'alert-' + aIWBS4ContextualClass[FContextualClass]);
  // Will need more...
  if FDismissible then
  begin
    TIWBS4Common.AddCssClass(ACss, 'alert-dismissible');
  end;
  inherited;
end;

procedure TIWBS4Alert.SetContextualClass(const Value: TIWBS4ContextualClass);
begin
  FContextualClass := Value;
  Invalidate;
end;

procedure TIWBS4Alert.SetHeaderType(const Value: TIWBS4HeaderClass);
begin
  FHeaderType := Value;
  Invalidate;
end;

function TIWBS4Alert.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  OldCss := RenderCSSClass(AContext);
  OldStyle := RenderStyle(AContext);
  OldVisible := Visible;
  FRegionDiv := TIWHTMLTag.CreateTag(FTagName);
  FRegionDiv.AddStringParam('id', HTMLName);
  FRegionDiv.AddClassParam(OldCss);
  FRegionDiv.AddStringParam('role', GetRoleString);
  FRegionDiv.AddStringParam('style', RenderStyle(AContext));
  if Text <> '' then
  begin
    FRegionDiv.Contents.AddText(RenderText);
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

function TIWBS4Alert.RenderText: string;
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
  end
  else
  begin
    // If the user uses properties that require inserting markup, then we basically treat it as RawText
    if (FTextStrong <> '') or (FLinkText <> '') then
    begin
      if FTextStrong <> '' then
      begin
        Result := '<strong>' + FTextStrong + '</strong>';
      end;
      Result := Result + ' ' + Text + ' ';
      if FLinkText <> '' then
      begin
        Result := Result + '<a href="' + FLinkHref + '" class="alert-link">' + FLinkText + '</a>';
      end;
      Result := Result + ' ' + FTextAfterLink;
      // Make sure we didn't create any double spaces
      Result := StringReplace(Result, '  ', ' ', [rfReplaceAll]);
    end
    else
    begin
      Result := TIWBaseHTMLControl.TextToHTML(Text);
    end;
  end;
end;

end.

