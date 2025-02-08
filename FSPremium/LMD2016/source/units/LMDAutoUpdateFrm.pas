unit LMDAutoUpdateFrm;
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

TLMDAutoUpdateForm unit (AIH)
--------------------
TLMDAutoUpdateForm - Visual Form to update process

Changes
-------
Release 1.0 (June 2008)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  ActnList, StdCtrls,
  LMDTypes, ComCtrls, Buttons, LMDCustomComponent, LMDWebBase, LMDWebConfig,
  SyncObjs, LMDUpdateInternetOptionsUnit, LMDUpdateMessage, ImgList;

type
  TLMDAutoUpdateForm = class(TForm)
    ActionList1: TActionList;
    actShowLog: TAction;
    actDone: TAction;
    mmStatus: TMemo;
    lbStatus: TLabel;
    btnDone: TSpeedButton;
    btnShowLog: TSpeedButton;
    pbStatus: TProgressBar;
    Label1: TLabel;
    btnInternetOptions: TSpeedButton;
    actInternetOptions: TAction;
    actStartUpdate: TAction;
    LMDWebConfig1: TLMDWebConfig;
    btnStartUpdate: TButton;
    Image1: TImage;
    procedure actShowLogExecute(Sender: TObject);
    procedure actDoneExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actInternetOptionsExecute(Sender: TObject);
    procedure actStartUpdateExecute(Sender: TObject);
  private
    { Private declarations }
    FCriticalSection: TCriticalSection;
  public
    procedure SetStatus(const AStatus: TLMDString);
    procedure ProgressiveBarVisiable(AVisiable: Boolean);
    procedure SetProgressiveBarMaxValue(AValue: Integer);
    procedure SetProgressiveBarValue(AValue: Integer);
    procedure ShowAdditionalButtons(AValue: Boolean);
    { Public declarations }
  end;

var
  LMDAutoUpdateForm: TLMDAutoUpdateForm;

implementation

uses LMDURLSupp;

{$R *.dfm}

procedure TLMDAutoUpdateForm.actShowLogExecute(Sender: TObject);
begin
//
end;

procedure TLMDAutoUpdateForm.actDoneExecute(Sender: TObject);
begin
  Close;
end;

procedure TLMDAutoUpdateForm.FormCreate(Sender: TObject);
begin
  btnShowLog.Hide;
  btnDone.Hide;
  btnInternetOptions.Hide;
  btnStartUpdate.Hide;
  FCriticalSection := nil;
end;

procedure TLMDAutoUpdateForm.SetStatus(const AStatus: TLMDString);
begin
  mmStatus.Text := AStatus;
  Application.ProcessMessages;
end;

procedure TLMDAutoUpdateForm.ProgressiveBarVisiable(AVisiable: Boolean);
begin
  pbStatus.Visible := AVisiable;
  Application.ProcessMessages;
end;

procedure TLMDAutoUpdateForm.SetProgressiveBarMaxValue(AValue: Integer);
begin
  pbStatus.Max := AValue;
  Application.ProcessMessages;
end;

procedure TLMDAutoUpdateForm.SetProgressiveBarValue(AValue: Integer);
begin
  pbStatus.Position := AValue;
  Application.ProcessMessages;
end;

procedure TLMDAutoUpdateForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TLMDAutoUpdateForm.ShowAdditionalButtons(AValue: Boolean);
begin
  btnInternetOptions.Visible := AValue;
  btnStartUpdate.Visible := AValue;
end;

procedure TLMDAutoUpdateForm.actInternetOptionsExecute(Sender: TObject);
var
  frmIO: TLMDUpdateInternetOptions; 
begin
  //
  Application.CreateForm(TLMDUpdateInternetOptions, frmIO);

  frmIO.LMDRAS1.GetEntries(frmIO.cbDUN.Items);
  frmIO.edURL.Text := LMDWebConfig1.URL;
  frmIO.cbUseModem.Checked := LMDWebConfig1.InternetOptions.ModemConnection;
  frmIO.cbUseProxy.Checked := LMDWebConfig1.InternetOptions.UseProxy;
  frmIO.cbProxyAuth.Checked := LMDWebConfig1.InternetOptions.UseProxyAuth;
  frmIO.cbDUN.ItemIndex := frmIO.cbDUN.Items.IndexOf(LMDWebConfig1.InternetOptions.DUN);
  frmIO.cbAutoClose.Checked := LMDWebConfig1.InternetOptions.AutoClose;
  frmIO.cbAutoDial.Checked := LMDWebConfig1.InternetOptions.AutoDial;
  frmIO.edRetries.Text := IntToStr(LMDWebConfig1.InternetOptions.ConnectRetries);
  frmIO.edHost.Text := LMDWebConfig1.InternetOptions.ProxyName;
  frmIO.edPort.Text := IntToStr(LMDWebConfig1.InternetOptions.ProxyPort);
  frmIO.edUser.Text := LMDWebConfig1.InternetOptions.ProxyUserName;
  frmIO.edPWD.Text := LMDWebConfig1.InternetOptions.ProxyPassword;
    frmIO.cbUseProxyClick(Self);
  frmIO.cbProxyAuthClick(Self);
  frmIO.cbUseModemClick(Self);
  if LMDWebConfig1.InternetOptions.SocksVersion = sv4 then
    frmIO.cmbProxyType.ItemIndex := 1
  else
  if LMDWebConfig1.InternetOptions.SocksVersion = sv5 then
    frmIO.cmbProxyType.ItemIndex := 2
  else
    frmIO.cmbProxyType.ItemIndex := 0;
  if frmIO.ShowModal = mrOK then
  begin
    LMDWebConfig1.URL := frmIO.edURL.Text;
    LMDWebConfig1.InternetOptions.ModemConnection := frmIO.cbUseModem.Checked;
    LMDWebConfig1.InternetOptions.UseProxy := frmIO.cbUseProxy.Checked;
    LMDWebConfig1.InternetOptions.UseProxyAuth := frmIO.cbProxyAuth.Checked;
    LMDWebConfig1.InternetOptions.DUN := frmIO.cbDUN.Items.Strings[frmIO.cbDUN.ItemIndex];
  LMDWebConfig1.InternetOptions.AutoClose := frmIO.cbAutoClose.Checked;
    LMDWebConfig1.InternetOptions.AutoDial := frmIO.cbAutoDial.Checked;
    LMDWebConfig1.InternetOptions.ConnectRetries := StrToInt(frmIO.edRetries.Text);
  LMDWebConfig1.InternetOptions.ProxyName := frmIO.edHost.Text;
    LMDWebConfig1.InternetOptions.ProxyPort := StrToInt(frmIO.edPort.Text);
  LMDWebConfig1.InternetOptions.ProxyUserName := frmIO.edUser.Text;
    LMDWebConfig1.InternetOptions.ProxyPassword := frmIO.edPWD.Text;
    LMDWebConfig1.InternetOptions.SocksProxy := frmIO.cmbProxyType.ItemIndex > 0;
    case frmIO.cmbProxyType.ItemIndex of
      1: LMDWebConfig1.InternetOptions.SocksVersion :=  sv4;
      2: LMDWebConfig1.InternetOptions.SocksVersion :=  sv5;
    end;
  end;
  frmIO.Free;
end;

procedure TLMDAutoUpdateForm.actStartUpdateExecute(Sender: TObject);
begin
//
end;

end.
