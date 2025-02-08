unit LMDCaret;
{$I lmdcmps.Inc}

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

LMDCaret unit (JH)
------------------
Wrapper for the facilities of the windows caret object.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, ImgList, Types,
  LMDObject, LMDGraph, LMDCont, LMDUtils, LMDCustomControl, LMDCustomImageList;

type
  TLMDCaretStyles = (csDefault, csBlock, csUnder, csOver, csBitmap, csUnderBlock);
  TLMDCaretBitmap = (cbBmpSize, cbTile, cbStretch);

  TLMDCaret = class(TLMDObject)
  private
    FPos           : TPoint;
    FHBmp,
    FBitmap        : Graphics.TBitmap;
    FImageList     : TCustomImageList;
    FFontHeight,
    FOldBlinkRate,
    FWidth,
    FHeight,
    FImageIndex,
    FListIndex,
    FBlinkRate     : Word;
    FStyle         : TLMDCaretStyles;
    FOwner         : TLMDCustomControl;
    FCanEnable,
    FCreated,
    FEnabled       : Boolean;
    FCaretBmp      : TLMDCaretBitmap;
    function GetPos(Index:Integer):Integer;
    procedure SetPos (Index, aValue : Integer);
    procedure SetStyle (aValue : TLMDCaretStyles);
    procedure SetWord (Index : Integer; aValue : Word);
    procedure SetImageList (aValue : TCustomImageList);
    procedure SetBitmap (aValue:Graphics.TBitmap);
  public
    //CreateExt instead of Create (to make the comiler happy ...)
    constructor CreateExt (Owner : TLMDCustomControl);
    procedure BuildCaret;
    procedure DestroyCaret;
    destructor Destroy; override;
    procedure Assign (Source : TPersistent); override;
    procedure GetIMLChange (Sender : TObject);
    procedure Enable;
    procedure Disable;

    procedure SetCaretPos (X, Y: Integer);

    property FontHeight : Word index 4 read FFontHeight write SetWord;
    property Enabled : Boolean read FEnabled default false;
    //RM
    property Row:Integer index 0 read GetPos write SetPos;
    property Col:Integer index 1 read GetPos write SetPos;
    //---
  published
    property BlinkRate : Word read FBlinkRate write FBlinkRate;
    property Style : TLMDCaretStyles read FStyle write SetStyle default csDefault;
    property Width : Word index 0 read FWidth write SetWord default 2;
    property Height : Word index 1 read FHeight write SetWord default 10;
    property ImageList : TCustomImageList read FImageList write SetImageList;
    property ImageIndex : Word index 2 read FImageIndex write SetWord default 0;
    property ListIndex : Word index 3 read FListIndex write SetWord default 0;
    property CaretBmpMode : TLMDCaretBitmap read FCaretBmp write FCaretBmp default cbBmpSize;
    property Bitmap : Graphics.TBitmap read FBitmap write SetBitmap;
    property CanEnable: Boolean read FCanEnable write FCanEnable default true;
  end;

implementation
uses
  LMDGraphUtils;
{ -------------------------------- private ----------------------------------- }
// RM
function TLMDCaret.GetPos(Index:Integer):Integer;
begin
  case index of
    0: result:=FPos.Y;
    1: result:=FPos.X;
  else
    result:=0;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.SetPos(Index, aValue : Integer);
begin
  case Index of
    0: FPos.Y := aValue;
    1: FPos.X := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.SetWord (Index : Integer; aValue : Word);
begin
  case Index of
    0 : if FWidth <> aValue then
          FWidth := aValue;
    1 : if FHeight <> aValue then
          FHeight := aValue;
    2 : FImageIndex := aValue;
    3 : FListIndex := aValue;
    4 : FFontHeight := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.SetImageList (aValue : TCustomImageList);
begin
  // ToDo RM --> That's quite dangerous...
  FImageList := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.SetBitmap (aValue : Graphics.TBitmap);
begin
  if FBitmap = nil then
    FBitmap := Graphics.TBitmap.Create;
  FBitmap.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.SetStyle (aValue : TLMDCaretStyles);
begin
  FStyle := aValue;
end;

{ -------------------------------- public ------------------------------------ }
procedure TLMDCaret.Enable;
begin
  if csDesigning in FOwner.ComponentState then exit;
  if not FCanEnable then exit;
  FEnabled := true;
  if not FCreated then
    begin
      FCreated := true;
      BuildCaret;
    end;
  SetCaretBlinkTime (FBlinkRate);
  ShowCaret (FOwner.Handle);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.Disable;
begin
  FEnabled := false;
  HideCaret (FOwner.Handle);
  SetCaretBlinkTime (FOldBlinkRate);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.SetCaretPos (x, y: Integer);
begin
  if FOwner.Focused then
    Windows.SetCaretPos (x, y);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDCaret.CreateExt(Owner : TLMDCustomControl);
begin
  inherited Create;
  FOwner    := Owner;
  FWidth    := 2;
  FHeight   := 10;
  FBitmap   := nil;
  FCreated  := false;
  FOldBlinkRate := GetCaretBlinkTime;
  FBlinkRate := FOldBlinkRate;
  FEnabled := false;
  FCaretBmp := cbBmpSize;
  FCanEnable := true;
  FBitmap := Graphics.TBitmap.Create;
  FHBmp := nil;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCaret.Destroy;
begin
  DestroyCaret;
  SetCaretBlinkTime (FOldBlinkRate);
  if Assigned (FHBmp) then FHBmp.Free;
  if FBitmap <> nil then
    FBitmap.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.Assign (Source : TPersistent);
begin
  if Source = self then exit;
  if (Source is TLMDCaret) then
    with Source as TLMDCaret do
      begin
        FBlinkRate := BlinkRate;
        FWidth := Width;
        FHeight := Height;
        FStyle := Style;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.GetIMLChange (Sender : TObject);
begin
  if FBitmap = nil then
    FBitmap := Graphics.TBitmap.Create;
  LMDIMLItemBitmap(FImageList, FListIndex, FImageIndex, FBitmap);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.BuildCaret;
begin
  case FStyle of
    csDefault : CreateCaret (FOwner.Handle, 0, 1, FFontHeight);
    csBlock : CreateCaret (FOwner.Handle, 0, FWidth, FHeight);
    csOver : CreateCaret (FOwner.Handle, 0, FWidth, 1);
    csUnder : CreateCaret (FOwner.Handle, 0, FWidth, 1);
    csUnderBlock : CreateCaret (FOwner.Handle, 0, FWidth, FHeight);
    csBitmap : begin
                 case FCaretBmp of
                   cbBmpSize : CreateCaret (FOwner.Handle, FBitmap.Handle, 0, 0);
                   cbTile : begin
                              DestroyCaret;  //added 17/07/00 JH - fixing res. leak Win 98
                              if Assigned (FHBmp) then
                                begin
                                  FHBmp.Free;
                                  FHBmp:=nil;
                                end;
                              FHBmp := Graphics.TBitmap.Create;
                              FHBmp.Height := FHeight;
                              FHBmp.Width := FWidth;

                              LMDBmpDraw(FHBmp.Canvas, Rect(0,0,FWidth,FHeight), FBitmap, DSF_TILE, clBlack);
                              CreateCaret (FOwner.Handle, FHBmp.Handle, 0, 0);
                            end;
                 cbStretch: begin
                               DestroyCaret; //added 17/07/00 JH - fixing res. leak Win 98
                               if Assigned (FHBmp) then
                                 FHBmp.Free;
                               FHBmp := Graphics.TBitmap.Create;
                               FHBmp.Height := FHeight;
                               FHBmp.Width := FWidth;
                               LMDBmpDraw(FBitmap.Canvas, Rect(0,0,FWidth,FHeight), FHBmp,DSF_STRETCH, clBlack);
                               CreateCaret (FOwner.Handle, FHBmp.Handle, 0, 0);
                            end;
                 end; // end of case
               end; //end of csBitmap
  end; //end of case FStyle
  SetCaretBlinkTime (FBlinkRate);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaret.DestroyCaret;
begin
  if Assigned (FOwner) and (FOwner.HandleAllocated) then
    begin
      SetCaretBlinkTime (FOldBlinkRate);
      Windows.DestroyCaret;
    end;
end;

end.

