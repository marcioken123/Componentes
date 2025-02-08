unit pLMDChartValuesOptionsSelDlg;
{$I lmdcmps.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, LMDChartValuesBase;

type
  TLMDChartValuesOptionsSelector = class(TForm)
    btCancel: TButton;
    btOK: TButton;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    edColCaption: TEdit;
    cbColName: TComboBox;
    Label2: TLabel;
    lbFieldName: TLabel;
    cbFieldName: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
    function Edit(AValues: TLMDChartValuesBase): boolean;
  end;

var
  LMDChartValuesOptionsSelector: TLMDChartValuesOptionsSelector;

implementation

{$R *.DFM}

{ TLMDChartValuesOptionsSelector }

function TLMDChartValuesOptionsSelector.Edit(AValues: TLMDChartValuesBase): boolean;
begin
  Result := false;
  Self.cbColName.Text := AValues.Name;
  Self.edColCaption.Text := AValues.Caption;
  case AValues.ValueType of
    cvtNumber: Self.RadioGroup1.ItemIndex := 0;
    cvtMoney: Self.RadioGroup1.ItemIndex := 1;
    cvtDate: Self.RadioGroup1.ItemIndex := 2;
    cvtLabel: Self.RadioGroup1.ItemIndex := 3;
  end;

  if Self.ShowModal = mrOK then
  begin
    AValues.Name := Self.cbColName.Text;
    AValues.Caption := Self.edColCaption.Text;
    case Self.RadioGroup1.ItemIndex of
        0: AValues.ValueType := cvtNumber;
        1: AValues.ValueType := cvtMoney;
        2: AValues.ValueType := cvtDate;
        3: AValues.ValueType := cvtLabel;
    end;
    Result := true;
  end;
end;

end.
