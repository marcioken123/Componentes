unit LMDDBMemo;
{$I lmdcmps.Inc}

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

LMDDBMemo unit ()
-----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Messages, Controls,
  DB, dbctrls,
  LMDCustomMemo,
  LMDDBBase;

type
  TLMDDBMemo = class(TLMDCustomMemo, IDataControl)
  private
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
//    FPaintControl: TPaintControl;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;reintroduce;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetAutoDisplay(Value: Boolean);
//    procedure SetFocused(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure DrawEditText (from : Integer); override;
    procedure GetChange(Sender : TObject); override;
    procedure ChangedText (At : Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure WndProc(var Message: TMessage); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CutToClipboard; override;
    procedure PasteFromClipboard; override;
    procedure LoadMemo;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property Align;
    property Alignment;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
    property AskForLoop;
    property Bevel;
    property Caret;
    property Color;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Flat;
    property FocusOnMouseAbove;
    property Font;
    property Font3D;
    property HideSelection;
    property HighlightBack;
    property HighlightText;
    property HorizScrollBar;
    property ImageIndex;
    property ImageList;
    property ImeMode;
    property ImeName;
    property Lined;
    property LineStyle;
    property ListIndex;
    property Margin;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property VertScrollBar;
    property Visible;
    property WantTabs;
    property WordWrap;
    property OnChange;
    property OnClick;
    property OnCurrentRowChanged;
    property OnCursorPosChanged;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMarginRowPaint;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnRowCountChanged;
    property OnStartDrag;
    property OnTextChangedAt;
  end;

  TLMDDBLabeledMemo = class(TLMDDBMemo)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  Windows, SysUtils, LMDStrings, LMDProcs;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FMemoLoaded then
  begin
    if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
      FDataLink.Edit;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FMemoLoaded then
  begin
    if LMDAnsiCharInSet(Key, [#32..#255]) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        FDataLink.Edit;
      #27:
        FDataLink.Reset;
    end;
  end else
  begin
    if Key = #13 then LoadMemo;
    Key := #0;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.GetChange(Sender : TObject);
begin
  if FMemoLoaded then FDataLink.Modified;
  FMemoLoaded := True;
  inherited GetChange(Sender);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.ChangedText (At : Integer);
begin
  inherited ChangedText (At);
  if [csReading, csLoading]*ComponentState<>[] then exit;
  if FMemoLoaded then FDataLink.Modified;
  FMemoLoaded := True;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMemo.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMemo.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMemo.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMemo.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.LoadMemo;
begin
  if not FMemoLoaded and Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
  begin
    try
      Text := FDataLink.Field.AsString;
      FMemoLoaded := True;
    except
      { Memo too large }
      on E:EInvalidOperation do
        Text := Format('(%s)', [E.Message]);
    end;
    EditingChange(Self);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsBlob then
      begin
        if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
          begin
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
        if FFocused and FDataLink.CanModify then
          Text := FDataLink.Field.Text
        else
          Text := FDataLink.Field.DisplayText;
        FMemoLoaded := True;
      end
  else
    begin
      if csDesigning in ComponentState then Text := Name else Text := '';
      FMemoLoaded := False;
    end;
//  Invalidate;
{  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
end;

function TLMDDBMemo.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMemo.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

procedure TLMDDBMemo.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsString := Text;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDDBMemo.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(FDataLink.Field) or not FDataLink.Field.IsBlob then
      FDataLink.Reset;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.WndProc(var Message: TMessage);
begin
{  with Message do
    if (Msg = WM_CREATE) or (Msg = WM_WINDOWPOSCHANGED) or
      (Msg = CM_FONTCHANGED) then FPaintControl.DestroyHandle;}
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.CMEnter(var Message: TCMEnter);
begin
//  SetFocused(True);
  inherited;
  FDataLink.Reset;
//  if SysLocale.FarEast and FDataLink.CanModify then
//    inherited ReadOnly := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  //SetFocused(False);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadMemo;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then LoadMemo else inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBMemo.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{procedure TLMDDBMemo.WMPaint(var Message: TWMPaint);
begin
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsBlob then
      begin
        if FAutoDisplay then
          Text := FDataLink.Field.AsString
        else
          Text := FDataLink.Field.DisplayLabel;
      end
    else
      Text := FDataLink.Field.DisplayText;
  inherited;
end;}

{ ----------------------------- public --------------------------------------- }
constructor TLMDDBMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
//  ControlStyle := ControlStyle + [csReplicatable];
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
//  FPaintControl := TPaintControl.Create(Self, 'EDIT');
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBMemo.Destroy;
begin
//  FPaintControl.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.PasteFromClipboard;
begin
  FDataLink.Edit;
  inherited PasteFromClipboard;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.CutToClipboard;
begin
  FDataLink.Edit;
  inherited CutToClipboard;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBMemo.WMPaint(var Message: TWMPaint);

begin
  inherited;
  exit;
//  if FNoUpdate then Exit;
  if not (csPaintCopy in ControlState) then
    inherited
  else
    begin
      //FNoUpdate := true;      // No longer required
      BeginUpdate;
      if FDataLink.Field <> nil then
        if FDataLink.Field.IsBlob then
          Text := FDataLink.Field.AsString
        else
          Text := FDataLink.Field.DisplayText;
      EndUpDate;
      //FNoUpDate := false;     // No longer required
      inherited;
      {      if FDataLink.Field <> nil then
        if FDataLink.Field.IsBlob then
        begin
          if FAutoDisplay then
            S := AdjustLineBreaks(FDataLink.Field.AsString) else
            S := Format('(%s)', [FDataLink.Field.DisplayLabel]);
        end else
          S := FDataLink.Field.DisplayText;
      SendMessage(FPaintControl.Handle, WM_SETTEXT, 0, LPARAM(PChar(S)));
      SendMessage(FPaintControl.Handle, WM_ERASEBKGND, Message.DC, 0);
      SendMessage(FPaintControl.Handle, WM_PAINT, Message.DC, 0); }
    end;
end;

procedure TLMDDBMemo.DrawEditText (from : Integer);
begin
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) and not (csDesigning in ComponentState) then
    begin
      BeginUpdate;
      if FDataLink.Field <> nil then
        if FDataLink.Field.IsBlob then
          Text := FDataLink.Field.AsString
        else
          Text := FDataLink.Field.DisplayText;
      //FNoUpdate := true;     // No longer required
      EndUpdate;
      //FNoUpdate := false;   // No longer required
    end;
  inherited DrawEditText (from);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBMemo.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDDBLabeledMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
