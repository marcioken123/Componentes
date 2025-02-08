unit JSTemplateEngineImpl;
{$I lmddlgcmps.inc}

interface

{$IFDEF DELPHI2006}

uses
  ToolsAPI, CodeTemplateAPI, DesignEditors;

type
  TMethodToCall = (mcMessageDlg, mcTaskDialog, mcJSDialog);

  TTemplateScriptEngine = class(TNotifierObject, IOTACodeTemplateScriptEngine)
  public
    procedure Execute(const ATemplate: IOTACodeTemplate;
                      const APoint: IOTACodeTemplatePoint;
                      const ASyncPoints: IOTASyncEditPoints;
                      const AScript: IOTACodeTemplateScript;
                      var Cancel: Boolean);
    function GetIDString: WideString;
    function GetLanguage: WideString;
  end;

procedure Register;

{$ENDIF}

implementation

{$IFDEF DELPHI2006}

uses
  SysUtils, Windows, Classes, ShellAPI, JSDialog, JSDialogs, TypInfo,
  Forms, WideStrUtils, WideStrings;

procedure Register;
begin
  (BorlandIDEServices as IOTACodeTemplateServices).RegisterScriptEngine(
    TTemplateScriptEngine.Create);
end;

{ TTemplateScriptEngine }

procedure TTemplateScriptEngine.Execute(const ATemplate: IOTACodeTemplate;
  const APoint: IOTACodeTemplatePoint; const ASyncPoints: IOTASyncEditPoints;
  const AScript: IOTACodeTemplateScript; var Cancel: Boolean);
var
  i: Integer;
  SL: TWideStringList;
  param1: WideString;
  param2: WideString;
  param3: WideString;
  param4: WideString;
  param5: WideString;
  param6: WideString;
  lValidMethodType: Integer;
  lMethodToCall: TMethodToCall;
  lMethodValid: Boolean;
  lDlgType: TMsgDlgType;
  lDlgButtons: TMsgDlgButtons;
  j: TMsgDlgType;
  y: TMsgDlgBtn;
  slTemp: TStringList;
  x: Integer;
begin
  Cancel := True;
  // check whether the elements we need are passed to us
  if (AScript <> nil) and (ASyncPoints <> nil) then
  begin
    SL := TWideStringList.Create;
    try
      // load the script
      SL.Text := AScript.Script;
      // trim every line - again, not a good way to do it, but it suffices this purpose
      for i := 0 to SL.Count - 1 do
        SL[i] := Trim(SL[i]);

      lValidMethodType := StrToIntDef(SL.Values['type'], -1);

      lMethodToCall := mcMessageDlg;

      lMethodValid := (lValidMethodType >= 0) and (lValidMethodType <= 2);
      if lMethodValid then
      begin
        try
          lMethodToCall := TMethodToCall(lValidMethodType);
        except
          lMethodValid := False;
        end;
      end;

      if not lMethodValid then
        exit;

      param1 := SL.Values['param1'];
      param2 := SL.Values['param2'];
      param3 := SL.Values['param3'];
      param4 := SL.Values['param4'];
      param5 := SL.Values['param5'];
      param6 := SL.Values['param6'];

      for i := 0 to ASyncPoints.Count - 1 do
      begin
        if WideSameText(ASyncPoints.Points[i].Name, param1) then
          param1 := ASyncPoints.Points[i].Text;
        if WideSameText(ASyncPoints.Points[i].Name, param2) then
          param2 := ASyncPoints.Points[i].Text;
        if WideSameText(ASyncPoints.Points[i].Name, param3) then
          param3 := ASyncPoints.Points[i].Text;
        if WideSameText(ASyncPoints.Points[i].Name, param4) then
          param4 := ASyncPoints.Points[i].Text;
        if WideSameText(ASyncPoints.Points[i].Name, param5) then
          param5 := ASyncPoints.Points[i].Text;
        if WideSameText(ASyncPoints.Points[i].Name, param6) then
          param6 := ASyncPoints.Points[i].Text;
      end;

      case lMethodToCall of
        mcMessageDlg:
          begin
            lDlgType := mtError;
            for j := low(TMsgDlgType) to high(TMsgDlgType)do
            begin
              if WideSameText(GetEnumName(TypeInfo(TMsgDlgType), ord(j)), param2) then
              begin
                lDlgType := j;
                break;
              end;
            end;
            slTemp := TStringList.Create;
            try
              param3 := copy(param3, 2, Length(param3) - 2);
              slTemp.StrictDelimiter := True;
              slTemp.Delimiter := ',';
              param3 := StringReplace(param3, ' ', '', [rfReplaceAll]);
              slTemp.CommaText := param3;
              lDlgButtons := [];
              for x := 0 to slTemp.Count - 1 do
              begin
                for y := low(TMsgDlgBtn) to high(TMsgDlgBtn)do
                begin
                  if WideSameText(GetEnumName(TypeInfo(TMsgDlgBtn), ord(y)), slTemp[x]) then
                  begin
                    lDlgButtons := lDlgButtons + [y];
                    break;
                  end;
                end;
              end;
            finally
              slTemp.Free;
            end;
            MessageDlg(AnsiDequotedStr(param1, ''''), lDlgType, lDlgButtons, StrToIntDef(param4, 0));
          end;
        mcTaskDialog: jsdialogs.TaskDialog({StrToIntDef(param1, 0)}Application.MainForm.Handle,
                        AnsiDequotedStr(param2, ''''), AnsiDequotedStr(param3, ''''),
                        AnsiDequotedStr(param4, ''''),
                        StrToIntDef(param5, TD_ICON_ERROR),
                        StrToIntDef(param6, TD_BUTTON_CLOSE));
        mcJSDialog: ;
      end;
    finally
      SL.Free;
    end;
  end;
  Cancel := False;
end;

function TTemplateScriptEngine.GetIDString: WideString;
begin
  Result := 'LMD.DIALOGPACK.TEMPLATEENGINE';
end;

function TTemplateScriptEngine.GetLanguage: WideString;
begin
  // The value returned is the one, that the IDE will match when
  // encountering a script node in the live template xml file
	// <script language="lmddialogpack" ...
  Result := 'lmddialogpack';
end;

{$ENDIF}

end.
