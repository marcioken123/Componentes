unit LMDSysService;
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

LMDSysService unit (AH)
-----------------------


Changes
-------
Release 11.0 (August 2010)
 - Initial Release

###############################################################################}

interface

uses
  Classes, LMDSysBase, LMDSysBaseComponent, LMDSysServiceObject, LMDSysServiceInfo;

type
  { ************************************************************************** }
  TLMDSysService = class(TLMDSysBaseComponent)
  private
    function GetObj: TLMDSysServiceObject;
    procedure SetObj(aValue: TLMDSysServiceObject);
  public
    constructor Create(aOwner: TComponent); override;
  published
    property Service: TLMDSysServiceObject read GetObj write SetObj stored false;
  end;

  { ************************************************************************** }
  TLMDSysServices = class(TLMDSysBaseComponent)
  private
    FServices: TLMDSysServicesInfo;
    procedure SetServices(const Value: TLMDSysServicesInfo);
  protected
    procedure RefreshIt; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function GetElementCount : integer; override;
    function GetElement(index : integer) : TObject;  override;
    function GetElementTitle : string;  override;
    function GetElementDescription : string;  override;
    function GetElementType : TLMDSysInfoType;  override;
  published
    property Services: TLMDSysServicesInfo read FServices write SetServices stored false;
  end;

implementation

uses
  LMDSysConst;
{ **************************** TLMDSysDrive ********************************** }
{ ------------------------------- private ------------------------------------ }

function TLMDSysService.GetObj: TLMDSysServiceObject;
begin
  Result:= TLMDSysServiceObject(FSysObject);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysService.SetObj(aValue: TLMDSysServiceObject);
begin
end;

{ ------------------------------- public ------------------------------------- }

constructor TLMDSysService.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FSysObject:= TLMDSysServiceObject.Create;
  InitSysObject;
end;
{ **************************** TLMDSysServices ********************************* }
{ ------------------------------- private ------------------------------------ }
procedure TLMDSysServices.SetServices(const Value: TLMDSysServicesInfo);
begin
  FServices.Assign(Value);
end;

{ ------------------------------- protected ---------------------------------- }
procedure TLMDSysServices.RefreshIt;
begin
  FServices.Refresh;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDSysServices.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FServices:= TLMDSysServicesInfo.Create(Self);
  FServices.OnChangeLog:= DoLog;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysServices.Destroy;
begin
  FServices.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysServices.GetElementCount : integer;
begin
  result := 1;
end;

{------------------------------------------------------------------------------}
function TLMDSysServices.GetElement(index : integer) : TObject;
begin
  result := TObject(FServices);
end;

{------------------------------------------------------------------------------}
function TLMDSysServices.GetElementTitle : string;
begin
  result := cLMDSysInfoTitle;
end;

{------------------------------------------------------------------------------}
function TLMDSysServices.GetElementDescription : string;
begin
  result := cLMDSysInfoDesc;
end;

{------------------------------------------------------------------------------}
function TLMDSysServices.GetElementType : TLMDSysInfoType;
begin
  result := itSystemInfoGroup;
end;

end.
