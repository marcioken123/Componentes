unit IWBS4Common;

interface
{$Include IWBootstrap4.inc}

uses
  Classes, SysUtils, StrUtils, Forms, IWApplication, IWBaseInterfaces, IWHTMLTag,
  IWRenderContext, IWControl, IWHTML40Interfaces, IWBaseHTMLInterfaces, IWTypes,
  IWBaseRenderContext, {$IFDEF IW_14_1_0_UP} IW.Common.StrLists, {$ENDIF}
  IWJsonDataObjects, IWBS4CommonInterfaces;

const
  EOL = #13#10;

type
  TIWBS4Size = (bs4szDefault, bs4szXl, bs4szLg, bs4szMd, bs4szSm, bs4szXs);

  TIWBS4RelativeSize = (bs4rzDefault, bs4rzLg, bs4rzSm);

  TIWBS4ResizeDirection = (bs4rdDefault, bs4rdNone, bs4rdBoth, bs4rdVertical, bs4rdHorizontal);

  TIWBS4NavItemAlignment = (bs4naLeft, bs4naCenter, bs4naRight);

const
  aIWBS4NavItemAlignment: array[bs4naLeft..bs4naRight] of string = ('', 'justify-content-center', 'justify-content-end');
  aIWBS4RelativeSize: array[bs4rzDefault..bs4rzSm] of string = ('', 'lg', 'sm');
  aIWBS4Size: array[bs4szDefault..bs4szXs] of string = ('', 'xl', 'lg', 'md', 'sm', '-');
  aIWBS4ResizeDirection: array[bs4rdDefault..bs4rdHorizontal] of string = ('', 'none', 'both', 'vertical', 'horizontal');

type
  TIWBS4GridVisibility = (bs4gvDefault, bs4gvBlock, bs4gvInline, bs4gvInlineBlock, bs4gvHidden);

  TIWBS4GridFloat = (bs4gfNone, bs4gfLeft, bs4gfRight);

  TIWBS4GridOptions = class(TPersistent)
  private
    FFloat: TIWBS4GridFloat;
    FOwner: IIWBaseControl;
    FGridXsOffset: Integer;
    FGridXsSpan: Integer;
    FGridSmOffset: Integer;
    FGridSmSpan: Integer;
    FGridMdOffset: Integer;
    FGridMdSpan: Integer;
    FGridLgOffset: Integer;
    FGridLgSpan: Integer;
    FGridXlOffset: Integer;
    FGridXlSpan: Integer;
    FVisibilityXs: TIWBS4GridVisibility;
    FVisibilitySm: TIWBS4GridVisibility;
    FVisibilityMd: TIWBS4GridVisibility;
    FVisibilityLg: TIWBS4GridVisibility;
    FVisibilityXl: TIWBS4GridVisibility;
    FVisibilityPrint: TIWBS4GridVisibility;
    procedure SetVisibilityXl(const Value: TIWBS4GridVisibility);
    procedure SetVisibilityLg(const Value: TIWBS4GridVisibility);
    procedure SetVisibilityPrint(const Value: TIWBS4GridVisibility);
    procedure SetVisibilityMd(const Value: TIWBS4GridVisibility);
    procedure SetVisibilitySm(const Value: TIWBS4GridVisibility);
    procedure SetVisibilityXs(const Value: TIWBS4GridVisibility);
    procedure SetFloat(const Value: TIWBS4GridFloat);
    procedure SetGridXlOffset(const Value: Integer);
    procedure SetGridXlspan(const Value: Integer);
    procedure SetGridLgOffset(const Value: Integer);
    procedure SetGridLgSpan(const Value: Integer);
    procedure SetGridMdOffset(const Value: Integer);
    procedure SetGridMdSpan(const Value: Integer);
    procedure SetGridSmOffset(const Value: Integer);
    procedure SetGridSmSpan(const Value: Integer);
    procedure SetGridXsOffset(const Value: Integer);
    procedure SetGridXsSpan(const Value: Integer);
  public
    constructor Create(AOwner: IIWBaseControl); virtual;
    procedure Assign(Source: TPersistent); override;
    function GetClassString(ACustomSmOffset, ACustomMdOffset, ACustomLgOffset, ACustomXlOffset: Integer): string; overload;
    function GetClassString: string; overload;
  published
    property Float: TIWBS4GridFloat read FFloat write SetFloat default bs4gfNone;
    property GridXsOffset: Integer read FGridXsOffset write SetGridXsOffset default 0;
    property GridXsSpan: Integer read FGridXsSpan write SetGridXsSpan default 0;
    property GridSmOffset: Integer read FGridSmOffset write SetGridSmOffset default 0;
    property GridSmSpan: Integer read FGridSmSpan write SetGridSmSpan default 0;
    property GridMdOffset: Integer read FGridMdOffset write SetGridMdOffset default 0;
    property GridMdSpan: Integer read FGridMdSpan write SetGridMdSpan default 0;
    property GridLgOffset: Integer read FGridLgOffset write SetGridLgOffset default 0;
    property GridLgSpan: Integer read FGridLgSpan write SetGridLgSpan default 0;
    property GridXlOffset: Integer read FGridXlOffset write SetGridXlOffset default 0;
    property GridXlSpan: Integer read FGridXlSpan write SetGridXlSpan default 0;
    property VisibilityXs: TIWBS4GridVisibility read FVisibilityXs write SetVisibilityXs default bs4gvDefault;
    property VisibilitySm: TIWBS4GridVisibility read FVisibilitySm write SetVisibilitySm default bs4gvDefault;
    property VisibilityMd: TIWBS4GridVisibility read FVisibilityMd write SetVisibilityMd default bs4gvDefault;
    property VisibilityLg: TIWBS4GridVisibility read FVisibilityLg write SetVisibilityLg default bs4gvDefault;
    property VisibilityXl: TIWBS4GridVisibility read FVisibilityXl write SetVisibilityXl default bs4gvDefault;
    property VisibilityPrint: TIWBS4GridVisibility read FVisibilityPrint write SetVisibilityPrint default bs4gvDefault;
  end;

  TIWBS4Common = class
  public
    class procedure AddCssClass(var ACss: string; const AClass: string);
    class procedure AsyncRemoveControl(const AHTMLName: string);
    class procedure DoAfterRender(AControl: TComponent);
    class procedure RenderAsync(const AHTMLName: string; const AControl: IIWBS4Component; AContext: TIWCompContext);
    class function RenderHTMLTag(const AControl: IIWBS4Component; AContext: TIWCompContext): string;
    class function RenderStyle(const AComponent: IIWBS4Component): string;
    class function ReplaceParams(const AComponent: IIWBS4Component; const AScript: string; AFrom: Integer = 1): string;
    class procedure SetNotVisible(AParams: TIWNameValueList);
    class procedure ValidateParamName(const AName: string);
    class procedure ValidateTagName(const AName: string);
    class procedure SetAsyncDisabled(AApplication: TIWApplication; const HTMLName: string; Value: Boolean; var OldValue: Boolean);
    class procedure SetAsyncReadOnly(AApplication: TIWApplication; const HTMLName: string; Value: Boolean; var OldValue: Boolean);
    class procedure SetAsyncVisible(AApplication: TIWApplication; const HTMLName: string; Value: Boolean; var OldValue: Boolean);
    class procedure SetAsyncClass(AApplication: TIWApplication; const HTMLName: string; const Value: string; var OldValue: string);
    class procedure SetAsyncStyle(AApplication: TIWApplication; const HTMLName: string; const Value: string; var OldValue: string);
    class procedure SetAsyncChecked(AApplication: TIWApplication; const HTMLName: string; const Value: Boolean; var OldValue: Boolean);
    class procedure SetAsyncText(AApplication: TIWApplication; const HTMLName: string; const Value: string; var OldValue: string);
    class procedure SetAsyncHtml(AApplication: TIWApplication; const HTMLName: string; const Value: string; var OldValue: string);
  end;

  TIWBS4RegionCommon = class
  public
    class procedure CancelChildAsyncRender(AControl: TComponent);
    class procedure DisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
    class procedure PrepareChildComponentsForRender(AContainer: IIWBaseContainer);
    class procedure RenderComponents(AContainer: IIWBS4Container; AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
  end;

implementation

uses
  IW.Common.SysTools, IW.Common.RenderStream, IWBaseHTMLControl, IWForm,
  IWRegion, IWMarkupLanguageTag, IWHTML40Container, IWBS4Utils, IWBS4Global,
  IWBS4NavBar, IWBS4CustomRegion, IWBS4LayoutMgr;
{$region 'TIWBS4GridOptions'}
{$IFDEF VER200}

function GetImplementorOfInterface(const I: IInterface): TObject;
{ TODO -cDOC : Original code by Hallvard Vassbotn }
{ TODO -cTesting : Check the implemetation for any further version of compiler }
const
  AddByte = $04244483; // opcode for ADD DWORD PTR [ESP+4], Shortint
  AddLong = $04244481; // opcode for ADD DWORD PTR [ESP+4], Longint
type
  PAdjustSelfThunk = ^TAdjustSelfThunk;

  TAdjustSelfThunk = packed record
    case AddInstruction: Longint of
      AddByte:
        (AdjustmentByte: ShortInt);
      AddLong:
        (AdjustmentLong: Longint);
  end;

  PInterfaceMT = ^TInterfaceMT;

  TInterfaceMT = packed record
    QueryInterfaceThunk: PAdjustSelfThunk;
  end;

  TInterfaceRef = ^PInterfaceMT;
var
  QueryInterfaceThunk: PAdjustSelfThunk;
begin
  try
    Result := Pointer(I);
    if Assigned(Result) then
    begin
      QueryInterfaceThunk := TInterfaceRef(I)^.QueryInterfaceThunk;
      case QueryInterfaceThunk.AddInstruction of
        AddByte:
          Inc(PByte(Result), QueryInterfaceThunk.AdjustmentByte);
        AddLong:
          Inc(PByte(Result), QueryInterfaceThunk.AdjustmentLong);
      else
        Result := nil;
      end;
    end;
  except
    Result := nil;
  end;
end;
{$ENDIF}
{$endregion}
{$region 'TIWBS4GridOptions'}

constructor TIWBS4GridOptions.Create(AOwner: IIWBaseControl);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TIWBS4GridOptions.GetClassString(ACustomSmOffset, ACustomMdOffset, ACustomLgOffset, ACustomXlOffset: Integer): string;

  procedure AddCssValue(var s: string; const Value: string);
  begin
    if s <> '' then
    begin
      s := s + ' ';
    end;
    s := s + Value;
  end;

var
  lNavBar: Boolean;
begin
  Result := '';

  // when the BSGridOptions > Grid*Offset is specified, it is translated to
  // col-*-offset-* (e.g. col-sm-offset-3). However, that’s not correct for Bootstrap 4,
  // it should instead be offset-*-* (e.g. offset-sm-3), see
  // https://getbootstrap.com/docs/4.0/layout/grid/#offset-classes and
  // https://www.webdevsplanet.com/post/bootstrap-col-md-offset-not-working
  if ACustomSmOffset + FGridSmOffset > 0 then
    AddCssValue(Result, 'offset-sm-' + IntToStr(ACustomSmOffset + FGridSmOffset));
  if ACustomMdOffset + FGridMdOffset > 0 then
    AddCssValue(Result, 'offset-md-' + IntToStr(ACustomMdOffset + FGridMdOffset));
  if ACustomLgOffset + FGridLgOffset > 0 then
    AddCssValue(Result, 'offset-lg-' + IntToStr(ACustomLgOffset + FGridLgOffset));
  if ACustomXlOffset + FGridXlOffset > 0 then
    AddCssValue(Result, 'offset-xl-' + IntToStr(ACustomXlOffset + FGridXlOffset));

  if FGridSmSpan > 0 then
    AddCssValue(Result, 'col-sm-' + IntToStr(FGridSmSpan));
  if FGridMdSpan > 0 then
    AddCssValue(Result, 'col-md-' + IntToStr(FGridMdSpan));
  if FGridLgSpan > 0 then
    AddCssValue(Result, 'col-lg-' + IntToStr(FGridLgSpan));
  if FGridXlspan > 0 then
    AddCssValue(Result, 'col-xl-' + IntToStr(FGridXlSpan));

  if FVisibilitySm = bs4gvBlock then
    AddCssValue(Result, 'visible-sm-block')
  else if FVisibilitySm = bs4gvInline then
    AddCssValue(Result, 'visible-sm-inline')
  else if FVisibilitySm = bs4gvInlineBlock then
    AddCssValue(Result, 'visible-sm-inline-block')
  else if FVisibilitySm = bs4gvHidden then
    AddCssValue(Result, 'hidden-sm');
  if FVisibilityMd = bs4gvBlock then
    AddCssValue(Result, 'visible-md-block')
  else if FVisibilityMd = bs4gvInline then
    AddCssValue(Result, 'visible-md-inline')
  else if FVisibilityMd = bs4gvInlineBlock then
    AddCssValue(Result, 'visible-md-inline-block')
  else if FVisibilityMd = bs4gvHidden then
    AddCssValue(Result, 'hidden-md');
  if FVisibilityLg = bs4gvBlock then
    AddCssValue(Result, 'visible-lg-block')
  else if FVisibilityLg = bs4gvInline then
    AddCssValue(Result, 'visible-lg-inline')
  else if FVisibilityLg = bs4gvInlineBlock then
    AddCssValue(Result, 'visible-lg-inline-block')
  else if FVisibilityLg = bs4gvHidden then
    AddCssValue(Result, 'hidden-lg');
  if FVisibilityXl = bs4gvBlock then
    AddCssValue(Result, 'visible-xl-block')
  else if FVisibilityXl = bs4gvInline then
    AddCssValue(Result, 'visible-xl-inline')
  else if FVisibilityXl = bs4gvInlineBlock then
    AddCssValue(Result, 'visible-xl-inline-block')
  else if FVisibilityXl = bs4gvHidden then
    AddCssValue(Result, 'hidden-xl');
  if FVisibilityPrint = bs4gvBlock then
    AddCssValue(Result, 'visible-print-block')
  else if FVisibilityPrint = bs4gvInline then
    AddCssValue(Result, 'visible-print-inline')
  else if FVisibilityPrint = bs4gvInlineBlock then
    AddCssValue(Result, 'visible-print-inline-block')
  else if FVisibilityPrint = bs4gvHidden then
    AddCssValue(Result, 'hidden-print');
  if FFloat <> bs4gfNone then
  begin
    {$IFDEF VER200}
    lNavBar := GetImplementorOfInterface(FOwner).InheritsFrom(TIWBS4CustomRegion);
    {$ELSE}
    lNavBar := FOwner is TIWBS4CustomRegion;
    {$ENDIF}
    if FFloat = bs4gfLeft then
    begin
      if lNavBar then
        AddCssValue(Result, 'navbar-left')
      else
        AddCssValue(Result, 'pull-left')
    end
    else if FFloat = bs4gfRight then
    begin
      if lNavBar then
        AddCssValue(Result, 'navbar-right')
      else
        AddCssValue(Result, 'pull-right');
    end;
  end;
end;

procedure TIWBS4GridOptions.SetFloat(const Value: TIWBS4GridFloat);
begin
  FFloat := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetGridXlOffset(const Value: Integer);
begin
  FGridXlOffset := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetGridXlspan(const Value: Integer);
begin
  FGridXlSpan := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetGridXsOffset(const Value: Integer);
begin
  FGridXsOffset := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetGridXsSpan(const Value: Integer);
begin
  FGridXsSpan := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetGridLgOffset(const Value: Integer);
begin
  FGridLgOffset := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetGridLgSpan(const Value: Integer);
begin
  FGridLgSpan := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetGridMdOffset(const Value: Integer);
begin
  FGridMdOffset := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetGridMdSpan(const Value: Integer);
begin
  FGridMdSpan := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetGridSmOffset(const Value: Integer);
begin
  FGridSmOffset := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetGridSmSpan(const Value: Integer);
begin
  FGridSmSpan := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetVisibilityXl(const Value: TIWBS4GridVisibility);
begin
  FVisibilityXl := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetVisibilityXs(const Value: TIWBS4GridVisibility);
begin
  FVisibilityXs := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetVisibilityLg(const Value: TIWBS4GridVisibility);
begin
  FVisibilityLg := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetVisibilityPrint(const Value: TIWBS4GridVisibility);
begin
  FVisibilityPrint := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetVisibilityMd(const Value: TIWBS4GridVisibility);
begin
  FVisibilityMd := Value;
  FOwner.Invalidate;
end;

procedure TIWBS4GridOptions.SetVisibilitySm(const Value: TIWBS4GridVisibility);
begin
  FVisibilitySm := Value;
  FOwner.Invalidate;
end;

function TIWBS4GridOptions.GetClassString: string;
begin
  Result := GetClassString(0, 0, 0, 0);
end;

procedure TIWBS4GridOptions.Assign(Source: TPersistent);
begin
  if Source is TIWBS4GridOptions then
  begin
    GridXsOffset := TIWBS4GridOptions(Source).GridXsOffset;
    GridXsSpan := TIWBS4GridOptions(Source).GridXsSpan;
    GridSmOffset := TIWBS4GridOptions(Source).GridSmOffset;
    GridSmSpan := TIWBS4GridOptions(Source).GridSmSpan;
    GridMdOffset := TIWBS4GridOptions(Source).GridMdOffset;
    GridMdSpan := TIWBS4GridOptions(Source).GridMdSpan;
    GridLgOffset := TIWBS4GridOptions(Source).GridLgOffset;
    GridLgSpan := TIWBS4GridOptions(Source).GridLgSpan;
    GridXlOffset := TIWBS4GridOptions(Source).GridXlOffset;
    GridXlSpan := TIWBS4GridOptions(Source).GridXlSpan;
  end
  else
  begin
    inherited;
  end;
end;
{$endregion}
{$region 'TIWBS4Common'}

class procedure TIWBS4Common.AddCssClass(var ACss: string; const AClass: string);
begin
  if ACss <> '' then
  begin
    ACss := ACss + ' ';
  end;
  ACss := Trim(ACss + AClass);
end;

class procedure TIWBS4Common.AsyncRemoveControl(const AHTMLName: string);
begin
  IWBS4ExecuteAsyncJScript('AsyncDestroyControl("' + AHTMLName + '");', False, True);
end;

class procedure TIWBS4Common.DoAfterRender(AControl: TComponent);
var
  i: Integer;
  LComponent: IIWBS4Component;
  LContainer: IIWBaseContainer;
begin
  AControl.GetInterface(IIWBS4Component, LComponent);
  if LComponent <> nil then
  begin
    if Assigned(LComponent.OnAfterRender) then
    begin
      LComponent.OnAfterRender(LComponent.InterfaceInstance);
    end;
    if Assigned(gIWBS4OnAfterRender) then
    begin
      gIWBS4OnAfterRender(LComponent.InterfaceInstance);
    end;
  end;
  if AControl is TFrame then
  begin
    for i := 0 to AControl.ComponentCount - 1 do
    begin
      DoAfterRender(AControl.Components[i])
    end;
  end
  else
  begin
    AControl.GetInterface(IIWBaseContainer, LContainer);
    if LContainer <> nil then
    begin
      for i := 0 to LContainer.IWComponentsCount - 1 do
      begin
        DoAfterRender(LContainer.Component[i])
      end;
    end;
  end;
end;

class procedure TIWBS4Common.RenderAsync(const AHTMLName: string; const AControl: IIWBS4Component; AContext: TIWCompContext);

  function ParentTreeVisibility(AControl: TComponent): Boolean;
  var
    LContainer: IIWInvisibleControlRenderer;
    LControl: IIWBaseControl;
  begin
    Result := True;
    LControl := BaseControlInterface(AControl);
    if LControl <> nil then
    begin
      if not LControl.Visible then
      begin
        GetIWInterface(LControl.ParentContainer.InterfaceInstance, IIWInvisibleControlRenderer, LContainer);
        if not LContainer.RenderInvisibleControls then
        begin
          Result := False;
        end;
      end;
      if Result and (LControl.ParentContainer <> nil) then
      begin
        Result := ParentTreeVisibility(LControl.ParentContainer.InterfaceInstance);
      end;
    end;
  end;

var
  LParentContainer: IIWBaseHTMLComponent;
  LBaseContainer: IIWBaseContainer;
  LParentSl: string;
  LHtmlTag: string;
begin
  // if not visible and parent.RenderInvisibleControls is False, do not render
  if not ParentTreeVisibility(AControl.InterfaceInstance) then
    Exit;
  // check if component context is assigned
  if AContext = nil then
  begin
    raise Exception.Create('Component context not assigned');
  end;
  // if baseContainer, DoRender;
  GetIWInterface(AControl.InterfaceInstance, IIWBaseContainer, LBaseContainer);
  if LBaseContainer <> nil then
  begin
    LBaseContainer.DoRender;
  end;
  // get parent container
  if AControl.ParentContainer.InterfaceInstance is TIWForm then
  begin
    LParentSl := 'body'
  end
  else
  begin
    LParentContainer := BaseHTMLComponentInterface(AControl.ParentContainer.InterfaceInstance);
    if LParentContainer <> nil then
      LParentSl := '#' + LParentContainer.HTMLName
    else
      Exit;
  end;
  LHtmlTag := RenderHtmlTag(AControl, AContext);
  // the creation of the controls is executed as first script in the callback response, so further scripts in callback could reference them
  IWBS4ExecuteAsyncJScript(AContext.WebApplication, 'AsyncRenderControl("' + AHTMLName + '", "' + LParentSl + '", "' + IWBS4TextToJsParamText(LHtmlTag) + '");', True, True);
  DoAfterRender(AControl.InterfaceInstance);
end;

class function TIWBS4Common.RenderHTMLTag(const AControl: IIWBS4Component; AContext: TIWCompContext): string;
var
  LContainer: IIWBS4Container;
  LBuffer: TIWRenderStream;
  LTag: TIWHTMLTag;
  LControl: TComponent;
begin
  LTag := AControl.RenderHTML(AContext);
  try
    if not BaseControlInterface(AControl.InterfaceInstance).Visible then
    begin
      TIWBS4Common.SetNotVisible(LTag.Params);
    end;
    // render child components
    LControl := AControl.InterfaceInstance;
    LControl.GetInterface(IIWBS4Container, LContainer);
    if LContainer <> nil then
    begin
      TIWBS4RegionCommon.RenderComponents(LContainer, LContainer.InitContainerContext(AContext.WebApplication), AContext.PageContext);
    end;
    LBuffer := TIWRenderStream.Create(True, True);
    try
      BaseHTMLComponentInterface(LControl).DoHTMLTag(LTag);
      LTag.Render(LBuffer);
      Result := LBuffer.AsString;
    finally
      FreeAndNil(LBuffer);
    end;
  finally
    FreeAndNil(LTag);
  end;
end;

class function TIWBS4Common.RenderStyle(const AComponent: IIWBS4Component): string;
var
  xStyle: TStringList;
  i: Integer;
  s: string;
begin
  Result := '';
  xStyle := TStringList.Create;
  try
    // assign user style
    xStyle.Assign(AComponent.Style);
    // z-index
    if AComponent.ZIndex <> 0 then
    begin
      xStyle.Values['z-index'] := IntToStr(AComponent.Zindex);
    end;
    // render cursor
    if AComponent.Cursor <> crAuto then
    begin
      xStyle.Values['cursor'] := Copy(TIWCustomControl.RenderCursorStyle(AComponent.Cursor), 9, MaxInt);
    end;
    AComponent.InternalRenderStyle(xStyle);
    for i := 0 to xStyle.Count - 1 do
    begin
      s := Trim(xStyle[i]);
      if s = '' then
      begin
        Continue;
      end;
      if (Result <> '') and (Result[Length(Result)] <> ';') then
      begin
        Result := Result + ';';
      end;
      Result := Result + s;
    end;
  finally
    xStyle.Free;
  end;
end;

class function TIWBS4Common.ReplaceParams(const AComponent: IIWBS4Component; const AScript: string; AFrom: Integer = 1): string;
var
  LF, LT, i: Integer;
  LParam, LParNm: string;
  LFound: Boolean;
  LCompo: TComponent;
  LIComp: IIWBS4Component;
begin
  Result := AScript;
  LF := PosEx('{%', Result, AFrom);
  if LF > 0 then
  begin
    LFound := False;
    LT := PosEx('%}', Result, LF);
    if LT > LF then
    begin
      LParam := Copy(Result, LF, LT - LF + 2);
      LParNm := Copy(Result, LF + 2, LT - LF - 2);
      i := AComponent.ScriptParams.IndexOfName(LParNm);
      if i >= 0 then
      begin
        Result := ReplaceStr(Result, LParam, AComponent.ScriptParams.ValueFromIndex[i]);
        LFound := True;
      end;
      i := AComponent.ScriptParams.IndexOf(LParNm);
      if i >= 0 then
      begin
        if AComponent.ScriptParams.Objects[i] is TJsonObject then
          Result := ReplaceText(Result, LParam, TJsonObject(AComponent.ScriptParams.Objects[i]).ToJSON)
        else
          Result := ReplaceText(Result, LParam, '');
      end;
      if not LFound and AnsiSameText('htmlname', LParNm) then
      begin
        Result := ReplaceStr(Result, LParam, AComponent.HTMLName);
        LFound := True;
      end;
      if not LFound and (AComponent.InterfaceInstance.Owner <> nil) then
      begin
        LCompo := AComponent.InterfaceInstance.Owner.FindComponent(LParNm);
        if LCompo <> nil then
        begin
          LCompo.GetInterface(IIWBS4Component, LIComp);
          if LIComp <> nil then
          begin
            Result := ReplaceStr(Result, LParam, LIComp.HTMLName);
            LFound := True;
          end;
        end;
      end;
      if LFound then
        Result := ReplaceParams(AComponent, Result)
      else
        Result := ReplaceParams(AComponent, Result, LF + 1);
    end;
  end;
end;

class procedure TIWBS4Common.ValidateParamName(const AName: string);
var
  i: Integer;
begin
  for i := 1 to Length(AName) do
  begin
    if not CharInSet(AName[i], ['-', '.', '0'..'9', 'A'..'Z', 'a'..'z']) then
    begin
      raise Exception.Create('Invalid character in param name ' + AName);
    end;
  end;
end;

class procedure TIWBS4Common.ValidateTagName(const AName: string);
var
  i: Integer;
begin
  if AName = '' then
  begin
    Exception.Create('Tag name could not be empty');
  end;
  for i := 1 to Length(AName) do
  begin
    if ((i = 1) and not CharInSet(AName[i], ['A'..'Z', 'a'..'z'])) or ((i > 1) and not CharInSet(AName[i], ['0'..'9', 'A'..'Z', 'a'..'z'])) then
    begin
      raise Exception.Create('Invalid character in tag name ' + AName);
    end;
  end;
end;

class procedure TIWBS4Common.SetNotVisible(AParams: TIWNameValueList);
var
  LStyle: string;
begin
  LStyle := AParams.Values['style'];
  LStyle := Trim(LStyle);
  if (LStyle <> '') and not AnsiEndsStr(';', LStyle) then
  begin
    LStyle := LStyle + ';';
  end;
  if not AnsiContainsStr(LStyle, 'visibility:') then
  begin
    LStyle := LStyle + 'visibility: hidden;';
  end;
  if not AnsiContainsStr(LStyle, 'display:') then
  begin
    LStyle := LStyle + 'display: none;';
  end;
  AParams.Values['style'] := LStyle;
end;

class procedure TIWBS4Common.SetAsyncDisabled(AApplication: TIWApplication; const HTMLName: string; Value: Boolean; var OldValue: Boolean);
begin
  if OldValue <> Value then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").prop("disabled",' + iif(Value, 'true', 'false') + ');', False, True);
    OldValue := Value;
  end;
end;

class procedure TIWBS4Common.SetAsyncReadOnly(AApplication: TIWApplication; const HTMLName: string; Value: Boolean; var OldValue: Boolean);
begin
  if OldValue <> Value then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").prop("readonly",' + iif(Value, 'true', 'false') + ');', False, True);
    OldValue := Value;
  end;
end;

class procedure TIWBS4Common.SetAsyncVisible(AApplication: TIWApplication; const HTMLName: string; Value: Boolean; var OldValue: Boolean);
begin
  if OldValue <> Value then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").css("visibility","' + iif(Value, '', 'hidden') + '");', False, True);
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").css("display","' + iif(Value, '', 'none') + '");', False, True);
    OldValue := Value;
  end;
end;

class procedure TIWBS4Common.SetAsyncText(AApplication: TIWApplication; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").val("' + TIWBaseHTMLControl.TextToJSStringLiteral(Value) + '");', True, True);
    OldValue := Value;
  end;
end;

class procedure TIWBS4Common.SetAsyncHtml(AApplication: TIWApplication; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").html("' + IWBS4TextToJsParamText(Value) + '");', True, True);
    OldValue := Value;
  end;
end;

class procedure TIWBS4Common.SetAsyncClass(AApplication: TIWApplication; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").removeClass().addClass("' + Value + '");', False, True);
    OldValue := Value;
  end;
end;

class procedure TIWBS4Common.SetAsyncStyle(AApplication: TIWApplication; const HTMLName: string; const Value: string; var OldValue: string);
begin
  if OldValue <> Value then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").prop("style","' + Value + '");', False, True);
    OldValue := Value;
  end;
end;

class procedure TIWBS4Common.SetAsyncChecked(AApplication: TIWApplication; const HTMLName: string; const Value: Boolean; var OldValue: Boolean);
begin
  if OldValue <> Value then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").prop("checked",' + iif(Value, 'true', 'false') + ');', False, True);
    OldValue := Value;
  end;
end;
{$endregion}
{$region 'THackCustomRegion'}

type
  THackTIWHTML40Container = class(TIWHTML40Container)
  private
    procedure CallInheritedRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
  end;

procedure THackTIWHTML40Container.CallInheritedRenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  inherited RenderComponents(AContainerContext, APageContext);
end;
{$endregion}
{$region 'TIWBS4RegionCommon'}

class procedure TIWBS4RegionCommon.DisableRenderOptions(StyleRenderOptions: TIWStyleRenderOptions);
begin
  StyleRenderOptions.RenderAbsolute := False;
  StyleRenderOptions.RenderBorder := False;
  StyleRenderOptions.RenderFont := False;
  StyleRenderOptions.RenderPadding := False;
  StyleRenderOptions.RenderPosition := False;
  StyleRenderOptions.RenderSize := False;
  StyleRenderOptions.RenderZIndex := False;
end;

class procedure TIWBS4RegionCommon.PrepareChildComponentsForRender(AContainer: IIWBaseContainer);
var
  i: Integer;
  LComponent: TComponent;
  LFrameRegion: TComponent;
  LRegion: TIWRegion;
  LBaseControl: IIWBaseControl;
  LHTML40Control: IIWHTML40Control;
begin
  for i := 0 to AContainer.IWComponentsCount - 1 do
  begin
    LComponent := AContainer.Component[i];
    // TFrame
    if LComponent is TFrame then
    begin
      LFrameRegion := TFrame(LComponent).FindComponent('IWFrameRegion');
      if LFrameRegion is TIWRegion then
      begin
        LRegion := TIWRegion(LFrameRegion);
        if LRegion.LayoutMgr = nil then
        begin
          LRegion.LayoutMgr := TIWBS4LayoutMgr.Create(AContainer.InterfaceInstance);
        end;
        LRegion.LayoutMgr.SetContainer(LRegion);
        PrepareChildComponentsForRender(LRegion);
      end;
    end
    else
    // tab pages of TIWBSTabControl are still TIWTabPage
      if LComponent.ClassName = 'TIWTabPage' then
    begin
      LRegion := TIWRegion(LComponent);
      if LRegion.LayoutMgr = nil then
      begin
        LRegion.LayoutMgr := TIWBS4LayoutMgr.Create(AContainer.InterfaceInstance);
      end;
      LRegion.LayoutMgr.SetContainer(LRegion);
      PrepareChildComponentsForRender(LRegion);
    end;
    // disable child StyleRenderOptions
    LBaseControl := BaseControlInterface(LComponent);
    if Assigned(LBaseControl) then
    begin
      LHTML40Control := HTML40ControlInterface(AContainer.Component[i]);
      DisableRenderOptions(LHTML40Control.StyleRenderOptions);
    end;
    // execute global OnRender hook
    if Assigned(gIWBS4OnRender) then
    begin
      gIWBS4OnRender(LComponent);
    end;
  end;
end;

class procedure TIWBS4RegionCommon.RenderComponents(AContainer: IIWBS4Container; AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
var
  LBuffer: TIWRenderStream;
  LContentTag: TIWBinaryElement;
  i, j: Integer;
  LRegionDiv: TIWHTMLTag;
  HTML40Container: THackTIWHTML40Container;
begin
  PrepareChildComponentsForRender(AContainer);
  AContainer.ContainerContext := AContainerContext;
  LBuffer := TIWRenderStream.Create(True, True);
  HTML40Container := THackTIWHTML40Container(AContainer.InterfaceInstance);
  try
    HTML40Container.CallInheritedRenderComponents(AContainerContext, APageContext);
    HTML40Container.LayoutMgr.ProcessControls(AContainerContext, TIWBaseHTMLPageContext(APageContext));
    HTML40Container.LayoutMgr.Process(LBuffer, AContainerContext, APageContext);
    // insert content before scripts
    LContentTag := TIWBinaryElement.Create(nil);
    LContentTag.Buffer.Stream.CopyFrom(LBuffer.Stream, 0);
    j := -1;
    LRegionDiv := AContainer.RegionDiv;
    for i := 0 to LRegionDiv.Contents.Count - 1 do
    begin
      if LRegionDiv.Contents.Items[i] is TIWMarkupLanguageTag then
      begin
        if TIWMarkupLanguageTag(LRegionDiv.Contents.Items[i]).Tag = 'script' then
        begin
          j := i;
        end;
      end;
    end;
    if j >= 0 then
      LRegionDiv.Contents.Insert(j, LContentTag)
    else
      LRegionDiv.Contents.Add(LContentTag);
  finally
    HTML40Container.LayoutMgr.SetContainer(nil);
    FreeAndNil(LBuffer);
  end;
end;

class procedure TIWBS4RegionCommon.CancelChildAsyncRender(AControl: TComponent);
var
  i: Integer;
  LComponent: IIWBS4Component;
  LContainer: IIWBaseContainer;
begin
  AControl.GetInterface(IIWBS4Component, LComponent);
  if LComponent <> nil then
  begin
    LComponent.ResetAsyncRefreshControl;
  end;
  if AControl is TFrame then
  begin
    for i := 0 to AControl.ComponentCount - 1 do
    begin
      CancelChildAsyncRender(AControl.Components[i])
    end;
  end
  else
  begin
    AControl.GetInterface(IIWBaseContainer, LContainer);
    if LContainer <> nil then
    begin
      for i := 0 to LContainer.IWComponentsCount - 1 do
      begin
        CancelChildAsyncRender(LContainer.Component[i])
      end;
    end;
  end;
end;
{$endregion}

end.

