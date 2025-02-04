unit BozSanCallStack;

interface

uses
    Classes;

procedure BeginCallStack(const sProc: String; const Param: array of const);
procedure EndCallStack(const sProc: String);

function GetCallStack: TStrings;

procedure ClearCallStack;

implementation

uses
    SysUtils, Contnrs;

type

  TObjParam = class
  private
    sProc, sParam: String;
  public
    constructor Create(const sProc: String; const sParam: String);
  end;

  TCallStackStrings = class(TObjectList)
  private
    procedure AddCall(const sProc: String; const Param: array of const);
    procedure DelCall(const sProc: String);
    function GetStrings: TStrings;
    function GetProcName(const Index: Integer): String;
    function GetParam(const Index: Integer): String;

  public
    property ProcName[const Index: Integer]: String read GetProcName;
    property Param[const Index: Integer]: String read GetParam;

  end;


var
    slProc: TCallStackStrings = NIL;
    slCallStack: TStrings = NIL;

procedure BeginCallStack(const sProc: String; const Param: array of const);
begin
    slProc.AddCall(sProc, Param);
end;

procedure EndCallStack(const sProc: String);
begin
    slProc.DelCall(sProc);
end;

function GetCallStack: TStrings;
begin
    Result := slProc.GetStrings;
end;

procedure ClearCallStack;
begin
    slProc.Clear;
end;

{ TObjParam }

constructor TObjParam.Create(const sProc: String;
  const sParam: String);
begin
    inherited Create;
    Self.sProc := sProc;
    Self.sParam := sParam;    
end;

{ TCallStackStrings }

procedure TCallStackStrings.AddCall(const sProc: String;
  const Param: array of const);
var
    s, sParam: String;
    i: Integer;
begin
    sParam := '';
    for i := low(Param) to high(Param) do
        begin
        case Param[i].vType of
            vtInteger:      s := IntToStr(Param[i].VInteger);
            vtBoolean:      if Param[i].VBoolean then
                                s := 'TRUE'
                            else
                                s := 'FALSE';
            vtChar:         s := '''' + Param[i].VChar + '''';
            vtExtended:     s := FloatToStr(Param[i].VExtended^);
            vtString:       s := '''' + Param[i].VString^ + '''';
            vtPointer:      s := 'Pointer';
            vtPChar:        s := '''' + Param[i].VPChar^ + '''';
            vtObject:       s := '(TObject)';
            vtClass:        s := '(' + Param[i].VClass.ClassName + ')';
            vtWideChar:     s := Param[i].VWideChar;
            vtPWideChar:    s := WideCharToString(Param[i].VPWideChar);
            vtAnsiString:   s := '''' + String(Param[i].VAnsiString) + '''';
            vtCurrency:     s := CurrToStr(Param[i].VCurrency^);
            vtVariant:      s := 'Variant';
            vtInterface:    s := 'Interface';
            vtWideString:   s := 'WideString';
            vtInt64:        s := IntToStr(Param[i].VInt64^);       
        end;
        if length(sParam) = 0 then
            sParam := s
        else
            sParam := format('%s, %s', [sParam, s]);
        end;
    Add(TObjParam.Create(sProc, sParam));
end;

procedure TCallStackStrings.DelCall(const sProc: String);
var
    i: Integer;
begin
    i := Count - 1;
    while (i > -1) and
            (CompareText(ProcName[i], sProc) <> 0) do
        dec(i);
    if i < Count then
        Delete(i);
end;

function TCallStackStrings.GetParam(const Index: Integer): String;
begin
    Result := TObjParam(Items[Index]).sParam;
end;

function TCallStackStrings.GetProcName(const Index: Integer): String;
begin
    Result := TObjParam(Items[Index]).sProc;
end;

function TCallStackStrings.GetStrings: TStrings;
var
    i: Integer;
begin
    if slCallStack = NIL then
        slCallStack := TStringList.Create;
    for i := 0 to Count - 1 do
        slCallStack.Add(format('%s(%s)', [slProc.ProcName[i], slProc.Param[i]]));
    Result := slCallStack;
end;

initialization
    slProc := TCallStackStrings.Create;

finalization
    FreeandNIL(slProc);
    FreeandNIL(slCallStack);

end.
