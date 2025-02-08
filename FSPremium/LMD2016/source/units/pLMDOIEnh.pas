unit pLMDOIEnh;

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

pLMDOIEnh unit (TS + RM)
------------------------
Introduces Object Inspector Design Enhancements
This unit contains Object Inspector Enhancements which are not directly connected
to LMD-Tools objects - LMD-Tools Property may contain OI display enhancements
as well, check for PropDrawValue property.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
{$I lmdcmps.inc}

uses
  DesignIntf, DesignEditors, VCLEditors,
  Windows, Classes, Types, Dialogs, Forms, Graphics, SysUtils, TypInfo;

type

  // Global Enhancement
  {*********************** TLMDSetProperty ************************************}
  TLMDSetProperty = class(TSetProperty)
  public
    FEnumInfo: PTypeInfo;
    procedure Initialize; override;
  procedure GetProperties(Proc: TGetPropProc); override;
    procedure GetValues(AProc: TGetStrProc); override;
  end;

  {********************* TLMDSetElementProperty *******************************}
  TLMDSetElementProperty = class(TSetElementProperty, ICustomPropertyDrawing)
  public
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas;const ARect: TRect; ASelected: Boolean);
  end;

  {*********************** TLMDBoolProperty ***********************************}
  TLMDBoolProperty = class({$IFNDEF LMDCOMP7}TBoolProperty{$ELSE}TEnumProperty{$ENDIF}, ICustomPropertyDrawing) 
  public
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas;const ARect: TRect; ASelected: Boolean);
  end;

  {*********************** TLMDBooleanProperty ********************************}
  TLMDBooleanProperty = class(TEnumProperty, ICustomPropertyDrawing)
  public
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas;const ARect: TRect; ASelected: Boolean);
  end;

  {*********************** TLMDFontProperty ***********************************}
  TLMDFontProperty = class(TFontProperty, ICustomPropertyDrawing)
    function GetValue: string; override;
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

type
  TLMDSet=0..31;

implementation
uses
  LMDTypes;

var
  FCheckDefWidth, FCheckDefHeight:Integer;

type
  TLMDIntegerSet=set of TLMDSet;

{
{*********************** TLMDSetProperty **************************************}
{------------------------- public ---------------------------------------------}
procedure TLMDSetProperty.Initialize;
begin
  inherited;
  FEnumInfo:=GetTypeData(GetPropType).CompType^;
end;

{------------------------------------------------------------------------------}
procedure TLMDSetProperty.GetProperties(Proc: TGetPropProc);
var
  i:TLMDSet;
  Data: TLMDTypeData;
begin
  Data := GetTypeData(FEnumInfo);
  for i:=Data.MinValue to Data.MaxValue do
   Proc(TLMDSetElementProperty.Create(Self,i));
end;

{------------------------------------------------------------------------------}
procedure TLMDSetProperty.GetValues(AProc: TGetStrProc);
var
  i: TLMDSet;
  Data: TLMDTypeData;
begin
  Data:=GetTypeData(FEnumInfo);
  for i:=Data.MinValue to Data.MaxValue do
    AProc(GetEnumName(FEnumInfo, i));
end;

// -- Helpers for Boolean properties -------------------------------------------
procedure LMDDrawCheckBox(ACanvas: TCanvas; const ARect: TRect; const AValue: string);
var
  tmp:TRect;
begin
  tmp:=Types.Rect(aRect.Left+1, ARect.Top + 1, aRect.Left+FCheckDefWidth+1, aRect.Top+FCheckDefHeight+1);

  aCanvas.FillRect(aRect);
  aCanvas.TextRect(aRect, tmp.Right+2, ARect.Top + 1, AValue);

  if AValue = BooleanIdents[False] then
    DrawFrameControl(aCanvas.Handle, tmp, DFC_BUTTON, DFCS_BUTTONCHECK)
  else
    DrawFrameControl(aCanvas.Handle, tmp, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED);
end;

{************************* TLMDSetElementProperty *****************************}
{------------------------- public ---------------------------------------------}
procedure TLMDSetElementProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;
{------------------------------------------------------------------------------}
procedure TLMDSetElementProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  LMDDrawCheckBox(ACanvas, ARect, Value);
end;

{********************* TLMDBoolProperty ***************************************}
{------------------------- public ---------------------------------------------}
procedure TLMDBoolProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
procedure TLMDBoolProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  LMDDrawCheckBox(ACanvas, ARect, Value);
end;

{********************* TLMDBooleanProperty ************************************}
{------------------------- public ---------------------------------------------}
procedure TLMDBooleanProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
procedure TLMDBooleanProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  LMDDrawCheckBox(ACanvas, ARect, Value);
end;

{********************* Class TLMDFontProperty *********************************}
{------------------------- public ---------------------------------------------}
function TLMDFontProperty.GetValue: string;
var
  Font: TFont;
begin
  Font := TFont(GetOrdValue);
  if Font = nil then
    Result := inherited GetValue
  else
    Result := Format('%s, %d', [Font.Name, Font.Size]);
end;

{------------------------------------------------------------------------------}
procedure TLMDFontProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
                                         ASelected: Boolean);
var
  s : String;
  bRect : TRect;
  ctemp : TColor;
begin
  aCanvas.FillRect (aRect);
  if not Assigned (Pointer(GetOrdValue)) then exit;
  with TFont(Pointer(GetOrdValue))do
  begin
      s := Name+', '+IntToStr (Size)+', ';
      ACanvas.TextOut (aRect.Left+1, aRect.Top+1, s);
      bRect := ARect;
      InflateRect (bRect, -1, -1);
      bRect.Left := bRect.Left + ACanvas.TextWidth (s) + 2;
      bRect.Right := bRect.Left + 10;
      cTemp := ACanvas.Brush.Color;
      ACanvas.Brush.Color := Color;
      ACanvas.FillRect (bRect);
      ACanvas.Brush.Color := cTemp;

      // Color Font Settings
      if ColorToRGB(Color) <> ColorToRGB(clBtnFace) then
        ACanvas.Font.Color := Color;
      ACanvas.Font.Name := Name;
      ACanvas.Font.Style := Style;
      // ----
      ACanvas.TextOut (bRect.Right+4, ARect.Top+1, ColorToString (Color));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

initialization
  {$ifndef LMDCOMP9}
  with Graphics.TBitmap.Create do
  {$else}
  with TBitmap.Create do
  {$endif}
    try
      Handle := LoadBitmap(0, PChar(32759));
      FCheckDefWidth := Width div 4;
      FCheckDefHeight := Height div 3;
    finally
      Free;
    end;

end.
