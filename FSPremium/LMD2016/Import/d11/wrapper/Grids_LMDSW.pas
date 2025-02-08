unit Grids_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Grids' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers, Types,
  Messages, Windows, SysUtils, Classes, Variants, Graphics, Menus, Controls,
  Forms, StdCtrls, Mask, Grids, Messages_LMDSW, Windows_LMDSW, SysUtils_LMDSW,
  Classes_LMDSW, Variants_LMDSW, Graphics_LMDSW, Menus_LMDSW, Controls_LMDSW,
  Forms_LMDSW, StdCtrls_LMDSW, Mask_LMDSW;


{ Type wrappers }

type
  EInvalidGridOperation_sw = class;
  TInplaceEdit_sw = class;
  TCustomGrid_sw = class;
  TCustomDrawGrid_sw = class;
  TDrawGrid_sw = class;
  TStringGridStrings_sw = class;
  TStringGrid_sw = class;
  TInplaceEditList_sw = class;

  EInvalidGridOperation_sc = class of EInvalidGridOperation;
  EInvalidGridOperation_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EInvalidGridOperation): OleVariant;
    class function FromVar(const AValue: OleVariant): EInvalidGridOperation;
    class function ClassToVar(AClass: EInvalidGridOperation_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EInvalidGridOperation_sc;
  end;

  TGetExtentsFunc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    function Handler(Index: Longint): Integer;
  end;

  TGetExtentsFunc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetExtentsFunc): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetExtentsFunc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetExtentsFunc;
  end;

  TGridAxisDrawInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TGridAxisDrawInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TGridAxisDrawInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TGridAxisDrawInfo;
  end;

  TGridDrawInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TGridDrawInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TGridDrawInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TGridDrawInfo;
  end;

  TGridState_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TGridState): OleVariant;
    class function FromVar(const AValue: OleVariant): TGridState;
  end;

  TGridMovement_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGridMovement): OleVariant;
    class function FromVar(const AValue: OleVariant): TGridMovement;
  end;

  TInplaceEdit_sc = class of TInplaceEdit;
  TInplaceEdit_sw = class(TCustomMaskEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TInplaceEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TInplaceEdit;
    class function ClassToVar(AClass: TInplaceEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TInplaceEdit_sc;
  end;

  TGridOption_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TGridOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TGridOption;
  end;

  TGridOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TGridOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TGridOptions;
  end;

  TGridCoord_sw = class(TLMDRecordWrapper)
  private
    FValue: TGridCoord;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TGridCoord): OleVariant;
    class function FromVar(const AValue: OleVariant): TGridCoord;
  end;

  TGridRect_sw = class(TLMDRecordWrapper)
  private
    FValue: TGridRect;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TGridRect): OleVariant;
    class function FromVar(const AValue: OleVariant): TGridRect;
  end;

  TEditStyle_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TEditStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditStyle;
  end;

  TSelectCellEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; ACol: Longint; ARow: Longint;
      var CanSelect: Boolean);
  end;

  TSelectCellEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSelectCellEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TSelectCellEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TSelectCellEvent;
  end;

  TCustomGrid_sc = class of TCustomGrid;
  TCustomGrid_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomGrid): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomGrid;
    class function ClassToVar(AClass: TCustomGrid_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomGrid_sc;
  end;

  TGetEditEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; ACol: Longint; ARow: Longint;
      var Value: string);
  end;

  TGetEditEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetEditEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetEditEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetEditEvent;
  end;

  TSetEditEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; ACol: Longint; ARow: Longint;
      const Value: string);
  end;

  TSetEditEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSetEditEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TSetEditEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TSetEditEvent;
  end;

  TMovedEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; FromIndex: Longint; ToIndex: Longint);
  end;

  TMovedEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMovedEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TMovedEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TMovedEvent;
  end;

  TCustomDrawGrid_sc = class of TCustomDrawGrid;
  TCustomDrawGrid_sw = class(TCustomGrid_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomDrawGrid): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomDrawGrid;
    class function ClassToVar(AClass: TCustomDrawGrid_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomDrawGrid_sc;
  end;

  TDrawGrid_sc = class of TDrawGrid;
  TDrawGrid_sw = class(TCustomDrawGrid_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDrawGrid): OleVariant;
    class function FromVar(const AValue: OleVariant): TDrawGrid;
    class function ClassToVar(AClass: TDrawGrid_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDrawGrid_sc;
  end;

  TStringGridStrings_sc = class of TStringGridStrings;
  TStringGridStrings_sw = class(TStrings_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStringGridStrings): OleVariant;
    class function FromVar(const AValue: OleVariant): TStringGridStrings;
    class function ClassToVar(AClass: TStringGridStrings_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStringGridStrings_sc;
  end;

  TStringGrid_sc = class of TStringGrid;
  TStringGrid_sw = class(TDrawGrid_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStringGrid): OleVariant;
    class function FromVar(const AValue: OleVariant): TStringGrid;
    class function ClassToVar(AClass: TStringGrid_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStringGrid_sc;
  end;

  TOnGetPickListItems_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(ACol: Integer; ARow: Integer; Items: TStrings);
  end;

  TOnGetPickListItems_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TOnGetPickListItems): OleVariant;
    class function FromVar(const AValue: OleVariant): TOnGetPickListItems;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TOnGetPickListItems;
  end;

  TInplaceEditList_sc = class of TInplaceEditList;
  TInplaceEditList_sw = class(TInPlaceEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TInplaceEditList): OleVariant;
    class function FromVar(const AValue: OleVariant): TInplaceEditList;
    class function ClassToVar(AClass: TInplaceEditList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TInplaceEditList_sc;
  end;


{ Unit wrapper }

type
  Grids_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TInplaceEdit_sacc = class(TInplaceEdit);
  TCustomGrid_sacc = class(TCustomGrid);
  TCustomDrawGrid_sacc = class(TCustomDrawGrid);

{ EInvalidGridOperation_sw }

class function EInvalidGridOperation_sw.GetTypeName: WideString;
begin
  Result := 'EInvalidGridOperation';
end;

class function EInvalidGridOperation_sw.GetWrappedClass: TClass;
begin
  Result := EInvalidGridOperation;
end;

class procedure EInvalidGridOperation_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EInvalidGridOperation_sw.ToVar(
  const AValue: EInvalidGridOperation): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EInvalidGridOperation_sw.FromVar(
  const AValue: OleVariant): EInvalidGridOperation;
begin
  Result := EInvalidGridOperation(ConvFromVar(AValue, EInvalidGridOperation));
end;

class function EInvalidGridOperation_sw.ClassToVar(
  AClass: EInvalidGridOperation_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EInvalidGridOperation_sw.ClassFromVar(
  const AClass: OleVariant): EInvalidGridOperation_sc;
begin
  Result := EInvalidGridOperation_sc(ConvClsFromVar(AClass, 
    EInvalidGridOperation));
end;

{ TGetExtentsFunc_sh }

function TGetExtentsFunc_sh.GetHandler: TMethod;
var
  hdr: TGetExtentsFunc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

function TGetExtentsFunc_sh.Handler(Index: Longint): Integer;
var
  args: array[0..0] of OleVariant;
begin
  // function (Index: Longint): Integer of object

  args[0] := Index;
  Result := Integer(Self.Owner.RunProc(Self.ProcName, args));
end;

{ TGetExtentsFunc_sw }

class function TGetExtentsFunc_sw.GetTypeName: WideString;
begin
  Result := 'TGetExtentsFunc';
end;

class function TGetExtentsFunc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetExtentsFunc_sh;
end;

class function TGetExtentsFunc_sw.ToVar(
  const AValue: TGetExtentsFunc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetExtentsFunc_sw.FromVar(
  const AValue: OleVariant): TGetExtentsFunc;
begin
  Result := TGetExtentsFunc(ConvFromVar(AValue));
end;

class function TGetExtentsFunc_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetExtentsFunc;
var
  hdlr: TGetExtentsFunc_sh;
begin
  hdlr   := TGetExtentsFunc_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetExtentsFunc_sw));
  Result := hdlr.Handler;
end;

{ TGridAxisDrawInfo_sw }

function TGridAxisDrawInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TGridAxisDrawInfo_sw.ToVar(TGridAxisDrawInfo(AObj));
end;

function TGridAxisDrawInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TGridAxisDrawInfo_sw.Create as IDispatch;
end;

function TGridAxisDrawInfo_EffectiveLineWidth_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var EffectiveLineWidth: Integer;

  if IsGet then
    Result := TGridAxisDrawInfo_sw(AObj).FValue.EffectiveLineWidth
  else
    TGridAxisDrawInfo_sw(AObj).FValue.EffectiveLineWidth := Integer(AArgs[0]);
end;

function TGridAxisDrawInfo_FixedBoundary_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FixedBoundary: Integer;

  if IsGet then
    Result := TGridAxisDrawInfo_sw(AObj).FValue.FixedBoundary
  else
    TGridAxisDrawInfo_sw(AObj).FValue.FixedBoundary := Integer(AArgs[0]);
end;

function TGridAxisDrawInfo_GridBoundary_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var GridBoundary: Integer;

  if IsGet then
    Result := TGridAxisDrawInfo_sw(AObj).FValue.GridBoundary
  else
    TGridAxisDrawInfo_sw(AObj).FValue.GridBoundary := Integer(AArgs[0]);
end;

function TGridAxisDrawInfo_GridExtent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var GridExtent: Integer;

  if IsGet then
    Result := TGridAxisDrawInfo_sw(AObj).FValue.GridExtent
  else
    TGridAxisDrawInfo_sw(AObj).FValue.GridExtent := Integer(AArgs[0]);
end;

function TGridAxisDrawInfo_LastFullVisibleCell_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LastFullVisibleCell: Longint;

  if IsGet then
    Result := TGridAxisDrawInfo_sw(AObj).FValue.LastFullVisibleCell
  else
    TGridAxisDrawInfo_sw(AObj).FValue.LastFullVisibleCell := Longint(AArgs[0]);
end;

function TGridAxisDrawInfo_FullVisBoundary_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FullVisBoundary: Integer;

  if IsGet then
    Result := TGridAxisDrawInfo_sw(AObj).FValue.FullVisBoundary
  else
    TGridAxisDrawInfo_sw(AObj).FValue.FullVisBoundary := Integer(AArgs[0]);
end;

function TGridAxisDrawInfo_FixedCellCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FixedCellCount: Integer;

  if IsGet then
    Result := TGridAxisDrawInfo_sw(AObj).FValue.FixedCellCount
  else
    TGridAxisDrawInfo_sw(AObj).FValue.FixedCellCount := Integer(AArgs[0]);
end;

function TGridAxisDrawInfo_FirstGridCell_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FirstGridCell: Integer;

  if IsGet then
    Result := TGridAxisDrawInfo_sw(AObj).FValue.FirstGridCell
  else
    TGridAxisDrawInfo_sw(AObj).FValue.FirstGridCell := Integer(AArgs[0]);
end;

function TGridAxisDrawInfo_GridCellCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var GridCellCount: Integer;

  if IsGet then
    Result := TGridAxisDrawInfo_sw(AObj).FValue.GridCellCount
  else
    TGridAxisDrawInfo_sw(AObj).FValue.GridCellCount := Integer(AArgs[0]);
end;

function TGridAxisDrawInfo_GetExtent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var GetExtent: TGetExtentsFunc;

  if IsGet then
    Result := TGetExtentsFunc_sw.ToVar(TGridAxisDrawInfo_sw(AObj).FValue.
      GetExtent)
  else
    TGridAxisDrawInfo_sw(AObj).FValue.GetExtent := TGetExtentsFunc_sw.FromVar(
      AArgs[0]);
end;

class function TGridAxisDrawInfo_sw.GetTypeName: WideString;
begin
  Result := 'TGridAxisDrawInfo';
end;

function TGridAxisDrawInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TGridAxisDrawInfo_sw.Create;
  TGridAxisDrawInfo_sw(Result).FValue := FValue;
end;

class procedure TGridAxisDrawInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TGridAxisDrawInfo_Copy_si, TGridAxisDrawInfo_sw, 0);
  AData.AddField('EffectiveLineWidth', TGridAxisDrawInfo_EffectiveLineWidth_si, Integer_sw);
  AData.AddField('FixedBoundary', TGridAxisDrawInfo_FixedBoundary_si, Integer_sw);
  AData.AddField('GridBoundary', TGridAxisDrawInfo_GridBoundary_si, Integer_sw);
  AData.AddField('GridExtent', TGridAxisDrawInfo_GridExtent_si, Integer_sw);
  AData.AddField('LastFullVisibleCell', TGridAxisDrawInfo_LastFullVisibleCell_si, Longint_sw);
  AData.AddField('FullVisBoundary', TGridAxisDrawInfo_FullVisBoundary_si, Integer_sw);
  AData.AddField('FixedCellCount', TGridAxisDrawInfo_FixedCellCount_si, Integer_sw);
  AData.AddField('FirstGridCell', TGridAxisDrawInfo_FirstGridCell_si, Integer_sw);
  AData.AddField('GridCellCount', TGridAxisDrawInfo_GridCellCount_si, Integer_sw);
  AData.AddField('GetExtent', TGridAxisDrawInfo_GetExtent_si, TGetExtentsFunc_sw);

  { Class members }

  AData.AddConstructor('Create', TGridAxisDrawInfo_Create_si, 0);
end;

class function TGridAxisDrawInfo_sw.ToVar(
  const AValue: TGridAxisDrawInfo): OleVariant;
var
  wrpr: TGridAxisDrawInfo_sw;
begin
  wrpr        := TGridAxisDrawInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TGridAxisDrawInfo_sw.FromVar(
  const AValue: OleVariant): TGridAxisDrawInfo;
begin
  Result := TGridAxisDrawInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TGridDrawInfo_sw }

function TGridDrawInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TGridDrawInfo_sw.ToVar(TGridDrawInfo(AObj));
end;

function TGridDrawInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TGridDrawInfo_sw.Create as IDispatch;
end;

function TGridDrawInfo_Horz_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Horz: TGridAxisDrawInfo;

  if IsGet then
    Result := TGridAxisDrawInfo_sw.ToVar(TGridDrawInfo_sw(AObj).FValue.Horz)
  else
    TGridDrawInfo_sw(AObj).FValue.Horz := TGridAxisDrawInfo_sw.FromVar(
      AArgs[0]);
end;

function TGridDrawInfo_Vert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Vert: TGridAxisDrawInfo;

  if IsGet then
    Result := TGridAxisDrawInfo_sw.ToVar(TGridDrawInfo_sw(AObj).FValue.Vert)
  else
    TGridDrawInfo_sw(AObj).FValue.Vert := TGridAxisDrawInfo_sw.FromVar(
      AArgs[0]);
end;

class function TGridDrawInfo_sw.GetTypeName: WideString;
begin
  Result := 'TGridDrawInfo';
end;

function TGridDrawInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TGridDrawInfo_sw.Create;
  TGridDrawInfo_sw(Result).FValue := FValue;
end;

class procedure TGridDrawInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TGridDrawInfo_Copy_si, TGridDrawInfo_sw, 0);
  AData.AddField('Horz', TGridDrawInfo_Horz_si, TGridAxisDrawInfo_sw);
  AData.AddField('Vert', TGridDrawInfo_Vert_si, TGridAxisDrawInfo_sw);

  { Class members }

  AData.AddConstructor('Create', TGridDrawInfo_Create_si, 0);
end;

class function TGridDrawInfo_sw.ToVar(const AValue: TGridDrawInfo): OleVariant;
var
  wrpr: TGridDrawInfo_sw;
begin
  wrpr        := TGridDrawInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TGridDrawInfo_sw.FromVar(
  const AValue: OleVariant): TGridDrawInfo;
begin
  Result := TGridDrawInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TGridState_sw }

class function TGridState_sw.GetTypeName: WideString;
begin
  Result := 'TGridState';
end;

class function TGridState_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TGridState);
end;

class function TGridState_sw.ToVar(const AValue: TGridState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGridState_sw.FromVar(const AValue: OleVariant): TGridState;
begin
  Result := TGridState(Integer(AValue));
end;

{ TGridMovement_sw }

class function TGridMovement_sw.GetTypeName: WideString;
begin
  Result := 'TGridMovement';
end;

class function TGridMovement_sw.ToVar(const AValue: TGridMovement): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGridMovement_sw.FromVar(
  const AValue: OleVariant): TGridMovement;
begin
  Result := TGridMovement(Integer(AValue));
end;

{ TInplaceEdit_sw }

function TInplaceEdit_Grid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Grid: TCustomGrid read <getter>;

  Result := TCustomGrid_sw.ToVar(TInplaceEdit_sacc(TInplaceEdit(AObj)).Grid);
end;

function TInplaceEdit_Deselect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Deselect;

  TInplaceEdit(AObj).Deselect();
end;

function TInplaceEdit_Hide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Hide;

  TInplaceEdit(AObj).Hide();
end;

function TInplaceEdit_Invalidate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Invalidate;

  TInplaceEdit(AObj).Invalidate();
end;

function TInplaceEdit_Move_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Move(const Loc: TRect);

  TInplaceEdit(AObj).Move(TRect_sw.FromVar(AArgs[0]));
end;

function TInplaceEdit_PosEqual_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function PosEqual(const Rect: TRect): Boolean;

  Result := TInplaceEdit(AObj).PosEqual(TRect_sw.FromVar(AArgs[0]));
end;

function TInplaceEdit_SetFocus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetFocus;

  TInplaceEdit(AObj).SetFocus();
end;

function TInplaceEdit_UpdateLoc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UpdateLoc(const Loc: TRect);

  TInplaceEdit(AObj).UpdateLoc(TRect_sw.FromVar(AArgs[0]));
end;

function TInplaceEdit_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Visible: Boolean;

  Result := TInplaceEdit(AObj).Visible();
end;

class function TInplaceEdit_sw.GetTypeName: WideString;
begin
  Result := 'TInplaceEdit';
end;

class function TInplaceEdit_sw.GetWrappedClass: TClass;
begin
  Result := TInplaceEdit;
end;

class procedure TInplaceEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Grid', TInplaceEdit_Grid_si, TCustomGrid_sw, True, False, 0, True);
  AData.AddProcedure('Deselect', TInplaceEdit_Deselect_si, 0, False);
  AData.AddProcedure('Hide', TInplaceEdit_Hide_si, 0, False);
  AData.AddProcedure('Invalidate', TInplaceEdit_Invalidate_si, 0, False);
  AData.AddProcedure('Move', TInplaceEdit_Move_si, 1, False);
  AData.AddFunction('PosEqual', TInplaceEdit_PosEqual_si, Boolean_sw, 1, False);
  AData.AddProcedure('SetFocus', TInplaceEdit_SetFocus_si, 0, False);
  AData.AddProcedure('UpdateLoc', TInplaceEdit_UpdateLoc_si, 1, False);
  AData.AddFunction('Visible', TInplaceEdit_Visible_si, Boolean_sw, 0, False);
end;

class function TInplaceEdit_sw.ToVar(const AValue: TInplaceEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInplaceEdit_sw.FromVar(const AValue: OleVariant): TInplaceEdit;
begin
  Result := TInplaceEdit(ConvFromVar(AValue, TInplaceEdit));
end;

class function TInplaceEdit_sw.ClassToVar(AClass: TInplaceEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TInplaceEdit_sw.ClassFromVar(
  const AClass: OleVariant): TInplaceEdit_sc;
begin
  Result := TInplaceEdit_sc(ConvClsFromVar(AClass, TInplaceEdit));
end;

{ TGridOption_sw }

class function TGridOption_sw.GetTypeName: WideString;
begin
  Result := 'TGridOption';
end;

class function TGridOption_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TGridOption);
end;

class function TGridOption_sw.ToVar(const AValue: TGridOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGridOption_sw.FromVar(const AValue: OleVariant): TGridOption;
begin
  Result := TGridOption(Integer(AValue));
end;

{ TGridOptions_sw }

class function TGridOptions_sw.GetTypeName: WideString;
begin
  Result := 'TGridOptions';
end;

class function TGridOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TGridOptions);
end;

class function TGridOptions_sw.ToVar(const AValue: TGridOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TGridOptions_sw.FromVar(const AValue: OleVariant): TGridOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TGridCoord_sw }

function TGridCoord_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TGridCoord_sw.ToVar(TGridCoord(AObj));
end;

function TGridCoord_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TGridCoord_sw.Create as IDispatch;
end;

function TGridCoord_X_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var X: Longint;

  if IsGet then
    Result := TGridCoord_sw(AObj).FValue.X
  else
    TGridCoord_sw(AObj).FValue.X := Longint(AArgs[0]);
end;

function TGridCoord_Y_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Y: Longint;

  if IsGet then
    Result := TGridCoord_sw(AObj).FValue.Y
  else
    TGridCoord_sw(AObj).FValue.Y := Longint(AArgs[0]);
end;

class function TGridCoord_sw.GetTypeName: WideString;
begin
  Result := 'TGridCoord';
end;

function TGridCoord_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TGridCoord_sw.Create;
  TGridCoord_sw(Result).FValue := FValue;
end;

class procedure TGridCoord_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TGridCoord_Copy_si, TGridCoord_sw, 0);
  AData.AddField('X', TGridCoord_X_si, Longint_sw);
  AData.AddField('Y', TGridCoord_Y_si, Longint_sw);

  { Class members }

  AData.AddConstructor('Create', TGridCoord_Create_si, 0);
end;

class function TGridCoord_sw.ToVar(const AValue: TGridCoord): OleVariant;
var
  wrpr: TGridCoord_sw;
begin
  wrpr        := TGridCoord_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TGridCoord_sw.FromVar(const AValue: OleVariant): TGridCoord;
begin
  Result := TGridCoord_sw(ConvFromVar(AValue)).FValue;
end;

{ TGridRect_sw }

function TGridRect_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TGridRect_sw.ToVar(TGridRect(AObj));
end;

function TGridRect_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TGridRect_sw.Create as IDispatch;
end;

function TGridRect_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Left: Longint;

  if IsGet then
    Result := TGridRect_sw(AObj).FValue.Left
  else
    TGridRect_sw(AObj).FValue.Left := Longint(AArgs[0]);
end;

function TGridRect_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Top: Longint;

  if IsGet then
    Result := TGridRect_sw(AObj).FValue.Top
  else
    TGridRect_sw(AObj).FValue.Top := Longint(AArgs[0]);
end;

function TGridRect_Right_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Right: Longint;

  if IsGet then
    Result := TGridRect_sw(AObj).FValue.Right
  else
    TGridRect_sw(AObj).FValue.Right := Longint(AArgs[0]);
end;

function TGridRect_Bottom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Bottom: Longint;

  if IsGet then
    Result := TGridRect_sw(AObj).FValue.Bottom
  else
    TGridRect_sw(AObj).FValue.Bottom := Longint(AArgs[0]);
end;

function TGridRect_TopLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TopLeft: TGridCoord;

  if IsGet then
    Result := TGridCoord_sw.ToVar(TGridRect_sw(AObj).FValue.TopLeft)
  else
    TGridRect_sw(AObj).FValue.TopLeft := TGridCoord_sw.FromVar(AArgs[0]);
end;

function TGridRect_BottomRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BottomRight: TGridCoord;

  if IsGet then
    Result := TGridCoord_sw.ToVar(TGridRect_sw(AObj).FValue.BottomRight)
  else
    TGridRect_sw(AObj).FValue.BottomRight := TGridCoord_sw.FromVar(AArgs[0]);
end;

class function TGridRect_sw.GetTypeName: WideString;
begin
  Result := 'TGridRect';
end;

function TGridRect_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TGridRect_sw.Create;
  TGridRect_sw(Result).FValue := FValue;
end;

class procedure TGridRect_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TGridRect_Copy_si, TGridRect_sw, 0);
  AData.AddField('Left', TGridRect_Left_si, Longint_sw);
  AData.AddField('Top', TGridRect_Top_si, Longint_sw);
  AData.AddField('Right', TGridRect_Right_si, Longint_sw);
  AData.AddField('Bottom', TGridRect_Bottom_si, Longint_sw);
  AData.AddField('TopLeft', TGridRect_TopLeft_si, TGridCoord_sw);
  AData.AddField('BottomRight', TGridRect_BottomRight_si, TGridCoord_sw);

  { Class members }

  AData.AddConstructor('Create', TGridRect_Create_si, 0);
end;

class function TGridRect_sw.ToVar(const AValue: TGridRect): OleVariant;
var
  wrpr: TGridRect_sw;
begin
  wrpr        := TGridRect_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TGridRect_sw.FromVar(const AValue: OleVariant): TGridRect;
begin
  Result := TGridRect_sw(ConvFromVar(AValue)).FValue;
end;

{ TEditStyle_sw }

class function TEditStyle_sw.GetTypeName: WideString;
begin
  Result := 'TEditStyle';
end;

class function TEditStyle_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TEditStyle);
end;

class function TEditStyle_sw.ToVar(const AValue: TEditStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TEditStyle_sw.FromVar(const AValue: OleVariant): TEditStyle;
begin
  Result := TEditStyle(Integer(AValue));
end;

{ TSelectCellEvent_sh }

function TSelectCellEvent_sh.GetHandler: TMethod;
var
  hdr: TSelectCellEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TSelectCellEvent_sh.Handler(Sender: TObject; ACol: Longint;
  ARow: Longint; var CanSelect: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; ACol: Longint; ARow: Longint;...

  v_1 := CanSelect;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := ACol;
  args[2] := ARow;
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  CanSelect := Boolean(v_1);
end;

{ TSelectCellEvent_sw }

class function TSelectCellEvent_sw.GetTypeName: WideString;
begin
  Result := 'TSelectCellEvent';
end;

class function TSelectCellEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TSelectCellEvent_sh;
end;

class function TSelectCellEvent_sw.ToVar(
  const AValue: TSelectCellEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TSelectCellEvent_sw.FromVar(
  const AValue: OleVariant): TSelectCellEvent;
begin
  Result := TSelectCellEvent(ConvFromVar(AValue));
end;

class function TSelectCellEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TSelectCellEvent;
var
  hdlr: TSelectCellEvent_sh;
begin
  hdlr   := TSelectCellEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TSelectCellEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomGrid_sw }

function TCustomGrid_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BorderStyle: TBorderStyle read <getter...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TCustomGrid_sacc(TCustomGrid(AObj)).
      BorderStyle)
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).BorderStyle := TBorderStyle_sw.FromVar(
      AArgs[0]);
end;

function TCustomGrid_Col_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Col: Longint read <getter> write <sett...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).Col
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).Col := Longint(AArgs[0]);
end;

function TCustomGrid_ColCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ColCount: Longint read <getter> write ...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).ColCount
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).ColCount := Longint(AArgs[0]);
end;

function TCustomGrid_ColWidths_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ColWidths[Index: Longint]: Integer rea...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).ColWidths[Longint(AArgs[0])]
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).ColWidths[Longint(AArgs[0])] := Integer(
      AArgs[1]);
end;

function TCustomGrid_DefaultColWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DefaultColWidth: Integer read <getter>...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).DefaultColWidth
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).DefaultColWidth := Integer(AArgs[0]);
end;

function TCustomGrid_DefaultDrawing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DefaultDrawing: Boolean read <getter> ...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).DefaultDrawing
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).DefaultDrawing := Boolean(AArgs[0]);
end;

function TCustomGrid_DefaultRowHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DefaultRowHeight: Integer read <getter...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).DefaultRowHeight
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).DefaultRowHeight := Integer(AArgs[0]);
end;

function TCustomGrid_EditorMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property EditorMode: Boolean read <getter> writ...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).EditorMode
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).EditorMode := Boolean(AArgs[0]);
end;

function TCustomGrid_FixedColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FixedColor: TColor read <getter> write...

  if IsGet then
    Result := TColor_sw.ToVar(TCustomGrid_sacc(TCustomGrid(AObj)).FixedColor)
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).FixedColor := TColor_sw.FromVar(
      AArgs[0]);
end;

function TCustomGrid_FixedCols_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FixedCols: Integer read <getter> write...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).FixedCols
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).FixedCols := Integer(AArgs[0]);
end;

function TCustomGrid_FixedRows_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FixedRows: Integer read <getter> write...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).FixedRows
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).FixedRows := Integer(AArgs[0]);
end;

function TCustomGrid_GridHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property GridHeight: Integer read <getter>;

  Result := TCustomGrid_sacc(TCustomGrid(AObj)).GridHeight;
end;

function TCustomGrid_GridLineWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property GridLineWidth: Integer read <getter> w...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).GridLineWidth
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).GridLineWidth := Integer(AArgs[0]);
end;

function TCustomGrid_GridWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property GridWidth: Integer read <getter>;

  Result := TCustomGrid_sacc(TCustomGrid(AObj)).GridWidth;
end;

function TCustomGrid_HitTest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HitTest: TPoint read <getter>;

  Result := TPoint_sw.ToVar(TCustomGrid_sacc(TCustomGrid(AObj)).HitTest);
end;

function TCustomGrid_InplaceEditor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property InplaceEditor: TInplaceEdit read <gett...

  Result := TInplaceEdit_sw.ToVar(TCustomGrid_sacc(TCustomGrid(AObj)).
    InplaceEditor);
end;

function TCustomGrid_LeftCol_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property LeftCol: Longint read <getter> write <...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).LeftCol
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).LeftCol := Longint(AArgs[0]);
end;

function TCustomGrid_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Options: TGridOptions read <getter> wr...

  if IsGet then
    Result := TGridOptions_sw.ToVar(TCustomGrid_sacc(TCustomGrid(AObj)).Options)
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).Options := TGridOptions_sw.FromVar(
      AArgs[0]);
end;

function TCustomGrid_Row_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Row: Longint read <getter> write <sett...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).Row
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).Row := Longint(AArgs[0]);
end;

function TCustomGrid_RowCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property RowCount: Longint read <getter> write ...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).RowCount
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).RowCount := Longint(AArgs[0]);
end;

function TCustomGrid_RowHeights_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property RowHeights[Index: Longint]: Integer re...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).RowHeights[Longint(AArgs[0])]
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).RowHeights[Longint(AArgs[0])] := 
      Integer(AArgs[1]);
end;

function TCustomGrid_ScrollBars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ScrollBars: TScrollStyle read <getter>...

  if IsGet then
    Result := TScrollStyle_sw.ToVar(TCustomGrid_sacc(TCustomGrid(AObj)).
      ScrollBars)
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).ScrollBars := TScrollStyle_sw.FromVar(
      AArgs[0]);
end;

function TCustomGrid_Selection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Selection: TGridRect read <getter> wri...

  if IsGet then
    Result := TGridRect_sw.ToVar(TCustomGrid_sacc(TCustomGrid(AObj)).Selection)
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).Selection := TGridRect_sw.FromVar(
      AArgs[0]);
end;

function TCustomGrid_TabStops_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TabStops[Index: Longint]: Boolean read...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).TabStops[Longint(AArgs[0])]
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).TabStops[Longint(AArgs[0])] := Boolean(
      AArgs[1]);
end;

function TCustomGrid_TopRow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TopRow: Longint read <getter> write <s...

  if IsGet then
    Result := TCustomGrid_sacc(TCustomGrid(AObj)).TopRow
  else
    TCustomGrid_sacc(TCustomGrid(AObj)).TopRow := Longint(AArgs[0]);
end;

function TCustomGrid_VisibleColCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property VisibleColCount: Integer read <getter>;

  Result := TCustomGrid_sacc(TCustomGrid(AObj)).VisibleColCount;
end;

function TCustomGrid_VisibleRowCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property VisibleRowCount: Integer read <getter>;

  Result := TCustomGrid_sacc(TCustomGrid(AObj)).VisibleRowCount;
end;

function TCustomGrid_MouseCoord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MouseCoord(X: Integer; Y: Integer): TGridCoord;

  Result := TGridCoord_sw.ToVar(TCustomGrid(AObj).MouseCoord(Integer(AArgs[0]), 
    Integer(AArgs[1])));
end;

class function TCustomGrid_sw.GetTypeName: WideString;
begin
  Result := 'TCustomGrid';
end;

class function TCustomGrid_sw.GetWrappedClass: TClass;
begin
  Result := TCustomGrid;
end;

class procedure TCustomGrid_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('BorderStyle', TCustomGrid_BorderStyle_si, TBorderStyle_sw, True, True, 0, True);
  AData.AddProperty('Col', TCustomGrid_Col_si, Longint_sw, True, True, 0, True);
  AData.AddProperty('ColCount', TCustomGrid_ColCount_si, Longint_sw, True, True, 0, True);
  AData.AddProperty('ColWidths', TCustomGrid_ColWidths_si, Integer_sw, True, True, 1, True);
  AData.AddProperty('DefaultColWidth', TCustomGrid_DefaultColWidth_si, Integer_sw, True, True, 0, True);
  AData.AddProperty('DefaultDrawing', TCustomGrid_DefaultDrawing_si, Boolean_sw, True, True, 0, True);
  AData.AddProperty('DefaultRowHeight', TCustomGrid_DefaultRowHeight_si, Integer_sw, True, True, 0, True);
  AData.AddProperty('EditorMode', TCustomGrid_EditorMode_si, Boolean_sw, True, True, 0, True);
  AData.AddProperty('FixedColor', TCustomGrid_FixedColor_si, TColor_sw, True, True, 0, True);
  AData.AddProperty('FixedCols', TCustomGrid_FixedCols_si, Integer_sw, True, True, 0, True);
  AData.AddProperty('FixedRows', TCustomGrid_FixedRows_si, Integer_sw, True, True, 0, True);
  AData.AddProperty('GridHeight', TCustomGrid_GridHeight_si, Integer_sw, True, False, 0, True);
  AData.AddProperty('GridLineWidth', TCustomGrid_GridLineWidth_si, Integer_sw, True, True, 0, True);
  AData.AddProperty('GridWidth', TCustomGrid_GridWidth_si, Integer_sw, True, False, 0, True);
  AData.AddProperty('HitTest', TCustomGrid_HitTest_si, TPoint_sw, True, False, 0, True);
  AData.AddProperty('InplaceEditor', TCustomGrid_InplaceEditor_si, TInplaceEdit_sw, True, False, 0, True);
  AData.AddProperty('LeftCol', TCustomGrid_LeftCol_si, Longint_sw, True, True, 0, True);
  AData.AddProperty('Options', TCustomGrid_Options_si, TGridOptions_sw, True, True, 0, True);
  AData.AddProperty('Row', TCustomGrid_Row_si, Longint_sw, True, True, 0, True);
  AData.AddProperty('RowCount', TCustomGrid_RowCount_si, Longint_sw, True, True, 0, True);
  AData.AddProperty('RowHeights', TCustomGrid_RowHeights_si, Integer_sw, True, True, 1, True);
  AData.AddProperty('ScrollBars', TCustomGrid_ScrollBars_si, TScrollStyle_sw, True, True, 0, True);
  AData.AddProperty('Selection', TCustomGrid_Selection_si, TGridRect_sw, True, True, 0, True);
  AData.AddProperty('TabStops', TCustomGrid_TabStops_si, Boolean_sw, True, True, 1, True);
  AData.AddProperty('TopRow', TCustomGrid_TopRow_si, Longint_sw, True, True, 0, True);
  AData.AddProperty('VisibleColCount', TCustomGrid_VisibleColCount_si, Integer_sw, True, False, 0, True);
  AData.AddProperty('VisibleRowCount', TCustomGrid_VisibleRowCount_si, Integer_sw, True, False, 0, True);
  AData.AddFunction('MouseCoord', TCustomGrid_MouseCoord_si, TGridCoord_sw, 2, False);
  AData.AddPropertyRedecl('TabStop');
end;

class function TCustomGrid_sw.ToVar(const AValue: TCustomGrid): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomGrid_sw.FromVar(const AValue: OleVariant): TCustomGrid;
begin
  Result := TCustomGrid(ConvFromVar(AValue, TCustomGrid));
end;

class function TCustomGrid_sw.ClassToVar(AClass: TCustomGrid_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomGrid_sw.ClassFromVar(
  const AClass: OleVariant): TCustomGrid_sc;
begin
  Result := TCustomGrid_sc(ConvClsFromVar(AClass, TCustomGrid));
end;

{ TGetEditEvent_sh }

function TGetEditEvent_sh.GetHandler: TMethod;
var
  hdr: TGetEditEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetEditEvent_sh.Handler(Sender: TObject; ACol: Longint;
  ARow: Longint; var Value: string);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; ACol: Longint; ARow: Longint;...

  v_1 := Value;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := ACol;
  args[2] := ARow;
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Value := string(v_1);
end;

{ TGetEditEvent_sw }

class function TGetEditEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetEditEvent';
end;

class function TGetEditEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetEditEvent_sh;
end;

class function TGetEditEvent_sw.ToVar(const AValue: TGetEditEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetEditEvent_sw.FromVar(
  const AValue: OleVariant): TGetEditEvent;
begin
  Result := TGetEditEvent(ConvFromVar(AValue));
end;

class function TGetEditEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetEditEvent;
var
  hdlr: TGetEditEvent_sh;
begin
  hdlr   := TGetEditEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetEditEvent_sw));
  Result := hdlr.Handler;
end;

{ TSetEditEvent_sh }

function TSetEditEvent_sh.GetHandler: TMethod;
var
  hdr: TSetEditEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TSetEditEvent_sh.Handler(Sender: TObject; ACol: Longint;
  ARow: Longint; const Value: string);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (Sender: TObject; ACol: Longint; ARow: Longint;...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := ACol;
  args[2] := ARow;
  args[3] := Value;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TSetEditEvent_sw }

class function TSetEditEvent_sw.GetTypeName: WideString;
begin
  Result := 'TSetEditEvent';
end;

class function TSetEditEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TSetEditEvent_sh;
end;

class function TSetEditEvent_sw.ToVar(const AValue: TSetEditEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TSetEditEvent_sw.FromVar(
  const AValue: OleVariant): TSetEditEvent;
begin
  Result := TSetEditEvent(ConvFromVar(AValue));
end;

class function TSetEditEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TSetEditEvent;
var
  hdlr: TSetEditEvent_sh;
begin
  hdlr   := TSetEditEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TSetEditEvent_sw));
  Result := hdlr.Handler;
end;

{ TMovedEvent_sh }

function TMovedEvent_sh.GetHandler: TMethod;
var
  hdr: TMovedEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TMovedEvent_sh.Handler(Sender: TObject; FromIndex: Longint;
  ToIndex: Longint);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (Sender: TObject; FromIndex: Longint; ToIndex: ...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := FromIndex;
  args[2] := ToIndex;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TMovedEvent_sw }

class function TMovedEvent_sw.GetTypeName: WideString;
begin
  Result := 'TMovedEvent';
end;

class function TMovedEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TMovedEvent_sh;
end;

class function TMovedEvent_sw.ToVar(const AValue: TMovedEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TMovedEvent_sw.FromVar(const AValue: OleVariant): TMovedEvent;
begin
  Result := TMovedEvent(ConvFromVar(AValue));
end;

class function TMovedEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TMovedEvent;
var
  hdlr: TMovedEvent_sh;
begin
  hdlr   := TMovedEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TMovedEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomDrawGrid_sw }

function TCustomDrawGrid_OnColumnMoved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnColumnMoved: TMovedEvent read <gette...

  if IsGet then
    Result := TMovedEvent_sw.ToVar(TCustomDrawGrid_sacc(TCustomDrawGrid(AObj)).
      OnColumnMoved)
  else
    TCustomDrawGrid_sacc(TCustomDrawGrid(AObj)).OnColumnMoved := TMovedEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomDrawGrid_OnGetEditMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetEditMask: TGetEditEvent read <get...

  if IsGet then
    Result := TGetEditEvent_sw.ToVar(TCustomDrawGrid_sacc(TCustomDrawGrid(
      AObj)).OnGetEditMask)
  else
    TCustomDrawGrid_sacc(TCustomDrawGrid(AObj)).OnGetEditMask := 
      TGetEditEvent_sw.FromVar(AArgs[0]);
end;

function TCustomDrawGrid_OnGetEditText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetEditText: TGetEditEvent read <get...

  if IsGet then
    Result := TGetEditEvent_sw.ToVar(TCustomDrawGrid_sacc(TCustomDrawGrid(
      AObj)).OnGetEditText)
  else
    TCustomDrawGrid_sacc(TCustomDrawGrid(AObj)).OnGetEditText := 
      TGetEditEvent_sw.FromVar(AArgs[0]);
end;

function TCustomDrawGrid_OnRowMoved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnRowMoved: TMovedEvent read <getter> ...

  if IsGet then
    Result := TMovedEvent_sw.ToVar(TCustomDrawGrid_sacc(TCustomDrawGrid(AObj)).
      OnRowMoved)
  else
    TCustomDrawGrid_sacc(TCustomDrawGrid(AObj)).OnRowMoved := TMovedEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomDrawGrid_OnSelectCell_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnSelectCell: TSelectCellEvent read <g...

  if IsGet then
    Result := TSelectCellEvent_sw.ToVar(TCustomDrawGrid_sacc(TCustomDrawGrid(
      AObj)).OnSelectCell)
  else
    TCustomDrawGrid_sacc(TCustomDrawGrid(AObj)).OnSelectCell := 
      TSelectCellEvent_sw.FromVar(AArgs[0]);
end;

function TCustomDrawGrid_OnSetEditText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnSetEditText: TSetEditEvent read <get...

  if IsGet then
    Result := TSetEditEvent_sw.ToVar(TCustomDrawGrid_sacc(TCustomDrawGrid(
      AObj)).OnSetEditText)
  else
    TCustomDrawGrid_sacc(TCustomDrawGrid(AObj)).OnSetEditText := 
      TSetEditEvent_sw.FromVar(AArgs[0]);
end;

function TCustomDrawGrid_OnTopLeftChanged_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnTopLeftChanged: TNotifyEvent read <g...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomDrawGrid_sacc(TCustomDrawGrid(AObj)).
      OnTopLeftChanged)
  else
    TCustomDrawGrid_sacc(TCustomDrawGrid(AObj)).OnTopLeftChanged := 
      TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomDrawGrid_CellRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CellRect(ACol: Longint; ARow: Longint): TRect;

  Result := TRect_sw.ToVar(TCustomDrawGrid(AObj).CellRect(Longint(AArgs[0]), 
    Longint(AArgs[1])));
end;

function TCustomDrawGrid_MouseToCell_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Longint;
  v_2: Longint;
begin
  // procedure MouseToCell(X: Integer; Y: Integer; var ACol: L...

  v_1 := Longint(AArgs[2]);
  v_2 := Longint(AArgs[3]);
  TCustomDrawGrid(AObj).MouseToCell(Integer(AArgs[0]), Integer(AArgs[1]), v_1, 
    v_2);
  AssignRefParam(AArgs[2], v_1);
  AssignRefParam(AArgs[3], v_2);
end;

class function TCustomDrawGrid_sw.GetTypeName: WideString;
begin
  Result := 'TCustomDrawGrid';
end;

class function TCustomDrawGrid_sw.GetWrappedClass: TClass;
begin
  Result := TCustomDrawGrid;
end;

class procedure TCustomDrawGrid_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('OnColumnMoved', TCustomDrawGrid_OnColumnMoved_si, TMovedEvent_sw, True, True, 0, True);
  AData.AddProperty('OnGetEditMask', TCustomDrawGrid_OnGetEditMask_si, TGetEditEvent_sw, True, True, 0, True);
  AData.AddProperty('OnGetEditText', TCustomDrawGrid_OnGetEditText_si, TGetEditEvent_sw, True, True, 0, True);
  AData.AddProperty('OnRowMoved', TCustomDrawGrid_OnRowMoved_si, TMovedEvent_sw, True, True, 0, True);
  AData.AddProperty('OnSelectCell', TCustomDrawGrid_OnSelectCell_si, TSelectCellEvent_sw, True, True, 0, True);
  AData.AddProperty('OnSetEditText', TCustomDrawGrid_OnSetEditText_si, TSetEditEvent_sw, True, True, 0, True);
  AData.AddProperty('OnTopLeftChanged', TCustomDrawGrid_OnTopLeftChanged_si, TNotifyEvent_sw, True, True, 0, True);
  AData.AddFunction('CellRect', TCustomDrawGrid_CellRect_si, TRect_sw, 2, False);
  AData.AddProcedure('MouseToCell', TCustomDrawGrid_MouseToCell_si, 4, False);
  AData.AddPropertyRedecl('Canvas');
  AData.AddPropertyRedecl('Col');
  AData.AddPropertyRedecl('ColWidths');
  AData.AddPropertyRedecl('EditorMode');
  AData.AddPropertyRedecl('GridHeight');
  AData.AddPropertyRedecl('GridWidth');
  AData.AddPropertyRedecl('LeftCol');
  AData.AddPropertyRedecl('Selection');
  AData.AddPropertyRedecl('Row');
  AData.AddPropertyRedecl('RowHeights');
  AData.AddPropertyRedecl('TabStops');
  AData.AddPropertyRedecl('TopRow');
end;

class function TCustomDrawGrid_sw.ToVar(
  const AValue: TCustomDrawGrid): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomDrawGrid_sw.FromVar(
  const AValue: OleVariant): TCustomDrawGrid;
begin
  Result := TCustomDrawGrid(ConvFromVar(AValue, TCustomDrawGrid));
end;

class function TCustomDrawGrid_sw.ClassToVar(
  AClass: TCustomDrawGrid_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomDrawGrid_sw.ClassFromVar(
  const AClass: OleVariant): TCustomDrawGrid_sc;
begin
  Result := TCustomDrawGrid_sc(ConvClsFromVar(AClass, TCustomDrawGrid));
end;

{ TDrawGrid_sw }

class function TDrawGrid_sw.GetTypeName: WideString;
begin
  Result := 'TDrawGrid';
end;

class function TDrawGrid_sw.GetWrappedClass: TClass;
begin
  Result := TDrawGrid;
end;

class procedure TDrawGrid_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align');
  AData.AddPropertyRedecl('Anchors');
  AData.AddPropertyRedecl('BevelEdges');
  AData.AddPropertyRedecl('BevelInner');
  AData.AddPropertyRedecl('BevelKind');
  AData.AddPropertyRedecl('BevelOuter');
  AData.AddPropertyRedecl('BevelWidth');
  AData.AddPropertyRedecl('BiDiMode');
  AData.AddPropertyRedecl('BorderStyle');
  AData.AddPropertyRedecl('Color');
  AData.AddPropertyRedecl('ColCount');
  AData.AddPropertyRedecl('Constraints');
  AData.AddPropertyRedecl('Ctl3D');
  AData.AddPropertyRedecl('DefaultColWidth');
  AData.AddPropertyRedecl('DefaultRowHeight');
  AData.AddPropertyRedecl('DefaultDrawing');
  AData.AddPropertyRedecl('DragCursor');
  AData.AddPropertyRedecl('DragKind');
  AData.AddPropertyRedecl('DragMode');
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('FixedColor');
  AData.AddPropertyRedecl('FixedCols');
  AData.AddPropertyRedecl('RowCount');
  AData.AddPropertyRedecl('FixedRows');
  AData.AddPropertyRedecl('Font');
  AData.AddPropertyRedecl('GridLineWidth');
  AData.AddPropertyRedecl('Options');
  AData.AddPropertyRedecl('ParentBiDiMode');
  AData.AddPropertyRedecl('ParentColor');
  AData.AddPropertyRedecl('ParentCtl3D');
  AData.AddPropertyRedecl('ParentFont');
  AData.AddPropertyRedecl('ParentShowHint');
  AData.AddPropertyRedecl('PopupMenu');
  AData.AddPropertyRedecl('ScrollBars');
  AData.AddPropertyRedecl('ShowHint');
  AData.AddPropertyRedecl('TabOrder');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('VisibleColCount');
  AData.AddPropertyRedecl('VisibleRowCount');
  AData.AddPropertyRedecl('OnClick');
  AData.AddPropertyRedecl('OnColumnMoved');
  AData.AddPropertyRedecl('OnContextPopup');
  AData.AddPropertyRedecl('OnDblClick');
  AData.AddPropertyRedecl('OnDragDrop');
  AData.AddPropertyRedecl('OnDragOver');
  AData.AddPropertyRedecl('OnDrawCell');
  AData.AddPropertyRedecl('OnEndDock');
  AData.AddPropertyRedecl('OnEndDrag');
  AData.AddPropertyRedecl('OnEnter');
  AData.AddPropertyRedecl('OnExit');
  AData.AddPropertyRedecl('OnGetEditMask');
  AData.AddPropertyRedecl('OnGetEditText');
  AData.AddPropertyRedecl('OnKeyDown');
  AData.AddPropertyRedecl('OnKeyPress');
  AData.AddPropertyRedecl('OnKeyUp');
  AData.AddPropertyRedecl('OnMouseActivate');
  AData.AddPropertyRedecl('OnMouseDown');
  AData.AddPropertyRedecl('OnMouseEnter');
  AData.AddPropertyRedecl('OnMouseLeave');
  AData.AddPropertyRedecl('OnMouseMove');
  AData.AddPropertyRedecl('OnMouseUp');
  AData.AddPropertyRedecl('OnMouseWheelDown');
  AData.AddPropertyRedecl('OnMouseWheelUp');
  AData.AddPropertyRedecl('OnRowMoved');
  AData.AddPropertyRedecl('OnSelectCell');
  AData.AddPropertyRedecl('OnSetEditText');
  AData.AddPropertyRedecl('OnStartDock');
  AData.AddPropertyRedecl('OnStartDrag');
  AData.AddPropertyRedecl('OnTopLeftChanged');
end;

class function TDrawGrid_sw.ToVar(const AValue: TDrawGrid): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDrawGrid_sw.FromVar(const AValue: OleVariant): TDrawGrid;
begin
  Result := TDrawGrid(ConvFromVar(AValue, TDrawGrid));
end;

class function TDrawGrid_sw.ClassToVar(AClass: TDrawGrid_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDrawGrid_sw.ClassFromVar(
  const AClass: OleVariant): TDrawGrid_sc;
begin
  Result := TDrawGrid_sc(ConvClsFromVar(AClass, TDrawGrid));
end;

{ TStringGridStrings_sw }

function TStringGridStrings_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AGrid: TStringGrid; AIndex: Longint);

  Result := TStringGridStrings_sw.ToVar(TStringGridStrings_sc(AObj).Create(
    TStringGrid_sw.FromVar(AArgs[0]), Longint(AArgs[1])));
end;

class function TStringGridStrings_sw.GetTypeName: WideString;
begin
  Result := 'TStringGridStrings';
end;

class function TStringGridStrings_sw.GetWrappedClass: TClass;
begin
  Result := TStringGridStrings;
end;

class procedure TStringGridStrings_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TStringGridStrings_Create_si, 2, False);
end;

class function TStringGridStrings_sw.ToVar(
  const AValue: TStringGridStrings): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStringGridStrings_sw.FromVar(
  const AValue: OleVariant): TStringGridStrings;
begin
  Result := TStringGridStrings(ConvFromVar(AValue, TStringGridStrings));
end;

class function TStringGridStrings_sw.ClassToVar(
  AClass: TStringGridStrings_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStringGridStrings_sw.ClassFromVar(
  const AClass: OleVariant): TStringGridStrings_sc;
begin
  Result := TStringGridStrings_sc(ConvClsFromVar(AClass, TStringGridStrings));
end;

{ TStringGrid_sw }

function TStringGrid_Cells_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Cells[ACol: Integer; ARow: Integer]: string read...

  if IsGet then
    Result := TStringGrid(AObj).Cells[Integer(AArgs[0]), Integer(AArgs[1])]
  else
    TStringGrid(AObj).Cells[Integer(AArgs[0]), Integer(AArgs[1])] := string(
      AArgs[2]);
end;

function TStringGrid_Cols_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Cols[Index: Integer]: TStrings read <getter> wri...

  if IsGet then
    Result := TStrings_sw.ToVar(TStringGrid(AObj).Cols[Integer(AArgs[0])])
  else
    TStringGrid(AObj).Cols[Integer(AArgs[0])] := TStrings_sw.FromVar(AArgs[1]);
end;

function TStringGrid_Objects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Objects[ACol: Integer; ARow: Integer]: TObject r...

  if IsGet then
    Result := TObject_sw.ToVar(TStringGrid(AObj).Objects[Integer(AArgs[0]), 
      Integer(AArgs[1])])
  else
    TStringGrid(AObj).Objects[Integer(AArgs[0]), Integer(AArgs[1])] := 
      TObject_sw.FromVar(AArgs[2]);
end;

function TStringGrid_Rows_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Rows[Index: Integer]: TStrings read <getter> wri...

  if IsGet then
    Result := TStrings_sw.ToVar(TStringGrid(AObj).Rows[Integer(AArgs[0])])
  else
    TStringGrid(AObj).Rows[Integer(AArgs[0])] := TStrings_sw.FromVar(AArgs[1]);
end;

class function TStringGrid_sw.GetTypeName: WideString;
begin
  Result := 'TStringGrid';
end;

class function TStringGrid_sw.GetWrappedClass: TClass;
begin
  Result := TStringGrid;
end;

class procedure TStringGrid_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Cells', TStringGrid_Cells_si, string_sw, True, True, 2, False);
  AData.AddProperty('Cols', TStringGrid_Cols_si, TStrings_sw, True, True, 1, False);
  AData.AddProperty('Objects', TStringGrid_Objects_si, TObject_sw, True, True, 2, False);
  AData.AddProperty('Rows', TStringGrid_Rows_si, TStrings_sw, True, True, 1, False);
end;

class function TStringGrid_sw.ToVar(const AValue: TStringGrid): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStringGrid_sw.FromVar(const AValue: OleVariant): TStringGrid;
begin
  Result := TStringGrid(ConvFromVar(AValue, TStringGrid));
end;

class function TStringGrid_sw.ClassToVar(AClass: TStringGrid_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStringGrid_sw.ClassFromVar(
  const AClass: OleVariant): TStringGrid_sc;
begin
  Result := TStringGrid_sc(ConvClsFromVar(AClass, TStringGrid));
end;

{ TOnGetPickListItems_sh }

function TOnGetPickListItems_sh.GetHandler: TMethod;
var
  hdr: TOnGetPickListItems;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TOnGetPickListItems_sh.Handler(ACol: Integer; ARow: Integer;
  Items: TStrings);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (ACol: Integer; ARow: Integer; Items: TStrings)...

  args[0] := ACol;
  args[1] := ARow;
  args[2] := TStrings_sw.ToVar(Items);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TOnGetPickListItems_sw }

class function TOnGetPickListItems_sw.GetTypeName: WideString;
begin
  Result := 'TOnGetPickListItems';
end;

class function TOnGetPickListItems_sw.GetScriptHandlerClass: TClass;
begin
  Result := TOnGetPickListItems_sh;
end;

class function TOnGetPickListItems_sw.ToVar(
  const AValue: TOnGetPickListItems): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TOnGetPickListItems_sw.FromVar(
  const AValue: OleVariant): TOnGetPickListItems;
begin
  Result := TOnGetPickListItems(ConvFromVar(AValue));
end;

class function TOnGetPickListItems_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TOnGetPickListItems;
var
  hdlr: TOnGetPickListItems_sh;
begin
  hdlr   := TOnGetPickListItems_sh(AScriptControl.GetEventHandler(AProcName, 
    TOnGetPickListItems_sw));
  Result := hdlr.Handler;
end;

{ TInplaceEditList_sw }

function TInplaceEditList_RestoreContents_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RestoreContents;

  TInplaceEditList(AObj).RestoreContents();
end;

function TInplaceEditList_ActiveList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveList: TWinControl read <getter> write <set...

  if IsGet then
    Result := TWinControl_sw.ToVar(TInplaceEditList(AObj).ActiveList)
  else
    TInplaceEditList(AObj).ActiveList := TWinControl_sw.FromVar(AArgs[0]);
end;

function TInplaceEditList_ButtonWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ButtonWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TInplaceEditList(AObj).ButtonWidth
  else
    TInplaceEditList(AObj).ButtonWidth := Integer(AArgs[0]);
end;

function TInplaceEditList_DropDownRows_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropDownRows: Integer read <getter> write <setter>;

  if IsGet then
    Result := TInplaceEditList(AObj).DropDownRows
  else
    TInplaceEditList(AObj).DropDownRows := Integer(AArgs[0]);
end;

function TInplaceEditList_EditStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EditStyle: TEditStyle read <getter>;

  Result := TEditStyle_sw.ToVar(TInplaceEditList(AObj).EditStyle);
end;

function TInplaceEditList_ListVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ListVisible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TInplaceEditList(AObj).ListVisible
  else
    TInplaceEditList(AObj).ListVisible := Boolean(AArgs[0]);
end;

function TInplaceEditList_PickList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PickList: TCustomListbox read <getter>;

  Result := TCustomListbox_sw.ToVar(TInplaceEditList(AObj).PickList);
end;

function TInplaceEditList_PickListLoaded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PickListLoaded: Boolean read <getter> write <set...

  if IsGet then
    Result := TInplaceEditList(AObj).PickListLoaded
  else
    TInplaceEditList(AObj).PickListLoaded := Boolean(AArgs[0]);
end;

function TInplaceEditList_Pressed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Pressed: Boolean read <getter>;

  Result := TInplaceEditList(AObj).Pressed;
end;

function TInplaceEditList_OnEditButtonClick_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnEditButtonClick: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TInplaceEditList(AObj).OnEditButtonClick)
  else
    TInplaceEditList(AObj).OnEditButtonClick := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TInplaceEditList_OnGetPickListitems_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetPickListitems: TOnGetPickListItems read <ge...

  if IsGet then
    Result := TOnGetPickListItems_sw.ToVar(TInplaceEditList(AObj).
      OnGetPickListitems)
  else
    TInplaceEditList(AObj).OnGetPickListitems := TOnGetPickListItems_sw.FromVar(
      AArgs[0]);
end;

class function TInplaceEditList_sw.GetTypeName: WideString;
begin
  Result := 'TInplaceEditList';
end;

class function TInplaceEditList_sw.GetWrappedClass: TClass;
begin
  Result := TInplaceEditList;
end;

class procedure TInplaceEditList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('RestoreContents', TInplaceEditList_RestoreContents_si, 0, False);
  AData.AddProperty('ActiveList', TInplaceEditList_ActiveList_si, TWinControl_sw, True, True, 0, False);
  AData.AddProperty('ButtonWidth', TInplaceEditList_ButtonWidth_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('DropDownRows', TInplaceEditList_DropDownRows_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('EditStyle', TInplaceEditList_EditStyle_si, TEditStyle_sw, True, False, 0, False);
  AData.AddProperty('ListVisible', TInplaceEditList_ListVisible_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('PickList', TInplaceEditList_PickList_si, TCustomListbox_sw, True, False, 0, False);
  AData.AddProperty('PickListLoaded', TInplaceEditList_PickListLoaded_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('Pressed', TInplaceEditList_Pressed_si, Boolean_sw, True, False, 0, False);
  AData.AddProperty('OnEditButtonClick', TInplaceEditList_OnEditButtonClick_si, TNotifyEvent_sw, True, True, 0, False);
  AData.AddProperty('OnGetPickListitems', TInplaceEditList_OnGetPickListitems_si, TOnGetPickListItems_sw, True, True, 0, False);
end;

class function TInplaceEditList_sw.ToVar(
  const AValue: TInplaceEditList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInplaceEditList_sw.FromVar(
  const AValue: OleVariant): TInplaceEditList;
begin
  Result := TInplaceEditList(ConvFromVar(AValue, TInplaceEditList));
end;

class function TInplaceEditList_sw.ClassToVar(
  AClass: TInplaceEditList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TInplaceEditList_sw.ClassFromVar(
  const AClass: OleVariant): TInplaceEditList_sc;
begin
  Result := TInplaceEditList_sc(ConvClsFromVar(AClass, TInplaceEditList));
end;

{ Grids_sw }

function Grids_EInvalidGridOperation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EInvalidGridOperation = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EInvalidGridOperation_sw);
end;

function Grids_TGetExtentsFunc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetExtentsFunc = function (Index: Longint): Integer...

  Result := TLMDUnitWrapper.TypeToVar(TGetExtentsFunc_sw);
end;

function Grids_TGridAxisDrawInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGridAxisDrawInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TGridAxisDrawInfo_sw);
end;

function Grids_TGridDrawInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGridDrawInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TGridDrawInfo_sw);
end;

function Grids_TGridState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGridState = (gsSelecting, gsRowSizing, gsColSizing,...

  Result := TLMDUnitWrapper.TypeToVar(TGridState_sw);
end;

function Grids_TGridMovement_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGridMovement = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TGridMovement_sw);
end;

function Grids_TInplaceEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInplaceEdit = class(TCustomMaskEdit);

  Result := TLMDUnitWrapper.TypeToVar(TInplaceEdit_sw);
end;

function Grids_TGridOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGridOption = (goFixedHorzLine, goVertLine, goHorzLi...

  Result := TLMDUnitWrapper.TypeToVar(TGridOption_sw);
end;

function Grids_TGridOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGridOptions = set of TGridOption;

  Result := TLMDUnitWrapper.TypeToVar(TGridOptions_sw);
end;

function Grids_TGridCoord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGridCoord = record;

  Result := TLMDUnitWrapper.TypeToVar(TGridCoord_sw);
end;

function Grids_TGridRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGridRect = record;

  Result := TLMDUnitWrapper.TypeToVar(TGridRect_sw);
end;

function Grids_TEditStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditStyle = (esEllipsis, esPickList);

  Result := TLMDUnitWrapper.TypeToVar(TEditStyle_sw);
end;

function Grids_TSelectCellEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSelectCellEvent = procedure (Sender: TObject; ACol:...

  Result := TLMDUnitWrapper.TypeToVar(TSelectCellEvent_sw);
end;

function Grids_TCustomGrid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomGrid = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomGrid_sw);
end;

function Grids_TGetEditEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetEditEvent = procedure (Sender: TObject; ACol: Lo...

  Result := TLMDUnitWrapper.TypeToVar(TGetEditEvent_sw);
end;

function Grids_TSetEditEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSetEditEvent = procedure (Sender: TObject; ACol: Lo...

  Result := TLMDUnitWrapper.TypeToVar(TSetEditEvent_sw);
end;

function Grids_TMovedEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMovedEvent = procedure (Sender: TObject; FromIndex:...

  Result := TLMDUnitWrapper.TypeToVar(TMovedEvent_sw);
end;

function Grids_TCustomDrawGrid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomDrawGrid = class(TCustomGrid);

  Result := TLMDUnitWrapper.TypeToVar(TCustomDrawGrid_sw);
end;

function Grids_TDrawGrid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDrawGrid = class(TCustomDrawGrid);

  Result := TLMDUnitWrapper.TypeToVar(TDrawGrid_sw);
end;

function Grids_TStringGridStrings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringGridStrings = class(TStrings);

  Result := TLMDUnitWrapper.TypeToVar(TStringGridStrings_sw);
end;

function Grids_TStringGrid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringGrid = class(TDrawGrid);

  Result := TLMDUnitWrapper.TypeToVar(TStringGrid_sw);
end;

function Grids_TOnGetPickListItems_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOnGetPickListItems = procedure (ACol: Integer; ARow...

  Result := TLMDUnitWrapper.TypeToVar(TOnGetPickListItems_sw);
end;

function Grids_TInplaceEditList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInplaceEditList = class(TInPlaceEdit);

  Result := TLMDUnitWrapper.TypeToVar(TInplaceEditList_sw);
end;

class function Grids_sw.GetUnitName: WideString;
begin
  Result := 'Grids';
end;

class procedure Grids_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(EInvalidGridOperation_sw, Grids_EInvalidGridOperation_si);
  AData.AddType(TGetExtentsFunc_sw, Grids_TGetExtentsFunc_si);
  AData.AddType(TGridAxisDrawInfo_sw, Grids_TGridAxisDrawInfo_si);
  AData.AddType(TGridDrawInfo_sw, Grids_TGridDrawInfo_si);
  AData.AddType(TGridState_sw, Grids_TGridState_si);
  AData.AddType(TGridMovement_sw, Grids_TGridMovement_si);
  AData.AddType(TInplaceEdit_sw, Grids_TInplaceEdit_si);
  AData.AddType(TGridOption_sw, Grids_TGridOption_si);
  AData.AddType(TGridOptions_sw, Grids_TGridOptions_si);
  AData.AddType(TGridCoord_sw, Grids_TGridCoord_si);
  AData.AddType(TGridRect_sw, Grids_TGridRect_si);
  AData.AddType(TEditStyle_sw, Grids_TEditStyle_si);
  AData.AddType(TSelectCellEvent_sw, Grids_TSelectCellEvent_si);
  AData.AddType(TCustomGrid_sw, Grids_TCustomGrid_si);
  AData.AddType(TGetEditEvent_sw, Grids_TGetEditEvent_si);
  AData.AddType(TSetEditEvent_sw, Grids_TSetEditEvent_si);
  AData.AddType(TMovedEvent_sw, Grids_TMovedEvent_si);
  AData.AddType(TCustomDrawGrid_sw, Grids_TCustomDrawGrid_si);
  AData.AddType(TDrawGrid_sw, Grids_TDrawGrid_si);
  AData.AddType(TStringGridStrings_sw, Grids_TStringGridStrings_si);
  AData.AddType(TStringGrid_sw, Grids_TStringGrid_si);
  AData.AddType(TOnGetPickListItems_sw, Grids_TOnGetPickListItems_si);
  AData.AddType(TInplaceEditList_sw, Grids_TInplaceEditList_si);
end;

class function Grids_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Grids_sw);
end;

initialization
  RegisterUnitWrapper(Grids_sw);
  RegisterClassWrapper(EInvalidGridOperation_sw);
  RegisterClassWrapper(TInplaceEdit_sw);
  RegisterClassWrapper(TCustomGrid_sw);
  RegisterClassWrapper(TCustomDrawGrid_sw);
  RegisterClassWrapper(TDrawGrid_sw);
  RegisterClassWrapper(TStringGridStrings_sw);
  RegisterClassWrapper(TStringGrid_sw);
  RegisterClassWrapper(TInplaceEditList_sw);
  RegisterEventWrapper(TypeInfo(TGetExtentsFunc), TGetExtentsFunc_sw);
  RegisterEventWrapper(TypeInfo(TSelectCellEvent), TSelectCellEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetEditEvent), TGetEditEvent_sw);
  RegisterEventWrapper(TypeInfo(TSetEditEvent), TSetEditEvent_sw);
  RegisterEventWrapper(TypeInfo(TMovedEvent), TMovedEvent_sw);
  RegisterEventWrapper(TypeInfo(TOnGetPickListItems), TOnGetPickListItems_sw);

end.
