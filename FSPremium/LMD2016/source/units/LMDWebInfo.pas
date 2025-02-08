unit LMDWebInfo;
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

LMDWebInfo unit (DD)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDWebbase
  ;
type
  TLMDWebInfo = class(TLMDWebComponent)
  private
    FModem: Boolean;
    function GetHostIP: String;
    function GetHostName_: String;
    function GetOnline: Boolean;
    procedure SetModem(const Value: Boolean);
  public
    property HostIP: String read GetHostIP;
    property HostName: String read GetHostName_;
    property Online: Boolean read GetOnline;
  published
    property Modem: Boolean read FModem write SetModem default false;
  end;

const
  MAXHOSTNAMELEN = 63;

implementation

uses
  WinSock, SysUtils,
  LMDURLSupp;

function TLMDWebInfo.GetHostIP: String;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe : PHostEnt;
  pptr: PaPInAddr;
  Buffer: array [0..MAXHOSTNAMELEN] of char;
  I: Integer;
  GInitData: TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(@Buffer, SizeOf(Buffer));
  phe := GetHostByName(@buffer);
  if phe = nil then Exit;
  pptr := PaPInAddr(Phe^.h_addr_list);
  I := 0;
  while pptr^[I] <> nil do begin
    result := String(StrPas(inet_ntoa(pptr^[I]^)));
    Inc(I);
  end;
  WSACleanup;
end;

function TLMDWebInfo.GetHostName_: String;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  Buffer: array [0..MAXHOSTNAMELEN] of char;
  GInitData: TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(@Buffer, SizeOf(Buffer));
  Result := StrPas(Buffer);
  WSACleanup;
end;

function TLMDWebInfo.GetOnline: Boolean;
begin
  Result := CheckInetConnected(FModem);
end;

procedure TLMDWebInfo.SetModem(const Value: Boolean);
begin
  FModem := Value;
end;

end.
