unit LMDSctImporterFileUtils;
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

LMDSctImporterFileUtils unit (YB)
---------------------------------
LMD Script Pack Importer specific file utils.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, Forms, Registry, FileCtrl;

type
  ELMDFileHandler = class(Exception);

  {************************** class TLMDFileHandler ***************************}

  TLMDFileHandler = class
  private
    FUnitPath:          string;
    FLibPaths:          TStrings;
    FNamespacePrefixes: TStrings;
    FVCLImportSubpath:  string;

    class function GetPathFromRegistry(const AKey: string): string;

    function  GetVCLStubPath: string;
    function  GetVCLWrapperPath: string;
    function  FindFullPath(const AShortFileName: string;
                           out APath: string): Boolean;
    procedure FindFiles(const ADirectory: string; const AMask: string;
                        AWithSubdirs: Boolean; AResFilePaths: TStrings);
  public
    constructor Create(const AUnitPath: string);
    destructor Destroy; override;

    class function GetVCLHintFileName: string;

    function FindStub(out APath: string): Boolean;
    function FindINCFile(const AIncFileName: string;
                         out APath: string): Boolean;
    function FindUsedPasFile(const AUnitName: string;
                             out APath: string): Boolean;
    function FindUsedUSUFile(const AUnitName: string;
                             out APath: string): Boolean;
    function FindUIMFile(out APath: string): Boolean;

    function GetUSUSavePath(AIsSysLib: Boolean): string;
    function GetUIMSavePath(AIsSysLib: Boolean): string;
    function GetWrapperUnitName(const AUnitName: string): string; // Not a file.
    function GetWrapperUnitSavePath(AIsSysLib: Boolean): string;

    property UnitPath: string read FUnitPath write FUnitPath;
    property VCLImportSubpath: string read FVCLImportSubpath write FVCLImportSubpath;
    property LibPaths: TStrings read FLibPaths;       // Changeable.
    property NamespacePrefixes: TStrings read FNamespacePrefixes;
  end;

implementation

uses
  LMDSctCst, LMDTypes;

{ ---------------------------------------------------------------------------- }

const
  LMDSCRIPTPACK_REGISTRYPATH  = LMDTOOLS_REGISTRYPATH + '\ScriptPack';
  VCLIMPORT_KEY               = 'VCLImportPath';

{************************** class TLMDFileHandler *****************************}
{--------------------------------- private ------------------------------------}

class function TLMDFileHandler.GetVCLHintFileName: string;
begin
  Result := IncludeTrailingPathDelimiter(GetPathFromRegistry(VCLIMPORT_KEY)) +
            'Hints.xml';
end;

{ ---------------------------------------------------------------------------- }

class function TLMDFileHandler.GetPathFromRegistry(const AKey: string): string;
var
  reg:  TRegistry;
  path: string;
begin
  reg := TRegistry.Create;
  try
    if Reg.OpenKey(LMDSCRIPTPACK_REGISTRYPATH, False) and
       Reg.ValueExists(AKey) then
    begin
      path := Reg.ReadString(AKey);
      if not DirectoryExists(path) then
        raise ELMDFileHandler.CreateFmt(SLMDDirNotExists, [path]);
    end
    else
      raise ELMDFileHandler.CreateFmt(SLMDRegValueNotExists,
        [LMDSCRIPTPACK_REGISTRYPATH + '\' + AKey]);

    Result := path;
  finally
    reg.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.GetVCLStubPath: string;
begin
  Result := IncludeTrailingPathDelimiter(GetPathFromRegistry(VCLIMPORT_KEY));
  Result := Result + IncludeTrailingPathDelimiter(FVCLImportSubpath);
  Result := Result + 'stub';
end;

{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.GetVCLWrapperPath: string;
begin
  Result := IncludeTrailingPathDelimiter(GetPathFromRegistry(VCLIMPORT_KEY));
  Result := Result + IncludeTrailingPathDelimiter(FVCLImportSubpath);
  Result := Result + 'wrapper';
end;

{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.FindFullPath(const AShortFileName: string;
  out APath: string): Boolean;

  function _MakePath(const ADirectory, AFileName: string): string;
  begin
    if ADirectory = '' then
      Result := AFileName
    else
      Result := IncludeTrailingPathDelimiter(ADirectory) + AFileName;
  end;

  function _FindFile(const ADirectory, AFileName: string;
                     out APath: string): Boolean;
  label
    L;
  var
    flnm: string;
    path: string;
    idx:  Integer;
  begin
    Result := False;
    idx    := -1; // bof
    path   := _MakePath(ADirectory, AFileName);

  L:
    if FileExists(path) then
    begin
      APath  := path;
      Result := True;
      Exit;
    end;

    Inc(idx);
    if idx < FNamespacePrefixes.Count then
    begin
      flnm := FNamespacePrefixes[idx];
      if (Length(flnm) > 0) and (flnm[Length(flnm)] <> '.') then
        flnm := flnm + '.';
      flnm := flnm + AFileName;
      path := _MakePath(ADirectory, flnm);

      goto L;
    end;
  end;

var
  i: Integer;
begin
  if _FindFile(ExtractFilePath(FUnitPath), AShortFileName, APath) then
  begin
    Result := True;
    Exit;
  end;

  for i := 0 to FLibPaths.Count - 1 do
    if _FindFile(FLibPaths[i], AShortFileName, APath) then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
end;
                     
{ ---------------------------------------------------------------------------- }

procedure TLMDFileHandler.FindFiles(const ADirectory, AMask: string;
  AWithSubdirs: Boolean; AResFilePaths: TStrings);
var
  path: string;
  sr:   TSearchRec;
begin
  path := IncludeTrailingPathDelimiter(ADirectory) + AMask;
  if FindFirst(path, faReadOnly	or faArchive, sr) = 0 then
  begin
    repeat
        AResFilePaths.Add(IncludeTrailingPathDelimiter(ADirectory) +
                          sr.Name);
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;

  path := IncludeTrailingPathDelimiter(ADirectory) + '*';
  if FindFirst(path, faDirectory, sr) = 0 then
  begin
    repeat
        if ((sr.Attr and faDirectory) <> 0) and
           (sr.Name <> '.') and (sr.Name <> '..') then
          FindFiles(IncludeTrailingPathDelimiter(ADirectory) + sr.Name,
                    AMask, True, AResFilePaths);
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

{----------------------------------- public -----------------------------------}

constructor TLMDFileHandler.Create(const AUnitPath: string);
begin
  inherited Create;
  FUnitPath          := AUnitPath;
  FLibPaths          := TStringList.Create;
  FNamespacePrefixes := TStringList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDFileHandler.Destroy;
begin
  FLibPaths.Free;
  FNamespacePrefixes.Free;
  inherited;
end;
                    
{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.FindStub(out APath: string): Boolean;
begin
  APath  := IncludeTrailingPathDelimiter(GetVCLStubPath) +
            ExtractFileName(FUnitPath);
  Result := FileExists(APath);
end;
             
{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.FindINCFile(const AIncFileName: string;
  out APath: string): Boolean;
begin
  // Searches included source in all specified directories.
  Result := FindFullPath(AIncFileName, APath);
end;

{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.FindUIMFile(out APath: string): Boolean;
begin
  // Searches *.uim file in the VCL-wrapper directory first.
  // Pregenerated *.uim files,  will be in this directory (But
  // corresponding *.pas files may be not).

  APath  := IncludeTrailingPathDelimiter(GetVCLWrapperPath) +
            ChangeFileExt(ExtractFileName(FUnitPath), '.uim');
  if FileExists(APath) then
  begin
    Result := True;
    Exit; // Handled.
  end;

  // Then check *.uim file in the same directory as module *.pas file.

  APath  := ChangeFileExt(FUnitPath, '.uim');
  Result := FileExists(APath);
end;

{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.FindUsedPasFile(const AUnitName: string;
  out APath: string): Boolean;
begin
  // Searches source file in all specified directories.
  Result := FindFullPath(AUnitName + '.pas', APath);
end;

{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.FindUsedUSUFile(const AUnitName: string;
  out APath: string): Boolean;
begin
  // Searches *.usu file in the VCL-wrapper directory first.
  // Pregenerated *.usu files will be in this directory (But
  // corresponding *.pas files may be not).

  APath := IncludeTrailingPathDelimiter(GetVCLWrapperPath) +
           AUnitName + '.usu';
  if FileExists(APath) then
  begin
    Result := True;
    Exit;
  end;

  // Then, searches the file in all specified directories.

  Result := FindFullPath(AUnitName + '.usu', APath);
end;

{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.GetUSUSavePath(AIsSysLib: Boolean): string;
var
  s: string;
begin
  // If unit is system library unit, then *.usu file directory is the
  // VCL-wrapper directory, otherwize directory is the same as for original
  // *.pas file.

  if AIsSysLib then
    s := IncludeTrailingPathDelimiter(GetVCLWrapperPath) +
         ExtractFileName(FUnitPath)
  else
    s := FUnitPath;

  Result := ChangeFileExt(s, '.usu');
end;
            
{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.GetUIMSavePath(AIsSysLib: Boolean): string;
var
  s: string;
begin
  // If unit is system library unit, then *.uim file directory is the
  // VCL-wrapper directory, otherwize directory is the same as for original
  // *.pas file.

  if AIsSysLib then
    s := IncludeTrailingPathDelimiter(GetVCLWrapperPath) +
         ExtractFileName(FUnitPath)
  else
    s := FUnitPath;

  Result := ChangeFileExt(s, '.uim');
end;
            
{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.GetWrapperUnitName(const AUnitName: string): string;
begin
  Result := AUnitName + '_LMDSW';
end;
       
{ ---------------------------------------------------------------------------- }

function TLMDFileHandler.GetWrapperUnitSavePath(AIsSysLib: Boolean): string;
var
  wrpunm: string;
begin
  // If unit is a system library unit, then wrapper file directory is the
  // VCL-wrapper directory, otherwize directory is the same as for original
  // *.pas file.

  wrpunm := GetWrapperUnitName(
    ChangeFileExt(ExtractFileName(FUnitPath), ''));

  if AIsSysLib then
    Result := IncludeTrailingPathDelimiter(GetVCLWrapperPath) +
              wrpunm + '.pas'
  else
    Result := IncludeTrailingPathDelimiter(ExtractFileDir(FUnitPath)) +
              wrpunm + '.pas';
end;
     
{ ---------------------------------------------------------------------------- }

end.
