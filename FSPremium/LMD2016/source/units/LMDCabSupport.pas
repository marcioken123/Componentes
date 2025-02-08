unit LMDCabSupport;
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

LMDCabSupport unit (RM)
-----------------------
Support of Windows CAB files which is part of system since Windows 98.

Changes
-------
Release 8.0 (March 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, SysUtils, Forms,
  LMDTypes, LMDClass, LMDProcs, LMDCustomComponent;

type
  ELMDCabError = class(Exception);

  TLMDFDIError = (FDINone, FDICabinetNotFound, FDINotACabinet, FDIUnknownCABVersion,
    FDICorruptCAB, FDIAllocFail, FDIBadCompressType, FDIMDIFail,
    FDITargetFile, FDIReserveMismatch, FDIWrongCabinet, FDIUserAbort);

  TLMDFCIError = (FCINone, FCIOpenSrc, FCIReadSrc, FCIAllocFail, FCITempFile,
    FCIBadCompressType, FCICabFile, FCIUserAbort, FCIMCIMail);

  TLMDFDICabinetInfo = record
    cbCabinet: Integer; // size of the archive
    cFolders: Word; // number of folders
    cFiles: Word; // number of files
    setID: Word; // application-defined magic #
    iCabinet: Word; // number of cabinet in set
    fReserve: Integer; // has reserved area?
    hasprev: Integer; // chained to previous?
    hasnext: Integer; // chained to next?
  end;

  TLMDCustomCabComponent = class;

  {******************* Object TLMDCabinetItem(s) ******************************}
  TLMDCabinetItem = class(TCollectionItem)
  private
    FDate: TDateTime;
    FFileName: AnsiString;
    FSize: Int64;
    FSelected: Boolean;
    FDestPath: AnsiString;
    function GetShortFileName: AnsiString;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property FileSize: Int64 read FSize write FSize;
    property FileDate: TDateTime read FDate write FDate;
    property Selected: Boolean read FSelected write FSelected;
    property FileName: AnsiString read FFileName write FFileName;
    property ShortFileName: AnsiString read GetShortFileName;
    // relative destination folder
    property DestinationPath: AnsiString read FDestPath write FDestPath;
  end;

  TLMDCabinetItems = class(TOwnedCollection)
  private
    FSelected: TLMDCabinetItem;
    function GetItem(index: Integer): TLMDCabinetItem;
    function GetSelCount: Integer;
  public
    constructor Create(Owner: TLMDCustomCabComponent);
    destructor Destroy; override;
    function Add: TLMDCabinetItem;
    property Selected: TLMDCabinetItem read FSelected write FSelected;
    property SelCount: Integer read GetSelCount;
    property Items[index: Integer]: TLMDCabinetItem read GetItem; default;
  end;

  {******************* Object TLMDCustomCabComponent **************************}
  TLMDCabProgessEvent = procedure(Sender: TObject; const FileName: AnsiString; FileIndex: LongInt; CurrentFileSize, CurrentCabSize: Int64) of object;
  TLMDCabErrorEvent = procedure(Sender: TObject; ErrorCode: Word) of object;

  TLMDCustomCabComponent = class(TLMDCustomComponent)
  private
    FItems: TLMDCabinetItems;
    FInternal: Byte; // specifies operating mode for callback function. 0=info, 1=copy
    FLastError: WORD;
    FCurrent: LongInt;
    FSourceSize: Int64;
    FRaiseExceptions: Boolean;
    FOnProgress: TLMDCabProgessEvent;
    FOnStart,
      FOnFinish: TNotifyEvent;
    FOnError: TLMDCabErrorEvent;
    function GetFileCount: Integer;
    function GetItem(Index: Integer): TLMDCabinetItem;
    function GetItemByName(const Index: AnsiString): TLMDCabinetItem;
  protected
    FFileName: TFileName;
    // calculates complete size of all files in items list
    function GetTotalFileSize: Int64; virtual; abstract;
    procedure DoHandleError(ErrorCode: WORD);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // clears filename and FileList
    procedure Reset;
    property Items: TLMDCabinetItems read FItems;
    property Item[Index: Integer]: TLMDCabinetItem read GetItem; default;
    property ItemByName[const Index: AnsiString]: TLMDCabinetItem read GetItemByName;
    property FileCount: Integer read GetFileCount;
    property LastError: WORD read FLastError;
    // accessing this property causes a full check of all file sizes in items list!
    property OriginalFileSize: Int64 read GetTotalFileSize;
    // Statistical function, available during or after (de)compress operations
    // Compress:        original file size of files about to be compressed
    // DeCompress:      original file size of files about to be decompressed,
    //                  considers Selected mode automatically
    property SourceFileSize: Int64 read FSourceSize;
  published
    property About;
    property RaiseExceptions: Boolean read FRaiseExceptions write FRaiseExceptions default false;
    property OnError: TLMDCabErrorEvent read FOnError write FOnError;
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
    property OnStart: TNotifyEvent read FOnStart write FOnStart;
    property OnProgress: TLMDCabProgessEvent read FOnProgress write FOnProgress;
  end;

  {******************* Object TLMDCabCompress *********************************}
  TLMDCabCompressionType = (cctNone, cctMSZIP, cctLZX);
  TLMDCabLZXLevel = (cllLowest, cllLower, cllLow, cllMedium, cllHigh, cllHigher, cllHighest);

  TLMDCabCompress = class(TLMDCustomCabComponent)
  private
    FFileName: TFileName;
    FCompressionType: TLMDCabCompressionType;
    FCompressionLevel: TLMDCabLZXLevel;
    FCompressedSize: Int64;
    function GetCompType: WORD;
  protected
    function DoProgress(typeStatus: UINT; cb1, cb2: Cardinal): LongInt;
    function GetTotalFileSize: Int64; override;
  public
    constructor Create(AOwner: TComponent); override;
    // AddFolder methods require a file mask. Example. AddFolder('C:\Windows\*.*);
    procedure AddFolder(const SourcePath: AnsiString); overload;
    procedure AddFolder(const SourcePath, DestPath: AnsiString); overload;
    // For very large folder structures a threaded grep routine should be used
    // (e.g. TLMDFileGrep, files should be added with AddFile then), otherwise
    // component blocks application too much.
    procedure AddFolder(const SourcePath, DestPath: AnsiString; RecurseDirs: Boolean); overload;
    procedure AddFile(const SourceName: AnsiString; const DestPath: AnsiString = '');
    // Compresses the current Items collection
    function Compress: Boolean;
    // properties available during/after compress operations.
    property CompressedFileSize: Int64 read FCompressedSize;
  published
    property CompressionType: TLMDCabCompressionType read FCompressionType write FCompressionType default cctMSZIP;
    property CompressionLZXLevel: TLMDCabLZXLevel read FCompressionLevel write FCompressionLevel default cllHighest;
    property FileName: TFileName read FFilename write FFileName;
  end;

  {******************* Object TLMDCabDeCompress *********************************}
type
  TLMDCabDeCompressOption = (dcoForceDirectories, dcoOverwriteFiles);
  TLMDCabDeCompressOptions = set of TLMDCabDeCompressOption;

const
  defCabOptions = [dcoForceDirectories, dcoOverwriteFiles];

type
  TLMDCabItemRequestEvent = procedure(Sender: TObject; const ItemName: AnsiString; var Cancel: Boolean) of object;

  TLMDCabDeCompress = class(TLMDCustomCabComponent)
  private
    FDestination: AnsiString;
    FExtractFileCount: Integer;
    FOptions: TLMDCabDeCompressOptions;
    FCurrentDeCompressed: Int64;
    FOnFolderRequired,
      FOnFileExists: TLMDCabItemRequestEvent;
    procedure SetFileName(const Value: TFileName);
    function GetSelCount: Integer;
    function GetSelected(index: Integer): Boolean;
    procedure SetSelected(index: Integer; const Value: Boolean);
  protected
    function DoDeCompress(op: Byte = 0): Boolean; virtual;
    function GetTotalFileSize: Int64; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // reloads content list
    procedure Refresh;
    // Extract functions
    function Extract(index: Integer): Boolean; overload;
    function Extract(const Value: TFileName): Boolean; overload;
    function Extract(item: TLMDCabinetItem): Boolean; overload;
    function Extract(Selected: Boolean = false): Boolean; overload; // handles all or selected items
    // info functions
    function IsCabFile(const Value: TFileName): Boolean;
    function IsMultiPart(const Value: TFileName): Boolean;
    function FileCountFromFile(const Value: TFileName): Integer;
    procedure GetFileList(aList: TStrings);
    // selection
    procedure SelectAll(doSelect: Boolean = true);
    property Selected[index: Integer]: Boolean read GetSelected write SetSelected;
    property SelCount: Integer read GetSelCount;
    // statistic properties available during Extraction operation (usually OnStart Event)
    property ExtractFileCount: Integer read FExtractFileCount;
  published
    property FileName: TFileName read FFileName write SetFileName;
    property DestinationPath: AnsiString read FDestination write FDestination;
    property Options: TLMDCabDeCompressOptions read FOptions write FOptions default defCabOptions;
    property OnFileExists: TLMDCabItemRequestEvent read FOnFileExists write FOnFileExists;
    property OnFolderRequired: TLMDCabItemRequestEvent read FOnFolderRequired write FOnFolderRequired;
  end;

  // simple helpers
  {------------------------------------------------------------------------------}
  // MultiPart cab file? Not supported in this release.
function LMDCABIsMultiPart(const FileName: AnsiString): Boolean;
// simple check
function LMDCABIsValidFile(const FileName: Ansistring): Boolean; overload;
// check for Cab file and returns info structure
function LMDCABIsValidFile(const FileName: Ansistring; var info: TLMDFDICabinetInfo): Boolean; overload;
// returns number of files stored in a cab file
function LMDCABGetFileCount(const FileName: Ansistring): Integer;
function LMDCabGetFileList(const CABFileName: AnsiString; filelist: TStrings): Boolean;
// returns Error AnsiString given for a valid
function LMDCabFCIErrorToString(ErrorCode: Word): AnsiString;
function LMDCabFDIErrorToString(ErrorCode: Word): AnsiString;
// fast compress/decompress methods
function LMDCabCompressFile(const CABFileName, SourceFileName: AnsiString; compType: TLMDCabCompressionType = cctMSZip): Boolean;
function LMDCabCompressFolder(const CABFileName, FolderName: AnsiString; subDirs: Boolean = true; compType: TLMDCabCompressionType = cctMSZip): Boolean;
function LMDCABExtractFile(const CABFileName, DestPath, SourceFileName: AnsiString): Boolean;
function LMDCABExtractAll(const CABFileName, DestPath: AnsiString): Boolean;

implementation

{$IFDEF LMDCOMP12}{$WARNINGS OFF}{$ENDIF}

uses
  FileCtrl,
  LMDStrings, LMDSysIn, LMDShUtils, LMDRTLXConst;

const
  CabinetDLL = 'Cabinet.dll'; // do lot localize

var
  hCabinetDll: HINST;

const
  // FDI notify codes
  ncCABInfo = 0; // General information about cabinet
  ncPartialFile = 1; // First file in cabinet is continuation
  ncCopyFile = 2; // File to be copied
  ncCloseFileInfo = 3; // close the file, set relevant info
  ncNextCabinet = 4; // File continued to next cabinet
  ncEnumerate = 5; // Enumeration status

  O_CREAT = $0100; //create and open file
  O_TRUNC = $0200; //open and truncate
  O_EXCL = $0400; //open only if file doesn't already exist

type
  TLMDERF = record
    ErrCode, ErrNo: Integer;
    ErrorPresent: Bool;
  end;

  // FDINOTIFICATION - Notification structure for PFNFDINOTIFY
  TLMDFDINotification = record
    FileSize: Integer; // uncomp size of the file (ncCopyFile only)
    FileName: PAnsiChar; // name of a file in the CAB
    psz2: PAnsiChar;
    psz3: PAnsiChar;
    AppValue: TLMDDataTag; //Pointer;     // application supplied value
    fd: Integer; // file handle
    Date: Word; // file's 16-bit FAT date
    Time: Word; // file's 16-bit FAT time
    Attribs: Word; // file's 16-bit FAT attributes
    setID: Word; // application-defined magic #
    iCabinet: Word; // number of this CAB
    iFolder: Word; // number of current 'folder'
    FDIError: Integer; // error code, if any
  end;

  // CCAB - Current Cabinet
  // This structure is used for passing in the cabinet parameters to FCI,
  // and is passed back on certain FCI callbacks to provide cabinet
  // information to the client.
  PCCAB = ^TCCAB;
  TCCAB = record
    cb: Longint; // size available for cabinet on this media
    cbFolderThresh: Longint; // Thresshold for forcing a new Folder
    cbReserveCFHeader: Integer; // Space to reserve in CFHEADER
    cbReserveCFFolder: Integer; // Space to reserve in CFFOLDER
    cbReserveCFData: Integer; // Space to reserve in CFDATA
    iCab: Integer; // sequential numbers for cabinets
    iDisk: Integer; // Disk number
    fFailOnIncompressible: BOOL; // TRUE => Fail if a block is incompressible
    setID: Smallint; // Cabinet set ID
    szDisk: array[0..255] of AnsiChar; // current disk name
    szCab: array[0..255] of AnsiChar; // current cabinet name
    szCabPath: array[0..255] of AnsiChar; // path for creating cabinet
    end;

const
  LMDFDIErrorStr: array[TLMDFDIError] of String =
  (SLMDCabNone, SLMDCabFDICabinetNotFound, SLMDCabFDINotACabinet, SLMDCabFDIUnknownCABVersion,
    SLMDCabFDICorruptCAB, SLMDCabAllocFail, SLMDCabBadCompressType, SLMDCabFDIMDIFail,
    SLMDCabFDITargetFile, SLMDCabFDIReserveMismatch, SLMDCabFDIWrongCabinet, SLMDCabUserAbort);

  LMDFCIErrorStr: array[TLMDFCIError] of String =
  (SLMDCabNone, SLMDCabFCIOpenSrc, SLMDCabFCIReadSrc, SLMDCabAllocFail, SLMDCabFCITEMPFILE,
    SLMDCabBadCompressType, SLMDCabFCICABFILE, SLMDCabUserAbort, SLMDCabFDIMCIFAIL);

var
  // FDI function types
  FDICreate: function(pAlloc, pFree, pOpen, pRead, pWrite, pClose, pSeek: Pointer; cpuType: Integer; var erf: TLMDERF): THandle; cdecl;
  FDICopy: function(h: THandle; CabName, CabPath: PAnsiChar; Flags: Integer; pNotify, pEncrypt, pUser: Pointer): Bool; cdecl;
  FDIDestroy: function(h: THandle): Bool; cdecl;
  FDIIsCabinet: function(h: THandle; fd: Integer; var info: TLMDFDICabinetInfo): Bool; cdecl;
  // FCI function types
  FCICreate: function(var erf: TLMDERF; pFileDest, pAlloc, pFree, pOpen, pRead, pWrite,
    pClose, pSeek, pDelete, pTempFile: Pointer; var cabinetDesc: TCCAB; pUser: Pointer): THandle; cdecl;
  FCIAddFile: function(h: THandle; pSourceFile, pFileName: PAnsiChar; Execute: Bool;
    pNextCabinet, pStatus, pOpeninfo: Pointer; typeCompress: Integer): Bool; cdecl;
  FCIFlushCabinet: function(h: THandle; NextCab: Bool; pNextCabinet, pStatus: Pointer): Bool; cdecl;
  FCIFlushFolder: function(h: THandle; pNextCabinet, pStatus: Pointer): Bool; cdecl;
  FCIDestroy: function(h: THandle): Bool; cdecl;
  // Callback routines used by FDI/FCI interface
  {------------------------------------------------------------------------------}
  // Shared
  {------------------------------------------------------------------------------}

function LMDAlloc(Bytes: Integer): Pointer; cdecl;
begin
  result := AllocMem(Bytes);
end;

{------------------------------------------------------------------------------}
function LMDFree(p: Pointer): Pointer; cdecl;
begin
  FreeMem(p);
  result := nil;
end;

// FDI

{------------------------------------------------------------------------------}
function LMDFDIRead(fd: Integer; buff: Pointer; bytes: Integer): Integer; cdecl;
begin
  result := _lread(fd, buff, bytes);
end;

{------------------------------------------------------------------------------}

function LMDFDIWrite(fd: Integer; buff: Pointer; bytes: Integer): Integer; cdecl;
begin
  result := _lwrite(fd, buff, bytes);
end;

// FCI
{------------------------------------------------------------------------------}

function LMDFCIOpen(FileName: PAnsiChar; oflag: Integer; Mode: Integer;
  Error: PInteger; pUser: Pointer): Integer; cdecl;
var
  tmpstrct: TOFSTRUCT;
begin
  if (oflag and O_CREAT = O_CREAT) then
    result := Windows.OpenFile(FileName, tmpstrct, (oflag and (OF_READ or OF_READWRITE)) or OF_CREATE)
  else
    result := _lopen(FileName, Mode);
  if result = integer(HFILE_ERROR) then
    Error^ := Integer(GetLastError);
end;

{------------------------------------------------------------------------------}

function LMDFCIClose(fd: Integer; Error: PInteger; pUser: Pointer): Integer; cdecl;
begin
  Error^ := 0;
  result := _lclose(fd);
  if result = integer(HFILE_ERROR) then
    Error^ := Integer(GetLastError);
end;

{------------------------------------------------------------------------------}

function LMDFCIDelete(FileName: PAnsiChar; Error: PInteger; pUser: Pointer): Integer cdecl;
begin
  result := 0;
  Error^ := 0;
  if not Windows.DeleteFileA(FileName) then
  begin
    Error^ := Integer(GetLastError);
    Result := -1;
  end;
end;

{------------------------------------------------------------------------------}

function LMDFCIGetNextCabinet(pccab: PCCAB; cbPrevCab: ULONG; pUser: Pointer): Bool; cdecl;
begin
  // not supported
  result := false;
end;

{------------------------------------------------------------------------------}
function LMDFCIRead(fd: Integer; buff: Pointer; bytes: Integer; Error: PInteger; pUser: Pointer): Integer; cdecl;
begin
  Error^ := 0;
  result := _lread(fd, buff, bytes);
  if result = integer(HFILE_ERROR) then
    Error^ := Integer(GetLastError);
end;

{------------------------------------------------------------------------------}

function LMDFCIWrite(fd: Integer; buff: Pointer; bytes: integer; Error: PInteger; pUser: Pointer): integer; cdecl;
begin
  Error^ := 0;
  result := _lwrite(fd, buff, bytes);
  if result = integer(HFILE_ERROR) then
    Error^ := Integer(GetLastError);
end;

{------------------------------------------------------------------------------}

function LMDFDISeek(fd: Integer; pos, mode: Integer): Integer; cdecl;
begin
  result := _llseek(fd, pos, mode);
end;

{------------------------------------------------------------------------------}

function LMDFCISeek(fd: Integer; pos, mode: Integer; Error: PInteger; pUser: Pointer): Integer; cdecl;
begin
  Error^ := 0;
  result := _llseek(fd, pos, mode);
  if result = integer(HFILE_ERROR) then
    Error^ := Integer(GetLastError);
end;

{------------------------------------------------------------------------------}

function LMDFCIStatus(typeStatus: UINT; cb1, cb2: Cardinal; pUser: Pointer): Longint; cdecl;
begin
  result := TLMDCabCompress(pUser).DoProgress(typeStatus, cb1, cb2);
end;

{------------------------------------------------------------------------------}

function LMDFCIGetTempFile(TempName: PAnsiChar; cbTempName: Integer; pUser: Pointer): Bool; cdecl;
var
  aName: AnsiString;
begin
  Result := Bool(false);
  aName := LMDSITempFile('cab');
  if (aName <> '') and (Length(aName) < cbTempName) then
  begin
    StrCopy(TempName, PAnsiChar(aName));
    Windows.DeleteFileA(TempName);
    Result := Bool(true);
  end;
end;

{------------------------------------------------------------------------------}

function LMDFCIOpenInfo(FileName: PAnsiChar; var pDate: Word; var pTime: Word; var pAttrib: Word;
  Error: PInteger; pUser: Pointer): Integer; cdecl;
var
  fh: THandle;
  FileTime: TFileTime;
  FileInfo: TByHandleFileInformation;
begin
  fh := CreateFileA(FileName, GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN, 0);
  if (fh = INVALID_HANDLE_VALUE) or not GetFileInformationByHandle(fh, FileInfo) then
  begin
    Error^ := Integer(GetLastError);
    result := -1;
    if fh <> INVALID_HANDLE_VALUE then
      CloseHandle(fh);
  end
  else
  begin
    FileTimeToLocalFileTime(FileInfo.ftLastWriteTime, FileTime);
    FileTimeToDosDateTime(FileTime, pDate, pTime);
    pAttrib := GetFileAttributesA(FileName) and (FILE_ATTRIBUTE_READONLY or
      FILE_ATTRIBUTE_HIDDEN or FILE_ATTRIBUTE_SYSTEM or FILE_ATTRIBUTE_ARCHIVE);
    CloseHandle(fh);
    result := _lopen(FileName, OF_READ);
    Error^ := 0;
  end;
end;

{------------------------------------------------------------------------------}

function LMDFCIFileDest(ccab: PCCAB; FileName: PAnsiChar; FileCount: Integer; fContinue: bool; pUser: Pointer): Integer; cdecl;
begin
  result := 0;
end;

{------------------------------------------------------------------------------}

function LMDFDIOpen(FileName: PAnsiChar; Mode: Integer): Integer; cdecl;

begin
  result := _lopen(FileName, Mode);
  end;

{------------------------------------------------------------------------------}
function LMDFDIClose(fd: Integer): Integer; cdecl;
begin
  result := _lclose(fd);
  end;

// standalone helper methods
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

function LMDCABIsValidFile(const FileName: AnsiString): Boolean;
var
  info: TLMDFDICabinetInfo;
begin
  result := LMDCABIsValidFile(FileName, info);
end;

{------------------------------------------------------------------------------}

function LMDCABIsValidFile(const FileName: AnsiString; var info: TLMDFDICabinetInfo): Boolean;
var
  fd: Integer;
  Context: THandle;
  erf: TLMDERF;
begin
  result := false;
  if not FileExists(FileName) then
    exit;
  Context := FDICreate(@LMDAlloc, @LMDFree, @LMDFDIOpen, @LMDFDIRead, @LMDFDIWrite,
    @LMDFDIClose, @LMDFDISeek, 0, erf);
  if Context <> 0 then
  try
    fd := LMDFDIOpen(PAnsiChar(FileName), of_Read);
    if fd <> -1 then
    try
      Result := FDIIsCabinet(Context, fd, info);
      finally
      LMDFDIClose(fd);
    end;
  finally
    FDIDestroy(Context);
  end;
end;

{------------------------------------------------------------------------------}

function LMDCABIsMultiPart(const FileName: AnsiString): Boolean;
var
  info: TLMDFDICabinetInfo;
begin
  result := LMDCabIsValidFile(FileName, info) and ((info.iCabinet > 0) or (info.hasPrev <> 0) or (info.hasNext <> 0));
end;

{------------------------------------------------------------------------------}

function LMDCABGetFileCount(const FileName: Ansistring): Integer;
var
  info: TLMDFDICabinetInfo;
begin
  result := 0;
  if LMDCabIsValidFile(FileName, info) then
    result := info.cFiles;
end;

{------------------------------------------------------------------------------}

function LMDCabFCIErrorToString(ErrorCode: Word): AnsiString;
begin
  if ErrorCode > Word(High(TLMDFCIError)) then
    result := SLMDCabUnknownErrorCode
  else
    result := LMDFCIErrorStr[TLMDFCIError(ErrorCode)];
end;

{------------------------------------------------------------------------------}

function LMDCabFDIErrorToString(ErrorCode: Word): AnsiString;
begin
  if ErrorCode > Word(High(TLMDFDIError)) then
    result := SLMDCabUnknownErrorCode
  else
    result := LMDFDIErrorStr[TLMDFDIError(ErrorCode)];
end;

{------------------------------------------------------------------------------}

function LMDCabCompressFile(const CABFileName, SourceFileName: AnsiString; compType: TLMDCabCompressionType = cctMSZip): Boolean;
begin
  result := false;
  if not FileExists(SourceFileName) then
    exit;
  with TLMDCabCompress.Create(nil) do
  try
    FileName := CabFileName;
    CompressionType := compType;
    AddFile(SourceFileName);
    result := Compress;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------------------}

function LMDCabCompressFolder(const CABFileName, FolderName: AnsiString; subDirs: Boolean = true; compType: TLMDCabCompressionType = cctMSZip): Boolean;
var
  tmp: AnsiString;
begin
  result := false;
  if not DirectoryExists(ExtractFileDir(FolderName)) then
    exit;
  if ExtractFileName(FolderName) = '' then
    tmp := LMDSlashAdd(FolderName) + '*.*'
  else
    tmp := FolderName;
  with TLMDCabCompress.Create(nil) do
  try
    FileName := CabFileName;
    CompressionType := compType;
    AddFolder(tmp, '', subDirs);
    result := Compress;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------------------}

function LMDCabGetFileList(const CABFileName: AnsiString; filelist: TStrings): Boolean;
begin
  result := false;
  if not FileExists(CabFileName) or not Assigned(filelist) then
    exit;
  with TLMDCabDeCompress.Create(nil) do
  try
    FileName := CabFileName;
    GetFileList(fileList);
    result := true;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------------------}

function LMDCABExtractFile(const CABFileName, DestPath, SourceFileName: AnsiString): Boolean;
begin
  result := false;
  if not FileExists(CabFileName) then
    exit;
  with TLMDCabDeCompress.Create(nil) do
  try
    FileName := CabFileName;
    DestinationPath := DestPath;
    result := Extract(SourceFileName);
  finally
    Free;
  end;
end;

{------------------------------------------------------------------------------}

function LMDCABExtractAll(const CABFileName, DestPath: AnsiString): Boolean;
begin
  result := false;
  if not FileExists(CabFileName) then
    exit;
  with TLMDCabDeCompress.Create(nil) do
  try
    FileName := CabFileName;
    DestinationPath := DestPath;
    result := Extract;
  finally
    Free;
  end;
end;

// CallBack functions
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

function LMDCabCallback(NotifyType: Integer; var Info: TLMDFDINotification): Integer; cdecl;

var
  cab: TLMDCustomCabComponent;
  FileTime: TFileTime;
  Path: AnsiString;
  Cancel: Boolean;

  function ProcessFile: Integer;
  begin
    result := 0;
    with TLMDCabDeCompress(cab) do
    begin
      Inc(FCurrentDeCompressed, info.FileSize);
      if Assigned(FOnProgress) then
        FOnProgress(TLMDCabDeCompress(cab), info.FileName, FCurrent, info.FileSize, FCurrentDeCompressed);
      Inc(FCurrent);

      // first handle path
      if LMDEmpty(DestinationPath) then
        Path := ExtractFileDir(ExpandFileName(info.FileName))
      else
        Path := LMDSlashAdd(DestinationPath) + ExtractFileDir(info.FileName);

      // Force Directory Option
      if not DirectoryExists(Path) then
      begin
        Cancel := not (dcoForceDirectories in Options);
        if Assigned(FOnFolderRequired) then
          FOnFolderRequired(cab, Path, Cancel);
        if not Cancel then
          ForceDirectories(Path)
        else
          exit;
      end;
      // --------------

      // Now handle file
      Path := LMDSlashAdd(DestinationPath) + info.FileName;
      // overwrite existing file?
      if FileExists(Path) then
      begin
        Cancel := not (dcoOverwriteFiles in Options);
        if Assigned(FOnFileExists) then
          FOnFileExists(cab, Path, Cancel);
        if Cancel then
          exit;
      end;

      result := _lcreat(PAnsiChar(Path), 0);
      if result = integer(HFILE_ERROR) then
        DoHandleError(Ord(FDITargetFile));
    end;
  end;

begin
  result := 0;
  cab := TLMDCabDeCompress(Info.AppValue);
  case NotifyType of
    ncCopyFile:
      case cab.FInternal of
        // get content of cab file
        0: with cab.Items.Add do
          begin
            FileName := Info.FileName;
            FileSize := Info.FileSize;
            FDestPath := ExtractFilePath(FileName);
            FileDate := FileDateToDateTime(MakeLong(Word(Info.Time), Word(Info.Date)));
          end;
        // single file
        1:
          if info.FileName = cab.Items.Selected.FileName then
            result := ProcessFile;
        // selected files
        2:
          if (cab.ItemByName[info.FileName] <> nil) and cab.ItemByName[info.FileName].Selected then
            result := ProcessFile;
      else
        // All Files
        result := ProcessFile;
      end;
    ncCloseFileInfo:
      begin
        result := 1;
        if cab.FInternal > 0 then
        begin
          // Not implemented yet for dotnet
          DosDateTimeToFileTime(Info.Date, Info.Time, FileTime);
          SetFileTime(Info.fd, nil, nil, @FileTime);
          LMDFDIClose(Info.fd);
        end;
      end;
  end;
end;

{******************* Object TLMDCabinetItem ***********************************}
{----------------------- private ----------------------------------------------}

function TLMDCabinetItem.GetShortFileName: AnsiString;
begin
  result := ExtractFileName(FileName);
end;

{----------------------- public -----------------------------------------------}

constructor TLMDCabinetItem.Create(Collection: TCollection);
begin
  inherited;
end;

{------------------------------------------------------------------------------}

destructor TLMDCabinetItem.Destroy;
begin
  inherited;
end;

{******************* Object TLMDCabinetItems **********************************}
{----------------------- private ----------------------------------------------}
{------------------------------------------------------------------------------}

function TLMDCabinetItems.GetItem(index: Integer): TLMDCabinetItem;
begin
  result := TLMDCabinetItem(inherited Items[index]);
end;

{------------------------------------------------------------------------------}

function TLMDCabinetItems.GetSelCount: Integer;
var
  i: Integer;
begin
  i := 0;
  result := 0;
  while (i < Count) do
  begin
    if Items[i].Selected then
      Inc(result);
    Inc(i);
  end;
end;

{----------------------- public -----------------------------------------------}

constructor TLMDCabinetItems.Create(Owner: TLMDCustomCabComponent);
begin
  inherited Create(Owner, TLMDCabinetItem);
end;

{------------------------------------------------------------------------------}

destructor TLMDCabinetItems.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDCabinetItems.Add: TLMDCabinetItem;
begin
  result := TLMDCabinetItem(inherited Add);
end;

{******************* Object TLMDCustomCabComponent ****************************}
{----------------------- private ----------------------------------------------}

function TLMDCustomCabComponent.GetFileCount: Integer;
begin
  result := FItems.Count;
end;

{------------------------------------------------------------------------------}

function TLMDCustomCabComponent.GetItem(Index: Integer): TLMDCabinetItem;
begin
  result := TLMDCabinetItem(FItems[Index]);
end;

{------------------------------------------------------------------------------}

function TLMDCustomCabComponent.GetItemByName(const Index: AnsiString): TLMDCabinetItem;
var
  i: integer;
begin
  result := nil;
  for i := 0 to FItems.Count - 1 do
    if FItems[i].FileName = Index then
    begin
      result := FItems[i];
      exit;
    end;
end;

{----------------------- protected --------------------------------------------}

procedure TLMDCustomCabComponent.DoHandleError(ErrorCode: WORD);
begin
  FLastError := ErrorCode;
  if Assigned(FOnError) then
    FOnError(self, ErrorCode);
  if FRaiseExceptions then
    if self is TLMDCabCompress then
      ELMDCabError.Create(LMDCabFCIErrorToString(ErrorCode))
    else
      ELMDCabError.Create(LMDCabFDIErrorToString(ErrorCode))
end;

{----------------------- public -----------------------------------------------}

constructor TLMDCustomCabComponent.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TLMDCabinetItems.Create(self);
end;

{------------------------------------------------------------------------------}

destructor TLMDCustomCabComponent.Destroy;
begin
  Reset;
  FreeAndNil(FItems);
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomCabComponent.Reset;
begin
  FFileName := '';
  FItems.Clear;
end;

{******************* Object TLMDCabCompress ***********************************}
{----------------------- private ----------------------------------------------}

function TLMDCabCompress.GetCompType: WORD;
begin
  result := 0;
  case FCompressionType of
    cctMSZIP: result := $01;
    cctLZX: result := ((Ord(FCompressionLevel) + 15) shl 8) or $003;
  end;
end;

{----------------------- protected --------------------------------------------}

function TLMDCabCompress.DoProgress(typeStatus: LongWord; cb1, cb2: Cardinal): LongInt;
{
    statusFile =      0;   // Add File to Folder callback
    statusFolder =    1;   // Add Folder to Cabinet callback
    statusCabinet =   2;   // Write out a completed cabinet callback
}
begin
  result := 0;
  if typeStatus = 0 then // statusfile only supported in this release
  begin
    // compressed size of files handled so far
    Inc(FCompressedSize, cb1);
    Inc(FSourceSize, cb2);
    // deliver data of current files
    if Assigned(FOnProgress) then
      FOnProgress(self, FItems[FCurrent].FileName, FCurrent, FSourceSize, FCompressedSize);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCabCompress.GetTotalFileSize: Int64;
var
  i: Integer;
begin
  // walk through all FItems and get their filesize
  result := 0;
  for i := 0 to FItems.Count - 1 do
  begin
    FItems[i].FileSize := LMDGetFileSize(ExpandFileName(FItems[i].FileName));
    if FItems[i].FileSize > -1 then
      result := result + FItems[i].FileSize;
  end;
end;

{----------------------- public -----------------------------------------------}

constructor TLMDCabCompress.Create(AOwner: TComponent);
begin
  inherited;
  FCompressionType := cctMSZIP;
  FCompressionLevel := cllHighest;
end;

{------------------------------------------------------------------------------}

procedure TLMDCabCompress.AddFile(const SourceName, DestPath: AnsiString);
begin
  with FItems.Add do
  begin
    FileName := SourceName;
    if FileExists(SourceName) then
    begin
      FileSize := LMDGetFileSize(FileName);
      FileDate := FileDateToDateTime(FileAge(FileName));
    end;
    DestinationPath := DestPath;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDCabCompress.AddFolder(const SourcePath, DestPath: AnsiString);
begin
  AddFolder(SourcePath, DestPath);
end;

{------------------------------------------------------------------------------}

procedure TLMDCabCompress.AddFolder(const SourcePath: AnsiString);
begin
  AddFolder(SourcePath, '', false);
end;

{------------------------------------------------------------------------------}

procedure TLMDCabCompress.AddFolder(const SourcePath, DestPath: AnsiString; RecurseDirs: Boolean);
var
  StartPath, Mask, FileName, Destination: AnsiString;
  search: TSearchRec;

  function FileTimeToDateTime(Time: TFileTime): TDateTime;
  var
    lt: TFileTime;
    dt: Integer;
    LTime, LDate: word;
  begin
    FileTimeToLocalFileTime(Time, lt);
    FileTimeToDosDateTime(lt, LDate, LTime);
    dt := MakeLong(LTime, LDate);
    try
      result := FileDateToDateTime(dt);
    except
      on EConvertError do
        Result := 0;
    end;
  end;

begin
  if LMDEmpty(SourcePath) then
    exit;
  StartPath := ExtractFilePath(SourcePath);
  Mask := ExtractFileName(SourcePath);
  Destination := DestPath;
  if not LMDEmpty(Destination) then
    Destination := LMDSlashAdd(Destination);

  if (FindFirst(SourcePath, faAnyFile, search) = 0) then
  try
    repeat
      Application.ProcessMessages;
      FileName := search.Name;
      if FileName[1] <> '.' then // ignore '.' and '..'
      begin
        // directory?
        if (search.Attr and faDirectory) = faDirectory then
        begin
          if RecurseDirs then
            AddFolder(StartPath + FileName + '\' + Mask, Destination + FileName, RecurseDirs);
        end
        else
          // file...
          if (search.Attr and faArchive) = faArchive then
            with FItems.Add do
            begin
              FileName := StartPath + search.Name;
              FileSize := LMDGetFileSize(FileName);
              FileDate := FileTimeToDateTime(search.FindData.ftLastWriteTime);
              DestinationPath := Destination;
            end;
      end;
    until FindNext(search) <> 0;
  finally
    FindClose(search);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCabCompress.Compress: Boolean;
var
  fh: THandle;
  cCabDesc: TCCab;
  erf: TLMDERF;
  i: Integer;
  sourcefile,
    destpath: AnsiString;
  const
  CB_MAX_DISK = $7FFFFFFF;

begin
  result := false;
  FLastError := 0;
  FSourceSize := 0;
  FCompressedSize := 0;

  // create Cabinet description
  FillChar(cCabDesc, SizeOf(cCabDesc), 0);
  // this release supports no thresholds, different multipart cabs etc.
  cCabDesc.cb := CB_MAX_DISK;
  cCabDesc.cbFolderThresh := CB_MAX_DISK;
  cCabDesc.FFailOnIncompressible := FALSE;
  cCabDesc.iDisk := 0;
  cCabDesc.setID := 0;
  cCabDesc.iCab := 1;
  StrCopy(cCabDesc.szCab, PAnsiChar(AnsiString(ExtractFileName(FFileName))));
  StrCopy(cCabDesc.szCabPath, PAnsiChar(AnsiString(ExtractFilePath(FFileName))));
  StrCopy(cCabDesc.szDisk, 'LMDCAB');
  // get file handle and set up callback functions
  fh := FCICreate(erf, @LMDFCIFileDest, @LMDAlloc, @LMDFree, @LMDFCIOpen, @LMDFCIRead, @LMDFCIWrite,
    @LMDFCIClose, @LMDFCISeek, @LMDFCIDelete, @LMDFCIGetTempFile, cCabDesc, self);
  try
    if Assigned(FOnStart) then
      FOnStart(self);
    for i := 0 to FItems.Count - 1 do
    begin
      Application.ProcessMessages;
      sourcefile := ExpandFileName(FItems[i].FileName);
      destpath := FItems[i].DestinationPath + ExtractFileName(FItems[i].FileName);
      FCurrent := i;
      if not FCIAddFile(fh, PAnsiChar(sourcefile), PAnsiChar(destPath), FALSE,
        @LMDFCIGetNextCabinet, @LMDFCIStatus, @LMDFCIOpenInfo, GetCompType) then
      DoHandleError(erf.ErrCode);
    end;

    if not FCIFlushCabinet(fh, FALSE, @LMDFCIGetNextCabinet, @LMDFCIStatus) then
    DoHandleError(erf.ErrCode)
    else
      result := true;
  finally
    FCIDestroy(fh);
    if Assigned(FOnFinish) then
      FOnFinish(self);
  end;
end;

{******************* Object TLMDCabDeCompress *********************************}
{----------------------- private ----------------------------------------------}

procedure TLMDCabDeCompress.SetFileName(const Value: TFileName);
begin
  FFileName := Value;
  if ([csLoading, csReading, csDestroying] * ComponentState = []) then
    Refresh;
end;

{------------------------------------------------------------------------------}

procedure TLMDCabDeCompress.SetSelected(index: Integer; const Value: Boolean);
begin
  FItems[index].Selected := Value;
end;

{------------------------------------------------------------------------------}

function TLMDCabDeCompress.GetSelCount: Integer;
begin
  result := FItems.SelCount;
end;

{------------------------------------------------------------------------------}

function TLMDCabDeCompress.GetSelected(index: Integer): Boolean;
begin
  result := FItems[index].Selected;
end;

{------------------------------------------------------------------------------}

function TLMDCabDeCompress.GetTotalFileSize: Int64;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to FItems.Count - 1 do
    Inc(result, FItems[i].FileSize);
end;

{------------------------------------------------------------------------------}

procedure TLMDCabDeCompress.Loaded;
begin
  inherited;
  if FFileName <> '' then
    Refresh;
end;

{----------------------- protected --------------------------------------------}

function TLMDCabDeCompress.DoDeCompress(op: Byte): Boolean;
var
  Context: THandle;
  erf: TLMDERF;
  i: Integer;
  begin
  result := false;

  FInternal := op;
  FExtractFileCount := 0;
  FSourceSize := 0;
  FCurrent := 0;
  FCurrentDeCompressed := 0;
  FLastError := 0;

  // new content list
  if FInternal = 0 then
    FItems.Clear;

  if not IsMultiPart(FFileName) then
  begin
    Context := FDICreate(@LMDAlloc, @LMDFree, @LMDFDIOpen, @LMDFDIRead, @LMDFDIWrite,
      @LMDFDIClose, @LMDFDISeek, 0, erf);
    if Context = 0 then
      DoHandleError(erf.ErrCode)
    else
    try
      if (FInternal > 0) then
      begin
        case FInternal of
          1:
            begin
              FSourceSize := FItems.Selected.FileSize;
              FExtractFileCount := 1;
            end;
          2:
            begin
              for i := 0 to FItems.Count - 1 do
                if FItems[i].Selected then
                  Inc(FSourceSize, FItems[i].FileSize);
              FExtractFileCount := SelCount;
            end;
        else
          begin
            FSourceSize := GetTotalFileSize;
            FExtractFileCount := GetFileCount;
          end;
        end;
        if Assigned(FOnStart) then
          FOnStart(self);
      end;

      result := FDICopy(Context, PAnsiChar(AnsiString(ExtractFileName(FFileName))),
        PAnsiChar(AnsiString(ExtractFilePath(FFileName))),
        0, @LMDCabCallback, nil, self);
      finally
      FDIDestroy(Context);
      if (FInternal > 0) and Assigned(FOnFinish) then
        FOnFinish(self);
      if not result then
        DoHandleError(GetLastError);
    end
  end
  else
    raise ELMDCabError.Create(SLMDCabNoMultiPart);
end;

{----------------------- public -----------------------------------------------}

constructor TLMDCabDeCompress.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := defCabOptions;
end;

{------------------------------------------------------------------------------}

destructor TLMDCabDeCompress.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDCabDeCompress.Extract(index: Integer): Boolean;
begin
  result := Extract(FItems[index]);
end;

{------------------------------------------------------------------------------}

function TLMDCabDeCompress.Extract(const Value: TFileName): Boolean;
begin
  result := Extract(ItemByName[Value]);
end;

{------------------------------------------------------------------------------}

function TLMDCabDeCompress.Extract(item: TLMDCabinetItem): Boolean;
var
  old: TLMDCabinetItem;
begin
  result := false;
  if item = nil then
    exit;
  old := FItems.Selected;
  try
    FItems.Selected := item;
    result := DoDeCompress(1);
  finally
    FItems.Selected := old;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCabDeCompress.Extract(Selected: Boolean = false): Boolean;
begin
  result := DoDeCompress(3 - Ord(Selected));
end;

{------------------------------------------------------------------------------}

function TLMDCabDeCompress.FileCountFromFile(const Value: TFileName): Integer;
begin
  result := LMDCabGetFileCount(Value);
end;

{------------------------------------------------------------------------------}

procedure TLMDCabDeCompress.GetFileList(aList: TStrings);
var
  i: Integer;
begin
  if not Assigned(aList) then
    exit;
  aList.Clear;
  for i := 0 to FItems.Count - 1 do
    aList.Add(FItems[i].FileName);
end;

{------------------------------------------------------------------------------}

function TLMDCabDeCompress.IsCabFile(const Value: TFileName): Boolean;
begin
  result := LMDCabIsValidFile(Value);
end;

{------------------------------------------------------------------------------}

function TLMDCabDeCompress.IsMultiPart(const Value: TFileName): Boolean;
begin
  result := LMDCabIsMultiPart(Value);
end;

{------------------------------------------------------------------------------}

procedure TLMDCabDeCompress.SelectAll(doSelect: Boolean);
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    FItems[i].Selected := doSelect;
end;

{------------------------------------------------------------------------------}

procedure TLMDCabDeCompress.Refresh;
begin
  if IsCabFile(FFileName) then
    DoDeCompress;
end;

// DLL Load/Unload
{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

procedure LoadCabDll;
begin
  hCabinetDll := SafeLoadLibrary(CabinetDLL);
  if hCabinetDll <> 0 then
  try
    // FDI functions
    @FDICreate := GetProcAddress(hCabinetDll, 'FDICreate');
    @FDIDestroy := GetProcAddress(hCabinetDll, 'FDIDestroy');
    @FDIIsCabinet := GetProcAddress(hCabinetDll, 'FDIIsCabinet');
    @FDICopy := GetProcAddress(hCabinetDll, 'FDICopy');
    // FCI functions
    @FCICreate := GetProcAddress(hCabinetDll, 'FCICreate');
    @FCIAddFile := GetProcAddress(hCabinetDll, 'FCIAddFile');
    @FCIFlushCabinet := GetProcAddress(hCabinetDll, 'FCIFlushCabinet');
    @FCIFlushFolder := GetProcAddress(hCabinetDll, 'FCIFlushFolder');
    @FCIDestroy := GetProcAddress(hCabinetDll, 'FCIDestroy');
    except
    on Exception do
    begin
      FreeLibrary(hCabinetDll);
      hCabinetDll := 0;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure UnLoadCabDll;
begin
  if hCabinetDll <> 0 then
    FreeLibrary(hCabinetDll);
end;

{ TLMDFCIHelper }

initialization
  LoadCabDll;

finalization
  UnLoadCabDll;

end.
