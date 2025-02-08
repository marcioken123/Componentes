unit pLMDGraphicLabelEditorDlg;
{$I lmdcmps.Inc}
interface

uses
  ComCtrls, Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, TabNotBk, StdCtrls, LMDClass, LMDGraph, pLMDCPGetMain,
  LMDCustomColorComboBox, LMDBaseLabel, LMDCustomSimpleLabel, LMDCustomPanel,
  LMDBaseGraphicControl, LMDGraphicControl, LMDCustomGraphicLabel, LMDCustomBevelPanel,
  LMDSimplePanel, LMDGraphicLabel, LMDSimpleLabel, LMDFontComboBox, LMDFontSizeComboBox,
  LMDColorComboBox, LMDCustomComponent, LMDCustomComboBox, LMDCustomControl,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, LMDCustomButton,
  LMDButton, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
  LMDCustomExtSpinEdit, LMDSpinEdit, LMDControl, LMDBaseControl, LMDThemes,
  LMDThemedComboBox;

type
  TLMDFormGraphicLabelEditor = class(TForm)
    FontDialog: TFontDialog;
    LMDSPCarryAll: TLMDSimplePanel;
    TabbedNotebookProperties: TPageControl;
    LMDSimpleLabel7: TLMDSimpleLabel;
    LMDSimpleLabel8: TLMDSimpleLabel;
    LMDSimpleLabel9: TLMDSimpleLabel;
    LMDSimpleLabel10: TLMDSimpleLabel;
    LMDSimpleLabel11: TLMDSimpleLabel;
    LMDSpinEditAngle: TLMDSpinEdit;
    LMDSpinEditLightDepth: TLMDSpinEdit;
    LMDSpinEditShadowDepth: TLMDSpinEdit;
    LMDSpinEditTracing: TLMDSpinEdit;
    ComboBoxStyle: TComboBox;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDSimpleLabel6: TLMDSimpleLabel;
    LMDFontComboBox: TLMDFontComboBox;
    LMDColorComboBox: TLMDColorComboBox;
    LMDFontSizeComboBox: TLMDFontSizeComboBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    LMDSpinEditToggle: TLMDSpinEdit;
    LMDSpinEditPerspectiveDepth: TLMDSpinEdit;
    ComboBoxPerspective: TComboBox;
    LMDSPCarryControls: TLMDSimplePanel;
    ComboBoxTransform: TComboBox;
    Label1: TLabel;
    LMDSimpleLabel12: TLMDSimpleLabel;
    LMDSpinEditFactor: TLMDSpinEdit;
    LMDSimpleLabel13: TLMDSimpleLabel;
    LMDLightColorComboBox: TLMDColorComboBox;
    LMDShadowColorComboBox: TLMDColorComboBox;
    LMDSimpleLabel14: TLMDSimpleLabel;
    LMDSimpleLabel15: TLMDSimpleLabel;
    LMDGraphicLabel: TLMDGraphicLabel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    LMDButton1: TLMDButton;
    LMDButton2: TLMDButton;
    ButtonFillObjectDialog: TLMDButton;
    ButtonFontDialog: TLMDButton;
    CheckBoxEqualLetters: TLMDCheckBox;
    CheckBoxAutoToggle: TLMDCheckBox;
    CheckBoxToggled: TLMDCheckBox;
    procedure ButtonFontDialogClick(Sender: TObject);
    procedure LMDFontComboBoxChange(Sender: TObject);
    procedure LMDColorComboBoxChange(Sender: TObject);
    procedure LMDFontSizeComboBoxChange(Sender: TObject);
    procedure CheckBoxAutoToggleClick(Sender: TObject);
    procedure CheckBoxToggledClick(Sender: TObject);
    procedure CheckBoxEqualLettersClick(Sender: TObject);
    procedure ComboBoxPerspectiveChange(Sender: TObject);
    procedure LMDSpinEditPerspectiveDepthChange(Sender: TObject);
    procedure LMDSpinEditToggleChange(Sender: TObject);
    procedure LMDSpinEditLightDepthChange(Sender: TObject);
    procedure LMDSpinEditShadowDepthChange(Sender: TObject);
    procedure LMDSpinEditAngleChange(Sender: TObject);
    procedure LMDSpinEditTracingChange(Sender: TObject);
    procedure ComboBoxStyleChange(Sender: TObject);
    procedure LMDSpinEditFactorChange(Sender: TObject);
    procedure ComboBoxTransformChange(Sender: TObject);
    procedure SetValue (Value : TLMDGraphicLabel);
    procedure LMDLightColorComboBoxChange(Sender: TObject);
    procedure LMDShadowColorComboBoxChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  LMDGrlf, pLMDCPGetCore;

{$R *.DFM}

procedure TLMDFormGraphicLabelEditor.SetValue (Value : TLMDGraphicLabel);
begin
  LMDGraphicLabel.Assign (Value);
  LMDFontComboBox.SelectedFont := Value.Font.Name;
  LMDColorComboBox.SelectedColor := Value.Font.Color;
  LMDFontSizeComboBox.FontSize := Value.Font.Size;
  If taAutoToggled In LMDGraphicLabel.Attributes Then
    CheckBoxAutoToggle.Checked := True
  Else
    CheckBoxAutoToggle.Checked := False;
  If taToggled In LMDGraphicLabel.Attributes Then
    CheckBoxToggled.Checked := True
  Else
    CheckBoxToggled.Checked := False;
  If NOT (taPerspective In LMDGraphicLabel.Attributes) Then
    ComboBoxPerspective.ItemIndex := 0
  else
    begin
      If LMDGraphicLabel.Perspective = tpBird Then
        ComboBoxPerspective.ItemIndex := 1
      else
        ComboBoxPerspective.ItemIndex := 2;
    end;
  If taEqualLetters In LMDGraphicLabel.Attributes Then
    CheckBoxEqualLetters.Checked := True
  Else
    CheckBoxEqualLetters.Checked := False;
  LMDSpinEditPerspectiveDepth.Value := LMDGraphicLabel.PerspectiveDepth;
  LMDSpinEditToggle.Value := LMDGraphicLabel.Toggle;
  LMDSpinEditLightDepth.Value := LMDGraphicLabel.FontFX.LightDepth;
  LMDSpinEditShadowDepth.Value := LMDGraphicLabel.FontFX.ShadowDepth;
  LMDSpinEditAngle.Value := LMDGraphicLabel.FontFX.Angle;
  LMDSpinEditTracing.Value := LMDGraphicLabel.FontFX.Tracing;
  LMDSpinEditFactor.Value := LMDGraphicLabel.Factor;

  ComboBoxTransform.ItemIndex := Ord(LMDGraphicLabel.Transform);

  ComboBoxStyle.ItemIndex := Ord(LMDGraphicLabel.FontFX.Style);

  LMDLightColorComboBox.SelectedColor := LMDGraphicLabel.FontFX.LightColor;
  LMDShadowColorComboBox.SelectedColor := LMDGraphicLabel.FontFX.ShadowColor;
end;

procedure TLMDFormGraphicLabelEditor.ButtonFontDialogClick(Sender: TObject);
begin
  FontDialog.Font.Assign (LMDGraphicLabel.Font);
  If FontDialog.Execute Then
    LMDGraphicLabel.Font.Assign (FontDialog.Font);
end;

procedure TLMDFormGraphicLabelEditor.LMDFontComboBoxChange(Sender: TObject);
begin
  LMDGraphicLabel.Font.Name := LMDFontComboBox.SelectedFont;
end;

procedure TLMDFormGraphicLabelEditor.LMDColorComboBoxChange(Sender: TObject);
begin
  LMDGraphicLabel.Font.Color := LMDColorComboBox.SelectedColor;
end;

procedure TLMDFormGraphicLabelEditor.LMDFontSizeComboBoxChange(
  Sender: TObject);
begin
  LMDGraphicLabel.Font.Size := LMDFontSizeComboBox.FontSize;
end;

procedure TLMDFormGraphicLabelEditor.CheckBoxAutoToggleClick(Sender: TObject);
begin
  If CheckBoxAutoToggle.Checked Then
    LMDGraphicLabel.Attributes := LMDGraphicLabel.Attributes+[taAutoToggled]
  else
    LMDGraphicLabel.Attributes := LMDGraphicLabel.Attributes-[taAutoToggled]
end;

procedure TLMDFormGraphicLabelEditor.CheckBoxToggledClick(Sender: TObject);
begin
  If CheckBoxToggled.Checked Then
    LMDGraphicLabel.Attributes := LMDGraphicLabel.Attributes+[taToggled]
  else
    LMDGraphicLabel.Attributes := LMDGraphicLabel.Attributes-[tatoggled]
end;

procedure TLMDFormGraphicLabelEditor.CheckBoxEqualLettersClick(
  Sender: TObject);
begin
  If CheckBoxEqualLetters.Checked Then
    LMDGraphicLabel.Attributes := LMDGraphicLabel.Attributes+[taEqualLetters]
  else
    LMDGraphicLabel.Attributes := LMDGraphicLabel.Attributes-[taEqualLetters]
end;

procedure TLMDFormGraphicLabelEditor.ComboBoxPerspectiveChange(
  Sender: TObject);
begin
  If ComboBoxPerspective.Text = 'None' Then
    LMDGraphicLabel.Attributes := LMDGraphicLabel.Attributes-[taPerspective]
  else
    Begin
      LMDGraphicLabel.Attributes := LMDGraphicLabel.Attributes+[taPerspective];
      If ComboBoxPerspective.Text = 'Bird' Then
        LMDGraphicLabel.Perspective := tpBird
      else
        LMDGraphicLabel.Perspective := tpFrog;
    End;
end;

procedure TLMDFormGraphicLabelEditor.LMDSpinEditPerspectiveDepthChange(
  Sender: TObject);
begin
  LMDGraphicLabel.PerspectiveDepth := LMDSpinEditPerspectiveDepth.AsInteger;
end;

procedure TLMDFormGraphicLabelEditor.LMDSpinEditToggleChange(Sender: TObject);
begin
  LMDGraphicLabel.Toggle := LMDSpinEditToggle.AsInteger;
end;

procedure TLMDFormGraphicLabelEditor.LMDSpinEditLightDepthChange(
  Sender: TObject);
begin
  LMDGraphicLabel.FontFX.LightDepth := LMDSpinEditLightDepth.AsInteger;
end;

procedure TLMDFormGraphicLabelEditor.LMDSpinEditShadowDepthChange(
  Sender: TObject);
begin
  LMDGraphicLabel.FontFX.ShadowDepth := LMDSpinEditShadowDepth.AsInteger;
end;

procedure TLMDFormGraphicLabelEditor.LMDSpinEditAngleChange(Sender: TObject);
begin
  LMDGraphicLabel.FontFX.Angle := LMDSpinEditAngle.AsInteger;
end;

procedure TLMDFormGraphicLabelEditor.LMDSpinEditTracingChange(
  Sender: TObject);
begin
  LMDGraphicLabel.FontFX.Tracing := LMDSpinEditTracing.AsInteger;
end;

procedure TLMDFormGraphicLabelEditor.ComboBoxStyleChange(Sender: TObject);
begin
  If ComboBoxStyle.Text = 'tdNone' Then
    LMDGraphicLabel.FontFX.Style := tdNone;
  If ComboBoxStyle.Text = 'tdSunken' Then
    LMDGraphicLabel.FontFX.Style := tdSunken;
  If ComboBoxStyle.Text = 'tdRaised' Then
    LMDGraphicLabel.FontFX.Style := tdRaised;
  If ComboBoxStyle.Text = 'tdSunkenShadow' Then
    LMDGraphicLabel.FontFX.Style := tdSunkenShadow;
  If ComboBoxStyle.Text = 'tdRaisedShadow' Then
    LMDGraphicLabel.FontFX.Style := tdRaisedShadow;
  If ComboBoxStyle.Text = 'tdPColorSunken' Then
    LMDGraphicLabel.FontFX.Style := tdPColorSunken;
  If ComboBoxStyle.Text = 'tdPColorRaised' Then
    LMDGraphicLabel.FontFX.Style := tdPColorRaised;
  If ComboBoxStyle.Text = 'tdShadow' Then
    LMDGraphicLabel.FontFX.Style := tdShadow;
end;

procedure TLMDFormGraphicLabelEditor.LMDSpinEditFactorChange(Sender: TObject);
begin
  LMDGraphicLabel.Factor := LMDSpinEditFactor.AsInteger;
end;

procedure TLMDFormGraphicLabelEditor.ComboBoxTransformChange(Sender: TObject);
begin
  LMDGraphicLabel.Transform := TLMDTransLabelTypes(ComboBoxTransform.ItemIndex);
end;

procedure TLMDFormGraphicLabelEditor.FormCreate(Sender: TObject);
begin
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

procedure TLMDFormGraphicLabelEditor.LMDLightColorComboBoxChange(
  Sender: TObject);
begin
  LMDGraphicLabel.FontFX.LightColor := LMDLightColorComboBox.SelectedColor;
end;

procedure TLMDFormGraphicLabelEditor.LMDShadowColorComboBoxChange(
  Sender: TObject);
begin
  LMDGraphicLabel.FontFX.ShadowColor := LMDShadowColorComboBox.SelectedColor;
end;

procedure TLMDFormGraphicLabelEditor.Button1Click(Sender: TObject);
begin
  LMDCPGetFillObject(LMDGraphicLabel.FillObject)
end;

end.
 
