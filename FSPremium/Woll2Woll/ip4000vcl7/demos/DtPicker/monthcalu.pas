unit monthcalu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, wwmonthcalendar, ExtCtrls, Spin, ComCtrls, wwriched, Menus,
  wwdbdatetimepicker, Mask, wwdbedit, Wwdbspin;

type
  TMonthCalendarForm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    CheckBox8: TCheckBox;
    Panel2: TPanel;
    wwDBMonthCalendar1: TwwDBMonthCalendar;
    Button2: TButton;
    StatusBar1: TStatusBar;
    wwDBSpinEdit1: TwwDBSpinEdit;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    wwDBSpinEdit2: TwwDBSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    wwDBSpinEdit3: TwwDBSpinEdit;
    CheckBox5: TCheckBox;
    Label7: TLabel;
    GroupBox3: TGroupBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    CheckBox4: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    Label3: TLabel;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    Label9: TLabel;
    Label10: TLabel;
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure wwDBMonthCalendar1CalcBoldDay(Sender: TObject; ADate: TDate;
      Month, Day, Year: Integer; var Accept: Boolean);
    procedure wwDBDateTimePicker1Change(Sender: TObject);
    procedure wwDBDateTimePicker2Change(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure wwDBMonthCalendar1MouseMove(Sender: TObject;
      Shift: TShiftState; X, Y, Month, Day, Year: Integer);
    procedure wwDBSpinEdit1Change(Sender: TObject);
    procedure wwDBSpinEdit2Change(Sender: TObject);
    procedure wwDBSpinEdit3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MonthCalendarForm: TMonthCalendarForm;

implementation

uses mnthyear;

{$R *.DFM}

procedure TMonthCalendarForm.CheckBox1Click(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then begin
     wwDBmonthcalendar1.Options := wwDBmonthcalendar1.Options - [mdoNoTodayCircle];
  end
  else begin
     wwDBmonthcalendar1.Options := wwDBmonthcalendar1.Options + [mdoNoTodayCircle];
  end;
end;

procedure TMonthCalendarForm.CheckBox2Click(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then begin
     wwDBmonthcalendar1.Options := wwDBmonthcalendar1.Options - [mdoNoToday];
  end
  else begin
     wwDBmonthcalendar1.Options := wwDBmonthcalendar1.Options + [mdoNoToday];
  end;
end;

procedure TMonthCalendarForm.CheckBox3Click(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then begin
     wwDBmonthcalendar1.Options := wwDBmonthcalendar1.Options + [mdoWeekNumbers];
  end
  else begin
     wwDBmonthcalendar1.Options := wwDBmonthcalendar1.Options - [mdoWeekNumbers];
  end;
end;

procedure TMonthCalendarForm.CheckBox4Click(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then begin
     wwDBmonthcalendar1.Options := wwDBmonthcalendar1.Options + [mdoDayState];
     RadioButton1.Enabled := True;
     RadioButton2.Enabled := True;
     RadioButton3.Enabled := True;
     RadioButton4.Enabled := True;
  end
  else begin
     wwDBmonthcalendar1.Options := wwDBmonthcalendar1.Options - [mdoDayState];
     RadioButton1.Enabled := False;
     RadioButton2.Enabled := False;
     RadioButton3.Enabled := False;
     RadioButton4.Enabled := False;
  end;
end;

procedure TMonthCalendarForm.Button1Click(Sender: TObject);
begin
  Showmessage('You selected: '+ DateToStr(wwDBmonthcalendar1.StartDate)+
              ' to '+ DateToStr(wwDBmonthcalendar1.EndDate));
end;

procedure TMonthCalendarForm.RadioButton1Click(Sender: TObject);
begin
  wwDBmonthcalendar1.Options := wwDBmonthcalendar1.Options - [mdoDayState];
  wwDBmonthcalendar1.Options := wwDBmonthcalendar1.Options + [mdoDayState];
end;

procedure TMonthCalendarForm.Button2Click(Sender: TObject);
begin
   with TYearCalendar.create(self) do begin
     showmodal;
     free;
   end;
end;

procedure TMonthCalendarForm.wwDBMonthCalendar1CalcBoldDay(Sender: TObject;
  ADate: TDate; Month, Day, Year: Integer; var Accept: Boolean);
var i:integer;
   Function SpecialHoliday(weekno,dayno:integer):boolean;
   var curdayindex:integer;
   begin
      curdayindex := DayOfWeek(StrToDate(inttostr(month)+'/1/'+Inttostr(Year)));
      if (curdayindex<=dayno) and (Day = dayno-curdayindex+7*(weekno-1)+1) then result := True
      else if (curdayindex>dayno) and (Day = 8-(curdayindex-dayno)+7*(weekno-1)) then result := True
      else result := False;
   end;
begin
   Accept := False;
   i := DayOfWeek(Adate);
   if RadioButton1.Checked then begin
      if DayOfWeek(ADate)=1 then Accept := True;
      if DayOfWeek(ADate)=7 then Accept := True;
   end;
   if RadioButton2.Checked then begin
                       {Highlight Leap Year Day}
      If isLeapYear(Year) and (Month = 2) and (Day=29) then
         Accept := True;
   end;
   if RadioButton3.Checked then begin
      if (Month = 1) then begin
         if (Month = 1) and (Day = 1) then
            Accept := True // New Years Day
         else if (SpecialHoliday(3,2)) then
            Accept :=True; //Birthday of Martin Luther King, third Monday in January.
      end
      else if (Month = 2) then begin
         if (Month = 2) and (Day = 2) then
            Accept := True // GroundHog Day
         else if (Month = 2) and (Day = 12) then
            Accept := True // Lincoln's Birthday
         else if (Month = 2) and (Day = 14) then
            Accept := True // Valentines Day
         else if (SpecialHoliday(3,2)) then
            Accept :=True;  //Washington's Birthday, third Monday in February.
      end
      else if (Month = 3) and (Day = 17) then
         Accept := True // St.Patricks Day
      else if (Month = 4) and (Day = 1) then
         Accept := True // April Fool's Day
      else if (Month = 5) then begin
         if (SpecialHoliday(2,1)) then
            Accept := True //Mother's Day
         else if (i=2) and ((31-Day)<=6) then
            Accept := True; //Memorial Day - Last Monday in May
      end
      else if (Month = 6) then begin
         if (Month = 6) and (Day = 14) then
            Accept := True // Flag Day
         else if (SpecialHoliday(3,1)) then
            Accept :=True; //Father's Day - 3rd Sunday in June
      end
      else if (Month = 7) and (Day = 4) then
         Accept := True // Independence Day
      else if (Month = 9) then begin //Labor Day - first Monday in September.
         if (SpecialHoliday(1,2)) then accept :=True;
      end
      else if (Month = 10) then begin
         if (Month = 10) and (Day = 31) then
             Accept := True // Halloween
         else if (SpecialHoliday(2,2)) then
             Accept :=True; //Columbus Day second Monday in October.
      end
      else if (Month = 11) then begin
         if (Month = 11) and (Day = 11) then
            Accept := True // Veterans Day
         else if (SpecialHoliday(4,5)) then
            Accept :=True; //ThanksGiving - Fourth Thursday in November
      end
      else if (Month = 12) and (Day = 25) then
           Accept := True; // Christmas
   end;

   if RadioButton4.Checked then begin
   // Payday on first and 3rd Friday of every month
      If SpecialHoliday(1,6) or SpecialHoliday(3,6) then Accept :=True;
   end;
end;

procedure TMonthCalendarForm.CheckBox8Click(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then begin
     Button1.Enabled := True;
     wwdbSpinEdit1.Enabled := True;
     Label1.Enabled := True;
     wwdbmonthcalendar1.Options := wwdbmonthcalendar1.Options + [mdoMultiSelect];
     wwdbmonthcalendar1.MaxSelectCount := 14;
     wwdbmonthcalendar1.StartDate := Trunc(wwdbmonthcalendar1.Date);
     wwdbmonthcalendar1.EndDate := Trunc(wwdbmonthcalendar1.Date)+13;
  end
  else begin
     Button1.Enabled := False;
     wwdbSpinEdit1.Enabled := False;
     Label1.Enabled := False;
     wwdbmonthcalendar1.Options := wwdbmonthcalendar1.Options - [mdoMultiSelect];
  end;
end;

procedure TMonthCalendarForm.wwDBDateTimePicker1Change(Sender: TObject);
begin
   wwDBDateTimePicker2.MinDate := wwDBDateTimePicker1.Date;
   wwDBMonthCalendar1.MinDate := wwDBDateTimePicker1.Date;
end;

procedure TMonthCalendarForm.wwDBDateTimePicker2Change(Sender: TObject);
begin
   wwDBDateTimePicker1.MaxDate := wwDBDateTimePicker2.Date;
   wwDBMonthCalendar1.MaxDate := wwDBDateTimePicker2.Date;
end;

procedure TMonthCalendarForm.CheckBox5Click(Sender: TObject);
begin
  wwDBmonthcalendar1.PopupYearOptions.ShowEdityear:=
    (Sender as TCheckBox).Checked;
end;

procedure TMonthCalendarForm.wwDBMonthCalendar1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y, Month, Day, Year: Integer);
begin
  if Day <> 0 then    //If Day is 0 then Mouse is not over a Day
     StatusBar1.Panels[0].Text := 'Mouse is over the following date: ' + DateToStr(EncodeDate(Year,Month,Day))
  else StatusBar1.Panels[0].Text := 'Move the mouse over a date';
end;

procedure TMonthCalendarForm.wwDBSpinEdit1Change(Sender: TObject);
begin
  if wwdbspinedit1.Text <> '' then begin
    try
       wwDBmonthcalendar1.MaxSelectCount := Trunc(wwdbspinedit1.Value);
    except
       wwDBmonthcalendar1.MaxSelectCount := 1;
    end;
  end;
end;

procedure TMonthCalendarForm.wwDBSpinEdit2Change(Sender: TObject);
begin
  if wwdbspinedit2.Text <> '' then begin
    try
       wwDBmonthcalendar1.PopupYearOptions.NumberColumns := Trunc(wwdbSpinEdit2.Value);
    except
       wwDBmonthcalendar1.PopupYearOptions.NumberColumns := 2;
    end;
  end;
end;

procedure TMonthCalendarForm.wwDBSpinEdit3Change(Sender: TObject);
begin
  if wwdbspinedit3.Text <> '' then begin
    try
       if length(wwdbspinedit3.Text)=4 then
          wwDBmonthcalendar1.PopupYearOptions.StartYear := Trunc(wwdbSpinEdit3.Value)
       else wwDBmonthcalendar1.PopupYearOptions.StartYear := 1990;
    except
       wwDBmonthcalendar1.PopupYearOptions.StartYear := 1990;
    end;
  end;
end;











end.
