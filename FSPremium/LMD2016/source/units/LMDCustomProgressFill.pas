unit LMDCustomProgressFill;
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

LMDCustomProgressFill unit (RM)
------------------------------


Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, LMDGraph, LMDFillObject, LMDBaseMeter;

type

  {-------------------------- TLMDProgressFill --------------------------------}
  TLMDCustomProgressFill = class(TLMDBaseMeter)
  private
    FBar3D:TLMDBorderStyle;
    FBack:TColor;
    FFillObject:TLMDFillObject;
    procedure SetBar3D(aValue:TLMDBorderStyle);
    procedure SetBack(aValue:TColor);
    procedure SetFillObject(aValue:TLMDFillObject);
  protected
    procedure DrawBar(aCanvas:TCanvas; dest, notDest, aRect:TRect);override;
    procedure GetIMLChange(Sender:TObject); override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    property About;
    property Align;
    property Alignment;
    property Bar3D:TLMDBorderStyle read FBar3D write SetBar3D default lsNone;
    property Bevel;
    property BrushBackColor:TColor read FBack write SetBack default clBtnFace;
    property Color;
    property Caption;
    property Direction;
    property Delta;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FillObject:TLMDFillObject read FFillObject write SetFillObject;
    property Font;
    property Font3D;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property MaxValue;
    property MinValue;
    property OptionsText;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property UseFontColor;
    property Visible;

    {Events}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    {3.0}
    property OnMouseEnter;
    property OnMouseExit;
    {---}
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
  Controls,
  LMDCont, LMDUtils, LMDGraphUtils, LMDCustomImageList;

{************************ Class TLMDCustomProgressFill ************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDCustomProgressFill.SetBar3D(aValue: TLMDBorderStyle);
begin
  if FBar3D<>aValue then
    begin
      FBar3D:=aValue;
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomProgressFill.SetBack(aValue: TColor);
begin
  if FBack<>aValue then
    begin
      FBack:=aValue;
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomProgressFill.SetFillObject(aValue: TLMDFillObject);
begin
  FFillObject.Assign(aValue);
end;

{-------------------------------- Protected -----------------------------------}
procedure TLMDCustomProgressFill.DrawBar(aCanvas:TCanvas; dest, notDest, aRect:TRect);
begin
  FFillObject.ClipFill(aCanvas, dest, FBack, 0);
  if Position>0 then LMDDrawStdFrame(aCanvas, dest, FBar3D, 0);
  // 5.02 changed on user request (RM)
  case FillObject.Style of
    sfGradient, sfBitmap, sfBitmapList, sfBrushBitmap:
      DrawCaption(aCanvas, dest, notDest, aRect, false, clBlack);
  else
    DrawCaption(aCanvas, dest, notDest, aRect, True, FFillObject.Brush.Color);
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomProgressFill.GetIMLChange(Sender:TObject);
begin
  if not IMLEmpty then
    LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FFillObject.ListBitmap)
  else
    FFillObject.ListBitmap:=nil;
  inherited GetIMLChange(Sender);
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDCustomProgressFill.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FFillObject:=TLMDFillObject.Create;
  FFillObject.OnChange:=GetChange;
  FBack:=clBtnFace;
  FBar3D:=lsNone;
  ControlStyle := ControlStyle + [csReplicatable];
end;

{------------------------------------------------------------------------------}
Destructor TLMDCustomProgressFill.Destroy;
begin
  FFillObject.OnChange:=nil;
  FFillObject.Free;
  inherited Destroy;
end;

end.
 
