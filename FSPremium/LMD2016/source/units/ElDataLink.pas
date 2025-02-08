unit ElDataLink;

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

ElDataLink unit
--------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  ElComponent,
  DB,
  Classes;

type

     TElDataSetScrollEvent = procedure(Sender : TObject; Distance : integer) of object;
     TElRecordChangeEvent = procedure(Sender : TObject; Field : TField) of object;

     TElDataLink = class;

     TElIntDataLink = class(TDataLink)
     private
       FLink : TElDataLink;
     protected
       procedure ActiveChanged; override;
       procedure DataSetChanged; override;
       procedure EditingChanged; override;
       procedure DataSetScrolled(Distance: Integer); override;
       procedure LayoutChanged; override;
       procedure RecordChanged(Field: TField); override;
     end;

     TElDataLink = class(TElComponent)
     private
       FDataLink: TElIntDataLink;
     protected
       FDataSource: TDataSource;
       FOnActiveChange: TNotifyEvent;
       FOnDatasetChange: TNotifyEvent;
       FOnDatasetScroll: TElDataSetScrollEvent;
       FOnEditingChange: TNotifyEvent;
       FOnLayoutChange: TNotifyEvent;
       FOnRecordChange: TElRecordChangeEvent;
       procedure SetDataSource(Value: TDataSource);
       procedure Notification(AComponent : TComponent; Operation : TOperation);
           override;
     public
       constructor Create(AOwner : TComponent); override;
       destructor Destroy; override;
     published
       property DataSource: TDataSource read FDataSource write SetDataSource;
       property OnActiveChange: TNotifyEvent read FOnActiveChange write
           FOnActiveChange;
       property OnDatasetChange: TNotifyEvent read FOnDatasetChange write
           FOnDatasetChange;
       property OnDatasetScroll: TElDataSetScrollEvent read FOnDatasetScroll write
           FOnDatasetScroll;
       property OnEditingChange: TNotifyEvent read FOnEditingChange write
           FOnEditingChange;
       property OnLayoutChange: TNotifyEvent read FOnLayoutChange write
           FOnLayoutChange;
       property OnRecordChange: TElRecordChangeEvent read FOnRecordChange write
           FOnRecordChange;
     end;

implementation

procedure TElDataLink.SetDataSource(Value: TDataSource);
begin
  if FDataSource <> Value then
  begin
    if FDataSource <> nil then
      FDataSource.UnregisterFreeNotification(Self);
    FDataSource := Value;
    FDataLink.DataSource := Value;

    if FDataSource <> nil then
      FDataSource.FreeNotification(Self);
  end;
end;

procedure TElDataLink.Notification(AComponent : TComponent; Operation :
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = DataSource then
      DataSource := nil;
  end;
end;

constructor TElDataLink.Create(AOwner : TComponent);
begin
  inherited;
  FDataLink := TElIntDataLink.Create;
  FDataLink.FLink := Self;
end;

destructor TElDataLink.Destroy;
begin
  DataSource := nil;
  FDataLink.Free;
  inherited;
end;

procedure TElIntDataLink.ActiveChanged;
begin
  if (FLink <> nil) and Assigned(FLink.FOnActiveChange) then FLink.FOnActiveChange(FLink);
end;

procedure TElIntDataLink.DataSetChanged;
begin
  if (FLink <> nil) and Assigned(FLink.FOnDataSetChange) then FLink.FOnDataSetChange(FLink);
end;

procedure TElIntDataLink.EditingChanged;
begin
  if (FLink <> nil) and Assigned(FLink.FOnEditingChange) then FLink.FOnEditingChange(FLink);
end;

procedure TElIntDataLink.DataSetScrolled(Distance: Integer);
begin
  if (FLink <> nil) and Assigned(FLink.FOnDataSetScroll) then FLink.FOnDataSetScroll(FLink, Distance);
end;

procedure TElIntDataLink.LayoutChanged;
begin
  if (FLink <> nil) and Assigned(FLink.FOnLayoutChange) then FLink.FOnLayoutChange(FLink);
end;

procedure TElIntDataLink.RecordChanged(Field: TField);
begin
  if (FLink <> nil) and Assigned(FLink.FOnRecordChange) then FLink.FOnRecordChange(FLink, Field);
end;

end.
