unit LMDShCombo;
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

LMDShCombo unit (DS)
--------------------
Contains ComboBox

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, ShlObj, StdCtrls, ComCtrls,
  LMDShFolder, LMDShView, LMDShBase, intfLMDBase, LMDTypes;

type

  {****************************************************************************}
  TLMDShellComboItem = class(TComboExItem)
  private
    FShellItem  : TLMDCustomShellItem;
    procedure SetShellItem(const aValue : TLMDCustomShellItem);
  public
    { constructor / destructor }
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    { properties }
    property ShellItem : TLMDCustomShellItem
        read FShellItem
        write SetShellItem;

  end;

  {****************************************************************************}
  TLMDShellComboStrings = class(TComboBoxExStrings)
  protected
//    function GetItemsClass: TComboExItemsClass; override;
    function GetItemClass: TComboExItemClass; override;
  end;

  {****************************************************************************}
  TLMDShellComboBox = class(TCustomComboBoxEx, IUnknown, 
                            ILMDShellView, ILMDComponent)
  private
    { property variables }
    FAbout              : TLMDAboutVar;
    FShellFolder        : TLMDShellFolder;
    FDroppedWidth       : LongInt;

    { Events }
    FOnItemSelected     : TLMDShellItemEvent;

    { internal variables }
    FLoadItem           : integer;
    FShellItems         : TLMDShellItemsList;
    FItemsCache         : TLMDShellItemsList;
    FActiveLocked       : boolean;
    FChangeLocked       : boolean;

    { property methods }
    procedure SetShellFolder(const aValue: TLMDShellFolder);
    function GetDroppedWidth: LongInt;
    procedure SetDroppedWidth(Value: LongInt);

    { internal methods }
    procedure RepaintEx;
    procedure ClearItems;
    procedure LoadRootItems;
    procedure EnumItems(aIndex : integer);

    //  ILMDShellView
    procedure DoFileChange(aPIDL : PItemIDList);
    procedure DoFileCreate(aPIDL : PItemIDList);
    procedure DoFileDelete(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure DoFileRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure DoFolderChange(aPIDL : PItemIDList);
    procedure DoFolderCreate(aPIDL : PItemIDList);
    procedure DoFolderDelete(aPIDL : PItemIDList);
    procedure DoFolderRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure BeginEnumeration;
    procedure EndEnumeration;
    function TerminateEnumeration : boolean;
    procedure ILMDShellView.AddItem = EnumAddItem;
    procedure EnumAddItem(aItem : TLMDCustomShellItem);
    procedure ActiveFolderChanged;
    function  Controller:TLMDCustomShellController;
  protected
    { base class methods }
    function GetItemsClass: TCustomComboBoxStringsClass; override;
    procedure CreateWnd; override;
    procedure CreateHandle; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Select; override;

  public
    { constructor / destructor }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;
  published
    { properties }
    property About : TLMDAboutVar read FAbout write FAbout stored false;
    property Folder : TLMDShellFolder read FShellFolder write SetShellFolder;
    property DroppedWidth : LongInt read GetDroppedWidth write SetDroppedWidth default 0;

    property Style;
    property StyleEx;
    property Action;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnBeginEdit;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndEdit;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
    property DropDownCount;

    property OnItemSelected : TLMDShellItemEvent read FOnItemSelected write FOnItemSelected;
  end;

implementation
uses
  Windows, ImgList, Graphics, Messages, Forms, Controls, CommCtrl,
  LMDUtils, LMDProcs;

type
{$HINTS OFF}

  {****************************************************************************}
  TCustomComboHack = class(TCustomListControl)
  private
    FCanvas: TCanvas;
    FMaxLength: Integer;
    FDropDownCount: Integer;
    FItemIndex: Integer;
    FOnChange: TNotifyEvent;
    FOnSelect: TNotifyEvent;
    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TNotifyEvent;
    FItemHeight: Integer;
    FItems: TStrings;
  end;

  {****************************************************************************}
  TCustomComboBoxExHack = class(TCustomCombo)
  private
    {$IFDEF LMDCOMP7}
    FAutoCompleteIntf: IAutoComplete;
    FAutoCompleteOptions: TAutoCompleteOptions;
    {$ENDIF}
    FComboBoxExHandle: HWND;
    FComboBoxExDefProc: Pointer;
    FComboBoxExInstance: Pointer;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FMemStream: TCollection;
    FReading: Boolean;
    FStyle: TComboBoxExStyle;
    FStyleEx: TComboBoxExStyles;
    FItemsEx: TComboExItems;
  end;

  {****************************************************************************}
  TComboBoxExStringsHack = class(TCustomComboBoxStrings)
  private
    FItems: TComboExItems;
  protected
    property ComboBox;
  end;

{** TLMDShellComboItem ********************************************************}
{-- private -------------------------------------------------------------------}
procedure TLMDShellComboItem.SetShellItem(const aValue : TLMDCustomShellItem);
begin
  inherited;
  if FShellItem = aValue then Exit;
  FShellItem := aValue;
  Caption := FShellItem.DisplayName;
  ImageIndex := FShellItem.IconIndex;
  SelectedImageIndex:= ImageIndex;
  Indent:= FShellItem.Level;
  OverlayImageIndex := FShellItem.OverlayIconIndex;
end;

{-- protected -----------------------------------------------------------------}
{-- private -------------------------------------------------------------------}
constructor TLMDShellComboItem.Create(Collection: TCollection);
begin
  inherited;
  FShellItem := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellComboItem.Destroy;
begin
  if FShellItem <> nil then
    FShellItem.Free;
  inherited;
end;

{** TLMDShellComboStrings *****************************************************}
{-- private -------------------------------------------------------------------}
{-- protected -----------------------------------------------------------------}
{-- private -------------------------------------------------------------------}
function TLMDShellComboStrings.GetItemClass: TComboExItemClass;
begin
  result := TLMDShellComboItem;
end;
{
function TLMDShellComboStrings.GetItemsClass: TComboExItemsClass;
begin
  Result := TLMDShellComboStrings;
end;
}
{** TLMDShellComboBox *********************************************************}
{-- private -------------------------------------------------------------------}
procedure TLMDShellComboBox.SetShellFolder(const aValue: TLMDShellFolder);
begin
  if FShellFolder = aValue then Exit;
  if FShellFolder <> nil then FShellFolder.UnRegisterView(Self);
  ClearItems;
  FShellFolder := aValue;

  if FShellFolder <> nil then
    begin
      FShellFolder.RegisterView(Self);
      if HandleAllocated then
        begin
          PostMessage(Handle, CBEM_SETIMAGELIST, 0, FShellFolder.SmallFolderImages.Handle);
          ActiveFolderChanged;
        end;
    end
  else
    Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDShellComboBox.GetDroppedWidth: LongInt;
begin
  result := FDroppedWidth;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.SetDroppedWidth(Value: LongInt);
begin
  if Value < 0 then Value:= 0;
  FDroppedWidth:= Value;
  if HandleAllocated then Perform(CB_SETDROPPEDWIDTH, Value, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.RepaintEx;
var
  R : TRect;
begin
  R := ClientRect;

  LMDInvalidateRect(Handle, R, False);
  Update;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.ClearItems;
begin
  while ItemsEx.Count > 0 do
    begin
      SendMessage(Handle, CB_DELETESTRING, 0, 0);
      ItemsEx.Delete(0);
    end;
  Items.Clear;
  FShellItems.Clear;
  Text := '';
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.LoadRootItems;
var
  i             : integer;
  ShellItem     : TLMDCustomShellItem;
begin
  ItemIndex := -1;
  ClearItems;

  ShellItem := FShellFolder.CreateShellItem(FShellFolder.NamespaceRootID);
  ShellItem.Level := 0;
  FShellItems.Add(ShellItem);

  EnumItems(0);

  for i := 0 to FShellItems.count-1 do
    if FShellFolder.ID_Equal(FShellItems[i].AbsoluteID, FShellFolder.ComboExtID) then
      begin
        EnumItems(i);
        Break;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.EnumItems(aIndex : integer);
begin
  FLoadItem := aIndex;
  if (FShellFolder = nil) then Exit;

  Screen.Cursor := crHourGlass;
  try
    FShellFolder.Enumerate(FShellItems[aIndex].AbsoluteID, Self, [eoFolders]);
  finally
    Screen.Cursor := crDefault;
  end;

end;

{-- protected -----------------------------------------------------------------}
function TLMDShellComboBox.GetItemsClass: TCustomComboBoxStringsClass;
begin
  result := TLMDShellComboStrings;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.CreateWnd;
begin
  inherited;
  if FShellFolder <> nil then
    begin
      PostMessage(Handle, CBEM_SETIMAGELIST, 0, FShellFolder.SmallFolderImages.Handle);
      ActiveFolderChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.CreateHandle;
begin
  inherited;
  Perform(CB_SETDROPPEDWIDTH, FDroppedWidth, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if AComponent = FShellFolder then
    if Operation = opRemove then Folder := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    FShellFolder.ChDir(Text+'\');
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.Select;
begin
  inherited;
  if FChangeLocked then Exit;
  if ItemIndex <> -1 then
    if assigned(FOnItemSelected) then
      FOnItemSelected(Self, TLMDShellComboItem(ItemsEx[ItemIndex]).ShellItem);
      FActiveLocked := True;
  FShellFolder.ChDir(TLMDShellComboItem(ItemsEx[ItemIndex]).ShellItem.AbsoluteID);
  FActiveLocked := False;
end;

{-- private -------------------------------------------------------------------}
constructor TLMDShellComboBox.Create(AOwner: TComponent);
var
  LTemp: TObject;
begin
  inherited;

  Items.Free;
  // Doesn't works in Delphi 2009
  //  TCustomComboHack(Self).FItems.Free;
  TCustomComboHack(Self).FItems:= TLMDShellComboStrings.Create(Self);
  TCustomComboBoxExHack(Self).FItemsEx := TComboBoxExStringsHack(Items).FItems;
  TComboBoxExStringsHack(Items).ComboBox := Self;

  Style := csExDropDown;
  FDroppedWidth:= 0;
  FShellItems := TLMDShellItemsList.Create;
  FItemsCache := TLMDShellItemsList.Create;
  FActiveLocked := False;
  FChangeLocked := False;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellComboBox.Destroy;
begin
  FShellItems.Free;
  FItemsCache.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.BeginEnumeration;
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.EndEnumeration;
var
  i : integer;
begin
  FItemsCache.SortByRelativeID;
  if FItemsCache.count > 0 then
    for i := FItemsCache.count-1 downto 0 do
      begin
        FItemsCache[i].Level := FShellItems[FLoadItem].Level+1;
        FShellItems.Insert(FLoadItem+1, FItemsCache[i]);
      end;
  FItemsCache.Clear;
end;
{------------------------------------------------------------------------------}
function TLMDShellComboBox.TerminateEnumeration : boolean;
begin
  result := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.EnumAddItem(aItem : TLMDCustomShellItem);
begin
  FItemsCache.Add(aItem);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.ActiveFolderChanged;
var
  i, j, k, l    : integer;
  Flag          : boolean;
  PIDLS         : TList;
  tmpPIDL       : PItemIDList;
  item          : TLMDCustomShellItem;
begin
  if FShellFolder.ActiveFolder = nil then Exit;

  if FActiveLocked or FChangeLocked then Exit;

  if not HandleAllocated  then  exit;

  PIDLS := nil;
  Items.BeginUpdate;
  FChangeLocked := True;
  try
    LoadRootItems;

    PIDLS := TList.Create;

    PIDLS.Add(FShellFolder.ID_Clone(FShellFolder.ActiveFolder.AbsoluteID));
    while True do
      begin
        tmpPIDL := FShellFolder.ID_Clone(PItemIDList(PIDLS[0]));
        if FShellFolder.ID_RemoveLastID(tmpPIDL) then PIDLS.Insert(0, tmpPIDL)
        else
          begin
            FShellFolder.ID_Free(tmpPIDL);
            Break;
          end;
      end;

    k := -1;
    for i := 0 to PIDLS.count-1 do
      begin
        Flag := False;
        for j := 0 to FShellItems.count-1 do
          if FShellFolder.ID_Equal(PItemIDList(PIDLS[i]), FShellItems[j].AbsoluteID) then
            begin
              Flag := True;
              k := j;
              Break;
            end;
        if not Flag then Break;
      end;

    if k <> -1 then
      begin
        l := FShellItems[k].Level+1;
        k := k + 1;
      end
    else
      begin
        l := 0;
        k := FShellItems.count;
      end;

    for j := i to PIDLS.count-1 do
      begin
        Item := FShellFolder.CreateShellItem(PItemIDList(PIDLS[j]));
        Item.Level := l;
        inc(l);
        FShellItems.Insert(k, Item);
        inc(k);
      end;

    ItemsEx.BeginUpdate;
    for i := 0 to FShellItems.count-1 do
      with TLMDShellComboItem(ItemsEx.Add) do
        ShellItem := FShellItems[i];
      ItemsEx.EndUpdate;

    ItemIndex := k-1;

    if assigned(FOnItemSelected) then
      FOnItemSelected(Self, FShellItems[ItemIndex]);

  finally
    if  Assigned(PIDLS) then
      for i := 0 to PIDLS.count-1 do
        FShellFolder.ID_Free(PItemIDList(PIDLS[i]));
      PIDLS.Free;
    // For Delphi.Net ShellItems stored in FShellItems instead of subclassing
    // TComboBoxItemEx
    FShellItems.Clear;
    Items.EndUpdate;
    FChangeLocked := False;
  end;
  RepaintEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.DoFileChange(aPIDL : PItemIDList);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.DoFileCreate(aPIDL : PItemIDList);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.DoFileDelete(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.DoFileRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.DoFolderChange(aPIDL : PItemIDList);
begin
//  ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.DoFolderCreate(aPIDL : PItemIDList);
begin
//  ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.DoFolderDelete(aPIDL : PItemIDList);
begin
//  ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.DoFolderRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
begin
  ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
function TLMDShellComboBox.Controller: TLMDCustomShellController;
begin
  result:=FShellFolder;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.BeginUpdate;
begin
  Items.BeginUpdate;
  ItemsEx.BeginUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellComboBox.EndUpdate;
var
  i: integer;
begin
  ItemsEx.EndUpdate;
  Items.EndUpdate;
  Application.ProcessMessages;
  //  fix bug during refresh process
  i := ItemIndex;
  ItemIndex := -1;
  ItemIndex := i;
end;

{------------------------------------------------------------------------------}
function TLMDShellComboBox.getLMDPackage: TLMDPackageID;
begin
    result:=pi_LMD_SHELL;
end;

end.
