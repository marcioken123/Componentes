
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressDataController                                        }
{                                                                    }
{       Copyright (c) 1998-2007 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSDATACONTROLLER AND ALL         }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxDataStorage;                   

{$I cxVer.inc}

interface

uses
  SysUtils, Classes{$IFDEF DELPHI6},Variants
  {$IFNDEF NONDB},FMTBcd, SqlTimSt{$ENDIF}{$ENDIF};

type
{$IFNDEF DELPHI6}
  PPointer = ^Pointer;
  PSmallInt = ^SmallInt;
  PInteger = ^Integer;
  PWord = ^Word;
  PBoolean = ^Boolean;
  PDouble =^Double;
  PByte = ^Byte;
{$ELSE}
  LargeInt = Int64;
  {$IFNDEF CLR}
  PLargeInt = ^LargeInt;
  {$ENDIF}
{$ENDIF}

  { Value Types }

  {$IFDEF CLR}
  PChar = IntPtr;
  Pointer = IntPtr;
  PString = IntPtr;
  PWideString = IntPtr;
  PVariant = Variant;
  {$ENDIF}
  
  PStringValue = PString;
  PWideStringValue = PWideString;

  TcxValueType = class
  protected
    class function Compare(P1, P2: Pointer): Integer; virtual;
    class procedure FreeBuffer(PBuffer: PChar); virtual;
    class procedure FreeTextBuffer(PBuffer: PChar); virtual;
    class function GetDataSize: Integer; virtual;
    class function GetDataValue(PBuffer: PChar): Variant; virtual;
    class function GetDefaultDisplayText(PBuffer: PChar): string; virtual;
    class function GetDisplayText(PBuffer: PChar): string; virtual;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); virtual;
    class procedure ReadDisplayText(PBuffer: PChar; AStream: TStream); virtual;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); virtual;
    class procedure SetDisplayText(PBuffer: PChar; const DisplayText: string); virtual;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); virtual;
    class procedure WriteDisplayText(PBuffer: PChar; AStream: TStream); virtual;
  public
    class function Caption: string; virtual;
    class function CompareValues(P1, P2: Pointer): Integer; virtual;
    class function GetValue(PBuffer: PChar): Variant; virtual;
    class function GetVarType: Integer; virtual;
    class function IsValueValid(var{const }Value: Variant): Boolean; virtual;
    class function IsString: Boolean; virtual;
    class procedure PrepareValueBuffer(var PBuffer: PChar); virtual;
  end;

  TcxValueTypeClass = class of TcxValueType;

  TcxStringValueType = class(TcxValueType)
  protected
    class function Compare(P1, P2: Pointer): Integer; override;
    class procedure FreeBuffer(PBuffer: PChar); override;
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetValue(PBuffer: PChar): Variant; override;
    class function GetVarType: Integer; override;
    class function IsString: Boolean; override;
    class procedure PrepareValueBuffer(var PBuffer: PChar); override;
  end;

  TcxWideStringValueType = class(TcxStringValueType)
  protected
    class function Compare(P1, P2: Pointer): Integer; override;
    class procedure FreeBuffer(PBuffer: PChar); override;
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetValue(PBuffer: PChar): Variant; override;
    class function GetVarType: Integer; override;
    class function IsString: Boolean; override;
    class procedure PrepareValueBuffer(var PBuffer: PChar); override;
  end;

  TcxSmallintValueType = class(TcxValueType)
  protected
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetVarType: Integer; override;
  end;

  TcxIntegerValueType = class(TcxValueType)
  protected
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetVarType: Integer; override;
  end;

  TcxWordValueType = class(TcxValueType)
  protected
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetVarType: Integer; override;
  end;

  TcxBooleanValueType = class(TcxValueType)
  protected
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class function GetDefaultDisplayText(PBuffer: PChar): string; override;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetVarType: Integer; override;
  end;

  TcxFloatValueType = class(TcxValueType) // TODO: Double or Extended?
  protected
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetVarType: Integer; override;
  end;

  TcxCurrencyValueType = class(TcxValueType)
  protected
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetVarType: Integer; override;
  end;

  TcxDateTimeValueType = class(TcxValueType)
  private
    class function GetDateTime(PBuffer: PChar): TDateTime; 
  protected
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class function GetDefaultDisplayText(PBuffer: PChar): string; override;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetVarType: Integer; override;
  end;

{$IFDEF DELPHI6}
  TcxLargeIntValueType = class(TcxValueType)
  protected
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetVarType: Integer; override;
  end;

  {$IFNDEF NONDB}
  TcxFMTBcdValueType = class(TcxValueType)
  protected
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class function GetDefaultDisplayText(PBuffer: PChar): string; override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetVarType: Integer; override;
  end;

  TcxSQLTimeStampValueType = class(TcxValueType)
  protected
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetVarType: Integer; override;
  end;
  {$ENDIF}
  {$ENDIF}

  TcxVariantValueType = class(TcxValueType)
  protected
    class function Compare(P1, P2: Pointer): Integer; override;
    class procedure FreeBuffer(PBuffer: PChar); override;
    class function GetDataSize: Integer; override;
    class function GetDataValue(PBuffer: PChar): Variant; override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
  public
    class function CompareValues(P1, P2: Pointer): Integer; override;
    class function GetValue(PBuffer: PChar): Variant; override;
    class procedure PrepareValueBuffer(var PBuffer: PChar); override;
  end;

  TcxObjectValueType = class(TcxIntegerValueType)
  protected
    class procedure FreeBuffer(PBuffer: PChar); override;
  {$IFDEF CLR}
    class function GetDataValue(PBuffer: PChar): Variant; override;
  {$ENDIF}  
    class procedure ReadDataValue(PBuffer: PChar; AStream: TStream); override;
    class procedure SetDataValue(PBuffer: PChar; const Value: Variant); override;
    class procedure WriteDataValue(PBuffer: PChar; AStream: TStream); override;
  end;

  { TcxDataStorage }

  TcxDataStorage = class;
  TcxValueDefs = class;

  TcxValueDef = class
  private
    FBufferSize: Integer;
    FDataSize: Integer;
    FStored: Boolean;
    FLinkObject: TObject;
    FOffset: Integer;
    FStreamStored: Boolean;
    FTextStored: Boolean;
    FValueDefs: TcxValueDefs;
    FValueTypeClass: TcxValueTypeClass;
    function GetIsNeedConversion: Boolean;
    function GetTextStored: Boolean;
    procedure SetStored(Value: Boolean);
    procedure SetTextStored(Value: Boolean);
    procedure SetValueTypeClass(Value: TcxValueTypeClass);
  protected
    procedure Changed(AResyncNeeded: Boolean);
    function Compare(P1, P2: PChar): Integer;
    procedure FreeBuffer(PBuffer: PChar);
    procedure FreeTextBuffer(PBuffer: PChar);
    function GetDataValue(PBuffer: PChar): Variant;
    function GetDisplayText(PBuffer: PChar): string;
    function GetLinkObject: TObject; virtual;
    function GetStored: Boolean; virtual;
    procedure Init(var AOffset: Integer);
    function IsNullValue(PBuffer: PChar): Boolean;
    function IsNullValueEx(PBuffer: PChar; AOffset: Integer): Boolean;
    procedure ReadDataValue(PBuffer: PChar; AStream: TStream);
    procedure ReadDisplayText(PBuffer: PChar; AStream: TStream);
    procedure SetDataValue(PBuffer: PChar; const Value: Variant);
    procedure SetDisplayText(PBuffer: PChar; const DisplayText: string);
    procedure SetLinkObject(Value: TObject); virtual;
    procedure SetNull(PBuffer: PChar; IsNull: Boolean);
    procedure WriteDataValue(PBuffer: PChar; AStream: TStream);
    procedure WriteDisplayText(PBuffer: PChar; AStream: TStream);
    property BufferSize: Integer read FBufferSize;
    property DataSize: Integer read FDataSize;
    property Offset: Integer read FOffset;
    property ValueDefs: TcxValueDefs read FValueDefs;
  public
    constructor Create(AValueDefs: TcxValueDefs; AValueTypeClass: TcxValueTypeClass); virtual;
    destructor Destroy; override;
    procedure Assign(ASource: TcxValueDef); virtual;
    function CompareValues(AIsNull1, AIsNull2: Boolean; P1, P2: PChar): Integer;
    property IsNeedConversion: Boolean read GetIsNeedConversion;
    property LinkObject: TObject read GetLinkObject write SetLinkObject;
    property Stored: Boolean read GetStored write SetStored default True;
    property TextStored: Boolean read GetTextStored write SetTextStored default False;
    property ValueTypeClass: TcxValueTypeClass read FValueTypeClass write SetValueTypeClass;
    property StreamStored: Boolean read FStreamStored write FStreamStored default True;
  end;

  TcxValueDefClass = class of TcxValueDef;

  TcxValueDefs = class
  private
    FDataStorage: TcxDataStorage;
    FItems: TList;
    FRecordOffset: Integer;
    FRecordSize: Integer;
    function GetStoredCount: Integer;
    function GetCount: Integer;
    function GetItem(Index: Integer): TcxValueDef;
  protected
    procedure Changed(AValueDef: TcxValueDef; AResyncNeeded: Boolean); virtual;
    function GetValueDefClass: TcxValueDefClass; virtual;
    procedure Prepare(AStartOffset: Integer); virtual;
    procedure Remove(AItem: TcxValueDef);
    property DataStorage: TcxDataStorage read FDataStorage;
  public
    constructor Create(ADataStorage: TcxDataStorage); virtual;
    destructor Destroy; override;
    function Add(AValueTypeClass: TcxValueTypeClass; AStored, ATextStored: Boolean; ALinkObject: TObject): TcxValueDef;
    procedure Clear;
    property StoredCount: Integer read GetStoredCount;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxValueDef read GetItem; default;
    property RecordSize: Integer read FRecordSize;
  end;

  { internal value defs }

  TcxInternalValueDef = class(TcxValueDef)
  protected
    function GetLinkObject: TObject; override;
    function GetStored: Boolean; override;
  public
    function GetValueDef: TcxValueDef;
  end;

  TcxInternalValueDefs = class(TcxValueDefs)
  protected
    function GetValueDefClass: TcxValueDefClass; override;
  public
    function FindByLinkObject(ALinkObject: TObject): TcxValueDef;
    procedure RemoveByLinkObject(ALinkObject: TObject);
  end;

  TcxValueDefReader = class
  public
    constructor Create; virtual;
    function GetDisplayText(AValueDef: TcxValueDef): string; virtual;
    function GetValue(AValueDef: TcxValueDef): Variant; virtual;
    function IsInternal(AValueDef: TcxValueDef): Boolean; virtual;
  end;

  TcxValueDefReaderClass = class of TcxValueDefReader;

  TcxValueDefSetProc = procedure (AValueDef: TcxValueDef; AFromRecordIndex, AToRecordIndex: Integer;
    AValueDefReader: TcxValueDefReader) of object;

  TcxDataStorage = class
  private
    FDestroying: Boolean;
    FInternalRecordBuffers: TList;
    FInternalValueDefs: TcxInternalValueDefs;
    FStoredValuesOnly: Boolean;
    FRecordBuffers: TList;
    FRecordIDCounter: Integer;
    FUseRecordID: Boolean;
    FValueDefs: TcxValueDefs;
    FValueDefsList: TList;
//    FValueDefsChanged: Boolean;
    FOnClearInternalRecords: TNotifyEvent;
    function GetRecordBuffer(Index: Integer): PChar;
    function GetRecordCount: Integer;
    procedure SetStoredValuesOnly(Value: Boolean);
    procedure SetRecordBuffer(Index: Integer; Value: PChar);
    procedure SetRecordCount(Value: Integer);
    procedure SetUseRecordID(Value: Boolean);
  protected
    function AllocRecordBuffer(Index: Integer): PChar;
    function CalcRecordOffset: Integer;
    procedure ChangeRecordFlag(PBuffer: PChar; AFlag: Byte; ATurnOn: Boolean);
    procedure CheckRecordID(ARecordIndex: Integer);
    procedure CheckRecordIDCounter;
    procedure CheckRecordIDCounterAfterLoad(ALoadedID: Integer);
    function CheckValueDef(ARecordIndex: Integer; var AValueDef: TcxValueDef): Boolean;
    procedure DeleteInternalRecord(ARecordIndex: Integer);
    procedure FreeAndNilRecordBuffer(AIndex: Integer);
    procedure InitStructure(AValueDefs: TcxValueDefs); virtual;
    procedure InsertValueDef(AIndex: Integer; AValueDef: TcxValueDef);
    function IsRecordFlag(PBuffer: PChar; AFlag: Byte): Boolean;
    procedure RemoveValueDef(AValueDef: TcxValueDef);
    procedure ValueDefsChanged(AValueDef: TcxValueDef; AResyncNeeded: Boolean); virtual;
    function ValueDefsByRecordIndex(Index: Integer): TcxValueDefs; virtual;
    property InternalValueDefs: TcxInternalValueDefs read FInternalValueDefs;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function AddInternalRecord: Integer;
    function AppendRecord: Integer;
    procedure BeforeDestruction; {$IFNDEF CLR}override;{$ENDIF}
    procedure BeginLoad;
    procedure CheckStructure;
    procedure Clear(AWithoutInternal: Boolean);
    procedure ClearInternalRecords;
    procedure ClearRecords(AClearList: Boolean);
    function CompareRecords(ARecordIndex1, ARecordIndex2: Integer; AValueDef: TcxValueDef): Integer;
    procedure DeleteRecord(ARecordIndex: Integer);
    procedure EndLoad;
    function GetDisplayText(ARecordIndex: Integer; AValueDef: TcxValueDef): string;
    function GetCompareInfo(ARecordIndex: Integer; AValueDef: TcxValueDef; var P: PChar): Boolean;
    function GetRecordID(ARecordIndex: Integer): Integer;
    function GetValue(ARecordIndex: Integer; AValueDef: TcxValueDef): Variant;
    procedure InsertRecord(ARecordIndex: Integer);
    procedure ReadData(ARecordIndex: Integer; AStream: TStream);
    procedure ReadRecord(ARecordIndex: Integer; AValueDefReader: TcxValueDefReader);
    procedure ReadRecordFrom(AFromRecordIndex, AToRecordIndex: Integer; AValueDefReader: TcxValueDefReader; ASetProc: TcxValueDefSetProc);
    procedure SetDisplayText(ARecordIndex: Integer; AValueDef: TcxValueDef; const Value: string);
    procedure SetRecordID(ARecordIndex, AID: Integer);
    procedure SetValue(ARecordIndex: Integer; AValueDef: TcxValueDef; const Value: Variant);
    procedure WriteData(ARecordIndex: Integer; AStream: TStream);

    procedure BeginStreaming(ACompare: TListSortCompare);
    procedure EndStreaming;
    
    property StoredValuesOnly: Boolean read FStoredValuesOnly write SetStoredValuesOnly;
    property UseRecordID: Boolean read FUseRecordID write SetUseRecordID;
    property RecordBuffers[Index: Integer]: PChar read GetRecordBuffer write SetRecordBuffer;
    property RecordCount: Integer read GetRecordCount write SetRecordCount;
    property ValueDefs: TcxValueDefs read FValueDefs;
    property OnClearInternalRecords: TNotifyEvent read FOnClearInternalRecords write FOnClearInternalRecords;
  end;

  { TcxLookupList }

  TcxLookupListItem = {$IFNDEF CLR}record{$ELSE}class{$ENDIF}
    KeyValue: Variant;
    DisplayText: string;
  end;
  {$IFNDEF CLR}
  PcxLookupListItem = ^TcxLookupListItem;
  {$ELSE}
  PcxLookupListItem = TcxLookupListItem;
  {$ENDIF}

  TcxLookupList = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): PcxLookupListItem;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Find(const AKeyValue: Variant; var AIndex: Integer): Boolean;
    procedure Insert(AIndex: Integer; const AKeyValue: Variant; const ADisplayText: string);
    property Count: Integer read GetCount;
    property Items[Index: Integer]: PcxLookupListItem read GetItem; default;
  end;

  { TcxValueTypeClassList }

  TcxValueTypeClassList = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TcxValueTypeClass;
  public
    constructor Create;
    destructor Destroy; override;
    function ItemByCaption(const ACaption: string): TcxValueTypeClass;
    procedure RegisterItem(AValueTypeClass: TcxValueTypeClass);
    procedure UnregisterItem(AValueTypeClass: TcxValueTypeClass);
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxValueTypeClass read GetItem; default;
  end;

function cxValueTypeClassList: TcxValueTypeClassList;

function IsDateTimeValueTypeClass(AValueTypeClass: TcxValueTypeClass): Boolean;

implementation

uses
  cxVariants{$IFDEF CLR}, System.Runtime.InteropServices, System.Collections{$ENDIF};

const
  RecordFlagSize = SizeOf(Byte);
  ValueFlagSize  = SizeOf(Byte);
  PointerSize    = {$IFNDEF CLR}SizeOf(Pointer){$ELSE}4{$ENDIF};
  RecordIDSize   = SizeOf(Integer);
  // RecordFlag Bit Masks
  RecordFlag_Busy = $01;

var
  FValueTypeClassList: TcxValueTypeClassList;
{$IFDEF CLR}
  FObjectHashtable: Hashtable;
type
  TVariantValue = class
  public
    V: Variant;
  end;
{$ENDIF}

function cxValueTypeClassList: TcxValueTypeClassList;
begin
  if FValueTypeClassList = nil then
    FValueTypeClassList := TcxValueTypeClassList.Create;
  Result := FValueTypeClassList;
end;

function IsDateTimeValueTypeClass(AValueTypeClass: TcxValueTypeClass): Boolean;
begin
  Result := (AValueTypeClass = TcxDateTimeValueType)
    {$IFDEF DELPHI6}{$IFNDEF NONDB} or (AValueTypeClass = TcxSQLTimeStampValueType){$ENDIF}{$ENDIF};
end;

function IncPChar(P: PChar; AOffset: Integer): PChar;
begin
{$IFNDEF CLR}
  Result := P + AOffset;
{$ELSE}
  Result := IntPtr(Integer(P) + AOffset);
{$ENDIF}
end;

{$IFDEF CLR}

function AllocMem(ASize: Integer): IntPtr;
var
  I: Integer;
begin
  Result := Marshal.AllocHGlobal(ASize);
  for I := 0 to ASize - 1 do
    Marshal.WriteByte(Result, I, 0);
end;

procedure ReallocMem(var P: IntPtr; ASize: IntPtr);
begin
  P := Marshal.ReAllocHGlobal(P, ASize);
end;

{$ENDIF}

{ TcxValueType }

class function TcxValueType.Caption: string;
var
  I: Integer;
begin
  Result := ClassName;
  if Result <> '' then
  begin
    if Copy(Result, 1, 3) = 'Tcx' then
      Delete(Result, 1, 3);
    I := Pos('ValueType', Result);
    if I <> 0 then
      Delete(Result, I, Length('ValueType'));
  end;
end;

class function TcxValueType.CompareValues(P1, P2: Pointer): Integer;
begin
  Result := VarCompare(GetDataValue(P1), GetDataValue(P2));
end;

class function TcxValueType.GetValue(PBuffer: PChar): Variant;
begin
  Result := GetDataValue(PBuffer);
end;

class function TcxValueType.GetVarType: Integer;
begin
  Result := varVariant;
end;

class function TcxValueType.IsValueValid(var{const }Value: Variant): Boolean;
//var
//  V: Variant;
begin
  if VarIsNull(Value) or (GetVarType = varVariant) then  // not Empty?
    Result := True
  else
  begin
    Result := False;
    try
      VarCast(Value{V}, Value, GetVarType);
      Result := True;
    except
      on E: EVariantError do;
    end;
  end;
end;

class function TcxValueType.IsString: Boolean;
begin
  Result := False;
end;

class procedure TcxValueType.PrepareValueBuffer(var PBuffer: PChar);
begin
end;

class function TcxValueType.Compare(P1, P2: Pointer): Integer;
begin
  Result := CompareValues(P1, P2);
end;

class procedure TcxValueType.FreeBuffer(PBuffer: PChar);
begin
end;

class procedure TcxValueType.FreeTextBuffer(PBuffer: PChar);
var
  P: PStringValue;
begin
{$IFNDEF CLR}
  P := PPointer(PBuffer)^;
  if P <> nil then
    Dispose(P);
{$ELSE}
  P := Marshal.ReadIntPtr(PBuffer);
  if P <> nil then
    Marshal.FreeHGlobal(P);
{$ENDIF}
end;

class function TcxValueType.GetDataSize: Integer;
begin
  Result := 0;
end;

class function TcxValueType.GetDataValue(PBuffer: PChar): Variant;
begin
  Result := Null;
end;

class function TcxValueType.GetDefaultDisplayText(PBuffer: PChar): string;
begin
  try
    Result := VarToStr(GetDataValue(PBuffer));
  except
    on EVariantError do
      Result := '';
  end;
end;

class function TcxValueType.GetDisplayText(PBuffer: PChar): string;
var
  P: PStringValue;
begin
{$IFNDEF CLR}
  P := PPointer(PBuffer)^;
  if P <> nil then
    Result := P^
  else
    Result := '';
{$ELSE}
  P := Marshal.ReadIntPtr(PBuffer);
  if P <> nil then
    Result := Marshal.PtrToStringAnsi(P)
  else
    Result := '';
{$ENDIF}
end;

class procedure TcxValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  SetDataValue(PBuffer, ReadVariantFunc(AStream));
end;

class procedure TcxValueType.ReadDisplayText(PBuffer: PChar; AStream: TStream);
begin
  SetDisplayText(PBuffer, ReadStringFunc(AStream));
end;

class procedure TcxValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
begin
end;

class procedure TcxValueType.SetDisplayText(PBuffer: PChar; const DisplayText: string);
var
  P: PStringValue;
begin
{$IFNDEF CLR}
  P := PPointer(PBuffer)^;
  if P = nil then
  begin
    New(P);
    PPointer(PBuffer)^ := P;
  end;
  P^ := DisplayText;
{$ELSE}
  P := Marshal.ReadIntPtr(PBuffer);
  if P <> nil then
    Marshal.FreeHGlobal(P);
  P := Marshal.StringToHGlobalAnsi(DisplayText);
  Marshal.WriteIntPtr(PBuffer, P);
{$ENDIF}
end;

class procedure TcxValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  WriteVariantProc(AStream, GetDataValue(PBuffer));
end;

class procedure TcxValueType.WriteDisplayText(PBuffer: PChar; AStream: TStream);
begin
  WriteStringProc(AStream, GetDisplayText(PBuffer));
end;

{ TcxStringValueType }

class function TcxStringValueType.CompareValues(P1, P2: Pointer): Integer;
var
  S1, S2: string;
begin
  if Assigned(P1) then
  begin
    if Assigned(P2) then
    begin
    {$IFNDEF CLR}
      S1 := PStringValue(P1)^;
      S2 := PStringValue(P2)^;
    {$ELSE}
      S1 := Marshal.PtrToStringAnsi(P1);
      S2 := Marshal.PtrToStringAnsi(P2);
    {$ENDIF}
      if S1 = S2 then
        Result := 0
      else
        if S1 < S2 then
          Result := -1
        else
          Result := 1;
    end
    else
      Result := 1;
  end
  else
  begin
    if Assigned(P2) then
      Result := -1
    else
      Result := 0;
  end;
end;

class function TcxStringValueType.GetValue(PBuffer: PChar): Variant;
{$IFDEF CLR}
var
  P: IntPtr;
{$ENDIF}
begin
{$IFNDEF CLR}
  Result := GetDataValue(@PBuffer);
{$ELSE}
  Marshal.WriteIntPtr(P, PBuffer);
  Result := GetDataValue(P);
{$ENDIF}
end;

class function TcxStringValueType.GetVarType: Integer;
begin
  Result := varString;
end;

class function TcxStringValueType.IsString: Boolean;
begin
  Result := True;
end;

class procedure TcxStringValueType.PrepareValueBuffer(var PBuffer: PChar);
begin
{$IFNDEF CLR}
  PBuffer := PPointer(PBuffer)^;
{$ELSE}
  PBuffer := Marshal.ReadIntPtr(PBuffer);
{$ENDIF}
end;

class function TcxStringValueType.Compare(P1, P2: Pointer): Integer;
begin
{$IFNDEF CLR}
  Result := CompareValues(PPointer(P1)^, PPointer(P2)^);
{$ELSE}
  Result := CompareValues(Marshal.ReadIntPtr(P1), Marshal.ReadIntPtr(P2));
{$ENDIF}
end;

class procedure TcxStringValueType.FreeBuffer(PBuffer: PChar);
begin
{$IFNDEF CLR}
  Dispose(PStringValue(PPointer(PBuffer)^));
{$ELSE}
  Marshal.FreeHGlobal(Marshal.ReadIntPtr(PBuffer));
{$ENDIF}
end;

class function TcxStringValueType.GetDataSize: Integer;
begin
  Result := SizeOf(PStringValue);
end;

class function TcxStringValueType.GetDataValue(PBuffer: PChar): Variant;
var
  P: PStringValue;
begin
{$IFNDEF CLR}
  P := PPointer(PBuffer)^;
  if P <> nil then
    Result := P^
  else
    Result := inherited GetDataValue(PBuffer);
{$ELSE}
  P := Marshal.ReadIntPtr(PBuffer);
  if P <> nil then
    Result := Marshal.PtrToStringAnsi(P)
  else
    Result := inherited GetDataValue(PBuffer);
{$ENDIF}
end;

class procedure TcxStringValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  SetDataValue(PBuffer, ReadStringFunc(AStream));
end;

class procedure TcxStringValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
begin
  SetDisplayText(PBuffer, Value);
end;

class procedure TcxStringValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  WriteStringProc(AStream, GetDisplayText(PBuffer));
end;

{ TcxWideStringValueType }

class function TcxWideStringValueType.CompareValues(P1, P2: Pointer): Integer;
var
  WS1, WS2: WideString;
begin
  if Assigned(P1) then
  begin
    if Assigned(P2) then
    begin
    {$IFNDEF CLR}
      WS1 := PWideStringValue(P1)^;
      WS2 := PWideStringValue(P2)^;
    {$ELSE}
      WS1 := Marshal.PtrToStringUni(P1);
      WS2 := Marshal.PtrToStringUni(P2);
    {$ENDIF}
      if WS1 = WS2 then
        Result := 0
      else
        if WS1 < WS2 then
          Result := -1
        else
          Result := 1;
    end
    else
      Result := 1;
  end
  else
  begin
    if Assigned(P2) then
      Result := -1
    else
      Result := 0;
  end;
end;

class function TcxWideStringValueType.GetValue(PBuffer: PChar): Variant;
{$IFDEF CLR}
var
  P: IntPtr;
{$ENDIF}
begin
{$IFNDEF CLR}
  Result := GetDataValue(@PBuffer);
{$ELSE}
  Marshal.WriteIntPtr(P, PBuffer);
  Result := GetDataValue(P);
{$ENDIF}
end;

class function TcxWideStringValueType.GetVarType: Integer;
begin
  Result := varOleStr;
end;

class function TcxWideStringValueType.IsString: Boolean;
begin
  Result := True;
end;

class procedure TcxWideStringValueType.PrepareValueBuffer(var PBuffer: PChar);
begin
{$IFNDEF CLR}
  PBuffer := PPointer(PBuffer)^;
{$ELSE}
  PBuffer := Marshal.ReadIntPtr(PBuffer);
{$ENDIF}
end;

class function TcxWideStringValueType.Compare(P1, P2: Pointer): Integer;
begin
{$IFNDEF CLR}
  Result := CompareValues(PPointer(P1)^, PPointer(P2)^);
{$ELSE}
  Result := CompareValues(Marshal.ReadIntPtr(P1), Marshal.ReadIntPtr(P2));
{$ENDIF}
end;

class procedure TcxWideStringValueType.FreeBuffer(PBuffer: PChar);
begin
{$IFNDEF CLR}
  Dispose(PWideStringValue(PPointer(PBuffer)^));
{$ELSE}
  Marshal.FreeHGlobal(Marshal.ReadIntPtr(PBuffer));
{$ENDIF}
end;

class function TcxWideStringValueType.GetDataSize: Integer;
begin
  Result := SizeOf(PWideStringValue);
end;

class function TcxWideStringValueType.GetDataValue(PBuffer: PChar): Variant;
var
  P: PWideStringValue;
begin
{$IFNDEF CLR}
  P := PPointer(PBuffer)^;
  if P <> nil then
    Result := P^
  else
    Result := inherited GetDataValue(PBuffer);
{$ELSE}
  P := Marshal.ReadIntPtr(PBuffer);
  if P <> nil then
    Result := Marshal.PtrToStringUni(P)
  else
    Result := inherited GetDataValue(PBuffer);
{$ENDIF}
end;

class procedure TcxWideStringValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  SetDataValue(PBuffer, ReadWideStringFunc(AStream));
end;

class procedure TcxWideStringValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
var
  P: PWideStringValue;
begin
{$IFNDEF CLR}
  P := PPointer(PBuffer)^;
  if P = nil then
  begin
    New(P);
    PPointer(PBuffer)^ := P;
  end;
  P^ := Value;
{$ELSE}
  P := Marshal.ReadIntPtr(PBuffer);
  if P <> nil then
    Marshal.FreeHGlobal(P);
  P := Marshal.StringToHGlobalUni(Value);
  Marshal.WriteIntPtr(PBuffer, P);
{$ENDIF}
end;

class procedure TcxWideStringValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  WriteWideStringProc(AStream, VarToStr(GetDataValue(PBuffer)));
end;

{ TcxSmallintValueType }

class function TcxSmallintValueType.CompareValues(P1, P2: Pointer): Integer;
begin
{$IFNDEF CLR}
  Result := PSmallInt(P1)^ - PSmallInt(P2)^;
{$ELSE}
  Result := Marshal.ReadInt16(P1) - Marshal.ReadInt16(P2);
{$ENDIF}
end;

class function TcxSmallintValueType.GetVarType: Integer;
begin
  Result := varSmallint;
end;

class function TcxSmallintValueType.GetDataSize: Integer;
begin
  Result := SizeOf(SmallInt);
end;

class function TcxSmallintValueType.GetDataValue(PBuffer: PChar): Variant;
begin
{$IFNDEF CLR}
  Result := PSmallInt(PBuffer)^;
{$ELSE}
  Result := Marshal.ReadInt16(PBuffer);
{$ENDIF}
end;

class procedure TcxSmallintValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  SetDataValue(PBuffer, ReadSmallIntFunc(AStream));
end;

class procedure TcxSmallintValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
{$IFDEF CLR}
var
  SI: Smallint;
{$ENDIF}
begin
{$IFNDEF CLR}
  PSmallInt(PBuffer)^ := Value;
{$ELSE}
  SI := Value;
  Marshal.WriteInt16(PBuffer, SI);
{$ENDIF}
end;

class procedure TcxSmallintValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  WriteSmallIntProc(AStream, SmallInt(GetDataValue(PBuffer)));
end;

{ TcxIntegerValueType }

class function TcxIntegerValueType.CompareValues(P1, P2: Pointer): Integer;
begin
{$IFNDEF CLR}
  Result := PInteger(P1)^ - PInteger(P2)^;
{$ELSE}
  Result := Marshal.ReadInt32(P1) - Marshal.ReadInt32(P2);
{$ENDIF}
end;

class function TcxIntegerValueType.GetVarType: Integer;
begin
  Result := varInteger;
end;

class function TcxIntegerValueType.GetDataSize: Integer;
begin
  Result := SizeOf(Integer);
end;

class function TcxIntegerValueType.GetDataValue(PBuffer: PChar): Variant;
begin
{$IFNDEF CLR}
  Result := PInteger(PBuffer)^;
{$ELSE}
  Result := Marshal.ReadInt32(PBuffer);
{$ENDIF}
end;

class procedure TcxIntegerValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  SetDataValue(PBuffer, ReadIntegerFunc(AStream));
end;

class procedure TcxIntegerValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
{$IFDEF CLR}
var
  I: Integer;
{$ENDIF}
begin
{$IFNDEF CLR}
  PInteger(PBuffer)^ := Value;
{$ELSE}
  I := Value;
  Marshal.WriteInt32(PBuffer, I);
{$ENDIF}
end;

class procedure TcxIntegerValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  WriteIntegerProc(AStream, Integer(GetDataValue(PBuffer)));
end;

{ TcxWordValueType }

class function TcxWordValueType.CompareValues(P1, P2: Pointer): Integer;
begin
{$IFNDEF CLR}
  Result := PWord(P1)^ - PWord(P2)^;
{$ELSE}
  Result := Word(Marshal.ReadInt16(P1)) - Word(Marshal.ReadInt16(P2));
{$ENDIF}
end;

class function TcxWordValueType.GetVarType: Integer;
begin
  Result := {$IFDEF DELPHI6}varWord{$ELSE}$0012{$ENDIF};
end;

class function TcxWordValueType.GetDataSize: Integer;
begin
  Result := SizeOf(Word);
end;

class function TcxWordValueType.GetDataValue(PBuffer: PChar): Variant;
begin
{$IFNDEF CLR}
  Result := PWord(PBuffer)^;
{$ELSE}
  Result := Word(Marshal.ReadInt16(PBuffer));
{$ENDIF}
end;

class procedure TcxWordValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  SetDataValue(PBuffer, ReadWordFunc(AStream));
end;

class procedure TcxWordValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
{$IFDEF CLR}
var
  W: Word;
{$ENDIF}
begin
{$IFNDEF CLR}
  PWord(PBuffer)^ := Value;
{$ELSE}
  W := Value;
  Marshal.WriteInt16(PBuffer, W);
{$ENDIF}
end;

class procedure TcxWordValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  WriteWordProc(AStream, Word(GetDataValue(PBuffer)));
end;

{ TcxBooleanValueType }

class function TcxBooleanValueType.CompareValues(P1, P2: Pointer): Integer;
begin
{$IFNDEF CLR}
  Result := Integer(PBoolean(P1)^) - Integer(PBoolean(P2)^);
{$ELSE}
  Result := Integer(Marshal.ReadByte(P1)) - Integer(Marshal.ReadByte(P2));
{$ENDIF}
end;

class function TcxBooleanValueType.GetVarType: Integer;
begin
  Result := varBoolean;
end;

class function TcxBooleanValueType.GetDataSize: Integer;
begin
  Result := SizeOf(Boolean);
end;

class function TcxBooleanValueType.GetDataValue(PBuffer: PChar): Variant;
begin
{$IFNDEF CLR}
  Result := PBoolean(PBuffer)^;
{$ELSE}
  Result := Boolean(Marshal.ReadByte(PBuffer));
{$ENDIF}
end;

class function TcxBooleanValueType.GetDefaultDisplayText(PBuffer: PChar): string;
begin
  try
  {$IFDEF DELPHI6}
    Result := BoolToStr(GetDataValue(PBuffer), True);
  {$ELSE}
    Result := GetDataValue(PBuffer);
  {$ENDIF}
  except
    on EVariantError do
      Result := '';
  end;
end;

class procedure TcxBooleanValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  SetDataValue(PBuffer, ReadBooleanFunc(AStream));
end;

class procedure TcxBooleanValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
begin
{$IFNDEF CLR}
  PBoolean(PBuffer)^ := Value;
{$ELSE}
  Marshal.WriteByte(PBuffer, Value);
{$ENDIF}
end;

class procedure TcxBooleanValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  WriteBooleanProc(AStream, Boolean(GetDataValue(PBuffer)));
end;

{ TcxFloatValueType }

class function TcxFloatValueType.CompareValues(P1, P2: Pointer): Integer;
var
  D1, D2: Double;
begin
{$IFNDEF CLR}
  D1 := PDouble(P1)^;
  D2 := PDouble(P2)^;
{$ELSE}
  D1 := BitConverter.Int64BitsToDouble(Marshal.ReadInt64(P1));
  D2 := BitConverter.Int64BitsToDouble(Marshal.ReadInt64(P2));
{$ENDIF}
  if D1 = D2 then
    Result := 0
  else
    if D1 < D2 then
      Result := -1
    else
      Result := 1;
end;

class function TcxFloatValueType.GetVarType: Integer;
begin
  Result := varDouble;
end;

class function TcxFloatValueType.GetDataSize: Integer;
begin
  Result := SizeOf(Double);
end;

class function TcxFloatValueType.GetDataValue(PBuffer: PChar): Variant;
begin
{$IFNDEF CLR}
  Result := PDouble(PBuffer)^;
{$ELSE}
  Result := BitConverter.Int64BitsToDouble(Marshal.ReadInt64(PBuffer));
{$ENDIF}
end;

class procedure TcxFloatValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
{$IFNDEF CLR}
var
  E: Extended;
{$ENDIF}
begin
{$IFNDEF CLR}
  ReadFloatProc(AStream, E);
  PDouble(PBuffer)^ := E;
{$ELSE}
  SetDataValue(PBuffer, Double(ReadFloatFunc(AStream)));
{$ENDIF}
end;

class procedure TcxFloatValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
begin
{$IFNDEF CLR}
  PDouble(PBuffer)^ := Value;
{$ELSE}
  Marshal.WriteInt64(PBuffer, BitConverter.DoubleToInt64Bits(Value));
{$ENDIF}
end;

class procedure TcxFloatValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  WriteFloatProc(AStream, Double(GetDataValue(PBuffer)));
end;

{ TcxCurrencyValueType }

class function TcxCurrencyValueType.CompareValues(P1, P2: Pointer): Integer;
var
  C1, C2: Currency;
begin
{$IFNDEF CLR}
  C1 := PCurrency(P1)^;
  C2 := PCurrency(P2)^;
{$ELSE}
  C1 := Currency.FromOACurrency(Marshal.ReadInt64(P1));
  C2 := Currency.FromOACurrency(Marshal.ReadInt64(P2));
{$ENDIF}
  if C1 = C2 then
    Result := 0
  else
    if C1 < C2 then
      Result := -1
    else
      Result := 1;
end;

class function TcxCurrencyValueType.GetVarType: Integer;
begin
  Result := varCurrency;
end;

class function TcxCurrencyValueType.GetDataSize: Integer;
begin
  Result := SizeOf(Currency);
end;

class function TcxCurrencyValueType.GetDataValue(PBuffer: PChar): Variant;
begin
{$IFNDEF CLR}
  Result := PCurrency(PBuffer)^;
{$ELSE}
  Result := Currency.FromOACurrency(Marshal.ReadInt64(PBuffer));
{$ENDIF}
end;

class procedure TcxCurrencyValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  SetDataValue(PBuffer, ReadCurrencyFunc(AStream));
end;

class procedure TcxCurrencyValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
{$IFDEF CLR}
var
  C: Currency;
{$ENDIF}
begin
{$IFNDEF CLR}
  PCurrency(PBuffer)^ := Value;
{$ELSE}
  C := Value;
  Marshal.WriteInt64(PBuffer, C.ToOACurrency);
{$ENDIF}
end;

class procedure TcxCurrencyValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  WriteCurrencyProc(AStream, Currency(GetDataValue(PBuffer)));
end;

{ TcxDateTimeValueType }

class function TcxDateTimeValueType.CompareValues(P1, P2: Pointer): Integer;
var
  D1, D2: Double;
begin
{$IFNDEF CLR}
  D1 := PDateTime(P1)^;
  D2 := PDateTime(P2)^;
{$ELSE}
  D1 := BitConverter.Int64BitsToDouble(Marshal.ReadInt64(P1));
  D2 := BitConverter.Int64BitsToDouble(Marshal.ReadInt64(P2));
{$ENDIF}
  if D1 = D2 then
    Result := 0
  else
    if D1 < D2 then
      Result := -1
    else
      Result := 1;
end;

class function TcxDateTimeValueType.GetVarType: Integer;
begin
  Result := varDate;
end;

class function TcxDateTimeValueType.GetDataSize: Integer;
begin
  Result := SizeOf(TDateTime);
end;

class function TcxDateTimeValueType.GetDataValue(PBuffer: PChar): Variant;
begin
  Result := GetDateTime(PBuffer);
end;

class function TcxDateTimeValueType.GetDefaultDisplayText(PBuffer: PChar): string;
var
  DT: TDateTime;
begin
  DT := GetDateTime(PBuffer);
  try
    Result := VarToStr(DT);
  except
    on EVariantError do
      Result := DateTimeToStr(DT);
  end;
end;

class procedure TcxDateTimeValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  SetDataValue(PBuffer, ReadDateTimeFunc(AStream));
end;

class procedure TcxDateTimeValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
begin
{$IFNDEF CLR}
  PDateTime(PBuffer)^ := VarToDateTime(Value);
{$ELSE}
  Marshal.WriteInt64(PBuffer, BitConverter.DoubleToInt64Bits(TDateTime(Value).ToOADate));
{$ENDIF}
end;

class procedure TcxDateTimeValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  WriteDateTimeProc(AStream, TDateTime(GetDataValue(PBuffer)));
end;

class function TcxDateTimeValueType.GetDateTime(PBuffer: PChar): TDateTime;
begin
{$IFNDEF CLR}
  Result := PDateTime(PBuffer)^;
{$ELSE}
  Result := TDateTime.FromOADate(BitConverter.Int64BitsToDouble(Marshal.ReadInt64(PBuffer)));
{$ENDIF}
end;
 
{$IFDEF DELPHI6}

{ TcxLargeIntValueType }

class function TcxLargeIntValueType.CompareValues(P1, P2: Pointer): Integer;
var
  L1, L2: LargeInt;
begin
{$IFNDEF CLR}
  L1 := PLargeInt(P1)^;
  L2 := PLargeInt(P2)^;
{$ELSE}
  L1 := Marshal.ReadInt64(P1);
  L2 := Marshal.ReadInt64(P2);
{$ENDIF}
  if L1 = L2 then
    Result := 0
  else
    if L1 < L2 then
      Result := -1
    else
      Result := 1;
end;

class function TcxLargeIntValueType.GetVarType: Integer;
begin
  Result := varInt64;
end;

class function TcxLargeIntValueType.GetDataSize: Integer;
begin
  Result := SizeOf(LargeInt);
end;

class function TcxLargeIntValueType.GetDataValue(PBuffer: PChar): Variant;
begin
{$IFNDEF CLR}
  Result := PLargeInt(PBuffer)^;
{$ELSE}
  Result := Marshal.ReadInt64(PBuffer);
{$ENDIF}
end;

class procedure TcxLargeIntValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  SetDataValue(PBuffer, ReadLargeIntFunc(AStream));
end;

class procedure TcxLargeIntValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
begin
{$IFNDEF CLR}
  PLargeInt(PBuffer)^ := Value;
{$ELSE}
  Marshal.WriteInt64(PBuffer, Value);
{$ENDIF}
end;

class procedure TcxLargeIntValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
{$IFNDEF CLR}
  WriteLargeIntProc(AStream, PLargeInt(PBuffer)^);
{$ELSE}
  WriteLargeIntProc(AStream, LargeInt(GetDataValue(PBuffer)));
{$ENDIF}
end;

{$IFNDEF NONDB}
{ TcxFMTBcdValueType }

class function TcxFMTBcdValueType.CompareValues(P1, P2: Pointer): Integer;
var
  B1, B2: TBcd;
{$IFDEF CLR}
  Temp: TBytes;
{$ENDIF}
begin
{$IFNDEF CLR}
  B1 := PBcd(P1)^;
  B2 := PBcd(P2)^;
{$ELSE}
  SetLength(Temp, SizeOfTBcd);
  Marshal.Copy(P1, Temp, 0, SizeOfTBcd);
  B1 := TBcd.FromBytes(Temp);
  Marshal.Copy(P2, Temp, 0, SizeOfTBcd);
  B2 := TBcd.FromBytes(Temp);
{$ENDIF}
  Result := BcdCompare(B1, B2);
end;

class function TcxFMTBcdValueType.GetVarType: Integer;
begin
  Result := VarFMTBcd;
end;

class function TcxFMTBcdValueType.GetDataSize: Integer;
begin
  Result := {$IFNDEF CLR}SizeOf(TBcd){$ELSE}SizeOfTBCD{$ENDIF};
end;

class function TcxFMTBcdValueType.GetDataValue(PBuffer: PChar): Variant;
{$IFDEF CLR}
var
  Temp: TBytes;
{$ENDIF}
begin
{$IFNDEF CLR}
  Result := VarFMTBcdCreate(PBcd(PBuffer)^);
//  Result := BcdToDouble(PBcd(PBuffer)^);
{$ELSE}
  SetLength(Temp, SizeOfTBcd);
  Marshal.Copy(PBuffer, Temp, 0, SizeOfTBcd);
  Result := VarFMTBcdCreate(TBcd.FromBytes(Temp));
{$ENDIF}
end;

class function TcxFMTBcdValueType.GetDefaultDisplayText(PBuffer: PChar): string;
var
  Bcd: TBcd;
{$IFDEF CLR}
  Temp: TBytes;
{$ENDIF}
begin
{$IFNDEF CLR}
  Bcd := PBcd(PBuffer)^;
{$ELSE}
  SetLength(Temp, SizeOfTBcd);
  Marshal.Copy(PBuffer, Temp, 0, SizeOfTBcd);
  Bcd := TBcd.FromBytes(Temp);
{$ENDIF}
  Result := BcdToStrF(Bcd, ffGeneral, 0, 0); // P, D - ignored in BcdToStrF 
end;

class procedure TcxFMTBcdValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
{$IFDEF CLR}
var
  Temp: TBytes;
{$ENDIF}
begin
{$IFNDEF CLR}
  PBcd(PBuffer)^ := VarToBcd(Value);
{$ELSE}
  Temp := TBcd.ToBytes(Value);
  Marshal.Copy(Temp, 0, PBuffer, Length(Temp));
{$ENDIF}
end;

{ TcxSQLTimeStampValueType }

class function TcxSQLTimeStampValueType.CompareValues(P1, P2: Pointer): Integer;
var
  T1, T2: TSQLTimeStamp;
{$IFDEF CLR}
  Temp: TBytes;
{$ENDIF}
begin
{$IFNDEF CLR}
  T1 := PSQLTimeStamp(P1)^;
  T2 := PSQLTimeStamp(P2)^;
{$ELSE}
  SetLength(Temp, SizeOf(TSQLTimeStamp));
  Marshal.Copy(P1, Temp, 0, SizeOf(TSQLTimeStamp));
  T1 := TSQLTimeStamp.FromBytes(Temp);
  Marshal.Copy(P2, Temp, 0, SizeOf(TSQLTimeStamp));
  T2 := TSQLTimeStamp.FromBytes(Temp);
{$ENDIF}
  Result := T1.Year - T2.Year;
  if Result = 0 then
  begin
    Result := T1.Month - T2.Month;
    if Result = 0 then
    begin
      Result := T1.Day - T2.Day;
      if Result = 0 then
      begin
        Result := T1.Hour - T2.Hour;
        if Result = 0 then
        begin
          Result := T1.Minute - T2.Minute;
          if Result = 0 then
          begin
            Result := T1.Second - T2.Second;
            if Result = 0 then
              Result := T1.Fractions - T2.Fractions;
          end;
        end;
      end;
    end;
  end;
end;

class function TcxSQLTimeStampValueType.GetVarType: Integer;
begin
  Result := VarSQLTimeStamp;
end;

class function TcxSQLTimeStampValueType.GetDataSize: Integer;
begin
  Result := SizeOf(TSQLTimeStamp);
end;

class function TcxSQLTimeStampValueType.GetDataValue(PBuffer: PChar): Variant;
{$IFDEF CLR}
var
  Temp: TBytes;
{$ENDIF}
begin
{$IFNDEF CLR}
  Result := SQLTimeStampToDateTime(PSQLTimeStamp(PBuffer)^);
{$ELSE}
  SetLength(Temp, SizeOf(TSQLTimeStamp));
  Marshal.Copy(PBuffer, Temp, 0, SizeOf(TSQLTimeStamp));
  Result := VarSQLTimeStampCreate(TSQLTimeStamp.FromBytes(Temp));
{$ENDIF}
end;

class procedure TcxSQLTimeStampValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
{$IFDEF CLR}
var
  Temp: TBytes;
{$ENDIF}
begin
{$IFNDEF CLR}
  PSQLTimeStamp(PBuffer)^ := VarToSQLTimeStamp(Value);
{$ELSE}
  Temp := TSQLTimeStamp.ToBytes(Value);
  Marshal.Copy(Temp, 0, PBuffer, Length(Temp));
{$ENDIF}
end;
{$ENDIF}
{$ENDIF}

{ TcxVariantValueType }

class function TcxVariantValueType.CompareValues(P1, P2: Pointer): Integer;
{$IFDEF CLR}
var
  V1, V2: Variant;
{$ENDIF}
begin
  if Assigned(P1) then
  begin
    if Assigned(P2) then
    begin
    {$IFNDEF CLR}
      Result := VarCompare(PVariant(P1)^, PVariant(P2)^);
    {$ELSE}
      V1 := TVariantValue(FObjectHashtable[TObject(Marshal.ReadInt32(P1))]).V;
      V2 := TVariantValue(FObjectHashtable[TObject(Marshal.ReadInt32(P2))]).V;
      Result := VarCompare(V1, V2);
    {$ENDIF}
    end
    else
      Result := 1;
  end
  else
  begin
    if Assigned(P2) then
      Result := -1
    else
      Result := 0;
  end;
end;

class function TcxVariantValueType.GetValue(PBuffer: PChar): Variant;
begin
{$IFNDEF CLR}
  Result := GetDataValue(@PBuffer);
{$ELSE}
  Result := inherited GetValue(PBuffer);
{$ENDIF}
end;

class procedure TcxVariantValueType.PrepareValueBuffer(var PBuffer: PChar);
begin
{$IFNDEF CLR}
  PBuffer := PPointer(PBuffer)^;
{$ELSE}
  // inherited;
{$ENDIF}
end;

class function TcxVariantValueType.Compare(P1, P2: Pointer): Integer;
begin
{$IFNDEF CLR}
  Result := CompareValues(PPointer(P1)^, PPointer(P2)^);
{$ELSE}
  Result := inherited Compare(P1, P2);
{$ENDIF}
end;

class procedure TcxVariantValueType.FreeBuffer(PBuffer: PChar);
{$IFDEF CLR}
var
  I: Integer;
  O: TObject;
{$ENDIF}
begin
{$IFNDEF CLR}
  Dispose(PVariant(PPointer(PBuffer)^));
{$ELSE}
  I := Marshal.ReadInt32(PBuffer);
  O := FObjectHashtable[TObject(I)];
  FObjectHashtable.Remove(TObject(I));
  O.Free;
{$ENDIF}
end;

class function TcxVariantValueType.GetDataSize: Integer;
begin
{$IFNDEF CLR}
  Result := SizeOf(PVariant);
{$ELSE}
  Result := SizeOf(Integer); // hashcode
{$ENDIF}
end;

class function TcxVariantValueType.GetDataValue(PBuffer: PChar): Variant;
begin
{$IFNDEF CLR}
  Result := PVariant(PPointer(PBuffer)^)^;
{$ELSE}
  Result := TVariantValue(FObjectHashtable[TObject(Marshal.ReadInt32(PBuffer))]).V;
{$ENDIF}
end;

class procedure TcxVariantValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
var
{$IFNDEF CLR}
  P: PVariant;
{$ELSE}
  I: Integer;
  VV: TVariantValue;
{$ENDIF}
begin
{$IFNDEF CLR}
  P := PPointer(PBuffer)^;
  if P = nil then
  begin
    New(P);
    PPointer(PBuffer)^ := P;
  end;
  P^ := Value;
{$ELSE}
  I := Marshal.ReadInt32(PBuffer);
  if I <> 0 then
    VV := TVariantValue(FObjectHashtable[TObject(I)])
  else
  begin
    VV := TVariantValue.Create;
    I := VV.GetHashCode;
    FObjectHashtable.Add(TObject(I), VV);
    Marshal.WriteInt32(PBuffer, I);
  end;
  VV.V := Value;
{$ENDIF}
end;

{ TcxObjectValueType }

class procedure TcxObjectValueType.FreeBuffer(PBuffer: PChar);
{$IFDEF CLR}
var
  I: Integer;
  O: TObject;
{$ENDIF}
begin
{$IFNDEF CLR}
  TObject(PPointer(PBuffer)^).Free;
{$ELSE}
  I := Marshal.ReadInt32(PBuffer);
  if I <> 0 then
  begin
    O := FObjectHashtable[TObject(I)];
    FObjectHashtable.Remove(TObject(I));
    O.Free;
  end;
{$ENDIF}
end;

{$IFDEF CLR}
class function TcxObjectValueType.GetDataValue(PBuffer: PChar): Variant;
var
  I: Integer;
begin
  Result := nil;
  I := Marshal.ReadInt32(PBuffer);
  if I <> 0 then
    Result := Variant(FObjectHashtable[TObject(I{=i})]);
end;
{$ENDIF}

class procedure TcxObjectValueType.ReadDataValue(PBuffer: PChar; AStream: TStream);
begin
  // not supported
end;

class procedure TcxObjectValueType.SetDataValue(PBuffer: PChar; const Value: Variant);
{$IFDEF CLR}
var
  I: Integer;
{$ENDIF}
begin
  // TODO: if PInteger(PBuffer)^ <> 0 then FreeBuffer(PBuffer);
{$IFNDEF CLR}
  inherited SetDataValue(PBuffer, Value);
{$ELSE}
  // remove old ref
  I := Marshal.ReadInt32(PBuffer);
  if I <> 0 then
    FObjectHashtable.Remove(TObject(I));
  // set new ref
  if Value <> nil then
  begin
    I := Value.GetHashCode;
    FObjectHashtable.Add(TObject(I), Value);
  end
  else
    I := 0;
  Marshal.WriteInt32(PBuffer, I);  // = inherited SetDataValue(PBuffer, I);
{$ENDIF}
end;

class procedure TcxObjectValueType.WriteDataValue(PBuffer: PChar; AStream: TStream);
begin
  // not supported
end;

{ TcxValueDef }

constructor TcxValueDef.Create(AValueDefs: TcxValueDefs; AValueTypeClass: TcxValueTypeClass);
begin
  inherited Create;
  FValueDefs := AValueDefs;
  FValueTypeClass := AValueTypeClass;
  FStored := True;
  FTextStored := False;
  FStreamStored := True;
end;

destructor TcxValueDef.Destroy;
begin
  FValueDefs.Remove(Self);
  inherited Destroy;
end;

procedure TcxValueDef.Assign(ASource: TcxValueDef);
begin
  Stored := ASource.Stored;
  TextStored := ASource.TextStored;
end;

function TcxValueDef.CompareValues(AIsNull1, AIsNull2: Boolean; P1, P2: PChar): Integer;
begin
  if AIsNull1 then
  begin
    if AIsNull2 then
      Result := 0
    else
      Result := -1
  end
  else
  begin
    if AIsNull2 then
      Result := 1
    else
      Result := ValueTypeClass.CompareValues(P1, P2);
  end;
end;

procedure TcxValueDef.Changed(AResyncNeeded: Boolean);
begin
  if Assigned(ValueDefs) then
    ValueDefs.Changed(Self, AResyncNeeded);
end;

function TcxValueDef.Compare(P1, P2: PChar): Integer;
begin
  if IsNullValueEx(P1, Offset) then
  begin
    if IsNullValueEx(P2, Offset) then
      Result := 0
    else
      Result := -1
  end
  else
  begin
    if IsNullValueEx(P2, Offset) then
      Result := 1
    else
      Result := ValueTypeClass.Compare(IncPChar(P1, Offset + ValueFlagSize),
        IncPChar(P2, Offset + ValueFlagSize));
  end;
end;

procedure TcxValueDef.FreeBuffer(PBuffer: PChar);
var
  PCurrent: PChar;
begin
  if not Stored then Exit;
  PCurrent := IncPChar(PBuffer, Offset);
  if not IsNullValue(PCurrent) then
    ValueTypeClass.FreeBuffer(IncPChar(PCurrent, ValueFlagSize));
  if TextStored then
    FreeTextBuffer(IncPChar(PCurrent, ValueFlagSize + DataSize));
end;

procedure TcxValueDef.FreeTextBuffer(PBuffer: PChar);
begin
  TcxValueType.FreeTextBuffer(PBuffer);
end;

function TcxValueDef.GetDataValue(PBuffer: PChar): Variant;
begin
  if IsNullValue(IncPChar(PBuffer, Offset)) then
    Result := Null
  else
    Result := ValueTypeClass.GetDataValue(IncPChar(PBuffer, Offset + ValueFlagSize));
end;

function TcxValueDef.GetDisplayText(PBuffer: PChar): string;
begin
  if TextStored then
    Result := ValueTypeClass.GetDisplayText(
      IncPChar(PBuffer, Offset + ValueFlagSize + DataSize))
  else
  begin
    if IsNullValue(IncPChar(PBuffer, Offset)) then
      Result := ''
    else
      Result := ValueTypeClass.GetDefaultDisplayText(
        IncPChar(PBuffer, Offset + ValueFlagSize));
  end;
end;

function TcxValueDef.GetLinkObject: TObject;
begin
  Result := FLinkObject;
end;

function TcxValueDef.GetStored: Boolean;
begin
  Result := FStored or not ValueDefs.DataStorage.StoredValuesOnly;
end;

procedure TcxValueDef.Init(var AOffset: Integer);
begin
  FDataSize := ValueTypeClass.GetDataSize;
  FOffset := AOffset;
  if Stored then
  begin
    Inc(AOffset, ValueFlagSize);
    Inc(AOffset, DataSize);
    if TextStored then
      Inc(AOffset, PointerSize);
    FBufferSize := AOffset - FOffset;
  end
  else
    FBufferSize := 0;
end;

function TcxValueDef.IsNullValue(PBuffer: PChar): Boolean;
begin
{$IFNDEF CLR}
  Result := PByte(PBuffer)^ = 0;
{$ELSE}
  Result := Marshal.ReadByte(PBuffer) = 0;
{$ENDIF}
end;

function TcxValueDef.IsNullValueEx(PBuffer: PChar; AOffset: Integer): Boolean;
begin
  Result := (PBuffer = nil) or IsNullValue(IncPChar(PBuffer, AOffset));
end;

procedure TcxValueDef.ReadDataValue(PBuffer: PChar; AStream: TStream);

  function ReadNullFlag: Boolean;
  begin
    Result := ReadBooleanFunc(AStream);
  end;

begin
  if ReadNullFlag then
    SetNull(IncPChar(PBuffer, Offset), True)
  else
  begin
    SetNull(IncPChar(PBuffer, Offset), False);
    ValueTypeClass.ReadDataValue(
      IncPChar(PBuffer, Offset + ValueFlagSize), AStream);
  end;                                               
end;

procedure TcxValueDef.ReadDisplayText(PBuffer: PChar; AStream: TStream);
begin
  if TextStored then
    ValueTypeClass.ReadDisplayText(IncPChar(PBuffer, Offset + ValueFlagSize + DataSize), AStream);
end;

procedure TcxValueDef.SetDataValue(PBuffer: PChar; const Value: Variant);
begin
  if VarIsNull(Value) then
    SetNull(IncPChar(PBuffer, Offset), True)
  else
  begin
    SetNull(IncPChar(PBuffer, Offset), False);
    ValueTypeClass.SetDataValue(IncPChar(PBuffer, Offset + ValueFlagSize), Value);
  end;
end;

procedure TcxValueDef.SetDisplayText(PBuffer: PChar; const DisplayText: string);
begin
  if TextStored then
    ValueTypeClass.SetDisplayText(
      IncPChar(PBuffer, Offset + ValueFlagSize + DataSize), DisplayText);
end;

procedure TcxValueDef.SetLinkObject(Value: TObject);
begin
  FLinkObject := Value;
end;

procedure TcxValueDef.SetNull(PBuffer: PChar; IsNull: Boolean);
{$IFDEF CLR}
var
  I: Integer;
  P: PChar;
{$ENDIF}
begin
  if IsNull then
  begin
    if not IsNullValue(PBuffer) then
    begin
      ValueTypeClass.FreeBuffer(IncPChar(PBuffer, ValueFlagSize));
      {$IFNDEF CLR}
      FillChar((PBuffer + ValueFlagSize)^, DataSize, 0);
      {$ELSE}
      P := IncPChar(PBuffer, ValueFlagSize);
      for I := 0 to DataSize - 1 do
        Marshal.WriteByte(P, I, 0);
      {$ENDIF}
    end;
  {$IFNDEF CLR}
    PByte(PBuffer)^ := 0 // see also IsNullValue
  {$ELSE}
    Marshal.WriteByte(PBuffer, 0);
  {$ENDIF}
  end
  else
  {$IFNDEF CLR}
    PByte(PBuffer)^ := 1;
  {$ELSE}
    Marshal.WriteByte(PBuffer, 1);
  {$ENDIF}
end;

procedure TcxValueDef.WriteDataValue(PBuffer: PChar; AStream: TStream);

  procedure WriteNullFlag(ANull: Boolean);
  begin
    WriteBooleanProc(AStream, ANull);
  end;

begin
  if IsNullValue(IncPChar(PBuffer, Offset)) then
    WriteNullFlag(True)
  else
  begin
    WriteNullFlag(False);
    ValueTypeClass.WriteDataValue(
      IncPChar(PBuffer, Offset + ValueFlagSize), AStream);
  end;
end;

procedure TcxValueDef.WriteDisplayText(PBuffer: PChar; AStream: TStream);
begin
  if TextStored then
    ValueTypeClass.WriteDisplayText(
      IncPChar(PBuffer, Offset + ValueFlagSize + DataSize), AStream);
end;

function TcxValueDef.GetIsNeedConversion: Boolean;
begin
  Result := ValueTypeClass.IsString;
end;

function TcxValueDef.GetTextStored: Boolean;
begin
  if not Stored then
    Result := False
  else
    Result := FTextStored;
end;

procedure TcxValueDef.SetStored(Value: Boolean);
begin
  if FStored <> Value then
  begin
    FStored := Value;
    Changed(False);
  end;
end;

procedure TcxValueDef.SetTextStored(Value: Boolean);
begin
  if FTextStored <> Value then
  begin
    FTextStored := Value;
    Changed(True);
  end;
end;

procedure TcxValueDef.SetValueTypeClass(Value: TcxValueTypeClass);
begin
  if FValueTypeClass <> Value then
  begin
    FValueTypeClass := Value; // TODO: clear?
    Changed(True);
  end;
end;

{ TcxValueDefs }

constructor TcxValueDefs.Create(ADataStorage: TcxDataStorage);
begin
  inherited Create;
  FDataStorage := ADataStorage;
  FItems := TList.Create;
  DataStorage.InitStructure(Self);
end;

destructor TcxValueDefs.Destroy;
begin
  Clear;
  FItems.Free;
  inherited Destroy;
end;

function TcxValueDefs.Add(AValueTypeClass: TcxValueTypeClass; AStored, ATextStored: Boolean; ALinkObject: TObject): TcxValueDef;
var
  I: Integer;
begin
  Result := GetValueDefClass.Create(Self, AValueTypeClass);
  Result.LinkObject := ALinkObject;
  Result.Stored := AStored;
  Result.TextStored := ATextStored;
  I := 0;
  Result.Init(I);
  DataStorage.InsertValueDef(FItems.Count, Result);
  FItems.Add(Result);
  DataStorage.InitStructure(Self);
end;

procedure TcxValueDefs.Clear;
begin
  while FItems.Count > 0 do
    TcxValueDef(FItems.Last).Free;
end;

procedure TcxValueDefs.Changed(AValueDef: TcxValueDef; AResyncNeeded: Boolean);
begin
  DataStorage.ValueDefsChanged(AValueDef, AResyncNeeded);
end;

function TcxValueDefs.GetValueDefClass: TcxValueDefClass;
begin
  Result := TcxValueDef;
end;

procedure TcxValueDefs.Prepare(AStartOffset: Integer);
var
  I, AOffset: Integer;
begin
  FRecordOffset := AStartOffset;
  AOffset := FRecordOffset;
  for I := 0 to Count - 1 do
    Items[I].Init(AOffset);
  FRecordSize := AOffset;
end;

procedure TcxValueDefs.Remove(AItem: TcxValueDef);
begin
  DataStorage.RemoveValueDef(AItem);
  FItems.Remove(AItem);
  DataStorage.InitStructure(Self);
end;

function TcxValueDefs.GetStoredCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if Items[I].Stored then
      Inc(Result);
end;

function TcxValueDefs.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxValueDefs.GetItem(Index: Integer): TcxValueDef;
begin
  if DataStorage.FValueDefsList <> nil then
    Result := TcxValueDef(DataStorage.FValueDefsList[Index])
  else
    Result := TcxValueDef(FItems[Index]);
end;

{ TcxInternalValueDef }

function TcxInternalValueDef.GetLinkObject: TObject;
begin
  if Assigned(FLinkObject) then
    Result := TcxValueDef(FLinkObject).LinkObject
  else
    Result := nil;
end;

function TcxInternalValueDef.GetStored: Boolean;
begin
  Result := True;
end;

function TcxInternalValueDef.GetValueDef: TcxValueDef;
begin
  Result := TcxValueDef(FLinkObject);
end;

{ TcxInternalValueDefs }

function TcxInternalValueDefs.FindByLinkObject(ALinkObject: TObject): TcxValueDef;
var
  I: Integer;
begin
  Result := nil;
  for I := Count - 1 downto 0 do
    if Items[I].FLinkObject = ALinkObject then
    begin
      Result := Items[I] as TcxValueDef;
      Break;
    end;
end;

procedure TcxInternalValueDefs.RemoveByLinkObject(ALinkObject: TObject);
var
  AItem: TcxValueDef;
begin
  AItem := FindByLinkObject(ALinkObject);
  if AItem <> nil then
    AItem.Free;
end;

function TcxInternalValueDefs.GetValueDefClass: TcxValueDefClass;
begin
  Result := TcxInternalValueDef;
end;

{ TcxValueDefReader }

constructor TcxValueDefReader.Create;
begin
  inherited Create;
end;

function TcxValueDefReader.GetDisplayText(AValueDef: TcxValueDef): string;
begin
  Result := '';
end;

function TcxValueDefReader.GetValue(AValueDef: TcxValueDef): Variant;
begin
  Result := Null;
end;

function TcxValueDefReader.IsInternal(AValueDef: TcxValueDef): Boolean;
begin
  Result := False;
end;

{ TcxDataStorage }

constructor TcxDataStorage.Create;
begin
  inherited Create;
  FRecordIDCounter := 1; // TODO: reset
  FInternalValueDefs := TcxInternalValueDefs.Create(Self);
  FValueDefs := TcxValueDefs.Create(Self);
  FInternalRecordBuffers := TList.Create;
  FRecordBuffers := TList.Create;
end;

destructor TcxDataStorage.Destroy;
begin
{$IFDEF CLR}
  BeforeDestruction;
{$ENDIF}
  Clear(False);
  FValueDefs.Free;
  FInternalValueDefs.Free;
  FRecordBuffers.Free;
  FInternalRecordBuffers.Free;
  inherited Destroy;
end;

function TcxDataStorage.AddInternalRecord: Integer;
var
  I: Integer;
  P: PChar;
begin
  Result := 0;
  for I := -1 downto -FInternalRecordBuffers.Count do
  begin
    if not IsRecordFlag(RecordBuffers[I], RecordFlag_Busy) then
    begin
      Result := I;
      Break;
    end;
  end;
  if Result = 0 then
    Result := -FInternalRecordBuffers.Add({$IFDEF CLR}IntPtr(nil){$ELSE}nil{$ENDIF}) - 1;
  P := AllocRecordBuffer(Result);
  ChangeRecordFlag(P, RecordFlag_Busy, True);
end;

function TcxDataStorage.AppendRecord: Integer;
begin
  Result := FRecordBuffers.Add({$IFDEF CLR}IntPtr(nil){$ELSE}nil{$ENDIF});
  CheckRecordID(Result);
end;

procedure TcxDataStorage.BeforeDestruction;
begin
  FDestroying := True;
{$IFNDEF CLR}
  inherited BeforeDestruction;
{$ENDIF}
end;

procedure TcxDataStorage.BeginLoad;
begin
  CheckStructure;
end;

procedure TcxDataStorage.CheckStructure;
begin
(*
  if FValueDefsChanged then
  begin
    InitStructure(ValueDefs);
    // !
    ClearInternalRecords;
    InitStructure(InternalValueDefs);
    // !
    FValueDefsChanged := False;
  end;
  *)
end;

procedure TcxDataStorage.Clear(AWithoutInternal: Boolean);
begin
  if not AWithoutInternal then
    ClearInternalRecords;
  ClearRecords(True);
end;

procedure TcxDataStorage.ClearInternalRecords;
var
  I: Integer;
begin
  for I := -FInternalRecordBuffers.Count to -1 do
    FreeAndNilRecordBuffer(I);
  FInternalRecordBuffers.Clear;
  if Assigned(FOnClearInternalRecords) then
    FOnClearInternalRecords(Self);
end;

procedure TcxDataStorage.ClearRecords(AClearList: Boolean);
var
  I: Integer;
begin
  for I := 0 to FRecordBuffers.Count - 1 do
    FreeAndNilRecordBuffer(I);
  if AClearList then                                      
    FRecordBuffers.Clear;
  CheckRecordIDCounter;  
  CheckRecordID(-1); // all   
end;

function TcxDataStorage.CompareRecords(ARecordIndex1, ARecordIndex2: Integer;
  AValueDef: TcxValueDef): Integer;
var
  P1, P2: PChar;
begin
  P1 := RecordBuffers[ARecordIndex1];
  P2 := RecordBuffers[ARecordIndex2];
  Result := AValueDef.Compare(P1, P2);
end;

procedure TcxDataStorage.DeleteRecord(ARecordIndex: Integer);
begin
  if ARecordIndex < 0 then
    DeleteInternalRecord(ARecordIndex)
  else
  begin
    FreeAndNilRecordBuffer(ARecordIndex);
    FRecordBuffers.Delete(ARecordIndex);
    CheckRecordIDCounter;
  end;
end;

procedure TcxDataStorage.EndLoad;
begin
end;

function TcxDataStorage.GetDisplayText(ARecordIndex: Integer; AValueDef: TcxValueDef): string;
var
  P: PChar;
begin
  Result := '';
  P := RecordBuffers[ARecordIndex];
  if (P <> nil) and CheckValueDef(ARecordIndex, AValueDef) then
    Result := AValueDef.GetDisplayText(P);
end;

function TcxDataStorage.GetCompareInfo(ARecordIndex: Integer; AValueDef: TcxValueDef;
  var P: PChar): Boolean;
begin
  P := RecordBuffers[ARecordIndex];
  IncPChar(P, AValueDef.Offset);
  Result := AValueDef.IsNullValue(P);
  if not Result then
  begin
    IncPChar(P, ValueFlagSize);
    AValueDef.ValueTypeClass.PrepareValueBuffer(P);
  end;
end;

function TcxDataStorage.GetRecordID(ARecordIndex: Integer): Integer;
var
  P: PChar;
begin
  P := AllocRecordBuffer(ARecordIndex);
  P := IncPChar(P, RecordFlagSize);
{$IFNDEF CLR}
  Result := PInteger(P)^;
{$ELSE}
  // TODO: check
  Result := Marshal.ReadInt32(P);
{$ENDIF}
end;

function TcxDataStorage.GetValue(ARecordIndex: Integer; AValueDef: TcxValueDef): Variant;
var
  P: PChar;
begin
  Result := Null;
  P := RecordBuffers[ARecordIndex];
  if (P <> nil) and CheckValueDef(ARecordIndex, AValueDef) then
    Result := AValueDef.GetDataValue(P);
end;

procedure TcxDataStorage.InsertRecord(ARecordIndex: Integer);
begin
  FRecordBuffers.Insert(ARecordIndex, {$IFDEF CLR}IntPtr(nil){$ELSE}nil{$ENDIF});
  CheckRecordID(ARecordIndex);
end;

procedure TcxDataStorage.ReadData(ARecordIndex: Integer; AStream: TStream);

  function ReadNilFlag: Boolean;
  begin
    Result := ReadBooleanFunc(AStream);
  end;

var
  P: PChar;
  I, AID: Integer;
  AValueDef: TcxValueDef;
begin
  if ReadNilFlag then
    FreeAndNilRecordBuffer(ARecordIndex)
  else
  begin
    P := AllocRecordBuffer(ARecordIndex);
    if UseRecordID then
    begin
      AID := ReadIntegerFunc(AStream);
      SetRecordID(ARecordIndex, AID);
      CheckRecordIDCounterAfterLoad(AID);
    end;  
    for I := 0 to ValueDefs.Count - 1 do
    begin
      AValueDef := ValueDefs[I];
      if AValueDef.StreamStored then
      begin
        AValueDef.ReadDataValue(P, AStream);
        if AValueDef.TextStored then
          AValueDef.ReadDisplayText(P, AStream);
      end;
    end;
  end;
end;

procedure TcxDataStorage.ReadRecord(ARecordIndex: Integer; AValueDefReader: TcxValueDefReader);
var
  P: PChar;
  I: Integer;
  AValueDef: TcxValueDef;
  AValueDefs: TcxValueDefs;
begin
  P := AllocRecordBuffer(ARecordIndex);
  AValueDefs := ValueDefsByRecordIndex(ARecordIndex);
  for I := 0 to AValueDefs.Count - 1 do
  begin
    AValueDef := AValueDefs[I];
    if not AValueDefReader.IsInternal(AValueDef) then
    begin
      AValueDef.SetDataValue(P, AValueDefReader.GetValue(AValueDef));
      if AValueDef.TextStored then
        AValueDef.SetDisplayText(P, AValueDefReader.GetDisplayText(AValueDef));
    end;
  end;
end;

procedure TcxDataStorage.ReadRecordFrom(AFromRecordIndex, AToRecordIndex: Integer;
  AValueDefReader: TcxValueDefReader; ASetProc: TcxValueDefSetProc);
var
  I: Integer;
  AValueDefs: TcxValueDefs;
begin
  AValueDefs := ValueDefsByRecordIndex(AFromRecordIndex);
  for I := 0 to AValueDefs.Count - 1 do
    ASetProc(AValueDefs[I], AFromRecordIndex, AToRecordIndex, AValueDefReader);
end;

procedure TcxDataStorage.SetDisplayText(ARecordIndex: Integer; AValueDef: TcxValueDef;
  const Value: string);
var
  P: PChar;
begin
  P := AllocRecordBuffer(ARecordIndex);
  if CheckValueDef(ARecordIndex, AValueDef) and AValueDef.TextStored then
    AValueDef.SetDisplayText(P, Value);
end;

procedure TcxDataStorage.SetRecordID(ARecordIndex, AID: Integer);
var
  P: PChar;
begin
  P := AllocRecordBuffer(ARecordIndex);
  P := IncPChar(P, RecordFlagSize);
{$IFNDEF CLR}
  PInteger(P)^ := AID;
{$ELSE}
  // TODO: check
  Marshal.WriteInt32(P, AID);
{$ENDIF}
end;

procedure TcxDataStorage.SetValue(ARecordIndex: Integer; AValueDef: TcxValueDef;
  const Value: Variant);
var
  P: PChar;
begin
  P := AllocRecordBuffer(ARecordIndex);
  if CheckValueDef(ARecordIndex, AValueDef) then
    AValueDef.SetDataValue(P, Value);
end;

procedure TcxDataStorage.WriteData(ARecordIndex: Integer; AStream: TStream);

  procedure WriteRecordInfo(PBuffer: PChar);
  var
    AID: Integer;
  begin
    WriteBooleanProc(AStream, PBuffer = nil);
    if (PBuffer <> nil) and UseRecordID then
    begin
      AID := 0;
      if PBuffer <> nil then
      begin
        PBuffer := IncPChar(PBuffer, RecordFlagSize);
      {$IFNDEF CLR}
        AID := PInteger(PBuffer)^;
      {$ELSE}
        // TODO: check
        AID := Marshal.ReadInt32(PBuffer);
      {$ENDIF}
      end;
      WriteIntegerProc(AStream, AID);
    end;
  end;

var
  P: PChar;
  I: Integer;
  AValueDef: TcxValueDef;
begin
  P := PChar(FRecordBuffers[ARecordIndex]);
  WriteRecordInfo(P);
  if P <> nil then
    for I := 0 to ValueDefs.Count - 1 do
    begin
      AValueDef := ValueDefs[I];
      if AValueDef.StreamStored then
      begin
        AValueDef.WriteDataValue(P, AStream);
        if AValueDef.TextStored then
          AValueDef.WriteDisplayText(P, AStream);
      end;
    end;
end;

procedure TcxDataStorage.BeginStreaming(ACompare: TListSortCompare);
var
  I: Integer;
  AList: TList;
begin
  AList := TList.Create;
  for I := 0 to ValueDefs.Count - 1 do
    AList.Add(ValueDefs[I]);
  AList.Sort(ACompare);
  FValueDefsList := AList; 
end;

procedure TcxDataStorage.EndStreaming;
begin
  FValueDefsList.Free;
  FValueDefsList := nil;
end;

function TcxDataStorage.AllocRecordBuffer(Index: Integer): PChar;
var
  AValueDefs: TcxValueDefs;
begin
  Result := RecordBuffers[Index];
  if Result = nil then
  begin
    AValueDefs := ValueDefsByRecordIndex(Index);
    Result := AllocMem(AValueDefs.RecordSize);
    RecordBuffers[Index] := Result;
  end;
end;

function TcxDataStorage.CalcRecordOffset: Integer;
begin
  Result := RecordFlagSize;
  if UseRecordID then
    Inc(Result, RecordIDSize);
end;

procedure TcxDataStorage.ChangeRecordFlag(PBuffer: PChar; AFlag: Byte; ATurnOn: Boolean);
begin
  if PBuffer <> nil then
    if ATurnOn then
    {$IFNDEF CLR}
      PByte(PBuffer)^ := PByte(PBuffer)^ or AFlag
    {$ELSE}
      Marshal.WriteByte(PBuffer, Marshal.ReadByte(PBuffer) or AFlag)
    {$ENDIF}
    else
    {$IFNDEF CLR}
      PByte(PBuffer)^ := PByte(PBuffer)^ and not AFlag;
    {$ELSE}
      Marshal.WriteByte(PBuffer, Marshal.ReadByte(PBuffer) and not AFlag);
    {$ENDIF}
end;

procedure TcxDataStorage.CheckRecordID(ARecordIndex: Integer);

  procedure CheckID(AIndex: Integer);
  begin
    if GetRecordID(AIndex) = 0 then
    begin
      SetRecordID(AIndex, FRecordIDCounter);
      Inc(FRecordIDCounter);
    end;
  end;

var
  I: Integer;  
begin
  if not UseRecordID then Exit;
  if ARecordIndex <> -1 then
    CheckID(ARecordIndex)
  else
    for I := 0 to RecordCount - 1 do
      CheckID(I);
end;

procedure TcxDataStorage.CheckRecordIDCounter;
begin
  if FRecordBuffers.Count = 0 then FRecordIDCounter := 1; // TODO: reset
end;

procedure TcxDataStorage.CheckRecordIDCounterAfterLoad(ALoadedID: Integer);
begin
  if FRecordIDCounter <= ALoadedID then
    FRecordIDCounter := ALoadedID + 1;
end;

function TcxDataStorage.CheckValueDef(ARecordIndex: Integer; var AValueDef: TcxValueDef): Boolean;
begin
  if not (AValueDef is TcxInternalValueDef) and
    (ValueDefsByRecordIndex(ARecordIndex) = InternalValueDefs) then
    AValueDef := InternalValueDefs.FindByLinkObject(AValueDef);
  Result := AValueDef <> nil;
end;

procedure TcxDataStorage.DeleteInternalRecord(ARecordIndex: Integer);
//var
//  P: PChar;
begin
  if ARecordIndex >= 0 then Exit;
//  P := RecordBuffers[ARecordIndex];
//  ChangeRecordFlag(P, RecordFlag_Busy, False);
  FreeAndNilRecordBuffer(ARecordIndex);
end;

procedure TcxDataStorage.FreeAndNilRecordBuffer(AIndex: Integer);
var
  P: PChar;
  I: Integer;
  AValueDefs: TcxValueDefs;
begin
  P := RecordBuffers[AIndex];
  if P <> nil then
  begin
    AValueDefs := ValueDefsByRecordIndex(AIndex);
    RecordBuffers[AIndex] := nil;
    for I := 0 to AValueDefs.Count - 1 do
      AValueDefs[I].FreeBuffer(P);
  {$IFNDEF CLR}
    FreeMem(P);
  {$ELSE}
    Marshal.FreeHGlobal(P);
  {$ENDIF}
  end;
end;

procedure TcxDataStorage.InitStructure(AValueDefs: TcxValueDefs);
begin
  AValueDefs.Prepare(CalcRecordOffset);
end;

procedure TcxDataStorage.InsertValueDef(AIndex: Integer; AValueDef: TcxValueDef);
var
  I, AStartIndex, AEndIndex: Integer;
  PBuffer, PSource, PDest: PChar;
  AValueDefs: TcxValueDefs;
  {$IFDEF CLR}
  Temp: TBytes;
  L, J: Integer;
  {$ENDIF}
begin
  AValueDefs := AValueDef.ValueDefs;
  if AValueDefs = ValueDefs then
  begin
    InternalValueDefs.Add(AValueDef.ValueTypeClass, True, AValueDef.FTextStored, AValueDef);
    AStartIndex := 0;
    AEndIndex := FRecordBuffers.Count - 1;
  end
  else
  begin
    AStartIndex := -FInternalRecordBuffers.Count;
    AEndIndex := -1;
  end;
  for I := AStartIndex to AEndIndex do
  begin
    PBuffer := RecordBuffers[I];
    if PBuffer <> nil then
    begin
    {$IFNDEF CLR}
      ReallocMem(PBuffer, AValueDefs.RecordSize + AValueDef.BufferSize);
    {$ELSE}
      ReallocMem(PBuffer, IntPtr(AValueDefs.RecordSize + AValueDef.BufferSize));
    {$ENDIF}
      RecordBuffers[I] := PBuffer;
      if AIndex < AValueDefs.Count then
      begin
        PSource := IncPChar(PBuffer, AValueDefs[AIndex].Offset);
        PDest := IncPChar(PSource, AValueDef.BufferSize);
      {$IFNDEF CLR}
        System.Move(PSource^, PDest^, AValueDefs.RecordSize - (PSource - PBuffer));
      {$ELSE}
        L := AValueDefs.RecordSize - (Integer(PSource) - Integer(PBuffer));
        SetLength(Temp, L);
        Marshal.Copy(PSource, Temp, 0, L);
        Marshal.Copy(Temp, 0, PDest, L);
      {$ENDIF}
      end
      else
      begin
        PSource := PBuffer;
        if AValueDefs.Count > 0 then
          PSource := IncPChar(PSource, AValueDefs[AValueDefs.Count - 1].Offset +
            AValueDefs[AValueDefs.Count - 1].BufferSize)
        else
          PSource := IncPChar(PSource, AValueDefs.RecordSize);
      end;
    {$IFNDEF CLR}
      FillChar(PSource^, AValueDef.BufferSize, 0);
    {$ELSE}
      for J := 0 to AValueDef.BufferSize - 1 do
        Marshal.WriteByte(PSource, J, 0);
    {$ENDIF}
    end;
  end;
end;

function TcxDataStorage.IsRecordFlag(PBuffer: PChar; AFlag: Byte): Boolean;
begin
{$IFNDEF CLR}
  Result := (PBuffer <> nil) and ((PByte(PBuffer)^ and AFlag) = AFlag);
{$ELSE}
  Result := (PBuffer <> nil) and ((Marshal.ReadByte(PBuffer) and AFlag) = AFlag);
{$ENDIF}
end;

procedure TcxDataStorage.RemoveValueDef(AValueDef: TcxValueDef);
var
  I, AStartIndex, AEndIndex: Integer;
  PBuffer, PSource, PDest: PChar;
  AValueDefs: TcxValueDefs;
  AFreeAndNil: Boolean;
  {$IFDEF CLR}
  Temp: TBytes;
  L: Integer;
  {$ENDIF}
begin
  AValueDefs := AValueDef.ValueDefs;
  if AValueDefs = ValueDefs then
  begin
    InternalValueDefs.RemoveByLinkObject(AValueDef);
    AStartIndex := 0;
    AEndIndex := FRecordBuffers.Count - 1;
  end
  else
  begin
    AStartIndex := -FInternalRecordBuffers.Count;
    AEndIndex := -1;
  end;
  AFreeAndNil := AValueDef.Stored and (AValueDefs.StoredCount <= 1);
  for I := AStartIndex to AEndIndex do
  begin
    PBuffer := RecordBuffers[I];
    if PBuffer <> nil then
      if AFreeAndNil then
        FreeAndNilRecordBuffer(I)
      else
        if AValueDef.Stored then
        begin
          AValueDef.FreeBuffer(PBuffer);
          PDest := IncPChar(PBuffer, AValueDef.Offset);
          PSource := IncPChar(PDest, AValueDef.BufferSize);
        {$IFNDEF CLR}
          System.Move(PSource^, PDest^, AValueDefs.RecordSize - (PSource - PBuffer));
          ReallocMem(PBuffer, AValueDefs.RecordSize - AValueDef.BufferSize); // existing data in the block is not affected!
        {$ELSE}
          L := AValueDefs.RecordSize - (Integer(PSource) - Integer(PBuffer));
          SetLength(Temp, L);
          Marshal.Copy(PSource, Temp, 0, L);
          Marshal.Copy(Temp, 0, PDest, L);
          ReallocMem(PBuffer, IntPtr(AValueDefs.RecordSize - AValueDef.BufferSize));
        {$ENDIF}
          RecordBuffers[I] := PBuffer;
        end;
  end;
end;

procedure TcxDataStorage.ValueDefsChanged(AValueDef: TcxValueDef; AResyncNeeded: Boolean);
//var
//  AInternalValueDef: TcxValueDef;
begin
  (*
  if FDestroying then Exit;
  if not FValueDefsChanged then
  begin
    ClearRecords(False);
    FValueDefsChanged := True;
    if AResyncNeeded and (AValueDef.ValueDefs = ValueDefs) then
    begin
      AInternalValueDef := InternalValueDefs.FindByLinkObject(AValueDef);
      if AInternalValueDef <> nil then
        AInternalValueDef.Assign(AValueDef);
    end;
  end;
  *)
end;

function TcxDataStorage.ValueDefsByRecordIndex(Index: Integer): TcxValueDefs;
begin
  if Index < 0 then
    Result := FInternalValueDefs
  else
    Result := FValueDefs;
end;

function TcxDataStorage.GetRecordBuffer(Index: Integer): PChar;
begin
  if Index >= 0 then
    Result := PChar(FRecordBuffers[Index])
  else
    Result := PChar(FInternalRecordBuffers[-Index - 1]);
end;

function TcxDataStorage.GetRecordCount: Integer;
begin
  Result := FRecordBuffers.Count;
end;

procedure TcxDataStorage.SetStoredValuesOnly(Value: Boolean);
begin
  if FStoredValuesOnly <> Value then
  begin
    ClearRecords(False);
    FStoredValuesOnly := Value;
    InitStructure(ValueDefs);
  end;
end;

procedure TcxDataStorage.SetRecordBuffer(Index: Integer; Value: PChar);
begin
  if Index >= 0 then
    FRecordBuffers[Index] := Value
  else
    FInternalRecordBuffers[-Index - 1] := Value;
end;

procedure TcxDataStorage.SetRecordCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if RecordCount <> Value then
  begin
    // TODO: Capacity
    while RecordCount < Value do
      AppendRecord;
    while RecordCount > Value do
      DeleteRecord(RecordCount - 1);
  end;
end;

procedure TcxDataStorage.SetUseRecordID(Value: Boolean);
begin
  if FUseRecordID <> Value then
  begin
    ClearRecords(False);
    FUseRecordID := Value;
    InitStructure(ValueDefs);
  end;
end;

{ TcxLookupList }

constructor TcxLookupList.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

destructor TcxLookupList.Destroy;
begin
  Clear;
  FItems.Free;
  inherited Destroy;
end;

procedure TcxLookupList.Clear;
var
  I: Integer;
begin
{$IFNDEF CLR}
  for I := 0 to FItems.Count - 1 do
    Dispose(PcxLookupListItem(FItems[I]));
{$ELSE}
  for I := 0 to FItems.Count - 1 do
    PcxLookupListItem(FItems[I]).Free;
{$ENDIF}
  FItems.Clear;
end;

function TcxLookupList.Find(const AKeyValue: Variant; var AIndex: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  AIndex := 0;
  Result := False;
  L := 0;
  H := FItems.Count - 1;
  if L <= H then
    repeat
      I := (L + H) div 2;
      C := VarCompare(PcxLookupListItem(FItems[I]).KeyValue, AKeyValue);
      if C = 0 then
      begin
        AIndex := I;
        Result := True;
        Break;
      end
      else
        if C < 0 then
          L := I + 1
        else
          H := I - 1;
      if L > H then
      begin
        AIndex := L;
        Break;
      end;
    until False;
end;

procedure TcxLookupList.Insert(AIndex: Integer; const AKeyValue: Variant;
  const ADisplayText: string);
var
  P: PcxLookupListItem;
begin
{$IFNDEF CLR}
  New(P);
{$ELSE}
  P := PcxLookupListItem.Create; 
{$ENDIF}
  P.KeyValue := AKeyValue;
  P.DisplayText := ADisplayText;
  FItems.Insert(AIndex, P);
end;

function TcxLookupList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxLookupList.GetItem(Index: Integer): PcxLookupListItem;
begin
  Result := PcxLookupListItem(FItems[Index]);
end;

{ TcxValueTypeClassList }

constructor TcxValueTypeClassList.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

destructor TcxValueTypeClassList.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TcxValueTypeClassList.ItemByCaption(const ACaption: string): TcxValueTypeClass;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FItems.Count - 1 do
    if TcxValueTypeClass(FItems[I]).Caption = ACaption then
    begin
      Result := TcxValueTypeClass(FItems[I]);
      Break;
    end;
end;

procedure TcxValueTypeClassList.RegisterItem(AValueTypeClass: TcxValueTypeClass);
begin
  if FItems.IndexOf(TObject(AValueTypeClass)) = -1 then
    FItems.Add(TObject(AValueTypeClass));
end;

procedure TcxValueTypeClassList.UnregisterItem(AValueTypeClass: TcxValueTypeClass);
begin
  FItems.Remove(TObject(AValueTypeClass));
end;

function TcxValueTypeClassList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxValueTypeClassList.GetItem(Index: Integer): TcxValueTypeClass;
begin
  Result := TcxValueTypeClass(FItems[Index]);
end;

initialization
{$IFDEF CLR}
  FObjectHashtable := Hashtable.Create;
{$ENDIF}
  cxValueTypeClassList.RegisterItem(TcxStringValueType);
  cxValueTypeClassList.RegisterItem(TcxWideStringValueType);
  cxValueTypeClassList.RegisterItem(TcxSmallintValueType);
  cxValueTypeClassList.RegisterItem(TcxIntegerValueType);
  cxValueTypeClassList.RegisterItem(TcxWordValueType);
  cxValueTypeClassList.RegisterItem(TcxBooleanValueType);
  cxValueTypeClassList.RegisterItem(TcxFloatValueType);
  cxValueTypeClassList.RegisterItem(TcxCurrencyValueType);
  cxValueTypeClassList.RegisterItem(TcxDateTimeValueType);
  {$IFDEF DELPHI6}
  cxValueTypeClassList.RegisterItem(TcxLargeIntValueType);
    {$IFNDEF NONDB}
  cxValueTypeClassList.RegisterItem(TcxFMTBcdValueType);
  cxValueTypeClassList.RegisterItem(TcxSQLTimeStampValueType);
    {$ENDIF}
  {$ENDIF}
  cxValueTypeClassList.RegisterItem(TcxVariantValueType);
  cxValueTypeClassList.RegisterItem(TcxObjectValueType);

finalization
  cxValueTypeClassList.UnregisterItem(TcxObjectValueType);
  cxValueTypeClassList.UnregisterItem(TcxVariantValueType);
  {$IFDEF DELPHI6}
    {$IFNDEF NONDB}
  cxValueTypeClassList.UnregisterItem(TcxSQLTimeStampValueType);
  cxValueTypeClassList.UnregisterItem(TcxFMTBcdValueType);
    {$ENDIF}
  cxValueTypeClassList.UnregisterItem(TcxLargeIntValueType);
  {$ENDIF}
  cxValueTypeClassList.UnregisterItem(TcxDateTimeValueType);
  cxValueTypeClassList.UnregisterItem(TcxCurrencyValueType);
  cxValueTypeClassList.UnregisterItem(TcxFloatValueType);
  cxValueTypeClassList.UnregisterItem(TcxBooleanValueType);
  cxValueTypeClassList.UnregisterItem(TcxWordValueType);
  cxValueTypeClassList.UnregisterItem(TcxIntegerValueType);
  cxValueTypeClassList.UnregisterItem(TcxSmallintValueType);
  cxValueTypeClassList.UnregisterItem(TcxWideStringValueType);
  cxValueTypeClassList.UnregisterItem(TcxStringValueType);

  FValueTypeClassList.Free;
  FValueTypeClassList := nil;

end.
