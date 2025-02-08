unit pLMDStyleManProp;
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

LMD StyleMan Editor unit - Core Library (VB)
--------------------------------------------
Description

ToDo
----
* Clean up .net port

Release 8.0 (July 2006)

* Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Variants, Messages, SysUtils, Graphics, Controls, Forms, Dialogs,
  DesignIntf, DesignEditors, DesignWindows, DsnConst,
  Typinfo, ExtCtrls, StdCtrls, ComCtrls, ImgList, Buttons,
  pLMDCst, LMDCFCStateObject, LMDList, LMDCustomControl,  LMDCustomPanel,
  LMDCustomBevelPanel,  LMDCustomParentPanel,  LMDCustomPanelFill,
  LMDCustomGroupBox, LMDCustomButtonGroup,
  LMDCustomRadioGroup, LMDRadioGroup, LMDCustomComponent, LMDBaseController,
  LMDContainerComponent, LMDBaseDialog, LMDInputDlg, LMDBaseEdit,
  LMDCustomEdit, LMDBaseGraphicButton,
  LMDCustomSpeedButton, LMDSpeedButton, LMDSimplePanel, LMDHeader,
  LMDCustomHeaderPanel, LMDHeaderPanel, LMDCustomComboBox,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, LMDCustomContainer,
  LMDCustomImageList, LMDBitmapList, LMDBackPanel, LMDCustomButton,
  LMDButton, LMDListComboBox, LMDColorComboBox, LMDCustomColorComboBox,
  LMDEdit, LMDSpinEdit, LMDCustomMaskEdit, LMDExtSpinEdit, LMDCalendarComboBox,
  LMDCheckListComboBox, LMDCustomCheckListDlg, LMDCheckListDlg,
  LMDBaseGraphicControl, LMDBaseControl, LMDControl, LMDClass,
  LMDStyleMan;

type
  TLMDPropListItem = class;
  TLMDPropViewGrouping = (pvgTypeName,pvgClassName);

  TfrmLMDStyleManProp = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ImageList1: TImageList;
    LMDInputDlg1: TLMDInputDlg;
    PropTreePanel: TPanel;
    PropTree: TTreeView;
    PropView: TListView;
    Splitter3: TSplitter;
    Label1: TLabel;
    PVGrouping: TLMDRadioGroup;
    TopPanel: TPanel;
    bttLoadFromFile: TLMDSpeedButton;
    btnSaveToFile: TLMDSpeedButton;
    btnAddStyle: TLMDSpeedButton;
    Splitter4: TSplitter;
    StylesPanel: TPanel;
    Styles: TTreeView;
    HeaderControl: THeaderControl;
    Splitter1: TSplitter;
    PreviewToolPanel: TPanel;
    Label2: TLabel;
    cbCtlXp: TLMDCheckBox;
    Bevel1: TBevel;
    cbAlign: TLMDCheckBox;
    LMDBitmapList1: TLMDBitmapList;
    btnDeleteStyle: TLMDSpeedButton;
    Panel1: TPanel;
    Bevel2: TBevel;
    cbStateStyles: TLMDCheckBox;
    cbConfirmDeletion: TLMDCheckBox;
    PreviewPanel: TLMDBackPanel;
    cbUseBgr: TLMDCheckBox;
    BottomPanel: TPanel;
    Bevel3: TBevel;
    btnOk: TLMDButton;
    btnCancel: TLMDButton;
    cbCascade: TLMDCheckBox;
    btnAddComponent: TLMDSpeedButton;
    LMDCheckListDlg1: TLMDCheckListDlg;
    btnCreateStyle: TLMDSpeedButton;
    FilterPanel: TPanel;
    fltEdit: TLMDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PVGroupingClick(Sender: TObject);
    procedure PropTreeClick(Sender: TObject);
    procedure StylesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure StylesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure StylesCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure HeaderControlSectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure StylesAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure StylesEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure StylesClick(Sender: TObject);
    procedure StylesDblClick(Sender: TObject);
    procedure EditorControlKeyPress(Sender: TObject; var Key: Char);
    procedure EditorControlExit(Sender: TObject);
    procedure cbCtlXpClick(Sender: TObject);
    procedure StylesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PropViewClick(Sender: TObject);
    procedure cbAlignClick(Sender: TObject);
    procedure bttLoadFromFileClick(Sender: TObject);
    procedure btnSaveToFileClick(Sender: TObject);
    procedure btnAddStyleClick(Sender: TObject);
    procedure btnDeleteStyleClick(Sender: TObject);
    procedure PreviewPanelResize(Sender: TObject);
    procedure StylesKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PropTreeCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure PropTreeExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure cbUseBgrClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure StylesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbStateStylesClick(Sender: TObject);
    procedure cbCascadeClick(Sender: TObject);
    procedure StylesEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure FormShow(Sender: TObject);
    procedure btnAddComponentClick(Sender: TObject);
    procedure btnCreateStyleClick(Sender: TObject);
    procedure fltEditKeyPress(Sender: TObject; var Key: Char);
    procedure fltEditCustomButtons0Click(Sender: TObject; index: Integer);
    procedure fltEditChange(Sender: TObject);
  private
    FOwnerForm: TComponent;
    FStyleManager   : TLMDStyleManager;
    FDefStyleNode: TTreeNode;
    FEditorControl: TControl;
    FPreviewControl: TControl;
    FEditingPropNode: TTreeNode;
    FCurPropNode: TTreeNode;

    FPropValueSaved: boolean;
    FShiftState: TShiftState;
    FOldStyleName: string;

  protected
    procedure AdjustPreviewControl;
    procedure AddStateStyles(ATreeNode: TTreeNode);
    procedure ApplyStyleToPreviewControl;
    function  AllSubStylesValid(ANode: TTreeNode; var msg: string): boolean;

    procedure BuildStylesTreeView;
    procedure CreateEditorControl(ANode: TTreeNode);
    procedure DeleteStyleNode;

    procedure FillPropTree(AGrouping: TLMDPropViewGrouping);
    function  FindNode(ATreeView: TTreeView; ACaption: string; ANode: TTreeNode = nil; ALevel: integer = -1): TTreeNode;
    function  FindNodeByFullStyleName(AStartNode: TTreeNode; AFullStyleName: string):TTreeNode;
    function  FindAncestorStyle(ANode: TTreeNode): string;

    function  GetDisplayValue(ANode: TTreeNode): string;
    function  GetFullPropName(ANode: TTreeNode):string;
    function  GetSubStyleCount(ANode: TTreeNode): integer;
    function  GetTypedFullPropName(ANode: TTreeNode):string;
    function  GetValueRect(ANode: TTreeNode):TRect;

    procedure ShowPreviewControl(AClassName: string);
    procedure SavePropValue;
    procedure SavePropsToStyle(AComponent: TObject; ANode: TTreeNode; AStyleName: string);

    function IsNonGraphicClass(ANode: TTreeNode): boolean; overload;
    function IsNonGraphicClass(AItem: TLMDPropListItem): boolean; overload;
    function IsValidStylePlacement(ANode: TTreeNode; AStyleName: string; var Msg: string): boolean;
  public
    procedure SetData(StyleManager: TLMDStyleManager);
    procedure GetData(StyleManager: TLMDStyleManager);
  end;

  TLMDStyleManEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TLMDPropListItem = class(TObject)
  protected
    FPropertyName: string;
    FTypeKind: TTypeKind;
    FTypeName: string;
    FAClassName: string;
    FContainerPropName: string;
  public
    property PropertyName: string read FPropertyName write FPropertyName;
    property TypeKind: TTypeKind read FTypeKind write FTypeKind;
    property TypeName: string read FTypeName write FTypeName;
    property AClassName: string read FAClassName write FAClassName;
    property ContainerPropName: string read FContainerPropName write FContainerPropName;
  end;

  TLMDPropList = class(TObject)
  private
    FExclusions: TStringList;
    FProps: TStringList;
    function GetCount: integer;
  protected
    function GetItems(Index: Integer): TLMDPropListItem;
    procedure SetItems(Index: Integer; Value: TLMDPropListItem);
  public
    procedure AddProperty(APropItem: TLMDPropListItem);
    constructor Create;
    procedure Clear;
    function FindItemByName(const AName: string): TLMDPropListItem;
    function FindItemByNameAndClassName(const AName, AClassName: string; AContainerPropName: string = ''): TLMDPropListItem;
    function FindItemByNameAndTypeName(const AName, ATypeName: string; AContainerPropName: string = ''): TLMDPropListItem;

    destructor Destroy; override;
    procedure ExcludeProperty(PropName: string);
    property Items[Index: Integer]: TLMDPropListItem read GetItems write SetItems; default;
    property Count: integer read GetCount;
    property Props: TStringList read FProps;
    function PropertyExcluded(PropName: string): Boolean;
  end;

var
  PropList: TLMDPropList;

procedure RegisterStyleMgrClass(AnObject: TPersistentClass; AContainerPropName: string);

implementation

uses
  LMDTypes, LMDConst, LMDStrings, pLMDCPGetMain, pLMDCPGetCore,
  intfLMDBase, LMDThemes, pLMDCstMain;

{$R *.DFM}

const
  sMsgTitle : string = 'LMD Tools Style Editor';
  StyleMgrClassesRegistered: boolean = false;
  Grouping: array[0..1] of TLMDPropViewGrouping=(pvgTypeName, pvgClassName);
  DefStyleImageIndex = 0;
  CompStyleImageIndex = 1;
  UserStyleImageIndex = 2;
  StateStyleImageIndex = 3;
  PropertyImageIndex = 4;

function LMDInRange(L, R, x: integer): boolean;
begin
  Result := not ((x < L) or (x > R));
end;

function GetStyleName(ANode: TTreeNode):string;
var
  s: string;
begin
  s := ANode.Text;
  while ANode.Parent<>nil do
    begin
      ANode := ANode.Parent;
      if ANode.Parent <> nil then
        s := ANode.Text + AncestorDelim + s;
    end;
  result := s;  
end;

function CompareStyles(List: TStringList; Index1, Index2: Integer): Integer;
var
  Count1,Count2: integer;
begin
  Count1 := LMDAnsiCount(List[Index1], AncestorDelim);
  Count2 := LMDAnsiCount(List[Index2], AncestorDelim);
  if Count1 < Count2 then
    result := -1
  else
  if Count1 > Count2 then
    result := 1
  else
    result := CompareStr(List[Index1], List[Index2]);
end;

function ComparePropListItemByClassName(List: TStringList; Index1, Index2: Integer): Integer;
var
  LPLItem1: TLMDPropListItem;
  LPLItem2: TLMDPropListItem;
begin
  LPLItem1 := TLMDPropListItem(List.Objects[Index1]);
  LPLItem2 := TLMDPropListItem(List.Objects[Index2]);
  result := CompareStr(LPLItem1.AClassName, LPLItem2.AClassName);
end;

function ComparePropListItemByTypeName(List: TStringList; Index1, Index2: Integer): Integer;
var
  LPLItem1: TLMDPropListItem;
  LPLItem2: TLMDPropListItem;
begin
  LPLItem1 := TLMDPropListItem(List.Objects[Index1]);
  LPLItem2 := TLMDPropListItem(List.Objects[Index2]);
  result := CompareStr(LPLItem1.TypeName, LPLItem2.TypeName);
end;

function CustomStylesSortProc(Node1, Node2: TTreeNode; Data: Integer): Integer; stdcall;

begin
  if (Node1.Data <> nil) and (Node2.Data = nil) then
    result := -1
  else
  if (Node1.Data = nil) and (Node2.Data <> nil) then
    result := 1
  else
    result := CompareStr(Node1.Text, Node2.Text);
end;

function CustomPropsSortProc(Node1, Node2: TTreeNode; Data: Longint): Integer; stdcall;

var
  n1,n2: boolean;
begin
  if (Node1.Count = 0) and (Node1.Count = 0) then
    begin
      result := CompareStr(Node1.Text, Node2.Text);
    end
  else
    begin
      n1 := (Pos('Base', Node1.Text) > 0) or (Pos('Custom', Node1.Text) > 0);
      n2 := (Pos('Base', Node2.Text) > 0) or (Pos('Custom', Node2.Text) > 0);
      if (n1 and not n2) then
        result := -1
      else
      if (not n1 and n2) then
        result := 1
      else
        result := CompareStr(Node1.Text, Node2.Text);
    end;
end;

procedure RegisterStyleMgrClass(AnObject: TPersistentClass; AContainerPropName: string);
var
  i: integer;
  PropCount: Integer;
  Props:  PPropList ;
  PropName: String;
  pTD: TLMDTypeData;
  LPLItem: TLMDPropListItem;
begin
  ActivateClassGroup(Controls.TControl);
  if GetClass(AnObject.ClassName) = nil then
    RegisterClass(AnObject);
  if PropList <> nil then
  begin
    PropCount := GetPropList(AnObject.ClassInfo, [tkInteger, tkEnumeration,
      tkFloat, tkString, tkWString, tkLString, tkClass, tkChar, tkSet], nil);
    if PropCount > 0 then
    begin
      GetMem(Props, PropCount * sizeof(pointer));
      try
        GetPropList(AnObject.ClassInfo, [tkInteger, tkEnumeration, tkFloat,
          tkString, tkWString, tkLString, tkClass, tkChar, tkSet], Props);
        for i := 0 to PropCount - 1 do
        begin
          if  Props[i]^.PropType^.Kind = tkClass then
          begin
            pTD := GetTypeData(Props[i]^.PropType^);
            if pTD^.ClassType.InheritsFrom(TPersistent) and
               (pTD^.ClassType.InheritsFrom(TImageList) or
                pTD^.ClassType.InheritsFrom(TStrings))
                then
              Continue;
          end;
          PropName := {$IFDEF LMDCOMP12}String{$ENDIF}(Props[i]^.Name);
          if PropList.PropertyExcluded(PropName) or
             PropList.PropertyExcluded(PropName+TypeNameDelim+{$IFDEF LMDCOMP12}String{$ENDIF}(Props[i]^.PropType^.Name)) then
            continue;
          if PropList.PropertyExcluded(AContainerPropName) then
            continue;
          if PropList.FindItemByNameAndClassName(PropName,AnObject.ClassName, AContainerPropName) = nil then
            begin
              LPLItem := TLMDPropListItem.Create;
              with LPLItem do
                begin
                  PropertyName := PropName;
                  AClassName := AnObject.ClassName;
                  TypeKind := Props[i]^.PropType^.Kind;
                  TypeName := {$IFDEF LMDCOMP12}String{$ENDIF}(Props[i]^.PropType^.Name);
                  ContainerPropName := AContainerPropName;
                end;
              PropList.AddProperty(LPLItem);
            end;
          if  Props[i]^.PropType^.Kind = tkClass then
          begin
            pTD := GetTypeData(Props[i]^.PropType^);
            if pTD^.ClassType.InheritsFrom(TPersistent) and
               (not (pTD^.ClassType = TBitmap)) and
               (not (pTD^.ClassType = TIcon)) then
              begin
                RegisterStyleMgrClass(TPersistentClass(pTD^.ClassType), PropName);
                Continue;
              end;
          end;
        end;
      finally
        FreeMem(Props);
      end;
    end;
  end;
end;

procedure TLMDPropList.AddProperty(APropItem: TLMDPropListItem);
begin
  FProps.AddObject(APropItem.PropertyName,APropItem);
end;

constructor TLMDPropList.Create;
begin
  inherited Create;
  FExclusions := TStringList.Create;
  FProps := TStringList.Create;

  FExclusions.Duplicates := dupIgnore;
  FExclusions.Sorted := true;

  FProps.Capacity := 3000;
  FProps.Duplicates := dupAccept;
  FProps.Sorted := true;
end;

function TLMDPropList.GetItems(Index: Integer): TLMDPropListItem;
begin
  Result := TLMDPropListItem(FProps.Objects[Index]);
end;

procedure TLMDPropList.SetItems(Index: Integer; Value: TLMDPropListItem);
begin
  FProps.Objects[index] := Value;
end;

function TLMDPropList.FindItemByName(const AName: string): TLMDPropListItem;
var
  i:integer;
begin
  Result := nil;
  i := FProps.IndexOf(AName);
  if i > 0 then
    Result := TLMDPropListItem(FProps.Objects[i]);
end;

function TLMDPropList.FindItemByNameAndClassName(const AName,
  AClassName: string; AContainerPropName: string = ''): TLMDPropListItem;
var
  i: integer;
  c: boolean;
begin
  //this procedure assumes that Props.Sorted = true (default sort by prop name)
  Result := nil;
  if Count = 0 then
    exit;
  i := FProps.IndexOf(AName);
  if i < 0 then
    exit;
  c := AContainerPropName <> '';
  while (i < Count) and (FProps[i] = AName) do
    begin
      if (Items[i].AClassName = AClassName) and
         (not c or c and (Items[i].ContainerPropName = AContainerPropName)) then
        begin
          result := Items[i];
          break;
        end;
      inc(i);
    end;
end;

function TLMDPropList.FindItemByNameAndTypeName(const AName,
  ATypeName: string; AContainerPropName: string = ''): TLMDPropListItem;
var
  i: integer;
  c: boolean;
begin
  //this procedure assumes that Props.Sorted = true (default sort by prop name)
  Result := nil;
  if Count = 0 then
    exit;
  c := AContainerPropName <> '';
  i := FProps.IndexOf(AName);
  if i < 0 then
    exit;
  while (i < Count) and (FProps[i] = AName) do
    begin
      if (Items[i].TypeName = ATypeName) and
         (not c or c and (Items[i].ContainerPropName = AContainerPropName)) then
        begin
          result := Items[i];
          break;
        end;
      inc(i);
    end;
end;

function TLMDPropList.PropertyExcluded(PropName: string): Boolean;
begin
  Result := FExclusions.IndexOf(Uppercase(PropName)) <> -1;
end;

destructor TLMDPropList.Destroy;
begin
  FExclusions.Clear;
  FreeAndNil(FExclusions);
  Clear;
  FreeAndNil(FProps);
  inherited;
end;

procedure TLMDPropList.ExcludeProperty(PropName: string);
begin
  FExclusions.Add(Uppercase(PropName));
end;

procedure TLMDStyleManEditor.ExecuteVerb(Index: Integer);
var
  i: integer;
begin
  if not StyleMgrClassesRegistered then
  begin
    StyleMgrClassesRegistered := true;

    PropList.ExcludeProperty('About');
    PropList.ExcludeProperty('Action');
    PropList.ExcludeProperty('Anchors');
    PropList.ExcludeProperty('Autosize');        
    PropList.ExcludeProperty('ButtonCaption');
    PropList.ExcludeProperty('Buttons');
    PropList.ExcludeProperty('Cancel');
    PropList.ExcludeProperty('CharCase');
    PropList.ExcludeProperty('Constraints');
    PropList.ExcludeProperty('CustomColors');

    //PropList.ExcludeProperty('Days');
    PropList.ExcludeProperty('DockSite');
    PropList.ExcludeProperty('DragKind');
    PropList.ExcludeProperty('DropDownMenu');
    PropList.ExcludeProperty('Default');
    PropList.ExcludeProperty('DefaultExt');
    PropList.ExcludeProperty('Enabled');
    PropList.ExcludeProperty('ExampleText');
    PropList.ExcludeProperty('FaceController');
    PropList.ExcludeProperty('FontList');
    PropList.ExcludeProperty('ForceMaskCheck');
    PropList.ExcludeProperty('HelpContext');
    PropList.ExcludeProperty('Hint');
    //PropList.ExcludeProperty('Hours');
    PropList.ExcludeProperty('MaxLength');
    //PropList.ExcludeProperty('Minutes');
    PropList.ExcludeProperty('Name');
    PropList.ExcludeProperty('ImageList');
    PropList.ExcludeProperty('Increment');
    PropList.ExcludeProperty('InitialDir');
    PropList.ExcludeProperty('IniKey');    
    PropList.ExcludeProperty('IniLink');
    PropList.ExcludeProperty('Items');
    PropList.ExcludeProperty('LargeIncrement');
    PropList.ExcludeProperty('Lines:TLMDMemoStrings');
    PropList.ExcludeProperty('Lines:TStrings');    
    PropList.ExcludeProperty('Layout');
    PropList.ExcludeProperty('MaxValue');
    PropList.ExcludeProperty('MinValue');
    PropList.ExcludeProperty('OEMConvert');
    PropList.ExcludeProperty('Orientation');
    PropList.ExcludeProperty('Owner');
    PropList.ExcludeProperty('Parent');
    PropList.ExcludeProperty('ParentSection');
    PropList.ExcludeProperty('PasswordChar');
    PropList.ExcludeProperty('PopupMenu');
    PropList.ExcludeProperty('Position');
    PropList.ExcludeProperty('Prompt');
    //PropList.ExcludeProperty('Readonly');
    PropList.ExcludeProperty('TimeOffset');
    PropList.ExcludeProperty('TabOrder');
    PropList.ExcludeProperty('TabStop');
    PropList.ExcludeProperty('Tag');
    PropList.ExcludeProperty('Text');
    //PropList.ExcludeProperty('Seconds');
    PropList.ExcludeProperty('StartFolder');
    PropList.ExcludeProperty('StyleManager');
    PropList.ExcludeProperty('Style:String');
    PropList.ExcludeProperty('Stringlist');
    PropList.ExcludeProperty('Value');
  end;

  PropList.Clear;
  with (Component as TLMDStyleManager).Owner do
    for i := 0 to ComponentCount - 1 do
      if Components[i].InheritsFrom(TComponent) and (Components[i] <> Component) then
        begin
          RegisterStyleMgrClass(TPersistentClass(Components[i].ClassType), '');
          RegisterStyleMgrClass(TPersistentClass(Components[i].ClassParent), '');
          RegisterStyleMgrClass(TPersistentClass(Components[i].ClassParent.ClassParent), '');
        end;

  with TfrmLMDStyleManProp.Create(Application) do
  try
    SetData(Component as TLMDStyleManager);
    if ShowModal = mrOk then
      begin
        GetData(Component as TLMDStyleManager);
        self.Designer.Modified;
      end;
  finally
    Free;
  end
end;

function TLMDStyleManEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Style Designer...';
  end;
end;

function TLMDStyleManEditor.GetVerbCount: Integer;
begin
  Result := 1
end;

procedure TfrmLMDStyleManProp.SetData(StyleManager: TLMDStyleManager);
begin
  FStyleManager.Assign(StyleManager);
  FOwnerForm := StyleManager.Owner;
end;

procedure TfrmLMDStyleManProp.GetData(StyleManager: TLMDStyleManager);
begin
  StyleManager.Assign(FStyleManager);
end;

procedure TfrmLMDStyleManProp.FormCreate(Sender: TObject);
begin
  FStyleManager := TLMDStyleManager.Create(nil);
  FEditorControl := nil;
  FPreviewControl := nil;
  FEditingPropNode := nil;
  FDefStyleNode := FindNode(Styles,sDefaultStyleName,nil,0);
  if cbStateStyles.Checked then
    AddStateStyles(FDefStyleNode);
end;

procedure TfrmLMDStyleManProp.FormDestroy(Sender: TObject);
begin
  if FEditorControl <> nil then
    begin
      SavePropValue;
      FreeAndNil(FEditorControl);
    end;
  FStyleManager.Free;
end;

procedure TfrmLMDStyleManProp.BuildStylesTreeView;
var
  LSl: TStringList;
  i,j: integer;
  s, LTypeName, LPropName: string;
  LNode, LNode1: TTreeNode;
  LPLItem: TLMDPropListItem;

begin
  Styles.Items.Clear;
  Styles.Items.BeginUpdate;
  LSl := TStringList.Create;
  FStyleManager.GetStyleNames(LSl);
  LSl.CustomSort(CompareStyles);
  LNode := Styles.Items.AddChild(nil,sDefaultStyleName);
  FDefStyleNode := LNode;
  LNode.ImageIndex := DefStyleImageIndex;
  LNode.SelectedIndex := LNode.ImageIndex;
  try
    while LSl.Count > 0 do
      begin
        s := LSl[0];
        if LSl[0] = sDefaultStyleName then
          begin
            LSl.Delete(0);
            continue;
          end;
        if LMDAnsiCount(LSl[0],AncestorDelim)=0 then
          LNode1 := Styles.Items.AddChildFirst(LNode, LSl[0])
        else
          begin
            s := LMDAnsiGetRightTrimmedString(LSl[0], AncestorDelim);
            LNode := FindNodeByFullStyleName(FDefStyleNode, s);
            s := LMDAnsiGetLastString(LSl[0], AncestorDelim);
            LNode1 := Styles.Items.AddChild(LNode, s);
          end;
        if s[1]=StylePrefix then
          begin
            if FStyleManager.IsStateStyle(s) then
              LNode1.ImageIndex := StateStyleImageIndex
            else
              LNode1.ImageIndex := UserStyleImageIndex
          end
        else
          LNode1.ImageIndex := CompStyleImageIndex;
        LNode1.SelectedIndex := LNode1.ImageIndex;
        LSl.Delete(0);
      end;
    for i := Styles.Items.Count - 1 downto 0 do
      begin
        LNode := Styles.Items[i];
        if LNode.ImageIndex < 0 then
          continue;
        s := GetStyleName(LNode);
        FStyleManager.GetProperties(s, LSl);
        for j:=0 to LSl.Count - 1 do
          begin
            LPropName := LMDAnsiGetFirstString(LSl[j],TypeNameDelim);
            s := LMDAnsiGetLastString(LPropName,'.');
            LTypeName := LMDAnsiGetLastString(LSl[j],TypeNameDelim);
            LPLItem := PropList.FindItemByNameAndTypeName(s, LTypeName);
            if LPLItem <> nil then
              begin
                LNode1 := Styles.Items.AddChildObject(LNode, LPropName, LPLItem);
                LNode1.ImageIndex := PropertyImageIndex;
                LNode1.SelectedIndex := LNode1.ImageIndex;
              end
          end;
      end;
  finally
    Styles.CustomSort(@CustomStylesSortProc, 0);
    Styles.FullExpand;
    Styles.Items.EndUpdate;
    LSl.Free;
  end;
end;

function TfrmLMDStyleManProp.GetDisplayValue(ANode: TTreeNode): string;
var
  d: double;
  i: integer;
  AClass: TClass;
  TypeInfo: PTypeInfo;
  TypeData: PTypeData;
  PropInfo: PPropInfo;
  PropType, PropName, LStyleName: string;
  lStream: TMemoryStream;
  LItem: TLMDPropListItem;

  function QueryComponentClass(Info : PTypeInfo) : boolean;
  var p : TLMDTypeData;
  begin
    p := GetTypeData(Info);
    result := (p^.ClassType.InheritsFrom(TComponent));
  end;

begin
  LItem := TLMDPropListItem(ANode.Data);
  LStyleName := GetStyleName(ANode.Parent);
  PropName := LItem.PropertyName;
  PropType := '';
  AClass := GetClass(LItem.AClassName);

  with FStyleManager do
    case LItem.TypeKind of
      tkEnumeration:
        begin
          result := '(Invalid value)';
          ReadPropValue(LStyleName, ANode.Text, LItem.TypeName, i);

          if AClass = nil then
          begin
            Result := result + #32 + LItem.AClassName;
            exit;
          end;

          PropInfo := GetPropInfo(AClass.ClassInfo, PropName, tkAny);
          if PropInfo <> nil then
          begin
            TypeInfo := PropInfo^.PropType^;

            if TypeInfo <> nil then
            begin
              TypeData := GetTypeData(TypeInfo);
              if (TypeData <> nil) and LMDInRange(TypeData.MinValue,
                TypeData.MaxValue, i) then
                result := GetEnumName(PropInfo.PropType^, i);
            end;
          end;
        end;
      tkInteger:
        begin
          ReadPropValue(LStyleName, ANode.Text, LItem.TypeName, i);
          if LItem.FTypeName = 'TColor' then
            result := ColorToString(i)
          else
            result := IntToStr(i);
        end;
      tkFloat:
        begin
          ReadPropValue(LStyleName, ANode.Text, LItem.TypeName, d);
          if LItem.FTypeName = 'TDateTime' then
            result := DateTimeToStr(d)
          else
            result := FloatToStr(d);
        end;
      tkChar,
        tkString,
        tkWString,
        tkLString:
        begin
          ReadPropValue(LStyleName, ANode.Text, LItem.TypeName, result);
        end;
      tkClass:
        try
          lStream := TMemoryStream.Create;
          ReadPropValue(LStyleName, ANode.Text, LItem.TypeName, lStream);
          if lStream.Size > 0 then
            result := '(' + LItem.TypeName + ')'
          else
            result := '(none)';
        finally
          lStream.Free;
        end;
      tkSet:
        ReadPropValue(LStyleName, ANode.Text, LItem.TypeName, result);
    end; {case}
end;

procedure TfrmLMDStyleManProp.FillPropTree(
  AGrouping: TLMDPropViewGrouping);
var
  LSaveCursor: TCursor;
            i: integer;
  LCurTypeOrClass, s: string;
       LNode, LNode1: TTreeNode;
begin
  PropList.Props.Sorted := false;
  btnCreateStyle.Enabled := (AGrouping = pvgClassName);
  case AGrouping of
    pvgClassName: PropList.Props.CustomSort(ComparePropListItemByClassName);
    pvgTypeName:  PropList.Props.CustomSort(ComparePropListItemByTypeName);
  end;

  PropTree.Items.BeginUpdate;
  PropTree.Items.Clear;
  LSaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  LCurTypeOrClass := '';
  LNode := nil;
  try
    for i := 0 to PropList.Count - 1 do
      if PropList.Items[i].ContainerPropName = '' then
        begin
          s := PropList.Items[i].PropertyName;
          if not LMDCheckWildCardMask(fltEdit.Text, s) then
            continue;
          case AGrouping of
            pvgClassName: s := PropList.Items[i].AClassName;
             pvgTypeName: s := PropList.Items[i].TypeName;
          end;
          if LCurTypeOrClass  <> s then
            begin
              LNode := PropTree.Items.Add(nil, s);
              LCurTypeOrClass := s;
            end;
          LNode1 := nil;
          case AGrouping of
            pvgClassName:
              begin
                LNode1 := PropTree.Items.AddChildObject(LNode, PropList.Items[i].PropertyName, PropList.Items[i]);
              end;
             pvgTypeName: if FindNode(PropTree, PropList.Items[i].PropertyName, LNode) = nil then
                            LNode1 := PropTree.Items.AddChildObject(LNode, PropList.Items[i].PropertyName, PropList.Items[i]);
          end;
          if IsNonGraphicClass(PropList.Items[i]) and (LNode1 <> nil) then
            PropTree.Items.AddChild(LNode1,'Dummy');
        end;

    PropList.Props.Sorted := true;
    PropTree.AlphaSort;
  finally
    PropTree.CustomSort(@CustomPropsSortProc, 0);
    PropTree.Items.EndUpdate;
    Screen.Cursor := LSaveCursor;
  end;
end;

function TfrmLMDStyleManProp.FindNode(ATreeView: TTreeView;
  ACaption: string; ANode: TTreeNode = nil; ALevel: integer = -1): TTreeNode;
var
  i:integer;
begin
  result := nil;
  if ANode <> nil then
    begin
      with ANode do
        for i := 0 to Count - 1 do
          begin
            if ALevel >= 0 then
              if Item[i].Level <> ALevel then
                continue;
            if Item[i].Text = ACaption then
              begin
                result := Item[i];
                break;
              end
          end
    end
  else
    with ATreeView do
      for i := 0 to Items.Count - 1 do
        begin
          if ALevel >= 0 then
            if Items[i].Level <> ALevel then
              continue;
          if Items[i].Text = ACaption then
            begin
              result := Items[i];
              break;
            end;
        end
end;

function TfrmLMDStyleManProp.FindNodeByFullStyleName(AStartNode: TTreeNode;
  AFullStyleName: string): TTreeNode;
var
  s1,s2: string;
      i: integer;
begin
  if AStartNode.Text = AFullStyleName then
    begin
      result := AStartNode;
      exit;
    end;
  result := nil;
  s1 := LMDAnsiGetFirstString(AFullStyleName, AncestorDelim);
  s2 := LMDAnsiGetSecondString(AFullStyleName, AncestorDelim);
  for i := 0 to AStartNode.Count - 1 do
    if AStartNode.Item[i].Text = s1 then
      result := FindNodeByFullStyleName(AStartNode.Item[i], s2);
end;

procedure TfrmLMDStyleManProp.PVGroupingClick(Sender: TObject);
begin
  FillPropTree(Grouping[PVGrouping.ItemIndex]);
end;

procedure TfrmLMDStyleManProp.PropTreeClick(Sender: TObject);
var
        i: integer;
   LVItem: TListItem;
begin
  if PropTree.Items.Count = 0 then
    exit;
  if PropTree.Selected = nil then
    exit;
  try
    PropView.Items.BeginUpdate;
    PropView.Items.Clear;
    if PropTree.Selected.Data = nil then
      ShowPreviewControl(PropTree.Selected.Text)
    else
      begin
        i := PropList.Props.IndexOf(PropTree.Selected.Text);
        while (i < PropList.Count) and (PropTree.Selected.Text = PropList.Props[i]) do
          begin
            LVItem := PropView.Items.Add;
            LVItem.Caption := PropList.Items[i].AClassName;
            LVItem.SubItems.Add(PropList.Items[i].TypeName);
            LVItem.SubItems.Add(PropList.Items[i].ContainerPropName);
            inc(i);
          end;
      end;
  finally
    PropView.Items.EndUpdate;
  end;
end;

procedure TfrmLMDStyleManProp.StylesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TTreeView);
end;

procedure TfrmLMDStyleManProp.StylesDragDrop(Sender, Source: TObject; X,  Y: Integer);
var
  LNode, LTn, LTn_Dest, LTn_Src:TTreeNode;
  LClass: TClass;
  LSrcStyle, LDstStyle,
  LFullPropName, LTypeName,
  LTypedFullPropName, s: string;
  i: integer;
begin
  LTn_Src := TTreeView(Source).Selected;
  LTn_Dest := TTreeView(Sender).DropTarget;

  if (LTn_Src = nil) or (LTn_Dest = nil) then
    exit;

  if LTn_Dest.Data <> nil then
    LTn_Dest := LTn_Dest.Parent;

  if LTn_Src.Text = sDefaultStyleName then
    begin
      messagebox(handle,pchar(IDS_CANTMOVEDEFSTYLE), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK);
      exit;
    end;

  if LTn_Src.Data <> nil then
    begin
      if LTn_Src.TreeView = PropTree then
        LFullPropName := GetFullPropName(LTn_Src)
      else
        LFullPropName := LTn_Src.Text;
      LTypeName := TLMDPropListItem(LTn_Src.Data).TypeName;
      LTypedFullPropName := LFullPropName + TypeNameDelim + LTypeName;
    end;

  if LTn_Src.TreeView = PropTree then
    s := LFullPropName
  else
    s := LTn_Src.Text;

  //base check - if the node exists amongst dest node children
  LNode := FindNode(Styles, s, LTn_Dest);
  if LNode = nil then
    begin
      //node drag&dropped from the PropTree (on the left)
      if LTn_Src.TreeView = PropTree then
        begin
          if (LTn_Src.Data = nil) then
          //component name is dragged from prop tree to create
          //default component style 
            begin
              if (PVGrouping.ItemIndex = 0) then
                //when grouped by the type name, prop tree doesn't allow
                //creation default component style by drag & drop
                begin
                  messagebox(handle,pchar(IDS_INVALIDCLASSFORDEFSTYLE), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK);
                  exit;
                end;
              if not IsValidStylePlacement(LTn_Dest, LTn_Src.Text, s) then
                //selected place for default component style
                //is not valid
                begin
                  messagebox(handle,pchar(s), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK);
                  exit;
                end
            end
          else
            begin
              s := FindAncestorStyle(Ltn_Dest);
              //if there is ancestor - default component style,
              //then we have to check whether this component has selected property
              if (s <> '') and (LTn_Dest <> FDefStyleNode) and
                 (PropList.FindItemByNameAndClassName(LMDAnsiGetFirstString(LFullPropName,'.'), s) = nil) then
                if messagebox(handle,pchar(Format(IDS_NOSUCHPROPERTY, [s, LFullPropName])), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_YESNO)=ID_NO then
                  exit;
            end;
          if (LTn_Src.Data = nil) then
          //style node is being drag & dropped from the prop tree
            begin
              LTn := Styles.Items.AddChild(LTn_Dest,GetFullPropName(LTn_Src));
              //LClass := nil;
              LClass := GetClass(LTn_Src.Text);
              if (LClass <> nil) and (LClass.InheritsFrom(TComponent)) then
                begin
                  LTn.ImageIndex := CompStyleImageIndex;
                  LTn.SelectedIndex := LTn.ImageIndex;
                  FStyleManager.WritePropValue(GetStyleName(LTn), StyleKindStringID, 'integer', LTn.ImageIndex);
                  if (Ltn_Src.TreeView = PropTree) and (cbStateStyles.Checked) then
                    AddStateStyles(LTn);
                end
            end
          else
            begin
              if IsNonGraphicClass(LTn_Src) then
                begin
                  //batch props add
                  LTn_Src.Expand(False);
                  for i := 0 to LTn_Src.Count - 1 do
                    if not IsNonGraphicClass(LTn_Src.Item[i]) then
                      begin
                        s := GetFullPropName(LTn_Src.Item[i]);
                        if FindNode(Styles, s, LTn_dest) = nil then
                          begin
                            LTn := Styles.Items.AddChild(LTn_Dest, s);
                            LTn.ImageIndex := PropertyImageIndex;
                            LTn.SelectedIndex := LTn.ImageIndex;
                            LTn.Data := LTn_Src.Item[i].Data;
                          end
                      end
                end
              else
                begin
                  //single prop add
                  LTn := Styles.Items.AddChild(LTn_Dest,GetFullPropName(LTn_Src));
                  LTn.ImageIndex := PropertyImageIndex;
                  LTn.SelectedIndex := LTn.ImageIndex;
                  LTn.Data := LTn_Src.Data;
                end
            end;
        end
      else
        //node is drag&dropped from the Styles tree (on the right)
        begin
          if LTn_Src.Data <> nil then //Property is being drag & dropped
            begin
              s := FindAncestorStyle(Ltn_Dest);
              if (s <> '') and (LTn_Dest <> FDefStyleNode) and
                (PropList.FindItemByNameAndClassName(LMDAnsiGetFirstString(LFullPropName,'.'), s) = nil) then
                if messagebox(handle,pchar(Format(IDS_NOSUCHPROPERTY, [s, LFullPropName])), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_YESNO)=ID_NO then
                  exit;
              LSrcStyle := GetStyleName(LTn_Src.Parent);
              LDstStyle := GetStyleName(LTn_Dest);
              FStyleManager.ReadPropValue(LSrcStyle, LFullPropName, LTypeName, s); //s='' if there's no such property
              if s = '' then
                begin
                  messagebox(handle,pchar(IDS_CANTMOVEUNDEFINEDPROPERTY), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK);
                  exit;
                end;
              if ssShift in FShiftState then
                begin
                  LTn := Styles.Items.AddChildObject(LTn_Dest, LTn_Src.Text, LTn_Src.Data);
                  LTn.ImageIndex := PropertyImageIndex;
                  LTn.SelectedIndex := LTn.ImageIndex;
                  FStyleManager.WritePropValue(LDstStyle, LFullPropName, LTypeName, s);
                end
              else
                begin
                  FStyleManager.WritePropValue(LDstStyle, LFullPropName, LTypeName, s);
                  FStyleManager.EraseProperty(LSrcStyle, LFullPropName, LTypeName);
                  LTn_Src.MoveTo(LTn_Dest, naAddChild);
                end
            end
          else //Style is being drag & dropped
            begin
              if LTn_Dest.HasAsParent(LTn_Src) then
                begin
                  messagebox(handle, pchar(IDS_CANTMOVESTYLETOSUBSTYLE), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK);
                  exit;
                end;
              if not IsValidStylePlacement(LTn_Dest, LTn_Src.Text, s) then
                begin
                  messagebox(handle, pchar(s), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK);
                  exit;
                end;
              LNode := LTn_Src.Parent;
              //old full name
              LSrcStyle := GetStyleName(LTn_Src);
              LTn_Src.MoveTo(LTn_Dest, naAddChild);
              if not AllSubStylesValid(LTn_Src, s) then
                begin
                  messagebox(handle,pchar(s), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK);
                  LTn_Src.MoveTo(LNode, naAddChild);
                  exit;
                end;
              //dest style full name
              LDstStyle := GetStyleName(LTn_Src);
              FStyleManager.RenameStyle(LSrcStyle, LDstStyle);
            end;
        end;
      LTn_Dest.CustomSort(@CustomStylesSortProc, 0);
      end
  else
    begin
      if LNode.Data <> nil then
        s := Format(IDS_PROPERTYEXISTS, [LTn_Src.Text])
      else
        s := Format(IDS_STYLEEXISTS, [LTn_Src.Text]);
      messagebox(handle,pchar(s), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK);
    end
end;

procedure TfrmLMDStyleManProp.StylesCompare(Sender: TObject; Node1, Node2: TTreeNode;
  Data: Integer; var Compare: Integer);
begin
  Compare := CustomStylesSortProc(Node1, Node2, Data);
end;

procedure TfrmLMDStyleManProp.HeaderControlSectionResize(
  HeaderControl: THeaderControl; Section: THeaderSection);
begin
  Styles.Repaint;
  if FEditorControl <> nil then
    with FEditorControl do
      begin
        Left := HeaderControl.Sections[0].Width;
        Width := HeaderControl.Sections[1].Width;
        Repaint;
      end;
end;

procedure TfrmLMDStyleManProp.StylesAdvancedCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
var
  NodeRect: TRect;
  s: string;
  bc : TColor;
begin
  if Stage = cdPostPaint then
    with Styles.Canvas do
      begin
        if (Node.Data <> nil) and (Node.ImageIndex = PropertyImageIndex) then
          begin
            NodeRect := GetValueRect(Node);
            s := GetDisplayValue(Node);
            if TLMDPropListItem(Node.Data).TypeName = 'TColor' then
              begin
                bc := Brush.Color;
                Brush.Color := StringToColor(s);
                InflateRect(NodeRect, -1, -1);
                FillRect(NodeRect);
                Brush.Color := bc;
              end;
            TextRect(NodeRect, NodeRect.Left+1, NodeRect.Top+1, s);
          end;
      end;
end;

procedure TfrmLMDStyleManProp.StylesEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
  if Node.Data <> nil then
    begin
      AllowEdit := false;
      CreateEditorControl(Node);
    end;
  if Node = FDefStyleNode then
    AllowEdit := false;
  FOldStyleName := Node.Text;
end;

function TfrmLMDStyleManProp.GetValueRect(ANode: TTreeNode): TRect;
begin
  result := ANode.DisplayRect(False);
  with result do
    begin
      Left := HeaderControl.Sections[0].Width;
      Right := Left + HeaderControl.Sections[1].Width;
    end;
end;

procedure TfrmLMDStyleManProp.StylesClick(Sender: TObject);
begin
  if FEditorControl <> nil then
    begin
      SavePropValue;
      FreeAndNil(FEditorControl);
    end;
  ApplyStyleToPreviewControl;
end;

procedure TfrmLMDStyleManProp.CreateEditorControl(ANode: TTreeNode);
var
  LRect: TRect;
  LPLItem: TLMDPropListItem;
  TypeInfo,
  TypeInfo2: TLMDTypeInfo;
  TypeData: TLMDTypeData;
  LClass: TClass;
  s,s1,LPropName: string;
  LStyle, LPropVal: string;
  i,j: integer;
  LBmp: TBitmap;
  LStream: TMemoryStream;
begin
  if ANode = nil then
    exit;
  if ANode.Data = nil then
    exit;
  if FEditorControl <> nil then
    begin
      SavePropValue;
      FreeAndNil(FEditorControl);
    end;
  FEditingPropNode := ANode;
  FPropValueSaved := false;
  LPLItem := TLMDPropListItem(ANode.Data);
  LStyle := GetStyleName(ANode.Parent);
  LPropVal := GetDisplayValue(ANode);
  case LPLItem.TypeKind of
    tkEnumeration:
      begin
        FEditorControl := TLMDListComboBox.CreateParented(Styles.Handle);
        TLMDListComboBox(FEditorControl).Flat := true;
        TLMDListComboBox(FEditorControl).OnKeyPress := EditorControlKeyPress;
        TLMDListComboBox(FEditorControl).OnAfterExit := EditorControlExit;
        LClass := FindClass(LPLItem.AClassName);
        lPropName := LMDAnsiGetLastString(LPLItem.PropertyName,'.');
        if LClass = nil then
          exit;
        TypeInfo := GetPropInfo(LClass.ClassInfo, LPropName, [tkEnumeration])^.PropType^;
        if TypeInfo = nil then
          exit;
        TypeData := GetTypeData(TypeInfo);
        j := 0;

        for i := TypeData.MinValue to TypeData.MaxValue do
          begin
            s1 := GetEnumName(TypeInfo, i);
            TLMDListComboBox(FEditorControl).Items.Add(s1);
            if s1 = LPropVal then
              begin
                TLMDListComboBox(FEditorControl).Text := s1;              
                TLMDListComboBox(FEditorControl).ItemIndex := j;
              end;
            inc(j);
          end;
      end;
    tkInteger:
      begin
        if LPLItem.TypeName = 'TColor' then
          begin
            FEditorControl := TLMDColorComboBox.CreateParented(Styles.Handle);
            TLMDColorComboBox(FEditorControl).OnKeyPress := EditorControlKeyPress;
            TLMDColorComboBox(FEditorControl).Options := [coDefaultColors, coSystemColors,
              coCustomColors, coAllowAnyColor, coAllowDialog];
            TLMDColorComboBox(FEditorControl).Flat := true;
            TLMDColorComboBox(FEditorControl).DisplayStyle := csColor3dText;
            TLMDColorComboBox(FEditorControl).SelectedColor := StringToColor(LPropVal);
          end
        else
          begin
            FEditorControl := TLMDSpinEdit.CreateParented(Styles.Handle);
            TLMDSpinEdit(FEditorControl).Flat := true;
            TLMDSpinEdit(FEditorControl).OnKeyPress := EditorControlKeyPress;
            TLMDSpinEdit(FEditorControl).Value := strtoint(LPropVal);
          end;
      end;
    tkFloat:
      begin
        if LPLItem.TypeName = 'TDateTime' then
          begin
            FEditorControl := TLMDCalendarComboBox.CreateParented(Styles.Handle);
            TLMDCalendarComboBox(FEditorControl).Flat := true;
            TLMDCalendarComboBox(FEditorControl).OnKeyPress := EditorControlKeyPress;
            TLMDCalendarComboBox(FEditorControl).Value := StrToDateTime(LPropVal);
          end
        else
          begin
            FEditorControl := TLMDExtSpinEdit.CreateParented(Styles.Handle);
            TLMDExtSpinEdit(FEditorControl).Flat := true;
            TLMDExtSpinEdit(FEditorControl).OnKeyPress := EditorControlKeyPress;
            TLMDExtSpinEdit(FEditorControl).EditType := ntFloatFixed;
            TLMDExtSpinEdit(FEditorControl).Decimals := 3;
            TLMDExtSpinEdit(FEditorControl).Value := StrToFloat(LPropVal);
            TLMDExtSpinEdit(FEditorControl).InfiniteMax := true;
            TLMDExtSpinEdit(FEditorControl).InfiniteMin := true;            
          end;
      end;
    tkChar, tkString, tkWString, tkLString:
      begin
        FEditorControl := TLMDEdit.CreateParented(Styles.Handle);
        TLMDEdit(FEditorControl).Flat := true;
        TLMDEdit(FEditorControl).OnKeyPress := EditorControlKeyPress;
        TLMDEdit(FEditorControl).Text := LPropVal;
      end;
    tkClass:
      begin
        LStream := TMemoryStream.Create;
        LBmp := TBitmap.Create;
        try
          LMDCPGetBitmap(LBmp);
          if not LBmp.Empty or LBmp.Empty and (messagebox(handle, pchar(IDS_CLEARBMPQUERY), pchar(sMsgTitle), MB_ICONQUESTION or MB_YESNO) = ID_YES) then
            begin
              LBmp.SaveToStream(LStream);
              LStream.Seek(0,soFromBeginning);
              FStyleManager.WritePropValue(GetStyleName(FEditingPropNode.Parent), FEditingPropNode.Text, LPLItem.TypeName, LStream);
            end;
        finally
          LBmp.Free;
          LStream.Free;
        end;
      end;
    tkSet:
      begin
        FEditorControl := TLMDCheckListComboBox.CreateParented(Styles.Handle);
        TLMDCheckListComboBox(FEditorControl).Flat := true;
        TLMDCheckListComboBox(FEditorControl).OnKeyPress := EditorControlKeyPress;
        LClass := FindClass(LPLItem.AClassName);
        lPropName := LMDAnsiGetLastString(LPLItem.PropertyName,'.');
        if LClass = nil then
          exit;
        TypeInfo := GetPropInfo(LClass.ClassInfo, LPropName, [tkSet])^.PropType^;
        if TypeInfo = nil then
          exit;
        TypeData := GetTypeData(TypeInfo);
        TypeInfo2 := TypeData.CompType^;
        TypeData := GetTypeData(TypeInfo2);
        for i := TypeData.MinValue to TypeData.MaxValue do
          begin
            s := GetEnumName(TypeInfo2, i);
            TLMDCheckListComboBox(FEditorControl).Items.Add(s);
            if Pos(s, LPropVal) > 0 then
              TLMDCheckListComboBox(FEditorControl).Checked[i] := true;
          end
      end;
  end;
  if FEditorControl = nil then
    exit;
  FEditorControl.Visible := false;
  if IsPublishedProp(FEditorControl, 'ThemeMode') then
    SetOrdProp(FEditorControl, 'ThemeMode', Ord(ttmPlatform));
  LRect := GetValueRect(ANode);
  with FEditorControl do
    begin
      Left := LRect.Left;
      Width := LRect.Right - LRect.Left;
      Top := LRect.Top;
      Height := LRect.Bottom - LRect.Top;
    end;
  FEditorControl.Visible := true;
end;

procedure TfrmLMDStyleManProp.StylesDblClick(Sender: TObject);
begin
  CreateEditorControl(FCurPropNode);
end;

procedure TfrmLMDStyleManProp.ShowPreviewControl(AClassName: string);
var
  LClass : TControlClass;
  PropInfo: PPropInfo;
begin
  if (Pos('Base',AClassName) > 0) or (Pos('Custom',AClassName) > 0) then
    exit;
  LClass := TControlClass(GetClass(AClassName));
  if (LClass <> nil) and (LClass.InheritsFrom(TControl)) then
  begin
    if FPreviewControl <> nil then
      FreeAndNil(FPreviewControl);
    try
    FPreviewControl := TControl(LClass.Create(nil));
    except
    end;

    if FPreviewControl=nil then
      exit;
    FPreviewControl.Parent := PreviewPanel;
    AdjustPreviewControl;
    if IsPublishedProp(FPreviewControl, 'ThemeMode') then
      SetOrdProp(FPreviewControl, 'ThemeMode', Ord(cbCtlXp.Checked));
    ApplyStyleToPreviewControl;
    if cbAlign.Checked then
      FPreviewControl.Align := alClient
    else
      FPreviewControl.Align := alNone;
    PropInfo := GetPropInfo(FPreviewControl.ClassInfo, 'Text');
    if PropInfo <> nil then
      SetStrProp(FPreviewControl, PropInfo, FPreviewControl.ClassName);
    PropInfo := GetPropInfo(FPreviewControl.ClassInfo, 'Caption');
    if PropInfo <> nil then
      SetStrProp(FPreviewControl, PropInfo, FPreviewControl.ClassName);
    PropInfo := GetPropInfo(FPreviewControl.ClassInfo, 'Value');
    if PropInfo <> nil then
      if PropInfo.PropType^.Kind in [tkString, tkLString, tkWString] then
        SetStrProp(FPreviewControl, PropInfo, 'Value');
  end
end;

procedure TfrmLMDStyleManProp.SavePropValue;
var
  LPLItem: TLMDPropListItem;
  LStyle, s: string;
  i : integer;
begin
  if (FEditingPropNode = nil) or FPropValueSaved then
    exit;
  LPLItem := TLMDPropListItem(FEditingPropNode.Data);
  if LPLItem = nil then
    exit;
  LStyle := GetStyleName(FEditingPropNode.Parent);
  with FStyleManager do
    case LPLItem.TypeKind of
      tkEnumeration:
        WritePropValue(LStyle, FEditingPropNode.Text, LPLItem.TypeName, TLMDListComboBox(FEditorControl).ItemIndex);
      tkInteger:
        begin
          if LPLItem.TypeName = 'TColor' then
            WritePropValue(LStyle, FEditingPropNode.Text, LPLItem.TypeName, TLMDColorComboBox(FEditorControl).SelectedColor)
          else
            WritePropValue(LStyle, FEditingPropNode.Text, LPLItem.TypeName, TLMDSpinEdit(FEditorControl).Value);
        end;
      tkFloat:
        if LPLItem.TypeName = 'TDateTime' then
          WritePropValue(LStyle, FEditingPropNode.Text, LPLItem.TypeName, TLMDCalendarComboBox(FEditorControl).Value)
        else
          WritePropValue(LStyle, FEditingPropNode.Text, LPLItem.TypeName, TLMDExtSpinEdit(FEditorControl).Value);
      tkChar, tkString, tkWString, tkLString:
        WritePropValue(LStyle, FEditingPropNode.Text, LPLItem.TypeName, TLMDEdit(FEditorControl).Text);
      tkClass: ;
      //bitmap is saved in CreateEditorControl
      //after modal dialog is closed
      tkSet:
        begin
          s := '';
          for i := 0 to TLMDCheckListComboBox(FEditorControl).Items.Count - 1 do
            if TLMDCheckListComboBox(FEditorControl).Checked[i] then
              s := LMDAnsiAddDelimiter(s,',') + TLMDCheckListComboBox(FEditorControl).Items[i];
          WritePropValue(LStyle, FEditingPropNode.Text, LPLItem.TypeName, '[' + s + ']');
        end;
    end;
  FPropValueSaved := true;
  ApplyStyleToPreviewControl;
end;

procedure TfrmLMDStyleManProp.EditorControlKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=#13 then
    begin
      SavePropValue;
      FEditorControl.Visible := false;
    end;
end;

procedure TfrmLMDStyleManProp.EditorControlExit(Sender: TObject);
begin
  SavePropValue;
  FEditorControl.Visible := false;
end;

procedure TfrmLMDStyleManProp.cbCtlXpClick(Sender: TObject);
begin
  if FPreviewControl <> nil then
    if IsPublishedProp(FPreviewControl, 'ThemeMode') then
      SetOrdProp(FPreviewControl, 'ThemeMode', Ord(cbCtlXP.Checked));
end;

procedure TfrmLMDStyleManProp.StylesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCurPropNode := Styles.GetNodeAt(X,Y);
  if FCurPropNode <> Styles.Selected then
    Styles.Selected := FCurPropNode;
end;

procedure TfrmLMDStyleManProp.PropViewClick(Sender: TObject);
begin
  if PropView.Selected <> nil then
    ShowPreviewControl(PropView.Selected.Caption);
end;

procedure TfrmLMDStyleManProp.cbAlignClick(Sender: TObject);
begin
  if FPreviewControl <> nil then
    begin
      if cbAlign.Checked then
        FPreviewControl.Align := alClient
      else
        FPreviewControl.Align := alNone;
    end
end;

procedure TfrmLMDStyleManProp.ApplyStyleToPreviewControl;
var
  LNode: TTreeNode;
  s: string;
begin
  if (FPreviewControl<>nil) and (Styles.Selected <> nil) then
    begin
      if Styles.Selected.Data = nil then //style node selected
        LNode := Styles.Selected
      else
        LNode := Styles.Selected.Parent;
      s := GetStyleName(LNode);
      FStyleManager.ApplyStyle(FPreviewControl, s, cbCascade.Checked);
      Label2.Caption := 'Preview control: '+FPreviewControl.ClassName+' styled with '''+s+'''';
    end;
end;

procedure TfrmLMDStyleManProp.bttLoadFromFileClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    try
      FStyleManager.LoadFromFile(OpenDialog.FileName);
      BuildStylesTreeView;
    except
      on E: Exception do
      begin
        {!!!ElMessageDlg(E.Message, mtError, [mbOk], 0);
        FStyleManager.Clear;
        SetDataFromStyles;}
      end;
    end;
  end;
end;

procedure TfrmLMDStyleManProp.btnSaveToFileClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    FStyleManager.SaveToFile(SaveDialog.FileName);
end;

procedure TfrmLMDStyleManProp.btnAddStyleClick(Sender: TObject);
var
  LRoot, LTn: TTreeNode;
  s, msg: string;
begin
  LRoot := Styles.Selected;
  if Styles.Selected = nil then
    LRoot := FDefStyleNode
  else
    if LRoot.Data <> nil then
      LRoot := LRoot.Parent;
  if LMDInputDlg1.Execute then
    begin
      s := LMDInputDlg1.Value;
      s := trim(s);
      if not FStyleManager.IsValidStyleName(s) then
        messagebox(handle,pchar(IDS_INVALIDSTYLNAME), pchar(sMsgTitle),MB_ICONEXCLAMATION or MB_OK)
      else
        begin
          if (FindNode(Styles, s, LRoot) <> nil) then
            begin
              Msg := Format(IDS_STYLEEXISTS, [s]);
              messagebox(handle,pchar(msg), pchar(sMsgTitle),MB_ICONEXCLAMATION or MB_OK);
              exit;
            end;
          if not IsValidStylePlacement(LRoot, s, msg) then
            begin
              messagebox(handle,pchar(msg), pchar(sMsgTitle),MB_ICONEXCLAMATION or MB_OK);
              exit;
            end;
          LTn := Styles.Items.AddChild(LRoot, s);
          if s[1]=StylePrefix then
            begin
              if FStyleManager.IsStateStyle(s) then
                LTn.ImageIndex := StateStyleImageIndex
              else
                LTn.ImageIndex := UserStyleImageIndex
            end
          else
            LTn.ImageIndex := CompStyleImageIndex;
          FStyleManager.WritePropValue(GetStyleName(LTn), StyleKindStringID, 'integer', LTn.ImageIndex);
          LTn.SelectedIndex := LTn.ImageIndex;
          if cbStateStyles.Checked and IsValidStylePlacement(LTn,StateStyleNames[skMouseAbove], msg) then
            AddStateStyles(LTn);
        end
    end;
end;

procedure TfrmLMDStyleManProp.btnDeleteStyleClick(Sender: TObject);
begin
  if (Styles.Selected = nil) then
    messagebox(handle,pchar(IDS_SELECTSTYLEORPROP), pchar(sMsgTitle),MB_ICONEXCLAMATION or MB_OK)
  else
    DeleteStyleNode;
end;

procedure TfrmLMDStyleManProp.AddStateStyles(ATreeNode: TTreeNode);
var
  LNode: TTreeNode;
     sk: TLMDStateKind;
begin
  for sk := low(TLMDStateKind) to high(TLMDStateKind) do
    if (FindNode(Styles, StateStyleNames[sk], ATreeNode) = nil) then
      begin
        LNode := Styles.Items.AddChild(ATreeNode,StateStyleNames[sk]);
        LNode.ImageIndex := StateStyleImageIndex;
        LNode.SelectedIndex := LNode.ImageIndex;
      end
end;

procedure TfrmLMDStyleManProp.AdjustPreviewControl;
begin
  if FPreviewControl.Width > PreviewPanel.Width then
    FPreviewControl.Width := PreviewPanel.Width - 4;
  FPreviewControl.Left := PreviewPanel.Width div 2 - FPreviewControl.Width div 2;
  if FPreviewControl.Height > PreviewPanel.Height then
    FPreviewControl.Height := PreviewPanel.Height - 4;
  FPreviewControl.Top := PreviewPanel.Height div 2 - FPreviewControl.Height div 2;
end;

procedure TfrmLMDStyleManProp.PreviewPanelResize(Sender: TObject);
begin
  if FPreviewControl <> nil then
    AdjustPreviewControl;
end;

//finds ancestor style that doesn't begin with StylePrefix ('.')
function TfrmLMDStyleManProp.FindAncestorStyle(
  ANode: TTreeNode): string;
begin
  result := '';
  while (ANode.Parent <> nil) and (ANode.Text[1] = StylePrefix) do
    ANode := ANode.Parent;
  if (ANode <> nil) and (ANode <> FDefStyleNode) then
    result := ANode.Text;
end;

procedure TfrmLMDStyleManProp.DeleteStyleNode;
begin
  if Styles.Selected.Data = nil then
    begin
      //delete style
      if Styles.Selected.Text = sDefaultStyleName then
        messagebox(handle,pchar(IDS_CANTDELDEFSTYLE), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK)
      else
        if (cbConfirmDeletion.Checked and (MessageBox(handle,pchar(Format(IDS_DELSTYLEQUERY,[Styles.Selected.Text])), pchar(sMsgTitle),MB_ICONQUESTION or MB_YESNO)=ID_YES)) or
            not cbConfirmDeletion.Checked then
          begin
            FStyleManager.EraseStyle(GetStyleName(Styles.Selected));
            Styles.Items.Delete(Styles.Selected);
          end;
    end
  else
    //delete property
    if (cbConfirmDeletion.Checked and (MessageBox(handle,pchar(Format(IDS_DELPROPPQUERY,[Styles.Selected.Text])), pchar(sMsgTitle),MB_ICONQUESTION or MB_YESNO)=ID_YES)) or
        not cbConfirmDeletion.Checked then
      begin
        FStyleManager.EraseProperty(GetStyleName(Styles.Selected.Parent), GetFullPropName(Styles.Selected), TLMDPropListItem(Styles.Selected.Data).TypeName);
        if FEditorControl <> nil then
          FreeAndNil(FEditorControl);
        Styles.Items.Delete(Styles.Selected);
      end;
end;

procedure TfrmLMDStyleManProp.StylesKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Styles.IsEditing then
    exit;
  if Key <> VK_DELETE then
    exit;
  if Styles.Selected = nil then
    exit;
  DeleteStyleNode;
  FShiftState := [];
end;

function TfrmLMDStyleManProp.AllSubStylesValid(ANode: TTreeNode; var msg: string): boolean;
var
  i:integer;
  LNode: TTreeNode;
begin
  result := true;
  if ANode = nil then
    exit;
  if GetSubstyleCount(ANode) = 0 then
    exit
  else
    for i := 0 to ANode.Count - 1 do
      begin
        LNode := ANode.Item[i];
        if GetSubstyleCount(LNode) = 0 then
          result := IsValidStylePlacement(ANode, LNode.Text, msg)
        else
          result := AllSubStylesValid(LNode, msg);
        if not result then
          break;
      end;
end;

function TfrmLMDStyleManProp.IsValidStylePlacement(ANode: TTreeNode;
  AStyleName: string; var Msg: string): boolean;
var
  LClass, LAncestorClass: TPersistentClass;
  LNode: TTreeNode;
begin
  result := true;
  if ANode = nil then
    exit;
  if FStyleManager.IsStateStyle(ANode.Text) then
    begin
      result := false;
      Msg := IDS_STATESTYLECANTHAVESUBSTYLES;
      exit;
    end;
  if FStyleManager.IsStateStyle(AStyleName) then
    begin
      if FStyleManager.IsStateStyle(ANode.Text) then
        begin
          result := false;
          Msg := IDS_STATESUBSTYLINGNOTALLOWED;
        end
      else
        begin
          LNode := ANode.Parent;
          result := IsValidStylePlacement(LNode, AStyleName, Msg);
        end;
    end
  else
  if AStyleName[1]=StylePrefix then
    begin
      if AStylename = ANode.Text then
        begin
          result := false;
          Msg := IDS_SAMESTYLENAMENOTALLOWED;
        end
      else
        result := IsValidStylePlacement(ANode.Parent, AStyleName, Msg);
    end
  else
  if AStyleName[1]='T' then
    begin
      if AStylename = ANode.Text then
        begin
          result := false;
          Msg := IDS_SAMESTYLENAMENOTALLOWED;
        end
      else
        begin
          LClass := GetClass(AStyleName);
          LAncestorClass := GetClass(ANode.Text);
          if (LClass <> nil) and (LAncestorClass <> nil) then
            begin
              if not LClass.InheritsFrom(LAncestorClass) then
                begin
                  result := false;
                  Msg := Format(IDS_INVALIDSTYLEANCESTOR,[AStyleName, ANode.Text, LClass.ClassName, LAncestorClass.ClassName]);
                end
              else
                result := IsValidStylePlacement(ANode.Parent, AStyleName, Msg);
            end
              else
                result := IsValidStylePlacement(ANode.Parent, AStyleName, Msg);
        end
    end
end;

function TLMDPropList.GetCount: integer;
begin
  result := FProps.Count;
end;

procedure TfrmLMDStyleManProp.PropTreeCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if Node.Data <> nil then
    begin
      if IsNonGraphicClass(Node) then
        PropTree.Canvas.Font.Style := [fsBold];
    end
  else
    begin
      PropTree.Canvas.Font.Style := [];
      if (Pos('Custom', Node.Text) > 0) or
         (Pos('Base', Node.Text) > 0) then
        PropTree.Canvas.Font.Color:= clSilver
      else
        if not (cdsSelected in State) then
          PropTree.Canvas.Font.Color:= clWindowText;
    end;
end;

procedure TfrmLMDStyleManProp.PropTreeExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
var
  LNode: TTreeNode;
      j: integer;
begin
  if Node.Data <> nil then
    if TLMDPropListItem(Node.Data).TypeKind = tkClass then
      Node.DeleteChildren;
  for j := 0 to PropList.Count - 1 do
    if (PropList.Items[j].ContainerPropName = Node.Text) then
      if FindNode(PropTree, PropList.Items[j].PropertyName, Node) = nil then
        begin
          LNode := PropTree.Items.AddChildObject(Node, PropList.Items[j].PropertyName, PropList.Items[j]);
          if IsNonGraphicClass(PropList.Items[j]) then
            PropTree.Items.AddChild(LNode, 'Dummy');
        end
end;

function TfrmLMDStyleManProp.GetFullPropName(ANode: TTreeNode): string;
begin
  result := ANode.Text;
  if ANode.Data <> nil then
    while (ANode.Parent <> nil) and (ANode.Parent.Data <> nil) do
      begin
        ANode := ANode.Parent;
        result := ANode.Text + '.' + result;
      end;
end;

function TfrmLMDStyleManProp.GetTypedFullPropName(ANode: TTreeNode): string;
begin
  result := '';
  if ANode.Data <> nil then
    result := GetFullPropName(ANode) + TypeNameDelim + TLMDPropListItem(ANode.Data).TypeName;
end;

function TfrmLMDStyleManProp.IsNonGraphicClass(ANode: TTreeNode): boolean;
begin
  result := IsNonGraphicClass(TLMDPropListItem(ANode.Data));
end;

function TfrmLMDStyleManProp.IsNonGraphicClass(
  AItem: TLMDPropListItem): boolean;
begin
  result := false;
  if (AItem.TypeKind = tkClass) and
     (AItem.TypeName <> 'TBitmap') and
     (AItem.TypeName <> 'TIcon') then
    result := true;
end;

procedure TfrmLMDStyleManProp.cbUseBgrClick(Sender: TObject);
begin
  if cbUseBgr.Checked then
    PreviewPanel.ImageList := LMDBitmapList1
  else
    PreviewPanel.ImageList := nil;
end;

procedure TfrmLMDStyleManProp.btnOkClick(Sender: TObject);
begin
  if FEditorControl <> nil then
    begin
      SavePropValue;
      FreeAndNil(FEditorControl);
    end;
end;

procedure TfrmLMDStyleManProp.StylesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FShiftState := Shift;
end;

procedure TfrmLMDStyleManProp.cbStateStylesClick(Sender: TObject);
begin
  if cbStateStyles.Checked then
    if FCurPropNode <> nil then
      if not FStyleManager.IsStateStyle(FCurPropNode.Text) then
        AddStateStyles(FCurPropNode);
end;

procedure TfrmLMDStyleManProp.cbCascadeClick(Sender: TObject);
begin
  ApplyStyleToPreviewControl;
end;

procedure TfrmLMDStyleManProp.StylesEdited(Sender: TObject;
  Node: TTreeNode; var S: String);
var
  LParentFullName, ls, LMsg: string;
begin
  if not FStyleManager.IsValidStyleName(S) then
    begin
      messagebox(handle,pchar(IDS_INVALIDSTYLNAME), pchar(sMsgTitle),MB_ICONEXCLAMATION or MB_OK);
      S := FOldStyleName;
      exit;
    end;
  if not IsValidStylePlacement(Node.Parent, S, LMsg) then
    begin
      messagebox(handle,pchar(LMsg), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK);
      S := FOldStyleName;
      exit;
    end;
  LParentFullName := GetStyleName(Node.Parent);
  ls := '';
  if LParentFullName <> sDefaultStyleName then
    ls := LParentFullName + AncestorDelim;
  FStyleManager.RenameStyle(ls + FOldStyleName, ls + S);
  if S[1] <> StylePrefix then
    begin
      Node.ImageIndex := CompStyleImageIndex;
      Node.SelectedIndex := Node.ImageIndex;
    end;
end;

procedure TLMDPropList.Clear;
var
  i: integer;
begin
  for i:= 0 to FProps.Count - 1 do
    begin
      FProps.Objects[i].Free;
      FProps.Objects[i] := nil;
    end;
  FProps.Clear;
end;

procedure TfrmLMDStyleManProp.FormShow(Sender: TObject);
begin
  FillPropTree(pvgClassName);
  BuildStylesTreeView;
end;

procedure TfrmLMDStyleManProp.btnAddComponentClick(Sender: TObject);
var
  cl: TPersistentClass;
   s: string;
begin
  LMDInputDlg1.Prompt := 'Please enter component class name:';
  if LMDInputDlg1.Execute then
    begin
      s := LMDInputDlg1.Value;
      s := trim(s);
      cl := GetClass(s);
      if GetClass(s) <> nil then
        begin
          RegisterStyleMgrClass(cl, '');
          FillPropTree(pvgClassName);
        end
      else
        messagebox(handle,pchar(Format(IDS_CANTFINDCOMPONENTCLASS, [s])), pchar(sMsgTitle), MB_ICONEXCLAMATION);
    end;
  LMDInputDlg1.Prompt := 'Please enter style name:';
end;

procedure TfrmLMDStyleManProp.SavePropsToStyle(AComponent: TObject; ANode: TTreeNode; AStyleName: string);
var
  i: integer;
  lFPName: string;
  lObj: TObject;
begin
  for i := 0 to ANode.Count - 1 do
    with ANode.Item[i] do
      begin
        if Data = nil then
          continue;
        lFPName := GetFullPropName(ANode.Item[i]);
        case TLMDPropListItem(ANode.Item[i].Data).TypeKind  of
          tkInteger,
          tkEnumeration:
            FStyleManager.WritePropValue(AStyleName, lFPName, TLMDPropListItem(Data).TypeName, GetOrdProp(AComponent, ANode.Item[i].Text));
          tkFloat:
            FStyleManager.WritePropValue(AStyleName, lFPName, TLMDPropListItem(Data).TypeName, GetFloatProp(AComponent, ANode.Item[i].Text));
          tkSet:
            FStyleManager.WritePropValue(AStyleName, lFPName, TLMDPropListItem(Data).TypeName, GetSetProp(AComponent, ANode.Item[i].Text, true));
          tkChar, tkString, tkLString, tkWString:
            FStyleManager.WritePropValue(AStyleName, lFPName, TLMDPropListItem(Data).TypeName, GetStrProp(AComponent, ANode.Item[i].Text));
          tkClass:
            begin
              lObj := GetObjectProp(AComponent, ANode.Item[i].Text);
              if lObj <> nil then
                SavePropsToStyle(lObj, ANode.Item[i], AStyleName);
            end;
        end;
      end
end;

procedure TfrmLMDStyleManProp.btnCreateStyleClick(Sender: TObject);
var
  i: integer;
  cl: TClass;
  lHasChecked: boolean;
begin
  if Grouping[PVGrouping.ItemIndex] <> pvgClassName then
    exit;
  if (PropTree.Selected = nil) or (PropTree.Selected.Data <> nil) then
    begin
      messagebox(handle,pchar(IDS_SELECTCOMPONENT), pchar(sMsgTitle), MB_ICONEXCLAMATION or MB_OK);
      exit;
    end;
  cl := GetClass(PropTree.Selected.Text);

  LMDCheckListDlg1.Items.Clear;

  with FOwnerForm do
  for i := 0 to ComponentCount - 1 do
    if Components[i].InheritsFrom(cl) then
      LMDCheckListDlg1.Items.AddObject(Components[i].Name, Components[i]);

  if LMDCheckListDlg1.Execute then
    begin
      lHasChecked := false;
      for i := 0 to LMDCheckListDlg1.Items.Count - 1 do
        if LMDCheckListDlg1.Checked[i] then
          begin
            lHasChecked := true;
            break;
          end;
        if lHasChecked then
          begin
            FStyleManager.WritePropValue(PropTree.Selected.Text, StyleKindStringID, 'integer', 1);
            PropTree.Selected.Expand(true);
            FStyleManager.WritePropValue(PropTree.Selected.Text, StyleKindStringID, 'integer', 2);
            for i := 0 to LMDCheckListDlg1.Items.Count - 1 do
              if LMDCheckListDlg1.Checked[i] then
                SavePropsToStyle(LMDCheckListDlg1.Items.Objects[i], PropTree.Selected,  PropTree.Selected.Text + AncestorDelim + StylePrefix + LMDCheckListDlg1.Items[i]);
            BuildStylesTreeView;
          end;
    end;
end;

function TfrmLMDStyleManProp.GetSubStyleCount(ANode: TTreeNode): integer;
var
  i: integer;
begin
  result := 0;
  if ANode.Count = 0 then
    exit;
  for i := 0 to ANode.Count - 1 do
    if ANode.Item[i].Data = nil then
      result := result + 1;
end;

procedure TfrmLMDStyleManProp.fltEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key <> #13 then
    exit;
  FillPropTree(Grouping[PVGrouping.ItemIndex]);
end;

procedure TfrmLMDStyleManProp.fltEditCustomButtons0Click(Sender: TObject;
  index: Integer);
var
  lChar: char;
begin
  fltEdit.Text := '';
  lChar := #13;
  fltEditKeyPress(Sender, lChar);
end;

procedure TfrmLMDStyleManProp.fltEditChange(Sender: TObject);
begin
  fltEdit.CustomButtons.Items[0].Enabled := Length(fltEdit.Text) <> 0;
end;

initialization

  PropList := TLMDPropList.Create;

finalization

  FreeAndNil(PropList);

end.
