unit ElDBWideLookupControls;
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

ElDBWideLookupControls unit
---------------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Variants,
  StdCtrls,
  Menus,
  db,
  dbctrls,
  LMDTypes,
  ElDBCtrls,
  ElListBox,
  ElCombos,
  LMDElDBConst,
  ElTreeCombo,
  ElHeader,
  LMDUnicode,
  {$IFDEF LMD_UNICODE}
  LMDUnicodeStrings,
  {$ENDIF}
  LMDGraphUtils,
  LMDStrings,
  HTMLLbx,
  ElVCLUtils;

{$IFDEF LMD_UNICODE}

type
  TElWideDBLookupListBox = class;
  TElWideDBLookupComboBox = class;

  { TElWideDBLookupListControl }
  TElWideDBLookupListControl = class(TDBLookupControl)
  private
    { Private declarations }
    FElDBWideLookupListBox: TElWideDBLookupListBox;
    FUpdate: Boolean;
    FSavedOnUpdateDataEvent: TNotifyEvent;
    fOLDListState :TDataSetState;
    FOldItemIndex: Integer;
    FOldValue: Variant;
  protected
    { Protected declarations }
    procedure KeyValueChanged; override;
    procedure UpdateListFields; override;
    procedure UpdateBuffer;
    procedure SelectCurrent;
    procedure Select(Value: Integer);
    procedure UpdateData(Sender: TObject);
    procedure ListLinkDataChanged; override;
  public
    { Public declarations }
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    published
    { Published declarations }
  property NullValueKey;
  end;

  { TElWideDBLookUpComboControl }
  TElWideDBLookUpComboControl = class(TDBLookupControl)
  private
    { Private declarations }
    FElDBWideLookupComboBox: TElWideDBLookupComboBox;
    FSavedOnUpdateDataEvent: TNotifyEvent;
    FUpdate: Boolean;
    FOldItemIndex: Integer;
    FOldValue: Variant;
  protected
    { Protected declarations }
    FUnicodeMode: TElDBUnicodeMode;
    procedure KeyValueChanged; override;
    procedure ListLinkDataChanged; override;
    procedure UpdateListFields; override;
    procedure SelectCurrent;
    function Select(Value: Integer):Boolean;
    procedure UpdateData(Sender: TObject);
    procedure SetUnicodeMode(Value: TElDBUnicodeMode);
    public
    { Public declarations }
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write SetUnicodeMode default umFieldType;
  published
  property NullValueKey;
  { Published declarations }
  end;

  //en
  //{$IFNDEF BCB}
  //TOwnerDrawState = ElVCLUtils.TOwnerDrawState;
  //{$ENDIF}

  { TElWideDBLookupListBox }
  TElWideDBLookupListBox = class(TCustomElListBox)
  private
    { Private declarations }
    FOnChange : TNotifyEvent;
    FElDBWideLookupControl: TElWideDBLookupListControl;
    FReadOnly: Boolean;
    FFieldCount: integer;
    FFieldWidth: array of integer;
    procedure SetDataSource(Value: TDataSource);
    procedure SetListSource(Value: TDataSource);
    procedure SetDataFieldName(const Value: string);
    procedure SetListFieldName(const Value: string);
    procedure SetKeyFieldName(const Value: string);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListFieldIndex(Value: integer);
    function GetField: TField;
    function GetListFieldIndex: integer;
    function GetDataSource: TDataSource;
    function GetListSource: TDataSource;
    function GetListFieldName: string;
    function GetDataFieldName: string;
    function GetKeyFieldName: string;
    function GetKeyValue: Variant;
    function GetSelectedString: WideString;
    procedure SetNullValueKey(Value : TShortCut);
    function GetNullValueKey:TShortCut;
    function GetSelected(Index: Integer): Boolean;
  protected
    { Protected declarations }
    FUnicodeMode: TElDBUnicodeMode;
    procedure SetHorizontalExtent; override;
    procedure DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState); override;
    procedure DoDrawText(Sender : TObject; ACanvas: TCanvas; const ACaption: TLMDString;
      var Rect: TRect; Flags: LongInt); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure SetFieldCount(Value: integer);
    procedure ClearFields;
    function GetStyle:TListBoxStyle;
    procedure SetStyle(Value:TListBoxStyle);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMKeyDown( var Message: TWMKeyDown ); message WM_KEYDOWN;
    procedure DefineProperties(Filer: TFiler); override;
    property Selected[Index: Integer]: Boolean read GetSelected;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    property SelectedItem: WideString read GetSelectedString;
    property ListFieldIndex: integer read GetListFieldIndex write SetListFieldIndex;
    property Field: TField read GetField;
    property Items;
    property ItemIndex;
    property MultiSelect;
    property UseXPThemes;
  published
    { Published declarations }
  property NullValueKey:TShortCut read GetNullValueKey write SetNullValueKey default 0;
  property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property DataField: string read GetDataFieldName write SetDataFieldName;
    property ListField: string read GetListFieldName write SetListFieldName;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default false;
    property Style:TListBoxStyle read GetStyle write SetStyle stored false;// emulate as read Only for reading from old dfm resource
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;
    property HideSelection default False;
    // inherited properties:
    property AllowGrayed;
    property BorderStyle;
    property Columns;
    property ExtendedSelect;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelectColor;
    property HideSelectTextColor;
    property IntegralHeight;
    property IncrementalSearchTimeout;
    property ItemHeight;
    property ParentColor;
    property TabWidth;
    property SelCount;
    property TopIndex;
    property ShowCheckBox;
    property ThemeMode;
    property ThemeGlobalMode;

    property ActiveBorderType;
    property Background;
    property BorderSides;
    property Flat;
    property Ctl3D;
    property ParentCtl3D;
    property Font;
    property FlatFocusedScrollBars;
    property HighlightAlphaLevel;
    property HorizontalScroll;
    property Images;
    property AlphaForImages;
    property ImageForm;
    property InactiveBorderType;
    property InvertSelection;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property SelectedFont;
    property ShowLineHint;
    property Transparent;
    property TransparentSelection;
    property UseBackground;
    property UseSelectedFont;
    property TabStop;
    property ParentFont;

    property OnClick;
    property OnCheckStateChange;
    //@+ 2/5/03
    property OnCheckBoxChange;
    //@- 2/5/03
    property OnContextPopup;
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
    property OnResize;
    property OnStartDock;
    property OnStartDrag;

    property Align;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
    property OnDrawItem;
    property OnMeasureItem;
    {< ELSCROLLBAR}
    property UseCustomScrollBars;
    property HorzScrollBarStyles;
    property VertScrollBarStyles;
    {> ELSCROLLBAR}
    property RightAlignedView;
  end;

  { TElWideDBLookupComboBox }
  TElWideDBLookupComboBox = class(TCustomElHTMLComboBox)
  private
    { Private declarations }
    FDataLink: TFieldDataLink;
    FMyOnChange : TNotifyEvent;
    FElDBWideLookupControl: TElWideDBLookUpComboControl;
    FFieldCount: integer;
    FFields: array of TLMDStrings;
    FKeyIndex :Integer;
    FFieldWidth: array of integer;
    fNeedUpdate:Boolean;
    fSaveItemIndex :Integer;
    fListFieldNames :String;
    FWReadOnly :Boolean;
    FAutoCompletionBuf: TLMDString;
    fLastAutoComletion: TDateTime;
    FOldAutoHistoryItemMoveEvent: TElAutoHistoryItemMoveEvent;

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
    procedure SetHScrollBarWidth;
    function GetSelected(index: integer): Boolean;
    function GetField: TField;
    function GetListFieldIndex: integer;
    function GetDataSource: TDataSource;
    function GetListSource: TDataSource;
    function GetListFieldName: string;
    function GetDataFieldName: string;
    function GetKeyFieldName: string;
    function GetKeyValue: Variant;
    function GetSelectedString: WideString;
    function GetFields(Index: integer): TLMDStrings;
    function GetStyle:TComboBoxStyle;
    function GetMultiSelectLookup:Boolean;
    procedure SetMultiSelectLookup(const Value:Boolean);
    procedure SetWReadOnly(Const Value:Boolean);
    procedure SelfAutoHistoryItemMoveEvent(Sender: TObject; const aString:
      TLMDString; const aIdx: Integer);
    function GetDBReadOnlyState: Boolean;
  protected
    { Protected declarations }
    FUnicodeMode: TElDBUnicodeMode;
    procedure ComboKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ActiveChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure ClearAutoCompletionData;
    procedure DoAutoComplete; override;
    procedure SetFieldCount(Value: integer);
    procedure ClearFields;
    procedure AddItem(const Value: TLMDString; Field: integer);
    procedure DoDropDown; override;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMKeyDown( var Message: TWMKeyDown ); message WM_KEYDOWN;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure SetStyle(Value:TComboBoxStyle); reintroduce;
    procedure SetUnicodeMode(Value: TElDBUnicodeMode);
    procedure PaintText(Canvas : TCanvas); override;
    procedure DefineProperties(Filer: TFiler); override;
    property Fields[Index: Integer]:TLMDStrings read GetFields;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DropDown; override;
    procedure CloseUp(AcceptValue: boolean); override;
    procedure UpdateData;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    procedure DoDrawText(Sender : TObject; ACanvas: TCanvas; Index: integer; var Rect: TRect;
      Flags: LongInt);
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    property SelectedItem: WideString read GetSelectedString;
    property ListFieldIndex: integer read GetListFieldIndex write SetListFieldIndex;
    property Field: TField read GetField;
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    property MultiSelect:Boolean read GetMultiSelectLookup write SetMultiSelectLookup
      default false;
    property Items;
    property ItemIndex;
  published
    { Published declarations }
  property NullValueKey:TShortCut read GetNullValueKey write SetNullValueKey default 0;
  property Style:TComboBoxStyle read GetStyle write SetStyle default csDropDown;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property DataField: string read GetDataFieldName write SetDataFieldName;
    property ListField: string read GetListFieldName write SetListFieldName;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write SetUnicodeMode
      default umFieldType;
    property ReadOnly: Boolean read FWReadOnly write SetWReadOnly default False;
    // inherited properties:
    property ButtonArrowColor;
    property OnChange read FMyOnChange write FMyOnChange;

    property IsHTML default False;
    property DisplayReadOnlyOptions;
    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property ListTransparentSelection;
    //property AutoCompletion;
    property AutoCompletion;
    property ListColor;
    property ListImageForm;
    property ListInvertSelection;
    property UseBackground;
    property OnDropDown;
    property AdjustDropDownPos;
    property ShowLineHint;
    property HorizontalScroll;
    property ItemHeight;
    property OnDrawItem;
    property OnMeasureItem;
    property DropDownAlignment;
    property ShowGripper;

    {< ELSCROLLBAR}
    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;
    property RightAlignedView;
    {> ELSCROLLBAR}

    property OnSelect;
    property AutoHistory default False;
    property AutoHistoryDirection;
    property AutoHistoryLimit;
    // property OnAutoCompletion;
    property OnAutoHistoryItemAdd;
    property OnAutoHistoryItemMove;

    // inherited from TCustomElButtonEdit
    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property MaxLength;
    property BorderSides;
    property Transparent;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

    property ImageForm;

    property IncrementalSearchTimeout;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnSelectionChange;
    property OnKeyPressEx;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    // inherited from TCustomElEdit
    property StressShortCut;
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseSystemMenu;

    property Alignment;
    property AutoSelect default true;

    property Background;
    property ButtonCaption;

    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;

    property ButtonColor;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonHint;
    property ButtonOldStyled;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
    property ButtonShowBorder;
    property ButtonVisible;
    property ButtonWidth;

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
    property AltButtonOldStyled;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShowBorder;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;

    property OnEndDock;

    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnStartDock;

    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
    property OnCloseUp;
  end;

var
  cAutoCompletionTimeOut: TDateTime;

{$ENDIF LMD_UNICODE}

implementation
uses
  Types,
  ElEdits;

{$B-}

{$IFDEF LMD_UNICODE}

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

function Canvas_TextWidthW(Canvas:TCanvas; const Text:WideString; uFormat: UINT):Integer;
{$IFDEF LMD_UNICODE}
  var R:Trect;
{$ENDIF}

begin
  {$IFDEF LMD_UNICODE}
  R :=Classes.Rect(0,0,0,0);
  if LMDDrawText(Canvas.Handle, Text, Length(Text), R,
    {uFormat or} DT_CALCRECT) <> 0 then
    Result := R.Right - R.Left +1
  else
  {$ENDIF}
  Result := Canvas.TextWidth(Text);
end;

{ TElWideDBLookupListControl }

procedure TElWideDBLookupListControl.KeyValueChanged;
var
  vItemIndex: Integer;
begin
  vItemIndex := FElDBWideLookupListBox.ItemIndex;
  inherited KeyValueChanged;
  if ListLink.Active and (Assigned(Field)) then
  begin
    if (not (Field.FieldKind=fkLookup)) then
    begin
      try
  {$IFDEF LMD_UNICODE}
        if VarToWideStr(ListLink.DataSet.FieldValues[KeyField])<>VarToWideStr(KeyValue) then
  {$else}
        if VarToStr(ListLink.DataSet.FieldValues[KeyField])<>VarToStr(KeyValue) then
  {$endif}
          ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);
      except
        ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);
      end;
  {$IFDEF LMD_UNICODE}
      if VarToWideStr(ListLink.DataSet.FieldValues[KeyField])=VarToWideStr(KeyValue) then
  {$else}
      if VarToStr(ListLink.DataSet.FieldValues[KeyField])=VarToStr(KeyValue) then
  {$endif}
      begin
        if Field = nil then
        begin
          FElDBWideLookupListBox.ItemIndex := ListLink.ActiveRecord;
          if Assigned(FElDBWideLookupListBox.OnChange) then
            FElDBWideLookupListBox.OnChange(FElDBWideLookupListBox);
        end
        else
          SelectCurrent;
      end
      else
      begin
        FElDBWideLookupListBox.ItemIndex := -1;
        if Assigned(FElDBWideLookupListBox.OnChange) then
          FElDBWideLookupListBox.OnChange(FElDBWideLookupListBox);
        if vItemIndex <> FElDBWideLookupListBox.ItemIndex then
          FElDBWideLookupListBox.Invalidate;
      end;
    end
    else
    begin
      ListLink.DataSet.Locate(DataSource.DataSet.fieldbyname(DataField).LookupKeyFields,FElDBWideLookupListBox.KeyValue,[]);
      SelectCurrent;
    end;
    if DataSource.DataSet.State = dsBrowse then
    begin
      FOldItemIndex := FElDBWideLookupListBox.ItemIndex;
      FOldValue := Field.Value;
    end;
  end
  else
  begin
    FOldItemIndex := -1;
    FOldValue := Null;
  end;
end;

procedure TElWideDBLookupListControl.UpdateData( Sender: TObject);
begin
  if FUpdate then
    exit;
  if Assigned(FSavedOnUpdateDataEvent) then
    FSavedOnUpdateDataEvent(Sender);
  FUpdate := True;
  UpdateListFields;
end;

procedure TElWideDBLookupListControl.UpdateBuffer;
var
  i, RecCount, FieldCount: integer;
  // variables for calc?ulate items text width:
  FListField: TField;
  j, ActiveRec, vFieldWidth: integer;
  W : WideString;
begin
  if ( not(
//          Assigned(DataSource) and Assigned(DataSource.DataSet) and
//          Assigned(DataSource.DataSet.FindField(DataField)) and
//          (not VarIsNull(KeyValue)) and
          Assigned(ListSource) and
          Assigned(ListSource.DataSet) and
          Assigned(ListSource.DataSet.FindField(KeyField))
       )
     ) or (ListFields.Count=0)
  then
  begin
    {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
    if FElDBWideLookupListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    begin
      //initialization of virtual list (problems are possible in Win 9x because of list's elements size limits )
      if FElDBWideLookupListBox.Count >0 then
        FElDBWideLookupListBox.Count := 0; //!!!
    end
    else
    {$ENDIF}
    begin
      if Assigned(Field) and (not (Field.FieldKind=fkLookup)) then
      begin
        if FElDBWideLookupListBox.Items.Count>0 then
          FElDBWideLookupListBox.Items.Clear;
        FElDBWideLookupListBox.ItemIndex := -1;
        ListLink.BufferCount := 0;
        exit;
      end;
    end;
  end;
  // setting up buffer equal to record count
  if assigned(field) and (not (Field.FieldKind=fkLookup)) then
    ListLink.BufferCount := ListSource.DataSet.RecordCount
  else
    ListLink.BufferCount := ListLink.DataSet.RecordCount;
  RecCount := ListLink.RecordCount;
  FieldCount := ListFields.Count;
  FElDBWideLookupListBox.SetFieldCount( FieldCount );
  {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
  if FElDBWideLookupListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    begin
    //initialization of virtual list (problems are possible in Win 9x because of list's elements size limits )
        if FElDBWideLookupListBox.Count <> RecCount then
          FElDBWideLookupListBox.Count := RecCount; //!!!
    end
  else
  {loading elements into the list (inefficient variant)}
  {$ENDIF}
  begin
    // emulation of a pseudo-list:
    // bringing list element count to buffer size
    if FElDBWideLookupListBox.Items.Count<>RecCount then
    begin
      FElDBWideLookupListBox.Items.BeginUpdate;
      try
        if FElDBWideLookupListBox.Items.Count>RecCount then
        //remove redundant pseudo-elements
        begin
           i := (FElDBWideLookupListBox.Items.Count-RecCount); { - how many to delete }
           if i=FElDBWideLookupListBox.Items.Count then
             // remove ALL
             FElDBWideLookupListBox.Items.Clear
           else
           if (i/100*(RecCount)) > 25 then {???: is it really more efficient?}
           begin
           // quantinty of being removed is significantly greater (25%), than if were adding
             FElDBWideLookupListBox.Items.Clear;
             for i:= 1 to RecCount do
               FElDBWideLookupListBox.Items.Add('');
           end
           else
             for i:= 1 to i do
               FElDBWideLookupListBox.Items.Delete(FElDBWideLookupListBox.Items.Count-1)
        end
        else
        // adding missing pseudo-elements
        for i:= 1 to RecCount-FElDBWideLookupListBox.Items.Count do
          FElDBWideLookupListBox.Items.Add('');
      finally
        FElDBWideLookupListBox.Items.EndUpdate;
      end;
    end;
  end;
  // update items text width ->
  ListLink.DataSet.DisableControls;
  ActiveRec := ListLink.ActiveRecord;
  for i := 0 to FieldCount-1 do
      FElDBWideLookupListBox.FFieldWidth[i] := 0;
  i:=0;
  repeat
    ListLink.ActiveRecord := i;
    for j := 0 to FieldCount-1 do
    begin
      FListField := TField(ListFields.Items[j]);
      if FListField.IsNULL then
        W := ''
      else
      if ((FElDBWideLookupListBox.UnicodeMode = umForceUTF8) or ((FListField.DataType <> ftWideString) and (FElDBWideLookupListBox.UnicodeMode = umForceUnicode))) and
         (LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(FListField.DisplayText), W, strictConversion, false) <> sourceIllegal)
      then
      else
      begin
        if (FListField.DataType = ftWideString) then
          W := FListField.Value
        else
          W := FListField.DisplayText;
      end;
     // set ListBox items width (calc max width):
      vFieldWidth := Canvas_TextWidthW(FElDBWideLookupListBox.Canvas, W, 0);
      if vFieldWidth > FElDBWideLookupListBox.FFieldWidth[j] then
        FElDBWideLookupListBox.FFieldWidth[j] := vFieldWidth;
    end;
    inc(i);
  until i>=RecCount;
  // restore data state:
  ListLink.ActiveRecord := ActiveRec;
  ListLink.DataSet.EnableControls;
  for i := 0 to FieldCount-1 do
    inc(FElDBWideLookupListBox.FFieldWidth[i], 7);
  // update horizontal scrollbar:
  if FElDBWideLookupListBox.HorizontalScroll then
    FElDBWideLookupListBox.SetHorizontalExtent;
  // <- update items text width
  if FElDBWideLookupListBox.ItemIndex <> ListLink.ActiveRecord then
    KeyValueChanged;
end;

procedure TElWideDBLookupListControl.UpdateListFields;
begin
  //???FUpdate := True;
  if Assigned(FElDBWideLookupListBox) then
  begin
    try
      inherited UpdateListFields;
    except
      begin
        FElDBWideLookupListBox.Update;
        UpdateBuffer;
        FElDBWideLookupListBox.Updated;
        FUpdate := false;
        if csDesigning in FElDBWideLookupListBox.ComponentState then
          raise
        else
          exit;
      end;
    end;
    FElDBWideLookupListBox.Update;
    try
      if ListLink.Active and ( (KeyField<>'') or
        ( (Field<>nil) and (Field.FieldKind=fkLookup) ))
      then
      begin
        fOLDListState := ListLink.DataSet.State;
        UpdateBuffer;
      end
      else
      begin
        fOLDListState := dsInactive;
        if FElDBWideLookupListBox.Items.Count>0 then
        begin
          {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
          if FElDBWideLookupListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
            FElDBWideLookupListBox.Count := 0
          else
          {$ENDIF}
            FElDBWideLookupListBox.Items.Clear;
          FElDBWideLookupListBox.ItemIndex := -1;
          ListLink.BufferCount := 0;
        end;
      end;
    finally
      FElDBWideLookupListBox.Updated;
      FUpdate := false;
    end;
  end;
end;

procedure TElWideDBLookupListControl.ListLinkDataChanged;
begin
  if (not FUpdate)
      and
     (
       {not scrolling}
       (ListLink.DataSet.State <> dsBrowse) or
       {removal}
       (ListLink.BufferCount <> ListLink.DataSet.RecordCount) or
       {exit from editing on Cancel}
       ( (fOLDListState = dsInsert) and (ListLink.DataSet.State = dsBrowse) )
     )
  then
  begin
    if (ListLink.DataSet.State = dsInsert) then//Insert not post
    begin
       {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
       FElDBWideLookupListBox.Count := FElDBWideLookupListBox.Count +1;
       {$ELSE}
       FElDBWideLookupListBox.Items.BeginUpdate;
       FElDBWideLookupListBox.Items.Add('');
       {$ENDIF}
       ListLink.BufferCount := ListLink.BufferCount+1;
       {$IFNDEF _VIRTUAL_LIST_SUPPORTED_}
       FElDBWideLookupListBox.Items.EndUpdate;
       {$ENDIF}
    end
    else
    if (fOLDListState = dsInsert) and // Cancel
       (ListLink.BufferCount <> ListLink.DataSet.RecordCount)
    then
    begin
       {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
       FElDBWideLookupListBox.Count := FElDBWideLookupListBox.Count -1;
       {$ELSE}
       FElDBWideLookupListBox.Items.BeginUpdate;
       FElDBWideLookupListBox.Items.Delete(FElDBWideLookupListBox.Items.Count-1);
       {$ENDIF}
       ListLink.BufferCount := ListLink.BufferCount-1;
       {$IFNDEF _VIRTUAL_LIST_SUPPORTED_}
       FElDBWideLookupListBox.Items.EndUpdate;
       {$ENDIF}
    end
    else
    begin
      if (ListLink.BufferCount <> ListLink.DataSet.RecordCount) then
        UpdateBuffer;
      FElDBWideLookupListBox.Invalidate;
    end;
  end;
  fOLDListState := ListLink.DataSet.State;
end;

procedure TElWideDBLookupListControl.SelectCurrent;
var
  CurRec: integer;
begin
  if ListLink.Active and (Field<>nil) then
  begin
    CurRec := ListLink.ActiveRecord;
    if FElDBWideLookupListBox.ItemIndex <> CurRec then
    begin
      FElDBWideLookupListBox.ItemIndex := CurRec;
      FElDBWideLookupListBox.Invalidate;
      if Assigned(FElDBWideLookupListBox.OnChange) then
        FElDBWideLookupListBox.OnChange(FElDBWideLookupListBox);
    end;
  end
  else
    FElDBWideLookupListBox.ItemIndex := -1;
end;

procedure TElWideDBLookupListControl.Select(Value: Integer);
begin
  if Assigned(Field) and (Value>=0) and ListLink.Active and (ListLink.ActiveRecord <> Value) then
  begin
    if not (Field.FieldKind=fkLookup) then
    begin
      ListLink.ActiveRecord := Value;
      SelectKeyValue(ListSource.DataSet.FieldValues[KeyField]);
    end
    else
    begin
      ListLink.ActiveRecord := Value;
      SelectKeyValue(ListLink.DataSet.fieldbyname(DataSource.DataSet.fieldbyname(DataField).LookupKeyFields).AsVariant);
    end;
  end;
end;

function TElWideDBLookupListControl.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataSource<>nil) and
    (DataSource.ExecuteAction(Action));
end;

function TElWideDBLookupListControl.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataSource<>nil)
    and (DataSource.UpdateAction(Action));
end;

{ TElWideDBLookupComboControl }

procedure TElWideDBLookupComboControl.KeyValueChanged;
var
  vItemIndex: Integer;
//  FListField: TField;
//  j, FieldCount: integer;
//  W : WideString;
begin
  if (Assigned(ListLink)) and (ListLink.Active) and (ListLink.RecordCount <> FElDBWideLookupComboBox.Items.Count) then
  begin
    UpdateListFields;
  end;
  vItemIndex := FElDBWideLookupComboBox.ItemIndex;
  inherited KeyValueChanged;
//  FElDBWideLookupComboBox.ClearAutoCompletionData;
  if ListLink.Active and (Assigned(Field)) and (not ListLink.DataSet.IsEmpty) and (KeyValue <> Null) then
  begin
    if (not (Field.FieldKind=fkLookup)) then
    begin
      try
        if (ListLink.ActiveRecord>=0) {and  (not ListLink.DataSet.IsEmpty)} and
           (
{$IFDEF LMD_UNICODE}
            (VarToWideStr(ListLink.DataSet.FieldValues[KeyField]) <> VarToWideStr(KeyValue))
            or {possible desynchronizing on insert}
            (VarToWideStr(FElDBWideLookupComboBox.Fields[0][ListLink.ActiveRecord])<>VarToWideStr(KeyValue))
{$else}
            (VarToStr(ListLink.DataSet.FieldValues[KeyField]) <> VarToStr(KeyValue))
            or {possible desynchronizing on insert}
            (VarToStr(FElDBWideLookupComboBox.Fields[0][ListLink.ActiveRecord])<>VarToStr(KeyValue))
{$endif}
           )
        then
        begin
          ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);

{$IFDEF LMD_UNICODE}
          if //(VarToStr(FElDBWideLookupComboBox.Fields[0][ListLink.ActiveRecord])<>VarToStr(KeyValue))
            (VarToWideStr(ListLink.DataSet.FieldValues[KeyField]) <> VarToWideStr(KeyValue)) and (not FUpdate)
{$else}
          if //(VarToStr(FElDBWideLookupComboBox.Fields[0][ListLink.ActiveRecord])<>VarToStr(KeyValue))
            (VarToStr(ListLink.DataSet.FieldValues[KeyField]) <> VarToStr(KeyValue)) and (not FUpdate)
{$endif}
          then {desynchronizing on insert - need to refresh all}
          begin
            FUpdate := true;
            UpdateListFields;
            ListLink.DataSet.Locate( KeyField, KeyValue, [loCaseInsensitive] );
          end;
        end
        else
          ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);
      except
        ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);
      end;
{$IFDEF LMD_UNICODE}
      if (VarToWideStr(ListLink.DataSet.FieldValues[KeyField]) = VarToWideStr(KeyValue)) then
{$else}
      if (VarToStr(ListLink.DataSet.FieldValues[KeyField]) = VarToStr(KeyValue)) then
{$endif}
      begin
        if Field = nil then
        begin
          FElDBWideLookupComboBox.ItemIndex := ListLink.ActiveRecord;
          FElDBWideLookupComboBox.Selected[FElDBWideLookupComboBox.ItemIndex] := True;
          if Assigned(FElDBWideLookupComboBox.FMyOnChange) then
            FElDBWideLookupComboBox.FMyOnChange(FElDBWideLookupComboBox);
        end
        else
           SelectCurrent;
        if (not ReadOnly) and (FElDBWideLookupComboBox.Text <>
          FElDBWideLookupComboBox.Items[FElDBWideLookupComboBox.ItemIndex])
        then
          FElDBWideLookupComboBox.Text :=
            FElDBWideLookupComboBox.Items[FElDBWideLookupComboBox.ItemIndex];
      end
      else
      begin
        FElDBWideLookupComboBox.ItemIndex := -1;
        FElDBWideLookupComboBox.Text := '';
        if Assigned(FElDBWideLookupComboBox.FMyOnChange) then
          FElDBWideLookupComboBox.FMyOnChange(FElDBWideLookupComboBox);
        if vItemIndex <> FElDBWideLookupComboBox.ItemIndex then
          FElDBWideLookupComboBox.Invalidate;
      end;
    end
    else
    begin
      if Field.LookupDataSet.Locate(Field.LookupKeyFields,KeyValue,[]) then
        SelectCurrent
      else
      begin
        FElDBWideLookupComboBox.ItemIndex := -1;
        FElDBWideLookupComboBox.Text := '';
        if Assigned(FElDBWideLookupComboBox.FMyOnChange) then
          FElDBWideLookupComboBox.FMyOnChange(FElDBWideLookupComboBox);
      end;
    end;
    if DataSource.DataSet.State = dsBrowse then
    begin
      FOldItemIndex := FElDBWideLookupComboBox.ItemIndex;
      FOldValue := Field.Value;
    end;
  end
  else
  begin
    FElDBWideLookupComboBox.Text := '';
    FElDBWideLookupComboBox.ItemIndex := -1;
    FOldItemIndex := -1;
    FOldValue := Null;
  end;
end;

procedure TElWideDBLookupComboControl.UpdateData( Sender: TObject );
begin
  if FUpdate then
    exit;
  if Assigned(FSavedOnUpdateDataEvent) then
    FSavedOnUpdateDataEvent(Sender);
  if (ListLink <> nil) and (ListLink.DataSet <> nil) and (ListLink.DataSet.FieldValues[KeyField]=KeyValue) then
  begin
    if FElDBWideLookupComboBox.ItemIndex = -1 then
    begin
      FUpdate := true;
      UpdateListFields
    end
  end
  else
    FElDBWideLookupComboBox.fNeedUpdate := True;
end;

procedure TElWideDBLookupComboControl.UpdateListFields;
var
  FListField: TField;
  i, j, RecCount, ActiveRec, FieldCount, vFieldWidth: integer;
  W : WideString;
begin
  if Assigned(FElDBWideLookupComboBox) then
  begin
    FElDBWideLookupComboBox.fNeedUpdate := False;
    inherited UpdateListFields;
    FElDBWideLookupComboBox.ClearFields;
    if (ListLink.Active) and
     ( ( (KeyField<>'') {and Assigned(Field)}) or
       ((Field<>nil) and (Field.FieldKind=fkLookup)) ) then
    begin
      if Assigned(Field) and (Field.FieldKind=fkLookup) then
        ListLink.BufferCount := ListLink.DataSet.RecordCount
      else
        ListLink.BufferCount := ListSource.DataSet.RecordCount;
      FElDBWideLookupComboBox.Enabled := true;
      if (ListLink.RecordCount = 0) then
        exit;
      ListLink.DataSet.DisableControls;
      ActiveRec := ListLink.ActiveRecord;
      RecCount := ListLink.RecordCount;
      FieldCount := ListFields.Count;
      FElDBWideLookupComboBox.SetFieldCount( FieldCount );
      // Search KeyField index
      FElDBWideLookupComboBox.FKeyIndex := -1;
      if KeyField<>'' then
        for i:=0 to ListFields.Count-1 do
        begin
          if CompareText(TField(ListFields[i]).FieldName, KeyField)=0 then
            FElDBWideLookupComboBox.FKeyIndex := i;
        end;
      // set ListBox items width (clear):
      for j := 0 to FieldCount-1 do
        FElDBWideLookupComboBox.FFieldWidth[j] := 0;
      i:=0;
      FElDBWideLookupComboBox.Items.BeginUpdate;
      try
        repeat
          ListLink.ActiveRecord := i;
          for j := 0 to FieldCount-1 do
          begin
            FListField := TField(ListFields.Items[j]);

            if FListField.IsNULL then
              W := ''
            else
            if ((UnicodeMode = umForceUTF8) or ((FListField.DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
               (LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(FListField.DisplayText), W, strictConversion, false) <> sourceIllegal)
            then
            else
            begin
              if (FListField.DataType = ftWideString) then
                W := FListField.Value
              else
                W := FListField.DisplayText;
            end;
            FElDBWideLookupComboBox.AddItem(W, j);
           // set ListBox items width (calc max width):
            vFieldWidth := Canvas_TextWidthW(FElDBWideLookupComboBox.ListBox.Canvas, W, 0);
            if vFieldWidth > FElDBWideLookupComboBox.FFieldWidth[j] then
              FElDBWideLookupComboBox.FFieldWidth[j] := vFieldWidth;
          end;
          inc(i);
        until i>=RecCount;
      finally
        FElDBWideLookupComboBox.Items.EndUpdate;
      end;
      // set ListBox items width (correct max width):
      for j := 0 to FieldCount-1 do
        inc(FElDBWideLookupComboBox.FFieldWidth[j], 7);
      // Hiden undefined KeyField in ListField:
      if (FElDBWideLookupComboBox.FFieldCount > 1 ) and
        (FElDBWideLookupComboBox.fListFieldNames <> ListField) then
        FElDBWideLookupComboBox.FFieldWidth[FElDBWideLookupComboBox.FFieldCount-1] := 0;
      // set scrollbar width:
      FElDBWideLookupComboBox.SetHScrollBarWidth;
      // restore data state:
      ListLink.ActiveRecord := ActiveRec;
      ListLink.DataSet.EnableControls;
      // check ItemIndex:
      if Assigned(Field) and (not VarIsNull(KeyValue)) and ((FElDBWideLookupComboBox.ItemIndex <> ListLink.ActiveRecord)
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
          if Field.LookupDataSet.Locate(Field.LookupKeyFields,KeyValue,[]) then
            SelectCurrent;
        end
        else
          FElDBWideLookupComboBox.ItemIndex := ListLink.ActiveRecord;
        FElDBWideLookupComboBox.Selected[FElDBWideLookupComboBox.ItemIndex] := True;
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
        FElDBWideLookupComboBox.fSaveItemIndex := FElDBWideLookupComboBox.ItemIndex;
//        if Assigned(FElDBWideLookupComboBox.OnChange) then
//          FElDBWideLookupComboBox.OnChange(FElDBWideLookupComboBox);
      end;
    end
    else
    begin
      FElDBWideLookupComboBox.Text := '';
      FElDBWideLookupComboBox.Enabled := false;
    end;
    FUpdate := false;
  end;
end;

procedure TElWideDBLookupComboControl.SelectCurrent;
var
  i, RecCount, CurRec, index: integer;
  FKeyField: TField;
  bSelected:Boolean;
begin
  if ListLink.Active and (Field<>nil) then
  begin
    i := 0;
    CurRec := ListLink.ActiveRecord;
    Index := CurRec;
    if ListLink.RecordCount <> ListLink.DataSet.RecordCount then
      UpdateListFields;
    RecCount := ListLink.RecordCount;
    if (not (Field.FieldKind=fkLookup)) then
    begin
      FKeyField := GetFieldProperty(ListLink.DataSet, Self, KeyField);
      // optimized ... itemIndex calculating
      index := -1;
      if FElDBWideLookupComboBox.ListBox.MultiSelect then
      begin
        ListLink.DataSet.DisableControls;
        repeat
          ListLink.ActiveRecord := i;
          bSelected := VarEquals(FKeyField.Value, KeyValue);
          if (index<0)and(bSelected) then
            index := i;
          FElDBWideLookupComboBox.Selected[i] := bSelected;
          inc(i);
        until (i>=RecCount);
        ListLink.ActiveRecord := CurRec;
        ListSource.DataSet.EnableControls;
      end
      else
      if VarEquals(FKeyField.Value, Field.Value) then
        index := CurRec;
    end
    else
      FKeyField := nil;
    if FElDBWideLookupComboBox.ItemIndex <> index then
    begin
      FElDBWideLookupComboBox.ItemIndex := index;
//      if FElDBWideLookupComboBox.FListBox.MultiSelect then
      FElDBWideLookupComboBox.Selected[FElDBWideLookupComboBox.ItemIndex] := True;
      if Assigned(FElDBWideLookupComboBox.FMyOnChange) then
        FElDBWideLookupComboBox.FMyOnChange(FElDBWideLookupComboBox);
    end;
    if (not (Field.FieldKind=fkLookup)) then
    begin
      if (index<0) and (not VarEquals(FKeyField.Value, KeyValue)) then
        FElDBWideLookupComboBox.ItemIndex := -1;
    end;
    // Check bug in ElListBox.pas:
    if (FElDBWideLookupComboBox.ItemIndex = -1) and
      (FElDBWideLookupComboBox.Items.Count>0) and
      FElDBWideLookupComboBox.ListBox.MultiSelect
    then
      FElDBWideLookupComboBox.Selected[0] := False;
  end;
end;

function TElWideDBLookupComboControl.Select(Value: Integer):Boolean;
//var
//  DataSet: TDataSet;
begin
  if ListLink.Active and (Value >= 0) then
  begin
    if Assigned(Field) and (not (Field.FieldKind=fkLookup)) then
    begin
//      DataSet := ListSource.DataSet;
//      Result := (Value>=0) and (DataSet.RecordCount>0) and (FElDBWideLookupComboBox.FKeyIndex>=0) and
//        DataSet.Locate(
//          TField(ListFields.Items[FElDBWideLookupComboBox.FKeyIndex]).DisplayName,
//          FElDBWideLookupComboBox.Fields[FElDBWideLookupComboBox.FKeyIndex][Value],
//          []);
//      if Result then
//        SelectKeyValue(DataSet.FieldValues[KeyField]);
      ListLink.ActiveRecord := Value;
      if ListLink.DataSet.Modified then
        ListLink.DataSet.Refresh;
      FElDBWideLookupComboBox.fSaveItemIndex := value;
      SelectKeyValue(ListLink.DataSet.FieldValues[KeyField]);
      if Assigned(FElDBWideLookupComboBox.FMyOnChange) then
        FElDBWideLookupComboBox.FMyOnChange(FElDBWideLookupComboBox);
      Result := True;
    end
    else
    begin
//     if ListLink.DataSet.Locate(DataSource.DataSet.fieldbyname(DataField).LookupResultField,FElDBWideLookupComboBox.Fields[0][value],[]) then
//     begin
      ListLink.ActiveRecord := Value;
      if ListLink.DataSet.Modified then
        ListLink.DataSet.Refresh;
      FElDBWideLookupComboBox.fSaveItemIndex := value;
//      SelectKeyValue(ListLink.DataSet.fieldbyname(DataSource.DataSet.fieldbyname(DataField).LookupKeyFields).AsVariant);
      SelectKeyValue(ListLink.DataSet.FieldValues[DataSource.DataSet.fieldbyname(DataField).LookupKeyFields]);
      if Assigned(FElDBWideLookupComboBox.FMyOnChange) then
        FElDBWideLookupComboBox.FMyOnChange(FElDBWideLookupComboBox);
      Result := True;
//     end
//     else
//     begin
//       FElDBWideLookupComboBox.ItemIndex := -1;
//       Result := false;
//     end;
    end;
  end
  else
    Result := True;
end;

function TElWideDBLookupComboControl.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataSource<>nil)
    and (DataSource.ExecuteAction(Action));
end;

function TElWideDBLookupComboControl.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataSource<>nil)
    and (DataSource.UpdateAction(Action));
end;

procedure TElWideDBLookUpComboControl.SetUnicodeMode(Value: TElDBUnicodeMode);
begin
  if FUnicodeMode <> Value then
  begin
    FUnicodeMode := Value;
    if HandleAllocated and Visible then
      Invalidate;
  end;
end;

procedure TElWideDBLookUpComboControl.ListLinkDataChanged;
begin
  inherited;
  FElDBWideLookupComboBox.fNeedUpdate := true;
  if ListLink.RecordCount = 0 then
  begin
    FElDBWideLookupComboBox.ItemIndex := -1;
    FElDBWideLookupComboBox.Text := '';
  end;
end;

{ TElWideDBLookupListBox }

constructor TElWideDBLookupListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MultiSelect := false;
  FElDBWideLookupControl := TElWideDBLookupListControl.Create(Self);
  FElDBWideLookupControl.FElDBWideLookupListBox := Self;
  FReadOnly := false;
  FFieldCount := 0;
  {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
    inherited Style := lbVirtualOwnerDraw;
  {$ENDIF}
  HideSelection := False;
end;

destructor TElWideDBLookupListBox.Destroy;
begin
  FElDBWideLookupControl.FElDBWideLookupListBox := nil;
  FElDBWideLookupControl.free;
  FElDBWideLookupControl := nil;
  SetLength(FFieldWidth, 0);
  inherited Destroy;
end;

procedure TElWideDBLookupListBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  {if CompareText(ClassName, TElWideDBLookupListBox.ClassName)=0 then
  with GetElReader do
    FakeDefineProperty(Filer);
  with GetElReader do
    Filer.DefineProperty('Multiselect', FakeBoolean, nil, false);}
end;

function TElWideDBLookupListBox.GetStyle:TListBoxStyle;
begin
  Result := inherited Style;
end;

procedure TElWideDBLookupListBox.SetStyle(Value:TListBoxStyle);
begin
end;

procedure TElWideDBLookupListBox.SetDataSource(Value: TDataSource);
begin
  FElDBWideLookupControl.DataSource := Value;
end;

procedure TElWideDBLookupListBox.SetListSource(Value: TDataSource);
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
      FElDBWideLookupControl.ListSource.OnUpdateData := FElDBWideLookupControl.UpdateData
    end;
  end;
end;

procedure TElWideDBLookupListBox.SetDataFieldName(const Value: string);
begin
  FElDBWideLookupControl.DataField := Value;
end;

procedure TElWideDBLookupListBox.SetListFieldName(const Value: string);
begin
  FElDBWideLookupControl.ListField := Value;
end;

procedure TElWideDBLookupListBox.SetKeyFieldName(const Value: string);
begin
  FElDBWideLookupControl.KeyField := Value;
end;

function TElWideDBLookupListBox.GetDataSource: TDataSource;
begin
  Result := FElDBWideLookupControl.DataSource;
end;

function TElWideDBLookupListBox.GetListSource: TDataSource;
begin
  Result := FElDBWideLookupControl.ListSource;
end;

function TElWideDBLookupListBox.GetListFieldName: string;
begin
  Result := FElDBWideLookupControl.ListField;
end;

function TElWideDBLookupListBox.GetDataFieldName: string;
begin
  Result := FElDBWideLookupControl.DataField;
end;

function TElWideDBLookupListBox.GetKeyFieldName: string;
begin
  Result := FElDBWideLookupControl.KeyField;
end;

procedure TElWideDBLookupListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft)and (not ReadOnly) then
    FElDBWideLookupControl.Select(ItemAtPos(Point(X, Y),true));
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TElWideDBLookupListBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  idx: integer;
begin
  if not Focused then
    Windows.SetFocus(Handle);
  if ReadOnly then
    exit;
  idx := ItemIndex;
  MouseDown(mbLeft, [], Message.XPos, Message.YPos);
  if ( idx<>ItemIndex ) and Assigned( FOnChange ) then
    FOnChange( Self );
end;

procedure TElWideDBLookupListBox.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
end;

procedure TElWideDBLookupListBox.SetKeyValue(const Value: Variant);
begin
  FElDBWideLookupControl.KeyValue := Value;
end;

function TElWideDBLookupListBox.GetKeyValue: Variant;
begin
  Result := FElDBWideLookupControl.KeyValue;
end;

function TElWideDBLookupListBox.GetSelectedString: WideString;
var
  i, ActiveRec: integer;
  FKeyField :TField;
begin
  Result := '';
  if Items.Count=0 then
    exit;
  FKeyField := FElDBWideLookupControl.ListLink.DataSet.FindField(FElDBWideLookupControl.KeyField);
  if FKeyField= nil then
    exit;
  ActiveRec := FElDBWideLookupControl.ListLink.ActiveRecord;
  for i := 0 to Items.Count-1 do
    if Selected[i] then
    begin
      FElDBWideLookupControl.ListLink.ActiveRecord := i;
      Result := Result + FKeyField.AsString + ';';
    end;
  FElDBWideLookupControl.ListLink.ActiveRecord := ActiveRec;
  if Result <> '' then
    SetLength( Result, length( Result )-1 );
end;

procedure TElWideDBLookupListBox.SetListFieldIndex(Value: integer);
begin
  FElDBWideLookupControl.ListFieldIndex := Value;
end;

function TElWideDBLookupListBox.GetListFieldIndex: integer;
begin
  Result := FElDBWideLookupControl.ListFieldIndex;
end;

function TElWideDBLookupListBox.GetField: TField;
begin
  Result := FElDBWideLookupControl.Field;
end;

function TElWideDBLookupListBox.ExecuteAction(Action: TBasicAction): boolean;
begin
  Result := inherited ExecuteAction(Action) and FElDBWideLookupControl.ExecuteAction(Action);
end;

function TElWideDBLookupListBox.UpdateAction(Action: TBasicAction): boolean;
begin
  Result := inherited UpdateAction(Action) and FElDBWideLookupControl.UpdateAction(Action);
end;

procedure TElWideDBLookupListBox.WMKeyDown( var Message: TWMKeyDown );
begin
  if not FElDBWideLookupControl.FUpdate then
    case Message.CharCode of
      VK_DOWN:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ItemIndex<Items.Count-1 then
          begin
            FElDBWideLookupControl.Select( ItemIndex+1 );
            if Assigned( FOnChange ) then
              FOnChange( self );
          end;
        end;
      VK_UP:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ItemIndex>0 then
          begin
            FElDBWideLookupControl.Select( ItemIndex-1 );
            if Assigned( FOnChange ) then
              FOnChange( self );
          end;
        end;
      VK_HOME:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ItemIndex>0 then
            begin
              FElDBWideLookupControl.Select( 0 );
            end;
        end;
      VK_END:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ( ItemIndex < Items.Count-1 ) then
            begin
              FElDBWideLookupControl.Select( Items.Count-1 );
            end;
        end;
      VK_PRIOR,VK_NEXT:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ( (Message.CharCode = VK_PRIOR) and ( ItemIndex >0 ) )
             or
             ( (Message.CharCode = VK_NEXT) and ( ItemIndex < Items.Count-1 ) )
          then
            begin
              inherited;
              FElDBWideLookupControl.Select( ItemIndex );
            end;
        end;
      VK_ESCAPE:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if Assigned(DataSource) and
             Assigned(DataSource.DataSet) and
             DataSource.DataSet.Active and
             ( DataSource.DataSet.State = dsEdit )
          then
            begin
              Field.Value := FElDBWideLookupControl.FOldValue;
              if FElDBWideLookupControl.FOldItemIndex <> -1 then
                FElDBWideLookupControl.Select(FElDBWideLookupControl.FOldItemIndex);
              if Assigned( FOnChange ) then
                FOnChange( self );
            end;
        end;
      {VK_RETURN:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if Assigned(DataSource) and
             Assigned(DataSource.DataSet) and
             DataSource.DataSet.Active and
             ( DataSource.DataSet.State in [dsEdit, dsInsert] )
          then
            begin
              DataSource.DataSet.Post;
              //???:
              if Assigned( FOnChange ) then
                FOnChange( self );
              //???:
              Invalidate;
            end;
        end;{}
      else
      begin
        if (Assigned(DataSource.DataSet)) and (DataSource.DataSet.Active) and (NullValueKey <> 0) and (not ReadOnly) and (NullValueKey = ShortCut(Message.CharCode,KeyDataToShiftState(Message.KeyData))) then
        begin
          if Assigned(DataSource.DataSet.FieldByName(DataField)) then
          begin
            DataSource.DataSet.Edit;
            DataSource.DataSet.FieldByName(DataField).Clear;
            FElDBWideLookupControl.KeyValue := null;
          end;
          Message.CharCode := 0;
        end
        else
      inherited;
      end;
    end
  else
    inherited;
end;

procedure TElWideDBLookupListBox.WMPaint(var Message: TWMPaint);
var
  ActiveRec:integer;
begin
  if not HandleAllocated then
    exit;
  if Assigned(FElDBWideLookupControl.ListLink.DataSet) and
     FElDBWideLookupControl.ListLink.DataSet.Active and
     Assigned(DataSource) and Assigned(DataSource.DataSet) and DataSource.DataSet.Active
  then
  begin
      ActiveRec := FElDBWideLookupControl.ListLink.ActiveRecord;
      inherited;
      FElDBWideLookupControl.ListLink.ActiveRecord := ActiveRec;
  end
  else
    inherited;
end;

function TElWideDBLookupListBox.GetSelected(Index: Integer): Boolean;
var
  ActiveRec:Integer;
  FKeyField:TField;
begin
  Items[Index];//check range overflow
  Result := False;
  FKeyField := GetFieldProperty( FElDBWideLookupControl.ListLink.DataSet, Self, KeyField );
  if FKeyField=nil then
    exit;
  ActiveRec := FElDBWideLookupControl.ListLink.ActiveRecord;
  FElDBWideLookupControl.ListLink.DataSet.DisableControls;
  try
    FElDBWideLookupControl.ListLink.ActiveRecord := Index;
    Result := FKeyField.Value = Field.Value;
    FElDBWideLookupControl.ListLink.ActiveRecord := ActiveRec;
  finally
    FElDBWideLookupControl.ListLink.DataSet.EnableControls;
  end;
end;

procedure TElWideDBLookupListBox.DoDrawText(Sender : TObject; ACanvas: TCanvas;
  const ACaption: TLMDString; var Rect: TRect; Flags: LongInt);
var
  i, TextHeight: integer;
  R: TRect;
  S: WideString;
begin
  TextHeight:= Canvas.TextHeight( '0' );
  R := Rect;
  inc(R.Left, 5);
  for i := 1 to FFieldCount do
  begin
    with TField(FElDBWideLookupControl.ListFields.Items[i-1]) do
    begin
      if isNull then
        S := ''
      else

      begin
        if ((UnicodeMode = umForceUTF8) or ((DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
           (LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(DisplayText), S, strictConversion, false) <> sourceIllegal)
        then
        else
        begin
          if DataType = ftWideString then
            S := Value
          else
            S := DisplayText;
        end;
      end;
    end;
    inherited DoDrawText(Sender, ACanvas, S, R, Flags );
    R.Left := R.Left + FFieldWidth[i-1];
    // ??? todo: if matches with background color of a selected item, then line is not seen.
    // Example: painting of a selected item when contorl is not focused
    if ColorToRGB(Color) <> ColorToRGB(clBtnFace) then
      ACanvas.Pen.Color := clBtnFace
    else
      ACanvas.Pen.Color := clBtnShadow;

    if i<FFieldCount then
    begin
      if i>0 then
        ACanvas.MoveTo(R.Left-3, R.Top-3)
      else
        ACanvas.MoveTo(R.Left-3, R.Top);
      if i<FFieldCount then
        ACanvas.LineTo(R.Left-3, R.Top + TextHeight+3)
      else
        ACanvas.LineTo(R.Left-3, R.Top + TextHeight);
    end;
    inc(R.Left, 7);
  end;
end;

procedure TElWideDBLookupListBox.DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState);
begin
 if Index>FElDBWideLookupControl.ListLink.BufferCount then
   exit;
  FElDBWideLookupControl.ListLink.ActiveRecord := Index;
  // Check Selected
  if Assigned(Field) and  (not (Field.FieldKind=fkLookup)) then
  begin
    if Assigned(DataSource) and Assigned(DataSource.DataSet) and
       Assigned(DataSource.DataSet.FindField(DataField)) and
       (not VarIsNull(KeyValue)) and
       Assigned(ListSource.DataSet) and
       Assigned(ListSource.DataSet.FindField(KeyField)) and
       VarEquals( ListSource.DataSet.FindField(KeyField).Value, KeyValue)
    then
    // is selected
    begin
     System.Include(State, odSelected);
     Canvas.Font.Color  := SelectedFont.Color;
     Canvas.Brush.Color := FocusedSelectColor;
    end
    else
    begin
     System.Exclude(State, odSelected);
     Canvas.Font.Color  := Font.Color;
     Canvas.Brush.Color := Color;
    end;
  end
  else
  begin
    if Assigned(DataSource) and Assigned(DataSource.DataSet) and
       Assigned(DataSource.DataSet.FindField(DataField)) and
       (not VarIsNull(KeyValue)) and
       Assigned(FElDBWideLookupControl.ListLink.DataSet) and
       Assigned(FElDBWideLookupControl.ListLink.DataSet.FindField(DataSource.DataSet.fieldbyname(DataField).LookupResultField)) and
       VarEquals(FElDBWideLookupControl.ListLink.DataSet.FindField(DataSource.DataSet.fieldbyname(DataField).LookupKeyFields).Value, KeyValue)
    then
    // is selected
    begin
     System.Include(State, odSelected);
     Canvas.Font.Color  := SelectedFont.Color;
     Canvas.Brush.Color := FocusedSelectColor;
    end
    else
    begin
     System.Exclude(State, odSelected);
     Canvas.Font.Color  := Font.Color;
     Canvas.Brush.Color := Color;
    end;
  end;
  //comment: findex := index;
  inherited DrawItem(Index, R, State);
end;

procedure TElWideDBLookupListBox.SetHorizontalExtent;
var
  j: integer;
begin
  FMaxWidth := 0;
  for j := 0 to FFieldCount-1 do
    inc(FMaxWidth, FFieldWidth[j] + 7);
  inherited;
end;

procedure TElWideDBLookupListBox.SetFieldCount(Value: integer);
begin
  if Value>FFieldCount then
  begin
    SetLength(FFieldWidth, Value);
    inc(FFieldCount);
    FFieldCount := Value;
  end
  else
  if Value<FFieldCount then
  begin
    SetLength(FFieldWidth, Value);
    FFieldCount := Value;
  end;
end;

procedure TElWideDBLookupListBox.ClearFields;
begin
  Items.Clear;
end;

function TElWideDBLookupListBox.GetNullValueKey: TShortCut;
begin
  Result := FElDBWideLookupControl.NullValueKey;
end;

procedure TElWideDBLookupListBox.SetNullValueKey(Value: TShortCut);
begin
  if Value <> FElDBWideLookupControl.NullValueKey then
    FElDBWideLookupControl.NullValueKey := Value;
end;

{ TElWideDBLookupComboBox }

constructor TElWideDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListBox.OnMouseMove := ComboMouseMove;
  FListBox.OnKeyDown := ComboKeyDown;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnActiveChange := ActiveChange;
  FDataLink.OnDataChange := ActiveChange;
  FMyOnChange := FOnChange;
  FOnChange := nil;
  FElDBWideLookupControl := TElWideDBLookUpComboControl.Create(Self);
  FElDBWideLookupControl.FElDBWideLookupComboBox := Self;
  FListBox.OnDrawText := DoDrawText;
  FListBox.MultiSelect:= False;
  FFieldCount := 0;
  fSaveItemIndex := -1;
  FHasCaret := False; //???
  AutoHistory := False;
  FOldAutoHistoryItemMoveEvent := OnAutoHistoryItemMove;
  OnAutoHistoryItemMove := SelfAutoHistoryItemMoveEvent;
  inherited Style := csDropDown;
  inherited ReadOnly := True;
  FIgnoreReadOnlyState := not DisplayReadOnlyOptions.Enabled;
end;

destructor TElWideDBLookupComboBox.Destroy;
var
  i: integer;
begin
  FDataLink.Free;
  FDataLink := nil;
  FElDBWideLookupControl.FElDBWideLookupComboBox := nil;
  FElDBWideLookupControl.free;
  FElDBWideLookupControl := nil;
  SetLength(FFieldWidth, 0);
  for i := 1 to FFieldCount do
    FFields[i-1].Free;
  SetLength(FFields, 0);
  inherited Destroy;
end;

procedure TElWideDBLookupComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
{  if CompareText(ClassName, TElWideDBLookupComboBox.ClassName)=0 then
  with GetElReader do
    FakeDefineProperty(Filer);
  with GetElReader do
    Filer.DefineProperty('Multiselect', FakeBoolean, nil, false);}
end;

function TElWideDBLookupComboBox.GetMultiSelectLookup:Boolean;
begin
  Result := FListBox.MultiSelect;
end;

procedure TElWideDBLookupComboBox.SetMultiSelectLookup(const Value:Boolean);
begin
  FListBox.MultiSelect := Value;
end;

function TElWideDBLookupComboBox.GetStyle:TComboBoxStyle;
begin
  Result := inherited Style;
end;

procedure TElWideDBLookupComboBox.SetStyle(Value:TComboBoxStyle);
begin
  if Value<>csDropDown then
  begin
     if (csDesigning in ComponentState) and
        (not (csReading in ComponentState) )
     then
       raise exception.Create('TElWideDBLookupComboBox support only "csDropDown" mode');
  end
  else
    inherited Style := Value;
end;

procedure TElWideDBLookupComboBox.UpdateData;
begin
  FElDBWideLookupControl.FUpdate := true;
  FElDBWideLookupControl.UpdateListFields;
  ClearAutoCompletionData;
end;

procedure TElWideDBLookupComboBox.SetDataSource(Value: TDataSource);
begin
  FElDBWideLookupControl.DataSource := Value;
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDataLink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElWideDBLookupComboBox.SetListSource(Value: TDataSource);
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

procedure TElWideDBLookupComboBox.SetDataFieldName(const Value: string);
begin
  FElDBWideLookupControl.DataField := Value;
  FDataLink.FieldName := Value;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElWideDBLookupComboBox.SetListFieldName(const Value: string);
begin
  fListFieldNames := Value;
  FElDBWideLookupControl.ListField := Value;
  if Trim(KeyField)<>'' then
  begin
    if pos(';'+LowerCase(KeyField)+';', ';'+LowerCase(Value)+';')=0 then
    begin
      if Trim(Value)<>'' then
        FElDBWideLookupControl.ListField := Value+'; '+KeyField
      else
        FElDBWideLookupControl.ListField := KeyField;
    end;
  end
  else
  begin
    FElDBWideLookupControl.ListField := Value;
  end;
end;

procedure TElWideDBLookupComboBox.SetKeyFieldName(const Value: string);
begin
  FElDBWideLookupControl.KeyField := Value;
  SetListFieldName(fListFieldNames);
end;

function TElWideDBLookupComboBox.GetDataSource: TDataSource;
begin
  Result := FElDBWideLookupControl.DataSource;
end;

function TElWideDBLookupComboBox.GetListSource: TDataSource;
begin
  Result := FElDBWideLookupControl.ListSource;
end;

function TElWideDBLookupComboBox.GetListFieldName: string;
begin
  Result := fListFieldNames;
end;

function TElWideDBLookupComboBox.GetDataFieldName: string;
begin
  Result := FElDBWideLookupControl.DataField;
end;

function TElWideDBLookupComboBox.GetKeyFieldName: string;
begin
  Result := FElDBWideLookupControl.KeyField;
end;

procedure TElWideDBLookupComboBox.SetKeyValue(const Value: Variant);
begin
  FElDBWideLookupControl.KeyValue := Value;
end;

function TElWideDBLookupComboBox.GetKeyValue: Variant;
begin
  Result := FElDBWideLookupControl.KeyValue;
end;

function TElWideDBLookupComboBox.GetSelectedString: WideString;
var
  i: integer;
begin
  Result := '';
  for i:=0 to Items.Count-1 do
    if FListBox.Selected[i] then Result := Result+Items.Strings[i]+';';
  if Result <> '' then SetLength(Result, length(Result)-1);
end;

procedure TElWideDBLookupComboBox.SetListFieldIndex(Value: integer);
begin
  FElDBWideLookupControl.ListFieldIndex := Value;
end;

function TElWideDBLookupComboBox.GetListFieldIndex: integer;
begin
  Result := FElDBWideLookupControl.ListFieldIndex;
end;

function TElWideDBLookupComboBox.GetField: TField;
begin
  Result := FElDBWideLookupControl.Field;
end;

function TElWideDBLookupComboBox.ExecuteAction(Action: TBasicAction): boolean;
begin
  Result := inherited ExecuteAction(Action) and FElDBWideLookupControl.ExecuteAction(Action);
end;

function TElWideDBLookupComboBox.UpdateAction(Action: TBasicAction): boolean;
begin
  Result := inherited UpdateAction(Action) and FElDBWideLookupControl.UpdateAction(Action);
end;

function TElWideDBLookupComboBox.GetSelected(index: integer): Boolean;
begin
  if FListBox.MultiSelect then
    Result := FListBox.Selected[index]
  else
    Result := index = ItemIndex;
end;

procedure TElWideDBLookupComboBox.SetSelected(index: integer; Value: Boolean);
begin
  if FListBox.MultiSelect then
  begin
    if FListBox.Items.Count > index then
      FListBox.Selected[index] := Value;
  end
  else
  begin
   if Value then
     FListBox.ItemIndex := index
   else
    if FListBox.ItemIndex = index then
      FListBox.ItemIndex := -1;
  end;
end;

procedure TElWideDBLookupComboBox.DropDown;
begin
  ClearAutoCompletionData;
  fSaveItemIndex := ItemIndex;
  if Assigned(Field) then
    if not (Field.FieldKind=fkLookup) then
    begin
      if FListBox.MultiSelect then
        TElWideDBLookUpComboControl(FElDBWideLookupControl).SelectCurrent;
    end;
  inherited;
  if fSaveItemIndex>=0 then
    FListBox.TopIndex := fSaveItemIndex;
  if (not Assigned(DataSource)) or (length(DataField)=0) then
    ItemIndex := fSaveItemIndex;
end;

procedure TElWideDBLookupComboBox.CloseUp(AcceptValue: boolean);
begin
  ClearAutoCompletionData;
  if ReadOnly or GetDBReadOnlyState then
    AcceptValue := False;
  if Assigned(DataSource) and (not ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))) then
    AcceptValue := False;
  inherited;
  if Assigned(DataSource) and (fSaveItemIndex <> ItemIndex) then
  begin
    if (AcceptValue) and (not ReadOnly) and FElDBWideLookupControl.Select(ItemIndex) then
    begin
//      if Assigned(OnChange) then
//        OnChange(Self);
      Invalidate;
    end
    else
    begin
        if FListBox.MultiSelect and (ItemIndex>=0) and (ItemIndex<Items.Count) then
          Selected[ItemIndex] := False;
      if (fSaveItemIndex <> -1) then
      begin
        ItemIndex := fSaveItemIndex;
        if FListBox.MultiSelect and (ItemIndex>=0) and (ItemIndex<Items.Count) then
          Selected[ItemIndex] := True;
      end;
    end;
  end;
  if ItemIndex <> -1 then
    Text := Items[ItemIndex];
  HideCaret(Handle);
end;

procedure TElWideDBLookupComboBox.WMMouseWheel( var Message: TWMMouseWheel );
var
  idx: integer;
begin
  if {(not DroppedDown) or} ReadOnly or GetDBReadOnlyState then
    exit;
  idx := FListBox.ItemIndex;
  inherited;
  ClearAutoCompletionData;
  FListBox.Invalidate;
  if idx <> FListBox.ItemIndex then
  begin
    if ReadOnly then
    begin
      ItemIndex := idx;
      exit;
    end;
    FElDBWideLookupControl.ListLink.DataSet.MoveBy(FListBox.ItemIndex - FElDBWideLookupControl.ListLink.ActiveRecord);
    if not DroppedDown then
      FElDBWideLookupControl.Select(FListBox.ItemIndex );
//    if Assigned( OnChange ) then
//      OnChange( Self );
  end;
end;

procedure TElWideDBLookupComboBox.WMKeyDown( var Message: TWMKeyDown );
var
  i:integer;
begin
  if (Assigned(DataSource)) and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert])) then
  begin
   if (Assigned(DataSource.DataSet)) and (DataSource.DataSet.Active) and (NullValueKey <> 0) and (not (ReadOnly or GetDBReadOnlyState)) and (NullValueKey = ShortCut(Message.CharCode,KeyDataToShiftState(Message.KeyData))) then
    begin
      if Assigned(DataSource.DataSet.FieldByName(DataField)) then
      begin
        DataSource.DataSet.Edit;
        DataSource.DataSet.FieldByName(DataField).Clear;
        FElDBWideLookupControl.KeyValue := null;
        FElDBWideLookupControl.Text := '';
      end;
      Message.CharCode := 0;
    end;
  if (not (ReadOnly or GetDBReadOnlyState)) and (not DroppedDown) and (not FElDBWideLookupControl.FUpdate) then
    begin
      case Message.CharCode of
        VK_DELETE:
          begin
            i := ItemIndex;
            DoKeyDown(Message);
            ItemIndex := i;
          end;
        VK_ESCAPE:
          begin
            if Assigned(DataSource) and
               Assigned(DataSource.DataSet) and
               DataSource.DataSet.Active and
               ( DataSource.DataSet.State = dsEdit )
            then
              begin
                Field.Value := FElDBWideLookupControl.FOldValue;
                ItemIndex := FElDBWideLookupControl.FOldItemIndex;
                if ItemIndex <> -1 then
                  FElDBWideLookupControl.Select(ItemIndex);
                ClearAutoCompletionData;
//                if Assigned( FOnChange ) then
//                  FOnChange( self );
              end;
            Message.CharCode := 0;
            Message.Result := 1;
          end;
        else
          if AutoCompletion and ((Length(FAutoCompletionBuf)=0) or ((Now - fLastAutoComletion) > cAutoCompletionTimeOut){or (Pos(UpperCase(FAutoCompletionBuf+Chr(Message.CharCode)),UpperCase(Text))=0)} or DroppedDown) then
          begin
            FElDBWideLookupControl.ProcessSearchKey(Chr(Message.CharCode));
            ClearAutoCompletionData;
            fLastAutoComletion := Now;
          end;
          i := ItemIndex;
          if (Message.CharCode in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT]) then
          begin
            DataSource.DataSet.Edit;
            DoKeyDown(Message);
            FElDBWideLookupControl.Select(ItemIndex);
          end
          else
          begin
            if (not (ReadOnly or GetDBReadOnlyState)) {and (DroppedDown)} then
              DoKeyDown(Message);
            ItemIndex := i;
          end;
      end;
    end
    else
      inherited;
  end
  else
  begin
    if (DroppedDown) and (Message.CharCode in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_Return]) then
    begin
      if Message.CharCode = VK_Return then
      begin
        CloseUp(false);
        ItemIndex := fSaveItemIndex;
      end
      else
        inherited;
    end;
  end;
end;

type
  TElComboListBoxProtected = class(TElComboListBox)
  end;

procedure TElWideDBLookupComboBox.SetWReadOnly(Const Value:Boolean);
begin
  if FWReadOnly<>Value then
  begin
    FWReadOnly := Value;
    inherited ReadOnly := GetDBReadOnlyState;
    Refresh;
    //CanDrop := not FReadOnly;
//    inherited ReadOnly := Value;
  end;
end;

procedure TElWideDBLookupComboBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  S: WideString;
  CurrItemIndex: Integer;
begin
  if ReadOnly and
    (not (Key in [VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR, VK_HOME, VK_END, VK_RETURN,
        VK_ESCAPE, VK_F4]) )
  then
    Key := 0;

  if GetDBReadOnlyState then
    exit;

  if (Key<>0) and (not ReadOnly) and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert])) and
     ( ((not DroppedDown) and (ItemIndex>=0)) or (DroppedDown and (FListBox.ItemIndex>=0)) )
  then
  begin
    if not DroppedDown then
      CurrItemIndex := ItemIndex
    else
      CurrItemIndex := FListBox.ItemIndex;

    if ( [ssAlt, ssCtrl] * Shift = [] )
    then
    begin
      case Key of
        VK_DELETE:
          begin
            Key := 0;
            SetLength(FAutoCompletionBuf, 0);
          end;
        VK_BACK:
          begin
            Key := 0;
            if AutoCompletion and (fLastAutoComletion<>0) and
              (Length(fAutoCompletionBuf)>0)
            then // remove last Autocompletion symbol
            begin
              if Length(fAutoCompletionBuf)>1 then
              begin
//                Key := Ord(fAutoCompletionBuf[Length(fAutoCompletionBuf)-1]);
//                SetLength(fAutoCompletionBuf, Length(fAutoCompletionBuf)-2);
                Key := Ord(fAutoCompletionBuf[Length(fAutoCompletionBuf)-1]);
                SetLength(fAutoCompletionBuf, Length(fAutoCompletionBuf)-1);
              end
              else
              begin
                Key := 0;
                SetLength(fAutoCompletionBuf, Length(fAutoCompletionBuf)-1);
              end;
              //SelStart := SelStart -1;
              if Key <> 0 then
              begin
                Perform(WM_CHAR, VK_RETURN, 0);
                Key := 0;
              end
              else
              begin // If Autocompletion Buff is Empty then Select First Element:
                ClearAutoCompletionData;
                if CurrItemIndex<>0 then
                begin
                  if not DroppedDown then
                  begin
                    FElDBWideLookupControl.Select( 0 );
//                    if Assigned( FOnChange ) then
//                      FOnChange( Self );
                  end
                  else
                  begin
                    FListBox.ItemIndex := 0;
                    FListBox.Invalidate;
                  end;
                end
                else
                begin
                  if not DroppedDown then
                    Invalidate
                  else
                    FListBox.Invalidate;
                end
              end;
            end;
          end;
        VK_Left, VK_Right:
          begin
            if AutoCompletion and (fLastAutoComletion<>0) or ((Now - fLastAutoComletion) < cAutoCompletionTimeOut)
            then
            begin
              // do here
            end;
          end;
      end;
    end
    else
    if AutoCompletion and ( not (ssAlt in Shift)) and (ssCtrl in Shift) then
    begin
      if (fLastAutoComletion=0) or
         ((Now - fLastAutoComletion) > cAutoCompletionTimeOut)
      then
      begin // Autocompletion timeout
        ClearAutoCompletionData;
      end;
      case Key of
        VK_LEFT:
          begin
            Key := 0;
            if Length(fAutoCompletionBuf)>0 then
            begin
              if Length(fAutoCompletionBuf)>1 then
              begin
                //Perform(WM_KEYDOWN, VK_BACK, 0); // if need search first Autocompletion value
                SetLength(fAutoCompletionBuf, Length(fAutoCompletionBuf)-1);
                //SelStart := SelStart -1;
                if not DroppedDown then
                  Invalidate
                else
                with TElComboListBoxProtected(FListBox) do
                begin
                  Canvas.Font := Font;
                  Canvas.Brush := Brush;
                  DrawItem(ItemIndex, ItemRect(ItemIndex), [odSelected]);
                end;
              end
              else
              begin
                ClearAutoCompletionData;
                if not DroppedDown then
                  Invalidate
                else
                with TElComboListBoxProtected(FListBox) do
                begin
                  Canvas.Font := Font;
                  Canvas.Brush := Brush;
                  DrawItem(ItemIndex, ItemRect(ItemIndex), [odSelected]);
                end;
              end;
            end;
          end;
        VK_RIGHT:
          begin
            Key := 0;
            S := GetTextFromItem(CurrItemIndex);
            if (S<>'') then
            begin
              if fAutoCompletionBuf='' then
                S := S[1]
              else
                if (Length(S)>Length(fAutoCompletionBuf))
              then
                S := S[Length(fAutoCompletionBuf)+1]
              else
                S := '';
              if S<>'' then
                Perform(WM_CHAR, Ord(S[1]), 0);
            end;
          end;
      end;
    end;
    (*
    if (Key<>0) then
    begin
      //if DroppedDown and ( [ssAlt, ssCtrl] * Shift <> [] ) and (Key in [VK_DOWN, VK_UP]) then
      //   Key := 0;
      case Key of
        VK_DOWN:
          if not ( (not DroppedDown) and (ssAlt in Shift) ) then
          begin
            if CurrItemIndex<Items.Count-1 then
            begin
              Key := 0;
              if not DroppedDown then
                FElDBWideLookupControl.Select( CurrItemIndex+1 )
              else
                FListBox.ItemIndex := CurrItemIndex+1;
              //ClearAutoCompletionData;
              if (not DroppedDown) and Assigned( FOnChange ) then
                FOnChange( Self );
              if DroppedDown then
              begin
                FListBox.Invalidate;
                // ??? todo: Multiselect in FListBox misbehaves - the value changes itself while browsing !!!
                // therefore is painted as odSelected, although must not
                if Multiselect and (ItemIndex<>CurrItemIndex) and (not FListBox.Selected[CurrItemIndex]) then
                with TElComboListBoxProtected(FListBox) do
                begin
                  Canvas.Font := Font;
                  Canvas.Brush := Brush;
                  DrawItem(CurrItemIndex, ItemRect(CurrItemIndex), [{odSelected}]);
                end;
              end;
            end;
          end;
        VK_UP:
          if not ( (not DroppedDown) and (ssAlt in Shift) ) then
          begin
            if CurrItemIndex>0 then
            begin
              Key := 0;
              if not DroppedDown then
                FElDBWideLookupControl.Select( CurrItemIndex-1 )
              else
                FListBox.ItemIndex := CurrItemIndex-1;
              //ClearAutoCompletionData;
              if (not DroppedDown) and Assigned( FOnChange ) then
                FOnChange( Self );
              if DroppedDown then
              begin
                FListBox.Invalidate;
                if Multiselect and (ItemIndex<>CurrItemIndex) and (not FListBox.Selected[CurrItemIndex]) then
                with TElComboListBoxProtected(FListBox) do
                begin
                  Canvas.Font := Font;
                  Canvas.Brush := Brush;
                  DrawItem(CurrItemIndex, ItemRect(CurrItemIndex), [{odSelected}]);
                end;
              end;
            end;
          end;
        VK_HOME:
          begin
            if CurrItemIndex>0 then
            begin
              Key := 0;
              if not DroppedDown then
                FElDBWideLookupControl.Select( 0 )
              else
                FListBox.ItemIndex := 0;
              ClearAutoCompletionData;
              if (not DroppedDown) and Assigned( FOnChange ) then
                FOnChange( Self );
              if DroppedDown then
              begin
                FListBox.Invalidate;
              end;
            end;
          end;
        VK_END:
          begin
            if ( CurrItemIndex < Items.Count-1 ) then
            begin
              Key := 0;
              if not DroppedDown then
                FElDBWideLookupControl.Select( Items.Count-1 )
              else
                FListBox.ItemIndex := Items.Count-1;
              ClearAutoCompletionData;
              if (not DroppedDown) and Assigned( FOnChange ) then
                FOnChange( Self );
              if DroppedDown then
              begin
                FListBox.Invalidate;
              end;
            end;
          end;
        {
        VK_PRIOR,VK_NEXT:
          begin
            if ( (Key = VK_PRIOR) and ( CurrItemIndex >0 ) )
               or
               ( (Key = VK_NEXT) and ( CurrItemIndex < Items.Count-1 ) )
            then
            begin
              Key := 0;
              if not DroppedDown then
              begin
                Items.BeginUpdate;
                  inherited;
                  FElDBWideLookupControl.Select( ItemIndex );
                  ClearAutoCompletionData;
                Items.EndUpdate;
              end
              else
              begin
                ClearAutoCompletionData;
                inherited;
              end;
              if (not DroppedDown) and Assigned( FOnChange ) then
                FOnChange( Self );
              //if DroppedDown then
                //FListBox.Invalidate;
            end;
          end;
        }
      end;
    end;
    *)
  end
  else
  if ReadOnly and DroppedDown then
  begin
    case Key of
      VK_HOME:
        begin
          if FListBox.ItemIndex>0 then
          begin
            FListBox.ItemIndex := 0;
            FListBox.Invalidate;
            Key := 0;
          end;
        end;
      VK_END:
        begin
          if ( FListBox.ItemIndex < Items.Count-1 ) then
          begin
            FListBox.ItemIndex := Items.Count-1;
            FListBox.Invalidate;
            Key := 0;
          end;
        end;
    end;
  end;
  inherited;
end;

procedure TElWideDBLookupComboBox.DoAutoComplete;
var
  i, ssl, StartPos: integer;
  S, S1: TLMDString;
  key: WideChar;
begin
  ssl := Length(fAutoCompletionBuf);
  S := fAutoCompletionBuf + Text;
  StartPos := 0;
//  S := fAutoCompletionBuf + WideCopy(Text, ssl+1, 1);
  if Length(S) > 0 then
  begin
    if (fAutoCompletionBuf='') or (ItemIndex<0) then
      StartPos := 0
    else
      StartPos := ItemIndex;
    for i := StartPos to Pred(FListBox.Items.Count) do
    begin
      S1 := GetTextFromItem(i); // Autocomplete for first field only !
{$IFDEF LMD_UNICODE}
      if LMDUnicodeLower(S) = LMDUnicodeLower(Copy(S1, 1, Length(S))) then
{$ELSE}
      if Lowercase(S) = Lowercase(Copy(S1, 1, Length(S))) then
{$ENDIF}
      begin
        Text := S1;
        if not DroppedDown then
          ItemIndex := i // when FIgnoreItemIdx = True
        else
          FListBox.ItemIndex := i;
        SelStart := ssl;
        SelLength := Length(Text) - ssl;
        CaretX := ssl;
        fAutoCompletionBuf := S;
        Break;
      end;
    end;
  end;
  if (Length(fAutoCompletionBuf) = ssl) and (Length(text) > 0) and (StartPos > 0) then
  begin
    for i := StartPos - 1 downto 0 do
    begin
      S1 := GetTextFromItem(i); // Autocomplete for first field only !
{$IFDEF LMD_UNICODE}
      if LMDUnicodeLower(S) = LMDUnicodeLower(Copy(S1, 1, Length(S))) then
{$ELSE}
      if Lowercase(S) = Lowercase(Copy(S1, 1, Length(S))) then
{$ENDIF}
      begin
        Text := S1;
        if not DroppedDown then
          ItemIndex := i // when FIgnoreItemIdx = True
        else
          FListBox.ItemIndex := i;
        SelStart := ssl;
        SelLength := Length(Text) - ssl;
        CaretX := ssl;
        fAutoCompletionBuf := S;
        Break;
      end;
    end;
  end;
  if (Length(fAutoCompletionBuf) = ssl) and (Length(text) > 0) then
  begin
    key := text[1];
    FElDBWideLookupControl.ProcessSearchKey(Char(key));
    ClearAutoCompletionData;
    fLastAutoComletion := Now;
    fAutoCompletionBuf := key;
  end;
  invalidate;
end;

procedure TElWideDBLookupComboBox.ClearAutoCompletionData;
begin
  fLastAutoComletion := 0;
  SelStart := 0;
  LeftChar := 0;
  fAutoCompletionBuf := '';
end;

procedure TElWideDBLookupComboBox.WMChar(var Message: TWMChar);
var
  OLDItemIndex, NewItemIndex: Integer;
  OLDSelStart: Integer;
  OLDAutoCompletionBuf: String;
begin
  if not ((
           AutoCompletion and
           (not (ReadOnly or GetDBReadOnlyState)) and
           (Message.CharCode <> VK_BACK{=8}) // and
           //(Message.CharCode <> VK_LEFT{=8}) and
           //(Message.CharCode <> VK_RIGHT{=8})
  )
  and
  (Assigned(DataSource) and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))))
    then
    begin
//      FWMKeyDown := True;
//      inherited;
    end
  else
  // if AutoCompletion:
  if (Message.CharCode <> VK_RETURN) then
  begin
    if not DroppedDown then
    begin
      OLDItemIndex := ItemIndex;
      FKeys := '';
    end
    else
    begin
      ClearAutoCompletionData;
      OLDItemIndex := FListBox.ItemIndex;
    end;
    if (Message.CharCode = VK_ESCAPE)or
       (fLastAutoComletion=0)or
       ((Now - fLastAutoComletion) > cAutoCompletionTimeOut)
    then
    begin // Autocompletion timeout
      ClearAutoCompletionData;
      if (Message.CharCode = VK_ESCAPE) then
        exit;
    end;
    OLDSelStart := SelStart;
    OLDAutoCompletionBuf := fAutoCompletionBuf;

    FIgnoreItemIdx := True; // disable reset ItemIndex, for search Autocompletion from current position !
    try
      FWMKeyDown := True;
      inherited;
    finally
      FIgnoreItemIdx := False;
    end;

    if not DroppedDown then
      NewItemIndex := ItemIndex
    else
      NewItemIndex := FListBox.ItemIndex;

    if OLDItemIndex <> NewItemIndex then
    begin
      if ItemIndex>=0 then
      begin
        if not DroppedDown then
        begin
          FElDBWideLookupControl.Select( NewItemIndex );
//          if Assigned( OnChange ) then
//            OnChange( Self );
        end
        else
        begin
          //if Selected[OLDItemIndex]
          //Selected[ItemIndex] := True;
          FListBox.Invalidate;
        end;
      end
      else
      begin
        // restore previous condition
        if not DroppedDown then
          ItemIndex := OLDItemIndex
        else
          FLIstBox.ItemIndex := OLDItemIndex;
        SelStart := OLDSelStart;
        LeftChar := 0;
      end;
    end
    else
    if OLDAutoCompletionBuf <> fAutoCompletionBuf
    then // when new symbol equal current
    begin
      if not DroppedDown then
        Invalidate
      else
      with TElComboListBoxProtected(FListBox) do
      begin
        Canvas.Font := Font;
        Canvas.Brush := Brush;
        DrawItem(ItemIndex, ItemRect(ItemIndex), [odSelected]);
      end;
    end;
    fLastAutoComletion := Now;
  end;
end;

procedure TElWideDBLookupComboBox.WMSetFocus(var Msg: TWMSetFocus);
begin
  //ClearAutoCompletionData; // need comment this line when debugging of Autocompletion !
  inherited;
  HideCaret(Handle);
end;

procedure TElWideDBLookupComboBox.CMExit(var Message: TCMExit);
begin
  //ClearAutoCompletionData; // need comment this line when debugging of Autocompletion !
  inherited;
end;

procedure TElWideDBLookupComboBox.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  Refresh;
end;

procedure TElWideDBLookupComboBox.PaintText(Canvas : TCanvas);
  procedure DoDrawText2(Sender : TObject; ACanvas: TCanvas; Index: integer;
      var Rect: TRect; Flags: LongInt);
  var
    i, TextHeight: integer;
    S, S1: TLMDString;
    vFieldCount :Integer;
    R: TRect;
    C1, C2, C3: TColor;
  begin
    if (index>=0) and (index<Items.Count) then
    begin
      vFieldCount := FFieldCount;
      if FFieldWidth[vFieldCount-1] = 0 then
        dec(vFieldCount);
    end
    else
      vFieldCount := 0;
    TextHeight:= Canvas.TextHeight( '0' );
    for i := 1 to vFieldCount do
    begin
      S := FFields[i-1].Strings[index];
      if S<>'' then
      begin
        if (not DroppedDown) and (i=1)and
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
            //if S<>'' then
              inc(Rect.Left, Canvas_TextWidthW(ACanvas, S1, Flags ) + 0);
            //else
            //  inc(Rect.Left, Canvas_TextWidthW(ACanvas, S1, Flags ) + 5);
            R.Right := Rect.Left;
            if (HighlightAlphaLevel < 255) then
              LMDAlphaFillRect(Canvas, R, clYellow, HighlightAlphaLevel)
            else
            begin
              Canvas.Brush.Color := clYellow;
              Canvas.FillRect(R);
            end;
            Canvas.Font.Color := clRed;
            SetBkMode(ACanvas.Handle, Windows.TRANSPARENT);
            if TopMargin > 0 then
              R.Top := R.Top + TopMargin;
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
          if (FDisplayReadOnlyOptions.Enabled) and (GetDBReadOnlyState) and (not Focused) then
            ACanvas.Font.Color := FDisplayReadOnlyOptions.TextColor;
          R := Rect;
          if TopMargin > 0 then
            R.Top := R.Top + TopMargin;
          if IsHTML then
          begin
            FRender.Data.DefaultColor := ACanvas.Font.Color;
            ACanvas.Brush.Style := bsClear;
            FRender.Data.DefaultBgColor := clNone;

            FRender.Data.DefaultStyle := ACanvas.Font.Style;
            FRender.Data.DefaultHeight := ACanvas.Font.Height;
            FRender.Data.DefaultFont := ACanvas.Font.Name;
            FRender.Data.Charset := ACanvas.Font.Charset;
            FRender.Data.LinkColor := LinkColor;
            FRender.Data.LinkStyle := LinkStyle;

            InflateRect(R, -1, 0);
            if WordWrap then
              FRender.PrepareText(S, R.Right - R.Left, True)
            else
              FRender.PrepareText(S, 0, false);
            FRender.DrawText(Canvas, Point(0, 0), Rect, clNone);
          end
          else
            LMDDrawText(ACanvas.Handle, S, Length(S), R, Flags);
//          inc(Rect.Left, Canvas_TextWidthW(ACanvas, S, Flags ) + 5);
        end;
//        else
//          inc(Rect.Left, 5+1);
      end;
//      else
//        inc(Rect.Left, 5);
      inc(Rect.Left ,FFieldWidth[i - 1]);
      if ColorToRGB(Color) <> ColorToRGB(clBtnFace) then
        ACanvas.Pen.Color := clBtnFace
      else
        ACanvas.Pen.Color := clBtnShadow;
      if i<vFieldCount then
      begin
        ACanvas.MoveTo(Rect.Left, Rect.Top);
        ACanvas.LineTo(Rect.Left, Rect.Top + TextHeight+3);
      end;
      inc(Rect.Left, 5);
    end;
  end;
var
  R: TRect;
  Flags :longint;
begin
  //Check bug in ElListBox.pas:
  //if (FFieldCount>1) and (FItemIndex > -1) then
  //begin
    R := EditRect;
    InflateRect(R, -1,-1);
    dec(R.Right, 1);
    if Assigned(OnDrawItem) then
    begin
      if (not Focused) or (not DroppedDown) then
      begin
        Canvas.Brush.Color := Color;
        if (not Focused) then
        begin
          if (DisplayReadOnlyOptions.Enabled) and (FReadOnly) then
            Canvas.Font.Color := FDisplayReadOnlyOptions.TextColor
          else
            Canvas.Font.Color := Font.Color;
        end
        else
          Canvas.Font.Color := FocusedSelectTextColor;
      end
      else
      begin
        Canvas.Brush.Color := FocusedSelectColor;
        Canvas.Font.Color := FocusedSelectTextColor;
      end;

      FCanvas := Canvas;
      DrawItem(FItemIndex, R, [odComboBoxEdit]);
    end
    else
    begin
      Flags := DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
      if RightAlignedText then
        Flags := Flags or DT_RTLREADING;
      if (Focused) and (not DroppedDown) then
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
        DrawFocusRect(Canvas.Handle, R);
        Canvas.Font.Color := FocusedSelectTextColor;
      end;
      inc(R.Left, 4);
      if (not Enabled) or ReadOnly then
      begin
        Canvas.Font.Color := DisabledFontColor;
        if Focused then
          Canvas.Brush.Color := DisabledColor;
      end;
      DoDrawText2(Self, Canvas, ItemIndex, R, Flags);
    end;
  //end
  //else
  //  inherited;
end;

procedure TElWideDBLookupComboBox.DoDrawText(Sender : TObject; ACanvas: TCanvas; Index: integer;
    var Rect: TRect; Flags: LongInt);
var
  i, TextHeight, vFieldCount: integer;
  S, S1: TLMDString;
  R, R2: TRect;
  C1, C2: TColor;
begin
  if ((not Enabled) or FWReadOnly) then
  begin
    if not Focused then
      ACanvas.Font.Color := DisabledFontColor;
    if Focused then
      ACanvas.Brush.Color := DisabledColor;
  end;
  if (ReadOnly and not FIgnoreReadOnlyState) and not Focused then
    ACanvas.Brush.Color := FDisplayReadOnlyOptions.TextColor;
  if (index>=0) and (index<Items.Count) then
  begin
    vFieldCount := FFieldCount;
    if FFieldWidth[vFieldCount-1] = 0 then
      dec(vFieldCount);
  end
  else
    vFieldCount := 0;
  TextHeight:= ACanvas.TextHeight( '0' );
  S1 := '';
  R.Left := 0;
  R.Right := 0;
  for i := 1 to vFieldCount do
  begin
    inc(Rect.Left, 7);
    S := FFields[i-1].Strings[index];
    if (i=1)and(Index=FListBox.ItemIndex) and
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
        R := Rect;
        R2 := Rect;
        R.Right := R.Left + Canvas_TextWidthW(ACanvas, S1, Flags );
        R2.Left := R.Right;
      end;
    end;
    if S<>'' then
    begin
      SetBkMode(ACanvas.Handle, Windows.TRANSPARENT);
      if R.Left = 0 then
        LMDDrawText(ACanvas.Handle, S, Length(S), Rect, Flags)
      else
        LMDDrawText(ACanvas.Handle, S, Length(S), R2, Flags)
    end;
    if (S1<>'') then
    begin

      C1 := ACanvas.Brush.Color;
      C2 := ACanvas.Font.Color;
      if (HighlightAlphaLevel < 255) then
        LMDAlphaFillRect(ACanvas, R, clYellow, HighlightAlphaLevel)
      else
      begin
        ACanvas.Brush.Color := clYellow;
        ACanvas.FillRect(R);
      end;
      ACanvas.Font.Color := clRed;
      SetBkMode(ACanvas.Handle, Windows.TRANSPARENT);
      LMDDrawText(ACanvas.Handle, S1, Length(S1), R, Flags);
      S1 := '';
      R.Left := 0;
      R.Right := 0;
      // restore colors
      ACanvas.Brush.Color := C1;
      ACanvas.Font.Color := C2;
    end;
    Rect.Left := Rect.Left + FFieldWidth[i-1];
    if ColorToRGB(Color) <> ColorToRGB(clBtnFace) then
      ACanvas.Pen.Color := clBtnFace
    else
      ACanvas.Pen.Color := clBtnShadow;
    if i<vFieldCount then
    begin
      if i>0 then
        ACanvas.MoveTo(Rect.Left-3, Rect.Top-3)
      else
        ACanvas.MoveTo(Rect.Left-3, Rect.Top);
      if i<vFieldCount then
        ACanvas.LineTo(Rect.Left-3, Rect.Top + TextHeight+3)
      else
        ACanvas.LineTo(Rect.Left-3, Rect.Top + TextHeight);
    end;
  end;
end;

function TElWideDBLookupComboBox.GetFields(Index: integer): TLMDStrings;
begin
  if (Index>=0) and (Index<FFieldCount) then
    Result := FFields[Index]
  else
    Result := nil;
end;

procedure TElWideDBLookupComboBox.SetFieldCount(Value: integer);
var
  i: integer;
begin
  if Value>FFieldCount then
  begin
    SetLength(FFields, Value);
    SetLength(FFieldWidth, Value);
    inc(FFieldCount);
    for i := FFieldCount to Value do
      FFields[i-1] := TLMDWideStringList.Create;
    FFieldCount := Value;
  end
  else
    if Value<FFieldCount then
    begin
      for i := Value+1 to FFieldCount do
        FFields[i-1].Free;
      SetLength(FFields, Value);
      SetLength(FFieldWidth, Value);
      FFieldCount := Value;
    end;
end;

procedure TElWideDBLookupComboBox.ClearFields;
var
  i: integer;
begin
  Items.Clear;
  for i:= 1 to FFieldCount do
    FFields[i-1].Clear;
end;

procedure TElWideDBLookupComboBox.AddItem(const Value: TLMDString; Field: integer);
begin
  Fields[Field].Add(Value);
  if Field=0 then
    Items.Add(Value);
end;

procedure TElWideDBLookupComboBox.SetHScrollBarWidth;
var
   j: integer;
   MaxWidth :integer;
begin
  if not HorizontalScroll then
    exit;
  MaxWidth := 0;
  for j := 0 to FFieldCount-1 do
    inc(MaxWidth, FFieldWidth[j] +7 );
  FListBox.Perform(LB_SETHORIZONTALEXTENT, MaxWidth, 0 );
end;

procedure TElWideDBLookupComboBox.DoDropDown;
//var
//  i: integer;
begin
  if (not HandleAllocated) or (csDestroying in ComponentState) then
    inherited
  else
  begin
    if fNeedUpdate
//       or
//       (
//        Assigned(FElDBWideLookupControl.ListSource) and Assigned(FElDBWideLookupControl.ListSource.DataSet) and
//        (FElDBWideLookupControl.ListSource.DataSet.Active) and
//        (FElDBWideLookupControl.ListSource.DataSet.RecordCount <> Items.Count)
//       )
    then
      FElDBWideLookupControl.UpdateListFields;
    inherited;
    if (Assigned(FElDBWideLookupControl.DataSource) and (FListBox.ItemIndex > 0) and (FListBox.ItemIndex <> FElDBWideLookupControl.ListLink.ActiveRecord)) then
    begin
      FElDBWideLookupControl.ListLink.DataSet.RecNo := FListBox.ItemIndex;
//      FElDBWideLookupControl.ListLink.DataSet.Refresh;
    end;
  end;
end;

procedure TElWideDBLookupComboBox.SetUnicodeMode(Value: TElDBUnicodeMode);
begin
  if FUnicodeMode <> Value then
  begin
    FUnicodeMode := Value;
    FElDBWideLookupControl.UnicodeMode := Value;
  end;
end;

function TElWideDBLookupComboBox.GetNullValueKey: TShortCut;
begin
  Result := FElDBWideLookupControl.NullValueKey;
end;

procedure TElWideDBLookupComboBox.SetNullValueKey(Value: TShortCut);
begin
  if Value <> FElDBWideLookupControl.NullValueKey then
    FElDBWideLookupControl.NullValueKey := Value;
end;

procedure TElWideDBLookupComboBox.KeyUp(var Key: Word; Shift: TShiftState);
//var
//  i: integer;
//  j: Integer;
begin
  if ( [ssAlt, ssCtrl] * Shift = [] ) and (DroppedDown)
  then
  begin
    case Key of
      VK_DOWN, VK_UP, VK_PRIOR, VK_NEXT:
        begin
//          for i := 0 to FListBox.Items.Count - 1 do
//          begin
//            if FListBox.Selected[i] then Break;
//          end;
          FElDBWideLookupControl.ListLink.DataSet.MoveBy(FListBox.ItemIndex - FElDBWideLookupControl.ListLink.ActiveRecord);
//            FElDBWideLookupControl.ListLink.ActiveRecord := i;
//            FElDBWideLookupControl.ListLink.DataSet.Refresh;
        end;
    end;
  end;
  inherited;
end;

procedure TElWideDBLookupComboBox.SelfAutoHistoryItemMoveEvent(
  Sender: TObject; const aString: TLMDString; const aIdx: Integer);
//var
//  tmp: array of WideString;
//  i, j: integer;
begin
//  if AutoHistoryDirection = ahdFirst then
//  begin
//    SetLength(tmp, FFieldCount);
//    for j := 0 to FFieldCount - 1 do
//      tmp[j] := FFields[j][aIdx];
//    for i := Items.Count - 1 downto 1 do
//    begin
//      for j := 0 to FFieldCount - 1 do
//        FFields[j][i] := FFields[j][i-1];
//    end;
//    for j := 0 to FFieldCount - 1 do
//      FFields[j][0] := tmp[j];
//  end
//  else
//  begin
//    SetLength(tmp, FFieldCount);
//    for j := 0 to FFieldCount - 1 do
//      tmp[j] := FFields[j][aIdx];
//    for i := 0 to Items.Count - 2 do
//    begin
//      for j := 0 to FFieldCount - 1 do
//        FFields[j][i] := FFields[j][i+1];
//    end;
//    for j := 0 to FFieldCount - 1 do
//      FFields[j][Items.Count - 1] := tmp[j];
//  end;
  if Assigned(FOldAutoHistoryItemMoveEvent) then
    FOldAutoHistoryItemMoveEvent(Sender,aString,aIdx);
end;

procedure TElWideDBLookupComboBox.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not FDataLink.Editing;
  Refresh;
end;

function TElWideDBLookupComboBox.GetDBReadOnlyState: Boolean;
begin
  Result := DBCheckReadOnlyState(FDataLink);
  Result := Result or FElDBWideLookupControl.ReadOnly or FWReadOnly;
end;

procedure TElWideDBLookupComboBox.ActiveChange(Sender: TObject);
begin
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElWideDBLookupComboBox.ComboMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ClearAutoCompletionData;
end;

procedure TElWideDBLookupComboBox.ComboKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [VK_UP, VK_Down, VK_Prior, VK_Next] then
    ClearAutoCompletionData;
end;

initialization

  cAutoCompletionTimeOut :=
    IncTime(0{TDateTime}, 0{Hours}, 10{Minutes}, 1{Sec}, 500{Ms});

{$ENDIF LMD_UNICODE}

end.
