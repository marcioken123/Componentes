unit LMDTaskDialogDsgn;
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

LMD-Tools Shared(X) LMDTaskDialog Designer (AH)
-----------------------------------------------

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ImgList, LMDTaskDlg, LMDTaskDialogButtonDsgn,
  ExtCtrls, LMDStrings, LMDTypes;

type
  TLMDTaskDialogDesigner = class(TForm)
    pgTaskDialogSetup: TPageControl;
    tabGeneral: TTabSheet;
    tabIcons: TTabSheet;
    btnShowDialog: TButton;
    tabExpanded: TTabSheet;
    tabButtons: TTabSheet;
    tabRadio: TTabSheet;
    GroupBox1: TGroupBox;
    chbOk: TCheckBox;
    chbCancel: TCheckBox;
    chbYes: TCheckBox;
    chbNo: TCheckBox;
    chbRetry: TCheckBox;
    chbClose: TCheckBox;
    GroupBox2: TGroupBox;
    chbUseCommandLinks: TCheckBox;
    chbUseCommandLinksNoIcon: TCheckBox;
    lstvButtons: TListView;
    btnAddButton: TButton;
    btnEditButton: TButton;
    btnDelButton: TButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    lstvMainIcon: TListView;
    lstvFooterIcon: TListView;
    btnMainIcon: TButton;
    btnFooterIcon: TButton;
    chbCustomFooterIcon: TCheckBox;
    chbCustomMainIcon: TCheckBox;
    dlgOpenIcon: TOpenDialog;
    imgMainIcons: TImageList;
    imgFooterIcons: TImageList;
    imgState: TImageList;
    btnEnableButton: TButton;
    btnDisableButton: TButton;
    grbDefault: TGroupBox;
    cmbDefaultButton: TComboBox;
    Label5: TLabel;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    edtExpandedInfo: TMemo;
    Label6: TLabel;
    edtCollapsedText: TEdit;
    edtExpandedText: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    chbExpandFooterArea: TCheckBox;
    chbExpandedByDefault: TCheckBox;
    tabProgressBar: TTabSheet;
    GroupBox7: TGroupBox;
    chbShowProgressbar: TCheckBox;
    chbMarqueBar: TCheckBox;
    Label9: TLabel;
    edtMarqueeSpeed: TEdit;
    Label10: TLabel;
    edtMin: TEdit;
    Label11: TLabel;
    edtMax: TEdit;
    Label12: TLabel;
    edtPosition: TEdit;
    cmbState: TComboBox;
    Label13: TLabel;
    udMin: TUpDown;
    udMax: TUpDown;
    udPosition: TUpDown;
    udMarqueSpeed: TUpDown;
    btnClear: TButton;
    GroupBox8: TGroupBox;
    Label14: TLabel;
    cmbDefaultRadioBtn: TComboBox;
    btnClearBtn: TButton;
    GroupBox9: TGroupBox;
    lstvRadionButton: TListView;
    btnAddRadioBtn: TButton;
    btnEditRadioBtn: TButton;
    btnDeleteBtn: TButton;
    btnEnableRadioBtn: TButton;
    btnDisableRadioBtn: TButton;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    imgFooterIconPreview: TImage;
    imgMainIconPreview: TImage;
    GroupBox12: TGroupBox;
    edtFooterText: TEdit;
    Label15: TLabel;
    edtVerification: TEdit;
    chbVerificationChecked: TCheckBox;
    Label4: TLabel;
    edtContent: TEdit;
    Label3: TLabel;
    edtMainInstruction: TEdit;
    Label2: TLabel;
    edtCaption: TEdit;
    Label1: TLabel;
    GroupBox13: TGroupBox;
    chbCanMinimized: TCheckBox;
    chbAllowCancel: TCheckBox;
    chbCallbackTimer: TCheckBox;
    chbRTLLayout: TCheckBox;
    chbEnableHyperLinks: TCheckBox;
    chbPositionRelative: TCheckBox;
    btnContentEdit: TButton;
    btnMainTextEdit: TButton;
    btnFooterEdit: TButton;
    procedure chbCustomFooterIconClick(Sender: TObject);
    procedure chbCustomMainIconClick(Sender: TObject);
    procedure btnEnableButtonClick(Sender: TObject);
    procedure btnDisableButtonClick(Sender: TObject);
    procedure btnShowDialogClick(Sender: TObject);
    procedure edtCaptionChange(Sender: TObject);
    procedure edtMainInstructionChange(Sender: TObject);
    procedure edtContentChange(Sender: TObject);
    procedure edtVerificationChange(Sender: TObject);
    procedure edtExpandedInfoChange(Sender: TObject);
    procedure edtCollapsedTextChange(Sender: TObject);
    procedure edtExpandedTextChange(Sender: TObject);
    procedure chbOkClick(Sender: TObject);
    procedure chbYesClick(Sender: TObject);
    procedure addCommonButtonToCheckbox(AButton: TLMDTaskDialogCommonButton);
    procedure removeCommonButtonToCheckbox(AButton: TLMDTaskDialogCommonButton);
    procedure chbNoClick(Sender: TObject);
    procedure chbCancelClick(Sender: TObject);
    procedure chbRetryClick(Sender: TObject);
    procedure chbCloseClick(Sender: TObject);
    procedure chbUseCommandLinksClick(Sender: TObject);
    procedure chbUseCommandLinksNoIconClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chbExpandFooterAreaClick(Sender: TObject);
    procedure chbExpandedByDefaultClick(Sender: TObject);
    procedure chbShowProgressbarClick(Sender: TObject);
    procedure chbMarqueBarClick(Sender: TObject);
    procedure cmbStateChange(Sender: TObject);
    procedure udMinChanging(Sender: TObject; var AllowChange: Boolean);
    procedure udMaxChanging(Sender: TObject; var AllowChange: Boolean);
    procedure udPositionChanging(Sender: TObject; var AllowChange: Boolean);
    procedure udMarqueSpeedChanging(Sender: TObject; var AllowChange: Boolean);
    procedure cmbDefaultButtonChange(Sender: TObject);
    procedure lstvMainIconSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lstvFooterIconSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnAddButtonClick(Sender: TObject);
    procedure lstvButtonsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnClearBtnClick(Sender: TObject);
    procedure btnEditButtonClick(Sender: TObject);
    procedure btnDelButtonClick(Sender: TObject);
    procedure edtFooterTextChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnAddRadioBtnClick(Sender: TObject);
    procedure btnEditRadioBtnClick(Sender: TObject);
    procedure btnDeleteBtnClick(Sender: TObject);
    procedure btnEnableRadioBtnClick(Sender: TObject);
    procedure btnDisableRadioBtnClick(Sender: TObject);
    procedure btnMainIconClick(Sender: TObject);
    procedure btnFooterIconClick(Sender: TObject);
    procedure chbVerificationCheckedClick(Sender: TObject);
    procedure chbAllowCancelClick(Sender: TObject);
    procedure chbCanMinimizedClick(Sender: TObject);
    procedure chbCallbackTimerClick(Sender: TObject);
    procedure chbRTLLayoutClick(Sender: TObject);
    procedure lstvRadionButtonSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure chbEnableHyperLinksClick(Sender: TObject);
    procedure chbPositionRelativeClick(Sender: TObject);
    procedure cmbDefaultRadioBtnChange(Sender: TObject);
    procedure lstvRadionButtonChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lstvButtonsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btnMainTextEditClick(Sender: TObject);
    procedure btnFooterEditClick(Sender: TObject);
    procedure btnContentEditClick(Sender: TObject);
  private
    FTaskDialog: TLMDTaskDialog;
    procedure SetTaskDialog(const Value: TLMDTaskDialog);
    procedure AddIconToMainIcons(ACaption: string; AIcon: PChar);
    procedure AddIconToFooterIcons(ACaption: string; AIcon: PChar);
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property TaskDialog: TLMDTaskDialog read FTaskDialog write SetTaskDialog;
  end;

var
  LMDTaskDialogDesigner: TLMDTaskDialogDesigner = nil;

implementation

uses
  TypInfo;

{$R *.dfm}

{$IFNDEF LMDCOMP14}
const
  {$EXTERNALSYM IDI_SHIELD}
  IDI_SHIELD  = MakeIntResource(32518);
{$ENDIF}
{------------------------------------------------------------------------------}
function LMDMemoInputBox(const ACaption: TLMDString; const AInitialValue: TLMDString; AOwner: TComponent): TLMDString;
var
  frmMemoEditor: TForm;
  edtText: TMemo;
  btnOk: TButton;
  btnCancel: TButton;
begin
  frmMemoEditor := TForm.Create(AOwner);
  try
    with frmMemoEditor do
    begin
      Left := 0;
      Top := 0;
      Caption := ACaption;
      ClientHeight := 240;
      ClientWidth := 391;
      Color := clBtnFace;
      Font.Charset := DEFAULT_CHARSET;
      Font.Color := clWindowText;
      Font.Height := -11;
      Font.Name := 'Tahoma';
      Font.Style := [];
      PixelsPerInch := 96;
      BorderStyle := bsDialog;
      Position := poOwnerFormCenter;
    end;
    edtText := TMemo.Create(frmMemoEditor);
    with edtText do
    begin
      Parent := frmMemoEditor;
      Left := 0;
      Top := 0;
      Width := 391;
      Height := 197;
      Align := alTop;
      Anchors := [akBottom];
      ScrollBars := ssVertical;
      Lines.Text := AInitialValue;
      TabOrder := 0;
    end;
    btnOk := TButton.Create(frmMemoEditor);
    with btnOk do
    begin
      Parent := frmMemoEditor;
      Left := 240;
      Top := 207;
      Width := 75;
      Height := 25;
      Caption := 'OK';
      Default := True;
      ModalResult := 1;
      TabOrder := 1;
    end;
    btnCancel := TButton.Create(frmMemoEditor);
    with btnCancel do
    begin
      Parent := frmMemoEditor;
      Left := 316;
      Top := 207;
      Width := 75;
      Height := 25;
      Caption := '&Cancel';
      ModalResult := 2;
      TabOrder := 2;
    end;
    if frmMemoEditor.ShowModal = mrOk then
      Result := edtText.Lines.Text
    else
      Result := AInitialValue;
  finally
    frmMemoEditor.Free;
  end;
end;

{ ************************ TLMDTaskDialogDesigner **************************** }
{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnAddButtonClick(Sender: TObject);
var
  LButtonEditor: TfrmButtonDesigner;
  LItem: TListItem;
begin
  Application.CreateForm(TfrmButtonDesigner, LButtonEditor);
  try
    if not (tdfUseCommandLinks in TaskDialog.Flags) then
      LButtonEditor.edtNote.Enabled := False;
    with (TaskDialog.Buttons.Add as TLMDTaskDlgButton) do
    begin
      LButtonEditor.edtButtonCaption.Text := Caption;
      LButtonEditor.updId.Position := ButtonId;
    end;
    if LButtonEditor.ShowModal = mrOk then
    begin
      with TaskDialog.Buttons.Buttons[TaskDialog.Buttons.Count - 1] do
      begin
        Caption := LButtonEditor.edtButtonCaption.Text;
        if LButtonEditor.edtNote.Enabled then
          Caption := Caption + #10 + LButtonEditor.edtNote.Text;
        ButtonId := LButtonEditor.updId.Position;
        LItem := lstvButtons.Items.Add;
        LItem.Caption := LMDReplaceStr(LMDReplaceStr(Caption, LMDCRLF, '#$D#$A'), LMDLF, '#$D');
        LItem.Checked := Enabled;
        LItem.Data := TaskDialog.Buttons.Buttons[TaskDialog.Buttons.Count - 1];
        LItem.SubItems.Add(Format('%d', [TaskDialog.Buttons.Buttons[TaskDialog.Buttons.Count - 1].ButtonId]));
        cmbDefaultButton.Items.AddObject(Caption, TaskDialog.Buttons.Buttons[TaskDialog.Buttons.Count - 1]);
      end;
    end
    else
      // Delete last Element
      TaskDialog.Buttons.Delete(TaskDialog.Buttons.Count - 1);
  finally
    LButtonEditor.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnAddRadioBtnClick(Sender: TObject);
var
  LButtonEditor: TfrmButtonDesigner;
  LItem: TListItem;
begin
  Application.CreateForm(TfrmButtonDesigner, LButtonEditor);
  try
    with (TaskDialog.RadioButtons.Add as TLMDTaskDlgRadioButton) do
    begin
      LButtonEditor.edtButtonCaption.Text := Caption;
      LButtonEditor.updId.Position := ButtonId;
    end;
    if LButtonEditor.ShowModal = mrOk then
    begin
      with TaskDialog.RadioButtons.Buttons[TaskDialog.RadioButtons.Count - 1] do
      begin
        Caption := LButtonEditor.edtButtonCaption.Text;
        ButtonId := LButtonEditor.updId.Position;
        LItem := lstvRadionButton.Items.Add;
        LItem.Caption := Caption;
        LItem.Checked := Enabled;
        LItem.Data := TaskDialog.RadioButtons.Buttons[TaskDialog.RadioButtons.Count - 1];
        LItem.SubItems.Add(Format('%d', [TaskDialog.RadioButtons.Buttons[TaskDialog.RadioButtons.Count - 1].ButtonId]));
        cmbDefaultRadioBtn.Items.AddObject(Caption, TaskDialog.RadioButtons.Buttons[TaskDialog.RadioButtons.Count - 1]);
      end;
    end
    else
      // Delete last Element
      TaskDialog.RadioButtons.Delete(TaskDialog.RadioButtons.Count - 1);
  finally
    LButtonEditor.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnClearBtnClick(Sender: TObject);
var
  LRadioButton: TLMDTaskDlgRadioButton;
begin
  if cmbDefaultRadioBtn.ItemIndex >= 0 then
  begin
    LRadioButton := TLMDTaskDlgRadioButton(cmbDefaultRadioBtn.Items.Objects[cmbDefaultRadioBtn.ItemIndex]);
    if Assigned(LRadioButton) then
      LRadioButton.IsDefault := False;
    cmbDefaultRadioBtn.ItemIndex := -1;
    TaskDialog.Flags := TaskDialog.Flags + [tdfNoDefaultRadioButton];
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnClearClick(Sender: TObject);
var
  LButton: TLMDTaskDlgButton;
begin
  if cmbDefaultButton.ItemIndex >= 0 then
  begin
    LButton := TLMDTaskDlgButton(cmbDefaultButton.Items.Objects[cmbDefaultButton.ItemIndex]);
    if Assigned(LButton) then
      LButton.IsDefault := False;
    cmbDefaultButton.ItemIndex := -1;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnContentEditClick(Sender: TObject);
begin
  edtContent.Text := LMDMemoInputBox('Content', edtContent.Text, Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnDelButtonClick(Sender: TObject);
var
  LButton: TLMDTaskDlgButton;
begin
  if Assigned(lstvButtons.Selected) then
  begin
    LButton := TLMDTaskDlgButton(lstvButtons.Selected.Data);
    cmbDefaultButton.Items.Delete(lstvButtons.Selected.Index);
    lstvButtons.Items.Delete(lstvButtons.Selected.Index);
    TaskDialog.Buttons.Delete(LButton.Index);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnDeleteBtnClick(Sender: TObject);
var
  LButton: TLMDTaskDlgRadioButton;
begin
  if Assigned(lstvRadionButton.Selected) then
  begin
    LButton := TLMDTaskDlgRadioButton(lstvRadionButton.Selected.Data);
    cmbDefaultRadioBtn.Items.Delete(lstvRadionButton.Selected.Index);
    lstvRadionButton.Items.Delete(lstvRadionButton.Selected.Index);
    TaskDialog.RadioButtons.Delete(LButton.Index);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnDisableButtonClick(Sender: TObject);
var
  LButton: TLMDTaskDlgButton;
begin
  if Assigned(lstvButtons.Selected) then
  begin
    lstvButtons.Selected.Checked := False;
    LButton := TLMDTaskDlgButton(lstvButtons.Selected.Data);
    LButton.Enabled := False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnDisableRadioBtnClick(Sender: TObject);
var
  LButton: TLMDTaskDlgRadioButton;
begin
  if Assigned(lstvRadionButton.Selected) then
  begin
    lstvRadionButton.Selected.Checked := False;
    LButton := TLMDTaskDlgRadioButton(lstvRadionButton.Selected.Data);
    LButton.Enabled := False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnEditButtonClick(Sender: TObject);
var
  LButtonEditor: TfrmButtonDesigner;
  LButton: TLMDTaskDlgButton;
begin
  if Assigned(lstvButtons.Selected) then
  begin
    LButton := TLMDTaskDlgButton(lstvButtons.Selected.Data);
    Application.CreateForm(TfrmButtonDesigner, LButtonEditor);
    try
      if not (tdfUseCommandLinks in TaskDialog.Flags) then
        LButtonEditor.edtNote.Enabled := False;

      LButtonEditor.edtButtonCaption.Text := Copy(LButton.Caption, 1, Pos(#10, LButton.Caption) - 1);
      LButtonEditor.edtNote.Text := Copy(LButton.Caption, Pos(#10, LButton.Caption) + 1,
                                         Length(LButton.Caption));
      LButtonEditor.updId.Position := LButton.ButtonId;
      if LButtonEditor.ShowModal = mrOk then
      begin
        LButton.Caption := LButtonEditor.edtButtonCaption.Text;
        if LButtonEditor.edtNote.Enabled then
          LButton.Caption := LButton.Caption + #10 + LButtonEditor.edtNote.Text;
        LButton.ButtonId := LButtonEditor.updId.Position;
        lstvButtons.Selected.Caption := LMDReplaceStr(LMDReplaceStr(LButton.Caption, LMDCRLF, '#$D#$A'), LMDLF, '#$D');;
        lstvButtons.Selected.SubItems.Text := IntToStr(LButton.ButtonId);
      end;
    finally
      LButtonEditor.Free;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnEditRadioBtnClick(Sender: TObject);
var
  LButtonEditor: TfrmButtonDesigner;
  LButton: TLMDTaskDlgRadioButton;
begin
  if Assigned(lstvRadionButton.Selected) then
  begin
    LButton := TLMDTaskDlgRadioButton(lstvRadionButton.Selected.Data);
    Application.CreateForm(TfrmButtonDesigner, LButtonEditor);
    try
      LButtonEditor.edtButtonCaption.Text := LButton.Caption;
      LButtonEditor.updId.Position := LButton.ButtonId;
      if LButtonEditor.ShowModal = mrOk then
      begin
        LButton.Caption := LButtonEditor.edtButtonCaption.Text;
        LButton.ButtonId := LButtonEditor.updId.Position;
        lstvRadionButton.Selected.Caption := LButton.Caption;
        lstvRadionButton.Selected.SubItems.Text := IntToStr(LButton.ButtonId);
      end;
    finally
      LButtonEditor.Free;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnEnableButtonClick(Sender: TObject);
var
  LButton: TLMDTaskDlgButton;
begin
  if Assigned(lstvButtons.Selected) then
  begin
    lstvButtons.Selected.Checked := True;
    LButton := TLMDTaskDlgButton(lstvButtons.Selected.Data);
    LButton.Enabled := True;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnEnableRadioBtnClick(Sender: TObject);
var
  LButton: TLMDTaskDlgRadioButton;
begin
  if Assigned(lstvRadionButton.Selected) then
  begin
    lstvRadionButton.Selected.Checked := True;
    LButton := TLMDTaskDlgRadioButton(lstvRadionButton.Selected.Data);
    LButton.Enabled := True;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnFooterEditClick(Sender: TObject);
begin
  edtFooterText.Text := LMDMemoInputBox('Footer text', edtFooterText.Text, Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnFooterIconClick(Sender: TObject);
var
  LIcon: TIcon;
begin
  if dlgOpenIcon.Execute then
  begin
    LIcon := TIcon.Create;
    try
      LIcon.LoadFromFile(dlgOpenIcon.FileName);
      TaskDialog.CustomFooterIcon := LIcon;
      imgFooterIconPreview.Picture.Icon.Assign(LIcon);
    finally
      LIcon.Free;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnMainIconClick(Sender: TObject);
var
  LIcon: TIcon;
begin
  if dlgOpenIcon.Execute then
  begin
    LIcon := TIcon.Create;
    try
      LIcon.LoadFromFile(dlgOpenIcon.FileName);
      TaskDialog.CustomMainIcon := LIcon;
      imgMainIconPreview.Picture.Icon.Assign(LIcon);
    finally
      LIcon.Free;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnMainTextEditClick(Sender: TObject);
begin
  edtMainInstruction.Text := LMDMemoInputBox('Main instruction', edtMainInstruction.Text, Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.btnShowDialogClick(Sender: TObject);
begin
  TaskDialog.Execute;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbAllowCancelClick(Sender: TObject);
begin
  if chbAllowCancel.Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfAllowDialogCancellation]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfAllowDialogCancellation];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbCallbackTimerClick(Sender: TObject);
begin
  if chbCallbackTimer.Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfCallbackTimer]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfCallbackTimer];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbCancelClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons + [tdcbCancel];
    addCommonButtonToCheckbox(tdcbCancel);
  end
  else
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons - [tdcbCancel];
    removeCommonButtonToCheckbox(tdcbCancel);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbCanMinimizedClick(Sender: TObject);
begin
  if chbCanMinimized.Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfCanBeMinimized]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfCanBeMinimized];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbCloseClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons + [tdcbClose];
    addCommonButtonToCheckbox(tdcbClose);
  end
  else
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons - [tdcbClose];
    removeCommonButtonToCheckbox(tdcbClose);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbCustomFooterIconClick(Sender: TObject);
begin
  btnFooterIcon.Enabled := chbCustomFooterIcon.Checked;
  lstvFooterIcon.Enabled := not chbCustomFooterIcon.Checked;
  if chbCustomFooterIcon.Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfUseHiconFooter]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfUseHiconFooter];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbCustomMainIconClick(Sender: TObject);
begin
  btnMainIcon.Enabled := chbCustomMainIcon.Checked;
  lstvMainIcon.Enabled := not chbCustomMainIcon.Checked;
  if chbCustomMainIcon.Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfUseHiconMain]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfUseHiconMain];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbEnableHyperLinksClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfEnableHyperlinks]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfEnableHyperlinks];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbExpandedByDefaultClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfExpandedByDefault]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfExpandedByDefault];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbExpandFooterAreaClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfExpandFooterArea]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfExpandFooterArea];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbMarqueBarClick(Sender: TObject);
var
  LChecked: Boolean;
begin
  LChecked := (Sender as TCheckBox).Checked;

  edtMarqueeSpeed.Enabled := LChecked;

  if LChecked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfShowProgressBar]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfShowProgressBar];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.addCommonButtonToCheckbox(AButton: TLMDTaskDialogCommonButton);
var
  LName: string;
begin
  LName := GetEnumName(TypeInfo(TLMDTaskDialogCommonButton), Ord(AButton));
  cmbDefaultButton.AddItem(Copy(LName, 5, Length(LName)), Pointer(LMDTaskDialogCommonButtonToID(AButton)));
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.removeCommonButtonToCheckbox(AButton: TLMDTaskDialogCommonButton);
var
  LIndex: Integer;
begin
  LIndex := cmbDefaultButton.Items.IndexOfObject(Pointer(LMDTaskDialogCommonButtonToID(AButton)));
  if LIndex >= 0 then
    cmbDefaultButton.Items.Delete(LIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbNoClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons + [tdcbNo];
    addCommonButtonToCheckbox(tdcbNo);
  end
  else
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons - [tdcbNo];
    removeCommonButtonToCheckbox(tdcbNo);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbOkClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons + [tdcbOk];
    addCommonButtonToCheckbox(tdcbOk);
  end
  else
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons - [tdcbOk];
    removeCommonButtonToCheckbox(tdcbOk);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbPositionRelativeClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfPositionRelativeToWindow]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfPositionRelativeToWindow];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbRetryClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons + [tdcbRetry];
    addCommonButtonToCheckbox(tdcbRetry);
  end
  else
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons - [tdcbRetry];
    removeCommonButtonToCheckbox(tdcbRetry);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbRTLLayoutClick(Sender: TObject);
begin
  if chbRTLLayout.Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfRtlLayout]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfRtlLayout];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbShowProgressbarClick(Sender: TObject);
var
  LChecked: Boolean;
begin
  LChecked := (Sender as TCheckBox).Checked;

  edtMin.Enabled := LChecked;
  edtMax.Enabled := LChecked;
  edtPosition.Enabled := LChecked;

  if LChecked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfShowProgressBar]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfShowProgressBar];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbUseCommandLinksClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfUseCommandLinks]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfUseCommandLinks];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbUseCommandLinksNoIconClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfUseCommandLinksNoIcon]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfUseCommandLinksNoIcon];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbVerificationCheckedClick(Sender: TObject);
begin
  if chbVerificationChecked.Checked then
    TaskDialog.Flags := TaskDialog.Flags + [tdfVerificationFlagChecked]
  else
    TaskDialog.Flags := TaskDialog.Flags - [tdfVerificationFlagChecked];
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.chbYesClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons + [tdcbYes];
    addCommonButtonToCheckbox(tdcbYes);
  end
  else
  begin
    TaskDialog.CommonButtons := TaskDialog.CommonButtons - [tdcbYes];
    removeCommonButtonToCheckbox(tdcbYes);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.cmbDefaultButtonChange(Sender: TObject);
begin
  if cmbDefaultButton.ItemIndex  >= 0 then
    TaskDialog.DefaultButton := TLMDPtrUInt(cmbDefaultButton.Items.Objects[cmbDefaultButton.ItemIndex]);
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.cmbDefaultRadioBtnChange(Sender: TObject);
begin
  if cmbDefaultRadioBtn.ItemIndex  >= 0 then
  begin
    TLMDTaskDlgRadioButton(cmbDefaultRadioBtn.Items.Objects[cmbDefaultRadioBtn.ItemIndex]).IsDefault := True;
    TaskDialog.Flags := TaskDialog.Flags - [tdfNoDefaultRadioButton];
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.cmbStateChange(Sender: TObject);
begin
  case cmbState.ItemIndex of
    0: TaskDialog.ProgressBar.State := tdpsNormal;
    1: TaskDialog.ProgressBar.State := tdpsError;
    2: TaskDialog.ProgressBar.State := tdsPaused;
  end;
end;

{------------------------------------------------------------------------------}
constructor TLMDTaskDialogDesigner.Create(AOwner: TComponent);
begin
  inherited;
  FTaskDialog := TLMDTaskDialog.Create(Self);
end;

{------------------------------------------------------------------------------}
destructor TLMDTaskDialogDesigner.Destroy;
begin
  FreeAndNil(FTaskDialog);
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDTaskDialogDesigner.AddIconToFooterIcons(ACaption: string; AIcon: PChar);

var
  LIcon: TIcon;
begin
  LIcon := TIcon.Create;
  try
    LIcon.Handle := LoadIcon(0, AIcon);
    with lstvFooterIcon.Items.Add do
    begin
      Caption := ACaption;
      ImageIndex := imgFooterIcons.AddIcon(LIcon);
    end;
  finally
    LIcon.Free;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDTaskDialogDesigner.AddIconToMainIcons(ACaption: string; AIcon: PChar);

var
  LIcon: TIcon;
begin
  LIcon := TIcon.Create;
  try
    LIcon.Handle := LoadIcon(0, AIcon);
    with lstvMainIcon.Items.Add do
    begin
      Caption := ACaption;
      ImageIndex := imgMainIcons.AddIcon(LIcon);
    end;
  finally
    LIcon.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.edtCaptionChange(Sender: TObject);
begin
  TaskDialog.Title := edtCaption.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.edtCollapsedTextChange(Sender: TObject);
begin
  TaskDialog.CollapsedControlText := edtCollapsedText.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.edtContentChange(Sender: TObject);
begin
  TaskDialog.Content := edtContent.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.edtExpandedInfoChange(Sender: TObject);
begin
  TaskDialog.ExpandedInformation := edtExpandedInfo.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.edtExpandedTextChange(Sender: TObject);
begin
  TaskDialog.ExpandedControlText := edtExpandedText.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.edtFooterTextChange(Sender: TObject);
begin
  TaskDialog.FooterText := edtFooterText.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.edtMainInstructionChange(Sender: TObject);
begin
  TaskDialog.MainInstruction := edtMainInstruction.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.edtVerificationChange(Sender: TObject);
begin
  TaskDialog.VerificationText := edtVerification.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.FormCreate(Sender: TObject);
begin
  pgTaskDialogSetup.ActivePageIndex := 0;

  AddIconToMainIcons('tdiBlank', nil);
  AddIconToMainIcons('tdiWarning', IDI_WARNING);
  AddIconToMainIcons('tdiQuestion', IDI_QUESTION);
  AddIconToMainIcons('tdiError', IDI_ERROR);
  AddIconToMainIcons('tdiInformation', IDI_INFORMATION);
  AddIconToMainIcons('tdiBlankAgain', nil);
  AddIconToMainIcons('tdiShield', IDI_SHIELD);  
  AddIconToFooterIcons('tdiBlank', nil);
  AddIconToFooterIcons('tdiWarning', IDI_WARNING);
  AddIconToFooterIcons('tdiQuestion', IDI_QUESTION);
  AddIconToFooterIcons('tdiError', IDI_ERROR);
  AddIconToFooterIcons('tdiInformation', IDI_INFORMATION);
  AddIconToFooterIcons('tdiBlankAgain', nil);
  AddIconToFooterIcons('tdiShield', IDI_SHIELD);
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.lstvButtonsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if (Change = ctState) and Assigned(Item.Data) then
    TLMDTaskDlgButton(Item.Data).Enabled := Item.Checked;
  if (Change = ctText) and Assigned(Item.Data) then
    TLMDTaskDlgButton(Item.Data).Caption := Item.Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.lstvButtonsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    btnEditButton.Enabled := True;
    btnDelButton.Enabled := True;
    btnEnableButton.Enabled := True;
    btnDisableButton.Enabled := True;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.lstvFooterIconSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  LBitmap: TBitmap;
begin
  if Selected then
  begin
    LBitmap := TBitmap.Create;
    try
      TaskDialog.FooterIcon := TLMDTaskDlgIcon(Item.Index);
      imgMainIcons.GetBitmap(Item.ImageIndex, LBitmap);
      imgFooterIconPreview.Picture.Bitmap.Assign(LBitmap);
    finally
      LBitmap.Free;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.lstvMainIconSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  LBitmap: TBitmap;
begin
  if Selected then
  begin
    LBitmap := TBitmap.Create;
    try
      TaskDialog.MainIcon := TLMDTaskDlgIcon(Item.Index);
      imgMainIcons.GetBitmap(Item.ImageIndex, LBitmap);
      imgMainIconPreview.Picture.Bitmap.Assign(LBitmap);
    finally
      LBitmap.Free;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.lstvRadionButtonChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if (Change = ctState) and Assigned(Item.Data) then
    TLMDTaskDlgButton(Item.Data).Enabled := Item.Checked;
  if (Change = ctText) and Assigned(Item.Data) then
    TLMDTaskDlgButton(Item.Data).Caption := Item.Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.lstvRadionButtonSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    btnEditRadioBtn.Enabled := True;
    btnDeleteBtn.Enabled := True;
    btnEnableRadioBtn.Enabled := True;
    btnDisableRadioBtn.Enabled := True;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.SetTaskDialog(const Value: TLMDTaskDialog);
var
  i: Integer;
  LDefault: Integer;
begin
  FTaskDialog.Assign(Value);

  edtCaption.Text := TaskDialog.Title;
  edtMainInstruction.Text := TaskDialog.MainInstruction;
  edtContent.Text := TaskDialog.Content;
  edtVerification.Text := TaskDialog.VerificationText;
  edtFooterText.Text := TaskDialog.FooterText;

  chbVerificationChecked.Checked := tdfVerificationFlagChecked in TaskDialog.Flags;
  chbAllowCancel.Checked := tdfAllowDialogCancellation in TaskDialog.Flags;
  chbCanMinimized.Checked := tdfCanBeMinimized in TaskDialog.Flags;
  chbCallbackTimer.Checked := tdfCallbackTimer in TaskDialog.Flags;
  chbRTLLayout.Checked := tdfRtlLayout in TaskDialog.Flags;
  chbEnableHyperLinks.Checked := tdfEnableHyperlinks in TaskDialog.Flags;
  chbPositionRelative.Checked := tdfPositionRelativeToWindow in TaskDialog.Flags;

  chbCustomMainIcon.Checked := tdfUseHiconMain in TaskDialog.Flags;
  chbCustomMainIconClick(chbCustomMainIcon);
  chbCustomFooterIcon.Checked := tdfUseHiconFooter in TaskDialog.Flags;
  chbCustomFooterIconClick(chbCustomFooterIcon);

  if tdfUseHiconMain in TaskDialog.Flags then
    imgMainIconPreview.Picture.Icon.Assign(TaskDialog.CustomMainIcon)
  else
    lstvMainIcon.ItemIndex := Integer(TaskDialog.MainIcon);

  if tdfUseHiconFooter in TaskDialog.Flags then
    imgFooterIconPreview.Picture.Icon.Assign(TaskDialog.CustomFooterIcon)
  else
    lstvFooterIcon.ItemIndex := Integer(TaskDialog.FooterIcon);

  edtExpandedInfo.Text := TaskDialog.ExpandedInformation;
  edtCollapsedText.Text := TaskDialog.CollapsedControlText;
  edtExpandedText.Text := TaskDialog.ExpandedControlText;

  chbOk.Checked := tdcbOk in TaskDialog.CommonButtons;
  chbYes.Checked := tdcbYes in TaskDialog.CommonButtons;
  chbNo.Checked := tdcbNo in TaskDialog.CommonButtons;
  chbCancel.Checked := tdcbCancel in TaskDialog.CommonButtons;
  chbRetry.Checked := tdcbRetry in TaskDialog.CommonButtons;
  chbClose.Checked := tdcbClose in TaskDialog.CommonButtons;

  chbUseCommandLinks.Checked := tdfUseCommandLinks in TaskDialog.Flags;
  chbUseCommandLinksNoIcon.Checked := tdfUseCommandLinksNoIcon in TaskDialog.Flags;

  chbExpandFooterArea.Checked := tdfExpandFooterArea in TaskDialog.Flags;
  chbExpandedByDefault.Checked := tdfExpandedByDefault in TaskDialog.Flags;

  LDefault := -1;
  for i := 0 to TaskDialog.Buttons.Count - 1 do
  begin
    with lstvButtons.Items.Add do
    begin
      Caption := TaskDialog.Buttons.Buttons[i].Caption;
      SubItems.Add(Format('%d', [TaskDialog.Buttons.Buttons[i].ButtonId]));
      Data := TaskDialog.Buttons.Buttons[i];
    end;
    cmbDefaultButton.Items.AddObject(TaskDialog.Buttons.Buttons[i].Caption, Pointer(TaskDialog.Buttons.Buttons[i].ButtonId));
    if TaskDialog.Buttons.Buttons[i].IsDefault then
      LDefault := i;
  end;
  cmbDefaultButton.ItemIndex := LDefault;

  LDefault := -1;
  for i := 0 to TaskDialog.RadioButtons.Count - 1 do
  begin
    with lstvRadionButton.Items.Add do
    begin
      Caption := TaskDialog.RadioButtons.Buttons[i].Caption;
      SubItems.Add(Format('%d', [TaskDialog.RadioButtons.Buttons[i].ButtonId]));
      Data := TaskDialog.RadioButtons.Buttons[i];
    end;
    cmbDefaultRadioBtn.Items.AddObject(TaskDialog.RadioButtons.Buttons[i].Caption,
                               TaskDialog.RadioButtons.Buttons[i]);
    if TaskDialog.RadioButtons.Buttons[i].IsDefault then
      LDefault := i;
  end;
  cmbDefaultRadioBtn.ItemIndex := LDefault;

  chbShowProgressbar.Checked := tdfShowProgressBar in TaskDialog.Flags;
  chbMarqueBar.Checked := tdfShowMarqueeProgressBar in TaskDialog.Flags;

  edtMin.Text := IntToStr(TaskDialog.ProgressBar.Min);
  edtMax.Text := IntToStr(TaskDialog.ProgressBar.Max);
  edtPosition.Text := IntToStr(TaskDialog.ProgressBar.Position);
  edtMarqueeSpeed.Text := IntToStr(TaskDialog.ProgressBar.MarqueSpeed);

  case TaskDialog.ProgressBar.State of
    tdpsNormal: cmbState.ItemIndex := 0;
    tdpsError: cmbState.ItemIndex := 1;
    tdsPaused: cmbState.ItemIndex := 2;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.udMarqueSpeedChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := True;
  TaskDialog.ProgressBar.MarqueSpeed := udMarqueSpeed.Position;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.udMaxChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := True;
  TaskDialog.ProgressBar.Max := udMax.Position;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.udMinChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := True;
  TaskDialog.ProgressBar.Min := udMin.Position;
end;

{------------------------------------------------------------------------------}
procedure TLMDTaskDialogDesigner.udPositionChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := True;
  TaskDialog.ProgressBar.Position := udPosition.Position;
end;

end.
