unit CustomiseDialog;

interface

{$I lmddlgcmps.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, JSDialog, ExtDlgs, Buttons, ActnList;

type
  TfrmCustomiseDialogClass = class of TfrmCustomiseDialog;

  TfrmCustomiseDialog = class(TForm)
    bOK: TButton;
    bPreview: TButton;
    bCancel: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    tsCustomBUttons: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    tsRadioBUttons: TTabSheet;
    TabSheet6: TTabSheet;
    Label1: TLabel;
    eInstruction: TEdit;
    Label2: TLabel;
    mContent: TMemo;
    gbOptions: TGroupBox;
    cbdoShowHelpLink: TCheckBox;
    cbdoRadioButtons: TCheckBox;
    cbdoCommandLinks: TCheckBox;
    cbdoCommandLinksNoIcon: TCheckBox;
    cbdoProgressBar: TCheckBox;
    cbdoProgressBarMarque: TCheckBox;
    cbdoTimer: TCheckBox;
    cbdoTopMost: TCheckBox;
    cbdoModal: TCheckBox;
    gbFonts: TGroupBox;
    Panel1: TPanel;
    lInstructionFont: TLabel;
    lContentFont: TLabel;
    lMoreContentFont: TLabel;
    FontDialog1: TFontDialog;
    cbShowVerification: TCheckBox;
    eVerification: TEdit;
    jsDialog1: TjsDialog;
    TabSheet7: TTabSheet;
    Label5: TLabel;
    eTitle: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    cbShowMoreShowing: TCheckBox;
    eShowText: TEdit;
    eHideText: TEdit;
    cbShowMoreShowInFooter: TCheckBox;
    rgShowMoreFormat: TRadioGroup;
    rgShowMoreSource: TRadioGroup;
    Label8: TLabel;
    eShowMoreFooterHeight: TEdit;
    cbShowHeader: TCheckBox;
    cbShowFooter: TCheckBox;
    rgFooterIcon: TRadioGroup;
    Label9: TLabel;
    mHeaderText: TMemo;
    Label10: TLabel;
    mFooterText: TMemo;
    lbCustomButtons: TListBox;
    lbRadioButtons: TListBox;
    pCustomButtonAddEdit: TPanel;
    bCustomButtonAdd: TButton;
    bCustomButtonDelete: TButton;
    bCustomButtonSave: TButton;
    Label11: TLabel;
    eCustomButtonCaption: TEdit;
    cbCustomButtonCancel: TCheckBox;
    cbCustomButtonDefault: TCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    eCustomButtonHint: TEdit;
    eCustomButtonImageIndex: TEdit;
    eCustomButtonPictureIndex: TEdit;
    iCustomButtonGlyph: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    jsdConfirmDelete: TjsDialog;
    Label16: TLabel;
    eDialogWidth: TEdit;
    pRadioButtonsAddEdit: TPanel;
    Label17: TLabel;
    Label20: TLabel;
    bRadioButtonsSave: TButton;
    eRadioButtonCaption: TEdit;
    cbRadioButtonEnabled: TCheckBox;
    cbRadioButtonChecked: TCheckBox;
    Edit5: TEdit;
    bRadioButtonsAdd: TButton;
    bRadioButtonsDelete: TButton;
    bCustomButtonEdit: TButton;
    bCustomButtonCancel: TButton;
    bRadioButtonsCancel: TButton;
    bRadioButtonsEdit: TButton;
    TabSheet8: TTabSheet;
    gbCommonButtons: TGroupBox;
    cbcbYes: TCheckBox;
    cbcbNo: TCheckBox;
    cbcbOK: TCheckBox;
    cbcbCancel: TCheckBox;
    cbcbAbort: TCheckBox;
    cbcbRetry: TCheckBox;
    cbcbIgnore: TCheckBox;
    cbcbAll: TCheckBox;
    cbcbNoToAll: TCheckBox;
    cbcbYesToAll: TCheckBox;
    cbcbHelp: TCheckBox;
    cbcbClose: TCheckBox;
    cboxButtonsDefault: TComboBox;
    cboxButtonsCancel: TComboBox;
    Label18: TLabel;
    Label19: TLabel;
    cbShowCommonButtons: TCheckBox;
    Label21: TLabel;
    eButtonBarColor: TEdit;
    ColorDialog1: TColorDialog;
    bbColorDialog: TBitBtn;
    TabSheet9: TTabSheet;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    eHelpLinkLabelText: TEdit;
    eHelpLinkContext: TEdit;
    cboxHelpLinkType: TComboBox;
    eHelpLinkKeyword: TEdit;
    Label26: TLabel;
    BitBtn1: TBitBtn;
    eHeaderColor: TEdit;
    GroupBox1: TGroupBox;
    lHeaderFont: TLabel;
    GroupBox2: TGroupBox;
    lFooterFont: TLabel;
    Label4: TLabel;
    eDialogColor: TEdit;
    bbDialogColor: TBitBtn;
    rgIconSize: TRadioGroup;
    gbMainIcon: TGroupBox;
    rgMainIcon: TRadioGroup;
    iMainIcon: TImage;
    cbUseDefaultFonts: TCheckBox;
    cboxBorderStyle: TComboBox;
    lBorderStyle: TLabel;
    GroupBox3: TGroupBox;
    cbSystemMenu: TCheckBox;
    cbMinimize: TCheckBox;
    rgPosition: TRadioGroup;
    GroupBox4: TGroupBox;
    iHeaderIcon: TImage;
    rgHeaderIcon: TRadioGroup;
    Label27: TLabel;
    eMainInstructionColor: TEdit;
    bbMainInstructionColor: TBitBtn;
    cbMultiline: TCheckBox;
    cbShowGlyph: TCheckBox;
    cbShowAtTop: TCheckBox;
    Label28: TLabel;
    cboxMainInstructionIcon: TComboBox;
    ActionList1: TActionList;
    aDeleteCustomButton: TAction;
    aDeleteRadioButton: TAction;
    Label29: TLabel;
    mCommandLinkHint: TMemo;
    Label30: TLabel;
    cbElevelationRequired: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    eCustomButtonModalResult: TComboBox;
    Label33: TLabel;
    eFooterBackgroundColor: TEdit;
    BitBtn2: TBitBtn;
    Label31: TLabel;
    Label32: TLabel;
    Label3: TLabel;
    cbShowMore: TCheckBox;
    mMoreContent: TMemo;
    lHelpLinkInfo: TLabel;
    lHelpLinkInfo1: TLabel;
    tsProgress: TTabSheet;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    eProgressInterval: TEdit;
    eProgressMin: TEdit;
    eProgressMax: TEdit;
    eProgressPosition: TEdit;
    eProgressStep: TEdit;
    cboxProgressState: TComboBox;
    gbBorder: TGroupBox;
    Label41: TLabel;
    lBorderWidth: TLabel;
    eBorderColor: TEdit;
    bbBorderColor: TBitBtn;
    cbBorderVisible: TCheckBox;
    eBorderWidth: TEdit;
    gbHeaderGradient: TGroupBox;
    cbHeaderGradientEnabled: TCheckBox;
    eHeaderGradientStartColor: TEdit;
    bbStartColor: TBitBtn;
    eHeaderGradientEndColor: TEdit;
    bbEndColor: TBitBtn;
    rgHeaderGradientDirection: TRadioGroup;
    Label40: TLabel;
    Label42: TLabel;
    pImageLists: TPanel;
    Label43: TLabel;
    Label44: TLabel;
    cboxCustomButtonImages: TComboBox;
    cboxCustomButtonPictureImages: TComboBox;
    Bevel3: TBevel;
    Label45: TLabel;
    cbCustomButtonEnabled: TCheckBox;
    cbCustomButtonVisible: TCheckBox;
    cbProgressUseNativeProgressBar: TCheckBox;
    procedure lInstructionFontClick(Sender: TObject);
    procedure bPreviewClick(Sender: TObject);
    procedure lbCustomButtonsClick(Sender: TObject);
    procedure iCustomButtonGlyphDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure bCustomButtonAddClick(Sender: TObject);
    procedure bCustomButtonSaveClick(Sender: TObject);
    procedure bRadioButtonsAddClick(Sender: TObject);
    procedure bRadioButtonsSaveClick(Sender: TObject);
    procedure lbRadioButtonsClick(Sender: TObject);
    procedure bCustomButtonEditClick(Sender: TObject);
    procedure bCustomButtonCancelClick(Sender: TObject);
    procedure bRadioButtonsCancelClick(Sender: TObject);
    procedure bRadioButtonsEditClick(Sender: TObject);
    procedure bbColorDialogClick(Sender: TObject);
    procedure eHelpLinkContextKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure lHeaderFontClick(Sender: TObject);
    procedure eButtonBarColorExit(Sender: TObject);
    procedure eHeaderColorExit(Sender: TObject);
    procedure bbDialogColorClick(Sender: TObject);
    procedure eDialogColorExit(Sender: TObject);
    procedure rgMainIconClick(Sender: TObject);
    procedure rgHeaderIconClick(Sender: TObject);
    procedure rgIconSizeClick(Sender: TObject);
    procedure bbMainInstructionColorClick(Sender: TObject);
    procedure aDeleteCustomButtonExecute(Sender: TObject);
    procedure aDeleteRadioButtonExecute(Sender: TObject);
    procedure aDeleteCustomButtonUpdate(Sender: TObject);
    procedure aDeleteRadioButtonUpdate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure eFooterBackgroundColorExit(Sender: TObject);
    procedure eProgressStepKeyPress(Sender: TObject; var Key: Char);
    procedure bbStartColorClick(Sender: TObject);
    procedure bbEndColorClick(Sender: TObject);
    procedure bbBorderColorContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
    FCustomButtonEdit: Boolean;
    FRadioButtonEdit: Boolean;
    FTempDialog: TJSDialog;
    procedure SetTempDialog(const Value: TJSDialog);
    function AddCustomButton: Integer;
    function AddRadioButton: Integer;
    procedure CancelCustomButtonEdit;
    procedure CancelRadioButtonEdit;
    procedure ClearCustomButtonValues;
    procedure ClearRadioButtonvalues;
    procedure LoadCustomButtons;
    procedure LoadRadioButtons;
    procedure PreviewHelpLinkClick(Sender: TObject; var Handled: Boolean);
    procedure SetControlState(AControl: TPanel; const AEnabled: Boolean; const ACustomButton: Boolean);
  protected
    FPreviewClass: TJSDialogClass;
    procedure CreateTempDialog; virtual;
    procedure DestroyTempDialog; virtual;
    function GetTempDialog: TJSDialog; virtual;
    procedure LoadDialogValues; virtual;
    procedure SaveDialogValues(ADialog: TJSDialog); virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateIconHints;
    class function Execute(ADialog: TJSDialog; APreviewClass: TJSDialogClass; ACustomiseClass: TfrmCustomiseDialogClass): Boolean; virtual;
    property TempDialog: TJSDialog read GetTempDialog write SetTempDialog;
  end;

var
  frmCustomiseDialog: TfrmCustomiseDialog;

implementation

{$R *.dfm}
{$R mbimg.res}
{$R vistaimg.res}

uses
    JSDialogs
  , TypInfo
  , JSGraphUtil
  {$IFDEF BDS}
  , GraphUtil
  {$ENDIF BDS}
  , JSProgressBar
  , ImgList
  ;

resourcestring
  StrHelpLinkInfo1 = 'Make sure you have doShowHelpLink in the DialogOpti' +
  'ons if you want your help link to display in the dialog.';

  StrHelpLinkInfo2 = 'If you want to write your own action for when the user clicks on the Help Lin' +
  'k, then handle the OnHelpLinkClick event. Make sure you set the Handled parameter to True so the default' +
  ' behaviour doesn''t get executed as well.';

function CreateHint(const AFont: TFont): string;
  function GetStyleStr: string;
  begin
    result := '';
    if fsBold in AFont.Style then
      result := 'Bold, ';
    if fsItalic in AFont.Style then
      result := result + 'Italic, ';
    if fsUnderline in AFont.Style then
      result := result + 'Underline, ';
    if fsStrikeOut in AFont.Style then
      result := result + 'StikeOut';
    if result = '' then
      result := 'none'
    else
    begin
      if result[Length(result)] = ' ' then
        result := Copy(result, 1, Length(result) - 2);
    end;
  end;
begin
  result := Format('Name: %s'#13#10'Size: %d'#13#10'Color: %s'#13#10'Style: %s', [AFont.Name, AFont.Size, ColorToString(AFont.Color), GetStyleStr]);
  result := result + #13#10#13#10 + 'Click to change font';
end;

function GetModalResultInt(const aStr: string): string;
begin
  if SameText(aStr, 'mrNone') then
    result := '0'
  else if SameText(aStr, 'mrOK') then
    result := IntToStr(idOK)
  else if SameText(aStr, 'mrCancel') then
    result := IntToStr(idCancel)
  else if SameText(aStr, 'mrAbort') then
    result := IntToStr(idAbort)
  else if SameText(aStr, 'mrRetry') then
    result := IntToStr(idRetry)
  else if SameText(aStr, 'mrIgnore') then
    result := IntToStr(idIgnore)
  else if SameText(aStr, 'mrYes') then
    result := IntToStr(idYes)
  else if SameText(aStr, 'mrNo') then
    result := IntToStr(idNo)
  else if SameText(aStr, 'mrAll') then
    result := IntToStr(mrNo + 1)
  else if SameText(aStr, 'mrNoToAll') then
    result := IntToStr(mrAll + 1)
  else if SameText(aStr, 'mrYesToAll') then
    result := IntToStr(mrNoToAll + 1)
end;

function GetModalResultStrFromInt(const aInt: Integer): string;
begin
  case aInt of
    0: result := 'mrNone';
    1: result := 'mrOK';
    2: result := 'mrCancel';
    3: result := 'mrAbort';
    4: result := 'mrRetry';
    5: result := 'mrIgnore';
    6: result := 'mrYes';
    7: result := 'mrNo';
    8: result := 'mrAll';
    mrAll + 1: result := 'mrNoToAll';
    mrNoToAll + 1: result := 'mrYesToAll';
  else
    result := IntToStr(aInt);
  end;
end;

{$IFDEF DELPHI5}
function TryStrToInt(const S: string; out Value: Integer): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;
{$ENDIF DELPHI5}

function TfrmCustomiseDialog.AddCustomButton: Integer;
var
  lBtn: TJSCustomButtonItem;
  lModRes: Integer;
begin
  if not FCustomButtonEdit then
    lBtn := TempDialog.CustomButtons.Add
  else
    lBtn := TempDialog.CustomButtons[lbCustomButtons.ItemIndex];
  lBtn.Caption := eCustomButtonCaption.Text;
  lBtn.Cancel := cbCustomButtonCancel.Checked;
  lBtn.Enabled := cbCustomButtonEnabled.Checked;
  lBtn.Visible := cbCustomButtonVisible.Checked;
  lBtn.Default := cbCustomButtonDefault.Checked;
  lBtn.Hint := eCustomButtonHint.Text;
  lBtn.ImageIndex := StrToIntDef(eCustomButtonImageIndex.Text, -1);
  lBtn.PictureIndex := StrToIntDef(eCustomButtonPictureIndex.Text, -1);
  if TryStrToInt(eCustomButtonModalResult.Text, lModRes) then
    lBtn.ModalResult := lModRes
  else
    lBtn.ModalResult := StrToIntDef(GetModalResultInt(eCustomButtonModalResult.Text), 0);
  // don't modify the value for an EDIT!
//  if not FCustomButtonEdit then
//    lBtn.Value := 100 + TempDialog.CustomButtons.Count;
  lBtn.ElevationRequired := cbElevelationRequired.Checked;
  lBtn.Info.Text := mCommandLinkHint.Text;
  lBtn.Glyph.Assign(iCustomButtonGlyph.Picture);
  result := lBtn.Index;
end;

function TfrmCustomiseDialog.AddRadioButton: Integer;
var
  lBtn: TJSRadioButtonItem;
begin
  if not FRadioButtonEdit then
    lBtn := TempDialog.RadioButtons.Add
  else
    lBtn := TempDialog.RadioButtons[lbRadioButtons.ItemIndex];
  lBtn.Caption := eRadioButtonCaption.Text;
  lBtn.Checked := cbRadioButtonChecked.Checked;
  lBtn.Enabled := cbRadioButtonEnabled.Checked;
//  if not FRadioButtonEdit then
//    lBtn.Value := 200 + TempDialog.RadioButtons.Count - 1;
  result := lBtn.Index;
end;

procedure TfrmCustomiseDialog.aDeleteCustomButtonExecute(Sender: TObject);
var
  lIdx: Integer;
begin
  if lbCustomButtons.ItemIndex = -1 then
    exit;
  if jsdConfirmDelete.Execute = mrYes then
  begin
    lIdx := lbCustomButtons.ItemIndex;
    TempDialog.CustomButtons.Delete(lIdx);
    lbCustomButtons.Items.Delete(lIdx);
    ClearCustomButtonValues;
    LoadCustomButtons;
  end;
end;

procedure TfrmCustomiseDialog.aDeleteCustomButtonUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (lbCustomButtons.ItemIndex > -1) and (bCustomButtonAdd.Enabled);
end;

procedure TfrmCustomiseDialog.aDeleteRadioButtonExecute(Sender: TObject);
var
  lIdx: Integer;
begin
  if lbRadioButtons.ItemIndex = -1 then
    exit;
  if jsdConfirmDelete.Execute = mrYes then
  begin
    lIdx := lbRadioButtons.ItemIndex;
    TempDialog.RadioButtons.Delete(lIdx);
    lbRadioButtons.Items.Delete(lIdx);
    LoadRadioButtons;
    ClearRadioButtonValues;
    SetControlState(pRadioButtonsAddEdit, False, False);
  end;
end;

procedure TfrmCustomiseDialog.aDeleteRadioButtonUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (lbRadioButtons.ItemIndex > -1) and (bRadioButtonsAdd.Enabled);
end;

procedure TfrmCustomiseDialog.bbBorderColorContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  ColorDialog1.Color := StringToColor(eBorderColor.Text);
  if ColorDialog1.Execute then
    eBorderColor.Text := ColorToString(ColorDialog1.Color);
end;

procedure TfrmCustomiseDialog.bbColorDialogClick(Sender: TObject);
begin
  ColorDialog1.Color := StringToColor(eButtonBarColor.Text);
  if ColorDialog1.Execute then
  begin
    eButtonBarColor.Text := ColorToString(ColorDialog1.Color);
    lFooterFont.Color := ColorDialog1.Color;
  end;
end;

procedure TfrmCustomiseDialog.bbDialogColorClick(Sender: TObject);
begin
  ColorDialog1.Color := StringToColor(eDialogColor.Text);
  if ColorDialog1.Execute then
  begin
    eDialogColor.Text := ColorToString(ColorDialog1.Color);
    lInstructionFont.Color := ColorDialog1.Color;
    lContentFont.Color := ColorDialog1.Color;
    lMoreContentFont.Color := ColorDialog1.Color;
  end;
end;

procedure TfrmCustomiseDialog.bbEndColorClick(Sender: TObject);
begin
  ColorDialog1.Color := StringToColor(eHeaderGradientEndColor.Text);
  if ColorDialog1.Execute then
    eHeaderGradientEndColor.Text := ColorToString(ColorDialog1.Color);
end;

procedure TfrmCustomiseDialog.SetControlState(AControl: TPanel; const AEnabled: Boolean; const ACustomButton: Boolean);
var
  i: Integer;
begin
  for i := 0 to AControl.ControlCount - 1 do
    AControl.Controls[i].Enabled := AEnabled;
  if ACustomButton then
  begin
    bCustomButtonAdd.Enabled := not AEnabled;
    bCustomButtonEdit.Enabled := not AEnabled;
    //bCustomButtonDelete.Enabled := not AEnabled;
  end
  else
  begin
    bRadioButtonsAdd.Enabled := not AEnabled;
    bRadioButtonsEdit.Enabled := not AEnabled;
    //bRadioButtonDelete.Enabled := not AEnabled;
  end;
end;

procedure TfrmCustomiseDialog.bCustomButtonAddClick(Sender: TObject);
begin
  SetControlState(pCustomButtonAddEdit, True, True);
  FCustomButtonEdit := False;
  bCustomButtonSave.Visible := True;
  bCustomButtonCancel.Visible := True;
  ClearCustomButtonValues;
  lbCustomButtons.ItemIndex := -1;
  ActiveControl := eCustomButtonCaption;
end;

procedure TfrmCustomiseDialog.bCustomButtonCancelClick(Sender: TObject);
begin
  CancelCustomButtonEdit;
  SetControlState(pCustomButtonAddEdit, False, True);
end;

procedure TfrmCustomiseDialog.bCustomButtonEditClick(Sender: TObject);
begin
  SetControlState(pCustomButtonAddEdit, True, True);
  FCustomButtonEdit := True;
  bCustomButtonSave.Visible := True;
  bCustomButtonCancel.Visible := True;
  ActiveControl := eCustomButtonCaption;
  eCustomButtonCaption.SelectAll;
end;

procedure TfrmCustomiseDialog.bCustomButtonSaveClick(Sender: TObject);
var
  lIdx: Integer;
begin
  lIdx := AddCustomButton;
  CancelCustomButtonEdit;
  LoadCustomButtons;
  lbCustomButtons.ItemIndex := lIdx;
  SetControlState(pCustomButtonAddEdit, False, True);
end;

procedure TfrmCustomiseDialog.BitBtn1Click(Sender: TObject);
begin
  ColorDialog1.Color := StringToColor(eHeaderColor.Text);
  if ColorDialog1.Execute then
  begin
    eHeaderColor.Text := ColorToString(ColorDialog1.Color);
    lHeaderFont.Color := StringToColor(eHeaderColor.Text);
  end;
end;

procedure TfrmCustomiseDialog.BitBtn2Click(Sender: TObject);
begin
  ColorDialog1.Color := StringToColor(eFooterBackgroundColor.Text);
  if ColorDialog1.Execute then
  begin
    eFooterBackgroundColor.Text := ColorToString(ColorDialog1.Color);
    lFooterFont.Color := StringToColor(eFooterBackgroundColor.Text);
  end;
end;

procedure TfrmCustomiseDialog.bbMainInstructionColorClick(Sender: TObject);
begin
  ColorDialog1.Color := StringToColor(eMainInstructionColor.Text);
  if ColorDialog1.Execute then
    eMainInstructionColor.Text := ColorToString(ColorDialog1.Color);
end;

procedure TfrmCustomiseDialog.bbStartColorClick(Sender: TObject);
begin
  ColorDialog1.Color := StringToColor(eHeaderGradientStartColor.Text);
  if ColorDialog1.Execute then
    eHeaderGradientStartColor.Text := ColorToString(ColorDialog1.Color);
end;

procedure TfrmCustomiseDialog.bOKClick(Sender: TObject);
begin
  SaveDialogValues(TempDialog);
end;

procedure TfrmCustomiseDialog.bRadioButtonsAddClick(Sender: TObject);
begin
  FRadioButtonEdit := False;
  SetControlState(pRadioButtonsAddEdit, True, False);
//  pRadioButtonsAddEdit.Enabled := True;
  bRadioButtonsSave.Visible := True;
  bRadioButtonsCancel.Visible := True;
  ClearRadioButtonValues;
  lbRadioButtons.ItemIndex := -1;
  ActiveControl := eRadioButtonCaption;
end;

procedure TfrmCustomiseDialog.bRadioButtonsCancelClick(Sender: TObject);
begin
  CancelRadioButtonEdit;
  FRadioButtonEdit := False;
  SetControlState(pRadioButtonsAddEdit, False, False);
//  pRadioButtonsAddEdit.Enabled := False;
end;

procedure TfrmCustomiseDialog.bRadioButtonsEditClick(Sender: TObject);
begin
  FRadioButtonEdit := True;
  SetControlState(pRadioButtonsAddEdit, True, False);
  //pRadioButtonsAddEdit.Enabled := True;
  bRadioButtonsSave.Visible := True;
  bRadioButtonsCancel.Visible := True;
  ActiveControl := eRadioButtonCaption;
  eRadioButtonCaption.SelectAll;
end;

procedure TfrmCustomiseDialog.bRadioButtonsSaveClick(Sender: TObject);
var
  lIdx: Integer;
begin
  lIdx := AddRadioButton;
  bRadioButtonsSave.Visible := False;
  bRadioButtonsCancel.Visible := False;
  LoadRadioButtons;
  lbRadioButtons.ItemIndex := lIdx;
  SetControlState(pRadioButtonsAddEdit, False, False);
//  pRadioButtonsAddEdit.Enabled := False;
end;

procedure TfrmCustomiseDialog.PreviewHelpLinkClick(Sender: TObject; var Handled: Boolean);
begin
  Handled := True;
end;

procedure TfrmCustomiseDialog.rgHeaderIconClick(Sender: TObject);
var
  lSize: Integer;
  lIconId: PChar;
  LIsCustomVistaShield: Boolean;
begin
  if (TTaskDialogIcon(rgHeaderIcon.ItemIndex) = tdiShield) and (Win32MajorVersion < 6) then
  begin
    if rgIconSize.ItemIndex = 0 then
      iHeaderIcon.Picture.Bitmap.LoadFromResourceName(hInstance, 'JSD_SHIELD_SML')
    else
      iHeaderIcon.Picture.Bitmap.LoadFromResourceName(hInstance, 'JSD_SHIELD');
    iHeaderIcon.Transparent := True;
  end
  else
  begin
    case rgIconSize.ItemIndex of
      0: lSize := 16;
      1: lSize := 24;
      2: lSize := 32;
    else
      lSize := 32;
    end;
    lIconId := GetIcon(TTaskDialogIcon(rgheaderIcon.ItemIndex), LIsCustomVistaShield);
    if IsVista then
    begin
      if lIconId <> nil then
        iHeaderIcon.Picture.Icon.Handle := LoadIcon(hInstance, lIconId);
    end
    else
      iHeaderIcon.Picture.Icon.Handle := LoadImage(0, lIconId, IMAGE_ICON, lSize, lSize, LR_DEFAULTCOLOR);
  end;
  UpdateIconHints;
end;

procedure TfrmCustomiseDialog.rgIconSizeClick(Sender: TObject);
var
  lIdx: Integer;
begin
  // roggle the indexes
  lIdx := rgHeaderIcon.ItemIndex;
  rgHeaderIcon.ItemIndex := -1;
  rgHeaderIcon.ItemIndex := lIdx;
end;

procedure TfrmCustomiseDialog.rgMainIconClick(Sender: TObject);
var
  lIconId: PChar;
  LIsCustomVistaShield: Boolean;
begin
  iMainIcon.Picture.Assign(nil);
  if (TTaskDialogIcon(rgMainIcon.ItemIndex) = tdiShield) and (Win32MajorVersion < 6) then
  begin
    iMainIcon.Picture.Bitmap.LoadFromResourceName(hInstance, 'JSD_SHIELD');
    iMainIcon.Transparent := True;
  end
  else
  begin
    lIconId := GetIcon(TTaskDialogIcon(rgMainIcon.ItemIndex), LIsCustomVistaShield);
    if IsVista then
    begin
      if lIconId <> nil then
        iMainIcon.Picture.Icon.Handle := LoadIcon(hInstance, lIconId);
    end
    else
      iMainIcon.Picture.Icon.Handle := LoadImage(0, lIconId, IMAGE_ICON, 32, 32, LR_DEFAULTCOLOR);
  end;
  UpdateIconHints;
end;

procedure TfrmCustomiseDialog.bPreviewClick(Sender: TObject);
var
  lDlg: TJSDialog;
begin
  lDlg := FPreviewClass.Create(nil);
  try
    SaveDialogValues(lDlg);
    lDlg.OnHelpLinkClick := PreviewHelpLinkClick;
    lDlg.AllowCancel := True;
    lDlg.ExecutePreview;
  finally
    lDlg.Free;
  end;
end;

procedure TfrmCustomiseDialog.CancelCustomButtonEdit;
begin
//  pCustomButtonAddEdit.Enabled := False;
  SetControlState(pCustomButtonAddEdit, False, True);
  FCustomButtonEdit := False;
  bCustomButtonSave.Visible := False;
  bCustomButtonCancel.Visible := False;
end;

procedure TfrmCustomiseDialog.CancelRadioButtonEdit;
begin
  bRadioButtonsSave.Visible := False;
  bRadioButtonsCancel.Visible := False;
  FRadioButtonEdit := False;
  SetControlState(pRadioButtonsAddEdit, False, False);
//  pRadioButtonsAddEdit.Enabled := False;
end;

constructor TfrmCustomiseDialog.Create(AOwner: TComponent);
begin
  inherited;
  CreateTempDialog;
end;

procedure TfrmCustomiseDialog.CreateTempDialog;
begin
  FTempDialog := TJSDialog.Create(nil);
end;

destructor TfrmCustomiseDialog.Destroy;
begin
  DestroyTempDialog;
  inherited;
end;

procedure TfrmCustomiseDialog.DestroyTempDialog;
begin
  FTempDialog.Free;
end;

procedure TfrmCustomiseDialog.eButtonBarColorExit(Sender: TObject);
begin
  lFooterFont.Color := StringToColor(TEdit(Sender).Text);
end;

procedure TfrmCustomiseDialog.eDialogColorExit(Sender: TObject);
begin
  lInstructionFont.Color := StringToColor(TEdit(Sender).Text);
  lContentFont.Color := StringToColor(TEdit(Sender).Text);
  lMoreContentFont.Color := StringToColor(TEdit(Sender).Text);
end;

procedure TfrmCustomiseDialog.eFooterBackgroundColorExit(Sender: TObject);
begin
  lHeaderFont.Color := StringToColor(TEdit(Sender).Text);
end;

procedure TfrmCustomiseDialog.eHeaderColorExit(Sender: TObject);
begin
  lHeaderFont.Color := StringToColor(TEdit(Sender).Text);
end;

procedure TfrmCustomiseDialog.eHelpLinkContextKeyPress(Sender: TObject; var Key: Char);
begin
  {$IFDEF DELPHI2009}
  if not CharInSet(Key, [#8, '0'..'9']) then
  {$ELSE}
  if not (Key in [#8, '0'..'9']) then
  {$ENDIF}
    Key := #0;
end;

procedure TfrmCustomiseDialog.eProgressStepKeyPress(Sender: TObject;
  var Key: Char);
begin
  {$IFDEF DELPHI2009}
  if not CharInSet(Key, [#8, '0'..'9']) then
  {$ELSE}
  if not (Key in ['0'..'9', #8]) then
  {$ENDIF}
    Key := #0;
end;

class function TfrmCustomiseDialog.Execute(ADialog: TJSDialog;
  APreviewClass: TJSDialogClass; ACustomiseClass: TfrmCustomiseDialogClass): Boolean;
var
  lDlg: TfrmCustomiseDialog;
begin
  lDlg := ACustomiseClass.Create(nil);
  try
    lDlg.TempDialog := ADialog;
    lDlg.FPreviewClass := APreviewClass;
    result := lDlg.ShowModal = mrOK;
    if result then
    begin
      ADialog.Assign(lDlg.TempDialog);
    end;
  finally
    lDlg.Free;
  end;
end;

procedure TfrmCustomiseDialog.LoadRadioButtons;
var
  i: Integer;
begin
  lbRadioButtons.Items.Clear;
  for i := 0 to TempDialog.RadioButtons.Count - 1 do
  begin
    lbRadioButtons.Items.Add(TempDialog.RadioButtons[i].DisplayName);
  end;
end;

procedure TfrmCustomiseDialog.LoadCustomButtons;
var
  i: Integer;
begin
  lbCustomButtons.Clear;
  for i := 0 to TempDialog.CustomButtons.Count - 1 do
  begin
    lbCustomButtons.Items.Add(TempDialog.CustomButtons[i].DisplayName);
  end;
  if TempDialog.CustomButtons.Images <> nil then
    cboxCustomButtonImages.ItemIndex := cboxCustomButtonImages.Items.IndexOf(TempDialog.CustomButtons.Images.Name);
  if TempDialog.CustomButtons.PictureImages <> nil then
    cboxCustomButtonPictureImages.ItemIndex := cboxCustomButtonPictureImages.Items.IndexOf(TempDialog.CustomButtons.PictureImages.Name);
end;

procedure TfrmCustomiseDialog.ClearCustomButtonValues;
begin
  eCustomButtonCaption.Text := '';
  cbCustomButtonCancel.Checked := False;
  cbCustomButtonDefault.Checked := False;
  cbCustomButtonEnabled.Checked := True;
  cbCustomButtonVisible.Checked := True;
  eCustomButtonHint.Text := '';
  eCustomButtonImageIndex.Text := '-1';
  eCustomButtonPictureIndex.Text := '-1';
  eCustomButtonModalResult.Text := '0';
  cbElevelationRequired.Checked := False;
  iCustomButtonGlyph.Picture.Assign(nil);
  mCommandLinkHint.Clear;
end;

procedure TfrmCustomiseDialog.ClearRadioButtonvalues;
begin
  eRadioButtonCaption.Text := '';
  cbRadioButtonEnabled.Checked := True;
  cbRadioButtonChecked.Checked := False;
end;

procedure TfrmCustomiseDialog.FormCreate(Sender: TObject);
var
  i: TFormBorderStyle;
  j: TTaskDialogIcon;
begin
  for i := low(TFormBorderStyle) to high(TFormBorderStyle)do
    cboxBorderStyle.Items.Add(GetEnumName(TypeInfo(TFormBorderStyle), ord(i)));
  for j := low(TTaskDialogIcon) to high(TTaskDialogIcon) do
    cboxMainInstructionIcon.Items.Add(GetEnumName(TypeInfo(TTaskDialogIcon), ord(j)));
  lHelpLinkInfo1.Caption := StrHelpLinkInfo1;
  lHelpLinkInfo.Caption := StrHelpLinkInfo2;
  PageControl1.ActivePageIndex := 0;
  SetControlState(pCustomButtonAddEdit, False, True);
  SetControlState(pRadioButtonsAddEdit, False, False);
end;

function TfrmCustomiseDialog.GetTempDialog: TJSDialog;
begin
  result := FTempDialog;
end;

procedure TfrmCustomiseDialog.iCustomButtonGlyphDblClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    iCustomButtonGlyph.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TfrmCustomiseDialog.lbCustomButtonsClick(Sender: TObject);
var
  lItem: TJSCustomButtonItem;
begin
  if FCustomButtonEdit then
    CancelCustomButtonEdit;
  if lbCustomButtons.ItemIndex > -1 then
  begin
    lItem := TempDialog.CustomButtons[lbCustomButtons.ItemIndex];
    eCustomButtonCaption.Text := lItem.Caption;
    cbCustomButtonCancel.Checked := lItem.Cancel;
    cbCustomButtonDefault.Checked := lItem.Default;
    cbCustomButtonEnabled.Checked := lItem.Enabled;
    cbCustomButtonVisible.Checked := lItem.Visible;
    eCustomButtonHint.Text := lItem.Hint;
    eCustomButtonImageIndex.Text := IntToStr(lItem.ImageIndex);
    eCustomButtonPictureIndex.Text := IntToStr(lItem.PictureIndex);
    eCustomButtonModalResult.Text := GetModalResultStrFromInt(ord(lItem.ModalResult));
    cbElevelationRequired.Checked := lItem.ElevationRequired;
    mCommandLinkHint.Text := lItem.Info.Text;
    iCustomButtonGlyph.Picture.Assign(lItem.Glyph.Graphic);
  end;
end;

procedure TfrmCustomiseDialog.lbRadioButtonsClick(Sender: TObject);
var
  lItem: TJSRadioButtonItem;
begin
  if lbRadioButtons.ItemIndex > -1 then
  begin
    lItem := TempDialog.RadioButtons[lbRadioButtons.ItemIndex];
    eRadioButtonCaption.Text := lItem.Caption;
    cbRadioButtonEnabled.Checked := lItem.Enabled;
    cbRadioButtonChecked.Checked := lItem.Checked;
  end;
end;

procedure TfrmCustomiseDialog.lHeaderFontClick(Sender: TObject);
begin
  FontDialog1.Font := TLabel(Sender).Font;
  if FontDialog1.Execute then
  begin
    TLabel(Sender).Font := FontDialog1.Font;
    TLabel(Sender).Hint := CreateHint(TLabel(Sender).Font);
    if Sender = lHeaderFont then
      lHeaderFont.Color := StringToColor(eHeaderColor.Text);
  end;
end;

procedure TfrmCustomiseDialog.lInstructionFontClick(Sender: TObject);
begin
  FontDialog1.Font := TLabel(Sender).Font;
  if FontDialog1.Execute then
  begin
    TLabel(Sender).Font := FontDialog1.Font;
    TLabel(Sender).Hint := CreateHint(TLabel(Sender).Font);
  end;
end;

procedure TfrmCustomiseDialog.LoadDialogValues;
var
  lCommonBtn: TCommonButton;
  i: Integer;
begin
  eInstruction.Text := TempDialog.Instruction.Text;
  rgMainIcon.ItemIndex := ord(TempDialog.MainIcon);
  if (TempDialog.MainIcon = tdiCustom) and (ValidPicture(TempDialog.Glyph)) then
    iMainIcon.Picture.Assign(TempDialog.Glyph);
  mContent.Lines.Assign(TempDialog.Content);
  mMoreContent.Lines.Assign(TempDialog.Expando.Lines);
  lInstructionFont.Font := TempDialog.Instruction.Font;
  lInstructionFont.Hint := CreateHint(lInstructionFont.Font);
  lContentFont.Font := TempDialog.Font;
  lContentFont.Hint := CreateHint(lContentFont.Font);
  lMoreContentFont.Font := TempDialog.Expando.Font;
  lMoreContentFont.Hint := CreateHint(lMoreContentFont.Font);
  cbdoShowHelpLink.Checked := doShowHelpLink in TempDialog.DialogOptions;
  cbdoRadioButtons.Checked := doRadioButtons in TempDialog.DialogOptions;
  cbdoCommandLinks.Checked := doCommandLinks in TempDialog.DialogOptions;
  cbdoCommandLinksNoIcon.Checked := doCommandLinksNoIcon in TempDialog.DialogOptions;
  cbdoProgressBar.Checked := doProgressBar in TempDialog.DialogOptions;
  cbdoProgressBarMarque.Checked := doProgressBarMarquee in TempDialog.DialogOptions;
  cbdoTimer.Checked := doTimer in TempDialog.DialogOptions;
  cbdoTopMost.Checked := doTopMost in TempDialog.DialogOptions;
  cbdoModal.Checked := doModal in TempDialog.DialogOptions;
  cbShowVerification.Checked := TempDialog.Verification.Visible;
  eVerification.Text := TempDialog.Verification.Text;
  cbShowMore.Checked := TempDialog.Expando.Visible;
  cbShowMoreShowing.Checked := TempDialog.Expando.Showing;
  cbShowMoreShowInFooter.Checked := TempDialog.Expando.ShowInFooter;
  eShowText.Text := TempDialog.Expando.ShowText;
  eHideText.Text := TempDialog.Expando.HideText;
  eTitle.Text := TempDialog.Title;
  rgShowMoreFormat.ItemIndex := ord(TempDialog.Expando.MoreFormat);
  rgShowMoreSource.ItemIndex := ord(TempDialog.Expando.MoreSource);
  eShowMoreFooterHeight.Text := IntToStr(TempDialog.Expando.MoreHeight);
  cbShowHeader.Checked := TempDialog.Header.Visible;
  mHeaderText.Lines.Text := TempDialog.Header.Text;
  rgHeaderIcon.ItemIndex := ord(TempDialog.Header.Icon);
  if (TempDialog.Header.Icon = tdiCustom) and (ValidPicture(TempDialog.Header.Glyph)) then
    iHeaderIcon.Picture.Assign(TempDialog.Header.Glyph);
  cbShowFooter.Checked := TempDialog.Footer.Visible;
  mFooterText.Lines.Text := TempDialog.Footer.Text;
  rgFooterIcon.ItemIndex := ord(TempDialog.Footer.Icon);
  LoadCustomButtons;
  LoadRadioButtons;
  eDialogWidth.Text := IntToStr(TempDialog.Width);
  cbShowCommonButtons.Checked := TempDialog.ButtonBar.Visible;
  eButtonBarColor.Text := ColorToString(TempDialog.ButtonBar.Color);
  for i := 0 to gbCommonButtons.ControlCount - 1 do
  begin
    lCommonBtn := TCommonButton(i);
    TCheckBox(gbCommonButtons.Controls[i]).Checked := lCommonBtn in TempDialog.ButtonBar.Buttons;
  end;
  cboxButtonsDefault.ItemIndex := ord(TempDialog.ButtonBar.Default);
  cboxButtonsCancel.ItemIndex := ord(TempDialog.ButtonBar.Cancel);
  eHelpLinkLabelText.Text := TempDialog.HelpLink.Text;
  eHelpLinkContext.Text := IntToStr(TempDialog.HelpLink.HelpContext);
  eHelpLinkKeyword.Text := TempDialog.HelpLink.HelpKeyword;
  cboxHelpLinkType.ItemIndex := ord(TempDialog.HelpLink.HelpType);
  eHeaderColor.Text := ColorToString(TempDialog.Header.Color);
  lHeaderFont.Color := TempDialog.Header.Color;
  lHeaderFont.Font := TempDialog.Header.Font;
  lHeaderFont.Hint := CreateHint(lHeaderFont.Font);
  lFooterFont.Font := TempDialog.Footer.Font;
  lFooterFont.Hint := CreateHint(lFooterFont.Font);
  eFooterBackgroundColor.Text := ColorToString(TempDialog.Footer.Color);
  lFooterFont.Color := TempDialog.Footer.Color;
  eDialogColor.Text := ColorToString(TempDialog.Color);
  lInstructionFont.Color := StringToColor(eDialogColor.Text);
  lContentFont.Color := StringToColor(eDialogColor.Text);
  lMoreContentFont.Color := StringToColor(eDialogColor.Text);
  rgIconSize.ItemIndex := ord(TempDialog.Header.IconSize);
  cbUseDefaultFonts.Checked := TempDialog.UseDefaultFonts;
  cboxBorderStyle.ItemIndex := ord(TempDialog.BorderStyle);
  cbSystemMenu.Checked := TempDialog.AllowCancel;
  cbMinimize.Checked := TempDialog.AllowMinimize;
  rgPosition.ItemIndex := ord(TempDialog.Position);
  cbShowAtTop.Checked := TempDialog.Instruction.ShowAtTop;
  cbShowGlyph.Checked := TempDialog.Instruction.ShowGlyph;
//  cbMultiline.Checked := TempDialog.Instruction.MultiLine;
  cboxMainInstructionIcon.ItemIndex := ord(TempDialog.Instruction.Icon);
  eMainInstructionColor.Text := ColorToString(TempDialog.Instruction.Color);
  // progress bar values
  eProgressInterval.Text := IntToStr(TempDialog.Progress.Interval);
  eProgressMin.Text := IntToStr(TempDialog.Progress.Min);
  eProgressMax.Text := IntToStr(TempDialog.Progress.Max);
  eProgressPosition.Text := IntToStr(TempDialog.Progress.Position);
  eProgressStep.Text := IntToStr(TempDialog.Progress.Step);
  cboxProgressState.ItemIndex := ord(TempDialog.Progress.State);
  cbProgressUseNativeProgressBar.Checked := TempDialog.Progress.UseNativeProgressBar;
  // border values
  cbBorderVisible.Checked := TempDialog.Border.Visible;
  eBorderWidth.Text := IntToStr(TempDialog.Border.Width);
  eBorderColor.Text := ColorToString(TempDialog.Border.Color);
  // header gradient
  cbHeaderGradientEnabled.Checked := TempDialog.Header.Gradient.Enabled;
  eHeaderGradientStartColor.Text := ColorToString(TempDialog.Header.Gradient.StartColor);
  eHeaderGradientEndColor.Text := ColorToString(TempDialog.Header.Gradient.EndColor);
  rgHeaderGradientDirection.ItemIndex := ord(TempDialog.Header.Gradient.Direction);
  // update hints
  UpdateIconHints;
end;

procedure TfrmCustomiseDialog.SaveDialogValues(ADialog: TJSDialog);
var
  lButtons: TCommonButtons;
begin
  aDialog.Instruction.Text := eInstruction.Text;
  aDialog.Instruction.ShowAtTop := cbShowAtTop.Checked;
  aDialog.Instruction.ShowGlyph := cbShowGlyph.Checked;
//  aDialog.Instruction.MultiLine := cbMultiline.Checked;
  aDialog.Instruction.Color := StringToColor(eMainInstructionColor.Text);
  aDialog.MainIcon := TTaskDialogIcon(rgMainIcon.ItemIndex);
  if (aDialog.MainIcon = tdiCustom) then
  begin
    if ValidPicture(iMainIcon.Picture) then
      aDialog.Glyph.Assign(iMainIcon.Picture);
  end;
  aDialog.Content.Assign(mContent.Lines);
  aDialog.Expando.Lines.Assign(mMoreContent.Lines);
  aDialog.Instruction.Font := lInstructionFont.Font;
  aDialog.Font := lContentFont.Font;
  aDialog.Expando.Font := lMoreContentFont.Font;
  aDialog.DialogOptions := [];
  if cbdoShowHelpLink.Checked then
    aDialog.DialogOptions := aDialog.DialogOptions + [doShowHelpLink];
  if cbdoRadioButtons.Checked then
    aDialog.DialogOptions := aDialog.DialogOptions + [doRadioButtons];
  if cbdoCommandLinks.Checked then
    aDialog.DialogOptions := aDialog.DialogOptions + [doCommandLinks];
  if cbdoCommandLinksNoIcon.Checked then
    aDialog.DialogOptions := aDialog.DialogOptions + [doCommandLinksNoIcon];
  if cbdoProgressBar.Checked then
    aDialog.DialogOptions := aDialog.DialogOptions + [doProgressBar];
  if cbdoProgressBarMarque.Checked then
    aDialog.DialogOptions := aDialog.DialogOptions + [doProgressBarMarquee];
  if cbdoTimer.Checked then
    aDialog.DialogOptions := aDialog.DialogOptions + [doTimer];
  if cbdoTopMost.Checked then
    aDialog.DialogOptions := aDialog.DialogOptions + [doTopMost];
  if cbdoModal.Checked then
    aDialog.DialogOptions := aDialog.DialogOptions + [doModal];
  aDialog.Verification.Visible := cbShowVerification.Checked;
  aDialog.Verification.Text := eVerification.Text;
  aDialog.Expando.Visible := cbShowMore.Checked;
  aDialog.Expando.Showing := cbShowMoreShowing.Checked;
  aDialog.Expando.ShowInFooter := cbShowMoreShowInFooter.Checked;
  aDialog.Expando.ShowText := eShowText.Text;
  aDialog.Expando.HideText := eHideText.Text;
  aDialog.Title := eTitle.Text;
  aDialog.Expando.MoreFormat := TMoreFormat(rgShowMoreFormat.ItemIndex);
  aDialog.Expando.MoreSource := TMoreSource(rgShowMoreSource.ItemIndex);
  aDialog.Expando.MoreHeight := StrToIntDef(eShowMoreFooterHeight.Text, 0);
  aDialog.Header.Visible := cbShowHeader.Checked;
  aDialog.Header.Text := mHeaderText.Lines.Text;
  aDialog.Header.Icon := TTaskDialogIcon(rgHeaderIcon.ItemIndex);
  aDialog.Footer.Visible := cbShowFooter.Checked;
  aDialog.Footer.Text := mFooterText.Lines.Text;
  aDialog.Footer.Icon := TTaskDialogIcon(rgFooterIcon.ItemIndex);
  if aDialog <> TempDialog then
    aDialog.CustomButtons.Assign(TempDialog.CustomButtons);
  if aDialog <> TempDialog then
    aDialog.RadioButtons.Assign(TempDialog.RadioButtons);
  aDialog.Width := StrToIntDef(eDialogWidth.Text, 0);
  aDialog.ButtonBar.Visible := cbShowCommonButtons.Checked;
  aDialog.ButtonBar.Color := StringToColor(eButtonBarColor.Text);
  lButtons := [];
  if cbcbYes.Checked then
    include(lButtons, cbYes);
  if cbcbNo.Checked then
    include(lButtons, cbNo);
  if cbcbOK.Checked then
    include(lButtons, cbOK);
  if cbcbCancel.Checked then
    include(lButtons, cbCancel);
  if cbcbAbort.Checked then
    include(lButtons, cbAbort);
  if cbcbRetry.Checked then
    include(lButtons, cbRetry);
  if cbcbIgnore.Checked then
    include(lButtons, cbIgnore);
  if cbcbAll.Checked then
    include(lButtons, cbAll);
  if cbcbNoToAll.Checked then
    include(lButtons, cbNoToAll);
  if cbcbYesToAll.Checked then
    include(lButtons, cbYesToAll);
  if cbcbHelp.Checked then
    include(lButtons, cbHelp);
  if cbcbClose.Checked then
    include(lButtons, cbClose);
  aDialog.Buttonbar.Buttons := lButtons;
  if cboxButtonsDefault.ItemIndex > -1 then
    aDialog.ButtonBar.Default := TCommonButton(cboxButtonsDefault.ItemIndex);
  if cboxButtonsCancel.ItemIndex > -1 then
    aDialog.ButtonBar.Cancel := TCommonButton(cboxButtonsCancel.ItemIndex);
  aDialog.HelpLink.Text := eHelpLinkLabelText.Text;
  aDialog.HelpLink.HelpContext := StrToIntDef(eHelpLinkContext.Text, 0);
  aDialog.HelpLink.HelpKeyword := eHelpLinkKeyword.Text;
  aDialog.HelpLink.HelpType := THelpType(cboxHelpLinkType.ItemIndex);
  aDialog.Header.Color := StringToColor(eHeaderColor.Text);
  aDialog.Header.Font := lHeaderFont.Font;
  aDialog.Footer.Font := lFooterFont.Font;
  aDialog.Footer.Color := StringToColor(eFooterBackgroundColor.Text);
  aDialog.Color := StringToColor(eDialogColor.Text);
  aDialog.Header.IconSize := TJSIconSize(rgIconSize.ItemIndex);
  aDialog.UseDefaultFonts := cbUseDefaultFonts.Checked;
  aDialog.BorderStyle := TFormBorderStyle(cboxBorderStyle.ItemIndex);
  aDialog.AllowCancel := cbSystemMenu.Checked;
  aDialog.AllowMinimize := cbMinimize.Checked;
  aDialog.Position := TDialogPosition(rgPosition.ItemIndex);
  aDialog.Instruction.Icon := TTaskDialogIcon(cboxMainInstructionIcon.ItemIndex);
  // progress bar values
  aDialog.Progress.Interval := StrToIntDef(eProgressInterval.Text, 100);
  aDialog.Progress.Min := StrToIntDef(eProgressMin.Text, 0);
  aDialog.Progress.Max := StrToIntDef(eProgressMax.Text, 100);
  aDialog.Progress.Position := StrToIntDef(eProgressPosition.Text, 0);
  aDialog.Progress.Step := StrToIntDef(eProgressStep.Text, 1);
  aDialog.Progress.State := TProgressBarState(cboxProgressState.ItemIndex);
  aDialog.Progress.UseNativeProgressBar := cbProgressUseNativeProgressBar.Checked;
  // border values
  aDialog.Border.Visible := cbBorderVisible.Checked;
  aDialog.Border.Width := StrToIntDef(eBorderWidth.Text, 1);
  aDialog.Border.Color := StringToColor(eBorderColor.Text);
  // header gradient
  aDialog.Header.Gradient.Enabled := cbHeaderGradientEnabled.Checked;
  aDialog.Header.Gradient.StartColor := StringToColor(eHeaderGradientStartColor.Text);
  aDialog.Header.Gradient.EndColor := StringToColor(eHeaderGradientEndColor.Text);
  aDialog.Header.Gradient.Direction := TGradientDirection(rgHeaderGradientDirection.ItemIndex);
  aDialog.RadioButton := TempDialog.RadioButton;
end;

procedure TfrmCustomiseDialog.SetTempDialog(const Value: TJSDialog);
var
  lOwnerForm: TCustomForm;
  i: Integer;
begin
  TempDialog.Assign(Value);
  if Value <> nil then
  begin
    Caption := Format('Customise %s', [Value.Name]);
    if Value.Owner is TCustomForm then
    begin
      lOwnerForm := Value.Owner as TCustomForm;
      for i := 0 to lOwnerForm.ComponentCount - 1 do
      begin
        if lOwnerForm.Components[i].InheritsFrom(TCustomImageList) then
          cboxCustomButtonImages.Items.Add(lOwnerForm.Components[i].Name);
      end;
      cboxCustomButtonPictureImages.Items.Assign(cboxCustomButtonImages.Items);
    end;
  end;
  LoadDialogValues;
end;

procedure TfrmCustomiseDialog.UpdateIconHints;
begin
  if ValidPicture(iMainIcon.Picture) then
    iMainIcon.Hint := Format('Image Dimensions'#13#10'%d x %d', [iMainIcon.Picture.Graphic.Width, iMainIcon.Picture.Graphic.Height])
  else
    iMainIcon.Hint := '';
  if ValidPicture(iHeaderIcon.Picture) then
    iHeaderIcon.Hint := Format('Image Dimensions'#13#10'%d x %d', [iHeaderIcon.Picture.Graphic.Width, iHeaderIcon.Picture.Graphic.Height])
  else
    iHeaderIcon.Hint := '';
end;

end.
