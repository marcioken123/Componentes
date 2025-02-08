unit LMDList;
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

LMDList unit - Run time library
-------------------------------
Description

Created: 1996

Changes
-------
Oct 2006 (VB):

[+] Prepend procedure added (insert before root)
[*] Items[index] now returns nil if index is out of range
[*] InsertAt(item, 0) calls Prepend procedure
[-] Clear procedure now nullifies FLast, FRoot and FCurrent

* Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDBuffer;

type
  TLMDCompareItemEvent = procedure (Sender : TObject; item1, item2 : Integer; result : Integer) of object;

  PLMDBiDynNode = ^TLMDBiDynNode;
  TLMDBiDynNode = record
    item : Pointer;
    next,
    prev : PLMDBiDynNode;
  end;

  TLMDList = class(TLMDBuffer)
  private
    FCurrent,
    FLast,
    FRoot : PLMDBiDynNode;

    FOnCompareItem : TLMDCompareItemEvent;
    function  AllocNode: PLMDBiDynNode;
    procedure FreeNode(Node: PLMDBiDynNode);
  protected
    procedure FirstNode (var node : Pointer); override;
    procedure NextNode (var node : Pointer); override;
    function GetItem (node : Pointer) : Pointer; override;
    function EOFBuffer(node : Pointer) : Boolean; override;
    procedure SetItem (index : Integer; item : Pointer);
    public

    constructor Create(AOwner: TPersistent = nil); override;
    destructor Destroy; override;

    function Item : TObject; //O(1)
    procedure First; //O(1)
    procedure Next; //O(1)
    procedure Last; //O(1)
    procedure Prev; // O(1)
    function IsLast: Boolean; //O(1);
    procedure Seek(index: Integer); //O(n) ... n/2

    function IsEmpty: Boolean; override;
    function IsFull: Boolean; override;
    procedure Put(item : Pointer); override; //O(1)
    function Get: Pointer; override; //O(1)
    function IndexOf(aItem: Pointer): integer;
    procedure Remove(aItem: Pointer);
    function LastItem: Pointer;
    function Extract: Pointer;  //O(1)
    function ExtractByNr(index : Integer) : Pointer; //O(n) ... n/2
    function GetItemByNr(index : Integer) : Pointer; //O(n) ... n/2
    procedure Delete;
    procedure Add(item: Pointer);
    procedure Prepend(Item: Pointer);
    procedure Insert(Item: Pointer); //O(1)
    procedure InsertAt(Item: Pointer; index : Integer); //O(n) ... n/2
    procedure Clear; override; //O(n)
    procedure LoadFromStream (Stream : TStream); override;

    property Items[Index: Integer]: Pointer read GetItemByNr write SetItem; default;
    property OnCompareItem : TLMDCompareItemEvent read FOnCompareItem write FOnCompareItem;
  end;

implementation

{ ---------------------------- protected ------------------------------------- }

procedure TLMDList.FirstNode (var node : Pointer);

begin
  node := FRoot;
  end;

{ ---------------------------------------------------------------------------- }

procedure TLMDList.NextNode (var node : Pointer);

begin
  if (node = nil) then
    exit;
  node := PLMDBiDynNode(node).next;
  end;

{ ---------------------------------------------------------------------------- }

function TLMDList.GetItem (node : Pointer) : Pointer;

begin
  result := PLMDBiDynNode(node).item;
end;

{ ---------------------------------------------------------------------------- }

function TLMDList.IndexOf(aItem: Pointer):integer;

var
  i: integer;
begin
  result := -1;
  if not IsEmpty then
    begin
      First;
      i := 0;
      while not IsLast do
        if (Item = aItem) then
          begin
            result := i;
            break;
          end
        else
          begin
            inc(i);
            Next;
            if IsLast and (Item = aItem) then
              Result := i;
          end;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDList.Remove(aItem: Pointer);

begin
  Seek(IndexOf(aItem));
  Get;
end;

{ ---------------------------------------------------------------------------- }

function TLMDList.LastItem: Pointer;

begin
  //Though TLMDBiDynNode maps right when dereferencing since Item is the first
  //field in the record, more correct variant is in CLR section.
  //This version is left for compatibility with existing demos and
  //must be changed to CLR version later with carefull tests of demos.
  result := FLast;
  end;

{ ---------------------------------------------------------------------------- }

function TLMDList.EOFBuffer (node : Pointer) :Boolean;

begin
  result := (node = nil);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDList.SetItem (index : Integer; item : Pointer);

begin
  Seek(index);
  if  Assigned(FCurrent)  then
    FCurrent.item := item;
end;

{ ---------------------------- public ---------------------------------------- }
constructor TLMDList.Create;
begin
  inherited Create;
  FRoot := nil;
  FLast := nil;
  FCurrent := nil;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDList.Item : TObject;
begin
  result := nil;
  if FCurrent = nil then exit;
  result := FCurrent.item;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDList.First;
var
  Node: Pointer;
  begin
  FirstNode (Node);
  FCurrent := PLMDBiDynNode(Node);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDList.Next;
var
  Node: Pointer;
  begin
  if FCurrent = nil then begin First; Exit; end;//we can only step to the next element if there is one!! -> try to set FCurrent on first
  if FCurrent.next = nil then exit; //already on last item
  Node := TObject(FCurrent);
  NextNode (Node);
  FCurrent := PLMDBiDynNode(Node);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDList.Last;
begin
  FCurrent := FLast;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDList.Prev;
begin
  if (FCurrent = nil) or (FCurrent.prev = nil) then exit;
  FCurrent := FCurrent.prev;
end;

{ ---------------------------------------------------------------------------- }
function TLMDList.IsLast: Boolean; //O(1);
begin
  result := (FCurrent = FLast);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDList.Seek(index : Integer);
var
  i : Integer;
begin
  if (index > FCount) or (index < 1) then
    exit;
  //search for item (regarding shortest way)
  if FCount div 2 > index then
    begin
      First;
      i := 1;
      while i < index do
        begin
          inc(i);
          Next;
        end;
    end
  else
    begin
      Last;
      i := FCount;
      while i > index do
        begin
          dec(i);
          Prev;
        end;
    end;
  //FCurrent is now item with index index
end;

{ ---------------------------------------------------------------------------- }
function TLMDList.IsEmpty : Boolean;
begin
  result := (FRoot = nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDList.IsFull : Boolean;
begin
  result := false;
  if (MaxEntries <> -1) then
    Result := (Count >= FMaxEntries);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDList.Put(item : Pointer);

var
  node : PLMDBiDynNode;
begin
  if (MaxEntries <> -1) and (Count >= MaxEntries) then exit;
  node := AllocNode;
  node.item := item;
  node.prev := nil;
  node.next := nil;
  inc(FCount);
  if FRoot = nil then
  begin
    FRoot := node;
    FLast := node;
    FCurrent := node;
    exit;
  end;
  FLast.next := node;
  node.prev := FLast;
  FLast := node;
end;

{ ---------------------------------------------------------------------------- }

function TLMDList.Get: Pointer;

var
  hNode : PLMDBiDynNode;
begin
  result := nil;
  if FCurrent = nil then exit;

  result := FCurrent.Item;

  hNode := FCurrent.prev;

  if hNode <> nil then
    hNode.next := FCurrent.next
  else //we are on the root
    FRoot := FCurrent.next;

  //is there a successor?
  hNode := FCurrent.next;

  if hNode <> nil then
    hNode.prev := FCurrent.prev
  else //we are on the last item
    FLast := FCurrent.prev;

  //one node less
  dec (FCount);

  //dispose the node
  FreeNode(FCurrent);

  FCurrent := hNode;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDList.Delete;
begin
  if Assigned(OnDestroyItem) then
    OnDestroyItem(Self, Get)
  else
    Get; //warning!! The item will NOT be deleted here!!
end;

{ ---------------------------------------------------------------------------- }

function TLMDList.Extract: Pointer;

begin
  result := Get;
end;

{ ---------------------------------------------------------------------------- }

function TLMDList.ExtractByNr(index: Integer) : Pointer;

begin
  Seek(index);
  Result := Get;
end;

{ ---------------------------------------------------------------------------- }

function TLMDList.GetItemByNr(index: Integer) : Pointer;

begin
  Seek(index);
  if  Assigned(FCurrent) and (index <= FCount) and (index >= 1) then
    result := GetItem(TObject(FCurrent))
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDList.Insert(item: Pointer);

var
  newNode : PLMDBiDynNode;
begin
  if ((MaxEntries <> -1) and (Count >= MaxEntries)) then exit;
  if (FCurrent = nil) then
    begin
      Put(item);
      exit;
    end;
  newNode := AllocNode;
  newNode.item := item;
  newNode.prev := FCurrent;
  newNode.next := FCurrent.next;

  if newNode.next <> nil then
    newNode.next.prev := newNode;

  FCurrent.next := newNode;

  if FCurrent = FLast then
    FLast := newNode;

  inc(FCount);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDList.insertAt (item : Pointer; index : Integer);

begin
  if (index >= 1) then
    begin
     Seek(index);
     Insert(item);
    end
  else
    Prepend(item);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDList.Add(item : Pointer);

begin
  Last;
  Insert(item);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDList.Prepend(item : Pointer);

var
  newNode : PLMDBiDynNode;
begin
  if Count <= 0 then
    Put(Item)
  else
    begin
      if ((MaxEntries <> -1) and (Count >= MaxEntries)) then exit;
      newNode := AllocNode;
      newNode.item := item;
      newNode.prev := nil;
      newNode.next := FRoot;
      FRoot.prev := newNode;
      Froot := newNode;
      inc(FCount);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDList.Clear;
begin
  while FRoot <> nil do
  begin
    FCurrent := FRoot.next;
    FreeNode(FRoot);
    if FCurrent <> nil then
      FCurrent.prev := nil;
    FRoot := FCurrent;
  end;
  FRoot := nil;
  FCurrent := nil;
  FLast := nil;
  FCount := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDList.LoadFromStream (Stream : TStream);
begin
  BeginUpdate;
  inherited LoadFromStream (Stream);
  EndUpdate;
  First; //set Current to first item
end;

function  TLMDList.AllocNode: PLMDBiDynNode;
begin

  New(Result);

end;

procedure TLMDList.FreeNode(Node: PLMDBiDynNode);
begin
  if  Assigned(Node)  then

  Dispose(Node);

end;

end.
