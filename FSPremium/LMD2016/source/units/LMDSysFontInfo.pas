unit LMDSysFontInfo;
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

LMDSysFontInfo unit (JH)
------------------------
TLMDFontItem - collection item for holding info about a Font
TLMDFontInfo - collection of all available Fonts

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  dialogs,
  Graphics,
  LMDTypes,
  LMDSysObject,
  LMDSysBase
  ;

const
  NTMNONNEGATIVEAC=16;
  NTMPSOPENTYPE=17;
  NTMTTOPENTYPE=18;
  NTMMULTIPLEMASTER=19;
  NTMTYPE1=20;
  NTMDSIG=21;

type
  { ************************************************************************** }
  TFontType = (ftDEVICE, ftRASTER, ftTRUETYPE);
  TFontTypes = set of TFontType;

  TtmFlag = (TM_ITALIC, TM_BOLD, TM_REGULAR, TM_NONNEGATIVE_AC, TM_PS_OPENTYPE,
    TM_TT_OPENTYPE, TM_MULTIPLEMASTER, TM_TYPE1, TM_DSIG);
  TtmFlags = set of TtmFlag;

type
  TLMDFontItem = class(TLMDSysCollectionItem)
  private
    FLogItalic: Boolean;
    FLogStikeOut: Boolean;
    FLogUnderline: Boolean;
    FLogFamily: Byte;
    FLogClipPrecision: Byte;
    FLogQuality: Byte;
    FLogOutPrecision: Byte;
    FLogHeight: LongInt;
    FLogOrientation: LongInt;
    FLogEscapement: LongInt;
    FLogWidth: LongInt;
    FLogWeight: LongInt;
    FStyle: string;
    FFullName: string;
    FLogFaceName: string;
    FScript: string;
    FLogCharSet: TFontCharset;
    FLogPitch: TFontPitch;
    FFontType: TFontTypes;
    FtmItalic: Boolean;
    FtmUnderline: Boolean;
    FtmStikeOut: Boolean;
    FtmFamily: Byte;
    FtmSizeEM: LongInt;
    FtmExternalLeading: LongInt;
    FtmMaxCharWidth: LongInt;
    FtmCellHeight: LongInt;
    FtmHeight: LongInt;
    FtmAscent: LongInt;
    FtmInternalLeading: LongInt;
    FtmWeight: LongInt;
    FtmDigitizedAspectY: LongInt;
    FtmDigitizedAspectX: LongInt;
    FtmDescent: LongInt;
    FtmAveCharWidth: LongInt;
    FtmFirstChar: string;
    FtmCharSet: TFontCharset;
    FtmPitch: TFontPitch;
    FtmFlags: TtmFlags;
    FtmDefaultChar: string;
    FtmLastChar: string;
    FtmBreakChar: string;
    FtmOverhang: LongInt;
    FtmAvgWidth: LongInt;
    procedure SetDummyString(aValue: string);
    procedure SetDummyBool(const Value: Boolean);
    procedure SetDummyByte(const Value: Byte);
    procedure SetDummyCharset(const Value: TFontCharset);
    procedure SetDummyFontType(const Value: TFontTypes);
    procedure SetDummyLong(const Value: LongInt);
    procedure SetDummyPitch(const Value: TFontPitch);
    procedure SetDummyFlags(const Value: TtmFlags);

    function FontTypeToStr(aFontType : TFontTypes) : string;
    function FontCharsetToStr(aCharSet : TFontCharset) : string;
    function FontPitchToStr(aPitch : TFontPitch) : string;
    function tmFlagsToStr(atmFlags : TtmFlags) : string;

  protected
    procedure RegisterProperties; override;
    function GetDisplayName: string; override;
  public
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property FontType: TFontTypes read FFontType write SetDummyFontType;
    {See ENUMLOGFONTEX}
    property FullName: string read FFullName write SetDummyString;
    property Style: string read FStyle write SetDummyString;
    property Script: string read FScript write SetDummyString;
    {See LOGFONT}
    property LogHeight: LongInt read FLogHeight write SetDummyLong;
    property LogWidth: LongInt read FLogWidth write SetDummyLong;
    property LogEscapement: LongInt read FLogEscapement write SetDummyLong;
    property LogOrientation: LongInt read FLogOrientation write SetDummyLong;
    property LogWeight: LongInt read FLogWeight write SetDummyLong;
    property LogItalic: Boolean read FLogItalic write SetDummyBool;
    property LogUnderline: Boolean read FLogUnderline write SetDummyBool;
    property LogStikeOut: Boolean read FLogStikeOut write SetDummyBool;
    property LogCharSet: TFontCharset read FLogCharSet write SetDummyCharset;
    property LogOutPrecision: Byte read FLogOutPrecision write SetDummyByte;
    property LogClipPrecision: Byte read FLogClipPrecision write SetDummyByte;
    property LogQuality: Byte read FLogQuality write SetDummyByte;
    property LogPitch: TFontPitch read FLogPitch write SetDummyPitch;
    property LogFamily: Byte read FLogFamily write SetDummyByte;
    property LogFaceName: string read FLogFaceName write SetDummyString;
    {See NEWTEXTMETRIC}
    property tmHeight: LongInt read FtmHeight write SetDummyLong;
    property tmAscent: LongInt read FtmAscent write SetDummyLong;
    property tmDescent: LongInt read FtmDescent write SetDummyLong;
    property tmInternalLeading: LongInt read FtmInternalLeading write SetDummyLong;
    property tmExternalLeading: LongInt read FtmExternalLeading write SetDummyLong;
    property tmAveCharWidth: LongInt read FtmAveCharWidth write SetDummyLong;
    property tmMaxCharWidth: LongInt read FtmMaxCharWidth write SetDummyLong;
    property tmWeight: LongInt read FtmWeight write SetDummyLong;
    property tmOverhang: LongInt read FtmOverhang write SetDummyLong;
    property tmDigitizedAspectX: LongInt read FtmDigitizedAspectX write SetDummyLong;
    property tmDigitizedAspectY: LongInt read FtmDigitizedAspectY write SetDummyLong;
    property tmFirstChar: string read FtmFirstChar write SetDummyString;
    property tmLastChar: string read FtmLastChar write SetDummyString;
    property tmDefaultChar: string read FtmDefaultChar write SetDummyString;
    property tmBreakChar: string read FtmBreakChar write SetDummyString;
    property tmItalic: Boolean read FtmItalic write SetDummyBool;
    property tmUnderline: Boolean read FtmUnderline write SetDummyBool;
    property tmStikeOut: Boolean read FtmStikeOut write SetDummyBool;
    property tmPitch: TFontPitch read FtmPitch write SetDummyPitch;
    property tmFamily: Byte read FtmFamily write SetDummyByte;
    property tmCharSet: TFontCharset read FtmCharSet write SetDummyCharset;
    property tmFlags: TtmFlags read FtmFlags write SetDummyFlags;
    property tmSizeEM: LongInt read FtmSizeEM write SetDummyLong;
    property tmCellHeight: LongInt read FtmCellHeight write SetDummyLong;
    property tmAvgWidth: LongInt read FtmAvgWidth write SetDummyLong;
  end;

  { ************************************************************************** }
  TLMDFontsInfo = class(TLMDSysCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TLMDFontItem;
    procedure SetItem(Index: Integer; Value: TLMDFontItem);
  protected
    function GetOwner: TPersistent; override;
    public
    function Add: TLMDFontItem;
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;

    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    property Items[Index: Integer]: TLMDFontItem read GetItem write SetItem; default;
  end;

implementation
uses
  SysUtils, LMDSysConst;

const
  cpidFontType = 0;
  cpidFullName = 1;
  cpidStyle = 2;
  cpidScript = 3;
  cpidLogHeight = 4;
  cpidLogWidth = 5;
  cpidLogEscapement = 6;
  cpidLogOrientation = 7;
  cpidLogWeight = 8;
  cpidLogItalic = 9;
  cpidLogUnderline = 10;
  cpidLogStikeOut = 11;
  cpidLogCharSet = 12;
  cpidLogOutPrecision = 13;
  cpidLogClipPrecision = 14;
  cpidLogQuality = 15;
  cpidLogPitch = 16;
  cpidLogFamily = 17;
  cpidLogFaceName = 18;
  cpidtmHeight = 19;
  cpidtmAscent = 20;
  cpidtmDescent = 21;
  cpidtmInternalLeading = 22;
  cpidtmExternalLeading = 23;
  cpidtmAveCharWidth = 24;
  cpidtmMaxCharWidth = 25;
  cpidtmWeight = 26;
  cpidtmOverhang = 27;
  cpidtmDigitizedAspectX = 28;
  cpidtmDigitizedAspectY = 29;
  cpidtmFirstChar = 30;
  cpidtmLastChar = 31;
  cpidtmDefaultChar = 32;
  cpidtmBreakChar = 33;
  cpidtmItalic = 34;
  cpidtmUnderline = 35;
  cpidtmStikeOut = 36;
  cpidtmPitch = 37;
  cpidtmFamily = 38;
  cpidtmCharSet = 39;
  cpidtmFlags = 40;
  cpidtmSizeEM = 41;
  cpidtmCellHeight = 42;
  cpidtmAvgWidth = 43;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }

procedure TLMDFontItem.SetDummyBool(const Value: Boolean);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDFontItem.SetDummyByte(const Value: Byte);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDFontItem.SetDummyCharset(const Value: TFontCharset);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDFontItem.SetDummyFontType(const Value: TFontTypes);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDFontItem.SetDummyLong(const Value: LongInt);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDFontItem.SetDummyPitch(const Value: TFontPitch);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDFontItem.SetDummyString(aValue: string);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDFontItem.SetDummyFlags(const Value: TtmFlags);
begin
end;

{ -------------------------- protected --------------------------------------- }

function TLMDFontItem.GetDisplayName: string;
begin
  Result:= FFullName + ' - ' + FScript
end;

{ ---------------------------------------------------------------------------- }
function TLMDFontItem.FontTypeToStr(aFontType : TFontTypes) : string;
begin
  result := '';
  if ftDEVICE in aFontType then result := result + ' ' + sFontTypeDEVICE;
  if ftRASTER in aFontType then  result := result + ' ' +  sFontTypeRASTER;
  if ftTRUETYPE in aFontType then  result := result + ' ' +  sFontTypeTRUETYPE;

end;

{ ---------------------------------------------------------------------------- }
function TLMDFontItem.FontCharsetToStr(aCharSet : TFontCharset) : string;
begin
  case aCharSet of
    ANSI_CHARSET : result := sCharSetANSI_CHARSET;
    DEFAULT_CHARSET : result := sCharSetDEFAULT_CHARSET;
    SYMBOL_CHARSET : result := sCharSetSYMBOL_CHARSET;
    MAC_CHARSET : result := sCharSetMAC_CHARSET;
    SHIFTJIS_CHARSET : result := sCharSetSHIFTJIS_CHARSET;
    HANGEUL_CHARSET : result := sCharSetHANGEUL_CHARSET;
    JOHAB_CHARSET : result := sCharSetJOHAB_CHARSET;
    GB2312_CHARSET : result := sCharSetGB2312_CHARSET;
    CHINESEBIG5_CHARSET : result := sCharSetCHINESEBIG5_CHARSET;
    GREEK_CHARSET : result := sCharSetGREEK_CHARSET;
    TURKISH_CHARSET : result := sCharSetTURKISH_CHARSET;
    VIETNAMESE_CHARSET : result := sCharSetVIETNAMESE_CHARSET;
    HEBREW_CHARSET : result := sCharSetHEBREW_CHARSET;
    ARABIC_CHARSET : result := sCharSetARABIC_CHARSET;
    BALTIC_CHARSET : result := sCharSetBALTIC_CHARSET;
    RUSSIAN_CHARSET : result := sCharSetRUSSIAN_CHARSET;
    THAI_CHARSET : result := sCharSetTHAI_CHARSET;
    EASTEUROPE_CHARSET : result := sCharSetEASTEUROPE_CHARSET;
    OEM_CHARSET : result := sCharSetOEM_CHARSET;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFontItem.FontPitchToStr(aPitch : TFontPitch) : string;
begin
  case aPitch of
    fpDefault : result := sFontPitchDefault;
    fpVariable : result := sFontPitchVariable;
    fpFixed : result := sFontPitchFixed;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFontItem.tmFlagsToStr(atmFlags : TtmFlags) : string;
begin
  result := '';
  if TM_ITALIC in atmFlags then result := result + ' ' + sTM_ITALIC;
  if TM_BOLD in atmFlags then result := result + ' ' + sTM_BOLD;
  if TM_REGULAR in atmFlags then result := result + ' ' + sTM_REGULAR;
  if TM_NONNEGATIVE_AC in atmFlags then result := result + ' ' + sTM_NONNEGATIVE_AC;
  if TM_PS_OPENTYPE in atmFlags then result := result + ' ' + sTM_PS_OPENTYPE;
  if TM_TT_OPENTYPE in atmFlags then result := result + ' ' + sTM_TT_OPENTYPE;
  if TM_MULTIPLEMASTER in atmFlags then result := result + ' ' + sTM_MULTIPLEMASTER;
  if TM_TYPE1 in atmFlags then result := result + ' ' + sTM_TYPE1;
  if TM_DSIG in atmFlags then result := result + ' ' + sTM_DSIG;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontItem.RegisterProperties;
begin
  inherited;

  FPropertiesDesc.Add(cpidFontType, sLMDSysFontPropTitleFontType, sLMDSysFontPropDescFontType);
  FPropertiesDesc.Add(cpidFullName, sLMDSysFontPropTitleFullName, sLMDSysFontPropDescFullName);
  FPropertiesDesc.Add(cpidStyle, sLMDSysFontPropTitleStyle, sLMDSysFontPropDescStyle);
  FPropertiesDesc.Add(cpidScript, sLMDSysFontPropTitleScript, sLMDSysFontPropDescScript);
  FPropertiesDesc.Add(cpidLogHeight, sLMDSysFontPropTitleLogHeight, sLMDSysFontPropDescLogHeight);
  FPropertiesDesc.Add(cpidLogWidth, sLMDSysFontPropTitleLogWidth, sLMDSysFontPropDescLogWidth);
  FPropertiesDesc.Add(cpidLogEscapement, sLMDSysFontPropTitleLogEscapement, sLMDSysFontPropDescLogEscapement);
  FPropertiesDesc.Add(cpidLogOrientation, sLMDSysFontPropTitleLogOrientation, sLMDSysFontPropDescLogOrientation);
  FPropertiesDesc.Add(cpidLogWeight, sLMDSysFontPropTitleLogWeight, sLMDSysFontPropDescLogWeight);
  FPropertiesDesc.Add(cpidLogItalic, sLMDSysFontPropTitleLogItalic, sLMDSysFontPropDescLogItalic);
  FPropertiesDesc.Add(cpidLogUnderline, sLMDSysFontPropTitleLogUnderline, sLMDSysFontPropDescLogUnderline);
  FPropertiesDesc.Add(cpidLogStikeOut, sLMDSysFontPropTitleLogStikeOut, sLMDSysFontPropDescLogStikeOut);
  FPropertiesDesc.Add(cpidLogCharSet, sLMDSysFontPropTitleLogCharSet, sLMDSysFontPropDescLogCharSet);
  FPropertiesDesc.Add(cpidLogOutPrecision, sLMDSysFontPropTitleLogOutPrecision, sLMDSysFontPropDescLogOutPrecision);
  FPropertiesDesc.Add(cpidLogClipPrecision, sLMDSysFontPropTitleLogClipPrecision, sLMDSysFontPropDescLogClipPrecision);
  FPropertiesDesc.Add(cpidLogQuality, sLMDSysFontPropTitleLogQuality, sLMDSysFontPropDescLogQuality);
  FPropertiesDesc.Add(cpidLogPitch, sLMDSysFontPropTitleLogPitch, sLMDSysFontPropDescLogPitch);
  FPropertiesDesc.Add(cpidLogFamily, sLMDSysFontPropTitleLogFamily, sLMDSysFontPropDescLogFamily);
  FPropertiesDesc.Add(cpidLogFaceName, sLMDSysFontPropTitleLogFaceName, sLMDSysFontPropDescLogFaceName);
  FPropertiesDesc.Add(cpidtmHeight, sLMDSysFontPropTitletmHeight, sLMDSysFontPropDesctmHeight);
  FPropertiesDesc.Add(cpidtmAscent, sLMDSysFontPropTitletmAscent, sLMDSysFontPropDesctmAscent);
  FPropertiesDesc.Add(cpidtmDescent, sLMDSysFontPropTitletmDescent, sLMDSysFontPropDesctmDescent);
  FPropertiesDesc.Add(cpidtmInternalLeading, sLMDSysFontPropTitletmInternalLeading, sLMDSysFontPropDesctmInternalLeading);
  FPropertiesDesc.Add(cpidtmExternalLeading, sLMDSysFontPropTitletmExternalLeading, sLMDSysFontPropDesctmExternalLeading);
  FPropertiesDesc.Add(cpidtmAveCharWidth, sLMDSysFontPropTitletmAveCharWidth, sLMDSysFontPropDesctmAveCharWidth);
  FPropertiesDesc.Add(cpidtmMaxCharWidth, sLMDSysFontPropTitletmMaxCharWidth, sLMDSysFontPropDesctmMaxCharWidth);
  FPropertiesDesc.Add(cpidtmWeight, sLMDSysFontPropTitletmWeight, sLMDSysFontPropDesctmWeight);
  FPropertiesDesc.Add(cpidtmOverhang, sLMDSysFontPropTitletmOverhang, sLMDSysFontPropDesctmOverhang);
  FPropertiesDesc.Add(cpidtmDigitizedAspectX, sLMDSysFontPropTitletmDigitizedAspectX, sLMDSysFontPropDesctmDigitizedAspectX);
  FPropertiesDesc.Add(cpidtmDigitizedAspectY, sLMDSysFontPropTitletmDigitizedAspectY, sLMDSysFontPropDesctmDigitizedAspectY);
  FPropertiesDesc.Add(cpidtmFirstChar, sLMDSysFontPropTitletmFirstChar, sLMDSysFontPropDesctmFirstChar);
  FPropertiesDesc.Add(cpidtmLastChar, sLMDSysFontPropTitletmLastChar, sLMDSysFontPropDesctmLastChar);
  FPropertiesDesc.Add(cpidtmDefaultChar, sLMDSysFontPropTitletmDefaultChar, sLMDSysFontPropDesctmDefaultChar);
  FPropertiesDesc.Add(cpidtmBreakChar, sLMDSysFontPropTitletmDefaultChar, sLMDSysFontPropDesctmDefaultChar);
  FPropertiesDesc.Add(cpidtmItalic, sLMDSysFontPropTitletmItalic, sLMDSysFontPropDesctmItalic);
  FPropertiesDesc.Add(cpidtmUnderline, sLMDSysFontPropTitletmUnderline, sLMDSysFontPropDesctmUnderline);
  FPropertiesDesc.Add(cpidtmStikeOut, sLMDSysFontPropTitletmStikeOut, sLMDSysFontPropDesctmStikeOut);
  FPropertiesDesc.Add(cpidtmPitch, sLMDSysFontPropTitletmPitch, sLMDSysFontPropDesctmPitch);
  FPropertiesDesc.Add(cpidtmFamily, sLMDSysFontPropTitletmFamily, sLMDSysFontPropDesctmFamily);
  FPropertiesDesc.Add(cpidtmCharSet, sLMDSysFontPropTitletmCharSet, sLMDSysFontPropDesctmCharSet);
  FPropertiesDesc.Add(cpidtmFlags, sLMDSysFontPropTitletmFlags, sLMDSysFontPropDesctmFlags);
  FPropertiesDesc.Add(cpidtmSizeEM, sLMDSysFontPropTitletmSizeEM, sLMDSysFontPropDesctmSizeEM);
  FPropertiesDesc.Add(cpidtmCellHeight, sLMDSysFontPropTitletmCellHeight, sLMDSysFontPropDesctmCellHeight);
  FPropertiesDesc.Add(cpidtmAvgWidth, sLMDSysFontPropTitletmAvgWidth, sLMDSysFontPropDesctmAvgWidth);
end;

{ -------------------------- pubic ------------------------------------------- }
procedure TLMDFontItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;

  FPropertiesDesc.PropertyByID(cpidFontType).Text := FontTypeToStr(FFontType);
  FPropertiesDesc.PropertyByID(cpidLogCharSet).Text := FontCharsetToStr(FLogCharSet);
  FPropertiesDesc.PropertyByID(cpidLogPitch).Text := FontPitchToStr(FLogPitch);
  FPropertiesDesc.PropertyByID(cpidtmPitch).Text := FontPitchToStr(FtmPitch);
  FPropertiesDesc.PropertyByID(cpidtmCharSet).Text := FontCharsetToStr(FtmCharSet);
  FPropertiesDesc.PropertyByID(cpidtmFlags).Text := tmFlagsToStr(FtmFlags);

  FPropertiesDesc.PropertyByID(cpidFullName).Text := FFullName;
  FPropertiesDesc.PropertyByID(cpidStyle).Text := FStyle;
  FPropertiesDesc.PropertyByID(cpidScript).Text := FScript;
  FPropertiesDesc.PropertyByID(cpidLogHeight).Text := IntToStr(FLogHeight);
  FPropertiesDesc.PropertyByID(cpidLogWidth).Text := IntToStr(FLogWidth);
  FPropertiesDesc.PropertyByID(cpidLogEscapement).Text := IntToStr(FLogEscapement);
  FPropertiesDesc.PropertyByID(cpidLogOrientation).Text := IntToStr(FLogOrientation);
  FPropertiesDesc.PropertyByID(cpidLogWeight).Text := IntToStr(FLogWeight);
  FPropertiesDesc.PropertyByID(cpidLogItalic).Text := BoolToStr(FLogItalic);
  FPropertiesDesc.PropertyByID(cpidLogUnderline).Text := BoolToStr(FLogUnderline);
  FPropertiesDesc.PropertyByID(cpidLogStikeOut).Text := BoolToStr(FLogStikeOut);
  FPropertiesDesc.PropertyByID(cpidLogOutPrecision).Text := IntToStr(FLogOutPrecision);
  FPropertiesDesc.PropertyByID(cpidLogClipPrecision).Text := IntToStr(FLogClipPrecision);
  FPropertiesDesc.PropertyByID(cpidLogQuality).Text := IntToStr(FLogQuality);
  FPropertiesDesc.PropertyByID(cpidLogFamily).Text := IntToStr(FLogFamily);
  FPropertiesDesc.PropertyByID(cpidLogFaceName).Text := FLogFaceName;
  FPropertiesDesc.PropertyByID(cpidtmHeight).Text := IntToStr(FtmHeight);
  FPropertiesDesc.PropertyByID(cpidtmAscent).Text := IntToStr(FtmAscent);
  FPropertiesDesc.PropertyByID(cpidtmDescent).Text := IntToStr(FtmDescent);
  FPropertiesDesc.PropertyByID(cpidtmInternalLeading).Text := IntToStr(FtmInternalLeading);
  FPropertiesDesc.PropertyByID(cpidtmExternalLeading).Text := IntToStr(FtmExternalLeading);
  FPropertiesDesc.PropertyByID(cpidtmAveCharWidth).Text := IntToStr(FtmAveCharWidth);
  FPropertiesDesc.PropertyByID(cpidtmMaxCharWidth).Text := IntToStr(FtmMaxCharWidth);
  FPropertiesDesc.PropertyByID(cpidtmWeight).Text := IntToStr(FtmWeight);
  FPropertiesDesc.PropertyByID(cpidtmOverhang).Text := IntToStr(FtmOverhang);
  FPropertiesDesc.PropertyByID(cpidtmDigitizedAspectX).Text := IntToStr(FtmDigitizedAspectX);
  FPropertiesDesc.PropertyByID(cpidtmDigitizedAspectY).Text := IntToStr(FtmDigitizedAspectY);
  FPropertiesDesc.PropertyByID(cpidtmFirstChar).Text := FtmFirstChar;
  FPropertiesDesc.PropertyByID(cpidtmLastChar).Text := FtmLastChar;
  FPropertiesDesc.PropertyByID(cpidtmDefaultChar).Text := FtmDefaultChar;
  FPropertiesDesc.PropertyByID(cpidtmBreakChar).Text := FtmBreakChar;
  FPropertiesDesc.PropertyByID(cpidtmItalic).Text := BoolToStr(FtmItalic);
  FPropertiesDesc.PropertyByID(cpidtmUnderline).Text := BoolToStr(FtmUnderline);
  FPropertiesDesc.PropertyByID(cpidtmStikeOut).Text := BoolToStr(FtmStikeOut);
  FPropertiesDesc.PropertyByID(cpidtmFamily).Text := IntToStr(FtmFamily);
  FPropertiesDesc.PropertyByID(cpidtmSizeEM).Text := IntToStr(FtmSizeEM);
  FPropertiesDesc.PropertyByID(cpidtmCellHeight).Text := IntToStr(FtmCellHeight);
  FPropertiesDesc.PropertyByID(cpidtmAvgWidth).Text := IntToStr(FtmAvgWidth);

end;

{ ---------------------------------------------------------------------------- }
function TLMDFontItem.GetElementTitle : string;
begin
  result := sLMDSysFontGroupTitle + ' ['+FullName+']';
end;

{ ---------------------------------------------------------------------------- }
function TLMDFontItem.GetElementDescription : string;
begin
  result := sLMDSysFontGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFontItem.GetElementType : TLMDSysInfoType;
begin
  result := itFont;
end;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }

function TLMDFontsInfo.GetItem(Index: Integer): TLMDFontItem;
begin
  Result:= TLMDFontItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDFontsInfo.SetItem(Index: Integer; Value: TLMDFontItem);
begin
  inherited SetItem(Index, Value);
end;

{ -------------------------- protected --------------------------------------- }

function TLMDFontsInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ -------------------------- public ------------------------------------------ }

function TLMDFontsInfo.Add: TLMDFontItem;
begin
  Result:= TLMDFontItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDFontsInfo.Create(aOwner: TComponent);
begin
  inherited Create(TLMDFontItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFontsInfo.Destroy;
begin
  FOwner:= nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function EnumFontFamExProc(
  var lpelfe: TENUMLOGFONTEX;           // logical-font data
  {$ifdef LMDCOMP12}
  var lpntme: TNEWTEXTMETRICEXW;        // physical-font data
  {$else}
  var lpntme: TNEWTEXTMETRICEXA;        // physical-font data
  {$endif} 
  dwFontType: DWORD;                    // type of font
  lParam: TLMDFontsInfo                 // application-defined data
  ): LongInt; stdcall;
  begin
  Result:= 1;
  with lParam.Add do
  begin
      FFontType:= [];
      if dwFontType and DEVICE_FONTTYPE <> 0 then
        FFontType:= FFontType + [ftDEVICE];
      if dwFontType and RASTER_FONTTYPE <> 0 then
        FFontType:= FFontType + [ftRASTER];
      if dwFontType and TRUETYPE_FONTTYPE <> 0 then
        FFontType:= FFontType + [ftTRUETYPE];
      FFullName:= lpelfe.elfFullName;
      FStyle:= lpelfe.elfStyle;
      FScript:= lpelfe.elfScript;
      FLogHeight:= lpelfe.elfLogFont.lfHeight;
      FLogWidth:= lpelfe.elfLogFont.lfWidth;
      FLogEscapement:= lpelfe.elfLogFont.lfEscapement;
      FLogOrientation:= lpelfe.elfLogFont.lfOrientation;
      FLogWeight:= lpelfe.elfLogFont.lfWeight;
      FLogItalic:= LongBool(lpelfe.elfLogFont.lfItalic);
      FLogUnderline:= LongBool(lpelfe.elfLogFont.lfUnderline);
      FLogStikeOut:= LongBool(lpelfe.elfLogFont.lfStrikeOut);
      FLogCharSet:= lpelfe.elfLogFont.lfCharSet;
      FLogOutPrecision:= lpelfe.elfLogFont.lfOutPrecision;
      FLogClipPrecision:= lpelfe.elfLogFont.lfClipPrecision;
      FLogQuality:= lpelfe.elfLogFont.lfQuality;
      FLogPitch:= TFontPitch(lpelfe.elfLogFont.lfPitchAndFamily and 3);
      if lpelfe.elfLogFont.lfPitchAndFamily and 3 = FIXED_PITCH then
        FLogPitch:= fpFixed
      else if lpelfe.elfLogFont.lfPitchAndFamily and 3 = VARIABLE_PITCH then
        FLogPitch:= fpVariable
      else if lpelfe.elfLogFont.lfPitchAndFamily and 3 = DEFAULT_PITCH then
        FLogPitch:= fpDefault;
      //    FFamily
      FLogFaceName:= lpelfe.elfLogFont.lfFaceName;

      FtmHeight:= lpntme.ntmTm.tmHeight;
      FtmAscent:= lpntme.ntmTm.tmAscent;
      FtmDescent:= lpntme.ntmTm.tmDescent;
      FtmInternalLeading:= lpntme.ntmTm.tmInternalLeading;
      FtmExternalLeading:= lpntme.ntmTm.tmExternalLeading;
      FtmAveCharWidth:= lpntme.ntmTm.tmAveCharWidth;
      FtmMaxCharWidth:= lpntme.ntmTm.tmMaxCharWidth;
      FtmWeight:= lpntme.ntmTm.tmWeight;
      FtmWeight:= lpntme.ntmTm.tmOverhang;
      FtmDigitizedAspectX:= lpntme.ntmTm.tmDigitizedAspectX;
      FtmDigitizedAspectY:= lpntme.ntmTm.tmDigitizedAspectY;
      FtmFirstChar:= lpntme.ntmTm.tmFirstChar;
      FtmLastChar:= lpntme.ntmTm.tmLastChar;
      FtmDefaultChar:= lpntme.ntmTm.tmDefaultChar;
      FtmBreakChar:= lpntme.ntmTm.tmBreakChar;
      FtmItalic:= LongBool(lpntme.ntmTm.tmItalic);
      FtmUnderline:= LongBool(lpntme.ntmTm.tmUnderlined);
      FtmStikeOut:= LongBool(lpntme.ntmTm.tmStruckOut);
      if lpntme.ntmTm.tmPitchAndFamily and 3 = FIXED_PITCH then
        FtmPitch:= fpFixed
      else if lpntme.ntmTm.tmPitchAndFamily and 3 = VARIABLE_PITCH then
        FtmPitch:= fpVariable
      else if lpntme.ntmTm.tmPitchAndFamily and 3 = DEFAULT_PITCH then
        FtmPitch:= fpDefault;

      //    FtmPitch:= TFontPitch( lpntme.ntmTm.tmPitchAndFamily and 3);
      //    FtmFamily write SetDummyByte;
      FtmCharSet:= lpntme.ntmTm.tmCharSet;
      FtmFlags:= [];
      if lpntme.ntmTm.ntmFlags and NTM_ITALIC <> 0 then
        FtmFlags:= FtmFlags + [TM_ITALIC];
      if lpntme.ntmTm.ntmFlags and NTM_BOLD <> 0 then
        FtmFlags:= FtmFlags + [TM_BOLD];
      if lpntme.ntmTm.ntmFlags and NTM_REGULAR <> 0 then
        FtmFlags:= FtmFlags + [TM_REGULAR];
      if lpntme.ntmTm.ntmFlags and NTMNONNEGATIVEAC <> 0 then
        FtmFlags:= FtmFlags + [TM_NONNEGATIVE_AC];
      if lpntme.ntmTm.ntmFlags and NTMPSOPENTYPE <> 0 then
        FtmFlags:= FtmFlags + [TM_PS_OPENTYPE];
      if lpntme.ntmTm.ntmFlags and NTMMULTIPLEMASTER <> 0 then
        FtmFlags:= FtmFlags + [TM_MULTIPLEMASTER];
      if lpntme.ntmTm.ntmFlags and NTMTYPE1 <> 0 then
        FtmFlags:= FtmFlags + [TM_TYPE1];
      if lpntme.ntmTm.ntmFlags and NTMDSIG <> 0 then
        FtmFlags:= FtmFlags + [TM_DSIG];
      FtmSizeEM:= lpntme.ntmTm.ntmSizeEM;
      FtmCellHeight:= lpntme.ntmTm.ntmCellHeight;
      FtmAvgWidth:= lpntme.ntmTm.ntmAvgWidth;
      lParam.DoProgress(sLMDSysFontGroupTitle, 100, lParam.Count);
      Refresh;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontsInfo.Refresh;
var
  dc: HDC;
  lf: TLogFont;
begin
  Clear;
  DoProgress(sLMDSysFontGroupTitle, 100, 0);
  dc:= GetDC(0);
  try
    lf.lfCharSet:= DEFAULT_CHARSET;
    lf.lfFaceName:= #0;
    EnumFontFamiliesEx(dc, lf, @EnumFontFamExProc, TLMDPtrInt(Self), 0);
  finally
    ReleaseDC(0, dc);
  end;
  DoProgress('', 100, 0);
end;

{------------------------------------------------------------------------------}
function TLMDFontsInfo.GetElementTitle : string;
begin
  result := sLMDSysFontGroupTitle;
end;

{------------------------------------------------------------------------------}
function TLMDFontsInfo.GetElementDescription : string;
begin
  result := sLMDSysFontGroupDesc;
end;

{------------------------------------------------------------------------------}
function TLMDFontsInfo.GetElementType : TLMDSysInfoType;
begin
  result := itFontGroup;
end;

end.
