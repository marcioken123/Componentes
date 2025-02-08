unit LMDDBNImage;
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

LMDDBNImage unit ()
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, DB,
  DBCtrls,
  Messages,
  Classes,
  Controls,
  Graphics,
  LMDCustomNImage,
  LMDDBBase;

type
  {------------------------------- TLMDDBNImage -------------------------------}
  TLMDDBNImage=class(TLMDCustomNImage, IDataControl)
  private
    FDataLink:TFieldDatalink;
    function GetDataField :string;
    function GetDataSource: TDataSource;
    procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDatasource);
    procedure DataChange(Sender:TObject);

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    function GetBitmap(tmp:TBitmap):TBitmap;override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner :TComponent); override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    destructor Destroy; override;
  published
    property DataField:string read GetDataField write SetDataField;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
  end;

implementation

{------------------------------- Private --------------------------------------}
function TLMDDBNImage.GetDataField :string;
begin
  result := FDataLink.Fieldname;
end;

{------------------------------------------------------------------------------}
function TLMDDBNImage.GetDataSource: TDataSource;
begin
  result := FDatalink.Datasource;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNImage.SetDataField(const aValue :string);
begin
  FDatalink.Fieldname := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNImage.SetDataSource(aValue :TDatasource);
begin
  FDatalink.Datasource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

function TLMDDBNImage.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNImage.DataChange(Sender :TObject);
begin
  Bitmap:=nil;
  if Assigned(FDataLink.Field) and (FDataLink.Field is TBlobField) then
    begin
      Bitmap.Assign(FDataLink.Field);
      if not TransparentStyle.Transparent then Paint;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBNImage.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(FDataLink);
end;

{--------------- Protected ----------------------------------------------------}
function TLMDDBNImage.GetBitmap(tmp:TBitmap): TBitmap;
begin
  result:=nil;
  if tmp=nil then
    result:=Bitmap
  else
    if Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
      begin
        tmp.Assign(FDataLink.Field);
        result:=tmp;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBNImage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------  Public ---------------------------------------------------}
constructor TLMDDBNImage.Create(AOwner :TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  {FAutoDisplay:=True;}
  FDatalink:=TFieldDatalink.Create;
  FDatalink.OnDataChange:=DataChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBNImage.Destroy;
begin
  FDatalink.Free;
  FDataLink:=nil;
  inherited Destroy;
end;

function TLMDDBNImage.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{------------------------------------------------------------------------------}
function TLMDDBNImage.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
