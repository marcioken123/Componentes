unit LMDSctExpertUnit;
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

LMDSctExpertUnit unit (YB)
--------------------------
LMD Script Pack Importer Delphi IDE expert.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Graphics, Forms, Windows, Messages, Menus, Dialogs,
  StrUtils, DesignIntf, ToolsApi, Registry, LMDTypes, LMDSctUnitFrame,
  LMDSctEmbeddedView, LMDSctFloatingView, LMDSctBatchFrame;

type
  {************************ class TLMDImporterExpert **************************}

  TLMDImporterExpert = class
  private
    {$IFDEF LMDCOMP14}
    FView:          Pointer;
    {$ENDIF}
    FSeparatorItem: TMenuItem;
    FWizardItem:    TMenuItem;
    FBatchItem:     TMenuItem;
    FMainItem:      TMenuItem;

    procedure InitMenuItems;
    {$IFNDEF LMDCOMP14}
    procedure WizardMenuItemClick(Sender: TObject);
    {$ENDIF}
    procedure BatchMenuItemClick(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;

    class function  EditorFromModule(const AModule: IOTAModule): IOTASourceEditor;
    class function  GetCurrentEditor: IOTASourceEditor;
    class procedure Register;
  end;

implementation

uses
  SysUtils, LMDSctCst;

var
  Expert: TLMDImporterExpert;

{************************* class TLMDImporterExpert ***************************}
{ --------------------------------- private ---------------------------------- }

{$IFNDEF LMDCOMP14}
procedure TLMDImporterExpert.WizardMenuItemClick(Sender: TObject);
var
  edtr:   IOTASourceEditor;
  untfrm: TLMDUnitFrame;
  form:   TForm;
begin
  edtr := GetCurrentEditor;

  if edtr <> nil then
  begin
    untfrm := TLMDUnitFrame.GetWizard(edtr);
    form   := TLMDUnitFloatingView.GetView(untfrm);

    form.Show;
    untfrm.QueryInitialParse;
  end
  else
    MessageDlg(SLMDNoOpenedUnit, mtInformation, [mbOk], 0);
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

procedure TLMDImporterExpert.InitMenuItems;
var
  toolsIndex,
  i:          Integer;
  mainMenu:   TMainMenu;
  toolsFound: Boolean;
  toolsItem:  TMenuItem;
begin
  mainMenu := (BorlandIDEServices as INTAServices).MainMenu;

  toolsFound := False;
  toolsItem  := nil;
  FMainItem  := nil;

  for i := mainMenu.Items.Count - 1 downto 0 do
    if mainMenu.Items[i].Name = 'ToolsMenu' then
    begin
      toolsItem  := mainMenu.Items[i];
      toolsFound := True;

      Break;
    end;

  if not toolsFound then
  begin
    FMainItem         := TMenuItem.Create(mainMenu);
    FMainItem.Caption := 'LMD Script';
    mainMenu.Items.Insert(mainMenu.Items.Count - 2, FMainItem);

    toolsItem  := FMainItem;
    toolsIndex := 0;
  end
  else
  begin
    toolsIndex := 0;

    for i := toolsItem.Count - 1 downto 0 do
      if toolsItem.Items[i].Name = 'LMDVCLSeparator' then
      begin
        toolsIndex := i;
        Break;
      end;

    if toolsIndex = 0 then
      for i := toolsItem.Count - 1 downto 0 do
        if toolsItem.Items[i].Name = 'ToolsToolsItem' then
        begin
          toolsIndex := i;
          Break;
        end;
  end;

  FBatchItem := TMenuItem.Create(nil);
  FBatchItem.Caption := 'LMD-ScriptPack Batch Import...';
  FBatchItem.OnClick := BatchMenuItemClick;
  toolsItem.Insert(toolsIndex, FBatchItem);

  {$IFNDEF LMDCOMP14}
  FWizardItem := TMenuItem.Create(nil);
  FWizardItem.Caption := 'LMD-ScriptPack Import Wizard...';
  FWizardItem.OnClick := WizardMenuItemClick;
  toolsItem.Insert(toolsIndex + 1 , FWizardItem);
  {$ENDIF}

  if toolsFound and (toolsIndex = 0) then
  begin
    FSeparatorItem := TMenuItem.Create(nil);
    FSeparatorItem.Caption := '-';
    toolsItem.Insert(2, FSeparatorItem);
  end;
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDImporterExpert.Register;
begin
  if Expert = nil then
    Expert := TLMDImporterExpert.Create;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDImporterExpert.GetCurrentEditor: IOTASourceEditor;
var
  mdsvs: IOTAModuleServices;
begin
  mdsvs  := BorlandIDEServices as IOTAModuleServices;
  Result := EditorFromModule(mdsvs.CurrentModule);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDImporterExpert.Create;
begin
  inherited;
  {$IFDEF LMDCOMP14}
  FView := (BorlandIDEServices as IOTAEditorViewServices).RegisterEditorSubView(
           TLMDUnitEmbeddedView.Create);
  {$ENDIF}
  InitMenuItems;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDImporterExpert.Destroy;
begin
  TLMDUnitFrame.CloseAllWizards;
  {$IFDEF LMDCOMP14}
  (BorlandIDEServices as IOTAEditorViewServices).UnregisterEditorSubView(FView);
  {$ENDIF}
  FSeparatorItem.Free;
  FWizardItem.Free;
  FBatchItem.Free;
  FMainItem.Free;
  inherited;
end;

class function TLMDImporterExpert.EditorFromModule(
  const AModule: IOTAModule): IOTASourceEditor;
var
  i:    Integer;
  edtr: IOTAEditor;
begin
  if AModule <> nil then
  begin
    for i := 0 to AModule.GetModuleFileCount - 1 do
    begin
      edtr := AModule.GetModuleFileEditor(i);

      if Supports(edtr, IOTASourceEditor, Result) and
         (AModule.FileSystem = '') and
         SameText(ExtractFileExt(edtr.FileName), '.pas') then
        Exit;
    end;
  end;

  Result := nil;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDImporterExpert.BatchMenuItemClick(Sender: TObject);
{$IFDEF LMDCOMP14}
var
  view: INTACustomEditorView;
{$ENDIF}
begin
  {$IFDEF LMDCOMP14}
  view := TLMDBatchEmbeddedView.Create;
  (BorlandIDEServices as IOTAEditorViewServices).ShowEditorView(view);
  {$ELSE}
  TLMDBatchFloatingView.Execute;
  {$ENDIF}
end;
                    
{ ---------------------------------------------------------------------------- }

initialization
  // Do nothing.

finalization
  FreeAndNil(Expert);

end.
