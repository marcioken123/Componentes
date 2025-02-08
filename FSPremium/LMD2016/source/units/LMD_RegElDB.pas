unit LMD_RegElDB;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

_LMD_RegElDB unit
-----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

  {$R LMDElPackDB.dcr}

interface

uses
  TypInfo,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  Classes,
     Db,
     pLMDELDBNavDsgn,
     ElDBInspector,
     ElDBTreeNavigator,
     pLMDElDBTreeNavDesign,

     ElDBLookupCtrls,
{$ifdef LMD_UNICODE}
     ElDBWideLookupControls,
     ElDBWideLookupComboGrid,
     ElDBWideComboBox,
{$endif}

     ElDBBoxes,
     ElDBBtnEdit,

     ElPropTools,
     ElDBCtrls,

     ElDBDTPick,

     pLMDELDBTreeDsgn,
     pLMDELDBXTreeDsgn,
     ElDBTree,
     ElDBTreeGrids,
     ElDBXTree,
     ElDBXTreeGrids

     ,
     ElDBCurrEdit,
     ElDBHTMLView,
     ElDBLbl,
     ElDBSpin,
     ElTree,
     pLMDElRelSourcePropDsgn,
     pLMDElXRelSourcePropDsgn,
     pLMDElXRelDataSourceDsgn,
     pLMDElXRelationsDsgn,
     pLMDElDBXTreeGridDsgn,
     pLMDElDBTreeGridDsgn,
     pLMDElDBTreeInplaceEditPropDsgn,
     pLMDElStylesProp,
     pLMDElXStylesProp,
     pLMDElXGridColProp,
     ElDBTreeEditors

     ;

procedure Register;

implementation

type
  TDBStringProperty = class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValueList(List : TStrings); virtual; abstract;
    procedure GetValues(Proc : TGetStrProc); override;
  end;

  TDataFieldProperty = class(TDBStringProperty)
  public
    function GetDataSourcePropName : string; virtual;
    procedure GetValueList(List : TStrings); override;
  end;

  TListFieldProperty = class(TDataFieldProperty)
  public
    function GetDataSourcePropName : string; override;
  end;

function TDBStringProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDBStringProperty.GetValues(Proc : TGetStrProc);
var
  I : Integer;
  Values : TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do
      Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

function TDataFieldProperty.GetDataSourcePropName : string;
begin
  Result := 'DataSource';
end;

procedure TDataFieldProperty.GetValueList(List : TStrings);
var
  PPI : PPropInfo;
  DataSource : TDataSource;

  function GetObjectProp(Instance: TObject; PropInfo: PPropInfo): TObject;
  begin
    Result := TObject(GetOrdProp(Instance, PropInfo));
  end;

begin
  PPI := GetPropertyRecord(GetComponent(0), GetDataSourcePropName);
  if PPI <> nil then
  begin
    DataSource := GetObjectProp(GetComponent(0), PPI) as TDataSource;
    if (DataSource <> nil) and (DataSource.DataSet <> nil) then
      DataSource.DataSet.GetFieldNames(List);
    Dispose(PPI);
  end;
end;

function TListFieldProperty.GetDataSourcePropName : string;
begin
  Result := 'ListSource';
end;

procedure Register;
begin

  RegisterComponents('ElPack DB',      [TElDBNavigator,
                                        TElDBTreeNavigator,
                                        TElDBLabel,
                                        TElDBHTMLView,
                                        TElDBCheckBox,
                                        TElDBRadioGroup,
                                        TElInspectorDBDataSource
                                        ]);

  RegisterComponents('ElPack DB Tree', [TElDBXTree,
                                        TElXRelDataSource,
                                        TElDBXTreeStringGrid,
                                        TElDBTreeEdit,
                                        TElDBTreeMemoEdit,
                                        TElDBTreeDateTimePickerEdit,
                                        TElDBTreeCurrencyEdit,
                                        TElDBTreeFloatSpinEdit,
                                        TElDBTreeSpinEdit,
                                        TElDBTreeCheckBoxEdit,
                                        TElDBTreeComboBoxEdit,
                                        TElDBTreeLookupComboBoxEdit,
                                        TElDBTreeLookupComboGridEdit,
                                        {$ifdef LMD_UNICODE}
                                        TElDBTreeWideStringEdit,
                                        {$ENDIF}
                                        TElDBTree,
                                        TElDBTreeStringGrid,
                                        TElRelDataSource
                                       ]);

  RegisterComponents('ElPack DB Edit', [TElDBEdit,
                                        TElDBMemo,
                                        TElDBButtonEdit,
                                        TElDBCurrencyEdit,
                                        TElDBDateTimePicker,
                                        TElDBSpinEdit,
                                        TElDBFloatSpinEdit
                                        {$ifdef LMD_UNICODE}
                                        ,TElWideDBEdit,
                                        TElWideDBMemo
                                        {$endif}
                                        ]);

  RegisterComponents('ElPack DB List', [TElDBListBox,
                                        TElDBComboBox,
                                        TElDBLookupListBox,
                                        TElDBLookupComboBox
                                        {$ifdef LMD_UNICODE}
                                        ,TElWideDBComboBox,
                                        TElWideDBLookupListBox,
                                        TElWideDBLookupComboBox,
                                        TElWideDBLookupComboGrid
                                        {$endif}
                                       ]);

  RegisterNoIcon([TElDBTreeNavButton]);
  Classes.RegisterClass(TElDBTreeNavButton);
  RegisterComponentEditor(TElDBTreeNavigator, TElDBTreeNavigatorEditor);

  RegisterNoIcon([TElDBNavButton]);
  Classes.RegisterClass(TElDBNavButton);

  RegisterPropertyEditor(TypeInfo(TElDataField),TElRelDataSource,'',TElDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(TElMasterField),TElRelationsItem,'',TElMasterFieldProperty);
  RegisterPropertyEditor(TypeInfo(TElDetailField),TElRelationsItem,'',TElDetailFieldProperty);
  RegisterPropertyEditor(TypeInfo(TElDetailDisplayField),TElRelationsItem,'',TElDetailDisplayFieldProperty);
  RegisterPropertyEditor(TypeInfo(TElStylesDefs), TElDBTree, 'StylesDefs', TElStylesDefsProperty);
  RegisterPropertyEditor(TypeInfo(TElStylesDefs), TElDBTreeStringGrid, 'StylesDefs', TElStylesDefsProperty);

  RegisterComponentEditor(TElXRelDataSource, TElRelDataSourceEditor);
  RegisterPropertyEditor(TypeInfo(TElXRelations), TElXRelDataSource, 'Relations',TElRelationsProperty);
  RegisterPropertyEditor(TypeInfo(TElXDataField),TElXRelDataSource,'',TElXDataFieldProperty);
  RegisterComponentEditor(TElDBXTree, TElDBXTreeEditor);
  RegisterComponentEditor(TElDBXTreeStringGrid, TElDBXTreeGridEditor);
  RegisterPropertyEditor(TypeInfo(TElXStylesDefs), TElDBXTree, 'StylesDefs', TElXStylesDefsProperty);
  RegisterPropertyEditor(TypeInfo(TElXStylesDefs), TElDBXTreeStringGrid, 'StylesDefs', TElXStylesDefsProperty);
  RegisterPropertyEditor(TypeInfo(TElDBXTreeGridColumns), TElDBXTreeStringGrid, 'Columns', TElXColumnsDefsProperty);

  RegisterPropertyEditor(TypeInfo(TCustomElTree),TElDBTreeInplaceEditor,'',TElDBTreeProperty);

  RegisterPropertyEditor(TypeInfo(string), TElDBEdit,    'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBMemo,    'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBLabel,   'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBListBox, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBSpinEdit, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBComboBox, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBHTMLView, 'DataField', TDataFieldProperty);

  RegisterPropertyEditor(TypeInfo(string), TElDBCheckBox, 'DataField', TDataFieldProperty);

  RegisterPropertyEditor(TypeInfo(string), TElDBButtonEdit, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBRadioGroup, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBCurrencyEdit, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBFloatSpinEdit, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBDateTimePicker, 'DataField', TDataFieldProperty);

{$ifdef LMD_UNICODE}
  RegisterPropertyEditor(TypeInfo(string), TElWideDBEdit, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElWideDBMemo, 'DataField', TDataFieldProperty);
{$endif}
  RegisterPropertyEditor(TypeInfo(string), TElDBLookupListBox, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBLookupListBox, 'ListField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBLookupListBox, 'KeyField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBLookupComboBox, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBLookupComboBox, 'ListField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElDBLookupComboBox, 'KeyField', TListFieldProperty);

{$ifdef LMD_UNICODE}
  RegisterPropertyEditor(TypeInfo(string), TElWideDBLookupListBox, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElWideDBLookupListBox, 'ListField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElWideDBLookupListBox, 'KeyField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElWideDBLookupComboBox, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElWideDBLookupComboBox, 'ListField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElWideDBLookupComboBox, 'KeyField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElWideDBLookupComboGrid, 'DataField', TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElWideDBLookupComboGrid, 'ListField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TElWideDBLookupComboGrid, 'KeyField', TListFieldProperty);
{$endif}

  RegisterComponentEditor(TElDBNavigator, TElDBNavigatorEditor);
  RegisterComponentEditor(TElDBTree, TElDBTreeEditor);

  RegisterComponentEditor(TElDBTreeStringGrid, TElDBTreeGridEditor);

end;

end.
