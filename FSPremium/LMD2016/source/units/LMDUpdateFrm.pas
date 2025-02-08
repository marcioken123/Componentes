unit LMDUpdateFrm;

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

LMDUpdateFrm unit (AIH)
--------------------
TLMDUpdateForm - Visual Form to provide adapter action

Changes
-------
Release 1.0 (June 2008)
 - Initial Release

###############################################################################}

interface
uses
  LMDCustomComponent, LMDAutoUpdateFrm, Classes, Forms, LMDTypes, SyncObjs,
  Controls, LMDWebConfig, LMDUpdateMessage, LMDWebBase;

type
  {************************* TLMDCustomUpdateForm *****************************}
  TLMDCustomUpdateForm = class(TLMDWebComponent)
  private
    FFormInstance: TLMDAutoUpdateForm;
    function GetWebConfig(): TLMDWebConfig;
  public
    function ShowForm(AModal: Boolean = False): TModalResult;
    procedure OnMessageReceive(Sender: TObject; AMessage: TLMDUpdateMessage);
    procedure HideForm();
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure SetStatus(const AStatus: TLMDString);
    procedure ProgressiveBarVisiable(AVisiable: Boolean);
    procedure SetProgressiveBarMaxValue(AValue: Integer);
    procedure SetProgressiveBarValue(AValue: Integer);
    procedure BtnLogVisiable(AValue: Boolean);
    procedure BtnDoneVisiable(AValue: Boolean);
    procedure ShowAdditionalButtons(AValue: Boolean);
    function GetInstance(): TLMDAutoUpdateForm;
    property WebConfig: TLMDWebConfig read GetWebConfig;
  end;

  {************************* TLMDCustomUpdateForm *****************************}
  TLMDUpdateForm = class (TLMDCustomUpdateForm)
  end;
 implementation

uses SysUtils, Dialogs;

{************************* TLMDCustomUpdateForm *******************************}
{------------------------------ private ---------------------------------------}

function TLMDCustomUpdateForm.GetInstance(): TLMDAutoUpdateForm;
begin 
  if not Assigned(FFormInstance) then
    Application.CreateForm(TLMDAutoUpdateForm, FFormInstance);
    Result := FFormInstance
end;

{---------------------------------- public ------------------------------------}
function TLMDCustomUpdateForm.ShowForm(AModal: Boolean = False): TModalResult;
begin
  Result := mrCancel;
  if AModal then
    Result := GetInstance().ShowModal
  else
    GetInstance().Show;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomUpdateForm.HideForm();
begin
  GetInstance().Hide;
end;

{------------------------------------------------------------------------------}
constructor TLMDCustomUpdateForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFormInstance := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomUpdateForm.Destroy();
begin
  if Assigned(FFormInstance) then
    FFormInstance := nil;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomUpdateForm.SetStatus(const AStatus: TLMDString);
begin
  GetInstance().SetStatus(AStatus);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomUpdateForm.ProgressiveBarVisiable(AVisiable: Boolean);
begin
  GetInstance().ProgressiveBarVisiable(AVisiable);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomUpdateForm.SetProgressiveBarMaxValue(AValue: Integer);
begin
  GetInstance().SetProgressiveBarMaxValue(AValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomUpdateForm.SetProgressiveBarValue(AValue: Integer);
begin
  GetInstance().SetProgressiveBarValue(AValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomUpdateForm.BtnLogVisiable(AValue: Boolean);
begin
  GetInstance().btnShowLog.Visible := AValue;  
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomUpdateForm.BtnDoneVisiable(AValue: Boolean);
begin
  GetInstance().btnDone.Visible := AValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomUpdateForm.ShowAdditionalButtons(AValue: Boolean);
begin
  GetInstance().ShowAdditionalButtons(AValue);
end;

{------------------------------------------------------------------------------}
function TLMDCustomUpdateForm.GetWebConfig(): TLMDWebConfig;
begin
  Result := FFormInstance.LMDWebConfig1;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomUpdateForm.OnMessageReceive(Sender: TObject; AMessage: TLMDUpdateMessage);
begin
  if AMessage.MsgType = umtConfirm then
    AMessage.Result := MessageDlg(Amessage.Descr, mtConfirmation, [mbRetry, mbIgnore, mbAbort], 0);
end;
//
end.
