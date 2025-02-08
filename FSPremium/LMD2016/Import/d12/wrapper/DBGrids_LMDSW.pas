unit DBGrids_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'DBGrids' unit.
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
  Variants, Windows, SysUtils, Messages, Classes, Controls, Forms, StdCtrls,
  Graphics, Grids, DBCtrls, Db, Menus, ImgList, DBGrids, Variants_LMDSW,
  Windows_LMDSW, SysUtils_LMDSW, Messages_LMDSW, Classes_LMDSW, Controls_LMDSW,
  Forms_LMDSW, StdCtrls_LMDSW, Graphics_LMDSW, Grids_LMDSW, DBCtrls_LMDSW,
  Db_LMDSW, Menus_LMDSW, ImgList_LMDSW;


{ Type wrappers }

type
  TColumnTitle_sw = class;
  TColumn_sw = class;
  TColumnClass_sw = class;
  TDBGridColumns_sw = class;
  TGridDataLink_sw = class;
  TBookmarkList_sw = class;
  TCustomDBGrid_sw = class;
  TDBGrid_sw = class;

  TColumnValue_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TColumnValue): OleVariant;
    class function FromVar(const AValue: OleVariant): TColumnValue;
  end;

  TColumnValues_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TColumnValues): OleVariant;
    class function FromVar(const AValue: OleVariant): TColumnValues;
  end;

  TColumnTitle_sc = class of TColumnTitle;
  TColumnTitle_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TColumnTitle): OleVariant;
    class function FromVar(const AValue: OleVariant): TColumnTitle;
    class function ClassToVar(AClass: TColumnTitle_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TColumnTitle_sc;
  end;

  TColumnButtonStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TColumnButtonStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TColumnButtonStyle;
  end;

  TColumn_sc = class of TColumn;
  TColumn_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TColumn): OleVariant;
    class function FromVar(const AValue: OleVariant): TColumn;
    class function ClassToVar(AClass: TColumn_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TColumn_sc;
  end;

  TColumnClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TColumnClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TColumnClass;
  end;

  TDBGridColumnsState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDBGridColumnsState): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBGridColumnsState;
  end;

  TDBGridColumns_sc = class of TDBGridColumns;
  TDBGridColumns_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBGridColumns): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBGridColumns;
    class function ClassToVar(AClass: TDBGridColumns_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBGridColumns_sc;
  end;

  TGridDataLink_sc = class of TGridDataLink;
  TGridDataLink_sw = class(TDataLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TGridDataLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TGridDataLink;
    class function ClassToVar(AClass: TGridDataLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TGridDataLink_sc;
  end;

  TBookmarkList_sc = class of TBookmarkList;
  TBookmarkList_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBookmarkList): OleVariant;
    class function FromVar(const AValue: OleVariant): TBookmarkList;
    class function ClassToVar(AClass: TBookmarkList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBookmarkList_sc;
  end;

  TDBGridOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDBGridOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBGridOption;
  end;

  TDBGridOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TDBGridOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBGridOptions;
  end;

  TDBGridClickEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Column: TColumn);
  end;

  TDBGridClickEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDBGridClickEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBGridClickEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDBGridClickEvent;
  end;

  TCustomDBGrid_sc = class of TCustomDBGrid;
  TCustomDBGrid_sw = class(TCustomGrid_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomDBGrid): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomDBGrid;
    class function ClassToVar(AClass: TCustomDBGrid_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomDBGrid_sc;
  end;

  TDBGrid_sc = class of TDBGrid;
  TDBGrid_sw = class(TCustomDBGrid_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDBGrid): OleVariant;
    class function FromVar(const AValue: OleVariant): TDBGrid;
    class function ClassToVar(AClass: TDBGrid_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDBGrid_sc;
  end;


{ Unit wrapper }

type
  DBGrids_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TColumn_sacc = class(TColumn);
  TCustomDBGrid_sacc = class(TCustomDBGrid);

{ TColumnValue_sw }

class function TColumnValue_sw.GetTypeName: WideString;
begin
  Result := 'TColumnValue';
end;

class procedure TColumnValue_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..10] of TLMDEnumerator = (
    (Name: 'cvColor'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvColor)),
    (Name: 'cvWidth'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvWidth)),
    (Name: 'cvFont'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvFont)),
    (Name: 'cvAlignment'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvAlignment)),
    (Name: 'cvReadOnly'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvReadOnly)),
    (Name: 'cvTitleColor'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvTitleColor)),
    (Name: 'cvTitleCaption'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvTitleCaption)),
    (Name: 'cvTitleAlignment'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvTitleAlignment)),
    (Name: 'cvTitleFont'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvTitleFont)),
    (Name: 'cvImeMode'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvImeMode)),
    (Name: 'cvImeName'; Value: Integer({$IFDEF LMDSCT_12}TColumnValue.{$ENDIF}cvImeName))
  );
begin
  AEnums := @ENUMS;
  ACount := 11;
end;

class function TColumnValue_sw.ToVar(const AValue: TColumnValue): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TColumnValue_sw.FromVar(const AValue: OleVariant): TColumnValue;
begin
  Result := TColumnValue(Integer(AValue));
end;

{ TColumnValues_sw }

class function TColumnValues_sw.GetTypeName: WideString;
begin
  Result := 'TColumnValues';
end;

class function TColumnValues_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TColumnValues);
end;

class function TColumnValues_sw.ToVar(const AValue: TColumnValues): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TColumnValues_sw.FromVar(
  const AValue: OleVariant): TColumnValues;
begin
  ConvFromVar(AValue, @Result);
end;

{ TColumnTitle_sw }

function TColumnTitle_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Column: TColumn);

  Result := TColumnTitle_sw.ToVar(TColumnTitle_sc(AObj).Create(TColumn_sw.
    FromVar(AArgs[0])));
end;

function TColumnTitle_DefaultAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultAlignment: TAlignment;

  Result := TAlignment_sw.ToVar(TColumnTitle(AObj).DefaultAlignment());
end;

function TColumnTitle_DefaultColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultColor: TColor;

  Result := TColor_sw.ToVar(TColumnTitle(AObj).DefaultColor());
end;

function TColumnTitle_DefaultFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultFont: TFont;

  Result := TFont_sw.ToVar(TColumnTitle(AObj).DefaultFont());
end;

function TColumnTitle_DefaultCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultCaption: string;

  Result := TColumnTitle(AObj).DefaultCaption();
end;

function TColumnTitle_RestoreDefaults_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RestoreDefaults;

  TColumnTitle(AObj).RestoreDefaults();
end;

function TColumnTitle_Column_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Column: TColumn read <getter>;

  Result := TColumn_sw.ToVar(TColumnTitle(AObj).Column);
end;

function TColumnTitle_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Alignment: TAlignment read <getter> write <setter>;

  if IsGet then
    Result := TAlignment_sw.ToVar(TColumnTitle(AObj).Alignment)
  else
    TColumnTitle(AObj).Alignment := TAlignment_sw.FromVar(AArgs[0]);
end;

function TColumnTitle_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Caption: string read <getter> write <setter>;

  if IsGet then
    Result := TColumnTitle(AObj).Caption
  else
    TColumnTitle(AObj).Caption := string(AArgs[0]);
end;

function TColumnTitle_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TColumnTitle(AObj).Color)
  else
    TColumnTitle(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TColumnTitle_Font_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Font: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TColumnTitle(AObj).Font)
  else
    TColumnTitle(AObj).Font := TFont_sw.FromVar(AArgs[0]);
end;

class function TColumnTitle_sw.GetTypeName: WideString;
begin
  Result := 'TColumnTitle';
end;

class function TColumnTitle_sw.GetWrappedClass: TClass;
begin
  Result := TColumnTitle;
end;

class procedure TColumnTitle_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('DefaultAlignment', TColumnTitle_DefaultAlignment_si, TAlignment_sw, 0, False);
  AData.AddFunction('DefaultColor', TColumnTitle_DefaultColor_si, TColor_sw, 0, False);
  AData.AddFunction('DefaultFont', TColumnTitle_DefaultFont_si, TFont_sw, 0, False);
  AData.AddFunction('DefaultCaption', TColumnTitle_DefaultCaption_si, string_sw, 0, False);
  AData.AddProcedure('RestoreDefaults', TColumnTitle_RestoreDefaults_si, 0, False);
  AData.AddProperty('Column', TColumnTitle_Column_si, TColumn_sw, True, False, 0, False, False);
  AData.AddProperty('Alignment', TColumnTitle_Alignment_si, TAlignment_sw, True, True, 0, False, False);
  AData.AddProperty('Caption', TColumnTitle_Caption_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Color', TColumnTitle_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('Font', TColumnTitle_Font_si, TFont_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TColumnTitle_Create_si, 1, False);
end;

class function TColumnTitle_sw.ToVar(const AValue: TColumnTitle): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TColumnTitle_sw.FromVar(const AValue: OleVariant): TColumnTitle;
begin
  Result := TColumnTitle(ConvFromVar(AValue, TColumnTitle));
end;

class function TColumnTitle_sw.ClassToVar(AClass: TColumnTitle_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TColumnTitle_sw.ClassFromVar(
  const AClass: OleVariant): TColumnTitle_sc;
begin
  Result := TColumnTitle_sc(ConvClsFromVar(AClass, TColumnTitle));
end;

{ TColumnButtonStyle_sw }

class function TColumnButtonStyle_sw.GetTypeName: WideString;
begin
  Result := 'TColumnButtonStyle';
end;

class procedure TColumnButtonStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'cbsAuto'; Value: Integer({$IFDEF LMDSCT_12}TColumnButtonStyle.{$ENDIF}cbsAuto)),
    (Name: 'cbsEllipsis'; Value: Integer({$IFDEF LMDSCT_12}TColumnButtonStyle.{$ENDIF}cbsEllipsis)),
    (Name: 'cbsNone'; Value: Integer({$IFDEF LMDSCT_12}TColumnButtonStyle.{$ENDIF}cbsNone))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TColumnButtonStyle_sw.ToVar(
  const AValue: TColumnButtonStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TColumnButtonStyle_sw.FromVar(
  const AValue: OleVariant): TColumnButtonStyle;
begin
  Result := TColumnButtonStyle(Integer(AValue));
end;

{ TColumn_sw }

function TColumn_IsStored_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property IsStored: Boolean read <getter> write ...

  if IsGet then
    Result := TColumn_sacc(TColumn(AObj)).IsStored
  else
    TColumn_sacc(TColumn(AObj)).IsStored := Boolean(AArgs[0]);
end;

function TColumn_DefaultAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultAlignment: TAlignment;

  Result := TAlignment_sw.ToVar(TColumn(AObj).DefaultAlignment());
end;

function TColumn_DefaultColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultColor: TColor;

  Result := TColor_sw.ToVar(TColumn(AObj).DefaultColor());
end;

function TColumn_DefaultFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultFont: TFont;

  Result := TFont_sw.ToVar(TColumn(AObj).DefaultFont());
end;

function TColumn_DefaultImeMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultImeMode: TImeMode;

  Result := TImeMode_sw.ToVar(TColumn(AObj).DefaultImeMode());
end;

function TColumn_DefaultImeName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultImeName: TImeName;

  Result := TImeName_sw.ToVar(TColumn(AObj).DefaultImeName());
end;

function TColumn_DefaultReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultReadOnly: Boolean;

  Result := TColumn(AObj).DefaultReadOnly();
end;

function TColumn_DefaultWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DefaultWidth: Integer;

  Result := TColumn(AObj).DefaultWidth();
end;

function TColumn_Depth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Depth: Integer;

  Result := TColumn(AObj).Depth();
end;

function TColumn_RestoreDefaults_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RestoreDefaults;

  TColumn(AObj).RestoreDefaults();
end;

function TColumn_Grid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Grid: TCustomDBGrid read <getter>;

  Result := TCustomDBGrid_sw.ToVar(TColumn(AObj).Grid);
end;

function TColumn_AssignedValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AssignedValues: TColumnValues read <getter>;

  Result := TColumnValues_sw.ToVar(TColumn(AObj).AssignedValues);
end;

function TColumn_Expandable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Expandable: Boolean read <getter>;

  Result := TColumn(AObj).Expandable;
end;

function TColumn_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Field: TField read <getter> write <setter>;

  if IsGet then
    Result := TField_sw.ToVar(TColumn(AObj).Field)
  else
    TColumn(AObj).Field := TField_sw.FromVar(AArgs[0]);
end;

function TColumn_ParentColumn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentColumn: TColumn read <getter>;

  Result := TColumn_sw.ToVar(TColumn(AObj).ParentColumn);
end;

function TColumn_Showing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Showing: Boolean read <getter>;

  Result := TColumn(AObj).Showing;
end;

function TColumn_Alignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Alignment: TAlignment read <getter> write <setter>;

  if IsGet then
    Result := TAlignment_sw.ToVar(TColumn(AObj).Alignment)
  else
    TColumn(AObj).Alignment := TAlignment_sw.FromVar(AArgs[0]);
end;

function TColumn_ButtonStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ButtonStyle: TColumnButtonStyle read <getter> wr...

  if IsGet then
    Result := TColumnButtonStyle_sw.ToVar(TColumn(AObj).ButtonStyle)
  else
    TColumn(AObj).ButtonStyle := TColumnButtonStyle_sw.FromVar(AArgs[0]);
end;

function TColumn_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TColumn(AObj).Color)
  else
    TColumn(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TColumn_DropDownRows_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropDownRows: Cardinal read <getter> write <sett...

  if IsGet then
    Result := TColumn(AObj).DropDownRows
  else
    TColumn(AObj).DropDownRows := Cardinal(AArgs[0]);
end;

function TColumn_Expanded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Expanded: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TColumn(AObj).Expanded
  else
    TColumn(AObj).Expanded := Boolean(AArgs[0]);
end;

function TColumn_FieldName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldName: WideString read <getter> write <setter>;

  if IsGet then
    Result := TColumn(AObj).FieldName
  else
    TColumn(AObj).FieldName := WideString(AArgs[0]);
end;

function TColumn_Font_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Font: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TColumn(AObj).Font)
  else
    TColumn(AObj).Font := TFont_sw.FromVar(AArgs[0]);
end;

function TColumn_ImeMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImeMode: TImeMode read <getter> write <setter>;

  if IsGet then
    Result := TImeMode_sw.ToVar(TColumn(AObj).ImeMode)
  else
    TColumn(AObj).ImeMode := TImeMode_sw.FromVar(AArgs[0]);
end;

function TColumn_ImeName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImeName: TImeName read <getter> write <setter>;

  if IsGet then
    Result := TImeName_sw.ToVar(TColumn(AObj).ImeName)
  else
    TColumn(AObj).ImeName := TImeName_sw.FromVar(AArgs[0]);
end;

function TColumn_PickList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PickList: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TColumn(AObj).PickList)
  else
    TColumn(AObj).PickList := TStrings_sw.FromVar(AArgs[0]);
end;

function TColumn_PopupMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PopupMenu: TPopupMenu read <getter> write <setter>;

  if IsGet then
    Result := TPopupMenu_sw.ToVar(TColumn(AObj).PopupMenu)
  else
    TColumn(AObj).PopupMenu := TPopupMenu_sw.FromVar(AArgs[0]);
end;

function TColumn_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ReadOnly: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TColumn(AObj).ReadOnly
  else
    TColumn(AObj).ReadOnly := Boolean(AArgs[0]);
end;

function TColumn_Title_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Title: TColumnTitle read <getter> write <setter>;

  if IsGet then
    Result := TColumnTitle_sw.ToVar(TColumn(AObj).Title)
  else
    TColumn(AObj).Title := TColumnTitle_sw.FromVar(AArgs[0]);
end;

function TColumn_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := TColumn(AObj).Width
  else
    TColumn(AObj).Width := Integer(AArgs[0]);
end;

function TColumn_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TColumn(AObj).Visible
  else
    TColumn(AObj).Visible := Boolean(AArgs[0]);
end;

class function TColumn_sw.GetTypeName: WideString;
begin
  Result := 'TColumn';
end;

class function TColumn_sw.GetWrappedClass: TClass;
begin
  Result := TColumn;
end;

class procedure TColumn_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('IsStored', TColumn_IsStored_si, Boolean_sw, True, True, 0, True, False);
  AData.AddFunction('DefaultAlignment', TColumn_DefaultAlignment_si, TAlignment_sw, 0, False);
  AData.AddFunction('DefaultColor', TColumn_DefaultColor_si, TColor_sw, 0, False);
  AData.AddFunction('DefaultFont', TColumn_DefaultFont_si, TFont_sw, 0, False);
  AData.AddFunction('DefaultImeMode', TColumn_DefaultImeMode_si, TImeMode_sw, 0, False);
  AData.AddFunction('DefaultImeName', TColumn_DefaultImeName_si, TImeName_sw, 0, False);
  AData.AddFunction('DefaultReadOnly', TColumn_DefaultReadOnly_si, Boolean_sw, 0, False);
  AData.AddFunction('DefaultWidth', TColumn_DefaultWidth_si, Integer_sw, 0, False);
  AData.AddFunction('Depth', TColumn_Depth_si, Integer_sw, 0, False);
  AData.AddProcedure('RestoreDefaults', TColumn_RestoreDefaults_si, 0, False);
  AData.AddProperty('Grid', TColumn_Grid_si, TCustomDBGrid_sw, True, False, 0, False, False);
  AData.AddProperty('AssignedValues', TColumn_AssignedValues_si, TColumnValues_sw, True, False, 0, False, False);
  AData.AddProperty('Expandable', TColumn_Expandable_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Field', TColumn_Field_si, TField_sw, True, True, 0, False, False);
  AData.AddProperty('ParentColumn', TColumn_ParentColumn_si, TColumn_sw, True, False, 0, False, False);
  AData.AddProperty('Showing', TColumn_Showing_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Alignment', TColumn_Alignment_si, TAlignment_sw, True, True, 0, False, False);
  AData.AddProperty('ButtonStyle', TColumn_ButtonStyle_si, TColumnButtonStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Color', TColumn_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('DropDownRows', TColumn_DropDownRows_si, Cardinal_sw, True, True, 0, False, False);
  AData.AddProperty('Expanded', TColumn_Expanded_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('FieldName', TColumn_FieldName_si, WideString_sw, True, True, 0, False, False);
  AData.AddProperty('Font', TColumn_Font_si, TFont_sw, True, True, 0, False, False);
  AData.AddProperty('ImeMode', TColumn_ImeMode_si, TImeMode_sw, True, True, 0, False, False);
  AData.AddProperty('ImeName', TColumn_ImeName_si, TImeName_sw, True, True, 0, False, False);
  AData.AddProperty('PickList', TColumn_PickList_si, TStrings_sw, True, True, 0, False, False);
  AData.AddProperty('PopupMenu', TColumn_PopupMenu_si, TPopupMenu_sw, True, True, 0, False, False);
  AData.AddProperty('ReadOnly', TColumn_ReadOnly_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Title', TColumn_Title_si, TColumnTitle_sw, True, True, 0, False, False);
  AData.AddProperty('Width', TColumn_Width_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Visible', TColumn_Visible_si, Boolean_sw, True, True, 0, False, False);
end;

class function TColumn_sw.ToVar(const AValue: TColumn): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TColumn_sw.FromVar(const AValue: OleVariant): TColumn;
begin
  Result := TColumn(ConvFromVar(AValue, TColumn));
end;

class function TColumn_sw.ClassToVar(AClass: TColumn_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TColumn_sw.ClassFromVar(const AClass: OleVariant): TColumn_sc;
begin
  Result := TColumn_sc(ConvClsFromVar(AClass, TColumn));
end;

{ TColumnClass_sw }

class function TColumnClass_sw.GetTypeName: WideString;
begin
  Result := 'TColumnClass';
end;

class function TColumnClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TColumn;
end;

class function TColumnClass_sw.ToVar(const AValue: TColumnClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TColumnClass_sw.FromVar(const AValue: OleVariant): TColumnClass;
begin
  Result := TColumnClass(ConvFromVar(AValue, TColumn));
end;

{ TDBGridColumnsState_sw }

class function TDBGridColumnsState_sw.GetTypeName: WideString;
begin
  Result := 'TDBGridColumnsState';
end;

class procedure TDBGridColumnsState_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'csDefault'; Value: Integer({$IFDEF LMDSCT_12}TDBGridColumnsState.{$ENDIF}csDefault)),
    (Name: 'csCustomized'; Value: Integer({$IFDEF LMDSCT_12}TDBGridColumnsState.{$ENDIF}csCustomized))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TDBGridColumnsState_sw.ToVar(
  const AValue: TDBGridColumnsState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDBGridColumnsState_sw.FromVar(
  const AValue: OleVariant): TDBGridColumnsState;
begin
  Result := TDBGridColumnsState(Integer(AValue));
end;

{ TDBGridColumns_sw }

function TDBGridColumns_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Grid: TCustomDBGrid; ColumnClass: TCol...

  Result := TDBGridColumns_sw.ToVar(TDBGridColumns_sc(AObj).Create(
    TCustomDBGrid_sw.FromVar(AArgs[0]), TColumnClass_sw.FromVar(AArgs[1])));
end;

function TDBGridColumns_Add_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Add: TColumn;

  Result := TColumn_sw.ToVar(TDBGridColumns(AObj).Add());
end;

function TDBGridColumns_LoadFromFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromFile(const Filename: string);

  TDBGridColumns(AObj).LoadFromFile(string(AArgs[0]));
end;

function TDBGridColumns_LoadFromStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure LoadFromStream(S: TStream);

  TDBGridColumns(AObj).LoadFromStream(TStream_sw.FromVar(AArgs[0]));
end;

function TDBGridColumns_RestoreDefaults_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RestoreDefaults;

  TDBGridColumns(AObj).RestoreDefaults();
end;

function TDBGridColumns_RebuildColumns_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RebuildColumns;

  TDBGridColumns(AObj).RebuildColumns();
end;

function TDBGridColumns_SaveToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToFile(const Filename: string);

  TDBGridColumns(AObj).SaveToFile(string(AArgs[0]));
end;

function TDBGridColumns_SaveToStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SaveToStream(S: TStream);

  TDBGridColumns(AObj).SaveToStream(TStream_sw.FromVar(AArgs[0]));
end;

function TDBGridColumns_State_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property State: TDBGridColumnsState read <getter> write <...

  if IsGet then
    Result := TDBGridColumnsState_sw.ToVar(TDBGridColumns(AObj).State)
  else
    TDBGridColumns(AObj).State := TDBGridColumnsState_sw.FromVar(AArgs[0]);
end;

function TDBGridColumns_Grid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Grid: TCustomDBGrid read <getter>;

  Result := TCustomDBGrid_sw.ToVar(TDBGridColumns(AObj).Grid);
end;

function TDBGridColumns_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TColumn read <getter> wri...

  if IsGet then
    Result := TColumn_sw.ToVar(TDBGridColumns(AObj).Items[Integer(AArgs[0])])
  else
    TDBGridColumns(AObj).Items[Integer(AArgs[0])] := TColumn_sw.FromVar(
      AArgs[1]);
end;

class function TDBGridColumns_sw.GetTypeName: WideString;
begin
  Result := 'TDBGridColumns';
end;

class function TDBGridColumns_sw.GetWrappedClass: TClass;
begin
  Result := TDBGridColumns;
end;

class procedure TDBGridColumns_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Add', TDBGridColumns_Add_si, TColumn_sw, 0, False);
  AData.AddProcedure('LoadFromFile', TDBGridColumns_LoadFromFile_si, 1, False);
  AData.AddProcedure('LoadFromStream', TDBGridColumns_LoadFromStream_si, 1, False);
  AData.AddProcedure('RestoreDefaults', TDBGridColumns_RestoreDefaults_si, 0, False);
  AData.AddProcedure('RebuildColumns', TDBGridColumns_RebuildColumns_si, 0, False);
  AData.AddProcedure('SaveToFile', TDBGridColumns_SaveToFile_si, 1, False);
  AData.AddProcedure('SaveToStream', TDBGridColumns_SaveToStream_si, 1, False);
  AData.AddProperty('State', TDBGridColumns_State_si, TDBGridColumnsState_sw, True, True, 0, False, False);
  AData.AddProperty('Grid', TDBGridColumns_Grid_si, TCustomDBGrid_sw, True, False, 0, False, False);
  AData.AddProperty('Items', TDBGridColumns_Items_si, TColumn_sw, True, True, 1, False, True);

  { Class members }

  AData.AddConstructor('Create', TDBGridColumns_Create_si, 2, False);
end;

class function TDBGridColumns_sw.ToVar(
  const AValue: TDBGridColumns): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBGridColumns_sw.FromVar(
  const AValue: OleVariant): TDBGridColumns;
begin
  Result := TDBGridColumns(ConvFromVar(AValue, TDBGridColumns));
end;

class function TDBGridColumns_sw.ClassToVar(
  AClass: TDBGridColumns_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBGridColumns_sw.ClassFromVar(
  const AClass: OleVariant): TDBGridColumns_sc;
begin
  Result := TDBGridColumns_sc(ConvClsFromVar(AClass, TDBGridColumns));
end;

{ TGridDataLink_sw }

function TGridDataLink_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AGrid: TCustomDBGrid);

  Result := TGridDataLink_sw.ToVar(TGridDataLink_sc(AObj).Create(
    TCustomDBGrid_sw.FromVar(AArgs[0])));
end;

function TGridDataLink_AddMapping_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddMapping(const FieldName: string): Boolean;

  Result := TGridDataLink(AObj).AddMapping(string(AArgs[0]));
end;

function TGridDataLink_ClearMapping_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ClearMapping;

  TGridDataLink(AObj).ClearMapping();
end;

function TGridDataLink_Modified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Modified;

  TGridDataLink(AObj).Modified();
end;

function TGridDataLink_Reset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Reset;

  TGridDataLink(AObj).Reset();
end;

function TGridDataLink_DefaultFields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultFields: Boolean read <getter>;

  Result := TGridDataLink(AObj).DefaultFields;
end;

function TGridDataLink_FieldCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldCount: Integer read <getter>;

  Result := TGridDataLink(AObj).FieldCount;
end;

function TGridDataLink_Fields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Fields[I: Integer]: TField read <getter>;

  Result := TField_sw.ToVar(TGridDataLink(AObj).Fields[Integer(AArgs[0])]);
end;

function TGridDataLink_SparseMap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SparseMap: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TGridDataLink(AObj).SparseMap
  else
    TGridDataLink(AObj).SparseMap := Boolean(AArgs[0]);
end;

function TGridDataLink_Grid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Grid: TCustomDBGrid read <getter>;

  Result := TCustomDBGrid_sw.ToVar(TGridDataLink(AObj).Grid);
end;

class function TGridDataLink_sw.GetTypeName: WideString;
begin
  Result := 'TGridDataLink';
end;

class function TGridDataLink_sw.GetWrappedClass: TClass;
begin
  Result := TGridDataLink;
end;

class procedure TGridDataLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('AddMapping', TGridDataLink_AddMapping_si, Boolean_sw, 1, False);
  AData.AddProcedure('ClearMapping', TGridDataLink_ClearMapping_si, 0, False);
  AData.AddProcedure('Modified', TGridDataLink_Modified_si, 0, False);
  AData.AddProcedure('Reset', TGridDataLink_Reset_si, 0, False);
  AData.AddProperty('DefaultFields', TGridDataLink_DefaultFields_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('FieldCount', TGridDataLink_FieldCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Fields', TGridDataLink_Fields_si, TField_sw, True, False, 1, False, False);
  AData.AddProperty('SparseMap', TGridDataLink_SparseMap_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Grid', TGridDataLink_Grid_si, TCustomDBGrid_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TGridDataLink_Create_si, 1, False);
end;

class function TGridDataLink_sw.ToVar(const AValue: TGridDataLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TGridDataLink_sw.FromVar(
  const AValue: OleVariant): TGridDataLink;
begin
  Result := TGridDataLink(ConvFromVar(AValue, TGridDataLink));
end;

class function TGridDataLink_sw.ClassToVar(
  AClass: TGridDataLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TGridDataLink_sw.ClassFromVar(
  const AClass: OleVariant): TGridDataLink_sc;
begin
  Result := TGridDataLink_sc(ConvClsFromVar(AClass, TGridDataLink));
end;

{ TBookmarkList_sw }

function TBookmarkList_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AGrid: TCustomDBGrid);

  Result := TBookmarkList_sw.ToVar(TBookmarkList_sc(AObj).Create(
    TCustomDBGrid_sw.FromVar(AArgs[0])));
end;

function TBookmarkList_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TBookmarkList(AObj).Clear();
end;

function TBookmarkList_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Delete;

  TBookmarkList(AObj).Delete();
end;

function TBookmarkList_Refresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Refresh: Boolean;

  Result := TBookmarkList(AObj).Refresh();
end;

function TBookmarkList_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Count: Integer read <getter>;

  Result := TBookmarkList(AObj).Count;
end;

function TBookmarkList_CurrentRowSelected_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CurrentRowSelected: Boolean read <getter> write ...

  if IsGet then
    Result := TBookmarkList(AObj).CurrentRowSelected
  else
    TBookmarkList(AObj).CurrentRowSelected := Boolean(AArgs[0]);
end;

class function TBookmarkList_sw.GetTypeName: WideString;
begin
  Result := 'TBookmarkList';
end;

class function TBookmarkList_sw.GetWrappedClass: TClass;
begin
  Result := TBookmarkList;
end;

class procedure TBookmarkList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Clear', TBookmarkList_Clear_si, 0, False);
  AData.AddProcedure('Delete', TBookmarkList_Delete_si, 0, False);
  AData.AddFunction('Refresh', TBookmarkList_Refresh_si, Boolean_sw, 0, False);
  AData.AddProperty('Count', TBookmarkList_Count_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('CurrentRowSelected', TBookmarkList_CurrentRowSelected_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TBookmarkList_Create_si, 1, False);
end;

class function TBookmarkList_sw.ToVar(const AValue: TBookmarkList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBookmarkList_sw.FromVar(
  const AValue: OleVariant): TBookmarkList;
begin
  Result := TBookmarkList(ConvFromVar(AValue, TBookmarkList));
end;

class function TBookmarkList_sw.ClassToVar(
  AClass: TBookmarkList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBookmarkList_sw.ClassFromVar(
  const AClass: OleVariant): TBookmarkList_sc;
begin
  Result := TBookmarkList_sc(ConvClsFromVar(AClass, TBookmarkList));
end;

{ TDBGridOption_sw }

class function TDBGridOption_sw.GetTypeName: WideString;
begin
  Result := 'TDBGridOption';
end;

class procedure TDBGridOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..12] of TLMDEnumerator = (
    (Name: 'dgEditing'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgEditing)),
    (Name: 'dgAlwaysShowEditor'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgAlwaysShowEditor)),
    (Name: 'dgTitles'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgTitles)),
    (Name: 'dgIndicator'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgIndicator)),
    (Name: 'dgColumnResize'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgColumnResize)),
    (Name: 'dgColLines'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgColLines)),
    (Name: 'dgRowLines'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgRowLines)),
    (Name: 'dgTabs'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgTabs)),
    (Name: 'dgRowSelect'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgRowSelect)),
    (Name: 'dgAlwaysShowSelection'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgAlwaysShowSelection)),
    (Name: 'dgConfirmDelete'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgConfirmDelete)),
    (Name: 'dgCancelOnExit'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgCancelOnExit)),
    (Name: 'dgMultiSelect'; Value: Integer({$IFDEF LMDSCT_12}TDBGridOption.{$ENDIF}dgMultiSelect))
  );
begin
  AEnums := @ENUMS;
  ACount := 13;
end;

class function TDBGridOption_sw.ToVar(const AValue: TDBGridOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDBGridOption_sw.FromVar(
  const AValue: OleVariant): TDBGridOption;
begin
  Result := TDBGridOption(Integer(AValue));
end;

{ TDBGridOptions_sw }

class function TDBGridOptions_sw.GetTypeName: WideString;
begin
  Result := 'TDBGridOptions';
end;

class function TDBGridOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TDBGridOptions);
end;

class function TDBGridOptions_sw.ToVar(
  const AValue: TDBGridOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TDBGridOptions_sw.FromVar(
  const AValue: OleVariant): TDBGridOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TDBGridClickEvent_sh }

function TDBGridClickEvent_sh.GetHandler: TMethod;
var
  hdr: TDBGridClickEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDBGridClickEvent_sh.Handler(Column: TColumn);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (Column: TColumn) of object

  args[0] := TColumn_sw.ToVar(Column);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TDBGridClickEvent_sw }

class function TDBGridClickEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDBGridClickEvent';
end;

class function TDBGridClickEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDBGridClickEvent_sh;
end;

class function TDBGridClickEvent_sw.ToVar(
  const AValue: TDBGridClickEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDBGridClickEvent_sw.FromVar(
  const AValue: OleVariant): TDBGridClickEvent;
begin
  Result := TDBGridClickEvent(ConvFromVar(AValue));
end;

class function TDBGridClickEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TDBGridClickEvent;
var
  hdlr: TDBGridClickEvent_sh;
begin
  hdlr   := TDBGridClickEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDBGridClickEvent_sw));
  Result := hdlr.Handler;
end;

{ TCustomDBGrid_sw }

function TCustomDBGrid_Columns_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Columns: TDBGridColumns read <getter> ...

  if IsGet then
    Result := TDBGridColumns_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(AObj)).
      Columns)
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).Columns := TDBGridColumns_sw.
      FromVar(AArgs[0]);
end;

function TCustomDBGrid_DefaultDrawing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DefaultDrawing: Boolean read <getter> ...

  if IsGet then
    Result := TCustomDBGrid_sacc(TCustomDBGrid(AObj)).DefaultDrawing
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).DefaultDrawing := Boolean(AArgs[0]);
end;

function TCustomDBGrid_DataLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DataLink: TGridDataLink read <getter>;

  Result := TGridDataLink_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(AObj)).
    DataLink);
end;

function TCustomDBGrid_IndicatorOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property IndicatorOffset: Byte read <getter>;

  Result := TCustomDBGrid_sacc(TCustomDBGrid(AObj)).IndicatorOffset;
end;

function TCustomDBGrid_LayoutLock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property LayoutLock: Byte read <getter>;

  Result := TCustomDBGrid_sacc(TCustomDBGrid(AObj)).LayoutLock;
end;

function TCustomDBGrid_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Options: TDBGridOptions read <getter> ...

  if IsGet then
    Result := TDBGridOptions_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(AObj)).
      Options)
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).Options := TDBGridOptions_sw.
      FromVar(AArgs[0]);
end;

function TCustomDBGrid_ReadOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ReadOnly: Boolean read <getter> write ...

  if IsGet then
    Result := TCustomDBGrid_sacc(TCustomDBGrid(AObj)).ReadOnly
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).ReadOnly := Boolean(AArgs[0]);
end;

function TCustomDBGrid_SelectedRows_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property SelectedRows: TBookmarkList read <gett...

  Result := TBookmarkList_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(AObj)).
    SelectedRows);
end;

function TCustomDBGrid_TitleFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TitleFont: TFont read <getter> write <...

  if IsGet then
    Result := TFont_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(AObj)).TitleFont)
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).TitleFont := TFont_sw.FromVar(
      AArgs[0]);
end;

function TCustomDBGrid_UpdateLock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property UpdateLock: Byte read <getter>;

  Result := TCustomDBGrid_sacc(TCustomDBGrid(AObj)).UpdateLock;
end;

function TCustomDBGrid_OnColEnter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnColEnter: TNotifyEvent read <getter>...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(AObj)).
      OnColEnter)
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).OnColEnter := TNotifyEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomDBGrid_OnColExit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnColExit: TNotifyEvent read <getter> ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(AObj)).
      OnColExit)
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).OnColExit := TNotifyEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomDBGrid_OnEditButtonClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnEditButtonClick: TNotifyEvent read <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(AObj)).
      OnEditButtonClick)
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).OnEditButtonClick := 
      TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCustomDBGrid_OnColumnMoved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnColumnMoved: TMovedEvent read <gette...

  if IsGet then
    Result := TMovedEvent_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(AObj)).
      OnColumnMoved)
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).OnColumnMoved := TMovedEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomDBGrid_OnCellClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCellClick: TDBGridClickEvent read <g...

  if IsGet then
    Result := TDBGridClickEvent_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(
      AObj)).OnCellClick)
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).OnCellClick := TDBGridClickEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomDBGrid_OnTitleClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnTitleClick: TDBGridClickEvent read <...

  if IsGet then
    Result := TDBGridClickEvent_sw.ToVar(TCustomDBGrid_sacc(TCustomDBGrid(
      AObj)).OnTitleClick)
  else
    TCustomDBGrid_sacc(TCustomDBGrid(AObj)).OnTitleClick := 
      TDBGridClickEvent_sw.FromVar(AArgs[0]);
end;

function TCustomDBGrid_ShowPopupEditor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowPopupEditor(Column: TColumn; X: Integer; Y:...

  case AArgsSize of
    1:
    begin
      TCustomDBGrid(AObj).ShowPopupEditor(TColumn_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TCustomDBGrid(AObj).ShowPopupEditor(TColumn_sw.FromVar(AArgs[0]), Integer(
        AArgs[1]));
    end;
    3:
    begin
      TCustomDBGrid(AObj).ShowPopupEditor(TColumn_sw.FromVar(AArgs[0]), Integer(
        AArgs[1]), Integer(AArgs[2]));
    end;
  else
    WrongArgCountError('ShowPopupEditor');
  end;
end;

function TCustomDBGrid_ValidFieldIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ValidFieldIndex(FieldIndex: Integer): Boolean;

  Result := TCustomDBGrid(AObj).ValidFieldIndex(Integer(AArgs[0]));
end;

function TCustomDBGrid_FieldCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FieldCount: Integer read <getter>;

  Result := TCustomDBGrid(AObj).FieldCount;
end;

function TCustomDBGrid_Fields_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Fields[FieldIndex: Integer]: TField read <getter>;

  Result := TField_sw.ToVar(TCustomDBGrid(AObj).Fields[Integer(AArgs[0])]);
end;

function TCustomDBGrid_SelectedField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelectedField: TField read <getter> write <setter>;

  if IsGet then
    Result := TField_sw.ToVar(TCustomDBGrid(AObj).SelectedField)
  else
    TCustomDBGrid(AObj).SelectedField := TField_sw.FromVar(AArgs[0]);
end;

function TCustomDBGrid_SelectedIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelectedIndex: Integer read <getter> write <sett...

  if IsGet then
    Result := TCustomDBGrid(AObj).SelectedIndex
  else
    TCustomDBGrid(AObj).SelectedIndex := Integer(AArgs[0]);
end;

function TCustomDBGrid_DataSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSource: TDataSource read <getter> write <set...

  if IsGet then
    Result := TDataSource_sw.ToVar(TCustomDBGrid(AObj).DataSource)
  else
    TCustomDBGrid(AObj).DataSource := TDataSource_sw.FromVar(AArgs[0]);
end;

class function TCustomDBGrid_sw.GetTypeName: WideString;
begin
  Result := 'TCustomDBGrid';
end;

class function TCustomDBGrid_sw.GetWrappedClass: TClass;
begin
  Result := TCustomDBGrid;
end;

class procedure TCustomDBGrid_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Columns', TCustomDBGrid_Columns_si, TDBGridColumns_sw, True, True, 0, True, False);
  AData.AddProperty('DefaultDrawing', TCustomDBGrid_DefaultDrawing_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('DataLink', TCustomDBGrid_DataLink_si, TGridDataLink_sw, True, False, 0, True, False);
  AData.AddProperty('IndicatorOffset', TCustomDBGrid_IndicatorOffset_si, Byte_sw, True, False, 0, True, False);
  AData.AddProperty('LayoutLock', TCustomDBGrid_LayoutLock_si, Byte_sw, True, False, 0, True, False);
  AData.AddProperty('Options', TCustomDBGrid_Options_si, TDBGridOptions_sw, True, True, 0, True, False);
  AData.AddProperty('ReadOnly', TCustomDBGrid_ReadOnly_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('SelectedRows', TCustomDBGrid_SelectedRows_si, TBookmarkList_sw, True, False, 0, True, False);
  AData.AddProperty('TitleFont', TCustomDBGrid_TitleFont_si, TFont_sw, True, True, 0, True, False);
  AData.AddProperty('UpdateLock', TCustomDBGrid_UpdateLock_si, Byte_sw, True, False, 0, True, False);
  AData.AddProperty('OnColEnter', TCustomDBGrid_OnColEnter_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnColExit', TCustomDBGrid_OnColExit_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnEditButtonClick', TCustomDBGrid_OnEditButtonClick_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnColumnMoved', TCustomDBGrid_OnColumnMoved_si, TMovedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCellClick', TCustomDBGrid_OnCellClick_si, TDBGridClickEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnTitleClick', TCustomDBGrid_OnTitleClick_si, TDBGridClickEvent_sw, True, True, 0, True, False);
  AData.AddProcedure('ShowPopupEditor', TCustomDBGrid_ShowPopupEditor_si, 1, True);
  AData.AddFunction('ValidFieldIndex', TCustomDBGrid_ValidFieldIndex_si, Boolean_sw, 1, False);
  AData.AddPropertyRedecl('EditorMode', False);
  AData.AddProperty('FieldCount', TCustomDBGrid_FieldCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Fields', TCustomDBGrid_Fields_si, TField_sw, True, False, 1, False, False);
  AData.AddProperty('SelectedField', TCustomDBGrid_SelectedField_si, TField_sw, True, True, 0, False, False);
  AData.AddProperty('SelectedIndex', TCustomDBGrid_SelectedIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('DataSource', TCustomDBGrid_DataSource_si, TDataSource_sw, True, True, 0, False, False);
end;

class function TCustomDBGrid_sw.ToVar(const AValue: TCustomDBGrid): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomDBGrid_sw.FromVar(
  const AValue: OleVariant): TCustomDBGrid;
begin
  Result := TCustomDBGrid(ConvFromVar(AValue, TCustomDBGrid));
end;

class function TCustomDBGrid_sw.ClassToVar(
  AClass: TCustomDBGrid_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomDBGrid_sw.ClassFromVar(
  const AClass: OleVariant): TCustomDBGrid_sc;
begin
  Result := TCustomDBGrid_sc(ConvClsFromVar(AClass, TCustomDBGrid));
end;

{ TDBGrid_sw }

class function TDBGrid_sw.GetTypeName: WideString;
begin
  Result := 'TDBGrid';
end;

class function TDBGrid_sw.GetWrappedClass: TClass;
begin
  Result := TDBGrid;
end;

class procedure TDBGrid_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Canvas', False);
  AData.AddPropertyRedecl('SelectedRows', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Columns', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('DataSource', False);
  AData.AddPropertyRedecl('DefaultDrawing', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('FixedColor', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('ImeMode', False);
  AData.AddPropertyRedecl('ImeName', False);
  AData.AddPropertyRedecl('Options', False);
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
  AData.AddPropertyRedecl('TitleFont', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnCellClick', False);
  AData.AddPropertyRedecl('OnColEnter', False);
  AData.AddPropertyRedecl('OnColExit', False);
  AData.AddPropertyRedecl('OnColumnMoved', False);
  AData.AddPropertyRedecl('OnDrawDataCell', False);
  AData.AddPropertyRedecl('OnDrawColumnCell', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEditButtonClick', False);
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
  AData.AddPropertyRedecl('OnMouseWheel', False);
  AData.AddPropertyRedecl('OnMouseWheelDown', False);
  AData.AddPropertyRedecl('OnMouseWheelUp', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnTitleClick', False);
end;

class function TDBGrid_sw.ToVar(const AValue: TDBGrid): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDBGrid_sw.FromVar(const AValue: OleVariant): TDBGrid;
begin
  Result := TDBGrid(ConvFromVar(AValue, TDBGrid));
end;

class function TDBGrid_sw.ClassToVar(AClass: TDBGrid_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDBGrid_sw.ClassFromVar(const AClass: OleVariant): TDBGrid_sc;
begin
  Result := TDBGrid_sc(ConvClsFromVar(AClass, TDBGrid));
end;

{ DBGrids_sw }

function DBGrids_TColumnValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColumnValue = (cvColor, cvWidth, cvFont, cvAlignmen...

  Result := TLMDUnitWrapper.TypeToVar(TColumnValue_sw);
end;

function DBGrids_TColumnValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColumnValues = set of TColumnValue;

  Result := TLMDUnitWrapper.TypeToVar(TColumnValues_sw);
end;

function DBGrids_ColumnTitleValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const ColumnTitleValues = <value>;

  Result := LMDSetToVar(SizeOf(ColumnTitleValues), ColumnTitleValues);
end;

function DBGrids_cm_DeferLayout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cm_DeferLayout = <value>;

  Result := cm_DeferLayout;
end;

function DBGrids_TColumnTitle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColumnTitle = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TColumnTitle_sw);
end;

function DBGrids_TColumnButtonStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColumnButtonStyle = (cbsAuto, cbsEllipsis, cbsNone);

  Result := TLMDUnitWrapper.TypeToVar(TColumnButtonStyle_sw);
end;

function DBGrids_TColumn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColumn = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TColumn_sw);
end;

function DBGrids_TColumnClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColumnClass = class of TColumn;

  Result := TLMDUnitWrapper.TypeToVar(TColumnClass_sw);
end;

function DBGrids_TDBGridColumnsState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBGridColumnsState = (csDefault, csCustomized);

  Result := TLMDUnitWrapper.TypeToVar(TDBGridColumnsState_sw);
end;

function DBGrids_TDBGridColumns_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBGridColumns = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TDBGridColumns_sw);
end;

function DBGrids_TGridDataLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGridDataLink = class(TDataLink);

  Result := TLMDUnitWrapper.TypeToVar(TGridDataLink_sw);
end;

function DBGrids_TBookmarkList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBookmarkList = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TBookmarkList_sw);
end;

function DBGrids_TDBGridOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBGridOption = (dgEditing, dgAlwaysShowEditor, dgTi...

  Result := TLMDUnitWrapper.TypeToVar(TDBGridOption_sw);
end;

function DBGrids_TDBGridOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBGridOptions = set of TDBGridOption;

  Result := TLMDUnitWrapper.TypeToVar(TDBGridOptions_sw);
end;

function DBGrids_TDBGridClickEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBGridClickEvent = procedure (Column: TColumn) of o...

  Result := TLMDUnitWrapper.TypeToVar(TDBGridClickEvent_sw);
end;

function DBGrids_TCustomDBGrid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomDBGrid = class(TCustomGrid);

  Result := TLMDUnitWrapper.TypeToVar(TCustomDBGrid_sw);
end;

function DBGrids_TDBGrid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDBGrid = class(TCustomDBGrid);

  Result := TLMDUnitWrapper.TypeToVar(TDBGrid_sw);
end;

function DBGrids_IndicatorWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IndicatorWidth = <value>;

  Result := IndicatorWidth;
end;

class function DBGrids_sw.GetUnitName: WideString;
begin
  Result := 'DBGrids';
end;

class procedure DBGrids_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TColumnValue_sw, DBGrids_TColumnValue_si);
  AData.AddType(TColumnValues_sw, DBGrids_TColumnValues_si);
  AData.AddConstant('ColumnTitleValues', DBGrids_ColumnTitleValues_si, nil, varInteger);
  AData.AddConstant('cm_DeferLayout', DBGrids_cm_DeferLayout_si, nil, VarType(DBGrids.cm_DeferLayout));
  AData.AddType(TColumnTitle_sw, DBGrids_TColumnTitle_si);
  AData.AddType(TColumnButtonStyle_sw, DBGrids_TColumnButtonStyle_si);
  AData.AddType(TColumn_sw, DBGrids_TColumn_si);
  AData.AddType(TColumnClass_sw, DBGrids_TColumnClass_si);
  AData.AddType(TDBGridColumnsState_sw, DBGrids_TDBGridColumnsState_si);
  AData.AddType(TDBGridColumns_sw, DBGrids_TDBGridColumns_si);
  AData.AddType(TGridDataLink_sw, DBGrids_TGridDataLink_si);
  AData.AddType(TBookmarkList_sw, DBGrids_TBookmarkList_si);
  AData.AddType(TDBGridOption_sw, DBGrids_TDBGridOption_si);
  AData.AddType(TDBGridOptions_sw, DBGrids_TDBGridOptions_si);
  AData.AddType(TDBGridClickEvent_sw, DBGrids_TDBGridClickEvent_si);
  AData.AddType(TCustomDBGrid_sw, DBGrids_TCustomDBGrid_si);
  AData.AddType(TDBGrid_sw, DBGrids_TDBGrid_si);
  AData.AddConstant('IndicatorWidth', DBGrids_IndicatorWidth_si, nil, VarType(DBGrids.IndicatorWidth));
end;

class function DBGrids_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DBGrids_sw);
end;

initialization
  RegisterUnitWrapper(DBGrids_sw);
  RegisterClassWrapper(TColumnTitle_sw);
  RegisterClassWrapper(TColumn_sw);
  RegisterClassWrapper(TDBGridColumns_sw);
  RegisterClassWrapper(TGridDataLink_sw);
  RegisterClassWrapper(TBookmarkList_sw);
  RegisterClassWrapper(TCustomDBGrid_sw);
  RegisterClassWrapper(TDBGrid_sw);
  RegisterEventWrapper(TypeInfo(TDBGridClickEvent), TDBGridClickEvent_sw);

end.
