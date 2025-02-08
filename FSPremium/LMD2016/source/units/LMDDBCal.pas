unit LMDDBCal;
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

LMDDBCal unit (JH)
------------------

Datasensitive db calendar

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Controls,
  dbctrls, db,
  lmdcal,
  LMDDBBase;

type
  TLMDDBCalendar = class(TLMDCustomCalendar, IDataControl)
  private
    FDataLink: TFieldDataLink;
    FOnDataChange: TNotifyEvent;
    procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDataSource);
    function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    procedure DataChange (Sender : TObject);
    procedure EditingChange (Sender : TObject);
    procedure UpDateData (Sender : TObject);
    procedure CMEnter (var Msg : TCMEnter); message CM_ENTER;
    procedure CMExit (var Msg : TCMExit); message CM_EXIT;
    procedure WMLButtonDown (var Msg : TWMLButtonDown); message WM_LBUTTONDOWN;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    procedure DoDateChange; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DockManager;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField; //added July 2001, JH
  published
    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property UseDockManager default false;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;

    property About;
    property Align;
    property Bevel;
    property CellStyle;
    property Cursor;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DayCaptionCellStyle;
    property DayCaptions;
    property DayDirection;
    property DragCursor;
    property DragMode;
    property FillObject;
    property FixedDimens;
    property Flat;
    property GridPen;
    property Header;
    property Height;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property ImageList;
    property Left;
    property ListIndex;
    property MarkedCellStyle;
    property MarkedDay;
    property Name;
    property PopupMenu;
    property ReadOnly;
    property SelectedCellStyle;
    property ShowDayHint;
    property ShowGrid;
    property ShowHint;
    property ShowSpecialDayHint;
    property SpecialDates;
    property StartDay;
    property StartWithActualDate;
    property Tag;
    property Top;
    property Transparent;
    property UseLongDayNames;
    property Width;
    { events }
    property OnClick;
    property OnDateSel;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDraw;
    property OnEndDrag;
    property OnGetCellSettings;
    property OnKeyPressed;
    property OnMonthChange;
    property OnMouseClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnStartDrag;
    property OnYearChange;
  end;

implementation

{-------------------------- Private -------------------------------------------}
procedure TLMDDBCalendar.DataChange(Sender: TObject);
begin
  if FDataLink.Field<>nil then
    begin
      if Focused and FDataLink.CanModify then
        Date := FDataLink.Field.AsDateTime
      else
      begin
        Date := FDataLink.Field.AsDateTime;
        if FDataLink.Editing {and FDataLink.Modified} then
          Modified := True;
      end;
    end;

  if Assigned(FOnDataChange) then FOnDataChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBCalendar.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

{------------------------------------------------------------------------------}
function TLMDDBCalendar.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{------------------------------------------------------------------------------}
function TLMDDBCalendar.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBCalendar.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsDateTime := Date;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBCalendar.CMEnter (var Msg : TCMEnter);
begin
  inherited;
  FDataLink.Reset;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBCalendar.CMExit (var Msg : TCMExit);
begin
  FDataLink.Reset;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBCalendar.WMLButtonDown (var Msg : TWMLButtonDown);
begin
  FDataLink.Edit;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBCalendar.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBCalendar.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDDBCalendar.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{------------------------------------------------------------------------------}
function TLMDDBCalendar.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{------------------------------------------------------------------------------}
function TLMDDBCalendar.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBCalendar.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink());
end;

{------------------------------ Protected -------------------------------------}
function TLMDDBCalendar.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBCalendar.DoDateChange;
begin
  inherited DoDateChange;
  FDataLink.Modified;
end;

{------------------------------ Public ----------------------------------------}
procedure TLMDDBCalendar.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{------------------------------------------------------------------------------}
constructor TLMDDBCalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := true;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBCalendar.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

end.
