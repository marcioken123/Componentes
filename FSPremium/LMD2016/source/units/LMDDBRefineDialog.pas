unit LMDDBRefineDialog;
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

LMDDBRefineDialog unit (DD)
--------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, LMDSearchConsts;

type
  TLMDDBSearchFindForm = class(TForm)
    FindWhatLabel: TLabel;
    FindEdit: TEdit;
    FindNextButton: TButton;
    CloseButton: TButton;
    BuildButton: TButton;
    DirectionGroupBox: TGroupBox;
    UpRadioButton: TRadioButton;
    DownRadioButton: TRadioButton;
    CriteriaGroupBox: TGroupBox;
    MathWholeCheckBox: TCheckBox;
    MathCaseCheckBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

{------------------------------------------------------------------------------}
procedure TLMDDBSearchFindForm.FormCreate(Sender: TObject);
begin
  Caption := LMDSP_DBRefineDialogFormCaption;
  FindWhatLabel.Caption := LMDSP_DBRefineDialogFindWhatLabelCaption;
  MathWholeCheckBox.Caption := LMDSP_MathWholeCheckBoxCaption;
  MathCaseCheckBox.Caption := LMDSP_MatchCaseCheckBoxCaption;
  CriteriaGroupBox.Caption:=LMDSP_CriteriaCaption;
  DirectionGroupBox.Caption := LMDSP_DBRefineDialogDirectionGroupBoxCaption;
  UpRadioButton.Caption := LMDSP_DBRefineDialogUpRadioButtonCaption;
  DownRadioButton.Caption := LMDSP_DBRefineDialogDownRadioButtonCaption;
  BuildButton.Caption := LMDSP_DBRefineDialogBuildButtonCaption;
  FindNextButton.Caption := LMDSP_DBRefineDialogFindNextButtonCaption;
  CloseButton.Caption := LMDSP_DBRefineDialogCloseButtonCaption;
end;

end.
