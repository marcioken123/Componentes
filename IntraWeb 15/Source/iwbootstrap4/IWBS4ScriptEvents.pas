unit IWBS4ScriptEvents;

interface
{$Include IWBootstrap4.inc}

uses
  Classes, SysUtils, StrUtils, IWScriptEvents, IWRenderContext, IWHTMLTag,
  IWHTML40Interfaces, IWBS4Common, IWBS4CommonInterfaces;

procedure IWBS4RenderScript(AComponent: IIWBS4Component; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);

implementation

uses
  IW.Common.Strings, IWBaseInterfaces, IWBS4CustomEvents;

type
  TIWBS4ScriptEvents = class(IWScriptEvents.TIWScriptEvents)
  end;

procedure RenderScriptEvents(const AHTMLName: string; AScriptEvents: TIWScriptEvents; APageContext: TIWPageContext40; AScript: TStringList);
var
  LScriptEvents: TIWBS4ScriptEvents;
  i: Integer;
  LEventName, LFuncCode: string;
  LInitProc: string;
begin
  LScriptEvents := TIWBS4ScriptEvents(AScriptEvents);

  LInitProc := '';
  if (LScriptEvents.Count > 0) or (LScriptEvents.DefaultHandlers <> '') or (not LScriptEvents.FProperties.IsEmpty) then
  begin
    for i := 0 to LScriptEvents.Count - 1 do
    begin
      // legacy IW events, declare only content of the function
      if AnsiStartsText('on', LScriptEvents.Items[i].EventName) then
      begin
        LEventName := LowerCase(LScriptEvents.Items[i].EventName);
        if Pos('on', LEventName) = 1 then
          Delete(LEventName, 1, 2);
        LFuncCode := 'function(event) { ' + Trim(LScriptEvents.Items[i].EventCode.Text) + '}';
      end
      // new way, full funtion declaration
      else
      begin
        if AnsiStartsStr('"', LScriptEvents.Items[i].EventName) then
          LEventName := AnsiDequotedStr(LScriptEvents.Items[i].EventName, '"')
        else
          LEventName := LScriptEvents.Items[i].EventName;
        LFuncCode := Trim(LScriptEvents.Items[i].EventCode.Text);
      end;
      AScript.Add('$("#' + AHTMLName + '").off("' + LEventName + '").on("' + LEventName + '", ' + LFuncCode + ');');
    end;

    if LScriptEvents.FDefaultHandlers <> '' then
    begin
      RemoveTrailingChars(LScriptEvents.FDefaultHandlers, ';');
      LInitProc := LInitProc + AHTMLName + 'IWCL.HookDefaultHandlers("' + LScriptEvents.FDefaultHandlers + '");' + EOL;
    end;

    if not LScriptEvents.FProperties.IsEmpty then
    begin
      LInitProc := LInitProc + '  ' + AHTMLName + 'IWCL.SetProps(' + LScriptEvents.FProperties.Data + ');' + EOL;
    end;

    if LInitProc <> '' then
      APageContext.AddToIWCLInitProc('  if (' + AHTMLName + 'IWCL) {' + EOL + '    ' + LInitProc + '  }');
  end;
end;

procedure IWBS4RenderScript(AComponent: IIWBS4Component; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  LHTMLName: string;
  LPageContext: TIWPageContext40;
  LSubmitOnAsync: Boolean;
  LInputInterface: IIWInputControl40;
  LInitProcCode: string;
  LJScript: TStringList;
  I: Integer;
  LHTMLTag: TIWHTMLTag;
begin
  LHTMLName := AComponent.HTMLName;
  LPageContext := TIWPageContext40(AContext.PageContext);

  LSubmitOnAsync := False;
  if AComponent.SupportsInput then
  begin
    LInputInterface := InputControl40Interface(AComponent.InterfaceInstance);
    if Assigned(LInputInterface) then
      LSubmitOnAsync := LInputInterface.SubmitOnAsyncEvent;
  end;

  {$IFNDEF IW_15}  // Anything prior to IW 15
  LInitProcCode := '  IW.initIWCL(' + AComponent.HTMLControlImplementation.IWCLParentName + ',"' + LHTMLName + '",' + BoolToString(LSubmitOnAsync) + ');';
  LPageContext.AddToIWCLInitProc(LInitProcCode);
  {$ELSE}          // IW 15 or newer use a minified func name
  LInitProcCode := '  f(' + AComponent.HTMLControlImplementation.IWCLParentName + ',"' + LHTMLName + '",' + BoolToString(LSubmitOnAsync) + ');';
  LPageContext.AppendIWCLInitProc(EOL + LInitProcCode);
  {$ENDIF}

  AComponent.ScriptEvents.ClearHooked;
  AComponent.ScriptEvents.Rendering := True;
  LJScript := TStringList.Create;
  try
    AComponent.HookEvents(LPageContext, AComponent.ScriptEvents);
    AComponent.HintEvents(AHTMLTag);

    RenderScriptEvents(LHTMLName, AComponent.ScriptEvents, LPageContext, LJScript);

    AComponent.InternalRenderScript(AContext, LHTMLName, LJScript);

    LJScript.AddStrings(AComponent.Script);

    if LJScript.Count > 0 then
      LJScript.Text := TIWBS4Common.ReplaceParams(AComponent, LJScript.Text);

    if AComponent.IsStoredCustomAsyncEvents then
    begin
      for I := 0 to AComponent.CustomAsyncEvents.Count - 1 do
      begin
        AComponent.CustomAsyncEvents.Items[I].RegisterEvent(AContext.WebApplication, LHTMLName);
        AComponent.CustomAsyncEvents.Items[I].ParseParam(LJScript);
        if AComponent.CustomAsyncEvents.Items[I].AutoBind and (AComponent.CustomAsyncEvents.Items[I].EventName <> '') then
        begin
          LJScript.Add('$("#' + LHTMLName + '").off("' + AComponent.CustomAsyncEvents.Items[I].EventName + '").on("' + AComponent.CustomAsyncEvents.Items[I].EventName + '", function(' + AComponent.CustomAsyncEvents.Items[I].EventParams + ') {' + AComponent.CustomAsyncEvents.Items[I].GetScript + '});');
        end;
      end;
      LJScript.Text := TIWBS4Common.ReplaceParams(AComponent, LJScript.Text);
    end;

    if AComponent.IsStoredCustomRestEvents then
      for I := 0 to AComponent.CustomRestEvents.Count - 1 do
      begin
        AComponent.CustomRestEvents.Items[I].RegisterEvent(AContext.WebApplication, LHTMLName);
        AComponent.CustomRestEvents.Items[I].ParseParam(LJScript);
      end;

    if LJScript.Count > 0 then
    begin
      if not AComponent.ScriptInsideTag then
      begin
        LHTMLTag := TIWHTMLTag.CreateTag('div');
        LHTMLTag.AddStringParam('id', LHTMLName + '_WRP');
        LHTMLTag.Contents.AddTagAsObject(AHTMLTag);
        AHTMLTag := LHTMLTag;
      end;
      AHTMLTag.Contents.AddTag('script').Contents.AddText(LJScript.Text);
    end;
  finally
    LJScript.Free;
    AComponent.ScriptEvents.Rendering := False;
    AComponent.ScriptEvents.ClearHooked;
  end;
end;

end.

