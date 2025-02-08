unit LMDMlGen;
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

LMDMlGen unit (MC, AH)
----------------------
Markup Language Generator, used with permission of author - Mikhail Chernyshev

Changes
-------
Release 8.0 (2007)
 - Initial Release

###############################################################################}

{*******************************************************}
{                                                       }
{  Markup Language Generator (MlGen)                    }
{                                                       }
{  Full Version 2.0.4                                   }
{                                                       }
{  Copyright (c) 1999-2009 Mikhail Chernyshev           }
{                                                       }
{*******************************************************}

{$ifdef ELMLGEN_ACTIVEX}
{$R LMDMLGen.dcr}
{$endif}
{$define INC_SyntaxCheck}

(* Language description

Template parameters.
<params>
  <param name="Param_Name" value="ParamValue"/>
  <param name="Param_Name">ParamValue</param>
  <param name="Param_Name" value="ParamVa">lue</param>
  <translation name="Translation_Table_Name" default="template|macro|all">
    <replace string="string1" with="string2"/>
    <replace string="string1">string2</replace>
    <replace string="string1" with="stri">ng2</replace>
  </translation name="Translation_Table_Name">
</params>

Loops.
<repeat name="loop name">
</repeat name="loop name">

Macros. Tag is completely replaced.
<macro name="macro name"/>

Conditions. Either first or second part of the comlex tag is executed.
<if name="condition name">
<else name="condition name"/>
</if name="condition name">

Comments:
<comment name="any_name">
</comment name="any_name">
or
<comment name="any_name"/>

If the line doesn't contain anything except spaces and macros which turns into empty space,
empty line will not be generated.

*)

interface

uses
  SysUtils,
  {$ifdef ELMLGEN_ACTIVEX}Windows, Messages, Forms, Controls, Graphics, {$endif}
  LMDTypes, LMDCustomComponent, Classes;

type
  TLMDMlStringsRec = record
    ValueName: string;
    Value: string;
    UserObject: TObject;
  end;

  TLMDMlArrayOfStringsRec = array of TLMDMlStringsRec;

  TLMDTranslationTable = class;
  TLMDStringParameters = class;
  TLMDBaseMLGen = class;

  TLMDMlPageEvent = procedure (Sender: TObject; PageNumb : integer) of object;
  TLMDMlIfFoundEvent = procedure (Sender: TObject; IfName : string; TagParameters
          : TLMDStringParameters; var ResultValue : boolean) of object;
  TLMDMlLoopIterateEvent = procedure (Sender: TObject; LoopNumb : integer;
          LoopName : string; TagParameters : TLMDStringParameters; var LoopDone :
          boolean) of object;
  TLMDMlMacroFoundEvent = procedure (Sender: TObject; MacroName : string;
          TagParameters : TLMDStringParameters; var MacroResult : string; var
          UseTranslationTable : boolean) of object;

  TLMDMlCodeFoundEvent = procedure (Sender: TObject; CodeName: string;
                        TagParameters: TLMDStringParameters;
                        ClosedTag: Boolean; Code: TStringList; var CodeResult: string;
                        var UseTranslationTable: boolean) of object;

  TLMDMlWriteStringEvent = procedure (Sender: TObject; Value : string) of object;
  TLMDMlTagFoundEvent = procedure (Sender: TObject; Tag : string; const TagClosed
          : boolean; TagParameters : TLMDStringParameters) of object;
  TLMDMlIsTagEvent = procedure (Sender: TObject; TagName : string; var IsTag :
          boolean) of object;
  TLMDMlIsTagValidEvent = procedure (Sender: TObject; aName : string;
          TagParameters : TLMDStringParameters; var Result : boolean) of object;
  TLMDMLTemplateNeededEvent = procedure (Sender: TObject; TemplateName : string;
          TagParameters : TLMDStringParameters; var Result : string) of object;
  TLMDMlObjectNotifyEvent = procedure (Sender: TObject; Value : TObject) of object;

  TLMDMLGenSession = class(TPersistent)
  private
    FBlockName: string;
    FBlocks: TLMDStringParameters;
    FChildSession: TLMDMLGenSession;
    FCommentName: string;
    FCodeName: string;
    FCodeBegin: Integer;
    FCodeParams: TLMDStringParameters;
    FIfNames: array of string;
    {{
    Position to Loops begin
    }
    FLoopBeginPos: array of integer;
    {{
    Position to Loops begin
    }
    FLoopBeginPosRzrv: array of integer;
    {{
    If string isn't empty, it means, that we skip all until loop end
    }
    FLoopBreak: string;
    {{
    Loops counters
    }
    FLoopCounters: array of integer;
    {{
    Loops counters
    }
    FLoopCountersCurrentPage: array of integer;
    {{
    Loops counters
    }
    FLoopCountersRzrv: array of integer;
    FLoopNames: array of string;
    FLoopNamesRzrv: array of string;
    {{
    Position of Loop begin in text
    }
    FLoopParamsBeginPos: array of integer;
    FName: string;
    FOwner: TLMDBaseMLGen;
    FParentSession: TLMDMLGenSession;
    FSessionExecuting: Boolean;
    {{
    For case when we have two 'if' with same name
    }
    FSkipIfsDownToIndex: Integer;
    FSource: string;
    FSrcPos: Integer;
    FTagParameters: TLMDStringParameters;
    FTemplate: TStrings;
    procedure CheckEndPos;
    function DoBlockBegin: Boolean;
    function DoBlockEnd: Boolean;
    function DoCodeBegin(APreparePass: Boolean = False): Boolean;
    procedure DoCodeEnd(APreparePass: Boolean = False);
    function DoCommentBegin: Boolean;
    function DoCommentEnd: Boolean;
    {{
    Returns true if found tag is the ending of the
    last IF being handled.
    }
    function DoIfDone: Boolean;
    function DoIfElse(const LastResult : boolean): Boolean;
    function DoIfFound(CallUserEvent : boolean): Boolean;
    function DoIsTag(const TagName : string): Boolean;
    {{
    Parses tag of the macro. SrcPos variable value must be set to point to the beginning '<macro'
    before method is called. After method call, SrcPos bust be set to point to the next symbol
    after '>'.
    }
    function DoMacroFound: string;
    function DoParamBegin(var ParamName : string; var ParamNumb : integer):
            Boolean;
    procedure DoParamEnd;
    function DoParamsBegin: Boolean;
    procedure DoParamsEnd;
    procedure DoProcess;
    procedure DoRepeatBegin;
    procedure DoRepeatDone;
    function DoRepeatSkipDone: Boolean;
    function DoReplaceBegin(var ParamName : string; var ParamNumb : integer):
            Boolean;
    procedure DoReplaceEnd;
    procedure DoTagFound(TagName : string);
    procedure DoTranslationBegin(var TableName : string);
    procedure DoTranslationEnd(var TableName : string);
    procedure DoWriteInterval(const AInterval: string);
    procedure FreeArrays;
    procedure FreeRzrvArrays;
    {{
    It is assumed that we are within the tag, and we have to parse what parameters
    the tag has. If no parameters found, then we return empty string values.
    }
    procedure GetTagProp(var ClosedTag: boolean; TagOptions: TLMDStringParameters);
    procedure PrepareTemplate;
    procedure SetTemplate(Value: TStrings);
    procedure StartSession(const TemplateName, BlockName, TemplateText: string);
    procedure TemplateChanged(Sender: TObject);
  protected
    function GetLoopIndex(const LoopName : string): Integer;
  public
    constructor Create(aOwner : TLMDBaseMLGen; aParentSession : TLMDMLGenSession;
            const aName : string);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    {{
    Starts template processing.
    }
    procedure Execute; virtual;
    procedure ExecuteEx(BlockName : string); virtual;
    property ChildSession: TLMDMLGenSession read FChildSession;
    property Name: string read FName;
    property Owner: TLMDBaseMLGen read FOwner;
    property ParentSession: TLMDMLGenSession read FParentSession;
    property Template: TStrings read FTemplate write SetTemplate;
  end;

  TLMDStringParameters = class(TPersistent)
  private
    FData: TLMDMlArrayOfStringsRec;
    FOnObjectRemove: TLMDMlObjectNotifyEvent;
    procedure BeforeDataClear;
    function GetanObject(Index: Integer): TObject;
    function GetanObjectByName(ValueName : string): TObject;
    function GetCount: Integer;
    function GetValue(Index: Integer): string;
    function GetValueByName(ValueName : string): string;
    function GetValueName(Index: Integer): string;
    procedure SetanObject(Index: Integer; const Value: TObject);
    procedure SetanObjectByName(ValueName : string; const Value: TObject);
    procedure SetValue(Index: Integer; const Value: string);
    procedure SetValueByName(ValueName : string; const Value: string);
    procedure SetValueName(Index: Integer; const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    function AddValue(const aValueName, aValue : string; anObject1 : TObject): Integer;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure Clear;
    function FindItemByName(ValueName : string): Integer;
    procedure GetNames(Strings : TStrings);
    function GetValueByNameEx(ValueName, DefaultValue : string): string;
    procedure RemoveValue(const Index : integer);
    procedure RemoveValueByName(const aValueName : string);
    procedure ReplaceValue(Index : integer; const aValue : string);
    function ReplaceValueByName(const aValueName, aValue : string): Integer;
    property UserObject[Index: Integer]: TObject read GetanObject write
            SetanObject;
    property anObjectByName[ValueName : string]: TObject read GetanObjectByName
            write SetanObjectByName;
    property Count: Integer read GetCount;
    property Data: TLMDMlArrayOfStringsRec read FData;
    property OnObjectRemove: TLMDMlObjectNotifyEvent read FOnObjectRemove write
            FOnObjectRemove;
    property Value[Index: Integer]: string read GetValue write SetValue;
    property ValueByName[ValueName : string]: string read GetValueByName write
            SetValueByName;
    property ValueName[Index: Integer]: string read GetValueName write
            SetValueName;
  end;

  TLMDTranslationTables = class(TCollection)
  private
    FDefaultForMacro: Integer;
    FDefaultForTemplate: Integer;
    FDefaultForCode: Integer;
    function GetItems(Index: Integer): TLMDTranslationTable;
    procedure SetDefaultForMacro(Value: Integer);
    procedure SetDefaultForTemplate(Value: Integer);
    procedure SetItems(Index: Integer; Value: TLMDTranslationTable);
    procedure SetDefaultForCode(const Value: Integer);
  public
    constructor Create;
    function Add(const TableName : string): TLMDTranslationTable;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function FindTableByName(const TableName : string): Integer;
    procedure GetTableNames(Strings : TStrings);
    property DefaultForCode: Integer read FDefaultForCode write SetDefaultForCode;
    property DefaultForMacro: Integer read FDefaultForMacro write
            SetDefaultForMacro;
    property DefaultForTemplate: Integer read FDefaultForTemplate write
            SetDefaultForTemplate;
    property Items[Index: Integer]: TLMDTranslationTable read GetItems write
            SetItems; default;
  end;

  TLMDTranslationTable = class(TCollectionItem)
  private
    FName: string;
    FTable: TLMDStringParameters;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Translate(Source : string): string;
    property Name: string read FName write FName;
    property Table: TLMDStringParameters read FTable;
  end;

  {$ifdef ELMLGEN_ACTIVEX}
  TLMDBaseMLGen = class (TCustomControl, ILMDComponent)
  {$else}
  TLMDBaseMLGen = class (TLMDCustomComponent)
  {$endif}
  private
    FCancelJob: Boolean;
    FCode: TStrings;
    FCurrentSession: TLMDMLGenSession;
    FCustomTagNames: TStrings;
    {{
    This flag is set to true when next output file is being open;
    Further this flag is set to false when a point is found from where the command
    for opening a new file was called.
    This point is assumed to be found when the last iteration where opening of the
    next file was demanded is found.  If there were no loops at this moment,
    then the flag will be set to false immediately when output file is open.
    }
    FEnteringInNextPage: Boolean;
    FExecuting: Boolean;
{$ifdef ELMLGEN_ACTIVEX}
    FIcon: TBitmap;
{$endif}
    FNewPageProcessing: Boolean;
    FPageCount: Integer;
    FParameters: TLMDStringParameters;
    FRootSession: TLMDMLGenSession;
    {{
    Controls Execute method. If set to true, the Execute method checks template syntax,
    otherwise Execute runs normally.
    }
    FSyntaxCheck: Boolean;
    FTagPrefix: string;
    {{
    Is used while parsing template parameters.
    }
    FTranslationTable: TLMDTranslationTable;
    FTranslationTables: TLMDTranslationTables;
    procedure DoNextPage;
    function GetBlocks: TLMDStringParameters;
    function GetLoopCount: Integer;
    function GetLoopCounter(Index: Integer): Integer;
    function GetLoopCountersCurrentPage(Index: Integer): Integer;
    function GetLoopCountersCurrentPageStr(LoopName : string): Integer;
    function GetLoopCounterStr(LoopName : string): Integer;
    function GetLoopName(Index: Integer): string;
    function GetTemplate: TStrings;
    procedure SetCustomTagNames(Value: TStrings);
    procedure SetTagPrefix(const Value: string);
    procedure SetTemplate(Value: TStrings);
  protected
    procedure AfterExecute; virtual; abstract;
    procedure BeforeExecute; virtual; abstract;
    {{
    Calculates the part to be processed
    }
    procedure IfFound(IfName : string; TagParameters : TLMDStringParameters; var
            ResultValue : boolean); virtual; abstract;
    procedure IsIfValid(aName : string; TagParameters : TLMDStringParameters; var
            Result : boolean); virtual;
    procedure IsLoopValid(aName : string; TagParameters : TLMDStringParameters;
            var Result : boolean); virtual;
    procedure IsMacroValid(aName : string; TagParameters : TLMDStringParameters;
            var Result : boolean); virtual;
    procedure IsTag(TagName : string; var IsTag : boolean); virtual;
    {{
    One of the loops starts new iteration. The user can interrupt loop execution
    }
    procedure LoopIteration(LoopNumb: integer; LoopName: string; TagParameters
            : TLMDStringParameters; var LoopDone : boolean); virtual; abstract;
    {{
    Code detected
    }
    procedure CodeFound(CodeName: string; TagParameters: TLMDStringParameters;
                        ClosedTag: Boolean; Code: TStringList; var CodeResult: string;
                        var UseTranslationTable: boolean); virtual; abstract;
    {{
    Macro detected
    }
    procedure MacroFound(MacroName : string; TagParameters : TLMDStringParameters;
            var MacroResult : string; var UseTranslationTable : boolean);
            virtual; abstract;
    procedure PageBegin(PageNumb : integer); virtual; abstract;
    procedure PageEnd(PageNumb : integer); virtual; abstract;
    procedure ProcessMessages; virtual;
    procedure TagFound(Tag : string; const TagClosed : boolean; TagParameters :
            TLMDStringParameters); virtual;
    procedure TemplateNeeded(TemplateName : string; TagParameters :
            TLMDStringParameters; var Result : string); virtual;
    procedure WriteString(Value : string); virtual; abstract;
    property CurrentSession: TLMDMLGenSession read FCurrentSession;
    property RootSession: TLMDMLGenSession read FRootSession;
{$ifdef ELMLGEN_ACTIVEX}
    procedure Paint; override;
    procedure Resize; override;
{$endif}
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateFrom(AOwner: TLMDBaseMLGen);
    destructor Destroy; override;
    procedure Init; virtual;
    procedure Abort; virtual;
    procedure Assign(Source: TPersistent); override;
    {{
    Starts template processing.
    }
    procedure Execute; virtual;
    procedure ExecuteEx(BlockName : string); virtual;
    function GetLoopIndex(const LoopName : string): Integer;
    procedure LoopBreak(LoopName : string);
    procedure LoopContinue(LoopName : string);
    procedure NextPage;
    procedure SyntaxCheck; virtual;
    property Blocks: TLMDStringParameters read GetBlocks;
    property Code: TStrings read FCode;
    property CustomTagNames: TStrings read FCustomTagNames write
            SetCustomTagNames;
    property Executing: Boolean read FExecuting;
    {{
    The number of loops that we are currently "in"
    }
    property LoopCount: Integer read GetLoopCount;
    {{
    Provides access to loop iteration counters. The oughtermost loop has index
    0.
    }
    property LoopCounter[Index: Integer]: Integer read GetLoopCounter;
    {{
    Provides access to loop iteration counters that count iterations on the
    current page. The oughtermost loop has index 0.
    }
    property LoopCountersCurrentPage[Index: Integer]: Integer read
            GetLoopCountersCurrentPage;
    property LoopCountersCurrentPageStr[LoopName : string]: Integer read
            GetLoopCountersCurrentPageStr;
    property LoopCounterStr[LoopName : string]: Integer read GetLoopCounterStr;
    property LoopName[Index: Integer]: string read GetLoopName;
    property PageCount: Integer read FPageCount;
    property Parameters: TLMDStringParameters read FParameters;
    property TagPrefix: string read FTagPrefix write SetTagPrefix;
    property Template: TStrings read GetTemplate write SetTemplate;
    property TranslationTables: TLMDTranslationTables read FTranslationTables;
  end;

  TLMDCustomMLGen = class(TLMDBaseMLGen)
  private
    FOnAfterExecute: TNotifyEvent;
    FOnBeforeExecute: TNotifyEvent;
    FOnIfFound: TLMDMlIfFoundEvent;
    FOnIsIfValid: TLMDMlIsTagValidEvent;
    FOnIsLoopValid: TLMDMlIsTagValidEvent;
    FOnIsMacroValid: TLMDMlIsTagValidEvent;
    FOnIsTag: TLMDMlIsTagEvent;
    FOnLoopIteration: TLMDMlLoopIterateEvent;
    FOnCodeFound: TLMDMlCodeFoundEvent;
    FOnMacroFound: TLMDMlMacroFoundEvent;
    FOnPageBegin: TLMDMlPageEvent;
    FOnPageEnd: TLMDMlPageEvent;
    FOnProcessMessages: TNotifyEvent;
    FOnTagFound: TLMDMlTagFoundEvent;
    FOnTemplateNeeded: TLMDMLTemplateNeededEvent;
    FOnWriteString: TLMDMlWriteStringEvent;
  protected
    procedure AfterExecute; override;
    procedure BeforeExecute; override;
    procedure IfFound(IfName : string; TagParameters : TLMDStringParameters; var
            ResultValue : boolean); override;
    procedure IsIfValid(aName : string; TagParameters : TLMDStringParameters; var
            Result : boolean); override;
    procedure IsLoopValid(aName : string; TagParameters : TLMDStringParameters;
            var Result : boolean); override;
    procedure IsMacroValid(aName : string; TagParameters : TLMDStringParameters;
            var Result : boolean); override;
    procedure IsTag(TagName : string; var IsTag : boolean); override;
    procedure LoopIteration(LoopNumb: integer; LoopName: string; TagParameters
            : TLMDStringParameters; var LoopDone : boolean); override;

    procedure CodeFound(CodeName: string; TagParameters: TLMDStringParameters;
                        ClosedTag: Boolean; Code: TStringList; var CodeResult: string;
                        var UseTranslationTable: boolean); override;

    procedure MacroFound(MacroName : string; TagParameters : TLMDStringParameters;
            var MacroResult : string; var UseTranslationTable : boolean);
            override;

    procedure PageBegin(PageNumb : integer); override;
    procedure PageEnd(PageNumb : integer); override;
    procedure ProcessMessages; override;
    procedure TagFound(Tag : string; const TagClosed : boolean; TagParameters :
            TLMDStringParameters); override;
    procedure TemplateNeeded(TemplateName : string; TagParameters :
            TLMDStringParameters; var Result : string); override;
    procedure WriteString(Value : string); override;
    property OnAfterExecute: TNotifyEvent read FOnAfterExecute write
            FOnAfterExecute;
    property OnBeforeExecute: TNotifyEvent read FOnBeforeExecute write
            FOnBeforeExecute;
    property OnIfFound: TLMDMlIfFoundEvent read FOnIfFound write FOnIfFound;
    property OnIsIfValid: TLMDMlIsTagValidEvent read FOnIsIfValid write
            FOnIsIfValid;
    property OnIsLoopValid: TLMDMlIsTagValidEvent read FOnIsLoopValid write
            FOnIsLoopValid;
    property OnIsMacroValid: TLMDMlIsTagValidEvent read FOnIsMacroValid write
            FOnIsMacroValid;
    property OnIsTag: TLMDMlIsTagEvent read FOnIsTag write FOnIsTag;
    property OnLoopIteration: TLMDMlLoopIterateEvent read FOnLoopIteration write
            FOnLoopIteration;
    property OnCodeFound: TLMDMlCodeFoundEvent read FOnCodeFound write FOnCodeFound;
    property OnMacroFound: TLMDMlMacroFoundEvent read FOnMacroFound write
            FOnMacroFound;
    property OnPageBegin: TLMDMlPageEvent read FOnPageBegin write FOnPageBegin;
    property OnPageEnd: TLMDMlPageEvent read FOnPageEnd write FOnPageEnd;
    property OnProcessMessages: TNotifyEvent read FOnProcessMessages write
            FOnProcessMessages;
    property OnTagFound: TLMDMlTagFoundEvent read FOnTagFound write FOnTagFound;
    property OnTemplateNeeded: TLMDMLTemplateNeededEvent read FOnTemplateNeeded
            write FOnTemplateNeeded;
    property OnWriteString: TLMDMlWriteStringEvent read FOnWriteString write
            FOnWriteString;
  end;

  TLMDMLGen = class(TLMDCustomMLGen)
  published
    property About;
    property CustomTagNames;
    property OnAfterExecute;
    property OnBeforeExecute;
    property OnIfFound;
    property OnIsIfValid;
    property OnIsLoopValid;
    property OnIsMacroValid;
    property OnIsTag;
    property OnLoopIteration;
    property OnCodeFound;
    property OnMacroFound;
    property OnPageBegin;
    property OnPageEnd;
    property OnProcessMessages;
    property OnTagFound;
    property OnTemplateNeeded;
    property OnWriteString;
    property TagPrefix;
    property Template;
  end;

  ELMDMlGenException = class(Exception)
  private
    FMlGen: TLMDBaseMLGen;
  public
    constructor Create(MlGen : TLMDBaseMLGen; Msg: string);
    property MlGen: TLMDBaseMLGen read FMlGen;
  end;

{$ifndef HAS_ALSTRTOOLS}
function CheckPath (InpPath : string; IsPath : boolean) : string;
function SetStrWidth(Value : string; Width : integer) : string;
function GetWordEx(S : string; var CharNumb : integer; Breaks : TSysCharSet) : string;
function GetPosOfNewString(const Value : string; CurPos : Integer) : Integer;
procedure GetTextLineByStringPos(const Value : string; ValuePos: integer; var Line,
  CharPos: Integer);
function PosEx(const substr : String; const s : String; EndPos, BegPos : Integer) : Integer;
{$endif}

implementation
uses
  LMDStrings, LMDPrintConst{$ifdef HAS_ALSTRTOOLS},AlStrTools{$endif};

{$ifndef HAS_ALSTRTOOLS}
{------------------------------------------------------------------------------}
// Path check and modification
function CheckPath(InpPath : string; IsPath : boolean) : string;
label l1;
var
  p, l : integer;
begin
//1. Check for '\\' absence
  Result := InpPath;
  if Result = '' then
    exit;

l1:
  p := Pos('\\', Result);
  // если p <= 0 то это значит что данные не найдены, если p = 1 то это значит сетевой путь.
  if p > 1 then
  begin
    Delete(Result, p, 1);
    goto l1;
  end;

//2. Check and remove quotes
  if Result[1] = '"' then
    Delete(Result, 1, 1);
  l := Length(Result);
  if Result[l] = '"' then
    SetLength(Result, l-1);

//3. If it is a path, then check for presence of '\' at the end.
  if IsPath then
  begin
    l := Length(Result);
    if l > 0 then
      if Result[l] <> '\' then
        Result := Result + '\';
  end;
end;

{------------------------------------------------------------------------------}
// Extracting word
function GetWordEx(S : string; var CharNumb : integer; Breaks : TSysCharSet) : string;
var
  Len : integer;
begin
  Result := '';
  Len := Length(s);
  if CharNumb > Len then
    exit;
  while CharNumb <= Len do
{$IFDEF LMD_NATIVEUNICODE}
    if not CharInSet(s[CharNumb], Breaks) then
{$ELSE LMD_NATIVEUNICODE}
    if not (s[CharNumb] in Breaks) then
{$ENDIF LMD_NATIVEUNICODE}
      break
    else
      inc(CharNumb);
  if CharNumb > Len then
    exit;
  while CharNumb <= Len do
  begin
{$IFDEF LMD_NATIVEUNICODE}
    if CharInSet(s[CharNumb], Breaks) then
{$ELSE LMD_NATIVEUNICODE}
    if s[CharNumb] in Breaks then
{$ENDIF LMD_NATIVEUNICODE}
      break;
    Result := Result + S[CharNumb];
    inc(CharNumb);
  end;
  inc(CharNumb);
end;

{------------------------------------------------------------------------------}
// Returns position from which next line begins
function GetPosOfNewString(const Value : string; CurPos : Integer) : Integer;
var
  i : Integer;
  // EndStrType:
  // 0 unknown
  // 1 #13 - Unix
  // 2 #10
  // 3 #13#10 - Windows
  // 4 #10#13 - Mac
  EndStrType : Integer;
begin
  Result := -1;
  EndStrType := 0;
  for i := CurPos to Length(Value) do
  begin
    case Value[i] of
      #13 :
        case EndStrType of
          0 : EndStrType := 1;
          1, 3, 4 :
            begin
              Result := i;
              break;
            end;
          2 : EndStrType := 4;
        end;    // case

      #10 :
        case EndStrType of
          0 : EndStrType := 2;
          1 : EndStrType := 3;
          2, 3, 4 :
            begin
              Result := i;
              break;
            end;
        end;    // case

      else
        case EndStrType of
          1, 2, 3, 4 :
            begin
              Result := i;
              break;
            end;
        end;    // case
    end;    // case
  end; // for
end;

{------------------------------------------------------------------------------}
// Sets length (in symbols) for a string, truncates extra symbols and adds '...'
// if the string doesn't fit width; adds spaces for too short string
function SetStrWidth(Value : string; Width : integer) : string;
var
  i, j : Integer;
begin
  j := Length(Value);
  Result := Value;
  if j < Width then
    Result := Result + StringOfChar(' ', Width - j)
  else
  if j > Width then
  begin
    SetLength(Result, Width);
    for i := Width - 2 to Width do
      Result[i] := '.';
  end;
end;

{------------------------------------------------------------------------------}
procedure GetTextLineByStringPos(const Value : string; ValuePos: integer; var Line,
  CharPos: Integer);
var
  SrcPos, SrcLen : Integer;
begin
  SrcLen := Length(Value);
  if ValuePos > SrcLen then
    Raise Exception.Create(Format(
      SErrorWhileDetectingPositionInLineIndexOutOfRange, [ValuePos, SrcLen]));
  SrcPos := 1;
  Line := 1;
  CharPos := 1;
  while SrcPos <= SrcLen do
  begin
    if SrcPos >= ValuePos then
      break;
    case Value[SrcPos] of
      #10, #13 :
      begin
        SrcPos := GetPosOfNewString(Value, SrcPos);
        inc(Line);
        CharPos := 1;
      end;
      else begin
        inc(CharPos);
        inc(SrcPos);
      end;
    end;    // case
  end;    // while
end;

{------------------------------------------------------------------------------}
type
{$IFDEF LMD_NATIVEUNICODE}
  StrRec = packed record
    codePage: Word;
    elemSize: Word;
    refCnt: Longint;
    length: Longint;
  end;
{$ELSE LMD_NATIVEUNICODE}
  StrRec = packed record
    allocSiz: Longint;
    refCnt: Longint;
    length: Longint;
  end;
{$ENDIF LMD_NATIVEUNICODE}

const
  skew = sizeof(StrRec);

function PosEx (const SubStr, s : String; EndPos, BegPos : Integer) : Integer;
{$ifdef LMDX64}
var
  LTemp: PLMDChar;
begin
  LTemp := PLMDChar(s);
  LTemp[EndPos] := #0;
  Result := LMDPosEx(SubStr, s, BegPos);
end;
{$else}
{$IFNDEF LMD_NATIVEUNICODE}
asm
{     ->EAX     Pointer to substr               }
{       EDX     Pointer to string               }
{       ECX     Last char (= length(s) if (EndPos <=0) or (EndPos > Length(s))) }
{     <-EAX     Position of substr in s or 0    }
        TEST    EAX,EAX
        JE      @@noWork

        TEST    EDX,EDX
        JE      @@stringEmpty

//----
        // ѕровер€ем параметры строки
        // ѕровер€ем EndPos, если <= 0 или больше длины строки, то присваиваем длину строки
        TEST    ECX,ECX
        JLE     @@Label3
        CMP     ECX,[EDX-skew].StrRec.length  // ѕровер€ем правильность переданного параметра EndPos
        JLE     @@Label1   // ѕереход если длина строки < EndPos
@@Label3:
        MOV     ECX,[EDX-skew].StrRec.length    { ECX = Length(s)} // конечное значение
@@Label1:
        DEC     BegPos
        JL      @@stringEmpty   // ѕереход если BegPos < 0
        SUB     ECX,BegPos     // EndPos = EndPos - BegPos ѕровер€ем чтобы Index был меньше EndPos
        JL      @@stringEmpty   // ѕереход если BegPos > EndPos
        ADD     EDX,BegPos  // устанавливаем другой номер символа с которого начинаем искать.
//----

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI

        MOV     ESI,EAX                         { Point ESI to substr           } // начало строки
        MOV     EDI,EDX                         { Point EDI to s                }

//        MOV     ECX,[EDI-skew].StrRec.length    { ECX = Length(s)               } // конечное значение значение

        PUSH    EDI                             { remember s position to calculate index        }

        MOV     EDX,[ESI-skew].StrRec.length    { EDX = Length(substr)          }

        DEC     EDX                             { EDX = Length(substr) - 1              }
        JS      @@fail                          { < 0 ? return 0                        }
        MOV     AL,[ESI]                        { AL = first char of substr             }
        INC     ESI                             { Point ESI to 2'nd char of substr      }

        SUB     ECX,EDX                         { #positions in s to look at    }
                                                { = Length(s) - Length(substr) + 1      }
        JLE     @@fail
@@loop:
        REPNE   SCASB
        JNE     @@fail
        MOV     EBX,ECX                         { save outer loop counter               }
        PUSH    ESI                             { save outer loop substr pointer        }
        PUSH    EDI                             { save outer loop s pointer             }

        MOV     ECX,EDX
        REPE    CMPSB
        POP     EDI                             { restore outer loop s pointer  }
        POP     ESI                             { restore outer loop substr pointer     }
        JE      @@found
        MOV     ECX,EBX                         { restore outer loop counter    }
        JMP     @@loop

@@fail:
        POP     EDX                             { get rid of saved s pointer    }
        XOR     EAX,EAX
        JMP     @@exit

@@stringEmpty:
        XOR     EAX,EAX
        JMP     @@noWork

@@found:
        POP     EDX                             { restore pointer to first char of s    }
        MOV     EAX,EDI                         { EDI points of char after match        }
        SUB     EAX,EDX                         { the difference is the correct index   }
//----
        ADD     EAX,BegPos
//----

@@exit:
        POP     EDI
        POP     ESI
        POP     EBX
@@noWork:
end;
{$ELSE LMD_NATIVEUNICODE}
asm
{     ->EAX     Pointer to substr               }
{       EDX     Pointer to string               }
{       ECX     Last char (= length(s) if (EndPos <=0) or (EndPos > Length(s))) }
{     <-EAX     Position of substr in s or 0    }
        TEST    EAX,EAX
        JE      @@noWork

        TEST    EDX,EDX
        JE      @@stringEmpty

//----
        // ѕровер€ем параметры строки
        // ѕровер€ем EndPos, если <= 0 или больше длины строки, то присваиваем длину строки
        TEST    ECX,ECX
        JLE     @@Label3
        CMP     ECX,[EDX-4]  // ѕровер€ем правильность переданного параметра EndPos
        JLE     @@Label1     // ѕереход если длина строки < EndPos
@@Label3:
        MOV     ECX,[EDX-4]                     { ECX = Length(s)} // конечное значение
@@Label1:
        DEC     BegPos
        JL      @@stringEmpty  // ѕереход если BegPos < 0
        SUB     ECX,BegPos     // EndPos = EndPos - BegPos ѕровер€ем чтобы Index был меньше EndPos
        JL      @@stringEmpty  // ѕереход если BegPos > EndPos
        SHL     BegPos,1     // “еперь BegPos можно использовать дл€ адресации LMD_NATIVEUNICODE string (возможно убрать дл€ WideString)
        ADD     EDX,BegPos   // устанавливаем другой номер символа с которого начинаем искать.
//----

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI

        MOV     ESI,EAX                         { Point ESI to substr           } // начало строки
        MOV     EDI,EDX                         { Point EDI to s                }

//        MOV     ECX,[EDI-4]                     { ECX = Length(s)               } // конечное значение

        PUSH    EDI                             { remember s position to calculate index        }

        MOV     EDX,[ESI-4]                     { EDX = Length(substr)          }

        DEC     EDX                             { EDX = Length(substr) - 1              }
        JS      @@fail                          { < 0 ? return 0                        }
        MOV     AX,[ESI]                        { AL = first char of substr             }
        ADD     ESI,2                           { Point ESI to 2'nd char of substr      }

        SUB     ECX,EDX                         { #positions in s to look at    }
                                                { = Length(s) - Length(substr) + 1      }
        JLE     @@fail
@@loop:
        REPNE   SCASW
        JNE     @@fail
        MOV     EBX,ECX                         { save outer loop counter               }
        PUSH    ESI                             { save outer loop substr pointer        }
        PUSH    EDI                             { save outer loop s pointer             }

        MOV     ECX,EDX
        REPE    CMPSW
        POP     EDI                             { restore outer loop s pointer  }
        POP     ESI                             { restore outer loop substr pointer     }
        JE      @@found
        MOV     ECX,EBX                         { restore outer loop counter    }
        JMP     @@loop

@@fail:
        POP     EDX                             { get rid of saved s pointer    }
        XOR     EAX,EAX
        JMP     @@exit

@@stringEmpty:
        XOR     EAX,EAX
        JMP     @@noWork

@@found:
        POP     EDX                             { restore pointer to first char of s    }
        MOV     EAX,EDI                         { EDI points of char after match        }
        SUB     EAX,EDX                         { the difference is the correct index   }
//----
        ADD     EAX,BegPos  // к индексу еще надо прибавить начальную позицию
//----
        SHR     EAX,1

@@exit:
        POP     EDI
        POP     ESI
        POP     EBX
@@noWork:
end;
{$ENDIF LMD_NATIVEUNICODE}
{$ENDIF}

{$endif}

{$ifdef ELDEMO}
const
  DEMO_BUFFER_SIZE = 2100;
  DEMO_BUFFER_SIZE2= 2100 xor $0FF0;
  DEMO_BUFFER_SIZE3= 2100 xor $0A0A;
{$endif ELDEMO}

{
******************************** TLMDMLGenSession *********************************
}
constructor TLMDMLGenSession.Create(aOwner : TLMDBaseMLGen; aParentSession :
        TLMDMLGenSession; const aName : string);
begin
  inherited Create;
  if not Assigned(aOwner) then
    Raise Exception.Create('Owner must be specified'); //en
  FOwner := aOwner;
  FParentSession := aParentSession;
  FName := aName;
  FTemplate := TStringList.Create;
  TStringList(FTemplate).OnChange := TemplateChanged;
  FTagParameters := TLMDStringParameters.Create;
  FBlocks := TLMDStringParameters.Create;
  FSrcPos := 0;
  FSource := '';
end;{ TLMDMLGenSession.Create }

destructor TLMDMLGenSession.Destroy;
begin
  if Assigned(FChildSession) then
  begin
    FChildSession.Free;
    FChildSession := nil;
  end;
  if FOwner.FCurrentSession = self then
    FOwner.FCurrentSession := FParentSession;
  FreeArrays;
  FreeRzrvArrays;
  FTemplate.Free;
  FTagParameters.Free;
  FBlocks.Free;
  inherited Destroy;
end;{ TLMDMLGenSession.Destroy }

procedure TLMDMLGenSession.Assign(Source: TPersistent);
begin
  //**
  inherited;
end;{ TLMDMLGenSession.Assign }

procedure TLMDMLGenSession.CheckEndPos;
var
  j, k, SrcLen: Integer;
begin
  // search for end of string in the template
  SrcLen := Length(FSource);
  j := FSrcPos; // Points to next symbol after macro
  while j <= SrcLen do begin
    case FSource[j] of
      #9, ' ' : ;
      #10, #13 :
        begin
          k := GetPosOfNewString(FSource, j);
          if k > 0 then
            j := k
          else
            j := SrcLen + 1;
          break;
        end;
      else
        exit; // have to write all. (Though, what we have found can be a beginning of a new macro)
    end;    // case
    inc(j);
  end;    // while

  // Now we know for sure that string must not be written. Cut it.
  FSrcPos := j;
end;{ TLMDMLGenSession.CheckEndPos }

function TLMDMLGenSession.DoBlockBegin: Boolean;
var
  j: Integer;
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 6{Length('<block')};
  GetTagProp(ClosedTag, FTagParameters);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SNameOfBlockTagMustBeSpecified);
  if FTagParameters.FData[j].Value = '' then
    Raise ELMDMlGenException.Create(FOwner, SNameOfBlockTagMustBeSpecified);
  Result := not ClosedTag;
  if Result then
    FBlockName := FTagParameters.FData[j].Value;
end;{ TLMDMLGenSession.DoBlockBegin }

function TLMDMLGenSession.DoBlockEnd: Boolean;
var
  j: Integer;
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 7{Length('</block')};
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInCodeTagDeclaration);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j >= 0 then
    Result := FBlockName = FTagParameters.FData[j].Value
  else
    Result := False;
  if Result then
    FBlockName := '';
end;{ TLMDMLGenSession.DoBlockEnd }

function TLMDMLGenSession.DoCodeBegin(APreparePass: Boolean = False): Boolean;
var
  LClosedTag: Boolean;
  j: Integer;
  LUseTranslationTable: Boolean;
  LCode: TStringList;
  LResult: string;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 5{Length('<code')};
  GetTagProp(LClosedTag, FTagParameters);
  if not APreparePass then
  begin
    FCodeBegin := FSrcPos;
    FCodeParams := TLMDStringParameters.Create;
    FCodeParams.Assign(FTagParameters);
    j := FTagParameters.FindItemByName('name');
    if j >= 0 then
      FCodeName := FTagParameters.FData[j].Value
    else
      FCodeName := '';

    if LClosedTag then
    begin
      LCode := nil;
      FOwner.CodeFound(FCodeName, FCodeParams, LClosedTag, LCode, LResult, LUseTranslationTable);
      with FOwner.FTranslationTables do
      begin
        if LUseTranslationTable and (DefaultForCode >= 0) then
          LResult := Items[DefaultForCode].Translate(LResult);
      end;  // with
      if LResult <> '' then
        FOwner.WriteString(LResult);
      if Assigned(FCodeParams) then
        FreeAndNil(FCodeParams);
    end;
  end;
  Result := not LClosedTag;
end;{ TLMDMLGenSession.DoCodeBegin }

procedure TLMDMLGenSession.DoCodeEnd(APreparePass: Boolean = False);
var
  LClosedTag: Boolean;
  LCode: TStringList;
  LCodeEnd: Integer;
  LResult: string;
  LUseTranslationTable: Boolean;
  LNewStrPos: Integer;
begin
  LCodeEnd := FSrcPos;
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 6{Length('</code')};
  GetTagProp(LClosedTag, FTagParameters);
  if LClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInCodeTagDeclaration);

  if not APreparePass then
  begin
    LCode := TStringList.Create;
    try
      if AnsiChar(FSource[FCodeBegin]) in [#13, #10] then
      begin
        LNewStrPos := GetPosOfNewString(FSource, FCodeBegin);
        if LNewStrPos > 0 then
          FCodeBegin := LNewStrPos;
      end;
      LCode.Text := Copy(FSource, FCodeBegin, LCodeEnd - FCodeBegin);
      FOwner.CodeFound(FCodeName, FCodeParams, LClosedTag, LCode, LResult, LUseTranslationTable);
      with FOwner.FTranslationTables do
      begin
        if LUseTranslationTable and (DefaultForCode >= 0) then
          LResult := Items[DefaultForCode].Translate(LResult);
      end;  // with
      if LResult <> '' then
        FOwner.WriteString(LResult);
    finally
      LCode.Free;
      if Assigned(FCodeParams) then
        FreeAndNil(FCodeParams);
    end;
  end;
end; { TLMDMLGenSession.DoCodeEnd }

function TLMDMLGenSession.DoCommentBegin: Boolean;
var
  j: Integer;
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 8{Length('<comment')};
  GetTagProp(ClosedTag, FTagParameters);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SNameOfCommentTagMustBeSpecified);
  if FTagParameters.FData[j].Value = '' then
    Raise ELMDMlGenException.Create(FOwner, SNameOfCommentTagMustBeSpecified);

  Result := not ClosedTag;
  if Result then
    FCommentName := FTagParameters.FData[j].Value;
end;{ TLMDMLGenSession.DoCommentBegin }

function TLMDMLGenSession.DoCommentEnd: Boolean;
var
  j: Integer;
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 9{Length('</comment')};
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInCommentTagDeclaration);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array

  if j >= 0 then
    Result := FCommentName = FTagParameters.FData[j].Value
  else
    Result := False;
  if Result then
    FCommentName := '';
end;{ TLMDMLGenSession.DoCommentEnd }

{{
Returns true if the tag found is an end of the last 'if' being handled.
}
function TLMDMLGenSession.DoIfDone: Boolean;
var
  i, j: Integer;
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 4{Length('</if')};
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInIfTagDeclaration1);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SNameOfIfTagMustBeSpecified1);
  if FTagParameters.FData[j].Value = '' then
    Raise ELMDMlGenException.Create(FOwner, SNameOfIfTagMustBeSpecified1);

  i := Length(FIfNames) - 1;
  if i >= 0 then
    Result := FIfNames[i] = FTagParameters.FData[j].Value
  else
    Result := False;
  if not Result then
    Raise ELMDMlGenException.Create(FOwner, SConditionWasNotDeclaredOrClosingTagForInnerConditionIsSkipped);

  if Result then begin
    FIfNames[i] := '';
    SetLength(FIfNames, i);
  end;

  if FSkipIfsDownToIndex >= 0 then
  begin
    Result := FSkipIfsDownToIndex = i;
    if Result then
      FSkipIfsDownToIndex := -1;
  end;
end;{ TLMDMLGenSession.DoIfDone }

function TLMDMLGenSession.DoIfElse(const LastResult : boolean): Boolean;
var
  i, j: Integer;
  ClosedTag: Boolean;
begin
  // Actually, it ever returns true except the case when nested 'IF' and 'ELSE'
  // is being skipped.
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 5{Length('<else')};
  GetTagProp(ClosedTag, FTagParameters);
  if not ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInElseTagDeclaration);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SNameOfElseTagMustBeSpecified);
  if FTagParameters.FData[j].Value = '' then
    Raise ELMDMlGenException.Create(FOwner, SNameOfElseTagMustBeSpecified);

  i := Length(FIfNames) - 1;
  if (i < 0) or (FIfNames[i] <> FTagParameters.FData[j].Value) then
    Raise ELMDMlGenException.Create(FOwner, SBeginningOfConditionIsNotFound);
  {$ifdef INC_SyntaxCheck}
    if not FOwner.FSyntaxCheck then
    begin
      if FSkipIfsDownToIndex < 0 then
      begin
        Result := True;
        // LastResult means that we executed 'IF' part, and 'Else' part must be skipped
        if LastResult then
          FSkipIfsDownToIndex := i;
      end
      else begin
        Result := FSkipIfsDownToIndex = i;
        if Result then
          FSkipIfsDownToIndex := -1;
      end;
    end
    else begin
      Result := True;
    end;
  {$else INC_SyntaxCheck}
    if FSkipIfsDownToIndex < 0 then
    begin
      Result := True;
      // LastResult means that we executed 'IF' part, and 'Else' part must be skipped
      if LastResult then
        FSkipIfsDownToIndex := i;
    end
    else begin
      Result := FSkipIfsDownToIndex = i;
      if Result then
        FSkipIfsDownToIndex := -1;
    end;
  {$endif INC_SyntaxCheck}
end;{ TLMDMLGenSession.DoIfElse }

function TLMDMLGenSession.DoIfFound(CallUserEvent : boolean): Boolean;
var
  i, j: Integer;
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 3{Length('<if')};
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInIfTagDeclaration);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SNameOfIfTagMustBeSpecified);
  if FTagParameters.FData[j].Value = '' then
    Raise ELMDMlGenException.Create(FOwner, SNameOfIfTagMustBeSpecified);

  {$ifdef INC_SyntaxCheck}
    if not FOwner.FSyntaxCheck then
    begin
      Result := True;
      if CallUserEvent then
        FOwner.IfFound(FTagParameters.FData[j].Value, FTagParameters, Result);
    end
    else begin
      Result := False;
      FOwner.IsIfValid(FTagParameters.FData[j].Value, FTagParameters, Result);
      if not Result then
        Raise ELMDMlGenException.Create(FOwner, Format('Condition %s is not valid', [FTagParameters.FData[j].Value]));
      Result := True;
    end;
  {$else INC_SyntaxCheck}
    Result := True;
    if CallUserEvent then
      FOwner.IfFound(FTagParameters.FData[j].Value, FTagParameters, Result);
  {$endif INC_SyntaxCheck}

  i := Length(FIfNames);
  SetLength(FIfNames, i + 1);
  FIfNames[i] := FTagParameters.FData[j].Value;

  // ƒл€ пропуска вложенных ифов
  if not Result then
    FSkipIfsDownToIndex := i;
end;{ TLMDMLGenSession.DoIfFound }

function TLMDMLGenSession.DoIsTag(const TagName : string): Boolean;
begin
  Result := False;
  FOwner.IsTag(TagName, Result);
end;{ TLMDMLGenSession.DoIsTag }

{{
Parses tag of the macro. SrcPos variable value must be set to point to the beginning '<macro'
before method is called. After method call, SrcPos bust be set to point to the next symbol
after '>'.
}
function TLMDMLGenSession.DoMacroFound: string;
var
  j: Integer;
  ClosedTag: Boolean;
  UseTranslationTable: Boolean;
  Valid: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 6{Length('<macro')};
  GetTagProp(ClosedTag, FTagParameters);
  if not ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInMacroDeclaration);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SNameOfMacroMustBeSpecified);
  if FTagParameters.FData[j].Value = '' then
    Raise ELMDMlGenException.Create(FOwner, SNameOfMacroMustBeSpecified);

  UseTranslationTable := True;
  Result := '';
  {$ifdef INC_SyntaxCheck}
    if not FOwner.FSyntaxCheck then
      FOwner.MacroFound(FTagParameters.FData[j].Value, FTagParameters, Result, UseTranslationTable)
    else begin
      Valid := False;
      FOwner.IsMacroValid(FTagParameters.FData[j].Value, FTagParameters, Valid);
      if not Valid then
        Raise ELMDMlGenException.Create(FOwner, Format('Macro %s is not valid', [FTagParameters.FData[j].Value])); //en
    end;
  {$else INC_SyntaxCheck}
    FOwner.MacroFound(FTagParameters.FData[j].Value, FTagParameters, Result, UseTranslationTable);
  {$endif INC_SyntaxCheck}

  with FOwner.FTranslationTables do
  begin
    if UseTranslationTable and (DefaultForMacro >= 0) then
      Result := Items[DefaultForMacro].Translate(Result);
  end;  // with
end;{ TLMDMLGenSession.DoMacroFound }

function TLMDMLGenSession.DoParamBegin(var ParamName : string; var ParamNumb :
        integer): Boolean;
var
  ClosedTag: Boolean;
  j: Integer;
  ParamValue: string;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 6{Length('<param')};
  GetTagProp(ClosedTag, FTagParameters);
  Result := not ClosedTag;
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SNameOfParamTagMustBeSpecified);
  if FTagParameters.FData[j].Value = '' then
    Raise ELMDMlGenException.Create(FOwner, SNameOfParamTagMustBeSpecified);
  ParamName := FTagParameters.FData[j].Value;
  j := FTagParameters.FindItemByName('value'); // Number of param that holds value
  if j >= 0 then
    ParamValue := FTagParameters.FData[j].Value
  else
    ParamValue := '';
  ParamNumb := FOwner.FParameters.AddValue(ParamName, ParamValue, nil);
  if not Result then
  begin
    ParamName := '';
    ParamNumb := 0;
  end;
end;{ TLMDMLGenSession.DoParamBegin }

procedure TLMDMLGenSession.DoParamEnd;
var
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 7{Length('</param')};
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInParamTagDeclaration1);
end;{ TLMDMLGenSession.DoParamEnd }

function TLMDMLGenSession.DoParamsBegin: Boolean;
var
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 7{Length('<params')};
  GetTagProp(ClosedTag, FTagParameters);
  Result := not ClosedTag;
end;{ TLMDMLGenSession.DoParamsBegin }

procedure TLMDMLGenSession.DoParamsEnd;
var
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 8{Length('</params')};
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInParamsTagDeclaration1);
end;{ TLMDMLGenSession.DoParamsEnd }

procedure TLMDMLGenSession.DoProcess;
var
  i, j, k: Integer;
  ClosedTag: Boolean;
  TemplateName, BlockName, TemplateText: string;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 8{Length('<process')};
  GetTagProp(ClosedTag, FTagParameters);
  if not ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInRepeatTagDeclaration);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  k := FTagParameters.FindItemByName('block'); // Position of name parameter in the array
  if (j < 0) and (k < 0) then
    Raise ELMDMlGenException.Create(FOwner, 'Tag ''Process'' contains neither external template name nor block name.'); //en

  if j > 0 then
  begin
    // Execute external block
    TemplateName := FTagParameters.FData[j].Value;
    if TemplateName = '' then
      Raise ELMDMlGenException.Create(FOwner, 'Tag ''Process'' contains neither external template name nor block name.'); //en
    if k > 0 then begin
      BlockName := FTagParameters.FData[k].Value;
      if BlockName = '' then
        Raise ELMDMlGenException.Create(FOwner, 'Tag ''Process'' not contains block name.'); //en
    end
    else
      BlockName := '';
    TemplateText := '';
    FOwner.TemplateNeeded(TemplateName, FTagParameters, TemplateText);
  end
  else begin
    // Execute internal block
    TemplateName := FName;
    BlockName := FTagParameters.FData[k].Value;
    if BlockName = '' then
      Raise ELMDMlGenException.Create(FOwner, 'Tag ''Process'' contains neither external template name nor block name.'); //en
    i := FBlocks.FindItemByName(BlockName);
    if i < 0 then
      Raise ELMDMlGenException.Create(FOwner, Format('Block %s is not found', [BlockName])); //en
    TemplateText := FBlocks.Value[i];
  end;

  StartSession(TemplateName, BlockName, TemplateText);
end;{ TLMDMLGenSession.DoProcess }

procedure TLMDMLGenSession.DoRepeatBegin;
var
  i, j, k: Integer;
  s: string;
  ClosedTag: Boolean;
  b: Boolean;
  aSrcPos : Integer;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 7{Length('<repeat')};
  aSrcPos := FSrcPos; // Temporarily store pointer to the beginning of loop parameters
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInRepeatTagDeclaration);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SNameOfRepeatTagMustBeSpecified);
  s := FTagParameters.FData[j].Value;
  if s = '' then
    Raise ELMDMlGenException.Create(FOwner, SNameOfRepeatTagMustBeSpecified);

  // Check if there was such loop earlier
  for i := 0 to Length(FLoopNames) - 1 do
  begin
    if FLoopNames[i] = s then
    Raise ELMDMlGenException.Create(FOwner, Format(SDuplicateLoopNameS, [s]));
  end; // for

  i := Length(FLoopCounters) + 1;
  SetLength(FLoopCounters, i);
  SetLength(FLoopNames, i);
  SetLength(FLoopBeginPos, i);
  SetLength(FLoopParamsBeginPos, i);
  SetLength(FLoopCountersCurrentPage, i);
  dec(i);

  FLoopNames[i] := s;
  FLoopCountersCurrentPage[i] := 0;
  if not FOwner.FEnteringInNextPage then
  begin
    FLoopCounters[i] := 0;
  end
  else begin
    // If we search for an entry point in a new file
    if FLoopNamesRzrv[0] = FLoopNames[0] then
    begin
      // We already found first loop and this means that all subsequent names must match
      if FLoopNames[i] <> FLoopNamesRzrv[i] then
        Raise ELMDMlGenException.Create(FOwner, SUnableToFindPointToReturn);
      FLoopCounters[i] := FLoopCountersRzrv[i];
      if Length(FLoopNames) = Length(FLoopNames) then
        FOwner.FEnteringInNextPage := False;
    end
    else begin
      // We haven't reached first loop where we were at the moment of exit. This
      // is simply a new loop.
      // But there must be no such name in our records!
      s := FTagParameters.FData[j].Value;
      for k := 0 to Length(FLoopNamesRzrv) -1 do
      begin
        if s = FLoopNamesRzrv[k] then
          Raise ELMDMlGenException.Create(FOwner, SUnableToFindPointToReturnPossibleReasonIsDuplicatedLoopName);
      end; // for
      FLoopCounters[i] := 0;
    end;
  end;

  FLoopBeginPos[i] := FSrcPos;
  FLoopParamsBeginPos[i] := aSrcPos; // Pointer to the beginning of loop paramaters

  b := False; // loop is iterated once.
  {$ifdef INC_SyntaxCheck}
    if not FOwner.FSyntaxCheck then // If syntax check is running
      FOwner.LoopIteration(i, FTagParameters.FData[j].Value, FTagParameters, b)
    else begin
      FOwner.IsLoopValid(FTagParameters.FData[j].Value, FTagParameters, b);
      if not b then
        Raise ELMDMlGenException.Create(FOwner, Format('Loop %s is not valid', [FTagParameters.FData[j].Value])); //en
    end;
  {$else INC_SyntaxCheck}
    FOwner.LoopIteration(i, FTagParameters.FData[j].Value, FTagParameters, b);
  {$endif INC_SyntaxCheck}

  if b then
  begin
    // loop finished without having started
    i := High(FLoopCounters);
    FLoopBreak := FLoopNames[i];
  end;
end;{ TLMDMLGenSession.DoRepeatBegin }

procedure TLMDMLGenSession.DoRepeatDone;
var
  i, j: Integer;
  s: string;
  b: Boolean;
  ClosedTag: Boolean;
  aTagParameters : TLMDStringParameters;
  aSrcPos : Integer;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 8{Length('</repeat')};
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInRepeatTagDeclaration1);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j >= 0 then
  begin
    s := FTagParameters.FData[j].Value;
    i := GetLoopIndex(s);
    if i < 0 then
      Raise ELMDMlGenException.Create(FOwner, SRepeatTagDoesnTHaveMatchingRepeatTag1);
  end
  else
  begin
    i := High(FLoopCounters);
    s := FLoopNames[i];
  end;

  // Event signaling about next iteration of the loop must be fired with new iterator value
  inc(FLoopCounters[i]);
  inc(FLoopCountersCurrentPage[i]);

  aTagParameters := TLMDStringParameters.Create;
  try
    // Read loop parameters anew
    aSrcPos := FSrcPos; // Backup pointer to the current cursors position in the template
    FSrcPos := FLoopParamsBeginPos[i];
    GetTagProp(ClosedTag, aTagParameters);
    FSrcPos := aSrcPos;

    // b := not LoopIteration(i, s, TagProp, TagPropValue);
    b := True;
    {$ifdef INC_SyntaxCheck}
      if not FOwner.FSyntaxCheck then
        FOwner.LoopIteration(i, s, aTagParameters, b)
      else begin
        b := False;
        FOwner.IsLoopValid(s, aTagParameters, b);
        if not b then
          Raise ELMDMlGenException.Create(FOwner, Format('Loop %s is not valid', [FTagParameters.FData[j].Value])); //en
        b := True;
      end;
    {$else INC_SyntaxCheck}
      FOwner.LoopIteration(i, s, aTagParameters, b);
    {$endif INC_SyntaxCheck}

    if (not b) and FOwner.FNewPageProcessing then
    begin
      // If loop is reserved, stop it.
      for j := 0 to High(FLoopNamesRzrv) do
      begin
        if (FLoopNamesRzrv[j] = s) and
           (FLoopBeginPos[j] = FLoopBeginPosRzrv[j]) then
        begin
          b := True;
          break;
        end;
      end; // for
    end;

    if b then begin
      // loop is finished
      SetLength(FLoopCounters, i);
      SetLength(FLoopCountersCurrentPage, i);
      SetLength(FLoopBeginPos, i);
      SetLength(FLoopParamsBeginPos, i);
      SetLength(FLoopNames, i);
    end
    else begin
      // loop continues

      // If one '/repeat' closes several loops, then we have to delete info about them
      if i < High(FLoopNames) then
      begin
        j := i + 1;
        SetLength(FLoopCounters, j);
        SetLength(FLoopCountersCurrentPage, j);
        SetLength(FLoopBeginPos, j);
        SetLength(FLoopParamsBeginPos, j);
        SetLength(FLoopNames, j);
      end;

      FSrcPos := FLoopBeginPos[i];
    end;

  finally
    aTagParameters.Free;
  end;  // try/finally
end;{ TLMDMLGenSession.DoRepeatDone }

function TLMDMLGenSession.DoRepeatSkipDone: Boolean;
var
  i, j: Integer;
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 8{Length('</repeat')};
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInRepeatTagDeclaration1);

  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array

  if j >= 0 then
  begin
    Result := FLoopBreak = FTagParameters.FData[j].Value;
    if Result then
    begin
      // loop is finished
      i := GetLoopIndex(FLoopBreak);
      if i < 0 then
        Raise ELMDMlGenException.Create(FOwner, STryingToCloseNotOpenedLoopInternalError);
      FLoopBreak := '';
      SetLength(FLoopCounters, i);
      SetLength(FLoopCountersCurrentPage, i);
      SetLength(FLoopBeginPos, i);
      SetLength(FLoopParamsBeginPos, i);
      SetLength(FLoopNames, i);
    end;
  end
  else
    Result := False; // This loop is not ours, we wait for another loop finishing
end;{ TLMDMLGenSession.DoRepeatSkipDone }

function TLMDMLGenSession.DoReplaceBegin(var ParamName : string; var ParamNumb :
        integer): Boolean;
var
  ClosedTag: Boolean;
  j: Integer;
  ParamValue: string;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 8{Length('<replace')};
  GetTagProp(ClosedTag, FTagParameters);
  Result := not ClosedTag;
  j := FTagParameters.FindItemByName('string'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SStringInReplaceTagMustBeSpecified);
  if FTagParameters.FData[j].Value = '' then
    Raise ELMDMlGenException.Create(FOwner, SStringInReplaceTagMustBeSpecified);

  ParamName := FTagParameters.FData[j].Value;
  j := FTagParameters.FindItemByName('with'); // Number of param that holds value
  if j >= 0 then
    ParamValue := FTagParameters.FData[j].Value
  else
    ParamValue := '';
  ParamNumb := FOwner.FTranslationTable.Table.AddValue(ParamName, ParamValue, nil);
  if not Result then
  begin
    ParamName := '';
    ParamNumb := 0;
  end;
end;{ TLMDMLGenSession.DoReplaceBegin }

procedure TLMDMLGenSession.DoReplaceEnd;
var
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 9{Length('</replace')};
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInReplaceTagDeclaration1);
end;{ TLMDMLGenSession.DoReplaceEnd }

procedure TLMDMLGenSession.DoTagFound(TagName : string);
var
  ClosedTag: Boolean;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + Length(TagName) + 1;
  GetTagProp(ClosedTag, FTagParameters);
  {$ifdef INC_SyntaxCheck}
    if not FOwner.FSyntaxCheck then
      FOwner.TagFound(TagName, ClosedTag, FTagParameters);
  {$else INC_SyntaxCheck}
    FOwner.TagFound(TagName, ClosedTag, FTagParameters);
  {$endif INC_SyntaxCheck}
end;{ TLMDMLGenSession.DoTagFound }

procedure TLMDMLGenSession.DoTranslationBegin(var TableName : string);
var
  ClosedTag: Boolean;
  j: Integer;
  s: string;
begin
  if TableName <> '' then
    Raise ELMDMlGenException.Create(FOwner, SEmbeddedTranslationTablesAreNotAllowed);
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 12{Length('<translation')};
  GetTagProp(ClosedTag, FTagParameters);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SNameOfTranslationTagMustBeSpecified);
  TableName := FTagParameters.FData[j].Value;
  if TableName = '' then
    Raise ELMDMlGenException.Create(FOwner, SNameOfTranslationTagMustBeSpecified);

  FOwner.FTranslationTable := FOwner.FTranslationTables.Add(TableName);

  j := FTagParameters.FindItemByName('default');
  if j >= 0 then
  begin
    s := LowerCase(FTagParameters.FData[j].Value);
    if s = 'macro' then
      FOwner.FTranslationTables.DefaultForMacro := FOwner.FTranslationTable.Index
    else
    if s = 'template' then
      FOwner.FTranslationTables.DefaultForTemplate := FOwner.FTranslationTable.Index
    else
    if s = 'code' then
      FOwner.FTranslationTables.DefaultForCode := FOwner.FTranslationTable.Index
    else
    if s = 'all' then
    begin
      FOwner.FTranslationTables.DefaultForMacro    := FOwner.FTranslationTable.Index;
      FOwner.FTranslationTables.DefaultForCode    := FOwner.FTranslationTable.Index;
      FOwner.FTranslationTables.DefaultForTemplate := FOwner.FTranslationTable.Index;
    end
    else
      Raise ELMDMlGenException.Create(FOwner, 'Unknown value for ''default'' property.'); //en
  end;
  if ClosedTag then
  begin
    TableName := '';
    FOwner.FTranslationTable := nil;
  end;
end;{ TLMDMLGenSession.DoTranslationBegin }

procedure TLMDMLGenSession.DoTranslationEnd(var TableName : string);
var
  ClosedTag: Boolean;
  j: Integer;
  s: string;
begin
  FSrcPos := FSrcPos + Length(FOwner.FTagPrefix) + 13{Length('</translation')};
  GetTagProp(ClosedTag, FTagParameters);
  if ClosedTag then
    Raise ELMDMlGenException.Create(FOwner, SErrorInTranslationTagDeclaration1);
  j := FTagParameters.FindItemByName('name'); // Position of name parameter in the array
  if j < 0 then
    Raise ELMDMlGenException.Create(FOwner, SNameOfTranslationTagMustBeSpecified1);
  s := FTagParameters.FData[j].Value;
  if s = '' then
    Raise ELMDMlGenException.Create(FOwner, SNameOfTranslationTagMustBeSpecified1);

  if s <> TableName then
    Raise ELMDMlGenException.Create(FOwner, Format(STryingToCloseNotPreviouslyOpenedTranslationTableSS,
                    [s, TableName]));

  TableName := '';
  FOwner.FTranslationTable := nil;
end;{ TLMDMLGenSession.DoTranslationEnd }

procedure TLMDMLGenSession.DoWriteInterval(const AInterval: String);
var
  LTemp: String;
begin
  LTemp := AInterval;
  with FOwner.FTranslationTables do
  begin
    if DefaultForTemplate >= 0 then
      LTemp := Items[DefaultForTemplate].Translate(AInterval);
  end;  // with

  // Write if there is anything to be writtem
  if (LTemp <> '') and (not FOwner.FSyntaxCheck) then
    FOwner.WriteString(LTemp);
end;

{{
Starts template processing.
}
procedure TLMDMLGenSession.Execute;
var
  SrcLen: Integer;
  OldSrcPos, TagStart: Integer;
  i, LenTagPrefix: Integer;
  s: string;
  SavingInterval, Substitution: string;

  // Returns true if SavingInterval variable must be written entirelly (or truncated)
  // check for spaces in the line where macro is placed
  function CheckSavingInterval : boolean;
  var
    i, m, j, k : Integer; // Counters
  begin
    Result := False;

    // Check beginning of the line (search either start of file, or end of previous line, or demand to write all)
    m := Length(SavingInterval);
    i := TagStart - 1;
    if i <> 0 then
    begin
      while i >= (TagStart - m) do
      begin
        case FSource[i] of
          #9, ' ' : ;
          #10, #13 :
            begin
              m := i - (TagStart - m - 1);
              break;
            end;
          else
            exit; // need to write all
        end;    // case
        dec(i);
      end;    // while
      if i = (TagStart - m - 1) then
      begin
        // Beginning of the line is reached, but no stop symbols are found
        m := 0;
      end;
    end
    else
      m := 0;

    // Check line from macro's end to beginning of the next line
    // This is part of CheckEndPos procedure

    // Search end of line in the template
    j := FSrcPos; // Points to next symbol after the macro
    while j <= SrcLen do begin
      case FSource[j] of
        #9, ' ' : ;
        #10, #13 :
          begin
            k := GetPosOfNewString(FSource, j);
            if k > 0 then
              j := k
            else
              j := SrcLen + 1;
            break;
          end;
        else
          exit; // have to write all. (Though, what we have found can be a beginning of a new macro)
      end;    // case
      inc(j);
    end;    // while

    // Now we know for sure that string must not be written. Cut it.
    FSrcPos := j;

    SavingInterval := Copy(SavingInterval, 1, m);
    Result := True;
  end;

  var
    aTagFound : boolean;
    j : Integer;
    IfPass, CommentPass, ParamsPass, CodePass, BlockPass: Boolean;

begin
  FSessionExecuting := True;
  try
    FOwner.FCurrentSession := self;
    FreeArrays;
    FreeRzrvArrays;
    FSrcPos := 0;
    IfPass := False;
    CommentPass := False;
    ParamsPass := False;
    CodePass := False;
    BlockPass := False;
    FLoopBreak := '';
    FSkipIfsDownToIndex := -1;

    FSource := FTemplate.Text;
    SrcLen := Length(FSource);
    // Cut last #13#10
    if (SrcLen >= 2) and (FSource[SrcLen-1] = #13) and (FSource[SrcLen] = #10) then
    begin
      dec(SrcLen, 2);
      SetLength(FSource, SrcLen);
    end;

    LenTagPrefix := Length(FOwner.FTagPrefix);
    try
      repeat
        FOwner.ProcessMessages;
        if FOwner.FCancelJob then
          exit;
        {$ifdef INC_SyntaxCheck}
          if (not Assigned(FParentSession)) and (not FOwner.FSyntaxCheck) then
            FOwner.DoNextPage;
        {$else INC_SyntaxCheck}
          if not Assigned(FParentSession) then
            FOwner.DoNextPage;
        {$endif INC_SyntaxCheck}
        try
          FSrcPos := 1;
          OldSrcPos := 1;
          while FSrcPos <= SrcLen do begin
            FOwner.ProcessMessages;
            if FOwner.FCancelJob then
              exit;
            TagStart := PosEx('<', FSource, SrcLen, FSrcPos);
            if TagStart <= 0 then begin
              // No more macros. Write end of chunk.
              if (not CommentPass) and (not FOwner.FSyntaxCheck) then
                FOwner.WriteString(Copy(FSource, OldSrcPos, SrcLen - OldSrcPos + 1));
              break;
            end;

            FSrcPos := TagStart;
            i := FSrcPos + 1;
            s := GetWordEx(FSource, i, [' ', '>']);
            // If a space goes after '<', allow for it, since spaces were skipped
            // while searching for a word
            if (i <= FSrcPos) and (FSource[i] = ' ') then
              s := s + ' ';

            Substitution := '';
            // SavingInterval := '';

            // Examine found tag
            if (FOwner.FTagPrefix = '') or (FOwner.FTagPrefix = Copy(s, 1, LenTagPrefix)) then
            begin // This tag must be handled
              if FOwner.FTagPrefix <> '' then
                Delete(s, 1, LenTagPrefix);
              // If there is closing symbol at the end, then exclude it.
              j := Length(s);
              if (j > 0) and (s[j] = '/') then
                SetLength(s, j - 1);

              aTagFound := True;
              if not CommentPass then
              begin
                if not BlockPass then
                begin
                  if not CodePass then
                  begin
                    if not ParamsPass then
                    begin
                      if FLoopBreak = '' then
                      begin
                        if not IfPass then
                        begin

                          SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
                          DoWriteInterval(SavingInterval);
                          // Now, when we've been writing interval - reset Pos
                          OldSrcPos := FSrcPos;

                          if s = 'comment' then begin
                            CommentPass := DoCommentBegin;
                          end
                          else
                          if s = 'macro' then begin
                            Substitution := DoMacroFound;
                            // SavingInterval := SavingInterval + Substitution;
                          end
                          else
                          if s = 'repeat' then begin
                            DoRepeatBegin;
                          end
                          else
                          if s = '/repeat' then begin
                            DoRepeatDone;
                          end
                          else
                          if s = 'if' then begin
                            IfPass := not DoIfFound(True);
                          end
                          else
                          if s = 'else' then begin
                            DoIfElse(True);
                            IfPass := True;
                          end
                          else
                          if s = '/if' then begin
                            DoIfDone;
                          end
                          else
                          if s = 'params' then begin
                            ParamsPass := DoParamsBegin;
                          end
                          else
                          if s = 'code' then
                          begin
                            CodePass := DoCodeBegin;
                          end
                          else
                          if s = 'block' then
                          begin
                            DoBlockBegin;
                            BlockPass := True;
                          end
                          else
                          if s = 'process' then
                          begin
                            DoProcess;
                          end
                          else begin
                            if DoIsTag(s) then
                            begin
                              // 04.Sep.02 removed, because this command is called earlier
                              // SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
                              DoTagFound(s);
                            end
                            else begin
                              aTagFound := False;
                              inc(FSrcPos);
                              SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
                              DoWriteInterval(SavingInterval);
                            end;
                          end;

                          // check whether line with macro holds anything else than macro
                          // skip service lines
                          if aTagFound then
                          begin
                            // There were no substitutions, or empty line was substituted.
                            // Check the line with found tag. If the line must not be written,
                            // move FSrcPos to a new position.
                            if Substitution = '' then
                              if CheckSavingInterval then
                                //CheckEndPos;
                                ;
                          end;

                          // Write if there is anything to be writtem
                          if (Substitution <> '') and (not FOwner.FSyntaxCheck) then
                            FOwner.WriteString(Substitution);

                        end // if IfFound then
                        else begin

                          // If condition is found and ≈сли найдено условие, and
                          // execution result was false, then skip text block

                          if s = 'if' then begin
                            DoIfFound(False);
                          end
                          else
                          if s = 'else' then begin
                            IfPass := not DoIfElse(False);
                          end
                          else
                          if s = '/if' then begin
                            IfPass := not DoIfDone;
                          end
                          else
                          if s = 'comment' then begin
                            CommentPass := DoCommentBegin;
                          end
                          else begin
                            inc(FSrcPos);
                            aTagFound := False;
                          end;

                          // Check if we have to skip line feed
                          // skip service lines
                          if aTagFound then
                            CheckEndPos;

                        end; // if IfFound else
                      end
                      else begin // !if not LoopSkip then

                        if s = '/repeat' then begin
                          DoRepeatSkipDone;
                        end
                        else
                        if s = 'comment' then begin
                          CommentPass := DoCommentBegin;
                        end
                        else begin
                          inc(FSrcPos);
                          aTagFound := False;
                        end;

                        // Check if we have to skip line feed
                        // Skip service lines
                        if aTagFound then
                          CheckEndPos;

                      end;

                    end // if not ParametresPass
                    else begin

                      if s = '/params' then begin
                        DoParamsEnd;
                        ParamsPass := False;
                      end
                      else
                      if s = 'comment' then begin
                        CommentPass := DoCommentBegin;
                      end
                      else begin
                        inc(FSrcPos);
                        aTagFound := False;
                      end;

                      // Check if we have to skip line feed
                      // Skip service lines

                      if aTagFound then
                        CheckEndPos;

                    end; // !if not ParametresPass
                  end // if not CodePass
                  else begin

                    if s = '/code' then begin
                      DoCodeEnd;
                      CodePass := False;
                    end
                    else
                    if s = 'comment' then begin
                      CommentPass := DoCommentBegin;
                    end
                    else begin
                      inc(FSrcPos);
                      aTagFound := False;
                    end;

                    // Check if we have to skip line feed
                    // skip service lines
                    if aTagFound then
                      CheckEndPos;

                  end; // !if not CodePass
                end
                else begin
                  if s = '/block' then begin
                    BlockPass := not DoBlockEnd;
                  end
                  else
                  if s = 'comment' then begin
                    CommentPass := DoCommentBegin;
                  end
                  else begin
                    inc(FSrcPos);
                    aTagFound := False;
                  end;

                  // Check if we have to skip line feed
                  // skip service lines
                  if aTagFound then
                    CheckEndPos;

                end; // !if not BlockPass
              end // !if not CommentPass
              else begin // !if not CommentPass

                if s = '/comment' then begin
                  CommentPass := not DoCommentEnd;
                end
                else begin
                  inc(FSrcPos);
                  aTagFound := False;
                end;
                // Check if we have to skip line feed
                // skip service lines
                if aTagFound then
                  CheckEndPos;

              end;
              OldSrcPos := FSrcPos;
            end
            else begin // skip other tags
              inc(FSrcPos);
            end;

          end; // while

          // Check if all tags were closed
          // Loops
          i := Length(FLoopCounters);
          if i > 0 then
            Raise Exception.Create(Format(SErrorInTemplateDLoopsWereNotClosed, [i]));

          // Conditions
          i := Length(FIfNames);
          if i > 0 then
            Raise Exception.Create(Format(SErrorInTemplateDConditionsWereNotClosed, [i]));

          if IfPass or CommentPass or ParamsPass then
            Raise Exception.Create(SErrorInTemplateNotAllTagsHaveBeenClosed);

        finally // wrap up
         {$ifdef INC_SyntaxCheck}
           if (not Assigned(FParentSession)) and (not FOwner.FSyntaxCheck) then
             FOwner.PageEnd(FOwner.FPageCount);
         {$else INC_SyntaxCheck}
           if not Assigned(FParentSession) then
             FOwner.PageEnd(FOwner.FPageCount);
         {$endif INC_SyntaxCheck}
        end; // try/finally
      until not FOwner.FNewPageProcessing; // Stop only if there were no command
                                           // for creation of a new file

    finally // wrap up
      FreeArrays;
      FreeRzrvArrays;
    end;    // try/finally
  finally
    FOwner.FCurrentSession := FParentSession;
    FSessionExecuting := False;
  end;  // try/finally
end;{ TLMDMLGenSession.Execute }

procedure TLMDMLGenSession.ExecuteEx(BlockName : string);
var
  i: Integer;
  TemplateText: string;
begin
  i := FBlocks.FindItemByName(BlockName);
  if i < 0 then
    Raise ELMDMlGenException.Create(FOwner, Format('Block %s is not found', [BlockName]));
  TemplateText := FBlocks.Value[i];
  StartSession(FName, BlockName, TemplateText);
end;{ TLMDMLGenSession.ExecuteEx }

procedure TLMDMLGenSession.FreeArrays;
begin
  FLoopBeginPos := nil;
  FLoopParamsBeginPos := nil;
  FLoopCounters := nil;
  FLoopCountersCurrentPage := nil;
  FLoopNames := nil;
  FIfNames := nil;
end;{ TLMDMLGenSession.FreeArrays }

procedure TLMDMLGenSession.FreeRzrvArrays;
begin
  FLoopBeginPosRzrv := nil;
  FLoopCountersRzrv := nil;
  FLoopNamesRzrv := nil;
end;{ TLMDMLGenSession.FreeRzrvArrays }

function TLMDMLGenSession.GetLoopIndex(const LoopName : string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to High(FLoopNames) do begin
    if FLoopNames[i] = LoopName then begin
      Result := i;
      break;
    end;
  end; // for
end;{ TLMDMLGenSession.GetLoopIndex }

{{
It is assumed that we are within the tag, and we have to parse what parameters
the tag has. If no parameters found, then we return empty string values.
}
const
  AllocateBy = 10;

procedure TLMDMLGenSession.GetTagProp(var ClosedTag : boolean; TagOptions :
        TLMDStringParameters);
    function ConvertParamValue(const Value : string) : string;
    var
      ValuePos, NewValuePos, ValueLen, j : Integer;
      s : string;
      i : byte;
    begin
      Result := '';
      ValuePos := 1;
      ValueLen := Length(Value);
      j := ValueLen - 2;
      if ValuePos <= j then
      begin
        while ValuePos <= j do
        begin
          NewValuePos := PosEx('#', Value, ValueLen, ValuePos);
          if NewValuePos <= 0 then
          begin
            Result := Result + Copy(Value, ValuePos, ValueLen - ValuePos + 1);
            break;
          end;
          Result := Result + Copy(Value, ValuePos, NewValuePos - ValuePos);
          s := Copy(Value, NewValuePos, 3);
          s[1] := '$';
          try
            i := StrToInt(s);
            Result := Result + Char(i);
          except
            s[1] := '#';
            Result := Result + s;
          end;    // try/except
          ValuePos := NewValuePos + 3;
        end;    // while
      end
      else
        Result := Value;
    end;

    procedure AddProp(Prop, Value : string; var PropCount: integer);
    var
      i : Integer;
    begin
      // Prop := AnsiLowerCase(Prop);
      // Value := AnsiLowerCase(Value);
      inc(PropCount);
      i := Length(TagOptions.FData);
      if i < PropCount then begin
        SetLength(TagOptions.FData, i + AllocateBy);
      end;
      TagOptions.Data[PropCount-1].ValueName := Prop;
      TagOptions.Data[PropCount-1].Value := ConvertParamValue(Value);
    end;

  var
    SrcLen: Integer;
    QuoutType: Integer; // 0 - not found, 1 - ", 2 - '
    QuoutBeginPos : Integer; // first quote position
    PropCount : Integer; // number of tag params found
    EndTag : boolean;
    s, s1 : string;
begin
  QuoutBeginPos := 0; // make compiler happy
  ClosedTag := False;
  PropCount := 0; // number of found params
  TagOptions.Clear;
  SetLength(TagOptions.FData, AllocateBy); // reserve some space
  EndTag := False;
  SrcLen := Length(FSource);
  if FSrcPos > SrcLen then
    Raise ELMDMlGenException.Create(FOwner, SCanNotAnalyzeTag);

  try
    repeat
      s := '';
      // skip leading spaces
      while FSrcPos <= SrcLen do begin
        case FSource[FSrcPos] of
          #9, ' ', #13, #10 : inc(FSrcPos);
          else
            break;
        end;    // case
      end;
      if FSrcPos > SrcLen then
        Raise ELMDMlGenException.Create(FOwner, SCanNotAnalyzeTag);
      // get parameter name
      while FSrcPos <= SrcLen do begin
        case FSource[FSrcPos] of
          #10, #13 :
            begin
              FSrcPos := GetPosOfNewString(FSource, FSrcPos) - 1;
              if FSrcPos <=0 then // true means that no beginning of next line found
                FSrcPos := SrcLen;
              break;
            end;
          #9, ' ', '=' :
            break;
          '>' :
            begin
              inc(FSrcPos);
              EndTag := True;
              break;
            end;
          '<', '"' :
            Raise ELMDMlGenException.Create(FOwner, SCanNotAnalyzeTag);
          '/' :
            begin
              if (FSrcPos = SrcLen) or (FSource[FSrcPos + 1] <> '>') then
                Raise ELMDMlGenException.Create(FOwner, SCanNotAnalyzeTag);
              ClosedTag := True;
              EndTag := True;
              inc(FSrcPos, 2);
              break;
            end;
          else
            s := s + FSource[FSrcPos]
        end; // case
        inc(FSrcPos);
      end;
      if (not EndTag) and ((FSrcPos > SrcLen) or (s = '')) then
      //if (FSrcPos > SrcLen) or ((s = '') and (not EndTag)) then
        Raise ELMDMlGenException.Create(FOwner, SCanNotAnalyzeTag);

      if EndTag then
      begin
        if s <> '' then
        begin
          // end of tag reached, param without value was at the end of the tag
          AddProp(s, '', PropCount);
        end;
        break;
      end;

      // check sign '='
      if FSource[FSrcPos] <> '=' then begin
        // this param has no values
        AddProp(s, '', PropCount);
        continue;
      end;
      inc(FSrcPos);

      // get param value
      if FSource[FSrcPos] = '"' then
        QuoutType := 1
      else
      if FSource[FSrcPos] = #39 then
        QuoutType := 2
      else
        QuoutType := 0;
      if QuoutType > 0 then
      begin
        QuoutBeginPos := FSrcPos;
        inc(FSrcPos);
      end;
      s1 := '';
      while FSrcPos <= SrcLen do begin
        case FSource[FSrcPos] of
          #10, #13 :
            begin
              if QuoutType > 0 then
              begin
                // if line feed character goes right after opening quote symbol, then
                // ignore it
                if FSrcPos <> (QuoutBeginPos+1) then
                  s1 := s1 + ' ';
              end
              else
                break;
              FSrcPos := GetPosOfNewString(FSource, FSrcPos) - 1;
              if FSrcPos < 0 then // true means that no beginning of the next line found
                FSrcPos := SrcLen;
            end;

          #9, ' ' :
            if QuoutType > 0 then
              s1 := s1 + FSource[FSrcPos]
            else
              break;

          '>' :
            if QuoutType > 0 then
              s1 := s1 + FSource[FSrcPos]
            else begin
              EndTag := True;
              break;
            end;

          '"' :
            case QuoutType of
              0: Raise ELMDMlGenException.Create(FOwner, SCanNotAnalyzeTag);
              1: break;
              2: s1 := s1 + FSource[FSrcPos];
            end;    // case

          #39 :
            case QuoutType of
              0: Raise ELMDMlGenException.Create(FOwner, SCanNotAnalyzeTag);
              1: s1 := s1 + FSource[FSrcPos];
              2: break;
            end;    // case

          '/' :
            if QuoutType > 0 then
              s1 := s1 + FSource[FSrcPos]
            else begin
              if (FSrcPos = SrcLen) or (FSource[FSrcPos + 1] <> '>') then
                Raise ELMDMlGenException.Create(FOwner, SCanNotAnalyzeTag);
              ClosedTag := True;
              EndTag := True;
              inc(FSrcPos, 2);
              break;
            end;

          else
            s1 := s1 + FSource[FSrcPos];
        end; // case
        inc(FSrcPos);
      end;
      inc(FSrcPos);
      AddProp(s, s1, PropCount);
    until EndTag;
  finally // wrap up
    SetLength(TagOptions.FData, PropCount);
  end;    // try/finally
end;{ TLMDMLGenSession.GetTagProp }

{$ifdef ELMLGEN_ACTIVEX}
procedure TLMDBaseMLGen.Paint;
begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(ClientRect);
  Canvas.BrushCopy(ClientRect, FIcon, Rect(0, 0, 24, 24), clFuchsia);
end;{TLMDBaseMLGen.Paint cat:Undefined}

procedure TLMDBaseMLGen.Resize;
begin
  inherited;
  SetBounds(Left, Top, 24, 24);
end;{TLMDBaseMLGen.Resize cat:Undefined}
{$endif}

procedure TLMDMLGenSession.PrepareTemplate;
var
  SrcLen: Integer;
  OldSrcPos, TagStart: Integer;
  i, LenTagPrefix: Integer;
  s: string;
  CommentPass: Boolean;
  BlockFound: Boolean;
  BlockName, BlockText: string;
  ParamsFound, CodeFound: Boolean;
  ParamName, TranslationTableName, ReplaceString: string;
  ParamNumb, ReplaceStringNumb: Integer;
  SavingInterval, CodeText: string;

  {$ifdef ELDEMO}
  FSource1 : array [0..DEMO_BUFFER_SIZE] of char;
  {$endif ELDEMO}

begin
  if not Assigned(FParentSession) then
  begin
    FOwner.FParameters.Clear;
    FOwner.FTranslationTables.Clear;
    FOwner.FCode.Clear;
  end;
  FBlocks.Clear;

  CommentPass := False;
  BlockFound := False;
  ParamsFound := False;
  CodeFound := False;
  ParamName := '';
  TranslationTableName := '';
  ReplaceString := '';
  CodeText := '';
  BlockText := '';

  {$ifdef ELDEMO}
    SrcLen := Length(FTemplate.Text);
    Move(FTemplate.Text[1], FSource1, SrcLen);
    SetLength(FSource, SrcLen);
    Move(FSource1, FSource[1], SrcLen);
  {$else ELDEMO}
    FSource := FTemplate.Text;
    SrcLen := Length(FSource);
  {$endif ELDEMO}
  // Cut last #13#10
  if (SrcLen >= 2) and (FSource[SrcLen-1] = #13) and (FSource[SrcLen] = #10) then
  begin
    dec(SrcLen, 2);
    SetLength(FSource, SrcLen);
  end;

  LenTagPrefix := Length(FOwner.FTagPrefix);
  FSrcPos := 1;
  OldSrcPos := 1;
  while FSrcPos <= SrcLen do begin
    TagStart := PosEx('<', FSource, SrcLen, FSrcPos);
    if TagStart <= 0 then begin
      break;
    end;

    FSrcPos := TagStart;
    i := FSrcPos + 1;
    s := GetWordEx(FSource, i, [' ', '>']);
    // If a space goes after '<', allow for it, since spaces were skipped
    // while searching for a word
    if (i <= FSrcPos) and (FSource[i] = ' ') then
      s := s + ' ';

    // Examine found tag
    if (FOwner.FTagPrefix = '') or (FOwner.FTagPrefix = Copy(s, 1, LenTagPrefix)) then
    begin // tag must be handled
      if FOwner.FTagPrefix <> '' then
        Delete(s, 1, LenTagPrefix);

      if not CommentPass then
      begin
        if BlockFound then
        begin
          // content handler for tags 'block' and '/block'
          if s = 'comment' then
          begin
            SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
            CommentPass := DoCommentBegin;
          end
          else
          if s = '/block' then
          begin
            SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
            BlockFound := not DoBlockEnd;
            if not BlockFound then
              CheckEndPos
            else begin
              inc(FSrcPos);
              SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
            end;
          end
          else begin
            inc(FSrcPos);
            SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
          end;
          BlockText := BlockText + SavingInterval;
          if not BlockFound then
          begin
            FBlocks.AddValue(BlockName, BlockText, nil);
            BlockText := '';
          end;
        end
        else begin
          if s = 'comment' then
          begin
            CommentPass := DoCommentBegin;
          end
          else
          if ParamsFound and (not Assigned(FParentSession)) then
          begin
            // content handler for tags params /params
            if TranslationTableName = '' then
            begin
              if ParamName = '' then
              begin
                if s = '/params' then begin
                  ParamsFound := False;
                  DoParamsEnd;
                end
                else
                if s = 'translation' then begin
                  DoTranslationBegin(TranslationTableName);
                end
                else
                if s = 'param' then begin
                  DoParamBegin(ParamName, ParamNumb);
                  CheckEndPos;
                end
                else
                  inc(FSrcPos);
              end // if not ParamFound
              else begin
                if s = '/param' then begin
                  SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
                  ParamName := '';
                  DoParamEnd;
                  CheckEndPos;
                end
                else begin
                  inc(FSrcPos);
                  SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
                end;
                with FOwner.FParameters.FData[ParamNumb] do
                  Value := Value + SavingInterval;
              end; // !if not ParamFound

            end
            else begin
              // content handler for tags translation /translation
              if ReplaceString = '' then
              begin
                if s = '/translation' then begin
                  DoTranslationEnd(TranslationTableName);
                end
                else
                if s = 'replace' then begin
                  DoReplaceBegin(ReplaceString, ReplaceStringNumb);
                  CheckEndPos;
                end
                else
                  inc(FSrcPos);
              end // if not ReplaceFound
              else begin
                if s = '/replace' then begin
                  SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
                  ReplaceString := '';
                  DoReplaceEnd;
                  CheckEndPos;
                end
                else begin
                  inc(FSrcPos);
                  SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
                end;
                with FOwner.FTranslationTable.Table.FData[ReplaceStringNumb] do
                  Value := Value + SavingInterval;
              end; // !if not ReplaceFound
            end;
          end
          else begin
            if CodeFound then
            begin
              // content handler for tags code /code
              if s = '/code' then begin
                SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
                CodeFound := False;
                DoCodeEnd(True);
                CheckEndPos;
              end
              else begin
                inc(FSrcPos);
                SavingInterval := Copy(FSource, OldSrcPos, FSrcPos - OldSrcPos);
              end;
              CodeText := CodeText + SavingInterval;
            end // if CodeFound
            else begin
              // handler at the moment of searching sections with params or script
              if s = 'block' then
              begin
                BlockFound := DoBlockBegin;
                if BlockFound then
                  BlockName := FBlockName;
                CheckEndPos;
              end
              else
              if s = 'params' then begin
                ParamsFound := DoParamsBegin;
              end
              else
              if s = 'code' then begin
                CodeFound := DoCodeBegin(True);
                // if CodeFound and (CodeText <> '') then
                //  CodeText := CodeText + #13#10;
                CheckEndPos;
              end
              else
              if (s = '/params') and (not Assigned(FParentSession)) then begin
                ParamsFound := False;
                DoParamsEnd;
              end
              else
                inc(FSrcPos);
            end; // !if CodeFound
          end; // !if ParamsFound
        end; // !if BlockFound
      end // if not CommentPass

      else begin // !if not CommentPass
        if s = '/comment' then begin
          CommentPass := not DoCommentEnd;
        end
        else begin
          inc(FSrcPos);
        end;
      end;

      OldSrcPos := FSrcPos;
    end
    else begin // skip other tags
      inc(FSrcPos);
    end;

  end; // while

  if ParamsFound or (TranslationTableName <> '') or (ParamName <> '') or
    (ReplaceString <> '') then
    Raise Exception.Create(SErrorInTemplateParamsDeclaration);

  if not Assigned(FParentSession) then
    FOwner.FCode.Text := CodeText;
end;{ TLMDMLGenSession.PrepareTemplate }

procedure TLMDMLGenSession.SetTemplate(Value: TStrings);
begin
  FTemplate.Assign(Value);
end;{ TLMDMLGenSession.SetTemplate }

procedure TLMDMLGenSession.StartSession(const TemplateName, BlockName,
        TemplateText : string);
var
  EmulateParentSession: Boolean;
  NewParentSession: TLMDMLGenSession;
begin
  EmulateParentSession := (not FSessionExecuting) and (FOwner.RootSession = self);
  if EmulateParentSession then
  begin
    // In this case we start another one session with part of current template, but
    // in such a way that session "thinks" it is the main
    NewParentSession := nil;
  end
  else begin
    NewParentSession := self
  end;
  FChildSession := TLMDMLGenSession.Create(FOwner, NewParentSession, Format('%s.%s', [TemplateName,BlockName]));
  try
    FChildSession.Template.Text := TemplateText;
    if EmulateParentSession then
      FOwner.FRootSession := FChildSession;
    try
      if (TemplateName <> FName) and (BlockName <> '') then
        FChildSession.ExecuteEx(BlockName)
      else
        FChildSession.Execute;
    finally
      if EmulateParentSession then
        FOwner.FRootSession := self;
    end;  // try/finally
  finally
    FChildSession.Free;
    FChildSession := nil;
  end;  // try/finally
end;{ TLMDMLGenSession.StartSession }

procedure TLMDMLGenSession.TemplateChanged(Sender: TObject);

  {$ifdef ELDEMO}
  var
    i : integer;
  {$endif ELDEMO}

begin
  if FSessionExecuting then
    Raise Exception.Create(SCanTChangeTemplateDuringExecution);
  {$ifdef ELDEMO}
  {$O-}
    i := DEMO_BUFFER_SIZE2;
    if Length(FTemplate.Text) >= i xor $0FF0 then
      Raise Exception.Create('This is a demo version of EldoS MLGen.'#13#10'Visit http://www.eldos.org/elmlgen/elmlgen.html to register your version.');
  {$O+}
  {$endif ELDEMO}
  PrepareTemplate;
end;{ TLMDMLGenSession.TemplateChanged }

{
****************************** TStringParameters *******************************
}
constructor TLMDStringParameters.Create;
begin
  inherited Create;
end;{ TStringParameters.Create }

destructor TLMDStringParameters.Destroy;
begin
  Clear;
  inherited Destroy;
end;{ TStringParameters.Destroy }

function TLMDStringParameters.AddValue(const aValueName, aValue : string;
        anObject1 : TObject): Integer;
begin
  Result := FindItemByName(aValueName);
  if Result < 0 then
  begin
    Result := Length(FData);
    SetLength(FData, Result + 1);
    with FData[Result] do
    begin
      ValueName := aValueName;
      Value := aValue;
      UserObject := anObject1;
    end;  // with
  end
  else begin
    with FData[Result] do
    begin
      Value := Value + aValue;
      if UserObject <> anObject1 then
      begin
        if (Assigned(FOnObjectRemove)) and Assigned(UserObject) then
          FOnObjectRemove(self, UserObject);
        UserObject := anObject1;
      end;
    end;
  end;
end;{ TStringParameters.AddValue }

procedure TLMDStringParameters.Assign(Source: TPersistent);
var
  i, j: Integer;
begin
  if Source is TLMDStringParameters then
  begin
    j := Length(TLMDStringParameters(Source).FData);
    BeforeDataClear;
    SetLength(FData, j);
    for i := 0 to j - 1 do
    begin
      with TLMDStringParameters(Source).FData[i] do
      begin
        FData[i].Value := Value;
        FData[i].ValueName := ValueName;
        FData[i].UserObject := UserObject;
      end;    // with
    end; // for
  end
  else
    inherited;
end;{ TStringParameters.Assign }

procedure TLMDStringParameters.AssignTo(Dest: TPersistent);
var
  i: Integer;
begin
  if Dest is TLMDStringParameters then
    Dest.Assign(self)
  else
    if Dest is TStrings then
    begin
      TStrings(Dest).Clear;
      if Length(FData) > 0 then
        for i := 0 to High(FData) do
        begin
          TStrings(Dest).Add(Format('%s=%s', [FData[i].ValueName, FData[i].Value]));
        end; // for
    end
    else
      inherited;
end;{ TStringParameters.AssignTo }

procedure TLMDStringParameters.BeforeDataClear;
var
  i: Integer;
begin
  if Assigned(FOnObjectRemove) then
  begin
    for i := 0 to High(FData) do
      if Assigned(FData[i].UserObject) then
        FOnObjectRemove(self, FData[i].UserObject);
  end;
end;{ TStringParameters.BeforeDataClear }

procedure TLMDStringParameters.Clear;
begin
  BeforeDataClear;
  FData := nil;
end;{ TStringParameters.Clear }

function TLMDStringParameters.FindItemByName(ValueName : string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Length(FData) -1 do
  begin
    if FData[i].ValueName = ValueName then
    begin
      Result := i;
      break;
    end;
  end; // for
end;{ TStringParameters.FindItemByName }

function TLMDStringParameters.GetanObject(Index: Integer): TObject;
begin
  Result := FData[Index].UserObject;
end;{ TStringParameters.GetanObject }

function TLMDStringParameters.GetanObjectByName(ValueName : string): TObject;
var
  i: Integer;
begin
  i := FindItemByName(ValueName);
  if i < 0 then
    Raise Exception.Create(Format(SCanNotFindValueNameS, [ValueName]));
  Result := FData[i].UserObject;
end;{ TStringParameters.GetanObjectByName }

function TLMDStringParameters.GetCount: Integer;
begin
  Result := Length(FData);
end;{ TStringParameters.GetCount }

procedure TLMDStringParameters.GetNames(Strings : TStrings);
var
  i: Integer;
begin
  for i := 0 to Length(FData) - 1 do
   Strings.Add(FData[i].ValueName);
end;{ TStringParameters.GetNames }

function TLMDStringParameters.GetValue(Index: Integer): string;
begin
  Result := FData[Index].Value;
end;{ TStringParameters.GetValue }

function TLMDStringParameters.GetValueByName(ValueName : string): string;
var
  i: Integer;
begin
  i := FindItemByName(ValueName);
  if i < 0 then
    Raise Exception.Create(Format(SCanNotFindValueNameS, [ValueName]));
  Result := FData[i].Value;
end;{ TStringParameters.GetValueByName }

function TLMDStringParameters.GetValueByNameEx(ValueName, DefaultValue : string):
        string;
var
  i: Integer;
begin
  i := FindItemByName(ValueName);
  if i >= 0 then
    Result := FData[i].Value
  else
    Result := DefaultValue;
end;{ TStringParameters.GetValueByNameEx }

function TLMDStringParameters.GetValueName(Index: Integer): string;
begin
  Result := FData[Index].ValueName;
end;{ TStringParameters.GetValueName }

procedure TLMDStringParameters.RemoveValue(const Index : integer);
var
  i, j: Integer;
begin
  if (Assigned(FOnObjectRemove)) and (Assigned(FData[Index].UserObject)) then
    FOnObjectRemove(self, FData[Index].UserObject);
  j := Length(FData);
  for i := Index to j - 2 do
  begin
    FData[i] := FData[i+1];
  end;  // for
  SetLength(FData, j - 1);
end;{ TStringParameters.RemoveValue }

procedure TLMDStringParameters.RemoveValueByName(const aValueName : string);
begin
  RemoveValue(FindItemByName(aValueName));
end;{ TStringParameters.RemoveValueByName }

procedure TLMDStringParameters.ReplaceValue(Index : integer; const aValue :
        string);
begin
  with FData[Index] do
    Value := aValue;
end;{ TStringParameters.ReplaceValue }

function TLMDStringParameters.ReplaceValueByName(const aValueName, aValue :
        string): Integer;
begin
  Result := FindItemByName(aValueName);
  if Result < 0 then
  begin
    Result := Length(FData);
    SetLength(FData, Result + 1);
    with FData[Result] do
    begin
      ValueName := aValueName;
      Value := aValue;
    end;  // with
  end
  else begin
    with FData[Result] do
      Value := aValue;
  end;
end;{ TStringParameters.ReplaceValueByName }

procedure TLMDStringParameters.SetanObject(Index: Integer; const Value: TObject);
begin
  FData[Index].UserObject := Value;
end;{ TStringParameters.SetanObject }

procedure TLMDStringParameters.SetanObjectByName(ValueName : string; const Value:
        TObject);
var
  i: Integer;
begin
  i := FindItemByName(ValueName);
  if i < 0 then
    Raise Exception.Create(Format(SCanNotFindValueNameS, [ValueName]));
  FData[i].UserObject := Value;
end;{ TStringParameters.SetanObjectByName }

procedure TLMDStringParameters.SetValue(Index: Integer; const Value: string);
begin
  FData[Index].Value := Value;
end;{ TStringParameters.SetValue }

procedure TLMDStringParameters.SetValueByName(ValueName : string; const Value:
        string);
var
  i: Integer;
begin
  i := FindItemByName(ValueName);
  if i < 0 then
    Raise Exception.Create(Format(SCanNotFindValueNameS, [ValueName]));
  FData[i].Value := Value;
end;{ TStringParameters.SetValueByName }

procedure TLMDStringParameters.SetValueName(Index: Integer; const Value: string);
begin
  FData[Index].ValueName := Value;
end;{ TStringParameters.SetValueName }

{
****************************** TTranslationTables ******************************
}
constructor TLMDTranslationTables.Create;
begin
  inherited Create(TLMDTranslationTable);
  FDefaultForMacro := -1;
  FDefaultForTemplate := -1;
end;{ TTranslationTables.Create }

function TLMDTranslationTables.Add(const TableName : string): TLMDTranslationTable;
var
  i: Integer;
begin
  i := FindTableByName(TableName);
  if i >= 0 then
    Raise Exception.Create(SDuplicateTranslationTableName);
  Result := TLMDTranslationTable(inherited Add);
  Result.Name := TableName;
end;{ TTranslationTables.Add }

procedure TLMDTranslationTables.Assign(Source: TPersistent);
begin
  if Source is TLMDTranslationTables then
  begin
    inherited Assign(Source);
    DefaultForMacro := TLMDTranslationTables(Source).DefaultForMacro;
    DefaultForCode := TLMDTranslationTables(Source).DefaultForCode;
    DefaultForTemplate := TLMDTranslationTables(Source).DefaultForTemplate;
  end
  else
    Raise Exception.Create(SCanNotAssignObjectToTranslationTableList);
end;{ TTranslationTables.Assign }

procedure TLMDTranslationTables.Clear;
begin
  FDefaultForMacro := -1;
  FDefaultForTemplate := -1;
  inherited Clear;
end;{ TTranslationTables.Clear }

function TLMDTranslationTables.FindTableByName(const TableName : string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if Items[i].Name = TableName then
    begin
      Result := i;
      break;
    end;
  end; // for
end;{ TTranslationTables.FindTableByName }

function TLMDTranslationTables.GetItems(Index: Integer): TLMDTranslationTable;
begin
  Result := TLMDTranslationTable(inherited GetItem(Index));
end;{ TTranslationTables.GetItems }

procedure TLMDTranslationTables.GetTableNames(Strings : TStrings);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Strings.Add(Items[i].Name);
  end; // for
end;{ TTranslationTables.GetTableNames }

procedure TLMDTranslationTables.SetDefaultForCode(const Value: Integer);
begin
  if FDefaultForCode <> Value then
  begin
    if Value >= Count then
      Raise Exception.Create(SCanNotSetDefaultTranslationTableIndexOutOfRange);
    FDefaultForCode := Value;
  end;
end; { TLMDTranslationTables.SetDefaultForCode }

procedure TLMDTranslationTables.SetDefaultForMacro(Value: Integer);
begin
  if FDefaultForMacro <> Value then
  begin
    if Value >= Count then
      Raise Exception.Create(SCanNotSetDefaultTranslationTableIndexOutOfRange);
    FDefaultForMacro := Value;
  end;
end;{ TTranslationTables.SetDefaultForMacro }

procedure TLMDTranslationTables.SetDefaultForTemplate(Value: Integer);
begin
  if FDefaultForTemplate <> Value then
  begin
    if Value >= Count then
      Raise Exception.Create(SCanNotSetDefaultTranslationTableIndexOutOfRange);
    FDefaultForTemplate := Value;
  end;
end;{ TTranslationTables.SetDefaultForTemplate }

procedure TLMDTranslationTables.SetItems(Index: Integer; Value: TLMDTranslationTable);
begin
  inherited SetItem(Index, Value);
end;{ TTranslationTables.SetItems }

{
****************************** TTranslationTable *******************************
}
constructor TLMDTranslationTable.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  // FName := '';
  FTable := TLMDStringParameters.Create;
end;{ TTranslationTable.Create }

destructor TLMDTranslationTable.Destroy;
begin
  if Assigned(Collection) and (Collection is TLMDTranslationTables) then
  begin
    if TLMDTranslationTables(Collection).DefaultForMacro = Index then
      TLMDTranslationTables(Collection).DefaultForMacro := -1;
    if TLMDTranslationTables(Collection).DefaultForCode = Index then
      TLMDTranslationTables(Collection).DefaultForCode := -1;
    if TLMDTranslationTables(Collection).DefaultForTemplate = Index then
      TLMDTranslationTables(Collection).DefaultForTemplate := -1;
  end;
  FTable.Free;
  inherited Destroy;
end;{ TTranslationTable.Destroy }

procedure TLMDTranslationTable.Assign(Source: TPersistent);
begin
  if Source is TLMDTranslationTable then
  begin
    FName := TLMDTranslationTable(Source).Name;
    FTable.Assign(TLMDTranslationTable(Source).Table);
  end
  else
    Raise Exception.Create(SCanNotAssignToTranslationTable);
end;{ TTranslationTable.Assign }

function TLMDTranslationTable.Translate(Source : string): string;
var
  i, j, k, SrcPos, SrcLen, ReplCount: Integer;
  s: string;
  Replace: Boolean;
begin
  Result := '';
  SrcLen := Length(Source);
  SrcPos := 1;
  ReplCount := High(FTable.FData);
  while SrcPos <= SrcLen do
  begin
    Replace := False;
    for i := 0 to ReplCount do
    begin
      s := FTable.FData[i].ValueName;
      k := Length(s);
      if (SrcPos + k - 1) <= SrcLen then
      begin
        Replace := True;
        for j := 1 to k do
        begin
          if Source[SrcPos + j - 1] <> s[j] then
          begin
            Replace := False;
            break;
          end;
        end; // for
        if Replace then
        begin
          Result := Result + FTable.FData[i].Value;
          inc(SrcPos, k);
          break;
        end;
      end;
    end; // for
    if not Replace then
    begin
      Result := Result + Source[SrcPos];
      inc(SrcPos);
    end;
  end;    // while
end;{ TTranslationTable.Translate }

{
********************************* TLMDBaseMLGen *********************************
}
constructor TLMDBaseMLGen.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Init;
end;{ TLMDBaseMLGen.Create }

constructor TLMDBaseMLGen.CreateFrom(AOwner: TLMDBaseMLGen);
begin
  inherited Create(AOwner);
  Init;

  FCode.Assign(AOwner.FCode);
  FCustomTagNames.Assign(AOwner.FCustomTagNames);
  FParameters.Assign(AOwner.FParameters);
  FTagPrefix := AOwner.FTagPrefix;
  FTranslationTables.Assign(AOwner.FTranslationTables);
  FRootSession.Assign(AOwner.FRootSession);
end;{ TLMDBaseMLGen.CreateFrom }

procedure TLMDBaseMLGen.Init;
begin
  {$ifdef ELMLGEN_ACTIVEX}
  FIcon := TBitmap.Create;
  FIcon.LoadFromResourceName(Hinstance, 'TELMLGEN');
  {$endif}
  // FExecuting := False;
  // FNewPageProcessing := False;
  // FEnteringInNextPage := False;
  // FSource := '';
  // FCommentName := '';
  // FBlockName := '';
  // FTagPrefix := '';
  // FLoopBreak := '';
  // FTranslationTable := nil;
  FCode := TStringList.Create;
  FCustomTagNames := TStringList.Create;
  FParameters := TLMDStringParameters.Create;
  FTranslationTables := TLMDTranslationTables.Create;
  FRootSession := TLMDMLGenSession.Create(self, nil, 'Main');
end;

destructor TLMDBaseMLGen.Destroy;
begin
  FRootSession.Free;
  FRootSession := nil;
  FTranslationTables.Free;
  FParameters.Free;
  FCode.Free;
  FCustomTagNames.Free;
  {$ifdef ELMLGEN_ACTIVEX}
  FIcon.Free;
  {$endif}
  inherited Destroy;
end;{ TLMDBaseMLGen.Destroy }

procedure TLMDBaseMLGen.Abort;
begin
  FCancelJob := True;
end;{ TLMDBaseMLGen.Abort }

procedure TLMDBaseMLGen.Assign(Source: TPersistent);
begin
  inherited;
  //Raise Exception.Create('TLMDBaseMLGen.Assign: Can not assign unknown object.');
end;{ TLMDBaseMLGen.Assign }

procedure TLMDBaseMLGen.DoNextPage;
begin
  if FCurrentSession <> FRootSession then
    Raise Exception.Create('Can not start new page'); //en
  FNewPageProcessing := False;
  if Length(FCurrentSession.FLoopCountersRzrv) <> 0 then
    FEnteringInNextPage := True;
  inc(FPageCount);
  FCurrentSession.FreeArrays;
  PageBegin(PageCount);
end;{ TLMDBaseMLGen.DoNextPage }

{{
Starts template processing.
}
procedure TLMDBaseMLGen.Execute;
begin
  if FExecuting then
    Raise Exception.Create('Recursive call is impossible'); //en
  FExecuting := True;
  try
    FCancelJob := False;
    FPageCount := 0;
    BeforeExecute;

    FRootSession.Execute;

  finally // wrap up
    FExecuting := False;
    AfterExecute;
  end;    // try/finally
end;{ TLMDBaseMLGen.Execute }

procedure TLMDBaseMLGen.ExecuteEx(BlockName : string);
begin
  if FExecuting then
    Raise Exception.Create('Recursive call is impossible'); //en
  FExecuting := True;
  try
    FCancelJob := False;
    FPageCount := 0;
    BeforeExecute;

    FRootSession.ExecuteEx(BlockName);

  finally // wrap up
    FExecuting := False;
    AfterExecute;
  end;    // try/finally
end;{ TLMDBaseMLGen.ExecuteEx }

function TLMDBaseMLGen.GetBlocks: TLMDStringParameters;
begin
  Result := FRootSession.FBlocks;
end;{ TLMDBaseMLGen.GetBlocks }

function TLMDBaseMLGen.GetLoopCount: Integer;
begin
  Result := Length(FCurrentSession.FLoopCounters);
end;{ TLMDBaseMLGen.GetLoopCount }

function TLMDBaseMLGen.GetLoopCounter(Index: Integer): Integer;
begin
  if (Index < 0) or (Index >= Length(FCurrentSession.FLoopCounters)) then
    Raise Exception.Create(SIndexOutOfRange);
  Result := FCurrentSession.FLoopCounters[Index];
end;{ TLMDBaseMLGen.GetLoopCounter }

function TLMDBaseMLGen.GetLoopCountersCurrentPage(Index: Integer): Integer;
begin
  if (Index < 0) or (Index >= Length(FCurrentSession.FLoopCountersCurrentPage)) then
    Raise Exception.Create(SIndexOutOfRange);
  Result := FCurrentSession.FLoopCountersCurrentPage[Index];
end;{ TLMDBaseMLGen.GetLoopCountersCurrentPage }

function TLMDBaseMLGen.GetLoopCountersCurrentPageStr(LoopName : string): Integer;
var
  Index: Integer;
begin
  Index := GetLoopIndex(LoopName);
  if (Index < 0) or (Index >= Length(FCurrentSession.FLoopCountersCurrentPage)) then
    Raise Exception.Create(SLoopNameIsNotFound);
  Result := FCurrentSession.FLoopCountersCurrentPage[Index];
end;{ TLMDBaseMLGen.GetLoopCountersCurrentPageStr }

function TLMDBaseMLGen.GetLoopCounterStr(LoopName : string): Integer;
var
  Index: Integer;
begin
  Index := GetLoopIndex(LoopName);
  if (Index < 0) or (Index >= Length(FCurrentSession.FLoopCounters)) then
    Raise Exception.Create(SLoopNameIsNotFound);
  Result := FCurrentSession.FLoopCounters[Index];
end;{ TLMDBaseMLGen.GetLoopCounterStr }

function TLMDBaseMLGen.GetLoopIndex(const LoopName : string): Integer;
begin
  Result := FCurrentSession.GetLoopIndex(LoopName);
end;{ TLMDBaseMLGen.GetLoopIndex }

function TLMDBaseMLGen.GetLoopName(Index: Integer): string;
begin
  if (Index < 0) or (Index >= Length(FCurrentSession.FLoopNames)) then
    Raise Exception.Create(SIndexOutOfRange);
  Result := FCurrentSession.FLoopNames[Index];
end;{ TLMDBaseMLGen.GetLoopName }

function TLMDBaseMLGen.GetTemplate: TStrings;
begin
  Result := FRootSession.FTemplate;
end;{ TLMDBaseMLGen.GetTemplate }

procedure TLMDBaseMLGen.IsIfValid(aName : string; TagParameters :
        TLMDStringParameters; var Result : boolean);
begin
end;{ TLMDBaseMLGen.IsIfValid }

procedure TLMDBaseMLGen.IsLoopValid(aName : string; TagParameters :
        TLMDStringParameters; var Result : boolean);
begin
end;{ TLMDBaseMLGen.IsLoopValid }

procedure TLMDBaseMLGen.IsMacroValid(aName : string; TagParameters :
        TLMDStringParameters; var Result : boolean);
begin
end;{ TLMDBaseMLGen.IsMacroValid }

procedure TLMDBaseMLGen.IsTag(TagName : string; var IsTag : boolean);
begin
  IsTag := FCustomTagNames.IndexOf(TagName) >=0;
end;{ TLMDBaseMLGen.IsTag }

procedure TLMDBaseMLGen.LoopBreak(LoopName : string);
var
  i: Integer;
begin
  i := GetLoopIndex(LoopName);
  if i < 0 then
    Raise Exception.Create(SAttemptToCloseTheLoopThatHasNotBeenOpenedBefore);
  FCurrentSession.FLoopBreak := LoopName;
end;{ TLMDBaseMLGen.LoopBreak }

procedure TLMDBaseMLGen.LoopContinue(LoopName : string);
begin
end;{ TLMDBaseMLGen.LoopContinue }

procedure TLMDBaseMLGen.NextPage;
var
  i, j: Integer;
begin
  {$ifdef INC_SyntaxCheck}
    if FSyntaxCheck then
      Raise Exception.Create('NextPage command is not available on syntax check.'); //en
  {$endif INC_SyntaxCheck}
  if FCurrentSession <> FRootSession then
    Raise Exception.Create('NextPage command inside block is not available .'); //en
  if FNewPageProcessing or FEnteringInNextPage then
    Raise Exception.Create(SRepeatedRequestForNewPageIsNotAllowed);
  FNewPageProcessing := True;

  j := Length(FCurrentSession.FLoopBeginPos);
  SetLength(FCurrentSession.FLoopBeginPosRzrv, j);
  for i := 0 to j-1 do
    FCurrentSession.FLoopBeginPosRzrv[i] := FCurrentSession.FLoopBeginPos[i];

  j := Length(FCurrentSession.FLoopCounters);
  SetLength(FCurrentSession.FLoopCountersRzrv, j);
  for i := 0 to j-1 do
    FCurrentSession.FLoopCountersRzrv[i] := FCurrentSession.FLoopCounters[i];

  j := Length(FCurrentSession.FLoopNames);
  SetLength(FCurrentSession.FLoopNamesRzrv, j);
  for i := 0 to j-1 do
    FCurrentSession.FLoopNamesRzrv[i] := FCurrentSession.FLoopNames[i];
end;{ TLMDBaseMLGen.NextPage }

procedure TLMDBaseMLGen.ProcessMessages;
begin
end;{ TLMDBaseMLGen.ProcessMessages }

procedure TLMDBaseMLGen.SetCustomTagNames(Value: TStrings);
begin
  FCustomTagNames.Assign(Value);
end;{ TLMDBaseMLGen.SetCustomTagNames }

procedure TLMDBaseMLGen.SetTagPrefix(const Value: string);
var
  i: Integer;
begin
  if FTagPrefix <> Value then
  begin
    // Checking is prefix correct
    for i := 1 to Length(Value) do
    begin
      if LMDAnsiCharInSet(Value[i], [#0..' ', '"', #39, '<', '>', '/']) then
      Raise Exception.Create(Format(SInvalidCharDSInTagPrefixString, [i, Value[i]]));
    end; // for
    FTagPrefix := Value;
  end;
end;{ TLMDBaseMLGen.SetTagPrefix }

procedure TLMDBaseMLGen.SetTemplate(Value: TStrings);
begin
  FRootSession.FTemplate.Assign(Value);
end;{ TLMDBaseMLGen.SetTemplate }

procedure TLMDBaseMLGen.SyntaxCheck;
begin
  {$ifdef INC_SyntaxCheck}
  FSyntaxCheck := True;
  try
    Execute;
  finally
    FSyntaxCheck := False;
  end;  // try/finally
  {$else INC_SyntaxCheck}
  Raise Exception.Create('This is a lite version of EldoS MLGen.'#13#10'Visit http://www.eldos.org/elmlgen/elmlgen.html to register your version.');
  {$endif INC_SyntaxCheck}
end;{ TLMDBaseMLGen.SyntaxCheck }

procedure TLMDBaseMLGen.TagFound(Tag : string; const TagClosed : boolean;
        TagParameters : TLMDStringParameters);
begin
end;{ TLMDBaseMLGen.TagFound }

procedure TLMDBaseMLGen.TemplateNeeded(TemplateName : string; TagParameters :
        TLMDStringParameters; var Result : string);
begin
end;{ TLMDBaseMLGen.TemplateNeeded }

{****************************** TLMDCustomMLGen ********************************}
procedure TLMDCustomMLGen.AfterExecute;
begin
  if Assigned(FOnAfterExecute) then
    FOnAfterExecute(self);
end;{ TLMDCustomMLGen.AfterExecute }

procedure TLMDCustomMLGen.BeforeExecute;
begin
  if Assigned(FOnBeforeExecute) then
    FOnBeforeExecute(self);
end; { TLMDCustomMLGen.BeforeExecute }

procedure TLMDCustomMLGen.CodeFound(CodeName: string;
  TagParameters: TLMDStringParameters; ClosedTag: Boolean; Code: TStringList;
  var CodeResult: string; var UseTranslationTable: boolean);
begin
  if Assigned(FOnCodeFound) then
    FOnCodeFound(Self, CodeName, TagParameters, ClosedTag, Code, CodeResult,
                 UseTranslationTable);
end; { TLMDCustomMLGen.CodeFound }

procedure TLMDCustomMLGen.IfFound(IfName : string; TagParameters :
        TLMDStringParameters; var ResultValue : boolean);
begin
  if Assigned(FOnIfFound) then
    FOnIfFound(self, IfName, TagParameters, ResultValue);
end;{ TLMDCustomMLGen.IfFound }

procedure TLMDCustomMLGen.IsIfValid(aName : string; TagParameters :
        TLMDStringParameters; var Result : boolean);
begin
  if Assigned(FOnIsIfValid) then
    FOnIfFound(self, aName, TagParameters, Result);
end;{ TLMDCustomMLGen.IsIfValid }

procedure TLMDCustomMLGen.IsLoopValid(aName : string; TagParameters :
        TLMDStringParameters; var Result : boolean);
begin
  if Assigned(FOnIsLoopValid) then
    FOnIfFound(self, aName, TagParameters, Result);
end;{ TLMDCustomMLGen.IsLoopValid }

procedure TLMDCustomMLGen.IsMacroValid(aName : string; TagParameters :
        TLMDStringParameters; var Result : boolean);
begin
  if Assigned(FOnIsMacroValid) then
    FOnIfFound(self, aName, TagParameters, Result);
end;{ TLMDCustomMLGen.IsMacroValid }

procedure TLMDCustomMLGen.IsTag(TagName : string; var IsTag : boolean);
begin
  inherited IsTag(TagName, IsTag);
  if Assigned(FOnIsTag) then
    FOnIsTag(Self, TagName, IsTag);
end;{ TLMDCustomMLGen.IsTag }

procedure TLMDCustomMLGen.LoopIteration(LoopNumb: integer; LoopName: string;
        TagParameters : TLMDStringParameters; var LoopDone : boolean);
begin
  if Assigned(FOnLoopIteration) then
    FOnLoopIteration(self, LoopNumb, LoopName, TagParameters, LoopDone);
end;{ TLMDCustomMLGen.LoopIteration }

procedure TLMDCustomMLGen.MacroFound(MacroName : string; TagParameters :
        TLMDStringParameters; var MacroResult : string; var UseTranslationTable :
        boolean);
begin
  if Assigned(FOnMacroFound) then
    FOnMacroFound(self, MacroName, TagParameters, MacroResult, UseTranslationTable)
end;{ TLMDCustomMLGen.MacroFound }

procedure TLMDCustomMLGen.PageBegin(PageNumb : integer);
begin
  if Assigned(FOnPageBegin) then
    FOnPageBegin(self, PageNumb);
end;{ TLMDCustomMLGen.PageBegin }

procedure TLMDCustomMLGen.PageEnd(PageNumb : integer);
begin
  if Assigned(FOnPageEnd) then
    FOnPageEnd(self, PageNumb);
end;{ TLMDCustomMLGen.PageEnd }

procedure TLMDCustomMLGen.ProcessMessages;
begin
  if Assigned(FOnProcessMessages) then
    FOnProcessMessages(self);
end;{ TLMDCustomMLGen.ProcessMessages }

procedure TLMDCustomMLGen.TagFound(Tag : string; const TagClosed : boolean;
        TagParameters : TLMDStringParameters);
begin
  if Assigned(FOnTagFound) then
    FOnTagFound(self, Tag, TagClosed, TagParameters);
end;{ TLMDCustomMLGen.TagFound }

procedure TLMDCustomMLGen.TemplateNeeded(TemplateName : string; TagParameters :
        TLMDStringParameters; var Result : string);
begin
  if Assigned(FOnTemplateNeeded) then
    FOnTemplateNeeded(self, TemplateName, TagParameters, Result);
end;{ TLMDCustomMLGen.TemplateNeeded }

procedure TLMDCustomMLGen.WriteString(Value : string);
begin
  if Assigned(FOnWriteString) then
    FOnWriteString(self, Value);
end;{ TLMDCustomMLGen.WriteString }

{****************************** ELMDMlGenException ********************************}
constructor ELMDMlGenException.Create(MlGen : TLMDBaseMLGen; Msg: string);
var
  i, j, k: Integer;
begin
  //inherited Create(Msg);
  FMlGen := MlGen;
  i := Length(Msg);
  if i > 0 then begin
    if Msg[i] <> '.' then
      Msg := Msg + '.';
  end
  else
    Msg := SError;
  if Assigned(MlGen.FCurrentSession) then
  begin
    GetTextLineByStringPos(MlGen.FCurrentSession.FSource, MlGen.FCurrentSession.FSrcPos, j, k);
    inherited Create(Format(SSessionLineChar, [MlGen.FCurrentSession.FName, Msg, j, k]));
  end
  else begin
  inherited Create(Msg);
  end;
end; { ELMDMlGenException.Create }

end.
