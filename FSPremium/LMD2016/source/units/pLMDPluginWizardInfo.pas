unit pLMDPluginWizardInfo;
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

LMDPluginWizardInfo unit (AIH)
-----------------------------
Design time constuctor to LMDPluginDataModule

Changes
-------
Release 1.0 (July 2008)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TLMDPluginWizardInfo = class(TForm)
    pnlMain: TPanel;
    grpPluginInfo: TGroupBox;
    lblAuthor: TLabel;
    Label1: TLabel;
    edAuthor: TEdit;
    edMajor: TEdit;
    udMajor: TUpDown;
    edMinor: TEdit;
    udMinor: TUpDown;
    grpProjectFolder: TGroupBox;
    edProjectFolder: TEdit;
    btnChooseFolder: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    procedure udMajorClick(Sender: TObject; Button: TUDBtnType);
    procedure udMinorClick(Sender: TObject; Button: TUDBtnType);
    procedure btnChooseFolderClick(Sender: TObject);
    procedure edMajorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LMDPluginWizardInfo: TLMDPluginWizardInfo;

implementation

{$R *.dfm}
uses
  ShlObj, ActiveX;
  procedure TLMDPluginWizardInfo.udMajorClick(Sender: TObject;
  Button: TUDBtnType);
begin
  if Button = btNext then
    edMajor.Text := IntToStr(StrToIntDef(edMajor.Text, 0) + 1)
  else
  if edMajor.Text <> '0' then
    edMajor.Text := IntToStr(StrToIntDef(edMajor.Text, 0) - 1)
end;

procedure TLMDPluginWizardInfo.udMinorClick(Sender: TObject;
  Button: TUDBtnType);
begin
  if Button = btNext then
    edMinor.Text := IntToStr(StrToIntDef(edMinor.Text, 0) + 1)
  else
  if edMinor.Text <> '0' then
    edMinor.Text := IntToStr(StrToIntDef(edMinor.Text, 0) - 1)
end;

procedure TLMDPluginWizardInfo.btnChooseFolderClick(Sender: TObject);
var
  LTitle: string;
  lpItemID: PItemIDList;
  LBrowseInfo: TBrowseInfo;
  LDisplayName: array[0..MAX_PATH] of char;
  LPath: array[0..MAX_PATH] of char;

begin
  FillChar(LBrowseInfo, SizeOf(TBrowseInfo), #0);
  LDisplayName := 'Browse For Folder'; 
  LBrowseInfo.hwndOwner := Handle;
  LBrowseInfo.pszDisplayName := @LDisplayName;
  LTitle := 'Please specify a directory';
  LBrowseInfo.lpszTitle := PChar(LTitle);
  LBrowseInfo.pidlRoot := nil;
  LBrowseInfo.ulFlags := BIF_EDITBOX {$IFDEF LMDCOMP7}or BIF_NEWDIALOGSTYLE{$ENDIF} or BIF_RETURNONLYFSDIRS; //compilability only vb apr 2009
  LBrowseInfo.lpfn := nil;
  lpItemID := nil;
  try
    lpItemID := SHBrowseForFolder(LBrowseInfo);
    if lpItemID <> nil then
    begin
      SHGetPathFromIDList(lpItemID, LPath);
      edProjectFolder.Text := LPath;
    end;
  finally
    if lpItemID <> nil then
      GlobalFreePtr(lpItemID)
  end;
end;

procedure TLMDPluginWizardInfo.edMajorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not {$IFNDEF LMDCOMP12}(Key in ['0'..'9']){$ELSE}CharInSet(Key, ['0'..'9']){$ENDIF} then Key := #0;
end;

end.
