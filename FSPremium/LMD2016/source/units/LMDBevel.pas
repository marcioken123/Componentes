unit LMDBevel;
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

LMDBevel unit (RM)
------------------
A bevel object contains information about a control's border style.

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
  TLMDBevel = class(TLMDObject)
  private
    FBevelStyleInner,
    FBevelStyleOuter  : TLMDBevelStyle;
    FBevelWidthInner,
    FBevelWidthOuter  : TLMDBevelWidth;
    FBorderColor      : TColor;
    FBorderSpace,
    FBorderWidth      : TLMDBorderWidth;
    FBorderSides      : TLMDFrameSides;
    FEdgeStyle        : TLMDEdgeStyle;
    FExt,
    FExtr             : Integer;
    FLightColor       : TColor;
    FMode             : TLMDBevelMode;
    FShadowColor      : TColor;
    FStyle            : TLMDBorderStyle;
    FSupport          : Boolean;
    FModeChanging      : Boolean;
    procedure SetBevelStyleInner(aValue: TLMDBevelStyle);
    procedure SetBevelStyleOuter(aValue: TLMDBevelStyle);
    procedure SetBevelWidthInner(aValue: TLMDBevelWidth);
    procedure SetBevelWidthOuter(aValue: TLMDBevelWidth);
    procedure SetColor(Index:Integer; aValue: TColor);
    procedure SetBorderWidth(aValue: TLMDBorderWidth);
    procedure SetBorderSides(aValue: TLMDFrameSides);
    procedure SetBorderSpace(aValue: TLMDBorderWidth);
    procedure SetEdgeStyle(aValue:TLMDEdgeStyle);
    procedure SetMode(aValue:TLMDBevelMode);
    procedure SetStyle(aValue:TLMDBorderStyle);
    function  GetBevelExtend:Integer;
  protected
    procedure Change;override;
  public
    constructor Create(AOwner:TPersistent=nil);override;
    procedure Assign(Source:TPersistent);override;
    function GetSetStr : String; override;
    function ClientRect(ControlRect:TRect):TRect;
    function PaintBevel(aCanvas:TCanvas;aRect:TRect;Transparent:Boolean):TRect; virtual;
    property BevelExtend:Integer read FExt;
    property BevelExtendRight:Integer read FExtR;
    property SupportWindowsMode:Boolean read FSupport write FSupport;
    property ModeChanging: Boolean read FModeChanging; 
  published
    property StyleInner:TLMDBevelStyle read FBevelStyleInner write SetBevelStyleInner default bvNone;
    property StyleOuter:TLMDBevelStyle read FBevelStyleOuter write SetBevelStyleOuter default bvNone;
    property WidthInner:TLMDBevelWidth read FBevelWidthInner write SetBevelWidthInner default 1;
    property WidthOuter:TLMDBevelWidth read FBevelWidthOuter write SetBevelWidthOuter default 1;
    property BorderColor:TColor index 0 read FBorderColor write SetColor default clBtnFace;
    property BorderSides:TLMDFrameSides read FBorderSides write SetBorderSides default
                                             [fsBottom, fsLeft, fsRight, fsTop];
    property BorderWidth:TLMDBorderWidth read FBorderWidth write SetBorderWidth default 0;
    property BorderInnerWidth:TLMDBorderWidth read FBorderSpace write SetBorderSpace default 0;
    property EdgeStyle:TLMDEdgeStyle read FEdgeStyle write SetEdgeStyle default etEtched;
    property LightColor:TColor index 1 read FLightColor write SetColor default clBtnHighlight;
    // if a default value is set this value will not be stored in controls which need
    // a different default (e.g. edit control have as default bmWindows, is s.o.
    // changes this to bmCustom and this is the bevel's default this will not
    // be stored!!!!!!)
    property Mode:TLMDBevelMode read FMode write SetMode; {3.5: default bmCustom;, removed JH, 13.03.2001}
    property ShadowColor:TColor index 2 read FShadowColor write SetColor default clBtnShadow;
    property StandardStyle:TLMDBorderStyle read FStyle write SetStyle default lsSingleLowered;
  end;

implementation

uses
  LMDGraphUtils, TypInfo{$IFDEF LMD_DEBUGTRACE}, dialogs;{$I C2.INC}{$ELSE};{$ENDIF}

{------------------------- Private --------------------------------------------}
function TLMDBevel.GetBevelExtend:Integer;
begin
  result:=0;
  case FMode of
    bmCustom:
      begin
        if FBevelStyleInner=bvShadow then
          begin
            result:=FBevelWidthInner+FBorderSpace;
            exit;
          end;

        Inc(result,FBorderWidth+FBorderSpace);

        if (FBevelStyleOuter=bvNone) and (FBevelStyleInner=bvNone) then exit;

        {outer bevel}
        Inc(result, FBevelWidthOuter*Byte(FBevelStyleOuter<>bvNone));
        if FBevelStyleOuter in [bvFrameLowered, bvFrameRaised] then Inc(result);

        {inner bevel}
        inc(result,FBevelWidthInner*Byte(FBevelStyleInner<>bvNone));
        if FBevelStyleInner in [bvFrameLowered, bvFrameRaised] then Inc(result);

      end;
    bmStandard:
      begin
        result:=LMDDrawStdFrameExt(FStyle);
        inc(result, FBorderSpace);
      end;
    bmEdge:
      begin
        if FBorderSides<>[] then result:=2;
        inc(result, FBorderSpace);
      end;
    bmWindows:
      if FSupport then
        result:=0
      else
        result:=FBorderSpace+2;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevel.SetBevelStyleInner(aValue: TLMDBevelStyle);
begin
  if FBevelStyleInner<>aValue then
    begin
      If FBevelStyleinner=bvShadow then FBevelStyleOuter:=bvNone;
      FBevelStyleInner:=aValue;
      if FBevelStyleInner=bvShadow then FBevelStyleOuter:=FBevelStyleInner;
      Change;
    end;
end;
{------------------------------------------------------------------------------}
procedure TLMDBevel.SetBevelStyleOuter(aValue: TLMDBevelStyle);
begin
  if FBevelStyleOuter<>aValue then
    begin
      If FBevelStyleOuter=bvShadow then FBevelStyleInner:=bvNone;
      FBevelStyleOuter := aValue;
      if FBevelStyleOuter=bvShadow then FBevelStyleInner:=FBevelStyleOuter;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevel.SetBevelWidthInner(aValue: TLMDBevelWidth);
begin
  if aValue<>FBevelWidthInner then
    begin
      FBevelWidthInner := aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevel.SetBevelWidthOuter(aValue: TLMDBevelWidth);
begin
  if aValue<>FBevelWidthOuter then
    begin
      FBevelWidthOuter := aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevel.SetBorderSides(aValue:TLMDFrameSides);
begin
  if aValue<>FBorderSides then
    begin
      FBorderSides:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevel.SetBorderSpace(aValue: TLMDBorderWidth);
begin
  if aValue<>FBorderSpace then
    begin
      FBorderSpace := aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevel.SetBorderWidth(aValue: TLMDBorderWidth);
begin
  if aValue<>FBorderWidth then
    begin
      FBorderWidth := aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevel.SetColor(Index:Integer;aValue: TColor);
begin
  case Index of
    0:If FBorderColor=aValue then exit else FBorderColor:=aValue;
    1:if FLightColor=aValue then exit else FLightColor:=aValue;
    2:if FShadowColor=aValue then exit else FShadowColor:=aValue;
  end;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevel.SetEdgeStyle(aValue:TLMDEdgeStyle);
begin
  if aValue<>FEdgeStyle then
    begin
      FEdgeStyle:=aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevel.SetMode(aValue:TLMDBevelMode);
begin
  if aValue<>FMode then
    begin
      FMode:=aValue;
      FModeChanging := true;
      Change;
      FModeChanging := false;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBevel.SetStyle(aValue:TLMDBorderStyle);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      if Mode=bmStandard then Change;
    end;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDBevel.Change;
begin
  FExt:=GetBevelExtend;
  if (FMode=bmCustom) and (FBevelStyleOuter=bvShadow) then
    begin
      FExtR:=FBevelWidthInner+FBevelWidthOuter+FBorderSpace;
    end
  else
    FExtR:=FExt;
  inherited Change;
end;

{------------------------- Public ---------------------------------------------}
procedure TLMDBevel.Assign(Source: TPersistent);
var
  S: TLMDBevel;
begin
  if Source=self then exit;
  if Source is TLMDBevel then
    begin
      S := TLMDBevel(Source);
      FBevelStyleInner:=S.StyleInner;
      FBevelStyleOuter:=S.StyleOuter;
      FBevelWidthInner:=S.WidthInner;
      FBevelWidthOuter:=S.WidthOuter;
      FBorderSides:=S.BorderSides;
      FBorderSpace:=S.BorderInnerWidth;
      FBorderWidth:=S.BorderWidth;
      FBorderColor:=S.BorderColor;
      FLightColor:=S.LightColor;
      FShadowColor:=S.ShadowColor;
      FMode:=S.Mode;
      FStyle:=S.StandardStyle;
      FEdgeStyle:=S.EdgeStyle;
      FSupport:=S.SupportWindowsMode;
      Change;
      Exit;
    end;
  inherited Assign(Source);
end;

{------------------------------------------------------------------------------}
function TLMDBevel.GetSetStr : String;
begin
  result:=GetEnumName(TypeInfo(TLMDBevelMode), Ord(FMode));
  result:='{'+Copy(result, 3, Length(result)-2)+'}';
end;

{------------------------------------------------------------------------------}
constructor TLMDBevel.Create;
begin
  inherited Create(aOwner);

  FBevelWidthOuter:=1;
  FBevelWidthInner:=1;
  FBorderColor:=clBtnFace;
  FShadowcolor:=clBtnShadow;
  FLightColor:=clBtnHighlight;

  FBevelStyleInner:=bvNone;
  FBevelStyleOuter:=bvNone;
  FBorderWidth:=0;
  FBorderSpace:=0;
  FEdgeStyle:=etEtched;
  FBorderSides:=[fsBottom, fsLeft, fsRight, fsTop];
  FMode:=bmCustom;
  FStyle:=lsSingleLowered;
  FExt:=0;
  FSupport:=False;
end;

{------------------------------------------------------------------------------}
function TLMDBevel.ClientRect(ControlRect:TRect):TRect;
begin
  result:=ControlRect;
  if (FMode=bmCustom) and (FBevelStyleOuter=bvShadow) then
    begin
      result.Left:=result.Left+FBevelWidthInner+FBorderSpace;
      result.Top:=result.Top+FBevelWidthInner+FBorderSpace;
      result.Right:=result.Right-FBevelWidthInner-FBevelWidthOuter-FBorderSpace;
      result.Bottom:=result.Bottom-FBevelWidthInner-FBevelWidthOuter-FBorderSpace;
      exit;
    end;
  InflateRect(result, -FExt, -FExt);
end;

{------------------------------------------------------------------------------}
function TLMDBevel.PaintBevel(aCanvas:TCanvas;aRect:TRect;Transparent:Boolean):TRect;
var
  edge:Integer;
  flags:Word;
  sRect, ssRect:TRect;
  Rgn, ExRgn:HRgn;

  procedure MakeSpace(aValue:Integer);
  var
    i:Integer;
  begin
    if Transparent then
      InflateRect(aRect, -aValue, -aValue)
    else
      with aCanvas do
        begin
          brush.color:=FBorderColor;
          for i:=1 to aValue do
            begin
              FrameRect(aRect);
              InflateRect(aRect, -1, -1);
            end;
        end;
  end;

  // 7.0
  procedure AddSide(aFlag:Word; var iSide, oSide:Integer; const aValue:Integer);
  begin
    flags:=flags or aFlag;
    Inc(iSide, aValue);
    Dec(oSide, aValue);

  end;

begin
  // -> Malen,...
  if FExt=0 then
    begin
      result:=aRect;
      exit;
    end;

  case FMode of
    bmCustom:
      begin
        {draw outer bevel}
        if FBevelStyleOuter=bvShadow then
          LMDDrawFrameShadow(aCanvas, aRect, FLightColor, FShadowColor, FBorderColor,
                             FBevelWidthOuter, FBevelWidthInner, Transparent, 0)
        else
          begin
            LMDDrawFrame3D(aCanvas, aRect, FBevelStyleouter, FLightcolor, FShadowcolor, FBevelWidthOuter);
            MakeSpace(FBorderWidth);
            LMDDrawFrame3D(aCanvas, aRect,  FBevelStyleInner, FLightcolor, FShadowcolor, FBevelWidthInner);
          end;
      end;
    bmStandard:
      LMDDrawStdFrame(aCanvas, aRect, FStyle, 0);
    bmEdge:
      begin
        edge:=0;
        flags:=0;
        if FBorderSides<>[] then
          begin
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

            // 7.0
            // ======
            sRect:=aRect;ssRect:=aRect;
            if fsBottom in FBorderSides then AddSide(BF_BOTTOM, sRect.Bottom, ssRect.Bottom, 2);
            if fsTop in FBorderSides then AddSide(BF_TOP, sRect.Top, ssRect.Top, -2);
            if fsRight in FBorderSides then AddSide(BF_RIGHT, sRect.Right, ssRect.Right, 2);
            if fsLeft in FBorderSides then AddSide(BF_LEFT, sRect.Left, ssRect.Left, -2);

            DrawEdge(aCanvas.Handle, aRect, edge, flags);
            // --> we need to fill non-transparent areas (e.g. in NCPaint messages)
            If not Transparent then
              begin
                InflateRect(sRect, -2,-2);
                Rgn:=CreateRectRgnIndirect(aRect);
                try
                  ExRgn:=CreateRectRgnIndirect(sRect);
                  try
                    SelectClipRgn(aCanvas.Handle, Rgn);
                    ExtSelectClipRgn(aCanvas.Handle, ExRgn, RGN_DIFF);
                    Windows.FillRect(aCanvas.Handle, aRect, aCanvas.Brush.Handle);
                  finally
                    DeleteObject(ExRgn);
                  end
                finally
                  DeleteObject(Rgn);
                  SelectClipRgn(aCanvas.Handle,0);
                end;
              end;
            aRect:=ssRect;
          end;
      end;
    bmWindows:
      //calling component does not support bmWindows Mode
      LMDDrawStdFrame(aCanvas, aRect, lsLoweredExt, 0);
  end;
  MakeSpace(FBorderSpace);
  result:=aRect;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC} 
{$ENDIF}

end.
