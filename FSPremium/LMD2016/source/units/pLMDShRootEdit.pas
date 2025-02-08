unit pLMDShRootEdit;
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

pLMDShRootEdit unit (DS)
------------------------
Contains RootPath property editor.


Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors,
  Forms, StdCtrls, Dialogs, Controls, Classes,
  LMDShDlg, LMDShBase;

type
{ ************************ class TRootPathEditDlg **************************** }
  TRootPathEditDlg = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    rbUseFolder: TRadioButton;
    GroupBox1: TGroupBox;
    cbFolderType: TComboBox;
    GroupBox2: TGroupBox;
    ePath: TEdit;
    rbUsePath: TRadioButton;
    btnBrowse: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbUseFolderClick(Sender: TObject);
    procedure rbUsePathClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
  private
    procedure UpdateState;
  public
  end;

{ *************************** class TLMDRootProperty ************************* }
  TLMDRootProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

{ *************************** class TLMDRootEditor *************************** }
  TLMDRootEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
  end;

implementation

uses
  Windows, SysUtils, TypInfo, FileCtrl, Variants,
  LMDShConsts, LMDShMisc, LMDShUtils;

{$R *.dfm}

const
  NTFolders = [sfCommonDesktopDirectory, sfCommonPrograms, sfCommonStartMenu,
               sfCommonStartup, sfCommonAltStartup, sfCommonVideo, sfCommonPictures,
               sfCommonAdminTools, sfCommonProgramFiles, sfCommonMusic, sfAdminTools,
               sfCommonAdminTools, sfCommonProgramFiles];

{ ****************************** ROUTINES ************************************ }
function LMDPathIsCSIDL(const Value: String): Boolean;
begin
  Result:= GetEnumValue(TypeInfo(TLMDRootFolder), Value) >= 0;
  end;

{ ---------------------------------------------------------------------------- }
function LMDRootPathEditor(const Value : string): string;
begin
  Result:= Value;
  with TRootPathEditDlg.Create(Application) do
    try
      rbUseFolder.Checked:= LMDPathIsCSIDL(Result);
      rbUsePath.Checked:= not rbUseFolder.Checked;
      if not LMDPathIsCSIDL(Result) then
        begin
          cbFolderType.ItemIndex := 0;
          ePath.Text:= Result;
        end
      else
        cbFolderType.ItemIndex := cbFolderType.Items.IndexOf(Result);

      UpdateState;
      ShowModal;
      if ModalResult = mrOK then
      begin
        if rbUsePath.Checked then
          Result:= ePath.Text
        else
          Result:= cbFolderType.Items[cbFolderType.ItemIndex];
      end;
    finally
      Free;
    end;
end;

{ ************************ class TRootPathEditDlg **************************** }
procedure TRootPathEditDlg.FormCreate(Sender: TObject);
var
  FT: TLMDRootFolder;
begin
  for FT := Low(TLMDRootFolder) to High(TLMDRootFolder) do
    if not ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and (FT in NTFolders)) then
      cbFolderType.Items.Add(GetEnumName(TypeInfo(TLMDRootFolder), Ord(FT)));
  cbFolderType.ItemIndex := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TRootPathEditDlg.UpdateState;
begin
  cbFolderType.Enabled := rbUseFolder.Checked;
  ePath.Enabled := not rbUseFolder.Checked;
  btnBrowse.Enabled := ePath.Enabled;
end;

{ ---------------------------------------------------------------------------- }
procedure TRootPathEditDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

{ ---------------------------------------------------------------------------- }
procedure TRootPathEditDlg.rbUseFolderClick(Sender: TObject);
begin
  rbUsePath.Checked:= not rbUseFolder.Checked;
  UpdateState;
end;

{ ---------------------------------------------------------------------------- }
procedure TRootPathEditDlg.rbUsePathClick(Sender: TObject);
begin
  rbUseFolder.Checked:= not rbUsePath.Checked;
  UpdateState;
end;

{ ---------------------------------------------------------------------------- }
procedure TRootPathEditDlg.btnBrowseClick(Sender: TObject);
  //Path: WideString;
  var
  Dir: String;
  begin
  Dir:= ePath.Text;
  if SelectDirectory( 'Please select a root path', '', Dir ) then
    ePath.Text:= Dir;
  end;

{ *************************** class TLMDRootProperty ************************* }
procedure TLMDRootProperty.Edit;

begin
  SetStrValue(LMDRootPathEditor(GetStrValue));

end;

{ ---------------------------------------------------------------------------- }
function TLMDRootProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paDialog];
end;

{ *************************** class TLMDRootEditor *************************** }
procedure TLMDRootEditor.ExecuteVerb(Index: Integer);

  procedure EditRoot;
  const
    SRoot = 'RootFolder';
  var
    oPath, Path: string;

  begin
    oPath := GetPropValue(Component, SRoot);
    Path:= LMDRootPathEditor(oPath);

    if  oPath <> Path then
      begin
        SetPropValue(Component, sRoot, Path);
        Designer.Modified;
      end;
  end;

begin
  case Index of
    0: EditRoot;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDRootEditor.GetVerb(Index: Integer): String;
begin
  case Index of
   0: Result := 'E&dit Root';
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDRootEditor.GetVerbCount: Integer;
begin
  Result:= 1;
end;

end.
