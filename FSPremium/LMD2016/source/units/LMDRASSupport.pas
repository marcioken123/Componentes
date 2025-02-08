unit LMDRASSupport;
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

LMDRASSupport unit (DD)
-----------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, SysUtils, LMDURLSupp, LMDRAS, Registry, LMDRASCF;

const
  RAS_DEFAULT_KEY = '\RemoteAccess';
  RAS_DEFAULT_VALUE = 'InternetProfile';

function RASConnect(IO: TLMDInternetOptions): Boolean;
function RASDisconnect: Boolean;

implementation

function RASConnect(IO: TLMDInternetOptions): Boolean;
var
  szConnection: String;
  Reg: TRegistry;
  RCF: TLMDRASConnectionForm;
begin
  Result := IsRASExist;
  if Result then
    begin
      if IO.UseIEDUNSettings or (IO.DUN = '') then
        begin
          Reg:= TRegistry.Create(KEY_READ);
          try
            szConnection:= '';
            if Reg.OpenKey(RAS_DEFAULT_KEY, False) then
              szConnection := Reg.ReadString(RAS_DEFAULT_VALUE);
          finally
            Reg.Free;
          end;
        end
      else
        szConnection:= IO.DUN;
      if szConnection <> '' then
        begin
          RCF:= TLMDRASConnectionForm.Create(nil);
          RCF.szConnection:= szConnection;
          RCF.ShowModal;
          RCF.Free;
        end;
    end;
end;

function RASDisconnect: Boolean;
var
  DU: TLMDRAS;
begin
  Result := IsRASExist;
  if Result then
  begin
    DU := TLMDRAS.Create(nil);
    try
      if DU.IsConnected then DU.HangUp;
    finally
      FreeAndNil(DU);
    end;
  end;
end;

end.
