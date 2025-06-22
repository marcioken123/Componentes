unit IWBS4CustomEvents;

interface

uses Classes, SysUtils, StrUtils, IWApplication, IWControl, IWBS4RestServer;

type
  TIWBS4CustomAsyncEvent = class (TCollectionItem)
  private
    FEventName: string;
    FAsyncEvent: TIWAsyncEvent;
    FCallBackParams: TStringList;
    FAutoBind: Boolean;
    FEventParams: string;
    FLock: Boolean;
    procedure SetCallBackParams(const Value: TStringList);
    procedure ExecuteCallBack(aParams: TStringList);
    function IsEventParamsStored: Boolean;
  protected
    function GetDisplayName: string; override;
    procedure SetEventName(const AValue: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    // Return the javascript code necessary to execute the callback
    function GetScript(ASemiColon: Boolean = True): string;
    // Register the callback in the server. Is for internal use, don't use it.
    procedure RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
    // Search in a script and replace params with same name as EventName with the js code necessary to execute the callback.
    procedure ParseParam(AScript: TStringList);
  published
    // Specifies if the delphi event will be automatically binded to the jQuery control with the EventName specified.
    // If True, the event will be automatically attached to the rendered object. @br
    // If False, you need to manually bind the event. @br
    // To manually bind an event in delphi code you could do:
    // @preformatted(IWBSExecuteJScript(MyObject.JQSelector+'.on("api.event.name", function(event, param1, param2) {'+MyObject.CustomAsyncEvents[0].GetScript+'})');)
    // or you can add in the script property:
    // @preformatted($("#{%htmlname%}").on("api.event.name", function(event, param1, param2) { {%eventname%} });)
    property AutoBind: Boolean read FAutoBind write FAutoBind default False;
    // Mainteins a list of pairs names=values to translate the EventParams to the params pased to the OnAsyncEvent
    property CallBackParams: TStringList read FCallBackParams write SetCallBackParams;
    // Specifies the event name, if AutoBind = True, the EventName should be exactly the name of the jQuery event,
    // if AutoBind = False you can set any name here and use the correct one when you manually register it. @br
    property EventName: string read FEventName write SetEventName;
    // Specifies a list of comma separated names of params that the event will pass to the callback function. @br
    // This params names are defined in the api of the object you are using.
    property EventParams: string read FEventParams write FEventParams stored IsEventParamsStored;
    // lock screen during async event
    property Lock: Boolean read FLock write FLock default False;
    // Occurs when the defined JQ event is triggered
    property OnAsyncEvent: TIWAsyncEvent read FAsyncEvent write FAsyncEvent;
  end;

  TIWBS4CustomAsyncEvents = class (TOwnedCollection)
  private
    function GetItems(I: Integer): TIWBS4CustomAsyncEvent;
    procedure SetItems(I: Integer; const Value: TIWBS4CustomAsyncEvent);
  public
    constructor Create(AOwner: TPersistent);
    function ByName(const AEventName: string): TIWBS4CustomAsyncEvent;
    property Items[I: Integer]: TIWBS4CustomAsyncEvent read GetItems write SetItems; default;
  end;

  TIWBS4CustomRestEvent = class (TCollectionItem)
  private
    FParseFileUpload: Boolean;
    FEventName: string;
    FRestEvent: TIWBS4RestCallBackFunction;
    FRestEventPath: string;
  protected
    function GetDisplayName: string; override;
    procedure SetEventName(const AValue: string);
  public
    procedure Assign(Source: TPersistent); override;
    procedure RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
    procedure ParseParam(AScript: TStringList);
  published
    property EventName: string read FEventName write SetEventName;
    property OnRestEvent: TIWBS4RestCallBackFunction read FRestEvent write FRestEvent;
    property ParseFileUpload: Boolean read FParseFileUpload write FParseFileUpload default False;
  end;

  TIWBS4CustomRestEvents = class (TOwnedCollection)
  private
    function GetItems(I: Integer): TIWBS4CustomRestEvent;
    procedure SetItems(I: Integer; const Value: TIWBS4CustomRestEvent);
  public
    constructor Create(AOwner: TPersistent);
    property Items[I: Integer]: TIWBS4CustomRestEvent read GetItems write SetItems; default;
  end;

implementation

uses IWBS4Common, IWBS4CustomControl;

{$region 'TIWBS4CustomAsyncEvent'}
constructor TIWBS4CustomAsyncEvent.Create(Collection: TCollection);
begin
  inherited;
  FAutoBind := False;
  FCallBackParams := TStringList.Create;
  FEventName := '';
  FEventParams := 'event';
  FAsyncEvent := nil;
end;

destructor TIWBS4CustomAsyncEvent.Destroy;
begin
  FCallBackParams.Free;
  inherited;
end;

function TIWBS4CustomAsyncEvent.GetDisplayName: string;
begin
  Result := FEventName;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TIWBS4CustomAsyncEvent.SetEventName(const AValue: string);
begin
  TIWBS4Common.ValidateParamName(AValue);
  FEventName := AValue;
end;

procedure TIWBS4CustomAsyncEvent.SetCallBackParams(const Value: TStringList);
begin
  FCallBackParams.Assign(Value);
end;

procedure TIWBS4CustomAsyncEvent.Assign(Source: TPersistent);
begin
  if Source is TIWBS4CustomAsyncEvent then
  begin
    AutoBind := TIWBS4CustomAsyncEvent(Source).AutoBind;
    CallBackParams.Assign(TIWBS4CustomAsyncEvent(Source).CallBackParams);
    EventName := TIWBS4CustomAsyncEvent(Source).EventName;
    EventParams := TIWBS4CustomAsyncEvent(Source).EventParams;
    Lock := TIWBS4CustomAsyncEvent(Source).Lock;
    OnAsyncEvent := TIWBS4CustomAsyncEvent(Source).OnAsyncEvent;
  end else
  begin
    inherited;
  end;
end;

function TIWBS4CustomAsyncEvent.GetScript(ASemiColon: Boolean = True): string;
var
  LParams, LName: string;
  i: Integer;
begin
  LParams := '';
  for i := 0 to FCallBackParams.Count - 1 do
  begin
    LName := FCallBackParams.Names[i];
    TIWBS4Common.ValidateParamName(LName);
    if i > 0 then
    begin
      LParams := LParams + '+';
    end;
    LParams := LParams + '"&' + LName + '="+' + FCallBackParams.ValueFromIndex[i];
  end;
  if LParams = '' then
  begin
    LParams := '""';
  end;
  Result := 'ajaxCall("' + TIWBS4CustomControl(Collection.Owner).HTMLName + '.' +
    EventName + '",' + LParams + ', ' + IfThen(FLock, 'true', 'false') + ')';
  if ASemiColon then
  begin
    Result := Result + ';';
  end;
end;

function TIWBS4CustomAsyncEvent.IsEventParamsStored: Boolean;
begin
  Result := FEventParams <> 'event';
end;

procedure TIWBS4CustomAsyncEvent.ExecuteCallBack(aParams: TStringList);
begin
  if Assigned(FAsyncEvent) then
  begin
    FAsyncEvent(Collection.Owner, aParams);
  end;
end;

procedure TIWBS4CustomAsyncEvent.RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
begin
  AApplication.RegisterCallBack(AComponentName + '.' + FEventName, ExecuteCallBack);
end;

procedure TIWBS4CustomAsyncEvent.ParseParam(AScript: TStringList);
begin
  if AScript.Count > 0 then
  begin
    AScript.Text := ReplaceStr(AScript.Text,'{%' + FEventName + '%}', GetScript);
  end;
end;
{$endregion}

{$region 'TIWBSCustomAsyncEvents'}
constructor TIWBS4CustomAsyncEvents.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIWBS4CustomAsyncEvent);
end;

function TIWBS4CustomAsyncEvents.GetItems(I: Integer): TIWBS4CustomAsyncEvent;
begin
  Result := TIWBS4CustomAsyncEvent(inherited Items[I]);
end;

procedure TIWBS4CustomAsyncEvents.SetItems(I: Integer; const Value: TIWBS4CustomAsyncEvent);
begin
  inherited SetItem(I, Value);
end;

function TIWBS4CustomAsyncEvents.ByName(const AEventName: string): TIWBS4CustomAsyncEvent;
var
  i: Integer;
begin
  Result := nil;

  for i := 0 to Count - 1 do
    if Items[i].FEventName = AEventName then
    begin
      Result := Items[i];
      Break;
    end;

  if Result = nil then
  begin
    Result := TIWBS4CustomAsyncEvent(Add);
    Result.FEventName := AEventName;
  end;
end;
{$endregion}

{$region 'TIWBS4CustomRestEvent'}
function TIWBS4CustomRestEvent.GetDisplayName: string;
begin
  Result := FEventName;
  if Result = '' then
  begin
    Result := inherited GetDisplayName;
  end;
end;

procedure TIWBS4CustomRestEvent.SetEventName(const AValue: string);
begin
  TIWBS4Common.ValidateParamName(AValue);
  FEventName := AValue;
end;

procedure TIWBS4CustomRestEvent.Assign(Source: TPersistent);
begin
  if Source is TIWBS4CustomRestEvent then
  begin
    EventName := TIWBS4CustomRestEvent(Source).EventName;
    ParseFileUpload := TIWBS4CustomRestEvent(Source).ParseFileUpload;
    OnRestEvent := TIWBS4CustomRestEvent(Source).OnRestEvent;
  end else
  begin
    inherited;
  end;
end;

procedure TIWBS4CustomRestEvent.RegisterEvent(AApplication: TIWApplication; const AComponentName: string);
begin
  FRestEventPath := IWBS4RegisterRestCallBack(AApplication,
    AComponentName + '.' + FEventName, FRestEvent, FParseFileUpload);
end;

procedure TIWBS4CustomRestEvent.ParseParam(AScript: TStringList);
begin
  if AScript.Count > 0 then
  begin
    AScript.Text := ReplaceStr(AScript.Text, '{%' + FEventName + '%}', FRestEventPath);
  end;
end;
{$endregion}

{$region 'TIWBS4CustomRestEvents'}
constructor TIWBS4CustomRestEvents.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIWBS4CustomRestEvent);
end;

function TIWBS4CustomRestEvents.GetItems(I: Integer): TIWBS4CustomRestEvent;
begin
  Result := TIWBS4CustomRestEvent(inherited Items[I]);
end;

procedure TIWBS4CustomRestEvents.SetItems(I: Integer; const Value: TIWBS4CustomRestEvent);
begin
  inherited SetItem(I, Value);
end;
{$endregion}

end.
