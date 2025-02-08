unit LMDSysModem;
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

LMDSysModem unit (JH)
---------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDSysBaseComponent, LMDSysModemInfo;

type
  { ************************************************************************** }
  TLMDSysModem = class(TLMDSysBaseComponent)
  private
    FDisplayInfo:TLMDSysModemDisplayInfos;
    FModems: TLMDModemInfo;
    procedure SetModem(const Value: TLMDModemInfo);
    procedure SetDisplayInfo(const Value: TLMDSysModemDisplayInfos);
  protected
    procedure RefreshIt; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function GetElement(index : integer) : TObject;  override;
  published
    property Modems: TLMDModemInfo read FModems write SetModem stored false;
    property DisplayInfo:TLMDSysModemDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysModemDisplayInfos;
    property SysLog;
  end;

implementation

{ **************************** TLMDSysModem ********************************** }
{ ------------------------------- private ------------------------------------ }
procedure TLMDSysModem.SetModem(const Value: TLMDModemInfo);
begin
  FModems.Assign(Value);
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDSysModem.RefreshIt;
begin
  FModems.Refresh;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDSysModem.Create(aOwner: TComponent);
begin
  FDisplayInfo:=def_TLMDSysModemDisplayInfos;
  inherited Create(aOwner);
  //  FSysObject := TLMDModemInfo.Create(Self);
  //  InitSysObject;
  FModems:= TLMDModemInfo.Create(Self);
  FModems.OnChangeLog:= DoLog;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysModem.Destroy;
begin
  FModems.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDSysModem.GetElement(index: integer): TObject;
begin
  result:=FModems;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysModem.SetDisplayInfo(const Value: TLMDSysModemDisplayInfos);
begin
  if FDisplayInfo<>Value then
    begin
      FDisplayInfo := Value;
      if not ((csDesigning in ComponentState) or (csLoading in ComponentState)) then
        FModems.Refresh;
    end;
end;

end.
