unit ElStrToken;
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

ElStrToken unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  LMDElConst,
  Classes,
  SysUtils;

type
  EElStrTokenizerError = class(Exception) end;

  TElStringTokenizer = class
  private
    FPos : Integer;
    FSourceString : String;
    FReturnDelims: Boolean;
    FDelimiters   : string;
    FLastWasToken : boolean;
    FSkipEmptyTokens: Boolean;
    procedure SetSourceString(newValue : String);
    function IntHasMoreTokens : Boolean;
    function IntNextToken(var AResult : string) : boolean;
  public
    constructor Create;
    constructor CreateStr(str : String);
    constructor CreateStrDelim(str : String; Delim : string);
    constructor CreateStrDelimEx(str : String; Delim : string; ReturnDelims :
        boolean);

    function  HasMoreTokens : Boolean;
    function  NextToken : String;
    function  CountTokens : Integer;
    function  NextTokenDelim(Delims : string) : String;
    procedure FindAll(AStrings : TStrings);
  public
    property SourceString : String read FSourceString write SetSourceString;  { Published }
    property ReturnDelims: Boolean read FReturnDelims write FReturnDelims;
    property Delimiters: string read FDelimiters write FDelimiters;  { Published }
    property SkipEmptyTokens: Boolean read FSkipEmptyTokens write FSkipEmptyTokens;
  end;

implementation

procedure RaiseNoMoreTokensError;
begin
  raise EElStrTokenizerError.Create(SLMDNoMoreTokensMessage);
end;

procedure TElStringTokenizer.SetSourceString(newValue : String);
{ Sets data member FSourceString to newValue. }
begin
  //if (FSourceString <> newValue) then
  begin
    FSourceString := newValue;
    FPos := 1;
    FLastWasToken := true;
  end;  { if }
end;  { SetSourceString }

function TElStringTokenizer.IntHasMoreTokens : Boolean;  { public }
var S   : string;
begin
  result := IntNextToken(S);
end;  { HasMoreTokens }

function TElStringTokenizer.HasMoreTokens : Boolean;  { public }
var FSP : integer;
    FWT : boolean;
    S   : string;
begin
  FSP := FPos;
  FWT := FLastWasToken;
  result := IntNextToken(S);
  FLastWasToken := FWT;
  FPos := FSP;
end;  { HasMoreTokens }

function TElStringTokenizer.NextToken : String;  { public }
begin
  if not IntNextToken(result) then
     RaiseNoMoreTokensError;
end;

function TElStringTokenizer.IntNextToken(var AResult : string) : boolean;
var
  i : integer;
  P : PChar;
  label
  a1;

begin
  if Length(FSourceString) < FPos then
  begin
    result := false;
    exit;
  end;

a1:
  P := PChar(@FSourceString[FPos]);
  if (Pos(P^, FDelimiters) > 0) then
  begin
    if FLastWasToken then
    begin
      if not SkipEmptyTokens then
      begin
        AResult := '';
        FLastWasToken := false;
        result := true;
        exit;
      end;
    end
    else
    // last was not token
    if ReturnDelims then
    begin
      AResult := P^;
      FLastWasToken := true;
      inc(FPos);
      result := true;
      exit;
    end;
    inc(FPos);
    inc(P);
  end;
  i := FPos;
  while (P^ <> #0) do
  begin
    if Pos(P^, FDelimiters) > 0 then
    break;
    inc(i);
    inc(P);
  end;
  AResult := Copy(FSourceString, FPos, i - FPos);
  FLastWasToken := false;
  if (i = FPos) and (P^ = #0) then
  begin
    result := false;
    exit;
  end;
  if (Length(AResult) = 0) and (SkipEmptyTokens) then
  begin
    FLastWasToken := true;
    inc(FPos);
    goto a1;
  end;
  FPos := i;
  result := true;
end;  { NextToken }

function TElStringTokenizer.CountTokens : Integer;  { public }
var FSP : integer;
    Tc  : integer;
begin
  FSP := FPos;
  Tc := 0;
  while IntHasMoreTokens do inc(tc);
  result := Tc;
  FPos := FSP;
end;  { CountTokens }

function TElStringTokenizer.NextTokenDelim(Delims : string) : String;  { public }
begin
  FDelimiters := Delims;
  result := NextToken;
end;  { NextTokenDelim }

procedure TElStringTokenizer.FindAll(AStrings : TStrings);
var S : string;
begin
  AStrings.Clear;
  while IntNextToken(S) do
    AStrings.Add(S);
end;

constructor TElStringTokenizer.Create;
begin
  CreateStrDelimEx('', '', false);
end;

constructor TElStringTokenizer.CreateStr(str : String);
begin
  CreateStrDelimEx(str, '', false);
end;

constructor TElStringTokenizer.CreateStrDelim(str : String; Delim : string);
begin
  CreateStrDelimEx(str, Delim, false);
end;

constructor TElStringTokenizer.CreateStrDelimEx(str : String; Delim : string;
    ReturnDelims : boolean);
begin
 inherited;

  FSourceString := str;
  FDelimiters := Delim;
  FReturnDelims := ReturnDelims;
  FLastWasToken := true;
  FPos := 1;
end;

end.
