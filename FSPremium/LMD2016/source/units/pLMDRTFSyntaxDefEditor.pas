unit pLMDRTFSyntaxDefEditor;
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

pLMDRTFSyntaxDefEditor unit (RM)
--------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Messages, Classes, Controls, StdCtrls, ActnList, ImgList,
  ComCtrls, ToolWin,
  LMDRTFActions, LMDRTFRichEdit, LMDRTFSyntaxEdit, ExtCtrls;

type
  TfrmSyntaxDefEditor = class(TForm)
    ImageList1: TImageList;
    alToolbar1: TActionList;
    Toolbar1: TToolBar;
    btnLoad1: TToolButton;
    actLoad1: TLMDRichEditLoad;
    btnSave1: TToolButton;
    Separator1: TToolButton;
    btnFind1: TToolButton;
    actFind1: TLMDRichEditFind;
    Separator3: TToolButton;
    btnCut1: TToolButton;
    actCut1: TLMDRichEditCut;
    btnCopy1: TToolButton;
    actCopy1: TLMDRichEditCopy;
    btnPaste1: TToolButton;
    actPaste1: TLMDRichEditPaste;
    Separator4: TToolButton;
    btnUndo1: TToolButton;
    actUndo1: TLMDRichEditUndo;
    btnRedo1: TToolButton;
    actRedo1: TLMDRichEditRedo;
    Separator5: TToolButton;
    btnIndent1: TToolButton;
    actIndent1: TLMDRichEditIndent;
    btnUnindent1: TToolButton;
    actUnindent1: TLMDRichEditUnindent;
    LMDRichEditSaveAs1: TLMDRichEditSaveAs;
    LMDSyntaxEdit1: TLMDRichSyntaxEdit;
    Panel1: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
    procedure WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

{ -------------------------------------------------------------------------- }
procedure TfrmSyntaxDefEditor.WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo);
begin
  inherited;

  with Msg.MinMaxInfo.ptMinTrackSize do
  begin
    x := self.Constraints.MinWidth;
    y := self.Constraints.MinHeight;
  end;
end;

end.
