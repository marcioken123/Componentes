unit IWBS4Tooltip;

interface

uses SysUtils, Classes;

type
  // Tooltip Placement
  TIWBS4TooltipPlacement = (bs4tpTop, bs4tpBottom, bs4tpLeft, bs4tpRight, bs4tpAuto);
{const
  aIWBS4TooltipPlacement: array[bs4tpTop..bs4tpAuto] of string =
    ('top', 'bottom', 'left', 'right', 'auto');}
type
  TJSTooltip = class(TPersistent)
  private
    // Internal use only, used to decide whether or not to render the tooltip
    FEnabled: Boolean;
    // The rest of the fields are attributes of the tooltip, others can be added later
    FTitle: string;
    FTitleIsHTML: Boolean;
    FFade: Boolean;
    FPlacement: TIWBS4TooltipPlacement;
   {FDelayShow: Integer;  // to be implemented later via JavaScript
    FDelayHide: Integer;}
    // As an attribute you can set a number which will control both the show and the hide
    FDelay: Integer;
    FTrigger: string;
    FOffset: Integer;
    procedure SetDelay(const Value: Integer);
    procedure SetTrigger(const Value: string);
  public
    constructor Create;
    function GetAttributeString: string;
  published
    property Enabled: Boolean read FEnabled write FEnabled default False;
    property Title: string read FTitle write FTitle;
    property TitleIsHTML: Boolean read FTitleIsHTML write FTitleIsHTML default False;
    property Fade: Boolean read FFade write FFade default False;
    property Placement: TIWBS4TooltipPlacement read FPlacement write FPlacement default bs4tpAuto;
   {property DelayShow: Integer read FDelayShow write FDelayShow default 0;
    property DelayHide: Integer read FDelayHide write FDelayHide default 0;}
    property Delay: Integer read FDelay write SetDelay;
    property Trigger: string read FTrigger write SetTrigger;
    property Offset: Integer read FOffset write FOffset default 0;
  end;

implementation

constructor TJSTooltip.Create;
begin
  inherited;
  FEnabled := False;
  FPlacement := bs4tpAuto;
 {FDelayShow := 0;
  FDelayHide := 0;}
  FDelay :=  0;
  FTrigger := 'focus hover';
  FOffset := 0;
end;

function TJSTooltip.GetAttributeString: string;
begin
  // Thought about raising an error if no title, but someone might want
  // an empty tooltip that will be manipulated via JS (empty title will never be shown)

  // All tooltips require these:
  Result := 'data-toggle="tooltip" title="' + FTitle + '"';

  // HTML in Title
  if FTitleIsHTML then
  begin
    Result := Result + ' data-html="true"';
  end;

  // Trigger
  Result := Result + ' data-trigger="' + FTrigger + '"';

  // Placement
  case FPlacement of
    bs4tpTop:    Result := Result + ' data-placement="top"';
    bs4tpBottom: Result := Result + ' data-placement="bottom"';
    bs4tpLeft:   Result := Result + ' data-placement="left"';
    bs4tpRight:  Result := Result + ' data-placement="right"';
    bs4tpAuto:   Result := Result + ' data-placement="auto"';
  end;

  // Fade
  if FFade then
  begin
    Result := Result + ' data-animation="true"';
  end;

  // Cannot get Delay to work declaratively
  // Delay
(*if (FDelayShow > 0) or (FDelayHide > 0) then
  begin
    Result := Result + ' delay={';
    if FDelayShow > 0 then
    begin
      Result := Result + '"show": ' + IntToStr(FDelayShow);
    end;
    if FDelayHide > 0 then
    begin
      if FDelayShow > 0 then
      begin
        Result := Result + ',';
      end;
      Result := Result + '"hide": ' + IntToStr(FDelayHide);
    end;
    Result := Result + '}';
  end;*)

  // Delay
  if FDelay > 0 then
  begin
    Result := Result + ' data-delay="' + IntToStr(FDelay) + '"';
  end;

  // Offset
  if FOffset <> 0 then
  begin
    Result := Result + ' offset="' + IntToStr(FOffset) + '"';
  end;
end;

procedure TJSTooltip.SetDelay(const Value: Integer);
begin
  if Value < 0
    then FDelay := 0
    else FDelay := Value;
end;

procedure TJSTooltip.SetTrigger(const Value: string);
var
  slTriggers: TStringList;
  i: Integer;
begin
  // Four possible values: click hover focus manual
  // Any combination of these is allowed, just list them delimited by a space
  // Here we make sure the user has not entered an invalid option
  slTriggers := TStringList.Create;
  try
    slTriggers.Delimiter := ' ';
    slTriggers.CommaText := Value;

    for i := 0 to slTriggers.Count - 1 do
    begin
      if (slTriggers[i] <> 'click') and (slTriggers[i] <> 'hover') and
         (slTriggers[i] <> 'focus') and (slTriggers[i] <> 'manual') then
      begin
        raise Exception.Create('Invalid trigger: enter any combination of "click hover focus manual", separated by spaces');
      end;
    end;
  finally
    slTriggers.Free;
  end;

  FTrigger := Value;
end;

end.
