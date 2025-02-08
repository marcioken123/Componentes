unit LMDShItem;
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

LMDShItem unit (DS)
------------------------
Contains shell virtual List items


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, ShlObj, Graphics, ActiveX,
  LMDShBase;

type

  {****************************************************************************}
  TLMDShellIconType = (itSmallClosed, itSmallOpen, itLargeClosed, itLargeOpen);

  {****************************************************************************}
  TLMDShellFolderOption = (foFolders, foNonFolders, foIncludeHidden,
                           foHighlightCompressed, foFilterDirs);
                           TLMDShellFolderOptions = set of TLMDShellFolderOption;

  {****************************************************************************}
  TLMDShellItem = class(TLMDCustomShellItem)
  private
    { property variables }
    FParentFolder       : IShellFolder;

    { for V2.0 }
    FOpened             : boolean;
    FParentShellItem    : TLMDShellItem;

    function GetPIDL : PItemIDList;
    function GetShellFolder : IShellFolder;

    function GetParentShellFolder2 : IShellFolder2;
    function GetImageIndex(iType: TLMDShellIconType) : LongInt;

    { internal methods }
    procedure UpdateAttributes;
    function  CheckAttribute(aFlags : DWORD): Boolean;
    procedure InitFromPIDL(aPIDL : PItemIDList; aController : TLMDShellComponent);
    procedure InitFromPIDLs(aParentPIDL, aRelPIDL : PItemIDList; aController : TLMDShellComponent);

  protected
    { base class methods }
    function GetDisplayName : string; override;
    function GetShortFileName : string; override;
    function GetPath : string; override;
    function GetTypeName : string; override;
    function GetExtDisplayName : string;override;
    function GetExtension : string; override;
    function GetDWFileAttributes : DWORD; override;
    function GetFileAttributes : TLMDShellFileAttributes; override;
    function GetFileAttributesStr : string; override;
    function GetFileProperties : TLMDShellFolderProperties; override;
    function GetFileCapabilities : TLMDShellFolderCapabilities; override;
    function GetFileSize : Int64; override;
    function GetModifiedDate : TDateTime; override;
    function GetAccessDate : TDateTime; override;
    function GetCreationDate : TDateTime; override;
    function GetIconIndex : integer; override;
    function GetOpenIconIndex : integer; override;
    function GetOverlayIconIndex : integer; override;
    function GetLargeIcon : TIcon; override;
    function GetLargeOpenIcon : TIcon; override;
    function GetSmallIcon : TIcon; override;
    function GetSmallOpenIcon : TIcon; override;
    function GetDriveType : integer; override;
    function GetIsNamespaceRoot : boolean; override;
    function GetIsFile : boolean; override;
    function GetIsFileFolder : boolean; override;
    function GetIsFileSystem : boolean; override;
    function GetIsLink : boolean; override;
    function GetIsShared : boolean; override;
    function GetCanCopy : boolean; override;
    function GetCanPaste : boolean; override;
    function GetCanLink : boolean; override;
    function GetCanRename : boolean; override;
    function GetHasPropSheet : boolean; override;
    function GetHasRemovableMedia : boolean; override;
    function GetHasSubFolder : boolean; override;
    function GetIsCompressed : boolean; override;
    function GetIsDropTarget : boolean; override;
    function GetIsFileSystemAncestor : boolean; override;
    function GetIsFolder : boolean; override;
    function GetIsGhosted : boolean; override;
    function GetIsHidden : boolean; override;
    function GetIsReadOnly : boolean; override;
    function GetDetails : TStringList; override;
    function GetParentShellFolderIntf : IShellFolder; override;
    function GetDropTargetIntf : IDropTarget; override;
    function GetDetailsEx(ColID: integer; var Res: string): Boolean;override;
  public
    { constructor/destructor }
    constructor CreateFromPIDL(aPIDL : PItemIDList; aController : TLMDShellComponent); reintroduce;
    constructor CreateFromPIDLs(aParentPIDL, aRelPIDL : PItemIDList; aController : TLMDShellComponent); reintroduce;
    constructor CreateFromPath(const aPath : string; aController : TLMDShellComponent); reintroduce;
    destructor Destroy; override;

    { methods }
    procedure Assign(aSource : TLMDCustomShellItem); override;
    procedure LoadDetailsEx(const ColIDs: array of integer); override;

    { V2.0}
    procedure GetIcon(iType: TLMDShellIconType; aIcon: TIcon);
    function IsDesktop: Boolean;
    function HasSubItems(aOptions: TLMDShellFolderOptions): Boolean;
    function ExecuteDefault: Integer;
    procedure Delete; override;

    { properties }
    property ParentFolder : IShellFolder read FParentFolder;

    { for V2.0 }
    property PIDL : PItemIDList read GetPIDL;
    property ParentShellFolder : IShellFolder read FParentFolder;
    property PathName : string read GetPath;
    property Capabilities : TLMDShellFolderCapabilities read GetFileCapabilities;
    property Properties : TLMDShellFolderProperties read GetFileProperties;
    property ParentShellFolder2 : IShellFolder2 read GetParentShellFolder2;
    property Opened : boolean read FOpened;
    property ParentShellItem : TLMDShellItem read FParentShellItem;
    property ImageIndex[iType: TLMDShellIconType] : LongInt read GetImageIndex;

    property ShellFolder : IShellFolder read GetShellFolder;
//    property ShellFolder2 : IShellFolder2 read GetShellFolder2;
  end;

implementation
uses
  SysUtils, ShellApi, Controls, ClipBrd,  LMDShDragDrop, LMDShPIDL, LMDShController, LMDShExceptions,
  LMDShConsts, LMDShMisc, LMDProcs;

{** TLMDShellItem *************************************************************}
{-- private -------------------------------------------------------------------}
procedure TLMDShellItem.UpdateAttributes;
var
  C     : TLMDShellController;

  function FileTimeToDateTime(aFileTime : TFileTime) : TDateTime;
  var
    FT          : TFileTime;
    ST          : TSystemTime;

    function ValidSystemTime : boolean;
    begin
      with ST do
        result := (wYear < 2050) and (wMonth <= 12) and (wMonth >= 1)
          and (wDayOfWeek <= 6) //and (wDayOfWeek >= 0)
          and (wHour <=24 ) and (wMinute <= 60) and (wSecond <= 60);
    end;

  begin
    result := 0;
    FileTimeToLocalFileTime(aFileTime, FT);
    FileTimeToSystemTime(FT, ST);
    if ValidSystemTime then Result := SystemTimeToDateTime(ST);
  end;

  function  MakeInt64(Lo, Hi: integer): Int64;
  begin

    Int64Rec(Result).Lo := Lo;
    Int64Rec(Result).Hi := Hi;

  end;

begin
  FFileAttributesStr := '';
  FFileAttributes := [];

  C := TLMDShellController(Controller);

  if not IsFileSystem or not Assigned(C) then Exit;

  with C.ID_Data(FRelativeID, FParentFolder) do
    begin
      FShortFileName := cAlternateFileName;
      FIsFileFolder := BoolToExt(IsElement(FILE_ATTRIBUTE_DIRECTORY, dwFileAttributes));

      if IsFileFolder then
        FFileSize := 0
      else
        FFileSize := MakeInt64(nFileSizeLow, nFileSizeHigh);

      FModifiedDate := FileTimeToDateTime(ftLastWriteTime);
      FCreationDate := FileTimeToDateTime(ftCreationTime);
      FAccessDate := FileTimeToDateTime(ftLastAccessTime);

      if IsElement(FILE_ATTRIBUTE_HIDDEN, dwFileAttributes) then
        begin
          FFileAttributesStr := FFileAttributesStr + 'H';
          Include(FFileAttributes, LMDShBase.faHidden);
        end;

      if IsElement(FILE_ATTRIBUTE_SYSTEM, dwFileAttributes) then
        begin
          FFileAttributesStr := FFileAttributesStr + 'S';
          Include(FFileAttributes, LMDShBase.faSystem);
        end;

      if IsElement(FILE_ATTRIBUTE_READONLY, dwFileAttributes) then
        begin
          FFileAttributesStr := FFileAttributesStr + 'R';
          Include(FFileAttributes, LMDShBase.faReadOnly);
        end;

      if IsElement(FILE_ATTRIBUTE_COMPRESSED, dwFileAttributes) then
        begin
          FFileAttributesStr := FFileAttributesStr + 'C';
          Include(FFileAttributes, LMDShBase.faCompressed);
        end;

      if IsElement(FILE_ATTRIBUTE_ARCHIVE, dwFileAttributes) then
        begin
          FFileAttributesStr := FFileAttributesStr + 'A';
          Include(FFileAttributes, LMDShBase.faArchive);
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetPIDL : PItemIDList;
begin
  result := RelativeID;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetParentShellFolder2 : IShellFolder2;
begin
  result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetImageIndex(iType: TLMDShellIconType) : LongInt;
begin
  result := IconIndex;
end;

{-- protected -----------------------------------------------------------------}
function TLMDShellItem.GetDisplayName : string;
begin
  result := FDisplayName;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetExtDisplayName: string;
begin
  result:= FExtDisplayName;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetShortFileName : string;
begin
  if FShortFileName = '' then UpdateAttributes;
  result := FShortFileName;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetPath : string;
begin
  result := FPath;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetTypeName : string;
var
  C : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FTypeName = '') then
    with C.ID_Info(FAbsoluteID, SHGFI_TYPENAME) do
      FTypeName := szTypeName;
  result := FTypeName;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetExtension : string;
begin
  if FExtension = '' then FExtension := ExtractFileExt(Path);
  result := FExtension;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetDWFileAttributes : DWORD;
begin
  if FDWFileAttributes = 0 then
    begin
      FDWFileAttributes := SFGAO_CANCOPY or SFGAO_CANDELETE or SFGAO_CANLINK or SFGAO_CANMOVE or SFGAO_DROPTARGET;
      FParentFolder.GetAttributesOf(1, FRelativeID, FDWFileAttributes);
    end;
  result := FDWFileAttributes;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetFileAttributes : TLMDShellFileAttributes;
begin
  if FFileAttributes = [] then UpdateAttributes;
  result := FFileAttributes;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetFileAttributesStr : string;
begin
  if FFileAttributesStr = '' then UpdateAttributes;
  result := FFileAttributesStr;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetFileProperties : TLMDShellFolderProperties;
const
  fpFlags: array[fpCut..fpFileSystem] of UINT = (SFGAO_GHOSTED, SFGAO_LINK,
    SFGAO_SHARE, SFGAO_FOLDER, SFGAO_HASSUBFOLDER, SFGAO_COMPRESSED,
    SFGAO_REMOVABLE, SFGAO_FILESYSANCESTOR, SFGAO_FILESYSTEM);
var
  C     : TLMDShellController;
  Flags : dword;
  FP    : TLMDShellFolderProperty;
begin
  C := TLMDShellController(Controller);
  result := [];
  if IsNamespaceRoot or not Assigned(C) then Exit;
  FFileProperties := [];
  Flags := SFGAO_GHOSTED or SFGAO_LINK or SFGAO_SHARE or SFGAO_HASSUBFOLDER or
    SFGAO_COMPRESSED or SFGAO_FILESYSTEM or SFGAO_FILESYSANCESTOR or SFGAO_FOLDER or SFGAO_REMOVABLE;

  Flags := C.ID_Attributes(FRelativeID, FParentFolder, Flags);
  for FP := fpCut to fpFileSystem do
    if IsElement(fpFlags[FP], Flags) then Include(FFileProperties, FP);

  result := FFileProperties;
end;
{------------------------------------------------------------------------------}
function TLMDShellItem.GetFileCapabilities : TLMDShellFolderCapabilities;
const
  fcFlags : array[fcCanCopy..fcHasPropSheet] of DWORD = (SFGAO_CANCOPY,
    SFGAO_CANDELETE, SFGAO_CANLINK, SFGAO_CANMOVE, SFGAO_CANRENAME,
    SFGAO_DROPTARGET, SFGAO_HASPROPSHEET);
var
  C     : TLMDShellController;
  Flags : dword;
  FC    : TLMDShellFolderCapability;
begin
  C := TLMDShellController(Controller);
  result := [];
  if IsNamespaceRoot or not Assigned(C) then Exit;
  FFileCapabilities := [];
  Flags := SFGAO_CANCOPY or SFGAO_CANDELETE or SFGAO_CANLINK or SFGAO_CANMOVE or
    SFGAO_CANRENAME or SFGAO_DROPTARGET or SFGAO_HASPROPSHEET;

  C.ID_Attributes(FRelativeID, FParentFolder, Flags);
  for FC := fcCanCopy to fcHasPropSheet do
    if IsElement(fcFlags[FC], Flags) then Include(FFileCapabilities, FC);

  result := FFileCapabilities;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetFileSize : Int64;
begin
  if FFileSize = -1 then UpdateAttributes;
  result := FFileSize;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetModifiedDate : TDateTime;
begin
  if FModifiedDate = -1 then UpdateAttributes;
  result := FModifiedDate;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetAccessDate : TDateTime;
begin
  if FAccessDate = -1 then UpdateAttributes;
  result := FAccessDate;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetCreationDate : TDateTime;
begin
  if FCreationDate = -1 then UpdateAttributes;
  result := FCreationDate;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIconIndex : integer;
var
  C : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FIconIndex = -1) then
    with C.ID_Info(FAbsoluteID, SHGFI_SYSICONINDEX) do
      begin
        FIconIndex := iIcon;
        if not IsFileFolder then
          FOpenIconIndex := FIconIndex;
      end;
  result := FIconIndex;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetOpenIconIndex : integer;
var
  C : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FOpenIconIndex = -1) then
    with C.ID_Info(FAbsoluteID, SHGFI_SYSICONINDEX or SHGFI_OPENICON) do
      FOpenIconIndex := iIcon;
  result := FOpenIconIndex;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetOverlayIconIndex : integer;
var
  SHFileInfo    : TShFileInfo;
begin
  if FOverlayIconIndex = -1 then begin
    if IsLink then

      FOverlayIconIndex := SHGetFileInfo(PChar(GetPath), 0, SHFileInfo, SizeOf(TSHFileInfo), SHGFI_LINKOVERLAY);

    if IsShared then
      FOverlayIconIndex := 0;
  End;
  result := FOverlayIconIndex;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetLargeIcon : TIcon;
var
  C : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FLargeIcon = nil) then
    FLargeIcon := C.ID_Icon(FAbsoluteID);
  result := FLargeIcon;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetLargeOpenIcon : TIcon;
var
  C : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FLargeOpenIcon = nil) then
    FLargeOpenIcon := C.ID_Icon(FAbsoluteID, [iOpen]);
  result := FLargeOpenIcon;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetSmallIcon : TIcon;
var
  C : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FSmallIcon = nil) then
    FSmallIcon := C.ID_Icon(FAbsoluteID, [iSmall]);
  result := FSmallIcon;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetSmallOpenIcon : TIcon;
var
  C : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FSmallOpenIcon = nil) then
    FSmallOpenIcon := C.ID_Icon(FAbsoluteID, [iSmall, iOpen]);
  result := FSmallOpenIcon;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetDriveType : integer;
begin
  if FDriveType = -1 then
    FDriveType := Windows.GetDriveType(Int_Ref(Path));
  result := FDriveType;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsNamespaceRoot : boolean;
var
  C     : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if FIsNamespaceRoot = boolUnknown then
    FIsNamespaceRoot := BoolToExt(C.ID_Equal(FAbsoluteID, C.ID_DesktopID));
  result := ExtToBool(FIsNamespaceRoot);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsFile : boolean;
begin
  if FIsFile = boolUnknown then
    FIsFile := BoolToExt(IsFileSystem and not IsFileFolder);
  result := ExtToBool(FIsFile);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsFileFolder : boolean;
var
  C     : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FIsFileFolder = boolUnknown) then
    FIsFileFolder := BoolToExt(IsFileSystem and C.ID_HasAttribute(FRelativeID, FParentFolder, SFGAO_FOLDER));
  result := ExtToBool(FIsFileFolder);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsFileSystem : boolean;
var
  C     : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FIsFileSystem = boolUnknown) then
    FIsFileSystem := BoolToExt(C.ID_HasAttribute(FRelativeID, FParentFolder, SFGAO_FILESYSTEM));
  result := ExtToBool(FIsFileSystem);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsLink : boolean;
var
  C     : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FIsLink = boolUnknown) then
    FIsLink := BoolToExt(C.ID_HasAttribute(FRelativeID, FParentFolder, SFGAO_LINK));
  result := ExtToBool(FIsLink);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsShared : boolean;
var
  C     : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  result := Assigned(C) and C.ID_HasAttribute(FRelativeID, FParentFolder, SFGAO_SHARE);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetCanCopy : boolean;
begin
  Result := CheckAttribute(SFGAO_CANCOPY);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetCanPaste : boolean;
begin
  result := (Clipboard.HasFormat(LMDShPIDLCFormat) and IsFileFolder);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetCanLink : boolean;
begin
  Result := CheckAttribute(SFGAO_CANLINK);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetCanRename : boolean;
begin
  Result := CheckAttribute(SFGAO_CANRENAME);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetHasPropSheet : boolean;
begin
  Result := CheckAttribute(SFGAO_HASPROPSHEET);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetHasRemovableMedia : boolean;
begin
  Result := CheckAttribute(SFGAO_REMOVABLE);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetHasSubFolder : boolean;
begin
  Result := CheckAttribute(SFGAO_HASSUBFOLDER);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsCompressed : boolean;
begin
  Result := CheckAttribute(SFGAO_COMPRESSED);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsDropTarget : boolean;
begin
  Result := CheckAttribute(SFGAO_DROPTARGET);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsFileSystemAncestor : boolean;
begin
  Result := CheckAttribute(SFGAO_FILESYSANCESTOR);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsFolder : boolean;
var
  C     : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  if Assigned(C) and (FIsFolder = boolUnknown) then
    FIsFolder := BoolToExt(not(IsNamespaceRoot)
      and C.ID_HasAttribute(FRelativeID, FParentFolder, SFGAO_FOLDER));
  result := ExtToBool(FIsFolder);
end;

{------------------------------------------------------------------------------}

function TLMDShellItem.CheckAttribute(aFlags : DWORD): Boolean;
var
  C     : TLMDShellController;
begin
  C := TLMDShellController(Controller);
  Result := Assigned(C) and not(IsNamespaceRoot)
    and C.ID_HasAttribute(FRelativeID, FParentFolder, aFlags);
end;

{------------------------------------------------------------------------------}

function TLMDShellItem.GetIsGhosted : boolean;

begin
  Result := CheckAttribute(SFGAO_GHOSTED);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsHidden : boolean;
begin
  Result := CheckAttribute(SFGAO_HIDDEN);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetIsReadOnly : boolean;
begin
  Result := CheckAttribute(SFGAO_READONLY);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetDetails : TStringList;
var
  ISD           : IShellDetails;
  SD            : TShellDetails;

  function FetchDetails(aCol : integer) : string;
  var
    Col         : integer;
//    PBuff       : PChar;
//    sf2: IShellFolder2;
  begin
    Result := '';
    Col := aCol;
    ISD.GetDetailsOf(FRelativeID, Col, SD);
    //Result := String(LMDStrRetToStringEx(nil, SD.str));
    Result := LMDStrRetToStr(nil, SD.str);
{
    case SD.str.uType of
      STRRET_CSTR : result := SD.str.cStr;
      STRRET_WSTR : result := WideCharToString(SD.str.pOleStr);
      STRRET_OFFSET :
        begin
          PBuff := PChar(FRelativeID) + SD.str.uOffset;
          result := PBuff;
        end;
    end;

    StrRetFree(SD.str);
}
  end;

  function GetItemDetails : boolean;
  begin
    Result := False;

    if  not Supports(ParentFolder, IShellDetails, ISD)  then
      ISD := nil;

    if ISD = nil then

      ParentFolder.CreateViewObject(0, IID_IShellDetails, ISD);

    if ISD = nil then Exit;

    FDetails.Add(FetchDetails(0)); // name
    FDetails.Add(FetchDetails(2)); // type
    FDetails.Add(FetchDetails(1)); // size
    FDetails.Add(FetchDetails(4)); // attr
    FDetails.Add(LMDFileDateToStr(CreationDate)); // CreateDate
    FDetails.Add(LMDFileTimeToStr(CreationDate)); // CreateTime
    FDetails.Add(LMDFileDateTimeToStr(CreationDate)); // CreateDateTime
    FDetails.Add(LMDFileDateToStr(AccessDate)); // AccessDate
    FDetails.Add(LMDFileTimeToStr(AccessDate)); // AccessTime
    FDetails.Add(LMDFileDateTimeToStr(AccessDate)); // AccessDateTime
    FDetails.Add(FetchDetails(3)); // ModifiedDate
    FDetails.Add(LMDFileTimeToStr(ModifiedDate)); // ModifiedTime
    FDetails.Add(LMDFileDateTimeToStr(ModifiedDate)); // ModifiedDateTime
    result := True;
    ISD := nil;
  end;

begin
  if FDetails.count = 0 then
    if not GetItemDetails then
      begin
        FDetails.Add(DisplayName); // name
        FDetails.Add(TypeName); // type
        if False{IsFileFolder} then
          begin
            FDetails.Add(''); // size
            FDetails.Add(''); // attr
            FDetails.Add(''); // CreateDate
            FDetails.Add(''); // CreateTime
            FDetails.Add(''); // CreateDateTime
            FDetails.Add(''); // AccessDate
            FDetails.Add(''); // AccessTime
            FDetails.Add(''); // AccessDateTime
            FDetails.Add(''); // ModifiedDate
            FDetails.Add(''); // ModifiedTime
            FDetails.Add(''); // ModifiedDateTime
          end
        else
          begin
            FDetails.Add(LMDFileSizeToStr(FileSize)); // size
            FDetails.Add(FileAttributesStr); // attr
            FDetails.Add(LMDFileDateToStr(CreationDate)); // CreateDate
            FDetails.Add(LMDFileTimeToStr(CreationDate)); // CreateTime
            FDetails.Add(LMDFileDateTimeToStr(CreationDate)); // CreateDateTime
            FDetails.Add(LMDFileDateToStr(AccessDate)); // AccessDate
            FDetails.Add(LMDFileTimeToStr(AccessDate)); // AccessTime
            FDetails.Add(LMDFileDateTimeToStr(AccessDate)); // AccessDateTime
            FDetails.Add(LMDFileDateToStr(ModifiedDate)); // ModifiedDate
            FDetails.Add(LMDFileTimeToStr(ModifiedDate)); // ModifiedTime
            FDetails.Add(LMDFileDateTimeToStr(ModifiedDate)); // ModifiedDateTime
          end;
      end;
  result := FDetails;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetParentShellFolderIntf : IShellFolder;
begin
  result := FParentFolder;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetDropTargetIntf : IDropTarget;
var
  Handle : HWND;
begin
  result := nil;
  Handle := 0;
  if TLMDCustomShellController(Controller).DragSource <> nil  then
    Handle := TWinControl(TLMDShellController(Controller).DragSource).Handle;

  if FParentFolder <>  nil then
    FParentFolder.GetUIObjectOf(Handle, 1, FRelativeID, IDropTarget, nil, Result)
  else
    LMDDesktopFolder.GetUIObjectOf(Handle, 1, FAbsoluteID, IDropTarget, nil, Result);

end;

procedure LMDDelete(var Str: string; i, N: integer);
begin
  Delete(Str, i, N);
end;

procedure int_InitShellItem(Obj: TLMDShellItem; C: TLMDShellController);
var
  i: integer;
begin
  // if Hide known extensions is enabled, FDisplayName has no extension!
  Obj.FDisplayName := C.ID_Name(Obj.FRelativeID, Obj.FParentFolder, SHGDN_NORMAL);

  Obj.FPath := C.ID_Name(Obj.FRelativeID, Obj.FParentFolder, SHGDN_FORPARSING);
  Obj.FExtDisplayName:=ExtractFileName(Obj.FPath);  // this is DisplayName with extension

  i := Pos(sDisplayPositionPrefix, Obj.FDisplayName);
  if (Pos('\\', Obj.FPath) = 1) and (i <> 0) then
    LMDDelete(Obj.FDisplayName, i, Length(Obj.FDisplayName) - i + 1);
end;

procedure TLMDShellItem.InitFromPIDLs(aParentPIDL, aRelPIDL : PItemIDList; aController : TLMDShellComponent);
var
  i: integer;
  C: TLMDShellController;
begin
  if aRelPIDL = nil then Exit;
  C := (aController as TLMDShellController);
  FAbsoluteID := LMDShPIDLCombine(aParentPIDL, aRelPIDL);
  FRelativeID := C.ID_Clone(aRelPIDL);
  i_BindToISHellFolder(LMDDesktopFolder, aParentPIDL, FParentFolder);
  int_InitShellItem(self, C);
exit;
  FDisplayName := LMDPidlToPath(FAbsoluteID);
  // if Hide known extensions is enabled, FDisplayName has no extension!
  FDisplayName := C.ID_Name(FRelativeID, FParentFolder, SHGDN_NORMAL);

  FPath := C.ID_Name(FRelativeID, FParentFolder, SHGDN_FORPARSING);
  FExtDisplayName:=ExtractFileName(FPath);  // this is DisplayName with extension

  i := Pos(sDisplayPositionPrefix, FDisplayName);
  if (Pos('\\', FPath) = 1) and (i <> 0) then
    LMDDelete(FDisplayName, i, Length(FDisplayName) - i + 1);
end;

procedure TLMDShellItem.InitFromPIDL(aPIDL : PItemIDList; aController : TLMDShellComponent);
var
  C: TLMDShellController;
begin
  if aPIDL = nil then Exit;
  C := (aController as TLMDShellController);
  FAbsoluteID := C.ID_Clone(aPIDL);
  FRelativeID := C.ID_Clone(C.ID_FindLast(aPIDL));
  FParentFolder := C.ID_ParentFolder(aPIDL);
  int_InitShellItem(self, C);
end;

{-- public --------------------------------------------------------------------}

constructor TLMDShellItem.CreateFromPIDL(aPIDL : PItemIDList; aController : TLMDShellComponent);
begin
  inherited Create(aController);

  InitFromPIDL(aPIDL, aController);
end;

{------------------------------------------------------------------------------}
constructor TLMDShellItem.CreateFromPIDLs(aParentPIDL, aRelPIDL : PItemIDList; aController : TLMDShellComponent);
begin
  inherited Create(aController);

  InitFromPIDLs(aParentPIDL, aRelPIDL, aController);
end;

{------------------------------------------------------------------------------}
constructor TLMDShellItem.CreateFromPath(const aPath : string; aController : TLMDShellComponent);
var
  C             : TLMDShellController;
  tmpPIDL       : PItemIDList;
begin
  inherited Create(aController);

  C := (aController as TLMDShellController);
  tmpPIDL := C.ID_PathToPIDL(aPath, C.ID_DesktopFolder);

  if tmpPIDL = nil then
    LMDRaiseError(ELMDInvalidFolder, cErrInvalidFolder)
  else
    begin
      InitFromPIDL(tmpPIDL, aController);
      C.ID_Free(tmpPIDL);
    end;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellItem.Destroy;
begin
  FParentFolder := nil;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItem.Assign(aSource : TLMDCustomShellItem);
begin
  inherited;
  FParentFolder := TLMDShellItem(aSource).FParentFolder;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItem.GetIcon(iType: TLMDShellIconType; aIcon: TIcon);
begin
  case iType of
    itSmallClosed : aIcon.Handle := SmallIcon.Handle;
    itSmallOpen : aIcon.Handle := SmallOpenIcon.Handle;
    itLargeClosed : aIcon.Handle := LargeIcon.Handle;
    itLargeOpen : aIcon.Handle := LargeOpenIcon.Handle;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.IsDesktop: boolean;
begin
  result := IsNamespaceRoot;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.HasSubItems(aOptions: TLMDShellFolderOptions): Boolean;
var
  Opt : TLMDShellEnumOptions;
begin
  Opt := [];
  if foFolders in aOptions then Opt := Opt + [eoFolders];
  if foNonFolders in aOptions then Opt := Opt + [eoNonFolders];
  if foIncludeHidden in aOptions then Opt := Opt + [eoIncludeHidden];
  result := TLMDShellController(Controller).ID_HasChildren(AbsoluteID, Opt);
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.ExecuteDefault : Integer;
begin
  result := integer(TLMDShellController(Controller).ExecuteDefault(Self));
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItem.Delete;
begin
  TLMDShellController(Controller).DeleteItem(Self);
end;

(*
*)
{
function TLMDShellItem.GetShellDetails: IShellDetails;
begin
  if not Assigned(FDetailInterface) then
    GetDetailInterface;
  Result := FIShellDetails;
end;
}
{
function TLMDShellItem.GetShellFolder2: IShellFolder2;
begin
  if not Assigned(FDetailInterface) then
    GetDetailInterface;
  Result := FIShellFolder2;
end;
}
{------------------------------------------------------------------------------}
function TLMDShellItem.GetShellFolder : IShellFolder;
begin
  Result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDShellItem.GetDetailsEx(ColID: integer; var Res: string): Boolean;
var
  ISF2: IShellFolder2;
  ISD: IShellDetails;
  SD: TShellDetails;
begin
  Result := False;

  if  not Supports(ParentShellFolderIntf, IShellFolder2, ISF2)  then
    ISF2 := nil;

  if Assigned(ISF2)
     and Succeeded(ISF2.GetDetailsOf(RelativeID, ColID, SD))  then
    begin
      //Res := String(LMDStrRetToStringEx(AbsoluteID, SD.str));
      Res := LMDStrRetToStr(AbsoluteID, SD.str);
      Result := True;
    end;

  if  not Result  then
    begin
      ISD := GetIShellDetails(ParentShellFolderIntf, AbsoluteID);

      if  Assigned(ISD)
          and Succeeded(ISD.GetDetailsOf(RelativeID, ColID, SD))  then
        begin
          //Res := String(LMDStrRetToStringEx(RelativeID, SD.str));
          Res := LMDStrRetToStr(RelativeID, SD.str);
          Result := True;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItem.LoadDetailsEx(const ColIDs: array of integer);
  procedure AddDetail(HR: HResult; var SD: TShellDetails; ColID: integer);
  var
    S: string;
  begin
    if Succeeded(HR)  then
      //S := String(LMDStrRetToStringEx(RelativeID, SD.str))
      S := LMDStrRetToStr(RelativeID, SD.str)
    else
      S := '';

    if  ColID = 3 then
      S := StringReplace(S, '?', '', [rfReplaceAll]);

    FDetailsEx.AddObject(S, TObject(ColID));
  end;
var
  ISF2: IShellFolder2;
  ISD: IShellDetails;
  SD: TShellDetails;
  HR: HResult;
  F2: Boolean;
  i: integer;
begin
  if  not Assigned(FDetailsEx)  then
    FDetailsEx := TStringList.Create;

  if  FDetailsEx.Count = Length(ColIDs)  then
    exit
  else
    FDetailsEx.Clear;

  if  not Supports(ParentShellFolderIntf, IShellFolder2, ISF2)  then
    ISF2 := nil;

  F2 := True;

  if Assigned(ISF2) then
    for i := Low(ColIDs) to High(ColIDs) do
      begin
        HR := ISF2.GetDetailsOf(RelativeID, ColIDs[i], SD);
        AddDetail(HR, SD, ColIDs[i]);
        StrRetFree(SD.Str);
        if Succeeded(HR)  then
          F2 := False;
      end;

  if  F2  then
    begin
      FDetailsEx.Clear;
      ISD := GetIShellDetails(ParentShellFolderIntf, AbsoluteID);

      if  Assigned(ISD) then
        for i := Low(ColIDs) to High(ColIDs) do
          begin
            HR := ISD.GetDetailsOf(RelativeID, ColIDs[i], SD);
            AddDetail(HR, SD, ColIDs[i]);
            StrRetFree(SD.Str);
          end;
    end;
end;

{------------------------------------------------------------------------------}

{=================}
{
function GetIShellDetails(IFolder: IShellFolder; PIDL: PItemIDList;
  Handle: THandle = 0): IShellDetails;
var
  HR : HResult;
begin
  if Assigned(IFolder) then
  begin
    HR := IFolder.BindToObject(PIDL, nil, IID_IShellDetails, Pointer(Result));
    if HR <> S_OK then
      IFolder.GetUIObjectOf(Handle, 1, PIDL, IID_IShellDetails, nil, Pointer(Result));
    if HR <> S_OK then
      IFolder.CreateViewObject(Handle, IID_IShellDetails, Pointer(Result));
  end;
  if not Assigned(Result) then
    LMDDesktopFolder.BindToObject(PIDL, nil, IID_IShellDetails, Pointer(Result));
end;
}
{=================}

end.
