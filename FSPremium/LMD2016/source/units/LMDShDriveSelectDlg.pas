unit LMDShDriveSelectDlg;
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

LMDShDriveSelectDlg unit (DS)
-----------------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses

  Classes, Controls, Forms, StdCtrls, 
  LMDShDriveListBox;

type
  TLMDShfrmSelectDriveDialog = class(TForm)
    lbdisk: TLMDShellDriveListBox;
    Instruction: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure lbdiskClick(Sender: TObject);
    procedure lbdiskDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  LMDShfrmSelectDriveDialog: TLMDShfrmSelectDriveDialog;

implementation

uses
  lmdshconsts;

{$R *.dfm}

procedure TLMDShfrmSelectDriveDialog.lbdiskClick(Sender: TObject);
begin
  btnOk.Enabled:=(lbdisk.ItemIndex <> -1);
end;

procedure TLMDShfrmSelectDriveDialog.lbdiskDblClick(Sender: TObject);
begin
  if btnOk.Enabled then ModalResult:=mrOK;
end;

procedure TLMDShfrmSelectDriveDialog.FormCreate(Sender: TObject);
begin
  btnOK.Caption:=IDSHELL_OK;
  btnCancel.Caption:=IDSHELL_CANCEL;
end;

end.
