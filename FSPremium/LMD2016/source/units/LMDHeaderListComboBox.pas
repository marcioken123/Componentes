unit LMDHeaderListComboBox;
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

LMDHeaderListComboBox unit (JH)
-------------------------------

ComboBox with a header list (colum list) drop down

Due to SetCapture Headerpanel resizing will fail if was already above 
the item list / the same is valid in regards to the scrollbar

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Controls,
  ComCtrls,
  Messages,
  Windows,
  LMDListBox,
  LMDCustomExtCombo;

type
  TLMDHeaderListComboBox = class (TLMDCustomExtCombo)
  private
    FOld : String;
    FDisplayColumn,
    FDropDownCount : Integer;
    procedure SetItems (aValue : TStrings);
    function GetItems : TStrings;
    procedure SetHeaderSections (aValue : THeaderSections);
    function GetHeaderSections : THeaderSections;
    procedure SetDisplayColumn (aValue : Integer);
    procedure SetDelimiter (aValue : Char);
    function GetDelimiter : Char;
    function GetListBox:TLMDListBox;
    function GetValue: string;
    function GetItemIndex: Integer;
    procedure SetItemIndex(const Value: Integer);
    procedure SetSValue(const Value: string);
    procedure WMKEYUP (var Msg : TWMKeyUp); message WM_KEYUP;    
  protected
    //procedure ControlWndProc(var Message: TMessage); override;
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
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;override;
    function GetControl : TWinControl; override;
    procedure DoDownKey; override;
    procedure DoUpKey; override;
    procedure Loaded; override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Init;override;
    // 7.11
    procedure Clear; override;
    // ----
    property ListBox:TLMDListBox read GetListBox;
    property Value:string read GetValue write SetSValue;
  published
    property Items : TStrings read GetItems write SetItems;
    property DropDownWidth;
    property DropDownCount : Integer read FDropDownCount write FDropDownCount default 8;
    property HeaderSections : THeaderSections read GetHeaderSections write SetHeaderSections;
    property DisplayColumn : Integer read FDisplayColumn write SetDisplayColumn default -1;
    property Delimiter : Char read GetDelimiter write SetDelimiter;
    property ItemIndex : Integer read GetItemIndex write SetItemIndex;
    property ReadOnly;
    property Style;
  end;

  TLMDLabeledHeaderListComboBox = class(TLMDHeaderListComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

  // ---------------------------------------------------------------------------
  // IMPORTANT: For CLR compatibility TLMDListBoxHack HAS to reside in interface
  //            section
  // ---------------------------------------------------------------------------
  TLMDListBoxHack = class (TLMDListBox)
  private
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
  protected
    procedure InternalMouseMove(Shift: TShiftState; X, Y: Integer);override;
  public
    constructor Create(AOwner: TComponent);override;
  end;

implementation

uses
  Types, Forms, Graphics, SysUtils,
  LMDGraph, LMDCustomMaskEdit;

procedure TLMDListBoxHack.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  if PtInRect (self.Header.ClientRect, Point(Message.XPos, Message.YPos)) then
    begin
      SendMessage (self.Header.Handle, WM_MOUSEMOVE, TMessage(Message).wParam, TMessage(Message).lParam);
      exit;
    end;
  if not PtInRect (lb.ClientRect, Point(Message.XPos, Message.YPos - HeaderHeight)) then
    begin
      ReleaseCapture;
      //SendMessage (self.Header.Handle, WM_MOUSEMOVE, TMessage(Message).wParam, TMessage(Message).lParam);
    end
  else
    if GetCapture<>Handle then
      SetCapture(Handle);
  ItemIndex := ItemAtPos (Point(Message.XPos, Message.YPos-HeaderHeight), true);
end;

procedure TLMDListBoxHack.CMMouseEnter (var Message: TMessage);
begin
  inherited;
  if GetCapture<>Handle then
    SetCapture(Handle);
end;

procedure TLMDListBoxHack.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if PtInRect (self.Header.ClientRect, Point(Message.XPos, Message.YPos)) then
    begin
      SendMessage(self.Header.Handle, WM_LButtonDown, TMessage(Message).wParam, TMessage(Message).lParam);
      exit;
    end
  else
    if PtInRect (lb.ClientRect, Point(Message.XPos, Message.YPos - HeaderHeight)) then
      begin
        ItemIndex := ItemAtPos (Point(Message.XPos, Message.YPos-HeaderHeight), true);
        (Parent as TLMDHeaderListComboBox).Close(true);
      end
    else
      begin //check wether we were on scroll bar ...
        inherited;
      end;
end;

procedure TLMDListBoxHack.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TLMDListBoxHack.InternalMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SetCapture(Handle);
end;

constructor TLMDListBoxHack.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible];
end;

{ ---------------------------------- private --------------------------------- }
function TLMDHeaderListComboBox.GetListBox : TLMDListBox;
begin
  result:=TLMDListBox(FControl);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHeaderListComboBox.GetValue: String;
begin
  result:=AsString;
end;
{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.SetItems (aValue : TStrings);
begin
  (FControl as TLMDListBox).Items.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.SetSValue(const Value: String);
begin
  inherited Text:=Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.WMKEYUP(var Msg: TWMKeyUp);
begin
  //VB June 2008: selection via cursor keys does not work without this
  if DroppedDown then
    case Msg.CharCode of
      VK_DOWN   : DoDownKey;
      VK_UP     : DoUpKey;
    end
end;

{ ---------------------------------------------------------------------------- }
function TLMDHeaderListComboBox.GetItemIndex: Integer;
begin
  Result := FItemIndex;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.SetItemIndex(const Value: Integer);
begin
  if (Value >= -1) and (Value < Items.Count) then
  begin
    FItemIndex := Value;
    if Assigned(FControl) then
      (FControl as TLMDListBoxHack).ItemIndex := Value;
    Accept;
  end;  
end;

{ ---------------------------------------------------------------------------- }
function TLMDHeaderListComboBox.GetItems : TStrings;
begin
  result := (FControl as TLMDListBox).Items;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.SetHeaderSections (aValue : THeaderSections);
begin
  (FControl as TLMDListBox).HeaderSections.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHeaderListComboBox.GetHeaderSections : THeaderSections;
begin
  result := (FControl as TLMDListBox).HeaderSections;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.SetDisplayColumn (aValue : Integer);
begin
  FDisplayColumn := aValue;
  Accept;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.SetDelimiter (aValue : Char);
begin
  (FControl as TLMDListBox).Delimiter := aValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHeaderListComboBox.GetDelimiter : Char;
begin
  result := (FControl as TLMDListBox).Delimiter;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDHeaderListComboBox.ControlWndProc(var Message: TMessage);
begin
    inherited ControlWndProc(Message);
    case Message.Msg of
      WM_VSCROLL:;
    end;
end;}

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.CreateControl;
begin
  FControl := TLMDListBoxHack.Create(self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHeaderListComboBox.GetControl : TWinControl;
begin
  result := TLMDListBoxHack(FControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.DoDownKey;
begin
  //if not DroppedDown then
    if (FControl as TLMDListBox).ItemIndex < (FControl as TLMDListBox).Items.Count-1 then
      begin
        (FControl as TLMDListBox).ItemIndex := (FControl as TLMDListBox).ItemIndex + 1;
        if not DroppedDown then
          Accept;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.DoUpKey;
begin
  //if not DroppedDown then
    if (FControl as TLMDListBox).ItemIndex > 0 then
      begin
        (FControl as TLMDListBox).ItemIndex := (FControl as TLMDListBox).ItemIndex - 1;
        if not DroppedDown then
          Accept;
      end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHeaderListComboBox.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  result := inherited DoMouseWheel (Shift, WheelDelta, MousePos);
  if not result then
    begin
      if WheelDelta > 0 then
        DoUpKey
      else
        DoDownKey;
      result := true;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.DoThemeChanged;
begin
  inherited;
  If Assigned(FControl) and Visible then
    (FControl as TLMDListBoxHack).ThemeMode := self.ThemeMode;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.ModifyControl;
begin
  with (FControl as TLMDListBox) do
    begin
      //OnMouseWheelUp:=
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.ReModifyControl;
var
  h : Integer;
begin
  // 7.02 -> dirty workaround for fixing bug when items are cleared.
  if (FControl as TLMDListBoxHack).Bevel.Mode=bmWindows then
    begin
      (FControl as TLMDListBoxHack).Bevel.Mode:=bmCustom;
      (FControl as TLMDListBoxHack).Bevel.Mode:=bmWindows;
    end;
  // ---

  h := DropDownCount;
  if Items.Count < DropDownCount then
    h := Items.Count + 1;
  h := 3 + h * (FControl as TLMDListBox).ItemHeight + {(FControl as TLMDListBox).HeaderHeight +}
                                      (FControl as TLMDListBox).Bevel.BevelExtend * 2;
  // while h + Top + Height > Screen.Height do dec (h);
  FControl.Height := h;
  if (DropDownWidth>0) and (Items.Count>0) then
    FControl.Width := DropDownWidth
  else
    FControl.Width := Width;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.DisplayControl;
begin
  SelectAll;
  (FControl as TLMDListBoxHack).ItemIndex := Items.IndexOf (Text);
  SetCaptureControl(FControl as TLMDListBoxHack);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.BeforeDropDown;
begin
  FOld := Text;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.Cancel;
begin
  Text := FOld;
  ReleaseCapture;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.Accept;
var
  s: String;
begin
  ReleaseCapture;
  if (FControl as TLMDListBoxHack).ItemIndex > -1 then
  begin
    if FDisplayColumn <> -1 then
      s:= (FControl as TLMDListBoxHack).ItemPart ((FControl as TLMDListBoxHack).ItemIndex, FDisplayColumn)
    else
      s := (FControl as TLMDListBoxHack).Items[(FControl as TLMDListBoxHack).ItemIndex];
    FItemIndex := (FControl as TLMDListBoxHack).ItemIndex;
    Text := s;
    inherited;
  end
  else
  begin
    Text := '';
    CheckModified;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Check: Boolean;
begin
  Check := DroppedDown;
  inherited MouseDown (Button, Shift, X, Y);
  if (not Check) and (Style = csDropDownList) then DoDropDownClick (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.ModifyTextRect;
begin
  inherited;
  if Style = csDropDownList then InflateRect (FTextRect, -1, -1);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHeaderListComboBox.RedrawOnExit: Boolean;
begin
  result := (inherited RedrawOnExit) or (Style = csDropDownList);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHeaderListComboBox.RedrawOnEnter: Boolean;
begin
  result := (inherited RedrawOnEnter) or (Style = csDropDownList);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.Loaded;
begin
  inherited Loaded;
  if (FItemIndex > -1) and (FItemIndex < Items.Count) then
    Text := Items[FItemIndex];  
  Init;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDHeaderListComboBox.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FDropDownCount := 8;
  FDisplayColumn := -1;
  CreateAndSetup;
  if (csDesigning in ComponentState) then FControl.Width := 0;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDHeaderListComboBox.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.Clear;
begin
  (FControl as TLMDListBoxHack).ItemIndex:=-1;
  (FControl as TLMDListBoxHack).Clear;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderListComboBox.Init;
begin
  MaskType := meNone;
end;

{ ********************** TLMDLabeledHeaderListComboBox ************************}
{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledHeaderListComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

initialization
  Classes.RegisterClass (TLMDListBoxHack);
end.
