unit LMDCustomToolBar;
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

LMDCustomToolBar unit (VB)
--------------------------

Changes
-------
Release 2012 (November 2011) - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDClass, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel,
  LMDCustomPanelFill, LMDSBtn, LMDGraph, LMDButtonBase, LMDButtonPanel, LMDFill ,LMDFillObject;

type
  TLMDToolButtonKind = (tbkButton, tbkSeparator);

const
  cDefaultSeparatorWidth = 4;

type
  TLMDToolButton = class(TLMDSpecialButton)
  private
    FSeparator: TLMDFill;
    procedure SetKind(const Value: TLMDToolButtonKind);
    procedure SetHeight(const Value: integer);
    procedure SetWidth(const Value: integer);
    procedure SetMargin(const Value: integer);
    function GetAction: TBasicAction;
    procedure SetAction(const Value: TBasicAction);
    procedure SetUseToolbarBtnSize(const Value: boolean);
    procedure SetUseToolbarMargin(const Value: boolean);
  protected
    FUseToolbarMargin : boolean;
    FUseToolbarBtnSize: boolean;
    FKind: TLMDToolButtonKind;
    FWidth: integer;
    FHeight: integer;
    FMargin: integer;
    procedure CreateButtonControl; override;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Separator: TLMDFill read FSeparator;
    function BtnWidth: integer;
    function BtnHeight: integer;
    function BtnMargin: integer;
  published
    property Action:  TBasicAction read GetAction write SetAction;
    property Kind:  TLMDToolButtonKind read FKind write SetKind default tbkButton;
    property Width:  integer read FWidth write SetWidth default 30;
    property Height: integer read FHeight write SetHeight default 30;
    property Margin: integer read FMargin write SetMargin;
    property UseToolbarMargin  : boolean read FUseToolbarMargin write SetUseToolbarMargin default true;
    property UseToolbarBtnSize : boolean read FUseToolbarBtnSize write SetUseToolbarBtnSize default true;
  end;

  TLMDToolButtons = class(TLMDSpecialButtons)
  protected
  public
    constructor Create(Owner : TWinControl; inform : Boolean); override;
    function GetButtonClass: TCollectionItemClass; override;
  end;


type
  TLMDCustomToolBar = class(TLMDButtonPanel)
  private
    FRowGap: integer;
    FButtonMargin: integer;
    FOrientation: TLMDOrientation;
    FSeparatorFillObject: TLMDFillObject;
    FSeparatorWidth: integer;
    FInitializingBevel: boolean;
    function GetButtons: TLMDToolButtons;
    procedure SetButtons(const Value: TLMDToolButtons);
    function GetButton(index: integer): TLMDToolButton;
    procedure SetRowGap(const Value: integer);
    procedure SetOrientation(const Value: TLMDOrientation);
    procedure SetSeparatorFillObject(const Value: TLMDFillObject);
    procedure SetButtonMargin(const Value: integer);
    procedure SetSeparatorWidth(const Value: integer);
  protected
    procedure SeparatorFillObjectChanged(Sender: TObject);
    procedure GetChange (Sender : TObject); override;
  public
    procedure Assign(Source: TPersistent);override;
    constructor Create(aOwner: TComponent);  override;
    procedure Clear;
    destructor Destroy; override;
    procedure DeleteButton(index: integer);
    procedure CreateButtons; override;
    procedure SetBorders; override;
    function AddToolButton(aSetBorders: boolean = true): TLMDToolButton;
    function AddSeparator(aSetBorders: boolean = true): TLMDToolButton;
    property Button[index: integer]: TLMDToolButton read GetButton;
  published
    property Buttons : TLMDToolButtons read GetButtons write SetButtons;
    property ButtonMargin: integer read FButtonMargin write SetButtonMargin default 1;
    property Orientation: TLMDOrientation read FOrientation write SetOrientation default toHorizontal;
    property RowGap: integer read FRowGap write SetRowGap default 4;
    property SeparatorFillObject: TLMDFillObject read FSeparatorFillObject write SetSeparatorFillObject;
    property SeparatorWidth: integer read FSeparatorWidth write SetSeparatorWidth default cDefaultSeparatorWidth;
  end;

implementation

uses
  Types, Variants,
  LMDCustomSpeedButton;

{------------------------- TLMDCustomToolBar ----------------------------------}
function TLMDCustomToolBar.AddSeparator(aSetBorders: boolean = true): TLMDToolButton;
begin
  result := TLMDToolButton(Buttons.Add);
  result.Kind := tbkSeparator;
  if aSetBorders then
    SetBorders;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomToolBar.AddToolButton(aSetBorders: boolean = true): TLMDToolButton;
begin
  result := TLMDToolButton(Buttons.Add);
  result.Kind := tbkButton;
  if aSetBorders then
    SetBorders;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomToolBar.Assign(Source: TPersistent);
var
  S: TLMDCustomToolBar;
begin
  if Source = self then exit;
  if (Source is TLMDCustomToolBar) then
  begin
    S := TLMDCustomToolBar(Source);
    ImageList := S.ImageList;
    Buttons.Assign(S.Buttons);
    Bevel.Assign(S.Bevel);
    SeparatorFillObject.Assign(S.SeparatorFillObject);
    FillObject.Assign(S.FillObject);
    ButtonMargin := S.ButtonMargin;
    ButtonHeight := S.ButtonHeight;
    ButtonWidth := S.ButtonWidth;
    ThemeMode := S.ThemeMode;
    ButtonStyle := S.ButtonStyle;
  end
  else
    inherited Assign(Source);
end;

procedure TLMDCustomToolBar.Clear;
begin
  Buttons.Clear;
end;

constructor TLMDCustomToolBar.Create(aOwner: TComponent);
begin
  inherited;
  FBtnSize := Point (30,30);
  Align := alTop;
  Height := ButtonHeight;
  FRowGap := 4;
  FOrientation := toHorizontal;
  FButtonMargin := 1;
  FSeparatorWidth := cDefaultSeparatorWidth;
  FSeparatorFillObject := TLMDFillObject.Create(aOwner);
  FSeparatorFillObject.OnChange := SeparatorFillObjectChanged;
  FInitializingBevel := true; //suppress GetChange
  Bevel.Mode := bmCustom;
  Bevel.StyleInner := bvNone;
  Bevel.StyleOuter := bvNone;
  Bevel.BorderInnerWidth := 1;
  FInitializingBevel := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomToolBar.CreateButtons;
begin
  FButtons := TLMDToolButtons.Create (self, true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomToolBar.DeleteButton(index: integer);
begin
  Buttons.Delete(index);
end;

destructor TLMDCustomToolBar.Destroy;
begin
  inherited;
  FreeAndNil(FSeparatorFillObject);  
end;

function TLMDCustomToolBar.GetButton(index: integer): TLMDToolButton;
begin
  result := TLMDToolButton(Buttons[index]);
end;

function TLMDCustomToolBar.GetButtons: TLMDToolButtons;
begin
  result := TLMDToolButtons(FButtons);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomToolBar.GetChange(Sender: TObject);
var
  i: integer;
begin
  if FInitializingBevel then
    exit;
  for i:= 0 to Buttons.Count - 1 do
  begin
    Button[i].Height := Button[i].BtnHeight;
    Button[i].Width := Button[i].BtnWidth;
    Button[i].ImageList := ImageList;
  end;
  if Align in [alTop, alBottom]  then
    FOrientation := toHorizontal
  else
    FOrientation := toVertical;
  inherited;
end;

procedure TLMDCustomToolBar.SeparatorFillObjectChanged(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Buttons.Count - 1 do
    if Button[i].Kind = tbkSeparator then
    begin
      Button[i].Separator.FillObject := SeparatorFillObject;
      Button[i].Separator.Repaint;
    end;
end;

procedure TLMDCustomToolBar.SetBorders;
var
  c,
  dx, dy, maxbsize, i: Integer;
  aRect : TRect;
  lBtn: TLMDToolButton;

  procedure DoSetBounds;
  begin
    if Assigned(lBtn.Btn) then
    begin
      if (lBtn.Kind = tbkButton) then
      begin
        lBtn.Separator.SetBounds (-10, -10, 1, 1);
        lBtn.Btn.SetBounds (aRect.Left + dx, aRect.Top + dy, lBtn.BtnWidth, lBtn.BtnHeight);
      end
    else
    begin
        lBtn.Btn.SetBounds (-10, -10, 1, 1);
      if Orientation = toHorizontal then
        lBtn.Separator.SetBounds (aRect.Left + dx, aRect.Top + dy, lBtn.Width, ButtonHeight)
      else
        lBtn.Separator.SetBounds (aRect.Left + dx, aRect.Top + dy, ButtonWidth, lBtn.Width)
    end;
  end;
  end;

begin
  if [csReading, csLoading]*ComponentState<>[] then exit;
  aRect := ClientRect;
  if not FSetBorders and (Buttons.Count > 0) then
  begin
    FSetBorders := true;  
    try
      if Bevel.Mode <> bmWindows then
        InflateRect (aRect, -Bevel.BevelExtend, -Bevel.BevelExtend);
      c := Buttons.Count;
      dy := 0;
      if FOrientation = toHorizontal then
        maxbsize := ButtonHeight
      else
        maxbsize := ButtonWidth;
      dx := 0;
      for i := 0 to c - 1 do
      begin
        lBtn := TLMDToolButton(Buttons[i]);
          if FOrientation = toHorizontal then
          begin
            dx := dx + lBtn.BtnMargin;
            if (aRect.Left + dx + lBtn.BtnWidth > aRect.Right - aRect.Left) then
            begin
              dx := lBtn.BtnMargin;
              dy := dy + lBtn.BtnHeight + FRowGap;
            end;
            if maxbsize < lBtn.BtnHeight then
              maxbsize := lBtn.BtnHeight;
            DoSetBounds;
            dx := dx + lBtn.BtnWidth;
            dx := dx + lBtn.BtnMargin;
          end
          else
          begin
            dy := dy + lBtn.BtnMargin;
            if (aRect.Top + dy + lBtn.BtnHeight > aRect.Bottom - aRect.Top) then
            begin
              dy := lBtn.BtnMargin;
              dx := dx + lBtn.BtnWidth + FRowGap;
            end;
            if maxbsize < lBtn.BtnWidth then
              maxbsize := lBtn.BtnWidth;
            DoSetBounds;
            dy := dy + lBtn.BtnHeight;
            dy := dy + lBtn.BtnMargin;
          end;
        if Assigned (FOnBtnClick) and Assigned(lBtn.Btn) then
            FButtons[i].Btn.OnClick := DoBtnClick;
        if FOrientation = toHorizontal then
          SetBounds (Left, Top, (aRect.Right - aRect.Left) + Bevel.BevelExtend * 2, dy + maxbsize + Bevel.BevelExtend * 2 + 1)
        else
          SetBounds (Left, Top, dx + maxbsize + Bevel.BevelExtend * 2 + 1, (aRect.Bottom - aRect.Top) + Bevel.BevelExtend * 2)
      end;
    finally
      FSetBorders := false;
    end;
  end
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDCustomToolBar.SetButtonMargin(const Value: integer);
begin
  FButtonMargin := Value;
  if csDesigning in ComponentState then
    SetBorders;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomToolBar.SetButtons(const Value: TLMDToolButtons);
begin
  FButtons.Assign(Value);
end;

{----------------------------- TLMDToolButtons --------------------------------}
constructor TLMDToolButtons.Create(Owner: TWinControl; inform: Boolean);
begin
  inherited;
end;

function TLMDToolButtons.GetButtonClass: TCollectionItemClass;
begin
  result := TLMDToolButton;
end;

{----------------------------- TLMDToolButton ---------------------------------}
procedure TLMDToolButton.Assign(Source: TPersistent);
var
  S: TLMDToolButton;
begin
  if Source = self then exit;
  if (Source is TLMDToolButton) then
  begin
    S := TLMDToolButton(Source);
    FUseToolbarMargin := S.UseToolbarMargin;
    FUseToolbarBtnSize:= S.UseToolbarBtnSize;
    Kind := S.Kind;
    FWidth := S.Width;
    FHeight := S.Height;
    FMargin := S.Margin;
    Action := S.Action;
  end;
  inherited Assign (Source);
end;

function TLMDToolButton.BtnHeight: integer;
begin
  result := FHeight;
  if UseToolbarBtnSize then
  case Kind of
    tbkButton:
      result := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ButtonHeight;
    tbkSeparator:
      result := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).SeparatorWidth;
  end
  else
  case Kind of
    tbkButton:
    result := FHeight;
    tbkSeparator:
      result := FWidth;
  end;
end;

function TLMDToolButton.BtnMargin: integer;
begin
  if UseToolbarMargin then
    result := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ButtonMargin
  else
    result := FMargin;
end;

function TLMDToolButton.BtnWidth: integer;
begin
  result := FWidth;
  if UseToolbarBtnSize then
  case Kind of
    tbkButton:
      result := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ButtonWidth;
    tbkSeparator:
      result := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).SeparatorWidth;
  end
  else
    result := FWidth;
end;

constructor TLMDToolButton.Create(Collection: TCollection);
begin
  //FKind := TLMDToolButtons(Collection).CreateKind;
  inherited;
  FMargin := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ButtonMargin;
  FWidth := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ButtonWidth;
  FHeight:= TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ButtonHeight;
  FUseToolbarMargin := true;
  FUseToolbarBtnSize := true;
  FKind := tbkButton;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDToolButton.CreateButtonControl;
begin
  inherited;
  FSeparator := TLMDFill.Create(TWinControl(TLMDToolButtons(Collection).GetOwner));
  FSeparator.Parent := TWinControl(TLMDToolButtons(Collection).GetOwner);

  if FKind = tbkButton then
  begin
    FSeparator.Visible := false;
    FSeparator.Left := -10;
    FSeparator.Top := -10;
    FSeparator.Width := 1;
    FSeparator.Height := 1;

    FMargin := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ButtonMargin;
    FWidth := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ButtonWidth;
    FBtn.Width := BtnWidth;
    ThemeMode := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ThemeMode;
    ImageList := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ImageList;
  end;

  if FKind = tbkSeparator then
  begin
    FBtn.Visible := false;
    FBtn.Left := -10;
    FBtn.Top := -10;
    FBtn.Width := 1;
    FBtn.Height := 1;

    FWidth := 4;
    FMargin := 0;
    FSeparator.Bevel.Mode := bmStandard;
    FSeparator.Bevel.StandardStyle := lsNone;
    //this is actually Assign behind the '='
    FSeparator.FillObject := TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).SeparatorFillObject;
    FSeparator.Width := Width;
    FSeparator.Tag := index;
    ImageIndex := -1;
    ImageList := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDToolButton.Destroy;
begin
  FreeAndNil(FSeparator);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDToolButton.GetAction: TBasicAction;
begin
  result := Btn.Action;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDToolButton.SetAction(const Value: TBasicAction);
begin
  Btn.Action := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDToolButton.SetHeight(const Value: integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    if csDesigning in TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ComponentState then
      TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).SetBorders;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDToolButton.SetKind(const Value: TLMDToolButtonKind);
begin
    FKind := Value;
    if FKind = tbkSeparator then
    begin
      FBtn.Visible := false;
      FSeparator.Visible := true;
      if not UseToolbarBtnSize then
        FWidth := cDefaultSeparatorWidth;
    end
    else
    begin
      FBtn.Visible := true;
      FSeparator.Visible := false;
      if (FWidth <> BtnWidth) then
        FWidth := BtnWidth;      
  end;
  TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).SetBorders;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDToolButton.SetMargin(const Value: integer);
begin
  FMargin := Value;
    if csDesigning in TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ComponentState then
      TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).SetBorders;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDToolButton.SetUseToolbarBtnSize(const Value: boolean);
begin
  FUseToolbarBtnSize := Value;
end;

procedure TLMDToolButton.SetUseToolbarMargin(const Value: boolean);
begin
  FUseToolbarMargin := Value;
end;

procedure TLMDToolButton.SetWidth(const Value: integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    if csDesigning in TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).ComponentState then
      TLMDCustomToolBar(TLMDToolButtons(Collection).GetOwner).SetBorders;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomToolBar.SetOrientation(const Value: TLMDOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    SetBorders;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomToolBar.SetRowGap(const Value: integer);
begin
  FRowGap := Value;
  SetBorders;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomToolBar.SetSeparatorFillObject(
  const Value: TLMDFillObject);
begin
  FSeparatorFillObject.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomToolBar.SetSeparatorWidth(const Value: integer);
begin
  if FSeparatorWidth <> Value then
    FSeparatorWidth := Value;
end;

end.
