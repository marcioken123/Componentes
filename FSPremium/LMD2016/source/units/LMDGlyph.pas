unit LMDGlyph;
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

LMDGlyph unit ()
----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, Controls,
  LMDGraph, LMDButtonBase, LMD3DCaption, LMDGlyphTextLayout, LMDImageList;

type
  TLMDNumGlyphs = 0..5;

  TLMDXGlyphList = class(TLMDImageListItem)
  private
    FCount:Integer;
    FUsedBA:TBits;
    function AllocateIndex: Integer;
  public
    constructor CreateSize(aWidth, aHeight: Integer);
    destructor Destroy; override;
    function Add(Image, Mask: TBitmap): Integer;
    function AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
    procedure Delete(Index: Integer);
    property Count: Integer read FCount;
  end;

  TLMDXGlyphCache = class
  private
    FList:TList;
  public
    constructor Create;
    destructor Destroy; override;

    function GetList(aWidth, aHeight: Integer): TLMDXGlyphList;
    procedure FreeList(aList:TLMDXGlyphList);
    function Empty:Boolean;
  end;

  TLMDGlyphStyle=(gsStandard, gsExplorer);

  {-------------------- internal object for 16 color glyphs -------------------}
  TLMDGlyph=class
  private
    FBitmap: TBitmap;
    FIndexs: array[TLMDButtonState] of Integer;
    FGlyphList: TLMDXGlyphList;
    FNumGlyphs: TLMDNumGlyphs;
    FOnChange: TNotifyEvent;
    FStyle: TLMDGlyphStyle;
    FDrawnRect: TRect;
    FGlyphRect: TRect;
    FTextRect: TRect;
    FTransparentColor: TColor;
    procedure SetGlyph(aValue:TBitmap);
    procedure SetNumGlyphs(aValue:TLMDNumGlyphs);
    procedure SetStyle(aValue:TLMDGlyphStyle);
    procedure GetGlyphChange(Sender: TObject);
    procedure Init;
  public
    constructor Create;
    destructor Destroy; override;

    procedure DrawButtonGlyphAndText(
              aCanvas: TCanvas; const aString:String;
              Effects:TLMD3DCaption; aDest: TRect; State:TLMDButtonState;
              aLayout: TLMDGlyphTextLayout; ExtFlags:TLMDDrawTextStyles;
              MultiLine:Boolean; flags:LongInt);
    function GetButtonGlyph(State:TLMDButtonState):Integer;
    procedure GetStateBitmap(State : TLMDButtonState; bmp : TBitmap);

    property Glyph: TBitmap read FBitmap write SetGlyph;
    property NumGlyphs: TLMDNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property Style:TLMDGlyphStyle read FStyle write SetStyle;
    property DrawnRect: TRect read FDrawnRect;
    property GlyphRect: TRect read FGlyphRect;
    property TextRect: TRect read FTextRect;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

{global cachelist}
var
  LMDGlyphCache:TLMDXGlyphCache;

implementation

uses
  Types,
  LMDGraphUtils;

{************************ Class TLMDXGlyphList *********************************}
{------------------------- Private --------------------------------------------}
{------------------------- Public ---------------------------------------------}
constructor TLMDXGlyphList.CreateSize(aWidth, aHeight: Integer);
begin
  inherited CreateSize(AWidth, AHeight);
  FCount:=0;
  FUsedBA:=TBits.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDXGlyphList.Destroy;
begin
  FUsedBA.Free;
  FUsedBA:=nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDXGlyphList.AllocateIndex: Integer;
begin
  Result:=FUsedBA.OpenBit;
  if Result>=FUsedBA.Size then
    begin
      Result:=inherited Add(nil, nil);
      FUsedBA.Size:=Result+1;
    end;
  FUsedBA[Result]:=True;
end;

{------------------------------------------------------------------------------}
function TLMDXGlyphList.Add(Image, Mask: TBitmap): Integer;
begin
  Result:=AllocateIndex;
  Replace(Result, Image, Mask);
  Inc(FCount);
end;

{------------------------------------------------------------------------------}
function TLMDXGlyphList.AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
begin
  Result:=AllocateIndex;
  ReplaceMasked(Result, Image, MaskColor);
  Inc(FCount);
end;

{------------------------------------------------------------------------------}
procedure TLMDXGlyphList.Delete(Index: Integer);
begin
  if FUsedBA[Index] then
    begin
      Dec(FCount);
      FUsedBA[Index]:=False;
    end;
end;

{************************ Class TLMDXGlyphCache ********************************}
{------------------------- Public ---------------------------------------------}
constructor TLMDXGlyphCache.Create;
begin
  inherited Create;
  FList:=TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDXGlyphCache.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDXGlyphCache.GetList(aWidth, aHeight: Integer): TLMDXGlyphList;
var
  i:Integer;
begin
  for i:=0 to Pred(FList.Count) do
    begin
      Result:=TLMDXGlyphList(FList[i]);
      with Result do
        if (aWidth=Width) and (aHeight=Height) then exit;
    end;
  Result:=TLMDXGlyphList.CreateSize(aWidth, aHeight);
  result.Masked:=True;
  FList.Add(Result);
end;

{------------------------------------------------------------------------------}
procedure TLMDXGlyphCache.FreeList(aList:TLMDXGlyphList);
begin
  if aList=nil then exit;
  if aList.Count=0 then
    begin
      FList.Remove(aList);
      aList.Free;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDXGlyphCache.Empty: Boolean;
begin
  Result:=FList.Count=0;
end;

{************************ Class TLMDGlyph *************************************}
{------------------------- Private --------------------------------------------}
procedure TLMDGlyph.SetGlyph(aValue:TBitmap);
var
  Glyphs:Integer;
begin
  Init;
  FBitmap.Assign(aValue);
  if (aValue<>nil) and (aValue.Height> 0) then
  begin
//    FTransparentColor:=aValue.TransparentColor;
    FTransparentColor := FBitmap.TransparentColor;
    if aValue.Width mod aValue.Height = 0 then
      begin
        Glyphs:=aValue.Width div aValue.Height;
        if Glyphs>5 then Glyphs:=1;
        SetNumGlyphs(Glyphs);
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyph.SetNumGlyphs(aValue: TLMDNumGlyphs);
begin
  if (aValue<>FNumGlyphs) and (aValue>0) then
    begin
      Init;
      FNumGlyphs:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyph.SetStyle(aValue: TLMDGlyphStyle);
begin
  if (aValue<>FStyle) then
    begin
      Init;
      FStyle:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyph.Init;
var
  i:TLMDButtonState;
begin
  for i:=Low(i) to High(i) do
    if FIndexs[i]<>-1 then
      begin
        FGlyphList.Delete(FIndexs[i]);
        FIndexs[i]:=-1;
      end;

  LMDGlyphCache.FreeList(FGlyphList);
  FGlyphList:=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyph.GetGlyphChange(Sender: TObject);
begin
  if Sender = FBitmap then
    begin
      FTransparentColor:=FBitmap.TransparentColor;
      Init;
      if Assigned(FOnChange) then FOnChange(Self);
    end;
end;

{-------------------------- public --------------------------------------------}
constructor TLMDGlyph.Create;
var
  i:TLMDButtonState;
begin
  inherited Create;
  FBitmap:=TBitmap.Create;
  FBitmap.OnChange:=GetGlyphChange;
  FStyle:=gsStandard;
  FNumGlyphs:=1;
  for i:=Low(i) to High(i) do FIndexs[i]:=-1;
  if LMDGlyphCache=nil then LMDGlyphCache:=TLMDXGlyphCache.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDGlyph.Destroy;
begin
  FBitmap.OnChange:=nil;
  FBitmap.Free;
  Init;
  if Assigned(LMDGlyphCache) and LMDGlyphCache.Empty then
    begin
      LMDGlyphCache.Free;
      LMDGlyphCache := nil;
    end;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyph.DrawButtonGlyphAndText(
           aCanvas: TCanvas; const aString:String;
           Effects:TLMD3DCaption; aDest: TRect; State:TLMDButtonState;
           aLayout: TLMDGlyphTextLayout; ExtFlags:TLMDDrawTextStyles;
           MultiLine:Boolean; flags:LongInt);
var
  nr:Integer;
  LWhereRect: TLMDWhereRect;
begin
  nr:=GetButtonGlyph(State);
  FDrawnRect:=Rect(0,0,0,0);
  if nr<>-1 then
    begin
      FDrawnRect:=FGlyphList.GetImageRect(nr);
      LWhereRect := LMDDrawTextAndGlyphExt(aCanvas, aString, Effects, aDest,
                             FGlyphList.GetImageBitmap.Canvas,
                             FDrawnRect,
                             FGlyphList.GetImageMaskBitmap.Canvas,
                             FGlyphList.TransparentColor(nr), aLayout, MultiLine, True, True,
                             ExtFlags, flags)
    end
  else
    LWhereRect := LMDDrawTextAndGlyphExt(aCanvas, aString, Effects, aDest, nil, FDrawnRect,
                           nil, FTransparentColor, aLayout, MultiLine, True, True,
                           ExtFlags, flags);

  FGlyphRect := LWhereRect.GlyphRect;
  FTextRect := LWhereRect.TextRect;
end;

{------------------------------------------------------------------------------}
function TLMDGlyph.GetButtonGlyph(State:TLMDButtonState):Integer;
var
  tmp, tmp2: TBitmap;
  tw, th: Integer;
  sRect, dRect:TRect;
  tmps:Integer;
begin

  if State in [bsDisabledUp, bsDisabledDown] then
    begin
      if State=bsDisabledDown then State:=bsDisabledUp;
    end
  else
    if (Ord(State)>Pred(FNumGlyphs)) then{and not (FStyle=gsExplorer) then State:=bsUp;}
      if not (FStyle=gsExplorer) then
        State:=bsUp
      else
        if (State=bsDropDownOpen) then
          State:=bsDown
        else
          State:=bsMouseOver;

  Result:=FIndexs[State];
  if Result <> -1 then Exit;

  {wenn noch nicht vorhanden, dann generieren}
  if FBitmap.Empty then exit;
  tw:=FBitmap.Width div FNumGlyphs;
  th:=FBitmap.Height;
  if FGlyphList = nil then
    begin
      if LMDGlyphCache=nil then LMDGlyphCache:=TLMDXGlyphCache.Create;
      FGlyphList:=LMDGlyphCache.GetList(tw, th);
    end;

  tmp:=TBitmap.Create;
  try

    tmp.Width:=tw;
    tmp.Height:=th;
    dRect:=Rect(0,0,tw,th);
    tmps:=Ord(State);

    //bsUp, bsDisabledUp, bsMouseOver, bsOptionSet, bsDown,

    if (tmps<FNumGlyphs) and not ((FStyle=gsExplorer) and (tmps=0)) then
      begin
        sRect:=Rect(Ord(tmps)*tw, 0, (ord(tmps)+1)*tw, th);
        tmp.Canvas.CopyRect(dRect, FBitmap.Canvas, sRect);
        FIndexs[State]:=FGlyphList.AddMasked(tmp, FTransparentColor);
      end
    else
      begin
        sRect:=Rect(0, 0, tw, th);
        case State of
          bsUp:
            begin
              if FBitmap.Canvas.Pixels[1,1]=clNone then ;
              tmp.Canvas.CopyRect(Rect(0,0, tmp.Width, tmp.Height), FBitmap.Canvas,
                                  Bounds(sRect.Left, sRect.Top, tmp.Width, tmp.Height));

              if FStyle=gsExplorer then
                begin
                  tmp2:=TBitmap.Create;
                  try
                    LMDBmpCreateGrayscale(tmp2,tmp);
                    FIndexs[State]:=FGlyphList.AddMasked(tmp2, FTransparentColor);
                  finally
                    tmp2.Free;
                  end;
                end
            end;
          bsDown, bsOptionSet, bsMouseOver:
            begin
              if FBitmap.Canvas.Pixels[1,1]=clNone then ;
              tmp.Canvas.CopyRect(Rect(0,0,tmp.Width, tmp.Height), FBitmap.Canvas,
                                  Bounds(sRect.Left, sRect.Top, tmp.Width, tmp.Height));
              FIndexs[State]:=FGlyphList.AddMasked(tmp, FTransparentColor);
            end;
          bsDisabledUp, bsDisabledDown:
            begin
              sRect:=Rect(0, 0, tw, th);
              tmp.Canvas.CopyRect(dRect, FBitmap.Canvas, sRect);
              tmp2:=TBitmap.Create;
              try
                tmp2.Width:=tw;
                tmp2.Height:=th;
                LMDBmpDrawDisabledState(tmp2,tmp,0,0);
                FIndexs[State]:=FGlyphList.AddMasked(tmp2, FTransparentColor);
              finally
                tmp2.Free;
              end;
            end;
        end;
    end;
  finally
    Tmp.Free;
  end;
  Result:=FIndexs[State];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDGlyph.GetStateBitmap(State : TLMDButtonState; bmp : TBitmap);
var
  nr:Integer;
  tmp2,
  tmp:TRect;
begin
  nr:=GetButtonGlyph(State);
  if nr<>-1 then
    begin
      tmp:=FGlyphList.GetImageRect(nr);
      tmp2 := tmp;
      OffsetRect (tmp2, -tmp2.Left, -tmp2.Top);
      bmp.Width := tmp2.Right;
      bmp.Height := tmp2.Bottom;
      bmp.Canvas.CopyRect (tmp2, FGlyphList.GetImageBitmap.Canvas, tmp);
    end;
end;

initialization
  LMDGlyphCache:=nil;

end.
