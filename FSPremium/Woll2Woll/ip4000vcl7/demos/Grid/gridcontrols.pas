unit gridcontrols;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, Db, DBTables, StdCtrls, ComCtrls, wwriched,
  DBCtrls, wwdblook, wwclearbuttongroup, wwradiogroup, wwcheckbox, ImgList,
  Mask, wwDataInspector, Buttons, DBCGrids, Wwtable, wwpaintoptions,
  wwdbedit, wwDialog, wwidlg, wwrcdvw, wwdbdatetimepicker;

type
  TGridControlsForm = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    wwDBGrid1: TwwDBGrid;
    Table1LAST_NAME: TStringField;
    Table1FIRST_NAME: TStringField;
    Table1ACCT_NBR: TFloatField;
    Table1ADDRESS_1: TStringField;
    Table1CITY: TStringField;
    Table1STATE: TStringField;
    Table1ZIP: TStringField;
    Table1TELEPHONE: TStringField;
    Table1DATE_OPEN: TDateField;
    Table1SS_NUMBER: TFloatField;
    Table1PICTURE: TStringField;
    Table1BIRTH_DATE: TDateField;
    Table1RISK_LEVEL: TStringField;
    Table1OCCUPATION: TStringField;
    Table1OBJECTIVES: TStringField;
    Table1INTERESTS: TStringField;
    Table1IMAGE: TBlobField;
    Table1RINTERESTS: TBlobField;
    Table1SEX: TStringField;
    Table1EDUCATION: TSmallintField;
    Table1CREDRATING: TStringField;
    Table1MARRIED: TBooleanField;
    Table1selected: TBooleanField;
    Table1details: TIntegerField;
    wwDBGrid1IButton: TwwIButton;
    Table1PAYMETHOD: TSmallintField;
    Table1BALANCEDUE: TFloatField;
    ImageList6: TImageList;
    DBImage2: TDBImage;
    wwDBRichEdit2: TwwDBRichEdit;
    wwRadioGroup2: TwwRadioGroup;
    wwDataInspector1: TwwDataInspector;
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GridControlsForm: TGridControlsForm;

implementation

{$R *.DFM}

procedure TGridControlsForm.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
exit;
  with (Sender as TwwDBGrid) do begin
    if (Sender as TwwDBGrid).IsSelectedRecord then begin
      ABrush.Color := clWhite;
      AFont.Color := clBlack;
    end;
    if calccellrow = getactiverow then begin
      ABrush.Color := clHighlight;
      AFont.Color := clWhite;
    end;
  end;
end;

end.
