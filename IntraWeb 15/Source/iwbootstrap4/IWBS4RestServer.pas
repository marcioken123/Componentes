unit IWBS4RestServer;
{$i 'IWBootstrap4.inc'}

interface
// this unit is compatible with IW 15.1.0 and later only

uses
  Classes, SysUtils, StrUtils, IWApplication, IW.Content.Base, IW.HTTP.Request,
  IW.HTTP.Reply, IWCallbackFunc;

type
  TIWBS4RestServer = class(TContentBase)
  protected
    function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): Boolean; override;
  public
    constructor Create; override;
  end;

  TIWBS4RestCallBackFunction = procedure(aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings) of object;

function IWBS4RegisterRestCallBack(AApplication: TIWApplication; AName: string; ARestCallbackFunction: TIWBS4RestCallBackFunction; AParseFileUpload: Boolean = False): string;

procedure IWBS4RegisterRestServerHandler;

implementation

uses
  IW.Content.Handlers, IWURL, IWBaseForm, IW.Common.HttpPacket, IW.Parser.Files,
  IW.Common.StrLists;

const
  IWBS_RESTURLBASE = '/$iwbs/';

var
  FIsServerRegistered: Boolean = False;

{$region 'RestCallBack functions'}

function IWBS4RegisterRestCallBack(AApplication: TIWApplication; AName: string; ARestCallbackFunction: TIWBS4RestCallBackFunction; AParseFileUpload: Boolean = False): string;
var
  LProc: TIWCallbackProc3;
begin
  LProc :=
    procedure(aParams: TStrings; out aResult: string; var aHandled: Boolean)
    begin
      aHandled := True; // we write our own response
      ARestCallbackFunction(AApplication, AApplication.Request, AApplication.Response, aParams);
    end;

  AApplication.RegisterCallBack(AName, LProc);

  Result := TURL.Concat(AApplication.SessionUrlBase, IWBS_RESTURLBASE + AName);
  if AParseFileUpload then
  begin
    Result := Result + '?IWFileUploader=true';
  end;
end;

procedure IWBS4PerformRestCallback(AApplication: TIWApplication; const AName: string; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings);
var
  LActiveForm: TIWBaseForm;
begin
  if Assigned(AApplication) and Assigned(AApplication.ActiveForm) then
  begin
    LActiveForm := TIWBaseForm(AApplication.ActiveForm);
    // Request params are assigned directly to Form.Params here.
    // This bypasses all parameter processing done by IntraWeb
    // (e.g. security checks and form rendering)
    // The IWBS code must be reponsible for it
    (LActiveForm.Params as TIWStringList).AssignStrings(TStringList(aParams));
    AApplication.PerformCallBack(nil, AName);
  end;
end;
{$endregion}

constructor TIWBS4RestServer.Create;
begin
  inherited;
  mFileMustExist := False;
  mRedirectToPath := False;  // New from 15.2.38+
end;

function TIWBS4RestServer.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): Boolean;
var
  i: integer;
  Doc: string;
begin
  i := Pos(IWBS_RESTURLBASE, aRequest.PathInfo);
  Doc := Copy(aRequest.PathInfo, i + Length(IWBS_RESTURLBASE), MaxInt);
  if Doc <> '' then
  begin
    try
      IWBS4PerformRestCallback(aSession, Doc, aRequest, aReply, aParams);
      if aReply.DataType = rtNone then
      begin
        aReply.Code := 200;
      end;
    except
      on E: Exception do
      begin
        aReply.ResetReplyType;
        aReply.Clear;
        aReply.Code := 500;
        aReply.ContentType := 'text/plain';
        aReply.WriteString(E.Message);
      end;
    end;
  end
  else
  begin
    aReply.Code := 404;
  end;
  Result := True;
end;

procedure IWBS4RegisterRestServerHandler;
begin
  if not FIsServerRegistered then
  begin
    THandlers.Add(IWBS_RESTURLBASE, '', TIWBS4RestServer.Create);
  end;

  RegisterContentType('multipart/form-data');

  FIsServerRegistered := True;
end;

end.

