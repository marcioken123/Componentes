unit Dbf_Fields;

{force CR/LF fix}

interface

{$I Dbf_Common.inc}

uses
  Classes,
  SysUtils,
  Db,
  Dbf_Common,
  Dbf_Str;

type
  PDbfFieldDef = ^TDbfFieldDef;

  TDbfFieldDef = class(TCollectionItem)
  private
    FFieldName: string;
    FFieldType: TFieldType;
    FNativeFieldType: TDbfFieldType;
    FDefaultBuf: PChar;
    FMinBuf: PChar;
    FMaxBuf: PChar;
    FSize: Integer;
    FPrecision: Integer;
    FHasDefault: Boolean;
    FHasMin: Boolean;
    FHasMax: Boolean;
    FAllocSize: Integer;
    FValueOffset: Integer;
    FCopyFrom: Integer;
    FOffset: Integer;
    FAutoInc: Cardinal;
    FRequired: Boolean;
    FIsLockField: Boolean;

    function  GetDbfVersion: xBaseVersion;
    procedure SetNativeFieldType(lFieldType: TDbfFieldType);
    procedure SetFieldType(lFieldType: TFieldType);
    procedure SetSize(lSize: Integer);
    procedure SetPrecision(lPrecision: Integer);
    procedure VCLToNative;
    procedure NativeToVCL;
    procedure FreeBuffers;
  protected
    function  GetDisplayName: string; override;
    procedure AssignTo(Dest: TPersistent); override;

    property DbfVersion: xBaseVersion read GetDbfVersion;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    procedure AssignDb(DbSource: TFieldDef);

    procedure CheckSizePrecision;
    procedure CalcValueOffset;
    procedure SetDefaultSize;
    procedure AllocBuffers;
    function  IsBlob: Boolean;

    property DefaultBuf: PChar read FDefaultBuf;
    property MinBuf: PChar read FMinBuf;
    property MaxBuf: PChar read FMaxBuf;
    property HasDefault: Boolean read FHasDefault write FHasDefault;
    property HasMin: Boolean read FHasMin write FHasMin;
    property HasMax: Boolean read FHasMax write FHasMax;
    property ValueOffset: Integer read FValueOffset write FValueOffset;
    property Offset: Integer read FOffset write FOffset;
    property AutoInc: Cardinal read FAutoInc write FAutoInc;
    property IsLockField: Boolean read FIsLockField write FIsLockField;
    property CopyFrom: Integer read FCopyFrom write FCopyFrom;
  published
    property FieldName: string     read FFieldName write FFieldName;
    property FieldType: TFieldType read FFieldType write SetFieldType;
    property NativeFieldType: TDbfFieldType read FNativeFieldType write SetNativeFieldType;
    property Size: Integer         read FSize      write SetSize;
    property Precision: Integer    read FPrecision write SetPrecision;
    property Required: Boolean     read FRequired  write FRequired;
  end;

  TDbfFieldDefs = class(TCollection)
  private
    FOwner: TPersistent;
    FDbfVersion: xBaseVersion;
    FUseFloatFields: Boolean;

    function GetItem(Idx: Integer): TDbfFieldDef;
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Owner: TPersistent);

{$ifdef SUPPORT_DEFAULT_PARAMS}
    procedure Add(const Name: string; DataType: TFieldType; Size: Integer = 0; Required: Boolean = False);
{$else}
    procedure Add(const Name: string; DataType: TFieldType; Size: Integer; Required: Boolean);
{$endif}
    function AddFieldDef: TDbfFieldDef;

    property Items[Idx: Integer]: TDbfFieldDef read GetItem;
    property DbfVersion: xBaseVersion read FDbfVersion write FDbfVersion;
    property UseFloatFields: Boolean read FUseFloatFields write FUseFloatFields;
  end;

implementation

uses
  Dbf_DbfFile;      // for dbf header structures

{$I Dbf_Struct.inc}

// I keep changing that fields...
// Last time has been asked by Venelin Georgiev
// Is he going to be the last ?
const
(*
The theory until now was :
    ftSmallint  16 bits = -32768 to 32767
                          123456 = 6 digit max theorically
                          DIGITS_SMALLINT = 6;
    ftInteger  32 bits = -2147483648 to 2147483647
                         12345678901 = 11 digits max
                         DIGITS_INTEGER = 11;
    ftLargeInt 64 bits = -9223372036854775808 to 9223372036854775807
                         12345678901234567890 = 20 digits max
                         DIGITS_LARGEINT = 20;

But in fact if I accept 6 digits into a ftSmallInt then tDbf will not
being able to handles fields with 999999 (6 digits).

So I now oversize the field type in order to accept anithing coming from the
database.
    ftSmallint  16 bits = -32768 to 32767
                           -999  to  9999
                           4 digits max theorically
                          DIGITS_SMALLINT = 4;
    ftInteger  32 bits = -2147483648 to 2147483647
                           -99999999 to  999999999                                        12345678901 = 11 digits max
                         DIGITS_INTEGER = 9;
    ftLargeInt 64 bits = -9223372036854775808 to 9223372036854775807
                           -99999999999999999 to  999999999999999999
                         DIGITS_LARGEINT = 18;
 *)
  DIGITS_SMALLINT = 4;
  DIGITS_INTEGER = 9;
  DIGITS_LARGEINT = 18;

//====================================================================
// DbfFieldDefs
//====================================================================
function TDbfFieldDefs.GetItem(Idx: Integer): TDbfFieldDef;
begin
  Result := TDbfFieldDef(inherited GetItem(Idx));
end;

constructor TDbfFieldDefs.Create(Owner: TPersistent);
begin
  inherited Create(TDbfFieldDef);
  FOwner := Owner;
end;

function TDbfFieldDefs.AddFieldDef: TDbfFieldDef;
begin
  Result := TDbfFieldDef(inherited Add);
end;

function TDbfFieldDefs.GetOwner: TPersistent; {override;}
begin
  Result := FOwner;
end;

procedure TDbfFieldDefs.Add(const Name: string; DataType: TFieldType; Size: Integer; Required: Boolean);
var
  FieldDef: TDbfFieldDef;
begin
  FieldDef := AddFieldDef;
  FieldDef.FieldName := Name;
  FieldDef.FieldType := DataType;
  FieldDef.Size := size;
  FieldDef.Required := Required;
end;

//====================================================================
// DbfFieldDef
//====================================================================
constructor TDbfFieldDef.Create(Collection: TCollection); {virtual}
begin
  inherited;

  FDefaultBuf := nil;
  FMinBuf := nil;
  FMaxBuf := nil;
  FAllocSize := 0;
  FCopyFrom := -1;
  FHasDefault := false;
  FHasMin := false;
  FHasMax := false;
end;

destructor TDbfFieldDef.Destroy; {override}
begin
  FreeBuffers;
  inherited;
end;

procedure TDbfFieldDef.Assign(Source: TPersistent);
var
  DbfSource: TDbfFieldDef;
begin
  if Source is TDbfFieldDef then
  begin
    // copy from another TDbfFieldDef
    DbfSource := TDbfFieldDef(Source);
    FFieldName := DbfSource.FieldName;
    FFieldType := DbfSource.FieldType;
    FNativeFieldType := DbfSource.NativeFieldType;
    FSize := DbfSource.Size;
    FPrecision := DbfSource.Precision;
    FRequired := DbfSource.Required;
    FCopyFrom := DbfSource.Index;
    FIsLockField := DbfSource.IsLockField;
    // copy default,min,max
    AllocBuffers;
    if DbfSource.DefaultBuf <> nil then
      Move(DbfSource.DefaultBuf^, FDefaultBuf^, FAllocSize*3);
    FHasDefault := DbfSource.HasDefault;
    FHasMin := DbfSource.HasMin;
    FHasMax := DbfSource.HasMax;
    // do we need offsets?
    FValueOffset := DbfSource.ValueOffset;
    FOffset := DbfSource.Offset;
    FAutoInc := DbfSource.AutoInc;
{$ifdef DELPHI_4}
  end else if Source is TFieldDef then begin
    AssignDb(TFieldDef(Source));
{$endif}
  end else
    inherited Assign(Source);
end;

procedure TDbfFieldDef.AssignDb(DbSource: TFieldDef);
begin
  // copy from Db.TFieldDef
  FFieldName := DbSource.Name;
  FFieldType := DbSource.DataType;
  FSize := DbSource.Size;
  FPrecision := DbSource.Precision;
  FRequired := DbSource.Required;
{$ifdef DELPHI_4}
{$ifndef FPC_VERSION}
  FCopyFrom := DbSource.Index;
{$endif}
{$endif}
  FIsLockField := false;
  // convert VCL fieldtypes to native DBF fieldtypes
  VCLToNative;
  // for integer / float fields try fill in size/precision
  SetDefaultSize;
  // VCL does not have default value support
  AllocBuffers;
  FHasDefault := false;
  FHasMin := false;
  FHasMax := false;
  FValueOffset := 0;
  FOffset := 0;
  FAutoInc := 0;
end;

procedure TDbfFieldDef.AssignTo(Dest: TPersistent);
var
  DbDest: TFieldDef;
begin
{$ifdef DELPHI_4}
  // copy to VCL fielddef?
  if Dest is TFieldDef then
  begin
    DbDest := TFieldDef(Dest);
    // VCL TFieldDef does not know how to handle TDbfFieldDef!
    // what a shame :-)
{$ifndef FPC_VERSION}
    DbDest.Attributes := [];
    DbDest.ChildDefs.Clear;
    DbDest.DataType := FFieldType;
    DbDest.Required := FRequired;
    DbDest.Size := FSize;
    DbDest.Name := FFieldName;
{$endif}
  end else
{$endif}
    inherited AssignTo(Dest);
end;

procedure TDbfFieldDef.CalcValueOffset;
begin
  // autoinc?
  if FNativeFieldType = '+' then
    FValueOffset := SizeOf(rDbfHdr)+SizeOf(rAfterHdrVII) + (Index-1)*SizeOf(rFieldDescVII) + FieldDescVII_AutoIncOffset;
end;

function TDbfFieldDef.GetDbfVersion: xBaseVersion;
begin
  Result := TDbfFieldDefs(Collection).DbfVersion;
end;

procedure TDbfFieldDef.SetFieldType(lFieldType: tFieldType);
begin
  FFieldType := lFieldType;
  VCLToNative;
  CheckSizePrecision;
end;

procedure TDbfFieldDef.SetNativeFieldType(lFieldType: tDbfFieldType);
begin
  // get uppercase field type
  if (lFieldType >= 'a') and (lFieldType <= 'z') then
    lFieldType := Chr(Ord(lFieldType)-32);
  FNativeFieldType := lFieldType;
  NativeToVCL;
  CheckSizePrecision;
end;

procedure TDbfFieldDef.SetSize(lSize: Integer);
begin
  FSize := lSize;
  CheckSizePrecision;
end;

procedure TDbfFieldDef.SetPrecision(lPrecision: Integer);
begin
  FPrecision := lPrecision;
  CheckSizePrecision;
end;

procedure TDbfFieldDef.NativeToVCL;
begin
  case FNativeFieldType of
// OH 2000-11-15 dBase7 support.
// Add the new fieldtypes
    '+' : FFieldType := ftAutoInc;
    'I' : FFieldType := ftInteger;
    'O' : FFieldType := ftFloat;
    '@', 'T':
          FFieldType := ftDateTime;
    'C' : FFieldType := ftString;
    'L' : FFieldType := ftBoolean;
    'F', 'N':
      begin
        if (FPrecision = 0) then
        begin
          if FSize <= DIGITS_SMALLINT then
            FFieldType := ftSmallInt
          else
          if TDbfFieldDefs(Collection).UseFloatFields then
            FFieldType := ftFloat
          else
{$ifdef DELPHI_4}
          if FSize <= DIGITS_INTEGER then
            FFieldType := ftInteger
          else
            FFieldType := ftLargeInt;
{$else}
            FFieldType := ftInteger;
{$endif}
        end else begin
          FFieldType := ftFloat;
        end;
      end;
    'D' : FFieldType := ftDate;
    'M' : FFieldType := ftMemo;
    'B' : FFieldType := ftBlob;
    'G' : FFieldType := ftDBaseOle;
  else
    FNativeFieldType := #0;
    FFieldType := ftUnknown;
  end; //case
end;

procedure TDbfFieldDef.VCLToNative;
begin
  case FFieldType of
    ftAutoInc  : FNativeFieldType  := '+';
    ftDateTime : FNativeFieldType  := '@';
{$ifdef DELPHI_4}
    ftFixedChar,
    ftWideString,
{$endif}
    ftString   : FNativeFieldType  := 'C';
    ftBoolean  : FNativeFieldType  := 'L';
    ftFloat, ftCurrency, ftSmallInt, ftWord
{$ifdef DELPHI_4}
      , ftLargeInt
{$endif}
               : FNativeFieldType := 'N';
    ftDate     : FNativeFieldType := 'D';
    ftMemo     : FNativeFieldType := 'M';
    ftBlob     : FNativeFieldType := 'B';
    ftDBaseOle : FNativeFieldType := 'G';
    ftInteger  :
      if DbfVersion = xBaseVII then
        FNativeFieldType := 'I'
      else
        FNativeFieldType := 'N';
  else
//    FFieldType := ftUnknown;
    FNativeFieldType := #0;
    raise EDbfError.CreateFmt(STRING_INVALID_VCL_FIELD_TYPE, [GetDisplayName, Ord(FFieldType)]);
  end; // Case
end;

procedure TDbfFieldDef.SetDefaultSize;
begin
  case FFieldType of
    ftFloat:
      begin
        FSize := 18;
        FPrecision := 9;
      end;
    ftCurrency:
      begin
        FSize := 16;
        FPrecision := 2;
      end;
    ftSmallInt, ftWord:
      begin
        FSize := DIGITS_SMALLINT;
        FPrecision := 0;
      end;
    ftInteger:
      begin
        if DbfVersion = xBaseVII then
          FSize := 4
        else
          FSize := DIGITS_INTEGER;
        FPrecision := 0;
      end;
{$ifdef DELPHI_4}
    ftLargeInt:
      begin
        FSize := DIGITS_LARGEINT;
        FPrecision := 0;
      end;
{$endif}
    ftDate, ftDateTime:
      begin
        FSize := 8;
        FPrecision := 0;
      end;
  end; // case fieldtype
end;

procedure TDbfFieldDef.CheckSizePrecision;
begin
  case FNativeFieldType of
    'C':
      begin
        if FSize < 0      then FSize := 0;
        if FSize >= 65534 then FSize := 65534;
        FPrecision := 0;
      end;
    'L':
      begin
        FSize := 1;
        FPrecision := 0;
      end;
    'N','F':
      begin
        if FSize < 1       then FSize := 0;
        if FSize >= 20     then FSize := 20;
        if FPrecision > FSize-2 then FPrecision := FSize-2;
        if FPrecision < 0       then FPrecision := 0;
      end;
    'D':
      begin
        FSize := 8;
        FPrecision := 0;
      end;
    'M','G','B':
      begin
        FSize := 10;
        FPrecision := 0;
      end;
    '+','I':
      begin
        FSize := 4;
        FPrecision := 0;
      end;
    '@', 'O':
      begin
        FSize := 8;
        FPrecision := 0;
      end;
  else
    // Nothing
  end; // case
end;

function TDbfFieldDef.GetDisplayName: string; {override;}
begin
  Result := FieldName;
end;

function TDbfFieldDef.IsBlob: Boolean; {override;}
begin
  Result := FNativeFieldType in ['M','G','B'];
end;

procedure TDbfFieldDef.FreeBuffers;
begin
  if FDefaultBuf <> nil then
  begin
    // one buffer for all
    FreeMemAndNil(Pointer(FDefaultBuf));
    FMinBuf := nil;
    FMaxBuf := nil;
  end;
  FAllocSize := 0;
end;

procedure TDbfFieldDef.AllocBuffers;
begin
  // size changed?
  if FAllocSize <> FSize then
  begin
    // free old buffers
    FreeBuffers;
    // alloc new
    GetMem(FDefaultBuf, FSize*3);
    FMinBuf := FDefaultBuf + FSize;
    FMaxBuf := FMinBuf + FSize;
    // store allocated size
    FAllocSize := FSize;
  end;
end;

end.

