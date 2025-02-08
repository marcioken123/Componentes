unit pLMDBarPE;
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

pLMDBarPE unit (DD, RM, AH)
---------------------------
Implements property editors for BarPack controls.


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}
interface
uses
  DesignIntf, DesignEditors, VCLEditors,
  Classes, SysUtils, Dialogs, Controls,
  LMDBarBase,  LMDExplorerBar, LMDSectionBar, LMDSectionBarPopupMenu, pLMDCommon;

type

  {------------------- Class TLMDBarSectionsProperty --------------------------}
  TLMDBarSectionsProperty = class(TClassProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    function GetValue: string; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDBarCaptionProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;
implementation
uses
  pLMDCst, pLMDSectionBarEditorDlg, LMDBarHTMLLabel, pLMDHTMLEditDlg;

{******************** TLMDBarSectionsProperty *********************************}
{------------------------------------------------------------------------------}
function TLMDBarSectionsProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paDialog];
end;

{------------------------------------------------------------------------------}
procedure TLMDBarSectionsProperty.Edit;
begin
  with TLMDfrmSectionBarEditorDlg.Create(nil) do
    try
      FDesigner:=self.Designer;
      bbar.Sections:=TLMDSectionBarSections(GetOrdValue);
      if showmodal=mrOK then
        SetOrdValue(LongInt(TLMDSectionBarSections(bbar.Sections)));
        finally
      free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBarSectionsProperty.GetValue: string;
begin
  ///result:=inherited GetValue + ;
  result:=Format('(%d Section(s) available)', [TLMDSectionBarSections(GetOrdValue).Count]);
end;

{********************TLMDStringProperty****************************************}
{------------------------------------------------------------------------------}
function TLMDBarCaptionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable, paDialog];
end;

{------------------------------------------------------------------------------}
procedure TLMDBarCaptionProperty.Edit;
begin
  with TfrmLMDMiniHTMLEditor.Create(nil) do
     try
       HTMLEdit.Text:=GetStrValue;
       SetViewControlClass(TLMDBarHTMLLabel);
       if ShowModal=mrok then
         SetStrValue(HTMLEdit.Text);
     finally
       free;
     end;
end;
end.

