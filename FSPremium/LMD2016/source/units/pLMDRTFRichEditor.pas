unit pLMDRTFRichEditor;
{$I LMDCmps.inc}

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

pLMDRTFRichEditor unit (RM)
----------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, ComCtrls, ToolWin, ImgList, ExtCtrls, StdCtrls,

  LMDRTFActions, LMDRTFRichEdit, LMDRTFFontComboBox, LMDRTFBase;

const
  ModifiedStates:array[Boolean] of String=('', 'Modified');

type
  TfrmLMDRichEditorForm = class(TForm)
    MainMenu: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    ImageList: TImageList;
    alToolbar: TActionList;
    Toolbar: TToolBar;
    btnNew1: TToolButton;
    actNew: TLMDRichEditNew;
    btnLoad1: TToolButton;
    actLoad: TLMDRichEditLoad;
    btnSave1: TToolButton;
    actSave: TLMDRichEditSave;
    Separator1: TToolButton;
    btnPrint1: TToolButton;
    actPrint: TLMDRichEditPrint;
    btnPreview1: TToolButton;
    actPreview: TLMDRichEditPreview;
    Separator2: TToolButton;
    btnFind1: TToolButton;
    actFind: TLMDRichEditFind;
    Separator3: TToolButton;
    btnCut1: TToolButton;
    actCut: TLMDRichEditCut;
    btnCopy1: TToolButton;
    actCopy: TLMDRichEditCopy;
    btnPaste1: TToolButton;
    actPaste: TLMDRichEditPaste;
    Separator4: TToolButton;
    btnUndo1: TToolButton;
    actUndo: TLMDRichEditUndo;
    btnRedo1: TToolButton;
    actRedo: TLMDRichEditRedo;
    btnTextAttributes1: TToolButton;
    actTextAttributes: TLMDRichEditTextAttributes;
    Separator6: TToolButton;
    btnTextBold1: TToolButton;
    actTextBold: TLMDRichEditTextBold;
    btnTextItalic1: TToolButton;
    actTextItalic: TLMDRichEditTextItalic;
    btnTextUnderline1: TToolButton;
    actTextUnderline: TLMDRichEditTextUnderline;
    actTextSubscript: TLMDRichEditTextSubscript;
    actTextSuperscript: TLMDRichEditTextSuperscript;
    Separator8: TToolButton;
    btnParaAlign1: TToolButton;
    actParaAlign1: TLMDRichEditParaAlign;
    btnParaAlign2: TToolButton;
    actParaAlign2: TLMDRichEditParaAlign;
    btnParaAlign3: TToolButton;
    actParaAlign3: TLMDRichEditParaAlign;
    Separator9: TToolButton;
    btnNumbering1: TToolButton;
    actNumbering1: TLMDRichEditNumbering;
    btnNumbering2: TToolButton;
    actNumbering2: TLMDRichEditNumbering;
    btnIndent1: TToolButton;
    actIndent: TLMDRichEditIndent;
    btnUnindent1: TToolButton;
    actUnindent: TLMDRichEditUnindent;
    Openafile1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Print1: TMenuItem;
    Preview1: TMenuItem;
    Edit1: TMenuItem;
    Find1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N2: TMenuItem;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    N3: TMenuItem;
    Format1: TMenuItem;
    Font1: TMenuItem;
    Numbering1: TMenuItem;
    StatusBar: TStatusBar;
    FormatBar: TToolBar;
    LMDRichFontComboBox1: TLMDRichFontComboBox;
    fsc: TLMDRichFontSizeComboBox;
    ToolButton2: TToolButton;
    Label1: TLabel;
    N4: TMenuItem;
    Exit1: TMenuItem;
    Insert1: TMenuItem;
    DateandTime1: TMenuItem;
    Object1: TMenuItem;
    SelectAll1: TMenuItem;
    actSelectAll: TLMDRichEditSelectAll;
    Delete1: TMenuItem;
    Symbol1: TMenuItem;
    View1: TMenuItem;
    vwToolbar: TMenuItem;
    vwFormatBar: TMenuItem;
    Paragraph1: TMenuItem;
    Tabstops1: TMenuItem;
    Replace1: TMenuItem;
    vwStatusBar: TMenuItem;
    vwRuler: TMenuItem;
    PageSettings1: TMenuItem;
    actDelete: TLMDRichEditDelete;
    actParagraph: TLMDRichEditParagraph;
    actInsertDateTime: TLMDRichEditInsertDateTime;
    actInsertChar: TLMDRichEditInsertChar;
    actInsertObject: TLMDRichEditInsertObject;
    Label2: TLabel;
    btnColors: TToolButton;
    mnuColors: TPopupMenu;
    mnuBlack: TMenuItem;
    mnuMaroon: TMenuItem;
    mnuGreen: TMenuItem;
    mnuOlive: TMenuItem;
    mnuNavy: TMenuItem;
    mnuPurple: TMenuItem;
    mnuTeal: TMenuItem;
    mnuGray: TMenuItem;
    mnuSilver: TMenuItem;
    mnuRed: TMenuItem;
    mnuLime: TMenuItem;
    mnuYellow: TMenuItem;
    mnuBlue: TMenuItem;
    mnuFuchsia: TMenuItem;
    mnuAqua: TMenuItem;
    mnuWhite: TMenuItem;
    mnuAutomatic: TMenuItem;
    Custom1: TMenuItem;
    ColorDialog: TColorDialog;
    N7: TMenuItem;
    vwMeasurement: TMenuItem;
    vwmPoints: TMenuItem;
    vwmInches: TMenuItem;
    vwmMillimeters: TMenuItem;
    N8: TMenuItem;
    vwWordWrap: TMenuItem;
    vwMode: TMenuItem;
    vwoPrinterSupport: TMenuItem;
    vwoAppOnly: TMenuItem;
    actReplace: TLMDRichEditReplace;
    N9: TMenuItem;
    vwStatistics: TMenuItem;
    actSaveAs: TLMDRichEditSaveAs;
    Savefileas1: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    actMenuColors: TLMDRichEditBaseEditAction;
    actPrintDialog: TLMDRichEditPrint;
    actTabs: TLMDRichEditBaseEditAction;
    Panel1: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    actStatistics: TLMDRichEditStatistics;
    LMDRichEdit: TLMDRichEdit;
    actPageSetting: TLMDRichEditPageSetting;
    actInsertBitmap: TLMDRichEditBaseEditAction;
    InsertBitmap1: TMenuItem;
    N10: TMenuItem;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure OnViewClick(Sender: TObject);
    procedure OnactionClick(Sender: TObject);
    procedure LMDRichEditSelectionChange(Sender: TObject);
    procedure mnuColorClick(Sender: TObject);
    procedure mnuColorDrawItem(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
    procedure LMDRichEditChange(Sender: TObject);
    procedure Measurement1Click(Sender: TObject);
    procedure vwWordWrapClick(Sender: TObject);
    procedure ModeClick(Sender: TObject);
    procedure actSaveUnknownFilename(Sender, Target: TObject;
      var Saved: Boolean);
    procedure actTabsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actInsertBitmapUpdate(Sender: TObject);
  private
    fComponent: TComponent;
    FPicPath: String;
    procedure WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure SetBComponent(C: TComponent);
    procedure AdjustControlItems;
    function  ExecuteStrings(const ACaption: string; C: TStrings): Boolean;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    class function  ExecuteEx(const ACaption: string; C: TPersistent): Boolean;
    class function  ExecuteRTFStrings(const ACaption: string; C: TStrings;
            WordWrap, AllowObjects: Boolean): Boolean;
    function  Execute(const ACaption: string; C: TComponent): Boolean;
    property  BaseComponent: TComponent read fComponent write SetBComponent;
  end;

function  LMDRTFEditComponent(const ACaption: string; C: TPersistent): Boolean;

implementation
uses
  ShellAPI, ExtDlgs,

  pLMDCst, pLMDCommon,

  LMDRTFLabel;

{$R *.dfm}

function LMDRTFEditComponent(const ACaption: string; C: TPersistent): Boolean;
begin
  Result := TfrmLMDRichEditorForm.ExecuteEx(ACaption, C);
end;

class function TfrmLMDRichEditorForm.ExecuteEx(const ACaption: string; C: TPersistent): Boolean;
var
  Frm: TfrmLMDRichEditorForm;
begin
  Result := False;
  Frm := TfrmLMDRichEditorForm.Create(Application);

  try
    if (C is TLMDCustomRichEdit) or (C is TLMDCustomRichLabel) or(C is TCustomMemo) then
    begin
      Result := Frm.Execute(ACaption, TComponent(C));
    end else begin
      if  C is TStrings then begin
        Result := Frm.ExecuteStrings(ACaption, TStrings(C));
      end;
    end;
  finally
    Frm.Free;
  end;
end;

function TfrmLMDRichEditorForm.ExecuteStrings(const ACaption: string; C: TStrings): Boolean;
begin
  Caption := ACaption;
  LMDRichEdit.PlainText := True;
  LMDRichEdit.WordWrap := False;
  LMDRichEdit.Lines := C;
  LMDRichEdit.Modified := False;
  LMDRichEditSelectionChange(LMDRichEdit);

  Result := (ShowModal = mrOK);

  if Result then
    begin
      C.Assign(LMDRichEdit.Lines);
    end;
end;

class function TfrmLMDRichEditorForm.ExecuteRTFStrings(const ACaption: string; C: TStrings;
                      WordWrap, AllowObjects: Boolean): Boolean;
var
  Frm: TfrmLMDRichEditorForm;
  MS: TMemoryStream;
begin
  MS := nil;
  Frm := TfrmLMDRichEditorForm.Create(Application);

  try
    Frm.Caption := ACaption;
    Frm.vwMeasurement.Visible := False;
    Frm.vwMode.Visible := False;
    Frm.LMDRichEdit.ShowRuler := True;
    Frm.LMDRichEdit.Mode := edModeAppOnly;
    Frm.LMDRichEdit.AllowObjects := AllowObjects;
    Frm.LMDRichEdit.WordWrap := WordWrap;
    Frm.LMDRichEdit.HandleNeeded;
    Frm.LMDRichEdit.Lines := C;
    Frm.LMDRichEdit.Modified := False;
    Frm.LMDRichEditSelectionChange(Frm.LMDRichEdit);

    Result := (Frm.ShowModal = mrOK);

    if Result then
      begin
        MS := TMemoryStream.Create;
        Frm.LMDRichEdit.Lines.SaveToStream(MS);
        MS.Position := 0;
        C.LoadFromStream(MS);
      end;
  finally
    MS.Free;
    Frm.Free;
  end;
end;

function  TfrmLMDRichEditorForm.Execute(const ACaption: string; C: TComponent): Boolean;
var
  RE: TLMDCustomRichEdit;
  RL: TLMDCustomRichLabel;
  OldCurs: TCursor;
  dLines: TStrings;
begin
  Result := False;
  Caption := ACaption;
  BaseComponent := C;
  LMDRichEdit.Modified := False;
  LMDRichEditSelectionChange(LMDRichEdit);

  if  ShowModal = mrOK  then
    begin
      Result := True;

      if  Assigned(C) then
        begin
          dLines := nil;
          OldCurs := Screen.Cursor;

          try
            Screen.Cursor := crHourGlass;

            if  C is TLMDCustomRichEdit then
              dLines := TLMDCustomRichEdit(C).Lines
            else
            if  C is TLMDCustomRichLabel  then
              dLines := TLMDCustomRichLabel(C).Lines
            else
            if  C is TCustomMemo  then
              dLines := TCustomMemo(C).Lines;

            if  Assigned(dLines)  then
              dLines.BeginUpdate;

            if  C is TLMDCustomRichEdit then
              begin
                fComponent := C;
                RE := TLMDCustomRichEdit(C);
                RE.Clear;
                RE.WordWrap := LMDRichEdit.WordWrap;
                RE.Mode := LMDRichEdit.Mode;
                RE.Measurement := LMDRichEdit.Measurement;
                RE.ShowRuler := LMDRichEdit.ShowRuler;
                RE.Lines := LMDRichEdit.Lines;
              end
            else
            if  C is TLMDCustomRichLabel  then
              begin
                RL := TLMDCustomRichLabel(C);
                RL.Lines.Clear;
                RL.WordWrap := LMDRichEdit.WordWrap;
                RL.Lines := LMDRichEdit.Lines;
              end
            else
            if  C is TCustomMemo  then
              begin
                TCustomMemo(C).Clear;

                if  C is TMemo  then
                  TMemo(C).WordWrap := LMDRichEdit.WordWrap;

                TCustomMemo(C).Lines := LMDRichEdit.Lines;
              end;

          finally
            if  Assigned(dLines)  then
              dLines.EndUpdate;

            Screen.Cursor := OldCurs;
          end;
        end
    end;
end;

procedure TfrmLMDRichEditorForm.SetBComponent(C: TComponent);
var
  RE: TLMDCustomRichEdit;
  RL: TLMDCustomRichLabel;
  OldCurs: TCursor;
begin
  fComponent := nil;

  if  Assigned(C) then
    begin
      if  Caption = ''  then
        Caption := C.Owner.Name + '.' + C.Name + ' - ' + C.ClassName + '  ' + Caption;
      OldCurs := Screen.Cursor;

      try
        Screen.Cursor := crHourGlass;
        if  C is TLMDCustomRichEdit then
          begin
            fComponent := C;
            RE := TLMDCustomRichEdit(C);
            LMDRichEdit.Clear;
            LMDRichEdit.PlainText := RE.PlainText;
            LMDRichEdit.WordWrap := RE.WordWrap;
            LMDRichEdit.Mode := RE.Mode;
            LMDRichEdit.Measurement := RE.Measurement;
            LMDRichEdit.ShowRuler := RE.ShowRuler;
            LMDRichEdit.MaxLength:= RE.MaxLength;
            LMDRichEdit.Lines := RE.Lines;
            actInsertBitmap.Visible := RE.AllowObjects;
          end
        else
        if  C is TLMDCustomRichLabel  then
          begin
            RL := TLMDCustomRichLabel(C);
            vwMeasurement.Visible := False;
            vwMode.Visible := False;
//            vwFormatBar.Visible := False;
            LMDRichEdit.AllowObjects := RL.AllowObjects;
            LMDRichEdit.WordWrap := RL.WordWrap;
            LMDRichEdit.Mode := edModeAppOnly;
            LMDRichEdit.Lines := RL.Lines;
            actPageSetting.Visible := False;
        end
        else
        if  C is TCustomMemo  then
          begin
            LMDRichEdit.Clear;
            LMDRichEdit.PlainText := True;

            if  C is TMemo then
            begin
              LMDRichEdit.Font := TMemo(C).Font;
              LMDRichEdit.WordWrap := TMemo(C).WordWrap;
            end;

            LMDRichEdit.Lines := TCustomMemo(C).Lines;
          end;
      finally
        Screen.Cursor := OldCurs;
      end;
    end
  else
    begin
    end;
end;

// Handle menuitems in View Menu
procedure TfrmLMDRichEditorForm.OnViewClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked:=not TMenuItem(Sender).Checked;
  ToolBar.Visible:=vwToolBar.Checked;
  FormatBar.Visible:=vwFormatBar.Checked;

  if  FormatBar.Visible then
    FormatBar.Top:=24;  // make sure that formatbar is placed below Toolbar

  StatusBar.Visible:=vwStatusBar.Checked;
  LMDRichEdit.ShowRuler:=vwRuler.Checked;
end;

// Tabstops Action
procedure TfrmLMDRichEditorForm.actTabsExecute(Sender: TObject);
begin
  LMDRichEdit.Paragraph.TabsDialog;
end;

// handle several menu clicks
procedure TfrmLMDRichEditorForm.OnActionClick(Sender: TObject);
var
  tmp : TPicture;
  I : Integer;
begin

  I := TComponent(Sender).Tag;

  case I of
    30: LMDRichEdit.PagePropertiesDialog;
    50: begin
          tmp:=TPicture.Create;
          with TOpenPictureDialog.Create(nil) do
            try
              InitialDir:=FPicPath;
              if Execute then
                begin
                  tmp.LoadFromFile(FileName);
                  LMDRichEdit.InsertGraphic(tmp.Graphic);
                  FPicPath:=ExtractFilePath(FileName);
                end;
            finally
              Free;
              tmp.Free;
            end;
        end;
  1000: Close;
  end;
end;

// Update Statusbar
procedure TfrmLMDRichEditorForm.LMDRichEditSelectionChange(Sender: TObject);
begin
  // Cursor Position
  with  LMDRichEdit.CursorPos do
    StatusBar.Panels[0].Text:=Format('%d: %d', [y, x]);
  LMDRichEditChange(nil);  // --> Modified State
end;

procedure TfrmLMDRichEditorForm.LMDRichEditChange(Sender: TObject);
begin
  // Displays Modified State in the StatusBar
  StatusBar.Panels[1].Text:=ModifiedStates[LMDRichEdit.Modified];
end;
{
// used to open a file and update info settings
procedure TfrmLMDRichDialogForm.PerformFileOpen(const FileName: string);
begin
  if  FileExists(FileName)  then
    begin
      LMDRichEdit.Lines.LoadFromFile(FileName);
      LMDRichEditChange(LMDRichEdit);
    end;
end;
}
procedure TfrmLMDRichEditorForm.FormShow(Sender: TObject);
begin
  AdjustControlItems;
end;

procedure TfrmLMDRichEditorForm.AdjustControlItems;
var
  i: integer;
begin
  actInsertBitmap.Visible := LMDRichEdit.AllowObjects;

  if  LMDRichEdit.PlainText then
    begin
      LMDRichEdit.ShowRuler := False;
      Separator1.Visible := False;
      Format1.Visible := False;
      vwRuler.Checked := False;
      vwRuler.Visible := False;
      vwWordWrap.Checked := False;
      vwWordWrap.Visible := False;
      vwFormatBar.Checked := False;
      vwFormatBar.Visible := False;
      FormatBar.Visible := False;
      actPageSetting.Visible := False;
      vwMeasurement.Visible := False;
      vwMode.Visible := False;
      actPrint.Visible := False;
      actPrintDialog.Visible := False;
      actPreview.Visible := False;
      actPageSetting.Visible := False;
      actInsertObject.Visible := False;
      actInsertBitmap.Visible := False;
      LMDRichEdit.Mode := edModeAppOnly;
      Separator1.Visible := False;
    end;

  // initialize menu items
  vwRuler.Checked := LMDRichEdit.ShowRuler;
  vwWordWrap.Checked := LMDRichEdit.WordWrap;
  if LMDRichEdit.Mode = edModePrinterSupport then
    vwoPrinterSupport.Checked := True
  else
    vwoAppOnly.Checked := True;

  if  LMDRichEdit.Mode = edModeAppOnly  then
    begin
      actPrintDialog.Visible := False;
      actPreview.Visible := False;
      actPageSetting.Visible := False;
    end;

  actInsertObject.Visible := actInsertBitmap.Visible;

  if  vwMeasurement.Visible then
    for i := 0 to vwMeasurement.Count - 1 do
      if  vwMeasurement.Items[i].Tag = integer(LMDRichEdit.Measurement)  then
        begin
          vwMeasurement.Items[i].Checked := True;
          Break;
        end;
end;

procedure TfrmLMDRichEditorForm.Measurement1Click(Sender: TObject);
begin
  // select measurement which is used in LMDRichEdit
  (Sender as TMenuItem).Checked := True;
  LMDRichEdit.Measurement := TLMDMeasurement(TMenuItem(Sender).Tag);
end;

procedure TfrmLMDRichEditorForm.vwWordWrapClick(Sender: TObject);
var
  SelStart: integer;
begin
  // enable/disable WordWrap and restore current cursor position
  vwWordWrap.Checked := not vwWordWrap.Checked;
  SelStart := LMDRichEdit.SelStart;
  LMDRichEdit.WordWrap := vwWordWrap.Checked;
  LMDRichEditChange(nil);
  LMDRichEdit.SelStart := SelStart;
end;

procedure TfrmLMDRichEditorForm.ModeClick(Sender: TObject);
begin
  if sender = vwoAppOnly then
    LMDRichEdit.Mode := edModeAppOnly
  else
    LMDRichEdit.Mode := edModePrinterSupport;
  TMenuItem(Sender).Checked:=True;
end;

procedure TfrmLMDRichEditorForm.actSaveUnknownFilename(Sender, Target: TObject; var Saved: Boolean);
begin
  // this event is generated when Save action is executed, but RichEdit.Title us empty.
  // We forwared here action to actSaveAs...
  actSaveAs.ExecuteTarget(Target);
  Saved:=actSaveAs.Saved;
end;

// The OwnerDrawItem handler for ColorMenu
procedure TfrmLMDRichEditorForm.mnuColorDrawItem(Sender: TObject;
    ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
var
  tmp : TRect;
  T : integer;
begin
  T := TComponent(Sender).Tag;

  with aCanvas do
    begin
      Brush.Style := bsSolid;
      if odSelected in State then Brush.Color := clHighlight else Brush.Color := clMenu;
      FillRect(aRect);
      with aRect do
        begin
        tmp := Classes.Rect(Left+4, Top+2, Left+22, Bottom-2);
        if (T = 1) then
            Brush.Color:=LMDRichEdit.Font.Color
          else
          if  (T = 2)  then
            Brush.Color:= LMDRichEdit.SelAttributes.Color
          else
            Brush.Color:=TColor(TComponent(Sender).Tag);
          Rectangle(tmp.Left, tmp.Top, tmp.Right, tmp.Bottom);
          if odSelected in State then Font.Color := clHighlightText else Brush.Color := clMenuText;
          Brush.Style := bsClear;
          TextOut(tmp.Right+6, tmp.Top+2, Trim(TMenuItem(Sender).Caption));
        end;
    end;
end;

// Handle clicks in Color Popup menu
procedure TfrmLMDRichEditorForm.mnuColorClick(Sender: TObject);
begin
  if TComponent(Sender).Tag = 1 then
    LMDRichEdit.SelAttributes.Color:=LMDRichEdit.Font.Color
  else
  if TComponent(Sender).Tag = 2 then
    begin
      ColorDialog.Color := LMDRichEdit.SelAttributes.Color;

      if  ColorDialog.Execute then
        LMDRichEdit.SelAttributes.Color := ColorDialog.Color;
    end
  else
    LMDRichEdit.SelAttributes.Color:=TColor(TComponent(Sender).Tag);
end;

procedure TfrmLMDRichEditorForm.WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo);
begin
  inherited;

  with Msg.MinMaxInfo.ptMinTrackSize do
  begin
    x := self.Constraints.MinWidth;
    y := self.Constraints.MinHeight;
  end;
end;

procedure TfrmLMDRichEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if  (Key = VK_ESCAPE) and (Shift = [])  then
    ModalResult := mrCancel 
end;

procedure TfrmLMDRichEditorForm.actInsertBitmapUpdate(Sender: TObject);
begin
  actInsertBitmap.Enabled:=LMDRichEdit.Focused;
end;

procedure TfrmLMDRichEditorForm.WndProc(var Message: TMessage);
begin
  inherited;
end;

end.
