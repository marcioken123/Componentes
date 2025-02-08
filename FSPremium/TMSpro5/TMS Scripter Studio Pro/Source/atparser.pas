{***************************************************************************}
{ Scripter Studio Components for Delphi & C++Builder                        }
{ version 4.7 (Std), 1.7 (Pro)                                              }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit atParser;

{$I ASCRIPT.INC}

interface
uses
  {$IFNDEF LINUX}
  Windows, SysUtils, Classes, Dialogs, ComCtrls, Contnrs;
  {$ELSE}
  SysUtils, Classes, QDialogs, QComCtrls;
  {$ENDIF}


const
   AllChars = #0#1#2#3#4#5#6#7#8#9#10#11#12#13#14#15#16#17#18#19#20#21#22#23#24+
              #25#26#27#28#29#30#31' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGH'+
              'IJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~��������'+
              '���������������������������������������������������������������'+
              '���������������������������������������������������������';

   SpecialChars = #0#1#2#3#4#5#6#7#8#9#10#11#12#13#14#15#16#17#18#19#20#21#22+
                  #23#24#25#26#27#28#29#30#31;

type
   TSyntaxResult = (srNotDefined, srCorrect, srIncomplete, srOverFlow, srIncorrect);
   EParserError = class(Exception);

   TNoTerminals = class;
   TNoTerminalNodes = class;
   TNoTerminalNode = class;
   TatSyntaxParser = class;
   TSavedInputs = class;
   TSavedInput = class;
   TIncludes = class;
   TInclude = class;

   { TParsingResults }
   TParsingResults = record
      Result          : TSyntaxResult;
      Suggestion      : char;
      InputPos        : integer;
      SyntaxPos       : integer;
      NoTerminalIndex : integer;
      MaxInputPos     : integer;
      LastResult      : TSyntaxResult;
   end;

   TNodeScanProc = procedure( Node:TNoTerminalNode ) of object;
   TNodeStringChangeProc = function( Node:TNoTerminalNode ):string of object;
   TAcceptNodeProc = function( Node:TNoTerminalNode ):boolean of object;
   TAcceptCharProc = function( Node:TNoTerminalNode; ACurrentPos: integer ):boolean of object;
   TExtractRemarkEvent = procedure(AParser: TatSyntaxParser; AStartPos, AFinalPos: integer ) of object;
   TNodeNotifyEvent = procedure( Node:TNoTerminalNode ) of object;
   TRefuseInputEvent = procedure( AInclude:TInclude; AInputPos: integer ) of object;
   TIncludeInputEvent = procedure(const AParser: TatSyntaxParser; const AName: string; var AInputBuffer: string; var AInfoObject: TObject) of object;

   { TNoTerminal }

   TNoTerminal = class(TCollectionItem)
   private
      FIdS                : string;
      FSyntax             : string; // sintaxe com referencias indexadas aos nao-terminais
      FSyntaxText         : string; // sintaxe original
      FOnBeforeNodeScan   : TNodeScanProc;
      FOnAfterNodeScan    : TNodeScanProc;
      FOnAcceptNode       : TAcceptNodeProc;
      FOnAcceptCharacter  : TAcceptCharProc;
      FOnNodeStringChange : TNodeStringChangeProc;
      FReverseScanning    : boolean;
      function GetNoTerminals: TNoTerminals;
   public
      procedure AssignNodeScanningEvents( AOnBeforeNodeScan,AOnAfterNodeScan:TNodeScanProc );
      property IdS:string read FIdS write FIdS;
      property Syntax:string read FSyntax write FSyntax;
      property SyntaxText:string read FSyntaxText write FSyntaxText;
      property OnBeforeNodeScan: TNodeScanProc read FOnBeforeNodeScan write FOnBeforeNodeScan;
      property OnAfterNodeScan: TNodeScanProc read FOnAfterNodeScan write FOnAfterNodeScan;
      property ReverseScanning: boolean read FReverseScanning write FReverseScanning;
      property OnAcceptNode: TAcceptNodeProc read FOnAcceptNode write FOnAcceptNode;
      property OnAcceptCharacter: TAcceptCharProc read FOnAcceptCharacter write FOnAcceptCharacter;
      property OnNodeStringChange: TNodeStringChangeProc read FOnNodeStringChange write FOnNodeStringChange;
      property NoTerminals: TNoTerminals read GetNoTerminals;
   end;

{ TNoTerminals }

   TNoTerminals = class(TCollection)
   private
      function GetItem(Index:Integer):TNoTerminal;
   public
      constructor Create;
      function Add(AIdS,ASyntax:string):TNoTerminal;
      procedure Delete(i:integer);
      function IndexOf(IdS:string):integer;
      procedure LoadFromStrings(List:TStrings);
      property Items[Index: Integer]: TNoTerminal read GetItem; default;
   end;

{ TNoTerminalNode }

   TNoTerminalNode = class(TCollectionItem)
   private
      FNoTerminalIndex   : integer;
      FInputInitialPos   : integer;
      FInputFinalPos     : integer;
      FNodes             : TNoTerminalNodes;
      FatSyntaxParser    : TatSyntaxParser;
      FInclude           : TInclude;
      function GetInputToken:string;
      function GetOwnerNodes:TNoTerminalNodes;
      function GetNoTerminal:TNoTerminal;
      function GetParentNode:TNoTerminalNode;
      function GetInputChar(i:integer):char;
      //procedure CheckBoundaries(i, f: integer);
      //function ShiftSubsequentNode(p,delta:integer):TNoTerminalNode;
      //procedure CheckInsertBoundaries(i: integer);
      function GetFinalPos: integer;
      function GetInitialPos: integer;
      function GetTokenLength: integer;
      procedure SetFinalPos(const Value: integer);
      procedure SetInitialPos(const Value: integer);
      procedure SetTokenLength(const Value: integer);
      function GetItem(i: integer): TNoTerminalNode;
      procedure MoveByOffset(delta: integer);
      procedure SetInputFinalPos(const Value: integer);
      procedure SetInputInitialPos(const Value: integer);
      function GetStrToken: string;
   public
      constructor Create(ACollection:TCollection); override;
      destructor Destroy; override;

      { NODE STRING MANIPULATION METHODS }
      { change the node string and delete all subnodes }
      procedure ChangeNodeString( s:string );
      { change a node substring }
      //procedure ChangeSubString( s:string; i,f:integer );
      { find a substring and replace by another }
      //procedure FindAndReplaceSubString( s:string; s1:string );
      { insert a subnode into node }
      //function InsertSubNodeString( s:string; p:integer; noterm:integer ):TNoTerminalNode;
      { insert a prefix string into node string }
      //procedure InsertPrefixSubString( s:string );
      { insert a sufix string into node string }
      //procedure InsertSufixSubString( s:string );
      { insert a substring into node string }
      //procedure InsertSubString( s:string; p:integer );
      { delete a subnode by its index }
      //procedure DeleteSubNode( i:integer );
      { delete "n" characters from begin of node string }
      //procedure DeletePrefixSubstring( n:integer );
      { delete "n" characters from end of node string }
      //procedure DeleteSufixSubString( n:integer );
      { move subnode to position p relative to "refnode" }
      //procedure MoveToPosition(refnode:TNoTerminalNode;p:integer);
      { properties }
      property OwnerNodes: TNoTerminalNodes read GetOwnerNodes;
      property ParentNode: TNoTerminalNode read GetParentNode;
      property NoTerminalIndex:integer read FNoTerminalIndex write FNoTerminalIndex;
      property InputInitialPos:integer read FInputInitialPos write SetInputInitialPos;
      property InputFinalPos:integer read FInputFinalPos write SetInputFinalPos;
      property Nodes:TNoTerminalNodes read FNodes write FNodes;
      property InputToken:string read GetInputToken;
      property StrToken:string read GetStrToken;
      property atSyntaxParser:TatSyntaxParser read FatSyntaxParser;
      property NoTerminal:TNoTerminal read GetNoTerminal;
      property InputChar[i:integer]:char read GetInputChar;
      property InitialPos:integer read GetInitialPos write SetInitialPos;
      property FinalPos:integer read GetFinalPos write SetFinalPos;
      property TokenLenght:integer read GetTokenLength write SetTokenLength;
      property Items[i:integer]:TNoTerminalNode read GetItem; default;
      property Include: TInclude read FInclude;
   end;

{ TNoTerminalNodes }

   TNoTerminalNodes = class(TCollection)
   private
      FNode  : TNoTerminalNode;
      function  GetItem(i:integer):TNoTerminalNode;
   public
      constructor Create(Owner:TNoTerminalNode);
      function Add(NoTermIndex:integer):TNoTerminalNode;
      procedure Delete(i:integer);
      function IndexOf(NoTerminalIndex:integer):integer;
      function FindByNoTerminalName(const AName:string):TNoTerminalNode;
      property Node:TNoTerminalNode read FNode write FNode;
      property Items[i:integer]:TNoTerminalNode read GetItem; default;
   end;

   TSyntaxComment = class(TCollectionItem)
   private
      FOpenString: string;
      FCloseString: string;
      FPriorDelims: string;
   public
      property OpenString: string read FOpenString write FOpenString;
      property CloseString: string read FCloseString write FCloseString;
      property PriorDelims: string read FPriorDelims write FPriorDelims;
   end;

   TSyntaxComments = class(TCollection)
   private
      function GetItem(Index: integer): TSyntaxComment;
   public
      function Add(AOpenString, ACloseString: string): TSyntaxComment;
      property Items[Index: integer]: TSyntaxComment read GetItem; default;
   end;

   { TatSyntaxParser }

   TatSyntaxParser = class(TComponent)
   private
     FParsing             : boolean;
     FBranchCount         : integer;
     FNode                : TNoTerminalNode;
     FNoTerminals         : TNoTerminals;
     FSyntax              : string;
     FGrammar             : TStrings;
     FInput               : string;
     FStrings             : TStrings;
     FScanningInputPos    : integer;
     FDisableBranching    : boolean; // usado pelo ScanNode p/ evitar recurs�o
     FStringDelimitter    : char;
     FCustomLexemes       : array[0..9] of string;
     // for remark parsing (also called comment)
     FCurrentInputPos     : integer; // posi��o corrente durante parsing (atualizado apenas no CheckRemarks)
     FCurrentMaxInputPos  : integer; // m�xima posi��o alcan�ada no texto de entrada (atualizado apenas no CheckRemarks)
     FComments            : TSyntaxComments;
     FOnExtractRemark     : TExtractRemarkEvent;
     FOnRefuseNode        : TNodeNotifyEvent;
     FOnRefuseRemarks     : TRefuseInputEvent;
     FContinueOnRemarks   : boolean;
     FOnIncludeInput      : TIncludeInputEvent;
     FSavedInputs         : TSavedInputs;
     FCurrentInclude      : TInclude;
     FProcessingRemarks   : boolean;
     FIncludes            : TIncludes;
     FLastRemarkFound     : integer; // posi��o final somente quando tem OnExtractRemark
     FOnNewNode           : TNodeNotifyEvent; // when a node was created on the syntaxtree (debugging purposes)

     {RebuildFromNode optimization variables}
     FTempNodes : TObjectList;
     procedure SetGrammar(Value : TStrings);
     procedure SetStrings(Value : TStrings);
     function ParseInput(Nodes:TNoTerminalNodes;Syntax:string;
               InputPosition:integer;literal:boolean;
               CurrentNoTerm:integer; var results:TParsingResults ):boolean;
     procedure GrammarChange(Sender : TObject);
     procedure StringsChange(Sender : TObject);
     procedure SetDisableBranching(const Value: boolean);
     procedure SetContinueOnRemarks(const Value: boolean);
     procedure SetCurrentInputPos(const Value: integer);
     procedure SetCurrentMaxInputPos(const Value: integer);
     procedure SetInput(const Value: string);
    function GetCustomLexeme(i: integer): string;
    procedure SetCustomLexeme(i: integer; const Value: string);
    procedure SetOnNewNode(const Value: TNodeNotifyEvent);
   protected
     procedure ChangePositions(refnode: TNoTerminalNode; delta: integer; ignoresubnodes:boolean);
     property Syntax:string read FSyntax;
   public
     constructor Create(AOwner: TComponent); override;
     destructor  Destroy; override;
     procedure Clear;
     function CheckLanguage: TParsingResults;
     function CheckExpression: TParsingResults;
     procedure BuildSyntaxTreeView(TreeView: TTreeView);
     procedure ScanNode(ANode: TNoTerminalNode);
     function ScanSyntaxTree:boolean;
     function RebuildFromNodes: string;
     function FindNodeByPosition(p:integer):TNoTerminalNode;
     function TestInputString(APos: integer;s:string;ACaseSensitive:boolean=false):boolean;
     { properties }
     property Effort : integer read FBranchCount;
     property NoTerminals:TNoTerminals read FNoTerminals;
     property Node:TNoTerminalNode read FNode{ write FNode};
     property Grammar : TStrings read FGrammar write SetGrammar;
     property Strings : TStrings read FStrings write SetStrings;
     property ScanningInputPos : integer read FScanningInputPos;
     property Input:string read FInput write SetInput;
     property DisableBranching : boolean read FDisableBranching write SetDisableBranching;
     property Parsing: boolean read FParsing;
     property CustomLexemes[i:integer]:string read GetCustomLexeme write SetCustomLexeme;
     { for remarks }
     procedure IncludeInput(AName: string);
     property ProcessingRemarks: boolean read FProcessingRemarks;
     property Comments: TSyntaxComments read FComments;
     property StringDelimitter: char read FStringDelimitter write FStringDelimitter;
     property ContinueOnRemarks: boolean read FContinueOnRemarks write SetContinueOnRemarks;
     property OnExtractRemark: TExtractRemarkEvent read FOnExtractRemark write FOnExtractRemark;
     property OnRefuseNode: TNodeNotifyEvent read FOnRefuseNode write FOnRefuseNode;
     property OnRefuseRemarks: TRefuseInputEvent read FOnRefuseRemarks write FOnRefuseRemarks;
     property OnIncludeInput: TIncludeInputEvent read FOnIncludeInput write FOnIncludeInput;
     property CurrentInputPos: integer read FCurrentInputPos write SetCurrentInputPos;
     property CurrentMaxInputPos: integer read FCurrentMaxInputPos write SetCurrentMaxInputPos;
     property CurrentInclude: TInclude read FCurrentInclude;
   published
     property OnNewNode: TNodeNotifyEvent read FOnNewNode write SetOnNewNode;
   end;

   TSavedInputs = class(TOwnedCollection)
   private
     function GetItems(i: integer): TSavedInput;
   public
     function Add: TSavedInput;
     property Items[i:integer]: TSavedInput read GetItems; default;
   end;

   TSavedInput = class(TCollectionItem)
   private
     FSavedInclude : TInclude;
     FSavedInputPosition : integer;
     FSavedMaxInputPosition : integer;
     FSavedInputBuffer : string;
   end;

   TIncludes = class(TOwnedCollection)
   private
     function GetItems(i: integer): TInclude;
   public
     function Add: TInclude;
     property Items[i:integer]: TInclude read GetItems; default;
     function IndexOf(AName: string): integer;
     function FindByName(AName: string): TInclude;
   end;

   TInclude = class(TCollectionItem)
   private
     FName : string;
     FInfoObject : TObject;
     FInputBuffer : string;
   public
     property Name : string read FName;
     property InfoObject : TObject read FInfoObject;
     property InputBuffer : string read FInputBuffer;
   end;

procedure GetRowColFromStrings(lines:TStrings;position:integer;var row,col:integer);
function SubtractChars( s,chars: string ):string;

implementation

type
   TTokenType = (ttOptional, ttReplicate, ttAchoice, ttNoTerminal, ttLiterate,
     ttNumeric, ttAlfabetic, ttSpecial, ttCharacter,
     {ttSpaces has special syntax. After a space can follow a special character that differentiates the spaces syntax.

      ^ -> do not allow #13 or #10 characters
      \ -> requires #13 characters

      Example:
      <sample1>:one two three
      <sample2>:one ^two ^three
      <sample3>:one two \three

      in sample1, the words can be on the same line or different line
      in sample2, words must be in the same line
      in sample3, "three" must be in different (next) line than "two"
     }
     ttSpaces,
     ttString,
     ttAnything, ttCustom, ttLineFeed, ttSameLine);

{ Fun��es auxiliadoras }

function SubtractChars( s,chars: string ):string;
var c: integer;
begin
   result := '';
   for c:=1 to length(s) do
      if pos(s[c],chars)=0 then
         result := result + s[c];
end;

(*function MoveCollectionItem(ACollection:TCollection;AIndex:integer;ATargetCollection:TCollection;ATarget:integer):TCollectionItem;
begin
   if (ACollection=ATargetCollection) then
   begin
      ACollection.Items[AIndex].Index:=ATarget;
      result:=nil;
   end
   else
   begin
      if ATarget>=ATargetCollection.Count then
         result:=ATargetCollection.Add
      else
      begin
         result:=ATargetCollection.Add;
         result.Index:=ATarget;
      end;
      result.Assign( ACollection.Items[AIndex] );
      ACollection.Items[AIndex].Free;
   end;
end;*)

procedure GetRowColFromStrings(lines:TStrings;position:integer;var row,col:integer);
var c,i,f : integer;
begin
   if position<length(lines.text) then
   begin
      row:=0;
      col:=0;
      i:=1;
      for c:=0 to lines.count-1 do
      begin
         f:=i+length( lines[c] )-1;
         if (position>=i-1) and (position<=f+1) then
         begin
            row:=c+1;
            col:=position-i+2;
            if col > length(lines[c]) then
              col := length(lines[c]);
            break;
         end;
         i:=f+3;
      end;
   end
   else
   begin
      row:=lines.Count+1;
      col:=1;
   end;
end;

{ TNoTerminal }

procedure TNoTerminal.AssignNodeScanningEvents( AOnBeforeNodeScan,AOnAfterNodeScan:TNodeScanProc );
begin
   FOnBeforeNodeScan := AOnBeforeNodeScan;
   FOnAfterNodeScan  := AOnAfterNodeScan;
end;

function TNoTerminal.GetNoTerminals: TNoTerminals;
begin
   result:=TNoTerminals(Collection);
end;

{ TNoTerminals }

constructor TNoTerminals.Create;
begin
   inherited Create(TNoTerminal);
end;

function TNoTerminals.Add(AIdS,ASyntax:string):TNoTerminal;
begin
   result := TNoTerminal(inherited Add);
   with result do
   begin
      IdS:=AIds;
      Syntax:=ASyntax;
   end;
end;

procedure TNoTerminals.Delete(i:integer);
begin
   if (i>=0) and (i<Count) then
   begin
      TNoTerminal(Items[i]).Free;
   end;
end;

function TNoTerminals.IndexOf(IdS:string):integer;
begin
   for result:=0 to Count-1 do
      if AnsiCompareText(TNoTerminal(Items[result]).IdS,UpperCase(IdS))=0 then Exit;
   result:=-1;
end;

function TNoTerminals.GetItem(Index: Integer): TNoTerminal;
begin
   Result := TNoTerminal(inherited Items[Index]);
end;

procedure TNoTerminals.LoadFromStrings(List:TStrings);
var c,c1,i,f,s    : integer;
    aux0,aux1     : string;
    Transliterate : boolean;
begin
   Clear;
   { define todos os nomes de n�o-terminais }
   for c:=0 to list.count-1 do
   begin
      i:=pos('<',list[c]);
      f:=pos('>',list[c]);
      s:=pos(':',list[c]);
      with Add( copy(list[c],i+1,f-i-1),copy(list[c],s+1,length(list[c])-s) ) do
      begin
         { an�lise dos modificadores de n�o-terminais }
         { para usar modificadores, inclua caracteres entre o s�mbolo ">" e o ":" na
           defini��o do n�o-terminal }
         { "R" (Reverse scanning): realiza a an�lise sint�tica em ordem reversa
           para os n�o-terminais pertinentes a este n�o-terminal }
         if pos('R',copy(list[c],f+1,s-f-1))>0 then FReverseScanning:=True else
      end;
   end;
   { troca todos os nomes de n�o-terminais da Syntaxe pelos respectivos �ndices }
   Transliterate:=False;
   for c:=0 to count-1 do
   begin
      aux0:=Items[c].FSyntax;
      aux1:='';
      i:=-1;
      for c1:=1 to length(aux0) do
      begin
         if aux0[c1]='"' then
         begin
            Transliterate:=not Transliterate;
            aux1:=aux1+'"';
         end
         else
            if Transliterate then
               aux1:=aux1+aux0[c1]
            else
               if aux0[c1]='<' then
                  i:=c1
               else
                  if aux0[c1]='>' then
                  begin
                     aux1:=aux1+'<'+inttostr( IndexOf(copy(aux0,i+1,c1-i-1)) )+'>';
                     i:=-1;
                  end
                  else
                     if i=-1 then aux1:=aux1+aux0[c1];
      end;
      Items[c].FSyntaxText:=aux0;
      Items[c].FSyntax:=aux1;
   end;
end;

{ TNoTerminalNode }

constructor TNoTerminalNode.Create(ACollection: TCollection);
begin
   inherited Create(ACollection);
   FInputInitialPos := -1;
   FInputFinalPos := -1;
   FNodes:=TNoTerminalNodes.Create(self);
end;

destructor TNoTerminalNode.Destroy;
begin
   if Assigned(FatSyntaxParser) and Assigned(FatSyntaxParser.FTempNodes) then
     FatSyntaxParser.FTempNodes.Remove(Self);
   FNodes.Free;
   inherited;
end;

function TNoTerminalNode.GetOwnerNodes : TNoTerminalNodes;
begin
   result:=TNoTerminalNodes(Collection);
end;

function TNoTerminalNode.GetStrToken: string;

  (*procedure _IgnoreRemarks(const AInput: string; var ACurPos: integer);

     function _MatchString(const S: string; AInputPos: integer): boolean;
     var i: integer;
     begin
        result:=true;
        for i:=0 to Length(S)-1 do
        begin
           if ((AInputPos+i)>length(AInput)) or (Upcase(AInput[AInputPos+i])<>Upcase(S[i+1])) then
           begin
              result:=false;
              break;
           end;
        end;
     end;

  var
    CommentIndex: integer;
    c: integer;
    ALevel: integer;
  begin
     CommentIndex:=-1;
     for c:=0 to FatSyntaxParser.FComments.Count-1 do
        if _MatchString(FatSyntaxParser.FComments[c].OpenString, ACurPos) then
        begin
           CommentIndex:=c;
           break;
        end;
     if CommentIndex <> -1 then
     begin
        Alevel:=1;
        inc(ACurPos, Length(FatSyntaxParser.FComments[CommentIndex].OpenString));
        repeat
           if (ACurPos > length(AInput)) then break;
           //if (FInput[InputPosition]=StringDelimitter) then TransString:=not TransString else
           if _MatchString(FatSyntaxParser.FComments[CommentIndex].CloseString, ACurPos) then
             dec(Alevel);
           inc(ACurPos);
        until (Alevel=0);
        if (Alevel=0) then
          inc(ACurPos, Length(FatSyntaxParser.FComments[CommentIndex].CloseString)-1);
     end;
  end;*)

  function RemarkStarted(const AInput: string; var ACurPos: integer): boolean;

     function _MatchString(const S: string; AInputPos: integer): boolean;
     var i: integer;
     begin
        result:=true;
        for i:=0 to Length(S)-1 do
        begin
           if ((AInputPos+i)>length(AInput)) or (Upcase(AInput[AInputPos+i])<>Upcase(S[i+1])) then
           begin
              result:=false;
              break;
           end;
        end;
     end;

  var
    c: integer;
  begin
     result := false;
     for c:=0 to FatSyntaxParser.FComments.Count-1 do
        if _MatchString(FatSyntaxParser.FComments[c].OpenString, ACurPos) and
          (
            (FatSyntaxParser.FComments[c].PriorDelims = '') or (ACurPos = 1) or
            ((ACurPos > 1) and (ACurPos <= Length(AInput)) and
            (Pos(AInput[ACurPos - 1], FatSyntaxParser.FComments[c].PriorDelims) <> 0))
          ) then
        begin
           result := true;
           break;
        end;
  end;

var AInput: string;
    APos: integer;
begin
  if Assigned(FatSyntaxParser) then
  begin
    result := '';
    AInput := InputToken;
    APos := 1;
    while APos <= Length(AInput) do
    begin
      //_IgnoreRemarks(AInput, APos);
      if not RemarkStarted(AInput, APos) then
      begin
        if APos <= Length(AInput) then
          result := result + AInput[APos];
      end else
        exit;
      inc(APos);
    end;
  end else
    result := InputToken;
end;

function TNoTerminalNode.GetInputToken:string;
begin
   if Assigned(FInclude) then
      result := Copy(FInclude.InputBuffer,FInputInitialPos,FInputFinalPos-FInputInitialPos+1)
   else
      result := Copy(FatSyntaxParser.FInput,FInputInitialPos,FInputFinalPos-FInputInitialPos+1);
end;

function TNoTerminalNode.GetInputChar(i:integer):char;
begin
   if Assigned(FInclude) then
      result := FInclude.InputBuffer[ FInputInitialPos + i ]
   else
      result := FatSyntaxParser.FInput[ FInputInitialPos + i ];
end;

function TNoTerminalNode.GetNoTerminal:TNoTerminal;
begin
   result:=FatSyntaxParser.FNoTerminals[ FNoTerminalIndex ];
end;

function TNoTerminalNode.GetParentNode:TNoTerminalNode;
begin
   if Assigned(Collection) then
      result:=TNoTerminalNodes(Collection).Node
   else
      result:=nil;
end;

procedure TNoTerminalNode.ChangeNodeString(s: string );
var delta,c: integer;
begin
   { change the node string and delete all subnodes }
   { modifies the string content directly in the buffer }

   { delete all subnodes }
   for c := Nodes.Count-1 downto 0 do
     Nodes.Delete(c);

   { remove the original text of input source }
   Delete(FatSyntaxParser.FInput,FInputInitialPos,FInputFinalPos-FInputInitialPos+1);
   { insere o novo trecho }
   Insert(s,FatSyntaxParser.FInput,FInputInitialPos);
   { ajusta as posi��es de todos os outros nodes afetados }
   delta:=length(s)-(FInputFinalPos-FInputInitialPos+1);

   if delta <> 0 then
   begin
     FatSyntaxParser.ChangePositions(self,delta,False);
     FInputFinalPos:=FInputFinalPos+delta;
   end;
end;

(*procedure TNoTerminalNode.CheckBoundaries(i,f:integer);
var c: integer;
begin
   if (i<1) or (i>f) or (f>FInputFinalPos-FInputInitialPos+1) then
      raise Exception.Create(Format(
         'Tentativa de modificar uma substring n�o pertinente ao n� ''%s''',
         [InputToken]));  
   { n�o permite que a substring perten�a a algum subnode }
   for c:=0 to Nodes.Count-1 do
      with Nodes[c] do
         if ((i-1>=FInputInitialPos-self.FInputInitialPos) and
             (i-1<=FInputFinalPos-self.FInputInitialPos)) or
            ((f-1>=FInputInitialPos-self.FInputInitialPos) and
             (f-1<=FInputFinalPos-self.FInputInitialPos)) then
             raise Exception.Create(Format(
                'N�o � poss�vel modificar a substring ''%s'' do n� ''%s'', '+
                'porque ela pertence a seu sub-n� %d (''%s'')',
                [ copy(self.InputToken,i,f-i+1),
                  self.InputToken,
                  c,
                  NoTerminal.IdS ]) );
end;*)

(*procedure TNoTerminalNode.CheckInsertBoundaries(i:integer);
var c: integer;
begin
   if (i<1) or (i>FInputFinalPos-FInputInitialPos+2) then
      raise Exception.Create(Format(
         'Tentativa de inserir uma substring fora do n� ''%s''',
         [InputToken]));
   { n�o permite que a substring seja inserida dentro de algum subnode }
   for c:=0 to Nodes.Count-1 do
      with Nodes[c] do
         if (i-1>FInputInitialPos-self.FInputInitialPos) and
            (i-1<=FInputFinalPos-self.FInputInitialPos) then
             raise Exception.Create(Format(
                'N�o � poss�vel inserir uma substring no n� ''%s'', '+
                'porque ela pertence a seu sub-n� %d (''%s'')',
                [ self.InputToken,
                  c,
                  NoTerminal.IdS ]) );
end;*)

(*function TNoTerminalNode.ShiftSubsequentNode(p,delta:integer):TNoTerminalNode;
var c: integer;
begin
   { desloca o primeiro sub-n� subsequente a posi��o dada, quando existir }
   { retorna o sub-n� deslocado ou o pr�prio n� quando n�o houver nenhum
     sub-n� subsequente a posi��o dada }
   result:=self;
   for c:=0 to Nodes.Count-1 do
      if (Nodes[c].FInputInitialPos>=self.FInputInitialPos+p-1) then
      begin
         result:=Nodes[c];
         result.FInputInitialPos:=result.FInputInitialPos+delta;
         result.FInputFinalPos:=result.FInputFinalPos+delta;
         { tamb�m desloca todos os n�s que sucederem o n� encontrado }
         FatSyntaxParser.ChangePositions(result,delta,False);
         Exit;
      end;
   { modifica o tamanho deste n� para corresponder ao deslocamento e
     tamb�m desloca todos os n�s que sucederem este n� }
   FInputFinalPos:=FInputFinalPos+delta;
   FatSyntaxParser.ChangePositions(result,delta,True);
end;*)

(*procedure TNoTerminalNode.ChangeSubString(s: string; i, f: integer);
begin
   { change a node substring }

   { Faz a consist�ncia das posi��es a serem modificadas }
   CheckBoundaries(i,f);
   { remove o trecho original da fonte }
   Delete(FatSyntaxParser.FInput,FInputInitialPos+i-1,f-i+1);
   { insere o novo trecho }
   Insert(s,FatSyntaxParser.FInput,FInputInitialPos+i-1);
   { ajusta as posi��es de todos os outros n�s afetados }
   ShiftSubsequentNode(i,length(s)-(f-i+1));
end;*)

(*procedure TNoTerminalNode.DeletePrefixSubstring(n: integer);
begin
   { delete "n" characters from begin of node string }

   { Faz a consist�ncia das posi��es a serem modificadas }
   CheckBoundaries(1,n);
   { remove o trecho original da fonte }
   Delete(FatSyntaxParser.FInput,FInputInitialPos,n);
   { ajusta as posi��es de todos os outros n�s afetados }
   ShiftSubsequentNode(1,-n);
end;*)

(*procedure TNoTerminalNode.DeleteSubNode(i: integer);
var delta : integer;
begin
   { delete a subnode by its index }

   { remove o trecho original da fonte }
   with Nodes[i] do
   begin
      delta:=-(FInputFinalPos-FInputInitialPos+1);
      Delete(FatSyntaxParser.FInput,FInputInitialPos,-delta);
   end;
   { ajusta as posi��es de todos os outros n�s afetados }
   FatSyntaxParser.ChangePositions(Nodes[i],delta,False);
   { elimina definitivamente o sub-n� }
   Nodes.Delete(i);
end;*)

(*procedure TNoTerminalNode.DeleteSufixSubString(n: integer);
begin
   { delete "n" characters from end of node string }

   { Faz a consist�ncia das posi��es a serem modificadas }
   CheckBoundaries(FInputFinalPos-FInputInitialPos+1-n+1,FInputFinalPos-FInputInitialPos+1);
   { remove o trecho original da fonte }
   Delete(FatSyntaxParser.FInput,FInputFinalPos-n+1,n);
   { ajusta as posi��es de todos os outros n�s afetados }
   FatSyntaxParser.ChangePositions(self,-n,True);
end;*)

(*procedure TNoTerminalNode.FindAndReplaceSubString(s, s1: string);
var p : integer;
begin
   { find a substring (s) and replace by another (s0) }
   p:=Pos(s,InputToken);
   if p>0 then
   begin
      { Faz a consist�ncia das posi��es a serem modificadas }
      CheckBoundaries(p,p+length(s)-1);
      { remove o trecho original da fonte }
      Delete(FatSyntaxParser.FInput,FInputInitialPos+p-1,length(s));
      { insere o novo trecho }
      Insert(s1,FatSyntaxParser.FInput,FInputInitialPos+p-1);
      { ajusta as posi��es de todos os outros n�s afetados }
      ShiftSubsequentNode(p+length(s),length(s1)-length(s));
   end;
end;*)

(*procedure TNoTerminalNode.InsertPrefixSubString(s: string);
begin
   { insert a prefix string into node string }

   { insere o novo trecho }
   Insert(s,FatSyntaxParser.FInput,FInputInitialPos);
   { ajusta as posi��es de todos os outros n�s afetados }
   ShiftSubsequentNode(1,length(s));
end;*)

(*function TNoTerminalNode.InsertSubNodeString(s: string; p, noterm: integer):TNoTerminalNode;
var ANewIndex: integer;
begin
   { insert a subnode into node }

   { Faz a consist�ncia das posi��es a serem modificadas }
   CheckInsertBoundaries(p);
   { insere o novo trecho }
   Insert(s,FatSyntaxParser.FInput,FInputInitialPos+p-1);
   { cria um node correspondendo � string inserida }

   { ajusta as posi��es de todos os outros n�s afetados }
   result:=ShiftSubsequentNode(p,length(s));
   { insere a inst�ncia de sub-n� }
   if (result=self) then
      result:=TNoTerminalNode(TCollection(Nodes).Add)
   else
   begin
      ANewIndex:=result.Index;
      result:=TNoTerminalNode(TCollection(Nodes).Add);
      result.Index:=ANewIndex;
   end;
   { ajusta as propriedades da nova inst�ncia de n� }
   with result do
   begin
      FNoTerminalIndex   := noterm;
      FInputInitialPos   := self.FInputInitialPos+p-1;
      FInputFinalPos     := self.FInputInitialPos+p-1+length(s)-1;
      FatSyntaxParser    := self.FatSyntaxParser;
   end;
end;*)

(*procedure TNoTerminalNode.InsertSubString(s: string; p: integer);
begin
   { insert a substring into node string }

   { Faz a consist�ncia das posi��es a serem modificadas }
   CheckInsertBoundaries(p);
   { insere o novo trecho }
   Insert(s,FatSyntaxParser.FInput,FInputInitialPos+p-1);
   { ajusta as posi��es de todos os outros n�s afetados }
   ShiftSubsequentNode(p,length(s));
end;*)

(*procedure TNoTerminalNode.InsertSufixSubString(s: string);
begin
   { insert a sufix string into node string }

   { insere o novo trecho }
   Insert(s,FatSyntaxParser.FInput,FInputFinalPos+1);
   { ajusta as posi��es de todos os outros n�s afetados }
   FatSyntaxParser.ChangePositions(self,length(s),True);
end;*)

procedure TNoTerminalNode.MoveByOffset(delta:integer);
var c: integer;
begin
   for c:=0 to Nodes.Count-1 do
      Nodes[c].MoveByOffset(delta);
   FInputInitialPos:=FInputInitialPos+delta;
   FInputFinalPos:=FInputFinalPos+delta;
end;

(*procedure TNoTerminalNode.MoveToPosition(refnode:TNoTerminalNode;p:integer);
var aux     : string;
    i,delta : integer;
begin
   { move subnode to position p relative to "refnode" }

   { se o n� de refer�ncia for NIL ent�o assume que � o pr�prio n� origem }
   if not Assigned(refnode) then
      refnode:=self;
   { consist�ncia para a re-inser��o do n� }
   refnode.CheckInsertBoundaries(p);
   { encontra o �ndice destino do n� relativo ao n� de refer�ncia (refnode) }
   i:=0;
   while (i<refnode.Nodes.Count) and (refnode.FInputInitialPos+p-1>refnode[i].FInputFinalPos) do
      Inc(i);

   { calcula o deslocamento para ajustar a substring movimentada }
   delta:=ParentNode.FInputInitialPos-FInputInitialPos+p-1;

   { obt�m o trecho a ser movimentado }
   aux:=copy(FatSyntaxParser.FInput,FInputInitialPos,FInputFinalPos-FInputInitialPos+1);
   { controla a ordem de opera��es na string de acordo com o sentido da movimenta��o }
   if FInputInitialPos > refnode.FInputInitialPos+p-1 then
   begin
      { movimenta��o para tr�s }

      { extrai a substring de origem }
      Delete(FatSyntaxParser.FInput,FInputInitialPos,FInputFinalPos-FInputInitialPos+1);

      { insere esta substring de origem na posi��o de destino }
      Insert(aux,FatSyntaxParser.FInput,refnode.FInputInitialPos+p-1);

      { atualiza as posi��es para refletir a exclus�o da substring de origem }
      ParentNode.ShiftSubsequentNode(
         FInputFinalPos+1-ParentNode.FInputInitialPos+1, // posi��o relativa ao n� superior
         -(FInputFinalPos-FInputInitialPos+1)); // deslocamento para tr�s do tamanho da substring de origem

      { movimenta a inst�ncia do n� - somente manipula ponteiros }
      MoveCollectionItem(OwnerNodes,Index,refnode.Nodes,i);

      { zera a posi��o do n� para evitar interfer�ncia com o procedimento seguinte }
      FInputInitialPos:=-FInputInitialPos;

      { atualiza as posi��es para refletir a re-inser��o da substring de origem }
      refnode.ShiftSubsequentNode(
         p, // posi��o relativa ao n� de refer�ncia
         length(aux)); // deslocamento para frente do tamanho da substring de origem

      { restaura a posi��o do n� para ajustar sua posi��o no procedimento seguinte }
      FInputInitialPos:=-FInputInitialPos;

      { atualiza as posi��es do n� movimentado }
      MoveByOffset(delta);
   end
   else
   begin
      { movimenta��o para frente }

      { insere esta substring de origem na posi��o de destino }
      Insert(aux,FatSyntaxParser.FInput,refnode.FInputInitialPos+p-1);

      { extrai a substring de origem }
      Delete(FatSyntaxParser.FInput,FInputInitialPos,FInputFinalPos-FInputInitialPos+1);

      { atualiza as posi��es para refletir a re-inser��o da substring de origem }
      refnode.ShiftSubsequentNode(
         p, // posi��o relativa ao n� de refer�ncia
         length(aux)); // deslocamento para frente do tamanho da substring de origem

      { movimenta a inst�ncia do n� - somente manipula ponteiros }
      if OwnerNodes=refnode.Nodes then Dec(i);
      MoveCollectionItem(OwnerNodes,Index,refnode.Nodes,i);

      { estoura a posi��o do n� para evitar interfer�ncia com o procedimento seguinte }
      FInputInitialPos:=1000000+FInputInitialPos;

      { atualiza as posi��es para refletir a exclus�o da substring de origem }
      ParentNode.ShiftSubsequentNode(
         FInputFinalPos+1-ParentNode.FInputInitialPos+1, // posi��o relativa ao n� superior
         -(FInputFinalPos+1000000-FInputInitialPos+1)); // deslocamento para tr�s do tamanho da substring de origem

      { restaura a posi��o do n� para ajustar sua posi��o no procedimento seguinte }
      FInputInitialPos:=FInputInitialPos-1000000;

      { atualiza as posi��es do n� movimentado }
      MoveByOffset(delta);
   end;
end;*)

function TNoTerminalNode.GetFinalPos: integer;
begin
   if Assigned(OwnerNodes) then
      result:=FInputFinalPos-ParentNode.FInputInitialPos+1
   else
      result:=FInputFinalPos;
end;

function TNoTerminalNode.GetInitialPos: integer;
begin
   if Assigned(OwnerNodes) then
      result:=FInputInitialPos-ParentNode.FInputInitialPos+1
   else
      result:=FInputInitialPos;
end;

function TNoTerminalNode.GetTokenLength: integer;
begin
   result:=FInputFinalPos-FInputInitialPos+1;
end;

procedure TNoTerminalNode.SetFinalPos(const Value: integer);
begin
   if Assigned(OwnerNodes) then
      FInputFinalPos:=ParentNode.FInputInitialPos+Value-1
   else
      FInputFinalPos:=Value;
end;

procedure TNoTerminalNode.SetInitialPos(const Value: integer);
begin
   if Assigned(OwnerNodes) then
      FInputInitialPos:=ParentNode.FInputInitialPos+Value-1
   else
      FInputInitialPos:=Value;
end;

procedure TNoTerminalNode.SetTokenLength(const Value: integer);
begin
   FInputFinalPos:=FInputFinalPos+(Value-GetTokenLength);
end;

function TNoTerminalNode.GetItem(i: integer): TNoTerminalNode;
begin
   result:=FNodes[i];
end;

procedure TNoTerminalNode.SetInputFinalPos(const Value: integer);
begin
  if FatSyntaxParser.FCurrentInclude <> FInclude then
     raise Exception.Create('Invalid included input buffer. Each nodes must begin and end on the same input buffer');
  FInputFinalPos := Value;
end;

procedure TNoTerminalNode.SetInputInitialPos(const Value: integer);
begin
  FInclude := FatSyntaxParser.FCurrentInclude;
  FInputInitialPos := Value;
end;

{ TNoTerminalNodes }

constructor TNoTerminalNodes.Create(Owner:TNoTerminalNode);
begin
   inherited Create(TNoTerminalNode);
   FNode:=Owner;
end;

function TNoTerminalNodes.Add(NoTermIndex:integer):TNoTerminalNode;
begin
   result:=TNoTerminalNode( inherited Add );
   with result do
   begin
      FatSyntaxParser := Node.atSyntaxParser;
      FNoTerminalIndex := NoTermIndex;
   end;
end;

procedure TNoTerminalNodes.Delete(i:integer);
begin
   if (i>=0) and (i<Count) then
   begin
      TNoTerminalNode(Items[i]).Free;
   end;
end;

function TNoTerminalNodes.IndexOf(NoTerminalIndex:integer):integer;
begin
  for result:=0 to Count-1 do
     if TNoTerminalNode(Items[result]).FNoTerminalIndex=NoTerminalIndex then Exit;
  result:=-1;
end;

function TNoTerminalNodes.GetItem(i:integer):TNoTerminalNode;
begin
  Result := TNoTerminalNode(inherited Items[i]);
end;

function TNoTerminalNodes.FindByNoTerminalName(const AName:string):TNoTerminalNode;
var i : integer;
begin
   result:=nil;
   { localiza o �ndice do n�o-terminal }
   i:=Node.NoTerminal.NoTerminals.IndexOf(AName);
   if (i>-1) then
   begin
      { localiza o n� correspondente ao �ndice encontrado }
      i:=IndexOf(i);
      if (i>-1) then
         result:=Items[i];
   end;
end;

{ TSyntaxComments }

function TSyntaxComments.GetItem(Index: integer): TSyntaxComment;
begin
   result:=TSyntaxComment(inherited Items[index]);
end;

function TSyntaxComments.Add(AOpenString, ACloseString: string): TSyntaxComment;
begin
   result:=TSyntaxComment(inherited Add);
   result.OpenString:=AOpenString;
   result.CloseString:=ACloseString;
end;

{ TatSyntaxParser }

constructor TatSyntaxParser.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FNode:=TNoTerminalNode.Create(nil);
   FTempNodes := nil;
   FComments:=TSyntaxComments.Create(TSyntaxComment);
   FComments.Add('{','}');
   FNoTerminals:=TNoTerminals.Create;
   FGrammar:=TStringList.Create;
   TStringList(FGrammar).OnChange:=GrammarChange;
   FStrings:=TStringList.Create;
   TStringList(FStrings).OnChange:=StringsChange;
   FSavedInputs := TSavedInputs.Create(Self,TSavedInput);
   FIncludes := TIncludes.Create(Self,TInclude);
   FInput:='';
   FSyntax:='';
   FBranchCount:=0;
   FStringDelimitter:='''';
end;

destructor TatSyntaxParser.Destroy;
begin
   if Assigned(FNode) then FNode.Free;
   FSavedInputs.Free;
   FNoTerminals.Free;
   FGrammar.Free;
   FStrings.Free;
   FComments.Free;
   FIncludes.Free;
   inherited;
end;

procedure TatSyntaxParser.Clear;
begin
   if FParsing then
      raise Exception.Create('Cannot clear parser when parsing');
   if Assigned(FNode) then FNode.Free;
   FNode := TNoTerminalNode.Create(nil);
   FScanningInputPos := 0;
   FSavedInputs.Clear;
   FIncludes.Clear;
   FCurrentInclude := nil;
   FContinueOnRemarks := false;
end;

procedure TatSyntaxParser.SetGrammar(Value:TStrings);
begin
   FGrammar.Assign(Value);
end;

procedure TatSyntaxParser.GrammarChange(Sender: TObject);
begin
   NoTerminals.LoadFromStrings(FGrammar);
   if NoTerminals.Count>0 then
      FSyntax:=NoTerminals[0].Syntax
   else
      FSyntax:='';
end;

procedure TatSyntaxParser.StringsChange(Sender: TObject);
begin
   FInput:=FStrings.Text;
end;

procedure TatSyntaxParser.SetStrings(Value:TStrings);
begin
   FStrings.Assign(Value);
end;

{------------------------------------------------------------------------------}
{                                 P A R S E R                                  }
{------------------------------------------------------------------------------}
function TatSyntaxParser.ParseInput(Nodes:TNoTerminalNodes;Syntax:string;InputPosition:integer;literal:boolean;CurrentNoTerm:integer; var results:TParsingResults ):boolean;
const ValidChars     : array[ttNumeric..ttAlfabetic] of string = (
      '0123456789',
      '_ABCDEFGHIJKLMNOPQRSTUVWXYZ' );
var EndOfInput       : boolean;
    EndOfSyntax      : boolean;
    SyntaxResult     : TSyntaxResult;
    SyntaxPosition   : integer;
    SuggestedChar    : char;
    InputChar        : char;
    SyntaxToken      : string;
    SyntaxTokenType  : TTokenType;
    ObligatorySubExp : boolean;
    SubExpFound      : boolean;
    SyntaxList       : array[0..29] of string;
    c,c0             : integer;
    TotSyntax        : integer;
    PartialResults   : TParsingResults;
    Transliterate    : boolean;
    LastSyntaxPos    : integer;
    LastInputPos     : integer;
    Level            : integer;
    NewNode          : TNoTerminalNode;
    AllowSuggestion  : boolean;
    InitialNodes     : integer;
    ok               : boolean;
    noTerminal       : TNoTerminal;
    curNode          : TNoTerminalNode;
    OriginalPos      : integer;
    LineFeedFound    : boolean;

    procedure CheckRemarks; forward;

    function CheckEndOfInput: boolean;
    begin
       { testa se chegou ao final do texto de entrada }
       result := InputPosition > Length(FInput);
       { se chegou mas est� dentro de um include,
         ent�o continua processando o include anterior }
       if result and (FSavedInputs.Count>0) and (SyntaxResult in [srNotDefined,srCorrect]) then
       begin
          with FSavedInputs[FSavedInputs.Count-1] do
          begin
             { restaura o texto de entrada anterior ao include j� processado }
             FCurrentInclude := FSavedInclude;
             InputPosition := FSavedInputPosition;
             results.MaxInputPos := FSavedMaxInputPosition;
             FInput := FSavedInputBuffer;
             { elimina o item de salvamento de include, pois j� foi foi processado }
             Free;
          end;
          { ignora eventuais coment�rios que eventualmente estejam logo ap�s
            o coment�rio que ativou o include rec�m processado }
          CheckRemarks;
          { verifica novamente se chegou ao final da entrada atual }
          result := InputPosition > Length(FInput);
       end;
    end;

    procedure ExtractSubExpression( OpenChar, CloseChar:char; TokenType:TTokenType );
    var
      LenSyntaxToken: integer;
      LenSyntax: integer;
    begin
       { retorna em SyntaxToken o conte�do string de uma sub-express�o sint�tica
         proveniente da gram�tica, usando como delimitadores OpenChar e CloseChar }
       SyntaxTokenType := TokenType;

       LenSyntax := Length(Syntax);
       SetLength(SyntaxToken, LenSyntax); {Maximum size of SyntaxToken will be the size of Syntax}
       LenSyntaxToken := 0;

       Inc( SyntaxPosition );
       { extra��o de seq��ncias literiais }
       if CloseChar='"' then
       begin
          while Syntax[ SyntaxPosition ]<>'"' do
          begin
             //SyntaxToken := SyntaxToken + Syntax[ SyntaxPosition ];
             LenSyntaxToken := LenSyntaxToken + 1;
             {$WARNINGS OFF}
             SyntaxToken[LenSyntaxToken] := Syntax[SyntaxPosition];
             {$WARNINGS ON}

             if SyntaxPosition > LenSyntax then
                raise EParserError.CreateFmt(
                   'Incorrect grammar. Literal string not terminated on ''%s''',
                   [ FNoTerminals[CurrentNoTerm].IdS ]);
             Inc( SyntaxPosition );
          end;
          Inc( SyntaxPosition );
       end
       else
       { extra��o de sub-express�es n�o literais
         (agregando sub-express�es aninhadas) }
       begin
          level := 1;
          transliterate := False; // indica que est� dentro de uma sequ�ncia literal
          repeat
             { igora sequencias literiais internas a outros tokens }
             if (Syntax[ SyntaxPosition ]='"') then
                transliterate := not transliterate;
             if not transliterate then
                if Syntax[ SyntaxPosition ]=CloseChar then level := level - 1 else
                if Syntax[ SyntaxPosition ]=OpenChar then level := level + 1;
             if level>0 then
             begin
                //SyntaxToken := SyntaxToken + Syntax[ SyntaxPosition ];
               LenSyntaxToken := LenSyntaxToken + 1;
               {$WARNINGS OFF}
               SyntaxToken[LenSyntaxToken] := Syntax[SyntaxPosition];
               {$WARNINGS ON}
             end;
             if SyntaxPosition > LenSyntax then
                raise EParserError.CreateFmt(
                   'Incorrect grammar. Subexpression not terminated on ''%s''',
                   [ FNoTerminals[CurrentNoTerm].IdS ]);
             Inc( SyntaxPosition );
          until (level=0);
          if {SyntaxToken=''} LenSyntaxToken = 0 then
             raise EParserError.CreateFmt(
                'Incorrect grammar. Subexpression is empty on ''%s''',
                [ FNoTerminals[CurrentNoTerm].IdS ]);
       end;
       SetLength(SyntaxToken, LenSyntaxToken);
    end;

    procedure CheckRemarks;

       function MatchString(const S: string; AInputPos: integer): boolean;
       var i: integer;
       begin
          result := True;
          for i := 0 to Length(S) - 1 do
          begin
             if ((AInputPos + i) > Length(FInput)) or ((Upcase(FInput[AInputPos + i])) <> Upcase(S[i + 1])) then
             begin
                result := False;
                break;
             end;
          end;
       end;

    var CommentIndex : integer;
        c            : integer;
        startPos     : integer;
    begin
      repeat
         { se a posi��o corrente no texto de entrada corresponder ao in�cio de
           um coment�rio, ent�o avan�a a an�lise da entrada at� o final do
           coment�rio }
         CommentIndex := -1;
         for c:=0 to FComments.Count-1 do
            if MatchString(FComments[c].OpenString, InputPosition) and
              (
                (FComments[c].PriorDelims = '') or (InputPosition = 1) or
                ((InputPosition > 1) and (InputPosition <= Length(FInput)) and
                (Pos(FInput[InputPosition - 1], FComments[c].PriorDelims) <> 0))
              ) then
            begin
               CommentIndex := c;
               Break;
            end;
         if CommentIndex<>-1 then
         begin
            startPos := InputPosition;
            level:=1;
            Inc( InputPosition, Length(FComments[CommentIndex].OpenString) );
            repeat
               if (InputPosition>length(FInput)) then
                  Break;
               if MatchString(FComments[CommentIndex].CloseString, InputPosition) then
                  Dec( level );
               Inc( InputPosition );
            until (level=0);
            if (level=0) then
               Inc( InputPosition, Length(FComments[CommentIndex].CloseString)-1 );
            if Assigned(FOnExtractRemark) then
            begin
               { permite que um procedimento externo possa interferir no
                 processamento de coment�rios durante o parsing.
                 neste evento as seguintes altera��es de estado do parser
                 poder�o ser realizadas:
                 - altera��o da posi��o corrente da entrada
                   CurrentInputPos
                 - altera��o da m�xima posi��o alcan�ada na entrada (para controle de erros)
                   CurrentMaxInputPos
                 - altera��o do buffer entrada (includes)
                   Input
                 - altera��o do objeto de informa��es associado � entrada
                   CurrentObject
                 - ligar ou desligar an�lise da entrada em estado de verifica��o de coment�rios
                   ContinueOnRemarkss
                 }
               FProcessingRemarks := True;
               FCurrentInputPos := InputPosition;
               FCurrentMaxInputPos := results.MaxInputPos;
               FLastRemarkFound := InputPosition - 1;
               try
                  //OutputDebugString(PChar(Format('ini=%d end=%d',[startpos,inputposition-1])));
                  FOnExtractRemark( Self, startPos, InputPosition-1 );
                  { ajusta a posi��o corrente que eventualmente foi alterada }
                  InputPosition := FCurrentInputPos;
                  results.MaxInputPos := FCurrentMaxInputPos;
                  { ignora poss�veis coment�rios na posi��o atual da entrada }
                  CheckRemarks;
               finally
                  FProcessingRemarks := False;
               end;
            end;
         end
         else
            if FContinueOnRemarks then
               Inc( InputPosition );
         { permite que o evento FOnExtractRemark permane�a ignorando o texto de entrada
           como se estivesse comentado, mas continua extraingo coment�rios e os processando }
      until not FContinueOnRemarks or (InputPosition>Length(FInput));
    end;

    procedure ExtractSimpleToken( TokenType:TTokenType; ExtractInput:boolean );
    begin
       { avan�a a an�lise 1 caracter dentro da gram�tica }
       SyntaxTokenType := TokenType;
       SyntaxToken := Syntax[ SyntaxPosition ];
       Inc( SyntaxPosition );

       Case TokenType of
         ttSpaces:
           if SyntaxPosition < Length(Syntax) then
             case Syntax[SyntaxPosition] of
               '^':
                 begin
                   SyntaxTokenType := ttSameLine;
                   Inc(SyntaxPosition);
                 end;
               '\':
                 begin
                   SyntaxTokenType := ttLineFeed;
                   Inc(SyntaxPosition);
                 end;
             end;
       end;

       if ExtractInput then
       begin
          { token de entrada - extrai 1 caracter de text a partir de position }
          if CheckEndOfInput then
             EndOfInput := True
          else
          begin
             InputChar := FInput[ InputPosition ];
             Inc( InputPosition );
             { sempre ignora coment�rios no interior de qualquer token,
               exceto quando estiver dentro de uma string }
             if (TokenType<>ttString) and (TokenType<>ttCustom) then
                CheckRemarks;
          end;
       end;
    end;

    procedure PreserveInitialNodes;
    begin
       if Nodes<>nil then
          InitialNodes := Nodes.Count;
    end;

    procedure RestoreInitialNodes;
    begin
      { elimina todos os n�s gerados a partir do �ndice InitialNodes }
      if Nodes<>nil then
      begin
        if Assigned(FOnRefuseNode) then
        begin
          while Nodes.Count > InitialNodes do
          begin
            FOnRefuseNode( Nodes[Nodes.Count - 1] );
            Nodes.Delete( Nodes.Count - 1 );
          end;
        end
        else
        begin
          while Nodes.Count > InitialNodes do
            Nodes.Delete( Nodes.Count - 1 );
        end;
      end;
    end;

begin
   Inc( FBranchCount );
   noTerminal := FNoTerminals[CurrentNoTerm];
   curNode := Nodes.FNode;
   SyntaxResult := srNotDefined;
   SyntaxPosition := 1;
   SuggestedChar := #0;
   AllowSuggestion := True;
   EndOfInput := False;
   EndOfSyntax := False;
   CheckRemarks;
   while SyntaxResult = srNotDefined do
   begin
      LastSyntaxPos := SyntaxPosition;
      LastInputPos := InputPosition;
      { token da sintaxe - extrai a seq��ncia de caracteres do token atual da sintaxe }
      if SyntaxPosition > Length(Syntax) then
      begin
         EndOfSyntax := True;
         if CheckEndOfInput then
            EndOfInput := True;
      end
      else
      begin
         { se est� dentro de uma string, ent�o extrai um caracter da entrada }
         if Literal then
            ExtractSimpleToken( ttCharacter, True )
         else
            { sen�o est� em string,
              identifica qual o tipo de sequ�ncia sint�tica que vir� agora na sintaxe }
            case Syntax[ SyntaxPosition ] of
               '[' : ExtractSubExpression( '[', ']', ttOptional );
               '(' : ExtractSubExpression( '(', ')', ttReplicate );
               '{' : ExtractSubExpression( '{', '}', ttAchoice );
               '<' : ExtractSubExpression( '<', '>', ttNoTerminal );
               '"' : ExtractSubExpression( '"', '"', ttLiterate );
               '#' : ExtractSimpleToken( ttNumeric, True );
               '@' : ExtractSimpleToken( ttAlfabetic, True );
               ' ' : ExtractSimpleToken( ttSpaces, False );
               '$' : ExtractSimpleToken( ttString, True );
               '~' : ExtractSimpleToken( ttSpecial, True );
               '%' : ExtractSimpleToken( ttAnything, True );
               '&' : ExtractSimpleToken( ttCustom, True );
               else  ExtractSimpleToken( ttCharacter, True );
            end;
      end;
      { verifica se encontrou o fim da sintaxe ou fim da entrada }
      if EndOfSyntax then
         if EndOfInput then
            SyntaxResult := srCorrect
         else
            SyntaxResult := srOverFlow
      else
      { tenta extratir da entrada um sequ�ncia correspondente ao
        elemento sint�tico corrente (indicado por SyntaxTokenType)  }
      Case SyntaxTokenType of
         ttCharacter:
         begin
            { caracter terminal (n�o literal) }
            if EndOfInput then
            begin
               SyntaxResult := srIncomplete;
               if AllowSuggestion then
                  SuggestedChar := SyntaxToken[1];
               Dec( SyntaxPosition ); {corre��o}
            end
            else
               { testa o caracter sem diferenciar mai�sculas de min�sculas }
               if (Upcase(InputChar) <> UpCase(SyntaxToken[1])) then
               begin
                  SyntaxResult := srIncorrect;
                  Dec( InputPosition ); {corre��o}
                  Dec( SyntaxPosition ); {corre��o}
               end
               else
                  AllowSuggestion := True;
         end;
         ttAnything:
         begin
            { qualquer caracter }
            if EndOfInput then
            begin
               SyntaxResult := srIncomplete;
               Dec( SyntaxPosition );
            end
            else
               AllowSuggestion := False;
         end;
         ttNumeric,
         ttAlfabetic:
         begin
            { algarismo num�rico ou letra do alfabeto }
            if EndOfInput then
            begin
               SyntaxResult := srIncomplete;
               Dec( SyntaxPosition ); {corre��o}
            end
            else
            begin
               if Pos(UpCase(InputChar),ValidChars[SyntaxTokenType])=0 then
               begin
                  SyntaxResult := srIncorrect;
                  Dec( InputPosition ); {corre��o}
                  Dec( SyntaxPosition ); {corre��o}
               end
               else
                  AllowSuggestion := True;
            end;
         end;
         ttSpecial:
         begin
            { espa�o ou caracter separador de lexema }
            if EndOfInput then
            begin
               SyntaxResult := srIncomplete;
               Dec( SyntaxPosition ); {corre��o}
            end
            else
            begin
               if (InputChar>#32) then
                  { se encontrar o "(" ent�o satisfaz o ttSpecial, mas n�o avan�a
                    a entrada para que o "(" possa ser reconhecido posteriormente }
                  if (InputChar='(') or (InputChar=';') then // outros s�mbolos especiais poderiam encerrar o ttSpecial
                     Dec( InputPosition )
                  else
                  begin
                     SyntaxResult := srIncorrect;
                     Dec( InputPosition ); {corre��o}
                     Dec( SyntaxPosition ); {corre��o}
                  end
               else
                  AllowSuggestion := True;
            end;
         end;
         ttCustom:
         begin
            { caracter pertinente a um conjunto de caracteres dado pelo usu�rio }
            if EndOfInput then
            begin
               SyntaxResult := srIncomplete;
               Dec( SyntaxPosition ); {corre��o}
            end
            else
            begin
               { obt�m o �ndice correspondente ao conjunto de caracteres permitidos }
               {$IFDEF DELPHI2009_LVL}
               if (SyntaxPosition <= Length(Syntax)) and (CharInSet(Syntax[SyntaxPosition],['0'..'9'])) then
               {$ELSE}
               if (SyntaxPosition <= Length(Syntax)) and (Syntax[SyntaxPosition] in ['0'..'9']) then
               {$ENDIF}
               begin
                  c := ord(Syntax[SyntaxPosition])-48;
                  Inc(SyntaxPosition);
               end
               else
                  c := -1;

               { quando usado com indice ent�o o caracter deve estar contido no string que
                 representa os caracteres validos do lexema (string indexada por "c")
                 quando usado sem indice permite que um evento externo possa validar o caracter }
               if ( ((c>-1) and (Pos(InputChar,FCustomLexemes[c])=0))  or
                    ((c=-1) and (not Assigned(noTerminal.OnAcceptCharacter) or not noTerminal.OnAcceptCharacter(curNode,InputPosition-1)))) then
               begin
                  SyntaxResult := srIncorrect;
                  Dec( InputPosition ); {corre��o}
                  Dec( SyntaxPosition ); {corre��o}
               end
               else
                  AllowSuggestion := True;
            end;
         end;
         ttOptional:
         begin
            { sequ�ncia opcional (n�o obrigat�ria) }
            PreserveInitialNodes;
            ParseInput( Nodes, SyntaxToken, InputPosition, False, CurrentNoTerm, results );
            with results do
               if (Result = srOverFlow) or (Result = srCorrect) then
               begin
                  { aceita o n� }
                  InputPosition := InputPos;
                  AllowSuggestion := True;
                  FLastRemarkFound := 0;
               end
               else
               begin
                  { permite monitoramento de trechos parcialmente extra�dos,
                    mas recusados }
                  if FLastRemarkFound > InputPosition then
                  begin
                     if Assigned(FOnRefuseRemarks) then
                        FOnRefuseRemarks(FCurrentInclude,InputPosition);
                     FLastRemarkFound := 0;
                  end;
                  { rejeita o n� }
                  RestoreInitialNodes;
                  AllowSuggestion := False;
               end;
         end;
         ttLiterate:
         begin
            { sequ�ncia literal de caracteres }
            ParseInput( Nodes, SyntaxToken, InputPosition, True, CurrentNoTerm, results );
            with results do
               if (Result<>srOverFlow) and (Result<>srCorrect) then
               begin
                  if AllowSuggestion then
                     SuggestedChar := Suggestion;
                  SyntaxResult := Result;
                  SyntaxPosition := LastSyntaxPos + SyntaxPos; {corre��o}
                  InputPosition := LastInputPos + InputPos - InputPosition; {corre��o}
                  FLastRemarkFound := 0;
               end
               else
               begin
                  { permite monitoramento de trechos parcialmente extra�dos,
                    mas recusados }
                  if (FLastRemarkFound>InputPosition) then
                  begin
                     //OutputDebugString(PChar(Format('Recusado %d',[InputPosition])));
                     if Assigned(FOnRefuseRemarks) then
                        FOnRefuseRemarks(FCurrentInclude,InputPosition);
                     FLastRemarkFound := 0;
                  end;
                  InputPosition := InputPos;
                  AllowSuggestion := True;
               end;
         end;
         ttReplicate:
         begin
            { sequ�ncia replic�vel (presente uma ou mais vezes) }
            ObligatorySubExp := True;
            repeat
               PreserveInitialNodes;
               ParseInput( Nodes, SyntaxToken, InputPosition, False, CurrentNoTerm, results );
               with results do
               begin
                  if (Result=srOverFlow) or (Result=srCorrect) then
                  begin
                     InputPosition := InputPos;
                     SubExpFound := True;
                     FLastRemarkFound := 0;
                  end
                  else
                  begin
                     { permite monitoramento de trechos parcialmente extra�dos,
                       mas recusados }
                     if (FLastRemarkFound>InputPosition) then
                     begin
                        //OutputDebugString(PChar(Format('Recusado %d',[InputPosition])));
                        if Assigned(FOnRefuseRemarks) then
                           FOnRefuseRemarks(FCurrentInclude,InputPosition);
                        FLastRemarkFound := 0;
                     end;
                     RestoreInitialNodes;
                     SubExpFound := False;
                  end;
                  if ObligatorySubExp then
                  begin
                     if SubExpFound then
                     begin
                        ObligatorySubExp := False;
                        AllowSuggestion := False;
                     end
                     else
                     begin
                        if AllowSuggestion then
                           SuggestedChar := Suggestion;
                        SyntaxResult := Result;
                        SyntaxPosition := LastSyntaxPos + SyntaxPos; {corre��o}
                        InputPosition := LastInputPos + InputPos - InputPosition; {corre��o}
                     end;
                  end;
               end;
            until (not ObligatorySubExp and not SubExpFound) or (SyntaxResult<>srNotDefined);
         end;
         ttAchoice:
         begin
            { sequ�ncias alternativas
              (uma �nica sequencia deve ser obrigatoriamente extra�da da lista de op��es) }

            { monta a lista com as Syntaxes possiveis }
            c0 := 1;
            TotSyntax := 0;
            Transliterate := False;
            level := 0;
            for c := 1 to length(SyntaxToken) do
            begin
               if SyntaxToken[c]='"' then
                  transliterate := not transliterate;
               if not transliterate then
                  if SyntaxToken[c]='{' then Inc(level) else
                  if SyntaxToken[c]='}' then Dec(level);
               if not transliterate and (level=0) and (SyntaxToken[c]='|') then
               begin
                  SyntaxList[TotSyntax] := copy(SyntaxToken,c0,c-c0);
                  Inc(TotSyntax);
                  c0:=c+1;
               end;
            end;
            SyntaxList[TotSyntax] := copy(SyntaxToken,c0,length(SyntaxToken)-c0+1);
            Inc(TotSyntax);
            { verifica se pelo menos uma das sintaxes � v�lida }
            PreserveInitialNodes;
            PartialResults.Result := srNotDefined;
            for c:=0 to TotSyntax-1 do
            begin
               ParseInput( Nodes, SyntaxList[c], InputPosition, False, CurrentNoTerm, results );
               with results do
               begin
                  if (Result = srOverFlow) or (Result = srCorrect) then
                  begin
                     PartialResults.Result := srNotDefined;
                     InputPosition := InputPos;
                     AllowSuggestion := True;
                     FLastRemarkFound := 0;
                     Break;
                  end
                  else
                  begin
                     { permite monitoramento de trechos parcialmente extra�dos,
                       mas recusados }
                     if (FLastRemarkFound>InputPosition) then
                     begin
                        //OutputDebugString(PChar(Format('Recusado %d',[InputPosition])));
                        if Assigned(FOnRefuseRemarks) then
                           FOnRefuseRemarks(FCurrentInclude,InputPosition);
                        FLastRemarkFound := 0;
                     end;
                     RestoreInitialNodes;
                     if PartialResults.result = srNotDefined then
                        PartialResults := results
                     else
                        if (PartialResults.Result<>results.Result) or (results.Result=srIncorrect) then
                        begin
                           PartialResults.Result := srIncorrect;
                           PartialResults.Suggestion := #0;
                           PartialResults.SyntaxPos := 0; {corre��o}
                           if PartialResults.InputPos <> results.InputPos then
                              PartialResults.InputPos := InputPosition; {corre��o}
                        end
                        else
                           if PartialResults.Suggestion <> results.Suggestion then
                              PartialResults.Suggestion := #0;
                  end;
               end;
            end;
            with PartialResults do
               if result <> srNotDefined then
               begin
                  if AllowSuggestion then
                     SuggestedChar := Suggestion;
                  SyntaxResult := Result;
                  SyntaxPosition := LastSyntaxPos + SyntaxPos; {corre��o}
                  InputPosition := LastInputPos + InputPos - InputPosition; {corre��o}
               end;
         end;
         ttSpaces:
         begin
            { espa�os ou caracteres especiais opcionais (mas n�o obrigat�rio) }

            { ignora todos os espa�os em branco e coment�rios na entrada }
            AllowSuggestion := False;
            repeat
               if CheckEndOfInput then
               begin
                  EndOfInput := True;
                  SubExpFound := False;
               end
               else
               begin
                  if FInput[InputPosition] < #33 then // aceita espa�os e caracteres especiais
                  begin
                     InputChar := FInput[InputPosition];
                     SubExpFound := True;
                     Inc( InputPosition );
                     CheckRemarks;
                  end
                  else
                     SubExpFound := False;
               end;
            until not SubExpFound;
         end;
         ttSameLine:
         begin
           OriginalPos := InputPosition - 1;

           {one or more spaces without having #13 or #10 characters}
           if EndOfInput then
           begin
             SyntaxResult := srIncomplete;
             Dec( SyntaxPosition );
           end
           else
           if (FInput[InputPosition] > #32) or (FInput[InputPosition] = #13) or (FInput[InputPosition] = #10) then
           begin
             SyntaxResult := srIncorrect;
             Dec( SyntaxPosition );
           end
           else
           begin
             Inc(InputPosition);
             repeat
                if CheckEndOfInput then
                begin
                   EndOfInput := True;
                   SubExpFound := False;
                end
                else
                begin
                  if (FInput[InputPosition] < #33) then // aceita espa�os e caracteres especiais
                  begin
                    if (FInput[InputPosition] = #13) or (FInput[InputPosition] = #10) then
                    begin
                      SyntaxResult := srIncorrect;
                      Dec( SyntaxPosition );
                      SubExpFound := False;
                    end else
                    begin
                      InputChar := FInput[InputPosition];
                      SubExpFound := True;
                      Inc( InputPosition );
                      CheckRemarks;
                    end;
                  end
                  else
                     SubExpFound := False;
                end;
             until not SubExpFound;
           end;

           if SyntaxResult = srIncorrect then
             InputPosition := OriginalPos;
         end;
         ttLineFeed:
         begin
           {Accepts 0 or more spaces and *must have* line feed} 
           OriginalPos := InputPosition - 1;

           {one or more spaces without having #13 or #10 characters}
           if EndOfInput then
           begin
             SyntaxResult := srIncomplete;
             Dec( SyntaxPosition );
           end
           else
           if (FInput[InputPosition] > #32) then
           begin
             SyntaxResult := srIncorrect;
             Dec( SyntaxPosition );
           end
           else
           begin
             LineFeedFound := (FInput[InputPosition] = #13) or (FInput[InputPosition] = #10);

             Inc(InputPosition);
             repeat
                if CheckEndOfInput then
                begin
                   EndOfInput := True;
                   SubExpFound := False;
                end
                else
                begin
                  if (FInput[InputPosition] < #33) then // aceita espa�os e caracteres especiais
                  begin
                    if (FInput[InputPosition] = #13) or (FInput[InputPosition] = #10) then
                      LineFeedFound := true;
                    InputChar := FInput[InputPosition];
                    SubExpFound := True;
                    Inc( InputPosition );
                    CheckRemarks;
                  end
                  else
                     SubExpFound := False;
                end;
             until not SubExpFound;

             if not LineFeedFound then
             begin
               SyntaxResult := srIncorrect;
               Dec( SyntaxPosition );
             end;
           end;

           if SyntaxResult = srIncorrect then
             InputPosition := OriginalPos;
         end;
         ttString:
         begin
            { estrai uma string inteira do texto de entrada }
            if EndOfInput then
            begin
               SyntaxResult := srIncomplete;
               SuggestedChar := #0;
               Dec( SyntaxPosition ); {corre��o}
            end
            else
            begin
               if InputChar <> StringDelimitter then
               begin
                  SyntaxResult := srIncorrect;
                  Dec( InputPosition ); {corre��o}
                  Dec( SyntaxPosition ); {corre��o}
               end
               else
               begin
                  { extra��o da string }
                  repeat
                     if CheckEndOfInput then
                     begin
                        EndOfInput := True;
                        SyntaxResult := srIncomplete;
                        SuggestedChar := #0;
                        Dec( SyntaxPosition ); {corre��o}
                        Break;
                     end
                     else
                     begin
                        InputChar := FInput[InputPosition];
                        Inc( InputPosition );
                        if FInput[InputPosition-1] = StringDelimitter then
                           if (InputPosition <= Length(FInput)) and
                              (FInput[InputPosition] = StringDelimitter) then
                              Inc(InputPosition)
                           else
                              Break;
                     end;
                  until False; { sa�da com break }
               end;
            end;
         end;
         ttNoTerminal:
         begin
            { extrai uma sequ�ncia sint�tica inteira }

            { montagem da �rvore sint�tica }
            PreserveInitialNodes;
            c := StrToInt(SyntaxToken);
            NewNode := Nodes.Add( c );
            NewNode.InputInitialPos := InputPosition;
            if Assigned(FOnNewNode) then
              FOnNewNode(NewNode);
            ParseInput( NewNode.Nodes, NoTerminals[c].Syntax, InputPosition, False, c, results );
            with results do
            begin
               NewNode.InputFinalPos := InputPos - 1;
               ok:=(Result=srOverFlow) or (Result=srCorrect);
               { se o n�o terminal possuir um evento para valida��o ent�o o executa agora }
               if ok and Assigned(FNoTerminals[c].FOnAcceptNode) and not FNoTerminals[c].FOnAcceptNode(NewNode) then
               begin
                  { provoca um erro de sintaxe porque o n�o terminal foi rejeitado pelo evento de aceita��o }
                  Result:=srIncorrect;
                  ok:=false;
               end;
               if ok then
               begin
                  { atualiza o node da �rvore sint�tica }
                  InputPosition:=InputPos;
                  AllowSuggestion:=true;
                  FLastRemarkFound := 0;
                  {$IFDEF SCRIPTDEBUG}
                  ShowMessage( Format('%s: %s',[FNoTerminals[c].FIdS,NewNode.InputToken]) );
                  {$ENDIF}
               end
               else
               begin
                  { permite monitoramento de trechos parcialmente extra�dos,
                    mas recusados }
                  if (FLastRemarkFound>InputPosition) then
                  begin
                     //OutputDebugString(PChar(Format('Recusado %d',[InputPosition])));
                     if Assigned(FOnRefuseRemarks) then
                        FOnRefuseRemarks(FCurrentInclude,InputPosition);
                     FLastRemarkFound := 0;
                  end;
                  RestoreInitialNodes;
                  if AllowSuggestion then SuggestedChar:=Suggestion;
                  SyntaxResult:=Result;
                  SyntaxPosition:=LastSyntaxPos; {corre��o}
                  InputPosition:=LastInputPos+InputPos-InputPosition; {corre��o}
                  CurrentNoTerm:=c;
               end;
            end;
 (*


               if (Result=srOverFlow) or (Result=srCorrect) then
                  { se o n�o terminal possuir um evento para valida��o ent�o o executa }
                  if Assigned(FNoTerminals[c].FOnAcceptNode) and
                     not FNoTerminals[c].FOnAcceptNode(NewNode) then
                     { provoca um erro de sintaxe porque o n�o terminal
                       foi rejeitado pelo evento de aceita��o }
                     Result := srIncorrect
                  else
                  begin
                     { atualiza o node da �rvore sint�tica }
                     InputPosition := InputPos;
                     AllowSuggestion := True;
                     {$IFDEF SCRIPTDEBUG}
                     ShowMessage( Format('Accepted node ''%s'' with ''%s''',[ FNoTerminals[c].FIdS, NewNode.InputToken]) );
                     {$ENDIF}
                  end
               else
               begin
                  RestoreInitialNodes;
                  if AllowSuggestion then
                     SuggestedChar:=Suggestion;
                  SyntaxResult := Result;
                  SyntaxPosition := LastSyntaxPos; {corre��o}
                  InputPosition := LastInputPos + InputPos - InputPosition; {corre��o}
                  CurrentNoTerm := c;
               end;
            end;
            *)
         end;
      end;
   end;
   { retorna os resultados da an�lise }
   with results do
   begin
      Result := SyntaxResult;
      InputPos := InputPosition;
      SyntaxPos := SyntaxPosition;
      Suggestion := SuggestedChar;
   end;
   result := (SyntaxResult = srCorrect);

   { resultados detalhados do erro para a checagem de linguagens }
   if not result and (InputPosition > results.MaxInputPos) then
      with results do
      begin
         NoTerminalIndex := CurrentNoTerm;
         MaxInputPos := InputPosition;
         LastResult := SyntaxResult;
      end;
end;

function TatSyntaxParser.CheckExpression: TParsingResults;
begin
   FBranchCount := 0;
   result.MaxInputPos := 0;
   FParsing := True;
   try
      ParseInput(nil,Syntax,1,False,-1,result);
   finally
      FParsing := False;
   end;
end;

function TatSyntaxParser.CheckLanguage: TParsingResults;
begin
   FBranchCount := 0;
   result.MaxInputPos := 0;
   Clear;
   FNode.FatSyntaxParser := Self;
   FNode.FNoTerminalIndex := 0;
   FNode.InputInitialPos := 1;
   FParsing := True;
   try
      ParseInput(FNode.Nodes,FSyntax,1,False,0,result);
   finally
      FParsing := False;
      FNode.InputFinalPos := result.InputPos - 1;
   end;
end;

procedure TatSyntaxParser.BuildSyntaxTreeView(TreeView:TTreeView);

   procedure ShowNodes( ViewNode:TTreeNode; SyntaxNodes:TNoTerminalNodes );
   var c   : integer;
       aux : string;
   begin
      for c:=0 to SyntaxNodes.Count-1 do
         with SyntaxNodes[c] do
         begin
            if Nodes.Count=0 then
               aux:=': '+InputToken
            else
               aux:='';
            ShowNodes( TreeView.Items.AddChild( ViewNode, NoTerminals[NoTerminalIndex].IdS+aux ),
                       SyntaxNodes[c].Nodes );
         end;
   end;

begin
   with TreeView do
   begin
      Items.Clear;
      Items.BeginUpDate;
      if Node.Nodes.Count>0 then
         ShowNodes( Items.AddChild(nil,NoTerminals[Node.NoTerminalIndex].IdS),
                    Node.Nodes );
      FullExpand;
      Items.EndUpDate;
   end;
end;

procedure TatSyntaxParser.ScanNode( ANode:TNoTerminalNode );
var c : integer;
begin
   with ANode, NoTerminal do
   begin
      FDisableBranching:=False; // o DisableBranching somente ter� efeito se ativo dentro do BeforeNodeScan
      { check if there is an event on before node scanning }
      if Assigned(FOnBeforeNodeScan) then
      begin
         FScanningInputPos:=ANode.FInputInitialPos;
         FOnBeforeNodeScan(ANode);
      end;
      if not FDisableBranching then
         { recursively scanning }
         if NoTerminal.ReverseScanning then
            for c:=FNodes.Count-1 downto 0 do ScanNode( FNodes[c] )
         else
            for c:=0 to FNodes.Count-1 do ScanNode( FNodes[c] );
      { check if there is an event on before node scanning }
      if Assigned(FOnAfterNodeScan) then
      begin
         FScanningInputPos:=ANode.FInputFinalPos;
         FOnAfterNodeScan(ANode);
      end;
   end;
end;

function TatSyntaxParser.ScanSyntaxTree:boolean;
begin
   ScanNode( FNode );
   result:=True;
end;
(*
function TatSyntaxParser.RebuildFromNodes:string;

   procedure Change( ANode:TNoTerminalNode );
   var c : integer;
   begin
      with ANode, NoTerminal do
      begin
         for c:=FNodes.Count-1 downto 0 do
            Change( FNodes[c] );
         if Assigned(FOnNodeStringChange) then
         begin
            { remove original fragment }
            Delete(result,InputInitialPos,InputFinalPos-InputInitialPos+1);
            { insert new fragment }
            Insert(FOnNodeStringChange(ANode),result,InputInitialPos);
         end;
      end;
   end;

begin
   { rebuild the source from sytax nodes }
   { use this function to perform lexical or syntatical convertions }
   { caution, this function could perform massive string manipulation }

   { begin with a copy of the original input string }
   result:=FStrings.Text;
   { recursivelly, change the subnode string }
   Change( FNode );
end;
*)

procedure TatSyntaxParser.ChangePositions(refnode:TNoTerminalNode;delta:integer;ignoresubnodes:boolean);

  procedure OptimizedChangeNodesPos;
  var
    c: integer;
    _node: TNoTerminalNode;
  begin
    c := FTempNodes.Count - 1;
    while (c >= 0) do
    begin
      _node := TNoTerminalNode(FTempNodes[c]);
      //if _node.FInputFinalPos < refnode.FInputInitialPos then
        //break;

      //if not _node.FToBeDeleted then
      if refnode <> _node then
      begin
        if _node.FInputInitialPos >= refnode.FInputFinalPos then
        begin
          _node.FInputInitialPos := _node.FInputInitialPos + delta;
          _node.FInputFinalPos := _node.FInputFinalPos + delta;
        end else
        if _node.FInputFinalPos >= refnode.FInputFinalPos then
          _node.FInputFinalPos := _node.FInputFinalPos + delta;
      end;

      dec(c);
    end;
  end;

  procedure ChangeNodesPos(ANodes: TNoTerminalNodes);
  var
    _node: TNoTerminalNode;
    c: integer;
  begin
    for c := 0 to ANodes.Count - 1 do
    begin
      _node := ANodes[c];
      if _node.Nodes.Count > 0 then
        ChangeNodesPos(_node.Nodes);

      if refnode <> _node then
      begin
        if _node.FInputInitialPos >= refnode.FInputFinalPos then
        begin
          _node.FInputInitialPos := _node.FInputInitialPos + delta;
          _node.FInputFinalPos := _node.FInputFinalPos + delta;
        end else
        if _node.FInputFinalPos >= refnode.FInputFinalPos then
          _node.FInputFinalPos := _node.FInputFinalPos + delta;
      end;


        (*if (_node.FInputInitialPos <= refnode.FInputInitialPos) and
          (_node.FInputFinalPos >= refnode.FInputFinalPos) then
          _node.FInputFinalPos := _node.FInputFinalPos + delta
        else
        if (_node.FInputInitialPos >= refnode.FInputFinalPos) and
          (_node.FInputFinalPos >= refnode.FInputFinalPos) then
        begin
          _node.FInputInitialPos := _node.FInputInitialPos + delta;
          _node.FInputFinalPos := _node.FInputFinalPos + delta;
        end else
        if (_node.FInputInitialPos < refnode.FInputInitialPos) and
          (_node.FInputFinalPos <= refnode.FInputInitialPos) then
        else
        if (_node.FInputInitialPos > _node.FInputFinalPos) then
        else
          raise Exception.Create(Format('Erro!'#13#10'refnode = %s; input = %d; final = %d'#13#10+
            'text = %s'#13#10+
            '_node = %s; input = %d; final = %d'#13#10+
            'text = %s',
            [refnode.NoTerminal.Ids, refnode.InputInitialPos, refnode.FInputFinalPos,
             refnode.InputToken,
             _node.NoTerminal.Ids, _node.FInputInitialPos, _node.FInputFinalPos,
             _node.InputToken]));
      end;*)
    end;
  end;

   (*function GetNextNode(node:TNoTerminalNode):TNoTerminalNode;
   var upnode : TNoTerminalNode;
   begin
      if node.Nodes.Count>0 then
         { retorna o primeiro filho do n� de refer�ncia }
         result:=node.Nodes[0]
      else
      begin
         { tenta encontrar algum n� posterior atrav�s da ascend�ncia }
         upnode:=node.ParentNode;
         while Assigned(upnode) and (node.Index=upnode.Nodes.Count-1) do
         begin
            node:=upnode;
            upnode:=node.ParentNode;
         end;
         if Assigned(upnode) then
            { retorna algum irm�o ou tio do n� refer�ncia que seja posterior a ele }
            result:=upnode.Nodes[node.Index+1]
         else
            { n�o h� mais n�s posteriores }
            result:=nil;
      end;
   end;*)

begin
   { ajusta o tamanho de todos os n�s superiores ao n� de refer�ncia }
   (*node:=refnode.ParentNode;
   while Assigned(node) do
   begin
      node.FInputFinalPos:=node.FInputFinalPos+delta;
      node:=node.ParentNode;
   end;
   { ajusta o deslocamento de todos os n�s posteriores ao n� de refer�ncia }
   node:=refnode;
   if ignoresubnodes then
      { retorna o sub-n� mais profundo deste n� }
      while node.Nodes.Count>0 do
         node:=node.Nodes[node.Nodes.Count-1];
   node:=GetNextNode(node);
   while Assigned(node) do
   begin
      node.FInputInitialPos:=node.FInputInitialPos+delta;
      node.FInputFinalPos:=node.FInputFinalPos+delta;
      node:=GetNextNode(node);
   end;*)

   if Assigned(FTempNodes) then
     OptimizedChangeNodesPos
   else
     ChangeNodesPos(FNode.Nodes);
end;

{$WARNINGS OFF}
function NodeCompare(Item1, Item2: Pointer): Integer;
var
  Node1, Node2: TNoTerminalNode;
begin
  Node1 := TNoTerminalNode(Item1);
  Node2 := TNoTerminalNode(Item2);
  {positive result means node1 is less than node2}
  result := Node2.FInputFinalPos - Node1.FInputFinalPos;
end;
{$WARNINGS ON}

function TatSyntaxParser.RebuildFromNodes:string;

   procedure Change( ANode:TNoTerminalNode );
   var c : integer;
   begin
     with ANode, NoTerminal do
     begin
        for c:=0 to FNodes.Count-1 do
           Change( FNodes[c] );
        if Assigned(FOnNodeStringChange) then
           ANode.ChangeNodeString( FOnNodeStringChange(ANode) );
     end;
   end;

   procedure AddTempNodes(ANodes: TNoTerminalNodes);
   var
     c: integer;
   begin
     for c := 0 to ANodes.Count - 1 do
     begin
       FTempNodes.Add(ANodes[c]);
       if ANodes[c].Nodes.Count > 0 then
         AddTempNodes(ANodes[c].Nodes);
     end;
   end;

begin
   FTempNodes := TObjectList.Create(false);
   try
     FTempNodes.Add(FNode);
     AddTempNodes(FNode.Nodes);
     FTempNodes.Sort(NodeCompare);

     { rebuild the source from sytax nodes }
     { use this function to perform lexical or syntatical convertions }
     { recursivelly, change the subnode string }
     Change( FNode );
     result:=FInput;
   finally
     FTempNodes.Free;
     FTempNodes := nil;
   end;
end;

function TatSyntaxParser.FindNodeByPosition(p: integer): TNoTerminalNode;

   function Branch(node:TNoTerminalNode):TNoTerminalNode;
   var c: integer;
   begin
      { varre os nodes (recursivamente) para descobrir qual o n� que cont�m a
        posi��o procurada - retorna o n� mais profundo }
      with node do
         for c:=0 to Nodes.Count-1 do
         begin
            if (p>=Nodes[c].FInputInitialPos) and
               (p<=Nodes[c].FInputFinalPos) then
            begin
               result:=Branch(Nodes[c]);
               Exit;
            end;
         end;
      { se n�o encontrou um n� mais profundo ent�o retorna este mesmo }
      result:=node;
   end;

begin
   if (p>=node.FInputInitialPos) and (p<=node.FInputFinalPos) then
      result:=Branch(Node)  
   else
      raise Exception.Create('Tentativa de acessar uma posi��o inexistente no fonte');
end;

procedure TatSyntaxParser.SetDisableBranching(const Value: boolean);
begin
  FDisableBranching := Value;
end;

procedure TatSyntaxParser.IncludeInput( AName: string );
var obj : TObject;
begin
  if not FProcessingRemarks then
     raise Exception.Create('SetContinueOnRemarks should only be called when processing input remarks');

  { muda o texto de entrada associado � an�lise corrente }
  { preserva as vari�veis de estado associadas ao buffer de entrada corrente }
  with FSavedInputs.Add do
  begin
     FSavedInclude := FCurrentInclude;
     FSavedInputPosition := FCurrentInputPos;
     FSavedMaxInputPosition := FCurrentMaxInputPos;
     FSavedInputBuffer := FInput;
  end;

  { faz a an�lise come�ar do in�cio do texto de entrada }
  FCurrentInputPos := 1;
  FCurrentMaxInputPos := 0;

  { procura o include na lista de includes }
  FCurrentInclude := FIncludes.FindByName( AName );

  if not Assigned(FCurrentInclude) then
  begin
     { n�o havia incluido ainda}

     { chama o evento do usu�rio para permitir que o buffer de entrada e
       o objeto corrente sejam ajustados para o novo include }
     if Assigned(OnIncludeInput) then
        OnIncludeInput(Self,AName,FInput,obj);

     { registra o include numa lista interna (para uso pelos nodes da �rvore sint�tica) }
     FCurrentInclude := FIncludes.Add;
     with FCurrentInclude do
     begin
        FName := AName;
        FInfoObject := obj;
        FInputBuffer := FInput;
     end;
  end
  else
     FInput := FCurrentInclude.FInputBuffer;
end;

procedure TatSyntaxParser.SetContinueOnRemarks(const Value: boolean);
begin
  if not FProcessingRemarks then
     raise Exception.Create('SetContinueOnRemarks should only be called when processing input remarks');
  FContinueOnRemarks := Value;
end;

procedure TatSyntaxParser.SetCurrentInputPos(const Value: integer);
begin
  if not FProcessingRemarks then
     raise Exception.Create('SetCurrentInputPos should only be called when processing input remarks');
  FCurrentInputPos := Value;
end;

procedure TatSyntaxParser.SetCurrentMaxInputPos(const Value: integer);
begin
  if not FProcessingRemarks then
     raise Exception.Create('SetCurrentMaxInputPos should only be called when processing input remarks');
  FCurrentMaxInputPos := Value;
end;

procedure TatSyntaxParser.SetInput(const Value: string);
begin
  if not FProcessingRemarks then
     raise Exception.Create('SetCurrentMaxInputPos should only be called when processing input remarks');
  FInput := Value;
end;

function TatSyntaxParser.GetCustomLexeme(i: integer): string;
begin
   result := FCustomLexemes[i];
end;

procedure TatSyntaxParser.SetCustomLexeme(i: integer;
  const Value: string);
begin
   FCustomLexemes[i] := Value;
end;

function TatSyntaxParser.TestInputString(APos: integer; s: string;ACaseSensitive: boolean): boolean;
var c: integer;
begin
   result := True;
   for c:=1 to length(s) do
   begin
      if (APos>Length(Input)) or
         (ACaseSensitive and (s[c]<>Input[APos])) or
         (not ACaseSensitive and (AnsiCompareText(s[c],FInput[APos])<>0)) then
      begin
         result := False;
         Exit;
      end;
      Inc(APos);
   end;
end;

procedure TatSyntaxParser.SetOnNewNode(const Value: TNodeNotifyEvent);
begin
  FOnNewNode := Value;
end;

{ TSavedInputs }

function TSavedInputs.Add: TSavedInput;
begin
   result := TSavedInput( inherited Add );
end;

function TSavedInputs.GetItems(i: integer): TSavedInput;
begin
   result := TSavedInput( inherited Items[i] );
end;

{ TIncludes }

function TIncludes.Add: TInclude;
begin
   result := TInclude( inherited Add );
end;

function TIncludes.FindByName(AName: string): TInclude;
var c: integer;
begin
   for c := 0 to Count-1 do
      if SameText(AName,Items[c].FName) then
      begin
         result := Items[c];
         Exit;
      end;
   result := nil;
end;

function TIncludes.GetItems(i: integer): TInclude;
begin
   result := TInclude( inherited Items[i] );
end;

function TIncludes.IndexOf(AName: string): integer;
begin
   for result := 0 to Count-1 do
      if SameText(AName,Items[result].FName) then
         Exit;
   result := -1;
end;

end.
