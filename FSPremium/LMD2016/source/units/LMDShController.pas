unit LMDShController;
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

LMDShController unit (DS)
------------------------
Contains controller for windows shell api items


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, ShlObj, ShellApi, Graphics, LMDTypes,
  LMDShBase, LMDShItem, LMDShPIDL, LMDShNtf;

type
  {****************************************************************************}
  TLMDShGetIconOption = (iSmall, iOpen);
  TLMDShGetIconOptions = set of TLMDShGetIconOption;

  TLMDShellFileOpFlag=(ffFilesOnly, ffNoActionConfirm, ffNoMKDIRConfirm, ffRenameFileOnCollision, ffShowNoErrors, ffShowNoProgress, ffSimpleProgress, ffUseRecycleBin);
  TLMDShellFileOpFlags=set of TLMDShellFileOpFlag;
  TLMDShellFileOperation=(foCopy, foRename, foMove, foDelete);

  {****************************************************************************}
  TLMDShellController = class(TLMDCustomShellController)
  private
    { property variables }
    FLargeFolderImages  : TImageList;
    FSmallFolderImages  : TImageList;

    { internal variables }
    FComboExtID         : PItemIDList;
    FObserver           : TLMDShellNotify;
    FForwardPathList    : TStringList;
    FBackwardPathList   : TStringList;
    FStopPathLog        : Boolean;
    FObserveChanges     : Boolean;

    { internal methods }
    function GetDesktopID : PItemIDList;
    function GetDesktopFolder : IShellFolder;
    function ID_ANSID(aPIDL1, aPIDL2 : PItemIDList) : boolean;

    { observer handlers }
    procedure OnFileChange(aSender : TObject; aPIDL : PItemIDList);
    procedure OnFileCreate(aSender : TObject; aPIDL : PItemIDList);
    procedure OnFileDelete(aSender : TObject; aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure OnFileRename(aSender : TObject; aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure OnFolderChange(aSender : TObject; aPIDL : PItemIDList);
    procedure OnFolderCreate(aSender : TObject; aPIDL : PItemIDList);
    procedure OnFolderDelete(aSender : TObject; aPIDL : PItemIDList);
    procedure OnFolderRename(aSender : TObject; aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure OnDriveAdd(aSender : TObject; aPIDL : PItemIDList);
    procedure OnDriveRemove(aSender : TObject; aPIDL : PItemIDList);
    procedure OnMediaInsert(aSender : TObject; aPIDL : PItemIDList);
    procedure OnMediaRemove(aSender : TObject; aPIDL : PItemIDList);
    procedure OnNetShare(aSender : TObject; aPIDL : PItemIDList);
    procedure OnNetUnShare(aSender : TObject; aPIDL : PItemIDList);
    procedure SetObserveChanges(aValue: Boolean);
  protected
    procedure ClearPathList(aList : TStringList);
  public
    { constructor / destructor }
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;

    { methods }
    function CreateShellItem(aPIDL : PItemIDList) : TLMDCustomShellItem; overload; override;
    function CreateShellItem(const aPath : string) : TLMDCustomShellItem; overload; override;
    procedure Enumerate(aPIDL : PItemIDList; aView : TObject; aEnumOptions : TLMDShellEnumOptions); override;
    function GetNamespaceRootID : PItemIDList; override;
    function GetComboExtID : PItemIDList;  override;
    function ID_Info(aPIDL : PItemIDList; aFlags : DWORD; aAttr : DWORD = 0) : TSHFileInfo;
    function ID_HasChildren(aPIDL : PItemIDList; aEnumOptions : TLMDShellEnumOptions) : boolean; override;
    function ID_Clone(aPIDL : PItemIDList) : PItemIDList; override;
    function ID_FindLast(aPIDL : PItemIDList) : PItemIDList; override;
    function ID_CloneFirst(aPIDL : PItemIDList) : PItemIDList; override;
    function ID_Combine(aPIDL1, aPIDL2 : PItemIDList) : PItemIDList; override;
    function ID_Next(aPIDL : PItemIDList) : PItemIDList; override;
    function ID_RemoveLastID(aPIDL : PItemIDList) : boolean; override;
    function ID_Size(aPIDL : PItemIDList) : word; override;
    procedure ID_Free(aPIDL : PItemIDList); override;
    function ID_PathToPIDL(const aPath : string; aParentFolder : IShellFolder) : PItemIDList;
    function ID_ParentFolder(aPIDL : PItemIDList) : IShellFolder;
    function ID_Name(aPIDL : PItemIDList; aParentFolder : IShellFolder; aFlags : DWORD) : string;
    function ID_HasAttribute(aPIDL : PItemIDList; aParentFolder : IShellFolder; aFlags : DWORD) : boolean;
    function ID_Data(aPIDL : PItemIDList; aParentFolder : IShellFolder) : TWin32FindData;
    function ID_Equal(aPIDL1, aPIDL2 : PItemIDList) : boolean;
    function ID_Icon(aPIDL : PItemIDList; aOptions : TLMDShGetIconOptions = []) : TIcon;
    function ID_Attributes(aPIDL : PItemIDList; aParentFolder : IShellFolder; aFlags : DWORD) : DWORD;
    function ID_Compare(aPIDL1, aPIDL2 : PItemIDList; aAbsoluteID : PItemIDList = nil) : integer; override;

    procedure ChDir(aPIDL : PItemIDList); override;
    procedure ChDir(const aPath : string); override;
    procedure LevelUp; override;
    procedure GoBack(index : integer = -1); override;
    procedure GoForward(index : integer = -1); override;

    function ExecuteDefault(aItem : TLMDCustomShellItem) : boolean; override;
    function ShowPropertySheet(aItem : TLMDCustomShellItem) : boolean; override;
    function CopyToClipboard(aItem : TLMDCustomShellItem): Boolean; override;
    function CutToClipboard(aItem : TLMDCustomShellItem): Boolean; override;
    function PasteFromClipboard(aItem : TLMDCustomShellItem): Boolean; override;
    function RenameItem(aItem : TLMDCustomShellItem; const aNewName : string): Boolean; override;
    function DeleteItem(aItem : TLMDCustomShellItem): Boolean; override;
    function NewFolder : string; override;

    // FileOperations
    function CopyFiles(const aSource, aDestination:String):Boolean;
    function MoveFiles(const aSource, aDestination:String):Boolean;

    { properties }
    property ID_DesktopID : PItemIDList read GetDesktopID;
    property ID_DesktopFolder : IShellFolder read GetDesktopFolder;
    property LargeFolderImages : TImageList read FLargeFolderImages;
    property SmallFolderImages : TImageList read FSmallFolderImages;
    property ForwardPathList : TStringList read FForwardPathList;
    property BackwardPathList : TStringList read FBackwardPathList;
    property ObserveChanges: Boolean read FObserveChanges write SetObserveChanges default True;
  end;

function LMDShellDoContextMenuVerb(aSender : TObject; aFolder : IShellFolder;
          const aPIDL: PLMDShellPIDLArray; aHandle : THandle; const aVerb : string): Boolean; overload;
//          const aPIDL: PLMDShellPIDLArray; aCount : Integer; aHandle : THandle; const aVerb : string): Boolean; overload;
function LMDShellDoContextMenuVerb(aSender : TObject; aFolder : IShellFolder;
          aPIDL : PItemIDList; aHandle : THandle; const aVerb : string): Boolean; overload;
//          var aPIDL : PItemIDList; aCount : Integer; aHandle : THandle; const aVerb : string): Boolean; overload;
function LMDShellDoContextMenuVerb(Owner: TWinControl; aItem: TLMDCustomShellItem;
            const Verb: string): Boolean; overload;
function LMDShellInvokeContextMenu(aSender : TObject; aFolder : IShellFolder;
                                    const aPIDL: PLMDShellPIDLArray;
//                                    var aPIDL : PItemIDList; aCount : Integer;
                                    aX, aY : Integer; aHandle : THandle; aFlags : DWORD; aSuppressCmd: boolean = false) : Integer; overload;
function LMDShellInvokeContextMenu(aSender : TObject; aFolder : IShellFolder;
                                    aPIDL: PItemIDList;
                                    aX, aY : Integer; aHandle : THandle; aFlags : DWORD; aSuppressCmd: boolean = false) : Integer; overload;

function LMDShellInvokeContextMenu(aSender : TObject; aFullName: TLMDString;
                                    aX, aY : Integer; aHandle : THandle; aFlags : DWORD; aSuppressCmd: boolean = false) : Integer; overload;

function LMDShellFileOperation(aSource:String; aDestination:String;
                              Operation:TLMDShellFileOperation;
                              Options:TLMDShellFileOpFlags):Boolean;
var
  ContextMenu2: IContextMenu2 = nil;

implementation

uses
  Forms, Sysutils, FileCtrl, LMDStrings,
  LMDShMisc, LMDShView, LMDShLink, LMDProcs;

{ the file-operations -------------------------------------------------------- }
function LMDShellFileOperation(aSource:String; aDestination:String;
                              Operation:TLMDShellFileOperation;
                              Options:TLMDShellFileOpFlags):Boolean;
var
  FileInfo: TSHFileOpStruct;
  i:TLMDShellFileOpFlag;
const
  FILEFLAGS:array [TLMDShellFileOpFlag] of Integer= (FOF_FILESONLY, FOF_NOCONFIRMATION, FOF_NOCONFIRMMKDIR, FOF_RENAMEONCOLLISION, FOF_NOERRORUI, FOF_SILENT, FOF_SIMPLEPROGRESS, FOF_ALLOWUNDO);
begin
  Result:=false;
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

      pFrom  := int_Ref(aSource);
      case Operation of
        foCopy:
          begin
            wFunc  := FO_COPY;
            pTo    := int_Ref(aDestination);
            lpszProgressTitle := '';
          end;
        foMove:
          begin
            wFunc := FO_MOVE;
            pTo   := int_Ref(aDestination);
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
            pTo := int_Ref(aDestination);
            lpszProgressTitle := '';
          end;
      end; // end of case
      for i:=Low(TLMDShellFileOpFlag) to High(TLMDShellFileOpFlag) do
        if i in Options then fFlags := fFlags or FILEFLAGS[i];
    end; // end of with
  Result:= (SHFileOperation(FileInfo)=0) and (not FileInfo.fAnyOperationsAborted);
end;

{******************************************************************************}

function LMDShellDoContextMenuVerb(aSender : TObject; aFolder : IShellFolder;
          const aPIDL : PLMDShellPIDLArray; aHandle : THandle; const aVerb : string): Boolean;
//          var aPIDL : PItemIDList; aCount : Integer; aHandle : THandle; const aVerb : string): Boolean;
var
  CM    : IContextMenu;
  ICI   : TCmInvokeCommandInfo;
begin
  Result := False;

  if Assigned(aFolder)  then
    begin

      if (aFolder.GetUIObjectOf(aHandle, Length(aPIDL), aPIDL[0], IID_IContextMenu, nil, CM) = NOERROR) then

//      if (aFolder.GetUIObjectOf(aHandle, aCount, aPIDL, IID_IContextMenu, nil, CM) = NOERROR) then
        begin

          ZeroMemory(@ICI, SizeOf(ICI));
          ICI.cbSize := SizeOf(TCmInvokeCommandInfo);

          ICI.hwnd := aHandle;
          ICI.fMask := CMIC_MASK_ASYNCOK;
          ICI.lpVerb := Int_RefA(AnsiString(aVerb));
          ICI.nShow := Windows.SW_SHOWNORMAL;
          Result := Succeeded(CM.InvokeCommand(ICI));
          int_Free([ICI.lpVerb]);
          CM := nil;
        end;
    end;

end;

{******************************************************************************}
function LMDShellDoContextMenuVerb(aSender : TObject; aFolder : IShellFolder;
          aPIDL : PItemIDList; aHandle : THandle; const aVerb : string): Boolean;
var
  A: PLMDShellPIDLArray;
begin
  if  Assigned(aPIDL) then
    begin
      SetLength(A, 1);
      A[0] := aPIDL;
      Result := LMDShellDoContextMenuVerb(aSender, aFolder, A, aHandle, aVerb);
    end
  else
    Result := False;
end;

{******************************************************************************}

function  LMDShellDoContextMenuVerb(Owner: TWinControl; aItem: TLMDCustomShellItem;
              const Verb: string): Boolean;
begin
   Result := LMDShellDoContextMenuVerb(nil, aItem.ParentShellFolderIntf, aItem.RelativeID,
          0, verb);
End;

{******************************************************************************}
function LMDShellInvokeContextMenu(aSender : TObject; aFolder : IShellFolder;
  const aPIDL: PLMDShellPIDLArray;
//  var aPIDL : PItemIDList; aCount : Integer;
  aX, aY : Integer; aHandle : THandle;
  aFlags : DWORD; aSuppressCmd: boolean = false) : Integer;
var
  hMenu        : THandle;
  CM           : IContextMenu;
  CI           : TCmInvokeCommandInfo;
  Cmd          : DWORD;
begin
//  hMenu := 0;
  Result := -1;
  if Assigned(aFolder) and

     (aFolder.GetUIObjectOf(aHandle, Length(aPIDL), aPIDL[0], IID_IContextMenu, nil, CM) = NOERROR)

//      if (aFolder.GetUIObjectOf(aHandle, aCount, aPIDL, IID_IContextMenu, nil, CM) = NOERROR) then
      and Assigned(CM)  then
    begin
      hMenu := CreatePopupMenu;

      try
        CM.QueryContextMenu(hMenu, 0, 1, $7FFF, aFlags);
        if  not Supports(CM, IContextMenu2, ContextMenu2) then //To handle submenus.
          ContextMenu2 := nil;

        try
          Cmd := Cardinal(TrackPopupMenu(hMenu,
              TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON or TPM_RETURNCMD,
              aX, aY, 0, aHandle, nil));
        finally
          ContextMenu2 := nil;
        end;

        if Cmd <> 0 then
          begin
            Result := Cmd;
            if not aSuppressCmd then
              begin
                dec(Cmd, 1);
                ZeroMemory(@CI, SizeOf(CI));
                CI.cbSize := SizeOf(TCmInvokeCommandInfo);
                CI.lpVerb := PAnsiChar(MAKEINTRESOURCE(Cmd));
                CI.lpParameters := nil;
                CI.lpDirectory := nil;
                CI.hwnd := AHandle;
                CI.nShow := SW_SHOWNORMAL;
              CM.InvokeCommand(CI);
            end;
          end;
        CM := nil;
      finally
        if hMenu <> 0 then DestroyMenu(hMenu);
      end;
    end;
end;

{******************************************************************************}
function LMDShellInvokeContextMenu(aSender : TObject; aFolder : IShellFolder;
                                    aPIDL: PItemIDList;
                                    aX, aY : Integer; aHandle : THandle; aFlags : DWORD; aSuppressCmd: boolean = false) : Integer; overload;
var
  A: PLMDShellPIDLArray;
begin
  if  Assigned(aPIDL) then
    begin
      SetLength(A, 1);
      A[0] := aPIDL;
      Result := LMDShellInvokeContextMenu(aSender, aFolder, A, aX, aY, aHandle, aFlags, aSuppressCmd);
    end
  else
    Result := 0;
end;

{******************************************************************************}
function LMDShellInvokeContextMenu(aSender : TObject; aFullName: TLMDString;
                                    aX, aY : Integer; aHandle : THandle; aFlags : DWORD; aSuppressCmd: boolean = false) : Integer; overload;
var
  A: PLMDShellPIDLArray;
  RelativeID, AbsoluteID: PItemIDList;
  lFolder: IShellFolder;
begin
  AbsoluteID := LMDPathToPIDL(aFullName);
  lFolder := GetIShellFolder(LMDGetParentPIDL(AbsoluteID));
  RelativeID := LMDShPIDLClone(LMDShPIDLFindLastID(AbsoluteID));
  if  Assigned(RelativeID) then
    begin
      SetLength(A, 1);
      A[0] := RelativeID;
      Result := LMDShellInvokeContextMenu(aSender, lFolder, A, aX, aY, aHandle, aFlags, aSuppressCmd);
    end
  else
    Result := 0;
end;

{** TLMDShellController *******************************************************}
{-- private -------------------------------------------------------------------}
function TLMDShellController.GetDesktopID : PItemIDList;
begin
  Result := LMDDesktopID;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.GetDesktopFolder : IShellFolder;
begin
  Result := LMDDesktopFolder;
end;

{$HINTS OFF}
{------------------------------------------------------------------------------}
function TLMDShellController.ID_ANSID(aPIDL1, aPIDL2 : PItemIDList) : boolean;
var
  tmpPIDL : PItemIDList;
begin
  Result := False;
  tmpPIDL := ID_Clone(aPIDL2);
  Result := ID_Equal(aPIDL1, tmpPIDL);

  while not Result do
    begin
      if not ID_RemoveLastID(tmpPIDL) then Break;
      Result := ID_Equal(aPIDL1, tmpPIDL);
    end;

  ID_Free(tmpPIDL);
end;
{$HINTS ON}

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnFileChange(aSender : TObject; aPIDL : PItemIDList);
begin
  DoFileChange(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnFileCreate(aSender : TObject; aPIDL : PItemIDList);
begin
  DoFileCreate(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnFileDelete(aSender : TObject; aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
begin
  DoFileDelete(aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnFileRename(aSender : TObject; aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
begin
  DoFileRename(aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnFolderChange(aSender : TObject; aPIDL : PItemIDList);
var
  tmpFolder : IShellFolder;
begin
  if  ID_Equal(ActiveFolder.AbsoluteID, ID_DesktopID) then
    DoFolderChange(aPIDL)
  else
    begin
      i_BindToISHellFolder(LMDDesktopFolder, ActiveFolder.AbsoluteID, tmpFolder);

      if tmpFolder <> nil then
        begin
          tmpFolder := nil;
          DoFolderChange(aPIDL);
        end
      else
        ChDir(aPIDL);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnFolderCreate(aSender : TObject; aPIDL : PItemIDList);
begin
  DoFolderCreate(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnFolderDelete(aSender : TObject; aPIDL : PItemIDList);
var
  tmpPIDL : PItemIDList;
begin
  if ID_ANSID(aPIDL, ActiveFolder.AbsoluteID) then
    begin
      tmpPIDL := ID_Clone(aPIDL);
      ID_RemoveLastID(tmpPIDL);
      ChDir(tmpPIDL);
      ID_Free(tmpPIDL);
    end
  else DoFolderDelete(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnFolderRename(aSender : TObject; aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
begin
  DoFolderRename(aPIDL1, aPIDL2);
  if ID_ANSID(aPIDL1, ActiveFolder.AbsoluteID) then
    ChDir(aPIDL2);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.ClearPathList(aList : TStringList);
var
  i : integer;
begin
  if not assigned(aList) then Exit;
  for i := 0 to aList.Count - 1 do
    LMDDisposePIDL(PItemIDList(aList.Objects[i]));
  aList.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnDriveAdd(aSender : TObject; aPIDL : PItemIDList);
begin
  DoDriveChanged(aPIDL, True);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnDriveRemove(aSender : TObject; aPIDL : PItemIDList);
begin
  DoDriveChanged(aPIDL, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnMediaInsert(aSender : TObject; aPIDL : PItemIDList);
begin
  DoMediaChanged(aPIDL, True);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnMediaRemove(aSender : TObject; aPIDL : PItemIDList);
begin
  DoMediaChanged(aPIDL, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnNetShare(aSender : TObject; aPIDL : PItemIDList);
begin
  DoNetShare(aPIDL, True);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.OnNetUnShare(aSender : TObject; aPIDL : PItemIDList);
begin
  DoNetShare(aPIDL, False);
end;

{------------------------------------------------------------------------------}

{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
constructor TLMDShellController.Create(aOwner : TComponent);
var
  SHFileInfo: TShFileInfo;
  Sz        : integer;
begin
  inherited;
  SHGetSpecialFolderLocation(Application.Handle, CSIDL_DRIVES, FComboExtID);
  FSmallFolderImages := TImageList.Create(nil);
  FLargeFolderImages := TImageList.Create(nil);
  SmallFolderImages.ShareImages := True;
  LargeFolderImages.ShareImages := True;

  Sz := SizeOf(TSHFileInfo);

  SmallFolderImages.Handle :=  SHGetFileInfo('', 0, SHFileInfo,
          Sz, SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  LargeFolderImages.Handle := SHGetFileInfo('', 0, SHFileInfo,
          Sz, SHGFI_SYSICONINDEX or SHGFI_LARGEICON);
  SmallFolderImages.bkColor := clNone;
  RegisterClipboardFormat(CFSTR_FILECONTENTS);
  RegisterClipboardFormat(CFSTR_FILEDESCRIPTOR);
  FObserver := nil;
  FObserveChanges := False;
  SetObserveChanges(True);
  FForwardPathList := TStringList.Create;
  FBackwardPathList := TStringList.Create;
  FStopPathLog := False;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellController.Destroy;
begin
  FObserver.Free;
  FComboExtID := nil;
  ClearPathList(FForwardPathList);
  ClearPathList(FBackwardPathList);
  FForwardPathList.Free;
  FBackwardPathList.Free;
  FSmallFolderImages.Free;
  FLargeFolderImages.Free;

  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.CreateShellItem(aPIDL : PItemIDList) : TLMDCustomShellItem;
begin
  Result := TLMDShellItem.CreateFromPIDL(aPIDL, Self);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.CreateShellItem(const aPath : string) : TLMDCustomShellItem;
begin
  Result := TLMDShellItem.CreateFromPath(aPath, Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.Enumerate(aPIDL : PItemIDList; aView : TObject; aEnumOptions : TLMDShellEnumOptions);
var
  SV            : ILMDShellView;
  Flags         : DWORD;
  ParentFolder  : IShellFolder;
//  RelativeID    : PItemIDList;
  Folder        : IShellFolder;
  hwndParent    : HWND;
  Enum          : IEnumIDList;
  Count         : Cardinal;
  AbsoluteID    : PItemIDList;
  FO            : Boolean;
  rgelt         : array[0..0] of PItemIDList;
begin
  if aView = nil then Exit;
  if aPIDL = nil then Exit;
  if not Supports(aView, ILMDShellView, SV) then Exit;

  FO := False;
  Enum := nil;
  Folder := nil;
  ParentFolder := nil;
//  RelativeID := nil;

  try
    if  ObserveChanges   //Assigned(FObserver) and FObserver.Active
        and (not ID_Equal(ActiveFolder.AbsoluteID, aPIDL)
          or not FObserver.Active)  then
      begin
        FO := True;
        FObserver.Active := False;
      end;

    SV.BeginEnumeration;
    Flags := 0;
    if eoFolders in aEnumOptions then Flags := SHCONTF_FOLDERS;
    if eoNonFolders in aEnumOptions then Flags := Flags or SHCONTF_NONFOLDERS;
    if eoIncludeHidden in aEnumOptions then Flags := Flags or SHCONTF_INCLUDEHIDDEN;

    if ID_Equal(aPIDL, LMDDesktopID) then
      begin
        ParentFolder := LMDDesktopFolder;
//        RelativeID := LMDShPIDLClone(aPIDL);
        Folder := LMDDesktopFolder;
      end
    else
     begin
        ParentFolder := ID_ParentFolder(aPIDL);
//        RelativeID := LMDShPIDLClone(LMDShPIDLFindLastID(aPIDL));
//        i_BindToISHellFolder(ParentFolder, RelativeID, Folder);
        i_BindToISHellFolder(ParentFolder, LMDShPIDLFindLastID(aPIDL), Folder);
     end;

    hwndParent := 0;
    if Folder <> nil then Folder.EnumObjects(hwndParent, Flags, Enum);
//    LMDDisposePIDL(RelativeID);

    if Enum <> nil then
      while not SV.TerminateEnumeration and (

            Enum.Next(1, rgelt[0]{RelativeID}, Count)

             = S_OK) do
        begin
          if Count = 0 then Break;
//          SV.AddItem(TLMDShellItem.CreateFromPIDLs(aPIDL, rgelt[0], self));
//          AbsoluteID :=  LMDShPIDLCombine(aPIDL, RelativeID);
          AbsoluteID :=  LMDShPIDLCombine(aPIDL, rgelt[0]);
          SV.AddItem(TLMDShellItem.CreateFromPIDL(AbsoluteID, Self));
          LMDShPIDLsFree(rgelt);
//          LMDDisposePIDL(RelativeID);
          LMDDisposePIDL(AbsoluteID);
        end;

  finally
    Enum := nil;
    Folder := nil;
    ParentFolder := nil;
    SV.EndEnumeration;
    SV := nil;

    if  FO  then
      FObserver.Active := True;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.GetNamespaceRootID : PItemIDList;
begin
  Result := LMDDesktopID;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.GetComboExtID : PItemIDList;
begin
  Result := FComboExtID;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_HasChildren(aPIDL : PItemIDList; aEnumOptions : TLMDShellEnumOptions) : boolean;
var
  Flags         : DWORD;
  ParentFolder  : IShellFolder;
  RelativeID    : PItemIDList;
  Folder        : IShellFolder;
  hwndParent    : HWND;
  Enum          : IEnumIDList;
  Count         : cardinal;
  rgelt         : array[0..0] of PItemIDList;
begin
  Result := False;
  if aPIDL = nil then Exit;

  Flags := 0;
  if eoFolders in aEnumOptions then Flags := SHCONTF_FOLDERS;
  if eoNonFolders in aEnumOptions then Flags := Flags or SHCONTF_NONFOLDERS;
  if eoIncludeHidden in aEnumOptions then Flags := Flags or SHCONTF_INCLUDEHIDDEN;

  if ID_Equal(aPIDL, LMDDesktopID) then
    begin
      ParentFolder := LMDDesktopFolder;
      Folder := LMDDesktopFolder;
    end
  else
   begin
      ParentFolder := ID_ParentFolder(aPIDL);
      RelativeID := LMDShPIDLClone(LMDShPIDLFindLastID(aPIDL));
      i_BindToISHellFolder(ParentFolder, RelativeID, Folder);
      LMDDisposePIDL(RelativeID);
   end;

  hwndParent := 0;
  if Assigned(Folder) then
    Folder.EnumObjects(hwndParent, Flags, Enum);

  if Assigned(Enum) then
    if Succeeded(

      Enum.Next(1, rgelt[0]{RelativeID}, Count)

        ) then
      begin
        Result := (Count > 0);
        LMDShPIDLsFree(rgelt{RelativeID});
      end;

  Enum := nil;
  Folder := nil;
  ParentFolder := nil;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_Clone(aPIDL : PItemIDList) : PItemIDList;
begin
  Result := LMDShPIDLClone(aPIDL);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_FindLast(aPIDL : PItemIDList) : PItemIDList;
begin
  Result := LMDShPIDLFindLastID(aPIDL);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_CloneFirst(aPIDL : PItemIDList) : PItemIDList;
begin
  Result := LMDShPIDLCloneFirst(aPIDL);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_Combine(aPIDL1, aPIDL2 : PItemIDList) : PItemIDList;
begin
  Result := LMDShPIDLCombine(aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_Next(aPIDL : PItemIDList) : PItemIDList;
begin
  Result := LMDShPIDLGetNext(aPIDL);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_RemoveLastID(aPIDL : PItemIDList) : boolean;
begin
  Result := LMDShPIDLRemoveLastID(aPIDL);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_Size(aPIDL : PItemIDList) : word;
begin
  Result := LMDShPIDLGetSize(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.ID_Free(aPIDL : PItemIDList);
begin
  LMDDisposePIDL(aPIDL);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_PathToPIDL(const aPath : string; aParentFolder : IShellFolder) : PItemIDList;
begin
  Result := LMDPathToPidl(aPath, aParentFolder);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_ParentFolder(aPIDL : PItemIDList) : IShellFolder;
var
  tmpPIDL : PItemIDList;
begin
  Result := nil;
  tmpPIDL := LMDShPIDLClone(aPIDL);
  LMDShPIDLRemoveLastID(tmpPIDL);
  i_BindToISHellFolder(LMDDesktopFolder, tmpPIDL, Result);
  LMDDisposePIDL(tmpPIDL);
  if Result = nil then Result := LMDDesktopFolder;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_Name(aPIDL : PItemIDList; aParentFolder : IShellFolder; aFlags : DWORD) : string;
var
  StrRet : TStrRet;
begin
  Result := '';

  if  Assigned(aParentFolder) then
    begin

      FillChar(StrRet, SizeOf(StrRet), 0);

      if  Succeeded(aParentFolder.GetDisplayNameOf(aPIDL, aFlags, StrRet))  then
        //Result := String(LMDStrRetToStringEx(aPIDL, StrRet));
        Result := LMDStrRetToStr(aPIDL, StrRet);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_HasAttribute(aPIDL : PItemIDList; aParentFolder : IShellFolder; aFlags : DWORD) : boolean;
var
  Attr  : dword;
  HR    : HRESULT;
begin
  Result := False;
  Attr := aFlags;
  if aPIDL = nil then
    exit;
  HR := aParentFolder.GetAttributesOf(1, aPIDL, Attr);
  if Succeeded(HR) then
    Result := IsElement(aFlags, Attr);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_Data(aPIDL : PItemIDList; aParentFolder : IShellFolder) : TWin32FindData;
var
  HR    : HRESULT;
  SR    : TSearchRec;

begin

  HR := SHGetDataFromIDList(aParentFolder, aPIDL, SHGDFIL_FINDDATA, @Result, SizeOf(TWin32FindData));

  if not Succeeded(HR) then
    if FindFirst(ID_Name(aPIDL, aParentFolder, SHGDN_FORPARSING), faAnyFile, SR) = 0 then
      begin
        FindClose(SR);
        Result := SR.FindData;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_Info(aPIDL : PItemIDList; aFlags : DWORD; aAttr : DWORD) : TSHFileInfo;
//var
//  Attr : DWORD;
begin
  LMDSHGetFileInfo(aPIDL, aFlags, Result, aAttr);
(*
  Attr := SHGFI_PIDL or aFlags;
  Result.dwAttributes := aAttr;
  SHGetFileInfo(PChar(aPIDL), 0, Result, SizeOf(Result), Attr);
*)
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_Equal(aPIDL1, aPIDL2 : PItemIDList) : boolean;
begin
  Result := LMDPIDLIsEqual(aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_Icon(aPIDL : PItemIDList; aOptions : TLMDShGetIconOptions) : TIcon;
var
  SHFileInfo    : TShFileInfo;
  Flags         : dword;
begin
  Result := TIcon.Create;
  Flags := SHGFI_ICON;
  if iSmall in aOptions then Flags := Flags or SHGFI_SMALLICON;
  if iOpen in aOptions then Flags := Flags or SHGFI_OPENICON;

  SHGetFileInfo(PChar(aPIDL), 0, SHFileInfo, SizeOf(TSHFileInfo), Flags);

  Result.Handle := SHFileInfo.hIcon;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ID_Attributes(aPIDL : PItemIDList; aParentFolder : IShellFolder; aFlags : DWORD) : DWORD;
begin
  Result := aFlags;
  aParentFolder.GetAttributesOf(1, aPIDL, Result);
end;

{$HINTS OFF}
{------------------------------------------------------------------------------}
function TLMDShellController.ID_Compare(aPIDL1, aPIDL2 : PItemIDList; aAbsoluteID : PItemIDList) : integer;
var
  ParentFolder  : IShellFolder;
  HR            : HRESULT;
begin
  Result := 0;
  HR := 0;
  if (aPIDL1 = nil) and (aPIDL2 = nil) then Result := 0
  else if (aPIDL1 = nil) or (aPIDL2 = nil) then Result := -1
  else
    begin
      if aAbsoluteID = nil then ParentFolder := LMDDesktopFolder
      else ParentFolder := ID_ParentFolder(aAbsoluteID);
      if ParentFolder <> nil then
        hr := ParentFolder.CompareIDs(0, aPIDL1, aPIDL2);
        if succeeded(hr) then
          Result := Shortint(Word(LongWord(hr) and $FFFF))
        else
          Result := 0;
    end;
  ParentFolder := nil;
end;
{$HINTS ON}

{------------------------------------------------------------------------------}
procedure TLMDShellController.ChDir(aPIDL : PItemIDList);
var
  s:string;
begin
  if FActiveFolder <> nil then FreeAndNil(FActiveFolder);
  FActiveFolder := TLMDShellItem.CreateFromPIDL(aPIDL, Self);

  if not FStopPathLog then
    begin
      ClearPathList(FForwardPathList);
      s:=Format('%s=%s', [FActiveFolder.DisplayName, FActiveFolder.Path]);
      if (FBackwardPathList.Count>0)and
        (FBackwardPathList[FBackwardPathList.Count-1]=s) then
        FBackwardPathList.Delete(FBackwardPathList.Count-1);
      FBackwardPathList.AddObject(s, TObject(LMDShPIDLClone(aPIDL)));
    end;

  if  ObserveChanges  then
    FObserver.WatchPidl := aPIDL;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.ChDir(const aPath : string);
var
  aPIDL : PItemIDList;
  s:string;
begin
  aPIDL := LMDShPIDLClone(FActiveFolder.AbsoluteID);
  s := LMDSlashAdd(aPath);
  if LMDPathToPIDL(s,aPIDL) then
    ChDir(aPidl);
  LMDDisposePIDL(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.LevelUp;
var
  tmpPIDL       : PItemIDList;
  ValidUp       : boolean;
begin
  if FActiveFolder = nil then Exit;
  tmpPIDL := LMDShPIDLClone(FActiveFolder.AbsoluteID);
  ValidUp := LMDShPIDLRemoveLastID(tmpPIDL);
  if ValidUp then ChDir(tmpPIDL);
  LMDDisposePIDL(tmpPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.GoBack(index : integer);
begin
  if (FBackwardPathList.count = 0) or (index >= FBackwardPathList.count) then Exit;
  FStopPathLog := True;
  if index < 0 then index := FBackwardPathList.count-1 + index;
  if index < 0 then index := 0;
  try
    ChDir(PItemIDList(FBackwardPathList.Objects[index]));
  except
    try
      ChDir(FBackwardPathList.Values[FBackwardPathList.Names[index]]);
    except end;
  end;
  while index < FBackwardPathList.count-1 do
  begin
    if (FForwardPathList.count>0)
      and(FForwardPathList[FForwardPathList.count-1]=FBackwardPathList[FBackwardPathList.count-1])
    then
      FForwardPathList.Delete(FForwardPathList.count-1);
    FForwardPathList.AddObject(FBackwardPathList[FBackwardPathList.count-1], TObject(LMDShPIDLClone(PItemIDList(FBackwardPathList.Objects[FBackwardPathList.count-1]))));
    LMDDisposePIDL(PItemIDList(FBackwardPathList.Objects[FBackwardPathList.count-1]));
    FBackwardPathList.Delete(FBackwardPathList.count-1);
  end;
  FStopPathLog := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.GoForward(index : integer);
begin
  if (FForwardPathList.count = 0) or (index >= FForwardPathList.count) then Exit;
  FStopPathLog := True;
  if index < 0 then index := FForwardPathList.count + index;
  if index < 0 then index := 0;
  try
    ChDir(PItemIDList(FForwardPathList.Objects[index]));
  except
    try
      ChDir(FForwardPathList.Values[FForwardPathList.Names[index]]);
    except end;
  end;
  while index <= FForwardPathList.count-1 do
  begin
    FBackwardPathList.AddObject(FForwardPathList[FForwardPathList.count-1], TObject(LMDShPIDLClone(PItemIDList(FForwardPathList.Objects[FForwardPathList.count-1]))));
    LMDDisposePIDL(PItemIDList(FForwardPathList.Objects[FForwardPathList.count-1]));
    FForwardPathList.Delete(FForwardPathList.count-1);
  end;
  FStopPathLog := False;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ExecuteDefault(aItem : TLMDCustomShellItem) : boolean;
var
  Link : TLMDShellLink;
  Cmd : string;
  SHI : TShellExecuteInfo;
begin
  Result := False;

  if  not Assigned(aItem) or (aItem.AbsoluteID = nil) then
    exit;

  Cmd := '';
  if aItem.IsLink then
    begin
      Link := TLMDShellLink.Create(nil);
      Link.Load(aItem.Path);
      if DirectoryExists(Link.Path) then Cmd := Link.Path;
      Link.Free;
    end;

  if Cmd <> '' then ChDir(Cmd)
  else
    begin

      ZeroMemory(@SHI, SizeOf(SHI));
      SHI.cbSize := SizeOf(SHI);

      SHI.fMask := SEE_MASK_INVOKEIDLIST;
      SHI.wnd := Application.Handle;
      SHI.nShow := SW_SHOW;
      SHI.lpIDList := aItem.AbsoluteID;
//      SHI.lpVerb := {Int_Ref(}'open';); 06-Apr-2006, RM

      Result := ShellExecuteEx(@SHI);

      if  (SHI.hProcess <> 0) and (SHI.hProcess <> INVALID_HANDLE_VALUE)  then
        CloseHandle(SHI.hProcess);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.ShowPropertySheet(aItem : TLMDCustomShellItem) : boolean;
var
  tmpPIDL : PItemIDList;
begin
  Result := aItem.HasPropSheet;
  tmpPIDL := aItem.RelativeID;
  if Result then
    LMDShellDoContextMenuVerb(nil, aItem.ParentShellFolderIntf, tmpPIDL, Application.Handle, 'properties');
end;

{------------------------------------------------------------------------------}
function TLMDShellController.CopyToClipboard(aItem : TLMDCustomShellItem): Boolean;
var
  tmpPIDL : PItemIDList;
begin
  tmpPIDL := aItem.RelativeID;
  Result := Assigned(aItem) and aItem.CanCopy
    and LMDShellDoContextMenuVerb(nil, aItem.ParentShellFolderIntf, tmpPIDL,
        Application.Handle, 'copy');
//  if aItem.CanCopy then LMDShellDoContextMenuVerb(nil, aItem.ParentShellFolderIntf, tmpPIDL, 1, Application.Handle, 'copy');
end;

{------------------------------------------------------------------------------}
function TLMDShellController.CutToClipboard(aItem : TLMDCustomShellItem): Boolean;
var
  tmpPIDL : PItemIDList;
begin
  tmpPIDL := aItem.RelativeID;
  Result := Assigned(aItem) and aItem.CanCopy
    and LMDShellDoContextMenuVerb(nil, aItem.ParentShellFolderIntf, tmpPIDL,
      Application.Handle, 'cut');
//  if aItem.CanCopy then LMDShellDoContextMenuVerb(nil, aItem.ParentShellFolderIntf, tmpPIDL, 1, Application.Handle, 'cut');
  if  Result  then
    ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.PasteFromClipboard(aItem : TLMDCustomShellItem): Boolean;
var
  tmpPIDL : PItemIDList;
begin
  tmpPIDL := aItem.RelativeID;
  Result := Assigned(aItem) and aItem.CanPaste
    and  LMDShellDoContextMenuVerb(nil, aItem.ParentShellFolderIntf, tmpPIDL,
      Application.Handle, 'paste');
//  if aItem.CanPaste then LMDShellDoContextMenuVerb(nil, aItem.ParentShellFolderIntf, tmpPIDL, 1, Application.Handle, 'paste');
  if  Result  then
    ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.RenameItem(aItem : TLMDCustomShellItem; const aNewName : string): Boolean;
var

  NewName  : array [0..MAX_PATH - 1] of WideChar;

  NewPIDL  : PItemIDList;
begin
  Result := False;
  if not aItem.CanRename then exit;

  StringToWideChar(aNewName, NewName, MAX_PATH);
  Result := Succeeded(aItem.ParentShellFolderIntf.SetNameOf(Application.Handle,
    aItem.RelativeID, NewName, SHGDN_NORMAL, NewPIDL)) and Assigned(NewPIDL);

  LMDShPIDLFree(NewPIDL);

  if  Result  then
    ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.DeleteItem(aItem : TLMDCustomShellItem): Boolean;
var
  tmpPIDL : PItemIDList;
begin
  tmpPIDL := aItem.RelativeID;
  Result := LMDShellDoContextMenuVerb(nil, aItem.ParentShellFolderIntf, tmpPIDL,
      Application.Handle, 'delete');

  if  Result  then
    ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
function TLMDShellController.NewFolder : string;
var
  i             : integer;
  APath         : string;
  NewPath       : string;

begin
  Result := '';
  if ActiveFolder = nil then Exit;

  APath := ActiveFolder.Path;
  if APath[length(APath)] <> '\' then APath:= APath + '\';

  for i := 1 to 100 do
    begin
      NewPath := APath + 'NewFolder';
      if i > 1 then
        NewPath:= Format('%s (%d)', [NewPath, i]);// + ' ' + IntToStr(i);
      if not DirectoryExists(NewPath) then
        begin
          CreateDir(NewPath);
          break;
        end;
    end;
  Result := NewPath;

  SHChangeNotify(SHCNE_MKDIR, SHCNF_PATH, Int_Ref(NewPath), Int_Ref(NewPath));

end;

{------------------------------------------------------------------------------}
function TLMDShellController.CopyFiles(const aSource, aDestination: String): Boolean;
begin
  Result := LMDShellFileOperation(aSource, aDestination, foCopy, []);
end;

{------------------------------------------------------------------------------}
function TLMDShellController.MoveFiles(const aSource, aDestination: String): Boolean;
begin
  Result := LMDShellFileOperation(aSource, aDestination, foMove, []);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellController.SetObserveChanges(aValue: Boolean);
begin
  if  ObserveChanges <> aValue  then
    begin
      if  aValue  then
        begin
          FObserveChanges := aValue;

          if  not Assigned(FObserver) then
            begin
              FObserver := TLMDShellNotify.Create(nil);
              FObserver.WatchSubFolders := True;
              FObserver.WatchPidl := nil;
              FObserver.OnFileChange := OnFileChange;
              FObserver.OnFileCreate := OnFileCreate;
              FObserver.OnFileDelete := OnFileDelete;
              FObserver.OnFileRename := OnFileRename;
              FObserver.OnFolderChange := OnFolderChange;
              FObserver.OnFolderCreate := OnFolderCreate;
              FObserver.OnFolderDelete := OnFolderDelete;
              FObserver.OnFolderRename := OnFolderRename;
              FObserver.OnDriveAdd := OnDriveAdd;
              FObserver.OnDriveRemove := OnDriveRemove;
              FObserver.OnMediaInsert := OnMediaInsert;
              FObserver.OnMediaRemove := OnMediaRemove;
              FObserver.OnNetShare := OnNetShare;
              FObserver.OnNetUnShare := OnNetUnShare;
            end;

          if  Assigned(FActiveFolder) then
            begin
              FObserver.WatchPidl := FActiveFolder.AbsoluteID;
              FObserver.Active := True;
            end;
        end
      else
        FreeAndNil(FObserver);
    end;
end;

initialization
finalization
  ContextMenu2 := nil;

end.
