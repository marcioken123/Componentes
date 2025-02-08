unit LMDRule;
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

LMDRule unit (VO)
-----------------

Used for store description of datamodel for HTML elements 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, LMDDeductionTree, LMDExtParser;

type

  TLMDIteratorType = (iONCE, iONE, iZero_or_One, iZero_or_More, iOne_or_More);

  TLMDRuleType = (rtATOM, rtRULE);

  { ******************************* TLMDBaseRule ***************************** }
  TLMDBaseRule = class
  private
    FName     : string;
    FType     : TLMDRuleType;
    FIterator : TLMDIteratorType;
    function Iterator_ONCE(aNode : TLMDDeductionTree) : boolean;
    function Iterator_ONE(aNode : TLMDDeductionTree) : boolean;
    function Iterator_ZERO_OR_ONE(aNode : TLMDDeductionTree) : boolean;
    function Iterator_ZERO_OR_MORE(aNode : TLMDDeductionTree) : boolean;
    function Iterator_ONE_OR_MORE(aNode : TLMDDeductionTree) : boolean;
  protected
    function CheckOnce(aNode : TLMDDeductionTree) : boolean; virtual; abstract;
  public
    function Check(aNode : TLMDDeductionTree) : boolean;
    property RuleType : TLMDRuleType read FType;
    property Iterator : TLMDIteratorType read  FIterator write FIterator;
    property Name : string read FName write FName;
  end;

  { ******************************* TLMDAtomRule ***************************** }
  TLMDAtomRule = class (TLMDBaseRule)
  private
    FEntry : pointer;
    protected
    function CheckOnce(aNode : TLMDDeductionTree) : boolean; override;
  public
    constructor Create(aEntry : pointer; aIterator : TLMDIteratorType);
    property EntryPoint : Pointer read FEntry;
    end;

  TLMDRuleList = class;
  { ******************************* TLMDRule ********************************* }
  TLMDRule = class (TLMDBaseRule)
  private
    FList : TList;
    procedure Clear;
    function GetItem(index : LongInt) : TLMDRuleList;
    function CheckCNF(Index : LongInt; aNode : TLMDDeductionTree) : boolean;
  protected
    function CheckOnce(aNode : TLMDDeductionTree) : boolean; override;
  public
    constructor Create;
    destructor Destroy; override;
    function Count : LongInt;
    procedure Add(aEntry : TObject; aIterator : TLMDIteratorType); overload;
    procedure Add(aRule : TLMDRule); overload;
    procedure Add_OR;
    property Item[index : LongInt] : TLMDRuleList read GetItem; default;
  end;

  { ******************************* TLMDRuleList ***************************** }

  TLMDRuleList = class
  private
    FList : TList;
    function GetItem(index : LongInt) : TLMDBaseRule;
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    function Count : LongInt;
    procedure Add(aItem : TLMDBaseRule);
    property Item[index : LongInt] : TLMDBaseRule read GetItem; default;
  end;

implementation
uses
  LMDEntryPoint, LMDText;

{ ********************************* TLMDBaseRule ***************************** }
{------------------------------------------------------------------------------}

function TLMDBaseRule.Iterator_ONCE(aNode : TLMDDeductionTree) : boolean;
var
  Node : TLMDDeductionTree;
begin
  Node := aNode.AddSubItem;
  result := CheckOnce(Node);
  if Not result then Node.Chop;
end;

{------------------------------------------------------------------------------}

function TLMDBaseRule.Iterator_ONE(aNode : TLMDDeductionTree) : boolean;
var
  Node : TLMDDeductionTree;
begin
  Result := False;
  Node := aNode.AddSubItem;
  if CheckOnce(Node) then begin
    Node := aNode.AddSubItem;
    if CheckOnce(Node) then aNode.RollBack
    else begin
      Node.Chop;
      result := True;
    end;
  end
  else Node.Chop;
end;

{------------------------------------------------------------------------------}

function TLMDBaseRule.Iterator_ZERO_OR_ONE(aNode : TLMDDeductionTree) : boolean;
var
  Node : TLMDDeductionTree;
begin
  result := False;
  Node := aNode.AddSubItem;
  if not CheckOnce(Node) then begin
    aNode.Chop;
    Result := True;
    Exit;
  end;

  Node := aNode.AddSubItem;
  if CheckOnce(Node) then  aNode.RollBack
  else begin
    Node.Chop;
    result := True;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDBaseRule.Iterator_ZERO_OR_MORE(aNode : TLMDDeductionTree) : boolean;
var
  Node : TLMDDeductionTree;
begin
  result := True;
  Node := aNode.AddSubItem;
  if not CheckOnce(Node) then begin
    Node.Chop;
    Exit;
  end;
  repeat
    Node := aNode.AddSubItem;
  until not CheckOnce(Node);
  Node.Chop;
end;

{------------------------------------------------------------------------------}

function TLMDBaseRule.Iterator_ONE_OR_MORE(aNode : TLMDDeductionTree) : boolean;
var
  Node : TLMDDeductionTree;
begin
  result := False;
  Node := aNode.AddSubItem;
  if CheckOnce(Node) then begin
    result := True;
    repeat
      Node := aNode.AddSubItem;
    until not CheckOnce(Node);
    Node.Chop;
  end
  else Node.Chop;
end;

{ ********************************* PROTECTED ******************************** }

function TLMDBaseRule.Check(aNode : TLMDDeductionTree) : boolean;
begin
  result := False;
  case FIterator of
    iONCE : result := Iterator_ONCE(aNode);
    iONE : result := Iterator_ONE(aNode);
    iZero_or_One : result := Iterator_ZERO_OR_ONE(aNode);
    iZero_or_More : result := Iterator_ZERO_OR_MORE(aNode);
    iOne_or_More : result := Iterator_ONE_OR_MORE(aNode);
  end;
end;

{ ********************************* TLMDAtomRule ***************************** }
{------------------------------------------------------------------------------}

function TLMDAtomRule.CheckOnce(aNode : TLMDDeductionTree) : boolean;
var
  Node : TLMDDeductionTree;
begin
  Node := aNode.AddSubItem;
  Node.EntryPoint := FEntry;
  result := TLMDEntryPoint(FEntry).IsTrue(Node);
  if Not result then Node.Chop;
end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDAtomRule.Create(aEntry : pointer; aIterator : TLMDIteratorType);

begin
  inherited Create;
  FType := rtATOM;
  FIterator := aIterator;
  FEntry := aEntry;
end;

{ ********************************* TLMDRule ********************************* }
{------------------------------------------------------------------------------}

procedure TLMDRule.Clear;
var
  I : LongInt;
begin
  for I := 0 to FList.count-1 do
    TObject(FList[I]).Free;
  FList.Clear;
end;

{------------------------------------------------------------------------------}

function TLMDRule.GetItem(index : LongInt) : TLMDRuleList;
begin  result := TLMDRuleList(Flist[index]) end;

{------------------------------------------------------------------------------}

function TLMDRule.CheckCNF(Index : LongInt; aNode : TLMDDeductionTree) : boolean;
var
  I     : LongInt;
  Node  : TLMDDeductionTree;
  RL    : TLMDRuleList;
begin
  RL := Item[Index];
  if RL.Count = 0 then begin
    result := False;
    Exit;
  end;
  result := true;
  for I := 0 to RL.count-1 do begin
    Node := aNode.AddSubItem;
    Result := Result and RL[I].Check(Node);
    if not Result then begin
      Node.Chop;
      if I > 0 then aNode.RollBack;
      Break;
    end;
  end;
end;

{ ********************************* PROTECTED ******************************** }

function TLMDRule.CheckOnce(aNode : TLMDDeductionTree) : boolean;
var
  I     : LongInt;
  Node  : TLMDDeductionTree;
begin
  result := False;
  for I := 0 to Count-1 do begin
    Node := aNode.AddSubItem;
    if not CheckCNF(I, Node) then Node.Chop
    else begin
      result := True;
      Break;
    end;
  end;
end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDRule.Create;
begin
  inherited;
  FType := rtRULE;
  FList := TList.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDRule.Destroy;
begin
  Clear;
  FList.Free;
  inherited
end;

{------------------------------------------------------------------------------}

function TLMDRule.Count : LongInt;
begin result := FList.count end;

{------------------------------------------------------------------------------}

procedure TLMDRule.Add(aEntry : TObject; aIterator : TLMDIteratorType);
begin
  if FList.count=0 then
    FList.Add(TLMDRuleList.Create);
  TLMDRuleList(FList[FList.count-1]).Add(TLMDAtomRule.Create(aEntry, aIterator));
end;

{------------------------------------------------------------------------------}

procedure TLMDRule.Add(aRule : TLMDRule);
begin
  if FList.count=0 then
    FList.Add(TLMDRuleList.Create);
  TLMDRuleList(FList[FList.count-1]).Add(aRule);
end;

{------------------------------------------------------------------------------}

procedure TLMDRule.Add_OR;
begin FList.Add(TLMDRuleList.Create) end;

{ ********************************* TLMDRuleList ************************ }
{------------------------------------------------------------------------------}

function TLMDRuleList.GetItem(index : LongInt) : TLMDBaseRule;
begin  result := TLMDBaseRule(FList[index]) end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDRuleList.Create;
begin
  inherited;
  FList := TList.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDRuleList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDRuleList.count : LongInt;
begin  result := FList.count end;

{------------------------------------------------------------------------------}

procedure TLMDRuleList.Clear;
var
  I : LongInt;
begin
  for I := 0 to FList.count-1 do
    if assigned(FList[I]) then
      TLMDBaseRule(FList[I]).Free;
  FList.Clear
end;

{------------------------------------------------------------------------------}

procedure TLMDRuleList.Add(aItem : TLMDBaseRule);
begin FList.Add(aItem) end;

end.
