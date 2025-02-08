unit LMDConversion;
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

LMDConversion unit (RM)
-----------------------
Conversion routines (Pixel, Twips, cm, mm). Taken from RichPack.

Changes
-------
Release 4.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Sysutils, Classes, Windows, LMDTypes;

const
  LMDTwipsPerInch       = 1440;
  MillimetersPerInch = 25.4;
  PointsPerInch      = 72;
  TwipsPerPoints     = (LMDTwipsPerInch div PointsPerInch);

  InchFactor         = 100;

function LMDMillimetersToInches(aValue:Double):Double;
function LMDMillimetersToPoints(aValue: Double): Double;
function LMDInchesToPoints(aValue: Double): Double;
function LMDInchesToMillimeters(aValue:Double):Double;
function LMDPointsToMillimeters(aValue: Double): Double;
function LMDPointsToInches(aValue: Double): Double;

function LMDTwipsToPoints(aValue: Double): Double;
function LMDTwipsToMillimeters(aValue: Double): Double;
function LMDTwipsToInches(aValue:Double):Double;
function LMDTwipsToPixelsX(aValue: integer): integer;
function LMDTwipsToPixels(aValue, aFactor: integer): integer;

function LMDPointsToTwips(aValue:Double):integer; overload;
function LMDMillimetersToTwips(aValue:Double):integer; overload;
function LMDInchesToTwips(aValue:Double):integer; overload;

function LMDPointsToPixelsX(aValue:Double): double;
function LMDMillimetersToPixelsX(aValue:Double):double;
function LMDInchesToPixelsX(aValue:Double):double;
function LMDPixelsXToTwips(aValue: integer): integer;
function LMDToPixelsX(aValue: double; Units: TLMDUnits): integer; overload;
function LMDToPixelsX(aValue: integer; Units: TLMDUnits): integer; overload;

function LMDPixelsXTo(aValue: integer; Units: TLMDUnits): integer;

function LMDToTwips(aValue: double; Units: TLMDUnits): integer; overload;
function LMDTwipsTo(aValue: integer; Units: TLMDUnits): double;
function LMDToPoints(aValue: integer; Units: TLMDUnits): integer;
function LMDPointsTo(aValue: integer; Units: TLMDUnits): integer;
function LMDConvertUnits(aValue: double; FromUnits, ToUnits: TLMDUnits): double;

function LMDUnitsToString(Units: TLMDUnits): string;

implementation
uses
  Printers, WinSpool, LMDRTLXConst;

type
  TMeasureConverterToInches = function(aValue: double): double;

function  SomeMeasureToPixelsX(aValue: double;
              Converter: TMeasureConverterToInches): double;
var
  DC: HDC;
begin
  DC:= GetDC(0);
  Result:= aValue * GetDeviceCaps(DC, LOGPIXELSX);
  ReleaseDC(0, DC);
  if  Assigned(Converter) then
    Result := Converter(Result) / InchFactor;
end;

{------------------------------------------------------------------------------}
function LMDPointsToPixelsX(aValue:Double):double;
begin
  Result := SomeMeasureToPixelsX(aValue, LMDPointsToInches);
end;

{------------------------------------------------------------------------------}
function LMDMillimetersToPixelsX(aValue:Double):Double;
begin
  Result := SomeMeasureToPixelsX(aValue, LMDMillimetersToInches);
end;

{------------------------------------------------------------------------------}
function LMDInchesToPixelsX(aValue:Double):Double;
begin
  Result := SomeMeasureToPixelsX(aValue / InchFactor, nil);
end;

{------------------------------------------------------------------------------}
function LMDTwipsToPixelsX(aValue: integer): integer;
begin
  Result := Round(SomeMeasureToPixelsX(aValue, LMDTwipsToInches));
end;

{------------------------------------------------------------------------------}
function LMDTwipsToPixels(aValue, aFactor: integer): integer;
begin
  Result := MulDiv(aValue, aFactor, LMDTwipsPerInch);
end;

{------------------------------------------------------------------------------}
function LMDToPixelsX(aValue: double; Units: TLMDUnits): integer;
begin
  if  aValue = 0  then
    Result := 0
  else
    case Units of
      unPoints: Result := Round(LMDPointsToPixelsX(aValue));
      unInches: Result := Round(LMDInchesToPixelsX(aValue));
      unMillimeters: Result := Round(LMDMillimetersToPixelsX(aValue));
    else
      Result := Round(aValue);
    end;
end;

{------------------------------------------------------------------------------}
function LMDToPixelsX(aValue: integer; Units: TLMDUnits): integer;
begin
  if  aValue = 0  then
    Result := 0
  else
    case Units of
      unPoints: Result := Round(LMDPointsToPixelsX(aValue));
      unInches: Result := Round(LMDInchesToPixelsX(aValue));
      unMillimeters: Result := Round(LMDMillimetersToPixelsX(aValue));
      else
        Result := Round(aValue);
    end;
end;

{------------------------------------------------------------------------------}
function LMDPixelsXToTwips(aValue: integer): integer;
var
  DC: HDC;
begin
  DC:= GetDC(0);
  Result:= MulDiv(aValue, LMDTwipsPerInch, GetDeviceCaps(DC, LOGPIXELSX));
  ReleaseDC(0, DC);
end;

{------------------------------------------------------------------------------}
function LMDPixelsXTo(aValue: integer; Units: TLMDUnits): integer;
var
  DC: HDC;
  V: double;
begin
  case Units of
    unPoints: V := aValue * PointsPerInch;
    unInches: V := aValue * InchFactor;
    unMillimeters: V := aValue * MillimetersPerInch;
    else
      V := aValue;
  end;

  DC:= GetDC(0);
  Result:= Round(V / GetDeviceCaps(DC, LOGPIXELSX));
  ReleaseDC(0, DC);
end;

{------------------------------------------------------------------------------}
function LMDTwipsToPoints(aValue: Double): Double;
begin
  Result := aValue / TwipsPerPoints;
end;

{------------------------------------------------------------------------------}
function LMDTwipsToMillimeters(aValue: Double): Double;
begin
  Result := aValue * MillimetersPerInch / LMDTwipsPerInch;
end;

{------------------------------------------------------------------------------}
function LMDTwipsToInches(aValue:Double):Double;
begin
  Result := aValue * InchFactor / LMDTwipsPerInch;
end;

{------------------------------------------------------------------------------}
function LMDPointsToTwips(aValue:Double):integer;
begin
  Result := Round(aValue * TwipsPerPoints);
end;

{------------------------------------------------------------------------------}
function LMDMillimetersToTwips(aValue:Double):integer;
begin
  Result := Round(aValue * LMDTwipsPerInch / MillimetersPerInch);
end;

{------------------------------------------------------------------------------}
function LMDInchesToTwips(aValue:Double):integer;
begin
  Result := Round(aValue * LMDTwipsPerInch / InchFactor);
end;

{------------------------------------------------------------------------------}
function LMDMillimetersToInches(aValue:Double):Double;
begin
  Result := aValue * InchFactor / MillimetersPerInch;
//  Result:= aValue/25.4;
end;

{------------------------------------------------------------------------------}
function LMDInchesToMillimeters(aValue:Double):Double;
begin
  Result := aValue * MillimetersPerInch / InchFactor;
//  Result:= aValue*25.4;
end;

{------------------------------------------------------------------------------}
function LMDPointsToMillimeters(aValue: Double): Double;
begin
  Result := aValue * MillimetersPerInch / PointsPerInch;
end;

{------------------------------------------------------------------------------}
function LMDPointsToInches(aValue: Double): Double;
begin
  Result := aValue * InchFactor / PointsPerInch;
end;

{------------------------------------------------------------------------------}
function LMDInchesToPoints(aValue: Double): Double;
begin
  Result := aValue * PointsPerInch / InchFactor;
end;

{------------------------------------------------------------------------------}
function LMDMillimetersToPoints(aValue: Double): Double;
begin
  Result := aValue * PointsPerInch / MillimetersPerInch;
end;

{------------------------------------------------------------------------------}
function LMDToTwips(aValue: double; Units: TLMDUnits): integer;
begin
  case Units of
    unPoints: Result := LMDPointsToTwips(aValue);
    unInches: Result := LMDInchesToTwips(aValue);
    unMillimeters: Result := LMDMillimetersToTwips(aValue);
  else
    Result := Round(aValue);
  end;
end;

{------------------------------------------------------------------------------}
function LMDTwipsTo(aValue: integer; Units: TLMDUnits): double;
begin
  case Units of
    unPoints: Result := LMDTwipsToPoints(aValue);
    unInches: Result := LMDTwipsToInches(aValue);
    unMillimeters: Result := LMDTwipsToMillimeters(aValue);
    else
      Result := aValue;
  end;
end;

{------------------------------------------------------------------------------}
function LMDToPoints(aValue: integer; Units: TLMDUnits): integer;
begin
  case Units of
//    unPoints: Result := LMDPointsToTwips(aValue);
    unInches: Result := Round(LMDInchesToPoints(aValue));
    unMillimeters: Result := Round(LMDMillimetersToPoints(aValue));
  else
    Result := aValue;
  end;
end;

{------------------------------------------------------------------------------}
function LMDPointsTo(aValue: integer; Units: TLMDUnits): integer;
begin
  case Units of
//    unPoints: Result := LMDTwipsToPoints(aValue);
    unInches: Result := Round(LMDPointsToInches(aValue));
    unMillimeters: Result := Round(LMDPointsToMillimeters(aValue));
    else
      Result := aValue;
  end;
end;

{------------------------------------------------------------------------------}
function LMDUnitsToString(Units: TLMDUnits): string;
begin
  case Units of
    unPoints: Result := SLMD_U_POINTS;
    unInches: Result := SLMD_U_INCHES100;
    unMillimeters: Result := SLMD_U_MILLIMETERS;
    else
      Result := '';
  end;
end;

{------------------------------------------------------------------------------}
function  LMDConvertUnits(aValue: double; FromUnits, ToUnits: TLMDUnits): double;
begin
  Result := aValue;

  if  FromUnits <> ToUnits  then
    case  FromUnits of
      unPoints:
        if  ToUnits = unInches  then
          Result := LMDPointsToInches(aValue)
        else
          Result := LMDPointsToMillimeters(aValue);
      unInches:
        if  ToUnits = unPoints  then
          Result := LMDInchesToPoints(aValue)
        else
          Result := LMDInchesToMillimeters(aValue);
      unMillimeters:
        if  ToUnits = unInches  then
          Result := LMDMillimetersToInches(aValue)
        else
          Result := LMDMillimetersToPoints(aValue);
    end;
end;

end.
