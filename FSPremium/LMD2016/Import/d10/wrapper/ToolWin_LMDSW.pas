unit ToolWin_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ToolWin' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Windows, Messages, Classes, Controls, Forms, ToolWin,
  Windows_LMDSW, Messages_LMDSW, Classes_LMDSW, Controls_LMDSW, Forms_LMDSW;


{ Type wrappers }

type
  TToolWindow_sw = class;
  TToolDockObject_sw = class;
  TToolDockForm_sw = class;

  TEdgeBorder_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TEdgeBorder): OleVariant;
    class function FromVar(const AValue: OleVariant): TEdgeBorder;
  end;

  TEdgeBorders_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TEdgeBorders): OleVariant;
    class function FromVar(const AValue: OleVariant): TEdgeBorders;
  end;

  TEdgeStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TEdgeStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TEdgeStyle;
  end;

  TToolWindow_sc = class of TToolWindow;
  TToolWindow_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TToolWindow): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolWindow;
    class function ClassToVar(AClass: TToolWindow_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TToolWindow_sc;
  end;

  TToolDockObject_sc = class of TToolDockObject;
  TToolDockObject_sw = class(TDragDockObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TToolDockObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolDockObject;
    class function ClassToVar(AClass: TToolDockObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TToolDockObject_sc;
  end;

  TSizingOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSizingOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TSizingOrientation;
  end;

  TToolDockForm_sc = class of TToolDockForm;
  TToolDockForm_sw = class(TCustomDockForm_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TToolDockForm): OleVariant;
    class function FromVar(const AValue: OleVariant): TToolDockForm;
    class function ClassToVar(AClass: TToolDockForm_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TToolDockForm_sc;
  end;


{ Unit wrapper }

type
  ToolWin_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TEdgeBorder_sw }

class function TEdgeBorder_sw.GetTypeName: WideString;
begin
  Result := 'TEdgeBorder';
end;

class procedure TEdgeBorder_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'ebLeft'; Value: Integer({$IFDEF LMDSCT_12}TEdgeBorder.{$ENDIF}ebLeft)),
    (Name: 'ebTop'; Value: Integer({$IFDEF LMDSCT_12}TEdgeBorder.{$ENDIF}ebTop)),
    (Name: 'ebRight'; Value: Integer({$IFDEF LMDSCT_12}TEdgeBorder.{$ENDIF}ebRight)),
    (Name: 'ebBottom'; Value: Integer({$IFDEF LMDSCT_12}TEdgeBorder.{$ENDIF}ebBottom))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TEdgeBorder_sw.ToVar(const AValue: TEdgeBorder): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TEdgeBorder_sw.FromVar(const AValue: OleVariant): TEdgeBorder;
begin
  Result := TEdgeBorder(Integer(AValue));
end;

{ TEdgeBorders_sw }

class function TEdgeBorders_sw.GetTypeName: WideString;
begin
  Result := 'TEdgeBorders';
end;

class function TEdgeBorders_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TEdgeBorders);
end;

class function TEdgeBorders_sw.ToVar(const AValue: TEdgeBorders): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TEdgeBorders_sw.FromVar(const AValue: OleVariant): TEdgeBorders;
begin
  ConvFromVar(AValue, @Result);
end;

{ TEdgeStyle_sw }

class function TEdgeStyle_sw.GetTypeName: WideString;
begin
  Result := 'TEdgeStyle';
end;

class procedure TEdgeStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'esNone'; Value: Integer({$IFDEF LMDSCT_12}TEdgeStyle.{$ENDIF}esNone)),
    (Name: 'esRaised'; Value: Integer({$IFDEF LMDSCT_12}TEdgeStyle.{$ENDIF}esRaised)),
    (Name: 'esLowered'; Value: Integer({$IFDEF LMDSCT_12}TEdgeStyle.{$ENDIF}esLowered))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TEdgeStyle_sw.ToVar(const AValue: TEdgeStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TEdgeStyle_sw.FromVar(const AValue: OleVariant): TEdgeStyle;
begin
  Result := TEdgeStyle(Integer(AValue));
end;

{ TToolWindow_sw }

function TToolWindow_EdgeBorders_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EdgeBorders: TEdgeBorders read <getter> write <s...

  if IsGet then
    Result := TEdgeBorders_sw.ToVar(TToolWindow(AObj).EdgeBorders)
  else
    TToolWindow(AObj).EdgeBorders := TEdgeBorders_sw.FromVar(AArgs[0]);
end;

function TToolWindow_EdgeInner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EdgeInner: TEdgeStyle read <getter> write <setter>;

  if IsGet then
    Result := TEdgeStyle_sw.ToVar(TToolWindow(AObj).EdgeInner)
  else
    TToolWindow(AObj).EdgeInner := TEdgeStyle_sw.FromVar(AArgs[0]);
end;

function TToolWindow_EdgeOuter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EdgeOuter: TEdgeStyle read <getter> write <setter>;

  if IsGet then
    Result := TEdgeStyle_sw.ToVar(TToolWindow(AObj).EdgeOuter)
  else
    TToolWindow(AObj).EdgeOuter := TEdgeStyle_sw.FromVar(AArgs[0]);
end;

class function TToolWindow_sw.GetTypeName: WideString;
begin
  Result := 'TToolWindow';
end;

class function TToolWindow_sw.GetWrappedClass: TClass;
begin
  Result := TToolWindow;
end;

class procedure TToolWindow_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('EdgeBorders', TToolWindow_EdgeBorders_si, TEdgeBorders_sw, True, True, 0, False, False);
  AData.AddProperty('EdgeInner', TToolWindow_EdgeInner_si, TEdgeStyle_sw, True, True, 0, False, False);
  AData.AddProperty('EdgeOuter', TToolWindow_EdgeOuter_si, TEdgeStyle_sw, True, True, 0, False, False);
end;

class function TToolWindow_sw.ToVar(const AValue: TToolWindow): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TToolWindow_sw.FromVar(const AValue: OleVariant): TToolWindow;
begin
  Result := TToolWindow(ConvFromVar(AValue, TToolWindow));
end;

class function TToolWindow_sw.ClassToVar(AClass: TToolWindow_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TToolWindow_sw.ClassFromVar(
  const AClass: OleVariant): TToolWindow_sc;
begin
  Result := TToolWindow_sc(ConvClsFromVar(AClass, TToolWindow));
end;

{ TToolDockObject_sw }

class function TToolDockObject_sw.GetTypeName: WideString;
begin
  Result := 'TToolDockObject';
end;

class function TToolDockObject_sw.GetWrappedClass: TClass;
begin
  Result := TToolDockObject;
end;

class procedure TToolDockObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TToolDockObject_sw.ToVar(
  const AValue: TToolDockObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TToolDockObject_sw.FromVar(
  const AValue: OleVariant): TToolDockObject;
begin
  Result := TToolDockObject(ConvFromVar(AValue, TToolDockObject));
end;

class function TToolDockObject_sw.ClassToVar(
  AClass: TToolDockObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TToolDockObject_sw.ClassFromVar(
  const AClass: OleVariant): TToolDockObject_sc;
begin
  Result := TToolDockObject_sc(ConvClsFromVar(AClass, TToolDockObject));
end;

{ TSizingOrientation_sw }

class function TSizingOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TSizingOrientation';
end;

class procedure TSizingOrientation_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'soNone'; Value: Integer({$IFDEF LMDSCT_12}TSizingOrientation.{$ENDIF}soNone)),
    (Name: 'soHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TSizingOrientation.{$ENDIF}soHorizontal)),
    (Name: 'soVertical'; Value: Integer({$IFDEF LMDSCT_12}TSizingOrientation.{$ENDIF}soVertical))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TSizingOrientation_sw.ToVar(
  const AValue: TSizingOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSizingOrientation_sw.FromVar(
  const AValue: OleVariant): TSizingOrientation;
begin
  Result := TSizingOrientation(Integer(AValue));
end;

{ TToolDockForm_sw }

class function TToolDockForm_sw.GetTypeName: WideString;
begin
  Result := 'TToolDockForm';
end;

class function TToolDockForm_sw.GetWrappedClass: TClass;
begin
  Result := TToolDockForm;
end;

class procedure TToolDockForm_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TToolDockForm_sw.ToVar(const AValue: TToolDockForm): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TToolDockForm_sw.FromVar(
  const AValue: OleVariant): TToolDockForm;
begin
  Result := TToolDockForm(ConvFromVar(AValue, TToolDockForm));
end;

class function TToolDockForm_sw.ClassToVar(
  AClass: TToolDockForm_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TToolDockForm_sw.ClassFromVar(
  const AClass: OleVariant): TToolDockForm_sc;
begin
  Result := TToolDockForm_sc(ConvClsFromVar(AClass, TToolDockForm));
end;

{ ToolWin_sw }

function ToolWin_TEdgeBorder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEdgeBorder = (ebLeft, ebTop, ebRight, ebBottom);

  Result := TLMDUnitWrapper.TypeToVar(TEdgeBorder_sw);
end;

function ToolWin_TEdgeBorders_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEdgeBorders = set of TEdgeBorder;

  Result := TLMDUnitWrapper.TypeToVar(TEdgeBorders_sw);
end;

function ToolWin_TEdgeStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEdgeStyle = (esNone, esRaised, esLowered);

  Result := TLMDUnitWrapper.TypeToVar(TEdgeStyle_sw);
end;

function ToolWin_TToolWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolWindow = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TToolWindow_sw);
end;

function ToolWin_TToolDockObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolDockObject = class(TDragDockObject);

  Result := TLMDUnitWrapper.TypeToVar(TToolDockObject_sw);
end;

function ToolWin_TSizingOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSizingOrientation = (soNone, soHorizontal, soVertic...

  Result := TLMDUnitWrapper.TypeToVar(TSizingOrientation_sw);
end;

function ToolWin_TToolDockForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TToolDockForm = class(TCustomDockForm);

  Result := TLMDUnitWrapper.TypeToVar(TToolDockForm_sw);
end;

class function ToolWin_sw.GetUnitName: WideString;
begin
  Result := 'ToolWin';
end;

class procedure ToolWin_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TEdgeBorder_sw, ToolWin_TEdgeBorder_si);
  AData.AddType(TEdgeBorders_sw, ToolWin_TEdgeBorders_si);
  AData.AddType(TEdgeStyle_sw, ToolWin_TEdgeStyle_si);
  AData.AddType(TToolWindow_sw, ToolWin_TToolWindow_si);
  AData.AddType(TToolDockObject_sw, ToolWin_TToolDockObject_si);
  AData.AddType(TSizingOrientation_sw, ToolWin_TSizingOrientation_si);
  AData.AddType(TToolDockForm_sw, ToolWin_TToolDockForm_si);
end;

class function ToolWin_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ToolWin_sw);
end;

initialization
  RegisterUnitWrapper(ToolWin_sw);
  RegisterClassWrapper(TToolWindow_sw);
  RegisterClassWrapper(TToolDockObject_sw);
  RegisterClassWrapper(TToolDockForm_sw);

end.
