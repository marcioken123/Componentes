unit pLMDMarginsEditor;
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

pLMDMarginsEditor unit
----------------------------------------------
An editor for the four margins of some area
(used e.g. in the Chart component editor)

ToDo
----
*
Changes
-------

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, ExtCtrls, Graphics, Types, 
  LMDShSpinEdit;

type
  TLMDMarginsEditor = class(TCustomPanel)
  private
    FSETopMargin: TLMDShSpinEdit;
    FSELeftMargin: TLMDShSpinEdit;
    FSERightMargin: TLMDShSpinEdit;
    FSEBottomMargin: TLMDShSpinEdit;
    function GetBottomMarginChange: TNotifyEvent;
    function GetLeftMarginChange: TNotifyEvent;
    function GetRightMarginChange: TNotifyEvent;
    function GetTopMarginChange: TNotifyEvent;
    procedure SetBottomMarginChange(const Value: TNotifyEvent);
    procedure SetLeftMarginChange(const Value: TNotifyEvent);
    procedure SetRightMarginChange(const Value: TNotifyEvent);
    procedure SetTopMarginChange(const Value: TNotifyEvent);
    { Private declarations }
  protected
    { Protected declarations }
    procedure Resize; override;
    procedure Loaded; override;
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override; 
  published
    { Published declarations }
    property SETopMargin: TLMDShSpinEdit read FSETopMargin;
    property SEBottomMargin: TLMDShSpinEdit read FSEBottomMargin;
    property SELeftMargin: TLMDShSpinEdit read FSELeftMargin;
    property SERightMargin: TLMDShSpinEdit read FSERightMargin;

    property TopMarginChange: TNotifyEvent read GetTopMarginChange write SetTopMarginChange;
    property BottomMarginChange: TNotifyEvent read GetBottomMarginChange write SetBottomMarginChange;
    property LeftMarginChange: TNotifyEvent read GetLeftMarginChange write SetLeftMarginChange;
    property RightMarginChange: TNotifyEvent read GetRightMarginChange write SetRightMarginChange;
  end;

implementation

{ TLMDMarginsEditor }

constructor TLMDMarginsEditor.Create(AOwner: TComponent);
begin
  inherited;

  Self.BevelInner := bvNone;
  Self.BevelOuter := bvNone;

  Self.FSETopMargin := TLMDShSpinEdit.Create(Self);
  Self.FSETopMargin.Parent := Self;
  Self.FSETopMargin.Width := 50;
  Self.FSETopMargin.Top := 10;
  Self.FSETopMargin.Anchors := [akTop];

  Self.FSELeftMargin := TLMDShSpinEdit.Create(Self);
  Self.FSELeftMargin.Parent := Self;
  Self.FSELeftMargin.Width := 50;
  Self.FSELeftMargin.Left := 10;
  Self.FSELeftMargin.Anchors := [akLeft];

  Self.FSEBottomMargin := TLMDShSpinEdit.Create(Self);
  Self.FSEBottomMargin.Parent := Self;
  Self.FSEBottomMargin.Width := 50;
  Self.FSEBottomMargin.Top := Self.Height -  Self.FSEBottomMargin.Height - 10;
  Self.FSEBottomMargin.Anchors := [akBottom];

  Self.FSERightMargin := TLMDShSpinEdit.Create(Self);
  Self.FSERightMargin.Parent := Self;
  Self.FSERightMargin.Width := 50;
  Self.FSERightMargin.Left := Self.Width - Self.FSERightMargin.Width - 10;
  Self.FSERightMargin.Anchors := [akRight];
end;

destructor TLMDMarginsEditor.Destroy;
begin

  inherited;
end;

function TLMDMarginsEditor.GetBottomMarginChange: TNotifyEvent;
begin
  Result := Self.FSEBottomMargin.OnChange;
end;

function TLMDMarginsEditor.GetLeftMarginChange: TNotifyEvent;
begin
  Result := Self.FSELeftMargin.OnChange;
end;

function TLMDMarginsEditor.GetRightMarginChange: TNotifyEvent;
begin
  Result := Self.FSERightMargin.OnChange;
end;

function TLMDMarginsEditor.GetTopMarginChange: TNotifyEvent;
begin
  Result := Self.FSETopMargin.OnChange;
end;

procedure TLMDMarginsEditor.Loaded;
begin
  inherited;
  Self.Caption := '';
end;

procedure TLMDMarginsEditor.Paint;
begin
  inherited;
  Self.Canvas.Brush.Color := Self.Color;
  Self.Canvas.FillRect(Rect(0, 0, Self.Width, Self.Height));
end;

procedure TLMDMarginsEditor.Resize;
begin
  inherited;
  Self.FSETopMargin.Left := (Self.Width div 2) - (Self.FSETopMargin.Width div 2);
  Self.FSELeftMargin.Top := (Self.Height div 2) - (Self.FSELeftMargin.Height div 2);
  Self.FSEBottomMargin.Left := Self.FSETopMargin.Left;
  Self.FSERightMargin.Top := Self.FSELeftMargin.Top;
end;

procedure TLMDMarginsEditor.SetBottomMarginChange(
  const Value: TNotifyEvent);
begin
  Self.FSEBottomMargin.OnChange := Value;
end;

procedure TLMDMarginsEditor.SetLeftMarginChange(const Value: TNotifyEvent);
begin
  Self.FSELeftMargin.OnChange := Value;
end;

procedure TLMDMarginsEditor.SetRightMarginChange(
  const Value: TNotifyEvent);
begin
  Self.FSERightMargin.OnChange := Value;
end;

procedure TLMDMarginsEditor.SetTopMarginChange(const Value: TNotifyEvent);
begin
  Self.FSETopMargin.OnChange := Value;
end;

initialization

RegisterClass(TLMDShSpinEdit);

end.
