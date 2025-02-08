unit LMDCalendarDlg;
{$I lmdcmps.inc}

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

LMDCalendarDlg unit ()
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Classes,
  LMDButtonBase, LMDCalendar, LMDBaseDialog;

type
  TLMDCalExecuteEvent = procedure (Sender : TObject; cal : TLMDCalendar) of object;

  TLMDCalendarDlg = class (TLMDBaseDialog)
  private
    FDate                    : TDateTime;
    FCloseOnDblClick,
    FActualDateButton,
    FStartWithActualDate     : Boolean;
    FHeaderRepeatingInterval : Integer;
    //needed for DoOnActualDateClick (only a pointer to dialogues calendar)
    FCal                     : TLMDCalendar;
    FOnCalDlgExecute         : TLMDCalExecuteEvent;
    FStartDay: Byte;

    procedure SetDate (aValue : String);
    function GetDate : String;
    procedure DoOnActualDateClick (Sender : TObject);
    procedure DoOnDblClick (Sender : TObject);
  public
    constructor Create (aOwner : TComponent); override;
    function Execute:Boolean; override;
    function ExecuteEnh(Main:TForm):Boolean;
    property CtlXP; // compatibility
    property DateValue : TDateTime read FDate write FDate;
  published
    property About;
    property CaptionFill;
    property CaptionTitle;
    property Colors;
    property CustomButton;
    property Date : String read GetDate write SetDate;
    property Effect;
    property Hints;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property Position;
    property RelatePos;
    property ShowHints;
    property StartWithActualDate : Boolean read FStartWithActualDate write FStartWithActualDate default false;
    property StartDay : Byte read FStartDay write FStartDay default 1;
    property ActualDateButton : Boolean read FActualDateButton write FActualDateButton default false;
    property CloseOnDblClick : Boolean read FCloseOnDblClick write FCloseOnDblClick default false;
    property HeaderRepeatingInterval : Integer read FHeaderRepeatingInterval write FHeaderRepeatingInterval default 100;
    property ThemeMode;
    property ThemeGlobalMode;    
    {Events}
    property OnCustomize;
    property OnCustomClick;
    property OnExecute : TLMDCalExecuteEvent read FOnCalDlgExecute write FOnCalDlgExecute;
  end;

implementation

uses
  StdCtrls,
  Controls,
  Graphics,
  SysUtils,
  LMDCal,
  LMDGraph,
  LMDButton,
  LMDFormStyler,
  LMDBack,
  LMDConst;

{--------------------------- private ------------------------------------------}
procedure TLMDCalendarDlg.SetDate (aValue : String);
begin
  try
    FDate := StrToDate (aValue);
  except
    FDate := Now;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCalendarDlg.GetDate : String;
begin
  result := DateToStr (FDate);
end;

{--------------------------- public -------------------------------------------}
constructor TLMDCalendarDlg.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FDate := Now;
  FStartWithActualDate := false;
  FStartDay := 1;
  FActualDatebutton := false;
  FCloseOnDblClick := false;
  FHeaderRepeatingInterval := 100;
end;

{------------------------------------------------------------------------------}
procedure TLMDCalendarDlg.DoOnActualDateClick(Sender : TObject);
begin
  FCal.Date := Now;
end;

{------------------------------------------------------------------------------}
procedure TLMDCalendarDlg.DoOnDblClick(Sender : TObject);
begin
  GetParentForm (TControl(Sender)).ModalResult := mrOK;
end;

{------------------------------------------------------------------------------}
function TLMDCalendarDlg.ExecuteEnh(Main:TForm):Boolean;
var
  cd     : TForm;
  adate,
  custom,
  ok,
  cancel : TLMDButton;
  cal    : TLMDCalendar;
  fs     : TLMDFormStyler;
  b      : TLMDBack;
  ct     : Integer;

begin
  result := false;
  cd := TForm.Create(nil);
  try
    with cd do
      begin
        BorderStyle:=bsDialog;
        Font.Color:=clWindowText;
        Font.Name:='MS Sans Serif';
        Font.Height:=-11;
        Position:=poDefault;
        PixelsPerInch:=96;
        Width := 380;
        Height := 245;

        cal := TLMDCalendar.Create(cd);
        with cal do
          begin
            Parent := cd;
            Left := 10;
            Top := 10;
            Width := 250;
            Height := 200;
            Header.Elements := [heMonthName, heYear, heYearBtns, heMonthBtns];
            Header.Style.FillObject.Style := sfBrush;
            Header.Style.FillObject.Brush.Color := clNavy;
            Header.ButtonStyle := ubsIntegrated;
            Header.Style.Font.Color := clWhite;
            Header.RepeatingInterval := FHeaderRepeatingInterval;
            Date := FDate;
            StartWithActualDate := FStartWithActualDate;
            StartDay := FStartDay;
            SelectedCellStyle.Mask := '<d>';
            FillObject.Style := sfBrush;
            OnDblClick := DoOnDblClick;
            if Assigned (FOnCalDlgExecute) then FOnCalDlgExecute (self, cal);
          end;

        cancel:=TLMDButton.Create(cd);
        with cancel do
          begin
            Parent:=cd;
            Width:=80;
            Height:=24;
            Left:=cal.Left + cal.Width + 20;
            Top:=cal.Top + cal.Height - Height;

            ModalResult:=mrCancel;
            Caption:=IDS_CANCEL;
            Cancel:=True;
            TabOrder:=1;
          end;

        ct := cancel.Top;

        ok:=TLMDButton.Create(cd);
        with ok do
          begin
            Parent:=cd;
            Width:=80;
            Height:=24;
            Left:=cal.Left + cal.Width + 20;
            Top:=ct - Height - 5;
            ModalResult:=1;
            Caption:='OK';
            Default:=True;
            Cancel:=True;
            TabOrder:=0;
          end;

        ct := ok.Top;

        if FActualDateButton then
          begin
            adate := TLMDButton.Create(cd);
            with adate do
              begin
                Parent := cd;
                Width:=80;
                Height:=24;
                Left:=cal.Left + cal.Width + 20;
                Top:=ct - Height - 10;
                Caption := IDS_ACTUALDATE;
                OnClick := DoOnActualDateClick;
                TabOrder:=0;
              end;
            FCal := cal;
            ct := adate.Top;
          end;

        custom:=TLMDButton.Create(cd);
        with custom do
          begin
            Parent:=cd;
            Width:=80;
            Height:=24;
            Left:=cal.Left + cal.Width + 20;
            Top:=ct - Height - 10;
            TabOrder:=0;
          end;

        if ShowHints and (Hints.Count>0) then
          begin
            ShowHint:=True;
            ok.Hint:=Hints[0];
            if Hints.Count>1 then cancel.Hint:=Hints[1];
            if Hints.Count>2 then custom.Hint:=Hints[2];
          end;

        fs:=TLMDFormStyler.Create(cd);
        fs.Enabled:=False;

        b:=TLMDBack.Create(cd);
        b.Enabled:=False;

      end;
      if BaseExecute(cd, Main, Custom,  fs, b, IDS_CALCAPTION)=mrOK then
        begin
          result := true;
          FDate := cal.Date;
        end;
  finally
    //remove pointer to calendar
    FCal := nil;
    //free all
    cd.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCalendarDlg.Execute:Boolean;
begin
  result:=ExecuteEnh(nil)
end;

end.
 
