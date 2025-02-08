unit DBCGrids_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'DBCGrids' unit.
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
  LMDSctSysWrappers, SysUtils, Windows, Messages, Classes, Controls, Forms,
  Graphics, Menus, DB, DBCGrids, SysUtils_LMDSW, Windows_LMDSW, Messages_LMDSW,
  Classes_LMDSW, Controls_LMDSW, Forms_LMDSW, Graphics_LMDSW, Menus_LMDSW,
  DB_LMDSW;


{ Type wrappers }

type
  TDBCtrlGridLink_sw = class;
  TDBCtrlPanel_sw = class;
  TDBCtrlGrid_sw = class;

  TDBCtrlGridLink_sc = class of TDBCtrlGridLink;
  TDBCtrlGridLink_sw = class(TDataLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBCtrlGridLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBCtrlGridLink;
    class function ClassToVar(AClass: TDBCtrlGridLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBCtrlGridLink_sc;
  end;

  TDBCtrlPanel_sc = class of TDBCtrlPanel;
  TDBCtrlPanel_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBCtrlPanel): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBCtrlPanel;
    class function ClassToVar(AClass: TDBCtrlPanel_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBCtrlPanel_sc;
  end;

  TDBCtrlGridOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDBCtrlGridOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBCtrlGridOrientation;
  end;

  TDBCtrlGridBorder_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDBCtrlGridBorder): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBCtrlGridBorder;
  end;

  TDBCtrlGridKey_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDBCtrlGridKey): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBCtrlGridKey;
  end;

  TPaintPanelEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
  end;

  TPaintPanelEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TPaintPanelEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TPaintPanelEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TPaintPanelEvent;
  end;

  TDBCtrlGrid_sc = class of TDBCtrlGrid;
  TDBCtrlGrid_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBCtrlGrid): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBCtrlGrid;
    class function ClassToVar(AClass: TDBCtrlGrid_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBCtrlGrid_sc;
  end;


{ Unit wrapper }

type
  DBCGrids_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TDBCtrlGrid_sacc = class(TDBCtrlGrid);

{ TDBCtrlGridLink_sw }

function TDBCtrlGridLink_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(DBCtrlGrid: TDBCtrlGrid);

  Result := TDBCtrlGridLink_sw.ToVar(TDBCtrlGridLink_sc(AObj).Create(
    TDBCtrlGrid_sw.FromVar(AArgs[0])));
end;

class function TDBCtrlGridLink_sw.GetTypeName: WideString;
begin
  Result := 'TDBCtrlGridLink';
end;

class function TDBCtrlGridLink_sw.GetWrappedClass: TClass;
begin
  Result := TDBCtrlGridLink;
end;

class procedure TDBCtrlGridLink_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TDBCtrlGridLink_Create_si, 1, False);
end;

class function TDBCtrlGridLink_sw.ToVar(
  const AValue: TDBCtrlGridLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBCtrlGridLink_sw.FromVar(
  const AValue: OleVariant): TDBCtrlGridLink;
begin
  Result := TDBCtrlGridLink(ConvFromVar(AValue, TDBCtrlGridLink));
end;

class function TDBCtrlGridLink_sw.ClassToVar(
  AClass: TDBCtrlGridLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBCtrlGridLink_sw.ClassFromVar(
  const AClass: OleVariant): TDBCtrlGridLink_sc;
begin
  Result := TDBCtrlGridLink_sc(ConvClsFromVar(AClass, TDBCtrlGridLink));
end;

{ TDBCtrlPanel_sw }

function TDBCtrlPanel_CreateLinked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor CreateLinked(DBCtrlGrid: TDBCtrlGrid);

  Result := TDBCtrlPanel_sw.ToVar(TDBCtrlPanel_sc(AObj).CreateLinked(
    TDBCtrlGrid_sw.FromVar(AArgs[0])));
end;

class function TDBCtrlPanel_sw.GetTypeName: WideString;
begin
  Result := 'TDBCtrlPanel';
end;

class function TDBCtrlPanel_sw.GetWrappedClass: TClass;
begin
  Result := TDBCtrlPanel;
end;

class procedure TDBCtrlPanel_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('CreateLinked', TDBCtrlPanel_CreateLinked_si, 1, False);
end;

class function TDBCtrlPanel_sw.ToVar(const AValue: TDBCtrlPanel): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBCtrlPanel_sw.FromVar(const AValue: OleVariant): TDBCtrlPanel;
begin
  Result := TDBCtrlPanel(ConvFromVar(AValue, TDBCtrlPanel));
end;

class function TDBCtrlPanel_sw.ClassToVar(AClass: TDBCtrlPanel_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBCtrlPanel_sw.ClassFromVar(
  const AClass: OleVariant): TDBCtrlPanel_sc;
begin
  Result := TDBCtrlPanel_sc(ConvClsFromVar(AClass, TDBCtrlPanel));
end;

{ TDBCtrlGridOrientation_sw }

class function TDBCtrlGridOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TDBCtrlGridOrientation';
end;

class procedure TDBCtrlGridOrientation_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'goVertical'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridOrientation.{$ENDIF}goVertical)),
    (Name: 'goHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridOrientation.{$ENDIF}goHorizontal))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TDBCtrlGridOrientation_sw.ToVar(
  const AValue: TDBCtrlGridOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDBCtrlGridOrientation_sw.FromVar(
  const AValue: OleVariant): TDBCtrlGridOrientation;
begin
  Result := TDBCtrlGridOrientation(Integer(AValue));
end;

{ TDBCtrlGridBorder_sw }

class function TDBCtrlGridBorder_sw.GetTypeName: WideString;
begin
  Result := 'TDBCtrlGridBorder';
end;

class procedure TDBCtrlGridBorder_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'gbNone'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridBorder.{$ENDIF}gbNone)),
    (Name: 'gbRaised'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridBorder.{$ENDIF}gbRaised))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TDBCtrlGridBorder_sw.ToVar(
  const AValue: TDBCtrlGridBorder): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDBCtrlGridBorder_sw.FromVar(
  const AValue: OleVariant): TDBCtrlGridBorder;
begin
  Result := TDBCtrlGridBorder(Integer(AValue));
end;

{ TDBCtrlGridKey_sw }

class function TDBCtrlGridKey_sw.GetTypeName: WideString;
begin
  Result := 'TDBCtrlGridKey';
end;

class procedure TDBCtrlGridKey_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..17] of TLMDEnumerator = (
    (Name: 'gkNull'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkNull)),
    (Name: 'gkEditMode'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkEditMode)),
    (Name: 'gkPriorTab'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkPriorTab)),
    (Name: 'gkNextTab'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkNextTab)),
    (Name: 'gkLeft'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkLeft)),
    (Name: 'gkRight'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkRight)),
    (Name: 'gkUp'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkUp)),
    (Name: 'gkDown'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkDown)),
    (Name: 'gkScrollUp'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkScrollUp)),
    (Name: 'gkScrollDown'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkScrollDown)),
    (Name: 'gkPageUp'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkPageUp)),
    (Name: 'gkPageDown'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkPageDown)),
    (Name: 'gkHome'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkHome)),
    (Name: 'gkEnd'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkEnd)),
    (Name: 'gkInsert'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkInsert)),
    (Name: 'gkAppend'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkAppend)),
    (Name: 'gkDelete'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkDelete)),
    (Name: 'gkCancel'; Value: Integer({$IFDEF LMDSCT_12}TDBCtrlGridKey.{$ENDIF}gkCancel))
  );
begin
  AEnums := @ENUMS;
  ACount := 18;
end;

class function TDBCtrlGridKey_sw.ToVar(
  const AValue: TDBCtrlGridKey): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDBCtrlGridKey_sw.FromVar(
  const AValue: OleVariant): TDBCtrlGridKey;
begin
  Result := TDBCtrlGridKey(Integer(AValue));
end;

{ TPaintPanelEvent_sh }

function TPaintPanelEvent_sh.GetHandler: TMethod;
var
  hdr: TPaintPanelEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TPaintPanelEvent_sh.Handler(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (DBCtrlGrid: TDBCtrlGrid; Index: Integer) of ob...

  args[0] := TDBCtrlGrid_sw.ToVar(DBCtrlGrid);
  args[1] := Index;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TPaintPanelEvent_sw }

class function TPaintPanelEvent_sw.GetTypeName: WideString;
begin
  Result := 'TPaintPanelEvent';
end;

class function TPaintPanelEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TPaintPanelEvent_sh;
end;

class function TPaintPanelEvent_sw.ToVar(
  const AValue: TPaintPanelEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TPaintPanelEvent_sw.FromVar(
  const AValue: OleVariant): TPaintPanelEvent;
begin
  Result := TPaintPanelEvent(ConvFromVar(AValue));
end;

class function TPaintPanelEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TPaintPanelEvent;
var
  hdlr: TPaintPanelEvent_sh;
begin
  hdlr   := TPaintPanelEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TPaintPanelEvent_sw));
  Result := hdlr.Handler;
end;

{ TDBCtrlGrid_sw }

function TDBCtrlGrid_Panel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Panel: TDBCtrlPanel read <getter>;

  Result := TDBCtrlPanel_sw.ToVar(TDBCtrlGrid_sacc(TDBCtrlGrid(AObj)).Panel);
end;

function TDBCtrlGrid_DoKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DoKey(Key: TDBCtrlGridKey);

  TDBCtrlGrid(AObj).DoKey(TDBCtrlGridKey_sw.FromVar(AArgs[0]));
end;

function TDBCtrlGrid_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TDBCtrlGrid(AObj).Canvas);
end;

function TDBCtrlGrid_EditMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EditMode: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBCtrlGrid(AObj).EditMode
  else
    TDBCtrlGrid(AObj).EditMode := Boolean(AArgs[0]);
end;

function TDBCtrlGrid_PanelCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PanelCount: Integer read <getter>;

  Result := TDBCtrlGrid(AObj).PanelCount;
end;

function TDBCtrlGrid_PanelIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PanelIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDBCtrlGrid(AObj).PanelIndex
  else
    TDBCtrlGrid(AObj).PanelIndex := Integer(AArgs[0]);
end;

function TDBCtrlGrid_AllowDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowDelete: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBCtrlGrid(AObj).AllowDelete
  else
    TDBCtrlGrid(AObj).AllowDelete := Boolean(AArgs[0]);
end;

function TDBCtrlGrid_AllowInsert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowInsert: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBCtrlGrid(AObj).AllowInsert
  else
    TDBCtrlGrid(AObj).AllowInsert := Boolean(AArgs[0]);
end;

function TDBCtrlGrid_ColCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ColCount: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDBCtrlGrid(AObj).ColCount
  else
    TDBCtrlGrid(AObj).ColCount := Integer(AArgs[0]);
end;

function TDBCtrlGrid_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBCtrlGrid(AObj).DataSource)
  else
    TDBCtrlGrid(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDBCtrlGrid_Orientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Orientation: TDBCtrlGridOrientation read <getter...

  if IsGet then
    Result := TDBCtrlGridOrientation_sw.ToVar(TDBCtrlGrid(AObj).Orientation)
  else
    TDBCtrlGrid(AObj).Orientation := TDBCtrlGridOrientation_sw.FromVar(
      AArgs[0]);
end;

function TDBCtrlGrid_PanelBorder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PanelBorder: TDBCtrlGridBorder read <getter> wri...

  if IsGet then
    Result := TDBCtrlGridBorder_sw.ToVar(TDBCtrlGrid(AObj).PanelBorder)
  else
    TDBCtrlGrid(AObj).PanelBorder := TDBCtrlGridBorder_sw.FromVar(AArgs[0]);
end;

function TDBCtrlGrid_PanelHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PanelHeight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDBCtrlGrid(AObj).PanelHeight
  else
    TDBCtrlGrid(AObj).PanelHeight := Integer(AArgs[0]);
end;

function TDBCtrlGrid_PanelWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PanelWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDBCtrlGrid(AObj).PanelWidth
  else
    TDBCtrlGrid(AObj).PanelWidth := Integer(AArgs[0]);
end;

function TDBCtrlGrid_RowCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RowCount: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDBCtrlGrid(AObj).RowCount
  else
    TDBCtrlGrid(AObj).RowCount := Integer(AArgs[0]);
end;

function TDBCtrlGrid_SelectedColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelectedColor: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TDBCtrlGrid(AObj).SelectedColor)
  else
    TDBCtrlGrid(AObj).SelectedColor := TColor_sw.FromVar(AArgs[0]);
end;

function TDBCtrlGrid_ShowFocus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowFocus: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBCtrlGrid(AObj).ShowFocus
  else
    TDBCtrlGrid(AObj).ShowFocus := Boolean(AArgs[0]);
end;

function TDBCtrlGrid_OnPaintPanel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnPaintPanel: TPaintPanelEvent read <getter> wri...

  if IsGet then
    Result := TPaintPanelEvent_sw.ToVar(TDBCtrlGrid(AObj).OnPaintPanel)
  else
    TDBCtrlGrid(AObj).OnPaintPanel := TPaintPanelEvent_sw.FromVar(AArgs[0]);
end;

class function TDBCtrlGrid_sw.GetTypeName: WideString;
begin
  Result := 'TDBCtrlGrid';
end;

class function TDBCtrlGrid_sw.GetWrappedClass: TClass;
begin
  Result := TDBCtrlGrid;
end;

class procedure TDBCtrlGrid_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Panel', TDBCtrlGrid_Panel_si, TDBCtrlPanel_sw, True, False, 0, True, False);
  AData.AddProcedure('DoKey', TDBCtrlGrid_DoKey_si, 1, False);
  AData.AddProperty('Canvas', TDBCtrlGrid_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddProperty('EditMode', TDBCtrlGrid_EditMode_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('PanelCount', TDBCtrlGrid_PanelCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('PanelIndex', TDBCtrlGrid_PanelIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddProperty('AllowDelete', TDBCtrlGrid_AllowDelete_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AllowInsert', TDBCtrlGrid_AllowInsert_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddProperty('ColCount', TDBCtrlGrid_ColCount_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddProperty('DataSource', TDBCtrlGrid_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddProperty('Orientation', TDBCtrlGrid_Orientation_si, TDBCtrlGridOrientation_sw, True, True, 0, False, False);
  AData.AddProperty('PanelBorder', TDBCtrlGrid_PanelBorder_si, TDBCtrlGridBorder_sw, True, True, 0, False, False);
  AData.AddProperty('PanelHeight', TDBCtrlGrid_PanelHeight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('PanelWidth', TDBCtrlGrid_PanelWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddProperty('RowCount', TDBCtrlGrid_RowCount_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('SelectedColor', TDBCtrlGrid_SelectedColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('ShowFocus', TDBCtrlGrid_ShowFocus_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddProperty('OnPaintPanel', TDBCtrlGrid_OnPaintPanel_si, TPaintPanelEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBCtrlGrid_sw.ToVar(const AValue: TDBCtrlGrid): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBCtrlGrid_sw.FromVar(const AValue: OleVariant): TDBCtrlGrid;
begin
  Result := TDBCtrlGrid(ConvFromVar(AValue, TDBCtrlGrid));
end;

class function TDBCtrlGrid_sw.ClassToVar(AClass: TDBCtrlGrid_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBCtrlGrid_sw.ClassFromVar(
  const AClass: OleVariant): TDBCtrlGrid_sc;
begin
  Result := TDBCtrlGrid_sc(ConvClsFromVar(AClass, TDBCtrlGrid));
end;

{ DBCGrids_sw }

function DBCGrids_TDBCtrlGridLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBCtrlGridLink = class(TDataLink);

  Result := TLMDUnitWrapper.TypeToVar(TDBCtrlGridLink_sw);
end;

function DBCGrids_TDBCtrlPanel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBCtrlPanel = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TDBCtrlPanel_sw);
end;

function DBCGrids_TDBCtrlGridOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBCtrlGridOrientation = (goVertical, goHorizontal);

  Result := TLMDUnitWrapper.TypeToVar(TDBCtrlGridOrientation_sw);
end;

function DBCGrids_TDBCtrlGridBorder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBCtrlGridBorder = (gbNone, gbRaised);

  Result := TLMDUnitWrapper.TypeToVar(TDBCtrlGridBorder_sw);
end;

function DBCGrids_TDBCtrlGridKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBCtrlGridKey = (gkNull, gkEditMode, gkPriorTab, gk...

  Result := TLMDUnitWrapper.TypeToVar(TDBCtrlGridKey_sw);
end;

function DBCGrids_TPaintPanelEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPaintPanelEvent = procedure (DBCtrlGrid: TDBCtrlGri...

  Result := TLMDUnitWrapper.TypeToVar(TPaintPanelEvent_sw);
end;

function DBCGrids_TDBCtrlGrid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBCtrlGrid = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TDBCtrlGrid_sw);
end;

class function DBCGrids_sw.GetUnitName: WideString;
begin
  Result := 'DBCGrids';
end;

class procedure DBCGrids_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TDBCtrlGridLink_sw, DBCGrids_TDBCtrlGridLink_si);
  AData.AddType(TDBCtrlPanel_sw, DBCGrids_TDBCtrlPanel_si);
  AData.AddType(TDBCtrlGridOrientation_sw, DBCGrids_TDBCtrlGridOrientation_si);
  AData.AddType(TDBCtrlGridBorder_sw, DBCGrids_TDBCtrlGridBorder_si);
  AData.AddType(TDBCtrlGridKey_sw, DBCGrids_TDBCtrlGridKey_si);
  AData.AddType(TPaintPanelEvent_sw, DBCGrids_TPaintPanelEvent_si);
  AData.AddType(TDBCtrlGrid_sw, DBCGrids_TDBCtrlGrid_si);
end;

class function DBCGrids_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DBCGrids_sw);
end;

initialization
  RegisterUnitWrapper(DBCGrids_sw);
  RegisterClassWrapper(TDBCtrlGridLink_sw);
  RegisterClassWrapper(TDBCtrlPanel_sw);
  RegisterClassWrapper(TDBCtrlGrid_sw);
  RegisterEventWrapper(TypeInfo(TPaintPanelEvent), TPaintPanelEvent_sw);

end.
