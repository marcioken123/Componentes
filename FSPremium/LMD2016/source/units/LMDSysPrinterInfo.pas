unit LMDSysPrinterInfo;
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

LMDSysPrinterInfo unit (JH)
---------------------------
TLMDPrinterItem - collection item for holding info about a printer
TLMDPrinterInfo - collection of all available printers

Changes
-------
Release 4.1 (October 2008)
[+] Added Available paper bins information

Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  WinSpool,
  LMDSysBase,
  LMDSysObject,
  LMDSysConst;

type
  TLMDSysPrinterDisplayInfo=(ppidDeviceName, ppidDriver, ppidComment,
                             ppidLocation, ppidPort, ppidServer, ppidDataType,
                             ppidPrintProcessor, ppidPrintProcessorParams, ppidSepFile,
                             ppidStartTime, ppidUntilTime, ppidDriverVersion, ppidDuplex,
                             ppidOrientation, ppidPaperSize, ppidQuality, ppidScale,
                             ppidCopies, ppidTrueTypeOption, ppidCollate,
                             ppidCustomXRes, ppidCustomYRes, ppidPaperLength,
                             ppidPaperWidth, ppidValidFlags, ppidMonochrome,
                             ppidAvailableBins, ppidDefaultBin);

  TLMDSysPrinterDisplayInfos=set of TLMDSysPrinterDisplayInfo;

const
  def_TLMDSysPrinterDisplayInfos=[ppidDeviceName, ppidDriver, ppidComment,
                                  ppidLocation, ppidPort, ppidServer, ppidDataType,
                                  ppidPrintProcessor, ppidPrintProcessorParams, ppidSepFile,
                                  ppidStartTime, ppidUntilTime, ppidDriverVersion, ppidDuplex,
                                  ppidOrientation, ppidPaperSize, ppidQuality, ppidScale,
                                  ppidCopies, ppidTrueTypeOption, ppidCollate,
                                  ppidCustomXRes, ppidCustomYRes, ppidPaperLength,
                                  ppidPaperWidth, ppidValidFlags, ppidMonochrome,
                                  ppidAvailableBins, ppidDefaultBin];

  LMDSysPrinterProps:array[TLMDSysPrinterDisplayInfo] of TLMDSysProperty =(
    (Name: sLMDSysPrinterPropTitleDeviceName; Description: sLMDSysPrinterPropDescDeviceName),
    (Name: sLMDSysPrinterPropTitleDriver; Description: sLMDSysPrinterPropDescDriver),
    (Name: sLMDSysPrinterPropTitleComment; Description: sLMDSysPrinterPropDescComment),
    (Name: sLMDSysPrinterPropTitleLocation; Description: sLMDSysPrinterPropDescLocation),
    (Name: sLMDSysPrinterPropTitlePort; Description: sLMDSysPrinterPropDescPort),
    (Name: sLMDSysPrinterPropTitleServer; Description: sLMDSysPrinterPropDescServer),
    (Name: sLMDSysPrinterPropTitleDataType; Description: sLMDSysPrinterPropDescDataType),
    (Name: sLMDSysPrinterPropTitlePrintProcessor; Description: sLMDSysPrinterPropDescPrintProcessor),
    (Name: sLMDSysPrinterPropTitlePrintProcessorParams; Description: sLMDSysPrinterPropDescPrintProcessorParams),
    (Name: sLMDSysPrinterPropTitleSepFile; Description: sLMDSysPrinterPropDescSepFile),
    (Name: sLMDSysPrinterPropTitleStartTime; Description: sLMDSysPrinterPropDescStartTime),
    (Name: sLMDSysPrinterPropTitleUntilTime; Description: sLMDSysPrinterPropDescUntilTime),
    (Name: sLMDSysPrinterPropTitleDriverVersion; Description: sLMDSysPrinterPropDescDriverVersion),
    (Name: sLMDSysPrinterPropTitleDuplex; Description: sLMDSysPrinterPropDescDuplex),
    (Name: sLMDSysPrinterPropTitleOrientation; Description: sLMDSysPrinterPropDescOrientation),
    (Name: sLMDSysPrinterPropTitlePaperSize; Description: sLMDSysPrinterPropDescPaperSize),
    (Name: sLMDSysPrinterPropTitleQuality; Description: sLMDSysPrinterPropDescQuality),
    (Name: sLMDSysPrinterPropTitleScale; Description: sLMDSysPrinterPropDescScale),
    (Name: sLMDSysPrinterPropTitleCopies; Description: sLMDSysPrinterPropDescCopies),
    (Name: sLMDSysPrinterPropTitleTrueTypeOption; Description: sLMDSysPrinterPropDescTrueTypeOption),
    (Name: sLMDSysPrinterPropTitleCollate; Description: sLMDSysPrinterPropDescCollate),
    (Name: sLMDSysPrinterPropTitleCustomXRes; Description: sLMDSysPrinterPropDescCustomXRes),
    (Name: sLMDSysPrinterPropTitleCustomYRes; Description: sLMDSysPrinterPropDescCustomYRes),
    (Name: sLMDSysPrinterPropTitlePaperLength; Description: sLMDSysPrinterPropDescPaperLength),
    (Name: sLMDSysPrinterPropTitlePaperWidth; Description: sLMDSysPrinterPropDescPaperWidth),
    (Name: sLMDSysPrinterPropTitleValidFlags; Description: sLMDSysPrinterPropDescValidFlags),
    (Name: sLMDSysPrinterPropTitleMonochrome; Description: sLMDSysPrinterPropDescMonochrome),
    (Name: sLMDSysPrinterPropAvailableBins; Description: sLMDSysPrinterPropDescAvailableBins),
    (Name: sLMDSysPrinterPropDefaultBin; Description: sLMDSysPrinterPropDescDefaultBin)
    );

type
  TLMDPaperSize = (psCustom,
    psLETTER,                           //      Letter, 8 1/2- by 11-inches
    psLETTERSMALL,                      //      Letter Small, 8 1/2- by 11-inches
    psTABLOID,                          //      Tabloid, 11- by 17-inches
    psLEDGER,                           //      Ledger, 17- by 11-inches
    psLEGAL,                            //      Legal, 8 1/2- by 14-inches
    psSTATEMENT,                        //      Statement, 5 1/2- by 8 1/2-inches
    psEXECUTIVE,                        //      Executive, 7 1/4- by 10 1/2-inches
    psA3,                               //      A3 sheet, 297- by 420-millimeters
    psA4,                               //      A4 Sheet, 210- by 297-millimeters
    psA4SMALL,                          //      A4 small sheet, 210- by 297-millimeters
    psA5,                               //      A5 sheet, 148- by 210-millimeters
    psB4,                               //      B4 sheet, 250- by 354-millimeters
    psB5,                               //      B5 sheet, 182- by 257-millimeter paper
    psFOLIO,                            //      Folio, 8 1/2- by 13-inch paper
    psQUARTO,                           //      Quarto, 215- by 275-millimeter paper
    ps10X14,                            //      10- by 14-inch sheet
    ps11X17,                            //      11- by 17-inch sheet
    psNOTE,                             //      Note, 8 1/2- by 11-inches
    psENV_9,                            //      #9 Envelope, 3 7/8- by 8 7/8-inches
    psENV_10,                           //      #10 Envelope, 4 1/8- by 9 1/2-inches
    psENV_11,                           //      #11 Envelope, 4 1/2- by 10 3/8-inches
    psENV_12,                           //      #12 Envelope, 4 3/4- by 11-inches
    psENV_14,                           //      #14 Envelope, 5- by 11 1/2-inches
    psCSHEET,                           //      C Sheet, 17- by 22-inches
    psDSHEET,                           //      D Sheet, 22- by 34-inches
    psESHEET,                           //      E Sheet, 34- by 44-inches
    psENV_DL,                           //      DL Envelope, 110- by 220-millimeters
    psENV_C5,                           //      C5 Envelope, 162- by 229-millimeters
    psENV_C3,                           //      C3 Envelope,  324- by 458-millimeters
    psENV_C4,                           //      C4 Envelope,  229- by 324-millimeters
    psENV_C6,                           //      C6 Envelope,  114- by 162-millimeters
    psENV_C65,                          //      C65 Envelope, 114- by 229-millimeters
    psENV_B4,                           //      B4 Envelope,  250- by 353-millimeters
    psENV_B5,                           //      B5 Envelope,  176- by 250-millimeters
    psENV_B6,                           //      B6 Envelope,  176- by 125-millimeters
    psENV_ITALY,                        //      Italy Envelope, 110- by 230-millimeters
    psENV_MONARCH,                      //      Monarch Envelope, 3 7/8- by 7 1/2-inches
    psENV_PERSONAL,                     //      6 3/4 Envelope, 3 5/8- by 6 1/2-inches
    psFANFOLD_US,                       //      US Std Fanfold, 14 7/8- by 11-inches
    psFANFOLD_STD_GERMAN,               //      German Std Fanfold, 8 1/2- by 12-inches
    psFANFOLD_LGL_GERMAN);              //      German Legal Fanfold, 8 1/2- by 13-inches

  TLMDPrinterOrientation = (poPortrait, poLandscape);
  TLMDPrintQuality = (pqHigh, pqMedium, pqLow, pqDraft, pqCustom);
  TLMDPrintDuplex = (pdSimplex, pdHorizontal, psVertical);
  TLMDPrintTTOption = (poBitmap, poDownload, poSubDev);
  TLMDPrintFlag = (pfORIENTATION,
    pfPAPERSIZE,
    pfPAPERLENGTH,
    pfPAPERWIDTH,
    pfSCALE,
    pfCOPIES,
    pfPRINTQUALITY,
    pfCOLOR,
    pfDUPLEX,
    pfYRESOLUTION,
    pfTTOPTION,
    pfCOLLATE);

  TLMDPrintFlags = set of TLMDPrintFlag;

  { ************************************************************************** }
  TLMDPrinterItem = class(TLMDSysCollectionItem)
  private
    FDriverVersion,
    FStartTime,
    FUntilTime: DWORD;
    FSepFile,
    FServerName,
    FDriverName,
    FComment,
    FLocation,
    FPort,
    FPrintProc,
    FDataType,
    FParams,
    FDefaultBin,
    FAvailableBins,
    FName: string;
    FDuplex: TLMDPrintDuplex;
    FOrientation: TLMDPrinterOrientation;
    FPaperSize: TLMDPaperSize;
    FPaperLength,
    FPaperWidth,
    FCustomXRes,
    FCustomYRes,
    FScale,
    FCopies: Smallint;
    FQuality: TLMDPrintQuality;
    FTTOption: TLMDPrintTTOption;
    FMonochrome,
     FCollate: Boolean;
    FFlags: TLMDPrintFlags;
    FPaperBins: TStringList;

    procedure SetDummyString(aValue: string);
    procedure SetDummyShort(aValue: SmallInt);
    procedure SetDummyBool(aValue: Boolean);
    //procedure SetDummyFlags(aValue: TLMDPrintFlags);
    procedure SetDummyTTOption(aValue: TLMDPrintTTOption);
    procedure SetDummyQuality(aValue: TLMDPrintQuality);
    procedure SetDummyPaperSize(aValue: TLMDPaperSize);
    procedure SetDummyOrientation(aValue: TLMDPrinterOrientation);
    procedure SetDummyDuplex(aValue: TLMDPrintDuplex);
    procedure SetDummyDWORD(aValue: DWORD);

    function DuplexToStr(aValue: TLMDPrintDuplex) : string;
    function OrientationToStr(aValue: TLMDPrinterOrientation) : string;
    function PaperSizeToStr(aValue: TLMDPaperSize) : string;
    function QualityToStr(aValue: TLMDPrintQuality) : string;
    function TrueTypeOptionToStr(aValue: TLMDPrintTTOption) : string;
    function ValidFlagsToStr(aValue: TLMDPrintFlags) : string;
  protected
    procedure RegisterProperties; override;
    function GetDisplayInfo:TLMDSysPrinterDisplayInfos;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Refresh;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType;  override;
    property PaperBins: TStringList read FPaperBins;

  published
    property DeviceName: string read FName write SetDummyString stored false;
    property Driver: string read FDriverName write SetDummyString stored false;
    property Comment: string read FComment write SetDummyString stored false;
    property Location: string read FLocation write SetDummyString stored false;
    property Port: string read FPort write SetDummyString stored false;
    property Server: string read FServerName write SetDummyString stored false;
    property DataType: string read FDataType write SetDummyString stored false;
    property PrintProcessor: string read FPrintProc write SetDummyString stored false;
    property PrintProcessorParams: string read FParams write SetDummyString stored false;
    property DefaultBin: string read FDefaultBin write SetDummyString stored false;
    property AvailableBins: string read FAvailableBins write SetDummyString stored false;
    property SepFile: string read FSepFile write SetDummyString stored false;
    property StartTime: DWORD read FStartTime write SetDummyDWORD stored false;
    property UntilTime: DWORD read FUntilTime write SetDummyDWORD stored false;
    property DriverVersion: DWORD read FDriverVersion write SetDummyDWORD stored false;
    property Duplex: TLMDPrintDuplex read FDuplex write SetDummyDuplex stored false;
    property Orientation: TLMDPrinterOrientation read FOrientation write SetDummyOrientation stored false;
    property PaperSize: TLMDPaperSize read FPaperSize write SetDummyPaperSize stored false;
    property Quality: TLMDPrintQuality read FQuality write SetDummyQuality stored false;
    property Scale: SmallInt read FScale write SetDummyShort stored false;
    property Copies: SmallInt read FCopies write SetDummyShort stored false;
    property TrueTypeOption: TLMDPrintTTOption read FTTOption write SetDummyTTOption stored false;
    property Collate: Boolean read FCollate write SetDummyBool stored false;
    property CustomXRes: SmallInt read FCustomXRes write SetDummyShort stored false;
    property CustomYRes: SmallInt read FCustomYRes write SetDummyShort stored false;
    property PaperLength: SmallInt read FPaperLength write SetDummyShort stored false;
    property PaperWidth: SmallInt read FPaperWidth write SetDummyShort stored false;
    property ValidFlags: TLMDPrintFlags read FFlags write FFlags stored false;
    property Monochrome: Boolean read FMonochrome write SetDummyBool stored false;
  end;

  { ************************************************************************** }
  TLMDPrintersInfo = class(TLMDSysCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TLMDPrinterItem;
    procedure SetItem(Index: Integer; Value: TLMDPrinterItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDPrinterItem;
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;

    procedure UpdateProperties;
    procedure Refresh;

    function GetElementTitle : string;  override;
    function GetElementDescription : string;  override;
    function GetElementType : TLMDSysInfoType;  override;

    property Items[Index: Integer]: TLMDPrinterItem read GetItem write SetItem; default;
  end;

implementation

uses
  SysUtils,   
  LMDSysPrinters, LMDSysSystemInfo, LMDSysIn;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }
procedure TLMDPrinterItem.SetDummyString(aValue: string);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPrinterItem.SetDummyShort(aValue: SmallInt);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPrinterItem.SetDummyBool(aValue: Boolean);
begin
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDPrinterItem.SetDummyFlags(aValue: TLMDPrintFlags);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPrinterItem.SetDummyTTOption(aValue: TLMDPrintTTOption);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPrinterItem.SetDummyQuality(aValue: TLMDPrintQuality);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPrinterItem.SetDummyPaperSize(aValue: TLMDPaperSize);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPrinterItem.SetDummyOrientation(aValue: TLMDPrinterOrientation);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPrinterItem.SetDummyDuplex(aValue: TLMDPrintDuplex);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPrinterItem.SetDummyDWORD(aValue: DWORD);
begin
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDPrinterItem.Create(Collection: TCollection);
begin
  inherited;
  FPaperBins := TStringList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPrinterItem.Destroy;
begin
  FPaperBins.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrinterItem.DuplexToStr(aValue: TLMDPrintDuplex) : string;
begin
  case aValue of
    pdSimplex : result := sLMDSysPrinterDuplexSimplex;
    pdHorizontal : result := sLMDSysPrinterDuplexHorizontal;
    psVertical : result := sLMDSysPrinterDuplexVertical;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrinterItem.OrientationToStr(aValue: TLMDPrinterOrientation) : string;
begin
  case aValue of
    poPortrait : result := sLMDSysPrinterOrientationPortrait;
    poLandscape : result := sLMDSysPrinterOrientationLandscape;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrinterItem.PaperSizeToStr(aValue: TLMDPaperSize) : string;
begin
  case aValue of
    psCustom : result := sLMDSysPrinterPaperSizeCustom;
    psLETTER : result := sLMDSysPrinterPaperSizeLETTER;
    psLEGAL : result := sLMDSysPrinterPaperSizeLEGAL;
    psA4 : result := sLMDSysPrinterPaperSizeA4;
    psCSHEET : result := sLMDSysPrinterPaperSizeCSHEET;
    psDSHEET : result := sLMDSysPrinterPaperSizeDSHEET;
    psESHEET : result := sLMDSysPrinterPaperSizeESHEET;
    psLETTERSMALL : result := sLMDSysPrinterPaperSizeLETTERSMALL;
    psTABLOID : result := sLMDSysPrinterPaperSizeTABLOID;
    psLEDGER : result := sLMDSysPrinterPaperSizeLEDGER;
    psSTATEMENT : result := sLMDSysPrinterPaperSizeSTATEMENT;
    psEXECUTIVE : result := sLMDSysPrinterPaperSizeEXECUTIVE;
    psA3 : result := sLMDSysPrinterPaperSizeA3;
    psA4SMALL : result := sLMDSysPrinterPaperSizeA4SMALL;
    psA5 : result := sLMDSysPrinterPaperSizeA5;
    psB4 : result := sLMDSysPrinterPaperSizeB4;
    psB5 : result := sLMDSysPrinterPaperSizeB5;
    psFOLIO : result := sLMDSysPrinterPaperSizeFOLIO;
    psQUARTO : result := sLMDSysPrinterPaperSizeQUARTO;
    ps10X14 : result := sLMDSysPrinterPaperSize10X14;
    ps11X17 : result := sLMDSysPrinterPaperSize11X17;
    psNOTE : result := sLMDSysPrinterPaperSizeNOTE;
    psENV_9 : result := sLMDSysPrinterPaperSizeENV_9;
    psENV_10 : result := sLMDSysPrinterPaperSizeENV_10;
    psENV_11 : result := sLMDSysPrinterPaperSizeENV_11;
    psENV_12 : result := sLMDSysPrinterPaperSizeENV_12;
    psENV_14 : result := sLMDSysPrinterPaperSizeENV_14;
    psENV_DL : result := sLMDSysPrinterPaperSizeENV_DL;
    psENV_C5 : result := sLMDSysPrinterPaperSizeENV_C5;
    psENV_C3 : result := sLMDSysPrinterPaperSizeENV_C3;
    psENV_C4 : result := sLMDSysPrinterPaperSizeENV_C4;
    psENV_C6 : result := sLMDSysPrinterPaperSizeENV_C6;
    psENV_C65 : result := sLMDSysPrinterPaperSizeENV_C65;
    psENV_B4 : result := sLMDSysPrinterPaperSizeENV_B4;
    psENV_B5 : result := sLMDSysPrinterPaperSizeENV_B5;
    psENV_B6 : result := sLMDSysPrinterPaperSizeENV_B6;
    psENV_ITALY : result := sLMDSysPrinterPaperSizeENV_ITALY;
    psENV_MONARCH : result := sLMDSysPrinterPaperSizeENV_MONARCH;
    psENV_PERSONAL : result := sLMDSysPrinterPaperSizeENV_PERSONAL;
    psFANFOLD_US : result := sLMDSysPrinterPaperSizeFANFOLD_US;
    psFANFOLD_STD_GERMAN : result := sLMDSysPrinterPaperSizeFANFOLD_STD_GERMAN;
    psFANFOLD_LGL_GERMAN : result := sLMDSysPrinterPaperSizeFANFOLD_LGL_GERMAN;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrinterItem.QualityToStr(aValue: TLMDPrintQuality) : string;
begin
  case aValue of
    pqHigh : result := sLMDSysPrinterQualityHigh;
    pqMedium : result := sLMDSysPrinterQualityMedium;
    pqLow : result := sLMDSysPrinterQualityLow;
    pqDraft : result := sLMDSysPrinterQualityDraft;
    pqCustom : result := sLMDSysPrinterQualityCustom;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrinterItem.TrueTypeOptionToStr(aValue: TLMDPrintTTOption) : string;
begin
  case aValue of
    poBitmap : result := sLMDSysPrinterOptionBitmap;
    poDownload : result := sLMDSysPrinterOptionDownload;
    poSubDev : result := sLMDSysPrinterOptionSubDev;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrinterItem.ValidFlagsToStr(aValue: TLMDPrintFlags) : string;

  procedure AddOption(const aValue:String);
  begin
    if result<>'' then
      result:=result + ' | '+aValue
    else
      result:=aValue;
  end;
begin
  result := '';
  if pfORIENTATION in aValue then AddOption(sLMDSysPrinterValidFlagORIENTATION);
  if pfPAPERSIZE in aValue then AddOption(sLMDSysPrinterValidFlagPAPERSIZE);
  if pfPAPERLENGTH in aValue then AddOption(sLMDSysPrinterValidFlagPAPERLENGTH);
  if pfPAPERWIDTH in aValue then AddOption(sLMDSysPrinterValidFlagPAPERWIDTH);
  if pfSCALE in aValue then AddOption(sLMDSysPrinterValidFlagSCALE);
  if pfCOPIES in aValue then AddOption(sLMDSysPrinterValidFlagCOPIES);
  if pfPRINTQUALITY in aValue then AddOption(sLMDSysPrinterValidFlagPRINTQUALITY);
  if pfCOLOR in aValue then AddOption(sLMDSysPrinterValidFlagCOLOR);
  if pfDUPLEX in aValue then AddOption(sLMDSysPrinterValidFlagDUPLEX);
  if pfYRESOLUTION in aValue then AddOption(sLMDSysPrinterValidFlagYRESOLUTION);
  if pfTTOPTION in aValue then AddOption(sLMDSysPrinterValidFlagTTOPTION);
  if pfCOLLATE in aValue then AddOption(sLMDSysPrinterValidFlagCOLLATE);
  result:='['+result+']';
end;

{ -------------------------- protected --------------------------------------- }
procedure TLMDPrinterItem.RegisterProperties;
var
  tmp:TLMDSysPrinterDisplayInfos;
  i:TLMDSysPrinterDisplayInfo;
begin
  tmp:=GetDisplayInfo;
  FPropertiesDesc.Clear;
  for i:=Low(TLMDSysPrinterDisplayInfo) to High(TLMDSysPrinterDisplayInfo) do
    if i in tmp then
      FPropertiesDesc.Add(Ord(i), LMDSysPrinterProps[i].Name, LMDSysPrinterProps[i].Description);
end;

{ -------------------------- public ------------------------------------------ }
procedure TLMDPrinterItem.Refresh;
var
 i:TLMDSysPrinterDisplayInfo;
 tmp:TLMDSysPrinterDisplayInfos;
begin
  tmp:=GetDisplayInfo;
  FPropertiesDesc.InvalidateProperties;
  for i:=Low(TLMDSysPrinterDisplayInfo) to High(TLMDSysPrinterDisplayInfo) do
    if i in tmp then
      with FPropertiesDesc.PropertyByID(Ord(i)) do
        case i of
          ppidDeviceName: Text := FName;
          ppidDriver: Text :=  FDriverName;
          ppidComment: Text := FComment;
          ppidLocation: Text := FLocation;
          ppidPort: Text :=  FPort;
          ppidServer: Text :=  FServerName;
          ppidDataType: Text :=  FDataType;
          ppidPrintProcessor: Text := FPrintProc;
          ppidPrintProcessorParams: Text := FParams;
          ppidSepFile: Text := FSepFile;
          ppidStartTime: Text := IntToStr(FStartTime);
          ppidUntilTime: Text :=  IntToStr(FUntilTime);
          ppidDriverVersion: Text := IntToStr(FDriverVersion);
          ppidDuplex: Text := DuplexToStr(FDuplex);
          ppidOrientation: Text := OrientationToStr(FOrientation);
          ppidPaperSize: Text := PaperSizeToStr(FPaperSize);
          ppidQuality: Text := QualityToStr(FQuality);
          ppidScale: Text := IntToStr(FScale);
          ppidCopies: Text :=  IntToStr(FCopies);
          ppidTrueTypeOption: Text := TrueTypeOptionToStr(FTTOption);
          ppidCollate: Text := BoolToStr(FCollate);
          ppidCustomXRes: Text :=  IntToStr(FCustomXRes);
          ppidCustomYRes: Text :=  IntToStr(FCustomYRes);
          ppidPaperLength: Text := IntToStr(FPaperLength);
          ppidPaperWidth: Text :=  IntToStr(FPaperWidth);
          ppidValidFlags: Text :=  ValidFlagsToStr(FFlags);
          ppidMonochrome: Text :=  BoolToStr(FMonochrome);
          ppidDefaultBin: Text := FDefaultBin;
          ppidAvailableBins: Text := FAvailableBins;
        end;
end;

{------------------------------------------------------------------------------}
function TLMDPrinterItem.GetElementTitle : string;
begin
  result := FName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrinterItem.GetElementDescription : string;
begin
  result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrinterItem.GetElementType : TLMDSysInfoType;
begin
  result := itPrinter;
end;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }

function TLMDPrintersInfo.GetItem(Index: Integer): TLMDPrinterItem;
begin
  Result:= TLMDPrinterItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPrintersInfo.SetItem(Index: Integer; Value: TLMDPrinterItem);
begin
  inherited SetItem(Index, Value);
end;

{ -------------------------- protected --------------------------------------- }
function TLMDPrintersInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintersInfo.UpdateProperties;
var
  i:Integer;
begin
  for i:=0 to Count-1 do
    Items[i].RegisterProperties;
end;

{ -------------------------- public ------------------------------------------ }
function TLMDPrintersInfo.Add: TLMDPrinterItem;
begin
  Result:= TLMDPrinterItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDPrintersInfo.Create(aOwner: TComponent);
begin
  inherited Create(TLMDPrinterItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPrintersInfo.Destroy;
begin
  FOwner:= nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPrintersInfo.Refresh;
type
  TLMDBinName = array[0..23] of char;
  TLMDBinNames = array[0..(High(Integer) div SizeOf(TLMDBinName)) - 1] of TLMDBinName;
  PLMDBinNames = ^TLMDBinNames;
  TLMDBins = array[0..(High(Integer) div SizeOf(Word)) - 1] of word;
  PLMDBins = ^TLMDBins;

var
  Buffer, PrinterInfo: PAnsiChar;

  Flags, Count, NumInfo: DWORD;
  I: Integer;
  Level: Byte;
  LBinsCount: Integer;
  LBinNamesCount: integer;
  LBinNames: PLMDBinNames;
  LBins: PLMDBins;
  j: Integer;
  LIndex: Integer;
  //dm: TDEVMODE;
begin
  Clear;
  DoProgress(sLMDSysPrinterObjectsTitle, 100, 10);

  try
    if LMDSIWindowsNT then
      begin
        Flags:= PRINTER_ENUM_CONNECTIONS or PRINTER_ENUM_LOCAL;
        //Level:= 4;
      end
    else
      begin
        Flags:= PRINTER_ENUM_LOCAL;
        //Level:= 5;
      end;

    Level:= 2;

  DoProgress(sLMDSysPrinterObjectsTitle, 100, 30);
    Count:= 0;
    EnumPrinters(Flags, nil, Level, nil, 0, Count, NumInfo);
    if Count = 0 then Exit;

    GetMem(Buffer, Count);
    try
      if not EnumPrinters(Flags, nil, Level, PByte(Buffer), Count, Count, NumInfo) then
        Exit;
      PrinterInfo := Buffer;
      for I:= 0 to NumInfo - 1 do
        with Add do
          begin
            with PPrinterInfo2(PrinterInfo)^ do
            begin
                FName:= pPrinterName;
                FPort:= pPortName;
                FSepFile:= pSepFile;
                FServerName:= pServerName;
                FDriverName:= pDriverName;
                FLocation:= pLocation;
                FComment:= pComment;
                FPrintProc:= pPrintProcessor;
                FDataType:= pDatatype;
                FParams:= pParameters;
                FStartTime:= StartTime;
                FUntilTime:= UntilTime;
                // Pare bins
                LBinNamesCount := DeviceCapabilities(pPrinterName, pPortName, DC_BINNAMES, nil, nil);
                LBinsCount := DeviceCapabilities(pPrinterName, pPortName, DC_BINS, nil, nil);

                if (LBinsCount = LBinNamesCount) and (LBinsCount > 0)  then
                begin
                  GetMem(LBinNames, LBinNamesCount * SizeOf(TLMDBinName));
                  try
                    GetMem(LBins, LBinsCount * SizeOf(Word));
                    try
                      DeviceCapabilities(pPrinterName, pPortName, DC_BINNAMES, PChar(LBinNames), nil);
                      DeviceCapabilities(pPrinterName, pPortName, DC_BINS, PChar(LBins), nil);

                      FPaperBins.Clear;
                      for j := 0 to LBinsCount - 1 do
                        FPaperBins.AddObject(LBinNames^[j], TObject(LBins^[j]));

                      FAvailableBins := FPaperBins.Text;
                    finally
                      FreeMem(LBins);
                    end;
                  finally
                    FreeMem(LBinNames);
                  end;
                end;

                {                                       TPrinter DEVMODE }
                with pDevMode^ do
                begin
                    FDriverVersion:= dmDriverVersion;
                    FDuplex:= TLMDPrintDuplex(dmDuplex);
                    LIndex := FPaperBins.IndexOfObject(TObject(dmDefaultSource));
                    if LIndex > -1 then
                      FDefaultBin := FPaperBins.Strings[LIndex];
                    FOrientation:= TLMDPrinterOrientation(dmOrientation - 1);
                    if (dmPaperSize = 0) or (dmPaperSize>Ord(High(TLMDPaperSize))) then
                      FPaperSize:= psCustom
                    else
                      FPaperSize:= TLMDPaperSize(dmPaperSize);
                    FScale:= dmScale;
                    FCopies:= dmCopies;
                    case dmPrintQuality of
                      Short(DMRES_HIGH): FQuality:= pqHigh;
                      Short(DMRES_MEDIUM): FQuality:= pqMedium;
                      Short(DMRES_LOW): FQuality:= pqLow;
                      Short(DMRES_DRAFT): FQuality:= pqDraft;
                    else
                      begin
                        FQuality:= pqCustom;
                        FCustomXRes:= dmPrintQuality;
                      end;
                    end;
                    FPaperLength:= dmPaperLength;
                    FPaperWidth:= dmPaperWidth;
                    FCustomYRes:= dmYResolution;
                    FTTOption:= TLMDPrintTTOption(dmTTOption);
                    FCollate:= Boolean(dmCollate);
                    FMonochrome:= dmColor = DMCOLOR_MONOCHROME;

                    FFlags:= [];
                    if dmFields and DM_ORIENTATION = DM_ORIENTATION then
                      Include(FFlags, pfORIENTATION);
                    if dmFields and DM_PAPERSIZE = DM_PAPERSIZE then
                      Include(FFlags, pfPAPERSIZE);
                    if dmFields and DM_PAPERLENGTH = DM_PAPERLENGTH then
                      Include(FFlags, pfPAPERLENGTH);
                    if dmFields and DM_PAPERWIDTH = DM_PAPERWIDTH then
                      Include(FFlags, pfPAPERWIDTH);
                    if dmFields and DM_SCALE = DM_SCALE then
                      Include(FFlags, pfSCALE);
                    if dmFields and DM_COPIES = DM_COPIES then
                      Include(FFlags, pfCOPIES);
                    if dmFields and DM_PRINTQUALITY = DM_PRINTQUALITY then
                      Include(FFlags, pfPRINTQUALITY);
                    if dmFields and DM_COLOR = DM_COLOR then
                      Include(FFlags, pfCOLOR);
                    if dmFields and DM_DUPLEX = DM_DUPLEX then
                      Include(FFlags, pfDUPLEX);
                    if dmFields and DM_YRESOLUTION = DM_YRESOLUTION then
                      Include(FFlags, pfYRESOLUTION);
                    if dmFields and DM_TTOPTION = DM_TTOPTION then
                      Include(FFlags, pfTTOPTION);
                    if dmFields and DM_COLLATE = DM_COLLATE then
                      Include(FFlags, pfCOLLATE);
                  end;
                Refresh;
                inc(PrinterInfo, SizeOf(TPrinterInfo2));
                end;
DoProgress(sLMDSysPrinterObjectsTitle, 100, round(30+i*70/NumInfo));
          end;
    finally
      FreeMem(Buffer, Count);
      end;
  except
    raise;
  end;

  DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrintersInfo.GetElementTitle : string;
begin
  result := sLMDSysPrinterObjectsTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrintersInfo.GetElementDescription : string;
begin
  result := sLMDSysPrinterObjectsDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPrintersInfo.GetElementType : TLMDSysInfoType;
begin
  result := itPrinterGroup;
end;

{------------------------------------------------------------------------------}
function TLMDPrinterItem.GetDisplayInfo: TLMDSysPrinterDisplayInfos;
begin
  result:=[];
  with TLMDPrintersInfo(Collection) do
    if FOwner=nil then
      result:=def_TLMDSysPrinterDisplayInfos
    else
      if FOwner is TLMDSysPrinters then
        result:=TLMDSysPrinters(FOwner).DisplayInfo
      else
        if FOwner is TLMDSysSystemInfo then
          result:=TLMDSysSystemInfo(FOwner).PrintersDisplayInfo
end;

end.
