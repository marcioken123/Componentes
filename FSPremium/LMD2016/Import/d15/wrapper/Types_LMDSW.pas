unit Types_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Types' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, Classes, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers;


{ Type wrappers }

type

  TPoint_sw = class(TLMDRecordWrapper)
  private
    FValue: TPoint;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPoint): OleVariant;
    class function FromVar(const AValue: OleVariant): TPoint;
  end;

  tagPOINT_sw = TPoint_sw;

  TRect_sw = class(TLMDRecordWrapper)
  private
    FValue: TRect;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TRect): OleVariant;
    class function FromVar(const AValue: OleVariant): TRect;
  end;

  tagSIZE_sw = class(TLMDRecordWrapper)
  private
    FValue: tagSIZE;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: tagSIZE): OleVariant;
    class function FromVar(const AValue: OleVariant): tagSIZE;
  end;

  TSize_sw = tagSIZE_sw;

  SIZE_sw = tagSIZE_sw;

  TSmallPoint_sw = class(TLMDRecordWrapper)
  private
    FValue: TSmallPoint;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TSmallPoint): OleVariant;
    class function FromVar(const AValue: OleVariant): TSmallPoint;
  end;

  DWORD_sw = LongWord_sw;

  TSplitRectType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSplitRectType): OleVariant;
    class function FromVar(const AValue: OleVariant): TSplitRectType;
  end;

  TValueRelationship_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TValueRelationship): OleVariant;
    class function FromVar(const AValue: OleVariant): TValueRelationship;
  end;


{ Unit wrapper }

type
  Types_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TPoint_sw }

function TPoint_X_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var X: Longint;

  if IsGet then
    Result := TPoint_sw(AObj).FValue.X
  else
    TPoint_sw(AObj).FValue.X := Longint(AArgs[0]);
end;

function TPoint_Y_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Y: Longint;

  if IsGet then
    Result := TPoint_sw(AObj).FValue.Y
  else
    TPoint_sw(AObj).FValue.Y := Longint(AArgs[0]);
end;

function TPoint_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TPoint_sw.Create as IDispatch;
end;

function TPoint_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Copy: TPoint;

  // Implicit record copy method.
  Result := TPoint_sw.ToVar(TPoint(AObj));
end;

class function TPoint_sw.GetTypeName: WideString;
begin
  Result := 'TPoint';
end;

function TPoint_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPoint_sw.Create;
  TPoint_sw(Result).FValue := FValue;
end;

class procedure TPoint_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('X', TPoint_X_si, Longint_sw);
  AData.AddField('Y', TPoint_Y_si, Longint_sw);
  AData.AddFunction('Copy', TPoint_Copy_si, TPoint_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPoint_Create_si, 0, False);
end;

class function TPoint_sw.ToVar(const AValue: TPoint): OleVariant;
var
  wrpr: TPoint_sw;
begin
  wrpr        := TPoint_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPoint_sw.FromVar(const AValue: OleVariant): TPoint;
begin
  Result := TPoint_sw(ConvFromVar(AValue)).FValue;
end;

{ TRect_sw }

function TRect_Left_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Left: Longint;

  if IsGet then
    Result := TRect_sw(AObj).FValue.Left
  else
    TRect_sw(AObj).FValue.Left := Longint(AArgs[0]);
end;

function TRect_Top_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Top: Longint;

  if IsGet then
    Result := TRect_sw(AObj).FValue.Top
  else
    TRect_sw(AObj).FValue.Top := Longint(AArgs[0]);
end;

function TRect_Right_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Right: Longint;

  if IsGet then
    Result := TRect_sw(AObj).FValue.Right
  else
    TRect_sw(AObj).FValue.Right := Longint(AArgs[0]);
end;

function TRect_Bottom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Bottom: Longint;

  if IsGet then
    Result := TRect_sw(AObj).FValue.Bottom
  else
    TRect_sw(AObj).FValue.Bottom := Longint(AArgs[0]);
end;

function TRect_TopLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TopLeft: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(TRect_sw(AObj).FValue.TopLeft)
  else
    TRect_sw(AObj).FValue.TopLeft := TPoint_sw.FromVar(AArgs[0]);
end;

function TRect_BottomRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BottomRight: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(TRect_sw(AObj).FValue.BottomRight)
  else
    TRect_sw(AObj).FValue.BottomRight := TPoint_sw.FromVar(AArgs[0]);
end;

function TRect_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TRect_sw.Create as IDispatch;
end;

function TRect_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Copy: TRect;

  // Implicit record copy method.
  Result := TRect_sw.ToVar(TRect(AObj));
end;

class function TRect_sw.GetTypeName: WideString;
begin
  Result := 'TRect';
end;

function TRect_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TRect_sw.Create;
  TRect_sw(Result).FValue := FValue;
end;

class procedure TRect_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Left', TRect_Left_si, Longint_sw);
  AData.AddField('Top', TRect_Top_si, Longint_sw);
  AData.AddField('Right', TRect_Right_si, Longint_sw);
  AData.AddField('Bottom', TRect_Bottom_si, Longint_sw);
  AData.AddField('TopLeft', TRect_TopLeft_si, TPoint_sw);
  AData.AddField('BottomRight', TRect_BottomRight_si, TPoint_sw);
  AData.AddFunction('Copy', TRect_Copy_si, TRect_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TRect_Create_si, 0, False);
end;

class function TRect_sw.ToVar(const AValue: TRect): OleVariant;
var
  wrpr: TRect_sw;
begin
  wrpr        := TRect_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TRect_sw.FromVar(const AValue: OleVariant): TRect;
begin
  Result := TRect_sw(ConvFromVar(AValue)).FValue;
end;

{ tagSIZE_sw }

function tagSIZE_cx_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var cx: Longint;

  if IsGet then
    Result := tagSIZE_sw(AObj).FValue.cx
  else
    tagSIZE_sw(AObj).FValue.cx := Longint(AArgs[0]);
end;

function tagSIZE_cy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var cy: Longint;

  if IsGet then
    Result := tagSIZE_sw(AObj).FValue.cy
  else
    tagSIZE_sw(AObj).FValue.cy := Longint(AArgs[0]);
end;

function tagSIZE_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := tagSIZE_sw.Create as IDispatch;
end;

function tagSIZE_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: tagSIZE;

  // Implicit record copy method.
  Result := tagSIZE_sw.ToVar(tagSIZE(AObj));
end;

class function tagSIZE_sw.GetTypeName: WideString;
begin
  Result := 'tagSIZE';
end;

function tagSIZE_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := tagSIZE_sw.Create;
  tagSIZE_sw(Result).FValue := FValue;
end;

class procedure tagSIZE_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('cx', tagSIZE_cx_si, Longint_sw);
  AData.AddField('cy', tagSIZE_cy_si, Longint_sw);
  AData.AddFunction('Copy', tagSIZE_Copy_si, tagSIZE_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', tagSIZE_Create_si, 0, False);
end;

class function tagSIZE_sw.ToVar(const AValue: tagSIZE): OleVariant;
var
  wrpr: tagSIZE_sw;
begin
  wrpr        := tagSIZE_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function tagSIZE_sw.FromVar(const AValue: OleVariant): tagSIZE;
begin
  Result := tagSIZE_sw(ConvFromVar(AValue)).FValue;
end;

{ TSmallPoint_sw }

function TSmallPoint_x_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var x: SmallInt;

  if IsGet then
    Result := TSmallPoint_sw(AObj).FValue.x
  else
    TSmallPoint_sw(AObj).FValue.x := SmallInt(AArgs[0]);
end;

function TSmallPoint_y_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var y: SmallInt;

  if IsGet then
    Result := TSmallPoint_sw(AObj).FValue.y
  else
    TSmallPoint_sw(AObj).FValue.y := SmallInt(AArgs[0]);
end;

function TSmallPoint_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TSmallPoint_sw.Create as IDispatch;
end;

function TSmallPoint_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TSmallPoint;

  // Implicit record copy method.
  Result := TSmallPoint_sw.ToVar(TSmallPoint(AObj));
end;

class function TSmallPoint_sw.GetTypeName: WideString;
begin
  Result := 'TSmallPoint';
end;

function TSmallPoint_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TSmallPoint_sw.Create;
  TSmallPoint_sw(Result).FValue := FValue;
end;

class procedure TSmallPoint_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('x', TSmallPoint_x_si, SmallInt_sw);
  AData.AddField('y', TSmallPoint_y_si, SmallInt_sw);
  AData.AddFunction('Copy', TSmallPoint_Copy_si, TSmallPoint_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TSmallPoint_Create_si, 0, False);
end;

class function TSmallPoint_sw.ToVar(const AValue: TSmallPoint): OleVariant;
var
  wrpr: TSmallPoint_sw;
begin
  wrpr        := TSmallPoint_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TSmallPoint_sw.FromVar(const AValue: OleVariant): TSmallPoint;
begin
  Result := TSmallPoint_sw(ConvFromVar(AValue)).FValue;
end;

{ TSplitRectType_sw }

class function TSplitRectType_sw.GetTypeName: WideString;
begin
  Result := 'TSplitRectType';
end;

class procedure TSplitRectType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'srLeft'; Value: Integer({$IFDEF LMDSCT_12}TSplitRectType.{$ENDIF}srLeft)),
    (Name: 'srRight'; Value: Integer({$IFDEF LMDSCT_12}TSplitRectType.{$ENDIF}srRight)),
    (Name: 'srTop'; Value: Integer({$IFDEF LMDSCT_12}TSplitRectType.{$ENDIF}srTop)),
    (Name: 'srBottom'; Value: Integer({$IFDEF LMDSCT_12}TSplitRectType.{$ENDIF}srBottom))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TSplitRectType_sw.ToVar(
  const AValue: TSplitRectType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSplitRectType_sw.FromVar(
  const AValue: OleVariant): TSplitRectType;
begin
  Result := TSplitRectType(Integer(AValue));
end;

{ TValueRelationship_sw }

class function TValueRelationship_sw.GetTypeName: WideString;
begin
  Result := 'TValueRelationship';
end;

class function TValueRelationship_sw.ToVar(
  const AValue: TValueRelationship): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TValueRelationship_sw.FromVar(
  const AValue: OleVariant): TValueRelationship;
begin
  Result := TValueRelationship(Integer(AValue));
end;

{ Types_sw }

function Types_TPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPoint = record;

  Result := TLMDUnitWrapper.TypeToVar(TPoint_sw);
end;

function Types_tagPOINT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagPOINT = TPoint;

  Result := TLMDUnitWrapper.TypeToVar(tagPOINT_sw);
end;

function Types_TRect_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TRect = record;

  Result := TLMDUnitWrapper.TypeToVar(TRect_sw);
end;

function Types_tagSIZE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagSIZE = record;

  Result := TLMDUnitWrapper.TypeToVar(tagSIZE_sw);
end;

function Types_TSize_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TSize = tagSIZE;

  Result := TLMDUnitWrapper.TypeToVar(TSize_sw);
end;

function Types_SIZE_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type SIZE = tagSIZE;

  Result := TLMDUnitWrapper.TypeToVar(SIZE_sw);
end;

function Types_TSmallPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSmallPoint = record;

  Result := TLMDUnitWrapper.TypeToVar(TSmallPoint_sw);
end;

function Types_DWORD_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type DWORD = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(DWORD_sw);
end;

function Types_TSplitRectType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSplitRectType = (srLeft, srRight, srTop, srBottom);

  Result := TLMDUnitWrapper.TypeToVar(TSplitRectType_sw);
end;

function Types_EqualRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function EqualRect(const R1: TRect; const R2: TRect): Boo...

  Result := Types.EqualRect(TRect_sw.FromVar(AArgs[0]), TRect_sw.FromVar(
    AArgs[1]));
end;

function Types_Rect_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Rect(Left: Integer; Top: Integer; Right: Integer...

  Result := TRect_sw.ToVar(Types.Rect(Integer(AArgs[0]), Integer(AArgs[1]), 
    Integer(AArgs[2]), Integer(AArgs[3])));
end;

function Types_Bounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Bounds(ALeft: Integer; ATop: Integer; AWidth: In...

  Result := TRect_sw.ToVar(Types.Bounds(Integer(AArgs[0]), Integer(AArgs[1]), 
    Integer(AArgs[2]), Integer(AArgs[3])));
end;

function Types_Point_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Point(X: Integer; Y: Integer): TPoint;

  Result := TPoint_sw.ToVar(Types.Point(Integer(AArgs[0]), Integer(AArgs[1])));
end;

function Types_PtInRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function PtInRect(const Rect: TRect; const P: TPoint): Bo...

  Result := Types.PtInRect(TRect_sw.FromVar(AArgs[0]), TPoint_sw.FromVar(
    AArgs[1]));
end;

function Types_PtInCircle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function PtInCircle(const Point: TPoint; const Center: TP...

  Result := Types.PtInCircle(TPoint_sw.FromVar(AArgs[0]), TPoint_sw.FromVar(
    AArgs[1]), Integer(AArgs[2]));
end;

function Types_IntersectRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // function IntersectRect(out Rect: TRect; const R1: TRect; ...

  Result := Types.IntersectRect(v_1, TRect_sw.FromVar(AArgs[1]), TRect_sw.
    FromVar(AArgs[2]));
  AssignRefParam(AArgs[0], TRect_sw.ToVar(v_1));
end;

function Types_UnionRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // function UnionRect(out Rect: TRect; const R1: TRect; cons...

  Result := Types.UnionRect(v_1, TRect_sw.FromVar(AArgs[1]), TRect_sw.FromVar(
    AArgs[2]));
  AssignRefParam(AArgs[0], TRect_sw.ToVar(v_1));
end;

function Types_IsRectEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsRectEmpty(const Rect: TRect): Boolean;

  Result := Types.IsRectEmpty(TRect_sw.FromVar(AArgs[0]));
end;

function Types_OffsetRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // function OffsetRect(var Rect: TRect; DX: Integer; DY: Int...

  v_1 := TRect_sw.FromVar(AArgs[0]);
  Result := Types.OffsetRect(v_1, Integer(AArgs[1]), Integer(AArgs[2]));
  AssignRefParam(AArgs[0], TRect_sw.ToVar(v_1));
end;

function Types_CenterPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CenterPoint(const Rect: TRect): TPoint;

  Result := TPoint_sw.ToVar(Types.CenterPoint(TRect_sw.FromVar(AArgs[0])));
end;

function Types_RectWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RectWidth(const Rect: TRect): Integer;

  Result := Types.RectWidth(TRect_sw.FromVar(AArgs[0]));
end;

function Types_RectHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RectHeight(const Rect: TRect): Integer;

  Result := Types.RectHeight(TRect_sw.FromVar(AArgs[0]));
end;

function Types_CenteredRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CenteredRect(const SourceRect: TRect; const Cent...

  Result := TRect_sw.ToVar(Types.CenteredRect(TRect_sw.FromVar(AArgs[0]), 
    TRect_sw.FromVar(AArgs[1])));
end;

function Types_TValueRelationship_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TValueRelationship = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TValueRelationship_sw);
end;

function Types_LessThanValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const LessThanValue = <value>;

  Result := LessThanValue;
end;

function Types_EqualsValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EqualsValue = <value>;

  Result := EqualsValue;
end;

function Types_GreaterThanValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GreaterThanValue = <value>;

  Result := GreaterThanValue;
end;

class function Types_sw.GetUnitName: WideString;
begin
  Result := 'Types';
end;

class procedure Types_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TPoint_sw, Types_TPoint_si);
  AData.AddType(tagPOINT_sw, Types_tagPOINT_si);
  AData.AddType(TRect_sw, Types_TRect_si);
  AData.AddType(tagSIZE_sw, Types_tagSIZE_si);
  AData.AddType(TSize_sw, Types_TSize_si);
  AData.AddType(SIZE_sw, Types_SIZE_si);
  AData.AddType(TSmallPoint_sw, Types_TSmallPoint_si);
  AData.AddType(DWORD_sw, Types_DWORD_si);
  AData.AddType(TSplitRectType_sw, Types_TSplitRectType_si);
  AData.AddFunction('EqualRect', Types_EqualRect_si, Boolean_sw, 2, False);
  AData.AddFunction('Rect', Types_Rect_si, TRect_sw, 4, False);
  AData.AddFunction('Bounds', Types_Bounds_si, TRect_sw, 4, False);
  AData.AddFunction('Point', Types_Point_si, TPoint_sw, 2, False);
  AData.AddFunction('PtInRect', Types_PtInRect_si, Boolean_sw, 2, False);
  AData.AddFunction('PtInCircle', Types_PtInCircle_si, Boolean_sw, 3, False);
  AData.AddFunction('IntersectRect', Types_IntersectRect_si, Boolean_sw, 3, False);
  AData.AddFunction('UnionRect', Types_UnionRect_si, Boolean_sw, 3, False);
  AData.AddFunction('IsRectEmpty', Types_IsRectEmpty_si, Boolean_sw, 1, False);
  AData.AddFunction('OffsetRect', Types_OffsetRect_si, Boolean_sw, 3, False);
  AData.AddFunction('CenterPoint', Types_CenterPoint_si, TPoint_sw, 1, False);
  AData.AddFunction('RectWidth', Types_RectWidth_si, Integer_sw, 1, False);
  AData.AddFunction('RectHeight', Types_RectHeight_si, Integer_sw, 1, False);
  AData.AddFunction('CenteredRect', Types_CenteredRect_si, TRect_sw, 2, False);
  AData.AddType(TValueRelationship_sw, Types_TValueRelationship_si);
  AData.AddConstant('LessThanValue', Types_LessThanValue_si, Integer_sw);
  AData.AddConstant('EqualsValue', Types_EqualsValue_si, nil, VarType(Types.EqualsValue));
  AData.AddConstant('GreaterThanValue', Types_GreaterThanValue_si, Integer_sw);
end;

class function Types_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Types_sw);
end;

initialization
  RegisterUnitWrapper(Types_sw);

end.
