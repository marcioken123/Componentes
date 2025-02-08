unit CustomiseEditDialog;

interface

{$I lmddlgcmps.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomiseDialog, ActnList, ExtDlgs, JSDialog, ExtCtrls, StdCtrls,
  Buttons, ComCtrls, JSTypes, JSEditDialog, JSDialogs, JSEditDialogs;

type
  TfrmCustomiseEditDialog = class(TfrmCustomiseDialog)
    JSEditDialog1: TJSEditDialog;
    tsEdit: TTabSheet;
    rgEditPropertiesCaptionPosition: TRadioGroup;
    rgEditPropertiesCoverageType: TRadioGroup;
    rgEditPropertiesEditType: TRadioGroup;
    eEditPropertiesCoverage: TEdit;
    eEditPropertiesCaption: TEdit;
    cbEditPropertiesAllowDoubleClickToClose: TCheckBox;
    eEditPropertiesHeight: TEdit;
    eEditPropertiesValue: TEdit;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    gbEditPropertiesItems: TGroupBox;
    lbEditPropertiesItems: TListBox;
    bEditPropertiesItemsAdd: TButton;
    bEditPropertiesItemsRemove: TButton;
    bEditPropertiesItemsClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure bEditPropertiesItemsClearClick(Sender: TObject);
    procedure bEditPropertiesItemsRemoveClick(Sender: TObject);
    procedure bEditPropertiesItemsAddClick(Sender: TObject);
  private
    FTempDialog: TJSEditDialog;
  protected
    procedure CreateTempDialog; override;
    procedure DestroyTempDialog; override;
    function GetTempDialog: TJSDialog; override;
    procedure LoadDialogValues; override;
    procedure SaveDialogValues(ADialog: TJSDialog); override;
  public
    { Public declarations }
  end;

var
  frmCustomiseEditDialog: TfrmCustomiseEditDialog;

implementation

uses
  TypInfo;

{$R *.dfm}

procedure TfrmCustomiseEditDialog.bEditPropertiesItemsAddClick(Sender: TObject);
var
  LValue: TJSString;
begin
  if JSEditDialogs.InputQuery('Add Item', 'Item to add:', LValue) then
    lbEditPropertiesItems.Items.Add(LValue);
end;

procedure TfrmCustomiseEditDialog.bEditPropertiesItemsClearClick(
  Sender: TObject);
begin
  if ShowWarningMessage('Are you sure you want to clear all items from the list?') = mrYes then
    lbEditPropertiesItems.Clear;  
end;

procedure TfrmCustomiseEditDialog.bEditPropertiesItemsRemoveClick(
  Sender: TObject);
begin
  if lbEditPropertiesItems.ItemIndex > -1 then
  begin
    if ShowWarningMessage('Are you sure you want to remove the selected item from the list?') = mrYes then
      lbEditPropertiesItems.Items.Delete(lbEditPropertiesItems.ItemIndex);
  end
  else
    ShowErrorMessage('Select the item you want to remove from the list.');
end;

procedure TfrmCustomiseEditDialog.CreateTempDialog;
begin
  FTempDialog := TJSEditDialog.Create(nil);
end;

procedure TfrmCustomiseEditDialog.DestroyTempDialog;
begin
  FTempDialog.Free;
end;

procedure TfrmCustomiseEditDialog.FormCreate(Sender: TObject);
var
  k: TJSEditType;
  l: TJSCaptionPosition;
  m: TCoverageType;
begin
  inherited;
  for k := low(TJSEditType) to high(TJSEditType) do
    rgEditPropertiesEditType.Items.Add(GetEnumName(TypeInfo(TJSEditType), ord(k)));
  for l := low(TJSCaptionPosition) to high(TJSCaptionPosition) do
    rgEditPropertiesCaptionPosition.Items.Add(GetEnumName(TypeInfo(TJSCaptionPosition), ord(l)));
  for m := low(TCoverageType) to high(TCoverageType) do
    rgEditPropertiesCoverageType.Items.Add(GetEnumName(TypeInfo(TCoverageType), ord(m)));
end;

function TfrmCustomiseEditDialog.GetTempDialog: TJSDialog;
begin
  result := FTempDialog;
end;

procedure TfrmCustomiseEditDialog.LoadDialogValues;
begin
  inherited;
  rgEditPropertiesEditType.ItemIndex := ord(TJSEditDialog(TempDialog).EditProperties.EditType);
  rgEditPropertiesCaptionPosition.ItemIndex := ord(TJSEditDialog(TempDialog).EditProperties.CaptionPosition);
  rgEditPropertiesCoverageType.ItemIndex := ord(TJSEditDialog(TempDialog).EditProperties.CoverageType);
  eEditPropertiesCoverage.Text := IntToStr(TJSEditDialog(TempDialog).EditProperties.Coverage);
  cbEditPropertiesAllowDoubleClickToClose.Checked := TJSEditDialog(TempDialog).EditProperties.AllowDoubleClickToClose;
  eEditPropertiesCaption.Text := TJSEditDialog(TempDialog).EditProperties.Caption;
  eEditPropertiesHeight.Text := IntToStr(TJSEditDialog(TempDialog).EditProperties.Height);
  eEditPropertiesValue.Text := TJSEditDialog(TempDialog).EditProperties.Value;
  lbEditPropertiesItems.Items.Assign(TJSEditDialog(TempDialog).EditProperties.Items);
end;

procedure TfrmCustomiseEditDialog.SaveDialogValues(ADialog: TJSDialog);
begin
  inherited;
  TJSEditDialog(ADialog).EditProperties.EditType := TJSEditType(rgEditPropertiesEditType.ItemIndex);
  TJSEditDialog(ADialog).EditProperties.CaptionPosition := TJSCaptionPosition(rgEditPropertiesCaptionPosition.ItemIndex);
  TJSEditDialog(ADialog).EditProperties.CoverageType := TCoverageType(rgEditPropertiesCoverageType.ItemIndex);
  TJSEditDialog(ADialog).EditProperties.Coverage := StrToInt(eEditPropertiesCoverage.Text);
  TJSEditDialog(ADialog).EditProperties.AllowDoubleClickToClose := cbEditPropertiesAllowDoubleClickToClose.Checked;
  TJSEditDialog(ADialog).EditProperties.Caption := eEditPropertiesCaption.Text;
  TJSEditDialog(ADialog).EditProperties.Height := StrToInt(eEditPropertiesHeight.Text);
  TJSEditDialog(ADialog).EditProperties.Value := eEditPropertiesValue.Text;
  TJSEditDialog(ADialog).EditProperties.Items.Assign(lbEditPropertiesItems.Items);
end;

end.
