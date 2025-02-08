unit LMD_RegCoreEditors;
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

LMD-Tools Core Controls registration unit (RM)
----------------------------------------------
Registers components and editors for the LMD-Tools Core controls, which
replaces LMD-Tools SE product line from LMD-Tools 2007 on.

Changes
-------
Release 8.0 (August 2006)
 - Initial Release

###############################################################################}

interface

procedure Register;

implementation

uses
  Classes, ComCtrls, ImgList,
  DesignIntf,
  LMDBase, LMDBaseMRUList, LMDClass, LMDCustomImageList, LMDImageList, LMDInformationLabel,
  LMDTypes, LMDGlyphTextLayout, LMDButtonLayout, LMDCont, LMDSplt, LMDBevel, LMD3DCaption,
  LMDFXCaption, LMDSmallBar, LMDGradient, LMDCustomMaskEdit, LMDCustomMemo,
  LMDWave, LMDFillObject, LMDCaption, LMDTransparent, LMDGraph, LMDApplicationCtrl,
  LMDBitmapEffectObject, LMDAlphaObject, LMDCustomComponent, LMDCustomControl,
  LMDCustomGroupBox, LMDCustomComboBox, LMDCustomListBox, LMDCustomScrollBox,
  LMDBaseEdit, LMDCustomEdit, LMDSBar, LMDSBtn, LMDButtonPanel, LMDCustomButton,
  LMDcustomButtonGroup, LMDCaret, LMDWndProcComponent, LMDCustomImageComboBox,
  LMDIniCtrl, LMDCustomCheckListDlg, LMDButtonBase, LMDBaseGraphicControl,
  pLMDCommon, pLMDPeCore, pLMDPeX, pLMDExDsgnOIEnh,
  {$ifdef lmdcomp12}lmdpngimage, pngimage,{$endif}
  // For SET-property editors
  LMDBaseLabel, LMDBaseGraphicButton, LMDCustomColorComboBox, LMDCustomImageListBox, LMDEditAutoComplete,
  LMDFontComboBox, LMDMRUList, LMDPrinterComboBox, LMDProcs, LMDSpinButton,
  LMDFaceController;

procedure Register;
begin
{
LabelPosition ;
LabelSpacing ;
LabelSync ;
}
  //general
  RegisterPropertiesInCategory(sVisualCategoryName, ['FillObject',
                                                        'BackFX',
                                                        'Bevel',
                                                        'FontFX',
                                                        'Font3D',
                                                        'ListIndex',
                                                        'FaceController',
                                                        'ShapeFill',
                                                        'Transparent']);

  RegisterPropertiesInCategory(sActionCategoryName, ['Action']);

  RegisterPropertiesInCategory(sMiscellaneousCategoryName, ['Attributes','Style']);

  RegisterPropertiesInCategory (sLayoutCategoryName,  ['ButtonLayout']);

  //Register all properties (by name) into category LMD Tools
  //Note: This should not be done with properties like Transparent which
  //can even exist without LMD Tools
  RegisterPropertiesInCategory (sLMDCategoryName, [TypeInfo (TLMDFillObject),
                                              TypeInfo (TLMDBitmapEffectObject),
                                              'BackFXPass',
                                              TypeInfo (TLMDBevel),
                                              TypeInfo (TLMDFXCaption),
                                              TypeInfo (TLMD3DCaption),
                                              TypeInfo (TLMDScrollBarObject),
                                              TypeInfo (TLMDSpecialButtons),
                                              TypeInfo (TLMDUserButtonStyle),
                                              TypeInfo (TLMDIniUse),
                                              TypeInfo (TLMDIniCtrl),
                                              TypeInfo (TLMDFaceController)]);

  RegisterPropertiesInCategory (sVisualCategoryName,
                                [TypeInfo (TLMDUserButtonStyle)]);

  RegisterPropertiesInCategory (sLinkageCategoryName, ['ImageList',
                                                          'Control',
                                                          'DataField' ,
                                                          'DataSource',
                                                          'DropDownCombo',
                                                          'DropDownMenu',
                                                          'EditLabel',
                                                          'FocusControl',
                                                          'LookupDataField',
                                                          'LookupDataSource',
                                                          'Menu',
                                                          'MenuItem']);

  //component specific LMD Tools properties
  //all descendants of TLMDCustomControl
  RegisterPropertiesInCategory (sLMDCategoryName,
                                TLMDCustomControl,
                                ['Transparent','Flat','SupportXP','ImageList',
                                'ListIndex', 'ImageIndex', 'About',
                                'OnMouseEnter', 'OnMouseExit', 'OnAfterEnter',
                                'OnAfterExit']);

  //all descendant of TLMDBaseGraphicControl
  RegisterPropertiesInCategory (sLMDCategoryName,
                                TLMDBaseGraphicControl,
                                ['About', 'OnBoundsChange', 'OnMouseEnter',
                                 'OnMouseExit']);

  //group boxes
  RegisterPropertiesInCategory (sLMDCategoryName,
                                TLMDCustomGroupBox,
                                ['Alignment', 'Transparent', 'CaptionOffset',
                                 'CaptionParentFont']);
  //edits
  RegisterPropertiesInCategory (sLMDCategoryName,
                                TLMDBaseEdit,
                                ['FocusOnMouseAbove', 'AutoSelect',
                                 'AutoComplete', 'Caret', 'Alignment',
                                 'HighlightBack', 'HighlightText',
                                 'AskForLoop']);

  RegisterPropertiesInCategory (sInputCategoryName,
                                TLMDBaseEdit,
                                ['CharCase', 'PasswordChar', 'OEMConvert',
                                 'MaxLength']);

  RegisterPropertiesInCategory (sLinkageCategoryName,
                                TLMDBaseEdit, ['AutoComplete']);

  RegisterPropertiesInCategory (sLMDCategoryName,
                                TLMDCustomEdit,
                                ['CustomButtonWidth',
                                 'OnCursorPosChanged', 'OnTextChangedAt',
                                 'OnChange', 'OnModified']);

  RegisterPropertiesInCategory (sLMDCategoryName,
                                TLMDCustomMemo,
                                ['OnMarginRowPaint', 'OnCurrentRowChanged',
                                 'OnRowCountChanged', 'Margin']);

  //button panel
  RegisterPropertiesInCategory (sLayoutCategoryName,
                                TLMDButtonPanel, ['ButtonWidth', 'ButtonHeight']);

  // *!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*

  // Test Examples for boolean properties
  if geoSetOI in LMDGLOBALEDITOROPTIONS then
    begin
      RegisterPropertyEditor(TypeInfo(TLMDSystemOptions), nil, '', TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDCheckListBoxDlgOptions),nil,'',TLMDExtSetProperty);
      // if this line is included, compiler generates internal error
      {$IFNDEF LMDCOMP12} 
      // if this line is included, compiler generates error: TLMDDelimiters has no typeinfo
      RegisterPropertyEditor(TypeInfo(TLMDDelimiters),nil,'',TLMDExtSetProperty);
      {$ENDIF}
      RegisterPropertyEditor(TypeInfo(TLMDEditModes),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDBoundsChangeStates),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDApplicationOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDListBoxEditOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFillOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFrameSides),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDDrawTextStyles),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSplitterIniSaveOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDAutoCompleteAddOns),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDAutoCompleteModes),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDAutoCompleteSources),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDColorCBOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFontCBOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDImageBoxOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDLabelOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDPrinterCBOptions),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDSpinButtons),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDMRUListOptions),nil,'',TLMDExtSetProperty);
    end;
  // --> more to add!!!

  // TStringList-Editor - since LMD-Tools 6.12 only for LMD controls
  // ==========================================================================
  if geoStringEditor in LMDGLOBALEDITOROPTIONS then
    begin
      RegisterPropertyEditor (TypeInfo(TStrings), TLMDCustomComponent, '', TLMDStringListProperty);
      RegisterPropertyEditor (TypeInfo(TStrings), TLMDCustomControl, '', TLMDStringListProperty);
      RegisterPropertyEditor (TypeInfo(TStrings), TLMDBaseGraphicControl, '', TLMDStringListProperty);
      RegisterPropertyEditor (TypeInfo(TStrings), TLMDCustomComboBox, '', TLMDStringListProperty);
      RegisterPropertyEditor (TypeInfo(TStrings), TLMDCustomListBox, '', TLMDStringListProperty);
      RegisterPropertyEditor (TypeInfo(TStrings), TLMDCustomScrollBox, '', TLMDStringListProperty);
    end;

  // Extended LMD ImageList editor
  // --> Since LMD-Tools 8 editor must be registered for each LMD control
  // class separately, because global bitmap-/ImageLists should be visible for
  // LMD controls only
  // ==========================================================================
  // TCustomImageList -> Make global lists visible
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDBaseGraphicControl, 'ImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDCustomButton, 'ImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDCustomControl, 'ImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDCustomButtonGroup, 'GlyphImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDCaret, 'ImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDAlphaObject, 'ImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDWndProcComponent, 'ImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDCustomImageComboBox, 'ImageList', TLMDCustomImageListProperty);
  RegisterPropertyEditor( TypeInfo( TCustomImageList), TLMDCustomImageListBox, 'ImageList', TLMDCustomImageListProperty);

  //lmdregst
    RegisterPropertyEditor( TypeInfo (TLMDDATETIMEFORMAT), TLMDInformationLabel, 'DateTimeFormat', TLMDDateTimeFormatProperty);
    //Property TextAndGlyph
    RegisterPropertyEditor( TypeInfo( TLMDGlyphTextLayout ), nil, '', TLMDTextAndGlyphProperty );
    //{TLMDButtonLayout
    RegisterPropertyEditor(TypeInfo(TLMDButtonLayout), nil, '', TLMDButtonLayoutProperty);
    RegisterPropertyEditor( TypeInfo( TLMDImageList), nil, '', TLMDImageListProperty);

    //TLMDHTMLString
    RegisterPropertyEditor( TypeInfo( TLMDHTMLString ), nil, '', TLMDHTMLStringProperty);

     {general designtime editors}
    {****************************************************************************}
    //TLMDBevel
    RegisterPropertyEditor( TypeInfo( TLMDBevel ), nil, '', TLMDBevelProperty);
    //TLMDFont3D
    RegisterPropertyEditor( TypeInfo( TLMD3DCaption ), nil, '', TLMD3DProperty);
    //TLMDFontFx
    RegisterPropertyEditor( TypeInfo( TLMDFxCaption ), nil, '', TLMDFxProperty);

    //TLMDBitmapEffectObject
    RegisterPropertyEditor( TypeInfo( TLMDBitmapEffectObject ), nil, '', TLMDBitmapFXObjectProperty);
    //TLMDAlphaObject
    RegisterPropertyEditor( TypeInfo( TLMDAlphaObject ), nil, '', TLMDAlphaObjectProperty);

    //TLMDSmBarOptions
    RegisterPropertyEditor( TypeInfo( TLMDSmallBar), nil, '', TLMDSmallBarProperty);
    {--> system, extended}
    //TLMDGradient
    RegisterPropertyEditor( TypeInfo( TLMDGradient ), nil, '', TLMDGradientProperty);
    RegisterPropertyEditor( TypeInfo( TLMDFillObject ), nil, '', TLMDFillObjectProperty);

    // --> LMD-Tools 7.0 Enhancements --> LMD Types
    // ---------------------------------------------------------------------------
    // TLMDGlyphKindProperty
    RegisterPropertyEditor(TypeInfo(TLMDGlyphKind), nil, '', TLMDGlyphKindProperty);

    // *!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*
    //lmdregec
    //TLMDMaskEdit
    RegisterPropertyEditor(TypeInfo(String), TLMDCustomMaskEdit, 'Mask', TLMDMaskProperty);
    //TLMDMemo
    RegisterPropertyEditor(TypeInfo(TLMDMemoStrings), TLMDCustomMemo, 'Lines', TLMDMemoLinesProperty);

    // *!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*
    //lmdregex
    //TLMDTransparent
    RegisterPropertyEditor( TypeInfo( TLMDTransparent ), nil, '', TLMDTransparentProperty);
    RegisterPropertyEditor(TypeInfo(TLMDSplitterBarItems), TLMDSplitterPanel, 'Bars', TLMDSplitterBarItemProperty);
    // *!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*
    //lmdregsy
    // *!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*

    {$ifdef lmdcomp12}
    RegisterPropertyEditor( TypeInfo(TLMDPNGObject), TLMDBaseGraphicButton , 'PngGlyph', TLMDPNGImageProperty);
    {$endif}

end;

end.

