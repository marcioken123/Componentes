Unit LMDREFINEParser;
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

LMDREFINEParser unit (DD)
------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDYParser, SysUtils, LMDBaseRefine, LMDSearchConsts;

const _AND = 257;
const _OR = 258;
const _NOT = 259;
const _NEAR = 260;
const IDENTIFIER = 261;
const CHARACTER_STRING = 262;
const ILLEGAL = 263;

// ** CLR **
// DONE: ShortString not allowed in variant record
type
  (*$HPPEMIT '#pragma pack(push,4)' *)
  (*$HPPEMIT 'struct YYSType{' *)
  (*$HPPEMIT '#pragma pack(push,1)' *)
  (*$HPPEMIT 'union{' *)
  (*$HPPEMIT 'struct{ Lmdyparser::TSegment* yyTSegment; };' *)
  (*$HPPEMIT 'struct { char yyShortString[255]; };' *)
  (*$HPPEMIT '};' *)
  (*$HPPEMIT '#pragma pack(pop)' *)
  (*$HPPEMIT '};' *)
  (*$HPPEMIT '#pragma pack(pop)' *)

  {$EXTERNALSYM YYSTYPE}
  YYSType = record case Integer of
              1 : ( yyShortString:ShortString);
              2 : ( yyTSegment : TSegment );
            end(*YYSType*);

  PYYSType  = ^YYSType;

  TLMDREFINEParser = class(TYLMDREFINEBaseParser)
  public
      yystate, yysp, yyn : Integer;
      yys : array [1..yymaxdepth] of Integer;
      yyv : array [1..yymaxdepth] of YYSType;
      yyval : YYSType;

      function  yyparse : Integer;override;
      procedure yyaction ( yyruleno : Integer );
      function  yyact(state, sym : Integer; var act : Integer) : Boolean;
      function  yygoto(state, sym : Integer; var nstate : Integer) : Boolean;
      function  Getyylval : YYSType;
      property  yylval : YYSType read Getyylval;
  end;

implementation

function  TLMDREFINEParser.Getyylval : YYSType;
begin
  if FYLex <> nil then
    Result := PYYSType(FYLex.GetYYlvalPonter)^;
end;

procedure TLMDREFINEParser.yyaction ( yyruleno : Integer );

begin
  { actions }
  case yyruleno of
   1 : begin
       end;
   2 : begin

         FCode.AddSegment(yyv[yysp-0].yyTSegment);
         yyv[yysp-0].yyTSegment.Free;

       end;
   3 : begin
         yyval.yyTSegment := TSegment.Create; yyval.yyTSegment.AddSegment(yyv[yysp-2].yyTSegment); yyval.yyTSegment.AddSegment(yyv[yysp-0].yyTSegment);yyval.yyTSegment.AddCodes([C_AND]);yyv[yysp-2].yyTSegment.Free;yyv[yysp-0].yyTSegment.Free;
       end;
   4 : begin
         yyval.yyTSegment := TSegment.Create; yyval.yyTSegment.AddSegment(yyv[yysp-2].yyTSegment); yyval.yyTSegment.AddSegment(yyv[yysp-0].yyTSegment);yyval.yyTSegment.AddCodes([C_AND]);yyv[yysp-2].yyTSegment.Free;yyv[yysp-0].yyTSegment.Free;
       end;
   5 : begin
         yyval.yyTSegment := TSegment.Create; yyval.yyTSegment.AddSegment(yyv[yysp-2].yyTSegment); yyval.yyTSegment.AddSegment(yyv[yysp-0].yyTSegment);yyval.yyTSegment.AddCodes([C_OR]);yyv[yysp-2].yyTSegment.Free;yyv[yysp-0].yyTSegment.Free;
       end;
   6 : begin
         yyval.yyTSegment := TSegment.Create; yyval.yyTSegment.AddSegment(yyv[yysp-2].yyTSegment); yyval.yyTSegment.AddSegment(yyv[yysp-0].yyTSegment);yyval.yyTSegment.AddCodes([C_OR]);yyv[yysp-2].yyTSegment.Free;yyv[yysp-0].yyTSegment.Free;
       end;
   7 : begin
         yyval.yyTSegment := TSegment.Create; yyval.yyTSegment.AddSegment(yyv[yysp-2].yyTSegment); yyval.yyTSegment.AddSegment(yyv[yysp-0].yyTSegment);yyval.yyTSegment.AddCodes([C_NEAR]);yyv[yysp-2].yyTSegment.Free;yyv[yysp-0].yyTSegment.Free;
       end;
   8 : begin
         yyval.yyTSegment := TSegment.Create; yyval.yyTSegment.AddSegment(yyv[yysp-0].yyTSegment);yyval.yyTSegment.AddCodes([C_NOT]);yyv[yysp-0].yyTSegment.Free;
       end;
   9 : begin
         yyval.yyTSegment := TSegment.Create; yyval.yyTSegment.AddSegment(yyv[yysp-2].yyTSegment);yyval.yyTSegment.AddSegment(yyv[yysp-0].yyTSegment);yyval.yyTSegment.AddCodes([C_NOT,C_AND]);yyv[yysp-2].yyTSegment.Free;yyv[yysp-0].yyTSegment.Free;
       end;
  10 : begin
         yyval.yyTSegment := yyv[yysp-1].yyTSegment;
       end;
  11 : begin
         yyval.yyTSegment := yyv[yysp-0].yyTSegment;
       end;
  12 : begin
         yyval.yyTSegment := TSegment.Create; yyval.yyTSegment.AddCodes([C_CONST, yyv[yysp-0].yyShortString]);
       end;
  13 : begin
         yyval.yyTSegment := TSegment.Create; yyval.yyTSegment.AddCodes([C_CONST, yyv[yysp-0].yyShortString]);
         end;
  end;
end  {yyaction};

{ parse table }

type YYARec = record
                sym, act : Integer;
              end;
     YYRRec = record
                len, sym : Integer;
              end;

const

yynacts   = 98;
yyngotos  = 18;
yynstates = 23;
yynrules  = 13;

yya : array [1..yynacts] of YYARec = (
{ 0: }
  ( sym: 40; act: 4 ),
  ( sym: 259; act: 5 ),
  ( sym: 261; act: 6 ),
  ( sym: 262; act: 7 ),
  ( sym: 0; act: -1 ),
{ 1: }
  ( sym: 0; act: 0 ),
{ 2: }
  ( sym: 260; act: 8 ),
  ( sym: 0; act: -11 ),
  ( sym: 41; act: -11 ),
  ( sym: 43; act: -11 ),
  ( sym: 45; act: -11 ),
  ( sym: 124; act: -11 ),
  ( sym: 257; act: -11 ),
  ( sym: 258; act: -11 ),
{ 3: }
  ( sym: 43; act: 9 ),
  ( sym: 45; act: 10 ),
  ( sym: 124; act: 11 ),
  ( sym: 257; act: 12 ),
  ( sym: 258; act: 13 ),
  ( sym: 0; act: -2 ),
{ 4: }
  ( sym: 40; act: 4 ),
  ( sym: 259; act: 5 ),
  ( sym: 261; act: 6 ),
  ( sym: 262; act: 7 ),
{ 5: }
  ( sym: 40; act: 4 ),
  ( sym: 259; act: 5 ),
  ( sym: 261; act: 6 ),
  ( sym: 262; act: 7 ),
{ 6: }
{ 7: }
{ 8: }
  ( sym: 261; act: 6 ),
  ( sym: 262; act: 7 ),
{ 9: }
  ( sym: 40; act: 4 ),
  ( sym: 259; act: 5 ),
  ( sym: 261; act: 6 ),
  ( sym: 262; act: 7 ),
{ 10: }
  ( sym: 40; act: 4 ),
  ( sym: 259; act: 5 ),
  ( sym: 261; act: 6 ),
  ( sym: 262; act: 7 ),
{ 11: }
  ( sym: 40; act: 4 ),
  ( sym: 259; act: 5 ),
  ( sym: 261; act: 6 ),
  ( sym: 262; act: 7 ),
{ 12: }
  ( sym: 40; act: 4 ),
  ( sym: 259; act: 5 ),
  ( sym: 261; act: 6 ),
  ( sym: 262; act: 7 ),
{ 13: }
  ( sym: 40; act: 4 ),
  ( sym: 259; act: 5 ),
  ( sym: 261; act: 6 ),
  ( sym: 262; act: 7 ),
{ 14: }
  ( sym: 41; act: 22 ),
  ( sym: 43; act: 9 ),
  ( sym: 45; act: 10 ),
  ( sym: 124; act: 11 ),
  ( sym: 257; act: 12 ),
  ( sym: 258; act: 13 ),
{ 15: }
  ( sym: 43; act: 9 ),
  ( sym: 45; act: 10 ),
  ( sym: 124; act: 11 ),
  ( sym: 0; act: -8 ),
  ( sym: 41; act: -8 ),
  ( sym: 257; act: -8 ),
  ( sym: 258; act: -8 ),
{ 16: }
{ 17: }
  ( sym: 43; act: 9 ),
  ( sym: 45; act: 10 ),
  ( sym: 124; act: 11 ),
  ( sym: 257; act: 12 ),
  ( sym: 258; act: 13 ),
  ( sym: 0; act: -4 ),
  ( sym: 41; act: -4 ),
{ 18: }
  ( sym: 43; act: 9 ),
  ( sym: 45; act: 10 ),
  ( sym: 124; act: 11 ),
  ( sym: 257; act: 12 ),
  ( sym: 258; act: 13 ),
  ( sym: 0; act: -9 ),
  ( sym: 41; act: -9 ),
{ 19: }
  ( sym: 43; act: 9 ),
  ( sym: 45; act: 10 ),
  ( sym: 124; act: 11 ),
  ( sym: 257; act: 12 ),
  ( sym: 258; act: 13 ),
  ( sym: 0; act: -6 ),
  ( sym: 41; act: -6 ),
{ 20: }
  ( sym: 43; act: 9 ),
  ( sym: 45; act: 10 ),
  ( sym: 124; act: 11 ),
  ( sym: 0; act: -3 ),
  ( sym: 41; act: -3 ),
  ( sym: 257; act: -3 ),
  ( sym: 258; act: -3 ),
{ 21: }
  ( sym: 43; act: 9 ),
  ( sym: 45; act: 10 ),
  ( sym: 124; act: 11 ),
  ( sym: 257; act: 12 ),
  ( sym: 0; act: -5 ),
  ( sym: 41; act: -5 ),
  ( sym: 258; act: -5 )
{ 22: }
);

yyg : array [1..yyngotos] of YYARec = (
{ 0: }
  ( sym: -4; act: 1 ),
  ( sym: -3; act: 2 ),
  ( sym: -2; act: 3 ),
{ 1: }
{ 2: }
{ 3: }
{ 4: }
  ( sym: -3; act: 2 ),
  ( sym: -2; act: 14 ),
{ 5: }
  ( sym: -3; act: 2 ),
  ( sym: -2; act: 15 ),
{ 6: }
{ 7: }
{ 8: }
  ( sym: -3; act: 16 ),
{ 9: }
  ( sym: -3; act: 2 ),
  ( sym: -2; act: 17 ),
{ 10: }
  ( sym: -3; act: 2 ),
  ( sym: -2; act: 18 ),
{ 11: }
  ( sym: -3; act: 2 ),
  ( sym: -2; act: 19 ),
{ 12: }
  ( sym: -3; act: 2 ),
  ( sym: -2; act: 20 ),
{ 13: }
  ( sym: -3; act: 2 ),
  ( sym: -2; act: 21 )
{ 14: }
{ 15: }
{ 16: }
{ 17: }
{ 18: }
{ 19: }
{ 20: }
{ 21: }
{ 22: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 0,
{ 3: } 0,
{ 4: } 0,
{ 5: } 0,
{ 6: } -13,
{ 7: } -12,
{ 8: } 0,
{ 9: } 0,
{ 10: } 0,
{ 11: } 0,
{ 12: } 0,
{ 13: } 0,
{ 14: } 0,
{ 15: } 0,
{ 16: } -7,
{ 17: } 0,
{ 18: } 0,
{ 19: } 0,
{ 20: } 0,
{ 21: } 0,
{ 22: } -10
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 6,
{ 2: } 7,
{ 3: } 15,
{ 4: } 21,
{ 5: } 25,
{ 6: } 29,
{ 7: } 29,
{ 8: } 29,
{ 9: } 31,
{ 10: } 35,
{ 11: } 39,
{ 12: } 43,
{ 13: } 47,
{ 14: } 51,
{ 15: } 57,
{ 16: } 64,
{ 17: } 64,
{ 18: } 71,
{ 19: } 78,
{ 20: } 85,
{ 21: } 92,
{ 22: } 99
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 5,
{ 1: } 6,
{ 2: } 14,
{ 3: } 20,
{ 4: } 24,
{ 5: } 28,
{ 6: } 28,
{ 7: } 28,
{ 8: } 30,
{ 9: } 34,
{ 10: } 38,
{ 11: } 42,
{ 12: } 46,
{ 13: } 50,
{ 14: } 56,
{ 15: } 63,
{ 16: } 63,
{ 17: } 70,
{ 18: } 77,
{ 19: } 84,
{ 20: } 91,
{ 21: } 98,
{ 22: } 98
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 4,
{ 2: } 4,
{ 3: } 4,
{ 4: } 4,
{ 5: } 6,
{ 6: } 8,
{ 7: } 8,
{ 8: } 8,
{ 9: } 9,
{ 10: } 11,
{ 11: } 13,
{ 12: } 15,
{ 13: } 17,
{ 14: } 19,
{ 15: } 19,
{ 16: } 19,
{ 17: } 19,
{ 18: } 19,
{ 19: } 19,
{ 20: } 19,
{ 21: } 19,
{ 22: } 19
);

yygh : array [0..yynstates-1] of Integer = (
{ 0: } 3,
{ 1: } 3,
{ 2: } 3,
{ 3: } 3,
{ 4: } 5,
{ 5: } 7,
{ 6: } 7,
{ 7: } 7,
{ 8: } 8,
{ 9: } 10,
{ 10: } 12,
{ 11: } 14,
{ 12: } 16,
{ 13: } 18,
{ 14: } 18,
{ 15: } 18,
{ 16: } 18,
{ 17: } 18,
{ 18: } 18,
{ 19: } 18,
{ 20: } 18,
{ 21: } 18,
{ 22: } 18
);

yyr : array [1..yynrules] of YYRRec = (
{ 1: } ( len: 0; sym: -4 ),
{ 2: } ( len: 1; sym: -4 ),
{ 3: } ( len: 3; sym: -2 ),
{ 4: } ( len: 3; sym: -2 ),
{ 5: } ( len: 3; sym: -2 ),
{ 6: } ( len: 3; sym: -2 ),
{ 7: } ( len: 3; sym: -2 ),
{ 8: } ( len: 2; sym: -2 ),
{ 9: } ( len: 3; sym: -2 ),
{ 10: } ( len: 3; sym: -2 ),
{ 11: } ( len: 1; sym: -2 ),
{ 12: } ( len: 1; sym: -3 ),
{ 13: } ( len: 1; sym: -3 )
);

const _error = 256; (* error token *)

function TLMDREFINEParser.yyact(state, sym : Integer; var act : Integer) : Boolean;
  (* search action table *)
  var k : Integer;
  begin
    k := yyal[state];
    while (k<=yyah[state]) and (yya[k].sym<>sym) do inc(k);
    if k>yyah[state] then
      yyact := false
    else
      begin
        act := yya[k].act;
        yyact := true;
      end;
  end(*yyact*);

function TLMDREFINEParser.yygoto(state, sym : Integer; var nstate : Integer) : Boolean;
  (* search goto table *)
  var k : Integer;
  begin
    k := yygl[state];
    while (k<=yygh[state]) and (yyg[k].sym<>sym) do inc(k);
    if k>yygh[state] then
      yygoto := false
    else
      begin
        nstate := yyg[k].act;
        yygoto := true;
      end;
  end(*yygoto*);

function TLMDREFINEParser.yyparse : Integer;
label parse, next, error, errlab, shift, reduce, accept, abort;
begin(*yyparse*)

  (* initialize: *)

  yystate := 0; yychar := -1; yynerrs := 0; yyerrflag := 0; yysp := 0;

{$ifdef yydebug}
  yydebug := true;
{$else}
  yydebug := false;
{$endif}

parse:

  (* push state and value: *)

  inc(yysp);
  if yysp>yymaxdepth then
    begin
      yyerror(YyparseStackOverflow);
      goto abort;
    end;
  yys[yysp] := yystate; yyv[yysp] := yyval;

next:

  if (yyd[yystate]=0) and (yychar=-1) then
    (* get next symbol *)
    begin
      yychar := yylex; if yychar<0 then yychar := 0;
    end;

  if yydebug then writeln(StateMsg + ' ', yystate, ', ' + CharMsg + ' ', yychar);

  (* determine parse action: *)

  yyn := yyd[yystate];
  if yyn<>0 then goto reduce; (* simple state *)

  (* no default action; search parse table *)

  if not yyact(yystate, yychar, yyn) then goto error
  else if yyn>0 then                      goto shift
  else if yyn<0 then                      goto reduce
  else                                    goto accept;

error:

  (* error; start error recovery: *)

  if yyerrflag=0 then yyerror(SyntaxError);

errlab:

  if yyerrflag=0 then inc(yynerrs);     (* new error *)

  if yyerrflag<=2 then                  (* incomplete recovery; try again *)
    begin
      yyerrflag := 3;
      (* uncover a state with shift action on error token *)
      while (yysp>0) and not ( yyact(yys[yysp], _error, yyn) and
                               (yyn>0) ) do
        begin
          if yydebug then
            if yysp>1 then
              writeln(ErrorRecoveryPopsState + ' ', yys[yysp], ', ' + uncovers + ' ',
                      yys[yysp-1])
            else
              writeln(ErrorRecoveryFailsAbort);
          dec(yysp);
        end;
      if yysp=0 then goto abort; (* parser has fallen from stack; abort *)
      yystate := yyn;            (* simulate shift on error *)
      goto parse;
    end
  else                                  (* no shift yet; discard symbol *)
    begin
      if yydebug then writeln(ErrorRecoveryDiscardsChar + ' ', yychar);
      if yychar=0 then goto abort; (* end of input; abort *)
      yychar := -1; goto next;     (* clear lookahead char and try again *)
    end;

shift:

  (* go to new state, clear lookahead character: *)

  yystate := yyn; yychar := -1; yyval := yylval;
  if yyerrflag>0 then dec(yyerrflag);

  goto parse;

reduce:

  (* execute action, pop rule from stack, and go to next state: *)

  if yydebug then writeln(ReduceMsg + ' ', -yyn);

  yyflag := yyfnone; yyaction(-yyn);
  dec(yysp, yyr[-yyn].len);
  if yygoto(yys[yysp], yyr[-yyn].sym, yyn) then yystate := yyn;

  (* handle action calls to yyaccept, yyabort and yyerror: *)

  case yyflag of
    yyfaccept : goto accept;
    yyfabort  : goto abort;
    yyferror  : goto errlab;
  end;

  goto parse;

accept:

  yyparse := 0; exit;

abort:

  yyparse := 1; exit;

end(*yyparse*);

end.
