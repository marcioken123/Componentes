unit LMDDrawEdge;
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

LMDDrawEdge unit ()
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, LMDGraph, LMDBaseGraphicControl;

type
  TLMDDiagonalStyle=(dsEndBottomLeft, dsEndBottomRight, dsEndTopLeft, dsEndTopRight);
  TLMDDrawEdgeStyle=(esEdge, esDiagonal, esStandard);

  TLMDDrawEdge = class(TLMDBaseGraphicControl)
  private
    FDiagonal:TLMDDiagonalStyle;
    FEdgeStyle:TLMDEdgeStyle;
    FFilled:Boolean;
    FFrame:TLMDFrameSides;
    FShape:TLMDBorderStyle;
    FSoft:Boolean;
    FStyle:TLMDDrawEdgeStyle;
    procedure SetBoolean(Index:Integer; aValue:Boolean);
    procedure SetDiagonal(aValue:TLMDDiagonalStyle);
    procedure SetEdgeStyle(aValue:TLMDEdgeStyle);
    procedure SetFrame(aValue: TLMDFrameSides);
    procedure SetStyle(aValue: TLMDDrawEdgeStyle);
    procedure SetShape(aValue: TLMDBorderStyle);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property About;
    property Align;
    property DiagonalStyle:TLMDDiagonalStyle read FDiagonal write SetDiagonal default dsEndBottomLeft;
    property EdgeStyle:TLMDEdgeStyle read FEdgestyle write SetEdgeStyle default etEtched;
    property Enabled;
    property Filled:Boolean index 0 read FFilled write SetBoolean default false;
    property FrameSides:TLMDFrameSides read FFrame write SetFrame default
                        [fsBottom, fsLeft, fsRight, fsTop];
    property ParentShowHint;
    property StandardStyle:TLMDBorderStyle read FShape write SetShape default lsSingleLowered;
    property ShowHint;
    property Soft:Boolean index 1 read FSoft write SetBoolean default false;
    property Style: TLMDDrawEdgeStyle read FStyle write SetStyle default esEdge;
    property Visible;

    property Anchors;
    property Constraints;

    { events }
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

  end;

implementation
uses
  Windows, Controls,
  LMDUtils, LMDGraphUtils;

{--------------------------- Private ------------------------------------------}
procedure TLMDDrawEdge.SetDiagonal(aValue:TLMDDiagonalStyle);
begin
  if aValue<>FDiagonal then
    begin
      FDiagonal:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDrawEdge.SetEdgeStyle(aValue:TLMDEdgeStyle);
begin
  if aValue<>FEdgeStyle then
    begin
      FEdgeStyle:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDrawEdge.SetFrame(aValue: TLMDFrameSides);
begin
  if aValue<>FFrame then
    begin
      FFrame:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDrawEdge.SetBoolean(Index:Integer; aValue:Boolean);
begin
  case Index of
    0:if aValue=FFilled then exit else FFilled:=aValue;
    1:if aValue=FSoft then exit else FSoft:=aValue;
  end;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDDrawEdge.SetStyle(aValue: TLMDDrawEdgeStyle);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDrawEdge.SetShape(aValue: TLMDBorderStyle);
begin
  if aValue<>FShape then
    begin
      FShape:=aValue;
      Invalidate;
    end;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDDrawEdge.Paint;
var
  edge, flags:LongInt;
  aRect:TRect;

begin
  flags:=0;
  edge:=0;

  aRect:=ClientRect;

  if FSoft then flags:=BF_SOFT;
  if FFilled then flags:=flags or BF_MIDDLE;

  if FStyle<>esStandard then
    case FEdgeStyle of
      etRaisedInner:edge:=BDR_RAISEDINNER;
      etRaisedOuter:edge:=BDR_RAISEDOUTER;
      etSunkenInner:edge:=BDR_SUNKENINNER;
      etSunkenOuter:edge:=BDR_SUNKENOUTER;
      etBump:edge:=EDGE_BUMP;
      etEtched:edge:=EDGE_ETCHED;
      etRaised:edge:=EDGE_RAISED;
      etSunken:edge:=EDGE_SUNKEN;
    end;

  case FStyle of
    esEdge:
      begin
        if fsBottom in FFrame then flags:=flags or BF_BOTTOM;
        if fsTop in FFrame then flags:=flags or BF_TOP;
        if fsRight in FFrame then flags:=flags or BF_RIGHT;
        if fsLeft in FFrame then flags:=flags or BF_LEFT;
        DrawEdge(Canvas.Handle, aRect, edge, flags);
      end;
    esDiagonal:
      begin
        case FDiagonal of
          dsEndBottomLeft:flags:=flags or BF_DIAGONAL_ENDBOTTOMLEFT;
          dsEndBottomRight:flags:=flags or BF_DIAGONAL_ENDBOTTOMRIGHT;
          dsEndTopLeft:flags:=flags or BF_DIAGONAL_ENDTOPLEFT;
          dsEndTopRight:flags:=flags or BF_DIAGONAL_ENDTOPRIGHT;
        end;
        DrawEdge(Canvas.Handle, aRect, edge, flags);
      end;
    esStandard:
      LMDDrawStdFrame(Canvas, aRect, FShape, flags);
  end;

end;

{--------------------------- Public -------------------------------------------}
constructor TLMDDrawEdge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable]; 
  FDiagonal:=dsEndBottomLeft;
  FEdgestyle:=etEtched;
  FFrame:=[fsBottom, fsLeft, fsRight, fsTop];
  FShape:=lsSingleLowered;
  FStyle:=esEdge;
  FSoft:=False;
  FFilled:=False;
  Width := 40;
  Height := 40;
end;

end.

