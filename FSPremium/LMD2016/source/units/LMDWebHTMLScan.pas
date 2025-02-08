unit LMDWebHTMLScan;
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

LMDWebHTMLScan unit (DD)
------------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Contnrs, StdCtrls,
  LMDWebBase, LMDWebHTMLLex, LMDWebLex
  ;

type
  TLMDOnTagEvent = procedure(szTagName: string; Attributes: TStringList;
    iStartPosition, iEndPosition: integer) of object;

  TLMDOnTextEvent = procedure(szText: string; iStartPosition, iEndPosition:
    integer) of object;

  TLMDOnEndTagEvent = procedure(szTagName: string; iStartPosition, iEndPosition:
    integer) of object;

  TLMDWebHTMLAlign = (haAbsBottom, haAbsMiddle, haBaseLine, haTextTop, haLeft,
   haRight, haTop, haMiddle, haBottom);
  TLMDWebHTMLResize = (hrNoResize, hrResize);
  TLMDWebHTMLScrolling = (hsAuto, hsYes, hsNo);
  TLMDWebHTMLFrameBorder = (fbYes, fbNo, fb0, fb1);
  TLMDWebHTMLScriptLanguage = (slJavaScript, slJScript, slVBScript);
  TLMDWebHTMLTableFrame = (tfAbove, tfBelow, tfBox, tfInsides, tfLHS, tfRHS, tfVoid, tfVSides);
  TLMDWebHTMLTableRules = (trAll, trCols, trGroups, trNone, trRows);
  TLMDWebHTMLVAlign = (vaBaseLine, vaBottom, vaCenter, vaTop);

  TLMDWebImageTag=packed record
    SRC : String;
    ALT : String;
    align : TLMDWebHTMLAlign;
    width : Integer;
    height: Integer;
    border: Integer;
    hspace: Integer;
    vspace: Integer;
    usemap: String;
    ismap : Boolean;
  end;

  TLMDOnImageTagEvent = procedure(Params: TLMDWebImageTag; Attributes: TStringList; iStartPosition, iEndPosition:
    integer) of object;

  TLMDOnTitleTagEvent = procedure(szTitle:String;iStartPosition, iEndPosition:
    integer) of object;

  TLMDOnLinkTagEvent = procedure(szURL, szTarget, szText: String;
   iStartPosition, iEndPosition: integer) of object;

  TLMDWebAppletTag = packed record
    align : TLMDWebHTMLAlign;
    code: String;
    codebase: String;
    dataFld: String;
    dataSrc: String;
    hspace: Integer;
    vspace: Integer;
    id: String;
    isTextEdit: Boolean;
    name: String;
    src: String;
    title: String;
  end;

  TLMDOnAppletTagEvent = procedure(szText: String; Params: TLMDWebAppletTag;
   Attributes: TStringList; iStartPosition, iEndPosition: integer) of object;

  TLMDOnBodyTagEvent = procedure(szBody: String;
   iStartPosition, iEndPosition: integer) of object;

  TLMDOnDivTagEvent = procedure(Attributes: TStringList;
   iStartPosition: integer) of object;

  TLMDOnFontTagEvent = procedure(Attributes: TStringList;
   iStartPosition: integer) of object;

  TLMDWebFormTag = packed record
    action: String;
    id: String;
    method: String;
    name: String;
    target: String;
    title: String;
  end;

  TLMDOnFormTagEvent = procedure(szForm: String; Params: TLMDWebFormTag;
   Attributes: TStringList; iStartPosition, iEndPosition: integer) of object;

  TLMDWebFrameTag = packed record
    borderColor: String;
    frameBorder: String;
    height: integer;
    id: String;
    marginHeight: integer;
    marginWidth: integer;
    name: string;
    noResize: TLMDWebHTMLResize;
    scrolling: TLMDWebHTMLScrolling;
    src: String;
  end;

  TLMDOnFrameTagEvent = procedure(Params: TLMDWebFrameTag;
   Attributes: TStringList; iStartPosition, iEndPosition: integer) of object;

  TLMDWebFrameSetTag = packed record
    border: integer;
    borderColor: String;
    cols: integer;
    frameBorder: TLMDWebHTMLFrameBorder;
    frameSpacing: Integer;
    id: String;
    rows: integer;
  end;

  TLMDOnFrameSetTagEvent = procedure(szFrameSet: String; Params: TLMDWebFrameSetTag;
   Attributes: TStringList; iStartPosition, iEndPosition: integer) of object;

  TLMDOnHeadTagEvent = procedure(szHead: String;
   iStartPosition, iEndPosition: integer) of object;

  TLMDWebIFrameTag = packed record
    align: TLMDWebHTMLAlign;
    border: integer;
    borderColor: String;
    frameBorder: TLMDWebHTMLFrameBorder;
    frameSpacing: integer;
    height: integer;
    hspace: integer;
    id: String;
    noResize: TLMDWebHTMLResize;
    scrolling: TLMDWebHTMLScrolling;
    src: String;
    vspace: integer;
    width: integer;
  end;

  TLMDOnIFrameTagEvent = procedure(Params: TLMDWebIFrameTag; Attributes: TStringList;
   iStartPosition: integer) of object;

  TLMDOnUlTagEvent = procedure(List: String; Attributes: TStringList;
   iStartPosition, iEndPosition: integer) of object;

  TLMDOnOlTagEvent = procedure(List: String; Attributes: TStringList;
   iStartPosition, iEndPosition: integer) of object;

  TLMDOnLiTagEvent = procedure(szText: String; Attributes: TStringList;
   iStartPosition, iEndPosition: integer) of object;

  TLMDOnMapTagEvent = procedure(szMap: String; Attribute: TStringList;
   iStartPosition, iEndPosition: integer) of object;

  TLMDOnMetaTagEvent = procedure(Attribute: TStringList;
   iStartPosition, iEndPosition: integer) of object;

  TLMDWebObjectTag = packed record
    align : TLMDWebHTMLAlign;
    code: String;
    codebase: String;
    dataFld: String;
    data: String;
    dataSrc: String;
    disabled: boolean;
    height: integer;
    id: String;
    isTextEdit: Boolean;
    name: String;
    title: String;
    type_: string;
    width: integer;
  end;

  TLMDOnObjectTagEvent = procedure(szText: String; Params: TLMDWebObjectTag;
   Attributes: TStringList; iStartPosition, iEndPosition: integer) of object;

  TLMDOnScriptTagEvent = procedure(szScript: String; Language: TLMDWebHTMLScriptLanguage;
   Attributes: TStringList; iStartPosition, iEndPosition: integer) of object;

  TLMDOnStyleTagEvent = procedure(szStyle: String;
   Attributes: TStringList; iStartPosition, iEndPosition: integer) of object;

  TLMDWebTableTag = packed record
    align: TLMDWebHTMLAlign;
    background: String;
    bgColor: String;
    border: Integer;
    borderColor: String;
    borderColorDark: String;
    borderColorLight: String;
    cellPadding: Integer;
    cellSpacing: Integer;
    cols: Integer;
    frame: TLMDWebHTMLTableFrame;
    height: Integer;
    id: String;
    rules: TLMDWebHTMLTableRules;
    scrollHeight: Integer;
    scrollLeft: Integer;
    scrollTop: Integer;
    scrollWidth: Integer;
    style: String;
    title: String;
    width: Integer;
  end;

  TLMDOnTableTagEvent = procedure(Params: TLMDWebTableTag;
   Attributes: TStringList; iStartPosition: integer) of object;

  TLMDWebTrTag = packed record
    align: TLMDWebHTMLAlign;
    bgColor: String;
    borderColor: String;
    borderColorDark: String;
    borderColorLight: String;
    style: String;
    title: String;
    valign: TLMDWebHTMLVAlign;
  end;

  TLMDOnTrTagEvent = procedure(Params: TLMDWebTrTag;
   Attributes: TStringList; iStartPosition: integer) of object;

  TLMDWebTdTag = packed record
    align: TLMDWebHTMLAlign;
    background: String;
    bgColor: String;
    borderColor: String;
    borderColorDark: String;
    borderColorLight: String;
    colSpan: Integer;
    height: Integer;
    id: String;
    noWrap: Boolean;
    rowSpan: Integer;
    style: String;
    title: String;
    valign: TLMDWebHTMLVAlign;
    width: Integer;
  end;

  TLMDOnTdTagEvent = procedure(szTd: String; Params: TLMDWebTdTag;
   Attributes: TStringList; iStartPosition, iEndPosition: integer) of object;

  { **************************TLMDWebHTMLScan**************************** }
  TLMDWebHTMLScan = class(TLMDWebComponent)
  private
    FHTML: TStringList;
    FOnTagEvent: TLMDOnTagEvent;
    FOnTextEvent: TLMDOnTextEvent;
    FReplaceSpecialChars: boolean;
    FOnStartTagEvent: TLMDOnTagEvent;
    FOnEndTagEvent: TLMDOnEndTagEvent;
    FOnImageTagEvent: TLMDOnImageTagEvent;
    FOnTitleTagEvent: TLMDOnTitleTagEvent;
    FOnLinkTagEvent: TLMDOnLinkTagEvent;
    FOnAppletTagEvent: TLMDOnAppletTagEvent;
    FOnBodyTagEvent: TLMDOnBodyTagEvent;
    FOnDivTagEvent: TLMDOnDivTagEvent;
    FOnFontTagEvent: TLMDOnFontTagEvent;
    FOnFormTagEvent: TLMDOnFormTagEvent;
    FOnFrameTagEvent: TLMDOnFrameTagEvent;
    FOnFrameSetTagEvent: TLMDOnFrameSetTagEvent;
    FOnHeadTagEvent: TLMDOnHeadTagEvent;
    FOnIFrameTagEvent: TLMDOnIFrameTagEvent;
    FOnUlTagEvent: TLMDOnUlTagEvent;
    FOnOlTagEvent: TLMDOnOlTagEvent;
    FOnLiTagEvent: TLMDOnLiTagEvent;
    FOnMapTagEvent: TLMDOnMapTagEvent;
    FOnMetaTagEvent: TLMDOnMetaTagEvent;
    FOnObjectTagEvent: TLMDOnObjectTagEvent;
    FOnScriptTagEvent: TLMDOnScriptTagEvent;
    FOnStyleTagEvent: TLMDOnStyleTagEvent;
    FOnTableTagEvent: TLMDOnTableTagEvent;
    FOnTrTagEvent: TLMDOnTrTagEvent;
    FOnTdTagEvent: TLMDOnTdTagEvent;
    FTagCharCase: TEditCharCase;
    FOnAfterParse: TNotifyEvent;
    FOnBeforeParse: TNotifyEvent;
    procedure SetHTML(const Value: TStringList);
    procedure SetOnTagEvent(const Value: TLMDOnTagEvent);
    function GetTG: integer;
    function GetToken(Index: integer): TLMDWebToken;
    procedure SetOnTextEvent(const Value: TLMDOnTextEvent);
    procedure SetReplaceSpecialChars(const Value: boolean);
    procedure SetOnStartTagEvent(const Value: TLMDOnTagEvent);
    procedure SetOnEndTagEvent(const Value: TLMDOnEndTagEvent);
    procedure SetOnImageTagEvent(const Value: TLMDOnImageTagEvent);
    procedure SetOnTitleTagEvent(const Value: TLMDOnTitleTagEvent);
    procedure SetOnLinkTagEvent(const Value: TLMDOnLinkTagEvent);
    procedure SetOnAppletTagEvent(const Value: TLMDOnAppletTagEvent);
    procedure SetOnBodyTagEvent(const Value: TLMDOnBodyTagEvent);
    procedure SetOnDivTagEvent(const Value: TLMDOnDivTagEvent);
    procedure SetOnFontTagEvent(const Value: TLMDOnFontTagEvent);
    procedure SetOnFormTagEvent(const Value: TLMDOnFormTagEvent);
    procedure SetOnFrameTagEvent(const Value: TLMDOnFrameTagEvent);
    procedure SetOnFrameSetTagEvent(const Value: TLMDOnFrameSetTagEvent);
    procedure SetOnHeadTagEvent(const Value: TLMDOnHeadTagEvent);
    procedure SetOnIFrameTagEvent(const Value: TLMDOnIFrameTagEvent);
    procedure SetOnUlTagEvent(const Value: TLMDOnUlTagEvent);
    procedure SetOnOlTagEvent(const Value: TLMDOnOlTagEvent);
    procedure SetOnLiTagEvent(const Value: TLMDOnLiTagEvent);
    procedure SetOnMapTagEvent(const Value: TLMDOnMapTagEvent);
    procedure SetOnMetaTagEvent(const Value: TLMDOnMetaTagEvent);
    procedure SetOnObjectTagEvent(const Value: TLMDOnObjectTagEvent);
    procedure SetOnScriptTagEvent(const Value: TLMDOnScriptTagEvent);
    procedure SetOnStyleTagEvent(const Value: TLMDOnStyleTagEvent);
    procedure SetOnTableTagEvent(const Value: TLMDOnTableTagEvent);
    procedure SetOnTrTagEvent(const Value: TLMDOnTrTagEvent);
    procedure SetOnTdTagEvent(const Value: TLMDOnTdTagEvent);
    procedure SetTagCharCase(const Value: TEditCharCase);
    procedure SetOnAfterParse(const Value: TNotifyEvent);
    procedure SetOnBeforeParse(const Value: TNotifyEvent);
  protected
    FLex: TLMDWebHTMLLex;
    FTags: TObjectList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Parse: boolean;
  public
    property TokensCount: integer read GetTG default 0;
    property Token[Index: integer]: TLMDWebToken read GetToken;
  published
    property ReplaceSpecialChars: boolean read FReplaceSpecialChars write
      SetReplaceSpecialChars default True;
    property HTML: TStringList read FHTML write SetHTML;
    property TagCharCase:TEditCharCase read FTagCharCase write SetTagCharCase;

    property OnBeforeParse:TNotifyEvent read FOnBeforeParse write SetOnBeforeParse;
    property OnAfterParse:TNotifyEvent read FOnAfterParse write SetOnAfterParse;
    property OnTagEvent: TLMDOnTagEvent read FOnTagEvent write SetOnTagEvent;
    property OnTextEvent: TLMDOnTextEvent read FOnTextEvent write
      SetOnTextEvent;
    property OnStartTagEvent:TLMDOnTagEvent read FOnStartTagEvent write SetOnStartTagEvent;
    property OnEndTagEvent:TLMDOnEndTagEvent read FOnEndTagEvent write SetOnEndTagEvent;
    property OnImageTagEvent:TLMDOnImageTagEvent read FOnImageTagEvent write SetOnImageTagEvent;
    property OnTitleTagEvent:TLMDOnTitleTagEvent read FOnTitleTagEvent write SetOnTitleTagEvent;
    property OnLinkTagEvent: TLMDOnLinkTagEvent read FOnLinkTagEvent write SetOnLinkTagEvent;
    property OnAppletTagEvent: TLMDOnAppletTagEvent read FOnAppletTagEvent write SetOnAppletTagEvent;
    property OnBodyTagEvent: TLMDOnBodyTagEvent read FOnBodyTagEvent write SetOnBodyTagEvent;
    property OnDivTagEvent: TLMDOnDivTagEvent read FOnDivTagEvent write SetOnDivTagEvent;
    property OnFontTagEvent: TLMDOnFontTagEvent read FOnFontTagEvent write SetOnFontTagEvent;
    property OnFormTagEvent: TLMDOnFormTagEvent read FOnFormTagEvent write SetOnFormTagEvent;
    property OnFrameTagEvent: TLMDOnFrameTagEvent read FOnFrameTagEvent write SetOnFrameTagEvent;
    property OnFrameSetTagEvent: TLMDOnFrameSetTagEvent read FOnFrameSetTagEvent write SetOnFrameSetTagEvent;
    property OnHeadTagEvent: TLMDOnHeadTagEvent read FOnHeadTagEvent write SetOnHeadTagEvent;
    property OnIFrameTagEvent: TLMDOnIFrameTagEvent read FOnIFrameTagEvent write SetOnIFrameTagEvent;
    property OnUlTagEvent: TLMDOnUlTagEvent read FOnUlTagEvent write SetOnUlTagEvent;
    property OnOlTagEvent: TLMDOnOlTagEvent read FOnOlTagEvent write SetOnOlTagEvent;
    property OnLiTagEvent: TLMDOnLiTagEvent read FOnLiTagEvent write SetOnLiTagEvent;
    property OnMapTagEvent: TLMDOnMapTagEvent read FOnMapTagEvent write SetOnMapTagEvent;
    property OnMetaTagEvent: TLMDOnMetaTagEvent read FOnMetaTagEvent write SetOnMetaTagEvent;
    property OnObjectTagEvent: TLMDOnObjectTagEvent read FOnObjectTagEvent write SetOnObjectTagEvent;
    property OnScriptTagEvent: TLMDOnScriptTagEvent read FOnScriptTagEvent write SetOnScriptTagEvent;
    property OnStyleTagEvent: TLMDOnStyleTagEvent read FOnStyleTagEvent write SetOnStyleTagEvent;
    property OnTableTagEvent: TLMDOnTableTagEvent read FOnTableTagEvent write SetOnTableTagEvent;
    property OnTrTagEvent: TLMDOnTrTagEvent read FOnTrTagEvent write SetOnTrTagEvent;
    property OnTdTagEvent: TLMDOnTdTagEvent read FOnTdTagEvent write SetOnTdTagEvent;
  end;

implementation

uses
  SysUtils,
  LMDFSSupport;

{-----------------------------------------------------------------------------}

function GetHTMLInteger(const szInt:String):Integer;
begin
  Result := 0;
  if szInt<>'' then
  begin
    Result :=  StrToIntDef(szInt,0);
  end;
end;

function GetHTMLAlign(const szAlign:String):TLMDWebHTMLAlign;
begin
//  szAlign := UpperCase(szAlign);
  if SameText(szAlign, 'RIGHT') then
    Result := haRight
  else
  if SameText(szAlign, 'TOP') then
    Result := haTop
  else
  if SameText(szAlign, 'MIDDLE') then
    Result := haMiddle
  else
  if SameText(szAlign, 'BOTTOM') then
    Result := haBottom
  else
  if SameText(szAlign, 'ABSBOTTOM') then
    Result := haAbsBottom
  else
  if SameText(szAlign, 'ABSMIDDLE') then
    Result := haAbsMiddle
  else
  if SameText(szAlign, 'BASELINE') then
    Result := haBaseLine
  else
  if SameText(szAlign, 'TEXTTOP') then
    Result := haTextTop
  else
    Result := haLeft;
end;

function GetHTMLVAlign(const szVAlign: String): TLMDWebHTMLVAlign;
begin
//  szVAlign := UpperCase(szVAlign);
  if SameText(szVAlign, 'BOTTOM') then
    Result := vaBottom
  else
  if SameText(szVAlign, 'CENTER') then
    Result := vaCenter
  else
  if SameText(szVAlign, 'TOP') then
    Result := vaTop
  else
    Result := vaBaseLine;
end;

function GetHTMLResize(const szResize: String): TLMDWebHTMLResize;
begin
//  szResize := UpperCase(szResize);
  Result := hrNoResize;
  if SameText(szResize, 'RESIZE') then
    Result := hrResize;
end;

function GetHTMLScrolling(const szScrolling: String): TLMDWebHTMLScrolling;
begin
//  szScrolling := UpperCase(szScrolling);
  if SameText(szScrolling, 'YES') then
    Result := hsYes
  else
  if SameText(szScrolling, 'NO') then
    Result := hsNo
  else
    Result := hsAuto;
end;

function GetHTMLFrameBorder(const szFrameBorder: String):TLMDWebHTMLFrameBorder;
begin
  if SameText(szFrameBorder, 'NO') then
    Result := fbNo
  else
  if szFrameBorder = '0' then
    Result := fb0
  else
  if szFrameBorder = '1' then
    Result := fb1
  else
    Result := fbYes;
end;

function GetHTMLScriptLanguage(const szScriptLanguage: String): TLMDWebHTMLScriptLanguage;
begin
//  szScriptLanguage := UpperCase(szScriptLanguage);
  if SameText(szScriptLanguage, 'JSCRIPT') then
    Result := slJScript
  else
  if SameText(szScriptLanguage, 'VBSCRIPT') then
    Result := slVBScript
  else
    Result := slJavaScript;
end;

function GetHTMLTableFrame(const szTableFrame: String): TLMDWebHTMLTableFrame;
begin
//  szTableFrame := UpperCase(szTableFrame);
  if SameText(szTableFrame, 'BELOW') then
    Result := tfBelow
  else
  if SameText(szTableFrame, 'BOX') then
    Result := tfBox
  else
  if SameText(szTableFrame, 'INSIDES') then
    Result := tfInsides
  else
  if SameText(szTableFrame, 'LHS') then
    Result := tfLHS
  else
  if SameText(szTableFrame, 'RHS') then
    Result := tfRHS
  else
  if SameText(szTableFrame, 'VOID') then
    Result := tfVoid
  else
  if SameText(szTableFrame, 'VSIDES') then
    Result := tfVSides
  else
    Result := tfAbove;
end;

function GetHTMLTableRules(const szTableRules: String): TLMDWebHTMLTableRules;
begin
//  szTableRules := UpperCase(szTableRules);
  if SameText(szTableRules, 'COLS') then
    Result := trCols
  else
  if SameText(szTableRules, 'GROUPS') then
    Result := trGroups
  else
  if SameText(szTableRules, 'NONE') then
    Result := trNone
  else
  if SameText(szTableRules, 'ROWS') then
    Result := trRows
  else
    Result := trAll;
end;

function ReplaceSpecialCharsFunc(const aText: string): string;
const
  spCharsCount = 96;
  spChars: array[0..spCharsCount - 1] of
  record
    spChar: string;
    spRepl: string;
  end = ((spChar: 'nbsp'; spRepl: ' '),
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
    (spChar: 'uacute'; spRepl: #251));
var
  I: longint;
  P: longint;
  S: string;
begin
  Result:= aText;
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
end;

{ **************************TLMDWebHTMLScan**************************** }

{-----------------------------------------------------------------------------}

constructor TLMDWebHTMLScan.Create(AOwner: TComponent);
begin
  inherited;
  FLex:= TLMDWebHTMLLex.Create;
  FHTML:= TStringList.Create;
  FTags:= TObjectList.Create;
  FReplaceSpecialChars:= True;
  FTagCharCase := ecNormal;
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebHTMLScan.Destroy;
begin
  FTags.Free;
  FHTML.Free;
  FLex.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTMLScan.GetTG: integer;
begin
  Result:= FTags.Count;
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTMLScan.GetToken(Index: integer): TLMDWebToken;
begin
  Result:= TLMDWebToken(FTags[Index]);
end;

{-----------------------------------------------------------------------------}

function TLMDWebHTMLScan.Parse: boolean;
type
  TLMDWebScanState = (ssNone, ssScript, ssComment, ssTitle, ssHREF, ssApplet,
                      ssBody, ssForm, ssFrameSet, ssHead, ssUl, ssOl, ssLi,
                      ssMap, ssObject, ssStyle, ssTable, ssLink, ssTr, ssTd);
var
  MS: TMemoryStream;
  T, TOLD: TLMDWebToken;
  iPos, iTextPos: integer;
  szHTML: string;
  szToken,szTmp: string;
  ImageTag : TLMDWebImageTag;
  AppletTag: TLMDWebAppletTag;
  FrameTag: TLMDWebFrameTag;
  FrameSetTag: TLMDWebFrameSetTag;
  FormTag: TLMDWebFormTag;
  IFrameTag: TLMDWebIFrameTag;
  ObjectTag: TLMDWebObjectTag;
  TableTag: TLMDWebTableTag;
  TrTag: TLMDWebTrTag;
  TdTag: TLMDWebTdTag;
  State : TLMDWebScanState;
  iPosTag,
  iPosTagEnd: Integer;
  szURL, szTarget: String;
  ScriptLanguage: TLMDWebHTMLScriptLanguage;
begin
  iPosTagEnd:=0;iPosTag:=0;

  szHTML:= FHTML.Text;
  Result:= szHTML <> '';
  FTags.Clear;
  State := ssNone;
  if Assigned(FOnBeforeParse) then
    FOnBeforeParse(Self);
  if Result then
    begin
      MS:= TMemoryStream.Create;
      try
        LMDWebStringToStream(MS, szHTML);
        MS.Position := 0;
        FLex.SkipSpaces(MS);
        iPos:= MS.Position div SizeOf(Char);
        iTextPos := iPos;
        ScriptLanguage := slJavaScript;
        TOLD := nil;
        T:= FLex.GetToken(MS);
        while T.TokenType <> ttEOF do
          begin
            if (TOLD <> nil) and (TOLD.TokenType = ttText) and (TOLD.TokenType <> T.TokenType) then
              begin
                TOLD.Free;
                szTmp:= Copy(szHTML, (iTextPos + 1), (iPos - iTextPos));
                if FReplaceSpecialChars then
                  szTmp:= ReplaceSpecialCharsFunc(szTmp);
                TOLD:= TLMDWebTextToken.Create(szTmp);
                FTags.Add(TOLD);
                if Assigned(FOnTextEvent) then
                  FOnTextEvent(TLMDWebTextToken(TOLD).TokenText, iTextPos + 1, iPos);
                TOLD:= nil;
              end;
            case T.TokenType of
              ttTag:
                begin
                  szToken := UpperCase(TLMDWebTagToken(T).TokenText);
                  case FTagCharCase of
                    ecUpperCase : TLMDWebTagToken(T).TokenText := szToken;
                    ecLowerCase : TLMDWebTagToken(T).TokenText := LowerCase(TLMDWebTagToken(T).TokenText);
                  end;
                  FTags.Add(T);
                  if Assigned(FOnTagEvent) then
                    FOnTagEvent(TLMDWebTagToken(T).TokenText,
                      TLMDWebTagToken(T).Attributes, iPos, MS.Position);
                  if szToken<>'' then
                  begin
                    if ((szToken = 'LI') or (szToken = '/OL') or (szToken = '/UL'))
                     and (State = ssLi) then
                    begin
                      szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                      if Assigned(FOnLiTagEvent) then
                        FOnLiTagEvent(szTmp, TLMDWebTagToken(T).Attributes,
                         iPosTag, MS.Position);
                    end;
                    if (szToken = 'TD') or (szToken = '/TD') or (szToken = '/TR')
                     and (State = ssTd) then
                    begin
                      szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                      if Assigned(FOnTdTagEvent) then
                        FOnTdTagEvent(szTmp, TdTag, TLMDWebTagToken(T).Attributes,
                         iPosTag, MS.Position);
                    end;
                    if szToken[1]='/' then
                    begin
                      if Assigned(FOnEndTagEvent) then
                        FOnEndTagEvent(TLMDWebTagToken(T).TokenText,
                           iPos, MS.Position);
                      if (szToken='/TITLE') and (State=ssTitle) then
                      begin
                        szTmp := Copy(szHTML,iPosTagEnd,iPos-iPosTagEnd+1);
                        if Assigned(FOnTitleTagEvent) then
                          FOnTitleTagEvent(szTmp,iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/APPLET') and (State = ssApplet) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnAppletTagEvent) then
                          FOnAppletTagEvent(szTmp, AppletTag,
                           TLMDWebTagToken(T).Attributes, iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/BODY') and (State = ssBody) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnBodyTagEvent) then
                          FOnBodyTagEvent(szTmp, iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/FORM') and (State = ssForm) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnFormTagEvent) then
                          FOnFormTagEvent(szTmp, FormTag,
                           TLMDWebTagToken(T).Attributes, iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/FRAMESET') and (State = ssFrameSet) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnFrameSetTagEvent) then
                          FOnFrameSetTagEvent(szTmp, FrameSetTag,
                           TLMDWebTagToken(T).Attributes, iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/HEAD') and (State = ssHead) then
                      begin
                        szTmp := Copy(szHTML,iPosTagEnd,iPos-iPosTagEnd+1);
                        if Assigned(FOnHeadTagEvent) then
                          FOnHeadTagEvent(szTmp, iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/UL') and (State = ssUl) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnUlTagEvent) then
                          FOnUlTagEvent(szTmp, TLMDWebTagToken(T).Attributes,
                           iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/OL') and (State = ssUl) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnOlTagEvent) then
                          FOnOlTagEvent(szTmp, TLMDWebTagToken(T).Attributes,
                           iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/MAP') and (State = ssMap) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnMapTagEvent) then
                          FOnMapTagEvent(szTmp, TLMDWebTagToken(T).Attributes,
                           iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/OBJECT') and (State = ssObject) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnObjectTagEvent) then
                          FOnObjectTagEvent(szTmp, ObjectTag,
                           TLMDWebTagToken(T).Attributes, iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/SCRIPT') and (State = ssScript) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnScriptTagEvent) then
                          FOnScriptTagEvent(szTmp, ScriptLanguage,
                           TLMDWebTagToken(T).Attributes, iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/STYLE') and (State = ssStyle) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnStyleTagEvent) then
                          FOnStyleTagEvent(szTmp, TLMDWebTagToken(T).Attributes,
                           iPosTag, MS.Position);
                      end
                      else
                      if (szToken = '/A') and (State = ssLink) then
                      begin
                        szTmp := Copy(szHTML, iPosTagEnd, iPos - iPosTagEnd + 1);
                        if Assigned(FOnLinkTagEvent) then
                          FOnLinkTagEvent(szURL, szTarget, szTmp, iPos, MS.Position);
                      end;

//                      if not (State in [ssComment,ssScript]) then
                        State := ssNone;
                    end
                    else
                    begin
                      if Assigned(FOnStartTagEvent) then
                        FOnStartTagEvent(TLMDWebTagToken(T).TokenText,
                           TLMDWebTagToken(T).Attributes, iPos, MS.Position);

                      if szToken='IMG' then
                      begin
                        with ImageTag do
                        begin
                          SRC := TLMDWebTagToken(T).Attributes.Values['SRC'];
                          ALT := TLMDWebTagToken(T).Attributes.Values['ALT'];
                          align := GetHTMLAlign(TLMDWebTagToken(T).Attributes.Values['ALIGN']);
                          width := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['WIDTH']);
                          height:= GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['HEIGHT']);
                          border:= GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['BORDER']);
                          vspace:= GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['VSPACE']);
                          hspace:= GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['HSPACE']);
                          usemap:= TLMDWebTagToken(T).Attributes.Values['USEMAP'];
                          ismap := TLMDWebTagToken(T).Attributes.IndexOf('ISMAP')>=0;
                        end;
                        if Assigned(FOnImageTagEvent) then
                          FOnImageTagEvent(ImageTag,TLMDWebTagToken(T).Attributes, iPos, MS.Position);
                      end
                      else
                      if szToken='TITLE' then
                      begin
                        State := ssTitle;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position+1;
                      end
                      else
                      if szToken = 'A' then
                      begin
                        State := ssLink;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position+1;
                        szURL := TLMDWebTagToken(T).Attributes.Values['HREF'];
                        szTarget := TLMDWebTagToken(T).Attributes.Values['TARGET'];
                      end
                      else
                      if szToken = 'APPLET' then
                      begin
                        State := ssApplet;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                        with AppletTag do
                        begin
                          align := GetHTMLAlign(TLMDWebTagToken(T).Attributes.Values['ALIGN']);
                          code := TLMDWebTagToken(T).Attributes.Values['CODE'];
                          codebase := TLMDWebTagToken(T).Attributes.Values['CODEBASE'];
                          dataFld := TLMDWebTagToken(T).Attributes.Values['DATAFLD'];
                          dataSrc := TLMDWebTagToken(T).Attributes.Values['DATASRC'];
                          hspace := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['HSPACE']);
                          vspace := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['VSPACE']);
                          id := TLMDWebTagToken(T).Attributes.Values['ID'];
                          isTextEdit := TLMDWebTagToken(T).Attributes.IndexOf('ISTEXTEDIT') >= 0;
                          name := TLMDWebTagToken(T).Attributes.Values['NAME'];
                          src := TLMDWebTagToken(T).Attributes.Values['SRC'];
                          title := TLMDWebTagToken(T).Attributes.Values['TITLE'];
                        end;
                      end
                      else
                      if szToken = 'BODY' then
                      begin
                        State := ssBody;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                      end
                      else
                      if szToken = 'DIV' then
                      begin
                        if Assigned(FOnDivTagEvent) then
                          FOnDivTagEvent(TLMDWebTagToken(T).Attributes, iPos);
                      end
                      else
                      if szToken = 'FONT' then
                      begin
                        if Assigned(FOnFontTagEvent) then
                          FOnFontTagEvent(TLMDWebTagToken(T).Attributes, iPos);
                      end
                      else
                      if szToken = 'FORM' then
                      begin
                        State := ssForm;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                        with FormTag do
                        begin
                          action := TLMDWebTagToken(T).Attributes.Values['ACTION'];
                          id := TLMDWebTagToken(T).Attributes.Values['ID'];
                          method := TLMDWebTagToken(T).Attributes.Values['METHOD'];
                          name := TLMDWebTagToken(T).Attributes.Values['NAME'];
                          target := TLMDWebTagToken(T).Attributes.Values['TARGET'];
                          title := TLMDWebTagToken(T).Attributes.Values['TITLE'];
                        end;
                      end
                      else
                      if szToken = 'FRAME' then
                      begin
                        with FrameTag do
                        begin
                          borderColor := TLMDWebTagToken(T).Attributes.Values['BORDERCOLOR'];
                          frameBorder := TLMDWebTagToken(T).Attributes.Values['FRAMEBORDER'];
                          height := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['HEIGHT']);
                          id := TLMDWebTagToken(T).Attributes.Values['ID'];
                          marginHeight := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['MARGINHEIGHT']);
                          marginWidth := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['MARGINWIDTH']);
                          name := TLMDWebTagToken(T).Attributes.Values['NAME'];
                          noResize := GetHTMLResize(TLMDWebTagToken(T).Attributes.Values['NORESIZE']);
                          scrolling := GetHTMLScrolling(TLMDWebTagToken(T).Attributes.Values['SCROLLING']);
                          src := TLMDWebTagToken(T).Attributes.Values['SRC'];
                        end;
                        if Assigned(FOnFrameTagEvent) then
                          FOnFrameTagEvent(FrameTag, TLMDWebTagToken(T).Attributes, iPos, MS.Position);
                      end
                      else
                      if szToken = 'FRAMESET' then
                      begin
                        State := ssFrameSet;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                        with FrameSetTag do
                        begin
                          border := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['BORDER']);
                          borderColor := TLMDWebTagToken(T).Attributes.Values['BORDERCOLOR'];
                          cols := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['COLS']);
                          frameBorder := GetHTMLFrameBorder(TLMDWebTagToken(T).Attributes.Values['FRAMEBORDER']);
                          frameSpacing := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['FRAMESPACING']);
                          id := TLMDWebTagToken(T).Attributes.Values['ID'];
                          rows := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['ROWS']);
                        end;
                      end
                      else
                      if szToken = 'HEAD' then
                      begin
                        State := ssHead;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position+1;
                      end
                      else
                      if szToken = 'IFRAME' then
                      begin
                        with IFrameTag do
                        begin
                          align := GetHTMLAlign(TLMDWebTagToken(T).Attributes.Values['ALIGN']);
                          border := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['BORDER']);
                          borderColor := TLMDWebTagToken(T).Attributes.Values['BORDERCOLOR'];
                          frameBorder := GetHTMLFrameBorder(TLMDWebTagToken(T).Attributes.Values['FRAMEBORDER']);
                          frameSpacing := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['FRAMESPACING']);
                          height := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['HEIGHT']);
                          hspace := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['HSPACE']);
                          id := TLMDWebTagToken(T).Attributes.Values['ID'];
                          noResize := GetHTMLResize(TLMDWebTagToken(T).Attributes.Values['NORESIZE']);
                          scrolling := GetHTMLScrolling(TLMDWebTagToken(T).Attributes.Values['SCROLLING']);
                          src := TLMDWebTagToken(T).Attributes.Values['SRC'];
                          vspace := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['VSPACE']);
                          width := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['WIDTH']);
                        end;
                        if Assigned(FOnIFrameTagEvent) then
                          FOnIFrameTagEvent(IFrameTag, TLMDWebTagToken(T).Attributes, iPos);
                      end
                      else
                      if szToken = 'UL' then
                      begin
                        State := ssUl;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                      end
                      else
                      if szToken = 'OL' then
                      begin
                        State := ssOl;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                      end
                      else
                      if szToken = 'LI' then
                      begin
                        State := ssLi;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                      end
                      else
                      if szToken = 'MAP' then
                      begin
                        State := ssMap;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                      end
                      else
                      if szToken = 'META' then
                      begin
                        if Assigned(FOnMetaTagEvent) then
                          FOnMetaTagEvent(TLMDWebTagToken(T).Attributes, iPos, MS.Position);
                      end
                      else
                      if szToken = 'OBJECT' then
                      begin
                        State := ssObject;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                        with ObjectTag do
                        begin
                          align := GetHTMLAlign(TLMDWebTagToken(T).Attributes.Values['ALIGN']);
                          code := TLMDWebTagToken(T).Attributes.Values['CODE'];
                          codebase := TLMDWebTagToken(T).Attributes.Values['CODEBASE'];
                          dataFld := TLMDWebTagToken(T).Attributes.Values['DATAFLD'];
                          data := TLMDWebTagToken(T).Attributes.Values['DATA'];
                          dataSrc := TLMDWebTagToken(T).Attributes.Values['DATASRC'];
                          disabled := UpperCase(TLMDWebTagToken(T).Attributes.Values['DISABLED']) = 'DISABLED';
                          height := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['HEIGHT']);
                          id := TLMDWebTagToken(T).Attributes.Values['ID'];
                          isTextEdit := TLMDWebTagToken(T).Attributes.IndexOf('ISTEXTEDIT') >= 0;
                          name := TLMDWebTagToken(T).Attributes.Values['NAME'];
                          title := TLMDWebTagToken(T).Attributes.Values['TITLE'];
                          type_ := TLMDWebTagToken(T).Attributes.Values['TYPE'];
                          width := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['WIDTH']);
                        end;
                      end
                      else
                      if szToken = 'SCRIPT' then
                      begin
                        State := ssScript;
                        iPosTag := iPos;
                        iPosTagEnd := (MS.Position div SizeOf(Char)) + 1;
                        ScriptLanguage := GetHTMLScriptLanguage(TLMDWebTagToken(T).Attributes.Values['LANGUAGE']);
                      end
                      else
                      if szToken = 'STYLE' then
                      begin
                        State := ssStyle;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                      end
                      else
                      if szToken = 'TABLE' then
                      begin
                        with TableTag do
                        begin
                          align := GetHTMLAlign(TLMDWebTagToken(T).Attributes.Values['ALIGN']);
                          background := TLMDWebTagToken(T).Attributes.Values['BACKGROUND'];
                          bgColor := TLMDWebTagToken(T).Attributes.Values['BGCOLOR'];
                          border := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['BORDER']);
                          borderColor := TLMDWebTagToken(T).Attributes.Values['BORDERCOLOR'];
                          borderColorDark := TLMDWebTagToken(T).Attributes.Values['BORDERCOLORDARK'];
                          borderColorLight := TLMDWebTagToken(T).Attributes.Values['BORDERCOLORLIGHT'];
                          cellPadding := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['CELLPADDING']);
                          cellSpacing := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['CELLSPACING']);
                          cols := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['COLS']);
                          frame := GetHTMLTableFrame(TLMDWebTagToken(T).Attributes.Values['FRAME']);
                          height := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['HEIGHT']);
                          id := TLMDWebTagToken(T).Attributes.Values['ID'];
                          rules := GetHTMLTableRules(TLMDWebTagToken(T).Attributes.Values['RULES']);
                          scrollHeight := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['SCROLLHEIGHT']);
                          scrollLeft := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['SCROLLLEFT']);
                          scrollTop := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['SCROLLTOP']);
                          scrollWidth := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['SCROLLWIDTH']);
                          style := TLMDWebTagToken(T).Attributes.Values['STYLE'];
                          title := TLMDWebTagToken(T).Attributes.Values['TITLE'];
                          width := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['WIDTH']);
                        end;
                        if Assigned(FOnTableTagEvent) then
                          FOnTableTagEvent(TableTag, TLMDWebTagToken(T).Attributes, iPos);
                      end
                      else
                      if szToken = 'TR' then
                      begin
                        with TrTag do
                        begin
                          align := GetHTMLAlign(TLMDWebTagToken(T).Attributes.Values['ALIGN']);
                          bgColor := TLMDWebTagToken(T).Attributes.Values['BGCOLOR'];
                          borderColor := TLMDWebTagToken(T).Attributes.Values['BORDERCOLOR'];
                          borderColorDark := TLMDWebTagToken(T).Attributes.Values['BORDERCOLORDARK'];
                          borderColorLight := TLMDWebTagToken(T).Attributes.Values['BORDERCOLORLIGHT'];
                          style := TLMDWebTagToken(T).Attributes.Values['STYLE'];
                          title := TLMDWebTagToken(T).Attributes.Values['TITLE'];
                          valign := GetHTMLVAlign(TLMDWebTagToken(T).Attributes.Values['VALIGN']);
                        end;
                        if Assigned(FOnTrTagEvent) then
                          FOnTrTagEvent(TrTag, TLMDWebTagToken(T).Attributes, iPos);
                      end
                      else
                      if szToken = 'TD' then
                      begin
                        State := ssTd;
                        iPosTag := iPos;
                        iPosTagEnd := MS.Position + 1;
                        with TdTag do
                        begin
                          align := GetHTMLAlign(TLMDWebTagToken(T).Attributes.Values['ALIGN']);
                          background := TLMDWebTagToken(T).Attributes.Values['BACKGROUND'];
                          bgColor := TLMDWebTagToken(T).Attributes.Values['BGCOLOR'];
                          borderColor := TLMDWebTagToken(T).Attributes.Values['BORDERCOLOR'];
                          borderColorDark := TLMDWebTagToken(T).Attributes.Values['BORDERCOLORDARK'];
                          borderColorLight := TLMDWebTagToken(T).Attributes.Values['BORDERCOLORLIGHT'];
                          colSpan := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['COLSPAN']);
                          height := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['HEIGHT']);
                          id := TLMDWebTagToken(T).Attributes.Values['ID'];
                          noWrap := UpperCase(TLMDWebTagToken(T).Attributes.Values['NOWRAP']) = 'NOWRAP';
                          rowSpan := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['ROWSPAN']);
                          style := TLMDWebTagToken(T).Attributes.Values['ID'];
                          title := TLMDWebTagToken(T).Attributes.Values['TITLE'];
                          valign := GetHTMLVAlign(TLMDWebTagToken(T).Attributes.Values['VALIGN']);
                          width := GetHTMLInteger(TLMDWebTagToken(T).Attributes.Values['WIDTH']);
                        end;
                      end
                    end;
                  end;
                end;
              ttText:
                begin
                  if (TOLD <> nil) and (TOLD.TokenType = ttText) then
                    begin
                      TOLD.Free;
                    end
                  else
                    iTextPos:= iPos;
                end;
            else
              FTags.Add(T);
            end;
            iPos := MS.Position div SizeOf(Char);
            TOLD:= T;
            T:= FLex.GetToken(MS);
          end;
          if (T.TokenType = ttEOF) then
            T.Free;
      finally
        MS.Free;
      end;
    end;
  if Assigned(FOnAfterParse) then
    FOnAfterParse(Self);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTMLScan.SetHTML(const Value: TStringList);
begin
  FHTML.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTMLScan.SetOnStartTagEvent(
  const Value: TLMDOnTagEvent);
begin
  FOnStartTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnEndTagEvent(
  const Value: TLMDOnEndTagEvent);
begin
  FOnEndTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnTagEvent(const Value: TLMDOnTagEvent);
begin
  FOnTagEvent:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTMLScan.SetOnTextEvent(const Value: TLMDOnTextEvent);
begin
  FOnTextEvent:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebHTMLScan.SetReplaceSpecialChars(const Value: boolean);
begin
  FReplaceSpecialChars:= Value;
end;
procedure TLMDWebHTMLScan.SetOnImageTagEvent(
  const Value: TLMDOnImageTagEvent);
begin
  FOnImageTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnTitleTagEvent(
  const Value: TLMDOnTitleTagEvent);
begin
  FOnTitleTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnLinkTagEvent(const Value: TLMDOnLinkTagEvent);
begin
  FOnLinkTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnAppletTagEvent(const Value: TLMDOnAppletTagEvent);
begin
  FOnAppletTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnBodyTagEvent(const Value: TLMDOnBodyTagEvent);
begin
  FOnBodyTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnDivTagEvent(const Value: TLMDOnDivTagEvent);
begin
  FOnDivTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnFontTagEvent(const Value: TLMDOnFontTagEvent);
begin
  FOnFontTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnFormTagEvent(const Value: TLMDOnFormTagEvent);
begin
  FOnFormTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnFrameTagEvent(const Value: TLMDOnFrameTagEvent);
begin
  FOnFrameTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnFrameSetTagEvent(const Value: TLMDOnFrameSetTagEvent);
begin
  FOnFrameSetTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnHeadTagEvent(const Value: TLMDOnHeadTagEvent);
begin
  FOnHeadTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnIFrameTagEvent(const Value: TLMDOnIFrameTagEvent);
begin
  FOnIFrameTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnUlTagEvent(const Value: TLMDOnUlTagEvent);
begin
  FOnUlTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnOlTagEvent(const Value: TLMDOnOlTagEvent);
begin
  FOnOlTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnLiTagEvent(const Value: TLMDOnLiTagEvent);
begin
  FOnLiTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnMapTagEvent(const Value: TLMDOnMapTagEvent);
begin
  FOnMapTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnMetaTagEvent(const Value: TLMDOnMetaTagEvent);
begin
  FOnMetaTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnObjectTagEvent(const Value: TLMDOnObjectTagEvent);
begin
  FOnObjectTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnScriptTagEvent(const Value: TLMDOnScriptTagEvent);
begin
  FOnScriptTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnStyleTagEvent(const Value: TLMDOnStyleTagEvent);
begin
  FOnStyleTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnTableTagEvent(const Value: TLMDOnTableTagEvent);
begin
  FOnTableTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnTrTagEvent(const Value: TLMDOnTrTagEvent);
begin
  FOnTrTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetOnTdTagEvent(const Value: TLMDOnTdTagEvent);
begin
  FOnTdTagEvent := Value;
end;

procedure TLMDWebHTMLScan.SetTagCharCase(const Value: TEditCharCase);
begin
  FTagCharCase := Value;
end;

procedure TLMDWebHTMLScan.SetOnAfterParse(const Value: TNotifyEvent);
begin
  FOnAfterParse := Value;
end;

procedure TLMDWebHTMLScan.SetOnBeforeParse(const Value: TNotifyEvent);
begin
  FOnBeforeParse := Value;
end;

end.
