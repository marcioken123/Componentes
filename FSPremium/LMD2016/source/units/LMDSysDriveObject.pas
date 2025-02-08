unit LMDSysDriveObject;
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

LMDSysDriveObject unit (RM, AH)
-------------------------------
Contains info about systems' drives.

ToDo
----
Format Disk / Dialogs, other drive relating functions/properties

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  LMDSysObject
  ;

type
  TLMDSysDriveType = (dtUnknown, dtNoRootDir, dtFloppy, dtFixed, dtNetwork, dtCDROM, dtRAM);

  TLMDSysFileSystemOption = (
    fsCaseIsPreserved,                  // The file system preserves the case of file names when it places a name on disk.
    fsCaseSensitive,                    // The file system supports case-sensitive file names.
    fsSupportsUnicode,                  // The file system supports Unicode in file names as they appear on disk.
    fsPersistentACLs,                   // The file system preserves and enforces ACLs. For example, NTFS preserves and enforces ACLs, and FAT does not.
    fsSupportsCompression,              // The file system supports file-based compression.
    fsIsCompressed,                     // The specified volume is a compressed volume; for example, a DoubleSpace volume.
    //fsSupportsNamedStreams,             // The file system supports named streams.
    //fsSupportsEncryption,               // The file system supports the Encrypted File System (EFS).
    //fsSupportsObjectIDs,                // The file system supports object identifiers.
    //fsSupportsReparsePoints,            // The file system supports reparse points.
    //fsSupportsSparseFiles,              // The file system supports sparse files.
    fsSupportsQuotas                    // The file system supports disk quotas.
    );
  TLMDSysFileSystemOptions = set of TLMDSysFileSystemOption;

  { ************************************************************************** }
  TLMDSysDriveObject = class(TLMDSysObject)
  private
    FDriveType: TLMDSysDriveType;
    FDrive: Char;
    FFileSystem,
      FSerialNumber,
      FVolumeLabel: string;
    FDiskSize,
      FDiskFree: Int64;
    FSectorsPerCluster,
      FBytesPerSector,
      FMaximumLength: DWORD;
    FOptions: TLMDSysFileSystemOptions;

    procedure SetDrive(aValue: Char);
    procedure SetDummyDriveType(aValue: TLMDSysDriveType);
    procedure SetDummyDWord(aValue: DWORD);
    procedure SetDummyInt64(aValue: Int64);
    procedure SetDummyString(const aValue: string);
    procedure SetDummyOptions(aValue: TLMDSysFileSystemOptions);
    procedure SetVolumeLabel(const aValue: string);
  protected
    procedure RegisterProperties; override;
  public
    constructor Create; override;
    //    procedure GetValues(aText: TStrings); override;
    procedure Refresh; override;
    procedure Apply; override;
    function DriveTypeStr(aValue: TLMDSysDriveType): string;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
  published
    property BytesPerSector: DWORD read FBytesPerSector write SetDummyDWord;
    property DiskSize: Int64 read FDiskSize write SetDummyInt64;
    property DiskFree: Int64 read FDiskFree write SetDummyInt64;
    property Drive: Char read FDrive write SetDrive;
    property DriveType: TLMDSysDriveType read FDriveType write SetDummyDriveType;
    property FileSystem: string read FFileSystem write SetDummyString;
    property SectorsPerCluster: DWORD read FSectorsPerCluster write SetDummyDWord;
    property MaximumLength: DWORD read FMaximumLength write SetDummyDWord;
    property SerialNumber: string read FSerialNumber write SetDummyString;
    property Options: TLMDSysFileSystemOptions read FOptions write SetDummyOptions;
    property VolumeLabel: string read FVolumeLabel write SetVolumeLabel;
  end;

  function LMDSysDriveOptionsToStr(aOptions : TLMDSysFileSystemOptions) : string;

implementation
uses
  SysUtils,
  LMDStrings,
  LMDSysConst;

const
  strDiskLabel = 'Disk:Label';

  cpidBytesPerSector            = 0;
  cpidDiskSize                  = 1;
  cpidDiskFree                  = 2;
  cpidDrive                     = 3;
  cpidDriveType                 = 4;
  cpidFileSystem                = 5;
  cpidSectorsPerCluster         = 6;
  cpidMaximumLength             = 7;
  cpidSerialNumber              = 8;
  cpidOptions                   = 9;
  cpidVolumeLabel               = 10;

{ ---------------------------------------------------------------------------- }
function LMDSysDriveOptionsToStr(aOptions : TLMDSysFileSystemOptions) : string;

  procedure AddOption(const aValue:String);
  begin
    if result<>'' then
      result:=result + ' | '+aValue
    else
      result:=aValue;
  end;

begin
  result := '';
  if fsCaseIsPreserved in aOptions then AddOption(sLMDSysDriveOptionCaseIsPreserved);
  if fsCaseSensitive in aOptions then AddOption(sLMDSysDriveOptionCaseSensitive);
  if fsSupportsUnicode in aOptions then AddOption(sLMDSysDriveOptionSupportsUnicode);
  if fsPersistentACLs in aOptions then AddOption(sLMDSysDriveOptionPersistentACLs);;
  if fsSupportsCompression in aOptions then AddOption(sLMDSysDriveOptionSupportsCompression);
  if fsIsCompressed in aOptions then AddOption(sLMDSysDriveOptionIsCompressed);
  if fsSupportsQuotas in aOptions then AddOption(sLMDSysDriveOptionSupportsQuotas);
  result := '['+result + ']';
end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDSysDriveObject.SetDrive(aValue: Char);
begin
  if aValue <> FDrive then
    begin
      aValue:= UpCase(aValue);
      if not LMDAnsiCharInSet(aValue, ['A'..'Z']) then
        begin
          aValue:= GetCurrentDir[1];
          if not LMDAnsiCharInSet(aValue, ['A'..'Z']) then 
            aValue:= 'C';
        end;
      FDrive:= aValue;
      Refresh;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDriveObject.SetDummyDriveType(aValue: TLMDSysDriveType);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDriveObject.SetDummyDWord(aValue: DWORD);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDriveObject.SetDummyInt64(aValue: Int64);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDriveObject.SetDummyOptions(aValue: TLMDSysFileSystemOptions);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDriveObject.SetDummyString(const aValue: string);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDriveObject.SetVolumeLabel(const aValue: string);
var
  tmp: string;
begin
  if FDrive <> aValue then
    begin
      RememberChange(strDiskLabel, FDrive, aValue);
      tmp:= FDrive + ':\';
      if Windows.SetVolumeLabel(PChar(tmp), PChar(aValue)) then
      begin
          WriteToLog(strDiskLabel);
          Refresh;
        end
      else
        RaiseLastWin32Error;
        end;

end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDSysDriveObject.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidBytesPerSector, sLMDSysDrivePropTitleBytesPerSector, sLMDSysDrivePropDescBytesPerSector);
  FPropertiesDesc.Add(cpidDiskSize , sLMDSysDrivePropTitleDiskSize, sLMDSysDrivePropDescDiskSize);
  FPropertiesDesc.Add(cpidDiskFree , sLMDSysDrivePropTitleDiskFree, sLMDSysDrivePropDescDiskFree);
  FPropertiesDesc.Add(cpidDrive , sLMDSysDrivePropTitleDrive, sLMDSysDrivePropDescDrive);
  FPropertiesDesc.Add(cpidDriveType , sLMDSysDrivePropTitleDriveType, sLMDSysDrivePropDescDriveType);
  FPropertiesDesc.Add(cpidFileSystem , sLMDSysDrivePropTitleFileSystem, sLMDSysDrivePropDescFileSystem);
  FPropertiesDesc.Add(cpidSectorsPerCluster , sLMDSysDrivePropTitleSectorsPerCluster, sLMDSysDrivePropDescSectorsPerCluster);
  FPropertiesDesc.Add(cpidMaximumLength , sLMDSysDrivePropTitleMaximumLength, sLMDSysDrivePropDescMaximumLength);
  FPropertiesDesc.Add(cpidSerialNumber , sLMDSysDrivePropTitleSerialNumber, sLMDSysDrivePropDescSerialNumber);
  FPropertiesDesc.Add(cpidOptions , sLMDSysDrivePropTitleOptions, sLMDSysDrivePropDescOptions);
  FPropertiesDesc.Add(cpidVolumeLabel , sLMDSysDrivePropTitleVolumeLabel, sLMDSysDrivePropDescVolumeLabel);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDSysDriveObject.Create;
begin
  inherited Create;
  FDrive:= 'C';
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDriveObject.Apply;
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDriveObject.Refresh;
var
  tmp: string;
  tmpByte: Byte;
  d1, d2: DWORD;
  serial: Integer;
  VolumeLabel, FileSystem: array[0..$FF] of Char;
  begin
  FPropertiesDesc.InvalidateProperties;

  tmp:= FDrive + ':\';
  tmpByte:= Byte(FDrive) - $40;
  FDriveType:= TLMDSysDriveType(GetDriveType(PChar(tmp)));
  FPropertiesDesc.PropertyByID(cpidDriveType).Text := DriveTypeStr(FDriveType);
  FDiskSize:= sysutils.DiskSize(tmpByte);
    FPropertiesDesc.PropertyByID(cpidDiskSize).Text := IntToStr(FDiskSize);
  FDiskFree:= sysutils.DiskFree(tmpByte);
    FPropertiesDesc.PropertyByID(cpidDiskFree).Text := IntToStr(FDiskFree);

  // better check Serial?
  if (FDiskSize = -1) and (FDriveType <> dtNetwork) then
    begin
      FVolumeLabel:= '';
      FFileSystem:= '';
      FSerialNumber:= '';
      FSectorsPerCluster:= 0;
      FBytesPerSector:= 0;
      FMaximumLength:= 0;
      FOptions:= [];
    end
  else
    begin
      GetDiskFreeSpace(PChar(tmp), FSectorsPerCluster, FBytesPerSector, d1, d2);
      GetVolumeInformation(PChar(tmp), VolumeLabel, SizeOf(VolumeLabel),
        @serial, FMaximumLength, d2, FileSystem, SizeOf(FileSystem));
      FVolumeLabel:= VolumeLabel;
      FFileSystem:= FileSystem;
      FSerialNumber:= IntToHex(serial, 8);
      Insert('-', FSerialNumber, 5);

      if FS_CASE_IS_PRESERVED and d2 = FS_CASE_IS_PRESERVED then FOptions:= [fsCaseIsPreserved];
      if FS_CASE_SENSITIVE and d2 = FS_CASE_SENSITIVE then Include(FOptions, fsCaseIsPreserved);
      if FS_UNICODE_STORED_ON_DISK and d2 = FS_UNICODE_STORED_ON_DISK then Include(FOptions, fsSupportsUnicode);
      if FS_PERSISTENT_ACLS and d2 = FS_PERSISTENT_ACLS then Include(FOptions, fsPersistentACLs);
      if FS_FILE_COMPRESSION and d2 = FS_FILE_COMPRESSION then Include(FOptions, fsSupportsCompression);
      if FS_VOL_IS_COMPRESSED and d2 = FS_VOL_IS_COMPRESSED then Include(FOptions, fsIsCompressed);
      if FFileSystem = 'NTFS' then
        if FILE_ATTRIBUTE_COMPRESSED and GetFileAttributes(PChar(tmp)) = FILE_ATTRIBUTE_COMPRESSED then Include(FOptions, fsIsCompressed);
        {if FILE_NAMED_STREAMS and d2 = FILE_NAMED_STREAMS then Include(FOptions, fsSupportsNamedStreams);
      if FILE_SUPPORTS_ENCRYPTION and d2 = FILE_SUPPORTS_ENCRYPTION then Include(FOptions, fsSupportsEncryption);
      if FILE_SUPPORTS_OBJECT_IDS and d2 = FILE_SUPPORTS_OBJECT_IDS then Include(FOptions, fsSupportsObjectIDs);
      if FILE_SUPPORTS_REPARSE_POINTS and d2 = FILE_SUPPORTS_REPARSE_POINTS then Include(FOptions, fsSupportsReparsePoints);
      if FILE_SUPPORTS_SPARSE_FILES and d2 = FILE_SUPPORTS_SPARSE_FILES then Include(FOptions, fsSupportsSparseFiles);
      if FILE_VOLUME_QUOTAS and d2 = FILE_VOLUME_QUOTAS then Include(FOptions, fsSupportsQuotas);}
      if $00000010 and d2 = $00000010 then Include(FOptions, fsSupportsQuotas);
    end;

  FPropertiesDesc.PropertyByID(cpidBytesPerSector).Text := IntToStr(FBytesPerSector);
  FPropertiesDesc.PropertyByID(cpidDrive).Text := FDrive;
  FPropertiesDesc.PropertyByID(cpidFileSystem).Text := FFileSystem;
  FPropertiesDesc.PropertyByID(cpidSectorsPerCluster).Text := IntToStr(FSectorsPerCluster);
  FPropertiesDesc.PropertyByID(cpidMaximumLength).Text := IntToStr(FMaximumLength);
  FPropertiesDesc.PropertyByID(cpidSerialNumber).Text := FSerialNumber;
  FPropertiesDesc.PropertyByID(cpidOptions).Text := LMDSysDriveOptionsToStr(FOptions);
  FPropertiesDesc.PropertyByID(cpidVolumeLabel).Text := FVolumeLabel;

end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDriveObject.DriveTypeStr(aValue: TLMDSysDriveType): string;
begin
  Result:= '';
  case aValue of
    dtUnknown: Result:= sLMDSysUNKNOWN;
    dtNoRootDir: Result:= sLMDSysNOROOTDIR;
    dtFloppy: Result:= sLMDSysREMOVABLE;
    dtFixed: Result:= sLMDSysFIXEDDRIVE;
    dtNetwork: Result:= sLMDSysREMOTE;
    dtCDROM: Result:= sLMDSysCDROM;
    dtRAM: Result:= sLMDSysRAMDISK;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDriveObject.GetElementTitle : string;
begin
  result := sLMDSysDriveObjectTitle + ' ('+FDrive+')';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDriveObject.GetElementDescription : string;
begin
  result := sLMDSysDriveObjectDesc;
end;

end.
