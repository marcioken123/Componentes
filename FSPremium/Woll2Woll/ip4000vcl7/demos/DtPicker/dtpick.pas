unit dtpick;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Db, DBTables, Wwtable, Wwdatsrc,
  wwDBDateTimePicker,wwmonthcalendar, Grids, Wwdbigrd, Wwdbgrid, Menus,
  ComCtrls, wwriched, Buttons, Mask, wwdbedit, Wwdotdot, wwSpeedButton,
  wwDBNavigator, wwclearpanel;

type
  TDateTimePickerForm = class(TForm)
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    Panel1: TPanel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    Label5: TLabel;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1PriorPage: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1NextPage: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    wwDBNavigator1Insert: TwwNavButton;
    wwDBNavigator1Delete: TwwNavButton;
    wwDBNavigator1Edit: TwwNavButton;
    wwDBNavigator1Post: TwwNavButton;
    wwDBNavigator1Cancel: TwwNavButton;
    wwDBNavigator1Refresh: TwwNavButton;
    wwDBNavigator1SaveBookmark: TwwNavButton;
    wwDBNavigator1RestoreBookmark: TwwNavButton;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    wwDBDateTimePicker3: TwwDBDateTimePicker;
    Label8: TLabel;
    Label9: TLabel;
    wwDBDateTimePicker4: TwwDBDateTimePicker;
    Label7: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    RadioGroup1: TRadioGroup;
    wwDBRichEdit4: TwwDBRichEdit;
    wwDBRichEdit3: TwwDBRichEdit;
    wwDBRichEdit2: TwwDBRichEdit;
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure wwDBDateTimePicker1CalcBoldDay(Sender: TObject; ADate: TDate;
      Month, Day, Year: Integer; var Accept: Boolean);
    procedure Edit1Exit(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DateTimePickerForm: TDateTimePickerForm;

implementation

{$R *.DFM}

procedure TDateTimePickerForm.CheckBox1Click(Sender: TObject);
var i: Integer;
begin
   for i:= 0 to ComponentCount-1 do
   begin
      if Components[i] is TwwDBDateTimePicker then
         with TwwDBDateTimePicker(Components[i]).CalendarAttributes do
             if (Sender as TCheckBox).checked then
                Options:= Options + [mdoWeekNumbers]
             else
                Options:= Options - [mdoWeekNumbers]
   end
end;

procedure TDateTimePickerForm.CheckBox2Click(Sender: TObject);
var i: Integer;
begin
   for i:= 0 to ComponentCount-1 do
   begin
      if Components[i] is TwwDBDateTimePicker then
         with TwwDBDateTimePicker(Components[i]).CalendarAttributes do
             if (Sender as TCheckBox).checked then
                Options:= Options - [mdoNoToday]
             else
                Options:= Options + [mdoNoToday]
   end
end;

procedure TDateTimePickerForm.CheckBox3Click(Sender: TObject);
var i: Integer;
begin
   for i:= 0 to ComponentCount-1 do
   begin
      if Components[i] is TwwDBDateTimePicker then
         with TwwDBDateTimePicker(Components[i]).CalendarAttributes do
             if (Sender as TCheckBox).checked then
                Options:= Options - [mdoNoTodayCircle]
             else
                Options:= Options + [mdoNoTodayCircle]
   end
end;

procedure TDateTimePickerForm.RadioGroup1Click(Sender: TObject);
var i: integer;
begin
   for i:= 0 to ComponentCount-1 do
   begin
      if Components[i] is TwwDBDateTimePicker then
         with TwwDBDateTimePicker(Components[i]).CalendarAttributes do
             if (Sender as TRadioGroup).itemIndex=0 then
                Options:= Options - [mdoDayState]
             else
                Options:= Options + [mdoDayState]
   end
end;

procedure TDateTimePickerForm.wwDBDateTimePicker1CalcBoldDay(Sender: TObject;
  ADate: TDate; Month, Day, Year: Integer; var Accept: Boolean);
var i:integer;
   { Holiday is not based on date but based on day of week }
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
   case radiogroup1.ItemIndex of
   1: begin
        if DayOfWeek(ADate)=1 then Accept := True;
        if DayOfWeek(ADate)=7 then Accept := True;
      end;
   2: begin
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
   3: begin
      If SpecialHoliday(1,6) or SpecialHoliday(3,6) then Accept :=True;
   end;
   end;
end;

procedure TDateTimePickerForm.Edit1Exit(Sender: TObject);
begin
{   epochyear := StrToIntDef(Edit1.Text,0);
   if (epochyear = 0) or (epochyear <= 1899) or (epochyear > 9999) then begin
      ShowMessage('Enter a Valid 4 digit Year (1900-9999)');
      Edit1.SetFocus;
      abort;
   end
   else wwdbdatetimepicker1.Epoch := epochyear;}
end;

procedure TDateTimePickerForm.ComboBox1Change(Sender: TObject);
var i: integer;
begin
   for i:= 0 to ComponentCount-1 do
   begin
      if Components[i] is TwwDBDateTimePicker then
         with TwwDBDateTimePicker(Components[i]).CalendarAttributes do
           if ComboBox1.Text = 'Center' then
              Alignment := wwdtaCenter
           else if ComboBox1.Text = 'Right' then
              Alignment := wwdtaRight
           else Alignment := wwdtaLeft;
   end

end;

end.
