unit LMDGradient;
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

LMDGradient unit (RM)
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Classes,
  LMDGraph, LMDObject;

type
  TLMDGradientColorEntry = record
    Color : TColor;
    ColorCount : Integer;
    Further : Pointer;
  end;

  TLMDGradientMode = (gmTwoColors, gmColorArray);

  TLMDGradient = class(TLMDObject)
  private
    FColorCount : TLMDColorCount;
    FColor      : TColor;
    FColorList  : TList;
    FEndColor   : TColor;
    FPaletteRealize:Boolean;
    FPalette    : HPalette;
    FStyle      : TLMDGradientStyle;
    FColors     : TList;
    FTwoColors  : Boolean;

    procedure SetColor(aValue:TColor);
    procedure SetStyle(aValue:TLMDGradientStyle);
    procedure SetEndColor(aValue:TColor);
    procedure SetColorCount(aValue:TLMDColorCount);
    procedure SetPaletteRealize(aValue:Boolean);
    procedure SetTwoColors (aValue : Boolean);
    procedure SetColors (aValue : TList);
    procedure DestroyPalette;
    procedure WriteColorArray (Writer : TWriter);
    procedure ReadColorArray (Reader : TReader);
    {$IFDEF LMDTOOLS10} procedure ReadIdent(Reader:TReader); {$ENDIF}
  protected
    procedure DefineProperties(Filer:TFiler);override;
    function  GetPalette:HPalette;
    procedure Change;override;
  public
    constructor Create(Owner: TPersistent = nil); override;
    destructor Destroy;override;
    procedure InitPalette;
    procedure Assign(Source: TPersistent);override;
    function GetSetStr : String; override;
    procedure PaintGradient(aCanvas:TCanvas; aRect:TRect);
    procedure SetRealPalette(aCanvas:TCanvas);
    property Palette:HPalette read GetPalette;
    property ColorList:TList read FColorList;
    property Colors : TList read FColors write SetColors;
  published
    property Color:TColor read FColor write SetColor default clBlue;
    property ColorCount:TLMDColorCount read FColorCount write SetColorCount default 16;
    property Style:TLMDGradientStyle read FStyle write SetStyle default gstVertical;
    property EndColor:TColor read FEndColor write SetEndColor default clBlack;
    property PaletteRealize:Boolean read FPaletteRealize write SetPaletteRealize default False;
    property TwoColors : Boolean read FTwoColors write SetTwoColors default true;
  end;

implementation
uses
  SysUtils, TypInfo, LMDGraphUtils, LMDTypes;

procedure LMDCopyList (source, target : TList);
var
  i : Integer;
begin
  if source = nil then Exit;
  if target = nil then target := TList.Create;
  target.Clear;
  for i := 0 to source.Count - 1 do
    target.Add (source[i]);
end;

{------------------------- Private --------------------------------------------}
procedure TLMDGradient.SetColor(aValue:TColor);
begin
  if aValue<>FColor then
    begin
      FColor:=aValue;
      InitPalette;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.SetStyle(aValue:TLMDGradientStyle);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.SetEndColor(aValue:TColor);
begin
  if aValue<>FEndColor then
    begin
      FEndColor:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.SetColorCount(aValue:TLMDColorCount);
begin
  if aValue<>FColorCount then
    begin
      FColorCount:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.SetPaletteRealize(aValue:Boolean);
begin
  if aValue<>FPaletteRealize then
    begin
      FPaletteRealize:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.SetTwoColors (aValue : Boolean);
begin
  if aValue <> FTwoColors then
    begin
      FTwoColors := aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.SetColors (aValue : TList);
begin
  LMDCopyList (aValue, FColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.WriteColorArray (Writer : TWriter);
var
  i : Integer;
begin
  Writer.WriteListBegin;
  for i := 0 to FColors.Count - 1 do
    Writer.WriteInteger (LongInt(FColors[i]));
  Writer.WriteListEnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.ReadColorArray (Reader : TReader);
begin
  FColors.Clear;  // 7.01 RM
  BeginUpdate;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    begin
      FColors.Add(Pointer(TLMDPtrUInt(Reader.ReadInteger)));
    end;
  Reader.ReadListEnd;
  EndUpdate(true);
end;

{$IFDEF LMDTOOLS10}
{------------------------------------------------------------------------------}
procedure TLMDGradient.ReadIdent(Reader:TReader);
var
  tmp:String;
begin
  tmp:=Reader.ReadIdent;
  if (tmp='mdHorizontal') or (tmp='mdHorizontalReverse') then FStyle:=gstHorizontal;
  if (tmp='mdVertical') or (tmp='mdVerticalReverse') then FStyle:=gstVertical;
end;
{$ENDIF}

{------------------------------------------------------------------------------}
procedure TLMDGradient.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer) ;
  {$IFDEF LMDTOOLS10}
  Filer.DefineProperty('Direction', ReadIdent, nil, false );
  {$ENDIF}
  Filer.DefineProperty('ColorList', ReadColorArray, WriteColorArray, (FColors.Count <> 0 ));
end;

{------------------------- Protected ------------------------------------------}
Function TLMDGradient.GetPalette:HPalette;
begin
  result:=FPalette;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.InitPalette;
var
  i : Integer;
  LColorAreas: Integer;
begin
  DestroyPalette;
  if FTwoColors then
    LMDGradientCreateColorList(FColor, FEndColor, FColorCount, FColorList, true)
  else
    if FColors.Count > 1 then
    begin
      if LongInt(FColors[1]) = clNone then
        LMDGradientCreateColorList(LongInt(FColors[0]), LongInt(FColors[1]), 2, FColorList, true)
      else
        LMDGradientCreateColorList(LongInt(FColors[0]), LongInt(FColors[1]), FColorCount div FColors.Count, FColorList, true);
      LColorAreas := 0;
      for i := 0 to FColors.Count - 1 do
      begin
        if LongInt(FColors[i]) <> clNone then
          inc(LColorAreas);
      end;
      i := 1;
      while(i <= FColors.Count - 2) do
      begin
        if (LongInt(FColors[i + 1])) = clNone then
        begin
          inc(i);
          if (i + 1) < FColors.Count then
            LMDGradientCreateColorList(LongInt(FColors[i]), LongInt(FColors[i+1]), 2, FColorList, false);
        end
        else
          LMDGradientCreateColorList(LongInt(FColors[i]), LongInt(FColors[i+1]), FColorCount div LColorAreas, FColorList, false);
        inc(i);
      end;
    end;
  if FPaletteRealize then
    FPalette:=LMDGradientCreatePalette(FColorList);
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.DestroyPalette;
begin
  if FPalette <> 0 then  //added 4.51
    if DeleteObject(FPalette) then FPalette:=0;
  FColorList.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.Change;
begin
  InitPalette;
  inherited Change;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDGradient.Create(Owner: TPersistent = nil);
begin
  inherited Create(Owner);
  FColorList:=TList.Create;
  FColor:=clblue;
  FEndColor:=clBlack;
  FStyle:=gstVertical;
  FColorCount:=16;
  FPaletteRealize:=False;
  FTwoColors := true;
  FColors := TList.Create;
  InitPalette;
end;

{------------------------------------------------------------------------------}
destructor TLMDGradient.Destroy;
begin
  FColors.Free;
  DestroyPalette;
  FColorList.Free;
  inherited destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.Assign(source:TPersistent);
var
  S: TLMDGradient;
begin

  if source=self then exit;
  if Source is TLMDGradient then
    begin
      S := TLMDGradient(Source);
      BeginUpdate;
      FColorCount:=S.ColorCount;
      FColor:=S.Color;
      FStyle:=S.Style;
      FEndColor:=S.EndColor;
      FPaletteRealize:=S.PaletteRealize;
      FTwoColors:=S.TwoColors;
      LMDCopyList (S.Colors, FColors);
      EndUpdate(True);
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDGradient.GetSetStr : String;
begin
  result:=GetEnumName(TypeInfo(TLMDGradientStyle), Ord(FStyle));
  result:=Copy(result, 3, Length(result)-2) + ', Col: '+IntToStr (FColorCount);
  if FTwoColors then
    result := result + ', 2 col mode'
  else
    result := result + ', mult. col mode';
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.PaintGradient(aCanvas:TCanvas; aRect:TRect);
var
  flags:Word;
begin
  flags:=0;
  if FPaletteRealize then flags:=DSF_PaletteRealize;
  LMDGradientPaintExt(aCanvas, aRect, FStyle, FColorList, FPalette, flags, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDGradient.SetRealPalette(aCanvas:TCanvas);
begin
  if FPaletteRealize then
    with aCanvas do
      begin
        SelectPalette(Handle, FPalette, False);
        RealizePalette(Handle);
      end;
end;

end.
