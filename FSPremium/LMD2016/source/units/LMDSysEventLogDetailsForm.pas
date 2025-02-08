unit LMDSysEventLogDetailsForm;
{$I LMDCmps.inc}

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

LMDSysEventLogDetailsForm unit (RM)
-----------------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, LMDSysEventLog, ComCtrls;

type
  TfrmLMDSysLogDetails = class(TForm)
    TabControl1: TTabControl;
    lblDate: TLabel;
    lblTime: TLabel;
    lblType: TLabel;
    lblSource: TLabel;
    lblCategory: TLabel;
    lblEventID: TLabel;
    lblUser: TLabel;
    lblComputer: TLabel;
    edShowDescription: TMemo;
    lblDescription: TLabel;
    btnOK: TButton;
    lblDisplayDate: TLabel;
    lblDisplaySource: TLabel;
    lblDisplayTime: TLabel;
    lblDisplayType: TLabel;
    lblDisplayUser: TLabel;
    lblDisplayCategory: TLabel;
    lblDisplayEventID: TLabel;
    lblDisplayComputer: TLabel;
    lblShowPosition: TLabel;
    btnDown: TBitBtn;
    btnUp: TBitBtn;
    btnCopy: TBitBtn;
    btnFirst: TBitBtn;
    btnLast: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
  private
    FOnChange:TLMDSysEventDlgChange;
    FOnBtnClick:TNotifyEvent;
  public
    FPosition, FCount:Integer;
    FOwner:TLMDSysEventLog;
    procedure DisplayEvent(tmp:PLMDSysEventInfo);
    property OnChange:TLMDSysEventDlgChange read FOnChange write FOnChange;
    property OnBtnClick:TNotifyEvent read FOnBtnClick write FOnBtnClick;
  end;

implementation
uses
  Clipbrd,
  LMDSysConst
  ;

{$R *.DFM}

{----------------------------- public -----------------------------------------}

procedure TfrmLMDSysLogDetails.DisplayEvent(tmp:PLMDSysEventInfo);

begin
   with tmp^ do
   begin
     lblDisplayDate.Caption := DateToStr(DateTime);
     lblDisplaySource.Caption := Source;
     lblDisplayTime.Caption := TimeToStr(DateTime);
     lblDisplayType.Caption := LMDSysEventTypeString[EventType];
     lblDisplayUser.Caption := UserNameLong;
     lblDisplayCategory.Caption := Category;
     lblDisplayEventID.Caption := inttostr(EventID and $FFFF);
     lblDisplayComputer.Caption := ComputerName;
     edShowDescription.Text := MessageText;
   end;

   if lblShowPosition.Visible then
     lblShowPosition.Caption:='('+inttostr(FPosition+1)+'/'+inttostr(FCount)+')';

   if btnDown.Visible then
     begin
       btnDown.Enabled:=FPosition<FCount-1;
       btnUp.Enabled:=FPosition>0;
       btnFirst.Enabled:=btnUp.Enabled;
       btnLast.Enabled:=btnDown.Enabled;
     end;

   if Assigned(FOnCHange) then
     FOnChange(self, FPosition);
end;

procedure TfrmLMDSysLogDetails.FormCreate(Sender: TObject);
begin

  // Resource Strings
  lblDate.Caption:=sLMDSysEventDate+':';
  lblTime.Caption:=sLMDSysEventTime+':';
  lblType.Caption:=sLMDSysEventType+':';
  lblSource.Caption:=sLMDSysEventSource+':';
  lblUser.Caption:=sLMDSysEventUser+':';
  lblCategory.Caption:=sLMDSysEventCategory+':';
  lblEventID.Caption:=sLMDSysEventDlgEventIDLabel;
  lblComputer.Caption:=sLMDSysEventComputer+':';
  lblDescription.Caption:=sLMDSysEventDlgDescriptionLabel;
  TabControl1.Tabs[0]:=sLMDSysEventEvent;
  Caption:=sLMDSysEventDlgCaption;
end;

procedure TfrmLMDSysLogDetails.btnClick(Sender: TObject);
var
  tmp:TLMDSysEventInfo;
begin
  if Sender=btnUp then Dec(FPosition)
  else if Sender=btnFirst then FPosition:=0
  else if Sender=btnLast then FPosition:=FCount-1
  else if Sender=btnDown then Inc(FPosition);

  FOwner.Read(FPosition, @tmp, true);
  DisplayEvent(@tmp);
  TComponent(Sender).Tag := tmp.RecordNumber;
  if Assigned(FOnBtnClick) then FOnBtnClick(Sender);
end;

procedure TfrmLMDSysLogDetails.btnCopyClick(Sender: TObject);
var
  sl:TStringList;
begin
  ClipBoard.Open;
  with ClipBoard do
    try
      sl:=TStringList.Create;
      try
        sl.Add(lblDate.Caption+Chr(32)+lblDisplayDate.Caption);
        sl.Add(lblTime.Caption+Chr(32)+lblDisplayTime.Caption);
        sl.Add(lblType.Caption+Chr(32)+lblDisplayType.Caption);
        sl.Add(lblSource.Caption+Chr(32)+lblDisplaySource.Caption);
        sl.Add(lblUser.Caption+Chr(32)+lblDisplayUser.Caption);
        sl.Add(lblCategory.Caption+Chr(32)+lblDisplayCategory.Caption);
        sl.Add(lblEventID.Caption+Chr(32)+lblDisplayEventID.Caption);
        sl.Add(lblComputer.Caption+Chr(32)+lblDisplayComputer.Caption);
        sl.Add(lblDescription.Caption+Chr(13)+Chr(10)+edShowDescription.Text);
        SetTextBuf(PChar(sl.Text));
        finally
        sl.Free;
      end;
    finally
      Close;
    end;
end;

end.
