unit LMDTextCheckBox;
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

LMDTextCheckBox unit ()
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Classes,
  Windows,
  Graphics,
  LMDTextObject,
  LMDText,
  LMDCustomCheckBox,
  LMD3DCaption,
  LMDGlyphTextLayout,
  LMDGraph;

type
  TLMDTextCheckBox = class (TLMDCustomCheckBox)
  private
    FText : TLMDTextObject;
    FOnGetVariable: TLMDGetVariableEvent;
    procedure SetTextObject (aValue : TLMDTextObject);
    //needed because text needs to be reparsed if assigned here
    procedure SetOnGetVariable (anEvent : TLMDGetVariableEvent);
  protected
    procedure DoTxtChange(Sender : TObject); override;
    function  DoGetVariable(Sender: TObject; const aVarName: string): string; virtual;
    procedure DrawFace(aCanvas: TCanvas; const aString:String;
                       Effects:TLMD3DCaption;
                       aDest: TRect; srcCanvas: TCanvas; var srcRect:TRect;
                       aMaskCanvas: TCanvas; TransColor:TColor;
                       aLayout: TLMDGlyphTextLayout; MultiLine, Accel,
                       Transparent:Boolean; ExtFlags:TLMDDrawTextStyles;
                       flags:LongInt); override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Checked;
    property TextSettings : TLMDTextObject read FText write SetTextObject;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write SetOnGetVariable;
    property State;
  end;

implementation

uses
  SysUtils,
  LMDProcs;
{ ************************ class TLMDTextCheckBox **************************** }
{ -------------------------------- private ----------------------------------- }
procedure TLMDTextCheckBox.SetTextObject (aValue : TLMDTextObject);
begin
  FText.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCheckBox.SetOnGetVariable (anEvent : TLMDGetVariableEvent);
begin
  FOnGetVariable := anEvent;
  DoTxtChange (self);
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDTextCheckBox.DoTxtChange (Sender : TObject);
begin
  FText.Parse (Caption + #10);
  CorrectBounds;
  if not AutoSize then Invalidate; //otherwise CorrectBounds will do that
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextCheckBox.DoGetVariable(Sender: TObject; const aVarName: string): string;
begin
  result := '';
  if Assigned (FOnGetVariable) then result := FOnGetVariable (self, aVarName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextCheckBox.DrawFace (aCanvas: TCanvas; const aString:String;
                    Effects:TLMD3DCaption;
                    aDest: TRect; srcCanvas: TCanvas; var srcRect:TRect;
                    aMaskCanvas: TCanvas; TransColor:TColor;
                    aLayout: TLMDGlyphTextLayout; MultiLine, Accel,
                    Transparent:Boolean; ExtFlags:TLMDDrawTextStyles;
                    flags:LongInt);
var
  myFont: TFont;
begin
  myFont := TFont.Create;
  try
    myFont.Assign(self.Font);
    myFont.Color := GetThemedTextColor;
    Canvas.Font  := myFont;

    FItemPositions := FText.Render(aCanvas, Effects, myFont, aDest, srcCanvas,
                           srcRect, aMaskCanvas, Color, TransColor, aLayout,
                           AutoSize{false} {AutoSize}, MultiLine, Transparent,
                           ExtFlags, flags);

    srcRect := FItemPositions.CompleteRect;
    if not (dtCalculate in ExtFlags) then
    begin
      if dtRectText in ExtFlags then srcRect := FItemPositions.TextRect;
      if dtRectGlyph in ExtFlags then srcRect := FItemPositions.GlyphRect;
      //InflateRect (srcRect, 1, 1);
      //if dtRectGlyphText in ExtFlags then srcRect := FItemPositions.CompleteRect;
    end;
    {if dtCalculate in ExtFlags then
      InflateRect (srcRect, 1, 1);}
  finally
    myFont.Free;
  end;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDTextCheckBox.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);
  FText := TLMDTextObject.Create;
  FText.OnChange := DoTxtChange;
  FText.OnGetVariable := DoGetVariable;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextCheckBox.Destroy;
begin
  FreeAndNil(FText);
  inherited Destroy;
end;

end.
