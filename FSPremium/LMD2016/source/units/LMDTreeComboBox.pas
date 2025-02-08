unit LMDTreeComboBox;
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

LMDTreeComboBox unit (JH)
-------------------------

ComboBox with a drop down tree control

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Controls,
  ComCtrls,
  Messages,
  LMDCustomExtCombo;

type
  TLMDTreeComboBox = class (TLMDCustomExtCombo)
  private
    FOld : String;
    FDropDownCount : Integer;

    procedure SetItems (aValue : TTreeNodes);
    function GetItems : TTreeNodes;
    procedure SetBoolean (index : Integer; aValue : Boolean);
    function GetBoolean (index : Integer) :  Boolean;
    function GetTreeView:TTreeView;
    function GetValue: String;
    procedure SetSValue(const Value: String);
    procedure SaveItemsToStream(AStream:TStream);
    procedure LoadItemsFromStream(AStream:TStream);
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
  protected
    procedure DoExpand (Sender : TObject; node : TTreeNode;var AllowExpansion: Boolean);
    procedure DoExpanded (Sender : TObject; node : TTreeNode);
    procedure DoClick (Sender : TObject);
    procedure DoDblClick (Sender : TObject);
    procedure CreateControl; override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;override;
    procedure DoDownKey;override;
    procedure DoUpKey;override;
    procedure ModifyControl; override;
    procedure ReModifyControl; override;
    procedure DisplayControl; override;
    procedure BeforeDropDown; override;
    procedure Cancel; override;
    procedure Accept; override;
    function GetControl : TWinControl; override;
    procedure Loaded; override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Init; override;
    // 7.11
    procedure Clear; override;
    // ----
    property TreeView:TTreeView read GetTreeView;
    property Value:string read GetValue write SetSValue;
  published
    property Items : TTreeNodes read GetItems write SetItems stored true;
    property DropDownCount : Integer read FDropDownCount write FDropDownCount default 8;
    property ShowLines : Boolean index 0 read GetBoolean write SetBoolean;
    property ShowRoot : Boolean index 1 read GetBoolean write SetBoolean;
    property HotTrack : Boolean index 2 read GetBoolean write SetBoolean;
    property RowSelect : Boolean index 3 read GetBoolean write SetBoolean;
    property AutoExpand : Boolean index 4 read GetBoolean write SetBoolean;
    property ShowButtons : Boolean index 5 read GetBoolean write SetBoolean;
    property DropDownWidth;
    property ReadOnly;
  end;

  TLMDLabeledTreeComboBox = class(TLMDTreeComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  Forms,
  Graphics,
  SysUtils,
  LMDGraph,
  LMDCustomMaskEdit;

{----------------------- private ----------------------------------------------}
procedure TLMDTreeComboBox.SetSValue(const Value: String);
begin
  inherited Text:=Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.SetBoolean (index : Integer; aValue : Boolean);
begin
  case index of
    0 : (FControl as TTreeView).ShowLines := aValue;
    1 : (FControl as TTreeView).ShowRoot := aValue;
    2 : (FControl as TTreeView).HotTrack := aValue;
    3 : (FControl as TTreeView).RowSelect := aValue;
    4 : (FControl as TTreeView).AutoExpand := aValue;
    5 : (FControl as TTreeView).Showbuttons := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.SetItems (aValue : TTreeNodes);
begin
  TTreeView(FControl).Items.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTreeComboBox.GetValue: String;
begin
  result:=AsString;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTreeComboBox.GetTreeView:TTreeView;
begin
  result:=TTreeView(FControl)
end;

{ ---------------------------------------------------------------------------- }
function TLMDTreeComboBox.GetItems : TTreeNodes;
begin
  result := TTreeView(FControl).Items;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTreeComboBox.GetBoolean (index : Integer) : Boolean;
begin
  case index of
    0 : result := (FControl as TTreeView).ShowLines;
    1 : result := (FControl as TTreeView).ShowRoot;
    2 : result := (FControl as TTreeView).HotTrack;
    3 : result := (FControl as TTreeView).RowSelect;
    4 : result := (FControl as TTreeView).AutoExpand;
    5 : result := (FControl as TTreeView).ShowButtons;
  else
    result := true;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.SaveItemsToStream(AStream:TStream);
var
 writer: TWriter;
 node: TTreeNode;
begin
  writer:=TWriter.Create(AStream,4096);
  try
    node:=TreeView.Items[0];
    writer.WriteListBegin;
    while node<> nil do
      begin
        writer.WriteInteger(node.level);
        writer.WriteString(node.Text);
        writer.WriteInteger(node.Imageindex);
        writer.WriteInteger(LongInt(node.data));
        node:= node.GetNext;
      end;
    writer.WriteListEnd;
    writer.FlushBuffer;
  finally
    writer.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.LoadItemsFromStream(AStream:TStream);
var
  reader: TReader;
  node: TTreenode;
  level: Integer;
begin
  with TreeView do
    begin
      Items.BeginUpdate;
      try
        Items.Clear;
        reader:=TReader.Create(AStream,4096);
        try
          node:=nil;
          reader.ReadListBegin;
          while not Reader.EndOfList do
            begin
              level:=reader.ReadInteger;
              If node=nil then
                node:=Items.Add( nil,'')
              else
                begin
                  If level=node.level then
                    node:=Items.Add(node,'')
                  else
                    if level>node.level then
                      node := Items.AddChild(node,'')
                    else
                      begin
                        while Assigned(node) and (level<node.level) do
                          node:=node.Parent;
                        node:=Items.Add(node,'');
                      end;
                end;
              node.Text:=Reader.ReadString;
              node.ImageIndex:=Reader.ReadInteger;
              node.Data:=Pointer(Reader.ReadInteger);
            end;
          reader.ReadListEnd;
        finally
          FreeAndNil(reader);
        end;
      finally
        Items.Endupdate;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.CMRecreateWnd(var Message: TMessage);
var
  ms: TMemoryStream;
begin
  ms:=nil;
  if Assigned(FControl) and (TreeView.Items.Count>0) then
      begin
         ms:=TMemoryStream.Create;
         SaveItemsToStream(ms);
         ms.Position:=0;
      end;
  inherited;
  if Assigned(FControl) and (ms<>nil) then
    begin
      LoadItemsFromStream(ms);
      FreeAndNil(ms);
    end;
end;

{ ----------------------- protected ------------------------------------------ }
procedure TLMDTreeComboBox.DoExpand (Sender : TObject; node : TTreeNode;var AllowExpansion: Boolean);
begin
  AllowExpansion:= true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.DoExpanded (Sender : TObject; node : TTreeNode);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.DoClick (Sender : TObject);
var
  MousePos : TPoint;
begin
  //get mouse pos
  GetCursorPos(MousePos);
  //convert screen mousepos to drop down controls client area
  Windows.ScreenToClient (FControl.Handle, MousePos);
  //check whether click occured on an item -> if not exit
  if not (htOnItem in (FControl as TTreeView ).GetHitTestInfoAt (mousePos.x, mousepos.y)) then
    exit;
  //we will get here if an item got clicked
  Close(true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.DoDblClick (Sender : TObject);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.CreateControl;
begin
  FControl := TTreeView.Create (self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTreeComboBox.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  result := inherited DoMouseWheel (Shift, WheelDelta, MousePos);
  if not result then
    begin
      if WheelDelta > 0 then
        DoUpKey
      else
        DoDownKey;
      result := true;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.DoDownKey;
var
  tmp:Integer;
begin
  tmp:=(FControl as TTreeView).Selected.Index ;
  if tmp<(FControl as TTreeView).Items.Count-1 then
    begin
      (FControl as TTreeView).Selected:=(FControl as TTreeView).Items[tmp+1];
      if not DroppedDown then
        Accept;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.DoUpKey;
var
  tmp:Integer;
begin
  tmp:=(FControl as TTreeView).Selected.Index ;
  if tmp>0 then
    begin
      (FControl as TTreeView).Selected:=(FControl as TTreeView).Items[tmp-1];
      if not DroppedDown then
        Accept;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTreeComboBox.GetControl : TWinControl;
begin
  result := TTreeView(FControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.ModifyControl;
begin
  with (FControl as TTreeView) do
    begin
      HideSelection := false;
      OnExpanding := DoExpand;
      OnClick := DoClick;
      OnDblClick := DoDblClick;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.ReModifyControl;
var
  c,
  h : Integer;
  r : TRect;
  t : TTreeNode;

  //this function iterates through all siblings of a node, and sums up
  //the nodes heights
  //if a node is expanded it will recursively call itself with the first child
  //node
  function getOpenHeight (node: TTreeNode): Integer;
  begin
    result := 0;
    if node = nil then exit;

    //iterate through all siblings, c # of items
    while (node <> nil) {and ((c < DropDownCount)and (DropDownCount <> -1))} do     // 13-May-2002 --> DropDownCount=0, so Recursion never occured before!
      begin
        inc(c); //inc number of items
        r := node.DisplayRect (false);
        result := result + r.Bottom - r.Top;
        if node.Expanded then //if a node is expanded
          result := result + getOpenHeight(node.getFirstChild);
        node := node.getNextSibling;
      end;
  end;

  function Min(v1, v2: Integer): Integer;
  begin
    result := v1;
    if v1 > v2 then result := v2;
  end;

begin
  if csLoading in ComponentState then exit;

  FControl.HandleNeeded;   // 13-May-2002 , Force update of inner control
  // Height
  if DropDownCount>-1 then
    begin
      h:=DropDownCount;
      if (FControl as TTreeView).Items.Count < DropDownCount then
        h := (FControl as TTreeView).Items.Count;
      if h=0 then h:=1; // minimum height
      h:=h*Canvas.TextHeight('Wq')+GetSystemMetrics(SM_CYHSCROLL);
    end
  else
    begin
       c := 0;
       if ((FControl as TTreeView).Items.GetFirstNode <> nil) then
         begin
           t := (FControl as TTreeView).Items.GetFirstNode;
           //h := 4{GetSystemMetrics (SM_CYEDGE) * 2}; //border of treeview control
           h := getOpenHeight(t)+GetSystemMetrics(SM_CYHSCROLL);
         end
       else
         h := Min((Items.Count+1), DropDownCount) * Canvas.TextHeight ('Wq')+GetSystemMetrics(SM_CYHSCROLL);
       //while h + Top + Height > Screen.Height do dec (h);
     end;
    FControl.Height := h+6;

  // Width
  if (DropDownWidth = 0) or ((FControl as TTreeView).Items.Count=0) then
    FControl.Width := Width
  else
    FControl.Width := DropDownWidth;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.DisplayControl;
begin
  SelectAll;
  //FControl.SetFocus; // --> not allowed, otherwise negative side effects
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.BeforeDropDown;
begin
  FOld := Text;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.Cancel;
begin
  Text := FOld;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.Accept;
begin
  if (FControl as TTreeView).Selected = nil then exit;
    Text := (FControl as TTreeView).Selected.Text;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.Loaded;
begin
  inherited Loaded;
  Init;
  //if Items.Count=0 then ;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDTreeComboBox.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  CreateAndSetup;
  FDropDownCount := 8;
  if csDesigning in ComponentState then
    FControl.Width := 0;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTreeComboBox.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.Init;
begin
  MaskType := meNone;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTreeComboBox.Clear;
begin
  TreeView.Items.Clear;
  inherited;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledTreeComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
