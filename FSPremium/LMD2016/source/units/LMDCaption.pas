unit LMDCaption;
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

LMDCaption unit ()
------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Graphics,
  Classes,
  Controls,
  lmdgraph,
  LMDFXCaption,
  LMDObject;

type
  TLMDCaption = class(TLMDObject)
    private
      FAlignment : TLMDAlignment;
      FCaption   : TCaption;
      FFont      : TFont;
      FFontFx    : TLMDFxCaption;
      FMultiLine : Boolean;
      FDefault   : Boolean;
      procedure SetAlignment(aValue:TLMDAlignment);
      procedure SetCaption(aValue:TCaption);
      procedure SetFont(aValue:TFont);
      procedure SetFontFx(aValue:TLMDFxCaption);
      procedure SetMultiLine(aValue:Boolean);
    protected
      procedure InitAttributes;
      procedure FontChanged(Sender:TObject);
      procedure GetChange(Sender:TObject);override;
    public
      constructor Create(Owner:TPersistent=nil);override;
      constructor CreateParams(aValue, aFontName:String; aFontSize:Integer;
                               aFontColor:TColor;aNotify:TNotifyEvent);
      destructor Destroy;override;
      procedure Assign(Source: TPersistent); override;
      function GetSetStr : String; override;
      procedure DrawCaption(aCanvas:TCanvas; aCaption:String; aRect:TRect;
                            extflags:TLMDDrawTextStyles; BackColor:TColor; pos:LongInt);
      property Default:Boolean read FDefault write FDefault;
    published
      property Alignment:TLMDAlignment read FAlignment write SetAlignment default agCenter;
      property Caption:TCaption read FCaption write SetCaption;
      property Font:TFont read FFont write SetFont;
      property FontFX:TLMDFxCaption read FFontFx write SetFontFx;
      property MultiLine:Boolean read FMultiline write SetMultiLine default false;
  end;

implementation
uses
  LMDClass, LMDGraphUtils, LMDUtils;

{------------------------- Private --------------------------------------------}
procedure TLMDCaption.SetAlignment(aValue:TLMDAlignment);
begin
  if FAlignment<>aValue then
    begin
      FAlignment:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaption.SetCaption(aValue:TCaption);
begin
  if FCaption<>aValue then
    begin
      FCaption:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaption.SetFont(aValue:TFont);
begin
  FFont.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaption.SetFontFx(aValue:TLMDFxCaption);
begin
  FFontFx.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaption.SetMultiLine(aValue:Boolean);
begin
  if aValue<>FMultiLine then
    begin
      FMultiLine:=aValue;
      Change;
    end;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDCaption.FontChanged(Sender:TObject);
begin
  if (FontFx.Angle<>0) and not LMDIsTrueTypeFont(Font) then
    if Sender=FFont then
      FontFx.Angle:=0
    else
      FFont.Name:=LMD_DEFAULTFONT;
  GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaption.InitAttributes;
begin
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FFontFx := TLMDFXCaption.Create;
  FFontFx.OnChange:=FontChanged;
  FAlignment := agCenter;
  FMultiLine := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaption.GetChange(Sender:TObject);
begin
  inherited GetChange(Sender);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCaption.Create;
begin
  inherited Create;
  InitAttributes;
end;

{------------------------------------------------------------------------------}
constructor TLMDCaption.CreateParams(aValue, aFontName:String; aFontSize:Integer;
            aFontColor:TColor; aNotify:TNotifyEvent);
begin
  inherited Create;
  InitAttributes;
  FCaption:=aValue;
  if aFontName<>'' then FFont.Name:=aFontName;
  if aFontsize>0 then FFont.Size:=aFontSize;
  FFont.Color:=aFontColor;
  FDefault:=True;
  OnChange:=aNotify;
end;

{------------------------------------------------------------------------------}
destructor TLMDCaption.Destroy;
begin
  FFontFx.OnChange:=nil;
  FFont.OnChange:=nil;
  FFont.Free;
  FFontFx.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaption.Assign(Source: TPersistent);
var
  S: TLMDCaption;
begin
  if source=self then exit;
  if Source is TLMDCaption then
    begin
      S := TLMDCaption(Source);
      BeginUpdate;
      FFont.Assign(S.Font);
      FFontFx.Assign(S.FontFx);
      FAlignment:=S.Alignment;
      FCaption:=S.Caption;
      FMultiLine:=S.MultiLine;
      EndUpdate(True);
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDCaption.GetSetStr : String;
begin
  result := '{'+FCaption+'}';
end;

{------------------------------------------------------------------------------}
procedure TLMDCaption.DrawCaption(aCanvas:TCanvas; aCaption:String;
                                  aRect:TRect; extflags:TLMDDrawTextStyles;
                                  BackColor:TColor; pos:LongInt);
var
  flags:Word;
  RgnRect:TRect;
begin

  if aCaption='' then
   if Default then aCaption:=FCaption;

  if dtClip in extflags then
    if pos=0 then
      RgnRect:=aRect
    else
      with aRect do RgnRect:=Bounds(LoWord(Pos)+Left,HiWord(pos)+Top, Right-Left, Bottom-Top);

  {Flags for DrawText}
  flags:=DT_EXPANDTABS or DT_WORDBREAK or TLMDAlignFlags[FAlignment];
  if not (dtAccelChar in Extflags) then Flags := Flags or DT_NOPREFIX;

  if FFontFx.Angle>0 then
    begin
      flags:=flags or DT_SINGLELINE;
      if not (FAlignment=agTopLeft) then
        aRect:=LMDAlignTextRect(FAlignment, aCaption, FFontFx, aRect, FFont,
                                FMultiLine, dtAccelChar in ExtFlags, flags)
    end
  else
    if not FMultiLine then
      flags:=flags or DT_SINGLELINE
    else
      if not (FAlignment in [agTopLeft, agTopCenter, agTopRight]) then
        aRect:=LMDAlignTextRect(FAlignment, aCaption, FFontFx, aRect, FFont,
                                FMultiLine, dtAccelChar in ExtFlags, flags);

  aCanvas.Brush.Style:=bsClear;
  aCanvas.Brush.Color:=BackColor;
  aCanvas.Font:=FFont;

  LMDDrawTextExt(aCanvas, aCaption, FFontFx, aRect, flags, extflags, @RgnRect);

end;

end.

