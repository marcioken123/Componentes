unit LMDTextRadioButton;
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

LMDTextRadioButton unit (JH)
----------------------------

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
  LMDRadioButton,

  LMD3DCaption,
  LMDGlyphTextLayout,
  LMDGraph;

type
  TLMDTextRadioButton = class (TLMDRadioButton)
  private
    FText         : TLMDTextObject;

    FOnGetVariable: TLMDGetVariableEvent;

    procedure SetTextObject (aValue : TLMDTextObject);
  protected
    procedure DoTxtChange (Sender : TObject); override;
    function DoGetVariable(Sender: TObject; const aVarName: string): string; virtual;
    procedure DrawFace (aCanvas: TCanvas; const aString:String;
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
    property TextSettings : TLMDTextObject read FText write SetTextObject;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;
  end;

implementation

uses
  SysUtils,
  LMDProcs;

{ -------------------------------- private ----------------------------------- }
procedure TLMDTextRadioButton.SetTextObject (aValue : TLMDTextObject);
begin
  FText.Assign (aValue);
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDTextRadioButton.DoTxtChange (Sender : TObject);
begin
  FText.Parse (Caption);
  CorrectBounds;
  if not AutoSize then Invalidate;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextRadioButton.DoGetVariable(Sender: TObject; const aVarName: string): string;
begin
  result := '';
  if Assigned (FOnGetVariable) then result := FOnGetVariable (self, aVarName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextRadioButton.DrawFace (aCanvas: TCanvas; const aString:String;
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
                           false {AutoSize}, true {wordwrap}, Transparent, ExtFlags, flags);
    srcRect := FItemPositions.CompleteRect;
    if not (dtCalculate in ExtFlags) then
    begin
      if dtRectText in ExtFlags then srcRect := FItemPositions.TextRect;
      if dtRectGlyph in ExtFlags then srcRect := FItemPositions.GlyphRect;
      //InflateRect (srcRect, 1, 1);
      //if dtRectGlyphText in ExtFlags then srcRect := FItemPositions.CompleteRect;
    end;
  finally
    myFont.Free;
  end;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDTextRadioButton.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);
  FText := TLMDTextObject.Create;
  FText.OnChange := DoTxtChange;
  FText.OnGetVariable := DoGetVariable;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextRadioButton.Destroy;
begin
  FreeAndNil(FText);
  inherited Destroy;
end;

end.
