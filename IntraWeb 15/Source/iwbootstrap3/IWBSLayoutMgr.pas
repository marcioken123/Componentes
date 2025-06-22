unit IWBSLayoutMgr;

interface
{$Include IWBootstrap.inc}

uses
  Classes, SysUtils, StrUtils, Forms, Controls, IWContainerLayout,
  IWRenderContext, IWBaseHTMLInterfaces, IWBaseRenderContext,
  IW.Common.RenderStream, IWHTMLTag;

type
  TIWBSRenderingSortMethod = (bsrmSortYX, bsrmSortXY);

  {$include IWPlatformAttrib.inc}
  TIWBSLayoutMgr = class(TIWContainerLayout)
  protected
    FLinkFiles: TStringList;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    procedure AddLinkFile(const AFile: string);
    procedure AddContentFile(const AFile: string; APage: TIWBasePageContext; AToBody: Boolean = True);
    procedure ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent); override;
    procedure ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext); virtual;
    procedure Process(ABuffer: TIWRenderStream; AContainerContext: TIWContainerContext; aPage: TIWBasePageContext); override;
  end;

implementation

uses
  IWBaseForm, IWGlobal, IWHTML40Interfaces, IWBaseInterfaces, IWURL, IWMimeTypes,
  IWApplication, IW.Common.Lists, IW.Common.Strings, IWBSGlobal, IWBSCommon,
  IWBSCommonInterfaces, IWBSTabControl;

constructor TIWBSLayoutMgr.Create(AOnwer: TComponent);
begin
  inherited;
  SetAllowFrames(true);
  SetLayoutType(ltFlow);
end;

destructor TIWBSLayoutMgr.Destroy;
begin
  FreeAndNil(FLinkFiles);
  inherited;
end;

procedure TIWBSLayoutMgr.AddLinkFile(const AFile: string);
begin
  if FLinkFiles = nil then
    FLinkFiles := TStringList.Create;
  if FLinkFiles.IndexOf(AFile) = -1 then
    FLinkFiles.Add(AFile);
end;

// same as TIWForm.ProcessContentFile
procedure TIWBSLayoutMgr.AddContentFile(const AFile: string; APage: TIWBasePageContext; AToBody: Boolean = True);
var
  LPageContext: TIWPageContext40 absolute APage;
  LFile: string;
begin
  LFile := IWTextReplace(AFile, '/<iwbspath>/', gIWBSLibPath);
  if SameText(ExtractFileExt(LFile), '.js') then
  begin
    if AToBody then
    begin
      LPageContext.AddBodyScriptFile(LFile);
    end
    else
    begin
      LPageContext.AddScriptFile(LFile);
    end;
  end
  else
  begin
    LPageContext.AddLinkFile(LFile)
  end;
end;

procedure TIWBSLayoutMgr.ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext);
var
  LUrlBase: string;
  LBodyScript: string;
  LPageContext: TIWPageContext40 absolute APage;
  LTerminated: Boolean;
  i: integer;
  LBodyContent: TIWHTMLTagCollection;
begin
  LUrlBase := gGetWebApplicationThreadVar.AppUrlBase;
  LTerminated := Assigned(LPageContext.WebApplication) and LPageContext.WebApplication.Terminated;
  // check if IW version is compatible and is being used
  if gSC.JavaScriptOptions.RenderjQuery and (gSC.JavaScriptOptions.jQueryVersion <> '3.6.4') then
    raise Exception.Create('Please, disable JavaScriptOptions.RenderjQuery option in server controller');
  ABuffer.WriteLine(LPageContext.DocType);
  ABuffer.WriteLine(HtmlStart);
  ABuffer.WriteLine('<title>' + LPageContext.Title + '</title>');
  ABuffer.WriteLine('<meta name="viewport" content="width=device-width, initial-scale=1">');
  ABuffer.WriteLine(PreHeadContent);

  // jquery. Add it to head otherwise other dependant scripts may fail
  if not gSC.JavaScriptOptions.RenderjQuery then
  begin
    AddContentFile(gIWBSLibJQueryJs, APage, False);
  end;

  // bootstrap
  AddContentFile(gIWBSLibBootstrapCss, APage);
  AddContentFile(gIWBSLibBootstrapJs, APage);

  // iwbs
  AddContentFile(gIWBSLibIWBSCss, APage);
  AddContentFile(gIWBSLibIWBSJs, APage);

  // polyfiller
  if gIWBSlibPolyfiller then
    AddContentFile(gIWBSLibPolyfillerJs, APage);

  // dynamic tabs
  if gIWBSLibDynamicTabs then
  begin
    AddContentFile(gIWBSLibDynamicTabsCss, APage);
    AddContentFile(gIWBSLibDynamicTabsJs, APage);
  end;

  // summernote
  if gIWBSLibSummerNote then
  begin
    AddContentFile(gIWBSLibSummerNoteCss, APage);
    AddContentFile(gIWBSLibSummerNoteJs, APage);
  end;

  // add global linkfiles
  if gIWBSLinkFiles <> nil then
    for i := 0 to gIWBSLinkFiles.Count - 1 do
      AddContentFile(gIWBSLinkFiles[i], APage);

  // add LayoutMgr linkfiles
  if FLinkFiles <> nil then
    for i := 0 to FLinkFiles.Count - 1 do
      AddContentFile(FLinkFiles[i], APage);

  HeadContent := LPageContext.RenderScriptFiles + EOL + LPageContext.ExtraHeader.Text + EOL + HeadContent;

  ABuffer.WriteLine('<script data-type="iw" nonce="' + LPageContext.Nonce + '">var IWBSAppBaseUrl = "' + LUrlBase + '";</script>');
  ABuffer.WriteLine(ScriptSection(LPageContext));
  ABuffer.WriteLine(HeadContent);
  if LPageContext.StyleTag.Contents.Count > 0 then
  begin
    LPageContext.StyleTag.Render(ABuffer);
  end;
  ABuffer.WriteLine('</head>');
  if not LTerminated then
    LPageContext.FormTag.Render(ATmpBuf);

  LBodyContent := LPageContext.BodyTag.Contents;

  LBodyContent.AddScriptTag('doOnReady(function(){ Initialize();} );', LPageContext.Nonce);
  LBodyScript := LPageContext.RenderBodyScriptFiles;
  if LBodyScript <> '' then
  begin
    LBodyContent.AddText(LBodyScript);
  end;
  // Body script code comes right after Body script files
  if LPageContext.BodyScript <> '' then
  begin
    LBodyContent.AddScriptTag(LPageContext.BodyScript, LPageContext.Nonce);
  end;
  // JavaScript module tag
  if LPageContext.BodyScriptModule <> '' then
  begin
    LBodyContent.AddScriptTag(LPageContext.BodyScriptModule, LPageContext.Nonce).AddStringParam('type', 'module');
  end;
  LBodyContent.AddBuffer(ATmpBuf);
  LPageContext.BodyTag.Render(ABuffer);
  ABuffer.WriteLine('</html>');
end;

function ControlRenderingSort(AItem1: Pointer; AItem2: Pointer): Integer;
var
  LTop1, LLeft1, LTop2, LLeft2, LIdx1, LIdx2: integer;
begin
  if TComponent(AItem1) is TControl then
  begin
    LTop1 := TControl(AItem1).Top;
    LLeft1 := TControl(AItem1).Left;
    LIdx1 := TControl(AItem1).ComponentIndex;
  end
  else
  begin
    LTop1 := -1;
    LLeft1 := -1;
    LIdx1 := -1;
  end;
  if TComponent(AItem2) is TControl then
  begin
    LTop2 := TControl(AItem2).Top;
    LLeft2 := TControl(AItem2).Left;
    LIdx2 := TControl(AItem2).ComponentIndex;
  end
  else
  begin
    LTop2 := -1;
    LLeft2 := -1;
    LIdx2 := -1;
  end;
  if gIWBSRenderingSortMethod = bsrmSortYX then
  begin
    Result := LTop1 - LTop2;
    if Abs(Result) < gIWBSRenderingGridPrecision then
      Result := LLeft1 - LLeft2;
  end
  else
  begin
    Result := LLeft1 - LLeft2;
    if Abs(Result) < gIWBSRenderingGridPrecision then
      Result := LTop1 - LTop2;
  end;
  if Result = 0 then
    Result := LIdx1 - LIdx2;
end;

procedure TIWBSLayoutMgr.Process(ABuffer: TIWRenderStream; AContainerContext: TIWContainerContext; aPage: TIWBasePageContext);
var
  LTmp: TIWRenderStream;
  LControls: TList;
  i: Integer;
  LComponent: IIWBaseHTMLComponent;
  xCompContext: TIWCompContext;
  LHTML: TIWHTMLTag;
begin
  LTmp := TIWRenderStream.Create(True, True);
  try
    LTmp.Data := aPage;
    // TIWBSTabControl (investigate how to move this to IWBSTabControl)
    if Container.InterfaceInstance.ClassNameIs('TIWBSTabControl') then
      LTmp.WriteLine('<div class="tab-content">');
    // render controls
    LControls := TList.Create;
    try
      for i := 0 to AContainerContext.ComponentsCount - 1 do
        LControls.Add(AContainerContext.ComponentsList[i]);
      MergeSortList(LControls, ControlRenderingSort);
      for i := 0 to LControls.Count - 1 do
      begin
        if isBaseComponent(LControls[i]) then
        begin
          LComponent := BaseHTMLComponentInterface(LControls[i]);
          xCompContext := TIWCompContext(AContainerContext.ComponentContext[LComponent.HTMLName]);
          if not AContainerContext.CacheControls then
          begin
            xCompContext.HTMLTag.Free;
            xCompContext.HTMLTag := TIWHTMLTag(BaseComponentInterface(xCompContext.Component).RenderMarkupLanguageTag(xCompContext));
          end;
          LHTML := xCompContext.HTMLTag;
          if LHTML <> nil then
            LComponent.MakeHTMLTag(LHTML, LTmp);
        end;
      end;
    finally
      LControls.Free;
    end;
    // close tabs
    if Container.InterfaceInstance.ClassNameIs('TIWBSTabControl') then
      LTmp.WriteLine('</div>');
    // write to buffer
    if Container.InterfaceInstance is TIWBaseForm then
    begin
      ProcessForm(ABuffer, LTmp, aPage);
      TIWBSCommon.DoAfterRender(Container.InterfaceInstance);
    end
    else
      ABuffer.Stream.CopyFrom(LTmp.Stream, 0);
  finally
    LTmp.Free;
  end;
end;

procedure TIWBSLayoutMgr.ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent);
var
  xHTMLName: string;
  LRenderInvisibleControls: Boolean;
  LComponentContext: TIWCompContext;
  LVisible: boolean;
  LHTML: TIWHTMLTag;
  L40Component: IIWHTML40Component;
  LInputLists: TStringList;
  i: integer;
begin
  xHTMLName := AControl.HTMLName;
  if SupportsInterface(Container.InterfaceInstance, IIWInvisibleControlRenderer) then
    LRenderInvisibleControls := (Container as IIWInvisibleControlRenderer).RenderInvisibleControls
  else
    LRenderInvisibleControls := False;
  LComponentContext := TIWCompContext(AContainerContext.ComponentContext[xHTMLName]);
  if SupportsInterface(AControl.InterfaceInstance, IIWBaseControl) then
    LVisible := BaseControlInterface(AControl.InterfaceInstance).Visible
  else
    LVisible := True;
  LHTML := LComponentContext.HTMLTag;
  if Assigned(LHTML) then
  begin
    // TIWBSTabControl pages
    if (AControl.InterfaceInstance.ClassName = 'TIWTabPage') and (TControl(AControl.InterfaceInstance).Parent is TIWBSTabControl) then
    begin
      LHTML.Params.Values['class'] := TIWBSTabControl(TControl(AControl.InterfaceInstance).Parent).GetTabPageCSSClass(AControl.InterfaceInstance);
      LHTML.Params.Values['id'] := xHTMLName;
    end
    else if AControl.InterfaceInstance.GetInterfaceEntry(IIWBSComponent) = nil then
    begin
      L40Component := HTML40ComponentInterface(AControl.InterfaceInstance);
      if L40Component <> nil then
      begin
        if LHTML.Params.Values['id'] = '' then
          LHTML.AddStringParam('id', xHTMLName);
        if L40Component.SupportsInput and (AControl.HasName) and (LHTML.Params.Values['name'] = '') then
          LHTML.AddStringParam('name', xHTMLName);
        if LHTML.Params.Values['class'] = '' then
          LHTML.AddStringParam('class', L40Component.RenderCSSClass(nil));
        LHTML.Params.Values['style'] := L40Component.RenderStyle(LComponentContext) + LHTML.Params.Values['style'];
      end;
    end
    else
    begin
      if not LVisible and LRenderInvisibleControls then
        TIWBSCommon.SetNotVisible(LHTML.Params);
    end;
  end;
  // render hidden inputs for submit
  if AControl.SupportsInput then
  begin
    LInputLists := TStringList.Create;
    try
      InputInterface(AControl.InterfaceInstance).GetInputControlNames(LInputLists);
      if LVisible or LRenderInvisibleControls then
        for i := 0 to LInputLists.Count - 1 do
          APageContext.AppendHiddenInput(LInputLists.Strings[i]);
    finally
      LInputLists.Free;
    end;
  end;
  APageContext.AppendContext(LComponentContext);
end;

initialization
// No need to register it. IW 15.2.x already registers these types
//  TIWMimeTypes.RegisterType('.woff','text/html; charset=UTF-8',True);
//  TIWMimeTypes.RegisterType('.woff2','text/html; charset=UTF-8',True);



end.

