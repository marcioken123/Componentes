unit LMD_RegRtlX;
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

LMD-Tools Shared Controls registration unit (RM)
------------------------------------------------
Registers components and editors for shared controls which can be used by
LMD-Tools, ElPack and Standalone packs which integrate extended Runtime package.

Changes
-------
Release 8.0 (December 2006)
 - Initial Release

###############################################################################}

interface

procedure Register;

{------------------------------------------------------------------------------}
implementation
uses
  Classes, Windows, SysUtils, Controls, ActnList, Forms,

  ExtCtrls,

  DesignIntf, DesignEditors, VCLEditors, DesignMenus,
  {base unit for all versions}
  LMDClass, LMDGraph, LMDCustomComponent,
  // LMD Dlg
  LMDVistaDialogs, LMDExtDialogs, LMDTaskDlg, LMDBrowseDlg, LMDUnicodeDialogs,
  // Container
  LMDCont, LMDWave, LMDImageList, LMDImageListConnector, LMDGenericList,
  LMDBitmapList, LMDGraphicList, LMDPngImageList, LMDStringList, LMDWaveList,
  // LMD Sys
  LMDApplicationCtrl, LMDFMDrop, LMDHookComponent, LMDIniCtrl, LMDCabSupport,
  LMDNativeHint,
  // LMD Form
  LMDFormVista, LMDForms, LMDFormPersistent,
  // Actions
  LMDBaseMRUList, LMDActnList, LMDStdActns,
  // Validators
  LMDVldBase, LMDErrorProvidersGroup, LMDErrorProvider, LMDInPlaceErrorProvider,
  LMDIconErrorProvider, LMDControlErrorProvider,
  LMDMessageBoxErrorProvider, LMDRequiredFieldValidator, LMDRegExpValidator,
  LMDRangeValidator, LMDIntRangeValidator, LMDFloatRangeValidator, LMDDateTimeRangeValidator,
  LMDStringRangeValidator, LMDCompareValidator,

  // Component Editors
  pLMDCommon, pLMDCEBase, pLMDCEX, pLMDPeX, pLMDTaskDialogEditor, pLMDActnList;

{------------------------------------------------------------------------------}
procedure Register;
begin
  // 9.0
  // --> Frames... , DataModules
  // disabled for first releases
  //RegisterComponentEditor( TForm, TLMDFormEditor );
  //RegisterComponentEditor(TPanel, TLMDTestComponentEditor);

  // register only when DesignEditors and Actions should be installed
  if leoInstallDesignEditorControls in LMDTOOLSEDITOROPTIONS then
    begin
      RegisterComponents('LMD EditorCtrls', [TLMDBaseMRUList]);
    end;

  {Vista dialog controls}
  {****************************************************************************}
  RegisterComponents('LMD Dlg Sys', [
                      TLMDTaskDialog,
                      TLMDBrowseDlg,
                      TLMDFileOpenDialog,
                      TLMDFileSaveDialog,
                      TLMDOpenWaveDialog,
                      TLMDSaveWaveDialog,
                      TLMDOpenDialog,
                      TLMDSaveDialog,
                      TLMDOpenPictureDialog,
                      TLMDSavePictureDialog
                     ]);

  {TLMDBaseOpenDialog}
  RegisterComponentEditor(TLMDBaseOpenDialog, TLMDDlgEditor);
  {TLMDCustomFileDialog}
  RegisterComponentEditor(TLMDCustomFileDialog, TLMDDlgEditor);
  {TLMDBrowseDlg}
  RegisterComponentEditor(TLMDBrowseDlg, TLMDDlgEditor);
  {TLMDTaskDialog}
  RegisterComponentEditor(TLMDTaskDialog, TLMDTaskDialogEditor);

  {Container controls}
  {****************************************************************************}
  RegisterComponents('LMD Cont', [
                      TLMDContainerCtrl,
                      TLMDBitmapList,
                      TLMDImageList,
                      TLMDImageListConnector,
                      TLMDGenericList,
                      TLMDGraphicList,
                      TLMDPNGImageList,
                      TLMDStringList,
                      TLMDWaveList
                     ]);

  {TLMDGraphicList}
  RegisterComponentEditor(TLMDGraphicList, TLMDGraphicListEditor);
  {TLMDPNGImageList}
  RegisterComponentEditor(TLMDPNGImageList, TLMDPNGImageListEditor);
  {TLMDBitmapList}
  RegisterComponentEditor(TLMDBitmapList, TLMDBitmapListEditor);
  {TLMDContainer}
  RegisterComponentEditor(TLMDContainerCtrl, TLMDContainerComponentEditor);
  {TLMDImageList}
  RegisterComponentEditor(TLMDImageList, TLMDImageListEditor);
  {TLMDGenericList}
  RegisterComponentEditor(TLMDGenericList, TLMDGenericListEditor);
  {TLMDStringList}
  RegisterComponentEditor(TLMDStringList, TLMDStringListEditor);
  {TLMDWaveList}
  RegisterComponentEditor(TLMDWaveList, TLMDWaveListEditor);
  //TLMDWave
  RegisterPropertyEditor( TypeInfo( TLMDWave ), nil, '', TLMDWaveProperty);

  {System controls}
  {****************************************************************************}
  RegisterComponents('LMD Sys', [
                      TLMDApplicationCtrl,
                      TLMDIniCtrl,
                      TLMDFMDrop,
                      TLMDHookComponent,
                      TLMDCabCompress,
                      TLMDCabDeCompress,
                      TLMDNativeHint
                    ]);

  //Property HelpFile, TLMDApp
  RegisterPropertyEditor( TypeInfo( String ), TLMDApplicationCtrl, 'HelpFile', TLMDHelpfileNameProperty );

  {Form controls}
  {****************************************************************************}
  RegisterComponents('LMD Form', [
                      TLMDFormVistaExtension,
                      TLMDFormGlass,
                      TLMDFormPersistent
                     ]);

  {Validator Controls}
  {****************************************************************************}
  RegisterComponents('LMD Validators', [
                      TLMDErrorProvidersGroup,
                      TLMDErrorProvider,
                      TLMDInPlaceErrorProvider,
                      TLMDIconErrorProvider,
                      TLMDControlErrorProvider,
                      TLMDMessageBoxErrorProvider,
                      TLMDValidationGroup,
                      TLMDRequiredFieldValidator,
                      TLMDCompareValidator,
                      TLMDRegExpValidator,
                      TLMDRangeValidator,
                      TLMDIntRangeValidator,
                      TLMDFloatRangeValidator,
                      TLMDStringRangeValidator,
                      TLMDDateTimeRangeValidator
                     ]);

  {ActionList unicode}
  {****************************************************************************}
  RegisterComponents('LMD Std', [
                      TLMDActionList
                     ]);

  RegisterComponentEditor(TLMDActionList, TLMDActionListEditor);
end;

end.
