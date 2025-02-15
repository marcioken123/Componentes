unit LMDPrintResModule;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
� by LMD Innovative
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

LMDPrintResModule unit (VT)
---------------------------

Changes
-------
Release 8.0 (November 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList;

type
  TLMDPrintResDataModule = class(TDataModule)
    PrintToolbarImgList: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LMDPrintResDataModule: TLMDPrintResDataModule;

implementation

{$R *.DFM}

initialization
  LMDPrintResDataModule := TLMDPrintResDataModule.Create(nil);
finalization
  LMDPrintResDataModule.Free;
  LMDPrintResDataModule := nil;
end.
