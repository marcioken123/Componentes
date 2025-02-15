{***********************************************************
                R&A Library
       Copyright (C) 1996-98 R&A
       Portion copyright (c) 1995,97 Borland International

       components  : TRADBLookupTreeView,
                     TRADBLookupTreeViewCombo
       description : db-aware lookup TreeView

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit RADBLookupTreeView;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Dialogs, Forms, Graphics,
  CommCtrl, ComCtrls, ExtCtrls, Db, DBTables, dbctrls, RADBTreeView;


const
  wm_InClose = wm_User + 1;

type

{********************** Borland **********************}
{ TDBLookupControl }

  TRADBLookupControl = class;

  TDataSourceLink = class(TDataLink)
  private
    FDBLookupControl: TRADBLookupControl;
  protected
    procedure FocusControl(Field: TFieldRef); override;
    procedure ActiveChanged; override;
    procedure RecordChanged(Field: TField); override;
  end;

  TListSourceLink = class(TDataLink)
  private
    FDBLookupControl: TRADBLookupControl;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
  end;

  TRADBLookupControl = class(TCustomControl)
  private
    FLookupSource: TDataSource;
    FDataLink: TDataSourceLink;
    FListLink: TListSourceLink;
    FDataFieldName: string;
    FKeyFieldName: string;
    FListFieldName: string;
    FListFieldIndex: Integer;
    FDataField: TField;
    FMasterField: TField;
    FKeyField: TField;
    FListField: TField;
    FListFields: TList;
    FKeyValue: Variant;
    FSearchText: string;
    FLookupMode: Boolean;
    FListActive: Boolean;
    FFocused: Boolean;
    function CanModify: Boolean;
    procedure CheckNotCircular;
    procedure CheckNotLookup;
    procedure DataLinkActiveChanged;
    procedure DataLinkRecordChanged(Field: TField);
    function GetBorderSize: Integer;
    function GetDataSource: TDataSource;
    function GetKeyFieldName: string;
    function GetListSource: TDataSource;
    function GetReadOnly: Boolean;
    function GetTextHeight: Integer;
    procedure KeyValueChanged; virtual;
    procedure ListLinkActiveChanged; virtual;
    procedure ListLinkDataChanged; virtual;
    function LocateKey: Boolean;
    procedure ProcessSearchKey(Key: Char);
    procedure SelectKeyValue(const Value: Variant);
    procedure SetDataFieldName(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetKeyFieldName(const Value: string);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListFieldName(const Value: string);
    procedure SetListSource(Value: TDataSource);
    procedure SetLookupMode(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure WMGetDlgCode(var Message: TMessage); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    property DataField: string read FDataFieldName write SetDataFieldName;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property KeyValue: Variant read FKeyValue write SetKeyValue;
    property ListField: string read FListFieldName write SetListFieldName;
    property ListFieldIndex: Integer read FListFieldIndex write FListFieldIndex default 0;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property ParentColor default False;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property TabStop default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read FDataField;
  end;

  TPopupDataList = class;

  TDropDownAlign = (daLeft, daRight, daCenter);

  TRADBLookupTreeViewCombo = class(TRADBLookupControl)
  private
    FDataList: TPopupDataList;
    FButtonWidth: Integer;
    FText: string;
//    FDropDownRows: Integer;
    FTracking: Boolean;
    FDropDownWidth: Integer;
    FDropDownHeight: Integer;
    FDropDownAlign: TDropDownAlign;
    FListVisible: Boolean;
    FPressed: Boolean;
    FAlignment: TAlignment;
    FLookupMode: Boolean;
    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TNotifyEvent;
{new} FMasterField : string;
{new} FDetailField : string;
{new} FIconField : string;
{new} FStartMasterValue : string;
    procedure KeyValueChanged; override;
    procedure ListLinkActiveChanged; override;
{    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);}
    procedure StopTracking;
    procedure TrackButton(X, Y: Integer);
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
  private
   {$IFDEF RA_D4H}
    FAutoExpand : boolean;
    FChangeDelay : integer;
    FHotTrack : boolean;
    FRowSelect : boolean;
    FToolTips : boolean;
    FOnCustomDraw: TTVCustomDrawEvent;
    FOnCustomDrawItem: TTVCustomDrawItemEvent;
    FOnGetImageIndex: TTVExpandedEvent;
   {$ENDIF RA_D4H}
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CloseUp(Accept: Boolean);
    procedure DropDown;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property KeyValue;
    property ListVisible: Boolean read FListVisible;
    property Text: string read FText;
  published
    property Color;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragMode;
    property DropDownAlign: TDropDownAlign read FDropDownAlign write FDropDownAlign default daLeft;
//    property DropDownRows: Integer read FDropDownRows write FDropDownRows default 7;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
{new} property DropDownHeight: Integer read FDropDownHeight write FDropDownHeight default 100;
    property Enabled;
    property Font;
    property KeyField;
    property ListField;

{new} property MasterField : string read FMasterField write FMasterField;
{new} property DetailField : string read FDetailField write FDetailField;
{new} property IconField : string read FIconField write FIconField;
{new} property StartMasterValue : string read FStartMasterValue write FStartMasterValue;

    property ListFieldIndex;
    property ListSource;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
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
   {$IFDEF RA_D3H}
    property ImeMode;
    property ImeName;
   {$ENDIF RA_D3H}
   {$IFDEF RA_D4H}
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property AutoExpand : boolean read FAutoExpand write FAutoExpand;
    property ChangeDelay : integer read FChangeDelay write FChangeDelay;
    property HotTrack : boolean read FHotTrack write FHotTrack;
    property RowSelect : boolean read FRowSelect write FRowSelect;
    property ToolTips : boolean read FToolTips write FToolTips;
    property OnCustomDraw : TTVCustomDrawEvent read FOnCustomDraw write FOnCustomDraw;
    property OnCustomDrawItem : TTVCustomDrawItemEvent read FOnCustomDrawItem write FOnCustomDrawItem;
    property OnGetImageIndex : TTVExpandedEvent read FOnGetImageIndex write FOnGetImageIndex;
   {$ENDIF RA_D4H}
  end;

{###################### Borland ######################}

  TPopupTree = class(TRADBTreeView)
  private
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
  protected
    procedure DblClick; override;
  end;

  TPopupDataList = class(TWinControl)
  private
    FTree : TPopupTree;
    function GetKeyValue : variant;
    property KeyValue : variant read GetKeyValue;
   // procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TRADBLookupTreeView = class(TRADBLookupControl)
  private
    FTree : TRADBTreeView;
    FBorderStyle : TBorderStyle;
    InKeyValueChanged : boolean;
    procedure SetBorderStyle(Value: TBorderStyle);
    function GetMasterField : string;
    procedure SetMasterField(Value: string);
    function GetDetailField : string;
    procedure SetDetailField(Value: string);
    function GetStartMasterValue : string;
    procedure SetStartMasterValue(Value: string);
    function GetIconField: string;
    procedure SetIconField(const Value: string);
    procedure KeyValueChanged; override;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
   {Tree}
    function GetShowButtons : boolean;
    function GetShowLines : boolean;
    function GetShowRoot : boolean;
    function GetReadOnly : boolean;
    function GetHideSelection : boolean;
    function GetIndent : integer;
    procedure SetShowButtons(Value : boolean);
    procedure SetShowLines(Value : boolean);
    procedure SetShowRoot(Value : boolean);
    procedure SetReadOnly(Value : boolean);
    procedure SetHideSelection(Value : boolean);
    procedure SetIndent(Value : integer);
   {$IFDEF RA_D3H}
    function GetRightClickSelect : boolean;
    procedure SetRightClickSelect(Value : boolean);
   {$ENDIF RA_D3H}
   {$IFDEF RA_D4H}
    function GetAutoExpand: boolean;
    function GetChangeDelay: integer;
    function GetHotTrack: boolean;
    function GetOnGetImageIndex: TTVExpandedEvent;
    function GetRowSelect: boolean;
    function GetToolTips: boolean;
    procedure SetAutoExpand(const Value: boolean);
    procedure SetChangeDelay(const Value: integer);
    procedure SetHotTrack(const Value: boolean);
    procedure SetOnGetImageIndex(const Value: TTVExpandedEvent);
    procedure SetRowSelect(const Value: boolean);
    procedure SetToolTips(const Value: boolean);
    function GetOnCustomDraw: TTVCustomDrawEvent;
    function GetOnCustomDrawItem: TTVCustomDrawItemEvent;
    procedure SetOnCustomDraw(const Value: TTVCustomDrawEvent);
    procedure SetOnCustomDrawItem(const Value: TTVCustomDrawItemEvent);
   {$ENDIF RA_D4H}
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ListLinkActiveChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Color;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property KeyField;
    property ListField;
    property ListFieldIndex;
    property ListSource;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
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
   {$IFDEF RA_D3H}
    property ImeMode;
    property ImeName;
   {$ENDIF RA_D3H}
   {$IFDEF RA_D4H}
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;

    property AutoExpand : boolean read GetAutoExpand write SetAutoExpand;
    property ChangeDelay : integer read GetChangeDelay write SetChangeDelay;
    property HotTrack : boolean read GetHotTrack write SetHotTrack;
    property RowSelect : boolean read GetRowSelect write SetRowSelect;
    property ToolTips : boolean read GetToolTips write SetToolTips;
    property OnCustomDraw : TTVCustomDrawEvent read GetOnCustomDraw write SetOnCustomDraw;
    property OnCustomDrawItem : TTVCustomDrawItemEvent read GetOnCustomDrawItem write SetOnCustomDrawItem;
    property OnGetImageIndex : TTVExpandedEvent read GetOnGetImageIndex write SetOnGetImageIndex;
   {$ENDIF RA_D4H}

   {Tree}
    property MasterField : string read GetMasterField write SetMasterField;
    property DetailField : string read GetDetailField write SetDetailField;
    property IconField : string read GetIconField write SetIconField;
    property StartMasterValue : string read GetStartMasterValue write SetStartMasterValue;
    property ShowButtons      : boolean read GetShowButtons      write SetShowButtons;
    property ShowLines        : boolean read GetShowLines        write SetShowLines;
    property ShowRoot         : boolean read GetShowRoot         write SetShowRoot;
    property ReadOnly         : boolean read GetReadOnly         write SetReadOnly;
   {$IFDEF RA_D3H}
    property RightClickSelect : boolean read GetRightClickSelect write SetRightClickSelect;
   {$ENDIF RA_D3H}
    property HideSelection    : boolean read GetHideSelection    write SetHideSelection;
    property Indent           : integer read GetIndent           write SetIndent;
  end;

implementation

uses DBConsts;

{ TDataSourceLink }

{$IFDEF RA_D2}
function GetFieldProperty(DataSet: TDataSet; Control: TComponent;
  const FieldName: string): TField;
begin
  Result := DataSet.FindField(FieldName);
  if Result = nil then
    raise EDatabaseError.CreateFmt(LoadStr(SFieldNotFound), [Control.Name, FieldName]);
end;
{$ENDIF RA_D2}


procedure TDataSourceLink.ActiveChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.DataLinkActiveChanged;
end;

procedure TDataSourceLink.RecordChanged(Field: TField);
begin
  if FDBLookupControl <> nil then FDBLookupControl.DataLinkRecordChanged(Field);
end;

procedure TDataSourceLink.FocusControl(Field: TFieldRef);
begin
  if (Field^ <> nil) and (Field^ = FDBLookupControl.Field) and
    (FDBLookupControl <> nil) and FDBLookupControl.CanFocus then
  begin
    Field^ := nil;
    FDBLookupControl.SetFocus;
  end;
end;

{ TListSourceLink }

procedure TListSourceLink.ActiveChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.ListLinkActiveChanged;
end;

procedure TListSourceLink.DataSetChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.ListLinkDataChanged;
end;

{ TRADBLookupControl }

function VarEquals(const V1, V2: Variant): Boolean;
begin
  Result := False;
  try
    Result := V1 = V2;
  except
  end;
end;

var
  SearchTickCount: Integer = 0;

constructor TRADBLookupControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if NewStyleControls then
    ControlStyle := [csOpaque] else
    ControlStyle := [csOpaque, csFramed];
  ParentColor := False;
  TabStop := True;
  FLookupSource := TDataSource.Create(Self);
  FDataLink := TDataSourceLink.Create;
  FDataLink.FDBLookupControl := Self;
  FListLink := TListSourceLink.Create;
  FListLink.FDBLookupControl := Self;
  FListFields := TList.Create;
  FKeyValue := Null;
end;

destructor TRADBLookupControl.Destroy;
begin
  FListFields.Free;
  FListLink.FDBLookupControl := nil;
  FListLink.Free;
  FDataLink.FDBLookupControl := nil;
  FDataLink.Free;
  inherited Destroy;
end;

function TRADBLookupControl.CanModify: Boolean;
begin
  Result := FListActive and not ReadOnly and ((FDataLink.DataSource = nil) or
    (FMasterField <> nil) and FMasterField.CanModify);
end;

procedure TRADBLookupControl.CheckNotCircular;
begin
  if (FDataLink.Active and FDataLink.DataSet.IsLinkedTo(ListSource)) or
     (FListLink.Active and FListLink.DataSet.IsLinkedTo(DataSource)) then
  {$IFDEF RA_D3H}
    DatabaseError(SCircularDataLink);
  {$ELSE}
    DatabaseError(LoadStr(SCircularDataLink));
  {$ENDIF RA_D3H}
end;

procedure TRADBLookupControl.CheckNotLookup;
begin
  if FLookupMode then
  {$IFDEF RA_D3H}
    DatabaseError(SPropDefByLookup);
  {$ELSE}
    DatabaseError(LoadStr(SPropDefByLookup));
  {$ENDIF RA_D3H}
  if FDataLink.DataSourceFixed then
  {$IFDEF RA_D3H}
    DatabaseError(SDataSourceFixed);
  {$ELSE}
    DatabaseError(LoadStr(SDataSourceFixed));
  {$ENDIF RA_D3H}
end;

procedure TRADBLookupControl.DataLinkActiveChanged;
begin
  FDataField := nil;
  FMasterField := nil;
  if FDataLink.Active and (FDataFieldName <> '') then
  begin
    CheckNotCircular;
    FDataField := GetFieldProperty(FDataLink.DataSet, Self, FDataFieldName);
    FMasterField := FDataField;
  end;
  SetLookupMode((FDataField <> nil) and (FDataField.FieldKind = fkLookup));
  DataLinkRecordChanged(nil);
end;

procedure TRADBLookupControl.DataLinkRecordChanged(Field: TField);
begin
  if (Field = nil) or (Field = FMasterField) then
    if FMasterField <> nil then
      SetKeyValue(FMasterField.Value) else
      SetKeyValue(Null);
end;

function TRADBLookupControl.GetBorderSize: Integer;
var
  Params: TCreateParams;
  R: TRect;
begin
  CreateParams(Params);
  SetRect(R, 0, 0, 0, 0);
  AdjustWindowRectEx(R, Params.Style, False, Params.ExStyle);
  Result := R.Bottom - R.Top;
end;

function TRADBLookupControl.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TRADBLookupControl.GetKeyFieldName: string;
begin
  if FLookupMode then Result := '' else Result := FKeyFieldName;
end;

function TRADBLookupControl.GetListSource: TDataSource;
begin
  if FLookupMode then Result := nil else Result := FListLink.DataSource;
end;

function TRADBLookupControl.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

function TRADBLookupControl.GetTextHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

procedure TRADBLookupControl.KeyValueChanged;
begin
end;

procedure TRADBLookupControl.ListLinkActiveChanged;
var
  DataSet: TDataSet;
  ResultField: TField;
begin
  FListActive := False;
  FKeyField := nil;
  FListField := nil;
  FListFields.Clear;
  if FListLink.Active and (FKeyFieldName <> '') then
  begin
    CheckNotCircular;
    DataSet := FListLink.DataSet;
    FKeyField := GetFieldProperty(DataSet, Self, FKeyFieldName);
    try
      DataSet.GetFieldList(FListFields, FListFieldName);
    except
     {$IFDEF RA_D3H}
      DatabaseErrorFmt(SFieldNotFound, [Self.Name, FListFieldName]);
     {$ELSE}
      raise EDatabaseError.CreateFmt(LoadStr(SFieldNotFound), [Self.Name, FListFieldName]);
     {$ENDIF RA_D3H}
    end;
    if FLookupMode then
    begin
      ResultField := GetFieldProperty(DataSet, Self, FDataField.LookupResultField);
      if FListFields.IndexOf(ResultField) < 0 then
        FListFields.Insert(0, ResultField);
      FListField := ResultField;
    end else
    begin
      if FListFields.Count = 0 then FListFields.Add(FKeyField);
      if (FListFieldIndex >= 0) and (FListFieldIndex < FListFields.Count) then
        FListField := FListFields[FListFieldIndex] else
        FListField := FListFields[0];
    end;
    FListActive := True;
  end;
end;

procedure TRADBLookupControl.ListLinkDataChanged;
begin
end;

function TRADBLookupControl.LocateKey: Boolean;
begin
  Result := False;
  try
    if not VarIsNull(FKeyValue) and
      FListLink.DataSet.Locate(FKeyFieldName, FKeyValue, []) then
      Result := True;
  except
  end;
end;

procedure TRADBLookupControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if (FDataLink <> nil) and (AComponent = DataSource) then DataSource := nil;
    if (FListLink <> nil) and (AComponent = ListSource) then ListSource := nil;
  end;
end;

procedure TRADBLookupControl.ProcessSearchKey(Key: Char);
var
  TickCount: Integer;
  S: string;
begin
  if (FListField <> nil) and (FListField.FieldKind = fkData) and
    (FListField.DataType = ftString) then
    case Key of
      #8, #27: FSearchText := '';
      #32..#255:
        if CanModify then
        begin
          TickCount := GetTickCount;
          if TickCount - SearchTickCount > 2000 then FSearchText := '';
          SearchTickCount := TickCount;
          if Length(FSearchText) < 32 then
          begin
            S := FSearchText + Key;
            if FListLink.DataSet.Locate(FListField.FieldName, S,
              [loCaseInsensitive, loPartialKey]) then
            begin
              SelectKeyValue(FKeyField.Value);
              FSearchText := S;
            end;
          end;
        end;
    end;
end;

procedure TRADBLookupControl.SelectKeyValue(const Value: Variant);
begin
  if FMasterField <> nil then
  begin
    if FDataLink.Edit then
      FMasterField.Value := Value;
  end else
    SetKeyValue(Value);
  Repaint;
  Click;
end;

procedure TRADBLookupControl.SetDataFieldName(const Value: string);
begin
  if FDataFieldName <> Value then
  begin
    FDataFieldName := Value;
    DataLinkActiveChanged;
  end;
end;

procedure TRADBLookupControl.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TRADBLookupControl.SetKeyFieldName(const Value: string);
begin
  CheckNotLookup;
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    ListLinkActiveChanged;
  end;
end;

procedure TRADBLookupControl.SetKeyValue(const Value: Variant);
begin
  if not VarEquals(FKeyValue, Value) then
  begin
    FKeyValue := Value;
    KeyValueChanged;
  end;
end;

procedure TRADBLookupControl.SetListFieldName(const Value: string);
begin
  if FListFieldName <> Value then
  begin
    FListFieldName := Value;
    ListLinkActiveChanged;
  end;
end;

procedure TRADBLookupControl.SetListSource(Value: TDataSource);
begin
  CheckNotLookup;
  FListLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TRADBLookupControl.SetLookupMode(Value: Boolean);
begin
  if FLookupMode <> Value then
    if Value then
    begin
      FMasterField := GetFieldProperty(FDataField.DataSet, Self, FDataField.KeyFields);
      FLookupSource.DataSet := FDataField.LookupDataSet;
      FKeyFieldName := FDataField.LookupKeyFields;
      FLookupMode := True;
      FListLink.DataSource := FLookupSource;
    end else
    begin
      FListLink.DataSource := nil;
      FLookupMode := False;
      FKeyFieldName := '';
      FLookupSource.DataSet := nil;
      FMasterField := FDataField;
    end;
end;

procedure TRADBLookupControl.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

procedure TRADBLookupControl.WMGetDlgCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

procedure TRADBLookupControl.WMKillFocus(var Message: TMessage);
begin
  FFocused := False;
  Inherited;
  Invalidate;
end;

procedure TRADBLookupControl.WMSetFocus(var Message: TMessage);
begin
  FFocused := True;
  Inherited;
  Invalidate;
end;

procedure TRADBLookupControl.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

{ TDBLookupComboBox }

constructor TRADBLookupTreeViewCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 145;
  Height := 0;
  FDataList := TPopupDataList.Create(Self);
  FDataList.Visible := False;
  FDataList.Parent := Self;
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FDropDownHeight := 100;
end;

procedure TRADBLookupTreeViewCombo.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    if NewStyleControls and Ctl3D then
      ExStyle := ExStyle or WS_EX_CLIENTEDGE
    else
      Style := Style or WS_BORDER;
end;

procedure TRADBLookupTreeViewCombo.Paint;
var
  W, X, Flags: Integer;
  Text: string;
  Alignment: TAlignment;
  Selected: Boolean;
  R: TRect;
begin
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  Selected := FFocused and not FListVisible and
    not (csPaintCopy in ControlState);
  if Selected then
  begin
    Canvas.Font.Color := clHighlightText;
    Canvas.Brush.Color := clHighlight;
  end;
  if (csPaintCopy in ControlState) and (FDataField <> nil) then
  begin
    Text := FDataField.DisplayText;
    Alignment := FDataField.Alignment;
  end else
  begin
    Text := FText;
    Alignment := FAlignment;
  end;
  W := ClientWidth - FButtonWidth;
  X := 2;
  case Alignment of
    taRightJustify: X := W - Canvas.TextWidth(Text) - 3;
    taCenter: X := (W - Canvas.TextWidth(Text)) div 2;
  end;
  SetRect(R, 1, 1, W - 1, ClientHeight - 1);
  Canvas.TextRect(R, X, 2, Text);
  if Selected then Canvas.DrawFocusRect(R);
  SetRect(R, W, 0, ClientWidth, ClientHeight);
  if not FListActive then
    Flags := DFCS_SCROLLCOMBOBOX or DFCS_INACTIVE
  else if FPressed then
    Flags := DFCS_SCROLLCOMBOBOX or DFCS_FLAT or DFCS_PUSHED
  else
    Flags := DFCS_SCROLLCOMBOBOX;
  DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, Flags);
end;

procedure TRADBLookupTreeViewCombo.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, GetTextHeight + GetBorderSize + 4);
end;

procedure TRADBLookupTreeViewCombo.KeyValueChanged;
begin
  if FLookupMode then
  begin
    FText := FDataField.DisplayText;
    FAlignment := FDataField.Alignment;
  end else
  if FListActive and LocateKey then
  begin
    FText := FListField.DisplayText;
    FAlignment := FListField.Alignment;
  end else
  begin
    FText := '';
    FAlignment := taLeftJustify;
  end;
  Invalidate;
end;

procedure TRADBLookupTreeViewCombo.ListLinkActiveChanged;
begin
  inherited;
  KeyValueChanged;
end;

procedure TRADBLookupTreeViewCombo.CloseUp(Accept: Boolean);
var
  ListValue: Variant;
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then
      SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    ListValue := FDataList.KeyValue;
    SetFocus;
    SetWindowPos(FDataList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
   // FDataList.ListSource := nil;
    FDataList.FTree.DataSource := nil;
    Invalidate;
    FSearchText := '';
    if Accept and CanModify then SelectKeyValue(ListValue);
    if Assigned(FOnCloseUp) then FOnCloseUp(Self);
    FPressed := false;
    Repaint;
  end;
end;

procedure TRADBLookupTreeViewCombo.DropDown;
var
  P: TPoint;
  {I,} Y: Integer;
  {S: string;}
begin
  if not FListVisible and FListActive then
  begin
    if Assigned(FOnDropDown) then FOnDropDown(Self);
    FDataList.Color := Color;
    FDataList.Font := Font;
    if FDropDownWidth > 0 then
      FDataList.Width := FDropDownWidth else
      FDataList.Width := Width;
    FDataList.Height := FDropDownHeight;
   // FDataList.RowCount := FDropDownRows;
   // FDataList.KeyField := FKeyFieldName;
    FDataList.FTree.MasterField := FKeyFieldName;
    FDataList.FTree.DetailField := FDetailField;
    FDataList.FTree.IconField := FIconField;
    FDataList.FTree.MasterField := FMasterField;
    FDataList.FTree.StartMasterValue := FStartMasterValue;

   {$IFDEF RA_D4H}
    FDataList.FTree.AutoExpand       := FAutoExpand      ;
    FDataList.FTree.ChangeDelay      := FChangeDelay     ;
    FDataList.FTree.HotTrack         := FHotTrack        ;
    FDataList.FTree.RowSelect        := FRowSelect       ;
    FDataList.FTree.ToolTips         := FToolTips        ;
    FDataList.FTree.OnCustomDraw     := FOnCustomDraw    ;
    FDataList.FTree.OnCustomDrawItem := FOnCustomDrawItem;
    FDataList.FTree.OnGetImageIndex  := FOnGetImageIndex ;
    FDataList.FTree.ReadOnly := not FDataLink.ReadOnly;
   {$ENDIF RA_D4H}

   { for I := 0 to FListFields.Count - 1 do
      S := S + TField(FListFields[I]).FieldName + ';';
    FDataList.ListField := S;}
    FDataList.FTree.ItemField := ListField;

   // FDataList.ListFieldIndex := FListFields.IndexOf(FListField);
   // FDataList.ListSource := FListLink.DataSource;
    FDataList.FTree.DataSource := FListLink.DataSource;
   { FDataList.FTree.FullExpand;
    FDataList.FTree.FullCollapse;
    FDataList.FTree.DataChanged; }
    FDataList.FTree.SelectNode(
      FListLink.DataSet.Lookup(FKeyFieldName, FKeyValue, FMasterField));

   // FDataList.KeyValue := KeyValue;

    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + FDataList.Height > Screen.Height then Y := P.Y - FDataList.Height;
    case FDropDownAlign of
      daRight: Dec(P.X, FDataList.Width - Width);
      daCenter: Dec(P.X, (FDataList.Width - Width) div 2);
    end;
    FDataList.Left := P.X;
    FDataList.Top := P.Y;
    FDataList.Visible := true;
    SetWindowPos(FDataList.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FListVisible := True;
    Repaint;
  end;
end;

procedure TRADBLookupTreeViewCombo.KeyDown(var Key: Word; Shift: TShiftState);
var
  Delta: Integer;
begin
  inherited KeyDown(Key, Shift);
  if FListActive and ((Key = VK_UP) or (Key = VK_DOWN)) then
    if ssAlt in Shift then
    begin
      if FListVisible then CloseUp(True) else DropDown;
      Key := 0;
    end else
      if not FListVisible then
      begin
        if not LocateKey then
          FListLink.DataSet.First
        else
        begin
          if Key = VK_UP then Delta := -1 else Delta := 1;
          FListLink.DataSet.MoveBy(Delta);
        end;
        SelectKeyValue(FKeyField.Value);
        Key := 0;
      end;
  if (Key <> 0) and FListVisible then
    // FDataList.KeyDown(Key, Shift);
    SendMessage(FDataList.FTree.Handle, WM_KEYDOWN, Key, 0);
end;

procedure TRADBLookupTreeViewCombo.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FListVisible then
    if Key in [#13, #27] then
      CloseUp(Key = #13)
    else
      FDataList.KeyPress(Key)
  else
    ProcessSearchKey(Key);
end;

procedure TRADBLookupTreeViewCombo.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    SetFocus;
    if not FFocused then Exit;
    if FListVisible then CloseUp(False) else
      if FListActive then
      begin
        MouseCapture := True;
        FTracking := True;
        TrackButton(X, Y);
        DropDown;
      end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TRADBLookupTreeViewCombo.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if FListVisible then
    begin
      ListPos := FDataList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(FDataList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(FDataList.FTree.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TRADBLookupTreeViewCombo.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  StopTracking;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TRADBLookupTreeViewCombo.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TRADBLookupTreeViewCombo.TrackButton(X, Y: Integer);
var
  NewState: Boolean;
begin
    Repaint;
  NewState := PtInRect(Rect(ClientWidth - FButtonWidth, 0, ClientWidth,
    ClientHeight), Point(X, Y));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    Repaint;
  end;
end;

procedure TRADBLookupTreeViewCombo.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FDataList) then
    CloseUp(False);
end;

procedure TRADBLookupTreeViewCombo.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls then
  begin
    RecreateWnd;
    Height := 0;
  end;
  inherited;
end;

procedure TRADBLookupTreeViewCombo.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Height := 0;
end;

procedure TRADBLookupTreeViewCombo.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TRADBLookupTreeViewCombo.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TRADBLookupTreeViewCombo.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
//  if Message.FocusedWnd = FDataList.Handle then SetFocus {else CloseUp(False);}
end;

{ TPopupRADBTreeView }

constructor TPopupDataList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable];
  TabStop := false;
  FTree := TPopupTree.Create(Self);
  FTree.Parent := self;
  FTree.Align := alClient;
  FTree.ReadOnly := true;
  FTree.BorderStyle := bsNone;
  FTree.HideSelection := false;
  FTree.TabStop := false;
//  FTree.OnDblClick := OnDblClick2;
end;

destructor TPopupDataList.Destroy;
begin
  FTree.Free;
  inherited Destroy;
end;

procedure TPopupDataList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW;
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

function TPopupDataList.GetKeyValue : variant;
begin
  if FTree.Selected <> nil then
//    Result := (FTree.Selected as TRADBTreeNode).MasterValue
    Result := FTree.DataSource.DataSet.Lookup(FTree.MasterField, (FTree.Selected as TRADBTreeNode).MasterValue, (Owner as TRADBLookupControl).KeyField)
  else Result := null;
end;


{ TPopupTree }

{******* from ComCtl98 unit}
  ////////////////////////////
  // Jean-Luc Mattei                                                            //
  // jlucm@club-internet.fr                                                     //
  ////////////////////////////
const
  NM_CUSTOMDRAW         = (NM_FIRST-12);
  CDDS_PREPAINT         = $000000001;
  CDRF_NOTIFYITEMDRAW   = $00000020;
  CDDS_ITEM             = $000010000;
  CDDS_ITEMPREPAINT     = (CDDS_ITEM OR CDDS_PREPAINT);
  CDIS_SELECTED  =  $0001;

type
  PNMCustomDrawInfo = ^TNMCustomDrawInfo;
  TNMCustomDrawInfo = packed record
    hdr : TNMHDR;
    dwDrawStage : LONGINT;
    hdc : HDC;
    rc : TRect;
    dwItemSpec : LONGINT;  // this is control specific, but it's how to specify an item.  valid only with CDDS_ITEM bit set
    uItemState : Cardinal;
    lItemlParam : Longint;
  end;
{####### from ComCtl98 unit}

procedure TPopupTree.CNNotify(var Message: TWMNotify);
begin
  with Message.NMHdr^ do
    case code of
      NM_CUSTOMDRAW:
        begin
          with PNMCustomDrawInfo(Pointer(Message.NMHdr))^ do begin
            if ( dwDrawStage and CDDS_PREPAINT ) = CDDS_PREPAINT then
              Message.Result:= CDRF_NOTIFYITEMDRAW;
            if ( dwDrawStage and CDDS_ITEMPREPAINT ) = CDDS_ITEMPREPAINT then begin
             if ( uItemstate AND CDIS_SELECTED ) <> 0 then begin
                SetTextColor(hdc, ColorToRGB(clHighLightText));
                SetBkColor(hdc, ColorToRGB(clHighLight));
              end;
              Message.Result:= CDRF_NOTIFYITEMDRAW;
            end;
          end;
        end;
      else inherited;
    end;
end;

procedure TPopupTree.WMSetFocus(var Message: TMessage);
begin
  inherited;
  Message.Result := 1;
  (Owner.Owner as TRADBLookupTreeViewCombo).SetFocus;
end;

procedure TPopupTree.DblClick;
begin
  (Owner.Owner as TRADBLookupTreeViewCombo).CloseUp(true);
end;




{ TRADBLookupTreeView }

type
  TRADBLookupTreeViewTree = class(TRADBTreeView)
  private
    procedure DataScrolled; override;
    procedure DataChanged; override;
    procedure Change2(Node: TTreeNode); override;
    procedure DefaultHandler(var Message); override;
  end;

constructor TRADBLookupTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorderStyle := bsSingle;
  FTree := TRADBLookupTreeViewTree.Create(Self);
  FTree.Parent := self;
  Width := FTree.Width;
  Height := FTree.Height;
  FTree.Align := alClient;
  FTree.ReadOnly := true;
  FTree.BorderStyle := bsNone;
  FTree.HideSelection := false;
//  FTree.TabStop := false;
end;

procedure TRADBLookupTreeView.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    if FBorderStyle = bsSingle then
      if NewStyleControls and Ctl3D then
        ExStyle := ExStyle or WS_EX_CLIENTEDGE
      else
        Style := Style or WS_BORDER;
end;

destructor TRADBLookupTreeView.Destroy;
begin
  FTree.Free;
  inherited Destroy;
end;

procedure TRADBLookupTreeView.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

function TRADBLookupTreeView.GetMasterField : string;
begin
  Result := FTree.MasterField;
end;

procedure TRADBLookupTreeView.SetMasterField(Value: string);
begin
  FTree.MasterField := Value;
end;

function TRADBLookupTreeView.GetDetailField : string;
begin
  Result := FTree.DetailField;
end;

procedure TRADBLookupTreeView.SetDetailField(Value: string);
begin
  FTree.DetailField := Value;
end;

function TRADBLookupTreeView.GetIconField: string;
begin
  Result := FTree.IconField;
end;

procedure TRADBLookupTreeView.SetIconField(const Value: string);
begin
  FTree.IconField := Value;
end;

function TRADBLookupTreeView.GetStartMasterValue : string;
begin
  Result := FTree.StartMasterValue;
end;

procedure TRADBLookupTreeView.SetStartMasterValue(Value: string);
begin
  FTree.StartMasterValue := Value;
end;

procedure TRADBLookupTreeView.ListLinkActiveChanged;
begin
  inherited;
  FTree.DataSource := ListSource;
  FTree.ItemField := ListField;
end;

procedure TRADBLookupTreeView.KeyValueChanged;
begin
  InKeyValueChanged := true;
  try
    TRADBLookupTreeViewTree(FTree).SelectNode(FKeyValue);
  finally
    InKeyValueChanged := false;
  end;
end;

procedure TRADBLookupTreeView.WMSetFocus(var Message: TMessage);
begin
  FTree.SetFocus;
end;

{** Tree}
function TRADBLookupTreeView.GetShowButtons : boolean;
begin
  Result := FTree.ShowButtons;
end;

function TRADBLookupTreeView.GetShowLines : boolean;
begin
  Result := FTree.ShowLines;
end;

function TRADBLookupTreeView.GetShowRoot : boolean;
begin
  Result := FTree.ShowRoot;
end;

function TRADBLookupTreeView.GetReadOnly : boolean;
begin
  Result := FTree.ReadOnly;
end;

{$IFDEF RA_D3H}
function TRADBLookupTreeView.GetRightClickSelect : boolean;
begin
  Result := FTree.RightClickSelect;
end;
{$ENDIF RA_D3H}

function TRADBLookupTreeView.GetHideSelection : boolean;
begin
  Result := FTree.HideSelection;
end;

function TRADBLookupTreeView.GetIndent : integer;
begin
  Result := FTree.Indent;
end;

procedure TRADBLookupTreeView.SetShowButtons(Value : boolean);
begin
  FTree.ShowButtons := Value;
end;

procedure TRADBLookupTreeView.SetShowLines(Value : boolean);
begin
  FTree.ShowLines := Value;
end;

procedure TRADBLookupTreeView.SetShowRoot(Value : boolean);
begin
  FTree.ShowRoot := Value;
end;

procedure TRADBLookupTreeView.SetReadOnly(Value : boolean);
begin
  FTree.ReadOnly := Value;
end;

{$IFDEF RA_D3H}
procedure TRADBLookupTreeView.SetRightClickSelect(Value : boolean);
begin
  FTree.RightClickSelect := Value;
end;
{$ENDIF RA_D3H}

procedure TRADBLookupTreeView.SetHideSelection(Value : boolean);
begin
  FTree.HideSelection := Value;
end;

procedure TRADBLookupTreeView.SetIndent(Value : integer);
begin
  FTree.Indent := Value;
end;
{## Tree}



procedure TRADBLookupTreeViewTree.DataScrolled;
begin
end;

procedure TRADBLookupTreeViewTree.DataChanged;
begin
  inherited DataChanged;
end;

procedure TRADBLookupTreeViewTree.Change2(Node: TTreeNode);
begin
  with Owner as TRADBLookupTreeView do
    if not InKeyValueChanged then begin
      FListLink.DataSet.Locate(MasterField, (Node as TRADBTreeNode).MasterValue, []);
      SelectKeyValue(FKeyField.Value);
      KeyValueChanged;
    end;
end;

procedure TRADBLookupTreeViewTree.DefaultHandler(var Message);
begin
  inherited DefaultHandler(Message);
  with TMessage(Message) do
    case Msg of
      WM_KEYDOWN, WM_KEYUP, WM_CHAR,
      WM_LBUTTONDOWN, WM_LBUTTONUP, WM_RBUTTONDOWN, WM_RBUTTONUP, WM_MBUTTONDOWN, WM_MBUTTONUP,
      WM_MOUSEMOVE
       : PostMessage((Owner as TWinControl).Handle, Msg, WParam, LParam);
    end;
end;


{ Translate properties }

{$IFDEF RA_D4H}
function TRADBLookupTreeView.GetAutoExpand: boolean;
begin
  Result := FTree.AutoExpand;
end;

function TRADBLookupTreeView.GetChangeDelay: integer;
begin
  Result := FTree.ChangeDelay;
end;

function TRADBLookupTreeView.GetHotTrack: boolean;
begin
  Result := FTree.HotTrack;
end;

function TRADBLookupTreeView.GetOnCustomDraw: TTVCustomDrawEvent;
begin
  Result := FTree.OnCustomDraw;
end;

function TRADBLookupTreeView.GetOnCustomDrawItem: TTVCustomDrawItemEvent;
begin
  Result := FTree.OnCustomDrawItem;
end;

function TRADBLookupTreeView.GetOnGetImageIndex: TTVExpandedEvent;
begin
  Result := FTree.OnGetImageIndex;
end;

function TRADBLookupTreeView.GetRowSelect: boolean;
begin
  Result := FTree.RowSelect;
end;

function TRADBLookupTreeView.GetToolTips: boolean;
begin
  Result := FTree.ToolTips;
end;

procedure TRADBLookupTreeView.SetAutoExpand(const Value: boolean);
begin
  FTree.AutoExpand := Value;
end;

procedure TRADBLookupTreeView.SetChangeDelay(const Value: integer);
begin
  FTree.ChangeDelay := Value;
end;

procedure TRADBLookupTreeView.SetHotTrack(const Value: boolean);
begin
  FTree.HotTrack := Value;
end;

procedure TRADBLookupTreeView.SetOnCustomDraw(const Value: TTVCustomDrawEvent);
begin
  FTree.OnCustomDraw := Value;
end;

procedure TRADBLookupTreeView.SetOnCustomDrawItem(const Value: TTVCustomDrawItemEvent);
begin
  FTree.OnCustomDrawItem := Value;
end;

procedure TRADBLookupTreeView.SetOnGetImageIndex(const Value: TTVExpandedEvent);
begin
  FTree.OnGetImageIndex := Value;
end;

procedure TRADBLookupTreeView.SetRowSelect(const Value: boolean);
begin
  FTree.RowSelect := Value;
end;

procedure TRADBLookupTreeView.SetToolTips(const Value: boolean);
begin
  FTree.ToolTips := Value;
end;
{$ENDIF RA_D4H}
{# Translate properties }


end.
