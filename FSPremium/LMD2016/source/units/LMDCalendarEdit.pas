unit LMDCalendarEdit;
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

LMDCalendarEdit unit (JH)
-------------------------

Date edit control based on TLMDMaskEdit Has "built in" calendar dialog for 
quick date selection

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDCalendarDlg,
  LMDCustomMaskEdit;

type
  { ----------------------- TLMDCalendarEdit --------------------------------- }
  TLMDCalendarEdit = class(TLMDCustomMaskEdit)
  private
    FCloseDlgOnDblClick,
    FAddActualDateButton : Boolean;
    FOnDlgChange,
    FOnShow,
    FOnClose:TNotifyEvent;
    FForceTodayAsDefault: boolean;
    FCalendarDlg: TLMDCalendarDlg;
    FStartDay: byte;

    procedure SetDate (aValue : TDateTime);
    function GetDate : TDateTime;
    procedure SetForceTodayAsDefault (aValue : boolean);
    procedure SetStartDay(const Value: byte);
  protected
    procedure DoOnBrowseClick (Sender : TObject; index: Integer);
    public
    constructor Create (aOwner : TComponent); override;
    procedure Loaded; override;
  public
    function CalendarDlg: TLMDCalendarDlg;
  published
    property CustomButtons;
    property CustomButtonsStyle;
    property CustomButtonWidth;
    property CustomButtonParentCtlXP;
    property AddActualDateButton : Boolean read FAddActualDateButton write FAddActualDateButton default false;
    property CloseDlgOnDblClick : Boolean read FCloseDlgOnDblClick write FCloseDlgOnDblClick default false;
    property Date : TDateTime read GetDate write SetDate;
    property DateSettings;
    property ReadOnly;
    property StartDay: byte read FStartDay write SetStartDay;
    // 7.0
    property OnDlgChange:TNotifyEvent read FOnDlgChange write FOnDlgChange;
    property OnDlgClose:TNotifyEvent read FOnClose write FOnClose;
    property OnDlgShow:TNotifyEvent read FOnShow write FOnShow;
    ///
    property ForceTodayAsDefault: boolean read FForceTodayAsDefault write SetForceTodayAsDefault default false;
  end;

  TLMDLabeledCalendarEdit = class(TLMDCalendarEdit)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  Forms, SysUtils,
  LMDClass, LMDButtonBase, LMDBase;

{ ---------------------------------- protected ------------------------------- }
procedure TLMDCalendarEdit.SetDate (aValue : TDateTime);
begin
  Text := DateSettings.GetDTEditString (aValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCalendarEdit.GetDate : TDateTime;
begin
  MaskType := meDate;
  result := AsDate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarEdit.SetForceTodayAsDefault (aValue : boolean);
begin
  FForceTodayAsDefault := aValue;
  if FForceTodayAsDefault then
    Date := Now;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarEdit.SetStartDay(const Value: byte);
begin
  if Value in [1..7] then
    FStartDay := Value;
end;

{ ---------------------------------- protected ------------------------------- }
procedure TLMDCalendarEdit.DoOnBrowseClick (Sender : TObject; index: Integer);
begin
  if not Focused then SetFocus; //added May 02, JH
  FCalendarDlg := TLMDCalendarDlg.Create (Application);
  try
    //JH Feb 2002
    //convert "our" date to TDateTime value, and back to a date string for
    //the dialog
    FCalendarDlg.StartDay := FStartDay;
    FCalendarDlg.ThemeMode := self.ThemeMode;
    FCalendarDlg.Date := DateToStr (DateSettings.StrToDate(Text));
    FCalendarDlg.ActualDateButton := FAddActualDateButton;
    FCalendarDlg.CloseOnDblClick := FCloseDlgOnDblClick;
    if Assigned(FOnShow) then FOnShow(FCalendarDlg);
    if FCalendarDlg.Execute then
      try
        //JH Feb 2002
        //convert date string from cal dialog to datetime and back to a string
        //matching "our" date settings
        Text := DateSettings.GetDTEditString(StrToDate(FCalendarDlg.Date));
        if Assigned(FOnDlgChange) then FOnDlgChange(self);
      except
        On Exception do ;
      end;
    if Assigned(FOnClose) then FOnClose(FCalendarDlg);
  finally
    FCalendarDlg.Free;
    FCalendarDlg := nil;
  end;
end;

{ ---------------------------------- public ---------------------------------- }
function TLMDCalendarEdit.CalendarDlg: TLMDCalendarDlg;
begin
  result := FCalendarDlg;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDCalendarEdit.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FCalendarDlg := nil;
  FForceTodayAsDefault := false;
  MaskType := meDate; //VB Aug 2007
  CustomButtons.Add;
  CustomButtons.Items[0].ThemeMode := ttmNone;
  CustomButtons.Items[0].OnClick := DoOnBrowseClick;
  CustomButtonWidth := 18;
  LMDGetGlyphKind(CustomButtons.Items[0].Glyph, gkCalender);

  FAddActualDateButton := false;
  FCloseDlgOnDblClick := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarEdit.Loaded;
begin
  inherited Loaded;
  if ForceTodayAsDefault then  //VB Nov 2008
    Date := Now;
  MaskType := meDate;
  CustomButtons.Items[0].OnClick := DoOnBrowseClick;  
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledCalendarEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
