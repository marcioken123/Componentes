unit pLMDElStyleManProp;
{$I lmdcmps.inc}
{$J+}

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

pLMDElStyleManProp unit
-----------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses

  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  Typinfo,
  ExtCtrls,
  StdCtrls,
  ComCtrls,
  ImgList,
  LMDTypes,
  pLMDCst,
  ElIni,
  LMDStrings,
  ElFrmPers,
  ElXPThemedControl,
  ElEdits,
{$IFDEF LMD_UNICODE}
  LMDUnicodeStrings,
  LMDUnicode,
{$ENDIF}
  pLMDElStyleImageSelect,
  ElTreeInplaceEditors,
  LMDProcs,
  ElHeader,
  ElInputDlg,
  ElClrCmb,
  ElTreeStdEditors,
  ElPromptDlg,
  ElStyleMan,
  Buttons,
  ElVCLUtils,
  ElTree,
  ElTreeGrids,
  ElPopBtn,
  ElToolBar,
  ElPanel,
  ElCombos,
  ElBtnCtl,
  ElCLabel,
  ElLabel,
  ElSplit,
  ElTreeComboBox,
  ElTreeDTPickEdit,
  ElTreeMemoEdit,
  ElTreeSpinEdit,
  ElTreeBtnEdit,
  ElTreeColorCombo,
  ElTreeTreeComboEdit,
  ElComponent, ElCGControl;

type

  TElPropListItem = class;

  TfrmLMDElStyleManProp = class(TForm)
    Panel1: TElPanel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ElToolBar1: TElToolBar;
    btnLoadFromFile: TElToolButton;
    OkButton: TElPopupButton;
    CancelButton: TElPopupButton;
    btnSaveToFile: TElToolButton;
    ElToolButton3: TElToolButton;
    btnAddStyle: TElToolButton;
    btnAddProp: TElToolButton;
    btnDelete: TElToolButton;
    ElToolButton7: TElToolButton;
    LeftPanel: TElPanel;
    ElSplitter1: TElSplitter;
    gridProps: TElTreeStringGrid;
    ElPanel2: TElPanel;
    gridStyles: TElTreeStringGrid;
    ElLabel1: TElLabel;
    ElLabel2: TElLabel;
    inpComboEnum: TElTreeInplaceComboBox;
    inpComboBoolean: TElTreeInplaceComboBox;
    inpEditText: TElTreeInplaceEdit;
    inpEditInt: TElTreeInplaceSpinEdit;
    inpEditFloat: TElTreeInplaceFloatSpinEdit;
    inpComboColor: TElTreeInplaceColorCombo;
    inpComboSet: TElTreeInplaceTreeComboEdit;
    ElFormPersist1: TElFormPersist;
    ElIniFile1: TElIniFile;
    inpEditImage: TElTreeInplaceButtonEdit;
    inpDTPick: TElTreeInplaceDateTimePicker;
    ElPopupButton1: TElPopupButton;
    Panel2: TPanel;
    ElEdit1: TElEdit;
    procedure LoadClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure gridPropsItemFocused(Sender: TObject);
    procedure gridStylesItemFocused(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure gridPropsDblClick(Sender: TObject);
    procedure btnAddPropClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure inpComboBooleanBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpComboBooleanAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpComboColorAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpComboColorBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpDTPickAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpDTPickBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpEditFloatBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpEditFloatAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpEditIntBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpEditIntAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpEditTextBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpEditTextAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpComboEnumAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure inpComboEnumBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpComboSetBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpComboSetAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure btnAddStyleClick(Sender: TObject);
    procedure inpEditImageBeforeOperation(Sender: TObject;
      var DefaultConversion: Boolean);
    procedure inpEditImageAfterOperation(Sender: TObject; var Accepted,
      DefaultConversion: Boolean);
    procedure ImageButtonClick(Sender: TObject);
    procedure gridStylesCompareItems(Sender: TObject; Item1,
      Item2: TElTreeItem; var res: Integer);
    procedure gridStylesInplaceEditorNeeded(Sender: TObject;
      Item: TElTreeItem; SectionIndex: Integer;
      SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor);
    procedure ElPopupButton1Click(Sender: TObject);
    procedure ElEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    FStyleManager: TElStyleManager;
    FSM: TElStyleManager;
    SL: TStringList;
    RootStyleItem: TElTreeItem;
    ImageStream: TMemoryStream;
  protected

    procedure AddProperty;
    function GetDisplayValue(StyleName: string; Item: TElPropListItem): string;
    procedure inpComboSetItemChecked(Sender: TObject; Item: TElTreeItem);
    procedure UpdateButtons;
  public
    procedure SetData(StyleManager: TElStyleManager);
    procedure GetData(StyleManager: TElStyleManager);
    procedure SetDataFromStyles;
  end;

  TElStyleManEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TElPropListItem = class(TCollectionItem)
  protected
    FPropertyName: string;
    FTypeKind: TTypeKind;
    FTypeName: string;
    FAClassName: string;
  public
    property PropertyName: string read FPropertyName write FPropertyName;
    property TypeKind: TTypeKind read FTypeKind write FTypeKind;
    property TypeName: string read FTypeName write FTypeName;
    property AClassName: string read FAClassName write FAClassName;
  end;

  TElPropListCollection = class(TCollection)
  private
    FExclusions: TStringList;
  protected
    function GetItems(Index: Integer): TElPropListItem;
    procedure SetItems(Index: Integer; Value: TElPropListItem);
    function PropertyExcluded(PropName: string): Boolean;
  public
    function Add: TElPropListItem;
    constructor Create;
    function FindItemByName(const Name: string): TElPropListItem;
    destructor Destroy; override;
    procedure ExcludeProperty(PropName: string);
    property Items[Index: Integer]: TElPropListItem read GetItems write SetItems; default;
  end;

var
  PropList: TElPropListCollection;

procedure RegisterStyleMgrClass(AnObject: TPersistentClass; Prefix: string);

implementation

uses
  ElScrollbar,
  ElCheckCtl,
  ElDTPick,
  ElCalendar,
  ElCalendDlg,
  ElCalc,
  ElCalculatorEdit,
  ElGroupBox,
  ElCheckItemGrp,
  ElStatBar,
  ElSideBar,
  ElBiProgr,
  ElSpinBtn,
  ElBtnEdit,
  ElSpin,
  ElMaskEdit,
  ElCurrEdit,
  ElIPEdit,
  ElNameEdits,
  ElHotKey,
  ElListBox,
  ElDriveCombo,
  ElImgCombo,
  ElTreeCombo,
  ElMemoCombo,
  ElFontCombo,
  ElPgCtl,
  ElTrackBar,
  ElURLLabel,
  ElClock,
  ElScrollBox,
  ElExpBar,
  ElCaption,
  ElFlatCtl,
  ElAdvPanel,
  ElHTMLLbl,
  ElHTMLPanel,
  HTMLLbx,
  ElHTMLView,
  // dbugintf,
  ElFolderDlg,
  ElDailyTip;

{$R *.DFM}

const
  StyleMgrClassesRegistered: boolean = false;

procedure SendDebug(const S : string);
begin
  // dbugintf.SendDebug(s);
end;

procedure RegisterStyleMgrClass(AnObject: TPersistentClass; Prefix: string);
var
  i: integer;
  PropCount: Integer;
  Props: PPropList;
  PropName: string;
  Item: TElPropListItem;
  pTD: PTypeData;
begin

  ActivateClassGroup(Controls.TControl);
  if GetClass(AnObject.ClassName) = nil then
  begin
    SendDebug('Class not found ' + AnObject.ClassName);
    RegisterClass(AnObject);
    if GetClass(AnObject.ClassName) = nil then
    SendDebug('Failed to register ' + AnObject.ClassName);
  end
  else
    SendDebug('Class found ' + AnObject.ClassName);
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
          PropName := String(Props[i]^.Name);

          if Props[i]^.PropType^.Kind = tkClass then
          begin
            pTD := GetTypeData(Props[i]^.PropType^);

            if (not pTD^.ClassType.InheritsFrom(TStrings)) and
{$IFDEF LMD_UNICODE}
            (not pTD^.ClassType.InheritsFrom(TLMDWideStrings)) and
{$ENDIF}
            (not pTD^.ClassType.InheritsFrom(TBitmap)) and
              (not pTD^.ClassType.InheritsFrom(TIcon)) and
               // (not pTD^.ClassType.InheritsFrom(TCustomImageList)) and
            (pTD^.ClassType.InheritsFrom(TComponent) or (((Prefix <> 'CaptionSettings.') and (PropName = 'Font')) and (Prefix <> ''))) then
              Continue;

            if (not pTD^.ClassType.InheritsFrom(TStrings)) and
{$IFDEF LMD_UNICODE}
            (not pTD^.ClassType.InheritsFrom(TLMDWideStrings)) and
{$ENDIF}
            (not (pTD^.ClassType = TBitmap)) and
              (not (pTD^.ClassType = TIcon)) and
               // (not pTD^.ClassType.InheritsFrom(TCustomImageList)) and
            pTD^.ClassType.InheritsFrom(TPersistent) then
            begin
              RegisterStyleMgrClass(TPersistentClass(pTD^.ClassType), Prefix + PropName +
                '.');
              Continue;
            end;

            // Continue;
          end;

          if PropList.PropertyExcluded(PropName) then
            PropName := PropName + '|' + String(Props[i]^.PropType^.Name);

          Item := PropList.FindItemByName(Prefix + PropName);
          if Item <> nil then
          begin
            if (Item.TypeKind <> Props[i]^.PropType^.Kind) or
              (Item.TypeName <> String(Props[i]^.PropType^.Name)) then
            try
              if (Item.TypeKind <> Props[i]^.PropType^.Kind) then
              begin
                raise
                  Exception.CreateFmt('Class %s declares property %s as %s, but it''s already declared as %s', [AnObject.ClassName, PropName, GetEnumName(System.TypeInfo(TypInfo.TTypeKind),
                  Ord(Props[i]^.PropType^.Kind)),
                  GetEnumName(System.TypeInfo(TypInfo.TTypeKind),
                  Ord(Item.TypeKind))]);
              end;
              if (Item.TypeName <> String(Props[i]^.PropType^.Name)) then
              begin
                if not ((PropName = 'BevelInner') or (PropName = 'BevelOuter'))  then
                  raise
                    Exception.CreateFmt('Class %s declares property %s as %s, but it''s already declared as %s', [AnObject.ClassName, PropName, Props[i]^.PropType^.Name, Item.TypeName])
                  else
                    Continue;
              end;
            except
              on E: Exception do
              begin
                Application.ShowException(E);
                Continue;
              end;
            end;
          end
          else
            with PropList.Add do
            begin
              AClassName := AnObject.ClassName;
              PropertyName := Prefix + PropName;
              TypeKind := Props[i]^.PropType^.Kind;
              TypeName := String(Props[i]^.PropType^.Name);
            end;
        end;
      finally
        FreeMem(Props);
      end;
    end;
  end;

end;

function TElPropListCollection.Add: TElPropListItem;
begin
  result := TElPropListItem(inherited Add);
end;

constructor TElPropListCollection.Create;
begin
  inherited Create(TElPropListItem);
  FExclusions := TStringList.Create;
  FExclusions.Duplicates := dupIgnore;
  FExclusions.Sorted := true;
end;

function TElPropListCollection.GetItems(Index: Integer): TElPropListItem;
begin
  Result := TElPropListItem(inherited Items[Index]);
end;

procedure TElPropListCollection.SetItems(Index: Integer; Value:
  TElPropListItem);
begin
  inherited Items[index] := Value;
end;

function TElPropListCollection.FindItemByName(const Name: string):
TElPropListItem;
var
  i: integer;
  s: string;
begin
  Result := nil;
  s := lowercase(Name);
  for i := 0 to Count - 1 do
  begin
    if lowercase(Items[i].PropertyName) = S then
    begin
      result := Items[i];
      exit;
    end;
  end;
end;

function TElPropListCollection.PropertyExcluded(PropName: string): Boolean;
begin
  Result := FExclusions.IndexOf(Uppercase(PropName)) <> -1;
end;

destructor TElPropListCollection.Destroy;
begin
  FreeAndNil(FExclusions);
  inherited;
end;

procedure TElPropListCollection.ExcludeProperty(PropName: string);
begin
  FExclusions.Add(Uppercase(PropName));
end;

procedure TElStyleManEditor.ExecuteVerb(Index: Integer);
begin
  if not StyleMgrClassesRegistered then
  begin
    StyleMgrClassesRegistered := true;

    PropList.ExcludeProperty('Orientation');
    PropList.ExcludeProperty('Layout');
    PropList.ExcludeProperty('Increment');
    PropList.ExcludeProperty('LargeIncrement');
    PropList.ExcludeProperty('MaxValue');
    PropList.ExcludeProperty('MinValue');
    PropList.ExcludeProperty('Value');
    PropList.ExcludeProperty('CharCase');
    PropList.ExcludeProperty('PasswordChar');
    PropList.ExcludeProperty('Text');
    PropList.ExcludeProperty('ButtonCaption');
    PropList.ExcludeProperty('Options');
    PropList.ExcludeProperty('Style');
    PropList.ExcludeProperty('TabWidth');
    PropList.ExcludeProperty('Position');
    PropList.ExcludeProperty('Prompt');
    PropList.ExcludeProperty('Title');
    PropList.ExcludeProperty('DialogTitle');
    PropList.ExcludeProperty('CustomRootFolder');
    PropList.ExcludeProperty('StatusText');
    RegisterStyleMgrClass(TElScrollbar, '');
    RegisterStyleMgrClass(TElTree, '');
    RegisterStyleMgrClass(TElHeader, '');
    RegisterStyleMgrClass(TElCheckBox, '');
    RegisterStyleMgrClass(TElRadioButton, '');

    RegisterStyleMgrClass(TElDateTimePicker, '');

    RegisterStyleMgrClass(TElPanel, '');
    RegisterStyleMgrClass(TElCalendar, '');
    RegisterStyleMgrClass(TElGroupBox, '');
    RegisterStyleMgrClass(TElCheckGroup, '');
    RegisterStyleMgrClass(TElRadioGroup, '');
    RegisterStyleMgrClass(TElToolBar, '');
    RegisterStyleMgrClass(TElStatusBar, '');
    RegisterStyleMgrClass(TElSideBar, '');
    RegisterStyleMgrClass(TElBiProgressBar, '');

    RegisterStyleMgrClass(TElSpinButton, '');
    RegisterStyleMgrClass(TElPopupButton, '');
    RegisterStyleMgrClass(TElGraphicButton, '');
    //RegisterStyleMgrClass(TElGauge, '');
    //RegisterStyleMgrClass(TElHistogram, '');
    //RegisterStyleMgrClass(TElGraph, '');

    //RegisterStyleMgrClass(TElAdvancedEdit, '');
    //RegisterStyleMgrClass(TElAdvancedMemo, '');
    RegisterStyleMgrClass(TElEdit, '');
    RegisterStyleMgrClass(TElButtonEdit, '');

    RegisterStyleMgrClass(TElSpinEdit, '');
    RegisterStyleMgrClass(TElFloatSpinEdit, '');
    RegisterStyleMgrClass(TElMaskEdit, '');
    RegisterStyleMgrClass(TElCurrencyEdit, '');
    RegisterStyleMgrClass(TElIPEdit, '');
    RegisterStyleMgrClass(TElFileNameEdit, '');
    RegisterStyleMgrClass(TElFolderNameEdit, '');
    RegisterStyleMgrClass(TElHotKey, '');

    RegisterStyleMgrClass(TElCalculatorEdit, '');

    RegisterStyleMgrClass(TElColorCombo, '');
    RegisterStyleMgrClass(TElListBox, '');
    RegisterStyleMgrClass(TElComboBox, '');
    RegisterStyleMgrClass(TElDriveComboBox, '');
    //RegisterStyleMgrClass(TElAdvancedComboBox, '');
    //RegisterStyleMgrClass(TElAdvancedListBox, '');
    RegisterStyleMgrClass(TElImageComboBox, '');
    RegisterStyleMgrClass(TElTreeCombo, '');
    RegisterStyleMgrClass(TElMemoCombo, '');
    RegisterStyleMgrClass(TElFontComboBox, '');
    RegisterStyleMgrClass(TElPageControl, '');
    RegisterStyleMgrClass(TElTrackBar, '');
    RegisterStyleMgrClass(TElSplitter, '');
    RegisterStyleMgrClass(TElURLLabel, '');
    RegisterStyleMgrClass(TElClock, '');
    RegisterStyleMgrClass(TElLabel, '');
    RegisterStyleMgrClass(TElScrollBox, '');
    RegisterStyleMgrClass(TElExplorerBar, '');
    RegisterStyleMgrClass(TElFormCaption, '');
    RegisterStyleMgrClass(TElFlatController, '');
    RegisterStyleMgrClass(TElFlatMultiController, '');

    RegisterStyleMgrClass(TElAdvancedPanel, '');
    RegisterStyleMgrClass(TElHTMLLabel, '');
    RegisterStyleMgrClass(TElHTMLListBox, '');
    RegisterStyleMgrClass(TElHTMLComboBox, '');
    RegisterStyleMgrClass(TElHTMLView, '');
    RegisterStyleMgrClass(TElHTMLPanel, '');
    RegisterStyleMgrClass(TElPromptDialog, '');
    RegisterStyleMgrClass(TElFolderDialog, '');
    RegisterStyleMgrClass(TElDailyTipDialog, '');
    RegisterStyleMgrClass(TElCalendarDialog, '');
    RegisterStyleMgrClass(TElInputDialog, '');
    RegisterStyleMgrClass(TElCalculatorDialog, '');
  end;

  with TfrmLMDElStyleManProp.Create(Application) do
  try
    gridProps.HeaderSections[0].Text := 'Property name';
    gridProps.HeaderSections[1].Text := 'Property type';
    gridStyles.HeaderSections[0].Text := 'Style/Property name';
    gridStyles.HeaderSections[1].Text := 'Inheritance/Value';
    SetData(Component as TElStyleManager);
    if ShowModal = mrOk then
      begin
        GetData(Component as TElStyleManager);
        self.Designer.Modified;
      end;
  finally
    Free;
  end
end;

function TElStyleManEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Style Designer...';
  end;
end;

function TElStyleManEditor.GetVerbCount: Integer;
begin
  Result := 1
end;

procedure TfrmLMDElStyleManProp.LoadClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    try
      FStyleManager.LoadFromFile(OpenDialog.FileName);
      SetDataFromStyles;
    except
      on E: Exception do
      begin
        ElMessageDlg(E.Message, mtError, [mbOk], 0);
        FStyleManager.Clear;
        SetDataFromStyles;
      end;
    end;
  end;
end;

procedure TfrmLMDElStyleManProp.SaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    FStyleManager.SaveToFile(SaveDialog.FileName);
end;

procedure TfrmLMDElStyleManProp.SetData(StyleManager: TElStyleManager);
var
  i: integer;
  Item: TElPropListItem;
  TreeItem: TElTreeItem;
begin
  gridProps.Items.BeginUpdate;
  try
    for i := 0 to PropList.Count - 1 do
    begin
      Item := PropList[i];
      TreeItem := gridProps.Items.AddItem(nil);
      TreeItem.Text := Item.PropertyName;
      TreeItem.ColumnText.Add(Item.TypeName);
      TreeItem.AnObject := Item;
    end;
  finally
    gridProps.Items.EndUpdate;
  end;
  FStyleManager.Assign(StyleManager);
  FSM := StyleManager;
  SetDataFromStyles;
end;

procedure TfrmLMDElStyleManProp.GetData(StyleManager: TElStyleManager);
begin
  StyleManager.Assign(FStyleManager);
end;

procedure TfrmLMDElStyleManProp.gridPropsItemFocused(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TfrmLMDElStyleManProp.gridStylesItemFocused(Sender: TObject);
begin
  UpdateButtons;
end;

procedure TfrmLMDElStyleManProp.FormCreate(Sender: TObject);
begin
  FStyleManager := TElStyleManager.Create(nil);
  ElIniFile1.Path := LMDELPACK_REGISTRYPATH;
end;

procedure TfrmLMDElStyleManProp.FormDestroy(Sender: TObject);
begin
  FStyleManager.Free;
end;

procedure TfrmLMDElStyleManProp.gridPropsDblClick(Sender: TObject);
begin
  if Assigned(gridProps.ItemFocused) and Assigned(gridStyles.ItemFocused) then
    AddProperty;
end;

procedure TfrmLMDElStyleManProp.btnAddPropClick(Sender: TObject);
begin
  if Assigned(gridProps.ItemFocused) and Assigned(gridStyles.ItemFocused) then
    AddProperty;
end;

procedure TfrmLMDElStyleManProp.AddProperty;
var
  ParentStyle,
  NewStyle: TElTreeItem;
  PropName,
  StyleName: string;
  p: Pointer;
  function LookForStyle(ParentStyle: TElTreeItem; PropName: String): boolean;
  var
    i: integer;
  begin
    Result := False;
    for i := 0 to ParentStyle.Count - 1 do
    begin
      {$ifdef LMD_UNICODE}
      if LMDWideSameText(ParentStyle.Children[i].Text, PropName) then
      {$else}
      if LMDAnsiSameText(ParentStyle.Children[i].Text, PropName) then
      {$endif}
      begin
        Result := True;
        exit;
      end;
    end;
  end;

begin
  //NewStyle := nil;
  if gridStyles.ItemFocused.AnObject <> nil then
    ParentStyle := gridStyles.ItemFocused.Parent
  else
    ParentStyle := gridStyles.ItemFocused;

  PropName := TElPropListItem(gridProps.ItemFocused.AnObject).PropertyName;
  ///Temp := gridStyles.Items.LookForItem(ParentStyle, PropName, nil, -1, false, false, false, false, true);
  if LookForStyle(ParentStyle, PropName) then
  begin
    ElMessageDlg(Format('Property %s already defined in style %s.', [PropName, ParentStyle.Text]), mtError, [mbOk], 0);
    exit;
  end;

  StyleName := '\' + ParentStyle.Text;

  gridStyles.Items.BeginUpdate;
  try
    NewStyle := gridStyles.Items.AddChild(ParentStyle, PropName);
    NewStyle.AnObject := gridProps.ItemFocused.AnObject;
    case TElPropListItem(gridProps.ItemFocused.AnObject).TypeKind of
      tkSet:
        FStyleManager.Styles.WriteString(StyleName, PropName,
          '');
      tkEnumeration:
        FStyleManager.Styles.WriteInteger(StyleName, PropName,
          0);
      tkInteger:
        begin
          if TElPropListItem(gridProps.ItemFocused.AnObject).FTypeName = 'TColor'
            then
            FStyleManager.Styles.WriteColor(StyleName, PropName,
              clNone)
          else
            FStyleManager.Styles.WriteInteger(StyleName,
              PropName, 0);
        end;
      tkFloat:
        begin
          FStyleManager.Styles.WriteDouble(StyleName, PropName,
            0);
        end;
      tkChar,
        tkString,
        tkWString,
        tkLString:
        begin
          FStyleManager.Styles.WriteString(StyleName, PropName,
            '');
        end;
      tkClass:
        begin
          FStyleManager.Styles.WriteBinary(StyleName, PropName,
            p, 0);
        end;
    end;
    NewStyle.Parent.Expanded := true;
    NewStyle.Focused := true;

    NewStyle.ColumnText.Add(GetDisplayValue(ParentStyle.Text,
      TElPropListItem(gridProps.ItemFocused.AnObject)));
  finally
    gridStyles.Items.EndUpdate;
  end;
  if NewStyle <> nil then
    gridStyles.EnsureVisibleBottom(NewStyle);
end;

procedure TfrmLMDElStyleManProp.SetDataFromStyles;
var
  i, j: integer;
  Item: TElPropListItem;
  DefItem,
    AncItem,
    TreeItem: TElTreeItem;
  SL: TStringList;
  s: string;
begin
  RootStyleItem := nil;
  gridStyles.Items.Clear;
  gridStyles.Items.BeginUpdate;
  try
    SL := TStringList.Create;
    try
      FStyleManager.GetStyleNames(SL);
      // add all styles
      for i := 0 to SL.Count - 1 do
      begin
        TreeItem := gridStyles.Items.AddItem(nil);
        TreeItem.Text := SL[i];
      end;
      // find default style
      TreeItem := gridStyles.Items.LookForItem(nil, string(sDefaultStyleName), nil, -1,
        false, true, false, false, true);
      if treeItem = nil then
        raise Exception.Create('Failed to find root item');
      DefItem := TreeItem;
      DefItem.AllowEdit := false;
      RootStyleItem := DefItem;

      // group style items in the tree
      for i := 0 to SL.Count - 1 do
      begin
        s := FStyleManager.GetAncestorStyle(SL[i]);
        TreeItem := gridStyles.Items.LookForItem(nil, SL[i], nil, -1, false,
          true, false, false, true);
        AncItem := gridStyles.Items.LookForItem(nil, s, nil, -1, false, true,
          false, false, true);
        if (AncItem <> nil) and (not (AncItem.IsUnder(TreeItem))) then
        begin
          TreeItem.MoveTo(AncItem);
          TreeItem.ColumnText.Add(s);
        end
        else
        begin
          TreeItem.MoveTo(DefItem);
          if TreeItem <> DefItem then
            TreeItem.ColumnText.Add(sDefaultStyleName)
          else
            TreeItem.ColumnText.Add('');
        end;
      end;

      // enumerate styles
      i := 0;
      while i < gridStyles.Items.Count do
      begin
        TreeItem := gridStyles.Items.Item[i];
        if TreeItem.AnObject = nil then
        begin
          s := TreeItem.Text;
          SL.Clear;
          FStyleManager.GetProperties(S, SL);

          // add properties of the style
          for j := 0 to SL.Count - 1 do
          begin
            Item := PropList.FindItemByName(SL[j]);
            if Item <> nil then
            begin
              TreeItem.Expanded := true;
              AncItem := gridStyles.Items.AddItem(TreeItem);
              AncItem.AnObject := Item;
              AncItem.Text := Item.PropertyName;
              AncItem.ColumnText.Add(GetDisplayValue(S, Item));
            end;
          end;
        end;
        inc(i);
      end;
    finally
      SL.Free;
    end;
  finally
    gridStyles.Items.EndUpdate;
  end;
end;

function TfrmLMDElStyleManProp.GetDisplayValue(StyleName: string; Item: TElPropListItem): string;
var
  p: pointer;
  d: double;
  i: integer;
  c: TColor;
  AClass: TClass;
  TypeInfo: PTypeInfo;
  TypeData: PTypeData;
  PropInfo: PPropInfo;
  PropName: string;
  PropType: string;

  function QueryComponentClass(Info : PTypeInfo) : boolean;
  var p : PTypeData;
  begin
    p := GetTypeData(Info);
    result := (p^.ClassType.InheritsFrom(TComponent));
  end;
  begin
  PropName := Item.PropertyName;
  PropType := '';
  AClass := GetClass(Item.AClassName);

  if Pos('.', PropName) > 0 then
  begin
    PropName := Copy(PropName, Pos('.', PropName) + 1, Length(PropName));
    AClass := GetClass(Item.AClassName);
  end;

  if Pos('|', PropName) > 0 then
  begin
    PropType := Copy(PropName, Pos('|', PropName) + 1, Length(PropName));
    PropName := Copy(PropName, 1, Pos('|', PropName) - 1);
  end;
  case Item.TypeKind of
    tkEnumeration:
      begin
        result := '(Invalid value)';
        FStyleManager.Styles.ReadInteger('\' + StyleName,
          Item.PropertyName, 0, i);

        if AClass = nil then
        begin
          Result := result + #32 + Item.AClassName;
          exit;
        end;

        PropInfo := GetPropInfo(AClass.ClassInfo, PropName, tkAny);
        if PropInfo <> nil then
        begin
          TypeInfo := PropInfo^.PropType^;
          if TypeInfo <> nil then
          begin
            TypeData := GetTypeData(TypeInfo);
            if (TypeData <> nil) and LMDInRange(i, TypeData.MinValue,
              TypeData.MaxValue) then
              result := GetEnumName(PropInfo.PropType^, i);
              end;
        end;
      end;
    tkInteger:
      begin
        if Item.FTypeName = 'TColor' then
        begin
          FStyleManager.Styles.ReadColor('\' + StyleName,
            Item.PropertyName, clNone, c);
          result := ColorToString(c);
        end
        else
        begin
          FStyleManager.Styles.ReadInteger('\' + StyleName,
            Item.PropertyName, 0, i);
          result := IntToStr(i);
        end;
      end;
    tkFloat:
      begin
        FStyleManager.Styles.ReadDouble('\' + StyleName,
          Item.PropertyName, 0, d);
        if Item.FTypeName = 'TDateTime' then
          result := DateTimeToStr(d)
        else
          result := FloatToStr(d);
      end;
    tkChar,
      tkString,
      tkWString,
      tkLString:
      begin
        FStyleManager.Styles.ReadString('\' + StyleName,
          Item.PropertyName, '', result);
      end;
    tkClass:
      begin
        i := -1;
        FStyleManager.Styles.ReadBinary('\' + StyleName,
          Item.PropertyName, p, i);
        if i > 0 then
          result := '(' + Item.TypeName + ')'
        else
          result := '(none)';
      end;
    tkSet:
      begin
        FStyleManager.Styles.ReadString('\' + StyleName,
          Item.PropertyName, '', result);
      end;
  end;
end;

procedure TfrmLMDElStyleManProp.btnDeleteClick(Sender: TObject);
begin
  if gridStyles.ItemFocused <> nil then
  begin
    if (gridStyles.ItemFocused.AnObject = nil) and (gridStyles.ItemFocused <>
      Self.RootStyleItem) then
    begin
      if ElMessageDlg('Do you want to delete selected style?', mtWarning,
        [mbYes, mbNo], 0) = mrYes then
      begin
        FStyleManager.Styles.Delete('\' +
          gridStyles.ItemFocused.Text, '');
        gridStyles.Items.DeleteItem(gridStyles.ItemFocused);
      end;
    end
    else
      if (gridStyles.ItemFocused.AnObject <> nil) then
    begin
      if ElMessageDlg('Do you want to delete selected property?', mtWarning,
        [mbYes, mbNo], 0) = mrYes then
      begin
        FStyleManager.Styles.Delete('\' +
          gridStyles.ItemFocused.Parent.Text, gridStyles.ItemFocused.Text);
        gridStyles.Items.DeleteItem(gridStyles.ItemFocused);
      end;
    end;
  end;
end;

procedure TfrmLMDElStyleManProp.inpComboBooleanBeforeOperation(
  Sender: TObject; var DefaultConversion: Boolean);
var
  b: boolean;
begin
  with inpComboBoolean.Editor do
  begin
    Items.Clear;
    Items.Add('False');
    Items.Add('True');
  end;
  FStyleManager.Styles.ReadBool('\' +
    (inpComboBoolean.Item as TElTreeItem).Parent.Text, (inpComboBoolean.Item as TElTreeItem).Text, false, b);
  if b then
    inpComboBoolean.Editor.ItemIndex := 1
  else
    inpComboBoolean.Editor.ItemIndex := 0;
end;

procedure TfrmLMDElStyleManProp.inpComboBooleanAfterOperation(
  Sender: TObject; var Accepted, DefaultConversion: Boolean);
var
  b: boolean;
begin
  if Accepted then
  begin
    DefaultConversion := false;
    b := inpComboBoolean.Editor.ItemIndex = 1;
    FStyleManager.Styles.WriteBool('\' +
      (inpComboBoolean.Item as TElTreeItem).Parent.Text, (inpComboBoolean.Item as TElTreeItem).Text, b);
    inpComboBoolean.ValueAsText :=
      GetDisplayValue((inpComboBoolean.Item as TElTreeItem).Parent.Text,
      TElPropListItem((inpComboBoolean.Item as TElTreeItem).AnObject));
  end;
end;

procedure TfrmLMDElStyleManProp.inpComboColorAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    FStyleManager.Styles.WriteColor('\' +
      (inpComboColor.Item as TElTreeItem).Parent.Text, (inpComboColor.Item as TElTreeItem).Text,
      inpComboColor.Editor.SelectedColor);
    inpComboColor.ValueAsText := GetDisplayValue((inpComboColor.Item as TElTreeItem).Parent.Text,
      TElPropListItem((inpComboColor.Item as TElTreeItem).AnObject));
  end;
end;

procedure TfrmLMDElStyleManProp.inpComboColorBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  c: TColor;
begin
  inpComboColor.Editor.Options := [ccoNoColor, cco4BitColors, ccoSystemColors,
    ccoCustomChoice, ccoShowNames];
  FStyleManager.Styles.ReadColor('\' +
    (inpComboColor.Item as TElTreeItem).Parent.Text, (inpComboColor.Item as TElTreeItem).Text, clNone, c);
  inpComboColor.Editor.SelectedColor := c;
end;

procedure TfrmLMDElStyleManProp.inpDTPickAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    FStyleManager.Styles.WriteDouble('\' +
      (inpDTPick.Item as TElTreeItem).Parent.Text, (inpDTPick.Item as TElTreeItem).Text, inpDTPick.Editor.DateTime);
    inpDTPick.ValueAsText := GetDisplayValue((inpDTPick.Item as TElTreeItem).Parent.Text,
      TElPropListItem((inpDTPick.Item as TElTreeItem).AnObject));
  end;
end;

procedure TfrmLMDElStyleManProp.inpDTPickBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  d: double;
begin
  inpDTPick.Editor.ShowPopupCalendar := true;
  FStyleManager.Styles.ReadDouble('\' +
    (inpDTPick.Item as TElTreeItem).Parent.Text, (inpDTPick.Item as TElTreeItem).Text, Now, d);
  inpDTPick.Editor.DateTime := d;
end;

procedure TfrmLMDElStyleManProp.inpEditFloatBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  d: double;
begin
  FStyleManager.Styles.ReadDouble('\' +
    (inpEditFloat.Item as TElTreeItem).Parent.Text, (inpEditFloat.Item as TElTreeItem).Text, 0, d);
  inpEditInt.Editor.MaxValue := $7FFFFFFF;
  inpEditFloat.Editor.Value := d;
end;

procedure TfrmLMDElStyleManProp.inpEditFloatAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    FStyleManager.Styles.WriteDouble('\' +
      (inpEditFloat.Item as TElTreeItem).Parent.Text, (inpEditFloat.Item as TElTreeItem).Text,
      inpEditFloat.Editor.Value);
    inpEditFloat.ValueAsText := GetDisplayValue((inpEditFloat.Item as TElTreeItem).Parent.Text,
      TElPropListItem((inpEditFloat.Item as TElTreeItem).AnObject));
  end;
end;

procedure TfrmLMDElStyleManProp.inpEditIntBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  i: integer;
begin
  FStyleManager.Styles.ReadInteger('\' +
    (inpEditInt.Item as TElTreeItem).Parent.Text, (inpEditInt.Item as TElTreeItem).Text, 0, i);

  inpEditInt.Editor.MinValue := -2147483647;
  inpEditInt.Editor.MaxValue := $7FFFFFFF;
  inpEditInt.Editor.Value := i;
end;

procedure TfrmLMDElStyleManProp.inpEditIntAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    FStyleManager.Styles.WriteInteger('\' +
      (inpEditInt.Item as TElTreeItem).Parent.Text, (inpEditInt.Item as TElTreeItem).Text, inpEditInt.Editor.Value);
    inpEditInt.ValueAsText := GetDisplayValue((inpEditInt.Item as TElTreeItem).Parent.Text,
      TElPropListItem((inpEditInt.Item as TElTreeItem).AnObject));
  end;
end;

procedure TfrmLMDElStyleManProp.inpEditTextBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  s: string;
begin
  FStyleManager.Styles.ReadString('\' +
    (inpEditText.Item as TElTreeItem).Parent.Text, (inpEditText.Item as TElTreeItem).Text, '', s);
  inpEditText.Editor.Text := s;
end;

procedure TfrmLMDElStyleManProp.inpEditTextAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    FStyleManager.Styles.WriteString('\' +
      (inpEditText.Item as TElTreeItem).Parent.Text, (inpEditText.Item as TElTreeItem).Text,
      inpEditText.Editor.Text);
    inpEditText.ValueAsText := GetDisplayValue((inpEditText.Item as TElTreeItem).Parent.Text,
      TElPropListItem((inpEditText.Item as TElTreeItem).AnObject));
  end;
end;

procedure TfrmLMDElStyleManProp.inpComboEnumAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    DefaultConversion := false;
    FStyleManager.Styles.WriteInteger('\' +
      (inpComboEnum.Item as TElTreeItem).Parent.Text, (inpComboEnum.Item as TElTreeItem).Text,
      inpComboEnum.Editor.ItemIndex);
    inpComboEnum.ValueAsText := GetDisplayValue((inpComboEnum.Item as TElTreeItem).Parent.Text,
      TElPropListItem((inpComboEnum.Item as TElTreeItem).AnObject));
  end;
end;

procedure TfrmLMDElStyleManProp.inpComboEnumBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  TypeInfo: PTypeInfo;
  TypeData: PTypeData;
  AClass: TClass;
  i: integer;
  AName: string;
begin
  with inpComboEnum.Editor do
  begin
    Items.Clear;
    AClass := FindClass(TElPropListItem((inpComboEnum.Item as TElTreeItem).AnObject).AClassName);
    if AClass = nil then exit;
    AName := TElPropListItem((inpComboEnum.Item as TElTreeItem).AnObject).PropertyName;
    if Pos('.', AName) > 0 then
      Delete(AName, 1, Pos('.', AName));
    if Pos('|', AName) > 0 then
      Delete(AName, Pos('|', AName), Length(AName));

    TypeInfo := GetPropInfo(AClass.ClassInfo, AName, [tkEnumeration])^.PropType^;
    if TypeInfo = nil then exit;
    TypeData := GetTypeData(TypeInfo);
    for i := TypeData.MinValue to TypeData.MaxValue do
      Items.Add(GetEnumName(TypeInfo, i));

    FStyleManager.Styles.ReadInteger('\' +
      (inpComboEnum.Item as TElTreeItem).Parent.Text, (inpComboEnum.Item as TElTreeItem).Text, 0, i);
    if LMDInRange(i, TypeData.MinValue, TypeData.MaxValue) then
      ItemIndex := i
    else
      ItemIndex := 0;
  end;
end;

procedure TfrmLMDElStyleManProp.inpComboSetBeforeOperation(Sender: TObject; var DefaultConversion: Boolean);
var
  TypeInfo,
    TypeInfo2: PTypeInfo;
  TypeData: PTypeData;
  AClass: TClass;
  i, j: integer;
  b: boolean;
  AName,
    s,
    value: string;
  TreeItem: TElTreeItem;
begin
  SL := TStringList.Create; // this one will be used later, don't dispose of it
  with inpComboSet.Editor do
  begin

    AutoProcessSelection := false;
    ShowCheckBoxes := true;
    ShowRoot := false;
    ShowButtons := false;
    ShowImages := false;
    OnItemChecked := inpComboSetItemChecked;
    Items.Clear;
    AClass := FindClass(TElPropListItem((inpComboSet.Item as TElTreeItem).AnObject).AClassName);
    if AClass = nil then exit;
    AName := TElPropListItem((inpComboSet.Item as TElTreeItem).AnObject).PropertyName;
    if Pos('.', AName) > 0 then
      Delete(AName, 1, Pos('.', AName));
    if Pos('|', AName) > 0 then
      Delete(AName, Pos('|', AName), Length(AName));
    TypeInfo := GetPropInfo(AClass.ClassInfo, AName, [tkSet])^.PropType^;
    if TypeInfo = nil then exit;
    TypeData := GetTypeData(TypeInfo);
    TypeInfo2 := TypeData.CompType^;
    TypeData := GetTypeData(TypeInfo2);

    FStyleManager.Styles.ReadString('\' +
      (inpComboSet.Item as TElTreeItem).Parent.Text, (inpComboSet.Item as TElTreeItem).Text, '', value);
    SL.CommaText := Value;

    for i := TypeData.MinValue to TypeData.MaxValue do
    begin
      s := GetEnumName(TypeInfo2, i);
      TreeItem := Items.Add(nil, s);
      s := uppercase(s);
      TreeItem.ShowCheckBox := true;
      b := false;
      for j := 0 to SL.Count - 1 do
      begin
        if Uppercase(SL[j]) = s then
        begin
          b := true;
          break;
        end;
      end;
      TreeItem.Checked := b;
    end;
    i := 0;
    while i < SL.Count do
    begin
      if Items.LookForItem(nil, SL[i], nil, -1, false, true, false, false, true)
        = nil then
        SL.Delete(i)
      else
        inc(i);
    end;
  end;
end;

procedure TfrmLMDElStyleManProp.inpComboSetItemChecked(Sender: TObject; Item:
  TElTreeItem);
begin
  if Item.Checked then
    SL.Add(Item.Text)
  else
    if SL.IndexOf(Item.Text) <> -1 then
    SL.Delete(SL.IndexOf(Item.Text));
  inpComboSet.Editor.Text := SL.CommaText;
end;

procedure TfrmLMDElStyleManProp.inpComboSetAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
begin
  if Accepted then
  begin
    FStyleManager.Styles.WriteString('\' +
      (inpComboSet.Item as TElTreeItem).Parent.Text, (inpComboSet.Item as TElTreeItem).Text, SL.CommaText);
    inpComboSet.ValueAsText := GetDisplayValue((inpComboSet.Item as TElTreeItem).Parent.Text,
      TElPropListItem((inpComboSet.Item as TElTreeItem).AnObject));
  end;
  FreeAndNil(SL);
end;

procedure TfrmLMDElStyleManProp.btnAddStyleClick(Sender: TObject);
var
  ParentStyle,
    NewStyle: TElTreeItem;
  s: TLMDString;
  LookItem: TElTreeItem;
begin
  if gridStyles.ItemFocused <> nil then
  begin
    if gridStyles.ItemFocused.AnObject <> nil then
      ParentStyle := gridStyles.ItemFocused.Parent
    else
      ParentStyle := gridStyles.ItemFocused;
  end
  else
    ParentStyle := RootStyleItem;
  s := '';
  while true do
    if ElInputDlg.InputQuery('Style name', 'Please enter style name', S, false, false)
      then
    begin
      LookItem := nil;
      while (LookItem = nil) or (LookItem.AnObject <> nil) do
      begin
        LookItem := gridStyles.Items.LookForItem(LookItem, S, nil, -1, false,
          false, false, false, true);
        if LookItem = nil then break;
      end;
      if (LookItem = nil) then
        break
      else
      begin
        if ElMessageDlg('Style name should be unique. Re-enter?', mtError,
          [mbYes, mbNo], 0) = mrNo then exit;
      end;
    end
    else
      exit;
  if FStyleManager.Styles.OpenKey({'\' + ParentStyle.Text + }'\' +
    S, true) then
  begin
    FStyleManager.Styles.WriteString('', 'InheritsFrom',
      ParentStyle.Text);
    NewStyle := gridStyles.Items.AddChild(ParentStyle, S);
    NewStyle.ColumnText.Add('');
    NewStyle.Expanded := true;
    NewStyle.Focused := true;
    gridStyles.EnsureVisibleBottom(NewStyle);
  end
  else
  begin
    ElMessageDlg('Failed to add new style. Please try another name or contact ElPack support.', mtError, [mbOk], 0);
  end;
end;

procedure TfrmLMDElStyleManProp.UpdateButtons;
begin
  btnAddProp.Enabled := (gridProps.ItemFocused <> nil) and
    (gridStyles.ItemFocused <> nil);
  btnDelete.Enabled := gridStyles.ItemFocused <> nil;
end;

procedure TfrmLMDElStyleManProp.inpEditImageBeforeOperation(Sender: TObject;
  var DefaultConversion: Boolean);
var
  P: Pointer;
  i: integer;
begin
  inpEditImage.Editor.ButtonVisible := true;
  inpEditImage.Editor.AltButtonVisible := false;
  inpEditImage.Editor.ReadOnly := true;
  ImageStream := TMemoryStream.Create;

  i := -1;
  FStyleManager.Styles.ReadBinary('\' +
    (inpEditImage.Item as TElTreeItem).Parent.Text, (inpEditImage.Item as TElTreeItem).Text, p, i);
  if i > 0 then
  begin
    GetMem(P, i);
    FStyleManager.Styles.ReadBinary('\' +
      (inpEditImage.Item as TElTreeItem).Parent.Text, (inpEditImage.Item as TElTreeItem).Text, PChar(p)^, i);
    if i > 0 then
      ImageStream.WriteBuffer(pchar(p)^, i);
    ImageStream.Position := 0;
    FreeMem(p);
    end;
end;

procedure TfrmLMDElStyleManProp.ImageButtonClick(Sender: TObject);
var
  AClass: TClass;
  IT: TImageType;
begin
  AClass := FindClass(TElPropListItem((inpEditImage.Item as TElTreeItem).AnObject).AClassName);
  if AClass = TIcon then
    it := itIcon
  else
    it := itBitmap;

  with TStyleImageSelectForm.Create(nil) do
  try
    if ImageStream.Size > 0 then
    begin
      ImageStream.Position := 0;
      LoadFromStream(ImageStream, IT);
    end;

    if ShowModal = mrOk then
    begin
      ImageStream.Size := 0;
      SaveToStream(ImageStream, IT);
      if ImageStream.Size > 0 then
        inpEditImage.Editor.Text := '(' +
          TElPropListItem((inpEditImage.Item as TElTreeItem).AnObject).TypeName + ')'
      else
        inpEditImage.Editor.Text := '(none)';
    end;
  finally
    Free;
  end;
end;

procedure TfrmLMDElStyleManProp.inpEditImageAfterOperation(Sender: TObject;
  var Accepted, DefaultConversion: Boolean);
var
  P: Pointer;
  i: integer;
begin
  if Accepted then
  begin
    DefaultConversion := false;

    p := ImageStream.Memory;
    i := ImageStream.Size;
    FStyleManager.Styles.WriteBinary('\' +
      (inpEditImage.Item as TElTreeItem).Parent.Text, (inpEditImage.Item as TElTreeItem).Text, PChar(p)^, i);
    inpEditImage.ValueAsText := GetDisplayValue((inpEditImage.Item as TElTreeItem).Parent.Text,
      TElPropListItem((inpEditImage.Item as TElTreeItem).AnObject));
  end;
end;

procedure TfrmLMDElStyleManProp.gridStylesCompareItems(Sender: TObject;
  Item1, Item2: TElTreeItem; var res: Integer);
begin
  if (Item1.AnObject <> nil) = (Item2.AnObject <> nil) then
  begin
    res := AnsiCompareText(Item1.Text, Item2.Text);
  end
  else
  if Item1.AnObject = nil then
    res := -1
  else
  if Item2.AnObject = nil then
    res := 1;
end;

procedure TfrmLMDElStyleManProp.gridStylesInplaceEditorNeeded(
  Sender: TObject; Item: TElTreeItem; SectionIndex: Integer;
  SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor);
begin
  if (Item.Level = 0) then
    Editor := nil
  else
  begin
    case TElPropListItem(Item.AnObject).TypeKind of
      tkEnumeration:
        begin
          if TElPropListItem(Item.AnObject).TypeName = 'Boolean' then
            Editor := inpComboBoolean
          else
            Editor := inpComboEnum;
        end;
      tkInteger:
        begin
          if TElPropListItem(Item.AnObject).TypeName = 'TColor' then
            Editor := inpComboColor
          else
            Editor := inpEditInt;
        end;
      tkFloat:
        begin
          if TElPropListItem(Item.AnObject).TypeName = 'TDateTime' then
            Editor := inpDTPick
          else
            Editor := inpEditFloat;
        end;
      tkChar,
        tkString,
        tkWString,
        tkLString:
        begin
          Editor := inpEditText;
        end;
      tkClass:
        begin
          Editor := inpEditImage;
        end;
      tkSet:
        begin
          Editor := inpComboSet;
        end;
    end;
  end;
end;

procedure TfrmLMDElStyleManProp.ElPopupButton1Click(Sender: TObject);
begin
  FSM.Assign(FStyleManager);
end;

procedure TfrmLMDElStyleManProp.ElEdit1KeyPress(Sender: TObject;
  var Key: Char);
var
  i, l : integer;
begin
  if Key <> #13 then
    exit;
  l := length(ElEdit1.Text);
  gridProps.FilteredVisibility := false;
  if l = 0 then
    exit;
  for i := 0 to gridProps.Items.Count - 1 do
    gridProps.Items[i].Hidden := not LMDCheckWildCardMask(ElEdit1.Text, gridProps.Items[i].Text);
  gridProps.FilteredVisibility := true;
end;

initialization

  PropList := TElPropListCollection.Create;

finalization

  FreeAndNil(PropList);

end.
