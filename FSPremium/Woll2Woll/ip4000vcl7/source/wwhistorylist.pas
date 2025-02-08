unit wwhistorylist;
{
//
// Components : History Lists
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
//
// 5/16/2002 - PYW - History list was getting cleared in destroy, when control never loaded the list.
}
{$R-}

interface

uses Windows, Classes, SysUtils, Registry, IniFiles, wwcommon,
     wwintl, forms;

type
  TwwStorageType = (stRegistry, stIniFile);

  TwwHistoryList = class(TPersistent)
  private
    // Property Storage
    FEnabled: Boolean;
    FSection: string;
    FFileName: string;
    FMaxSize: Integer;
    FStorageType: TwwStorageType;
    FMRUEnabled: boolean;
    FMRUMaxSize: integer;

    FList: TStrings;
    FLoaded: Boolean; //5/16/2002
//    FSource: TStrings;
//    FSourceCopy: TStrings;

    // Accessors
    procedure SetEnabled(Enabled: Boolean);
    procedure SetSection(Section: string);
    function GetFileName: string;
    procedure SetFileName(FileName: string);
    procedure SetMaxSize(MaxSize: Integer);
    procedure SetStorageType(StorageType: TwwStorageType);

    procedure SetList(List: TStrings);
//    procedure SetSource(Source: TStrings);
  protected
    procedure SynchWithList(SynchList: TStrings);
//    procedure SynchList;
  public
    Owner: TComponent;
    property List: TStrings read FList write SetList;
//    property Source: TStrings read FSource write SetSource;

    // Create/Destroy
    procedure Load(SyncList: TStrings);
//    procedure AddMRU(SynchList: TStrings);
    constructor Create;
    destructor Destroy; override;
    procedure Save;

    // Storage Methods
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToRegistry(Value: string; Key: string;
      RootKey: DWORD);
    procedure LoadFromRegistry(SynchList: Tstrings; Value: string; Key: string;
      RootKey: DWORD);
    procedure SaveToIniFile(Section: string; IniFile: string );
    procedure LoadFromIniFile(SynchList: TStrings; Section: string; IniFile: string );
    function EffectiveMRUCount: integer;
  published
    property Section: string read FSection write SetSection;
    property FileName: string read GetFileName write SetFileName;
    property MaxSize: Integer read FMaxSize write SetMaxSize default -1;
    property StorageType: TwwStorageType read FStorageType write SetStorageType default stIniFile;
    property Enabled: Boolean read FEnabled write SetEnabled default false;
    property MRUEnabled: boolean read FMRUEnabled write FMRUEnabled default False;
    property MRUMaxSize: integer read FMRUMaxSize write FMRUMaxSize default 2;
  end;

implementation

uses wwstr;

//const
  // Default Registry Values
//  DEFAULT_KEY =     '\Software\Woll2Woll\Settings\HistoryList';
//  DEFAULT_ROOT =    HKEY_CURRENT_USER;
  // Default Ini Values
//  DEFAULT_FILE =    'wwHistoryList.ini';

constructor TwwHistoryList.Create;
begin
  inherited Create;

  FStorageType:= stIniFile;
  FMaxSize := -1;
  FList := TStringList.Create;
  FMRUEnabled:= False;
  FMRUMaxSize:= 2;
  FLoaded := False;  //5/16/2002
//  FSourceCopy := TStringList.Create;
end;

destructor TwwHistoryList.Destroy;
begin
  inherited;

  // 5/16/2002 - PYW - History list was getting cleared in destroy, when control never loaded the list.
  //                   So only save if control has loaded the list.
  if not (csDesigning in Owner.ComponentState) and (FLoaded) then Save;

  FList.Free;
  FList := nil;
//  FSourceCopy.Free;
//  FSourceCopy := nil;
//  FSource := nil;
end;

procedure TwwHistoryList.SynchWithList(SynchList: TStrings);
var i: Integer;
begin
  if (SynchList <> nil) then
  begin
    for i := 0 to FList.Count - 1 do
      if (SynchList.IndexOf(FList[i]) = -1) then
        SynchList.Add(FList[i]);
  end
end;

{
procedure TwwHistoryList.SynchList;
var i: Integer;
    Count: Integer;
begin
  exit;
  FList.Clear;

  Count := 0;
  if (FSource <> nil) then
    for i := 0 to FSource.Count - 1 do
      if (FSourceCopy.IndexOf(FSource[i]) = -1) and
         ((Count < MaxSize) or (MaxSize = -1)) then
      begin
        FList.Add(FSource[i]);
        inc(Count);
      end;
end;
}

procedure TwwHistoryList.SetList(List: TStrings);
begin
  FList.Assign(List);
end;

//procedure TwwHistoryList.SetSource(Source: TStrings);
//begin
//  FSource := Source;
//  FSourceCopy.Assign(Source);
//  SynchSource;
//end;

procedure TwwHistoryList.SetSection(Section: string);
begin
  if (FSection <> Section) then
  begin
    FSection := Section;
  end;
end;

function TwwHistoryList.GetFileName: string;
begin
   if FFileName = '' then begin
      result := wwInternational.IniFileName;
      if(FStorageType = stIniFile) and (Owner<>nil) then
         if (result = '') and not (csDesigning in Owner.ComponentState) then
            result := wwExtractFileNameOnly(Application.ExeName)+'.ini'
   end
   else result := FFileName;
end;

procedure TwwHistoryList.SetFileName(FileName: string);
begin
  if (FFileName <> FileName) then
  begin
    FFileName := FileName;
  end;
end;

procedure TwwHistoryList.SetMaxSize(MaxSize: Integer);
begin
  if (FMaxSize <> MaxSize) then
  begin
    FMaxSize := MaxSize;
  end;
end;

procedure TwwHistoryList.SetStorageType(StorageType: TwwStorageType);
begin
  if (FStorageType <> StorageType) then
  begin
    FStorageType := StorageType;
  end;
end;

procedure TwwHistoryList.SetEnabled(Enabled: Boolean);
begin
  if (FEnabled <> Enabled) then
  begin
    FEnabled := Enabled;
//    Load;
  end;
end;

procedure TwwHistoryList.Load(SyncList: TStrings);
var i: integer;
begin
  if (FSection <> '') and (FileName <> '') and (FStorageType <> TwwStorageType(-1)) then
  begin
    case FStorageType of
      stRegistry: LoadFromRegistry(SyncList, FSection, FileName, HKEY_CURRENT_USER);
      stIniFile: LoadFromIniFile(SyncList, FSection, FileName);
    end;
    FLoaded := True; //5/16/2002 - Only applicable for persistent history list.
  end
  else begin
     for i:= 0 to List.count-1 do begin
        if SyncList.IndexOf(List[i])<0 then
           SyncList.Add(List[i]);
     end;
  end;
end;

procedure TwwHistoryList.Save;
begin
  if (FSection <> '') and (FileName <> '') and (FStorageType <> TwwStorageType(-1)) then
  begin
    case FStorageType of
      stRegistry: SaveToRegistry(FSection, FileName, HKEY_CURRENT_USER);
      stIniFile: SaveToIniFile(FSection, FileName);
    end;
  end;
end;

procedure TwwHistoryList.SaveToStream(Stream: TStream);
var tempList: TStrings;
    i: Integer;
begin
//  SynchList;
  if FMaxSize>0 then begin
     tempList:= TStringList.create;
     try
        for i:= wwmax(FList.count-FMaxSize, 0) to List.count-1 do
           tempList.add(FList[i]);
        List.assign(tempList);
     finally
       tempList.Free;
     end;
  end;

  List.SaveToStream(Stream);
end;

procedure TwwHistoryList.LoadFromStream(Stream: TStream);
begin
  FList.LoadFromStream(Stream);
//  SynchSource;
end;

procedure TwwHistoryList.SaveToRegistry(Value: string; Key: string; RootKey: DWORD);
var Registry: TRegistry;
    Stream: TMemoryStream;
begin
//  SynchList;
  Stream := TMemoryStream.Create;
  try
    SaveToStream(Stream);

    Registry := TRegistry.Create;
    try
      Registry.RootKey := RootKey;
      Registry.OpenKey(Key, True);
      Registry.WriteBinaryData(Value, Stream.Memory^, Stream.Size);
    finally
      Registry.CloseKey;
      Registry.Free;
    end;
  finally
    Stream.Free;
  end;
end;

type
  TPointerStream = class(TMemoryStream)
  public
    constructor Create(Ptr: Pointer; Size: Integer);
  end;

constructor TPointerStream.Create(Ptr: Pointer; Size: Integer);
begin
  inherited Create;
  SetPointer(Ptr, Size);
end;

procedure TwwHistoryList.LoadFromRegistry(SynchList: TStrings;
    Value: string; Key: string; RootKey: DWORD);
var Registry: TRegistry;
    Size: Integer;
    Buffer: Pointer;
    Stream: TPointerStream;
    i: integer;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := RootKey;
    Registry.OpenKey(Key, True);

    Size := Registry.GetDataSize(Value);
    Buffer := AllocMem(Size);

    try
      Registry.ReadBinaryData(Value, Buffer^, Size);

      Stream := TPointerStream.Create(Buffer, Size);
      try
        LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    finally
      FreeMem(Buffer);
    end;
  finally
    Registry.CloseKey;
    Registry.Free;
  end;
  for i:= 0 to List.count-1 do begin
     if SynchList.IndexOf(List[i])<0 then
       SynchList.Add(List[i]);
  end;
//  SynchSource;
end;

procedure TwwHistoryList.SaveToIniFile(Section: string; IniFile: string);
var Ini: TIniFile;
    i: Integer;
begin
//  SynchList;

  Ini := TIniFile.Create(IniFile);
  try
    Ini.EraseSection(Section);
    if MaxSize>0 then
       for i:= wwmax(FList.count-FMaxSize, 0) to List.count-1 do
         Ini.WriteString(Section, IntToStr(i), FList[i])
    else
      for i := 0 to FList.Count - 1 do
        Ini.WriteString(Section, IntToStr(i), FList[i]);
//           tempList.add(FList[i]);
//    for i := 0 to FList.Count - 1 do
//      Ini.WriteString(Section, IntToStr(i), FList[i]);
  finally
    Ini.Free;
  end;
end;

procedure TwwHistoryList.LoadFromIniFile(SynchList: Tstrings; Section: string; IniFile: string);
var Ini: TIniFile;
    Names: TStringList;
    i: Integer;
begin
  Names := TStringList.Create;
  try
    Ini := TIniFile.Create(IniFile);
    try
      FList.Clear;
      Ini.ReadSection(Section, Names);
      for i := 0 to Names.Count - 1 do
        FList.Add(Ini.ReadString(Section, Names[i], ''));
    finally
      Ini.Free;
    end;
  finally
    Names.Free;
  end;
  for i:= 0 to List.count-1 do begin
     if SynchList.IndexOf(List[i])<0 then
       SynchList.Add(List[i]);
  end;
end;

function TwwHistoryList.EffectiveMRUCount: integer;
begin
   result:= 0;
   if enabled and MRUEnabled then
      result:= wwMin(MRUMaxSize, List.count);
end;

end.

