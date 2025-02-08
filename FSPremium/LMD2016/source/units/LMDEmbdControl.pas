unit LMDEmbdControl;
{$I LMDCmps.inc}

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

LMDEmbdControl unit (VO)
------------------------

Support for using VCL controls 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Graphics, Controls, StdCtrls, Types, Classes,
  LMDText, LMDWriter;

type

  { ******************************** TLMDEmbdControl ******************************}
  TLMDEmbdControl = class(TLMDPieceOfText)
  private
    FHeight             : string;
    FWidth              : string;
    FControlClass       : string;
    FControlName        : string;
    FControlText        : string;
    FControlCaption     : string;
    FControl            : TControl;
    FOwner              : TControl;
    FEventHandler       : TLMDEmbdControlEvent;
    function  GetHeight: LongInt;
    function  GetWidth: LongInt;
    function  GetParentControl : TWinControl;
    procedure GetOwnerControl;
    procedure SetControlPos(AX, AY : LongInt);
    procedure SetControlSize;
    procedure CreateControl;
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect; aDefFont:
      TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(aParent: TLMDParsedTextList; aClass, aName: string;
      aWidth, aHeight: string; aEventHandler : TLMDEmbdControlEvent);
    destructor Destroy; override;
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint; aDefFont:
      TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    procedure Store(AWriter : TLMDWriter); override;
    property Width: LongInt read GetWidth;
    property Height: LongInt read GetHeight;
    property ControlClass : string read FControlClass;
    property ControlName : string read FControlName write FControlName;
    property ControlText : string read FControlText write FControlText;
    property ControlCaption : string read FControlCaption write FControlCaption;
  end;

implementation
uses
  Sysutils;

  { ********************************* TLMDEmbdControl *******************************}
{------------------------------------------------------------------------------}

function TLMDEmbdControl.GetHeight: LongInt;
begin
  if FHeight = '' then result := 1
  else result := StrToInt(FHeight);
end;

{------------------------------------------------------------------------------}

function TLMDEmbdControl.GetWidth: LongInt;
begin
  if FWidth = '' then result := 1
  else result := StrToInt(FWidth);
end;
{------------------------------------------------------------------------------}

function TLMDEmbdControl.GetParentControl : TWincontrol;
var
  P : TLMDBaseText;
begin
//  result := nil;
  P := self;
  repeat
    result := P.ParentControl;
    if assigned(result) then Exit;
    P := P.parent;
  until not assigned(P);
end;

{------------------------------------------------------------------------------}

procedure TLMDEmbdControl.GetOwnerControl;
var
  P : TLMDBaseText;
begin
  FOwner := nil;
  P := self;
  repeat
    FOwner := P.OwnerControl;
    if assigned(FOwner) then Exit;
    P := P.parent;
  until not assigned(P);
end;

{------------------------------------------------------------------------------}

procedure TLMDEmbdControl.SetControlPos(AX, AY : LongInt);
var
  P : TPoint;
begin
  if not assigned(FOwner) then GetOwnerControl;
  if not assigned(FOwner) then Exit;
  P := FControl.Parent.ScreenToClient(FOwner.ClientToScreen(Point(Ax, Ay)));
  FControl.Left := P.X;
  FControl.Top := P.Y;
end;

{------------------------------------------------------------------------------}

procedure TLMDEmbdControl.SetControlSize;
begin
  if Width = 1 then
    if (FControl is TCustomEdit) then FWidth := '100'
    else if (FControl is TButton) then FWidth := '50'
      else FWidth := '13';
  if Height = 1 then
    if (FControl is TCustomEdit) then FHeight := '13'
    else FHeight := '20';

    FControl.Width := Width;
    FControl.Height := Height;
end;

{------------------------------------------------------------------------------}
procedure TLMDEmbdControl.CreateControl;
var
  lParent : TWinControl;
begin
  if assigned(FControl) then Exit;
  lParent := GetParentControl;
  GetOwnerControl;
  if assigned(lParent) and assigned(GetClass(FControlClass)) then begin
    FControl := TControlClass(GetClass(FControlClass)).Create(FOwner);
    FControl.Name := FControlName;
    FControl.Visible := False;
    FControl.Parent := lParent;
    SetControlSize;
    if assigned(FEventHandler) then FEventHandler(Self, FControl, FControlName);
    if (FControl is TButton) and (FControlCaption <> '') then TButton(FControl).caption := FControlCaption;
  end;
end;

{ ********************************** Public ***********************************}

constructor TLMDEmbdControl.Create(aParent: TLMDParsedTextList; aClass, aName: string;
      aWidth, aHeight: string; aEventHandler : TLMDEmbdControlEvent);
begin
  inherited Create(aParent);
  FHeight := aHeight;
  FWidth  := aWidth;
  FControlClass := aClass;
  FControlName := aName;
  FEventHandler := aEventHandler;
  FControl := nil;
  FOwner := nil;
  RegisterClasses([TEdit, TButton, TCheckBox, TRadioButton]);
end;

{------------------------------------------------------------------------------}

destructor TLMDEmbdControl.Destroy;
begin
  if assigned(FControl) and assigned(FControl.Parent) then
    FControl.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDEmbdControl.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean);
begin
  if aMask then
    aCanvas.Brush.Color:= clWhite
  else
    aCanvas.Brush.Color:= aBkColor;

  CreateControl;
  if assigned(FControl) then begin
    SetControlPos(aRect.Left+aOffset.x, aRect.Top+aOffset.y);
    FControl.Visible := True;
  end
  else begin
    aCanvas.FillRect(Rect(aRect.Left+aOffset.x, aRect.Top+aOffset.y,
      aRect.Left+aOffset.x+Width, aRect.Top+aOffset.y+Height));
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDEmbdControl.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := True;
end;

procedure TLMDEmbdControl.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
    aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
begin
  CreateControl;
  if assigned(FControl) then begin
    FClientWidth := FControl.Width;
    FClientHeight := FControl.Height;
  end
  else begin
    FClientWidth := 0;
    FClientHeight := 0;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEmbdControl.Store(AWriter : TLMDWriter);
//var
//  I : LongInt;
begin
  AWriter.WriteEmbdControl(FControlClass, FControlName, Height, Width);
end;

end.
