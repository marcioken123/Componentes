unit wwclient;
{
//
// Components : TwwClientDataSet
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
}

interface

{$i wwIfDef.pas}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, DB, DBTables, dialogs, wwfilter, wwStr,
  wwSystem, wwTable, wwtypes, dbclient,
{$IFDEF WIN32}
bde
{$ELSE}
dbiprocs, dbiTypes, dbierrs
{$ENDIF}
;

type
  TwwClientDataSet = class;
  TwwClientDataSetFilterEvent = Procedure(ClientDataSet: TwwClientDataSet; var Accept: boolean) of object;

  TwwClientDataSet = class(TClientDataSet)
  private
     FControlType: TStrings;
     FPictureMasks: TStrings;
     FUsePictureMask: boolean;

     FOnInvalidValue: TwwInvalidValueEvent;
     FOnFilter: TFilterRecordEvent;
     FFilterFieldBuffer: PChar;
     FFilterParam: TParam;
     FRemoteSQL: TStrings;
     FFieldList: TStrings;
     procedure SetOnFilter(val: TFilterRecordEvent);

     function GetControlType: TStrings;
     procedure SetControlType(sel : TStrings);
     function GetPictureMasks: TStrings;
     procedure SetPictureMasks(sel : TStrings);
//     Function GetRemoteSQL: TStrings;
//     Procedure SetRemoteSQL(val: TStrings);
     Function GetFieldInfo: TStrings;

  protected
     procedure DoBeforePost; override; { For picture support }

  public
    InFilterEvent: boolean;    {Woll2Woll Internal use only}

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Function wwFilterField(AFieldName: string): TParam;

    {$ifdef wwDelphi3Up}
    function IsSequenced: Boolean; override;
    {$endif}

  published
    property ControlType : TStrings read getControlType write setControltype;
    property PictureMasks: TStrings read GetPictureMasks write SetPictureMasks;
    property ValidateWithMask: boolean read FUsePictureMask write FUsePictureMask;
    property OnFilter: TFilterRecordEvent read FOnFilter write SetOnFilter;
    property OnInvalidValue: TwwInvalidValueEvent read FOnInvalidValue write FOnInvalidValue;
//    property SQL: TStrings read GetRemoteSQL write SetRemoteSQL stored False;
    property FieldInfo: TStrings read GetFieldInfo stored False;
  end;


implementation


   uses wwcommon, dbconsts;

    constructor TwwClientDataSet.create(AOwner: TComponent);
    begin
      inherited Create(AOwner);
      FControlType:= TStringList.create;
      FPictureMasks:= TStringList.create;

      GetMem(FFilterFieldBuffer, 256);
      FFilterParam:= TParam.create(nil, ptUnknown);
      FUsePictureMask:= True;
      FRemoteSQL:= TStringList.create;
      FFieldList:= TStringList.create;

    end;

    destructor TwwClientDataSet.Destroy;
    begin
      FControlType.Free;
      FPictureMasks.Free;
      FPictureMasks:= Nil;
      FRemoteSQL.Free;
      FRemoteSQL:= Nil;
      FFieldList.Free;
      FFieldList:= nil;

      FreeMem(FFilterFieldBuffer, 256);
      FFilterParam.Free;

      inherited Destroy;
    end;


    function TwwClientDataSet.GetControltype: TStrings;
    begin
         Result:= FControlType;
    end;

    procedure TwwClientDataSet.SetControlType(sel : TStrings);
    begin
       FControlType.assign(sel);
    end;

    function TwwClientDataSet.GetPictureMasks: TStrings;
    begin
       Result:= FPictureMasks
    end;

    procedure TwwClientDataSet.SetPictureMasks(sel : TStrings);
    begin
         FPictureMasks.assign(sel);
    end;


  procedure TwwClientDataSet.SetOnFilter(val: TFilterRecordEvent);
  begin
     OnFilterRecord:= val;
  end;


Function TwwClientDataSet.wwFilterField(AFieldName: string): TParam;
var curField, OtherField: TField;
   method: TMethod;
begin
   curField:= findField(AFieldName);
   if curField=Nil then begin
     {$ifdef wwDelphi3Up}
      DatabaseErrorFmt(SFieldNotFound, [AFieldName, AFieldName]);
     {$else}
      DBErrorFmt(SFieldNotFound, [AFieldName]);
     {$endif}
      result:= FFilterParam;
      exit;
   end;

   if not wwisNonPhysicalField(curfield) then begin
      FFilterParam.DataType:= curField.DataType;
      wwConvertFieldToParam(curField, FFilterParam, FFilterFieldBuffer);
   end
   else begin  {This is a lookup or a calculated field so get Lookup field value}
      method.data:= self;
      method.code:= @TwwClientDataset.wwFilterField;
      OtherField := wwDataSet_GetFilterLookupField(Self, curfield, method);

      if OtherField <> nil then begin
        FFilterParam.DataType:= OtherField.DataType;
        wwConvertFieldToParam(OtherField, FFilterParam, FFilterFieldBuffer);
      end;

   end;

   result:= FFilterParam;
end;

procedure TwwClientDataSet.DoBeforePost;
begin
  inherited DoBeforePost;
  if FUsePictureMask then
     wwValidatePictureFields(self, FOnInvalidValue);
end;

Function TwwClientDataSet.GetFieldInfo: TStrings;
//var sqlString: string;
begin
    if csDesigning in ComponentState then begin
       result:= nil;
       exit;
    end;
//    sqlString:= provider.DataRequest(VarArrayOf(['w2wGetFieldInfo']));
//    strBreakApart(sqlString, #13, FFieldList);
    result:= FFieldList;
end;

{Function TwwClientDataSet.GetRemoteSQL: TStrings;
var sqlString: string;
begin
    if csDesigning in ComponentState then begin
       result:= nil;
       exit;
    end;
    sqlString:= provider.DataRequest(VarArrayOf(['w2wGetSQL']));
    strBreakApart(sqlString, #13, FRemoteSQL);
    result:= FRemoteSQL;
end;

Procedure TwwClientDataSet.SetRemoteSQL(val: TStrings);
var i: integer;
    tempSQL: OLEVariant;
begin
    if csDesigning in ComponentState then begin
       exit;
    end;
    tempsql:= VarArrayCreate([0, val.count], varVariant);
    tempsql[0]:= 'w2wSetSQL';
    for i:= 0 to val.count-1 do begin
       tempsql[i+1]:= val[i];
    end;
    provider.DataRequest(tempSQL);
end;
}
function TwwClientDataSet.IsSequenced: Boolean;
begin
  result:= inherited isSequenced;
  if result then begin
     if Assigned(FOnFilter) then result:= False;
  end
end;



end.
