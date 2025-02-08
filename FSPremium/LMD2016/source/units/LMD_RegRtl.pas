unit LMD_RegRtl;
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

_LMD_RegRtl Unit(RM)
--------------------

Changes
-------
Release 9.0 (April 2008)
 - Initial Release

###############################################################################}

interface

  {$R LMDCPData.dcr}
  {$R pLMDEditors.res}

procedure Register;

implementation

{------------------------------------------------------------------------------}

uses
  Windows, Classes, Controls, Graphics, SysUtils, Forms, Menus, Grids, Dialogs,
  DesignIntf, DesignEditors, ToolsAPI,
  LMDDateTime, LMDTypes, LMDUnicodeStrings, intfLMDBase,
  pLMDCommon, pLMDCst, pLMDOIEnh, pLMDGlobalEditors, pLMDComAboutDlg,

  // 8.0 --> Shared controls for designtime editors
  pLMDURLLabel, pLMDColorBox, pLMDImageBox, LMDShSpinEdit,
  // 9.0
  pLMDConfigExp

  // ------
  , comctrls // TypeInfo(TConsistentAttributes)
  , toolwin  // TypeInfo(TEdgeBorders)
  , filectrl // TypeInfo(TFileType)
  , mask     // TypeInfo(TMaskedState)
  , printers // TypeInfo(TPrinterCapabilities)
;

{$IFDEF LMDCOMP9}
{------------------------------------------------------------------------------}
var
  LMDAboutBoxServices: IOTAAboutBoxServices = nil;
  LMDAboutBoxIndex: Integer = 0;

{------------------------------------------------------------------------------}
procedure LMDInstallIDEIcons;
var
  tmp                  : TBitmap;
  tmpHImage            : HBitmap;
  begin
  tmp := TBitmap.Create;
  try
    tmp.Handle := LoadBitmap(hInstance, sLMDSplashIconResource);
    tmpHImage := LoadBitmap(hInstance, sLMDSplashIconResource);
    if Supports(BorlandIDEServices, IOTAAboutBoxServices, LMDAboutBoxServices) then
      LMDAboutBoxIndex := LMDAboutBoxServices.AddPluginInfo(sLMDPackageName, sLMDAboutDescription, tmpHImage, False, '');
    SplashScreenServices.AddPluginBitmap(sLMDPackageName, tmp.Handle, false, '', '' );
  finally
    tmp.Free;
  end;
  end;

{------------------------------------------------------------------------------}
procedure LMDUninstallIDEIcons;
begin
  if Assigned(LMDAboutBoxServices) and (LMDAboutBoxIndex<>0) then
    begin
      LMDAboutBoxServices.RemovePluginInfo(LMDAboutBoxIndex);
      LMDAboutBoxIndex := 0;
      LMDAboutBoxServices := nil;
    end;
end;
{$ENDIF}

{------------------------------------------------------------------------------}
procedure Register;
begin
  // 9.0
  // Common configuration
  RegisterPackageWizard(TLMDConfigExpert.Create);

  // AboutDialog
  RegisterPropertyEditor(TypeInfo(TLMDAboutVar), nil, 'About', TLMDAboutProperty);

  // Shared controls for designtime editors.
  if leoInstallDesignEditorControls in LMDTOOLSEDITOROPTIONS then
    RegisterComponents('LMD EditorCtrls', [TLMDURLLabel,
                                           TLMDColorBox,
                                           TLMDImageCBox,
                                           TLMDImageLBox,
                                           TLMDShSpinEdit]);

   //--> ToDO
  {TPicture/Graphic}
  {outcomment next two lines, if you don't want the extended TPicture-Editor}
  //RegisterPropertyEditor(TypeInfo(TPicture), nil, '', TLMDPictureProperty);
  //RegisterPropertyEditor(TypeInfo(TGraphic), nil, '', TLMDGraphicProperty);

  {TLMDDateTime}
  RegisterPropertyEditor(TypeInfo(TLMDDATETIME), nil, '', TLMDDateTimeProperty);

  {TLMDStrings}
  {$IFNDEF LMDCOMP12}
  if geoWideStringEditor in LMDGLOBALEDITOROPTIONS then
    RegisterPropertyEditor(TypeInfo(TLMDWideStrings), nil, '', TLMDWideStringsProperty);
  {$ENDIF}

  {TBrush}
  if geoBrushEditor in LMDGLOBALEDITOROPTIONS then
    RegisterPropertyEditor(TypeInfo(TBrush), nil, '', TLMDBrushProperty);

  {String-Editor}
  if geoStringEditor in LMDGLOBALEDITOROPTIONS then
  begin
    RegisterPropertyEditor(TypeInfo(String), nil, '', TLMDStringProperty);
    RegisterPropertyEditor(TypeInfo(TLMDString), nil, '', TLMDStringProperty);
  end;

  {Hint-Editor}
  if geoHintEditor in LMDGLOBALEDITOROPTIONS then
  begin
    RegisterPropertyEditor(TypeInfo(string), TControl, 'Hint', TLMDHintProperty);
    RegisterPropertyEditor(TypeInfo(TLMDString), TControl, 'Hint', TLMDHintProperty);
  end;

  {TCaption-Editor}
  if geoCaptionEditor in LMDGLOBALEDITOROPTIONS then
    RegisterPropertyEditor(TypeInfo(TCaption), nil, '', TLMDStdCaptionProperty);

  {TFont-Editor}
  if geoFontOI in LMDGLOBALEDITOROPTIONS then
    RegisterPropertyEditor(TypeInfo(TFont), nil, '', TLMDFontProperty);

  // TLMDHotKey Editor
  if geoHotkeyEditor in LMDGLOBALEDITOROPTIONS then
    RegisterPropertyEditor(TypeInfo(TShortCut), nil, '', TLMDHotkeyProperty);

  // --> LMD-Tools 7.0 Enhancements
  // ---------------------------------------------------------------------------
  // TLMDBooleanProperty
  if geoBooleanOI in LMDGLOBALEDITOROPTIONS then
    begin
      RegisterPropertyEditor(TypeInfo(ByteBool), nil, '', TLMDBoolProperty);
      RegisterPropertyEditor(TypeInfo(Boolean),  nil, '', TLMDBooleanProperty);
      RegisterPropertyEditor(TypeInfo(LongBool), nil, '', TLMDBoolProperty);
      RegisterPropertyEditor(TypeInfo(WordBool), nil, '', TLMDBoolProperty);
    end;

  // Elements properties -> must be registered for each type :-(
  // Here are examples only, full list must be added
  if geoSetOI in LMDGLOBALEDITOROPTIONS then
    begin
      RegisterPropertyEditor(TypeInfo(TBevelEdges), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TFontStyles), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TBorderIcons), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TMenuAnimation), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TAnchors), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TGridOptions), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TOpenOptions), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TOpenOptionsEx),nil,'',TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TFontDialogOptions), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TColorDialogOptions), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TPrintDialogOptions), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TFindOptions), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TComponentState), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TComponentStyle), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TConsistentAttributes), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TControlState), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TControlStyle), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TEdgeBorders), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TFileType), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TFormState), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(THKInvalidKeys), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(THKModifiers), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TListhottrackStyles), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TMaskedState), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TPrinterCapabilities), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TScalingFlags), nil, '', TLMDSetProperty);
    end;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP9}
initialization
  LMDInstallIDEIcons;

finalization
  LMDUnInstallIDEIcons;
{$ENDIF}
end.
