unit LMDRTFDBLabel;
{$I LMDCmps.inc}

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

LMDRTFDBLabel unit (RM)
-----------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDRTFLabel, db, dbctrls, Messages, controls, Classes,
  Windows;

type

{ **************************  TLMDDBRichLabel  ************************** }
  TLMDDBRichLabel = class(TLMDCustomRichLabel)
  private
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FMemoLoaded: Boolean;
    FDataSave: string;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure UpdateData(Sender: TObject);
  procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  procedure LoadMemo; virtual;
    property Field: TField read GetField;
    function UseRightToLeftAlignment: Boolean; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property AutoURLDetect;

    property AutoURLPopup;
    property AlphaBlend;
    property AlphaBlendValue;

    property Align;
    property Anchors;
    property Bevel;
    property BiDiMode;
    property Cursor;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Hint;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Transparent;
    property Visible;
    property OnURLClick;
    property OnLinkClick;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

{ **************************  TLMDDBRichScrollText  ************************* }
  TLMDDBRichScrollText = class(TLMDCustomRichScrollText)
  private
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FMemoLoaded: Boolean;
    FDataSave: string;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure UpdateData(Sender: TObject);
  procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  procedure LoadMemo; virtual;
    property Field: TField read GetField;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
  published
    property AutoURLPopup;
    property AlphaBlend;
    property AlphaBlendValue;

    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Direction;
    property ScrollStyle;
    property Scroll;
    property AutoURLDetect;
    property Align;
    property Anchors;
    property Bevel;
    property BiDiMode;
    property Cursor;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Hint;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Transparent;
    property WordWrap;
    property MaxWidth;
    property MaxHeight;
    property Visible;
    property OnURLClick;
    property OnLinkClick;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property Delay;
    property Step;
  end;

{ **************************  TLMDDBRichScrollBox  ************************* }
  TLMDDBRichScrollBox = class(TLMDCustomRichScrollBox)
  private
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FMemoLoaded: Boolean;
    FDataSave: string;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure UpdateData(Sender: TObject);
  procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  procedure LoadMemo; virtual;
    property Field: TField read GetField;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
  published
    property AutoURLPopup;
    property AlphaBlend;
    property AlphaBlendValue;

    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Align;
    property Anchors;
    property Bevel;
    property BiDiMode;
    property Cursor;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Hint;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Transparent;
    property WordWrap;
    property Visible;
    property OnURLClick;
    property OnLinkClick;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses SysUtils;

{ **************************  TLMDDBRichLabel  ***************************** }
{ -------------------------------------------------------------------------- }
constructor TLMDDBRichLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ -------------------------------------------------------------------------- }
destructor TLMDDBRichLabel.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ -------------------------------------------------------------------------- }

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichLabel.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and (AComponent = DataSource) then DataSource := nil;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichLabel.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichLabel.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichLabel.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self)
  else
    Lines.Clear;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichLabel.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichLabel.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichLabel.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichLabel.LoadMemo;
begin
  if not FMemoLoaded and Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
  begin
    try
      Lines.Assign(FDataLink.Field);
      FMemoLoaded := True;
    except
      on E:EOutOfResources do
        Lines.Text := Format('(%s)', [E.Message]);
    end;
  end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichLabel.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsBlob then
      begin
        if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
          begin
            if (FDataSave <> '') and (FDataSave = FDataLink.Field.AsString) then Exit;
            FMemoLoaded := False;
            LoadMemo;
          end
        else
          begin
            Text := Format('(%s)', [FDataLink.Field.DisplayLabel]);
            FMemoLoaded := False;
          end;
      end
    else
      begin
        Lines.Text := FDataLink.Field.DisplayText;
        FMemoLoaded := True;
      end
  else
    begin
      if csDesigning in ComponentState then
        Text := Name
      else
        Text := '';
      FMemoLoaded := False;
    end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichLabel.UpdateData(Sender: TObject);
begin
  if FDataLink.Field.IsBlob then
    FDataLink.Field.Assign(Lines)
  else
    FDataLink.Field.AsString := Text;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDDBRichLabel.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(FDataLink);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichLabel.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and FDataLink.ExecuteAction(Action);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichLabel.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and FDataLink.UpdateAction(Action);
end;

{ **************************  TLMDDBRichScrollText  ************************ }
{ -------------------------------------------------------------------------- }
constructor TLMDDBRichScrollText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ -------------------------------------------------------------------------- }
destructor TLMDDBRichScrollText.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ -------------------------------------------------------------------------- }

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollText.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollText.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollText.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollText.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollText.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self)
  else
    Lines.Clear;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollText.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollText.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollText.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollText.LoadMemo;
begin
  if not FMemoLoaded and Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
    try
      Lines.Assign(FDataLink.Field);
      FMemoLoaded := True;
    except
      on E:EOutOfResources do
        Lines.Text := Format('(%s)', [E.Message]);
    end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollText.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsBlob then
      begin
        if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
          begin
            if (FDataSave <> '') and (FDataSave = FDataLink.Field.AsString) then Exit;
            FMemoLoaded := False;
            LoadMemo;
          end
        else
          begin
            Text := Format('(%s)', [FDataLink.Field.DisplayLabel]);
            FMemoLoaded := False;
          end;
      end
    else
      begin
        Lines.Text := FDataLink.Field.DisplayText;
        FMemoLoaded := True;
      end
  else
  begin
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';
    FMemoLoaded := False;
  end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollText.UpdateData(Sender: TObject);
begin
  if FDataLink.Field.IsBlob then
    FDataLink.Field.Assign(Lines)
  else
    FDataLink.Field.AsString := Text;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDDBRichScrollText.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(FDataLink)
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollText.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollText.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and FDataLink.UpdateAction(Action);
end;

{ **************************  TLMDDBRichScrollBox  ************************* }
{ -------------------------------------------------------------------------- }
constructor TLMDDBRichScrollBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ -------------------------------------------------------------------------- }
destructor TLMDDBRichScrollBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ -------------------------------------------------------------------------- }

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollBox.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and (AComponent = DataSource) then DataSource := nil;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollBox.GetDataSource: TDataSource;
begin Result := FDataLink.DataSource; end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollBox.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self)
  else
    Lines.Clear;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollBox.GetDataField: string;
begin Result := FDataLink.FieldName; end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollBox.LoadMemo;
begin
  if not FMemoLoaded and Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
    begin
      try
        Lines.Assign(FDataLink.Field);
        FMemoLoaded := True;
      except
        on E:EOutOfResources do
          Lines.Text := Format('(%s)', [E.Message]);
      end;
    end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollBox.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsBlob then
      begin
        if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
          begin
            if (FDataSave <> '') and (FDataSave = FDataLink.Field.AsString) then Exit;
            FMemoLoaded := False;
            LoadMemo;
          end
        else
          begin
            Text := Format('(%s)', [FDataLink.Field.DisplayLabel]);
            FMemoLoaded := False;
          end;
        end
      else
        begin
          Lines.Text := FDataLink.Field.DisplayText;
          FMemoLoaded := True;
        end
    else
      begin
        if csDesigning in ComponentState then
          Text := Name
        else
          Text := '';
        FMemoLoaded := False;
      end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichScrollBox.UpdateData(Sender: TObject);
begin
  if FDataLink.Field.IsBlob then
    FDataLink.Field.Assign(Lines)
  else
    FDataLink.Field.AsString := Text;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDDBRichScrollBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(FDataLink);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and FDataLink.ExecuteAction(Action);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichScrollBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and FDataLink.UpdateAction(Action);
end;

end.

