unit Wwprpedt;
{
//
// Components : Property Editors
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
// 3/5/98 - GetComponentData work generically with TDataSet
// 12/1/98 - Check if grid.datasource.dataset is nil
// 11/19/99 - Fix bug in not updating maplist property
}
interface

{$i wwIfDef.pas}

Uses controls, dialogs, wwDBLook, classes, db, wwTable, wwDBGrid,wwdbigrd,
     wwCommon, wwidlg, dbtables, sysutils, wwselfld, wwstr, wwQuery, wwQBE,
     stdctrls, wwdatainspector, ipabout, registry,
       {$ifdef wwdelphi6up}
       designintf, designeditors,
       {$else}
       dsgnintf,
       {$endif}

{$ifdef win32}
     comctrls, wwrich, wwriched,
{$else}
     LibMain,
{$endif}
     wwlocate, wwfltfld, wwfltdlg, wwrcdvw, wwrcdpnl, buttons, wwintl;


Type

  TwwComponentEditor = class(TDefaultEditor)
  private
    procedure ShowAboutBox;
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  TwwGridComponentEditor = class(TwwComponentEditor)
  private
    function SupportIniSave: boolean;
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

  TwwIndexDefsProperty = class(TStringProperty)
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

  TwwTableProperty = class(TComponentProperty)
     procedure GetValues(Proc : TGetStrProc); override;
  end;

  TwwIndexFieldProperty = class(TStringProperty)
     function GetAttributes: TPropertyAttributes; override;
     procedure GetValues(Proc : TGetStrProc); override;
  end;

  TwwSearchFieldProperty = class(TStringProperty)
     function GetAttributes: TPropertyAttributes; override;
     procedure GetValues(Proc : TGetStrProc); override;
  end;

  TwwDBLookupDisplayProperty = class(TPropertyEditor)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

  TwwTableDisplayProperty = class(TPropertyEditor)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

  TwwDBLookupDisplayComponentEditor = class(TwwComponentEditor)
     procedure Edit; override;
  end;

  TSelectedFieldsProperty = class(TPropertyEditor)
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  TwwDBGridComponentEditor = class(TwwGridComponentEditor)
    procedure Edit; override;
  end;

  TwwRecordViewPanelComponentEditor = class(TwwComponentEditor)
    procedure Edit; override;
  end;

  TwwFilterFieldsProperty = class(TPropertyEditor)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

  TwwComboItemsProperty = class(TPropertyEditor)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

  TwwObjPictureProperty = class(TClassProperty)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;


  TwwMultiLineStringProperty = class(TClassProperty)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
     procedure SetValue(const value: string); override;
  end;

  TwwPictureProperty = class(TClassProperty)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

  TwwPicturePropertyGen = class(TClassProperty)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

  TwwRecordViewComponentEditor = class(TwwComponentEditor)
    procedure Edit; override;
  end;

{  TwwDataInspectorComponentEditor = class(TDefaultEditor)
    procedure Edit; override;
  end;
}
  TwwGridIndicatorProperty = class(TPropertyEditor)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

{$ifdef win32}
  TwwRichEditItemsProperty = class(TPropertyEditor)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

  TwwRichEditComponentEditor = class(TwwComponentEditor)
     procedure Edit; override;
  end;

{$endif}

function EditSelectedFieldsProperty(AComponent: TComponent;
        listHandle: TStrings; dataSet: TDataSet;
        designer:
        {$ifdef wwDelphi6Up}
        IDesigner;
        {$else}
          {$ifdef wwDelphi4Up}
          IFormDesigner;
          {$else}
          TFormDesigner;
          {$endif}
        {$endif}
        readFromTableComponent: Boolean;
        var useTFields: boolean; propertyType: TwwSelectedPropertyType): boolean;

procedure Register;


implementation

uses wwdbcomb, wwprpcom, wwdbedit, wwprppic, wwpiced2,
     forms, wwstorep, typinfo;

{type SmallString = string[64];}

procedure GetComponentData(AComponent: TComponent;
            var ASelected: TStrings; var ADataSet: TDataSet);
begin
    if AComponent is TwwDBLookupList then begin
       ASelected:= (AComponent as TwwDBLookupList).Selected;
       ADataSet:= (AComponent as TwwDBLookupList).LookupTable;
    end
    else if AComponent is TwwDBCustomLookupCombo then begin
       ASelected:= (AComponent as TwwDBCustomLookupCombo).Selected;
       ADataSet:= (AComponent as TwwDBCustomLookupCombo).LookupTable;
    end
    else if AComponent is TwwLookupDialog then begin
       ASelected:= (AComponent as TwwLookupDialog).Selected;
       ADataSet:= (AComponent as TwwLookupDialog).LookupTable;
    end
    else if AComponent is TwwSearchDialog then begin
       ASelected:= (AComponent as TwwSearchDialog).Selected;
       ADataSet:= (AComponent as TwwSearchDialog).ShadowSearchTable;
    end
    else if AComponent is TwwRecordViewDialog then begin {5/2/97}
       ASelected:= (AComponent as TwwRecordViewDialog).Selected;
       if (AComponent as TwwRecordViewDialog).DataSource<>nil then
          ADataSet:= (AComponent as TwwRecordViewDialog).DataSource.Dataset
       else ADataSet:= nil;
    end
    else if AComponent is TwwRecordViewPanel then begin {5/2/97}
       ASelected:= (AComponent as TwwRecordViewPanel).Selected;
       if (AComponent as TwwRecordViewPanel).DataSource<>nil then
          ADataSet:= (AComponent as TwwRecordViewPanel).DataSource.Dataset
       else ADataSet:= nil;
    end
{    else if AComponent is TwwDataInspector then begin
       ASelected:= (AComponent as TwwDataInspector).Selected;
       if (AComponent as TwwDataInspector).DataSource<>nil then
          ADataSet:= (AComponent as TwwDataInspector).DataSource.Dataset
       else ADataSet:= nil;
    end}
    else ADataset:= AComponent as TDataset;
{
    if AComponent is TwwTable then begin
       ADataSet:= AComponent as TwwTable
    end
    else if AComponent is TwwQuery then begin
       ADataSet:= AComponent as TwwQuery
    end
    else if AComponent is TwwQBE then begin
       ADataSet:= AComponent as TwwQBE
    end
    else if AComponent is TwwStoredProc then begin
       ADataSet:= AComponent as TwwStoredProc
    end
}
end;


{*** Property editors ***}
Function TwwGridIndicatorProperty.GetValue: string;
begin
   result:= '<TSpeedButton>'
end;

function TwwGridIndicatorProperty.GetAttributes: TPropertyAttributes;
begin
   result:= [paDialog];
end;

procedure TwwGridIndicatorProperty.Edit;
var grid: TwwDBGrid;
begin
   grid:= GetComponent(0) as TwwDBGrid;
   if grid.IndicatorButton=nil then
   begin
      grid.IndicatorButton:= TwwIButton.create(wwGetOwnerForm(grid));
      grid.IndicatorButton.parent:= grid;
      grid.IndicatorButton.name:= grid.name + 'IButton';
      grid.IndicatorButton.width:= 13;
      grid.IndicatorButton.AllowAllUp:=True;
   end;
  {$ifdef win32}
   Designer.SelectComponent(grid.IndicatorButton);
  {$else}
   Complib.GetActiveForm.SetSelection((GetComponent(0) as TwwDBGrid).IndicatorButton.Name);
  {$endif}
end;

function TwwTableDisplayProperty.GetValue: string;
begin
   result:= '<Display>';
end;

function TwwTableDisplayProperty.GetAttributes: TPropertyAttributes;
begin
   result:= [paDialog];
end;

{ Define selected fields property editor for grid }
function EditSelectedFieldsProperty(AComponent: TComponent;
        listHandle: TStrings; dataSet: TDataSet;
        designer:
        {$ifdef wwDelphi6Up}
        IDesigner;
        {$else}
          {$ifdef wwDelphi4Up}
          IFormDesigner;
          {$else}
          TFormDesigner;
          {$endif}
        {$endif}
//         {$ifdef wwDelphi4Up}IFormDesigner{$else}TFormDesigner{$endif};
        readFromTableComponent: Boolean;
        var useTFields: boolean; propertyType: TwwSelectedPropertyType): boolean;
var
  i,j: integer;
  apos: integer;
  SaveList: TStrings;
  ReadOnlyStr, GroupStr: string;
begin
  result:= False;
  if ReadFromTableComponent and (useTFields or (listhandle.count=0)) then begin
       SaveList:= TStringlist.create;
       SaveList.assign(ListHandle);
       ListHandle.clear;
       with dataSet do begin
          if (not Active) and (FieldCount=0) then begin
             MessageDlg('DataSet for this component must be active or have persistent fields to edit design.', mtInformation, [mbok], 0);
             exit;
          end;

          for i:= 0 to fieldCount-1 do begin
             if (fields[i].visible) then begin

                for j:= 0 to SaveList.count-1 do
                begin
                    apos:= 1;
                    ReadOnlyStr:= 'F';
                    GroupStr:= '';
                    if Fields[i].FieldName=strGetToken(SaveList[j], #9, apos) then
                    begin
                        strGetToken(SaveList[j], #9, apos); // display width
                        strGetToken(SaveList[j], #9, apos); // display label
                        ReadOnlyStr:= strGetToken(SaveList[j], #9, apos);
                        GroupStr:= strGetToken(SaveList[j], #9, apos);
                        break;
                    end;
                end;

                if propertyType = sptObjectViewType then
                   ListHandle.add(fields[i].fieldName + #9 +  '0' + #9 +
                              fields[i].displayLabel + #9 + 'F')
                else
                   ListHandle.add(fields[i].fieldName + #9 +
                              inttostr(fields[i].displayWidth) + #9 +
                              fields[i].displayLabel + #9 + ReadOnlyStr + #9 + GroupStr);
             end
          end;
       end;

       SaveList.Free;
   end;

   if wwSelectTableFields(AComponent, dataSet, listHandle, useTFields, Designer, propertyType) then
   begin
      if Designer<>Nil then Designer.modified;
      wwDataModuleChanged(Dataset);
      if (dataSet is TwwTable) then
         if (TwwTable(dataset).query.count=0) then dataSet.refresh;
{               dataset.resync([]);}
      result:= True;
   end
end;


procedure TwwTableDisplayProperty.Edit;
var
   listHandle : TStrings;
   dataSet: TDataSet;
   useTFields: boolean;
begin
    GetComponentData(GetComponent(0) as TComponent, listHandle, dataSet);
    listHandle:= TStringList.create;
    if (dataSet=Nil) then begin
       MessageDlg('Missing TableName property', mtInformation, [mbok], 0);
       exit;
    end;

    useTFields:= True;
{    try}
       if (EditSelectedFieldsProperty(GetComponent(0) as TComponent,
          listHandle, DataSet, Designer, True,
          useTFields, sptDataSetType)) then begin
           wwDataSetUpdateFieldProperties(DataSet, listHandle);
       end;
{    finally}
       listHandle.free;
{    end;}
end;

function TwwDBLookupDisplayProperty.GetValue: string;
var
   listHandle : TStrings;
   dataSet: TDataSet;
begin
   GetComponentData(GetComponent(0) as TComponent, listHandle, dataSet);
{   GetComponentData(GetComponent(0), listHandle, dataSet);}
   if listHandle.count>0 then result:= listHandle[0]
   else result := '';
end;

function TwwDBLookupDisplayProperty.GetAttributes: TPropertyAttributes;
begin
   result:= [paDialog];
end;

procedure TwwDBLookupDisplayProperty.Edit;
var
   listHandle : TStrings;
   dataSet: TDataSet;
   component: TComponent;
   useTFields: boolean;
   SelectedPropertyType: TwwSelectedPropertyType;
begin
    component:= GetComponent(0) as TComponent;
    GetComponentData(GetComponent(0) as TComponent, listHandle, dataSet);
    SelectedPropertyType:= sptNone;
    if GetComponent(0) is TwwCustomLookupDialog then
    begin
       useTFields:= TwwCustomLookupDialog(GetComponent(0)).useTFields;
    end
    else if GetComponent(0) is TwwRecordViewDialog then begin
       useTFields:= False; {TwwRecordViewDialog(GetComponent(0)).useTFields;}
       SelectedPropertyType:= sptRecordViewType;
    end
    else if GetComponent(0) is TwwDataInspector then begin
       SelectedPropertyType:= sptObjectViewType;
       useTFields:= False;
    end
    else if GetComponent(0) is TwwRecordViewPanel then begin
       useTFields:= False;
       SelectedPropertyType:= sptRecordViewType;
    end
    else if GetComponent(0) is TwwDBCustomLookupCombo then begin
       useTFields:= TwwDBCustomLookupCombo(GetComponent(0)).useTFields;
    end;

    if (dataSet=Nil) then begin
       if GetComponent(0) is TwwSearchDialog then begin
          MessageDlg('ShadowSearchTable is required to customize field layout of search dialog.', mtInformation, [mbok], 0);
       end
       else if Component is TwwRecordViewDialog then
          MessageDlg('DataSet required to customize RecordViewDialog Layout.', mtInformation, [mbok], 0)
       else if Component is TwwRecordViewPanel then
          MessageDlg('DataSet required to customize RecordViewPanel Layout.', mtInformation, [mbok], 0)
       else if Component is TwwDataInspector then
          MessageDlg('DataSet required to customize ObjectView Layout.', mtInformation, [mbok], 0)
       else MessageDlg('Missing LookupTable', mtInformation, [mbok], 0);
    end
    else if (EditSelectedFieldsProperty(component, listHandle, DataSet, Designer, True,
             useTFields, selectedPropertyType)) then
    begin
       if useTFields then wwDataSetUpdateFieldProperties(DataSet, listHandle);
       if GetComponent(0) is TwwCustomLookupDialog then
          TwwCustomLookupDialog(GetComponent(0)).useTFields:= useTFields
       else if GetComponent(0) is TwwDBCustomLookupCombo then
          TwwDBCustomLookupCombo(GetComponent(0)).useTFields:= useTFields;
       if Component is TwwDBCustomLookupCombo then
         (Component as TwwDBCustomLookupCombo).refreshDisplay
       else if Component is TwwRecordViewPanel then
         (Component as TwwRecordViewPanel).RecreateControls
       else if Component is TwwDataInspector then
         (Component as TwwDataInspector).ApplySettings;
    end
end;

procedure TwwDBLookupDisplayComponentEditor.Edit;
var
   listHandle : TStrings;
   dataSet: TDataSet;
   useTFields: boolean;
   SelectedPropertyType: TwwSelectedPropertyType;
begin
   GetComponentData(Component, listHandle, dataSet);
   SelectedPropertyType:= sptNone;
   if Component is TwwCustomLookupDialog then
   begin
      useTFields:= TwwCustomLookupDialog(Component).useTFields;
   end
   else if Component is TwwDBCustomLookupCombo then
   begin
      useTFields:= TwwDBCustomLookupCombo(Component).useTFields;
   end
   else if Component is TwwRecordViewDialog then
   begin
      useTFields:= False;
      SelectedPropertyType:= sptRecordViewType;
   end
   else if Component is TwwDataInspector then
   begin
      SelectedPropertyType:= sptObjectViewType;
      useTFields:= False;
   end
   else if Component is TwwRecordViewPanel then
   begin
      useTFields:= False;
      SelectedPropertyType:= sptRecordViewType;
   end;
   if (dataSet=Nil) then begin
      if Component is TwwSearchDialog then begin
         MessageDlg('ShadowSearchTable is required to customize field layout of search dialog.', mtInformation, [mbok], 0);
      end
      else if Component is TwwRecordViewDialog then
         MessageDlg('DataSet required to customize RecordViewDialog Layout.', mtInformation, [mbok], 0)
      else if Component is TwwRecordViewPanel then
         MessageDlg('DataSet required to customize RecordViewPanel Layout.', mtInformation, [mbok], 0)
      else if Component is TwwDataInspector then
         MessageDlg('DataSet required to customize ObjectView Layout.', mtInformation, [mbok], 0)
      else MessageDlg('Missing LookupTable', mtInformation, [mbok], 0);
   end
   else if (EditSelectedFieldsProperty(component, listHandle, DataSet, Designer, False, useTFields,
            SelectedPropertyType)) then
   begin
      if useTFields then wwDataSetUpdateFieldProperties(DataSet, listHandle);
      if Component is TwwCustomLookupDialog then
         TwwCustomLookupDialog(Component).useTFields:= useTFields
      else if Component is TwwDBCustomLookupCombo then
         TwwDBCustomLookupCombo(Component).useTFields:= useTFields;
      if Component is TwwDBCustomLookupCombo then
        (Component as TwwDBCustomLookupCombo).refreshDisplay
      else if Component is TwwRecordViewPanel then
         (Component as TwwRecordViewPanel).RecreateControls
       else if Component is TwwDataInspector then
         (Component as TwwDataInspector).ApplySettings;
   end
end;

Function TwwIndexFieldProperty.GetAttributes: TPropertyAttributes;
begin
   result:= [paValueList, paSortList];
end;

procedure TwwIndexFieldProperty.GetValues(Proc : TGetStrProc);
var
    LookupTable: TDataSet;
    curpos, i: integer;
    addedList: TStrings;
    indexFieldName: string;
begin
    if GetComponent(0) is TwwDBCustomLookupCombo then
       LookupTable:= (GetComponent(0) as TwwDBCustomLookupCombo).LookupTable
    else exit;

    if (LookupTable<>Nil) then begin
       if (LookupTable is TTable) or
          (LookupTable is TwwTable) and ((LookupTable as TwwTable).Query.Count=0) then begin
          addedList:= TStringList.create;

          (LookupTable as TTable).IndexDefs.update;
          for i:= 0 to (LookupTable as TTable).IndexDefs.count-1 do
          begin
             curpos:= 1;
             indexFieldName:= strGetToken((LookupTable as TTable).IndexDefs.Items[i].fields, ';', curpos);
             if (addedList.indexOf(indexFieldName)<0) then begin
                Proc(indexFieldname);
                addedList.add(indexFieldName);
             end
          end;

          addedList.free;
       end
       else begin
          for i:= 0 to LookupTable.FieldCount-1 do
             Proc(LookupTable.Fields[i].FieldName);
       end
    end
end;

Function TwwSearchFieldProperty.GetAttributes: TPropertyAttributes;
begin
   result:= [paValueList, paSortList];
end;

procedure TwwSearchFieldProperty.GetValues(Proc : TGetStrProc);
var
    ds: TDataSource;
    i: integer;
begin
   if GetComponent(0) is TwwLocateDialog then
      ds:= (GetComponent(0) as TwwLocateDialog).dataSource
   else if GetComponent(0) is TwwFilterDialog then
      ds:= (GetComponent(0) as TwwFilterDialog).dataSource
   else exit;

   if (ds<>Nil) and (ds.dataSet<>Nil) then begin
     with ds.DataSet do begin
        for i:= 0 to fieldCount-1 do begin
           if (fields[i].dataType = ftBlob) or (fields[i].dataType=ftGraphic) or
              (fields[i].dataType = ftVarBytes) or (fields[i].dataType=ftBytes) then
              continue;
           Proc(fields[i].FieldName);
        end
     end;
   end
end;

procedure TwwTableProperty.GetValues(Proc : TGetStrProc);
{$ifndef win32}
var
  I,J: Integer;
  ownerComponent, dmComponent, Component: TComponent;
{$endif}
begin
  {$ifdef win32}
  Designer.GetComponentNames(GetTypeData(TypeInfo(TwwTable)), Proc);
  {$else}
  ownerComponent:= ((GetComponent(0) as TComponent).Owner);
  if ownerComponent = nil then exit;

  for I := 0 to ownerComponent.ComponentCount - 1 do
  begin
    Component := ownerComponent.Components[I];
    if (Component is TwwTable) and (Component.Name <> '') then
      Proc(Component.Name);
  end;
  {$endif}
end;

    function TSelectedFieldsProperty.GetValue: string;
    begin
       result := 'wwDBGrid';
    end;

    function TSelectedFieldsProperty.GetAttributes: TPropertyAttributes;
    begin
      result:= [paDialog];
    end;

    procedure TSelectedFieldsProperty.Edit;
    var
      grid       : TwwDBGrid;
      useTFields: boolean;
    begin
       grid:= GetComponent(0) as TwwDBGrid;
       if (grid.dataSource=Nil) then begin
           MessageDlg('Grid requires a DataSource', mtInformation, [mbok], 0);
           exit;
       end;
       if (grid.dataSource.dataset=Nil) then begin { 12/1/98 }
           MessageDlg('Grid requires a DataSet', mtInformation, [mbok], 0);
           exit;
       end;

       useTFields:= grid.useTFields;
       if (EditSelectedFieldsProperty(grid, grid.Selected, grid.dataSource.dataset,
          Designer, True, useTFields, sptNone)) then
       begin
          grid.useTFields:= useTFields;
//          if not useTFields then grid.applyselected;
          grid.redrawGrid;
       end
       else if not useTFields then grid.ApplySelected;
    end;


    procedure TwwDBGridComponentEditor.edit;
    var
      grid       : TwwDBGrid;
      useTFields: boolean;
    begin
       grid:= Component as TwwDBGrid;
       if (grid.dataSource=Nil) then begin
           MessageDlg('Grid requires a DataSource', mtInformation, [mbok], 0);
           exit;
       end;
       if (grid.dataSource.dataset=Nil) then begin { 12/1/98 }
           MessageDlg('Grid requires a DataSet', mtInformation, [mbok], 0);
           exit;
       end;
       useTFields:= grid.useTFields;
       if (EditSelectedFieldsProperty(grid, grid.Selected, grid.dataSource.dataset,
          Designer, True, useTFields, sptNone)) then begin
          grid.useTFields:= useTFields;
          grid.redrawGrid;
       end
       else if not useTFields then grid.ApplySelected;
    end;

    procedure TwwRecordViewPanelComponentEditor.edit;
    var
      ListHandle: TStrings;
      DataSet: TDataSet;
      useTFields: boolean;
    begin
       GetComponentData(Component, listHandle, dataSet);
       if (dataset=Nil) then begin
           MessageDlg('Component requires a DataSourc/DataSet', mtInformation, [mbok], 0);
           exit;
       end;
       useTFields:= False;
       if (EditSelectedFieldsProperty(component, listHandle, DataSet,
          Designer, True, useTFields, sptRecordViewType)) then
          (Component as TwwRecordViewPanel).RecreateControls;
    end;

Function TwwComboItemsProperty.GetAttributes: TPropertyAttributes;
begin
   result:= [paDialog, paMultiSelect];
end;

Function GetItems(Component: TPersistent): TStrings;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(Component.ClassInfo,'Items');
   if PropInfo<>Nil then
      result:= TStrings(GetOrdProp(Component, PropInfo));
end;

procedure TwwComboItemsProperty.Edit;
var MapList: boolean;
    i: integer;

   Function GetMapList(Component: TPersistent): boolean;
   var PropInfo: PPropInfo;
   begin
      result:= false;
      PropInfo:= Typinfo.GetPropInfo(Component.ClassInfo,'MapList');
      if PropInfo<>Nil then
         result:= Boolean(GetOrdProp(Component, PropInfo));
   end;

   Procedure SetMapList(Component: TPersistent; val: boolean);
   var PropInfo: PPropInfo;
   begin
      PropInfo:= Typinfo.GetPropInfo(Component.ClassInfo,'MapList');
      if PropInfo<>Nil then
         SetOrdProp(Component, PropInfo, ord(val));
   end;

begin
   MapList:= GetMapList(GetComponent(0));
   if wwEditComboList(GetItems(GetComponent(0)), MapList) then
   begin
      SetMapList(GetComponent(0), MapList); // 11/19/99 - Fix bug in not updating maplist property
      for i:= 1 to PropCount-1 do  {8/23/96 - Change all selected controls }
      begin
          GetItems(GetComponent(i)).assign(GetItems(GetComponent(0)));
          SetMapList(GetComponent(i), MapList);
      end;
//      SetMapList(GetComponent(0), MapList);
      Designer.modified;
   end;
end;

Function TwwComboItemsProperty.GetValue: string;
begin
   result:= '<' + inttostr(GetItems(GetComponent(0)).count) + ' Items>';
end;

function TwwPictureProperty.GetValue: string;
begin
   with (GetComponent(0) as TwwCustomMaskEdit) do begin
      result:= Picture.PictureMask;
   end;
end;

Procedure TwwPictureProperty.Edit;
var component: TwwCustomMaskEdit;
    i: integer;
begin
   component:= GetComponent(0) as TwwCustomMaskEdit;
   if wwPrpEdit_PictureMask2(component) then
   begin
      for i:= 1 to PropCount-1 do  {8/23/96 - Change all selected controls }
      begin
          with GetComponent(i) as TwwCustomMaskEdit do begin
             Picture.PictureMask:= component.Picture.PictureMask;
             Picture.AutoFill:= component.Picture.AutoFill;
             Picture.AllowInvalidExit:= component.Picture.AllowInvalidExit;
             UsePictureMask:= component.UsePictureMask;
          end
      end;

      Designer.modified;
   end
end;

function TwwPictureProperty.GetAttributes: TPropertyAttributes;
begin
   Result:= [paMultiSelect, paSubProperties, paReadOnly, paDialog];
end;

Procedure TwwPicturePropertyGen.Edit;
var component: TCustomEdit;
begin
   component:= GetComponent(0) as TCustomEdit;
   if wwPrpEdit_PictureMaskGen(component) then
   begin
      Designer.modified;
   end
end;

function TwwPicturePropertyGen.GetAttributes: TPropertyAttributes;
begin
   Result:= [paDialog];
end;

function TwwPicturePropertyGen.GetValue: string;
begin
   result:= wwGetControlPictureMask(GetComponent(0) as TCustomEdit);
end;

procedure Register;
begin
{
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwDBLookupList, '', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwDBLookupCombo, '', TwwDBLookupDisplayProperty);
  RegisterComponentEditor(TwwDBLookupList, TwwDBLookupDisplayComponentEditor);
  RegisterComponentEditor(TwwDBLookupCombo, TwwDBLookupDisplayComponentEditor);
}
end;

Procedure TwwFilterFieldsProperty.Edit;
var
   listHandle : TStrings;
   component: TwwFilterDialog;
begin
   component:= GetComponent(0) as TwwFilterDialog;
   if (component.dataSource=Nil) then begin
      MessageDlg('Missing Datasource Property', mtInformation, [mbok], 0);
      exit;
   end;

   listHandle:= component.SelectedFields;

   if wwSelectFilterableFields(component, listHandle) then
   begin
      Designer.modified;
   end;

end;

Function TwwFilterfieldsProperty.GetAttributes: TPropertyAttributes;
begin
   result:= [paDialog];
end;

Function TwwFilterFieldsProperty.GetValue: string;
begin
   result:= '<TStringList>'
end;

procedure TwwRecordViewComponentEditor.edit;
begin
   (Component as TwwRecordViewDialog).execute;
end;

{procedure TwwDataInspectorComponentEditor.edit;
var
   ListHandle: TStrings;
   DataSet: TDataSet;
   useTFields: boolean;
begin
    GetComponentData(Component, listHandle, dataSet);
    if (dataset=Nil) then begin
        MessageDlg('Component requires a DataSourc/DataSet', mtInformation, [mbok], 0);
        exit;
    end;
    useTFields:= False;
    if (EditSelectedFieldsProperty(component, listHandle, DataSet,
        Designer, True, useTFields, sptObjectViewType)) then
    begin
         (Component as TwwDataInspector).ApplySettings;
    end
end;
}

{$ifdef win32}
Procedure TwwRichEditItemsProperty.Edit;
var richedit: TwwCustomRichEdit;
    prevoptions: TwwRichEditOptions;
begin
   richedit:= GetComponent(0) as TwwCustomRichEdit;
   prevOptions:= richedit.editoroptions;
   richedit.editoroptions:= richedit.editoroptions + [reoShowLoad];
   if richedit.execute then Designer.modified;
   richedit.editoroptions:= prevOptions;
end;

function TwwRichEditItemsProperty.GetAttributes: TPropertyAttributes;
begin
   result:= [paDialog]
end;

function TwwRichEditItemsProperty.GetValue: string;
begin
   result:= '<TStringList>'
end;

procedure TwwRichEditComponentEditor.edit;
var richedit: TwwCustomRichEdit;
    prevoptions: TwwRichEditOptions;
begin
    richedit:= (Component as TwwCustomRichEdit);
    prevOptions:= richedit.editoroptions;
    richedit.editoroptions:= richedit.editoroptions + [reoShowLoad];
    if (Component as TwwCustomRichEdit).execute then
       Designer.modified;
    richedit.editoroptions:= prevOptions;
end;

{$endif}

{$ifdef wwDelphi3Up}
function TwwIndexDefsProperty.GetAttributes: TPropertyAttributes;
begin
   Result:= [paReadOnly];
end;

function TwwIndexDefsProperty.GetValue: string;
begin
   Result:= '<InfoPower use only>'
end;
{$endif}

function TwwObjPictureProperty.GetValue: string;
begin
   with (GetComponent(0) as TwwInspectorItem) do
      result:= Picture.PictureMask;
end;

Procedure TwwObjPictureProperty.Edit;
var component: TwwInspectorItem;
    i: integer;
begin
   component:= GetComponent(0) as TwwInspectorItem;
   {$ifdef wwDelphi6Up}
   if wwPrpEdit_PictureMask3(component.Picture, Designer.Root as TWinControl) then
   {$else}
   if wwPrpEdit_PictureMask3(component.Picture, Designer.Form) then
   {$endif}

   begin
      for i:= 1 to PropCount-1 do  {8/23/96 - Change all selected controls }
      begin
          with GetComponent(i) as TwwInspectorItem do begin
             Picture.PictureMask:= component.Picture.PictureMask;
             Picture.AutoFill:= component.Picture.AutoFill;
             Picture.AllowInvalidExit:= component.Picture.AllowInvalidExit;
//             UsePictureMask:= component.UsePictureMask;
          end
      end;

      Designer.modified;
   end
end;

function TwwObjPictureProperty.GetAttributes: TPropertyAttributes;
begin
   Result:= [paMultiSelect, paSubProperties, paReadOnly, paDialog];
end;

Procedure TwwMultiLineStringProperty.SetValue(const value: string);
var PropInfo: PPropInfo;
begin
   PropInfo:= GetPropInfo;
   SetStrProp(GetComponent(0), PropInfo, value);
end;

function TwwMultiLineStringProperty.GetValue: string;
var PropInfo: PPropInfo;
begin
   PropInfo:= GetPropInfo;
   result:= GetStrProp(GetComponent(0), PropInfo);
end;

Procedure TwwMultiLineStringProperty.Edit;
var PropInfo: PPropInfo;
    memoDialog: TwwMemoDialog;
    s: string;
    i: integer;
begin
   PropInfo:= GetPropInfo;
   if PropInfo=nil then exit;
   memoDialog:= TwwMemoDialog.create(nil);

   s:= GetStrProp(GetComponent(0), PropInfo);
   s:= strRemoveChar(s, #10);
   strBreakApart(s, #13, memodialog.lines);

   if memoDialog.execute then
   begin
      s:= '';
      for i:= 0 to MemoDialog.lines.count-1 do
      begin
         if i>0 then s:= s + #13;
         s:= s + memodialog.lines[i];
      end;
      SetStrProp(GetComponent(0), PropInfo, s);
      Designer.modified;
   end;
   memodialog.free;
end;

function TwwMultiLineStringProperty.GetAttributes: TPropertyAttributes;
begin
   Result:= [paDialog];
end;

function TwwComponentEditor.GetVerbCount: Integer;
begin
  result := 1;
end;

function TwwComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then result := '&About InfoPower 3000';
end;

procedure TwwComponentEditor.ShowAboutBox;
var ipReg: TRegIniFile;
    ARegNumber: string;
begin
  ipreg := TRegIniFile.create('');
  ARegNumber := ipreg.ReadString('\Software\Woll2Woll\InfoPower', 'Reg. No.', '');
  ipreg.Free;
  with TIPAboutForm.create(nil) do begin
    AVersion:= 'Version: ' + wwInternational.VersionInfoPower;
    ARegistration:= 'Reg. No.: ' + ARegNumber;
    ShowModal;
    Free;
  end;
end;

procedure TwwComponentEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then ShowAboutBox;
end;

function TwwGridComponentEditor.GetVerbCount: Integer;
begin
   if SupportIniSave then
   begin
      result:= inherited GetVerbCount + 2;
   end
   else result:= inherited GetVerbCount + 1;
end;

function TwwGridComponentEditor.GetVerb(Index: Integer): string;
begin
  result:= inherited GetVerb(Index);
  if SupportIniSave then
  begin
     if Index = GetVerbCount - 1 then result := '&Clear Custom Control Information'
     else if (Index = GetVerbCount - 2) then result := '&Save settings to INI file';
  end
  else if Index = GetVerbCount - 1 then result := '&Clear Custom Control Information'
end;

procedure TwwGridComponentEditor.ExecuteVerb(Index: Integer);
  procedure ClearControls;
  begin
      wwClearControls(Component);
  end;
begin
  if SupportIniSave then
  begin
      if (Index = GetVerbCount - 2) and (Component is TwwDBGrid) then
         TwwDBGrid(Component).SaveToIniFile
      else if Index = GetVerbCount - 1 then
      begin
         ClearControls;
         if Component is TwwDBGrid then TwwDBgrid(Component).RefreshDisplay
      end
  end
  else if Index = GetVerbCount - 1 then
  begin
         ClearControls;
         if Component is TwwDBGrid then TwwDBgrid(Component).RefreshDisplay
  end
  else inherited ExecuteVerb(Index)
end;

Function TwwGridComponentEditor.SupportIniSave: boolean;
begin
  result:= False;
//  if (Component is TwwDBGrid) and TwwDBgrid(Component).IniAttributes.Enabled then
end;

end.
