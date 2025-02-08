unit LMDLogDBSession;
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

LMDLogDBSession unit (AH, AIH)
------------------------------
Log system that can help monitoring actions of application without debugger.
Helper class for logging DB datasets

Changes
-------
Release 1.0 (1st quarter 2008)
 - Standalone release

###############################################################################}

interface

uses
  Classes, SysUtils, TypInfo, DB, LMDUnicode, LMDLogMessage, LMDStrings, LMDIniCtrl;

type
  TLMDLogDBSession = class(TLMDLogCustomSession)
  public
    class function GetName: WideString; override;
    procedure SendDataSet(ALogLevel: TLMDLogLevel; AName: String; ADataSet: TDataSet);overload;
    procedure SendDataSet(AName: String; ADataSet: TDataSet);overload;
    procedure SendDataSetStructure(ALogLevel: TLMDLogLevel; AName: String; ADataSet: TDataSet);overload;
    procedure SendDataSetStructure(AName: String; ADataSet: TDataSet);overload;
  end;

implementation

{ ---------------------------------------------------------------------------- }
procedure TLMDLogDBSession.SendDataSet(ALogLevel: TLMDLogLevel; AName: String; ADataSet: TDataSet);
var
  SafeRecNo, i: Integer;
  LResult: TStringList;
  LStr: String;

const
  LSeparator = ',';

  function AddSlashes(const AStr: String): String;
  begin
    Result := LMDReplaceStr(AStr, '"', '""')
  end;

begin
  if ADataSet.FieldCount > 0 then
  begin
    SafeRecNo := ADataSet.RecNo;
    LResult := TStringList.Create;
    LResult.Clear;
    LStr := '';
    LStr := AddSlashes(ADataSet.Fields[0].DisplayName);
    for i := 1 to ADataSet.FieldCount - 1 do
      LStr := LStr + LSeparator + AddSlashes(ADataSet.Fields[i].DisplayName);
    LResult.Add(LStr);
    ADataSet.First;
    while not ADataSet.Eof do
    begin
      LStr := AddSlashes(ADataSet.Fields[0].AsString);
      for i := 1 to ADataSet.FieldCount - 1 do
        LStr := LStr + LSeparator + AddSlashes(ADataSet.Fields[i].AsString);
      LResult.Add(LStr);
      ADataSet.Next;
    end;
    ADataSet.RecNo := SafeRecNo;
    SendCustomString(ALogLevel, AName, LResult.Text, mtDataMessage, mstTable);
    LResult.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
class function TLMDLogDBSession.GetName: WideString;
begin
  Result := 'lmd_db_session';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogDBSession.SendDataSet(AName: String; ADataSet: TDataSet);
begin
  SendDataSet(FDefaultLogLevel, AName, ADataSet);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogDBSession.SendDataSetStructure(ALogLevel: TLMDLogLevel; AName: String; ADataSet: TDataSet);
var
  LIni: TLMDMemIniFile;
  LIniCtr: TLMDIniCtrl;
  LStr: TStringList;
  LMemStream: TMEmoryStream;
  i: Integer;
  LSection: string;

  function FieldDateTypeToString(AFieldType: TFieldType): string;
  begin
    Result := GetEnumName(TypeInfo(TFieldType), Ord(AFieldType))
  end;

  function FieldKindToString(AFieldKind: TFieldKind): string;
  begin
    Result := GetEnumName(TypeInfo(TFieldKind), Ord(AFieldKind))
  end;

begin
  if not Assigned(ADataSet) then exit;
  LIniCtr := TLMDIniCtrl.Create(nil);
  try
    LIniCtr.Target := itMemIniFile;
    LIni := LIniCtr.MemIniFile;

    LIni.WriteString('Main', 'Field Count', IntToStr(ADataSet.FieldCount));
    LIni.WriteString('Main', 'Filter', ADataSet.Filter);
    LIni.WriteString('Main', 'Filtered', LMDIfThen(ADataSet.Filtered, 'Yes', 'No'));
    LIni.WriteString('Main', 'Is UniDirectional', LMDIfThen(ADataSet.IsUniDirectional, 'Yes', 'No'));

    for i := 0  to ADataSet.Fields.Count - 1 do
    begin
      LSection := 'Fields\' + FieldKindToString(ADataSet.Fields[i].FieldKind) + '\' + ADataSet.Fields[i].FieldName;
      LIni.WriteString(LSection, 'DateType', FieldDateTypeToString(ADataSet.Fields[i].DataType));
      LIni.WriteString(LSection, 'Size', IntToStr(ADataSet.Fields[i].DataSize));
      LIni.WriteString(LSection, 'required', LMDIfThen(ADataSet.Fields[i].Required, 'Yes', 'No'));
    end;

    LStr := TStringList.Create;
    //////////////////////
    try
      LMemStream := TMemoryStream.Create;
      try
        LIni.GetStrings(LStr);
        // SendCustomString(ALogLevel, AName, LStr.Text, mtDataMessage, mstDataSetStructure);
        LStr.SaveToStream(LMemStream);
        SendCustomStream(ALogLevel, '', AName, LMemStream, mtDataMessage, mstDataSetStructure);
      finally
        LMemStream.Free;
      end;
    finally
      LStr.Free;
    end;
  finally
    LIniCtr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLogDBSession.SendDataSetStructure(AName: String; ADataSet: TDataSet);
begin
  SendDataSetStructure(FDefaultLogLevel, AName, ADataSet);
end;

initialization
  LMDLogManager.RegisterSessionClass(TLMDLogDBSession);

end.
