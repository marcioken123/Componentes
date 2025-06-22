unit IWBS4CommonInterfaces;

interface

uses
  Classes, SysUtils, StrUtils, IWApplication, IWRenderContext, IWBaseInterfaces,
  IWHTMLTag, IWTypes, IWHTML40Interfaces, IWBaseRenderContext, IWControl,
  IWBS4CustomEvents, IWJsonDataObjects;

type
  TIWBS4ScriptParams = class(TStringList)
  private
    function GetJson(const Name: string): TJsonObject;
    procedure SetJson(const Name: string; const Value: TJsonObject);
  public
    constructor Create;
    property Json[const Name: string]: TJsonObject read GetJson write SetJson;
  end;

  IIWBS4Component = interface(IIWHTML40Control)
    ['{12925CB4-58EC-4B56-B032-578892548906}']
    procedure AsyncRemoveControl;
    procedure AsyncRefreshControl;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
    procedure InternalRenderStyle(AStyle: TStringList);
    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function JQSelector: string;
    function ParentContainer: IIWBaseContainer;
    procedure ResetAsyncRefreshControl;
    procedure SetFocus;

    function GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
    procedure SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
    function IsStoredCustomAsyncEvents: Boolean;
    function GetCustomRestEvents: TIWBS4CustomRestEvents;
    procedure SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
    function IsStoredCustomRestEvents: Boolean;

    function GetAfterRender: TNotifyEvent;
    procedure SetAfterRender(const Value: TNotifyEvent);

    function GetScript: TStringList;
    procedure SetScript(const AValue: TStringList);
    function GetScriptInsideTag: Boolean;
    procedure SetScriptInsideTag(const AValue: Boolean);
    function GetScriptParams: TIWBS4ScriptParams;
    procedure SetScriptParams(const AValue: TIWBS4ScriptParams);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    function get_Visible: Boolean;
    procedure set_Visible(Value: Boolean);

    property Cursor: TIWCursor read get_WebCursor write set_WebCursor;
    property CustomAsyncEvents: TIWBS4CustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents;
    property CustomRestEvents: TIWBS4CustomRestEvents read GetCustomRestEvents write SetCustomRestEvents;
    property Script: TStringList read GetScript write SetScript;
    property ScriptInsideTag: Boolean read GetScriptInsideTag write SetScriptInsideTag;
    property ScriptParams: TIWBS4ScriptParams read GetScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;
    property Visible: Boolean read get_Visible write set_Visible;

    property OnAfterRender: TNotifyEvent read GetAfterRender write SetAfterRender;
  end;

  IIWBS4Container = interface(IIWBaseContainer)
    ['{819FB21E-8204-450F-8778-5DEB56FDB062}']
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
    function ParentContainer: IIWBaseContainer;
    function RegionDiv: TIWHTMLTag;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag;

    function get_ContainerContext: TIWContainerContext;
    procedure set_ContainerContext(const AContainerContext: TIWContainerContext);
    function get_HTMLName: string;

    property ContainerContext: TIWContainerContext read get_ContainerContext write set_ContainerContext;
    property HTMLName: string read get_HTMLName;
  end;

implementation

{$region 'TIWBS4ScriptParams'}
constructor TIWBS4ScriptParams.Create;
begin
  inherited;
  Duplicates := dupError;
  OwnsObjects := True;
end;

function TIWBS4ScriptParams.GetJson(const Name: string): TJsonObject;
var
  i: Integer;
begin
  i := IndexOf(Name);
  if i < 0 then
  begin
    Result := TJsonObject.Create;
    AddObject(Name, Result);
  end else
  if Objects[i] = nil then
  begin
    Result := TJsonObject.Create;
    Objects[i] := Result;
  end else
  begin
    Result := TJsonObject(Objects[i]);
  end;
end;

procedure TIWBS4ScriptParams.SetJson(const Name: string; const Value: TJsonObject);
begin
  Json[Name].Assign(Value);
end;
{$endregion}

end.
