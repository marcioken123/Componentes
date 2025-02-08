unit LMD_RegShell;
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

LMD-Tools ShellPack registration unit (RM)
-----------------------------------------
Registers components and editors for LMD ShellPack controls set.


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, ActnList,
  DesignIntf, DesignEditors,
  LMDShFolder, LMDShList, LMDShTree, LMDShCombo, LMDShDlg, LMDShBrwDlg, LMDShListDlg,
  LMDShListFilterDlg, LMDShLink, LMDShFavMenu, LMDShNtf, LMDShBase, LMDShDriveListBox,
  LMDShPathDlg, pLMDShRootEdit, LMDShActions, LMDShMisc, //LMDShellDrivePanel,
  // 4.0 --> Moved from LMD-Tools
  LMDVersionInfo, LMDStarter, LMDFileCtrl, LMDFileGrep,
  // New
  LMDShConsoleView,
  pLMDCommon
  {$IFDEF LMDCOMP17}, System.Actions{$ENDIF};

procedure Register;

implementation

uses
  LMDShConsts, LMDShUtils,
  pLMDCPGetBase, pLMDGlobalEditors;

type

  {----------------------  Class TLMDShellDlgEditor ---------------------------}
  TLMDShellDlgEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDStarterEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{********************* Class TLMDShellDlgEditor ********************************}
{------------------------------------------------------------------------------}
procedure TLMDShellDlgEditor.ExecuteVerb(Index: Integer);
begin
  case index of
    0 : TLMDShellBaseDialog(Component).Execute;
  end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDShellDlgEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result := 'Test Dialog';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShellDlgEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* Class TLMDStarterEditor ********************************}
{------------------------------------------------------------------------------}
procedure TLMDStarterEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDStarter (component) do
    case index of
      0 : AutoStart := (Autostart = false);
      1 : if not LMDCPGetDateTime (StartTime) then exit;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDStarterEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result:='Autostart' + BoolStr[TLMDStarter(Component).Autostart];
    1: Result:='StartTime';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDStarterEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

// Register Routine
{------------------------------------------------------------------------------}
procedure Register;
begin
  RegisterComponents('LMD Shell', [
                                   // Explorer Controls
                                   TLMDShellFolder,
                                   TLMDShellTree,
                                   TLMDShellList,
                                   TLMDShellListDialog,
                                   TLMDShellListFilterDialog,
                                   TLMDShellComboBox,

                                   // General Controls
                                   TLMDShellDriveListBox,
                                   TLMDShellLink,
                                   TLMDShellNotify,
                                   TLMDShellConsoleView,

                                   // from LMD-Tools
                                   TLMDFileGrep,
                                   TLMDFileCtrl,
                                   TLMDVersionInfo,
                                   TLMDStarter,
				  				   TLMDStarterExt,

                                   //IE Favorites support controls
                                   TLMDShellAddFavoritesDialog,
                                   TLMDShellFavoritesDialog,
                                   TLMDShellFavoritesMenu,

                                   // LMD Dialogs
                                   TLMDShellPathDialog,
                                   TLMDShellBrowseDialog,

                                   // Shell Dialogs
                                   TLMDShellAboutDialog,
                                   TLMDShellAppletLoader,
                                   TLMDShellFormatDriveDialog,
                                   TLMDShellFindDialog,
                                   TLMDShellNetConnectionDialog,
                                   TLMDShellObjectPropertiesDialog,
                                   TLMDShellPickIconDialog,
                                   TLMDShellRunFileDialog,
                                   TLMDShellRestartDialog,
                                   TLMDShellSysBrowseDialog
                                   //TLMDShellDrivePanel
                                   ]);

    RegisterActions( 'LMDShellFolder', [
                                  TLMDShellEditShowProperties,
                                  TLMDShellEditCopyFiles,
                                  TLMDShellEditMoveFiles,
                                  TLMDShellEditCut,
                                  TLMDShellEditCopy,
                                  TLMDShellEditPaste,
                                  TLMDShellEditDelete,
                                  TLMDShellEditOpen,
                                  TLMDShellEditCopyFileNameAsText,
                                  TLMDShellEditCopyPathNameAsText,
                                  TLMDShellEditReName,
                                  TLMDShellEditSelectAll,
                                  TLMDShellEditInvertSelection,
                                  TLMDShellFolderCreateFolder,
                                  TLMDShellFolderBackward,
                                  TLMDShellFolderForward,
                                  TLMDShellFolderUpLevel,
                                  TLMDShellMapDrive,
                                  TLMDShellUnMapDrive,
                                  TLMDShellFilterDlg,
                                  TLMDShellFindFiles,
                                  TLMDShellFindComputer,
                                  TLMDShellDiskFormat,
                                  TLMDShellDiskCopy,
                                  TLMDShellDiskLabelEdit,
                                  TLMDShellOpenDosWindow,
                                  TLMDShellMailTo,
                                  TLMDShellRun], nil);

  RegisterPropertyEditor(TypeInfo(TLMDRoot), nil{TLMDShellFolder}, 'RootFolder', TLMDRootProperty);
  RegisterComponentEditor(TLMDShellFolder, TLMDRootEditor);
  //RegisterComponentEditor(TLMDShellSysBrowseDialog, TLMDRootEditor);
  //RegisterComponentEditor(TLMDShellFindDialog, TLMDRootEditor);
  RegisterComponentEditor(TLMDShellNotify, TLMDRootEditor);
  RegisterComponentEditor(TLMDShellBaseDialog, TLMDShellDlgEditor);
  RegisterComponentEditor(TLMDStarter, TLMDStarterEditor);

  // New from LMD-Tools
  RegisterPropertyEditor( TypeInfo( String ), TLMDStarter, 'Command', TLMDFileNameProperty );
  RegisterPropertyEditor( TypeInfo( String ), TLMDVersionInfo, 'RetrieveFilename', TLMDFileNameProperty );

  // --> pLMDExDsgnOIEnh
  {if geoSetOI in LMDGLOBALEDITOROPTIONS then
    begin
      RegisterPropertyEditor(TypeInfo(TLMDFileCtrlAttributes),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFileGrepAttributes),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDFileOpFlags),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDLookFors),nil,'',TLMDExtSetProperty);
      RegisterPropertyEditor(TypeInfo(TLMDReturnValues),nil,'',TLMDExtSetProperty);
      // ---
    end;}

end;

end.
