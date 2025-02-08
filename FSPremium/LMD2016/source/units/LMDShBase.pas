unit LMDShBase;
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

LMDShBase unit (DS)
------------------
Contains base classes and bitmap resources for LMD ShellPack

Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, Forms, Windows, Graphics, ActiveX, Messages,
  ShlObj, ShellAPI, Controls, Comctrls, Imglist, StdCtrls,
  LMDCustomComponent, LMDTypes;

  {$R LMDShellPack.res}

const
  // Error identifiers
  cErrShVersion                 = 0; { Operation not supported in this version of the shell }
  cErrInvalidFolder             = 1; { Invalid folder }
  cMaxCode = 1;

  sRFDesktop                    = 'sfDesktop'; { Do not localize }
  sRFFavorites                  = 'sfFavorites'; { Do not localize }
  sDisplayPositionPrefix        = ' on ';

{------------------------------------------------------------------------------}

type
  TStrRetEx = TStrRet;
  TShellDetailsEx = TShellDetails;

  {-------------------- TLMDShellComponent ------------------------------------}
  TLMDShellComponent = class (TLMDCustomComponent)
  public
    function getLMDPackage:TLMDPackageID;override;
  published
    property About;
  end;

  {-------------------- TLMDShellbaseDialog -----------------------------------}
  TLMDShellParentHandle=(pwNone, pwApplication, pwOwnerForm);

  TLMDShellBaseDialog = class (TLMDShellComponent)
  private
    FParent:TLMDShellParentHandle;
  protected
    function GetOwnerHandle(aHWND:HWND=0):HWND;
  public
    function Execute(aHWND:HWND=0):Boolean;virtual;abstract;
  published
    property OwnerHandle:TLMDShellParentHandle read FParent write FParent default pwNone;
  end;

  {****************************************************************************}
  TLMDShellFileAttribute = (faReadOnly, faHidden, faSystem, faArchive, faCompressed);
  TLMDShellFileAttributes = set of TLMDShellFileAttribute;

  {****************************************************************************}
  TLMDShellFolderCapability = (fcCanCopy, fcCanDelete, fcCanLink, fcCanMove,
                               fcCanRename, fcDropTarget, fcHasPropSheet);
  TLMDShellFolderCapabilities = set of TLMDShellFolderCapability;

  {****************************************************************************}
  TLMDShellFolderProperty = (fpCut, fpIsLink, fpShared, fpFolder, fpHasSubFolder,
                             fpCompressed, fpRemovable, fpFileSystemAncestor, fpFileSystem);
  TLMDShellFolderProperties = set of TLMDShellFolderProperty;

  {****************************************************************************}
  TLMDShellBoolExt = (boolUnknown, boolTrue, boolFalse);

  {****************************************************************************}
  TLMDShellItemDetailsColumn = (cdName, cdTypeName, cdSize, cdAttributes,
                                cdWriteDate, cdWriteTime, cdWriteDateTime,
                                cdCreateDate, cdCreateTime, cdCreateDateTime,
                                cdAccessDate, cdAccessTime, cdAccessDateTime,
                                cdCustom
                                );

  {-------------------- TLMDShellDummyItems  ----------------------------------}
  TLMDCustomShellItem = class;
  TLMDShellDummyItems = class
  private
    //FItem       : TLMDCustomShellItem;
    function GetCount : integer;
    function GetItem(index : integer) : TLMDCustomShellItem;
  public
    property Items[index : integer] : TLMDCustomShellItem read GetItem ; default;
    property Count : integer read GetCount;
  end;

  {-------------------- TLMDCustomShellItem  ----------------------------------}

(*$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDropTarget)' *)

  TShellItemDetailsInfo = record
    Title: string;    //  Column Title
    View: string;
    Flags: dword;
  end;

  TShellItemDetailsInfoArray = array of TShellItemDetailsInfo;

  TLMDCustomShellItemCheckedEvent = procedure(Sender: TObject; AChecked: Boolean) of object;

  TLMDCustomShellItem = class
  private
    FCustomData         : TObject;
    FOwnedCustomData    : Boolean;
    function int_GetDetailsEx(ColID: integer): string;
  protected
    { property variables }
    FController         : TLMDShellComponent;
    FAbsoluteID         : PItemIDList;
    FRelativeID         : PItemIDList;
    FDisplayName        : string;
    FExtDisplayName     : string;
    FShortFileName      : string;
    FPath               : string;
    FTypeName           : string;
    FExtension          : string;
    FDWFileAttributes   : DWORD;
    FFileAttributes     : TLMDShellFileAttributes;
    FFileAttributesStr  : string;
    FFileProperties     : TLMDShellFolderProperties;
    FFileCapabilities   : TLMDShellFolderCapabilities;
    FFileSize           : Int64;
    FModifiedDate       : TDateTime;
    FAccessDate         : TDateTime;
    FCreationDate       : TDateTime;
    FIconIndex          : integer;
    FOpenIconIndex      : integer;
    FOverlayIconIndex   : integer;
    FLargeIcon          : TIcon;
    FLargeOpenIcon      : TIcon;
    FSmallIcon          : TIcon;
    FSmallOpenIcon      : TIcon;
    FDriveType          : integer;
    FIsNamespaceRoot    : TLMDShellBoolExt;
    FIsFile             : TLMDShellBoolExt;
    FIsFileFolder       : TLMDShellBoolExt;
    FIsFileSystem       : TLMDShellBoolExt;
    FIsLink             : TLMDShellBoolExt;
    FIsFolder           : TLMDShellBoolExt;
    FDetails            : TStringList;
    FDetailsEx          : TStringList;
    FData               : DWORD;
    FChecked            : boolean;
    FOnCheckItem        : TLMDCustomShellItemCheckedEvent;
    FLevel              : integer;

    { only for old cpb }
    FDummyItems         : TLMDShellDummyItems;

    { property methods }
    function GetDisplayName : string; virtual; abstract;
    function GetExtDisplayName : string; virtual; abstract;
    function GetShortFileName : string; virtual; abstract;
    function GetPath : string; virtual; abstract;
    function GetTypeName : string; virtual; abstract;
    function GetExtension : string; virtual; abstract;
    function GetDWFileAttributes : DWORD; virtual; abstract;
    function GetFileAttributes : TLMDShellFileAttributes; virtual; abstract;
    function GetFileAttributesStr : string; virtual; abstract;
    function GetFileProperties : TLMDShellFolderProperties; virtual; abstract;
    function GetFileCapabilities : TLMDShellFolderCapabilities; virtual; abstract;
    function GetFileSize : Int64; virtual; abstract;
    function GetModifiedDate : TDateTime; virtual; abstract;
    function GetAccessDate : TDateTime; virtual; abstract;
    function GetCreationDate : TDateTime; virtual; abstract;
    function GetIconIndex : integer; virtual; abstract;
    function GetOpenIconIndex : integer; virtual; abstract;
    function GetOverlayIconIndex : integer; virtual; abstract;
    function GetLargeIcon : TIcon; virtual; abstract;
    function GetLargeOpenIcon : TIcon; virtual; abstract;
    function GetSmallIcon : TIcon; virtual; abstract;
    function GetSmallOpenIcon : TIcon; virtual; abstract;
    function GetDriveType : integer; virtual; abstract;
    function GetIsNamespaceRoot : boolean; virtual; abstract;
    function GetIsFile : boolean; virtual; abstract;
    function GetIsFileFolder : boolean; virtual; abstract;
    function GetIsFileSystem : boolean; virtual; abstract;
    function GetIsLink : boolean; virtual; abstract;
    function GetIsShared : boolean; virtual; abstract;
    function GetCanCopy : boolean; virtual; abstract;
    function GetCanPaste : boolean; virtual; abstract;
    function GetCanLink : boolean; virtual; abstract;
    function GetCanRename : boolean; virtual; abstract;
    function GetHasPropSheet : boolean; virtual; abstract;
    function GetHasRemovableMedia : boolean; virtual; abstract;
    function GetHasSubFolder : boolean; virtual; abstract;
    function GetIsCompressed : boolean; virtual; abstract;
    function GetIsDropTarget : boolean; virtual; abstract;
    function GetIsFileSystemAncestor : boolean; virtual; abstract;
    function GetIsFolder : boolean; virtual; abstract;
    function GetIsGhosted : boolean; virtual; abstract;
    function GetIsHidden : boolean; virtual; abstract;
    function GetIsReadOnly : boolean; virtual; abstract;
    function GetDetails : TStringList; virtual; abstract;
    function GetParentShellFolderIntf : IShellFolder; virtual; abstract;
    function GetDropTargetIntf : IDropTarget; virtual; abstract;
    function GetDetailsEx(ColID: integer; var Res: string): Boolean; virtual;
    procedure SetChecked(const Value: boolean); virtual;
  public
    { constructor/destructor }
    constructor Create(aController : TLMDShellComponent); virtual;
    destructor Destroy; override;

    procedure Delete;virtual;
    procedure Refresh;virtual;

    { methods }
    procedure Assign(aSource : TLMDCustomShellItem); virtual;
    function  GetDetailsInfo: TShellItemDetailsInfoArray;
    function  GetDetailItem(ItemType: TLMDShellItemDetailsColumn): string;
    procedure LoadDetailsEx(const ColIDs: array of integer); virtual;

    { properties }
    property Controller : TLMDShellComponent read FController;

    property AbsoluteID : PItemIDList read FAbsoluteID;
    property AccessDate : TDateTime read GetAccessDate;
    property CanCopy : boolean read GetCanCopy;
    property CanLink : boolean read GetCanLink;
    property CanPaste : boolean read GetCanPaste;
    property CanRename : boolean read GetCanRename;
    property Capabilities : TLMDShellFolderCapabilities read GetFileCapabilities;
    property Checked : boolean read FChecked write SetChecked;
    property CreationDate : TDateTime read GetCreationDate;
    property Data : DWORD read FData write FData;
    property Details : TStringList read GetDetails;
    property DetailsEx[ColID: integer]: string read int_GetDetailsEx;
    property DisplayName : string read GetDisplayName;
    property DriveType : integer read GetDriveType;
    property DropTargetIntf : IDropTarget read GetDropTargetIntf;
    property DWFileAttributes : DWORD read GetDWFileAttributes;
    property ExtDisplayName:String read GetExtDisplayName;
    property Extension : string read  GetExtension;
    property FileAttributes : TLMDShellFileAttributes read GetFileAttributes;
    property FileAttributesStr : string read GetFileAttributesStr;
    property FileCapabilities : TLMDShellFolderCapabilities read GetFileCapabilities;
    property FileProperties : TLMDShellFolderProperties read GetFileProperties;
    property FileSize : Int64 read  GetFileSize;
    property HasPropSheet : boolean read GetHasPropSheet;
    property HasRemovableMedia : boolean read GetHasRemovableMedia;
    property HasSubFolder : boolean read GetHasSubFolder;
    property IconIndex : integer read GetIconIndex;
    property IsCompressed : boolean read GetIsCompressed;
    property IsDropTarget : boolean read GetIsDropTarget;
    property IsFile : boolean read GetIsFile;
    property IsFileFolder : boolean read GetIsFileFolder;
    property IsFileSystem : boolean read GetIsFileSystem;
    property IsFileSystemAncestor : boolean read GetIsFileSystemAncestor;
    property IsFolder : boolean read GetIsFolder;
    property IsGhosted : boolean read GetIsGhosted;
    property IsHidden : boolean read GetIsHidden;
    property IsLink : boolean read GetIsLink;
    property IsNamespaceRoot : boolean read GetIsNamespaceRoot;
    property IsReadOnly : boolean read GetIsReadOnly;
    property IsShared : boolean read GetIsShared;
    property LargeIcon : TIcon read GetLargeIcon;
    property LargeOpenIcon : TIcon read GetLargeOpenIcon;
    property Level : integer read FLevel write FLevel;
    property ModifiedDate : TDateTime read GetModifiedDate;
    property OpenIconIndex : integer read GetOpenIconIndex;
    property OverlayIconIndex : integer read GetOverlayIconIndex;
    property ParentShellFolderIntf : IShellFolder read GetParentShellFolderIntf;
    property Path : string read GetPath;
    property PathName : string read GetPath;
    property RelativeID : PItemIDList read FRelativeID;
    property ShortFileName : string read GetShortFileName;
    property SmallIcon : TIcon read GetSmallIcon;
    property SmallOpenIcon : TIcon read GetSmallOpenIcon;
    property TypeName : string read GetTypeName;
    property CustomData: TObject read FCustomData write FCustomData;
    property OwnedCustomData: Boolean read FOwnedCustomData write FOwnedCustomData;
    property OnCheckItem: TLMDCustomShellItemCheckedEvent read FOnCheckItem write FOnCheckItem;

    { only for old cpb, compatibility }
    property Items : TLMDShellDummyItems read FDummyItems;
  end;

  {****************************************************************************}
  TLMDShellItemsCompareFunc = function(Item1, Item2 : TLMDCustomShellItem) : integer of Object;

  {-------------------- TLMDShellItemsList  -----------------------------------}
  TLMDShellItemsList = class
  private
    { internal variables}
    FDetailsColumn      : TLMDShellItemDetailsColumn;
    FList               : TList;
    FDetailsData        : TStrings;
    FOnCheckItem        : TLMDCustomShellItemCheckedEvent;
//    FSortIndex          : integer;

    { properties methods }
    function GetItem(index : integer) : TLMDCustomShellItem;
    function GetCount : integer;

    { sort methods }
    function CompareByAbsoluteID(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByRelativeID(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByName(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByDetails(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByDetailsEx(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByExtension(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByTypeName(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByAttributes(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByFileSize(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByModifiedDate(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByAccessDate(Item1, Item2 : TLMDCustomShellItem) : integer;
    function CompareByCreationDate(Item1, Item2 : TLMDCustomShellItem) : integer;
    procedure Sort(aCompareFunc : TLMDShellItemsCompareFunc);

  public
    { constructor / destructor }
    constructor Create;
    destructor Destroy; override;

    { methods }
    function Add(aItem : TLMDCustomShellItem) : TLMDCustomShellItem;
    procedure Insert(aIndex : integer; aItem : TLMDCustomShellItem);
    procedure Clear;
    procedure Delete(aIndex : integer); overload;
    procedure Delete(AItem: TLMDCustomShellItem); overload;

    { sort methods }
    procedure SortByAbsoluteID;
    procedure SortByRelativeID;
    procedure SortByName;
    procedure SortByDetails(Index: integer); overload;
    procedure SortByDetails(aColumn : TLMDShellItemDetailsColumn); overload;
    procedure SortByDetailsEx(aColumn : TLMDShellItemDetailsColumn);
    procedure SortByExtension;
    procedure SortByTypeName;
    procedure SortByAttributes;
    procedure SortByFileSize;
    procedure SortByModifiedDate;
    procedure SortByAccessDate;
    procedure SortByCreationDate;

    { properties }
    property Item[index : integer] : TLMDCustomShellItem  read GetItem; default;
    property Count : integer read GetCount;
    property OnCheckItem: TLMDCustomShellItemCheckedEvent read FOnCheckItem write FOnCheckItem;
  end;

  {-------------------- TLMDShellItems  ---------------------------------------}
  TLMDShellItems = class(TLMDShellItemsList)
  public
    procedure Clear;
    procedure Delete(aIndex : integer);
  end;

  {****************************************************************************}
  TLMDShellEnumOption = (eoFolders, eoNonFolders, eoIncludeHidden);
  TLMDShellEnumOptions = set of TLMDShellEnumOption;

  {-------------------- TLMDCustomShellController  ----------------------------}
  TLMDCustomShellController = class(TLMDShellComponent)
  private
    { internal variables }
    FViews              : TList;
    FDragSource         : TObject;

    { internal methods }
    procedure ClearViews;
    procedure NotifyParentChange(aPIDL : PItemIDList);
  protected
    { property variables }
    FActiveFolder       : TLMDCustomShellItem;

    { observer handlers }
    procedure DoFileChange(aPIDL : PItemIDList);
    procedure DoFileCreate(aPIDL : PItemIDList);
    procedure DoFileDelete(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure DoFileRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure DoFolderChange(aPIDL : PItemIDList);
    procedure DoFolderCreate(aPIDL : PItemIDList);
    procedure DoFolderDelete(aPIDL : PItemIDList);
    procedure DoFolderRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure DoDriveChanged(aPIDL : PItemIDList; IsAdded: Boolean);
    procedure DoMediaChanged(aPIDL : PItemIDList; IsInserted: Boolean);
    procedure DoNetShare(aPIDL : PItemIDList; IsShared: Boolean);

    { property methods }
    procedure SetActiveFolder(const aValue : TLMDCustomShellItem);
    function GetView(Index:Integer):TObject;
    function GetViewCount:Integer;
    procedure ActiveFolderChanged;
    procedure TriggerActiveFolderChanged; virtual;
  public
    { constructor / destructor }
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;

    { methods }
    procedure RegisterView(aView : TObject);
    procedure UnRegisterView(aView : TObject);
    function CreateShellItem(aPIDL : PItemIDList) : TLMDCustomShellItem; overload; virtual; abstract;
    function CreateShellItem(const aPath : string) : TLMDCustomShellItem; overload; virtual; abstract;
    procedure Enumerate(aPIDL : PItemIDList; aView : TObject; aEnumOptions : TLMDShellEnumOptions); virtual; abstract;
    function GetNamespaceRootID : PItemIDList; virtual; abstract;
    function GetComboExtID : PItemIDList; virtual; abstract;
    function ID_HasChildren(aPIDL : PItemIDList; aEnumOptions : TLMDShellEnumOptions) : boolean; virtual; abstract;
    function ID_Clone(aPIDL : PItemIDList) : PItemIDList; virtual; abstract;
    function ID_FindLast(aPIDL : PItemIDList) : PItemIDList; virtual; abstract;
    function ID_CloneFirst(aPIDL : PItemIDList) : PItemIDList; virtual; abstract;
    function ID_Combine(aPIDL1, aPIDL2 : PItemIDList) : PItemIDList; virtual; abstract;
    function ID_Next(aPIDL : PItemIDList) : PItemIDList; virtual; abstract;
    function ID_RemoveLastID(aPIDL : PItemIDList) : boolean; virtual; abstract;
    function ID_Size(aPIDL : PItemIDList) : word; virtual; abstract;
    function ID_Compare(aPIDL1, aPIDL2 : PItemIDList; aAbsoluteID : PItemIDList = nil) : integer; virtual; abstract;
    procedure ID_Free(aPIDL : PItemIDList); virtual; abstract;

    procedure ChDir(aPIDL : PItemIDList); overload; virtual;
    procedure ChDir(const aPath : string); overload; virtual;
    procedure LevelUp; virtual; abstract;
    procedure GoBack(index : integer = -1); virtual; abstract;
    procedure GoForward(index : integer = -1); virtual; abstract;
    function ExecuteDefault(aItem : TLMDCustomShellItem) : boolean; virtual; abstract;
    function ShowPropertySheet(aItem : TLMDCustomShellItem) : boolean; virtual; abstract;
    function CopyToClipboard(aItem : TLMDCustomShellItem): Boolean; virtual; abstract;
    function CutToClipboard(aItem : TLMDCustomShellItem): Boolean; virtual; abstract;
    function PasteFromClipboard(aItem : TLMDCustomShellItem): Boolean; virtual; abstract;
    function RenameItem(aItem : TLMDCustomShellItem; const aNewName : string): Boolean; virtual; abstract;
    function DeleteItem(aItem : TLMDCustomShellItem): Boolean; virtual; abstract;
    function NewFolder : string; virtual; abstract;

    { properties }

    // used to examine the current connected controls
    property Views[Index: Integer]: TObject read GetView;
    property ViewCount: Integer read GetViewCount;

    property ActiveFolder : TLMDCustomShellItem read FActiveFolder write SetActiveFolder;
    property NamespaceRootID : PItemIDList read GetNamespaceRootID;
    property ComboExtID : PItemIDList read GetComboExtID;
    property DragSource : TObject read FDragSource write FDragSource;
  end;

function BoolToExt(aValue : boolean) : TLMDShellBoolExt;
function ExtToBool(aValue : TLMDShellBoolExt) : boolean;
//----

function i_CLSIDFromString(const psz: string): TGUID;

function  i_BindToISHellFolder(Folder: IShellFolder; PIDL: PItemIDList;
                var Res: IShellFolder): Boolean;

implementation
uses
  ComObj, Variants,
  LMDShView, LMDShPIDL, LMDShMisc
  {$IFDEF LMD_DEBUGTRACE}, Dialogs{$ENDIF}
  ;

function BoolToExt(aValue : boolean) : TLMDShellBoolExt;
begin
  if aValue then Result := boolTrue
  else Result := boolFalse;
end;

{------------------------------------------------------------------------------}
function ExtToBool(aValue : TLMDShellBoolExt) : boolean;
begin
  Result := (aValue = boolTrue);
end;

{------------------------------------------------------------------------------}
function  int_CompareText(const Str1, Str2: string): integer;
begin

  Result := AnsiCompareText(Str1, Str2);

end;

{******************* Classe TLMDShellComponent ********************************}
{------------------------------------------------------------------------------}
function TLMDShellComponent.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_SHELL;
end;

{******************* Classe TLMDShellBaseDialog *******************************}
{------------------------- private --------------------------------------------}
function TLMDShellBaseDialog.GetOwnerHandle(aHWND: HWND = 0): HWND;
begin
  Result := aHWND;
  if csDesigning in Componentstate then exit;
  if Result=0 then
    case FParent of
      pwApplication:Result:=Application.Handle;
      pwOwnerForm: if (Owner<>nil) and (Owner is TCustomForm) then Result:=TCustomForm(Owner).Handle;
    end;
end;

{** TLMDShellDummyItems *******************************************************}
{-- private -------------------------------------------------------------------}
function TLMDShellDummyItems.GetItem(index : integer) : TLMDCustomShellItem;
begin
  Result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDShellDummyItems.GetCount : integer;
begin
  Result := 0;
end;

{** TLMDCustomShellItem *******************************************************}
{-- private -------------------------------------------------------------------}
{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
constructor TLMDCustomShellItem.Create(aController : TLMDShellComponent);
begin
  inherited Create;
  FController           := aController;
  FAbsoluteID           := nil;
  FRelativeID           := nil;
  FDisplayName          := '';
  FShortFileName        := '';;
  FPath                 := '';
  FTypeName             := '';
  FExtension            := '';
  FFileAttributes       := [];
  FFileAttributesStr    := '';
  FFileProperties       := [];
  FFileCapabilities     := [];
  FFileSize             := -1;
  FModifiedDate         := -1;
  FAccessDate           := -1;
  FCreationDate         := -1;
  FIconIndex            := -1;
  FOpenIconIndex        := -1;
  FOverlayIconIndex     := -1;
  FLargeIcon            := nil;
  FLargeOpenIcon        := nil;
  FSmallIcon            := nil;
  FSmallOpenIcon        := nil;
  FDriveType            := -1;
  FIsNamespaceRoot      := boolUnknown;
  FIsFile               := boolUnknown;
  FIsFileFolder         := boolUnknown;
  FIsFileSystem         := boolUnknown;
  FIsLink               := boolUnknown;
  FIsFolder             := boolUnknown;
  FDetails              := TStringList.Create;
  FDetailsEx            := nil;
  FData                 := 0;
  FChecked              := False;
  FDWFileAttributes     := 0;
  FLevel                := 0;
  FDummyItems := TLMDShellDummyItems.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomShellItem.Destroy;
var
  C : TLMDCustomShellController;
begin
  if  Assigned(FCustomData) and FOwnedCustomData  then
    FCustomData.Free;

  C := TLMDCustomShellController(FController);
  if FAbsoluteID <> nil then C.ID_Free(FAbsoluteID);
  if FRelativeID <> nil then C.ID_Free(FRelativeID);
  FDetails.Free;
  FDetailsEx.Free;
  if FLargeIcon <> nil then FLargeIcon.Free;
  if FLargeOpenIcon <> nil then FLargeOpenIcon.Free;
  if FSmallIcon <> nil then FSmallIcon.Free;
  if FSmallOpenIcon <> nil then FSmallOpenIcon.Free;
  FDummyItems.Free;

  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellItem.Assign(aSource : TLMDCustomShellItem);
var
  C : TLMDCustomShellController;
begin
  C := TLMDCustomShellController(FController);
  FAbsoluteID         := C.ID_Clone(aSource.FAbsoluteID);
  FRelativeID         := C.ID_Clone(aSource.FRelativeID);
  FDisplayName        := aSource.FDisplayName;
  FShortFileName      := aSource.FShortFileName;
  FPath               := aSource.FPath;
  FTypeName           := aSource.FTypeName;
  FExtension          := aSource.FExtension;
  FFileAttributes     := aSource.FFileAttributes;
  FFileAttributesStr  := aSource.FFileAttributesStr;
  FFileProperties     := aSource.FFileProperties;
  FFileCapabilities   := aSource.FFileCapabilities;
  FFileSize           := aSource.FFileSize;
  FModifiedDate       := aSource.FModifiedDate;
  FAccessDate         := aSource.FAccessDate;
  FCreationDate       := aSource.FCreationDate;
  FIconIndex          := aSource.FIconIndex;
  FOpenIconIndex      := aSource.FOpenIconIndex;
  FOverlayIconIndex   := aSource.FOverlayIconIndex;
  if aSource.FLargeIcon <> nil then
    begin
      FLargeIcon := TIcon.Create;
      FLargeIcon.Handle := aSource.FLargeIcon.Handle;
    end;
  if aSource.FLargeOpenIcon <> nil then
    begin
      FLargeOpenIcon := TIcon.Create;
      FLargeOpenIcon.Handle := aSource.FLargeOpenIcon.Handle;
    end;
  if aSource.FSmallIcon <> nil then
    begin
      FSmallIcon := TIcon.Create;
      FSmallIcon.Handle := aSource.FSmallIcon.Handle;
    end;
  if aSource.FSmallOpenIcon <> nil then
    begin
      FSmallOpenIcon := TIcon.Create;
      FSmallOpenIcon.Handle := aSource.FSmallOpenIcon.Handle;
    end;
  FDriveType          := aSource.FDriveType;
  FIsNamespaceRoot    := aSource.FIsNamespaceRoot;
  FIsFile             := aSource.FIsFile;
  FIsFileFolder       := aSource.FIsFileFolder;
  FIsFileSystem       := aSource.FIsFileSystem;
  FIsLink             := aSource.FIsLink;
  FIsFolder           := aSource.FIsFolder;
  FDetails.Assign(aSource.FDetails);
  FData               := aSource.FData;
  FChecked            := aSource.Checked;
  FDWFileAttributes   := aSource.FDWFileAttributes;
  FLevel              := aSource.FLevel;

  if  Assigned(aSource.FDetailsEx)  then
    begin
      if  not Assigned(FDetailsEx)  then
        FDetailsEx := TStringList.Create;
      FDetailsEx.Assign(aSource.FDetailsEx);
    end
  else
    FreeAndNil(FDetailsEx);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellItem.Delete;
begin
  TLMDCustomShellController(Controller).DeleteItem(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellItem.Refresh;
Begin
//
end;

procedure TLMDCustomShellItem.SetChecked(const Value: boolean);
begin
  if (FChecked <> Value) then
  begin
    FChecked := Value;
    if Assigned(FOnCheckItem) then
      FOnCheckItem(Self, FChecked);
  end;
end;

{------------------------------------------------------------------------------}
function  TLMDCustomShellItem.GetDetailsInfo: TShellItemDetailsInfoArray;

  function  RtoS(const StrRet: TStrRetEx; var Res: string): Boolean;
  begin
    Res := LMDStrRetToString(nil, StrRet);
    Result := (Res <> '');
  end;

  procedure AddRow(const Title, View: string; Flags: dword);
  var
    i: integer;
  begin
    i := Length(Result) + 1;
    SetLength(Result, i);
    dec(i);
    Result[i].Title := Title;
    Result[i].View := View;
    Result[i].Flags := Flags;
  end;

var
  SF2: IShellFolder2;
  ISD: IShellDetails;
  Title, View: TShellDetailsEx;
  S: string;
  i: integer;
  ColFlags: dword;
begin
  Result := nil;

  if  not Assigned(FAbsoluteID) then
    exit;

  if  not Supports(ParentShellFolderIntf, IShellFolder2, SF2) then
    SF2 := nil;

  ISD := GetIShellDetails(ParentShellFolderIntf, RelativeID);//AbsoluteID);

  if Assigned(SF2) then // Have IShellFolder2 interface
    begin
      i := 0;

      while Succeeded(SF2.GetDetailsOf(nil, i, Title)) do
        begin
          S := '';
          if  Failed(SF2.GetDefaultColumnState(i, ColFlags)) then
            ColFlags := 0;

          FillChar(View, sizeof(View), 0);

          if  (Failed(SF2.GetDetailsOf(RelativeID, i, View)) or not RtoS(View.str, S))
              and (Assigned(ISD) and Succeeded(ISD.GetDetailsOf(RelativeID, i, View))) then
            RtoS(View.str, S);

            AddRow(LMDStrRetToString(nil, Title.Str), S, ColFlags);
          StrRetFree(View.str);
          StrRetFree(Title.str);
          Inc(i);
        end;

      SF2 := nil;
    end;

  if  (Length(Result) = 0) and Assigned(ISD)  then
    begin
      i := 0;
      ColFlags := 0;

      while Succeeded(ISD.GetDetailsOf(nil, i, Title)) do
        begin
          S := '';

          FillChar(View, sizeof(View), 0);

          if  Succeeded(ISD.GetDetailsOf(RelativeID, i, View)) then
            RtoS(View.str, S);

          AddRow(LMDStrRetToString(nil, Title.Str), S, ColFlags);
          StrRetFree(View.str);
          StrRetFree(Title.str);
          Inc(i);
        end;
    end;
end;

function  TLMDCustomShellItem.GetDetailItem(ItemType: TLMDShellItemDetailsColumn): string;
  function  i_DateTimeToStr(V: TDateTime): string;
  begin
    if  V > 0 then
      Result := DateTimeToStr(V)
    else
      Result := '';
  end;

  function  i_DateToStr(V: TDateTime): string;
  begin
    if  V > 0 then
      Result := FormatDateTime('ddddd', V)
    else
      Result := '';
  end;

  function  i_TimeToStr(V: TDateTime): string;
  begin
    if  V > 0 then
      Result := FormatDateTime('t', V)
    else
      Result := '';
  end;

begin
  Result := '';

  case  ItemType of
    cdName:           Result := DisplayName;
    cdTypeName:       Result := TypeName;
    cdAttributes:     Result := FileAttributesStr;
    cdWriteDate:      Result := i_DateToStr(ModifiedDate);
    cdWriteTime:      Result := i_TimeToStr(ModifiedDate);
    cdWriteDateTime:  Result := i_DateTimeToStr(ModifiedDate);
    cdCreateDate:     Result := i_DateToStr(CreationDate);
    cdCreateTime:     Result := i_TimeToStr(CreationDate);
    cdCreateDateTime: Result := i_DateTimeToStr(CreationDate);
    cdAccessDate:     Result := i_DateToStr(AccessDate);
    cdAccessTime:     Result := i_TimeToStr(AccessDate);
    cdAccessDateTime: Result := i_DateTimeToStr(AccessDate);
    cdSize:
      if  IsFile  then
        Result := IntToStr(FileSize);
  end;
end;

{------------------------------------------------------------------------------}

function TLMDCustomShellItem.int_GetDetailsEx(ColID: integer): string;
var
  S: string;
  i: integer;
begin
  Result := '';

  if  Assigned(FDetailsEx)  then
    i := FDetailsEx.IndexOfObject(TObject(ColID))
  else
    i := -1;

  if  i < 0 then
    begin
      if  GetDetailsEx(ColID, S)  then
        begin
          if  not Assigned(FDetailsEx)  then
            FDetailsEx := TStringList.Create;

          FDetailsEx.AddObject(S, TObject(ColID));
          Result := S;
        end;
    end
  else
    Result := FDetailsEx[i];
end;

{------------------------------------------------------------------------------}

function TLMDCustomShellItem.GetDetailsEx(ColID: integer; var Res: string): Boolean;
begin
  Res := '';
  Result := False;
end;

{------------------------------------------------------------------------------}

procedure TLMDCustomShellItem.LoadDetailsEx(const ColIDs: array of integer);
begin
end;

{** TLMDShellItemsList ********************************************************}
{-- private -------------------------------------------------------------------}
function TLMDShellItemsList.GetItem(index : integer) : TLMDCustomShellItem;
begin
  Result := TLMDCustomShellItem(FList[index]);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.GetCount : integer;
begin
  Result := FList.count;
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByAbsoluteID(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  Result := TLMDCustomShellController(Item1.Controller).ID_Compare(Item1.AbsoluteID, Item2.AbsoluteID);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByRelativeID(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  Result := TLMDCustomShellController(Item1.Controller).ID_Compare(Item1.RelativeID, Item2.RelativeID, Item1.AbsoluteID);
end;

{------------------------------------------------------------------------------}
function ItemCompareFolder(Item1, Item2: TLMDCustomShellItem) : integer;
var
  F1, F2: Boolean;
begin
  F1 := Item1.IsFileFolder;
  F2 := Item2.IsFileFolder;

  if not F1 and F2 then
    Result := 1
  else
  if F1 and not F2 then
    Result := -1
  else
  if F1 and F2 then
    Result :=  int_CompareText(Item1.DisplayName, Item2.DisplayName)
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByName(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  Result := ItemCompareFolder(Item1, Item2);

  if  Result = 0  then
    Result :=  int_CompareText(Item1.DisplayName, Item2.DisplayName);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByDetails(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  Result := ItemCompareFolder(Item1, Item2);

  if  Result = 0  then
    Result := int_CompareText(Item1.Details[integer(FDetailsColumn)], Item2.Details[integer(FDetailsColumn)]);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByDetailsEx(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  Result := int_CompareText(Item1.Details[integer(FDetailsColumn)], Item2.Details[integer(FDetailsColumn)]);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByExtension(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  if not Item1.IsFileFolder and Item2.IsFileFolder then Result := 1
  else if Item1.IsFileFolder and not Item2.IsFileFolder then Result := -1
  else Result := int_CompareText(Item1.Extension, Item2.Extension);

  if  Result = 0  then
    Result :=  int_CompareText(Item1.DisplayName, Item2.DisplayName);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByTypeName(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  if not Item1.IsFileFolder and Item2.IsFileFolder then Result := 1
  else if Item1.IsFileFolder and not Item2.IsFileFolder then Result := -1
  else Result := int_CompareText(Item1.TypeName, Item2.TypeName);

  if  Result = 0  then
    Result :=  int_CompareText(Item1.DisplayName, Item2.DisplayName);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByAttributes(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  if not Item1.IsFileFolder and Item2.IsFileFolder then Result := 1
  else if Item1.IsFileFolder and not Item2.IsFileFolder then Result := -1
  else Result := int_CompareText(Item1.FileAttributesStr, Item2.FileAttributesStr);

  if  Result = 0  then
    Result :=  int_CompareText(Item1.DisplayName, Item2.DisplayName);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByFileSize(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  if Item2.IsFileFolder and not Item1.IsFileFolder then Result := 1
  else if Item1.IsFileFolder and not Item2.IsFileFolder then  Result := -1
  else if Item1.FileSize > Item2.FileSize then Result := 1
  else if Item1.FileSize < Item2.FileSize then Result := -1
  else Result := int_CompareText(Item1.Path, Item2.Path);

  if  Result = 0  then
    Result :=  int_CompareText(Item1.DisplayName, Item2.DisplayName);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByModifiedDate(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  if Item1.IsFileFolder and not Item2.IsFileFolder then Result := -1
  else if Item2.IsFileFolder and not Item1.IsFileFolder then Result := 1
  else if Item2.ModifiedDate > Item1.ModifiedDate then Result := 1
  else if Item2.ModifiedDate < Item1.ModifiedDate then Result := -1
  else Result := 0;

  if  Result = 0  then
    Result :=  int_CompareText(Item1.DisplayName, Item2.DisplayName);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByAccessDate(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  if Item1.IsFileFolder and not Item2.IsFileFolder then Result := -1
  else if Item2.IsFileFolder and not Item1.IsFileFolder then Result := 1
  else if Item2.AccessDate > Item1.AccessDate then Result := 1
  else if Item2.AccessDate < Item1.AccessDate then Result := -1
  else Result := 0;

  if  Result = 0  then
    Result :=  int_CompareText(Item1.DisplayName, Item2.DisplayName);
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.CompareByCreationDate(Item1, Item2 : TLMDCustomShellItem) : integer;
begin
  if Item1.IsFileFolder and not Item2.IsFileFolder then Result := -1
  else if Item2.IsFileFolder and not Item1.IsFileFolder then Result := 1
  else if Item2.CreationDate > Item1.CreationDate then Result := 1
  else if Item2.CreationDate < Item1.CreationDate then Result := -1
  else Result := 0;

  if  Result = 0  then
    Result :=  int_CompareText(Item1.DisplayName, Item2.DisplayName);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.Sort(aCompareFunc : TLMDShellItemsCompareFunc);
  procedure ExchangeItems(Index1, Index2: Integer);
  var
    Item: TObject;
  begin
    Item := FList[Index1];
    FList[Index1] := FList[Index2];
    FList[Index2] := Item;
  end;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P: Integer;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while aCompareFunc(GetItem(I), GetItem(P)) < 0 do Inc(I);
        while aCompareFunc(GetItem(J), GetItem(P)) > 0 do Dec(J);
        if I <= J then
        begin
          ExchangeItems(I, J);
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;
begin
  if FList.count > 1 then QuickSort(0,FList.count-1);
end;

{-- protecte ------------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
constructor TLMDShellItemsList.Create;
begin
  inherited;
  FList := TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellItemsList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDShellItemsList.Add(aItem : TLMDCustomShellItem) : TLMDCustomShellItem;
begin
  Result := aItem;
  FList.Add(aItem);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.Insert(aIndex : integer; aItem : TLMDCustomShellItem);
begin
  FList.Insert(aIndex, aItem);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.Clear;
begin
  FList.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.Delete(aIndex : integer);
var
  LItem: TLMDCustomShellItem;
begin
  LItem := TLMDCustomShellItem(FList.Items[aIndex]);
  if Assigned(LItem.OnCheckItem) then
    LItem.OnCheckItem := nil;
  FList.Delete(aIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.Delete(AItem: TLMDCustomShellItem);
var
  i: Integer;
begin
  i := FList.IndexOf(AItem);
  if i >= 0 then
    FList.Delete(i);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByAbsoluteID;
begin
  Sort(CompareByAbsoluteID);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByRelativeID;
begin
  Sort(CompareByRelativeID);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByName;
begin
  Sort(CompareByName);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByDetails(aColumn : TLMDShellItemDetailsColumn);
begin
  FDetailsColumn := aColumn;
  Sort(CompareByDetails);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByDetails(Index: integer);

var
  i: integer;
  SF2: IShellFolder2;
  ISD: IShellDetails;
  ShellItem: TLmdCustomShellItem;
  HR: HResult;
  SD: TShellDetails;
  SCID: TShColumnID;
  fSCID: Boolean;
  V: OleVariant;
  S: string;

begin
  fSCID := False;
  SF2 := nil;
  ISD := nil;
  FDetailsData := TStringList.Create;

  try
    for i := 0 to Count - 1 do
      begin
        HR := E_UNEXPECTED;
        ShellItem := Item[i];

        if  not (Assigned(SF2) or Assigned(ISD))  then
          begin

            if  not Supports(ShellItem.ParentShellFolderIntf, IShellFolder2, SF2) then
              SF2 := nil;
//            ShellItem.ParentShellFolderIntf.QueryInterface(IID_IShellFolder2, pointer(SF2));

            if Assigned(SF2) then
              {$ifdef LMDCOMP14}
              fSCID := Succeeded(SF2.MapColumnToSCID(Index, SCID))
              {$else}
              fSCID := Succeeded(SF2.MapNameToSCID(PWChar(Index), SCID))
              {$endif} 
            else

              ISD := GetIShellDetails(ShellItem.ParentShellFolderIntf, ShellItem.AbsoluteID);

            if  not (Assigned(SF2) or Assigned(ISD))  then
              break;
          end;

        if  Assigned(SF2) then
          begin

            if  fSCID and Succeeded(SF2.GetDetailsEx(ShellItem.RelativeID, SCID, @V))  then

              begin

                if  VarType(V) in [20, 21] then  //  VT_I8, VT_UI8
                  S := IntToStr(PInt64(@(TVarData(V).VInteger))^)
                else

                  S := V;
                FDetailsData.AddObject(S, ShellItem);
                Continue;
              end
            else
              HR := SF2.GetDetailsOf(ShellItem.RelativeID, Index, SD);
          end;

        if  Failed(HR) then
          begin
            if  not Assigned(ISD)  then
              ISD := GetIShellDetails(ShellItem.ParentShellFolderIntf, ShellItem.AbsoluteID);

            if  Assigned(ISD)  then
              HR := ISD.GetDetailsOf(ShellItem.RelativeID, Index, SD);
          end;

        if Succeeded(HR)  then
          //FDetailsData.AddObject(String(LMDStrRetToStringEx(ShellItem.RelativeID, SD.str)), ShellItem)
          FDetailsData.AddObject(LMDStrRetToStr(ShellItem.RelativeID, SD.str), ShellItem)
        else
          FDetailsData.AddObject('', ShellItem);
      end;

    TStringList(FDetailsData).Sort;

    if  FDetailsData.Count = FList.Count then
      for i := 0 to FDetailsData.Count - 1 do
        FList[i] := FDetailsData.Objects[i];
  finally
    FreeAndNil(FDetailsData);
  end;
//  FSortIndex := Index;
//  Sort(CompareByDetailsIdx);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByDetailsEx(aColumn : TLMDShellItemDetailsColumn);
begin
  FDetailsColumn := aColumn;
  Sort(CompareByDetailsEx);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByExtension;
begin
  Sort(CompareByExtension);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByTypeName;
begin
  Sort(CompareByTypeName);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByAttributes;
begin
  Sort(CompareByAttributes);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByFileSize;
begin
  Sort(CompareByFileSize);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByModifiedDate;
begin
  Sort(CompareByModifiedDate);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByAccessDate;
begin
  Sort(CompareByAccessDate);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItemsList.SortByCreationDate;
begin
  Sort(CompareByCreationDate);
end;

{** TLMDShellItems ************************************************************}
{-- private -------------------------------------------------------------------}
{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
procedure TLMDShellItems.Clear;
var
  i : integer;
begin
  for i := 0 to count-1 do
    TObject(Item[i]).Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellItems.Delete(aIndex : integer);
begin
  TObject(FList[aIndex]).Free;
  FList.Delete(aIndex);
end;

{** TLMDCustomShellController *************************************************}
{-- private -------------------------------------------------------------------}
procedure TLMDCustomShellController.ClearViews;
begin
  FViews.Clear;
end;

{------------------------------------------------------------------------------}
function TLMDCustomShellController.GetView(Index:Integer):TObject;
begin
  Result := FViews[index];
end;

{------------------------------------------------------------------------------}
function TLMDCustomShellController.GetViewCount:Integer;
begin
  if  Assigned(FViews)  then
    Result := FViews.Count
  else
    Result := 0;
end;
{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.ActiveFolderChanged;
var
  i     : integer;
  SV    : ILMDShellView;
  Lst   : TInterfaceList;
begin
  Lst := nil;

  try
    if  Assigned(FViews)  then
      for i := 0 to FViews.count-1 do
        if Supports(TObject(FViews[i]), ILMDShellView, SV) then
          begin
            try
              Application.ProcessMessages;
              SV.BeginUpdate;
              SV.ActiveFolderChanged;
            finally
              SV.EndUpdate;
              SV := nil;
            end;
          end;
{
    try
      for i := 0 to FViews.count-1 do
        if Supports(TObject(FViews[i]), ILMDShellView, SV) then
          begin
            if  not Assigned(Lst) then
              Lst := TInterfaceList.Create;

            Lst.Add(SV);
            SV.BeginUpdate;
          end;

      if  Assigned(Lst) then
        for i := 0 to Lst.Count - 1 do
          ILMDShellView(Lst[i]).ActiveFolderChanged;
    finally
      if  Assigned(Lst) then
        for i := 0 to Lst.Count - 1 do
          ILMDShellView(Lst[i]).EndUpdate;
    end;
}
  finally
    Lst.Free;
  end;
{
  for i := 0 to FViews.count-1 do Begin
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
       SV.BeginUpdate;
  End;
  for i := 0 to FViews.count-1 do
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
      SV.ActiveFolderChanged;
  for i := 0 to FViews.count-1 do Begin
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
       SV.EndUpdate;
  End;
}
  TriggerActiveFolderChanged;
end;

{-- protected -----------------------------------------------------------------}
procedure TLMDCustomShellController.TriggerActiveFolderChanged;
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoFileChange(aPIDL : PItemIDList);
var
  i     : integer;
  SV    : ILMDShellView;
begin
  for i := 0 to FViews.count-1 do
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
      SV.DoFileChange(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoFileCreate(aPIDL : PItemIDList);
var
  i     : integer;
  SV    : ILMDShellView;
begin
  for i := 0 to FViews.count - 1 do
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
      SV.DoFileCreate(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoFileDelete(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
var
  i     : integer;
  SV    : ILMDShellView;
begin
  for i := 0 to FViews.count - 1 do
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
      SV.DoFileDelete(aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoFileRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
var
  i     : integer;
  SV    : ILMDShellView;
begin
  for i := 0 to FViews.count - 1 do
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
      SV.DoFileRename(aPIDL1 ,aPIDL2);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoFolderChange(aPIDL : PItemIDList);
var
  i     : integer;
  SV    : ILMDShellView;
begin
  for i := 0 to FViews.count - 1 do
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
      SV.DoFolderChange(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoFolderCreate(aPIDL : PItemIDList);
var
  i     : integer;
  SV    : ILMDShellView;
begin
  for i := 0 to FViews.count - 1 do
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
      SV.DoFolderCreate(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoFolderDelete(aPIDL : PItemIDList);
var
  i     : integer;
  SV    : ILMDShellView;
begin
  for i := 0 to FViews.count - 1 do
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
      SV.DoFolderDelete(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoFolderRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
var
  i     : integer;
  SV    : ILMDShellView;
begin
  for i := 0 to FViews.count - 1 do
    if Supports(TObject(FViews[i]), ILMDShellView, SV) then
      SV.DoFolderRename(aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.NotifyParentChange(aPIDL : PItemIDList);
var
  i     : integer;
  SV    : ILMDShellView;
  Parent: PItemIDList;
begin
  Parent := LMDGetParentPIDL(aPIDL);

  try
    for i := 0 to FViews.Count - 1 do
      if Supports(TObject(FViews[i]), ILMDShellView, SV) then
        SV.DoFolderChange(Parent);
  finally
    ID_Free(Parent);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoDriveChanged(aPIDL : PItemIDList; IsAdded: Boolean);
begin
  NotifyParentChange(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoMediaChanged(aPIDL : PItemIDList; IsInserted: Boolean);
begin
  NotifyParentChange(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.DoNetShare(aPIDL : PItemIDList; IsShared: Boolean);
begin
  NotifyParentChange(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.SetActiveFolder(const aValue : TLMDCustomShellItem);
begin
  if aValue = nil then Exit;
  ChDir(aValue.AbsoluteID);
end;

{-- public --------------------------------------------------------------------}
constructor TLMDCustomShellController.Create(aOwner : TComponent);
begin
  inherited;
  FViews := TList.Create;
  FActiveFolder := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomShellController.Destroy;
begin
  ClearViews;
  FViews.Free;
  if FActiveFolder <> nil then FActiveFolder.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.RegisterView(aView : TObject);
var
  i     : integer;
  SV    : ILMDShellView;
begin
  for i := 0 to FViews.count - 1 do
    if FViews[i] = aView then Exit;
  if Supports(aView, ILMDShellView, SV) then
    FViews.Add(aView);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.UnRegisterView(aView : TObject);
var
  i     : integer;
begin
  for i := 0 to FViews.count - 1 do
    if FViews[i] = aView then
      begin
        FViews.Delete(i);
        Break;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.ChDir(aPIDL : PItemIDList);
begin
  ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomShellController.ChDir(const aPath : string);
begin
  ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
function  i_BindToISHellFolder(Folder: IShellFolder; PIDL: PItemIDList;
                var Res: IShellFolder): Boolean;
begin
  if  not Succeeded(

    Folder.BindToObject(PIDL, nil, IID_ISHellFolder, Res)

    )  then
  Res := nil;

  Result := Assigned(Res);
end;

function i_CLSIDFromString(const psz: string): TGUID;
begin
  if  Succeeded(CLSIDFromString(PWideChar(WideString(psz)), Result)) then
  else
  begin
    FillChar(Result, sizeof(Result), 0);
  end;
end;

{$IFDEF LMD_DEBUGTRACE}{$I C2.INC}{$ENDIF}
initialization
  {$IFDEF LMD_DEBUGTRACE}{$I C1.INC}{$ENDIF}
end.
