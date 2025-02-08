unit pLMDSearchPE;
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

pLMDSearchDateTimeEditorDlg unit (DD)
-------------------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  LMDRVEFormUnit, LMDRefineUnit, LMDSearchFileGrep, 
  Controls, SysUtils;

type
  {-------------------  Class TLMDSearchComponentEditor -----------------------}
  TLMDSearchComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {-------------------  Class TLMDSearchTemplatePropertyEditor ----------------}
  TLMDSearchTemplatePropertyEditor = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

implementation

uses
  LMDSearchBase, LMDDBRefine, LMDUtils;

{********************* TLMDSearchComponentEditor ******************************}
{------------------------- Public ---------------------------------------------}
procedure TLMDSearchComponentEditor.ExecuteVerb(Index: Integer);
var
  VisualBuilderForm:TLMDRVEForm;
begin
  if not (Component is TLMDSearchBaseDlgComponent) then exit;
  if Component is TLMDDBRefine then Dec(Index);
  case Index of
    -1: begin
          TLMDDBRefine(Component).ShowFindDialog;
        end;
     0: begin
          VisualBuilderForm:=TLMDRVEForm.Create(nil);
          with VisualBuilderForm do
            try
               LMDSPSetUpDialog(VisualBuilderForm, TLMDSearchBaseDlgComponent(Component));
               // at designtime allways center on screen
               LMDCenterForm(VisualBuilderForm);
               if ShowModal=mrOk then
                 begin
                   LMDSPAssignDialogValues(VisualBuilderForm, TLMDSearchBaseDlgComponent(Component));
                   self.Designer.Modified;
                 end;
            finally
              Free;
            end;
          end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSearchComponentEditor.GetVerb(Index: Integer): string;
begin
  if Component is TLMDDBRefine then Dec(Index);
  case index of
   -1: Result := 'Find Dialog';
    0: Result := 'Visual Editor';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSearchComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
  if Component is TLMDDBRefine then Inc(Result);
end;

{********************* TLMDSearchTemplatePropertyEditor ***********************}
{------------------------- Public----------------------------------------------}
procedure TLMDSearchTemplatePropertyEditor.Edit;
var
  VisualBuilderForm:TLMDRVEForm;
begin
  if not (GetComponent(0) is TLMDSearchBaseDlgComponent) then exit;
  VisualBuilderForm:=TLMDRVEForm.Create(nil);
  with VisualBuilderForm do
    try
       LMDSPSetUpDialog(VisualBuilderForm, TLMDSearchBaseDlgComponent(GetComponent(0)));
       LMDCenterForm(VisualBuilderForm);
       if ShowModal=mrOk then
         begin
           LMDSPAssignDialogValues(VisualBuilderForm, TLMDSearchBaseDlgComponent(GetComponent(0)));
           self.Designer.Modified;
         end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSearchTemplatePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog];
end;

end.
