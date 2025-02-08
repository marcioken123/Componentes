unit LMDSedGotoLineDialog;
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

LMDSedGotoLineDialog unit (VT)
------------------------------
This unit contains implementation of the GotoLine dialog.

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ExtCtrls, LMDSedUtils;

type
  {*************************** TLMDSedGotoLineDlg *****************************}

  TLMDSedGotoLineDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btnOk: TButton;
    Panel6: TPanel;
    Button1: TButton;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    lblCaption: TLabel;
    edtLine: TMaskEdit;
    Panel8: TPanel;
    procedure FormCreate(Sender: TObject);
  end;

function LMDEditAskGoToLine(AMaxLine: Integer;
                            out ResultLine: Integer): Boolean;

implementation

uses
  Math, LMDUtils, LMDStrings, LMDTypes, LMDSedConst, LMDProcs;

{$R *.dfm}

{------------------------------------------------------------------------------}

function LMDEditAskGoToLine(AMaxLine: Integer;
                            out ResultLine: Integer): Boolean;
var
  res: Integer;
  txt: TLMDString;
begin
  with TLMDSedGotoLineDlg.Create(nil) do
  begin
    edtLine.EditMask := StringOfChar('0', Length(IntToStr(AMaxLine)));
    res := ShowModal;
    txt := LMDTrim(edtLine.Text);

    if (res=mrOK) and (Length(txt)>0) then
      ResultLine := LMDMinMax(StrToInt(txt), 1, AMaxLine)-1
    else
      ResultLine := -1;

    Result := res=mrOk;
    Free;
  end;
end;

{*************************** TLMDSedGotoLineDlg *******************************}
{------------------------------------------------------------------------------}

procedure TLMDSedGotoLineDlg.FormCreate(Sender: TObject);
begin
  LMDGetDialogFont(Font);

  SetFocusedControl(edtLine);
  Caption := SLMDSedDlgGotoLine;
end;

end.
