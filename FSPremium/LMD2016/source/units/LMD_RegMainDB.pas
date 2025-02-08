unit LMD_RegMainDB;
{$I LMDCMPS.INC}

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

LMD-Tools DB registration unit (RM)
-----------------------------------
Registers components and editors for the LMD-Tools Database controls.

Changes
-------
Release 8.0 (August 2006)
 - Initial Release

###############################################################################}

interface

procedure Register;

implementation
uses Classes,
     DesignIntf,
     // DB Standard
     LMDDBGraphicLabel, LMDDBLEDLabel, LMDDBProgressFill, LMDDBShapeControl,
     LMDDBRestoreGrid, LMDDBProgress, LMDDBSimpleLabel, LMDDBLabel, LMDDBHTMLLabel, LMDDBInformationLabel,
     LMDDBGlyphInfoLabel, LMDDBLabelFill, LMDDBNImage, LMDDBSpeedButton, LMDBookmarkCont,
     LMDDBExport, LMDDBSwitch, LMDDBLight, LMDCSV2DBImport, LMDDBBtn,
     // DB Edit
     LMDDBCheckBox, LMDDBRadioGroup, LMDDBCheckGroup, LMDDBTrackBar, LMDDBCal,
     LMDDBMaskEdit, LMDDBSpinEdit, LMDDBExtSpinEdit, LMDDBEdit, LMDDBMemo,
     LMDDBEditDBLookup, LMDEditDBLookup,
     // DB List
     LMDDBColorComboBox, LMDDBImageComboBox, LMDDBImageListBox, LMDDBListComboBox,
     LMDDBTreeComboBox, LMDDBCalendarComboBox, LMDDBCalculatorComboBox, LMDDBFieldComboBox,
     LMDDBLookupCtrls,

     pLMDCommon, pLMDPeCore, pLMDCECore, {pLMDPEDB,} pLMDOIEnh, pLMDExDsgnOIEnh,
     DBReg,
     DB,        // TypeInfo(TFieldAttributes)
     DBCtrls,   // TypeInfo(TButtonSet)
     DBGrids   // TypeInfo(TColumnValues)
     {$IFNDEF LMDCOMP21}, {$IFDEF LMDCOMP16}Bde.DBTables{$ELSE}DBTables{$ENDIF} {$ENDIF};  // TypeInfo(TConfigMode)

type TLMDDataFieldAggProperty = class(TDataFieldAggProperty)
  public
    function GetDataSourcePropName: string; override;
  end;

{------------------------------------------------------------------------------}
procedure Register;
begin

  {DB Standard controls}
  {****************************************************************************}
  RegisterComponents('LMD DB', [
                      TLMDDBNavigator,
                      TLMDDBSpeedButton,
                      TLMDBookmarkCont,
                      TLMDDBExport,
                      TLMDCSV2DBImport,
                      TLMDDBRestoreGrid,
                      TLMDDBSimpleLabel,
                      TLMDDBLabel,
                      TLMDDBHTMLLabel,
                      TLMDDBInformationLabel,
                      TLMDDBGlyphInfoLabel,
                      TLMDDBLabelFill,
                      TLMDDBGraphicLabel,
                      TLMDDBProgress,
                      TLMDDBLEDLabel,
                      TLMDDBProgressFill,
                      TLMDDBNImage,
                      TLMDDBSwitch,
                      TLMDDBWSwitch,
                      TLMDDBLight,
                      TLMDDBShapeControl
                     ]);

  {DB Edit controls}
  {****************************************************************************}
  RegisterComponents('LMD DB Edit', [
                      TLMDDBEdit,
                      TLMDDBMemo,
                      TLMDDBCheckBox,
                      TLMDDBRadioGroup,
                      TLMDDBCheckGroup,
                      TLMDDBMaskEdit,
                      TLMDDBSpinEdit,
                      TLMDDBExtSpinEdit,
                      TLMDDBEditDBLookup,
                      TLMDEditDBLookup,
                      TLMDDBCalendar,
                      TLMDDBTrackBar
                     ]);

  if leoInstallLabeledControls in LMDTOOLSEDITOROPTIONS then
    RegisterComponents('LMD DB Labeled', [
                        TLMDDBLabeledEdit,
                        TLMDDBLabeledMaskEdit,
                        TLMDDBLabeledSpinEdit,
                        TLMDDBLabeledExtSpinEdit,
                        TLMDDBLabeledMemo]);

  RegisterPropertyEditor (TypeInfo(String), TLMDEditDBLookup,
                          'LookupDataField', TLMDDataFieldAggProperty);

  {DB List controls}
  {****************************************************************************}
  RegisterComponents('LMD DB List', [
                      TLMDDBColorComboBox,
                      TLMDDBImageComboBox,
                      TLMDDBImageListBox,
                      TLMDDBListComboBox,
                      TLMDDBTreeComboBox,
                      TLMDDBCalendarComboBox,
                      TLMDDBCalculatorComboBox,
                      TLMDDBFieldComboBox,
                      TLMDDBLookupComboBox
                     ]);

  if leoInstallLabeledControls in LMDTOOLSEDITOROPTIONS then
    RegisterComponents('LMD DB Labeled', [
                        TLMDDBLabeledListComboBox,
                        TLMDDBLabeledTreeComboBox,
                        TLMDDBLabeledCalendarComboBox,
                        TLMDDBLabeledCalculatorComboBox,
                        TLMDDBLabeledImageListBox
                       ]);
  RegisterComponentEditor(TLMDDBImageListBox, TLMDImageListBoxComponentEditor);
  
  RegisterComponentEditor(TLMDDBHTMLLabel, TLMDHTMLLabelComponentEditor);

  if geoSetOI in LMDGLOBALEDITOROPTIONS then begin
    RegisterPropertyEditor(TypeInfo(TLMDDBImportOptions),nil,'',TLMDExtSetProperty);
    RegisterPropertyEditor(TypeInfo(TLMDDBRestoreGridOptions),nil,'',TLMDExtSetProperty);
    RegisterPropertyEditor(TypeInfo(TLMDNavButtons),nil,'',TLMDExtSetProperty);
    // Standard VCL SET properies (DB controls)
    RegisterPropertyEditor(TypeInfo(TFieldAttributes), nil, '', TLMDSetProperty);
    // RM, following line causes internal compiler error in .NET
    RegisterPropertyEditor(TypeInfo(TFieldchars), nil, '', TLMDSetProperty);
    RegisterPropertyEditor(TypeInfo(TFieldkinds), nil, '', TLMDSetProperty);
    RegisterPropertyEditor(TypeInfo(TDBGridOptions), nil, '', TLMDSetProperty);
    {$IFNDEF LMDCOMP21}
    RegisterPropertyEditor(TypeInfo(TConfigMode), nil, '', TLMDSetProperty);
    {$ENDIF}
    RegisterPropertyEditor(TypeInfo(TFilterOptions), nil, '', TLMDSetProperty);
    {$IFDEF LMDCOMP10}
    RegisterPropertyEditor(TypeInfo(TNavButtonSet), nil, '', TLMDSetProperty);
    {$ELSE}
    RegisterPropertyEditor(TypeInfo(TButtonSet), nil, '', TLMDSetProperty);
    {$ENDIF}
    RegisterPropertyEditor(TypeInfo(TColumnValues), nil, '', TLMDSetProperty);
    RegisterPropertyEditor(TypeInfo(TIndexOptions), nil, '', TLMDSetProperty);
    RegisterPropertyEditor(TypeInfo(TNavButtonStyle), nil, '', TLMDSetProperty);
    RegisterPropertyEditor(TypeInfo(TProviderFlags), nil, '', TLMDSetProperty);
    {$IFNDEF LMDCOMP21}
    RegisterPropertyEditor(TypeInfo(TTraceFlags), nil, '', TLMDSetProperty);
    {$ENDIF}
    RegisterPropertyEditor(TypeInfo(TUpdateRecordTypes), nil, '', TLMDSetProperty);
    RegisterPropertyEditor(TypeInfo(TUpdateStatusSet), nil, '', TLMDSetProperty);
  end;

end ;

{ TLMDDataFieldAggProperty }

function TLMDDataFieldAggProperty.GetDataSourcePropName: string;
begin
  Result := 'LookUpDataSource';
end;

end.
