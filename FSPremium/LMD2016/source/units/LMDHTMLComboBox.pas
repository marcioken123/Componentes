unit LMDHTMLComboBox;
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
  Classes, Controls, ComCtrls, Messages, Menus, Windows, StdCtrls, Graphics,
  LMDTypes, LMDHTMLExtListBox, LMDCustomExtCombo, LMDHTMLUnit;

type
  TLMDHTMLComboBox = class(TLMDCustomExtCombo)
  private
    FOld : string;
    FDropDownCount : Integer;
    FOnDrawItem    : TDrawItemEvent;
    FOnMeasureItem : TMeasureItemEvent;
    FOnLinkClick: TLMDHTMLLinkClickEvent;
    FOnImageNeeded: TLMDHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FIsHTML: Boolean;
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;

    procedure WMKEYUP (var Msg : TWMKeyUp); message WM_KEYUP;
    procedure SetItems (aValue : TStrings);
    function  GetItems : TStrings;
    function  GetListBox: TLMDHTMLExtListBox;
    function  GetValue: string;
    function  GetItemIndex: Integer;
    procedure SetItemIndex(const Value: Integer);
    procedure SetSValue(const Value: string);
    function  GetMeasureItemEvent: TMeasureItemEvent;
    procedure SetMeasureItemEvent(const Value: TMeasureItemEvent);
    function  GetOnDrawItem: TDrawItemEvent;
    procedure SetOnDrawItem(const Value: TDrawItemEvent);
    procedure SetIsHTML(const Value: Boolean);
    procedure SetLinkColor(const Value: TColor);
    procedure SetLinkStyle(const Value: TFontStyles);
    procedure SetLinkPopupMenu(const Value: TPopupMenu);
  protected
    FRender: TLMDHTMLRender;

    procedure CreateControl; override;
    procedure DoThemeChanged; override;
    procedure ModifyControl; override;
    procedure ReModifyControl; override;
    procedure DisplayControl; override;
    procedure BeforeDropDown; override;
    procedure Cancel; override;
    procedure Accept; override;

    procedure ModifyTextRect; override;
    function RedrawOnExit: Boolean; override;
    function RedrawOnEnter: Boolean; override;
    // ---
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;override;
    procedure DrawEditText(from : Integer); overload; override;
    //procedure DrawEditText(from : Integer; const aTxt: TLMDString); overload; override;
    procedure DoDownKey; override;
    procedure DoUpKey; override;
    function GetControl : TWinControl; override;
    procedure Loaded; override;

    procedure TriggerLinkClickEvent(Sender : TObject; HRef : TLMDString); virtual;
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; Image : TPicture); virtual;
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString); virtual;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    function GetTextFromItem(Index : integer): TLMDString;
    procedure Init;override;
    // 7.11
    procedure Clear; override;
    // ----
    property ListBox:TLMDHTMLExtListBox read GetListBox;
    property Value:string read GetValue write SetSValue;
  published
    property ItemIndex : Integer read GetItemIndex write SetItemIndex;
    property Items : TStrings read GetItems write SetItems;
    property DropDownWidth;
    property DropDownCount  : Integer read FDropDownCount write FDropDownCount default 8;
    property ReadOnly;
    property Style;
    property OnMeasureItem:TMeasureItemEvent read GetMeasureItemEvent write SetMeasureItemEvent;
    property OnDrawItem:TDrawItemEvent read GetOnDrawItem write SetOnDrawItem;

    property OnLinkClick : TLMDHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TLMDHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
    property IsHTML: Boolean read FIsHTML write SetIsHTML default true;
    property LinkColor: TColor read FLinkColor write SetLinkColor default def_LMDLinkColor;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default def_LMDLinkStyle;
  end;

  TLMDLabeledHTMLComboBox = class(TLMDHTMLComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

  // ---------------------------------------------------------------------------
  // IMPORTANT: For CLR compatibility TLMDHTMLExtListBoxH HAS to reside in interface
  //            section
  // ---------------------------------------------------------------------------
  TLMDHTMLExtListBoxH = class (TLMDHTMLExtListBox)
  private
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
  protected
  public
    constructor Create(AOwner: TComponent);override;
  end;

implementation

uses
  Types, Forms, SysUtils, LMDClass, LMDButtonBase,
  LMDGraph, LMDCustomMaskEdit;


{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBoxH.WMMouseMove(var Message: TWMMouseMove);
var
  LR: TRect;
begin
  inherited;
  if not PtInRect (LR, Point(Message.XPos, Message.YPos)) then
    ReleaseCapture
  else
    if GetCapture<>Handle then
      SetCapture(Handle);
  ItemIndex := ItemAtPos (Point(Message.XPos, Message.YPos), true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBoxH.CMMouseEnter (var Message: TMessage);
begin
  inherited;
  if GetCapture<>Handle then
    SetCapture(Handle);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBoxH.WMLButtonDown(var Message: TWMLButtonDown);
var
  LR: TRect;
begin
  LR := ClientRect;
  inherited;
  if PtInRect (LR, Point(Message.XPos, Message.YPos)) then
  begin
    ItemIndex := ItemAtPos (Point(Message.XPos, Message.YPos), true);
    (Parent as TLMDHTMLComboBox).Close(true);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBoxH.WMMouseActivate(var Message: TMessage);
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDHTMLExtListBoxH.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible];
end;

{ ---------------------------------- private --------------------------------- }
function TLMDHTMLComboBox.GetListBox : TLMDHTMLExtListBox;
begin
  result:=TLMDHTMLExtListBox(FControl);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLComboBox.GetValue: String;
begin
  result:=AsString;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.SetItems (aValue : TStrings);
begin
  (FControl as TLMDHTMLExtListBox).Items.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.SetLinkColor(const Value: TColor);
begin
  FLinkColor := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.SetLinkPopupMenu(const Value: TPopupMenu);
begin
  if (FLinkPopupMenu <> Value) then
  begin
    if FLinkPopupMenu <> nil then
      if not (csDestroying in FLinkPopupMenu.ComponentState) then
        FLinkPopupMenu.RemoveFreeNotification(Self);
    FLinkPopupMenu := Value;
    if (Value <> nil) then
      Value.FreeNotification(Self);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.SetLinkStyle(const Value: TFontStyles);
begin
  FLinkStyle := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.SetSValue(const Value: String);
begin
  inherited Text:=Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; Image : TPicture);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src , Image );
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.TriggerLinkClickEvent(Sender: TObject;
  HRef: TLMDString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.WMKEYUP(var Msg: TWMKeyUp);
begin
  if DroppedDown then
    case Msg.CharCode of
      VK_DOWN   : DoDownKey;
      VK_UP     : DoUpKey;
    end
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLComboBox.GetItemIndex: Integer;
begin
  Result := FItemIndex;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.SetIsHTML(const Value: Boolean);
begin
  FIsHTML := Value;
end;

procedure TLMDHTMLComboBox.SetItemIndex(const Value: Integer);
begin
  if (Value >= -1) and (Value < Items.Count) then
  begin
    FItemIndex := Value;
    if Assigned(Control) then
      (FControl as TLMDHTMLExtListBoxH).ItemIndex := Value;
    Accept;
  end;  
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLComboBox.GetItems : TStrings;
begin
  result := (FControl as TLMDHTMLExtListBox).Items;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.CreateControl;
begin
  FControl := TLMDHTMLExtListBoxH.Create(self);
  TLMDHTMLExtListBoxH(FControl).Multiline := true;
  TLMDHTMLExtListBoxH(FControl).ItemAutoHeight := true;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLComboBox.GetControl : TWinControl;
begin
  result := TLMDHTMLExtListBoxH(FControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.DoDownKey;
begin
  if (FControl as TLMDHTMLExtListBox).ItemIndex < (FControl as TLMDHTMLExtListBox).Items.Count-1 then
    begin
      (FControl as TLMDHTMLExtListBox).ItemIndex := (FControl as TLMDHTMLExtListBox).ItemIndex + 1;
      if not DroppedDown then
        Accept;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.DoUpKey;
begin
  if (FControl as TLMDHTMLExtListBox).ItemIndex > 0 then
    begin
      (FControl as TLMDHTMLExtListBox).ItemIndex := (FControl as TLMDHTMLExtListBox).ItemIndex - 1;
      if not DroppedDown then
        Accept;
    end;
end;

procedure TLMDHTMLComboBox.DrawEditText(from: Integer);
var
  R: TRect;
begin
  R := FTextRect;
  if IsHTML then
  begin
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.DefaultColor := GetThemedTextColor;
    FRender.PrepareText(Text, R.Right - R.Left, True);
    FRender.DrawText(Canvas, Point(0,0), R, FRender.Data.DefaultBgColor);
  end
  else
    inherited DrawEditText(from);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLComboBox.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
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
procedure TLMDHTMLComboBox.DoThemeChanged;
begin
  inherited;
  if Assigned(FControl){ and Visible} then
  begin
    if FControl.ParentWindow <> Handle then
      Windows.SetParent(FControl.Handle, Handle);
    (FControl as TLMDHTMLExtListBoxH).ThemeMode := self.ThemeMode;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.ModifyControl;
begin
//
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.ReModifyControl;
var
  h : Integer;
begin
  h := DropDownCount;
  if Items.Count < DropDownCount then
    h := Items.Count + 1;
  h := h * (FControl as TLMDHTMLExtListBox).ItemHeight;
  FControl.Height := h;
  if (DropDownWidth>0) and (Items.Count>0) then
    FControl.Width := DropDownWidth
  else
    FControl.Width := Width;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.DisplayControl;
begin
  SelectAll;
  (FControl as TLMDHTMLExtListBoxH).ItemIndex := Items.IndexOf (Text);
  SetCaptureControl(FControl as TLMDHTMLExtListBoxH);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.BeforeDropDown;
begin
  FOld := Text;
  TLMDHTMLExtListBoxH(FControl).OnDrawItem := OnDrawItem;
  TLMDHTMLExtListBoxH(FControl).OnMeasureItem := OnMeasureItem;
  TLMDHTMLExtListBoxH(FControl).OnLinkClick := OnLinkClick;
  TLMDHTMLExtListBoxH(FControl).OnImageNeeded := OnImageNeeded;
  TLMDHTMLExtListBoxH(FControl).OnVariableNeeded := OnVariableNeeded;
  TLMDHTMLExtListBoxH(FControl).LinkPopupMenu := FLinkPopupMenu;
  TLMDHTMLExtListBoxH(FControl).IsHTML := FIsHTML;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.Cancel;
begin
  Text := FOld;
  ReleaseCapture;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.Accept;
var
  s: String;
begin
  ReleaseCapture;
  if (FControl as TLMDHTMLExtListBoxH).ItemIndex > -1 then
  begin
    s := (FControl as TLMDHTMLExtListBoxH).Items[(FControl as TLMDHTMLExtListBoxH).ItemIndex];
    inherited;
    Text := s;
    Repaint;
  end
  else
  begin
    Text := '';
    CheckModified;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Check: Boolean;
begin
  Check := DroppedDown;
  inherited MouseDown (Button, Shift, X, Y);
  if (not Check) and (Style = csDropDownList) then DoDropDownClick (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.ModifyTextRect;
begin
  inherited;
  if Style = csDropDownList then InflateRect (FTextRect, -1, -1);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLComboBox.RedrawOnExit: Boolean;
begin
  result := (inherited RedrawOnExit) or (Style = csDropDownList);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLComboBox.RedrawOnEnter: Boolean;
begin
  result := (inherited RedrawOnEnter) or (Style = csDropDownList);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.Loaded;
begin
  inherited Loaded;
  if (FItemIndex > -1) and (FItemIndex < Items.Count) then
    Text := Items[FItemIndex];
  Init;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDHTMLComboBox.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);

  FDropDownCount := 8;

  FOnDrawItem := nil;
  FOnMeasureItem := nil;

  CreateAndSetup;

  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeededEx := TriggerImageNeededEvent;
  FRender.OnVariableNeeded := TriggerVariableNeededEvent;
  FRender.Control := Self;

  FIsHTML := true;
  FLinkColor := def_LMDLinkColor;
  FLinkStyle := def_LMDLinkStyle;

  if (csDesigning in ComponentState) then FControl.Width := 0;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDHTMLComboBox.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.Clear;
begin
  (FControl as TLMDHTMLExtListBoxH).ItemIndex:=-1;
  (FControl as TLMDHTMLExtListBoxH).Clear;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.Init;
begin
  MaskType := meNone;
  if UseThemeMode = ttmNative then
  begin
    CustomButtonsStyle := ubsWin40Ext; //some workaround for getting button
    CustomButtonsStyle := ubsCombo;    //initialized
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLComboBox.GetMeasureItemEvent: TMeasureItemEvent;
begin
  result := FOnMeasureItem;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLComboBox.GetOnDrawItem: TDrawItemEvent;
begin
  result := FOnDrawItem;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.SetMeasureItemEvent(
  const Value: TMeasureItemEvent);
begin
  FOnMeasureItem := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLComboBox.SetOnDrawItem(const Value: TDrawItemEvent);
begin
  FOnDrawItem := value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLComboBox.GetTextFromItem(Index : integer): TLMDString;
begin
  if IsHTML then
  begin
    FRender.PrepareText(Items[Index], 0, false);
    Result := FRender.AsText;
  end
  else
    Result := Items[Index];
end;

{ ********************** TLMDLabeledComboBoxExt ************************}
{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledHTMLComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;


initialization
  Classes.RegisterClass (TLMDHTMLExtListBoxH);
end.
