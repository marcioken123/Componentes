unit LMDPanelShape;
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

LMDPanelShape unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Windows,
  Messages,
  LMDRegion,
  LMDCustomPanelFill;

type
  { -------------------------------------------------------------------------- }
  TLMDPanelShape = class (TLMDCustomPanelFill)
  private
    FRegion      : TLMDBorderRegion;
    FUseRgnBitmap: Boolean;
    FOnDrawBorder: TLMDBorderDrawEvent;

    procedure SetUseBitmap (aValue : Boolean);
    procedure SetRegion (aValue : TLMDBorderRegion);

    procedure WMSize (var Msg : TWMSize); message WM_SIZE;
  protected
    procedure CreateBack(aValue:Boolean); override;
    public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Loaded; override;
    procedure GetChange (Sender : TObject); override;
    function GetEmpty : boolean; override;
    published
    property About;
    property Align;
    property BackFX;
    property Caption;
    property Color;
    property Cursor;
    property DragCursor;
    property DragMode;
    property FillObject;
    property Font;
    property FontFX;
    property Hint;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property Locked;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property QuickDraw;
    property ShowHint;
    property Region : TLMDBorderRegion read FRegion write SetRegion;
    property TabOrder;
    property TabStop;
    property Transparent;
    property UseRgnBitmap : Boolean read FUseRgnBitmap write SetUseBitmap default true;
    property Visible;

    property OnDrawBorder: TLMDBorderDrawEvent read FOnDrawBorder write FOnDrawBorder;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseExit;
    property OnMouseEnter;
    property OnKeyDown;
    property OnKeyUp;
    property OnStartDrag;
    property OnEndDrag;
    property OnDragOver;
    property OnClick;
    property OnDblClick;
    property OnResize;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}    
  end;

implementation

uses
  Types, Graphics,
  LMDGraph;

{ @@@@@@@@@@@@@@@@@@@@@@@@@@@ TLMDPanelShape @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ }
{ --------------------------- private ---------------------------------------- }
procedure TLMDPanelShape.SetRegion (aValue : TLMDBorderRegion);
begin
  FRegion.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPanelShape.SetUseBitmap (aValue : Boolean);
begin
  if aValue <> FUseRgnBitmap then
    begin
      FUseRgnBitmap := aValue;
      if FUseRgnBitmap then
        FillObject.Style := sfNone;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPanelShape.CreateBack(aValue:Boolean);
begin
  if (csLoading in ComponentState) then exit;
  if (FRegion.Shape <> rsBitmap) or (not FUseRgnBitmap) then
    inherited CreateBack (aValue)
  else
    begin
      if FBack=nil then FBack:=TBitmap.Create;
      FBack.Assign (FRegion.Mask.BorderBmp);
      FillObject.FillCanvas(FBack.Canvas, Rect(0,0, FBack.Width, FBack.Height), Color);
    end;
  //DrawBack(FBack.Canvas, Rect(0,0, FBack.Width, FBack.Height));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPanelShape.WMSize (var Msg : TWMSize);
begin
  inherited;
  FRegion.CreateRegion (ClientRect);
  FRegion.SetRegion;
  Invalidate;
end;

{ -------------------------- public ------------------------------------------ }
constructor TLMDPanelShape.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FRegion := TLMDBorderRegion.Create;
  FRegion.Owner := self;
  FRegion.OnChange := GetChange;
  FUseRgnBitmap := true;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPanelShape.Destroy;
begin
  FRegion.FreeRegion;
  FRegion.OnChange := nil;
  FRegion.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPanelShape.Loaded;
begin
  inherited Loaded;
  GetChange (FRegion);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPanelShape.Paint;
var
  aRect : TRect;
begin
  if csDestroying in ComponentState then Exit;
  if csLoading in ComponentState then exit;
  if not HandleAllocated then exit;
//  SelectClipRgn (Canvas.Handle, FRegion.Handle);
  inherited Paint;
//  SelectClipRgn (Canvas.Handle, 0);
  aRect := ClientRect;
  InflateRect (aRect, -2, -2);
  if (FRegion.Shape = rsUserRegion) and Assigned (FOnDrawBorder) then
    FOnDrawBorder (self, Canvas, aRect)
  else
    FRegion.PaintRegionShape (Canvas, aRect);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPanelShape.GetEmpty:Boolean;
begin
  result:=(FRegion.Border.Style = rbNone);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPanelShape.GetChange (Sender : TObject);
begin
  inherited GetChange (Sender);
  if Sender is TLMDBorderRegion then
    begin
      FRegion.CreateRegion (ClientRect);
      FRegion.SetRegion;
    end;
end;

end.
