unit LMD_RegPlugin;
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

_LMD_RegPlugin unit
------------------


Changes
-------
Release 0.2 (July 2007)
 - Initial Release

###############################################################################}
interface

uses 
  ToolsApi, DesignIntf, DesignEditors, VCLEditors, DesignMenus,
  Classes, Windows, SysUtils, Controls, pLMDPluginWizard, LMDPluginModule, LMDPluginManager, LMDCustomPluginManager, LMDPluginModuleEditor;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('LMD Plugins', [TLMDPluginManager]);
  RegisterCustomModule(TLMDPluginModule, TLMDPluginCustomModule);
  RegisterComponentEditor(TLMDPluginModule, TLMDPluginModuleEditor);
  {$ifdef LMDCOMP9}
  RegisterPackageWizard(TLMDBuilderPluginModuleWizard.Create);
  RegisterPackageWizard(TLMDDelphiPluginModuleWizard.Create);
  {$else}
    {$ifdef BCB}         
    RegisterPackageWizard(TLMDBuilderPluginModuleWizard.Create);
    {$else}
    RegisterPackageWizard(TLMDDelphiPluginModuleWizard.Create);
    {$endif}
  {$endif}
end;

end.
