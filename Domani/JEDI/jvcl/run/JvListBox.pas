{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvListbox2.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse att buypin dott com]
Portions created by Sébastien Buysse are Copyright (C) 2001 Sébastien Buysse.
All Rights Reserved.

This unit is a merging of the original TJvListBox, JvListBox2, TJvExListBox.
Merging done 2002-06-15 by Peter Thornqvist [peter3 at sourceforge dot net]

Contributor(s):
Michael Beck [mbeck att bigfoot dott com].
Petr Vones (petr dott v att mujmail dott cz)
Peter Below <100113 dott 1101 att compuserve dott com>

MERGE NOTES:
  * The Alignment property might mess things up depending on other property settings
  * not very extensively tested
  * TJvListBox in JvCtrls inherits from TJvCustomListbox in this unit.
    Maybe TJvListBox should be moved here instead (or this code into JvCtrls)?
  * TJvPlaylist now inherits from JvListBox

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net
Known Issues:

Merge notes (2002-03-21):
* (p3) merged JvMultilineListBox, JvReorderListBox, JvTextListBox, JvBMPListBox
Notes (2003-05-21) // Remko Bonte
* Removed OwnerData
* Some bug-fixes. Combinations of Multiline, Alignment, Scrollbars seem to work now.
* Did some rewrite of background-drawing. Most of it seems to work, but a lot
  of flickering, best avoid it or set ScrollBars to ssNone.
* Updated drag image to use with MultiLine.
-----------------------------------------------------------------------------}
// $Id: JvListBox.pas,v 1.49 2005/12/25 16:38:10 ahuser Exp $

unit JvListBox;

{$I jvcl.inc}
{$I vclonly.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$IFDEF CLR}
  System.Reflection,
  Types,
  {$ENDIF CLR}
  Windows, Messages, SysUtils, Classes, Graphics, StdCtrls, Controls, Forms,
  JvItemsSearchs, JvDataProvider, JvDataProviderIntf, JvExStdCtrls;

type
  TJvListboxFillMode = (bfmTile, bfmStretch);
  TJvListBoxDataEvent = procedure(Sender: TWinControl; Index: Integer; var Text: string) of object;
  TJvListboxChange = procedure(Sender: TObject; Item: string) of object;
  TJvScrollEvent = procedure(Sender: TObject; const Msg: TWMScroll; var DontScroll: Boolean) of object;

  TJvListBoxBackground = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FImage: TBitmap;
    FFillMode: TJvListboxFillMode;
    FVisible: Boolean;
    procedure SetFillMode(const Value: TJvListboxFillMode);
    procedure SetImage(const Value: TBitmap);
    procedure SetVisible(const Value: Boolean);
    function GetDoDraw: Boolean;
  protected
    procedure Change;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property DoDraw: Boolean read GetDoDraw;
    property Image: TBitmap read FImage write SetImage;
    property FillMode: TJvListboxFillMode read FFillMode write SetFillMode;
    property Visible: Boolean read FVisible write SetVisible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TJvCustomListBox = class;

  { This class will be used for the Items property of the list box.

    If a provider is active at the list box, this list will keep the strings stored in an internal
    list.

    Whenever an item is added to the list the provider will be deactivated and the list will be
    handled by the list box as usual. }
  TJvListBoxStrings = class(TStrings)
  private
    FListBox: TJvCustomListBox;
    FInternalList: TStringList;
    FUseInternal: Boolean;
    FUpdating: Boolean;
    FDestroyCnt: Integer;
    function GetInternalList: TStrings;
  protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
    procedure SetWndDestroying(Destroying: Boolean);
    function GetListBox: TJvCustomListBox;
    procedure SetListBox(Value: TJvCustomListBox);
    property ListBox: TJvCustomListBox read GetListBox write SetListBox;
    property InternalList: TStrings read GetInternalList;
    property UseInternal: Boolean read FUseInternal write FUseInternal;
    property Updating: Boolean read FUpdating;
    property DestroyCount: Integer read FDestroyCnt;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    function IndexOf(const S: string): Integer; override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
    procedure MakeListInternal; virtual;
    procedure ActivateInternal; virtual;
  end;
  TJvListBoxStringsClass = class of TJvListBoxStrings;

  TJvCustomListBox = class(TJvExCustomListBox)
  private
    FHotTrack: Boolean;
    FAlignment: TAlignment;
    FMaxWidth: Integer;
    FScrollBars: TScrollStyle;
    FSorted: Boolean;
    FOnGetText: TJvListBoxDataEvent;
    FOnSelectCancel: TNotifyEvent;
    FOnDeleteString: TJvListboxChange;
    FOnAddString: TJvListboxChange;
    FOnChange: TNotifyEvent;
    FOnHorizontalScroll: TJvScrollEvent;
    FOnVerticalScroll: TJvScrollEvent;
    FDragIndex: Integer;
    FDragImage: TDragImageList;
    FMultiline: Boolean;
    FShowFocusRect: Boolean;
    FSelectedTextColor: TColor;
    FSelectedColor: TColor;
    FDisabledTextColor: TColor;
    FBackground: TJvListBoxBackground;
    FLeftPosition: Integer;

    {$IFNDEF CLR}
    FConsumerSvc: TJvDataConsumer;
    FConsumerStrings: TJvConsumerStrings;
    {$ENDIF !CLR}
    FProviderIsActive: Boolean;
    FProviderToggle: Boolean;

    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure CNKeyDown(var Msg: TWMKeyDown); message CN_KEYDOWN;

    procedure DrawBackGround(ADC: HDC; const DoOffSet: Boolean);
    procedure UpdateStyle;

    { Handle messages that insert or delete strings from the listbox to
      manage the horizontal scrollbar if FMutliline is false. }
    procedure LBAddString(var Msg: TMessage); message LB_ADDSTRING;
    procedure LBInsertString(var Msg: TMessage); message LB_INSERTSTRING;
    procedure LBDeleteString(var Msg: TMessage); message LB_DELETESTRING;
    { Override CN_DRAWITEM handling to be able to switch off focus rect. }
    procedure CNDrawItem(var Msg: TWMDrawItem); message CN_DRAWITEM;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetMultiline(const Value: Boolean);
    procedure SetSelectedColor(const Value: TColor);
    procedure SetSelectedTextColor(const Value: TColor);
    procedure SetShowFocusRect(const Value: Boolean);
    procedure SetDisabledTextColor(const Value: TColor);
    procedure SetMaxWidth(const Value: Integer);
    procedure SetScrollBars(const Value: TScrollStyle);
    procedure SetSorted(const Value: Boolean);
    procedure SetHotTrack(const Value: Boolean);
    procedure SetBackground(const Value: TJvListBoxBackground);
    function GetLimitToClientWidth: Boolean;
  protected
    procedure FontChanged; override;
    function GetItemsClass: TJvListBoxStringsClass; virtual;
    procedure BeginRedraw;
    procedure EndRedraw;

    {$IFNDEF CLR}
    procedure SetConsumerService(Value: TJvDataConsumer);
    procedure ConsumerServiceChanging(Sender: TJvDataConsumer; Reason: TJvDataConsumerChangeReason);
    procedure ConsumerServiceChanged(Sender: TJvDataConsumer; Reason: TJvDataConsumerChangeReason);
    procedure ConsumerSubServiceCreated(Sender: TJvDataConsumer;
      SubSvc: TJvDataConsumerAggregatedObject);
    {$ENDIF !CLR}
    function IsProviderSelected: Boolean;
    function IsProviderToggle: Boolean;
    procedure DeselectProvider;
    procedure UpdateItemCount;
    {$IFNDEF CLR}
    property Provider: TJvDataConsumer read FConsumerSvc write SetConsumerService;
    property ConsumerStrings: TJvConsumerStrings read FConsumerStrings;
    {$ENDIF !CLR}
    procedure LBFindString(var Msg: TMessage); message LB_FINDSTRING;
    procedure LBFindStringExact(var Msg: TMessage); message LB_FINDSTRINGEXACT;
    procedure LBSelectString(var Msg: TMessage); message LB_SELECTSTRING;
    procedure LBGetText(var Msg: TMessage); message LB_GETTEXT;
    procedure LBGetTextLen(var Msg: TMessage); message LB_GETTEXTLEN;

    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    function DoEraseBackground(Canvas: TCanvas; Param: Integer): Boolean; override;
    procedure MouseEnter(Control: TControl); override;
    procedure MouseLeave(Control: TControl); override;
    procedure SelectCancel(var Msg: TMessage); message LBN_SELCANCEL;
    procedure Changed; virtual;
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure RemeasureAll;
    procedure DoBackgroundChange(Sender: TObject);

    procedure Loaded; override;
    {$IFNDEF CLR}
    procedure DrawProviderItem(Canvas: TCanvas; Rect: TRect; Index: Integer;
      State: TOwnerDrawState);
    {$ENDIF !CLR}
    procedure DoGetText(Index: Integer; var AText: string); virtual;

    property LimitToClientWidth: Boolean read GetLimitToClientWidth;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth;
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssBoth;
    property Sorted: Boolean read FSorted write SetSorted default False;
    property OnGetText: TJvListBoxDataEvent read FOnGetText write FOnGetText;
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    property OnSelectCancel: TNotifyEvent read FOnSelectCancel write FOnSelectCancel;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDeleteString: TJvListboxChange read FOnDeleteString write FOnDeleteString;
    property OnAddString: TJvListboxChange read FOnAddString write FOnAddString;
    property OnVerticalScroll: TJvScrollEvent read FOnVerticalScroll write FOnVerticalScroll;
    property OnHorizontalScroll: TJvScrollEvent read FOnHorizontalScroll write FOnHorizontalScroll;
    {$IFDEF CLR}
    // access protected members across assembly borders
    function DoGetData(const Index: Integer): string;
    function DoGetDataObject(const Index: Integer): TObject;
    function GetItemData(Index: Integer): TObject; override;
    function InternalGetItemData(Index: Integer): TObject; override;
    procedure InternalSetItemData(Index: Integer; AData: TObject); override;
    procedure SetItemData(Index: Integer; AData: TObject); override;
    procedure ResetContent; override;
    procedure DeleteString(Index: Integer); override;
    function DoFindData(const Data: String): Integer;
    property Style;
    {$ENDIF CLR}
    property Moving: Boolean read FMoving write FMoving;

    property DragIndex: Integer read FDragIndex;
    property DragImages: TDragImageList read GetDragImages;
    procedure WndProc(var Msg: TMessage); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ItemRect(Index: Integer): TRect;
    function ItemsShowing: TStrings; virtual;

    {$IFNDEF CLR}
    procedure MeasureProviderItem(Index, WidthAvail: Integer; var ASize: TSize);
    {$ENDIF !CLR}
    procedure MeasureString(const S: string; WidthAvail: Integer; var ASize: TSize);

    procedure DefaultDrawItem(Index: Integer; ARect: TRect;
      State: TOwnerDrawState); virtual;
    procedure DefaultDragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); virtual;
    procedure DefaultStartDrag(var DragObject: TDragObject); virtual;
    procedure DefaultDragDrop(Source: TObject; X, Y: Integer); virtual;
    procedure CreateDragImage(const S: string);
    procedure UpdateHorizontalExtent;
    function SearchExactString(const Value: string; CaseSensitive: Boolean = True;
      StartIndex: Integer = -1): Integer;
    function SearchPrefix(const Value: string; CaseSensitive: Boolean = True;
      StartIndex: Integer = -1): Integer;
    function SearchSubString(const Value: string; CaseSensitive: Boolean = True;
      StartIndex: Integer = -1): Integer;
    function DeleteExactString(const Value: string; All: Boolean;
      CaseSensitive: Boolean = True): Integer;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    function GetDragImages: TDragImageList; override;
    procedure SelectAll; {$IFDEF COMPILER6_UP} override; {$ENDIF}
    procedure UnselectAll;
    procedure InvertSelection;
    procedure MoveSelectedUp; virtual;
    procedure MoveSelectedDown; virtual;
    procedure DeleteSelected; {$IFDEF COMPILER6_UP} override; {$ELSE} virtual; {$ENDIF}
    procedure DeleteAllButSelected;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
  protected
    property MultiLine: Boolean read FMultiline write SetMultiline default False;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor default clHighlight;
    property SelectedTextColor: TColor read FSelectedTextColor write SetSelectedTextColor default clHighlightText;
    property DisabledTextColor: TColor read FDisabledTextColor write SetDisabledTextColor default clGrayText;
    property ShowFocusRect: Boolean read FShowFocusRect write SetShowFocusRect default True;
    property Background: TJvListBoxBackground read FBackground write SetBackground;
  end;

  TJvListBox = class(TJvCustomListBox)
  public
    {$IFDEF COMPILER6_UP}
    property Count;
    {$ENDIF COMPILER6_UP}
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property Items;

    property MultiLine;
    property SelectedColor;
    property SelectedTextColor;
    property DisabledTextColor;
    property ShowFocusRect;
    property Background;

    property MultiSelect;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    {$IFNDEF CLR}
    property Provider;
    {$ENDIF !CLR}
    property ScrollBars;
    property ShowHint;
    property Sorted;
    property Style;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetText;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property Alignment;
    property HotTrack;
    property HintColor;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnParentColorChange;
    property OnSelectCancel;
    property OnChange;
    property OnDeleteString;
    property OnAddString;
    property OnVerticalScroll;
    property OnHorizontalScroll;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvListBox.pas,v $';
    Revision: '$Revision: 1.49 $';
    Date: '$Date: 2005/12/25 16:38:10 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  Consts, TypInfo,
  {$IFDEF HAS_UNIT_RTLCONSTS}
  RTLConsts,
  {$ENDIF HAS_UNIT_RTLCONSTS}
  JclBase,
  JvJVCLUtils, JvConsts, JvCtrls, JvResources;

const
  AlignFlags: array [TAlignment] of DWORD = (DT_LEFT, DT_RIGHT, DT_CENTER);

type
  PStrings = ^TStrings;

//=== { TJvListBoxStrings } ==================================================

constructor TJvListBoxStrings.Create;
begin
  inherited Create;
  FInternalList := TStringList.Create;
end;

destructor TJvListBoxStrings.Destroy;
begin
  FreeAndNil(FInternalList);
  inherited Destroy;
end;

function TJvListBoxStrings.Get(Index: Integer): string;
var
  Len: Integer;
begin
  if UseInternal then
    Result := InternalList[Index]
  else
  {$IFDEF COMPILER6_UP}
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := ListBox.DoGetData(Index)
  else
  {$ENDIF COMPILER6_UP}
  begin
    Len := SendMessage(ListBox.Handle, LB_GETTEXTLEN, Index, 0);
    if Len = LB_ERR then
      Error(SListIndexError, Index);
    SetLength(Result, Len);
    if Len <> 0 then
    begin
      {$IFDEF CLR}
      SendGetTextMessage(ListBox.Handle, LB_GETTEXT, Index, Result, Len);
      {$ELSE}
      Len := SendMessage(ListBox.Handle, LB_GETTEXT, Index, Longint(PChar(Result)));
      SetLength(Result, Len);
      {$ENDIF CLR}
    end;
  end;
end;

function TJvListBoxStrings.GetCount: Integer;
begin
  if (DestroyCount > 0) and UseInternal then
    Result := 0
  else
  begin
    if UseInternal then
      Result := InternalList.Count
    else
      Result := SendMessage(ListBox.Handle, LB_GETCOUNT, 0, 0);
  end;
end;

function TJvListBoxStrings.GetObject(Index: Integer): TObject;
begin
  if UseInternal then
    Result := InternalList.Objects[Index]
  else
  {$IFDEF COMPILER6_UP}
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := ListBox.DoGetDataObject(Index)
  else
  {$ENDIF COMPILER6_UP}
  begin
    Result := TObject(ListBox.GetItemData(Index));
    if Longint(Result) = LB_ERR then
      Error(SListIndexError, Index);
  end;
end;

procedure TJvListBoxStrings.Put(Index: Integer; const S: string);
var
  I: Integer;
  {$IFDEF CLR}
  TempData: TObject;
  {$ELSE}
  TempData: Longint;
  {$ENDIF CLR}
begin
  if UseInternal then
    InternalList[Index] := S
  else
  begin
    ListBox.DeselectProvider;
    I := ListBox.ItemIndex;
    TempData := ListBox.InternalGetItemData(Index);
    // Set the Item to 0 in case it is an object that gets freed during Delete
    ListBox.InternalSetItemData(Index, {$IFDEF CLR} nil {$ELSE} 0 {$ENDIF});
    Delete(Index);
    InsertObject(Index, S, nil);
    ListBox.InternalSetItemData(Index, TempData);
    ListBox.ItemIndex := I;
  end;
end;

procedure TJvListBoxStrings.PutObject(Index: Integer; AObject: TObject);
begin
  if UseInternal then
    InternalList.Objects[Index] := AObject
  else
  begin
    if (Index <> -1) {$IFDEF COMPILER6_UP} and not (ListBox.Style in [lbVirtual, lbVirtualOwnerDraw]) {$ENDIF} then
    begin
      ListBox.DeselectProvider;
      {$IFDEF CLR}
      ListBox.SetItemData(Index, AObject);
      {$ELSE}
      ListBox.SetItemData(Index, Longint(AObject));
      {$ENDIF CLR}
    end;
  end;
end;

procedure TJvListBoxStrings.SetUpdateState(Updating: Boolean);
begin
  FUpdating := Updating;
  if ListBox.HandleAllocated then
  begin
    SendMessage(ListBox.Handle, WM_SETREDRAW, Ord(not Updating), 0);
    if not Updating then
      ListBox.Refresh;
  end;
end;

procedure TJvListBoxStrings.SetWndDestroying(Destroying: Boolean);
begin
  if Destroying then
    Inc(FDestroyCnt)
  else
  if FDestroyCnt > 0 then
    Dec(FDestroyCnt);
end;

function TJvListBoxStrings.GetListBox: TJvCustomListBox;
begin
  Result := FListBox;
end;

procedure TJvListBoxStrings.SetListBox(Value: TJvCustomListBox);
begin
  FListBox := Value;
end;

function TJvListBoxStrings.GetInternalList: TStrings;
begin
  Result := FInternalList;
end;

function TJvListBoxStrings.Add(const S: string): Integer;
begin
  if (csLoading in ListBox.ComponentState) and UseInternal then
    Result := InternalList.Add(S)
  else
  begin
    {$IFDEF COMPILER6_UP}
    Result := -1;
    if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
      Exit;
    {$ENDIF COMPILER6_UP}
    ListBox.DeselectProvider;
    {$IFDEF CLR}
    Result := SendTextMessage(ListBox.Handle, LB_ADDSTRING, 0, S);
    if Result < 0 then
      raise EOutOfResources.Create(SInsertLineError);
    {$ELSE}
    Result := SendMessage(ListBox.Handle, LB_ADDSTRING, 0, Longint(PChar(S)));
    if Result < 0 then
      raise EOutOfResources.CreateRes(@SInsertLineError);
    {$ENDIF CLR}
  end;
end;

procedure TJvListBoxStrings.Clear;
begin
  if (FDestroyCnt <> 0) and UseInternal then
    Exit;
  if (csLoading in ListBox.ComponentState) and UseInternal then
    InternalList.Clear
  else
  begin
    ListBox.DeselectProvider;
    ListBox.ResetContent;
  end;
end;

procedure TJvListBoxStrings.Delete(Index: Integer);
begin
  if (csLoading in ListBox.ComponentState) and UseInternal then
    InternalList.Delete(Index)
  else
  begin
    ListBox.DeselectProvider;
    ListBox.DeleteString(Index);
  end;
end;

function TJvListBoxStrings.IndexOf(const S: string): Integer;
begin
  if UseInternal then
    Result := InternalList.IndexOf(S)
  else
  {$IFDEF COMPILER6_UP}
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := ListBox.DoFindData(S)
  else
  {$ENDIF COMPILER6_UP}
    {$IFDEF CLR}
    Result := SendTextMessage(ListBox.Handle, LB_FINDSTRINGEXACT, -1, S);
    {$ELSE}
    Result := SendMessage(ListBox.Handle, LB_FINDSTRINGEXACT, -1, Longint(PChar(S)));
    {$ENDIF CLR}
end;

procedure TJvListBoxStrings.Insert(Index: Integer; const S: string);
begin
  if (csLoading in ListBox.ComponentState) and UseInternal then
    InternalList.Insert(Index, S)
  else
  begin
    ListBox.DeselectProvider;
    {$IFDEF COMPILER6_UP}
    if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
      Exit;
    {$ENDIF COMPILER6_UP}
    {$IFDEF CLR}
    if SendTextMessage(ListBox.Handle, LB_INSERTSTRING, Index, S) < 0 then
      raise EOutOfResources.Create(SInsertLineError);
    {$ELSE}
    if SendMessage(ListBox.Handle, LB_INSERTSTRING, Index, Longint(PChar(S))) < 0 then
      raise EOutOfResources.CreateRes(@SInsertLineError);
    {$ENDIF CLR}
  end;
end;

procedure TJvListBoxStrings.Move(CurIndex, NewIndex: Integer);
var
  TempString: string;
  {$IFDEF CLR}
  TempData: TObject;
  {$ELSE}
  TempData: Longint;
  {$ENDIF CLR}
begin
  if (csLoading in ListBox.ComponentState) and UseInternal then
    InternalList.Move(CurIndex, NewIndex)
  else
  begin
    {$IFDEF COMPILER6_UP}
    if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
      Exit;
    {$ENDIF COMPILER6_UP}
    BeginUpdate;
    ListBox.Moving := True;
    try
      if CurIndex <> NewIndex then
      begin
        TempString := Get(CurIndex);
        TempData := ListBox.InternalGetItemData(CurIndex);
        ListBox.InternalSetItemData(CurIndex, {$IFDEF CLR} nil {$ELSE} 0 {$ENDIF});
        Delete(CurIndex);
        Insert(NewIndex, TempString);
        ListBox.InternalSetItemData(NewIndex, TempData);
      end;
    finally
      ListBox.Moving := False;
      EndUpdate;
    end;
  end;
end;

{ Copies the strings at the list box to the FInternalList. To minimize the memory usage when a
  large list is used, each item copied is immediately removed from the list box list. }
procedure TJvListBoxStrings.MakeListInternal;
var
  Cnt: Integer;
  {$IFNDEF CLR}
  Text: array [0..4095] of Char;
  Len: Integer;
  {$ENDIF !CLR}
  S: string;
  Obj: TObject;
begin
  if ListBox.HandleAllocated then
    SendMessage(ListBox.Handle, WM_SETREDRAW, Ord(False), 0);
  try
    InternalList.Clear;
    if ListBox.HandleAllocated then
      Cnt := SendMessage(ListBox.Handle, LB_GETCOUNT, 0, 0)
    else
      Cnt := 0;
    while Cnt > 0 do
    begin
      {$IFDEF CLR}
      SendGetTextMessage(ListBox.Handle, LB_GETTEXT, 0, S, 4096);
      Obj := ListBox.GetItemData(0);
      {$ELSE}
      Len := SendMessage(ListBox.Handle, LB_GETTEXT, 0, Longint(@Text));
      SetString(S, Text, Len);
      Obj := TObject(SendMessage(ListBox.Handle, LB_GETITEMDATA, 0, 0));
      {$ENDIF CLR}
      SendMessage(ListBox.Handle, LB_DELETESTRING, 0, 0);
      InternalList.AddObject(S, Obj);
      Dec(Cnt);
    end;
  finally
    UseInternal := True;
    if not Updating and ListBox.HandleAllocated then
      SendMessage(ListBox.Handle, WM_SETREDRAW, Ord(True), 0);
  end;
end;

procedure TJvListBoxStrings.ActivateInternal;
var
  S: string;
  Obj: TObject;
  {$IFNDEF CLR}
  Index: Integer;
  {$ENDIF !CLR}
begin
  SendMessage(ListBox.Handle, WM_SETREDRAW, Ord(False), 0);
  try
    InternalList.BeginUpdate;
    try
      SendMessage(ListBox.Handle, LB_RESETCONTENT, 0, 0);
      while InternalList.Count > 0 do
      begin
        S := InternalList[0];
        Obj := InternalList.Objects[0];
        {$IFDEF CLR}
        ListBox.AddItem(S, Obj);
        {$ELSE}
        Index := SendMessage(ListBox.Handle, LB_ADDSTRING, 0, Longint(PChar(S)));
        if Index < 0 then
          raise EOutOfResources.CreateRes(@SInsertLineError);
        SendMessage(ListBox.Handle, LB_SETITEMDATA, Index, Longint(Obj));
        {$ENDIF CLR}
        InternalList.Delete(0);
      end;
    finally
      InternalList.EndUpdate;
    end;
  finally
    if not Updating then
      SendMessage(ListBox.Handle, WM_SETREDRAW, Ord(True), 0);
    UseInternal := False;
  end;
end;

//=== { TJvCustomListBox } ===================================================

constructor TJvCustomListBox.Create(AOwner: TComponent);
{$IFNDEF CLR}
var
  PI: PPropInfo;
  PStringsAddr: PStrings;
{$ENDIF !CLR}
begin
  inherited Create(AOwner);
  // JvBMPListBox:
  //  Style := lbOwnerDrawFixed;

  {$IFNDEF CLR}
  FConsumerSvc := TJvDataConsumer.Create(Self, [DPA_RenderDisabledAsGrayed,
    DPA_ConsumerDisplaysList]);
  FConsumerSvc.OnChanging := ConsumerServiceChanging;
  FConsumerSvc.OnChanged := ConsumerServiceChanged;
  FConsumerSvc.AfterCreateSubSvc := ConsumerSubServiceCreated;
  FConsumerStrings := TJvConsumerStrings.Create(FConsumerSvc);
  { The following hack assumes that TJvListBox.Items reads directly from the private FItems field
    of TCustomListBox and that TJvListBox.Items is actually published.

    What we do here is remove the original string list used and place our own version in it's place.
    This would give us the benefit of keeping the list of strings (and objects) even if a provider
    is active and the list box windows has no strings at all. }
  PI := GetPropInfo(TJvListBox, 'Items');
  PStringsAddr := Pointer(Integer(PI.GetProc) and $00FFFFFF + Integer(Self));
  Items.Free;                                 // remove original item list (TListBoxStrings instance)
  PStringsAddr^ := GetItemsClass.Create;      // create our own implementation and put it in place.
  {$ELSE} // CLR=True
  Items.Free;                                 // remove original item list (TListBoxStrings instance)
  GetType.GetField('FItems', BindingFlags.NonPublic).SetValue(Self, GetItemsClass.Create); // create our own implementation and put it in place.
  {$ENDIF !CLR}
  TJvListBoxStrings(Items).ListBox := Self;   // link it to the list box.

  FBackground := TJvListBoxBackground.Create;
  FBackground.OnChange := DoBackgroundChange;
  FScrollBars := ssBoth;
  FAlignment := taLeftJustify;
  FMultiline := False;
  FSelectedColor := clHighlight;
  FSelectedTextColor := clHighlightText;
  FDisabledTextColor := clGrayText;
  FShowFocusRect := True;
  //  Style := lbOwnerDrawVariable;

  FMaxWidth := 0;
  FHotTrack := False;
  // ControlStyle := ControlStyle + [csAcceptsControls];
end;

destructor TJvCustomListBox.Destroy;
begin
  FreeAndNil(FBackground);
  {$IFNDEF CLR}
  FreeAndNil(FConsumerStrings);
  FreeAndNil(FConsumerSvc);
  {$ENDIF !CLR}
  inherited Destroy;
end;

function TJvCustomListBox.GetItemsClass: TJvListBoxStringsClass;
begin
  Result := TJvListBoxStrings;
end;

{$IFDEF CLR}
function TJvCustomListBox.DoGetData(const Index: Integer): string;
begin
  Result := inherited DoGetData(Index);
end;

function TJvCustomListBox.DoGetDataObject(const Index: Integer): TObject;
begin
  Result := inherited DoGetDataObject(Index);
end;

function TJvCustomListBox.GetItemData(Index: Integer): TObject;
begin
  Result := inherited GetItemData(Index);
end;

function TJvCustomListBox.InternalGetItemData(Index: Integer): TObject;
begin
  Result := inherited InternalGetItemData(Index);
end;

procedure TJvCustomListBox.InternalSetItemData(Index: Integer; AData: TObject);
begin
  inherited InternalSetItemData(Index, AData);
end;

procedure TJvCustomListBox.SetItemData(Index: Integer; AData: TObject);
begin
  inherited SetItemData(Index, AData);
end;

procedure TJvCustomListBox.ResetContent;
begin
  inherited ResetContent;
end;

procedure TJvCustomListBox.DeleteString(Index: Integer);
begin
  inherited DeleteString(Index);
end;

function TJvCustomListBox.DoFindData(const Data: String): Integer;
begin
  Result :=  inherited DoFindData(Data);
end;
{$ENDIF CLR}

procedure TJvCustomListBox.BeginRedraw;
begin
  SendMessage(Handle, WM_SETREDRAW, Ord(False), 0);
end;

procedure TJvCustomListBox.Changed;
begin
  // (rom) TODO?
  inherited Changed; // (marcelb): I added this, 'caus I assume it needs to be called.
end;

procedure TJvCustomListBox.FontChanged;
const
  CShowFocusRect: array [Boolean] of Integer = (0, 2);
begin
  inherited FontChanged;
  Canvas.Font := Font;
  if Style <> lbStandard then
    ItemHeight := CanvasMaxTextHeight(Canvas) + CShowFocusRect[ShowFocusRect];
  RemeasureAll;
end;

procedure TJvCustomListBox.MouseEnter(Control: TControl);
begin
  if csDesigning in ComponentState then
    Exit;
  if not MouseOver then
  begin
    if FHotTrack then
      Ctl3D := True;
    inherited MouseEnter(Control);
  end;
end;

procedure TJvCustomListBox.MouseLeave(Control: TControl);
begin
  if MouseOver then
  begin
    if FHotTrack then
      Ctl3D := False;
    inherited MouseLeave(Control);
  end;
end;

{ This routine is copied mostly from TCustomListbox.CNDrawItem.
  The setting of colors is modified.
  Drawing of the focus rectangle is delegated to DrawItem.}

procedure TJvCustomListBox.CNDrawItem(var Msg: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Msg.DrawItemStruct{$IFNDEF CLR}^{$ENDIF} do
  begin
    State := TOwnerDrawState(Word(itemState and $FFFF));
    Canvas.Handle := hDC;
    Canvas.Font := Font;
    Canvas.Brush := Brush;
    if Integer(itemID) >= 0 then
    begin
      if odSelected in State then
      begin
        Canvas.Brush.Color := FSelectedColor;
        Canvas.Font.Color := FSelectedTextColor;
      end;
      if (([odDisabled, odGrayed] * State) <> []) or not Enabled then
        Canvas.Font.Color := FDisabledTextColor;
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
    begin
      if Background.DoDraw then
      begin
        Perform(WM_ERASEBKGND, Canvas.Handle, 0);
        if odFocused in State then
          DrawFocusRect(hDC, rcItem);
      end
      else
      begin
        Canvas.FillRect(rcItem);
        if odFocused in State then
          DrawFocusRect(hDC, rcItem);
      end;
    end;
    Canvas.Handle := 0;
  end;
end;

procedure TJvCustomListBox.CNKeyDown(var Msg: TWMKeyDown);
begin
  if Background.DoDraw and (Msg.Result = 0) and
    (Msg.CharCode in [VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN]) then
  begin
    BeginRedraw;
    try
      inherited;
    finally
      EndRedraw;
    end;
  end
  else
    inherited;
end;

procedure TJvCustomListBox.CreateDragImage(const S: string);
const
  CLeftMargin = 15;
var
  Size: TSize;
  Bmp: TBitmap;
  SizeRect: TRect;
begin
  if not Assigned(FDragImage) then
    FDragImage := TDragImageList.Create(Self)
  else
    FDragImage.Clear;
  Canvas.Font := Font;
  if MultiLine then
  begin
    SizeRect := Rect(0, 0, MaxInt, 0);
    DrawText(Canvas.Handle, {$IFDEF CLR} S {$ELSE} PChar(S) {$ENDIF}, -1, SizeRect, DT_CALCRECT or
      DrawTextBiDiModeFlags(DT_WORDBREAK or DT_NOPREFIX or AlignFlags[FAlignment]));
    Size.cx := SizeRect.Right;
    Size.cy := SizeRect.Bottom;
  end
  else
    Size := Canvas.TextExtent(S);
  {$IFDEF CLR}
  Inc(Size.Width, CLeftMargin);
  {$ELSE}
  Inc(Size.cx, CLeftMargin);
  {$ENDIF CLR}

  FDragImage.Width := Size.cx;
  FDragImage.Height := Size.cy;
  Bmp := TBitmap.Create;
  try
    Bmp.Width := Size.cx;
    Bmp.Height := Size.cy;
    Bmp.Canvas.Font := Font;
    Bmp.Canvas.Font.Color := clBlack;
    Bmp.Canvas.Brush.Color := clWhite;
    Bmp.Canvas.Brush.Style := bsSolid;
    if MultiLine then
    begin
      Inc(SizeRect.Right, CLeftMargin);
      Bmp.Canvas.FillRect(SizeRect);
      Inc(SizeRect.Left, CLeftMargin);
      DrawText(Bmp.Canvas.Handle, {$IFDEF CLR} S {$ELSE} PChar(S) {$ENDIF}, -1, SizeRect,
        DrawTextBiDiModeFlags(DT_WORDBREAK or DT_NOPREFIX or AlignFlags[FAlignment]));
    end
    else
      Bmp.Canvas.TextOut(CLeftMargin, 0, S);
    FDragImage.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;
  ControlStyle := ControlStyle + [csDisplayDragImage];
end;

procedure TJvCustomListBox.CreateParams(var Params: TCreateParams);
const
  ScrollBar: array [TScrollStyle] of DWORD =
    (0, WS_HSCROLL, WS_VSCROLL, WS_HSCROLL or WS_VSCROLL);
  Sorted: array [Boolean] of DWORD =
    (0, LBS_SORT);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style and not (WS_HSCROLL or WS_VSCROLL) or ScrollBar[FScrollBars] or
      Sorted[FSorted];
  end;
  if IsProviderSelected then
  begin
    Params.Style := Params.Style and not (LBS_SORT or LBS_HASSTRINGS or LBS_NODATA);
    if Params.Style and (LBS_OWNERDRAWVARIABLE or LBS_OWNERDRAWFIXED) = 0 then
      Params.Style := Params.Style or LBS_OWNERDRAWFIXED;
  end;
end;

procedure TJvCustomListBox.CreateWnd;
begin
  if not (csLoading in ComponentState) then
  begin
    FMultiline := MultiLine and (Style = lbOwnerDrawVariable);

    if not (Style in [lbOwnerDrawVariable, lbOwnerDrawFixed]) then
      FAlignment := taLeftJustify;
  end;
  FLeftPosition := 0;
  inherited CreateWnd;
  UpdateItemCount;
  UpdateHorizontalExtent;
end;

procedure TJvCustomListBox.DestroyWnd;
begin
  if IsProviderSelected then
    TJvListBoxStrings(Items).SetWndDestroying(True);
  try
    inherited DestroyWnd;
  finally
    if IsProviderSelected then
      TJvListBoxStrings(Items).SetWndDestroying(False);
  end;
end;

procedure TJvCustomListBox.DefaultDragDrop(Source: TObject;
  X, Y: Integer);
var
  DropIndex, Ti: Integer;
  S: string;
  Obj: TObject;
begin
  if not IsProviderSelected and (Source = Self) then
  begin
    S := Items[FDragIndex];
    Obj := Items.Objects[FDragIndex];
    DropIndex := ItemAtPos(Point(X, Y), True);
    Ti := TopIndex;
    if DropIndex > FDragIndex then
      Dec(DropIndex);
    Items.Delete(FDragIndex);
    if DropIndex < 0 then
      Items.AddObject(S, Obj)
    else
      Items.InsertObject(DropIndex, S, Obj);
    TopIndex := Ti;
  end;
end;

procedure TJvCustomListBox.DefaultDragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := not IsProviderSelected and (Source = Self);
  if Accept then
  begin
    // Handle autoscroll in the "hot zone" 5 pixels from top or bottom of
    // client area
    if (Y < 5) or ((ClientHeight - Y) <= 5) then
    begin
      FDragImage.HideDragImage;
      try
        if Y < 5 then
        begin
          Perform(WM_VSCROLL, SB_LINEUP, 0);
          Perform(WM_VSCROLL, SB_ENDSCROLL, 0);
        end
        else
        if (ClientHeight - Y) <= 5 then
        begin
          Perform(WM_VSCROLL, SB_LINEDOWN, 0);
          Perform(WM_VSCROLL, SB_ENDSCROLL, 0);
        end
      finally
        FDragImage.ShowDragImage;
      end;
    end;
    //    i := ItemAtPos(Point(X,Y),true);
    //    if i > -1 then ItemIndex := i;
  end;
end;

{ This procedure is a slightly modified version of TCustomListbox.DrawItem! }

procedure TJvCustomListBox.DefaultDrawItem(Index: Integer; ARect: TRect;
  State: TOwnerDrawState);
const
  AlignFlags: array [TAlignment] of DWORD =
    (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Flags: Longint;
  ActualRect: TRect;
  AText: string;
begin
   if csDestroying in ComponentState then
    Exit;
 // JvBMPListBox:
  // draw text transparently
  if ScrollBars in [ssHorizontal, ssBoth] then
  begin
    if FMaxWidth < ClientWidth then
      ActualRect := Rect(0, ARect.Top, ClientWidth, ARect.Bottom)
    else
      ActualRect := Rect(0, ARect.Top, FMaxWidth, ARect.Bottom);
  end
  else
    ActualRect := ARect;

  if Background.DoDraw then
  begin
    Canvas.Brush.Style := bsClear;
    // always use font color, CNDrawItem sets it to clHighlitetext for
    // selected items.
    Canvas.Font.Color := Font.Color;

    // The listbox does not erase the background for the item before
    // sending the WM_DRAWITEM message! We have to do that here manually.
    SaveDC(Canvas.Handle);
    IntersectClipRect(Canvas.Handle, ActualRect.Left, ActualRect.Top, ActualRect.Right, ActualRect.Bottom);
    DrawBackGround(Canvas.Handle, True);
    RestoreDC(Canvas.Handle, -1);
  end;

  if Index < ItemsShowing.Count then
  begin
    if not Background.DoDraw then
      Canvas.FillRect(ActualRect);

    if FMultiline then
      Flags := DrawTextBiDiModeFlags(DT_WORDBREAK or DT_NOPREFIX or
        AlignFlags[FAlignment])
    else
      Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX or
        AlignFlags[FAlignment]);
    if not UseRightToLeftAlignment then
      Inc(ActualRect.Left, 2)
    else
      Dec(ActualRect.Right, 2);

    if IsProviderSelected then
      {$IFNDEF CLR}
      DrawProviderItem(Canvas, ActualRect, Index, State)
      {$ENDIF !CLR}
    else
    begin
      AText := ItemsShowing[Index];
      DoGetText(Index, AText);
      DrawText(Canvas.Handle, {$IFDEF CLR} AText {$ELSE} PChar(AText) {$ENDIF},
        Length(AText), ActualRect, Flags);
    end;

    //if (Index >= 0) and (Index < Items.Count) then
    //  Canvas.TextOut(ActualRect.Left + 2, ActualRect.Top, Items[Index]);

    // invert the item if selected
    if Background.DoDraw and (odSelected in State) then
      InvertRect(Canvas.Handle, ActualRect);
    // no need to draw focus rect, CNDrawItem does that for us
  end;
end;

procedure TJvCustomListBox.DefaultStartDrag(var DragObject: TDragObject);
begin
  FDragIndex := ItemIndex;
  if FDragIndex >= Items.Count then
    FDragIndex := Items.Count-1;
  if not IsProviderSelected and (FDragIndex >= 0) then
    CreateDragImage(Items[FDragIndex])
  else
    CancelDrag;
end;

procedure TJvCustomListBox.DeleteAllButSelected;
var
  I: Integer;
begin
  if not IsProviderSelected and MultiSelect then
  begin
    I := 0;
    while I < Items.Count do
      if not Selected[I] then
        Items.Delete(I)
      else
        Inc(I);
    Changed;
  end;
end;

function TJvCustomListBox.DeleteExactString(const Value: string; All: Boolean;
  CaseSensitive: Boolean): Integer;
begin
  if not IsProviderSelected then
  begin
    Result := TJvItemsSearchs.DeleteExactString(Items, Value, CaseSensitive);
    Changed;
  end
  else
    Result := 0;
end;

procedure TJvCustomListBox.DeleteSelected;
var
  I: Integer;
begin
  if not IsProviderSelected then
  begin
    if MultiSelect then
    begin
      for I := Items.Count - 1 downto 0 do
        if Selected[I] then
          Items.Delete(I);
    end
    else
    if ItemIndex <> -1 then
    begin
      I := ItemIndex;
      Items.Delete(I);
      if I > 0 then
        Dec(I);
      if Items.Count > 0 then
        ItemIndex := I;
    end;
    Changed;
  end;
end;

procedure TJvCustomListBox.DoBackgroundChange(Sender: TObject);
begin
  Invalidate;
end;

procedure TJvCustomListBox.DoStartDrag(var DragObject: TDragObject);
begin
  if Assigned(OnStartDrag) then
    inherited DoStartDrag(DragObject)
  else
    DefaultStartDrag(DragObject);
end;

procedure TJvCustomListBox.DragDrop(Source: TObject; X, Y: Integer);
begin
  if Assigned(OnDragDrop) then
    inherited DragDrop(Source, X, Y)
  else
    DefaultDragDrop(Source, X, Y);
end;

procedure TJvCustomListBox.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Assigned(OnDragOver) then
    inherited DragOver(Source, X, Y, State, Accept)
  else
    DefaultDragOver(Source, X, Y, State, Accept);
end;

procedure TJvCustomListBox.DrawBackGround(ADC: HDC; const DoOffSet: Boolean);
var
  ImageRect, ClipBox, ClientRect, Temp: TRect;
  Canvas: TCanvas;
  ClipComplexity: Integer;
begin
 if (ADC = 0) or not Background.DoDraw or (csDestroying in ComponentState) then
    Exit;
  ClientRect := Self.ClientRect;
  ClipComplexity := GetClipBox(ADC, ClipBox);
  if ClipComplexity = NULLREGION then
    Exit; // nothing to paint
  if ClipComplexity = ERROR then
    ClipBox := ClientRect;

  if DoOffSet then
    OffsetRect(ClientRect, FLeftPosition, 0);

  Canvas := TCanvas.Create;
  try
    Canvas.Handle := ADC;
    if Canvas.Handle = 0 then
      Exit;
    if Background.FillMode = bfmStretch then
      Canvas.StretchDraw(ClientRect, Background.Image)
    else
    begin
      ImageRect := Background.Image.Canvas.ClipRect;
      while ImageRect.Top < ClientRect.Bottom do
      begin
        while ImageRect.Left < ClientRect.Right do
        begin
          if IntersectRect(Temp, ClipBox, ImageRect) then
            Canvas.Draw(ImageRect.Left, ImageRect.Top, Background.Image);
          OffsetRect(ImageRect, ImageRect.Right - ImageRect.Left, 0);
        end;
        OffsetRect(ImageRect, -ImageRect.Left,
          ImageRect.Bottom - ImageRect.Top);
      end;
    end;
  finally
    Canvas.Handle := 0;
    Canvas.Free;
  end;
end;

procedure TJvCustomListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  if csDestroying in ComponentState then
    Exit;
  if Assigned(OnDrawItem) then
    inherited DrawItem(Index, Rect, State)
  else
  begin
    { Call the drawing code. This is isolated in its own public routine
      so a OnDrawItem handler can use it, too. }
    DefaultDrawItem(Index, Rect, State);
    if FShowFocusRect and (odFocused in State) then
      Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TJvCustomListBox.EndRedraw;
var
  R: TRect;
begin
  SendMessage(Handle, WM_SETREDRAW, Ord(True), 0);
  R := Rect(0, 0, Width, Height);
  InvalidateRect(Handle, {$IFNDEF CLR}@{$ENDIF}R, True);
end;

{$IFNDEF CLR}
procedure TJvCustomListBox.SetConsumerService(Value: TJvDataConsumer);
begin
end;

procedure TJvCustomListBox.ConsumerServiceChanging(Sender: TJvDataConsumer;
  Reason: TJvDataConsumerChangeReason);
begin
  { If we're changing providers, make sure a list box is created; this will post the saved list back
    now instead of after a provider is assigned (which will then be deselected again as the string
    list is changed). }
  if (Reason = ccrProviderSelect) and not (csDestroying in ComponentState) then
    HandleNeeded;
  if (Reason = ccrProviderSelect) and IsProviderSelected and not FProviderToggle then
  begin
    FProviderIsActive := False;
    FProviderToggle := True;
  end
  else
  if (Reason = ccrProviderSelect) and not IsProviderSelected and not FProviderToggle and
      not TJvListBoxStrings(Items).UseInternal then
    TJvListBoxStrings(Items).MakeListInternal;
end;

procedure TJvCustomListBox.ConsumerServiceChanged(Sender: TJvDataConsumer;
  Reason: TJvDataConsumerChangeReason);
begin
  if (Reason = ccrProviderSelect) and not IsProviderSelected and not FProviderToggle then
  begin
    FProviderToggle := True;
    FProviderIsActive := True;
    RecreateWnd;
{    if not TJvListBoxStrings(Items).UseInternal then
    begin
      TJvListBoxStrings(Items).MakeListInternal;
      RecreateWnd;
    end;}
  end
  else
  if (Reason = ccrProviderSelect) and not IsProviderSelected and FProviderToggle and
    TJvListBoxStrings(Items).UseInternal then
  begin
    RecreateWnd;
    TJvListBoxStrings(Items).ActivateInternal; // apply internal string list to list box
{  end
  else
  if (Reason = ccrProviderSelect) and IsProviderSelected and not FProviderToggle then
  begin
    FProviderIsActive := False;
    FProviderToggle := True;
    TJvListBoxStrings(Items).ActivateInternal; // apply internal string list to list box
    RecreateWnd;}
  end;
  if (not FProviderToggle or (Reason = ccrProviderSelect)) and IsProviderSelected then
  begin
    UpdateItemCount;
    Refresh;
  end;
  if FProviderToggle and (Reason = ccrProviderSelect) then
    FProviderToggle := False;
end;

procedure TJvCustomListBox.ConsumerSubServiceCreated(Sender: TJvDataConsumer;
  SubSvc: TJvDataConsumerAggregatedObject);
var
  VL: IJvDataConsumerViewList;
begin
  if SubSvc.GetInterface(IJvDataConsumerViewList, VL) then
  begin
    VL.ExpandOnNewItem := True;
    VL.AutoExpandLevel := -1;
    VL.RebuildView;
  end;
end;
{$ENDIF !CLR}

function TJvCustomListBox.IsProviderSelected: Boolean;
begin
  Result := FProviderIsActive;
end;

function TJvCustomListBox.IsProviderToggle: Boolean;
begin
  Result := FProviderToggle;
end;

procedure TJvCustomListBox.DeselectProvider;
begin
  {$IFNDEF CLR}
  Provider.Provider := nil;
  {$ENDIF !CLR}
end;

procedure TJvCustomListBox.UpdateItemCount;
var
  VL: IJvDataConsumerViewList;
  Cnt: Integer;
  EmptyChr: Char;
begin
  if HandleAllocated and IsProviderSelected
     {$IFNDEF CLR}
     and Supports(Provider as IJvDataConsumer, IJvDataConsumerViewList, VL)
     {$ENDIF !CLR}
     then
  begin
    Cnt := VL.Count - SendMessage(Handle, LB_GETCOUNT, 0, 0);
    EmptyChr := #0;
    while Cnt > 0 do
    begin
      {$IFDEF CLR}
      SendTextMessage(Handle, LB_ADDSTRING, 0, EmptyChr);
      {$ELSE}
      SendMessage(Handle, LB_ADDSTRING, 0, LParam(@EmptyChr));
      {$ENDIF CLR}
      Dec(Cnt);
    end;
    while Cnt < 0 do
    begin
      SendMessage(Handle, LB_DELETESTRING, 0, 0);
      Inc(Cnt);
    end;
  end;
end;

procedure TJvCustomListBox.LBFindString(var Msg: TMessage);
begin
  if IsProviderSelected then
    {$IFDEF CLR}
    Msg.Result := SearchPrefix(TWMSetText.Create(Msg).Text, False, Msg.WParam)
    {$ELSE}
    Msg.Result := SearchPrefix(PChar(Msg.LParam), False, Msg.WParam)
    {$ENDIF CLR}
  else
    inherited;
end;

procedure TJvCustomListBox.LBFindStringExact(var Msg: TMessage);
begin
  if IsProviderSelected then
    {$IFDEF CLR}
    Msg.Result := SearchExactString(TWMSetText.Create(Msg).Text, False, Msg.WParam)
    {$ELSE}
    Msg.Result := SearchExactString(PChar(Msg.LParam), False, Msg.WParam)
    {$ENDIF CLR}
  else
    inherited;
end;

procedure TJvCustomListBox.LBSelectString(var Msg: TMessage);
begin
  if IsProviderSelected then
  begin
    {$IFDEF CLR}
    Msg.Result := SearchExactString(TWMSetText.Create(Msg).Text, False, Msg.WParam);
    {$ELSE}
    Msg.Result := SearchExactString(PChar(Msg.LParam), False, Msg.WParam);
    {$ENDIF CLR}
    if Msg.Result > 0 then
      Perform(LB_SETCURSEL, Msg.Result, 0);
  end
  else
    inherited;
end;

procedure TJvCustomListBox.LBGetText(var Msg: TMessage);
begin
  {$IFNDEF CLR}
  if IsProviderSelected then
  begin
    if (Msg.WParam >= 0) and (Msg.WParam < ConsumerStrings.Count) then
    begin
      StrCopy(PChar(Msg.LParam), PChar(ConsumerStrings[Msg.WParam]));
      Msg.Result := StrLen(PChar(Msg.LParam));
    end
    else
      Msg.Result := LB_ERR;
  end
  else
  {$ENDIF !CLR}
    inherited;
end;

procedure TJvCustomListBox.LBGetTextLen(var Msg: TMessage);
begin
  {$IFNDEF CLR}
  if IsProviderSelected then
  begin
    if (Msg.WParam >= 0) and (Msg.WParam < ConsumerStrings.Count) then
      Msg.Result := Length(ConsumerStrings[Msg.WParam])
    else
      Msg.Result := LB_ERR;
  end
  else
  {$ENDIF !CLR}
    inherited;
end;

function TJvCustomListBox.GetDragImages: TDragImageList;
begin
  Result := FDragImage;
end;

function TJvCustomListBox.GetLimitToClientWidth: Boolean;
begin
  Result := FMultiline and (ScrollBars in [ssNone, ssVertical]);
end;

procedure TJvCustomListBox.InvertSelection;
var
  I: Integer;
begin
  if MultiSelect then
  begin
    ItemsShowing.BeginUpdate;
    for I := 0 to ItemsShowing.Count - 1 do
      Selected[I] := not Selected[I];
    ItemsShowing.EndUpdate;
  end;
end;

procedure TJvCustomListBox.LBAddString(var Msg: TMessage);
var
  LSize: TSize;
begin
  { (rb) Because TJvDirectoryListBox displays shorter strings than it stores in
         it's Items property - ie it stores the complete path, displays only
         the last part of a directory - the following code will cause the
         TJvCustomListBox think that the size of the strings are bigger than
         they really are (thus you probably will see a horizontal scroll bar)
  }
  if not LimitToClientWidth then
  begin
    {$IFDEF CLR}
    MeasureString(TWMSetText.Create(Msg).Text, 0, LSize);
    {$ELSE}
    MeasureString(PChar(Msg.LParam), 0, LSize);
    {$ENDIF CLR}
    if LSize.cx > FMaxWidth then
      SetMaxWidth(LSize.cx);
  end;
  inherited;
  if Assigned(FOnAddString) then
    {$IFDEF CLR}
    FOnAddString(Self, TWMSetText.Create(Msg).Text);
    {$ELSE}
    FOnAddString(Self, StrPas(PChar(Msg.LParam)));
    {$ENDIF CLR}
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TJvCustomListBox.LBDeleteString(var Msg: TMessage);
var
  LSize: TSize;
  InheritedCalled: Boolean;
begin
  InheritedCalled := False;
  if not LimitToClientWidth then
  begin
    if Msg.WParam < ItemsShowing.Count then
      MeasureString(ItemsShowing[Msg.WParam], 0, LSize)
    else
      LSize.cx := FMaxWidth;
    InheritedCalled := LSize.cx = FMaxWidth;
    if InheritedCalled then
    begin
      inherited;
      RemeasureAll;
    end;
  end;
  if (Msg.WParam < ItemsShowing.Count) and Assigned(FOnDeleteString) then
    FOnDeleteString(Self, ItemsShowing.Strings[Msg.WParam]);
  if not InheritedCalled then
    inherited;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TJvCustomListBox.LBInsertString(var Msg: TMessage);
var
  LSize: TSize;
begin
  if not LimitToClientWidth then
  begin
    {$IFDEF CLR}
    MeasureString(TWMSetText.Create(Msg).Text, 0, LSize);
    {$ELSE}
    MeasureString(PChar(Msg.LParam), 0, LSize);
    {$ENDIF CLR}
    if LSize.cx > FMaxWidth then
      SetMaxWidth(LSize.cx);
  end;
  inherited;
end;

procedure TJvCustomListBox.Loaded;
begin
  inherited Loaded;
  UpdateStyle;
end;

{$IFNDEF CLR}
procedure TJvCustomListBox.DrawProviderItem(Canvas: TCanvas; Rect: TRect; Index: Integer;
  State: TOwnerDrawState);
var
  DrawState: TProviderDrawStates;
  VL: IJvDataConsumerViewList;
  Item: IJvDataItem;
  ItemsRenderer: IJvDataItemsRenderer;
  ItemRenderer: IJvDataItemRenderer;
  ItemText: IJvDataItemText;
  AText: string;
begin
  DrawState := DP_OwnerDrawStateToProviderDrawState(State);
  if not Enabled then
    DrawState := DrawState + [pdsDisabled, pdsGrayed];
  Provider.Enter;
  try
    if Supports(Provider as IJvDataConsumer, IJvDataConsumerViewList, VL) then
    begin
      Item := VL.Item(Index);
      if Item <> nil then
      begin
        Inc(Rect.Left, VL.ItemLevel(Index) * VL.LevelIndent);
        if Supports(Item, IJvDataItemRenderer, ItemRenderer) then
          ItemRenderer.Draw(Canvas, Rect, DrawState)
        else
        if DP_FindItemsRenderer(Item, ItemsRenderer) then
          ItemsRenderer.DrawItem(Canvas, Rect, Item, DrawState)
        else
        if Supports(Item, IJvDataItemText, ItemText) then
        begin
          AText := ItemText.Caption;
          DoGetText(Index,AText);
          Canvas.TextRect(Rect, Rect.Left, Rect.Top, AText);
        end
        else
        begin
          AText := RsDataItemRenderHasNoText;
          DoGetText(Index,AText);
          Canvas.TextRect(Rect, Rect.Left, Rect.Top, AText);
        end;
      end;
    end;
  finally
    Provider.Leave;
  end;
end;
{$ENDIF !CLR}

procedure TJvCustomListBox.DoGetText(Index: Integer; var AText: string);
begin
  if Assigned(FOnGetText) then
    FOnGetText(Self, Index, AText);
end;

procedure TJvCustomListBox.MeasureItem(Index: Integer;
  var Height: Integer);
var
  AvailWidth: Integer;
  LSize: TSize;
begin
  if Assigned(OnMeasureItem) or (not MultiLine and not IsProviderSelected) or
    (Index < 0) or (Index >= ItemsShowing.Count) then
    inherited MeasureItem(Index, Height)
  else
  begin
    if LimitToClientWidth then
      AvailWidth := ClientWidth
    else
      AvailWidth := MaxInt;

    {$IFNDEF CLR}
    if IsProviderSelected then
      MeasureProviderItem(Index, AvailWidth, LSize)
    else
    {$ENDIF !CLR}
      MeasureString(ItemsShowing[Index], AvailWidth, LSize);

    Height := LSize.cy;
  end;
end;

{$IFNDEF CLR}
procedure TJvCustomListBox.MeasureProviderItem(Index, WidthAvail: Integer; var ASize: TSize);
var
  VL: IJvDataConsumerViewList;
  Item: IJvDataItem;
  ItemsRenderer: IJvDataItemsRenderer;
  ItemRenderer: IJvDataItemRenderer;
  ItemText: IJvDataItemText;
begin
  Canvas.Font := Font;
  { Note: doing the TextHeight unconditionally makes sure the font is properly
    selected into the device context. }
  ASize.cy := CanvasMaxTextHeight(Canvas);
  ASize.cx := ClientWidth - 4;
  Provider.Enter;
  try
    if Supports(Provider as IJvDataConsumer, IJvDataConsumerViewList, VL) then
    begin
      Item := VL.Item(Index);
      if Item <> nil then
      begin
        if Supports(Item, IJvDataItemRenderer, ItemRenderer) then
          ASize := ItemRenderer.Measure(Canvas)
        else
        if DP_FindItemsRenderer(Item, ItemsRenderer) then
          ASize := ItemsRenderer.MeasureItem(Canvas, Item)
        else
        if Supports(Item, IJvDataItemText, ItemText) then
          ASize := Canvas.TextExtent(ItemText.Caption)
        else
          ASize := Canvas.TextExtent(RsDataItemRenderHasNoText);
        Inc(ASize.cx, VL.ItemLevel(Index) * VL.LevelIndent);
      end;
    end;
  finally
    Provider.Leave;
  end;
  { Note: item height in a listbox is limited to 255 pixels since Windows
    stores the height in a single byte.}
  if ASize.cy > 255 then
    ASize.cy := 255;
  if ASize.cy < ItemHeight then
    ASize.cy := ItemHeight;
end;
{$ENDIF !CLR}

procedure TJvCustomListBox.MeasureString(const S: string; WidthAvail: Integer; var ASize: TSize);
var
  Flags: Longint;
  R: TRect;
begin
  Canvas.Font := Font;
  { Note: doing the TextHeight unconditionally makes sure the font is properly
    selected into the device context. }
  ASize.cx := Canvas.TextHeight(S);

  Flags := DrawTextBiDiModeFlags(
    DT_WORDBREAK or DT_NOPREFIX or DT_CALCRECT or AlignFlags[FAlignment]);
  if WidthAvail = 0 then
    WidthAvail := MaxInt
  else
    Dec(WidthAvail, 2);
  R := Rect(0, 0, WidthAvail, 1);
  DrawText(Canvas.Handle, {$IFDEF CLR} S {$ELSE} PChar(S) {$ENDIF}, Length(S), R, Flags);
  ASize.cx := R.Right + 4;
  ASize.cy := R.Bottom;

  { Note: item height in a listbox is limited to 255 pixels since Windows
    stores the height in a single byte.}
  if ASize.cy > 255 then
    ASize.cy := 255;
  if ASize.cy < ItemHeight then
    ASize.cy := ItemHeight;
end;

procedure TJvCustomListBox.MoveSelectedDown;
var
  I: Integer;
begin
  if not IsProviderSelected then
  begin
    if not MultiSelect then
    begin
      if (ItemIndex <> -1) and (ItemIndex < Items.Count - 1) then
      begin
        Items.Exchange(ItemIndex, ItemIndex + 1);
        ItemIndex := ItemIndex + 1;
      end;
      Exit;
    end;
    if (Items.Count > 0) and (SelCount > 0) and (not Selected[Items.Count - 1]) then
    begin
      I := Items.Count - 2;
      while I >= 0 do
      begin
        if Selected[I] then
        begin
          Items.Exchange(I, I + 1);
          Selected[I + 1] := True;
        end;
        Dec(I);
      end;
    end;
  end;
end;

procedure TJvCustomListBox.MoveSelectedUp;
var
  I: Integer;
begin
  if not IsProviderSelected then
  begin
    if not MultiSelect then
    begin
      if ItemIndex > 0 then
      begin
        Items.Exchange(ItemIndex, ItemIndex - 1);
        ItemIndex := ItemIndex - 1;
      end;
      Exit;
    end;
    if (Items.Count > 0) and (SelCount > 0) and not Selected[0] then
    begin
      I := 1;
      while I < Items.Count do
      begin
        if Selected[I] then
        begin
          Items.Exchange(I, I - 1);
          Selected[I - 1] := True;
        end;
        Inc(I);
      end;
    end;
  end;
end;

procedure TJvCustomListBox.RemeasureAll;
var
  I: Integer;
  LMaxWidth, cx: Integer;
  LItemSize: TSize;
begin
  LMaxWidth := 0;
  if LimitToClientWidth then
    cx := ClientWidth
  else
    cx := 0;

  for I := 0 to ItemsShowing.Count - 1 do
  begin
    MeasureString(ItemsShowing[I], cx, LItemSize);
    if MultiLine then
      Perform(LB_SETITEMHEIGHT, I, LItemSize.cy);

    if not LimitToClientWidth and (LItemSize.cx > LMaxWidth) then
      LMaxWidth := LItemSize.cx;
  end;
  if not LimitToClientWidth then
    MaxWidth := LMaxWidth;
end;

function TJvCustomListBox.SearchExactString(const Value: string;
  CaseSensitive: Boolean; StartIndex: Integer): Integer;
begin
  Result := TJvItemsSearchs.SearchExactString(ItemsShowing, Value, CaseSensitive, StartIndex);
end;

function TJvCustomListBox.SearchPrefix(const Value: string;
  CaseSensitive: Boolean; StartIndex: Integer): Integer;
begin
  Result := TJvItemsSearchs.SearchPrefix(ItemsShowing, Value, CaseSensitive, StartIndex);
end;

function TJvCustomListBox.SearchSubString(const Value: string;
  CaseSensitive: Boolean; StartIndex: Integer): Integer;
begin
  Result := TJvItemsSearchs.SearchSubString(ItemsShowing, Value, CaseSensitive, StartIndex);
end;

procedure TJvCustomListBox.SelectAll;
var
  I: Integer;
begin
  if MultiSelect then
  begin
    ItemsShowing.BeginUpdate;
    for I := 0 to ItemsShowing.Count - 1 do
      Selected[I] := True;
    ItemsShowing.EndUpdate;
  end;
end;

procedure TJvCustomListBox.SelectCancel(var Msg: TMessage);
begin
  if Assigned(FOnSelectCancel) then
    FOnSelectCancel(Self);
end;

procedure TJvCustomListBox.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;

    UpdateStyle;
    Invalidate;
  end;
end;

procedure TJvCustomListBox.SetBackground(const Value: TJvListBoxBackground);
begin
  FBackground.Assign(Value);
end;

procedure TJvCustomListBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if Alignment <> taLeftJustify then
    Repaint;
end;

procedure TJvCustomListBox.SetDisabledTextColor(const Value: TColor);
begin
  if FDisabledTextColor <> Value then
  begin
    FDisabledTextColor := Value;
    Invalidate;
  end;
end;

procedure TJvCustomListBox.SetHotTrack(const Value: Boolean);
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    Ctl3D := not FHotTrack;
  end;
end;

procedure TJvCustomListBox.SetMaxWidth(const Value: Integer);
begin
  if not LimitToClientWidth and (FMaxWidth <> Value) then
  begin
    FMaxWidth := Value;
    Perform(LB_SETHORIZONTALEXTENT, Value, 0);
  end;
end;

procedure TJvCustomListBox.SetMultiline(const Value: Boolean);
begin
  if FMultiline <> Value then
  begin
    FMultiline := Value;

    UpdateStyle;
    if FMultiline then
    begin
      // make sure scrollbars matches
      if ScrollBars = ssBoth then
        ScrollBars := ssVertical;
      if ScrollBars = ssHorizontal then
        ScrollBars := ssNone;
      FMaxWidth := 0;
      Perform(LB_SETHORIZONTALEXTENT, 0, 0);
    end
    else
      RemeasureAll;
  end;
end;

procedure TJvCustomListBox.SetScrollBars(const Value: TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TJvCustomListBox.SetSelectedColor(const Value: TColor);
begin
  if FSelectedColor <> Value then
  begin
    FSelectedColor := Value;
    Invalidate;
  end;
end;

procedure TJvCustomListBox.SetSelectedTextColor(const Value: TColor);
begin
  if FSelectedTextColor <> Value then
  begin
    FSelectedTextColor := Value;
    Invalidate;
  end;
end;

procedure TJvCustomListBox.SetShowFocusRect(const Value: Boolean);
const
  CShowFocusRect: array [Boolean] of Integer = (0, 2);
begin
  if FShowFocusRect <> Value then
  begin
    FShowFocusRect := Value;

    ItemHeight := CanvasMaxTextHeight(Canvas) + CShowFocusRect[ShowFocusRect];
    RemeasureAll;
    if Focused then
      Invalidate;
  end;
end;

procedure TJvCustomListBox.SetSorted(const Value: Boolean);
begin
  if FSorted <> Value then
  begin
    FSorted := Value;
    RecreateWnd;
  end;
end;

procedure TJvCustomListBox.UnselectAll;
var
  I: Integer;
begin
  if MultiSelect then
  begin
    ItemsShowing.BeginUpdate;
    for I := 0 to ItemsShowing.Count - 1 do
      Selected[I] := False;
    ItemsShowing.EndUpdate;
  end
  else
    ItemIndex := -1;
end;

procedure TJvCustomListBox.UpdateHorizontalExtent;
begin
  if HandleAllocated and (FScrollBars in [ssHorizontal, ssBoth]) then
    RemeasureAll;
  //    SendMessage(Handle, LB_SETHORIZONTALEXTENT, FHorizontalExtent, 0);
end;

procedure TJvCustomListBox.UpdateStyle;
const
  CShowFocusRect: array [Boolean] of Integer = (0, 2);
var
  PreviousStyle: TListBoxStyle;
begin
  if csLoading in ComponentState then
    Exit;

  PreviousStyle := Style;

  if MultiLine then
    Style := lbOwnerDrawVariable
  else
  if Alignment <> taLeftJustify then
    Style := lbOwnerDrawFixed;

  if (PreviousStyle = lbStandard) and (Style <> lbStandard) then
  begin
    ItemHeight := CanvasMaxTextHeight(Canvas) + CShowFocusRect[ShowFocusRect];
    RemeasureAll;
  end;
end;

function TJvCustomListBox.DoEraseBackground(Canvas: TCanvas; Param: Integer): Boolean;
begin
  if not Background.DoDraw then
    Result := inherited DoEraseBackground(Canvas, Param)
  else
  begin
    Result := True;
    DrawBackGround(Canvas.Handle, False);
  end;
end;

procedure TJvCustomListBox.WMHScroll(var Msg: TWMHScroll);
var
  DontScroll: Boolean;
  DoUpdate: Boolean;
  ScrollInfo: TScrollInfo;
begin
  DoUpdate := Background.DoDraw;

  if DoUpdate then
    BeginRedraw;
  try
    if Assigned(FOnHorizontalScroll) then
    begin
      DontScroll := False;
      FOnHorizontalScroll(Self, Msg, DontScroll);
      if DontScroll then
        Exit;
    end;
    inherited;

    if DoUpdate and (FMaxWidth > 0) then
    begin
      with ScrollInfo do
      begin
        cbSize := SizeOf(ScrollInfo);
        fMask := SIF_ALL;
        if GetScrollInfo(Handle, SB_HORZ, ScrollInfo) then
          FLeftPosition := Round((FMaxWidth / nMax) * nPos);
      end;
    end
    else
      FLeftPosition := 0;

    //if DoUpdate then
    //  Invalidate;
  finally
    if DoUpdate then
      EndRedraw;
  end;
end;

procedure TJvCustomListBox.WMVScroll(var Msg: TWMVScroll);
var
  DontScroll: Boolean;
  DoUpdate: Boolean;
begin
  DoUpdate := Background.DoDraw;

  if DoUpdate then
    BeginRedraw;
  try
    if Assigned(FOnVerticalScroll) then
    begin
      DontScroll := False;
      FOnVerticalScroll(Self, Msg, DontScroll);
      if DontScroll then
        Exit;
    end;
    inherited;

    //if DoUpdate then
    //  Invalidate;
  finally
    if DoUpdate then
      EndRedraw;
  end;
end;

function TJvCustomListBox.ItemRect(Index: Integer): TRect;
var
  Count: Integer;
begin
  Count := ItemsShowing.Count;
  {$IFDEF CLR}
  if (Index >= 0) and (Index < Count) then
    Perform(LB_GETITEMRECT, Index, Result)
  else
  if Index = Count then
  begin
    Perform(LB_GETITEMRECT, Index - 1, Result);
    OffsetRect(Result, 0, Result.Bottom - Result.Top);
  end
  else
    Result := Rect(0, 0, 0, 0);
  {$ELSE}
  if (Index >= 0) and (Index < Count) then
    Perform(LB_GETITEMRECT, Index, Longint(@Result))
  else
  if Index = Count then
  begin
    Perform(LB_GETITEMRECT, Index - 1, Longint(@Result));
    OffsetRect(Result, 0, Result.Bottom - Result.Top);
  end
  else
    FillChar(Result, SizeOf(Result), 0);
  {$ENDIF CLR}
end;

function TJvCustomListBox.ItemsShowing: TStrings;
begin
  {$IFNDEF CLR}
  if IsProviderSelected then
    Result := ConsumerStrings
  else
  {$ENDIF !CLR}
    Result := Items;
end;

procedure TJvCustomListBox.WndProc(var Msg: TMessage);
var
  ItemWidth: Word;
begin
  case Msg.Msg of
    LB_ADDSTRING, LB_INSERTSTRING:
      begin
        {$IFDEF CLR}
        ItemWidth := Canvas.TextWidth(TWMSetText.Create(Msg).Text + ' ');
        {$ELSE}
        ItemWidth := Canvas.TextWidth(StrPas(PChar(Msg.LParam)) + ' ');
        {$ENDIF CLR}
        if FMaxWidth < ItemWidth then
          FMaxWidth := ItemWidth;
        SendMessage(Handle, LB_SETHORIZONTALEXTENT, FMaxWidth, 0);
      end;
    LB_DELETESTRING:
      begin
        if Msg.WParam < ItemsShowing.Count then
          ItemWidth := Canvas.TextWidth(ItemsShowing[Msg.WParam] + ' ')
        else
          ItemWidth := FMaxWidth;
        if ItemWidth = FMaxWidth then
        begin
          inherited WndProc(Msg);
          UpdateHorizontalExtent;
          Exit;
        end;
      end;
    LB_RESETCONTENT:
      SendMessage(Handle, LB_SETHORIZONTALEXTENT, 0, 0);
    WM_SETFONT:
      begin
        inherited WndProc(Msg);
        Canvas.Font.Assign(Font);
        UpdateHorizontalExtent;
        Exit;
      end;
  end;
  inherited WndProc(Msg);
end;

//=== { TJvListBoxBackground } ===============================================

constructor TJvListBoxBackground.Create;
begin
  inherited Create;
  FImage := TBitmap.Create;
end;

destructor TJvListBoxBackground.Destroy;
begin
  FImage.Free;
  inherited Destroy;
end;

procedure TJvListBoxBackground.Assign(Source: TPersistent);
begin
  if Source is TJvListBoxBackground then
  begin
    FImage.Assign(TJvListBoxBackground(Source).Image);
    FFillMode := TJvListBoxBackground(Source).FillMode;
    FVisible := TJvListBoxBackground(Source).Visible;
  end
  else
    inherited Assign(Source);
end;

procedure TJvListBoxBackground.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TJvListBoxBackground.GetDoDraw: Boolean;
begin
  Result := Visible and not Image.Empty;
end;

procedure TJvListBoxBackground.SetFillMode(const Value: TJvListboxFillMode);
begin
  if FFillMode <> Value then
  begin
    FFillMode := Value;
    Change;
  end;
end;

procedure TJvListBoxBackground.SetImage(const Value: TBitmap);
begin
  FImage.Assign(Value);
  Change;
end;

procedure TJvListBoxBackground.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Change;
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

