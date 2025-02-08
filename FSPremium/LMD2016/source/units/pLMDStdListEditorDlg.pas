unit pLMDStdListEditorDlg;
{$I lmdcmps.Inc}

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

TLMDStdListEditorDlg unit (RM)
------------------------------
Unified editor for different container classes. Unfortunately default container
classes and bitmap/image classes do no longer have same ancestor, hence
additional code is required.

Important
---------
Save Form always in BDS 4.0 or higher.

Changes
-------
Release 8.0 (April 2006)
 - Initial Release
###############################################################################}

interface

uses
  RTLConsts, Windows, Consts, Classes, Graphics, Forms, Controls, Dialogs,
  ComCtrls, ToolWin, StdCtrls, Menus, ImgList, Buttons, ExtCtrls, ClipBrd,
  LMDCustomIniComponent, LMDBaseMRUList, LMDIniCtrl, LMDCustomComponent,
  LMDHookComponent, LMDFMDrop, LMDCustomContainer, pLMDActionsData,
  LMDBitmapList, LMDGenericList, LMDWaveList, LMDStringList, LMDImageList,
  LMDWndProcComponent, LMDFormPersistent;

type
  TLMDStdListEditorDlg = class(TForm)
    FileDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    fm: TLMDFMDrop;
    pop: TPopupMenu;
    Add1: TMenuItem;
    Remove1: TMenuItem;
    Clear1: TMenuItem;
    N1: TMenuItem;
    Up1: TMenuItem;
    Down1: TMenuItem;
    N2: TMenuItem;
    prop: TMenuItem;
    MainMenu1: TMainMenu;
    Edit1: TMenuItem;
    mnuCut: TMenuItem;
    bmp2iml:TMenuItem;
    avi2iml:TMenuItem;
    mnuCopy: TMenuItem;
    mnuPaste: TMenuItem;
    mnuDelete: TMenuItem;
    N4: TMenuItem;
    cline: TMenuItem;
    saveasbmp:TMenuItem;
    Up2: TMenuItem;
    down2: TMenuItem;
    N5: TMenuItem;
    mnuSelectAll: TMenuItem;
    ClearAll1: TMenuItem;
    N6: TMenuItem;
    Properties1: TMenuItem;
    Tools1: TMenuItem;
    comp: TMenuItem;
    checkall: TMenuItem;
    UnCheckAll: TMenuItem;
    mnuSave:TMenuItem;
    N7: TMenuItem;
    mnuMulti: TMenuItem;
    ini: TLMDIniCtrl;
    mru: TLMDBaseMRUList;
    Play1: TMenuItem;
    N8: TMenuItem;
    mnuLoad:TMenuItem;
    quit1:TMenuItem;
    quit2:TMenuItem;
    pnlMain: TPanel;
    header: THeaderControl;
    lb: TListBox;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    btnLoad: TToolButton;
    btnSave: TToolButton;
    ToolButton3: TToolButton;
    btnCut: TToolButton;
    btnCopy: TToolButton;
    btnPaste: TToolButton;
    ToolButton7: TToolButton;
    btnMultiSelect: TToolButton;
    Panel1: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    addfast: TToolButton;
    remove: TToolButton;
    up: TToolButton;
    down: TToolButton;
    add: TToolButton;
    clear: TToolButton;
    ToolButton1: TToolButton;
    btnProp: TToolButton;
    ToolButton4: TToolButton;
    playdiv: TToolButton;
    play: TToolButton;
    mnuAddFromFile: TMenuItem;
    fp: TLMDFormPersistent;
    procedure FormDestroy(Sender: TObject);
    procedure lbClick(Sender: TObject);
    procedure PopupClick(Sender: TObject);
    procedure fileactionClick(Sender: TObject);
    procedure fmFMDragDrop(Sender: TObject; fcount, x, y: Integer;
      FileList: TStrings);
    procedure lbDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mruClick(Sender: TObject; const aValue: String;
      var Remove: Boolean);
    procedure lbDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure FormResize(Sender: TObject);
  private
    FType: TLMDListItemClassType;
    FBitmapList:TLMDBitmapList;
    FGenericList: TLMDGenericList;
    FStringList: TLMDStringList;
    FWaveList: TLMDWaveList;
    FImageList:TLMDImageList;
    FImageListItem:TLMDImageListItem;
    FDefaultExt,
    FName:String;

    procedure SetList(aValue: TLMDGenericList);
    procedure SetBitmapList(const Value: TLMDBitmapList);
    procedure SetImageList(const Value: TLMDImageList);
    procedure SetWaves(const Value: TLMDWaveList);
    procedure SetStrings(aValue: TLMDStringList);
    procedure SetItemHeight(aValue:Integer);
    procedure SetImageListItem(const Value: TLMDImageListItem);
    procedure WriteGeneral;
    function ImageListItemProp(aValue:TLMDImageListItem):Boolean;

    // class related methods
    function GetCount:Integer;
    function GetEmpty:Boolean;
    procedure LoadFromFile(const FileName:String);
    procedure SaveToFile(const FileName:String);
    procedure ItemDelete(index:Integer);
  public
    procedure SetLabels(Index:Integer; Update:Boolean=false);
    procedure SetType(const Value: TLMDListItemClassType);

    // different possible class types
    property BitmapList: TLMDBitmapList read FBitmapList write SetBitmapList;
    property ImageList: TLMDImageList read FImageList write SetImageList;
    property StringList: TLMDStringList read FStringList write SetStrings;
    property WaveList: TLMDWaveList read FWaveList write SetWaves;
    property GenericList: TLMDGenericList read FGenericList write SetList;
    property ImageListItem:TLMDImageListItem read FImageListItem write SetImageListItem;
  end;

implementation
uses
  SysUtils, TypInfo, ExtDlgs,
  LMDGraph, LMDStrings, LMDGraphUtils, LMDWave, LMDCustomImageList,
  pLMDPECst, pLMDCst, pLMDDsgnCPGetX, LMDTypes,
  pLMDStdItemPropertiesEditorDlg;

{$R *.DFM}
{ ---------------------------------------------------------------------------- }
function LMDCPGetImageListItem(aValue:TLMDImageListItem):Boolean;
var
  sEditor: TLMDStdListEditorDlg;
begin
  result:=False;
  sEditor:=TLMDStdListEditorDlg.Create(nil);
  try
    sEditor.SetType(icImageListItem);
    sEditor.ImageListItem:=aValue;
    sEditor.SetLabels(-1, true);
    if sEditor.Showmodal=mrOK then
      begin
        aValue.Assign(sEditor.ImageListItem);
        result:=True;
      end;
  finally
    sEditor.Free;
  end;
end;

{***************** Class TLMDStdListEditorDlg *********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDStdListEditorDlg.SetType(const Value: TLMDListItemClassType);

  procedure AddColumn(const capt:String; w:Integer);
  begin
    with Header.Sections.Add do
      begin
        Text:=capt;
        Width:=w;
      end;
  end;

begin
  FType:=Value;
  FName:=LMDListGetTypeName(FType);
  case FType of
    icBitmap:
      begin
        FBitmapList:=TLMDBitmapList.Create(nil);
        AddColumn('Nr.', 40); AddColumn('ID', 40); AddColumn('C.', 22);
        AddColumn('Col.', 35); AddColumn('Description', 80); AddColumn('Bitmap', 173);
        saveasbmp.Visible:=true; mnuAddFromFile.Visible:=True;
        cline.Visible:=true;
        SetItemHeight(40);
      end;
    icWave:
      begin
        FWaveList:=TLMDWaveList.Create(nil);
        play.Visible:=True; playdiv.Visible:=true; play1.Visible:=True;n8.Visible:=True;
        AddColumn('Nr.', 40); AddColumn('Size (Bytes)', 75);
        AddColumn('ID', 80); AddColumn('C.', 22); AddColumn('Description', 150);
      end;
    icStringList:
      begin
        FStringList:=TLMDStringList.Create(nil);
        AddColumn('Nr.', 40); AddColumn('Size (Lines)', 75);
        AddColumn('ID', 80); AddColumn('C.', 22); AddColumn('Description', 150);
      end;
    icGeneric:
      begin
        FGenericList:=TLMDGenericList.Create(nil);
        AddColumn('Nr.', 40); AddColumn('Size (Bytes)', 75);
        AddColumn('ID', 80); AddColumn('C.', 22); AddColumn('Description', 150);
      end;
    icImageList:
      begin
        FImageList:=TLMDImageList.Create(nil);
        AddColumn('Index', 50); AddColumn('It.', 25); AddColumn('Col.', 30);
        AddColumn('Size', 55); AddColumn('T.', 25); AddColumn('C.', 25);
        AddColumn('Description', 160);
      end;
    icImageListItem:
      begin
        comp.Visible:=false;
        FImageListItem:=TLMDImageListItem.Create(nil);
        mnuAddFromFile.Visible:=True; bmp2iml.Visible:=true;avi2iml.Visible:=true;
        saveasbmp.Visible:=true;
        cline.Visible:=true;
        AddColumn('Nr.', 40); AddColumn('Bitmap', 330);
      end;
  end;

  Caption:=FName+'-Editor';
  ini.RegPath:=LMDTOOLS_REGISTRYPATH+'\Editors\'+FName;
  fp.IniKey:='Position';
  mru.ReadData;
  FDefaultExt:=LMDICGetSUFFIX(FType, false);
  saveDialog.DefaultExt:=LMDICGetSUFFIX(FType, false);
  saveDialog.Filter:=LMDCPGetFilter(FType);
  filedialog.DefaultExt:=saveDialog.DefaultExt;
  filedialog.Filter:=saveDialog.Filter;
  fp.ReadData;
  {$IFNDEF LMDCOMP10}ToolBar1.Flat:=True;{$ENDIF}
  SetLabels(0, true);
end;

{------------------------------------------------------------------------------}
Procedure TLMDStdListEditorDlg.SetLabels(Index:Integer; Update:Boolean=false);
var
  i:Integer;
begin

  lb.Items.BeginUpdate;
  try
    if Update then
      begin
        lb.Clear;
        if not GetEmpty then
        for i:=0 to Pred(GetCount) do
          lb.Items.Add('');
      end
    else
      lb.Refresh;
  finally
    lb.Items.EndUpdate;
  end;

  if Index>Pred(lb.Items.Count) then
    Index:=Pred(lb.Items.Count);
  if (index>-1) then
    lb.Itemindex:=index;

  {clear}
  Clear.Enabled := not GetEmpty;
  Clear1.Enabled:=Clear.Enabled;
  ClearAll1.Enabled:=Clear.Enabled;

  {save}
  btnSave.Enabled:=not GetEmpty;
  mnuSave.Enabled:=btnSave.Enabled;
  saveasbmp.Enabled:=Clear.Enabled;

  comp.Enabled:=mnuSave.Enabled;
  mnuSelectAll.Enabled:=mnuSave.Enabled and lb.MultiSelect;

  writeGeneral;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.SetStrings(aValue:TLMDStringList);
begin
  FStringList.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.SetWaves(const Value: TLMDWaveList);
begin
  FWaveList.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.SetList(aValue: TLMDGenericList);
begin
  FGenericList.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.SetItemHeight(aValue: Integer);
begin
  lb.ItemHeight:=aValue;
  fm.Enabled:=False;
  fm.Enabled:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.SetImageList(const Value: TLMDImageList);
begin
  FImageList.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.SetImageListItem(const Value: TLMDImageListItem);
begin
  FImageListItem.Assign(Value);
  if (FImageListItem.Height>100) then
    SetItemHeight(104)
  else
    SetItemHeight(FImageListItem.Height+4);
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.SetBitmapList(const Value: TLMDBitmapList);
begin
  FBitmapList.Assign(Value);
end;

{------------------------------------------------------------------------------}
function TLMDStdListEditorDlg.GetCount: Integer;
begin
  result:=0;
  case FType of
    icBitmap: result:=FBitmapList.Count;
    icWave: result:=FWaveList.Count;
    icStringList:result:=FStringList.Count;
    icGeneric: result:=FGenericList.Count;
    icImageList: result:=FImageList.Count;
    icImageListItem:result:=FImageListItem.Count;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDStdListEditorDlg.GetEmpty: Boolean;
begin
  result:=True;
  case FType of
    icBitmap: result:=FBitmapList.Empty;
    icWave: result:=FWaveList.Empty;
    icStringList:result:=FStringList.Empty;
    icGeneric:result:=FGenericList.Empty;
    icImageList:result:=FImageList.Empty;
    icImageListItem:result:=FImageListItem.Empty;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.LoadFromFile(const FileName: String);
var
  tmp:TLMDImageList;
begin
  case FType of
    icBitmap: FBitmapList.LoadFromFile(FileName);
    icWave: FWaveList.LoadFromFile(FileName);
    icStringList:FStringList.LoadFromFile(FileName);
    icGeneric: FGenericList.LoadFromFile(FileName);
    icImageList: FImageList.LoadFromFile(FileName);
    icImageListItem:
      begin
        tmp:=TLMDImageList.Create(nil);
        try
          tmp.LoadFromFile(FileName);
          if not tmp.Empty then
            ImageListItem:=tmp[0]
          else
            FImageListItem.Clear
        finally
          tmp.Free;
        end;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.ItemDelete(index: Integer);
begin
  case FType of
    icBitmap: FBitmapList.Delete(Index);
    icWave: FWaveList.Delete(Index);
    icStringList:FStringList.Delete(Index);
    icGeneric: FGenericList.Delete(Index);
    icImageList: FImageList.Delete(Index);
    icImageListItem: FImageListItem.Delete(Index);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.SaveToFile(const FileName: String);
begin
  case FType of
    icBitmap: FBitmapList.SaveToFile(FileName);
    icWave: FWaveList.SaveToFile(FileName);
    icStringList:FStringList.SaveToFile(FileName);
    icGeneric: FGenericList.SaveToFile(FileName);
    icImageList: FImageList.SaveToFile(FileName);
    icImageListItem: FImageListItem.SaveToFile(FileName);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.WriteGeneral;
begin
  {play}
  if FType=icWave then
    begin
      Play.Enabled:=(lb.Items.Count>0) and (lb.Itemindex<>-1) and (FWaveList[lb.ItemIndex].Wave.Size<>0);
      Play1.Enabled:=Play.Enabled;
    end;

  {remove}
  Remove.Enabled:=(lb.Itemindex<>-1) and (GetCount>0);
  Remove1.Enabled:=Remove.Enabled;
  mnuDelete.Enabled:=Remove.Enabled;

  {Down}
  Down1.Enabled:=((lb.Itemindex>-1) and (lb.itemindex<lb.items.count-1)) and not lb.MultiSelect;
  Down.Enabled:=Down1.Enabled;
  down2.Enabled:=down.Enabled;

  {up}
  Up1.Enabled:=(lb.Itemindex>0) and not lb.MultiSelect;
  up.Enabled:=Up1.Enabled;
  up2.Enabled:=up.Enabled;

  {properties}
  if FType=icImageListItem then
    begin
      btnProp.Enabled:=true;
      self.Caption:= FName+'-Editor'+Format(' (%d x %d)',[FImageListItem.Width, FImageListItem.Height]);
    end
  else
    btnProp.Enabled:=(lb.ItemIndex<>-1) and (lb.SelCount<2) and (GetCount>0);

  properties1.Enabled:=btnProp.Enabled;
  prop.Enabled:=btnProp.Enabled;

  {cut, copy}
  btnCut.Enabled:=remove.Enabled;
  mnuCut.Enabled:=remove.Enabled;
  mnuCopy.Enabled:=remove.Enabled;
  btnCopy.Enabled:=remove.Enabled;
  btnPaste.Enabled:=ClipBoard.HasFormat(CF_COMPONENT);
  mnuPaste.Enabled:=btnPaste.Enabled;
end;

{------------------------------------------------------------------------------}
function TLMDStdListEditorDlg.ImageListItemProp(aValue:TLMDImageListItem):Boolean;
begin
  result:=false;
  with TLMDStdItemForm.Create(nil) do
    try
      Caption:='ImageList Properties';
      nb.ActivePage:='ImageListItem';
      ed1.Value:=aValue.Height;
      ed2.Value:=aValue.Width;
      ed3.Value:=aValue.AllocBy;
      compress.Checked:=aValue.Compressed;
      cmb.ItemIndex:=Ord(aValue.PixelFormat);
      desc.Text:=aValue.Description;
      maske.Checked:=aValue.Masked;
      ActiveControl:=desc;
      if ShowModal=mrOK then
        with aValue do
          begin
            result:=true;
            PixelFormat:=TLMDSavePixelFormat(cmb.ItemIndex);
            Height:=ed1.Value;
            Width:=ed2.Value;
            Masked:=Maske.Checked;
            Description:=desc.Text;
            Compressed:=compress.Checked;
            AllocBy:=ed3.Value;
          end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.FormDestroy(Sender: TObject);
begin
  case FType of
    icBitmap: FBitmapList.Free;
    icWave: FWaveList.Free;
    icStringList:FStringList.Free;
    icGeneric: FGenericList.Free;
    icImageList:FImageList.Free;
    icImageListItem:FImageListItem.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.lbClick(Sender: TObject);
begin
  WriteGeneral;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.PopupClick(Sender: TObject);
var
  // --> Relace by generic type
  tmp1:TLMDStringList;
  tmp1b:TLMDBitmapList;
  tmp1w:TLMDWaveList;
  tmp1g:TLMDGenericList;
  tmp1i:TLMDImageList;
  tmp1il:TLMDImageListItem;
  // ---------
  tmp:TComponent;
  m, b:TBitmap;
  temp, i, j:Integer;
begin

  if (sender=btnmultiselect) or (sender=mnumulti) then
    begin
      temp:=lb.ItemIndex;
      if (sender=mnumulti) then
        begin
          mnuMulti.Checked:=not mnuMulti.Checked;
          lb.MultiSelect:=mnuMulti.Checked;
          btnMultiSelect.Down:=lb.MultiSelect;
        end
      else
        begin
          lb.MultiSelect:=btnMultiSelect.Down;
          mnuMulti.Checked:=lb.MultiSelect;
        end;
      lb.ItemIndex:=temp;
      if lb.MultiSelect then
        if lb.ItemIndex<>-1 then lb.Selected[lb.ItemIndex]:=True;
      SetLabels(lb.ItemIndex, false);
    end;

  if (sender=CheckAll) or (sender=unCheckAll) then
    begin
      temp:=lb.ItemIndex;
      for i:=0 to Pred(lb.Items.Count) do
        case FType of
          icBitmap:  FBitmapList[i].Compressed:=(sender=CheckAll);
          icWave: FWaveList[i].Compressed:=(sender=CheckAll);
          icStringList:FStringList[i].Compressed:=(sender=CheckAll);
          icGeneric: FGenericList[i].Compressed:=(sender=CheckAll);
          icImageList: FImageList[i].Compressed:=(sender=CheckAll);
          icImageListItem: ; // Nothing to do
        end;
      SetLabels(temp, true);
    end

  else if (sender=up1) or (sender=up) or (sender=up2) then
    begin
      temp:=lb.Itemindex;
      case FType of
        icBitmap: FBitmapList.Move(temp, temp-1);
        icWave: FWaveList.Move(temp, temp-1);
        icStringList:FStringList.Move(temp, temp-1);
        icGeneric: FGenericList.Move(temp, temp-1);
        icImageList: FImageList.Move(temp, temp-1);
        icImageListItem: FImageListItem.Move(temp, temp-1);
      end;
      SetLabels(temp-1, false);
    end

  else if (sender=down1) or (sender=down) or (sender=down2) then
    begin
      temp:=lb.Itemindex;
      case FType of
        icBitmap: FBitmapList.Move(temp, temp+1);
        icWave: FWaveList.Move(temp, temp+1);
        icStringList:FStringList.Move(temp, temp+1);
        icGeneric: FGenericList.Move(temp, temp+1);
        icImageList: FImageList.Move(temp, temp+1);
        icImageListItem: FImageListItem.Move(temp, temp+1);
      end;
      SetLabels(temp+1, false);
    end

  else if (Sender=play1) or (sender=play) then
    FWaveList[lb.Itemindex].Wave.Play

  else if (Sender=add1) or (sender=add) then
    case FType of
      icImageList:
        begin
          tmp1il:=TLMDImageListItem.Create(nil);
          tmp1il.Compressed:=FImageList.DefaultCompressed;
          tmp1il.PixelFormat:=FImageList.DefaultPixelFormat;
          if ImageListItemProp(tmp1il) then
            begin
              FImageList.Add(tmp1il);
              self.SetLabels(FImageList.Count-1, true);
            end
          else
            FreeAndNil(tmp1il);
        end;
      icImageListItem:
        with TOpenPictureDialog.Create(nil) do
          try
            DefaultExt := GraphicExtension(TBitmap);
            FileName:='*.'+DefaultExt;
            Filter :=GraphicFilter(TBitmap);
            InitialDir:=LMDRestoreItemPath(piBitmap);
            Options := [ofHideReadOnly, ofFileMustExist];
            if Execute then
              begin
                m:=TBitmap.Create;
                try
                   m.LoadFromFile(FileName);
                   FImageListItem.AddMasked(m, m.TransparentColor);
                   LMDSaveItemPath(piBitmap, ExtractFilePath(FileName));
                   Self.SetLabels(FImageListItem.Count-1, True);
                finally
                  m.Free;
                end;
              end;
          finally
            Free;
          end;
      else {case}
        with TLMDStdItemForm.Create(nil) do
          try
            Caption:='Add '+FName+'Item...';
            case FType of
              icBitmap:
                begin
                  nb.ActivePage:='Picture';
                  edb.Value:=FBitmapList.Count;
                  indexb.Caption:=IntToStr(FBitmapList.Count);
                  Compressedb.Checked:=FBitmapList.DefaultCompressed;
                  cmbb.ItemIndex:=Ord(FBitmapList.DefaultPixelFormat);
                  dimLabel.Caption := '';
                  if ShowModal=mrOK then
                    begin
                      temp:=FBitmapList.Add(nil);
                      {compression}
                      FBitmapList[temp].Compressed:=Compressedb.Checked;
                      FBitmapList[temp].PixelFormat:=TLMDSavePixelFormat(cmbb.ItemIndex);
                      if not img.Picture.Bitmap.Empty then
                        FBitmapList[temp].Bitmap.Assign(img.Picture.Bitmap);
                      FBitmapList[temp].Ident:=edb.Value;
                      FBitmapList[temp].Description:=descb.Text;
                      self.SetLabels(FBitmapList.Count-1, true);
                    end;
                end;
              icWave:
                begin
                  nb.ActivePage:='Wave';
                  edw.Value:=FWaveList.Count;
                  indexw.Caption:=IntToStr(FWaveList.Count);
                  Compressedw.Checked:=FWaveList.DefaultCompressed;
                  SetLabels;
                  if ShowModal=mrOK then
                    begin
                      temp:=FWaveList.Add(nil);
                      {compression}
                      if not cWave.Empty then
                        FWaveList[temp].Wave.Assign(cWave);
                      FWaveList[temp].Ident:=edW.Value;
                      FWaveList[temp].Compressed:=CompressedW.Checked;
                      FWaveList[temp].Description:=DescW.Text;
                      self.SetLabels(FWaveList.Count-1, true);
                    end;
                 end;
              icStringList:
                begin
                  nb.ActivePage:='StringList';
                  Width:=580; Height:=385;
                  edS.Value:=FStringList.Count;
                  indexS.Caption:=IntToStr(FStringList.Count);
                  CompressedS.Checked:=FStringList.DefaultCompressed;
                  SetLabels;
                  if ShowModal=mrOK then
                    begin
                      temp:=FStringList.Add(nil);
                      FStringList[temp].Items:=Editor.Lines;
                      FStringList[temp].Ident:=edS.Value;
                      FStringList[temp].Description:=DescS.Text;
                      FStringList[temp].Compressed:=CompressedS.Checked;
                      self.SetLabels(FStringList.Count-1, true);
                    end;
                end;
              icGeneric:
                begin
                  nb.ActivePage:='Generic';
                  edg.Value:=FGenericList.Count;
                  indexg.Caption:=IntToStr(FGenericList.Count);
                  compressedg.Checked:=FGenericList.DefaultCompressed;
                  if ShowModal=mrOK then
                    begin
                      temp:=FGenericList.Add(nil);
                      FGenericList[temp].LoadFromFile(dimlabelg.Caption);
                      FGenericList[temp].Ident:=edg.Value;
                      FGenericList[temp].Description:=Descg.Text;
                      FGenericList[temp].Compressed:=Compressedg.Checked;
                      self.SetLabels(FGenericList.Count-1, true);
                    end;
                 end;
            end;
        finally
          free;
        end
    end  {of case}

  else if (sender=addfast) then
    begin
      with FileDialog do
        begin
          case FType of
            icBitmap, icImageListItem:
              begin
                DefaultExt:='bmp';
                Filter:=GraphicFilter(TBitmap);
                InitialDir:=LMDRestoreItemPath(piBitmap);
              end;
           icWave:
              begin
                DefaultExt:='wav';
                Filter:='Wave files (*.wav)|*.wav';
                InitialDir:=LMDRestoreItemPath(piWave);
              end;
           icStringList:
              begin
                DefaultExt:='txt';
                Filter:='Text files (*.txt)|*.txt';
                InitialDir:=LMDRestoreItemPath(piText);
              end;
           icGeneric:
              begin
                DefaultExt:='*';
                Filter:='All files (*.*)|*.*';
                InitialDir:=LMDRestoreItemPath(piGeneric);
              end;
           icImageList:
              begin
                DefaultExt:=LMDICGetSUFFIX(FType, false);
                Filter:=LMDCPGetFilter(icImageList);
                InitialDir:=LMDRestoreListPath(FType);
              end;
          end;
          try
            Options:=Options+[ofAllowMultiSelect];
            FileName:='*.'+DefaultExt;
            if Execute then
              fmFMDragDrop(nil, Files.Count, 0,0, Files);
          finally
            Options:=Options-[ofAllowMultiSelect];
            filedialog.Filter:=saveDialog.Filter;
            DefaultExt:=saveDialog.DefaultExt;
            case FType of
              icBitmap, icImageListItem: LMDSaveItemPath(piBitmap, ExtractFilePath(FileName));
              icStringList: LMDSaveItemPath(piText, ExtractFilePath(FileName));
              icGeneric: LMDSaveItemPath(piGeneric, ExtractFilePath(FileName));
              icImageList: LMDSaveListPath(FType, ExtractFilePath(FileName));
            end;
          end;
        end;
    end

  else if (sender=mnuSelectAll) then
    begin
      lb.Items.BeginUpdate;
      for i:=0 to Pred(lb.Items.Count) do lb.Selected[i]:=True;
      lb.Items.EndUpdate;
    end

  else if (Sender=clear1) or (sender=clear) or (sender=clearAll1) then
    begin
      if messagedlg(IDS_DeleteList, mtConfirmation,[mbYes, mbNo],0)=mrNo then exit;
      case FType of
        icBitmap: FBitmapList.Clear;
        icWave: FWaveList.Clear;
        icStringList:FStringList.Clear;
        icGeneric: FGenericList.Clear;
        icImageList:FImageList.Clear;
        icImageListItem:FImageListItem.Clear;
      end;
      SetLabels(-1, true);
    end

  else if (sender=remove1) or (sender=remove) or (sender=mnuDelete) then
    begin
      temp:=lb.Itemindex;
      if lb.selcount=1 then
        ItemDelete(temp)
      else
        for i:=Pred(GetCount) downto 0 do
          if lb.Selected[i] then ItemDelete(i);
      SetLabels(temp, true);
    end

  else if (sender=prop) or (sender=btnprop) or (sender=properties1) then
    case FType of
      icImageList:
        begin
          LMDCPGetImageListItem(FImageList[lb.ItemIndex]);
          self.SetLabels(lb.ItemIndex);
        end;
      icImageListItem:
        begin
          ImageListItemProp(FImageListItem);
          if FImageListItem.Count>0 then
            self.SetLabels(lb.ItemIndex)
          else
            self.SetLabels(-1, true);
        end
    else
      with TLMDStdItemForm.Create(nil) do
        try
          Caption:=FName+'Item Editor';
          case FType of
            icBitmap:
              begin
                nb.ActivePage:='Picture';
                edb.Value:=FBitmapList.Contents[lb.ItemIndex].Ident;
                img.Picture.Bitmap.Assign(FBitmapList[lb.ItemIndex].Bitmap);
                indexb.Caption:=Inttostr(lb.ItemIndex);
                Compressedb.Checked:=FBitmapList[lb.ItemIndex].Compressed;
                cmbb.ItemIndex:=Ord(FBitmapList[lb.ItemIndex].PixelFormat);
                descb.Text:=FBitmapList[lb.ItemIndex].Description;
                dimLabel.Caption := '('+IntToStr (FBitmapList[lb.ItemIndex].Bitmap.Width) + 'x' +
                                    IntToStr (FBitmapList[lb.ItemIndex].Bitmap.Height)+')';
                if ShowModal=mrOK then
                  begin
                    FBitmapList[lb.ItemIndex].PixelFormat:=TLMDSavePixelFormat(cmbb.ItemIndex);
                    FBitmapList[lb.ItemIndex].Bitmap.Assign(img.Picture.Bitmap);
                    FBitmapList[lb.ItemIndex].Ident:=edb.Value;
                    FBitmapList[lb.ItemIndex].Compressed:=compressedb.Checked;
                    FBitmapList[lb.ItemIndex].Description:=descb.Text;
                    self.SetLabels(lb.ItemIndex, False);
                  end;
              end;
            icWave:
              begin
                nb.ActivePage:='Wave';
                indexw.Caption:=Inttostr(lb.ItemIndex);
                edw.Value:= FWaveList[lb.ItemIndex].Ident;
                descw.Text:=FWaveList[lb.ItemIndex].Description;
                Compressedw.Checked:=FWaveList[lb.ItemIndex].Compressed;
                cWave.Assign(FWaveList[lb.ItemIndex].Wave);
                SetLabels;
                if ShowModal=mrOK then
                  begin
                    FWaveList[lb.ItemIndex].Wave.Assign(cWave);
                    FWaveList[lb.ItemIndex].Ident:=edw.Value;
                    FWaveList[lb.ItemIndex].Description:=DescW.Text;
                    FWaveList[lb.ItemIndex].Compressed:=compressedW.Checked;
                    self.SetLabels(lb.ItemIndex);
                  end;
              end;
            icStringList:
                begin
                  nb.ActivePage:='StringList';
                  Width:=580; Height:=385;
                  indexS.Caption:=Inttostr(lb.ItemIndex);
                  edS.Value:= FStringList[lb.ItemIndex].Ident;
                  descS.Text:=FStringList[lb.ItemIndex].Description;
                  CompressedS.Checked:=FStringList[lb.ItemIndex].Compressed;
                  Editor.Lines.Assign(FStringList[lb.ItemIndex].Items);
                  SetLabels;
                  if ShowModal=mrOK then
                    begin
                      FStringList[lb.ItemIndex].Items.Assign(Editor.Lines);
                      FStringList[lb.ItemIndex].Ident:=edS.Value;
                      FStringList[lb.ItemIndex].Description:=DescS.Text;
                      FStringList[lb.ItemIndex].Compressed:=compressedS.Checked;
                      self.SetLabels(lb.ItemIndex);
                    end;
                end;
            icGeneric:
              begin
                nb.ActivePage:='Generic';
                indexg.Caption:=Inttostr(lb.ItemIndex);
                edg.Value:= FGenericList[lb.ItemIndex].Ident;
                descg.Text:=FGenericList[lb.ItemIndex].Description;
                Compressedg.Checked:=FGenericList[lb.ItemIndex].Compressed;
                dimlabelg.Caption:=FGenericList[lb.ItemIndex].Filename;
                if ShowModal=mrOK then
                  begin
                    if FGenericList[lb.ItemIndex].Filename<>dimlabelg.Caption then
                      FGenericList[lb.ItemIndex].LoadFromFile(dimlabelg.Caption);
                    FGenericList[lb.ItemIndex].Ident:=edg.Value;
                    FGenericList[lb.ItemIndex].Description:=Descg.Text;
                    FGenericList[lb.ItemIndex].Compressed:=compressedg.Checked;
                    self.SetLabels(lb.ItemIndex);
                  end;
              end;
          end;
      finally
        Free;
      end;
    end;

  if (sender=mnuCopy) or (sender=btnCopy) then
    case lb.SelCount of
      0:exit;
    else
      case FType of
        icBitmap:
          begin
            tmp1b:=TLMDBitmapList.Create(nil);
            try
              for i:=0 to Pred(lb.Items.Count) do
                if lb.Selected[i] then
                  begin
                    tmp1b.Contents[tmp1b.Add(nil)].Assign(FBitmapList.Contents[i]);
                    if tmp1b.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1b);
            finally
              tmp1b.Free;
            end;
          end;
        icWave:
          begin
            tmp1w:=TLMDWaveList.Create(nil);
            try
              for i:=0 to Pred(lb.Items.Count) do
                if lb.Selected[i] then
                  begin
                    tmp1w.Contents[tmp1w.Add(nil)].Assign(FWaveList.Contents[i]);
                    if tmp1w.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1w);
            finally
              tmp1w.Free;
            end;
          end;
        icStringList:
          begin
            tmp1:=TLMDStringList.Create(nil);
            try
              for i:=0 to Pred(lb.Items.Count) do
                if lb.Selected[i] then
                  begin
                    tmp1.Contents[tmp1.Add(nil)].Assign(FStringList.Contents[i]);
                    if tmp1.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1);
            finally
              tmp1.Free;
            end;
          end;
       icImageListItem:
          begin
            tmp1il:=TLMDImageListItem.Create(nil);
            m:=nil; b:=nil;
            try
              tmp1il.Masked:=FImageListItem.Masked;
              tmp1il.Width:=FImageListItem.Width;
              tmp1il.Height:=FImageListItem.Height;
              for i:=0 to Pred(lb.Items.Count) do
                if lb.Selected[i] then
                  begin
                    b:=TBitmap.Create;
                    if FImageListItem.Masked then
                      begin
                        m:=TBitmap.Create;
                        FImageListItem.GetMaskBitmap(i, m);
                      end;
                    FImageListItem.GetBitmap(i, b);
                    tmp1il.Add(b, m);
                    b.Free;b:=nil;
                    if m<>nil then m.Free;
                    m:=nil;
                    if tmp1il.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1il);
              SetLabels(lb.ItemIndex, True);
            finally
              if m<>nil then m.Free;
              if b<>nil then b.Free;
              tmp1il.Free;
            end;
          end;
        icImageList:
          begin
            tmp1i:=TLMDImageList.Create(nil);
            try
              for i:=0 to Pred(lb.Items.Count) do
                if lb.Selected[i] then
                  begin
                    tmp1i.Contents[tmp1i.Add(nil)].Assign(FImageList.Contents[i]);
                    if tmp1i.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1i);
            finally
              tmp1i.Free;
            end;
          end;
       icGeneric:
          begin
            tmp1g:=TLMDGenericList.Create(nil);
            try
              for i:=0 to Pred(lb.Items.Count) do
                if lb.Selected[i] then
                  begin
                    tmp1g.Contents[tmp1g.Add(nil)].Assign(FGenericList.Contents[i]);
                    if tmp1g.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1g);
            finally
              tmp1g.Free;
            end;
          end;
      end;
    end;

  if (sender=mnuCut) or (sender=btnCut) then
    case lb.SelCount of
      0:exit;
    else
      case FType of
        icBitmap:
          begin
            tmp1b:=TLMDBitmapList.Create(nil);
            try
              for i:=Pred(lb.Items.Count) downto 0 do
                if lb.Selected[i] then
                  begin
                     tmp1b.Insert(0, nil);
                     tmp1b[0].Assign(FBitmapList[i]);
                     FBitmapList.Delete(i);
                     if tmp1b.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1b);
              SetLabels(lb.ItemIndex, True);
            finally
              tmp1b.Free;
            end;
          end;
        icWave:
          begin
            tmp1w:=TLMDWaveList.Create(nil);
            try
              for i:=Pred(lb.Items.Count) downto 0 do
                if lb.Selected[i] then
                  begin
                     tmp1w.Insert(0, nil);
                     tmp1w[0].Assign(FWaveList[i]);
                     FWaveList.Delete(i);
                     if tmp1w.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1w);
              SetLabels(lb.ItemIndex, true);
            finally
              tmp1w.Free;
            end;
          end;
        icImageList:
          begin
            tmp1i:=TLMDImageList.Create(nil);
            try
              for i:=Pred(lb.Items.Count) downto 0 do
                if lb.Selected[i] then
                  begin
                     tmp1i.Insert(0, nil);
                     tmp1i[0].Assign(FImageList[i]);
                     FImageList.Delete(i);
                     if tmp1i.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1i);
              SetLabels(lb.ItemIndex, True);
            finally
              tmp1i.Free;
            end;
          end;
        icImageListItem:
          begin
            tmp1il:=TLMDImageListItem.Create(nil);
            m:=nil; b:=nil;
            try
              tmp1il.Masked:=FImageListItem.Masked;
              tmp1il.Width:=FImageListItem.Width;
              tmp1il.Height:=FImageListItem.Height;
              if FImageListItem.Masked then m:=TBitmap.Create;
              for i:=Pred(lb.Items.Count) downto 0 do
                if lb.Selected[i] then
                  begin
                    b:=TBitmap.Create;
                    if FImageListItem.Masked then
                      begin
                        m:=TBitmap.Create;
                        FImageListItem.GetMaskBitmap(i, m);
                      end;
                    FImageListItem.GetBitmap(i, b);
                    tmp1il.Add(b, m);
                    FImageListItem.Delete(i);
                    b.Free;b:=nil;
                    if m<>nil then m.Free;
                    m:=nil;
                    if tmp1il.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1il);
              SetLabels(lb.ItemIndex, True);
            finally
              tmp1il.Free;
              if m<>nil then m.Free;
              if b<>nil then b.Free;
            end;
          end;
        icStringList:
          begin
            tmp1:=TLMDStringList.Create(nil);
            try
              for i:=Pred(lb.Items.Count) downto 0 do
                if lb.Selected[i] then
                  begin
                     tmp1.Insert(0, nil);
                     tmp1[0].Assign(FStringList[i]);
                     FStringList.Delete(i);
                     if tmp1.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1);
              SetLabels(lb.ItemIndex, true);
            finally
              tmp1.Free;
            end;
          end;
       icGeneric:
          begin
            tmp1g:=TLMDGenericList.Create(nil);
            try
              for i:=Pred(lb.Items.Count) downto 0 do
                if lb.Selected[i] then
                  begin
                     tmp1g.Insert(0, nil);
                     tmp1g[0].Assign(FGenericList[i]);
                     FGenericList.Delete(i);
                     if tmp1g.Count=lb.SelCount then break;
                  end;
              ClipBoard.SetComponent(tmp1g);
              SetLabels(lb.ItemIndex, true);
            finally
              tmp1g.Free;
            end;
          end;
      end;
    end;

  if (sender=mnuPaste) or (sender=btnPaste) then
    if ClipBoard.HasFormat(CF_COMPONENT) then
      case FType of
        icBitmap:
          begin
            tmp:=ClipBoard.GetComponent(self, nil);
            if tmp is TLMDBitmapList then
              with TLMDBitmapList(tmp) do
                if (lb.ItemIndex=-1) or (lb.ItemIndex=Pred(FBitmapList.Count)) then
                  begin
                    FBitmapList.AddList(TLMDBitmapList(tmp));
                    SetLabels(Pred(FBitmapList.Count), True);
                  end
                else
                  begin
                    j:=lb.ItemIndex;
                    for i:=Pred(Count) downto 0 do
                      begin
                        FBitmapList.Insert(j, nil);
                        FBitmapList[j].Assign(TLMDBitmapList(tmp)[i]);
                      end;
                    SetLabels(j, True);
                  end;
          end;
        icWave:
          begin
            tmp:=ClipBoard.GetComponent(self, nil);
            if tmp is TLMDWaveList then
              with TLMDWaveList(tmp) do
                if (lb.ItemIndex=-1) or (lb.ItemIndex=Pred(FWaveList.Count)) then
                  begin
                    FWaveList.AddList(TLMDWaveList(tmp));
                    SetLabels(Pred(FWaveList.Count), true);
                  end
                else
                  begin
                    j:=lb.ItemIndex;
                    for i:=Pred(Count) downto 0 do
                      begin
                        FWaveList.Insert(j, nil);
                        FWaveList[j].Assign(TLMDWaveList(tmp)[i]);
                      end;
                    SetLabels(j, true);
                  end;
          end;
        icImageListItem:
          begin
            tmp:=ClipBoard.GetComponent(self, nil);
            if tmp is TLMDImageListItem then
              with TLMDImageListItem(tmp) do
                begin
                  j:=lb.ItemIndex;
                  if j=-1 then j:=0;
                  FImageListItem.InsertImages(j, TLMDImageListItem(tmp));
                  SetLabels(j, True);
                end;
          end;
        icImageList:
          begin
            tmp:=ClipBoard.GetComponent(self, nil);
            if tmp is TLMDImageList then
              with TLMDImageList(tmp) do
                if (lb.ItemIndex=-1) or (lb.ItemIndex=Pred(FImageList.Count)) then
                  begin
                    FImageList.AddList(TLMDImageList(tmp));
                    SetLabels(Pred(FImageList.Count), true);
                  end
                else
                  begin
                    j:=lb.ItemIndex;
                    for i:=Pred(Count) downto 0 do
                      begin
                        FImageList.Insert(j, nil);
                        FImageList[j].Assign(TLMDImageList(tmp)[i]);
                      end;
                    SetLabels(j, true);
                  end;
          end;
        icStringList:
          begin
            tmp:=ClipBoard.GetComponent(self, nil);
            if tmp is TLMDStringList then
              with TLMDStringList(tmp) do
                if (lb.ItemIndex=-1) or (lb.ItemIndex=Pred(FStringList.Count)) then
                  begin
                    FStringList.AddList(TLMDStringList(tmp));
                    SetLabels(Pred(FStringList.Count), true);
                  end
                else
                  begin
                    j:=lb.ItemIndex;
                    for i:=Pred(Count) downto 0 do
                      begin
                        FStringList.Insert(j, nil);
                        FStringList[j].Assign(TLMDStringList(tmp)[i]);
                      end;
                    SetLabels(j, true);
                  end;
          end;
       icGeneric:
          begin
            tmp:=ClipBoard.GetComponent(self, nil);
            if tmp is TLMDGenericList then
              with TLMDGenericList(tmp) do
                if (lb.ItemIndex=-1) or (lb.ItemIndex=Pred(FGenericList.Count)) then
                  begin
                    FGenericList.AddList(TLMDGenericList(tmp));
                    SetLabels(Pred(FGenericList.Count), true);
                  end
                else
                  begin
                    j:=lb.ItemIndex;
                    for i:=Pred(Count) downto 0 do
                      begin
                        FGenericList.Insert(j, nil);
                        FGenericList[j].Assign(TLMDGenericList(tmp)[i]);
                      end;
                    SetLabels(j, true);
                  end;
          end
      end;

end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.fileactionClick(Sender: TObject);
var
  tmp:TBitmap;
  s:TStringList;
begin

  if sender=quit1 then
    ModalResult:=mrOK;

  if sender=quit2 then
    ModalResult:=mrCancel;

  if (sender=mnuAddFromFile) then
    with FileDialog do
      begin
        InitialDir:=LMDRestoreListPath(FType);
        Filename:='*.'+FDefaultExt;
        if Execute then
          case FType of
            icBitmap:
              if LMDCPIMLAddItemsFromFile(FileName, FBitmapList, 0) then
                begin
                  Self.SetLabels(Pred(FBitmapList.Count), True);
                  LMDSaveListPath(icBitmap,ExtractFilePath(FileName));
                end;
            icImageListItem:
              if LMDCPIMLAddItemsFromFile(FileName, FImageListItem) then
                begin
                  SetLabels(Pred(FImageListItem.Count), True);
                  LMDSaveListPath(FType,ExtractFilePath(FileName));
                end;
          end;
      end;

  if (sender=btnLoad) or (sender=mnuLoad) then
    with FileDialog do
      begin
        InitialDir:=LMDRestoreListPath(FType);
        Filename:='*.'+FDefaultExt;
        if FileDialog.Execute then
          begin
            LoadFromFile(FileDialog.Filename);
            LMDSaveListPath(FType, ExtractFilePath(FileName));
            mru.Add(FileDialog.Filename);
            SetLabels(-1, true);
          end;
      end;

  if (sender=btnSave) or (sender=mnuSave) then
   with SaveDialog do
     begin
       InitialDir:=LMDRestoreListPath(FType);
       Filename:='*.'+FDefaultExt;
       if Execute then
         begin
           SaveToFile(Filename);
           mru.Add(FileName);
           LMDSaveListPath(icStringList,ExtractFilePath(FileName));
         end;
       exit;
     end;

  if sender=saveasbmp then
    with TSaveDialog.Create(nil) do
      try
        Title:='Save bitmap';
        filename:='*.bmp';
        defaultext:='bmp';
        filter:=GraphicFilter(TBitmap);
        InitialDir:=LMDRestoreItemPath(piBitmap);
        Options := [ofOverwritePrompt,ofHideReadOnly];
        if Execute then
          case FType of
            icImageListItem:
              begin
                tmp:=TBitmap.Create;
                try
                  tmp.Assign(FImageListItem.GetImageBitmap);
                  tmp.SaveToFile(FileName);
                  LMDSaveItemPath(piBitmap, ExtractFilePath(FileName));
                finally
                  tmp.Free;
                end;
              end;
            icBitmap:
              begin
                if lb.ItemIndex<>-1 then
                  FBitmapList[lb.ItemIndex].Bitmap.SaveToFile(FileName)
                else
                  with TBitmap.Create do
                    try
                      SaveToFile(FileName)
                    finally
                      Free;
                    end;
                LMDSaveItemPath(piBitmap, ExtractFilePath(FileName));
              end;
          end;
      finally
        free;
      end;

  if not (FType=icImageListItem) then exit;

  if (FImageListItem.Count>0) and ((sender=avi2IML) or (sender=bmp2iml)) then
    if MessageDlg('The current list contains items. This operation will replace the '+
               'list (removing all items).'#13'Continue?', mtConfirmation,[mbYes, mbNo],0)=mrNo then
      exit;

  if sender=bmp2iml then
    with FileDialog do
      begin
        filename:='*.bmp';
        defaultext:='bmp';
        filter:=GraphicFilter(TBitmap);
        InitialDir:=LMDRestoreItemPath(piBitmap);
        tmp:=TBitmap.Create;
        try
          if Execute then
            begin
              tmp.LoadFromFile(FileName);
              if not tmp.Empty then
                with TLMDStdItemForm.Create(nil) do
                  try
                    Caption:='BMP2IML, Import Options';
                    nb.ActivePage:='BMP2IML';
                    lblSize.Caption:=SysUtils.Format('%d x %d pixels', [tmp.Width, tmp.Height]);
                    s:=TStringList.Create;
                    LMDAnsiGetDivider(s, tmp.Width);
                    rows.Items:=s;
                    rows.ItemIndex:=0;
                    ActiveControl:=rows;
                    if ShowModal=mrOK then
                      begin
                        FImageListItem.LoadFromBitmap(FileName, StrToInt(rows.Items[rows.ItemIndex]), mk.Checked);
                        LMDSaveItemPath(piBitmap, ExtractFilePath(FileName));
                        SetItemHeight(tmp.Height+4);
                        self.SetLabels(-1, True);
                      end;
                   finally
                     Free;
                   end;
            end;
        finally
          tmp.Free;
        end;
     end;

    if sender=avi2iml then
      with TLMDStdItemForm.Create(nil) do
        try
          Caption:='ImageList Properties';
          nb.ActivePage:='AVI2IML Converter';
          Width:=580; Height:=385;
          if (ShowModal=mrOK) and Assigned(ImageListItem) then
            begin
              FImageListItem.Clear;
              FImageListItem.Assign(ImageListItem);
              SetItemHeight(ImageListItem.Height+4);
              self.SetLabels(-1, True);
            end;
        finally
          Free;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.fmFMDragDrop(Sender: TObject; fcount, x, y: Integer; FileList: TStrings);
var
  i, old:Integer;
  tmp:TStringList;
  tmpi:TLMDImageList;
  tmpw:TLMDWave;
  tmpB:TBitmap;
begin
  screen.Cursor:=crHourglass;
  old:=GetCount;
  lb.Items.BeginUpdate;
  try
    for i:=0 to fcount-1 do
      case FType of
        icImageList:
          if LowerCase(copy(FileList[i], Length(FileList[i])-3, Length(FileList[i])))='.iml' then
            begin
              tmpi:=TLMDImageList.Create(nil);
              try
                tmpi.LoadFromFile(FileList[i]);
                FImageList.AddList(tmpi);
              finally
                tmpi.Free;
              end;
            end;
        icStringList:
          if LowerCase(copy(FileList[i], Length(FileList[i])-3, Length(FileList[i])))='.txt' then
            begin
              tmp:=TStringList.Create;
              try
                tmp.LoadFromFile(FileList[i]);
                with FStringList[FStringList.Add(nil)] do
                  begin
                    Assign(tmp);
                    Compressed:=FStringList.DefaultCompressed;
                  end;
              finally
                FreeAndNil(tmp);
              end;
            end;
        icWave:
          if LowerCase(copy(FileList[i], Length(FileList[i])-3, Length(FileList[i])))='.wav' then
            begin
              tmpw:=TLMDWave.Create;
              try
                tmpw.LoadFromFile(FileList[i]);
                with FWaveList[FWaveList.Add(nil)] do
                  begin
                    Wave:=tmpw;
                    Compressed:=FWaveList.DefaultCompressed;
                  end;
              finally
                FreeAndNil(tmpw);
              end;
            end;
        icGeneric:
          try
            FGenericList[FGenericList.Add(nil)].LoadFromFile(FileList[i]);
          except
             On Exception do
               Showmessage(format('%s:'#13'%s',[SFOpenError, FileList[i]]));
          end;
        icBitmap, icImageListItem:
          if LowerCase(copy(FileList[i], Length(FileList[i])-3, Length(FileList[i])))='.bmp' then
            begin
              tmpb:=TBitmap.Create;
              try
                tmpb.LoadFromFile(FileList[i]);
                if FType=icBitmap then
                  begin
                    FBitmapList[FBitmapList.Add(nil)].Bitmap.Assign(tmpb);
                    FBitmapList[Pred(FBitmapList.Count)].Compressed:=FBitmapList.DefaultCompressed;
                    FBitmapList[Pred(FBitmapList.Count)].PixelFormat:=FBitmapList.DefaultPixelFormat;
                  end
                else
                  FImageListItem.AddMasked(tmpb, tmpb.TransparentColor);
              finally
                FreeAndNil(tmpb);
              end;
            end;
      end;
  finally
    screen.Cursor:=crDefault;
    lb.Items.EndUpdate;
    if old<GetCount then
      old:=GetCount-1
    else
      old:=lb.ItemIndex;
    Self.SetLabels(old, true);
  end;

end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.lbDblClick(Sender: TObject);
begin
  if lb.ItemIndex<>-1 then
    PopUpClick(prop);
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fm.Control:=nil;
  fp.WriteData;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.mruClick(Sender: TObject; const aValue: String; var Remove: Boolean);
begin
 if not FileExists(aValue) then
   Remove:=True
 else
   begin
     LoadFromFile(aValue);
     SetLabels(-1, true);
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.lbDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  tmp:TRect;
  t:Integer;
  tmps:String;
  tmpfc:TColor;
  flag:Word;
begin

  with lb.Canvas do
    begin
      if odSelected in State then
        begin
          Brush.Color:=clHighlight;
          tmpfc:=clHighlightText;
        end
      else
        begin
          tmpfc:=lb.Font.Color;
          Brush.Color:=lb.Color;
        end;

      Canvas.Font.Color:=tmpfc;
      Brush.Style := bsSolid;
      FillRect(Rect);
      Brush.Style := bsClear;

      t:=Index;
      tmp:=Rect;

      {Index Nummer}
      tmp.Right:=tmp.Left+Header.Sections[0].Width-2;
      LMDDrawTextExt(lb.Canvas, inttostr(t), nil, tmp, DT_CENTER or DT_VCENTER or DT_SINGLELINE);

      {Standard: Size, Bitmap: Ident}
      tmp.Left:=tmp.Right+2;
      tmp.Right:=tmp.Left+Header.Sections[1].Width-4;
      if FType=icImageListItem then
        begin
          flag:=0;
          Inc(tmp.Top,2);
          if (FImageListItem.Height>100) then
            begin
              tmp.Bottom:=tmp.Top+100;
              flag:=DSF_STRETCH;
            end
          else
            Dec(tmp.Bottom,2);
          if (FImageListItem.Width>+Header.Sections[1].Width-4) then
            begin
              tmp.Right:=Rect.Right-2;
              flag:=DSF_STRETCH;
            end
          else
            tmp.Right:=tmp.Left+FImageListItem.Width;
          FImageListItem.DrawExt(lb.Canvas, tmp, flag, Index);
          exit;
        end
      else
        begin
          case FType of
            icBitmap: tmps:=inttostr(FBitmapList[t].Ident);
            icStringList: tmps:=IntToStr(FStringList[t].Items.Count);
            icWave: tmps:=IntToStr( FWaveList[t].Wave.Size);
            icGeneric: tmps:=Inttostr(FGenericList[t].Data.Size);
            icImageList: tmps:=Inttostr(FImageList[t].Count);
          end;
          LMDDrawTextExt(lb.Canvas, tmps, nil, tmp, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
        end;

      {Standard: Ident, Bitmap: Compressed}
      tmp.Left:=tmp.Right+2;
      tmp.Right:=tmp.Left+Header.Sections[2].Width-2;
      case FType of
        icBitmap: tmps:=inttostr(Ord(FBitmapList[t].Compressed));
        icStringList: tmps:=IntToStr(FStringList[t].Ident);
        icWave: tmps:=IntToStr( FWaveList[t].Ident);
        icGeneric: tmps:=Inttostr(FGenericList[t].Ident);
        icImageList: tmps:=Inttostr(LMDPixelFormatColors[FImageList[t].PixelFormat]);
      end;
      LMDDrawTextExt(lb.Canvas, tmps, nil, tmp, DT_LEFT or DT_VCENTER or DT_SINGLELINE);

      {Standard: Compressed, Bitmap: Colors}
      tmp.Left:=tmp.Right+2;
      tmp.Right:=tmp.Left+Header.Sections[3].Width-2;
      case FType of
        icBitmap: tmps:=inttostr(LMDPixelFormatColors[FBitmapList[t].PixelFormat]);
        icStringList: tmps:=IntToStr(Ord(FStringList[t].Compressed));
        icWave: tmps:=IntToStr(Ord(FWaveList[t].Compressed));
        icGeneric: tmps:=Inttostr(Ord(FGenericList[t].Compressed));
        icImageList: tmps:=IntToStr(FImageList[t].Width)+'x'+IntToStr(FImageList[t].Height);
      end;
      LMDDrawTextExt(lb.Canvas, tmps, nil, tmp, DT_LEFT or DT_VCENTER or DT_SINGLELINE);

      {Description}
      tmp.Left:=tmp.Right+2;
      tmp.Right:=tmp.Left+Header.Sections[4].Width-2;
      case FType of
        icBitmap: tmps:=FBitmapList[t].Description;
        icStringList: tmps:=FStringList[t].Description;
        icWave: tmps:=FWaveList[t].Description;
        icGeneric: tmps:=FGenericList[t].Description;
        icImageList: tmps:=Inttostr(Ord(FImageList[t].Masked));
      end;
      LMDDrawTextExt(lb.Canvas, tmps, nil, tmp, DT_LEFT or DT_VCENTER or DT_SINGLELINE);

      case FType of
        icImageList:
          begin
            tmp.Left:=tmp.Right+2;
            tmp.Right:=tmp.Left+Header.Sections[5].Width-2;
            LMDDrawTextExt(lb.Canvas, Inttostr(Ord(FImageList[t].Compressed)), nil,  tmp, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
          end;
        icBitmap:
          begin
            tmp.Left:=tmp.Right+2;
            if FBitmapList.Contents[t].Empty then
              begin
                tmp.Right:=tmp.Left+Header.Sections[5].Width-4;
                LMDDrawTextExt(lb.Canvas, srNone, nil, tmp, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
              end
            else
              begin
                Inc(tmp.Top,2);
                if FBitmapList.Items[t].Bitmap.Width<Rect.Right-tmp.Left then
                  tmp.Right:=tmp.Left+FBitmapList.Items[t].Bitmap.Width
                else
                  tmp.Right:=Rect.Right;

                if FBitmapList.Items[t].Bitmap.Height<lb.ItemHeight-4 then
                  tmp.Bottom:=tmp.Top+FBitmapList.Items[t].Bitmap.Height
                else
                  tmp.Bottom:=Rect.Bottom-2;

                FBitmapList.DrawExt(lb.Canvas, tmp, DSF_STRETCHKEEPRATIO, t, 0);
              end;
          end;
      end;

      if FType=icImageList then
        begin
          tmp.Left:=tmp.Right+2;
          tmp.Right:=tmp.Left+Header.Sections[6].Width-2;
          LMDDrawTextExt(lb.Canvas, FImageList[t].Description, nil,  tmp, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStdListEditorDlg.FormResize(Sender: TObject);
var
  tmp:Integer;
begin
  if Header.Sections.Count=0 then exit;

  case FType of
    icImageListItem: tmp:=40;
    icImageList: tmp:=210;
  else
    tmp:=216;
  end;
  Header.Sections[Header.Sections.Count-1].Width:=Header.Width-tmp;
  lb.Refresh;
end;

initialization
  RegisterClass(TLMDBitmapList);
  RegisterClass(TLMDStringList);
  RegisterClass(TLMDGenericList);
  RegisterClass(TLMDWaveList);
  RegisterClass(TLMDImageList);
  RegisterClass(TLMDImageListItem);

finalization
  UnRegisterClass(TLMDBitmapList);
  UnRegisterClass(TLMDStringList);
  UnRegisterClass(TLMDGenericList);
  UnRegisterClass(TLMDWaveList);
  UnRegisterClass(TLMDImageList);
  UnRegisterClass(TLMDImageListItem);
end.
