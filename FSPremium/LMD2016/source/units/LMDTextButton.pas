unit LMDTextButton;
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

LMDTextButton unit (JH)
-----------------------

Button component which displays formatted text 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Classes, Messages, Controls,
  LMDCustomButton, LMDText, LMDTextObject;

type
  TLMDTextButton = class (TLMDCustomButton)
  private
    FText : TLMDTextObject;
    FWordWrap: Boolean;
    FOnGetVariable: TLMDGetVariableEvent;
    procedure SetTextObject (aValue : TLMDTextObject);
    procedure CMTEXTCHANGED (var Msg : TMessage); message CM_TEXTCHANGED;
  protected
    function DoGetVariable(Sender: TObject; const aVarName: string): string; virtual;
    procedure DrawCaptionAndGlyph (aCanvas: TCanvas;aRect: TRect; flags: LongInt); override;
    procedure DoTxtChange (Sender: TObject);
    public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    published
    property TextSettings : TLMDTextObject read FText write SetTextObject;
    property DropDownMenu;
    property DropDownIndent;
    property DropDownRight;
    property OnDropDown;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;
  end;

implementation
uses
  SysUtils,
  LMDGlyph, LMDProcs, LMDGraph;

{ -------------------------------- private ----------------------------------- }
procedure TLMDTextButton.SetTextObject (aValue : TLMDTextObject);
begin
  FText.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextButton.CMTEXTCHANGED (var Msg : TMessage);
begin
  DoTxtChange (self);
end;

{ --------------------------------- protected -------------------------------- }
function TLMDTextButton.DoGetVariable(Sender: TObject; const aVarName: string): string;
begin
  result := '';
  if Assigned (FOnGetVariable) then result := FOnGetVariable (self, aVarName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextButton.DrawCaptionAndGlyph (aCanvas: TCanvas;aRect: TRect; flags: LongInt);
var
  tmp : TBitmap;
  gRect: TRect;
  myFont : TFont;
begin
  tmp := nil;
  myFont := TFont.Create;
  try
    myFont.Assign (self.Font);
    //!!!!! We need to do something here for supporting a disabled look !!!!!
    if not Enabled then
      myFont.Color := clGray;

    //get the glyph (if none exists tmp will be nil)
    tmp := TBitmap.Create;
    //get rect of glyph (if one exists)
    gRect := Rect (0,0,0,0);
    if Assigned (FGlyph) then
      begin
        TLMDGlyph(FGlyph).GetStateBitmap (GetState, tmp);
        //if tmp <> nil then
        gRect := Rect (0, 0, tmp.Width, tmp.Height);
      end;

    FText.Render (aCanvas, FontFX, myFont, aRect, tmp.Canvas, gRect, nil, Color, tmp.TransparentColor,
                  ButtonLayout, false, FWordWrap, true, [TLMDDrawTextStyle(Enabled), dt3DDisabled], flags);
  finally
    if Assigned(tmp) then
      tmp.Free;
    if Assigned(myFont) then
      myFont.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextButton.DoTxtChange (Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  FText.Parse (Caption + #10);
  Invalidate;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDTextButton.Create (aOwner : TComponent);
begin
  inherited Create(aOwner);
  FWordWrap := true;
  FText := TLMDTextObject.Create;
  FText.OnChange := DoTxtChange;
  FText.OnGetVariable := DoGetVariable;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextButton.Destroy;
begin
  FText.OnChange := nil;
  FreeAndNil(FText);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextButton.Loaded;
begin
  inherited Loaded;
  DoTxtChange (nil);
end;

end.
