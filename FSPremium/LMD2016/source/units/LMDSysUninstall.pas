unit LMDSysUninstall;
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

LMDSysUninstall unit (JH)
-------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDSysBaseComponent,
  LMDSysUninstallInfo;
type
  { ************************************************************************** }
  TLMDSysUninstall = class(TLMDSysBaseComponent)
  private
    FUninstall: TLMDUninstallInfo;
    procedure SetUninstall(const Value: TLMDUninstallInfo);
  protected
    procedure RefreshIt; override;  
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function GetElement(index : integer) : TObject;  override;
  published
    property Uninstall: TLMDUninstallInfo read FUninstall write SetUninstall stored false;
    property SysLog;
  end;

implementation

{ **************************** TLMDSysUninstall ********************************** }
{ ------------------------------- private ------------------------------------ }

procedure TLMDSysUninstall.SetUninstall(const Value: TLMDUninstallInfo);
begin
  FUninstall.Assign(Value);
end;

{ ----------------------------- protected ------------------------------------ }
procedure TLMDSysUninstall.RefreshIt;
begin
  FUninstall.Refresh;
end;

{ ------------------------------- public ------------------------------------- }

constructor TLMDSysUninstall.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  //  FSysObject := TLMDUninstallInfo.Create(Self);
  //  InitSysObject;
  FUninstall:= TLMDUninstallInfo.Create(Self);
  //FUninstall.Refresh;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysUninstall.Destroy;
begin
  FUninstall.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDSysUninstall.GetElement(index: integer): TObject;
begin
  result:=FUnInstall;
end;

end.
