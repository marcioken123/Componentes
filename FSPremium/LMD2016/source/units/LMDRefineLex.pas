Unit LMDREFINELEX;
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

LMDREFINELEX unit (DD)
----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDYParser, LMDRefineParser, SysUtils, LMDSearchConsts;

type

  TLMDREFINELEXLex = class(TYLex)
  public
    yylval : YYSType;
    function yylex : Integer;override;
    function  GetYYlvalPonter: TObject; override;
    procedure yyaction ( yyruleno : Integer );
  end;

implementation

function  TLMDREFINELEXLex.GetYYlvalPonter: TObject;

begin
  Result := @yylval;
  end;

procedure TLMDREFINELEXLex.yyaction(yyruleno : Integer);

function upper(str : String) : String;
  (* converts str to uppercase *)
  var i : integer;
  begin
    for i := 1 to length(str) do
      str[i] := upCase(str[i]);
    upper := str
  end(*upper*);

function is_keyword(id : string; var token : integer) : boolean;
  (* checks whether id is Pascal keyword; if so, returns corresponding
     token number in token *)
  const
    id_len = 20;
  type
    Ident = string[id_len];
  const
    no_of_keywords = 4;
    keyword : array [1..no_of_keywords] of Ident = (
      'AND', 'NEAR','NOT','OR'
      );
    keyword_token : array [1..no_of_keywords] of integer = (
      _AND, _NEAR, _NOT, _OR
      );
  var m, n, k : integer;
  begin
    id := upper(id);
    (* binary search: *)
    m := 1; n := no_of_keywords;
    while m<=n do
      begin
        k := m+(n-m) div 2;
        if id=String(keyword[k]) then
          begin
            is_keyword := true;
            token := keyword_token[k];
            exit
          end
        else if id>String(keyword[k]) then
          m := k+1
        else
          n := k-1
      end;
    is_keyword := false
  end(*is_keyword*);

var
  kw: integer;

begin
  case yyruleno of
  1:
    if is_keyword(yytext, kw) then
      returnn(kw)
    else
    begin
      yylval.yyShortString := AnsiString(yytext);
      returnn(IDENTIFIER);
    end;
  2, 3:
  begin
     yylval.yyShortString := AnsiString(Copy(yytext, 2, Length(yytext)-2));
     returnn(CHARACTER_STRING);
  end;
  4:  ;
  5:  ;
  6: returnc(yytext[1]);
  end;
end(*yyaction*);

(* DFA table: *)

type YYTRec = record
                cc : set of AnsiChar;
                s  : Integer;
              end;

const

yynmarks   = 16;
yynmatches = 16;
yyntrans   = 26;
yynstates  = 14;

yyk : array [1..yynmarks] of Integer = (
  { 0: }
  1,
  { 1: }
  1,
  { 2: }
  1,
  6,
  { 3: }
  6,
  { 4: }
  6,
  { 5: }
  4,
  5,
  6,
  { 6: }
  5,
  { 7: }
  5,
  6,
  { 8: }
  6,
  { 9: }
  1,
  { 10: }
  { 11: }
  2,
  { 12: }
  { 13: }
  3
);

yym : array [1..yynmatches] of Integer = (
{ 0: }
  1,
{ 1: }
  1,
{ 2: }
  1,
  6,
{ 3: }
  6,
{ 4: }
  6,
{ 5: }
  4,
  5,
  6,
{ 6: }
  5,
{ 7: }
  5,
  6,
{ 8: }
  6,
{ 9: }
  1,
{ 10: }
{ 11: }
  2,
{ 12: }
{ 13: }
  3
);

yyt : array [1..yyntrans] of YYTrec = (
{ 0: }
  ( cc: [ #1..#8,#11,#14..#31,'!','#'..'&','(',')',
            '+'..'-','/',':'..'>','@','['..'^','`','{'..#191 ]; s: 8),
  ( cc: [ #9,#12,#13 ]; s: 7),
  ( cc: [ #10 ]; s: 6),
  ( cc: [ ' ' ]; s: 5),
  ( cc: [ '"' ]; s: 3),
  ( cc: [ '''' ]; s: 4),
  ( cc: [ '*','.','0'..'9','?','A'..'Z','_','a'..'z',
            #192..#255 ]; s: 2),
{ 1: }
  ( cc: [ #1..#8,#11,#14..#31,'!','#'..'&','(',')',
            '+'..'-','/',':'..'>','@','['..'^','`','{'..#191 ]; s: 8),
  ( cc: [ #9,#12,#13 ]; s: 7),
  ( cc: [ #10 ]; s: 6),
  ( cc: [ ' ' ]; s: 5),
  ( cc: [ '"' ]; s: 3),
  ( cc: [ '''' ]; s: 4),
  ( cc: [ '*','.','0'..'9','?','A'..'Z','_','a'..'z',
            #192..#255 ]; s: 2),
{ 2: }
  ( cc: [ '*','.','0'..'9','?','A'..'Z','_','a'..'z',
            #192..#255 ]; s: 9),
{ 3: }
  ( cc: [ #1..'!','#'..'&','('..#255 ]; s: 10),
  ( cc: [ '"' ]; s: 11),
{ 4: }
  ( cc: [ #1..'&','('..#255 ]; s: 12),
  ( cc: [ '''' ]; s: 13),
{ 5: }
{ 6: }
{ 7: }
{ 8: }
{ 9: }
  ( cc: [ '*','.','0'..'9','?','A'..'Z','_','a'..'z',
            #192..#255 ]; s: 9),
{ 10: }
  ( cc: [ #1..'!','#'..'&','('..#255 ]; s: 10),
  ( cc: [ '"' ]; s: 11),
{ 11: }
  ( cc: [ #1..'!','#'..'&','('..#255 ]; s: 10),
  ( cc: [ '"' ]; s: 11),
{ 12: }
  ( cc: [ #1..'&','('..#255 ]; s: 12),
  ( cc: [ '''' ]; s: 13)
{ 13: }
);

yykl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 5,
{ 4: } 6,
{ 5: } 7,
{ 6: } 10,
{ 7: } 11,
{ 8: } 13,
{ 9: } 14,
{ 10: } 15,
{ 11: } 15,
{ 12: } 16,
{ 13: } 16
);

yykh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 4,
{ 3: } 5,
{ 4: } 6,
{ 5: } 9,
{ 6: } 10,
{ 7: } 12,
{ 8: } 13,
{ 9: } 14,
{ 10: } 14,
{ 11: } 15,
{ 12: } 15,
{ 13: } 16
);

yyml : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 3,
{ 3: } 5,
{ 4: } 6,
{ 5: } 7,
{ 6: } 10,
{ 7: } 11,
{ 8: } 13,
{ 9: } 14,
{ 10: } 15,
{ 11: } 15,
{ 12: } 16,
{ 13: } 16
);

yymh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2,
{ 2: } 4,
{ 3: } 5,
{ 4: } 6,
{ 5: } 9,
{ 6: } 10,
{ 7: } 12,
{ 8: } 13,
{ 9: } 14,
{ 10: } 14,
{ 11: } 15,
{ 12: } 15,
{ 13: } 16
);

yytl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 8,
{ 2: } 15,
{ 3: } 16,
{ 4: } 18,
{ 5: } 20,
{ 6: } 20,
{ 7: } 20,
{ 8: } 20,
{ 9: } 20,
{ 10: } 21,
{ 11: } 23,
{ 12: } 25,
{ 13: } 27
);

yyth : array [0..yynstates-1] of Integer = (
{ 0: } 7,
{ 1: } 14,
{ 2: } 15,
{ 3: } 17,
{ 4: } 19,
{ 5: } 19,
{ 6: } 19,
{ 7: } 19,
{ 8: } 19,
{ 9: } 20,
{ 10: } 22,
{ 11: } 24,
{ 12: } 26,
{ 13: } 26
);

function TLMDREFINELEXLex.yylex : Integer;
label start, scan, action;
var
  yyn : Integer;
begin

start:

  (* initialize: *)

  yynew;

scan:

  (* mark positions and matches: *)

  for yyn := yykl[yystate] to     yykh[yystate] do yymark(yyk[yyn]);
  for yyn := yymh[yystate] downto yyml[yystate] do yymatch(yym[yyn]);

  if yytl[yystate]>yyth[yystate] then goto action; (* dead state *)

  (* get next character: *)

  yyscan;

  (* determine action: *)

  yyn := yytl[yystate];
  while (yyn<=yyth[yystate]) and not (AnsiChar(yyactchar) in yyt[yyn].cc) do inc(yyn);
  if yyn>yyth[yystate] then goto action;
    (* no transition on yyactchar in this state *)

  (* switch to new state: *)

  yystate := yyt[yyn].s;

  goto scan;

action:

  (* execute action: *)

  if yyfind(yyrule) then
    begin
      yyaction(yyrule);
      if yyreject then goto action;
    end
  else if not yydefault and yywrap then
    begin
      yyclear;
      returnn(0);
    end;

  if not yydone then goto start;

  yylex := yyretval;

end(*yylex*);
end.
