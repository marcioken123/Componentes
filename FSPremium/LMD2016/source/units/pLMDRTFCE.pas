unit  pLMDRTFCE;
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

pLMDRTFCE unit (RM)
-------------------
Component Editors for LMD RichPack.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils,
  ActnMan, ActnCtrls, DesignIntf, DesignEditors, VCLEditors, ActnMenus,
  LMDRTFBase, LMDRTFRichEdit,
  pLMDRTFGenerateToolbar,
  LMDRTFPageDialog, LMDRTFStorage, LMDRTFLabel;

type

  {----------------------  Class TLMDRTFRichDialogEditor ----------------------}
  TLMDRTFRichDialogEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------  Class TLMDRTFComponentEditor -----------------------}
  TLMDRTFComponentEditor = class(TDefaultEditor)
  protected
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------  Class TLMDRTFLinesEditor  --------------------------}
  TLMDRTFLinesEditor = class(TDefaultEditor)
  protected
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------  Class TLMDEmptyEditor ------------------------------}
  TLMDEmptyEditor = class(TLMDRTFLinesEditor)
  protected
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {----------------------  Class TLMDRTFStorageEditor -------------------------}
  TLMDRTFStorageEditor = class(TDefaultEditor)
  protected
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation

uses
  pLMDRTFRichEditor;
  {********************* Class TLMDRTFRichDialogEditor **************************}
{------------------------------------------------------------------------------}
procedure TLMDRTFRichDialogEditor.ExecuteVerb(Index: Integer);
begin
  if Component is TLMDRichBaseDialog then
    TLMDRichBaseDialog(Component).Execute
  else
    if Component is  TLMDRichPageSetupDialog then
      TLMDRichPageSetupDialog(Component).Execute;
  //if Component is TLMDRichDialog then
  //  TLMDRichDialog(Component).Execute;
  //  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDRTFRichDialogEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: Result := 'Test Dialog';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRTFRichDialogEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{------------------------------------------------------------------------------}
{  TLMDRTFComponentEditor  }
procedure TLMDRTFComponentEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
begin
  ExecuteVerb(0);
  Continue:= False;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFComponentEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0:
      if  LMDRTFEditComponent('', Component)  then
        Self.Designer.Modified;
    1: GenerateToolbar(Component);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRTFComponentEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result:= 'Editor...';
    1: Result:= 'Generate toolbar...'
  else
    Result:= '';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRTFComponentEditor.GetVerbCount: Integer;
begin
  if Component is TLMDRichEdit then
    Result:= 2
  else
    Result:= 1;
end;

{------------------------------------------------------------------------------}
{  TLMDRTFLinesEditor  }
procedure TLMDRTFLinesEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  PropName: string;
begin
  PropName:= Prop.GetName;
  if SameText(PropName, 'Lines')  then
    begin
      Prop.Edit;
      Continue:= False;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFLinesEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: Edit;
    1: GenerateToolbar(Component);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRTFLinesEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result:= 'Editor...';
    1: Result:= 'Generate toolbar...'
  else
    Result:= '';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRTFLinesEditor.GetVerbCount: Integer;
begin
  if Component is TLMDRichEdit then
    Result:= 2
  else
    Result:= 1;
end;

{ TLMDEmptyEditor }
{------------------------------------------------------------------------------}
procedure TLMDEmptyEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  PropName: string;
begin
  PropName:= Prop.GetName;
  if CompareText(PropName, 'Lines') = 0 then
    begin
      Prop.Edit;
      Continue:= False;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDEmptyEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: GenerateToolbar(Component);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDEmptyEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result:= 'Generate toolbar...'
  else
    Result:= '';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDEmptyEditor.GetVerbCount: Integer;
begin
  if Component.ClassName='TLMDDBRichEdit' then
    Result:= 1
  else
    Result:= 0;
end;

{ TLMDRTFStorageEditor }
{------------------------------------------------------------------------------}
procedure TLMDRTFStorageEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  PropName: string;
begin
  PropName:= Prop.GetName;
  if CompareText(PropName, 'Items') = 0 then
    begin
      Prop.Edit;
      Continue:= False;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFStorageEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: Edit;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRTFStorageEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result:= 'Storage Items Editor...';
  else
    Result:= '';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRTFStorageEditor.GetVerbCount: Integer;
begin
  Result:= 1
end;

end.
