unit pLMDSys_CE;
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

pLMDSys_CE unit (RM)
-------------------
Component editors for LMD SysPack

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  DesignIntf, DesignEditors, VCLEditors;
  type
  {----------------------------------------------------------------------------}
  TLMDSysNetComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

  {----------------------------------------------------------------------------}
  TLMDSystemComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation

uses
  LMDSysBaseComponent, LMDSysSystemInfo, pLMDSysNetEnumDlg, pLMDSysViewDlg, LMDSysNetworkEnumerator;

{********************* Class TLMDSysNetComponentEditor*************************}
{------------------------------------------------------------------------------}
procedure TLMDSysNetComponentEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: with TfrmLMDSysEnumDlg.Create(nil) do
         try
           nEnum.ResourceType:=TLMDSysNetworkEnumerator(Component).ResourceType;
           nEnum.Scope:=TLMDSysNetworkEnumerator(Component).Scope;
           nEnum.Usage:=TLMDSysNetworkEnumerator(Component).Usage;
           btnUpdateClick(nil);
           ShowModal;
         finally
           Free;
         end;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDSysNetComponentEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result:= 'Browse Network...';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSysNetComponentEditor.GetVerbCount: Integer;
begin
  Result:= 1;
end;

{********************* Class TLMDSystemComponentEditor ************************}
{------------------------------------------------------------------------------}
procedure TLMDSystemComponentEditor.ExecuteVerb(Index: Integer);
begin
  case index of
    0: (Component as TLMDSysBaseComponent).Refresh;
    1: begin
         (Component as TLMDSysBaseComponent).Refresh;
         with TfrmLMDSysViewDlg.Create(nil) do
           try
             lv.SysInfoControl:=(Component as TLMDSysBaseComponent);
             ShowModal;
           finally
             Free;
           end;
       end;
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDSystemComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result := 'Refresh';
    1: result := 'View Info';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSystemComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
  if not (Component is TLMDSysSystemInfo) then
    Inc(Result);
end;

end.
