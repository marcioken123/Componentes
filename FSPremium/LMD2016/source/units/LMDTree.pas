unit LMDTree;
{$I LMDCmps.inc}

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

LMDTree unit (VO)
-----------------

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Graphics, Types, Classes,
  LMDText, LMDWriter;

type
  { ********************************** TLMDTREE *******************************}
  TLMDTree = class(TLMDParsedTextList)
  private
    FOffset     : integer;
    FWidth      : integer;
    FHeight     : integer;
    FRoot       : boolean;
    function GetDataCount : LongInt;
    function GetItemCount : LongInt;
    function GetData(index : LongInt) : TLMDBaseText;
    function GetItem(index : LongInt) : TLMDTree;
  protected
    function  NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;override;
    procedure CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);override;
  public
    constructor Create(aParent: TLMDParsedTextList); overload;
    constructor Create(aParent: TLMDParsedTextList; aRoot : boolean); overload;
    procedure Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint; aDefFont:
      TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean); override;
    function Clone : TLMDBaseText; override;
    procedure Store(AWriter : TLMDWriter); override;
    property Offset : integer read FOffset write FOffset;
    property DataCount : LongInt read GetDataCount;
    property Data[index : LongInt] : TLMDBaseText read GetData;
    property ItemCount : LongInt read GetItemCount;
    property Item[index : LongInt] : TLMDTree read GetItem;
    property Root : boolean read FRoot;
  end;

implementation

{ *********************************** TLMDTREE ********************************}
{------------------------------------------------------------------------------}

function TLMDTREE.GetDataCount : LongInt;
var
  I : LongInt;
begin
  result := 0;
  for I := 0 to count-1 do
    if not(SubItem[I] is TLMDTree) or (TLMDTree(SubItem[I]).Root) then inc(result);
end;

{------------------------------------------------------------------------------}

function TLMDTREE.GetItemCount : LongInt;
var
  I : LongInt;
begin
  result := 0;
  for I := 0 to count-1 do
    if (SubItem[I] is TLMDTree) and (Not TLMDTree(SubItem[I]).Root) then inc(result);
end;

{------------------------------------------------------------------------------}

function TLMDTREE.GetData(index : LongInt) : TLMDBaseText;
var
  I, J : LongInt;
begin
  J := 0;
  result := nil;

  for I := 0 to count-1 do
    if not(SubItem[I] is TLMDTree) or TLMDTree(SubItem[I]).Root then begin
      if index = J then begin
        result := SubItem[I];
        Exit;
      end;
      inc(J);
    end;
end;

{------------------------------------------------------------------------------}

function TLMDTREE.GetItem(index : LongInt) : TLMDTree;
var
  I, J : LongInt;
begin
  J := 0;
  result := nil;

  for I := 0 to count-1 do
    if (SubItem[I] is TLMDTree) and (not TLMDTree(SubItem[I]).Root) then begin
      if index = J then begin
        result := TLMDTree(SubItem[I]);
        Exit;
      end;
      inc(J);
    end;
end;

{ *********************************** PUBLIC **********************************}

constructor TLMDTREE.Create(aParent: TLMDParsedTextList);
begin
  inherited create(aParent);
  FOffset := 10;
  FWidth  := 0;
  FHeight := 0;
  FRoot   := False;
end;

{------------------------------------------------------------------------------}

constructor TLMDTREE.Create(aParent: TLMDParsedTextList; aRoot : boolean);
begin
  Create(aParent);
  Froot := aRoot;
end;

{------------------------------------------------------------------------------}

procedure TLMDTREE.Render(aCanvas: TCanvas; const aRect: TRect; const aOffset: TPoint;
      aDefFont: TFont; aBkColor: TColor; aAutoSize: Boolean; aWordWrap: Boolean;
      aMask: Boolean);
var
  I       : LongInt;
  R       : TRect;
  yOffset : integer;
begin
  yOffset := 0;
  if aMask then
    aCanvas.Brush.Color:= clWhite
  else
    aCanvas.Brush.Color:= aBkColor;

  for I := 0 to count-1 do
    begin
      if SubItem[I] is TLMDTree then
        begin
          SubItem[I].Render(aCanvas, Rect(aRect.Left+aOffset.X+FOffset, aRect.Top+aOffset.Y+yOffset,
            aRect.Right, aRect.Bottom), Point(0, 0), aDefFont, aBkColor, aAutoSize, aWordWrap, aMask);
          SubItem[I].PosInParent := Point(FOffset, yOffset);
          R := SubItem[I].GetClientRect(aCanvas, Rect(0, 0, aRect.Right-aRect.Left-aOffset.X-FOffset,
            aRect.Bottom-aRect.Top-aOffset.Y-yOffset), aDefFont, aAutoSize, aWordWrap);
          yOffset := yOffset + R.Bottom-R.top+2;
          if yOffset > aRect.Bottom then Exit;
        end
      else
        begin
          R := SubItem[I].GetClientRect(aCanvas,Rect(0, 0, aRect.Right-aRect.Left-aOffset.X,
           aRect.Bottom-aRect.Top-aOffset.Y-yOffset), aDefFont, aAutoSize, aWordWrap);
          SubItem[I].Render(aCanvas, Rect(aRect.Left+aOffset.X, aRect.Top++aOffset.y+yOffset,
            aRect.Right, aRect.Bottom), Point(0,0), aDefFont, aBkColor, aAutoSize, aWordWrap, aMask);
          SubItem[I].PosInParent := Point(0,yOffset);
          yOffset := yOffset + R.Bottom-R.Top+2;
          if yOffset > aRect.Bottom then Exit;
        end;
    end;
end;

{------------------------------------------------------------------------------}

function  TLMDTREE.NeedReCalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
    aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean) : boolean;
begin
  result := True;
end;

procedure TLMDTREE.CalcClientRect(aCanvas: TCanvas; const aDisplayRect: TRect;
      aDefFont: TFont; aAutoSize: Boolean; aWordWrap: Boolean);
var
  I             : LongInt;
  R             : TRect;
begin
  FHeight := 0;
  FWidth  := 0;

  for I := 0 to Count-1 do
    begin
      if SubItem[I] is TLMDTree then
        begin
          R := SubItem[I].GetClientRect(aCanvas, Rect(0, 0, aDisplayRect.Right-aDisplayRect.Left-FOffset,
            aDisplayRect.Bottom - aDisplayRect.Top-FHeight) , aDefFont, aAutoSize, aWordWrap);
          FHeight := FHeight+R.Bottom-R.Top+2;
          if (R.Right-R.Left+FOffset) > FWidth then FWidth := R.Right-R.Left+FOffset;
        end
      else
        begin
          R := SubItem[I].GetClientRect(aCanvas, Rect(0, 0, aDisplayRect.Right-aDisplayRect.Left,
            aDisplayRect.Bottom - aDisplayRect.Top -FHeight), aDefFont, aAutoSize, aWordWrap);
          FHeight := FHeight+R.Bottom-R.Top + 2;
          if (R.Right-R.Left) > FWidth then FWidth := R.Right-R.Left;
        end;
    end;
  FClientWidth := FWidth;
  FClientHeight := FHeight;
end;

{------------------------------------------------------------------------------}

function TLMDTREE.Clone : TLMDBaseText;
begin
  result := inherited Clone;
  TLMDTree(Result).FOffset := FOffset;
  TLMDTree(Result).FRoot   := FRoot;
end;

{------------------------------------------------------------------------------}

procedure TLMDTREE.Store(AWriter : TLMDWriter);
var
  I{,J} : LongInt;
begin
  if FRoot then AWriter.WriteOpenTree
  else AWriter.WriterOpenTreeItem;
    for I := 0 to count-1 do
      SubItem[I].Store(AWriter);
  if FRoot then AWriter.WriteCloseTree
  else AWriter.WriterCloseTreeItem;
end;

end.
