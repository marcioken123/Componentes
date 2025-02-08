unit pLMDDistanceAndPositionDlg;
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
pLMDDistanceAndPositionDlg unit - size, margins and position editor
-----------------------------------
Description

Editor which allows to visually define position and size of some element
and/or margins - distances to borders/other elemenets
-----------------------------------

ToDo
----
*

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, StdCtrls, Controls, ExtCtrls, Classes,
  Graphics, Forms, Dialogs,
  pLMDMarginsEditor, LMDShSpinEdit;

type
  TLMDDistanceAndSizeEditor = class(TForm)
    plArea: TPanel;
    plTools: TPanel;
    plBottomMargin: TPanel;
    plTopMargin: TPanel;
    plLeftMargin: TPanel;
    plRightMargin: TPanel;
    plElement: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    btOK: TButton;
    btCancel: TButton;
    Label1: TLabel;
    LMDMarginsEditor1: TLMDMarginsEditor;
    procedure plElementMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure plElementMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure plElementMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure plTopMarginResize(Sender: TObject);
  private
    FAreaWidth: integer;
    FAreaHeight: integer;
    FScaleCoef: double;
    FAllowsSizing: boolean;
    FAllowsMoving: boolean;

    FStartX: integer;
    FStartY: integer;
    FLiveMoving: boolean;

    procedure AdjustElementPosition(X, Y: integer);

    procedure MarginSEValueChanged(ASender: TObject);
    procedure SetMarginSEHandlers(assign: boolean);

    function GetBottomMargin: integer;
    function GetElementHeight: integer;
    function GetLeftMargin: integer;
    function GetRightMargin: integer;
    function GetTopMargin: integer;
    function GetElementWidth: integer;
    procedure SetBottomMargin(const Value: integer);
    procedure SetElementHeight(const Value: integer);
    procedure SetLeftMargin(const Value: integer);
    procedure SetRightMargin(const Value: integer);
    procedure SetTopMargin(const Value: integer);
    procedure SetElementWidth(const Value: integer);
    procedure SetAllowsSizing(const Value: boolean);
    procedure SetScaleCoef(const Value: double);
    { Private declarations }
  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;

    function Edit: boolean;

    property AreaWidth: integer read FAreaWidth write FAreaWidth;
    property AreaHeight: integer read FAreaHeight write FAreaHeight;
    property ScaleCoef: double read FScaleCoef write SetScaleCoef;

    property TopMargin: integer read GetTopMargin write SetTopMargin;
    property LeftMargin: integer read GetLeftMargin write SetLeftMargin;
    property RightMargin: integer read GetRightMargin write SetRightMargin;
    property BottomMargin: integer read GetBottomMargin write SetBottomMargin;
    property ElementHeight: integer read GetElementHeight write SetElementHeight;
    property ElementWidth: integer read GetElementWidth write SetElementWidth;

    property AllowsMoving: boolean read FAllowsMoving write FAllowsMoving;
    property AllowsSizing: boolean read FAllowsSizing write SetAllowsSizing;
    property LiveMoving: boolean read FLiveMoving write FLiveMoving;
  end;

var
  LMDDistanceAndSizeEditor: TLMDDistanceAndSizeEditor;

implementation

{$R *.dfm}

{ TLMDDistanceAndSizeEditor }

function TLMDDistanceAndSizeEditor.GetBottomMargin: integer;
begin
  Result := Round(Self.plBottomMargin.Height / Self.ScaleCoef);
end;

function TLMDDistanceAndSizeEditor.GetElementHeight: integer;
begin
  Result := Round(Self.plElement.Height / Self.ScaleCoef);
end;

function TLMDDistanceAndSizeEditor.GetLeftMargin: integer;
begin
  Result := Round(Self.plLeftMargin.Width / Self.ScaleCoef);
end;

function TLMDDistanceAndSizeEditor.GetRightMargin: integer;
begin
  Result := Round(Self.plRightMargin.Height / Self.ScaleCoef);
end;

function TLMDDistanceAndSizeEditor.GetTopMargin: integer;
begin
  Result := Round(Self.plTopMargin.Height / Self.ScaleCoef);
end;

function TLMDDistanceAndSizeEditor.GetElementWidth: integer;
begin
  Result := Round(Self.plElement.Height / Self.ScaleCoef);
end;

procedure TLMDDistanceAndSizeEditor.SetBottomMargin(const Value: integer);
begin
  Self.SetMarginSEHandlers(false);
  Self.LMDMarginsEditor1.SEBottomMargin.Value := Value;
  Self.plBottomMargin.Height := Round(Value * Self.ScaleCoef);
  Self.SetMarginSEHandlers(true);
end;

procedure TLMDDistanceAndSizeEditor.SetElementHeight(const Value: integer);
begin
  Self.BottomMargin := Self.AreaHeight - Self.TopMargin - Value;
end;

procedure TLMDDistanceAndSizeEditor.SetLeftMargin(const Value: integer);
begin
  Self.SetMarginSEHandlers(false);
  Self.LMDMarginsEditor1.SELeftMargin.Value := Value;
  Self.plLeftMargin.Width := Round(Value * Self.ScaleCoef);
  Self.SetMarginSEHandlers(true);
end;

procedure TLMDDistanceAndSizeEditor.SetRightMargin(const Value: integer);
begin
  Self.SetMarginSEHandlers(false);
  Self.LMDMarginsEditor1.SERightMargin.Value := Value;
  Self.plRightMargin.Height := Round(Value * Self.ScaleCoef);
  Self.SetMarginSEHandlers(true);
end;

procedure TLMDDistanceAndSizeEditor.SetTopMargin(const Value: integer);
begin
  Self.SetMarginSEHandlers(false);
  Self.LMDMarginsEditor1.SETopMargin.Value := Value;
  Self.plTopMargin.Height := Round(Value * Self.ScaleCoef);
  Self.SetMarginSEHandlers(true);
end;

procedure TLMDDistanceAndSizeEditor.SetElementWidth(const Value: integer);
begin
  Self.RightMargin := Self.AreaWidth - Self.LeftMargin - Value;
end;

procedure TLMDDistanceAndSizeEditor.plElementMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Self.FStartX := X;
  Self.FStartY := Y;
end;

procedure TLMDDistanceAndSizeEditor.SetAllowsSizing(const Value: boolean);
begin
  FAllowsSizing := Value;
  Self.Splitter1.Visible := Self.AllowsSizing;
  Self.Splitter2.Visible := Self.AllowsSizing;
  Self.Splitter3.Visible := Self.AllowsSizing;
  Self.Splitter4.Visible := Self.AllowsSizing;
end;

procedure TLMDDistanceAndSizeEditor.plElementMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Self.AllowsMoving then
    Self.AdjustElementPosition(X, Y);
end;

procedure TLMDDistanceAndSizeEditor.FormCreate(Sender: TObject);
begin
  Self.AllowsMoving := true;
  Self.AllowsSizing := true;
  Self.ScaleCoef := 1;
  Self.AreaWidth := 150;
  Self.AreaHeight := 100;

  Self.TopMargin := 10;
  Self.LeftMargin := 15;

  Self.ElementHeight := 80;
  Self.ElementWidth := 120;
end;

procedure TLMDDistanceAndSizeEditor.plElementMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);

begin
  if Self.AllowsMoving and Self.LiveMoving and (ssLeft in Shift) then
    Self.AdjustElementPosition(X, Y);
end;

procedure TLMDDistanceAndSizeEditor.AdjustElementPosition(X, Y: integer);
var
  Ldx, Ldy: integer;
begin
  Ldx := X - Self.FStartX;
  Ldy := Y - Self.FStartY;
  Self.plLeftMargin.Width := Self.plLeftMargin.Width + Ldx;
  Self.plRightMargin.Width := Self.plRightMargin.Width - Ldx;
  Self.plTopMargin.Height := Self.plTopMargin.Height + Ldy;
  Self.plBottomMargin.Height := Self.plBottomMargin.Height - Ldy;

  Self.FStartX := X;
  Self.FStartY := Y;
end;

function TLMDDistanceAndSizeEditor.Edit: boolean;
begin
  Result := Self.ShowModal = mrOK;
end;

procedure TLMDDistanceAndSizeEditor.SetScaleCoef(const Value: double);
var
  LCurAreaWidth, LCurAreaHeight, LCurTopMargin,
  LCurLeftMargin, LCurElementWidth, LCurElementHeight: integer;
begin
  LCurAreaWidth := Self.AreaWidth;
  LCurAreaHeight := Self.AreaHeight;
  LCurTopMargin := Self.TopMargin;
  LCurLeftMargin := Self.LeftMargin;
  LCurElementWidth := Self.ElementWidth;
  LCurElementHeight := Self.ElementHeight;

  FScaleCoef := Value;

  Self.AreaWidth := LCurAreaWidth;
  Self.AreaHeight := LCurAreaHeight;
  Self.TopMargin := LCurTopMargin;
  Self.LeftMargin := LCurLeftMargin;
  Self.ElementWidth := LCurElementWidth;
  Self.ElementHeight := LCurElementHeight;
end;

constructor TLMDDistanceAndSizeEditor.Create(AOwner: TComponent);
begin
  Self.FScaleCoef := 1;
  inherited;
  Self.SetMarginSEHandlers(true);
end;

procedure TLMDDistanceAndSizeEditor.FormResize(Sender: TObject);
begin
  Self.LMDMarginsEditor1.Left := (Self.ClientWidth - Self.LMDMarginsEditor1.Width) div 2;
end;

procedure TLMDDistanceAndSizeEditor.plTopMarginResize(Sender: TObject);
var
  LSender: TPanel;
begin
  LSender := Sender as TPanel;
  if LSender = Self.plTopMargin then
    Self.TopMargin := Round(LSender.Height * Self.ScaleCoef)
  else if LSender = Self.plLeftMargin then
    Self.LeftMargin := Round(LSender.Width * Self.ScaleCoef)
  else if LSender = Self.plBottomMargin then
    Self.BottomMargin := Round(LSender.Height * Self.ScaleCoef)
  else if LSender = Self.plRightMargin then
    Self.RightMargin := Round(LSender.Width * Self.ScaleCoef);
end;

procedure TLMDDistanceAndSizeEditor.MarginSEValueChanged(ASender: TObject);
var
  LSender: TLMDShSpinEdit;
begin
  LSender := ASender as TLMDShSpinEdit;
  if LSender = Self.LMDMarginsEditor1.SETopMargin then
    Self.TopMargin := LSender.Value
  else if LSender = Self.LMDMarginsEditor1.SELeftMargin then
    Self.LeftMargin := LSender.Value
  else if LSender = Self.LMDMarginsEditor1.SEBottomMargin then
    Self.BottomMargin := LSender.Value
  else if LSender = Self.LMDMarginsEditor1.SERightMargin then
    Self.RightMargin := LSender.Value;
end;

procedure TLMDDistanceAndSizeEditor.SetMarginSEHandlers(assign: boolean);
var
  LHnd1, LHnd2: TNotifyEvent;
begin
  if assign then
  begin
    LHnd1 := Self.MarginSEValueChanged;
    LHnd2 := Self.plTopMarginResize;
  end
  else
  begin
    LHnd1 := nil;
    LHnd2 := nil;
  end;
    Self.LMDMarginsEditor1.SETopMargin.OnChange := LHnd1;
  Self.LMDMarginsEditor1.SELeftMargin.OnChange := LHnd1;
  Self.LMDMarginsEditor1.SEBottomMargin.OnChange := LHnd1;
  Self.LMDMarginsEditor1.SERightMargin.OnChange := LHnd1;

  Self.plTopMargin.OnResize := LHnd2;
  Self.plLeftMargin.OnResize := LHnd2;
  Self.plBottomMargin.OnResize := LHnd2;
  Self.plRightMargin.OnResize := LHnd2;
end;

end.
