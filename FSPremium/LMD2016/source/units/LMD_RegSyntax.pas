unit LMD_RegSyntax;
{$I lmdcmps.inc}

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

_LMD_RegSyntax unit (VT)
------------------------
Registration unit for LMD Syntax Edit.

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

procedure Register;

implementation

uses
  DesignIntf, Classes, Controls, LMDSedDocument, LMDSedParser, LMDSedView,
  LMDSedDialogs, pLMDSedPE;

{ ---------------------------------------------------------------------------- }
procedure Register;
begin
  // Connect components with TWinControl, so that
  // it no longer appears on CLX palette.
  GroupDescendentsWith(TLMDEditDocument, TWinControl);
  GroupDescendentsWith(TLMDEditView, TWinControl);

  RegisterComponents('LMD Syntax Edit', [TLMDEditDocument,
                                         TLMDEditView,
                                         TLMDEditViewPrintTask]);

  RegisterComponents('LMD Syntax Edit - Dialogs',
                     [TLMDEditFindDialog, TLMDEditReplaceDialog,
                      TLMDEditKeybindingsDialog,
                      TLMDEditSyntaxSchemeDialog, TLMDEditColorSchemeDialog,
                      TLMDEditGotoLineDialog]);

  RegisterPropertyEditor(TypeInfo(TLMDSyntaxSchemeRef), TLMDEditDocument, '',
                         TLMDSyntaxSchemeProperty);

  RegisterPropertyEditor(TypeInfo(TLMDColorSchemeRef), TLMDEditDocument, '',
                         TLMDColorSchemeProperty);

  RegisterPropertyEditor(TypeInfo(TLMDEditParserSchemeStrings),
                         TLMDEditParserSchemeCollectionItem, '',
                         TLMDParserSchemeTextProperty);

  RegisterPropertyEditor(TypeInfo(TLMDEditCommandList),
                         TLMDEditView, '',
                         TLMDEditCommandListProperty);

  RegisterPropertyEditor(TypeInfo(TLMDCodePageRef),
                         TLMDEditDocument, '',
                         TLMDCodePageProperty);

  RegisterPropertyEditor(TypeInfo(TLMDSyntaxSchemeRef), TLMDEditSyntaxSchemeDialog, '',
                         TLMDSyntaxSchemeDlgProperty);

  RegisterPropertyEditor(TypeInfo(TLMDColorSchemeRef), TLMDEditColorSchemeDialog, '',
                         TLMDColorSchemeDlgProperty);

  RegisterComponentEditor(TLMDEditDocument, TLMDEditDocumentEditor);
end;

{ ---------------------------------------------------------------------------- }

end.


