unit pLMDStorPE;
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

pLMDStorPE unit (VO)
---------------------
LMD StoragePack Property Editors

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  Classes, Registry, Controls, SysUtils, Dialogs, Forms,
  LMDStorPropertiesStorage, pLMDStorPropForm, pLMDTemplateStorageForm, LMDStorTemplateStorage,
  pLMDCst, LMDTypes, pLMDCommon;

const
  OS_KEY = LMDTOOLS_REGISTRYPATH + '\LMD StoragePack';
  OS_EP_VALUE = 'ExcludedProperties';

type
  {-------------------  Class TLMDStorVaultProperty ---------------------------}
  TLMDStorVaultProperty = class(TComponentProperty)
  private
    FStrings:TStringList;
    procedure VaultProc(const S: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {-------------------  Class TLMDPropertiesComponentEditor -------------------}
  TLMDPropertiesComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {-------------------  Class TLMDPropertiesPropertyEditor --------------------}
  TLMDPropertiesPropertyEditor = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetValue: string; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {-------------------  Class TLMDStorFilenameProperty ------------------------}
  TLMDStorFilenameProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {-------------------  Class TLMDSectionIndexProperty ------------------------}
  TLMDSectionIndexProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  {-------------------  Class TLMDStorTemplateStorageEditor -------------------}
  TLMDStorTemplateStorageEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure SaveExcludedProperties;

var
  ExcludedProperties: TStringList;

implementation

uses
  LMDStorBase,
  LMDStorControllerVault,
  LMDStorINIVault,
  LMDStorBinVault,
  LMDStorXMLVault,
  TypInfo;

var
  Reg: TRegistry;
  MS: TMemoryStream;

{********************* TLMDPropertiesComponentEditor **************************}
{------------------------- Public ---------------------------------------------}
procedure TLMDPropertiesComponentEditor.ExecuteVerb(Index: Integer);
var
  PForm: TLMDPropForm;
begin
  PForm := TLMDPropForm.Create(nil);
  try
    PForm.OS := Component as TLMDStorPropertiesStorage;
    if PForm.ShowModal = mrOk then Designer.Modified;
  finally
    PForm.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDPropertiesComponentEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Editor';
end;

{------------------------------------------------------------------------------}
function TLMDPropertiesComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{********************* TLMDStorVaultProperty **********************************}
{------------------------------------------------------------------------------}
procedure TLMDStorVaultProperty.VaultProc(const S: string);
begin
  if Assigned(FStrings) then
    FStrings.Add(S);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorVaultProperty.GetValues(Proc: TGetStrProc);
var
  i:Integer;
begin
  FStrings:=TStringList.Create;
  try
    Designer.GetComponentNames(GetTypeData(GetPropType), VaultProc);
    for i:=FStrings.Count-1 downto 0 do
      if Designer.GetComponent(FStrings[i]) is TLMDStorControllerVault then
        FStrings.Delete(i);
    for i:=0 to FStrings.Count-1 do
      Proc(FStrings[i]);
  finally
    FreeAndNil(FStrings);
  end;
end;

{********************* TLMDPropertiesPropertyEditor ***************************}
{------------------------- Public----------------------------------------------}
procedure TLMDPropertiesPropertyEditor.Edit;
var
  PForm: TLMDPropForm;
begin
  PForm := TLMDPropForm.Create(nil);
  try
    PForm.OS := GetComponent(0) as TLMDStorPropertiesStorage;
    if PForm.ShowModal = mrOk then Modified;
  finally
    PForm.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDPropertiesPropertyEditor.GetValue: string;
begin
  Result := '(' + IntToStr((GetComponent(0)
    as TLMDStorPropertiesStorage).Properties.Count) + ' selected)';
end;

{------------------------------------------------------------------------------}
function TLMDPropertiesPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paReadOnly, paDialog];
end;

{********************* TLMDStorFilenameProperty *******************************}
{------------------------- Public----------------------------------------------}
procedure TLMDStorFilenameProperty.Edit;
begin
  with TOpenDialog.Create(Application) do
    try
      Filename := GetValue;
      Options:=Options + [ofPathMustExist];
      if GetComponent(0) is TLMDStorXMLVault then
        Filter := 'XML files (*.xml)|*.xml|All files (*.*)|*.*'
      else if GetComponent(0) is TLMDStorIniVault then
        Filter := 'Ini files (*.ini)|*.ini|All files (*.*)|*.*'
      else if GetComponent(0) is TLMDStorBinVault then
        Filter := 'Data files (*.dat)|*.dat|All files (*.*)|*.*';
      if Execute then
        SetValue(Filename);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDStorFilenameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end;

{********************* TLMDSectionIndexProperty *******************************}
{------------------------- Public----------------------------------------------}
function TLMDSectionIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paMultiSelect];
end;

type
  TLMDCrackStorageVault = class(TLMDAbstractStorageVault)
  public
    property Sections;
  end;

{------------------------------------------------------------------------------}
procedure TLMDSectionIndexProperty.GetValueList(List: TStrings);
var
  i: integer;
  Sections: TStrings;
begin
  List.Clear;
  Sections := nil;
  if GetComponent(0) is TLMDStorPropertiesStorage then Sections :=
   TLMDCrackStorageVault(TLMDStorPropertiesStorage(GetComponent(0)).StorageVault).Sections else
    if GetComponent(0) is TLMDAbstractStorageVault then Sections :=
      TLMDCrackStorageVault(GetComponent(0)).Sections;
  if Sections <> nil then
    for i := 0 to Sections.Count - 1 do
      begin
        if Sections[i] <> '' then
          List.Add(IntToStr(i) + ' - ' + Sections[i]) else
          List.Add(IntToStr(i) + ' - (TLMDStorSection)');
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionIndexProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionIndexProperty.SetValue(const Value: string);
var
  S, Name: string;
  I, k: Integer;
  Sections: TStrings;
begin
  S := Value;
  Sections := nil;
  if GetComponent(0) is TLMDStorPropertiesStorage then Sections :=
    TLMDCrackStorageVault((GetComponent(0) as TLMDStorPropertiesStorage).StorageVault).Sections else
    if GetComponent(0) is TLMDAbstractStorageVault then Sections :=
      TLMDCrackStorageVault(GetComponent(0)).Sections;
  i := -1;
  for k := 0 to Sections.Count - 1 do
    begin
      if trim(Sections[k]) <> '' then Name := Sections[k] else
        Name := '(TLMDStorSection)';
      if IntToStr(k) + ' - ' + Name = Value then i := k;
    end;
  if I <> -1 then S := IntToStr(I);
  inherited SetValue(S);
end;

{********************* TLMDStorTemplateStorageEditor **************************}
{------------------------- Public----------------------------------------------}
procedure TLMDStorTemplateStorageEditor.ExecuteVerb(Index: Integer);
var
  PForm: TLMDTemplateStorageForm;
begin
  PForm := TLMDTemplateStorageForm.Create(nil);
  try
    PForm.SC := Component as TLMDStorTemplateStorage;
    if PForm.ShowModal = mrOk then Designer.Modified;
  finally
    PForm.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDStorTemplateStorageEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Editor';
end;

{------------------------------------------------------------------------------}
function TLMDStorTemplateStorageEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{------------------------------------------------------------------------------}
procedure SaveExcludedProperties;
begin
  Reg := TRegistry.Create;
  if Reg.OpenKey(OS_KEY, True) then
    begin
      MS := TMemoryStream.Create;
      try
        ExcludedProperties.SaveToStream(MS);
        Reg.WriteBinaryData(OS_EP_VALUE, MS.Memory^, MS.Size);
      except
      end;
      MS.Free;
    end;
  Reg.Free;
end;

initialization
  ExcludedProperties := TStringList.Create;
  Reg := TRegistry.Create;
  if Reg.OpenKey(OS_KEY, False) then
    begin
      MS := TMemoryStream.Create;
      try
        MS.Size := Reg.GetDataSize(OS_EP_VALUE);
        Reg.ReadBinaryData(OS_EP_VALUE, MS.Memory^, MS.Size);
        ExcludedProperties.LoadFromStream(MS);
      except
      end;
      MS.Free;
    end;
  Reg.Free;

finalization
  SaveExcludedProperties;
  ExcludedProperties.Free;

end.

