unit IWBS4LayoutMgr;

interface
{$Include IWBootstrap4.inc}

uses
  Classes, SysUtils, StrUtils, Forms, Controls, IWContainerLayout,
  IWRenderContext, IWBaseHTMLInterfaces, IWBaseRenderContext,
  IW.Common.RenderStream, IWHTMLTag;

type
  TIWBS4RenderingSortMethod = (bs4rmSortYX, bs4rmSortXY);

  {$include IWPlatformAttrib.inc}
  TIWBS4LayoutMgr = class(TIWContainerLayout)
  private
    FLinkFiles: TStringList;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    procedure AddLinkFile(const AFile: string);
    procedure AddContentFile(const AFile: string; APage: TIWBasePageContext; AToBody: Boolean = True);
    procedure ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent); override;
    procedure ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext);
    procedure Process(ABuffer: TIWRenderStream; AContainerContext: TIWContainerContext; aPage: TIWBasePageContext); override;
  end;

implementation

uses
  IWBaseForm, IWGlobal, IWHTML40Interfaces, IWBaseInterfaces, IWURL, IWMimeTypes,
  IWApplication,
  {$IFNDEF IW_14_1_0_UP} IWLists, {$ELSE} IW.Common.Lists, {$ENDIF}
  IW.Common.Strings, IWBS4Global, IWBS4Common, IWBS4CommonInterfaces,
  IWBS4TabControl;

constructor TIWBS4LayoutMgr.Create(AOnwer: TComponent);
begin
  inherited;
  SetAllowFrames(true);
  SetLayoutType(ltFlow);
end;

destructor TIWBS4LayoutMgr.Destroy;
begin
  FreeAndNil(FLinkFiles);
  inherited;
end;

procedure TIWBS4LayoutMgr.AddLinkFile(const AFile: string);
begin
  if FLinkFiles = nil then
  begin
    FLinkFiles := TStringList.Create;
  end;
  if FLinkFiles.IndexOf(AFile) = -1 then
  begin
    FLinkFiles.Add(AFile);
  end;
end;

// same as TIWForm.ProcessContentFile
procedure TIWBS4LayoutMgr.AddContentFile(const AFile: string; APage: TIWBasePageContext; AToBody: Boolean = True);
var
  LPageContext: TIWPageContext40 absolute APage;
  LFile: string;
begin
  LFile := IWTextReplace(AFile, '/<iwbspath>/', gIWBS4LibPath);
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

procedure TIWBS4LayoutMgr.ProcessForm(ABuffer, ATmpBuf: TIWRenderStream; APage: TIWBasePageContext);
var
  LUrlBase: string;
  LBodyScript: string;
  LPageContext: TIWPageContext40 absolute APage;
  LTerminated: Boolean;
  i: Integer;
  LBodyContent: TIWHTMLTagCollection;
begin
  LUrlBase := gGetWebApplicationThreadVar.AppUrlBase;
  LTerminated := Assigned(LPageContext.WebApplication) and LPageContext.WebApplication.Terminated;
  // check if IW version is compatible and is being used
  if gSC.JavaScriptOptions.RenderjQuery and (gSC.JavaScriptOptions.jQueryVersion <> '3.6.4') then
  begin
    raise Exception.Create('Please, disable JavaScriptOptions.RenderjQuery option in server controler');
  end;
  ABuffer.WriteLine(LPageContext.DocType);
  ABuffer.WriteLine(HtmlStart);
  ABuffer.WriteLine('<title>' + LPageContext.Title + '</title>');
  ABuffer.WriteLine('<meta name="viewport" content="width=device-width, initial-scale=1">');
(*ABuffer.WriteLine(PreHeadContent);*)

  // jquery. Add it to head otherwise other dependant scripts may fail
  if not gSC.JavaScriptOptions.RenderjQuery then
  begin
    AddContentFile(gIWBS4LibJQueryJs, APage, False);
  end;

  // popper
  AddContentFile(gIWBS4LibPopperJs, LPageContext);

  // bootstrap
  AddContentFile(gIWBS4LibBootstrapCss, LPageContext);
  AddContentFile(gIWBS4LibBootstrapJs, LPageContext);

  // fontawesome
  AddContentFile(gIWBS4FontAwesomeCss, LPageContext);
  // fontawesome
  if gIWBS4GoogleMaterialCss <> '' then   // otherwise will raise an exception!
  begin
    AddContentFile(gIWBS4GoogleMaterialCss, LPageContext);
  end;

  // iwbs
  AddContentFile(gIWBS4LibIWBSCss, LPageContext);
  AddContentFile(gIWBS4LibIWBSJs, LPageContext);

  // polyfiller
// if gIWBS4libPolyfiller then
//    AddContentFile(gIWBS4LibPolyfillerJs, LPageContext);

  // dynamic tabs
  if gIWBS4LibDynamicTabs then
  begin
    AddContentFile(gIWBS4LibDynamicTabsCss, LPageContext);
    AddContentFile(gIWBS4LibDynamicTabsJs, LPageContext);
  end;

  // summernote
// if gIWBS4LibSummerNote then begin
//    AddContentFile(gIWBS4LibSummerNoteCss, LPageContext);
//    AddContentFile(gIWBS4LibSummerNoteJs, LPageContext);
//  end;
  // add global linkfiles
  if gIWBS4LinkFiles <> nil then
  begin
    for i := 0 to gIWBS4LinkFiles.Count - 1 do
    begin
      AddContentFile(gIWBS4LinkFiles[i], LPageContext);
    end;
  end;
  // add LayoutMgr linkfiles
  if FLinkFiles <> nil then
  begin
    for i := 0 to FLinkFiles.Count - 1 do
    begin
      AddContentFile(FLinkFiles[i], LPageContext);
    end;
  end;

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
  begin
    LPageContext.FormTag.Render(ATmpBuf);
  end;

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
  LTop1, LLeft1, LTop2, LLeft2, LIdx1, LIdx2: Integer;
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
  if gIWBS4RenderingSortMethod = bs4rmSortYX then
  begin
    Result := LTop1 - LTop2;
    if Abs(Result) < gIWBS4RenderingGridPrecision then
    begin
      Result := LLeft1 - LLeft2;
    end;
  end
  else
  begin
    Result := LLeft1 - LLeft2;
    if Abs(Result) < gIWBS4RenderingGridPrecision then
    begin
      Result := LTop1 - LTop2;
    end;
  end;
  if Result = 0 then
  begin
    Result := LIdx1 - LIdx2;
  end;
end;

procedure TIWBS4LayoutMgr.Process(ABuffer: TIWRenderStream; AContainerContext: TIWContainerContext; aPage: TIWBasePageContext);
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
    if Container.InterfaceInstance.ClassNameIs('TIWBS4TabControl') then
    begin
      LTmp.WriteLine('<div class="tab-content">');
    end;
    // render controls
    LControls := TList.Create;
    try
      for i := 0 to AContainerContext.ComponentsCount - 1 do
      begin
        LControls.Add(AContainerContext.ComponentsList[i]);
      end;
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
          begin
            LComponent.MakeHTMLTag(LHTML, LTmp);
          end;
        end;
      end;
    finally
      LControls.Free;
    end;
    // close tabs
    if Container.InterfaceInstance.ClassNameIs('TIWBS4TabControl') then
    begin
      LTmp.WriteLine('</div>');
    end;
    // write to buffer
    if Container.InterfaceInstance is TIWBaseForm then
    begin
      ProcessForm(ABuffer, LTmp, aPage);
      TIWBS4Common.DoAfterRender(Container.InterfaceInstance);
    end
    else
    begin
      ABuffer.Stream.CopyFrom(LTmp.Stream, 0);
    end;
  finally
    LTmp.Free;
  end;
end;

procedure TIWBS4LayoutMgr.ProcessControl(AContainerContext: TIWContainerContext; APageContext: TIWBaseHTMLPageContext; AControl: IIWBaseHTMLComponent);
var
  xHTMLName: string;
  LRenderInvisibleControls: Boolean;
  LComponentContext: TIWCompContext;
  LVisible: Boolean;
  LHTML: TIWHTMLTag;
  L40Component: IIWHTML40Component;
  LInputLists: TStringList;
  i: Integer;
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
    // TIWBS4TabControl pages
    if (AControl.InterfaceInstance.ClassName = 'TIWTabPage') and (TControl(AControl.InterfaceInstance).Parent is TIWBS4TabControl) then
    begin
      LHTML.Params.Values['class'] := TIWBS4TabControl(TControl(AControl.InterfaceInstance).Parent).GetTabPageCSSClass(AControl.InterfaceInstance);
      LHTML.Params.Values['id'] := xHTMLName;
    end
    else if AControl.InterfaceInstance.GetInterfaceEntry(IIWBS4Component) = nil then
    begin
      L40Component := HTML40ComponentInterface(AControl.InterfaceInstance);
      if L40Component <> nil then
      begin
        if LHTML.Params.Values['id'] = '' then
        begin
          LHTML.AddStringParam('id', xHTMLName);
        end;
        if L40Component.SupportsInput and (AControl.HasName) and (LHTML.Params.Values['name'] = '') then
        begin
          LHTML.AddStringParam('name', xHTMLName);
        end;
        if LHTML.Params.Values['class'] = '' then
        begin
          LHTML.AddStringParam('class', L40Component.RenderCSSClass(nil));
        end;
        LHTML.Params.Values['style'] := L40Component.RenderStyle(LComponentContext) + LHTML.Params.Values['style'];
      end;
    end
    else
    begin
      if not LVisible and LRenderInvisibleControls then
      begin
        TIWBS4Common.SetNotVisible(LHTML.Params);
      end;
    end;
  end;

  // render hidden inputs for submit
  if AControl.SupportsInput then
  begin
    LInputLists := TStringList.Create;
    try
      InputInterface(AControl.InterfaceInstance).GetInputControlNames(LInputLists);
      if LVisible or LRenderInvisibleControls then
      begin
        for i := 0 to LInputLists.Count - 1 do
        begin
          APageContext.AppendHiddenInput(LInputLists.Strings[i]);
        end;
      end;
    finally
      LInputLists.Free;
    end;
  end;
  APageContext.AppendContext(LComponentContext);
end;

//initialization
// No need to register this. IW 15.2.x already support these file types
//  TIWMimeTypes.RegisterType('.woff', 'text/html; charset=UTF-8', True);
//  TIWMimeTypes.RegisterType('.woff2', 'text/html; charset=UTF-8', True);

end.

