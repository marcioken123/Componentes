unit wwInspectorPrpEdt;
{
//
// Components : Inspector design-time support
//
// Copyright (c) 1999-2001 by Woll2Woll Software
//
}
{$i wwIfDef.pas}

interface

Uses controls,
       {$ifdef wwdelphi6up}
       designintf, designeditors,
       {$else}
       dsgnintf,
       {$endif}
     classes, dialogs,
     wwdatainspector, wwInspectorProp, db, dbtables, wwprpcom, wwprpedt;

type
  TwwObjectViewComponentEditor = class(TwwComponentEditor)
     procedure Edit; override;
  end;

  TwwInspectorItemsProperty = class(TStringProperty)
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;

  TwwCustomEditPropertyEditor = class(TComponentProperty)
     procedure GetValues(Proc : TGetStrProc); override;
     procedure wwGetStrProc(const s: string);
  end;

  TwwDataFieldEditor = class(TStringProperty)
     function GetAttributes: TPropertyAttributes; override;
     procedure GetValues(Proc : TGetStrProc); override;
  end;

{  TwwObjComboItemsProperty = class(TPropertyEditor)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;
}
  TwwInspectorCollectionEditor = class(TPropertyEditor)
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
     function GetValue: string; override;
  end;


implementation

uses wwcommon,typinfo;

function TwwInspectorItemsProperty.GetAttributes: TPropertyAttributes;
begin
   Result:= [paReadOnly];
end;

function TwwInspectorItemsProperty.GetValue: string;
begin
   Result:= '<InfoPower use only>'
end;

{Function wwSupportsInfoPower(ctrl: TComponent): boolean;
var PropInfo: PPropInfo;
begin
   if ctrl=nil then result:= false
   else if wwIsClass(ctrl.classType, 'TwwDBCustomEdit') then result:= True
   else if wwIsClass(ctrl.classType, 'TwwDBCustomLookupCombo') then result:= True
   else if wwIsClass(ctrl.classType, 'TwwDBRichEdit') then result:= True
   else if wwIsClass(ctrl.classType, 'TCustomEdit') then
//   else if Ctrl.InheritsFrom(TCustomEdit) then
   begin
      PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'InfoPower');
      result:= PropInfo<>Nil;
   end
   else result:= False;
end;
}
procedure TwwObjectViewComponentEditor.edit;
var edit: TwwDataInspector;
begin
   edit:= (Component as TwwDataInspector);
   if ExecuteInspectorEditor(Designer, {Designer.Root,} edit) then
       Designer.modified;
end;

{ TCustomEditPropertyEditor }
type PGetStrProc = ^TGetStrProc;
var MyProc: TGetStrProc;

procedure TwwCustomEditPropertyEditor.wwGetStrProc(const s: string);
var Component: TComponent;
begin
  component:= Designer.GetComponent(s);
  if (pos('.', Designer.GetComponentName(Component))=0) and
     (Component is TWinControl) then
  begin
//     wwSupportsInfoPower(Component) then
     MyProc(s);
  end
end;

procedure TwwCustomEditPropertyEditor.GetValues(Proc : TGetStrProc);
begin
  MyProc:= Proc;
  Designer.GetComponentNames(GetTypeData(TypeInfo(TComponent)), wwGetStrProc);
end;

Function TwwDataFieldEditor.GetAttributes: TPropertyAttributes;
begin
   result:= [paValueList, paSortList];
end;

procedure TwwDataFieldEditor.GetValues(Proc : TGetStrProc);
var
    ds: TDataSource;
    i: integer;
begin
//   ds:= TwwDataInspector((GetComponent(0) as TwwInspectorItem).Control).dataSource;
   ds:= (GetComponent(0) as TwwInspectorItem).datasource;

   if (ds<>Nil) and (ds.dataSet<>Nil) then begin
     with ds.DataSet do begin
        for i:= 0 to fieldCount-1 do begin
           if {(fields[i].dataType=ftGraphic) or}
              (fields[i].dataType = ftVarBytes) or (fields[i].dataType=ftBytes) then
              continue;
           Proc(fields[i].FieldName);
        end
     end;
   end
end;

{Function TwwObjComboItemsProperty.GetAttributes: TPropertyAttributes;
begin
   result:= [paDialog]
end;

procedure TwwObjComboItemsProperty.Edit;
var Combo: TwwInspectorCollectionEditorItem;
    MapList: boolean;
begin
   Combo:= GetComponent(0) as TwwInspectorCollectionEditorItem;
   MapList:= Combo.PickList.Mapped;

   if wwEditComboList(Combo.PickList.Items, MapList) then
   begin
      Combo.PickList.Mapped:= MapList;
      Designer.modified;
   end;
end;

Function TwwObjComboItemsProperty.GetValue: string;
begin
   result:= '<Items>';
end;
}
Function TwwInspectorCollectionEditor.GetAttributes: TPropertyAttributes;
begin
   if GetComponent(0) is TwwDataInspector then
      result:= [paDialog]
   else
      result:= [paReadOnly]
end;

procedure TwwInspectorCollectionEditor.Edit;
var Edit: TwwDataInspector;
    c: TPersistent;
begin
  c:= GetComponent(0);
  if c is TwwDataInspector then
  begin
   edit:= TwwDataInspector(c);
   if ExecuteInspectorEditor(Designer,{ Designer.Form, }edit) then
       Designer.modified;
  end
  else if c is TwwInspectorItem then
  begin
  end
end;

Function TwwInspectorCollectionEditor.GetValue: string;
begin
   result:= '<Items>';
end;



end.
