unit LMDSysDrive;
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

LMDSysDrive unit (JH)
--------------------
Component which will display information about one of the system drives in the drive object

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDSysBaseComponent,
  LMDSysDriveObject, LMDSysDriveInfo, LMDSysBase;

type
  { ************************************************************************** }
  TLMDSysDrive = class(TLMDSysBaseComponent)
  private
    function GetObj: TLMDSysDriveObject;
    procedure SetObj(aValue: TLMDSysDriveObject);
  public
    constructor Create(aOwner: TComponent); override;
  published
    property Drive: TLMDSysDriveObject read GetObj write SetObj stored false;
  end;

  { ************************************************************************** }
  TLMDSysDrives = class(TLMDSysBaseComponent)
  private
    FDrives : TLMDSysDrivesInfo;
    procedure SetDrives(const Value: TLMDSysDrivesInfo);
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
    property Drives: TLMDSysDrivesInfo read FDrives write SetDrives stored false;
  end;

implementation
uses
  LMDSysConst;
{ **************************** TLMDSysDrive ********************************** }
{ ------------------------------- private ------------------------------------ }

function TLMDSysDrive.GetObj: TLMDSysDriveObject;
begin
  Result:= TLMDSysDriveObject(FSysObject);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDrive.SetObj(aValue: TLMDSysDriveObject);
begin
end;

{ ------------------------------- public ------------------------------------- }

constructor TLMDSysDrive.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FSysObject:= TLMDSysDriveObject.Create;
  InitSysObject;
end;
{ **************************** TLMDSysDrives ********************************* }
{ ------------------------------- private ------------------------------------ }
procedure TLMDSysDrives.SetDrives(const Value: TLMDSysDrivesInfo);
begin
  FDrives.Assign(Value);
end;

{ ------------------------------- protected ---------------------------------- }
procedure TLMDSysDrives.RefreshIt;
begin
  FDrives.Refresh;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDSysDrives.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FDrives:= TLMDSysDrivesInfo.Create(Self);
  FDrives.OnChangeLog:= DoLog;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysDrives.Destroy;
begin
  FDrives.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDrives.GetElementCount : integer;
begin
  result := 1;
end;

{------------------------------------------------------------------------------}
function TLMDSysDrives.GetElement(index : integer) : TObject;
begin
  result := TObject(FDrives);
end;

{------------------------------------------------------------------------------}
function TLMDSysDrives.GetElementTitle : string;
begin
  result := cLMDSysInfoTitle;
end;

{------------------------------------------------------------------------------}
function TLMDSysDrives.GetElementDescription : string;
begin
  result := cLMDSysInfoDesc;
end;

{------------------------------------------------------------------------------}
function TLMDSysDrives.GetElementType : TLMDSysInfoType;
begin
  result := itSystemInfoGroup;
end;

end.
