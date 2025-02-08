unit LMDCustomListComboBox;
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

LMDCustomListComboBox unit (JH)
-------------------------------

Combobox with a drop down list, combo box is a base edit descendant (effects)

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Controls,
  StdCtrls,
  Windows,
  Graphics,
  Messages,
  LMDCustomExtCombo;

type
  TLMDCustomListComboBox = class(TLMDCustomExtCombo)
  private
    FOld           : String;
    FDropDownCount : Integer;
    FSorted        : Boolean;
    FOnSelected    : TNotifyEvent;

    procedure SetItems(aValue: TStrings);
    procedure SetSorted(aValue: Boolean);
    function  GetItems: TStrings;
    function  GetListBox: TListBox;
    procedure SetItemIndex(aValue: Integer);
    function  GetItemIndex: Integer;
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
  protected
    procedure CreateControl; override;
    procedure ModifyControl; override;
    procedure ReModifyControl; override;
    procedure DisplayControl; override;
    procedure BeforeDropDown; override;
    procedure Cancel; override;
    function  NoneSelected: Boolean; //added April 02, JH
    function  GetSelectedText: String; //added April 02, JH
    procedure Accept; override;
    function  GetControl : TWinControl; override;
    procedure DoDownKey; override;
    procedure DoUpKey; override;
    //JH March 2002
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    function  DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
                           MousePos: TPoint): Boolean;override;
    procedure ModifyTextRect; override;
    function  RedrawOnExit: Boolean; override;
    function  RedrawOnEnter: Boolean; override;

    property Sorted: Boolean read FSorted write SetSorted default false;
    property Items: TStrings read GetItems write SetItems;
    property DropDownCount: Integer read FDropDownCount write FDropDownCount default 8;
    property OnSelected: TNotifyEvent read FOnSelected write FOnSelected;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear; override;
    procedure Init; override;
    procedure SelectItem(const anItem: String);
    property  ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property  ListBox: TListBox read GetListBox;
  end;

implementation

uses
  Types, Dialogs, Forms, SysUtils, {$IFDEF LMDCOMP16}VCL.Themes,{$ENDIF}
  LMDGraph, LMDCustomMaskEdit;

type
  TListBoxHack = class(TListBox)
  private
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

procedure TListBoxHack.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
//    Style := WS_POPUP or WS_BORDER;
//    ExStyle := WS_EX_TOOLWINDOW;
//    AddBiDiModeExStyle(ExStyle);
//    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TListBoxHack.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  ItemIndex := ItemAtPos(Point(Message.XPos, Message.YPos), True);
end;

procedure TListBoxHack.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  ItemIndex := ItemAtPos (Point(Message.XPos, Message.YPos), true);
  {$IFDEF LMDCOMP16}
  // workaround for remaining scrollbar after dropdown list is closed
  // when custom style is active (XE2) - VB May 2012.
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    RecreateWnd;
  {$ENDIF}
  (Parent as TLMDCustomListComboBox).Close(True);
end;

{ ---------------------------------- private --------------------------------- }
function TLMDCustomListComboBox.GetListBox : TListBox;
begin
  result:=TListBox(FControl);
end;

function TLMDCustomListComboBox.GetItemIndex: Integer;
begin
  result := FItemIndex;

end;
{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.SetItems (aValue : TStrings);
begin
  (FControl as TListBox).Items.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomListComboBox.GetItems : TStrings;
begin
  result := (FControl as TListBox).Items;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.SetSorted (aValue: Boolean);
begin
  FSorted := aValue;
  if Assigned (FControl) then (FControl as TListBox).Sorted := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.SetItemIndex (aValue: Integer);
begin
  if (aValue >= -1) and (aValue < Items.Count) then
  begin
    FItemIndex := aValue;
    if Assigned(FControl) then
      (FControl as TListBox).ItemIndex := aValue;
    Accept;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.CMRecreateWnd(var Message: TMessage);
var
  s: TStringList;
begin
  s := nil;
  if FControl <> nil then
    if ListBox.Items.Count > 0 then
    begin
      s := TStringList.Create;
      s.Assign(ListBox.Items);
    end;
  inherited;
  if s <> nil then
  begin
    ListBox.Items.Assign(s);
    s.Clear;
    FreeAndNil(s);
  end;
end;

{ ---------------------------------- protected ------------------------------- }
procedure TLMDCustomListComboBox.CreateControl;
begin
  FControl := TListBoxHack.Create(self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomListComboBox.GetControl : TWinControl;
begin
  Result := TListBoxHack(FControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.DoDownKey;
begin
  if (FControl as TListBox).ItemIndex < (FControl as TListBox).Items.Count-1 then
  begin
    (FControl as TListBox).ItemIndex := (FControl as TListBox).ItemIndex + 1;
    if not DroppedDown then
      Accept;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.DoUpKey;
begin
  if (FControl as TListBox).ItemIndex > 0 then
  begin
    (FControl as TListBox).ItemIndex := (FControl as TListBox).ItemIndex - 1;
    if not DroppedDown then
      Accept;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomListComboBox.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheel (Shift, WheelDelta, MousePos);
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
procedure TLMDCustomListComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Check: Boolean;
begin
  Check := DroppedDown;
  inherited MouseDown (Button, Shift, X, Y);
  if (not Check) and (Style = csDropDownList) then DoDropDownClick (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.ModifyTextRect;
begin
  inherited;
  if Style = csDropDownList then InflateRect (FTextRect, -1, -1);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomListComboBox.RedrawOnExit: Boolean;
begin
  result := (inherited RedrawOnExit) or (Style = csDropDownList);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomListComboBox.RedrawOnEnter: Boolean;
begin
  result := (inherited RedrawOnEnter) or (Style = csDropDownList);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.ModifyControl;
begin
  with (FControl as TListBox) do
    Sorted := FSorted;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.ReModifyControl;
var
  h : Integer;
begin
  h := DropDownCount;
  if Items.Count < DropDownCount then
    h := Items.Count;

  h := h * Canvas.TextHeight ('Wq');
  inc (h, 4); // include listbox borders, JH March 2002
  //while h + Top + Height > Screen.Height do dec (h); // no longer required
  FControl.Height := h;

  if (DropDownWidth>0) and (Items.Count>0) then
    FControl.Width := DropDownWidth
  else
    FControl.Width := Width;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.DisplayControl;
begin
  SelectAll;
  (FControl as TListBoxHack).ItemIndex := Items.IndexOf(Text);
//  FControl.SetFocus;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.BeforeDropDown;
begin
  FOld := Text;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.Cancel;
begin
  Text := FOld;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomListComboBox.NoneSelected: Boolean;
begin
  result := (FControl as TListBoxHack).ItemIndex = -1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomListComboBox.GetSelectedText: String;
begin
  result := '';
  if NoneSelected then exit;
  result := (FControl as TListBoxHack).Items[(FControl as TListBoxHack).ItemIndex]
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.Accept;
begin
  FItemIndex := (FControl as TListBoxHack).ItemIndex;
  Text := GetSelectedText;
  if Assigned (FOnSelected) then FOnSelected(self);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.Loaded;
begin
  inherited Loaded;
  if (FItemIndex > -1) and (FItemIndex < Items.Count) then
    Text := Items[FItemIndex];
  Init;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDCustomListComboBox.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FDropDownCount := 8;
  FSorted := false;
  FItemIndex := -1;
  CreateAndSetup;
  if (csDesigning in ComponentState) then
    FControl.Width := 0;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomListComboBox.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.Clear;
begin
  (FControl as TListBoxHack).Clear;
  FItemIndex := -1;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.Init;
begin
  MaskType := meNone;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListComboBox.SelectItem (const anItem: String);
begin
  (FControl as TListBoxHack).ItemIndex := Items.IndexOf (anItem);
  Accept;
end;

end.
