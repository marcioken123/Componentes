unit WideStrings_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'WideStrings' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Classes, SysUtils, WideStrings, Classes_LMDSW,
  SysUtils_LMDSW;


{ Type wrappers }

type
  TWideStringsEnumerator_sw = class;
  TWideStrings_sw = class;
  TWideStringList_sw = class;

  TWideStringsEnumerator_sc = class of TWideStringsEnumerator;
  TWideStringsEnumerator_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWideStringsEnumerator): OleVariant;
    class function FromVar(const AValue: OleVariant): TWideStringsEnumerator;
    class function ClassToVar(AClass: TWideStringsEnumerator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWideStringsEnumerator_sc;
  end;

  TWideStrings_sc = class of TWideStrings;
  TWideStrings_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWideStrings): OleVariant;
    class function FromVar(const AValue: OleVariant): TWideStrings;
    class function ClassToVar(AClass: TWideStrings_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWideStrings_sc;
  end;

  TWideStringItem_sw = class(TLMDRecordWrapper)
  private
    FValue: TWideStringItem;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TWideStringItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TWideStringItem;
  end;

  TWideStringList_sc = class of TWideStringList;
  TWideStringList_sw = class(TWideStrings_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWideStringList): OleVariant;
    class function FromVar(const AValue: OleVariant): TWideStringList;
    class function ClassToVar(AClass: TWideStringList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWideStringList_sc;
  end;


{ Unit wrapper }

type
  WideStrings_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TWideStrings_sacc = class(TWideStrings);

{ TWideStringsEnumerator_sw }

function TWideStringsEnumerator_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AStrings: TWideStrings);

  Result := TWideStringsEnumerator_sw.ToVar(TWideStringsEnumerator_sc(AObj).
    Create(TWideStrings_sw.FromVar(AArgs[0])));
end;

function TWideStringsEnumerator_GetCurrent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCurrent: WideString;

  Result := TWideStringsEnumerator(AObj).GetCurrent();
end;

function TWideStringsEnumerator_MoveNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MoveNext: Boolean;

  Result := TWideStringsEnumerator(AObj).MoveNext();
end;

function TWideStringsEnumerator_Current_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Current: WideString read <getter>;

  Result := TWideStringsEnumerator(AObj).Current;
end;

class function TWideStringsEnumerator_sw.GetTypeName: WideString;
begin
  Result := 'TWideStringsEnumerator';
end;

class function TWideStringsEnumerator_sw.GetWrappedClass: TClass;
begin
  Result := TWideStringsEnumerator;
end;

class procedure TWideStringsEnumerator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetCurrent', TWideStringsEnumerator_GetCurrent_si, WideString_sw, 0, False);
  AData.AddFunction('MoveNext', TWideStringsEnumerator_MoveNext_si, Boolean_sw, 0, False);
  AData.AddProperty('Current', TWideStringsEnumerator_Current_si, WideString_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TWideStringsEnumerator_Create_si, 1, False);
end;

class function TWideStringsEnumerator_sw.ToVar(
  const AValue: TWideStringsEnumerator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWideStringsEnumerator_sw.FromVar(
  const AValue: OleVariant): TWideStringsEnumerator;
begin
  Result := TWideStringsEnumerator(ConvFromVar(AValue, TWideStringsEnumerator));
end;

class function TWideStringsEnumerator_sw.ClassToVar(
  AClass: TWideStringsEnumerator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWideStringsEnumerator_sw.ClassFromVar(
  const AClass: OleVariant): TWideStringsEnumerator_sc;
begin
  Result := TWideStringsEnumerator_sc(ConvClsFromVar(AClass, 
    TWideStringsEnumerator));
end;

{ TWideStrings_sw }

function TWideStrings_UpdateCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property UpdateCount: Integer read <getter>;

  Result := TWideStrings_sacc(TWideStrings(AObj)).UpdateCount;
end;

function TWideStrings_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add(const S: WideString): Integer;

  Result := TWideStrings(AObj).Add(WideString(AArgs[0]));
end;

function TWideStrings_AddObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddObject(const S: WideString; AObject: TObject)...

  Result := TWideStrings(AObj).AddObject(WideString(AArgs[0]), TObject_sw.
    FromVar(AArgs[1]));
end;

function TWideStrings_Append_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Append(const S: WideString);

  TWideStrings(AObj).Append(WideString(AArgs[0]));
end;

function TWideStrings_BeginUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginUpdate;

  TWideStrings(AObj).BeginUpdate();
end;

function TWideStrings_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TWideStrings(AObj).Clear();
end;

function TWideStrings_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete(Index: Integer);

  TWideStrings(AObj).Delete(Integer(AArgs[0]));
end;

function TWideStrings_EndUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndUpdate;

  TWideStrings(AObj).EndUpdate();
end;

function TWideStrings_Equals_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Equals(Strings: TWideStrings): Boolean;

  Result := TWideStrings(AObj).Equals(TWideStrings_sw.FromVar(AArgs[0]));
end;

function TWideStrings_Exchange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Exchange(Index1: Integer; Index2: Integer);

  TWideStrings(AObj).Exchange(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TWideStrings_GetEnumerator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetEnumerator: TWideStringsEnumerator;

  Result := TWideStringsEnumerator_sw.ToVar(TWideStrings(AObj).GetEnumerator());
end;

function TWideStrings_IndexOf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOf(const S: WideString): Integer;

  Result := TWideStrings(AObj).IndexOf(WideString(AArgs[0]));
end;

function TWideStrings_IndexOfName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOfName(const Name: WideString): Integer;

  Result := TWideStrings(AObj).IndexOfName(WideString(AArgs[0]));
end;

function TWideStrings_IndexOfObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IndexOfObject(AObject: TObject): Integer;

  Result := TWideStrings(AObj).IndexOfObject(TObject_sw.FromVar(AArgs[0]));
end;

function TWideStrings_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Insert(Index: Integer; const S: WideString);

  TWideStrings(AObj).Insert(Integer(AArgs[0]), WideString(AArgs[1]));
end;

function TWideStrings_InsertObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InsertObject(Index: Integer; const S: WideStrin...

  TWideStrings(AObj).InsertObject(Integer(AArgs[0]), WideString(AArgs[1]), 
    TObject_sw.FromVar(AArgs[2]));
end;

function TWideStrings_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const FileName: WideString);

  TWideStrings(AObj).LoadFromFile(WideString(AArgs[0]));
end;

function TWideStrings_LoadFromStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromStream(Stream: TStream);

  TWideStrings(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]));
end;

function TWideStrings_Move_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Move(CurIndex: Integer; NewIndex: Integer);

  TWideStrings(AObj).Move(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TWideStrings_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToFile(const FileName: WideString);

  TWideStrings(AObj).SaveToFile(WideString(AArgs[0]));
end;

function TWideStrings_SaveToStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToStream(Stream: TStream);

  TWideStrings(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]));
end;

function TWideStrings_Capacity_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Capacity: Integer read <getter> write <setter>;

  if IsGet then
    Result := TWideStrings(AObj).Capacity
  else
    TWideStrings(AObj).Capacity := Integer(AArgs[0]);
end;

function TWideStrings_CommaText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CommaText: WideString read <getter> write <setter>;

  if IsGet then
    Result := TWideStrings(AObj).CommaText
  else
    TWideStrings(AObj).CommaText := WideString(AArgs[0]);
end;

function TWideStrings_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TWideStrings(AObj).Count;
end;

function TWideStrings_Delimiter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Delimiter: WideChar read <getter> write <setter>;

  if IsGet then
    Result := Ord(TWideStrings(AObj).Delimiter)
  else
    TWideStrings(AObj).Delimiter := WideChar(Integer(AArgs[0]));
end;

function TWideStrings_DelimitedText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DelimitedText: WideString read <getter> write <s...

  if IsGet then
    Result := TWideStrings(AObj).DelimitedText
  else
    TWideStrings(AObj).DelimitedText := WideString(AArgs[0]);
end;

function TWideStrings_LineBreak_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LineBreak: WideString read <getter> write <setter>;

  if IsGet then
    Result := TWideStrings(AObj).LineBreak
  else
    TWideStrings(AObj).LineBreak := WideString(AArgs[0]);
end;

function TWideStrings_Names_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Names[Index: Integer]: WideString read <getter>;

  Result := TWideStrings(AObj).Names[Integer(AArgs[0])];
end;

function TWideStrings_Objects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Objects[Index: Integer]: TObject read <getter> w...

  if IsGet then
    Result := TObject_sw.ToVar(TWideStrings(AObj).Objects[Integer(AArgs[0])])
  else
    TWideStrings(AObj).Objects[Integer(AArgs[0])] := TObject_sw.FromVar(
      AArgs[1]);
end;

function TWideStrings_QuoteChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property QuoteChar: WideChar read <getter> write <setter>;

  if IsGet then
    Result := Ord(TWideStrings(AObj).QuoteChar)
  else
    TWideStrings(AObj).QuoteChar := WideChar(Integer(AArgs[0]));
end;

function TWideStrings_Values_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Values[const Name: WideString]: WideString read ...

  if IsGet then
    Result := TWideStrings(AObj).Values[WideString(AArgs[0])]
  else
    TWideStrings(AObj).Values[WideString(AArgs[0])] := WideString(AArgs[1]);
end;

function TWideStrings_ValueFromIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ValueFromIndex[Index: Integer]: WideString read ...

  if IsGet then
    Result := TWideStrings(AObj).ValueFromIndex[Integer(AArgs[0])]
  else
    TWideStrings(AObj).ValueFromIndex[Integer(AArgs[0])] := WideString(
      AArgs[1]);
end;

function TWideStrings_NameValueSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NameValueSeparator: WideChar read <getter> write...

  if IsGet then
    Result := Ord(TWideStrings(AObj).NameValueSeparator)
  else
    TWideStrings(AObj).NameValueSeparator := WideChar(Integer(AArgs[0]));
end;

function TWideStrings_StrictDelimiter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StrictDelimiter: Boolean read <getter> write <se...

  if IsGet then
    Result := TWideStrings(AObj).StrictDelimiter
  else
    TWideStrings(AObj).StrictDelimiter := Boolean(AArgs[0]);
end;

function TWideStrings_Strings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Strings[Index: Integer]: WideString read <getter...

  if IsGet then
    Result := TWideStrings(AObj).Strings[Integer(AArgs[0])]
  else
    TWideStrings(AObj).Strings[Integer(AArgs[0])] := WideString(AArgs[1]);
end;

function TWideStrings_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Text: WideString read <getter> write <setter>;

  if IsGet then
    Result := TWideStrings(AObj).Text
  else
    TWideStrings(AObj).Text := WideString(AArgs[0]);
end;

class function TWideStrings_sw.GetTypeName: WideString;
begin
  Result := 'TWideStrings';
end;

class function TWideStrings_sw.GetWrappedClass: TClass;
begin
  Result := TWideStrings;
end;

class procedure TWideStrings_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('UpdateCount', TWideStrings_UpdateCount_si, Integer_sw, True, False, 0, True, False);
  AData.AddFunction('Add', TWideStrings_Add_si, Integer_sw, 1, False);
  AData.AddFunction('AddObject', TWideStrings_AddObject_si, Integer_sw, 2, False);
  AData.AddProcedure('Append', TWideStrings_Append_si, 1, False);
  AData.AddProcedure('BeginUpdate', TWideStrings_BeginUpdate_si, 0, False);
  AData.AddProcedure('Clear', TWideStrings_Clear_si, 0, False);
  AData.AddProcedure('Delete', TWideStrings_Delete_si, 1, False);
  AData.AddProcedure('EndUpdate', TWideStrings_EndUpdate_si, 0, False);
  AData.AddFunction('Equals', TWideStrings_Equals_si, Boolean_sw, 1, False);
  AData.AddProcedure('Exchange', TWideStrings_Exchange_si, 2, False);
  AData.AddFunction('GetEnumerator', TWideStrings_GetEnumerator_si, TWideStringsEnumerator_sw, 0, False);
  AData.AddFunction('IndexOf', TWideStrings_IndexOf_si, Integer_sw, 1, False);
  AData.AddFunction('IndexOfName', TWideStrings_IndexOfName_si, Integer_sw, 1, False);
  AData.AddFunction('IndexOfObject', TWideStrings_IndexOfObject_si, Integer_sw, 1, False);
  AData.AddProcedure('Insert', TWideStrings_Insert_si, 2, False);
  AData.AddProcedure('InsertObject', TWideStrings_InsertObject_si, 3, False);
  AData.AddProcedure('LoadFromFile', TWideStrings_LoadFromFile_si, 1, False);
  AData.AddProcedure('LoadFromStream', TWideStrings_LoadFromStream_si, 1, False);
  AData.AddProcedure('Move', TWideStrings_Move_si, 2, False);
  AData.AddProcedure('SaveToFile', TWideStrings_SaveToFile_si, 1, False);
  AData.AddProcedure('SaveToStream', TWideStrings_SaveToStream_si, 1, False);
  AData.AddProperty('Capacity', TWideStrings_Capacity_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('CommaText', TWideStrings_CommaText_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('Count', TWideStrings_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Delimiter', TWideStrings_Delimiter_si, WideChar_sw, True, True, 0, False, False);
  AData.AddProperty('DelimitedText', TWideStrings_DelimitedText_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('LineBreak', TWideStrings_LineBreak_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('Names', TWideStrings_Names_si, WideString_sw, True, False, 1, False, False);
  AData.AddProperty('Objects', TWideStrings_Objects_si, TObject_sw, True, True, 1, False, False);
  AData.AddProperty('QuoteChar', TWideStrings_QuoteChar_si, WideChar_sw, True, True, 0, False, False);
  AData.AddProperty('Values', TWideStrings_Values_si, WideString_sw, True, True, 1, False, False);
  AData.AddProperty('ValueFromIndex', TWideStrings_ValueFromIndex_si, WideString_sw, True, True, 1, False, False);
  AData.AddProperty('NameValueSeparator', TWideStrings_NameValueSeparator_si, WideChar_sw, True, True, 0, False, False);
  AData.AddProperty('StrictDelimiter', TWideStrings_StrictDelimiter_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Strings', TWideStrings_Strings_si, WideString_sw, True, True, 1, False, True);
  AData.AddProperty('Text', TWideStrings_Text_si, WideString_sw, True, True, 0, False, False);
end;

class function TWideStrings_sw.ToVar(const AValue: TWideStrings): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWideStrings_sw.FromVar(const AValue: OleVariant): TWideStrings;
begin
  Result := TWideStrings(ConvFromVar(AValue, TWideStrings));
end;

class function TWideStrings_sw.ClassToVar(AClass: TWideStrings_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWideStrings_sw.ClassFromVar(
  const AClass: OleVariant): TWideStrings_sc;
begin
  Result := TWideStrings_sc(ConvClsFromVar(AClass, TWideStrings));
end;

{ TWideStringItem_sw }

function TWideStringItem_FString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FString: WideString;

  if IsGet then
    Result := TWideStringItem_sw(AObj).FValue.FString
  else
    TWideStringItem_sw(AObj).FValue.FString := WideString(AArgs[0]);
end;

function TWideStringItem_FObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FObject: TObject;

  if IsGet then
    Result := TObject_sw.ToVar(TWideStringItem_sw(AObj).FValue.FObject)
  else
    TWideStringItem_sw(AObj).FValue.FObject := TObject_sw.FromVar(AArgs[0]);
end;

function TWideStringItem_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TWideStringItem_sw.Create as IDispatch;
end;

function TWideStringItem_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TWideStringItem;

  // Implicit record copy method.
  Result := TWideStringItem_sw.ToVar(TWideStringItem(AObj));
end;

class function TWideStringItem_sw.GetTypeName: WideString;
begin
  Result := 'TWideStringItem';
end;

function TWideStringItem_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TWideStringItem_sw.Create;
  TWideStringItem_sw(Result).FValue := FValue;
end;

class procedure TWideStringItem_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('FString', TWideStringItem_FString_si, WideString_sw);
  AData.AddField('FObject', TWideStringItem_FObject_si, TObject_sw);
  AData.AddFunction('Copy', TWideStringItem_Copy_si, TWideStringItem_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TWideStringItem_Create_si, 0, False);
end;

class function TWideStringItem_sw.ToVar(
  const AValue: TWideStringItem): OleVariant;
var
  wrpr: TWideStringItem_sw;
begin
  wrpr        := TWideStringItem_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TWideStringItem_sw.FromVar(
  const AValue: OleVariant): TWideStringItem;
begin
  Result := TWideStringItem_sw(ConvFromVar(AValue)).FValue;
end;

{ TWideStringList_sw }

function TWideStringList_Find_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // function Find(const S: WideString; var Index: Integer): B...

  v_1 := Integer(AArgs[1]);
  Result := TWideStringList(AObj).Find(WideString(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function TWideStringList_Sort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Sort;

  TWideStringList(AObj).Sort();
end;

function TWideStringList_Duplicates_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Duplicates: TDuplicates read <getter> write <set...

  if IsGet then
    Result := TDuplicates_sw.ToVar(TWideStringList(AObj).Duplicates)
  else
    TWideStringList(AObj).Duplicates := TDuplicates_sw.FromVar(AArgs[0]);
end;

function TWideStringList_Sorted_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Sorted: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TWideStringList(AObj).Sorted
  else
    TWideStringList(AObj).Sorted := Boolean(AArgs[0]);
end;

function TWideStringList_CaseSensitive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CaseSensitive: Boolean read <getter> write <sett...

  if IsGet then
    Result := TWideStringList(AObj).CaseSensitive
  else
    TWideStringList(AObj).CaseSensitive := Boolean(AArgs[0]);
end;

function TWideStringList_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TWideStringList(AObj).OnChange)
  else
    TWideStringList(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TWideStringList_OnChanging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChanging: TNotifyEvent read <getter> write <se...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TWideStringList(AObj).OnChanging)
  else
    TWideStringList(AObj).OnChanging := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TWideStringList_OwnsObjects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OwnsObjects: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TWideStringList(AObj).OwnsObjects
  else
    TWideStringList(AObj).OwnsObjects := Boolean(AArgs[0]);
end;

class function TWideStringList_sw.GetTypeName: WideString;
begin
  Result := 'TWideStringList';
end;

class function TWideStringList_sw.GetWrappedClass: TClass;
begin
  Result := TWideStringList;
end;

class procedure TWideStringList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Find', TWideStringList_Find_si, Boolean_sw, 2, False);
  AData.AddProcedure('Sort', TWideStringList_Sort_si, 0, False);
  AData.AddProperty('Duplicates', TWideStringList_Duplicates_si, TDuplicates_sw, True, True, 0, False, False);
  AData.AddProperty('Sorted', TWideStringList_Sorted_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('CaseSensitive', TWideStringList_CaseSensitive_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnChange', TWideStringList_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnChanging', TWideStringList_OnChanging_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OwnsObjects', TWideStringList_OwnsObjects_si, Boolean_sw, True, True, 0, False, False);
end;

class function TWideStringList_sw.ToVar(
  const AValue: TWideStringList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWideStringList_sw.FromVar(
  const AValue: OleVariant): TWideStringList;
begin
  Result := TWideStringList(ConvFromVar(AValue, TWideStringList));
end;

class function TWideStringList_sw.ClassToVar(
  AClass: TWideStringList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWideStringList_sw.ClassFromVar(
  const AClass: OleVariant): TWideStringList_sc;
begin
  Result := TWideStringList_sc(ConvClsFromVar(AClass, TWideStringList));
end;

{ WideStrings_sw }

function WideStrings_TWideStringsEnumerator_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWideStringsEnumerator = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TWideStringsEnumerator_sw);
end;

function WideStrings_TWideStrings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWideStrings = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TWideStrings_sw);
end;

function WideStrings_TWideStringItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWideStringItem = record;

  Result := TLMDUnitWrapper.TypeToVar(TWideStringItem_sw);
end;

function WideStrings_TWideStringList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWideStringList = class(TWideStrings);

  Result := TLMDUnitWrapper.TypeToVar(TWideStringList_sw);
end;

class function WideStrings_sw.GetUnitName: WideString;
begin
  Result := 'WideStrings';
end;

class procedure WideStrings_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TWideStringsEnumerator_sw, WideStrings_TWideStringsEnumerator_si);
  AData.AddType(TWideStrings_sw, WideStrings_TWideStrings_si);
  AData.AddType(TWideStringItem_sw, WideStrings_TWideStringItem_si);
  AData.AddType(TWideStringList_sw, WideStrings_TWideStringList_si);
end;

class function WideStrings_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(WideStrings_sw);
end;

initialization
  RegisterUnitWrapper(WideStrings_sw);
  RegisterClassWrapper(TWideStringsEnumerator_sw);
  RegisterClassWrapper(TWideStrings_sw);
  RegisterClassWrapper(TWideStringList_sw);

end.
