unit combodemou;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, StdCtrls, ComCtrls,
  wwriched, wwcheckbox, wwtypes, Db, DBTables;

type
  TComboDemoForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Bevel3: TBevel;
    Label3: TLabel;
    Image2: TImage;
    wwDBRichEdit2: TwwDBRichEdit;
    Bevel5: TBevel;
    Panel5: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel6: TBevel;
    Panel6: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    wwDBComboBox2: TwwDBComboBox;
    wwDBEdit1: TwwDBEdit;
    wwDBComboBox1: TwwDBComboBox;
    wwCheckBox1: TwwCheckBox;
    DataSource1: TDataSource;
    Table1: TTable;
    Label12: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    Label4: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    wwDBRichEdit1: TwwDBRichEdit;
    FirstNameCombo: TwwDBComboBox;
    Panel2: TPanel;
    CompanyNameCombo: TwwDBComboBox;
    Panel3: TPanel;
    FontNameCombo: TwwDBComboBox;
    Panel4: TPanel;
    procedure FormShow(Sender: TObject);
    procedure wwDBComboBox2DropDown(Sender: TObject);
    procedure wwDBComboBox2CloseUp(Sender: TwwDBComboBox; Select: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ComboDemoForm: TComboDemoForm;

implementation

{$R *.DFM}

procedure TComboDemoForm.FormShow(Sender: TObject);
var i:integer;
begin

  for i:= 0 to Screen.fonts.count-1 do
     fontnamecombo.Items.Add(screen.fonts[i]);
end;

procedure TComboDemoForm.wwDBComboBox2DropDown(Sender: TObject);
begin
  (Sender as TwwDBComboBox).TwoColumnDisplay := wwcheckbox1.checked;
end;

procedure TComboDemoForm.wwDBComboBox2CloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
   Sender.UpdateRecord; // flush contents so that other edit controls immediately reflect change
end;

end.
