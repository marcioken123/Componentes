unit LMDSysNetworkEnumerator;
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

LMDSysNetworkEnumerator unit (RM, AH)
-------------------------------------

ToDo
----
AssignValues --> Images for other states

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, ComCtrls,
  LMDSysBase, LMDSysNetTreeView;

type
  TLMDSysNetDisplay = (ndDomain, ndGeneric, ndServer, ndShare, ndFile, ndGroup,
                       ndNetwork, ndRoot, ndShareAdmin, ndDirectory, ndTree,
                       ndNDSContainer);
  TLMDSysNetScope=(nsGlobal, nsContext, nsConnected, nsRemembered, nsRecent);
  TLMDSysNetResourceType=(nrAny, nrDisk, nrPrint);

  TLMDSysNetUsage=(nuConnectable, nuContainer);
  TLMDSysNetUsages = set of TLMDSysNetUsage;

  TLMDSysNetItems = class;

  TLMDSysNetItem = class
  private
    FScope: TLMDSysNetScope;
    FResourceType: TLMDSysNetResourceType;
    FDisplay: TLMDSysNetDisplay;
    FUsage: TLMDSysNetUsages;
    FIndex: Integer;
    FLocalName: string;
    FRemoteName: string;
    FComment: string;
    FProvider: string;
    FSubItems: TLMDSysNetItems;
  public
    constructor Create;
    destructor Destroy; override;
    property Comment: string read FComment;
    property Display: TLMDSysNetDisplay read FDisplay;
    property Index:Integer read FIndex;
    property LocalName: string read FLocalName;
    property Provider: string read FProvider;
    property SubItems: TLMDSysNetItems read FSubItems;
    property Scope: TLMDSysNetScope read FScope;
    property RemoteName: string read FRemoteName;
    property ResourceType: TLMDSysNetResourceType read FResourceType;
    property Usage: TLMDSysNetUsages read FUsage;
  end;

  TLMDSysNetItems=class
  private
    FList: TList;
    procedure SetItem(Index: Integer;Value:TLMDSysNetItem);
    function GetItem(Index: Integer):TLMDSysNetItem;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(Item: TLMDSysNetItem);
    procedure Delete(Index:Integer);
    property Items[Index: Integer]: TLMDSysNetItem read GetItem write SetItem; default;
    property Count: Integer read GetCount;
  end;

  TLMDSysNetworkEnumerator=class;

  TLMDSysNetItemEvent=procedure(Sender:TObject; anItem:TLMDSysNetItem) of object;
  TLMDSysNetThread = class(TThread)
  private
     FTreeNode: TTreeNode;
     Parent:TLMDSysNetworkEnumerator;
     NewItem: TLMDSysNetItem;
     // 7.01
     FOnEnumItem:TLMDSysNetItemEvent;
     // ---
  protected
     procedure Execute; override;
     procedure DoItemEvent;
  public
     procedure AddNode;
     procedure EnumNodes(NetItems: TLMDSysNetItems; lpnr: PNetResource);
     constructor Create(Owner:TLMDSysNetworkEnumerator);
  end;

  TLMDSysNetworkEnumerator=class(TLMDSysComponent)
  private
    FItems: TLMDSysNetItems;
    FInternal:TList;
    FScope: TLMDSysNetScope;
    FResourceType: TLMDSysNetResourceType;
    FUsage: TLMDSysNetUsages;
    FTree: TLMDSysNetTreeView;
    FThread: TLMDSysNetThread;
    FAuto,
    FThreaded,
    FShowRoot: Boolean;
    FTreeNode:TTreeNode;
    FOnEnumStart,
    FOnEnumEnd:TNotifyEvent;
    FOnEnumItem:TLMDSysNetItemEvent;
    function GetItem(Index:Integer):TLMDSysNetItem;
    function CheckStates:Boolean;
    procedure SetTreeView(const Value: TLMDSysNetTreeView);
    procedure SetThreaded(const Value: Boolean);
    procedure ThreadDone(Sender:TObject);
    procedure SetScope(const Value: TLMDSysNetScope);
    procedure SetUsage(const Value: TLMDSysNetUsages);
    procedure SetResourceType(const Value: TLMDSysNetResourceType);
    procedure SetShowRoot(const Value: Boolean);
    function GetIdxCount: Integer;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure AssignValues(Target:TTreeNode; Value:TLMDSysNetItem);
    procedure EnumerateNet(NetItems: TLMDSysNetItems; lpnr: PNetResource);
    procedure Loaded;override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure Refresh;
    procedure CancelThread;
    // direct access to items, indexed
    property ItemIdx[Index:Integer]:TLMDSysNetItem read GetItem;default;
    property ItemIdxCount:Integer read GetIdxCount;

    // network tree
    property Items: TLMDSysNetItems read FItems;
  published
    property AutoRetrieve:Boolean read FAuto write FAuto default true;
    property DisplayControl: TLMDSysNetTreeView read FTree write SetTreeView;
    property Scope: TLMDSysNetScope read FScope write SetScope default nsGlobal;
    property ResourceType: TLMDSysNetResourceType read FResourceType write SetResourceType default nrAny;
    property ShowRoot:Boolean read FShowRoot write SetShowRoot default false;
    property Usage: TLMDSysNetUsages read FUsage write SetUsage default [];
    property Threaded:Boolean read FThreaded write SetThreaded default false;

    property OnEnumStart:TNotifyEvent read FOnEnumStart write FOnEnumStart;
    property OnEnumEnd:TNotifyEvent read FOnEnumEnd write FOnEnumEnd;
    // 7.01
    property OnEnumItem:TLMDSysNetItemEvent read FOnEnumItem write FOnEnumItem;
    // ---
  end;

implementation
uses
  SysUtils,
  LMDSysConst
  ;

const
  NetBufSize=16384;

// from Windows.pas
type
  PNetResourceArray = ^TNetResourceArray;
  TNetResourceArray = array[0..0] of TNetResource;
  {*************************** TLMDSysNetThread *********************************}
{----------------------------- public -----------------------------------------}
constructor TLMDSysNetThread.Create(Owner: TLMDSysNetworkEnumerator);
begin
  {$IFNDEF LMDCOMP9}
  Parent:=Owner;
  FreeOnTerminate:=True;
  {$ENDIF}
  inherited Create(false);
  {$IFDEF LMDCOMP9}
  Parent:=Owner;
  FreeOnTerminate:=True;
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetThread.AddNode;
begin
  FTreeNode:=Parent.DisplayControl.Items.AddChild(FTreeNode, NewItem.RemoteName);
  Parent.AssignValues(FTreeNode, NewItem);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetThread.DoItemEvent;
begin
 if Assigned(FOnEnumItem) then
   FOnEnumItem(Parent, Newitem);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetThread.Execute;

begin
  if Assigned(Parent.DisplayControl) and Parent.ShowRoot then
    FTreeNode:=Parent.DisplayControl.Items[0]
  else
    FTreeNode:=nil;
  EnumNodes(Parent.FItems, nil);
  end;

{------------------------------------------------------------------------------}

procedure TLMDSysNetThread.EnumNodes(NetItems: TLMDSysNetItems; lpnr: PNetResource);

var
  dwResult, dwResultEnum: Integer;
  hEnum: THandle;
  cbBuffer, cEntries,
  dwScope, dwType, dwUsage:DWORD;
  i: Integer;
  NRArray: PNetResourceArray;
  tmp:TTreeNode;
  begin
  cbBuffer := NetBufSize;
  cEntries := $FFFFFFFF;  // all entries
  dwScope:=RESOURCE_GLOBALNET;
  dwType:=RESOURCETYPE_ANY;

  case Parent.Scope of
    nsConnected:dwScope := RESOURCE_CONNECTED;
    nsRemembered:dwScope := RESOURCE_REMEMBERED;
    nsContext:dwScope := RESOURCE_CONTEXT;
  end;

  case Parent.ResourceType of
    nrDisk:dwType:=RESOURCETYPE_DISK;
    nrPrint:dwType:=RESOURCETYPE_PRINT;
  end;

  dwUsage := 0;
  if nuConnectable in Parent.Usage then
    dwUsage:=dwUsage or RESOURCEUSAGE_CONNECTABLE;
  if nuContainer in Parent.Usage then
    dwUsage:=dwUsage or RESOURCEUSAGE_CONTAINER;

  dwResult:=WNetOpenEnum(dwScope, dwType, dwUsage, lpnr, hEnum);
  if dwResult <> NO_ERROR then Exit;

  GetMem(nrArray, cbBuffer);
  try
    repeat
      if Terminated then exit;
      dwResultEnum := WNetEnumResource(hEnum, cEntries, nrArray, cbBuffer);
      if dwResultEnum = NO_ERROR then
      begin
        for i := 0 to cEntries - 1 do
          begin
            NewItem := TLMDSysNetItem.Create;
            tmp:=FTreeNode;
            case nrArray[i].dwScope of
              RESOURCE_CONNECTED:  NewItem.FScope:=nsConnected;
              RESOURCE_GLOBALNET:  NewItem.FScope:=nsGlobal;
              RESOURCE_REMEMBERED: NewItem.FScope:=nsRemembered;
              RESOURCE_CONTEXT:    NewItem.FScope:=nsContext;
            else
              NewItem.FScope := nsGlobal;
            end;

            case nrArray[i].dwType of
              RESOURCETYPE_ANY:   NewItem.FResourceType:=nrAny;
              RESOURCETYPE_DISK:  NewItem.FResourceType:=nrDisk;
              RESOURCETYPE_PRINT: NewItem.FResourceType:=nrPrint;
            else
              NewItem.FResourceType := nrAny;
            end;

            case nrArray[i].dwDisplayType of
              RESOURCEDISPLAYTYPE_GENERIC:      NewItem.FDisplay:=ndGeneric;
              RESOURCEDISPLAYTYPE_DOMAIN:       NewItem.FDisplay:=ndDomain;
              RESOURCEDISPLAYTYPE_SERVER:       NewItem.FDisplay:=ndServer;
              RESOURCEDISPLAYTYPE_SHARE:        NewItem.FDisplay:=ndShare;
              RESOURCEDISPLAYTYPE_FILE:         NewItem.FDisplay:=ndFile;
              RESOURCEDISPLAYTYPE_GROUP:        NewItem.FDisplay:=ndGroup;
              RESOURCEDISPLAYTYPE_NETWORK:      NewItem.FDisplay:=ndNetwork;
              RESOURCEDISPLAYTYPE_ROOT:         NewItem.FDisplay:=ndRoot;
              RESOURCEDISPLAYTYPE_SHAREADMIN:   NewItem.FDisplay:=ndShareAdmin;
              RESOURCEDISPLAYTYPE_DIRECTORY:    NewItem.FDisplay:=ndDirectory;
              RESOURCEDISPLAYTYPE_TREE:         NewItem.FDisplay:=ndTree;
              RESOURCEDISPLAYTYPE_NDSCONTAINER: NewItem.FDisplay:=ndNDSContainer;
            else
              NewItem.FDisplay := ndGeneric;
            end;

            NewItem.FUsage := [];
            if nrArray[i].dwUsage and RESOURCEUSAGE_CONNECTABLE<>0 then Include(NewItem.FUsage, nuConnectable);
            if nrArray[i].dwUsage and RESOURCEUSAGE_CONTAINER <> 0 then Include(NewItem.FUsage, nuContainer);

            NewItem.FLocalName:=StrPas(nrArray[i].lpLocalName);
            NewItem.FRemoteName:=StrPas(nrArray[i].lpRemoteName);
            NewItem.FComment:=StrPas(nrArray[i].lpComment);
            NewItem.FProvider:=StrPas(nrArray[i].lpProvider);
            Parent.FInternal.Add(NewItem);
            NewItem.FIndex:=Parent.FInternal.Count;
            NetItems.Add(NewItem);

            // suggested by Hugo Logmans, 01-04-2004
            if Assigned(FOnEnumItem) then
              Synchronize(DoItemEvent);
            if Assigned(Parent.DisplayControl) and (NewItem.RemoteName<>'') then
              Synchronize(AddNode);

            // if container, call recursively
            if (nuContainer in NewItem.FUsage) and (Parent.Scope<>nsContext) then
              EnumNodes(NewItem.FSubItems, @nrArray[i]);
              FTreeNode:=tmp;
            end;
      end;
    until dwResultEnum = ERROR_NO_MORE_ITEMS;
  finally
    FreeMem(nrArray);
    WNetCloseEnum(hEnum);
  end;
end;

{ **************************** TLMDSysNetItem ******************************** }
{ ------------------------------- private ------------------------------------ }
{ ------------------------------- public ------------------------------------- }
constructor TLMDSysNetItem.Create;
begin
  inherited;
  FSubItems:=TLMDSysNetItems.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDSysNetItem.Destroy;
begin
  FreeAndNil(FSubItems);
  inherited;
end;

{ **************************** TLMDSysNetItems ******************************* }
{ ------------------------------- private ------------------------------------ }
procedure TLMDSysNetItems.SetItem(Index:Integer;Value:TLMDSysNetItem);
begin
  if Assigned(FList.Items[Index]) and (FList.Items[Index]<>Value) then
    TLMDSysNetItem(FList.Items[Index]).Free;
  FList.Items[Index]:=Value;
end;

{------------------------------------------------------------------------------}
function TLMDSysNetItems.GetItem(Index:Integer):TLMDSysNetItem;
begin
  result:=TLMDSysNetItem(FList.Items[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDSysNetItems.GetCount:Integer;
begin
  if Assigned(FList) then
    result:=FList.Count
  else
    result:=0;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDSysNetItems.Create;
begin
  inherited;
  FList:=TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDSysNetItems.Destroy;
begin
  Clear;
  if FList<>nil then
    FList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetItems.Clear;
begin
  while Count>0 do Delete(0);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetItems.Add(Item: TLMDSysNetItem);
begin
  FList.Add(Item);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetItems.Delete(Index:Integer);
begin
  if Assigned(FList.Items[Index]) then
    TLMDSysNetItem(FList.Items[Index]).Free;
  FList.Delete(Index);
end;

{ *********************** TLMDSysNetworkEnumerator *************************** }
{ ------------------------------- private ------------------------------------ }
function TLMDSysNetworkEnumerator.CheckStates: Boolean;
begin
  result:=not ((csDesigning in ComponentState) or (csLoading in ComponentState) or
              (csDestroying in ComponentState));
end;

{------------------------------------------------------------------------------}
function TLMDSysNetworkEnumerator.GetIdxCount: Integer;
begin
  result:=FInternal.Count;
end;

{------------------------------------------------------------------------------}
function TLMDSysNetworkEnumerator.GetItem(Index: Integer): TLMDSysNetItem;
begin
  result:=TLMDSysNetItem(FInternal[Index-1]);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.SetTreeView(const Value: TLMDSysNetTreeView);
begin
  if FTree<>Value then
    begin
      FTree:=Value;
      if FTree<>nil then
        FTree.FreeNotification(Self);
      if CheckStates then Refresh;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.SetThreaded(const Value: Boolean);
begin
  if FThreaded<>Value then
    begin

      if FThreaded and (FThread<>nil) and not ((csDesigning in ComponentState) or (csLoading in ComponentState)) then
        begin
          FThread.Terminate;
          FThread.WaitFor;
          FThread:=nil;
        end;

      FThreaded:=Value;

      if CheckStates then Refresh;
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.SetResourceType(const Value: TLMDSysNetResourceType);
begin
  if FResourceType<>Value then
    begin
      FResourceType := Value;
      if CheckStates then Refresh;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.SetShowRoot(const Value: Boolean);
begin
  if FShowRoot<>Value then
    begin
      FShowRoot := Value;
      if CheckStates then Refresh;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.SetScope(const Value: TLMDSysNetScope);
begin
  if FScope<>Value then
    begin
      FScope:= Value;
      if CheckStates then Refresh;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.SetUsage(const Value: TLMDSysNetUsages);
begin
  if FUsage<>Value then
    begin
      FUsage:=Value;
      if CheckStates then Refresh;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.ThreadDone(Sender: TObject);
begin
  FThread:=nil;
  if Assigned(FOnEnumEnd) then FOnEnumEnd(self);
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDSysNetworkEnumerator.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) and (aComponent = FTree) then
    DisplayControl:=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.AssignValues(Target: TTreeNode; Value: TLMDSysNetItem);
var
  img:Integer;
begin
  img:=-1;
  case Value.Display of
     ndDomain: img:=2;
     ndGeneric: ;
     ndServer: img:=3;
     ndShare:
       case Value.ResourceType of
         nrDisk: img:=4;
         nrPrint: img:=5;
       end;
     ndNetwork: img:=1;
   end;

  Target.ImageIndex:=img;
  Target.SelectedIndex:=img;
  Target.Data := Pointer(Value.Index);
  end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.Loaded;
begin
  inherited;
  if FAuto and not (csDesigning in ComponentState) then
    Refresh;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDSysNetworkEnumerator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAuto:=True;
  FItems:=TLMDSysNetItems.Create;
  FInternal:=TList.Create;
  FScope:=nsGlobal;
  FResourceType := nrAny;
  FUsage:=[];
end;

{------------------------------------------------------------------------------}
destructor TLMDSysNetworkEnumerator.Destroy;
begin
  CancelThread;
  FreeAndNil(FInternal);
  FreeAndNil(FItems);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.CancelThread;
begin
  if FThread<>nil then
    begin
      FThread.Terminate;
      FThread.WaitFor;
      FThread:=nil;
    end;
end;
procedure TLMDSysNetworkEnumerator.Refresh;

begin
  CancelThread;

  Clear;

  if FShowRoot and Assigned(FTree) then
    begin
      FTreeNode:=FTree.Items.Add(nil, sLMDSysNetwork);
      FTreeNode.ImageIndex:=0;
      FTreeNode.SelectedIndex:=0;
    end
  else
    FTreeNode:=nil;

  if Assigned(FOnEnumStart) then FOnEnumStart(self);

  if FThreaded then
    begin
      FThread:=TLMDSysNetThread.Create(self);
      FThread.FOnEnumItem:=FOnEnumItem;
      FThread.OnTerminate:=ThreadDone;
    end
  else
    EnumerateNet(FItems, nil);
    end;

{------------------------------------------------------------------------------}
procedure TLMDSysNetworkEnumerator.Clear;
begin
  if FThreaded and (FThread<>nil) then exit;
  if Assigned(FTree) then
    FTree.Items.Clear;
  FInternal.Clear;
  FItems.Clear;
end;

{------------------------------------------------------------------------------}

procedure TLMDSysNetworkEnumerator.EnumerateNet(NetItems: TLMDSysNetItems; lpnr: PNetResource);

var
  dwResult, dwResultEnum: Integer;
  hEnum: THandle;
  cbBuffer, cEntries,
  dwScope, dwType, dwUsage:DWORD;
  i: Integer;
  NRArray: PNetResourceArray;
  NewItem: TLMDSysNetItem;
  tmp:TTreeNode;
  begin
  cbBuffer := NetBufSize;
  cEntries := $FFFFFFFF;
  dwScope:=RESOURCE_GLOBALNET;
  dwType:=RESOURCETYPE_ANY;

  case FScope of
    nsConnected: dwScope := RESOURCE_CONNECTED;
    //nsGlobal: dwScope := RESOURCE_GLOBALNET;
    nsRemembered: dwScope := RESOURCE_REMEMBERED;
    nsContext: dwScope := RESOURCE_CONTEXT;
    nsRecent: dwScope :=RESOURCE_RECENT;
  end;

  case FResourceType of
    //nrAny: dwType := RESOURCETYPE_ANY;
    nrDisk: dwType := RESOURCETYPE_DISK;
    nrPrint: dwType := RESOURCETYPE_PRINT;
  end;

  dwUsage := 0;
  if nuConnectable in FUsage then
    dwUsage := dwUsage or RESOURCEUSAGE_CONNECTABLE;
  if nuContainer in FUsage then
    dwUsage := dwUsage or RESOURCEUSAGE_CONTAINER;

  dwResult := WNetOpenEnum(dwScope, dwType, dwUsage, lpnr, hEnum);
  if dwResult <> NO_ERROR then Exit;

  GetMem(nrArray, cbBuffer);
  try
    repeat
      dwResultEnum := WNetEnumResource(hEnum, cEntries, nrArray, cbBuffer);
      if dwResultEnum = NO_ERROR then
      begin
        for i := 0 to cEntries-1 do
          begin
            NewItem := TLMDSysNetItem.Create;
            tmp:=FTreeNode;
            case nrArray[i].dwScope of
              RESOURCE_CONNECTED:  NewItem.FScope:=nsConnected;
              RESOURCE_GLOBALNET:  NewItem.FScope:=nsGlobal;
              RESOURCE_REMEMBERED: NewItem.FScope:=nsRemembered;
              RESOURCE_CONTEXT:    NewItem.FScope:=nsContext;
              RESOURCE_RECENT:      NewItem.FScope:=nsRecent;
            else
              NewItem.FScope := nsGlobal;
            end;

            case nrArray[i].dwType of
              RESOURCETYPE_ANY:   NewItem.FResourceType:=nrAny;
              RESOURCETYPE_DISK:  NewItem.FResourceType:=nrDisk;
              RESOURCETYPE_PRINT: NewItem.FResourceType:=nrPrint;
            else
              NewItem.FResourceType := nrAny;
            end;

            case nrArray[i].dwDisplayType of
              RESOURCEDISPLAYTYPE_GENERIC:      NewItem.FDisplay:=ndGeneric;
              RESOURCEDISPLAYTYPE_DOMAIN:       NewItem.FDisplay:=ndDomain;
              RESOURCEDISPLAYTYPE_SERVER:       NewItem.FDisplay:=ndServer;
              RESOURCEDISPLAYTYPE_SHARE:        NewItem.FDisplay:=ndShare;
              RESOURCEDISPLAYTYPE_FILE:         NewItem.FDisplay:=ndFile;
              RESOURCEDISPLAYTYPE_GROUP:        NewItem.FDisplay:=ndGroup;
              RESOURCEDISPLAYTYPE_NETWORK:      NewItem.FDisplay:=ndNetwork;
              RESOURCEDISPLAYTYPE_ROOT:         NewItem.FDisplay:=ndRoot;
              RESOURCEDISPLAYTYPE_SHAREADMIN:   NewItem.FDisplay:=ndShareAdmin;
              RESOURCEDISPLAYTYPE_DIRECTORY:    NewItem.FDisplay:=ndDirectory;
              RESOURCEDISPLAYTYPE_TREE:         NewItem.FDisplay:=ndTree;
              RESOURCEDISPLAYTYPE_NDSCONTAINER: NewItem.FDisplay:=ndNDSContainer;
            else
              NewItem.FDisplay := ndGeneric;
            end;

            NewItem.FUsage := [];
            if nrArray[i].dwUsage and RESOURCEUSAGE_CONNECTABLE<>0 then Include(NewItem.FUsage, nuConnectable);
            if nrArray[i].dwUsage and RESOURCEUSAGE_CONTAINER <> 0 then Include(NewItem.FUsage, nuContainer);

            NewItem.FLocalName := StrPas(nrArray[i].lpLocalName);
            NewItem.FRemoteName := StrPas(nrArray[i].lpRemoteName);
            NewItem.FComment := StrPas(nrArray[i].lpComment);
            NewItem.FProvider := StrPas(nrArray[i].lpProvider);
            FInternal.Add(NewItem);
            NewItem.FIndex:=FInternal.Count;
            NetItems.Add(NewItem);

            if Assigned(FTree) and (NewItem.FRemoteName<>'') then
              begin
                FTreeNode:=FTree.Items.AddChild(FTreeNode, NewItem.FRemoteName);
                AssignValues(FTreeNode, NewItem);
              end;

            // Hugo Logmans, 01-04-2004
            if Assigned(FOnEnumItem) then
              FOnEnumitem(self, NewItem);
            // if container, call recursively
            if (nuContainer in NewItem.FUsage) and (FScope<>nsContext) then
              EnumerateNet(NewItem.FSubItems, @nrArray[i]);
              FTreeNode:=tmp;
            end;
      end;
    until dwResultEnum = ERROR_NO_MORE_ITEMS;
  finally
    FreeMem(nrArray);
    WNetCloseEnum(hEnum);
  end;

  if (NetItems=FItems) and Assigned(FOnEnumEnd) then FOnEnumEnd(self);

end;

end.
