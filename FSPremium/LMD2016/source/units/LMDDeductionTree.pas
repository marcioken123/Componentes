unit LMDDeductionTree;
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

LMDDeductionTree unit (VO)
--------------------------

TLMDRule and TLMDEntryPoint uses TLMDDeductionTree for a storing of parsing 
results with ability to make rollback in case of fail in parsing 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
//  Classes,
  LMDListObjects, LMDText;

type

  { ******************************* TLMDDeductionTree ************************ }
  TLMDDeductionTree = class
  private
    FStartPos   : LongInt;
    FParent     : TLMDDeductionTree;
    FList       : TLMDListObjects;//TList;
    FParsedText : TLMDParsedTextList;
    FEntry      : Pointer;
    function  GetItem(index : LongInt) :  TLMDDeductionTree;
  public
    constructor Create(aParent : TLMDDeductionTree);
    destructor Destroy; override;
    function AddSubItem : TLMDDeductionTree;
    function Count : LongInt;
    procedure ClearParsedText;
    procedure Clear;
    procedure Chop;
    procedure RollBack;
    property StartPos : LongInt read FStartPos write FStartPos;
    property ParsedText : TLMDParsedTextList read FParsedText write FParsedText;
    property EntryPoint : pointer read FEntry write FEntry;
    property Item[index : LongInt] : TLMDDeductionTree read GetItem; default;
  end;

implementation

uses
  LMDEntryPoint;

{ ********************************* TLMDDeductionTree ************************ }
{------------------------------------------------------------------------------}

function  TLMDDeductionTree.GetItem(index : LongInt) :  TLMDDeductionTree;
begin
  if  Assigned(FList) then
    Result := TLMDDeductionTree(FList[index])
  else
    Result := nil;
end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDDeductionTree.Create(aParent : TLMDDeductionTree);
begin
  inherited Create;
  FStartPos   := -1;
  FParent     := aParent;
  FList       := nil;//TList.Create;
  FParsedText := nil;
  FEntry      := nil;
end;

{------------------------------------------------------------------------------}

destructor TLMDDeductionTree.Destroy;
//var
//  I : LongInt;
begin
  Clear;
  FParsedText := nil;
  FEntry      := nil;
//  FList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDDeductionTree.Count : LongInt;
begin
  if  Assigned(FList) then
    Result := FList.count
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDDeductionTree.RollBack;
var
  I : LongInt;
begin

  for I := count-1 downto 0 do
    Item[I].RollBack;
  Clear;

  if assigned(EntryPoint) then TLMDEntryPoint(EntryPoint).RollBack(Self);

end;

{------------------------------------------------------------------------------}

var
  NodeCache: TLMDListObjects = nil;

function  GetObject_DT(aParent : TLMDDeductionTree): TLMDDeductionTree;
begin
  Result := TLMDDeductionTree(NodeCache.RemoveLast);

  if  Assigned(Result)  then
    Result.FParent := aParent
  else
    Result := TLMDDeductionTree.Create(aParent);
end;

function  AddToCache(Node: TLMDDeductionTree): Boolean;
begin
//Node.Free; exit;
  if  Assigned(Node)  then
    begin
      if  Assigned(Node.FList) then
        while AddToCache(TLMDDeductionTree(Node.FList.RemoveLast)) do;
//        Node.FList.Clear;

      Node.FParsedText := nil;
      Node.FEntry      := nil;
      Node.FParent     := nil;
      NodeCache.Add(Node);
      Result := True;
    end
  else
    Result := False;
end;

procedure TLMDDeductionTree.Clear;
begin
  FList.Free;
  FList := nil;
end;

{------------------------------------------------------------------------------}

procedure TLMDDeductionTree.Chop;
begin
  if assigned(FParent) then  FParent.FList.Remove(Self);
//  Free;
  AddToCache(self);
end;

{------------------------------------------------------------------------------}

function TLMDDeductionTree.AddSubItem : TLMDDeductionTree;
begin
//  Result := TLMDDeductionTree.Create(self);
  Result := GetObject_DT(self);
  Result.ParsedText := ParsedText;
  Result.EntryPoint := nil;
  Result.StartPos := FStartPos;

  if  not Assigned(FList) then
    FList := TLMDListObjects.Create;

  FList.Add(Result);
end;

{------------------------------------------------------------------------------}

procedure TLMDDeductionTree.ClearParsedText;
var
  I : LongInt;
begin
  FParsedText := nil;
  for I := 0 to count-1 do
    Item[I].ClearParsedText;
end;

initialization
  NodeCache := TLMDListObjects.Create;
finalization
  NodeCache.Free;
end.
