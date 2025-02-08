unit LMDPluginModuleEditor;
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

LMDPluginManagerEditor unit (AIH)
-------------------------------
Description
LMDPluginManager editor

ToDo
----

Changes
-------

Release 0.2 (February 2008)
* Initial Release

###############################################################################}
interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  StdCtrls,
  DesignEditors, DesignWindows, DsnConst, DesignIntf;

type
  TLMDPluginModuleEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation

uses
  LMDPluginImpl, StrUtils, TypInfo, LMDXML, LMDPluginManager, LMDPluginModule;
  procedure TLMDPluginModuleEditor.ExecuteVerb(Index: Integer);

  function GetTypeName(AType: TLMDParameterType): string;
  begin
    Result := GetEnumName(TypeInfo(TLMDParameterType), Integer(AType));
  end;

  procedure SaveToXML(AModule: TLMDPluginModule; APath: String);
  var
    xmlDoc: ILMDXmlDocument;
    docEl,
    LElement: ILMDXmlElement;
    LActions,
    LParams: ILMDXmlElement;
    i, j: Integer;
    LPar: TLMDCustomPluginParameter;
  begin
    xmlDoc := LMDCreateXmlDocument('LMDPlugin', '1.0', 'UTF-8');
    docEl := xmlDoc.DocumentElement;
    docEl.SetAttr('Author', AModule.Author);
    docEl.SetAttr('ProjectFolder', AModule.ProjectFolder);
    docEl.SetAttr('MajorVersion', IntToStr(AModule.MajorVersion));
    docEl.SetAttr('MinorVersion', IntToStr(AModule.MinorVersion));
    docEl.SetAttr('FileName', AModule.FileName);
    docEl.SetAttr('Description', AModule.Description);

    LActions := xmlDoc.CreateElement('Actions');
    docEl.AppendChild(LActions);

    for i := 0 to AModule.Actions.Count - 1 do
    begin
      LElement := xmlDoc.CreateElement('Action');
      LActions.AppendChild(LElement);
      LElement.SetAttr('name', TLMDAction(AModule.Actions.Items[i]).Name);
      for j := 0 to TLMDCustomPluginAction(AModule.Actions.Items[i]).Parameters.Count - 1 do
      begin
        LPar := TLMDCustomPluginParameter(TLMDCustomPluginAction(AModule.Actions.Items[i]).Parameters.Items[j]);
        LParams := xmlDoc.CreateElement('Parameter');
        LElement.AppendChild(LParams);
        LParams.SetAttr('Name', LPar.Name);
        LParams.SetAttr('IsOptional', IfThen(LPar.IsOptional, 'true', 'false'));
        LParams.SetAttr('Type', GetTypeName(LPar.ParamType));        
      end;
    end;

    xmlDoc.Save(APath);
  end;

function GetParamType(AType: string): TLMDParameterType;
  begin
    if AType = '' then
      Result := ptPointer
    else
      Result := TLMDParameterType(GetEnumValue(TypeInfo(TLMDParameterType), AType));
  end;

procedure LoadFromXML(AModule: TLMDPluginModule; APath: string);
  var
    xmlDoc: ILMDXmlDocument;
    xmlActions,
    xmlParams: ILMDXmlNodeList;
    i, j: Integer;
    LActionItem: TLMDCustomPluginAction;
    LParamItem: TLMDCustomPluginParameter;    
  begin
    AModule.Actions.Clear;
    xmlDoc := LMDLoadXmlDocument(APath);
    AModule.ProjectFolder := xmlDoc.DocumentElement.GetAttr('ProjectFolder', '');
    AModule.Author := xmlDoc.DocumentElement.GetAttr('Author', '');
    AModule.Description := xmlDoc.DocumentElement.GetAttr('Description', '');
    AModule.FileName := xmlDoc.DocumentElement.GetAttr('FileName', '');
    AModule.MajorVersion := xmlDoc.DocumentElement.GetIntAttr('MajorVersion', 0);
    AModule.MinorVersion := xmlDoc.DocumentElement.GetIntAttr('MinorVersion', 0);
    xmlActions := xmlDoc.DocumentElement.GetElementsByTagName('Actions');
    if xmlActions.Count > 0 then
    begin
      xmlActions := xmlActions.Item[0].GetElementsByTagName('Action');
      for i := 0 to xmlActions.Count - 1 do
      begin
        LActionItem := TLMDCustomPluginAction(AModule.Actions.Add());
        LActionItem.Name := xmlActions.Item[i].GetAttr('name', '');
        xmlParams := xmlActions.Item[i].GetElementsByTagName('Parameter');
        for j := 0 to xmlParams.Count - 1 do
        begin
          LParamItem := TLMDCustomPluginParameter(LActionItem.Parameters.Add());
          LParamItem.Name := xmlParams.Item[j].GetAttr('name', '');
          LParamItem.IsOptional := UpperCase(xmlParams.Item[j].GetAttr('IsOptional', '')) = 'TRUE';
          LParamItem.ParamType := GetParamType(xmlParams.Item[j].GetAttr('Type', '')); 
        end;
      end;
    end;
  end;
  var
  SaveDialog: TSaveDialog;
  OpenDialog: TOpenDialog;
begin
  case Index of
    0:
    begin
      SaveDialog := TSaveDialog.Create(nil);
      SaveDialog.Filter := 'XML Files (*.xml)|*.xml';
      if SaveDialog.Execute then
        SaveToXML(Component as TLMDPluginModule, SaveDialog.FileName);
      SaveDialog.Free;
    end;
    1:
    begin
      OpenDialog := TOpenDialog.Create(nil);
      OpenDialog.Filter := 'XML Files (*.xml)|*.xml';
      if OpenDialog.Execute then
        LoadFromXML(Component as TLMDPluginModule, OpenDialog.FileName);
      OpenDialog.Free;
    end;
  end;
end;

function TLMDPluginModuleEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '&Save to XML';
    1: Result := '&Load from XML';
  end;
end;

function TLMDPluginModuleEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

end.
