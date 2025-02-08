unit LMDDBFieldCheckListDlg;
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

LMDDBFieldCheckListDlg unit (JH)
--------------------------------

Dialog providing a Radio- or CheckListBox

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms,
  Classes,
  DB,
  LMDCustomCheckListDlg;

type
  TLMDDBFieldCheckListDlg = class (TLMDCustomCheckListDlg)
  private
    FDataLink: TDataLink;
    procedure SetDataSource(aValue:TDataSource);
    function GetDataSource:TDataSource;
  protected
  public
    function ExecuteEnh(aForm:TForm):Boolean; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    constructor Create (aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

implementation

{----------------------------------------------------------------------------- }
procedure TLMDDBFieldCheckListDlg.SetDataSource(aValue: TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:= aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{----------------------------------------------------------------------------- }
function TLMDDBFieldCheckListDlg.GetDataSource: TDataSource;
begin
  result:= FDataLink.DataSource;
end;

{----------------------------------------------------------------------------- }
function TLMDDBFieldCheckListDlg.ExecuteEnh(aForm:TForm):Boolean;
var
  i : Integer;
begin
  Items.Clear;
  if Assigned (DataSource) then
    if Assigned (DataSource.DataSet) then
      Items.Assign (DataSource.DataSet.FieldList);
  inherited ExecuteEnh (aForm);
end;

{----------------------------------------------------------------------------- }
procedure TLMDDBFieldCheckListDlg.Notification(aComponent:TComponent;Operation:TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{----------------------------------------------------------------------------- }
constructor TLMDDBFieldCheckListDlg.Create (aOwner: TComponent);
begin
  inherited Create (aOwner);
  FDataLink := TDataLink.Create;
end;

{----------------------------------------------------------------------------- }
destructor TLMDDBFieldCheckListDlg.Destroy;
begin
  FDataLink.Free;
  inherited Destroy;
end;

end.

