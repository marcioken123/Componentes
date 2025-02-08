unit LMDDsgStructDlg;
{$I LmdCmps.inc}

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

LMDDsgStructDlg unit (YB)
------------------------
Module structure exploring dialog for debugging purposes.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ImgList, LMDDsgClass, LMDDsgModule,
  LMDDsgDesigner;

type
  {******************************** TLMDStructDlg *****************************}

  TLMDStructDlg = class(TForm)
    MessagesList: TListBox;
    Splitter1: TSplitter;
    TreeView: TTreeView;
    ImageList: TImageList;
    CurMessages: TListBox;
    Splitter2: TSplitter;
    StatusBar: TStatusBar;
    procedure MessagesListDblClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FModule: TLMDModule;
    FRoot:   TWinControl;

    function  DoAddCompNode(AComponent: TComponent; const S: string;
                            AParent: TTreeNode): TTreeNode;

    procedure AddHint(const AMessage: string; ANode: TTreeNode);
    procedure AddError(const AMessage: string; ANode: TTreeNode);

    function  MakeCompFlags(AState: TComponentState): string;
    procedure AddCompToTree(AComponent: TComponent; AParent: TTreeNode);
    procedure UpdateImageIndexes(ANode: TTreeNode);
    procedure UpdateCurMessages;
    procedure UpdateView;
  private
    FTmpChildren: TList;
    FCurRoot:     TComponent; // Root or frame.

    procedure AddChildProc(Child: TComponent);
    function  DispName(AComponent: TComponent): string;
    function  IsOwnedBy(AOwner, AComp: TComponent): Boolean;
    function  IsDirectChildOf(AParent, ARoot,
                              AComp: TComponent): Boolean; // Uses TComponent.GetChildren

    procedure AnalyzeChildControls(AParent: TWinControl; ANode: TTreeNode);
    procedure AnalyzeRoot(ANode: TTreeNode);
    procedure AnalyzeComp(AComponent: TComponent; ANode: TTreeNode);
  public
    constructor Create(AOwner: TComponent; AModule: TLMDModule); reintroduce;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

type
  TComponentAccess = class(TComponent);
     
{********************************* TLMDStructDlg ******************************}
{----------------------------------- published --------------------------------}

procedure TLMDStructDlg.MessagesListDblClick(Sender: TObject);
var
  nd: TTreeNode;
begin
  if MessagesList.ItemIndex <> -1 then
  begin
    nd := TTreeNode(MessagesList.Items.Objects[
      MessagesList.ItemIndex]);
    if nd <> nil then
      TreeView.Selected := nd;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDStructDlg.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  UpdateCurMessages;
end;
  
{------------------------------------------------------------------------------}

procedure TLMDStructDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Key := 0;
    ModalResult := mrCancel;
  end;
end;

{----------------------------------- private ----------------------------------}

function TLMDStructDlg.DoAddCompNode(AComponent: TComponent; const S: string;
  AParent: TTreeNode): TTreeNode;
begin
  Result := TreeView.Items.AddChildObject(AParent, s, AComponent);
end;
         
{------------------------------------------------------------------------------}

procedure TLMDStructDlg.AddHint(const AMessage: string;
  ANode: TTreeNode);
begin
  MessagesList.Items.AddObject('[Hint] ' + AMessage, ANode);
end;
     
{------------------------------------------------------------------------------}

procedure TLMDStructDlg.AddError(const AMessage: string;
  ANode: TTreeNode);
begin
  MessagesList.Items.AddObject('[Error] ' + AMessage, ANode);
end;
    
{------------------------------------------------------------------------------}

function TLMDStructDlg.MakeCompFlags(AState: TComponentState): string;

  procedure _AddFlag(const s: string; var r: string);
  begin
    if r <> '' then
      r := r + ',';
    r := r + s;
  end;

begin
  Result := '';

  if csInline in AState then
    _AddFlag('inline', Result);
  if csAncestor in AState then
    _AddFlag('ancestor', Result);

  if Result <> '' then
    Result := '{' + Result + '}';
end;
     
{------------------------------------------------------------------------------}

procedure TLMDStructDlg.AddCompToTree(AComponent: TComponent;
  AParent: TTreeNode);
var
  i:      Integer;
  s:      string;
  f:      string;
  nd:     TTreeNode;
  isroot: Boolean;
  oldrt:  TComponent;
begin
  { Make node caption }

  s := DispName(AComponent) + ': ' +  AComponent.ClassName;

  if AComponent is TControl then
  begin
    s := s + ', Parent: ';
    if TControl(AComponent).Parent <> nil then
      s := s + DispName(TControl(AComponent).Parent)
    else
      s := s + 'nil';
  end;

  f := MakeCompFlags(AComponent.ComponentState);
  if f <> '' then
    s := s + ', ' + f;

  { Add component node }

  nd     := DoAddCompNode(AComponent, s, AParent);
  isroot := (AComponent = FRoot) or (AComponent is TCustomFrame);

  oldrt := FCurRoot;
  try
    if isroot then
      FCurRoot := AComponent;

    { Analyze component }

    if AComponent = FRoot then
      AnalyzeRoot(nd)
    else
      AnalyzeComp(AComponent, nd);

    { Process children }

    if isroot then
    begin
      for i := 0 to AComponent.ComponentCount - 1 do
        if not (csSubComponent in AComponent.Components[i].ComponentStyle) then
          AddCompToTree(AComponent.Components[i], nd);
    end;
  finally
    FCurRoot := oldrt;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDStructDlg.UpdateImageIndexes(ANode: TTreeNode);
var
  i:    Integer;
  comp: TComponent;
begin
  comp := TComponent(ANode.Data);

  if comp = FRoot then
    ANode.ImageIndex := 0
  else if comp is TCustomFrame then
    ANode.ImageIndex := 1
  else if comp is TControl then
    ANode.ImageIndex := 2
  else
    ANode.ImageIndex := 3;

  for i := 0 to MessagesList.Items.Count - 1 do
    if MessagesList.Items.Objects[i] = ANode then
    begin
      if (Pos('[Hint]', MessagesList.Items[i]) <> 0) and
         (ANode.ImageIndex <= 4) then
        ANode.ImageIndex := 4
      else
        ANode.ImageIndex := 5;
    end;

  ANode.SelectedIndex := ANode.ImageIndex;

  for i := 0 to ANode.Count - 1 do
    UpdateImageIndexes(ANode[i]);
end;
     
{------------------------------------------------------------------------------}

procedure TLMDStructDlg.UpdateCurMessages;
var
  i:  Integer;
  nd: TTreeNode;
begin
  CurMessages.items.BeginUpdate;
  try
    CurMessages.items.Clear;

    nd := TreeView.Selected;
    if nd <> nil then
    begin
      for i := 0 to MessagesList.Items.Count - 1 do
        if MessagesList.Items.Objects[i] = nd then
          CurMessages.Items.Add(MessagesList.Items[i]);

      StatusBar.SimpleText := nd.Text;
    end
    else
      StatusBar.SimpleText := '';
  finally
    CurMessages.items.EndUpdate;
  end;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDStructDlg.UpdateView;
var
  s: string;
begin
  { Form caption }

  s := 'Module Structure of ' + DispName(FModule) + ', ModuleName = ';
  if FModule.ModuleName <> '' then
    s := s + FModule.ModuleName
  else
    s := s + '<Unnamed>';

  Caption := s;

  { Tree and messages }

  TreeView.Items.BeginUpdate;
  MessagesList.Items.BeginUpdate;
  try
    TreeView.Items.Clear;

    if FRoot <> nil then
    begin
      AddCompToTree(FRoot, nil);
      if TreeView.Items.Count <> 0 then
      begin
        TreeView.Items[0].Expand(True);
        UpdateImageIndexes(TreeView.Items[0]);
      end;
    end;

    UpdateCurMessages;
  finally
    TreeView.Items.EndUpdate;
    MessagesList.Items.EndUpdate;
  end;
end;

{----------------------------------- private ----------------------------------}

procedure TLMDStructDlg.AddChildProc(Child: TComponent);
begin
  if FTmpChildren <> nil then
    FTmpChildren.Add(Child);
end;
        
{------------------------------------------------------------------------------}

function TLMDStructDlg.DispName(AComponent: TComponent): string;
begin
  Result := AComponent.Name;
  if Result = '' then
    Result := '<Unnamed>';
end;
       
{------------------------------------------------------------------------------}

function TLMDStructDlg.IsOwnedBy(AOwner, AComp: TComponent): Boolean;
var
  cur: TComponent;
begin
  cur := AComp.Owner;
  while cur <> nil do
  begin
    if cur = AOwner then
    begin
      Result := True;
      Exit;
    end;
    cur := cur.Owner;
  end;

  Result := False;
end;
      
{------------------------------------------------------------------------------}

function TLMDStructDlg.IsDirectChildOf(AParent, ARoot,
  AComp: TComponent): Boolean;
var
  i:   Integer;
  old: TList;
begin
  Result := False;

  old          := FTmpChildren;
  FTmpChildren := TList.Create;
  try
    TComponentAccess(AParent).GetChildren(AddChildProc, ARoot);

    for i := 0 to FTmpChildren.Count - 1 do
      if TComponent(FTmpChildren[i]) = AComp then
      begin
        Result := True;
        Break; // for
      end;
  finally
    FTmpChildren.Free;
    FTmpChildren := old;
  end;
end;
      
{------------------------------------------------------------------------------}

procedure TLMDStructDlg.AnalyzeChildControls(AParent: TWinControl;
  ANode: TTreeNode);
var
  i: Integer;
begin
  for i := 0 to AParent.ControlCount - 1 do
  begin

    if not IsOwnedBy(AParent, AParent.Controls[i]) and // Not internal comp.
       not (csSubComponent in AParent.Controls[i].ComponentStyle) and
       (AParent.Controls[i].Owner <> FCurRoot) then
    begin
      AddError('Child control ''' + DispName(AParent.Controls[i]) +
               ''' must be owned by ''' + DispName(FCurRoot) + '''.',
               ANode);
    end;
  end;
end;
  
{------------------------------------------------------------------------------}

procedure TLMDStructDlg.AnalyzeRoot(ANode: TTreeNode);
begin
  if FRoot is TCustomForm then
  begin
    { Form-based roots }

    if FRoot.Parent <> nil then
      AddError('Root.Parent property must be set to ' +
               'nil at design-time.', ANode);
  end
  else
  begin
    { Non-form roots }

    if FRoot.ClassType = TPanel then // Just a common mistake.
      AddError('TPanel root class do not satisfy root class pre-requirests. ' +
               'Notification and GetChildren methods should be overriden.',
               ANode);

    if FRoot.Owner <> nil then
      AddError('Root.Owner property must be set to nil ' +
               'at design-time.', ANode);

    if (FRoot.Parent <> nil) and not LMDIsPlacedOnDesignPanel(FRoot) then
      AddError('Root.Parent property must be set to nil ' +
               'at design-time.', ANode);

    { Frames specific analyze }

    if (FRoot is TCustomFrame) and (csInline in FRoot.ComponentState) then
      AddError('Base-frame ''' + DispName(FRoot) +  ''' must not include ' +
               'csInline flag in ComponentState property.', ANode);
  end;

  AnalyzeChildControls(FRoot, ANode);
end;
     
{------------------------------------------------------------------------------}

procedure TLMDStructDlg.AnalyzeComp(AComponent: TComponent; ANode: TTreeNode);
begin
  if AComponent.Name = '' then
    AddError('The component must have a name.', ANode);

  if (AComponent <> FRoot) and (AComponent is TControl) then
  begin
    { Visual controls }

    if TControl(AComponent).Parent = nil then
      AddError('Control ''' + DispName(AComponent) +
               ''' Parent property is nil.', ANode);

    if AComponent is TWinControl then
      AnalyzeChildControls(TWinControl(AComponent), ANode);
  end
  else
  if (AComponent <> FRoot) and not (AComponent is TControl) then
  begin
    { Non-visual controls }

    if not IsDirectChildOf(FCurRoot, FCurRoot, AComponent) then
      AddError('Non-visual component ''' + DispName(AComponent) +  ''' is ' +
               'not reported as a child of the ''' + DispName(FCurRoot) +  '''; ' +
               'Probably you forget to override GetChildren method.', ANode);
  end;

  if (AComponent <> FRoot) and (AComponent is TCustomFrame) then
  begin
    { Frames specific analyze }

    if not (csInline in AComponent.ComponentState) then
      AddError('Frame-copy ''' + DispName(AComponent) +  ''' must include csInline ' +
               'flag in ComponentState property.', ANode);

    if FModule.GetFrameModuleName(TCustomFrame(AComponent)) =
                                                    AComponent.ClassName then
      AddHint('Frame-copy ''' + DispName(AComponent) +  ''' module name is equal ' +
              'to its class name; Probably frame module name was not assigned.',
              ANode);
  end;
end;

{----------------------------------- public -----------------------------------}

constructor TLMDStructDlg.Create(AOwner: TComponent; AModule: TLMDModule);
begin
  inherited Create(AOwner);
  FModule := AModule;
  FRoot   := AModule.Root;

  UpdateView;
end;
    
{------------------------------------------------------------------------------}

destructor TLMDStructDlg.Destroy;
begin
  inherited;
end;
   
{------------------------------------------------------------------------------}

end.
