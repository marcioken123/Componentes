unit ElDBWideComboBox;
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

ElDBWideComboBox unit
---------------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  DB,
  DBCtrls,
  ElDBCtrls,
  LMDTypes,
  LMDElDBConst,
  StdCtrls,
  LMDUnicode,
  Classes,
  ElDBBoxes;
{$IFDEF LMD_UNICODE}

type

  TElWideDBComboBox = class(TElDBComboBox)
  private
    FUnicodeMode: TElDBUnicodeMode;
    procedure SetUnicodeMode(Value: TElDBUnicodeMode);
    function GetDBText: TLMDString;
  protected
    procedure DataChange(Sender: TObject);override;
    procedure UpdateData(Sender: TObject);override;
  published
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write SetUnicodeMode default umFieldType;
    property StressShortCut;
  end;
{$endif}
implementation
{$ifdef LMD_UNICODE}

uses
  Controls;

{ TElWideDBComboBox }

procedure TElWideDBComboBox.DataChange(Sender: TObject);
begin
  if not Assigned(DataSource) or not Assigned(DataSource.DataSet) then
    exit;
  if ((Style <> csSimple) or IsHTML) and FForm.Visible then
  else
  if DataSource.DataSet.FieldByName(DataField) <> nil then
  begin
    if UseValues then
      ItemIndex := Values.IndexOf(GetDBText)
    else
      ItemIndex := Items.IndexOf(GetDBText);
    if (ItemIndex < 0) and ( (Style = csDropDown) or IsHTML) then
      Text := GetDBText
  end
  else
    ItemIndex := -1;
  CActiveChange(nil);
end;

function TElWideDBComboBox.GetDBText: TLMDString;
var
  W : WideString;
begin
  Alignment := taLeftJustify;
  if csDesigning in ComponentState then
    Result := Name
  else
    Result := '';
  if not Assigned(DataSource) or not Assigned(DataSource.DataSet) then
    exit;
  if Alignment <> DataSource.DataSet.FieldByName(DataField).Alignment then
  begin
    Text := '';  {forces update}
    Alignment := DataSource.DataSet.FieldByName(DataField).Alignment;
  end;
  if not (csDesigning in ComponentState) then
  begin
    if (DataSource.DataSet.FieldByName(DataField).DataType in [ftString, ftWideString]) and (MaxLength = 0) then
      MaxLength := DataSource.DataSet.FieldByName(DataField).Size;
  end;
  //if Focused and FDataLink.CanModify then
  begin
    if DataSource.DataSet.FieldByName(DataField).isNull then
      W := ''
    else
    if ((UnicodeMode = umForceUTF8) or ((DataSource.DataSet.FieldByName(DataField).DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
       (LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(DataSource.DataSet.FieldByName(DataField).Value), W, strictConversion, false)<> sourceIllegal)
    then
    else
    begin
      if (DataSource.DataSet.FieldByName(DataField).DataType = ftWideString) then
        W := DataSource.DataSet.FieldByName(DataField).Value
      else
      W := DataSource.DataSet.FieldByName(DataField).Text;
    end;
    Result := W;
  end;
end;

procedure TElWideDBComboBox.SetUnicodeMode(Value: TElDBUnicodeMode);
begin
  if FUnicodeMode <> Value then
  begin
    FUnicodeMode := Value;
    if Assigned(DataSource) and Assigned(DataSource.DataSet) then
      DataChange(Self);
    if HandleAllocated and Visible then
      Invalidate;
  end;
end;

procedure TElWideDBComboBox.UpdateData(Sender: TObject);
var
  W : WideString;
  st: AnsiString;
begin
  if ((UnicodeMode = umForceUTF8) or ((DataSource.DataSet.FieldByName(DataField).DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
     (LMDConvertUTF16toUTF8(Text, st, strictConversion, false) <> sourceIllegal)
  then
  begin
    if (Style in [csSimple, csDropDown]) and (not IsHTML) then
    begin
      if (not UseValues) or (ItemIndex < 0) then
        DataSource.DataSet.FieldByName(DataField).Value := st
      else
        DataSource.DataSet.FieldByName(DataField).Value := Values[ItemIndex];
    end
    else
    if ItemIndex >= 0 then
    begin
      if UseValues and (ItemIndex < Values.Count) then
        DataSource.DataSet.FieldByName(DataField).Value := Values[ItemIndex]
      else
        DataSource.DataSet.FieldByName(DataField).Value := st;
    end
    else
      DataSource.DataSet.FieldByName(DataField).Text := '';
  end
  else
  begin
    if (DataSource.DataSet.FieldByName(DataField).DataType = ftWideString) then
    begin
      W := Text;
      if (Style in [csSimple, csDropDown]) and (not IsHTML) then
      begin
        if (not UseValues) or (ItemIndex < 0) then
          DataSource.DataSet.FieldByName(DataField).Value := W
        else
          DataSource.DataSet.FieldByName(DataField).Value := Values[ItemIndex];
      end
      else
      if ItemIndex >= 0 then
      begin
        if UseValues and (ItemIndex < Values.Count) then
          DataSource.DataSet.FieldByName(DataField).Value := Values[ItemIndex]
        else
          DataSource.DataSet.FieldByName(DataField).Value := Items[ItemIndex];
      end
      else
        DataSource.DataSet.FieldByName(DataField).Text := '';
    end
    else
    begin
      if (Style in [csSimple, csDropDown]) and (not IsHTML) then
      begin
        if (not UseValues) or (ItemIndex < 0) then
          DataSource.DataSet.FieldByName(DataField).Text := Text
        else
          DataSource.DataSet.FieldByName(DataField).Text := Values[ItemIndex];
      end
      else
      if ItemIndex >= 0 then
      begin
        if UseValues and (ItemIndex < Values.Count) then
          DataSource.DataSet.FieldByName(DataField).Text := Values[ItemIndex]
        else
          DataSource.DataSet.FieldByName(DataField).Text := Items[ItemIndex];
      end
      else
        DataSource.DataSet.FieldByName(DataField).Text := '';
    end;
  end;
end;
{$ENDIF LMD_UNICODE}

end.
