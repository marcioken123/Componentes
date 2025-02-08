unit DBCtrls_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'DBCtrls' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers,
  Variants, Windows, SysUtils, Messages, Controls, Forms, Classes, Graphics,
  Menus, StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, DB, RichEdit, DBCtrls,
  Variants_LMDSW, Windows_LMDSW, SysUtils_LMDSW, Messages_LMDSW,
  Controls_LMDSW, Forms_LMDSW, Classes_LMDSW, Graphics_LMDSW, Menus_LMDSW,
  StdCtrls_LMDSW, ExtCtrls_LMDSW, Mask_LMDSW, Buttons_LMDSW, ComCtrls_LMDSW,
  DB_LMDSW, RichEdit_LMDSW;


{ Type wrappers }

type
  TFieldDataLink_sw = class;
  TPaintControl_sw = class;
  TDBEdit_sw = class;
  TDBText_sw = class;
  TDBCheckBox_sw = class;
  TDBComboBox_sw = class;
  TDBListBox_sw = class;
  TDBRadioGroup_sw = class;
  TDBMemo_sw = class;
  TDBImage_sw = class;
  TDBNavigator_sw = class;
  TNavButton_sw = class;
  TNavDataLink_sw = class;
  TDataSourceLink_sw = class;
  TListSourceLink_sw = class;
  TDBLookupControl_sw = class;
  TDBLookupListBox_sw = class;
  TPopupDataList_sw = class;
  TDBLookupComboBox_sw = class;
  TDBRichEdit_sw = class;

  TFieldDataLink_sc = class of TFieldDataLink;
  TFieldDataLink_sw = class(TDataLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFieldDataLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldDataLink;
    class function ClassToVar(AClass: TFieldDataLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFieldDataLink_sc;
  end;

  TPaintControl_sc = class of TPaintControl;
  TPaintControl_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPaintControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TPaintControl;
    class function ClassToVar(AClass: TPaintControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPaintControl_sc;
  end;

  TDBEdit_sc = class of TDBEdit;
  TDBEdit_sw = class(TCustomMaskEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBEdit;
    class function ClassToVar(AClass: TDBEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBEdit_sc;
  end;

  TDBText_sc = class of TDBText;
  TDBText_sw = class(TCustomLabel_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBText): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBText;
    class function ClassToVar(AClass: TDBText_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBText_sc;
  end;

  TDBCheckBox_sc = class of TDBCheckBox;
  TDBCheckBox_sw = class(TCustomCheckBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBCheckBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBCheckBox;
    class function ClassToVar(AClass: TDBCheckBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBCheckBox_sc;
  end;

  TDBComboBox_sc = class of TDBComboBox;
  TDBComboBox_sw = class(TCustomComboBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBComboBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBComboBox;
    class function ClassToVar(AClass: TDBComboBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBComboBox_sc;
  end;

  TDBListBox_sc = class of TDBListBox;
  TDBListBox_sw = class(TCustomListBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBListBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBListBox;
    class function ClassToVar(AClass: TDBListBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBListBox_sc;
  end;

  TDBRadioGroup_sc = class of TDBRadioGroup;
  TDBRadioGroup_sw = class(TCustomRadioGroup_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBRadioGroup): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBRadioGroup;
    class function ClassToVar(AClass: TDBRadioGroup_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBRadioGroup_sc;
  end;

  TDBMemo_sc = class of TDBMemo;
  TDBMemo_sw = class(TCustomMemo_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBMemo): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBMemo;
    class function ClassToVar(AClass: TDBMemo_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBMemo_sc;
  end;

  TDBImage_sc = class of TDBImage;
  TDBImage_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBImage): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBImage;
    class function ClassToVar(AClass: TDBImage_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBImage_sc;
  end;

  TNavGlyph_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TNavGlyph): OleVariant;
    class function FromVar(const AValue: OleVariant): TNavGlyph;
  end;

  TNavigateBtn_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TNavigateBtn): OleVariant;
    class function FromVar(const AValue: OleVariant): TNavigateBtn;
  end;

  TNavButtonSet_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TNavButtonSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TNavButtonSet;
  end;

  ENavClick_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Button: TNavigateBtn);
  end;

  ENavClick_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: ENavClick): OleVariant;
    class function FromVar(const AValue: OleVariant): ENavClick;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): ENavClick;
  end;

  TDBNavigator_sc = class of TDBNavigator;
  TDBNavigator_sw = class(TCustomPanel_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBNavigator): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBNavigator;
    class function ClassToVar(AClass: TDBNavigator_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBNavigator_sc;
  end;

  TNavButton_sc = class of TNavButton;
  TNavButton_sw = class(TSpeedButton_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TNavButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TNavButton;
    class function ClassToVar(AClass: TNavButton_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TNavButton_sc;
  end;

  TNavDataLink_sc = class of TNavDataLink;
  TNavDataLink_sw = class(TDataLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TNavDataLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TNavDataLink;
    class function ClassToVar(AClass: TNavDataLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TNavDataLink_sc;
  end;

  TDataSourceLink_sc = class of TDataSourceLink;
  TDataSourceLink_sw = class(TDataLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDataSourceLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TDataSourceLink;
    class function ClassToVar(AClass: TDataSourceLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDataSourceLink_sc;
  end;

  TListSourceLink_sc = class of TListSourceLink;
  TListSourceLink_sw = class(TDataLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TListSourceLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TListSourceLink;
    class function ClassToVar(AClass: TListSourceLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TListSourceLink_sc;
  end;

  TDBLookupControl_sc = class of TDBLookupControl;
  TDBLookupControl_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBLookupControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBLookupControl;
    class function ClassToVar(AClass: TDBLookupControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBLookupControl_sc;
  end;

  TDBLookupListBox_sc = class of TDBLookupListBox;
  TDBLookupListBox_sw = class(TDBLookupControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBLookupListBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBLookupListBox;
    class function ClassToVar(AClass: TDBLookupListBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBLookupListBox_sc;
  end;

  TPopupDataList_sc = class of TPopupDataList;
  TPopupDataList_sw = class(TDBLookupListBox_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPopupDataList): OleVariant;
    class function FromVar(const AValue: OleVariant): TPopupDataList;
    class function ClassToVar(AClass: TPopupDataList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPopupDataList_sc;
  end;

  TDropDownAlign_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDropDownAlign): OleVariant;
    class function FromVar(const AValue: OleVariant): TDropDownAlign;
  end;

  TDBLookupComboBox_sc = class of TDBLookupComboBox;
  TDBLookupComboBox_sw = class(TDBLookupControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBLookupComboBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBLookupComboBox;
    class function ClassToVar(AClass: TDBLookupComboBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBLookupComboBox_sc;
  end;

  TDBRichEdit_sc = class of TDBRichEdit;
  TDBRichEdit_sw = class(TCustomRichEdit_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBRichEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBRichEdit;
    class function ClassToVar(AClass: TDBRichEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBRichEdit_sc;
  end;


{ Unit wrapper }

type
  DBCtrls_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TDBRadioGroup_sacc = class(TDBRadioGroup);
  TDBLookupControl_sacc = class(TDBLookupControl);

{ TFieldDataLink_sw }

function TFieldDataLink_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TFieldDataLink_sw.ToVar(TFieldDataLink_sc(AObj).Create());
end;

function TFieldDataLink_Edit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Edit: Boolean;

  Result := TFieldDataLink(AObj).Edit();
end;

function TFieldDataLink_Modified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Modified;

  TFieldDataLink(AObj).Modified();
end;

function TFieldDataLink_Reset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Reset;

  TFieldDataLink(AObj).Reset();
end;

function TFieldDataLink_CanModify_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CanModify: Boolean read <getter>;

  Result := TFieldDataLink(AObj).CanModify;
end;

function TFieldDataLink_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Control: TComponent read <getter> write <setter>;

  if IsGet then
    Result := TComponent_sw.ToVar(TFieldDataLink(AObj).Control)
  else
    TFieldDataLink(AObj).Control := TComponent_sw.FromVar(AArgs[0]);
end;

function TFieldDataLink_Editing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Editing: Boolean read <getter>;

  Result := TFieldDataLink(AObj).Editing;
end;

function TFieldDataLink_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TFieldDataLink(AObj).Field);
end;

function TFieldDataLink_FieldName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldName: WideString read <getter> write <setter>;

  if IsGet then
    Result := TFieldDataLink(AObj).FieldName
  else
    TFieldDataLink(AObj).FieldName := WideString(AArgs[0]);
end;

function TFieldDataLink_OnDataChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDataChange: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TFieldDataLink(AObj).OnDataChange)
  else
    TFieldDataLink(AObj).OnDataChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TFieldDataLink_OnEditingChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnEditingChange: TNotifyEvent read <getter> writ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TFieldDataLink(AObj).OnEditingChange)
  else
    TFieldDataLink(AObj).OnEditingChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TFieldDataLink_OnUpdateData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnUpdateData: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TFieldDataLink(AObj).OnUpdateData)
  else
    TFieldDataLink(AObj).OnUpdateData := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TFieldDataLink_OnActiveChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnActiveChange: TNotifyEvent read <getter> write...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TFieldDataLink(AObj).OnActiveChange)
  else
    TFieldDataLink(AObj).OnActiveChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TFieldDataLink_sw.GetTypeName: WideString;
begin
  Result := 'TFieldDataLink';
end;

class function TFieldDataLink_sw.GetWrappedClass: TClass;
begin
  Result := TFieldDataLink;
end;

class procedure TFieldDataLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Edit', TFieldDataLink_Edit_si, Boolean_sw, 0, False);
  AData.AddProcedure('Modified', TFieldDataLink_Modified_si, 0, False);
  AData.AddProcedure('Reset', TFieldDataLink_Reset_si, 0, False);
  AData.AddProperty('CanModify', TFieldDataLink_CanModify_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Control', TFieldDataLink_Control_si, TComponent_sw, True, True, 0, False, False);
  AData.AddProperty('Editing', TFieldDataLink_Editing_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Field', TFieldDataLink_Field_si, TField_sw, True, False, 0, False, False);
  AData.AddProperty('FieldName', TFieldDataLink_FieldName_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('OnDataChange', TFieldDataLink_OnDataChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnEditingChange', TFieldDataLink_OnEditingChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnUpdateData', TFieldDataLink_OnUpdateData_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnActiveChange', TFieldDataLink_OnActiveChange_si, TNotifyEvent_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TFieldDataLink_Create_si, 0, False);
end;

class function TFieldDataLink_sw.ToVar(
  const AValue: TFieldDataLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFieldDataLink_sw.FromVar(
  const AValue: OleVariant): TFieldDataLink;
begin
  Result := TFieldDataLink(ConvFromVar(AValue, TFieldDataLink));
end;

class function TFieldDataLink_sw.ClassToVar(
  AClass: TFieldDataLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFieldDataLink_sw.ClassFromVar(
  const AClass: OleVariant): TFieldDataLink_sc;
begin
  Result := TFieldDataLink_sc(ConvClsFromVar(AClass, TFieldDataLink));
end;

{ TPaintControl_sw }

function TPaintControl_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AOwner: TWinControl; const ClassName: ...

  Result := TPaintControl_sw.ToVar(TPaintControl_sc(AObj).Create(TWinControl_sw.
    FromVar(AArgs[0]), string(AArgs[1])));
end;

function TPaintControl_DestroyHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DestroyHandle;

  TPaintControl(AObj).DestroyHandle();
end;

function TPaintControl_Ctl3DButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Ctl3DButton: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TPaintControl(AObj).Ctl3DButton
  else
    TPaintControl(AObj).Ctl3DButton := Boolean(AArgs[0]);
end;

function TPaintControl_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWnd read <getter>;

  Result := HWnd_sw.ToVar(TPaintControl(AObj).Handle);
end;

class function TPaintControl_sw.GetTypeName: WideString;
begin
  Result := 'TPaintControl';
end;

class function TPaintControl_sw.GetWrappedClass: TClass;
begin
  Result := TPaintControl;
end;

class procedure TPaintControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('DestroyHandle', TPaintControl_DestroyHandle_si, 0, False);
  AData.AddProperty('Ctl3DButton', TPaintControl_Ctl3DButton_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Handle', TPaintControl_Handle_si, HWnd_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TPaintControl_Create_si, 2, False);
end;

class function TPaintControl_sw.ToVar(const AValue: TPaintControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPaintControl_sw.FromVar(
  const AValue: OleVariant): TPaintControl;
begin
  Result := TPaintControl(ConvFromVar(AValue, TPaintControl));
end;

class function TPaintControl_sw.ClassToVar(
  AClass: TPaintControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPaintControl_sw.ClassFromVar(
  const AClass: OleVariant): TPaintControl_sc;
begin
  Result := TPaintControl_sc(ConvClsFromVar(AClass, TPaintControl));
end;

{ TDBEdit_sw }

function TDBEdit_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TDBEdit(AObj).Field);
end;

function TDBEdit_DataField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataField: WideString read <getter> write <setter>;

  if IsGet then
    Result := TDBEdit(AObj).DataField
  else
    TDBEdit(AObj).DataField := WideString(AArgs[0]);
end;

function TDBEdit_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBEdit(AObj).DataSource)
  else
    TDBEdit(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDBEdit_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBEdit(AObj).ReadOnly
  else
    TDBEdit(AObj).ReadOnly := Boolean(AArgs[0]);
end;

class function TDBEdit_sw.GetTypeName: WideString;
begin
  Result := 'TDBEdit';
end;

class function TDBEdit_sw.GetWrappedClass: TClass;
begin
  Result := TDBEdit;
end;

class procedure TDBEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Field', TDBEdit_Field_si, TField_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSelect', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('CharCase', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('DataField', TDBEdit_DataField_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TDBEdit_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('MaxLength', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PasswordChar', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('ReadOnly', TDBEdit_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
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
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBEdit_sw.ToVar(const AValue: TDBEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBEdit_sw.FromVar(const AValue: OleVariant): TDBEdit;
begin
  Result := TDBEdit(ConvFromVar(AValue, TDBEdit));
end;

class function TDBEdit_sw.ClassToVar(AClass: TDBEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBEdit_sw.ClassFromVar(const AClass: OleVariant): TDBEdit_sc;
begin
  Result := TDBEdit_sc(ConvClsFromVar(AClass, TDBEdit));
end;

{ TDBText_sw }

function TDBText_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TDBText(AObj).Field);
end;

function TDBText_DataField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataField: WideString read <getter> write <setter>;

  if IsGet then
    Result := TDBText(AObj).DataField
  else
    TDBText(AObj).DataField := WideString(AArgs[0]);
end;

function TDBText_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBText(AObj).DataSource)
  else
    TDBText(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

class function TDBText_sw.GetTypeName: WideString;
begin
  Result := 'TDBText';
end;

class function TDBText_sw.GetWrappedClass: TClass;
begin
  Result := TDBText;
end;

class procedure TDBText_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Field', TDBText_Field_si, TField_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddProperty('DataField', TDBText_DataField_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TDBText_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('Transparent', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBText_sw.ToVar(const AValue: TDBText): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBText_sw.FromVar(const AValue: OleVariant): TDBText;
begin
  Result := TDBText(ConvFromVar(AValue, TDBText));
end;

class function TDBText_sw.ClassToVar(AClass: TDBText_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBText_sw.ClassFromVar(const AClass: OleVariant): TDBText_sc;
begin
  Result := TDBText_sc(ConvClsFromVar(AClass, TDBText));
end;

{ TDBCheckBox_sw }

function TDBCheckBox_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TDBCheckBox(AObj).Field);
end;

function TDBCheckBox_DataField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataField: WideString read <getter> write <setter>;

  if IsGet then
    Result := TDBCheckBox(AObj).DataField
  else
    TDBCheckBox(AObj).DataField := WideString(AArgs[0]);
end;

function TDBCheckBox_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBCheckBox(AObj).DataSource)
  else
    TDBCheckBox(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDBCheckBox_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBCheckBox(AObj).ReadOnly
  else
    TDBCheckBox(AObj).ReadOnly := Boolean(AArgs[0]);
end;

function TDBCheckBox_ValueChecked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ValueChecked: string read <getter> write <setter>;

  if IsGet then
    Result := TDBCheckBox(AObj).ValueChecked
  else
    TDBCheckBox(AObj).ValueChecked := string(AArgs[0]);
end;

function TDBCheckBox_ValueUnchecked_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ValueUnchecked: string read <getter> write <sett...

  if IsGet then
    Result := TDBCheckBox(AObj).ValueUnchecked
  else
    TDBCheckBox(AObj).ValueUnchecked := string(AArgs[0]);
end;

class function TDBCheckBox_sw.GetTypeName: WideString;
begin
  Result := 'TDBCheckBox';
end;

class function TDBCheckBox_sw.GetWrappedClass: TClass;
begin
  Result := TDBCheckBox;
end;

class procedure TDBCheckBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Checked', False);
  AData.AddProperty('Field', TDBCheckBox_Field_si, TField_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('State', False);
  AData.AddPropertyRedecl('Action', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('AllowGrayed', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('DataField', TDBCheckBox_DataField_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TDBCheckBox_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('ReadOnly', TDBCheckBox_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddProperty('ValueChecked', TDBCheckBox_ValueChecked_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ValueUnchecked', TDBCheckBox_ValueUnchecked_si, string_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBCheckBox_sw.ToVar(const AValue: TDBCheckBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBCheckBox_sw.FromVar(const AValue: OleVariant): TDBCheckBox;
begin
  Result := TDBCheckBox(ConvFromVar(AValue, TDBCheckBox));
end;

class function TDBCheckBox_sw.ClassToVar(AClass: TDBCheckBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBCheckBox_sw.ClassFromVar(
  const AClass: OleVariant): TDBCheckBox_sc;
begin
  Result := TDBCheckBox_sc(ConvClsFromVar(AClass, TDBCheckBox));
end;

{ TDBComboBox_sw }

function TDBComboBox_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TDBComboBox(AObj).Field);
end;

function TDBComboBox_DataField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataField: WideString read <getter> write <setter>;

  if IsGet then
    Result := TDBComboBox(AObj).DataField
  else
    TDBComboBox(AObj).DataField := WideString(AArgs[0]);
end;

function TDBComboBox_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBComboBox(AObj).DataSource)
  else
    TDBComboBox(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDBComboBox_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBComboBox(AObj).ReadOnly
  else
    TDBComboBox(AObj).ReadOnly := Boolean(AArgs[0]);
end;

class function TDBComboBox_sw.GetTypeName: WideString;
begin
  Result := 'TDBComboBox';
end;

class function TDBComboBox_sw.GetWrappedClass: TClass;
begin
  Result := TDBComboBox;
end;

class procedure TDBComboBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Field', TDBComboBox_Field_si, TField_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Text', False);
  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoComplete', False);
  AData.AddPropertyRedecl('AutoDropDown', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('CharCase', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('DataField', TDBComboBox_DataField_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TDBComboBox_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('DropDownCount', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('ItemHeight', False);
  AData.AddPropertyRedecl('Items', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('ReadOnly', TDBComboBox_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Sorted', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnDrawItem', False);
  AData.AddPropertyRedecl('OnDropDown', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMeasureItem', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBComboBox_sw.ToVar(const AValue: TDBComboBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBComboBox_sw.FromVar(const AValue: OleVariant): TDBComboBox;
begin
  Result := TDBComboBox(ConvFromVar(AValue, TDBComboBox));
end;

class function TDBComboBox_sw.ClassToVar(AClass: TDBComboBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBComboBox_sw.ClassFromVar(
  const AClass: OleVariant): TDBComboBox_sc;
begin
  Result := TDBComboBox_sc(ConvClsFromVar(AClass, TDBComboBox));
end;

{ TDBListBox_sw }

function TDBListBox_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TDBListBox(AObj).Field);
end;

function TDBListBox_DataField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataField: WideString read <getter> write <setter>;

  if IsGet then
    Result := TDBListBox(AObj).DataField
  else
    TDBListBox(AObj).DataField := WideString(AArgs[0]);
end;

function TDBListBox_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBListBox(AObj).DataSource)
  else
    TDBListBox(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDBListBox_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBListBox(AObj).ReadOnly
  else
    TDBListBox(AObj).ReadOnly := Boolean(AArgs[0]);
end;

class function TDBListBox_sw.GetTypeName: WideString;
begin
  Result := 'TDBListBox';
end;

class function TDBListBox_sw.GetWrappedClass: TClass;
begin
  Result := TDBListBox;
end;

class procedure TDBListBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Field', TDBListBox_Field_si, TField_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
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
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('DataField', TDBListBox_DataField_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TDBListBox_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
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
  AData.AddProperty('ReadOnly', TDBListBox_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('Style', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnDrawItem', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
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

class function TDBListBox_sw.ToVar(const AValue: TDBListBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBListBox_sw.FromVar(const AValue: OleVariant): TDBListBox;
begin
  Result := TDBListBox(ConvFromVar(AValue, TDBListBox));
end;

class function TDBListBox_sw.ClassToVar(AClass: TDBListBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBListBox_sw.ClassFromVar(
  const AClass: OleVariant): TDBListBox_sc;
begin
  Result := TDBListBox_sc(ConvClsFromVar(AClass, TDBListBox));
end;

{ TDBRadioGroup_sw }

function TDBRadioGroup_DataLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DataLink: TFieldDataLink read <getter>;

  Result := TFieldDataLink_sw.ToVar(TDBRadioGroup_sacc(TDBRadioGroup(AObj)).
    DataLink);
end;

function TDBRadioGroup_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TDBRadioGroup(AObj).Field);
end;

function TDBRadioGroup_Value_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Value: string read <getter> write <setter>;

  if IsGet then
    Result := TDBRadioGroup(AObj).Value
  else
    TDBRadioGroup(AObj).Value := string(AArgs[0]);
end;

function TDBRadioGroup_DataField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataField: WideString read <getter> write <setter>;

  if IsGet then
    Result := TDBRadioGroup(AObj).DataField
  else
    TDBRadioGroup(AObj).DataField := WideString(AArgs[0]);
end;

function TDBRadioGroup_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBRadioGroup(AObj).DataSource)
  else
    TDBRadioGroup(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDBRadioGroup_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBRadioGroup(AObj).ReadOnly
  else
    TDBRadioGroup(AObj).ReadOnly := Boolean(AArgs[0]);
end;

function TDBRadioGroup_Values_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Values: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TDBRadioGroup(AObj).Values)
  else
    TDBRadioGroup(AObj).Values := TStrings_sw.FromVar(AArgs[0]);
end;

function TDBRadioGroup_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDBRadioGroup(AObj).OnChange)
  else
    TDBRadioGroup(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TDBRadioGroup_sw.GetTypeName: WideString;
begin
  Result := 'TDBRadioGroup';
end;

class function TDBRadioGroup_sw.GetWrappedClass: TClass;
begin
  Result := TDBRadioGroup;
end;

class procedure TDBRadioGroup_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DataLink', TDBRadioGroup_DataLink_si, TFieldDataLink_sw, True, False, 0, True, False);
  AData.AddProperty('Field', TDBRadioGroup_Field_si, TField_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('ItemIndex', False);
  AData.AddProperty('Value', TDBRadioGroup_Value_si, string_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Columns', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('DataField', TDBRadioGroup_DataField_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TDBRadioGroup_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('Items', False);
  AData.AddPropertyRedecl('ParentBackground', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('ReadOnly', TDBRadioGroup_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddProperty('Values', TDBRadioGroup_Values_si, TStrings_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddProperty('OnChange', TDBRadioGroup_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBRadioGroup_sw.ToVar(const AValue: TDBRadioGroup): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBRadioGroup_sw.FromVar(
  const AValue: OleVariant): TDBRadioGroup;
begin
  Result := TDBRadioGroup(ConvFromVar(AValue, TDBRadioGroup));
end;

class function TDBRadioGroup_sw.ClassToVar(
  AClass: TDBRadioGroup_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBRadioGroup_sw.ClassFromVar(
  const AClass: OleVariant): TDBRadioGroup_sc;
begin
  Result := TDBRadioGroup_sc(ConvClsFromVar(AClass, TDBRadioGroup));
end;

{ TDBMemo_sw }

function TDBMemo_LoadMemo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadMemo;

  TDBMemo(AObj).LoadMemo();
end;

function TDBMemo_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TDBMemo(AObj).Field);
end;

function TDBMemo_AutoDisplay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoDisplay: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBMemo(AObj).AutoDisplay
  else
    TDBMemo(AObj).AutoDisplay := Boolean(AArgs[0]);
end;

function TDBMemo_DataField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataField: WideString read <getter> write <setter>;

  if IsGet then
    Result := TDBMemo(AObj).DataField
  else
    TDBMemo(AObj).DataField := WideString(AArgs[0]);
end;

function TDBMemo_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBMemo(AObj).DataSource)
  else
    TDBMemo(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDBMemo_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBMemo(AObj).ReadOnly
  else
    TDBMemo(AObj).ReadOnly := Boolean(AArgs[0]);
end;

class function TDBMemo_sw.GetTypeName: WideString;
begin
  Result := 'TDBMemo';
end;

class function TDBMemo_sw.GetWrappedClass: TClass;
begin
  Result := TDBMemo;
end;

class procedure TDBMemo_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('LoadMemo', TDBMemo_LoadMemo_si, 0, False);
  AData.AddProperty('Field', TDBMemo_Field_si, TField_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddProperty('AutoDisplay', TDBMemo_AutoDisplay_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('DataField', TDBMemo_DataField_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TDBMemo_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('HideSelection', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('MaxLength', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('ReadOnly', TDBMemo_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ScrollBars', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WantReturns', False);
  AData.AddPropertyRedecl('WantTabs', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
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
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBMemo_sw.ToVar(const AValue: TDBMemo): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBMemo_sw.FromVar(const AValue: OleVariant): TDBMemo;
begin
  Result := TDBMemo(ConvFromVar(AValue, TDBMemo));
end;

class function TDBMemo_sw.ClassToVar(AClass: TDBMemo_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBMemo_sw.ClassFromVar(const AClass: OleVariant): TDBMemo_sc;
begin
  Result := TDBMemo_sc(ConvClsFromVar(AClass, TDBMemo));
end;

{ TDBImage_sw }

function TDBImage_CopyToClipboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CopyToClipboard;

  TDBImage(AObj).CopyToClipboard();
end;

function TDBImage_CutToClipboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CutToClipboard;

  TDBImage(AObj).CutToClipboard();
end;

function TDBImage_LoadPicture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadPicture;

  TDBImage(AObj).LoadPicture();
end;

function TDBImage_PasteFromClipboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure PasteFromClipboard;

  TDBImage(AObj).PasteFromClipboard();
end;

function TDBImage_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TDBImage(AObj).Field);
end;

function TDBImage_Picture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Picture: TPicture read <getter> write <setter>;

  if IsGet then
    Result := TPicture_sw.ToVar(TDBImage(AObj).Picture)
  else
    TDBImage(AObj).Picture := TPicture_sw.FromVar(AArgs[0]);
end;

function TDBImage_AutoDisplay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoDisplay: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBImage(AObj).AutoDisplay
  else
    TDBImage(AObj).AutoDisplay := Boolean(AArgs[0]);
end;

function TDBImage_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BorderStyle: TBorderStyle read <getter> write <s...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TDBImage(AObj).BorderStyle)
  else
    TDBImage(AObj).BorderStyle := TBorderStyle_sw.FromVar(AArgs[0]);
end;

function TDBImage_Center_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Center: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBImage(AObj).Center
  else
    TDBImage(AObj).Center := Boolean(AArgs[0]);
end;

function TDBImage_DataField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataField: WideString read <getter> write <setter>;

  if IsGet then
    Result := TDBImage(AObj).DataField
  else
    TDBImage(AObj).DataField := WideString(AArgs[0]);
end;

function TDBImage_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBImage(AObj).DataSource)
  else
    TDBImage(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDBImage_Proportional_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Proportional: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBImage(AObj).Proportional
  else
    TDBImage(AObj).Proportional := Boolean(AArgs[0]);
end;

function TDBImage_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBImage(AObj).ReadOnly
  else
    TDBImage(AObj).ReadOnly := Boolean(AArgs[0]);
end;

function TDBImage_QuickDraw_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property QuickDraw: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBImage(AObj).QuickDraw
  else
    TDBImage(AObj).QuickDraw := Boolean(AArgs[0]);
end;

function TDBImage_Stretch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Stretch: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBImage(AObj).Stretch
  else
    TDBImage(AObj).Stretch := Boolean(AArgs[0]);
end;

class function TDBImage_sw.GetTypeName: WideString;
begin
  Result := 'TDBImage';
end;

class function TDBImage_sw.GetWrappedClass: TClass;
begin
  Result := TDBImage;
end;

class procedure TDBImage_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('CopyToClipboard', TDBImage_CopyToClipboard_si, 0, False);
  AData.AddProcedure('CutToClipboard', TDBImage_CutToClipboard_si, 0, False);
  AData.AddProcedure('LoadPicture', TDBImage_LoadPicture_si, 0, False);
  AData.AddProcedure('PasteFromClipboard', TDBImage_PasteFromClipboard_si, 0, False);
  AData.AddProperty('Field', TDBImage_Field_si, TField_sw, True, False, 0, False, False);
  AData.AddProperty('Picture', TDBImage_Picture_si, TPicture_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddProperty('AutoDisplay', TDBImage_AutoDisplay_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('BorderStyle', TDBImage_BorderStyle_si, TBorderStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Center', TDBImage_Center_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('DataField', TDBImage_DataField_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TDBImage_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('Proportional', TDBImage_Proportional_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ReadOnly', TDBImage_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('QuickDraw', TDBImage_QuickDraw_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddProperty('Stretch', TDBImage_Stretch_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
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
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBImage_sw.ToVar(const AValue: TDBImage): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBImage_sw.FromVar(const AValue: OleVariant): TDBImage;
begin
  Result := TDBImage(ConvFromVar(AValue, TDBImage));
end;

class function TDBImage_sw.ClassToVar(AClass: TDBImage_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBImage_sw.ClassFromVar(const AClass: OleVariant): TDBImage_sc;
begin
  Result := TDBImage_sc(ConvClsFromVar(AClass, TDBImage));
end;

{ TNavGlyph_sw }

class function TNavGlyph_sw.GetTypeName: WideString;
begin
  Result := 'TNavGlyph';
end;

class procedure TNavGlyph_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'ngEnabled'; Value: Integer({$IFDEF LMDSCT_12}TNavGlyph.{$ENDIF}ngEnabled)),
    (Name: 'ngDisabled'; Value: Integer({$IFDEF LMDSCT_12}TNavGlyph.{$ENDIF}ngDisabled))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TNavGlyph_sw.ToVar(const AValue: TNavGlyph): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TNavGlyph_sw.FromVar(const AValue: OleVariant): TNavGlyph;
begin
  Result := TNavGlyph(Integer(AValue));
end;

{ TNavigateBtn_sw }

class function TNavigateBtn_sw.GetTypeName: WideString;
begin
  Result := 'TNavigateBtn';
end;

class procedure TNavigateBtn_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..9] of TLMDEnumerator = (
    (Name: 'nbFirst'; Value: Integer({$IFDEF LMDSCT_12}TNavigateBtn.{$ENDIF}nbFirst)),
    (Name: 'nbPrior'; Value: Integer({$IFDEF LMDSCT_12}TNavigateBtn.{$ENDIF}nbPrior)),
    (Name: 'nbNext'; Value: Integer({$IFDEF LMDSCT_12}TNavigateBtn.{$ENDIF}nbNext)),
    (Name: 'nbLast'; Value: Integer({$IFDEF LMDSCT_12}TNavigateBtn.{$ENDIF}nbLast)),
    (Name: 'nbInsert'; Value: Integer({$IFDEF LMDSCT_12}TNavigateBtn.{$ENDIF}nbInsert)),
    (Name: 'nbDelete'; Value: Integer({$IFDEF LMDSCT_12}TNavigateBtn.{$ENDIF}nbDelete)),
    (Name: 'nbEdit'; Value: Integer({$IFDEF LMDSCT_12}TNavigateBtn.{$ENDIF}nbEdit)),
    (Name: 'nbPost'; Value: Integer({$IFDEF LMDSCT_12}TNavigateBtn.{$ENDIF}nbPost)),
    (Name: 'nbCancel'; Value: Integer({$IFDEF LMDSCT_12}TNavigateBtn.{$ENDIF}nbCancel)),
    (Name: 'nbRefresh'; Value: Integer({$IFDEF LMDSCT_12}TNavigateBtn.{$ENDIF}nbRefresh))
  );
begin
  AEnums := @ENUMS;
  ACount := 10;
end;

class function TNavigateBtn_sw.ToVar(const AValue: TNavigateBtn): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TNavigateBtn_sw.FromVar(const AValue: OleVariant): TNavigateBtn;
begin
  Result := TNavigateBtn(Integer(AValue));
end;

{ TNavButtonSet_sw }

class function TNavButtonSet_sw.GetTypeName: WideString;
begin
  Result := 'TNavButtonSet';
end;

class function TNavButtonSet_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TNavButtonSet);
end;

class function TNavButtonSet_sw.ToVar(const AValue: TNavButtonSet): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TNavButtonSet_sw.FromVar(
  const AValue: OleVariant): TNavButtonSet;
begin
  ConvFromVar(AValue, @Result);
end;

{ ENavClick_sh }

function ENavClick_sh.GetHandler: TMethod;
var
  hdr: ENavClick;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure ENavClick_sh.Handler(Sender: TObject; Button: TNavigateBtn);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Button: TNavigateBtn) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TNavigateBtn_sw.ToVar(Button);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ ENavClick_sw }

class function ENavClick_sw.GetTypeName: WideString;
begin
  Result := 'ENavClick';
end;

class function ENavClick_sw.GetScriptHandlerClass: TClass;
begin
  Result := ENavClick_sh;
end;

class function ENavClick_sw.ToVar(const AValue: ENavClick): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function ENavClick_sw.FromVar(const AValue: OleVariant): ENavClick;
begin
  Result := ENavClick(ConvFromVar(AValue));
end;

class function ENavClick_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): ENavClick;
var
  hdlr: ENavClick_sh;
begin
  hdlr   := ENavClick_sh(AScriptControl.GetEventHandler(AProcName, 
    ENavClick_sw));
  Result := hdlr.Handler;
end;

{ TDBNavigator_sw }

function TDBNavigator_BtnClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BtnClick(Index: TNavigateBtn);

  TDBNavigator(AObj).BtnClick(TNavigateBtn_sw.FromVar(AArgs[0]));
end;

function TDBNavigator_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBNavigator(AObj).DataSource)
  else
    TDBNavigator(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDBNavigator_VisibleButtons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property VisibleButtons: TNavButtonSet read <getter> writ...

  if IsGet then
    Result := TNavButtonSet_sw.ToVar(TDBNavigator(AObj).VisibleButtons)
  else
    TDBNavigator(AObj).VisibleButtons := TNavButtonSet_sw.FromVar(AArgs[0]);
end;

function TDBNavigator_Flat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Flat: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBNavigator(AObj).Flat
  else
    TDBNavigator(AObj).Flat := Boolean(AArgs[0]);
end;

function TDBNavigator_Hints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Hints: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TDBNavigator(AObj).Hints)
  else
    TDBNavigator(AObj).Hints := TStrings_sw.FromVar(AArgs[0]);
end;

function TDBNavigator_ConfirmDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ConfirmDelete: Boolean read <getter> write <sett...

  if IsGet then
    Result := TDBNavigator(AObj).ConfirmDelete
  else
    TDBNavigator(AObj).ConfirmDelete := Boolean(AArgs[0]);
end;

function TDBNavigator_BeforeAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeAction: ENavClick read <getter> write <set...

  if IsGet then
    Result := ENavClick_sw.ToVar(TDBNavigator(AObj).BeforeAction)
  else
    TDBNavigator(AObj).BeforeAction := ENavClick_sw.FromVar(AArgs[0]);
end;

function TDBNavigator_OnClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnClick: ENavClick read <getter> write <setter>;

  if IsGet then
    Result := ENavClick_sw.ToVar(TDBNavigator(AObj).OnClick)
  else
    TDBNavigator(AObj).OnClick := ENavClick_sw.FromVar(AArgs[0]);
end;

class function TDBNavigator_sw.GetTypeName: WideString;
begin
  Result := 'TDBNavigator';
end;

class function TDBNavigator_sw.GetWrappedClass: TClass;
begin
  Result := TDBNavigator;
end;

class procedure TDBNavigator_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('BtnClick', TDBNavigator_BtnClick_si, 1, False);
  AData.AddProperty('DataSource', TDBNavigator_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddProperty('VisibleButtons', TDBNavigator_VisibleButtons_si, TNavButtonSet_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddProperty('Flat', TDBNavigator_Flat_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('Hints', TDBNavigator_Hints_si, TStrings_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('ConfirmDelete', TDBNavigator_ConfirmDelete_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddProperty('BeforeAction', TDBNavigator_BeforeAction_si, ENavClick_sw, True, True, 0, False, False);
  AData.AddProperty('OnClick', TDBNavigator_OnClick_si, ENavClick_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBNavigator_sw.ToVar(const AValue: TDBNavigator): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBNavigator_sw.FromVar(const AValue: OleVariant): TDBNavigator;
begin
  Result := TDBNavigator(ConvFromVar(AValue, TDBNavigator));
end;

class function TDBNavigator_sw.ClassToVar(AClass: TDBNavigator_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBNavigator_sw.ClassFromVar(
  const AClass: OleVariant): TDBNavigator_sc;
begin
  Result := TDBNavigator_sc(ConvClsFromVar(AClass, TDBNavigator));
end;

{ TNavButton_sw }

function TNavButton_Index_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Index: TNavigateBtn read <getter> write <setter>;

  if IsGet then
    Result := TNavigateBtn_sw.ToVar(TNavButton(AObj).Index)
  else
    TNavButton(AObj).Index := TNavigateBtn_sw.FromVar(AArgs[0]);
end;

class function TNavButton_sw.GetTypeName: WideString;
begin
  Result := 'TNavButton';
end;

class function TNavButton_sw.GetWrappedClass: TClass;
begin
  Result := TNavButton;
end;

class procedure TNavButton_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Index', TNavButton_Index_si, TNavigateBtn_sw, True, True, 0, False, False);
end;

class function TNavButton_sw.ToVar(const AValue: TNavButton): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TNavButton_sw.FromVar(const AValue: OleVariant): TNavButton;
begin
  Result := TNavButton(ConvFromVar(AValue, TNavButton));
end;

class function TNavButton_sw.ClassToVar(AClass: TNavButton_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TNavButton_sw.ClassFromVar(
  const AClass: OleVariant): TNavButton_sc;
begin
  Result := TNavButton_sc(ConvClsFromVar(AClass, TNavButton));
end;

{ TNavDataLink_sw }

function TNavDataLink_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(ANav: TDBNavigator);

  Result := TNavDataLink_sw.ToVar(TNavDataLink_sc(AObj).Create(TDBNavigator_sw.
    FromVar(AArgs[0])));
end;

class function TNavDataLink_sw.GetTypeName: WideString;
begin
  Result := 'TNavDataLink';
end;

class function TNavDataLink_sw.GetWrappedClass: TClass;
begin
  Result := TNavDataLink;
end;

class procedure TNavDataLink_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TNavDataLink_Create_si, 1, False);
end;

class function TNavDataLink_sw.ToVar(const AValue: TNavDataLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TNavDataLink_sw.FromVar(const AValue: OleVariant): TNavDataLink;
begin
  Result := TNavDataLink(ConvFromVar(AValue, TNavDataLink));
end;

class function TNavDataLink_sw.ClassToVar(AClass: TNavDataLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TNavDataLink_sw.ClassFromVar(
  const AClass: OleVariant): TNavDataLink_sc;
begin
  Result := TNavDataLink_sc(ConvClsFromVar(AClass, TNavDataLink));
end;

{ TDataSourceLink_sw }

function TDataSourceLink_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TDataSourceLink_sw.ToVar(TDataSourceLink_sc(AObj).Create());
end;

class function TDataSourceLink_sw.GetTypeName: WideString;
begin
  Result := 'TDataSourceLink';
end;

class function TDataSourceLink_sw.GetWrappedClass: TClass;
begin
  Result := TDataSourceLink;
end;

class procedure TDataSourceLink_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TDataSourceLink_Create_si, 0, False);
end;

class function TDataSourceLink_sw.ToVar(
  const AValue: TDataSourceLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDataSourceLink_sw.FromVar(
  const AValue: OleVariant): TDataSourceLink;
begin
  Result := TDataSourceLink(ConvFromVar(AValue, TDataSourceLink));
end;

class function TDataSourceLink_sw.ClassToVar(
  AClass: TDataSourceLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDataSourceLink_sw.ClassFromVar(
  const AClass: OleVariant): TDataSourceLink_sc;
begin
  Result := TDataSourceLink_sc(ConvClsFromVar(AClass, TDataSourceLink));
end;

{ TListSourceLink_sw }

function TListSourceLink_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TListSourceLink_sw.ToVar(TListSourceLink_sc(AObj).Create());
end;

class function TListSourceLink_sw.GetTypeName: WideString;
begin
  Result := 'TListSourceLink';
end;

class function TListSourceLink_sw.GetWrappedClass: TClass;
begin
  Result := TListSourceLink;
end;

class procedure TListSourceLink_sw.DoInit(AData: TLMDClassWrapperData);
begin

  { Class members }

  AData.AddConstructor('Create', TListSourceLink_Create_si, 0, False);
end;

class function TListSourceLink_sw.ToVar(
  const AValue: TListSourceLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TListSourceLink_sw.FromVar(
  const AValue: OleVariant): TListSourceLink;
begin
  Result := TListSourceLink(ConvFromVar(AValue, TListSourceLink));
end;

class function TListSourceLink_sw.ClassToVar(
  AClass: TListSourceLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TListSourceLink_sw.ClassFromVar(
  const AClass: OleVariant): TListSourceLink_sc;
begin
  Result := TListSourceLink_sc(ConvClsFromVar(AClass, TListSourceLink));
end;

{ TDBLookupControl_sw }

function TDBLookupControl_DataField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DataField: WideString read <getter> wr...

  if IsGet then
    Result := TDBLookupControl_sacc(TDBLookupControl(AObj)).DataField
  else
    TDBLookupControl_sacc(TDBLookupControl(AObj)).DataField := WideString(
      AArgs[0]);
end;

function TDBLookupControl_DataLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DataLink: TDataSourceLink read <getter>;

  Result := TDataSourceLink_sw.ToVar(TDBLookupControl_sacc(TDBLookupControl(
    AObj)).DataLink);
end;

function TDBLookupControl_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DataSource: TDataSource read <getter> ...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBLookupControl_sacc(TDBLookupControl(
      AObj)).DataSource)
  else
    TDBLookupControl_sacc(TDBLookupControl(AObj)).DataSource := TDataSource_sw.
      FromVar(AArgs[0]);
end;

function TDBLookupControl_HasFocus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property HasFocus: Boolean read <getter>;

  Result := TDBLookupControl_sacc(TDBLookupControl(AObj)).HasFocus;
end;

function TDBLookupControl_KeyField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property KeyField: string read <getter> write <...

  if IsGet then
    Result := TDBLookupControl_sacc(TDBLookupControl(AObj)).KeyField
  else
    TDBLookupControl_sacc(TDBLookupControl(AObj)).KeyField := string(AArgs[0]);
end;

function TDBLookupControl_KeyValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property KeyValue: Variant read <getter> write ...

  if IsGet then
    Result := TDBLookupControl_sacc(TDBLookupControl(AObj)).KeyValue
  else
    TDBLookupControl_sacc(TDBLookupControl(AObj)).KeyValue := Variant(
      FindVarData(AArgs[0])^);
end;

function TDBLookupControl_ListActive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ListActive: Boolean read <getter>;

  Result := TDBLookupControl_sacc(TDBLookupControl(AObj)).ListActive;
end;

function TDBLookupControl_ListField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ListField: string read <getter> write ...

  if IsGet then
    Result := TDBLookupControl_sacc(TDBLookupControl(AObj)).ListField
  else
    TDBLookupControl_sacc(TDBLookupControl(AObj)).ListField := string(AArgs[0]);
end;

function TDBLookupControl_ListFieldIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ListFieldIndex: Integer read <getter> ...

  if IsGet then
    Result := TDBLookupControl_sacc(TDBLookupControl(AObj)).ListFieldIndex
  else
    TDBLookupControl_sacc(TDBLookupControl(AObj)).ListFieldIndex := Integer(
      AArgs[0]);
end;

function TDBLookupControl_ListFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ListFields: TList read <getter>;

  Result := TList_sw.ToVar(TDBLookupControl_sacc(TDBLookupControl(AObj)).
    ListFields);
end;

function TDBLookupControl_ListLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ListLink: TListSourceLink read <getter>;

  Result := TListSourceLink_sw.ToVar(TDBLookupControl_sacc(TDBLookupControl(
    AObj)).ListLink);
end;

function TDBLookupControl_ListSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ListSource: TDataSource read <getter> ...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBLookupControl_sacc(TDBLookupControl(
      AObj)).ListSource)
  else
    TDBLookupControl_sacc(TDBLookupControl(AObj)).ListSource := TDataSource_sw.
      FromVar(AArgs[0]);
end;

function TDBLookupControl_NullValueKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property NullValueKey: TShortCut read <getter> ...

  if IsGet then
    Result := TShortCut_sw.ToVar(TDBLookupControl_sacc(TDBLookupControl(AObj)).
      NullValueKey)
  else
    TDBLookupControl_sacc(TDBLookupControl(AObj)).NullValueKey := TShortCut_sw.
      FromVar(AArgs[0]);
end;

function TDBLookupControl_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ReadOnly: Boolean read <getter> write ...

  if IsGet then
    Result := TDBLookupControl_sacc(TDBLookupControl(AObj)).ReadOnly
  else
    TDBLookupControl_sacc(TDBLookupControl(AObj)).ReadOnly := Boolean(AArgs[0]);
end;

function TDBLookupControl_SearchText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property SearchText: string read <getter> write...

  if IsGet then
    Result := TDBLookupControl_sacc(TDBLookupControl(AObj)).SearchText
  else
    TDBLookupControl_sacc(TDBLookupControl(AObj)).SearchText := string(
      AArgs[0]);
end;

function TDBLookupControl_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TDBLookupControl(AObj).Field);
end;

class function TDBLookupControl_sw.GetTypeName: WideString;
begin
  Result := 'TDBLookupControl';
end;

class function TDBLookupControl_sw.GetWrappedClass: TClass;
begin
  Result := TDBLookupControl;
end;

class procedure TDBLookupControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DataField', TDBLookupControl_DataField_si, WideString_sw, True, True, 0, True, False);
  AData.AddProperty('DataLink', TDBLookupControl_DataLink_si, TDataSourceLink_sw, True, False, 0, True, False);
  AData.AddProperty('DataSource', TDBLookupControl_DataSource_si, TDataSource_sw, True, True, 0, True, False);
  AData.AddProperty('HasFocus', TDBLookupControl_HasFocus_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProperty('KeyField', TDBLookupControl_KeyField_si, string_sw, True, True, 0, True, False);
  AData.AddProperty('KeyValue', TDBLookupControl_KeyValue_si, Variant_sw, True, True, 0, True, False);
  AData.AddProperty('ListActive', TDBLookupControl_ListActive_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProperty('ListField', TDBLookupControl_ListField_si, string_sw, True, True, 0, True, False);
  AData.AddProperty('ListFieldIndex', TDBLookupControl_ListFieldIndex_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('ListFields', TDBLookupControl_ListFields_si, TList_sw, True, False, 0, True, False);
  AData.AddProperty('ListLink', TDBLookupControl_ListLink_si, TListSourceLink_sw, True, False, 0, True, False);
  AData.AddProperty('ListSource', TDBLookupControl_ListSource_si, TDataSource_sw, True, True, 0, True, False);
  AData.AddProperty('NullValueKey', TDBLookupControl_NullValueKey_si, TShortCut_sw, True, True, 0, True, False);
  AData.AddProperty('ReadOnly', TDBLookupControl_ReadOnly_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('SearchText', TDBLookupControl_SearchText_si, string_sw, True, True, 0, True, False);
  AData.AddProperty('Field', TDBLookupControl_Field_si, TField_sw, True, False, 0, False, False);
end;

class function TDBLookupControl_sw.ToVar(
  const AValue: TDBLookupControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBLookupControl_sw.FromVar(
  const AValue: OleVariant): TDBLookupControl;
begin
  Result := TDBLookupControl(ConvFromVar(AValue, TDBLookupControl));
end;

class function TDBLookupControl_sw.ClassToVar(
  AClass: TDBLookupControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBLookupControl_sw.ClassFromVar(
  const AClass: OleVariant): TDBLookupControl_sc;
begin
  Result := TDBLookupControl_sc(ConvClsFromVar(AClass, TDBLookupControl));
end;

{ TDBLookupListBox_sw }

function TDBLookupListBox_SelectedItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelectedItem: string read <getter>;

  Result := TDBLookupListBox(AObj).SelectedItem;
end;

function TDBLookupListBox_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BorderStyle: TBorderStyle read <getter> write <s...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TDBLookupListBox(AObj).BorderStyle)
  else
    TDBLookupListBox(AObj).BorderStyle := TBorderStyle_sw.FromVar(AArgs[0]);
end;

function TDBLookupListBox_RowCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RowCount: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDBLookupListBox(AObj).RowCount
  else
    TDBLookupListBox(AObj).RowCount := Integer(AArgs[0]);
end;

class function TDBLookupListBox_sw.GetTypeName: WideString;
begin
  Result := 'TDBLookupListBox';
end;

class function TDBLookupListBox_sw.GetWrappedClass: TClass;
begin
  Result := TDBLookupListBox;
end;

class procedure TDBLookupListBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('KeyValue', False);
  AData.AddProperty('SelectedItem', TDBLookupListBox_SelectedItem_si, string_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddProperty('BorderStyle', TDBLookupListBox_BorderStyle_si, TBorderStyle_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DataField', False);
  AData.AddPropertyRedecl('DataSource', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('KeyField', False);
  AData.AddPropertyRedecl('ListField', False);
  AData.AddPropertyRedecl('ListFieldIndex', False);
  AData.AddPropertyRedecl('ListSource', False);
  AData.AddPropertyRedecl('NullValueKey', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ReadOnly', False);
  AData.AddProperty('RowCount', TDBLookupListBox_RowCount_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
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
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBLookupListBox_sw.ToVar(
  const AValue: TDBLookupListBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBLookupListBox_sw.FromVar(
  const AValue: OleVariant): TDBLookupListBox;
begin
  Result := TDBLookupListBox(ConvFromVar(AValue, TDBLookupListBox));
end;

class function TDBLookupListBox_sw.ClassToVar(
  AClass: TDBLookupListBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBLookupListBox_sw.ClassFromVar(
  const AClass: OleVariant): TDBLookupListBox_sc;
begin
  Result := TDBLookupListBox_sc(ConvClsFromVar(AClass, TDBLookupListBox));
end;

{ TPopupDataList_sw }

class function TPopupDataList_sw.GetTypeName: WideString;
begin
  Result := 'TPopupDataList';
end;

class function TPopupDataList_sw.GetWrappedClass: TClass;
begin
  Result := TPopupDataList;
end;

class procedure TPopupDataList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TPopupDataList_sw.ToVar(
  const AValue: TPopupDataList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPopupDataList_sw.FromVar(
  const AValue: OleVariant): TPopupDataList;
begin
  Result := TPopupDataList(ConvFromVar(AValue, TPopupDataList));
end;

class function TPopupDataList_sw.ClassToVar(
  AClass: TPopupDataList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPopupDataList_sw.ClassFromVar(
  const AClass: OleVariant): TPopupDataList_sc;
begin
  Result := TPopupDataList_sc(ConvClsFromVar(AClass, TPopupDataList));
end;

{ TDropDownAlign_sw }

class function TDropDownAlign_sw.GetTypeName: WideString;
begin
  Result := 'TDropDownAlign';
end;

class procedure TDropDownAlign_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'daLeft'; Value: Integer({$IFDEF LMDSCT_12}TDropDownAlign.{$ENDIF}daLeft)),
    (Name: 'daRight'; Value: Integer({$IFDEF LMDSCT_12}TDropDownAlign.{$ENDIF}daRight)),
    (Name: 'daCenter'; Value: Integer({$IFDEF LMDSCT_12}TDropDownAlign.{$ENDIF}daCenter))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TDropDownAlign_sw.ToVar(
  const AValue: TDropDownAlign): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDropDownAlign_sw.FromVar(
  const AValue: OleVariant): TDropDownAlign;
begin
  Result := TDropDownAlign(Integer(AValue));
end;

{ TDBLookupComboBox_sw }

function TDBLookupComboBox_CloseUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CloseUp(Accept: Boolean);

  TDBLookupComboBox(AObj).CloseUp(Boolean(AArgs[0]));
end;

function TDBLookupComboBox_DropDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DropDown;

  TDBLookupComboBox(AObj).DropDown();
end;

function TDBLookupComboBox_ListVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ListVisible: Boolean read <getter>;

  Result := TDBLookupComboBox(AObj).ListVisible;
end;

function TDBLookupComboBox_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Text: string read <getter>;

  Result := TDBLookupComboBox(AObj).Text;
end;

function TDBLookupComboBox_DropDownAlign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropDownAlign: TDropDownAlign read <getter> writ...

  if IsGet then
    Result := TDropDownAlign_sw.ToVar(TDBLookupComboBox(AObj).DropDownAlign)
  else
    TDBLookupComboBox(AObj).DropDownAlign := TDropDownAlign_sw.FromVar(
      AArgs[0]);
end;

function TDBLookupComboBox_DropDownRows_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropDownRows: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDBLookupComboBox(AObj).DropDownRows
  else
    TDBLookupComboBox(AObj).DropDownRows := Integer(AArgs[0]);
end;

function TDBLookupComboBox_DropDownWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropDownWidth: Integer read <getter> write <sett...

  if IsGet then
    Result := TDBLookupComboBox(AObj).DropDownWidth
  else
    TDBLookupComboBox(AObj).DropDownWidth := Integer(AArgs[0]);
end;

function TDBLookupComboBox_OnCloseUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCloseUp: TNotifyEvent read <getter> write <set...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDBLookupComboBox(AObj).OnCloseUp)
  else
    TDBLookupComboBox(AObj).OnCloseUp := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TDBLookupComboBox_OnDropDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDropDown: TNotifyEvent read <getter> write <se...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TDBLookupComboBox(AObj).OnDropDown)
  else
    TDBLookupComboBox(AObj).OnDropDown := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TDBLookupComboBox_sw.GetTypeName: WideString;
begin
  Result := 'TDBLookupComboBox';
end;

class function TDBLookupComboBox_sw.GetWrappedClass: TClass;
begin
  Result := TDBLookupComboBox;
end;

class procedure TDBLookupComboBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('CloseUp', TDBLookupComboBox_CloseUp_si, 1, False);
  AData.AddProcedure('DropDown', TDBLookupComboBox_DropDown_si, 0, False);
  AData.AddPropertyRedecl('KeyValue', False);
  AData.AddProperty('ListVisible', TDBLookupComboBox_ListVisible_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Text', TDBLookupComboBox_Text_si, string_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DataField', False);
  AData.AddPropertyRedecl('DataSource', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddProperty('DropDownAlign', TDBLookupComboBox_DropDownAlign_si, TDropDownAlign_sw, True, True, 0, False, False);
  AData.AddProperty('DropDownRows', TDBLookupComboBox_DropDownRows_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('DropDownWidth', TDBLookupComboBox_DropDownWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('KeyField', False);
  AData.AddPropertyRedecl('ListField', False);
  AData.AddPropertyRedecl('ListFieldIndex', False);
  AData.AddPropertyRedecl('ListSource', False);
  AData.AddPropertyRedecl('NullValueKey', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ReadOnly', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddProperty('OnCloseUp', TDBLookupComboBox_OnCloseUp_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddProperty('OnDropDown', TDBLookupComboBox_OnDropDown_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('OnEndDock', False);
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
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBLookupComboBox_sw.ToVar(
  const AValue: TDBLookupComboBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBLookupComboBox_sw.FromVar(
  const AValue: OleVariant): TDBLookupComboBox;
begin
  Result := TDBLookupComboBox(ConvFromVar(AValue, TDBLookupComboBox));
end;

class function TDBLookupComboBox_sw.ClassToVar(
  AClass: TDBLookupComboBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBLookupComboBox_sw.ClassFromVar(
  const AClass: OleVariant): TDBLookupComboBox_sc;
begin
  Result := TDBLookupComboBox_sc(ConvClsFromVar(AClass, TDBLookupComboBox));
end;

{ TDBRichEdit_sw }

function TDBRichEdit_LoadMemo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadMemo;

  TDBRichEdit(AObj).LoadMemo();
end;

function TDBRichEdit_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter>;

  Result := TField_sw.ToVar(TDBRichEdit(AObj).Field);
end;

function TDBRichEdit_AutoDisplay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoDisplay: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBRichEdit(AObj).AutoDisplay
  else
    TDBRichEdit(AObj).AutoDisplay := Boolean(AArgs[0]);
end;

function TDBRichEdit_DataField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataField: WideString read <getter> write <setter>;

  if IsGet then
    Result := TDBRichEdit(AObj).DataField
  else
    TDBRichEdit(AObj).DataField := WideString(AArgs[0]);
end;

function TDBRichEdit_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TDBRichEdit(AObj).DataSource)
  else
    TDBRichEdit(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

function TDBRichEdit_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDBRichEdit(AObj).ReadOnly
  else
    TDBRichEdit(AObj).ReadOnly := Boolean(AArgs[0]);
end;

class function TDBRichEdit_sw.GetTypeName: WideString;
begin
  Result := 'TDBRichEdit';
end;

class function TDBRichEdit_sw.GetWrappedClass: TClass;
begin
  Result := TDBRichEdit;
end;

class procedure TDBRichEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('LoadMemo', TDBRichEdit_LoadMemo_si, 0, False);
  AData.AddProperty('Field', TDBRichEdit_Field_si, TField_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Alignment', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddProperty('AutoDisplay', TDBRichEdit_AutoDisplay_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('DataField', TDBRichEdit_DataField_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TDBRichEdit_DataSource_si, TDataSource_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('HideSelection', False);
  AData.AddPropertyRedecl('HideScrollBars', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('MaxLength', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PlainText', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddProperty('ReadOnly', TDBRichEdit_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('ScrollBars', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('WantReturns', False);
  AData.AddPropertyRedecl('WantTabs', False);
  AData.AddPropertyRedecl('WordWrap', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
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
  AData.AddPropertyRedecl('OnResizeRequest', False);
  AData.AddPropertyRedecl('OnSelectionChange', False);
  AData.AddPropertyRedecl('OnProtectChange', False);
  AData.AddPropertyRedecl('OnSaveClipboard', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
end;

class function TDBRichEdit_sw.ToVar(const AValue: TDBRichEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBRichEdit_sw.FromVar(const AValue: OleVariant): TDBRichEdit;
begin
  Result := TDBRichEdit(ConvFromVar(AValue, TDBRichEdit));
end;

class function TDBRichEdit_sw.ClassToVar(AClass: TDBRichEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBRichEdit_sw.ClassFromVar(
  const AClass: OleVariant): TDBRichEdit_sc;
begin
  Result := TDBRichEdit_sc(ConvClsFromVar(AClass, TDBRichEdit));
end;

{ DBCtrls_sw }

function DBCtrls_TFieldDataLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldDataLink = class(TDataLink);

  Result := TLMDUnitWrapper.TypeToVar(TFieldDataLink_sw);
end;

function DBCtrls_TPaintControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPaintControl = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TPaintControl_sw);
end;

function DBCtrls_TDBEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBEdit = class(TCustomMaskEdit);

  Result := TLMDUnitWrapper.TypeToVar(TDBEdit_sw);
end;

function DBCtrls_TDBText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBText = class(TCustomLabel);

  Result := TLMDUnitWrapper.TypeToVar(TDBText_sw);
end;

function DBCtrls_TDBCheckBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBCheckBox = class(TCustomCheckBox);

  Result := TLMDUnitWrapper.TypeToVar(TDBCheckBox_sw);
end;

function DBCtrls_TDBComboBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBComboBox = class(TCustomComboBox);

  Result := TLMDUnitWrapper.TypeToVar(TDBComboBox_sw);
end;

function DBCtrls_TDBListBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBListBox = class(TCustomListBox);

  Result := TLMDUnitWrapper.TypeToVar(TDBListBox_sw);
end;

function DBCtrls_TDBRadioGroup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBRadioGroup = class(TCustomRadioGroup);

  Result := TLMDUnitWrapper.TypeToVar(TDBRadioGroup_sw);
end;

function DBCtrls_TDBMemo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBMemo = class(TCustomMemo);

  Result := TLMDUnitWrapper.TypeToVar(TDBMemo_sw);
end;

function DBCtrls_TDBImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBImage = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TDBImage_sw);
end;

function DBCtrls_InitRepeatPause_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const InitRepeatPause = <value>;

  Result := InitRepeatPause;
end;

function DBCtrls_RepeatPause_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const RepeatPause = <value>;

  Result := RepeatPause;
end;

function DBCtrls_SpaceSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SpaceSize = <value>;

  Result := SpaceSize;
end;

function DBCtrls_TNavGlyph_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNavGlyph = (ngEnabled, ngDisabled);

  Result := TLMDUnitWrapper.TypeToVar(TNavGlyph_sw);
end;

function DBCtrls_TNavigateBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNavigateBtn = (nbFirst, nbPrior, nbNext, nbLast, nb...

  Result := TLMDUnitWrapper.TypeToVar(TNavigateBtn_sw);
end;

function DBCtrls_TNavButtonSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNavButtonSet = set of TNavigateBtn;

  Result := TLMDUnitWrapper.TypeToVar(TNavButtonSet_sw);
end;

function DBCtrls_ENavClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ENavClick = procedure (Sender: TObject; Button: TNav...

  Result := TLMDUnitWrapper.TypeToVar(ENavClick_sw);
end;

function DBCtrls_TDBNavigator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBNavigator = class(TCustomPanel);

  Result := TLMDUnitWrapper.TypeToVar(TDBNavigator_sw);
end;

function DBCtrls_TNavButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNavButton = class(TSpeedButton);

  Result := TLMDUnitWrapper.TypeToVar(TNavButton_sw);
end;

function DBCtrls_TNavDataLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNavDataLink = class(TDataLink);

  Result := TLMDUnitWrapper.TypeToVar(TNavDataLink_sw);
end;

function DBCtrls_TDataSourceLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDataSourceLink = class(TDataLink);

  Result := TLMDUnitWrapper.TypeToVar(TDataSourceLink_sw);
end;

function DBCtrls_TListSourceLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TListSourceLink = class(TDataLink);

  Result := TLMDUnitWrapper.TypeToVar(TListSourceLink_sw);
end;

function DBCtrls_TDBLookupControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBLookupControl = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TDBLookupControl_sw);
end;

function DBCtrls_TDBLookupListBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBLookupListBox = class(TDBLookupControl);

  Result := TLMDUnitWrapper.TypeToVar(TDBLookupListBox_sw);
end;

function DBCtrls_TPopupDataList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPopupDataList = class(TDBLookupListBox);

  Result := TLMDUnitWrapper.TypeToVar(TPopupDataList_sw);
end;

function DBCtrls_TDropDownAlign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDropDownAlign = (daLeft, daRight, daCenter);

  Result := TLMDUnitWrapper.TypeToVar(TDropDownAlign_sw);
end;

function DBCtrls_TDBLookupComboBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBLookupComboBox = class(TDBLookupControl);

  Result := TLMDUnitWrapper.TypeToVar(TDBLookupComboBox_sw);
end;

function DBCtrls_TDBRichEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBRichEdit = class(TCustomRichEdit);

  Result := TLMDUnitWrapper.TypeToVar(TDBRichEdit_sw);
end;

function DBCtrls_OkToChangeFieldAlignment_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function OkToChangeFieldAlignment(AField: TField; Alignme...

  Result := DBCtrls.OkToChangeFieldAlignment(TField_sw.FromVar(AArgs[0]), 
    TAlignment_sw.FromVar(AArgs[1]));
end;

function DBCtrls_DBUseRightToLeftAlignment_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DBUseRightToLeftAlignment(AControl: TControl; AF...

  Result := DBCtrls.DBUseRightToLeftAlignment(TControl_sw.FromVar(AArgs[0]), 
    TField_sw.FromVar(AArgs[1]));
end;

class function DBCtrls_sw.GetUnitName: WideString;
begin
  Result := 'DBCtrls';
end;

class procedure DBCtrls_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TFieldDataLink_sw, DBCtrls_TFieldDataLink_si);
  AData.AddType(TPaintControl_sw, DBCtrls_TPaintControl_si);
  AData.AddType(TDBEdit_sw, DBCtrls_TDBEdit_si);
  AData.AddType(TDBText_sw, DBCtrls_TDBText_si);
  AData.AddType(TDBCheckBox_sw, DBCtrls_TDBCheckBox_si);
  AData.AddType(TDBComboBox_sw, DBCtrls_TDBComboBox_si);
  AData.AddType(TDBListBox_sw, DBCtrls_TDBListBox_si);
  AData.AddType(TDBRadioGroup_sw, DBCtrls_TDBRadioGroup_si);
  AData.AddType(TDBMemo_sw, DBCtrls_TDBMemo_si);
  AData.AddType(TDBImage_sw, DBCtrls_TDBImage_si);
  AData.AddConstant('InitRepeatPause', DBCtrls_InitRepeatPause_si, nil, VarType(DBCtrls.InitRepeatPause));
  AData.AddConstant('RepeatPause', DBCtrls_RepeatPause_si, nil, VarType(DBCtrls.RepeatPause));
  AData.AddConstant('SpaceSize', DBCtrls_SpaceSize_si, nil, VarType(DBCtrls.SpaceSize));
  AData.AddType(TNavGlyph_sw, DBCtrls_TNavGlyph_si);
  AData.AddType(TNavigateBtn_sw, DBCtrls_TNavigateBtn_si);
  AData.AddType(TNavButtonSet_sw, DBCtrls_TNavButtonSet_si);
  AData.AddType(ENavClick_sw, DBCtrls_ENavClick_si);
  AData.AddType(TDBNavigator_sw, DBCtrls_TDBNavigator_si);
  AData.AddType(TNavButton_sw, DBCtrls_TNavButton_si);
  AData.AddType(TNavDataLink_sw, DBCtrls_TNavDataLink_si);
  AData.AddType(TDataSourceLink_sw, DBCtrls_TDataSourceLink_si);
  AData.AddType(TListSourceLink_sw, DBCtrls_TListSourceLink_si);
  AData.AddType(TDBLookupControl_sw, DBCtrls_TDBLookupControl_si);
  AData.AddType(TDBLookupListBox_sw, DBCtrls_TDBLookupListBox_si);
  AData.AddType(TPopupDataList_sw, DBCtrls_TPopupDataList_si);
  AData.AddType(TDropDownAlign_sw, DBCtrls_TDropDownAlign_si);
  AData.AddType(TDBLookupComboBox_sw, DBCtrls_TDBLookupComboBox_si);
  AData.AddType(TDBRichEdit_sw, DBCtrls_TDBRichEdit_si);
  AData.AddFunction('OkToChangeFieldAlignment', DBCtrls_OkToChangeFieldAlignment_si, Boolean_sw, 2, False);
  AData.AddFunction('DBUseRightToLeftAlignment', DBCtrls_DBUseRightToLeftAlignment_si, Boolean_sw, 2, False);
end;

class function DBCtrls_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DBCtrls_sw);
end;

initialization
  RegisterUnitWrapper(DBCtrls_sw);
  RegisterClassWrapper(TFieldDataLink_sw);
  RegisterClassWrapper(TPaintControl_sw);
  RegisterClassWrapper(TDBEdit_sw);
  RegisterClassWrapper(TDBText_sw);
  RegisterClassWrapper(TDBCheckBox_sw);
  RegisterClassWrapper(TDBComboBox_sw);
  RegisterClassWrapper(TDBListBox_sw);
  RegisterClassWrapper(TDBRadioGroup_sw);
  RegisterClassWrapper(TDBMemo_sw);
  RegisterClassWrapper(TDBImage_sw);
  RegisterClassWrapper(TDBNavigator_sw);
  RegisterClassWrapper(TNavButton_sw);
  RegisterClassWrapper(TNavDataLink_sw);
  RegisterClassWrapper(TDataSourceLink_sw);
  RegisterClassWrapper(TListSourceLink_sw);
  RegisterClassWrapper(TDBLookupControl_sw);
  RegisterClassWrapper(TDBLookupListBox_sw);
  RegisterClassWrapper(TPopupDataList_sw);
  RegisterClassWrapper(TDBLookupComboBox_sw);
  RegisterClassWrapper(TDBRichEdit_sw);
  RegisterEventWrapper(TypeInfo(ENavClick), ENavClick_sw);

end.
