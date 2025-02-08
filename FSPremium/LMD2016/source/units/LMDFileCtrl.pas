unit LMDFileCtrl;
{$I lmdcmps.Inc}

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

LMDFileCtrl unit (RM)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Graphics, ImgList, SysUtils, LMDShBase;

type
  TLMDFileOpFlag=(ffFilesOnly, ffNoActionConfirm, ffNoMKDIRConfirm, ffRenameFileOnCollision, ffShowNoErrors, ffShowNoProgress, ffSimpleProgress, ffUseRecycleBin);
  TLMDFileOpFlags=set of TLMDFileOpFlag;

  TLMDFileCtrlAttribute=(fcaArchive, fcaDirectory, fcaHidden, fcaNormal, fcaOffline, fcaReadonly, fcaSystem,fcaTemporary, fcaCompressed);
  TLMDFileCtrlAttributes=set of TLMDFileCtrlAttribute;

  TLMDFileOperation=(foCopy, foRename, foMove, foDelete);

  TLMDFileCtrl = class(TLMDShellComponent)
  private
    FFileStampFormat : string;
    FFileName: TFileName;
    FOptions:TLMDFileOpFlags;
    // File-Attributes
    procedure SetAttributes (aValue : TLMDFileCtrlAttributes);
    function GetAttributes: TLMDFileCtrlAttributes;
    // Copy - Move - Delete - Rename
    function FileOps(aSource:String; aDestination:String; Operation:TLMDFileOperation):Boolean;
    // Filesize
    function GetFileBytes:LongInt;
    procedure SetFileBytes(aDummy: LongInt);
    // Timestamps
    function GetFileTimeb(index: Integer):String;
    procedure SetFileTimeb(index: Integer; aValue:String);
    // Filetype
    function GetFileType:String;
    procedure SetFileType(aDummy:String);
    // Associated Program-File
    function GetExecuteable:String;
    // More File-Infos
    function GetFileExtension:String;
    function GetShortAttrib:String;
    function GetFileExist:Boolean;
    function GetFilePath:String;
    function GetFileNameOnly:String;
    procedure SetFileName(const aValue:TFileName);
    // Icon-Operations
    function GetFileIconPath:String;
    function GetFileIconIndex:Integer;
    function GetSmallIconListHandle:DWORD;
    function GetLargeIconListHandle:DWORD;
    function GetLargeIconHeight:Integer;
    function GetSmallIconHeight:Integer;
    function GetLargeIconWidth:Integer;
    function GetSmallIconWidth:Integer;
    function GetIconNum:Integer;
  protected
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    // File-Ops
    function CopyFiles(aSource:String; aDestination:String):Boolean;
    function DeleteFiles(aSource:String):Boolean;
    function MoveFiles(aSource, aDestination:String):Boolean;
    function RenameFiles(aSource, aDestination:String):Boolean;
    // Icon-Operations
    procedure GetLargeFileIcon(var TempIcon:TIcon);
    procedure GetSmallFileIcon(var TempIcon:TIcon);
    procedure GetLargeIconFromFile(aIndex:DWord; var TempIcon:TIcon);
    procedure GetSmallIconFromFile(aIndex:DWord; var TempIcon:TIcon);
    procedure ExtractIconsFromFile(var TempList:TCustomImageList; Small:Boolean);
    property FileIconPath:String read GetFileIconPath;
    property FileIconSysIndex:Integer read GetFileIconIndex;
    property SmallIconSysList:DWORD read GetSmallIconListHandle;
    property LargeIconSysList:DWORD read GetLargeIconListHandle;
    property LargeIconHeight: Integer read GetLargeIconHeight;
    property SmallIconHeight: Integer read GetSmallIconHeight;
    property LargeIconWidth: Integer read GetLargeIconWidth;
    property SmallIconWidth: Integer read GetSmallIconWidth;
    property ExtractIconsNumber: Integer read GetIconNum;
    // More File-Infos
    property Executeable:String read GetExecuteable;
    property FileExtension:String read GetFileExtension;
    property ShortAttributes:String read GetShortAttrib;
    property FileExist:Boolean read GetFileExist;
    property FilePath:String read GetFilePath;
    property FileNameOnly:String read GetFileNameOnly;
  published
    property About;
    // the filename
    property FileName:TFileName read FFileName write SetFilename;
    // a set of file-attributes
    property Attributes:TLMDFileCtrlAttributes read GetAttributes write SetAttributes stored false;
    // a set of options according to file-ops
    property Options:TLMDFileOpFlags read FOptions write FOptions default [ffUseRecycleBin, ffFilesOnly];
    // the filesize
    property FileSize:LongInt read GetFileBytes write SetFileBytes stored false;
    // the file-create-time
    property FileCreateStamp:String index 0 read GetFileTimeb write SetFileTimeb stored false;
    // the time of last access to file
    property FileAccessStamp:String index 1 read GetFileTimeb write SetFileTimeb stored false;
    // the time file was last written
    property FileWriteStamp:String index 2 read GetFileTimeb write SetFileTimeb stored false;
    // the type of the file
    property FileType:String read GetFileType write SetFileType stored false;
    // 7.02
    property FileStampFormat : string read FFileStampFormat write FFileStampFormat;
  end;

implementation

uses

  ShellApi, LMDProcs, LMDShUtils, LMDSysIn, LMDRTLConst, LMDStrings;
  {--------------------------- LMDFileCtrl ------------------------------------- }
{--------------------------- private ----------------------------------------- }
{ read out file-attributes --------------------------------------------------- }
function TLMDFileCtrl.GetAttributes: TLMDFileCtrlAttributes;
  procedure CheckFlag(FA, Flag: dword; Attr: TLMDFileCtrlAttribute);
  begin
    if  (FA and Flag) = Flag  then
      Include(Result, Attr);
  end;

var
  FA: dword;
begin
  result := [];

  if FileExists(FFileName) then
    begin
      FA := GetFileAttributes(Int_Ref(FFileName));
      if  integer(FA) = -1  then
        exit;
      CheckFlag(FA, FILE_ATTRIBUTE_ARCHIVE, fcaArchive);
      CheckFlag(FA, FILE_ATTRIBUTE_DIRECTORY, fcaDirectory);
      CheckFlag(FA, FILE_ATTRIBUTE_HIDDEN, fcaHidden);
      CheckFlag(FA, FILE_ATTRIBUTE_NORMAL, fcaNormal);
      CheckFlag(FA, FILE_ATTRIBUTE_OFFLINE, fcaOffline);
      CheckFlag(FA, FILE_ATTRIBUTE_READONLY, fcaReadonly);
      CheckFlag(FA, FILE_ATTRIBUTE_SYSTEM, fcaSystem);
      CheckFlag(FA, FILE_ATTRIBUTE_TEMPORARY, fcaTemporary);
      CheckFlag(FA, FILE_ATTRIBUTE_COMPRESSED, fcaCompressed);
    end;
end;

{ set file-attributes -------------------------------------------------------- }
procedure TLMDFileCtrl.SetAttributes (aValue : TLMDFileCtrlAttributes);
var
  FileAttributesToSet:DWORD;
  FAttributes : TLMDFileCtrlAttributes;
begin
  FileAttributesToSet := 0;
  //if aValue <> FAttributes then
    if FileExists(FFilename) then
      begin
        FAttributes := aValue;
        if fcaArchive in FAttributes then
          FileAttributesToSet := FileAttributesToSet or FILE_ATTRIBUTE_ARCHIVE;
        if fcaDirectory in FAttributes then
          FileAttributesToSet := FileAttributesToSet or FILE_ATTRIBUTE_DIRECTORY;
        if fcaHidden in FAttributes then
          FileAttributesToSet := FileAttributesToSet or FILE_ATTRIBUTE_HIDDEN;
        if fcaNormal in FAttributes then
          FileAttributesToSet := FileAttributesToSet or FILE_ATTRIBUTE_NORMAL;
        if fcaOffline in FAttributes then
          FileAttributesToSet := FileAttributesToSet or FILE_ATTRIBUTE_OFFLINE;
        if fcaReadOnly in FAttributes then
          FileAttributesToSet := FileAttributesToSet or FILE_ATTRIBUTE_READONLY;
        if fcaSystem in FAttributes then
          FileAttributesToSet := FileAttributesToSet or FILE_ATTRIBUTE_SYSTEM;
        if fcaTemporary in FAttributes then
          FileAttributesToSet := FileAttributesToSet or FILE_ATTRIBUTE_TEMPORARY;
        if fcaCompressed in FAttributes then; // not implemented
        SetFileAttributes(int_Ref(FFileName), FileAttributesToSet);
      end
end;

{ the file-operations -------------------------------------------------------- }
function TLMDFileCtrl.FileOps(aSource:String; aDestination:String; Operation:TLMDFileOperation):Boolean;
var
  FileInfo: TSHFileOpStruct;
  i:TLMDFileOpFlag;
const
  FILEFLAGS:array [TLMDFileOpFlag] of Integer= (FOF_FILESONLY, FOF_NOCONFIRMATION, FOF_NOCONFIRMMKDIR, FOF_RENAMEONCOLLISION, FOF_NOERRORUI, FOF_SILENT, FOF_SIMPLEPROGRESS, FOF_ALLOWUNDO);
begin
  result:=false;
  if aSource='' then exit;
  with FileInfo do
    begin
      fAnyOperationsAborted:=false;
      hNameMappings:=nil;
      Wnd := 0;
      fFlags := 0;

      // check wether have a list of files
      if Pos(#0, aSource)=0 then aSource:=ExpandFileName(aSource)+#0;
      // the destination...
      if Pos(#0, aDestination)=0 then aDestination:=ExpandFileName(aDestination)+#0;
      //---

      pFrom  := Int_Ref(aSource);
      case Operation of
        foCopy:
          begin
            wFunc  := FO_COPY;
            pTo    := Int_Ref(aDestination);
            lpszProgressTitle := '';
          end;
        foMove:
          begin
            wFunc := FO_MOVE;
            pTo   := Int_Ref(aDestination);
            lpszProgressTitle := '';
          end;
        foDelete:
          begin
            wFunc  := FO_DELETE;
            pTo:=pFrom;
            lpszProgressTitle := '';
          end;
        foRename:
          begin
            wFunc  := FO_RENAME;
            pTo := Int_Ref(aDestination);
            lpszProgressTitle := '';
          end;
      end; // end of case
      for i:=Low(TLMDFileOpFlag) to High(TLMDFileOpFlag) do
       if i in FOptions then fFlags := fFlags or FILEFLAGS[i];
    end; // end of with
  result:= (SHFileOperation(FileInfo)=0) and (not FileInfo.fAnyOperationsAborted);
end;

{ get size of file ----------------------------------------------------------- }
function TLMDFileCtrl.GetFileBytes:LongInt;
var
  SecAttr: TSecurityAttributes;
  hf : THandle;
begin
  result:=0;
  if FileExists(FFilename) then
    begin

      SecAttr.nLength := SizeOf(TSecurityAttributes);

      SecAttr.bInheritHandle := false;
      hf := CreateFile (int_Ref(FFilename), GENERIC_READ , 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL {or FILE_FLAG_SEQUENTIAL_SCAN}, 0);
      if (hf <> INVALID_HANDLE_VALUE) then
        begin
          result := (GetFileSize(hf, nil));
          CloseHandle(hf);
        end;
    end
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileCtrl.SetFileBytes(aDummy: LongInt);
begin
  // dummy procedure
end;

{ get timestamp-information -------------------------------------------------- }
function TLMDFileCtrl.GetFileTimeb(index : Integer):String;
var
  SecAttr: TSecurityAttributes;
  hf : THandle;
  lpDate : TFileTime;

  function FileTimeToDateTime(ft: TFileTime): TDateTime;
  var
    st : TSystemTime;
  begin
    FileTimeToSystemTime (ft, st);
    with st do
      result := EncodeDate(wYear, wMonth, wDay) +
        EncodeTime(wHour, wMinute, wSecond, wMilliSeconds);
  end;

begin
  result := '';
  if FileExists(FFilename) then
    begin

      SecAttr.nLength := SizeOf(TSecurityAttributes);

      SecAttr.bInheritHandle := false;
      hf := CreateFile (int_Ref(FFilename), GENERIC_READ , 0, nil, OPEN_EXISTING, 0{FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN}, 0);
      if hf <> INVALID_HANDLE_VALUE then
        begin
          case index of

            0 : GetFileTime (hf, @lpDate, nil, nil); // created
            1 : GetFileTime (hf, nil, @lpDate, nil); // access
            2 : GetFileTime (hf, nil, nil, @lpDate); // write

          end;
          CloseHandle (hf);
          FileTimeToLocalFileTime (lpDate, lpDate);
          // 7.02
          if FFileStampFormat='' then
            result := DateTimeToStr (FileTimeToDateTime (lpDate))
          else
            try
              result := SysUtils.FormatDateTime (FFileStampFormat,FileTimeToDateTime(lpDate))
             except
               On Exception do
                 result := DateTimeToStr (FileTimeToDateTime (lpDate));
            end;
        end
    end;
end;

{ set timestamp-information -------------------------------------------------- }
procedure TLMDFileCtrl.SetFileTimeb(index : Integer; aValue:String);
var
  SecAttr: TSecurityAttributes;
  hf : THandle;
  lpDate : TFileTime;

  function DateTimeToFileTime(dt: TDateTime): TFileTime;
  var
    st : TSystemTime;
  begin
    with st do
      begin
        DecodeDate(dt, st.wYear, st.wMonth, st.wDay);
        DecodeTime(dt, st.wHour, st.wMinute, st.wSecond, st.wMilliSeconds);
      end;
    SystemTimeToFileTime (st, result);
  end;

begin
  if FileExists(FFilename) then
    begin

      SecAttr.nLength := SizeOf(TSecurityAttributes);

      SecAttr.bInheritHandle := false;
      hf := CreateFile (int_Ref(FFileName), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, 0, 0);
      lpDate := DateTimeToFileTime(StrToDateTime (aValue));
      LocalFileTimeToFileTime (lpDate, lpDate);
      if hf <> INVALID_HANDLE_VALUE then
        begin
          case index of

            0 : SetFileTime (hf, @lpDate, nil, nil); // create
            1 : SetFileTime (hf, nil, @lpDate, nil); // access
            2 : SetFileTime (hf, nil, nil, @lpDate); // write

          end;
          CloseHandle (hf);
        end
    end;
end;

{ get type of file ---------------------------------------------------------}
function TLMDFileCtrl.GetFileType:String;
var
  FileInfo: TSHFileInfo;
begin
  if FileExists(FFilename) then
    begin

      FillChar (FileInfo, sizeof(TSHFileInfo), 0);

      LMDSHGetFileInfo(FFileName, 0, FileInfo, SHGFI_TYPENAME);
      Result := FileInfo.szTypeName;
      // no filetype -> name it "[fileextension]-file"
      if result = '' then
        result := LMDAnsiUpperCase(ExtractfileExt(FFileName)) + '-' + IDS_FILE;
    end
  else result := '';
end;

{---------------------------------------------------------------------------}
procedure TLMDFileCtrl.SetFileType(aDummy:String);
begin
  // dummy procedure
end;

{ get path to associated program-file --------------------------------------}

function TLMDFileCtrl.GetExecuteable:String;
var
  Buffer: array[0..500] of char;   // a buffer for a path and filename
begin
  FindExecutable(PChar(FFileName),nil,@Buffer);
  result := StrPas(Buffer);
end;

{ get path to file-icon ----------------------------------------------------}
function TLMDFileCtrl.GetFileIconPath:String;
var
  FileInfo: TSHFileInfo;
begin

  FillChar(FileInfo, SizeOf(FileInfo), 0);

  LMDSHGetFileInfo('',0,FileInfo,SHGFI_ICONLOCATION);
  result :=(FileInfo.szDisplayName);
end;

{ get icon-index in global images-list -------------------------------------}
function TLMDFileCtrl.GetFileIconIndex:Integer;
var
  FileInfo: TSHFileInfo;
begin
  LMDSHGetFileInfo(FFilename,0,FileInfo,SHGFI_ICON or SHGFI_SYSICONINDEX);
  result := FileInfo.iIcon;
end;

{ get handle of small global icon-list ------------------------------------}
function TLMDFileCtrl.GetSmallIconListHandle:DWORD;
begin
  result := LMDSISystemIconListHandle(false);
end;

{ get handle of large global icon-list ------------------------------------}
function TLMDFileCtrl.GetLargeIconListHandle:DWORD;
begin
  result := LMDSISystemIconListHandle(true);
end;

{ get systemwide heigth of a large icon -----------------------------------}
function TLMDFileCtrl.GetLargeIconHeight:Integer;
begin
  result := LMDSIIconHeight;
end;

{ get systemwide height of a small icon -----------------------------------}
function TLMDFileCtrl.GetSmallIconHeight:Integer;
begin
  result := LMDSISmallIconHeight;
end;

{ get systemwide width of a large icon -------------------------------------}
function TLMDFileCtrl.GetLargeIconWidth:Integer;
begin
  result := LMDSIIconWidth;
end;

{ get systemwide width of a small icon -------------------------------------}
function TLMDFileCtrl.GetSmallIconWidth:Integer;
begin
  result := LMDSISmallIconWidth;
end;

{ get number of icons stored in a file -------------------------------------}
function TLMDFileCtrl.GetIconNum:Integer;
var
  LIcon, SIcon: HICON;
begin
  result:=0;
  LIcon := 0;
  SIcon := 0;
  if FileExists(FFileName) then
    result := ExtractIconEx(Int_Ref(FFileName), -1, LIcon, SIcon, 0);
  if result < 0 then result := 0;
end;

{ get file-extension ------------------------------------------------------}
function TLMDFileCtrl.GetFileExtension:String;
begin
  result := ExtractFileExt(FFileName);
end;

{ -------------------------------------------------------------------------}
function TLMDFileCtrl.GetShortAttrib:String;
var
  TempAttributes : TLMDFileCtrlAttributes;
begin
  result := '';
  TempAttributes := GetAttributes;
  if fcaArchive in TempAttributes then
    result := result + 'a'
  else
    result := result + '-';
  if fcaHidden in TempAttributes then
    result := result + 'h'
  else
    result := result + '-';
  if fcaReadonly in TempAttributes then
    result := result + 'r'
  else
    result := result + '-';
  if fcaSystem in TempAttributes then
    result := result + 's'
  else
    result := result + '-';
end;

{ --------------------------------------------------------------------------}
function TLMDFileCtrl.GetFileExist:Boolean;
begin
  if FileExists(FFileName) then
    result := true
  else result := false;
end;

{ --------------------------------------------------------------------------}
function TLMDFileCtrl.GetFilePath:String;
begin
  result := ExtractFilePath(FFileName);
end;

{ --------------------------------------------------------------------------}
function TLMDFileCtrl.GetFileNameOnly:String;
var
  temp:Byte;
begin
  result := ExtractFileName(FFileName);
  temp := pos('.', result);
  if temp > 0 then
    result := copy(result, 1, temp-1);
end;

{ --------------------------------------------------------------------------}
procedure TLMDFileCtrl.SetFileName(const aValue:TFileName);
begin
  if FileExists(aValue) then
    FFileName := ExpandFileName(aValue);
end;

{--------------------------- public ----------------------------------------}
function TLMDFileCtrl.CopyFiles(aSource:String; aDestination:String):Boolean;
begin
  result := FileOps (aSource, aDestination, foCopy);
end;

{ delete source file ------------------------------------------------------}
function TLMDFileCtrl.DeleteFiles(aSource:String):Boolean;
begin
  result := FileOps (aSource, '', foDelete);
end;

{ move from source to destination ------------------------------------------}
function TLMDFileCtrl.MoveFiles(aSource, aDestination:String):Boolean;
begin
  result := FileOps (aSource, aDestination, foMove);
end;

{ rename from source to destination ----------------------------------------}
function TLMDFileCtrl.RenameFiles(aSource, aDestination:String):Boolean;
begin
  result := FileOps (aSource, aDestination, foRename);
end;

{ extract large icon associated with the file ------------------------------}
procedure TLMDFileCtrl.GetLargeFileIcon(var TempIcon:TIcon);
var
  FileInfo: TSHFileInfo;
begin
  LMDSHGetFileInfo(FFilename,0,FileInfo,SHGFI_ICON or SHGFI_LARGEICON);
  TempIcon.Handle := FileInfo.hIcon;
end;

{ extract small icon associated with the file ------------------------------}
procedure TLMDFileCtrl.GetSmallFileIcon(var TempIcon:TIcon);
var
  FileInfo: TSHFileInfo;
begin
  LMDSHGetFileInfo(FFilename,0,FileInfo,SHGFI_ICON or SHGFI_SMALLICON);
  TempIcon.Handle := FileInfo.hIcon;
end;

{ extract large icon from a file (icon-library) - by index -----------------}
procedure TLMDFileCtrl.GetLargeIconFromFile(aIndex:DWord; var TempIcon:TIcon);
var
  LIcon, SIcon:HICON;
begin
  LIcon := 0;
  SIcon := 0;
  if FileExists (FFileName) then
    if ExtractIconEx(Int_Ref(FFileName), -1, LIcon, SIcon, 0) > aIndex then
      begin
        ExtractIconEx(Int_Ref(FFileName), aIndex, LIcon, SIcon, 1);
        TempIcon.Handle := LIcon;
      end;
end;

{ extract small icon from a file (icon-library) - by index -----------------}
procedure TLMDFileCtrl.GetSmallIconFromFile(aIndex:DWord; var TempIcon:TIcon);
var
  LIcon, SIcon:HICON;
begin
  LIcon := 0;
  SIcon := 0;
  if FileExists (FFileName) then
    if ExtractIconEx(Int_Ref(FFileName), -1, LIcon, SIcon, 0) > aIndex then
      begin
        ExtractIconEx(Int_Ref(FFileName), aIndex, LIcon, SIcon, 1);
        TempIcon.Handle := SIcon;
      end;
end;

{ extract all icons from a file - into an imagelist ------------------------}
procedure TLMDFileCtrl.ExtractIconsFromFile(var TempList:TCustomImageList; Small:Boolean);
var
  LIcon, SIcon:HICON;
  NumTemp:Integer;
  TempIcon:TIcon;
  i:Integer;
begin
  LIcon := 0;
  SIcon := 0;
  if FileExists (FFileName) then
    begin
      NumTemp := ExtractIconEx(Int_Ref(FFileName), -1, LIcon, SIcon, 0);
      for i := 0 to NumTemp -1 do
        begin
          ExtractIconEx(Int_Ref(FFileName), i, LIcon, SIcon, 1);
          TempIcon := TIcon.Create;
          if Small then
            TempIcon.Handle := SIcon
          else
            TempIcon.Handle := LIcon;
          TempList.AddIcon(TempIcon);
          TempIcon.Free;
        end;
    end;
end;

{---------------------------------------------------------------------------}
constructor TLMDFileCtrl.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FFileName := '';
  FOptions:=[ffUseRecycleBin, ffFilesOnly];
  FFileStampFormat := '';
end;

{---------------------------------------------------------------------------}
Destructor TLMDFileCtrl.Destroy;
begin
  inherited Destroy;
end;

end.
