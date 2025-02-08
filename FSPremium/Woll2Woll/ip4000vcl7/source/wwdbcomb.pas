unit Wwdbcomb;
{$R-}
{
//
// Components : TwwDBCustomCombo, TwwDBComboDlg
//
// Copyright (c) 1996, 1997, 1998 by Woll2Woll Software
//
// 7/23/97 - Enable edit so later call to edit will not revert text to
//           original value
// 7/30/97 - Set modified to True since clearing
//
// 9/24/97 - Call SetItemIndex instead of setting FItemIndex in SelectValue methods
//
// 9/25/97 - KeyDown method - Don't search or auto-dropdown if alt key is pressed
//
//
// 9/26/97 - Prevents going into edit mode if closeup method does not have
//           any entry selected.
//
// 11/18/97 - AllowClearKey when not dropped down did not set modified flag.
//            As a result, the clearing was not saved.  This problem is now fixed.
//
// 1/16/98  - Numpad digits not handled in KeyDown method.
//
// 3/24/98 - Added Value property which is hidden stored value
// 4/8/98 - Update FItemIndex in DataChange event
// 4/29/98 - skip code if shift key pressed
// 10/12/98 - Don't restore ShowHint if it was never dropped down
// 11/15/98 - Calling closeup immediately would cause problems from hook
// 2/24/99 - Fix for ItemIndex being incorrect at time of OnCloseUp
// 3/31/99 - Improved support for ShowMatchText and AllowClearKey
// 4/2/99 - Support calculated field edits
// 4/18/99 - Only execute 4/2/99 code change for calculated fields
// 6/29/99 - ShowMatchText cursor pos should be where typing
// 8/17/00 - Add history list
// 8/17/00 - Only ignore key if csDropDownList
// 9/5/00 - Fire onkeydown event
// 10/11/2000-PYW-Prevents backspace from working on string lengths > 32
// 10/20/2000- Update listbox's itemindex property when value set.
// 11/28/2000 - PYW - Check based on actual work area.
// 12/17/00 RSW - Fix problem where handle gets created when destroying
// 10/4/01 RSW - In applylist, update flag for dirtylistbox.  This prevents the
//               problem where the itemindex from being cleared
// 10/4/01 - GetComboValue was returning displaytext when using mapped values
//           if the displayvalue was not found.  This was an incompatibility
//           with InfOpower 2000.
//10/29/01 - Handle the case when abort is called.
//11/05/2001 - Allow overriding of Listbox Color and Font.
//11/05/2001 - Not taking into account maplist when owner draw.
// 11/29/01 - Don't paste into control with csDropDownList
// 12/12/2001-Don't clear result if this is for TwoColumnDisplay
// 2/19/02 - Case insensitive when maplist is true
// 2/22/2002 - Don't do otherwise to delay listbox creation until necessary
// 9/18/02 - Don't call addhistory event if already in list
}
interface
{$i wwIfDef.pas}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Mask, Wwdbedit, Wwdotdot,
  db, menus, wwdatsrc, wwtypes, grids, wwframe, wwhistorylist;


type

  TwwDBCustomComboBox = class;
  TwwDBComboBox = class;
  TwwComboCloseUpEvent = procedure(Sender: TwwDBComboBox; Select: boolean) of object;
  TwwAddHistoryItemEvent = procedure(Sender: TwwDBCustomComboBox; Value : String; var Accept : Boolean) of object;

  TwwPopupListbox = class(TCustomListbox)
  private
    FSearchText: String;
    FSearchTickCount: Longint;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
//    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure Keypress(var Key: Char); override;
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); override;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  public
    constructor Create(AOwner: TComponent); Override;
  end;

  TwwDBCustomComboBox = class(TwwDBCustomCombo)
  private
    FMapList: boolean;
    FItems: TStrings;
    FDropDownCount: integer;
    FItemHeight: integer;
    FListbox: TwwPopupListBox;
    FListVisible: Boolean;
    FNoKeysEnteredYet: boolean;
    FAllowClearKey: boolean;
    FItemIndex: integer;
    FStyle: TComboBoxStyle;
    FCanvas: TCanvas;
    FDropDownWidth: integer;
    FAutoDropDown: boolean;
    FShowMatchText: boolean;
    FHistoryList: TwwHistoryList;

    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TwwComboCloseUpEvent;
    FOnDrawItem: TDrawItemEvent;
    FOnMeasureItem: TMeasureItemEvent;
    FOnAddHistoryItem: TwwAddHistoryItemEvent;

    InAutoDropDown: boolean;
    LastShowHint: boolean;
    PreDropDownText: string;
    DoSelChange: boolean;
    DirtyListBox: boolean;

    FDisableDropDownList: boolean;
    FColumn1Width: integer;
    FTwoColumnDisplay: boolean;

    procedure DataChange(Sender: TObject);
    function GetComboText: string;
    procedure SetComboText(const Value: string);
    procedure SetItemList(Value: TStrings);
    Function GetSorted: boolean;
    procedure SetSorted(val: Boolean);
    Function GetItemIndex: integer;
    procedure SetItemIndex(val: integer);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMClear(var Message: TMessage); message WM_CLEAR;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN; {handle tab}
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    {$ifndef wwDelphi4Up}
    procedure WndProc(var Message: TMessage); override;
    {$endif}
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    Function GetCanvas: TCanvas;
    Procedure SetStyle(val: TComboBoxStyle);
    Procedure SetValue(Value: string);
    Function GetValue: string;
    procedure SetDroppedDown(val: boolean);
  protected
    Function IndexOf(Value: string; StartIndex: integer = 0): integer; virtual;
    procedure Loaded; override;
    Function OwnerDraw: boolean; override;
    Function GetStoredText: string; override;
    procedure CloseUp(Accept: Boolean); override;
    Function IsDroppedDown: boolean; override;
    Function Editable: boolean; override;
    Function MouseEditable: boolean; override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;

    procedure ListBoxNeeded;
    procedure DoSelectAll;
    Procedure ShowText(ACanvas: TCanvas;
          ARect: TRect; indentLeft, indentTop: integer; AText: string); override;
    procedure SetListBoxItemIndex(val: integer);
    {$ifdef wwDelphi4Up}
    procedure WndProc(var Message: TMessage); override;
    {$endif}
    procedure ProcessSearchKey(
      Key: char;
      NewItemIndex: integer;
      OldItemIndex: integer;
      FSearchText: string;
      MatchTextFromList: string);

  public
    property Listbox: TwwPopupListBox read FListbox;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ListBoxItemsNeeded;
    procedure DeleteItem(Value: string; DeleteFromHistory: boolean = False); virtual;
    procedure AddItem(Value: string; AddToHistory: boolean = False); virtual;
    procedure ClearHistory; virtual;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    Function GetFieldMapText(StoreValue: string; var res: string): boolean; override; { Map Value to Display Value }
    Function GetComboValue(DisplayText: string): string;
    Function GetComboDisplay(Value: string): string;
    procedure ApplyList;
    procedure DropDown; override;

{    property Text;}
    property Canvas : TCanvas read GetCanvas;
    property DroppedDown: boolean read IsDroppedDown write SetDroppedDown;
    property Value: string read GetValue write SetValue;

  public
    property ShowButton;  { Publish before Style property for SetStyle code }
    property Style : TComboboxStyle read FStyle write SetStyle; {Must be published before Items}
    property MapList: boolean read FMapList write FMapList; { publish before Items }

    property AllowClearKey : boolean read FAllowClearKey write FAllowClearKey;
    property AutoDropDown : boolean read FAutoDropDown write FAutoDropDown default False;
    property EditAlignment;
    property ShowMatchText: boolean read FShowMatchText write FShowMatchText default False;
    property ButtonStyle default cbsDownArrow;
    property DropDownCount : integer read FDropDownCount write FDropDownCount;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
    property DisableDropDownList: boolean read FDisableDropDownList write FDisableDropDownList default False;
    property TwoColumnDisplay: boolean read FTwoColumnDisplay write FTwoColumnDisplay default False;
    property Column1Width: integer read FColumn1Width write FColumn1Width default 0;

    property HistoryList: TwwHistoryList read FHistoryList write FHistoryList;
    property ItemHeight : integer read FItemHeight write FItemHeight;
    property Items : TStrings read FItems write SetItemList;
    property ItemIndex: integer read GetItemIndex write SetItemIndex default -1;
    property Sorted : boolean read GetSorted write SetSorted;

    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnCloseUp: TwwComboCloseUpEvent read FOnCloseUp write FOnCloseUp;
    property OnDrawItem : TDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
    property OnAddHistoryItem: TwwAddHistoryItemEvent read FOnAddHistoryItem write FOnAddHistoryItem;
  end;

  TwwDBComboBox = class(TwwDBCustomComboBox)
  published
    property DisableThemes;
    {$ifdef wwDelphi4Up}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property ParentBiDiMode;
    {$endif}

    property ShowButton;  { Publish before Style property for SetStyle code }
    property Style;
    property MapList;

    property AllowClearKey;
    property AutoDropDown;
    property ShowMatchText;
    property AutoFillDate;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property ButtonStyle default cbsDownArrow;
    property CharCase;
    property Color;
    property Column1Width;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DisableDropDownList;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Font;
    property ButtonEffects;
    property Frame;
    property ButtonWidth;
    property ButtonGlyph;
    property HistoryList;

    {$ifdef wwDelphi3Up}
    property ImeMode;
    property ImeName;
    {$endif}
    property ItemHeight;
    property Items;
    property ItemIndex;
    property LimitEditRect;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property Picture;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property UnboundDataType;
    property UsePictureMask;
    property Visible;
    property UnboundAlignment;
    property TwoColumnDisplay;

    property OnAddHistoryItem;
    property OnChange;
    property OnCheckValue;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnCloseUp;
    property OnDrawItem;
    property OnMeasureItem;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

procedure Register;

implementation

uses wwstr, wwcommon;

{ The following hook proc is a workaround for a delphi 4 bug
  where it no longer sends a CM_CANCELMODE message when the end-user
  clicks away from the dropped down list }
{$ifdef wwDelphi4up}
var wwHook: HHOOK;

function wwHookProc(nCode: Integer; wParam: Integer; lParam: Integer): LResult; stdcall;
var r1, r2: TRect;
begin
  result := CallNextHookEx(wwHook, nCode, wParam, lParam);
  with PMouseHookStruct(lParam)^ do
  begin
    if (wParam = WM_LBUTTONDOWN) or (wParam = WM_NCLBUTTONDOWN) then
    begin
      if (Screen.ActiveControl <> nil) and (Screen.ActiveControl is TwwDBCustomComboBox) then
        with (Screen.ActiveControl as TwwDBCustomComboBox) do
      begin
        { Auto-closeup if clicked outside of drop-down area }
        if DroppedDown then begin
           GetWindowRect(FListBox.Handle, r1);
           GetWindowRect(Handle, r2);
           if (not PtInRect(r1, pt)) and (not PtInRect(r2, pt)) then
             { 11/15/98 - Calling closeup immediately would cause problems
              if user's OnCloseUp aborted }
             PostMessage(Handle, CM_CANCELMODE, 0, 0);
//           CloseUp(True);
        end
      end;
    end;
  end;
end;
{$endif}

procedure TwwDBCustomComboBox.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      with TWMKey(Message) do
      begin
         { 4/29/98 - skip code if shift key pressed }
//         if not (ssShift in KeyDataToShiftState(KeyData)) then
         begin
             if not (isDroppedDown and
               (CharCode in [VK_LEFT, VK_RIGHT, VK_HOME, VK_END]) and
               (Message.Msg=wm_KeyDown)) then begin

               if (Message.Msg = wm_keydown) and (charcode=vk_f4) or
                  (charcode<>vk_f4) then
                  HandleDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
               if (CharCode <> 0) and FListVisible then
               begin
                 with TMessage(Message) do
                    SendMessage(FListBox.Handle, Msg, WParam, LParam);
               end
            end;

            // 9/17/01 -
            // If shift key pressed then its not vk_up or vk_down.
            // For instance '&' is ascii 38
            if  (isDroppedDown and
               not (ssShift in KeyDataToShiftState(KeyData)) and
               (CharCode in [VK_UP, VK_DOWN])) then
               exit;
         end
      end
  end;

  inherited WndProc(Message);
end;

procedure TwwDBCustomComboBox.KeyPress(var Key: Char);
var TempAutoFillDate: boolean;
    TempText: string;
    i, curpos, TempIndex: integer;
    LItem: string;
    found: boolean;
    startIndex: integer;
    oldselstart, oldsellength: integer;
//    matchIndex: integer;
//    MatchTextFromList: string;

   Function NewText: string;
   var curStr : string;
   begin
      curStr:= Text;
      result:= copy(curStr, 1, selStart) +
               char(Key) + copy(curStr, selStart + 1 + length(SelText), 32767);
   end;

    procedure SelectValue(AIndex: integer);
    begin
       if AIndex>ListBox.Items.count-1 then exit;
       if AIndex<0 then exit;
       if (Datasource<>nil) then begin
          DataLink.Edit;
          if not DataLink.Editing then begin
            if (DataLink.Field<>nil) and (DataLink.Field.Calculated) and EditCanModify then
               DataLink.DataSet.Edit
            else exit; { 4/2/99 - Support calculated field edits}
          end
       end;
       curpos:= 1;
       { 9/24/97 - Call SetItemIndex instead of setting FItemIndex }
       SetItemIndex(AIndex);
{       FItemIndex:= AIndex;
       Text:= strGetToken(FItems[AIndex], #9, curPos);}
       SetModified(True);  {1/21/97}
    end;

    function max(x,y: integer): integer;
    begin
       if x>y then result:= x else result:= y;
    end;

begin
   tempText:= NewText;
   ListBoxItemsNeeded;  // 8/27/00 - Listbox items need to be initialized

   { 3/31/99 - Improved support for ShowMatchText and AllowClearKey }
   if ((key=#8) or (key=#24)) {and (Style=csDropDownList) and ShowMatchText }then
   begin
      if IsDroppedDown then key:= #0
      else begin
          if Style=csDropDownList then
          begin { Find first match }
             ApplyList;
             ListBox.KeyPress(key);
          end
          else { Process backspace as delete character }
      end;
   end;

   if ShowMatchText and (Key in [#32..#254]) and (Text<>TempText) then begin
      found:= False;
      if (selStart>=length(NewText)-1) then begin
//         startIndex:= max(0, FItemIndex);
         startIndex:= max(0, HistoryList.EffectiveMRUCount);
         for i:= startIndex to (startIndex + ListBox.Items.count-1) do begin
            tempIndex:= i mod (ListBox.Items.count);
            Litem:=uppercase(ListBox.Items[tempIndex]);
            if pos(uppercase(TempText),Litem)=1 then begin
               SelectValue(tempIndex);

               { 6/29/99 - ShowMatchText cursor pos should be where typing }
               if (DataSource=nil) or DataLink.Editing then begin
                 selStart:= length(Text);
                 selLength:= - (length(Text)-length(TempText));
                 found:= True;
               end;
               key:= #0;
               break;
            end
         end
      end;

      if not found then begin
         // 8/17/00 - Only ignore key if csDropDownList
         if (Style=csDropDownList) {or isDroppedDown }then begin
            key:= #0;
         end
      end
   end
   else if not Editable and (Key in [#32..#254]) then begin  { Use first character to search }
//      found:= false;
      for i:= FItemIndex+1 to (FItemIndex + ListBox.Items.count) do begin
         tempIndex:= i mod (ListBox.Items.count);
         Litem:=uppercase(ListBox.Items[tempIndex]);
         if pos(uppercase(char(key)),Litem)=1 then begin
            SelectValue(tempIndex);
//            found:= true;
            break;
         end
      end;

      // 8/17/00 - Only ignore key if csDropDownList
      if (Style=csDropDownList) then key:= #0;
   end;

   TempAutoFillDate:= AutoFillDate;
   If MapList then AutoFillDate:= False;

   { Going into edit mode the first time can cause the selStart to be wrong if displayformat is assigned }
   if not MapList and (DataLink.DataSet<>nil) and (DataLink.dataset.State=dsBrowse) and
     (DataLink.Field.asString<>DataLink.Field.DisplayText) then
   begin
      OldSelStart:= selStart;
      OldSelLength:= selLength;
      inherited KeyPress(Key);
      if (selStart=0) then
      begin
         selStart:= OldSelStart;
         selLength:= OldSelLength;
      end
   end
   else
      inherited KeyPress(Key);
   AutoFillDate:= TempAutoFillDate;

   if Key=#13 then Key:= #0; { 8/22/96 - Avoid Beep when closing dropdown :)}
end;

constructor TwwPopupListBox.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   {$IFDEF WIN32}
   ControlStyle := ControlStyle + [csReplicatable];
   ControlStyle := ControlStyle + [csNoDesignVisible];
   {$ENDIF}
end;

procedure TwwDBCustomComboBox.ProcessSearchKey(
   Key: char;
   NewItemIndex: integer;
   OldItemIndex: integer;
   FSearchText: string;
   MatchTextFromList: string);

   procedure GoBack1;
   begin
       SelStart:= wwMax(0, SelStart-1);
       SelLength:= length(Text)-SelStart;
   end;

begin
   if NewItemIndex=-1 then begin
       if (key=#8) then begin
          if (FSearchText='') and (Style=csDropDownList) and ShowMatchText then
          begin
             GoBack1;
          end
          else if (Style<>csDropDownList) then
          begin
             ListBox.ItemIndex:= -1;
             Text:= FSearchText;
             SelStart:= length(Text);
          end
       end
       else if (Style<>csDropDownList) and (IsDroppedDown) then
       begin
          ListBox.ItemIndex:= -1;
       end
    end
    else begin
       if (key=#8) then
       begin
          if Style=csDropDownList then
          begin
            if wwEqualStr(Text, MatchTextFromList) then
            begin
              GoBack1;
            end
            else begin
               if pos(uppercase(MatchTextFromList), uppercase(Text))=1 then
               begin
                  Text:= MatchTextFromList;
                  SelStart:= length(Text);
               end
               else begin
                  ListBox.ItemIndex:= OldItemIndex;
                  GoBack1;
               end
            end
         end
         else begin
            Text:= FSearchText;
            SelStart:= length(Text);
            if (IsDroppedDown) then
               if not wwEqualStr(FSearchText, MatchTextFromList) then
               begin
                  ListBox.ItemIndex:=-1;
               end
         end
      end
   end;
end;

procedure TwwPopupListbox.Keypress(var Key: Char);
var
  TickCount: Integer;
  buf: array[0..255] of char;
  selIndex: integer;
  combo: TwwDBCustomComboBox;
  MatchTextFromList: string;
  OldItemIndex: integer;

   Function NewText(Key: Char): string;
   var curStr : string;
   begin
      curStr:= FSearchText;
      if Combo.OwnerDraw then result:= curStr + char(Key)
      else if (ord(key)=vk_back) then begin
         if (length(curstr)>=1) then
            delete(curstr, wwmin(combo.selStart+1, length(curstr)),
                           wwmax(combo.selLength, 1));
         result:= curStr;
      end
      else
         result:= copy(curStr, 1, combo.selStart) +
               char(Key) + copy(curStr, combo.selStart + 1 + length(combo.SelText), 32767);
   end;

begin
  Combo:= owner as TwwDBCustomComboBox;
  case Key of
    #27: FSearchText := '';
    #8, #32..#255:
      begin
        { Allow incremental searching for up to 1.5 seconds before resetting }
        if Combo.OwnerDraw then begin
           TickCount := GetTickCount;
           if TickCount - FSearchTickCount > 1500 then FSearchText := '';
           FSearchTickCount := TickCount;
        end
        else FSearchText:= Combo.Text;

        {if Length(FSearchText) < 32 then }  //10/11/2000-PYW-Prevents backspace from working on string lengths > 32
            FSearchText := NewText(Key);

        strplcopy(buf, FSearchText, 255);
        OldItemIndex:= ItemIndex;
        selIndex:= SendMessage(Handle, LB_SelectString,
                   Combo.HistoryList.EffectiveMRUCount-1 {WORD(-1)}, Longint(@buf));

        if ItemIndex>=0 then MatchTextFromList:= Items[ItemIndex]
        else MatchTextFromList:= '';
        Combo.ProcessSearchKey(key, SelIndex, OldItemIndex, FSearchText, MatchTextFromList);
        Key := #0;

      end;
  end;
  inherited Keypress(Key);
end;

procedure TwwPopupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_BORDER;
    {$ifdef win32}
    ExStyle := WS_EX_TOOLWINDOW;
    {$endif}
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TwwPopupListbox.CreateWnd;
begin
  inherited CreateWnd;
  WinProcs.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, wm_SetFocus, 0, 0);
end;

procedure TwwPopupListbox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  case Message.NotifyCode of
    LBN_SELCHANGE: { Allow text to change when scrolling with up/down, pageup/pagedown }
      begin
         with Owner as TwwDBCustomComboBox do
         begin
           if (Self.ItemIndex>=0) and IsDroppedDown and DoSelChange then
           begin
             if (DataSource=nil) or (DataLink.Editing) then
             begin
               if (DataLink.Field=nil) and Readonly then //2/22/2002 - Do not change selection if readonly.
               else Text:= Self.Items[ItemIndex];
               if Editable then DoSelectAll;
             end
           end
         end
      end;
  end;
end;

procedure TwwPopupListBox.DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
var combo: TwwDBCustomComboBox;
    pt: TPoint;
    tempValue: string;
    DoDefault: boolean;
    TempColumn1Width: integer;
    tempRect: TRect;
//    Flags:Integer;
begin
  Combo:= owner as TwwDBCustomComboBox;
  DoDefault:= True;
  if Assigned(Combo.FOnDrawItem) and Combo.OwnerDraw then begin
     if not (odSelected in State) then begin
        Canvas.Brush.Color:= Color;
        Canvas.Font.Color:= Font.Color;
        Canvas.TextRect(Rect, Rect.Left, Rect.Top, '');
     end;

     try
       Combo.FOnDrawItem(Combo, Index, Rect, State)
     except
       DoDefault:= False;
     end
  end;

  if Combo.Column1Width=0 then TempColumn1Width:= Width div 2
  else TempColumn1Width:= Combo.Column1Width;

  if Combo.TwoColumnDisplay and DoDefault then
  begin
     if Index<=Items.Count-1 then
     begin
        DoDefault:= False;
//        Flags:= DT_END_ELLIPSIS;  { If text does not fit then put ellipsis at end }

        tempRect:= Rect;
        if Combo.MapList then begin
           tempValue:= Items[index];
           TempRect.Right:= TempRect.Left + tempColumn1Width;
           Canvas.TextRect(TempRect, TempRect.Left+1, TempRect.Top+1, tempValue);
           Rect.Left:= Rect.Left + TempColumn1Width;
           tempValue:= Combo.GetComboValue(Items[Index]);
           Canvas.TextRect(Rect, Rect.Left+1, Rect.Top+1, tempValue);
        end
        else begin
           tempValue:= Items[Index];
           TempRect.Right:= TempRect.Left + tempColumn1Width;
           Canvas.TextRect(TempRect, TempRect.Left+1, TempRect.Top+1, tempValue);
           Rect.Left:= Rect.Left + TempColumn1Width;
           tempValue:= Combo.GetComboDisplay(Items[index]);
           Canvas.TextRect(Rect, Rect.Left+1, Rect.Top+1, tempValue);
        end;
     end
  end;

  if DoDefault then
     inherited DrawItem(Index, Rect, State);

  pt:= Point(2,2);
  if Combo.HistoryList.EffectiveMRUCount>0 then
  begin
    try
      if (Index = Combo.HistoryList.EffectiveMRUCount-1) then
      begin
         Canvas.Pen.Color := clBtnShadow;
         Canvas.PolyLine([Point(0, rect.Bottom - 1), Point(Width, rect.Bottom - 1)]);
      end;
      if (Index = Combo.HistoryList.EffectiveMRUCount) then
      begin
         Canvas.Pen.Color := clBtnShadow;
         Canvas.PolyLine([Point(0, rect.Top+1), Point(Width, rect.Top+1)]);
      end;
    finally
    end
  end;

end;


type
  TwwCheatListBox=class(TListBox);

  TwwComboStringList = class(TStringList)
  protected
//    procedure EndUpdate; override;
//  protected
//    procedure Put(Index: Integer; const S: string); override;
//    procedure PutObject(Index: Integer; AObject: TObject); override;
//    procedure SetCapacity(NewCapacity: Integer); override;
//    procedure SetUpdateState(Updating: Boolean); override;

  public
    function AddObject(const S: string; AObject: TObject): Integer; override;
    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Sort; override;
    function ListBoxReady: boolean; virtual;
    function IndexOf(const S: string): Integer; override;
  private
    Combo: TwwDBCustomComboBox;
  end;

function TwwComboStringList.IndexOf(const S: string): Integer;
begin
//   if Combo.DirtyListBox then
//     Combo.ListBoxItemsNeeded;
   result:= inherited IndexOf(S);
end;

function TwwComboStringList.ListBoxReady: boolean;
begin
   result:= (Combo.ListBox<>nil) and Combo.Listbox.HandleAllocated;
end;
{
procedure TwwComboStringList.Put(Index: Integer; const S: string);
begin
   inherited Put(Index, S);
//   if ListBoxReady then TStringList(Combo.ListBox.Items).Put(Index, S);
end;

procedure TwwComboStringList.PutObject(Index: Integer; AObject: TObject);
begin
   inherited PutObject(Index, AObject);
//   if ListBoxReady then Combo.ListBox.Items.PutObject(Index, AObject);
end;
}
function TwwComboStringList.Add(const S: string): Integer;
begin
   result:= inherited Add(S);
   Combo.DirtyListBox:= True;
//   if ListBoxReady then Combo.Listbox.Items.Add(S);
end;

function TwwComboStringList.AddObject(const S: string; AObject: TObject): Integer;
begin
   result:= inherited AddObject(S, AObject);
   Combo.DirtyListBox:= True;
//   if ListBoxReady then Combo.Listbox.Items.AddObject(S, AObject);
//   if ListBoxReady then Combo.ListBox.Items.Objects[
//   PutObject(Result, AObject);
end;

procedure TwwComboStringList.Clear;
begin
   inherited Clear;
   Combo.DirtyListBox:= True;
//   if ListBoxReady then Combo.Listbox.Items.Clear;
end;

procedure TwwComboStringList.Delete(Index: Integer);
begin
   inherited Delete(Index);
   Combo.DirtyListBox:= True;
//   if ListBoxReady then Combo.Listbox.Items.Delete(Index);
end;

procedure TwwComboStringList.Exchange(Index1, Index2: Integer);
begin
   inherited Exchange(Index1, Index2);
   Combo.DirtyListBox:= True;
//   if ListBoxReady then Combo.Listbox.Items.Exchange(Index1, Index2);
end;

procedure TwwComboStringList.Insert(Index: Integer; const S: string);
begin
   inherited Insert(Index, S);
   Combo.DirtyListBox:= True;
//   if ListBoxReady then Combo.Listbox.Items.Insert(Index, S);
end;

// Refresh listbox list
{
procedure TwwComboStringList.EndUpdate;
begin
   inherited EndUpdate;
   if ListBoxReady then
     Combo.ListBoxItemsNeeded;
end;
}
procedure TwwComboStringList.Sort;
begin
   inherited Sort;
   if ListBoxReady and (Combo.ListBox.Items is TStringList) then
      TStringList(Combo.Listbox.Items).Sort;
end;

constructor TwwDBCustomComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DropDownCount:= 8;
  FItems:= TwwComboStringList.create;
  TwwComboStringList(FItems).Combo:= self;
  FItemIndex:= -1;
  FHistoryList := TwwHistoryList.Create;
  with FHistoryList do begin
     Owner:= self;
//     Source := FItems;
  end;
  ButtonStyle:= cbsDownArrow; {???}
  DataLink.OnDataChange := DataChange;

  {$ifdef wwDelphi4Up}
  if not Patch[2] then
     Button.OnClick:= nil;
  {$endif}

end;

Function TwwDBCustomComboBox.GetCanvas: TCanvas;
begin
   if FCanvas<>Nil then result:= FCanvas
   else if FListBox<>Nil then result:= FListBox.Canvas
   else result:= Nil;
end;

destructor TwwDBCustomComboBox.Destroy;
begin
  FHistoryList.Free;
  FHistoryList := nil;
  FItems.Free;
  FItems:= nil;
  FListbox.Free;
  FListbox:= nil;
  {$ifdef wwDelphi4up}
  if wwHook<>0 then begin
     UnhookWindowsHookEx(wwHook);
     wwHook:= 0;
  end;
  {$endif}
  inherited Destroy;
end;

procedure TwwDBCustomComboBox.ListBoxItemsNeeded;
begin
   ListBoxNeeded;
   if (ListBox.Items.Count=0) or DirtyListBox then ApplyList;
   DirtyListBox:= False;
end;

procedure TwwDBCustomComboBox.ListboxNeeded;
begin
  if FListbox<>Nil then exit;

  FListbox:= TwwPopupListbox.create(self);
  FListbox.visible:= False;
  FListbox.integralHeight:= True;
  FListbox.ItemHeight := 11;
  FListbox.parent:= self;
  FListbox.ParentShowHint:=false;
  FListbox.showhint:= false;
  SetWindowPos(FListbox.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW); { Hide window }
  FListbox.visible:= False;
  FListbox.OnMouseUp := ListMouseUp;

end;

Function TwwDBCustomComboBox.GetFieldMapText(StoreValue: string; var res: string): boolean;
begin
   if maplist then begin
      Res:= GetComboDisplay(StoreValue);
      result:= True;
   end
   else result:= False;
end;

Function TwwDBCustomComboBox.GetStoredText: string;
begin
   result:= GetComboText;
end;

{ Return current combo's hidden value }
function TwwDBCustomComboBox.GetComboText: string;
begin

  if (Style in [csDropDown]) and (Text='') then Result:= ''
  else Result:= GetComboValue(Text);

end;

Function TwwDBCustomComboBox.GetValue: string;
begin
   result:= GetStoredText;
end;

Procedure TwwDBCustomComboBox.SetValue(Value: string);
var curpos, i, j: integer;
   DisplayVal: string;
begin
   EnableEdit;
   ListBoxItemsNeeded;
   if FMapList then begin
      FItemIndex:= -1; {4/8/98 }

      for i:= 0 to FItems.count-1 do begin
         curpos:= 1;
         DisplayVal:= strGetToken(FItems[i], #9, curPos);
         if strGetToken(FItems[i], #9, curPos)=Value then
         begin
            for j:= 0 to ListBox.Items.Count-1 do
            begin
                if wwEqualStr(ListBox.Items[j], DisplayVal) then
                begin
                   FItemIndex:= i;
                   Text:= DisplayVal;
                   Listbox.itemindex := i;   //10/20/2000 - Update listbox's itemindex property when value set.
                   break;
                end
            end;
            exit;
         end
      end;
      if FItemIndex=-1 then Text:= '';
   end
   else begin
//      FItemIndex:= ListBox.Items.IndexOf(Value);
      FItemIndex:= IndexOf(Value);
      Text:= Value;
   end
end;

{ Map a HiddenValue to its corresponding Display Value }
Function TwwDBCustomComboBox.GetComboDisplay(Value: string): string;
var curpos, i: integer;
   DisplayVal: string;
begin
   Result:= '';
   if FMapList or TwoColumnDisplay then
   begin
      for i:= 0 to FItems.count-1 do begin
         curpos:= 1;
         DisplayVal:= strGetToken(FItems[i], #9, curPos);
         if strGetToken(FItems[i], #9, curPos)=Value then
         begin
            result:= DisplayVal;
            exit;
         end
      end
   end
   else Result:= Value;
end;

{ Map a DisplayValue to its corresponding Hidden Value }
Function TwwDBCustomComboBox.GetComboValue(DisplayText: string): string;
var curpos, i: integer;
begin
   result:= DisplayText;
   if FMapList or TwoColumnDisplay then begin
      // 12/12/2001-Don't clear result if this is for TwoColumnDisplay
      if not TwoColumnDisplay then result:= '';  // 10/4/01 - Otherwise returns displaytext when it does not find value
      for i:= 0 to FItems.count-1 do begin
         curpos:= 1;
         if wwEqualStr(strGetToken(FItems[i], #9, curPos), DisplayText) then // 2/19/02 - Case insensitive
//         if strGetToken(FItems[i], #9, curPos)=DisplayText then
         begin
            result:= strGetToken(FItems[i], #9, curPos);
            break;
         end
      end
   end
//   else Result:= DisplayText;
end;

procedure TwwDBCustomComboBox.DataChange(Sender: TObject);
begin
  if Patch[1] then exit;  // 2/24/99 - Fix for ItemIndex being incorrect at time of OnCloseUp
  if csDestroying in ComponentState then exit; // 12/17/00 RSW - Fix problem where handle gets created when destroying

  if MapList or HistoryList.enabled then  // 2/22/2002 - Don't do otherwise to delay listbox creation until necessary
     ListBoxItemsNeeded;

  { When mapping list don't do edit masking }
  if MapList then begin
     if DataLink.Field <> nil then
       SetComboText(DataLink.Field.asString)
     else
       if csDesigning in ComponentState then
         SetComboText(Name)
       else
         SetComboText('');
  end
  else begin
    if (DataLink.Field<>Nil) then begin
       SetComboText(DataLink.Field.DisplayText); { 6/20/98 }
       if OwnerDraw then begin
          FItemIndex:= IndexOf(DataLink.Field.asString);
//          FItemIndex:= FListBox.Items.IndexOf(DataLink.Field.asString);
          invalidate;
       end
    end;

    inherited DataChange(Sender);
  end
end;

procedure TwwDBCustomComboBox.SetComboText(const Value: string);
var
  I,J: Integer;
  curPos: integer;
  NewText: string;
begin
  if (Value <> GetComboText) or ((Value='') and MapList) then  {5/6/97 - Support null mapping }
  begin
    if (Style in [csDropDown]) and (not FMapList) then
    begin
       Text := Value;
       FItemIndex:= IndexOf(Value);
       exit;
    end;

    if (Value = '') and (not MapList) then I := -1  { 5/6/97 - Support null mapping }
    else begin
       if (FMapList) then begin
          i:= -1;
          for j:= 0 to FItems.count-1 do begin
             curpos:= 1;
             NewText:= strGetToken(FItems[j], #9, curPos);
             if Value=strGetToken(FItems[j], #9, curPos) then begin
//                i:= j;
                i:= IndexOf(NewText);
//                i:= ListBox.Items.IndexOf(NewText);
                Text:= NewText;
                break;
             end
          end;
//          if i>=FListBox.Items.count then i:= -1;
       end
       else I:= IndexOf(Value);
//       else I:= ListBox.Items.IndexOf(Value);
    end;

    // 2/22/02
    if (FListbox=nil) or (not FListbox.HandleAllocated) then
      FItemIndex:= I
    else ItemIndex := I;

    if I >= 0 then Exit;
    if ItemIndex<0 then Text:= ''
  end
end;

procedure TwwDBCustomComboBox.SetItemList(Value: TStrings);
begin
  FItems.Assign(Value);
  DataLink.OnDataChange(Self);
end;

procedure TwwDBCustomComboBox.Loaded;
begin
  inherited;
//  FHistoryList.Source := FItems;
end;

Function TwwDBCustomComboBox.GetSorted: boolean;
begin
   result:= (FItems as TStringList).Sorted;
end;

Procedure TwwDBCustomComboBox.SetSorted(val: boolean);
begin
   (FItems as TStringList).sorted:= val;
{   FItems.Sorted:= val;}
end;

procedure TwwDBCustomComboBox.ApplyList;
var i, curpos: integer;
   TempList:TStringList;
   token1,token2:string;
begin
  ListBoxNeeded;  { 8/16/96 - Listbox needed before applying list }
  (FListbox.Items).clear;
  for i:= 0 to FItems.count-1 do
  begin
     curPos:= 1;
     if MapList then
       (FListbox.Items).add(strGetToken(FItems[i], #9, curPos))
     else begin
       token1:= strGetToken(FItems[i], #9, curPos);
       token2:= strGetToken(FItems[i], #9, curPos);
       if (token2='') then
          (FListbox.Items).add(token1)
       else
          (FListbox.Items).add(token2)
     end;
//     (FListbox.Items).add(strGetToken(FItems[i], #9, curPos));
  end;

  if HistoryList.enabled then
    HistoryList.Load(FListbox.Items);

  if HistoryList.enabled and HistoryList.MRUEnabled then
  begin
      TempList := TStringList.create;
      TempList.assign(FListBox.Items);
      TempList.Sorted := Sorted; //True;

      FListbox.sorted:= false;
      FListBox.Items.Clear;
      FListBox.Items.assign(TempList);

//      Sorted:= False;

{      TempList.Clear;
      with HistoryList do begin
        if (List.Count>=EffectiveMRUCount) then begin
            for i:= List.Count-EffectiveMRUCount to List.Count - 1 do
               TempList.Add(List[i]);

            for i:= 0 to TempList.count-1 do //TempList.count-1 downto 0 do
               FListBox.Items.Insert(0, TempList[i]);
        end
        else
            for i:= 0 to List.count-1 do FListBox.Items.Insert(0, List[i]);
      end;
}
      with HistoryList do begin
         if (List.Count>EffectiveMRUCount) then begin
            for i:= List.Count-EffectiveMRUCount to List.Count - 1 do
                FListBox.Items.Insert(0, List[i]);
         end
         else begin
             for i:= 0 to List.count-1 do FListBox.Items.Insert(0, List[i]);
         end;
      end;
      Templist.free;
  end;

  DirtyListBox:= False; // 10/4/01 - Listbox is accurate after applying list
end;

procedure TwwDBCustomComboBox.SetDroppedDown(val: boolean);
begin
   if IsDroppedDown then
   begin
      if (not val) then CloseUp(True)
   end
   else if val then DropDown;
end;

procedure TwwDBCustomComboBox.DropDown;
var
  P: TPoint;
  X, Y: Integer;
  WinAttribute: HWnd;
  ListBoxWidth, ListBoxHeight: integer;
{  parentForm: TCustomForm;}
   function GetDeskTopHeight:Integer;
   var Rect1:TRect;
   begin
      if SystemParametersInfo(SPI_GETWORKAREA,0,@Rect1,0) Then
         GetDeskTopHeight:=Rect1.Bottom-Rect1.Top
      else
         GetDeskTopHeight:=Screen.Height;
   end;
begin
   if FListVisible or (Style=csSimple) then exit;
   Invalidate;
{   EnableEdit;}  { 6/4/97 - Don't enter edit mode - Let EditCanModify handle it in CloseUp event}

   ApplyList;
   //11/05/2001 - Allow overriding of Listbox Color and Font.
   FListBox.Color := Color;
   FListBox.Font := Font;

   if Assigned(FOnDropDown) then
   begin
      FOnDropDown(Self);
      if DisableDropDownList then exit;
      ApplyList;  { In case the list was modified }
   end
   else if DisableDropDownList then exit;

   case Style of
      csOwnerDrawFixed: FListBox.Style:= lbOwnerDrawFixed;
      csOwnerDrawVariable: FListBox.Style:= lbOwnerDrawVariable;
      else begin
         if (HistoryList.Enabled and HistoryList.MRUEnabled) or TwoColumnDisplay then
            FListbox.Style:= lbOwnerDrawFixed;
      end
   end;

   if HistoryList.enabled and HistoryList.MRUEnabled then
      FListBox.Sorted:= False
   else FListBox.Sorted:= Sorted;
//   FListBox.Color := Color;
//   FListBox.Font := Font;
   if FItemHeight=0 then
     FListBox.ItemHeight:= FListbox.Canvas.TextHeight('A') + 2
   else
     FListBox.ItemHeight:= FItemHeight;

   if FListBox.Items.Count >= DropDownCount then
     ListBoxHeight:= DropDownCount * FListBox.ItemHeight + 4
   else
     ListBoxHeight:= FListBox.Items.Count * FListBox.ItemHeight + 4;

   if FDropDownWidth=0 then
   begin
      if Column1Width = 0 then
         ListBoxWidth:= Width
      else
         ListBoxWidth:= Column1Width * 3 div 2;//ListBoxWidth:= Width
   end
   else ListBoxWidth:= FDropDownWidth;

   { Pre-select record }
   if OwnerDraw and (DataLink.Field<>Nil) then
      //SetListBoxItemIndex(IndexOf(DataLink.Field.asString))
      //11/05/2001 - Not taking into account maplist when owner draw.
      SetListBoxItemIndex(IndexOf(Text))
//      SetListBoxItemIndex(FListBox.Items.IndexOf(DataLink.Field.asString))
   else if Text='' then
      SetListBoxItemIndex(-1)
   else begin
     if Field<>Nil then
        SetListBoxItemIndex(IndexOf(Text))
//        SetListBoxItemIndex(FListBox.Items.IndexOf(Text))
     else
        SetListBoxItemIndex(IndexOf(Text))
//        SetListBoxItemIndex(FListBox.Items.IndexOf(Text))
   end;

   P := Parent.ClientToScreen(Point(Left, Top));
   Y := P.Y + Height - 1;
   if BorderStyle = bsNone then y:= y + 1;

  { 11/28/2000 - PYW - Check based on actual work area. }
   if Y + ListBoxHeight > GetDeskTopHeight then Y := P.Y - ListBoxHeight;

   { 4/1/97 - Expand list to left since it goes past edge of screen }
   X := P.X ;
   if P.X + ListBoxWidth >= Screen.Width then X := P.X + Width - 1 - ListBoxWidth;

   { 3/13/97 - Always Top so that drop-down is not hidden under taskbar}
   WinAttribute:= HWND_TOPMOST;
   SetWindowPos(FListBox.Handle, WinAttribute, X, Y, ListBoxWidth, ListBoxHeight,
    {  SWP_NOSIZE or} SWP_NOACTIVATE or SWP_SHOWWINDOW);
   FListVisible := True;
   FNoKeysEnteredYet:= True;

   WinProcs.SetFocus(Handle);
   if not inAutoDropDown then DoSelectAll;
   if Editable then ShowCaret(Handle);

   LastShowHint:= ShowHint;
   ShowHint:= False;
   Invalidate;

   {$ifdef wwDelphi4up}
   if wwHook=0 then
      wwHook := SetWindowsHookEx(WH_MOUSE, @wwHookProc, HINSTANCE, GetCurrentThreadID);
   {$endif}

   PreDropDownText:= Text;

end;

procedure TwwDBCustomComboBox.CloseUp(Accept: Boolean);
var
  ListValue: String;
begin
  if FListVisible then
  begin
    ListValue:= '';
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if (not ReadOnly) and Accept and (FListbox.ItemIndex <> -1) and (FListbox.items.count>0) then
        ListValue := FListbox.Items[FListbox.ItemIndex]
   { 9/26/97 - Prevents going into edit mode  if ListValue=Text}
    else if style=csDropDown then ListValue:= Text
    else if style=csDropDownList then begin
       if FListBox.ItemIndex=-1 then ListValue:= Text { don't clear if item not found }
    end;

    SetWindowPos(FListbox.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    if Accept then
    begin
      if (DataLink.Field=Nil) and (inherited ReadOnly) then // 2/22/02 - do nothing if unbound and readonly
      else try
        Patch[1]:= True;
        if (ListValue<>PreDropDownText) and EditCanModify then { 6/5/97 - Only update if changed }
        begin
           if ListValue<>'' then begin
              Text:= ListValue;
           end
           else if (Style=csDropDownList) or FMapList then Text:= '';
           FItemIndex:= FListBox.itemIndex;
           SetModified(True);  {1/21/97}

           if FHistoryList.Enabled and Modified then
           begin
              AddItem(Text, True);
              HistoryList.Save;
           end;

        end;
      finally
        Patch[1]:= False;
      end
    end;
    if (not Editable) then HideCaret(Handle);
    Invalidate;
    DoSelectAll;
{    FListBox.Free;
    FListBox:= Nil; } { 5/2/97}
    if self is TwwDBComboBox then
      if Assigned(FOnCloseUp) then FOnCloseUp(TwwDBComboBox(Self), Accept);
    ShowHint:= LastShowHint; { 10/12/98 }
  end
  else if Accept and (not MapList) then begin // 7/12/02 - Clear itemindex if user cleared text
     if Text='' then
       ItemIndex:= -1;
  end;


   {$ifdef wwDelphi4up}
   if wwHook<>0 then
   begin
     UnhookWindowsHookEx(wwHook);
     wwHook:= 0;
   end;
   {$endif}

end;

Procedure TwwDBCustomComboBox.DoSelectAll;
begin
   if Editable then SelectAll;
end;

Function TwwDBCustomComboBox.GetItemIndex: integer;
begin
   if (FListBox<>Nil) then result:= FListbox.itemIndex
   else result:= FItemIndex;
end;

procedure TwwDBCustomComboBox.SetListBoxItemIndex(val: integer);
begin
   { workaround for Delphi 4 bug in listbox/combo-box}
   {$ifdef wwdelphi4up}
   SendMessage(FListbox.Handle, LB_SETCURSEL, Val, 0);
   {$endif}
   FListbox.ItemIndex:= val;
end;

procedure TwwDBCustomComboBox.SetItemIndex(val: integer);
begin
   FItemIndex:= val;
   ListBoxItemsNeeded;
   if (FListBox<>Nil) then SetListBoxItemIndex(Val);
   if (val>=0) and (val<FListBox.Items.count) then
   begin
      Text:= FListBox.Items[val];
   end
   else if val=-1 then Text:= '' { 12/6/98 }
end;

Function TwwDBCustomComboBox.isDroppedDown: boolean;
begin
    result:= FListVisible;
end;

procedure TwwDBCustomComboBox.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FListBox) and
     (Message.Sender <> Button) then
    CloseUp(True);
end;

procedure TwwDBCustomComboBox.WMKillFocus(var Message: TMessage);
begin
  inherited;
  CloseUp(True);
  if FHistoryList.Enabled and Modified then
  begin
     AddItem(Text, True);
     HistoryList.Save;
  end
end;

procedure TwwDBCustomComboBox.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and PtInRect((Sender as TCustomListBox).ClientRect, Point(x,y)) then
    CloseUp(PtInRect(FListBox.ClientRect, Point(X, Y)));
end;

procedure TwwDBCustomComboBox.CNKeyDown(var Message: TWMKeyDown);
begin
  if not (csDesigning in ComponentState) then
    with Message do
    begin
       if (charcode = VK_TAB) and FListVisible then Closeup(True)
       else if FListVisible and
        ((charcode=vk_return) or (charcode=vk_escape)) then
         exit;
    end;

  inherited;
end;

procedure TwwDBCustomComboBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
   if AllowClearKey then begin
      if FListVisible then begin
         if ((key=vk_delete) or (key=vk_back)) and (Text='') then
            itemIndex:= -1
      end
      else begin
         if ((key=vk_delete) or (key=vk_back)) and
             (Style=csDropDownList) and (not ShowMatchText) then
         begin
            EnableEdit; {7/30/97 - Enable edit }
            Text:= '';
            itemIndex:= -1;  { 8/22/96}
            SetModified(True);  {11/18/97}
         end
      end;
   end;

   inherited KeyUp(Key, Shift);
end;

procedure TwwPopupListbox.WMKeyDown(var Message: TWMKeyDown);
begin
   // Allow combo's text to change when scrolling
   if message.charcode in [vk_next, vk_prior, vk_up, vk_down] then
     (parent as TwwDBCustomComboBox).doSelchange:= true;
   inherited;
   (parent as TwwDBCustomComboBox).doSelchange:= False;
end;
{procedure TwwPopupListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
   if key in [vk_next, vk_prior, vk_up, vk_down] then
     (parent as TwwDBCustomComboBox).doSelchange:= true;
   inherited;
   (parent as TwwDBCustomComboBox).doSelchange:= False;
end;
}
{ Support scrolling vai VK_Up and VK_Down when listbox is not shown. }
procedure TwwDBCustomComboBox.KeyDown(var Key: Word; Shift: TShiftState);
var curpos: integer;
//    tempIndex: integer;
//    Litem:string;

    procedure SelectValue(AIndex: integer);
    begin
       ListBoxItemsNeeded;
       if AIndex>FListBox.Items.count-1 then exit;
       if AIndex<0 then exit;
       if (Datasource<>nil) then begin
          DataLink.Edit;
          if not DataLink.Editing then begin
            if (DataLink.Field<>nil) and (DataLink.Field.Calculated) and EditCanModify then
               DataLink.DataSet.Edit
            else exit; { 4/2/99 - Support calculated field edits}
          end
       end;
       curpos:= 1;
       SetItemIndex(AIndex);  { 9/24/97 - Call SetItemIndex instead of setting FItemIndex }
{       FItemIndex:= AIndex;
       Text:= strGetToken(FItems[AIndex], #9, curPos);}
       SetModified(True);  {5/17/97}
       DoSelectAll;
    end;

    procedure ClearValue;
    begin
       if Text<>'' then
       if (Datasource<>nil) then begin
          DataLink.Edit;
          if not DataLink.Editing then begin
            if (DataLink.Field<>nil) and (DataLink.Field.Calculated) and EditCanModify then
               DataLink.DataSet.Edit
            else exit; { 4/2/99 - Support calculated field edits}
          end
       end;
       SetItemIndex(-1);
       SetModified(True);
    end;

    function IsCtrlX: boolean;
    begin
       result:= (key=ord('X')) and (ssCtrl in Shift)
    end;

begin
   if (Key = VK_RETURN) and FHistoryList.Enabled then AddItem(Text, True);

   if (not DroppedDown) and wwIsValidChar(Key) and AutoDropDown and
      (not (key in [VK_DELETE,VK_BACK])) and
      not (ssAlt in Shift) then begin { 9/25/97 - Don't auto-drop down if alt key is pressed }
      InAutoDropDown:= True;
      DropDown;
      InAutoDropDown:= False;
   end;

   if GetKeyState(VK_MENU) < 0 then
   begin
      Include(Shift, ssAlt);
   end;

   { 3/31/99 - Improved support for ShowMatchText and AllowClearKey }
   if ShowMatchText and
      ((key=vk_delete) or (key=vk_back) or IsCtrlX) and (Style=csDropDownList) then
   begin
      if (AllowClearKey) and (selText=Text) then
      begin
         if (DataLink.Field=Nil) and (inherited ReadOnly) then // 2/22/02 - do nothing if unbound and readonly
         else ClearValue;
         key:= 0;
      end
      else begin
{         if (selStart>0) then
         begin
            SendMessage(Handle, EM_SETSEL, length(Text), selStart-1);
            SendMessage(Handle, EM_SCROLLCARET, 0,0);
         end; }
         key:= 0;
      end;
   end
   else if (not (FListVisible)) then
   begin
      if (not (parent is TCustomGrid)) and { 6/22/99 - Support TwwObjectView }
         ((Key=VK_Down) or (Key=vk_Up)) then
      begin
         if (DataLink.Field=Nil) and (inherited ReadOnly) then // 2/22/02 - do nothing if unbound and readonly
         else begin
           if key=vk_down then SelectValue(FItemIndex + 1)
           else SelectValue(FItemIndex-1);
         end;
         if Assigned(OnKeyDown) then OnKeyDown(Self, Key, Shift);  { 9/5/00 - Fire onkeydown event }
         Key:= 0;
         exit;
      end
      else if ShowMatchText then
(*      else if not Editable {(Style=csDropDownList)} and wwIsValidChar(Key) then begin  { Use first character to search }
         if not (ssAlt in Shift) then { 9/25/97 - Don't search if alt key is pressed }
         for i:= FItemIndex+1 to (FItemIndex + FItems.count) do begin
            tempIndex:= i mod (FItems.count);
            curpos:= 1;
            Litem:=uppercase(strGetToken(FItems[tempIndex],#9, curPos));
            if (key >= VK_NUMPAD0) and (key <= VK_NUMPAD9) then  {1/16/98- Handle Numpad keys}
            begin
               if pos(uppercase(char(key-ord('0'))),Litem)=1 then begin
                  SelectValue(tempIndex);
                  break;
               end
            end
            else if pos(uppercase(char(key)),Litem)=1 then begin
               SelectValue(tempIndex);
               break;
            end
         end;
      end
*)
   end
   else begin
      if FListVisible and
         ((Style<>csDropDown) or AutoDropDown or   { 9/12/96 - Added "or AutoDropDown" }
         ((Style=csDropDown) and False and (selLength=length(Text)))) and  { 9/24/96 - Clear if all selected }
         wwIsValidChar(Key) and FNoKeysEnteredYet then
      begin
         EnableEdit; {7/23/97 - Enable edit so later call to edit will not revert text to original value}
//         Text:= '';  { 8/21/00 - Obsolete with new style enhancements - causes bug if left here now }
         FNoKeysEnteredYet:= False;
      end
   end;
   inherited KeyDown(Key, Shift);
end;

Function TwwDBCustomComboBox.Editable: boolean;
begin
   if OwnerDraw then result:= False
   else Result := (FStyle <> csDropDownList) {or isDroppedDown }or ShowMatchText;
end;

Function TwwDBCustomComboBox.MouseEditable: boolean;
begin
   if OwnerDraw then result:= False
   else Result := (FStyle <> csDropDownList);
end;

Procedure TwwDBCustomComboBox.ShowText(ACanvas: TCanvas;
          ARect: TRect; indentLeft, indentTop: integer; AText: string);
begin
   FCanvas:= ACanvas;
   if Assigned(FOnDrawItem) and OwnerDraw then
   begin
      if isDroppedDown then begin
         FCanvas.Brush.Color:= Color;
         FCanvas.Font.Color:= Font.Color;
      end;
      FCanvas.TextRect(ARect, ARect.Left, ARect.Top, '');
      try //10/29/01 - Handle the case when abort is called.
        FOnDrawItem(self, FItemIndex, ARect, [odFocused])
      except
      end;
   end
   else ACanvas.TextRect(ARect, indentLeft, indentTop, AText);
   FCanvas:= Nil;
end;

Function TwwDBCustomComboBox.OwnerDraw: boolean;
begin
   result:= Style in [csOwnerDrawFixed, csOwnerDrawVariable]
end;

Procedure TwwDBCustomComboBox.SetStyle(val: TComboBoxStyle);
begin
   if val=csSimple then ShowButton:= False
   else if (FStyle=csSimple) then ShowButton:= True;
   FStyle:= val;
end;

procedure TwwDBCustomComboBox.WMCut(var Message: TMessage);
begin
  if (Style=csDropDownList) and ShowMatchText and (not AllowClearKey) then
     message.result:=1
  else
     inherited;
end;

procedure TwwDBCustomComboBox.WMClear(var Message: TMessage);
begin
  if (Style=csDropDownList) and ShowMatchText and (not AllowClearKey) then
     message.result:=1
  else
     inherited;
end;


procedure TwwDBCustomComboBox.DeleteItem(Value: string; DeleteFromHistory: boolean = False);
var idx: integer;
begin
    if DeleteFromHistory then begin
       idx:= HistoryList.List.IndexOf(Value);
       if idx>=0 then HistoryList.List.Delete(idx);
    end;

    if (ListBox<>nil) and ListBox.HandleAllocated then begin
       idx:= Listbox.Items.IndexOf(Value);
       if idx>=0 then Items.Delete(idx);
       idx:= Listbox.Items.IndexOf(Value);  // do twice in case of mru
       if idx>=0 then Items.Delete(idx);
    end
end;

procedure TwwDBCustomComboBox.AddItem(Value: string; AddToHistory: boolean = False);
var idx: integer;
    accept: boolean;
begin
    strStripTrailing(Value, [' ', #9]);
//    ApplyMask;
    if Value='' then exit;

    idx:= HistoryList.List.IndexOf(Value); // 9/18/02 - Don't call addhistory event if already in list
    if (idx<0) and Assigned(FOnAddHistoryItem) then begin
       accept := True;
       FOnAddHistoryItem(Self, Value, accept);
       if accept = False then exit;
    end;

    if AddToHistory then begin
//       idx:= HistoryList.List.IndexOf(Value);
       if idx>=0 then HistoryList.List.delete(idx);  { By deleting keeps most recent at bottom of list }
       HistoryList.List.Add(Value);
    end;

    if (ListBox<>nil) and ListBox.HandleAllocated then begin
        if ListBox.Items.Indexof(Value)<0 then
           Listbox.Items.Add(Value);
    end;
end;

procedure TwwDBCustomComboBox.ClearHistory;
begin
   HistoryList.List.Clear;
   HistoryList.Save;
end;

procedure Register;
begin
{  RegisterComponents('InfoPower', [TwwDBComboBox]);}
end;

procedure TwwDBCustomComboBox.CMEnter(var Message: TCMEnter);
//var i: integer;
begin
   inherited;
   if HistoryList.Enabled then begin
      ApplyList;
//      HistoryList.Load(Listbox.Items);
   end;

{   with HistoryList do begin
      if List.Count>2 then
      begin
        for i := List.Count-2 to List.Count - 1 do
          Listbox.Items.Insert(0, List[i]);
      end
   end;}
end;

procedure TwwDBCustomComboBox.CMExit(var Message: TCMExit);
begin
   inherited;
end;

Function TwwDBCustomComboBox.IndexOf(Value: string; StartIndex: integer = 0) : integer;
var i, tempIndex: integer;
begin
   // 2/23/02 - Use FItems if listbox not yet created
   if (Listbox=nil) or (not Listbox.HandleAllocated) or
      (ListBox.Items.Count=0) then
      result:= FItems.Indexof(Value)
   else if startIndex=0 then
      result:= ListBox.Items.IndexOf(Value)
   else begin
       result:= -1;
       for i:= startIndex to (startIndex + ListBox.Items.count-1) do begin
          tempIndex:= i mod (ListBox.Items.count);
          if wwEqualStr(ListBox.Items[tempIndex], Value) then
          begin
             result:= tempIndex;
             break;
          end
       end;
   end
end;

// 11/29/01 - Don't paste into control with csDropDownList
procedure TwwDBCustomComboBox.WMPaste(var Message: TMessage);
begin
  if Style=csDropDownList then
    exit
  else
    inherited;
end;

end.

