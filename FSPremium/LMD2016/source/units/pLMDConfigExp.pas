unit pLMDConfigExp;
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

pLMDConfigExp unit (RM)
-----------------------
Common settings for all LMD VCL packages.

Changes
-------
Release 9.0 (April 2008)
 - Initial Release

###############################################################################}

interface

uses
  ToolsAPI, Classes, Controls, Forms, Windows, Messages, Menus, Dialogs;

type

  {************************ class TLMDConfigExpert **************************}
  TLMDConfigExpert = class(TNotifierObject, IOTAWizard)
  private
    FSeparatorItem: TMenuItem;
    FConfigItem:    TMenuItem;
    procedure CreateMenuItems;
    procedure ConfigItemClick(Sender: TObject);
    function GetNTAServices: INTAServices;
  protected
    function  GetIDString: string;
    function  GetName: string;
    function  GetState: TWizardState;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute;
  end;

implementation
uses
  SysUtils,
  pLMDConfigDlg{$IFNDEF LMDCOMP22};{$ELSE}, LMDProcs, pLMDCst, LMDStrings, Registry;{$ENDIF}

{*************************** class TLMDConfigExpert ***************************}
{ --------------------------------- private ---------------------------------- }
procedure TLMDConfigExpert.ConfigItemClick(Sender: TObject);
begin
  Execute
end;

{ ---------------------------------------------------------------------------- }
function TLMDConfigExpert.GetNTAServices: INTAServices;
begin
  Result := (BorlandIDEServices as INTAServices);
end;

{------------------------------------------------------------------------------}
procedure TLMDConfigExpert.CreateMenuItems;
var
  i,
  toolsindex: Integer;
  mainMenu  : TMainMenu;
  toolsItem : TMenuItem;
begin
  mainMenu := GetNTAServices.MainMenu;

  // find toolsmenu
  toolsItem  := nil;
  for i := mainMenu.Items.Count - 1 downto 0 do
    if mainMenu.Items[i].Name = 'ToolsMenu' then
      begin
        toolsItem  := mainMenu.Items[i];
        Break;
      end;
  if not Assigned(toolsItem) then exit;  // tools menu not found

  toolsIndex := 0;
  for i := toolsItem.Count - 1 downto 0 do
    if toolsItem.Items[i].Name = 'ToolsToolsItem' then
      begin
        toolsIndex := i;
        break;
      end;

  FConfigItem := TMenuItem.Create(nil);
  FConfigItem.Caption := 'Configure LMD VCL Options...';
  FConfigItem.Name := 'LMDVCLOptionsMenuItem';
  FConfigItem.OnClick := ConfigItemClick;
  toolsItem.Insert(toolsIndex, FConfigItem);

  FSeparatorItem := TMenuItem.Create(nil);
  FSeparatorItem.Name := 'LMDVCLSeparator';
  FSeparatorItem.Caption := '-';
  toolsItem.Insert(toolsIndex+1, FSeparatorItem);
end;

{ -------------------------------- protected --------------------------------- }
function TLMDConfigExpert.GetIDString: string;
begin
  Result := 'LMDInnovative.Common.Configuration';
end;

{ ---------------------------------------------------------------------------- }
function TLMDConfigExpert.GetName: string;
begin
  Result:= 'LMD VCL Configuration';
end;

{ ---------------------------------------------------------------------------- }
function TLMDConfigExpert.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDConfigExpert.Create;
begin
  inherited;
  CreateMenuItems;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDConfigExpert.Destroy;
begin
  FreeAndNil(FSeparatorItem);
  FreeAndNil(FConfigItem);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDConfigExpert.Execute;
begin
  with TLMDConfigDlg.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end
end;

{$IFDEF LMDCOMP22}
type

  TLMDHelpMenuEntries = class
  private
    FMenues: array[TLMDHelpfile] of TMenuItem;
    FHelpPath: string;
  protected
    procedure CreateMenuItems;
    procedure HandleClick(Sender:TObject);
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  LMDHelpMenuEntries:   TLMDHelpMenuEntries = nil;

{ --------------------------------- private ---------------------------------- }


{ --------------------------------- protected -------------------------------- }
procedure TLMDHelpMenuEntries.HandleClick(Sender:TObject);
begin
  if Sender is TComponent then
    LMDExecute('open', FHelpPath + LMDHelpFiles[TLMDHelpfile(TMenuItem(Sender).Tag)].FileName);
end;

{------------------------------------------------------------------------------}
procedure TLMDHelpMenuEntries.CreateMenuItems;
var
  NTAServices: INTAServices;
  i: TLMDHelpfile;
begin
  if Supports(BorlandIDEServices, INTAServices, NTAServices) then
  try
    with TRegIniFile.Create(LMDREGROOTDIR) do
    try
      FHelpPath := ReadString('', 'RootDir', '');
    finally
      Free;
    end;
    if FHelpPath = '' then exit;

    FHelpPath := LMDSlashAdd(FHelpPath)+ 'Help\Doc\';

    for I := Low(TLMDHelpfile) to High(TLMDHelpfile) do
    begin
      if FileExists(FHelpPath + LMDHelpFiles[i].FileName) then
      begin
        FMenues[i] := TMenuItem.Create(nil);
        FMenues[i].Caption :=  LMDHelpFiles[i].Caption;
        FMenues[i].ImageIndex := 16;
        FMenues[i].Tag := Ord(i);
        FMenues[i].OnClick := HandleClick;
        NTAServices.AddActionMenu('HelpThirdPartyMenuItem', nil, FMenues[i], True, True);
      end;
    end;
  except
  end;
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDHelpMenuEntries.Create;
var
  i: TLMDHelpfile;
begin
  inherited;
  for I := Low(TLMDHelpfile) to High(TLMDHelpfile) do FMenues[i] := nil;
  CreateMenuItems;
end;

{------------------------------------------------------------------------------}
destructor TLMDHelpMenuEntries.Destroy;
var
  i: TLMDHelpfile;
begin
  for I := Low(TLMDHelpfile) to High(TLMDHelpfile) do
    if Assigned(FMenues[i]) then FMenues[i].Free;
  inherited;
end;

initialization
  LMDHelpMenuEntries := TLMDHelpMenuEntries.Create;

finalization
  FreeAndNil(LMDHelpMenuEntries);
{$ENDIF}
end.
