unit LMDFxBitmap;
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

LMDFxBitmap unit (RM, AH)
------------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Types, SysUtils, Classes, Windows, Graphics, Math, Clipbrd, LMDTypes;

type
  PLMDFxColor = ^TLMDFxColor;
  TLMDFxColor = type cardinal;

  PLMDFxColorRec = ^TLMDFxColorRec;
  TLMDFxColorRec = packed record
    case Cardinal of
      0: (Color: Cardinal);
      2: (HiWord, LoWord: Word);
      3: (B, G, R, A: Byte);
    end;
  PLMDFxColorRecBor = ^TLMDFxColorRecBor;
  TLMDFxColorRecBor = packed record
    case Cardinal of
      0: (Color: Cardinal);
      2: (HiWord, LoWord: Word);
      3: (R, G, B, A: Byte);
    end;
  PLMDFxColorArray = ^TLMDFxColorArray;
  TLMDFxColorArray = array [0..0] of TLMDFxColor;
  PLMDFxColorRecArray = ^TLMDFxColorRecArray;
  TLMDFxColorRecArray = array [0..0] of TLMDFxColorRec;
  TArrayOfLMDFxColor = array of TLMDFxColor;

const
  LMDFxTransparent         = $007F007F;
  AlphaMask                = $FF000000;
  LMDFxBlack               : TLMDFxColor = $FF000000;
  LMDFxGray                : TLMDFxColor = $FF7F7F7F;
  LMDFxWhite               : TLMDFxColor = $FFFFFFFF;
  LMDFxMaroon              : TLMDFxColor = $FF7F0000;
  LMDFxGreen               : TLMDFxColor = $FF007F00;
  LMDFxOlive               : TLMDFxColor = $FF7F7F00;
  LMDFxNavy                : TLMDFxColor = $FF00007F;
  LMDFxPurple              : TLMDFxColor = $FF7F007F;
  LMDFxTeal                : TLMDFxColor = $FF007F7F;
  LMDFxRed                 : TLMDFxColor = $FFFF0000;
  LMDFxLime                : TLMDFxColor = $FF00FF00;
  LMDFxYellow              : TLMDFxColor = $FFFFFF00;
  LMDFxBlue                : TLMDFxColor = $FF0000FF;
  LMDFxFuchsia             : TLMDFxColor = $FFFF00FF;
  LMDFxAqua                : TLMDFxColor = $FF00FFFF;
  LMDFxMenu                : TLMDFxColor = $FFEDEDEE;
  LMDFxBorder              : TLMDFxColor = $FF003399;
  LMDFxWindow              : TLMDFxColor = $FFEBEBEE;
  LMDFxBtnFace             : TLMDFxColor = $FFD2D2D2;
  LMDFxBtnShadow           : TLMDFxColor = $FFA8A8A8;
  LMDFxHotHighlight        : TLMDFxColor = $FFF8C751;
  LMDFxHighlight           : TLMDFxColor = $FF64A0FF;
  LMDFxHintBack            : TLMDFxColor = $FFEBEBEE;
  LMDFxNone                : TLMDFxColor = $33333333;
  LMDFxTransparentVar      : TLMDFxColor = LMDFxTransparent;

type

  TLMDFxBitmapLink = class;

  { ************************ class TLMDFxBitmap ****************************** }
  TLMDFxBitmap = class(TPersistent)
  private
    FBits: PLMDFxColorArray;
    FWidth, FHeight: integer;
    FName: string;
    FBitmapInfo: TBitmapInfo;
    FHandle: HBITMAP;
    FDC: HDC;
    FAlphaBlend: boolean;
    FTransparent: boolean;
    FNewFormat: boolean;
    function  GetPixel(X, Y: Integer): TLMDFxColor;
    procedure SetPixel(X, Y: Integer; Value: TLMDFxColor);
    function GetPixelPtr(X, Y: Integer): PLMDFxColor;
    function GetScanLine(Y: Integer): PLMDFxColorArray;
    protected
    public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    { }
    procedure SetSize(AWidth, AHeight: Integer);
    procedure Clear(Color: TLMDFxColor);
    function Empty: boolean;
    { I/O }
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    procedure SaveToBitmapFile(AFileName: string);
    procedure LoadFromPcxStream(Stream: TStream);
    procedure LoadFromResource(const ResFileName, ResName: string);
    { BitmapLink }
    function GetBitmapLink(Rect: TRect): TLMDFxBitmapLink; overload;
    function GetBitmapLink(Rect: string): TLMDFxBitmapLink; overload;
    { Checking }
    procedure CheckingTransparent(Color: TLMDFxColor = LMDFxTransparent); overload;
    procedure CheckingTransparent(ARect: TRect; Color: TLMDFxColor = LMDFxTransparent); overload;
    procedure CheckingAlphaBlend; overload;
    procedure CheckingAlphaBlend(ARect: TRect); overload;
    procedure SetAlpha(Alpha: byte); overload;
    procedure SetAlpha(Alpha: byte; Rect: TRect); overload;
    { Color transition }
    procedure SetBitmapHue(Hue: integer);
    procedure ChangeBitmapSat(DeltaSat: integer);
    procedure ChangeBitmapHue(DeltaHue: integer);
    procedure ChangeBitmapBrightness(DeltaBrightness: integer);
    { Manipulation }
    procedure FlipHorz;
    { Paint routines }
    {procedure MoveTo(X, Y: integer);
    procedure LineTo(X, Y: integer; Color: TLMDFxColor);}
    procedure DrawGraphic(Graphic: TGraphic; DstRect: TRect);
    procedure FillRect(R: TRect; Color: TLMDFxColor);
    {procedure FillRoundRect(R: TRect; Radius: integer; Color: TLMDFxColor);
    procedure FillHalftoneRect(R: TRect; Color, HalfColor: TLMDFxColor);
    procedure FillGradientRect(Rect: TRect; BeginColor, EndColor: TLMDFxColor; Vertical: boolean);
    procedure FillRadialGradientRect(Rect: TRect; BeginColor, EndColor: TLMDFxColor; Pos: TPoint);
    procedure FillEllipse(R: TRect; Color: TLMDFxColor);
    procedure FillPolygon(Points: array of TPoint; Color: TColor);
    procedure FillHalftonePolygon(Points: array of TPoint; Color, HalfColor: TLMDFxColor);
    procedure DrawEdge(R: TRect; RaisedColor, SunkenColor: TLMDFxColor);
    procedure DrawBevel(R: TRect; Color: TLMDFxColor; Width: integer; Down: boolean);
    procedure DrawRect(R: TRect; Color: TLMDFxColor);
    procedure DrawFocusRect(R: TRect; Color: TLMDFxColor);
    procedure DrawRoundRect(R: TRect; Radius: integer; Color: TLMDFxColor);
    procedure DrawLine(R: TRect; Color: TLMDFxColor);
    procedure DrawEllipse(R: TRect; Color: TLMDFxColor);
    procedure DrawPolygon(Points: array of TPoint; Color: TColor);
    function DrawText(AText: WideString; var Bounds: TRect; Flag: cardinal): integer; overload;
    function DrawText(AText: WideString; X, Y: integer): integer; overload;
    function DrawVerticalText(AText: WideString; Bounds: TRect; Flag: cardinal; FromTop: boolean): integer;
    function TextWidth(AText: WideString; Flags: Integer = 0): integer;
    function TextHeight(AText: WideString): integer;}
    { Draw to Canvas }
    procedure Draw(DC: HDC; X, Y: integer); overload;
    procedure Draw(DC: HDC; X, Y: integer; SrcRect: TRect); overload;
    procedure Draw(DC: HDC; DstRect: TRect); overload;
    procedure Draw(DC: HDC; DstRect, SrcRect: TRect); overload;
    procedure Draw(Canvas: TCanvas; X, Y: integer); overload;
    procedure Draw(Canvas: TCanvas; X, Y: integer; SrcRect: TRect); overload;
    procedure Draw(Canvas: TCanvas; DstRect: TRect); overload;
    procedure Draw(Canvas: TCanvas; DstRect, SrcRect: TRect); overload;
    { Draw to TLMDFxBitmap }
    procedure Draw(Bitmap: TLMDFxBitmap; X, Y: integer); overload;
    procedure Draw(Bitmap: TLMDFxBitmap; X, Y: integer; SrcRect: TRect); overload;
    procedure Draw(Bitmap: TLMDFxBitmap; DstRect: TRect); overload;
    procedure Draw(Bitmap: TLMDFxBitmap; DstRect, SrcRect: TRect); overload;
    { Complex Draw }
    procedure Tile(DC: HDC; DstRect, SrcRect: TRect); overload;
    procedure Tile(Canvas: TCanvas; DstRect, SrcRect: TRect); overload;
    procedure Tile(Bitmap: TLMDFxBitmap; DstRect, SrcRect: TRect); overload;
    procedure TileClip(DC: HDC; DstRect, DstClip, SrcRect: TRect); overload;
    procedure TileClip(Canvas: TCanvas; DstRect, DstClip, SrcRect: TRect); overload;
    procedure TileClip(Bitmap: TLMDFxBitmap; DstRect, DstClip, SrcRect: TRect); overload;
    { Alpha blend two bitmap }
    procedure MergeDraw(Bitmap: TLMDFxBitmap; X, Y: integer; SrcRect: TRect);
    { Low-level access}
    property Handle: HBITMAP read FHandle;
    property DC: HDC read FDC;
    { Access properties }
    property Bits: PLMDFxColorArray read FBits;
    property Pixels[X, Y: Integer]: TLMDFxColor read GetPixel write SetPixel; default;
    property PixelPtr[X, Y: Integer]: PLMDFxColor read GetPixelPtr;
    property ScanLine[Y: Integer]: PLMDFxColorArray read GetScanLine;
    property Width: integer read FWidth;
    property Height: integer read FHeight;
    { States }
    property AlphaBlend: boolean read FAlphaBlend write FAlphaBlend;
    property Transparent: boolean read FTransparent write FTransparent;
    { Persitent properties }
    property Name: string read FName write FName;
    property NewFormat: boolean read FNewFormat write FNewFormat;
  published
  end;

  { ************************ class TLMDFxBitmapLink ************************** }
  TLMDFxBitmapLink = class(TPersistent)
  private
    FImage: TLMDFxBitmap;
    FRect: TRect;
    FName: string;
    FMaskedBorder: boolean;
    FMaskedAngles: boolean;
    FMasked: boolean;
    function GetBottom: integer;
    function GetLeft: integer;
    function GetRight: integer;
    function GetTop: integer;
    procedure SetBottom(const Value: integer);
    procedure SetLeft(const Value: integer);
    procedure SetRight(const Value: integer);
    procedure SetTop(const Value: integer);
    function GetAssigned: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure CheckingMasked; overload;
    procedure CheckingMasked(Margin: TRect); overload;
    procedure Draw(Canvas: TCanvas; X, Y: integer); overload;
    procedure Draw(Bitmap: TLMDFxBitmap; X, Y: integer); overload;
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);

    property Assigned: boolean read GetAssigned;
    property Image: TLMDFxBitmap read FImage write FImage;
    property Rect: TRect read FRect write FRect;
    property Masked: boolean read FMasked write FMasked;
    property MaskedBorder: boolean read FMaskedBorder write FMaskedBorder;
    property MaskedAngles: boolean read FMaskedAngles write FMaskedAngles;
  published
    property Name: string read FName write FName;
    property Left: integer read GetLeft write SetLeft;
    property Top: integer read GetTop write SetTop;
    property Right: integer read GetRight write SetRight;
    property Bottom: integer read GetBottom write SetBottom;
  end;

  { ************************ class TLMDFxBitmapList ************************** }
  TLMDFxBitmapList = class(TList)
  private
    function GetImage(index: integer): TLMDFxBitmap;
    function GetBitmapByName(index: string): TLMDFxBitmap;
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Clear; override;

    function GetBitmapLink(Image: TLMDFxBitmap; Rect: TRect): TLMDFxBitmapLink; overload;
    function GetBitmapLink(Name: string; Rect: TRect): TLMDFxBitmapLink; overload;
    function GetBitmapLink(Name, Rect: string): TLMDFxBitmapLink; overload;

    property Bitmaps[index: integer]: TLMDFxBitmap read GetImage; default;
    property BitmapByName[index: string]: TLMDFxBitmap read GetBitmapByName;
  end;

{ Color functions }
function LMDFxColor(Color: TColor; A: Byte = $FF): TLMDFxColor; overload;
function LMDFxColor(R, G, B: SmallInt; A: Byte = $FF): TLMDFxColor; overload;

function LMDFxColor(ColorRec: TLMDFxColorRec): TLMDFxColor; overload;

function LMDFxColorToColor(Color: TLMDFxColor): TColor;
function LMDFxColorToColor16(Color: TLMDFxColor): word; // 16-bit, 5-6-5
function LMDFxColorToColor15(Color: TLMDFxColor): word; // 15-bit, 5-5-5

const
  EnableDibOperation: boolean = true; // Use dib routines from DC

{ Function prototypes }
type
  TLMDFxAlphaBlendPixel = function (Src, Dst: TLMDFxColor): TLMDFxColor;
  TLMDFxAlphaBlendLine = procedure (Src, Dst: PLMDFxColor; Count: Integer);
  TLMDFxTransparentLine = procedure (Src, Dst: PLMDFxColor; Count: Integer);
  TLMDFxMoveLongword = procedure (const Src: Pointer; Dst: Pointer; Count: Integer);
  TLMDFxFillLongword = procedure (Src: Pointer; Count: integer; Value: longword);
  TLMDFxFillLongwordRect = procedure (Src: Pointer; W, H, X1, Y1, X2, Y2: integer;
    Value: longword);
  TLMDFxFillAlpha = procedure (Src: Pointer; Count: integer; Alpha: byte);
  TLMDFxFillAlphaRect = procedure (Src: Pointer; W, H, X1, Y1, X2, Y2: integer; Alpha: byte);
  TLMDFxClearAlpha = procedure (Src: Pointer; Count: TLMDPtrInt; Value: longword);
  { Function variables }

var
  PixelAlphaBlendFunc: TLMDFxAlphaBlendPixel;
  LineAlphaBlendFunc: TLMDFxAlphaBlendLine;
  LineTransparentFunc: TLMDFxTransparentLine;

  MoveLongwordFunc: TLMDFxMoveLongword;
  FillLongwordFunc: TLMDFxFillLongword;
  FillLongwordRectFunc: TLMDFxFillLongwordRect;

  FillAlphaFunc: TLMDFxFillAlpha;
  FillAlphaRectFunc: TLMDFxFillAlphaRect;

  ClearAlphaFunc: TLMDFxClearAlpha;

function MulDiv16(Number, Numerator, Denominator: Word): Word;

function FromRGB(Color32: longword): longword;
function ToRGB(Color: longword): longword;

{ Function prototypes }

type
  TLMDFxStretchToDCOpaque = procedure (DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
    SrcBmp: TLMDFxBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
  TLMDFxStretchToDCTransparent = procedure(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
    SrcBmp: TLMDFxBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
  TLMDFxStretchToDCAlphaBlend = procedure (DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
    SrcBmp: TLMDFxBitmap; SrcX, SrcY, SrcW, SrcH: Integer);

  TLMDFxStretchToDibOpaque = procedure (Bits: Pointer; DstRect, DstClip: TRect;
    BitsW, BitsH: integer; Src: TLMDFxBitmap; SrcRect: TRect);
  TLMDFxStretchToDibTransparent = procedure(Bits: Pointer; DstRect, DstClip: TRect;
    BitsW, BitsH: integer; Src: TLMDFxBitmap; SrcRect: TRect);
  TLMDFxStretchToDibAlphaBlend = procedure (Bits: Pointer; DstRect, DstClip: TRect;
    BitsW, BitsH: integer; Src: TLMDFxBitmap; SrcRect: TRect);
  TLMDFxStretchOpaque = procedure(Dst: TLMDFxBitmap; DstRect, DstClip: TRect; Src: TLMDFxBitmap;
    SrcRect: TRect);
  TLMDFxStretchTransparent = procedure(Dst: TLMDFxBitmap; DstRect, DstClip: TRect; Src: TLMDFxBitmap;
    SrcRect: TRect);
  TLMDFxStretchAlphaBlend = procedure(Dst: TLMDFxBitmap; DstRect, DstClip: TRect; var Src: TLMDFxBitmap;
    SrcRect: TRect);

  TLMDFxBltOpaque = procedure(Dst: TLMDFxBitmap; DstRect: TRect; Src: TLMDFxBitmap;
    SrcX, SrcY: Integer);
  TLMDFxBltTransparent = procedure(Dst: TLMDFxBitmap; DstRect: TRect; Src: TLMDFxBitmap;
    SrcX, SrcY: Integer);
  TLMDFxBltAlphaBlend = procedure(Dst: TLMDFxBitmap; DstRect: TRect; Src: TLMDFxBitmap;
    SrcX, SrcY: Integer);
  TLMDFxGetBitsFromDC = function(DC: HDC; var Width, Height, BitCount: integer): Pointer;
  { Function variables }

var
  { DC }
  StretchToDCOpaqueFunc: TLMDFxStretchToDCOpaque;
  StretchToDCAlphaBlendFunc: TLMDFxStretchToDCAlphaBlend;
  StretchToDCTransparentFunc: TLMDFxStretchToDCTransparent;
  { Dib }
  GetBitsFromDCFunc: TLMDFxGetBitsFromDC;
  StretchToDibOpaqueFunc: TLMDFxStretchToDibOpaque;
  StretchToDibAlphaBlendFunc: TLMDFxStretchToDibAlphaBlend;
  StretchToDibTransparentFunc: TLMDFxStretchToDibTransparent;
  { LMDFxBitmap }
  BltOpaqueFunc: TLMDFxBltOpaque;
  BltAlphaBlendFunc: TLMDFxBltAlphaBlend;
  BltTransparentFunc: TLMDFxBltTransparent;
  StretchOpaqueFunc: TLMDFxStretchOpaque;
  StretchAlphaBlendFunc: TLMDFxStretchAlphaBlend;
  StretchTransparentFunc: TLMDFxStretchTransparent;

implementation

uses
  LMDFxUtils, LMDUtils;

type
  TGraphicAccess = class(TGraphic);

  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;

//To test the hashing implementatiotn, you should define "LMDFX_USE_HASH" in lmdcmps.inc
 { TStringHash }
  PPHashItem = ^PHashItem;
  PHashItem = ^THashItem;
  THashItem = record
    Next: PHashItem;
    Key: Cardinal;
    Value: Integer;
  end;
  { Based on TStringHash class by Borland }
  TIntegerHash = class
  private
    Buckets: array of PHashItem;
    protected
    function Find(const Key: Cardinal): PPHashItem;
    function HashOfInteger(const Key: Cardinal): Cardinal;
  public
    constructor Create(Size: Cardinal = 256);
    destructor Destroy; override;
    procedure Add(const Key: Cardinal; Value: Integer);
    procedure Clear;
    function ValueOf(const Key: Cardinal): Integer;
  end;

  { TFasterHashedStringList - A TStringList that uses TIntegerHash to improve the
    speed of Find. Based on Borland's implementation. }
  TFasterHashedStringList = class(TStringList)
  private
    FValueHash: TIntegerHash;
    FValueHashValid: Boolean;
    procedure UpdateValueHash;
  protected
    procedure Changed; override;
  public
    destructor Destroy; override;
    function IndexOfDC(const DC: Cardinal): Integer;
  end;

var
  BitmapList: TFasterHashedStringList = nil;

{ TIntegerHash }
{ ---------------------------------------------------------------------------- }
procedure TIntegerHash.Add(const Key: Cardinal; Value: Integer);
var
  Hash: Integer;
  Bucket: PHashItem;
  begin
  Hash := HashOfInteger(Key) mod Cardinal(Length(Buckets));
  New(Bucket);
  Bucket^.Key := Key;
  Bucket^.Value := Value;
  Bucket^.Next := Buckets[Hash];
  Buckets[Hash] := Bucket;
  end;

{ ---------------------------------------------------------------------------- }
procedure TIntegerHash.Clear;
var
  I: Integer;
  P, N: PHashItem;
  begin
  for I := 0 to Length(Buckets) - 1 do
  begin
    P := Buckets[I];
    while P <> nil do
    begin
      N := P^.Next;
      Dispose(P);
      P := N;
    end;
    Buckets[I] := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }
constructor TIntegerHash.Create(Size: Cardinal);
begin
  inherited Create;
  SetLength(Buckets, Size);
end;

{ ---------------------------------------------------------------------------- }
destructor TIntegerHash.Destroy;
begin
  Clear;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

function TIntegerHash.Find(const Key: Cardinal): PPHashItem;

var
  Hash: Integer;
begin
  Hash := HashOfInteger(Key) mod Cardinal(Length(Buckets));
  Result := @Buckets[Hash];
  while Result^ <> nil do
  begin
    if Result^.Key = Key then
      Exit
    else
      Result := @Result^.Next;
  end;
  end;

{ ---------------------------------------------------------------------------- }
function TIntegerHash.HashOfInteger(const Key: Cardinal): Cardinal;

type
  TBuffer = array[0..0] of Cardinal;
  PBuffer = ^TBuffer;
var
  P: PBuffer;
  h: Cardinal;
  begin
  // start with a good "random" bit pattern so that
  // even single byte hashes are well scattered over
  // a 32-bit range
  Result := $9E3779B9;
  P := @Key;

  h := P[0];
  Inc(Result, ($9E3779B9 * h));
  // i.e. rotate the Result bit-pattern to the right to keep
  // early bits in the key from getting completely lost
  Result := (Result shr 15) or (Result shl 17);
end;

{ ---------------------------------------------------------------------------- }
function TIntegerHash.ValueOf(const Key: Cardinal): Integer;
var
  P: PHashItem;
  begin
  P := Find(Key)^;
  if P <> nil then
    Result := P^.Value
    else
    Result := -1;
end;

{ TFasterHashedStringList }
{ ---------------------------------------------------------------------------- }
procedure TFasterHashedStringList.Changed;
begin
  inherited Changed;
  FValueHashValid := False;
end;

{ ---------------------------------------------------------------------------- }
destructor TFasterHashedStringList.Destroy;
begin
  FValueHash.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TFasterHashedStringList.IndexOfDC(const DC: Cardinal): Integer;
begin
   UpdateValueHash;
   Result := FValueHash.ValueOf(DC);
end;

{ ---------------------------------------------------------------------------- }
function FastIntToStr(I: LongWord): string;
{$IFDEF LMDCOMP12}
var
  tmp:ShortString;
begin
  Str(I, tmp);
  result := String(tmp);
end;
{$ELSE}
begin
  Str(I, result);
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
function StrToCardinal(const S: string): Cardinal;
var
  I,L: Word;
begin
  I := 1;
  Result := 0;
  L:= Length(s);
  while I <= L do
  begin
    Result := Result * 10 + Ord(s[I]) - Ord('0');
    Inc(I);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TFasterHashedStringList.UpdateValueHash;
var
  I: Integer;
begin
  if FValueHashValid then Exit;

  if FValueHash = nil then
    FValueHash := TIntegerHash.Create
  else
    FValueHash.Clear;
  for I := 0 to Count - 1 do
    FValueHash.Add(StrToCardinal(Self[I]), I);
  FValueHashValid := True;
end;

{ BitmapList Routines }
{ ---------------------------------------------------------------------------- }
procedure AddBitmapToList(B: TLMDFxBitmap);
begin
  if BitmapList = nil then
    begin
      BitmapList := TFasterHashedStringList.Create;
      BitmapList.CaseSensitive := true; // Faster acces
    end;
  BitmapList.AddObject(FastIntToStr(B.DC),B); //Search based on DC
end;

{ ---------------------------------------------------------------------------- }
procedure RemoveBitmapFromList(B: TLMDFxBitmap);
var Index: Integer;
begin
  if BitmapList <> nil then
  begin
    Index := BitmapList.IndexOfDC(B.DC);
    if Index <> -1 then
      BitmapList.Delete(Index);
  end;
end;

{ ---------------------------------------------------------------------------- }
function FindBitmapByDC(DC: HDC): TLMDFxBitmap;
var
  i: integer;
begin
  i:= BitmapList.IndexOfDC(DC);
  if i <> -1 then
    Result := TLMDFxBitmap(BitmapList.Objects[i])
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure FreeBitmapList;
begin
  if BitmapList <> nil then FreeAndNil(BitmapList);
end;

{ Color function }
function LMDFxColor(Color: TColor; A: Byte = $FF): TLMDFxColor;
var
  C: TColor;
  Tmp: cardinal;
begin
  C := ColorToRGB(Color);
  Tmp := A;
  Result := FromRGB(C) + (Tmp shl 24);
end;

function LMDFxColor(R, G, B: SmallInt; A: Byte = $FF): TLMDFxColor;
begin
  if R > $FF then R := $FF;
  if G > $FF then G := $FF;
  if B > $FF then B := $FF;
  if R < 0 then R := 0;
  if G < 0 then G := 0;
  if B < 0 then B := 0;
  TLMDFxColorRec(Result).R := R;
  TLMDFxColorRec(Result).G := G;
  TLMDFxColorRec(Result).B := B;
  TLMDFxColorRec(Result).A := A;
  end;

function LMDFxColor(ColorRec: TLMDFxColorRec): TLMDFxColor;

begin
  Result := ToRGB(Longword(ColorRec));
  end;

function LMDFxColorToColor(Color: TLMDFxColor): TColor;
begin
  Result := ToRGB(Color);
end;

function LMDFxColorToColor16(Color: TLMDFxColor): word; // 16-bit, 5-6-5
{$IFDEF CLR_REMOVED}
var
  L_FxColorRecConv: TLMDFxColorRec;
{$ENDIF}
begin
  with TLMDFxColorRec(Color) do
    Result :=
      (R shr 3 shl 11) or  // R-5bit
      (G shr 2 shl 5) or   // G-6bit
      (B shr 3);           // B-5bit

  end;

function LMDFxColorToColor15(Color: TLMDFxColor): word; // 15-bit, 5-5-5
{$IFDEF CLR_REMOVE}
var
  L_FxColorRecConv: TLMDFxColorRec;
{$ENDIF}
begin
  with TLMDFxColorRec(Color) do
    Result :=
      (R shr 3 shl 10) or  // R-5bit
      (G shr 3 shl 5) or   // G-5bit
      (B shr 3);           // B-5bit
  end;

{ Color space conversions }

{$Q-}
{ ---------------------------------------------------------------------------- }
function HSLtoRGB(H, S, L: Single): TLMDFxColor;
var
  M1, M2: Single;
  R, G, B: Byte;

  function HueToColor(Hue: Single): Byte;
  var
    V: Double;
  begin
    Hue := Hue - Floor(Hue);

    if 6 * Hue < 1 then
      V := M1 + (M2 - M1) * Hue * 6
    else
      if 2 * Hue < 1 then
        V := M2
      else
        if 3 * Hue < 2 then
          V := M1 + (M2 - M1) * (2 / 3 - Hue) * 6
        else
          V := M1;
    Result := Round(255 * V);
  end;

begin
  if S = 0 then
    begin
      R := Round(255 * L);
      G := R;
      B := R;
    end
  else
    begin
      if L <= 0.5 then
        M2 := L * (1 + S)
      else
        M2 := L + S - L * S;
      M1 := 2 * L - M2;
      R := HueToColor(H + 1 / 3);
      G := HueToColor(H);
      B := HueToColor(H - 1 / 3)
    end;
  Result := LMDFxColor(R, G, B);
end;

{ ---------------------------------------------------------------------------- }
procedure RGBtoHSL(RGB: TLMDFxColor; out H, S, L: single);
var
  R, G, B, D, Cmax, Cmin: Single;
begin
  R := TLMDFxColorRec(RGB).R / 255;
  G := TLMDFxColorRec(RGB).G / 255;
  B := TLMDFxColorRec(RGB).B / 255;
  Cmax := Max(R, Max(G, B));
  Cmin := Min(R, Min(G, B));
  L := (Cmax + Cmin) / 2;

  if Cmax = Cmin then
    begin
      H := 0;
      S := 0
    end
  else
    begin
      D := Cmax - Cmin;
      if L < 0.5 then
        S := D / (Cmax + Cmin)
      else
        S := D / (2 - Cmax - Cmin);
      if R = Cmax then
        H := (G - B) / D
      else
        if G = Cmax then
          H  := 2 + (B - R) /D
        else
          H := 4 + (R - G) / D;
      H := H / 6;
      if H < 0 then H := H + 1
    end;
end;

{ -----------------------------------------------------------------------------}
function ChangeBrightness(Color: TLMDFxColor; DeltaBrightness: integer): TLMDFxColor;
var
  R, G, B: integer;
begin
  R := TLMDFxColorRec(Color).R;
  G := TLMDFxColorRec(Color).G;
  B := TLMDFxColorRec(Color).B;
  Inc(R, DeltaBrightness);
  Inc(G, DeltaBrightness);
  Inc(B, DeltaBrightness);
  Result := LMDFxColor(R, G, B);
end;

{ ---------------------------------------------------------------------------- }
function ChangeSat(Color: TLMDFxColor; DeltaSat: integer): TLMDFxColor;
var
  H, S, L: single;
  SValue: integer;
begin
  RGBtoHSL(Color, H, S, L);

  SValue := Round(S * 255);
  Inc(SValue, DeltaSat);

  if SValue > $FF then SValue := SValue - $FF;
  if SValue < 0 then SValue := $FF + SValue;

  Result := HSLtoRGB(H, SValue / $FF, L);
end;

{ ---------------------------------------------------------------------------- }
function SetHue(Color: TLMDFxColor; Hue: integer): TLMDFxColor;
var
  H, S, L: single;
begin
  RGBtoHSL(Color, H, S, L);

  if Hue > $FF then Hue := $Ff;
  if Hue < 0 then Hue := 0;

  Result := HSLtoRGB(Hue / 255, S, L);
end;

{ -----------------------------------------------------------------------------}
function ChangeHue(Color: TLMDFxColor; DeltaHue: integer): TLMDFxColor;
var
  H, S, L: single;
  HValue: integer;
begin
  RGBtoHSL(Color, H, S, L);

  HValue := Round(H * 255);
  Inc(HValue, DeltaHue);

  if HValue > 255 then HValue := HValue - 255;
  if HValue < 0 then HValue := 255 + HValue;

  Result := HSLtoRGB(HValue / 255, S, L);
end;

{ ************************ class TLMDFxBitmap ******************************** }
{ ------------------------------ private ------------------------------------- }

function TLMDFxBitmap.GetScanLine(Y: Integer): PLMDFxColorArray;
begin
  Result := @Bits[Y * FWidth];
end;

{ ---------------------------------------------------------------------------- }

function TLMDFxBitmap.GetPixelPtr(X, Y: Integer): PLMDFxColor;
begin
  Result := @Bits[X + Y * FWidth];
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxBitmap.GetPixel(X, Y: Integer): TLMDFxColor;
begin
  if (FBits <> nil) and (X >= 0) and (Y >= 0) and (X < Width) and (Y < Height) then

    Result := PixelPtr[X, Y]^

  else
    Result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.SetPixel(X, Y: Integer; Value: TLMDFxColor);
begin
  if X < 0 then Exit;
  if Y < 0 then Exit;
  if X > Width then Exit;
  if Y > Height then Exit;
  if FBits <> nil then
  PixelPtr[X, Y]^ := Value;
  end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDFxBitmap.AssignTo(Dest: TPersistent);
var
  Bmp: TBitmap;

  procedure CopyToBitmap(Bmp: TBitmap);
  begin
    Bmp.PixelFormat := pf32Bit;
    Bmp.Width := FWidth;
    Bmp.Height := FHeight;
    Draw(Bmp.Canvas, 0, 0);
  end;

begin
  if Dest is TPicture then CopyToBitmap(TPicture(Dest).Bitmap)
  else if Dest is TBitmap then CopyToBitmap(TBitmap(Dest))
  else if Dest is TClipboard then
  begin
    Bmp := TBitmap.Create;
    try
      CopyToBitmap(Bmp);
      TClipboard(Dest).Assign(Bmp);
    finally
      Bmp.Free;
    end;
  end
  else inherited;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxBitmap.Create;
begin
  inherited Create;
  FDC := 0;
  with FBitmapInfo.bmiHeader do
  begin
    biSize := SizeOf(TBitmapInfoHeader);
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
  end;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFxBitmap.Destroy;
begin
  RemoveBitmapFromList(Self);
  if FDC <> 0 then DeleteDC(FDC);
  FDC := 0;
  if FHandle <> 0 then DeleteObject(FHandle);
  FHandle := 0;
  FBits := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Assign(Source: TPersistent);

  procedure AssignFromBitmap(SrcBmp: TBitmap);
  begin
    SetSize(SrcBmp.Width, SrcBmp.Height);
    if Empty then Exit;
    BitBlt(FDC, 0, 0, FWidth, FHeight, SrcBmp.Canvas.Handle, 0, 0, SRCCOPY);
//    SetAlpha($FF);
  end;

var
  SLine: PLMDFxColorArray;
  DstP: PLMDFxColor;
  i, j: integer;
begin
  if Source is TLMDFxBitmap then
  begin
    SetSize((Source as TLMDFxBitmap).FWidth, (Source as TLMDFxBitmap).FHeight);
    if Empty then Exit;
    MoveLongwordFunc((Source as TLMDFxBitmap).Bits, FBits, FWidth * FHeight);
    { Assign properties }
    FName := (Source as TLMDFxBitmap).FName;
    FTransparent := (Source as TLMDFxBitmap).FTransparent;
    FAlphaBlend := (Source as TLMDFxBitmap).FAlphaBlend;
  end
  else
    if Source is TBitmap then
    begin
      if ((Source as TBitmap).PixelFormat = pf32bit) and
         ((Source as TBitmap).HandleType = bmDIB) then
      with (Source as TBitmap) do
      begin
        { Alpha }
        SetSize(Width, Height);
        { Copy alpha }
        for j := 0 to Height - 1 do
        begin
          SLine := Scanline[j];
          for i := 0 to Width - 1 do
          begin
            DstP := PixelPtr[i, j];
            DstP^ := SLine^[i];
            end;
        end;
        { CheckAlpha }
        CheckingAlphaBlend;
      end
      else
      begin
        { Copy }
        AssignFromBitmap((Source as TBitmap));
        SetAlpha($FF);
      end;
    end
    else
      if Source is TGraphic then
      begin
        SetSize(TGraphic(Source).Width, TGraphic(Source).Height);
        if Empty then Exit;
        DrawGraphic(TGraphic(Source), Rect(0, 0, FWidth, FHeight));
        SetAlpha($FF);
      end
      else
        if Source is TPicture then
        begin
          with TPicture(Source) do
          begin
            if TPicture(Source).Graphic is TBitmap then
              AssignFromBitmap(TBitmap(TPicture(Source).Graphic))
            else
            begin
              // icons, metafiles etc...
              SetSize(TPicture(Source).Graphic.Width, TPicture(Source).Graphic.Height);
              if Empty then Exit;
              DrawGraphic(TPicture(Source).Graphic, Rect(0, 0, FWidth, FHeight));
              SetAlpha($FF);
            end;
          end;
        end
        else  { inherited }
          inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.SetSize(AWidth, AHeight: Integer);

begin
    AWidth := Abs(AWidth);
    AHeight := Abs(AHeight);
    if (AWidth = 0) or (AHeight = 0) then Exit;
    if (AWidth = FWidth) and (AHeight = FHeight) then Exit;

    { Free resource }
    if FDC <> 0 then RemoveBitmapFromList(Self);
    if FDC <> 0 then DeleteDC(FDC);
    FDC := 0;
    if FHandle <> 0 then DeleteObject(FHandle);
    FHandle := 0;
    FBits := nil;

    { Initialization }
    with FBitmapInfo.bmiHeader do
    begin
      biWidth := AWidth;
      biHeight := -AHeight;
    end;

    { Create new DIB }
    FHandle := CreateDIBSection(0, FBitmapInfo, DIB_RGB_COLORS, Pointer(FBits), 0, 0);
    if FBits = nil then
      raise Exception.Create('Can''t allocate the DIB handle');

    FDC := CreateCompatibleDC(0);
    if FDC = 0 then
    begin
      DeleteObject(FHandle);
      FHandle := 0;
      FBits := nil;
      raise Exception.Create('Can''t create compatible DC');
    end;

    if SelectObject(FDC, FHandle) = 0 then
    begin
      DeleteDC(FDC);
      DeleteObject(FHandle);
      FDC := 0;
      FHandle := 0;
      FBits := nil;
      raise Exception.Create('Can''t select an object into DC');
    end;

    { Add to BitmapList }
    AddBitmapToList(Self);

  FWidth := AWidth;
  FHeight := AHeight;
end;

{ BitmapLink }
{ ---------------------------------------------------------------------------- }
function TLMDFxBitmap.GetBitmapLink(Rect: TRect): TLMDFxBitmapLink;
begin
  Result := TLMDFxBitmapLink.Create;
  Result.Image := Self;
  Result.Name := Name;
  Result.Rect := Rect;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxBitmap.GetBitmapLink(Rect: string): TLMDFxBitmapLink;
begin
  Result := TLMDFxBitmapLink.Create;
  Result.Image := Self;
  Result.Name := Name;
  Result.Rect := StringToRect(Rect);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxBitmap.Empty: boolean;
begin
  Result := FHandle = 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Clear(Color: TLMDFxColor);
begin
  FillLongwordFunc(Bits, FWidth * FHeight, Color);
end;

{ I/O Routines }
{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.LoadFromResource(const ResFileName, ResName: string);
var
  H: THandle;
  ResStream: TStream;
  BitmapInfo: PBitmapInfo;
  HeaderSize: integer;
  B: TBitmap;
begin
  H := LoadLibraryEx(PChar(ResFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
  try
    ResStream := TResourceStream.Create(H, ResName, RT_BITMAP);
    try
      ResStream.Read(HeaderSize, sizeof(HeaderSize));
      GetMem(BitmapInfo, HeaderSize + 12 + 256 * sizeof(TRGBQuad));
      with BitmapInfo^ do
      try
        ResStream.Read(Pointer(Longint(BitmapInfo) + sizeof(HeaderSize))^,
          HeaderSize - sizeof(HeaderSize));
      B := TBitmap.Create;
        try
          if BitmapInfo^.bmiHeader.biBitCount = 32 then
            B.LoadFromResourceName(H, ResName) // By VCL
          else
          begin
            B.Handle := LoadBitmap(H, PChar(ResName)); // By Windows
            if B.Handle = 0 then
            B.LoadFromResourceName(H, ResName) // Try by VCL
            end;

          Assign(B);
        finally
          B.Free;
        end;
      finally
        FreeMem(BitmapInfo);
        end;
    finally
      ResStream.Free;
    end;
  finally
    FreeLibrary(H);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.LoadFromStream(Stream: TStream);
var
  W, H: integer;

begin
  FName := ReadString(Stream);
  Stream.Read(W, SizeOf(Integer));
  Stream.Read(H, SizeOf(Integer));
  if (H > 0) then
  begin
    { New format since 3.4.4 }
    SetSize(W, H);
    if (FWidth = W) and (FHeight = H) then
    Stream.Read(FBits^, FWidth * FHeight * SizeOf(Longword));
    end
  else
  begin
    H := Abs(H);
    SetSize(W, H);
    if (FWidth = W) and (FHeight = H) then
    Stream.Read(FBits^, FWidth * FHeight * SizeOf(Longword));
    FlipHorz;
  end;
  { Checking }
{  CheckingAlphaBlend;
  if not FAlphaBlend then CheckingTransparent;}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.SaveToBitmapFile(AFileName: string);
var
  LBmp: TBitmap;
begin
  LBmp := TBitmap.Create;
  LBmp.Width := FWidth;
  LBmp.Height := FHeight;
  Draw(LBmp.Canvas, 0, 0);
  LBmp.SaveToFile(AFileName);
  LBmp.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.SaveToStream(Stream: TStream);
var
  NewFormatHeight: integer;

begin
  WriteString(Stream, FName);
  Stream.Write(FWidth, SizeOf(Integer));
  NewFormatHeight := FHeight; { New format since 3.4.4 }
  Stream.Write(NewFormatHeight, SizeOf(Integer));
  Stream.Write(FBits^, FWidth * FHeight * SizeOf(Longword));
  end;

type

  TRGB = packed record
   R, G, B: Byte;
  end;

  TPCXHeader = record
    FileID: Byte;                      // $0A for PCX files, $CD for SCR files
    Version: Byte;                     // 0: version 2.5; 2: 2.8 with palette; 3: 2.8 w/o palette; 5: version 3
    Encoding: Byte;                    // 0: uncompressed; 1: RLE encoded
    BitsPerPixel: Byte;
    XMin,
    YMin,
    XMax,
    YMax,                              // coordinates of the corners of the image
    HRes,                              // horizontal resolution in dpi
    VRes: Word;                        // vertical resolution in dpi
    ColorMap: array[0..15] of TRGB;    // color table
    Reserved,
    ColorPlanes: Byte;                 // color planes (at most 4)
    BytesPerLine,                      // number of bytes of one line of one plane
    PaletteType: Word;                 // 1: color or b&w; 2: gray scale
    Fill: array[0..57] of Byte;
  end;
procedure TLMDFxBitmap.LoadFromPcxStream(Stream: TStream);
const
  FSourceBPS: byte = 8;
  FTargetBPS: byte = 8;
var
  Header: TPCXHeader;
  Bitmap: TBitmap;

  procedure PcxDecode(var Source, Dest: Pointer; PackedSize, UnpackedSize: Integer);
  var
    Count: Integer;
    SourcePtr,
    TargetPtr: PByte;
  begin

    SourcePtr := Source;
    TargetPtr := Dest;
    while UnpackedSize > 0 do
    begin
      if (SourcePtr^ and $C0) = $C0 then
      begin
        // RLE-Code
        Count := SourcePtr^ and $3F;
        Inc(SourcePtr);
        if UnpackedSize < Count then Count := UnpackedSize;
        FillChar(TargetPtr^, Count, SourcePtr^);
        Inc(SourcePtr);
        Inc(TargetPtr, Count);
        Dec(UnpackedSize, Count);
      end
      else
      begin
        // not compressed
        TargetPtr^ := SourcePtr^;
        Inc(SourcePtr);
        Inc(TargetPtr);
        Dec(UnpackedSize);
      end;
    end;

  end;

  function PcxCreateColorPalette(Data: array of Pointer; ColorCount: Cardinal): HPALETTE;
  var
    I, MaxIn, MaxOut: Integer;
    LogPalette: TMaxLogPalette;
    RunR8: PByte;
    begin
    FillChar(LogPalette, SizeOf(LogPalette), 0);
    LogPalette.palVersion := $300;
    if ColorCount > 256 then
      LogPalette.palNumEntries := 256
    else
      LogPalette.palNumEntries := ColorCount;

    RunR8 := Data[0];

    for I := 0 to LogPalette.palNumEntries - 1 do
    begin
      LogPalette.palPalEntry[I].peRed := RunR8^;
      Inc(RunR8);
      LogPalette.palPalEntry[I].peGreen := RunR8^;
      Inc(RunR8);
      LogPalette.palPalEntry[I].peBlue := RunR8^;
      Inc(RunR8);
      end;
    MaxIn := (1 shl FSourceBPS) - 1;
    MaxOut := (1 shl FTargetBPS) - 1;
    if (FTargetBPS <= 8) and (MaxIn <> MaxOut) then
    begin
      MaxIn := (1 shl FSourceBPS) - 1;
      MaxOut := (1 shl FTargetBPS) - 1;
      if MaxIn < MaxOut then
      begin
        { palette is too small, enhance it }
        for I := MaxOut downto 0 do
        begin
        LogPalette.palPalEntry[I].peRed := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peRed;
          LogPalette.palPalEntry[I].peGreen := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peGreen;
          LogPalette.palPalEntry[I].peBlue := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peBlue;
        end;
      end
      else
      begin
        { palette contains too many entries, shorten it }
        for I := 0 to MaxOut do
        begin
          LogPalette.palPalEntry[I].peRed := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peRed;
          LogPalette.palPalEntry[I].peGreen := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peGreen;
          LogPalette.palPalEntry[I].peBlue := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peBlue;
          end;
      end;
      LogPalette.palNumEntries := MaxOut + 1;
    end;

    { finally create palette }
    Result := CreatePalette(PLogPalette(@LogPalette)^);
    end;

  procedure MakePalette;
  var
    PCXPalette: array[0..255] of TRGB;
    OldPos: Integer;
    Marker: Byte;
    begin
    if (Header.Version <> 3) or (Bitmap.PixelFormat = pf1Bit) and
       (Bitmap.PixelFormat = pf8Bit) then
    begin
      OldPos := Stream.Position;
      { 256 colors with 3 components plus one marker byte }
      Stream.Position := Stream.Size - 769;
      Stream.Read(Marker, 1);
      Stream.Read(PCXPalette[0], 768);
      Bitmap.Palette := PcxCreateColorPalette([@PCXPalette], 256);
      Stream.Position := OldPos;
    end
    else
      Bitmap.Palette := Graphics.SystemPalette16;
      end;

  procedure RowConvertIndexed8(Source: array of Pointer; Target: Pointer; Count: Cardinal; Mask: Byte);
  var
    SourceRun, TargetRun: PByte;
  begin
    SourceRun := Source[0];
    TargetRun := Target;

    if (FSourceBPS = FTargetBPS) and (Mask = $FF) then
      Move(SourceRun^, TargetRun^, (Count * FSourceBPS + 7) div 8);
      end;

var
  PCXSize, Size: Cardinal;
  RawBuffer, DecodeBuffer: Pointer;
  Run: PByte;
  Line: PByte;
  I: Integer;
  Increment: Cardinal;
begin
  { Load from PCX - 8-bit indexed RLE compressed/uncompressed }
  {$WARNINGS OFF}
  Bitmap := TBitmap.Create;
  try
    Bitmap.Handle := 0;
    Stream.Read(Header, SizeOf(Header));
    PCXSize := Stream.Size - Stream.Position;
    with Header do
    begin
      if not (FileID in [$0A, $CD]) then Exit;

      Bitmap.PixelFormat := pf8bit;
      MakePalette;

      Bitmap.Width := XMax - XMin + 1;
      Bitmap.Height := YMax - YMin + 1;

      { adjust alignment of line }
      Increment := ColorPlanes * BytesPerLine;

      { Decompress }
      if Header.Encoding = 1 then
      begin
        { RLE }
        Size := Increment * Bitmap.Height;
        GetMem(DecodeBuffer, Size);
        GetMem(RawBuffer, PCXSize);
        try
          Stream.ReadBuffer(RawBuffer^, PCXSize);
          PcxDecode(RawBuffer, DecodeBuffer, PCXSize, Size);
        finally
          if Assigned(RawBuffer) then FreeMem(RawBuffer);
          end;
      end
      else
      begin
        GetMem(DecodeBuffer, PCXSize);
        Stream.ReadBuffer(DecodeBuffer^, PCXSize);
        end;

      try
        Run := DecodeBuffer;
        { PCX 8 bit Index }
        for I := 0 to Bitmap.Height - 1 do
        begin
          Line := Bitmap.ScanLine[I];
          RowConvertIndexed8([Run], Line, Bitmap.Width, $FF);
          Inc(Run, Increment);
        end;
      finally
        if Assigned(DecodeBuffer) then FreeMem(DecodeBuffer);
        end;
    end;

    { Assign to Self }
    Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
  {$WARNINGS ON}
end;

{ Checking routines }

const
  Quantity = 6;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.CheckingAlphaBlend;
var
  i: Cardinal;
  C: PLMDFxColor;
  begin
  FAlphaBlend := false;
  C := @FBits[0];
  for i := 0 to FWidth * FHeight - 1 do
  begin
    if (TLMDFxColorRec(C^).A > 0) and (TLMDFxColorRec(C^).A < $FF) then
    begin
      FAlphaBlend := true;
      Break;
    end;
    Inc(C);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.CheckingAlphaBlend(ARect: TRect);
var
  i, j: integer;
  C: PLMDFxColor;
  begin
  FAlphaBlend := false;
//TODO: Ошибка! Альфа канал проверяется не на участке ARect, а на всём Bitmap-е
  for i := 0 to FWidth - 1 do
    for j := 0 to FHeight - 1 do
    begin
      C := PixelPtr[i, j];
      if (TLMDFxColorRec(C^).A > 0) and (TLMDFxColorRec(C^).A < $FF) then
      begin
        FAlphaBlend := true;
        Break;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
{$warnings off}
procedure TLMDFxBitmap.CheckingTransparent(Color: TLMDFxColor = LMDFxTransparent);
var
  i: Cardinal;
  C: PLMDFxColor;
  begin
  FTransparent := false;
  C := @FBits[0];
  for i := 0 to FWidth * FHeight - 1 do
  begin
  if (Abs(TLMDFxColorRec(C^).R - TLMDFxColorRec(Color).R) < Quantity) and
       (Abs(TLMDFxColorRec(C^).G - TLMDFxColorRec(Color).G) < Quantity) and
       (Abs(TLMDFxColorRec(C^).B - TLMDFxColorRec(Color).B) < Quantity)
    then
    begin
      C^ := LMDFxTransparent;
      FTransparent := true;
    end;

    Inc(C);
 end;
end;
{$warnings on}

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.CheckingTransparent(ARect: TRect; Color: TLMDFxColor = LMDFxTransparent);
var
  i, j: integer;
  C: PLMDFxColor;
  begin
  FTransparent := false;
  for i := 0 to FWidth - 1 do
    for j := 0 to FHeight - 1 do
      begin
        C := PixelPtr[i, j];
        if (Abs(TLMDFxColorRec(C^).R - TLMDFxColorRec(Color).R) < Quantity) and
           (Abs(TLMDFxColorRec(C^).G - TLMDFxColorRec(Color).G) < Quantity) and
           (Abs(TLMDFxColorRec(C^).B - TLMDFxColorRec(Color).B) < Quantity)
        then
          begin
            C^ := LMDFxTransparent;
            FTransparent := true;
          end;
        end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.SetAlpha(Alpha: byte);
begin
  if Empty then Exit;
  FillAlphaFunc(Bits, FWidth * FHeight - 1, Alpha);
  end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.SetAlpha(Alpha: byte; Rect: TRect);
begin
  if RectWidth(Rect) = 0 then Exit;
  if RectHeight(Rect) = 0 then Exit;

  if Rect.Left < 0 then Rect.Left := 0;
  if Rect.Top < 0 then Rect.Top := 0;
  if Rect.Right > FWidth then Rect.Right := FWidth;
  if Rect.Bottom > FHeight then Rect.Bottom := FHeight;
  FillAlphaRectFunc(FBits, FWidth, FHeight, Rect.Left, Rect.Top, Rect.Right-1,
    Rect.Bottom - 1, Alpha);
end;

{ Color transition ============================================================}
procedure TLMDFxBitmap.ChangeBitmapBrightness(DeltaBrightness: integer);
var
  i: Integer;
  Color: PLMDFxColor;
  A: byte;
begin
  if DeltaBrightness = 0 then Exit;
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TLMDFxColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := ChangeBrightness(Color^, DeltaBrightness);
    Color^ := Color^ and not AlphaMask or (A shl 24);
    ;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.SetBitmapHue(Hue: integer);
var
  i: Integer;
  Color: PLMDFxColor;
  A: byte;
begin
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TLMDFxColorRec(Color^).A;
    if (A = 0) then
      Continue;
    Color^ := SetHue(Color^, Hue);
    Color^ := Color^ and not AlphaMask or (A shl 24);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.ChangeBitmapSat(DeltaSat: integer);
var
  i: Integer;
  Color: PLMDFxColor;
  A: byte;
begin
  if DeltaSat = 0 then Exit;
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TLMDFxColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := ChangeSat(Color^, DeltaSat);
    Color^ := Color^ and not AlphaMask or (A shl 24);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.ChangeBitmapHue(DeltaHue: integer);
var
  i: Integer;
  Color: PLMDFxColor;
  A: byte;
begin
  if DeltaHue = 0 then Exit;
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TLMDFxColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := ChangeHue(Color^, DeltaHue);
    Color^ := Color^ and not AlphaMask or (A shl 24);
    end;
end;

{ Draw to XXX =================================================================}
procedure TLMDFxBitmap.Draw(DC: HDC; X, Y: integer);
begin
  Draw(DC, X, Y, Rect(0, 0, Width, Height));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(DC: HDC; X, Y: integer; SrcRect: TRect);
begin
  Draw(DC, Rect(X, Y, X + RectWidth(SrcRect), Y + RectHeight(SrcRect)), SrcRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(DC: HDC; DstRect: TRect);
begin
  Draw(DC, DstRect, Rect(0, 0, FWidth, FHeight));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(DC: HDC; DstRect, SrcRect: TRect);
{$WARNINGS OFF}
var
  Dst: TLMDFxBitmap;
  P: TPoint;
  BitmapW, BitmapH, BitmapBCount: integer;
  BitmapBits: PByteArray;
  begin
  Dst := FindBitmapByDC(DC);
  if Dst <> nil then
    begin
      { Adjust WindowOrg }
      GetWindowOrgEx(DC, P);
      OffsetRect(DstRect, -P.X, -P.Y);
      { Destination is KS Bitmap }
      Draw(Dst, DstRect, SrcRect);
    end
  else
    begin
      BitmapBits := GetBitsFromDCFunc(DC, BitmapW, BitmapH, BitmapBCount);
      if EnableDibOperation and (BitmapBits <> nil) and (BitmapBCount = 32) and (BitmapH > 0) then
        begin
          { Adjust WindowOrg }
          GetWindowOrgEx(DC, P);
          OffsetRect(DstRect, -P.X, -P.Y);
          { Draw to DIB }
          if FAlphaBlend then
            StretchToDibAlphaBlendFunc(BitmapBits, DstRect, DstRect, BitmapW, BitmapH,
              Self, SrcRect)
          else
            if FTransparent then
              StretchToDibTransparentFunc(BitmapBits, DstRect, DstRect, BitmapW, BitmapH,
                Self, SrcRect)
            else
              StretchToDibOpaqueFunc(BitmapBits, DstRect, DstRect, BitmapW, BitmapH,
                Self, SrcRect);
        end
      else
        begin
          { Draw to DC }
          if FAlphaBlend then
            StretchToDCAlphaBlendFunc(DC, DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
              Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
          else
            if FTransparent then
              StretchToDCTransparentFunc(DC, DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
                Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
            else
              StretchToDCOpaqueFunc(DC, DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
                Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect));
        end;
    end;
{$WARNINGS ON}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(Canvas: TCanvas; X, Y: integer);
begin
  Draw(Canvas.Handle, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(Canvas: TCanvas; X, Y: integer; SrcRect: TRect);
begin
  Draw(Canvas, Rect(X, Y, X + RectWidth(SrcRect), Y + RectHeight(SrcRect)), SrcRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(Canvas: TCanvas; DstRect: TRect);
begin
  Draw(Canvas, DstRect, Rect(0, 0, FWidth, FHeight));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(Canvas: TCanvas; DstRect, SrcRect: TRect);
begin
  Draw(Canvas.Handle, DstRect, SrcRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(Bitmap: TLMDFxBitmap; X, Y: integer);
begin
  Draw(Bitmap, X, Y, Rect(0, 0, Width, Height));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(Bitmap: TLMDFxBitmap; X, Y: integer;
  SrcRect: TRect);
begin
  Draw(Bitmap, Rect(X, Y, X + RectWidth(SrcRect), Y + RectHeight(SrcRect)), SrcRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(Bitmap: TLMDFxBitmap; DstRect: TRect);
begin
  Draw(Bitmap, DstRect, Rect(0, 0, FWidth, FHeight));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Draw(Bitmap: TLMDFxBitmap; DstRect, SrcRect: TRect);
begin
  if AlphaBlend then
    begin
      StretchAlphaBlendFunc(Bitmap, DstRect, DstRect, Self, SrcRect)
    end
  else
    if Transparent then
      StretchTransparentFunc(Bitmap, DstRect, DstRect, Self, SrcRect)
    else
      StretchOpaqueFunc(Bitmap, DstRect, DstRect, Self, SrcRect)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Tile(DC: HDC; DstRect, SrcRect: TRect);
var
  i, j: integer;
  R, R1, SrcR: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
  Dst: TLMDFxBitmap;
  BitmapW, BitmapH, BitmapBCount: integer;
  BitmapBits: PByteArray;
  procedure Draw( SrcRect: TRect);
  var
    P: TPoint;
  begin
    if Dst <> nil then
    begin
      { Adjust WindowOrg }
      GetWindowOrgEx(DC, P);
      OffsetRect(R, -P.X, -P.Y);
      { Destination is KS Bitmap }
      self.Draw(Dst, R, SrcRect);
    end
    else
    begin
      if EnableDibOperation and (BitmapBits <> nil) and (BitmapBCount = 32) and (BitmapH > 0) then
      begin
        { Adjust WindowOrg }
        GetWindowOrgEx(DC, P);
        OffsetRect(R, -P.X, -P.Y);
        { Draw to DIB }
        if FAlphaBlend then
          StretchToDibAlphaBlendFunc(BitmapBits, R, R, BitmapW, BitmapH,
            Self, SrcRect)
        else
          if FTransparent then
            StretchToDibTransparentFunc(BitmapBits, R, R, BitmapW, BitmapH,
              Self, SrcRect)
          else
            StretchToDibOpaqueFunc(BitmapBits, R, R, BitmapW, BitmapH,
              Self, SrcRect);
      end
      else
      begin
        { Draw to DC }
        if FAlphaBlend then
          StretchToDCAlphaBlendFunc(DC, R.Left, R.Top, RectWidth(R), RectHeight(R),
            Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
        else
          if FTransparent then
            StretchToDCTransparentFunc(DC, R.Left, R.Top, RectWidth(R), RectHeight(R),
              Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
          else
            StretchToDCOpaqueFunc(DC, R.Left, R.Top, RectWidth(R), RectHeight(R),
              Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect));
      end;
    end;
  end;

begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if (W=0) or (H=0) then Exit;

  Dst := FindBitmapByDC(DC);
  if Dst=nil then
    BitmapBits := GetBitsFromDCFunc(DC, BitmapW, BitmapH, BitmapBCount);

  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      R1 := SrcRect;
      if (DW <> W) or (DH <> H) then
      begin
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        Draw( R1);
      end
      else
        Draw( R1);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Tile(Canvas: TCanvas; DstRect, SrcRect: TRect);
begin
  Tile(Canvas.Handle, DstRect, SrcRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.Tile(Bitmap: TLMDFxBitmap; DstRect, SrcRect: TRect);
var
  i, j: integer;
  R, R1, SrcR: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if W * H = 0 then Exit;

  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      if (DW <> W) or (DH <> H) then
      begin
        R1 := SrcRect;
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        Draw(Bitmap, R, R1);
      end
      else
        Draw(Bitmap, R, SrcRect);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.TileClip(DC: HDC; DstRect, DstClip, SrcRect: TRect);
var
  i, j: integer;
  R, R1, SrcR, ClipRes: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
  IsClip: boolean;
begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if W * H = 0 then Exit;

  if IsRectEmpty(DstClip) then
    IsClip := false
  else
    IsClip := true;
  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      if (DW <> W) or (DH <> H) then
      begin
        R1 := SrcRect;
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(DC, R, R1);
        end
        else
          Draw(DC, R, R1);
      end
      else
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(DC, R, SrcRect);
        end
        else
          Draw(DC, R, SrcRect);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.TileClip(Canvas: TCanvas; DstRect, DstClip, SrcRect: TRect);
begin
  TileClip(Canvas.Handle, DstRect, DstClip, SrcRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.TileClip(Bitmap: TLMDFxBitmap; DstRect, DstClip, SrcRect: TRect);
var
  i, j: integer;
  R, R1, ClipRes, SrcR: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
  IsClip: boolean;
begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if W * H = 0 then Exit;

  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  if IsRectEmpty(DstClip) then
    IsClip := false
  else
    IsClip := true;

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      if (DW <> W) or (DH <> H) then
      begin
        R1 := SrcRect;
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(Bitmap, R, R1);
        end
        else
          Draw(Bitmap, R, R1);
      end
      else
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(Bitmap, R, SrcRect);
        end
        else
          Draw(Bitmap, R, SrcRect);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.MergeDraw(Bitmap: TLMDFxBitmap; X, Y: integer; SrcRect: TRect);
var
  Index: integer;
  i, j: integer;
  B, F: PLMDFxColor;
  Alpha: byte;
begin
  if SrcRect.Left < 0 then
  begin
    X := X + Abs(SrcRect.Left);
    SrcRect.Left := 0;
  end;
  if SrcRect.Top < 0 then
  begin
    Y := Y + Abs(SrcRect.Top);
    SrcRect.Top := 0;
  end;
  if SrcRect.Right > Bitmap.FWidth then SrcRect.Right := Bitmap.FWidth;
  if SrcRect.Bottom > Bitmap.FHeight then SrcRect.Bottom := Bitmap.FHeight;
  { Draw bitmap rect to another bitmap }
  try
    for i := SrcRect.Left to SrcRect.Right-1 do
      for j := SrcRect.Top to SrcRect.Bottom-1 do
      begin
        { Get Back pixel from Bitmap }
        B := Bitmap.PixelPtr[i, j];
        { Get fore pixel }
        Index := (X + i-SrcRect.Left) + (Y + (j-SrcRect.Top)) * FWidth;
        if Index >= FWidth * FHeight then Continue;
        F := @FBits[Index];
        { Blend }
        Alpha := F^ shr 24;
        if Alpha = 0 then
          F^ := B^
        else
          if Alpha < $FF then
            F^ := PixelAlphaBlendFunc(F^, B^);
        end;
  finally
    EMMS;
  end;
end;

{ Painting Routines ===========================================================}
procedure TLMDFxBitmap.DrawGraphic(Graphic: TGraphic; DstRect: TRect);
var
  Bitmap: TBitmap;
  SL: PLMDFxColorArray;
  i, j: integer;
begin
  { Create DIB copy }
  Bitmap := TBitmap.Create;
  try
    Bitmap.PixelFormat := pf32bit;
    Bitmap.Width := FWidth;
    Bitmap.Height := FHeight;
    Bitmap.Canvas.Brush.Color := RGB(255, 0, 255);
    Bitmap.Canvas.Rectangle(-1, -1, FWidth + 1, FHeight + 1);
    Bitmap.Canvas.StretchDraw(DstRect, Graphic);

    { Copy to bitmap }
    for j := 0 to FHeight - 1 do
    begin
      SL := Bitmap.Scanline[j];
      for i := 0 to FWidth - 1 do
        if (TLMDFxColorRec(SL[i]).R = $FF) and (TLMDFxColorRec(SL[i]).G = 0) and (TLMDFxColorRec(SL[i]).B = $FF) then
          Continue
        else
          Pixels[i, j] := SL[i];
        end;
  finally
    Bitmap.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.DrawBevel(R: TRect; Color: TLMDFxColor; Width: integer;
  Down: boolean);
begin
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.DrawEdge(R: TRect; RaisedColor, SunkenColor: TLMDFxColor);
begin
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.DrawEllipse(R: TRect; Color: TLMDFxColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.DrawFocusRect(R: TRect; Color: TLMDFxColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.DrawLine(R: TRect; Color: TLMDFxColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.DrawPolygon(Points: array of TPoint; Color: TColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.DrawRect(R: TRect; Color: TLMDFxColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.DrawRoundRect(R: TRect; Radius: integer;
  Color: TLMDFxColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{function TLMDFxBitmap.DrawText(AText: WideString; var Bounds: TRect;
  Flag: cardinal): integer;
begin
  Result := 0;
end;

{ ---------------------------------------------------------------------------- }
{function TLMDFxBitmap.DrawText(AText: WideString; X, Y: integer): integer;
begin
  Result := 0;
end;

{ ---------------------------------------------------------------------------- }
{function TLMDFxBitmap.DrawVerticalText(AText: WideString; Bounds: TRect;
  Flag: cardinal; FromTop: boolean): integer;
begin
  Result := 0;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.FillEllipse(R: TRect; Color: TLMDFxColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.FillGradientRect(Rect: TRect; BeginColor,
  EndColor: TLMDFxColor; Vertical: boolean);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.FillHalftonePolygon(Points: array of TPoint; Color,
  HalfColor: TLMDFxColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.FillHalftoneRect(R: TRect; Color,
  HalfColor: TLMDFxColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.FillPolygon(Points: array of TPoint; Color: TColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.FillRadialGradientRect(Rect: TRect; BeginColor,
  EndColor: TLMDFxColor; Pos: TPoint);
begin

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.FillRect(R: TRect; Color: TLMDFxColor);
var
  Size, j: integer;
  AlphaLine: PLMDFxColor;
  begin
  if R.Left < 0 then R.Left := 0;
  if R.Top < 0 then R.Top := 0;
  if R.Right > Width then R.Right := Width;
  if R.Bottom > Height then R.Bottom := Height;
  if RectWidth(R) <= 0 then Exit;
  if RectHeight(R) <= 0 then Exit;

  if AlphaBlend then
  begin
    Size := RectWidth(R);
    GetMem(AlphaLine, SizeOf(TLMDFxColor) * Size);
    try
      FillLongwordFunc(AlphaLine, Size, Color);
      for j := R.Top to R.Bottom-1 do
        LineAlphaBlendFunc(AlphaLine, PixelPtr[R.Left, j], Size);
        finally
      FreeMem(AlphaLine, SizeOf(TLMDFxColor) * Size);
      EMMS;
    end;
  end
  else
    FillLongwordRectFunc(FBits, FWidth, FHeight, R.Left, R.Top, R.Right-1, R.Bottom - 1, Color);
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.FillRoundRect(R: TRect; Radius: integer;
  Color: TLMDFxColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.LineTo(X, Y: integer; Color: TLMDFxColor);
begin

end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDFxBitmap.MoveTo(X, Y: integer);
begin

end;

{ ---------------------------------------------------------------------------- }
{function TLMDFxBitmap.TextHeight(AText: WideString): integer;
begin
  Result := 0;
end;

{ ---------------------------------------------------------------------------- }
{function TLMDFxBitmap.TextWidth(AText: WideString; Flags: Integer): integer;
begin
  Result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmap.FlipHorz;
var
 J, J2: Integer;
 Buffer: PLMDFxColorArray;
 P1, P2: PLMDFxColor;
 begin
   J2 := Height - 1;
   GetMem(Buffer, Width shl 2);
   for J := 0 to Height div 2 - 1 do
   begin
     P1 := PixelPtr[0, J];
     P2 := PixelPtr[0, J2];
     MoveLongwordFunc(P1, PLMDFxColor(Buffer), Width);
     MoveLongwordFunc(P2, P1, Width);
     MoveLongwordFunc(PLMDFxColor(Buffer), P2, Width);
     Dec(J2);
   end;
   FreeMem(Buffer);
   end;

{ ************************ class TLMDFxBitmapLink **************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDFxBitmapLink.GetAssigned: boolean;
begin
  Result := (FImage <> nil) and ((FRect.Right - FRect.Left) * (FRect.Bottom - FRect.Top) > 0);
end;

{ -----------------------------------------------------------------------------}
function TLMDFxBitmapLink.GetBottom: integer;
begin
  Result := FRect.Bottom;
end;

{ -----------------------------------------------------------------------------}
function TLMDFxBitmapLink.GetLeft: integer;
begin
  Result := FRect.Left;
end;

{ -----------------------------------------------------------------------------}
function TLMDFxBitmapLink.GetRight: integer;
begin
  Result := FRect.Right;
end;

{ -----------------------------------------------------------------------------}
function TLMDFxBitmapLink.GetTop: integer;
begin
  Result := FRect.Top;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.SetBottom(const Value: integer);
begin
  FRect.Bottom := Value;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.SetLeft(const Value: integer);
begin
  FRect.Left := Value;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.SetRight(const Value: integer);
begin
  FRect.Right := Value;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.SetTop(const Value: integer);
begin
  FRect.Top := Value;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxBitmapLink.Create;
begin
  inherited Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFxBitmapLink.Destroy;
begin
  inherited Destroy;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.Assign(Source: TPersistent);
begin
  if Source is TLMDFxBitmapLink then
  begin
    FImage := (Source as TLMDFxBitmapLink).FImage;
    FRect := (Source as TLMDFxBitmapLink).FRect;
    FName := (Source as TLMDFxBitmapLink).FName;
    FMasked := (Source as TLMDFxBitmapLink).FMasked;
    FMaskedBorder := (Source as TLMDFxBitmapLink).FMaskedBorder;
    FMaskedAngles := (Source as TLMDFxBitmapLink).FMaskedAngles;
  end
  else
    inherited;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.LoadFromStream(Stream: TStream);
begin
  FName := ReadString(Stream);
  Stream.Read(FRect, SizeOf(FRect));
  end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.SaveToStream(Stream: TStream);
begin
  WriteString(Stream, FName);
  Stream.Write(FRect, SizeOf(FRect));
  end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.CheckingMasked(Margin: TRect);
var
  i, j: integer;
  P: TLMDFxColor;
  Pt: TPoint;
begin
  FMasked := false;
  FMaskedBorder := false;
  FMaskedAngles := false;

  if (Margin.Left = 0) and (Margin.Top = 0) and (Margin.Right = 0) and (Margin.Right = 0) then
  begin
    for i := Left to Right - 1 do
      for j := Top to Bottom - 1 do
      begin
        if (FImage.Bits <> nil) and (i >= 0) and (j >= 0) and (i < FImage.Width) and (j < FImage.Height) then
          P := PLMDFxColor(@FImage.Bits[i + j * FImage.Width])^
          else
          P := 0;

        if P <> LMDFxNone then
        begin
          if P = LMDFxTransparent then
          begin
            FMasked := true;
            Break;
          end;
          if TLMDFxColorRec(P).A < $FF then
          begin
            FMasked := true;
            Break;
          end;
        end;
      end;
  end
  else
  begin
    for i := Left to Right - 1 do
      for j := Top to Bottom - 1 do
      begin
        if (FImage.Bits <> nil) and (i >= 0) and (j >= 0) and (i < FImage.Width) and (j < FImage.Height) then
          P := PLMDFxColor(@FImage.Bits[i + j * FImage.Width])^
          else
          P := 0;

        if P <> LMDFxNone then
        begin
          if (P = LMDFxTransparent) or (TLMDFxColorRec(P).A < $FF) then
          begin
            Pt := Point(i - Left, j - Top);
            { Check angles }

            if PtInRect(Classes.Rect(0, 0, Margin.Left, Margin.Top), Pt) then
              FMaskedAngles := true;
            if PtInRect(Classes.Rect(Right - Margin.Right, 0, Right, Margin.Top), Pt) then
              FMaskedAngles := true;
            if PtInRect(Classes.Rect(Right - Margin.Right, Bottom - Margin.Bottom, Right, Bottom), Pt) then
              FMaskedAngles := true;
            if PtInRect(Classes.Rect(0, Bottom - Margin.Bottom, Margin.Left, Bottom), Pt) then
              FMaskedAngles := true;

            { Check borders }
            if PtInRect(Classes.Rect(Margin.Left, 0, Right - Margin.Right, Margin.Top), Pt) then
              FMaskedBorder := true;
            if PtInRect(Classes.Rect(Margin.Left, Bottom - Margin.Bottom, Right - Margin.Right, Bottom), Pt) then
              FMaskedBorder := true;
            if PtInRect(Classes.Rect(0, Margin.Top, Margin.Left, Bottom - Margin.Bottom), Pt) then
              FMaskedBorder := true;
            if PtInRect(Classes.Rect(Right - Margin.Right, Margin.Top, Right, Bottom - Margin.Bottom), Pt) then
              FMaskedBorder := true;

            if PtInRect(Classes.Rect(Margin.Left, Margin.Top, Right - Margin.Right, Bottom - Margin.Bottom), Pt) then
              FMasked := true;
            end;
        end;
      end;
  end;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.CheckingMasked;
begin
  CheckingMasked(Classes.Rect(0, 0, 0, 0));
  end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.Draw(Bitmap: TLMDFxBitmap; X, Y: integer);
begin
  if FImage = nil then Exit;
  if FImage.Empty then Exit;
  if FRect.Right - FRect.Left <= 0 then Exit;
  if FRect.Bottom - FRect.Top <= 0 then Exit;
  { Draw bitmap link }
  FImage.Draw(Image, X, Y, FRect);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxBitmapLink.Draw(Canvas: TCanvas; X, Y: integer);
begin
  if FImage = nil then Exit;
  if FImage.Empty then Exit;
  if FRect.Right - FRect.Left <= 0 then Exit;
  if FRect.Bottom - FRect.Top <= 0 then Exit;
  { Draw bitmap link }
  FImage.Draw(Canvas, X, Y, FRect);
end;

{ ************************ class TLMDFxBitmapList **************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDFxBitmapList.GetBitmapByName(index: string): TLMDFxBitmap;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if LowerCase(Bitmaps[i].Name) = LowerCase(index) then
      begin
        Result := Bitmaps[i];
        Exit;
      end;
end;

{ -----------------------------------------------------------------------------}
function TLMDFxBitmapList.GetImage(index: integer): TLMDFxBitmap;
begin
  {$WARNINGS OFF}
  if (index >= 0) and (index < Count) then
    Result := TLMDFxBitmap(Items[index])
  else
    Result := nil;
  {$WARNINGS ON}
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxBitmapList.Create;
begin
  inherited Create;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDFxBitmapList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxBitmapList.Clear;
{var
  i: integer;}
begin
  {$WARNINGS OFF}
  while Count>0 do
    TLMDFxBitmap(Items[Count-1]).Free;
  {for i := 0 to Count-1 do
    TLMDFxBitmap(Items[i]).Free;}
  {$WARNINGS ON}
  inherited Clear;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxBitmapList.GetBitmapLink(Image: TLMDFxBitmap; Rect: TRect): TLMDFxBitmapLink;
var
  i: integer;
begin
  Result := nil;
  { Create BitmapLink }
  for i := 0 to Count - 1 do
    if Bitmaps[i] = Image then
      begin
        Result := Bitmaps[i].GetBitmapLink(Rect);
        Exit;
      end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxBitmapList.GetBitmapLink(Name: string; Rect: TRect): TLMDFxBitmapLink;
var
  i: integer;
begin
  Result := nil;
  { Create BitmapLink }
  for i := 0 to Count - 1 do
    if LowerCase(Bitmaps[i].Name) = LowerCase(Name) then
      begin
        Result := Bitmaps[i].GetBitmapLink(Rect);
        Exit;
      end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxBitmapList.GetBitmapLink(Name, Rect: string): TLMDFxBitmapLink;
var
  i: integer;
begin
  Result := nil;
  { Create BitmapLink }
  for i := 0 to Count - 1 do
    if LowerCase(Bitmaps[i].Name) = LowerCase(Name) then
      begin
        Result := Bitmaps[i].GetBitmapLink(Rect);
        Exit;
      end;
end;

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
function FromRGB(Color32: longword): longword;
{ TColor -> TLMDFxColor }
asm
  BSWAP   ECX
  MOV     CL, $FF
  ROR     ECX,8
  MOV     EAX, ECX
end;
{$else}
function FromRGB(Color32: longword): longword;
{ TColor -> TLMDFxColor }
asm
  BSWAP   EAX
  MOV     AL, $FF
  ROR     EAX,8
end;
{$endif}

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
function ToRGB(Color: longword): longword;
{ TLMDFxColor -> TColor }
asm
  ROL    ECX,8
  XOR    CL,CL
  BSWAP  ECX
  MOV    EAX, ECX
end;
{$else}
function ToRGB(Color: longword): longword;
{ TLMDFxColor -> TColor }
asm
  ROL    EAX,8
  XOR    AL,AL
  BSWAP  EAX
end;
{$endif}

{ ---------------------------------------------------------------------------- }
function MulDiv16(Number, Numerator, Denominator: Word): Word;
asm
  MUL DX
  DIV CX
end;

{ Non-MMX }
{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
procedure _MoveLongword(const Src: Pointer; Dst: Pointer; Count: Integer);
asm
  .NOFRAME
  PUSH    RSI
  PUSH    RDI

  MOV     RSI,RCX
  MOV     RDI,RDX
  MOV     RCX,R8
  CMP     RDI,RSI
  JE      @exit

  REP     MOVSD
@exit:
  POP     RDI
  POP     RSI
end;
{$else}
procedure _MoveLongword(const Src: Pointer; Dst: Pointer; Count: Integer);
asm
  PUSH    ESI
  PUSH    EDI

  MOV     ESI,EAX
  MOV     EDI,EDX
  MOV     EAX,ECX
  CMP     EDI,ESI
  JE      @exit

  REP     MOVSD
@exit:
  POP     EDI
  POP     ESI
end;
{$endif}

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
procedure _ClearAlpha(Src: Pointer; Count: TLMDPtrInt; Value: LongWord);
asm
  .PARAMS 2
  { Clear alpha }
  PUSH    RDI

  MOV     RDI, RCX {X}
  MOV     RAX, R8  {Value}
  MOV     RCX, RDX {Count}
  TEST    RCX, RCX
  JS      @exit
  AND     RAX, $00FFFFFF
@1:
  MOV     EDX, [RDI]
  AND     EDX, $00FFFFFF
  CMP     EDX, EAX
  JNE     @2
  MOV     [RDI], EDX
@2:
  ADD     RDI, 4

  LOOP    @1

@exit:
  POP     RDI
end;
{$else}
procedure _ClearAlpha(Src: Pointer; Count: TLMDPtrInt; Value: longword);
asm
  { Clear alpha }
  PUSH   EDI

  MOV     EDI, EAX {X}
  MOV     EAX, ECX {Value}
  MOV     ECX, EDX {Count}
  TEST    ECX,ECX
  JS      @exit
  AND     EAX, $00FFFFFF
@1:
  MOV     EDX, [EDI]
  AND     EDX, $00FFFFFF
  CMP     EDX, EAX
  JNE     @2
  MOV     [EDI], EDX
@2:
  ADD     EDI, 4

  LOOP    @1

@exit:
  POP     EDI
end;
{$endif}

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
procedure _FillLongword(Src: Pointer; Count: Integer; Value: Longword);
asm
  PUSH    RDI

  MOV     RDI,RCX  // Point EDI to destination
  MOV     RAX,R8
  MOV     ECX,EDX
  TEST    ECX,ECX
  JS      @exit

  REP     STOSD    // Fill count dwords
@exit:
  POP     RDI
end;
{$else}
procedure _FillLongword(Src: Pointer; Count: Integer; Value: Longword);
asm
  PUSH    EDI

  MOV     EDI,EAX  // Point EDI to destination
  MOV     EAX,ECX
  MOV     ECX,EDX
  TEST    ECX,ECX
  JS      @exit

  REP     STOSD    // Fill count dwords
@exit:
  POP     EDI
end;
{$endif}

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
procedure _FillLongwordRect(Src: Pointer; W, H, X1, Y1, X2, Y2: Integer; Value: Longword);
asm
  .PARAMS 4
  PUSH    RDI
  PUSH    RAX
  PUSH    RBX
  PUSH    RCX
  PUSH    RDX

  MOV     EDI, ECX
  XOR     EBX, EBX
  XOR     EAX, EAX
  MOV     EBX, EDX
  MOV     EAX, Y1
  MUL     EBX
  ADD     RAX, R9
  ADD     RDI, RAX
  ADD     RDI, RAX
  ADD     RDI, RAX
  ADD     RDI, RAX

  MOV     EBX, X2
  SUB     RBX, R9
  INC     EBX
  TEST    EBX,EBX
  JS      @exit

  MOV     EDX, Y2
  SUB     EDX, Y1
  INC     EDX
  TEST    EDX,EDX
  JS      @exit
  MOV     EAX, VALUE

@1:
  PUSH    RDI
  MOV     ECX, EBX
  CLD
  REP     STOSD
  POP     RDI
  POP     RCX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  PUSH    RCX
  DEC     EDX
  CMP     EDX, 0
  JNE     @1

@exit:
  POP     RDX
  POP     RCX
  POP     RBX
  POP     RAX
  POP     RDI
end;
{$else}
procedure _FillLongwordRect(Src: Pointer; W, H, X1, Y1, X2, Y2: Integer; Value: Longword);
asm
  PUSH    EDI
  PUSH    EAX
  PUSH    EBX
  PUSH    ECX
  PUSH    EDX

  MOV     EDI, EAX
  XOR     EBX, EBX
  XOR     EAX, EAX
  MOV     EBX, W
  MOV     EAX, Y1
  MUL     EBX
  ADD     EAX, X1
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX

  MOV     EBX, X2
  SUB     EBX, X1
  INC     EBX
  TEST    EBX,EBX
  JS      @exit

  MOV     EDX, Y2
  SUB     EDX, Y1
  INC     EDX
  TEST    EDX,EDX
  JS      @exit
  MOV     EAX, VALUE

@1:
  PUSH    EDI
  MOV     ECX, EBX
  CLD
  REP     STOSD
  POP     EDI
  POP     ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  PUSH    ECX
  DEC     EDX
  CMP     EDX, 0
  JNE     @1

@exit:
  POP     EDX
  POP     ECX
  POP     EBX
  POP     EAX
  POP     EDI
end;
{$endif}

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
procedure _FillAlpha(Src: Pointer; Count: Integer; Alpha: byte);
asm
  PUSH    RDI

  MOV     RDI,RCX  // Point EDI to destination
  MOV     AL, CL
  MOV     ECX,EDX
  TEST    ECX,ECX
  JS      @exit

@1:
  INC     EDI
  INC     EDI
  INC     EDI
  MOV     [RDI], AL
  INC     RDI
  LOOP    @1

@exit:
  POP     RDI
end;
{$else}
procedure _FillAlpha(Src: Pointer; Count: Integer; Alpha: byte);
asm
  PUSH    EDI

  MOV     EDI,EAX  // Point EDI to destination
  MOV     AL, CL
  MOV     ECX,EDX
  TEST    ECX,ECX
  JS      @exit

@1:
  INC     EDI
  INC     EDI
  INC     EDI
  MOV     [EDI], AL
  INC     EDI
  LOOP    @1

@exit:
  POP     EDI
end;
{$endif}

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
procedure _FillAlphaRect(Src: Pointer; W, H, X1, Y1, X2, Y2: Integer; Alpha: byte);
asm
  .PARAMS 4
  PUSH    RDI
  PUSH    RAX
  PUSH    RBX
  PUSH    RCX
  PUSH    RDX

  MOV     EDI, ECX
  XOR     EBX, EBX
  XOR     EAX, EAX
  MOV     EBX, EDX //W
  MOV     EAX, Y1
  MUL     EBX
  ADD     RAX, R9
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX

  MOV     EBX, X2
  SUB     RBX, R9
  INC     EBX
  TEST    EBX,EBX
  JS      @exit

  MOV     EDX, Y2
  SUB     EDX, Y1
  INC     EDX
  TEST    EDX,EDX
  JS      @exit
  mov     al, alpha

@1:
  PUSH    RDI
  MOV     ECX, EBX

@2:
  INC     EDI
  INC     EDI
  INC     EDI
  MOV     [RDI], AL
  INC     EDI
  LOOP    @2

  POP     RDI
  POP     RCX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  PUSH    RCX
  DEC     EDX
  CMP     EDX, 0
  JNE     @1

@exit:
  POP     RDX
  POP     RCX
  POP     RBX
  POP     RAX
  POP     RDI
end;
{$else}
procedure _FillAlphaRect(Src: Pointer; W, H, X1, Y1, X2, Y2: Integer; Alpha: byte);
asm
  PUSH    EDI
  PUSH    EAX
  PUSH    EBX
  PUSH    ECX
  PUSH    EDX

  MOV     EDI, EAX
  XOR     EBX, EBX
  XOR     EAX, EAX
  MOV     EBX, W
  MOV     EAX, Y1
  MUL     EBX
  ADD     EAX, X1
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX

  MOV     EBX, X2
  SUB     EBX, X1
  INC     EBX
  TEST    EBX,EBX
  JS      @exit

  MOV     EDX, Y2
  SUB     EDX, Y1
  INC     EDX
  TEST    EDX,EDX
  JS      @exit
  mov     al, alpha

@1:
  PUSH    EDI
  MOV     ECX, EBX

@2:
  INC     EDI
  INC     EDI
  INC     EDI
  MOV     [EDI], AL
  INC     EDI
  LOOP    @2

  POP     EDI
  POP     ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  PUSH    ECX
  DEC     EDX
  CMP     EDX, 0
  JNE     @1

@exit:
  POP     EDX
  POP     ECX
  POP     EBX
  POP     EAX
  POP     EDI
end;
{$endif}

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
function _PixelAlphaBlend(F, B: TLMDFxColor): TLMDFxColor;
asm
  .NOFRAME
  CMP     ECX,$FF000000
  JNC     @2
  TEST    ECX,$FF000000
  JZ      @1

  MOV     EAX,ECX
  SHR     ECX,24

  PUSH    RBX

  PUSH    RAX
  AND     EAX,$00FF00FF
  IMUL    EAX,ECX
  MOV     EBX, EDX
  AND     EBX,$00FF00FF
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EAX, EBX
  AND     EAX,$FF00FF00
  SHR     EAX, 8
  { EAX = BlendPixel.R and BlendPixel.B }
  POP     RBX
  AND     EBX,$0000FF00
  AND     EDX,$0000FF00
  SHR     EBX, 8
  SHR     EDX, 8
  IMUL    EDX, ECX
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EBX, EDX
  AND     EBX,$0000FF00
  ADD     EBX,$FF000000
  { EBX = BlendPixel.G }
  OR      EAX,EBX
  POP     RBX

  RET
@1:
  MOV     EAX,EDX
@2:
  RET
end;
{$else}
function _PixelAlphaBlend(F, B: TLMDFxColor): TLMDFxColor;
asm
  CMP     EAX,$FF000000
  JNC     @2
  TEST    EAX,$FF000000
  JZ      @1

  MOV     ECX,EAX
  SHR     ECX,24

  PUSH    EBX

  PUSH    EAX
  AND     EAX,$00FF00FF
  IMUL    EAX,ECX
  MOV     EBX, EDX
  AND     EBX,$00FF00FF
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EAX, EBX
  AND     EAX,$FF00FF00
  SHR     EAX, 8
  { EAX = BlendPixel.R and BlendPixel.B }
  POP     EBX
  AND     EBX,$0000FF00
  AND     EDX,$0000FF00
  SHR     EBX, 8
  SHR     EDX, 8
  IMUL    EDX, ECX
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EBX, EDX
  AND     EBX,$0000FF00
  ADD     EBX,$FF000000
  { EBX = BlendPixel.G }
  OR      EAX,EBX
  POP     EBX

  RET
@1:
  MOV     EAX,EDX
@2:
  RET
end;
{$endif}

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
procedure _LineAlphaBlend(Src, Dst: PLMDFxColor; Count: Integer);
asm
  TEST    R8,R8
  JS      @4

  PUSH    RBX
  PUSH    RSI
  PUSH    RDI

  MOV     ESI, ECX
  MOV     EDI, EDX
  MOV     RCX, R8

@1:
  MOV     EAX,[ESI]
  MOV     EDX,[EDI]
  TEST    EAX,$FF000000
  JZ      @3

  PUSH    RCX

  MOV     ECX,EAX
  SHR     ECX,24

  CMP     ECX,$FF
  JZ      @2

  PUSH    RAX

  AND     EAX,$00FF00FF
  IMUL    EAX,ECX
  MOV     EBX, EDX
  AND     EBX,$00FF00FF
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EAX, EBX
  AND     EAX,$FF00FF00
  SHR     EAX, 8
  {BlendPixel.R b BlendPixel.B - EAX}
  POP     RBX
  AND     EBX,$0000FF00
  AND     EDX,$0000FF00
  SHR     EBX, 8
  SHR     EDX, 8
  IMUL    EDX, ECX
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EBX, EDX
  AND     EBX,$0000FF00
  ADD     EBX,$FF000000
  {BlendPixel.G - EBX}
  OR      EAX,EBX
  {BlendPixel - EAX}
@2:
  MOV     [EDI],EAX

  POP     RCX             // restore counter
@3:
  ADD     ESI,4
  ADD     EDI,4

  DEC     ECX
  JNZ     @1

  POP     RDI
  POP     RSI
  POP     RBX
@4:
  RET
end;
{$else}
procedure _LineAlphaBlend(Src, Dst: PLMDFxColor; Count: Integer);
asm
  TEST    ECX,ECX
  JS      @4

  PUSH    EBX
  PUSH    ESI
  PUSH    EDI

  MOV     ESI,EAX
  MOV     EDI,EDX

@1:
  MOV     EAX,[ESI]
  MOV     EDX,[EDI]
  TEST    EAX,$FF000000
  JZ      @3

  PUSH    ECX

  MOV     ECX,EAX
  SHR     ECX,24

  CMP     ECX,$FF
  JZ      @2

  PUSH    EAX

  AND     EAX,$00FF00FF
  IMUL    EAX,ECX
  MOV     EBX, EDX
  AND     EBX,$00FF00FF
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EAX, EBX
  AND     EAX,$FF00FF00
  SHR     EAX, 8
  {BlendPixel.R b BlendPixel.B - EAX}
  POP     EBX
  AND     EBX,$0000FF00
  AND     EDX,$0000FF00
  SHR     EBX, 8
  SHR     EDX, 8
  IMUL    EDX, ECX
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EBX, EDX
  AND     EBX,$0000FF00
  ADD     EBX,$FF000000
  {BlendPixel.G - EBX}
  OR      EAX,EBX
  {BlendPixel - EAX}
@2:
  MOV     [EDI],EAX

  POP     ECX             // restore counter
@3:
  ADD     ESI,4
  ADD     EDI,4

  DEC     ECX
  JNZ     @1

  POP     EDI
  POP     ESI
  POP     EBX
@4:
  RET
end;
{$endif}

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
procedure _LineTransparent(Src, Dst: PLMDFxColor; Count: Integer);
asm
  TEST    R8,R8
  JS      @4

  PUSH    RSI
  PUSH    RDI
  PUSH    RBX

  MOV     RSI, RCX
  MOV     RDI, RDX
  MOV     EBX, $007F007F
  MOV     RCX, R8

@1:
  MOV     EAX,[RSI]
  MOV     EDX, EAX

  AND     EAX, NOT $FF000000
  CMP     EAX, EBX
  JE      @3

  OR      EDX, $FF000000
  MOV     [RDI], EDX

@3:
  ADD     ESI,4
  ADD     EDI,4

  DEC     ECX
  JNZ     @1

  POP     RBX
  POP     RDI
  POP     RSI
@4:
  RET
end;
{$else}
procedure _LineTransparent(Src, Dst: PLMDFxColor; Count: Integer);
asm
  TEST    ECX,ECX
  JS      @4

  PUSH    ESI
  PUSH    EDI
  PUSH    EBX

  MOV     EBX, LMDFxTransparent
  MOV     ESI,EAX
  MOV     EDI,EDX

@1:
  MOV     EAX,[ESI]
  MOV     EDX, EAX

  AND     EAX, NOT ALPHAMASK
  CMP     EAX, EBX
  JE      @3

  OR      EDX, AlphaMask
  MOV     [EDI], EDX

@3:
  ADD     ESI,4
  ADD     EDI,4

  DEC     ECX
  JNZ     @1

  POP     EBX
  POP     EDI
  POP     ESI

@4:
  RET
end;
{$endif}

{ MMX =========================================================================}
{$ifdef LMDX64}
function Mmx_PixelAlphaBlend(F, B: TLMDFxColor): TLMDFxColor;
asm
  .NOFRAME
  MOVD    MM0, ECX
  MOVD    MM2, EDX
  PXOR    MM3, MM3
  PUNPCKLBW MM0, MM3
  PUNPCKLBW MM2, MM3
  MOVQ      MM1,MM0
  PUNPCKHWD MM1,MM1
  PUNPCKHDQ MM1,MM1
  PSUBW   MM0,MM2
  PMULLW  MM0,MM1
  PSLLW   MM2, 8
  PADDW   MM2, MM0
  PSRLW   MM2,8
  db $0F,$67,$D3  //C0PACKUSWB  MM2,MM3
  MOVD      EAX,MM2
end;
{$else}
function Mmx_PixelAlphaBlend(F, B: TLMDFxColor): TLMDFxColor;
asm
  db $0F,$6E,$C0          // MOVD    MM0, EAX
  db $0F,$6E,$D2          // MOVD    MM2, EDX
  db $0F,$EF,$DB          // PXOR    MM3, MM3
  db $0F,$60,$C3          // PUNPCKLBW MM0, MM3
  db $0F,$60,$D3          // PUNPCKLBW MM2, MM3
  db $0F,$6F,$C8          // MOVQ      MM1,MM0
  db $0F,$69,$C9          // PUNPCKHWD MM1,MM1
  db $0F,$6A,$C9          // PUNPCKHDQ MM1,MM1
  db $0F,$F9,$C2          // PSUBW   MM0,MM2
  db $0F,$D5,$C1          // PMULLW  MM0,MM1
  db $0F,$71,$F2,$08      // PSLLW   MM2, 8
  db $0F,$FD,$D0          // PADDW   MM2, MM0
  db $0F,$71,$D2,$08      // PSRLW   MM2,8
  db $0F,$67,$D3          // C0PACKUSWB  MM2,MM3
  db $0F,$7E,$D0          // MOVD      EAX,MM2
end;
{$endif}

{ ---------------------------------------------------------------------------- }
{$ifdef LMDX64}
procedure Mmx_LineAlphaBlend(Src, Dst: PLMDFxColor; Count: Integer);
asm
  TEST      R8,R8
  JS        @4

  PUSH      RSI
  PUSH      RDI

  MOV       RSI,RCX
  MOV       RDI,RDX
  MOV       RCX, R8

@1:
  MOV       EAX,[RSI]
  TEST      EAX,$FF000000
  JZ        @3
  CMP       EAX,$FF000000
  JNC       @2

  MOVD    MM0, EAX
  MOVD    MM2, [RDI]
  PXOR    MM3, MM3
  PUNPCKLBW MM0, MM3
  PUNPCKLBW MM2, MM3
  MOVQ      MM1,MM0
  PUNPCKHWD MM1,MM1
  PUNPCKHDQ MM1,MM1
  PSUBW   MM0,MM2
  PMULLW  MM0,MM1
  PSLLW   MM2, 8
  PADDW   MM2, MM0
  PSRLW   MM2,8
  db $0F,$67,$D3          // C0PACKUSWB  MM2,MM3
  MOVD      EAX,MM2

@2:
  MOV       [RDI],EAX
@3:
  ADD       RSI,4
  ADD       RDI,4

  DEC       ECX
  JNZ       @1

  POP       RDI
  POP       RSI
@4:
  RET
end;
{$else}
procedure Mmx_LineAlphaBlend(Src, Dst: PLMDFxColor; Count: Integer);
asm
  TEST      ECX,ECX
  JS        @4

  PUSH      ESI
  PUSH      EDI

  MOV       ESI,EAX
  MOV       EDI,EDX
@1:
  MOV       EAX,[ESI]
  TEST      EAX,$FF000000
  JZ        @3
  CMP       EAX,$FF000000
  JNC       @2

  db $0F,$6E,$C0          // MOVD    MM0, EAX
  db $0F,$6E,$17          // MOVD    MM2, [EDI]
  db $0F,$EF,$DB          // PXOR    MM3, MM3
  db $0F,$60,$C3          // PUNPCKLBW MM0, MM3
  db $0F,$60,$D3          // PUNPCKLBW MM2, MM3
  db $0F,$6F,$C8          // MOVQ      MM1,MM0
  db $0F,$69,$C9          // PUNPCKHWD MM1,MM1
  db $0F,$6A,$C9          // PUNPCKHDQ MM1,MM1
  db $0F,$F9,$C2          // PSUBW   MM0,MM2
  db $0F,$D5,$C1          // PMULLW  MM0,MM1
  db $0F,$71,$F2,$08      // PSLLW   MM2, 8
  db $0F,$FD,$D0          // PADDW   MM2, MM0
  db $0F,$71,$D2,$08      // PSRLW   MM2,8
  db $0F,$67,$D3          // C0PACKUSWB  MM2,MM3
  db $0F,$7E,$D0          // MOVD      EAX,MM2

@2:
  MOV       [EDI],EAX
@3:
  ADD       ESI,4
  ADD       EDI,4

  DEC       ECX
  JNZ       @1

  POP       EDI
  POP       ESI
@4:
  RET
end;
{$endif}

{ Initialization ==============================================================}
procedure SetupLowLevel;
begin
  if not HasMMX then
    begin
      { MMX }
      PixelAlphaBlendFunc := Mmx_PixelAlphaBlend;
      LineAlphaBlendFunc := Mmx_LineAlphaBlend;
      LineTransparentFunc := _LineTransparent;

      MoveLongwordFunc := _MoveLongword;
      FillLongwordFunc := _FillLongword;
      FillLongwordRectFunc := _FillLongwordRect;

      FillAlphaFunc := _FillAlpha;
      FillAlphaRectFunc := _FillAlphaRect;

      ClearAlphaFunc := _ClearAlpha;
    end
  else
    begin
      { Non-MMX }
      PixelAlphaBlendFunc := _PixelAlphaBlend;
      LineAlphaBlendFunc := _LineAlphaBlend;
      LineTransparentFunc := _LineTransparent;

      MoveLongwordFunc := _MoveLongword;
      FillLongwordFunc := _FillLongword;
      FillLongwordRectFunc := _FillLongwordRect;

      FillAlphaFunc := _FillAlpha;
      FillAlphaRectFunc := _FillAlphaRect;

      ClearAlphaFunc := _ClearAlpha;
    end;
  end;

{ ---------------------------------------------------------------------------- }

function _GetBitsFromDC(DC: HDC; var Width, Height, BitCount: integer): Pointer;

var
  Bitmap: HBITMAP;
  DIB: TDIBSection;
begin
  Result := nil;
  Width := 0;
  Height := 0;
  BitCount := 0;

  Bitmap := GetCurrentObject(DC, OBJ_BITMAP);
  if Bitmap <> 0 then
  begin
    if GetObject(Bitmap, SizeOf(DIB), @DIB) = SizeOf(DIB) then
    begin
      Result := DIB.dsBm.bmBits;
      Width := DIB.dsBmih.biWidth;
      Height := DIB.dsBmih.biHeight;
      BitCount := DIB.dsBmih.biBitCount;
    end;
  end;
end;

{ DC functions ================================================================}
procedure _StretchToDCOpaque(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TLMDFxBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
begin
  SetStretchBltMode(DstDC, COLORONCOLOR);
  StretchBlt(DstDC, DstX, DstY, DstW, DstH, SrcBmp.DC, SrcX, SrcY, SrcW, SrcH, SRCCOPY);
end;

{ ---------------------------------------------------------------------------- }
procedure _StretchToDCAlphaBlend(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TLMDFxBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
var
  SrcRect, DstRect: TRect;
  ResBmp: TLMDFxBitmap;
begin
  { Stretch }
  SrcRect := Rect(SrcX, SrcY, SrcX + SrcW, SrcY + SrcH);
  DstRect := Rect(DstX, DstY, DstX + DstW, DstY + DstH);
  { Stretch }
  ResBmp := TLMDFxBitmap.Create;
  ResBmp.SetSize(DstW, DstH);
  { Copy from DstDC  }
  BitBlt(ResBmp.DC, 0, 0, DstW, DstH, DstDC, DstX, DstY, SRCCOPY);
  { Draw bitmap transparent to ResBmp }
  SrcBmp.Draw(ResBmp, Rect(0, 0, DstW, DstH), SrcRect);
  { Draw ResBmp }
  BitBlt(DstDC, DstRect.Left, DstRect.Top, DstW, DstH, ResBmp.DC, 0, 0, SRCCOPY);
  { Free resource }
  ResBmp.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure _StretchToDCTransparent(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TLMDFxBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
var
  SrcRect, DstRect: TRect;
  ResBmp: TLMDFxBitmap;
begin
  { Stretch }
  SrcRect := Rect(SrcX, SrcY, SrcX + SrcW, SrcY + SrcH);
  DstRect := Rect(DstX, DstY, DstX + DstW, DstY + DstH);
  { Stretch }
  ResBmp := TLMDFxBitmap.Create;
  ResBmp.SetSize(DstW, DstH);
  { Copy DstDC  }
  BitBlt(ResBmp.DC, 0, 0, DstW, DstH, DstDC, DstX, DstY, SRCCOPY);
  { Draw bitmap transparent to ResBmp }
  SrcBmp.Draw(ResBmp, Rect(0, 0, DstW, DstH), SrcRect);
  { Draw ResBmp }
  BitBlt(DstDC, DstRect.Left, DstRect.Top, DstW, DstH, ResBmp.DC, 0, 0, SRCCOPY);
  { Free resource }
  ResBmp.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure MsImg_StretchToDCTransparent(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TLMDFxBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
begin
  LMDTransparentBlt(DstDC, DstX, DstY, DstW, DstH, SrcBmp.DC, SrcX, SrcY,
                    SrcW, SrcH, LMDFxTransparent);
end;

{ Dib Routines ================================================================}

procedure _BltToDibOpaque(Bits: Pointer; DstX, DstY, BitsW, BitsH: integer;
  Src: TLMDFxBitmap; SrcRect: TRect); overload;
var
  SrcP, DstP: PLMDFxColor;

  W, H, Y: Integer;
begin
  { Internal routine }
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  { Source bitmap }
  SrcP := Src.PixelPtr[SrcRect.Left, SrcRect.Top];
  { 32-bit -DIB }
  DstP := @PLMDFxColorArray(Bits)[DstX + (BitsH - DstY - 1) * BitsW];
  for Y := 0 to H - 1 do
  begin
    MoveLongwordFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Dec(DstP, BitsW);
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure _BltToDibTransparent(Bits: Pointer; DstX, DstY, BitsW, BitsH: integer;
  Src: TLMDFxBitmap; SrcRect: TRect); overload;
var
  SrcP, DstP: PLMDFxColor;

  W, H, Y: Integer;
begin
  { Internal routine }
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  { Source bitmap }
  SrcP := Src.PixelPtr[SrcRect.Left, SrcRect.Top];
  Assert(SrcP <> nil);
  { 32-bit -DIB }

  DstP := @PLMDFxColorArray(Bits)[DstX + (BitsH - DstY - 1) * BitsW];
  for Y := 0 to H - 1 do
  begin
    LineTransparentFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Dec(DstP, BitsW);
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure _BltToDibAlphaBlend(Bits: Pointer; DstX, DstY, BitsW, BitsH: integer;
  Src: TLMDFxBitmap; SrcRect: TRect); overload;
var
  SrcP, DstP: PLMDFxColor;

  W, H, Y: Integer;
begin
  { Internal routine }
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  { Source bitmap }
  SrcP := Src.PixelPtr[SrcRect.Left, SrcRect.Top];
  Assert(SrcP <> nil);
  { 32-bit -DIB }
  DstP := @PLMDFxColorArray(Bits)[DstX + (BitsH - DstY - 1) * BitsW];
  for Y := 0 to H - 1 do
  begin
    LineAlphaBlendFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Dec(DstP, BitsW);
    end;
end;

{ ---------------------------------------------------------------------------- }

  procedure _StretchToDibOpaque(Bits: Pointer; DstRect, DstClip: TRect;
  BitsW, BitsH: integer; Src: TLMDFxBitmap; SrcRect: TRect); overload;
var
  SrcLine, DstLine: PLMDFxColorArray;

  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  Scale: Single;
begin
  IntersectRect(DstClip, DstClip, Rect(0, 0, BitsW, BitsH));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      _BltToDibOpaque(Bits, DstClip.Left, DstClip.Top, BitsW, BitsH,
        Src, SrcRect);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Round(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      DstLine := @PLMDFxColorArray(Bits)[DstClip.Left + (BitsH - DstClip.Top - 1) * BitsW];
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
          SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale)
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do
            DstLine[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end
        else
        MoveLongwordFunc(@DstLine[-BitsW], @DstLine[0], DstClipW);
        Dec(DstLine, BitsW);
        end;
    end;
  finally
    EMMS;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure _StretchToDibTransparent(Bits: Pointer; DstRect, DstClip: TRect;
  BitsW, BitsH: integer; Src: TLMDFxBitmap; SrcRect: TRect); overload;
var
  SrcLine, DstLine: PLMDFxColorArray;
  Buffer: TArrayOfLMDFxColor;

  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;

  Scale: Single;
begin
  IntersectRect(DstClip, DstClip, Rect(0, 0, BitsW, BitsH));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      Assert(Bits<>nil);
      Assert(Src<>nil);
      _BltToDibTransparent(Bits, DstClip.Left, DstClip.Top, BitsW, BitsH,
        Src, SrcRect);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Round(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := @PLMDFxColorArray(Bits)[DstClip.Left + (BitsH - DstClip.Top - 1) * BitsW];
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do
            Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineTransparentFunc(@Buffer[0], @DstLine[0], DstClipW);
        Dec(DstLine, BitsW);
        end;
    end;
  finally
    EMMS;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure _StretchToDibAlphaBlend(Bits: Pointer; DstRect, DstClip: TRect;
  BitsW, BitsH: integer; Src: TLMDFxBitmap; SrcRect: TRect); overload;
var
  SrcLine, DstLine: PLMDFxColorArray;
  Buffer: TArrayOfLMDFxColor;

  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;

  Scale: Single;
begin
  IntersectRect(DstClip, DstClip, Rect(0, 0, BitsW, BitsH));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      _BltToDibAlphaBlend(Bits, DstClip.Left, DstClip.Top, BitsW, BitsH,
        Src, SrcRect);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Round(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := @PLMDFxColorArray(Bits)[DstClip.Left + (BitsH - DstClip.Top - 1) * BitsW];
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do
          Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineAlphaBlendFunc(@Buffer[0], @DstLine[0], DstClipW);
        Dec(DstLine, BitsW);
        end;
    end;
  finally
    EMMS;
    end;
end;

{ LMDFxBitmap functions =======================================================}
procedure _BltOpaque(Dst: TLMDFxBitmap; DstRect: TRect;
  Src: TLMDFxBitmap; SrcX, SrcY: Integer); overload;
var
  SrcP, DstP: PLMDFxColor;

  W, DstY: Integer;
begin
  { Internal routine }
  W := DstRect.Right - DstRect.Left;
  SrcP := Src.PixelPtr[SrcX, SrcY];
  Assert(SrcP <> nil);
  DstP := Dst.PixelPtr[DstRect.Left, DstRect.Top];
  Assert(DstP <> nil);
  for DstY := DstRect.Top to DstRect.Bottom - 1 do
  begin
    MoveLongwordFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Inc(DstP, Dst.Width);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure _BltTransparent(Dst: TLMDFxBitmap; DstRect: TRect;
  Src: TLMDFxBitmap; SrcX, SrcY: Integer); overload;
var
  SrcP, DstP: PLMDFxColor;
  W, DstY: Integer;
begin
  { Internal routine }
  W := DstRect.Right - DstRect.Left;
  SrcP := Src.PixelPtr[SrcX, SrcY];
  Assert(SrcP <> nil);
  DstP := Dst.PixelPtr[DstRect.Left, DstRect.Top];
  Assert(DstP <> nil);
  for DstY := DstRect.Top to DstRect.Bottom - 1 do
  begin
    LineTransparentFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Inc(DstP, Dst.Width);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure _BltAlphaBlend(Dst: TLMDFxBitmap; DstRect: TRect;
  Src: TLMDFxBitmap; SrcX, SrcY: Integer); overload;
var
  SrcP, DstP: PLMDFxColor;
  W, DstY: Integer;
begin
  { Internal routine }
  W := DstRect.Right - DstRect.Left;
  SrcP := Src.PixelPtr[SrcX, SrcY];
  Assert(SrcP <> nil);
  DstP := Dst.PixelPtr[DstRect.Left, DstRect.Top];
  Assert(DstP <> nil);
  for DstY := DstRect.Top to DstRect.Bottom - 1 do
  begin
    LineAlphaBlendFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Inc(DstP, Dst.Width);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure _StretchOpaque(Dst: TLMDFxBitmap; DstRect, DstClip: TRect;
  Src: TLMDFxBitmap; SrcRect: TRect);
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PLMDFxColorArray;
  Scale: Single;
begin
  IntersectRect(DstClip, DstClip, Rect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      BltOpaqueFunc(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Trunc(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      DstLine := PLMDFxColorArray(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
          SrcY := Trunc(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale)
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do
            DstLine[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end
        else
          MoveLongwordFunc(@DstLine[-Dst.Width], @DstLine[0], DstClipW);
          Inc(DstLine, Dst.Width);
          end;
    end;
  finally
    EMMS;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure _StretchTransparent(Dst: TLMDFxBitmap; DstRect, DstClip: TRect;
  Src: TLMDFxBitmap; SrcRect: TRect);
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PLMDFxColorArray;
  Buffer: TArrayOfLMDFxColor;
  Scale: Single;
begin
  IntersectRect(DstClip, DstClip, Rect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      BltTransparentFunc(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Trunc(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := PLMDFxColorArray(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Trunc(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do
            Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineTransparentFunc(@Buffer[0], @DstLine[0], DstClipW);
        Inc(DstLine, Dst.Width);
        end;
    end;
  finally
    EMMS;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure _StretchAlphaBlend(Dst: TLMDFxBitmap; DstRect, DstClip: TRect;
  var Src: TLMDFxBitmap; SrcRect: TRect);
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PLMDFxColorArray;
  Buffer: TArrayOfLMDFxColor;
  Scale: Single;
begin
  IntersectRect(DstClip, DstClip, Rect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
      { Copy without resampling }
      BltAlphaBlendFunc(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top)
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Trunc(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := PLMDFxColorArray(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Trunc(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do
            Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineAlphaBlendFunc(@Buffer[0], @DstLine[0], DstClipW);
        Inc(DstLine, Dst.Width);
        end;
    end;
  finally
    EMMS;
  end;
end;

{ Setup functions =============================================================}
procedure SetupFunctions;
begin
  StretchToDCOpaqueFunc := _StretchToDCOpaque;
  StretchToDCAlphaBlendFunc := _StretchToDCAlphaBlend;

  //if IsMsImg then
    StretchToDCTransparentFunc := MsImg_StretchToDCTransparent;
  //else
    //StretchToDCTransparentFunc := _StretchToDCTransparent;

  StretchToDibOpaqueFunc := _StretchToDibOpaque;
  StretchToDibAlphaBlendFunc := _StretchToDibAlphaBlend;
  StretchToDibTransparentFunc := _StretchToDibTransparent;

  StretchOpaqueFunc := _StretchOpaque;
  StretchAlphaBlendFunc := _StretchAlphaBlend;
  StretchTransparentFunc := _StretchTransparent;
  BltOpaqueFunc := _BltOpaque;
  BltAlphaBlendFunc := _BltAlphaBlend;
  BltTransparentFunc := _BltTransparent;

  GetBitsFromDCFunc := _GetBitsFromDC;
end;

initialization
  SetupLowLevel;
  SetupFunctions;
finalization
  FreeBitmapList;
  end.
