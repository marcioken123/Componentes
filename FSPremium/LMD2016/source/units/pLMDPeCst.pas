unit pLMDPeCst;
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

pLMDPeCst unit ()
-----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  // Path / Loading , Saving
  IDS_LOAD='&Load';
  IDS_SAVE='&Save';
  IDS_SAVEFILEAS='Save File as...';
  IDS_CLEAR='&Clear';
  IDS_ADD='&Add';
  IDS_REMOVE='&Remove';
  IDS_PATHS='Paths:';
  IDS_CLEARLIST='Clear &List';
  IDS_DELETELIST='Really delete List?';

  IDS_SAVEBMPAS='Save Bitmap-File as...';

  {TLMDWave}
  IDS_PLAY='&Play';
  IDS_ACTUALWAVE='Current Wave:';
  IDS_WAVECAPTION='Select Wave';
  IDS_WAVEFILTER='Wave-Files (*.wav)|*.wav';
  IDS_NOWAVESELECTED='No Wave-File selected';
  IDS_LOADLIST='Load List';
  IDS_SAVELIST='Save List';
  IDS_CHANGE='Chan&ge';
  IDS_UP='&Up';
  IDS_DOWN='&Down';

  {TLMDDialogs}
  IDS_TESTDIALOG='Test dialog...';
  IDS_HELPFILTER='Helpfiles (*.hlp)|*.hlp';
  IDS_HELPTITLE='Specify HelpFile';

  {Graphic- and PNGImage- List editors}
  IDS_CONFIRM = 'Confirm action';
  IDS_CONFIRMDELETE='Are you sure to delete all items from list?';

implementation

end.
