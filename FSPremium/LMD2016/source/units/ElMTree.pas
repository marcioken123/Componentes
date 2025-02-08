unit ElMTree;
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

ElMTree unit
------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses Classes, SysUtils, LMDObjectList;

type
  TElMTree = class;

//  TElMTreeItem = ^RElMTreeItem;
//  RElMTreeItem = record
//    Parent : TElMTreeItem;
//    Data : pointer;
//    List : TLMDObjectList;
//  end;

  TElMTreeItem = class
  private
    FParent: TElMTreeItem;
    FData: pointer;
    FList: TLMDObjectList;
    FTag: Integer;
  public
    procedure MoveTo(NewParent: TElMTreeItem);virtual;
    procedure MoveToIns(NewParent: TElMTreeItem; AnIndex: Integer);virtual;
    property Parent : TElMTreeItem read Fparent Write FParent;
    property Tag: Integer read FTag write FTag;
    property Data : pointer read Fdata write FData;
    property List : TLMDObjectList read Flist write FList;
  end;

  TIterProc = procedure(Item : TElMTreeItem; Index : integer; var ContinueIterate : boolean;
    IterateData : pointer);

  TItemSaveEvent = procedure(Sender : TObject; Item : TElMTreeItem; Stream : TStream) of object;

  TElMTreeItemDelete = procedure(Sender : TObject; Item : TElMTreeItem; Data : pointer) of object;

  TElMTree = class
  private
    FRoot : TElMTreeItem;
    FCount : integer;
    FOnItemSave : TItemSaveEvent;
    FOnItemLoad : TItemSaveEvent;
    FOnItemDelete : TElMTreeItemDelete;
    function GetItem(index : integer) : TElMTreeItem;
  protected
    procedure TriggerItemSaveEvent(Item : TElMTreeItem; Stream : TStream); virtual;
    procedure TriggerItemLoadEvent(Item : TElMTreeItem; Stream : TStream); virtual;
    procedure TriggerItemDeleteEvent(Item : TElMTreeItem; Data : pointer); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function AddItem(Parent : TElMTreeItem; Value : pointer) : TElMTreeItem; virtual;
    function InsertItem(Parent : TElMTreeItem; Index : integer; Value : pointer) : TElMTreeItem; virtual;
    procedure DeleteItem(Item : TElMTreeItem);
    procedure MoveTo(Item, NewParent : TElMTreeItem);
    procedure Clear;virtual;
    function GetIndex(Item : TElMTreeItem) : Integer;
    function GetAbsIndex(Item : TElMTreeItem) : Integer;
    function GetNextSibling(Item: TElMTreeItem): TElMTreeItem;

    procedure Iterate(IterateProc : TIterProc; IterateData : pointer);
    procedure SaveToStream(Stream : TStream); virtual;
    procedure LoadFromStream(Stream : TStream); virtual;
    procedure SaveSubTreeToStream(Item : TElMTreeItem; Stream : TStream ; ReadRoot : boolean = true); virtual;
         // Item will be saved too
    procedure LoadSubTreeFromStream(Item : TElMTreeItem; Stream : TStream ; ReadRoot : boolean = true); virtual;
    procedure MoveToIns(Item, NewParent : TElMTreeItem; Index : integer);
    function FindData(Data : pointer): TElMTreeItem;
    function GetLevel(Item : TElMTreeItem): Integer;
         // Item here is the "parent" item for all items loaded

    property Count : Integer read FCount; { Public }
    property Item[index : integer] : TElMTreeItem read GetItem; { Public }
    property OnItemSave : TItemSaveEvent read FOnItemSave write FOnItemSave;
    property OnItemLoad : TItemSaveEvent read FOnItemLoad write FOnItemLoad;
    property OnItemDelete : TElMTreeItemDelete read FOnItemDelete write FOnItemDelete;
    property Root : TElMTreeItem read FRoot;
  end;

implementation

procedure TElMTree.Iterate(IterateProc : TIterProc; IterateData : pointer);
var
  j : integer;
  DoContinue : boolean;

  procedure IntIterate(Item : TElMTreeItem);
  var
    i : integer;
  begin
    inc(j);
    if j >= 0 then IterateProc(Item, j, DoContinue, IterateData);
    if not (DoContinue) then exit;
    for i := 0 to Item.List.Count - 1 do
    begin
      IntIterate(TElMTreeItem(Item.List[i]));
      if not (DoContinue) then exit;
    end;
  end;

begin
  j := -2;
  DoContinue := true;
  IntIterate(FRoot);
end;

function TElMTree.GetItem(index : integer) : TElMTreeItem;

type
  PGIRec = ^TGIRec;
  TGIRec = record
    j : integer;
    TSI : TElMTreeItem;
  end;

  procedure IntGetItem(Item : TElMTreeItem; Index : integer; var ContinueIterate : boolean;
    IterateData : Pointer);
  begin
    if Index = PGIRec(IterateData)^.j then
    begin
      PGIRec(IterateData)^.TSI := Item;
      ContinueIterate := false;
    end;
  end;

var
  GIRec : TGIRec;
begin
  if (index < 0) or (index >= FCount) then
  begin
    result := nil;
    exit;
  end;
  GIRec.TSI := nil;
  GIRec.j := index;
  Iterate(@IntGetItem, @GIRec);
  result := GIRec.TSI;
  end;

function TElMTree.AddItem(Parent : TElMTreeItem; Value : pointer) : TElMTreeItem; { public }
var
  TI : TElMTreeItem;
begin
  TI := TElMTreeItem.Create;
  TI.List := TLMDObjectList.Create;
  TI.Data := Value;
  if Parent = nil then
    FRoot.List.Add(TI)
  else
    Parent.List.Add(TI);
  if Parent = nil then
    TI.Parent := FRoot
  else
    TI.Parent := Parent;
  result := ti;
  inc(FCount);
end; { AddItem }

function TElMTree.InsertItem(Parent : TElMTreeItem; Index : integer; Value : pointer) : TElMTreeItem; { public }
var
  TI : TElMTreeItem;
begin
  TI := TElMTreeItem.Create;
  TI.List := TLMDObjectList.Create;
  TI.Data := Value;
  if Parent = nil then
  begin
    FRoot.List.Insert(index, TI);
    TI.Parent := FRoot;
  end
  else
  begin
    Parent.List.Insert(Index, TI);
    TI.Parent := Parent;
  end;
  result := ti;
  inc(FCount);
end; { InsertItem }

procedure TElMTree.DeleteItem(Item : TElMTreeItem); { public }
begin
  if (Item = nil) then exit;
  while Item.List.Count > 0 do
    DeleteItem(TElMTreeItem(Item.List[0]));
  Item.List.Free;
  Item.Parent.List.Remove(Item);
  TriggerItemDeleteEvent(Item, Item.Data);
  Item.Free;
  dec(FCount);
end; { DeleteItem }

procedure TElMTree.Clear; { public }
begin
  while FRoot.List.Count > 0 do
    DeleteItem(TElMTreeItem(FRoot.List[0]));
end; { Clear }

procedure TElMTree.MoveTo(Item, NewParent : TElMTreeItem); { public }
begin
  if Item = nil then exit;
  Item.Parent.List.Remove(Item);
  if NewParent = nil then NewParent := FRoot;
  NewParent.List.Add(Item);
  Item.Parent := NewParent;
end; { MoveTo }

function TElMTree.GetIndex(Item : TElMTreeItem) : Integer; { public }
begin
  if Assigned(Item.Parent) then
    result := Item.Parent.List.IndexOf(Item)
  else
    result := Froot.List.IndexOf(Item);
end; { GetIndex }

function TElMTree.GetAbsIndex(Item : TElMTreeItem) : Integer; { public }

type
  PGIRec = ^TGIRec;
  TGIRec = record
    j : integer;
    TSI : TElMTreeItem;
  end;

  procedure IntGetIndex(Item : TElMTreeItem; Index : integer; var ContinueIterate : boolean;
    IterateData : pointer);
  begin
    if PGIRec(IterateData)^.TSI = Item then
    begin
      PGIRec(IterateData)^.j := index;
      ContinueIterate := false;
    end;
  end;

var
  GIRec : TGIRec;
begin
  if Item = nil then
  begin result := -1;
    exit;
  end;
  GIRec.j := -1;
  GIRec.TSI := Item;
  Iterate(@IntGetIndex, @GIRec);
  result := GIRec.j;
end;

procedure TElMTree.SaveToStream(Stream : TStream); { public }
begin
  SaveSubTreeToStream(FRoot, Stream);
end; { SaveToStream }

procedure TElMTree.LoadFromStream(Stream : TStream); { public }
begin
  LoadSubTreeFromStream(FRoot, Stream);
end; { LoadFromStream }

procedure TElMTree.SaveSubTreeToStream(Item : TElMTreeItem; Stream : TStream ; ReadRoot : boolean = true);

  procedure IntSave(Base, Item : TElMTreeItem; Stream : TStream; Tree : TElMTree);
  var
    i, j : integer;
  begin
    i := Item.List.Count;
    Stream.WriteBuffer(i, sizeof(integer));
    if (Item <> Base) then
      Tree.TriggerItemSaveEvent(Item, Stream);
    for j := 0 to i - 1 do
      IntSave(Base, TElMTreeItem(Item.List[j]), Stream, Tree);
  end;

begin
  if Item = nil then Item := FRoot;
  if ReadRoot then
    IntSave(FRoot, Item, Stream, self)
  else
    IntSave(Item, Item, Stream, self);
end;

procedure TElMTree.LoadSubTreeFromStream(Item : TElMTreeItem; Stream : TStream ; ReadRoot : boolean = true);

  procedure IntLoad(Base, Item : TElMTreeItem; Stream : TStream; Tree : TElMTree);
  var
    i, j : integer;
    NewItem : TElMTreeItem;
  begin
    Stream.ReadBuffer(i, sizeof(integer));
    if Item <> Base then
      Tree.TriggerItemLoadEvent(Item, Stream);
    if i < 0 then
       raise EOutOfMemory.Create('');
    for j := 0 to i - 1 do
      begin
        NewItem := Tree.AddItem(Item, nil);
        IntLoad(Base, NewItem, Stream, Tree);
      end;
  end;

begin
  if Item = nil then Item := FRoot;
  if ReadRoot then
    IntLoad(FRoot, Item, Stream, self)
  else
    IntLoad(Item, Item, Stream, self);
end;

procedure TElMTree.TriggerItemSaveEvent(Item : TElMTreeItem; Stream : TStream);
{ Triggers the OnItemSave event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnItemSave)) then
    FOnItemSave(Self, Item, Stream);
end; { TriggerItemSaveEvent }

procedure TElMTree.TriggerItemLoadEvent(Item : TElMTreeItem; Stream : TStream);
{ Triggers the OnItemLoad event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnItemLoad)) then
    FOnItemLoad(Self, Item, Stream);
end; { TriggerItemLoadEvent }

procedure TElMTree.TriggerItemDeleteEvent(Item : TElMTreeItem; Data :pointer);
{ Triggers the OnItemDelete event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnItemDelete)) then
    FOnItemDelete(Self, Item, Data);
end; { TriggerItemDeleteEvent }

constructor TElMTree.Create; { public }
begin
  inherited;
  FRoot := TElMTreeItem.Create;
  FRoot.Parent := nil;
  FRoot.Data := nil;
  FRoot.List := TLMDObjectList.Create;
end; { Create }

destructor TElMTree.Destroy; { public }
begin
  Clear;
  FRoot.List.Free;
  FRoot.Free;
  inherited;
end; { Destroy }

procedure TElMTree.MoveToIns(Item, NewParent : TElMTreeItem; Index : integer);
begin
  if Item = nil then exit;
  Item.Parent.List.Remove(Item);
  if NewParent = nil then
    NewParent := FRoot;
  NewParent.List.Insert(Index, Item);
  Item.Parent := NewParent;
end; { MoveTo }

function TElMTree.FindData(Data : pointer): TElMTreeItem;

type
  TSRec = record
    Data : pointer;
    Item : TElMTreeItem;
  end;
  PSrec = ^TSrec;

  procedure SearchProc(Item : TElMTreeItem; Index : integer; var ContinueIterate : boolean;
    IterateData : pointer);
  begin
    if Item.Data = PSrec(IterateData).Data then
    begin
      ContinueIterate := false;
      PSrec(IterateData).Item := Item;
    end;
  end;

var
  SRec : TSRec;
begin
  SRec.Data := Data;
  SRec.Item := nil;
  Iterate(@SearchProc, @SRec);
  Result := SRec.Item;
  end;

function TElMTree.GetLevel(Item : TElMTreeItem): Integer;
begin
  if Assigned(Item) and Assigned(Item.parent) then
  begin
    Result := 0;
    while Item.Parent <> FRoot do
    begin
      inc(Result);
      Item := Item.Parent;
    end;
  end
  else
    Result := -1;
end;

function TElMTree.GetNextSibling(Item: TElMTreeItem): TElMTreeItem;
var
  i: integer;
begin
  i := Self.GetIndex(Item);
  if Assigned(Item.Parent) then
     if Item.Parent.FList.Count > i+1 then
       Result := TElMTreeItem(Item.Parent.List[i+1])
     else
       Result := nil
  else
     if Self.FRoot.FList.Count > i+1 then
       Result := TElMTreeItem(Self.FRoot.List[i+1])
     else
       Result := nil
end;

{ TElMTreeItem }

procedure TElMTreeItem.MoveTo(NewParent: TElMTreeItem);
var
  TSI: TElMTreeItem;
begin
  if NewParent = self then
    Exit;
  if NewParent = nil then
     TSI := FParent
  else
     TSI := NewParent;
  if TSI.FList.Count = 0 then
     MoveToIns(NewParent, 0)
  else
     MoveToIns(NewParent, TSI.FList.Count);
end;

procedure TElMTreeItem.MoveToIns(NewParent: TElMTreeItem;
  AnIndex: Integer);
begin
  if (NewParent = self) or (NewParent = nil) then
    Exit;
  if Assigned(FParent) then
    FParent.FList.Remove(Self);
  if Assigned(NewParent) then
    NewParent.FList.Insert(AnIndex, Self);
  FParent := NewParent;
end;

end.
