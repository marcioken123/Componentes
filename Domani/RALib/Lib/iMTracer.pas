unit iMTracer;
{ ��������� � Tracer'�  ����� ���������}
 
interface
{$DEFINE DEBUG}

{$IFDEF DEBUG}
uses Windows, Messages{, Forms};

type
  PTracerInfo = ^TTracerInfo;
  TTracerCommand = word;

  TTracerSocket = class
  private
    FPDI : PTracerInfo;
    hFileMap : THandle;
    FEnabled : boolean;
    procedure Post(Command : TTracerCommand; Param : Word);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Writeln(const S : string);
    procedure Clear;
    procedure TimerStart(Timer : integer);
    procedure TimerStop(Timer : integer);
    property PDI : PTracerInfo read FPDI;
    property Enabled : boolean read FEnabled;
  end;

  TTracerInfo = record
    RemoteAppName : string[255];
    S : string[255];
    Data : boolean;
  end;

  TWMTracer = record
    Msg: Cardinal;
    Command : TTracerCommand;
    wParam  : Word;
    Unused: array[0..1] of Word;
    Result: Longint;
  end;

const
  wm_Tracer = wm_User+200;
  RATracerSignatur = 'R&A Tracer Info';

 {Tracer Commands}
  dc_Writeln         = 1;
  dc_Clear           = 2;
  dc_RemoteAppClosed = 3;
  dc_TimerStart      = 4;
  dc_TimerStop       = dc_TimerStart + 1;

  function Tracer : TTracerSocket;

var
  TracerApp : boolean = false;
{$ENDIF DEBUG}

  procedure ODS(S : string);

implementation

{$IFDEF DEBUG}
var
  FTracer : TTracerSocket = nil;

constructor TTracerSocket.Create;
begin
  inherited Create;
  hFileMap := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, sizeof(TTracerInfo), RATracerSignatur);
  if hFileMap = 0 then exit;
  FPDI := MapViewOfFile(hFileMap, FILE_MAP_WRITE, 0, 0, 0);
  FEnabled := PDI <> nil;
end;

destructor TTracerSocket.Destroy;
begin
  if FEnabled then Post(dc_RemoteAppClosed, 0);
  if FPDI <> nil then UnMapViewOfFile(FPDI);
  if hFileMap <> 0 then CloseHandle(hFileMap);
  inherited Destroy;
end;

procedure TTracerSocket.Post(Command : TTracerCommand; Param : Word);
var
  H : HWnd;
begin
  H := FindWindow('TTracerMain', nil);
  if H > 0 then begin
    if not TracerApp then FPDI.RemoteAppName := ParamStr(0);
    SendMessage(H, wm_Tracer, Param shl 16 + Command, 0);
    { ���������� ������������ SendMessage � �� PostMessage,
      �.�. ��� ���������� ��������� ���� ������� ������
      � ���� Tracer �� ����� �������� ������������ ���������
      �� ��� ����� ���������� ������.
        ��� ���������� ���������� ����� ����������� ������������
      ������ �������������� ��������� � ����������� ������... }
  end;
end;

procedure TTracerSocket.Writeln(const S : string);
begin
  if not FEnabled then exit;
  FPDI.S := S;
  Post(dc_Writeln, 0);
end;

procedure TTracerSocket.Clear;
begin
  if not FEnabled then exit;
  Post(dc_Clear, 0);
end;

procedure TTracerSocket.TimerStart(Timer : integer);
begin
  if not FEnabled then exit;
  Post(dc_TimerStart, Timer);
end;

procedure TTracerSocket.TimerStop(Timer : integer);
begin
  if not FEnabled then exit;
  Post(dc_TimerStop, Timer);
end;
{-----------------------------------------------}

function Tracer : TTracerSocket;
begin
  if FTracer = nil then
    FTracer := TTracerSocket.Create;
  Result := FTracer;
end;
{$ENDIF DEBUG}

procedure ODS(S : string);
begin
{$IFDEF DEBUG}
  Tracer.Writeln(S);
{$ENDIF DEBUG}
end;

{$IFDEF DEBUG}
initialization
finalization
  FTracer.Free;
{$ENDIF DEBUG}

end.
