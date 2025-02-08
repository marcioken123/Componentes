unit LMDRTFDBRichEdit;
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

LMDRTFDBRichEdit unit (RM)
-------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDRTFRichEdit, db, dbctrls, Messages, controls, Classes,
  Windows;

type
{ **************************  TLMDDBRichEdit  ************************** }
  TLMDDBRichEdit = class(TLMDCustomRichEdit)
  private
    FKeepCaret: Boolean;
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    FDataSave: string;

    procedure BeginEditing;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetAutoDisplay(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    FCaretPos: TPoint;
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
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
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

  published
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property KeepCaret: Boolean read FKeepCaret write FKeepCaret default False;
    property AcceptDropFiles;
    property AllowObjects;
    property AllowInPlace;
    property Align;
    property Alignment;
    property Anchors;
    property AutoURLDetect;
    property AutoVerbMenu;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HideScrollBars;
    property ImeMode;
    property ImeName;
    property Constraints;
    property LanguageOptions;
    property MaxLength;
    property Mode;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PlainText;
    property PopupMenu;
    property ShowRuler;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Title;
    property UndoLimit;
    property Visible;
    property Version;
    property WantTabs;
    property WantReturns;
    property WordWrap;
    property Zoom;
    property OnChange;
    // 7.02
    property ShowDefaultPopup;
    property OnAfterSave;
    property OnBeforeSave;
    // ---
    property OnContextPopup;
    // -----
    property OnDlgCustomize;
    property OnDlgInit;
    property OnDlgAfterShow;
    // -----
    property OnDropFile;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnProtectChange;
    property OnResizeRequest;
    property OnSaveClipboard;
    property OnSelectionChange;
    property OnStartDock;
    property OnStartDrag;
    property OnURLClick;
    property OnLinkClick;
    property OnRulerTabCreate;
    property OnRulerTabChange;
    property OnRulerTabDestroy;
    property OnRulerFirstIdentChange;
    property OnRulerLeftIdentChange;
    property OnRulerRightIdentChange;

  property OnVScroll;
    property OnHScroll;
  end;

implementation

uses Forms, Graphics, SysUtils;

{ **************************  TLMDDBRichEdit  ************************** }
{ -------------------------------------------------------------------------- }
constructor TLMDDBRichEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly:= True;
  FAutoDisplay:= True;
  FDataLink:= TFieldDataLink.Create;
  FDataLink.Control:= Self;
  FDataLink.OnDataChange:= DataChange;
  FDataLink.OnEditingChange:= EditingChange;
  FDataLink.OnUpdateData:= UpdateData;
  ControlStyle := ControlStyle + [csReplicatable];
  FKeepCaret := False;
end;

{ -------------------------------------------------------------------------- }
destructor TLMDDBRichEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink:= nil;
  inherited Destroy;
end;

{ -------------------------------------------------------------------------- }

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource:= nil;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichEdit.UseRightToLeftAlignment: Boolean;
begin Result:= DBUseRightToLeftAlignment(Self, Field); end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.BeginEditing;
begin
  if FDataLink.ReadOnly then exit; // V.O. 23.06.2003
  if FDataLink.Field = nil then exit; // D.S. 03.06.2003
  if not FDataLink.Editing then
  try
    if FDataLink.Field.IsBlob then
      FDataSave:= FDataLink.Field.AsString;
    FDataLink.Edit;
  finally
    FDataSave:= '';
  end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FMemoLoaded then
  begin
    if (Key = VK_DELETE) or (Key = VK_BACK) or
      ((Key = VK_INSERT) and (ssShift in Shift)) or
      (((Key = Ord('V')) or (Key = Ord('X'))) and (ssCtrl in Shift)) then
      BeginEditing;
  end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FMemoLoaded then
  begin
    if ((Key >= #32) and (Key <= #255)) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key:= #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        BeginEditing;
      #27:
        FDataLink.Reset;
    end;
  end else
  begin
    if Key = #13 then LoadMemo;
    Key:= #0;
  end;
end;

procedure TLMDDBRichEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FCaretPos := GetCaretPos;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.Change;
begin
  if FMemoLoaded then
  begin
    BeginEditing;
    FDataLink.Modified;
  end;
  inherited Change;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichEdit.GetDataSource: TDataSource;
begin Result:= FDataLink.DataSource; end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource:= Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichEdit.GetDataField: string;
begin Result:= FDataLink.FieldName; end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName:= Value;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichEdit.GetReadOnly: Boolean;
begin
  Result:= FDataLink.ReadOnly;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly:= Value;
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichEdit.GetField: TField;
begin
  Result:= FDataLink.Field;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.LoadMemo;
begin
  if not FMemoLoaded and Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
    begin
      try
        Lines.Assign(FDataLink.Field);
        FMemoLoaded:= True;
      except
        { Rich Edit Load failure }
        on E:EOutOfResources do
          Lines.Text:= Format('(%s)', [E.Message]);
      end;
      EditingChange(Self);
    end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.DataChange(Sender: TObject);
var
  LOldL, LNewL: integer;
begin
  LOldL := Length(Lines.Text);
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsBlob then
    begin
      if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
      begin
        { Check if the data has changed since we read it the first time }
        if (FDataSave <> '') and (FDataSave = FDataLink.Field.AsString) then Exit;
        FMemoLoaded:= False;
        LoadMemo;
      end else
      begin
        Text:= Format('(%s)', [FDataLink.Field.DisplayLabel]);
        FMemoLoaded:= False;
      end;
    end else
    begin
      if FFocused and FDataLink.CanModify then
        Text:= FDataLink.Field.Text
      else
        Text:= FDataLink.Field.DisplayText;
      FMemoLoaded:= True;
    end
  else
  begin
    if csDesigning in ComponentState then Text:= Name else Text:= '';
    FMemoLoaded:= False;
  end;

  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);

  if KeepCaret then
  begin
    LNewL := Length(Lines.Text);
    if LNewL >= LOldL then
      SetCaretPos(FCaretPos);
  end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.EditingChange(Sender: TObject);
 begin inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded); end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.UpdateData(Sender: TObject);
begin
  if FDataLink.Field.IsBlob then
    FDataLink.Field.Assign(Lines)
  else
    FDataLink.Field.AsString:= Text;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused:= Value;
    if not Assigned(FDataLink.Field) or not FDataLink.Field.IsBlob then
      FDataLink.Reset;
  end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    inherited ReadOnly:= False;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.CMExit(var Message: TCMExit);
begin
    try
      FDataLink.UpdateRecord;
    except
      SetFocus;
      raise;
    end;
  SetFocused(False);
  inherited;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
    begin
      FAutoDisplay:= Value;
      if Value then LoadMemo;
    end;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then
    LoadMemo
  else
    inherited;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  FCaretPos := GetCaretPos;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.WMCut(var Message: TMessage);
begin
  BeginEditing;
  inherited;
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.WMPaste(var Message: TMessage);
begin
  BeginEditing;
  inherited;
end;

{ -------------------------------------------------------------------------- }

procedure TLMDDBRichEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result:= LRESULT(FDataLink);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result:= inherited ExecuteAction(Action) or (FDataLink <> nil) and FDataLink.ExecuteAction(Action);
end;

{ -------------------------------------------------------------------------- }
function TLMDDBRichEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result:= inherited UpdateAction(Action) or (FDataLink <> nil) and FDataLink.UpdateAction(Action);
end;

{ -------------------------------------------------------------------------- }
procedure TLMDDBRichEdit.WMPaint(var Message: TWMPaint);
var
  lBmp: TBitmap;
  lCanvas: TCanvas;
  lRichEdit: TLMDCustomRichEdit;
  s: string;
  ch: integer;
begin
  if not (csPaintCopy in ControlState) then
    inherited
  else
    begin
      if FDataLink.Field <> nil then
        if FDataLink.Field.IsBlob then
        begin
          if FAutoDisplay then
            S := AdjustLineBreaks(FDataLink.Field.AsString) else
            S := Format('(%s)', [FDataLink.Field.DisplayLabel]);
        end else
          S := FDataLink.Field.DisplayText;

      lRichEdit := TLMDCustomRichEdit.Create(nil);
      lRichEdit.ParentWindow := Application.Handle;

      lRichEdit.LanguageOptions := LanguageOptions;

      TLMDRichEdit(lRichEdit).Color := Color;
      TLMDRichEdit(lRichEdit).BorderStyle := BorderStyle;
      TLMDRichEdit(lRichEdit).BorderWidth := BorderWidth;
      TLMDRichEdit(lRichEdit).Ctl3D := Ctl3D;
      TLMDRichEdit(lRichEdit).Mode := Mode;
      TLMDRichEdit(lRichEdit).Font.Assign(Font);
      TLMDRichEdit(lRichEdit).MaxLength := MaxLength;
      TLMDRichEdit(lRichEdit).PlainText := PlainText;
      TLMDRichEdit(lRichEdit).ShowRuler := ShowRuler;
      TLMDRichEdit(lRichEdit).ScrollBars := ScrollBars;

      lRichEdit.Text := s;
      lBmp := TBitmap.Create;
      lCanvas := TCanvas.Create;
      lBmp.Width := ClientRect.Right - ClientRect.Left;
      lBmp.Height := ClientRect.Bottom - ClientRect.Top;

      lCanvas.Handle := Message.Dc;
      ch := 0;

      lBmp.Canvas.Brush.Color := Color;
      lBmp.Canvas.Brush.Style := bsSolid;
      lBmp.Canvas.FillRect(ClientRect);

      lRichEdit.Render(lBmp, ch);
      lCanvas.Draw(0,0, lBmp);

      lRichEdit.Free;
      lBmp.free;
      lCanvas.free;
    end;
end;



end.
