unit LMDSctDialects;
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

LMDSctDialects unit (YB)
------------------------
LMD Script Pack Importer Delphi IDE dialect handling utils

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Registry, Dialogs, ToolsApi, LMDSctImporterParser,
  LMDSctImporterFileUtils, LMDSctImporterUnitDoc;

type
  TLMDIDEDialect          = class;
  ELMDIDEDialectException = class(Exception);

  {********************** class TLMDIDEDialectProvider ************************}

  TLMDIDEDialectProvider = class
  private
    class procedure CreateDialect(out AResult: TLMDIDEDialect);
  public
    class function GetDialect: TLMDIDEDialect;
  end;

  {************************** class TLMDIDEDialect ****************************}

  TLMDIDEDialect = class(ILMDUnitDocEnvironment)
  private
    function  GetIDEOptionValue(const AOptName: string): string;
    function  TryGetIDEConfigKey(AIsLocMachine: Boolean; const ASubkey,
                                 AValName: string; out AResult: string): Boolean;
    function  GetIDEConfigKey(AIsLocMachine: Boolean; const ASubkey,
                              AValName: string): string;
    function  ExpandIDEMacro(const APath: string): string;
    procedure AddPathList(const APathList: string; AResult: TStrings);
  protected
    function  GetIDEMacro: string; virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;

    procedure GetLibPaths(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  {*************** Dialects for different Delphi versions *********************}

  TLMDIDEDialect6 = class(TLMDIDEDialect)
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect7 = class(TLMDIDEDialect)
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect9 = class(TLMDIDEDialect) // 2005
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect10 = class(TLMDIDEDialect) // 2006
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect11 = class(TLMDIDEDialect) // 2007
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect12 = class(TLMDIDEDialect) // 2009
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect14 = class(TLMDIDEDialect) // 2010
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect15 = class(TLMDIDEDialect) // XE
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect16 = class(TLMDIDEDialect) // XE2
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect17 = class(TLMDIDEDialect) // XE3
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect18 = class(TLMDIDEDialect) // XE4
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect19 = class(TLMDIDEDialect) // XE5
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect20 = class(TLMDIDEDialect) // XE6
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect21 = class(TLMDIDEDialect) // XE7
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect22 = class(TLMDIDEDialect) // XE8
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect23 = class(TLMDIDEDialect) // Delphi 10
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect24 = class(TLMDIDEDialect) // Delphi 10.1
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

  TLMDIDEDialect25 = class(TLMDIDEDialect) // Delphi 10.2
  protected
    function  GetIDEMacro: string; override;
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); override;
    procedure GetLibPaths(AResult: TStrings); override;
    function  GetVCLImportSubpath: string; override;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); override;
    procedure GetNamespacePrefixes(AResult: TStrings); override;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; override;
  end;

implementation

uses
  LMDSctCst;

{ ---------------------------------------------------------------------------- }

var
  Dialect: TLMDIDEDialect;

procedure SplitToList(const AStr: string; AResult: TStrings);
var
  delpos: Integer;
  list:   string;
  s:   string;
begin
  list   := AStr;
  delpos := AnsiPos(';', list);

  while delpos > 0 do
  begin
    s := Trim(Copy(list, 1, delpos - 1));
    if s <> '' then
      AResult.Add(s);

    Delete(list, 1, delpos);
    delpos := AnsiPos(';', list);
  end;

  s := Trim(list);
  if s <> '' then
    AResult.Add(s);
end;

procedure GetNamespacePrefixesLow(ADialect: TLMDIDEDialect;
  AResult: TStrings);
var
  lib, ns: string;
  val:     string;
begin
  AResult.Clear;

  ns  := 'Namespace Search Path';
  lib := 'Library';

  if ADialect.TryGetIDEConfigKey(True, lib, ns, val) then
    SplitToList(val, AResult);
end;

{*********************** class TLMDIDEDialectProvider *************************}
{ --------------------------------- private ---------------------------------- }

class procedure TLMDIDEDialectProvider.CreateDialect(out AResult: TLMDIDEDialect);
begin
  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP25}
    AResult := TLMDIDEDialect25.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP24}
    AResult := TLMDIDEDialect24.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP23}
    AResult := TLMDIDEDialect23.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP22}
    AResult := TLMDIDEDialect22.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP21}
    AResult := TLMDIDEDialect21.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP20}
    AResult := TLMDIDEDialect20.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP19}
    AResult := TLMDIDEDialect19.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP18}
    AResult := TLMDIDEDialect18.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP17}
    AResult := TLMDIDEDialect17.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP16}
    AResult := TLMDIDEDialect16.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP15}
    AResult := TLMDIDEDialect15.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP14}
    AResult := TLMDIDEDialect14.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP12}
    AResult := TLMDIDEDialect12.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP11}
    AResult := TLMDIDEDialect11.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP10}
    AResult := TLMDIDEDialect10.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP9}
    AResult := TLMDIDEDialect9.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP7}
    AResult := TLMDIDEDialect7.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF DIALECT_IDE_DETECTED}
  {$IFDEF LMDCOMP6}
    AResult := TLMDIDEDialect6.Create;
    {$DEFINE DIALECT_IDE_DETECTED}
  {$ENDIF}
  {$ENDIF}
end;

{ --------------------------------- public ----------------------------------- }

class function TLMDIDEDialectProvider.GetDialect: TLMDIDEDialect;
begin
  if Dialect = nil then
    CreateDialect(Dialect);

  if Dialect = nil then
    raise ELMDIDEDialectException.Create(SLMDInvalidIDEVers);

  Result := Dialect;
end;

{*************************** class TLMDIDEDialect *****************************}
{ --------------------------------- private ---------------------------------- }

function TLMDIDEDialect.GetIDEOptionValue(const AOptName: string): string;
var
  opts: IOTAEnvironmentOptions;
begin
  opts   := (BorlandIDEServices as IOTAServices).GetEnvironmentOptions;
  Result := opts.Values[AOptName];
end;

function TLMDIDEDialect.TryGetIDEConfigKey(AIsLocMachine: Boolean;
  const ASubkey, AValName: string; out AResult: string): Boolean;
const
  ROOTS: array[Boolean] of HKEY = (HKEY_CURRENT_USER, HKEY_LOCAL_MACHINE);
var
  reg: TRegistry;
  key: string;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := ROOTS[AIsLocMachine];
    reg.Access  := KEY_READ;
    key         := (BorlandIDEServices as IOTAServices).GetBaseRegistryKey;

    if ASubkey <> '' then
      key := key + '\' + ASubkey;

    if reg.OpenKey(key, False) and reg.ValueExists(AValName) then
    begin
      AResult := reg.ReadString(AValName);
      Result  := True;
    end
    else
      Result := False;
  finally
    reg.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDIDEDialect.GetIDEConfigKey(AIsLocMachine: Boolean;
  const ASubkey: string; const AValName: string): string;
const
  ROOTS: array[Boolean] of HKEY = (HKEY_CURRENT_USER, HKEY_LOCAL_MACHINE);
var
  key: string;
begin
  if not TryGetIDEConfigKey(AIsLocMachine, ASubkey, AValName, Result) then
  begin
    key := (BorlandIDEServices as IOTAServices).GetBaseRegistryKey;
    if ASubkey <> '' then
      key := key + '\' + ASubkey;

    raise ELMDIDEDialectException.CreateFmt(SLMDNoIDEConfigKey, [key +
                                            '\' + AValName]);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDIDEDialect.ExpandIDEMacro(const APath: string): string;
var
  macro:   string;
  mpos:    Integer;
  rootdir: string;
begin
  macro   := GetIDEMacro;
  mpos    := AnsiPos(macro, APath);
  rootdir := ExcludeTrailingPathDelimiter(GetIDEConfigKey(True, '', 'RootDir'));

  if mpos > 0 then
    Result := Copy(APath, 1, mpos - 1) + rootdir +
              Copy(APath, mpos + Length(macro), MaxInt)
  else
    Result := APath;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect.AddPathList(const APathList: string;
  AResult: TStrings);
var
  delpos: Integer;
  list:   string;
  path:   string;
begin
  list   := APathList;
  delpos := AnsiPos(';', list);

  while delpos > 0 do
  begin
    path := Trim(Copy(list, 1, delpos - 1));
    if path <> '' then
      AResult.Add(ExpandIDEMacro(path));

    Delete(list, 1, delpos);
    delpos := AnsiPos(';', list);
  end;

  path := Trim(list);
  if path <> '' then
    AResult.Add(ExpandIDEMacro(path));
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDIDEDialect.Create;
begin
  inherited Create;
end;
        
{ ---------------------------------------------------------------------------- }

destructor TLMDIDEDialect.Destroy;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect.GetLibPaths(AResult: TStrings);
begin
  AResult.Clear;
  AddPathList(GetIDEOptionValue('LibraryPath'), AResult);
  AddPathList(GetIDEOptionValue('BrowsingPath'), AResult);
end;

procedure TLMDIDEDialect.GetNamespacePrefixes(AResult: TStrings);
begin
  AResult.Clear;
end;

{*************************** class TLMDIDEDialect7 ****************************}
{ -------------------------------- protected --------------------------------- }

function TLMDIDEDialect7.GetIDEMacro: string;
begin
  Result := '$(DELPHI)';
end;
            
{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect7.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER150');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('CPU386');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ ---------------------------------------------------------------------------- }

function TLMDIDEDialect7.GetVCLImportSubpath: string;
begin
  Result := 'd7';
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect7.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('SysUtils');
  AResult.Add('Classes');
  AResult.Add('Variants');
  AResult.Add('TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

{*************************** class TLMDIDEDialect9 ****************************}
{ -------------------------------- protected --------------------------------- }

function TLMDIDEDialect9.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;
         
{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect9.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER170');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('CPU386');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect9.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect9.GetNamespacePrefixes(AResult: TStrings);
begin
  GetNamespacePrefixesLow(self, AResult);
end;

{ ---------------------------------------------------------------------------- }

function TLMDIDEDialect9.GetVCLImportSubpath: string;
begin
  Result := 'd9';
end;
    
{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect9.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('Classes');
  AResult.Add('SysUtils');
  AResult.Add('Variants');
  AResult.Add('TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

{*************************** class TLMDIDEDialect10 ***************************}
{ -------------------------------- protected --------------------------------- }

function TLMDIDEDialect10.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;
         
{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect10.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER180');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('CPU386');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;
    
{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect10.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect10.GetNamespacePrefixes(AResult: TStrings);
begin
  GetNamespacePrefixesLow(self, AResult);
end;

{ ---------------------------------------------------------------------------- }

function TLMDIDEDialect10.GetVCLImportSubpath: string;
begin
  Result := 'd10';
end;
    
{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect10.GetStandardWrapperUsedUnits(
  AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('Classes');
  AResult.Add('SysUtils');
  AResult.Add('Variants');
  AResult.Add('TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

{ ---------------------------------------------------------------------------- }

{ TLMDIDEDialect11 }

function TLMDIDEDialect11.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 18.5;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.1.5';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.2;
    Result := True;
  end;
end;

function TLMDIDEDialect11.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

{ ---------------------------------------------------------------------------- }

function TLMDIDEDialect11.GetVCLImportSubpath: string;
begin
  Result := 'd11';
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect11.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER180');
  AParser.Define('VER185');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('CPU386');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect11.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect11.GetNamespacePrefixes(AResult: TStrings);
begin
  GetNamespacePrefixesLow(Self, AResult);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDIDEDialect11.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('Classes');
  AResult.Add('SysUtils');
  AResult.Add('Variants');
  AResult.Add('TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
  AResult.Add('Types');
end;

{ ---------------------------------------------------------------------------- }

{ TLMDIDEDialect12 }

function TLMDIDEDialect12.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 20.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.2.5';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.3;
    Result := True;
  end;
end;

function TLMDIDEDialect12.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

function TLMDIDEDialect12.GetVCLImportSubpath: string;
begin
  Result := 'd12';
end;

procedure TLMDIDEDialect12.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER200');
  AParser.Define('UNICODE');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('CPU386');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

procedure TLMDIDEDialect12.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect12.GetNamespacePrefixes(AResult: TStrings);
begin
  GetNamespacePrefixesLow(Self, AResult);
end;

procedure TLMDIDEDialect12.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('Classes');
  AResult.Add('SysUtils');
  AResult.Add('Variants');
  AResult.Add('TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
  AResult.Add('Types');
end;

{ TLMDIDEDialect6 }

function TLMDIDEDialect6.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 14.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '8.0.25';
    Result := True;
  end;
end;

function TLMDIDEDialect6.GetIDEMacro: string;
begin
  Result := '$(DELPHI)';
end;

function TLMDIDEDialect6.GetVCLImportSubpath: string;
begin
  Result := 'd6';
end;

procedure TLMDIDEDialect6.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER140');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('CPU386');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

procedure TLMDIDEDialect6.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('SysUtils');
  AResult.Add('Classes');
  AResult.Add('Variants');
  AResult.Add('TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctClass'); // Contains FindVarData function.
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

{ TLMDIDEDialect14 }

function TLMDIDEDialect14.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 21.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.3.5';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect14.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

function TLMDIDEDialect14.GetVCLImportSubpath: string;
begin
  Result := 'd14';
end;

procedure TLMDIDEDialect14.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER210');
  AParser.Define('UNICODE');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('CPU386');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

procedure TLMDIDEDialect14.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect14.GetNamespacePrefixes(AResult: TStrings);
begin
  GetNamespacePrefixesLow(Self, AResult);
end;

procedure TLMDIDEDialect14.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('Types');
  AResult.Add('Classes');
  AResult.Add('SysUtils');
  AResult.Add('Variants');
  AResult.Add('TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

function TLMDIDEDialect.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;
end;

function TLMDIDEDialect7.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 15.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '9.00.10';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.2;
    Result := True;
  end;
end;

function TLMDIDEDialect9.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 17.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.0.20';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.2;
    Result := True;
  end;
end;

function TLMDIDEDialect10.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 18.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.0.20';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.2;
    Result := True;
  end;
end;

{ TLMDIDEDialect15 }

function TLMDIDEDialect15.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 22.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.5.7';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect15.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

function TLMDIDEDialect15.GetVCLImportSubpath: string;
begin
  Result := 'd15';
end;

procedure TLMDIDEDialect15.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER220');
  AParser.Define('UNICODE');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('CPU386');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

procedure TLMDIDEDialect15.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect15.GetNamespacePrefixes(AResult: TStrings);
begin
  GetNamespacePrefixesLow(Self, AResult);
end;

procedure TLMDIDEDialect15.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('Types');
  AResult.Add('Classes');
  AResult.Add('SysUtils');
  AResult.Add('Variants');
  AResult.Add('TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

{ TLMDIDEDialect16 }

function TLMDIDEDialect16.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 23.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.5.7';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect16.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

function TLMDIDEDialect16.GetVCLImportSubpath: string;
begin
  Result := 'd16';
end;

procedure TLMDIDEDialect16.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER230');
  AParser.Define('CPU386');
  AParser.Define('CPUX86');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('ASSEMBLER');
  AParser.Define('NATIVECODE');
  AParser.Define('UNICODE');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

procedure TLMDIDEDialect16.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect16.GetNamespacePrefixes(AResult: TStrings);
begin
  // There namespaces are not stored in
  // registry. At least for XE2.

  AResult.Clear;
  AResult.Add('System');
  AResult.Add('System.Win');
  AResult.Add('Winapi');
  AResult.Add('Data.Win');
  AResult.Add('Datasnap.Win');
  AResult.Add('Web');
  AResult.Add('Web.Win');
  AResult.Add('Soap');
  AResult.Add('Soap.Win');
  AResult.Add('Xml');
  AResult.Add('Xml.Win');
  AResult.Add('Data');
  AResult.Add('Datasnap');
  AResult.Add('Bde');
  AResult.Add('Vcl');
  AResult.Add('Vcl.Imaging');
  AResult.Add('Vcl.Touch');
  AResult.Add('Vcl.Samples');
  AResult.Add('Vcl.Shell');
end;

procedure TLMDIDEDialect16.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('System.Types');
  AResult.Add('System.Classes');
  AResult.Add('System.SysUtils');
  AResult.Add('System.Variants');
  AResult.Add('System.TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

{ TLMDIDEDialect17 }

function TLMDIDEDialect17.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 24.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.5.7';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect17.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

procedure TLMDIDEDialect17.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect17.GetNamespacePrefixes(AResult: TStrings);
begin
  // There namespaces are not stored in
  // registry. At least for XE2.

  AResult.Clear;
  AResult.Add('System');
  AResult.Add('System.Win');
  AResult.Add('Winapi');
  AResult.Add('Data.Win');
  AResult.Add('Datasnap.Win');
  AResult.Add('Web');
  AResult.Add('Web.Win');
  AResult.Add('Soap');
  AResult.Add('Soap.Win');
  AResult.Add('Xml');
  AResult.Add('Xml.Win');
  AResult.Add('Data');
  AResult.Add('Datasnap');
  AResult.Add('Bde');
  AResult.Add('Vcl');
  AResult.Add('Vcl.Imaging');
  AResult.Add('Vcl.Touch');
  AResult.Add('Vcl.Samples');
  AResult.Add('Vcl.Shell');
end;

procedure TLMDIDEDialect17.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('System.Types');
  AResult.Add('System.Classes');
  AResult.Add('System.SysUtils');
  AResult.Add('System.Variants');
  AResult.Add('System.TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

function TLMDIDEDialect17.GetVCLImportSubpath: string;
begin
  Result := 'd17';
end;

procedure TLMDIDEDialect17.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER240');
  AParser.Define('CPU386');
  AParser.Define('CPUX86');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('ASSEMBLER');
  AParser.Define('NATIVECODE');
  AParser.Define('UNICODE');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ TLMDIDEDialect18 }

function TLMDIDEDialect18.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 25.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.5.7';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect18.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

procedure TLMDIDEDialect18.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect18.GetNamespacePrefixes(AResult: TStrings);
begin
  // There namespaces are not stored in
  // registry. At least for XE2.

  AResult.Clear;
  AResult.Add('System');
  AResult.Add('System.Win');
  AResult.Add('Winapi');
  AResult.Add('Data.Win');
  AResult.Add('Datasnap.Win');
  AResult.Add('Web');
  AResult.Add('Web.Win');
  AResult.Add('Soap');
  AResult.Add('Soap.Win');
  AResult.Add('Xml');
  AResult.Add('Xml.Win');
  AResult.Add('Data');
  AResult.Add('Datasnap');
  AResult.Add('Bde');
  AResult.Add('Vcl');
  AResult.Add('Vcl.Imaging');
  AResult.Add('Vcl.Touch');
  AResult.Add('Vcl.Samples');
  AResult.Add('Vcl.Shell');
end;

procedure TLMDIDEDialect18.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('System.Types');
  AResult.Add('System.Classes');
  AResult.Add('System.SysUtils');
  AResult.Add('System.Variants');
  AResult.Add('System.TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

function TLMDIDEDialect18.GetVCLImportSubpath: string;
begin
  Result := 'd18';
end;

procedure TLMDIDEDialect18.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER250');
  AParser.Define('CPU386');
  AParser.Define('CPUX86');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('ASSEMBLER');
  AParser.Define('NATIVECODE');
  AParser.Define('UNICODE');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ TLMDIDEDialect19 }

function TLMDIDEDialect19.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 26.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.5.7';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect19.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

procedure TLMDIDEDialect19.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect19.GetNamespacePrefixes(AResult: TStrings);
begin
  // There namespaces are not stored in
  // registry. At least for XE2.

  AResult.Clear;
  AResult.Add('System');
  AResult.Add('System.Win');
  AResult.Add('Winapi');
  AResult.Add('Data.Win');
  AResult.Add('Datasnap.Win');
  AResult.Add('Web');
  AResult.Add('Web.Win');
  AResult.Add('Soap');
  AResult.Add('Soap.Win');
  AResult.Add('Xml');
  AResult.Add('Xml.Win');
  AResult.Add('Data');
  AResult.Add('Datasnap');
  AResult.Add('Bde');
  AResult.Add('Vcl');
  AResult.Add('Vcl.Imaging');
  AResult.Add('Vcl.Touch');
  AResult.Add('Vcl.Samples');
  AResult.Add('Vcl.Shell');
end;

procedure TLMDIDEDialect19.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('System.Types');
  AResult.Add('System.Classes');
  AResult.Add('System.SysUtils');
  AResult.Add('System.Variants');
  AResult.Add('System.TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

function TLMDIDEDialect19.GetVCLImportSubpath: string;
begin
  Result := 'd19';
end;

procedure TLMDIDEDialect19.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER260');
  AParser.Define('CPU386');
  AParser.Define('CPUX86');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('ASSEMBLER');
  AParser.Define('NATIVECODE');
  AParser.Define('UNICODE');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ TLMDIDEDialect20 }

function TLMDIDEDialect20.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 27.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.6.0.5122';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect20.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

procedure TLMDIDEDialect20.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect20.GetNamespacePrefixes(AResult: TStrings);
begin
  // There namespaces are not stored in
  // registry. At least for XE2.

  AResult.Clear;
  AResult.Add('System');
  AResult.Add('System.Win');
  AResult.Add('Winapi');
  AResult.Add('Data.Win');
  AResult.Add('Datasnap.Win');
  AResult.Add('Web');
  AResult.Add('Web.Win');
  AResult.Add('Soap');
  AResult.Add('Soap.Win');
  AResult.Add('Xml');
  AResult.Add('Xml.Win');
  AResult.Add('Data');
  AResult.Add('Datasnap');
  AResult.Add('Bde');
  AResult.Add('Vcl');
  AResult.Add('Vcl.Imaging');
  AResult.Add('Vcl.Touch');
  AResult.Add('Vcl.Samples');
  AResult.Add('Vcl.Shell');
end;

procedure TLMDIDEDialect20.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('System.Types');
  AResult.Add('System.Classes');
  AResult.Add('System.SysUtils');
  AResult.Add('System.Variants');
  AResult.Add('System.TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

function TLMDIDEDialect20.GetVCLImportSubpath: string;
begin
  Result := 'd20';
end;

procedure TLMDIDEDialect20.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER270');
  AParser.Define('CPU386');
  AParser.Define('CPUX86');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('ASSEMBLER');
  AParser.Define('NATIVECODE');
  AParser.Define('UNICODE');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ TLMDIDEDialect21 }

function TLMDIDEDialect21.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 28.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.6.0.5169';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect21.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

procedure TLMDIDEDialect21.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect21.GetNamespacePrefixes(AResult: TStrings);
begin
  // There namespaces are not stored in
  // registry. At least for XE2.

  AResult.Clear;
  AResult.Add('System');
  AResult.Add('System.Win');
  AResult.Add('Winapi');
  AResult.Add('Data.Win');
  AResult.Add('Datasnap.Win');
  AResult.Add('Web');
  AResult.Add('Web.Win');
  AResult.Add('Soap');
  AResult.Add('Soap.Win');
  AResult.Add('Xml');
  AResult.Add('Xml.Win');
  AResult.Add('Data');
  AResult.Add('Datasnap');
  AResult.Add('Bde');
  AResult.Add('Vcl');
  AResult.Add('Vcl.Imaging');
  AResult.Add('Vcl.Touch');
  AResult.Add('Vcl.Samples');
  AResult.Add('Vcl.Shell');
end;

procedure TLMDIDEDialect21.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('System.Types');
  AResult.Add('System.Classes');
  AResult.Add('System.SysUtils');
  AResult.Add('System.Variants');
  AResult.Add('System.TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

function TLMDIDEDialect21.GetVCLImportSubpath: string;
begin
  Result := 'd21';
end;

procedure TLMDIDEDialect21.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER280');
  AParser.Define('CPU386');
  AParser.Define('CPUX86');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('ASSEMBLER');
  AParser.Define('NATIVECODE');
  AParser.Define('UNICODE');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ TLMDIDEDialect22 }

function TLMDIDEDialect22.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 28.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.6.0.5169';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect22.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

procedure TLMDIDEDialect22.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect22.GetNamespacePrefixes(AResult: TStrings);
begin
  // There namespaces are not stored in
  // registry. At least for XE2.

  AResult.Clear;
  AResult.Add('System');
  AResult.Add('System.Win');
  AResult.Add('Winapi');
  AResult.Add('Data.Win');
  AResult.Add('Datasnap.Win');
  AResult.Add('Web');
  AResult.Add('Web.Win');
  AResult.Add('Soap');
  AResult.Add('Soap.Win');
  AResult.Add('Xml');
  AResult.Add('Xml.Win');
  AResult.Add('Data');
  AResult.Add('Datasnap');
  AResult.Add('Bde');
  AResult.Add('Vcl');
  AResult.Add('Vcl.Imaging');
  AResult.Add('Vcl.Touch');
  AResult.Add('Vcl.Samples');
  AResult.Add('Vcl.Shell');
end;

procedure TLMDIDEDialect22.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('System.Types');
  AResult.Add('System.Classes');
  AResult.Add('System.SysUtils');
  AResult.Add('System.Variants');
  AResult.Add('System.TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

function TLMDIDEDialect22.GetVCLImportSubpath: string;
begin
  Result := 'd22';
end;

procedure TLMDIDEDialect22.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER290');
  AParser.Define('CPU386');
  AParser.Define('CPUX86');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('ASSEMBLER');
  AParser.Define('NATIVECODE');
  AParser.Define('UNICODE');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ TLMDIDEDialect23 }

function TLMDIDEDialect23.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 30.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.6.0.5169';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect23.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

procedure TLMDIDEDialect23.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect23.GetNamespacePrefixes(AResult: TStrings);
begin
  // There namespaces are not stored in
  // registry. At least for XE2.

  AResult.Clear;
  AResult.Add('System');
  AResult.Add('System.Win');
  AResult.Add('Winapi');
  AResult.Add('Data.Win');
  AResult.Add('Datasnap.Win');
  AResult.Add('Web');
  AResult.Add('Web.Win');
  AResult.Add('Soap');
  AResult.Add('Soap.Win');
  AResult.Add('Xml');
  AResult.Add('Xml.Win');
  AResult.Add('Data');
  AResult.Add('Datasnap');
  AResult.Add('Bde');
  AResult.Add('Vcl');
  AResult.Add('Vcl.Imaging');
  AResult.Add('Vcl.Touch');
  AResult.Add('Vcl.Samples');
  AResult.Add('Vcl.Shell');
end;

procedure TLMDIDEDialect23.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('System.Types');
  AResult.Add('System.Classes');
  AResult.Add('System.SysUtils');
  AResult.Add('System.Variants');
  AResult.Add('System.TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

function TLMDIDEDialect23.GetVCLImportSubpath: string;
begin
  Result := 'd23';
end;

procedure TLMDIDEDialect23.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER290');
  AParser.Define('CPU386');
  AParser.Define('CPUX86');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('ASSEMBLER');
  AParser.Define('NATIVECODE');
  AParser.Define('UNICODE');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ TLMDIDEDialect24 }

function TLMDIDEDialect24.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 31.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.6.0.5169';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect24.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

procedure TLMDIDEDialect24.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect24.GetNamespacePrefixes(AResult: TStrings);
begin
  // There namespaces are not stored in
  // registry. At least for XE2.

  AResult.Clear;
  AResult.Add('System');
  AResult.Add('System.Win');
  AResult.Add('Winapi');
  AResult.Add('Data.Win');
  AResult.Add('Datasnap.Win');
  AResult.Add('Web');
  AResult.Add('Web.Win');
  AResult.Add('Soap');
  AResult.Add('Soap.Win');
  AResult.Add('Xml');
  AResult.Add('Xml.Win');
  AResult.Add('Data');
  AResult.Add('Datasnap');
  AResult.Add('Bde');
  AResult.Add('Vcl');
  AResult.Add('Vcl.Imaging');
  AResult.Add('Vcl.Touch');
  AResult.Add('Vcl.Samples');
  AResult.Add('Vcl.Shell');
end;

procedure TLMDIDEDialect24.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('System.Types');
  AResult.Add('System.Classes');
  AResult.Add('System.SysUtils');
  AResult.Add('System.Variants');
  AResult.Add('System.TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

function TLMDIDEDialect24.GetVCLImportSubpath: string;
begin
  Result := 'd24';
end;

procedure TLMDIDEDialect24.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER310');
  AParser.Define('CPU386');
  AParser.Define('CPUX86');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('ASSEMBLER');
  AParser.Define('NATIVECODE');
  AParser.Define('UNICODE');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

{ TLMDIDEDialect25 }

function TLMDIDEDialect25.FindDirectiveConst(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := False;

  if SameText(AConstName, 'CompilerVersion') then
  begin
    AValue := 32.0;
    Result := True;
  end
  else if SameText(AConstName, 'gsIdVersion') then
  begin
    AValue := '10.6.0.5169';
    Result := True;
  end
  else if SameText(AConstName, 'DOMWrapperVersion') then
  begin
    AValue := 1.4;
    Result := True;
  end;
end;

function TLMDIDEDialect25.GetIDEMacro: string;
begin
  Result := '$(BDS)';
end;

procedure TLMDIDEDialect25.GetLibPaths(AResult: TStrings);
const
  SUBKEYS: array[0..1] of string = ('Browsing Path', 'Search Path');
var
  i:     Integer;
  paths: string;
begin
  AResult.Clear;

  for i := 0 to HIGH(SUBKEYS) do
  begin
    if TryGetIDEConfigKey(False, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult)
    else if TryGetIDEConfigKey(True, 'Library\Win32', SUBKEYS[i], paths) then
      AddPathList(paths, AResult);
  end;
end;

procedure TLMDIDEDialect25.GetNamespacePrefixes(AResult: TStrings);
begin
  // There namespaces are not stored in
  // registry. At least for XE2.

  AResult.Clear;
  AResult.Add('System');
  AResult.Add('System.Win');
  AResult.Add('Winapi');
  AResult.Add('Data.Win');
  AResult.Add('Datasnap.Win');
  AResult.Add('Web');
  AResult.Add('Web.Win');
  AResult.Add('Soap');
  AResult.Add('Soap.Win');
  AResult.Add('Xml');
  AResult.Add('Xml.Win');
  AResult.Add('Data');
  AResult.Add('Datasnap');
  AResult.Add('Bde');
  AResult.Add('Vcl');
  AResult.Add('Vcl.Imaging');
  AResult.Add('Vcl.Touch');
  AResult.Add('Vcl.Samples');
  AResult.Add('Vcl.Shell');
end;

procedure TLMDIDEDialect25.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  AResult.Clear;
  AResult.Add('System.Types');
  AResult.Add('System.Classes');
  AResult.Add('System.SysUtils');
  AResult.Add('System.Variants');
  AResult.Add('System.TypInfo');
  AResult.Add('LMDTypes');
  AResult.Add('LMDSctScripter');
  AResult.Add('LMDSctWrappers');
  AResult.Add('LMDSctSysWrappers');
end;

function TLMDIDEDialect25.GetVCLImportSubpath: string;
begin
  Result := 'd25';
end;

procedure TLMDIDEDialect25.MakeStandardDefines(AParser: TLMDPasParser);
begin
  AParser.Define('VER320');
  AParser.Define('CPU386');
  AParser.Define('CPUX86');
  AParser.Define('MSWINDOWS');
  AParser.Define('WIN32');
  AParser.Define('ASSEMBLER');
  AParser.Define('NATIVECODE');
  AParser.Define('UNICODE');
  AParser.Define('CONDITIONALEXPRESSIONS');
end;

initialization
  Dialect := nil;

{ ---------------------------------------------------------------------------- }

finalization
  Dialect.Free;

{ ---------------------------------------------------------------------------- }

end.
