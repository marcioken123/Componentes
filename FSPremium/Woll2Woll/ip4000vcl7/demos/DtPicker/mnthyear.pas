unit mnthyear;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, wwmonthcalendar, ExtCtrls;

type
  TYearCalendar = class(TForm)
    Panel1: TPanel;
    wwDBMonthCalendar1: TwwDBMonthCalendar;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  YearCalendar: TYearCalendar;

implementation

{$R *.DFM}

end.
