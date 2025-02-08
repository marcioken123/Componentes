unit LMDHTMLSTYLE;
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

LMDHTMLSTYLE unit (VO)
----------------------

Used for storing current text attributes 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Graphics,
  LMDParserStack, LMDText;

type

  { ******************************* TLMDHTMLStyle ***************************** }
  TLMDHTMLStyle = class
  private
    FFontFace    : TLMDStringStack;
    FFontSize    : TLMDStringStack;
    FBaseFontSize : TLMDStringStack;
    FBaseFontFace : TLMDStringStack;
    FBaseFontColor : TLMDIntegerStack;
    FFontColor   : TLMDIntegerStack;
    FFontStyle   : TLMDFontStyleStack;
    FShadowColor : TLMDIntegerStack;
    FShadowDepth : TLMDIntegerStack;
    FLightColor  : TLMDIntegerStack;
    FLightDepth  : TLMDIntegerStack;
    FTextStyle   : TLMDIntegerStack;
    FSubscriptStyle : TLMDIntegerStack;
    FLink        : TLMDIntegerStack;
    FHREF        : TLMDStringStack;
    function  GetFontFace : string;
    function  GetFontSize : string;
    function  GetBaseFontSize : string;
    function  GetBaseFontFace : string;
    function  GetBaseFontColor : TColor;
    function  GetFontColor : TColor;
    function  GetFontStyle : TFontStyles;
    procedure SetFontStyle(aValue: TFontStyles);
    function  GetShadowColor : TColor;
    function  GetShadowDepth : byte;
    function  GetLightColor : TColor;
    function  GetLightDepth : byte;
    function  GetTextStyle : TLMDTextStyle;
    function  GetSubscriptStyle : TLMDTextSubscriptStyle;
    function  GetLink : boolean;
    function  GetHREF : string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure SetStyle(aText : TLMDText);
    procedure OpenFontFaceArea(const aFontFace : string);
    procedure CloseFontFaceArea;
    procedure OpenFontSizeArea(const aFontSize : string);
    procedure CloseFontSizeArea;
    procedure OpenBaseFontSizeArea(const aFontSize : string);
    procedure CloseBaseFontSizeArea;
    procedure OpenBaseFontFaceArea(const aFontFace : string);
    procedure CloseBaseFontFaceArea;
    procedure OpenBaseFontColorArea(aFontColor : TColor);
    procedure CloseBaseFontColorArea;
    procedure OpenFontColorArea(aFontColor : TColor);
    procedure CloseFontColorArea;
    procedure OpenFontStyleArea(aFontStyle : TFontStyles);
    procedure CloseFontStyleArea;
    procedure OpenShadowColorArea(aColor : TColor);
    procedure CloseShadowColorArea;
    procedure OpenShadowDepthArea(aDepth : byte);
    procedure CloseShadowDepthArea;
    procedure OpenLightColorArea(aColor : TColor);
    procedure CloseLightColorArea;
    procedure OpenLightDepthArea(aDepth : byte);
    procedure CloseLightDepthArea;
    procedure OpenTextStyleArea(aTextStyle : TLMDTextStyle);
    procedure CloseTextStyleArea;
    procedure OpenSubscriptStyleArea(aSStyle : TLMDTextSubscriptStyle);
    procedure CloseSubscriptStyleArea;
    procedure OpenLinkArea;
    procedure CloseLinkArea;
    procedure OpenHREFArea(const aHREF : string);
    procedure CloseHREFArea;
    property FontFace: string read GetFontFace;
    property FontSize: string read GetFontSize;
    property BaseFontSize: string read GetBaseFontSize;
    property BaseFontFace: string read GetBaseFontFace;
    property BaseFontColor: TColor read GetBaseFontColor;
    property FontColor: TColor read GetFontColor;
    property FontStyle: TFontStyles read GetFontStyle write SetFontStyle;
    property ShadowColor : TColor read GetShadowColor;
    property ShadowDepth: byte read GetShadowDepth;
    property LightColor: TColor read GetLightColor;
    property LightDepth: byte read GetLightDepth;
    property TextStyle: TLMDTextStyle read GetTextStyle;
    property SubscriptStyle: TLMDTextSubscriptStyle read GetSubscriptStyle;
    property Link: Boolean read GetLink;
    property HREF: string read GetHREF;
  end;

implementation
uses
  SysUtils;
  { ********************************* TLMDHTMLStyle ***************************** }
{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetFontFace : string;
begin result := FFontFace.Top end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetFontSize : string;
begin result := FFontSize.Top end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetBaseFontSize : string;
const
  FontSizes: array[1..7] of Byte = (10, 12, 14, 16, 18, 24, 28);
begin
  result := FBaseFontSize.Top;
  if result = '' then
    result := IntToStr(FontSizes[1]);
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetBaseFontFace : string;
begin result := FBaseFontFace.Top end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetBaseFontColor : TColor;
begin
  if FBaseFontColor.Top = -10000 then
    result := clDefault
  else
    result := TColor(FBaseFontColor.Top);
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetFontColor : TColor;
begin
  if FFontColor.Top = -10000 then
    result := clDefault
  else
    result := TColor(FFontColor.Top);
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetFontStyle : TFontStyles;
begin result := FFontStyle.Top end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.SetFontStyle(aValue: TFontStyles);
begin
  FFontStyle.Pop;
  FFontStyle.Push(aValue);
//  FFontStyle.Top := aValue;
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetShadowColor : TColor;
begin
  if FShadowColor.Top = -10000 then
    result := clbtnShadow
  else
    result := TColor(FShadowColor.Top);
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetShadowDepth : byte;
begin
  if FShadowDepth.Top = -10000 then
    result := 1
  else
    result := FShadowDepth.Top;
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetLightColor : TColor;
begin
  if FLightColor.Top = -10000 then
    result := clbtnHighLight
  else
    result := TColor(FLightColor.Top);
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetLightDepth : byte;
begin
  if FLightDepth.Top = -10000 then
    result := 1
  else
    result := FLightDepth.Top;
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetTextStyle : TLMDTextStyle;
begin
  if FTextStyle.Top = -10000 then
    result := tsNormal
  else
    result := TLMDTextStyle(FTextStyle.Top);
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetSubscriptStyle : TLMDTextSubscriptStyle;
begin
  if FSubscriptStyle.Top = -10000 then
    result := tssNone
  else
    result := TLMDTextSubscriptStyle(FSubscriptStyle.Top);
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetLink : boolean;
begin
  if FLink.Top = -10000 then
    result := False
  else
    result := boolean(FLink.Top);
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLStyle.GetHREF : string;
begin
    result := FHREF.Top;
end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDHTMLStyle.Create;
begin
  inherited;
  FFontFace    := TLMDStringStack.Create;
  FFontSize    := TLMDStringStack.Create;
  FBaseFontSize    := TLMDStringStack.Create;
  FBaseFontFace    := TLMDStringStack.Create;
  FBaseFontColor   := TLMDIntegerStack.Create;
  FFontColor   := TLMDIntegerStack.Create;
  FFontStyle   := TLMDFontStyleStack.Create;
  FShadowColor := TLMDIntegerStack.Create;
  FShadowDepth := TLMDIntegerStack.Create;
  FLightColor  := TLMDIntegerStack.Create;
  FLightDepth  := TLMDIntegerStack.Create;
  FTextStyle   := TLMDIntegerStack.Create;
  FSubscriptStyle := TLMDIntegerStack.Create;
  FLink        := TLMDIntegerStack.Create;
  FHREF        := TLMDStringStack.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDHTMLStyle.Destroy;
begin
  FFontFace.Free;
  FFontSize.Free;
  FBaseFontSize.Free;
  FBaseFontFace.Free;
  FBaseFontColor.Free;  
  FFontColor.Free;
  FFontStyle.Free;
  FShadowColor.Free;
  FShadowDepth.Free;
  FLightColor.Free;
  FLightDepth.Free;
  FTextStyle.Free;
  FSubscriptStyle.Free;
  FLink.Free;
  FHREF.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.SetStyle(aText : TLMDText);
begin
  if FontStyle <> [] then aText.FontStyle := FontStyle;
  if FontSize <> '' then
    aText.FontSize := FontSize
  else
    if BaseFontSize <> '' then
      aText.FontSize := BaseFontSize;

  if FontFace <> '' then
    aText.FontFace := FontFace
  else
    if BaseFontFace <> '' then
      aText.FontFace := BaseFontFace;

  aText.FontColor := FontColor;
  if FontColor = clDefault then
    if BaseFontColor <> clDefault then
      aText.FontColor := BaseFontColor;

  aText.Link := Link;
  aText.HREF := HREF;
  aText.TextStyle := TextStyle;
  aText.LightColor := LightColor;
  aText.LightDepth := LightDepth;
  aText.ShadowColor := ShadowColor;
  aText.ShadowDepth := ShadowDepth;
  aText.SubscriptStyle := SubscriptStyle;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.Clear;
begin
  FFontFace.Clear;
  FFontSize.Clear;
  FBaseFontSize.Clear;
  FBaseFontFace.Clear;
  FBaseFontColor.Clear;
  FFontColor.Clear;
  FFontStyle.Clear;
  FShadowColor.Clear;
  FShadowDepth.Clear;
  FLightColor.Clear;
  FLightDepth.Clear;
  FTextStyle.Clear;
  FSubscriptStyle.Clear;
  FLink.Clear;
  FHREF.Clear;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenFontFaceArea(const aFontFace : string);
begin FFontFace.Push(aFontFace) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseFontFaceArea;
begin FFontFace.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenFontSizeArea(const aFontSize : string);
begin FFontSize.Push(aFontSize) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseFontSizeArea;
begin FFontSize.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenBaseFontSizeArea(const aFontSize : string);
begin FBaseFontSize.Push(aFontSize) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseBaseFontSizeArea;
begin FBaseFontSize.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenBaseFontFaceArea(const aFontFace : string);
begin FBaseFontFace.Push(aFontFace) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseBaseFontFaceArea;
begin FBaseFontFace.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenBaseFontColorArea(aFontColor : TColor);
begin FBaseFontColor.Push(integer(aFontColor)) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseBaseFontColorArea;
begin FBaseFontColor.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenFontColorArea(aFontColor : TColor);
begin FFontColor.Push(integer(aFontColor)) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseFontColorArea;
begin FFontColor.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenFontStyleArea(aFontStyle : TFontStyles);
begin FFontStyle.Push(aFontStyle) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseFontStyleArea;
begin FFontStyle.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenShadowColorArea(aColor : TColor);
begin FShadowColor.Push(integer(aColor)) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseShadowColorArea;
begin FShadowColor.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenShadowDepthArea(aDepth : byte);
begin FShadowDepth.Push(aDepth) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseShadowDepthArea;
begin FShadowDepth.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenLightColorArea(aColor : TColor);
begin FLightColor.Push(integer(aColor)) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseLightColorArea;
begin FLightColor.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenLightDepthArea(aDepth : byte);
begin FLightDepth.Push(aDepth) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseLightDepthArea;
begin FLightDepth.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenTextStyleArea(aTextStyle : TLMDTextStyle);
begin FTextStyle.Push(integer(aTextStyle)) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseTextStyleArea;
begin FTextStyle.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenSubscriptStyleArea(aSStyle : TLMDTextSubscriptStyle);
begin FSubscriptStyle.Push(integer(aSStyle)) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseSubscriptStyleArea;
begin FSubscriptStyle.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenLinkArea;
begin FLink.Push(integer(True)) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseLinkArea;
begin FLink.Pop end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.OpenHREFArea(const aHREF : string);
begin FHREF.Push(aHREF) end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLStyle.CloseHREFArea;
begin FHREF.Pop end;

end.
