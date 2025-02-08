unit ElDBWideLookupComboGrid;
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

ElDBWideLookupComboGrid unit
----------------------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Variants, StdCtrls, Menus, db, dbctrls,
  eldbctrls,
  LMDTypes,
  ElTree,
  LMDElDBConst,
  ElTreeCombo,
  ElHeader,
  LMDProcs,
  {$IFDEF LMD_UNICODE}
  LMDUnicodeStrings,
  LMDUnicode,
  {$ENDIF}
  ElEditCmds,
  LMDGraphUtils,
  LMDSysIn,
  LMDStrings,
  ElVCLUtils;

type
  TElWideDBLookupComboGrid = class;
  TElWideDBLookUpComboGridControl = class(TDBLookupControl)
  private
    FElDBWideLookupComboGrid: TElWideDBLookupComboGrid;
    FSavedOnUpdateDataEvent: TNotifyEvent;
    FUpdate: Boolean;
    FOldItemIndex: Integer;
    FOldValue: Variant;
    FOldStateChange: TNotifyEvent;
  protected
    FUnicodeMode: TElDBUnicodeMode;
    procedure KeyValueChanged; override;
    procedure UpdateListFields; override;
    procedure ListLinkDataChanged; override;
    procedure StateChange(Sender: TObject);
    procedure SelectCurrent;
    function Select(Value: Integer):Boolean;
    procedure UpdateData(Sender: TObject);
    procedure SetUnicodeMode(Value: TElDBUnicodeMode);
    public
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write SetUnicodeMode default umFieldType;
  published
  property NullValueKey;
  end;

  TElWideDBLookupComboGrid = class(TCustomElTreeCombo)
  private
    FDataLink: TFieldDataLink;
    FElDBWideLookupControl: TElWideDBLookUpComboGridControl;
    FKeyIndex :Integer;
    fNeedUpdate:Boolean;
    fSaveItemIndex :Integer;
    fListFieldNames :String;
    FAutoCompletionBuf: TLMDString;
    FWReadOnly :Boolean;
    fLastAutoComletion: TDateTime;
    FPressedKey: WideString;
    procedure SetNullValueKey(Value : TShortCut);
    function GetNullValueKey:TShortCut;
    procedure SetDataSource(Value: TDataSource);
    procedure SetListSource(Value: TDataSource);
    procedure SetDataFieldName(const Value: string);
    procedure SetListFieldName(const Value: string);
    procedure SetKeyFieldName(const Value: string);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListFieldIndex(Value: integer);
    procedure SetSelected(index: integer; Value: Boolean);
    function GetSelected(index: integer): Boolean;
    function GetField: TField;
    function GetListFieldIndex: integer;
    function GetDataSource: TDataSource;
    function GetListSource: TDataSource;
    function GetListFieldName: string;
    function GetDataFieldName: string;
    function GetKeyFieldName: string;
    function GetKeyValue: Variant;
    function GetWReadOnly: Boolean;
    procedure SetWReadOnly(Const Value:Boolean);
    function GetDBReadOnlyState: Boolean;
  protected
    FUnicodeMode: TElDBUnicodeMode;
    procedure CreateWnd; override;
    procedure DblClickHandler(Sender : TObject); override;
    procedure ActiveChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure SetDropped(Value : Boolean); override;
    procedure ProcessSelect; override;
    function GetDisplayText(Item : TElTreeItem): TLMDString; override;
    procedure ClearAutoCompletionData;
    procedure SetFieldCount(Value: integer);
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure TriggerBeforeCommand(AData: Pointer; AChar: Char; ACommand: TElCommand); override;
    procedure WMImeStartComposition(var Message : TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMImeComposition(var Message: TMessage); message WM_IME_COMPOSITION;
    procedure WMKeyDown( var Message: TWMKeyDown ); message WM_KEYDOWN;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure SetUnicodeMode(Value: TElDBUnicodeMode);
    procedure PaintText(Canvas : TCanvas); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure TreeItemDelete(Sender: TObject; Item: TElTreeItem);virtual;
    procedure DoAutoComplete; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateData;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
//    procedure DoDrawText(Sender : TObject; ACanvas: TCanvas; Index: integer; var Rect: TRect;
//      Flags: LongInt);
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    property ListFieldIndex: integer read GetListFieldIndex write SetListFieldIndex;
    property Field: TField read GetField;
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    property AutoCompletion;
    property ShowLines default true;
    property ShowColumns default True;
    property TreeHorizontalLines default True;
    property VerticalLines default True;
    published
  property NullValueKey:TShortCut read GetNullValueKey write SetNullValueKey default 0;
  property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property DataField: string read GetDataFieldName write SetDataFieldName;
    property ListField: string read GetListFieldName write SetListFieldName;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write SetUnicodeMode
      default umFieldType;
    property ReadOnly: Boolean read GetWReadOnly write SetWReadOnly default False;

    property DisplayReadOnlyOptions;
    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;

    property ButtonEnabled;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;

    property OnButtonClick;

    property AltButtonCaption;

    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;

    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AlignBottom;
    property AutoSelect;
    property AutoSize;
    property RightAlignedView;
    property BorderSides;
//    property PasswordChar;
    property MaxLength;
    property Transparent;
    property WantTabs;
    property HandleDialogKeys;
    property HideSelection;
    property TabSpaces;
    property ImageForm;
    property WordWrap;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property StressShortCut;
    property ActiveBorderType;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;

    property Align;
    property Color;
    property Ctl3D;
    property Cursor;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
//    property Text;
    property TabStop;
    property TabOrder;
    property Visible;

    property UseSystemMenu;
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
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;
  end;

var
  cAutoCompletionTimeOut: TDateTime;

implementation
uses
  Types,
  ElEdits;

function IncTime(ATime: TDateTime; Hours, Minutes, Seconds, MSecs: Integer): TDateTime;
begin
  Result := ATime + (Hours div 24) + (((Hours mod 24) * 3600000 +
    Minutes * 60000 + Seconds * 1000 + MSecs) / MSecsPerDay);
  if Result < 0 then
    Result := Result + 1;
end;

function VarEquals(const V1, V2: Variant): Boolean;
begin
  try
    if ( VarIsNull(V1) and (not VarIsNull(V2)) ) or
       ( (not VarIsNull(V1)) and VarIsNull(V2) )
    then
      Result := False
    else
      Result := VarToStr(V1) = VarToStr(V2);
  except
    Result := False;
  end;
end;

{ TElWideDBLookUpComboGridControl }

procedure TElWideDBLookUpComboGridControl.StateChange(Sender: TObject);
begin
  if Assigned(DataSource.DataSet) and Assigned(Field) and (DataSource.DataSet.State = dsBrowse) then
  begin
    FOldValue := Field.Value;
    if Assigned(FElDBWideLookupComboGrid.GetTree.Selected) then
      FOldItemIndex := FElDBWideLookupComboGrid.GetTree.Selected.Index
    else
      FOldItemIndex := -1;
  end;
  if Assigned(FOldStateChange) then
    FOldStateChange(Sender);
end;

function TElWideDBLookUpComboGridControl.ExecuteAction(
  Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataSource<>nil)
    and (DataSource.ExecuteAction(Action));
end;

procedure TElWideDBLookUpComboGridControl.KeyValueChanged;
begin
  if (Assigned(ListLink)) and (ListLink.Active) and (ListLink.RecordCount <> FElDBWideLookupComboGrid.Items.Count) then
    UpdateListFields;
  inherited KeyValueChanged;
  if ListLink.Active and (Assigned(Field)) and (not ListLink.DataSet.IsEmpty) then
  begin
    if (not (Field.FieldKind=fkLookup)) then
    begin
      if (KeyField <> '') then
      begin
  {$IFDEF LMD_UNICODE}
        if (VarToWideStr(ListLink.DataSet.FieldValues[KeyField]) <> VarToWideStr(KeyValue)) then
  {$else}
        if (VarToStr(ListLink.DataSet.FieldValues[KeyField]) <> VarToStr(KeyValue)) then
  {$endif}
          ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);
  {$IFDEF LMD_UNICODE}
        if (VarToWideStr(ListLink.DataSet.FieldValues[KeyField]) = VarToWideStr(KeyValue)) then
  {$else}
        if (VarToStr(ListLink.DataSet.FieldValues[KeyField]) = VarToStr(KeyValue)) then
  {$endif}
        begin
          if Field = nil then
          begin
            FElDBWideLookupComboGrid.SetSelected(ListLink.ActiveRecord, True);
            if Assigned(FElDBWideLookupComboGrid.OnChange) then
              FElDBWideLookupComboGrid.OnChange(FElDBWideLookupComboGrid);
          end
          else
             SelectCurrent;
          if (not ReadOnly) and (FElDBWideLookupComboGrid.Text <>
            FElDBWideLookupComboGrid.Items[ListLink.ActiveRecord].Text)
          then
            FElDBWideLookupComboGrid.Text :=
              FElDBWideLookupComboGrid.Items[ListLink.ActiveRecord].Text;
        end
        else
        begin
          if Assigned(FElDBWideLookupComboGrid.Selection) then
            FElDBWideLookupComboGrid.Selection := nil;
          FElDBWideLookupComboGrid.Text := '';
          if Assigned(FElDBWideLookupComboGrid.OnChange) then
            FElDBWideLookupComboGrid.OnChange(FElDBWideLookupComboGrid);
        end;
      end
      else
      begin
        FElDBWideLookupComboGrid.Selection := nil;
        FElDBWideLookupComboGrid.Text := '';
        FOldValue := Null;
        FOldItemIndex := -1;
      end;
    end
    else
    begin
      if Field.LookupDataSet.Locate(Field.LookupKeyFields,KeyValue,[]) then
        SelectCurrent
      else
      begin
        if Assigned(FElDBWideLookupComboGrid.Selection) then
          FElDBWideLookupComboGrid.Selection := nil;
        FElDBWideLookupComboGrid.Text := '';
        if Assigned(FElDBWideLookupComboGrid.OnChange) then
          FElDBWideLookupComboGrid.OnChange(FElDBWideLookupComboGrid);
      end;
    end;
    if DataSource.DataSet.State = dsBrowse then
    begin
      FOldValue := Field.Value;
      if Assigned(FElDBWideLookupComboGrid.GetTree.Selected) then
        FOldItemIndex := FElDBWideLookupComboGrid.GetTree.Selected.Index
      else
        FOldItemIndex := -1;
    end;
  end
  else
  begin
    FElDBWideLookupComboGrid.Selection := nil;
    FElDBWideLookupComboGrid.Text := '';
    FOldValue := Null;
    FOldItemIndex := -1;
  end;
end;

procedure TElWideDBLookUpComboGridControl.ListLinkDataChanged;
begin
  inherited;
  FElDBWideLookupComboGrid.fNeedUpdate := true;
  if ListLink.RecordCount = 0 then
    FElDBWideLookupComboGrid.Text := '';
end;

function TElWideDBLookUpComboGridControl.Select(Value: Integer): Boolean;
begin
  if ListLink.Active then
  begin
    if Value >= 0 then
    begin
      ListLink.ActiveRecord := Value;
//      ListLink.DataSet.Refresh;
      if Assigned(Field) and (not (Field.FieldKind=fkLookup)) then
        SelectKeyValue(ListSource.DataSet.FieldValues[KeyField])
      else
        SelectKeyValue(ListLink.DataSet.fieldbyname(DataSource.DataSet.fieldbyname(DataField).LookupKeyFields).AsVariant);
      FElDBWideLookupComboGrid.SetSelected(Value, True);
      if Assigned(FElDBWideLookupComboGrid.OnChange) then
        FElDBWideLookupComboGrid.OnChange(FElDBWideLookupComboGrid);
      Result := True;
    end
    else
    begin
      Result := False;
    end;
  end
  else
    Result := True;
end;

procedure TElWideDBLookUpComboGridControl.SelectCurrent;
var
  CurRec, index: integer;
  FKeyField: TField;
begin
  if ListLink.Active and (Field<>nil) then
  begin
    CurRec := ListLink.ActiveRecord;
    Index := CurRec;
    if ListLink.RecordCount <> ListLink.DataSet.RecordCount then
      UpdateListFields;
    if (not (Field.FieldKind=fkLookup)) then
    begin
      FKeyField := GetFieldProperty(ListLink.DataSet, Self, KeyField);
      index := -1;
      if Assigned(FKeyField) then
      begin
  //      if FElDBWideLookupComboGrid.MultiSelect then
  //      begin
  //        ListLink.DataSet.DisableControls;
  //        repeat
  //          ListLink.ActiveRecord := i;
  //          bSelected := VarEquals(FKeyField.Value, KeyValue);
  //          if (index<0) and (bSelected) then
  //            index := i;
  //          FElDBWideLookupComboGrid.Selected[i] := bSelected;
  //          inc(i);
  //        until (i>=RecCount);
  //        ListLink.ActiveRecord := CurRec;
  //        ListSource.DataSet.EnableControls;
  //      end
  //      else
        if VarEquals(FKeyField.Value, Field.Value) then
          index := CurRec;
      end;
    end
    else
      FKeyField := nil;
    if (not Assigned(FElDBWideLookupComboGrid.Selection)) or (FElDBWideLookupComboGrid.Selection.Index <> index) then
    begin
//      FElDBWideLookupComboGrid.Selected[index] := True;
      FElDBWideLookupComboGrid.SetSelected(index, True);
      if Assigned(FElDBWideLookupComboGrid.OnChange) then
        FElDBWideLookupComboGrid.OnChange(FElDBWideLookupComboGrid);
    end;
    if (not (Field.FieldKind=fkLookup)) then
    begin
      if (index<0) and (not VarEquals(FKeyField.Value, KeyValue)) then
      begin
        FElDBWideLookupComboGrid.Selection := nil;
        FElDBWideLookupComboGrid.Text := '';
        if Assigned(FElDBWideLookupComboGrid.OnChange) then
          FElDBWideLookupComboGrid.OnChange(FElDBWideLookupComboGrid);
      end;
    end;
  end;
end;

procedure TElWideDBLookUpComboGridControl.SetUnicodeMode(
  Value: TElDBUnicodeMode);
begin
  if FUnicodeMode <> Value then
  begin
    FUnicodeMode := Value;
    if HandleAllocated and Visible then
      Invalidate;
  end;
end;

function TElWideDBLookUpComboGridControl.UpdateAction(
  Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataSource<>nil)
    and (DataSource.UpdateAction(Action));
end;

procedure TElWideDBLookUpComboGridControl.UpdateData(Sender: TObject);
begin
  if FUpdate then
    exit;
  if Assigned(FSavedOnUpdateDataEvent) then
    FSavedOnUpdateDataEvent(Sender);
  if (ListLink <> nil) and (ListLink.DataSet <> nil) and (ListLink.DataSet.FieldValues[KeyField]=KeyValue) then
  begin
    if not Assigned(FElDBWideLookupComboGrid.Selection) then
    begin
      FUpdate := true;
      UpdateListFields;
    end
  end
  else
    FElDBWideLookupComboGrid.fNeedUpdate := True;
end;

procedure TElWideDBLookUpComboGridControl.UpdateListFields;
var
  FListField: TField;
  i, j, RecCount, ActiveRec, FieldCount: integer;
  W : WideString;
  rItem: TElTreeItem;
  cs: TElCellStyle;
begin
  if Assigned(FElDBWideLookupComboGrid) then
  begin
    FElDBWideLookupComboGrid.fNeedUpdate := False;
    inherited UpdateListFields;
    FElDBWideLookupComboGrid.Selection := nil;
    FElDBWideLookupComboGrid.SelectionList.Clear;
    FElDBWideLookupComboGrid.Items.Clear;
    if (ListLink.Active) and
     ( ( (KeyField<>'') {and Assigned(Field)}) or
       ((Field<>nil) and (Field.FieldKind=fkLookup)) ) then
    begin
      if Assigned(Field) and (Field.FieldKind=fkLookup) then
        ListLink.BufferCount := ListLink.DataSet.RecordCount
      else
        ListLink.BufferCount := ListSource.DataSet.RecordCount;
      FElDBWideLookupComboGrid.Enabled := true;
      if (ListLink.RecordCount = 0) then
        exit;
      ListLink.DataSet.DisableControls;
      ActiveRec := ListLink.ActiveRecord;
      RecCount := ListLink.RecordCount;
      FieldCount := ListFields.Count;
      FElDBWideLookupComboGrid.SetFieldCount( FieldCount );
      for i := 0 to ListFields.Count-1 do
      begin
        FElDBWideLookupComboGrid.HeaderSections[i].Text := TField(ListFields[i]).DisplayLabel;
      end;
      // Search KeyField index
      FElDBWideLookupComboGrid.FKeyIndex := -1;
      if KeyField<>'' then
        for i:=0 to ListFields.Count-1 do
        begin
          if CompareText(TField(ListFields[i]).FieldName, KeyField)=0 then
            FElDBWideLookupComboGrid.FKeyIndex := i;
        end;
      i:=0;
      FElDBWideLookupComboGrid.Items.BeginUpdate;
      try
        repeat
          ListLink.ActiveRecord := i;
          j := 0;
          FListField := TField(ListFields.Items[j]);
          if FListField.IsNULL then
            W := ''
          else

  {$ifdef LMD_UNICODE}
          if ((UnicodeMode = umForceUTF8) or ((FListField.DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
             (LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(FListField.DisplayText), W, strictConversion, false) <> sourceIllegal)
          then
          else
  {$endif}
          begin
            if (FListField.DataType = ftWideString) then
              W := FListField.Value
            else
              W := FListField.DisplayText;
          end;
          rItem := FElDBWideLookupComboGrid.Items.AddChild(nil,W);
          rItem.MainStyle.OwnerProps := false;
          rItem.UseStyles := True;
          for j := 1 to FieldCount-1 do
          begin
            FListField := TField(ListFields.Items[j]);
            if FListField.IsNULL then
              W := ''
            else
  {$ifdef LMD_UNICODE}
            if ((UnicodeMode = umForceUTF8) or ((FListField.DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
               (LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(FListField.DisplayText), W, strictConversion, false) <> sourceIllegal)
            then
            else
  {$endif}
            begin
              if (FListField.DataType = ftWideString) then
                W := FListField.Value
              else
                W := FListField.DisplayText;
            end;
            rItem.ColumnText.Add(W);
            CS := rItem.AddStyle;
            CS.Style := ElhsText;
            if FElDBWideLookupComboGrid.HeaderSections[j].Alignment = hsaLeft then
              CS.TextFlags := DT_LEFT;
            if FElDBWideLookupComboGrid.HeaderSections[j].Alignment = hsaCenter then
              CS.TextFlags := DT_CENTER;
            if FElDBWideLookupComboGrid.HeaderSections[j].Alignment = hsaRight then
              CS.TextFlags := DT_RIGHT;
            if FListField.DataType = ftGraphic then
            begin
              CS.CellType := sftPicture;
              if FListField.IsBlob then
              begin
                FElDBWideLookupComboGrid.ShowImages := True;
                CS.Style := ElhsPictureOnly;
                CS.Picture := TBitmap.Create;
                CS.Picture.Assign(FListField);
                rItem.OwnerHeight := false;
                rItem.Height := CS.Picture.Height;
                if FElDBWideLookupComboGrid.HeaderSections[j].AutoSize then
                  FElDBWideLookupComboGrid.HeaderSections[j].Width := CS.Picture.Width;
              end;
            end;
          end;
          inc(i);
        until i>=RecCount;
      finally
        FElDBWideLookupComboGrid.Items.EndUpdate;
      end;
      // restore data state:
      ListLink.ActiveRecord := ActiveRec;
      ListLink.DataSet.EnableControls;
      // check ItemIndex:
      if Assigned(Field) and ((not Assigned(FElDBWideLookupComboGrid.Selection)) or (FElDBWideLookupComboGrid.Selection.Index <> ListLink.ActiveRecord)
         or
  {$IFDEF LMD_UNICODE}
         (VarToWideStr(ListLink.DataSet.FieldValues[KeyField])<>VarToWideStr(KeyValue)))
  {$else}
         (VarToStr(ListLink.DataSet.FieldValues[KeyField])<>VarToStr(KeyValue)))
  {$endif}
      then
      begin
        if Assigned(Field) and (Field.FieldKind=fkLookup) then
        begin
          Field.LookupDataSet.Locate(Field.LookupKeyFields,KeyValue,[]);
          SelectCurrent;
        end
        else
          FElDBWideLookupComboGrid.Selected[ListLink.ActiveRecord] := True;
//        FElDBWideLookupComboGrid.Selected[FElDBWideLookupComboGrid.ItemIndex] := True;
        if Assigned(Field) and (not (Field.FieldKind=fkLookup)) then
        begin
  {$IFDEF LMD_UNICODE}
          if ( VarToWideStr(ListLink.DataSet.FieldValues[KeyField])<>VarToWideStr(KeyValue) )
  {$else}
          if ( VarToStr(ListLink.DataSet.FieldValues[KeyField])<>VarToStr(KeyValue) )
  {$endif}
             and not
             ( (DataSource=nil) or (DataSource.DataSet=nil) or
               (DataSource.DataSet.FindField(DataField)=nil) )
          then
          begin
            KeyValueChanged;
          end
         end;
        if Assigned(FElDBWideLookupComboGrid.OnChange) then
          FElDBWideLookupComboGrid.OnChange(FElDBWideLookupComboGrid);
      end;
    end
    else
    begin
      FElDBWideLookupComboGrid.Text := '';
      FElDBWideLookupComboGrid.Enabled := false;
      Invalidate;
    end;
    FUpdate := false;
  end;
end;

{ TElWideDBLookupComboGrid }

procedure TElWideDBLookupComboGrid.ActiveChange(Sender: TObject);
begin
//  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElWideDBLookupComboGrid.ClearAutoCompletionData;
begin
  fLastAutoComletion := 0;
  SelStart := 0;
  LeftChar := 0;
  fAutoCompletionBuf := '';
end;

procedure TElWideDBLookupComboGrid.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  Refresh;
end;

procedure TElWideDBLookupComboGrid.CMExit(var Message: TCMExit);
begin
  ClearAutoCompletionData; // need comment this line when debugging of Autocompletion !
  inherited;
end;

constructor TElWideDBLookupComboGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnActiveChange := ActiveChange;
  FElDBWideLookupControl := TElWideDBLookUpComboGridControl.Create(Self);
  FElDBWideLookupControl.FElDBWideLookupComboGrid := Self;
//  FListBox.OnDrawText := DoDrawText;
  inherited MultiSelect:= False;
  GetTree.OnItemDeletion := TreeItemDelete;
  fSaveItemIndex := -1;
  FHasCaret := False;
  LockHeaderHeight := True;
  VerticalLines := True;
  TreeHorizontalLines := True;
  ShowLines := true;
  ShowColumns := True;
  inherited ReadOnly := true;
  FIgnoreReadOnlyState := not DisplayReadOnlyOptions.Enabled;
  FNoCompletion := True;
end;

procedure TElWideDBLookupComboGrid.CreateWnd;
begin
  // problem from DBCtrls.TFieldDataLink.UpdateRightToLeft.
  // if BiDiMode = bdRightToLeft it creates new handle when app. destroing
  if not (csDestroying in ComponentState) then
    inherited;
end;

procedure TElWideDBLookupComboGrid.DefineProperties(Filer: TFiler);
begin
  inherited;
  {if CompareText(ClassName, TElWideDBLookupComboGrid.ClassName)=0 then
  GetElReader.FakeDefineProperty(Filer);
  with GetElReader do
    Filer.DefineProperty('Multiselect', FakeBoolean, nil, false);}
end;

destructor TElWideDBLookupComboGrid.Destroy;
begin
  SetDataSource(nil);
  FDataLink.Free;
  FDataLink := nil;
  FElDBWideLookupControl.FElDBWideLookupComboGrid := nil;
  FElDBWideLookupControl.free;
  FElDBWideLookupControl := nil;
  inherited Destroy;
end;

procedure TElWideDBLookupComboGrid.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not FDataLink.Editing;
  Refresh;
end;

function TElWideDBLookupComboGrid.ExecuteAction(
  Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) and FElDBWideLookupControl.ExecuteAction(Action);
end;

function TElWideDBLookupComboGrid.GetDataFieldName: string;
begin
  Result := FElDBWideLookupControl.DataField;
end;

function TElWideDBLookupComboGrid.GetDataSource: TDataSource;
begin
  Result := FElDBWideLookupControl.DataSource;
end;

function TElWideDBLookupComboGrid.GetDBReadOnlyState: Boolean;
begin
  Result := DBCheckReadOnlyState(FDataLink);
  Result := Result or FElDBWideLookupControl.ReadOnly;
end;

function TElWideDBLookupComboGrid.GetDisplayText(
  Item: TElTreeItem): TLMDString;
begin
  if Assigned(OnGetDisplayText) then
    OnGetDisplayText(Self, Item, Result)
  else
    Result := Item.Text;
end;

function TElWideDBLookupComboGrid.GetField: TField;
begin
  Result := FElDBWideLookupControl.Field;
end;

function TElWideDBLookupComboGrid.GetKeyFieldName: string;
begin
  Result := FElDBWideLookupControl.KeyField;
end;

function TElWideDBLookupComboGrid.GetKeyValue: Variant;
begin
  Result := FElDBWideLookupControl.KeyValue;
end;

function TElWideDBLookupComboGrid.GetListFieldIndex: integer;
begin
  Result := FElDBWideLookupControl.ListFieldIndex;
end;

function TElWideDBLookupComboGrid.GetListFieldName: string;
begin
  Result := fListFieldNames;
end;

function TElWideDBLookupComboGrid.GetListSource: TDataSource;
begin
  Result := FElDBWideLookupControl.ListSource;
end;

function TElWideDBLookupComboGrid.GetNullValueKey: TShortCut;
begin
  Result := FElDBWideLookupControl.NullValueKey;
end;

function TElWideDBLookupComboGrid.GetSelected(index: integer): Boolean;
begin
  Result := Selected[index];
end;

function Canvas_TextWidthW(Canvas:TCanvas; const Text:WideString; uFormat: UINT):Integer;
{$IFDEF LMD_UNICODE}
  var R:Trect;
{$ENDIF}
begin
  {$IFDEF LMD_UNICODE}
  R := Classes.Rect(0,0,0,0);
  if LMDDrawText(Canvas.Handle, Text, Length(Text), R,
    {uFormat or} DT_CALCRECT) <> 0 then
    Result := R.Right - R.Left +1
  else
  {$ENDIF}
  Result := Canvas.TextWidth(Text);
end;

procedure TElWideDBLookupComboGrid.PaintText(Canvas: TCanvas);
  procedure DoDrawText2(Sender : TObject; ACanvas: TCanvas;
      var Rect: TRect; Flags: LongInt);
  var
    //i, TextHeight: integer;
    S, S1: TLMDString;
    R: TRect;
    C1, C2, C3: TColor;
  begin
    //TextHeight := Canvas.TextHeight( '0' );
    S := Text;
    if S<>'' then
    begin
      if {(not Dropped) and}
         (
          (fLastAutoComletion<>0)and
          ((Now - fLastAutoComletion) < cAutoCompletionTimeOut) and
          (Length(fAutoCompletionBuf)>0)
         )
      then
      begin
        S1 := LMDExtractStr(S, 1, Length(fAutoCompletionBuf) );
        if S1<>'' then
        begin
          // save current colors
          C1 := Canvas.Brush.Color;
          C2 := Canvas.Pen.Color;
          C3 := Canvas.Font.Color;
          //.
          R := Rect;
          if RightAlignedText then
          begin
            Dec(Rect.Right, Canvas_TextWidthW(ACanvas, S1, Flags ) + 0);
            R.Left := Rect.Right;
          end
          else
          begin
            Inc(Rect.Left, Canvas_TextWidthW(ACanvas, S1, Flags ) + 0);
            R.Right := Rect.Left;
          end;
          if (HighlightAlphaLevel < 255) then
            LMDAlphaFillRect(Canvas, R, clYellow, HighlightAlphaLevel)
          else
          begin
            Canvas.Brush.Color := clYellow;
            Canvas.FillRect(R);
          end;
          Canvas.Font.Color := clRed;
          SetBkMode(ACanvas.Handle, Windows.TRANSPARENT);
          LMDDrawText(ACanvas.Handle, S1, Length(S1), R, Flags);
          S1 := '';
          // restore colors
          Canvas.Brush.Color := C1;
          Canvas.Pen.Color := C2;
          Canvas.Font.Color := C3;
        end;
      end;
      if S<>'' then
      begin
        SetBkMode(ACanvas.Handle, Windows.TRANSPARENT);
        if (FDisplayReadOnlyOptions.Enabled) and (GetDBReadOnlyState) then
        begin
          if not Focused then
            Canvas.Font.Color := FDisplayReadOnlyOptions.TextColor
          else
            Canvas.Font.Color := FocusedSelectTextColor;
        end;
        LMDDrawText(ACanvas.Handle, S, Length(S), Rect, Flags);
        inc(Rect.Left, Canvas_TextWidthW(ACanvas, S, Flags ) + 5);
      end
      else
        inc(Rect.Left, 5+1);
    end
    else
      inc(Rect.Left, 5);
    if ColorToRGB(Color) <> ColorToRGB(clBtnFace) then
      ACanvas.Pen.Color := clBtnFace
    else
      ACanvas.Pen.Color := clBtnShadow;
    inc(Rect.Left, 5);
  end;
var
  R: TRect;
  Flags :longint;
begin
  R := EditRect;
  InflateRect(R, -1,-1);
  dec(R.Right, 1);
  begin
    Flags := DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
    if RightAlignedText then
    begin
      Flags := Flags or DT_RTLREADING;
      Flags := Flags or DT_RIGHT;
    end;
    if Focused and (not Dropped) then
    begin
      if (HighlightAlphaLevel < 255) then
        LMDAlphaFillRect(Canvas, R, FocusedSelectColor, HighlightAlphaLevel)
      else
      begin
        Canvas.Brush.Color := FocusedSelectColor;
        Canvas.FillRect(R);
      end;
      Canvas.Brush.Color := clBtnFace;
      Canvas.Pen.Color := clWindowFrame;
      Windows.DrawFocusRect(Canvas.Handle, R);
      Canvas.Font.Color := FocusedSelectTextColor;
    end;
    inc(R.Left, 4);
    if ((not Enabled) or ReadOnly) and not Focused then
    begin
      Canvas.Font.Color := DisabledFontColor;
      if Focused then
        Canvas.Brush.Color := DisabledColor;
    end;
    DoDrawText2(Self, Canvas, R, Flags);
  end;
end;

procedure TElWideDBLookupComboGrid.ProcessSelect;
begin
  if not (ReadOnly or GetDBReadOnlyState) then
  begin
    inherited;
    if Assigned(GetTree.Selected) then
      FElDBWideLookupControl.Select(GetTree.Selected.Index);
  end;
  ClearAutoCompletionData;
end;

procedure TElWideDBLookupComboGrid.SetDataFieldName(const Value: string);
begin
  FElDBWideLookupControl.DataField := Value;
  FDataLink.FieldName := Value;
  FElDBWideLookupControl.KeyValueChanged;
end;

procedure TElWideDBLookupComboGrid.SetDataSource(Value: TDataSource);
begin
  if Assigned(FElDBWideLookupControl.DataSource) then
  begin
    FElDBWideLookupControl.DataSource.OnStateChange := FElDBWideLookupControl.FOldStateChange;
    FElDBWideLookupControl.FOldStateChange := nil;
  end;
  FElDBWideLookupControl.DataSource := Value;
  if Assigned(FElDBWideLookupControl.DataSource) then
  begin
    FElDBWideLookupControl.FOldStateChange := FElDBWideLookupControl.DataSource.OnStateChange;
    FElDBWideLookupControl.DataSource.OnStateChange := FElDBWideLookupControl.StateChange;
  end;
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDataLink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  FElDBWideLookupControl.KeyValueChanged;
end;

procedure TElWideDBLookupComboGrid.SetDropped(Value: Boolean);
begin
  if (not HandleAllocated) or (csDestroying in ComponentState) then
  else
  begin
    if Value and fNeedUpdate and (not inherited ReadOnly) then
      FElDBWideLookupControl.UpdateListFields;
    inherited;
  end;
end;

procedure TElWideDBLookupComboGrid.SetFieldCount(Value: integer);
var
  i, hsc: integer;
  hr: TElHeaderSection;
begin
  if Value < 0 then exit;
  hsc := HeaderSections.Count;
  if Value > hsc then
  begin
    for i := hsc to Value - 1 do
    begin
      hr := HeaderSections.AddSection;
      hr.AutoSize := True;
    end;
  end
  else
    if Value < hsc then
    begin
      for i := Value to hsc - 1 do
        HeaderSections.DeleteSection(HeaderSections[Value]);
    end;
  if (HeaderSections.Count > 1) or (TreeHeaderHeight > 0) then
    ShowColumns := True;
  if HeaderSections.Count = 1 then
    HeaderSections[0].Width := Width - GetTree.VScrollBar.Width - 5;
end;

procedure TElWideDBLookupComboGrid.SetKeyFieldName(const Value: string);
begin
  FElDBWideLookupControl.KeyField := Value;
  SetListFieldName(fListFieldNames);
end;

procedure TElWideDBLookupComboGrid.SetKeyValue(const Value: Variant);
begin
  FElDBWideLookupControl.KeyValue := Value;
end;

procedure TElWideDBLookupComboGrid.SetListFieldIndex(Value: integer);
begin
  FElDBWideLookupControl.ListFieldIndex := Value;
end;

procedure TElWideDBLookupComboGrid.SetListFieldName(const Value: string);
begin
  fListFieldNames := Value;
  FElDBWideLookupControl.ListField := Value;
end;

procedure TElWideDBLookupComboGrid.SetListSource(Value: TDataSource);
begin
  if FElDBWideLookupControl.ListSource <> Value then
  begin
    if FElDBWideLookupControl.ListSource <> nil then
    begin
      FElDBWideLookupControl.ListSource.OnUpdateData := FElDBWideLookupControl.FSavedOnUpdateDataEvent;
      FElDBWideLookupControl.FSavedOnUpdateDataEvent := nil;
    end;
    FElDBWideLookupControl.ListSource := Value;
    if Value <> nil then
    begin
      if Assigned(FElDBWideLookupControl.ListSource.OnUpdateData) then
        FElDBWideLookupControl.FSavedOnUpdateDataEvent := FElDBWideLookupControl.ListSource.OnUpdateData
      else
        FElDBWideLookupControl.FSavedOnUpdateDataEvent := nil;
      FElDBWideLookupControl.ListSource.OnUpdateData := FElDBWideLookupControl.UpdateData;
    end;
  end;
end;

procedure TElWideDBLookupComboGrid.SetNullValueKey(Value: TShortCut);
begin
  if Value <> FElDBWideLookupControl.NullValueKey then
    FElDBWideLookupControl.NullValueKey := Value;
end;

procedure TElWideDBLookupComboGrid.SetWReadOnly(const Value: Boolean);
begin
  if FWReadOnly<>Value then
  begin
    FWReadOnly := Value;
//    inherited ReadOnly := GetDBReadOnlyState;
    Invalidate;
  end;
end;

procedure TElWideDBLookupComboGrid.SetSelected(index: integer;
  Value: Boolean);
begin
  if Items.Count > index then
  begin
    text := Items[index].Text;
    Items[index].Selected := Value;
    Items[index].Focused := Value;
    Selection := Items[index];
    if Assigned(GetTree.Selected) then
      GetTree.VScrollBar.Position := GetTree.Selected.Index
    else
      GetTree.VScrollBar.Position := Index;
  end;
end;

procedure TElWideDBLookupComboGrid.SetUnicodeMode(Value: TElDBUnicodeMode);
begin
  if FUnicodeMode <> Value then
  begin
    FUnicodeMode := Value;
    FElDBWideLookupControl.UnicodeMode := Value;
  end;
end;

procedure TElWideDBLookupComboGrid.TreeItemDelete(Sender: TObject;
  Item: TElTreeItem);
var
  i: Integer;
begin
  if Assigned(Item.MainStyle) and Assigned(Item.MainStyle.Picture) then
    Item.MainStyle.Picture.Free;
  for i := 0 to Item.StylesCount - 1 do
  begin
    if Assigned(Item.Styles[i]) and Assigned(Item.Styles[i].Picture) then
      Item.Styles[i].Picture.Free;
  end;
end;

function TElWideDBLookupComboGrid.UpdateAction(
  Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) and FElDBWideLookupControl.UpdateAction(Action);
end;

procedure TElWideDBLookupComboGrid.UpdateData;
begin
  FElDBWideLookupControl.FUpdate := true;
  FElDBWideLookupControl.UpdateListFields;
  ClearAutoCompletionData;
end;

procedure TElWideDBLookupComboGrid.DoAutoComplete;
var
  i, StartPos : integer;
  S, S1: TLMDString;
  key: TLMDChar;
  f: boolean;
begin
  S := fAutoCompletionBuf;
  f := false;
  StartPos := 0;
  if Length(S) > 0 then
  begin
    if (fAutoCompletionBuf='') or not Assigned(GetTree.Selected) then
      StartPos := 0
    else
      StartPos := GetTree.Selected.Index;
    for i := StartPos to Pred(GetTree.Items.Count) do
    begin
      S1 := GetTree.Items[i].Text; // Autocomplete for first field only !
{$IFDEF LMD_UNICODE}
      if LMDUnicodeLower(S) = LMDUnicodeLower(Copy(S1, 1, Length(S))) then
{$ELSE}
      if Lowercase(S) = Lowercase(Copy(S1, 1, Length(S))) then
{$ENDIF}
      begin
//        Text := S1;
        FElDBWideLookupControl.Select(i);
        fLastAutoComletion := Now;
        f := True;
        Break;
      end;
    end;
  end;
  if (not f) and (StartPos > 0) then
  begin
    for i := StartPos - 1 downto 0 do
    begin
      S1 := GetTree.Items[i].Text; // Autocomplete for first field only !
{$IFDEF LMD_UNICODE}
      if LMDUnicodeLower(S) = LMDUnicodeLower(Copy(S1, 1, Length(S))) then
{$ELSE}
      if Lowercase(S) = Lowercase(Copy(S1, 1, Length(S))) then
{$ENDIF}
      begin
        FElDBWideLookupControl.Select(i);
        f := True;
        Break;
      end;
    end;
  end;
  if not f then
  begin
    key := fAutoCompletionBuf[length(fAutoCompletionBuf)];
    FElDBWideLookupControl.ProcessSearchKey(Char(key));
    ClearAutoCompletionData;
    fLastAutoComletion := Now;
    {$IFDEF LMD_UNICODE}
    if LMDWidePos(LMDUnicodeUpper(key), LMDUnicodeUpper(Text)) = 1 then
    {$else}
    if Pos(UpperCase(key), UpperCase(Text)) = 1 then
    {$endif}
      fAutoCompletionBuf := key;
  end;
  invalidate;
end;

procedure TElWideDBLookupComboGrid.WMChar(var Message: TWMChar);
begin
  if not ((
           AutoCompletion and
           (not (ReadOnly or GetDBReadOnlyState)) and
           (Message.CharCode <> VK_BACK)
  )
  and
  (Assigned(DataSource) and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))))
    then
    inherited
  else
  // if AutoCompletion:
  begin
    if ((Message.CharCode = VK_ESCAPE) or (Message.CharCode = VK_RETURN)) or
       (fLastAutoComletion=0)or
       ((Now - fLastAutoComletion) > cAutoCompletionTimeOut)
    then
    begin // Autocompletion timeout
      ClearAutoCompletionData;
      Invalidate;
      if ((Message.CharCode = VK_ESCAPE) or (Message.CharCode = VK_RETURN)) then
        exit;
    end;
    inherited;
    if AutoCompletion then
    begin
      if (not (ReadOnly or GetDBReadOnlyState)) {and (not Dropped)} and (not FElDBWideLookupControl.FUpdate) then
      begin
        if (Message.CharCode in [VK_BACK, VK_ESCAPE]) or (fLastAutoComletion=0) or ((Now - fLastAutoComletion) > cAutoCompletionTimeOut) then
        begin
          ClearAutoCompletionData;
          if not (Message.CharCode in [VK_BACK, VK_ESCAPE]) then
            if FPressedKey > '' then
              FAutoCompletionBuf := FPressedKey
            else
              FAutoCompletionBuf := {$IFDEF LMD_UNICODE}WideChar(Message.CharCode){$ELSE}Char(Message.CharCode){$ENDIF};
        end
        else
        begin
          if FPressedKey > '' then
            FAutoCompletionBuf := FAutoCompletionBuf + FPressedKey
          else
            FAutoCompletionBuf := FAutoCompletionBuf + {$IFDEF LMD_UNICODE}WideChar(Message.CharCode){$ELSE}Char(Message.CharCode){$ENDIF};
        end;
      end;
      DoAutoComplete;
      Invalidate;
      fLastAutoComletion := Now;
    end;
  end;
end;

procedure TElWideDBLookupComboGrid.WMImeStartComposition(var Message : TMessage);
begin
  CaretX := length(FAutoCompletionBuf);
  inherited;
end;

procedure TElWideDBLookupComboGrid.WMImeComposition(var Message: TMessage);
begin
  SetInheritedReadOnly(False);
  inherited;
  SetInheritedReadOnly(True);
  if length(FAutoCompletionBuf) > 0 then
    DoAutoComplete;
end;

procedure TElWideDBLookupComboGrid.TriggerBeforeCommand(AData: Pointer; AChar: Char; ACommand: TElCommand);
begin
  if ACommand = eecWideString then
  begin
    FAutoCompletionBuf := FAutoCompletionBuf + WideString(AData^);
     SetLength(WideString(AData^), 0);
    end;
  inherited TriggerBeforeCommand(AData, AChar, ACommand);
end;

procedure TElWideDBLookupComboGrid.WMKeyDown(var Message: TWMKeyDown);
{$ifdef LMD_UNICODE}
var

    s : WideString;

    Len : Integer;
    ACharCode : integer;
    KeyState: TKeyboardState;
{$endif}
begin
  FPressedKey := '';
  if (not (ReadOnly or GetDBReadOnlyState)) and (Assigned(DataSource)) and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert])) then
  begin
   {$IFDEF LMD_UNICODE}
    if LMDSIWindowsNTUp {and IsSpecialLanguage } then
    begin
      if not (Message.CharCode in [8, 9, 13, 27]) then
      begin
        SetLength(s, 5);
        if GetKeyboardState(KeyState) and ((KeyState[VK_CONTROL] and $80)=0) then
        begin
          ACharCode := Message.CharCode;
          Len := ToUnicode(ACharCode, Message.KeyData, KeyState, PWideChar(s)^, 5, 0);
          if Len > 1 then
          begin
            SetLength(s, Len);
            if (FDeadChar <> #0) then
            begin
              FPressedKey := s;
              end;
          end
          else
          // Dead char support
          if (FDeadChar <> #0) and (Len = 1) then
          begin
            FPressedKey := FDeadCharList.GetDeadChar({$IFNDEF LMDCOMP12}WideChar{$ELSE}char{$ENDIF}(s[1]), FDeadChar);
            if FPressedKey = WideChar(0) then
            begin
              SetLength(s, 2);
              s[2] := s[1];
              s[1] := WideChar(FDeadChar);
              FPressedKey := s;
              end;
            FDeadChar := #0;
          end
          else
          if Len > 0 then
          begin
            SetLength(s, Len);
            FPressedKey := s;
            end;
        end;
      end;
    end;
   {$ENDIF}
   if (Assigned(DataSource.DataSet)) and (DataSource.DataSet.Active) and (NullValueKey <> 0) and (not ReadOnly) and (NullValueKey = ShortCut(Message.CharCode,KeyDataToShiftState(Message.KeyData))) then
    begin
      if Assigned(DataSource.DataSet.FieldByName(DataField)) then
      begin
        DataSource.DataSet.Edit;
        DataSource.DataSet.FieldByName(DataField).Clear;
        FElDBWideLookupControl.KeyValue := null;
      end;
      Message.CharCode := 0;
    end;
  if (not Dropped) and (not FElDBWideLookupControl.FUpdate) then
    begin
      case Message.CharCode of
        VK_DELETE:
          begin
            Message.CharCode := 0;
            SetLength(FAutoCompletionBuf, 0);
            Invalidate;
          end;
        VK_BACK:
          begin
            if AutoCompletion and (fLastAutoComletion<>0) and
              (Length(fAutoCompletionBuf)>0)
            then
            begin
              if Length(fAutoCompletionBuf)>1 then
              begin
//                Message.CharCode := Ord(fAutoCompletionBuf[Length(fAutoCompletionBuf)-1]);
                SetLength(fAutoCompletionBuf, Length(fAutoCompletionBuf)-1);
//                Perform(WM_CHAR, Message.CharCode, 0);
              end
              else
              begin
                SetLength(fAutoCompletionBuf, 0);
              end;
              Message.CharCode := 0;
             Invalidate;
            end;
          end;
        VK_Up:
          if LMDInRange(FElDBWideLookupControl.ListLink.ActiveRecord - 1, 0, Items.Count - 1) then
            FElDBWideLookupControl.Select(FElDBWideLookupControl.ListLink.ActiveRecord - 1);
        VK_Down:
          begin
            if LMDInRange(FElDBWideLookupControl.ListLink.ActiveRecord + 1, 0, Items.Count - 1) then
            begin
              FElDBWideLookupControl.Select(FElDBWideLookupControl.ListLink.ActiveRecord + 1);
            end;
          end;
        VK_ESCAPE:
          begin
            if Assigned(DataSource) and
               Assigned(DataSource.DataSet) and
               DataSource.DataSet.Active and
               ( DataSource.DataSet.State = dsEdit )
            then
              begin
                FElDBWideLookupControl.Field.Value := FElDBWideLookupControl.FOldValue;
                if FElDBWideLookupControl.FOldItemIndex <> -1 then
                  FElDBWideLookupControl.Select(FElDBWideLookupControl.FOldItemIndex)
                else
                  GetTree.Selected := nil;
                ClearAutoCompletionData;
                if Assigned( FOnChange ) then
                  FOnChange( self );
              end;
            Message.CharCode := 0;
            Message.Result := 1;
          end;
      end;
    end
    else
    begin
      if Dropped then
      begin
        case Message.CharCode of
          VK_DOWN, VK_UP, VK_PRIOR, VK_NEXT:
          begin
            inherited;
            if Assigned(GetTree.Selected) then
            begin
              FElDBWideLookupControl.ListLink.ActiveRecord := GetTree.Selected.Index;
              FElDBWideLookupControl.ListLink.DataSet.Refresh;
            end;
          end;
          VK_Escape:
          begin
            if FElDBWideLookupControl.FOldItemIndex <> -1 then
            begin
              FElDBWideLookupControl.ListLink.ActiveRecord := FElDBWideLookupControl.FOldItemIndex;
              FElDBWideLookupControl.ListLink.DataSet.Refresh;
            end;
            GetTree.VScrollBar.Position := FElDBWideLookupControl.FOldItemIndex;
            inherited;
          end;
          VK_RETURN: inherited;
          VK_DELETE:
            begin
              Message.CharCode := 0;
              SetLength(FAutoCompletionBuf, 0);
              Invalidate;
            end;
          VK_BACK:
            begin
              if AutoCompletion and (fLastAutoComletion<>0) and
                (Length(fAutoCompletionBuf)>0)
              then
              begin
                if Length(fAutoCompletionBuf)>1 then
                begin
  //                Message.CharCode := Ord(fAutoCompletionBuf[Length(fAutoCompletionBuf)-1]);
                  SetLength(fAutoCompletionBuf, Length(fAutoCompletionBuf)-1);
  //                Perform(WM_CHAR, Message.CharCode, 0);
                end
                else
                begin
                  SetLength(fAutoCompletionBuf, 0);
                end;
                Message.CharCode := 0;
               Invalidate;
              end;
            end;
        end;
      end;
    end;
  end;
end;

procedure TElWideDBLookupComboGrid.WMMouseWheel(
  var Message: TWMMouseWheel);
var
  Dy: integer;
  sl: integer;
  ItemIndex: integer;
begin
  if (not (ReadOnly or GetDBReadOnlyState)) and (Assigned(DataSource)) and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert])) then
  begin
    if Assigned(GetTree.Selected) then
      ItemIndex := GetTree.Selected.Index
    else
      ItemIndex := -1;
    if Items.Count > 1 then
    begin
      sl := 1;
      Dy := Message.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
      if Dy <> 0 then
      begin
        if Self.Dropped then
        begin
          if LMDInRange(ItemIndex - dy, 0, Items.Count - 1) then
          begin
            GetTree.Selected := GetTree.Items.Item[ItemIndex - dy];
            GetTree.VScrollBar.Position := ItemIndex - dy;
            FElDBWideLookupControl.ListLink.DataSet.MoveBy(GetTree.Selected.Index - FElDBWideLookupControl.ListLink.ActiveRecord);
          end;
        end
        else
        if LMDInRange(ItemIndex - dy, 0, Items.Count - 1) then
        begin
          FElDBWideLookupControl.Select(ItemIndex - dy);
        end;
      end;
    end;
    ClearAutoCompletionData;
    Invalidate;
  end;
end;

procedure TElWideDBLookupComboGrid.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  HideCaret(Handle);
end;

function TElWideDBLookupComboGrid.GetWReadOnly: Boolean;
begin
  Result := FWReadOnly; //FDataLink.ReadOnly;
end;

procedure TElWideDBLookupComboGrid.DblClickHandler(Sender: TObject);
begin
  Dropped := false;
  if Assigned(GetTree.Selected) then
    FElDBWideLookupControl.Select(GetTree.Selected.Index);
  TriggerNewTextSelectionEvent;
  ClearAutoCompletionData;
  SetFocus;
end;

initialization

  cAutoCompletionTimeOut :=
    IncTime(0{TDateTime}, 0{Hours}, 1{Minutes}, 1{Sec}, 500{Ms});
end.
