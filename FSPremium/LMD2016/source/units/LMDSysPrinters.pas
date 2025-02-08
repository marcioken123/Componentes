unit LMDSysPrinters;
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

LMDSysPrinters unit (JH)
-----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDSysBaseComponent,
  LMDSysPrinterInfo;

type
  { ************************************************************************** }
  TLMDSysPrinters = class(TLMDSysBaseComponent)
  private
    FPrinters: TLMDPrintersInfo;
    FDisplayInfo: TLMDSysPrinterDisplayInfos;
    procedure SetPrinters(const Value: TLMDPrintersInfo);
    procedure SetDisplayInfo(const Value: TLMDSysPrinterDisplayInfos);
  protected
    procedure RefreshIt; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function GetElement(index : integer) : TObject;  override;
  published
    property Printers: TLMDPrintersInfo read FPrinters write SetPrinters stored false;
    property DisplayInfo:TLMDSysPrinterDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysPrinterDisplayInfos;
  end;

implementation

{ **************************** TLMDSysPrinters ********************************** }
{ ------------------------------- private ------------------------------------ }
procedure TLMDSysPrinters.SetPrinters(const Value: TLMDPrintersInfo);
begin
  FPrinters.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysPrinters.SetDisplayInfo(const Value: TLMDSysPrinterDisplayInfos);
begin
  if FDisplayInfo<>Value then
    begin
      FDisplayInfo := Value;
      if not ((csDesigning in ComponentState) or (csLoading in ComponentState)) then
        FPrinters.Refresh;
    end;
end;

{ ------------------------------- protected ---------------------------------- }
procedure TLMDSysPrinters.RefreshIt;
begin
  FPrinters.Refresh;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDSysPrinters.Create(aOwner: TComponent);
begin
  FDisplayInfo:=def_TLMDSysPrinterDisplayInfos;
  inherited Create(aOwner);
  FPrinters:= TLMDPrintersInfo.Create(Self);

  FPrinters.OnChangeLog:= DoLog;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysPrinters.Destroy;
begin
  FPrinters.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysPrinters.GetElement(index: integer): TObject;
begin
  result:=FPrinters;
end;

end.
