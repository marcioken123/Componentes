unit LMDQueue;
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

LMDQueue unit ()
----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDDynFIFOBuffer;

type
  TLMDQueue = class(TLMDDynFIFOBuffer)
  public
    procedure enQueue (item : TObject); virtual;
    procedure deQueue;
//    function front : Pointer;
    function extractFront : TObject;
  end;

implementation

procedure TLMDQueue.enQueue (item : TObject);
begin
  Put (item);
end;

procedure TLMDQueue.deQueue;
begin
  Get;
end;

function TLMDQueue.extractFront : TObject;
begin
  result := Get;
end;

end.
