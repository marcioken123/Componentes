{***********************************************************
                R&A Library
       Copyright (C) 1999 R&A

       component   : TRAHLEditor
       description : RAEditor with built-in highlighting
                     for pascal, cbuilder, sql, python, jscript, vbscript

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib.htm
************************************************************}

{$INCLUDE RA.INC}

{ history
 (R&A Library versions) :
  1.03:       
    - first release;
  1.11:
    - improvements in custom reserved words support;
    - comments works better in custom reserved words;
  1.17:
    - python highlighting by Rafal Smotrzyk - rsmotrzyk@mikroplan.com.pl;
  1.172:
    - jscript, vbscript highlighting by Rafal Smotrzyk - rsmotrzyk@mikroplan.com.pl;
  1.176:
    - html highlighting;
  1.122:
    - fixed bug with pressing End-key if CursorBeoyondEOF enabled
      (greetings to Andre N Belokon)
  1.23:
    - fixed another bug in comment checking (range check error)
    (greetings to Willo vd Merwe)
  1.231:
    - first version of perl highlighter;
  1.41:
    - fixed another bug in comment checking;
}

unit RAHLEditor;

interface

uses SysUtils, Classes, Graphics, RAEditor, IParser;

const

  { Max_Line - maximum line numbers, what editor scan for comments }
  Max_Line = 20000;

type

  THighLighter = (hlNone, hlPascal, hlCBuilder, hlSql, hlPython, hlJava, hlVB,
    hlHtml, hlPerl);

  TSymbolColor = class(TPersistent)
  private
    FStyle: TFontStyles;
    FForeColor: TColor;
    FBackColor: TColor;
  public
    procedure SetColor(const ForeColor, BackColor: TColor; const Style:
      TFontStyles);
    procedure Assign(Source: TPersistent); override;
  published
    property Style: TFontStyles read FStyle write FStyle;
    property ForeColor: TColor read FForeColor write FForeColor;
    property BackColor: TColor read FBackColor write FBackColor;
  end;

  TColors = class(TPersistent)
  private
    FComment: TSymbolColor;
    FNumber: TSymbolColor;
    FString: TSymbolColor;
    FSymbol: TSymbolColor;
    FReserved: TSymbolColor;
    FIdentifer: TSymbolColor;
    FPreproc: TSymbolColor;
    FFunctionCall: TSymbolColor;
    FDeclaration: TSymbolColor;
    FStatement: TSymbolColor;
    FPlainText: TSymbolColor;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Comment: TSymbolColor read FComment write FComment;
    property Number: TSymbolColor read FNumber write FNumber;
    property Strings: TSymbolColor read FString write FString;
    property Symbol: TSymbolColor read FSymbol write FSymbol;
    property Reserved: TSymbolColor read FReserved write FReserved;
    property Identifer: TSymbolColor read FIdentifer write FIdentifer;
    property Preproc: TSymbolColor read FPreproc write FPreproc;
    property FunctionCall: TSymbolColor read FFunctionCall write FFunctionCall;
    property Declaration: TSymbolColor read FDeclaration write FDeclaration;
    property Statement: TSymbolColor read FStatement write FStatement;
    property PlainText: TSymbolColor read FPlainText write FPlainText;
  end;

  TOnReservedWord = procedure(Sender: TObject; Token: string;
    var Reserved: Boolean) of object;

  TRAHLEditor = class(TRAEditor)
  private
    Parser: TIParser;
    FHighLighter: THighLighter;
    FColors: TColors;
    FLine: string;
    FLineNum: Integer;
    FLong: byte;
    FLongTokens: Boolean;
    FLongDesc: array[0..Max_Line] of byte;
    FOnReservedWord: TOnReservedWord;
    procedure RescanLong;
    procedure CheckInLong;
    function FindLongEnd: integer;
    procedure SetHighLighter(Value: THighLighter);
  protected
    procedure Loaded; override;
    procedure GetAttr(Line, ColBeg, ColEnd: integer); override;
    procedure TextModified(Pos: integer; Action: TModifiedAction; Text: string);
      override;
    function GetReservedWord(const Token: string; var Reserved: Boolean):
      Boolean; virtual;
    function UserReservedWords: boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property HighLighter: THighLighter read FHighLighter write SetHighLighter
      default hlPascal;
    property Colors: TColors read FColors write FColors;
    property LongTokens: Boolean read FLongTokens write FLongTokens default
      True;
    property OnReservedWord: TOnReservedWord read FOnReservedWord write
      FOnReservedWord;
  end;

implementation

uses RAUtils, RAConst;


procedure TSymbolColor.SetColor(const ForeColor, BackColor: TColor; const Style:
  TFontStyles);
begin
  FForeColor := ForeColor;
  FBackColor := BackColor;
  FStyle := Style;
end;

procedure TSymbolColor.Assign(Source: TPersistent);
begin
  if Source is TSymbolColor then
  begin
    FForeColor := TSymbolColor(Source).FForeColor;
    FBackColor := TSymbolColor(Source).FBackColor;
    FStyle := TSymbolColor(Source).FStyle;
  end
  else
    inherited Assign(Source);
end;

constructor TColors.Create;
begin
  FComment := TSymbolColor.Create;
  FNumber := TSymbolColor.Create;
  FString := TSymbolColor.Create;
  FSymbol := TSymbolColor.Create;
  FReserved := TSymbolColor.Create;
  FStatement := TSymbolColor.Create;
  FIdentifer := TSymbolColor.Create;
  FPreproc := TSymbolColor.Create;
  FFunctionCall := TSymbolColor.Create;
  FDeclaration := TSymbolColor.Create;
  FPlainText := TSymbolColor.Create;
  FComment.SetColor(clOlive, clWindow, [fsItalic]);
  FNumber.SetColor(clNavy, clWindow, []);
  FString.SetColor(clPurple, clWindow, []);
  FSymbol.SetColor(clBlue, clWindow, []);
  FReserved.SetColor(clWindowText, clWindow, [fsBold]);
  FStatement.SetColor(clWindowText, clWindow, [fsBold]);
  FIdentifer.SetColor(clWindowText, clWindow, []);
  FPreproc.SetColor(clGreen, clWindow, []);
  FFunctionCall.SetColor(clWindowText, clWindow, []);
  FDeclaration.SetColor(clWindowText, clWindow, []);
  FPlainText.SetColor(clWindowText, clWindow, []);
end;

destructor TColors.Destroy;
begin
  FComment.Free;
  FNumber.Free;
  FString.Free;
  FSymbol.Free;
  FReserved.Free;
  FStatement.Free;
  FIdentifer.Free;
  FPreproc.Free;
  FFunctionCall.Free;
  FDeclaration.Free;
  FPlainText.Free;
  inherited Destroy;
end; { Destroy }

procedure TColors.Assign(Source: TPersistent);
begin
  if Source is TColors then
  begin
    FComment     .Assign(TColors(Source).FComment     );
    FNumber      .Assign(TColors(Source).FNumber      );
    FString      .Assign(TColors(Source).FString      );
    FSymbol      .Assign(TColors(Source).FSymbol      );
    FReserved    .Assign(TColors(Source).FReserved    );
    FStatement   .Assign(TColors(Source).FStatement   );
    FIdentifer   .Assign(TColors(Source).FIdentifer   );
    FPreproc     .Assign(TColors(Source).FPreproc     );
    FFunctionCall.Assign(TColors(Source).FFunctionCall);
    FDeclaration .Assign(TColors(Source).FDeclaration );
    FPlainText   .Assign(TColors(Source).FPlainText   );
  end
  else
    inherited Assign(Source);
end;


{ TRAHLEditor }
constructor TRAHLEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parser := TIParser.Create;
  Parser.ReturnComments := True;
  FHighLighter := hlPascal;
  FColors := TColors.Create;
  FLongTokens := True;
end; { Create }

destructor TRAHLEditor.Destroy;
begin
  Parser.Free;
  FColors.Free;
  inherited Destroy;
end; { Destroy }

procedure TRAHLEditor.Loaded;
begin
  inherited Loaded;
  RescanLong;
end;

procedure TRAHLEditor.SetHighLighter(Value: THighLighter);
begin
  if FHighLighter <> Value then
  begin
    FHighLighter := Value;
    case FHighLighter of
      hlPascal:
        Parser.Style := psPascal;
      hlCBuilder, hlSql, hlJava:
        Parser.Style := psCpp;
      hlPython:
        Parser.Style := psPython;
      hlVB:
        Parser.Style := psVB;
      hlHtml:
        Parser.Style := psHtml;
      hlPerl:
        Parser.Style := psPerl;
    end;
    RescanLong;
    Invalidate;
  end;
end;

procedure TRAHLEditor.GetAttr(Line, ColBeg, ColEnd: integer);
var
  Token: string;
  i: integer;
const
  Symbols = [',', ':', ';', '.', '[', ']', '(', ')', '=', '+',
    '-', '/', '<', '>', '%', '*', '~', '''', '\', '^', '@', '{', '}',
    '#'];
const
  DelphiKeyWords: string =
    '  constructor  destructor  record  procedure  with  of  ' +
    'repeat  until  try  finally  except  for  to  downto  case  ' +
    'type  interface  implementation  initialization  finalization  ' +
    'default  private  public  protected  published   automated  property  ' +
    'program  read  write  override  object  nil  raise  ' +
    'on  set  xor  shr  shl  begin  end  args  if  then  else  ' +
    'endif  goto  while  do  var  true  false  or  and  not  mod  unit  ' +
    'function  uses  external  const  class  inherited  '
    ;

  BuilderKeyWords: string =
    ' __asm  _asm  asm  auto  __automated  break  bool  case  catch  __cdecl  ' +
    '_cdecl  cdecl  char  class  __classid  __closure  const  const_cast  ' +
    'continue  __declspec  default  delete  __dispid  do  double  dynamic_cast  ' +
    'else  enum  __except  explicit  _export  __export  extern  false  __fastcall  ' +
    '_fastcall  __finally  float  for  friend  goto  if  __import  _import  inline  ' +
    'int  __int8  __int16  __int32  __int64  long  mutable  namespace  new  operator  ' +
    '__pascal  _pascal  pascal  private  protected  __property  public  __published  ' +
    'register  reinterpret_cast  return  __rtti  short  signed  sizeof  static  static_cast  ' +
    '__stdcall  _stdcall  struct  switch  template  this  __thread  throw  true  __try  ' +
    'try  typedef  typename  typeid  union  using  unsigned  virtual  void  volatile  ' +
    'wchar_t  while  '
    ;

  SQLKeyWords: string =
    '  active  as  add  asc  after  ascending  all  at  alter  auto  ' +
    'and  autoddl  any  avg  based  between  basename  blob  ' +
    'base_name  blobedit  before  buffer  begin  by  cache   compiletime  ' +
    'cast   computed  char   close  character   conditional  character_length   connect  ' +
    'char_length   constraint  check   containing  check_point_len   continue  check_point_length   count  ' +
    'collate   create  collation   cstring  column   current  commit   cursor  ' +
    'committed  database   descending  date   describe  db_key   descriptor  debug   disconnect  ' +
    'dec   display  decimal  distinct  declare  do  default   domain  ' +
    'delete   double  desc  drop  echo  exception  edit  execute  ' +
    'else   exists  end   exit  entry_point   extern  escape   external  ' +
    'event   extract  fetch  foreign  file   found  filter   from  ' +
    'float   full  for   function  gdscode  grant  generator  group  ' +
    'gen_id  commit_group_wait  global  group_commit_wait_time  goto  ' +
    'having  help  if   input_type  immediate   insert  in  int  ' +
    'inactive   integer  index  into  indicator   is  init   isolation  ' +
    'inner  isql  input  join  key  ' +
    'lc_messages   like  lc_type   logfile  left  log_buffer_size  length  log_buf_size  ' +
    'lev   long  level  manual   merge  max   message  ' +
    'maximum   min  maximum_segment  minimum  max_segment   module_name  names  not  ' +
    'national   null  natural   numeric  nchar  num_log_bufs  no  num_log_buffers  ' +
    'noauto  octet_length  or  of   order  on   outer  only  output  ' +
    'open  output_type  option  overflow  page  post_event  pagelength   precision  ' +
    'pages   prepare  page_size  procedure  parameter   protected  password   primary  ' +
    'plan   privileges  position   public  quit  ' +
    'raw_partitions   retain  rdb  db_key   return  read   returning_values  real   returns  ' +
    'record_version  revoke  references   right  release   rollback  reserv  runtime  ' +
    'reserving  schema   sql  segment   sqlcode  select   sqlerror  set   sqlwarning  ' +
    'shadow   stability  shared   starting  shell   starts  show   statement  ' +
    'singular   static  size   statistics  smallint   sub_type  snapshot   sum  ' +
    'some  suspend  sort  table   translate  terminator   translation  then   trigger  to   trim  ' +
    'transaction  uncommitted  upper  union   user  unique  using  update  ' +
    'value  varying  values  version  varchar  view  variable  ' +
    'wait  while  when  with  whenever  work  where  write  ' +
    'term  new  old '
    ;

  PythonKeyWords: string =
    ' and  del  for  is  raise  ' +
    'assert  elif  from  lambda  return  ' +
    'break  else  global  not  try  ' +
    'class  except  if  or  while  ' +
    'continue  exec  import  pass  ' +
    'def  finally  in  print '
    ;

  JavaKeyWords: string =
    ' abstract delegate if boolean do implements break double import' +
    ' byte else instanceof case extends int catch false interface' +
    ' char final long class finally multicast continue float' +
    ' default for native short transient new static true' +
    ' null super try package switch void private synchronized volatile' +
    ' protected this while public throw return throws '
    ;

  VBKeyWords: string =
    ' as and base binary byref byval call case class compare const date debug declare deftype dim do each else elseif ' +
    ' empty end endif enum eqv erase error event execute exit explicit false for friend function get' +
    ' global gosub goto if imp implements input is kill len let line load lock loop lset me mid mod name new next not nothing null on open option optional' +
    ' or paramarray preserve print private property public raiseevent randomize redim rem' +
    ' resume return seek select set static step' +
    ' string sub then time to true unlock until wend while with withevents xor '
    ;
  VBStatements: string =
    ' access alias any beep ccur cdbl chdir chdrive choose' +
    ' chr cint clear clng clone close cls command compare' +
    ' cos csng cstr curdir currency cvar cvdate ' +
    ' defcur defdbl defint deflng defsng defstr deftype defvar delete deletesetting' +
    ' doevents double dynaset edit environ eof erl err exp fix format ' +
    ' hex int integer isdate isempty isnull isnumeric lbound lcase' +
    ' lib like loc local lof long mkdir oct output pset put' +
    ' random read refresh reset restore rmdir rnd rset savesetting ' +
    ' sendkeys shared single stop system text type typeof ubound unload ' +
    ' using variant vartype write'
    ;

  HTMLTags: string =
    ' doctype a address applet area b base basefont bgsound big blink ' +
    ' blockquote body br caption center cite code col colgroup comment ' +
    ' dfn dir li div dl dt dd em embed font form frame frameset h align ' +
    ' h1 h2 h3 h4 h5 h6 head hr html i iframe img input isindex kbd link ' +
    ' listing map marquee menu meta multicol nextid nobr noframes noscript ' +
    ' object ol option p plaintext pre s samp script select small sound ' +
    ' spacer span strike strong style sub sup table tbody td textarea tfoot' +
    ' th thead title tr tt u ul var wbr xmp '
    ;

  HtmlSpecChars: string =
    ' Aacute aacute acirc Acirc acute AElig aelig agrave Agrave alefsym ' +
    ' alpha Alpha AMP amp and ang Aring aring asymp atilde Atilde Auml ' +
    ' auml bdquo beta Beta brvbar bull cap Ccedil ccedil cedil cent chi ' +
    ' Chi circ clubs cong copy COPY crarr cup curren dagger Dagger dArr ' +
    ' darr deg Delta delta diams divide eacute Eacute ecirc Ecirc Egrave ' +
    ' egrave empty emsp ensp Epsilon epsilon equiv eta Eta ETH eth Euml ' +
    ' euml euro exist fnof forall frac12 frac14 frac34 frasl Gamma gamma ' +
    ' ge gt GT harr hArr hearts hellip iacute Iacute Icirc icirc iexcl Igrave ' +
    ' igrave image infin int Iota iota iquest isin Iuml iuml kappa Kappa Lambda ' +
    ' lambda lang laquo larr lArr lceil ldquo le lfloor lowast loz lrm lsaquo ' +
    ' lsquo lt LT macr mdash micro middot minus mu Mu nabla nbsp ndash ne ' +
    ' ni not notin nsub Ntilde ntilde Nu nu oacute Oacute ocirc Ocirc oelig ' +
    ' OElig ograve Ograve oline Omega omega omicron Omicron oplus or ordf ' +
    ' ordm Oslash oslash Otilde otilde otimes ouml Ouml para part permil ' +
    ' perp phi Phi Pi pi piv plusmn pound Prime prime prod prop psi Psi quot ' +
    ' QUOT radic rang raquo rArr rarr rceil rdquo real REG reg rfloor Rho ' +
    ' rho rlm rsaquo rsquo sbquo scaron Scaron sdot sect shy Sigma sigma ' +
    ' sigmaf sim spades sub sube sum sup sup1 sup2 sup3 supe szlig Tau ' +
    ' tau there4 Theta theta thetasym thinsp THORN thorn tilde times trade ' +
    ' Uacute uacute uArr uarr ucirc Ucirc ugrave Ugrave uml upsih upsilon ' +
    ' Upsilon uuml Uuml weierp xi Xi Yacute yacute yen yuml Yuml zeta Zeta ' +
    ' zwj zwnj '
  ;

  PerlKeyWords: string =
    ' sub if else unless foreach next local '+
    ' return defined until while do elsif eq '
  ;

  PerlStatements: string =
    ' stat die open print push close defined chdir last read chop ' +
    ' keys sort bind unlink select length '
  ;

  function IsDelphiKeyWord(St: string): boolean;
  begin
    Result := Pos(' ' + ANSILowerCase(St) + ' ', DelphiKeyWords) <> 0;
  end;

  function IsBuilderKeyWord(St: string): boolean;
  begin
    Result := Pos(' ' + St + ' ', BuilderKeyWords) <> 0;
  end;

  function IsJavaKeyWord(St: string): boolean;
  begin
    Result := Pos(' ' + St + ' ', JavaKeyWords) <> 0;
  end;

  function IsVBKeyWord(St: string): boolean;
  begin
    Result := Pos(' ' + LowerCase(St) + ' ', VBKeyWords) <> 0;
  end;

  function IsVBStatement(St: string): boolean;
  begin
    Result := Pos(' ' + LowerCase(St) + ' ', VBStatements) <> 0;
  end;

  function IsSQLKeyWord(St: string): boolean;
  begin
    Result := Pos(' ' + ANSILowerCase(St) + ' ', SQLKeyWords) <> 0;
  end;

  function IsPythonKeyWord(St: string): boolean;
  begin
    Result := Pos(' ' + St + ' ', PythonKeyWords) <> 0;
  end;

  function IsHtmlTag(St: string): boolean;
  begin
    Result := Pos(' ' + ANSILowerCase(St) + ' ', HtmlTags) <> 0;
  end;

  function IsHtmlSpecChar(St: string): boolean;
  begin
    Result := Pos(' ' + ANSILowerCase(St) + ' ', HtmlSpecChars) <> 0;
  end;

  function IsPerlKeyWord(St: string): boolean;
  begin
    Result := Pos(' ' + St + ' ', PerlKeyWords) <> 0;
  end;

  function IsPerlStatement(St: string): boolean;
  begin
    Result := Pos(' ' + St + ' ', PerlStatements) <> 0;
  end;

  function IsComment(St: string): boolean;
  var
    LS: integer;
  begin
    LS := Length(St);
    case HighLighter of
      hlPascal:
        Result := ((LS > 0) and (St[1] = '{')) or
          ((LS > 1) and (((St[1] = '(') and (St[2] = '*')) or
                         ((St[1] = '/') and (St[2] = '/'))));
      hlCBuilder, hlSQL, hlJava:
        Result := (LS > 1) and (St[1] = '/') and
          ((St[2] = '*') or (St[2] = '/'));
      hlVB:
        Result := (LS > 0) and (St[1] = '''');
      hlPython, hlPerl:
        Result := (LS > 0) and (St[1] = '#'); 
      else
        Result := False;
    end; { case }
  end;

  function IsStringConstant(St: string): boolean;
  var
    LS: integer;
  begin
    LS := Length(St);
    case FHighLighter of
      hlPascal, hlCBuilder, hlSql, hlPython, hlJava, hlPerl:
        Result := (LS > 0) and ((St[1] = '''') or (St[1] = '"'));
      hlVB:
        Result := (LS > 0) and (St[1] = '"');
      hlHtml:
        Result := False;
    else
      Result := False; { unknown highlighter ? }
    end;
  end;

  procedure SetColor(Color: TSymbolColor);
  var
    i: integer;
  begin
    for i := Parser.PosBeg[0] + 1 to Parser.PosEnd[0] do
    begin
      LineAttrs[i].FC := Color.ForeColor;
      LineAttrs[i].BC := Color.BackColor;
      LineAttrs[i].Style := Color.Style;
    end;
  end;

  function NextSymbol: string;
  var
    i: Integer;
  begin
    i := 0;
    while (Parser.PCPos[i] <> #0) and (Parser.PCPos[i] in [' ', #9, #13, #10]) do
    begin
      inc(i);
    end;
    Result := Parser.PCPos[i];
  end;

  procedure TestHtmlSpecChars;
  var
    i, j, iBeg, iEnd: Integer;
    S1: string;
    F1: Integer;
  begin
    i := 1;
    F1 := Parser.PosBeg[0];
    while i <= Length(Token) do
    begin
      if Token[i] = '&' then
      begin
        iBeg := i; iEnd := iBeg;
        inc(i);
        while i <= Length(Token) do
        begin
          if Token[i] = ';' then
          begin
            iEnd := i;
            break;
          end;
          inc(i);
        end;
        if iEnd > iBeg + 1 then
        begin
          S1 := Copy(Token, iBeg + 1, iEnd - iBeg - 1);
          if IsHtmlSpecChar(S1) then
            for j := iBeg to iEnd do
            begin
              LineAttrs[F1 + j].FC := Colors.Preproc.ForeColor;
              LineAttrs[F1 + j].BC := Colors.Preproc.BackColor;
              LineAttrs[F1 + j].Style := Colors.Preproc.Style;
            end;
        end;
      end;
      inc(i);
    end;
  end;

var
  F: boolean;
  S: string;
  C: TSymbolColor;
  Reserved: Boolean;
  PrevToken: string;
  InTag: Boolean;
  N: Integer;
begin
  S := Lines[Line];
  if (FHighLighter = hlNone) and not UserReservedWords then
    C := Colors.PlainText
  else
  begin
    FLine := S;
    FLineNum := Line;
    Parser.pcProgram := PChar(S);
    Parser.pcPos := Parser.pcProgram;
    CheckInLong;
    if (FHighLighter in [hlCBuilder, hlJava]) and (Length(S) > 0) and
       (S[1] = '#') and (FLong = 0) then
      C := FColors.FPreproc
    else if (FHighLighter in [hlPython, hlPerl]) and (Length(S) > 0) and
       (S[1] = '#') and (FLong = 0) then
      C := FColors.FComment
    else
      C := FColors.FPlainText;
    if (FLong <> 0) and (FHighLighter <> hlHtml) then
    begin
      Parser.pcPos := Parser.pcProgram + FindLongEnd + 1;
      if (FHighLighter in [hlPython, hlPerl]) and (FLong = 4) then
        C := FColors.FString
      else
        C := FColors.FComment;
    end;
  end;

  LineAttrs[1].FC := C.ForeColor;
  LineAttrs[1].Style := C.Style;
  LineAttrs[1].BC := C.BackColor;
  N := Min(Max_X, Length(S));
  for i := 1 to N do
    Move(LineAttrs[1], LineAttrs[i], sizeof(LineAttrs[1]));
  if Length(S) < Max_X then
  begin
    LineAttrs[N+1].FC := Font.Color;
    LineAttrs[N+1].Style := Font.Style;
    LineAttrs[N+1].BC := Color;
    for i := N+1 to Max_X do
      Move(LineAttrs[N+1], LineAttrs[i], sizeof(LineAttrs[1]));
  end;

  if (FHighLighter = hlNone) and not UserReservedWords then Exit;
  if (FHighLighter in [hlCBuilder, hlJava, hlPython, hlPerl]) and
     (Length(S) > 0) and (S[1] = '#') then
     Exit;

  try
    InTag := FLong = 5;
    PrevToken := '';
    Token := Parser.Token;
    while Token <> '' do
    begin
      F := true;
      if UserReservedWords and GetReservedWord(Token, Reserved) then
      begin
        if Reserved then
          SetColor(FColors.FReserved);
      end
      else
        case FHighLighter of
          hlPascal:
            if IsDelphiKeyWord(Token) then
              SetColor(FColors.FReserved)
            else
              F := false;
          hlCBuilder:
            if IsBuilderKeyWord(Token) then
              SetColor(FColors.FReserved)
            else
              F := false;
          hlSql:
            if IsSQLKeyWord(Token) then
              SetColor(FColors.FReserved)
            else
              F := false;
          hlPython:
            if IsPythonKeyWord(Token) then
              SetColor(FColors.FReserved)
            else if Token = 'None' then
              SetColor(FColors.FNumber)
            else if (PrevToken = 'def') or (PrevToken = 'class') then
              SetColor(FColors.FDeclaration)
            else if (NextSymbol = '(') and IsIdentifer(Token) then
              SetColor(FColors.FFunctionCall)
            else
              F := false;
          hlJava:
            if IsJavaKeyWord(Token) then
              SetColor(FColors.FReserved)
            else if PrevToken = 'function' then
              SetColor(FColors.FDeclaration)
            else
              F := false;
          hlVB:
            if IsVBKeyWord(Token) then
              SetColor(FColors.FReserved)
            else if IsVBStatement(Token) then
              SetColor(FColors.FStatement)
            else if Cmp(PrevToken, 'function') or Cmp(PrevToken, 'sub') or
              Cmp(PrevToken, 'class') then
              SetColor(FColors.FDeclaration)
            else
              F := false;
          hlHtml:
            if not InTag then
            begin
              if Token = '<' then
              begin
                InTag := True;
                SetColor(FColors.FReserved)
              end;
              F := True;
            end
            else
            begin
              if Token = '>' then
              begin
                InTag := False;
                SetColor(FColors.FReserved)
              end
              else if (Token = '/') and (PrevToken = '<') then
                SetColor(FColors.FReserved)
              else if (NextSymbol = '=') and IsIdentifer(Token) then
                SetColor(FColors.FIdentifer)
              else if PrevToken = '=' then
                SetColor(FColors.FString)
              else if IsHtmlTag(Token) then
                SetColor(FColors.FReserved)
              else
                F := false;
            end;
          hlPerl:
            if IsPerlKeyWord(Token) then
              SetColor(FColors.FReserved)
            else if IsPerlStatement(Token) then
              SetColor(FColors.FStatement)
            else if Token[1] in ['$', '@', '%', '&'] then
              SetColor(FColors.FFunctionCall)
            else
              F := false;
          else
            F := false;
        end;
      if F then {Ok}
      else if IsComment(Token) then
        SetColor(FColors.FComment)
      else if IsStringConstant(Token) then
        SetColor(FColors.FString)
      else if (Length(Token) = 1) and (Token[1] in Symbols) then
        SetColor(FColors.FSymbol)
      else if IsIntConstant(Token) or IsRealConstant(Token) then
        SetColor(FColors.FNumber)
      else if (FHighLighter in [hlCBuilder, hlJava, hlPython]) and
        (PrevToken = '0') and (Token[1] in ['x', 'X']) then
        SetColor(FColors.FNumber)
      else if FHighLighter = hlHtml then
        SetColor(FColors.FPlainText)
      else
        SetColor(FColors.FIdentifer);
      if FHighLighter = hlHtml then
      begin
       { found special chars starting with '&' and ending with ';' }
        TestHtmlSpecChars;
      end;
      PrevToken := Token;
      Token := Parser.Token;
    end;
  except                         

  end;
end; { GetAttr }

procedure TRAHLEditor.CheckInLong;
begin
  if not FLongTokens then
  begin
    FLong := 0;
    Exit;
  end;
  if FLineNum <= High(FLongDesc) then
    FLong := FLongDesc[FLineNum]
  else
    { oh my god!, it's very big text }
    FLong := 0;
end;

procedure TRAHLEditor.RescanLong;
var
  iLine: integer;
  P, F: PChar;
  S: string;
  i, i1, L1: Integer;
begin
  if not FLongTokens then
  begin
    FLong := 0;
    Exit;
  end;
  if Lines.Count = 0 then Exit;
  FLong := 0;
  iLine := 0;
  FillChar(FLongDesc, sizeof(FLongDesc), 0);
  while iLine < Lines.Count - 1 do { Iterate }
  begin
    { only real programer can write loop on 5 pages }

    S := Lines[iLine];
    P := PChar(S);
    F := P;
    L1 := Length(S);
    i := 1;
    while i <= L1 do
    begin
      case FHighLighter of
        hlPascal:
          case FLong of
            0: //  not in comment
              case S[i] of
                '{':
                  begin
                    P := StrScan(F + i, '}');
                    if P = nil then
                    begin
                      FLong := 1;
                      Break;
                    end
                    else
                      i := P - F + 1;
                  end;
                '(':
                  if {S[i + 1]} F[i] = '*' then
                  begin
                    FLong := 2;
                    P := StrScan(F + i + 2, ')');
                    if P = nil then
                      Break
                    else
                    begin
                      if P[-1] = '*' then
                        FLong := 0;
                      i := P - F + 1;
                    end;
                  end;
                '''':
                  begin
                    P := StrScan(F + i + 1, '''');
                    if P <> nil then
                    begin
                      i1 := P - F;
                      if P[1] <> '''' then
                        i := i1
                      else
                        { ?? }
                    end
                    else
                      i := L1 + 1;
                  end;
              end; { case }
            1:
              begin //  {
                P := StrScan(F + i - 1, '}');
                if P <> nil then
                begin
                  FLong := 0;
                  i := P - F + 1;
                end
                else
                  i := L1 + 1;
              end;
            2:
              begin //  (*
                P := StrScan(F + i, ')');
                if P = nil then
                  Break
                else
                begin
                  if P[-1] = '*' then
                    FLong := 0;
                  i := P - F + 1;
                end;
              end;
          end; { case FLong }
        hlCBuilder, hlSql, hlJava:
          case FLong of
            0: //  not in comment
              case S[i] of
                '/':
                  if S[i + 1] = '*' then
                  begin
                    FLong := 2;
                    P := StrScan(F + i + 2, '/');
                    if P = nil then
                      Break
                    else
                    begin
                      if P[-1] = '*' then
                        FLong := 0;
                      i := P - F + 1;
                    end;
                  end;
                '"':
                  begin
                    P := StrScan(F + i + 1, '"');
                    if P <> nil then
                    begin
                      i1 := P - F;
                      if P[1] <> '"' then
                        i := i1
                      else
                        { ?? }
                    end
                    else
                      i := L1 + 1;
                  end;
              end; { case }
            2:
              begin //  /*
                P := StrScan(F + i, '/');
                if P = nil then
                  Break
                else
                begin
                  if P[-1] = '*' then
                    FLong := 0;
                  i := P - F + 1;
                end;
              end;
          end; { case FLong }
        hlPython:
          case FLong of
            0: //  not in comment
              case S[i] of
                '"':
                  begin
                    P := StrScan(F + i, '"');
                    if P = nil then
                    begin
                      FLong := 4;
                      Break;
                    end
                    else
                      i := P - F + 1;
                  end;
              end; { case }
            4: // python long string
              begin
                P := StrScan(F + i - 1, '"');
                if P <> nil then
                begin
                  FLong := 0;
                  i := P - F + 1;
                end
                else
                  i := L1 + 1;
              end;
          end; { case FLong }
        hlHtml:
          case FLong of
            0: //  not in comment
              case S[i] of
                '<':
                  begin
                    P := StrScan(F + i, '>');
                    if P = nil then
                    begin
                      FLong := 5;
                      Break;
                    end
                    else
                      i := P - F + 1;
                  end;
              end; { case }
            5: // html tag
              begin
                P := StrScan(F + i - 1, '>');
                if P <> nil then
                begin
                  FLong := 0;
                  i := P - F + 1;
                end
                else
                  i := L1 + 1;
              end;
          end; { case FLong }
      end; { FHighLighter }
      inc(i);
    end; { while i <= L1 }
    inc(iLine);
    FLongDesc[iLine] := FLong;
  end; { iLine < Lines.Count - 1 }
end;

function TRAHLEditor.FindLongEnd: integer;
var
  P, F: PChar;
begin
  P := PChar(FLine);
  Result := Length(FLine);
  case FHighLighter of
    hlPascal:
      case FLong of
        1:
          begin
            P := StrScan(P, '}');
            if P <> nil then
              Result := P - PChar(FLine);
          end;
        2:
          begin
            F := P;
            while true do
            begin
              F := StrScan(F, '*');
              if F = nil then Exit;
              if F[1] = ')' then break;
              inc(F);
            end;
            P := F + 1;
            Result := P - PChar(FLine);
          end;
      end;
    hlCBuilder, hlSql, hlJava:
      begin
        F := P;
        while true do
        begin
          F := StrScan(F, '*');
          if F = nil then Exit;
          if F[1] = '/' then break;
          inc(F);
        end;
        P := F + 1;
        Result := P - PChar(FLine);
      end;
    hlPython:
      case FLong of
        4:
          begin
            P := StrScan(P, '"');
            if P <> nil then
              Result := P - PChar(FLine);
          end;
      end;
    hlHtml:
      case FLong of
        4:
          begin
            P := StrScan(P, '>');
            if P <> nil then
              Result := P - PChar(FLine);
          end;
      end;
  end;
end;

procedure TRAHLEditor.TextModified(Pos: integer; Action: TModifiedAction; Text:
  string);
var
  S: string;
begin
  if not FLongTokens then Exit;
  case FHighLighter of
    hlPascal:
      S := '{}*()/'#13;
    hlCBuilder, hlJava, hlSql:
      S := '*/'#13;
    hlVB:
      S := '''' + #13;
    hlPython:
      S := '#"'#13;
    hlHtml:
      S := '<>'#13;
  else
    S := #13; { unknown highlighter ? }
  end;
  if HasAnyChar(S, Text) then
  begin
    RescanLong;
    Invalidate;
  end;
end; { TextChanged }

function TRAHLEditor.GetReservedWord(const Token: string; var Reserved:
  Boolean): Boolean;
begin
  Result := Assigned(FOnReservedWord);
  if Result then
  begin
    Reserved := False;
    FOnReservedWord(Self, Token, Reserved);
  end
end;

function TRAHLEditor.UserReservedWords: boolean;
begin
  Result := Assigned(FOnReservedWord);
end; {  }

end.

