unit LMD_RegWeb;

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

_LMD_RegWeb unit (DD)
--------------------
Registration unit for LMD WebPack

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}
interface
{$I LMDCmps.inc}

  {$R LMDUpdateFrm.res}
  {$R LMDUpdateAdapter.res}

procedure Register;

implementation

uses
  Classes, Controls,
  DesignIntf, DesignEditors, VCLEditors,
  LMDWebInfo,
  pLMDOIEnh, LMDWebBase, LMDMapi, LMDNews, LMDWebUpdate, LMDWebConfig,
  LMDWebHTTPGet, LMDWebHTMLScan, LMDWebHTTPScan, LMDRAS,
  LMDWebNewsView, LMDUpdateAdapter, pLMDCommon, LMDUpdateFrm;

procedure Register;
begin
  // Connect TLMDWebComponent with TWinControl, so that it no longer appears
  // on CLX palette.
  GroupDescendentsWith(TLMDWebComponent, TWinControl);

  RegisterComponents('LMD Web',     [TLMDMapiSendMail,
                                     TLMDRAS,
                                     TLMDWebNews,
                                     TLMDWebNewsView,
                                     TLMDWebUpdate,
                                     TLMDWebConfig,

                                    TLMDWebInfo,

                                     TLMDWebHTTPGet,
                                     TLMDWebHTMLScan,
                                     TLMDWebHTTPScan,
                                     TLMDUpdateAdapter,
                                     TLMDUpdateForm
                                     ]);

   // get current global settings, entry for adding custom set editors
  if geoSetOI in LMDGLOBALEDITOROPTIONS then
    begin
      RegisterPropertyEditor(TypeInfo(TLMDMAPIOptions), nil, '', TLMDSetProperty);
    end;

end;

end.
