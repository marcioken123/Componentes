unit LMDCustomLImage;
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

LMDCustomLImage unit (RM)
------------------------
Image control (source of images are imagelist container)

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes,
  LMDBaseImage;

type
  {--------------------------- TLMDCustomLImage -------------------------------}
  TLMDCustomLImage = class(TLMDBaseImage)
  private
    FSilentMove:Boolean;
    procedure SetBool(index:Integer; aValue:Boolean);
  protected
    FForceTransparent:Boolean;
    function CheckOptimized:Boolean;override;
    function CorrectBounds:Boolean;override;
    function GetEmpty:Boolean;override;
    function GetPalette:HPalette;override;
    property ForceTransparent:Boolean index 0 read FForceTransparent write SetBool default false;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    function isTransparentSet: Boolean;override;

    property ImageList;
    property ImageIndex;
    property ListIndex;
    {3.10}
    property SilentMove:Boolean index 1 read FSilentMove write SetBool default false;
    property Transparent;
  published
    property Align;
    property Bevel;
    property Color;
    property DragCursor;
    property DragMode;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property QuickDraw;
    property ShowHint;
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

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation
uses
  LMDGraph, LMDCont;

{------------------------- Private---------------------------------------------}
procedure TLMDCustomLImage.SetBool(index:Integer; aValue:Boolean);
begin
  case Index of
    0: if FForceTransparent<>aValue then
         begin
           FForceTransparent:=aValue;
           InvalidateControl;
         end;
    1: if FSilentMove<>aValue then
         begin
           FSilentMove:=aValue;
           InvalidateControl;
         end;
  end;
end;

{------------------------ Protected -------------------------------------------}
function TLMDCustomLImage.CheckOptimized:Boolean;
begin
  result := inherited CheckOptimized;
  if not result and SilentMove then
    result := BackBitmapCheck;
end;

{------------------------------------------------------------------------------}
function TLMDCustomLImage.CorrectBounds:Boolean;
var
  w, h:Integer;
begin
  result:=false;
  if Style=sbAutosize then
    begin
      if GetEmpty then
        begin
          w:=20+DblBevelExt;
          h:=20+DblBevelExt;
        end
      else
        begin
          w:=LMDIMLItemWidth(ImageList, ListIndex)+DblBevelExt;
          h:=LMDIMLItemHeight(ImageList, ListIndex)+DblBevelExt;
        end;
      if (w<>Width) or (h<>Height) then
        begin
          SetBounds(Left, Top, w, h);
          result:=True;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomLImage.GetEmpty:Boolean;
begin
  result:=IMLEmpty;
end;

{------------------------------------------------------------------------------}
function TLMDCustomLImage.GetPalette: HPALETTE;
begin
  Result:=0;
  if not GetEmpty then
    result:=LMDIMLPalette(ImageList, ListIndex);
end;

{------------------------------------------------------------------------------}
{procedure TLMDCustomLImage.Invalidate;
begin
  if Transparent and CheckOptimized then
    Paint
  else
    inherited;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomLImage.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FForceTransparent:=False;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomLImage.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDCustomLImage.isTransparentSet: Boolean;
begin
  result:=inherited isTransparentSet or SilentMove;
end;

end.
