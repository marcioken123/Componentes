unit LMDRASCF;
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

LMDRASCF unit (DD)
------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDRAS, StdCtrls, ExtCtrls, LMDWebConst;

type
  TLMDRASConnectionForm = class(TForm)
    StatusLabel: TLabel;
    RASImage: TImage;
    CancelBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CDialUpAsyncEvent(Sender: TObject; State, Error: Integer;
      MessageText: string);
  private
    { Private declarations }
  public
    { Public declarations }
    DU: TLMDRAS;
    szConnection: String;
  end;

var
  LMDRASConnectionForm: TLMDRASConnectionForm;

implementation

{$R *.DFM}

procedure TLMDRASConnectionForm.FormCreate(Sender: TObject);
begin
  DU:= TLMDRAS.Create(Self);
  DU.OnAsyncEvent:= CDialUpAsyncEvent;
end;

procedure TLMDRASConnectionForm.CancelBtnClick(Sender: TObject);
begin
  DU.HangUp;
  Close;
end;

procedure TLMDRASConnectionForm.FormShow(Sender: TObject);
begin
  Caption := RS_CONNECTING + ' ' + szConnection + '...';
  DU.Dial(szConnection);
end;

procedure TLMDRASConnectionForm.CDialUpAsyncEvent(Sender: TObject; State,
  Error: Integer; MessageText: string);
begin
  StatusLabel.Caption:= MessageText;
  case State of
    RASCS_Connected:
      Close;

    RASCS_Disconnected:
      CancelBtn.Caption:= RS_CLOSE;
  end;
end;

end.
