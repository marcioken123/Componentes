unit LMDTextSpeedButton;
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

LMDTextSpeedButton unit (JH)
----------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDButtonBase,
  LMDBaseGraphicButton,
  LMDCustomSpeedButton,
  LMDTextObject,
  LMDText;

type
  TLMDTextSpeedButton = class(TLMDCustomSpeedButton)
  private
    FText : TLMDTextObject;
    //FOnLinkClick: TLMDLinkClickEvent;
    FOnGetVariable: TLMDGetVariableEvent;

    procedure SetTextObject (aValue : TLMDTextObject);
    procedure CMTextChanged(var Message:TMessage);message CM_TEXTCHANGED;
  protected
    procedure DrawGlyphAndText(aCanvas: TCanvas; aRect: TRect); override;
    function  DoGetVariable(Sender: TObject; const aVarName: string): string; virtual;
    procedure DoTxtChange(Sender: TObject);
    public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    published
    property Align;
    property ButtonStyle;
    property AllowAllUp;
    property GroupIndex;
    property MultiLine;
    property Pressed;
    property DropDownCombo;
    property DropDownComboWidth;
    property DropDownMenu;
    property DropDownIndent;
    property DropDownRight;
    property TextSettings : TLMDTextObject read FText write SetTextObject;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;
  end;

implementation

uses
  LMDGlyph,
  LMDGraph;

{ -------------------------------- private ----------------------------------- }
procedure TLMDTextSpeedButton.SetTextObject (aValue : TLMDTextObject);
begin
  FText.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextSpeedButton.CMTextChanged(var Message:TMessage);
begin
  DoTxtChange(self);
  inherited;
end;

{ --------------------------------- protected -------------------------------- }
function TLMDTextSpeedButton.DoGetVariable(Sender: TObject; const aVarName: string): string;
begin
  result := '';
  if Assigned (FOnGetVariable) then result := FOnGetVariable (self, aVarName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextSpeedButton.DrawGlyphAndText(aCanvas: TCanvas; aRect: TRect);
var
  flags : Longint;
  gRect : TRect;
  tmp   : TBitmap;
  myFont: TFont;
begin
  tmp    := nil;
  myFont := TFont.Create;
  try
    myFont.Assign(self.Font);
    myFont.Color := GetThemedTextColor;
    aCanvas.Font := myFont;

    if (FState in [bsMouseOver, bsOptionSet, bsDown, bsDragOver, bsDropDownOpen])
       and AllowMouseOver and EnterColorChange then
      myFont.Color := EnterColor;

    {$IFNDEF LMDCOMP3}
    flags := DrawTextBiDiModeFlags(0);
    {$ELSE}
    flags := 0;
    {$ENDIF}

    //!!!!! We need to do something here for supporting a disabled look !!!!!
    //    if not Enabled then
    //      myFont.Color := clGray;

    //get the glyph (if none exists tmp will be nil)
    tmp := TBitmap.Create;
    //get rect of glyph (if one exists)
    TLMDGlyph(FGlyph).GetStateBitmap(FState, tmp);
    gRect := Rect(0,0,0,0);
    if tmp <> nil then
      gRect := Rect(0, 0, tmp.Width, tmp.Height);

    FText.Render(aCanvas, FontFX, myFont, aRect, tmp.Canvas, gRect, nil, Color, tmp.TransparentColor,
                 ButtonLayout, false, true, true, [TLMDDrawTextStyle(Enabled), dt3DDisabled], flags);
  finally
    if Assigned (tmp) then
      tmp.Free;
    myfont.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextSpeedButton.DoTxtChange (Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  FText.Parse (Caption + #10);
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDTextSpeedButton.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);

  FText := TLMDTextObject.Create;
  //FText.OnLinkClick := DoLinkClick;
  //FText.OnGraphicError := DoGraphicError;
  FText.OnChange := DoTxtChange;
  FText.OnGetVariable := DoGetVariable;

end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextSpeedButton.Destroy;
begin
  FText.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextSpeedButton.Loaded;
begin
  inherited Loaded;
  DoTxtChange (nil);
end;

end.
