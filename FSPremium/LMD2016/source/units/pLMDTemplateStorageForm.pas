unit pLMDTemplateStorageForm;
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

pLMDTemplateStorageForm unit (VO)
---------------------


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShellAPI, ShlObj, Registry, 
  ComCtrls, ExtCtrls, StdCtrls, TypInfo, Buttons, LMDStorTemplateStorage,  
  LMDTypes, pLMDCst;

const
  IS_KEY = LMDTOOLS_REGISTRYPATH + '\Shared\IDEStorage';
  IS_DIR_VALUE = 'Directory';
  IS_FILE_NAME = 'storage.key';

type
  {------------------- Helper classes -----------------------------------------}
  TLMDExWriter = class(TWriter);
  TLMDExReader = class(TReader);

  {-------------------  Class TLMDIDEStorageItem ------------------------------}
  TLMDIDEStorageItem = class(TCollectionItem)
  private
    FClassName: string;
    FName: string;
    FFileName: string;
    procedure SetClassName(const Value: string);
    procedure SetFileName(const Value: string);
    procedure SetName(const Value: string);
  published
    property Name: string read FName write SetName;
    property StoredClassName: string read FClassName write SetClassName;
    property FileName: string read FFileName write SetFileName;
  end;

  {-------------------  Class TLMDIDEStorageItems -----------------------------}
  TLMDIDEStorageItems = class(TCollection)
  private
    function GetItem(Index: Integer): TLMDIDEStorageItem;
  public
    constructor Create;
    destructor Destroy; override;
    function Add: TLMDIDEStorageItem;
    property Items[Index: Integer]: TLMDIDEStorageItem read GetItem; default;
  end;

  {-------------------  Class TLMDTemplateStorageForm -------------------------}
  TLMDTemplateStorageForm = class(TForm)
    Panel1: TPanel;
    OkBtn: TButton;
    CancelBtn: TButton;
    ComponentsTree: TTreeView;
    Panel3: TPanel;
    Label1: TLabel;
    StoragePathEdit: TEdit;
    Label2: TLabel;
    TLCombo: TComboBox;
    AddBtn: TButton;
    LoadBtn: TButton;
    BrowseFolderBtn: TButton;
    Splitter1: TSplitter;
    DeleteButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComponentsTreeChange(Sender: TObject; Node: TTreeNode);
    procedure AddBtnClick(Sender: TObject);
    procedure TLComboChange(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure BrowseFolderBtnClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SC: TLMDStorTemplateStorage;
    StoredItems: TLMDIDEStorageItems;
    procedure SaveObject(aObj: TObject; szFileName: string);
    procedure LoadObject(aObj: TObject; szFileName: string);
    function GetSelectedObject: TObject;
    procedure UpdatePropertiesTree;
    procedure UpdateStoredItems(aObject: TObject);
    procedure LoadStoredItems;
    procedure SaveStoredItems;
    procedure Apply;
    procedure UpdateBtn;
  end;

implementation

uses
  FileCtrl

;

var
  Reg: TRegistry;
  StoragePath: string;

{$R *.DFM}

{********************* TLMDBarAboutProperty ***********************************}
{------------------------- Private --------------------------------------------}
procedure TLMDIDEStorageItem.SetClassName(const Value: string);
begin
  FClassName := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDIDEStorageItem.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDIDEStorageItem.SetName(const Value: string);
begin
  FName := Value;
end;

{********************* TLMDIDEStorageItems ************************************}
{------------------------- Private --------------------------------------------}
function TLMDIDEStorageItems.GetItem(Index: Integer): TLMDIDEStorageItem;
begin
  Result := TLMDIDEStorageItem(inherited Items[Index]);
end;

{------------------------- Public --------------------------------------------}
constructor TLMDIDEStorageItems.Create;
begin
  inherited Create(TLMDIDEStorageItem);
end;

{------------------------------------------------------------------------------}
destructor TLMDIDEStorageItems.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDIDEStorageItems.Add: TLMDIDEStorageItem;
begin
  Result := TLMDIDEStorageItem(inherited Add);
end;

{********************* TLMDTemplateStorageForm ********************************}
{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.FormShow(Sender: TObject);
begin
  StoragePathEdit.Text := StoragePath;
  UpdatePropertiesTree;
  UpdateBtn;
  LoadStoredItems;
  UpdateStoredItems(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.OkBtnClick(Sender: TObject);
begin
  Apply;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.FormCreate(Sender: TObject);
begin
  StoredItems := TLMDIDEStorageItems.Create;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.FormDestroy(Sender: TObject);
begin
  StoredItems.Free;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.ComponentsTreeChange(Sender: TObject;
  Node: TTreeNode);
begin
  UpdateStoredItems(GetSelectedObject);
  UpdateBtn;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.AddBtnClick(Sender: TObject);
var
  aObj: TObject;
  szTmp: string;
begin
  aObj := GetSelectedObject;
  if aObj <> nil then
    begin
      szTmp := InputBox('Add template for ' + aObj.ClassName,
       'Input tempate name', '');
      if szTmp <> '' then
        begin
          with StoredItems.Add do
            begin
              Name := szTmp;
              FClassName := aObj.ClassName;

              FFileName := aObj.ClassName + IntToHex(GetTickCount, 8) + '.tml';
              SaveObject(aObj, StoragePathEdit.text + '\' + FFileName);
            end;
          SaveStoredItems;
          UpdateStoredItems(aObj);
        end;
    end;
  UpdateBtn;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.TLComboChange(Sender: TObject);
begin
  UpdateBtn;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.LoadBtnClick(Sender: TObject);
var
  aObj: TObject;
  szTmp: string;
begin
  aObj := GetSelectedObject;
  if aObj <> nil then
    begin
      szTmp := TLMDIDEStorageItem(TLCombo.Items.Objects[TLCombo.ItemIndex]).
       FFileName;
      LoadObject(aObj, StoragePathEdit.Text + '\' + szTmp);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.BrowseFolderBtnClick(Sender: TObject);
var
  TitleName: string;

  DisplayName: array[0..MAX_PATH] of char;
  TempPath: array[0..MAX_PATH] of char;
  lpItemID: PItemIDList;

  BrowseInfo: TBrowseInfo;
begin

  FillChar(BrowseInfo, sizeof(TBrowseInfo), $0);
  BrowseInfo.pszDisplayName := @DisplayName;
  BrowseInfo.lpszTitle := PChar(TitleName);

      BrowseInfo.hwndOwner := Handle;

      TitleName := 'Please specify a directory';
      BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
      lpItemID := SHBrowseForFolder(BrowseInfo);
      if lpItemId <> nil then
        begin
        try
            SHGetPathFromIDList(lpItemID, TempPath);
          StoragePathEdit.Text := TempPath;
            GlobalFreePtr(lpItemID);
          finally
        end;
        end;
  UpdatePropertiesTree;
    UpdateBtn;
    LoadStoredItems;
    UpdateStoredItems(GetSelectedObject);
    UpdateBtn;

end;

{------------------------- Public ---------------------------------------------}
procedure TLMDTemplateStorageForm.SaveObject(aObj: TObject; szFileName: string);
var
  FS: TFileStream;
  WR: TWriter;
begin
  if aObj is TPersistent then
    begin
      try
        FS := TFileStream.Create(szFileName, fmCreate);
        WR := TWriter.Create(FS, 4096);
        try
          TLMDExWriter(WR).WriteProperties(aObj as TPersistent);
          finally
          WR.Free;
          FS.Free;
        end;
      except
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.LoadObject(aObj: TObject; szFileName: string);
var
  FS: TFileStream;
  RD: TReader;
begin
  if aObj is TPersistent then
    begin
      try
        FS := TFileStream.Create(szFileName, fmOpenRead);
        RD := TReader.Create(FS, 4096);
        try
          while not TLMDExReader(RD).EndOfList do
          TLMDExReader(RD).ReadProperty(aObj as TPersistent);
          finally
          RD.Free;
          FS.Free;
        end;
      except
      end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDTemplateStorageForm.GetSelectedObject: TObject;
var
  aObj: TObject;
  aCmp: TObject;
begin
  Result := nil;
  if (ComponentsTree.Selected <> nil) then
    if ComponentsTree.Selected.Level = 0 then
      begin
        if SC.Owner.Name = ComponentsTree.Selected.Text then
          Result := SC.Owner
        else
          Result := SC.Owner.FindComponent(ComponentsTree.Selected.Text);
      end
    else
      begin
        aCmp := SC.Owner.FindComponent(ComponentsTree.Selected.Parent.Text);
        if TComponent(aCmp) = nil then
          aCmp := SC.Owner;
        aObj := GetObjectProp(aCmp, ComponentsTree.Selected.Text);
        result:=aObj;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.UpdatePropertiesTree;
var
  i: Integer;
  szComp, szProp: string;

  procedure AddProperties(aObject: TComponent);
  var
    CN: TTreeNode;
    PN: TTreeNode;
    I, Count: Integer;
  PropInfo: PPropInfo;
    PropList: PPropList;
  begin
    CN := ComponentsTree.Items.Add(nil, aObject.Name);
    Count := GetTypeData(aObject.ClassInfo).PropCount;
    if Count > 0 then
      begin
        GetMem(PropList, Count * SizeOf(Pointer));
        try
          GetPropInfos(aObject.ClassInfo,PropList);
          for I := 0 to Count - 1 do
            begin
              PropInfo := PropList[I];
              if PropInfo = nil then break;
              if {IsStoredProp(aObject,PropInfo) and }
          (PropInfo.PropType^.Kind = tkClass)
          and(GetOrdProp(aObject, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name)) <> 0) then
                begin
                  PN := ComponentsTree.Items.AddChild(CN, {$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name));
                  if (aObject.Name = szComp) and ({$IFDEF LMDCOMP12}String{$ENDIF}(PropInfo.Name) = szProp) then
                    begin
                      PN.Selected := True;
                      PN.Focused := True;
                    end;
                end;
            end;
        finally
        FreeMem(PropList, Count * SizeOf(Pointer));
        end;
      end;

  end;

begin
  szComp := '';
  szProp := '';
  if (ComponentsTree.Selected <> nil) and
   (ComponentsTree.Selected.Level = 1) then
    begin
      szProp := ComponentsTree.Selected.Text;
      szComp := ComponentsTree.Selected.Parent.Text;
    end;
  ComponentsTree.Items.BeginUpdate;
  ComponentsTree.Items.Clear;
  try
    AddProperties(SC.Owner);
    for i := 0 to SC.Owner.ComponentCount - 1 do
      begin
        if (SC.Owner.Components[i] <> SC) and
         (SC.Owner.Components[i].Name <> '') then
           AddProperties(SC.Owner.Components[i]);
      end;
  except
  end;
  ComponentsTree.Items.EndUpdate;
  if (ComponentsTree.Selected <> nil) then
    ComponentsTree.Selected.MakeVisible;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.UpdateStoredItems;
var
  i: Integer;
  aClass: TClass;
  b: Boolean;
begin
  TLCombo.Items.Clear;
  if aObject = nil then exit;
  for i := 0 to StoredItems.Count - 1 do
    begin
      b := False;
      aClass := aObject.ClassType;
      while (aClass <> nil) and (not b) do
        begin
          b := aClass.ClassNameIs(StoredItems[i].StoredClassName);
          aClass := aClass.ClassParent;
        end;
      if not b then
        continue;
      TLCombo.Items.AddObject(StoredItems[i].FName, StoredItems[i]);
    end;
  if TLCombo.Items.Count > 0 then
    TLCombo.ItemIndex := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.LoadStoredItems;
var
  FS: TFileStream;
  RD: TReader;
begin
  StoredItems.Clear;
  try
    FS := TFileStream.Create(StoragePathEdit.Text + '\' + IS_FILE_NAME,
     fmOpenRead or fmShareDenyWrite);
    RD := TReader.Create(FS, 4096);
    try
      RD.ReadValue;
      RD.ReadCollection(StoredItems);
    finally
      RD.Free;
      FS.Free;
    end;
  except
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.SaveStoredItems;
var
  FS: TFileStream;
  WR: TWriter;
begin
  try
    FS := TFileStream.Create(StoragePathEdit.Text + '\' + IS_FILE_NAME,
     fmCreate);
    WR := TWriter.Create(FS, 4096);
    try
      WR.WriteCollection(StoredItems);
    finally
      WR.Free;
      FS.Free;
    end;
  except
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.Apply;
begin
  StoragePath := StoragePathEdit.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDTemplateStorageForm.UpdateBtn;
begin
  AddBtn.Enabled := (ComponentsTree.Selected <> nil) and
   (GetSelectedObject <> nil);
  LoadBtn.Enabled := TLCombo.ItemIndex >= 0;
  DeleteButton.Enabled := TLCombo.ItemIndex >= 0;
end;

procedure TLMDTemplateStorageForm.DeleteButtonClick(Sender: TObject);
var
  aObj: TObject;
  i: integer;
begin
  if MessageDlg('Delete this template?', mtWarning, mbYesNoCancel, 0) <> mrYes then exit;
  aObj := GetSelectedObject;
  if aObj <> nil then
    begin
      for i := 0 to StoredItems.Count - 1 do
       if StoredItems[i].FName = TLCombo.Text then
      begin
        DeleteFile(StoragePathEdit.text + '\' + StoredItems[i].FFileName);
        StoredItems[i].Free;
        break;
      end;
      SaveStoredItems;
      UpdateStoredItems(aObj);
    end;
  UpdateBtn;
end;

initialization
  Reg := TRegistry.Create;
  if Reg.OpenKey(IS_KEY, False) then
    begin
      StoragePath := Reg.ReadString(IS_DIR_VALUE);
    end;
  Reg.Free;
  if not DirectoryExists(StoragePath) then
    begin
      StoragePath := ExtractFilePath(Application.ExeName) + 'LMDTemplates';
      CreateDir(StoragePath);
    end;

finalization
  Reg := TRegistry.Create;
  if Reg.OpenKey(IS_KEY, True) then
    begin
      Reg.WriteString(IS_DIR_VALUE, StoragePath);
    end;
  Reg.Free;

end.

