unit LMDHTMLParser;
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

LMDHTMLParser unit (VO)
-----------------------

HTML parser

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Graphics,
  LMDParser, LMDExtParser, LMDLex, LMDHTMLLex, LMDText, LMDTable, LMDEmbdControl,
  LMDTree, LMDHiddenText, lmddtd, LMDHTMLSTYLE, LMDEntryPoint, LMDRule;

type

  { ******************************* TLMDHTMLParser **************************** }
  TLMDHTMLParser = class(TLMDExtParser)
  private
    FDTD : TLMDDTD;
    FStyle : TLMDHTMLStyle;
    FHiddenModeRef : LongInt;
    function StrToColor(const aColor: string): TColor;
    function StrToFontSize(const aValue : string): string;
    function ReplaceSpecialChars(const aText: string): string;
    //function ParentAlign(aParsedText : TLMDParsedTextList): string;
    procedure StoreHiddenText(aParsedText : TLMDParsedTextList);
    procedure ChopAndNil(var aParsedText : TLMDParsedTextList);
    procedure OpenHiddenArea;
    procedure CloseHiddenArea;
    function  IsPCDATA : boolean;
    procedure Process_Hidden(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessDOCTYPE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTITLE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessBASE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessPCDATA(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessHTML(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessHEAD(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessBODY(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessSCRIPT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessSTYLE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessMETA(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessLINK(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessOBJECT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessINS(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessDEL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessH_n(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage;
                FontSize: integer);
    procedure ProcessH1(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessH2(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessH3(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessH4(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessH5(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessH6(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessUL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessOL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessLI(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessLI_1(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessPRE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessNOSCRIPT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessHR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessFontStyle(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage;
                FontStyle: TFontStyle);
    procedure ProcessI(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessB(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessBIG(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessSMALL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessSUNKEN(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessRAISED(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessPCOLOR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessFONT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessEM(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessSTRONG(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessDFN(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessCODE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessSAMP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessKBD(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessVAR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessCITE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessABBR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessACRONYM(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessADDRESS(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessBLOCKQUOTE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessPARAM(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessDL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessDT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessDIV(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessCENTER(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessIMG(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessSUB(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessSUP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessA(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessBR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessSPAN(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessQ(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessMAP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessAREA(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessFORM(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessINPUT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTEXTAREA(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessLABEL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessBUTTON(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessSELECT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessOPTGROUP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessOPTION(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessFIELDSET(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTABLE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessCAPTION(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTHEAD(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTFOOT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTBODY(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessCOLGROUP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessCOL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTH(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTD(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessCONTROL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessTREE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessITEM(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessREPEAT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessDD(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessBDO(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessLEGEND(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessPLAIN(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessS(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessU(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessBASEFONT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ProcessCLOSEBASEFONT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure ExceptionHandler(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    //procedure NullExceptionHandler(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure Nothing(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure EH_BODY(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
    procedure FillDTD(aDTD : TLMDDTD);
    function  CheckTokenAsTagAttr(const aName: string; var aRes: string): Boolean;
  protected
    function GetLexClass: TLMDLexClass; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Parse(aStream: TStream;
      aGraphicErrorEvent: TLMDGraphicErrorEvent;
      aGetVariable: TLMDGetVariableEvent;
      aEmbdControlCreated : TLMDEmbdControlEvent;
      aRepeatEvent : TLMDRepeatEvent): TLMDParsedTextList; override;
  end;

implementation

uses
  SysUtils, Dialogs, LMDStrings;

function  i_Pos(const Substr, Str: string; var i: integer): Boolean;
begin
  i := Pos(Substr, Str);
  Result := (i > 0);
end;

function HTMLToWidth(value: string): integer;
const
  cDigits = ['0'..'9'];
var
  I: integer;
  lDigit: string;
begin
  Result:= -100; // 100%
  lDigit:= '';
  if length(value) = 0 then
    exit;

  for I:= 1 to length(value) do
    if AnsiChar(value[I]) in cDigits then
      lDigit:= lDigit + value[I]
    else
      if value[I] = '%' then
        begin
          Result:= StrToInt(lDigit) * (-1);
          if Result < -100 then
            Result:= -100;
          if Result = 0 then
            Result:= -1;
          exit;
        end
      else
        if value[I] = '*' then
          begin
            Result:= -100 - StrToInt(lDigit);
            exit;
          end
        else
          exit;
  if length(lDigit) > 0 then
    Result:= StrToInt(lDigit);
end;

{-----------------------------------------------------------------------------}

function RGBToColor(aColor: string): TColor;
var
  R, G, B: Byte;
begin
  Result:= clDefault;
  if aColor <> '' then
    if aColor[1] = '#' then
      begin
        aColor[1]:= '$';
        Result:= StrToInt(aColor);
        G:= Result and $0000FF;
        B:= (Result and $00FF00) shr 8;
        R:= (Result and $FF0000) shr 16;
        Result:= G shl 16 + B shl 8 + R;
      end
    else
      try
        Result:= StringToColor('cl' + aColor)
      except
      end
end;

{ ******************************* TLMDHTMLParser **************************** }
{-----------------------------------------------------------------------------}

function TLMDHTMLParser.StrToColor(const aColor: string): TColor;
var
  R, G, B: Byte;
begin
  Result:= clDefault;
  if aColor <> '' then
    if aColor[1] = '#' then
      begin
//        aColor[1]:= '$';
        Result:= StrToInt('$' + Copy(aColor, 2, MAXINT));
        G:= Result and $0000FF;
        B:= (Result and $00FF00) shr 8;
        R:= (Result and $FF0000) shr 16;
        Result:= G shl 16 + B shl 8 + R;
      end
    else
      try
        Result:= StringToColor('cl' + aColor)
      except
      end
end;

{------------------------------------------------------------------------------}

function TLMDHTMLParser.StrToFontSize(const aValue : string): string;
const
  FontSizes: array[1..7] of Byte = (10, 12, 14, 16, 18, 24, 28);
var
  lMode         : byte;
  Code          : Integer;
  lPrevSize     : integer;
  lNewSize      : integer;
  I             : integer;
  sValue        : string;
begin
  lMode := 0;

  if IsVariable(aValue) then
    sValue := GetVariable(self, aValue, FGetVariable)
  else
    sValue := aValue;

  if sValue[1] = '+' then
    begin
      lMode := 1;
      sValue := Copy(sValue, 2, Length(sValue)-1);
    end;

  if sValue[1] = '-' then
    begin
      lMode := 2;
      sValue := Copy(sValue, 2, Length(sValue)-1);
    end;

  if IsVariable(sValue) then
    sValue := GetVariable(self, sValue, FGetVariable);

  lPrevSize := 1;
  for I := 1 to 7 do
    if IntToStr(FontSizes[I]) = FStyle.BaseFontSize then
      begin
        lPrevSize := I;
        break;
      end;

  Val(sValue, lNewSize, Code);
  if Code <> 0 then
    lNewSize := 0;

  case lMode of
    1: lNewSize := lNewSize + lPrevSize;
    2: lNewSize := lPrevSize - lNewSize;
  end;

  if lNewSize < 1 then lNewSize := 1;
  if lNewSize > 7 then lNewSize := 7;

  Result := IntToStr(FontSizes[lNewSize]);
end;

{------------------------------------------------------------------------------}

function TLMDHTMLParser.ReplaceSpecialChars(const aText: string): string;
const
  spCharsCount = 97;
  spChars: array[0..spCharsCount - 1] of
  record
    spChar: string;
    spRepl: string;
  end =
  ((spChar: 'nbsp'; spRepl: ' '),
    (spChar: 'quot'; spRepl: '"'),
    (spChar: 'amp'; spRepl: '&'),
    (spChar: 'lt'; spRepl: '<'),
    (spChar: 'gt'; spRepl: '>'),
    (spChar: 'iexcl'; spRepl: #161),
    (spChar: 'cent'; spRepl: #162),
    (spChar: 'pound'; spRepl: #163),
    (spChar: 'curren'; spRepl: #164),
    (spChar: 'yen'; spRepl: #165),
    (spChar: 'brvbar'; spRepl: #166),
    (spChar: 'sect'; spRepl: #167),
    (spChar: 'uml'; spRepl: #168),
    (spChar: 'copy'; spRepl: #169),
    (spChar: 'ordf'; spRepl: #170),
    (spChar: 'laquo'; spRepl: #171),
    (spChar: 'not'; spRepl: #172),
    (spChar: 'shy'; spRepl: #173),
    (spChar: 'reg'; spRepl: #174),
    (spChar: 'macr'; spRepl: #175),
    (spChar: 'deg'; spRepl: #176),
    (spChar: 'plusmn'; spRepl: #177),
    (spChar: 'sup2'; spRepl: #178),
    (spChar: 'sup3'; spRepl: #179),
    (spChar: 'acute'; spRepl: #180),
    (spChar: 'micro'; spRepl: #181),
    (spChar: 'para'; spRepl: #182),
    (spChar: 'uml'; spRepl: #183),
    (spChar: 'middot'; spRepl: #184),
    (spChar: 'cedil'; spRepl: #185),
    (spChar: 'sup1'; spRepl: #186),
    (spChar: 'ordm'; spRepl: #187),
    (spChar: 'raquo'; spRepl: #188),
    (spChar: 'frac14'; spRepl: #189),
    (spChar: 'frac12'; spRepl: #190),
    (spChar: 'frac34'; spRepl: #191),
    (spChar: 'iquest'; spRepl: #192),
    (spChar: 'Agrave'; spRepl: #193),
    (spChar: 'Aacute'; spRepl: #194),
    (spChar: 'Acirc'; spRepl: #195),
    (spChar: 'Atilde'; spRepl: #196),
    (spChar: 'Auml'; spRepl: #197),
    (spChar: 'Aring'; spRepl: #198),
    (spChar: 'AElig'; spRepl: #199),
    (spChar: 'Ccedil'; spRepl: #200),
    (spChar: 'Egrave'; spRepl: #201),
    (spChar: 'Eacute'; spRepl: #202),
    (spChar: 'Ecirc'; spRepl: #203),
    (spChar: 'Euml'; spRepl: #204),
    (spChar: 'Igrave'; spRepl: #205),
    (spChar: 'Iacute'; spRepl: #206),
    (spChar: 'Icirc'; spRepl: #207),
    (spChar: 'Iuml'; spRepl: #208),
    (spChar: 'ETH'; spRepl: #209),
    (spChar: 'Ntilde'; spRepl: #210),
    (spChar: 'Ograve'; spRepl: #211),
    (spChar: 'Oacute'; spRepl: #212),
    (spChar: 'Ocirc'; spRepl: #213),
    (spChar: 'Otilde'; spRepl: #214),
    (spChar: 'Ouml'; spRepl: #215),
    (spChar: 'times'; spRepl: #216),
    (spChar: 'Oslash'; spRepl: #217),
    (spChar: 'Ugrave'; spRepl: #218),
    (spChar: 'Uacute'; spRepl: #219),
    (spChar: 'Ucirc'; spRepl: #220),
    (spChar: 'Uuml'; spRepl: #221),
    (spChar: 'Yacute'; spRepl: #222),
    (spChar: 'THORN'; spRepl: #223),
    (spChar: 'szlig'; spRepl: #224),
    (spChar: 'agrave'; spRepl: #225),
    (spChar: 'aacute'; spRepl: #226),
    (spChar: 'acirc'; spRepl: #227),
    (spChar: 'atilde'; spRepl: #228),
    (spChar: 'auml'; spRepl: #229),
    (spChar: 'aring'; spRepl: #230),
    (spChar: 'aelig'; spRepl: #231),
    (spChar: 'ccedil'; spRepl: #232),
    (spChar: 'egrave'; spRepl: #233),
    (spChar: 'eacute'; spRepl: #234),
    (spChar: 'ecirc'; spRepl: #235),
    (spChar: 'euml'; spRepl: #236),
    (spChar: 'igrave'; spRepl: #237),
    (spChar: 'iacute'; spRepl: #238),
    (spChar: 'icirc'; spRepl: #239),
    (spChar: 'iuml'; spRepl: #240),
    (spChar: 'eth'; spRepl: #241),
    (spChar: 'ntilde'; spRepl: #242),
    (spChar: 'ograve'; spRepl: #243),
    (spChar: 'oacute'; spRepl: #244),
    (spChar: 'ocirc'; spRepl: #245),
    (spChar: 'otilde'; spRepl: #246),
    (spChar: 'ouml'; spRepl: #247),
    (spChar: 'divide'; spRepl: #248),
    (spChar: 'oslash'; spRepl: #249),
    (spChar: 'ugrave'; spRepl: #250),
    (spChar: 'uacute'; spRepl: #251),
    (spChar: 'euro'; spRepl: #8364));

var
  I: LongInt;
  P: LongInt;
  S: string;
  tmpStr: string;
begin
  Result:= aText;
  if  Pos('&', Result) > 0  then
  begin
    for I:= 0 to spCharsCount - 1 do
      begin
        repeat
          P:= Pos('&' + spChars[I].spChar + ';', Result);
          if P <> 0 then
            begin
              S:= Copy(Result, 1, P - 1) +
                spChars[I].spRepl +
                Copy(Result, P + length(spChars[I].spChar) + 2,
                length(Result) - (P + length(spChars[I].spChar) + 2) + 1);
              Result:= S;
            end;
        until P = 0;
      end;

    repeat
      P := Pos('&#', Result);
      if P <> 0 then
        begin
          I := P;
          while (Result[I] <> ';') and (I < Length(Result)) do Inc(I);
          S:= Copy(Result, 1, P - 1) + ' ';
          try
            tmpStr := Copy(Result, P+2, I - P - 2);
            if (length(tmpStr) > 0) and (LMDAnsiCharInSet(tmpStr[1], ['x', 'X'])) then
            tmpStr[1] := '$';
            S := S + Chr(StrToInt(tmpStr));
          except end;
          S:= S + Copy(Result, I+1, Length(Result)-I);
          Result := S;
        end;
    until P = 0;
  end;
end;

{------------------------------------------------------------------------------}
{function TLMDHTMLParser.ParentAlign(aParsedText : TLMDParsedTextList): string;
begin
  Result := '';
  if not Assigned(aParsedText) then Exit;
  if aParsedText is TLMDParagraph then Result := TLMDParagraph(aParsedText).AlignTxt;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.StoreHiddenText(aParsedText : TLMDParsedTextList);
var
  S : string;
  I : LongInt;
begin
  if not ValidToken then Exit;
  case Token.TokenType of
    ttTag  : begin
      S := '<' + TokenText;
      for I := 0 to TokenAsTag.Attributes.count-1 do
        S := S + ' ' + TokenAsTag.Attributes[I];
      S := S +' >';
    end;
    ttText : S := TokenText;
  end;
  aParsedText.AddSubItem(TLMDHiddenText.Create(aParsedText, S));
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ChopAndNil(var aParsedText : TLMDParsedTextList);
begin
  if Assigned(aParsedText) then begin
    aParsedText.Chop;
    aParsedText := nil;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.OpenHiddenArea;
begin
  inc(FHiddenModeRef);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.CloseHiddenArea;
begin
  Dec(FHiddenModeRef);
end;

{------------------------------------------------------------------------------}

function TLMDHTMLParser.IsPCDATA : boolean;
begin
  Result := TokenIsText;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessDOCTYPE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessPCDATA(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
  procedure AddText(const Txt: string);
  var
    aText : TLMDText;
  begin
    aText := TLMDText.Create(Txt, aParsedText);
    aParsedText.AddSubitem(aText);
    FStyle.SetStyle(aText);
  end;

const
  BlankSymbols: TSysCharSet = [' ', #9, #13, #10];
var
//  aText : TLMDText;
  lText : string;
  lWord : string;
  I     : LongInt;
  Ln    : integer;
  sW    : integer;
  HasBlank: Boolean;
begin
  if aStage <> esData then Exit;
  if FHiddenModeRef = 0 then begin
    lText := ReplaceSpecialChars(TokenText);
    I := 1;
    Ln := Length(lText);
    while I <= Ln do
    begin
      HasBlank := False;

      //  Skip Blank
      while (I <= Ln) and (AnsiChar(lText[I]) in BlankSymbols) do
      begin
        HasBlank := True;
        inc(I);
      end;

      if  (i <= Ln)  then
      begin
        if  HasBlank  then
          AddText(' ');

        sW := I;

        //  Skip Word
        while (I <= Ln) and not (AnsiChar(lText[I]) in BlankSymbols) do inc(I);

        lWord := Copy(lText, sW, i - sW);

        if Length(lWord) > 0 then
          AddText(lWord);
      end
      else
      if  HasBlank  then
        AddText(' ');
    end;
  end
  else StoreHiddenText(aParsedText);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTITLE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessBASE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessHTML(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessHEAD(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
//  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessBODY(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessSCRIPT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessSTYLE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessMETA(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessLINK(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessOBJECT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessINS(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessDEL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.Process_Hidden(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : begin
      StoreHiddenText(aParsedText);
      OpenHiddenArea;
    end;
    esCloseTag : StoreHiddenText(aParsedText);
    esElementFail, esElementSuccess: CloseHiddenArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : begin
      aParsedText := TLMDParsedTextList(aParsedText.AddSubitem(
        TLMDParagraph.Create(aParsedText, TokenAsTag.Attributes.Values['Align'])));
    end;
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
//    esCloseTag : aParsedText := nil;
//    aParsedText.AddSubItem(TLMDLineBreak.Create(aParsedText));
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessH_n(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage;
                FontSize: integer);
begin
  case aStage of
    esOpenTag    : begin
      FStyle.OpenFontSizeArea(IntToStr(FontSize));
      aParsedText := TLMDParsedTextList(aParsedText.AddSubitem(
        TLMDParagraph.Create(aParsedText, TokenAsTag.Attributes.Values['Align'])));
    end;
    esCloseTag : FStyle.CloseFontSizeArea;
    esRollBack, esElementFail : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessH1(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  ProcessH_n(aParsedText, aStage, 24);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessH2(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  ProcessH_n(aParsedText, aStage, 18);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessH3(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  ProcessH_n(aParsedText, aStage, 16);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessH4(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  ProcessH_n(aParsedText, aStage, 14);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessH5(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  ProcessH_n(aParsedText, aStage, 12);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessH6(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  ProcessH_n(aParsedText, aStage, 10);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessUL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag       : aParsedText := TLMDParsedTextList(aParsedText.AddSubItem(
      TLMDParseList.Create(aParsedText, ltUnordered)));
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessOL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag       : aParsedText := TLMDParsedTextList(aParsedText.AddSubitem(
      TLMDParseList.Create(aParsedText, ltOrdered)));
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessLI(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag       : aParsedText := TLMDParsedTextList(aParsedText.AddSubItem(
      TLMDParseListItem.Create(aParsedText)));
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessLI_1(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag       :
      begin
        if  not (aParsedText is TLMDParseList) then
          aParsedText := TLMDParsedTextList(aParsedText.AddSubItem(
            TLMDParseList.Create(aParsedText, ltUnordered)));
          aParsedText := TLMDParsedTextList(aParsedText.AddSubItem(
            TLMDParseListItem.Create(aParsedText)));
          aParsedText := TLMDParsedTextList(aParsedText.AddSubitem(
            TLMDParagraph.Create(aParsedText, '')));
      end;
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessPRE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : aParsedText := TLMDParsedTextList(aParsedText.AddSubitem(
      TLMDParagraph.Create(aParsedText, TokenAsTag.Attributes.Values['Align'])));
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessNOSCRIPT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessHR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  if aStage = esOpenTag then
    aParsedText.AddSubitem(TLMDLine.Create(aParsedText));
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag    : FStyle.OpenFontFaceArea('Courier');
    esElementFail, esCloseTag : FStyle.CloseFontFaceArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessFontStyle(var aParsedText : TLMDParsedTextList;
              aStage : TLMDEntryStage; FontStyle: TFontStyle);
begin
  case aStage of
{
    esOpenTag    : FStyle.OpenFontStyleArea(FStyle.FontStyle+[FontStyle]);
    esElementFail, esCloseTag : FStyle.CloseFontStyleArea;
}
    esOpenTag    : FStyle.FontStyle := FStyle.FontStyle +[FontStyle];
    esElementFail, esCloseTag : FStyle.FontStyle := FStyle.FontStyle - [FontStyle];
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessI(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  ProcessFontStyle(aParsedText, aStage, fsItalic);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessB(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  ProcessFontStyle(aParsedText, aStage, fsBold);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessU(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  ProcessFontStyle(aParsedText, aStage, fsUnderline);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessS(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  ProcessFontStyle(aParsedText, aStage, fsStrikeout);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessBIG(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag    : begin
      FStyle.OpenFontFaceArea('Courier');
      FStyle.OpenFontStyleArea(FStyle.FontStyle+[fsBold]);
    end;
    esElementFail, esCloseTag : begin
      FStyle.CloseFontFaceArea;
      FStyle.CloseFontStyleArea;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessSMALL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag    : begin
      FStyle.OpenFontFaceArea('Courier');
      FStyle.OpenFontSizeArea('2');
    end;
    esElementFail, esCloseTag : begin
      FStyle.CloseFontSizeArea;
      FStyle.CloseFontFaceArea;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessSUNKEN(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
var
  S: string;
begin
  case aStage of
    esOpenTag    : begin
      FStyle.OpenTextStyleArea(tsSunken);

      if CheckTokenAsTagAttr('LIGHTCOLOR', S)  then
        FStyle.OpenLightColorArea(StrToColor(S))
      else
        FStyle.OpenLightColorArea(FStyle.LightColor);

      if CheckTokenAsTagAttr('LIGHTDEPTH', S) then
        FStyle.OpenLightDepthArea(StrToInt(S))
      else
        FStyle.OpenLightDepthArea(FStyle.LightDepth);
    end;
    esElementFail, esCloseTag : begin
      FStyle.CloseTextStyleArea;
      FStyle.CloseLightColorArea;
      FStyle.CloseLightDepthArea;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessRAISED(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
var
  S: string;
begin
  case aStage of
    esOpenTag    : begin
      FStyle.OpenTextStyleArea(tsRaised);

      if CheckTokenAsTagAttr('LIGHTCOLOR', S)  then
        FStyle.OpenLightColorArea(StrToColor(S))
      else
        FStyle.OpenLightColorArea(FStyle.LightColor);

      if CheckTokenAsTagAttr('LIGHTDEPTH', S)  then
        FStyle.OpenLightDepthArea(StrToInt(S))
      else
        FStyle.OpenLightDepthArea(FStyle.LightDepth);

    end;
    esElementFail, esCloseTag : begin
      FStyle.CloseTextStyleArea;
      FStyle.CloseLightColorArea;
      FStyle.CloseLightDepthArea;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDHTMLParser.CheckTokenAsTagAttr(const aName: string; var aRes: string): Boolean;
begin
  Result := TokenAsTag.GetAttr(aName, aRes);

  if Result and IsVariable(aRes) then
    aRes := GetVariable(Token, aRes, FGetVariable);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessPCOLOR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
var
  S: string;
begin
  case aStage of
    esOpenTag    :
      begin
        if CheckTokenAsTagAttr('STYLE', S) then
        begin
          if SameText(S, 'RAISED') then
            FStyle.OpenTextStyleArea(tsPColorRaised)
          else
            FStyle.OpenTextStyleArea(tsPColorSunken);
        end
        else
          FStyle.OpenTextStyleArea(tsPColorSunken);

        if CheckTokenAsTagAttr('LIGHTCOLOR', S)  then
          FStyle.OpenLightColorArea(StrToColor(S))
        else
          FStyle.OpenLightColorArea(FStyle.LightColor);

        if CheckTokenAsTagAttr('LIGHTDEPTH', S)  then
          FStyle.OpenLightDepthArea(StrToInt(S))
        else
          FStyle.OpenLightDepthArea(FStyle.LightDepth);

        if CheckTokenAsTagAttr('SHADOWCOLOR', S) then
          FStyle.OpenShadowColorArea(StrToColor(S))
        else
          FStyle.OpenShadowColorArea(FStyle.LightColor);

        if CheckTokenAsTagAttr('SHADOWDEPTH', S) then
          FStyle.OpenShadowDepthArea(StrToInt(S))
        else
          FStyle.OpenShadowDepthArea(FStyle.LightDepth);
      end;
    esElementFail, esCloseTag :
      begin
        FStyle.CloseTextStyleArea;
        FStyle.CloseLightColorArea;
        FStyle.CloseLightDepthArea;
        FStyle.CloseShadowColorArea;
        FStyle.CloseShadowDepthArea;
      end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessFONT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
const
  FontSizes: array[1..7] of Byte = (10, 12, 14, 16, 18, 24, 28);
var
  i: integer;
  S: string;
begin
  case aStage of
    esOpenTag    :
      begin
        if CheckTokenAsTagAttr('FACE', S) then
          begin
            if i_Pos(',', S, i) then
              FStyle.OpenFontFaceArea(Copy(S, 1, i - 1))
            else
              FStyle.OpenFontFaceArea(S);
          end;

        if CheckTokenAsTagAttr('SIZE', S) then
          FStyle.OpenFontSizeArea(StrToFontSize(S))
        else
        if CheckTokenAsTagAttr('POINT-SIZE', S) then
          FStyle.OpenFontSizeArea(S)
        else
          FStyle.OpenFontSizeArea(FStyle.BaseFontSize);

        if CheckTokenAsTagAttr('COLOR', S)  then
          FStyle.OpenFontColorArea(StrToColor(S))
//      else FStyle.OpenFontColorArea(FStyle.FontColor);
        else
          FStyle.OpenFontColorArea(FStyle.BaseFontColor);
      end;
    esElementFail, esCloseTag :
      begin
        if FStyle.FontFace <> '' then FStyle.CloseFontFaceArea;
        FStyle.CloseFontSizeArea;
        FStyle.CloseFontColorArea;
      end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessBASEFONT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
const
  FontSizes: array[1..7] of Byte = (10, 12, 14, 16, 18, 24, 28);
var
  S: string;
begin
  case aStage of
    esOpenTag :
    begin
      if CheckTokenAsTagAttr('FACE', S) then
        begin
          if Pos(',', S) = 0 then
            FStyle.OpenBaseFontFaceArea(S)
          else
            FStyle.OpenBaseFontFaceArea(Copy(S, 1, Pos(',', S) - 1));
        end
      else
        FStyle.OpenBaseFontFaceArea('');

      if CheckTokenAsTagAttr('SIZE', S) then
        FStyle.OpenBaseFontSizeArea(StrToFontSize(S))
      else
        FStyle.OpenBaseFontSizeArea(IntToStr(FontSizes[1]));

      if CheckTokenAsTagAttr('COLOR', S)  then
        FStyle.OpenBaseFontColorArea(StrToColor(S))
      else
        FStyle.OpenBaseFontColorArea(StrToColor('Black'));
    end;
    esCloseTag, esElementFail, esElementSuccess: ;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessCLOSEBASEFONT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag :
    begin
      FStyle.CloseBaseFontFaceArea;
      FStyle.CloseBaseFontSizeArea;
      FStyle.CloseBaseFontColorArea;
    end;
    esCloseTag, esElementFail, esElementSuccess: ;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessEM(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenFontStyleArea(FStyle.FontStyle+[fsItalic]);
    esElementFail, esCloseTag : FStyle.CloseFontStyleArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessSTRONG(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenFontStyleArea(FStyle.FontStyle+[fsBold]);
    esElementFail, esCloseTag : FStyle.CloseFontStyleArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessDFN(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenFontStyleArea(FStyle.FontStyle+[fsItalic]);
    esElementFail, esCloseTag : FStyle.CloseFontStyleArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessCODE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenFontFaceArea('Courier');
    esElementFail, esCloseTag : FStyle.CloseFontFaceArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessSAMP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenFontFaceArea('Courier');
    esElementFail, esCloseTag : FStyle.CloseFontFaceArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessKBD(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenFontFaceArea('Courier');
    esElementFail, esCloseTag : FStyle.CloseFontFaceArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessVAR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenFontStyleArea(FStyle.FontStyle+[fsItalic, fsBold]);
    esElementFail, esCloseTag : FStyle.CloseFontStyleArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessCITE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenFontStyleArea(FStyle.FontStyle+[fsItalic, fsBold]);
    esElementFail, esCloseTag : FStyle.CloseFontStyleArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessABBR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenFontStyleArea(FStyle.FontStyle+[fsBold]);
    esElementFail, esCloseTag : FStyle.CloseFontStyleArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessACRONYM(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenFontStyleArea(FStyle.FontStyle+[fsBold]);
    esElementFail, esCloseTag : FStyle.CloseFontStyleArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessADDRESS(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessBLOCKQUOTE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : begin
      aParsedText := TLMDParsedTextList(aParsedText.AddSubitem(TLMDParagraph.Create(aParsedText)));
    end;
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
    esCloseTag : ;
  end;
{
  case aStage of
    esOpenTag : begin
      StoreHiddenText(aParsedText);
      OpenHiddenArea;
    end;
    esCloseTag : StoreHiddenText(aParsedText);
    esElementFail, esElementSuccess: CloseHiddenArea;
  end;
}
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessPARAM(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessDL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessDT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessDIV(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
{  case aStage of
    esOpenTag : begin
      aParsedText := TLMDParsedTextList(aParsedText.AddSubitem(TLMDParagraph.Create(aParsedText)));
      if TokenAsTag.Attributes.Values['ALIGN'] <>  '' then
        TLMDParagraph(aParsedText).AlignTxt := TokenAsTag.Attributes.Values['ALIGN'];
    end;
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
}
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessCENTER(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
{  case aStage of
    esOpenTag : begin
      aParsedText := TLMDParsedTextList(aParsedText.AddSubitem(TLMDParagraph.Create(aParsedText)));
      TLMDParagraph(aParsedText).AlignTxt := 'center';
    end;
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;}
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessIMG(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  if aStage = esOpenTag then
  aParsedText.AddSubItem(TLMDImage.Create(aParsedText,
    TokenAsTag.Attributes.Values['SRC'],
    TokenAsTag.Attributes.Values['WIDTH'],
    TokenAsTag.Attributes.Values['HEIGHT'],
    TokenAsTag.Attributes.Values['IMAGEINDEX'],
    FGraphicErrorEvent));
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessSUB(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenSubscriptStyleArea(tssSubscript);
    esElementFail, esCloseTag : FStyle.CloseSubscriptStyleArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessSUP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : FStyle.OpenSubscriptStyleArea(tssSuperscript);
    esElementFail, esCloseTag : FStyle.CloseSubscriptStyleArea;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessA(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : begin
      FStyle.OpenLinkArea;
      FStyle.OpenHREFArea(TokenAsTag.Attributes.Values['HREF']);
    end;
    esElementFail, esCloseTag : begin
      FStyle.CloseLinkArea;
      FStyle.CloseHREFArea;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessBR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  if aStage = esOpenTag then
    aParsedText.AddSubItem(TLMDLineBreak.Create(aParsedText))
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessSPAN(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessQ(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessMAP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessAREA(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessFORM(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessINPUT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
var
  lClassValue  : string;
  lCtrlClass   : string;
  lCtrlCaption : string;
  lControl     : TLMDEmbdControl;
  lName, lHeight, lWidth: string;
begin
  case aStage of
    esOpenTag : begin
      CheckTokenAsTagAttr('TYPE', lClassValue);
//      if IsVariable(TokenAsTag.Attributes.Values['TYPE']) then
//        lClassValue := GetVariable(Token, TokenAsTag.Attributes.Values['TYPE'], FGetVariable)
//      else lClassValue := TokenAsTag.Attributes.Values['TYPE'];
      begin
        lCtrlClass := 'TEdit';
        lWidth := '40';
        lHeight := '20';
        if SameText(lClassValue, 'TEXT') then
          lCtrlClass := 'TEdit';
        if SameText(lClassValue, 'PASSWORD') then
          lCtrlClass := 'TEdit';
        if SameText(lClassValue, 'CHECKBOX') then
          lCtrlClass := 'TCheckBox';
        if SameText(lClassValue, 'RADIO') then
          lCtrlClass := 'TRadioButton';
        if SameText(lClassValue, 'SUBMIT') then begin
          lCtrlClass := 'TButton';
          lCtrlCaption := 'Submit';
        end;
        if SameText(lClassValue, 'RESET') then begin
          lCtrlClass := 'TButton';
          lCtrlCaption := 'Reset';
        end;
        if SameText(lClassValue, 'FILE') then
          lCtrlClass := 'TEdit';
        if SameText(lClassValue, 'BUTTON') then
          lCtrlClass := 'TButton';

        CheckTokenAsTagAttr('NAME', lName);
//        if IsVariable(TokenAsTag.Attributes.Values['NAME']) then
//          lName := GetVariable(Token, TokenAsTag.Attributes.Values['NAME'], FGetVariable)
//        else lName := TokenAsTag.Attributes.Values['NAME'];

        CheckTokenAsTagAttr('WIDTH', lWidth);
//        if IsVariable(TokenAsTag.Attributes.Values['WIDTH']) then
//          lWidth := GetVariable(Token, TokenAsTag.Attributes.Values['WIDTH'], FGetVariable)
//        else lWidth := TokenAsTag.Attributes.Values['WIDTH'];

        CheckTokenAsTagAttr('HEIGHT', lHeight);
//        if IsVariable(TokenAsTag.Attributes.Values['HEIGHT']) then
//          lHeight := GetVariable(Token, TokenAsTag.Attributes.Values['HEIGHT'], FGetVariable)
//        else lHeight := TokenAsTag.Attributes.Values['HEIGHT'];

        lControl := TLMDEmbdControl(aParsedText.AddSubItem(TLMDEmbdControl.Create(aParsedText, lCtrlClass,
          lName,
          lWidth,
          lHeight,
          FEmbdControlCreated)));
        lControl.ControlCaption := lCtrlCaption;
      end;
    end;
    esDataCancel, esCloseTag : ;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTEXTAREA(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessLABEL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessBUTTON(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessSELECT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessOPTGROUP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessOPTION(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessFIELDSET(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTABLE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
var
  S: string;
begin
  case aStage of
    esOpenTag : begin
      aParsedText := TLMDParsedTextList(aParsedText.AddSubItem(TLMDTable.Create(aParsedText)));

      if CheckTokenAsTagAttr('BGCOLOR', S)  then
        TLMDTable(aParsedText).BgColor:= RGBToColor(S);

      if CheckTokenAsTagAttr('CELLSPACING', S)  then
        TLMDTable(aParsedText).Cellspacing:= StrToInt(S);

      if CheckTokenAsTagAttr('BORDER', S) then
        TLMDTable(aParsedText).Border:= StrToInt(S);

      if CheckTokenAsTagAttr('CELLPADDING', S)  then
        TLMDTable(aParsedText).Cellpadding:= HTMLToWidth(S);

      if CheckTokenAsTagAttr('WIDTH', S)  then
        TLMDTable(aParsedText).Width:= HTMLToWidth(S);

      if CheckTokenAsTagAttr('ALIGN', S)  then
        TLMDTable(aParsedText).Align:= StrToLMDParaAlign(S);

      if CheckTokenAsTagAttr('VALIGN', S) then
        TLMDTable(aParsedText).VAlign:= StrToLMDVAlign(S);

      if TLMDTable(aParsedText).Width < -100 then
        TLMDTable(aParsedText).Width:= -100;
    end;
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
    esCloseTag : TLMDTable(aParsedText).Prepare;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessCAPTION(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTHEAD(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTFOOT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTBODY(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessCOLGROUP(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessCOL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTR(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
var
  S: string;
begin
  case aStage of
    esOpenTag : begin
      aParsedText := TLMDParsedTextList(aParsedText.AddSubItem(TLMDTableRow.Create(aParsedText)));

      if CheckTokenAsTagAttr('height', S) then
        TLMDTableRow(aParsedText).Height := HTMLToWidth(S);

      if CheckTokenAsTagAttr('VALIGN', S) then
        TLMDTableRow(aParsedText).VAlign:= StrToLMDVAlign(S);

    end;
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTH(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : aParsedText := TLMDParsedTextList(aParsedText.AddSubItem(TLMDCell.Create(aParsedText)));
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTD(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
var
  lParentheight : LongInt;
  lParentVAlign : TLMDVAlign;
  S: string;
begin
  lParentheight:=0;

  case aStage of
    esOpenTag : begin
      lParentVAlign := vaTop;
      if Assigned(aParsedText) then
        if aParsedText is TLMDTableRow then begin
          lParentheight := TLMDTableRow(aParsedText).Height;
          lParentVAlign := TLMDTableRow(aParsedText).VAlign;
        end;
      aParsedText := TLMDParsedTextList(aParsedText.AddSubItem(TLMDCell.Create(aParsedText)));

      if CheckTokenAsTagAttr('BGCOLOR', S)  then
        TLMDCell(aParsedText).BgColor:= RGBToColor(S);

      if CheckTokenAsTagAttr('WIDTH', S)  then
        TLMDCell(aParsedText).Width:= HTMLToWidth(S);

      if CheckTokenAsTagAttr('ALIGN', S)  then
        TLMDCell(aParsedText).Align:= StrToLMDParaAlign(S);

      if CheckTokenAsTagAttr('VALIGN', S) then
        TLMDCell(aParsedText).VAlign:= StrToLMDVAlign(S)
      else
        TLMDCell(aParsedText).VAlign := lParentVAlign;

      if CheckTokenAsTagAttr('HEIGHT', S) then
        TLMDCell(aParsedText).Height:= HTMLToWidth(S)
      else
        TLMDCell(aParsedText).Height:= lParentheight;

      if CheckTokenAsTagAttr('ROWSPAN', S)  then
        TLMDCell(aParsedText).rowspan:= HTMLToWidth(S);

      if CheckTokenAsTagAttr('COLSPAN', S)  then
        TLMDCell(aParsedText).colspan:= HTMLToWidth(S);

    end;
    esElementFail : ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessCONTROL(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
var
  lClassName    : string;
  lName         : string;
  lWidth        : string;
  lHeight       : string;
begin
  if aStage = esOpenTag then
  begin
    CheckTokenAsTagAttr('VCLCLASS', lClassName);
    CheckTokenAsTagAttr('NAME', lName);
    CheckTokenAsTagAttr('WIDTH', lWidth);
    CheckTokenAsTagAttr('HEIGHT', lHeight);
{
    if IsVariable(TokenAsTag.Attributes.Values['VCLCLASS']) then
      lClassName := GetVariable(Token, TokenAsTag.Attributes.Values['VCLCLASS'], FGetVariable)
    else lClassName := TokenAsTag.Attributes.Values['VCLCLASS'];

    if IsVariable(TokenAsTag.Attributes.Values['NAME']) then
      lName := GetVariable(Token, TokenAsTag.Attributes.Values['NAME'], FGetVariable)
    else lName := TokenAsTag.Attributes.Values['NAME'];

    if IsVariable(TokenAsTag.Attributes.Values['WIDTH']) then
      lWidth := GetVariable(Token, TokenAsTag.Attributes.Values['WIDTH'], FGetVariable)
    else lWidth := TokenAsTag.Attributes.Values['WIDTH'];

    if IsVariable(TokenAsTag.Attributes.Values['HEIGHT']) then
      lHeight := GetVariable(Token, TokenAsTag.Attributes.Values['HEIGHT'], FGetVariable)
    else lHeight := TokenAsTag.Attributes.Values['HEIGHT'];
}
  aParsedText.AddSubItem(TLMDEmbdControl.Create(aParsedText,
    lClassName,
    lName,
    lWidth,
    lHeight,
    FEmbdControlCreated));
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessTREE(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : aParsedText := TLMDParsedTextList(aParsedText.AddSubItem(
        TLMDTree.Create(aParsedText,True)));
    esElementFail, esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessITEM(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : aParsedText := TLMDParsedTextList(aParsedText.AddSubItem(TLMDTree.Create(aParsedText)));
    esElementFail, esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessREPEAT(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esOpenTag : aParsedText := TLMDParsedTextList(aParsedText.AddSubitem(
        TLMDRepeat.Create(aParsedText, TokenAsTag.Attributes.Values['COUNT'], FRepeatEvent)));
    esDataCancel: ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessDD(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessBDO(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessLEGEND(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  Process_Hidden(aParsedText, aStage);
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ProcessPLAIN(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  case aStage of
    esData : aParsedText := TLMDParsedTextList(aParsedText.AddSubitem(
        TLMDParagraph.Create(aParsedText)));
    esDataCancel: ChopAndNil(aParsedText);
    esRollBack : ChopAndNil(aParsedText);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.ExceptionHandler(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
{
  if  (aParsedText.Parent = nil) and (FHiddenModeRef = 0)  then
    AddTag('P')
  else
}
  begin
    StoreHiddenText(aParsedText);
    NextToken;
  end;
end;

{------------------------------------------------------------------------------}
{procedure TLMDHTMLParser.NullExceptionHandler(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  //
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.EH_BODY(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  AddTag('P');
end;

{------------------------------------------------------------------------------}

procedure TLMDHTMLParser.Nothing(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage);
begin
  NextToken;
end;

{ ******************************** PROTECTED ********************************* }

function TLMDHTMLParser.GetLexClass: TLMDLexClass;
begin
  Result:= TLMDHTMLLex;
end;

procedure TLMDHTMLParser.FillDTD(aDTD : TLMDDTD);
var
  DM     : TLMDDataModel;
  SubDM1 : TLMDDataModel;
//  SubDM2 : TLMDDataModel;
  Exl    : TStringList;
  CloseTags : TStringList;

  procedure AddStrings(Dst: TStrings; const aStr: array of string);
  var
    i: integer;
  begin
    for i := Low(aStr) to High(aStr) do
      if  aStr[i] <> '' then
        Dst.Add(aStr[i]);
  end;

  function  CreateStrings(const aStr: array of string): TStringList;
  begin
    Result := TStringList.Create;
    AddStrings(Result, aStr);
  end;

  procedure Add_iONCE_OR(DM: TLMDDataModel; const aStr: array of string);
  var
    i: integer;
  begin
    for i := Low(aStr) to High(aStr) do
      if  aStr[i] <> '' then
        begin
          if  DM.Count > 0  then  DM.Add_OR;
          DM.Add(aStr[i], iONCE);
        end;
  end;

  procedure HEADTags;
  begin
    AddStrings(CloseTags,
      ['HEAD', 'TITLE', 'BASE', 'SCRIPT', 'STYLE', 'META', 'LINK',
       'OBJECT', '/HEAD']);
  end;

  procedure InlineTags;
  begin
    AddStrings(CloseTags,
      ['', 'TT', 'I', 'B', 'BIG', 'SMALL', 'SUNKEN', 'RAISED', 'PCOLOR',
       'U', 'FONT', 'BASEFONT', 'CLOSEBASEFONT', 'EM', 'STRONG', 'DFN',
       'CODE', 'SAMP', 'KBD', 'VAR', 'CITE', 'ABBR', 'ACRONYM', 'A',
       'IMG', 'OBJECT', 'BR', 'SCRIPT', 'MAP', 'Q', 'SUB', 'SUP',
       'SPAN', 'BDO', 'INPUT', 'SELECT', 'TEXTAREA', 'LABEL', 'BUTTON']);
  end;

  procedure BlockTags;
  begin
    AddStrings(CloseTags,
      ['P', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'UL', 'OL', 'PRE', 'DL',
       'DIV', 'NOSCRIPT', 'BLOCKQUOTE', 'FORM', 'HR', 'TABLE',
       'FIELDSET', 'ADDRESS', 'TREE', 'REPEAT']);
  end;

  procedure BODYTags;
  begin
    AddStrings(CloseTags, ['BODY', '/BODY', 'SCRIPT', 'INS', 'DEL']);
    BlockTags;
    InlineTags;
  end;

  procedure HTMLTags;
  begin
    AddStrings(CloseTags, ['HTML', '/HTML']);
    HEADTags;
    BODYTags;
  end;

begin
  aDTD.Definition.DTD_TYPE('#PCDATA', IsPCDATA, ProcessPCDATA);

  DM := TLMDDataModel.Create;
    DM.Add('!DOCTYPE', iZero_or_one); DM.Add('HTML', iONCE);
  aDTD.Definition.DTD_ENTITY('HTML_DOCUMENT', DM);

  CloseTags := TStringList.Create;
    HTMLTags;
  aDTD.Definition.DTD_ELEMENT('!DOCTYPE', True, False, CloseTags, nil, nil, ProcessDOCTYPE, Nothing);

//  <!ELEMENT HTML O O (%html.content;)
  DM := TLMDDataModel.Create; DM.Add('%html.content', iONCE);
  aDTD.Definition.DTD_ELEMENT('HTML', False, False, nil, DM, nil, ProcessHTML, Nothing);

//  <!ENTITY %html.content "HEAD, BODY">
  DM := TLMDDataModel.Create;
//  DM.Add('#PCDATA', iZERO_OR_MORE);
  DM.Add('HEAD', iZERO_OR_ONE);
  DM.Add('BODY', iZERO_OR_ONE);
  aDTD.Definition.DTD_ENTITY('%html.content', DM);

//  <!ELEMENT HEAD O O (%head.content;) +(%head.misc;)
  DM := TLMDDataModel.Create;
 //   DM.Add('#PCDATA', iZERO_OR_MORE);
    DM.Add('%head.misc', iZERO_OR_MORE);
    DM.Add('%head.content', iONCE);
    DM.Add('%head.misc', iZERO_OR_MORE);

  CloseTags := CreateStrings(['/HTML', 'HTML']);
  BodyTags;
  aDTD.Definition.DTD_ELEMENT('HEAD', False, False, CloseTags, DM, nil, ProcessHEAD, EH_BODY);//ExceptionHandler);

// <!ENTITY % head.content "TITLE & BASE?">
  DM := TLMDDataModel.Create;
    DM.Add('TITLE', iONCE);
    DM.Add('BASE', iZERO_OR_ONE);
    DM.Add_OR;
    DM.Add('BASE', iZERO_OR_ONE);
    DM.Add('TITLE', iONCE);
  aDTD.Definition.DTD_ENTITY('%head.content', DM);

// <!ELEMENT TITLE - - (#PCDATA) -(%head.misc;)
  DM := TLMDDataModel.Create; DM.Add('#PCDATA', iONCE);
  Exl := CreateStrings(['SCRIPT', 'STYLE', 'META', 'LINK', 'OBJECT']);
  aDTD.Definition.DTD_ELEMENT('TITLE', True, True, nil, DM, Exl, ProcessTITLE, ExceptionHandler);

// <!ELEMENT BASE - O EMPTY
//  CloseTags := TStringList.Create;
//    HTMLTags;
  aDTD.Definition.DTD_ELEMENT('BASE', True, False, nil, nil, nil, ProcessBASE, Nothing);

// <!ENTITY % head.misc "SCRIPT|STYLE|META|LINK|OBJECT"
  DM := TLMDDataModel.Create;
  Add_iONCE_OR(DM, ['SCRIPT', 'STYLE', 'META', 'LINK', 'OBJECT']);
  aDTD.Definition.DTD_ENTITY('%head.misc', DM);

// <!ELEMENT SCRIPT - - %Script;
// <!ENTITY % Script "CDATA"
  DM := TLMDDataModel.Create; DM.Add('#PCDATA', iONCE);
  aDTD.Definition.DTD_ELEMENT('SCRIPT', True, True, nil, DM, nil, ProcessSCRIPT, ExceptionHandler);

// <!ELEMENT STYLE - - %StyleSheet
// <!ENTITY % StyleSheet "CDATA"
  DM := TLMDDataModel.Create; DM.Add('#PCDATA', iONCE);
  aDTD.Definition.DTD_ELEMENT('STYLE', True, True, nil, DM, nil, ProcessSTYLE, ExceptionHandler);

// <!ELEMENT META - O EMPTY
  CloseTags := TStringList.Create;
    HTMLTags;
  aDTD.Definition.DTD_ELEMENT('META', True, False, CloseTags, nil, nil, ProcessMETA, Nothing);

// <!ELEMENT LINK - O EMPTY
  CloseTags := TStringList.Create;
    HTMLTags;
  aDTD.Definition.DTD_ELEMENT('LINK', True, False, CloseTags, nil, nil, ProcessLINK, Nothing);

// <!ELEMENT OBJECT - - (PARAM | %flow;)*
  DM := TLMDDataModel.Create;
    DM.Add('PARAM', iONCE); DM.Add_OR;
    DM.Add('%flow', iONCE);
    DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('OBJECT', True, True, nil, DM, nil, ProcessOBJECT, ExceptionHandler);

// <!ELEMENT BODY O O (%block;|SCRIPT)+ +(INS|DEL)
// <!ELEMENT BODY O O (%block;|SCRIPT|INS|DEL)+ new
  SubDM1 := TLMDDataModel.Create;
    Add_iONCE_OR(SubDM1, ['%block', 'SCRIPT', 'INS', 'DEL']);
    SubDM1.Iterator := iONE_OR_MORE;
  CloseTags := CreateStrings(['/HTML', 'HTML']);
  aDTD.Definition.DTD_ELEMENT('BODY', False, False, CloseTags, SubDM1, nil, ProcessBODY, EH_BODY);

// <!ENTITY % block
//     "P | %heading; | %list; | %preformatted; | DL | DIV | NOSCRIPT |
//      BLOCKQUOTE | FORM | HR | TABLE | FIELDSET | ADDRESS">
  DM := TLMDDataModel.Create;
    Add_iONCE_OR(DM, ['P', 'LI', '%heading', '%list', 'PRE', 'DL', 'DIV',
        'NOSCRIPT', 'BLOCKQUOTE', 'REPEAT', 'FORM', 'HR', 'TABLE',
        'TREE', 'FIELDSET', 'ADDRESS']);
  aDTD.Definition.DTD_ENTITY('%block', DM);

// <!ENTITY % flow "%block; | %inline;">
  DM := TLMDDataModel.Create;
  Add_iONCE_OR(DM, ['%block', '%inline']);
  aDTD.Definition.DTD_ENTITY('%flow', DM);

//  <!ENTITY % inline "#PCDATA | %fontstyle; | %phrase; | %special; | %formctrl;">
  DM := TLMDDataModel.Create;
  Add_iONCE_OR(DM, ['#PCDATA', '%fontstyle', '%phrase', '%special',
      '%formctrl', 'CENTER']);
  aDTD.Definition.DTD_ENTITY('%inline', DM);

// <!ELEMENT INS - - (%flow;)*
  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('INS', True, True, nil, DM, nil, ProcessINS, ExceptionHandler);

// <!ELEMENT DEL - - (%flow;)*
  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('DEL', True, True, nil, DM, nil, ProcessDEL, ExceptionHandler);

//  <!ELEMENT P - O (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  CloseTags := CreateStrings(['/HTML', '/BODY']);
  BlockTags;
  AddStrings(CloseTags, ['/TD', '/TH', 'TD', 'TH', 'TR', '/TR',
      'THEAD', '/THEAD', 'TFOOT', '/TFOOT', 'TBODY', '/TBODY',
      '/TABLE', '/ITEM', 'ITEM', 'LI', '/LI', '/UL', '/OL', '/REPEAT']);
  aDTD.Definition.DTD_ELEMENT('P', True, False, CloseTags, DM, nil, ProcessP, ExceptionHandler);

  DM := TLMDDataModel.Create;
  Add_iONCE_OR(DM, ['#PCDATA', '%fontstyle', 'SUB', 'SUP', 'IMG', 'CONTROL']);
  DM.Iterator := iZERO_OR_MORE;
//  DM.Add('#PCDATA', iZERO_OR_MORE);//iONCE);
//  DM.Add_OR;
//  DM.Add('%fontstyle', iZERO_OR_MORE);
//  DM.Add('%inline', iONCE);
//  DM.Iterator := iZERO_OR_MORE;
  Exl := TStringList.Create;
  Exl.Assign(CloseTags);
  aDTD.Definition.DTD_ELEMENT('LI', True, False, Exl, DM, nil, ProcessLI_1, ExceptionHandler);

// <!ENTITY % heading "H1|H2|H3|H4|H5|H6">
  DM := TLMDDataModel.Create;
  Add_iONCE_OR(DM, ['H1', 'H2', 'H3', 'H4', 'H5', 'H6']);
  aDTD.Definition.DTD_ENTITY('%heading', DM);

// <!ELEMENT (%heading;)  - - (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('H1', True, True, nil, DM, nil, ProcessH1, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('H2', True, True, nil, DM, nil, ProcessH2, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('H3', True, True, nil, DM, nil, ProcessH3, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('H4', True, True, nil, DM, nil, ProcessH4, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('H5', True, True, nil, DM, nil, ProcessH5, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('H6', True, True, nil, DM, nil, ProcessH6, ExceptionHandler);

// <!ENTITY % list "UL | OL">
  DM := TLMDDataModel.Create;
  Add_iONCE_OR(DM, ['UL', 'OL']);
  aDTD.Definition.DTD_ENTITY('%list', DM);

// <!ELEMENT UL - - (LI)+
//  DM := TLMDDataModel.Create; DM.Add('LI', iONCE); DM.Iterator := iONE_OR_MORE;
  DM := TLMDDataModel.Create; DM.Add('LI', iONCE); DM.Iterator := iZero_or_More;
  aDTD.Definition.DTD_ELEMENT('UL', True, True, nil, DM, nil, ProcessUL, ExceptionHandler);

// <!ELEMENT OL - - (LI)+
  DM := TLMDDataModel.Create; DM.Add('LI', iONCE); DM.Iterator := iZero_or_More;//iONE_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('OL', True, True, nil, DM, nil, ProcessOL, ExceptionHandler);

// <!ELEMENT LI - O (%flow;)*
  DM := TLMDDataModel.Create;
    DM.Add('PLAIN', iONCE); DM.Add_OR;
    DM.Add('%flow', iONCE);
    DM.Iterator := iZERO_OR_MORE;
  CloseTags := CreateStrings(['LI', '/UL', '/OL']);
  aDTD.Definition.DTD_ELEMENT('LI', True, False, CloseTags, DM, nil, ProcessLI, Nothing);

// <!ELEMENT LI - - (#PCDATA)
  DM := TLMDDataModel.Create; DM.Add('#PCDATA', iONCE);
  aDTD.Definition.DTD_ELEMENT('LI', True, True, nil, DM, nil, ProcessLI, Nothing);

  // <!ENTITY % pre.exclusion "IMG|OBJECT|BIG|SMALL|SUB|SUP">
// <!ELEMENT PRE - - (%inline;)* -(%pre.exclusion;)
  DM := TLMDDataModel.Create; DM.Add('%inline', iZERO_OR_MORE);
  Exl := CreateStrings(['IMG', 'OBJECT', 'BIG', 'SMALL', 'SUB', 'SUP']);
  aDTD.Definition.DTD_ELEMENT('PRE', True, True, nil, DM, Exl, ProcessPRE, ExceptionHandler);

// <!ELEMENT NOSCRIPT - - (%block;)+
  DM := TLMDDataModel.Create; DM.Add('%block', iONCE); DM.Iterator := iONE_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('NOSCRIPT', True, True, nil, DM, nil, ProcessNOSCRIPT, ExceptionHandler);

// <!ELEMENT HR - O EMPTY
  CloseTags := CreateStrings(['/HTML', '/BODY']);
    BlockTags;
  aDTD.Definition.DTD_ELEMENT('HR', True, False, CloseTags, nil, nil, ProcessHR, Nothing);

// <!ENTITY % fontstyle
//   "TT | I | B | BIG | SMALL">
  DM := TLMDDataModel.Create;
  Add_iONCE_OR(DM, ['TT', 'I', 'B', 'U', 'S', 'STRIKE', 'BIG', 'SUNKEN',
      'RAISED', 'PCOLOR', 'FONT', 'BASEFONT', 'CLOSEBASEFONT', 'SMALL']);
  aDTD.Definition.DTD_ENTITY('%fontstyle', DM);

//  <!ELEMENT %fontstyle - - (%inline;)*>
  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('TT', True, True, nil, DM, nil, ProcessTT, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('I', True, True, nil, DM, nil, ProcessI, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('B', True, True, nil, DM, nil, ProcessB, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('U', True, True, nil, DM, nil, ProcessU, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('S', True, True, nil, DM, nil, ProcessS, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('STRIKE', True, True, nil, DM, nil, ProcessS, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('BIG', True, True, nil, DM, nil, ProcessBIG, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('SMALL', True, True, nil, DM, nil, ProcessSMALL, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('SUNKEN', True, True, nil, DM, nil, ProcessSUNKEN, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('RAISED', True, True, nil, DM, nil, ProcessRAISED, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('PCOLOR', True, True, nil, DM, nil, ProcessPCOLOR, Nothing);//ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('FONT', True, True, nil, DM, nil, ProcessFONT, Nothing);//ExceptionHandler);

  aDTD.Definition.DTD_ELEMENT('BASEFONT', True, False, nil, nil, nil, ProcessBASEFONT, Nothing);
  aDTD.Definition.DTD_ELEMENT('CLOSEBASEFONT', True, False, nil, nil, nil, ProcessCLOSEBASEFONT, Nothing);

// <!ENTITY % phrase "EM | STRONG | DFN | CODE |
//                     SAMP | KBD | VAR | CITE | ABBR | ACRONYM" >
  DM := TLMDDataModel.Create;
  Add_iONCE_OR(DM, ['EM', 'STRONG', 'DFN', 'CODE', 'SAMP', 'KBD',
      'VAR', 'CITE', 'ABBR', 'ACRONYM']);
  aDTD.Definition.DTD_ENTITY('%phrase', DM);

//  <!ELEMENT %phrase - - (%inline;)*>
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('EM', True, True, nil, DM, nil, ProcessEM, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('STRONG', True, True, nil, DM, nil, ProcessSTRONG, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('DFN', True, True, nil, DM, nil, ProcessDFN, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('CODE', True, True, nil, DM, nil, ProcessCODE, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('SAMP', True, True, nil, DM, nil, ProcessSAMP, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('KBD', True, True, nil, DM, nil, ProcessKBD, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('VAR', True, True, nil, DM, nil, ProcessVAR, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('CITE', True, True, nil, DM, nil, ProcessCITE, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('ABBR', True, True, nil, DM, nil, ProcessABBR, ExceptionHandler);

  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('ACRONYM', True, True, nil, DM, nil, ProcessACRONYM, ExceptionHandler);

// <!ELEMENT ADDRESS - - (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('ADDRESS', True, True, nil, DM, nil, ProcessADDRESS, ExceptionHandler);

//  <!ELEMENT BLOCKQUOTE - - (%block;|SCRIPT)+
  DM := TLMDDataModel.Create;
    DM.Add('%block', iONCE); DM.Add_OR;
    DM.Add('SCRIPT', iONCE);
    DM.Iterator := iONE_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('BLOCKQUOTE', True, True, nil, DM, nil, ProcessBLOCKQUOTE, ExceptionHandler);

// <!ELEMENT PARAM - O EMPTY
  CloseTags := TStringList.Create;
    CloseTags.Add('PARAM');
    HTMLTags;
  aDTD.Definition.DTD_ELEMENT('PARAM', True, False, CloseTags, nil, nil, ProcessPARAM, Nothing);

//  <!ELEMENT DL - - (DT|DD)+
  DM := TLMDDataModel.Create;
    DM.Add('DT', iONCE); DM.Add_OR; DM.Add('DD', iONCE);
    DM.Iterator := iONE_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('DL', True, True, nil, DM, nil, ProcessDL, ExceptionHandler);

// <!ELEMENT DT - O (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  CloseTags := CreateStrings(['DT', 'DL', 'DD']);
  aDTD.Definition.DTD_ELEMENT('DT', True, False, CloseTags, DM, nil, ProcessDT, Nothing);

//  <!ELEMENT DD - O (%flow;)*
  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  CloseTags := CreateStrings(['DT', 'DL', 'DD']);
  aDTD.Definition.DTD_ELEMENT('DD', True, False, CloseTags, DM, nil, ProcessDD, Nothing);

//  <!ELEMENT DIV - - (%flow;)*
  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('DIV', True, True, nil, DM, nil, ProcessDIV, ExceptionHandler);

//  <!ELEMENT CENTER - - (%flow;)*
  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('CENTER', True, True, nil, DM, nil, ProcessCENTER, ExceptionHandler);

// <!ELEMENT IMG - O EMPTY
  CloseTags := TStringList.Create;
    HTMLTags;
  aDTD.Definition.DTD_ELEMENT('IMG', True, False, CloseTags, nil, nil, ProcessIMG, Nothing);

//  <!ELEMENT SUB - - (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('SUB', True, True, nil, DM, nil, ProcessSUB, ExceptionHandler);

//  <!ELEMENT SUP - - (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('SUP', True, True, nil, DM, nil, ProcessSUP, ExceptionHandler);

//  <!ENTITY % special
//     "A | IMG | OBJECT | BR | SCRIPT | MAP | Q | SUB | SUP | SPAN | BDO">
  DM := TLMDDataModel.Create;
  Add_iONCE_OR(DM, ['A', 'IMG', 'CONTROL', 'OBJECT', 'BR', 'SCRIPT',
      'MAP', 'Q', 'SUB', 'SUP', 'SPAN', 'BDO']);
  aDTD.Definition.DTD_ENTITY('%special', DM);

//  <!ELEMENT A - - (%inline;)* -(A)
  DM := TLMDDataModel.Create; DM.Add('%flow', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('A', True, True, nil, DM, nil, ProcessA, ExceptionHandler);

// <!ELEMENT BR - O EMPTY
  CloseTags := TStringList.Create;
    HTMLTags;
  aDTD.Definition.DTD_ELEMENT('BR', True, False, CloseTags, nil, nil, ProcessBR, Nothing);

// <!ELEMENT BDO - - (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('BDO', True, True, nil, DM, nil, ProcessBDO, ExceptionHandler);

//  <!ELEMENT SPAN - - (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('SPAN', True, True, nil, DM, nil, ProcessSPAN, ExceptionHandler);

// <!ELEMENT Q - - (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('Q', True, True, nil, DM, nil, ProcessQ, ExceptionHandler);

//  <!ELEMENT MAP - - ((%block;)+ | AREA+)
  DM := TLMDDataModel.Create;
    DM.Add('%block', iONE_OR_MORE); DM.Add_OR; DM.Add('AREA', iONE_OR_MORE);
  aDTD.Definition.DTD_ELEMENT('MAP', True, True, nil, DM, nil, ProcessMAP, ExceptionHandler);

// <!ELEMENT AREA - O EMPTY
  CloseTags := TStringList.Create;
    CloseTags.Add('MAP');
    BlockTags;
  aDTD.Definition.DTD_ELEMENT('AREA', True, False, CloseTags, nil, nil, ProcessAREA, Nothing);

// <!ELEMENT FORM - - (%block;|SCRIPT)+ -(FORM)
  DM := TLMDDataModel.Create;
    DM.Add('%block', iONCE); DM.Add_OR; DM.Add('AREA', iONCE);
    DM.Iterator := iONE_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('FORM', True, True, nil, DM, 'FORM', ProcessFORM, ExceptionHandler);

//  <!ENTITY % formctrl "INPUT | SELECT | TEXTAREA | LABEL | BUTTON">
  DM := TLMDDataModel.Create;
  Add_iONCE_OR(DM, ['INPUT', 'SELECT', 'TEXTAREA', 'LABEL', 'BUTTON']);
  aDTD.Definition.DTD_ENTITY('%formctrl', DM);

//  <!ELEMENT INPUT - O EMPTY
  CloseTags := TStringList.Create;
    HTMLTags;
  aDTD.Definition.DTD_ELEMENT('INPUT', True, False, CloseTags, nil, nil, ProcessINPUT, Nothing);

// <!ELEMENT TEXTAREA - - (#PCDATA)
  DM := TLMDDataModel.Create; DM.Add('#PCDATA', iONCE);
  aDTD.Definition.DTD_ELEMENT('TEXTAREA', True, True, nil, DM, nil, ProcessTEXTAREA, ExceptionHandler);

//  <!ELEMENT LABEL - - (%inline;)* -(LABEL)
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('LABEL', True, True, nil, DM, 'LABEL', ProcessLABEL, ExceptionHandler);

//  <!ELEMENT BUTTON - -
//       (%flow;)* -(A|%formctrl;|FORM|FIELDSET)
  DM := TLMDDataModel.Create; DM.Add('%flow', iZERO_OR_MORE);
  Exl := CreateStrings(['A', 'FORM', 'FIELDSET', 'formctrl', 'INPUT',
      'SELECT', 'TEXTAREA', 'LABEL', 'BUTTON']);
//  aDTD.Definition.DTD_ELEMENT('BUTTON', True, True, nil, DM, 'LABEL', ProcessBUTTON, ExceptionHandler);
  aDTD.Definition.DTD_ELEMENT('BUTTON', True, True, nil, DM, Exl, ProcessBUTTON, ExceptionHandler);

// <!ELEMENT SELECT - - (OPTGROUP|OPTION)+
  DM := TLMDDataModel.Create;
    DM.Add('OPTGROUP', iONCE); DM.Add_OR; DM.Add('OPTION', iONCE);
    DM.iterator := iONE_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('SELECT', True, True, nil, DM, nil, ProcessSELECT, ExceptionHandler);

//  <!ELEMENT OPTGROUP - - (OPTION)+
  DM := TLMDDataModel.Create; DM.Add('OPTION', iONCE); DM.Iterator := iONE_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('OPTGROUP', True, True, nil, DM, nil, ProcessOPTGROUP, ExceptionHandler);

// <!ELEMENT OPTION - O (#PCDATA)
  DM := TLMDDataModel.Create; DM.Add('#PCDATA', iONCE);
  CloseTags := TStringList.Create;
    CloseTags.Add('OPTGROUP');
  aDTD.Definition.DTD_ELEMENT('OPTION', True, False, CloseTags, DM, nil, ProcessOPTION, Nothing);

// <!ELEMENT FIELDSET - - (#PCDATA,LEGEND,(%flow;)* )
  DM := TLMDDataModel.Create;
    DM.Add('#PCDATA', iONCE);
    DM.Add('LEGEND', iONCE);
    DM.Add('%flow', iZERO_OR_MORE);
  aDTD.Definition.DTD_ELEMENT('FIELDSET', True, True, nil, DM, nil, ProcessFIELDSET, ExceptionHandler);

//  <!ELEMENT TABLE - -
//       (CAPTION?, (COL*|COLGROUP* ), THEAD?, TFOOT?, TBODY+)>
  SubDM1 := TLMDDataModel.Create;
    SubDM1.Add('COL', iZERO_OR_MORE); SubDM1.Add_OR; SubDM1.Add('COLGROUP', iZERO_OR_MORE);
  DM := TLMDDataModel.Create;
    DM.Add('CAPTION', iZERO_OR_ONE);
    DM.Add(SubDM1);
    DM.Add('THEAD', iZERO_OR_ONE);
    DM.Add('TFOOT', iZERO_OR_ONE);
    DM.Add('TBODY', iONE_OR_MORE);
    DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('TABLE', True, True, nil, DM, nil, ProcessTABLE, ExceptionHandler);

//  <!ELEMENT CAPTION  - - (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('CAPTION', True, True, nil, DM, nil, ProcessCAPTION, Nothing);

// <!ELEMENT THEAD    - O (TR)+
  DM := TLMDDataModel.Create; DM.Add('TR', iONCE); DM.Iterator := iONE_OR_MORE;
  CloseTags := CreateStrings(['TFOOT', 'TBODY', 'TR', 'TABLE']);
  aDTD.Definition.DTD_ELEMENT('THEAD', True, False, CloseTags, DM, nil, ProcessTHEAD, Nothing);

// <!ELEMENT TFOOT    - O (TR)+
  DM := TLMDDataModel.Create; DM.Add('TR', iONCE); DM.Iterator := iONE_OR_MORE;
  CloseTags := CreateStrings(['TBODY', 'TR', 'TABLE']);
  aDTD.Definition.DTD_ELEMENT('TFOOT', True, False, CloseTags, DM, nil, ProcessTFOOT, Nothing);

// <!ELEMENT TBODY    O O (TR)+
  DM := TLMDDataModel.Create; DM.Add('TR', iONCE); DM.Iterator := iONE_OR_MORE;
  CloseTags := TStringList.Create;
    CloseTags.Add('/TABLE');
  aDTD.Definition.DTD_ELEMENT('TBODY', False, False, CloseTags, DM, nil, ProcessTBODY, Nothing);

//  <!ELEMENT COLGROUP - O (col)*
  DM := TLMDDataModel.Create; DM.Add('COL', iONCE); DM.Iterator := iZERO_OR_MORE;
  CloseTags := CreateStrings(['TFOOT', 'TBODY', 'TR', 'TABLE']);
  aDTD.Definition.DTD_ELEMENT('COLGROUP', True, False, CloseTags, DM, nil, ProcessCOLGROUP, Nothing);

//  <!ELEMENT COL      - O EMPTY
  CloseTags := TStringList.Create;
    CloseTags.Add('COL');
    CloseTags.Add('COLGROUP');
//  aDTD.Definition.DTD_ELEMENT('COL', True, False, nil, nil, nil, ProcessCOL, Nothing);
  aDTD.Definition.DTD_ELEMENT('COL', True, False, CloseTags, nil, nil, ProcessCOL, Nothing);

//  <!ELEMENT TR       - O (TH|TD)+
  DM := TLMDDataModel.Create;
    DM.Add('TD', iONCE); DM.Add_OR; DM.Add('TH', iONCE);
    DM.Iterator := iZERO_OR_MORE;
  CloseTags := CreateStrings(['TR', 'THEAD', 'TFOOT', 'TBODY', '/THEAD',
        '/TFOOT', '/TBODY', '/TABLE']);
  aDTD.Definition.DTD_ELEMENT('TR', True, False, CloseTags, DM, nil, ProcessTR, ExceptionHandler);

//  <!ELEMENT TH  - O (%flow;)*
  DM := TLMDDataModel.Create;
    DM.Add('PLAIN', iONCE); DM.Add_OR;
    DM.Add('%flow', iONCE);
    DM.Iterator := iZERO_OR_MORE;
  CloseTags := CreateStrings(['TD', 'TH', 'TR', '/TR', 'THEAD', 'TFOOT',
      'TBODY', '/THEAD', '/TFOOT', '/TBODY', '/TABLE']);
  aDTD.Definition.DTD_ELEMENT('TH', True, False, CloseTags, DM, nil, ProcessTH, ExceptionHandler);

//  <!ELEMENT TD  - O (%flow;)*
  DM := TLMDDataModel.Create;
    DM.Add('PLAIN', iONCE); DM.Add_OR;
    DM.Add('%flow', iONCE);
    DM.Iterator := iZERO_OR_MORE;
  CloseTags := CreateStrings(['TD', 'TH', 'TR', '/TR', 'THEAD', 'TFOOT',
      'TBODY', '/THEAD', '/TFOOT', '/TBODY', '/TABLE']);
  aDTD.Definition.DTD_ELEMENT('TD', True, False, CloseTags, DM, nil, ProcessTD, ExceptionHandler);

  aDTD.Definition.DTD_ELEMENT('CONTROL', True, False, nil, nil, nil, ProcessCONTROL, Nothing);

  DM := TLMDDataModel.Create; DM.Add('ITEM', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('TREE', True, True, nil, DM, nil, ProcessTREE, Nothing);

  DM := TLMDDataModel.Create;
    DM.Add('PLAIN', iONCE); DM.Add_OR; DM.Add('%flow', iONCE);
    DM.Iterator := IZERO_OR_MORE;
  SubDM1 := TLMDDataModel.Create;
    SubDM1.Add(DM);
    SubDM1.Add('ITEM', iZERO_OR_MORE);
  aDTD.Definition.DTD_ELEMENT('ITEM', True, True, nil, SubDM1, nil, ProcessITEM, Nothing);

  DM := TLMDDataModel.Create;
    DM.Add('PLAIN', iONCE); DM.Add_OR;
    DM.Add('%flow', iONCE);
    DM.Iterator := iONE_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('REPEAT', True, True, nil, DM, nil, ProcessREPEAT, Nothing);

//  <!ELEMENT LEGEND - - (%inline;)*
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iZERO_OR_MORE;
  aDTD.Definition.DTD_ELEMENT('LEGEND', True, True, nil, DM, nil, ProcessLEGEND, ExceptionHandler);

//  <!ELEMENT PLAIN 0 O (%inline;)+
  DM := TLMDDataModel.Create; DM.Add('%inline', iONCE); DM.Iterator := iONE_OR_MORE;
  CloseTags := CreateStrings(['LI', '/LI', '/UL', '/OL', 'TD', '/TD',
      'TH', '/TH', 'TR', '/TR', '/TABLE', '/THEAD', '/TFOOT', '/TBODY',
      '/HTML', '/BODY', 'ITEM', '/ITEM', '/REPEAT']);
    BlockTags;
  aDTD.Definition.DTD_ELEMENT('PLAIN', False, False, CloseTags, DM, nil, ProcessPLAIN, Nothing);

end;

{ ******************************** PUBLIC ************************************ }

constructor TLMDHTMLParser.Create;
begin
  inherited Create;
  FStyle := TLMDHTMLStyle.Create;
  FDTD := TLMDDTD.Create(Self);
  FillDTD(FDTD);
end;

{------------------------------------------------------------------------------}

destructor TLMDHTMLParser.Destroy;
begin
  FStyle.Free;
  FDTD.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

function TLMDHTMLParser.Parse(aStream: TStream;
    aGraphicErrorEvent: TLMDGraphicErrorEvent;
    aGetVariable: TLMDGetVariableEvent;
    aEmbdControlCreated : TLMDEmbdControlEvent;
    aRepeatEvent : TLMDRepeatEvent): TLMDParsedTextList;
begin
  Result := TLMDParsedTextList.Create(nil);
  FGraphicErrorEvent := aGraphicErrorEvent;
  FGetVariable := aGetVariable;
  FEmbdControlCreated := aEmbdControlCreated;
  FRepeatEvent := aRepeatEvent;
  Clear;
  LoadFromStream(aStream);
  FStyle.Clear;
  FHiddenModeRef := 0;
  if not FDTD.Check('HTML_DOCUMENT', Result) then begin
    Result.Free;
    Result := TLMDParsedTextList.Create(nil);
//    Result.AddSubitem(TLMDText.Create('Incorrect data format', Result));
//    Result.AddSubitem(TLMDText.Create('Check source text please.', Result));
  end;
  Clear;
  if Assigned(Result) then Result.ApplyVariables(FGetVariable);
end;

initialization
  RegisterParser(TLMDHTMLParser, ['HTML', 'HTM'], false);

end.
