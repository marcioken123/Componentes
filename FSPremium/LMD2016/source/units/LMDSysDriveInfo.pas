unit LMDSysDriveInfo;
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

LMDSysDriveInfo unit (JH, AH)
-----------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes,
  LMDSysBase, LMDSysObject, LMDSysDriveObject;

type
  { ************************************************************************** }
  TLMDSysDriveItem = class(TLMDSysCollectionItem)
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
    function DriveTypeToStr(aValue: TLMDSysDriveType): string;
  protected
    procedure RegisterProperties; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Refresh;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

  published
    property BytesPerSector: DWORD read FBytesPerSector write SetDummyDWord stored false;
    property DiskSize: Int64 read FDiskSize write SetDummyInt64 stored false;
    property DiskFree: Int64 read FDiskFree write SetDummyInt64 stored false;
    property Drive: Char read FDrive write SetDrive stored false;
    property DriveType: TLMDSysDriveType read FDriveType write SetDummyDriveType stored false;
    property FileSystem: string read FFileSystem write SetDummyString stored false;
    property SectorsPerCluster: DWORD read FSectorsPerCluster write SetDummyDWord stored false;
    property MaximumLength: DWORD read FMaximumLength write SetDummyDWord stored false;
    property SerialNumber: string read FSerialNumber write SetDummyString stored false;
    property Options: TLMDSysFileSystemOptions read FOptions write SetDummyOptions stored false;
    property VolumeLabel: string read FVolumeLabel write SetVolumeLabel stored false;
  end;

  { ************************************************************************** }
  TLMDSysDrivesInfo = class(TLMDSysCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TLMDSysDriveItem;
    procedure SetItem(Index: Integer; Value: TLMDSysDriveItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDSysDriveItem;
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure Refresh;

    function GetElementTitle : string;  override;
    function GetElementDescription : string;  override;
    function GetElementType : TLMDSysInfoType; override;

    property Items[Index: Integer]: TLMDSysDriveItem read GetItem write SetItem; default;
  end;

implementation
uses
  SysUtils,
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

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDSysDriveItem.SetDrive(aValue: Char);
begin
  if aValue <> FDrive then
    begin
      aValue:= UpCase(aValue);
      if not (AnsiChar(aValue) in ['A'..'Z']) then
        begin
          aValue:= GetCurrentDir[1];
          if not (AnsiChar(aValue) in ['A'..'Z']) then aValue:= 'C';
        end;
      FDrive:= aValue;
      Refresh;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDriveItem.SetDummyDriveType(aValue: TLMDSysDriveType);
begin end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDriveItem.SetDummyDWord(aValue: DWORD);
begin end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDriveItem.SetDummyInt64(aValue: Int64);
begin end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDriveItem.SetDummyOptions(aValue: TLMDSysFileSystemOptions);
begin end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDriveItem.SetDummyString(const aValue: string);
begin end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDriveItem.SetVolumeLabel(const aValue: string);
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
procedure TLMDSysDriveItem.RegisterProperties;
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
constructor TLMDSysDriveItem.Create(Collection: TCollection);
begin
  inherited;
  FDrive:= 'C';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDriveItem.Refresh;
var
  tmp: string;
  tmpByte: Byte;
  d1, d2: DWORD;
  errormode:UInt;
  serial: DWORD;
  VolumeLabel, FileSystem: array[0..$FF] of Char;
begin
  FPropertiesDesc.InvalidateProperties;

  tmp:= FDrive + ':\';
  tmpByte:= Byte(FDrive) - $40;
  // 7.01
  errorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    FDriveType:= TLMDSysDriveType(GetDriveType(PChar(tmp)));
    FPropertiesDesc.PropertyByID(cpidDriveType).Text := DriveTypeToStr(FDriveType);
    if not (ansisametext(FDrive,'A') or ansisametext(FDrive,'a')) then
    begin
        FDiskSize:= Sysutils.DiskSize(tmpByte);
          FPropertiesDesc.PropertyByID(cpidDiskSize).Text := IntToStr(FDiskSize);
        FDiskFree:= sysutils.DiskFree(tmpByte);
          FPropertiesDesc.PropertyByID(cpidDiskFree).Text := IntToStr(FDiskFree);
      end;

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
          if $00000010 and d2 = $00000010 then Include(FOptions, fsSupportsQuotas);
      end;
  finally
    SetErrorMode(errorMode);
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
function TLMDSysDriveItem.DriveTypeToStr(aValue: TLMDSysDriveType): string;
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
function TLMDSysDriveItem.GetElementTitle : string;
begin
  result := sLMDSysDriveObjectTitle + ' ('+FDrive+')';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDriveItem.GetElementDescription : string;
begin
  result := sLMDSysDriveObjectDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDriveItem.GetElementType : TLMDSysInfoType;
begin
  result := itUnknown;
  case FDriveType of
    dtFloppy: result := itFloppyDrive;
    dtFixed: result := itFixedDrive;
    dtNetwork: result := itFixedDrive;
    dtCDROM: result := itCDROMDrive;
    dtRAM: result := itFixedDrive;
  end;
end;

{ ************************** TLMDSysDrivesInfo ******************************** }
{ -------------------------- private ----------------------------------------- }

function TLMDSysDrivesInfo.GetItem(Index: Integer): TLMDSysDriveItem;
begin
  Result:= TLMDSysDriveItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDrivesInfo.SetItem(Index: Integer; Value: TLMDSysDriveItem);
begin
  inherited SetItem(Index, Value);
end;

{ -------------------------- protected --------------------------------------- }

function TLMDSysDrivesInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ -------------------------- public ------------------------------------------ }

function TLMDSysDrivesInfo.Add: TLMDSysDriveItem;
begin
  Result:= TLMDSysDriveItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDSysDrivesInfo.Create(aOwner: TComponent);
begin
  inherited Create(TLMDSysDriveItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDSysDrivesInfo.Destroy;
begin
  FOwner:= nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDrivesInfo.Refresh;
var
  DriveNum: Integer;
  DriveChar: Char;
  DriveType: TLMDSysDriveType;
  DriveBits: set of 0..25;
  procedure AddDrive(const VolName: char);
  begin
    with Add do
      Drive := VolName;
  end;

begin
  Clear;
DoProgress(sLMDSysDriveObjectTitle, 100, 0);
  Integer(DriveBits) := GetLogicalDrives;
  for DriveNum := 0 to 25 do
  begin
    //    if not (DriveNum in DriveBits) then Continue;
    DriveChar := Char(DriveNum + Ord('a'));
    DriveType := TLMDSysDriveType(GetDriveType(PChar(DriveChar + ':\')));
    case DriveType of
      dtFloppy:   AddDrive(DriveChar);
      dtFixed:    AddDrive(DriveChar);//(VolumeID(DriveChar), FixedBMP);
      dtNetwork:  AddDrive(DriveChar);//(NetworkVolume(DriveChar), NetworkBMP);
      dtCDROM:    AddDrive(DriveChar);//(VolumeID(DriveChar), CDROMBMP);
      dtRAM:      AddDrive(DriveChar);//(VolumeID(DriveChar), RAMBMP);
    end;
    //DriveType := dtUnknown;
DoProgress(sLMDSysDriveObjectTitle, 100, DriveNum*4);
  end;
DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDrivesInfo.GetElementTitle : string;
begin
  result := sLMDSysDriveObjectTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDrivesInfo.GetElementDescription : string;
begin
  result := sLMDSysDriveObjectDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDrivesInfo.GetElementType : TLMDSysInfoType;
begin
  result := itDriveGroup;
end;

end.
