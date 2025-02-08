unit LMDTrackBarComboBox;
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

LMDTrackBarComboBox unit (JH)
-----------------------------

ComboBox (Integer edit) with drop down TrackBar control

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Controls, Classes, Graphics, Types, Windows,
  LMDTrackBar, LMDCustomExtCombo, LMDGraph;

type
  {********************* TLMDTrackBarComboBox *********************************}
  TLMDTrackBarComboBox = class (TLMDCustomExtCombo)
  private
    FOld : String;
    FTrackColor:TColor;
    FTrackBorder,
    FTrackHeight,
    FTrackWidth: Integer;
    FBorder: Boolean;
    procedure SetColor(const aValue: TColor);
    procedure SetInteger(Index, aValue:Integer);
    procedure SetIValue(const aValue: Integer);
    function GetValue: Integer;
    function GetTrackBar:TLMDTrackBar;
    procedure DrawComboFrame(Sender:TObject);
  protected
    procedure CreateControl; override;
    function GetControl : TWinControl; override;
    procedure BeforeDropDown; override;
    procedure DoThemeChanged;override;
    procedure ReModifyControl; override;
    procedure DisplayControl; override;
    procedure ModifyControl; override;
    procedure Cancel; override;
    procedure Accept; override;
    procedure DoChange(Sender: TObject);
    procedure DoDblClick(Sender: TObject);
    procedure Loaded;override;
  public
    constructor Create(aOwner: TComponent); override;
    property TrackBar:TLMDTrackBar read GetTrackBar;
    procedure Init;override;
    property CtlXP;  // compatibility
    property Value:Integer read GetValue write SetIValue;
  published
    property MinValue;
    property MaxValue;
    property RangeCheck default false;
    property Suffix;
    property TrackBarColor:TColor read FTrackColor write SetColor default clWhite;
    // 8.0
    property TrackBarBorder:Boolean read FBorder write FBorder default true;
    property TrackBarMargin:Integer index 0 read FTrackBorder write SetInteger default 4;
    property TrackBarHeight:Integer index 1 read FTrackHeight write SetInteger default 40;
    property TrackBarWidth:Integer index 2 read FTrackWidth write SetInteger default 230;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
  end;

  {********************* TLMDLabeledTrackBarComboBox **************************}
  TLMDLabeledTrackBarComboBox = class(TLMDTrackBarComboBox)
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
  UxTheme, Themes,
  LMDClass, LMDThemes, LMDCustomTrackBar, LMDCustomMaskEdit;

type
  TLMDComboTrackBar=class(TLMDCustomTrackBar)
  public
    property Canvas;
    property OnDrawFrame;
  end;

{********************** TLMDTrackBarComboBox **********************************}
{ ---------------------------------- private --------------------------------- }
procedure TLMDTrackBarComboBox.SetInteger(Index, aValue:Integer);
begin
  case Index of
    0: if FTrackBorder<>aValue then
         begin
           FTrackBorder := aValue;
           if Assigned(TrackBar) then
             TrackBar.Margin:=FTrackBorder;
         end;
    1: if FTrackHeight<>aValue then
         begin
           FTrackHeight := aValue;
           if Assigned(TrackBar) then
             TrackBar.Height:=FTrackHeight;
         end;
    2: if FTrackWidth<>aValue then
         begin
           FTrackWidth := aValue;
           if Assigned(TrackBar) then
             TrackBar.Width:=FTrackWidth;
         end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.SetColor(const aValue: TColor);
begin
  if aValue<>FTrackColor then
    begin
      FTrackColor:=aValue;
      if Assigned(TrackBar) then
        TrackBar.Color:=FTrackColor;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.SetIValue(const aValue: Integer);
begin
  inherited SetValue(aValue);
  CheckNumberRange;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTrackBarComboBox.GetValue: Integer;
begin
  result:=AsInteger;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTrackBarComboBox.GetTrackBar : TLMDTrackBar;
begin
  result:=TLMDTrackBar(FControl);
end;

{ ---------------------------------- protected ------------------------------- }
procedure TLMDTrackBarComboBox.CreateControl;
begin
  FControl := TLMDTrackBar.Create (self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTrackBarComboBox.GetControl : TWinControl;
begin
  result := TLMDTrackBar(FControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.BeforeDropDown;
begin
  FOld := Text;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.ReModifyControl;
begin
  with FControl as TLMDTrackBar do
    begin
      // 7.10
      SetRange(Trunc(self.MinValue), trunc(self.MaxValue));
      Position := self.AsInteger;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.DisplayControl;
begin
  (FControl as TLMDTrackBar).Top := (FControl as TLMDTrackBar).Top + 3;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.ModifyControl;
begin
  (FControl as TLMDTrackBar).ThemeMode := self.ThemeMode;
  (FControl as TLMDTrackBar).ParentBackground:=false;
  (FControl as TLMDTrackBar).Init;
  (FControl as TLMDTrackBar).OnChange := DoChange;
  (FControl as TLMDTrackBar).OnDblClick := DoDblClick;
  (FControl as TLMDTrackBar).Color := FTrackColor;
  (FControl as TLMDTrackBar).Margin := FTrackBorder;
  (FControl as TLMDTrackBar).Height := FTrackHeight;
  (FControl as TLMDTrackBar).Width := FTrackWidth;
  (FControl as TLMDTrackBar).FocusStyle := tbNoFocus;
  if FBorder then
    TLMDComboTrackBar(FControl).OnDrawFrame:=DrawComboFrame
  else
    TLMDComboTrackBar(FControl).OnDrawFrame:=nil;
  ReModifyControl;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.Cancel;
begin
  Text := FOld;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.Accept;
begin
  SetValue ((FControl as TLMDTrackBar).Position);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.DoChange(Sender: TObject);
begin
  SetValue ((FControl as TLMDTrackBar).Position);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.DoThemeChanged;
begin
  inherited;
  if Assigned(FControl) then ModifyControl;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.DrawComboFrame(Sender: TObject);
var
  lThemeMode: TLMDThemeMode;
begin
  lThemeMode := UseThemeMode;
  if UseThemeMode <> ttmNone then
    LMDThemeServices.DrawThemeEdge(lThemeMode, TLMDComboTrackbar(Sender).Canvas.Handle,
                                   teEdit, EP_EDITTEXT, ETS_NORMAL, TLMDComboTrackbar(Sender).ClientRect,
                                   BDR_RAISEDINNER, BF_RECT)
  else
    with TLMDComboTrackbar(Sender) do
      begin
       Canvas.Brush.Color:=clBlack;
       Canvas.FrameRect(ClientRect);
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.DoDblClick(Sender: TObject);
begin
  Close(true);
end;

{ ----------------------------------- public --------------------------------- }
constructor TLMDTrackBarComboBox.Create(aOwner: TComponent);
begin
  inherited Create (aOwner);
  MinValue := 0;
  MaxValue := 100;
  FTrackColor := clWhite;
  FTrackBorder:= 4;
  FTrackHeight := 40;
  FTrackWidth := 230;
  FBorder:=True;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.Loaded;
begin
  inherited;
  Init;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTrackBarComboBox.Init;
begin
  MaskType := meInteger;
end;

{***************** TLMDLabeledTrackBarComboBox ********************************}
{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledTrackBarComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
