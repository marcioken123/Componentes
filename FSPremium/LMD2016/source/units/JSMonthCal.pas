{ Summary
  This unit contains a thin wrapper over the TMonthCalendar control. Only permitting the double click event
  being called when an actual date in the calendar is double clicked on. }
unit JSMonthCal;

interface

{$I lmddlgcmps.inc}

uses
    Windows
  , ComCtrls
  ;

type
  { Summary
    Control used to display a calendar for the InputCalendar methods.
    Description
    This calendar control is a direct descendant from the TMonthCalendar control.
    The only difference is a bug fix to make sure that the double clicking event is only
    processed when actually double clicking on a date in the calendar. }
  TJSMonthCalendar = class(TMonthCalendar)
  protected
  { Summary
    Overriden to alter default (and incorrect) behaviour in TMonthCalendar.
    Description
    Only allow the processing of a double click when the double click occurs on an actual day in the calendar. }
    procedure DblClick; override;
  end;

implementation

uses
    CommCtrl
  , Controls
  ;

{ TJSMonthCalendar }

procedure TJSMonthCalendar.DblClick;
var
  lHitTest: MCHITTESTINFO;
begin
  lHitTest.cbSize := SizeOf(lHitTest);
  lHitTest.pt := ScreenToClient(Mouse.CursorPos);
  MonthCal_HitTest(Handle, lHitTest);
  if (lHitTest.uHit or MCHT_CALENDARDATE) = MCHT_CALENDARDATE then
   inherited;
end;

end.
