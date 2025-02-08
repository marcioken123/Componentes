unit LMD_RegThemes;
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

LMD_RegThemes unit (VB)
-----------------------------
Registration unit for LMD ThemesPack.

Changes
-------
Release 1.0 (XXX 2008)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Controls;

procedure Register;

implementation
uses
  LMDThemesGradientThemeRenderer,
  LMDThemesSGThemeRenderer,
  LMDThemesSGExtThemeRenderer,
  LMDThemesEngine,
  LMDFormThemeProvider;

{------------------------------------------------------------------------------}
procedure Register;
begin
  // components
  RegisterComponents('LMD Themes',  [TLMDThemeEngineController,
                                     TLMDFormThemeProvider,
                                     TLMDThemesGradientThemeController,
                                     TLMDSimpleGradientThemeController,
                                     TLMDSimpleGradientExtThemeController
                                    ]);
end;

end.

