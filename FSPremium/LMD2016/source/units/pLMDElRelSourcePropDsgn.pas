unit pLMDElRelSourcePropDsgn;
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

pLMDElRelSourcePropDsgn unit
----------------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses

  Windows,
  Messages,
  Graphics,
  Controls,
  DBCtrls,
  Dialogs,

  SysUtils,
  Classes,
  Db,
  TypInfo,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  LMDElDBConst,
  ElDBTree;

type
// TElFieldProperty

  TElDataFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
  end;

// property editors for RelationItem

  TElMasterFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
    function GetValue: string; override;
  end;

  TElDetailFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
  end;

  TElDetailDisplayFieldProperty = class(TStringProperty)
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc ) ; override;
    procedure SetValue(const Value: string); override;
  end;

implementation

// property editors for RelationItem

function TElMasterFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElMasterFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if (TElRelationsItem(GetComponent(0)).MasterDataSet<>nil) then
    for i := 0 to TElRelationsItem(GetComponent(0)).MasterDataSet.FieldCount-1 do
      begin
        Proc(TElRelationsItem(GetComponent(0)).MasterDataSet.Fields[i].FieldName);
      end;
end;

function TElMasterFieldProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

//watch the correct links MasterField-DetailField if the type doesn't match 
//notify user about possible problems. 
//don't take punitive measures, because while constructing we 
//will try to cast to one type 

procedure TElMasterFieldProperty.SetValue(const Value: string);
var m,d : TFieldType;
begin
  if (TElRelationsItem(GetComponent(0)).DetailDataSet<>nil)  and (TElRelationsItem(GetComponent(0)).DetailField<>'') then
    begin
      m := TElRelationsItem(GetComponent(0)).MasterDataSet.FieldByName(Value).DataType;
      d := TElRelationsItem(GetComponent(0)).DetailDataSet.FieldByName(TElRelationsItem(GetComponent(0)).DetailField).DataType;
      if m <> d then ShowMessage(SMasterDetailIncompatible);
    end;
  inherited SetValue(value);
//  (TElRelationsItem(GetComponent(0)).Collection as TElRelations).ElRelDataSource.NotifyLinks(elSetModify,0);
end;

function TElDetailFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElDetailFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if TElRelationsItem(GetComponent(0)).DetailDataSet<>nil then
    for i := 0 to TElRelationsItem(GetComponent(0)).DetailDataSet.FieldCount-1 do
      begin
        Proc(TElRelationsItem(GetComponent(0)).DetailDataSet.Fields[i].FieldName);
      end;
end;

//watch the correct links MasterField-DetailField if the type doesn't match
//notify user about possible problems. 
//don't take punitive measures, because while constructing we will try to 
//cast to one type 

procedure TElDetailFieldProperty.SetValue(const Value: string);
var m,d : TFieldType;
begin
  if (TElRelationsItem(GetComponent(0)).MasterDataSet<>nil)  and (TElRelationsItem(GetComponent(0)).MasterField<>'') then
    begin
      m := TElRelationsItem(GetComponent(0)).MasterDataSet.FieldByName(TElRelationsItem(GetComponent(0)).MasterField).DataType;
      d := TElRelationsItem(GetComponent(0)).DetailDataSet.FieldByName(Value).DataType;
      if m <> d then ShowMessage(SMasterDetailIncompatible);
    end;
  inherited SetValue(value);
//  (TElRelationsItem(GetComponent(0)).Collection as TElRelations).ElRelDataSource.NotifyLinks(elSetModify,0);
end;

function TElDetailDisplayFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElDetailDisplayFieldProperty.SetValue(const Value: string) ;
begin
  inherited SetValue(value);
//  (TElRelationsItem(GetComponent(0)).Collection as TElRelations).ElRelDataSource.NotifyLinks(elSetModify,0);
end;

procedure TElDetailDisplayFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if TElRelationsItem(GetComponent(0)).DetailDataSet<>nil then
    for i := 0 to TElRelationsItem(GetComponent(0)).DetailDataSet.FieldCount-1 do
      begin
        Proc(TElRelationsItem(GetComponent(0)).DetailDataSet.Fields[i].FieldName);
      end;
end;
// TElDataFieldProperty

function TElDataFieldProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TElDataFieldProperty.GetValues( Proc : TGetStrProc ) ;
var i : integer;
begin
  if TElRelDataSource(GetComponent(0)).DataSet<>nil then
    for i := 0 to TElRelDataSource(GetComponent(0)).DataSet.FieldCount-1 do
      begin
        Proc(TElRelDataSource(GetComponent(0)).DataSet.Fields[i].FieldName);
      end;
end;

procedure TElDataFieldProperty.SetValue(const Value: string);
begin
  inherited SetValue(Value);
//  TElRelDataSource(GetComponent(0)).NotifyLinks(elSetModify,0);
end;

end.
