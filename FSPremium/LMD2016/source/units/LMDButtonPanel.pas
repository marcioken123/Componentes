unit LMDButtonPanel;
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

LMDButtonPanel unit (JH)
------------------------

db navigator like button panel

TLMDButtonPanel is a panel on which you can place as many buttons as you like. 
You can setup every button's surface through the Buttons collection property. 
The button style has to be set for all buttons equal - through ButtonStyle property. 
If you assign an event handler to the OnBtnClick event the OnClick events from the 
TLMDSpecialButton collection items will be ignored!!

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDClass, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel,
  LMDCustomPanelFill, LMDSBtn, LMDGraph, LMDButtonBase;

type
  TLMDBtnClickEvent = procedure (Sender : TObject; SendBtn : TObject; Btn : Integer) of object;

  TLMDButtonPanel = class(TLMDCustomPanelFill)
  private
    FBtnStyle  : TLMDUserButtonStyle;
    FCustomXP: Boolean;
    procedure SetCustomButtonXP(const Value: Boolean);
    procedure SetButtons (aValue : TLMDSpecialButtons);
    procedure SetBtnStyle (aValue : TLMDUserButtonStyle);
    procedure SetBtnSize (index : Integer; aValue : Integer);
    function GetBtnSize (index : Integer) : Integer;
    procedure WMSize (var Msg : TWMSize); message WM_SIZE;
  protected
    FBtnSize   : TPoint;
    FButtons   : TLMDSpecialButtons;
    FOnBtnClick: TLMDBtnClickEvent;
    FSetBorders: Boolean;
    procedure Loaded; override;
    procedure DoThemeChanged;override;
    procedure InitBtnStyle;
    function GetEmpty : Boolean; override;
    procedure GetBtnsChange(Sender:TObject);
    procedure GetChange (Sender : TObject); override;
    procedure DoBtnClick (Sender : TObject);
    procedure SetCustomButtonsXPMode(const Value : TLMDThemeMode);
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure CreateButtons; virtual;
    //use this function to add btns during runtime
    //if you use Buttons.Add you have to call SetBorders manually!
    procedure SetBorders; virtual;
    function AddButton : Integer; virtual;
    procedure InsertButton (index : Integer);
    property CtlXP;  // compatibility
    property DockManager;
  published
    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property UseDockManager default false;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBackground default false;
    property ParentColor;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    property About;
    property Buttons : TLMDSpecialButtons read FButtons write SetButtons;
    property ButtonHeight : Integer index 0 read GetBtnSize write SetBtnSize default 20;
    property ButtonWidth : Integer index 1 read GetBtnSize write SetBtnSize default 20;
    property ButtonStyle : TLMDUserButtonStyle read FBtnStyle write SetBtnStyle default ubsWin40;
    property ButtonParentCtlXP:Boolean read FCustomXP write SetCustomButtonXP default true;
    property Color;
    property Align;
    property BackFX;
    property Bevel;
    property DragMode;
    property DragCursor;
    property Enabled;
    property FillObject;
    property Flat;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property Visible;
    property PopupMenu;
    property TabStop;
    property TabOrder;
    property Transparent;
    property ShowHint;
    property ThemeMode; // 9.0
    property ThemeGlobalMode;
    property ParentShowHint;
    //events
    property OnButtonClick : TLMDBtnClickEvent read FOnBtnClick write FOnBtnClick;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnResize;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnMouseEnter;
    property OnMouseExit;
    property OnKeyDown;
    property OnKeyUp;
    property OnStartDrag;
    property OnMouseWheel;
  end;

implementation

uses
  Types, Variants,
  LMDCustomSpeedButton;

{ ------------------------- private ------------------------------------------ }
procedure TLMDButtonPanel.SetButtons (aValue : TLMDSpecialButtons);
begin
  FButtons.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.SetCustomButtonXP(const Value: Boolean);
begin
  if Value<>FCustomXP then
    begin
      FCustomXP:=Value;
      if FCustomXP then
        SetCustomButtonsXPMode(FThemeMode);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.SetBtnStyle (aValue : TLMDUserButtonStyle);
begin
  if aValue <> FBtnStyle then
    begin
      FBtnStyle := aValue;
      InitBtnStyle;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.SetBtnSize (index : Integer; aValue : Integer);
begin
  case index of
    0 : if aValue <> FBtnSize.Y then
          begin
            FBtnSize.Y := aValue;
            GetChange(nil);
          end;
    1 : if aValue <> FBtnSize.X then
          begin
            FBtnSize.X := aValue;
            GetChange (nil);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonPanel.GetBtnSize (index : Integer) : Integer;
begin
  result := 0;
  case index of
    0 : result := FBtnSize.Y;
    1 : result := FBtnSize.X;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.WMSize (var Msg : TWMSize);
begin
  inherited;
  if [csDestroying, csLoading]*ComponentState<>[] then exit;
  SetBorders;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.InitBtnStyle;
var
  i : Integer;
begin
  for i := 0 to FButtons.Count - 1 do
    begin
      FButtons[i].Btn.Style := FBtnStyle;
      if ButtonParentCtlXP then
        FButtons[i].Btn.ThemeMode := self.FThemeMode;
      FButtons[i].Btn.HideHint:=False;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.SetCustomButtonsXPMode(const Value : TLMDThemeMode);
var
  i:Integer;
begin
  for i:=0 to FButtons.Count-1 do
    if Assigned(FButtons.Items[i].Btn) then
       begin
         FButtons.Items[i].Btn.BeginUpdate;
         try
           FButtons.Items[i].Btn.ThemeMode:=Value;
         finally
           FButtons.Items[i].Btn.EndUpdate(Showing);
         end;
       end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonPanel.GetEmpty : Boolean;
begin
  result := (FButtons.Count = 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.GetChange (Sender : TObject);
begin
  inherited GetChange (Sender);
  SetBorders;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.GetBtnsChange(Sender: TObject);
begin
  if (ComponentState*[csLoading, csReading, csDestroying]<>[]) then exit;
  if FCustomXP then
    SetCustomButtonsXPMode(FThemeMode);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.DoBtnClick (Sender : TObject);
begin
  if Assigned (FOnBtnClick) then
    FOnBtnClick (self, Sender, TLMDCustomSpeedButton(Sender).Tag);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.DoThemeChanged;
begin
  inherited;
  if FCustomXP then
    SetCustomButtonsXPMode(FThemeMode);
end;

{ -------------------------- public ------------------------------------------ }
procedure TLMDButtonPanel.SetBorders;
var
  col,
  row,
  c,
  i : Integer;
  aRect : TRect;
begin
  if FSetBorders then exit;
  if [csReading, csLoading]*ComponentState<>[] then exit;
  FSetBorders := true;
  try
    //get the client rect
    aRect := ClientRect;
    if Bevel.Mode <> bmWindows then
      InflateRect (aRect, -Bevel.BevelExtend, -Bevel.BevelExtend);
    //count visible buttons
    c := 0;
    for i := 0 to FButtons.Count - 1 do
      if (FButtons[i].Btn <> nil) and FButtons[i].Btn.Visible then
        inc(c);

    //estimate buttons per column and row
    col := (aRect.Right - aRect.Left) div FBtnSize.X;
    if col > c then col := c; //all btns will be in one row
    if col = 0 then col := 1;
    if col < c then //if not all btns in one row calculate row count
      begin
        row := (aRect.Bottom - aRect.Top) div FBtnSize.Y;
        if (col = 1) and (row > c) then
          row := c;
        if (row = 0) or (col >= c) then row := 1;
        while col * row > c do dec (row);
        while col * row < c do inc(row);
      end
    else
      row := 1;
    SetBounds (Left, Top, col * FBtnSize.X + Bevel.BevelExtend * 2, row * FBtnSize.Y + Bevel.BevelExtend * 2+1);
    c := 0;
    for i := 0 to FButtons.Count - 1 do
      begin
        //this can occur if a btn is added during design time
        //shortly after the inherited constructor of a special btn is executed this
        //code will be executed -> btn is nil!
        if FButtons[i].Btn = nil then break;
        if not FButtons[i].Btn.Visible then
          continue;

        FButtons[i].Btn.SetBounds (aRect.Left + (c mod col) * FBtnSize.X, aRect.Top + ((c div col) mod row) * FBtnSize.Y,
                                   FBtnSize.X, FBtnSize.Y);
        if Assigned (FOnBtnClick) then
          FButtons[i].Btn.OnClick := DoBtnClick;
        inc(c);
      end;
  finally
    FSetBorders := false;
  end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDButtonPanel.Create (aOwner : TComponent);
begin
  FBtnSize := Point (20,20);
  inherited Create (aOwner);
  //ControlStyle := ControlStyle + [csOpaque] - [csAcceptsControls, csSetCaption, csReplicatable, csParentBackground];
  ControlStyle := ControlStyle + [csOpaque] - [csAcceptsControls, csSetCaption, csReplicatable{$IFDEF LMDCOMP7}, csParentBackground{$ENDIF}];
  FBtnStyle := ubsWin40;
  FCustomXP:=True;
  {$IFNDEF LMDCOMP7}
  ParentBackground := false;
  {$ENDIF}
  CreateButtons;
  FButtons.OnChange:=GetBtnsChange;
  FSetBorders:=false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDButtonPanel.Destroy;
begin
  FButtons.OnChange:=nil;
  FreeAndNil(FButtons);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.Loaded;
begin
  inherited Loaded;
  if FCustomXP then
    SetCustomButtonsXPMode(FThemeMode);
  SetBorders;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonPanel.AddButton : Integer;
begin
  FButtons.OnChange:=nil;
  try
    result := FButtons.Add.Index;
    GetBtnsChange(nil);
    SetBorders;
  finally
    FButtons.OnChange:=GetBtnsChange;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonPanel.InsertButton (index : Integer);
begin
  FButtons.OnChange:=nil;
  try
    FButtons.Insert (index);
    GetBtnsChange(nil);
    SetBorders;
  finally
    FButtons.OnChange:=GetBtnsChange;
  end;
end;

procedure TLMDButtonPanel.CreateButtons;
begin
  FButtons := TLMDSpecialButtons.Create (self, true);  
end;

end.
