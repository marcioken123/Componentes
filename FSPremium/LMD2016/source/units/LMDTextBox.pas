unit LMDTextBox;
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

LMDTextBox unit (VO)
--------------------



ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Graphics, Types, Classes,
  LMDText, LMDWriter;

type
  { ********************************** TLMDTextBox ****************************}
  TLMDTextBox = class(TLMDParsedTextList)
  private
    FBorder     : integer;
  protected
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(aParent: TLMDParsedTextList; aBorder : integer);
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    function Clone : TLMDBaseText; override;
    procedure Store(AWriter : TLMDWriter); override;
    property Border : integer read FBorder write FBorder;
  end;

implementation

{ *********************************** TLMDTextBox *****************************}
{------------------------------------------------------------------------------}

{ *********************************** PUBLIC **********************************}

constructor TLMDTextBox.Create(aParent: TLMDParsedTextList; aBorder : integer);
begin
  inherited create(aParent);
  FBorder := aBorder;
end;

{------------------------------------------------------------------------------}

procedure TLMDTextBox.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
  aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean);
var
//  I       : LongInt;
  R       : TRect;
//  yOffset : integer;
begin

  R := GetClientRect(aCanvas, Rect(
    aRect.Left + aOffset.X, aRect.Top + aOffset.Y, aRect.Right, aRect.Bottom),
    aDefFont, aAutoSize, aWordWrap);

  if aMask then
    aCanvas.Brush.Color:= clWhite
  else
    aCanvas.Brush.Color:= aBkColor;

(*
Rect(
    aRect.Left + aOffset.X + FBorder + 1,
    aRect.Top + aOffset.Y + FBorder + 1,
    aRect.Right -  + FBorder - 1, aRect.Bottom -  + FBorder - 1),
*)
  inherited Render(aCanvas, Rect(
    aRect.Left + aOffset.X + FBorder + 1,
    aRect.Top + aOffset.Y + FBorder + 1,
    aRect.Right - FBorder - 1, aRect.Bottom - FBorder - 1
  ),Point(0,0), aDefFont, aBkColor, aAutoSize, aWordWrap, aMask);

  // draw border
  if FBorder > 0 then begin
    aCanvas.Pen.Width := FBorder;
    aCanvas.MoveTo(aRect.Left + aOffset.X, aRect.Top + aOffset.Y);
    aCanvas.LineTo(aRect.Left + aOffset.X+R.Right,aRect.Top + aOffset.Y);
    aCanvas.LineTo(aRect.Left + aOffset.X+R.Right,aRect.Top + aOffset.Y+R.Bottom);
    aCanvas.LineTo(aRect.Left + aOffset.X,aRect.Top + aOffset.Y+R.Bottom);
    aCanvas.LineTo(aRect.Left + aOffset.X,aRect.Top + aOffset.Y);
  end;

end;

{------------------------------------------------------------------------------}

procedure TLMDTextBox.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
var
//  I, Y  : LongInt;
//  R     : TRect;
  nRect : TRect;
begin
  FClientHeight := 0;
  FClientWidth  := 0;
  nRect := Rect(aDisplayRect.left+FBorder + 1, aDisplayRect.top+FBorder+1,
    aDisplayRect.right-FBorder - 1, aDisplayRect.bottom-FBorder-1);
  inherited CalcClientRect(aCanvas, nRect, aDefFont, aAutoSize, aWordWrap);
  FClientWidth := FClientWidth + 2*(FBorder+1);
  FClientHeight := FClientHeight + 2*(FBorder+1);
end;

{------------------------------------------------------------------------------}

function TLMDTextBox.Clone : TLMDBaseText;
begin
  result := inherited Clone;
  TLMDTextBox(Result).FBorder := FBorder;
end;

{------------------------------------------------------------------------------}

procedure TLMDTextBox.Store(AWriter : TLMDWriter);
begin
  inherited;
end;

end.
