unit pLMDCstMain;

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

pLMDConstMain unit (RM)
---------------------
Constants for LMD-Tools main editors

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

resourcestring
 {LMD Tools Style Editor messages}
 IDS_STYLEEXISTS='Substyle '#39'%s'#39' already exists in destination style!';
 IDS_PROPERTYEXISTS='Property '#39'%s'#39' already included in destination style!';
 IDS_NOSUCHPROPERTY='Component '#39'%s'#39' doesn'#39't have property '#39'%s'#39'!';
 IDS_CLEARBMPQUERY='No bitmap was chosen. Clear current bitmap?';
 IDS_INVALIDSTYLNAME='Invalid style name!';
 IDS_SELECTSTYLEORPROP='Please select style or property first!';
 IDS_CANTDELDEFSTYLE='Cannot delete default style!';
 IDS_CANTMOVEDEFSTYLE='Cannot move default style!';
 IDS_DELSTYLEQUERY='Delete style '#39'%s'#39'?';
 IDS_DELPROPPQUERY='Delete property '#39'%s'#39'?';
 IDS_STATESUBSTYLINGNOTALLOWED='State style cannot have state style ancestors!';
 IDS_SAMESTYLENAMENOTALLOWED='Style cannot have ancestor style with the same name!';
 IDS_INVALIDSTYLEANCESTOR='Style '#39'%s'#39' cannot be inherited from style '#39'%s'#39', because class '#39'%s'#39' not inherited from class '#39'%s'#39'!';
 IDS_CANTMOVEUNDEFINEDPROPERTY='Cannot move property with undefined value!';
 IDS_INVALIDCLASSFORDEFSTYLE='Cannot create default style for non-TComponent descendants!';
 IDS_STATESTYLECANTHAVESUBSTYLES='State style cannot have substyles!';
 IDS_CANTFINDCOMPONENTCLASS='Cannot find component class '#39'%s'#39'!';
 IDS_CANTMOVESTYLETOSUBSTYLE='Cannot move style into its own substyle!';
 IDS_SELECTCOMPONENT='Please select component class first!'; 

implementation

end.
