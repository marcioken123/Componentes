{
//
// Components : TwwProvider - Used by TwwFilterDialog
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
}
unit wwProvider;

interface

{$i wwIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Provider,
  {$ifndef wwDelphi5Up}
  BdeProv,
  {$endif}
  {$ifdef wwDelphi6Up}
  Variants,
  {$endif}
  wwcommon, dbtables, db;

type
  TwwProvider = class(TProvider)
  public
    function DataRequest(Input: OleVariant): OleVariant; override;
  end;

implementation

uses typinfo;

function TwwProvider.DataRequest(Input: OleVariant): OleVariant;
const dbl='"';
      single='''';
var apos, i, j: integer;
    s: string;
    sql: TStrings;
    PropInfo: PPropInfo;
    querySQL: TStrings;
    line, word: string;
    tempDataSet, table: TTable;
    TempFldList, TempAllFldList: TStrings;
    TableName, TableAlias, PhysFieldName, LogicalFieldName, DisplayLabel,
    FieldType, Key: string;
    TempField: TField;
    FieldDef: TFieldDef;
    FieldSize: string;

   Function ComputeFieldName(TempFldName: wwSmallString): string;
   begin
       result:= TempFldName;
   end;

begin
   try
      if Input[0]='w2wGetSQL' then begin
         PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'Sql');
         if PropInfo<>Nil then sql:= TStrings(GetOrdProp(DataSet, PropInfo))
         else exit;

         with sql do
         begin
            for i:= 0 to sql.count-1 do begin
               s:= s + sql[i];
               if i<sql.count-1 then s:= s + #13;
            end
         end;
         result:= s;
         exit;
      end
      else if Input[0]='w2wGetFieldInfo' then begin
          if Dataset=Nil then exit;

          PropInfo:= Typinfo.GetPropInfo(Dataset.ClassInfo,'Sql');
          if PropInfo<>Nil then querysql:= TStrings(GetOrdProp(DataSet, PropInfo))
          else exit;

          for i:= 0 to querysql.count-1 do begin
            line:= uppercase(querysql[i]);
            APos:= 1;
            repeat
               word:= wwGetSQLWord(line, APos);
            until (word='FROM') or (word='');
            if word='FROM' then break;
          end;

          table:= TTable.create(Nil);
          tempDataSet:= table;

          TempFldList:= TStringList.create;
          TempAllFldList:= TStringList.create;

          if word='FROM' then begin
            repeat
               repeat { Get Next table in From list }
                  TableName:= wwGetSQLWord(line, APos);
                  if TableName='' then begin
                     if (i>=querysql.count-1) then break;
                     inc(i);
                     line:=uppercase(querysql[i]);
                     APos:= 1;
                  end
               until TableName<>'';

               if (TableName[1]=Dbl) or (TableName[1]=Single) then
               begin
                  TableName:= copy(TableName, 2, length(TableName)-2);
                  TableAlias:= wwGetSQLWord(line, APos);
               end
               else begin
                  TableAlias:= TableName;
               end;

               table.databaseName:= wwGetDatabaseName(dataset);
               table.sessionName:= wwGetSessionName(dataset);
               table.tableName:= tableName;
               table.readOnly:= True;
               table.GetFieldNames(TempFldList);

               for j:= 0 to TempFldList.Count-1 do begin
                  PhysFieldName:= TempFldList[j];
                  TempFldList[j]:= ComputeFieldName(TempFldList[j]);
                  LogicalFieldName:= TempFldList[j];
                  TableName:= TableAlias;

                  FieldDef:= tempDataSet.FieldDefs.Find(PhysFieldName);
                  if FieldDef<>nil then begin
                     FieldType:= GetEnumName(TypeInfo(TFieldType), Integer(FieldDef.DataType));
                     FieldSize:= inttostr(FieldDef.size);
                  end
                  else begin
                     FieldType:= '';
                     FieldSize:= '0';
                  end;

                  tempField:=tempDataSet.FindField(PhysFieldName);
                  if tempField=nil then begin  { If field not found check query's fields }
                     tempField:= dataset.FindField(PhysFieldName);
                     if tempField=nil then DisplayLabel:= PhysFieldName
                     else DisplayLabel:= tempField.DisplayLabel;
                  end
                  else DisplayLabel:= tempField.DisplayLabel;
                  Key:= PhysFieldName + ';' + LogicalFieldname + ';' +
                        TableName + ';' + DisplayLabel + ';' + FieldType + FieldSize;
                  if (TempAllFldList.indexOf(key)<0) then TempAllFldList.add(key)
               end;

               if wwGetSQLWord(line, APos)<>',' then break;
            until False;

            with TempAllFldList do
            begin
               for i:= 0 to TempAllFldList.count-1 do begin
                  s:= s + TempAllFldList[i];
                  if i<TempAllFldList.count-1 then s:= s + #13;
               end
            end;
            result:= s;
{
            returnOLE:= VarArrayCreate([0, TempAllFldList.count], varVariant);
            for i:= 0 to TempAllFldList.count-1 do begin
               returnOLE[i]:= TempAllFldList[i];
            end;
            result:= returnOLE;}
         end;

         tempDataSet.Free;
         tempFldList.Free;
         tempAllFldList.Free;
         exit;
      end
      else if Input[0]='w2wSetSQL' then begin
          PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo,'Sql');
          if PropInfo<>Nil then sql:= TStrings(GetOrdProp(DataSet, PropInfo))
          else exit;

          sql.clear;
          for i:= VarArrayLowBound(Input, 1)+1 to
                  VarArrayHighBound(Input, 1) do
          begin
              sql.add(Input[i]);
          end;
          exit;
      end;

   except
   end;

   result:= inherited DataRequest(Input);

end;

end.
