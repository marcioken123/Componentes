unit pLMDURLLabel;

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

pLMDURLLabel unit (RM)
----------------------

Common control for all Packs / used at Designtime

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface
{$I lmdcmps.inc}
uses
  Graphics, Classes, Controls, StdCtrls, ActnList;

type
  {---------------------- TLMDURLLabel ----------------------------------------}
  TLMDURLLabel = class(TCustomLabel)
  private
    FJump: string;
    FActiveColor,
    FInActiveColor: TColor;
    FJumpUnderline: Boolean;
    FCounter: LongInt;
    procedure SetColor(Index: Integer; aValue: TColor);
    procedure SetJumpUnderLine(aValue: Boolean);
    function GetCounter: LongInt;
  protected
    procedure Click; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ResetCounter;
    // 5.0
    procedure Execute;
    property Counter: LongInt read GetCounter;
  published
    property Action;
    property Caption;
    property ActiveColor: TColor index 0 read FActiveColor write SetColor default clPurple;
    property Jump: string read FJump write FJump;
    property InActiveColor: TColor index 1 read FInActiveColor write SetColor default clBlue;
    property JumpUnderline: Boolean read FJumpUnderline write SetJumpUnderLine default true;
    property Align;
    property Alignment;
    property AutoSize;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Transparent;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    {4.0}
    //properties
    property Anchors;
    property BiDiMode;
    property DragKind;
    property Constraints;
    property ParentBiDiMode;
    //events
    property OnEndDock;
    property OnStartDock;
  end;

implementation

uses
  Windows, Forms, ShellApi, SysUtils;

{********************* Class TLMDURLLabel **********************************}
{----------------------- Private ----------------------------------------------}
procedure TLMDURLLabel.SetColor(Index: Integer; aValue: TColor);
begin
  case Index of
    0:
      if aValue = FActiveColor then
        exit
      else
        FActiveColor:= aValue;
    1:
      if aValue = FInActiveColor then
        exit
      else
        begin
          FInActiveColor:= aValue;
          Font.Color:= FInActiveColor;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDURLLabel.SetJumpUnderLine(aValue: Boolean);
begin
  if aValue <> FJumpUnderline then
    begin
      FJumpUnderline:= aValue;
      if FJumpUnderline then
        Font.Style:= Font.Style + [fsUnderline]
      else
        Font.Style:= Font.Style - [fsUnderline]
    end;
end;

{------------------------------------------------------------------------------}
function TLMDURLLabel.GetCounter: LongInt;
begin
  Result:= FCounter;
end;

{----------------------- Protected --------------------------------------------}
procedure TLMDURLLabel.Click;
var
  buffer: string;
begin
  if Trim(FJump) <> '' then
    buffer:= FJump
  else if Pos('@', GetLabelText) > 0 then
    buffer:= 'mailto:' + GetLabelText
  else
    buffer:= GetLabelText;
  if ShellExecute(Application.Handle, nil,
    PChar(buffer), nil, nil, SW_NORMAL) <= 32 then
  Enabled:= false;
end;

{------------------------------------------------------------------------------}
procedure TLMDURLLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then
    begin
      INC(FCounter);
      Font.Color:= FActiveColor;
    end;
  inherited MouseDown(Button, Shift, X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDURLLabel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then Font.Color:= FInActiveColor;
  inherited MouseUp(Button, Shift, X, Y);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDURLLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInActiveColor:= clBlue;
  FActiveColor:= clPurple;
  FJumpUnderline:= true;
  FCounter:= 0;
  Font.Color:= FInActiveColor;
  Font.Style:= Font.Style + [fsUnderline];
  Cursor:= crHandPoint;
end;

{------------------------------------------------------------------------------}
destructor TLMDURLLabel.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDURLLabel.Execute;
begin
  INC(FCounter);
  Font.Color:= FActiveColor;
  Click;
end;

{------------------------------------------------------------------------------}
procedure TLMDURLLabel.ResetCounter;
begin
  FCounter:= 0;
  Font.Color:= FInActiveColor;
  if FJumpUnderline then
    Font.Style:= Font.Style + [fsUnderline];
end;

end.
