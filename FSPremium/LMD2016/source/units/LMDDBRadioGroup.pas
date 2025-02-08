unit LMDDBRadioGroup;
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

LMDDBRadioGroup unit ()
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, DB,
  DBCtrls,
  Classes,
  Messages,
  Controls,
  LMDCustomRadioGroup,
  LMDDBBase;

type
  {---------------------------- TLMDDBRadioGroup ------------------------------}
  TLMDDBRadioGroup = class(TLMDCustomRadioGroup, IDataControl)
  private
    FDataLink: TFieldDataLink;
    FValue: string;
    FValues: TStrings;
    FInSetValue: Boolean;
    FOnChange: TNotifyEvent;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;reintroduce;
    function GetButtonValue(Index: Integer): string;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValue(const Value: string);
    procedure SetItems(Value: TStringList);
    procedure SetValues(Value: TStrings);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure Change; dynamic;
    procedure Click; override;
    procedure Loaded;override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property DataLink: TFieldDataLink read FDataLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanModify: Boolean; override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
    property ItemIndex;
    property Value: string read FValue write SetValue;
  published
    property About;
    property Align;
    property Alignment;
    property Bevel;
    property Caption;
    property CaptionFont;
    property CaptionFont3D;
    property CaptionOffset;
    property CaptionParentFont;
    property Color;
    property Columns;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusStyle;
    property FocusColor;
    property UseFocusColor;
    property Font;
    property Font3D;
    property GlyphImageIndex;
    property GlyphImageList;
    property GlyphListIndex;
    property GlyphTransparent;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property Items write SetItems;
    property ItemHeight;
    property ItemOffset;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property ShowAccelChar;
    property TabOrder;
    property TabStop;
    property Transparent;
    property UseBitmap;
    property Values: TStrings read FValues write SetValues;
    property Visible;

    {events}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

implementation
uses
  SysUtils,
  StdCtrls;

{ ------------------------------- private ------------------------------------ }
procedure TLMDDBRadioGroup.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    Value := FDataLink.Field.Text
  else
    Value := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioGroup.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

procedure TLMDDBRadioGroup.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    FDataLink.Field.Text := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioGroup.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioGroup.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioGroup.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioGroup.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioGroup.GetButtonValue(Index: Integer): string;
begin
  if (Index < FValues.Count) and (FValues[Index] <> '') then
    Result := FValues[Index]
  else if Index < Items.Count then
    Result := Items[Index]
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.SetValue(const Value: string);
var
  I, Index: Integer;
begin
  if FValue <> Value then
    begin
      FInSetValue := True;
      FReading:=csLoading in ComponentState;  // 7.0.61
      try
        Index := -1;
        for I := 0 to Items.Count - 1 do
          if Value = GetButtonValue(I) then
            begin
              Index := I;
              Break;
            end;
        ItemIndex := Index;
      finally
        FInSetValue := False;
        FReading:=False;
      end;
      FValue := Value;
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.SetItems(Value: TStringList);
begin
  Items.Assign(Value);
  DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.SetValues(Value: TStrings);
begin
  FValues.Assign(Value);
  DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBRadioGroup.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    if ItemIndex >= 0 then
      TRadioButton(Controls[ItemIndex]).SetFocus
    else
      TRadioButton(Controls[0]).SetFocus;
    raise;
  end;
  inherited;
end;

{ ------------------------- protected ---------------------------------------- }
procedure TLMDDBRadioGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ': FDataLink.Edit;
    #27: FDataLink.Reset;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.Loaded;
begin
  inherited;
  if (csDesigning in ComponentState) then
    DataChange(Self)
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioGroup.CanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioGroup.Click;
begin
  if not FInSetValue then
    begin
      inherited Click;
      if ItemIndex >= 0 then
        begin
          FDataLink.Edit;
          Value := GetButtonValue(ItemIndex);
        end;
      if FDataLink.Editing then FDataLink.Modified;
    end;
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDDBRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle{+[csReplicatable]};
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FValues := TStringList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBRadioGroup.Destroy;
begin
  FreeAndNil(FDataLink);
  FreeAndNil(FValues);
  inherited Destroy;
end;

function TLMDDBRadioGroup.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioGroup.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
