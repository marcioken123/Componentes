unit ValEdit_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ValEdit' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Windows, SysUtils, Classes, Messages, Controls, Grids,
  StdCtrls, ValEdit, Windows_LMDSW, SysUtils_LMDSW, Classes_LMDSW,
  Messages_LMDSW, Controls_LMDSW, Grids_LMDSW, StdCtrls_LMDSW;


{ Type wrappers }

type
  TValueListEditor_sw = class;
  TValueListStrings_sw = class;
  TItemProp_sw = class;

  TDisplayOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDisplayOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TDisplayOption;
  end;

  TDisplayOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TDisplayOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TDisplayOptions;
  end;

  TKeyOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TKeyOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TKeyOption;
  end;

  TKeyOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TKeyOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TKeyOptions;
  end;

  TGetPickListEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; const KeyName: string; Values: TStrings);
  end;

  TGetPickListEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetPickListEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetPickListEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetPickListEvent;
  end;

  TOnValidateEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; ACol: Longint; ARow: Longint;
      const KeyName: string; const KeyValue: string);
  end;

  TOnValidateEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TOnValidateEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TOnValidateEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TOnValidateEvent;
  end;

  TValueListEditor_sc = class of TValueListEditor;
  TValueListEditor_sw = class(TCustomDrawGrid_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TValueListEditor): OleVariant;
    class function FromVar(const AValue: OleVariant): TValueListEditor;
    class function ClassToVar(AClass: TValueListEditor_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TValueListEditor_sc;
  end;

  TValueListStrings_sc = class of TValueListStrings;
  TValueListStrings_sw = class(TStringList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TValueListStrings): OleVariant;
    class function FromVar(const AValue: OleVariant): TValueListStrings;
    class function ClassToVar(AClass: TValueListStrings_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TValueListStrings_sc;
  end;

  TItemProp_sc = class of TItemProp;
  TItemProp_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TItemProp): OleVariant;
    class function FromVar(const AValue: OleVariant): TItemProp;
    class function ClassToVar(AClass: TItemProp_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TItemProp_sc;
  end;


{ Unit wrapper }

type
  ValEdit_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TValueListEditor_sacc = class(TValueListEditor);

{ TDisplayOption_sw }

class function TDisplayOption_sw.GetTypeName: WideString;
begin
  Result := 'TDisplayOption';
end;

class procedure TDisplayOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'doColumnTitles'; Value: Integer({$IFDEF LMDSCT_12}TDisplayOption.{$ENDIF}doColumnTitles)),
    (Name: 'doAutoColResize'; Value: Integer({$IFDEF LMDSCT_12}TDisplayOption.{$ENDIF}doAutoColResize)),
    (Name: 'doKeyColFixed'; Value: Integer({$IFDEF LMDSCT_12}TDisplayOption.{$ENDIF}doKeyColFixed))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TDisplayOption_sw.ToVar(
  const AValue: TDisplayOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDisplayOption_sw.FromVar(
  const AValue: OleVariant): TDisplayOption;
begin
  Result := TDisplayOption(Integer(AValue));
end;

{ TDisplayOptions_sw }

class function TDisplayOptions_sw.GetTypeName: WideString;
begin
  Result := 'TDisplayOptions';
end;

class function TDisplayOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TDisplayOptions);
end;

class function TDisplayOptions_sw.ToVar(
  const AValue: TDisplayOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TDisplayOptions_sw.FromVar(
  const AValue: OleVariant): TDisplayOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TKeyOption_sw }

class function TKeyOption_sw.GetTypeName: WideString;
begin
  Result := 'TKeyOption';
end;

class procedure TKeyOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'keyEdit'; Value: Integer({$IFDEF LMDSCT_12}TKeyOption.{$ENDIF}keyEdit)),
    (Name: 'keyAdd'; Value: Integer({$IFDEF LMDSCT_12}TKeyOption.{$ENDIF}keyAdd)),
    (Name: 'keyDelete'; Value: Integer({$IFDEF LMDSCT_12}TKeyOption.{$ENDIF}keyDelete)),
    (Name: 'keyUnique'; Value: Integer({$IFDEF LMDSCT_12}TKeyOption.{$ENDIF}keyUnique))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TKeyOption_sw.ToVar(const AValue: TKeyOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TKeyOption_sw.FromVar(const AValue: OleVariant): TKeyOption;
begin
  Result := TKeyOption(Integer(AValue));
end;

{ TKeyOptions_sw }

class function TKeyOptions_sw.GetTypeName: WideString;
begin
  Result := 'TKeyOptions';
end;

class function TKeyOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TKeyOptions);
end;

class function TKeyOptions_sw.ToVar(const AValue: TKeyOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TKeyOptions_sw.FromVar(const AValue: OleVariant): TKeyOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TGetPickListEvent_sh }

function TGetPickListEvent_sh.GetHandler: TMethod;
var
  hdr: TGetPickListEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetPickListEvent_sh.Handler(Sender: TObject; const KeyName: string;
  Values: TStrings);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (Sender: TObject; const KeyName: string; Values...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := KeyName;
  args[2] := TStrings_sw.ToVar(Values);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TGetPickListEvent_sw }

class function TGetPickListEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetPickListEvent';
end;

class function TGetPickListEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetPickListEvent_sh;
end;

class function TGetPickListEvent_sw.ToVar(
  const AValue: TGetPickListEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetPickListEvent_sw.FromVar(
  const AValue: OleVariant): TGetPickListEvent;
begin
  Result := TGetPickListEvent(ConvFromVar(AValue));
end;

class function TGetPickListEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TGetPickListEvent;
var
  hdlr: TGetPickListEvent_sh;
begin
  hdlr   := TGetPickListEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetPickListEvent_sw));
  Result := hdlr.Handler;
end;

{ TOnValidateEvent_sh }

function TOnValidateEvent_sh.GetHandler: TMethod;
var
  hdr: TOnValidateEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TOnValidateEvent_sh.Handler(Sender: TObject; ACol: Longint;
  ARow: Longint; const KeyName: string; const KeyValue: string);
var
  args: array[0..4] of OleVariant;
begin
  // procedure (Sender: TObject; ACol: Longint; ARow: Longint;...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := ACol;
  args[2] := ARow;
  args[3] := KeyName;
  args[4] := KeyValue;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TOnValidateEvent_sw }

class function TOnValidateEvent_sw.GetTypeName: WideString;
begin
  Result := 'TOnValidateEvent';
end;

class function TOnValidateEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TOnValidateEvent_sh;
end;

class function TOnValidateEvent_sw.ToVar(
  const AValue: TOnValidateEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TOnValidateEvent_sw.FromVar(
  const AValue: OleVariant): TOnValidateEvent;
begin
  Result := TOnValidateEvent(ConvFromVar(AValue));
end;

class function TOnValidateEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TOnValidateEvent;
var
  hdlr: TOnValidateEvent_sh;
begin
  hdlr   := TOnValidateEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TOnValidateEvent_sw));
  Result := hdlr.Handler;
end;

{ TValueListEditor_sw }

function TValueListEditor_EditList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property EditList: TInplaceEditList read <getter>;

  Result := TInplaceEditList_sw.ToVar(TValueListEditor_sacc(TValueListEditor(
    AObj)).EditList);
end;

function TValueListEditor_FindRow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
begin
  // function FindRow(const KeyName: string; var Row: Integer)...

  v_1 := Integer(AArgs[1]);
  Result := TValueListEditor(AObj).FindRow(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function TValueListEditor_InsertRow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function InsertRow(const KeyName: string; const Value: st...

  Result := TValueListEditor(AObj).InsertRow(string(AArgs[0]), string(AArgs[1]),
    Boolean(AArgs[2]));
end;

function TValueListEditor_Refresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Refresh;

  TValueListEditor(AObj).Refresh();
end;

function TValueListEditor_RestoreCurrentRow_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RestoreCurrentRow: Boolean;

  Result := TValueListEditor(AObj).RestoreCurrentRow();
end;

function TValueListEditor_Cells_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Cells[ACol: Integer; ARow: Integer]: string read...

  if IsGet then
    Result := TValueListEditor(AObj).Cells[Integer(AArgs[0]), Integer(AArgs[1])]
  else
    TValueListEditor(AObj).Cells[Integer(AArgs[0]), Integer(AArgs[1])] := 
      string(AArgs[2]);
end;

function TValueListEditor_ItemProps_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ItemProps[const KeyOrIndex: Variant]: TItemProp ...

  if IsGet then
    Result := TItemProp_sw.ToVar(TValueListEditor(AObj).ItemProps[Variant(
      FindVarData(AArgs[0])^)])
  else
    TValueListEditor(AObj).ItemProps[Variant(FindVarData(AArgs[0])^)] := 
      TItemProp_sw.FromVar(AArgs[1]);
end;

function TValueListEditor_Keys_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Keys[Index: Integer]: string read <getter> write...

  if IsGet then
    Result := TValueListEditor(AObj).Keys[Integer(AArgs[0])]
  else
    TValueListEditor(AObj).Keys[Integer(AArgs[0])] := string(AArgs[1]);
end;

function TValueListEditor_RowCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RowCount: Integer read <getter>;

  Result := TValueListEditor(AObj).RowCount;
end;

function TValueListEditor_Values_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Values[const Key: string]: string read <getter> ...

  if IsGet then
    Result := TValueListEditor(AObj).Values[string(AArgs[0])]
  else
    TValueListEditor(AObj).Values[string(AArgs[0])] := string(AArgs[1]);
end;

function TValueListEditor_DisplayOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DisplayOptions: TDisplayOptions read <getter> wr...

  if IsGet then
    Result := TDisplayOptions_sw.ToVar(TValueListEditor(AObj).DisplayOptions)
  else
    TValueListEditor(AObj).DisplayOptions := TDisplayOptions_sw.FromVar(
      AArgs[0]);
end;

function TValueListEditor_DropDownRows_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropDownRows: Integer read <getter> write <setter>;

  if IsGet then
    Result := TValueListEditor(AObj).DropDownRows
  else
    TValueListEditor(AObj).DropDownRows := Integer(AArgs[0]);
end;

function TValueListEditor_KeyOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeyOptions: TKeyOptions read <getter> write <set...

  if IsGet then
    Result := TKeyOptions_sw.ToVar(TValueListEditor(AObj).KeyOptions)
  else
    TValueListEditor(AObj).KeyOptions := TKeyOptions_sw.FromVar(AArgs[0]);
end;

function TValueListEditor_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TGridOptions read <getter> write <setter>;

  if IsGet then
    Result := TGridOptions_sw.ToVar(TValueListEditor(AObj).Options)
  else
    TValueListEditor(AObj).Options := TGridOptions_sw.FromVar(AArgs[0]);
end;

function TValueListEditor_Strings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Strings: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TValueListEditor(AObj).Strings)
  else
    TValueListEditor(AObj).Strings := TStrings_sw.FromVar(AArgs[0]);
end;

function TValueListEditor_TitleCaptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TitleCaptions: TStrings read <getter> write <set...

  if IsGet then
    Result := TStrings_sw.ToVar(TValueListEditor(AObj).TitleCaptions)
  else
    TValueListEditor(AObj).TitleCaptions := TStrings_sw.FromVar(AArgs[0]);
end;

function TValueListEditor_OnEditButtonClick_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnEditButtonClick: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TValueListEditor(AObj).OnEditButtonClick)
  else
    TValueListEditor(AObj).OnEditButtonClick := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TValueListEditor_OnGetPickList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetPickList: TGetPickListEvent read <getter> w...

  if IsGet then
    Result := TGetPickListEvent_sw.ToVar(TValueListEditor(AObj).OnGetPickList)
  else
    TValueListEditor(AObj).OnGetPickList := TGetPickListEvent_sw.FromVar(
      AArgs[0]);
end;

function TValueListEditor_OnStringsChange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnStringsChange: TNotifyEvent read <getter> writ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TValueListEditor(AObj).OnStringsChange)
  else
    TValueListEditor(AObj).OnStringsChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TValueListEditor_OnStringsChanging_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnStringsChanging: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TValueListEditor(AObj).OnStringsChanging)
  else
    TValueListEditor(AObj).OnStringsChanging := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TValueListEditor_OnValidate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnValidate: TOnValidateEvent read <getter> write...

  if IsGet then
    Result := TOnValidateEvent_sw.ToVar(TValueListEditor(AObj).OnValidate)
  else
    TValueListEditor(AObj).OnValidate := TOnValidateEvent_sw.FromVar(AArgs[0]);
end;

class function TValueListEditor_sw.GetTypeName: WideString;
begin
  Result := 'TValueListEditor';
end;

class function TValueListEditor_sw.GetWrappedClass: TClass;
begin
  Result := TValueListEditor;
end;

class procedure TValueListEditor_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('EditList', TValueListEditor_EditList_si, TInplaceEditList_sw, True, False, 0, True, False);
  AData.AddFunction('FindRow', TValueListEditor_FindRow_si, Boolean_sw, 2, False);
  AData.AddFunction('InsertRow', TValueListEditor_InsertRow_si, Integer_sw, 3, False);
  AData.AddProcedure('Refresh', TValueListEditor_Refresh_si, 0, False);
  AData.AddFunction('RestoreCurrentRow', TValueListEditor_RestoreCurrentRow_si, Boolean_sw, 0, False);
  AData.AddProperty('Cells', TValueListEditor_Cells_si, string_sw, True, True, 2, False, False);
  AData.AddPropertyRedecl('ColCount', False);
  AData.AddProperty('ItemProps', TValueListEditor_ItemProps_si, TItemProp_sw, True, True, 1, False, False);
  AData.AddProperty('Keys', TValueListEditor_Keys_si, string_sw, True, True, 1, False, False);
  AData.AddProperty('RowCount', TValueListEditor_RowCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Values', TValueListEditor_Values_si, string_sw, True, True, 1, False, False);
  AData.AddPropertyRedecl('VisibleColCount', False);
  AData.AddPropertyRedecl('VisibleRowCount', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DefaultColWidth', False);
  AData.AddPropertyRedecl('DefaultDrawing', False);
  AData.AddPropertyRedecl('DefaultRowHeight', False);
  AData.AddProperty('DisplayOptions', TValueListEditor_DisplayOptions_si, TDisplayOptions_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddProperty('DropDownRows', TValueListEditor_DropDownRows_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('FixedColor', False);
  AData.AddPropertyRedecl('FixedCols', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('GridLineWidth', False);
  AData.AddProperty('KeyOptions', TValueListEditor_KeyOptions_si, TKeyOptions_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TValueListEditor_Options_si, TGridOptions_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ScrollBars', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('Strings', TValueListEditor_Strings_si, TStrings_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddProperty('TitleCaptions', TValueListEditor_TitleCaptions_si, TStrings_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnDrawCell', False);
  AData.AddProperty('OnEditButtonClick', TValueListEditor_OnEditButtonClick_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGetEditMask', False);
  AData.AddPropertyRedecl('OnGetEditText', False);
  AData.AddProperty('OnGetPickList', TValueListEditor_OnGetPickList_si, TGetPickListEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnMouseWheelDown', False);
  AData.AddPropertyRedecl('OnMouseWheelUp', False);
  AData.AddPropertyRedecl('OnRowMoved', False);
  AData.AddPropertyRedecl('OnSelectCell', False);
  AData.AddPropertyRedecl('OnSetEditText', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddProperty('OnStringsChange', TValueListEditor_OnStringsChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnStringsChanging', TValueListEditor_OnStringsChanging_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnTopLeftChanged', False);
  AData.AddProperty('OnValidate', TValueListEditor_OnValidate_si, TOnValidateEvent_sw, True, True, 0, False, False);
end;

class function TValueListEditor_sw.ToVar(
  const AValue: TValueListEditor): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TValueListEditor_sw.FromVar(
  const AValue: OleVariant): TValueListEditor;
begin
  Result := TValueListEditor(ConvFromVar(AValue, TValueListEditor));
end;

class function TValueListEditor_sw.ClassToVar(
  AClass: TValueListEditor_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TValueListEditor_sw.ClassFromVar(
  const AClass: OleVariant): TValueListEditor_sc;
begin
  Result := TValueListEditor_sc(ConvClsFromVar(AClass, TValueListEditor));
end;

{ TValueListStrings_sw }

function TValueListStrings_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AEditor: TValueListEditor);

  Result := TValueListStrings_sw.ToVar(TValueListStrings_sc(AObj).Create(
    TValueListEditor_sw.FromVar(AArgs[0])));
end;

function TValueListStrings_KeyIsValid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function KeyIsValid(const Key: string; RaiseError: Boolea...

  case AArgsSize of
    1:
    begin
      Result := TValueListStrings(AObj).KeyIsValid(string(AArgs[0]));
    end;
    2:
    begin
      Result := TValueListStrings(AObj).KeyIsValid(string(AArgs[0]), Boolean(
        AArgs[1]));
    end;
  else
    WrongArgCountError('KeyIsValid');
  end;
end;

function TValueListStrings_ItemProps_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ItemProps[const KeyOrIndex: Variant]: TItemProp ...

  if IsGet then
    Result := TItemProp_sw.ToVar(TValueListStrings(AObj).ItemProps[Variant(
      FindVarData(AArgs[0])^)])
  else
    TValueListStrings(AObj).ItemProps[Variant(FindVarData(AArgs[0])^)] := 
      TItemProp_sw.FromVar(AArgs[1]);
end;

class function TValueListStrings_sw.GetTypeName: WideString;
begin
  Result := 'TValueListStrings';
end;

class function TValueListStrings_sw.GetWrappedClass: TClass;
begin
  Result := TValueListStrings;
end;

class procedure TValueListStrings_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('KeyIsValid', TValueListStrings_KeyIsValid_si, Boolean_sw, 1, True);
  AData.AddProperty('ItemProps', TValueListStrings_ItemProps_si, TItemProp_sw, True, True, 1, False, False);

  { Class members }

  AData.AddConstructor('Create', TValueListStrings_Create_si, 1, False);
end;

class function TValueListStrings_sw.ToVar(
  const AValue: TValueListStrings): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TValueListStrings_sw.FromVar(
  const AValue: OleVariant): TValueListStrings;
begin
  Result := TValueListStrings(ConvFromVar(AValue, TValueListStrings));
end;

class function TValueListStrings_sw.ClassToVar(
  AClass: TValueListStrings_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TValueListStrings_sw.ClassFromVar(
  const AClass: OleVariant): TValueListStrings_sc;
begin
  Result := TValueListStrings_sc(ConvClsFromVar(AClass, TValueListStrings));
end;

{ TItemProp_sw }

function TItemProp_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AEditor: TValueListEditor);

  Result := TItemProp_sw.ToVar(TItemProp_sc(AObj).Create(TValueListEditor_sw.
    FromVar(AArgs[0])));
end;

function TItemProp_HasPickList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HasPickList: Boolean;

  Result := TItemProp(AObj).HasPickList();
end;

function TItemProp_EditMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EditMask: string read <getter> write <setter>;

  if IsGet then
    Result := TItemProp(AObj).EditMask
  else
    TItemProp(AObj).EditMask := string(AArgs[0]);
end;

function TItemProp_EditStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EditStyle: TEditStyle read <getter> write <setter>;

  if IsGet then
    Result := TEditStyle_sw.ToVar(TItemProp(AObj).EditStyle)
  else
    TItemProp(AObj).EditStyle := TEditStyle_sw.FromVar(AArgs[0]);
end;

function TItemProp_KeyDesc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeyDesc: string read <getter> write <setter>;

  if IsGet then
    Result := TItemProp(AObj).KeyDesc
  else
    TItemProp(AObj).KeyDesc := string(AArgs[0]);
end;

function TItemProp_PickList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PickList: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TItemProp(AObj).PickList)
  else
    TItemProp(AObj).PickList := TStrings_sw.FromVar(AArgs[0]);
end;

function TItemProp_MaxLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxLength: Integer read <getter> write <setter>;

  if IsGet then
    Result := TItemProp(AObj).MaxLength
  else
    TItemProp(AObj).MaxLength := Integer(AArgs[0]);
end;

function TItemProp_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TItemProp(AObj).ReadOnly
  else
    TItemProp(AObj).ReadOnly := Boolean(AArgs[0]);
end;

class function TItemProp_sw.GetTypeName: WideString;
begin
  Result := 'TItemProp';
end;

class function TItemProp_sw.GetWrappedClass: TClass;
begin
  Result := TItemProp;
end;

class procedure TItemProp_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('HasPickList', TItemProp_HasPickList_si, Boolean_sw, 0, False);
  AData.AddProperty('EditMask', TItemProp_EditMask_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('EditStyle', TItemProp_EditStyle_si, TEditStyle_sw, True, True, 0, False, False);
  AData.AddProperty('KeyDesc', TItemProp_KeyDesc_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('PickList', TItemProp_PickList_si, TStrings_sw, True, True, 0, False, False);
  AData.AddProperty('MaxLength', TItemProp_MaxLength_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ReadOnly', TItemProp_ReadOnly_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TItemProp_Create_si, 1, False);
end;

class function TItemProp_sw.ToVar(const AValue: TItemProp): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TItemProp_sw.FromVar(const AValue: OleVariant): TItemProp;
begin
  Result := TItemProp(ConvFromVar(AValue, TItemProp));
end;

class function TItemProp_sw.ClassToVar(AClass: TItemProp_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TItemProp_sw.ClassFromVar(
  const AClass: OleVariant): TItemProp_sc;
begin
  Result := TItemProp_sc(ConvClsFromVar(AClass, TItemProp));
end;

{ ValEdit_sw }

function ValEdit_TDisplayOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDisplayOption = (doColumnTitles, doAutoColResize, d...

  Result := TLMDUnitWrapper.TypeToVar(TDisplayOption_sw);
end;

function ValEdit_TDisplayOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDisplayOptions = set of TDisplayOption;

  Result := TLMDUnitWrapper.TypeToVar(TDisplayOptions_sw);
end;

function ValEdit_TKeyOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TKeyOption = (keyEdit, keyAdd, keyDelete, keyUnique);

  Result := TLMDUnitWrapper.TypeToVar(TKeyOption_sw);
end;

function ValEdit_TKeyOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TKeyOptions = set of TKeyOption;

  Result := TLMDUnitWrapper.TypeToVar(TKeyOptions_sw);
end;

function ValEdit_TGetPickListEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetPickListEvent = procedure (Sender: TObject; cons...

  Result := TLMDUnitWrapper.TypeToVar(TGetPickListEvent_sw);
end;

function ValEdit_TOnValidateEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOnValidateEvent = procedure (Sender: TObject; ACol:...

  Result := TLMDUnitWrapper.TypeToVar(TOnValidateEvent_sw);
end;

function ValEdit_TValueListEditor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TValueListEditor = class(TCustomDrawGrid);

  Result := TLMDUnitWrapper.TypeToVar(TValueListEditor_sw);
end;

function ValEdit_TValueListStrings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TValueListStrings = class(TStringList);

  Result := TLMDUnitWrapper.TypeToVar(TValueListStrings_sw);
end;

function ValEdit_TItemProp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TItemProp = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TItemProp_sw);
end;

class function ValEdit_sw.GetUnitName: WideString;
begin
  Result := 'ValEdit';
end;

class procedure ValEdit_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TDisplayOption_sw, ValEdit_TDisplayOption_si);
  AData.AddType(TDisplayOptions_sw, ValEdit_TDisplayOptions_si);
  AData.AddType(TKeyOption_sw, ValEdit_TKeyOption_si);
  AData.AddType(TKeyOptions_sw, ValEdit_TKeyOptions_si);
  AData.AddType(TGetPickListEvent_sw, ValEdit_TGetPickListEvent_si);
  AData.AddType(TOnValidateEvent_sw, ValEdit_TOnValidateEvent_si);
  AData.AddType(TValueListEditor_sw, ValEdit_TValueListEditor_si);
  AData.AddType(TValueListStrings_sw, ValEdit_TValueListStrings_si);
  AData.AddType(TItemProp_sw, ValEdit_TItemProp_si);
end;

class function ValEdit_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ValEdit_sw);
end;

initialization
  RegisterUnitWrapper(ValEdit_sw);
  RegisterClassWrapper(TValueListEditor_sw);
  RegisterClassWrapper(TValueListStrings_sw);
  RegisterClassWrapper(TItemProp_sw);
  RegisterEventWrapper(TypeInfo(TGetPickListEvent), TGetPickListEvent_sw);
  RegisterEventWrapper(TypeInfo(TOnValidateEvent), TOnValidateEvent_sw);

end.
