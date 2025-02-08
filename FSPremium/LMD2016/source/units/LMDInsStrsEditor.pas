unit LMDInsStrsEditor;
{$I LmdCmps.inc}

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

LMDInsStrsEditor unit (YB)
------------------------
TLMDStringsEditorDialog unit

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Variants,
  LMDInsCst;

type
  { *********************** TLMDStringsEditorDialog ************************** }

  TLMDStringsEditorDialog = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    lbLineCount: TLabel;
    bvlMain: TBevel;
    memMain: TMemo;
    procedure memMainChange(Sender: TObject);
  private
    function  GetLines: TStrings;
    procedure SetLines(const Value: TStrings);
  public
    function Execute: Boolean;
    property Lines: TStrings read GetLines write SetLines;
  end;

implementation

{$R *.dfm}

{ ********************* class TLMDStringsEditorDialog ************************ }
{ ----------------------------- published ------------------------------------ }
{$WARNINGS OFF}
procedure TLMDStringsEditorDialog.memMainChange(Sender: TObject);
begin
  lbLineCount.Caption := Format(SLMDStrErDlgLinesCountTemplate,
    [memMain.Lines.Count]);
end;

{ ------------------------------ private ------------------------------------- }
function TLMDStringsEditorDialog.GetLines: TStrings;
begin
  Result := memMain.Lines;
end;

procedure TLMDStringsEditorDialog.SetLines(const Value: TStrings);
begin
  memMain.Lines := Value;
end;

{ ------------------------------ public -------------------------------------- }
function TLMDStringsEditorDialog.Execute: Boolean;
begin
  Caption             := SLMDStrErDlgCaption;
  btnOk.Caption       := SLMDStrErDlgOkBtnCaption;
  btnCancel.Caption   := SLMDStrErDlgCancelBtnCaption;
  lbLineCount.Caption := Format(SLMDStrErDlgLinesCountTemplate,
                                [memMain.Lines.Count]);

  Result := (ShowModal = mrOk);
end;
{$WARNINGS ON}

{ ---------------------------------------------------------------------------- }

end.
