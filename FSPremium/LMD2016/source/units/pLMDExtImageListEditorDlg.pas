unit pLMDExtImageListEditorDlg;
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

pLMDExtImageListEditorDlg (VB)
------------------------------
This unit contains editor for TLMDGraphicList.

To-Do
-----
Gereralize other list editors using this template.
Correct editor update when item is updated via OI in D5

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignEditors, DesignWindows, DsnConst, DesignIntf, 
  Windows, Messages, SysUtils, Types, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ActnList, Menus, ClipBrd, ImgList, ExtCtrls, ExtDlgs, Variants,
  pLMDActionsData, LMDCustomImageList, LMDGraphicList, LMDPNGImage, LMDPNGImageList,
  LMDCustomComponent, LMDCustomIniComponent, LMDWndProcComponent, LMDFormPersistent,
  LMDBaseMRUList, LMDHookComponent, LMDFMDrop, LMDIniCtrl;

const
  Status : array[boolean] of string = ('Status: Unmodified', 'Status: Modified');

type
  TLMDExtImageListClassType = (icGraphicList, icPNGImageList);

type
  TLMDExtImageListEditorDlg = class(TDesignWindow)
    MainMenu: TMainMenu;
    ActionList: TActionList;
    actLoad: TAction;
    actSave: TAction;
    actOK: TAction;
    actPaste: TAction;
    File1: TMenuItem;
    Edit1: TMenuItem;
    ools1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton18: TToolButton;
    DetailsPanel: TPanel;
    Splitter1: TSplitter;
    actCut: TAction;
    actCopy: TAction;
    actDelete: TAction;
    actUp: TAction;
    actDown: TAction;
    actSelectAll: TAction;
    actClearAll: TAction;
    actSaveSelection: TAction;
    StatusBar: TStatusBar;
    ItemViewPanel: TPanel;
    actMultiline: TAction;
    actAddItem: TAction;
    actAddMultipleItems: TAction;
    Load1: TMenuItem;
    Save1: TMenuItem;
    OK1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    N1: TMenuItem;
    Up1: TMenuItem;
    Down1: TMenuItem;
    N2: TMenuItem;
    Selectall1: TMenuItem;
    Clearall1: TMenuItem;
    N3: TMenuItem;
    Saveas1: TMenuItem;
    Addmultipleitems1: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    OpenPictureDialog: TOpenPictureDialog;
    SavePictureDialog: TSavePictureDialog;
    ScrollBox: TScrollBox;
    ImageView: TImage;
    ItemTreeView: TTreeView;
    ToolButton17: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    actZoomIN: TAction;
    actZoomOut: TAction;
    actActualSize: TAction;
    ToolButton21: TToolButton;
    View1: TMenuItem;
    Zoomin1: TMenuItem;
    Zoomout1: TMenuItem;
    N4: TMenuItem;
    Actualsize1: TMenuItem;
    PopupMenu: TPopupMenu;
    Additem1: TMenuItem;
    Delete2: TMenuItem;
    Clearall2: TMenuItem;
    N5: TMenuItem;
    Up2: TMenuItem;
    Down2: TMenuItem;
    N6: TMenuItem;
    Ini: TLMDIniCtrl;
    FMDrop: TLMDFMDrop;
    MRUList: TLMDBaseMRUList;
    FormPersistent: TLMDFormPersistent;
    FMDrop1: TLMDFMDrop;
    Additem2: TMenuItem;
    N7: TMenuItem;
    Images: TImageList;
    Cut2: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    N8: TMenuItem;
    actCancel: TAction;
    ToolButton22: TToolButton;
    N9: TMenuItem;
    Cancel1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure actAddItemExecute(Sender: TObject);
    procedure ItemTreeViewClick(Sender: TObject);
    procedure actMultilineExecute(Sender: TObject);
    procedure ItemViewPanelResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actUpExecute(Sender: TObject);
    procedure actDownExecute(Sender: TObject);
    procedure actAddMultipleItemsExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actLoadExecute(Sender: TObject);
    procedure actClearAllExecute(Sender: TObject);
    procedure actUpDownUpdate(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPasteUpdate(Sender: TObject);
    procedure actCutCopyExecute(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure actCutCopyUpdate(Sender: TObject);
    procedure actSaveSelectionExecute(Sender: TObject);
    procedure actSaveSelectionUpdate(Sender: TObject);
    procedure actOKExecute(Sender: TObject);
    procedure actZoomINExecute(Sender: TObject);
    procedure actZoomOutExecute(Sender: TObject);
    procedure actZoomInOutUpdate(Sender: TObject);
    procedure actActualSizeExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ItemTreeViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ItemTreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actMultilineUpdate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MRUListClick(Sender: TObject; const aValue: String;
      var Remove: Boolean);
    procedure FMDropFMDragDrop(Sender: TObject; fcount, x, y: Integer;
      FileList: TStrings);
    procedure ItemTreeViewCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  private
    FZoom: integer;
    FModified: boolean;
    FBmp: TBitmap;
    FImageList: TCustomImageList;
    FRoot: TTreeNode;
    FListType: TLMDExtImageListClassType;
    FShown: Boolean;
    procedure AddItemFromFile(FileName: string);
    procedure AddItems(Files: TStrings);
    procedure AddItem(AItem: TLMDGraphicListItem); overload;
    procedure AddItem(AItem: TLMDPNGObject); overload;
    procedure BuildItemTreeView;
    procedure LoadFromFile(const FileName: String);

    procedure UpdateView;
    procedure UpdateStatusBar;
    procedure UpdateImageView;

    procedure SaveListPath(AValue: string);
    function RestoreListPath: string;

    function SelectionCount: integer;
    procedure SetModified(const Value: boolean);
    procedure SetType(AValue: TLMDExtImageListClassType);

    procedure Scale(ASrcW, ASrcH, ACntW, ACntH, DestL, DestT, dx, dy: integer; var DRect: TRect);
    procedure SetImageList(aValue: TCustomImageList);
    function GetGraphicList: TLMDGraphicList;
    function GetPNGImageList: TLMDPNGImageList;
  public
    destructor Destroy; override;
    property GraphicList: TLMDGraphicList read GetGraphicList;
    property PNGImageList: TLMDPNGImageList read GetPNGImageList;
    property ImageList: TCustomImageList read FImageList write SetImageList;
    property Modified: boolean read FModified write SetModified;
  end;

implementation

{$R *.dfm}

uses
  Registry,
  LMDProcs, pLMDPECst, pLMDCst, LMDTypes;

const
  ListTypeName: array[TLMDExtImageListClassType] of string = ('TLMDGraphicList', 'TLMDPNGImageList');
  ListFileExt: array[TLMDExtImageListClassType] of string = ('grl', 'pnl');

procedure TLMDExtImageListEditorDlg.FormCreate(Sender: TObject);
begin
  FormPersistent.IniKey:='Position';
  FBmp := nil;
  FImageList := nil;
  FZoom := 100;
  StatusBar.Panels[0].Text := Status[false];
  actMultiline.AutoCheck := true;
end;

procedure TLMDExtImageListEditorDlg.SetImageList(aValue: TCustomImageList);
begin
  if (aValue <> nil) then
    begin
      if aValue is TLMDGraphicList then
        SetType(icGraphicList)
      else
        if aValue is TLMDPNGImageList then
          SetType(icPNGImageList);
      FImageList.Assign(aValue);
      BuildItemTreeView;
    end;
end;

procedure TLMDExtImageListEditorDlg.actAddItemExecute(Sender: TObject);
begin
  if OpenPictureDialog.Execute then
    with OpenPictureDialog do
      begin
        InitialDir := RestoreListPath;
        AddItemFromFile(FileName);
        UpdateView;
        Modified := true;
      end;
end;

procedure TLMDExtImageListEditorDlg.ItemTreeViewClick(Sender: TObject);
begin
  UpdateView;
end;

procedure TLMDExtImageListEditorDlg.UpdateView;
begin
  UpdateImageView;
  UpdateStatusBar;
end;

procedure TLMDExtImageListEditorDlg.UpdateStatusBar;
begin
  if ItemTreeView.Selected = nil then
    begin
      StatusBar.Panels[1].Text := '';
      exit;
    end;
  if ItemTreeView.Selected.Level = 0 then
    begin
      StatusBar.Panels[1].Text := '';
      exit;
    end;
  case FListType of
    icGraphicList:
      StatusBar.Panels[1].Text := Format('ImageIndex: %d',
        [TLMDGraphicListItem(ItemTreeView.Selected.Data).Index]);
    icPNGImageList:
      StatusBar.Panels[1].Text := Format('ImageIndex: %d',
        [PNGImageList.IndexOf(TLMDPNGObject(ItemTreeView.Selected.Data))]);
    end;
end;

procedure TLMDExtImageListEditorDlg.actMultilineExecute(Sender: TObject);
begin
  ItemTreeView.MultiSelect := actMultiline.Checked;
  ItemTreeView.MultiSelectStyle := [msControlSelect, msShiftSelect, msVisibleOnly, msSiblingOnly];
end;

procedure TLMDExtImageListEditorDlg.UpdateImageView;
var
  LGraphicList: TLMDGraphicList;
  LPNGImageList: TLMDPNGImageList;
  LPicture: TPicture;
  LPNGObject: TLMDPngObject;
  LSrcW, LSrcH, CWidth, CHeight, x, y: integer;
  i,n, cnt: integer;
  LRect: TRect;
  Node: TTreeNode;
begin
 LPicture   := nil;
 LPNGObject := nil;
 if FZoom = 100 then
   begin
     ImageView.AutoSize := true;
     ImageView.Stretch := false;
   end
 else
   begin
     ImageView.AutoSize := false;
     ImageView.Stretch := true;
   end;
 if (ItemTreeView.Selected <> nil) and (ItemTreeView.Selected.Level > 0) then
   begin
     //paint selected image
     Node := ItemTreeView.Selected;
     if (Node.Data <> nil) then
       begin
         ScrollBox.HorzScrollBar.Position := 0;
         ScrollBox.VertScrollBar.Position := 0;

         LSrcW := 0;
         LSrcH := 0;

         case FListType of
           icGraphicList:
             begin
               LPicture := TLMDGraphicListItem(Node.Data).Picture;
               LSrcW := LPicture.Width;
               LSrcH := LPicture.Height;
             end;
           icPNGImageList:
             begin
               LPNGObject := TLMDPNGObject(Node.Data);
               LSrcW := LPNGObject.Width;
               LSrcH := LPNGObject.Height;
             end;
           end;
         ImageView.Width := Muldiv(LSrcW, FZoom, 100);
         ImageView.Height := Muldiv(LSrcH, FZoom, 100);

         case FListType of
           icGraphicList:  ImageView.Picture.Assign(LPicture);
           icPNGImageList: ImageView.Picture.Assign(LPNGObject);
           end;

         if (ImageView.Width <= ItemViewPanel.Width) and
            (ImageView.Height <= ItemViewPanel.Height) then
           begin
             ImageView.Left := ItemViewPanel.Width div 2 - ImageView.Width div 2;
             ImageView.Top := ItemViewPanel.Height div 2 - ImageView.Height div 2;
           end
         else
           begin
             ImageView.Left := 0;
             ImageView.Top  := 0;
           end
       end
     end
   else
     begin
       //paint all images
       FZoom := 100;
       ImageView.AutoSize := true;
       ImageView.Stretch := false;

       ImageView.Left := 0;
       ImageView.Top  := 0;

       if ItemTreeView.Selected <> nil then
         Node := ItemTreeView.Selected
       else
         Node := FRoot;

       Cnt := 0;
       case FListType of
         icGraphicList:
           begin
             LGraphicList := TLMDGraphicList(Node.Data);
             Cnt := LGraphicList.Count;
           end;
         icPNGImageList:
           begin
             LPNGImageList := TLMDPNGImageList(Node.Data);
             Cnt := LPNGImageList.Count;
           end;
       end;

       if Cnt <= 0 then
         begin
           if FBmp <> nil then
             begin
               FBmp.Width := 0;
               FBmp.Height := 0;
               ImageView.Picture.Bitmap.Assign(FBmp);
             end;
           exit;
         end;

       i := Muldiv(ItemViewPanel.Width, Cnt, ItemViewPanel.Height);
       n := 2;
       while n*n < i do
         inc(n);

       CWidth := (ItemviewPanel.Width - 2) div n;
       CHeight := CWidth;

       if FBmp = nil then
         begin
           FBmp := TBitmap.Create;
           FBmp.PixelFormat := pf24bit;
         end;

       ScrollBox.HorzScrollBar.Position := 0;
       ScrollBox.VertScrollBar.Position := 0;
       FBmp.Width := ItemViewPanel.Width - 2;
       i := 1 + Cnt div n;
       FBmp.Height := CHeight * i;
       FBmp.Canvas.Brush.Color := clBtnFace;
       FBmp.Canvas.Brush.Style := bsSolid;
       FBmp.Canvas.FillRect(Rect(0,0,FBmp.Width, FBmp.Height));
       for i:= 0 to Cnt - 1 do
         begin
           LSrcW := 0;
           LSrcH := 0;
           case FListType of
             icGraphicList:
               begin
                 LPicture := GraphicList.Graphics[i].Picture;
                 LSrcW := LPicture.Width;
                 LSrcH := LPicture.Height;
               end;
             icPNGImageList:
               begin
                 LPNGObject := PNGImageList.PNG[i];
                 LSrcW := LPNGObject.Width;
                 LSrcH := LPNGObject.Height;
               end;
             end;
           x := (i mod n) * CWidth;
           y := (i div n) * CHeight;
           Scale(LSrcW, LSrcH, CWidth, CHeight, x, y, 4, 4, LRect);
           FBmp.Canvas.Brush.Color := clGray;
           FBmp.Canvas.FillRect(Rect(x + 1, y + 1, x + CWidth - 1, y + CHeight - 1));
           case FListType of
             icGraphicList:  FBmp.Canvas.StretchDraw(LRect, LPicture.Graphic);
             icPNGImageList: LPngObject.Draw(FBmp.Canvas, LRect);
             end;
         end;
       ImageView.Picture.Bitmap.Assign(FBmp);
     end;
end;

procedure TLMDExtImageListEditorDlg.ItemViewPanelResize(Sender: TObject);
begin
  if FShown then
    UpdateImageView;
end;

procedure TLMDExtImageListEditorDlg.FormDestroy(Sender: TObject);
begin
  if FBmp <> nil then
    FBmp.Free;
end;

procedure TLMDExtImageListEditorDlg.actUpExecute(Sender: TObject);
var
  LTmp, LNode: TTreeNode;
  LItem: TLMDGraphicListItem;
begin
  LTmp := ItemTreeView.Selected;
  if LTmp <> nil then
    if LTmp.Level > 0 then
      begin
        LNode := LTmp.GetPrevSibling;
        if LNode <> nil then
          begin
            case FListType of
              icGraphicList:
                begin
                  LItem :=  TLMDGraphicListItem(LTmp.Data);
                  LTmp.MoveTo(LNode, naInsert);
                  LItem.Index := LItem.Index - 1;
                end;
              icPNGImageList:
                begin
                  PNGImageList.Move(LTmp.Index, LTmp.Index - 1);
                  LTmp.MoveTo(LNode, naInsert);
                  LTmp.Selected := true;
                end;
            end;
            LTmp.Selected := true;
          end;
        Modified := true;
      end;
end;

procedure TLMDExtImageListEditorDlg.actDownExecute(Sender: TObject);
var
  LTmp, LNode: TTreeNode;
  LItem: TLMDGraphicListItem;
begin
  LTmp := ItemTreeView.Selected;
  if LTmp <> nil then
    if LTmp.Level > 0 then
      begin
        LNode := LTmp.GetNextSibling;
        if LNode <> nil then
          begin
            case FListType of
              icGraphicList:
                begin
                  LItem :=  TLMDGraphicListItem(LTmp.Data);
                  LNode.MoveTo(LTmp, naInsert);
                  LItem.Index := LItem.Index + 1;
                end;
              icPNGImageList:
                begin
                  PNGImageList.Move(LTmp.Index, LTmp.Index + 1);
                  LNode.MoveTo(LTmp, naInsert);
                end;
            end;
            LTmp.Selected := true;
          end;
        Modified := true;
      end;
end;

procedure TLMDExtImageListEditorDlg.AddItemFromFile(FileName: string);
var
  LItem: TObject;
  LNode: TTreeNode;
  s: String;
  PngChunk: TLMDPngChunk;
  const
  fn: {$IFDEF LMD_NATIVEUNICODE}AnsiString{$ELSE}String{$ENDIF} = 'filename';
begin
  LItem := nil;
  s := ExtractFileName(FileName);
  case FListType of
    icGraphicList:
      begin
        LItem := GraphicList.Graphics.Add;
        TLMDGraphicListItem(LItem).Picture.LoadFromFile(FileName);
        TLMDGraphicListItem(LItem).Name := s;
      end;
    icPNGImageList:
      begin
        LItem := TLMDPngObject.Create;
        TLMDPNGObject(LItem).LoadFromFile(FileName);
        PngChunk := TLMDPNGObject(LItem).Chunks.ItemFromClass(TLMDPNGChunkzTXT);
        if PngChunk = nil then
          TLMDPNGObject(LItem).AddztXt(fn, AnsiString(s))
        else
          begin
            if TLMDPNGChunkzTXT(PngChunk).KeyWord <> fn then
              TLMDPNGObject(LItem).AddztXt(fn, 's')
            else
              TLMDPNGChunkzTXT(PngChunk).Text := AnsiString(s);
          end;
        PNGImageList.AddPng(TLMDPNGObject(LItem));
      end;
    end;
  LNode := ItemTreeView.Items.AddChildObject(FRoot, s, LItem);
  LNode.ImageIndex := -1;
  LNode.SelectedIndex := -1;
  Modified := true;
end;

procedure TLMDExtImageListEditorDlg.actAddMultipleItemsExecute(
  Sender: TObject);
begin
  with OpenPictureDialog do
    begin
      Options:=Options + [ofAllowMultiSelect];
      try
        if Execute then
          AddItems(Files);
      finally
        Options:=Options-[ofAllowMultiSelect];
      end;
    end;
end;

procedure TLMDExtImageListEditorDlg.actSaveExecute(Sender: TObject);
var
  S: TStream;
begin
   with SaveDialog do
     begin
       InitialDir := RestoreListPath;
       Filename:='*.' + ListFileExt[FListType];
       if Execute then
         begin
           S := TFileStream.Create(FileName, fmCreate);
           S.WriteComponent(ImageList);
           S.Free;
           MRUList.Add(FileName);
           SaveListPath(ExtractFilePath(FileName));
         end;
     end;
end;

procedure TLMDExtImageListEditorDlg.SetModified(const Value: boolean);
begin
  FModified := Value;
  StatusBar.Panels[0].Text := Status[FModified];
end;

procedure TLMDExtImageListEditorDlg.LoadFromFile(const FileName: String);
var
  S: TStream;
begin
  S := TFileStream.Create(FileName, fmOpenRead);
  try
    S.ReadComponent(ImageList);
    SaveListPath(ExtractFilePath(FileName));
    MRUList.Add(Filename);
    BuildItemTreeView;
    UpdateView;
    Modified := true;
  finally
    S.Free;
  end;
end;

procedure TLMDExtImageListEditorDlg.actLoadExecute(Sender: TObject);
begin
  with OpenDialog do
    begin
      InitialDir := RestoreListPath;
      Filename := '*.' + ListFileExt[FListType];
      if Execute then
        LoadFromFile(FileName);
    end;
end;

procedure TLMDExtImageListEditorDlg.actCancelExecute(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TLMDExtImageListEditorDlg.actClearAllExecute(Sender: TObject);
begin
  if Application.MessageBox(int_Ref(IDS_CONFIRMDELETE), int_Ref(IDS_CONFIRM), MB_YESNO) = IDYES then
    begin
      ItemTreeView.Items.BeginUpdate;
      FRoot.DeleteChildren;
      case FListType of
        icGraphicList: GraphicList.Graphics.Clear;
        icPNGImageList: PNGImageList.Clear;
      end;
      ItemTreeView.Items.EndUpdate;
      Modified := true;
      UpdateView;
    end;
end;

procedure TLMDExtImageListEditorDlg.actUpDownUpdate(Sender: TObject);
var
  b: boolean;
begin
  b := (ItemTreeView.Selected <> nil) and
    (ItemTreeView.Selected.Level > 0);
  if b then
    case integer((Sender as TAction).Tag) of
      21: b := ItemTreeView.Selected.getPrevSibling <> nil;
      22: b := ItemTreeView.Selected.getNextSibling <> nil;
    end;
  (Sender as TAction).Enabled := b;
end;

procedure TLMDExtImageListEditorDlg.actDeleteUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (ItemTreeView.Selected <> nil) and
    (ItemTreeView.Selected.Level > 0);
end;

procedure TLMDExtImageListEditorDlg.actDeleteExecute(Sender: TObject);
var
  LItem: TObject;
  i,j: integer;
begin
  for i := ItemTreeView.Items.Count - 1 downto 1 do
    if ItemTreeView.Items[i].Selected then
      begin
        LItem := TObject(ItemTreeView.Items[i].Data);
        ItemTreeView.Items.BeginUpdate;
        j := ItemTreeView.Items[i].Index;
        ItemTreeView.Items[i].Delete;
        case FListType of
          icGraphicList: GraphicList.Graphics.Delete(TLMDGraphicListItem(LItem).Index);
          icPNGImageList: PNGImageList.Delete(j);
        end;
        ItemTreeView.Items.EndUpdate;
      end;
  UpdateView;
  Modified := true;
end;

procedure TLMDExtImageListEditorDlg.actPasteUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled:=ClipBoard.HasFormat(CF_COMPONENT);
end;

procedure TLMDExtImageListEditorDlg.actCutCopyExecute(Sender: TObject);
var
  LTmpList: TCustomImageList;
  LItem, LGLNewItem: TObject;
  Node: TTreeNode;
  i, j: integer;
begin
//  LItem := nil;
  LTmpList := nil;
  case FListType of
    icGraphicList:  LTmpList := TLMDGraphicList.Create(nil);
    icPNGImageList: LTmpList := TLMDPNGImageList.Create(nil);
  end;
  try
    for i := 0 to ItemTreeView.SelectionCount - 1 do
      begin
        Node := ItemTreeView.Selections[i];
        if (Node <> nil) and (Node.Level > 0) then
          case FListType of
            icGraphicList:
              begin
                LItem := TLMDGraphicListItem(Node.Data);
                LGLNewItem := TLMDGraphicListItem(TLMDGraphicList(LTmpList).Graphics.Add);
                TLMDGraphicListItem(LGLNewItem).Assign(TLMDGraphicListItem(LItem));
              end;
            icPNGImageList:
              TLMDPNGImageList(LTmpList).AddPng(PNGImageList.Png[Node.Index]);
            end;
      end;
    if integer((Sender as TAction).Tag) = 11 then
      begin
        ItemTreeView.Items.BeginUpdate;
        for i := ItemTreeView.SelectionCount - 1 downto 0 do
          begin
            Node := ItemTreeView.Selections[i];
            if (Node <> nil) and (Node.Level > 0) then
              case FListType of
                icGraphicList:
                  begin
                    LItem := TLMDGraphicListItem(Node.Data);
                    Node.Delete;
                    GraphicList.Graphics.Delete(TLMDGraphicListItem(LItem).Index);
                  end;
                icPNGImageList:
                  begin
                    j := Node.Index;
                    Node.Delete;
                    PNGImageList.Delete(j);
                  end;
              end;
          end;
        ItemTreeView.Items.EndUpdate;
      end;
    ClipBoard.SetComponent(LTmpList);
  finally
    LTmpList.Free;
  end;
end;

procedure TLMDExtImageListEditorDlg.actPasteExecute(Sender: TObject);
var
  LTmpGrList: TLMDGraphicList;
  LTmpPngList: TLMDPNGImageList;
  LTmpComp: TComponent;
  i: integer;
begin
  if ClipBoard.HasFormat(CF_COMPONENT) then
    begin
      LTmpComp := ClipBoard.GetComponent(self, nil);
      if LTmpComp is TLMDGraphicList then
        begin
          LTmpGrList := TLMDGraphicList(LTmpComp);
          for i := 0 to LTmpGrList.Graphics.Count - 1 do
            AddItem(LTmpGrList.Graphics.Items[i]);
        end;
      if LTmpComp is TLMDPNGImageList then
        begin
          LTmpPngList := TLMDPNGImageList(LTmpComp);
          for i := 0 to LTmpPngList.Count - 1 do
            AddItem(LTmpPngList.Png[i]);
        end;
      end;
  Modified := true;
end;

procedure TLMDExtImageListEditorDlg.AddItem(AItem: TLMDGraphicListItem);
var
  LItem: TLMDGraphicListItem;
  LNode, LTmpNode: TTreeNode;
begin
  LItem := GraphicList.Graphics.Add;
  LItem.Assign(AItem);
  LNode := ItemTreeView.Items.AddChildObject(FRoot, AItem.Name, LItem);
  LNode.ImageIndex := -1;
  LNode.SelectedIndex := -1;
  if (ItemTreeView.Selected <> nil) and (ItemTreeView.Selected.Level > 0) and
    (ItemTreeView.Selected.GetNextSibling <> nil) then
    begin
      LTmpNode := ItemTreeView.Selected.GetNextSibling;
      LNode.MoveTo(LTmpNode, naInsert);
      LItem.Index := TLMDGraphicListItem(LTmpNode.Data).Index;
    end;
  LNode.Selected := true;
  Modified := true;
end;

procedure TLMDExtImageListEditorDlg.AddItem(AItem: TLMDPNGObject);
var
  LNode, LTmpNode: TTreeNode;
  PngChunk: TLMDPNGChunk;
begin
  PNGImageList.AddPng(AItem);
  PngChunk := AItem.Chunks.ItemFromClass(TLMDPNGChunkzTXT);
  LNode := ItemTreeView.Items.AddChildObject(FRoot, {$IFDEF LMDCOMP12}String{$ENDIF}(TLMDPNGChunkzTXT(PngChunk).Text) , AItem);
  if (ItemTreeView.Selected <> nil) and (ItemTreeView.Selected.Level > 0) and
    (ItemTreeView.Selected.GetNextSibling <> nil) then
    begin
      LTmpNode := ItemTreeView.Selected.GetNextSibling;
      LNode.MoveTo(LTmpNode, naInsert);
    end;
  LNode.Selected := true;
  Modified := true;
end;

procedure TLMDExtImageListEditorDlg.actCutCopyUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (SelectionCount > 0);
end;

procedure TLMDExtImageListEditorDlg.actSaveSelectionExecute(Sender: TObject);
var
  i: integer;
  LDir: string;
  LGLItem:  TLMDGraphicListItem;
  LPNGItem: TLMDPngObject;
  begin
  if SavePictureDialog.Execute then
    if (SelectionCount = 1) then
      case FListType of
        icGraphicList: TLMDGraphicListItem(ItemTreeView.Selected.Data).Picture.SaveToFile(SavePictureDialog.FileName);
        icPNGImageList: TLMDPNGObject(ItemTreeView.Selected.Data).SaveToFile(SavePictureDialog.FileName);
        end
    else
      begin
        LDir := ExtractFilePath(SavePictureDialog.FileName);
        for i := 0 to ItemTreeView.Items.Count - 1 do
          if ItemTreeView.Items[i].Selected then
            case FListType of
              icGraphicList:
                begin
                  LGLItem := TLMDGraphicListItem(ItemTreeView.Items[i].Data);
                  LGLItem.Picture.SaveToFile(LDir + LGLItem.Name);
                end;
              icPNGImageList:
                begin
                  LPNGItem := TLMDPNGObject(ItemTreeView.Items[i].Data);
                  LPNGItem.SaveToFile(LDir + {$IFDEF LMDCOMP12}String{$ENDIF}(LPNGItem.Header.Name));
                end;
              end;
      end;
end;

procedure TLMDExtImageListEditorDlg.actSaveSelectionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (SelectionCount > 0);
end;

procedure TLMDExtImageListEditorDlg.actOKExecute(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TLMDExtImageListEditorDlg.BuildItemTreeView;
var
  cnt, i: integer;
  LItem: TObject;
  LNode: TTreeNode;
  PngChunk: TLMDPngChunk;
  begin
  ItemTreeView.Items.Clear;
  FRoot := ItemTreeView.Items.AddObject(nil, ImageList.Name, ImageList);
  Cnt := 0;
  case FListType of
    icGraphicList:
      begin
        FRoot.ImageIndex := 0;
        cnt := GraphicList.Graphics.Count;
      end;
    icPNGImageList:
      begin
        FRoot.ImageIndex := 1;
        cnt := PNGImageList.Count;
      end;
    end;
  FRoot.SelectedIndex := FRoot.ImageIndex;
  for i := 0 to Cnt - 1 do
    begin
      //LItem := nil;
      LNode := nil;
      case FListType of
       icGraphicList:
         begin
           LItem := GraphicList.Graphics.Items[i];
           LNode := ItemTreeView.Items.AddChildObject(FRoot, TLMDGraphicListItem(LItem).Name, LItem);
         end;
       icPNGImageList:
         begin
           LItem := PNGImageList.PNG[i];
           PNGChunk := TLMDPNGObject(LItem).Chunks.ItemFromClass(TLMDPNGChunkzTXT);
           LNode := ItemTreeView.Items.AddChildObject(FRoot, {$IFDEF LMDCOMP12}String{$ENDIF}(TLMDPNGChunkzTXT(PNGChunk).Text), LItem);
         end;
       end;
      LNode.ImageIndex := -1;
      LNode.SelectedIndex := -1;
    end;
  FRoot.Expand(true);
end;

destructor TLMDExtImageListEditorDlg.Destroy;
begin
  if Assigned(FImageList) then
    FreeAndNil(FImageList);
  inherited;
end;

procedure TLMDExtImageListEditorDlg.actZoomINExecute(Sender: TObject);
begin
  inc(FZoom, 25);
  if FZoom > 3000 then
    FZoom := 3000;
  UpdateImageView;
end;

procedure TLMDExtImageListEditorDlg.actZoomOutExecute(Sender: TObject);
begin
  dec(FZoom, 25);
  if FZoom < 10 then
    FZoom := 25;
  UpdateImageView;
end;

procedure TLMDExtImageListEditorDlg.actZoomInOutUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (ItemTreeView.Selected <> nil) and
    (ItemTreeView.Selected.Level > 0);
end;

procedure TLMDExtImageListEditorDlg.actActualSizeExecute(Sender: TObject);
begin
  FZoom := 100;
  UpdateImageView;
end;

procedure TLMDExtImageListEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormPersistent.WriteData;
  MRUList.WriteData;
end;

function TLMDExtImageListEditorDlg.SelectionCount: integer;
begin
  result := ItemTreeView.SelectionCount;
end;

procedure TLMDExtImageListEditorDlg.ItemTreeViewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  UpdateView;
end;

procedure TLMDExtImageListEditorDlg.ItemTreeViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  UpdateView;
end;

procedure TLMDExtImageListEditorDlg.actMultilineUpdate(Sender: TObject);
begin
  //
end;

procedure TLMDExtImageListEditorDlg.FormShow(Sender: TObject);
begin
  if not FShown then
  begin
    MRUList.ReadData;
    FShown := true;
  end;
end;

function TLMDExtImageListEditorDlg.RestoreListPath;
var
  LIni: TRegIniFile;
begin
  result:='';
  LIni := TRegIniFile.Create(LMDTOOLS_REGISTRYPATH+'\Editors');
  try
    result := LIni.ReadString(ListTypeName[FListType],'Path' , '');
  finally
    LIni.Free;
  end;
end;

procedure TLMDExtImageListEditorDlg.SaveListPath(AValue: string);
var
  LIni: TRegIniFile;
begin
  LIni := TRegIniFile.Create(LMDTOOLS_REGISTRYPATH+'\Editors');
  with LIni do
    try
      WriteString(ListTypeName[FListType], 'Path', aValue);
    finally
      Free;
    end;
end;

procedure TLMDExtImageListEditorDlg.MRUListClick(Sender: TObject;
  const aValue: String; var Remove: Boolean);
begin
 if not FileExists(aValue) then
   Remove := True
 else
   LoadFromFile(aValue);
end;

procedure TLMDExtImageListEditorDlg.AddItems(Files: TStrings);
var
  i: integer;
begin
  for i := 0 to Files.Count - 1 do
    AddItemFromFile(Files[i]);
  UpdateView;
  Modified := true;
end;

procedure TLMDExtImageListEditorDlg.FMDropFMDragDrop(Sender: TObject;
  fcount, x, y: Integer; FileList: TStrings);
begin
  AddItems(FileList);
end;

procedure TLMDExtImageListEditorDlg.ItemTreeViewCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var
  LRect: TRect;
  LSrcW, LSrcH, CW, CH: integer;
  LPicture: TPicture;
  LPNGObject: TLMDPNGObject;
  begin
  if (Node.Level > 0) and (Node.Data <> nil) then
    with ItemTreeView.Canvas do
      begin
        LPicture := nil;
        LPNGObject := nil;
        LSrcW := 0;
        LSrcH := 0;
        case FListType of
          icGraphicList:
            begin
              LPicture := TLMDGraphicListItem(Node.Data).Picture;
              LSrcW := LPicture.Width;
              LSrcH := LPicture.Height;
            end;
          icPNGImageList:
            begin
              LPNGObject := TLMDPNGObject(Node.Data);
              LSrcW := LPNGObject.Width;
              LSrcH := LPNGObject.Height;
            end;
          end;
        CW := Images.Width;
        CH := Images.Height;
        if cdsSelected in State then
          begin
            LRect := Node.DisplayRect(True);
            FillRect(LRect);
          end;
        LRect := Node.DisplayRect(true);
        LRect.Left := LRect.Left - CW;
        LRect.Right := LRect.Right - CW;
        Scale(LSrcW, LSrcH, CW, CH, LRect.Left, LRect.Top, 0, 0, LRect);
        case FListType of
          icGraphicList:  TTreeView(Sender).Canvas.StretchDraw(LRect, LPicture.Graphic);
          icPNGImageList: LPNGObject.Draw(TTreeView(Sender).Canvas, LRect);
          end;
      end;
  DefaultDraw := true;
end;

procedure TLMDExtImageListEditorDlg.Scale(ASrcW, ASrcH, ACntW, ACntH, DestL, DestT, dx, dy: integer; var DRect: TRect);
var
  LHeight, LWidth: integer;
begin
  LHeight := ACntH - dy;
  LWidth := ACntW - dx;
  if (ASrcW > ACntW) or (ASrcH > ACntH) then
    begin
      if ASrcW = ASrcH then
        LWidth := LHeight
      else
        if ASrcW  < ASrcH  then
          LWidth := Muldiv(ASrcW , ACntH, ASrcH)
        else
          LHeight := Muldiv(ASrcH , ACntW, ASrcW);
    end
  else
    begin
      LHeight := ASrcH;
      LWidth := ASrcW;
    end;
  DRect.Left := DestL + ACntW div 2 - LWidth div 2;
  DRect.Top := DestT + ACntH div 2 - LHeight div 2;
  DRect.Bottom := DRect.Top + LHeight;
  DRect.Right := DRect.Left + LWidth;
end;

procedure TLMDExtImageListEditorDlg.actSelectAllExecute(Sender: TObject);
var
  i: integer;
begin
  actMultiLine.Checked := true;
  with ItemTreeView do
    for i := 1 to Items.Count - 1 do
      begin
        ItemTreeView.Deselect(Items[i]);
        ItemTreeView.Select(Items[i], [ssShift]);
      end;
end;

function TLMDExtImageListEditorDlg.GetGraphicList: TLMDGraphicList;
begin
  if FImageList is TLMDGraphicList then
    result := TLMDGraphicList(FImageList)
  else
    result := nil;
end;

function TLMDExtImageListEditorDlg.GetPNGImageList: TLMDPNGImageList;
begin
  if FImageList is TLMDPNGImageList then
    result := TLMDPNGImageList(FImageList)
  else
    result := nil;
end;

procedure TLMDExtImageListEditorDlg.SetType(AValue: TLMDExtImageListClassType);
begin

  FListType := AValue;
  Ini.RegPath := LMDTOOLS_REGISTRYPATH+'\Editors\' + ListTypeName[FListType];
  if FListType=icPNGImageList then
    // We should not use GraphicFilter here, because programmer can switch
    // off registration of TLMDPNGImage.
    begin
      SavePictureDialog.Filter:='Portable Network Graphics (*.png)|*.png';
      OpenPictureDialog.DefaultExt := '*.png';
      FImageList := TLMDPngImageList.Create(nil);
    end
  else
    begin
      SavePictureDialog.Filter :=  GraphicFilter(TGraphic);
      OpenPictureDialog.DefaultExt := GraphicExtension(TGraphic);
      FImageList := TLMDGraphicList.Create(nil);
    end;
  OpenPictureDialog.Filter := SavePictureDialog.Filter;

  SaveDialog.DefaultExt := ListFileExt[FListType];
  SaveDialog.Filter := '*.' + ListFileExt[FListType];
  OpenDialog.DefaultExt := SaveDialog.DefaultExt;
  OpenDialog.Filter := SaveDialog.Filter;
end;

initialization
  RegisterClass(TLMDGraphicList);
  RegisterClass(TLMDPNGImageList);

finalization
  UnregisterClass(TLMDGraphicList);
  UnRegisterClass(TLMDPNGImageList);

end.
