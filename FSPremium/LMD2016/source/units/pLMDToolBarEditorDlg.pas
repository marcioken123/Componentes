unit pLMDToolBarEditorDlg;
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

pLMDToolBarEditorDlg (VB)
-------------------------
This unit contains editor for TLMDToolBar.


Changes
-------
November 2012 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, LMDSimplePanel, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel,
  LMDCustomPanelFill, LMDButtonPanel, LMDCustomToolBar, LMDToolBar,
  ImgList, LMDPNGImageList, LMDCustomScrollBox, LMDScrollBox,
  LMDBaseControl, LMDBaseGraphicControl, LMDBaseGraphicButton,
  LMDCustomSpeedButton, LMDSpeedButton, LMDPanelFill, LMDDrawEdge, LMDCustomComponent, LMDIniCtrl,
  LMDVistaDialogs, StdCtrls, LMDCustomButton, LMDDockButton, LMDBaseEdit,
  LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit,
  LMDButton, LMDThemedComboBox, LMDCustomComboBox, LMDComboBox,
  LMDCustomImageList, LMDGraphicList, LMDBitmapList, LMDImageList;

type
  TLMDToolBarEditorDlg = class(TForm)
    pnlEditTools: TLMDSimplePanel;
    pnlOkCancel: TLMDSimplePanel;
    pngImageList: TLMDPNGImageList;
    sbx: TScrollBox;
    bpImages: TLMDButtonPanel;
    sbAddButton: TLMDSpeedButton;
    sbAddSeparator: TLMDSpeedButton;
    sbEditSeparatorFill: TLMDSpeedButton;
    sbEditToolBarFill: TLMDSpeedButton;
    tb: TLMDToolBar;
    IniCtrl: TLMDIniCtrl;
    OpenDialog: TLMDFileOpenDialog;
    sbEditBevel: TLMDSpeedButton;
    LMDDrawEdge1: TLMDDrawEdge;
    LMDDrawEdge2: TLMDDrawEdge;
    LMDDrawEdge3: TLMDDrawEdge;
    spbMakeFirst: TLMDSpeedButton;
    spbMoveRight: TLMDSpeedButton;
    spbMoveLeft: TLMDSpeedButton;
    spbMakeLast: TLMDSpeedButton;
    speButtonMargin: TLMDSpinEdit;
    Label1: TLabel;
    speButtonW: TLMDSpinEdit;
    speButtonH: TLMDSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    sbLoadGlyFX: TLMDSpeedButton;
    sbLoadPack1: TLMDSpeedButton;
    sbLoadPack2: TLMDSpeedButton;
    btnOk: TLMDButton;
    btnCancel: TLMDButton;
    cbThemeMode: TLMDComboBox;
    Label4: TLabel;
    cbBtnStyle: TLMDComboBox;
    Label5: TLabel;
    spbRemove: TLMDSpeedButton;
    spbClear: TLMDSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure sbxResize(Sender: TObject);
    procedure bpImagesButtonClick(Sender, SendBtn: TObject; Btn: Integer);
    procedure sbAddButtonClick(Sender: TObject);
    procedure sbAddSeparatorClick(Sender: TObject);
    procedure tbButtonClick(Sender, SendBtn: TObject; Btn: Integer);
    procedure sbEditSeparatorFillClick(Sender: TObject);
    procedure sbEditToolBarFillClick(Sender: TObject);
    procedure sbLoadGlyFXClick(Sender: TObject);
    procedure LoadImages;
    procedure sbLoadPack1Click(Sender: TObject);
    procedure sbEditBevelClick(Sender: TObject);
    procedure spbMakeFirstClick(Sender: TObject);
    procedure speButtonMarginChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure speButtonWChange(Sender: TObject);
    procedure speButtonHChange(Sender: TObject);
    procedure cbThemeModeChange(Sender: TObject);
    procedure cbBtnStyleChange(Sender: TObject);
    procedure spbRemoveClick(Sender: TObject);
    procedure spbClearClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    cbutton: TLMDToolButton;
    oldimgcount: integer;
    procedure UpdateEditFields;
    function GetImgList: TCustomImageList;
    { Private declarations }
  public
    procedure FillGlyphButtonBar;
    property ToolBar: TLMDToolBar read tb;
    property ToolbarImgList: TCustomImageList read GetImgList;
    property ImagePack: TLMDButtonPanel read bpImages; 
    { Public declarations }
  end;

var
  LMDToolBarEditorDlg: TLMDToolBarEditorDlg;

implementation

{$R *.dfm}
uses
  pLMDCPGetCore, LMDClass, LMDTypes, LMDButtonBase, LMDSBtn, LMDPNGImage, LMDGraph;

procedure TLMDToolBarEditorDlg.FormCreate(Sender: TObject);
begin
  cbutton := nil;
  FillGlyphButtonBar;
  iniCtrl.RegPath := LMDTOOLS_REGISTRYPATH;
end;

procedure TLMDToolBarEditorDlg.sbxResize(Sender: TObject);
begin
  bpImages.Width := sbx.ClientRect.Right;
end;

procedure TLMDToolBarEditorDlg.bpImagesButtonClick(Sender,
  SendBtn: TObject; Btn: Integer);
var
  j : integer;
  lbmp: TBitmap;
  pngobj : TLMDPNGObject;
begin
  cbutton := tb.AddToolButton(false);

  if ToolbarImgList=nil then
  begin
    pngobj := TLMDPNGObject.Create;
    TLMDPNGImageList(pngImageList).GetPNG(btn, pngobj);
    cbutton.PngGlyph := pngobj;
    cbutton.UsePngGlyph := true;
  end
  else
  if ToolbarImgList is TLMDPngImageList then
    cbutton.ImageIndex := TLMDPngImageList(ToolbarImgList).AddImage(pngImageList, Btn)
  else
  begin
    lbmp := TBitmap.Create;
    lbmp.Width := ToolbarImgList.Width;
    lbmp.Height := ToolbarImgList.Height;
    pngImageList.Draw(lbmp.Canvas, 0, 0, 0, Btn);

    if ToolbarImgList is TLMDGraphicList then
    begin
      TLMDGraphicList(ToolbarImgList).Graphics.Add.Picture.Bitmap := lbmp;
      j := TLMDGraphicList(ToolbarImgList).Count - 1;
      {$IFDEF LMD_FORCELISTINDEXUSE}
      cbutton.ListIndex := j
      {$ELSE}
      cbutton.ImageIndex := j;
      {$ENDIF}
    end
    else
    if ToolbarImgList is TLMDBitmapList then
    begin
      j := TLMDBitmapList(ToolbarImgList).Add;
      TLMDBitmapList(ToolbarImgList).Items[j].Bitmap := lbmp;
      {$IFDEF LMD_FORCELISTINDEXUSE}
      cbutton.ListIndex := j
      {$ELSE}
      cbutton.ImageIndex := j;
      {$ENDIF}
    end
    else
    if ToolbarImgList is TImageList then
    begin
      j := ToolbarImgList.Add(lbmp, nil);
      cbutton.ImageIndex := j;
    end
    else
    if ToolbarImgList is TLMDImageList then
    begin
      j := TLMDImageList(ToolbarImgList).Items[tb.ListIndex].Add(lbmp, nil);
      cbutton.ImageIndex := j;
    end;

  end;
  cbutton.ImageList := ToolbarImgList;
  tb.SetBorders;
end;

procedure TLMDToolBarEditorDlg.sbAddButtonClick(Sender: TObject);
begin
  cbutton := tb.AddToolButton(true);
  cbutton.ImageIndex := -1;
end;

procedure TLMDToolBarEditorDlg.sbAddSeparatorClick(Sender: TObject);
begin
  cbutton := tb.AddSeparator(true);
  cbutton.Separator.Enabled := true;
end;

procedure TLMDToolBarEditorDlg.tbButtonClick(Sender, SendBtn: TObject;
  Btn: Integer);
begin
  cbutton := TLMDToolButton(tb.Buttons[btn]);
end;

procedure TLMDToolBarEditorDlg.sbEditSeparatorFillClick(Sender: TObject);
begin
  LMDCPGetFillObject (tb.SeparatorFillObject);
end;

procedure TLMDToolBarEditorDlg.sbEditToolBarFillClick(Sender: TObject);
begin
  LMDCPGetFillObject (tb.FillObject);
end;

procedure TLMDToolBarEditorDlg.sbLoadGlyFXClick(Sender: TObject);
{$IFDEF LMDCOMP11}
var
  modalpopup: TPopupMode;
{$ENDIF}
begin
  {$IFDEF LMDCOMP11}
  modalpopup := Application.ModalPopupMode;
  Application.ModalPopupMode := pmNone;
  {$ENDIF}
  OpenDialog.DefaultFolder := 'C:\Program Files\Common Files\Borland Shared\Images\GlyFX\Icons\PNG';
  OpenDialog.Title := 'Open folder and select images to load';
  OpenDialog.FileName := '';
  if OpenDialog.Execute and (OpenDialog.Files.Count > 0) then
    LoadImages;
  {$IFDEF LMDCOMP11}
  Application.ModalPopupMode := modalpopup;
  {$ENDIF}
end;

procedure TLMDToolBarEditorDlg.FillGlyphButtonBar;
var
  i: integer;
  b: TLMDSpecialButton;
  PngChunk: TLMDPngChunk;
  s: ansistring;
begin
  Screen.Cursor := crHourGlass;
  try
    bpImages.ButtonWidth := pngImageList.Width * 2;
    bpImages.ButtonHeight := pngImageList.Height * 2;

    for i := 0 to pngImageList.Count - 1 do
    begin
      b := bpImages.Buttons.Add;
      b.ImageIndex := -1;
      b.Btn.Style := ubsOfficeTransp;

      PngChunk := pngImageList.PNG[i].Chunks.ItemFromClass(TLMDPNGChunkzTXT);
      if PngChunk <> nil then
        s := AnsiString(TLMDPNGChunkzTXT(PngChunk).Text)
      else
        s := '';

      b.Btn.Hint := string(s);
      b.Btn.ShowHint := true;
      b.ImageList := pngImageList;
      b.ImageIndex := i;
    end;
    bpImages.SetBorders;
  finally
    Screen.Cursor := crDefault;
  end
end;

procedure TLMDToolBarEditorDlg.LoadImages;
var
  pngImage: TLMDPngObject;
  i: integer;
  s: string;
  PngChunk: TLMDPngChunk;
  const
    fn: {$IFDEF LMD_NATIVEUNICODE}AnsiString{$ELSE}String{$ENDIF} = 'filename';
begin
  pngImage := TLMDPngObject.Create;
  bpImages.ImageList := nil;
  bpImages.Buttons.Clear;

  pngImage.LoadFromFile(OpenDialog.Files[0]);
  if (pngImageList.Width <> pngImage.Width) or (pngImageList.Height <> pngImage.Height) then
  begin
    pngImageList.Clear;
    pngImageList.Width := pngImage.Width;
    pngImageList.Height := pngImage.Height;
  end;

  pngImageList.AddPng(pngImage);

  for i := 1 to OpenDialog.Files.Count - 1 do
  begin
    pngImage := TLMDPngObject.Create;
    pngImage.LoadFromFile(OpenDialog.Files[i]);
    pngImageList.AddPng(pngImage);
    s := ExtractFileName(OpenDialog.Files[i]);
    PngChunk := pngImage.Chunks.ItemFromClass(TLMDPNGChunkzTXT);
    if PngChunk = nil then
      pngImage.AddztXt(fn, AnsiString(s));
  end;

  FillGlyphButtonBar;
  tb.ButtonWidth := bpImages.ButtonWidth;
  tb.ButtonHeight := bpImages.ButtonHeight;
  UpdateEditFields;
end;

procedure TLMDToolBarEditorDlg.sbLoadPack1Click(Sender: TObject);
var
  s: string;
begin
  OpenDialog.FileName := '';  

  if Sender = sbLoadPack1 then
    s := inictrl.ReadString('LMDToolBarEditorDlgSettings', 'Pack1Path', '')
  else
    s := inictrl.ReadString('LMDToolBarEditorDlgSettings', 'Pack2Path', '');
  if (s = '') or not (DirectoryExists(s)) then
    s := GetCurrentDir;

  OpenDialog.DefaultFolder := s;
  OpenDialog.Title := 'Open folder and select images to load';
  if OpenDialog.Execute and (OpenDialog.Files.Count > 0) then
  begin
    LoadImages;
    s := ExtractFilePath(OpenDialog.Files[0]);
    if Sender = sbLoadPack1 then
      inictrl.WriteString('LMDToolBarEditorDlgSettings', 'Pack1Path', s)
    else
      inictrl.WriteString('LMDToolBarEditorDlgSettings', 'Pack2Path', s)
  end;
end;

procedure TLMDToolBarEditorDlg.sbEditBevelClick(Sender: TObject);
begin
  LMDCPGetBevel(tb.Bevel);
end;

procedure TLMDToolBarEditorDlg.spbMakeFirstClick(Sender: TObject);
begin
  if cbutton = nil then
  begin
    ShowMessage('Please select toolbutton to be moved by mouse click!');
    exit;
  end;
  case integer(TLMDSpeedButton(Sender).Tag) of
  1: //make first
     cbutton.Index := 0;
  2: //move left
     if (cbutton.Index - 1) >= 0 then
       cbutton.Index := cbutton.Index - 1;
  3: //move right
     if cbutton.Index + 1 < tb.Buttons.count then
       cbutton.Index := cbutton.Index + 1;
  4: //make last
     cbutton.Index := tb.Buttons.count - 1;
  end;
end;

procedure TLMDToolBarEditorDlg.speButtonMarginChange(Sender: TObject);
begin
  tb.ButtonMargin := speButtonMargin.Value;
  tb.SetBorders;
end;

procedure TLMDToolBarEditorDlg.FormShow(Sender: TObject);
begin
  UpdateEditFields;
  if ToolbarImgList <> nil then
    oldimgcount := ToolbarImgList.Count;
end;

procedure TLMDToolBarEditorDlg.speButtonWChange(Sender: TObject);
begin
  tb.ButtonWidth := speButtonW.Value;
  tb.SetBorders;
end;

procedure TLMDToolBarEditorDlg.speButtonHChange(Sender: TObject);
begin
  tb.ButtonHeight := speButtonH.Value;
  tb.SetBorders;
end;

procedure TLMDToolBarEditorDlg.cbThemeModeChange(Sender: TObject);
begin
  tb.ThemeMode := TLMDThemeMode(cbThemeMode.ItemIndex);
end;

procedure TLMDToolBarEditorDlg.cbBtnStyleChange(Sender: TObject);
begin
  tb.ButtonStyle := TLMDUserButtonStyle(cbBtnStyle.ItemIndex);
end;

procedure TLMDToolBarEditorDlg.spbRemoveClick(Sender: TObject);
begin
  if tb.Buttons.Count = 0 then
  begin
    ShowMessage('Toolbar is empty!');
    exit;
  end;
  if cbutton = nil then
  begin
    ShowMessage('Please select toolbutton to be removed by mouse click!');
    exit;
  end;
  tb.Buttons.Delete(cbutton.Index);
  if tb.Buttons.Count > 0 then
    cbutton := tb.Button[tb.Buttons.Count - 1]
  else
    cbutton := nil;
end;

procedure TLMDToolBarEditorDlg.spbClearClick(Sender: TObject);
begin
  if MessageBox(handle, {$IFDEF UNICODE}PWideChar{$ELSE}PChar{$ENDIF}('Are you sure to clear buttons?'), pchar(Caption), MB_YESNO) = ID_YES then
  begin
    cbutton := nil;
    tb.Buttons.Clear;
  end;
end;

procedure TLMDToolBarEditorDlg.UpdateEditFields;
begin
  speButtonMargin.Value := tb.ButtonMargin;
  speButtonW.Value := tb.ButtonWidth;
  speButtonH.Value := tb.ButtonHeight;
  cbThemeMode.ItemIndex := ord(tb.ThemeMode);
  cbBtnStyle.ItemIndex := ord(tb.ButtonStyle);
end;


function TLMDToolBarEditorDlg.GetImgList: TCustomImageList;
begin
  result := tb.ImageList;
end;

procedure TLMDToolBarEditorDlg.btnCancelClick(Sender: TObject);
var
  i: integer;
begin
  if ToolBarImgList <> nil then
  for i:= oldimgcount - 1 to ToolBarImgList.Count - 1 do
  begin
    ToolBarImgList.Delete(i);
  end;
end;

end.
