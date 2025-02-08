unit LMDEntryPoint;
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

LMDEntryPoint unit (VO)
-----------------------

Used for store description of HTML elements 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDListObjects, LMDExtParser, LMDText, LMDRule, LMDDeductionTree;

type

  { ******************************* TLMDEntryPoint *************************** }
  TLMDEntryPoint = class
  private
    FName    : string;
    FParser  : TLMDExtParser;
    FLockRef : LongInt;
    FTable   : TLMDListObjects;//TList;
    FAction  : TLMDParseAction;
    FExceptionHandler : TLMDParseAction;
    function GetLocked : boolean;
    function ValidTag : boolean;
  protected
    procedure Lock;
    procedure UnLock;
    procedure DoAction(aTree : TLMDDeductionTree; aStage : TLMDEntryStage);
    procedure Exception(aTree : TLMDDeductionTree; aStage : TLMDEntryStage);
    procedure PrevToken(aNode : TLMDDeductionTree);
    procedure NextToken(aNode : TLMDDeductionTree);
    property  Locked : boolean read GetLocked;
  public
    constructor Create(const aName : string; aParser : TLMDExtParser; aTable : TLMDListObjects;//TList;
      aAction : TLMDParseAction; aExceptionHandler : TLMDParseAction);
    function IsTrue(aTree : TLMDDeductionTree) : boolean ; virtual; abstract;
    procedure RollBack(aTree : TLMDDeductionTree); virtual; abstract;
    procedure GetFirstToken(aNode : TLMDDeductionTree);
    property Name : string read FName;
  end;

  { ******************************* TLMDTypeEntry **************************** }
  TLMDTypeEntry = class (TLMDEntryPoint)
  private
    FTypeFunc : TLMDParseFunc;
  public
    constructor Create(const aName : string; aTypeFunc : TLMDParseFunc;
                       aAction : TLMDParseAction; aParser : TLMDExtParser;
                       aTable : TLMDListObjects{TList});
    function IsTrue(aTree : TLMDDeductionTree) : boolean ; override;
    procedure RollBack(aTree : TLMDDeductionTree); override;
  end;

  { ******************************* TLMDEntityEntry ************************** }
  TLMDEntityEntry = class (TLMDEntryPoint)
  private
    FRule   : TLMDRule;
    FOwnedRule: Boolean;
  public
    constructor Create(const aName : string; aParser : TLMDExtParser; aTable : TLMDListObjects{TList});
    destructor Destroy; override;
    function IsTrue(aTree : TLMDDeductionTree) : boolean ; override;
    procedure RollBack(aTree : TLMDDeductionTree); override;
    procedure SetRule(Rule: TLMDRule; Owned: Boolean);
    property Rule : TLMDRule read FRule;// write FRule;
  end;

  { ******************************* TLMDElementEntry ************************* }
  TLMDElementEntry = class (TLMDEntryPoint)
  private
    FRule   : TLMDRule;
    FOwnedRule : Boolean;
    FTagOpen   : boolean;
    FTagClose  : boolean;
    FCloseTags : TStringList;
    FExclusion : TList;
    function IsCloseTag : boolean;
    function  CheckDataModel(aTree : TLMDDeductionTree) : boolean;
    procedure LockExclusion;
    procedure UnLockExclusion;
  public
    constructor Create(const aName : string; aTagOpen, aTagClose : boolean; aCloseTags : TStringList;
      aAction : TLMDParseAction; aParser : TLMDExtParser;
      aExceptionHandler : TLMDParseAction; aTable : TLMDListObjects{TList});
    destructor Destroy; override;
    function IsTrue(aTree : TLMDDeductionTree) : boolean ; override;
    procedure RollBack(aTree : TLMDDeductionTree); override;
    procedure SetRule(Rule: TLMDRule; Owned: Boolean);
    property Exclusion : TList read FExclusion write FExclusion;
    property Rule : TLMDRule read FRule;// write FRule;
  end;

implementation
uses
  Sysutils, LMDLex;
{
var
  LLLL: integer = 0;
function i_S(var L: integer): string;
begin inc(LLLL); L := LLLL; Result := sBlank(L); end;
}
{ ********************************* TLMDEntryPoint *************************** }
{------------------------------------------------------------------------------}

function TLMDEntryPoint.GetLocked : boolean;
begin Result := (FLockRef <> 0) end;

{------------------------------------------------------------------------------}

function TLMDEntryPoint.ValidTag : boolean;
var
  I : LongInt;
  E : TLMDEntryPoint; 
//  F : boolean;
begin
  Result := True;
  if not Assigned(FTable) then Exit;
  Result := False;
  for I := 0 to FTable.count-1 do
  begin
    E := TLMDEntryPoint(FTable[I]);
    if Assigned(E) then
      if ((not E.Locked) and
          (FParser.Tag(E.Name) or FParser.Tag('/' + E.Name)))
      then
      begin
        Result := True;
        Exit;
      end;
  end;
end;

{ ********************************* PROTECTED ******************************** }

procedure TLMDEntryPoint.Lock;
begin inc(FLockRef) end;

{------------------------------------------------------------------------------}

procedure TLMDEntryPoint.UnLock;
begin if FLockRef > 0 then Dec(FLockRef) end;

{------------------------------------------------------------------------------}

procedure TLMDEntryPoint.DoAction(aTree : TLMDDeductionTree; aStage : TLMDEntryStage);
var
  aParsedText : TLMDParsedTextList;
begin
  if Assigned(FAction) then begin
    aParsedText := aTree.ParsedText;
    FAction(aParsedText, aStage);
    aTree.ParsedText := aParsedText;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEntryPoint.Exception(aTree : TLMDDeductionTree; aStage : TLMDEntryStage);
var
  aParsedText : TLMDParsedTextList;
begin
  if Assigned(FExceptionHandler) then begin
    aParsedText := aTree.ParsedText;
    FExceptionHandler(aParsedText, aStage);
    aTree.ParsedText := aParsedText;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEntryPoint.PrevToken(aNode : TLMDDeductionTree);
begin
 FParser.PrevToken;
 while FParser.ValidToken and
       (FParser.Token.TokenType = ttTag) and
       (not ValidTag) do
 begin
   Exception(aNode, esData);
   FParser.PrevToken;
 end;
end;

{------------------------------------------------------------------------------}

procedure TLMDEntryPoint.NextToken(aNode : TLMDDeductionTree);
begin
 FParser.NextToken;
 while FParser.ValidToken and
       (FParser.Token.TokenType = ttTag) and
       (not ValidTag) do
 begin
   Exception(aNode, esData);
   FParser.NextToken;
 end;
end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDEntryPoint.Create(const aName : string; aParser : TLMDExtParser; aTable : TLMDListObjects{TList};
      aAction : TLMDParseAction; aExceptionHandler : TLMDParseAction);
begin
  inherited Create;
  FName := aName;
  FParser := aParser;
  FTable := aTable;
  FAction := aAction;
  FExceptionHandler := aExceptionHandler;
  FLockRef := 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDEntryPoint.GetFirstToken(aNode : TLMDDeductionTree);
begin NextToken(aNode) end;

{ ********************************* TLMDTypeEntry **************************** }
{------------------------------------------------------------------------------}

constructor TLMDTypeEntry.Create(const aName : string; aTypeFunc : TLMDParseFunc;
  aAction : TLMDParseAction; aParser : TLMDExtParser; aTable : TLMDListObjects{TList});
begin
  inherited Create(aName, aParser, aTable, aAction, nil);
  FTypeFunc := aTypeFunc;
end;

{------------------------------------------------------------------------------}

function TLMDTypeEntry.IsTrue(aTree : TLMDDeductionTree) : boolean ;
begin
  Result := False;
  if not FParser.ValidToken then Exit;
  if not Assigned(FTypeFunc) then Exit;

  while FParser.ValidToken and FTypeFunc do
  begin
    DoAction(aTree, esData);
    NextToken(aTree);
    Result := True;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDTypeEntry.RollBack(aTree : TLMDDeductionTree);
begin
  DoAction(aTree, esRollBack);
  FParser.Position := aTree.StartPos;
end;

{ ********************************* TLMDEntityEntry ************************** }
{------------------------------------------------------------------------------}

constructor TLMDEntityEntry.Create(const aName : string; aParser : TLMDExtParser; aTable : TLMDListObjects{TList});
begin
  inherited Create(aName, aParser, aTable, nil, nil);
  FName := aName;
  FRule := nil;
  FOwnedRule := False;
  FParser := aParser;
end;

{------------------------------------------------------------------------------}

destructor TLMDEntityEntry.Destroy;
begin
  SetRule(nil, False);
//  if Assigned(FRule) then FRule.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDEntityEntry.IsTrue(aTree : TLMDDeductionTree) : boolean;
begin
  Result := True;
  if Assigned(FRule) then Result := FRule.Check(aTree.AddSubItem);
end;

{------------------------------------------------------------------------------}

procedure TLMDEntityEntry.RollBack(aTree : TLMDDeductionTree);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDEntityEntry.SetRule(Rule: TLMDRule; Owned: Boolean);
begin
  if Assigned(FRule) and FOwnedRule then
    FRule.Free;

  FRule := Rule;
  FOwnedRule := Owned;
end;

{ ********************************* TLMDElementEntry ************************* }
{------------------------------------------------------------------------------}

function TLMDElementEntry.IsCloseTag : boolean;
var
  I : LongInt;
  C: TLMDToken;
begin
  Result := True;
  C := FParser.Token;
  if (C = nil) then Exit;
//  if (FParser.Token <> nil) and (FParser.Token.TokenType = ttEOF) then Exit;
  if (C.TokenType = ttEOF) then Exit;
  if Not FParser.ValidToken then Exit;
  if FParser.Tag('/'+FName) then Exit;
  if Assigned(FCloseTags) then
    for I := 0 to FCloseTags.count-1 do begin
      if (FCloseTags[I] = '') and FParser.TokenIsText then Exit;
      if FParser.Tag(FCloseTags[I]) then Exit;
    end;
  Result := False;
end;

{------------------------------------------------------------------------------}

function  TLMDElementEntry.CheckDataModel(aTree : TLMDDeductionTree) : boolean;
var
  aNode : TLMDDeductionTree;
  Tmp   : boolean;
  P     : integer;
begin
  {$IFNDEF LMDCOMP24}Tmp := False;{$ENDIF} // Initialize.

  P := -1;
  Result := False;
  repeat
    aNode := aTree.AddSubItem;
    aNode.StartPos := FParser.Position;
    DoAction(aNode, esData);
    if not Assigned(FRule) then begin
      Result := True;
//      while not IsCloseTag do
//        FParser.NextToken;
      Exit;
    end
    else   Tmp := FRule.Check(aNode);
    Result := Result or Tmp;
    if IsCloseTag then Exit;
    if (not Tmp) or (aNode.StartPos = FParser.Position) then
    begin
      Exception(aNode, esData);
//      aNode.Chop;
      DoAction(aNode, esDataCancel);
      aNode.Chop;
      if IsCloseTag then Exit;

      if  P = FParser.Position  then
        Exit;

      P := FParser.Position;
    end
    else
      P := -1;
  until IsCloseTag;
end;

{------------------------------------------------------------------------------}

procedure TLMDElementEntry.LockExclusion;
var
  I : LongInt;
begin
  if not Assigned(FExclusion) then Exit;
  for I := 0 to FExclusion.count-1 do
    if Assigned(FExclusion[I]) then
      TLMDEntryPoint(FExclusion[I]).Lock;
end;

{------------------------------------------------------------------------------}

procedure TLMDElementEntry.UnLockExclusion;
var
  I : LongInt;
begin
  if not Assigned(FExclusion) then Exit;
  for I := 0 to FExclusion.count-1 do
    if Assigned(FExclusion[I]) then
      TLMDEntryPoint(FExclusion[I]).UnLock;
end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDElementEntry.Create(const aName : string; aTagOpen, aTagClose : boolean; aCloseTags : TStringList;
      aAction : TLMDParseAction; aParser : TLMDExtParser;
      aExceptionHandler : TLMDParseAction; aTable : TLMDListObjects{TList});
begin
  inherited Create(aName, aParser, aTable, aAction, aExceptionHandler);
  FTagOpen   := aTagOpen;
  FTagClose  := aTagClose;
  FCloseTags := aCloseTags;
end;

{------------------------------------------------------------------------------}

destructor TLMDElementEntry.Destroy;
begin
  SetRule(nil, False);
//  FRule.Free;
  if Assigned(FExclusion) then FExclusion.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDElementEntry.SetRule(Rule: TLMDRule; Owned: Boolean);
begin
  if Assigned(FRule) and FOwnedRule then
    FRule.Free;

  FRule := Rule;
  FOwnedRule := Owned;
end;

{------------------------------------------------------------------------------}

function TLMDElementEntry.IsTrue(aTree : TLMDDeductionTree) : boolean;
begin
  Result := False;

  if Not FParser.ValidToken then Exit;
  if Locked then Exit;

  if not FParser.Tag(FName) then begin
    if FTagOpen then Exit;
  end
  else begin
    DoAction(aTree, esOpenTag);
    FParser.NextToken;
//    NextToken(aTree);
  end;

  LockExclusion;

  if not CheckDataModel(aTree) then begin
    UnLockExclusion;
    DoAction(aTree, esElementFail);
    Result := False;
    Exit;
  end;

  Result := True;
  if not FParser.Tag('/'+FName) then
    if FTagClose then begin
      DoAction(aTree, esElementFail);
      UnLockExclusion;
      Result := False;
      Exit;
    end
    else begin
      UnLockExclusion;
      DoAction(aTree, esElementSuccess);
      Exit;
    end;

  DoAction(aTree, esCloseTag);
  UnLockExclusion;
  DoAction(aTree, esElementSuccess);
  FParser.NextToken;
//  NextToken(aTree);
end;

{------------------------------------------------------------------------------}

procedure TLMDElementEntry.RollBack(aTree : TLMDDeductionTree);
begin
  DoAction(aTree, esRollBack);
  FParser.Position := aTree.StartPos;
end;

end.
