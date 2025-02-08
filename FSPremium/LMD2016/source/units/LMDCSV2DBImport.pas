unit LMDCSV2DBImport;
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

LMDCSV2DBImport unit (JH)
-------------------------

Component which can be used for importing values from a CSV ASCII file into 
a database

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, DBCtrls, DB,
  LMDClass, LMDCSVImport;

type
  {---------------------TLMDDBFieldConnect-------------------------------------}
  TLMDDBFieldConnect = class (TCollectionItem)
  private
    FDataLink    : TFieldDataLink;
    FTokenNum    : Int64;
    FPrimary     : Boolean;

    procedure SetDataField(const aValue:string);
    procedure SetDataSource (aValue: TDataSource);
    function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    procedure SetPrimary (aValue: Boolean);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource;
    property Index;
    property Primary: Boolean read FPrimary write SetPrimary default false;
    property TokenNum: Int64 read FTokenNum write FTokenNum;
    property DisplayName;
  end;

  TLMDCustomSetToken = procedure (Sender: TLMDDBFieldConnect; tokenVal: String) of object;

  {---------------------TLMDFieldConnections-----------------------------------}
  TLMDDBFieldConnections = class (TOwnedCollection)
  private
    //FOwner  : TComponent;
    function GetItem(Index: Integer): TLMDDBFieldConnect;
    procedure SetItem(Index: Integer; Value: TLMDDBFieldConnect);
  protected
    function getTokenCount: Int64; virtual; //abstract;
    //function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    procedure SetDataSource (aValue: TDataSource);
    function GetDataSource: TDataSource;
    procedure SelectAsPrimary (aField: TLMDDBFieldConnect);
  public
    //constructor Create(Owner : TComponent);
    //destructor Destroy; override;
    function Add: TLMDDBFieldConnect;
    property Items[Index: Integer]: TLMDDBFieldConnect read GetItem write SetItem; default;
  end;

  {---------------------TLMDDBImportLink---------------------------------------}
  TLMDDBImportLink = class(TDataLink)
  private
//    FDBImportComponent: TLMDCSV2DBImport;
  protected
    procedure ActiveChanged; override;
    procedure LayoutChanged; override;
  public
    constructor Create;
  end;

  TLMDDBImportOption = (ioAppendNew, ioUpdateExisting, ioEmptyDB);
  TLMDDBImportOptions = set of TLMDDBImportOption;

  TLMDOnUpdateRecordField = procedure (Sender: TObject; recNo: Int64; Field: TField; const newVal: String; var update: Boolean) of object;

  {---------------------TLMDCSV2DBImport---------------------------------------}
  TLMDCSV2DBImport = class (TLMDCSVImport)
  private
    FFieldConnections: TLMDDBFieldConnections;
    FImportOptions   : TLMDDBImportOptions;
    FDataSourceLink  : TLMDDBImportLink;
    FUpdatingRecord  : Boolean;

    FOnUpdateField   : TLMDOnUpdateRecordField;
    FOnSetTokenValue : TLMDCustomSetToken;

    procedure SetDataSource(aValue:TDataSource);
    function GetDataSource:TDataSource;
    procedure SetFieldConnections(aValue: TLMDDBFieldConnections);
  protected
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    function getTokenCount: Int64; override;
    function BeginImport: Boolean; override;
    procedure ProcessToken (const aToken: String; aTokenNum: Int64); override;
    function ProcessRecordStart: Boolean; override;
    procedure ProcessRecordEnd; override;
  public
    constructor Create (aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property FieldConnections: TLMDDBFieldConnections read FFieldConnections write SetFieldConnections;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Options: TLMDDBImportOptions read FImportOptions write FImportOptions default [ioAppendNew];
    property OnUpdateField: TLMDOnUpdateRecordField read FOnUpdateField write FOnUpdateField;
    property OnSetTokenValue: TLMDCustomSetToken read FOnSetTokenValue write FOnSetTokenValue;
  end;

implementation

{ **************************** TLMDDBFieldConnect **************************** }
procedure TLMDDBFieldConnect.SetDataField(const aValue:string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldConnect.SetDataSource (aValue: TDataSource);
begin
  if (FDataLink=nil) then exit;
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then
    aValue.FreeNotification(TComponent(TOwnedCollection(self.Collection).Owner));
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldConnect.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldConnect.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldConnect.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldConnect.SetPrimary (aValue: Boolean);
begin
  if aValue = false then FPrimary := false
  else
    TLMDDBFieldConnections(Collection).SelectAsPrimary (self);
end;

{ -------------------------- protected --------------------------------------- }
{ ---------------------------- public ---------------------------------------- }
constructor TLMDDBFieldConnect.Create(Collection: TCollection);
begin
  inherited Create (Collection);
  FDataLink := TFieldDataLink.Create;
  FTokenNum := Index;
  FPrimary := false;
  SetDataSource (TLMDDBFieldConnections(Collection).GetDataSource);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBFieldConnect.Destroy;
begin
  FDataLink.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldConnect.Assign(Source: TPersistent);
begin
  if Source is TLMDDBFieldConnect then
    begin
      FTokenNum := (Source as TLMDDBFieldConnect).TokenNum;
      if DataSource = (Source as TLMDDBFieldConnect).DataSource then
        DataField := (Source as TLMDDBFieldConnect).DataField;
    end
  else
    inherited Assign (Source);
end;

{ **************************************************************************** }
function TLMDDBFieldConnections.GetItem(Index: Integer): TLMDDBFieldConnect;
begin
  result := TLMDDBFieldConnect(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldConnections.SetItem(Index: Integer; Value: TLMDDBFieldConnect);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
{function TLMDDBFieldConnections.GetOwner: TPersistent;
begin
  result := FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldConnections.Update(Item: TCollectionItem);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldConnections.SetDataSource (aValue: TDataSource);
var
  i: Integer;
begin
  for i := 0 to count - 1 do
    Items[i].SetDataSource(aValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldConnections.GetDataSource: TDataSource;
begin
  result := (GetOwner as TLMDCSV2DBImport).DataSource;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldConnections.SelectAsPrimary (aField: TLMDDBFieldConnect);
var
  i: Integer;
begin
  //only one primary allowed! disable all others
  for i := 0 to count - 1 do
    Items[i].Primary := false;
  //set primary
  aField.FPrimary := true;
end;

{ ------------------------------ public -------------------------------------- }
{constructor TLMDDBFieldConnections.Create(Owner : TComponent);
begin
  inherited Create(TLMDDBFieldConnect);
  FOwner := Owner;
end;

{ ---------------------------------------------------------------------------- }
{destructor TLMDDBFieldConnections.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldConnections.Add: TLMDDBFieldConnect;
begin
  result := TLMDDBFieldConnect(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldConnections.getTokenCount: Int64;
begin
  Result := 0;
end;

{ *********************************TLMDDBImportLink*************************** }
procedure TLMDDBImportLink.ActiveChanged;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBImportLink.LayoutChanged;
begin
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDBImportLink.Create;
begin
  inherited Create;
end;

{ ***********************************TLMDCSV2DBImport************************* }
procedure TLMDCSV2DBImport.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataSourceLink.DataSource then
    FDataSourceLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(self);
  FFieldConnections.SetDataSource(aValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCSV2DBImport.GetDataSource:TDataSource;
begin
  result:= FDataSourceLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCSV2DBImport.SetFieldConnections(aValue: TLMDDBFieldConnections);
begin
  FFieldConnections.Assign(aValue);
end;

{ ---------------------------- protected ------------------------------------- }
function TLMDCSV2DBImport.getTokenCount: Int64;
begin
  result := FFieldConnections.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCSV2DBImport.BeginImport: Boolean;
begin
  result:= false;
  if not Assigned (DataSource) then
    begin
      exit;
    end;
  DataSource.DataSet.First;
  if ioEmptyDB in FImportOptions then
    while not DataSource.DataSet.Eof do
      DataSource.DataSet.Delete;
  result:= true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCSV2DBImport.ProcessToken (const aToken: String; aTokenNum: Int64);
var
  i: Integer;
  doIt: Boolean;
begin
  i := 0;
  //find field which shall be set to the value of the current token
  while (i < FFieldConnections.Count) and (FFieldConnections.Items[i].TokenNum <> aTokenNum) do
    inc(i);
  //check whether we have a valid connection for the last token
  //iff, proccess  
  if i < FFieldConnections.Count then //conversion is done by field itself!
    begin
      doIt := true;
      //if updating a user can deny the updating by using the OnUpdateField event
      if FUpdatingRecord and Assigned (FOnUpdateField) then
        FOnUpdateField (self, DataSource.DataSet.RecNo, FFieldConnections.Items[i].Field, aToken, doIt);
      //if we shall set the new value we'll do that now
      if doIt then
        begin
          if Assigned (FFieldConnections.Items[i].Field) then
            FFieldConnections.Items[i].Field.AsString := aToken
          else //of no field name is assigned but OnImportEvent assigned execute it
            if Assigned (FOnSetTokenValue) then FOnSetTokenValue (FFieldConnections.Items[i], aToken);
        end
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCSV2DBImport.ProcessRecordStart: Boolean;
var
  i: Integer;
  existing : Boolean;
begin
  result := false;

  //lookout for a primary field
  i := 0;
  while (i < FFieldConnections.Count) and (not FFieldConnections.Items[i].Primary) do
    inc(i);

  //assume record not existing
  existing := false;
  //disable any old filtering
  DataSource.DataSet.Filtered := false;

  if i < FFieldConnections.Count then //we have got a primary field!!
    begin
      DataSource.DataSet.Filter := FFieldConnections.Items[i].DataField +'='+ CurrentRecord[FFieldConnections.Items[i].TokenNum];
      DataSource.DataSet.Filtered := true;
      existing := DataSource.DataSet.RecordCount <> 0;
    end;

  FUpdatingRecord := false;

  if existing then //can only be true if one field is identified f as primary key
    if not (ioUpdateExisting in FImportOptions) then //if we shall not update
                                                     //already existing fields
                                                     //we should exit without
                                                     //any further processing
      exit
    else
      begin
        FUpdatingRecord := true;                     //set internal flag
        DataSource.DataSet.Edit                      //enable record editing
      end
  else                                              //new record
    if ioAppendNew in FImportOptions then
      DataSource.DataSet.Append                     //add new record and enable editing
    else
      exit;                                         //no new ones -> get out

  result := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCSV2DBImport.ProcessRecordEnd;
begin
  DataSource.DataSet.Post;                         //save changes to record
  DataSource.DataSet.Filtered := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCSV2DBImport.Notification(aComponent:TComponent;Operation:TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (AComponent=DataSource) then
    begin
      DataSource := nil;
    end;
end;

{ ----------------------------- public --------------------------------------- }
constructor TLMDCSV2DBImport.Create (aOwner: TComponent);
begin
  inherited Create (aOwner);
  FFieldConnections := TLMDDBFieldConnections.Create(self, TLMDDBFieldConnect);
  FDataSourceLink  := TLMDDBImportLink.Create;
  FImportOptions := [ioAppendNew];
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCSV2DBImport.Destroy;
begin
  FDataSourceLink.Free;
  FFieldConnections.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCSV2DBImport.Loaded;
begin
  inherited Loaded;
  FFieldConnections.SetDataSource(DataSource);  
end;

end.
