{**
*  TDBNumEdit - vs99.01c
*
*  Copyright 97, 98 by Sebastião Elivaldo Ribeiro
*  http://www.utranet.com.br/elivaldo
*  e-mail: elivaldo@utranet.com.br
*
*  vs99.01c - inclusão da propriedade MaxLength
*  vs99.01b - corrigido problemas com o pressionamento de back space
*  vs99.01  - versão inicial
*}

unit DBNumEdt;

interface

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, DB, DBTables, Mask, DBCtrls, Dialogs;

type
  TDBNumEdit = class(TCustomMaskEdit)
  private
    FAlignment: TAlignment;
    FCanvas: TControlCanvas;
    FDataLink: TFieldDataLink;
    FDecimals: Byte;
    FFocused: Boolean;
    FKey: Char;
    FMaxValue: Extended;
    FMinValue: Extended;
    FOnOutOfRange: TNotifyEvent;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure EvalDecSeparator;
    procedure EvaluateKey;
    procedure InvertValue;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure SetDecimals(Dec: Byte);
    procedure UpdateData(Sender: TObject);
    procedure ValidateKey;
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Msg: TMessage); message CM_GETDATALINK;
    procedure WMCut(var Msg: TMessage); message WM_CUT;
    procedure WMMouse(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
    function CheckRange: Boolean;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetValue: Extended;
    function IsActive: Boolean;
    function StrToValue(S: string): Extended;
  protected
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Reset; override;
    function EditCanModify: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
    property Value: Extended read GetValue;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Decimals: Byte read FDecimals write SetDecimals;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property MaxLength;
    property MaxValue: Extended read FMaxValue write FMaxValue;
    property MinValue: Extended read FMinValue write FMinValue;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnOutOfRange: TNotifyEvent read FOnOutOfRange write FOnOutOfRange;
    property OnStartDock;
    property OnStartDrag;

  end;

procedure Register;

implementation

{ Create }
constructor TDBNumEdit.Create(AOwner: TComponent);
const
  bShareware: Boolean = False;
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDecimals := 2;
  // mensagem shareware
  if bShareware and not (csDesigning in ComponentState) then
    begin
      MessageBeep(MB_ICONASTERISK);
      MessageDlg('   O componente ' + ClassName + ' é shareware, e para ' +
        'utiliza-lo livremente' + #9#13 + '   você deve registra-lo.' + #13#13 +
        '    http://www.utranet.com.br/elivaldo' + #13 +
        '    mailto:elivaldo@utranet.com.br', mtInformation, [mbOk], 0);
      //bShareware := False;
    end;
end;


{ Destroy }
destructor TDBNumEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  inherited Destroy;
end;


{ CreateParams }
procedure TDBNumEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'EDIT');
  Params.Style := Params.Style and not (ES_AUTOVSCROLL or ES_AUTOHSCROLL)
    or Alignments[FAlignment] ;
end;


{ Notification }
procedure TDBNumEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then
    DataSource := nil;
end;


{ KeyDown }
procedure TDBNumEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;


{ KeyPress }
procedure TDBNumEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  FKey := Key;
  if FKey <> #0 then
    ValidateKey;
  if FKey = '-' then
    InvertValue;
  if FKey = DecimalSeparator then
    EvalDecSeparator;
  if FKey <> #0 then
    EvaluateKey;
  Key := FKey;
end;


{ EditCanModify }
function TDBNumEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;


{ Reset }
procedure TDBNumEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;


{ SetFocused }
procedure TDBNumEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
    begin
      FFocused := Value;
      if (FAlignment <> taLeftJustify) and not IsMasked then
        Invalidate;
      FDataLink.Reset;
    end;
end;


{ Change }
procedure TDBNumEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;


{ GetDataSource }
function TDBNumEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;


{ SetDataSource }
procedure TDBNumEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;


{ GetDataField }
function TDBNumEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;


{ SetDataField }
procedure TDBNumEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;


{ GetReadOnly }
function TDBNumEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;


{ SetReadOnly }
procedure TDBNumEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;


{ GetField }
function TDBNumEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;


{ DataChange }
procedure TDBNumEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    begin
      if FAlignment <> FDataLink.Field.Alignment then
        begin
          EditText := '';
          FAlignment := FDataLink.Field.Alignment;
          RecreateWnd;
          if Focused then
            PostMessage(Handle, WM_SETFOCUS, 0, 0);
        end;
      if FFocused and FDataLink.CanModify then
        Text := FloatToStrF(FDataLink.Field.AsFloat, ffFixed, 20, FDecimals)
      else
        EditText := FloatToStrF(FDataLink.Field.AsFloat, ffNumber, 20, FDecimals);
    end
  else
    begin
      if csDesigning in ComponentState then
        begin
          EditText := Name;
          if FAlignment <> taLeftJustify then
            begin
              FAlignment := taLeftJustify;
              RecreateWnd;
            end
        end
      else
        EditText := '';
    end;
  if Focused and not FDataLink.Editing then
    SelectAll;
end;


{ EditingChange }
procedure TDBNumEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;


{ UpdateData }
procedure TDBNumEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  if CheckRange then
    FDataLink.Field.Text := FloatToStr(GetValue)
  else
    Abort;
end;


{ WMPaste }
procedure TDBNumEdit.WMPaste(var Msg: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;


{ WMCut }
procedure TDBNumEdit.WMCut(var Msg: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;


{ CMEnter }
procedure TDBNumEdit.CMEnter(var Msg: TCMEnter);
begin
  SetFocused(True);
  SelectAll;
  inherited;
  Invalidate;
end;


{ CMExit }
procedure TDBNumEdit.CMExit(var Msg: TCMExit);
begin
  if CheckRange then
    begin
      try
        FDataLink.UpdateRecord;
      except
        SelectAll;
        SetFocus;
        raise;
      end;
      SetFocused(False);
      SetCursor(0);
      DoExit;
    end;
end;


{ WMPaint }
procedure TDBNumEdit.WMPaint(var Msg: TWMPaint);
var
  X, Y: Integer;
  Rect: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
begin
  if FFocused and not (csPaintCopy in ControlState) then
    begin
      inherited;
      Exit;
    end;
  if (csDesigning in ComponentState) and (not IsActive) then
    S := Name
  else if (not IsActive) then
    S := ''
  else
    S := FloatToStrF(GetValue, ffNumber, 20, FDecimals);
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
    S := FloatToStrF(FDataLink.Field.AsFloat, ffNumber, 20, FDecimals);
  DC := Msg.DC;
  if DC = 0 then
    DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    if not Enabled then
      FCanvas.Font.Color := clGray;
    Rect := ClientRect;
    if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        FCanvas.Brush.Color := clWindowFrame;
        FCanvas.FrameRect(Rect);
        InflateRect(Rect, -1, -1);
      end;
    FCanvas.Brush.Color := Color;
    Y := ((Height + Font.Height) div 2) - 3;
    X := Y - 1;
    case FAlignment of
      taRightJustify: X := Rect.Right - FCanvas.TextWidth(S) - Y;
      taCenter: X := (Rect.Left + Rect.Right - FCanvas.TextWidth(S)) div 2;
    end;
    FCanvas.TextRect(Rect, X, Y, S);
  finally
    FCanvas.Handle := 0;
    if Msg.DC = 0 then
      EndPaint(Handle, PS);
  end;
end;


{ CMGetDataLink }
procedure TDBNumEdit.CMGetDataLink(var Msg: TMessage);
begin
  Msg.Result := Integer(FDataLink);
end;


{ WMMouse }
procedure TDBNumEdit.WMMouse(var Msg: TWMMouse);
begin
  if not Focused then
    begin
      inherited;
      SelectAll;
    end
  else
    inherited;
end;


{ GetValue }
function TDBNumEdit.GetValue: Extended;
begin
  Result := StrToValue(Text);
end;


{ StrToValue }
function TDBNumEdit.StrToValue(S: string): Extended;
var
  N: string;
  I: Integer;
begin
  N := '0';
  for I := 1 to Length(S) do
    if ((S[I] = DecimalSeparator) and (Pos(DecimalSeparator, N) = 0))
      or (S[I] in ['0'..'9']) then
      N := N + S[I];
  Result := StrToFloat(N);
  if (N <> '0') and (Pos('-', S) = 1) then
    Result := -StrToFloat(N)
end;


{ ValidateKey }
procedure TDBNumEdit.ValidateKey;
begin
  if FKey in ['.', ','] then
    FKey := DecimalSeparator;
  if not (FKey in ['0'..'9', '.', ',', '-', #08, #27, ^X, ^C, ^V])
    or ((GetValue < 0) and (SelStart = 0) and (SelLength = 0) and (FKey <> '-'))
    or ((FKey = DecimalSeparator) and (FDecimals = 0)) then
    begin
      MessageBeep(0);
      FKey := #0;
    end;
  if FKey in [^H, ^V, ^X, '0'..'9', DecimalSeparator] then
    FDataLink.Edit
  else if FKey = #27 then
    begin
      FDataLink.Reset;
      SelectAll;
      FKey := #0;
    end;
end;


{ InvertValue }
procedure TDBNumEdit.InvertValue;
var
  I, L: Integer;
begin
  L := Length(Text);
  if SelLength <> L then
    begin
      I := SelStart;
      if GetValue > 0 then
        Text := '-' + Text
      else if GetValue < 0 then
        Text := Copy(Text, 2, L);
      SelStart := I + Length(Text) - L;
      FKey := #0;
    end;
end;


{ EvalDecSeparator }
procedure TDBNumEdit.EvalDecSeparator;
var
  I, L: Integer;
begin
  L := Length(Text);
  I := Pos(DecimalSeparator, Text );
  if (I > 0) and (SelLength <> L) then
    begin
      SelStart := I;
      FKey := #0;
    end
  else if (SelLength <> L) and ((SelStart + FDecimals) < L) then
    begin
      {retira decimais excedentes, se houver}
      I := SelStart;
      Text := Copy(Text, 1, SelStart + FDecimals);
      SelStart := I;
    end;
end;


{ EvaluateKey }
procedure TDBNumEdit.EvaluateKey;
var
  I, L: Integer;
begin
  L := Length(Text);
  I := Pos(DecimalSeparator, Text );
  {edição dos decimais}
  if (I <> 0) and (SelStart >= I) and ((L - I) >= FDecimals) and (SelLength = 0) then
    begin
      if (SelStart < L) then
        begin
          I := SelStart;
          Text := Copy(Text, 1, L - 1 );
          SelStart := I;
        end
      else if (FKey <> #08) then
        begin
          MessageBeep(0);
          FKey := #0;
        end;
    end;
end;


{ SetDecimals }
procedure TDBNumEdit.SetDecimals(Dec: Byte);
begin
  FDecimals := Dec;
  DataChange(Self);
end;


{ IsActive }
function TDBNumEdit.IsActive: Boolean;
var
  DtSrc: TDataSource;
begin
  Result := False;
  DtSrc := GetDataSource;
  if (DtSrc <> nil) and (DtSrc.Dataset <> nil) then
    Result := DtSrc.Dataset.Active
end;


{ CheckRange }
function TDBNumEdit.CheckRange: Boolean;
begin
  Result := True;
  if IsActive and ((FMaxValue <> 0) or (FMinValue <> 0)) and
    ((GetValue > FMaxValue) or (GetValue < FMinValue)) then
    begin
      if Assigned(FOnOutOfRange) then
        FOnOutOfRange(Self)
      else
        MessageBeep(0);
      SelectAll;
      SetFocus;
      Result := False;
    end
end;


{ Register }
procedure Register;
begin
  RegisterComponents('Externo', [TDBNumEdit]);
end;


end.

