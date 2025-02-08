unit LMD_RegStorage;
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

_LMD_RegStorage unit (VO)
--------------------------
LMDStoragePack: Registration file.

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  DesignIntf, DesignEditors, VCLEditors,
  Classes, SysUtils,
  // runtime files
  LMDStorBase, LMDStorPropertiesStorage, LMDStorRegistryVault, LMDStorINIVault,
  LMDStorBinVault, LMDStorXMLVault, LMDStorXORCryptor, LMDStorCustomCryptor,
  LMDStorFormProperties, LMDStorControllerVault,
  // IDE only files
  LMDStorTemplateStorage, pLMDStorPE, pLMDOIEnh, pLMDCommon;

const
  CTRL_STORAGE = 'LMD Storage';  // Name of Storage Pack Tab

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents(CTRL_STORAGE, [TLMDStorPropertiesStorage,
                                    TLMDStorRegistryVault,
                                    TLMDStorBinVault,
                                    TLMDStorXMLVault,
                                    TLMDStorINIVault,
                                    TLMDStorXORCryptor,
                                    TLMDStorCustomCryptor,
                                    TLMDStorFormStorage,
                                    TLMDStorControllerVault]);

  RegisterComponentEditor(TLMDStorPropertiesStorage, TLMDPropertiesComponentEditor);
  RegisterPropertyEditor(TypeInfo(TLMDStorPropertyStorageItems), TLMDStorPropertiesStorage, 'Properties', TLMDPropertiesPropertyEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TLMDAbstractStorageVault, 'ActiveSectionIndex', TLMDSectionIndexProperty);

  // RM
  RegisterPropertyEditor(TypeInfo(TLMDAbstractStorageVault), TLMDStorControllerVault, 'StorageVault', TLMDStorVaultProperty);
  RegisterPropertyEditor(TypeInfo(TFileName), TLMDAbstractStorageVault, 'FileName', TLMDStorFilenameProperty);
  // ---
  {RegisterPropertyEditor(TypeInfo(String), TLMDStorXMLVault, 'FileName', TXMLFilenameProperty);
  RegisterPropertyEditor(TypeInfo(String), TLMDStorBinVault, 'FileName', TBinFilenameProperty);
  RegisterPropertyEditor(TypeInfo(String), TLMDStorINIVault, 'FileName', TIniFilenameProperty);}

  RegisterComponents(CTRL_STORAGE, [TLMDStorTemplateStorage]);
  RegisterComponentEditor(TLMDStorTemplateStorage, TLMDStorTemplateStorageEditor);

    // get current global settings, entry for adding custom set editors
  if geoSetOI in LMDGLOBALEDITOROPTIONS then
    begin
      RegisterPropertyEditor(TypeInfo(TLMDStorCryptTypes), nil, '', TLMDSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDStorFormProps), nil, '', TLMDSetProperty);
    end;
end;

end.
