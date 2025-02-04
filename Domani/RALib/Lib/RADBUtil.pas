{***********************************************************
                R&A Library
       Copyright (C) 1996-98 R&A

       description : db-aware routines

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit RADBUtil;

interface

uses
  Windows, Messages, Bde, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DB, DBTables, DBCtrls;


type

  EScriptError = class(Exception)
    ErrPos : integer;
    constructor Create2(AMessage : string; AErrPos : integer);
  end;

  TCommit = (ctNone, ctStep, ctAll);
  TOnProgress = procedure(UserData : integer; var Cancel : boolean; Line : integer) of object;


  { ExecuteSQLScript executes SQL script }

  procedure ExecuteSQLScript(Base : TDataBase; const Script : string; const Commit : TCommit; OnProgress : TOnProgress; const UserData : integer);

  { GetQueryResult executes SQL Query and returns result as variant }

  function GetQueryResult(const DatabaseName, SQL : string) : variant;

  { GetStoredProcResult executes SQL stored procedure and returns
    value of ResultName parameters as variant }

  function GetStoredProcResult(const DatabaseName, StoredProcName : string; Params : array of variant; const ResultName : string) : variant;

  { StrFieldDesc returns field description of given FLDDesc record }

  function StrFieldDesc(Field: FLDDesc) : string;


  function Var2Type(V : Variant; const VarType : integer) : variant;


  procedure CopyRecord(DataSet : TDataSet);

 { AddReference create reference for paradox table,
   RefField and MasterField are field numbers (first field has number 1)
   Tables allready must have indices for this fields }

  procedure AddReference(Tbl : TTable; RefName : string; RefField : word;
    MasterTable : string; MasterField : word; ModOp, DelOp : RINTQual);

 { AddMasterPassword extracted from "bde.hlp" file }
  procedure AddMasterPassword(Table: TTable; pswd: string);

 { PackTable extracted from "bde.hlp" file }
  procedure PackTable(Table: TTable);

  procedure PackEncryptedTable(Table: TTable; pswd: string);

  function EncodeQuates(const S: string): string;


implementation

uses RAUtils;


constructor EScriptError.Create2(AMessage : string; AErrPos : integer);
begin
  inherited Create(AMessage);
  ErrPos := AErrPos;
end;

procedure ExecuteSQLScript(Base : TDataBase; const Script : string; const Commit : TCommit; OnProgress : TOnProgress; const UserData : integer);
var
  N : integer;
  Term : char;

  function NextQuery : string;
  var
    C : char;
    Rem : boolean;
  begin
    Result := '';
    Rem := false;
    while Length(Script) >= N do begin
      C := Script[N];
      inc(N);
      if (C = Term) and not Rem then exit;
      Result := Result + C;
      if (C = '/') and (Length(Script) >= N) and (Script[N] = '*') then
        Rem := true;
      if (C = '*') and (Length(Script) >= N) and (Script[N] = '/') and Rem then
        Rem := false;
    end;
    Result := '';
  end;
  function SetTerm(S : string) : boolean;
  var
    Rem : boolean;
  begin
    Rem := false;
    while (Length(S) > 0) do begin
      if (S[1] in [' ', #13, #10]) then Delete(S, 1, 1)
      else
      if Rem then
        if (S[1] = '*') and (Length(S) > 1) and (S[2] = '/') then begin
          Delete(S, 1, 2);
          Rem := false;
        end else
          Delete(S, 1, 1)
      else
      if (S[1] = '/') and (Length(S) > 1) and (S[2] = '*') then begin
        Delete(S, 1, 2);
        Rem := true;
      end
      else break;
    end;
    Result := ANSIStrLIComp(PChar(S), 'set term', 8) = 0;
    if Result then begin
      S := Trim(Copy(S, 9, 1024));
      if Length(S) = 1 then
        Term := S[1] else
        EDatabaseError.Create('Bad term');
      exit;
    end;
    Result := ANSIStrLIComp(PChar(S), 'commit work', 11) = 0;
    if Result then begin
      Base.Commit;
      Base.StartTransaction;
      exit;
    end;
  end;

var
  Q : string;
  ErrPos : integer;
  NBeg : integer;
  X, Y, N2 : integer;
  S1 : string;
  Query : TQuery;
  Stop : boolean;
begin
  if Commit in [ctStep, ctAll] then
    Base.StartTransaction;
  Query := TQuery.Create(Application);
  try
    Query.DatabaseName := Base.DatabaseName;
    Query.ParamCheck := false;
    N := 1; Term := ';'; Stop := false;
    NBeg := 1;
    try
      Q := NextQuery;
      while Q <> '' do
      begin
        if not SetTerm(Q) then
        begin
          if Assigned(OnProgress) then
          begin
            S1 := Q; N2 := 0;
            while (Length(S1) > 0) and (S1[1] in [' ', #13, #10]) do
            begin
              Delete(S1, 1, 1);
              inc(N2);
            end;
            GetXYByPos(Script, NBeg+N2, X, Y);
            if Assigned(OnProgress) then
              OnProgress(UserData, Stop, Y)
            else
              Application.ProcessMessages;
            if Stop then Abort;
          end;
          Query.SQL.Text := Q;
          Query.ExecSQL;
          if Commit = ctStep then
          begin
            Base.Commit;
            Base.StartTransaction;
          end;
          Query.Close;
        end;
        NBeg := N+1;
        Q := NextQuery;
      end;
      if Commit in [ctStep, ctAll] then
        Base.Commit;
    except
      on E : Exception do
      begin
        if Commit in [ctStep, ctAll] then
          Base.Rollback;
        if E is EDatabaseError then
        begin
          ErrPos := NBeg;
          //..
          raise EScriptError.Create2(E.Message, ErrPos)
        end else
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

function GetQueryResult(const DatabaseName, SQL : string) : variant;
var
  Query : TQuery;
begin
  Query := TQuery.Create(Application);
  try
    Query.DatabaseName := DatabaseName;
    Query.ParamCheck := false;
    Query.SQL.Text := SQL;
    Query.Open;
    Result := Query.Fields[0].AsVariant;
  finally
    Query.Free;
  end;
end;

function GetStoredProcResult(const DatabaseName, StoredProcName : string; Params : array of variant; const ResultName : string) : variant;
var
  StoredProc : TStoredProc;
  i : integer;
begin
  StoredProc := TStoredProc.Create(Application);
  try
    StoredProc.DatabaseName := DatabaseName;
    StoredProc.ParamBindMode := pbByNumber;
    StoredProc.StoredProcName := StoredProcName;
    StoredProc.Prepare;
    for i := Low(Params) to High(Params) do
      StoredProc.Params[i].Value := Params[i];
    StoredProc.ExecProc;
    Result := StoredProc.ParamByName(ResultName).Value;
  finally
    StoredProc.Free;
  end;
end;

function StrFieldDesc(Field: FLDDesc) : string;

  function sUnits1 : string;
  begin
    Result := IntToStr(Field.iUnits1);
  end;
  function sUnits2 : string;
  begin
    if Field.iUnits2 < 0 then
      Result := IntToStr(-Field.iUnits2) else
      Result := IntToStr(Field.iUnits2);
  end;

begin
  with Field do
    case iFldType  of
      fldUNKNOWN: result := 'unknown';
      fldZSTRING: result := 'string';               { Null terminated string }
      fldDATE: result := 'date';                    { Date     (32 bit) }
      fldBLOB: result := 'BLOb';                    { Blob }
      fldBOOL: result := 'boolean';                 { Boolean  (16 bit) }
      fldINT16: result := 'integer';                { 16 bit signed number }
      fldINT32: result := 'long integer';           { 32 bit signed number }

      fldFLOAT: result := 'float';                  { 64 bit floating point }
      fldBCD: result := 'BCD';                      { BCD }
      fldBYTES: result := 'bytes';                  { Fixed number of bytes }
      fldTIME: result := 'time';                    { Time        (32 bit) }
      fldTIMESTAMP: result := 'timestamp';          { Time-stamp  (64 bit) }
      fldUINT16: result := 'unsigned int';          { Unsigned 16 bit integer }
      fldUINT32: result := 'unsigned long int';     { Unsigned 32 bit integer }

      fldFLOATIEEE: result := 'float IEEE';         { 80-bit IEEE float }
      fldVARBYTES: result := 'varbytes';            { Length prefixed var bytes }
      fldLOCKINFO: result := 'lockinfo';            { Look for LOCKINFO typedef }
     {$IFDEF RA_D3H}
      fldCURSOR: result := 'Oracle cursor';         { For Oracle Cursor type }
     {$ENDIF RA_D3H}

     { Paradox types (Physical) }
      fldPDXCHAR: result := 'alpha('+sUnits1+')';       { Alpha    (string) }
      fldPDXNUM: result := 'numeric('+sUnits1+', '+sUnits2+')';               { Numeric }

      fldPDXMONEY: result := 'money';               { Money }
      fldPDXDATE: result := 'date';                 { Date }
      fldPDXSHORT: result := 'smallint';            { Short }
      fldPDXMEMO: result := 'Memo BLOb';            { Text Memo       (blob) }
      fldPDXBINARYBLOB: result := 'Binary BLOb';    { Binary data     (blob) }
      fldPDXFMTMEMO: result := 'formatted BLOb';    { Formatted text  (blob) }
      fldPDXOLEBLOB: result := 'OLE BLOb';          { OLE object      (blob) }

      fldPDXGRAPHIC: result := 'Graphic BLOb';      { Graphics object (blob) }
      fldPDXLONG: result := 'long integer';         { Long }
      fldPDXTIME: result := 'time';                 { Time }
      fldPDXDATETIME: result := 'date time';        { Time Stamp }
      fldPDXBOOL: result := 'boolean';              { Logical }
      fldPDXAUTOINC: result := 'auto increment';    { Auto increment (long) }
      fldPDXBYTES: result := 'bytes';               { Fixed number of bytes }

      fldPDXBCD: result := 'BCD';                   { BCD (32 digits) }

      { xBASE types (Physical) }
      fldDBCHAR: result := 'character';             { Char string }
      fldDBNUM: result := 'number';                 { Number }
      fldDBMEMO: result := 'Memo BLOb';             { Memo          (blob) }
      fldDBBOOL: result := 'logical';               { Logical }
      fldDBDATE: result := 'date';                  { Date }
      fldDBFLOAT: result := 'float';                { Float }

      fldDBLOCK: result := 'LOCKINFO';              { Logical type is LOCKINFO }
      fldDBOLEBLOB: result := 'OLE BLOb';           { OLE object    (blob) }
      fldDBBINARY: result := 'Binary BLOb';         { Binary data   (blob) }
      fldDBBYTES: result := 'bytes';                { Only for TEMPORARY tables }
     {$IFDEF RA_D3H}
      fldDBLONG: result := 'long integer';          { Long (Integer) }
      fldDBDATETIME: result := 'date time';         { Time Stamp }
      fldDBDOUBLE: result := 'double';              { Double }

      fldDBAUTOINC: result := 'aut increment';      { Auto increment (long) }
     {$ENDIF RA_D3H}

     { InterBase types (Physical) }
      1026 : result := 'integer';
      1028 : result := 'numeric('+sUnits1+', '+sUnits2+')';  { Numeric }
      1029 : result := 'char('+sUnits1+')';
      1031 : result := 'date';                               { Date      }
    else
      Result := 'unknown type';
    end;
end;

{************************ variant conversion routines ************************}

function Var2Type(V : Variant; const VarType : integer) : variant;
begin
  if V = null then
  begin
    case VarType of
      varString,
      varOleStr    : Result := '';
      varInteger,
      varSmallint,
      varByte      : Result := 0;
      varBoolean   : Result := false;
      varSingle,
      varDouble,
      varCurrency,
      varDate      : Result := 0.0;
      else Result := VarAsType(V, VarType);
    end;
  end else
    Result := VarAsType(V, VarType);
end;

procedure CopyRecord(DataSet : TDataSet);
var
  i : integer;
begin
  with DataSet, TStringList.Create do
  try
    for i := 0 to FieldCount -1 do
      Add(Fields[i].AsString);
    DataSet.Append;
    for i := 0 to FieldCount -1 do
      if Fields[i].IsNull then
        Fields[i].AsString := Strings[i];
  finally
    Free;
  end
end;

procedure AddReference(Tbl : TTable; RefName : string; RefField : word;
  MasterTable : string; MasterField : word; ModOp, DelOp : RINTQual);
var
  hDb: hDbiDb;
  TblDesc: CRTblDesc;
  RInt: pRINTDesc;
  Dir: string;
  OpType: CROpType;
begin
  SetLength(Dir, dbiMaxNameLen + 1);
  Check(DbiGetDirectory(Tbl.DBHandle, False, PChar(Dir)));
  SetLength(Dir, StrLen(PChar(Dir)));
  RInt := AllocMem(sizeof(RINTDesc));
  try
    FillChar(TblDesc, sizeof(CRTblDesc), #0);
    Tbl.DisableControls;
    Tbl.Close;
    Check(DbiOpenDatabase(nil, nil, dbiReadWrite, dbiOpenExcl, nil, 0, nil, nil, hDb));
    Check(DbiSetDirectory(hDb, PChar(Dir)));
    with RInt^ do
    begin
      StrPCopy(szRintName, RefName);
      StrPCopy(szTblName, MasterTable);
      eType := rintDEPENDENT;
      eModOp := ModOp;
      eDelOp := DelOp;
      iFldCount := 1;
      aiThisTabFld[0] := RefField;
      aiOthTabFld[0] := MasterField;
    end;
    TblDesc.iRintCount := 1;
    TblDesc.pRINTDesc := RInt;
    OpType := crADD;
    TblDesc.pecrRintOp := @OpType;
    StrPCopy(TblDesc.szTblName, Tbl.TableName);
    StrCopy(TblDesc.szTblType, szParadox);
    Check(DbiDoRestructure(hDb, 1, @TblDesc, nil, nil, nil, False));
  finally
    Check(DbiCloseDatabase(hDb));
    FreeMem(RInt, sizeof(RINTDesc));
    Tbl.EnableControls;
    Tbl.Open;
  end;
end;

// Pack a Paradox or dBASE table
// The table must be opened execlusively before calling this function...
procedure PackTable(Table: TTable);
var
  Props: CURProps;
  hDb: hDBIDb;
  TableDesc: CRTblDesc;
begin
  // Make sure the table is open exclusively so we can get the db handle...
  if not Table.Active then
    raise EDatabaseError.Create('Table must be opened to pack');
  if not Table.Exclusive then

    raise EDatabaseError.Create('Table must be opened exclusively to pack');

  // Get the table properties to determine table type...
  Check(DbiGetCursorProps(Table.Handle, Props));

  // If the table is a Paradox table, you must call DbiDoRestructure...
  if (Props.szTableType = szPARADOX) then begin
    // Blank out the structure...
    FillChar(TableDesc, sizeof(TableDesc), 0);
    // Get the database handle from the table's cursor handle...

    Check(DbiGetObjFromObj(hDBIObj(Table.Handle), objDATABASE, hDBIObj(hDb)));
    // Put the table name in the table descriptor...
    StrPCopy(TableDesc.szTblName, Table.TableName);
    // Put the table type in the table descriptor...
    StrPCopy(TableDesc.szTblType, Props.szTableType);
    // Set the Pack option in the table descriptor to TRUE...
    TableDesc.bPack := True;
    // Close the table so the restructure can complete...
    Table.Close;
    // Call DbiDoRestructure...

    Check(DbiDoRestructure(hDb, 1, @TableDesc, nil, nil, nil, False));
  end
  else
    // If the table is a dBASE table, simply call DbiPackTable...
    if (Props.szTableType = szDBASE) then
      Check(DbiPackTable(Table.DBHandle, Table.Handle, nil, szDBASE, True))
    else
      // Pack only works on PAradox or dBASE; nothing else...
      raise EDatabaseError.Create('Table must be either of Paradox or dBASE ' +
        'type to pack');
  Table.Open;
end;


//Add a master password to a Paradox table.
//This procedure uses the following input:
//AddMasterPassword(Table1, 'MyNewPassword')

procedure AddMasterPassword(Table: TTable; pswd: string);
const
  RESTRUCTURE_TRUE = WordBool(1);
var
  TblDesc: CRTblDesc;
  hDb: hDBIDb;
begin
  { Make sure that the table is opened and is exclusive }
  if not Table.Active or not Table.Exclusive then
    raise EDatabaseError.Create('Table must be opened in exclusive ' +
      'mode to add passwords');
  { Initialize the table descriptor }
  FillChar(TblDesc, SizeOf(CRTblDesc), #0);
  with TblDesc do begin

    { Place the table name in descriptor }
    StrPCopy(szTblName, Table.TableName);
    { Place the table type in descriptor }
    StrCopy(szTblType, szPARADOX);
    { Master Password, Password }
    StrPCopy(szPassword, pswd);
    { Set bProtected to True }
    bProtected := RESTRUCTURE_TRUE;
  end;
  { Get the database handle from the cursor handle }
  Check(DbiGetObjFromObj(hDBIObj(Table.Handle), objDATABASE, hDBIObj(hDb)));
  { Close the table }
  Table.Close;

  { Add the master password to the Paradox table }
  Check(DbiDoRestructure(hDb, 1, @TblDesc, nil, nil, nil, False));
  { Add the new password to the session }
  Session.AddPassword(pswd);
  { Re-Open the table }
  Table.Open;
end;

// Pack a Paradox table with Password
// The table must be opened execlusively before calling this function...
procedure PackEncryptedTable(Table: TTable; pswd: string);
const
  RESTRUCTURE_TRUE = WordBool(1);
var
  Props: CURProps;
  hDb: hDBIDb;
  TableDesc: CRTblDesc;
begin
  // Make sure the table is open exclusively so we can get the db handle...
  if not Table.Active then
    raise EDatabaseError.Create('Table must be opened to pack');
  if not Table.Exclusive then

    raise EDatabaseError.Create('Table must be opened exclusively to pack');

  // Get the table properties to determine table type...
  Check(DbiGetCursorProps(Table.Handle, Props));

  // If the table is a Paradox table, you must call DbiDoRestructure...
  if (Props.szTableType = szPARADOX) then begin
    // Blank out the structure...
    FillChar(TableDesc, sizeof(TableDesc), 0);
    // Get the database handle from the table's cursor handle...

    Check(DbiGetObjFromObj(hDBIObj(Table.Handle), objDATABASE, hDBIObj(hDb)));
    // Put the table name in the table descriptor...
    StrPCopy(TableDesc.szTblName, Table.TableName);
    // Put the table type in the table descriptor...
    StrPCopy(TableDesc.szTblType, Props.szTableType);
    // Set the Pack option in the table descriptor to TRUE...
    TableDesc.bPack := True;
    { Master Password, Password }
    StrPCopy(TableDesc.szPassword, pswd);
    { Set bProtected to True }
    TableDesc.bProtected := RESTRUCTURE_TRUE;

    // Close the table so the restructure can complete...
    Table.Close;
    // Call DbiDoRestructure...

    Check(DbiDoRestructure(hDb, 1, @TableDesc, nil, nil, nil, False));
  end
  else
    // If the table is a dBASE table, simply call DbiPackTable...
    if (Props.szTableType = szDBASE) then
      Check(DbiPackTable(Table.DBHandle, Table.Handle, nil, szDBASE, True))
    else
      // Pack only works on PAradox or dBASE; nothing else...
      raise EDatabaseError.Create('Table must be either of Paradox or dBASE ' +
        'type to pack');
  Table.Open;
end;

function EncodeQuates(const S: string): string;
begin
  Result := S;
  Result := ReplaceSokr1(Result, #13#10, #13);
  Result := ReplaceSokr1(Result, #13, '\#13');
  Result := ReplaceSokr1(Result, '"', '\#34');
  Result := ReplaceSokr1(Result, ',', '\#44');
end;

end.
