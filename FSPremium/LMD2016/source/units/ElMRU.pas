unit ElMRU;
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

ElMRU unit
----------
Most Recently Used items manager.

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  SysUtils,
  Messages,
  Graphics,
  Controls,
  Menus,
  ShlObj,

  Types,

  LMDTypes,
  ElMenus,
  ElComponent,
  LMDObjectList,
  ElVCLUtils,
  ElTools,
  ElIni;

type

  TElMRUEntry = class;
  TElMRUSection = class;

  TElMRU = class;
  TElMRUSections = class;

  TMRUChangeEvent = procedure(Sender : TObject; Section : TElMRUSection) of object;
  TMRUClickEvent = procedure(Sender : TObject; Entry : TElMRUEntry) of object;
  TMRUStreamEvent = procedure(Sender : TObject; Stream : TStream; Entry : TElMRUEntry) of object;

  TMRUAddMode = (mamAdd, mamInsert);

  TElMRUEntry = class
  private
    FName : string;
    FData : Integer;
    FOwner : TElMRUSection;
    FDefault: Boolean;
    FChecked: boolean;
    FPersistent: boolean;
    procedure SetName(value : string);
    procedure SetData(Value : integer);
    procedure SetDefault(Value: boolean);
    procedure SetChecked(Value: boolean);
  public
    property Name : string read FName write SetName;
    property Data : Integer read FData write SetData;
    property Section : TElMRUSection read FOwner;
    property Default: Boolean read FDefault write SetDefault;
    property Checked: boolean read FChecked write SetChecked;
    property Persistent: boolean read FPersistent write FPersistent;
  end;

  TElMRUSection = class(TCollectionItem)
  protected
    FTag: Integer;
    FAutoHide : Boolean;
    FCaption : string;
    FValues : TLMDObjectList;
    FCapacity : Integer;
    FName : string;
    FShowName : Boolean;
    FVisible : Boolean;
    FOwner : TElMRU;
    procedure SetName(newValue : string);
    procedure SetShowName(newValue : Boolean);
    procedure SetVisible(newValue : Boolean);
    function GetValue(index : integer) : TElMRUEntry;
    procedure SetCapacity(newValue : Integer);
    function GetCount : Integer;
    procedure OnEntryDelete(Sender : TObject; var Item : pointer);
    procedure SetCaption(newValue : string);
    procedure SetAutoHide(newValue : Boolean);
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;
    procedure Clear;

    property Count : Integer read GetCount;
    function Add(Name : string; Data : integer): TElMRUEntry; virtual;
    procedure Remove(Entry : TElMRUEntry); virtual;
    function EntryByName(Name : string) : TElMRUEntry;

    property Entries[index : integer] : TElMRUEntry read GetValue;
  published
    property Name : string read FName write SetName;
    property ShowCaption : Boolean read FShowName write SetShowName default false;
    property Visible : Boolean read FVisible write SetVisible default true;
    property Capacity : Integer read FCapacity write SetCapacity default 10;
    property Caption : string read FCaption write SetCaption;
    property AutoHide : Boolean read FAutoHide write SetAutoHide;
    property Tag: Integer read FTag write FTag;
  end;

  TElMRUSections = class(TCollection)
  private
    FMRU : TElMRU;
    function GetItem(index : integer) : TElMRUSection;
    procedure SetItem(index : integer; newValue : TElMRUSection);
  protected
    function GetOwner : TPersistent; override;
    procedure Update(Item : TCollectionItem); override;
  public
    constructor Create(MRU : TElMRU);
    function Add : TElMRUSection;
    property Items[index : integer] : TElMRUSection read GetItem write SetItem; default;
  end;

  TElMRU = class(TElComponent)
  private
    FStorage : TElIniFile;
    FShowAccel : Boolean;
    FAutoUpdate : Boolean;
    FAutoEnable : Boolean;
    FSections : TElMRUSections;
    FRecentMenu : TMenuItem;
    FAddMode : TMRUAddMode;
    FRemoveOnClick : Boolean;
    FAccelDelimiter : Char;
    FOnChange : TMRUChangeEvent;
    FOnClick : TMRUClickEvent;
    FOnSaveEntry : TMRUStreamEvent;
    FOnLoadEntry : TMRUStreamEvent;
    FPopupMenu : TPopupMenu;
    FStoragePath : string;
    FIgnoreDuplicates : Boolean;
    procedure SetStorage(newValue : TElIniFile);
    procedure SetIgnoreDuplicates(newValue : Boolean);
    procedure SetPopupMenu(newValue : TPopupMenu);
    procedure SetSections(newValue : TElMRUSections);
    procedure SetShowAccel(newValue : Boolean);
    procedure SetAutoUpdate(newValue : Boolean);
    procedure SetAutoEnable(newValue : Boolean);
    procedure SetRecentMenu(newValue : TMenuItem);
    procedure OnItemClick(Sender : TObject);
    procedure SetAccelDelimiter(newValue : Char);
  protected
    procedure TriggerChangeEvent(Section : TElMRUSection); virtual;
    procedure TriggerClickEvent(Entry : TElMRUEntry); virtual;
    procedure TriggerSaveEntryEvent(Stream : TStream; Entry : TElMRUEntry); virtual;
    procedure TriggerLoadEntryEvent(Stream : TStream; Entry : TElMRUEntry); virtual;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure RebuildMenu; virtual;
    procedure Restore;
    procedure Save;
    function SectionByName(Name : string) : TElMRUSection;
  published
    property AccelDelimiter : Char read FAccelDelimiter write SetAccelDelimiter default ' ';
    property AddMode : TMRUAddMode read FAddMode write FAddMode default mamInsert;
    property Sections : TElMRUSections read FSections write SetSections;
    property Storage : TElIniFile read FStorage write SetStorage;
    property StoragePath : string read FStoragePath write FStoragePath;
    property ShowAccel : Boolean read FShowAccel write SetShowAccel default true;
    property AutoUpdate : Boolean read FAutoUpdate write SetAutoUpdate default true;
    property AutoEnable : Boolean read FAutoEnable write SetAutoEnable default true;
    property RecentMenu : TMenuItem read FRecentMenu write SetRecentMenu;
    property PopupMenu : TPopupMenu read FPopupMenu write SetPopupMenu;
    property RemoveOnClick : Boolean read FRemoveOnClick write FRemoveOnClick default true;
    property IgnoreDuplicates : Boolean read FIgnoreDuplicates write SetIgnoreDuplicates default True;

    property OnChange : TMRUChangeEvent read FOnChange write FOnChange;
    property OnClick : TMRUClickEvent read FOnClick write FOnClick;
    property OnSaveEntry : TMRUStreamEvent read FOnSaveEntry write FOnSaveEntry;
    property OnLoadEntry : TMRUStreamEvent read FOnLoadEntry write FOnLoadEntry;
  end;

implementation
uses

  LMDProcs;

procedure TElMRUEntry.SetName(value : string);
begin
  if FName <> value then
  begin
    FName := value;

    FOwner.Changed(false);

  end;
end;

procedure TElMRUEntry.SetData(Value : integer);
begin
  if FData <> value then
  begin
    FData := value;

    FOwner.Changed(false);

  end;
end;

procedure TElMRUEntry.SetDefault(Value: boolean);
begin
  if Value<>FDefault then
  begin
    FDefault := Value;

    FOwner.Changed(false);

  end;
end;

procedure TElMRUEntry.SetChecked(Value: boolean);
begin
  if Value<>FChecked then
  begin
    FChecked := Value;

    FOwner.Changed(false);

  end;
end;

procedure TElMRUSection.SetName(newValue : string);
begin
  if (FName <> newValue) then
  begin
    FName := newValue;
    Changed(false);
  end; {if}
end;

procedure TElMRUSection.SetShowName(newValue : Boolean);
begin
  if (FShowName <> newValue) then
  begin
    FShowName := newValue;
    Changed(false);
  end; {if}
end;

procedure TElMRUSection.SetVisible(newValue : Boolean);
begin
  if (FVisible <> newValue) then
  begin
    FVisible := newValue;
    Changed(true);
  end; {if}
end;

function TElMRUSection.GetValue;
begin
  result := TElMRUEntry(FValues[index]);
end;

procedure TElMRUSection.SetCapacity(newValue : Integer);
begin
  if (FCapacity <> newValue) then
  begin
    FCapacity := newValue;
    if FValues.Count > FCapacity then
    begin
      Collection.BeginUpdate;
      if FOwner.FAddMode = mamInsert then
        while FValues.Count > FCapacity do
          FValues.Delete(FValues.Count - 1)
      else
        while FValues.Count > FCapacity do
          FValues.Delete(0);
      Collection.EndUpdate;
    end;
  end; {if}
end;

function TElMRUSection.GetCount : Integer;
begin
  result := FValues.Count;
end;

procedure TElMRU.SetShowAccel(newValue : Boolean);
begin
  if (FShowAccel <> newValue) then
  begin
    FShowAccel := newValue;
    if AutoUpdate and (Assigned(FRecentMenu) or Assigned(FPopupMenu)) then RebuildMenu;
    if not AutoUpdate then TriggerChangeEvent(nil);
  end; {if}
end;

procedure TElMRU.SetAutoUpdate(newValue : Boolean);
begin
  if (FAutoUpdate <> newValue) then
  begin
    FAutoUpdate := newValue;
    if AutoUpdate and (Assigned(FRecentMenu) or Assigned(FPopupMenu)) then RebuildMenu;
    if not AutoUpdate then TriggerChangeEvent(nil);
  end; {if}
end;

procedure TElMRU.SetAutoEnable(newValue : Boolean);
var
  i : integer;
begin
  if (FAutoEnable <> newValue) then
  begin
    FAutoEnable := newValue;
    if not Assigned(FRecentMenu) then exit;
    if FAutoEnable then
    begin
      FRecentMenu.Enabled := false;
      for i := 0 to FSections.Count - 1 do
      begin
        if FSections[i].Count > 0 then
        begin
          FRecentMenu.Enabled := true;
          break;
        end;
      end;
    end
    else
    begin
      FRecentMenu.Enabled := true;
    end;
  end; {if}
end;

function TElMRUSections.GetItem(index : integer) : TElMRUSection;
begin
  result := TElMRUSection(inherited GetItem(Index));
end;

procedure TElMRUSections.SetItem(index : integer; newValue : TElMRUSection);
begin
  inherited SetItem(Index, newValue);
end;

function TElMRUSections.GetOwner : TPersistent;
begin
  Result := FMRU;
end;

function TElMRUSections.Add : TElMRUSection;
begin
  result := TElMRUSection(inherited Add);
end;

procedure TElMRUSections.Update(Item : TCollectionItem);
begin
  inherited Update(Item);
  with FMRU do
  begin
    if AutoUpdate and (Assigned(FRecentMenu) or Assigned(FPopupMenu)) then RebuildMenu;
    if not AutoUpdate then TriggerChangeEvent(TElMRUSection(Item));
  end;
end;

constructor TElMRUSections.Create(MRU : TElMRU);
begin
  inherited Create(TElMRUSection);
  FMRU := MRU;
end;

procedure TElMRU.SetRecentMenu(newValue : TMenuItem);
begin
  if (FRecentMenu <> newValue) then
  begin
    FRecentMenu := newValue;
    if AutoUpdate and Assigned(FRecentMenu) then RebuildMenu;
  end; {if}
end;

procedure TElMRU.OnItemClick(Sender : TObject);
var
  Entry : TElMRUEntry;
  Section: TElMRUSection;
  i : integer;
  t: boolean;
  begin

  if Sender is TElMenuItem then
    i := TElMenuItem(Sender).Tag
  else
    i := TMenuItem(Sender).Tag;

  begin
    Entry := TElMRUEntry(i);
    Section := nil;
    if Entry = nil then exit;
    if FRemoveOnClick then
    begin
      i := Entry.FOwner.FValues.IndexOf(Entry);
      t := TElMRUEntry(Entry.FOwner.FValues.Items[i]).Persistent;
      if (i <> -1) and (not t) then
      begin
        Section := Entry.FOwner;
        Section.FValues.OnDelete := nil;
        Section.FValues.Delete(I);
      end;
    end;
    TriggerClickEvent(Entry);
    if Section <> nil then
    begin
      Section.FValues.OnDelete := Section.OnEntryDelete;
      Section.OnEntryDelete(Section.FValues, Pointer(Entry));
      end;
    RebuildMenu;
  end;
end;

procedure TElMRU.RebuildMenu;
var
  i, j : integer;
  Acc : char;
  Section : TElMRUSection;
  Entry : TElMRUEntry;
  Item : TMenuItem;
  ElItem : TElMenuItem;
  S : string;
  b : boolean;

begin
  if (AutoEnable) and Assigned(FRecentMenu) then
    FRecentMenu.Enabled := false;
  if (ComponentState * [csDesigning, csLoading] <> []) then exit;
  b := false;
  Acc := '0';
  if Assigned(FRecentMenu) then
  begin
    if FRecentMenu is TElMenuItem then
    begin
      while TElMenuItem(FRecentMenu).Count > 0 do
      begin
        ElItem := TElMenuItem(FRecentMenu)[0];
        TElMenuItem(FRecentMenu).Delete(0);
        ElItem.Free;
      end;
    end
    else
    begin
      while FRecentMenu.Count > 0 do
      begin
        Item := FRecentMenu[0];
        FRecentMenu.Delete(0);
        Item.Free;
      end;
    end;
  end;
  if Assigned(FPopupMenu) then
  begin
    if FPopupMenu is TElPopupMenu then
    begin
      while TElPopupMenu(FPopupMenu).Items.Count > 0 do
      begin
        Item := TElPopupMenu(FPopupMenu).Items[0];
        TElPopupMenu(FPopupMenu).Items.Delete(0);
        Item.Free;
      end;
    end
    else
    begin
      while FPopupMenu.Items.Count > 0 do
      begin
        Item := FPopupMenu.Items[0];
        FPopupMenu.Items.Delete(0);
        Item.Free;
      end;
    end;
  end;
  for i := 0 to FSections.Count - 1 do
  begin
    Section := FSections.Items[i];
    if not Section.Visible then Continue;
    if Section.FShowName then
    begin
      if Assigned(FRecentMenu) then
      begin
        if not (FRecentMenu is TElMenuItem) then
        begin
          Item := TMenuItem.Create(nil);
          Item.Caption := Section.FCaption;
          Item.Enabled := false;
          if (I > 0) then
            Item.Break := Menus.mbBarBreak;
          FRecentMenu.Add(Item);
          Item := TMenuItem.Create(nil);
          Item.Caption := '-';
          Item.Enabled := false;
          FRecentMenu.Add(Item);
        end
        else
        begin
          ElItem := TElMenuItem.Create(nil);
          ElItem.Caption := Section.FCaption;
          ElItem.Enabled := false;
          if (I > 0) then
            ElItem.Break := mbBarBreak;
          TElMenuItem(FRecentMenu).Add(ElItem);

          ElItem := TElMenuItem.Create(nil);
          ElItem.Caption := '-';
          ElItem.Enabled := false;
          TElMenuItem(FRecentMenu).Add(ElItem);
        end;
      end;

      if Assigned(FPopupMenu) then
      begin
        if not (FPopupMenu is TElPopupMenu) then
        begin
          Item := TMenuItem.Create(nil);
          Item.Caption := Section.FCaption;
          Item.Enabled := false;
          if (I > 0) then
            Item.Break := Menus.mbBarBreak;
          FPopupMenu.Items.Add(Item);
          Item := TMenuItem.Create(nil);
          Item.Caption := '-';
          Item.Enabled := false;
          FPopupMenu.Items.Add(Item);
        end
        else
        begin
          ElItem := TElMenuItem.Create(nil);
          ElItem.Caption := Section.FCaption;
          ElItem.Enabled := false;
          if (I > 0) then
            ElItem.Break := mbBarBreak;
          TElPopupMenu(FPopupMenu).Items.Add(ElItem);
          ElItem := TElMenuItem.Create(nil);
          ElItem.Caption := '-';
          ElItem.Enabled := false;
          TElPopupMenu(FPopupMenu).Items.Add(ElItem);
        end;
      end;
    end;
    for j := 0 to Section.Count - 1 do
    begin
      Entry := Section.Entries[j];
      S := '';
      if FShowAccel then
      begin
        if Acc <> #0 then
        begin
          S := '&' + Acc + FAccelDelimiter;
          if Acc = '9' then
            Acc := 'A'
          else if Acc = 'Z' then
            Acc := #0
          else
            Inc(Acc);
        end
        else
          S := ' ' + FAccelDelimiter;
      end;
      S := S + Entry.FName;

      if Assigned(FRecentMenu) then
      begin
        if not (FRecentMenu is TElMenuItem) then
        begin
          Item := TMenuItem.Create(nil);
          Item.Caption := S;
          Item.Default := Entry.Default;
          Item.Checked := Entry.Checked;
          Item.Enabled := true;
          if (J = 0) and (I > 0) and (not Section.FShowName) then
            Item.Break := Menus.mbBarBreak;
          Item.OnClick := OnItemClick;
          Item.Tag := TLMDPtrInt(Entry);
          FRecentMenu.Add(Item);
        end
        else
        begin
          ElItem := TElMenuItem.Create(nil);
          ElItem.Caption := S;
          ElItem.Default := Entry.Default;
          ElItem.Checked := Entry.Checked;
          ElItem.Enabled := true;
          if (J = 0) and (I > 0) and (not Section.FShowName) then
            ElItem.Break := mbBarBreak;
          ElItem.OnClick := OnItemClick;
          ElItem.Tag := TLMDPtrInt(Entry);
          TElMenuItem(FRecentMenu).Add(ElItem);
        end;
      end;

      if Assigned(FPopupMenu) then
      begin
        if not (FPopupMenu is TElPopupMenu) then
        begin
          Item := TMenuItem.Create(nil);
          Item.Caption := S;
          Item.Default := Entry.Default;
          Item.Checked := Entry.Checked;
          Item.Enabled := true;
          if (J = 0) and (I > 0) and (not Section.FShowName) then
            Item.Break := Menus.mbBarBreak;
          Item.OnClick := OnItemClick;
          Item.Tag := TLMDPtrInt(Entry);
          FPopupMenu.Items.Add(Item);
        end
        else
        begin
          ElItem := TElMenuItem.Create(nil);
          ElItem.Caption := S;
          ElItem.Default := Entry.Default;
          ElItem.Checked := Entry.Checked;
          ElItem.Enabled := true;
          if (J = 0) and (I > 0) and (not Section.FShowName) then
            ElItem.Break := mbBarBreak;
          ElItem.OnClick := OnItemClick;
          ElItem.Tag := TLMDPtrInt(Entry);
          TElPopupMenu(FPopupMenu).Items.Add(ElItem);
        end;
      end;

      b := true;
    end;
  end;
  if AutoEnable and Assigned(FRecentMenu) then
  begin
    if FRecentMenu is TElMenuItem then
      TElMenuItem(FRecentMenu).Enabled := b
    else
    FRecentMenu.Enabled := b;
  end;
end;

procedure TElMRU.SetSections(newValue : TElMRUSections);
begin
  if (FSections <> newValue) and Assigned(newValue) then FSections.Assign(newValue);
end;

procedure TElMRU.TriggerChangeEvent(Section : TElMRUSection);
begin
  if (assigned(FOnChange)) then FOnChange(Self, Section);
end;

procedure TElMRU.TriggerClickEvent(Entry : TElMRUEntry);
begin
  if (assigned(FOnClick)) then FOnClick(Self, Entry);
end;

procedure TElMRU.TriggerSaveEntryEvent(Stream : TStream; Entry : TElMRUEntry);
begin
  if (assigned(FOnSaveEntry)) then FOnSaveEntry(Self, Stream, Entry);
end;

procedure TElMRU.TriggerLoadEntryEvent(Stream : TStream; Entry : TElMRUEntry);
begin
  if (assigned(FOnLoadEntry)) then FOnLoadEntry(Self, Stream, Entry);
end;

procedure TElMRU.SetAccelDelimiter(newValue : Char);
begin
  if (FAccelDelimiter <> newValue) then
  begin
    FAccelDelimiter := newValue;
    if AutoUpdate and Assigned(FRecentMenu) then RebuildMenu;
  end; {if}
end;

function TElMRU.SectionByName(Name : string) : TElMRUSection;
var
  i : integer;
begin
  result := nil;
  for i := 0 to FSections.Count - 1 do
    if FSections[i].Name = Name then
    begin
      result := FSections[i];
      exit;
    end;
end;

procedure TElMRU.Restore;
var
  i, j, k : integer;
  Section : TElMRUSection;
  SList, SList1 : TStringList;
  Stream : TDirectMemoryStream;
  Entry : TElMRUEntry;
  p : pointer;
  FSaveMode : TMRUAddMode;
begin
  if not Assigned(FStorage) then exit;
  SList := nil;
  Stream := nil;
  SList1 := nil;
  FSaveMode := FAddMode;
  try
    FAddMode := mamAdd;
    FSections.BeginUpdate;
    SList1 := TStringList.Create;
    SList := TStringList.Create;
    Stream := TDirectMemoryStream.Create;
    if FStorage.OpenKey(FStoragePath + FStorage.Delimiter + Name, false) then
    begin
      FStorage.EnumSubKeys('', SList1);
      for i := 0 to SList1.Count - 1 do
      begin
        Section := SectionByName(SList1[i]);
        if Section <> nil then
        begin
          SList.Clear;
          if FStorage.ReadMultiString(SList1[i], 'Value', SList) then
          begin
            if Assigned(FOnLoadEntry) then
            begin
              for j := 0 to SList.Count - 1 do
              begin
                Entry := Section.Add('', 0);
                Stream.SetSize(0);
                if LMDStrToData(SList[j], p, k) then
                begin
                  Stream.SetPointer(p, k);
                  TriggerLoadEntryEvent(Stream, Entry);
                end;
              end;
            end
            else
              for j := 0 to SList.Count - 1 do
                Section.Add(SList[j], 0);
          end;
        end
        else
          FStorage.Delete('', SList1[i]);
      end;
    end;
  finally
    Stream.Free;
    SList.Free;
    SList1.Free;
    FSections.EndUpdate;
    FAddMode := FSaveMode;
  end;
end;

procedure TElMRU.Save;
var
  i, j : integer;
  Section : TElMRUSection;
  SList : TStringList;
  Stream : TDirectMemoryStream;
  b : boolean;

begin
  if not Assigned(FStorage) then exit;
  SList := nil;
  Stream := nil;
  b := FStorage.LazyWrite;
  FStorage.LazyWrite := true;
  try
    SList := TStringList.Create;
    Stream := TDirectMemoryStream.Create;
    for i := 0 to FSections.Count - 1 do
    begin
      Section := FSections[i];
      if not FStorage.OpenKey(FStoragePath + FStorage.Delimiter + Name + FStorage.Delimiter + Section.Name, true) then Continue;
      SList.Clear;
      for j := 0 to Section.Count - 1 do
      begin
        if Assigned(FOnSaveEntry) then
        begin
          Stream.SetSize(0);
          TriggerSaveEntryEvent(Stream, Section.Entries[j]);
          SList.Add(Data2Str(Stream.Memory, Stream.Size));
        end
        else
          SList.Add(Trim(Section.Entries[j].Name));
      end;
      FStorage.WriteMultiString('', 'Value', SList);
    end;
  finally
    SList.Free;
    Stream.Free;
  end;
  if not b then FStorage.Save;
  FStorage.LazyWrite := b;
end;

procedure TElMRU.SetPopupMenu(newValue : TPopupMenu);
begin
  if (FPopupMenu <> newValue) then
  begin
    FPopupMenu := newValue;
    if AutoUpdate and Assigned(FPopupMenu) then RebuildMenu;
  end; {if}
end;

procedure TElMRU.SetIgnoreDuplicates(newValue : Boolean);
begin
  if (FIgnoreDuplicates <> newValue) then
  begin
    FIgnoreDuplicates := newValue;
  end; {if}
end; {SetIgnoreDuplicates}

destructor TElMRU.Destroy;
begin
  FreeAndNil(FSections);
  inherited Destroy;
end;

constructor TElMRU.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FSections := TElMRUSections.Create(Self);
  FAddMode := mamInsert;
  FRemoveOnClick := true;
  FAutoUpdate := true;
  FAutoEnable := true;
  FAccelDelimiter := ' ';
  FShowAccel := true;
  FIgnoreDuplicates := True;
end;

procedure TElMRU.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FStorage) then
    Storage := nil;
end;

procedure TElMRU.SetStorage(newValue : TElIniFile);
begin
  if newValue <> FStorage then
  begin
    if FStorage <> nil then
      if not (csDestroying in FStorage.ComponentState) then
        FStorage.RemoveFreeNotification(Self);
    FStorage := newValue;
    if FStorage <> nil then FStorage.FreeNotification(Self);
  end;
end;

procedure TElMRU.Loaded;
begin
  inherited;
  RebuildMenu;
end;

destructor TElMRUSection.Destroy;
begin
  FValues.Free;
  inherited;
end;

constructor TElMRUSection.Create(Collection : TCollection);
begin
  inherited;
  FValues := TLMDObjectList.Create;
  FValues.OnDelete := Self.OnEntryDelete;
  FShowName := false;
  FVisible := true;
  FCapacity := 10;
  FOwner := TElMRUSections(Collection).FMRU;
end;

procedure TElMRUSection.OnEntryDelete;//(Sender : TObject; var Item : pointer);
var
  e: TElMRUEntry;
begin
  e := TElMRUEntry(Item);
  Item := nil;
  e.Free;
  //Changed(false);
end;

procedure TElMRUSection.SetCaption(newValue : string);
begin
  if (FCaption <> newValue) then
  begin
    FCaption := newValue;
    if FName = '' then FName := FCaption;
    Changed(false);
  end; {if}
end;

function TElMRUSection.Add(Name : string; Data : integer): TElMRUEntry;
var
  Entry : TElMRUEntry;
  i : integer;
begin
  if FOwner.FIgnoreDuplicates then
  begin
    for i := 0 to FValues.Count - 1 do
    begin
      if Uppercase(TElMRUEntry(FValues[i]).FName) = Uppercase(Name) then
      begin
        Result := TElMRUEntry(FValues[i]);
        Result.FData := Data;
        exit;
      end;
    end;
  end;
  // Add to shell recent docs
  SHAddToRecentDocs(SHARD_PATHA, int_ref(Name));

  Entry := TElMRUEntry.Create;
  Entry.FName := Name;
  Entry.FData := Data;
  Entry.FOwner := Self;
  if FOwner.FAddMode = mamInsert then
    FValues.Insert(0, Entry)
  else
    FValues.Add(Entry);
  if FAutoHide then FVisible := true;
  Collection.BeginUpdate;
  if FOwner.FAddMode = mamInsert then
    while FValues.Count > FCapacity do
      FValues.Delete(FValues.Count - 1)
  else
    while FValues.Count > FCapacity do
      FValues.Delete(0);
  Collection.EndUpdate;
  Changed(false);
  result := Entry;
end;

procedure TElMRUSection.Remove(Entry : TElMRUEntry);
begin
  FValues.Remove(Entry);
  if FAutoHide then FVisible := FValues.Count > 0;
  Changed(false);
end;

function TElMRUSection.EntryByName(Name : string) : TElMRUEntry;
var
  i : integer;
begin
  result := nil;
  for i := 0 to FValues.Count - 1 do
  begin
    if Entries[i].FName = Name then
    begin
      result := Entries[i];
      exit;
    end;
  end;
end;

procedure TElMRUSection.SetAutoHide(newValue : Boolean);
begin
  if (FAutoHide <> newValue) then
  begin
    FAutoHide := newValue;
    if FAutoHide then Visible := FValues.Count > 0;
  end; {if}
end;

procedure TElMRUSection.Assign(Source : TPersistent);
var
  i : integer;
begin
  if Source is TElMRUSection then
    with Source as TElMRUSection do
    begin
      Self.FAutoHide := FAutoHide;
      Self.FCaption := FCaption;
      Self.FName := FName;
      Self.FCapacity := FCapacity;
      Self.FShowName := FShowName;
      Self.FVisible := FShowName;
      for i := 0 to FValues.Count - 1 do
        Self.Add(Entries[i].FName, Entries[i].FData);
    end
  else
    inherited Assign(Source);
end;

procedure TElMRUSection.Clear;
begin
  FValues.Clear;
  Changed(False);
end;

end.
