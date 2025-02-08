unit eldbutils;
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

ElDBUtils unit
--------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface
uses
  DB,
  DBTables,
  SysUtils,
  Classes,
  ElXTree,
  ElHeader
  ;

type

  TElDatasetFeatures = class
  public
    constructor Create; virtual;
    procedure DoSort(Sender: TCustomElXTree; DataSet: TDataSet); virtual;
  end;

  TElQueryFeatures = class(TElDatasetFeatures)
  public
    procedure DoSort(Sender: TCustomElXTree; DataSet: TDataSet); override;
  end;

  THackElXTree = class(TCustomElXTree);

implementation

{ TElDatasetFeatures }

constructor TElDatasetFeatures.Create;
begin
  inherited Create;
end;

procedure TElDatasetFeatures.DoSort(Sender: TCustomElXTree; DataSet: TDataSet);
begin
end;

{ TElQueryFeatures }

procedure TElQueryFeatures.DoSort(Sender: TCustomElXTree; DataSet: TDataSet);
var
  tmp: TStrings;
  s: String;
  i: Integer;
  AlreadyOrdered, WasOpened: Boolean;
  bk: TBookmark;
begin
  if not Assigned(THackElXTree(Sender).FSortSections) then exit;
  bk := nil;
  tmp := TStringList.Create;
  try
    tmp.Text := TQuery(DataSet).SQL.Text;
    s := '';
    for i := 0 to THackElXTree(Sender).FSortSections.Count - 1 do
    begin
      s := s + IntToStr(TElHeaderSection(THackElXTree(Sender).FSortSections[i]).Index + 1);
      if TElHeaderSection(THackElXTree(Sender).FSortSections[i]).SortMode = hsmDescend then
        s := s + ' DESC, '
      else
        s := s + ', ';
    end;
    if s <> '' then
    begin
      s := 'ORDER BY ' + Copy(s, 1, Length(s) - 2);
      AlreadyOrdered := false;
      for i := 0 to tmp.Count - 1 do
      begin
        if Pos('ORDER BY',UpperCase(tmp[i])) > 0 then
        begin
          if Pos('ORDER BY',UpperCase(tmp[i])) = 1 then
            tmp[i] := s;
          AlreadyOrdered := true;
          Break;
        end;
      end;
      if not AlreadyOrdered then
        tmp.add(s);
      DataSet.DisableControls;
      WasOpened := DataSet.Active;
      if WasOpened then
      begin
        bk := DataSet.GetBookmark;
        DataSet.Close;
      end;
      TQuery(DataSet).SQL.Text := tmp.Text;
      if WasOpened then
      begin
        DataSet.Open;
        DataSet.GotoBookmark(bk);
      end;
    end;
  finally
    tmp.Free;
    if DataSet.ControlsDisabled then
      DataSet.EnableControls;
  end;
end;

end.
