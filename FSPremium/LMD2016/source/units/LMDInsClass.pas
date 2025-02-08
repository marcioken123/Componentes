unit LMDInsClass;
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

LMDInsClass unit (YB)
------------------------
Unit contains bases classes needed in LMD InspectorPack.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms, StdCtrls,
  Grids, TypInfo, Themes, Dialogs, LMDInsCst, LMDTypes;

{$R LMDInsClass.res}

type
  { ************************** class TLMDObjectList ************************** }

  ELMDObjectList  = class(Exception);
  TLMDItemByProc  = procedure(AItem: TObject; AData: TLMDDataTag;
                              var AResult: Boolean) of object;

  TLMDObjectList = class
  private
    FItems        : TList;
    FChangingCount: Boolean;

    function  GetItems(AIndex: Integer): TObject;
    function  GetCount: Integer;
    procedure SetCount(const Value: Integer);
  protected
    function  CreateItem: TObject; virtual;
    procedure Change; virtual;
    procedure Added; virtual;
    procedure Deleted; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    function  DoItemBy(AData: TLMDDataTag; AItemByProc: TLMDItemByProc): TObject;
    function  DoFind(AData: TLMDDataTag; AItemByProc: TLMDItemByProc): TObject;
    function  DoSearch(AData: TLMDDataTag; AItemByProc: TLMDItemByProc): TObject;
    function  Add: Integer;
    procedure Remove(AItem: TObject);
    procedure Delete(AIndex: Integer);
    procedure Clear;
    function  IndexOf(AItem: TObject): Integer;
    property  Items[AIndex: Integer]: TObject read GetItems; default;
    property  Count: Integer read GetCount write SetCount;
  end;

{******************************* Quick sort ***********************************}

type
  TLMDQSCompareProc  = function(AItemIndex1, AItemIndex2: Integer;
                                AData: TLMDDataTag): Integer;
  TLMDQSExchangeProc = procedure(AItemIndex1, AItemIndex2: Integer;
                                 AData: TLMDDataTag);

procedure LMDQuickSort(ALow, AHigh: Integer; ACompareProc: TLMDQSCompareProc;
                       AExchangeProc: TLMDQSExchangeProc; AData: TLMDDataTag);

{******************************* Hint hooking *********************************}

type
  TLMDHintHookProc = procedure(var AMsg: TMsg) of object;

procedure LMDHookHint(AHookProc: TLMDHintHookProc);
procedure LMDUnhookHint(AHookProc: TLMDHintHookProc);

{************************ Unicode related base classes ************************}

type
  {$IFDEF _LMD_UNICODEIMPL}

  TLMDEditStyle               = (esSimple, esEllipsis, esPickList);
  TLMDGridBase                = class;
  TLMDGridBaseInplaceEditList = class;

  TLMDOnGetPickListItems = procedure(ACol, ARow: Integer;
                                     Items: TLMDStrings) of object;

  TLMDListBoxItems = class(TLMDStrings)
  private
    FListBox:  TCustomListBox;
    FOldItems: TStrings;
  protected
    function  Get(Index: Integer): WideString; override;
    function  GetCount: Integer; override;
    function  GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: WideString); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(AListBox: TCustomListBox; AOldItems: TStrings);

    function  IndexOf(const S: WideString): Integer; override;
    procedure Clear; override;
    function  Add(const S: WideString): Integer; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: WideString); override;
    procedure Exchange(Index1, Index2: Integer); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
  end;

  TLMDGridBasePopupListBox = class(TCustomListbox)
  private
    FItems:           TLMDStrings;
    FSearchText:      TLMDString;
    FSearchTickCount: Longint;

    procedure SetItems(const Value: TLMDStrings);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                      X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddItem(const AItem: TLMDString;
                      AObject: TObject); reintroduce; virtual;
    property  Items: TLMDStrings read FItems write SetItems;
  end;

  TLMDGridBaseInplaceEditList = class(TInPlaceEdit)
  private
    FButtonWidth        : Integer;
    FPickList           : TLMDGridBasePopupListBox;
    FActiveList         : TLMDGridBasePopupListBox;
    FEditStyle          : TLMDEditStyle;
    FDropDownRows       : Integer;
    FListVisible        : Boolean;
    FTracking           : Boolean;
    FPressed            : Boolean;
    FPickListLoaded     : Boolean;
    FMouseInControl     : Boolean;
    FOnGetPickListitems : TLMDOnGetPickListItems;
    FOnEditButtonClick  : TNotifyEvent;

    function  GetText: WideString;
    procedure SetText(const Value: WideString); reintroduce;
    function  GetPickList: TLMDGridBasePopupListBox;
    function  GetGrid: TLMDGridBase;
    procedure KillMessage(Wnd: HWnd; Msg: Integer);
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure BoundsChanged; override;
    function  ButtonRect: TRect;
    procedure CloseUp(Accept: Boolean); dynamic;
    procedure DblClick; override;
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState); virtual;
    procedure DoEditButtonClick; virtual;
    procedure DoGetPickListItems; dynamic;
    procedure DropDown; dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
                          Shift: TShiftState; X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                      X, Y: Integer); override;
    function  OverButton(const P: TPoint): Boolean;
    procedure PaintWindow(DC: HDC); override;
    procedure StopTracking;
    procedure TrackButton(X,Y: Integer);
    procedure UpdateContents; override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(Owner: TComponent); override;

    procedure RestoreContents;
    property  Grid: TLMDGridBase read GetGrid;
    property  ActiveList: TLMDGridBasePopupListBox read FActiveList write FActiveList;
    property  ButtonWidth: Integer read FButtonWidth write FButtonWidth;
    property  DropDownRows: Integer read FDropDownRows write FDropDownRows;
    property  EditStyle: TLMDEditStyle read FEditStyle;
    property  ListVisible: Boolean read FListVisible write FListVisible;
    property  Text: WideString read GetText write SetText;
    property  PickList: TLMDGridBasePopupListBox read GetPickList;
    property  PickListLoaded: Boolean read FPickListLoaded write FPickListLoaded;
    property  Pressed: Boolean read FPressed;
    property  OnEditButtonClick: TNotifyEvent read FOnEditButtonClick write FOnEditButtonClick;
    property  OnGetPickListitems: TLMDOnGetPickListItems read FOnGetPickListitems write FOnGetPickListitems;
  end;

  TLMDInternalGridBase = class(TCustomGrid)
  protected
    function  GetEditText(ACol, ARow: Longint): string; override;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
  end;

  TLMDGridBase = class(TLMDInternalGridBase)
  private
    procedure UpdateText;
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    function  GetEditText(ACol, ARow: Longint): TLMDString; reintroduce; dynamic;
    procedure SetEditText(ACol, ARow: Longint; const Value: TLMDString); reintroduce; dynamic;
    function  GetEditStyle(ACol, ARow: Longint): TLMDEditStyle; reintroduce; dynamic;
  end;

  {$ELSE} // _LMD_UNICODEIMPL

  TLMDEditStyle               = TEditStyle;
  TLMDGridBase                = TCustomGrid;
  TLMDGridBaseInplaceEditList = TInplaceEditList;

  {$ENDIF} // ELSE _LMD_UNICODEIMPL

implementation

uses
  Consts, Types, RTLConsts, Variants,
  LMDProcs, LMDUnicodeControl;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

var
  LMDHintHook:       HHOOK;
  LMDHintHooksProcs: TList;

type
  TComponentAccess  = class(TComponent);
  TPersistentAccess = class(TPersistent);
  TListBoxAccess    = class(TCustomListBox);
  TStringsAccess    = class(TStrings);

{ ---------------------------------------------------------------------------- }
procedure LMDQuickSort(ALow, AHigh: Integer; ACompareProc: TLMDQSCompareProc;
  AExchangeProc: TLMDQSExchangeProc; AData: TLMDDataTag);

  procedure _Sort(AFromIndex, AToIndex: Integer);
  var
    LI, LJ, LCenter: Integer;
  begin
    repeat
      LI := AFromIndex;
      LJ := AToIndex;
      LCenter := (AFromIndex + AToIndex) div 2;
      repeat
        while ACompareProc(LI, LCenter, AData) < 0 do Inc(LI);
        while ACompareProc(LJ, LCenter, AData) > 0 do Dec(LJ);
        if LI <= LJ then
        begin
          AExchangeProc(LI, LJ, AData);
          if LCenter = LI then
            LCenter := LJ
          else if LCenter = LJ then
            LCenter := LI;
          Inc(LI);
          Dec(LJ);
        end;
      until LI > LJ;
      if AFromIndex < LJ then _Sort(AFromIndex, LJ);
      AFromIndex := LI;
    until LI >= AToIndex;
  end;

begin
  if AHigh > ALow then
    _Sort(ALow, AHigh);
end;

{ ---------------------------------------------------------------------------- }
function LMDHintHookMsgProc(ACode: Integer; AParam: Longint;
  var AMsg: TMsg): Longint; stdcall;
var
  LI: Integer;
  LList: TList;
begin
  Result := CallNextHookEx(LMDHintHook, ACode, AParam, LPARAM(@AMsg));

  if LMDHintHooksProcs <> nil then
  begin
    LList := TList.Create;
    try
      for LI := 0 to LMDHintHooksProcs.Count - 1 do
        LList.Add(LMDHintHooksProcs[LI]);
      for LI := 0 to LList.Count - 1 do
        TLMDHintHookProc(LList[LI]^)(AMsg);
    finally
      LList.Free;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDClearHintHooks;
var
  LProc: ^TLMDHintHookProc;
  LI: Integer;
begin
  if LMDHintHooksProcs <> nil then
  begin
    for LI := 0 to LMDHintHooksProcs.Count - 1 do
    begin
      LProc := LMDHintHooksProcs[LI];
      Dispose(LProc);
    end;
    LMDHintHooksProcs.Free;
    LMDHintHooksProcs := nil;
    if LMDHintHook <> 0 then UnhookWindowsHookEx(LMDHintHook);
    LMDHintHook := 0;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDHookHint(AHookProc: TLMDHintHookProc);
var
  LProc: ^TLMDHintHookProc;
begin
  if LMDHintHooksProcs = nil then
    LMDHintHooksProcs := TList.Create;

  New(LProc);
  LProc^ := AHookProc;
  LMDHintHooksProcs.Add(LProc);

  if LMDHintHook = 0 then
  begin
    LMDHintHook := SetWindowsHookEx(WH_GETMESSAGE, @LMDHintHookMsgProc,
      0, GetCurrentThreadID);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDUnhookHint(AHookProc: TLMDHintHookProc);
var
  LProc: ^TLMDHintHookProc;
  LI: Integer;
begin
  if LMDHintHooksProcs <> nil then
  begin
    for LI := 0 to LMDHintHooksProcs.Count - 1 do
    begin
      LProc := LMDHintHooksProcs[LI];
      if (TMethod(LProc^).Code = TMethod(AHookProc).Code) and
        (TMethod(LProc^).Data = TMethod(AHookProc).Data) then
      begin
        Dispose(LProc);
        LMDHintHooksProcs.Delete(LI);
        Break;
      end;
    end;
    if LMDHintHooksProcs.Count = 0 then
    begin
      LMDHintHooksProcs.Free;
      LMDHintHooksProcs := nil;
      if LMDHintHook <> 0 then UnhookWindowsHookEx(LMDHintHook);
      LMDHintHook := 0;
    end;
  end;
end;

{ ************************ class TLMDObjectList ****************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDObjectList.GetItems(AIndex: Integer): TObject;
begin
  Result := FItems[AIndex];
end;

{ ---------------------------------------------------------------------------- }
function TLMDObjectList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDObjectList.SetCount(const Value: Integer);
begin
  FChangingCount := True;
  try
    if Value > Count then
      while Count < Value do Add
    else if Value < Count then
      while Count > Value do Delete(Count - 1);
  finally
    FChangingCount := False;
  end;
  Change;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDObjectList.CreateItem: TObject;
begin
  Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDObjectList.Change;
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDObjectList.Added;
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDObjectList.Deleted;
begin
  // Do nothing
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDObjectList.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDObjectList.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDObjectList.DoItemBy(AData: TLMDDataTag;
  AItemByProc: TLMDItemByProc): TObject;
begin
  Result := DoFind(AData, AItemByProc);
  if Result = nil then
    raise ELMDObjectList.Create(SLMDItemNotFound);
end;

{ ---------------------------------------------------------------------------- }
function TLMDObjectList.DoFind(AData: TLMDDataTag;
  AItemByProc: TLMDItemByProc): TObject;
var
  LI: Integer;
  LResult: Boolean;
begin
  Result := nil;
  for LI := 0 to Count - 1 do
    begin
      LResult := False;
      AItemByProc(Items[LI], AData, LResult);
      if LResult then
        begin
          Result := Items[LI];
          Break;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDObjectList.DoSearch(AData: TLMDDataTag;
  AItemByProc: TLMDItemByProc): TObject;
var
  LI: Integer;
begin
  Result := DoFind(AData, AItemByProc);
  if Result = nil then
    for LI := 0 to Count - 1 do
      if (Items[LI] <> nil) and (Items[LI] is TLMDObjectList) then
        begin
          Result := TLMDObjectList(Items[LI]).DoSearch(AData, AItemByProc);
          if Result <> nil then Break;
        end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDObjectList.Add: Integer;
begin
  Result := FItems.Add(CreateItem);
  Added;
  if not FChangingCount then Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDObjectList.Remove(AItem: TObject);
var
  LI: Integer;
begin
  LI := FItems.IndexOf(AItem);
  if LI <> -1 then Delete(LI);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDObjectList.Delete(AIndex: Integer);
begin
  TObject(FItems[AIndex]).Free;
  FItems.Delete(AIndex);
  Deleted;
  if not FChangingCount then Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDObjectList.Clear;
begin
  Count := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDObjectList.IndexOf(AItem: TObject): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

{*************************** TLMDInternalGridBase *****************************}
{ ---------------------------------------------------------------------------- }

{$IFDEF _LMD_UNICODEIMPL}

function TLMDInternalGridBase.GetEditText(ACol, ARow: Integer): string;
begin
  Assert(False);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDInternalGridBase.SetEditText(ACol, ARow: Integer;
  const Value: string);
begin
  TLMDGridBase(Self).SetEditText(ACol, ARow,
    LMDGetControlText(InplaceEditor));
end;

{$ENDIF} // _LMD_UNICODEIMPL

{ *************************** class TLMDGridBase ***************************** }
{ -------------------------------- private ----------------------------------- }

{$IFDEF _LMD_UNICODEIMPL}

procedure TLMDGridBase.UpdateText;
begin
  if (InplaceEditor <> nil) and EditorMode then
    SetEditText(Col, Row, LMDGetControlText(InplaceEditor));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDGridBase.CreateWindowHandle(const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, '');
end;

{ ---------------------------------------------------------------------------- }

function TLMDGridBase.GetEditText(ACol, ARow: Integer): TLMDString;
begin
  Result := '';
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDGridBase.SetEditText(ACol, ARow: Integer;
  const Value: TLMDString);
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

function TLMDGridBase.GetEditStyle(ACol, ARow: Integer): TLMDEditStyle;
begin
  Result := esSimple;
end;

{$ENDIF} // _LMD_UNICODEIMPL

{ ******************* class TLMDGridBaseInplaceEditList ********************** }
{ --------------------------------- private ---------------------------------- }

{$IFDEF _LMD_UNICODEIMPL}

function TLMDGridBaseInplaceEditList.GetPickList: TLMDGridBasePopupListBox;
begin
  if not Assigned(FPickList) then
  begin
    FPickList := TLMDGridBasePopupListBox.Create(Self);

    FPickList.Visible        := False;
    FPickList.Parent         := Self;
    FPickList.OnMouseUp      := ListMouseUp;
    FPickList.IntegralHeight := True;
    FPickList.ItemHeight     := 11;
  end;

  Result := FPickList;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> ActiveList) then
    CloseUp(False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.WMKillFocus(var Message: TMessage);
begin
  if not SysLocale.FarEast then inherited
  else
    begin
      ImeName := Screen.DefaultIme;
      ImeMode := imDontCare;
      inherited;
      if HWND(Message.WParam) <> Grid.Handle then
        ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
    end;
  CloseUp(False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.WMLButtonDblClk(
  var Message: TWMLButtonDblClk);
begin
  with Message do
  if (EditStyle <> esSimple) and OverButton(Point(XPos, YPos)) then
    Exit;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if (EditStyle <> esSimple) and OverButton(P) then
    Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if ThemeServices.ThemesEnabled and not FMouseInControl then
  begin
    FMouseInControl := True;
    Invalidate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if ThemeServices.ThemesEnabled and FMouseInControl then
  begin
    FMouseInControl := False;
    Invalidate;
  end;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDGridBaseInplaceEditList.BoundsChanged;
var
  R: TRect;
begin
  SetRect(R, 2, 2, Width - 2, Height);
  if EditStyle <> esSimple then
    if not Grid.UseRightToLeftAlignment then
      Dec(R.Right, ButtonWidth)
    else
      Inc(R.Left, ButtonWidth - 2);
  LMDSendMessage(Handle, EM_SETRECTNP, 0, LPARAM(@R));
  LMDSendMessage(Handle, EM_SCROLLCARET, 0, 0);
  if SysLocale.FarEast then
    SetImeCompositionWindow(Font, R.Left, R.Top);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGridBaseInplaceEditList.ButtonRect: TRect;
begin
  if not Grid.UseRightToLeftAlignment then
    Result := Rect(Width - ButtonWidth, 0, Width, Height)
  else
    Result := Rect(0, 0, ButtonWidth, Height);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.CloseUp(Accept: Boolean);
var
  LListValue: TLMDString;
begin
  if ListVisible and (ActiveList = FPickList) then
  begin
    if GetCapture <> 0 then
      LMDSendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if PickList.ItemIndex <> -1 then
      LListValue := PickList.Items[PickList.ItemIndex];

    SetWindowPos(ActiveList.Handle, 0, 0, 0, 0, 0,
                 SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or
                 SWP_NOACTIVATE or SWP_HIDEWINDOW);

    FListVisible := False;
    Invalidate;

    if Accept then
    begin
      if (LListValue <> '') and (LListValue <> Text) then
      begin
        LMDSendMessage(Handle, WM_SETTEXT, 0, LPARAM(PLMDChar(LListValue)));
        Modified := True;

        Grid.SetEditText(Grid.Col, Grid.Row, LListValue);
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.DblClick;
var
  Index:     Integer;
  ListValue: TLMDString;
begin
  if (EditStyle = esSimple) or Assigned(Grid.OnDblClick) then
    inherited
  else if (EditStyle = esPickList) and (ActiveList = PickList) then
    begin
      DoGetPickListItems;
      if PickList.Items.Count > 0 then
        begin
          Index := PickList.ItemIndex + 1;
          if Index >= PickList.Items.Count then
            Index := 0;
          PickList.ItemIndex := Index;
          ListValue := PickList.Items[PickList.ItemIndex];
          Perform(WM_SETTEXT, 0, LPARAM(ListValue));
          Modified := True;
          Grid.SetEditText(Grid.Col, Grid.Row, ListValue);
          SelectAll;
        end;
    end
  else if EditStyle = esEllipsis then
    DoEditButtonClick;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.DoDropDownKeys(var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
        begin
          if ListVisible then CloseUp(True) else DropDown;
          Key := 0;
        end;
    VK_RETURN, VK_ESCAPE:
      if ListVisible and not (ssAlt in Shift) then
        begin
          CloseUp(Key = VK_RETURN);
          Key := 0;
        end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.DoEditButtonClick;
begin
  if Assigned(FOnEditButtonClick) then
    FOnEditButtonClick(Grid);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.DoGetPickListItems;
begin
  if not PickListLoaded then
  begin
    if Assigned(OnGetPickListItems) then
      OnGetPickListItems(Grid.Col, Grid.Row, PickList.Items);
    PickListLoaded := (PickList.Items.Count > 0);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.DropDown;
var
  P: TPoint;
  I,J,Y: Integer;
begin
  if not ListVisible then
    begin
      ActiveList.Width := Width;
      if ActiveList = FPickList then
        begin
          DoGetPickListItems;
          TLMDGridBasePopupListBox(PickList).Color := Color;
          TLMDGridBasePopupListBox(PickList).Font := Font;
          if (DropDownRows > 0) and (PickList.Items.Count >= DropDownRows) then
            PickList.Height := DropDownRows * TLMDGridBasePopupListBox(PickList).ItemHeight + 4
          else
            PickList.Height := PickList.Items.Count * TLMDGridBasePopupListBox(PickList).ItemHeight + 4;
          if Text = '' then
            PickList.ItemIndex := -1
          else
            PickList.ItemIndex := PickList.Items.IndexOf(Text);
          J := PickList.ClientWidth;
          for I := 0 to PickList.Items.Count - 1 do
            begin
              Y := PickList.Canvas.TextWidth(PickList.Items[I]);
              if Y > J then J := Y;
            end;
          PickList.ClientWidth := J;
        end;
      P := Parent.ClientToScreen(Point(Left, Top));
      Y := P.Y + Height;
      if Y + ActiveList.Height > Screen.Height then Y := P.Y - ActiveList.Height;
      SetWindowPos(ActiveList.Handle, HWND_TOP, P.X, Y, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      FListVisible := True;
      Invalidate;
      Windows.SetFocus(Handle);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (EditStyle = esEllipsis) and (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    begin
      DoEditButtonClick;
      KillMessage(Handle, WM_CHAR);
    end
  else
    inherited KeyDown(Key, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.ListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(ActiveList.ClientRect, Point(X, Y)));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (EditStyle <> esSimple) and
    OverButton(Point(X,Y)) then
    begin
      if ListVisible then
        CloseUp(False)
      else
        begin
          MouseCapture := True;
          FTracking := True;
          TrackButton(X, Y);
          if Assigned(ActiveList) then
            DropDown;
        end;
    end;
  inherited MouseDown(Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.MouseMove(Shift: TShiftState;
  X, Y: Integer);
var
  ListPos: TPoint;
  prm:     LPARAM;
begin
  if FTracking then
    begin
      TrackButton(X, Y);
      if ListVisible then
        begin
          ListPos := ActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
          if PtInRect(ActiveList.ClientRect, ListPos) then
            begin
              StopTracking;

              prm := 0;
              PSmallPoint(@prm)^ := PointToSmallPoint(ListPos);
              LMDSendMessage(ActiveList.Handle, WM_LBUTTONDOWN, 0, prm);
              Exit;
            end;
        end;
    end;
  inherited MouseMove(Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := Pressed;
  StopTracking;
  if (Button = mbLeft) and (EditStyle = esEllipsis) and WasPressed then
    DoEditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGridBaseInplaceEditList.OverButton(const P: TPoint): Boolean;
begin
  Result := PtInRect(ButtonRect, P);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.PaintWindow(DC: HDC);
var
  R: TRect;
  Flags: Integer;
  W, X, Y: Integer;
  Details: TThemedElementDetails;
begin
  if EditStyle <> esSimple then
  begin
    R := ButtonRect;
    Flags := 0;
    case EditStyle of
      esPickList:
        begin
          if ThemeServices.ThemesEnabled then
          begin
            if ActiveList = nil then
              Details := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
            else
              if Pressed then
                Details := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
              else
                if FMouseInControl then
                  Details := ThemeServices.GetElementDetails(tcDropDownButtonHot)
                else
                  Details := ThemeServices.GetElementDetails(tcDropDownButtonNormal);
            ThemeServices.DrawElement(DC, Details, R);
          end
          else
          begin
            if ActiveList = nil then
              Flags := DFCS_INACTIVE
            else if Pressed then
              Flags := DFCS_FLAT or DFCS_PUSHED;
            DrawFrameControl(DC, R, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
          end;
        end;
      esEllipsis:
        begin
          if ThemeServices.ThemesEnabled then
            begin
              if Pressed then
                Details := ThemeServices.GetElementDetails(tbPushButtonPressed)
              else
                if FMouseInControl then
                  Details := ThemeServices.GetElementDetails(tbPushButtonHot)
                else
                  Details := ThemeServices.GetElementDetails(tbPushButtonNormal);
              ThemeServices.DrawElement(DC, Details, R);
            end
          else
            begin
              if Pressed then Flags := BF_FLAT;
              DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
            end;

          X := R.Left + ((R.Right - R.Left) shr 1) - 1 + Ord(Pressed);
          Y := R.Top + ((R.Bottom - R.Top) shr 1) - 1 + Ord(Pressed);
          W := ButtonWidth shr 3;
          if W = 0 then W := 1;
          PatBlt(DC, X, Y, W, W, BLACKNESS);
          PatBlt(DC, X - (W * 2), Y, W, W, BLACKNESS);
          PatBlt(DC, X + (W * 2), Y, W, W, BLACKNESS);
        end;
    end;
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end;

{*var
  R: TRect;
  Flags: Integer;
  W, X, Y: Integer;
begin
  if EditStyle <> esSimple then
    begin
      R := ButtonRect;
      Flags := 0;
      case EditStyle of
        esPickList:
          begin
            if ActiveList = nil then
              Flags := DFCS_INACTIVE
            else if Pressed then
              Flags := DFCS_FLAT or DFCS_PUSHED;
            DrawFrameControl(DC, R, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
          end;
        esEllipsis:
          begin
            if Pressed then Flags := BF_FLAT;
            DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
            X := R.Left + ((R.Right - R.Left) shr 1) - 1 + Ord(Pressed);
            Y := R.Top + ((R.Bottom - R.Top) shr 1) - 1 + Ord(Pressed);
            W := ButtonWidth shr 3;
            if W = 0 then W := 1;
            PatBlt(DC, X, Y, W, W, BLACKNESS);
            PatBlt(DC, X - (W * 2), Y, W, W, BLACKNESS);
            PatBlt(DC, X + (W * 2), Y, W, W, BLACKNESS);
          end;
      end;
      ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
    end;
  inherited PaintWindow(DC);
end;
*)

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.StopTracking;
begin
  if FTracking then
    begin
      TrackButton(-1, -1);
      FTracking := False;
      MouseCapture := False;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.TrackButton(X, Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := ButtonRect;
  NewState := PtInRect(R, Point(X, Y));
  if Pressed <> NewState then
    begin
      FPressed := NewState;
      InvalidateRect(Handle, @R, False);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.UpdateContents;
begin
  ActiveList := nil;
  PickListLoaded := False;
  FEditStyle := Grid.GetEditStyle(Grid.Col, Grid.Row);
  if EditStyle = esPickList then
    ActiveList := PickList;

  { inherited UpdateContents }

  Text := Grid.GetEditText(Grid.Col, Grid.Row);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_KEYDOWN, WM_SYSKEYDOWN,
    WM_CHAR:
      if EditStyle = esPickList then
        with TWMKey(Message) do
        begin
          DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
          if (CharCode <> 0) and ListVisible then
          begin
            with TMessage(Message) do
              LMDSendMessage(ActiveList.Handle, Msg, WParam, LParam);
            Exit;
          end;
        end;
  end;

  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDGridBaseInplaceEditList.GetText: WideString;
begin
  Result := LMDGetControlText(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.SetText(const Value: WideString);
begin
  LMDSetControlText(Self, Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.CreateWindowHandle(
  const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, 'EDIT');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.KillMessage(Wnd: HWnd; Msg: Integer);
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.wparam);
end;

{ ---------------------------------------------------------------------------- }
function TLMDGridBaseInplaceEditList.GetGrid: TLMDGridBase;
begin
  Result := TLMDGridBase(inherited Grid);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDGridBaseInplaceEditList.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FEditStyle := esSimple;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGridBaseInplaceEditList.RestoreContents;
begin
  Reset;
  Grid.UpdateText;
end;

{$ENDIF} // _LMD_UNICODEIMPL

{ ********************* class TLMDGridBasePopupListBox *********************** }
{ -------------------------------- protected --------------------------------- }

{$IFDEF _LMD_UNICODEIMPL}

procedure TLMDGridBasePopupListBox.AddItem(const AItem: TLMDString;
  AObject: TObject);
begin
  FItems.AddObject(AItem, AObject);
end;

{------------------------------------------------------------------------------}

constructor TLMDGridBasePopupListBox.Create(AOwner: TComponent);
begin
  inherited;
  {$IFDEF _LMD_UNICODEIMPL}
  FItems := TLMDListBoxItems.Create(Self, inherited Items);
  {$ELSE}
  FItems := inherited Items;
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

procedure TLMDGridBasePopupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do
  begin
    Style    := Style or WS_BORDER;
    ExStyle  := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDGridBasePopupListBox.CreateWindowHandle(
  const Params: TCreateParams);
begin
  LMDCreateControlHandle(Self, Params, 'LISTBOX');
end;

{------------------------------------------------------------------------------}

procedure TLMDGridBasePopupListBox.CreateWnd;
begin
  inherited CreateWnd;

  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, WM_SETFOCUS, 0, 0);
end;

{------------------------------------------------------------------------------}

destructor TLMDGridBasePopupListBox.Destroy;
begin
  inherited;
  {$IFDEF _LMD_UNICODEIMPL}
  FItems.Free;
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

procedure TLMDGridBasePopupListBox.KeyPress(var Key: Char);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27:    FSearchText := '';
    #32..#255:  begin
                  TickCount := GetTickCount;
                  if TickCount - FSearchTickCount > 2000 then
                    FSearchText := '';
                  FSearchTickCount := TickCount;

                  if Length(FSearchText) < 32 then
                    FSearchText := FSearchText + Key;//!!! Ansi Key.

                  LMDSendMessage(Handle, LB_SELECTSTRING, WPARAM(-1),
                                 LPARAM(PLMDChar(FSearchText)));
                  Key := #0;
                end;
  end;

  inherited KeyPress(Key);
end;

{------------------------------------------------------------------------------}

procedure TLMDGridBasePopupListBox.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  TLMDGridBaseInplaceEditList(Owner).CloseUp((X >= 0) and (Y >= 0) and
                                             (X < Width) and (Y < Height));
end;

{------------------------------------------------------------------------------}

procedure TLMDGridBasePopupListBox.SetItems(const Value: TLMDStrings);
begin
  FItems.Assign(Value);
end;

{$ENDIF} // _LMD_UNICODEIMPL

{****************************** TLMDListBoxItems ******************************}
{------------------------------------------------------------------------------}

{$IFDEF _LMD_UNICODEIMPL}

function TLMDListBoxItems.Add(const S: WideString): Integer;
begin
  Result := LMDSendMessage(FListBox.Handle, LB_ADDSTRING, 0,
                           LPARAM(PLMDChar(S)));
  if Result < 0 then
    raise EOutOfResources.Create(SInsertLineError);
end;

{------------------------------------------------------------------------------}

procedure TLMDListBoxItems.Clear;
begin
  TListBoxAccess(FListBox).ResetContent;
end;

{------------------------------------------------------------------------------}

constructor TLMDListBoxItems.Create(AListBox: TCustomListBox;
  AOldItems: TStrings);
begin
  inherited Create;
  FListBox  := AListBox;
  FOldItems := AOldItems;
end;

{------------------------------------------------------------------------------}

procedure TLMDListBoxItems.Delete(Index: Integer);
begin
  TListBoxAccess(FListBox).DeleteString(Index);
end;

{------------------------------------------------------------------------------}

procedure TLMDListBoxItems.Exchange(Index1, Index2: Integer);
var
  s:    TLMDString;
  data: Integer;
begin
  BeginUpdate;
  try
    s    := Strings[Index1];
    data := TListBoxAccess(FListBox).InternalGetItemData(Index1);

    Strings[Index1] := Strings[Index2];
    TListBoxAccess(FListBox).InternalSetItemData(Index1,
      TListBoxAccess(FListBox).InternalGetItemData(Index2));
    Strings[Index2] := s;
    TListBoxAccess(FListBox).InternalSetItemData(Index2, data);

    if FListBox.ItemIndex = Index1 then
      FListBox.ItemIndex := Index2
    else if FListBox.ItemIndex = Index2 then
      FListBox.ItemIndex := Index1;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDListBoxItems.Get(Index: Integer): WideString;
var
  len: Integer;
begin
  len := LMDSendMessage(FListBox.Handle, LB_GETTEXTLEN, Index, 0);

  if len = LB_ERR then
    Error(SListIndexError, Index);

  SetLength(Result, len);
  if len > 0 then
    LMDSendMessage(FListBox.Handle, LB_GETTEXT, Index, LPARAM(@Result[1]));
end;

{------------------------------------------------------------------------------}

function TLMDListBoxItems.GetCount: Integer;
begin
  Result := FOldItems.Count;
end;

{------------------------------------------------------------------------------}

function TLMDListBoxItems.GetObject(Index: Integer): TObject;
begin
  Result := FOldItems.Objects[Index];
end;

{------------------------------------------------------------------------------}

function TLMDListBoxItems.IndexOf(const S: WideString): Integer;
begin
  Result := LMDSendMessage(FListBox.Handle, LB_FINDSTRINGEXACT,
                           WPARAM(-1), LPARAM(PLMDChar(S)));
end;

{------------------------------------------------------------------------------}

procedure TLMDListBoxItems.Insert(Index: Integer; const S: WideString);
begin
  if LMDSendMessage(FListBox.Handle, LB_INSERTSTRING, Index,
                    LPARAM(PLMDChar(S))) < 0 then
    raise EOutOfResources.Create(SInsertLineError);
end;

{------------------------------------------------------------------------------}

procedure TLMDListBoxItems.Move(CurIndex, NewIndex: Integer);
var
  s:    TLMDString;
  data: Longint;
begin
  BeginUpdate;
  TListBoxAccess(FListBox).FMoving := True;
  try
    if CurIndex <> NewIndex then
    begin
      s    := Get(CurIndex);
      data := TListBoxAccess(FListBox).InternalGetItemData(CurIndex);

      TListBoxAccess(FListBox).InternalSetItemData(CurIndex, 0);
      Delete(CurIndex);
      Insert(NewIndex, s);
      TListBoxAccess(FListBox).InternalSetItemData(NewIndex, data);
    end;
  finally
    TListBoxAccess(FListBox).FMoving := False;
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDListBoxItems.Put(Index: Integer; const S: WideString);
var
  i:    Integer;
  data: Longint;
begin
  i    := FListBox.ItemIndex;
  data := TListBoxAccess(FListBox).InternalGetItemData(Index);

  TListBoxAccess(FListBox).InternalSetItemData(Index, 0);
  Delete(Index);
  InsertObject(Index, S, nil);
  TListBoxAccess(FListBox).InternalSetItemData(Index, data);
  FListBox.ItemIndex := i;
end;

{------------------------------------------------------------------------------}

procedure TLMDListBoxItems.PutObject(Index: Integer; AObject: TObject);
begin
  FOldItems.Objects[Index] := AObject;
end;

{------------------------------------------------------------------------------}

procedure TLMDListBoxItems.SetUpdateState(Updating: Boolean);
begin
  TStringsAccess(FOldItems).SetUpdateState(Updating);
end;

{$ENDIF} // _LMD_UNICODEIMPL

{------------------------------------------------------------------------------}

initialization
  {$IFDEF LMD_DEBUGTRACE}
    {$I C3.INC}
  {$ENDIF}

finalization
  LMDClearHintHooks;

{------------------------------------------------------------------------------}

end.
