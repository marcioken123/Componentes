unit LMDParser;
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

LMDParser unit (VO)
-------------------

Base parser 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDText, LMDLex;

type
  { ****************************** TLMDParser **********************************}
  TLMDParser = class
  private
    FLex: TLMDLex;
  protected
    function GetLexClass: TLMDLexClass; virtual; abstract;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Lex: TLMDLex read FLex;
    function Parse(aStream: TStream;
      aGraphicErrorEvent: TLMDGraphicErrorEvent;
      aGetVariable: TLMDGetVariableEvent;
      aEmbdControlCreated : TLMDEmbdControlEvent;
      aRepeatEvent : TLMDRepeatEvent): TLMDParsedTextList; virtual; abstract;
  end;

  TLMDParserClass = class of TLMDParser;

  PLMDParserRec = ^TLMDParserRec;
  TLMDParserRec = record
    Default: Boolean;
    ParserClass: TLMDParserClass;
    Extentions: PAnsiChar;//array of string;
  end;
  { ********************************* Register routines ************************}
procedure RegisterParser(aParserClass: TLMDParserClass;
  const aExtentions: array of AnsiString; aDefault: Boolean);
procedure UnregisterParser(aParserClass: TLMDParserClass);
function Parsers: TList;
function DefaultParserClass: TLMDParserClass;
function GetParser (const Fileext: AnsiString): TLMDParserClass;

implementation

uses
  sysutils
  {$ifdef LMDCOMP12}
   , AnsiStrings
  {$endif}
  {$IFDEF LMD_DEBUGTRACE}
   , Windows
   , dialogs;
  {$I C2.INC}
{$ELSE}
  ;
{$ENDIF}

var
  FParsers: TList;

  { ********************************* Register routines ************************}
  {-----------------------------------------------------------------------------}

procedure RegisterParser(aParserClass: TLMDParserClass;
  const aExtentions: array of AnsiString; aDefault: Boolean);
var
  P: PLMDParserRec;
  I: LongInt;
  S: AnsiString;
begin
  GetMem(P, SizeOf(TLMDParserRec));
  P.Default:= aDefault;
  P.ParserClass:= aParserClass;
  S:= '';
  for I := 0 to Length(aExtentions) - 1 do
  begin
    if  S <> '' then
      S:= S + ';';
    S:= S + aExtentions[I];
  end;

  GetMem(P.Extentions, Length(S) + 1);
  {$IFDEF LMDCOMP18}AnsiStrings.{$ENDIF}StrCopy(P.Extentions, PAnsiChar(S));
  if aDefault then
    begin
      for I:= 0 to FParsers.Count - 1 do
        if PLMDParserRec(FParsers[I]).Default then
          begin
            PLMDParserRec(FParsers[I]).Default:= false;
            Break;
          end;
    end;
  FParsers.Add(P);
end;

{-----------------------------------------------------------------------------}

procedure UnregisterParser(aParserClass: TLMDParserClass);
var
  I: LongInt;
begin
  for I:= 0 to FParsers.Count - 1 do
    if PLMDParserRec(FParsers[I])^.ParserClass = aParserClass then
    begin
        FreeMem(PLMDParserRec(FParsers[I]).Extentions,
          Length(PLMDParserRec(FParsers[I]).Extentions) + 1);
        FreeMem(FParsers[I], SizeOf(TLMDParserRec));
        FParsers.Delete(I);
        Break;
      end;
end;

{-----------------------------------------------------------------------------}

function Parsers: TList;
begin
  Result:= FParsers
end;

{-----------------------------------------------------------------------------}

function DefaultParserClass: TLMDParserClass;
var
  I: LongInt;
begin
  for I:= 0 to FParsers.Count - 1 do
    if PLMDParserRec(FParsers[I]).Default then
      begin
        Result:= PLMDParserRec(FParsers[I]).ParserClass;
        Exit;
      end;
  if FParsers.Count > 0 then
    Result:= PLMDParserRec(FParsers[0]).ParserClass
  else
    raise Exception.Create('Don''t have any registered parser...')
end;

function GetParser (const FileExt: AnsiString): TLMDParserClass;
var
  I{, J}: LongInt;
begin
  for I:= 0 to FParsers.Count - 1 do
    if Pos(AnsiUpperCase(FileExt),
      AnsiUpperCase(PLMDParserRec(FParsers[I]).Extentions)) > 0 then
    begin
            Result:= PLMDParserRec(FParsers[I]).ParserClass;
            exit;
        end;
  result := nil;
end;

constructor TLMDParser.Create;
begin
  inherited;
  FLex := GetLexClass.Create;
end;

destructor TLMDParser.Destroy;
begin
  FLex.Free;
  inherited ;
end;

initialization
  FParsers:= TList.Create;

finalization
  while FParsers.Count > 0 do
    UnregisterParser(PLMDParserRec(FParsers[0])^.ParserClass);
    FParsers.Free;

end.
