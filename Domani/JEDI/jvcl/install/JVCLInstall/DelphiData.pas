{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: DelphiData.pas, released on 2004-03-29.

The Initial Developer of the Original Code is Andreas Hausladen
(Andreas dott Hausladen att gmx dott de)
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL
home page, located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: DelphiData.pas,v 1.25 2006/01/26 23:24:38 ahuser Exp $

unit DelphiData;

{$I jvcl.inc}
{$I windowsonly.inc}

interface

uses
  Windows, SysUtils, Classes, Contnrs, Registry, ShlObj;

const
  BDSVersions: array[1..4] of record
                                Name: string;
                                VersionStr: string;
                                Version: Integer;
                                CIV: string; // coreide version
                                ProjectDirResId: Integer;
                                Supported: Boolean;
                              end = (
    (Name: 'C#Builder'; VersionStr: '1.0'; Version: 1; CIV: '71'; ProjectDirResId: 64507; Supported: False),
    (Name: 'Delphi'; VersionStr: '8'; Version: 8; CIV: '71'; ProjectDirResId: 64460; Supported: False),
    (Name: 'Delphi'; VersionStr: '2005'; Version: 9; CIV: '90'; ProjectDirResId: 64431; Supported: True),
    (Name: 'Borland Developer Studio'; VersionStr: '2006'; Version: 10; CIV: '100'; ProjectDirResId: 64719; Supported: True)
  );

type
  TPersonalityType = (
    persDelphi, persDelphiNet,
    persBCB, persManagedCpp,
    persCSharp, persVisualBasic
  );
  TPersonalities = set of TPersonalityType;

const
  PersNames: array[TPersonalityType] of string = (
    'Delphi.Win32', 'Delphi.NET', 'BCB', 'BCB.NET'{???}, 'C#Builder', 'VB.NET'
  );

type
  TCompileTarget = class;
  TCompileTargetList = class;
  TDelphiPackage = class;
  TDelphiPackageList = class;

  TCompileTargetList = class(TObjectList)
  private
    function GetItems(Index: Integer): TCompileTarget;
    procedure LoadTargets(const SubKey, HKCUSubKey: string);
    function IsBDSSupported(const IDEVersionStr: string): Boolean;
  public
    constructor Create;
    property Items[Index: Integer]: TCompileTarget read GetItems; default;
  end;


  TCompileTarget = class(TObject)
  private
    FName: string;
    FIDEName: string;
    FLatestRTLPatch: Integer;
    FLatestUpdate: Integer;
    FIDEVersion: Integer;
    FIDEVersionStr: string;
    FVersion: Integer;
    FVersionStr: string;
    FExecutable: string;
    FEdition: string;
    FRootDir: string;
    FBDSProjectsDir: string;
    FBrowsingPaths: TStringList;
    FDCPOutputDir: string;
    FBPLOutputDir: string;
    FPackageSearchPaths: TStringList;
    FSearchPaths: TStringList;
    FDisabledPackages: TDelphiPackageList;
    FKnownPackages: TDelphiPackageList;
    FKnownIDEPackages: TDelphiPackageList;
    FHKLMRegistryKey: string;
    FRegistryKey: string;
    FDebugDcuPaths: TStringList;
    FInstalledPersonalities: TStrings;
    FGlobalIncludePaths: TStringList;
    FGlobalCppSearchPaths: TStringList;

    procedure LoadFromRegistry;
    function ReadBDSProjectsDir: string;
    procedure LoadPackagesFromRegistry(APackageList: TDelphiPackageList;
      const SubKey: string);
    procedure SavePackagesToRegistry(APackageList: TDelphiPackageList;
      const SubKey: string);
    function GetHomepage: string;
    procedure GetBDSVersion(out Name: string; out Version: Integer; out VersionStr: string);
    function GetMake: string;
    function GetBplDir: string;
    function GetDcpDir: string;
    function GetProjectDir: string;
    function IsBCB: Boolean;
    function IsDelphi: Boolean;
  public
    constructor Create(const AName, AVersion, ARegSubKey: string);
    destructor Destroy; override;

    function IsBDS: Boolean;
    function IsPersonal: Boolean;
    function DisplayName: string;

    function SupportedPersonalities: TPersonalities;
      { SupportedPersonalities returns all installed personalities for the
        target. Delphi/BCB < 9.0 return either [persDelphi] or [persBCB]. }
    function SupportsPersonalities(Personalities: TPersonalities; Exact: Boolean = False): Boolean;
      { SupportsPersonalities tests if the target supports all specified
        personalities if Exact=False. If Exact=True the target must exactly
        support all specified personalities, nothing less, nothing more. }

    function VersionedDCP(const Filename: string): string;
      { returns the filename + version + extension for Delphi 5 and BCB 5
        else it returns the Filename. }
    function VersionedBPL(const Filename: string): string;
      { returns the filename + version + extension. }

    function TargetType: string;
      { return 'D' for Delphi, 'C' for C++ and ?? for BDS }

    function FindPackage(const PackageName: string): TDelphiPackage;
    function FindPackageEx(const PackageNameStart: string): TDelphiPackage;
    function ExpandDirMacros(const Dir: string): string;
    function InsertDirMacros(const Dir: string): string;

    procedure SavePaths;
      { writes BrowsingPaths and SearchPaths to the registry }
    procedure SavePackagesLists;
      { writes KnownPackages and DisabledPackages to the registry }

    property Homepage: string read GetHomepage;
    property RegistryKey: string read FRegistryKey;
    property HKLMRegistryKey: string read FHKLMRegistryKey;

    property Make: string read GetMake;

    property Name: string read FName;
    property Version: Integer read FVersion;
    property VersionStr: string read FVersionStr;
    property IDEName: string read FIDEName;
    property IDEVersion: Integer read FIDEVersion;
    property IDEVersionStr: string read FIDEVersionStr;
    property Executable: string read FExecutable; // [Reg->App] x:\path\Delphi.exe
    property RootDir: string read FRootDir; // [Reg->RootDir] x:\path
    property Edition: string read FEdition; // [Reg->Version] PER/PRO/CSS
    property LatestUpdate: Integer read FLatestUpdate;
    property LatestRTLPatch: Integer read FLatestRTLPatch;

    property BrowsingPaths: TStringList read FBrowsingPaths; // with macros
    property DCPOutputDir: string read FDCPOutputDir; // with macros
    property BPLOutputDir: string read FBPLOutputDir; // with macros
    property PackageSearchPathList: TStringList read FPackageSearchPaths; // with macros
    property SearchPaths: TStringList read FSearchPaths; // with macros
    property DebugDcuPaths: TStringList read FDebugDcuPaths; // with macros
    property GlobalIncludePaths: TStringList read FGlobalIncludePaths; // BDS only, with macros
    property GlobalCppSearchPaths: TStringList read FGlobalCppSearchPaths; // BDS only, with macros

    property BDSProjectsDir: string read FBDSProjectsDir;
    property ProjectDir: string read GetProjectDir; // Delphi 5-7: RootDir\Projects BDS: BDSProjectDir\Projects
    property BplDir: string read GetBplDir; // macros are expanded
    property DcpDir: string read GetDcpDir; // macros are expanded

    property KnownIDEPackages: TDelphiPackageList read FKnownIDEPackages;
    property KnownPackages: TDelphiPackageList read FKnownPackages;
    property DisabledPackages: TDelphiPackageList read FDisabledPackages;
  end;

  TDelphiPackageList = class(TObjectList)
  private
    function GetItems(Index: Integer): TDelphiPackage;
  public
    function IndexOfFilename(const Filename: string): Integer;
    procedure Add(const Filename, Description: string);
    procedure Remove(const Filename: string);

    property Items[Index: Integer]: TDelphiPackage read GetItems; default;
  end;

  TDelphiPackage = class(TObject)
  private
    FFilename: string;
    FDescription: string;
    function GetName: string;
  public
    constructor Create(const AFilename, ADescription: string);

    property Name: string read GetName;
    property Filename: string read FFilename;
    property Description: string read FDescription;
  end;


procedure ConvertPathList(const Paths: string; List: TStrings); overload;
function ConvertPathList(List: TStrings): string; overload;

{$IFDEF COMPILER5}
function AnsiStartsText(const SubStr, Text: string): Boolean;
function ExcludeTrailingPathDelimiter(const Path: string): string;
function GetEnvironmentVariable(const Name: string): string;
{$ENDIF COMPIELR5}

implementation

uses
  {$IFDEF COMPILER6_UP}
  StrUtils,
  {$ENDIF COMPILER6_UP}
  CmdLineUtils,
  JvConsts;

{$IFDEF COMPILER5}
function AnsiStartsText(const SubStr, Text: string): Boolean;
begin
  Result := AnsiStrLIComp(PChar(SubStr), PChar(Text), Length(SubStr)) = 0;
end;

function ExcludeTrailingPathDelimiter(const Path: string): string;
begin
  if (Path <> '') and (Path[Length(Path)] = '\') then // Delphi 5 only knows Windows
    Result := Copy(Path, 1, Length(Path) - 1)
  else
    Result := Path;
end;

function GetEnvironmentVariable(const Name: string): string;
begin
  SetLength(Result, 8 * 1024);
  SetLength(Result, Windows.GetEnvironmentVariable(PChar(Name), PChar(Result), Length(Result)));
end;
{$ENDIF COMPIELR5}

const
  KeyBorland = '\SOFTWARE\Borland\'; // do not localize

function SubStr(const Text: string; StartIndex, EndIndex: Integer): string;
begin
  Result := Copy(Text, StartIndex, EndIndex - StartIndex + 1);
end;

procedure ConvertPathList(const Paths: string; List: TStrings); overload;
var
  F, P: PChar;
  S: string;
begin
  List.Clear;
  P := PChar(Paths);
  while (P[0] <> #0) do
  begin
   // trim
    while (P[0] = ' ') do
      Inc(P);
    if P[0] = #0 then
      Break;

    F := P;
    while not (P[0] in [#0, ';']) do
      Inc(P);
    SetString(S, F, P - F);
    List.Add(ExcludeTrailingPathDelimiter(S));
    if P[0] = #0 then
      Break;
    Inc(P);
  end;
end;

function ConvertPathList(List: TStrings): string; overload;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to List.Count - 1 do
    Result := Result + List[I] + ';';
  SetLength(Result, Length(Result) - 1);
end;

{ TCompileTargetList }

constructor TCompileTargetList.Create;
begin
  inherited Create;
  if CmdOptions.RegistryKeyDelphi = '' then
    CmdOptions.RegistryKeyDelphi := 'Delphi'; // do not localize
  if CmdOptions.RegistryKeyBCB = '' then
    CmdOptions.RegistryKeyBCB := 'C++Builder'; // do not localize
  if CmdOptions.RegistryKeyBDS = '' then
    CmdOptions.RegistryKeyBDS := 'BDS'; // do not localize

  if not CmdOptions.IgnoreDelphi then
    LoadTargets('Delphi', CmdOptions.RegistryKeyDelphi); // do not localize
  if not CmdOptions.IgnoreBCB then
    LoadTargets('C++Builder', CmdOptions.RegistryKeyBCB); // do not localize
  if not CmdOptions.IgnoreDelphi then
    LoadTargets('BDS', CmdOptions.RegistryKeyBDS); // do not localize
end;

function TCompileTargetList.GetItems(Index: Integer): TCompileTarget;
begin
  Result := TCompileTarget(inherited Items[Index]);
end;

procedure TCompileTargetList.LoadTargets(const SubKey, HKCUSubKey: string);
var
  Reg, HKCUReg: TRegistry;
  List: TStrings;
  i: Integer;
begin
  Reg := TRegistry.Create;
  HKCUReg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    HKCUReg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly(KeyBorland + SubKey) then
    begin
      List := TStringList.Create;
      try
        Reg.GetKeyNames(List);
        for i := 0 to List.Count - 1 do
          if List[i][1] in ['1'..'9'] then // only version numbers (not "BDS\DBExpress")
            if (SubKey <> 'BDS') or IsBDSSupported(List[i]) then
            begin
              if HKCUReg.KeyExists(KeyBorland + HKCUSubKey + '\' + List[i]) then
                Add(TCompileTarget.Create(SubKey, List[i], HKCUSubKey));
            end;
      finally
        List.Free;
      end;
    end;
  finally
    HKCUReg.Free;
    Reg.Free;
  end;
end;

function TCompileTargetList.IsBDSSupported(const IDEVersionStr: string): Boolean;
var
  IDEVersion: Integer;
begin
  Result := False;
  IDEVersion := StrToInt(IDEVersionStr[1]);
  if (IDEVersion >= Low(BDSVersions)) and (IDEVersion <= High(BDSVersions)) then
    Result := BDSVersions[IDEVersion].Supported;
end;

{ TCompileTarget }

constructor TCompileTarget.Create(const AName, AVersion, ARegSubKey: string);
begin
  inherited Create;
  FInstalledPersonalities := TStringList.Create;
  FIDEName := AName;
  FIDEVersionStr := AVersion;
  FIDEVersion := StrToIntDef(Copy(FIDEVersionStr, 1, Pos('.', FIDEVersionStr) - 1), 0);
  if not IsBDS then
  begin
    FName := FIDEName;
    FVersion := FIDEVersion;
    FVersionStr := FIDEVersionStr;
  end
  else
    GetBDSVersion(FName, FVersion, FVersionStr);

  FHKLMRegistryKey := KeyBorland + IDEName + '\' + IDEVersionStr;
  FRegistryKey := KeyBorland + ARegSubKey + '\' + IDEVersionStr;

  FBrowsingPaths := TStringList.Create;
  FPackageSearchPaths := TStringList.Create;
  FSearchPaths := TStringList.Create;
  FDebugDcuPaths := TStringList.Create;
  FGlobalIncludePaths := TStringList.Create;
  FGlobalCppSearchPaths := TStringList.Create;

  FBrowsingPaths.Duplicates := dupIgnore;
  FPackageSearchPaths.Duplicates := dupIgnore;
  FSearchPaths.Duplicates := dupIgnore;
  FDebugDcuPaths.Duplicates := dupIgnore;
  FGlobalIncludePaths.Duplicates := dupIgnore;
  FGlobalCppSearchPaths.Duplicates := dupIgnore;

  FDisabledPackages := TDelphiPackageList.Create;
  FKnownIDEPackages := TDelphiPackageList.Create;
  FKnownPackages := TDelphiPackageList.Create;

  LoadFromRegistry;
end;

destructor TCompileTarget.Destroy;
begin
  FBrowsingPaths.Free;
  FPackageSearchPaths.Free;
  FSearchPaths.Free;
  FDebugDcuPaths.Free;
  FGlobalIncludePaths.Free;
  FGlobalCppSearchPaths.Free;

  FDisabledPackages.Free;
  FKnownIDEPackages.Free;
  FKnownPackages.Free;

  FInstalledPersonalities.Free;
  inherited Destroy;
end;

function TCompileTarget.DisplayName: string;
begin
  Result := Format('%s %s (%s)', [Name, VersionStr, Edition]); // do not localize
end;

function TCompileTarget.ExpandDirMacros(const Dir: string): string;
var
  I, EndPs: Integer;
  S, NewS: string;
begin
  Result := Dir;
  I := 1;
  while I < Length(Result) do
  begin
    if (Result[I] = '$') and (Result[I + 1] = '(') then
    begin
      EndPs := I + 2;
      while (EndPs <= Length(Result)) and (Result[EndPs] <> ')') do
        Inc(EndPs);
      S := AnsiLowerCase(SubStr(Result, I + 2, EndPs - 1));
      NewS := S;

     // available macros
      if (S = 'delphi') or (S = 'bcb') or (S = 'bds') then // do not localize
        NewS := FRootDir
      else if IsBDS and (S = 'bdsprojectsdir') then
        NewS := BDSProjectsDir
      else
        NewS := GetEnvironmentVariable(S);

      if NewS <> S then
      begin
        Delete(Result, i, EndPs - I + 1);
        Insert(NewS, Result, I);
        Inc(I, Length(NewS) - 1);
        NewS := '';
      end;
    end;
    Inc(I);
  end;
end;

function TCompileTarget.InsertDirMacros(const Dir: string): string;
begin
  Result := Dir;
  if AnsiStartsText(RootDir + PathDelim, Dir) then
  begin
    if IsBDS then
      Result := '$(BDS)' // do not localize
    else
    if IsDelphi then
      Result := '$(DELPHI)' // do not localize
    else
    if IsBCB then
      Result := '$(BCB)' // do not localize
    else
      Result := RootDir;

    Result := Result + Copy(Dir, Length(RootDir) + 1, MaxInt);
  end;
end;

function TCompileTarget.FindPackage(const PackageName: string): TDelphiPackage;

  function Find(List: TDelphiPackageList): TDelphiPackage;
  var
    i: Integer;
  begin
    for i := 0 to List.Count - 1 do
      if CompareText(PackageName, List[i].Name) = 0 then
      begin
        Result := List[i];
        Exit;
      end;
    Result := nil;
  end;

begin
  Result := Find(KnownIDEPackages);
  if Result = nil then
    Result := Find(KnownPackages);
end;

function TCompileTarget.FindPackageEx(const PackageNameStart: string): TDelphiPackage;

  function Find(List: TDelphiPackageList): TDelphiPackage;
  var
    i: Integer;
  begin
    for i := 0 to List.Count - 1 do
      if AnsiStartsText(PackageNameStart, List[i].Name) then
      begin
        Result := List[i];
        Exit;
      end;
    Result := nil;
  end;

begin
  Result := Find(KnownIDEPackages);
  if Result = nil then
    Result := Find(KnownPackages);
end;

function TCompileTarget.IsBCB: Boolean;
begin
  Result := (AnsiPos(AnsiUppercase('Builder'), AnsiUppercase(Name)) > 0);
end;

function TCompileTarget.IsDelphi: Boolean;
begin
  Result := (AnsiPos(AnsiUppercase('Delphi'), AnsiUppercase(Name)) > 0);
end;

function TCompileTarget.IsBDS: Boolean;
begin
  Result := CompareText(IDEName, 'BDS') = 0;
end;

function TCompileTarget.IsPersonal: Boolean;
begin
  Result := (CompareText(Edition, 'PER') = 0) or // do not localize
            (CompareText(Edition, 'PERS') = 0) or // do not localize
            (CompareText(Edition, 'Personal') = 0) or // do not localize
            (CompareText(Edition, 'STD') = 0); // do not localize
end;

procedure TCompileTarget.LoadFromRegistry;
var
  Reg: TRegistry;
  List: TStrings;
  i: Integer;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    if Reg.OpenKeyReadOnly(HKLMRegistryKey) then
    begin
      if Reg.ValueExists('Edition') then
        FEdition := Reg.ReadString('Edition')
      else
      if Reg.ValueExists('Version') then
        FEdition := Reg.ReadString('Version') // do not localize
      else
        FEdition := 'Pers';

      FExecutable := Reg.ReadString('App'); // do not localize
      FRootDir := ExcludeTrailingPathDelimiter(Reg.ReadString('RootDir')); // do not localize

      if IsBDS then
        FBDSProjectsDir := ReadBDSProjectsDir // reads from COREIDExx.XX's resource strings
      else
        FBDSProjectsDir := RootDir + '\Projects';

      // obtain updates state
      List := TStringList.Create;
      try
        Reg.GetValueNames(List);
        for i := 1 to 10 do
        begin
          if Reg.ValueExists('Update #' + IntToStr(i)) then // do not localize
            FLatestUpdate := i;
          if i = 1 then
          begin
            if Reg.ValueExists('Pascal RTL Patch') then // do not localize
              FLatestRTLPatch := i;
          end
          else
            if Reg.ValueExists('Pascal RTL Patch #' + IntToStr(i)) then // do not localize
              FLatestRTLPatch := i;
        end;
      finally
        List.Free;
      end;
    end;

    Reg.RootKey := HKEY_CURRENT_USER;

    // update BDSProjectsDir is the user has defined an IDE-environment variable
    if IsBDS and Reg.OpenKeyReadOnly(HKLMRegistryKey + '\Environment Variables') then // do not localize
    begin
      if Reg.ValueExists('BDSPROJECTSDIR') then
        FBDSProjectsDir := ExpandDirMacros(Reg.ReadString('BDSPROJECTSDIR')); // do not localize
      Reg.CloseKey;
    end;

    if Reg.OpenKeyReadOnly(RegistryKey) then
    begin
      // obtain updates state
      List := TStringList.Create;
      try
        Reg.GetValueNames(List);
        for i := 1 to 10 do
        begin
          if Reg.ValueExists('Update #' + IntToStr(i)) then // do not localize
            if FLatestUpdate < i then
              FLatestUpdate := i;
          if i = 1 then
          begin
            if Reg.ValueExists('Pascal RTL Patch') then // do not localize
              if FLatestRTLPatch < i then
                FLatestRTLPatch := i;
          end
          else
            if Reg.ValueExists('Pascal RTL Patch #' + IntToStr(i)) then // do not localize
              if FLatestRTLPatch < i then
                FLatestRTLPatch := i;
        end;
      finally
        List.Free;
      end;
      Reg.CloseKey;
    end;

    // get library paths
    if Reg.OpenKeyReadOnly(RegistryKey + '\Library') then // do not localize
    begin
      FDCPOutputDir := ExcludeTrailingPathDelimiter(Reg.ReadString('Package DCP Output')); // do not localize
      FBPLOutputDir := ExcludeTrailingPathDelimiter(Reg.ReadString('Package DPL Output')); // do not localize
      ConvertPathList(Reg.ReadString('Browsing Path'), FBrowsingPaths); // do not localize
      ConvertPathList(Reg.ReadString('Package Search Path'), FPackageSearchPaths); // do not localize
      ConvertPathList(Reg.ReadString('Search Path'), FSearchPaths); // do not localize
      Reg.CloseKey;
    end;
    if Reg.OpenKeyReadOnly(RegistryKey + '\Debugging') then // do not localize
    begin
      ConvertPathList(Reg.ReadString('Debug DCUs Path'), FDebugDcuPaths); // do not localize
      Reg.CloseKey;
    end;
    if IsBDS and Reg.OpenKeyReadOnly(RegistryKey + '\CppPaths') then // do not localize
    begin
      ConvertPathList(Reg.ReadString('IncludePath'), FGlobalIncludePaths); // do not localize
      ConvertPathList(Reg.ReadString('SearchPath'), FGlobalCppSearchPaths); // do not localize
      Reg.CloseKey;
    end;
    if IsBDS and Reg.OpenKeyReadOnly(RegistryKey + '\Personalities') then
    begin
      Reg.GetValueNames(FInstalledPersonalities);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;

  LoadPackagesFromRegistry(FKnownIDEPackages, 'Known IDE Packages'); // do not localize
  LoadPackagesFromRegistry(FKnownPackages, 'Known Packages'); // do not localize
  LoadPackagesFromRegistry(FDisabledPackages, 'Disabled Packages'); // do not localize
end;

procedure TCompileTarget.LoadPackagesFromRegistry(APackageList: TDelphiPackageList;
  const SubKey: string);
var
  Reg: TRegistry;
  List: TStrings;
  I: Integer;
begin
  APackageList.Clear;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly(RegistryKey + '\' + SubKey) then
    begin
      List := TStringList.Create;
      try
        Reg.GetValueNames(List);
        for i := 0 to List.Count - 1 do
          APackageList.Add(List[i], Reg.ReadString(List[i]));
      finally
        List.Free;
      end;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TCompileTarget.SavePackagesToRegistry(APackageList: TDelphiPackageList;
  const SubKey: string);
var
  Reg: TRegistry;
  List: TStrings;
  I: Integer;
begin
{  for I := 0 to APackageList.Count - 1 do
    APackageList[I].FFilename := InsertDirMacros(APackageList[I].FFilename);}

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(RegistryKey + '\' + SubKey, False) then
    begin
      List := TStringList.Create;
      try
        Reg.GetValueNames(List);

        // remove old packages
        for I := 0 to List.Count - 1 do
          if APackageList.IndexOfFilename(List[I]) = -1 then
            Reg.DeleteValue(List[I]);

        // add new packages
        for I := 0 to APackageList.Count - 1 do
          if List.IndexOf(APackageList[I].Filename) = -1 then
            Reg.WriteString(APackageList[I].Filename, APackageList[I].Description);

      finally
        List.Free;
      end;
    end;
  finally
    Reg.Free;
  end;
end;

function TCompileTarget.GetHomepage: string;
begin
  if IsBCB and not IsBDS then
    Result := 'http://www.borland.com/products/downloads/download_cbuilder.html' // do not localize
  else
  begin
    if Version = 5 then
      Result := 'http://info.borland.com/devsupport/delphi/downloads/index.html' // do not localize
    else
      Result := 'http://www.borland.com/products/downloads/download_delphi.html' // do not localize
  end;
end;

procedure TCompileTarget.SavePackagesLists;
begin
  SavePackagesToRegistry(FKnownPackages, 'Known Packages'); // do not localize
  SavePackagesToRegistry(FDisabledPackages, 'Disabled Packages'); // do not localize
end;

procedure TCompileTarget.SavePaths;
var
  Reg: TRegistry;
  S: string;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(RegistryKey + '\Library', False) then // do not localize
    begin
      Reg.WriteString('Browsing Path', ConvertPathList(FBrowsingPaths)); // do not localize
      Reg.WriteString('Search Path', ConvertPathList(FSearchPaths)); // do not localize
      Reg.CloseKey;
    end;
    if Reg.OpenKey(RegistryKey + '\Debugging', False) then // do not localize
    begin
      S := ConvertPathList(FDebugDcuPaths);
      if S <> Reg.ReadString('Debug DCUs Path') then
        Reg.WriteString('Debug DCUs Path', S); // do not localize
      Reg.CloseKey;
    end;
    if IsBDS and Reg.OpenKey(RegistryKey + '\CppPaths', False) then // meight not exist
    begin
      S := ConvertPathList(FGlobalIncludePaths);
      if not Reg.ValueExists('IncludePath') or (S <> Reg.ReadString('IncludePath')) then
        Reg.WriteString('IncludePath', S);
      S := ConvertPathList(FGlobalCppSearchPaths);
      if not Reg.ValueExists('SearchPath') or (S <> Reg.ReadString('SearchPath')) then
        Reg.WriteString('SearchPath', S);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

function TCompileTarget.SupportedPersonalities: TPersonalities;
var
  Pers: TPersonalityType;
begin
  Result := [];
  if not IsBDS then
  begin
    if IsDelphi then
      Result := [persDelphi]
    else
    if IsBCB then
      Result := [persBCB];
  end
  else
  begin
    for Pers := Low(TPersonalityType) to High(TPersonalityType) do
      if FInstalledPersonalities.IndexOf(PersNames[Pers]) >= 0 then
        Include(Result, Pers);
  end;
end;

function TCompileTarget.SupportsPersonalities(Personalities: TPersonalities; Exact: Boolean = False): Boolean;
begin
  if Exact then
    Result := SupportedPersonalities = Personalities
  else
    Result := SupportedPersonalities * Personalities = Personalities;
end;

function TCompileTarget.TargetType: string;
begin
  if IsBDS then
  begin
    if SupportsPersonalities([persDelphi]) then
      Result := 'D' // do not localize
    else
    if SupportsPersonalities([persBCB]) then
      Result := 'C' // do not localize
    else
      Result := '';
  end
  else
  if IsDelphi then
    Result := 'D' // do not localize
  else
  if IsBCB then
    Result := 'C' // do not localize
  else
    Result := '';
end;

function TCompileTarget.GetMake: string;
begin
  Result := RootDir + '\Bin\make.exe'; // do not localize
end;

function TCompileTarget.GetBplDir: string;
begin
  Result := ExpandDirMacros(BPLOutputDir);
end;

function TCompileTarget.GetDcpDir: string;
begin
  Result := ExpandDirMacros(DCPOutputDir);
end;

procedure TCompileTarget.GetBDSVersion(out Name: string; out Version: Integer; out VersionStr: string);
begin
  if (IDEVersion >= Low(BDSVersions)) and (IDEVersion <= High(BDSVersions)) then
  begin
    Name := BDSVersions[IDEVersion].Name;
    VersionStr := BDSVersions[IDEVersion].VersionStr;
    Version := BDSVersions[IDEVersion].Version;
  end
  else
  begin
    Name := IDEName;
    Version := IDEVersion;
    VersionStr := IDEVersionStr;
  end;
end;

var
  _SHGetSpecialFolderPathA: function(hwndOwner: HWND; lpszPath: PAnsiChar;
    nFolder: Integer; fCreate: BOOL): BOOL; stdcall;

function TCompileTarget.ReadBDSProjectsDir: string;
var
  h: HMODULE;
  LocaleName: array[0..4] of Char;
  Filename: string;
  PersDir: string;
begin
  if IsBDS and (IDEVersion >= Low(BDSVersions)) and (IDEVersion <= High(BDSVersions)) then
  begin
    Result := 'Borland Studio Projects'; // do not localize

    FillChar(LocaleName, SizeOf(LocaleName[0]), 0);
    GetLocaleInfo(GetThreadLocale, LOCALE_SABBREVLANGNAME, LocaleName, SizeOf(LocaleName));
    if LocaleName[0] <> #0 then
    begin
      Filename := RootDir + '\Bin\coreide' + BDSVersions[IDEVersion].CIV + '.';
      if FileExists(Filename + LocaleName) then
        Filename := Filename + LocaleName
      else
      begin
        LocaleName[2] := #0;
        if FileExists(Filename + LocaleName) then
          Filename := Filename + LocaleName
        else
          Filename := '';
      end;

      if Filename <> '' then
      begin
        h := LoadLibraryEx(PChar(Filename), 0,
          LOAD_LIBRARY_AS_DATAFILE or DONT_RESOLVE_DLL_REFERENCES);
        if h <> 0 then
        begin
          SetLength(Result, 1024);
          SetLength(Result, LoadString(h, BDSVersions[IDEVersion].ProjectDirResId, PChar(Result), Length(Result) - 1));
          FreeLibrary(h);
        end;
      end;
    end;

    if not Assigned(_SHGetSpecialFolderPathA) then
      _SHGetSpecialFolderPathA := GetProcAddress(GetModuleHandle('shell32.dll'), 'SHGetSpecialFolderPathA');
    SetLength(PersDir, MAX_PATH);
    if Assigned(_SHGetSpecialFolderPathA) and
       _SHGetSpecialFolderPathA(0, PChar(PersDir), CSIDL_PERSONAL, False) then
    begin
      SetLength(PersDir, StrLen(PChar(PersDir)));
      Result := ExcludeTrailingPathDelimiter(PersDir) + '\' + Result;
    end
    else
      Result := '';
  end
  else
    Result := '';
end;

function TCompileTarget.VersionedDCP(const Filename: string): string;
begin
  if Version > 5 then
    Result := Filename
  else
    Result := ChangeFileExt(Filename, '') + IntToStr(Version) + '0' + ExtractFileExt(Filename);
end;

function TCompileTarget.VersionedBPL(const Filename: string): string;
begin
  Result := ChangeFileExt(Filename, '') + IntToStr(Version) + '0' + ExtractFileExt(Filename);
end;

function TCompileTarget.GetProjectDir: string;
begin
  if IsBDS then
    Result := BDSProjectsDir
  else
    Result := RootDir;
  Result := Result + PathDelim + 'Projects';
end;

{ TDelphiPackageList }

procedure TDelphiPackageList.Add(const Filename, Description: string);
var
  Item: TDelphiPackage;
begin
  if Description = '' then
    Item := TDelphiPackage.Create(Filename, ChangeFileExt(ExtractFileName(Filename), ''))
  else
    Item := TDelphiPackage.Create(Filename, Description);
  inherited Add(Item);
end;

procedure TDelphiPackageList.Remove(const Filename: string);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if CompareText(Items[i].Filename, Filename) = 0 then
    begin
      Delete(i);
      Exit;
    end;
end;

function TDelphiPackageList.GetItems(Index: Integer): TDelphiPackage;
begin
  Result := TDelphiPackage(inherited Items[Index]);
end;

function TDelphiPackageList.IndexOfFilename(const Filename: string): Integer;
begin
  for Result := 0 to Count - 1 do
    if CompareText(Items[Result].Filename, Filename) = 0 then
      Exit;
  Result := -1;
end;

{ TDelphiPackage }

constructor TDelphiPackage.Create(const AFilename, ADescription: string);
begin
  inherited Create;
  FFilename := AFilename;
  FDescription := ADescription;
end;

function TDelphiPackage.GetName: string;
begin
  Result := ExtractFileName(Filename);
end;

end.
