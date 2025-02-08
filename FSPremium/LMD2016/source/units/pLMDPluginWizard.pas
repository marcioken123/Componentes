unit pLMDPluginWizard;
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

pLMDPluginWizardReg unit (AIH)
----------------------------
Description
Registration Wizard of Expert for LMD Plugin Framework.
Visual projecting LMD Plugin as TDataModule descendant

ToDo
----

Changes
-------

Release 0.1 (July 2008)
* Initial Release

###############################################################################}

interface

 uses
  ToolsApi, DesignIntf, DesignEditors, VCLEditors, DesignMenus,
  Classes, Windows, SysUtils, Controls;

type
  TLMDPluginCustomModule = class(TCustomModule)
    class function DesignClass: TComponentClass; override;
  end;

  TLMDCustomPluginWizard = class(TNotifierObject,
   IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard, IOTARepositoryWizard60
   {$IFDEF LMDCOMP9}, IOTARepositoryWizard80{$ENDIF})
  protected
    function GetFormName: String; virtual;
    function GetFormClass: TComponentClass; virtual; abstract;
  public
    // IOTAWizard
    function GetIDString: string; virtual;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
    // IOTARepositoryWizard
    function GetAuthor: string;
    function GetComment: string; virtual; abstract;
    function GetPage: string; virtual;
    function GetGlyph: Cardinal;
    // IOTARepositoryWizard60
    function GetDesigner: string; overload;
    {$IFDEF LMDCOMP9}
    // IOTARepositoryWizard80
    function GetGalleryCategory: IOTAGalleryCategory; virtual; abstract;
    function GetPersonality: string; virtual; abstract;
    {$ENDIF}
  end;
  TLMDFormGenerator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  private
    FAncestorName: String;
  public
    // IOTACreator
    function GetCreatorType: String;
    function GetExisting: Boolean;
    function GetFileSystem: String;
    function GetOwner: IOTAModule;
    function GetCurrentProject: IOTAProject;
    function GetUnnamed: Boolean;
    // IOTAModuleCreator
    function GetAncestorName: String;
    function GetImplFileName: String;
    function GetIntfFileName: String;
    function GetFormName: String;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: String): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: String): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: String): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  public
    constructor Create(const FormName, AncestorName: String);
  end;

  TLMDOTAFile = class(TInterfacedObject, IOTAFile)
  private
    FSource: String;
  public
    function GetSource: String;
    function GetAge: TDateTime;
    constructor Create(const ASource: String);
  end;

  TLMDPluginWizard = class(TLMDCustomPluginWizard,
   IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard, IOTARepositoryWizard60
   {$IFDEF LMDCOMP9}, IOTARepositoryWizard80{$ENDIF})
  protected
    function GetFormClass: TComponentClass; override;
  public
    function GetComment: string; override;
  end;

  TLMDDelphiPluginModuleWizard = class(TLMDPluginWizard,
   IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard, IOTARepositoryWizard60
   {$IFDEF LMDCOMP9}, IOTARepositoryWizard80{$ENDIF})
  public
    function GetPage: String; override;
    function GetIDString: string; override;
    {$ifdef LMDCOMP9}
    function GetGalleryCategory: IOTAGalleryCategory; override;
    function GetPersonality: string; override;
    {$endif}
  end;

  TLMDBuilderPluginModuleWizard = class(TLMDPluginWizard,
   IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard, IOTARepositoryWizard60
   {$IFDEF LMDCOMP9}, IOTARepositoryWizard80{$ENDIF})
  public
    function GetPage: String; override;
    function GetIDString: string; override;
    {$ifdef LMDCOMP9}
    function GetGalleryCategory: IOTAGalleryCategory; override;
    function GetPersonality: string; override;
    {$endif}
  end;

implementation

uses
  LMDPluginModule, pLMDPluginWizardInfo, Dialogs;

var
  FAuthor: string;
  FMajorVersion,
  FMinorVersion: Integer;
  FProjectFolder: string;
{$ifdef LMDCOMP9}
var
  CDelphiCategory: IOTAGalleryCategory;
  CBuilderCategory: IOTAGalleryCategory;
{$endif}

{ TLMDPluginWizard }
procedure TLMDCustomPluginWizard.Execute;
var
  frmInfo: TLMDPluginWizardInfo;
  Module: IOTAModule;
begin
  frmInfo := TLMDPluginWizardInfo.Create(nil);
  if frmInfo.ShowModal = mrOK then
  begin
    FAuthor := frmInfo.edAuthor.Text;
    FMajorVersion := StrToIntDef(frmInfo.edMajor.Text, 0);
    FMinorVersion := StrToIntDef(frmInfo.edMinor.Text, 0);
    FProjectFolder := frmInfo.edProjectFolder.Text;
    Module := (BorlandIDEServices as IOTAModuleServices).CreateModule(TLMDFormGenerator.Create('', GetFormName));
  end;
end;

function TLMDCustomPluginWizard.GetAuthor: string;
begin
  Result := FAuthor
end;

function TLMDCustomPluginWizard.GetGlyph: Cardinal;
begin
  Result := 0; //LoadIcon(hInstance, 'LMDPluginWIZARD');
end;

{------------------------------------------------------------------------------}
function TLMDCustomPluginWizard.GetDesigner: string;
begin
  Result := dVCL;
end;

function TLMDCustomPluginWizard.GetIDString: string;
begin
  Result := 'LMD.' + GetFormName();
end;

function TLMDCustomPluginWizard.GetName: string;
begin
  Result := GetFormName();
end;

function TLMDCustomPluginWizard.GetPage: string;
begin
  Result := 'LMD Innovative'
end;

function TLMDCustomPluginWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

function TLMDCustomPluginWizard.GetFormName(): string;
begin
  Result := Copy(GetFormClass.ClassName, 2, Length(GetFormClass.ClassName) - 1);
end;

{------------------------------------------------------------------------------}
function IsDelphiPersonality: Boolean;
{$ifdef LMDCOMP9}
var
  Personalities: IOTAPersonalityServices;
{$endif}
begin
  {$ifdef LMDCOMP9}
  Personalities := BorlandIDEServices as IOTAPersonalityServices;  
  Result := Personalities.CurrentPersonality = sDelphiPersonality;
  {$else}
    {$ifdef BCB}
    Result := False;
    {$else}
    Result := True;
    {$endif}
  {$endif}
end;

{ TLMDPluginWizard }
{------------------------------------------------------------------------------}
function TLMDPluginWizard.GetComment: string;
begin
  Result := 'Creates TLMDPlugin module';
end;

{------------------------------------------------------------------------------}
function TLMDPluginWizard.GetFormClass: TComponentClass;
begin
  Result := TLMDPluginModule;
end;

{************************ TLMDDelphiPluginModuleWizard ****************************}
{------------------------------------------------------------------------------}
function TLMDDelphiPluginModuleWizard.GetIDString: string;
begin
  Result := 'Delphi.' + inherited GetIDString;
end;

{------------------------------------------------------------------------------}
function TLMDDelphiPluginModuleWizard.GetPage: String;
begin
  Result := 'LMD Innovative';
end;

{$ifdef LMDCOMP9}
{------------------------------------------------------------------------------}
function TLMDDelphiPluginModuleWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  Result := CDelphiCategory;
end;

{------------------------------------------------------------------------------}
function TLMDDelphiPluginModuleWizard.GetPersonality: string;
begin
  Result := sDelphiPersonality;
end;
{$ENDIF LMDCOMP9}

{************************* TLMDBuilderPluginModuleWizard **************************}
{------------------------------------------------------------------------------}
function TLMDBuilderPluginModuleWizard.GetIDString: string;
begin
  Result := 'Builder.' + inherited GetIDString;
end;

{------------------------------------------------------------------------------}
function TLMDBuilderPluginModuleWizard.GetPage: String;
begin
  Result := 'LMD Innovative';
end;

{$ifdef LMDCOMP9}
{------------------------------------------------------------------------------}
function TLMDBuilderPluginModuleWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  Result := CBuilderCategory;
end;

{------------------------------------------------------------------------------}
function TLMDBuilderPluginModuleWizard.GetPersonality: string;
begin
  Result := sCBuilderPersonality;
end;
{$endif LMDCOMP9}

{********************************* TLMDOTAFile ********************************}
{------------------------------------------------------------------------------}
constructor TLMDOTAFile.Create(const ASource: String);
begin
  inherited Create;
  FSource := ASource;
end;

{------------------------------------------------------------------------------}
function TLMDOTAFile.GetSource: String;
begin
  Result := FSource;
end;

{------------------------------------------------------------------------------}
function TLMDOTAFile.GetAge: TDateTime;
begin
  Result := Now;
end;

{ TLMDFormGenerator }
{------------------------------------------------------------------------------}
constructor TLMDFormGenerator.Create(const FormName, AncestorName: String);
begin
  inherited Create;
  FAncestorName := AncestorName;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormGenerator.FormCreated(const FormEditor: IOTAFormEditor);
var
  LCmp: IOTAComponent;
begin
  // nothing to do;
  inherited;
  LCmp := FormEditor.GetRootComponent;
  if Assigned(LCmp) then
  begin
    LCmp.SetPropByName('Author', FAuthor);
    LCmp.SetPropByName('MajorVersion', FMajorVersion);
    LCmp.SetPropByName('MinorVersion', FMinorVersion);
    LCmp.SetPropByName('ProjectFolder', FProjectFolder);

  end;
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetAncestorName: String;
begin
  Result := FAncestorName;
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetCreatorType: String;
begin
  Result := sForm;
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetExisting: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetFileSystem: String;
begin
  Result := '';
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetFormName: String;
begin
  Result := '';
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetImplFileName: String;
begin
  Result := '';
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetIntfFileName: String;
begin
  Result := '';
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetMainForm: Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetOwner: IOTAModule;
{$IFDEF LMDCOMP7}
var
  i: Integer;
  LModSrv: IOTAModuleServices;
{$ENDIF}  
begin
  {$IFDEF LMDCOMP7} //compilability only vb apr 2009
  Result := GetActiveProject;
  if not Assigned(Result) then
    begin
      if Assigned(BorlandIDEServices) then
        begin
          LModSrv := BorlandIDEServices as IOTAModuleServices;
          for i := 0 to LModSrv.ModuleCount - 1 do
            begin
              if Supports(LModSrv.Modules[i], IOTAProject, Result) then
                exit;
              if Supports(LModSrv.Modules[i], IOTAProjectGroup, Result) then
                begin
                  Result := (Result as IOTAProjectGroup).ActiveProject;
                  exit;
                end;
            end;
        end;
    end;
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetCurrentProject: IOTAProject;
{$IFDEF LMDCOMP7}
var
  i: Integer;
  LModSrv: IOTAModuleServices;
{$ENDIF}  
begin
  {$IFDEF LMDCOMP7} //compilability only vb apr 2009
  Result := GetActiveProject;
  if not Assigned(Result) then
    begin
      if Assigned(BorlandIDEServices) then
        begin
          LModSrv := BorlandIDEServices as IOTAModuleServices;
          for i := 0 to LModSrv.ModuleCount - 1 do
            begin
              if Supports(LModSrv.Modules[i], IOTAProject, Result) then
                exit;
              if Supports(LModSrv.Modules[i], IOTAProjectGroup, Result) then
                begin
                  Result := (Result as IOTAProjectGroup).ActiveProject;
                  exit;
                end;
            end;
        end;
    end;
  {$ENDIF}  
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetShowForm: Boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetShowSource: Boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetUnnamed: Boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.NewFormFile(const FormIdent, AncestorIdent: String): IOTAFile;
begin
  Result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: String): IOTAFile;
const
  CNewCppFormCode =
    '//---------------------------------------------------------------------------' + #13#10 +
    '' + #13#10 +
    '#include <vcl.h>' + #13#10 +
    '#pragma hdrstop' + #13#10 +
    '' + #13#10 +
    '#include "%s.h"' + #13#10 +
    '//---------------------------------------------------------------------------' + #13#10 +
    '#pragma package(smart_init)' + #13#10 +
    '#pragma resource "*.dfm"' + #13#10 +
    'T%s *%s;' + #13#10 +
    '//---------------------------------------------------------------------------' + #13#10 +
    '__fastcall T%s::T%s(TComponent* Owner)' + #13#10 +
      ': T%s(Owner)' + #13#10 +
    '{' + #13#10 +
    '}' + #13#10 +
    '//---------------------------------------------------------------------------';

  CNewPasFormCode =
    'unit %s;' + #13#10 +
    '' + #13#10 +
    'interface' + #13#10 +
    '' + #13#10 +
    'uses' + #13#10 +
    '  Windows, Messages, SysUtils, ' + 'Variants, Classes, Graphics, Controls, Forms,' + #13#10 +
    '  Dialogs, LMDPluginModule, LMDPluginManager, LMDPluginImpl;' + #13#10 +
    '' + #13#10 +
    'type' + #13#10 +
    '  T%s = class(T%s)' + #13#10 +
    '  private' + #13#10 +
    '    { Private declarations }' + #13#10 +
    '  public' + #13#10 +
    '    { Public declarations }' + #13#10 +
    '  end;' + #13#10 +
    '' + #13#10 +
    'var' + #13#10 +
    '  %s: T%s;' + #13#10 +
    '' + #13#10 +
    'implementation' + #13#10 +
    '' + #13#10 +
    '{$R *.dfm}' + #13#10 +
    '' + #13#10 +
    'end.';
var
  LSource: String;
begin
  if IsDelphiPersonality then
  begin
    LSource := Format(CNewPasFormCode, [ModuleIdent, FormIdent, AncestorIdent, FormIdent, FormIdent]);
    Result := TLMDOTAFile.Create(LSource);
  end
  else
  begin
    LSource := Format(CNewCppFormCode, [ModuleIdent, FormIdent, FormIdent, FormIdent, FormIdent, AncestorIdent]);
    Result := TLMDOTAFile.Create(LSource);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: String): IOTAFile;
const
  CNewHppFormCode =
    '#ifndef %sH' + #13#10 +
    '#define %sH' + #13#10 +
    '//---------------------------------------------------------------------------' + #13#10 +
    '#include <Classes.hpp>' + #13#10 +
    '#include <Controls.hpp>' + #13#10 +
    '#include <StdCtrls.hpp>' + #13#10 +
    '#include <Forms.hpp>' + #13#10 +
    '#include <LMDPluginModule.hpp>' + #13#10 +
    '#include <LMDPluginManager.hpp>' + #13#10 +
    '#include <LMDPluginImpl.hpp>' + #13#10 +
    '//---------------------------------------------------------------------------' + #13#10 +
    'class T%s : public T%s' + #13#10 +
    '{' + #13#10 +
    '__published:  // IDE-managed Components' + #13#10 +
    'private:  // User declarations' + #13#10 +
    'public:   // User declarations' + #13#10 +
      '__fastcall T%s(TComponent* Owner);' + #13#10 +
    '};' + #13#10 +
    '//---------------------------------------------------------------------------' + #13#10 +
    'extern PACKAGE T%s *%s;' + #13#10 +
    '//---------------------------------------------------------------------------' + #13#10 +
    '#endif';

var
  LSource: String;
begin
  Result := nil;
  if not IsDelphiPersonality then
  begin
    LSource := Format(CNewHppFormCode, [ModuleIdent, ModuleIdent, FormIdent, AncestorIdent, FormIdent, FormIdent, FormIdent]);
    Result := TLMDOTAFile.Create(LSource);
  end;
end;

{ TLMDPluginCustomModule }
{------------------------------------------------------------------------------}
class function TLMDPluginCustomModule.DesignClass: TComponentClass;
begin
  Result := TLMDPluginModule;
end;

{$ifdef LMDCOMP9}
{------------------------------------------------------------------------------}
function AddDelphiCategory(CategoryID, CategoryCaption: string): IOTAGalleryCategory;
var
  Manager: IOTAGalleryCategoryManager;
  ParentCategory: IOTAGalleryCategory;
begin
  Result := nil;
  Manager := BorlandIDEServices as IOTAGalleryCategoryManager;
  if Assigned(Manager) then
  begin
    ParentCategory := Manager.FindCategory(sCategoryDelphiNew);
    if Assigned(ParentCategory) then
      Result := Manager.AddCategory(ParentCategory, CategoryID, CategoryCaption);
  end
end;

{------------------------------------------------------------------------------}
function AddBuilderCategory(CategoryID, CategoryCaption: string): IOTAGalleryCategory;
var
  Manager: IOTAGalleryCategoryManager;
  ParentCategory: IOTAGalleryCategory;
begin
  Result := nil;
  Manager := BorlandIDEServices as IOTAGalleryCategoryManager;
  if Assigned(Manager) then
  begin
    ParentCategory := Manager.FindCategory(sCategoryCBuilderNew);
    if Assigned(ParentCategory) then
      Result := Manager.AddCategory(ParentCategory, CategoryID, CategoryCaption);
  end
end;

{------------------------------------------------------------------------------}
procedure RemoveCategory(Category: IOTAGalleryCategory);
var
  Manager: IOTAGalleryCategoryManager;
begin
  Manager := BorlandIDEServices as IOTAGalleryCategoryManager;
  if Assigned(Manager) then
  begin
    if Assigned(Category) then
      Manager.DeleteCategory(Category)
  end
end;

{------------------------------------------------------------------------------}
procedure CreateGalleries;
begin
  CDelphiCategory := AddDelphiCategory('LMD.Innovative.Delphi.Category', 'LMD Innovative');
  CBuilderCategory := AddBuilderCategory('LMD.Innovative.Builder.Category', 'LMD Innovative');
end;

{------------------------------------------------------------------------------}
procedure RemoveGalleries;
begin
  RemoveCategory(CDelphiCategory);
  RemoveCategory(CBuilderCategory);
end;

initialization
  CreateGalleries;

finalization
  RemoveGalleries;

{$ENDIF}

end.
