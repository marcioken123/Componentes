unit LMDDBLookupCtrls;
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

LMDDBLookupCtrls unit
-------------------
Combobox control for new LMDComboBoxExt

Changes
-------
Release 11.0 (November 2010)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,
  DBCtrls, Variants, StdCtrls, LMDCustomExtCombo, LMDTypes, LMDGraphUtils,
  LMDComboBoxExt;

type
  TLMDDBLookupComboBox = class;

  TLMDNotInListEvent = procedure(Sender: TObject; Text: string;  var Accept: boolean) of object;

  TLMDDBLookUpComboControl = class(TDBLookupControl)
  private
    { Private declarations }
    FElDBLookupComboBox: TLMDDBLookupComboBox;
    FSelected: integer;
    FSavedOnUpdateDataEvent: TNotifyEvent;
    FUpdate: Boolean;
  protected
    { Protected declarations }
    procedure KeyValueChanged; override;
    procedure UpdateListFields; override;
    procedure SelectCurrent;
    procedure Select( Value: Integer );
    property Selected: integer read FSelected;
    procedure UpdateData(Sender: TObject);
  public
    { Public declarations }
    function ExecuteAction( Action: TBasicAction ): Boolean; override;
    function UpdateAction( Action: TBasicAction ): Boolean; override;

  published
    { Published declarations }
  end;

  TLMDDBLookupComboBox = class(TLMDComboBoxExt)
  private
    { Private declarations }
    FLMDDBLookupControl: TLMDDBLookupComboControl;
    FSelected: array of Boolean;
    FMaxItems: integer;
    FFieldCount: integer;
    FFields: array of TStrings;
    FFieldWidth: array of integer;
    FReadOnly: boolean;
    FCompleting: boolean;
    FOnNotInList: TLMDNotInListEvent;
    fNeedUpdate:Boolean;
    procedure SetDataSource( Value: TDataSource );
    procedure SetListSource( Value: TDataSource );
    procedure SetDataFieldName( const Value: string );
    procedure SetListFieldName( const Value: string );
    procedure SetKeyFieldName( const Value: string );
    procedure SetKeyValue( const Value: Variant );
    procedure SetListFieldIndex( Value: integer );
    procedure SetSelected( index: integer; Value: Boolean );
    function GetSelected( index: integer ): boolean;
    function GetField: TField;
    function GetListFieldIndex: integer;
    function GetDataSource: TDataSource;
    function GetListSource: TDataSource;
    function GetListFieldName: string;
    function GetDataFieldName: string;
    function GetKeyFieldName: string;
    function GetKeyValue: Variant;
    function GetSelectedString: string;
    function GetFields( Index: integer ): TStrings;
    procedure DoComplete(Accept: Boolean);
    //procedure SetHScrollBarWidth;
    procedure WMMouseWheel( var Message: TWMMouseWheel ); message WM_MOUSEWHEEL;
    procedure CMFontChanged( var Msg: TMessage ); message CM_FONTCHANGED;
    procedure WMKeyDown( var Message: TWMKeyDown ); message WM_KEYDOWN;
  protected
    { Protected declarations }
//    procedure EditWndProc( var Message : TMessage ); override;
//    procedure ListWndProc( var Message : TMessage ); override;
//    procedure DrawItem( Index: Integer; Rect: TRect; State: TOwnerDrawState ); override;
    procedure SetFieldCount( Value: integer );
    procedure ClearFields;
    procedure AddFieldItem( const Value: string; Field: integer );
    property Fields[Index: Integer]: TStrings read GetFields{ write SetField};
    procedure MouseDown( Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer ); override;
    procedure Change; override;
    procedure DoExit; override;
    procedure DropDown; override;

  public
    { Public declarations }
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure UpdateData;
    function ExecuteAction( Action: TBasicAction ): Boolean; override;
    function UpdateAction( Action: TBasicAction ): Boolean; override;
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    property SelectedItem: string read GetSelectedString;
    property ListFieldIndex: integer read GetListFieldIndex write SetListFieldIndex;
    property Field: TField read GetField;
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
  published
    { Published declarations }
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property DataField: string read GetDataFieldName write SetDataFieldName;
    property ListField: string read GetListFieldName write SetListFieldName;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default false;
    property OnNotInList: TLMDNotInListEvent read FOnNotInList write FOnNotInList;

    property Align;
    property Anchors;
    property BiDiMode;
    //    property BtnFlat;
//    property BtnThinFrame;
//    property BtnTransparent;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Font;
    property Flat;
    property Hint;
    property ImeMode;
    property ImeName;
    property ItemIndex stored false;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text stored false;
    property ThemeMode;
    property ThemeGlobalMode;
    property Visible;

    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
//    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
//    property OnMeasureItem;
    property OnStartDock;
    property OnStartDrag;

    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;

    property Items stored false;
  end;

implementation

{$B-}

{ TLMDDBLookupComboControl }

procedure TLMDDBLookupComboControl.KeyValueChanged;
  var
    vItemIndex: Integer;
begin
  vItemIndex := FElDBLookupComboBox.ItemIndex;
  inherited KeyValueChanged;
  if ListLink.Active then
  begin
    if Assigned(Field) and (not (Field.FieldKind=fkLookup)) then
    begin
      try
        if (VarToStr(KeyValue) <> VarToStr(ListLink.DataSet.FieldValues[KeyField]))
           or
           (VarToStr(KeyValue) <> VarToStr(FElDBLookupComboBox.Fields[0][ListLink.ActiveRecord]))
          then
            begin
              ListLink.DataSet.Locate( KeyField, KeyValue, [loCaseInsensitive] );
              if (VarToStr(KeyValue) <> VarToStr(FElDBLookupComboBox.Fields[0][ListLink.ActiveRecord]))
                 and
                 (not FUpdate)
              then 
                begin
                  FUpdate := true;
                  UpdateListFields;
                  ListLink.DataSet.Locate( KeyField, KeyValue, [loCaseInsensitive] );
                end;
            end;
      except
        ListLink.DataSet.Locate( KeyField, KeyValue, [loCaseInsensitive] );
      end;

      if (VarToStr(KeyValue) = VarToStr(ListLink.DataSet.FieldValues[KeyField])) then
      begin
        if Field = nil then
        begin
          FElDBLookupComboBox.ItemIndex := ListLink.ActiveRecord;
          FSelected := ListLink.ActiveRecord;
          if Assigned( FElDBLookupComboBox.OnChange ) then
            FElDBLookupComboBox.OnChange( FElDBLookupComboBox );
        end
        else
          SelectCurrent;
      end
      else
      begin
        FElDBLookupComboBox.ItemIndex := -1;
        FSelected := -1;
        if Assigned( FElDBLookupComboBox.OnChange ) then
          FElDBLookupComboBox.OnChange( FElDBLookupComboBox );
        if vItemIndex <> FElDBLookupComboBox.ItemIndex then
          FElDBLookupComboBox.Invalidate;
      end;
    end
    else
    begin
      FElDBLookupComboBox.ItemIndex := FElDBLookupComboBox.Items.IndexOf(DataSource.DataSet.fieldbyname(DataField).asString);
      FElDBLookupComboBox.Selected[FElDBLookupComboBox.ItemIndex] := True;
      if Assigned(FElDBLookupComboBox.OnChange) then
        FElDBLookupComboBox.OnChange(FElDBLookupComboBox);
    end;
  end;
end;

procedure TLMDDBLookupComboControl.UpdateData(Sender: TObject);
 var j :integer;
begin
  if FUpdate then
    exit;
  if Assigned(FSavedOnUpdateDataEvent) then FSavedOnUpdateDataEvent(Sender);
//  FUpdate := true;
//  UpdateListFields;

  if (ListLink.DataSet.FieldValues[KeyField]=KeyValue) then
    begin
      if FElDBLookupComboBox.ItemIndex = -1 then
        begin
          FUpdate := true;
          UpdateListFields
        end
      else
      if (ListFields.Count>0) then
        begin
          if (FElDBLookupComboBox.Fields[0][ListLink.ActiveRecord] <> KeyValue) then
          begin
            FUpdate := true;
            UpdateListFields
          end else
          begin
            for j := 0 to ListFields.Count-1 do
              if (j <> 0)
                 and
                 ( FElDBLookupComboBox.Fields[j][ListLink.ActiveRecord] <>
                   ( TField( ListFields.Items[j] ).DisplayText) )
              then
                FElDBLookupComboBox.Fields[j][ListLink.ActiveRecord] :=
                  ( TField( ListFields.Items[j] ).DisplayText);
            FElDBLookupComboBox.Invalidate;
          end;
        end
      {}
    end
    else
      FElDBLookupComboBox.fNeedUpdate := True;
end;

procedure TLMDDBLookupComboControl.UpdateListFields;
var
  i, j, RecCount, ActiveRec, FieldCount: integer;
begin
  if Assigned(FElDBLookupComboBox) then
  begin
    FElDBLookupComboBox.fNeedUpdate := False;

    inherited UpdateListFields;
    FElDBLookupComboBox.ClearFields;

    if ListLink.Active and ( (KeyField<>'') or
      ( (Field<>nil) and (Field.FieldKind=fkLookup) )) then
    begin
      if not (Field.FieldKind=fkLookup) then
        ListLink.BufferCount := ListSource.DataSet.RecordCount
      else
        ListLink.BufferCount := ListLink.DataSet.RecordCount;
      ListLink.DataSet.DisableControls;
      i := 0;
      ActiveRec := ListLink.ActiveRecord;
      RecCount := ListLink.RecordCount;
      FieldCount := ListFields.Count;
      FElDBLookupComboBox.SetFieldCount( FieldCount );
      repeat
        ListLink.ActiveRecord := i;
        for j := 0 to FieldCount-1 do
          FElDBLookupComboBox.AddFieldItem( TField( ListFields.Items[j] ).DisplayText, j );
        inc(i);
      until i >= RecCount;

      for j := 0 to FieldCount-1 do
        FElDBLookupComboBox.FFieldWidth[j] := TField( ListFields.Items[j] ).DisplayWidth;

      //FElDBLookupComboBox.SetHScrollBarWidth;
      ListLink.ActiveRecord := ActiveRec;
      if not (Field.FieldKind=fkLookup) then
      begin
    //    if FUpdate then FElDBLookupComboBox.ItemIndex := ActiveRec;
        if (FElDBLookupComboBox.ItemIndex <> ListLink.ActiveRecord)
           or
           (VarToStr(ListLink.DataSet.FieldValues[KeyField])<>VarToStr(KeyValue))
        then
          KeyValueChanged;
      end
      else
      begin
        FElDBLookupComboBox.ItemIndex := FElDBLookupComboBox.Items.IndexOf(DataSource.DataSet.fieldbyname(DataField).asString);
        FElDBLookupComboBox.Selected[FElDBLookupComboBox.ItemIndex] := True;
      end;
      ListLink.DataSet.EnableControls;
  {
      if FElDBLookupComboBox.ItemIndex <> ActiveRec then
      begin
        FElDBLookupComboBox.ItemIndex := ActiveRec;
        if Assigned( FElDBLookupComboBox.OnChange ) then
          FElDBLookupComboBox.OnChange( FElDBLookupComboBox );
      end;
  }
    end;
    FUpdate := false;
  end;
end;

procedure TLMDDBLookupComboControl.SelectCurrent;
var
  i, RecCount, CurRec: integer;
  FKeyField: TField;
begin
  if ListLink.Active and (Field<>nil) then
  begin
    i := 0;
    CurRec := ListLink.ActiveRecord;
    RecCount := ListLink.RecordCount;
    FKeyField := GetFieldProperty( ListLink.DataSet, Self, KeyField );
    ListLink.DataSet.DisableControls;
//    FElDBLookupComboBox.Updating;
    repeat
      ListLink.ActiveRecord := i;
      try
        FElDBLookupComboBox.Selected[i] := FKeyField.Value = Field.Value;
      except
        FElDBLookupComboBox.Selected[i] := false;
      end;
      inc(i);
    until i >= RecCount;
    ListLink.ActiveRecord := CurRec;
//    FElDBLookupComboBox.Updated;
    ListSource.DataSet.EnableControls;
    if FElDBLookupComboBox.ItemIndex <> CurRec then
    begin
      FElDBLookupComboBox.ItemIndex := CurRec;
      FSelected := CurRec;
      if Assigned( FElDBLookupComboBox.OnChange ) then
        FElDBLookupComboBox.OnChange( FElDBLookupComboBox );
    end;

    if (ListLink.DataSet.FieldValues[KeyField]<>KeyValue) then
      FElDBLookupComboBox.ItemIndex := -1;

  end;
end;

procedure TLMDDBLookupComboControl.Select( Value: Integer );
var
  DataSet: TDataSet;
begin
  if (Value>=0) and
     ListLink.Active
  then
  begin
    if Assigned(Field) and (not (Field.FieldKind=fkLookup)) then
    begin
      DataSet := ListSource.DataSet;
      if (Value>=0)and (DataSet.Recordcount>0) then
      begin
        DataSet.Locate(TField( ListFields.Items[0] ).DisplayName,
          FElDBLookupComboBox.Items[Value], []);
        FSelected := Value;
        SelectKeyValue( DataSet.FieldValues[KeyField] );
      end;
    end
    else
    begin
      ListLink.DataSet.Locate(DataSource.DataSet.fieldbyname(DataField).LookupResultField,FElDBLookupComboBox.Items[value],[]);
      SelectKeyValue(ListLink.DataSet.fieldbyname(DataSource.DataSet.fieldbyname(DataField).LookupKeyFields).AsVariant);
    end;
  end;
end;

function TLMDDBLookupComboControl.ExecuteAction( Action: TBasicAction ): Boolean;
begin
  Result := inherited ExecuteAction( Action ) or (DataSource <> nil)
    and ( DataSource.ExecuteAction( Action ) );
end;

function TLMDDBLookupComboControl.UpdateAction( Action: TBasicAction ): Boolean;
begin
  Result := inherited UpdateAction( Action ) or (DataSource <> nil)
    and ( DataSource.UpdateAction( Action ) );
end;

{ TLMDDBLookupComboBox }

constructor TLMDDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  inherited Style := csDropDown;
  FLMDDBLookupControl := TLMDDBLookupComboControl.Create( Self );
  FLMDDBLookupControl.FElDBLookupComboBox := Self;
  FMaxItems := 0;
  FFieldCount := 0;
  FReadOnly := false;
  FCompleting := false;
end;

destructor TLMDDBLookupComboBox.Destroy;
var
  i: integer;
begin
  FLMDDBLookupControl.FElDBLookupComboBox := nil;
  FLMDDBLookupControl.free;
  FLMDDBLookupControl := nil;
  SetLength( FSelected, 0 );
  SetLength( FFieldWidth, 0 );
  for i := 1 to FFieldCount do FFields[i-1].Free;
  SetLength( FFields, 0 );
  inherited Destroy;
end;

procedure TLMDDBLookupComboBox.UpdateData;
begin
  FLMDDBLookupControl.FUpdate := true;
  FLMDDBLookupControl.UpdateListFields;
end;

procedure TLMDDBLookupComboBox.Change;
begin
  inherited;
  if (not FCompleting) and (FLMDDBLookupControl.Selected <> ItemIndex) then
  begin
    FLMDDBLookupControl.Select( ItemIndex );
    if Assigned( OnChange ) then OnChange( Self );
  end;
end;

procedure TLMDDBLookupComboBox.DoExit;
begin
  inherited;
  if FCompleting then DoComplete( true );
end;

procedure TLMDDBLookupComboBox.DropDown;
begin
  if (not HandleAllocated) or (csDestroying in ComponentState) then
    inherited
  else
  begin
    if fNeedUpdate
       or
       (
        Assigned(FLMDDBLookupControl.ListSource) and Assigned(FLMDDBLookupControl.ListSource.DataSet) and
        (FLMDDBLookupControl.ListSource.DataSet.Active) and
        (FLMDDBLookupControl.ListSource.DataSet.RecordCount <> Items.Count)
       )
    then FLMDDBLookupControl.UpdateListFields;
    inherited;
  end;
end;

procedure TLMDDBLookupComboBox.SetDataSource( Value: TDataSource );
begin
  FLMDDBLookupControl.DataSource := Value;
end;

procedure TLMDDBLookupComboBox.SetListSource( Value: TDataSource );
begin
  if FLMDDBLookupControl.ListSource <> Value then
  begin
    if FLMDDBLookupControl.ListSource <> nil then
    begin
      FLMDDBLookupControl.ListSource.OnUpdateData := FLMDDBLookupControl.FSavedOnUpdateDataEvent;
      FLMDDBLookupControl.FSavedOnUpdateDataEvent := nil;
//      FLMDDBLookupControl.ListSource.OnDataChange := nil;
    end;
    FLMDDBLookupControl.ListSource := Value;
    if Value <> nil then
    begin
      if Assigned(FLMDDBLookupControl.ListSource.OnUpdateData) then
        FLMDDBLookupControl.FSavedOnUpdateDataEvent := FLMDDBLookupControl.ListSource.OnUpdateData
      else
        FLMDDBLookupControl.FSavedOnUpdateDataEvent := nil;
      FLMDDBLookupControl.ListSource.OnUpdateData := FLMDDBLookupControl.UpdateData;
//      FLMDDBLookupControl.ListSource.OnDataChange := FLMDDBLookupControl.DataChange;
    end;
  end;
end;

procedure TLMDDBLookupComboBox.SetDataFieldName( const Value: string );
begin
  FLMDDBLookupControl.DataField := Value;
end;

procedure TLMDDBLookupComboBox.SetListFieldName( const Value: string );
begin
  FLMDDBLookupControl.ListField := Value;
end;

procedure TLMDDBLookupComboBox.SetKeyFieldName( const Value: string );
begin
  FLMDDBLookupControl.KeyField := Value;
end;

function TLMDDBLookupComboBox.GetDataSource: TDataSource;
begin
  Result := FLMDDBLookupControl.DataSource;
end;

function TLMDDBLookupComboBox.GetListSource: TDataSource;
begin
  Result := FLMDDBLookupControl.ListSource;
end;

function TLMDDBLookupComboBox.GetListFieldName: string;
begin
  Result := FLMDDBLookupControl.ListField;
end;

function TLMDDBLookupComboBox.GetDataFieldName: string;
begin
  Result := FLMDDBLookupControl.DataField;
end;

function TLMDDBLookupComboBox.GetKeyFieldName: string;
begin
  Result := FLMDDBLookupControl.KeyField;
end;

procedure TLMDDBLookupComboBox.SetKeyValue( const Value: Variant );
begin
  FLMDDBLookupControl.KeyValue := Value;
end;

function TLMDDBLookupComboBox.GetKeyValue: Variant;
begin
  Result := FLMDDBLookupControl.KeyValue;
end;

function TLMDDBLookupComboBox.GetSelectedString: string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to Items.Count-1 do
    if FSelected[i] then Result := Result + Items.Strings[i] + ';';
  if Result <> '' then SetLength( Result, length( Result )-1 );
end;

procedure TLMDDBLookupComboBox.SetListFieldIndex( Value: integer );
begin
  FLMDDBLookupControl.ListFieldIndex := Value;
end;

function TLMDDBLookupComboBox.GetListFieldIndex: integer;
begin
  Result := FLMDDBLookupControl.ListFieldIndex;
end;

function TLMDDBLookupComboBox.GetField: TField;
begin
  Result := FLMDDBLookupControl.Field;
end;

function TLMDDBLookupComboBox.ExecuteAction( Action: TBasicAction ): boolean;
begin
  Result := inherited ExecuteAction( Action ) and FLMDDBLookupControl.ExecuteAction( Action );
end;

function TLMDDBLookupComboBox.UpdateAction( Action: TBasicAction ): boolean;
begin
  Result := inherited UpdateAction( Action ) and FLMDDBLookupControl.UpdateAction( Action );
end;

procedure TLMDDBLookupComboBox.DoComplete(Accept: Boolean);
var
  i: integer;
  ac: boolean;
begin
  FCompleting := false;
  if FReadOnly then exit;
  if Accept then
  begin
    i := Items.IndexOf(Text);
    if i<0 then
    begin
      if Assigned(FOnNotInList) then FOnNotInList(Self, Text, ac);
      if not ac then
      begin
        ItemIndex := FLMDDBLookupControl.Selected;
        Change;
      end
      else
        FCompleting := true;
    end
    else
    begin
      ItemIndex := i;
      Change;
    end;
  end
  else
    ItemIndex := FLMDDBLookupControl.Selected;
end;

function TLMDDBLookupComboBox.GetSelected(index: integer): boolean;
begin
  if (index >= Items.Count) or (index >= FMaxItems) then
    raise ERangeError.CreateFmt( 'Index out of range!', [] )
  else
    Result := FSelected[index];
end;

procedure TLMDDBLookupComboBox.SetSelected( index: integer; Value: Boolean );
begin
  if ( index >= Items.Count ) or ( index >= FMaxItems ) then
    raise ERangeError.CreateFmt( 'Index out of range!', [] )
  else
    FSelected[index] := Value;
end;

//procedure TLMDDBLookupComboBox.EditWndProc( var Message : TMessage );
//begin
//  FCompleting := FCompleting or (Message.Msg = WM_CHAR);
//
//  inherited EditWndProc( Message );
//
//  if Message.Msg = WM_CHAR then
//  case TWMChar(Message).CharCode of
//    VK_RETURN: DoComplete( true );
//    VK_ESCAPE: DoComplete( false );
//  end;
//end;

procedure TLMDDBLookupComboBox.WMKeyDown( var Message: TWMKeyDown );
begin
  if DroppedDown and ((Style = csDropDown)) then
  begin
    FCompleting := false;
    Selected[ItemIndex] := false;
  end;
  inherited;
end;

//procedure TLMDDBLookupComboBox.DrawItem( Index: Integer; Rect: TRect; State: TOwnerDrawState );
//var
//  i: integer;
//  R: TRect;
//  S: String;
//  TextWidth, TextHeight: integer;
//begin
//  Canvas.Font := Font;
//  if FSelected[Index] or (odSelected in State) then
//  begin
//    Canvas.Font.Color := clHighlightText;
//    Canvas.Brush.Color := clHighlight;
//  end;
//
//  if FFieldCount = 1 then inherited;
//
//  if FReadOnly then
//    Canvas.Font.Color := clGrayText;
//
//  if ColorToRGB( Color ) <> ColorToRGB( clBtnFace ) then
//    Canvas.Pen.Color := clBtnFace
//  else
//    Canvas.Pen.Color := clBtnShadow;
//
//  TextWidth := Canvas.TextWidth( '0' );
//  TextHeight := Canvas.TextHeight( '0' );
//  R := Rect;
//  for i := 1 to FFieldCount do
//  begin
//    if FFields[i-1].Count > Index then
//      S := FFields[i-1].Strings[index]
//    else
//      S := '';
//    Canvas.FillRect( R );
//    Canvas.TextOut( R.Left+4, R.Top, S );
//    R.Left := R.Left + FFieldWidth[i-1]*TextWidth;
//    if i < FFieldCount then
//    begin
//      Canvas.MoveTo( R.Left-1, R.Top );
//      Canvas.LineTo( R.Left-1, R.Top + TextHeight+3 );
//    end;
//  end;
//end;

//procedure TLMDDBLookupComboBox.ListWndProc( var Message : TMessage );
//var
//  Index: integer;
//begin
//  if Message.Msg = WM_SIZE then SetHScrollBarWidth;
//  if (Message.Msg = WM_LBUTTONDOWN) and FReadOnly then
//  begin
//    Index := ItemIndex;
//    inherited ListWndProc( Message );
//    ItemIndex := Index
//  end
//  else
//  begin
//    if Message.Msg <> WM_MOUSEMOVE then inherited ListWndProc( Message );
//    if Message.Msg = WM_LBUTTONDOWN then
//    begin
//      if FCompleting then
//        DoComplete( true )
//      else
//        FLMDDBLookupControl.Select( ItemIndex );
//    end;
//  end;
//end;

procedure TLMDDBLookupComboBox.AddFieldItem( const Value: string; Field: integer );
var
  i, count: integer;
begin
  Fields[Field].Add( Value );
  if Field = 0 then
  begin
    Items.Add( Value );
    if FMaxItems <= Items.Count then
    begin
      count := FMaxItems;
      FMaxItems := Items.Count+1;
      SetLength( FSelected, FMaxItems );
      for i := count to FMaxItems do FSelected[i-1] := false;
    end;
  end;
end;

function TLMDDBLookupComboBox.GetFields( Index: integer ): TStrings;
begin
  Result := FFields[Index];
end;

procedure TLMDDBLookupComboBox.SetFieldCount( Value: integer );
var
  i: integer;
begin
  if Value > FFieldCount then
  begin
    SetLength( FFields, Value );
    SetLength( FFieldWidth, Value );
    inc( FFieldCount );
    for i := FFieldCount to Value do FFields[i-1] := TStringList.Create;
    FFieldCount := Value;
  end
  else
    if Value < FFieldCount then
    begin
      for i := Value+1 to FFieldCount do FFields[i-1].Free;
      SetLength( FFields, Value );
      SetLength( FFieldWidth, Value );
      FFieldCount := Value;
    end;
end;

procedure TLMDDBLookupComboBox.ClearFields;
var
  i: integer;
begin
  Items.Clear;
  for i := 1 to FFieldCount do FFields[i-1].Clear;
end;

procedure TLMDDBLookupComboBox.MouseDown( Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin
  if not ReadOnly then inherited MouseDown( Button, Shift, X, Y );
end;

procedure TLMDDBLookupComboBox.WMMouseWheel( var Message: TWMMouseWheel );
var
  idx: integer;
begin
  idx := ItemIndex;
  inherited;
  if idx <> ItemIndex then
  begin
    if FReadOnly then
    begin
      ItemIndex := idx;
      exit;
    end;
    FLMDDBLookupControl.Select( ItemIndex );
    if Assigned( OnChange ) then OnChange( Self );
  end;
end;

//procedure TLMDDBLookupComboBox.SetHScrollBarWidth;
//var
//  ts: string;
//   j: integer;
//begin
//  if HorizontalScroll then
//    begin
//      ts := '';
//      for j := 0 to FFieldCount-1 do ts := ts + StringOfChar( '0', FFieldWidth[j] );
//      Perform( CB_SETHORIZONTALEXTENT, Canvas.TextWidth( ts ), 0 );
//    end
//    else
//      Perform( CB_SETHORIZONTALEXTENT, 0, 0 );
//end;

procedure TLMDDBLookupComboBox.CMFontChanged(var Msg: TMessage);
var
  tm: TLMDTextMetric;
begin
  inherited;
  Canvas.Font.Assign( Font );
  LMDGetTextMetrics( Canvas.Handle, tm );
  Perform( CB_SETITEMHEIGHT, 0, tm.tmHeight );
end;

end.
