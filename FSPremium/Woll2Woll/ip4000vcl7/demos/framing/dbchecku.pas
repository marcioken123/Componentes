unit dbchecku;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  wwdbdatetimepicker, wwdblook, wwDialog,
  Wwfltdlg, wwSpeedButton, wwDBNavigator, ExtCtrls, Db, DBTables, Wwtable,
  Wwdatsrc, Wwdbspin, Buttons, wwclearpanel, Wwdbgrid, ComCtrls, wwriched;

type
  TCustomFramingForm = class(TForm)
    PaymentName: TwwDBEdit;
    CurrencyCombo: TwwDBComboBox;
    AmountWord: TwwDBEdit;
    Signature: TwwDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DateMade: TwwDBDateTimePicker;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    wwDBRichEdit1: TwwDBRichEdit;
    wwDBEdit1: TwwDBEdit;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    wwDBNavigator1Insert: TwwNavButton;
    wwDBNavigator1Post: TwwNavButton;
    wwDBNavigator1Cancel: TwwNavButton;
    wwDataSource1: TDataSource;
    wwTable1: TTable;
    Image1: TImage;
    procedure wwDataSource1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CustomFramingForm: TCustomFramingForm;

implementation

{$R *.DFM}

procedure TCustomFramingForm.wwDataSource1DataChange(Sender: TObject; Field: TField);
begin
  with (Sender as TDataSource).DataSet do begin
     Label9.Caption := ':145681 :146 :'+ FieldByName('CheckNo').AsString;
  end;
end;

end.
