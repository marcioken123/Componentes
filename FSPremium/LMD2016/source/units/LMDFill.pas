unit LMDFill;
{$I lmdcmps.INC}

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

LMDFill unit (RM)
----------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes,
  LMDGraph, LMDCont, LMDFillObject, LMDCaption, LMDGraphicControl;

type
  TLMDFill = class(TLMDGraphicControl)
  private
    FCaption:TLMDCaption;
    FFillObject:TLMDFillObject;
    procedure SetCaption(aValue:TLMDCaption);
    procedure SetFillObject(aValue:TLMDFillObject);
  protected
    procedure Paint;override;
    procedure GetChange(Sender:TObject);override;
    function GetEmpty:Boolean;override;
    procedure GetIMLChange(Sender:TObject); override;
    function GetPalette:HPalette;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    property About;
    property Align;
    property Bevel;
    property Caption:TLMDCaption read FCaption write SetCaption;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FillObject:TLMDFillObject read FFillObject write SetFillObject;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}

    {4.0}
    //properties
    property Anchors;
    property BiDiMode;
    property DragKind;
    property Constraints;
    property ParentBiDiMode;
  end;

implementation

uses
  SysUtils,
  LMDCustomImageList;

{************************ Class TLMDFill **************************************}
{------------------------- Private --------------------------------------------}
Procedure TLMDFill.SetCaption(aValue:TLMDCaption);
begin
  FCaption.Assign(aValue);
end;

{------------------------------------------------------------------------------}
Procedure TLMDFill.SetFillObject(aValue:TLMDFillObject);
begin
  FFillObject.Assign(aValue);
end;

{------------------------- Protected ------------------------------------------}
Procedure TLMDFill.GetChange(Sender:TObject);
begin
 if Sender=FFillObject then
   Transparent:=FFillObject.Transparent;
 InvalidateControl;
end;

{------------------------------------------------------------------------------}
function TLMDFill.GetEmpty:Boolean;
begin
  result:=FFillObject.Empty and (BevelExt=0) and (FCaption.Caption='');
end;

{------------------------------------------------------------------------------}
procedure TLMDFill.GetIMLChange(Sender:TObject);
begin
  if not IMLEmpty then
     LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FFillObject.ListBitmap)
  else
    FFillObject.ListBitmap:=nil;
  inherited GetIMLChange(Sender);
end;

{------------------------------------------------------------------------------}
function TLMDFill.GetPalette: HPALETTE;
begin
  if not Transparent then
    Result:=FFillObject.Palette
  else
    Result := inherited GetPalette;
end;

{------------------------------------------------------------------------------}
procedure TLMDFill.Paint;
var
  aRect:TRect;

begin
  if (csLoading in ComponentState) then exit;
  if GetEmpty then
    begin
      inherited Paint;
      exit;
    end;

  try
    // 7.0 changed order
    aRect:=Bevel.PaintBevel(Canvas, GetClientRect, Transparent);
    FFillObject.ClipFill(Canvas, aRect, Color, MakeLong(Left, Top));
    FCaption.DrawCaption(Canvas, FCaption.Caption, aRect, [TLMDDrawTextStyle(Enabled), dtClip],
                         Canvas.Brush.Color, MakeLong(Left, Top));
  except
    on exception do exit;
  end;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDFill.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FCaption:=TLMDCaption.Create;
  FFillObject:=TLMDFillObject.Create;
  FCaption.OnChange:=GetChange;
  FFillObject.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDFill.Destroy;
begin
  FCaption.OnChange:=nil;
  FFillObject.OnChange:=nil;
  FCaption.Free;
  FFillObject.Free;
  inherited Destroy;
end;

end.
 
