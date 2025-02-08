unit LMD_RegMainEditors;
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

LMD-Tools Main Controls registration unit (RM)
----------------------------------------------
Registers property editors and designtime enhancements for LMD-Tools Main controls.

Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface

procedure Register;

implementation

uses
  Classes, ComCtrls, ImgList,
  DesignIntf, 
  LMDTypes, LMDButtonBar, LMDButtonBase, LMDAssist, LMDShadow, LMDShapeFill,
  LMDPointList, LMDCal, LMDClass, LMDCaption, LMDDateL, LMDRegionMask, LMDVldBase,
  LMDMsg, LMDCaptionButtons, LMDCustomMMButton, LMDCustomShapeButton,
  LMDMMButtonFaceController, pLMDExDsgnOIEnh, pLMDCommon, pLMDPEMain, pLMDPeX, pLMDPeCore,
  // For SET-property editors
  LMDDlgEx, LMDBrowseDlg, LMDFormA, LMDFormStyler, LMDGrlf, LMDLED, LMDMRUList,
  LMDPanelCaptionObject, LMDPopupMenu, LMDTextEditDlg, LMDWindowListDlg, LMDSysMenu,
  LMDClock, LMDButtonBarPopupMenu, LMDCaptionPanelGroup, LMDDlgButtonPanel,
  LMDCustomHeaderPanel, LMDSimpleBevel, LMDShape, LMDTeeth, LMDBaseDialog;

procedure Register;
begin
  //button bar
  RegisterPropertiesInCategory (sLMDCategoryName,
                                TLMDButtonBar,
                                ['Sections', 'FillSelectedItem',
                                 'FixedSectionLeftBorder',
                                 'FixedSectionRightBorder',
                                 'FocusStyle',
                                 'IniSaveOptions', 'IniSection', 'IniKey',
                                 'LargeItemHeight', 'SmallItemHeight',
                                 'Orientation', 'SaveAndRestore',
                                 'ScrollDelay', 'ScrollStep',
                                 'SectionBtnSize', 'SingleSectionMode',
                                 'SoftScroll', 'TransparentButtons']);

  RegisterPropertiesInCategory (sLayoutCategoryName,
                                TLMDButtonBar,
                                ['FixedSectionLeftBorder',
                                 'FixedSectionRightBorder',
                                 'LargeItemHeight', 'SmallItemHeight',
                                 'Orientation',
                                 'SectionBtnSize', 'SingleSectionMode']);

  RegisterPropertiesInCategory (sVisualCategoryName,
                                TLMDButtonBar,
                                ['FillSelectedItem',
                                 'FixedSectionLeftBorder',
                                 'FixedSectionRightBorder',
                                 'FocusStyle',
                                 'LargeItemHeight', 'SmallItemHeight',
                                 'Orientation',
                                 'SectionBtnSize', 'SingleSectionMode',
                                 'TransparentButtons']);

  // Test Examples for boolean properties
  if geoSetOI in LMDGLOBALEDITOROPTIONS then
    begin
      RegisterPropertyEditor(TypeInfo(TLMDAssistButtons), nil, '', TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDBBIniSaveOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDHeaderElements),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDVisibleModes),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFormOpenOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDVisibleControlsSet),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFormColorDialogOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFormFontDialogOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDPageSetupOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDPrintDialogOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFormFolderDialogOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDInsertObjectOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDBrowseDlgOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDClockOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDAutoDockSides),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDButtonBarPopupMenuItems),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDCPGIniSaveOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDDlgButtonOptions),nil,'',TLMDExtSetProperty);

      RegisterPropertyEditor(TypeInfo(TLMDFormIniSaveOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFormOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFormStyleOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDHeaderOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDLEDSET),nil,'',TLMDExtSetProperty);

      RegisterPropertyEditor(TypeInfo(TLMDPanelCaptionButtons),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDPopUpOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDTextEditDlgOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDTransLabelAttr),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDWLOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSysMenuEntries),nil,'',TLMDExtSetProperty);
    end;
   // --> more to add!!!

   // TStringList-Editor - since LMD-Tools 6.12 only for LMD controls
   // ==========================================================================
   {if geoStringEditor in tmp then
     begin
     end;}

  // Extended LMD ImageList editor
  // --> Since LMD-Tools 8 editor must be registered for each LMD control
  // class separately, because global bitmap-/ImageLists should be visible for
  // LMD controls only
  // ==========================================================================
  // TCustomImageList -> Make global lists visible
  // Extended LMD ImageList editor
  // --> Since LMD-Tools 8 editor must be registered for each LMD control
  // class separately, because global bitmap-/ImageLists should be visible for
  // LMD controls only
  // ==========================================================================
  // TCustomImageList -> Make global lists visible
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDBaseDialog, 'ImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDMessageBoxDlg, 'ImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDMessageBoxDlg, 'CustomGlyphImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDCaptionButtons, 'ImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDButtonBar, 'LargeImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDButtonBar, 'SmallImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDCustomMMButton, 'ButtonFaceImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDCustomShapeButton, 'ShapeFillImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDMMButtonFaceController, 'ButtonFaceImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDPopupMenu, 'ImageList', TLMDCustomImageListProperty);

   //TLMDShadow
   RegisterPropertyEditor( TypeInfo( TLMDShadow ), nil, '', TLMDShadowProperty);
   //TLMDShapeFill, TLMDFillObject
   RegisterPropertyEditor( TypeInfo( TLMDShapeFill ), nil, '', TLMDShapeFillProperty);
   RegisterPropertyEditor( TypeInfo( TLMDPointList ), nil, '', TLMDPointListProperty);

   //Extended controls
   //TLMDAssist
   RegisterPropertyEditor(TypeInfo( TLMDAssistPage), nil, '', TLMDAssistPageProperty);
   RegisterPropertyEditor( TypeInfo (TLMDDATETIMEFORMAT), TLMDClock, 'CustomDateTimeFormat', TLMDDateTimeFormatProperty);
   //TLMDCaption
   RegisterPropertyEditor( TypeInfo( TLMDCaption ), nil, '', TLMDCaptionProperty);

   //TLMDDateList
   RegisterPropertyEditor( TypeInfo( lmddatel.TLMDDateList), TLMDSpecialDates, 'Dates', TLMDDateListProperty);

   // *!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*
   //lmdregdg

   //Editors for extended dialog controls
   RegisterPropertyEditor(TypeInfo(TLMDFilterString),TLMDFormOpenDialog,'Filter',TLMDFilterProperty);
   RegisterPropertyEditor(TypeInfo(TLMDFilterString),TLMDFormSaveDialog,'Filter',TLMDFilterProperty);

   // *!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*
   //lmdregsy
   RegisterPropertyEditor ( TypeInfo(TLMDRegionMask), nil, '', TLMDRegionMaskProperty);
   //RegExp property of the TMDRegExpValidator
   RegisterPropertyEditor(TypeInfo(TLMDRegExString), nil, 'Expression', TLMDVldRegExprProperty);

   // *!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*
   //lmdregmm
   //TLMDButtonFace
   RegisterPropertyEditor(TypeInfo(TLMDButtonFace), nil, '', TLMDButtonFaceProperty);
   //TLMDSimpleBevel
   RegisterPropertyEditor( TypeInfo( TLMDSimpleBevel ), nil, '', TLMDSimpleBevelProperty);
   //TLMDShape
   RegisterPropertyEditor( TypeInfo( TLMDShapeType ), nil, '', TLMDShapeProperty);
   //TLMDTeeth
   RegisterPropertyEditor( TypeInfo( TLMDTeeth ), nil, '', TLMDTeethProperty);
end;

end.

