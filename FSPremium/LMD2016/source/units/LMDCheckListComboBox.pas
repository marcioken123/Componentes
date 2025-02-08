unit LMDCheckListComboBox;
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

LMDCheckListComboBox unit (JH)
------------------------------

Special combo box which allows selection of multiple items

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Messages, StdCtrls,
  LMDBase, LMDButtonListData, LMDCheckListBox, LMDCustomExtCombo;

type
  TLMDCheckListComboBox = class (TLMDCustomExtCombo)
  private
    FOld : String;
    FDropDownCount : Integer;
    FBtnDefault: Boolean;
    FBtnMode: TLMDButtonListMode;
    procedure SetBtnDefault(const aValue: Boolean);
    procedure SetBtnMode(const aValue: TLMDButtonListMode);
    procedure SetItems (aValue : TStrings);
    procedure SetChecked (index: Integer; aValue: Boolean);
    procedure SetEnabled (index: Integer; aValue: Boolean); reintroduce;
    procedure SetState(Index: Integer; const aValue: TCheckBoxState);
    procedure SetSValue(const Value: string);
    function GetCheckListBox:TLMDCheckListBox;
    function GetChecked (index: Integer): Boolean;
    function GetEnabled (index: Integer): Boolean; reintroduce;
    function GetState(Index: Integer): TCheckBoxState;
    function GetItems : TStrings;
    function GetValue: string;
    procedure DoClickCheck (Sender : TObject);
  protected
    procedure CreateWnd;override;
    procedure DoThemeChanged; override;
    procedure CreateControl; override;
    procedure ModifyControl; override;
    procedure ReModifyControl; override;
    procedure DisplayControl; override;
    procedure BeforeDropDown; override;
    procedure Cancel; override;
    procedure Accept; override;
    function GetControl : TWinControl; override;
    procedure Loaded; override;
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    // 7.11
    procedure Clear; override;
    // ----
    procedure Init; override;
    procedure CheckAll(UnCheck:Boolean=false);
    property Checked[index: Integer]: Boolean read GetChecked write SetChecked;
    // 7.0
    property ItemEnabled[index:Integer]:Boolean read GetEnabled write SetEnabled;
    // 8.0
    property State[Index: Integer]: TCheckBoxState read GetState write SetState;
    property CheckListBox:TLMDCheckListBox read GetCheckListBox;
    property Value:string read GetValue write SetSValue;
  published
    property Items : TStrings read GetItems write SetItems;
    property CheckBtnDefault:Boolean read FBtnDefault write SetBtnDefault default true;
    property CheckBtnMode:TLMDButtonListMode read FBtnMode write SetBtnMode default blCheckBox;
    property DropDownWidth;
    property DropDownCount : Integer read FDropDownCount write FDropDownCount default 8;
    property ReadOnly;

  end;

  TLMDLabeledCheckListComboBox = class(TLMDCheckListComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  Types, Windows, Dialogs, Forms, Graphics, SysUtils,
  LMDProcs, LMDGraph, LMDCustomImageListBox, LMDCustomMaskEdit;

type
  TListBoxHack = class (TLMDCheckListBox)
  private
    FResult:Int64;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMDestroy(var Msg:TWMDestroy);message WM_DESTROY;
  public
    constructor Create(AOwner: TComponent); override;
  end;

    procedure TListBoxHack.WMMouseMove(var Message: TWMMouseMove);
    begin
      inherited;
      ItemIndex := ItemAtPos (Point(Message.XPos, Message.YPos), true);
    end;

    procedure TListBoxHack.WMLButtonDown(var Message: TWMLButtonDown);
    begin
      inherited;
      //ItemIndex := ItemAtPos (Point(Message.XPos, Message.YPos), true);
    end;

    procedure TListBoxHack.WMRButtonDown(var Message: TWMRButtonDown);
    begin
      inherited;
      (Parent as TLMDCheckListComboBox).Close(true);
      //ItemIndex := ItemAtPos (Point(Message.XPos, Message.YPos), true);
    end;

    procedure TListBoxHack.WMDestroy(var Msg: TWMDestroy);
    begin
      // This is really a hack :-(
      // if placed on Header/FormDisplay and no valid handle, WMDestroy will be
      // called at a very early stage. Thus we remember last value here.
      if not (csDestroying in ComponentState) then
        FResult:=Value;
      inherited;
    end;

    constructor TListBoxHack.Create(AOwner: TComponent);
    begin
      FResult:=-1;
      inherited Create(AOwner);
      Options:=[lboCalcHeight];
    end;

{ ********************* TLMDCheckListComboBox *********************************}
{----------------------- private ----------------------------------------------}
procedure TLMDCheckListComboBox.SetChecked (index: Integer; aValue: Boolean);
begin
  GetCheckListBox.Checked[index] := aValue;
  Accept;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.SetEnabled (index: Integer; aValue: Boolean);
begin
  GetCheckListBox.ItemEnabled[index]:=aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.SetState(Index: Integer; const aValue: TCheckBoxState);
begin
 GetCheckListBox.State[index] := aValue;
 Accept;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.SetItems (aValue : TStrings);
begin
  (FControl as TLMDCheckListBox).Items.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.SetSValue(const Value: string);
begin
 inherited Text:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCheckListComboBox.SetBtnDefault(const aValue: Boolean);
begin
  if FBtnDefault <> aValue then
    begin
      FBtnDefault := aValue;
      if Assigned(FControl) then
        CheckListBox.BtnDefault:=FBtnDefault;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCheckListComboBox.SetBtnMode(const aValue: TLMDButtonListMode);
begin
  if FBtnMode <> aValue then
    begin
      FBtnMode := aValue;
      if Assigned(FControl) then
        CheckListBox.BtnMode:=FBtnMode;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCheckListComboBox.GetValue: string;
begin
 result:=AsString;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCheckListComboBox.GetCheckListBox:TLMDCheckListBox;
begin
  result:=TLMDCheckListBox(FControl);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCheckListComboBox.GetChecked (index: Integer): Boolean;
var
  tmp:Int64;
begin
  // bad hack
  if (not FControl.HandleAllocated) and ((FControl as TListBoxHack).FResult>-1) then
    begin
      tmp:=LMDExp(2, index);
      result:=(tmp and (FControl as TListBoxHack).FResult = tmp);
      exit;
    end;
  result := GetCheckListBox.Checked[index];
end;

{ ---------------------------------------------------------------------------- }
function TLMDCheckListComboBox.GetState(Index: Integer): TCheckBoxState;
begin
  result := GetCheckListBox.State[index];
end;

{ ---------------------------------------------------------------------------- }
function TLMDCheckListComboBox.GetEnabled (index: Integer): Boolean;
begin
  result:=GetCheckListBox.ItemEnabled[index];
end;

{ ---------------------------------------------------------------------------- }
function TLMDCheckListComboBox.GetItems : TStrings;
begin
  result := (FControl as TLMDCheckListBox).Items;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.DoClickCheck (Sender : TObject);
begin
  Accept;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.CreateControl;
begin
  FControl := TListBoxHack.Create (self);
  (FControl as TListBoxHack).OnClickCheck := DoClickCheck;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCheckListComboBox.GetControl : TWinControl;
begin
  result := TListBoxHack(FControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.ModifyControl;
begin
  with (FControl as TLMDCheckListBox) do
    begin
      BtnDefault:=self.FBtnDefault;
      BtnMode:=self.FBtnMode;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.ReModifyControl;
var
  i,
  r,
  h : Integer;
  b : TRect;
begin
  h := DropDownCount;
  if Items.Count < DropDownCount then
    h := Items.Count;

  r := 4-(Ord(CtlXP)*2);  // workaround for non CtlXP checkboxes

  for i := 0 to h - 1 do
    begin
      b := (FControl as TLMDCheckListBox).ItemRect(i);
      r := r + b.Bottom - b.Top;
    end;
  //h := h * Canvas.TextHeight ('Wq');
  while r + Top + Height > Screen.Height do dec (r);
  FControl.Height := r;

  if (DropDownWidth>0) and (Items.Count>0) then
    FControl.Width := DropDownWidth
  else
    FControl.Width := Width;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.DisplayControl;
begin
  SelectAll;
  (FControl as TListBoxHack).ItemIndex := Items.IndexOf (Text);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.BeforeDropDown;
begin
  FOld := Text;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.Cancel;
begin
  //Text := FOld;
  Accept;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.Accept;
const
  FDelim = ',';
var
  i : Integer;
  s : String;
begin
  //if (FControl as TListBoxHack).ItemIndex = -1 then exit;
  for i := 0 to Items.Count - 1 do
    if (FControl as TListBoxHack).State[i]>TCheckBoxState(0) then
      begin
        if s <> '' then s := s + FDelim+' ';
        s := s + Items[i];
      end;
  Text := s;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.CreateWnd;
begin
  //if csDestroying in ComponentState then exit;
  inherited CreateWnd;
  //(FControl as TListBoxHack).CreateWnd;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.DoThemeChanged;
begin
  inherited;
  If Assigned(FControl) and Visible then
    (FControl as TLMDCheckListBox).ThemeMode := self.ThemeMode;
end;

{ ---------------------------------------------------------------------------- }
(*
procedure TLMDCheckListComboBox.ReCreateWnd;
var
  i:Integer;
begin
  inherited CreateWnd;
  //i:=(FControl as TListBoxHack).Items.Count;
end;*)

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.CMRecreateWnd(var Message: TMessage);
var
  s: TStringList;
begin
  s := nil;
  if FControl <> nil then
    if Items.Count > 0 then
      begin
        s := TStringList.Create;
        s.Assign(Items);
      end;
  inherited;
  if s<> nil then
    begin
      Items.Assign(s);
      s.clear;
      s.free;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.Loaded;
begin
  inherited Loaded;
  Init;
  MaskType := meNone;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.Init;
begin
  MaskType := meNone;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDCheckListComboBox.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FDropDownCount := 8;
  FBtnMode := blCheckBox;
  FBtnDefault := true;
  //self.ReadOnly := true;
  EnableKeyInput := false; //!!!! JH April 02
  DraggingAllowed := false; //!!!! JH April 02
  CreateAndSetup;
  if (csDesigning in ComponentState) then
    FControl.Width := 0;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCheckListComboBox.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.Clear;
begin
  (FControl as TListBoxHack).Clear;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckListComboBox.CheckAll(UnCheck:Boolean=false);
begin
  (FControl as TListBoxHack).CheckAll(UnCheck);
  Accept;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledCheckListComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
