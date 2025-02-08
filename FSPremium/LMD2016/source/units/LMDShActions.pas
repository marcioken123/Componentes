unit LMDShActions;
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

LMDShActions unit (DS)
------------------------
Contains RootPath property editor.


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, ActnList, StdActns, Graphics,
  LMDShBase, LMDShFolder, LMDShList, LMDShDlg;

type

  { ************************  TLMDShellAction  ******************************* }
  TLMDShellAction = class(TAction)
  private
    //FAbout: TLMDShellAboutVar;
  published
    //property About : TLMDShellAboutVar read FAbout write FAbout stored false;
  end;

  { ************************  TLMDShellFolderAction  ************************* }
  TLMDShellFolderAction = class(TLMDShellAction)
  private
    FFolder: TLMDShellFolder;
    procedure SetFolder(Value: TLMDShellFolder);
  protected
    function GetFolder(Target: TObject): TLMDShellFolder; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
  published
    property Folder: TLMDShellFolder read FFolder write SetFolder;
  end;

  { **************************  TLMDShellEditAction  ************************* }
  TLMDShellEditAction = class(TLMDShellAction)
  public
    function HandlesTarget(Target: TObject): Boolean; override;
  end;

  { **************************  TLMDShellDlgAction  ************************** }
  TLMDShellDlgAction = class(TLMDShellAction)
  private
    FParent:TLMDShellParentHandle;
  protected
    property OwnerHandle:TLMDShellParentHandle read FParent write FParent default pwNone;
  public
    procedure UpdateTarget(Target: TObject);override;
    function HandlesTarget(Target: TObject): Boolean; override;
  end;

  // Edit related actions
  { *********************** TLMDShellEditShowProperties ********************** }
  TLMDShellEditShowProperties = class(TLMDShellEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

  { ************************** TLMDShellEditCopyFiles ************************ }
  TLMDShellEditCopyFiles = class(TLMDShellEditAction)
  private
    FDestination,
    FDlgCaption,
    FDlgInstructionText:String;
    FParent:TLMDShellParentHandle;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  published
    property OwnerHandle:TLMDShellParentHandle read FParent write FParent default pwNone;
    property DlgCaption: string read FDlgCaption write FDlgCaption;
    property DlgInstructionText:string read FDlgInstructionText write FDlgInstructionText;
  end;

  { ************************** TLMDShellEditMoveFiles ***************************** }
  TLMDShellEditMoveFiles = class(TLMDShellEditAction)
  private
    FDestination,
    FDlgCaption,
    FDlgInstructionText:String;
    FParent:TLMDShellParentHandle;
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  published
    property OwnerHandle:TLMDShellParentHandle read FParent write FParent default pwNone;
    property DlgCaption: string read FDlgCaption write FDlgCaption;
    property DlgInstructionText:string read FDlgInstructionText write FDlgInstructionText;

  end;

  { ************************** TLMDShellEditCut ****************************** }
  TLMDShellEditCut = class(TLMDShellEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

  { ************************** TLMDShellEditCopy ***************************** }
  TLMDShellEditCopy = class(TLMDShellEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

  { ************************** TLMDShellEditPaste **************************** }
  TLMDShellEditPaste = class(TLMDShellEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

  { ************************** TLMDShellEditDelete *************************** }
  TLMDShellEditDelete = class(TLMDShellEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

  TLMDShellEditOpenMode=(eomOpenWidth, eomOpen);

  { ************************** TLMDShellEditOpenWith *************************** }
  TLMDShellEditOpen = class(TLMDShellEditAction)
  private
    FMode:TLMDShellEditOpenMode;
    procedure SetMode(const Value: TLMDShellEditOpenMode);
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  published
    property Mode:TLMDShellEditOpenMode read FMode write SetMode default eomOpenWidth;
  end;

 { ************************** TLMDShellFilterDlg ***************************** }
  TLMDShellFilterDlg=class(TLMDShellDlgAction)
  private
    FCount: Integer;
    FDlgCaption: string;
    FDlgInstructionText: string;
    FShellList: TLMDShellList;
    FHistory: TStringList;
    procedure SetHistoryList(const Value: TStringList);
    procedure SetShellList(const Value: TLMDShellList);
  protected
    function GetList(Target: TObject): TLMDShellList; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
    function HandlesTarget(Target: TObject): Boolean; override;
  published
    property OwnerHandle;
    property DlgCaption: string read FDlgCaption write FDlgCaption;
    property DlgInstructionText:string read FDlgInstructionText write FDlgInstructionText;
    property ShellList: TLMDShellList read FShellList write SetShellList;
    property HistoryList:TStringList read FHistory write SetHistoryList;
    property HistoryCount:Integer read FCount write FCount default 10;
  end;

  { ************************** TLMDShellMailTo ********************************* }
  TLMDShellMailTo = class(TLMDShellDlgAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

 { ************************** TLMDShellEditCopyFileNameAsText ***************** }
  TLMDShellEditCopyFileNameAsText = class(TLMDShellEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

{ ************************** TLMDShellEditCopyPathNameAsText ***************** }
  TLMDShellEditCopyPathNameAsText = class(TLMDShellEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

{ ************************** TLMDShellEditReName ***************************** }
  TLMDShellEditRename = class(TLMDShellEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

{ ************************** TLMDShellEditSelectAll ************************** }
  TLMDShellEditSelectAll = class(TLMDShellEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

{ ************************** TLMDShellEditInvertSelection ******************** }
  TLMDShellEditInvertSelection = class(TLMDShellEditAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

 { ************************** TLMDShellFolderCreateFolder ********************* }
  TLMDShellFolderCreateFolder = class(TLMDShellFolderAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

  // TLMDShellFolder related actions
  { ************************** TLMDShellFolderBackward *********************** }
  TLMDShellFolderBackward = class(TLMDShellFolderAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

{ ************************** TLMDShellFolderForward ************************** }
  TLMDShellFolderForward = class(TLMDShellFolderAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

{ ************************** TLMDShellFolderUpLevel ************************** }
  TLMDShellFolderUpLevel = class(TLMDShellFolderAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject);override;
  end;

  // general Shell related actions

  { ************************** TLMDShellFolderMapDrive ************************* }
  TLMDShellMapDrive = class(TLMDShellDlgAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property OwnerHandle;
  end;

{ ************************** TLMDShellFolderUnMapDrive *********************** }
  TLMDShellUnMapDrive = class(TLMDShellDlgAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property OwnerHandle;
  end;

{ ************************** TLMDShellFindComputer *************************** }
  TLMDShellFindComputer=class(TLMDShellDlgAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property OwnerHandle;
  end;

{ ************************** TLMDShellFolderFind ***************************** }
  TLMDShellFindFiles = class(TLMDShellDlgAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property OwnerHandle;
  end;

{ ************************** TLMDShellFolderFormatDisk *********************** }
  TLMDShellDiskFormat = class(TLMDShellDlgAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property OwnerHandle;
  end;

  { ************************** TLMDShellFolderCopyDisk *********************** }
  TLMDShellDiskCopy = class(TLMDShellDlgAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property OwnerHandle;
  end;

  { ************************** TLMDShellFolderEditDiskLabel ****************** }
  TLMDShellDiskLabelEdit = class(TLMDShellDlgAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property OwnerHandle;
  end;

  { ************************** TLMDShellRun ********************************** }
  TLMDShellRun = class(TLMDShellDlgAction)
  private
    FDlgCaption :String;
    FDlgDescription: String;
    FDlgIcon: TIcon;
    FDlgOptions: TLMDShellRunFileOptions;
    FDlgWorkingPath: TFileName;
    procedure SetIcon(Value: TIcon);
    function StoreIcon: Boolean;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy;override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property DlgCaption: String read FDlgCaption write FDlgCaption;
    property DlgDescription: String read FDlgDescription write FDlgDescription;
    property DlgIcon: TIcon read FDlgIcon write SetIcon stored StoreIcon;
    property DlgOptions: TLMDShellRunFileOptions read FDlgOptions write FDlgOptions default [];
    property DlgWorkingPath: TFileName read FDlgWorkingPath write FDlgWorkingPath;
    property OwnerHandle;
  end;

  { ************************** TLMDShellOpenDosWindow ************************** }
  TLMDShellOpenDosWindow = class(TLMDShellFolderAction)
  public
    constructor Create(aOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

implementation

uses
  Windows, Forms, ShellAPI, Controls, Menus,
  LMDShMisc, LMDShView, LMDShTree, LMDSHLink, LMDShConsts,
  LMDShDriveSelectDlg, LMDShListFilterDlg, LMDProcs;

{ **************************  TLMDShellFolderAction ************************** }
procedure TLMDShellFolderAction.SetFolder(Value: TLMDShellFolder);
begin
  if Value <> FFolder then
    begin
      FFolder:= Value;
      if Value <> nil then Value.FreeNotification(Self);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDShellFolderAction.GetFolder(Target: TObject): TLMDShellFolder;
var
  intf:ILMDShellView;
begin
  if FFolder<>nil then
    result:=FFolder
  else
    begin
      Supports(Target, ILMDShellView, intf);
      Result:=TLMDShellFolder(intf.Controller);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFolderAction.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Folder) then Folder:= nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDShellFolderAction.HandlesTarget(Target: TObject): Boolean;
var
  intf:ILMDShellView;
begin
  // all changes in visible controls connected to
  result:=(FFolder<>nil) or Supports(Target, ILMDShellView, intf);
end;

{ *************************** TLMDShellEditAction **************************** }
{ ---------------------------------------------------------------------------- }
function TLMDShellEditAction.HandlesTarget(Target: TObject): Boolean;
var
  intf:ILMDShellEdit;
begin
  Result:= Supports(Target, ILMDShellEdit, intf) and intf.Editable;
end;

{ **************************** TLMDShellDlgAction **************************** }
function TLMDShellDlgAction.HandlesTarget(Target: TObject): Boolean;
begin
  result:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellDlgAction.UpdateTarget(Target: TObject);
begin
  Enabled:=True;
end;

{ ************************** TLMDShellEditShowProperties ********************* }
constructor TLMDShellEditShowProperties.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_SHOWPROPERTIES;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditShowProperties.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    intf.ShowProperties;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditShowProperties.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled:= Supports(Target, ILMDShellEdit, intf) and intf.CanAccessItem;
end;

{ TLMDShellEditCopyFiles }
{------------------------------------------------------------------------------}
constructor TLMDShellEditCopyFiles.Create(aOwner: TComponent);
begin
  inherited;
  Caption:=IDSHELL_COPYTO;
  Hint:=Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditCopyFiles.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
  LSavedTopWindow: THandle;
begin
  if Supports(Target, ILMDShellEdit, intf) then
  begin
    if Owner is TWinControl then
      LSavedTopWindow := TWinControl(Owner).Handle
    else
      LSavedTopWindow := 0;
    with TLMDShellSysBrowseDialog.Create(owner) do
      try
        OwnerHandle:=self.OwnerHandle;
        Filter:=bfBrowseForDirectories;
        SelectedPath:=FDestination;
        Caption:=FDlgCaption;
        Options:=[];
        if FDlgInstructionText='' then
          InstructionText:=IDSHELL_COPYTOINST
        else
          InstructionText:=FDlgInstructionText;
        if Execute(LSavedTopWindow) then
          begin
            FDestination:=SelectedPath;
            intf.CopyItems(FDestination);
          end
        else
          FDestination:='';
      finally
        Free;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditCopyFiles.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled:=Supports(Target, ILMDShellEdit, intf) and intf.CanCopy;
end;

{ TLMDShellEditMoveFiles }
{------------------------------------------------------------------------------}
constructor TLMDShellEditMoveFiles.Create(aOwner: TComponent);
begin
  inherited;
  Caption:=IDSHELL_MOVETO;
  Hint:=Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditMoveFiles.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    with TLMDShellSysBrowseDialog.Create(owner) do
      try
        OwnerHandle:=self.OwnerHandle;
        Filter:=bfBrowseForDirectories;
        SelectedPath:=FDestination;
        Caption:=FDlgCaption;
        Options:=[];
        if FDlgInstructionText='' then
          InstructionText:=IDSHELL_MOVETOINST
        else
          InstructionText:=FDlgInstructionText;
        if Execute then
          begin
            FDestination:=SelectedPath;
            intf.MoveItems(FDestination);
          end
        else
          FDestination:='';
      finally
        Free;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditMoveFiles.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.CanAccessItem;
end;

{ ************************** TLMDShellEditCut ******************************** }
constructor TLMDShellEditCut.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_CUT;
  Hint:= Caption;
  ShortCut := TextToShortCut('Ctrl+X');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditCut.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    intf.CutToClipboard;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditCut.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.CanCut;
end;

{ ************************** TLMDShellEditCopy ******************************* }
constructor TLMDShellEditCopy.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_COPY;
  Hint:= Caption;
  ShortCut := TextToShortCut('Ctrl+C');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditCopy.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    intf.CopyToClipboard;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditCopy.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.CanCopy;
end;

{ ************************** TLMDShellEditPaste ****************************** }
constructor TLMDShellEditPaste.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_PASTE;
  Hint:= Caption;
  ShortCut := TextToShortCut('Ctrl+V');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditPaste.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    intf.PasteFromClipboard;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditPaste.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.CanPaste;
end;

{ ************************** TLMDShellEditDelete ***************************** }
constructor TLMDShellEditDelete.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_DELETE;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditDelete.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    intf.DeleteItems;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditDelete.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.CanDelete;
end;

{ ************************** TLMDShellEditOpen ******************************* }
constructor TLMDShellEditOpen.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_OPENWITH;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditOpen.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    case FMode of
      eomOpen: intf.Open;
      eomOpenWidth: intf.OpenWith;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditOpen.SetMode(const Value: TLMDShellEditOpenMode);
begin
  if Value<>FMode then
    begin
      FMode := Value;
      if not (csLoading in ComponentState) then
        begin
          if FMode=eomOpen then
            Caption:= IDSHELL_OPEN
          else
            Caption:= IDSHELL_OPENWITH;
          Hint:= Caption;
        end;

    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditOpen.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    case FMode of
      eomOpen: Enabled:=intf.CanAccessItem;
      eomOpenWidth: Enabled:=(Target is TLMDShellList) and intf.CanAccessItem;  // for folders open with makes no sense
    end
  else
    Enabled:=False;
end;

{ ************************** TLMDShellMailTo ********************************* }
constructor TLMDShellMailTo.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_MAILTO;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellMailTo.ExecuteTarget(Target: TObject);
begin
  ShellExecute(Application.Handle, 'open', Int_Ref('mailto:'), '', nil, SW_NORMAL);
end;

{ ************************** TLMDShellEditCopyFileNameAsText ***************** }
constructor TLMDShellEditCopyFileNameAsText.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_COPYFILENAMEASTEXT;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditCopyFileNameAsText.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    if intf.Editable then
      intf.CopyFileNameAsText;
end;

{ ************************** TLMDShellEditCopyPathNameAsText ***************** }
constructor TLMDShellEditCopyPathNameAsText.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_COPYPATHNAMEASTEXT;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditCopyPathNameAsText.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    if intf.Editable then
      intf.CopyPathAsText;
end;

{ ************************** TLMDShellEditReName ***************************** }
constructor TLMDShellEditReName.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_RENAME;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditReName.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    if intf.Editable then
      intf.Rename;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellEditReName.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.CanRename;
end;
{ ************************** TLMDShellEditSelectAll ************************** }
constructor TLMDShellEditSelectAll.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_SELECTALL;
  Hint:= Caption;
  ShortCut := TextToShortCut('Ctrl+A');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditSelectAll.ExecuteTarget(Target: TObject);
var
  i:Integer;
begin
  if Target is TLMDShellList then
    TLMDShellList(Target).SelectAll;
  if Target is TLMDShellTree then
    with TLMDShellTree(Target).Folder do
      begin
        for i:=0 to ViewCount-1 do
          if Views[i] is TLMDShellList then
            begin
              TLMDShellList(Views[i]).SelectAll;
              TLMDShellList(Views[i]).SetFocus;
              exit;
            end;
      end;
end;

{ ************************** TLMDShellEditInvertSelection ******************** }
constructor TLMDShellEditInvertSelection.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_INVERTSELECTION;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellEditInvertSelection.ExecuteTarget(Target: TObject);
var
  i:Integer;
begin
  if Target is TLMDShellList then
    TLMDShellList(Target).InvertSelection;
  if Target is TLMDShellTree then
    with TLMDShellTree(Target).Folder do
      begin
        for i:=0 to ViewCount-1 do
          if Views[i] is TLMDShellList then
            begin
              TLMDShellList(Views[i]).InvertSelection;
              TLMDShellList(Views[i]).SetFocus;
              exit;
            end;
      end;
end;

{ ************************** TLMDShellFolderCreateFolder ********************* }
constructor TLMDShellFolderCreateFolder.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_CREATEFOLDER;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFolderCreateFolder.ExecuteTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  if Supports(Target, ILMDShellEdit, intf) then
    if intf.Editable then
      intf.NewFolder;
//  GetFolder(Target).NewFolder;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFolderCreateFolder.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.Editable;
end;

{ ************************** TLMDShellFolderBackward ************************* }
constructor TLMDShellFolderBackward.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_BACKWARD;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFolderBackward.ExecuteTarget(Target: TObject);
begin
  GetFolder(Target).GoBack;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFolderBackward.UpdateTarget(Target: TObject);
var
  intf:ILMDShellView;
begin
  if Supports(Target, ILMDShellView, intf) then
    if intf.Controller<>nil then
      self.Enabled:=TLMDShellFolder(intf.Controller).BackwardPathList.Count>1
    else
      self.Enabled:=False;
end;

{ ************************** TLMDShellFolderForward ************************** }
constructor TLMDShellFolderForward.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_FORWARD;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFolderForward.ExecuteTarget(Target: TObject);
begin
  GetFolder(Target).GoForward;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFolderForward.UpdateTarget(Target: TObject);
var
  intf:ILMDShellView;
begin
  if Supports(Target, ILMDShellView, intf) then
    if intf.Controller<>nil then
      self.Enabled:=TLMDShellFolder(intf.Controller).ForwardPathList.Count>0
    else
      self.Enabled:=False;
end;

{ ************************** TLMDShellFolderUpLevel ************************** }
constructor TLMDShellFolderUpLevel.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_UPLEVEL;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFolderUpLevel.ExecuteTarget(Target: TObject);
begin
  GetFolder(Target).LevelUp;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFolderUpLevel.UpdateTarget(Target: TObject);
var
  intf:ILMDShellView;
begin
  if Supports(Target, ILMDShellView, intf) then
    if intf.Controller<>nil then
      self.Enabled:=not intf.Controller.ActiveFolder.IsNamespaceRoot
    else
      self.Enabled:=False;
end;

{ ************************** TLMDShellFolderMapDrive ************************* }
constructor TLMDShellMapDrive.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_MAPDRIVE;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellMapDrive.ExecuteTarget(Target: TObject);
begin
  with TLMDShellNetConnectionDialog.Create(Owner) do
    try
      OwnerHandle:=self.OwnerHandle;
      Execute;
    finally
      Free;
    end;
end;

{ ************************** TLMDShellFolderUnMapDrive *********************** }
constructor TLMDShellUnMapDrive.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_UNMAPDRIVE;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellUnMapDrive.ExecuteTarget(Target: TObject);
begin
  with TLMDShellNetConnectionDialog.Create(Owner) do
    try
      OwnerHandle:=self.OwnerHandle;
      DisconnectDrive;
    finally
      Free;
    end;
end;

{ ************************** TLMDShellFindComputer *************************** }
constructor TLMDShellFindComputer.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_FINDCOMPUTER;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFindComputer.ExecuteTarget(Target: TObject);
begin
  with TLMDShellFindDialog.Create(Owner) do
    try
      OwnerHandle:=self.OwnerHandle;
      FindComputer;
    finally
      Free;
    end;
end;

{ ************************** TLMDShellFindFiles ****************************** }
constructor TLMDShellFindFiles.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_FINDFILES;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellFindFiles.ExecuteTarget(Target: TObject);
begin
  with TLMDShellFindDialog.Create(Owner) do
    try
      OwnerHandle:=self.OwnerHandle;
      FindFiles;
    finally
      Free;
    end;
end;

{ ************************** TLMDShellDiskFormat ***************************** }
constructor TLMDShellDiskFormat.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_FORMATDISK;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellDiskFormat.ExecuteTarget(Target: TObject);
begin
  with TLMDShfrmSelectDriveDialog.Create(Owner) do
    try
      case OwnerHandle of
        pwNone: Position:=poScreenCenter;
        pwApplication: Position:=PoMainFormCenter;
        // else: use default value (OwnerFormCenter)
      end;
      lbdisk.Drive:=#0;
      Caption:=IDSHELL_FORMATDISK;
      Instruction.Caption:=IDSHELL_SELECTDISKFORMAT;
      if ShowModal=mrOK then
        with TLMDShellFormatDriveDialog.Create(Owner) do
          try
            OwnerHandle:=self.OwnerHandle;
            DriveToFormat:=UpCase(lbdisk.Drive);
            Execute;
          finally
            Free;
          end;
    finally
      free;
    end;
end;

{ ************************** TLMDDiskFolderCopy ************************* }
constructor TLMDShellDiskCopy.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_COPYDISK;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellDiskCopy.ExecuteTarget(Target: TObject);
begin
  LMDShellCopyDiskDialog;
end;

{ ************************** TLMDShellFolderEditDiskLabel ******************** }
constructor TLMDShellDiskLabelEdit.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_EDITDISKLABEL;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellDiskLabelEdit.ExecuteTarget(Target: TObject);
begin
  with TLMDShfrmSelectDriveDialog.Create(Owner) do
    try
      case OwnerHandle of
        pwNone: Position:=poScreenCenter;
        pwApplication: Position:=PoMainFormCenter;
        // else: use default value (OwnerFormCenter)
      end;
      lbdisk.Drive:=#0;
      Caption:=IDSHELL_EDITDISKLABEL;
      Instruction.Caption:=IDSHELL_SELECTDISKLABEL;
      if ShowModal=mrOK then
        with TLMDShellObjectPropertiesDialog.Create(Owner) do
          try
            OwnerHandle:=self.OwnerHandle;
            ObjectName:=UpCase(lbdisk.Drive)+':\';
            Execute;
          finally
            Free;
          end;
    finally
      free;
    end;
end;

{ ************************** TLMDShellOpenDosWindow ************************** }
constructor TLMDShellOpenDosWindow.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_OPENDOSWINDOW;
  Hint:= Caption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellOpenDosWindow.ExecuteTarget(Target: TObject);
begin
  LMDShellOpenDOSWindow(GetFolder(Target).ActiveFolder.PathName);  
end;

{ ************************** TLMDShellRun ************************************ }
constructor TLMDShellRun.Create(aOwner: TComponent);
begin
  inherited;
  Caption:= IDSHELL_RUN;
  Hint:= Caption;

  FDlgCaption:= '';
  FDlgDescription:= '';
  FDlgWorkingPath:= '';
  FDlgOptions:=[];
  FDlgIcon:= TIcon.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellRun.Destroy;
begin
  FDlgIcon.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellRun.ExecuteTarget(Target: TObject);
begin
  with TLMDShellRunFileDialog.Create(Owner) do
    try
      OwnerHandle:=self.OwnerHandle;
      Caption:=FDlgCaption;
      Description:=FDlgDescription;
      WorkingPath:=FDlgWorkingPath;
      Options:=FDlgOptions;
      Execute;
    finally
      Free;
    end;
end;

{----------------------------- Private ----------------------------------------}
procedure TLMDShellRun.SetIcon(Value: TIcon);
begin
  FDlgIcon.Assign(Value);
end;

{------------------------------------------------------------------------------}
function TLMDShellRun.StoreIcon: Boolean;
begin
  Result:= not FDlgIcon.Empty;
end;

procedure TLMDShellEditCopyPathNameAsText.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.CanAccessItem;
end;

procedure TLMDShellEditCopyFileNameAsText.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.CanAccessItem;
end;

procedure TLMDShellEditSelectAll.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.CanAccessItem;
end;

procedure TLMDShellEditInvertSelection.UpdateTarget(Target: TObject);
var
  intf:ILMDShellEdit;
begin
  Enabled := Supports(Target, ILMDShellEdit, intf) and intf.CanAccessItem;
end;

{ ************************ TLMDShellFilterDlg ******************************** }
{ ----------------------------- private -------------------------------------- }
procedure TLMDShellFilterDlg.SetHistoryList(const Value: TStringList);
begin
  FHistory.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFilterDlg.SetShellList(const Value: TLMDShellList);
begin
  if Value <> FShellList then
    begin
      FShellList:= Value;
      if Value <> nil then Value.FreeNotification(Self);
    end;
end;

{ --------------------------- protected -------------------------------------- }
function TLMDShellFilterDlg.GetList(Target: TObject): TLMDShellList;
begin
  if FShellList<>nil then
    result:=FShellList
  else
    result:=Target as TLMDShellList;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFilterDlg.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FShellList) then ShellList:= nil;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDShellFilterDlg.Create(aOwner: TComponent);
begin
  inherited;
  Caption:=IDSHELL_FILTER;
  FCount:=10;
  FHistory:=TStringList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellFilterDlg.Destroy;
begin
  FreeAndNil(FHistory);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFilterDlg.ExecuteTarget(Target: TObject);
begin
  with TLMDShellListFilterDialog.Create(Owner) do
    try
      OwnerHandle:=self.OwnerHandle;
      Caption:=FDlgCaption;
      InstructionText:=FDlgInstructionText;
      ShellList:=FShellList;
      HistoryList:=FHistory;
      HistoryCount:=FCount;
      ShellList:=GetList(Target);
      if Execute then
        FHistory.Assign(HistoryList);
     finally
       Free;
     end;
end;

{------------------------------------------------------------------------------}
function TLMDShellFilterDlg.HandlesTarget(Target: TObject): Boolean;
begin
  result:=(FShellList<>nil) or (Target is TLMDShellList);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFilterDlg.UpdateTarget(Target: TObject);
begin
  Enabled:=GetList(Target)<>nil;
end;

end.
