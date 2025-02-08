unit LMDSctUnitFrame;
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

LMDSctUnitForm unit (YB)
-------------------------
LMD Script Pack Importer visualization related path for import working document.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, ExtCtrls, StdCtrls, ToolWin,  ActnList, Menus,
  ToolsApi, LMDXML, LMDSctImporterFileUtils, LMDSctImporterTree,
  LMDSctImporterUnitDoc, LMDSctDialects;

const
  WM_INITIALPARSE = WM_USER + 1;

type
  TLMDUnitFrame = class;
  ELMDUnitFrame = class(Exception);

  {*********************** class TLMDIDEModuleNotifier ************************}

  TLMDIDEModuleNotifier = class(TInterfacedObject, IOTANotifier,
                                IOTAModuleNotifier)
  private
    FFrame: TLMDUnitFrame;
  protected
    { IOTANotifier }

    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;

    { IOTAModuleNotifier }

    function  CheckOverwrite: Boolean;
    procedure ModuleRenamed(const NewName: string);
  public
    constructor Create(AFrame: TLMDUnitFrame);
  end;

  {************************ class TLMDUnitDocNotifier *************************}

  TLMDUnitDocNotifier = class(ILMDUnitDocNotifier)
  private
    FFrame: TLMDUnitFrame;
  public
    constructor Create(AFrame: TLMDUnitFrame);

    procedure Modified(Sender: TLMDUnitDocument); override;
    procedure AnalizeProgress(Sender: TLMDUnitDocument; ADeclsCount,
                              AAnalizedCount: Integer); override;
    function  PreprocessUsedUnit(Sender: TLMDUnitDocument; const AUnitName: string;
                                 out AUSUPath: string): Boolean; override;
    procedure UsedElemReferenced(Sender: TLMDUnitDocument; const AUnitName,
                                 AElemFullName: string); override;
  end;

  {********************* class TLMDUnitDocSourceProvider **********************}

  TLMDUnitDocSourceProvider = class(ILMDUnitDocSourceProvider)
  private
    FFrame: TLMDUnitFrame;
  protected
    function GetSource: string; override;
  public
    constructor Create(AFrame: TLMDUnitFrame);
  end;

  {*************************** class TLMDUnitFrame *****************************}

  ILMDUnitFrameTraits = interface
    procedure UpdateCaption;
    procedure OpenUsedUnit(const AUnitName: string);
    function  UseExternalMessageView: Boolean;
    procedure BeginImporting;
    procedure ImportingProgress(AProgress: Integer);
    procedure EndImporting(ASucceded: Boolean);
  end;

  TLMDUnitFrame = class(TFrame)
    TreeImages: TImageList;
    StateImages: TImageList;
    ToolBar1: TToolBar;
    ActionImages: TImageList;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    DocErrorsPanel: TPanel;
    DocErrorsListBox: TListBox;
    Label1: TLabel;
    NodeErrorsListBox: TListBox;
    MainPanel: TPanel;
    TreeView: TTreeView;
    ProgressBar: TProgressBar;
    ActionList: TActionList;
    CheckAllAction: TAction;
    UncheckAllAction: TAction;
    OptionsAction: TAction;
    PopupMenu: TPopupMenu;
    CheckAll1: TMenuItem;
    UncheckAll1: TMenuItem;
    Options1: TMenuItem;
    CheckAction: TAction;
    UncheckAction: TAction;
    UncheckUnsopportedAction: TAction;
    N2: TMenuItem;
    Uncheckallwitherrors1: TMenuItem;
    ExpandAction: TAction;
    CollapseAction: TAction;
    Expand1: TMenuItem;
    Collapse1: TMenuItem;
    N3: TMenuItem;
    StatusBar: TStatusBar;
    ExpandAllAction: TAction;
    CollapseAllAction: TAction;
    ExpandAll1: TMenuItem;
    CollapseAll1: TMenuItem;
    GenerateAction: TAction;
    N4: TMenuItem;
    ToolButton7: TToolButton;
    DetailsPanel: TPanel;
    Splitter3: TSplitter;
    DetailsGroupBox: TGroupBox;
    ToStringMemo: TMemo;
    ConstDetails: TPanel;
    Label3: TLabel;
    ConstTypeEdit: TEdit;
    Label2: TLabel;
    DocErrorsSplitter: TSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    SetConstTypeAction: TAction;
    Setconstantstype1: TMenuItem;
    ApplyHintsAction: TAction;
    Applyallhints1: TMenuItem;
    procedure TreeViewGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure DocErrorsListBoxDblClick(Sender: TObject);
    procedure TreeViewClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewDblClick(Sender: TObject);
    procedure CheckAllActionUpdate(Sender: TObject);
    procedure CheckAllActionExecute(Sender: TObject);
    procedure UncheckAllActionUpdate(Sender: TObject);
    procedure UncheckAllActionExecute(Sender: TObject);
    procedure OptionsActionUpdate(Sender: TObject);
    procedure OptionsActionExecute(Sender: TObject);
    procedure CheckActionUpdate(Sender: TObject);
    procedure CheckActionExecute(Sender: TObject);
    procedure UncheckActionUpdate(Sender: TObject);
    procedure UncheckActionExecute(Sender: TObject);
    procedure UncheckUnsopportedActionUpdate(Sender: TObject);
    procedure UncheckUnsopportedActionExecute(Sender: TObject);
    procedure ExpandActionUpdate(Sender: TObject);
    procedure ExpandActionExecute(Sender: TObject);
    procedure CollapseActionUpdate(Sender: TObject);
    procedure CollapseActionExecute(Sender: TObject);
    procedure ExpandAllActionUpdate(Sender: TObject);
    procedure ExpandAllActionExecute(Sender: TObject);
    procedure CollapseAllActionUpdate(Sender: TObject);
    procedure CollapseAllActionExecute(Sender: TObject);
    procedure GenerateActionUpdate(Sender: TObject);
    procedure GenerateActionExecute(Sender: TObject);
    procedure ConstTypeEditChange(Sender: TObject);
    procedure TreeViewChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToStringMemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetConstTypeActionUpdate(Sender: TObject);
    procedure SetConstTypeActionExecute(Sender: TObject);
    procedure ApplyHintsActionUpdate(Sender: TObject);
    procedure ApplyHintsActionExecute(Sender: TObject);
  private
    FEditor:          IOTASourceEditor;
    FTraits:          ILMDUnitFrameTraits;
    FIDENotifier:     IOTAModuleNotifier;
    FIDENotifierIdx:  Integer;
    FDocument:        TLMDUnitDocument;
    FDocNotifier:     ILMDUnitDocNotifier;
    FSourceProvider:  ILMDUnitDocSourceProvider;
    FDetailsNode:     TLMDPasNamedNode;
    FExpandedNodes:   TStringList;
    FSelectedNode:    string;
    FTopNode:         string;
    FUpdatingDetails: Boolean;
    FImporting:       Boolean;

    procedure WMInitialParse(var M: TMessage); message WM_INITIALPARSE;
    procedure SetTraits(const Value: ILMDUnitFrameTraits);
    function  GetNodeVisualPath(ANode: TTreeNode): string;
  protected
    {$IFNDEF LMDCOMP14}
    procedure SetParent(AParent: TWinControl); override;
    {$ELSE}
    procedure CreateHandle; override;
    procedure DestroyHandle; override;
    {$ENDIF}

    { TreeView filling }

    procedure FillTree;
    function  AddTreeNode(AParent: TTreeNode; const S: string;
                          AData: TLMDPasNamedNode): TTreeNode;
    function  GetNodeImage(APasNode: TLMDPasTreeNode): Integer;

    { TreeView expansion state }

    procedure SaveExpandedState;
    procedure RestoreExpandedState;

    { Node data getters }

    function GetViewNode(APasNode: TLMDPasTreeNode): TTreeNode;
    function GetPasNode(AViewNode: TTreeNode): TLMDPasTreeNode;

    { Visualization updating }

    procedure UpdateTreeStates;
    procedure UpdateNodeState(ANode: TTreeNode);
    procedure UpdateTree;
    procedure UpdateNodeErrors;
    procedure UpdateStatusBar;
    procedure UpdateDetails;
    procedure UpdateCaption;
    procedure UpdateAll;

    procedure FlushDetails;
    procedure ReportDocMessages;

    { Others }

    function  Parse: Boolean;
    function  Analize(GenWrapperFile: Boolean): Boolean;
    procedure CheckAll(AIsCheck: Boolean);
    procedure UncheckAllUnsupported;
    procedure SetStatusText(const S: string);
    procedure SetStateText(const S: string);
  public
    constructor Create(AOwner: TComponent;
                       AEditor: IOTASourceEditor); reintroduce;
    destructor Destroy; override;

    procedure Select(ANode: TLMDPasTreeNode); overload;
    procedure QueryInitialParse;

    property Editor: IOTASourceEditor read FEditor;
    property Traits: ILMDUnitFrameTraits read FTraits write SetTraits;
    property Document: TLMDUnitDocument read FDocument;
    property Caption;

    class function  FindWizard(AEditor: IOTASourceEditor): TLMDUnitFrame;
    class function  GetWizard(AEditor: IOTASourceEditor): TLMDUnitFrame;
    class procedure CloseAllWizards;
  end;

implementation

{$R *.dfm}

uses
  ComObj, LMDSctCst, LMDSctUnitOptionsForm;

{ ---------------------------------------------------------------------------- }

var
  Wizards: TList;

{************************ class TLMDIDEModuleNotifier *************************}
{ --------------------------------- protected -------------------------------- }

procedure TLMDIDEModuleNotifier.AfterSave;
begin
  FFrame.FlushDetails;
  FFrame.FDocument.Save;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDIDEModuleNotifier.BeforeSave;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDIDEModuleNotifier.Destroyed;
begin
  FFrame.Free;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDIDEModuleNotifier.Modified;
begin
  // Do nothing.
end;
                        
{ ---------------------------------------------------------------------------- }

function TLMDIDEModuleNotifier.CheckOverwrite: Boolean;
begin
  Result := True;
end;
                        
{ ---------------------------------------------------------------------------- }

procedure TLMDIDEModuleNotifier.ModuleRenamed(const NewName: string);
begin
  FFrame.FDocument.Renamed(FFrame.FEditor.FileName);
  FFrame.UpdateCaption;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDIDEModuleNotifier.Create(AFrame: TLMDUnitFrame);
begin
  inherited Create;
  FFrame := AFrame;
end;

{************************* class TLMDUnitDocNotifier **************************}
{ --------------------------------- protected -------------------------------- }

procedure TLMDUnitDocNotifier.Modified(Sender: TLMDUnitDocument);
begin
  FFrame.FEditor.Module.MarkModified;
end;

function TLMDUnitDocNotifier.PreprocessUsedUnit(Sender: TLMDUnitDocument;
  const AUnitName: string; out AUSUPath: string): Boolean;
begin
  Result := False;
end;

procedure TLMDUnitDocNotifier.UsedElemReferenced(Sender: TLMDUnitDocument;
  const AUnitName, AElemFullName: string);
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocNotifier.AnalizeProgress(Sender: TLMDUnitDocument;
  ADeclsCount, AAnalizedCount: Integer);
var
  val: Integer;
begin
  val := Trunc((AAnalizedCount / ADeclsCount) * 100);

  if FFrame.FImporting and (FFrame.FTraits <> nil) and
     FFrame.FTraits.UseExternalMessageView then
    FFrame.FTraits.ImportingProgress(val)
  else
  begin
    FFrame.ProgressBar.Position := val;
    FFrame.Update;
  end;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDUnitDocNotifier.Create(AFrame: TLMDUnitFrame);
begin
  inherited Create;
  FFrame := AFrame;
end;

{********************** class TLMDUnitDocSourceProvider ***********************}
{ --------------------------------- protected -------------------------------- }

function TLMDUnitDocSourceProvider.GetSource: string;
const
  bufsz = 1024;
var
  i:      Integer;
  rdr:    IOTAEditReader;
  readed: Integer;
  ressz:  Integer;
  growsz: Integer;
  curpos: Integer;
  buf:    array[0..bufsz] of {$IFDEF LMDCOMP12} Byte {$ELSE }Char {$ENDIF};
begin
  { Create source reader }

  rdr := FFrame.FEditor.CreateReader;

  { Read whole source text }

  Result := '';
  ressz  := 0;
  curpos := 0;

  while True do
  begin
    readed := rdr.GetText(curpos, @buf, bufsz);

    if readed <> 0 then
    begin
      if Length(Result) - ressz < readed then
      begin
        growsz := readed;
        if growsz < Length(Result) div 4 then
          growsz := Length(Result) div 4;
        SetLength(Result, ressz + growsz);
      end;

      for i := 0 to readed - 1 do
      begin
        Inc(ressz);
        Result[ressz] := {$IFDEF LMDCOMP12}Char{$ENDIF}(buf[i]);
      end;
    end
    else
      Break;
    Inc(curpos, readed);
  end;

  SetLength(Result, ressz); // Set real size.
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDUnitDocSourceProvider.Create(AFrame: TLMDUnitFrame);
begin
  inherited Create;
  FFrame := AFrame;
end;

{**************************** class TLMDUnitForm ******************************}
{ --------------------------------- published -------------------------------- }

procedure TLMDUnitFrame.TreeViewGetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  Node.ImageIndex    := GetNodeImage(GetPasNode(Node));
  Node.SelectedIndex := Node.ImageIndex;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.TreeViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  viewnd:  TTreeNode;
  pasnd:   TLMDPasTreeNode;
  nnode:   TLMDPasNamedNode;
  i:       Integer;
begin
  if Key = VK_SPACE then
  begin
    for i := 0 to TreeView.SelectionCount - 1 do
    begin
      viewnd := TreeView.Selections[i];

      if viewnd <> nil then
        pasnd := GetPasNode(viewnd)
      else
        pasnd := nil;

      if (pasnd <> nil) then
      begin
        nnode := TLMDPasNamedNode(pasnd);
        FDocument.NodeChecked[nnode] := not FDocument.NodeChecked[nnode];
      end;
    end;

    UpdateTreeStates;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.DocErrorsListBoxDblClick(Sender: TObject);
var
  i:  Integer;
  nd: TLMDPasTreeNode;
begin
  i := DocErrorsListBox.ItemIndex;

  if i <> -1 then
  begin
    nd := TLMDPasTreeNode(DocErrorsListBox.Items.Objects[i]);
    Select(nd);
  end;
end;
                              
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.TreeViewClick(Sender: TObject);
var
  pos:     TPoint;
  hittest: THitTests;
  viewnd:  TTreeNode;
  pasnd:   TLMDPasTreeNode;
begin
  GetCursorPos(pos);
  pos := TreeView.ScreenToClient(pos);
  hittest := TreeView.GetHitTestInfoAt(pos.X, pos.Y);
  viewnd  := TreeView.GetNodeAt(pos.X, pos.Y);
  pasnd   := GetPasNode(viewnd);

  if (pasnd <> nil) and (htOnStateIcon in hittest) then
  begin
    FDocument.NodeChecked[TLMDPasNamedNode(pasnd)] :=
      not FDocument.NodeChecked[TLMDPasNamedNode(pasnd)];
    UpdateTreeStates;
  end;
end;
                                       
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.ToStringMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  nd: TTreeNode;
begin
  if ((Key = VK_UP) or (Key = VK_DOWN)) and (ssCtrl in Shift) then
  begin
    nd := TreeView.Selected;
    if nd <> nil then
    begin
      if Key = VK_UP then
        nd := nd.GetPrev
      else
        nd := nd.GetNext;

      if nd <> nil then
      begin
        TreeView.ClearSelection;
        TreeView.Selected := nd;

        if TWinControl(Sender).CanFocus then
          TWinControl(Sender).SetFocus;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  UpdateDetails;
  UpdateNodeErrors;
  UpdateStatusBar;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.TreeViewDblClick(Sender: TObject);
var
  pasnd: TLMDPasTreeNode;
begin
  if FTraits <> nil then
  begin
    pasnd := GetPasNode(TreeView.Selected);

    if (pasnd <> nil) and (pasnd.GetNodeKind = tnkUsedUnit) then
      FTraits.OpenUsedUnit(TLMDPasUsedUnit(pasnd).Name);
  end;
end;
                                       
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.CheckAllActionUpdate(Sender: TObject);
begin
  CheckAllAction.Enabled := FDocument.Parsed;
end;
                                   
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.CheckAllActionExecute(Sender: TObject);
begin
  CheckAll(True);
end;
                                  
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UncheckAllActionUpdate(Sender: TObject);
begin
  UncheckAllAction.Enabled := FDocument.Parsed;
end;
                                
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UncheckAllActionExecute(Sender: TObject);
begin
  CheckAll(False);
end;
                                 
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.OptionsActionUpdate(Sender: TObject);
begin
  OptionsAction.Enabled := True;
end;
                                
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.OptionsActionExecute(Sender: TObject);
begin
  FlushDetails;
  TLMDUnitOptionsFrm.Execute(FDocument);
end;
                                 
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.CheckActionUpdate(Sender: TObject);
begin
  CheckAction.Enabled := (GetPasNode(TreeView.Selected) <> nil);
end;
                                
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.CheckActionExecute(Sender: TObject);
var
    i: Integer;
begin
  for i:=0 to TreeView.SelectionCount-1 do
    FDocument.NodeChecked[TLMDPasNamedNode(GetPasNode(
                          TreeView.Selections[i]))] := True;
  UpdateTreeStates;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UncheckActionUpdate(Sender: TObject);
begin
  UncheckAction.Enabled := (GetPasNode(TreeView.Selected) <> nil);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UncheckActionExecute(Sender: TObject);
var
    i: Integer;
begin
  for i:=0 to TreeView.SelectionCount-1 do
    FDocument.NodeChecked[TLMDPasNamedNode(GetPasNode(
                          TreeView.Selections[i]))] := False;
  UpdateTreeStates;
end;
                                       
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UncheckUnsopportedActionUpdate(Sender: TObject);
begin
  UncheckAllAction.Enabled := FDocument.Parsed;
end;
                                     
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UncheckUnsopportedActionExecute(Sender: TObject);
begin
  UncheckAllUnsupported;
end;
                                     
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.ExpandActionUpdate(Sender: TObject);
begin
  ExpandAction.Enabled := (TreeView.Selected <> nil) and
                          (TreeView.Selected.Count <> 0);
end;
                                  
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.ExpandActionExecute(Sender: TObject);
begin
  TreeView.Selected.Expand(True);
end;
                                 
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.CollapseActionUpdate(Sender: TObject);
begin
  ExpandAction.Enabled := (TreeView.Selected <> nil) and
                          (TreeView.Selected.Count <> 0);
end;
                                 
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.CollapseActionExecute(Sender: TObject);
begin
  TreeView.Selected.Collapse(True);
end;
                              
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.ExpandAllActionUpdate(Sender: TObject);
begin
  ExpandAllAction.Enabled := FDocument.Parsed;
end;
                             
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.ExpandAllActionExecute(Sender: TObject);
var
  i: Integer;
begin
  TreeView.Items.BeginUpdate;
  try
    for i := 0 to TreeView.Items.Count - 1 do
      TreeView.Items[i].Expand(True);
  finally
    TreeView.Items.EndUpdate;
  end;
end;
                            
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.CollapseAllActionUpdate(Sender: TObject);
begin
  CollapseAllAction.Enabled := FDocument.Parsed;
end;
                         
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.CollapseAllActionExecute(Sender: TObject);
var
  i: Integer;
begin
  TreeView.Items.BeginUpdate;
  try
    for i := 0 to TreeView.Items.Count - 1 do
      TreeView.Items[i].Collapse(True);
  finally
    TreeView.Items.EndUpdate;
  end;
end;
                       
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.GenerateActionUpdate(Sender: TObject);
begin
  GenerateAction.Enabled := not FDocument.IsLocked;
end;
                        
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.GenerateActionExecute(Sender: TObject);
var
  res: Boolean;
begin
  TreeView.Items.BeginUpdate;
  try
    res := False; // Initialize.

    if FTraits <> nil then
      FTraits.BeginImporting;
    FImporting := True;
    try
      res := Parse and Analize(True);
      ReportDocMessages;
    finally
      if FTraits <> nil then
        FTraits.EndImporting(res);
      FImporting := False;
    end;
  finally
    TreeView.Items.EndUpdate;
  end;
end;
                    
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.ConstTypeEditChange(Sender: TObject);
begin
  if not FUpdatingDetails then
    FDocument.MarkModified;
end;
                  
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.TreeViewChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  FlushDetails;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;

{ --------------------------------- protected -------------------------------- }

procedure TLMDUnitFrame.FillTree;
var
  i:          Integer;
  s:          string;
  pasUnit:    TLMDPasUnit;
  pntNode:    TTreeNode;
  udecl:      TLMDPasNamedNode;
  classes:    TList;
  interfaces: TList;
  procedures: TList;
  types:      TList;
  varconsts:  TList;
begin
  classes    := TList.Create;
  interfaces := TList.Create;
  procedures := TList.Create;
  types      := TList.Create;
  varconsts  := TList.Create;
  TreeView.Items.BeginUpdate;
  try
    pasUnit := FDocument.ParseTree;

    { Add units from 'uses' clause }

    pntNode := TreeView.Items.Add(nil, 'Uses');
    for i := 0 to pasUnit.Uses_.Count - 1 do
    begin
      s := pasUnit.Uses_[i].Name;
      AddTreeNode(pntNode, s, pasUnit.Uses_[i]);
    end;

    { Categorize unit declarations }

    for i := 0 to pasUnit.Declarations.Count - 1 do
    begin
      udecl := pasUnit.Declarations[i];
      case udecl.GetNodeKind of
        tnkTypeDecl:         case TLMDPasTypeDecl(udecl).Type_.GetNodeKind of
                               tnkClassType,
                               tnkClassRefType:  classes.Add(udecl);
                               tnkInterfaceType: interfaces.Add(udecl);
                             else
                               types.Add(udecl);
                             end;
        tnkProcHeading,
        tnkOverloadGroup:    procedures.Add(udecl);
        tnkConstDecl,
        tnkVarDecl:          varconsts.Add(udecl);
      else
        Assert(False);
      end;
    end;

    { Add interfaces }

    if interfaces.Count > 0 then
    begin
      pntNode := TreeView.Items.Add(nil, 'Interfaces');

      for i := 0 to interfaces.Count - 1 do
      begin
        s := TLMDPasTypeDecl(interfaces[i]).Name;
        AddTreeNode(pntNode, s, interfaces[i]);
      end;
    end;

    { Add procedures }

    if procedures.Count > 0 then
    begin
      pntNode := TreeView.Items.Add(nil, 'Procedures');

      for i := 0 to procedures.Count - 1 do
      begin
        s := TLMDPasNamedNode(procedures[i]).Name; // Can be overload group.
        AddTreeNode(pntNode, s, procedures[i]);
      end;
    end;

    { Add types }

    if types.Count > 0 then
    begin
      pntNode := TreeView.Items.Add(nil, 'Types');

      for i := 0 to types.Count - 1 do
      begin
        s := TLMDPasTypeDecl(types[i]).Name;
        AddTreeNode(pntNode, s, types[i]);
      end;
    end;

    { Add variables/constants }

    if varconsts.Count > 0 then
    begin
      pntNode := TreeView.Items.Add(nil, 'Variables/Constants');

      for i := 0 to varconsts.Count - 1 do
      begin
        s := TLMDPasNamedNode(varconsts[i]).Name;
        AddTreeNode(pntNode, s, varconsts[i]);
      end;
    end;

    { Add classes and metaclasses }

    for i := 0 to classes.Count - 1 do
    begin
      s := TLMDPasTypeDecl(classes[i]).Name;
      AddTreeNode(nil, s, classes[i]);
    end;
  finally
    classes.Free;
    interfaces.Free;
    procedures.Free;
    types.Free;
    varconsts.Free;
    TreeView.Items.EndUpdate;
  end;
end;
                            
{ ---------------------------------------------------------------------------- }

function TLMDUnitFrame.GetNodeImage(APasNode: TLMDPasTreeNode): Integer;
begin
  Result := 0; // Folder by default
  if APasNode <> nil then
    case APasNode.GetNodeKind of
      tnkUsedUnit:              Result := 1;
      tnkUnit:                  Result := 1;
      tnkConstDecl:             Result := 2;
      tnkTypeDecl:              Result := GetNodeImage(TLMDPasTypeDecl(APasNode).Type_);
      tnkVarDecl:               Result := 2;
      tnkProcHeading:           if TLMDPasProcHeading(APasNode).FuncKind in
                                    [ppkFunction, ppkClassFunction] then
                                  Result := 4
                                else
                                  Result := 3;
      tnkOverloadGroup:         Result := 3;
      tnkParameter:             Result := 2;
      tnkProperty:              if TLMDPasProperty(APasNode).IsProtected then
                                  Result := 10
                                else
                                  Result := 5;
      tnkPropertyRedecl:        Result := 6;
      tnkSubrangeType:          Result := 7;
      tnkTypeId:                Result := 7;
      tnkEnumType:              Result := 7;
      tnkPointerType:           Result := 7;
      tnkProcType:              Result := 7;
      tnkClassRefType:          Result := 7;
      tnkStaticArrayType:       Result := 7;
      tnkDynamicArrayType:      Result := 7;
      tnkSetType:               Result := 7;
      tnkFileType:              Result := 7;
      tnkRecordType:            Result := 7;
      tnkClassType:             Result := 8;
      tnkInterfaceType:         Result := 9;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.SaveExpandedState;
var
  i:    Integer;
  node: TTreeNode;
begin
  FExpandedNodes.Sorted := False; // Speed optimization.

  for i := 0 to TreeView.Items.Count - 1 do
  begin
    node := TreeView.Items[i];
    if node.Expanded then
      FExpandedNodes.Add(GetNodeVisualPath(node));
    if node.Selected then
      FSelectedNode := GetNodeVisualPath(node);
    if TreeView.TopItem = node then
      FTopNode := GetNodeVisualPath(node);
  end;
end;
                      
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.ReportDocMessages;
const
  MSG_KIND: array[TLMDUnitDocMessageKind] of string = (
    '',
    '[Parse Error] ',
    '[Info] ',
    '[Warning] ',
    '[Error] ');
var
  i:      Integer;
  m:      TLMDUnitDocMessage;
  erridx: Integer;
  nfohdr: Boolean;
begin
  if (FTraits <> nil) and FTraits.UseExternalMessageView then
    Exit;

  erridx := -1;
  nfohdr := False;

  DocErrorsListBox.Items.BeginUpdate;
  try
    DocErrorsListBox.Items.Clear;

    for i := 0 to FDocument.MessageCount - 1 do
      if FDocument.Messages[i].Kind <> mkInfo then
      begin
        m := FDocument.Messages[i];
        DocErrorsListBox.Items.AddObject(Format('%s%s', [MSG_KIND[m.Kind],
                                         m.Text]), m.Node);

        if (erridx = -1) and (m.Kind = mkError) then
          erridx := DocErrorsListBox.Items.Count - 1;
      end;

    for i := 0 to FDocument.MessageCount - 1 do
      if FDocument.Messages[i].Kind = mkInfo then
      begin
        if not nfohdr then
        begin
          DocErrorsListBox.Items.Add('Additional info:');
          nfohdr := True;
        end;

        m := FDocument.Messages[i];
        DocErrorsListBox.Items.AddObject(Format('  %s%s', [MSG_KIND[m.Kind],
                                         m.Text]), m.Node);
      end;

    if erridx <> -1 then
      DocErrorsListBox.ItemIndex := erridx;
  finally
    DocErrorsListBox.Items.EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.RestoreExpandedState;
var
  i:       Integer;
  s:       string;
  node:    TTreeNode;
  selnode: TTreeNode;
  topnode: TTreeNode;
begin
  FExpandedNodes.Sorted := True; // Speed optimization.

  selnode := nil;
  topnode := nil;

  for i := 0 to TreeView.Items.Count - 1 do
  begin
    node := TreeView.Items[i];
    s    := GetNodeVisualPath(node);

    if FExpandedNodes.IndexOf(s) <> -1 then
      node.Expand(False);

    if s = FSelectedNode then
      selnode := node;

    if s = FTopNode then
      topnode := node;
  end;

  if selnode <> nil then
    selnode.Selected := True;

  if topnode <> nil then
    TreeView.TopItem := topnode;

  FExpandedNodes.Clear; // Free memory.
end;
                           
{ ---------------------------------------------------------------------------- }

function TLMDUnitFrame.GetNodeVisualPath(ANode: TTreeNode): string;
begin
  if ANode <> nil then
  begin
    Result := ANode.Text;
    ANode  := ANode.Parent;

    while ANode <> nil do
    begin
      Result := ANode.Text + '.' + Result;
      ANode  := ANode.Parent;
    end;
  end
  else
    Result := '';
end;
                            
{ ---------------------------------------------------------------------------- }

function TLMDUnitFrame.GetViewNode(APasNode: TLMDPasTreeNode): TTreeNode;
begin
  if APasNode = nil then
    Result := nil
  else
    Result := TTreeNode(APasNode.V_Data);
end;
                                  
{ ---------------------------------------------------------------------------- }

function TLMDUnitFrame.GetPasNode(AViewNode: TTreeNode): TLMDPasTreeNode;
begin
  if AViewNode = nil then
    Result := nil
  else
    Result := TLMDPasTreeNode(AViewNode.Data);
end;
                                
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UpdateTreeStates;
var
  i: Integer;
begin
  TreeView.Items.BeginUpdate;
  try
    for i := 0 to TreeView.Items.Count -1 do
      UpdateNodeState(TreeView.Items[i]);
  finally
    TreeView.Items.EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.WMInitialParse(var M: TMessage);
begin
  if not FDocument.Parsed then
  begin
    if Parse then
      Analize(False);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UpdateNodeState(ANode: TTreeNode);
var
  pasnd: TLMDPasTreeNode;
  idx:   Integer;
begin
  pasnd := TLMDPasTreeNode(ANode.Data);

  idx := -1;
  if pasnd <> nil then
  begin
    case pasnd.C_SupportKind of
      skYes:     idx := 1;
      skNo:      idx := 3;
      skUnknown: idx := 2;
    end;
    if FDocument.NodeChecked[TLMDPasNamedNode(pasnd)] then
      idx := idx + 3;
  end;
  ANode.StateIndex := idx;
end;
                       
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UpdateTree;
begin
  TreeView.Items.BeginUpdate;
  try
    TreeView.Items.Clear;
    if FDocument.Parsed then
      FillTree;
  finally
    TreeView.Items.EndUpdate;
  end;
end;
                    
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UpdateNodeErrors;
var
  selnd: TLMDPasTreeNode;
begin
  selnd := GetPasNode(TreeView.Selected);
  if selnd <> nil then
    NodeErrorsListBox.Items := selnd.C_Messages
  else
    NodeErrorsListBox.Items.Clear;
end;
                          
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UpdateStatusBar;
var
  pasnd: TLMDPasTreeNode;
begin
  pasnd := GetPasNode(TreeView.Selected);
  if pasnd <> nil then
    SetStatusText(TLMDPasNamedNode(pasnd).ToStr)
  else
    SetStatusText('');

  if FDocument.LastAnalizeSucceds then
    SetStateText(SLMDDocFormOk)
  else
    SetStateText(SLMDDocFormFailed);
end;
                       
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UpdateDetails;
begin
  FDetailsNode     := TLMDPasNamedNode(GetPasNode(TreeView.Selected));
  FUpdatingDetails := True;
  try
    { Update to-string memo }

    if FDetailsNode <> nil then
      ToStringMemo.Lines.Text := TLMDPasNamedNode(FDetailsNode).ToStr
    else
      ToStringMemo.Lines.Text := SLMDDocFormNoSelection;

    { Update ConstDetails }

    if (FDetailsNode <> nil) and (FDetailsNode.GetNodeKind = tnkConstDecl) then
    begin
      ConstDetails.Visible  := True;
      ConstTypeEdit.Enabled := (TLMDPasConstDecl(FDetailsNode).Type_ = nil);

      if not ConstTypeEdit.Enabled then
        ConstTypeEdit.Text := TLMDPasConstDecl(FDetailsNode).Type_.ToStr
      else
        ConstTypeEdit.Text := FDocument.ConstTypeRepl[TLMDPasConstDecl(
                                                      FDetailsNode)];
    end
    else
      ConstDetails.Visible := False;
  finally
    FUpdatingDetails := False;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UpdateCaption;
begin
  Caption := 'LMD Script Unit Importer: ' +
             ExtractFileName(FEditor.FileName);
  if FTraits <> nil then
    FTraits.UpdateCaption;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UpdateAll;
begin
  UpdateTree;
  UpdateTreeStates;
  UpdateDetails;
  UpdateNodeErrors;
  UpdateStatusBar;
  UpdateCaption;
end;
                      
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.FlushDetails;
var
  s: string;
begin
  if FDetailsNode = nil then
    Exit;

  case FDetailsNode.GetNodeKind of
    tnkConstDecl:
    begin
      if TLMDPasConstDecl(FDetailsNode).Type_ = nil then
        s := ConstTypeEdit.Text
      else
        s := '';
      FDocument.ConstTypeRepl[TLMDPasConstDecl(FDetailsNode)] := s;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitFrame.Parse: Boolean;
var
  hflnm: string;
  hints: ILMDXmlDocument;
begin
  SetStateText(SLMDDocFormParsing);
  StatusBar.Update;

  TreeView.Items.BeginUpdate;
  try
    SaveExpandedState;
    FlushDetails;
    TreeView.Items.Clear;

    Result := FDocument.Parse;
    if Result then
    begin
      hflnm := TLMDFileHandler.GetVCLHintFileName;

      if FileExists(hflnm) then
      begin
        hints := LMDLoadXmlDocument(hflnm);
        FDocument.LoadHints(hints);
      end;
    end;

    UpdateAll;
    RestoreExpandedState;
  finally
    TreeView.Items.EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.QueryInitialParse;
begin
  if not FDocument.Parsed then
    PostMessage(Handle, WM_INITIALPARSE, 0, 0);
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitFrame.Analize(GenWrapperFile: Boolean): Boolean;
begin
  ProgressBar.Position := 0;
  try
    SetStateText(SLMDDocFormAnalizing);
    StatusBar.Update;

    FlushDetails;

    if FDocument.Parsed then
      Result := FDocument.Analize(GenWrapperFile)
    else
      Result := false;

    UpdateTreeStates;
    UpdateDetails;
    UpdateStatusBar;
  finally
    ProgressBar.Position := 0;
  end;

  if GenWrapperFile then
  begin
    (BorlandIDEServices as IOTAActionServices).ReloadFile(
      FDocument.WrapperUnitPath);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.ApplyHintsActionExecute(Sender: TObject);
begin
  FDocument.ApplyAllHints;
  UpdateTreeStates;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.ApplyHintsActionUpdate(Sender: TObject);
begin
  ApplyHintsAction.Enabled := FDocument.Parsed;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.CheckAll(AIsCheck: Boolean);
var
  i:     Integer;
  pasnd: TLMDPasTreeNode;
begin
  FlushDetails;
  for i := 0 to TreeView.Items.Count -1 do
  begin
    pasnd := TLMDPasTreeNode(TreeView.Items[i].Data);
    if pasnd <> nil then
      FDocument.NodeChecked[TLMDPasNamedNode(pasnd)] := AIsCheck;
  end;
  UpdateTreeStates;
end;
                                
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.UncheckAllUnsupported;
begin
  FlushDetails;

  FDocument.UncheckNodesWithErrors;
  UpdateTreeStates;
end;
                         
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.SetStatusText(const S: string);
begin
  StatusBar.Panels[1].Text := S;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.SetTraits(const Value: ILMDUnitFrameTraits);
begin
  if FTraits <> Value then
  begin
    FTraits := Value;

    if not (csDestroying in ComponentState) then
    begin
      DocErrorsListBox.Items.Clear;
      DocErrorsPanel.Visible    := (FTraits = nil) or
                                   not FTraits.UseExternalMessageView;
      DocErrorsSplitter.Visible := DocErrorsPanel.Visible;
      StatusBar.Visible         := DocErrorsPanel.Visible;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.Select(ANode: TLMDPasTreeNode);
var
  vnd: TTreeNode;
begin
  vnd := GetViewNode(ANode);

  if vnd <> nil then
  begin
    vnd.Selected := True;
    vnd.MakeVisible;

    if TreeView.CanFocus then
    begin
      TreeView.SetFocus;
      TreeView.Refresh;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.SetStateText(const S: string);
begin
  StatusBar.Panels[0].Text := S;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDUnitFrame.FindWizard(
  AEditor: IOTASourceEditor): TLMDUnitFrame;
var
  i: Integer;
begin
  for i := 0 to Wizards.Count - 1 do
    if TLMDUnitFrame(Wizards[i]).FEditor = AEditor then
    begin
      Result := TLMDUnitFrame(Wizards[i]);
      Exit;
    end;
  Result := nil;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDUnitFrame.Create(AOwner: TComponent;
  AEditor: IOTASourceEditor);
var
  notif: TLMDIDEModuleNotifier;
begin
  inherited Create(AOwner);

  FEditor                 := AEditor;
  FExpandedNodes          := TStringList.Create;
  FSourceProvider         := TLMDUnitDocSourceProvider.Create(Self);
  FDocument               := TLMDUnitDocument.Create(AEditor.FileName,
                                                     TLMDIDEDialectProvider.GetDialect,
                                                     FSourceProvider, False);
  TreeView.DoubleBuffered := True;

  notif           := TLMDIDEModuleNotifier.Create(Self);
  FIDENotifier    := notif;
  FIDENotifierIdx := FEditor.Module.AddNotifier(FIDENotifier);

  FDocNotifier := TLMDUnitDocNotifier.Create(Self);
  FDocument.AddNotifier(FDocNotifier);

  UpdateAll;
  Wizards.Add(Self);
end;

{$IFDEF LMDCOMP14}
procedure TLMDUnitFrame.CreateHandle;
begin
  inherited;
  if (TreeView <> nil) and (FDocument <> nil) then
  begin
    TreeView.Items.BeginUpdate;
    try
      UpdateTree;
      RestoreExpandedState;
    finally
      TreeView.Items.EndUpdate;
    end;
  end;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

destructor TLMDUnitFrame.Destroy;
begin
  Wizards.Remove(Self);

  if FIDENotifier <> nil then
  begin
    FEditor.Module.RemoveNotifier(FIDENotifierIdx);
    FIDENotifier := nil; // Release.
  end;

  if FDocNotifier <> nil then
  begin
    FDocument.RemoveNotifier(FDocNotifier);
    FDocNotifier.Free;
  end;

  FExpandedNodes.Free;
  FDocument.Free;
  FSourceProvider.Free;

  inherited;
end;

{ ---------------------------------------------------------------------------- }

{$IFDEF LMDCOMP14}
procedure TLMDUnitFrame.DestroyHandle;
begin
  SaveExpandedState;
  TreeView.Items.Clear;
  inherited;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

class function TLMDUnitFrame.GetWizard(
  AEditor: IOTASourceEditor): TLMDUnitFrame;
begin
  Result := FindWizard(AEditor);
  if Result = nil then
    Result := TLMDUnitFrame.Create(nil, AEditor);
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDUnitFrame.CloseAllWizards;
begin
  while Wizards.Count > 0 do
    TLMDUnitFrame(Wizards[0]).Free;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitFrame.AddTreeNode(AParent: TTreeNode; const S: string;
  AData: TLMDPasNamedNode): TTreeNode;
var
  td:   TLMDPasTypeDecl;
  rec:  TLMDPasRecordType;
  i:    Integer;
  cls:  TLMDPasClassType;
  itf:  TLMDPasInterfaceType;
  grp:  TLMDPasOverloadGroup;
  hint: string;
begin
  hint := FDocument.NodeHint[AData];
  if hint <> '' then
    hint := ' (Hint: ' + hint + ')';

  if AParent <> nil then
    Result := TreeView.Items.AddChildObject(AParent, S + hint, AData)
  else
    Result := TreeView.Items.AddObject(nil, S + hint, AData);

  if AData <> nil then
    TLMDPasTreeNode(AData).V_Data := Result;
  UpdateNodeState(Result);

  case AData.GetNodeKind of
    tnkTypeDecl:      begin
                        td := TLMDPasTypeDecl(AData);
                        case td.Type_.GetNodeKind of
                          tnkRecordType:
                          begin
                            rec := TLMDPasRecordType(td.Type_);
                            for i := 0 to rec.Members.Count - 1 do
                              AddTreeNode(Result, rec.Members[i].Name,
                                          rec.Members[i]);
                          end;
                          tnkClassType:
                          begin
                            cls := TLMDPasClassType(td.Type_);
                            for i := 0 to cls.Members.Count - 1 do
                              AddTreeNode(Result, cls.Members[i].Name,
                                          cls.Members[i]);
                          end;
                          tnkInterfaceType:
                          begin
                            itf := TLMDPasInterfaceType(td.Type_);
                            for i := 0 to itf.Members.Count - 1 do
                              AddTreeNode(Result, itf.Members[i].Name,
                                          itf.Members[i]);
                          end;
                        end;
                      end;
    tnkOverloadGroup: begin
                        grp := TLMDPasOverloadGroup(AData);
                        for i := 0 to grp.Procs.Count - 1 do
                          AddTreeNode(Result, grp.Procs[i].Name,
                                      grp.Procs[i]);
                      end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.SetConstTypeActionExecute(Sender: TObject);
var
  viewnd:  TTreeNode;
  pasnd:   TLMDPasTreeNode;
  cstdcl:  TLMDPasConstDecl;
  i:       Integer;
  s:       string;
begin
  FlushDetails;
  s := '';

  if InputQuery('Constant type', 'Enter conatant type', s) and
     (s <> '') then
  begin
    for i := 0 to TreeView.SelectionCount - 1 do
    begin
      viewnd := TreeView.Selections[i];

      if viewnd <> nil then
        pasnd := GetPasNode(viewnd)
      else
        pasnd := nil;

      if pasnd is TLMDPasConstDecl then
      begin
        cstdcl := TLMDPasConstDecl(pasnd);
        if cstdcl.Type_ = nil then
          FDocument.ConstTypeRepl[cstdcl] := s;

        UpdateDetails;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitFrame.SetConstTypeActionUpdate(Sender: TObject);
begin
  UncheckAllAction.Enabled := FDocument.Parsed and (TreeView.SelectionCount > 0);
end;

{ ---------------------------------------------------------------------------- }

{$IFNDEF LMDCOMP14}
procedure TLMDUnitFrame.SetParent(AParent: TWinControl);
begin
  if (AParent = nil) and (TreeView <> nil) then
  begin
    SaveExpandedState;
    TreeView.Items.Clear;
  end;

  inherited;

  if (TreeView <> nil) and (FDocument <> nil) then
  begin
    TreeView.Items.BeginUpdate;
    try
      UpdateTree;
      RestoreExpandedState;
    finally
      TreeView.Items.EndUpdate;
    end;
  end;
end;
{$ENDIF}

initialization
  Wizards := TList.Create;

{ ---------------------------------------------------------------------------- }

finalization
  TLMDUnitFrame.CloseAllWizards;
  Wizards.Free;
  Wizards := nil;

{ ---------------------------------------------------------------------------- }

end.
