unit LMDRTFRichDialog;
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

LMDRTFRichDialog unit (RM)
--------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Dialogs, LMDTypes, StdCtrls,
  LMDRTFBase, LMDRTFRichDialogForm;

type
  TLMDRichDialogActions = set of (rdaNew, rdaLoad, rdaSave, rdaPrint,
   rdaPreview, rdaFind, rdaCut, rdaCopy, rdaPaste, rdaUndo, rdaRedo,
   rdaTextAttributes, rdaTextBold, rdaTextItalic, rdaTextUnderline,
   rdaTextSubscript, rdaTextSuperscript, rdaParaAlign1, rdaParaAlign2,
   rdaParaAlign3, rdaNumbering1, rdaNumbering2, rdaIndent, rdaUnindent); 

  TLMDRichDialogGeneral = class(TPersistent)
  private
    FShowMainMenu: Boolean;
    FShowStatusBar: Boolean;
    FShowToolbar: Boolean;
    FCaption: String;
    FLeft: Integer;
    FTop: Integer;
    FHeight: Integer;
    FWidth: Integer;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ShowMainMenu: Boolean read FShowMainMenu write FShowMainMenu default True;
    property ShowStatusBar: Boolean read FShowStatusBar write FShowStatusBar default True;
    property ShowToolbar: Boolean read FShowToolbar write FShowToolbar default True;
    property Caption: String read FCaption write FCaption;
    property Left: Integer read FLeft write FLeft default -1;
    property Top: Integer read FTop write FTop default -1;
    property Height: Integer read FHeight write FHeight default -1;
    property Width: Integer read FWidth write FWidth default -1;
  end;

  TLMDRichDialogEditor = class(TPersistent)
  private
    FShowRuler: Boolean;
    FAutoURLDetect: Boolean;
    FScrollBars: TScrollStyle;
    FHideScrollBars: Boolean;
    FMeasurement: TLMDMeasurement;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ShowRuler: Boolean read FShowRuler write FShowRuler default True;
    property AutoURLDetect: Boolean read FAutoURLDetect write FAutoURLDetect default False;
    property ScrollBars: TScrollStyle read FScrollBars write FScrollBars default ssNone;
    property HideScrollBars: Boolean read FHideScrollBars write FHideScrollBars default True;
    property Measurement: TLMDMeasurement read FMeasurement write FMeasurement default unPoints;
  end;

{***************************** TLMDRichDialog *********************************}
  TLMDRichDialog = class(TLMDRichComponent)
  private
    FDialog: TLMDRichDialogForm;
    FGeneral: TLMDRichDialogGeneral;
    FEditor: TLMDRichDialogEditor;
    FActions: TLMDRichDialogActions;
    procedure SetDialog(const Value: TLMDRichDialogForm);
    procedure SetGeneral(const Value: TLMDRichDialogGeneral);
    procedure SetEditor(const Value: TLMDRichDialogEditor);    
    procedure SetActions(const Value: TLMDRichDialogActions);
  protected
    procedure SetUpRichDialog;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;
    property Dialog: TLMDRichDialogForm read FDialog write SetDialog;
  published
    property General: TLMDRichDialogGeneral read FGeneral write SetGeneral;
    property Editor: TLMDRichDialogEditor read FEditor write SetEditor;
    property Actions: TLMDRichDialogActions read FActions write SetActions;
  end;

implementation

uses
  ComCtrls;
  constructor TLMDRichDialogGeneral.Create;
begin
  inherited Create;
  FShowMainMenu := True;
  FShowStatusBar := True;
  FShowToolbar := True;
  FCaption := 'RichPad';
  FLeft := -1;
  FTop := -1;
  FHeight := -1;
  FWidth := -1;
end;

destructor TLMDRichDialogGeneral.Destroy;
begin
  inherited Destroy;
end;

constructor TLMDRichDialogEditor.Create;
begin
  inherited Create;
  FShowRuler := True;
  FAutoURLDetect := False;
  FScrollBars := ssNone;
  FHideScrollBars := True;  
  FMeasurement := unPoints;
end;

destructor TLMDRichDialogEditor.Destroy;
begin
  inherited Destroy;
end;

procedure TLMDRichDialog.SetUpRichDialog;
{
var
  i: integer;
  Btn: TToolButton;
  HasPrev, HasNext: Boolean;
  Separator, Divider: integer;
}
begin
  if not Assigned(FDialog) then exit;
  if FGeneral.ShowMainMenu then FDialog.Menu := FDialog.MainMenu else
   FDialog.Menu := nil;
  FDialog.StatusBar.Visible := FGeneral.ShowStatusBar;
  FDialog.Toolbar.Visible := FGeneral.ShowToolbar;
  FDialog.actNew.Visible := rdaNew in FActions;
  FDialog.actLoad.Visible := rdaLoad in FActions;
  FDialog.actSave.Visible := rdaSave in FActions;
  FDialog.actPrint.Visible := rdaPrint in FActions;
  FDialog.actPreview.Visible := rdaPreview in FActions;
  FDialog.actFind.Visible := rdaFind in FActions;
  FDialog.actCut.Visible := rdaCut in FActions;
  FDialog.actCopy.Visible := rdaCopy in FActions;
  FDialog.actPaste.Visible := rdaPaste in FActions;
  FDialog.actUndo.Visible := rdaUndo in FActions;
  FDialog.actRedo.Visible := rdaRedo in FActions;
  FDialog.actTextAttributes.Visible := rdaTextAttributes in FActions;
  FDialog.actTextBold.Visible := rdaTextBold in FActions;
  FDialog.actTextItalic.Visible := rdaTextItalic in FActions;
  FDialog.actTextUnderline.Visible := rdaTextUnderline in FActions;
  FDialog.actTextSubscript.Visible := rdaTextSubscript in FActions;
  FDialog.actTextSuperscript.Visible := rdaTextSuperscript in FActions;
  FDialog.actParaAlign1.Visible := rdaParaAlign1 in FActions;
  FDialog.actParaAlign2.Visible := rdaParaAlign2 in FActions;
  FDialog.actParaAlign3.Visible := rdaParaAlign3 in FActions;
  FDialog.actNumbering1.Visible := rdaNumbering1 in FActions;
  FDialog.actNumbering2.Visible := rdaNumbering2 in FActions;
  FDialog.actIndent.Visible := rdaIndent in FActions;
  FDialog.actUnindent.Visible := rdaUnindent in FActions;
  FDialog.Caption := FGeneral.Caption;
  if FGeneral.Left <> -1 then FDialog.Left := FGeneral.Left;
  if FGeneral.Top <> -1 then FDialog.Top := FGeneral.Top;
  if FGeneral.Width <> -1 then FDialog.Width := FGeneral.Width;
  if FGeneral.Height <> -1 then FDialog.Height := FGeneral.Height;
  FDialog.LMDRichEdit.ShowRuler := FEditor.ShowRuler;
  FDialog.LMDRichEdit.AutoURLDetect := FEditor.AutoURLDetect;
  FDialog.LMDRichEdit.ScrollBars := FEditor.ScrollBars;
  FDialog.LMDRichEdit.Measurement := FEditor.Measurement;
  FDialog.LMDRichEdit.HideScrollBars := FEditor.HideScrollBars;
(*
  HasPrev := False;
  HasNext := False;
  Separator := -1;
  Divider := -1;

  for i := 0 to FDialog.ToolBar.ButtonCount - 1 do
    begin
      Btn := FDialog.ToolBar.Buttons[i];

      if  Btn.Style in [tbsSeparator, tbsDivider] then
        begin
          if  not HasPrev then
            Btn.State := tbsHidden;
        end
      else
      if  Btn.Visible then
        begin
          HasPrev := True;
        end
      else
        begin
        end;
    end;
*)
end;

constructor TLMDRichDialog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
//  FDialog := TLMDRichDialogForm.Create(nil);
  FGeneral := TLMDRichDialogGeneral.Create;
  FEditor := TLMDRichDialogEditor.Create;
  FActions := [rdaNew, rdaLoad, rdaSave, rdaPrint,
   rdaPreview, rdaFind, rdaCut, rdaCopy, rdaPaste, rdaUndo, rdaRedo,
   rdaTextAttributes, rdaTextBold, rdaTextItalic, rdaTextUnderline,
   rdaTextSubscript, rdaTextSuperscript, rdaParaAlign1, rdaParaAlign2,
   rdaParaAlign3, rdaNumbering1, rdaNumbering2, rdaIndent, rdaUnindent];
end;

destructor TLMDRichDialog.Destroy;
begin
  FGeneral.Free;
  FEditor.Free;
  FDialog.Free;
  inherited Destroy;
end;

procedure TLMDRichDialog.SetDialog(const Value: TLMDRichDialogForm);
begin
  if not Assigned(FDialog) then
    FDialog := TLMDRichDialogForm.Create(nil);
  FDialog.Assign(Value);
end;

procedure TLMDRichDialog.Execute;
begin
  if not Assigned(FDialog) then
    FDialog := TLMDRichDialogForm.Create(nil);
  SetUpRichDialog;
  FDialog.ShowModal;
end;

procedure TLMDRichDialog.SetGeneral(const Value: TLMDRichDialogGeneral);
begin
  FGeneral.Assign(Value);
end;

procedure TLMDRichDialog.SetEditor(const Value: TLMDRichDialogEditor);
begin
  FEditor.Assign(Value);
end;

procedure TLMDRichDialog.SetActions(const Value: TLMDRichDialogActions);
begin
  FActions := Value;

  if  Assigned(FDialog) then
    SetUpRichDialog;
end;

end.
