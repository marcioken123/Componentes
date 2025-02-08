unit LMDDBFilter;
{$I lmdcmps.inc}

{
  ##############################################################################
  # Author: LMD Innovative ()
  # Created: 1996
  # Description:
  # State: release
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

uses
  DB,
  DBCtrls,
  Classes,
  Controls,
  Messages,
  LMDCustomComponent;

type
  {------------------------------- TLMDDBFilter -------------------------------}
  TLMDDBFilter=class;

  TLMDFilterDataLink = class(TDataLink)
  private
    FFilter:TLMDDBFilter;
  protected
    procedure ActiveChanged; override;
  public
    constructor Create(aValue:TLMDDBFilter);
    destructor Destroy; override;
  end;

  TLMDDBFilter = class(TLMDCustomComponent)
  private
    FFiltered:Boolean;
    FDataLink: TLMDFilterDataLink;
    FOnFilter:TFilterRecordEvent;
    function GetDataSource: TDataSource;
    procedure SetFiltered(aValue:Boolean);
    procedure SetOnFiltered(aValue:TFilterRecordEvent);
    procedure SetDataSource(aValue:TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    procedure ActivateFilter;
    procedure DeActivateFilter;
  published
    property About;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
    property Filtered:Boolean read FFiltered write SetFiltered default false;
    property OnFilterRecord: TFilterRecordEvent read FOnFilter write SetOnFiltered;
  end;

implementation

{************************ Class TLMDFilterDataLink ****************************}
{------------------------------ Public ----------------------------------------}
constructor TLMDFilterDataLink.Create(aValue:TLMDDBFilter);
begin
  inherited Create;
  FFilter:=aValue;
end;

{------------------------------------------------------------------------------}
destructor TLMDFilterDataLink.Destroy;
begin
  FFilter:=nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFilterDataLink.ActiveChanged;
begin
  if FFilter<>nil then FFilter.DeActivateFilter;
end;

{************************ Class TLMDDBFilter **********************************}
{------------------------- Private --------------------------------------------}
procedure TLMDDBFilter.SetFiltered(aValue:Boolean);
begin
  if not (csDesigning in ComponentState) then
    if aValue then ActivateFilter else DeActivateFilter;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBFilter.SetOnFiltered(aValue:TFilterRecordEvent);
begin
  if FFiltered then DeActivateFilter;
  FOnFilter:=aValue;
  if Assigned(FDataLink.DataSet) then
    begin
      FDataLink.DataSet.OnFilterRecord:=nil;
      FDataLink.DataSet.OnFilterRecord:=FOnFilter;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBFilter.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    begin
      DeActivateFilter;
      FDataLink.DataSource:=aValue;
    end;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDDBFilter.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBFilter.CMGetDataLink(var Message: TMessage);
begin
  Message.Result:=Integer(FDataLink);
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDDBFilter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) then
    if Assigned(FDataLink) and (AComponent=DataSource) then DataSource:=nil;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDDBFilter.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FDataLink:=TLMDFilterDataLink.Create(self);
end;

{------------------------------------------------------------------------------}
Destructor TLMDDBFilter.Destroy;
begin
  FDataLink.Free;
  FDataLink:=nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBFilter.ActivateFilter;
begin
  if csLoading in ComponentState then exit;

  if FDataLink.DataSet<>nil then
    with FDataLink.DataSet do
      begin
        OnFilterRecord:=FOnFilter;
        Filtered:=True;
        FFiltered:=FDataLink.DataSet.Filtered;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBFilter.DeActivateFilter;
begin
  if csLoading in ComponentState then exit;

  if Assigned(FDataLink) then
  if Assigned(FDataLink.DataSource) then
    FDataLink.DataSource.DataSet.Filtered:=False;
  FFiltered:=False;
end;

end.
 
