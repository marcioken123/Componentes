{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JVCLData.pas, released on 2004-03-29.

The Initial Developer of the Original Code is Andreas Hausladen
(Andreas dott Hausladen att gmx dott de)
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL
home page, located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JVCLData.pas,v 1.41 2006/02/09 11:47:31 obones Exp $

unit JVCLData;

{$I jvcl.inc}

interface

uses
  Windows, Registry, SysUtils, Classes, Contnrs,
  JVCLConfiguration, DelphiData, PackageUtils, Intf, GenerateUtils,
  IniFiles, JCLData;

const
  sPackageGeneratorFile = 'devtools\bin\pgEdit.xml';
  sDxgettextRegKey = '\bplfile\Shell\Extract strings\Command';
  sJvclIncFile = '%s\common\jvcl.inc';
  sBCBIncludeDir = '%s\Include\Vcl';

const
  CLXSupport = False; { Switch this to True if the Installer should support CLX }

type
  TJVCLData = class;
  TTargetConfig = class;

  TInstallMode = set of TPackageGroupKind;

  TDeinstallProgressEvent = procedure(Sender: TObject; const Text: string;
    Position, Max: Integer) of object;
  TDeleteFilesEvent = procedure(TargetConfig: TTargetConfig) of object;

  TTargetConfig = class(TComponent, ITargetConfig) // TComponent <-> TInterfacedObject
  private
    FOwner: TJVCLData;
    FTarget: TCompileTarget;
    FInstalledJVCLVersion: Integer;
    FDefaultJCLDir: string;
    FJCLDir: string;
    FDefaultHppDir: string;
    FHppDir: string;
    FMissingJCL: Boolean;
    FOutdatedJCL: Boolean;
//    FCompiledJCL: Boolean;
    FInstallJVCL: Boolean;

    FDeveloperInstall: Boolean;
    FCleanPalettes: Boolean;
    FBuild: Boolean;
    FCompileOnly: Boolean;
    FDebugUnits: Boolean;
    FAutoDependencies: Boolean;

    FInstallMode: TInstallMode;
    FFrameworks: TFrameworks;
    FDcpDir: string;
    FBplDir: string;
    FGenerateMapFiles: Boolean;

    FJVCLConfig: TJVCLConfig;

    procedure SetInstallMode(Value: TInstallMode);
    function GetFrameworkCount: Integer;
    function GetDxgettextDir: string;
    function GetDeveloperInstall: Boolean;
    function GetGenerateMapFiles: Boolean;
    procedure SetJCLDir(const Value: string);
    function GetJVCLConfig: TJVCLConfig;
  private
    { ITargetConfig }
    function GetInstance: TObject;
    function GetJVCLPackagesXmlDir: string;
    function GetJVCLDir: string;
    function GetJVCLPackagesDir: string;

    function GetTargetSymbol: string;
    function GetAutoDependencies: Boolean;
    function GetBuild: Boolean;
    function GetUnitOutDir: string;
    function GetDebugUnits: Boolean;
    function GetCompileOnly: Boolean;

    function GetTarget: TCompileTarget;
    function GetJCLDir: string;
    function GetJCLLibDir: string;
    function GetHppDir: string;
    function GetBplDir: string;
    function GetDcpDir: string;
  protected
    procedure Init; virtual;
    procedure DoCleanPalette(Reg: TRegistry; const Name: string;
      RemoveEmptyPalettes: Boolean);
    procedure ClearPackageCache(const Key: string; const AStartsWith: string);
    function RegisterProjectGroupToIDE(ProjectGroup: TProjectGroup): Boolean;

    procedure UpdateOptions;
    procedure EnableOption(const Name: string; Enable: Boolean);
  public
    property Target: TCompileTarget read GetTarget;
    property Owner: TJVCLData read FOwner;
  public
    constructor Create(AOwner: TJVCLData; ATarget: TCompileTarget); reintroduce;
    destructor Destroy; override;
    procedure Load;
    procedure Save;
    procedure CleanJVCLPalette(RemoveEmptyPalettes: Boolean);
    procedure DeinstallJVCL(Progress: TDeinstallProgressEvent;
      DeleteFiles: TDeleteFilesEvent);
    function RegisterToIDE: Boolean;

    function CanInstallJVCL: Boolean;
      // CanInstallJVCL returns False when the target is not up to date or
      // no JCL was found.

    function IsUpToDate: Boolean;
      // IsUpToDate returns False when the (Borland) updates for this target
      // are not installed.

    function IsOldVersionInstalled: Boolean;
      // IsOldVersionInstalled returns true if an older JVCL version is
      // installed.

    function GetBpgFilename(Personal: Boolean; Kind: TPackageGroupKind): string;
      // BpgFilename returns the filename of the ProjectGroup that is used

    procedure ResetPackagesSettings(ProjectGroup: TProjectGroup);
      // ResetPackagesSettings sets the install property for each package target
      // to its registry setting of the current IDE target.
    procedure SavePackagesSettings(ProjectGroup: TProjectGroup);
      // SavePackagesSettings saves the runtime packages state to an .ini file.

    property TargetSymbol: string read GetTargetSymbol;
      // TargetSymbol returns the symbol that is used in the xml files for this
      // target.

    property UnitOutDir: string read GetUnitOutDir;
      // UnitOutDir specifies the JVCL directory where the .dcu should go.
    property BplDir: string read GetBplDir write FBplDir;
      // BPL directory for this target
    property DcpDir: string read GetDcpDir write FDcpDir;
      // DCP directory for this target

    property DxgettextDir: string read GetDxgettextDir;
      // Directory where dxgettext is installed or ''. (special handling for Delphi/BCB 5)

    property InstalledJVCLVersion: Integer read FInstalledJVCLVersion;
      // InstalledJVCLVersion returns the version of the installed JVCL.

    property MissingJCL: Boolean read FMissingJCL;
      // MissingJCL is True when no JCL is installed and no JCL directoy was
      // found that could be installed.

    property OutdatedJCL: Boolean read FOutdatedJCL;
      // OutdatedJCL is True if no jcl\source\common\windows\win32api directory
      // exists which means that the JCL is too old for the JVCL.

//    property CompiledJCL: Boolean read FCompiledJCL;
      // CompiledJCL is True if Jcl.dcp and JclVcl.dcp exist for this
      // target.

    property Frameworks: TFrameworks read FFrameworks;
      // Frameworks contains all possible package groups.

    property FrameworkCount: Integer read GetFrameworkCount;
      // FrameworkCount returns the number of available frameworks for this
      // target.

    property JVCLConfig: TJVCLConfig read GetJVCLConfig;
      // JVCLConfig returns the confiuration
  public
    property InstallJVCL: Boolean read FInstallJVCL write FInstallJVCL;
      // InstallJVCL specifies if the JVCL should be installed on this target.

    property InstallMode: TInstallMode read FInstallMode write SetInstallMode;
      // InstallMode specifies if the JVCL only,  JVCL and JVCLX or JVCLX only
      // should be installed.

    property DebugUnits: Boolean read GetDebugUnits write FDebugUnits;
      // if DebugUnits is True the units will be compiled in debug mode, too.
      // (Delphi only) [NOT USED IN THE JVCL DUE TO jvcl.inc SETTINGS]

    property GenerateMapFiles: Boolean read GetGenerateMapFiles write FGenerateMapFiles;
      // if GenerateMapFiles is True the compiler generates .map files for each package

    property Build: Boolean read GetBuild write FBuild;
      // if Build is True the packages are built instead of make.

    property CompileOnly: Boolean read GetCompileOnly write FCompileOnly;
      // if CompileOnly is True the desigtime packages are not registered to the
      // IDE.

    property AutoDependencies: Boolean read GetAutoDependencies write FAutoDependencies;
      // if AutoDependencies it True the make file for the project groups will
      // contain auto dependency information for faster compilation.

    property DeveloperInstall: Boolean read GetDeveloperInstall write FDeveloperInstall;
      // DevelopInstall: add the \run directory to the library path.

    property CleanPalettes: Boolean read FCleanPalettes write FCleanPalettes;
      // CleanPalettes specifies if the JVCL components should be removed from
      // the component palettes before installation.

    property JCLDir: string read GetJCLDir write SetJCLDir;
      // JCLDir specifies the directory where the JCL is.

    property JCLLibDir: string read GetJCLLibDir;
      // JCLDir specifies the directory where the JCL Library files are, depending on the target.

    property HppDir: string read GetHppDir write FHppDir;
      // HppDir: (for BCB installation) specifies where the generated .hpp files
      // should go.
  end;

  TJVCLData = class(TObject)
  private
    FConfigs: array of TTargetConfig;
    FTargets: TCompileTargetList;
    FIsDxgettextInstalled: Boolean;
    FDxgettextDir: string;
    FJVCLDir: string;
    FDeleteFilesOnUninstall: Boolean;
    FVerbose: Boolean;
    FIgnoreMakeErrors: Boolean;

    function GetTargetConfig(Index: Integer): TTargetConfig;
    function GetJVCLDir: string;
    function GetCleanPalettes: Integer;
    procedure SetCleanPalettes(Value: Integer);
    function GetDeveloperInstall: Integer;
    procedure SetDeveloperInstall(Value: Integer);
    function GetJVCLPackagesDir: string;
    function GetJVCLPackagesXmlDir: string;
    function GetBuild: Integer;
    procedure SetBuild(Value: Integer);
    function GetCompileOnly: Integer;
    procedure SetCompileOnly(const Value: Integer);
    function GetOptionState(Index: Integer): Integer;
    function GetGenerateMapFiles: Integer;
    procedure SetGenerateMapFiles(const Value: Integer);
    function GetDebugUnits: Integer;
    procedure SetDebugUnits(const Value: Integer);
  protected
    function JvclIncFilename: string;
    procedure Init; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SaveTargetConfigs;
    function FindTargetConfig(const TargetSymbol: string): TTargetConfig;
    function IsJVCLInstalledAnywhere(MinVersion: Integer): Boolean;

    property DxgettextDir: string read FDxgettextDir;
    property IsDxgettextInstalled: Boolean read FIsDxgettextInstalled;

    property JVCLDir: string read GetJVCLDir;
    property JVCLPackagesDir: string read GetJVCLPackagesDir;
    property JVCLPackagesXmlDir: string read GetJVCLPackagesXmlDir;

    property DeveloperInstall: Integer read GetDeveloperInstall write SetDeveloperInstall;
    property DebugUnits: Integer read GetDebugUnits write SetDebugUnits;
    property CleanPalettes: Integer read GetCleanPalettes write SetCleanPalettes;
    property Build: Integer read GetBuild write SetBuild;
    property CompileOnly: Integer read GetCompileOnly write SetCompileOnly;
    property GenerateMapFiles: Integer read GetGenerateMapFiles write SetGenerateMapFiles;

    property DeleteFilesOnUninstall: Boolean read FDeleteFilesOnUninstall write FDeleteFilesOnUninstall default True;
    property Verbose: Boolean read FVerbose write FVerbose default False;
    property IgnoreMakeErrors: Boolean read FIgnoreMakeErrors write FIgnoreMakeErrors default False;

    property TargetConfig[Index: Integer]: TTargetConfig read GetTargetConfig;
    property Targets: TCompileTargetList read FTargets;
  end;

implementation

uses
  Utils, CmdLineUtils, PackageInformation;

resourcestring
  RsComponentPalettePrefix = 'TJv';
  RsNoJVCLFound = 'No JVCL directory found. Application terminated.';
  RsJVCLInstaller = 'JVCL Installer';

  RsCleaningPalette = 'Cleaning Palette...';
  RsCleaningPathLists = 'Cleaning Path lists...';
  RsUnregisteringPackages = 'Unregistering packages...';
  RsDeletingFiles = 'Deleting files...';
  RsComplete = 'Complete.';

function ReadRegString(RootKey: HKEY; const Key, Name: string): string;
var
  Reg: TRegistry;
begin
  Result := '';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := RootKey;
    if Reg.OpenKeyReadOnly(Key) then
    begin
      if Reg.ValueExists(Name) then
        Result := Reg.ReadString(Name);
    end;
  finally
    Reg.Free;
  end;
end;

function FixBackslashBackslash(const Dir: string): string;
var
  ps: Integer;
begin
  Result := Dir;
  ps := Pos('\\', Result);
  if ps > 0 then
    Delete(Result, ps, 1);
end;

{ TJVCLData }

constructor TJVCLData.Create;
var
  I: Integer;
  ErrMsg: string;
begin
  inherited Create;
  FDeleteFilesOnUninstall := True;
  FVerbose := False;

  ErrMsg := '';
  LoadConfig(JVCLDir + '\' + sPackageGeneratorFile, 'JVCL', ErrMsg);

  FTargets := TCompileTargetList.Create;
  SetLength(FConfigs, Targets.Count);
  for I := 0 to High(FConfigs) do
    FConfigs[I] := TTargetConfig.Create(Self, Targets[I]);
  Init;
end;

destructor TJVCLData.Destroy;
var
  i: Integer;
begin
  for i := 0 to High(FConfigs) do
    FConfigs[I].Free;
  FTargets.Free;
  inherited Destroy;
end;

function TJVCLData.FindTargetConfig(const TargetSymbol: string): TTargetConfig;
var
  i: Integer;
begin
  for i := 0 to Targets.Count - 1 do
  begin
    Result := TargetConfig[i];
    if CompareText(TargetSymbol, Result.TargetSymbol) = 0 then
      Exit;
  end;
  Result := nil;
end;

function TJVCLData.GetOptionState(Index: Integer): Integer;
var
  i: Integer;
  b: Boolean;
begin
  Result := 0; // false
  for i := 0 to Targets.Count - 1 do
  begin
    if TargetConfig[i].InstallJVCL then
    begin
      case Index of
        0: b := TargetConfig[i].Build;
        1: b := TargetConfig[i].CleanPalettes;
        2: b := TargetConfig[i].CompileOnly;
        3: b := TargetConfig[i].DeveloperInstall;
        4: b := TargetConfig[i].DebugUnits;
        5: b := TargetConfig[i].GenerateMapFiles;
      else
        b := False;
      end;
      if b then
      begin
        if Result = 3 then
        begin
          Result := 2;
          Exit;
        end;
        Result := 1 // true
      end
      else
      begin
        if Result = 1 then
        begin
          Result := 2; // mixed
          Exit;
        end;
        Result := 3;
      end;
    end;
  end;
  if Result = 3 then
    Result := 0;
end;

function TJVCLData.GetBuild: Integer;
begin
  Result := GetOptionState(0);
end;

function TJVCLData.GetCleanPalettes: Integer;
begin
  Result := GetOptionState(1);
end;

function TJVCLData.GetCompileOnly: Integer;
begin
  Result := GetOptionState(2);
end;

function TJVCLData.GetDeveloperInstall: Integer;
begin
  Result := GetOptionState(3);
end;

function TJVCLData.GetDebugUnits: Integer;
begin
  Result := GetOptionState(4);
end;

function TJVCLData.GetGenerateMapFiles: Integer;
begin
  Result := GetOptionState(5);
end;

function TTargetConfig.GetJVCLConfig: TJVCLConfig;
begin
  Result := FJVCLConfig;
end;

function TJVCLData.GetJVCLDir: string;
begin
  if FJVCLDir = '' then
  begin
    FJVCLDir := ExtractFileDir(ParamStr(0));
    while not DirectoryExists(JVCLPackagesDir) do
    begin
      if Length(FJVCLDir) < 4 then
      begin
        MessageBox(0, PChar(RsNoJVCLFound), PChar(RsJVCLInstaller), MB_ICONERROR or MB_OK);
        Halt(1);
        Break;
      end;
      FJVCLDir := ExtractFileDir(JVCLDir);
    end;
  end;
  Result := FJVCLDir;
end;

function TJVCLData.GetJVCLPackagesDir: string;
begin
  Result := JVCLDir + '\packages';
end;

function TJVCLData.GetJVCLPackagesXmlDir: string;
begin
  Result := JVCLPackagesDir + '\xml';
end;

function TJVCLData.GetTargetConfig(Index: Integer): TTargetConfig;
begin
  Result := FConfigs[Index];
end;

procedure TJVCLData.Init;
var
  i: Integer;
  S: string;
begin
 // dxgettext detection
  S := ReadRegString(HKEY_CLASSES_ROOT, PChar(sDxgettextRegKey), '');
  FIsDxgettextInstalled := S <> '';
  if FIsDxgettextInstalled then
  begin
    if S[1] = '"' then
    begin
      Delete(S, 1, 1);
      i := 1;
      while (i <= Length(S)) and (S[i] <> '"') do
        Inc(i);
      SetLength(S, i - 1);
    end;
    FDxgettextDir := ExtractFileDir(S);
    if not FileExists(FDxgettextDir + '\msgfmt.exe') then
    begin
      FIsDxgettextInstalled := False;
      FDxgettextDir := '';
    end;
  end;
end;

function TJVCLData.IsJVCLInstalledAnywhere(MinVersion: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Targets.Count - 1 do
    if TargetConfig[i].InstalledJVCLVersion >= MinVersion then
    begin
      Result := True;
      Break;
    end;
end;

function TJVCLData.JvclIncFilename: string;
begin
  Result := Format(sJvclIncFile, [JVCLDir]);
end;

procedure TJVCLData.SaveTargetConfigs;
var
  i: Integer;
begin
  for i := 0 to Targets.Count - 1 do
    TargetConfig[i].Save;
end;

procedure TJVCLData.SetBuild(Value: Integer);
var
  i: Integer;
begin
  for i := 0 to Targets.Count - 1 do
    TargetConfig[I].Build := Value <> 0;
end;

procedure TJVCLData.SetCleanPalettes(Value: Integer);
var
  i: Integer;
begin
  for i := 0 to Targets.Count - 1 do
    TargetConfig[I].CleanPalettes := Value <> 0;
end;

procedure TJVCLData.SetCompileOnly(const Value: Integer);
var
  i: Integer;
begin
  for i := 0 to Targets.Count - 1 do
    TargetConfig[i].CompileOnly := Value <> 0;
end;

procedure TJVCLData.SetDeveloperInstall(Value: Integer);
var
  i: Integer;
begin
  for i := 0 to Targets.Count - 1 do
    TargetConfig[i].DeveloperInstall := Value <> 0;
end;

procedure TJVCLData.SetGenerateMapFiles(const Value: Integer);
var
  i: Integer;
begin
  for i := 0 to Targets.Count - 1 do
    TargetConfig[i].GenerateMapFiles := Value <> 0;
end;

procedure TJVCLData.SetDebugUnits(const Value: Integer);
var
  i: Integer;
begin
  for i := 0 to Targets.Count - 1 do
    TargetConfig[i].DebugUnits := Value <> 0;
end;

{ TTargetConfig }

constructor TTargetConfig.Create(AOwner: TJVCLData; ATarget: TCompileTarget);
begin
  inherited Create(nil);
  FOwner := AOwner;
  FTarget := ATarget;

  FInstallMode := [pkVcl];
  if Target.IsBDS then
    FDefaultHppDir := ExtractFilePath(Format(sBCBIncludeDir, [Target.RootDir])) + 'JVCL' // do not localize
  else
    FDefaultHppDir := Format(sBCBIncludeDir, [Target.RootDir]);
  FHppDir := FDefaultHppDir;
  FCleanPalettes := True;
  FDeveloperInstall := False;
  FAutoDependencies := True;
  FBplDir := Target.BplDir;
  if Target.IsBDS then
    FDcpDir := GetUnitOutDir
  else
    FDcpDir := Target.DcpDir;
  FDefaultJCLDir := CmdOptions.JclPath;
  FJCLDir := FDefaultJCLDir;
  Init;
  FInstallJVCL := CanInstallJVCL;

  FFrameworks := TFrameworks.Create(Self);
  FJVCLConfig := TJVCLConfig.Create;
  Load;
end;

destructor TTargetConfig.Destroy;
begin
  FFrameworks.Free;
  inherited Destroy;
end;

procedure TTargetConfig.Init;
  // Memory allocations must go to the constructor because Init could be called
  // more the once.

  function FindJCL(List: TStrings): string;
  var
    i, jclIndex, BrowseIndex, ps: Integer;
    Dir: string;
    Identify: Boolean;
  begin
    Result := '';
    for i := 0 to List.Count - 1 do
    begin
      Dir := Target.ExpandDirMacros(List[i]);

      for BrowseIndex := 0 to High(JCLBrowsePaths) do
      begin
        // obtain the assumed JCL root directory
        Identify := False;
        if EndsWith(JCLBrowsePaths[BrowseIndex], '\', False) then
        begin
          ps := Pos(LowerCase(Path(JCLBrowsePaths[BrowseIndex])), LowerCase(Dir));
          if ps > 0 then
          begin
            Delete(Dir, ps, MaxInt);
            Identify := True;
          end;
        end
        else
        if EndsWith(Dir, Path(JCLBrowsePaths[BrowseIndex]), True) then
        begin
          Dir := ExtractFileDir(ExtractFileDir(Dir));
          Identify := True;
        end;

        if Identify then
        begin
          FMissingJCL := False;
          // Check if the assumed JCL directory contains the files that identify
          // the JCL.
          for jclIndex := 0 to High(JCLIdentify) do
            if not FileExists(Dir + Path(JCLIdentify[jclIndex])) then
            begin
              FMissingJCL := True;
              Break;
            end;

          if not FMissingJCL then
          begin
            Result := Dir;
            Break;
          end;
        end;
      end;

      if Result <> '' then
        Break;
    end;
  end;

var
  S: string;
  PossibleBPLDirs: TStrings;
  i: Integer;
  Reg: TRegistry;
begin
  FInstallMode := [];
//  FCompiledJCL := False;
  FOutdatedJCL := False;

  // identify JVCL version
  FInstalledJVCLVersion := 0;
  if Target.FindPackageEx('JvPack1') <> nil then
    FInstalledJVCLVersion := 1
  else if Target.FindPackageEx('jvcl2') <> nil then
    FInstalledJVCLVersion := 2
  else if Target.FindPackageEx('JvCore') <> nil then // VCL
  begin
    Include(FInstallMode, pkVCL);
    FInstalledJVCLVersion := 3;
  end;
  if Target.FindPackageEx('JvQCore') <> nil then // CLX
  begin
    Include(FInstallMode, pkCLX);
    FInstalledJVCLVersion := 3;
  end;
  if not CLXSupport then
  begin
    Exclude(FInstallMode, pkCLX);
    Include(FInstallMode, pkVCL);
  end
  else
  if FInstallMode = [] then // if no VCL and no CLX than it is VCL
    Include(FInstallMode, pkVCL);

  // identify JCL version
  FMissingJCL := True;
  if FJCLDir = '' then
  begin
    SetJCLDir(FindJCL(Target.BrowsingPaths));
    if FJCLDir = '' then
      SetJCLDir(FindJCL(Target.SearchPaths));
  end;

  // Check for the JCL bpl file, that's the most reliable way to find
  // if the JCL is actually installed because users may not have put the
  // JCL directory in their browsing and/or search paths, especially
  // BCB users.
  PossibleBPLDirs := TStringList.Create;
  try
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;

      ConvertPathList(GetEnvironmentVariable('PATH'), PossibleBPLDirs);
      if Reg.OpenKeyReadOnly(Target.HKLMRegistryKey + '\Environment Variables') then // do not localize
      begin
        if Reg.ValueExists('Path') then
        begin
          PossibleBPLDirs.Clear;
          ConvertPathList(Target.ExpandDirMacros(Reg.ReadString('Path')), PossibleBPLDirs);
        end;
        Reg.CloseKey;
      end;
    finally
      Reg.Free;
    end;
    PossibleBPLDirs.Insert(0, BplDir);

    for i := 0 to PossibleBPLDirs.Count - 1 do
    begin
      S := ExcludeTrailingPathDelimiter(PossibleBPLDirs[i]);
      if Target.Version > 7 then
        FMissingJCL := not FileExists(Format('%s\Jcl%d0.bpl', [S, Target.Version]))
      else
      if (Target.SupportsPersonalities([persBCB], True) and
          FileExists(Format('%s\JclC%d0.bpl', [S, Target.Version]))) or
         (Target.SupportsPersonalities([persDelphi], True) and
          FileExists(Format('%s\JclD%d0.bpl', [S, Target.Version]))) or
         (Target.SupportsPersonalities([persDelphi, persBCB], False) and
          FileExists(Format('%s\Jcl%d0.bpl', [S, Target.Version]))) then
      begin
        FMissingJCL := False;
      end;

      if not FMissingJCL then
        Break;
    end;
  finally
    PossibleBPLDirs.Free;
  end;


(*  // are Jcl.dcp and JclVcl.dcp available
  if Target.Version = 5 then S := '50' else S := '';

  if (Target.IsBCB and not Target.IsDelphi and
      FileExists(Format('%s\JclC%s.dcp', [BplDir, S])) and
      FileExists(Format('%s\JclVclC%s.dcp', [BplDir, S])))
     or
     ((not Target.IsBCB or (Target.IsBCB and Target.IsDelphi)) and
      FileExists(Format('%s\JclD%s.dcp', [BplDir, S])) and
      FileExists(Format('%s\JclVclD%s.dcp', [BplDir, S])))
     then
  begin
    FCompiledJCL := True;

    { (ahuser) Removed because some files require JCL source }
    // (obones) More exactly, this is required for the compilation
    // of the JCL DCP file for BCB targets.

    {if FJCLDir = '' then // replace JCL directory
      FJCLDir := BplDir;

    if Target.IsBCB then
      FMissingJCL := False
    else
    begin
      // Delphi requires .bpl files
      if FileExists(Format('%s\JclD%s.bpl', [BplDir, S])) and
         FileExists(Format('%s\JclVclD%s.bpl', [BplDir, S])) then
        FMissingJCL := False;
    end;}
  end;*)
  FDefaultJCLDir := JCLDir;
end;

function TTargetConfig.CanInstallJVCL: Boolean;
begin
  Result := IsUpToDate and not MissingJCL;
end;

function TTargetConfig.IsUpToDate: Boolean;
begin
{
  Result := False;
  if Target.IsBCB then
  begin
    case Target.Version of
      5: Result := Target.LatestUpdate >= 1;
      6: Result := Target.LatestUpdate >= 1;
    end;
  end
  else
  begin
    case Target.Version of
      5: Result := Target.LatestUpdate >= 1;
      6: Result := Target.LatestUpdate >= 2;
      7: Result := True;
      8: Result := False; // not supported
    end;
  end;}

  // The IDE is up to date because the JCL Installer garantees this for us.
  // The JVCL requires an installed JCL, so this is no problem.
  Result := True;
end;

function TTargetConfig.IsOldVersionInstalled: Boolean;
begin
  Result := InstalledJVCLVersion < 3;
end;

/// <summary>
/// GetBpgFilename returns the file name of the Borland Package Group (.bpg)
/// file that is used for this target.
/// </summary>
function TTargetConfig.GetBpgFilename(Personal: Boolean; Kind: TPackageGroupKind): string;
var
  Pers, Clx: string;
begin
  if Personal then
  begin
    if Target.Version <= 5 then
      Pers := 'Std'  // do not localize
    else
      Pers := 'Per'; // do not localize
  end;

  if Kind = pkClx then
    Clx := 'Clx';

  if Target.IsBDS then
    Result := Owner.JVCLPackagesDir + Format('\%s%d%s%s Packages.bdsgroup', // do not localize
      [Target.TargetType, Target.Version, Pers, Clx])
  else
    Result := Owner.JVCLPackagesDir + Format('\%s%d%s%s Packages.bpg', // do not localize
      [Target.TargetType, Target.Version, Pers, Clx]);
end;

procedure TTargetConfig.SavePackagesSettings(ProjectGroup: TProjectGroup);
var
  i: Integer;
  Ini: TMemIniFile;
  IniFileName: string;
begin
  // save to ini
  IniFileName := ChangeFileExt(ParamStr(0), '.ini'); // do not localize
  FileSetReadOnly(IniFileName, False);
  Ini := TMemIniFile.Create(IniFileName);
  try
    Ini.EraseSection(ProjectGroup.BpgName);
    for i := 0 to ProjectGroup.Count - 1 do
      with ProjectGroup.Packages[i] do
        if not ProjectTypeIsDesign(Info.ProjectType) then
          Ini.WriteBool(ProjectGroup.BpgName, Info.Name, Compile);
    Ini.UpdateFile;
  finally
    Ini.Free;
  end;
end;

procedure TTargetConfig.ResetPackagesSettings(ProjectGroup: TProjectGroup);
var
  PkgIndex, i: Integer;
  BplName: string;
  IsInstalled: Boolean;
  Ini: TMemIniFile;
begin
  // Set Compile to False for each package.
  for PkgIndex := 0 to ProjectGroup.Count - 1 do
    ProjectGroup.Packages[PkgIndex].Compile := False;

  // read from ini
  Ini := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini')); // do not localize
  try
    for i := 0 to ProjectGroup.Count - 1 do
      if not ProjectTypeIsDesign(ProjectGroup.Packages[i].Info.ProjectType) then
        // Ini read defaults to True, to compile and install newly created packages
        ProjectGroup.Packages[i].Compile := Ini.ReadBool(ProjectGroup.BpgName, ProjectGroup.Packages[i].Info.Name, True);
  finally
    Ini.Free;
  end;

  IsInstalled := False;
  // Set Install to the registry setting. The dependency check will activate the
  // required (runtime) packages.
  for PkgIndex := 0 to ProjectGroup.Count - 1 do
  begin
    BplName := ProjectGroup.Packages[PkgIndex].Info.BplName;

    for i := 0 to Target.KnownPackages.Count - 1 do
      if CompareText(Target.KnownPackages[i].Name, BplName) = 0 then
      begin
        ProjectGroup.Packages[PkgIndex].Install := True;
        IsInstalled := True;
        Break;
      end;

    for i := 0 to Target.DisabledPackages.Count - 1 do
      if CompareText(Target.DisabledPackages[i].Name, BplName) = 0 then
      begin
        // shouldn't the following value be False?
        ProjectGroup.Packages[PkgIndex].Install := True;
        IsInstalled := True;
        Break;
      end;
  end;
  if not IsInstalled then
  begin
    // No package of the project group is installed, so it must be a new
    // installation.
    for PkgIndex := 0 to ProjectGroup.Count - 1 do
      ProjectGroup.Packages[PkgIndex].Install := True;
  end;
end;

function TTargetConfig.GetTargetSymbol: string;
var
  Pers: string;
begin
  if Target.IsPersonal {or (Kind = pkPersonal)} then
  begin
    if Target.Version = 5 then
      Pers := 's' // do not localize
    else
      Pers := 'p'; // do not localize
  end;
  if Target.IsBDS then
    Result := Format('%s%d%s', [Target.TargetType, Target.Version, Pers]) // do not localize
  else
    Result := Format('%s%d%s', [Target.TargetType, Target.Version, Pers]); // do not localize
end;

function TTargetConfig.GetUnitOutDir: string;
begin
  if Target.IsBDS then
    Result := GetJVCLDir + Format('\lib\%s%d', [Target.TargetType, Target.Version]) // do not localize
  else
    Result := GetJVCLDir + Format('\lib\%s%d', [Target.TargetType, Target.Version]); // do not localize
end;

procedure TTargetConfig.SetInstallMode(Value: TInstallMode);
begin
  if Value <> FInstallMode then
  begin
    if not CLXSupport then
      Exclude(Value, pkCLX);
    if Value = [] then
      FInstallMode := [pkVcl]
    else
      FInstallMode := Value;
  end;
end;

function TTargetConfig.GetInstance: TObject;
begin
  Result := Self;
end;

function TTargetConfig.GetTarget: TCompileTarget;
begin
  Result := FTarget;
end;

function TTargetConfig.GetJVCLPackagesXmlDir: string;
begin
  Result := Owner.JVCLPackagesXmlDir;
end;

function TTargetConfig.GetJVCLDir: string;
begin
  Result := Owner.JVCLDir;
end;

function TTargetConfig.GetJVCLPackagesDir: string;
begin
  Result := Owner.JVCLPackagesDir;
end;

function TTargetConfig.GetJCLDir: string;
begin
  Result := FJCLDir;
end;

function TTargetConfig.GetJCLLibDir: string;
begin
  // Note: if the JCL changes its naming convention, a table of equivalences
  // would need to be built. Right now (2006/02/09), this is not necessary
  // as the format is always %type%version.
  Result := JCLDir + Format('\lib\%s%d', [Target.TargetType, Target.Version]);
end;

function TTargetConfig.GetHppDir: string;
begin
  Result := FHppDir;
end;

function TTargetConfig.GetDebugUnits: Boolean;
begin
  Result := FDebugUnits;
end;

function TTargetConfig.GetAutoDependencies: Boolean;
begin
  Result := FAutoDependencies and not Build;
end;

function TTargetConfig.GetBuild: Boolean;
begin
  Result := FBuild;
end;

function TTargetConfig.GetCompileOnly: Boolean;
begin
  Result := FCompileOnly;
end;

function TTargetConfig.GetGenerateMapFiles: Boolean;
begin
  Result := FGenerateMapFiles;
end;

function TTargetConfig.GetBplDir: string;
begin
  Result := FBplDir;
end;

function TTargetConfig.GetDcpDir: string;
begin
  Result := FDcpDir;
end;

function TTargetConfig.GetFrameworkCount: Integer;
var
  Kind: TPackageGroupKind;
begin
  Result := 0;
  for Kind := pkFirst to pkLast do
  begin
    if Frameworks.Items[Target.IsPersonal, Kind] <> nil then
      Inc(Result);
  end;
end;

function TTargetConfig.GetDeveloperInstall: Boolean;
begin
  Result := FDeveloperInstall;
end;

function TTargetConfig.GetDxgettextDir: string;
begin
  Result := Owner.DxgettextDir;
  if Result <> '' then
    if Target.Version = 5 then
      Result := Result + '\delphi5'; // do not localize
end;

procedure TTargetConfig.SetJCLDir(const Value: string);
var
  i: Integer;
begin
  if Value <> FJCLDir then
  begin
    FJCLDir := Value;

    // Check if the JCL is outdated
    FOutdatedJCL := False;
    for i := 0 to High(JCLIdentifyOutdated) do
    begin
      if JCLIdentifyOutdated[i] = '' then
        Continue;
      if JCLIdentifyOutdated[i][1] = '+' then
      begin
        if not FileExists(FJCLDir + Path(Copy(JCLIdentifyOutdated[i], 2, MaxInt))) then
        begin
          FOutdatedJCL := True;
          Break;
        end;
      end
      else if JCLIdentifyOutdated[i][1] = '-' then
      begin
        if FileExists(FJCLDir + Path(Copy(JCLIdentifyOutdated[i], 2, MaxInt))) then
        begin
          FOutdatedJCL := True;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TTargetConfig.Save;
var
  Kind: TPackageGroupKind;
  Ini: TMemIniFile;
  IniFileName: string;
begin
  if JVCLConfig.Modified then
  begin
    FileSetReadOnly(JVCLConfig.Filename, False);
    JVCLConfig.SaveToFile(JVCLConfig.Filename);
  end;

  for Kind := pkFirst to pkLast do
  begin
    if Frameworks.Items[False, Kind] <> nil then
      SavePackagesSettings(Frameworks.Items[False, Kind]);
    if Frameworks.Items[True, Kind] <> nil then
      SavePackagesSettings(Frameworks.Items[True, Kind]);
  end;

  IniFileName := ChangeFileExt(ParamStr(0), '.ini'); // do not localize
  FileSetReadOnly(IniFileName, False);
  Ini := TMemIniFile.Create(IniFileName);
  try
    if JCLDir = FDefaultJCLDir then
      Ini.DeleteKey(Target.DisplayName, 'JCLDir') // do not localize
    else
      Ini.WriteString(Target.DisplayName, 'JCLDir', JCLDir); // do not localize

    if not Target.SupportsPersonalities([persBCB]) or (HppDir = FDefaultHppDir) then
      Ini.DeleteKey(Target.DisplayName, 'HPPDir') // do not localize
    else
      Ini.WriteString(Target.DisplayName, 'HPPDir', HppDir); // do not localize

    if BplDir = Target.BplDir then
      Ini.DeleteKey(Target.DisplayName, 'BPLDir') // do not localize
    else
      Ini.WriteString(Target.DisplayName, 'BPLDir', BplDir); // do not localize

    if DcpDir = Target.DcpDir then
      Ini.DeleteKey(Target.DisplayName, 'DCPDir') // do not localize
    else
      Ini.WriteString(Target.DisplayName, 'DCPDir', DcpDir); // do not localize

    Ini.WriteBool(Target.DisplayName, 'DeveloperInstall', DeveloperInstall); // do not localize
    Ini.WriteBool(Target.DisplayName, 'CleanPalettes', CleanPalettes); // do not localize
    for Kind := pkFirst to pkLast do
      Ini.WriteBool(Target.DisplayName, 'InstallMode_' + IntToStr(Integer(Kind)), Kind in InstallMode); // do not localize
    Ini.WriteBool(Target.DisplayName, 'AutoDependencies', AutoDependencies); // do not localize
    Ini.WriteBool(Target.DisplayName, 'GenerateMapFiles', GenerateMapFiles); // do not localize
    Ini.WriteBool(Target.DisplayName, 'DebugUnits', DebugUnits); // do not localize

    Ini.UpdateFile;
  finally
    Ini.Free;
  end;
end;

procedure TTargetConfig.Load;
var
  Kind: TPackageGroupKind;
  Ini: TMemIniFile;
  Mode: TInstallMode;
  Filename: string;
begin
  for Kind := pkFirst to pkLast do
  begin
    if Frameworks.Items[False, Kind] <> nil then
      ResetPackagesSettings(Frameworks.Items[False, Kind]);
    if Frameworks.Items[True, Kind] <> nil then
      ResetPackagesSettings(Frameworks.Items[True, Kind]);
  end;

  Ini := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    if JCLDir = '' then
      JCLDir := ExcludeTrailingPathDelimiter(Ini.ReadString(Target.DisplayName, 'JCLDir', JCLDir)); // do not localize
    HppDir := ExcludeTrailingPathDelimiter(Ini.ReadString(Target.DisplayName, 'HPPDir', HppDir));   // do not localize
    BplDir := ExcludeTrailingPathDelimiter(Ini.ReadString(Target.DisplayName, 'BPLDir', BplDir));   // do not localize
    DcpDir := ExcludeTrailingPathDelimiter(Ini.ReadString(Target.DisplayName, 'DCPDir', DcpDir));   // do not localize
    DeveloperInstall := Ini.ReadBool(Target.DisplayName, 'DeveloperInstall', DeveloperInstall); // do not localize
    CleanPalettes := Ini.ReadBool(Target.DisplayName, 'CleanPalettes', CleanPalettes); // do not localize
    GenerateMapFiles := Ini.ReadBool(Target.DisplayName, 'GenerateMapFiles', GenerateMapFiles); // do not localize
    DebugUnits := Ini.ReadBool(Target.DisplayName, 'DebugUnits', DebugUnits); // do not localize
    Mode := [];
    for Kind := pkFirst to pkLast do
      if Ini.ReadBool(Target.DisplayName, 'InstallMode_' + IntToStr(Integer(Kind)), Kind in InstallMode) then // do not localize
        Include(Mode, Kind);

    InstallMode := Mode;
    //AutoDependencies := Ini.ReadBool(Target.DisplayName, 'AutoDependencies', AutoDependencies);

    // fix "Delphi\\Projects" bug
    HppDir := FixBackslashBackslash(HppDir);
    BplDir := FixBackslashBackslash(BplDir);
    DcpDir := FixBackslashBackslash(DcpDir);

    // Load jvcl%t.inc. Or the jvclbase.inc when no jvcl%t.inc exists
    if Target.IsBDS then
      Filename := GetJVCLDir + '\common\' + Format('jvcl%s%d.inc', // do not localize
          [LowerCase(Target.TargetType), Target.Version])
    else
      Filename := GetJVCLDir + '\common\' + Format('jvcl%s%d.inc', // do not localize
          [LowerCase(Target.TargetType), Target.Version]);
    if not FileExists(Filename) then
    begin
      JVCLConfig.LoadFromFile(GetJVCLDir + '\common\jvclbase.inc'); // do not localize
      JVCLConfig.Filename := Filename;
      JVCLConfig.Modified := True; // must be stored
    end
    else
      JVCLConfig.LoadFromFile(Filename);

    // set (hidden) personal edition configuration
    JVCLConfig.Enabled['DelphiPersonalEdition'] := Target.IsPersonal; // do not localize

    UpdateOptions;
  finally
    Ini.Free;
  end;
end;

procedure TTargetConfig.EnableOption(const Name: string; Enable: Boolean);
begin
  if Name <> '' then
    JVCLConfig.Enabled[Name] := Enable and JVCLConfig.Enabled[Name];
end;

procedure TTargetConfig.ClearPackageCache(const Key: string; const AStartsWith: string);
var
  Reg: TRegistry;
  Names: TStrings;
  i: Integer;
begin
  Reg := TRegistry.Create;
  try
    if Reg.OpenKey(Target.RegistryKey + '\' + Key, False) then
    begin
      Names := TStringList.Create;
      try
        Reg.GetKeyNames(Names);
        Reg.CloseKey;
        for i := 0 to Names.Count - 1 do
          if StartsWith(Names[i], AStartsWith, True) then
            Reg.DeleteKey(Target.RegistryKey + '\' + Key + '\' + Names[i]);
      finally
        Names.Free;
      end;
    end;
  finally
    Reg.Free;
  end;
end;

function TTargetConfig.RegisterProjectGroupToIDE(ProjectGroup: TProjectGroup): Boolean;
var
  PackageIndex, i: Integer;
  KnownPackages, DisabledPackages: TDelphiPackageList;
  Target: TCompileTarget;
begin
  Target := ProjectGroup.Target;
  KnownPackages := Target.KnownPackages;
  DisabledPackages := Target.DisabledPackages;

  // remove JVCL packages
  for i := DisabledPackages.Count - 1 downto 0 do
    if StartsWith(DisabledPackages.Items[i].Name, 'Jv', True) then // do not localize
      DisabledPackages.Delete(i);

  for i := KnownPackages.Count - 1 downto 0 do
    if StartsWith(KnownPackages.Items[i].Name, 'Jv', True) then // do not localize
      KnownPackages.Delete(i);

  if Target.IsBDS then
    ClearPackageCache('Package Cache', 'Jv'); // do not localize

  for PackageIndex := 0 to ProjectGroup.Count - 1 do
  begin
    if ProjectGroup.Packages[PackageIndex].Install and
       ProjectTypeIsDesign(ProjectGroup.Packages[PackageIndex].Info.ProjectType) then
    begin
      KnownPackages.Add(
        ProjectGroup.TargetConfig.BplDir + '\' + ProjectGroup.Packages[PackageIndex].TargetName, // do not localize
        ProjectGroup.Packages[PackageIndex].Info.Description
      );
    end;
  end;

  ProjectGroup.Target.SavePaths;
  ProjectGroup.Target.SavePackagesLists;
  Result := True;
end;

function TTargetConfig.RegisterToIDE: Boolean;
var
  Kind: TPackageGroupKind;
  i: Integer;
  AllPackages, PackageGroup: TProjectGroup;
begin
  if InstalledJVCLVersion < 3 then
    DeinstallJVCL(nil, nil);

  // remove old paths
  AddPaths(Target.BrowsingPaths, False, Owner.JVCLDir,
    ['common', 'run', 'Resources', 'qcommon', 'qrun']); // do not localize
  AddPaths(Target.SearchPaths, False, Owner.JVCLDir,
    ['common', 'run', 'Resources', 'qcommon', 'qrun']); // do not localize
  AddPaths(Target.DebugDcuPaths, {Add:=}False, Owner.JVCLDir,
    [Target.InsertDirMacros(UnitOutDir + '\debug'), UnitOutDir + '\debug']); // do not localize

  // update paths
  AddPaths(Target.BrowsingPaths, True, Owner.JVCLDir, // Resources directory must not be in browse-paths
    ['common']); // do not localize
  AddPaths(Target.SearchPaths, True, Owner.JVCLDir,
    [Target.InsertDirMacros(UnitOutDir), 'common', 'Resources']); // do not localize
  if DebugUnits and not DeveloperInstall then
    AddPaths(Target.DebugDcuPaths, True, Owner.JVCLDir,
      [Target.InsertDirMacros(UnitOutDir + '\debug')]); // do not localize
  if Target.SupportsPersonalities([persBCB]) then
  begin
    AddPaths(Target.GlobalIncludePaths, True, Owner.JVCLDir,
     [Target.InsertDirMacros(HppDir)]);
    AddPaths(Target.GlobalCppSearchPaths, True, Owner.JVCLDir,
      ['Resources', Target.InsertDirMacros(UnitOutDir)]); // do not localize
  end;

  // add
  if pkVCL in InstallMode then
  begin
    AddPaths(Target.BrowsingPaths, True, Owner.JVCLDir,
      ['run']); // do not localize
    AddPaths(Target.SearchPaths, {Add:=}DeveloperInstall, Owner.JVCLDir,
      ['run']); // do not localize
  end;
  if pkCLX in InstallMode then
  begin
    AddPaths(Target.BrowsingPaths, True, Owner.JVCLDir,
      ['qcommon', 'qrun']); // do not localize
    AddPaths(Target.SearchPaths, {Add:=}DeveloperInstall, Owner.JVCLDir,
      ['qcommon', 'qrun']); // do not localize
  end;

  AllPackages := TProjectGroup.Create(Self, '');
  try
    for Kind := pkFirst to pkLast do
    begin
      if Kind in InstallMode then
      begin
        PackageGroup := Frameworks.Items[Target.IsPersonal, Kind];
        if PackageGroup <> nil then
        begin
          for i := 0 to PackageGroup.Count - 1 do
            if PackageGroup.Packages[i].Install then
              AllPackages.AddPackage(PackageGroup.Packages[i]);
        end;
      end;
    end;
    Result := RegisterProjectGroupToIDE(AllPackages);
  finally
    AllPackages.Free;
  end;
end;

procedure TTargetConfig.DoCleanPalette(Reg: TRegistry; const Name: string;
  RemoveEmptyPalettes: Boolean);
var
  Entries, S: string;
  List: TStrings;
  i, ps: Integer;
begin
  Entries := Reg.ReadString(Name);
  List := TStringList.Create;
  try
    ps := 0;
    for i := 1 to Length(Entries) do
      if Entries[i] = ';' then // do not localize
      begin
        List.Add(SubStr(Entries, ps + 1, i - 1));
        ps := i;
      end;
    if ps < Length(Entries) then
      List.Add(SubStr(Entries, ps + 1, Length(Entries)));

    for i := List.Count - 1 downto 0 do
    begin
      ps := Pos('.', List[i]); // for Delphi 6, 7 and BCB 6
      if Copy(List[i], ps + 1, 3) = RsComponentPalettePrefix then
        List.Delete(i);
    end;

    S := '';
    for i := 0 to List.Count - 1 do
      S := S + List[i] + ';'; // do not localize
    // last char is ';'

    if (S <> '') or (not RemoveEmptyPalettes) then
    begin
      if S <> Entries then
        Reg.WriteString(Name, S)
    end
    else
      Reg.DeleteValue(Name);

  finally
    List.Free;
  end;
end;

procedure TTargetConfig.CleanJVCLPalette(RemoveEmptyPalettes: Boolean);
var
  i: Integer;
  Reg: TRegistry;
  List: TStrings;
begin
  reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(Target.RegistryKey + '\Palette', False) then // do not localize
    begin
      List := TStringList.Create;
      try
        Reg.GetValueNames(List);
        for i := 0 to List.Count - 1 do
          DoCleanPalette(reg, List[i], RemoveEmptyPalettes);
      finally
        List.Free;
      end;
    end;

    if Target.IsBDS then
      ClearPackageCache('Palette\Cache', 'Jv'); // do not localize
  finally
    Reg.Free;
  end;
end;

procedure TTargetConfig.DeinstallJVCL(Progress: TDeinstallProgressEvent;
  DeleteFiles: TDeleteFilesEvent);

  procedure DoProgress(const Text: string; Position, Max: Integer);
  begin
    if Assigned(Progress) then
      Progress(Self, Text, Position, Max);
  end;

var
  MaxSteps: Integer;
  i: Integer;
  Ini: TMemIniFile;
  Kind: TPackageGroupKind;
begin
  MaxSteps := 4;
  if not Assigned(DeleteFiles) then
    Dec(MaxSteps);

{**}DoProgress(RsCleaningPalette, 0, MaxSteps);
  CleanJVCLPalette(True);

  if Target.IsBDS then
    ClearPackageCache('Package Cache', 'Jv'); // do not localize

{**}DoProgress(RsCleaningPathLists, 1, MaxSteps);

  // remove JVCL 1 and 2 directories
  for i := Target.BrowsingPaths.Count - 1 downto 0 do
    if Pos('\jvpack\', AnsiLowerCase(Target.BrowsingPaths[i])) <> 0 then // do not localize
      Target.BrowsingPaths.Delete(i);

  for i := Target.SearchPaths.Count - 1 downto 0 do
    if Pos('\jvpack\', AnsiLowerCase(Target.SearchPaths[i])) <> 0 then // do not localize
      Target.SearchPaths.Delete(i);


  // remove JVCL 3 directories
  AddPaths(Target.BrowsingPaths, {Add:=}False, Owner.JVCLDir,
    ['common', 'design', 'run', 'Resources', 'qcommon', 'qdesign', 'qrun']); // do not localize
  AddPaths(Target.SearchPaths, {Add:=}False, Owner.JVCLDir,
    ['common', 'design', 'run', 'Resources', 'qcommon', 'qdesign', 'qrun', // do not localize
    Target.InsertDirMacros(UnitOutDir), UnitOutDir]);
  AddPaths(Target.DebugDcuPaths, {Add:=}False, Owner.JVCLDir,
    [Target.InsertDirMacros(UnitOutDir + '\debug'), UnitOutDir + '\debug']); // do not localize
  if Target.SupportsPersonalities([persBCB]) then
  begin
    AddPaths(Target.GlobalIncludePaths, False, Owner.JVCLDir,
     [Target.InsertDirMacros(HppDir)]);
    AddPaths(Target.GlobalCppSearchPaths, False, Owner.JVCLDir,
      ['Resources', Target.InsertDirMacros(UnitOutDir)]); // do not localize
  end;
  Target.SavePaths;

{**}DoProgress(RsUnregisteringPackages, 2, MaxSteps);
  // remove JVCL packages
  with Target do
  begin
    for i := DisabledPackages.Count - 1 downto 0 do
      if StartsWith(DisabledPackages.Items[i].Name, 'Jv', True) then // do not localize
        DisabledPackages.Delete(i);

    for i := KnownPackages.Count - 1 downto 0 do
      if StartsWith(KnownPackages.Items[i].Name, 'Jv', True) then // do not localize
        KnownPackages.Delete(i);
  end;
  Target.SavePackagesLists;

  // clean ini file
  Ini := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini')); // do not localize
  try
    Ini.EraseSection(Target.DisplayName);
    for Kind := pkFirst to pkLast do
    begin
      if Frameworks.Items[False, Kind] <> nil then
        Ini.EraseSection(Frameworks.Items[False, Kind].BpgName);
      if Frameworks.Items[True, Kind] <> nil then
        Ini.EraseSection(Frameworks.Items[True, Kind].BpgName);
    end;
    Ini.UpdateFile;
  finally
    Ini.Free;
  end;

  if Assigned(DeleteFiles) then
  begin
{**}DoProgress(RsDeletingFiles, 3, MaxSteps);
    DeleteFiles(Self);
  end;

{**}DoProgress(RsComplete, MaxSteps, MaxSteps);
end;

{$I InstalledPackages.inc}

end.
