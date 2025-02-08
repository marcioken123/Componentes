unit pLMDStdItemPropertiesEditorDlg;
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

TLMDStdListItemPropertiesEditorDlg unit (RM)
--------------------------------------------
Unified item editor for different container classes.

Changes
-------
Release 8.0 (April 2006)
 - Initial Release
###############################################################################}

interface

uses
  Windows,  Messages, Classes, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  LMDCustomComponent, LMDCustomContainer, LMDWave, LMDShSpinEdit, Menus,
  ComCtrls, ToolWin, LMDImageList;

type
  TLMDStdItemForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    nb: TNotebook;
    LMDSimpleLabel1: TLabel;
    IndexW: TLabel;
    LMDSimpleLabel3: TLabel;
    LMDSimpleLabel5: TLabel;
    LMDSimpleLabel2: TLabel;
    edW: TLMDShSpinEdit;
    btnWchange: TButton;
    descw: TEdit;
    compressedw: TCheckBox;
    LMDLabel1: TLabel;
    indexb: TLabel;
    LMDLabel4: TLabel;
    LMDLabel5: TLabel;
    dimLabel: TLabel;
    img: TImage;
    LMDLabel2: TLabel;
    edb: TLMDShSpinEdit;
    btnbChange: TButton;
    compressedb: TCheckBox;
    descb: TEdit;
    LMDGLabel1: TLabel;
    indexg: TLabel;
    LMDGLabel4: TLabel;
    dimlabelg: TLabel;
    LMDGLabel2: TLabel;
    LMDGLabel5: TLabel;
    btngChange: TButton;
    compressedg: TCheckBox;
    descg: TEdit;
    edg: TLMDShSpinEdit;
    clear: TButton;
    Label4: TLabel;
    cmbb: TComboBox;
    LMDSimplePanel1: TPanel;
    Label5: TLabel;
    IndexS: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edS: TLMDShSpinEdit;
    descS: TEdit;
    compressedS: TCheckBox;
    LMDSimpleLabel4: TLabel;
    l: TLabel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Editor: TMemo;
    editmenu: TPopupMenu;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    N1: TMenuItem;
    Selectall1: TMenuItem;
    mfile: TPopupMenu;
    mnuOpen: TMenuItem;
    mnuSave: TMenuItem;
    Label10: TLabel;
    lblWidth: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Maske: TCheckBox;
    compress: TCheckBox;
    ed3: TLMDShSpinEdit;
    ed2: TLMDShSpinEdit;
    desc: TEdit;
    LMDButton1: TButton;
    cmb: TComboBox;
    ed1: TLMDShSpinEdit;
    Count: TLabel;
    mk: TCheckBox;
    rows: TComboBox;
    Label14: TLabel;
    lblsize: TLabel;
    aviLoad: TButton;
    aviPlay: TButton;
    Ani: TAnimate;
    btnConvert: TButton;
    lblframes: TLabel;
    Load: TButton;
    Save: TButton;
    Play: TButton;
    btnWClear: TButton;
    pnlWave: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    format: TLabel;
    size: TLabel;
    bits: TLabel;
    Label23: TLabel;
    Channels: TLabel;
    Label7: TLabel;
    samplerate: TLabel;
    procedure btnWchangeClick(Sender: TObject);
    procedure clearClick(Sender: TObject);
    procedure nbPageChanged(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OnEditClick(Sender: TObject);
    procedure editmenuPopup(Sender: TObject);
    procedure EditorChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConvertClick(Sender: TObject);
  private
  public
    cWave:TLMDWave;
    ImageListItem:TLMDImageListItem;
    procedure SetLabels;
  end;

implementation
uses
  Consts, ExtDlgs, Graphics, SysUtils, ClipBrd, Types,
  LMDGraphUtils, LMDExtDialogs, pLMDPECst,pLMDDsgnCPGetX;

{$R *.DFM}

procedure TLMDStdItemForm.btnWchangeClick(Sender: TObject);
var
  tmp:TBitmap;
begin
  if sender=aviload then
    with TOpenDialog.Create(nil) do
      try
        Title:='Load AVI';
        Filename:='*.avi';
        DefaultExt:='avi';
        InitialDir:=LMDRestoreItemPath(piAVI);
        Filter:='AVI Files (*.avi)|*.avi';
        Options := [ofHideReadOnly, ofFileMustExist];
        if Execute then
          begin
            ani.FileName:=FileName;
            LMDSaveItemPath(piAVI, ExtractFilePath(FileName));
          end;
      finally
        Free;
      end;

  if sender=aviplay then
    if ani.FileName<>'' then ani.Active:=True;

  if sender=btngChange then
    with TOpenDialog.Create(nil) do
      try
        DefaultExt :='*';
        FileName:='*.'+DefaultExt;
        Filter := sDefaultFilter;
        InitialDir:=LMDRestoreItemPath(piGeneric);
        Options := [ofHideReadOnly, ofFileMustExist];
        if Execute then
          begin
            dimLabelg.Caption:=FileName;
            LMDSaveItemPath(piGeneric, ExtractFilePath(FileName));
          end;
      finally
        Free;
      end;

  if sender=btnBChange then
    with TOpenPictureDialog.Create(nil) do
      try
        DefaultExt := GraphicExtension(TBitmap);
        FileName:='*.'+DefaultExt;
        Filter :=GraphicFilter(TBitmap);
        Options := [ofHideReadOnly, ofFileMustExist];
        InitialDir:=LMDRestoreItemPath(piBitmap);
        if Execute then
          begin
            self.img.Picture.Bitmap.LoadFromFile(FileName);
            LMDSaveItemPath(piBitmap, ExtractFilePath(FileName));
          end;
        dimLabel.Caption := '('+IntToStr( self.img.Picture.Bitmap.Width) + 'x' +
                            IntToStr( self.img.Picture.Bitmap.Height)+')';
      finally
        Free;
      end;

   if (sender=btnWChange) or (sender=Load) then
     with TLMDOpenWaveDialog.Create(nil) do
       try
         Filename:='*.wav';
         DefaultExt:='wav';
         Options := [ofHideReadOnly, ofFileMustExist];
         InitialDir:=LMDRestoreItemPath(piWave);
         if Execute then
           begin
             cWave.LoadFromFile(FileName);
             LMDSaveItemPath(piWave, ExtractFilePath(FileName));
           end;
         SetLabels;
       finally
         Free;
       end;

   if (sender=Save) then
     with TLMDSaveWaveDialog.Create(nil) do
       try
         DefaultExt:='wav';
         Options := [ofHideReadOnly, ofOverwritePrompt];
         InitialDir:=LMDRestoreItemPath(piWave);
         if Execute then
           begin
             cWave.SaveToFile(FileName);
             LMDSaveItemPath(piWave, ExtractFilePath(FileName));
           end;
         SetLabels;
       finally
         Free;
       end;

   if sender=Play then
     if not cWave.Empty then
       cWave.Play;

   if (sender=btnWClear) then
     begin
       cWave.FreeWave;
       SetLabels;
     end;

   if Sender=mnuOpen then
     with TOpenDialog.Create(nil) do
       try
         Filename:='*.txt';
         DefaultExt:='txt';
         Filter:='Text files (*.txt)|*.txt|All files|*.*';
         Options := [ofHideReadOnly, ofFileMustExist];
         InitialDir:=LMDRestoreItemPath(piText);
         if Execute then
           begin
             Editor.Lines.LoadFromFile(FileName);
             LMDSaveItemPath(piText, ExtractFilePath(FileName));
           end;
         SetLabels;
       finally
         Free;
       end;

   if Sender=mnuSave then
     with TSaveDialog.Create(nil) do
       try
         Filename:='*.txt';
         DefaultExt:='txt';
         Filter:='Text files (*.txt)|*.txt|All files|*.*';
         Options:=[ofHideReadOnly, ofNoReadOnlyReturn];
         InitialDir:=LMDRestoreItemPath(piText);
         if Execute then
           begin
             Editor.Lines.SaveToFile(FileName);
             LMDSaveItemPath(piText, ExtractFilePath(FileName));
           end;
         SetLabels;
       finally
         Free;
       end;

   if Sender=LMDButton1 then
      with TOpenPictureDialog.Create(nil) do
        try
          DefaultExt := GraphicExtension(TBitmap);
          FileName:='*.'+DefaultExt;
          Filter := GraphicFilter(TBitmap);
          InitialDir:=LMDRestoreItemPath(piBitmap);
          if Execute then
            begin
              tmp:=TBitmap.Create;
              try
                tmp.LoadFromFile(FileName);
                ed2.Value:=tmp.Width;
                ed1.Value:=tmp.Height;
                LMDSaveItemPath(piBitmap, ExtractFilePath(FileName));
              finally
                tmp.Free;
              end;
            end;
        finally
          Free;
        end;

end;

procedure TLMDStdItemForm.SetLabels;
begin
  if nb.ActivePage='WaveStandAlone' then
    begin
      Save.Enabled := not cWave.Empty;
      Play.Enabled:= not cWave.Empty;
      btnWClear.enabled:=not cWave.Empty;
    end;

  if (nb.ActivePage='Wave') or (nb.ActivePage='WaveStandAlone') then
    with cWave do
      If Empty then
        begin
          self.Format.Caption:=IDS_NOWAVESELECTED;
          self.SampleRate.caption:='---';
          self.Size.caption:='---';
          self.Bits.caption:='---';
          self.Channels.caption:='---';
        end
      else
        begin
          case format of
            wfPCM: self.Format.Caption:='PCM-Wave';
          else
            self.Format.Caption:=srUNKNOWN;
          end;

          case ChannelMode of
            cmMono: self.Channels.Caption:='Mono';
            cmStereo: self.Channels.Caption:='Stereo';
          else
            self.Format.Caption:=srUNKNOWN;
          end;

          self.SampleRate.caption:=inttostr(SampleRate)+' Hz';;
          self.Size.caption:=inttostr(Size)+' Bytes';
          self.Bits.caption:=inttostr(Bits)+' Bit';
        end;

  if nb.ActivePage='StringList' then
    l.Caption:=Inttostr(editor.Lines.Count);
end;

procedure TLMDStdItemForm.clearClick(Sender: TObject);
begin
  dimLabelg.Caption:='';
end;

procedure TLMDStdItemForm.nbPageChanged(Sender: TObject);
begin
  if (nb.ActivePage='Wave') or (nb.ActivePage='WaveStandAlone') then
    if not Assigned(cWave) then cWave:=TLMDWave.Create;
  if nb.ActivePage='WaveStandAlone' then
    begin
      pnlWave.Parent:=nb;
      pnlWave.Left:=10;
      pnlWave.Top:=7;
    end;

end;

procedure TLMDStdItemForm.FormDestroy(Sender: TObject);
begin
  if Assigned(cWave) then
    FreeAndNil(cWave);
  if Assigned(ImageListItem) then
    FreeAndNil(ImageListItem);
end;

procedure TLMDStdItemForm.OnEditClick(Sender: TObject);
begin
  case Integer(TComponent(Sender).Tag) of
    0: Editor.CutToClipboard;
    1: Editor.CopyToClipboard;
    2: Editor.PasteFromClipBoard;
    3: Editor.ClearSelection;
    4: Editor.SelectAll;
  end;
end;

procedure TLMDStdItemForm.editmenuPopup(Sender: TObject);
var
  HasSelection: Boolean;
begin
  Paste1.Enabled := Clipboard.HasFormat(CF_TEXT);
  HasSelection := Editor.SelLength > 0;
  Cut1.Enabled := HasSelection;
  Copy1.Enabled := HasSelection;
  Delete1.Enabled := HasSelection;
end;

procedure TLMDStdItemForm.EditorChange(Sender: TObject);
begin
  SetLabels;
end;

procedure TLMDStdItemForm.FormCreate(Sender: TObject);
begin
  ImageListItem:=nil;
end;

procedure TLMDStdItemForm.btnConvertClick(Sender: TObject);
var
  i:Integer;
  t:TBitmap;
begin
  if not Assigned(ImageListItem) then
    ImageListItem:=TLMDImageListItem.Create(nil)
  else
    ImageListItem.Clear;

  if (ani.FileName<>'') and (ani.FrameCount>0) then
    with ani do
      begin
        t:=TBitmap.Create;
        try
          ImageListItem.Height:=FrameHeight;
          ImageListItem.Width:=FrameWidth;
          ImageListItem.Masked:=false;
          for i:=1 to ani.FrameCount do
            begin
              ani.StartFrame:=i;
              LMDBmpFromDesktop(t, Types.Bounds(ClientOrigin.X, ClientOrigin.Y, FrameWidth, FrameHeight));
              Application.ProcessMessages;
              ImageListItem.Add(t, nil);
            end;
        finally
          t.Free;
        end;
      end;

  lblframes.Caption:=SysUtils.Format('%d frame(s)', [ImageListItem.Count]);
end;

end.

