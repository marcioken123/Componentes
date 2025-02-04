{***********************************************************
                R&A Library
                   RAI2
       Copyright (C) 1998-99 R&A

       component   : form runner for RAI2
       description : R&A Interpreter version 2

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

{ history (R&A Library versions):
  1.10:
   - first release;
  1.12:
   - more smart interface-part reducementer -
     method MakeCompatibleUnit;
  1.31.3 (R&A Library 1.31 with update 3):
   - support for Delphi5 text DFM files.
}


unit RAI2Fm;

interface

uses Windows, SysUtils, Classes, Forms, RAI2, RAI2Parser;

type

  TRAI2Fm = class;

  TRAI2Form = class(TForm)
  private
    FRAI2Fm: TRAI2Fm;
    FMethodList: TList;
    FreeFRAI2Fm: Boolean;
    procedure FixupMethods;
  protected
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property RAI2Fm: TRAI2Fm read FRAI2Fm;
  end;

  TRAI2Fm = class(TRAI2Program)
  private
    FForm: TRAI2Form;
    FVars: TRAI2VarList;
    PasFile, DfmFile: TFileName;
    function MakeCompatibleUnit(const SourceUnit: string): string;
  protected
    function GetValue(Identifer: string; var Value: Variant; var Args: TArgs)
      : Boolean; override;
    function SetValue(Identifer: string; const Value: Variant; var Args: TArgs)
      : Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Run; override;
    function MakeForm(const FileName: TFileName): TForm;
    function RunForm(const FileName: TFileName): TForm;
    function RunFormModal(const FileName: TFileName): TModalResult;
    property Form: TRAI2Form read FForm;
  end;

  function RAI2RunFormModal(const FileName: TFileName): TModalResult;
  function RAI2RunForm(const FileName: TFileName): TForm;
  function RAI2MakeForm(const FileName: TFileName): TForm;

  procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);


const
  ieImplementationNotFound = 401;


var
  RAI2GlobalAdapter: TRAI2Adapter = nil;

implementation

uses RAUtils, Consts, TypInfo;

type

  TRAI2Reader = class(TReader)
  protected
    function FindMethod(Root: TComponent; const MethodName: string): Pointer;
      override;
  end;

function TRAI2Reader.FindMethod(Root: TComponent; const MethodName: string)
  : Pointer;
begin
  Result := NewStr(MethodName);
  TRAI2Form(Root).FMethodList.Add(Result);
end;

constructor TRAI2Form.Create(AOwner: TComponent);
begin
 {$IFDEF RA_D}
  CreateNew(AOwner);
 {$ELSE}
  CreateNew(AOwner, 1);
 {$ENDIF}
  FMethodList := TList.Create;
end;    { Create }

destructor TRAI2Form.Destroy;
var
  i: Integer;
begin
  for i := 0 to FMethodList.Count - 1 do    { Iterate }
    DisposeStr(FMethodList[i]);
  inherited Destroy;
  if FreeFRAI2Fm then
    FRAI2Fm.Free;
end;    { Destroy }

procedure TRAI2Form.FixupMethods;

  procedure ReadProps(Com: TComponent);
  var
    TypeInf  : PTypeInfo;
    TypeData : PTypeData;
    PropList : PPropList;
    NumProps : word;
    i: Integer;
    Method: TMethod;
    F: Integer;
  begin
    TypeInf := Com.ClassInfo;
    TypeData := GetTypeData(TypeInf);
    NumProps := TypeData^.PropCount;
    GetMem(PropList, NumProps*sizeof(pointer));
    try
      GetPropInfos(TypeInf, PropList);
      for i := 0 to NumProps-1 do
        if PropList^[i].PropType^.Kind = tkMethod then
        begin
          Method := GetMethodProp(Com, PropList^[i]);
          if Method.Data = Self then
          begin
            F := FMethodList.IndexOf(Method.Code);
            if F > -1 then
            begin
              Method := TMethod(FRAI2Fm.NewEvent(PString(FMethodList[F])^,
                PropList^[i]^.PropType^.Name));
              SetMethodProp(Com, PropList^[i], Method);
            end;
          end;
        end;
    finally
      FreeMem(PropList, NumProps*sizeof(pointer));
    end;
  end;

var
  i: Integer;
begin
  ReadProps(Self);
  for i := 0 to ComponentCount - 1 do    { Iterate }
    ReadProps(Components[i]);
end;

procedure TRAI2Form.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  FixupMethods;
end;

function RAI2ReadComponentRes(Stream: TStream; Instance: TComponent)
  : TComponent;
var
  RAI2Reader: TRAI2Reader;
begin
  Stream.ReadResHeader;
  RAI2Reader := TRAI2Reader.Create(Stream, 4096);
  try
    Result := RAI2Reader.ReadRootComponent(Instance);
  finally
    RAI2Reader.Free;
  end;
end;

function RAI2ReadComponentResFile(const FileName: string; Instance: TComponent)
  : TComponent;
var
  Stream: TStream;
 {$IFDEF RA_D5H}
  TmpStream: TMemoryStream;
 {$ENDIF RA_D5H}
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
   {$IFDEF RA_D5H}
    if TestStreamFormat(Stream) = sofText then
    begin
      TmpStream := TMemoryStream.Create;
      ObjectTextToResource(Stream, TmpStream);
      Stream.Free;
      Stream := TmpStream;
      Stream.Position := 0;
    end;
   {$ENDIF RA_D5H}
    Result := RAI2ReadComponentRes(Stream, Instance);
  finally
    Stream.Free;
  end;
end;

{ ********************* TRAI2Fm **********************}
constructor TRAI2Fm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVars := TRAI2VarList.Create;
end;    { Create }

destructor TRAI2Fm.Destroy;
begin
  ClearList(FVars);
  FVars.Free;
  inherited Destroy;
end;    { Destroy }

function TRAI2Fm.MakeForm(const FileName: TFileName): TForm;
var
  S: string;
begin
  PasFile := ChangeFileExt(FileName, '.pas');
  DfmFile := ChangeFileExt(FileName, '.dfm');
  if not FileExists(DfmFile) then
    RAI2ErrorN(ieUnitNotFound, -1, DfmFile);
  try
    S := LoadTextFile(PasFile);
  except
    RAI2ErrorN(ieUnitNotFound, -1, PasFile);
  end;
  ClearList(FVars);
  Source := MakeCompatibleUnit(S);
  Compile;
  FForm := TRAI2Form.Create(Application);
  FForm.FRAI2Fm := Self;
  RAI2ReadComponentResFile(DfmFile, FForm);
  try
    if Assigned(FForm.OnCreate) then FForm.OnCreate(FForm);
  except
    Application.HandleException(FForm);
  end;
  FForm.Visible := False;
  Result := FForm;
end;    { MakeForm }

function TRAI2Fm.MakeCompatibleUnit(const SourceUnit: string): string;
begin
  Source := SourceUnit;
  Init;
  while True do
  begin
    NextToken;
    case TTyp of
      ttImplementation:
        begin
          BaseErrLine := GetLineByPos(SourceUnit, CurPos);
          Result := 'Unit ' + ChangeFileExt(ExtractFileName(PasFile), '') +
            ';'#13#10 + Copy(SourceUnit, CurPos + 1, Length(SourceUnit));
          Exit;
        end;
      ttPrivate, ttProtected, ttPublic, ttPublished:
        begin
          try
            Var1(FVars);
          except
            on E: ERAI2Error do
              if E.ErrCode = ieExpected then
                Back else
                raise;
          end;
        end;
      ttEmpty:
        RAI2Error(ieImplementationNotFound, -1);
    end;    { case }
  end;    { while }
end;    { MakeCompatibleUnit }

function TRAI2Fm.GetValue(Identifer: string; var Value: Variant;
  var Args: TArgs): Boolean;
var
  Com: TComponent;
begin
  Com := nil;
  Result := False;
  if (FForm <> nil) and (Args.Obj = nil) then
  begin
    if Cmp(Identifer, 'Self') then
    begin
      Value := O2V(FForm);
      Result := True;
    end
    else
    begin
      Com := FForm.FindComponent(Identifer);
      if Com = nil then
      begin
       { may be TForm method }
        Args.Obj := FForm;
        Args.ObjTyp := varObject;
        try
          Result := inherited GetValue(Identifer, Value, Args);
        finally
          Args.Obj := nil;
          Args.ObjTyp := 0;
        end;
      end;
    end;
  end
  else
  if (Args.Obj <> nil) and
     (Args.ObjTyp = varObject) and
     (Args.Obj is TRAI2Form) then
    Com := (Args.Obj as TRAI2Form).FindComponent(Identifer);

  if Com <> nil then
  begin
    Value := O2V(Com);
    Result := True;
  end;
  
  if not Result then
    Result := FVars.GetValue(Identifer, Value, Args) or
       inherited GetValue(Identifer, Value, Args);
end;    { GetValue }

function TRAI2Fm.SetValue(Identifer: string; const Value: Variant;
  var Args: TArgs): Boolean;
begin
  if (FForm <> nil) and (Args.Obj = nil) then
  begin
   { may be TForm method }
    Args.Obj := FForm;
    Args.ObjTyp := varObject;
    try
      Result := inherited SetValue(Identifer, Value, Args);
    finally
      Args.Obj := nil;
      Args.ObjTyp := 0;
    end;
  end
  else
    Result := False;  
  Result := Result or FVars.SetValue(Identifer, Value, Args) or
     inherited SetValue(Identifer, Value, Args);
end;    { GetValue }

procedure TRAI2Fm.Run;
begin
  inherited Run;
end;

function TRAI2Fm.RunForm(const FileName: TFileName): TForm;
begin
  Result := MakeForm(FileName);
  Result.Show;
end;

function TRAI2Fm.RunFormModal(const FileName: TFileName): TModalResult;
begin
  with MakeForm(FileName) do
    try
      Result := ShowModal;
    finally { wrap up }
      Free;
    end;    { try/finally }
end;

function RAI2RunFormModal(const FileName: TFileName): TModalResult;
begin
  with TRAI2Fm.Create(Application) do
    try
      Result := RunFormModal(FileName);
    finally { wrap up }
      Free;
    end;    { try/finally }
end;

function RAI2RunForm(const FileName: TFileName): TForm;
begin
  with TRAI2Fm.Create(Application) do
  begin
    Result := RunForm(FileName);
    (Result as TRAI2Form).FreeFRAI2Fm := True;
  end;
end;

function RAI2MakeForm(const FileName: TFileName): TForm;
begin
  with TRAI2Fm.Create(Application) do
  begin
    Result := MakeForm(FileName);
    (Result as TRAI2Form).FreeFRAI2Fm := True;
  end;
end;


{ adapter to self }
{ function RAI2RunFormModal(const FileName: TFileName): TModalResult; }
procedure RAI2_RAI2RunFormModal(var Value: Variant; Args: TArgs);
begin
  Value := RAI2RunFormModal(Args.Values[0]);
end;

{ function RAI2RunForm(const FileName: TFileName): TForm; }
procedure RAI2_RAI2RunForm(var Value: Variant; Args: TArgs);
begin
  Value := O2V(RAI2RunForm(Args.Values[0]));
end;

{ function RAI2MakeForm(const FileName: TFileName): TForm; }
procedure RAI2_RAI2MakeForm(var Value: Variant; Args: TArgs);
begin
  Value := O2V(RAI2MakeForm(Args.Values[0]));
end;

procedure RegisterRAI2Adapter(RAI2Adapter: TRAI2Adapter);
begin
  with RAI2Adapter do
  begin
    AddFun('RAI2Fm', 'RAI2RunFormModal', RAI2_RAI2RunFormModal, 1, [varEmpty]);
    AddFun('RAI2Fm', 'RAI2RunForm', RAI2_RAI2RunForm, 1, [varEmpty]);
    AddFun('RAI2Fm', 'RAI2MakeForm', RAI2_RAI2MakeForm, 1, [varEmpty]);
  end;    { with }
end;    { RegisterRAI2Adapter }

end.
