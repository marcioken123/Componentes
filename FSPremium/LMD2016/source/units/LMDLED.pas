unit LMDLED;
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

LMDLED unit ()
--------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, menus,
  LMDObject, lmdgraph;

type
  {. - .
   |\ /|
   . - .
   |/ \|
   . - .}
  TLMDLEDLights=(llTop, llTopLeft, llTopRight,
                 llMiddle, llBottomLeft, llBottomRight,
                 llBottom, llInTopMiddle, llInBottomMiddle,
                 llInTopLeft, llInTopRight, llInBottomLeft, llInBottomRight,
                 llPointMiddle, llPointTop, llPointBottom);

  TLMDLEDSET=set of TLMDLEDLights;

  TLMDLEDStyle=(lsString, lsInteger);
  TLMDLEDPoints=array[0..5] of TPoint;
  TLMDLEDCalc=array[TLMDLEDLights] of TLMDLEDPoints;

  {---------------------- Object TLMDLED --------------------------------------}
  TLMDLED = class(TLMDObject)
  private
    FBack, FInactive, FActive:TColor;
    FHorz, FThick, FVert:Byte;
    FIsFlashing, FFlag, FEnhEnabled:Boolean;
    FRows, FCols:Byte;

    FLEDs:TLMDLEDCalc;
    FBitmap:TBitmap;

    {compatibility}
    FCaption:string;

    {Sets}
    procedure SetByte(Index:Integer; aValue:Byte);
    procedure SetColor(Index:Integer; aColor:TColor);
    procedure SetEnabled(aValue:Boolean);

    procedure CreateBmp;
  protected
    function GetHeight:Integer;
    function GetWidth:Integer;
  public
    constructor Create(Owner:TPersistent=nil); override;
    destructor Destroy; override;

    procedure Assign(Source:TPersistent);override;
    function CalcBoundsRect(const sText:String; Ext:Integer):TRect;
    procedure PaintLED(ACanvas :TCanvas; ARect:TRect; const sText:String; Enabled, flag:Boolean);

    procedure BeginFlash; virtual;
    procedure EndFlash; virtual;

    property Rows:Byte read FRows;
    property Columns:Byte read FCols;

    {for compatibility}
    property Caption:string read FCaption;
    property BackColor:TColor index 2 read FBack write SetColor;

    property LEDHeight:Integer read GetHeight;
    property LEDWidth:Integer read GetWidth;
  published
    property ActiveColor:TColor index 0 read FActive write SetColor default clLime;
    property DisabledDigits:Boolean read FEnhEnabled write SetEnabled default True;
    property Horzsize:Byte index 1 read FHorz write SetByte default 7;
    property InActiveColor:TColor index 1 read FInActive write SetColor default clGreen;
    property Thickness:Byte index 2 read FThick write SetByte default 2;
    property Vertsize:Byte index 3 read FVert write SetByte default 9;
  end;

implementation

uses
  Types,
  LMDProcs, LMDStrings;

var
  Counter:Integer;
  FirstColor, SecondColor:TColor;
  LEDBrush:TBitmap;

{Helpers}
{------------------------------------------------------------------------------}
function GetLEDBrushBitmap(first, second:TColor):TBitmap;
var
  i,j:Integer;
begin
  if (first<>FirstColor) or (second<>SecondColor) then
    with LEDBrush.Canvas do
      begin
        LedBrush.FreeImage;
        for i:=0 to 7 do
          for j:=0 to 7 do
            if ((i mod 2)=0) xor ((j mod 2)=0) then
              Pixels[i,j]:=first
            else
              Pixels[i,j]:=second;
        FirstColor:=First;
        SecondColor:=Second;
      end;
  result:=LEDBrush;
end;

{------------------------------------------------------------------------------}
procedure GetSinglePoints(flag:Byte; x,y,xext,yext:integer;
                          var ThePoints :TLMDLEDPoints; FThick:Byte);
var
  xd, yd :integer;

begin
  case flag of
    0: {Horz}
       begin
         ThePoints[0]:=Point(x,y+yExt);
         ThePoints[1]:=Point(x+yExt,y);
         ThePoints[2]:=Point(x+xExt+yExt,y);
         ThePoints[3]:=Point(x+xext+2*yext, ThePoints[0].Y);
         ThePoints[4]:=Point(ThePoints[2].X, y+2*yext);
         ThePoints[5]:=Point(ThePoints[1].X, ThePoints[4].Y);
       end;
    1: {Vert}
       begin
         ThePoints[0]:=Point(x+xext,y);
         ThePoints[1]:=Point(x+2*xext, y+xext);
         ThePoints[2]:=Point(ThePoints[1].X, y+xext+yext);
         ThePoints[3]:=Point(ThePoints[0].X, y+2*xext+yext);
         ThePoints[4]:=Point(x, ThePoints[2].Y);
         ThePoints[5]:=Point(x, ThePoints[1].y);
       end;
    2: {diagonal}
       begin
         if (xExt=0) or (yExt=0) then exit;
         xd:=Round(xext/Abs(xext)*FThick/2);
         yd:=Round(yext/Abs(yext)*FThick/2);

         ThePoints[0]:=Point(x,y);
         ThePoints[1]:=Point(x+xd,y);
         ThePoints[2]:=Point(x+xext, y+yext-yd);
         ThePoints[3]:=Point(ThePoints[2].X, y+yext);
         ThePoints[4]:=Point(x+xext-xd, ThePoints[3].y);
         ThePoints[5]:=Point(x, y + yd);
       end;
    3: {Points}
       begin
         {ThePoints[0]:=Point(x+xext-xd,y);
         ThePoints[1]:=Point(x+xext,y+yd);
         ThePoints[2]:=Point(x+xext-xd,y+yext);
         ThePoints[3]:=Point(x,y+yd);}
         ThePoints[0]:=Point(x+xext,y-1);
         ThePoints[1]:=Point(x+xext,y+yExt-1);
         ThePoints[2]:=Point(x,y+yext-1);
         ThePoints[3]:=Point(x,y-1);
         ThePoints[4]:=ThePoints[3];
         ThePoints[5]:=ThePoints[4];
       end;
  end;
end;

{------------------------------------------------------------------------------}
function GetLMDLEDSet(AChar:Char):TLMDLEDSet;
begin
  case aChar of
    'A','a' :result := [lltop,lltopleft,lltopright,llmiddle,llbottomleft,llbottomright];
    'B','b' :result := [lltop,llInTopMiddle,lltopright,llmiddle,llInBottomMiddle,llbottomright, llBottom];
    'C','c' :result := [lltop,lltopleft,llbottomleft, llBottom];
    'D','d' :result := [lltop,llInTopMiddle,lltopright,llInBottomMiddle,llbottomright, llBottom];
    'E','e'  :result := [lltop,lltopleft,llmiddle,llbottomleft,llbottom];
    'F','f'  :result := [lltop,lltopleft,llmiddle,llbottomleft];
    'G','g'  :result := [lltop,lltopleft,llmiddle,llbottomleft,llbottomright,llbottom];
    'H','h'  :result := [lltopright,lltopleft,llmiddle,llbottomleft,llbottomright];
    '1','I','i'  :result := [llInTopMiddle,llInBottomMiddle];
    'J','j'  :result := [lltopright,llbottomright,llBottom, llBottomleft];
    'K','k'  :result := [llTopLeft,llBottomLeft, llInTopRight, llInBottomRight, llMiddle];
    'L','l'  :result := [lltopleft,llbottomleft, llBottom];
    'M','m'  :result := [lltopright,lltopleft,llbottomleft,llbottomright,llInTopRight, llInTopLeft];
    'N','n'  :result := [lltopright,lltopleft,llbottomleft,llbottomright,llInBottomRight, llInTopLeft];
    'O','o'  :result := [lltop,lltopleft,lltopright,llbottomleft,llbottomright,llbottom];
    'P','p'  :result := [lltop,lltopleft,llmiddle,llbottomleft, llTopright];
    'Q','q'  :result := [lltop,lltopleft,lltopright,llbottomleft,llbottomright,llInbottomright, llBottom];
    'R','r'  :result := [lltop,lltopleft,llmiddle,llbottomleft, llTopright, llInBottomRight];
    'S','s'  :result := [lltop,lltopleft,llmiddle,llbottomright,llbottom];
    'T','t'  :result := [lltop, llInTopMiddle, llInBottomMiddle];
    'U','u'  :result := [lltopleft,lltopright,llbottomleft,llbottomright,llbottom];
    'V','v'  :result := [lltopLeft,llbottomLeft,llInBottomLeft, llInTopRight];
    'W','w'  :result := [lltopleft,lltopright,llbottomleft,llbottomright, llInBottomLeft, llInBottomRight];
    'X','x'  :result := [llInTopRight, llInTopLeft, llInBottomLeft, llInBottomRight];
    'Y','y'  :result := [llInBottomMiddle, llInTopRight, llInTopLeft];
    'Z','z'  :result := [llTop, llInTopRight, llInBottomleft, llBottom];
    '-'      :result := [llmiddle];
    '_'      :result := [llBottom];
    '\'      :result := [llInTopLeft, llInBottomRight];
    '/'      :result := [llInBottomLeft, llInTopRight];
    '+'      :result := [llInTopMiddle, llInBottomMiddle, llMiddle];
    '*'      :result := [llInTopRight, llInTopLeft, llInBottomLeft, llInBottomRight, llInTopMiddle, llInBottomMiddle];
    '<',
    '('      :result := [llInTopRight, llInBottomRight];
    '>',
    ')'      :result := [llInTopLeft, llInBottomLeft];
    '0'      :result := [lltop,lltopleft,lltopright,llbottomleft,llbottomright,llbottom, llInTopLeft, llInBottomRight];
    {'1'      :result := [lltopright,llbottomright];}
    '2'      :result := [lltop,lltopright,llmiddle,llbottomleft,llbottom];
    '3'      :result := [lltop,lltopright,lltopright,llmiddle,llbottomright,llbottom];
    '4'      :result := [lltopleft,lltopright,llmiddle,llbottomright];
    '5'      :result := [lltop,lltopleft,llmiddle,llbottomright,llbottom];
    '6'      :result := [lltop,lltopleft,llmiddle,llbottomleft,llbottomright,llbottom];
    '7'      :result := [lltop,lltopright,llbottomright];
    '8'      :result := [lltop,lltopleft,lltopright,llmiddle,llbottomleft,llbottomright,llbottom];
    '9'      :result := [lltop,lltopleft,lltopright,llmiddle,llbottomright,llbottom];
    ':'      :result := [llPointMiddle, llPointBottom];
    '.'      :result := [llPointBottom];
    '"'      :result := [llTopLeft, llInTopMiddle];
    ''''     :result := [llInTopMiddle];
    '='      :result := [llBottom, llMiddle];
    '[' :result := [lltopleft,llbottomleft, llBottom, llTop];
    ']' :result := [lltopRight,llbottomRight, llBottom, llTop];
  else
    result := []; {Unknown char...}
  end;
end;

{------------------------------------------------------------------------------}
procedure CreateLEDArray(var FLEDs:TLMDLEDCalc; FThick, FHorz, FVert:Byte);
var
  i:TLMDLEDLights;

begin

 for i := Low(TLMDLEDLights) to High(TLMDLEDLights) do
   case i of
     llTop          : GetSinglePoints(0, 2 * FThick, FThick, FHorz, FThick div 2, FLEDs[llTop],0);
     llTopleft      : GetSinglePoints(1, FThick, 2* FThick, FThick div 2, FVert, FLEDs[llTopLeft],0);
     llTopright     : GetSinglePoints(1, 3* FThick + FHorz, 2 * FThick, FThick div 2, FVert,
                                    FLEDs[llTopRight],0);
     llMiddle       : GetSinglePoints(0, 2* FThick, 3*FThick + FVert, FHorz, FThick div 2,
                                    FLEDs[llMiddle],0);
     llBottomleft   : GetSinglePoints(1, FThick, 4* FThick + FVert, FThick div 2, FVert,
                                    FLEDs[llBottomLeft],0);
     llBottomright  : GetSinglePoints(1, 3* FThick + FHorz, 4 * FThick+ FVert, FThick div 2, FVert,
                                    FLEDs[llBottomRight],0);
     llBottom       : GetSinglePoints(0, 2* FThick, 5*FThick + 2* FVert, FHorz, FThick div 2,
                                      FLEDs[llBottom],0);
     llInTopMiddle  : GetSinglePoints(1, (4*FThick+ FHorz) div 2, 2*FThick,FThick div 2,
                                      FVert,  FLEDs[llInTopMiddle],0);
     llInBottomMiddle:GetSinglePoints(1, (4*FThick+ FHorz) div 2, 4*FThick+FVert, FThick div 2, FVert,
                                    FLEDs[llInBottomMiddle],0);
     llInTopleft    : GetSinglePoints(2, (4*FThick+ FHorz) div 2- FThick div 2 , 2*FThick+FVert,
                                     -(FHorz div 2)+FThick, -FVert + FThick , FLEDs[llInTopLeft], FThick);
     llInTopright   : GetSinglePoints(2, (4*FThick+ FHorz) div 2 + round(1.5*FThick), 2*FThick+FVert,
                                    (FHorz div 2) - fThick, -FVert + FThick , FLEDs[llInTopRight], FThick);
     llInBottomLeft : GetSinglePoints(2, (4*FThick+ FHorz) div 2 - FThick div 2, 5*FThick+FVert, -(FHorz div 2) + FThick ,
                                     FVert - FThick , FLEDs[llInBottomLeft], FThick);
     llInBottomRight: GetSinglePoints(2,(4*FThick+ FHorz) div 2 + round(1.5*FThick), 5*FThick+FVert, (FHorz div 2) - FThick ,
                                      FVert - FThick , FLEDs[llInBottomRight], FThick);
     llPointMiddle: GetSinglePoints(3, ((4*FThick+ FHorz) div 2-1), 3*FThick + FVert, FThick, FThick, FLEDs[llPointMiddle],
                                    FThick);
     llPointTop: GetSinglePoints(3, ((4*FThick+ FHorz) div 2-1), FThick, FThick, FThick, FLEDs[llPointTop], FThick);
     llPointBottom: GetSinglePoints(3, ((4*FThick+ FHorz) div 2-1), 5*FThick + 2* FVert, FThick, FThick, FLEDs[llPointBottom],
                                       FThick);
   end;
end;

{************************** Object TLMDLED ************************************}
{---------------------------- Private -----------------------------------------}
procedure TLMDLED.SetByte(Index:Integer; aValue:Byte);
begin
  case Index of
    {0:if (aValue=FDigits) or (aValue=0) then exit else FDigits:=aValue;}
    1:if aValue=FHorz then exit else FHorz:=aValue;
    2:if aValue=FThick then exit else FThick:=aValue;
    3:if aValue=FVert then exit else FVert:=aValue;
  end;
  CreateBmp;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDLED.SetColor(Index:Integer; aColor:TColor);
begin
  case Index of
    0:if (aColor=FActive) then exit else FActive:=aColor;
    1:if (aColor=FInActive) then exit else FInActive:=aColor;
    2:if (aColor=FBack) then exit else FBack:=aColor;
  end;
  CreateBmp;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDLED.SetEnabled(aValue:Boolean);
begin
  if FEnhEnabled<>aValue then
    begin
      FEnhEnabled:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDLED.CreateBmp;
var
  i: TLMDLEDLights;
begin
  Inc(Counter);
  CreateLEDArray(FLEDs, FThick, FHorz, FVert);
  with FBitmap.Canvas, FBitmap do
    begin
      Height:=GetHeight;
      Width:=GetWidth;
      brush.Color:=FBack;
      FillRect(Rect(0,0,Width, Height));
      pen.Style:=psClear;
      Brush.Bitmap:=GetLEDBrushBitmap(FBack, FInActive);
      brush.Color:=FInActive;
      for i:=Low(TLMDLEDLights) to High(TLMDLEDLights) do
        Polygon(FLEDS[i]);
      Brush.Bitmap:=nil;
    end;
end;

{----------------------- Protected --------------------------------------------}
function TLMDLED.GetHeight:Integer;
begin
  result := 2*FVert + 7*FThick;
end;

{------------------------------------------------------------------------------}
function TLMDLED.GetWidth:Integer;
begin
  result := (FHorz + 5*FThick);
end;

{----------------------- Public -----------------------------------------------}
constructor TLMDLED.Create;
begin
  inherited Create;

  FActive := clLime;
  FInActive := clGreen;
  FHorz := 9;
  FVert := 7;
  FThick:= 2;
  FEnhEnabled:=True;

  {Internal}
  FIsFlashing:=False;
  FFlag:=False;

  FBitmap:=TBitmap.Create;

  {$IFDEF LMDTOOLS10}
  FDigits := 2;
  FStyle:=lsString;
  FTransparent := false;
  FBack:=clBlack;
  {$ENDIF}

end;

{------------------------------------------------------------------------------}
destructor TLMDLED.Destroy;
begin
  FBitmap.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDLED.Assign(Source: TPersistent);
var
  S: TLMDLED;
begin
  if Source=self then exit;
  if Source is TLMDLED then
    begin
      S := TLMDLED(Source);
      FHorz:=S.HorzSize;
      FVert:=S.VertSize;
      FThick:=S.Thickness;
      FEnhEnabled:=S.DisabledDigits;
      FActive:=S.ActiveColor;
      FInActive:=S.InActiveColor;
      CreateBmp;
      Change;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDLED.CalcBoundsRect(const sText:String; Ext:Integer):TRect;
begin
  PaintLED(nil, Rect(0,0,0,0), sText, False, False);
  result:=Rect(0, 0, GetWidth*FCols, FRows*GetHeight);
  Inc(Result.Right, 2*Ext+1);
  Inc(Result.Bottom, 2*Ext);
end;

{------------------------------------------------------------------------------}
procedure TLMDLED.PaintLED(aCanvas:TCanvas; aRect:TRect; const sText:String;
                          Enabled, flag:Boolean);
var
  i,x, tx, ty, th, tw:integer;
  pts:TLMDLEDPoints;
  TheLEDs :TLMDLEDSet;
  j: TLMDLEDLights;
  tmp, tmp2:Boolean;

begin

  FRows:=1;
  FCols:=1;
  x := 0;
  FCaption:=sText;

  {only 1 time}
  tmp:=(FVert>3) and (FHorz>3);
  tmp2:=not (FEnhEnabled and not Enabled);
  th:=GetHeight;
  tw:=GetWidth;
  ty:=aRect.Top;

  if Flag then
    with aCanvas do
      begin
        pen.Style:=psSolid;
        brush.Color:=FActive;
        pen.Color:= FActive;
      end;

  for i := 0 to Length(FCaption)-1 do
    begin
      case Ord(AnsiChar(FCaption[i+1])) of
        13:
          begin
            Inc(FRows);
            ty:=aRect.Top+(FRows-1)*th;
            x:=0;
          end;
        32..255:
          begin
            if flag then {we have to draw the LED}
              begin
                if FBitmap.Empty then CreateBmp;

                tx:=aRect.Left+x*tw;
                aCanvas.CopyRect(Bounds(tx, ty, tw, th), FBitmap.Canvas,
                                 Rect(0,0, tw, th));

                if tmp2 then
                  begin
                    if FIsFlashing and not FFLag then
                      TheLeds:=[]
                    else
                      TheLeds := GetLMDLEDSet(FCaption[i+1]);

                    if  TheLeds <> []   then
                      for j:=Low(TLMDLEDLights) to High(TLMDLEDLights) do
                       if tmp or (j<llInTopMiddle) then
                         begin
                           pts:=FLEDs[j];
                           if j in TheLeds then
                             begin
                               LMDOffsetPoints(pts, tx, ty);
                               Windows.Polygon(aCanvas.Handle,pts, 6);
                             end;
                         end;
                  end;
              end;

            inc(x);
            if (x>=FCols) then FCols :=x;
          end;
      end;
    end;

  if FIsFlashing then
    FFlag := not FFlag;
end;

{------------------------------------------------------------------------------}
procedure TLMDLED.BeginFlash;
begin
  FIsFlashing:=True;
  //Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDLED.EndFlash;
begin
  FIsFlashing:=False;
  Change;
end;

initialization
  {create LEDBrush}
  LEDBrush:=TBitmap.Create;
  LEDBrush.Width:=8;
  LEDBrush.Height:=8;

finalization
  LEDBrush.Free;

end.
