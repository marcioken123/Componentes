unit CheckLst_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'CheckLst' unit.
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
  LMDSctSysWrappers, Windows, Messages, SysUtils, Classes, Graphics, Controls,
  StdCtrls, CheckLst, Windows_LMDSW, Messages_LMDSW, SysUtils_LMDSW,
  Classes_LMDSW, Graphics_LMDSW, Controls_LMDSW, StdCtrls_LMDSW;


{ Type wrappers }

type
  TCheckListBox_sw = class;

  TCheckListBox_sc = class of TCheckListBox;
  TCheckListBox_sw = class(TCustomListBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCheckListBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TCheckListBox;
    class function ClassToVar(AClass: TCheckListBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCheckListBox_sc;
  end;


{ Unit wrapper }

type
  CheckLst_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TCheckListBox_sw }

function TCheckListBox_Checked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Checked[Index: Integer]: Boolean read <getter> w...

  if IsGet then
    Result := TCheckListBox(AObj).Checked[Integer(AArgs[0])]
  else
    TCheckListBox(AObj).Checked[Integer(AArgs[0])] := Boolean(AArgs[1]);
end;

function TCheckListBox_ItemEnabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ItemEnabled[Index: Integer]: Boolean read <gette...

  if IsGet then
    Result := TCheckListBox(AObj).ItemEnabled[Integer(AArgs[0])]
  else
    TCheckListBox(AObj).ItemEnabled[Integer(AArgs[0])] := Boolean(AArgs[1]);
end;

function TCheckListBox_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State[Index: Integer]: TCheckBoxState read <gett...

  if IsGet then
    Result := TCheckBoxState_sw.ToVar(TCheckListBox(AObj).State[Integer(
      AArgs[0])])
  else
    TCheckListBox(AObj).State[Integer(AArgs[0])] := TCheckBoxState_sw.FromVar(
      AArgs[1]);
end;

function TCheckListBox_Header_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Header[Index: Integer]: Boolean read <getter> wr...

  if IsGet then
    Result := TCheckListBox(AObj).Header[Integer(AArgs[0])]
  else
    TCheckListBox(AObj).Header[Integer(AArgs[0])] := Boolean(AArgs[1]);
end;

function TCheckListBox_OnClickCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnClickCheck: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCheckListBox(AObj).OnClickCheck)
  else
    TCheckListBox(AObj).OnClickCheck := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCheckListBox_AllowGrayed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowGrayed: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCheckListBox(AObj).AllowGrayed
  else
    TCheckListBox(AObj).AllowGrayed := Boolean(AArgs[0]);
end;

function TCheckListBox_Flat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Flat: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCheckListBox(AObj).Flat
  else
    TCheckListBox(AObj).Flat := Boolean(AArgs[0]);
end;

function TCheckListBox_HeaderColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HeaderColor: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TCheckListBox(AObj).HeaderColor)
  else
    TCheckListBox(AObj).HeaderColor := TColor_sw.FromVar(AArgs[0]);
end;

function TCheckListBox_HeaderBackgroundColor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HeaderBackgroundColor: TColor read <getter> writ...

  if IsGet then
    Result := TColor_sw.ToVar(TCheckListBox(AObj).HeaderBackgroundColor)
  else
    TCheckListBox(AObj).HeaderBackgroundColor := TColor_sw.FromVar(AArgs[0]);
end;

class function TCheckListBox_sw.GetTypeName: WideString;
begin
  Result := 'TCheckListBox';
end;

class function TCheckListBox_sw.GetWrappedClass: TClass;
begin
  Result := TCheckListBox;
end;

class procedure TCheckListBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Checked', TCheckListBox_Checked_si, Boolean_sw, True, True, 1, False, False);
  AData.AddProperty('ItemEnabled', TCheckListBox_ItemEnabled_si, Boolean_sw, True, True, 1, False, False);
  AData.AddProperty('State', TCheckListBox_State_si, TCheckBoxState_sw, True, True, 1, False, False);
  AData.AddProperty('Header', TCheckListBox_Header_si, Boolean_sw, True, True, 1, False, False);
  AData.AddProperty('OnClickCheck', TCheckListBox_OnClickCheck_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddProperty('AllowGrayed', TCheckListBox_AllowGrayed_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoComplete', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Columns', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddProperty('Flat', TCheckListBox_Flat_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddProperty('HeaderColor', TCheckListBox_HeaderColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('HeaderBackgroundColor', TCheckListBox_HeaderBackgroundColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('IntegralHeight', False);
  AData.AddPropertyRedecl('ItemHeight', False);
  AData.AddPropertyRedecl('Items', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Sorted', False);
  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('TabWidth', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnData', False);
  AData.AddPropertyRedecl('OnDataFind', False);
  AData.AddPropertyRedecl('OnDataObject', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnDrawItem', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMeasureItem', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TCheckListBox_sw.ToVar(const AValue: TCheckListBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCheckListBox_sw.FromVar(
  const AValue: OleVariant): TCheckListBox;
begin
  Result := TCheckListBox(ConvFromVar(AValue, TCheckListBox));
end;

class function TCheckListBox_sw.ClassToVar(
  AClass: TCheckListBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCheckListBox_sw.ClassFromVar(
  const AClass: OleVariant): TCheckListBox_sc;
begin
  Result := TCheckListBox_sc(ConvClsFromVar(AClass, TCheckListBox));
end;

{ CheckLst_sw }

function CheckLst_TCheckListBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCheckListBox = class(TCustomListBox);

  Result := TLMDUnitWrapper.TypeToVar(TCheckListBox_sw);
end;

class function CheckLst_sw.GetUnitName: WideString;
begin
  Result := 'CheckLst';
end;

class procedure CheckLst_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TCheckListBox_sw, CheckLst_TCheckListBox_si);
end;

class function CheckLst_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(CheckLst_sw);
end;

initialization
  RegisterUnitWrapper(CheckLst_sw);
  RegisterClassWrapper(TCheckListBox_sw);

end.
