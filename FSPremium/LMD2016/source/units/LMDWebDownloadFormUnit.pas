unit LMDWebDownloadFormUnit;
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

LMDWebDownloadFormUnit unit (DD)
--------------------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, LMDDownload, ImgList,LMDWebConst,
  LMDHTMLObjectUnit, LMDURLSupp, LMDStringsSupport, LMDFSSupport;

const
  WM_SEND_PROCESSED = WM_USER + 22;

type
  TLMDWebDownload = class(TForm)
    StopBtn: TButton;
    ProgressBar: TProgressBar;
    Label1: TLabel;
    DownloadLabel: TLabel;
    TransferLabel: TLabel;
    CPSLabel: TLabel;
    CloseBtn: TButton;
    Label2: TLabel;
    SizeLabel: TLabel;
    CopyAnimate: TAnimate;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StopBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
  private
    FOnProcessed: TNotifyEvent;
    FAutoClose: Boolean;
    FOldProgress: TLMDDownloadProgress;
    FOldProcessed: TLMDDownloadProcessed;
    { Private declarations }
    procedure DownloadProgress(Sender: TLMDDownloadItem);
    procedure DownloadProcessed(Sender: TLMDDownloads);
    procedure SetOnProcessed(const Value: TNotifyEvent);
    procedure SendProcessed(var Message: TMessage); message WM_SEND_PROCESSED;
    procedure SetAutoClose(const Value: Boolean);
  public
    { Public declarations }
    FormResult: TModalResult;
    ProgressStart: Integer;
    ProgressLen: Integer;
    DL: TLMDDownloads;
    procedure UpdateBtn;
    procedure Start;
    procedure Stop;
    procedure SetHandlers;

    property OnProcessed: TNotifyEvent read FOnProcessed write SetOnProcessed;
  published
    property AutoClose: Boolean read FAutoClose write SetAutoClose default True;
  end;

implementation
{$R LMDWeb.res}
{$R *.DFM}

procedure TLMDWebDownload.FormCreate(Sender: TObject);
begin
  DL:= nil;
  CopyAnimate.ResName:='LMDCOPYFILE';
  ProgressLen:= 100;
  ProgressStart:= 0;
  FOnProcessed:= nil;
  FormResult:= mrOk;
  FAutoClose:= True;
  Label1.Caption := DF_DOWNLOAD;
  TransferLabel.Caption := DF_TRANSFER;
  Label2.Caption := DF_TOTAL;
  CloseBtn.Caption := DF_CLOSE;
  StopBtn.Caption := DF_CANCEL;
  CopyAnimate.BringToFront;
end;

procedure TLMDWebDownload.FormShow(Sender: TObject);
begin
  Start;
end;

procedure TLMDWebDownload.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CopyAnimate.Active:= False;
  DL.OnProgress:= FOldProgress;
  DL.OnProcessed:= FOldProcessed;
  ModalResult := FormResult; 
end;

procedure TLMDWebDownload.Start;
begin
  FormResult:= mrOk;
  CopyAnimate.Active:= True;
  StopBtn.Enabled:= True;
  DL.ServerThreads:= 1;
  DL.ThreadProcess;
  UpdateBtn;
end;

procedure TLMDWebDownload.Stop;
begin
  DL.Terminate;
end;

procedure TLMDWebDownload.UpdateBtn;
begin
  CloseBtn.Enabled:= DL.State in [DS_PROCESSED, DS_ERROR];
  StopBtn.Enabled:= not CloseBtn.Enabled;
end;

procedure TLMDWebDownload.DownloadProcessed(Sender: TLMDDownloads);
begin
  UpdateBtn;
  ProgressStart:= ProgressStart + ProgressLen;
  ProgressBar.Position:= ProgressStart;
  CopyAnimate.Active:= False;
  ProgressBar.Position:= 100;

  if Assigned(FOnProcessed) and (FormResult = mrOk) then
    PostMessage(Handle, WM_SEND_PROCESSED, 0, 0)
  else
    begin
      if AutoClose then
        Close;
    end;
  if Assigned(FOldProcessed) then
    FOldProcessed(Sender);
end;

procedure TLMDWebDownload.DownloadProgress(Sender: TLMDDownloadItem);
var
  iMax: Integer;
  iCur: Integer;
  i: Integer;
begin
  if Assigned(FOldProgress) then
    FOldProgress(Sender);
  iMax:= 100 * DL.Count;
  iCur:= 0;
  for i:= 0 to DL.Count - 1 do
    begin
      case DL[i].State of
        DS_PROCESSING, DS_PROCESSED:
          begin
            Inc(iCur, DL[i].Progress);
          end;
        DS_ERROR:
          begin
            Inc(iCur, 100);
          end;
      end;
    end;

  DownloadLabel.Caption:= ExtractURLFileName(Sender.URL) + ' '+DF_FROM+' ' +
    GetHost(Sender.URL);
  CPSLabel.Caption:= FormatFloat('0.00', DL.CPS / 1024) + ' '+DF_KBS;
  SizeLabel.Caption:= FormatFloat('0.00', DL.AllSize / 1024) + ' '+DF_KB;
  ProgressBar.Position:= ProgressStart + Round(ProgressLen * iCur / iMax);

end;

procedure TLMDWebDownload.CloseBtnClick(Sender: TObject);
begin
  Close;
  ModalResult:= FormResult;
end;

procedure TLMDWebDownload.StopBtnClick(Sender: TObject);
begin
  FormResult:= mrCancel;
  StopBtn.Enabled:= False;
  Stop;
end;

procedure TLMDWebDownload.SetOnProcessed(const Value: TNotifyEvent);
begin
  FOnProcessed:= Value;
end;

procedure TLMDWebDownload.SendProcessed(var Message: TMessage);
begin
  if Assigned(FOnProcessed) then
    begin
      DL.WaitForEnd;
      FOnProcessed(Self);
    end;
end;

procedure TLMDWebDownload.SetAutoClose(const Value: Boolean);
begin
  FAutoClose:= Value;
end;

procedure TLMDWebDownload.SetHandlers;
begin
  FOldProgress:= DL.OnProgress;
  FOldProcessed:= DL.OnProcessed;
  DL.OnProgress:= DownloadProgress;
  DL.OnProcessed:= DownloadProcessed;
end;

end.
