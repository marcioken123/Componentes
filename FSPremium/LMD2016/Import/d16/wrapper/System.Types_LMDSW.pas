unit System.Types_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'System.Types' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.Classes, System.SysUtils, System.Variants,
  System.TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers;


{ Type wrappers }

type

  TSize_sw = class(TLMDRecordWrapper)
  private
    FValue: TSize;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TSize): OleVariant;
    class function FromVar(const AValue: OleVariant): TSize;
  end;

  SIZE_sw = TSize_sw;

  tagSize_sw = TSize_sw;

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

  TSplitRectType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSplitRectType): OleVariant;
    class function FromVar(const AValue: OleVariant): TSplitRectType;
  end;

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

  TPointF_sw = class(TLMDRecordWrapper)
  private
    FValue: TPointF;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPointF): OleVariant;
    class function FromVar(const AValue: OleVariant): TPointF;
  end;

  TVector_sw = class(TLMDRecordWrapper)
  private
    FValue: TVector;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVector): OleVariant;
    class function FromVar(const AValue: OleVariant): TVector;
  end;

  TMatrix_sw = class(TLMDRecordWrapper)
  private
    FValue: TMatrix;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TMatrix): OleVariant;
    class function FromVar(const AValue: OleVariant): TMatrix;
  end;

  tagPOINTF_sw = TPointF_sw;

  TSizeF_sw = class(TLMDRecordWrapper)
  private
    FValue: TSizeF;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TSizeF): OleVariant;
    class function FromVar(const AValue: OleVariant): TSizeF;
  end;

  TRectF_sw = class(TLMDRecordWrapper)
  private
    FValue: TRectF;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TRectF): OleVariant;
    class function FromVar(const AValue: OleVariant): TRectF;
  end;

  DWORD_sw = LongWord_sw;

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

{ TSize_sw }

function TSize_cx_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var cx: Longint;

  if IsGet then
    Result := TSize_sw(AObj).FValue.cx
  else
    TSize_sw(AObj).FValue.cx := Longint(AArgs[0]);
end;

function TSize_cy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var cy: Longint;

  if IsGet then
    Result := TSize_sw(AObj).FValue.cy
  else
    TSize_sw(AObj).FValue.cy := Longint(AArgs[0]);
end;

function TSize_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TSize_sw.ToVar(TSize.Create(TSize_sw.FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TSize_sw.ToVar(TSize.Create(Integer(AArgs[0]), Integer(
        AArgs[1])));
    end;
    0:
    begin
      // Implicit parameterless constructor.
      Result := TSize_sw.Create as IDispatch;
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TSize_Add_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Add(const Point: TSize): TSize;

  Result := TSize_sw.ToVar(TSize_sw(AObj).FValue.Add(TSize_sw.FromVar(
    AArgs[0])));
end;

function TSize_Distance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Distance(const P2: TSize): Double;

  Result := TSize_sw(AObj).FValue.Distance(TSize_sw.FromVar(AArgs[0]));
end;

function TSize_IsZero_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsZero: Boolean;

  Result := TSize_sw(AObj).FValue.IsZero();
end;

function TSize_Subtract_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Subtract(const Point: TSize): TSize;

  Result := TSize_sw.ToVar(TSize_sw(AObj).FValue.Subtract(TSize_sw.FromVar(
    AArgs[0])));
end;

function TSize_Width_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := TSize_sw(AObj).FValue.Width
  else
    TSize_sw(AObj).FValue.Width := Integer(AArgs[0]);
end;

function TSize_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter> write <setter>;

  if IsGet then
    Result := TSize_sw(AObj).FValue.Height
  else
    TSize_sw(AObj).FValue.Height := Integer(AArgs[0]);
end;

function TSize_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Copy: TSize;

  // Implicit record copy method.
  Result := TSize_sw.ToVar(TSize(AObj));
end;

class function TSize_sw.GetTypeName: WideString;
begin
  Result := 'TSize';
end;

function TSize_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TSize_sw.Create;
  TSize_sw(Result).FValue := FValue;
end;

class procedure TSize_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('cx', TSize_cx_si, Longint_sw);
  AData.AddField('cy', TSize_cy_si, Longint_sw);
  AData.AddFunction('Add', TSize_Add_si, TSize_sw, 1, False);
  AData.AddFunction('Distance', TSize_Distance_si, Double_sw, 1, False);
  AData.AddFunction('IsZero', TSize_IsZero_si, Boolean_sw, 0, False);
  AData.AddFunction('Subtract', TSize_Subtract_si, TSize_sw, 1, False);
  AData.AddProperty('Width', TSize_Width_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Height', TSize_Height_si, Integer_sw, True, True, 0, False, False);
  AData.AddFunction('Copy', TSize_Copy_si, TSize_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TSize_Create_si, 0, True);
end;

class function TSize_sw.ToVar(const AValue: TSize): OleVariant;
var
  wrpr: TSize_sw;
begin
  wrpr        := TSize_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TSize_sw.FromVar(const AValue: OleVariant): TSize;
begin
  Result := TSize_sw(ConvFromVar(AValue)).FValue;
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
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TSmallPoint_sw.ToVar(TSmallPoint.Create(TSmallPoint_sw.FromVar(
        AArgs[0])));
    end;
    2:
    begin
      Result := TSmallPoint_sw.ToVar(TSmallPoint.Create(SmallInt(AArgs[0]), 
        SmallInt(AArgs[1])));
    end;
    0:
    begin
      // Implicit parameterless constructor.
      Result := TSmallPoint_sw.Create as IDispatch;
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TSmallPoint_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add(const Point: TSmallPoint): TSmallPoint;

  Result := TSmallPoint_sw.ToVar(TSmallPoint_sw(AObj).FValue.Add(TSmallPoint_sw.
    FromVar(AArgs[0])));
end;

function TSmallPoint_Distance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Distance(const P2: TSmallPoint): Double;

  Result := TSmallPoint_sw(AObj).FValue.Distance(TSmallPoint_sw.FromVar(
    AArgs[0]));
end;

function TSmallPoint_IsZero_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsZero: Boolean;

  Result := TSmallPoint_sw(AObj).FValue.IsZero();
end;

function TSmallPoint_Subtract_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Subtract(const Point: TSmallPoint): TSmallPoint;

  Result := TSmallPoint_sw.ToVar(TSmallPoint_sw(AObj).FValue.Subtract(
    TSmallPoint_sw.FromVar(AArgs[0])));
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
  AData.AddFunction('Add', TSmallPoint_Add_si, TSmallPoint_sw, 1, False);
  AData.AddFunction('Distance', TSmallPoint_Distance_si, Double_sw, 1, False);
  AData.AddFunction('IsZero', TSmallPoint_IsZero_si, Boolean_sw, 0, False);
  AData.AddFunction('Subtract', TSmallPoint_Subtract_si, TSmallPoint_sw, 1, False);
  AData.AddFunction('Copy', TSmallPoint_Copy_si, TSmallPoint_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TSmallPoint_Create_si, 0, True);
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
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TPoint_sw.ToVar(TPoint.Create(TPoint_sw.FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TPoint_sw.ToVar(TPoint.Create(Integer(AArgs[0]), Integer(
        AArgs[1])));
    end;
    0:
    begin
      // Implicit parameterless constructor.
      Result := TPoint_sw.Create as IDispatch;
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TPoint_Distance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Distance(const P2: TPoint): Double;

  Result := TPoint_sw(AObj).FValue.Distance(TPoint_sw.FromVar(AArgs[0]));
end;

function TPoint_SetLocation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SetLocation(...); overload;

  case AArgsSize of
    2:
    begin
      TPoint_sw(AObj).FValue.SetLocation(Integer(AArgs[0]), Integer(AArgs[1]));
    end;
    1:
    begin
      TPoint_sw(AObj).FValue.SetLocation(TPoint_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('SetLocation');
  end;
end;

function TPoint_Offset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Offset(...); overload;

  case AArgsSize of
    2:
    begin
      TPoint_sw(AObj).FValue.Offset(Integer(AArgs[0]), Integer(AArgs[1]));
    end;
    1:
    begin
      TPoint_sw(AObj).FValue.Offset(TPoint_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Offset');
  end;
end;

function TPoint_Add_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Add(const Point: TPoint): TPoint;

  Result := TPoint_sw.ToVar(TPoint_sw(AObj).FValue.Add(TPoint_sw.FromVar(
    AArgs[0])));
end;

function TPoint_Subtract_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Subtract(const Point: TPoint): TPoint;

  Result := TPoint_sw.ToVar(TPoint_sw(AObj).FValue.Subtract(TPoint_sw.FromVar(
    AArgs[0])));
end;

function TPoint_IsZero_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsZero: Boolean;

  Result := TPoint_sw(AObj).FValue.IsZero();
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
  AData.AddFunction('Distance', TPoint_Distance_si, Double_sw, 1, False);
  AData.AddProcedure('SetLocation', TPoint_SetLocation_si, 1, True);
  AData.AddProcedure('Offset', TPoint_Offset_si, 1, True);
  AData.AddFunction('Add', TPoint_Add_si, TPoint_sw, 1, False);
  AData.AddFunction('Subtract', TPoint_Subtract_si, TPoint_sw, 1, False);
  AData.AddFunction('IsZero', TPoint_IsZero_si, Boolean_sw, 0, False);
  AData.AddFunction('Copy', TPoint_Copy_si, TPoint_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPoint_Create_si, 0, True);
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

{ TRect_sw }

function TRect_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TRect_sw.ToVar(TRect.Create(TPoint_sw.FromVar(AArgs[0])));
    end;
    3:
    begin
      Result := TRect_sw.ToVar(TRect.Create(TPoint_sw.FromVar(AArgs[0]), 
        Integer(AArgs[1]), Integer(AArgs[2])));
    end;
    4:
    begin
      Result := TRect_sw.ToVar(TRect.Create(Integer(AArgs[0]), Integer(
        AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3])));
    end;
    0:
    begin
      // Implicit parameterless constructor.
      Result := TRect_sw.Create as IDispatch;
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TRect_Empty_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // class function Empty: TRect;

  Result := TRect_sw.ToVar(TRect.Empty());
end;

function TRect_NormalizeRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure NormalizeRect;

  TRect_sw(AObj).FValue.NormalizeRect();
end;

function TRect_IsEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsEmpty: Boolean;

  Result := TRect_sw(AObj).FValue.IsEmpty();
end;

function TRect_Contains_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Contains(...); overload;

  Result := TRect_sw(AObj).FValue.Contains(TPoint_sw.FromVar(AArgs[0]));
end;

function TRect_IntersectsWith_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IntersectsWith(const R: TRect): Boolean;

  Result := TRect_sw(AObj).FValue.IntersectsWith(TRect_sw.FromVar(AArgs[0]));
end;

function TRect_Intersect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Intersect(...); overload;

  TRect_sw(AObj).FValue.Intersect(TRect_sw.FromVar(AArgs[0]));
end;

function TRect_Union_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure/function Union(...); overload;

  TRect_sw(AObj).FValue.Union(TRect_sw.FromVar(AArgs[0]));
end;

function TRect_Offset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Offset(...); overload;

  case AArgsSize of
    2:
    begin
      TRect_sw(AObj).FValue.Offset(Integer(AArgs[0]), Integer(AArgs[1]));
    end;
    1:
    begin
      TRect_sw(AObj).FValue.Offset(TPoint_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Offset');
  end;
end;

function TRect_SetLocation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SetLocation(...); overload;

  case AArgsSize of
    2:
    begin
      TRect_sw(AObj).FValue.SetLocation(Integer(AArgs[0]), Integer(AArgs[1]));
    end;
    1:
    begin
      TRect_sw(AObj).FValue.SetLocation(TPoint_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('SetLocation');
  end;
end;

function TRect_Inflate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Inflate(...); overload;

  case AArgsSize of
    2:
    begin
      TRect_sw(AObj).FValue.Inflate(Integer(AArgs[0]), Integer(AArgs[1]));
    end;
    4:
    begin
      TRect_sw(AObj).FValue.Inflate(Integer(AArgs[0]), Integer(AArgs[1]), 
        Integer(AArgs[2]), Integer(AArgs[3]));
    end;
  else
    WrongArgCountError('Inflate');
  end;
end;

function TRect_CenterPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CenterPoint: TPoint;

  Result := TPoint_sw.ToVar(TRect_sw(AObj).FValue.CenterPoint());
end;

function TRect_SplitRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SplitRect(...); overload;

  Result := TRect_sw.ToVar(TRect_sw(AObj).FValue.SplitRect(TSplitRectType_sw.
    FromVar(AArgs[0]), Integer(AArgs[1])));
end;

function TRect_Width_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := TRect_sw(AObj).FValue.Width
  else
    TRect_sw(AObj).FValue.Width := Integer(AArgs[0]);
end;

function TRect_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter> write <setter>;

  if IsGet then
    Result := TRect_sw(AObj).FValue.Height
  else
    TRect_sw(AObj).FValue.Height := Integer(AArgs[0]);
end;

function TRect_Size_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Size: TSize read <getter> write <setter>;

  if IsGet then
    Result := TSize_sw.ToVar(TRect_sw(AObj).FValue.Size)
  else
    TRect_sw(AObj).FValue.Size := TSize_sw.FromVar(AArgs[0]);
end;

function TRect_Location_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Location: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TRect_sw(AObj).FValue.Location)
  else
    TRect_sw(AObj).FValue.Location := TPoint_sw.FromVar(AArgs[0]);
end;

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

  AData.AddProcedure('NormalizeRect', TRect_NormalizeRect_si, 0, False);
  AData.AddFunction('IsEmpty', TRect_IsEmpty_si, Boolean_sw, 0, False);
  AData.AddFunction('Contains', TRect_Contains_si, nil, 1, False);
  AData.AddFunction('IntersectsWith', TRect_IntersectsWith_si, Boolean_sw, 1, False);
  AData.AddProcedure('Intersect', TRect_Intersect_si, 1, False);
  AData.AddProcedure('Union', TRect_Union_si, 1, False);
  AData.AddProcedure('Offset', TRect_Offset_si, 1, True);
  AData.AddProcedure('SetLocation', TRect_SetLocation_si, 1, True);
  AData.AddProcedure('Inflate', TRect_Inflate_si, 2, True);
  AData.AddFunction('CenterPoint', TRect_CenterPoint_si, TPoint_sw, 0, False);
  AData.AddFunction('SplitRect', TRect_SplitRect_si, nil, 2, False);
  AData.AddProperty('Width', TRect_Width_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Height', TRect_Height_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Size', TRect_Size_si, TSize_sw, True, True, 0, False, False);
  AData.AddProperty('Location', TRect_Location_si, TPoint_sw, True, True, 0, False, False);
  AData.AddField('Left', TRect_Left_si, Longint_sw);
  AData.AddField('Top', TRect_Top_si, Longint_sw);
  AData.AddField('Right', TRect_Right_si, Longint_sw);
  AData.AddField('Bottom', TRect_Bottom_si, Longint_sw);
  AData.AddField('TopLeft', TRect_TopLeft_si, TPoint_sw);
  AData.AddField('BottomRight', TRect_BottomRight_si, TPoint_sw);
  AData.AddFunction('Copy', TRect_Copy_si, TRect_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TRect_Create_si, 0, True);
  AData.AddClassFunction('Empty', TRect_Empty_si, TRect_sw, 0, False);
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

{ TPointF_sw }

function TPointF_X_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var X: Single;

  if IsGet then
    Result := TPointF_sw(AObj).FValue.X
  else
    TPointF_sw(AObj).FValue.X := Single(AArgs[0]);
end;

function TPointF_Y_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Y: Single;

  if IsGet then
    Result := TPointF_sw(AObj).FValue.Y
  else
    TPointF_sw(AObj).FValue.Y := Single(AArgs[0]);
end;

function TPointF_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TPointF_sw.ToVar(TPointF.Create(TPointF_sw.FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TPointF_sw.ToVar(TPointF.Create(Single(AArgs[0]), Single(
        AArgs[1])));
    end;
    0:
    begin
      // Implicit parameterless constructor.
      Result := TPointF_sw.Create as IDispatch;
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TPointF_Distance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Distance(const P2: TPointF): Double;

  Result := TPointF_sw(AObj).FValue.Distance(TPointF_sw.FromVar(AArgs[0]));
end;

function TPointF_SetLocation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SetLocation(...); overload;

  case AArgsSize of
    2:
    begin
      TPointF_sw(AObj).FValue.SetLocation(Single(AArgs[0]), Single(AArgs[1]));
    end;
    1:
    begin
      TPointF_sw(AObj).FValue.SetLocation(TPointF_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('SetLocation');
  end;
end;

function TPointF_Offset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Offset(...); overload;

  case AArgsSize of
    2:
    begin
      TPointF_sw(AObj).FValue.Offset(Single(AArgs[0]), Single(AArgs[1]));
    end;
    1:
    begin
      TPointF_sw(AObj).FValue.Offset(TPointF_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Offset');
  end;
end;

function TPointF_Add_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure/function Add(...); overload;

  Result := TPointF_sw.ToVar(TPointF_sw(AObj).FValue.Add(TPointF_sw.FromVar(
    AArgs[0])));
end;

function TPointF_Subtract_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Subtract(...); overload;

  Result := TPointF_sw.ToVar(TPointF_sw(AObj).FValue.Subtract(TPointF_sw.
    FromVar(AArgs[0])));
end;

function TPointF_IsZero_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsZero: Boolean;

  Result := TPointF_sw(AObj).FValue.IsZero();
end;

function TPointF_Ceiling_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Ceiling: TPoint;

  Result := TPoint_sw.ToVar(TPointF_sw(AObj).FValue.Ceiling());
end;

function TPointF_Truncate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Truncate: TPoint;

  Result := TPoint_sw.ToVar(TPointF_sw(AObj).FValue.Truncate());
end;

function TPointF_Round_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Round: TPoint;

  Result := TPoint_sw.ToVar(TPointF_sw(AObj).FValue.Round());
end;

function TPointF_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TPointF;

  // Implicit record copy method.
  Result := TPointF_sw.ToVar(TPointF(AObj));
end;

class function TPointF_sw.GetTypeName: WideString;
begin
  Result := 'TPointF';
end;

function TPointF_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPointF_sw.Create;
  TPointF_sw(Result).FValue := FValue;
end;

class procedure TPointF_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('X', TPointF_X_si, Single_sw);
  AData.AddField('Y', TPointF_Y_si, Single_sw);
  AData.AddFunction('Distance', TPointF_Distance_si, Double_sw, 1, False);
  AData.AddProcedure('SetLocation', TPointF_SetLocation_si, 1, True);
  AData.AddProcedure('Offset', TPointF_Offset_si, 1, True);
  AData.AddFunction('Add', TPointF_Add_si, nil, 1, False);
  AData.AddFunction('Subtract', TPointF_Subtract_si, nil, 1, False);
  AData.AddFunction('IsZero', TPointF_IsZero_si, Boolean_sw, 0, False);
  AData.AddFunction('Ceiling', TPointF_Ceiling_si, TPoint_sw, 0, False);
  AData.AddFunction('Truncate', TPointF_Truncate_si, TPoint_sw, 0, False);
  AData.AddFunction('Round', TPointF_Round_si, TPoint_sw, 0, False);
  AData.AddFunction('Copy', TPointF_Copy_si, TPointF_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPointF_Create_si, 0, True);
end;

class function TPointF_sw.ToVar(const AValue: TPointF): OleVariant;
var
  wrpr: TPointF_sw;
begin
  wrpr        := TPointF_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPointF_sw.FromVar(const AValue: OleVariant): TPointF;
begin
  Result := TPointF_sw(ConvFromVar(AValue)).FValue;
end;

{ TVector_sw }

function TVector_X_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var X: Single;

  if IsGet then
    Result := TVector_sw(AObj).FValue.X
  else
    TVector_sw(AObj).FValue.X := Single(AArgs[0]);
end;

function TVector_Y_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Y: Single;

  if IsGet then
    Result := TVector_sw(AObj).FValue.Y
  else
    TVector_sw(AObj).FValue.Y := Single(AArgs[0]);
end;

function TVector_W_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var W: Single;

  if IsGet then
    Result := TVector_sw(AObj).FValue.W
  else
    TVector_sw(AObj).FValue.W := Single(AArgs[0]);
end;

function TVector_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TVector_sw.Create as IDispatch;
end;

function TVector_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TVector;

  // Implicit record copy method.
  Result := TVector_sw.ToVar(TVector(AObj));
end;

class function TVector_sw.GetTypeName: WideString;
begin
  Result := 'TVector';
end;

function TVector_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVector_sw.Create;
  TVector_sw(Result).FValue := FValue;
end;

class procedure TVector_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('X', TVector_X_si, Single_sw);
  AData.AddField('Y', TVector_Y_si, Single_sw);
  AData.AddField('W', TVector_W_si, Single_sw);
  AData.AddFunction('Copy', TVector_Copy_si, TVector_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TVector_Create_si, 0, False);
end;

class function TVector_sw.ToVar(const AValue: TVector): OleVariant;
var
  wrpr: TVector_sw;
begin
  wrpr        := TVector_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVector_sw.FromVar(const AValue: OleVariant): TVector;
begin
  Result := TVector_sw(ConvFromVar(AValue)).FValue;
end;

{ TMatrix_sw }

function TMatrix_m11_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var m11: Single;

  if IsGet then
    Result := TMatrix_sw(AObj).FValue.m11
  else
    TMatrix_sw(AObj).FValue.m11 := Single(AArgs[0]);
end;

function TMatrix_m12_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var m12: Single;

  if IsGet then
    Result := TMatrix_sw(AObj).FValue.m12
  else
    TMatrix_sw(AObj).FValue.m12 := Single(AArgs[0]);
end;

function TMatrix_m13_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var m13: Single;

  if IsGet then
    Result := TMatrix_sw(AObj).FValue.m13
  else
    TMatrix_sw(AObj).FValue.m13 := Single(AArgs[0]);
end;

function TMatrix_m21_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var m21: Single;

  if IsGet then
    Result := TMatrix_sw(AObj).FValue.m21
  else
    TMatrix_sw(AObj).FValue.m21 := Single(AArgs[0]);
end;

function TMatrix_m22_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var m22: Single;

  if IsGet then
    Result := TMatrix_sw(AObj).FValue.m22
  else
    TMatrix_sw(AObj).FValue.m22 := Single(AArgs[0]);
end;

function TMatrix_m23_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var m23: Single;

  if IsGet then
    Result := TMatrix_sw(AObj).FValue.m23
  else
    TMatrix_sw(AObj).FValue.m23 := Single(AArgs[0]);
end;

function TMatrix_m31_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var m31: Single;

  if IsGet then
    Result := TMatrix_sw(AObj).FValue.m31
  else
    TMatrix_sw(AObj).FValue.m31 := Single(AArgs[0]);
end;

function TMatrix_m32_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var m32: Single;

  if IsGet then
    Result := TMatrix_sw(AObj).FValue.m32
  else
    TMatrix_sw(AObj).FValue.m32 := Single(AArgs[0]);
end;

function TMatrix_m33_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var m33: Single;

  if IsGet then
    Result := TMatrix_sw(AObj).FValue.m33
  else
    TMatrix_sw(AObj).FValue.m33 := Single(AArgs[0]);
end;

function TMatrix_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TMatrix_sw.Create as IDispatch;
end;

function TMatrix_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TMatrix;

  // Implicit record copy method.
  Result := TMatrix_sw.ToVar(TMatrix(AObj));
end;

class function TMatrix_sw.GetTypeName: WideString;
begin
  Result := 'TMatrix';
end;

function TMatrix_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TMatrix_sw.Create;
  TMatrix_sw(Result).FValue := FValue;
end;

class procedure TMatrix_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('m11', TMatrix_m11_si, Single_sw);
  AData.AddField('m12', TMatrix_m12_si, Single_sw);
  AData.AddField('m13', TMatrix_m13_si, Single_sw);
  AData.AddField('m21', TMatrix_m21_si, Single_sw);
  AData.AddField('m22', TMatrix_m22_si, Single_sw);
  AData.AddField('m23', TMatrix_m23_si, Single_sw);
  AData.AddField('m31', TMatrix_m31_si, Single_sw);
  AData.AddField('m32', TMatrix_m32_si, Single_sw);
  AData.AddField('m33', TMatrix_m33_si, Single_sw);
  AData.AddFunction('Copy', TMatrix_Copy_si, TMatrix_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TMatrix_Create_si, 0, False);
end;

class function TMatrix_sw.ToVar(const AValue: TMatrix): OleVariant;
var
  wrpr: TMatrix_sw;
begin
  wrpr        := TMatrix_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TMatrix_sw.FromVar(const AValue: OleVariant): TMatrix;
begin
  Result := TMatrix_sw(ConvFromVar(AValue)).FValue;
end;

{ TSizeF_sw }

function TSizeF_cx_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var cx: Single;

  if IsGet then
    Result := TSizeF_sw(AObj).FValue.cx
  else
    TSizeF_sw(AObj).FValue.cx := Single(AArgs[0]);
end;

function TSizeF_cy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var cy: Single;

  if IsGet then
    Result := TSizeF_sw(AObj).FValue.cy
  else
    TSizeF_sw(AObj).FValue.cy := Single(AArgs[0]);
end;

function TSizeF_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TSizeF_sw.ToVar(TSizeF.Create(TSizeF_sw.FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TSizeF_sw.ToVar(TSizeF.Create(Single(AArgs[0]), Single(
        AArgs[1])));
    end;
    0:
    begin
      // Implicit parameterless constructor.
      Result := TSizeF_sw.Create as IDispatch;
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TSizeF_Ceiling_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Ceiling: TSize;

  Result := TSize_sw.ToVar(TSizeF_sw(AObj).FValue.Ceiling());
end;

function TSizeF_Truncate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Truncate: TSize;

  Result := TSize_sw.ToVar(TSizeF_sw(AObj).FValue.Truncate());
end;

function TSizeF_Round_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Round: TSize;

  Result := TSize_sw.ToVar(TSizeF_sw(AObj).FValue.Round());
end;

function TSizeF_Add_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Add(const Point: TSizeF): TSizeF;

  Result := TSizeF_sw.ToVar(TSizeF_sw(AObj).FValue.Add(TSizeF_sw.FromVar(
    AArgs[0])));
end;

function TSizeF_Subtract_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Subtract(const Point: TSizeF): TSizeF;

  Result := TSizeF_sw.ToVar(TSizeF_sw(AObj).FValue.Subtract(TSizeF_sw.FromVar(
    AArgs[0])));
end;

function TSizeF_Distance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Distance(const P2: TSizeF): Double;

  Result := TSizeF_sw(AObj).FValue.Distance(TSizeF_sw.FromVar(AArgs[0]));
end;

function TSizeF_IsZero_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsZero: Boolean;

  Result := TSizeF_sw(AObj).FValue.IsZero();
end;

function TSizeF_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Single read <getter> write <setter>;

  if IsGet then
    Result := TSizeF_sw(AObj).FValue.Width
  else
    TSizeF_sw(AObj).FValue.Width := Single(AArgs[0]);
end;

function TSizeF_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Single read <getter> write <setter>;

  if IsGet then
    Result := TSizeF_sw(AObj).FValue.Height
  else
    TSizeF_sw(AObj).FValue.Height := Single(AArgs[0]);
end;

function TSizeF_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Copy: TSizeF;

  // Implicit record copy method.
  Result := TSizeF_sw.ToVar(TSizeF(AObj));
end;

class function TSizeF_sw.GetTypeName: WideString;
begin
  Result := 'TSizeF';
end;

function TSizeF_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TSizeF_sw.Create;
  TSizeF_sw(Result).FValue := FValue;
end;

class procedure TSizeF_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('cx', TSizeF_cx_si, Single_sw);
  AData.AddField('cy', TSizeF_cy_si, Single_sw);
  AData.AddFunction('Ceiling', TSizeF_Ceiling_si, TSize_sw, 0, False);
  AData.AddFunction('Truncate', TSizeF_Truncate_si, TSize_sw, 0, False);
  AData.AddFunction('Round', TSizeF_Round_si, TSize_sw, 0, False);
  AData.AddFunction('Add', TSizeF_Add_si, TSizeF_sw, 1, False);
  AData.AddFunction('Subtract', TSizeF_Subtract_si, TSizeF_sw, 1, False);
  AData.AddFunction('Distance', TSizeF_Distance_si, Double_sw, 1, False);
  AData.AddFunction('IsZero', TSizeF_IsZero_si, Boolean_sw, 0, False);
  AData.AddProperty('Width', TSizeF_Width_si, Single_sw, True, True, 0, False, False);
  AData.AddProperty('Height', TSizeF_Height_si, Single_sw, True, True, 0, False, False);
  AData.AddFunction('Copy', TSizeF_Copy_si, TSizeF_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TSizeF_Create_si, 0, True);
end;

class function TSizeF_sw.ToVar(const AValue: TSizeF): OleVariant;
var
  wrpr: TSizeF_sw;
begin
  wrpr        := TSizeF_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TSizeF_sw.FromVar(const AValue: OleVariant): TSizeF;
begin
  Result := TSizeF_sw(ConvFromVar(AValue)).FValue;
end;

{ TRectF_sw }

function TRectF_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TRectF_sw.ToVar(TRectF.Create(TPointF_sw.FromVar(AArgs[0])));
    end;
    3:
    begin
      Result := TRectF_sw.ToVar(TRectF.Create(TPointF_sw.FromVar(AArgs[0]), 
        Single(AArgs[1]), Single(AArgs[2])));
    end;
    4:
    begin
      Result := TRectF_sw.ToVar(TRectF.Create(Single(AArgs[0]), Single(
        AArgs[1]), Single(AArgs[2]), Single(AArgs[3])));
    end;
    0:
    begin
      // Implicit parameterless constructor.
      Result := TRectF_sw.Create as IDispatch;
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TRectF_Empty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function Empty: TRectF;

  Result := TRectF_sw.ToVar(TRectF.Empty());
end;

function TRectF_NormalizeRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure NormalizeRect;

  TRectF_sw(AObj).FValue.NormalizeRect();
end;

function TRectF_IsEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsEmpty: Boolean;

  Result := TRectF_sw(AObj).FValue.IsEmpty();
end;

function TRectF_Contains_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Contains(...); overload;

  Result := TRectF_sw(AObj).FValue.Contains(TPointF_sw.FromVar(AArgs[0]));
end;

function TRectF_IntersectsWith_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IntersectsWith(const R: TRectF): Boolean;

  Result := TRectF_sw(AObj).FValue.IntersectsWith(TRectF_sw.FromVar(AArgs[0]));
end;

function TRectF_Intersect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Intersect(...); overload;

  TRectF_sw(AObj).FValue.Intersect(TRectF_sw.FromVar(AArgs[0]));
end;

function TRectF_Union_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Union(...); overload;

  TRectF_sw(AObj).FValue.Union(TRectF_sw.FromVar(AArgs[0]));
end;

function TRectF_Offset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Offset(...); overload;

  case AArgsSize of
    2:
    begin
      TRectF_sw(AObj).FValue.Offset(Single(AArgs[0]), Single(AArgs[1]));
    end;
    1:
    begin
      TRectF_sw(AObj).FValue.Offset(TPointF_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('Offset');
  end;
end;

function TRectF_SetLocation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SetLocation(...); overload;

  case AArgsSize of
    2:
    begin
      TRectF_sw(AObj).FValue.SetLocation(Single(AArgs[0]), Single(AArgs[1]));
    end;
    1:
    begin
      TRectF_sw(AObj).FValue.SetLocation(TPointF_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('SetLocation');
  end;
end;

function TRectF_Inflate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Inflate(...); overload;

  case AArgsSize of
    2:
    begin
      TRectF_sw(AObj).FValue.Inflate(Single(AArgs[0]), Single(AArgs[1]));
    end;
    4:
    begin
      TRectF_sw(AObj).FValue.Inflate(Single(AArgs[0]), Single(AArgs[1]), Single(
        AArgs[2]), Single(AArgs[3]));
    end;
  else
    WrongArgCountError('Inflate');
  end;
end;

function TRectF_CenterPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CenterPoint: TPointF;

  Result := TPointF_sw.ToVar(TRectF_sw(AObj).FValue.CenterPoint());
end;

function TRectF_Ceiling_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Ceiling: TRect;

  Result := TRect_sw.ToVar(TRectF_sw(AObj).FValue.Ceiling());
end;

function TRectF_Truncate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Truncate: TRect;

  Result := TRect_sw.ToVar(TRectF_sw(AObj).FValue.Truncate());
end;

function TRectF_Round_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Round: TRect;

  Result := TRect_sw.ToVar(TRectF_sw(AObj).FValue.Round());
end;

function TRectF_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Single read <getter> write <setter>;

  if IsGet then
    Result := TRectF_sw(AObj).FValue.Width
  else
    TRectF_sw(AObj).FValue.Width := Single(AArgs[0]);
end;

function TRectF_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Single read <getter> write <setter>;

  if IsGet then
    Result := TRectF_sw(AObj).FValue.Height
  else
    TRectF_sw(AObj).FValue.Height := Single(AArgs[0]);
end;

function TRectF_Size_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // property Size: TSizeF read <getter> write <setter>;

  if IsGet then
    Result := TSizeF_sw.ToVar(TRectF_sw(AObj).FValue.Size)
  else
    TRectF_sw(AObj).FValue.Size := TSizeF_sw.FromVar(AArgs[0]);
end;

function TRectF_Location_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Location: TPointF read <getter> write <setter>;

  if IsGet then
    Result := TPointF_sw.ToVar(TRectF_sw(AObj).FValue.Location)
  else
    TRectF_sw(AObj).FValue.Location := TPointF_sw.FromVar(AArgs[0]);
end;

function TRectF_Left_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Left: Single;

  if IsGet then
    Result := TRectF_sw(AObj).FValue.Left
  else
    TRectF_sw(AObj).FValue.Left := Single(AArgs[0]);
end;

function TRectF_Top_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Top: Single;

  if IsGet then
    Result := TRectF_sw(AObj).FValue.Top
  else
    TRectF_sw(AObj).FValue.Top := Single(AArgs[0]);
end;

function TRectF_Right_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Right: Single;

  if IsGet then
    Result := TRectF_sw(AObj).FValue.Right
  else
    TRectF_sw(AObj).FValue.Right := Single(AArgs[0]);
end;

function TRectF_Bottom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Bottom: Single;

  if IsGet then
    Result := TRectF_sw(AObj).FValue.Bottom
  else
    TRectF_sw(AObj).FValue.Bottom := Single(AArgs[0]);
end;

function TRectF_TopLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TopLeft: TPointF;

  if IsGet then
    Result := TPointF_sw.ToVar(TRectF_sw(AObj).FValue.TopLeft)
  else
    TRectF_sw(AObj).FValue.TopLeft := TPointF_sw.FromVar(AArgs[0]);
end;

function TRectF_BottomRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BottomRight: TPointF;

  if IsGet then
    Result := TPointF_sw.ToVar(TRectF_sw(AObj).FValue.BottomRight)
  else
    TRectF_sw(AObj).FValue.BottomRight := TPointF_sw.FromVar(AArgs[0]);
end;

function TRectF_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Copy: TRectF;

  // Implicit record copy method.
  Result := TRectF_sw.ToVar(TRectF(AObj));
end;

class function TRectF_sw.GetTypeName: WideString;
begin
  Result := 'TRectF';
end;

function TRectF_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TRectF_sw.Create;
  TRectF_sw(Result).FValue := FValue;
end;

class procedure TRectF_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddProcedure('NormalizeRect', TRectF_NormalizeRect_si, 0, False);
  AData.AddFunction('IsEmpty', TRectF_IsEmpty_si, Boolean_sw, 0, False);
  AData.AddFunction('Contains', TRectF_Contains_si, nil, 1, False);
  AData.AddFunction('IntersectsWith', TRectF_IntersectsWith_si, Boolean_sw, 1, False);
  AData.AddProcedure('Intersect', TRectF_Intersect_si, 1, False);
  AData.AddProcedure('Union', TRectF_Union_si, 1, False);
  AData.AddProcedure('Offset', TRectF_Offset_si, 1, True);
  AData.AddProcedure('SetLocation', TRectF_SetLocation_si, 1, True);
  AData.AddProcedure('Inflate', TRectF_Inflate_si, 2, True);
  AData.AddFunction('CenterPoint', TRectF_CenterPoint_si, TPointF_sw, 0, False);
  AData.AddFunction('Ceiling', TRectF_Ceiling_si, TRect_sw, 0, False);
  AData.AddFunction('Truncate', TRectF_Truncate_si, TRect_sw, 0, False);
  AData.AddFunction('Round', TRectF_Round_si, TRect_sw, 0, False);
  AData.AddProperty('Width', TRectF_Width_si, Single_sw, True, True, 0, False, False);
  AData.AddProperty('Height', TRectF_Height_si, Single_sw, True, True, 0, False, False);
  AData.AddProperty('Size', TRectF_Size_si, TSizeF_sw, True, True, 0, False, False);
  AData.AddProperty('Location', TRectF_Location_si, TPointF_sw, True, True, 0, False, False);
  AData.AddField('Left', TRectF_Left_si, Single_sw);
  AData.AddField('Top', TRectF_Top_si, Single_sw);
  AData.AddField('Right', TRectF_Right_si, Single_sw);
  AData.AddField('Bottom', TRectF_Bottom_si, Single_sw);
  AData.AddField('TopLeft', TRectF_TopLeft_si, TPointF_sw);
  AData.AddField('BottomRight', TRectF_BottomRight_si, TPointF_sw);
  AData.AddFunction('Copy', TRectF_Copy_si, TRectF_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TRectF_Create_si, 0, True);
  AData.AddClassFunction('Empty', TRectF_Empty_si, TRectF_sw, 0, False);
end;

class function TRectF_sw.ToVar(const AValue: TRectF): OleVariant;
var
  wrpr: TRectF_sw;
begin
  wrpr        := TRectF_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TRectF_sw.FromVar(const AValue: OleVariant): TRectF;
begin
  Result := TRectF_sw(ConvFromVar(AValue)).FValue;
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

function Types_TSize_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TSize = record;

  Result := TLMDUnitWrapper.TypeToVar(TSize_sw);
end;

function Types_SIZE_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type SIZE = TSize;

  Result := TLMDUnitWrapper.TypeToVar(SIZE_sw);
end;

function Types_tagSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagSize = TSize;

  Result := TLMDUnitWrapper.TypeToVar(tagSize_sw);
end;

function Types_TSmallPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSmallPoint = record;

  Result := TLMDUnitWrapper.TypeToVar(TSmallPoint_sw);
end;

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

function Types_TSplitRectType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSplitRectType = (srLeft, srRight, srTop, srBottom);

  Result := TLMDUnitWrapper.TypeToVar(TSplitRectType_sw);
end;

function Types_TRect_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TRect = record;

  Result := TLMDUnitWrapper.TypeToVar(TRect_sw);
end;

function Types_TPointF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPointF = record;

  Result := TLMDUnitWrapper.TypeToVar(TPointF_sw);
end;

function Types_TVector_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVector = record;

  Result := TLMDUnitWrapper.TypeToVar(TVector_sw);
end;

function Types_TMatrix_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMatrix = record;

  Result := TLMDUnitWrapper.TypeToVar(TMatrix_sw);
end;

function Types_tagPOINTF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagPOINTF = TPointF;

  Result := TLMDUnitWrapper.TypeToVar(tagPOINTF_sw);
end;

function Types_TSizeF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSizeF = record;

  Result := TLMDUnitWrapper.TypeToVar(TSizeF_sw);
end;

function Types_TRectF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRectF = record;

  Result := TLMDUnitWrapper.TypeToVar(TRectF_sw);
end;

function Types_DWORD_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type DWORD = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(DWORD_sw);
end;

function Types_NullChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NullChar = <value>;

  Result := NullChar;
end;

function Types_Tabulator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Tabulator = <value>;

  Result := Tabulator;
end;

function Types_Space_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const Space = <value>;

  Result := Space;
end;

function Types_CarriageReturn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CarriageReturn = <value>;

  Result := CarriageReturn;
end;

function Types_LineFeed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const LineFeed = <value>;

  Result := LineFeed;
end;

function Types_VerticalTab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VerticalTab = <value>;

  Result := VerticalTab;
end;

function Types_FormFeed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const FormFeed = <value>;

  Result := FormFeed;
end;

function Types_LineSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const LineSeparator = <value>;

  Result := LineSeparator;
end;

function Types_ParagraphSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ParagraphSeparator = <value>;

  Result := ParagraphSeparator;
end;

function Types_BOM_LSB_FIRST_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const BOM_LSB_FIRST = <value>;

  Result := BOM_LSB_FIRST;
end;

function Types_BOM_MSB_FIRST_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const BOM_MSB_FIRST = <value>;

  Result := BOM_MSB_FIRST;
end;

function Types_GUID_NULL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GUID_NULL: TGUID = <value>;

  Result := TGUID_sw.ToVar(GUID_NULL);
end;

function Types_cPI_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const cPI: Single = <value>;

  Result := cPI;
end;

function Types_cPIdiv180_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cPIdiv180: Single = <value>;

  Result := cPIdiv180;
end;

function Types_c180divPI_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const c180divPI: Single = <value>;

  Result := c180divPI;
end;

function Types_c2PI_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const c2PI: Single = <value>;

  Result := c2PI;
end;

function Types_cPIdiv2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cPIdiv2: Single = <value>;

  Result := cPIdiv2;
end;

function Types_cPIdiv4_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cPIdiv4: Single = <value>;

  Result := cPIdiv4;
end;

function Types_c3PIdiv4_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const c3PIdiv4: Single = <value>;

  Result := c3PIdiv4;
end;

function Types_cInv2PI_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cInv2PI: Single = <value>;

  Result := cInv2PI;
end;

function Types_cInv360_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cInv360: Single = <value>;

  Result := cInv360;
end;

function Types_c180_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const c180: Single = <value>;

  Result := c180;
end;

function Types_c360_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const c360: Single = <value>;

  Result := c360;
end;

function Types_cOneHalf_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cOneHalf: Single = <value>;

  Result := cOneHalf;
end;

function Types_CurveKappa_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CurveKappa = <value>;

  Result := CurveKappa;
end;

function Types_CurveKappaInv_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CurveKappaInv = <value>;

  Result := CurveKappaInv;
end;

function Types_Epsilon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Epsilon: Single = <value>;

  Result := Epsilon;
end;

function Types_Epsilon2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Epsilon2: Single = <value>;

  Result := Epsilon2;
end;

function Types_EqualRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function EqualRect(...); overload;

  Result := System.Types.EqualRect(TRect_sw.FromVar(AArgs[0]), TRect_sw.FromVar(
    AArgs[1]));
end;

function Types_Rect_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Rect(Left: Integer; Top: Integer; Right: Integer...

  Result := TRect_sw.ToVar(System.Types.Rect(Integer(AArgs[0]), Integer(
    AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3])));
end;

function Types_RectF_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure/function RectF(...); overload;

  Result := TRectF_sw.ToVar(System.Types.RectF(Single(AArgs[0]), Single(
    AArgs[1]), Single(AArgs[2]), Single(AArgs[3])));
end;

function Types_NormalizeRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function NormalizeRect(...); overload;

  Result := TRectF_sw.ToVar(System.Types.NormalizeRect(TRectF_sw.FromVar(
    AArgs[0])));
end;

function Types_RectWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function RectWidth(...); overload;

  Result := System.Types.RectWidth(TRect_sw.FromVar(AArgs[0]));
end;

function Types_RectHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function RectHeight(...); overload;

  Result := System.Types.RectHeight(TRect_sw.FromVar(AArgs[0]));
end;

function Types_RectCenter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // procedure/function RectCenter(...); overload;

  v_1 := TRect_sw.FromVar(AArgs[0]);
  Result := TRect_sw.ToVar(System.Types.RectCenter(v_1, TRect_sw.FromVar(
    AArgs[1])));
  AssignRefParam(AArgs[0], TRect_sw.ToVar(v_1));
end;

function Types_Bounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Bounds(ALeft: Integer; ATop: Integer; AWidth: In...

  Result := TRect_sw.ToVar(System.Types.Bounds(Integer(AArgs[0]), Integer(
    AArgs[1]), Integer(AArgs[2]), Integer(AArgs[3])));
end;

function Types_Point_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure/function Point(...); overload;

  Result := TPoint_sw.ToVar(System.Types.Point(Integer(AArgs[0]), Integer(
    AArgs[1])));
end;

function Types_PointF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function PointF(...); overload;

  case AArgsSize of
    2:
    begin
      Result := TPointF_sw.ToVar(System.Types.PointF(Single(AArgs[0]), Single(
        AArgs[1])));
    end;
    1:
    begin
      Result := TPointF_sw.ToVar(System.Types.PointF(TVector_sw.FromVar(
        AArgs[0])));
    end;
  else
    WrongArgCountError('PointF');
  end;
end;

function Types_MinPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function MinPoint(...); overload;

  Result := TPoint_sw.ToVar(System.Types.MinPoint(TPoint_sw.FromVar(AArgs[0]), 
    TPoint_sw.FromVar(AArgs[1])));
end;

function Types_ScalePoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function ScalePoint(...); overload;

  Result := TPoint_sw.ToVar(System.Types.ScalePoint(TPoint_sw.FromVar(AArgs[0]),
    Single(AArgs[1]), Single(AArgs[2])));
end;

function Types_SmallPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SmallPoint(...); overload;

  case AArgsSize of
    2:
    begin
      Result := TSmallPoint_sw.ToVar(System.Types.SmallPoint(Integer(AArgs[0]), 
        Integer(AArgs[1])));
    end;
    1:
    begin
      Result := TSmallPoint_sw.ToVar(System.Types.SmallPoint(LongWord(
        AArgs[0])));
    end;
  else
    WrongArgCountError('SmallPoint');
  end;
end;

function Types_PtInRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function PtInRect(...); overload;

  Result := System.Types.PtInRect(TRect_sw.FromVar(AArgs[0]), TPoint_sw.FromVar(
    AArgs[1]));
end;

function Types_PtInCircle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function PtInCircle(const Point: TPoint; const Center: TP...

  Result := System.Types.PtInCircle(TPoint_sw.FromVar(AArgs[0]), TPoint_sw.
    FromVar(AArgs[1]), Integer(AArgs[2]));
end;

function Types_IntersectRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // procedure/function IntersectRect(...); overload;

  case AArgsSize of
    2:
    begin
      Result := System.Types.IntersectRect(TRect_sw.FromVar(AArgs[0]), TRect_sw.
        FromVar(AArgs[1]));
    end;
    3:
    begin
      Result := System.Types.IntersectRect(v_1, TRect_sw.FromVar(AArgs[1]), 
        TRect_sw.FromVar(AArgs[2]));
      AssignRefParam(AArgs[0], TRect_sw.ToVar(v_1));
    end;
  else
    WrongArgCountError('IntersectRect');
  end;
end;

function Types_UnionRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // procedure/function UnionRect(...); overload;

  case AArgsSize of
    3:
    begin
      Result := System.Types.UnionRect(v_1, TRect_sw.FromVar(AArgs[1]), 
        TRect_sw.FromVar(AArgs[2]));
      AssignRefParam(AArgs[0], TRect_sw.ToVar(v_1));
    end;
    2:
    begin
      Result := TRect_sw.ToVar(System.Types.UnionRect(TRect_sw.FromVar(
        AArgs[0]), TRect_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('UnionRect');
  end;
end;

function Types_IsRectEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function IsRectEmpty(...); overload;

  Result := System.Types.IsRectEmpty(TRect_sw.FromVar(AArgs[0]));
end;

function Types_OffsetRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // procedure/function OffsetRect(...); overload;

  v_1 := TRect_sw.FromVar(AArgs[0]);
  Result := System.Types.OffsetRect(v_1, Integer(AArgs[1]), Integer(AArgs[2]));
  AssignRefParam(AArgs[0], TRect_sw.ToVar(v_1));
end;

function Types_MultiplyRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRectF;
begin
  // procedure MultiplyRect(var R: TRectF; const DX: Single; c...

  v_1 := TRectF_sw.FromVar(AArgs[0]);
  System.Types.MultiplyRect(v_1, Single(AArgs[1]), Single(AArgs[2]));
  AssignRefParam(AArgs[0], TRectF_sw.ToVar(v_1));
end;

function Types_InflateRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRect;
begin
  // procedure/function InflateRect(...); overload;

  v_1 := TRect_sw.FromVar(AArgs[0]);
  System.Types.InflateRect(v_1, Integer(AArgs[1]), Integer(AArgs[2]));
  AssignRefParam(AArgs[0], TRect_sw.ToVar(v_1));
end;

function Types_CenterPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CenterPoint(const Rect: TRect): TPoint;

  Result := TPoint_sw.ToVar(System.Types.CenterPoint(TRect_sw.FromVar(
    AArgs[0])));
end;

function Types_SplitRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SplitRect(...); overload;

  Result := TRect_sw.ToVar(System.Types.SplitRect(TRect_sw.FromVar(AArgs[0]), 
    TSplitRectType_sw.FromVar(AArgs[1]), Integer(AArgs[2])));
end;

function Types_CenteredRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CenteredRect(const SourceRect: TRect; const Cent...

  Result := TRect_sw.ToVar(System.Types.CenteredRect(TRect_sw.FromVar(AArgs[0]),
    TRect_sw.FromVar(AArgs[1])));
end;

function Types_IntersectRectF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRectF;
begin
  // function IntersectRectF(out Rect: TRectF; const R1: TRect...

  Result := System.Types.IntersectRectF(v_1, TRectF_sw.FromVar(AArgs[1]), 
    TRectF_sw.FromVar(AArgs[2]));
  AssignRefParam(AArgs[0], TRectF_sw.ToVar(v_1));
end;

function Types_UnionRectF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TRectF;
begin
  // function UnionRectF(out Rect: TRectF; const R1: TRectF; c...

  Result := System.Types.UnionRectF(v_1, TRectF_sw.FromVar(AArgs[1]), TRectF_sw.
    FromVar(AArgs[2]));
  AssignRefParam(AArgs[0], TRectF_sw.ToVar(v_1));
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

  Result := TValueRelationship_sw.ToVar(LessThanValue);
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

  Result := TValueRelationship_sw.ToVar(GreaterThanValue);
end;

class function Types_sw.GetUnitName: WideString;
begin
  Result := 'Types';
end;

class procedure Types_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TSize_sw, Types_TSize_si);
  AData.AddType(SIZE_sw, Types_SIZE_si);
  AData.AddType(tagSize_sw, Types_tagSize_si);
  AData.AddType(TSmallPoint_sw, Types_TSmallPoint_si);
  AData.AddType(TPoint_sw, Types_TPoint_si);
  AData.AddType(tagPOINT_sw, Types_tagPOINT_si);
  AData.AddType(TSplitRectType_sw, Types_TSplitRectType_si);
  AData.AddType(TRect_sw, Types_TRect_si);
  AData.AddType(TPointF_sw, Types_TPointF_si);
  AData.AddType(TVector_sw, Types_TVector_si);
  AData.AddType(TMatrix_sw, Types_TMatrix_si);
  AData.AddType(tagPOINTF_sw, Types_tagPOINTF_si);
  AData.AddType(TSizeF_sw, Types_TSizeF_si);
  AData.AddType(TRectF_sw, Types_TRectF_si);
  AData.AddType(DWORD_sw, Types_DWORD_si);
  AData.AddConstant('NullChar', Types_NullChar_si, nil, VarType(System.Types.NullChar));
  AData.AddConstant('Tabulator', Types_Tabulator_si, nil, VarType(System.Types.Tabulator));
  AData.AddConstant('Space', Types_Space_si, nil, VarType(System.Types.Space));
  AData.AddConstant('CarriageReturn', Types_CarriageReturn_si, nil, VarType(System.Types.CarriageReturn));
  AData.AddConstant('LineFeed', Types_LineFeed_si, nil, VarType(System.Types.LineFeed));
  AData.AddConstant('VerticalTab', Types_VerticalTab_si, nil, VarType(System.Types.VerticalTab));
  AData.AddConstant('FormFeed', Types_FormFeed_si, nil, VarType(System.Types.FormFeed));
  AData.AddConstant('LineSeparator', Types_LineSeparator_si, nil, VarType(System.Types.LineSeparator));
  AData.AddConstant('ParagraphSeparator', Types_ParagraphSeparator_si, nil, VarType(System.Types.ParagraphSeparator));
  AData.AddConstant('BOM_LSB_FIRST', Types_BOM_LSB_FIRST_si, nil, VarType(System.Types.BOM_LSB_FIRST));
  AData.AddConstant('BOM_MSB_FIRST', Types_BOM_MSB_FIRST_si, nil, VarType(System.Types.BOM_MSB_FIRST));
  AData.AddConstant('GUID_NULL', Types_GUID_NULL_si, TGUID_sw);
  AData.AddConstant('cPI', Types_cPI_si, Single_sw);
  AData.AddConstant('cPIdiv180', Types_cPIdiv180_si, Single_sw);
  AData.AddConstant('c180divPI', Types_c180divPI_si, Single_sw);
  AData.AddConstant('c2PI', Types_c2PI_si, Single_sw);
  AData.AddConstant('cPIdiv2', Types_cPIdiv2_si, Single_sw);
  AData.AddConstant('cPIdiv4', Types_cPIdiv4_si, Single_sw);
  AData.AddConstant('c3PIdiv4', Types_c3PIdiv4_si, Single_sw);
  AData.AddConstant('cInv2PI', Types_cInv2PI_si, Single_sw);
  AData.AddConstant('cInv360', Types_cInv360_si, Single_sw);
  AData.AddConstant('c180', Types_c180_si, Single_sw);
  AData.AddConstant('c360', Types_c360_si, Single_sw);
  AData.AddConstant('cOneHalf', Types_cOneHalf_si, Single_sw);
  AData.AddConstant('CurveKappa', Types_CurveKappa_si, nil, VarType(System.Types.CurveKappa));
  AData.AddConstant('CurveKappaInv', Types_CurveKappaInv_si, nil, VarType(System.Types.CurveKappaInv));
  AData.AddConstant('Epsilon', Types_Epsilon_si, Single_sw);
  AData.AddConstant('Epsilon2', Types_Epsilon2_si, Single_sw);
  AData.AddFunction('EqualRect', Types_EqualRect_si, nil, 2, False);
  AData.AddFunction('Rect', Types_Rect_si, TRect_sw, 4, False);
  AData.AddFunction('RectF', Types_RectF_si, nil, 4, False);
  AData.AddFunction('NormalizeRect', Types_NormalizeRect_si, nil, 1, False);
  AData.AddFunction('RectWidth', Types_RectWidth_si, nil, 1, False);
  AData.AddFunction('RectHeight', Types_RectHeight_si, nil, 1, False);
  AData.AddFunction('RectCenter', Types_RectCenter_si, nil, 2, False);
  AData.AddFunction('Bounds', Types_Bounds_si, TRect_sw, 4, False);
  AData.AddFunction('Point', Types_Point_si, nil, 2, False);
  AData.AddFunction('PointF', Types_PointF_si, nil, 1, True);
  AData.AddFunction('MinPoint', Types_MinPoint_si, nil, 2, False);
  AData.AddFunction('ScalePoint', Types_ScalePoint_si, nil, 3, False);
  AData.AddFunction('SmallPoint', Types_SmallPoint_si, nil, 1, True);
  AData.AddFunction('PtInRect', Types_PtInRect_si, nil, 2, False);
  AData.AddFunction('PtInCircle', Types_PtInCircle_si, Boolean_sw, 3, False);
  AData.AddFunction('IntersectRect', Types_IntersectRect_si, nil, 2, True);
  AData.AddFunction('UnionRect', Types_UnionRect_si, nil, 2, True);
  AData.AddFunction('IsRectEmpty', Types_IsRectEmpty_si, nil, 1, False);
  AData.AddFunction('OffsetRect', Types_OffsetRect_si, nil, 3, False);
  AData.AddProcedure('MultiplyRect', Types_MultiplyRect_si, 3, False);
  AData.AddProcedure('InflateRect', Types_InflateRect_si, 3, False);
  AData.AddFunction('CenterPoint', Types_CenterPoint_si, TPoint_sw, 1, False);
  AData.AddFunction('SplitRect', Types_SplitRect_si, nil, 3, False);
  AData.AddFunction('CenteredRect', Types_CenteredRect_si, TRect_sw, 2, False);
  AData.AddFunction('IntersectRectF', Types_IntersectRectF_si, Boolean_sw, 3, False);
  AData.AddFunction('UnionRectF', Types_UnionRectF_si, Boolean_sw, 3, False);
  AData.AddType(TValueRelationship_sw, Types_TValueRelationship_si);
  AData.AddConstant('LessThanValue', Types_LessThanValue_si, TValueRelationship_sw);
  AData.AddConstant('EqualsValue', Types_EqualsValue_si, nil, VarType(System.Types.EqualsValue));
  AData.AddConstant('GreaterThanValue', Types_GreaterThanValue_si, TValueRelationship_sw);
end;

class function Types_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Types_sw);
end;

initialization
  RegisterUnitWrapper(Types_sw);

end.
