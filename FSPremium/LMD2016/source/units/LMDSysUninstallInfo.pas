unit LMDSysUninstallInfo;
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

LMDSysUninstallInfo unit (JH)
----------------------------
TLMDUninstallItem - collection item for holding info about a installed program
TLMDUninstallInfo - collection of all available installed programs

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

{
  ##############################################################################
  # Author: LMD Innovative ()
  # Created: October 2000
  # Description: TLMDUninstallItem - collection item for holding info about a
  #                                installed progra,
  #              TLMDUninstallInfo - collection of all available installed
  #                                programs
  # State: developing
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

uses
  Windows,
  Classes,
  LMDSysObject,
  LMDSysLogStrings, LMDSysBase;

type
  { ************************************************************************** }
  TLMDUninstallItem = class(TLMDSysCollectionItem)
  private
    FregProgramName: string;
    FProgramName: string;
    FRegOwner: string;
    FHelpLink: string;
    FPublisherURL: string;
    FRegCompany: string;
    FPublisher: string;
    FVersion: string;
    FUninstallPath: string;
    FUpdateInfoURL: string;
    procedure SetString(aIndex: LongInt; const aValue: string);
  protected
    procedure RegisterProperties; override;
    function GetDisplayName: string; override;
  public
    procedure Refresh;
    procedure Apply; override;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property ProgramName: string index 0 read FProgramName write SetString stored false;
    property UninstallPath: string index 1 read FUninstallPath write SetString stored false;
    property Publisher: string index 2 read FPublisher write SetString stored false;
    property PublisherURL: string index 3 read FPublisherURL write SetString stored false;
    property Version: string index 4 read FVersion write SetString stored false;
    property HelpLink: string index 5 read FHelpLink write SetString stored false;
    property UpdateInfoURL: string index 6 read FUpdateInfoURL write SetString stored false;
    property RegCompany: string index 7 read FRegCompany write SetString stored false;
    property RegOwner: string index 8 read FRegOwner write SetString stored false;
  end;

  { ************************************************************************** }
  TLMDUninstallInfo = class(TLMDSysCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TLMDUninstallItem;
    procedure SetItem(Index: Integer; Value: TLMDUninstallItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDUninstallItem;
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;

    procedure Refresh;

    function GetElementTitle : string;  override;
    function GetElementDescription : string;  override;
    function GetElementType : TLMDSysInfoType; override;

    property Items[Index: Integer]: TLMDUninstallItem read GetItem write SetItem; default;
  end;

implementation

uses
  Registry, LMDSysConst;

const
  cpidProgramName = 0;
  cpidUninstallPath = 1;
  cpidPublisher = 2;
  cpidPublisherURL = 3;
  cpidVersion = 4;
  cpidHelpLink = 5;
  cpidUpdateInfoURL = 6;
  cpidRegCompany = 7;
  cpidRegOwner = 8;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }

procedure TLMDUninstallItem.SetString(aIndex: LongInt; const aValue: string);
begin
  case aIndex of
    0:
      if FProgramName <> aValue then
        begin
          RememberChange(strUninstallProgramName, FProgramName, aValue);
          FProgramName:= aValue;
        end;
    1:
      if FUninstallPath <> aValue then
        begin
          RememberChange(strUninstallUninstallPath, FUninstallPath, aValue);
          FUninstallPath:= aValue;
        end;
    2:
      if FPublisher <> aValue then
        begin
          RememberChange(strUninstallPublisher, FPublisher, aValue);
          FPublisher:= aValue;
        end;
    3:
      if FPublisherURL <> aValue then
        begin
          RememberChange(strUninstallPublisherURL, FPublisherURL, aValue);
          FPublisherURL:= aValue;
        end;
    4:
      if FVersion <> aValue then
        begin
          RememberChange(strUninstallVersion, FVersion, aValue);
          FVersion:= aValue;
        end;
    5:
      if FHelpLink <> aValue then
        begin
          RememberChange(strUninstallHelpLink, FHelpLink, aValue);
          FHelpLink:= aValue;
        end;
    6:
      if FUpdateInfoURL <> aValue then
        begin
          RememberChange(strUninstallUpdateInfoURL, FUpdateInfoURL, aValue);
          FUpdateInfoURL:= aValue;
        end;
    7:
      if FRegCompany <> aValue then
        begin
          RememberChange(strUninstallRegCompany, FRegCompany, aValue);
          FRegCompany:= aValue;
        end;
    8:
      if FRegOwner <> aValue then
        begin
          RememberChange(strUninstallRegOwner, FRegOwner, aValue);
          FRegOwner:= aValue;
        end;
  end;
end;

{ -------------------------- proteceted -------------------------------------- }

function TLMDUninstallItem.GetDisplayName: string;
begin
  Result:= FProgramName;
end;

procedure TLMDUninstallItem.RegisterProperties;
begin
  inherited;

  FPropertiesDesc.Add(cpidProgramName, sLMDSysUninstallPropTitleProgramName, sLMDSysUninstallPropDescProgramName);
  FPropertiesDesc.Add(cpidUninstallPath, sLMDSysUninstallPropTitleUninstallPath, sLMDSysUninstallPropDescUninstallPath);
  FPropertiesDesc.Add(cpidPublisher, sLMDSysUninstallPropTitlePublisher, sLMDSysUninstallPropDescPublisher);
  FPropertiesDesc.Add(cpidPublisherURL, sLMDSysUninstallPropTitlePublisherURL, sLMDSysUninstallPropDescPublisherURL);
  FPropertiesDesc.Add(cpidVersion, sLMDSysUninstallPropTitleVersion, sLMDSysUninstallPropDescVersion);
  FPropertiesDesc.Add(cpidHelpLink, sLMDSysUninstallPropTitleHelpLink, sLMDSysUninstallPropDescHelpLink);
  FPropertiesDesc.Add(cpidUpdateInfoURL, sLMDSysUninstallPropTitleUpdateInfoURL, sLMDSysUninstallPropDescUpdateInfoURL);
  FPropertiesDesc.Add(cpidRegCompany, sLMDSysUninstallPropTitleRegCompany, sLMDSysUninstallPropDescRegCompany);
  FPropertiesDesc.Add(cpidRegOwner, sLMDSysUninstallPropTitleRegOwner, sLMDSysUninstallPropDescRegOwner);
end;

{ -------------------------- public ------------------------------------------ }
procedure TLMDUninstallItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;
  FPropertiesDesc.PropertyByID(cpidProgramName).Text := FProgramName;
  FPropertiesDesc.PropertyByID(cpidUninstallPath).Text := FUninstallPath;
  FPropertiesDesc.PropertyByID(cpidPublisher).Text := FPublisher;
  FPropertiesDesc.PropertyByID(cpidPublisherURL).Text := FPublisherURL;
  FPropertiesDesc.PropertyByID(cpidVersion).Text := FVersion;
  FPropertiesDesc.PropertyByID(cpidHelpLink).Text := FHelpLink;
  FPropertiesDesc.PropertyByID(cpidUpdateInfoURL).Text := FUpdateInfoURL;
  FPropertiesDesc.PropertyByID(cpidRegCompany).Text := FRegCompany;
  FPropertiesDesc.PropertyByID(cpidRegOwner).Text := FRegOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUninstallItem.GetElementTitle : string;
begin
  result := sLMDSysUninstallGroupTitle + ' ['+ProgramName+']';
end;

{ ---------------------------------------------------------------------------- }
function TLMDUninstallItem.GetElementDescription : string;
begin
  result := sLMDSysUninstallGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUninstallItem.GetElementType : TLMDSysInfoType;
begin
  result := itUninstallItem;
end;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }
function TLMDUninstallInfo.GetItem(Index: Integer): TLMDUninstallItem;
begin
  Result:= TLMDUninstallItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUninstallInfo.SetItem(Index: Integer; Value: TLMDUninstallItem);
begin
  inherited SetItem(Index, Value);
end;

{ -------------------------- protected --------------------------------------- }
function TLMDUninstallInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ -------------------------- public ------------------------------------------ }
function TLMDUninstallInfo.Add: TLMDUninstallItem;
begin
  Result:= TLMDUninstallItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDUninstallInfo.Create(aOwner: TComponent);
begin
  inherited Create(TLMDUninstallItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDUninstallInfo.Destroy;
begin
  FOwner:= nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDUninstallInfo.Refresh;
var
  R: TRegistry;
  S: TStringList;
  I: LongInt;
begin
  Clear;
DoProgress(sLMDSysUninstallGroupTitle, 100, 0);
  R:= TRegistry.Create;
  S:= TStringList.Create;
  try
    R.RootKey:= HKEY_LOCAL_MACHINE;
    R.OpenKeyReadOnly('\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall');
    R.GetKeyNames(S);
    for I:= 0 to S.Count - 1 do
      begin
        DoProgress(sLMDSysUninstallGroupTitle, 100, Round(i*100/s.count));
        if R.OpenKeyReadOnly('\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + S[I]) then
          if R.ValueExists('DisplayName') and R.ValueExists('UninstallString') then
            begin
              with Add do
                begin
                  FregProgramName:= S[I];
                  FProgramName:= R.ReadString('DisplayName');
                  FUninstallPath:= R.ReadString('UninstallString');
                  if R.ValueExists('Publisher') then
                    FPublisher:= R.ReadString('Publisher');
                  if R.ValueExists('URLInfoAbout') then
                    FPublisherURL:= R.ReadString('URLInfoAbout');
                  if R.ValueExists('DisplayVersion') then
                    FVersion:= R.ReadString('DisplayVersion');
                  if R.ValueExists('HelpLink') then
                    FHelpLink:= R.ReadString('HelpLink');
                  if R.ValueExists('URLUpdateInfo') then
                    FUpdateInfoURL:= R.ReadString('URLUpdateInfo');
                  if R.ValueExists('RegCompany') then
                    FRegCompany:= R.ReadString('RegCompany');
                  if R.ValueExists('RegOwner') then
                    FRegOwner:= R.ReadString('RegOwner');
                  Refresh;
                end;
            end;
      end;
  finally
    R.Free;
    S.Free;
  end;
DoProgress('', 100, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDUninstallItem.Apply;
var
  R: TRegistry;
begin
  R:= TRegistry.Create;
  try
    R.RootKey:= HKEY_LOCAL_MACHINE;
    R.OpenKeyReadOnly('\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall');
    if R.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + FregProgramName, false) then
      begin
        if PropChanged(strUninstallProgramName) then
          begin
            WriteToLog(strUninstallProgramName);
            R.WriteString('DisplayName', FProgramName);
          end;
        if PropChanged(strUninstallUninstallPath) then
          begin
            WriteToLog(strUninstallUninstallPath);
            R.WriteString('UninstallString', FUninstallPath);
          end;
        if PropChanged(strUninstallPublisher) then
          begin
            WriteToLog(strUninstallPublisher);
            R.WriteString('Publisher', FPublisher);
          end;
        if PropChanged(strUninstallPublisherURL) then
          begin
            WriteToLog(strUninstallPublisherURL);
            R.WriteString('URLInfoAbout', FPublisherURL);
          end;
        if PropChanged(strUninstallVersion) then
          begin
            WriteToLog(strUninstallVersion);
            R.WriteString('DisplayVersion', FVersion);
          end;
        if PropChanged(strUninstallHelpLink) then
          begin
            WriteToLog(strUninstallHelpLink);
            R.WriteString('HelpLink', FHelpLink);
          end;
        if PropChanged(strUninstallUpdateInfoURL) then
          begin
            WriteToLog(strUninstallUpdateInfoURL);
            R.WriteString('URLUpdateInfo', FUpdateInfoURL);
          end;
        if PropChanged(strUninstallRegCompany) then
          begin
            WriteToLog(strUninstallRegCompany);
            R.WriteString('RegCompany', FRegCompany);
          end;
        if PropChanged(strUninstallRegOwner) then
          begin
            WriteToLog(strUninstallRegOwner);
            R.WriteString('RegOwner', FRegOwner);
          end;
      end;
  finally
    R.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUninstallInfo.GetElementTitle : string;
begin
  result := sLMDSysUninstallGroupTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUninstallInfo.GetElementDescription : string;
begin
  result := sLMDSysUninstallGroupDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUninstallInfo.GetElementType : TLMDSysInfoType;
begin
  result := itUninstallGroup;
end;

end.
