unit IWBSRestServer;
{$i 'IWBootstrap.inc'}

interface
// this unit is compatible with IW 15.1.0 and later only

uses
  Classes, SysUtils, StrUtils, IWApplication, IW.Content.Base, IW.HTTP.Request,
  IW.HTTP.Reply, IWCallbackFunc;

type
  TIWBSRestServer = class(TContentBase)
  protected
    function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): Boolean; override;
  public
    constructor Create; override;
  end;

  TIWBSRestCallBackFunction = procedure(aApplication: TIWApplication; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings) of object;

function IWBSRegisterRestCallBack(AApplication: TIWApplication; AName: string; ARestCallbackFunction: TIWBSRestCallBackFunction; AParseFileUpload: boolean = False): string;

procedure IWBSRegisterRestServerHandler;

implementation

uses
  IW.Content.Handlers, IWURL, IWBaseForm, IW.Common.HttpPacket, IW.Parser.Files,
  IW.Common.StrLists;

const
  IWBS_RESTURLBASE = '/$iwbs/';

var
  FIsServerRegistered: boolean = False;
{$region 'RestCallBack functions'}

function IWBSRegisterRestCallBack(AApplication: TIWApplication; AName: string; ARestCallbackFunction: TIWBSRestCallBackFunction; AParseFileUpload: boolean = False): string;
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
    Result := Result + '?IWFileUploader=true';
end;

procedure IWBSPerformRestCallback(AApplication: TIWApplication; const AName: string; aRequest: THttpRequest; aReply: THttpReply; aParams: TStrings);
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

constructor TIWBSRestServer.Create;
begin
  inherited;
  mFileMustExist := False;
  mRedirectToPath := False;  // New from 15.2.38+
end;

function TIWBSRestServer.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean;
var
  i: integer;
  Doc: string;
begin
  i := Pos(IWBS_RESTURLBASE, aRequest.PathInfo);
  Doc := Copy(aRequest.PathInfo, i + Length(IWBS_RESTURLBASE), MaxInt);
  if Doc <> '' then
  begin
    try
      IWBSPerformRestCallback(aSession, Doc, aRequest, aReply, aParams);
      if aReply.DataType = rtNone then
        aReply.Code := 200;
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
    aReply.Code := 404;
  Result := True;
end;

procedure IWBSRegisterRestServerHandler;
begin
  if not FIsServerRegistered then
    THandlers.Add(IWBS_RESTURLBASE, '', TIWBSRestServer.Create);
  RegisterContentType('multipart/form-data');
  FIsServerRegistered := True;
end;

end.

