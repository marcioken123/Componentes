unit LMDCustomPluginManager;
{$I lmdcmps.inc}

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

LMDCustomPluginManager unit (AIH)
----------------------------
Description
LMD Plugin Manager
ToDo
----

Changes
-------

Release 0.1 (July 2008)
* Initial Release

###############################################################################}

interface

uses
  Classes, Forms, Windows, Controls, Types, LMDTypes, LMDPluginModule,
  LMDPluginManager, SysUtils, LMDPluginImpl, LMDVariants;

type
  TLMDPluginOnLoad = procedure (APluginPath: string; var Accept: Boolean) of object;

  TLMDPluginDataModules = class(TOwnedCollection)
  end;

  TLMDPluginDataModuleItem = class(TCollectionItem)
    private
      FModule: TLMDPluginModule;
    published
      property Module: TLMDPluginModule read FModule write FModule;
  end;

  TLMDOnPluginEvent = procedure (Sendet: TObject; AData: Pointer) of object;
    TLMDCustomPluginEvent = class(TCollectionItem)
  private
    FOnPluginEvent: TLMDOnPluginEvent;
    FName: WideString;
  published
    property OnPluginEvent: TLMDOnPluginEvent read FOnPluginEvent write FOnPluginEvent;
    property Name: WideString read FName write FName;
  end;

  TLMDCustomPluginEvents = class(TOwnedCollection)
  end;

  { ************************ TLMDCustomPluginManager *************************** }
  TLMDCustomPluginManager = class(TLMDPluginComponent)
  private
    FAutoLoading: Boolean;
    FHostParameters: TStrings;
    FMenuController: TLMDBaseMenuController;
    FPlugins: TInterfaceList;
    FPluginsToLoad: TLMDStrings;
    FToolbarController: TLMDBaseToolbarController;
    FHost: ILMDHost;
    FPathMask: string;
    FPluginModules: TLMDPluginDataModules;
    FOnLoad: TLMDPluginOnLoad;
    FEvents: TLMDCustomPluginEvents;
    FEventCallback: TLMDPluginEvent;
    FInvokes: TLMDVariantList;
    function GetPluginCount(): Integer;
    procedure SetPluginsToLoad(AList: TLMDStrings);
    function GetPlugin(AIndex: Integer): ILMDPlugin;
    function GetInvoke(AIndex: Integer): Variant;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure Loaded; override;
    function LoadPlugin(const AFileName: string): Boolean;
    function AddPlugin(APlugin: ILMDPlugin): Boolean;
    function LoadPlugins: Boolean;
    function UnloadPlugin(AIndex: Integer): Boolean;
    function UnloadPlugins: Boolean;
    procedure OnPerformPluginEvent(const AName: WideString; AData: Pointer);
    property AutoLoading: Boolean read FAutoLoading write FAutoLoading;
    property HostParameters: TStrings read FHostParameters write FHostParameters;
    property MenuController: TLMDBaseMenuController read FMenuController write FMenuController;
    property PluginsCount: Integer read GetPluginCount;
    property PluginsToLoad: TLMDStrings read FPluginsToLoad write SetPluginsToLoad;
    property ToolbarController: TLMDBaseToolbarController read FToolbarController write FToolbarController;
    property Host: ILMDHost read FHost write FHost;
    property Plugins[Index: Integer]: ILMDPlugin read GetPlugin; default;
    property PathMask: String read FPathMask write FPathMask;
    property PluginModules: TLMDPluginDataModules read FPluginModules write FPluginModules;
    property OnLoad: TLMDPluginOnLoad read FOnLoad write FOnLoad;
    property Events: TLMDCustomPluginEvents read FEvents write FEvents;
    property PluginInvoke[Index: Integer]: Variant read GetInvoke;
  end;

  TLMDPluginManager = class(TLMDCustomPluginManager)
  public
    property PluginsToLoad;
  published
    property AutoLoading;
    property HostParameters;
    property MenuController;
    property ToolbarController;
    property PathMask;
    property PluginModules;
    property OnLoad;
    property Events;
    property About;
  end;

implementation

uses
  LMDStrings, LMDPluginVarType;
{ ************************ TLMDCustomPluginManager *************************** }
{ ----------------------------- private -------------------------------------- }
function TLMDCustomPluginManager.GetPluginCount: Integer;
begin
  Result := 0;
  if Assigned(FPlugins) then
    Result := FPlugins.Count;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPluginManager.GetPlugin(AIndex: Integer): ILMDPlugin;
begin
  if AIndex > FPlugins.Count - 1 then
    Raise ERangeError.Create('Index wrong');
  Result := ILMDPlugin(FPlugins[Aindex]);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPluginManager.SetPluginsToLoad(AList: TLMDStrings);
begin
  FPluginsToLoad.Assign(AList);
  if AutoLoading then
    LoadPlugins;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPluginManager.GetInvoke(AIndex: Integer): Variant;
begin
  Result := FInvokes.Variants[AIndex];
end;

{ ------------------------------ public -------------------------------------- }
function TLMDCustomPluginManager.AddPlugin(APlugin: ILMDPlugin): Boolean;
var
  LVariant: Variant;
begin
  if not Assigned(FEventCallback) then
    FEventCallback := TLMDPluginEvent.Create(OnPerformPluginEvent);
  APlugin.SetHandle(0);
  APlugin.SetFileName(Application.ExeName);
  FPlugins.Add(APlugin);
  APlugin.EventCallback(FEventCallback);
  LVariant := VarLMDPluginCreate(APlugin);
  FInvokes.Add(LVariant);
  Result := True;
end;

{------------------------------------------------------------------------------}
constructor TLMDCustomPluginManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHostParameters := TStringList.Create();
  FPlugins := TInterfaceList.Create;
  FPlugins.Clear;
  FPluginsToLoad := TLMDMemoryStrings.Create;
  FPluginModules := TLMDPluginDataModules.Create(Self, TLMDPluginDataModuleItem);
  FEvents := TLMDCustomPluginEvents.Create(Self, TLMDCustomPluginEvent);
  FInvokes := TLMDVariantList.Create;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPluginManager.Loaded;
var
  LSearchRec: TSearchRec;
  LPath: string;
begin
  if csDesigning  in ComponentState then
    exit;

  LPath := ExtractFilePath(FPathMask);
  if Length(FPathMask) > 0 then
    if FindFirst(FPathMask, faAnyFile, LSearchRec) = 0 then
    repeat
       FPluginsToLoad.Add(LPath + LSearchRec.Name);
    until FindNext(LSearchRec) <> 0;

  if FAutoLoading then
    LoadPlugins;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomPluginManager.Destroy();
begin
  if Assigned(FPlugins) then
    UnloadPlugins;
  FreeAndNil(FPlugins);
  FreeAndNil(FPluginsToLoad);
  FreeAndNil(FInvokes);
  FreeAndNil(FHostParameters);
  FreeAndNil(FPluginModules);
  FreeAndNil(FEvents);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPluginManager.LoadPlugin(const AFileName: string): Boolean;
var
  hLib: HMODULE;
  LPlugin: ILMDPlugin;
  LGetPluginProc: TLMDGetPluginProc;
  LAccept: boolean;
  V: Variant;
begin
  Result := false;

  LAccept := True;
  if Assigned(FOnLoad) then
    FOnLoad(AFileName, LAccept);
  if not LAccept then
    exit;

  if FileExists(AFileName) then
  begin
    if not Assigned(FEventCallback) then
      FEventCallback := TLMDPluginEvent.Create(OnPerformPluginEvent);
    hLib := LoadLibrary(PChar(AFileName));
    if hLib = 0 then
      exit;
    @LGetPluginProc := GetProcAddress(hLib, 'GetLMDPlugin');
    if not Assigned(LGetPluginProc) then
    begin
      @LGetPluginProc := GetProcAddress(hLib, '_GetLMDPlugin');
      if not Assigned(LGetPluginProc) then
      begin
        try
          FreeLibrary(hLib);
        finally
          Result := False;
        end;
        exit;
      end;
    end;

    LPlugin := LGetPluginProc(Application);
    if not Assigned(LPlugin) then
    begin
      try
        FreeLibrary(hLib);
      finally
        Result := False;
      end;
      exit;
    end;
    LPlugin.SetHandle(hLib);
    LPlugin.SetFileName(AFileName);
    FPlugins.Add(LPlugin);
    V := VarLMDPluginCreate(LPlugin);
    FInvokes.Add(V);
    LPlugin.EventCallback(FEventCallback);
    Result := true;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPluginManager.LoadPlugins: Boolean;
var
  LIterator: Integer;
begin
  Result := True;
  if Assigned(FPluginsToLoad) then
    for LIterator := 0 to FPluginsToLoad.Count - 1 do
      Result := Result and LoadPlugin(FPluginsToLoad.Strings[LIterator]);
end;

{------------------------------------------------------------------------------}
function TLMDCustomPluginManager.UnloadPlugin(AIndex: Integer) : Boolean;
var
  LIdx: Integer;
  LHandle: THandle;

  // !!! Do not remove this function
  function GetHandle: THandle;
  begin
    Result := Plugins[AIndex].GetHandle;
  end;

begin
  try
    LHandle := GetHandle;

    LIdx := AIndex;
    FPlugins.Items[LIdx] := nil;
    FInvokes.Delete(LIdx);
    FPlugins.Delete(LIdx);

    if LHandle <> 0 then
      FreeLibrary(LHandle);

    if FInvokes.Count < 1 then
      FEventCallBack := nil;

    Result := True;
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPluginManager.UnloadPlugins: Boolean;
begin
  Result := True;
  while FPlugins.Count > 0 do
    Result := Result and UnloadPlugin(0);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPluginManager.OnPerformPluginEvent(const AName: WideString; AData: Pointer);
var
  i: Integer;
  LEvent: TLMDCustomPluginEvent;
begin
  for i := 0 to FEvents.Count - 1 do
  begin
    LEvent := TLMDCustomPluginEvent(FEvents.Items[i]); 
    if LMDWideUpperCase(LEvent.Name) = LMDWideUpperCase(AName) then
      if Assigned(LEvent.OnPluginEvent) then
        LEvent.OnPluginEvent(Self, AData);
  end;
end;

end.
