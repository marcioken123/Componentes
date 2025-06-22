unit IWBS4CustomControl;

interface

{$WARN SYMBOL_DEPRECATED OFF}

uses
  Classes, SysUtils, StrUtils, DB, IWTypes, IWApplication, IWAppForm, IWControl,
  IWRenderContext, IWHTMLTag, IWXMLTag, IWDBCommon, IWDBStdCtrls, IWBS4Common,
  IWBS4CommonInterfaces, IWBS4CustomEvents;

type
  // Base class for IWBS4 controls
  TIWBS4CustomControl = class(TIWCustomControl, IIWBS4Component)
  private
    FMainID: string;

    FAsyncRefreshControl: Boolean;
    FRendered: Boolean;
    FCustomAsyncEvents: TIWBS4CustomAsyncEvents;
    FCustomRestEvents: TIWBS4CustomRestEvents;
    FTabIndex: Integer;
    FScript: TStringList;
    FScriptInsideTag: Boolean;
    FScriptParams: TIWBS4ScriptParams;
    FStyle: TStringList;

    FOnAfterRender: TNotifyEvent;
    FOnAfterAsyncChange: TNotifyEvent;

    procedure SetScript(const AValue: TStringList);
    procedure SetScriptParams(const AValue: TIWBS4ScriptParams);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    procedure OnScriptChange(ASender: TObject);
    procedure OnStyleChange(ASender: TObject);
    function GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
    procedure SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
    function GetCustomRestEvents: TIWBS4CustomRestEvents;
    procedure SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
    function GetScript: TStringList;
    function GetScriptParams: TIWBS4ScriptParams;
    function GetScriptInsideTag: Boolean;
    procedure SetScriptInsideTag(const Value: Boolean);
    function GetAfterRender: TNotifyEvent;
    procedure SetAfterRender(const Value: TNotifyEvent);
  protected
    FOldCss: string;
    FOldDisabled: Boolean;
    FOldReadOnly: Boolean;
    FOldStyle: string;
    FOldVisible: Boolean;

    {$hints off}
    function get_HasTabOrder: Boolean; override;
    function GetTabOrder: TIWTabOrder; override;
    procedure SetTabOrder(AValue: TIWTabOrder); override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
    function RenderStyle(AContext: TIWCompContext): string; override;
  protected
    {$hints on}
    function FindOwnerForm(AOwner: TComponent): TIWAppForm; virtual;
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); virtual;
    procedure InternalRenderCss(var ACss: string); virtual;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); virtual;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); virtual;
    procedure InternalRenderStyle(AStyle: TStringList); virtual;
    function InputSelector: string; virtual;
    function InputSuffix: string; virtual;
    function IsReadOnly: Boolean; virtual;
    function IsDisabled: Boolean; virtual;

    property ActiveCss: string read FOldCss;
    property ActiveStyle: string read FOldStyle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // Force a full refresh of the control during an Async call. @br
    // Usually there is no need to use this method, only if some property changed during async calls is not reflected.
    procedure AsyncRefreshControl;

    // Cancel AsyncRefreshControl
    // Usually there is no need to use this method. It is for internal use.
    procedure ResetAsyncRefreshControl;

    // Remove a control from html flow. You should execute this when destroying a control durinc async calls before Freeing @br
    // If you are destroying a region is enought to execute this in that region, you don't need to execute it in each child control.
    procedure AsyncRemoveControl;

    // Resturns True if CustomAsyncEvents are defined
    function IsStoredCustomAsyncEvents: Boolean;

    // Resturns True if CustomRestEvents are defined
    function IsStoredCustomRestEvents: Boolean;

    // returns a string representing the the JQSelector for this object.
    // @preformatted(IWBSCustomControl.JQSelector > '$(#"htmlname")')
    function JQSelector: string;

    // Set focus on component in an Ajax Callback
    procedure SetFocus;
  published
    // Mainteins a list of TIWBSCustomAsyncEvent. @br
    // CustomAsyncEvent let you bind delphi code execution to practically any jQuery event of the control. @br
    // This is usefull when you apply third party plugins to the control.
    property CustomAsyncEvents: TIWBS4CustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    // Mainteins a list of TIWBSCustomRestEvent. @br
    // CustomRestEvent are for providing data to third party controls that request data via REST calls.
    property CustomRestEvents: TIWBS4CustomRestEvents read GetCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    // Specifies whether the control responds to mouse, keyboard, and timer events.
    property Enabled;

    property ExtraTagParams;

    // Specifies user javascript code that will be rendered and executed with this object. @br
    // You can define ScriptParams inside the script. ScriptParams are specified in scripts as: {%param%}. @br
    // With property ScriptInsideTag you can define if the script will be rendered inside or outside the script.
    property Script: TStringList read GetScript write SetScript;
    // Maintains a list of JS events you can directly write events in JS @br
    // at design time you can access to a limited set of events, but at runtime you can attach to any event of the control doing:
    // @preformatted(IWBSCustomControl.ScriptEvents.Values['object.custom.event'] := 'your javascript code...';
    // or if you want to define the function params:
    // @preformatted(IWBSCustomControl.ScriptEvents.Values['object.custom.event'] := 'function (param1, param2, param3) { your javascript code... }';
    property ScriptEvents;
    // Specifies if the script will be rendered inside the control tag or not. @br
    // If True the script will be rendered inside the tag. @br
    // If false a new div will be created to surround the control and the script will be rendered in this div, outside the control tag. @br
    // this is necessary script can't be placed inside the tag, for example in input controls.
    property ScriptInsideTag: Boolean read GetScriptInsideTag write SetScriptInsideTag default True;
    // Params that will be replaced in scripts and in some controls content, for example in TIWBSText. @br
    // Params are specified in scripts as: {%param%}.
    property ScriptParams: TIWBS4ScriptParams read GetScriptParams write SetScriptParams;
    // List of inline styles in pairs name: value
    property Style: TStringList read GetStyle write SetStyle;
    // Corresponds to html tabindex attribute. It will be rendered if tabindex <> 0. Set to -1 to disable tabstop
    property TabIndex: Integer read FTabIndex write FTabIndex default 0;

    property OnAsyncClick;
    property OnAsyncDoubleClick;
    property OnAsyncChange;
    property OnAsyncEnter;
    property OnAsyncExit;
    property OnAsyncKeyDown;
    property OnAsyncKeyUp;
    property OnAsyncKeyPress;
    property OnAsyncMouseDown;
    property OnAsyncMouseMove;
    property OnAsyncMouseOver;
    property OnAsyncMouseOut;
    property OnAsyncMouseUp;
    property OnClick;

    // Occurs after HTMLTag is created
    property OnHTMLTag;

    // Occurs after component is rendered.
    property OnAfterRender: TNotifyEvent read GetAfterRender write SetAfterRender;

    // Occurs after component is changed in an Async call, it doesn't occur if the control is fully rendered
    property OnAfterAsyncChange: TNotifyEvent read FOnAfterAsyncChange write FOnAfterAsyncChange;
  end;

  // Base class for IWBS data aware controls
  TIWBS4CustomDbControl = class(TIWBS4CustomControl, IIWBS4Component)
  private
    FDataLink: TIWDataLink;
    FDataField: string;
    FDataSource: TDataSource;
    FMaxLength: Integer;
    procedure SetDataField(const AValue: string);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetMaxLength(const AValue: Integer);
  protected
    procedure CheckData(AContext: TIWCompContext); virtual;
    property MaxLength: Integer read FMaxLength write SetMaxLength;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property DataField: string read FDataField write SetDataField;
  end;

implementation

uses
  IWBaseHTMLInterfaces, IWBS4ScriptEvents, IWBS4Global, IWBS4Utils;

{$region 'TIWBS4CustomControl'}
constructor TIWBS4CustomControl.Create(AOwner: TComponent);
begin
  inherited;
  FAsyncRefreshControl := False;
  FRendered := False;
  FCustomAsyncEvents := nil;
  FCustomRestEvents := nil;
  FFriendlyName := '-';
  FMainID := '';
  FTabIndex := 0;
  FScript := TStringList.Create;
  FScript.OnChange := OnScriptChange;
  FScriptInsideTag := True;
  FScriptParams := TIWBS4ScriptParams.Create;
  FScriptParams.OnChange := OnScriptChange;
  FStyle := TStringList.Create;
  FStyle.OnChange := OnStyleChange;
  FStyle.NameValueSeparator := ':';
end;

destructor TIWBS4CustomControl.Destroy;
begin
  FreeAndNil(FCustomAsyncEvents);
  FreeAndNil(FCustomRestEvents);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  inherited;
end;

function TIWBS4CustomControl.JQSelector: string;
begin
  Result := '$("#' + HTMLName + '")';
end;

procedure TIWBS4CustomControl.SetFocus;
begin
  IWBS4ExecuteAsyncJScript(JQSelector + '.focus()');
end;

procedure TIWBS4CustomControl.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBS4CustomControl.ResetAsyncRefreshControl;
begin
  FAsyncRefreshControl := False;
end;

procedure TIWBS4CustomControl.AsyncRemoveControl;
begin
  TIWBS4Common.AsyncRemoveControl(HTMLName);
  FRendered := False;
end;

function TIWBS4CustomControl.FindOwnerForm(AOwner: TComponent): TIWAppForm;
begin
  if AOwner is TIWAppForm then
  begin
    Result := TIWAppForm(AOwner)
  end
  else if AOwner.Owner <> nil then
    Result := FindOwnerForm(AOwner.Owner)
  else
    Result := nil;
end;

function TIWBS4CustomControl.get_HasTabOrder: Boolean;
begin
  Result := False;
end;

function TIWBS4CustomControl.GetTabOrder: TIWTabOrder;
begin
  Result := -1;
end;

procedure TIWBS4CustomControl.SetTabOrder(AValue: TIWTabOrder);
begin
  //
end;

function TIWBS4CustomControl.GetAfterRender: TNotifyEvent;
begin
  Result := FOnAfterRender;
end;

function TIWBS4CustomControl.GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
begin
  if FCustomAsyncEvents = nil then
  begin
    FCustomAsyncEvents := TIWBS4CustomAsyncEvents.Create(Self);
  end;
  Result := FCustomAsyncEvents;
end;

function TIWBS4CustomControl.GetCustomRestEvents: TIWBS4CustomRestEvents;
begin
  if FCustomRestEvents = nil then
  begin
    FCustomRestEvents := TIWBS4CustomRestEvents.Create(Self);
  end;
  Result := FCustomRestEvents;
end;

procedure TIWBS4CustomControl.SetAfterRender(const Value: TNotifyEvent);
begin
  FOnAfterRender := Value;
end;

procedure TIWBS4CustomControl.SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBS4CustomControl.SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
begin
  FCustomRestEvents.Assign(Value);
end;

function TIWBS4CustomControl.IsStoredCustomAsyncEvents: Boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;

function TIWBS4CustomControl.IsStoredCustomRestEvents: Boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;

procedure TIWBS4CustomControl.OnScriptChange(ASender: TObject);
begin
  AsyncRefreshControl;
end;

procedure TIWBS4CustomControl.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBS4CustomControl.SetScriptInsideTag(const Value: Boolean);
begin
  FScriptInsideTag := Value;
end;

procedure TIWBS4CustomControl.OnStyleChange(ASender: TObject);
begin
  Invalidate;
end;

procedure TIWBS4CustomControl.SetScriptParams(const AValue: TIWBS4ScriptParams);
begin
  FScriptParams.Assign(AValue);
end;

function TIWBS4CustomControl.GetScript: TStringList;
begin
  Result := FScript;
end;

function TIWBS4CustomControl.GetScriptInsideTag: Boolean;
begin
  Result := FScriptInsideTag;
end;

function TIWBS4CustomControl.GetScriptParams: TIWBS4ScriptParams;
begin
  Result := FScriptParams;
end;

function TIWBS4CustomControl.GetStyle: TStringList;
begin
  Result := FStyle;
end;

procedure TIWBS4CustomControl.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
end;

procedure TIWBS4CustomControl.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  //
end;

procedure TIWBS4CustomControl.InternalRenderCss(var ACss: string);
begin
  //
end;

procedure TIWBS4CustomControl.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  //
end;

procedure TIWBS4CustomControl.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  //
end;

procedure TIWBS4CustomControl.InternalRenderStyle(AStyle: TStringList);
begin
  //
end;

function TIWBS4CustomControl.IsReadOnly: Boolean;
begin
  Result := False;
end;

function TIWBS4CustomControl.IsDisabled: Boolean;
begin
  Result := not Enabled;
end;

function TIWBS4CustomControl.InputSelector: string;
begin
  Result := '';
end;

function TIWBS4CustomControl.InputSuffix: string;
begin
  Result := '';
end;

function TIWBS4CustomControl.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
  xInputSelector: string;
  xApplication: TIWApplication;
begin
  Result := nil;

  if FAsyncRefreshControl or not FRendered then
  begin
    xHTMLName := FMainID;
    TIWBS4Common.RenderAsync(xHTMLName, Self, AContext);
  end
  else
  begin
    xHTMLName := HTMLName;
    if InputSelector <> '' then
      xInputSelector := FMainID + InputSelector
    else
      xInputSelector := xHTMLName + InputSuffix;
    if AContext = nil then
      xApplication := GGetWebApplicationThreadVar
    else
      xApplication := AContext.WebApplication;
    TIWBS4Common.SetAsyncClass(xApplication, xHTMLName, RenderCSSClass(nil), FOldCss);
    TIWBS4Common.SetAsyncDisabled(xApplication, xInputSelector, IsDisabled, FOldDisabled);
    TIWBS4Common.SetAsyncReadOnly(xApplication, xInputSelector, IsReadOnly, FOldReadOnly);
    TIWBS4Common.SetAsyncStyle(xApplication, xHTMLName, RenderStyle(nil), FOldStyle);
    TIWBS4Common.SetAsyncVisible(xApplication, FMainID, Visible, FOldVisible);
    InternalRenderAsync(xHTMLName, xApplication);

    if Assigned(FOnAfterAsyncChange) then
    begin
      FOnAfterAsyncChange(Self);

      if Assigned(gIWBS4OnAfterAsyncChange) then
        gIWBS4OnAfterAsyncChange(Self, xHTMLName);
    end;

    if Assigned(gIWBS4OnAfterAsyncChange) then
    begin
      gIWBS4OnAfterAsyncChange(Self, xHTMLName);
    end;
  end;
end;

function TIWBS4CustomControl.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := Css;
  InternalRenderCss(Result);
end;

function TIWBS4CustomControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := nil;
  FOldCss := RenderCSSClass(AContext);
  FOldDisabled := IsDisabled;
  FOldReadOnly := IsReadOnly;
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;

  InternalRenderHTML(HTMLName, AContext, Result);
  if Result = nil then
  begin
    raise Exception.Create('HTML tag not created');
  end;

  IWBS4RenderScript(Self, AContext, Result);
  FMainID := Result.Params.Values['id'];
  FAsyncRefreshControl := False;
  FRendered := True;
end;

procedure TIWBS4CustomControl.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;

function TIWBS4CustomControl.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := TIWBS4Common.RenderStyle(Self);
end;
{$endregion}

{$region 'TIWBSCustomDbControl'}

constructor TIWBS4CustomDbControl.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := nil;
  FDataField := '';
end;

destructor TIWBS4CustomDbControl.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited;
end;

procedure TIWBS4CustomDbControl.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then
  begin
    if FDatasource = AComponent then
    begin
      SetDataSource(nil);
    end;
  end;
end;

procedure TIWBS4CustomDbControl.SetDataField(const AValue: string);
var
  xFld: TField;
begin
  if not SameText(AValue, FDataField) then
  begin
    FDataField := AValue;
    MaxLength := 0;
    if FDataField <> '' then
    begin
      xFld := GetDataSourceField(FDataSource, FDataField);
      if Assigned(xFld) and (xFld is TStringField) then
      begin
        MaxLength := TStringField(xFld).Size;
      end;
    end;
    Invalidate;
  end;
end;

procedure TIWBS4CustomDbControl.SetDataSource(const Value: TDataSource);
begin
  if Value <> FDataSource then
  begin
    FDataSource := Value;
    if Value = nil then
    begin
      FDataField := '';
      FreeAndNil(FDataLink);
    end
    else
    begin
      if FDataLink = nil then
      begin
        FDataLink := TIWDataLink.Create(Self);
      end;
      FDataLink.DataSource := FDataSource;
    end;
    Invalidate;
  end;
end;

procedure TIWBS4CustomDbControl.SetMaxLength(const AValue: Integer);
begin
  if FMaxLength <> AValue then
  begin
    FMaxLength := AValue;
    AsyncRefreshControl;
  end;
end;

procedure TIWBS4CustomDbControl.CheckData(AContext: TIWCompContext);
begin
  //
end;

function TIWBS4CustomDbControl.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
begin
  CheckData(AContext);
  Result := inherited;
end;

function TIWBS4CustomDbControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  CheckData(AContext);
  Result := inherited;
end;
{$endregion}

end.

