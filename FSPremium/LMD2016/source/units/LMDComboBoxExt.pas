unit LMDComboBoxExt;
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

LMDComboBoxExt unit
-------------------

ComboBox with a header list (colum list) drop down

Due to SetCapture Headerpanel resizing will fail if was already above
the item list / the same is valid in regards to the scrollbar

Changes
-------
Release 11.0 (November 2010)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Controls,
  ComCtrls,
  Messages,
  Windows,
  StdCtrls,
  LMDListBoxExt,
  LMDCustomExtCombo;

type
  TLMDComboBoxExt = class(TLMDCustomExtCombo)
  private
    FOld:            string;
    FDisplayColumn,
    FDropDownCount : Integer;
    FOnDrawItem    : TDrawItemEvent;
    FOnMeasureItem : TMeasureItemEvent;
    FHeaderHeight  : Integer;
    FHeaderVisible : Boolean;

    procedure SetItems (aValue : TStrings);
    function GetItems : TStrings;
    procedure SetHeaderSections (aValue : THeaderSections);
    function GetHeaderSections : THeaderSections;
    procedure SetDisplayColumn (aValue : Integer);
    procedure SetDelimiter (aValue : Char);
    function GetDelimiter : Char;
    function GetListBox:TLMDListBoxExt;
    function GetValue: string;
    function GetItemIndex: Integer;
    procedure SetItemIndex(const Value: Integer);
    procedure SetSValue(const Value: string);
    procedure WMKEYUP (var Msg : TWMKeyUp); message WM_KEYUP;
    function GetMeasureItemEvent: TMeasureItemEvent;
    procedure SetMeasureItemEvent(const Value: TMeasureItemEvent);
    function GetHeaderHeight: integer;
    function GetHeaderVisible: boolean;
    procedure SetHeaderHeight(const Value: integer);
    procedure SetHeaderVisible(const Value: boolean);
  protected
    procedure Change; override;  
    procedure CreateControl; override;
    procedure DoThemeChanged; override;
    procedure ModifyControl; override;
    procedure ReModifyControl; override;
    procedure DisplayControl; override;
    procedure BeforeDropDown; override;
    procedure Cancel; override;
    procedure Accept; override;
    // 7.01
    procedure ModifyTextRect; override;
    function RedrawOnExit: Boolean; override;
    function RedrawOnEnter: Boolean; override;
    // ---
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function  DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;override;
    function  GetControl : TWinControl; override;
    procedure DoDownKey; override;
    procedure DoUpKey; override;
    procedure Loaded; override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure Init;override;
    procedure Clear; override;
    property  ListBox:TLMDListBoxExt read GetListBox;
    property  Value:string read GetValue write SetSValue;
  published
    property ItemIndex : Integer read GetItemIndex write SetItemIndex;
    property Items : TStrings read GetItems write SetItems;
    property DropDownWidth;
    property DropDownCount  : Integer read FDropDownCount write FDropDownCount default 8;
    property HeaderSections : THeaderSections read GetHeaderSections write SetHeaderSections;
    property HeaderHeight   : integer read GetHeaderHeight write SetHeaderHeight default 0;
    property HeaderVisible  : boolean read GetHeaderVisible write SetHeaderVisible default false;

    property DisplayColumn : Integer read FDisplayColumn write SetDisplayColumn default -1;
    property Delimiter : Char read GetDelimiter write SetDelimiter;
    property ReadOnly;
    property Style;
    property OnMeasureItem:TMeasureItemEvent read GetMeasureItemEvent write SetMeasureItemEvent;
    property OnDrawItem:TDrawItemEvent read FOnDrawItem write FOnDrawItem;
  end;

  TLMDLabeledComboBoxExt = class(TLMDComboBoxExt)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

  // ---------------------------------------------------------------------------
  // IMPORTANT: For CLR compatibility TLMDListBoxExtHack HAS to reside in interface
  //            section
  // ---------------------------------------------------------------------------

  TLMDListBoxExtHack = class (TLMDListBoxExt)
  private
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
  protected
    procedure InternalMouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  Types, Forms, Graphics, SysUtils, LMDClass, LMDButtonBase,
  LMDGraph, LMDCustomMaskEdit;

procedure TLMDListBoxExtHack.WMMouseMove(var Message: TWMMouseMove);
var
  LR: TRect;
begin
  inherited;
  if PtInRect(Self.Header.ClientRect, Point(Message.XPos, Message.YPos)) then
  begin
    SendMessage(Self.Header.Handle, WM_MOUSEMOVE, TMessage(Message).wParam,
                TMessage(Message).lParam);
    Exit;
  end;
  if not PtInRect(LR, Point(Message.XPos, Message.YPos - HeaderHeight)) then
    ReleaseCapture
  else
    if GetCapture<>Handle then
      SetCapture(Handle);
  ItemIndex := ItemAtPos(Point(Message.XPos, Message.YPos-HeaderHeight), True);
end;

procedure TLMDListBoxExtHack.CMMouseEnter (var Message: TMessage);
begin
  inherited;
  if GetCapture <> Handle then
    SetCapture(Handle);
end;

procedure TLMDListBoxExtHack.WMLButtonDown(var Message: TWMLButtonDown);
var
  LR: TRect;
begin
  if PtInRect (self.Header.ClientRect, Point(Message.XPos, Message.YPos)) then
    begin
      SendMessage(self.Header.Handle, WM_LButtonDown, TMessage(Message).wParam, TMessage(Message).lParam);
      exit;
    end
  else
  begin
    LR := LB.ClientRect;
    if PtInRect (LR, Point(Message.XPos, Message.YPos - HeaderHeight)) then
      begin
        ItemIndex := ItemAtPos (Point(Message.XPos, Message.YPos - HeaderHeight), true);
        (Parent as TLMDComboBoxExt).Close(true);
      end
    else
      inherited;
  end;
end;

procedure TLMDListBoxExtHack.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TLMDListBoxExtHack.InternalMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SetCapture(Handle);
end;

constructor TLMDListBoxExtHack.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible];
end;

{ ---------------------------------- private --------------------------------- }
function TLMDComboBoxExt.GetListBox : TLMDListBoxExt;
begin
  Result := TLMDListBoxExt(FControl);
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.GetValue: String;
begin
  Result := AsString;
end;
{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.SetItems(aValue: TStrings);
begin
  (FControl as TLMDListBoxExt).Items.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.SetSValue(const Value: String);
begin
  inherited Text := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.WMKEYUP(var Msg: TWMKeyUp);
begin
  //VB June 2008: selection via cursor keys does not work without this
  if DroppedDown then
    case Msg.CharCode of
      VK_DOWN   : DoDownKey;
      VK_UP     : DoUpKey;
    end
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.GetItemIndex: Integer;
begin
  //Result := (FControl as TLMDListBoxExtHack).ItemIndex;
  Result := FItemIndex;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.SetItemIndex(const Value: Integer);
begin
  if (Value >= -1) and (Value < Items.Count) then
  begin
    FItemIndex := Value;
    if Assigned(Control) then
      (FControl as TLMDListBoxExtHack).ItemIndex := Value;
    Accept;
  end;  
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.GetItems: TStrings;
begin
  result := (FControl as TLMDListBoxExt).Items;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.SetHeaderSections (aValue : THeaderSections);
begin
  (FControl as TLMDListBoxExt).HeaderSections.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.GetHeaderSections : THeaderSections;
begin
  result := (FControl as TLMDListBoxExt).HeaderSections;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.SetDisplayColumn (aValue : Integer);
begin
  FDisplayColumn := aValue;
  Accept;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.SetDelimiter (aValue : Char);
begin
  (FControl as TLMDListBoxExt).Delimiter := aValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.GetDelimiter : Char;
begin
  result := (FControl as TLMDListBoxExt).Delimiter;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.CreateControl;
begin
  FControl := TLMDListBoxExtHack.Create(self);
  TLMDListBoxExtHack(FControl).HeaderHeight := 0;
  TLMDListBoxExtHack(FControl).HeaderVisible := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.GetControl : TWinControl;
begin
  result := TLMDListBoxExtHack(FControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.DoDownKey;
begin
  //if not DroppedDown then
    if (FControl as TLMDListBoxExt).ItemIndex < (FControl as TLMDListBoxExt).Items.Count-1 then
    begin
      (FControl as TLMDListBoxExt).ItemIndex := (FControl as TLMDListBoxExt).ItemIndex + 1;
      if not DroppedDown then
        Accept;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.DoUpKey;
begin
  //if not DroppedDown then
    if (FControl as TLMDListBoxExt).ItemIndex > 0 then
    begin
      (FControl as TLMDListBoxExt).ItemIndex := (FControl as TLMDListBoxExt).ItemIndex - 1;
      if not DroppedDown then
        Accept;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
  if not Result then
  begin
    if WheelDelta > 0 then
      DoUpKey
    else
      DoDownKey;
    Result := true;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.DoThemeChanged;
begin
  inherited;
  if Assigned(FControl){ and Visible} then
  begin
    if FControl.ParentWindow <> Handle then
      Windows.SetParent(FControl.Handle, Handle);
    (FControl as TLMDListBoxExtHack).ThemeMode := Self.ThemeMode;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.ModifyControl;
begin
//
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.ReModifyControl;
var
  h : Integer;
begin
  // 7.02 -> dirty workaround for fixing bug when items are cleared.
{  if (FControl as TLMDListBoxExtHack).Bevel.Mode=bmWindows then
    begin
      (FControl as TLMDListBoxExtHack).Bevel.Mode:=bmCustom;
      (FControl as TLMDListBoxExtHack).Bevel.Mode:=bmWindows;
    end;  }
  // ---

  h := DropDownCount;
  if Items.Count < DropDownCount then
    h := Items.Count + 1;
  h := h * (FControl as TLMDListBoxExt).ItemHeight +
       (FControl as TLMDListBoxExt).HeaderHeight +
       (FControl as TLMDListBoxExt).Bevel.BevelExtend * 2;
  // while h + Top + Height > Screen.Height do dec (h);
  FControl.Height := h;
  if (DropDownWidth > 0) and (Items.Count > 0) then
    FControl.Width := DropDownWidth
  else
    FControl.Width := Width;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.DisplayControl;
begin
  SelectAll;
  (FControl as TLMDListBoxExtHack).ItemIndex := Items.IndexOf(Text);
  SetCaptureControl(FControl as TLMDListBoxExtHack);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.BeforeDropDown;
begin
  FOld := Text;
  TLMDListBoxExtHack(FControl).HeaderHeight := FHeaderHeight;
  TLMDListBoxExtHack(FControl).HeaderVisible := FHeaderVisible;
  TLMDListBoxExtHack(FControl).OnDrawItem := FOnDrawItem;
  TLMDListBoxExtHack(FControl).OnMeasureItem := FOnMeasureItem;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.Cancel;
begin
  Text := FOld;
  ReleaseCapture;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.Accept;
var
  s: String;
begin
  ReleaseCapture;
  if (FControl as TLMDListBoxExtHack).ItemIndex > -1 then
  begin
    if FDisplayColumn <> -1 then
      s:= (FControl as TLMDListBoxExtHack).ItemPart ((FControl as TLMDListBoxExtHack).ItemIndex, FDisplayColumn)
    else
      s := (FControl as TLMDListBoxExtHack).Items[(FControl as TLMDListBoxExtHack).ItemIndex];
    inherited;
    FItemIndex := (FControl as TLMDListBoxExtHack).ItemIndex;
    Text := s;
  end
  else
  begin
    Text := '';
    CheckModified;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Check: Boolean;
begin
  Check := DroppedDown;
  inherited MouseDown (Button, Shift, X, Y);
  if (not Check) and (Style = csDropDownList) then DoDropDownClick (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.ModifyTextRect;
begin
  inherited;
  if Style = csDropDownList then
    InflateRect(FTextRect, -1, -1);
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.RedrawOnExit: Boolean;
begin
  Result := (inherited RedrawOnExit) or (Style = csDropDownList);
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.RedrawOnEnter: Boolean;
begin
  Result := (inherited RedrawOnEnter) or (Style = csDropDownList);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.Loaded;
begin
  inherited Loaded;
  if (FItemIndex > -1) and (FItemIndex < Items.Count) then
    Text := Items[FItemIndex];
  if (UseThemeMode <> ttmNone) then
  begin
    TLMDListBoxExtHack(FControl).VScroll.Bevel.Mode := bmStandard;
    TLMDListBoxExtHack(FControl).VScroll.Bevel.StandardStyle := lsNone;
    TLMDListBoxExtHack(FControl).HScroll.Bevel.Mode := bmStandard;
    TLMDListBoxExtHack(FControl).HScroll.Bevel.StandardStyle := lsNone;
  end;
  Init;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDComboBoxExt.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FHeaderHeight  := 0;
  FHeaderVisible := false;

  FDropDownCount := 8;
  FDisplayColumn := -1;
  CreateAndSetup;
  if (csDesigning in ComponentState) then FControl.Width := 0;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDComboBoxExt.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.Clear;
begin
  (FControl as TLMDListBoxExtHack).ItemIndex:=-1;
  (FControl as TLMDListBoxExtHack).Clear;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.Init;
begin
  MaskType := meNone;
  if UseThemeMode = ttmNative then
  begin
    CustomButtonsStyle := ubsWin40Ext; //some workaround for getting button
    CustomButtonsStyle := ubsCombo;    //initialized
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.GetMeasureItemEvent: TMeasureItemEvent;
begin
  result := FOnMeasureItem;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.SetMeasureItemEvent(
  const Value: TMeasureItemEvent);
begin
  FOnMeasureItem := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.GetHeaderHeight: integer;
begin
  result := FHeaderHeight;
end;

{ ---------------------------------------------------------------------------- }
function TLMDComboBoxExt.GetHeaderVisible: boolean;
begin
  result := FHeaderVisible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.SetHeaderHeight(const Value: integer);
begin
  FHeaderHeight := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.SetHeaderVisible(const Value: boolean);
begin
  FHeaderVisible := Value;
end;


{ ********************** TLMDLabeledComboBoxExt ************************}
{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledComboBoxExt.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComboBoxExt.Change;
begin
  inherited;
end;

initialization
  Classes.RegisterClass (TLMDListBoxExtHack);

end.
