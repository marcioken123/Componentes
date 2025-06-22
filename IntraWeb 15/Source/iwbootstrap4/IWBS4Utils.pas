unit IWBS4Utils;

interface

uses Classes, SysUtils, StrUtils, IWApplication;

  function IWBS4GetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;

  function IWBS4TextToJsParamText(AText: string): string;

  procedure IWBS4ExecuteAsyncJScript(AWebApplication: TIWApplication; const AScript: string;
    AsCDATA: Boolean = False; AFirst: Boolean = False); overload;
  procedure IWBS4ExecuteAsyncJScript(const AScript: string; AsCDATA: Boolean = False; AFirst: Boolean = False); overload;

  function IWBS4ExecuteAjaxEventJs(const AHtmlName, AEventName: string; const AParams: string = ''; ALock: Boolean = False): string;
{
  procedure IWBS4ExecuteJScript(AWebApplication: TIWApplication; const AScript: string); overload;
  procedure IWBS4ExecuteJScript(const AScript: string); overload;
}
implementation

uses IWXMLTag, IWCallBack, IW.Common.Strings;

type
  TIWCallBackResponseHack = class(TIWCallBackResponse);

function IWBS4GetUniqueComponentName(AOwner: TComponent; const APrefix: string): string;
var
  i: Integer;
begin
  if AOwner = nil then Exit;

  Result := APrefix;
  i := 0;
  while Assigned(AOwner.FindComponent(Result)) do
  begin
    Inc(i);
    Result := APrefix + IntToStr(i);
  end;
end;

function IWBS4TextToJsParamText(AText: string): string;
begin
  // Faster than multiple StringReplace calls
  Result := IW.Common.Strings.TextToJsonString(AText);
end;

type
  TPrevIWXMLTag = class(TIWXMLTag);

procedure IWBS4ExecuteAsyncJScript(AWebApplication: TIWApplication;
  const AScript: string; AsCDATA: Boolean = False; AFirst: Boolean = False); overload;
var
  LCallTag: TPrevIWXMLTag;
  i, j: Integer;
begin
  if Length(AScript) <= 0 then Exit;

  if AWebApplication.IsCallBack then
  begin
    if AFirst then
    begin
      LCallTag := TPrevIWXMLTag.CreateTag('literal');
      if AsCDATA
        then LCallTag.Contents.AddText('<![CDATA[' + AScript + ']]>')
        else LCallTag.Contents.AddText(AScript);
      with TIWCallBackResponseHack(AWebApplication.CallBackResponse).FExecuteTag do
      begin
        j := 0;
        for i := 0 to Contents.Count - 1 do
        begin
          if Contents.Items[i] is TPrevIWXMLTag
            then Inc(j)
            else Break;
        end;
        Contents.Insert(j, LCallTag);
      end;
    end else
    if AsCDATA
      then AWebApplication.CallBackResponse.AddJavaScriptToExecuteAsCDATA(AScript)
      else AWebApplication.CallBackResponse.AddJavaScriptToExecute(AScript);
  end;
end;

procedure IWBS4ExecuteAsyncJScript(const AScript: string; AsCDATA: Boolean = False; AFirst: Boolean = False);
var
  LWebApplication: TIWApplication;
begin
  LWebApplication := GGetWebApplicationThreadVar;
  if LWebApplication = nil then
  begin
    raise Exception.Create('User session not found');
  end;
  IWBS4ExecuteAsyncJScript(LWebApplication, AScript, AsCDATA, AFirst);
end;

function IWBS4ExecuteAjaxEventJs(const AHtmlName, AEventName: string; const AParams: string = ''; ALock: Boolean = False): string;
var
  LParams: string;
begin
  if AParams = ''
    then LParams := '""'
    else LParams := AParams;

  if ALock
    then Result := Format('ajaxCall("%s",%s, true)', [AHTMLName + '.' + AEventName, LParams])
    else Result := Format('ajaxCall("%s",%s)', [AHTMLName + '.' + AEventName, LParams]);
end;
{
procedure IWBSExecuteJScript(AWebApplication: TIWApplication; const AScript: string); overload;
begin
  if Length(AScript) <= 0 then Exit;

  if AWebApplication.IsCallBack
    then AWebApplication.CallBackResponse.AddJavaScriptToExecute(AScript)
    else HTML40FormInterface(AWebApplication.ActiveForm).PageContext.AddToInitProc(AScript);
end;

procedure IWBSExecuteJScript(const AScript: string);
var
  LWebApplication: TIWApplication;
begin
  LWebApplication := GGetWebApplicationThreadVar;
  if LWebApplication = nil then
    raise Exception.Create('User session not found');
  IWBS4ExecuteJScript(LWebApplication, AScript);
end;
}
end.
