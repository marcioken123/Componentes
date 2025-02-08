unit ActnCtrls_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ActnCtrls' unit.
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
  LMDSctSysWrappers, Types, Windows, Messages, Classes, Controls, Graphics,
  ToolWin, ActnMan, Buttons, StdCtrls, ComCtrls, Contnrs, GraphUtil, ExtCtrls,
  ActnCtrls, Windows_LMDSW, Messages_LMDSW, Classes_LMDSW, Controls_LMDSW,
  Graphics_LMDSW, ToolWin_LMDSW, ActnMan_LMDSW, Buttons_LMDSW, StdCtrls_LMDSW,
  ComCtrls_LMDSW, Contnrs_LMDSW, GraphUtil_LMDSW, ExtCtrls_LMDSW;


{ Type wrappers }

type
  TCustomButtonControl_sw = class;
  TCustomUtilityButton_sw = class;
  TCustomToolScrollBtn_sw = class;
  TCustomDropDownButton_sw = class;
  TCustomActionCombo_sw = class;
  TCustomComboControl_sw = class;
  TCustomActionDockBar_sw = class;
  TCustomToolScrollBtnClass_sw = class;
  TCustomActionToolBar_sw = class;
  TActionToolBar_sw = class;

  TCustomButtonControl_sc = class of TCustomButtonControl;
  TCustomButtonControl_sw = class(TCustomActionControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomButtonControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomButtonControl;
    class function ClassToVar(AClass: TCustomButtonControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomButtonControl_sc;
  end;

  TCustomUtilityButton_sc = class of TCustomUtilityButton;
  TCustomUtilityButton_sw = class(TCustomButtonControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomUtilityButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomUtilityButton;
    class function ClassToVar(AClass: TCustomUtilityButton_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomUtilityButton_sc;
  end;

  TCustomToolScrollBtn_sc = class of TCustomToolScrollBtn;
  TCustomToolScrollBtn_sw = class(TCustomUtilityButton_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomToolScrollBtn): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomToolScrollBtn;
    class function ClassToVar(AClass: TCustomToolScrollBtn_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomToolScrollBtn_sc;
  end;

  TCustomDropDownButton_sc = class of TCustomDropDownButton;
  TCustomDropDownButton_sw = class(TCustomButtonControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomDropDownButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomDropDownButton;
    class function ClassToVar(AClass: TCustomDropDownButton_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomDropDownButton_sc;
  end;

  TCustomActionCombo_sc = class of TCustomActionCombo;
  TCustomActionCombo_sw = class(TCustomComboBoxEx_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionCombo): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionCombo;
    class function ClassToVar(AClass: TCustomActionCombo_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionCombo_sc;
  end;

  TCustomComboControl_sc = class of TCustomComboControl;
  TCustomComboControl_sw = class(TCustomActionControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomComboControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomComboControl;
    class function ClassToVar(AClass: TCustomComboControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomComboControl_sc;
  end;

  TCustomActionDockBar_sc = class of TCustomActionDockBar;
  TCustomActionDockBar_sw = class(TCustomActionBar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionDockBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionDockBar;
    class function ClassToVar(AClass: TCustomActionDockBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionDockBar_sc;
  end;

  TCustomToolScrollBtnClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomToolScrollBtnClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomToolScrollBtnClass;
  end;

  TCustomActionToolBar_sc = class of TCustomActionToolBar;
  TCustomActionToolBar_sw = class(TCustomActionDockBar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActionToolBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActionToolBar;
    class function ClassToVar(AClass: TCustomActionToolBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActionToolBar_sc;
  end;

  TActionToolBar_sc = class of TActionToolBar;
  TActionToolBar_sw = class(TCustomActionToolBar_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TActionToolBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TActionToolBar;
    class function ClassToVar(AClass: TActionToolBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TActionToolBar_sc;
  end;


{ Unit wrapper }

type
  ActnCtrls_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TCustomButtonControl_sacc = class(TCustomButtonControl);
  TCustomDropDownButton_sacc = class(TCustomDropDownButton);

{ TCustomButtonControl_sw }

function TCustomButtonControl_MouseInControl_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MouseInControl: Boolean read <getter>;

  Result := TCustomButtonControl_sacc(TCustomButtonControl(AObj)).
    MouseInControl;
end;

function TCustomButtonControl_AllowAllUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowAllUp: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomButtonControl(AObj).AllowAllUp
  else
    TCustomButtonControl(AObj).AllowAllUp := Boolean(AArgs[0]);
end;

function TCustomButtonControl_Down_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Down: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomButtonControl(AObj).Down
  else
    TCustomButtonControl(AObj).Down := Boolean(AArgs[0]);
end;

function TCustomButtonControl_Flat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Flat: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomButtonControl(AObj).Flat
  else
    TCustomButtonControl(AObj).Flat := Boolean(AArgs[0]);
end;

function TCustomButtonControl_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State: TButtonState read <getter> write <setter>;

  if IsGet then
    Result := TButtonState_sw.ToVar(TCustomButtonControl(AObj).State)
  else
    TCustomButtonControl(AObj).State := TButtonState_sw.FromVar(AArgs[0]);
end;

function TCustomButtonControl_TrackButton_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TrackButton: TMouseButton read <getter> write <s...

  if IsGet then
    Result := TMouseButton_sw.ToVar(TCustomButtonControl(AObj).TrackButton)
  else
    TCustomButtonControl(AObj).TrackButton := TMouseButton_sw.FromVar(AArgs[0]);
end;

class function TCustomButtonControl_sw.GetTypeName: WideString;
begin
  Result := 'TCustomButtonControl';
end;

class function TCustomButtonControl_sw.GetWrappedClass: TClass;
begin
  Result := TCustomButtonControl;
end;

class procedure TCustomButtonControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('MouseInControl', TCustomButtonControl_MouseInControl_si, Boolean_sw, True, False, 0, True);
  AData.AddProperty('AllowAllUp', TCustomButtonControl_AllowAllUp_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Caption');
  AData.AddProperty('Down', TCustomButtonControl_Down_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('Flat', TCustomButtonControl_Flat_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('ShowCaption');
  AData.AddPropertyRedecl('ShowShortCut');
  AData.AddProperty('State', TCustomButtonControl_State_si, TButtonState_sw, True, True, 0, False);
  AData.AddProperty('TrackButton', TCustomButtonControl_TrackButton_si, TMouseButton_sw, True, True, 0, False);
end;

class function TCustomButtonControl_sw.ToVar(
  const AValue: TCustomButtonControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomButtonControl_sw.FromVar(
  const AValue: OleVariant): TCustomButtonControl;
begin
  Result := TCustomButtonControl(ConvFromVar(AValue, TCustomButtonControl));
end;

class function TCustomButtonControl_sw.ClassToVar(
  AClass: TCustomButtonControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomButtonControl_sw.ClassFromVar(
  const AClass: OleVariant): TCustomButtonControl_sc;
begin
  Result := TCustomButtonControl_sc(ConvClsFromVar(AClass, 
    TCustomButtonControl));
end;

{ TCustomUtilityButton_sw }

function TCustomUtilityButton_AutoScroll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoScroll: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomUtilityButton(AObj).AutoScroll
  else
    TCustomUtilityButton(AObj).AutoScroll := Boolean(AArgs[0]);
end;

function TCustomUtilityButton_ArrowSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ArrowSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomUtilityButton(AObj).ArrowSize
  else
    TCustomUtilityButton(AObj).ArrowSize := Integer(AArgs[0]);
end;

function TCustomUtilityButton_ArrowType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ArrowType: TArrowType read <getter> write <setter>;

  if IsGet then
    Result := TArrowType_sw.ToVar(TCustomUtilityButton(AObj).ArrowType)
  else
    TCustomUtilityButton(AObj).ArrowType := TArrowType_sw.FromVar(AArgs[0]);
end;

function TCustomUtilityButton_Direction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Direction: TScrollDirection read <getter> write ...

  if IsGet then
    Result := TScrollDirection_sw.ToVar(TCustomUtilityButton(AObj).Direction)
  else
    TCustomUtilityButton(AObj).Direction := TScrollDirection_sw.FromVar(
      AArgs[0]);
end;

function TCustomUtilityButton_RepeatRate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RepeatRate: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomUtilityButton(AObj).RepeatRate
  else
    TCustomUtilityButton(AObj).RepeatRate := Integer(AArgs[0]);
end;

function TCustomUtilityButton_OnClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnClick: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomUtilityButton(AObj).OnClick)
  else
    TCustomUtilityButton(AObj).OnClick := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCustomUtilityButton_sw.GetTypeName: WideString;
begin
  Result := 'TCustomUtilityButton';
end;

class function TCustomUtilityButton_sw.GetWrappedClass: TClass;
begin
  Result := TCustomUtilityButton;
end;

class procedure TCustomUtilityButton_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AutoScroll', TCustomUtilityButton_AutoScroll_si, Boolean_sw, True, True, 0, False);
  AData.AddProperty('ArrowSize', TCustomUtilityButton_ArrowSize_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('ArrowType', TCustomUtilityButton_ArrowType_si, TArrowType_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Color');
  AData.AddProperty('Direction', TCustomUtilityButton_Direction_si, TScrollDirection_sw, True, True, 0, False);
  AData.AddProperty('RepeatRate', TCustomUtilityButton_RepeatRate_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('OnClick', TCustomUtilityButton_OnClick_si, TNotifyEvent_sw, True, True, 0, False);
end;

class function TCustomUtilityButton_sw.ToVar(
  const AValue: TCustomUtilityButton): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomUtilityButton_sw.FromVar(
  const AValue: OleVariant): TCustomUtilityButton;
begin
  Result := TCustomUtilityButton(ConvFromVar(AValue, TCustomUtilityButton));
end;

class function TCustomUtilityButton_sw.ClassToVar(
  AClass: TCustomUtilityButton_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomUtilityButton_sw.ClassFromVar(
  const AClass: OleVariant): TCustomUtilityButton_sc;
begin
  Result := TCustomUtilityButton_sc(ConvClsFromVar(AClass, 
    TCustomUtilityButton));
end;

{ TCustomToolScrollBtn_sw }

class function TCustomToolScrollBtn_sw.GetTypeName: WideString;
begin
  Result := 'TCustomToolScrollBtn';
end;

class function TCustomToolScrollBtn_sw.GetWrappedClass: TClass;
begin
  Result := TCustomToolScrollBtn;
end;

class procedure TCustomToolScrollBtn_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomToolScrollBtn_sw.ToVar(
  const AValue: TCustomToolScrollBtn): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomToolScrollBtn_sw.FromVar(
  const AValue: OleVariant): TCustomToolScrollBtn;
begin
  Result := TCustomToolScrollBtn(ConvFromVar(AValue, TCustomToolScrollBtn));
end;

class function TCustomToolScrollBtn_sw.ClassToVar(
  AClass: TCustomToolScrollBtn_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomToolScrollBtn_sw.ClassFromVar(
  const AClass: OleVariant): TCustomToolScrollBtn_sc;
begin
  Result := TCustomToolScrollBtn_sc(ConvClsFromVar(AClass, 
    TCustomToolScrollBtn));
end;

{ TCustomDropDownButton_sw }

function TCustomDropDownButton_DroppedDown_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DroppedDown: Boolean read <getter>;

  Result := TCustomDropDownButton_sacc(TCustomDropDownButton(AObj)).DroppedDown;
end;

function TCustomDropDownButton_DropDownClick_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DropDownClick;

  TCustomDropDownButton(AObj).DropDownClick();
end;

class function TCustomDropDownButton_sw.GetTypeName: WideString;
begin
  Result := 'TCustomDropDownButton';
end;

class function TCustomDropDownButton_sw.GetWrappedClass: TClass;
begin
  Result := TCustomDropDownButton;
end;

class procedure TCustomDropDownButton_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DroppedDown', TCustomDropDownButton_DroppedDown_si, Boolean_sw, True, False, 0, True);
  AData.AddProcedure('DropDownClick', TCustomDropDownButton_DropDownClick_si, 0, False);
end;

class function TCustomDropDownButton_sw.ToVar(
  const AValue: TCustomDropDownButton): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomDropDownButton_sw.FromVar(
  const AValue: OleVariant): TCustomDropDownButton;
begin
  Result := TCustomDropDownButton(ConvFromVar(AValue, TCustomDropDownButton));
end;

class function TCustomDropDownButton_sw.ClassToVar(
  AClass: TCustomDropDownButton_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomDropDownButton_sw.ClassFromVar(
  const AClass: OleVariant): TCustomDropDownButton_sc;
begin
  Result := TCustomDropDownButton_sc(ConvClsFromVar(AClass, 
    TCustomDropDownButton));
end;

{ TCustomActionCombo_sw }

class function TCustomActionCombo_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionCombo';
end;

class function TCustomActionCombo_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionCombo;
end;

class procedure TCustomActionCombo_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomActionCombo_sw.ToVar(
  const AValue: TCustomActionCombo): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionCombo_sw.FromVar(
  const AValue: OleVariant): TCustomActionCombo;
begin
  Result := TCustomActionCombo(ConvFromVar(AValue, TCustomActionCombo));
end;

class function TCustomActionCombo_sw.ClassToVar(
  AClass: TCustomActionCombo_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionCombo_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionCombo_sc;
begin
  Result := TCustomActionCombo_sc(ConvClsFromVar(AClass, TCustomActionCombo));
end;

{ TCustomComboControl_sw }

function TCustomComboControl_ComboBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ComboBox: TCustomActionCombo read <getter>;

  Result := TCustomActionCombo_sw.ToVar(TCustomComboControl(AObj).ComboBox);
end;

class function TCustomComboControl_sw.GetTypeName: WideString;
begin
  Result := 'TCustomComboControl';
end;

class function TCustomComboControl_sw.GetWrappedClass: TClass;
begin
  Result := TCustomComboControl;
end;

class procedure TCustomComboControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ComboBox', TCustomComboControl_ComboBox_si, TCustomActionCombo_sw, True, False, 0, False);
end;

class function TCustomComboControl_sw.ToVar(
  const AValue: TCustomComboControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomComboControl_sw.FromVar(
  const AValue: OleVariant): TCustomComboControl;
begin
  Result := TCustomComboControl(ConvFromVar(AValue, TCustomComboControl));
end;

class function TCustomComboControl_sw.ClassToVar(
  AClass: TCustomComboControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomComboControl_sw.ClassFromVar(
  const AClass: OleVariant): TCustomComboControl_sc;
begin
  Result := TCustomComboControl_sc(ConvClsFromVar(AClass, TCustomComboControl));
end;

{ TCustomActionDockBar_sw }

function TCustomActionDockBar_CalcDockedWidth_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CalcDockedWidth: Integer;

  Result := TCustomActionDockBar(AObj).CalcDockedWidth();
end;

class function TCustomActionDockBar_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionDockBar';
end;

class function TCustomActionDockBar_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionDockBar;
end;

class procedure TCustomActionDockBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('CalcDockedWidth', TCustomActionDockBar_CalcDockedWidth_si, Integer_sw, 0, False);
end;

class function TCustomActionDockBar_sw.ToVar(
  const AValue: TCustomActionDockBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionDockBar_sw.FromVar(
  const AValue: OleVariant): TCustomActionDockBar;
begin
  Result := TCustomActionDockBar(ConvFromVar(AValue, TCustomActionDockBar));
end;

class function TCustomActionDockBar_sw.ClassToVar(
  AClass: TCustomActionDockBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionDockBar_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionDockBar_sc;
begin
  Result := TCustomActionDockBar_sc(ConvClsFromVar(AClass, 
    TCustomActionDockBar));
end;

{ TCustomToolScrollBtnClass_sw }

class function TCustomToolScrollBtnClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomToolScrollBtnClass';
end;

class function TCustomToolScrollBtnClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomToolScrollBtn;
end;

class function TCustomToolScrollBtnClass_sw.ToVar(
  const AValue: TCustomToolScrollBtnClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomToolScrollBtnClass_sw.FromVar(
  const AValue: OleVariant): TCustomToolScrollBtnClass;
begin
  Result := TCustomToolScrollBtnClass(ConvFromVar(AValue, 
    TCustomToolScrollBtn));
end;

{ TCustomActionToolBar_sw }

function TCustomActionToolBar_HiddenCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HiddenCount: Integer read <getter>;

  Result := TCustomActionToolBar(AObj).HiddenCount;
end;

class function TCustomActionToolBar_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActionToolBar';
end;

class function TCustomActionToolBar_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActionToolBar;
end;

class procedure TCustomActionToolBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('HiddenCount', TCustomActionToolBar_HiddenCount_si, Integer_sw, True, False, 0, False);
end;

class function TCustomActionToolBar_sw.ToVar(
  const AValue: TCustomActionToolBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActionToolBar_sw.FromVar(
  const AValue: OleVariant): TCustomActionToolBar;
begin
  Result := TCustomActionToolBar(ConvFromVar(AValue, TCustomActionToolBar));
end;

class function TCustomActionToolBar_sw.ClassToVar(
  AClass: TCustomActionToolBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActionToolBar_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActionToolBar_sc;
begin
  Result := TCustomActionToolBar_sc(ConvClsFromVar(AClass, 
    TCustomActionToolBar));
end;

{ TActionToolBar_sw }

class function TActionToolBar_sw.GetTypeName: WideString;
begin
  Result := 'TActionToolBar';
end;

class function TActionToolBar_sw.GetWrappedClass: TClass;
begin
  Result := TActionToolBar;
end;

class procedure TActionToolBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Canvas');
  AData.AddPropertyRedecl('ActionManager');
  AData.AddPropertyRedecl('Align');
  AData.AddPropertyRedecl('AllowHiding');
  AData.AddPropertyRedecl('Anchors');
  AData.AddPropertyRedecl('BiDiMode');
  AData.AddPropertyRedecl('Caption');
  AData.AddPropertyRedecl('Color');
  AData.AddPropertyRedecl('ColorMap');
  AData.AddPropertyRedecl('Constraints');
  AData.AddPropertyRedecl('Cursor');
  AData.AddPropertyRedecl('DragCursor');
  AData.AddPropertyRedecl('DragKind');
  AData.AddPropertyRedecl('DragMode');
  AData.AddPropertyRedecl('EdgeBorders');
  AData.AddPropertyRedecl('EdgeInner');
  AData.AddPropertyRedecl('EdgeOuter');
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('Font');
  AData.AddPropertyRedecl('HorzMargin');
  AData.AddPropertyRedecl('HorzSeparator');
  AData.AddPropertyRedecl('Orientation');
  AData.AddPropertyRedecl('ParentBiDiMode');
  AData.AddPropertyRedecl('ParentBackground');
  AData.AddPropertyRedecl('ParentColor');
  AData.AddPropertyRedecl('ParentFont');
  AData.AddPropertyRedecl('ParentShowHint');
  AData.AddPropertyRedecl('PersistentHotKeys');
  AData.AddPropertyRedecl('PopupMenu');
  AData.AddPropertyRedecl('ShowHint');
  AData.AddPropertyRedecl('Spacing');
  AData.AddPropertyRedecl('VertMargin');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('OnAlignInsertBefore');
  AData.AddPropertyRedecl('OnAlignPosition');
  AData.AddPropertyRedecl('OnControlCreated');
  AData.AddPropertyRedecl('OnCanResize');
  AData.AddPropertyRedecl('OnClick');
  AData.AddPropertyRedecl('OnConstrainedResize');
  AData.AddPropertyRedecl('OnContextPopup');
  AData.AddPropertyRedecl('OnDockDrop');
  AData.AddPropertyRedecl('OnDockOver');
  AData.AddPropertyRedecl('OnDblClick');
  AData.AddPropertyRedecl('OnDragDrop');
  AData.AddPropertyRedecl('OnDragOver');
  AData.AddPropertyRedecl('OnEndDock');
  AData.AddPropertyRedecl('OnEndDrag');
  AData.AddPropertyRedecl('OnEnter');
  AData.AddPropertyRedecl('OnExit');
  AData.AddPropertyRedecl('OnGetControlClass');
  AData.AddPropertyRedecl('OnGetSiteInfo');
  AData.AddPropertyRedecl('OnMouseActivate');
  AData.AddPropertyRedecl('OnMouseDown');
  AData.AddPropertyRedecl('OnMouseMove');
  AData.AddPropertyRedecl('OnMouseUp');
  AData.AddPropertyRedecl('OnPaint');
  AData.AddPropertyRedecl('OnResize');
  AData.AddPropertyRedecl('OnStartDock');
  AData.AddPropertyRedecl('OnStartDrag');
  AData.AddPropertyRedecl('OnUnDock');
end;

class function TActionToolBar_sw.ToVar(
  const AValue: TActionToolBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TActionToolBar_sw.FromVar(
  const AValue: OleVariant): TActionToolBar;
begin
  Result := TActionToolBar(ConvFromVar(AValue, TActionToolBar));
end;

class function TActionToolBar_sw.ClassToVar(
  AClass: TActionToolBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TActionToolBar_sw.ClassFromVar(
  const AClass: OleVariant): TActionToolBar_sc;
begin
  Result := TActionToolBar_sc(ConvClsFromVar(AClass, TActionToolBar));
end;

{ ActnCtrls_sw }

function ActnCtrls_TCustomButtonControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomButtonControl = class(TCustomActionControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomButtonControl_sw);
end;

function ActnCtrls_TCustomUtilityButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomUtilityButton = class(TCustomButtonControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomUtilityButton_sw);
end;

function ActnCtrls_TCustomToolScrollBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomToolScrollBtn = class(TCustomUtilityButton);

  Result := TLMDUnitWrapper.TypeToVar(TCustomToolScrollBtn_sw);
end;

function ActnCtrls_TCustomDropDownButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomDropDownButton = class(TCustomButtonControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomDropDownButton_sw);
end;

function ActnCtrls_TCustomActionCombo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionCombo = class(TCustomComboBoxEx);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionCombo_sw);
end;

function ActnCtrls_TCustomComboControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomComboControl = class(TCustomActionControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomComboControl_sw);
end;

function ActnCtrls_TCustomActionDockBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionDockBar = class(TCustomActionBar);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionDockBar_sw);
end;

function ActnCtrls_TCustomToolScrollBtnClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomToolScrollBtnClass = class of TCustomToolScro...

  Result := TLMDUnitWrapper.TypeToVar(TCustomToolScrollBtnClass_sw);
end;

function ActnCtrls_TCustomActionToolBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActionToolBar = class(TCustomActionDockBar);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActionToolBar_sw);
end;

function ActnCtrls_TActionToolBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActionToolBar = class(TCustomActionToolBar);

  Result := TLMDUnitWrapper.TypeToVar(TActionToolBar_sw);
end;

class function ActnCtrls_sw.GetUnitName: WideString;
begin
  Result := 'ActnCtrls';
end;

class procedure ActnCtrls_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TCustomButtonControl_sw, ActnCtrls_TCustomButtonControl_si);
  AData.AddType(TCustomUtilityButton_sw, ActnCtrls_TCustomUtilityButton_si);
  AData.AddType(TCustomToolScrollBtn_sw, ActnCtrls_TCustomToolScrollBtn_si);
  AData.AddType(TCustomDropDownButton_sw, ActnCtrls_TCustomDropDownButton_si);
  AData.AddType(TCustomActionCombo_sw, ActnCtrls_TCustomActionCombo_si);
  AData.AddType(TCustomComboControl_sw, ActnCtrls_TCustomComboControl_si);
  AData.AddType(TCustomActionDockBar_sw, ActnCtrls_TCustomActionDockBar_si);
  AData.AddType(TCustomToolScrollBtnClass_sw, ActnCtrls_TCustomToolScrollBtnClass_si);
  AData.AddType(TCustomActionToolBar_sw, ActnCtrls_TCustomActionToolBar_si);
  AData.AddType(TActionToolBar_sw, ActnCtrls_TActionToolBar_si);
end;

class function ActnCtrls_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ActnCtrls_sw);
end;

initialization
  RegisterUnitWrapper(ActnCtrls_sw);
  RegisterClassWrapper(TCustomButtonControl_sw);
  RegisterClassWrapper(TCustomUtilityButton_sw);
  RegisterClassWrapper(TCustomToolScrollBtn_sw);
  RegisterClassWrapper(TCustomDropDownButton_sw);
  RegisterClassWrapper(TCustomActionCombo_sw);
  RegisterClassWrapper(TCustomComboControl_sw);
  RegisterClassWrapper(TCustomActionDockBar_sw);
  RegisterClassWrapper(TCustomActionToolBar_sw);
  RegisterClassWrapper(TActionToolBar_sw);

end.
