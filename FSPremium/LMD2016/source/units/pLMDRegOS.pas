unit pLMDRegOS;
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

pLMDRegOS unit ()
-----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors, 
  SysUtils, TypInfo, Classes, Forms, Dialogs, Controls, Registry,
  LMDObjectStorage, pLMDOSPropForm, pLMDCst, LMDTypes;

const
  OS_EP_VALUE   = 'ExcludedProperties';

type
  {----------------------------------------------------------------------------}
  TLMDPropertiesProperty=class(TPropertyEditor)
  public
    procedure Edit; override;
    function  GetValue:String; override;
    function  GetAttributes:TPropertyAttributes; override;
  end;

  {----------------------------------------------------------------------------}
  TLMDOSComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer);  override;
    function GetVerb(Index: Integer): String;  override;
    function GetVerbCount: Integer;  override;
  end;

  procedure SaveExcludedProperties;

procedure Register;

var
  ExcludedProperties:TStringList;
  OS_KEY:String;

implementation

var
  Reg : TRegistry;
  MS  : TMemoryStream;

{ ---------------------------------------------------------------------------- }
procedure Register;
begin
  RegisterComponents('LMD Sys',[TLMDObjectStorage]);
  RegisterComponentEditor(TLMDObjectStorage, TLMDOSComponentEditor);
  RegisterPropertyEditor(TypeInfo(TLMDPropertyStorage),TLMDObjectStorage,'Properties',TLMDPropertiesProperty);
end;

{********************* Class TLMDOSComponentEditor ****************************}
{------------------------------------------------------------------------------}
procedure TLMDOSComponentEditor.ExecuteVerb(Index: Integer);
var
  PForm : TLMDOSPropForm;
begin
  PForm := TLMDOSPropForm.Create(nil);
  try
    PForm.OS := Component as TLMDObjectStorage;
    if PForm.ShowModal=mrOk then Designer.Modified;
  finally
    PForm.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDOSComponentEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Editor';
end;

{------------------------------------------------------------------------------}
function TLMDOSComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TLMDPropertiesProperty }
{ ---------------------------------------------------------------------------- }
procedure TLMDPropertiesProperty.Edit;
var
  PForm : TLMDOSPropForm;
begin
  PForm := TLMDOSPropForm.Create(nil);
  try
    PForm.OS := GetComponent(0) as TLMDObjectStorage;
    if PForm.ShowModal=mrOk then Modified;
  finally
    PForm.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertiesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect,paReadOnly,paDialog];
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertiesProperty.GetValue: String;
begin
  Result :='('+IntToStr((GetComponent(0) as TLMDObjectStorage).Properties.Count)+' selected)';
end;

{ ---------------------------------------------------------------------------- }
procedure SaveExcludedProperties;
begin
  Reg := TRegistry.Create;
  if Reg.OpenKey(OS_KEY,True) then
  begin
    MS := TMemoryStream.Create;
    try
      ExcludedProperties.SaveToStream(MS);
      Reg.WriteBinaryData(OS_EP_VALUE,MS.Memory^,MS.Size);
    except
    end;
    MS.Free;
  end;
  Reg.Free;
end;

{ ---------------------------------------------------------------------------- }
initialization
  OS_KEY:=LMDTOOLS_REGISTRYPATH+'\Editors\TLMDObjectStorage';
  ExcludedProperties := TStringList.Create;
  Reg := TRegistry.Create;
  if Reg.OpenKey(OS_KEY,False) then
  begin
    MS := TMemoryStream.Create;
    try
      MS.Size := Reg.GetDataSize(OS_EP_VALUE);
      Reg.ReadBinaryData(OS_EP_VALUE,MS.Memory^,MS.Size);
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
