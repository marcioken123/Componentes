unit pLMDWizardsX;
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

LMD-Tools Shared(X) Form Wizards (AH)
-------------------------------------

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

{$IFNDEF LMD_NATIVEUNICODE}
procedure Register;
{$ENDIF}

implementation

{$ifndef LMD_NATIVEUNICODE}
uses
  ToolsApi, DesignIntf, DesignEditors, VCLEditors, DesignMenus, 
  Classes, Windows, SysUtils, Controls, LMDForms;

type
  HICON = Cardinal;

  TLMDCustomFormWizard = class(TNotifierObject,
   IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard, IOTARepositoryWizard60
   {$IFDEF LMDCOMP9}, IOTARepositoryWizard80{$ENDIF})
  protected
    function GetFormName: String; virtual;
    function GetFormClass: TComponentClass; virtual; abstract;
  public
    // IOTAWizard
    function GetIDString: String;
    function GetName: String; virtual;
    function GetState: TWizardState;
    procedure Execute;
    // IOTARepositoryWizard
    function GetAuthor: String;
    function GetComment: String; virtual; abstract;
    function GetPage: String; virtual;
    function GetGlyph: HICON;
    // IOTARepositoryWizard60
    function GetDesigner: string; overload;
    {$IFDEF LMDCOMP9}
    // IOTARepositoryWizard80
    function GetGalleryCategory: IOTAGalleryCategory; virtual;
    function GetPersonality: string; virtual; abstract;
    {$ENDIF}
  end;

  TLMDWideFormWizard = class(TLMDCustomFormWizard,
   IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard, IOTARepositoryWizard60
   {$IFDEF LMDCOMP9}, IOTARepositoryWizard80{$ENDIF})
  protected
    function GetFormClass: TComponentClass; override;
  public
    function GetComment: string; override;
  end;

  TLMDDelphiWideFormWizard = class(TLMDWideFormWizard,
   IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard, IOTARepositoryWizard60
   {$IFDEF LMDCOMP9}, IOTARepositoryWizard80{$ENDIF})
    function GetPage: String; override;
  public
    {$ifdef LMDCOMP9}
    function GetGalleryCategory: IOTAGalleryCategory; override;
    function GetPersonality: string; override;
    {$endif}
  end;

  TLMDBuilderWideFormWizard = class(TLMDWideFormWizard,
   IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard, IOTARepositoryWizard60
   {$IFDEF LMDCOMP9}, IOTARepositoryWizard80{$ENDIF})
  public
    function GetPage: String; override;
    {$ifdef LMDCOMP9}
    function GetGalleryCategory: IOTAGalleryCategory; override;
    function GetPersonality: string; override;
    {$endif}
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

  TLMDWideFormCustomModule = class(TCustomModule)
    class function DesignClass: TComponentClass; override;
  end;

{------------------------------------------------------------------------------}
procedure Register;
begin
  RegisterCustomModule(TLMDWideForm, TLMDWideFormCustomModule);
  {$ifdef LMDCOMP9}
  RegisterPackageWizard(TLMDBuilderWideFormWizard.Create);
  RegisterPackageWizard(TLMDDelphiWideFormWizard.Create);
  {$else}
    {$ifdef BCB}
    RegisterPackageWizard(TLMDBuilderWideFormWizard.Create);
    {$else}
    RegisterPackageWizard(TLMDDelphiWideFormWizard.Create);
    {$endif}
  {$endif}
end;

{$ifdef LMDCOMP9}
var
  CDelphiCategory: IOTAGalleryCategory;
  CBuilderCategory: IOTAGalleryCategory;

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
{$endif}

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
begin
  // nothing to do;
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
{$ifdef LMDCOMP7}
var
  i: Integer;
  LModSrv: IOTAModuleServices;
{$endif}
begin
  {$ifdef LMDCOMP7}
  Result := GetActiveProject;
  if not Assigned(Result) then
  {.$endif} //vb apr 2009
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
  {$endif} //vb apr 2009
end;

{------------------------------------------------------------------------------}
function TLMDFormGenerator.GetCurrentProject: IOTAProject;
var
  i: Integer;
  LModSrv: IOTAModuleServices;
begin
  {$ifdef LMDCOMP7}
  Result := GetActiveProject;
  if not Assigned(Result) then
  {$endif}
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
    '  Dialogs, LMDForms;' + #13#10 +
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
    '#include <LMDForms.hpp>' + #13#10 +
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

{ TLMDCustomFormWizard }
{------------------------------------------------------------------------------}
procedure TLMDCustomFormWizard.Execute;
var
  Module: IOTAModule;
begin
  Module := (BorlandIDEServices as IOTAModuleServices).CreateModule(TLMDFormGenerator.Create('', GetFormName));
end;

{------------------------------------------------------------------------------}
function TLMDCustomFormWizard.GetAuthor: String;
begin
  Result := 'LMD Innovative';
end;

{------------------------------------------------------------------------------}
function TLMDCustomFormWizard.GetDesigner: string;
begin
  Result := dVCL;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFormWizard.GetFormName: String;
begin
  Result := Copy(GetFormClass.ClassName, 2, Length(GetFormClass.ClassName) - 1);
end;

{$ifdef LMDCOMP9}
function TLMDCustomFormWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  Result := nil;
  if (BorlandIDEServices as IOTAGalleryCategoryManager) <> nil then
    Result := (BorlandIDEServices as IOTAGalleryCategoryManager).FindCategory(sCategoryCBuilderNew)
end;
{$endif}

{------------------------------------------------------------------------------}
function TLMDCustomFormWizard.GetGlyph: HICON;
begin
  Result := 0;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFormWizard.GetIDString: String;
begin
  Result := 'LMD.' + GetFormName() + '.FormWizard (Unicode)';
end;

{------------------------------------------------------------------------------}
function TLMDCustomFormWizard.GetName: String;
begin
  Result := GetFormName() + ' (Unicode)';
end;

{------------------------------------------------------------------------------}
function TLMDCustomFormWizard.GetPage: String;
begin
  Result := 'LMD Innovative';
end;

{------------------------------------------------------------------------------}
function TLMDCustomFormWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

{ TLMDWideFormCustomModule }
{------------------------------------------------------------------------------}
class function TLMDWideFormCustomModule.DesignClass: TComponentClass;
begin
  Result := TLMDWideForm;
end;

{ TLMDWideFormWizard }
{------------------------------------------------------------------------------}
function TLMDWideFormWizard.GetComment: string;
begin
  Result := 'Creates TLMDWideForm with unicode Caption';
end;

{------------------------------------------------------------------------------}
function TLMDWideFormWizard.GetFormClass: TComponentClass;
begin
  Result := TLMDWideForm;
end;

{************************ TLMDDelphiWideFormWizard ****************************}
{------------------------------------------------------------------------------}
function TLMDDelphiWideFormWizard.GetPage: String;
begin
  Result := 'LMD Forms for Delphi';
end;

{$ifdef LMDCOMP9}
{------------------------------------------------------------------------------}
function TLMDDelphiWideFormWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  Result := CDelphiCategory;
end;

{------------------------------------------------------------------------------}
function TLMDDelphiWideFormWizard.GetPersonality: string;
begin
  Result := sDelphiPersonality;
end;
{$ENDIF LMDCOMP9}

{************************* TLMDBuilderWideFormWizard **************************}
{------------------------------------------------------------------------------}
function TLMDBuilderWideFormWizard.GetPage: String;
begin
  Result := 'LMD Forms for C++Builder';
end;

{$ifdef LMDCOMP9}
{------------------------------------------------------------------------------}
function TLMDBuilderWideFormWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  Result := CBuilderCategory;
end;

{------------------------------------------------------------------------------}
function TLMDBuilderWideFormWizard.GetPersonality: string;
begin
  Result := sCBuilderPersonality;
end;

{------------------------------------------------------------------------------}
procedure CreateGalleries;
begin
  CDelphiCategory := AddDelphiCategory('LMD.Innovative.Delphi.Category', 'LMD Forms for Delphi');
  CBuilderCategory := AddBuilderCategory('LMD.Innovative.Builder.Category', 'LMD Forms for C++Builder');
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
{$ENDIF LMDCOMP9}
{$ENDIF LMD_NATIVEUNICODE}

end.
