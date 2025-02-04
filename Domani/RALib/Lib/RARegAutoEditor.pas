{***********************************************************
                R&A Library
       Copyright (C) 1996-99 R&A
       Portion copyright (C) Sergey Orlik

       description : Design-time Editor for TRegAuto component

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib.htm
************************************************************}

{$INCLUDE RA.INC}

unit RARegAutoEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RARegAuto, ExtCtrls, ComCtrls, Grids,
  Buttons, DsgnIntf {$IFDEF RA_D4H}, ImgList {$ENDIF RA_D4H}, Menus;

type

  TRegAutoEditor = class(TComponentEditor)
    function GetVerbCount : integer; override;
    function GetVerb(Index : integer) : string; override;
    procedure ExecuteVerb(Index : integer) ; override;
  end;

  TRegEditor = class(TForm)
    panelBottom: TPanel;
    panelTop: TPanel;
    panelOKCancelApply: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    panelButtons: TPanel;
    edtProp: TEdit;
    TreeImages: TImageList;
    Tree: TTreeView;
    btnAddProp: TSpeedButton;
    List: TListBox;
    PopupMenu1: TPopupMenu;
    Sort1: TMenuItem;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure btnAddPropClick(Sender: TObject);
    procedure ListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListClick(Sender: TObject);
    procedure TreeEnter(Sender: TObject);
    procedure ListDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure edtPropChange(Sender: TObject);
    procedure edtPropKeyPress(Sender: TObject; var Key: Char);
    procedure ListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sort1Click(Sender: TObject);
  private
    { Private declarations }
    Component : TRegAuto;
    FProps    : string;
    FModified : boolean;
    procedure Apply;
    procedure TreeLoad;
    procedure ListLoad;
    procedure PropAdd;
    procedure PropDelete;
    procedure WMGetMinMaxInfo(var M : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
    constructor Create1(AOwner: TComponent; lComponent : TComponent);
    property Modified : boolean read FModified;
  end;

var
  RegEditor: TRegEditor;

implementation

uses RAConst, TypInfo, ExptIntf, RADsgnIntf, iMTracer;

{$R *.DFM}

function TRegAutoEditor.GetVerbCount : integer;
begin
  Result := inherited GetVerbCount + 1;
end;

function TRegAutoEditor.GetVerb(Index : integer) : string;
begin
  if Index = GetVerbCount - 1 then
    Result := 'Editor' else
    Result := inherited GetVerb(Index);
end;

procedure TRegAutoEditor.ExecuteVerb(Index : integer);
begin
  if Index = GetVerbCount - 1 then begin
    RegEditor := TRegEditor.Create1(nil, Component);
    try
      RegEditor.ShowModal;
      if RegEditor.Modified then Designer.Modified;
    finally
      RegEditor.Free;
    end
  end else
    inherited ExecuteVerb(Index);
end;

type
  TLoadProgress = class(TForm)
    ProgressBar : TProgressBar;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    Canceled : boolean;
  end;
var
  LoadProgress: TLoadProgress;

const
// ������� �������� � TreeImages
  imUnknown     = 4;
  imClass       = 4;
  imInteger     = 1;
  imChar        = 1;
  imString      = 1;
  imEnumeration = 1;
  imComponent   = 3; //� ���� �������� ���������� ���������

function LoadProgressCreate : TLoadProgress;
begin
 {$IFDEF RA_D}
  Result := TLoadProgress.CreateNew(Application);
 {$ELSE}
  Result := TLoadProgress.CreateNew(Application, 1);
 {$ENDIF}
  with Result do begin
    OnClose := FormClose;
    Width  := 279; Height := 148;
    BorderStyle := bsDialog;
    Position := poScreenCenter;
    Caption := 'RARegAuto Editor';
    with TLabel.Create(Result) do begin
      Parent := Result;
      Caption := 'Reading RTTI';
      Left := 68;
      Top := 16;
      Font.Size := 10;
      Font.Style := [fsBold];
    end;
    with TButton.Create(Result) do begin
      Parent := Result;
      Left := 96; Top := 88;
      Caption := 'Cancel';
      OnClick := btnCancelClick;
    end;
    ProgressBar := TProgressBar.Create(Result);
    with ProgressBar do begin
      Parent := Result;
      SetBounds(7, 56, 257, 18);
    end;
    Canceled := false;
  end;
end;

procedure TLoadProgress.btnCancelClick(Sender: TObject);
begin
  Canceled := true;
end;

procedure TLoadProgress.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

constructor TRegEditor.Create1(AOwner: TComponent; lComponent : TComponent);
begin
  inherited Create(AOwner);
  Component := lComponent as TRegAuto;
  FProps    := Component.Props.Text;
  FModified := false;
end;

procedure TRegEditor.btnOkClick(Sender: TObject);
begin
  Apply;
  Close;
end;

procedure TRegEditor.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TRegEditor.Apply;
begin
  Component.Props := List.Items;
end;

procedure TRegEditor.FormShow(Sender: TObject);
begin
  LoadProgress := LoadProgressCreate;
  try
    LoadProgress.Show;
    TreeLoad;
  finally
    LoadProgress.Close;
  end;
  ListLoad;
end;

procedure TRegEditor.ListLoad;
begin
  List.Items.Assign(Component.Props);
end;

function IsEnabled(S : ShortString): boolean;
var P : integer;
begin
  P := Pos(#0, S);
  if (P = 0) or (Length(S) <= P) or (S[P+1] = 'N') then
    Result := false else
    Result := true;
end;

procedure TRegEditor.TreeLoad;
var
  i, j : integer;
  ANode : TTreeNode;
  TypeInf  : PTypeInfo;
  TypeData : PTypeData;
  PropList : PPropList;
  NumProps : word;
  AName    : string;
const
  SOrdType : array[0..5] of string =
    ('ShortInt', 'Byte', 'Integer', 'Word', 'Longint', 'Cardinal');
  SFloatType : array[0..4] of string =
    ('Single', 'Double', 'Extended', 'Comp', 'Curr');

  procedure AddToTree(ATypeInfo : PTypeInfo; Node : TTreeNode);
  var
    aPropList : PPropList;
    aNumProps : word;
    i        : integer;
    MyNode   : TTreeNode;
  begin
    TypeData := GetTypeData(ATypeInfo);
    MyNode := nil;
    with ATypeInfo^ do
      case Kind of
        tkUnknown    : begin MyNode :=
           Tree.Items.AddChild(Node, 'Unknown - ' + AName + #0+'N');
           MyNode.ImageIndex := imUnknown; //�������� - ������ ��������
        end;
        tkInteger    : begin MyNode :=
           Tree.Items.AddChild(Node, AName +' : '
             + SOrdType[Integer(TypeData^.OrdType)] + #0+'Y');
           MyNode.ImageIndex := imInteger; //�������� - ����� ��������
        end;
        tkFloat      : begin MyNode :=
           Tree.Items.AddChild(Node, AName +' : '
             + SFloatType[Integer(TypeData^.FloatType)] + #0+'Y');
           MyNode.ImageIndex := imInteger; //�������� - ����� ��������
        end;
        tkWChar,
        tkChar       : begin MyNode :=
           Tree.Items.AddChild(Node, AName +' : '
             + System.Copy(GetEnumName(TypeInfo(TTypeKind)
             , Integer(Kind)), 3, 255) + #0+'Y');
           MyNode.ImageIndex := imChar; //�������� - ����� ��������
        end;
        tkEnumeration : begin MyNode :=
           Tree.Items.AddChild(Node, AName +' : '
             + ATypeInfo^.Name + #0+'Y');
           MyNode.ImageIndex := imEnumeration; //�������� - ����� ��������
        end;
        tkString,
        tkLString{,
        tkWString}    : begin MyNode :=
           Tree.Items.AddChild(Node, AName +' : '
             + ATypeInfo^.Name +' ( '
             + Format('String[%d]', [TypeData^.MaxLength])
             +' )'  + #0+'Y');
           MyNode.ImageIndex := imString; //�������� - ����� ��������
        end;
        tkClass  : begin
          MyNode := Tree.Items.AddChild(Node, AName +' : '
            + TypeData^.ClassType.ClassName + #0+'N');
          MyNode.ImageIndex := imClass; //�������� ����� - ������ ��������
          aNumProps := TypeData^.PropCount;
          GetMem(aPropList, aNumProps*sizeof(pointer));
          try
            GetPropInfos(ATypeInfo, aPropList);
            for i := 0 to aNumProps-1 do begin
            AName := aPropList^[i]^.Name;
            {$IFDEF RA_D3H}
              AddToTree(aPropList^[i]^.PropType^, MyNode);
            {$ELSE}
              AddToTree(aPropList^[i]^.PropType, MyNode);
            {$ENDIF}
          end;
          finally
            FreeMem(aPropList, aNumProps*sizeof(pointer));
          end;
        end;
       // tkSet    // - ���� �� ��������������
      end;
    if MyNode <> nil then MyNode.SelectedIndex := MyNode.ImageIndex;
  end;

var
  Comp : TComponent;

  procedure LoadBitmap;
  var
    Pic, PicTmp : TBitmap;
    s : string;
  begin
    if not (csDesigning in ComponentState) then exit;
    Pic := TBitmap.Create;
    s := Comp.ClassName;
     try
       Pic.LoadFromResourceName(hInstance, UpperCase(pchar(s)));
     except
     end;
    if (Pic.Height <> 24) or (Pic.Width <> 24) then begin
      PicTmp := TBitmap.Create;
      PicTmp.Height := 24;
      PicTmp.Width  := 24;
      PicTmp.Canvas.Draw(0, 0, Pic);
      Pic.Free;
      Pic := PicTmp;
    end;
    TreeImages.AddMasked(Pic, clOlive);
    Pic.Free;
  end;

begin
  Tree.Items.BeginUpdate;
  try
  Tree.Items.Clear;
  LoadProgress.ProgressBar.Max := Component.Owner.ComponentCount+2;
  for j := -1 to Component.Owner.ComponentCount -1 do begin
    if j = -1 then
      Comp := Component.Owner else
      Comp := Component.Owner.Components[j];
   //__________________________
    LoadProgress.ProgressBar.Position := j+1;
    Application.ProcessMessages;
    if LoadProgress.Canceled then exit;
    ODS('Read ' + Comp.Name + ':' + Comp.ClassName);
   //__________________________
    LoadBitmap;
    ANode := Tree.Items.Add(nil, Comp.Name +' : '+ Comp.ClassName);
//    else ANode := Tree.Items.Add(nil, Component.Owner.Components[j].Name +' : '+ Component.Owner.Components[j].ClassName);
    ANode.ImageIndex := imComponent + j+1;
    ANode.SelectedIndex := ANode.ImageIndex;
    try
      if j = -1 then
        TypeInf  := Component.Owner.ClassInfo else
        TypeInf  := Component.Owner.Components[j].ClassInfo;
      AName := TypeInf^.Name;
      TypeData := GetTypeData(TypeInf);
      NumProps := TypeData^.PropCount;
      GetMem(PropList, NumProps*sizeof(pointer));
      try
        GetPropInfos(TypeInf, PropList);
        for i := 0 to NumProps-1 do begin
          AName := PropList^[i]^.Name;
          {$IFDEF RA_D3H}
            AddToTree(PropList^[i]^.PropType^, ANode);
          {$ELSE}
            AddToTree(PropList^[i]^.PropType, ANode);
          {$ENDIF}
        end;
      finally
        FreeMem(PropList, NumProps*sizeof(pointer));
      end;
    except
      on E : Exception do begin
        MessageDlg('Internal Error for ' + AName+':'+
          E.Message, mtError, [mbOk], 0);
        raise;
      end;
    end;{except}
  end;{for}
//  Tree.AlphaSort;
  finally
    Tree.Items.EndUpdate;
  end;
end;

procedure TRegEditor.FormResize(Sender: TObject);
begin
  edtProp.Width := panelButtons.Left - edtProp.Left*2-2;
end;

procedure TRegEditor.WMGetMinMaxInfo(var M : TWMGetMinMaxInfo);
begin
  inherited;
  M.MinMaxInfo^.ptMinTrackSize.X := panelOKCancelApply.Width + 15;
  M.MinMaxInfo^.ptMinTrackSize.Y := 200;
end;

procedure TRegEditor.TreeChange(Sender: TObject; Node: TTreeNode);
var
  Text, Text1 : string;
  P : integer;
begin
  if Node = nil then exit;
  Text := Node.Text;
  btnAddProp.Enabled := IsEnabled(Text);
  P := Pos(' ', Text);
  if P > 0 then Text := System.Copy(Text, 1, P-1);
  Node := Node.Parent;
  while Node <> nil do begin
    Text1 := Node.Text;
    P := Pos(' ', Text1);
    if P > 0 then Text1 := System.Copy(Text1, 1, P-1);
    Text := Text1 +'.'+Text;
    Node := Node.Parent;
  end;
  edtProp.Text := Text;
{  Ind := List.Items.IndexOf(edtProp.Text);
  if Ind <> -1 then List.ItemIndex := Ind;}
end;

procedure TRegEditor.btnAddPropClick(Sender: TObject);
var Ind : integer;
begin
  Ind := List.Items.IndexOf(edtProp.Text);
  if Ind = -1 then PropAdd
  else if ActiveControl = List then PropDelete
  else begin
    List.Items.Delete(Ind);
    List.ItemIndex := Ind;
  end;
end;

procedure TRegEditor.PropAdd;
begin
  if List.Items.IndexOf(edtProp.Text) = -1 then begin
    List.Items.Add(edtProp.Text);
    List.ItemIndex := List.Items.IndexOf(edtProp.Text);
  end;
end;

procedure TRegEditor.PropDelete;
var It : integer;
begin
  It := List.ItemIndex;
  List.Items.Delete(List.ItemIndex);
  if It > List.Items.Count-1 then dec(It);
  if It < 0 then It := 0;
  List.ItemIndex := It;
  if List.Items.Count <> 0 then
    edtProp.Text := List.Items[List.ItemIndex];
end;

procedure TRegEditor.ListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then PropDelete;
  if List.Items.Count <> 0 then
    edtProp.Text := List.Items[List.ItemIndex];
end;

procedure TRegEditor.ListClick(Sender: TObject);
begin
  edtProp.Text := List.Items[List.ItemIndex];
end;

procedure TRegEditor.TreeEnter(Sender: TObject);
begin
  TreeChange(Sender, Tree.Selected);
end;

procedure TRegEditor.ListDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Offset: Integer;	{ text offset width }
  BitmapIndex : integer;
  ComponentName : string[100];
  Obj : TComponent;
begin
  (Control as TListBox).Canvas.FillRect(Rect);	{ clear the rectangle }

  if Tree.Images <> nil then begin
    ComponentName := (Control as TListBox).Items[Index];
    ComponentName := Copy(ComponentName, 1, Pos('.', ComponentName)-1);
    if ComponentName = Component.Owner.Name then ComponentName := '';
    if ComponentName = '' then BitmapIndex := 0
    else begin
      Obj := Component.Owner.FindComponent(ComponentName);
      if Obj <> nil then BitmapIndex := Obj.ComponentIndex +1
      else BitmapIndex := imUnknown;
    end;
    inc(BitmapIndex, imComponent);

    TreeImages.Draw((Control as TListBox).Canvas, Rect.Left + 2, Rect.Top, BitmapIndex);
    Offset := TreeImages.width + 6; { add four pixels between bitmap and text }
  end
  else Offset := 2;
  (Control as TListBox).Canvas.TextOut(Rect.Left + Offset, Rect.Top, (Control as TListBox).Items[Index]);{ display the text }
//Note that the Rect parameter automatically provides the proper location of the item within the control's canvas.
end;


procedure TRegEditor.FormCreate(Sender: TObject);
begin
//  if Tree.Images = nil then List.Style := lbStandard;
 {$IFDEF RA_D3H}
  with TSplitter.Create(Self) do
  begin
    Parent := Self;
    Align := alLeft;
    Left := 201;
    Beveled := false;
    Visible := true;
  end;
 {$ENDIF RA_D3H}
  with TRegAuto.Create(Self) do begin
   {$IFDEF RA_D}
    RegPath := 'Software\Borland\Delphi\R&A\RARegAutoEditor';
   {$ENDIF RA_D}
   {$IFDEF RA_B}
    RegPath := 'Software\Borland\C++Builder\R&A\RARegAutoEditor';
   {$ENDIF RA_B}
    AutoMode := true;
    SaveWindowPlace := true;
    Props.Add('Tree.Width');
    Load;
  end;
  edtProp.Hint    := sRegAutoEditorEdtPropHint   ;
  Tree.Hint       := sRegAutoEditorTreeHint      ;
  List.Hint       := sRegAutoEditorListHint      ;
  btnAddProp.Hint := sRegAutoEditorBtnAddPropHint;
  Sort1.Caption   := sRegAutoEditorSort;
end;

procedure TRegEditor.edtPropChange(Sender: TObject);
var
  Ind : integer;
begin
  Ind := List.Items.IndexOf(edtProp.Text);
  if Ind <> -1 then List.ItemIndex := Ind;
end;

procedure TRegEditor.edtPropKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = ^M then begin
    btnAddPropClick(Sender);
    Key := #0;
  end;
end;

procedure TRegEditor.ListDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = Tree) and (List.Items.IndexOf(edtProp.Text) = -1);
end;

procedure TRegEditor.ListDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if (Source = Tree) and (List.Items.IndexOf(edtProp.Text) = -1) then
    btnAddPropClick(Self);
//  then PropAdd;
end;

procedure TRegEditor.TreeDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = List) and (List.Items.IndexOf(edtProp.Text) <> -1);
end;

procedure TRegEditor.TreeDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if (Source = List) and (List.Items.IndexOf(edtProp.Text) <> -1) then
    btnAddPropClick(Self);
//  then PropDelete;
end;

procedure TRegEditor.ListEnter(Sender: TObject);
begin
  btnAddProp.Enabled := true;
end;


procedure TRegEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FProps <> Component.Props.Text then FModified := true;
end;


procedure TRegEditor.Sort1Click(Sender: TObject);
begin
  List.Sorted := true;
//  List.Sorted := false;
end;

function GetProjectName: string;
begin
  if Assigned(ToolServices) then
    Result := ToolServices.GetProjectName else
    Result := '';
end;

initialization
  GetProjectNameProc := GetProjectName;
end.
