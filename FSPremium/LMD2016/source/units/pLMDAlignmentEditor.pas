unit pLMDAlignmentEditor;
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
pLMDAlignmentEditor unit
------------------------
Component for visual selection of element's alignment

Changes
-------
Release 1.0 (July 2006)
 - Initial Release
 
###############################################################################}

interface

uses
  SysUtils, Classes, Controls, StdCtrls, ExtCtrls, Graphics, Buttons;

type
  TLMDAlignmentMode = (amAll, amBorder, am4Sides, am4SidesCenter);
  TLMDAlignmentEditor = class(TCustomGroupBox)
  private
    FBottomButton: TSpeedButton;
    FBottomLeftButton: TSpeedButton;
    FTopLeftButton: TSpeedButton;
    FBottomRightButton: TSpeedButton;
    FRightButton: TSpeedButton;
    FCenterButton: TSpeedButton;
    FTopButton: TSpeedButton;
    FTopRightButton: TSpeedButton;
    FLeftButton: TSpeedButton;
    FButtonSpaceWidth: integer;
    FMode: TLMDAlignmentMode;
    FButtonList: TList;
    FSelY: integer;
    FSelX: integer;
    FOnChange: TNotifyEvent;

    procedure SetButtonSpaceWidth(const Value: integer);
    procedure SetMode(const Value: TLMDAlignmentMode);
    procedure SetSelX(const Value: integer);
    procedure SetSelY(const Value: integer);
  protected
    procedure Resize; override;
    procedure ButtonClick(ASender: TObject);
    function  GetPressedButton: TSpeedButton;
    function  GetButtonX(AButton: TSpeedButton): integer;
    function  GetButtonY(AButton: TSpeedButton): integer;
    procedure SetButtonDown(AButton: TSpeedButton);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property TopLeftButton: TSpeedButton read FTopLeftButton;
    property LeftButton: TSpeedButton read FLeftButton;
    property BottomLeftButton: TSpeedButton read FBottomLeftButton;
    property BottomButton: TSpeedButton read FBottomButton;
    property BottomRightButton: TSpeedButton read FBottomRightButton;
    property RightButton: TSpeedButton read FRightButton;
    property TopRightButton: TSpeedButton read FTopRightButton;
    property TopButton: TSpeedButton read FTopButton;
    property CenterButton: TSpeedButton read FCenterButton;
    property ButtonSpaceWidth: integer read FButtonSpaceWidth write SetButtonSpaceWidth;
    property Mode: TLMDAlignmentMode read FMode write SetMode;

    property SelX: integer read FSelX write SetSelX;
    property SelY: integer read FSelY write SetSelY;

    property Caption;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

{ ************************* TLMDAlignmentEditor ******************************* }

procedure TLMDAlignmentEditor.ButtonClick(ASender: TObject);
begin
  Self.FSelX := Self.GetButtonX(ASender as TSpeedButton);
  Self.FSelY := Self.GetButtonY(ASender as TSpeedButton);
  Self.SetButtonDown(ASender as TSpeedButton);

  if Assigned(Self.FOnChange) then
    Self.FOnChange(Self);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDAlignmentEditor.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited;
  Self.FTopLeftButton := TSpeedButton.Create(Self);
  Self.FTopLeftButton.Parent := Self;
  Self.FLeftButton := TSpeedButton.Create(Self);
  Self.FLeftButton.Parent := Self;
  Self.FBottomLeftButton := TSpeedButton.Create(Self);
  Self.FBottomLeftButton.Parent := Self;
  Self.FBottomButton := TSpeedButton.Create(Self);
  Self.FBottomButton.Parent := Self;
  Self.FBottomRightButton := TSpeedButton.Create(Self);
  Self.FBottomRightButton.Parent := Self;
  Self.FRightButton := TSpeedButton.Create(Self);
  Self.FRightButton.Parent := Self;
  Self.FTopRightButton := TSpeedButton.Create(Self);
  Self.FTopRightButton.Parent := Self;
  Self.FTopButton := TSpeedButton.Create(Self);
  Self.FTopButton.Parent := Self;
  Self.FCenterButton := TSpeedButton.Create(Self);
  Self.FCenterButton.Parent := Self;

  Self.FButtonList := TList.Create;
  Self.FButtonList.Add(Self.FTopLeftButton);
  Self.FButtonList.Add(Self.FLeftButton);
  Self.FButtonList.Add(Self.FBottomLeftButton);
  Self.FButtonList.Add(Self.FTopButton);
  Self.FButtonList.Add(Self.FCenterButton);
  Self.FButtonList.Add(Self.FBottomButton);
  Self.FButtonList.Add(Self.FTopRightButton);
  Self.FButtonList.Add(Self.FRightButton);
  Self.FButtonList.Add(Self.FBottomRightButton);

  Self.FButtonSpaceWidth := 3;

  for i := 0 to Self.FButtonList.Count - 1 do
  begin
    TSpeedButton(Self.FButtonList[i]).OnClick := Self.ButtonClick;
    TSpeedButton(Self.FButtonList[i]).GroupIndex := 1;
  end;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDAlignmentEditor.Destroy;
begin
  Self.FButtonList.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

function TLMDAlignmentEditor.GetButtonX(AButton: TSpeedButton): integer;
begin
  Result := Self.FButtonList.IndexOf(AButton) div 3;
end;

{ ---------------------------------------------------------------------------- }

function TLMDAlignmentEditor.GetButtonY(AButton: TSpeedButton): integer;
begin
  Result := Self.FButtonList.IndexOf(AButton) mod 3;
end;

{ ---------------------------------------------------------------------------- }

function TLMDAlignmentEditor.GetPressedButton: TSpeedButton;
var
  i: integer;
  found: boolean;
begin
  found := false; i := 0;
  while (not found) and (i < Self.FButtonList.Count) do
  begin
    found := TSpeedButton(Self.FButtonList[i]).Down;
    if not found then
      Inc(i);
  end;
  Result := TSpeedButton(Self.FButtonList[i]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDAlignmentEditor.Resize;
var
  LBtWidth: integer;
  LBtHeight: integer;
  i: integer;
  cx, cy: integer;
  LBtn: TSpeedButton;
begin
  inherited;
  LbtWidth := (Self.ClientWidth - 4 * Self.FButtonSpaceWidth) div 3;
  LbtHeight := (Self.ClientHeight - 4 * Self.FButtonSpaceWidth - Abs(Self.Font.Height) - 3) div 3;
  for i := 0 to Self.FButtonList.Count - 1 do
  begin
    LBtn := TSpeedButton(Self.FButtonList[i]);
    cx := Self.GetButtonX(Lbtn);
    cy := Self.GetButtonY(LBtn);
    LBtn.Height := LBtHeight;
    LBtn.Width := LBtWidth;
    LBtn.Top := cy * LBtHeight + (cy + 1) * Self.FButtonSpaceWidth + Abs(Self.Font.Height) + 3;
    LBtn.Left := cx * LBtWidth + (cx + 1) * Self.FButtonSpaceWidth;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDAlignmentEditor.SetButtonDown(AButton: TSpeedButton);
{var
  i: integer; }
begin
  {for i := 0 to Self.FButtonList.Count - 1 do
    TSpeedButton(Self.FButtonList[i]).Down := Self.FButtonList[i] = AButton; }
  AButton.Down := true;   
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDAlignmentEditor.SetButtonSpaceWidth(const Value: integer);
begin
  FButtonSpaceWidth := Value;
  Self.Resize;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDAlignmentEditor.SetMode(const Value: TLMDAlignmentMode);
begin
  FMode := Value;
  Self.FTopLeftButton.Visible := Self.FMode in [amAll, amBorder];
  Self.FBottomLeftButton.Visible := Self.FTopLeftButton.Visible;
  Self.FBottomRightButton.Visible := Self.FTopLeftButton.Visible;
  Self.FTopRightButton.Visible := Self.FTopLeftButton.Visible;
  Self.FCenterButton.Visible := Self.FMode in [amAll, am4SidesCenter];
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDAlignmentEditor.SetSelX(const Value: integer);
begin
  if (Value < 0) or (Value > 2) then Exit;
  Self.FSelX := Value;
  Self.SetButtonDown(TSpeedButton(Self.FButtonList[Self.FSelX * 3 + Self.FSelY]));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDAlignmentEditor.SetSelY(const Value: integer);
begin
  if (Value < 0) or (Value > 2) then Exit;
  Self.FSelY := Value;
  Self.SetButtonDown(TSpeedButton(Self.FButtonList[Self.FSelX * 3 + Self.FSelY]));
end;

end.

