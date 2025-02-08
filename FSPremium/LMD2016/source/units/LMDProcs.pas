unit LMDProcs;
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

LMDProcs unit (RM)
------------------
General non-visual helpers unit.

!NB! Only for non visual routines - no Forms, Controls etc shouldn't uses here.

ToDo
----

Changes
-------
Release 9.0 (July 2008)
 - LMDPtrToRect, LMDRectToPtr

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}


interface

uses
  Windows, SysUtils, Classes, Math, TypInfo, LMDRTLConst, LMDTypes;

const
  MaxBufferSize = 32767;
  MaxBufferIndex = MaxBufferSize+14;

type
  TLMDRectAlignment = (raLeft, raCenter, raRight);

  TLMDAlignRect = record
    align: TLMDRectAlignment;
    index: Integer;
    rect : TRect;
  end;
//  PLMDAlignRect = ^TLMDAlignRect;
//Aligns rects in the given array a according to their alignment, index
//and (implicit) widths settings given in the array items
procedure LMDAlignRects(inRect: TRect; var a: Array of TLMDAlignRect);
procedure LMDCheckRects (var a: Array of TLMDAlignRect);
function LMDGetWorkSpaceRect: TRect;

{Some helpful func's}
{------------------------------------------------------------------------------}
{Rects}
function  LMDExpandRect(const aRect:TRect; aValue:Integer):TRect;
procedure LMDAdjustRect(var aRect:TRect; dx, dy:Integer);
procedure LMDAdjustRectExt(var aRect:TRect; dx, dy, dx1, dy1:Integer); overload;
procedure LMDAdjustRectExt(var aRect:TRect; ASecondRect: TRect); overload;
function LMDAffineRect(const srcRect, destRect:TRect):TRect;
function LMDRectinRect(const first, second:TRect):Boolean;
procedure LMDCenterRects(WS, WT, HS, HT: integer; var R: TRect);

function LMDRectLeftPart(const aRect: TRect; aPercent: byte): TRect;
function LMDRectRightPart(const aRect: TRect; aPercent: byte): TRect;
function LMDRectTopPart(const aRect: TRect; aPercent: byte): TRect;
function LMDRectBottomPart(const aRect: TRect; aPercent: byte): TRect;
function LMDRelativeRect(const aBoundsRect: TRect; const aPercentsRect: TRect): TRect;
function LMDRelativePoint(const aBoundsRect: TRect; const aPercentsPoint: TPoint): TPoint;

//Rect helpers
procedure LMDGetRectWH(const srcRect:TRect; var w,h:Integer);
function LMDRectWidth(const ARect: TRect): Integer;
function LMDRectHeight(const ARect: TRect): Integer;
function LMDRectEquals(const R1, R2: TRect): Boolean;
function LMDGetShiftState: TShiftState;
//Points
function LMDPointInRect(APoint: TPoint; ARect: TRect): boolean;
function LMDMiddlePoint(APoint1, APoint2: TPoint): TPoint;


{Rotation}
procedure LMDCalcRotRect(var aRect:TRect; anAngle :integer);
function LMDRotatedXPos(Anangle, AWidth, AHeight :integer):integer;
function LMDRotatedYPos(Anangle, AWidth, AHeight :integer):integer;
{Points}
procedure LMDMidpoint(const X :array of TPoint; var Mid :TPoint);
procedure LMDOffsetPoints(var X :array of TPoint; dx, dy: integer);
procedure LMDNullPoints(var X :array of TPoint);
{General}
function LMDMax(const X:array of Longint):Longint;
function LMDMin(const X:array of Longint):Longint;
function LMDMidI(x,y:LongInt):LongInt;
function LMDMaxR(const X:array of Extended):Extended;
function LMDMinR(const X:array of Extended):Extended;
function LMDInRange(AVal, ALower, AUpper: Integer): Boolean;
function LMDInRangeF(AVal, ALower, AUpper: double): boolean;
//Returns Min(Max(AVal, AMin), AMax)
function LMDMinMax(Val, AMin, AMax: Integer): Integer;

procedure LMDSwapInt(var x,y:Integer);
procedure LMDSwapString(var x,y:String);
// 8.0
function LMDGetPercentValue(aPosition, aMaxValue:Int64; aMinValue:Int64=0): TLMDPercent;

//Returns string like: '[ssShift, ssCtrl, ssRight, ssMiddle, ssDouble]'
function LMDShiftStateToString(AState: TShiftState): TLMDString;

// <-- LMD HTML Render
function LMDSign(a: integer): integer;
function LMDSwapInt32(i: integer): integer;
function LMDSwapInt16(w: word): Word;
function LMDIsHTMLText(s: TLMDString): boolean;

{SetBit/GetBit for one Byte flags}
{----------------------------------------------------------------------------}
procedure LMDSetBit(var holder:Byte; bit:Byte; aValue:Boolean);
procedure LMDSetBitUpTo(var Holder:Byte; upTo:Byte);
function LMDGetBit(holder, bit:Byte):Boolean;

{Math}
function LMDExp(ABase, AExp: LongInt):Int64; //deprecated;


function  int_Ref(const Str: String): PChar; overload;
{$ifdef LMDCOMP12}
function  int_Ref(const Str: AnsiString): PAnsiChar; overload;
{$endif}
function  int_Ref(V: integer): PChar; overload;
{$ifdef LMDCOMP12} function  int_RefA(const Str: string; var APtr: PChar): PChar; overload; {$endif}
function  int_RefA(const Str: Ansistring; var APtr: PAnsiChar): PAnsiChar; overload;
function  int_RefA(const Str: Ansistring): PAnsiChar; overload;
function  int_RefW(const Str: WideString): PWideChar;
function  int_RefWI(const Str: WideString): PWideChar;
{$ifdef LMDCOMP12}procedure int_Free(const Lst: array of PAnsiChar);overload;{$endif}
procedure int_Free(const Lst: array of PChar);{$ifdef LMDCOMP12}overload;{$endif}

function  LMDWebBufToStr(Buf: PChar; iLength: integer; iOffset: integer = 0): string;
function  LMDPtrToText(APtr: PChar): string;

function  LMDPtrToRect(APtr: PRect): TRect; {$IFDEF LMD_INLINE} inline; {$ENDIF}
function  LMDRectToPtr(const ARect:TRect): PRect; {$IFDEF LMD_INLINE} inline; {$ENDIF}

{Path}
{------------------------------------------------------------------------------}
type
  TLMDPathPrefix=(ppWindows, ppSystem, ppProgram, ppFixed);

function LMDAppPath:String;
function LMDAppIniName:String;
function LMDExtractFileName(const FileName:String):String;
function LMDCreatePathPrefix(aValue:TLMDPathPrefix; Slash:Boolean):String;
function LMDSystemDirectory:String;
function LMDWindowsDirectory:String;
function LMDShrunkFileName(const Filename:String; MaxLen:Integer):String;

function LMDInc(var i: Integer): Integer;
function LMDDec(var i: Integer): Integer;

// Version 6.0
procedure LMDMailTo(const aAddress: String; const aSubject:String='');

// Version 8.0
function LMDFireURL(const URL: TLMDString; ALocal: Boolean=false): Boolean;
function LMDExecute(const Verb, FileName: string): Boolean;
function LMDSetToString(const ATypeInfo: PTypeInfo; AValue: Integer; const ABrackets: Boolean): String;

{Misc}
{------------------------------------------------------------------------------}
procedure LMDDelay(ms:LongWord);

type
  TLMDCompressionType=(ctLZRW, ctZLib); {more to come later}

  TBufferSize = 0..MaxBufferSize;
  TBufferIndex = 0..MaxBufferIndex;
  TABuffer=array[TBufferIndex] of Byte;
  PBuffer =^ TABuffer;

{Compression}
{------------------------------------------------------------------------------}
function LMDLZRWCompress(Source, Dest: PBuffer; SourceSize: TBufferSize): TBufferSize;
function LMDLZRWDecompress(Source, Dest: PBuffer; Size: TBufferSize): TBufferSize;

function LMDZLibCompress(const Source: PBuffer; var Dest: PBuffer; SourceSize: Cardinal): Cardinal;
function LMDZLibDecompress(const Source: PBuffer; var Dest: PBuffer; Size: Cardinal): Cardinal;


procedure LMDLoadCompressedStream(src, target:TStream; cType:TLMDCompressionType=ctLZRW);
procedure LMDSaveCompressedStream(src, target:TStream; size:LongInt; cType:TLMDCompressionType=ctLZRW);

{Convert String to bytes}
function LMDDataToStr(Buffer: Pointer; BufLen: integer): TLMDString;
function LMDStrToData(S: TLMDString; var Buffer: Pointer; var BufLen: integer): boolean;

type
  // IntPtr and Pointer accesed as array
  TLMDRawMemory = class(TObject)
  private
    FMemory: UniPtr;
    FOffsetSize: Integer;
    FBaseOffset: Integer;
    procedure SetBaseOffset(const Value: Integer);
    function GetBytes(Offset: Integer): byte;
    procedure SetBytes(Offset: Integer; const Value: byte);
    function GetWords(Offset: Integer): word;
    procedure SetWords(Offset: Integer; const Value: word);
    function GetDWords(Offset: Integer): DWord;
    function GetInt64(Offset: Integer): Int64;
    procedure SetDWords(Offset: Integer; const Value: DWord);
    procedure SetInt64(Offset: Integer; const Value: Int64);
    procedure SetOffsetSize(Value: Integer);
  public
    constructor Create; overload;
    constructor Create(AMemory: UniPtr); overload;
    property Memory: UniPtr read FMemory write FMemory;
    property BaseOffset: Integer read FBaseOffset write SetBaseOffset;
    property OffsetSize: Integer read FOffsetSize write SetOffsetSize;
    property Byte[Offset: Integer]: byte read GetBytes write SetBytes; default;
    property Word[Offset: Integer]: word read GetWords write SetWords;
    property DWord[Offset: Integer]: DWord read GetDWords write SetDWords;
    property Int64[Offset: Integer]: Int64 read GetInt64 write SetInt64;
  end;


implementation

uses
  ShellApi, LMDStrings, LMDSysIn, LMDZCommonUnit, LMDZCompressUnit,
  LMDZUnCompressUnit, LMDZLib;

type
  TLMDAlignRectItem = record
    alignRect: TLMDAlignRect;
    index    : Integer;
  end;
  PLMDAlignRectItem = ^TLMDAlignRectItem;

  function CompareAlignRects (Item1, Item2: Pointer): Integer;
  begin
    Result := PLMDAlignRectItem(Item1).alignRect.index - PLMDAlignRectItem(Item2).alignRect.index;
  end;


procedure LMDAlignRects(inRect: TRect; var a: Array of TLMDAlignRect);

var
  ra   : TLMDRectAlignment;
  i    : Integer;
  list : TList;

   //append a list
   procedure appendList(ri: Integer; const anItem: TLMDAlignRect; index: Integer);
   var
     l: TList;
     item: PLMDAlignRectItem;
     begin
     l := TList(list.Items[ri]);
     New(item);
     item.alignRect := anItem;
     item.index := index;
     l.Add(TObject(item));
   end;

   //sort the list according to index value
   procedure sortList (l: TList);
   begin
     l.Sort(CompareAlignRects);
   end;

   //left align rects
   procedure LeftAlign (x: Integer; l: TList);
   var
     i: Integer;
     R: PLMDAlignRectItem;
   begin
     for i := 0 to l.Count - 1 do
       begin
         R := PLMDAlignRectItem(l[i]);

         with R.alignRect.rect do
         begin
           Left := x;
           x := Left + Right;
         end;

         l[i] := R;
       end;
   end;

   //width of list rects
   function width(l: TList): Integer;
   var
     i: Integer;
   begin
     result := 0;
     for i := 0 to l.Count - 1 do
       with PLMDAlignRectItem(l.Items[i]).alignRect.rect do
         inc (result, Right-Left);
   end;

   //right align rects
   procedure RightAlign (l: TList);
   var
     x:Integer;
   begin
     x := inRect.Right - width(l);
     LeftAlign (x, l);
   end;

   //center rects
   procedure Center (l: TList);
   var
     x      : Integer;
   begin
     x := width(l);
     x := ((inRect.Right - inRect.Left) - x) div 2;
     LeftAlign (x, l);
   end;

   //list to array
   procedure ListInArray (l: TList);
   var
     i: Integer;
   begin
     for i := 0 to l.Count - 1 do
       a[PLMDAlignRectItem(l.Items[i]).index] := PLMDAlignRectItem(l.Items[i]).alignRect;
   end;

   //empties a list
   procedure DeleteList(ri: Integer);
   var
     l: TList;
     i: Integer;
   begin
     l := TList(list.Items[ri]);
     for i := 0 to l.Count - 1 do
       Dispose (PLMDAlignRectItem(l[i]));
     l.Free;
   end;


begin
  list := TList.Create;
  try
    for ra := Low(TLMDRectAlignment) to High(TLMDRectAlignment) do
      list.Add(TList.Create);
    for i := Low(a) to High(a) do
      appendList (Ord(a[i].align), a[i], i);
    for ra := Low(TLMDRectAlignment) to High(TLMDRectAlignment) do
      sortList (TList(list.Items[Ord(ra)]));
    //now we have #TLMDRectAlignment lists sorted by index
    LeftAlign (inRect.Left, TList(list.Items[Ord(raLeft)]));
    RightAlign (TList(list.Items[Ord(raRight)]));
    Center (TList(list.Items[Ord(raCenter)]));

    for ra := Low(TLMDRectAlignment) to High(TLMDRectAlignment) do
      begin
        ListInArray (TList(list.Items[Ord(ra)]));
        DeleteList(Ord(ra));
      end;

  finally
    list.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDCheckRects (var a: Array of TLMDAlignRect);
var
  i: Integer;
begin
  for i := Low(a) to High(a) do
    if IsRectEmpty (a[i].rect) then
       a[i].rect := Rect(0,0,1,1);
end;

{Rect}
{------------------------------------------------------------------------------}
function  LMDExpandRect(const aRect:TRect; aValue:Integer):TRect;
begin
  result:=aRect;
  LMDAdjustRectExt(result, -aValue, -aValue, aValue, aValue);
end;

{------------------------------------------------------------------------------}
procedure LMDAdjustRect(var aRect:TRect; dx, dy:Integer);
begin
  Inc(aRect.Right, dx);
  Inc(aRect.Bottom, dy);
end;

{------------------------------------------------------------------------------}
procedure LMDAdjustRectExt(var aRect:TRect; dx, dy, dx1, dy1:Integer);
begin
  with aRect do
    begin
      Inc(Left, dx);
      Inc(Top, dy);
      Inc(Right, dx1);
      Inc(Bottom, dy1);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDAdjustRectExt(var aRect:TRect; ASecondRect: TRect); overload;
begin
  LMDAdjustRectExt(aRect, ASecondRect.Left, ASecondRect.Top, ASecondRect.Right, ASecondRect.Bottom);
end;

{------------------------------------------------------------------------------}
function LMDAffineRect(const srcRect, destRect:TRect):TRect;
var
  sw, sh, dw, dh:Integer;
  k:Extended;

begin
  with srcRect do
    begin
     sw:=Right-Left;
     sh:=Bottom-Top;
    end;

  with destRect do
    begin
     dw:=Right-Left;
     dh:=Bottom-Top;
    end;

  k:=LMDMinR([dw/sw, dh/sh]);
  SetRect(result, 0,0, Trunc(sw*k), Trunc(sh*k));
  OffsetRect(result, destRect.Left, destRect.Top);
end;

{------------------------------------------------------------------------------}
function LMDRectinRect(const first, second:TRect):Boolean;
begin
  result:=false;
  if (PtInRect(second, first.TopLeft)) and
     (PtInRect(second, first.BottomRight)) then
     result:=true;
end;

{------------------------------------------------------------------------------}
procedure LMDCenterRects(WS, WT, HS, HT: integer; var R: TRect);
begin
  R.Left := max(WT div 2 - WS div 2, 0);
  R.Right := min(R.Left + WS, WT + R.Left); //changed line
  R.Top := max(HT div 2 - HS div 2, 0);
  R.Bottom := min(R.Top + HS, HT + R.Top); //changed line
end;

//TRect helpers
{------------------------------------------------------------------------------}
function LMDRectTopPart(const aRect: TRect; aPercent: byte): TRect;
begin
  result := aRect;
  result.Bottom := result.Top + muldiv((result.Bottom - result.Top), aPercent, 100);
end;

{------------------------------------------------------------------------------}
function LMDRectBottomPart(const aRect: TRect; aPercent: byte): TRect;
begin
  result := aRect;
  result.Top := result.Top + muldiv((result.Bottom - result.Top), aPercent, 100) + 1;
end;

{------------------------------------------------------------------------------}
function LMDRectLeftPart(const aRect: TRect; aPercent: byte): TRect;
begin
  result := aRect;
  result.Right := result.Left + muldiv((result.Right - result.Left), aPercent, 100);
end;

{------------------------------------------------------------------------------}
function LMDRectRightPart(const aRect: TRect; aPercent: byte): TRect;
begin
  result := aRect;
  result.Left := result.Left + muldiv((result.Right - result.Left), aPercent, 100) + 1;
end;

{------------------------------------------------------------------------------}
function LMDRelativeRect(const aBoundsRect: TRect; const aPercentsRect: TRect): TRect;
begin
  result.Left := aBoundsRect.Left + muldiv((aBoundsRect.Right - aBoundsRect.Left), aPercentsRect.Left, 100);
  result.Top := aBoundsRect.Top + muldiv((aBoundsRect.Bottom - aBoundsRect.Top), aPercentsRect.Top, 100);
  result.Right := aBoundsRect.Left + muldiv((aBoundsRect.Right - aBoundsRect.Left), aPercentsRect.Right, 100);
  result.Bottom := aBoundsRect.Top + muldiv((aBoundsRect.Bottom - aBoundsRect.Top), aPercentsRect.Bottom, 100);
end;

{------------------------------------------------------------------------------}
function LMDRelativePoint(const aBoundsRect: TRect; const aPercentsPoint: TPoint): TPoint;
begin
  result.X := aBoundsRect.Left + muldiv((aBoundsRect.Right - aBoundsRect.Left), aPercentsPoint.X, 100);
  result.Y := aBoundsRect.Top + muldiv((aBoundsRect.Bottom - aBoundsRect.Top), aPercentsPoint.Y, 100);
end;

{------------------------------------------------------------------------------}
function LMDRectWidth(const ARect: TRect): Integer;
begin
  result := ARect.Right - ARect.Left;
end;

{------------------------------------------------------------------------------}
function LMDRectHeight(const ARect: TRect): Integer;
begin
  result := ARect.Bottom - ARect.Top;
end;

{------------------------------------------------------------------------------}
procedure LMDGetRectWH(const srcRect:TRect; var w,h:Integer);
begin
  with srcRect do
    begin
     w:=Right-Left;
     h:=Bottom-Top;
    end;
end;

{------------------------------------------------------------------------------}
function LMDRectEquals(const R1, R2: TRect): Boolean;
begin
  result := (R1.Left=R2.Left) and (R1.Right=R2.Right) and
            (R1.Top=R2.Top) and (R1.Bottom=R2.Bottom)
end;

{Rotation&Rects}
{------------------------------------------------------------------------------}
procedure LMDCalcRotRect(var aRect:TRect; anAngle :integer);
var
  x,y,x1,x2,x3,x4,y1,y2,y3,y4,w,h:integer;
  winkel, sn,cs:Extended;

begin
  if anangle=0 then exit; {Nix zu tun...}

  winkel := anangle*(pi/180);
  with aRect do
    begin
    w := (right-left) div 2;
    h := (bottom-top) div 2;

    {Mitte des Rechtecks}
    x := left + w;
    y := top + h;

    {Nur einmal den sin/cos berechenen}
    sn := sin(winkel);
    cs := cos(winkel);

    {Koordinaten}
    x1 := x - round(w * cs - h*sn);
    x2 := x - round(w * cs + h*sn);
    x3 := x + round(w * cs + h*sn);
    x4 := x + round(w * cs - h*sn);

    y1 := y + round(w*sn - h*cs);
    y2 := y + round(w*sn + h*cs);
    y3 := y - round(w*sn + h*cs);
    y4 := y - round(w*sn - h*cs);

    {Ausdehnung des Rechtecks ermitteln}
    left := LMDMin([x1,x2,x3,x4]);
    right := LMDMax([x1,x2,x3,x4]);
    top := LMDMin([y1,y2,y3,y4]);
    bottom := LMDMax([y1,y2,y3,y4]);

    OffsetRect(aRect, -Left, -Top);
  end;
end;

{------------------------------------------------------------------------------}
function LMDRotatedXPos(Anangle, AWidth, AHeight :integer):integer;
var
  Xdir:Extended;
begin

  result:=0;
  Xdir:=sin(AnAngle*pi/180);

  case Anangle of
    91..180 : result := round(Awidth*sin((AnAngle-90)*pi/180));
    181..270: result := awidth;
    271..359: result := awidth+round(Awidth*sin((AnAngle-90)*pi/180));
  end;
  result:=Round(result+aHeight*XDir);
end;

{------------------------------------------------------------------------------}
function LMDRotatedYPos(Anangle, AWidth, AHeight :integer):integer;
var
  YDir:Extended;
begin

  result:=0;
  YDir:=Cos(AnAngle * Pi/180);
  case Anangle of
    0..90   : result := round(Aheight*sin(AnAngle*pi/180));
    91..180 : result := aheight;
    181..270: result := aheight+round(Aheight*sin(AnAngle*pi/180));
  end;
  result:=Round(result+aHeight*YDir);
end;

{------------------------------------------------------------------------------}
procedure LMDMidpoint(const X :array of TPoint; var Mid :TPoint);
var
  i:integer;
  sumx, sumy:integer;
begin
  if high(x) = 0 then exit; {nix zu tun...}
  sumx :=0;
  sumy :=0;
  for i := 0 to High(x)-1 do begin
    inc(sumx, x[i].x);
    inc(sumy, x[i].y);
  end;
  mid.x := sumx div (high(x));
  mid.y := sumy div (high(x));
end;

{------------------------------------------------------------------------------}
procedure LMDOffsetPoints(var X :array of TPoint; dx, dy: integer);
var i:integer;
begin
  for i := 0 to High(x) do
    begin
      Inc(X[i].x, dx);
      Inc(X[i].y, dy);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDNullPoints(var X :array of TPoint);
var
  i:integer;
begin
  for i := 0 to High(x) do
    begin
      X[i].x := 0;
      X[i].y := 0;
    end;
end;

{------------------------------------------------------------------------------}
function LMDMax(const x:array of Longint):Longint;
var
  i:Integer;
begin
  result:=X[0];
  if sizeof(x)>1 then
    for i:=1 to High(X) do
      if x[i]>result then result:=X[i];
end;

{------------------------------------------------------------------------------}
function LMDMin(const X:array of Longint):Longint;
var
  i:Integer;
begin
  result:=X[0];
  if sizeof(x)>1 then
    for i:=1 to High(X) do
      if X[i]<result then result:=X[i];
end;

{------------------------------------------------------------------------------}
function LMDMidI(x,y:LongInt):LongInt;
begin
  result:=(x+y) div 2;
end;

{------------------------------------------------------------------------------}
function LMDMaxR(const x:array of Extended):Extended;
var
  i:Integer;
begin
  result:=X[0];
  if sizeof(x)>1 then
    for i:=1 to High(X) do
      if x[i]>result then result:=X[i];
end;

{------------------------------------------------------------------------------}
function LMDMinR(const X:array of Extended):Extended;
var
  i:Integer;
begin
  result:=X[0];
  if sizeof(x)>1 then
    for i:=1 to High(X) do
      if X[i]<result then result:=X[i];
end;

{------------------------------------------------------------------------------}
procedure LMDSwapInt(var x, y:Integer);
var
  dummy:Integer;
begin
  dummy := x;
  x := y;
  y := dummy;
end;

{------------------------------------------------------------------------------}
procedure LMDSwapString(var x,y:String);
var
  dummy:String;
begin
  dummy:=x;
  x := y;
  y := dummy;
end;

{------------------------------------------------------------------------------}
function LMDGetPercentValue(aPosition, aMaxValue:Int64; aMinValue:Int64=0):TLMDPercent;
var
  temp:Int64;
begin
  temp:=Round((aPosition-aMinValue)/(aMaxValue-aMinValue)*100);
  if temp<0 then temp:=0;
  if temp>100 then temp:=100;
  result:=TLMDPercent(temp);
end;

{------------------------------------------------------------------------------}
function LMDIsHTMLText(s: TLMDString): boolean;
begin
  result := SameText(Copy(s, 1, 6), '<html>');
end;

{---- From ElTools, needed for LMDHTMLRender ----}
{------------------------------------------------------------------------------}
function LMDSwapInt16(w: Word): Word;
begin
  Result := (w shl 8) or (w shr 8);
end;

{------------------------------------------------------------------------------}
function LMDSwapInt32(i: integer): integer;
begin
  Result := (i shr 24) or (((i and $FF0000) shr 16) shl 8) or
    (((i and $FF00) shr 8) shl 16) or ((i and $FF) shl 24);
end;

{------------------------------------------------------------------------------}
function LMDSign(a: integer): integer;
begin
  if a < 0 then
    Result := -1
  else
    if a > 0 then
    Result := 1
  else
    Result := 0;
end;
{Helper for for one byte flags}
{------------------------------------------------------------------------------}
procedure LMDSetBit(var holder:Byte; bit:Byte; aValue:Boolean);
begin
  if aValue then
    holder:=holder or (1 shl bit)
  else
    holder:=holder xor (1 shl bit);
end;

{------------------------------------------------------------------------------}
procedure LMDSetBitUpTo(var Holder:Byte; upTo:Byte);
var
  i:Integer;
begin
  For i:=0 to upTo do LMDSetBit(Holder, i, True);
end;

{------------------------------------------------------------------------------}
function LMDGetBit(holder, bit:Byte):Boolean;
begin
  result:=((1 shl bit) and Holder=(1 shl bit));
end;

{Misc}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
function LMDExp(ABase, AExp:LongInt):Int64;
//function LMDExp(base, exp:Integer):LongInt;
var
  i:LongInt;
begin
  result:=1;
  for i:=1 to AExp do
    result:=result*ABase;
end;


{------------------------------------------------------------------------------}
function  LMDPtrToText(APtr: PChar): string;
begin
  if APtr = nil then
    Result := ''
  else
    Result := Trim(APtr);
end;

{------------------------------------------------------------------------------}
function  int_Ref(const Str: string): PChar;
begin
  if  Str = ''  then
    Result := nil
  else
    Result := PChar(Str);
end;

{------------------------------------------------------------------------------}
{$ifdef LMDCOMP12}
function  int_Ref(const Str: AnsiString): PAnsiChar;
begin
  if  Str = ''  then
    Result := nil
  else
    Result := PAnsiChar(Str);
end;
{$endif}
{------------------------------------------------------------------------------}
function  int_Ref(V: integer): PChar;
begin
  Result := PChar(V);
end;

{$ifdef LMDCOMP12} 
function int_RefA(const Str: string; var APtr: PChar): PChar; 
begin
  if  Str = ''  then
    Result := nil
  else
    Result := PChar(Str);

  APtr := Result;
end;
{$endif}
{------------------------------------------------------------------------------}
function  int_RefA(const Str: Ansistring; var APtr: PAnsiChar): PAnsiChar;
begin
  if  Str = ''  then
    Result := nil
  else
    Result := PAnsiChar(Str);

  APtr := Result;
end;

{------------------------------------------------------------------------------}
function  int_RefA(const Str: Ansistring): PAnsiChar;
begin
  int_RefA(Str, Result);
end;

{------------------------------------------------------------------------------}
{$ifdef LMDCOMP12}
procedure int_Free(const Lst: array of PAnsiChar);
begin
  // Nothing
end;
{$endif}
procedure int_Free(const Lst: array of PChar);
begin
  //  Nothing
end;

{------------------------------------------------------------------------------}
function  int_RefW(const Str: WideString): PWideChar;
begin
  if  Str = ''  then
    Result := nil
  else
    Result := PWideChar(Str);
end;
{------------------------------------------------------------------------------}
function  int_RefWI(const Str: WideString): PWideChar;
begin
  if  Str = ''  then
    Result := nil
  else
    Result := PWideChar(Str);
end;
{------------------------------------------------------------------------------}
function  LMDWebBufToStr(Buf: PChar; iLength: integer; iOffset: integer = 0): string;
begin
  if  Buf = nil then
    Result := ''
  else
    SetString(Result, Buf + iOffset, iLength);
end;

{------------------------------------------------------------------------------}
function  LMDPtrToRect(APtr: PRect): TRect;
begin
  result := PRect(APtr)^;
end;

{------------------------------------------------------------------------------}
function  LMDRectToPtr(const ARect:TRect): PRect;
begin
  result := @ARect;
end;

{Misc}
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
function LMDAppPath:String;
begin
  result:=ExtractFilePath(ParamStr(0));
end;

{------------------------------------------------------------------------------}
function LMDAppIniName:String;
begin
  result:='SOFTWARE\'+ ChangeFileExt(ExtractFileName(ParamStr(0)),'');
end;

{------------------------------------------------------------------------------}
function LMDExtractFileName(const FileName:String):String;
begin
  result:=ChangeFileExt(ExtractFileName(FileName),'');
end;

{------------------------------------------------------------------------------}
function LMDCreatePathPrefix(aValue:TLMDPathPrefix; Slash:Boolean):String;
begin
  result:='';
  case aValue of
    ppWindows: result:=LMDWindowsDirectory;
    ppSystem : result:=LMDSystemDirectory;
    ppProgram: Result:=LMDAppPath;
  else
    exit;
  end;
  if Slash then
    Result := LMDAnsiSlashAdd(result)
  else
    Result := LMDAnsiSlashRemove(result);
end;

{------------------------------------------------------------------------------}
function LMDSystemDirectory:String;
var
  tmp:Integer;
begin
  SetLength(result, MAX_PATH);
  tmp:=GetSystemDirectory(PChar(result), MAX_PATH);
  SetLength(result, tmp);
end;

{------------------------------------------------------------------------------}
function LMDWindowsDirectory:String;
var
  tmp:Integer;
begin
  SetLength(result, MAX_PATH);
  tmp:=GetWindowsDirectory(PChar(result), MAX_PATH);
  SetLength(result, tmp);
end;

{------------------------------------------------------------------------------}
function LMDShrunkFileName(const Filename:String; MaxLen: Integer): String;
var
  Drive, Dir, Name:String;

  procedure ShrunkDirectory(var S: String);
  var
    Root: Boolean;
    P: Integer;
  begin
    if S='\' then
      S:=''
    else
      begin
        if S[1]='\' then
          begin
            Root:=True;
            Delete(S, 1, 1);
          end
        else
          Root := False;
        if S[1] = '.' then
          Delete(S, 1, 4);
        P:=Pos('\', S);
        if P <> 0 then
          begin
            Delete(S, 1, P);
            S := '...\' + S;
          end
        else
          S := '';
        if Root then S := '\' + S;
      end;
  end;

begin
  Result:=FileName;
  Dir:=ExtractFilePath(Result);
  Name:=ExtractFileName(Result);

  if (Length(Dir) >= 2) and (Dir[2] = ':') then
    begin
      Drive := Copy(Dir, 1, 2);
      Delete(Dir, 1, 2);
    end
  else
     Drive := '';

  while ((Dir <> '') or (Drive <> '')) and (Length(result) > MaxLen) do
    begin
      if Dir = '\...\' then
        begin
          Drive := '';
          Dir := '...\';
        end
          else if Dir = '' then
            Drive := ''
          else
            ShrunkDirectory(Dir);
      Result := Drive + Dir + Name;
    end;
end;


{------------------------------------------------------------------------------}
procedure LMDDelay(ms:LongWord);
var
  waituntil:LongWord;
begin
  if ms<=0 then exit;
  waituntil:=GetTickCount+ms;
  repeat until GetTickCount>waitUntil;
end;


{compression routines, basing on routines from SWAG}
{------------------------------------------------------------------------------}
const
  FLAG_Copied=$80;
  FLAG_Compress=$40;

type
  LZTable=array[0..4095] of SmallInt;
  PLZTable= ^LZTable;


{------------------------------------------------------------------------------}
function  LMDLZRWCompress(Source, Dest:PBuffer; SourceSize:TBufferSize) :TBufferSize;
var
  Hash:PLZTable;
  Key, Bit,Command,Size:Word;
  X,Y,Z,Pos:TBufferIndex;

  function FindMatch(ASource: PBuffer; X: TBufferIndex; SourceSize: TBufferSize;
                     AHash: PLZTable; var iSize: WORD; var Pos: TBufferIndex): Boolean;
    var
      TmpHash:SmallInt;
      HashValue:Word;

    begin
      HashValue:=(40543*((((ASource^[X] shl 4) xor ASource^[X+1]) shl 4) xor ASource^[X+2]) SHR 4) AND $0FFF;
      result:=false;
      TmpHash:=AHash^[HashValue];
      if (TmpHash <> -1) and (X - TmpHash < 4096) then
        begin
          pos:=TmpHash;
          iSize:=0;
          while((iSize < 18) and (ASource^[X+iSize] = ASource^[Pos+iSize]) and (X+iSize<SourceSize)) do Inc(iSize);
          result:=(iSize >= 3)
        end;
      AHash^[HashValue] := X
    end;


begin

  try
    Getmem(Hash,Sizeof(LZTable));
  except
    raise EInvalidPointer.Create('LZRW Error!');
    exit;
  end;

  FillChar(Hash^, SizeOf(LZTable), $FF);
  Dest^[0]:=FLAG_Compress;X:=0;Y:=3;Z:=1;Bit:=0;Command:=0;
  while (X<SourceSize) and (Y<=SourceSize) do
    begin
      if (Bit>15) then
        begin
          Dest^[Z]:=Hi(Command);
          Dest^[Z+1]:=Lo(Command);
          Z:=Y;Bit := 0;Inc(Y,2)
        end;
        Size:=1;
      while ((Source^[X] = Source^[X+Size]) and (Size<$FFF) and (X+Size<SourceSize)) do Inc(Size);

      if (Size >= 16) then
        begin
          Dest^[Y]:=0;Dest^[Y+1]:=Hi(Size-16);
          Dest^[Y+2]:=Lo(Size-16);Dest^[Y+3]:=Source^[X];
          Inc(Y,4);Inc(X,Size);
          Command:=(Command shl 1) + 1;
        end
      else
        if (FindMatch(Source,X,SourceSize,Hash,Size,Pos)) then
          begin
            Key:=((X-Pos) shl 4) + (Size-3);
            Dest^[Y]:=Hi(Key); Dest^[Y+1]:=Lo(Key);
            Inc(Y,2);Inc(X,Size);
            Command:=(Command SHL 1) + 1
          end
        else
          begin
            Dest^[Y]:=Source^[X];
            Inc(Y);Inc(X);
            Command:=Command shl 1
          end;
      Inc(Bit);
    end;

  Command := Command shl (16-Bit);
  Dest^[Z] := HI(Command); Dest^[Z+1] := LO(Command);
  if (Y>SourceSize) then
    begin
      Move(Source^[0],Dest^[1],SourceSize);
      Dest^[0] := FLAG_Copied;
      Y:=Succ(SourceSize)
    end;
  Result:=Y;

  if (Hash<>nil) then Freemem(Hash, Sizeof(LZTable));
END;

{------------------------------------------------------------------------------}
function  LMDLZRWDecompress(Source,Dest:PBuffer;Size:TBufferSize):TBufferSize;
var
  X,Y,SaveY, Pos:TBufferIndex;
  BSize,K, Command:Word;
  Bit:Byte;

begin
  SaveY:=0;
  IF (Source^[0]=FLAG_Copied) then
    begin
      for y:=1 to Pred(Size) do
        begin
          Dest^[Pred(Y)]:=Source^[Y];
          SaveY:=Y;
        end;
       Y:=SaveY;
    end
  else
    begin
      y:=0;X:=3;
      Command := (Source^[1] SHL 8) + Source^[2];
      Bit:=16;
      while (X<Size) do
        begin
          if (Bit=0) then
            begin
              Command:=(Source^[X] shl 8) + Source^[X+1];
              Bit := 16;
              Inc(X,2)
            end;
          if ((Command and $8000) = 0) then
            begin
              Dest^[Y] := Source^[X];
              inc(X); inc(Y)
            end
          else
            begin
              Pos:=((Source^[X] shl 4)+(Source^[X+1] shr 4));
              if (Pos = 0) then
                begin
                  BSize:=(Source^[X+1] shl 8) + Source^[X+2] + 15;
                  for k:=0 to BSize do
                    Dest^[Y+K] := Source^[X+3];
                  Inc(X,4); Inc(Y,BSize+1)
                end
            else
              begin
                BSize:=(Source^[X+1] and $0F)+2;
                for k:=0 to BSize do
                  Dest^[Y+K] := Dest^[Y-Pos+K];
                Inc(X,2);Inc(Y,BSize+1)
              end;
        end;
      Command := Command shl 1;
      Dec(Bit);
    end;
  end;
  result:=y
end;


function LMDZLibCompress(const Source: PBuffer; var Dest: PBuffer; SourceSize: Cardinal): Cardinal;
var
  LStrm: TZStreamRec;
  LP: Pointer;
  LDestSize: Cardinal;
  LSelfAllocated: Boolean;
begin
  FillChar(LStrm, SizeOf(LStrm), 0);
  LStrm.zalloc := zlibAllocMem;
  LStrm.zfree := zlibFreeMem;

  LDestSize := ((SourceSize + (SourceSize div 10) + 12) + 255) and not 255;
  if not Assigned(Dest) then
  begin
    GetMem(Dest, LDestSize);
    LSelfAllocated := True;
  end
  else
  begin
    LDestSize := SourceSize;
    LSelfAllocated := False;
  end;
  try
    LStrm.next_in := PAnsiChar(Source);
    LStrm.avail_in := SourceSize;
    LStrm.next_out := PAnsiChar(Dest);
    LStrm.avail_out := LDestSize;
    CCheck(deflateInit_(LStrm, Z_BEST_COMPRESSION, zlib_version, SizeOf(LStrm)));
    try
      while CCheck(deflate(LStrm, Z_FINISH)) <> Z_STREAM_END do
      begin
        LP := Dest;
        Inc(LDestSize, 256);
        ReallocMem(Dest, LDestSize);
        LStrm.next_out := PAnsiChar(TLMDPtrInt(Dest) + (TLMDPtrInt(LStrm.next_out) - TLMDPtrInt(LP)));
        LStrm.avail_out := 256;
      end;
    finally
      CCheck(deflateEnd(LStrm));
    end;
    if LSelfAllocated then
      ReallocMem(Dest, LStrm.total_out);
    Result := LStrm.total_out;
  except
    FreeMem(Dest);
    raise
  end;
end;

function LMDZLibDecompress(const Source: PBuffer; var Dest: PBuffer; Size: Cardinal): Cardinal;
var
  LStrm: TZStreamRec;
  LP: Pointer;
  LBufInc: Integer;
  LDestSize: Integer;
  LSelfAllocated: Boolean;
begin
  FillChar(LStrm, SizeOf(LStrm), 0);
  LStrm.zalloc := zlibAllocMem;
  LStrm.zfree := zlibFreeMem;

  LBufInc := (Size + 255) and not 255;
  LDestSize := LBufInc;
  if not Assigned(Dest) then
  begin
    GetMem(Dest, LDestSize);
    LSelfAllocated := True;
  end
  else
  begin
    LDestSize := Size;
    LSelfAllocated := False;
  end;
  try
    LStrm.next_in := PAnsiChar(Source);
    LStrm.avail_in := Size;
    LStrm.next_out := PAnsiChar(Dest);
    LStrm.avail_out := LDestSize;
    CCheck(inflateInit_(LStrm, zlib_version, sizeof(LStrm)));
    try
      while CCheck(inflate(LStrm, Z_NO_FLUSH)) <> Z_STREAM_END do
      begin
        LP := Dest;
        Inc(LDestSize, LBufInc);
        ReallocMem(Dest, LDestSize);
        LStrm.next_out := PAnsiChar(TLMDPtrInt(Dest) + (TLMDPtrInt(LStrm.next_out) - TLMDPtrInt(LP)));
        LStrm.avail_out := LBufInc;
      end;
    finally
      CCheck(inflateEnd(LStrm));
    end;
    if LSelfAllocated then
      ReallocMem(Dest, LStrm.total_out);
    Result := LStrm.total_out;
  except
    FreeMem(Dest);
    raise
  end;
end;


{------------------------------------------------------------------------------}
procedure LMDSaveCompressedStream(src, target:TStream; size:LongInt; cType:TLMDCompressionType=ctLZRW);
var
  bi, bo: PBuffer;
  oldPos, newpos, c, r,s:LongInt;
  LBufSize: integer;
begin
  c:=0;
  oldPos:=target.Position;
  target.Position:=oldpos+sizeof(c);
  if cType = ctLZRW then
    LBufSize := MaxBufferIndex
  else
    LBufSize := MaxBufferIndex - 14;

  bi:=nil;
  bo:=nil;
  try
    GetMem(bi, LBufSize);
    GetMem(bo, LBufSize);
    while Size>0 do
    begin
        r:=src.Read(bi^, LBufSize);
        case cType of
          ctLZRW: s:= LMDLZRWCompress(bi, bo, r);
          ctZLib: s:= LMDZLibCompress(bi, bo, r);
        end;
        target.Write(s, SizeOf(s));
        target.WriteBuffer(bo^, s);
        Inc(c, s+SizeOf(s));
        Dec(Size, r);
    end;
    newpos:=target.Position;
    target.Position:=oldPos;
    target.Write(c, SizeOf(c));
    target.Position:=newPos;
  finally
    FreeMem(bi, MaxBufferIndex);
    FreeMem(bo, MaxBufferIndex);
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDLoadCompressedStream(src, target:TStream; cType:TLMDCompressionType=ctLZRW);
var
  c, s, srcsize:LongInt;
  bi, bo: PBuffer;
begin
  bi:=nil;
  bo:=nil;
  try
    GetMem(bi, MaxBufferIndex);
    GetMem(bo, MaxBufferIndex);
    src.Read(srcSize, SizeOf(srcSize));
    while srcSize>0 do
      begin
        src.Read(c, SizeOf(c));
        src.ReadBuffer(bi^, c);
        case cType of
          ctZLib: s:=LMDZLibDeCompress(bi, bo, c);
        else
          s:=LMDLZRWDecompress(bi, bo, c);
        end;
        target.WriteBuffer(bo^, s);
        Dec(srcSize, c+sizeof(c));
      end;
  finally
    FreeMem(bi, MaxBufferIndex);
    FreeMem(bo, MaxBufferIndex);
  end;
end;

{------------------------------------------------------------------------------}
function LMDInc(var i: Integer): Integer;
begin
  inc(i);
  result := i;
end;

{------------------------------------------------------------------------------}
function LMDDec(var i: Integer): Integer;
begin
  dec(i);
  result := i;
end;

// small helpers
{------------------------------------------------------------------------------}
procedure LMDMailTo(const aAddress: String; const aSubject:String='');
var
  Buffer: String;
begin
  buffer:='';
  if pos('mailto:', aAddress)=0 then
    buffer := 'mailto:';
  buffer:=buffer+aAddress;
  if aSubject<>'' then
    buffer:=buffer+'?subject='+aSubject;
  LMDFireURL(buffer);
end;

{------------------------------------------------------------------------------}
function LMDFireURL(const URL: TLMDString; ALocal: Boolean=false): Boolean;
var
  {$ifdef LMD_UNICODE}
  SHIW  :TShellExecuteInfoW;
  {$endif}
  SHI  :TShellExecuteInfo;
  URL2 :TLMDString;
begin
  URL2 := URL;
  if Pos(':', URL2) = 0 then
    begin
      if LMDAnsiContainsAt(URL2, 1, 'www') then
        begin
          if not ALocal then
            URL2 := 'http://' + URL2;
        end
      else
        begin
          if LMDAnsiContainsAt(URL2, 1, 'ftp') then
            begin
              URL2 := 'ftp://' + URL2;
            end
          else
            begin
              if Pos('@', URL2) > 1 then
                begin
                  URL2 := 'mailto:' + URL2;
                end;
            end;
        end;
    end;
  {$ifdef LMD_UNICODE}
  if LMDSIWindowsNT then
    begin
      ZeroMemory(@SHIW, SizeOf(SHIW));
      SHIW.cbSize := SizeOf(SHIW);
      SHIW.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_NOCLOSEPROCESS;
      SHIW.Wnd := 0{Application.Handle};
      SHIW.lpVerb := 'Open';
      SHIW.lpFile := PWideChar(URL2);
      SHIW.lpParameters := nil;
      SHIW.lpDirectory := nil;
      Result := ShellExecuteExW(@SHIW);
      if Result then
        begin
          CloseHandle(SHIW.hProcess);
        end;
    end
  else
  {$endif}
    begin
      ZeroMemory(@SHI, SizeOf(SHI));
      SHI.cbSize := SizeOf(SHI);
      SHI.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_NOCLOSEPROCESS;
      SHI.Wnd := 0{Application.Handle};
      SHI.lpVerb := int_Ref('Open');
      SHI.lpFile := int_Ref(String(URL2));
      SHI.lpParameters := nil;
      SHI.lpDirectory := nil;
      Result := ShellExecuteEx(@SHI);
      if Result then
        begin
          CloseHandle(SHI.hProcess);
        end;
    end;
end;

{------------------------------------------------------------------------------}
function LMDExecute(const Verb, FileName: string): Boolean;
var
  SHI : TShellExecuteInfo;
begin
  ZeroMemory(@SHI, SizeOf(SHI));
  SHI.cbSize := SizeOf(SHI);
  SHI.fMask := 0;//SEE_MASK_INVOKEIDLIST;
  SHI.nShow := SW_SHOWNORMAL;
  SHI.lpIDList := nil;
  SHI.lpFile := Int_Ref(FileName);
  SHI.lpVerb := Int_Ref('open');
  Result := ShellExecuteEx(@SHI);

  if  (SHI.hProcess <> 0) and (SHI.hProcess <> INVALID_HANDLE_VALUE)  then
    CloseHandle(SHI.hProcess);
end;

//Others
function LMDGetShiftState: TShiftState;
begin
  Result := [];
  if GetKeyState(VK_MENU) < 0 then
    Include(Result, ssAlt);
  if GetKeyState(VK_CONTROL) < 0 then
    Include(Result, ssCtrl);
  if GetKeyState(VK_Shift) < 0 then
    Include(Result, ssShift);
end;

function LMDPointInRect(APoint: TPoint; ARect: TRect): boolean;
begin
  with APoint, ARect do
    Result := (X >= Left) and (X <= Right ) and (Y >= Top) and (Y <= Bottom);
end;

function LMDMiddlePoint(APoint1, APoint2: TPoint): TPoint;
var
  x, y: integer;
begin
  x := (APoint1.X + APoint2.X) div 2;
  y := (APoint1.Y + APoint2.Y) div 2;
  result := Point(x, y);  
end;

function  LMDShiftStateToString(AState: TShiftState): TLMDString;
var State: TShiftState;
begin
  result := '[';
  State := [];

  if ssShift in AState then
  begin
    result := result+'ssShift';
    Include(State, ssShift);
    if State <> AState then
      result := result+', ';
  end;

  if ssAlt in AState then
  begin
    result := result+'ssAlt';
    Include(State, ssAlt);
    if State <> AState then
      result := result+', ';
  end;

  if ssCtrl in AState then
  begin
    result := result+'ssCtrl';
    Include(State, ssCtrl);
    if State <> AState then
      result := result+', ';
  end;

  if ssLeft in AState then
  begin
    result := result+'ssLeft';
    Include(State, ssLeft);
    if State <> AState then
      result := result+', ';
  end;

  if ssRight in AState then
  begin
    result := result+'ssRight';
    Include(State, ssRight);
    if State <> AState then
      result := result+', ';
  end;

  if ssMiddle in AState then
  begin
    result := result+'ssMiddle';
    Include(State, ssMiddle);
    if State <> AState then
      result := result+', ';
  end;

  if ssDouble in AState then
    result := result+'ssDouble';

  result := result + ']'
end;

function LMDInRange(AVal, ALower, AUpper: Integer): Boolean;
begin
  result := (AVal >= ALower) and (AVal <= AUpper);
end;

function LMDMinMax(Val, AMin, AMax: Integer): Integer;
begin
  Val := Min(Val, AMax);
  Result := Max(Val, AMin);
end;

function LMDInRangeF(AVal, ALower, AUpper: double): boolean;
begin
  Result := not ((AVal < ALower) or (AVal > AUpper));
end;

{ ---------------------------------------------------------------------------- }
function LMDGetWorkSpaceRect: TRect;
{$IFNDEF LMDCOMP7}
const
  SM_XVIRTUALSCREEN = 76;
  SM_YVIRTUALSCREEN = 77;
  SM_CXVIRTUALSCREEN = 78;
  SM_CYVIRTUALSCREEN = 79;
{$ENDIF}
begin
  if LMDSIWindows98 or LMDSIWindows2000Up then
  begin
    result.Left := 0;
    result.Top := 0;
    result.Right := GetSystemMetrics(SM_CXVIRTUALSCREEN);
    result.Bottom := GetSystemMetrics(SM_CYVIRTUALSCREEN);
    OffsetRect(Result, GetSystemMetrics(SM_XVIRTUALSCREEN),
      GetSystemMetrics(SM_YVIRTUALSCREEN));
  end
  else
  begin
    result.Left := 0;
    result.Top := 0;
    result.Right := GetSystemMetrics(SM_CXSCREEN);
    result.Bottom := GetSystemMetrics(SM_CYSCREEN);
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDSetToString(const ATypeInfo: PTypeInfo; AValue: Integer; const ABrackets: Boolean): String;
var
  i: Integer;
begin
  Result := '';
  i := 0;
  while AValue <> 0 do
  begin
    if (AValue and $1) <> 0 then
    begin
      if Result <> '' then
        Result := Result + ', ';
      Result := Result + GetEnumName(ATypeInfo, 1 shl I);
    end;
    AValue := AValue shr 1;
    Inc(I);
  end;

  if ABrackets then
    Result := '[' + Result + ']';
end;

{ ---------------------------------------------------------------------------- }
function LMDDataToStr(Buffer: Pointer; BufLen: integer): TLMDString;
var
  p: PByteArr;
  i: integer;
begin
  P := PByteArr(Buffer);
  Result := '454C ' + IntToHex(BufLen, 1) + ' ';
  for i := 0 to BufLen - 1 do
    Result := Result + IntToHex(P[i], 2) + ' ';
end;

function LMDStrToData(S: TLMDString; var Buffer: Pointer; var BufLen: integer): boolean;
var
  p: PByteArr;
  S1: TLMDString;
  i, j: integer;
  b: boolean;
begin
  Result := false;
  BufLen := -1;
  Buffer := nil;
  if pos('454C', S) <> 1 then exit;
  Delete(S, 1, 5);
  S1 := LMDExtractStr(S, 1, Pos(' ', S) - 1);
  Delete(S, 1, 1);

  if S1 = '' then exit;
  try
    j := LMDH2D(S1);
  except
    exit;
  end;
  GetMem(Buffer, j);
  p := PByteArr(Buffer);
  BufLen := j;
  try
    for i := 0 to J - 1 do
    begin
      if Pos(' ', S) > 0 then
      begin
        S1 := LMDExtractStr(S, 1, Pos(' ', S) - 1);
        Delete(S, 1, 1);
        b := False;
      end
      else
      begin
        S1 := S;
        b := true;
      end;
      p[i] := LMDH2D(S1);
      if b and (i < j - 1) then
         break;
    end;
    Result := i >= j;
  except
    Result := False;
  end;
end;

{ ******************************* TLMDRawMemory ****************************** }
{------------------------------------------------------------------------------}
constructor TLMDRawMemory.Create(AMemory: UniPtr);
begin
  inherited Create;
  FMemory := AMemory;
  FOffsetSize := 1;
end;

{------------------------------------------------------------------------------}
constructor TLMDRawMemory.Create;
begin
  inherited;
  FMemory := nil;
  FOffsetSize := 1;
  FBaseOffset := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDRawMemory.SetOffsetSize(Value: Integer);
begin
  if Value <> 0 then
    FOffsetSize := Value;
end;

{------------------------------------------------------------------------------}
function TLMDRawMemory.GetBytes(Offset: Integer): byte;
begin
  Result := 0;
  if TLMDPtrInt(FMemory) = 0 then
    exit;
  Result := PByte(TLMDPtrInt(FMemory) + (FBaseOffset + Offset) * FOffsetSize)^;
end;

{------------------------------------------------------------------------------}
function TLMDRawMemory.GetDWords(Offset: Integer): DWord;
begin
  Result := 0;
  if TLMDPtrInt(FMemory) = 0 then
    exit;
  Result := PDword(TLMDPtrInt(FMemory) + (FBaseOffset + Offset) * FOffsetSize)^;
end;

{------------------------------------------------------------------------------}
function TLMDRawMemory.GetInt64(Offset: Integer): Int64;
begin
  Result := 0;
  if TLMDPtrInt(FMemory) = 0 then
    exit;
  Result := PInt64(TLMDPtrInt(FMemory) + (FBaseOffset + Offset) * FOffsetSize)^;
end;

{------------------------------------------------------------------------------}
function TLMDRawMemory.GetWords(Offset: Integer): word;
begin
  Result := 0;
  if TLMDPtrInt(FMemory) = 0 then
    exit;
  Result := PWord(TLMDPtrInt(FMemory) + (FBaseOffset + Offset) * FOffsetSize)^;
end;

{------------------------------------------------------------------------------}
procedure TLMDRawMemory.SetBytes(Offset: Integer; const Value: byte);
begin
  if TLMDPtrInt(FMemory) = 0 then
    exit;
  PByte(TLMDPtrInt(FMemory) + (FBaseOffset + Offset) * FOffsetSize)^ := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDRawMemory.SetDWords(Offset: Integer; const Value: DWord);
begin
  if TLMDPtrInt(FMemory) = 0 then
    exit;
  PDWord(TLMDPtrInt(FMemory) + (FBaseOffset + Offset) * FOffsetSize)^ := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDRawMemory.SetInt64(Offset: Integer; const Value: Int64);
begin
  if TLMDPtrInt(FMemory) = 0 then
    exit;
  PInt64(TLMDPtrInt(FMemory) + (FBaseOffset + Offset) * FOffsetSize)^ := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDRawMemory.SetWords(Offset: Integer; const Value: word);
begin
  if TLMDPtrInt(FMemory) = 0 then
    exit;
  PWord(TLMDPtrInt(FMemory) + (FBaseOffset + Offset) * FOffsetSize)^ := Value;
end;

procedure TLMDRawMemory.SetBaseOffset(const Value: Integer);
begin
  if FBaseOffset <> Value then
    FBaseOffset := Value;
end;


end.
