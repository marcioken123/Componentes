unit pLMDElXRelSourcePropDsgn;
{$I lmdcmps.inc}
{
  ##############################################################################
  # Author:             LMD Innovative (EK, AH)
  # Created:            05/05/2005
  # Description:
  # State:              release
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Db,
  DBCtrls,
  TypInfo,
  Dialogs,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  LMDElDBConst,
  ElDBXTree;

type
// TElFieldProperty

  TElXDataFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
  end;

// редакторы св-в  для RelationItem

  TElXMasterFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
    function GetValue: string; override;
  end;

  TElXDetailFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
  end;

  TElXDetailDisplayFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
  end;

implementation

// редакторы св-в для RelationItem

function TElXMasterFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElXMasterFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if (TElXRelationsItem(GetComponent(0)).MasterDataSet<>nil) then
    for i := 0 to TElXRelationsItem(GetComponent(0)).MasterDataSet.FieldCount-1 do
      begin
        Proc(TElXRelationsItem(GetComponent(0)).MasterDataSet.Fields[i].FieldName);
      end;
end;

function TElXMasterFieldProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

// следим за корректными связками MasterField-DetailField при несовпадении типа
// предупреждаем пользователя о возможных проблемах.
//   карательные меры не применяем т.к. при построении будем пытаться привести их к одному типу
procedure TElXMasterFieldProperty.SetValue(const Value: string);
var m,d : TFieldType;
begin
  if (TElXRelationsItem(GetComponent(0)).DetailDataSet<>nil)  and (TElXRelationsItem(GetComponent(0)).DetailField<>'') then
    begin
      m := TElXRelationsItem(GetComponent(0)).MasterDataSet.FieldByName(Value).DataType;
      d := TElXRelationsItem(GetComponent(0)).DetailDataSet.FieldByName(TElXRelationsItem(GetComponent(0)).DetailField).DataType;
      if m <> d then ShowMessage(SMasterDetailIncompatible);
    end;
  inherited SetValue(value);
//  (TElXRelationsItem(GetComponent(0)).Collection as TElXRelations).ElRelDataSource.NotifyLinks(elSetModify,0);
end;

function TElXDetailFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElXDetailFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if TElXRelationsItem(GetComponent(0)).DetailDataSet<>nil then
    for i := 0 to TElXRelationsItem(GetComponent(0)).DetailDataSet.FieldCount-1 do
      begin
        Proc(TElXRelationsItem(GetComponent(0)).DetailDataSet.Fields[i].FieldName);
      end;
end;

// следим за корректными связками MasterField-DetailField при несовпадении типа
// предупреждаем пользователя о возможных проблемах.
//   карательные меры не применяем т.к. при построении будем пытаться привести их к одному типу
procedure TElXDetailFieldProperty.SetValue(const Value: string);
var m,d : TFieldType;
begin
  if (TElXRelationsItem(GetComponent(0)).MasterDataSet<>nil)  and (TElXRelationsItem(GetComponent(0)).MasterField<>'') then
    begin
      m := TElXRelationsItem(GetComponent(0)).MasterDataSet.FieldByName(TElXRelationsItem(GetComponent(0)).MasterField).DataType;
      d := TElXRelationsItem(GetComponent(0)).DetailDataSet.FieldByName(Value).DataType;
      if m <> d then ShowMessage(SMasterDetailIncompatible);
    end;
  inherited SetValue(value);
//  (TElXRelationsItem(GetComponent(0)).Collection as TElXRelations).ElRelDataSource.NotifyLinks(elSetModify,0);
end;

function TElXDetailDisplayFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElXDetailDisplayFieldProperty.SetValue(const Value: string) ;
begin
  inherited SetValue(value);
//  (TElXRelationsItem(GetComponent(0)).Collection as TElXRelations).ElRelDataSource.NotifyLinks(elSetModify,0);
end;

procedure TElXDetailDisplayFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if TElXRelationsItem(GetComponent(0)).DetailDataSet<>nil then
    for i := 0 to TElXRelationsItem(GetComponent(0)).DetailDataSet.FieldCount-1 do
      begin
        Proc(TElXRelationsItem(GetComponent(0)).DetailDataSet.Fields[i].FieldName);
      end;
end;
// TElXDataFieldProperty

function TElXDataFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElXDataFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if TElXRelDataSource(GetComponent(0)).DataSet<>nil then
    for i := 0 to TElXRelDataSource(GetComponent(0)).DataSet.FieldCount-1 do
      begin
        Proc(TElXRelDataSource(GetComponent(0)).DataSet.Fields[i].FieldName);
      end;
end;

procedure TElXDataFieldProperty.SetValue(const Value: string);
begin
  inherited SetValue(Value);
//  TElXRelDataSource(GetComponent(0)).NotifyLinks(elSetModify,0);
end;

end.
