unit pLMDSedPE;
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

pLMDDsgPE unit (YB)
------------------------
Unit contains property editors needed in  LMD Design Pack

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors, Classes, TypInfo, SyncObjs, Dialogs,
  pLMDCommon;

type
  { ********************* class TLMDSyntaxSchemeProperty ********************* }

  TLMDCodePageProperty = class(TIntegerProperty)
  private
    FSec: TCriticalSection;
    procedure CheckDescrs;
  public
    procedure  AfterConstruction; override;
    destructor Destroy; override;

    function  GetAttributes: TPropertyAttributes; override;
    function  GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { ********************* class TLMDSyntaxSchemeProperty ********************* }

  TLMDSyntaxSchemeProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { ********************* class TLMDColorSchemeProperty ********************** }

  TLMDColorSchemeProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { ******************* class TLMDParserSchemeTextProperty ******************* }

  TLMDParserSchemeTextProperty = class(TClassProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  { ******************** class TLMDEditCommandListProperty ******************* }

  TLMDEditCommandListProperty = class(TClassProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  { ********************* class TLMDEditDocumentEditor *********************** }

  TLMDEditDocumentEditor = class(TComponentEditor)
  private
    procedure LoadSchemes(AIsSyntax: Boolean);
  public
    procedure ExecuteVerb(Index: Integer); override;
    function  GetVerb(Index: Integer): string; override;
    function  GetVerbCount: Integer; override;
  end;

  { ******************** class TLMDSyntaxSchemeDlgProperty ******************* }

  TLMDSyntaxSchemeDlgProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { ********************* class TLMDColorSchemeDlgProperty ******************* }

  TLMDColorSchemeDlgProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

function  LMDReadLastSchemesDir(AIsSyntax: Boolean): string;
procedure LMDWriteLastSchemesDir(AIsSyntax: Boolean; const ADir: string);

implementation

uses
  Registry, SysUtils, Controls, ShlObj, LMDShUtils, LMDUtils, LMDSedConst,
  LMDTypes, LMDSedDocument, LMDSedView, LMDSedColorSchemeDialog,
  LMDSedKeyBindingsDialog, LMDUnicodeEncodings, LMDSedSchemeEditDialog,
  LMDSedDialogs, pLMDCst;

var
  EncDescrs: TLMDEncodingDescrArray;

function LMDReadLastSchemesDir(AIsSyntax: Boolean): string;
begin
  Result := ''; // Initialize.

  with TRegIniFile.Create(LMDTOOLS_REGISTRYPATH) do
  try
    if AIsSyntax then
      Result := ReadString('SyntaxEdit', 'DocumentEditorLastDirSyntax', '')
    else
      Result := ReadString('SyntaxEdit', 'DocumentEditorLastDirColor', '');
  finally
    Free;
  end;
end;

procedure LMDWriteLastSchemesDir(AIsSyntax: Boolean; const ADir: string);
begin
  with TRegIniFile.Create(LMDTOOLS_REGISTRYPATH) do
  try
    if AIsSyntax then
      WriteString('SyntaxEdit', 'DocumentEditorLastDirSyntax', ADir)
    else
      WriteString('SyntaxEdit', 'DocumentEditorLastDirColor', ADir);
  finally
    Free;
  end;
end;

{ ********************* class TLMDSyntaxSchemeProperty *********************** }
{ ------------------------------ public -------------------------------------- }
function TLMDSyntaxSchemeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paRevertable];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSyntaxSchemeProperty.GetValues(Proc: TGetStrProc);
var
  I:       Integer;
  Doc: TLMDEditDocument;
  Schemes: TLMDEditParserSchemeCollection;
begin
  Doc := GetComponent(0) as TLMDEditDocument;
  Schemes := Doc.SyntaxSchemes;

  for I := 0 to Schemes.Count - 1 do
    Proc(Schemes[I].Name);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSyntaxSchemeProperty.SetValue(const Value: string);
var
  Doc: TLMDEditDocument;
  Schemes: TLMDEditParserSchemeCollection;
begin
  Doc := GetComponent(0) as TLMDEditDocument;
  Schemes := Doc.SyntaxSchemes;

  if (Value <> '') and (Schemes.FindItem(Value) = nil) then
    raise EPropertyError.Create(SLMDSedDocSyntaxSchemeNotFound+Value);

  inherited SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }

{ ********************** class TLMDColorSchemeProperty *********************** }
{ ------------------------------ public -------------------------------------- }
function TLMDColorSchemeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paRevertable];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorSchemeProperty.GetValues(Proc: TGetStrProc);
var
  I:       Integer;
  Doc: TLMDEditDocument;
  Schemes: TLMDEditParserSchemeCollection;
begin
  Doc := GetComponent(0) as TLMDEditDocument;
  Schemes := Doc.ColorSchemes;

  for I := 0 to Schemes.Count - 1 do
    Proc(Schemes[I].Name);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorSchemeProperty.SetValue(const Value: string);
var
  Doc: TLMDEditDocument;
  Schemes: TLMDEditParserSchemeCollection;
begin
  Doc := GetComponent(0) as TLMDEditDocument;
  Schemes := Doc.ColorSchemes;

  if (Value <> '') and (Schemes.FindItem(Value) = nil) then
    raise EPropertyError.Create(SLMDSedDocColorSchemeNotFound+Value);

  inherited SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
{ TLMDParserSchemeTextProperty }

procedure TLMDParserSchemeTextProperty.Edit;
var
  Strs: TLMDEditParserSchemeStrings;
  Coll: TLMDEditParserSchemeCollection;
  Doc:  TLMDEditDocument;
begin
  strs := TLMDEditParserSchemeStrings(Pointer(GetOrdValue));

  Coll := Strs.Parent.Collection as TLMDEditParserSchemeCollection;
  Doc  := Coll.Parent;

  if Coll = Doc.SyntaxSchemes then
    LMDEditExecSchemeXMLDialog(strs, skSyntax)
  else
  begin
    Assert(Coll=Doc.ColorSchemes);
    LMDEditExecColorSchemesDialog(Doc, Strs.Parent.Name);
  end;

  SetOrdValue(Integer(strs));
end;

function TLMDParserSchemeTextProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly, paMultiSelect];
end;

{ TLMDEditDocumentEditor }

procedure TLMDEditDocumentEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0:  LoadSchemes(True);
    1:  LoadSchemes(False);
  else
    Assert(False);
  end;
end;

function TLMDEditDocumentEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := SLMDSedLoadSyntaxSchemes;
    1: Result := SLMDSedLoadColorSchemes;
  else
    Assert(False);
  end;
end;

function TLMDEditDocumentEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

procedure TLMDEditDocumentEditor.LoadSchemes(AIsSyntax: Boolean);
var
  coll:             TLMDEditParserSchemeCollection;
  doc:              TLMDEditDocument;
  capt:             TLMDString;
  oldSyn, oldColor: TLMDString;
  folder:           string;
  dlg:              TOpenDialog;
  i:                Integer;
  files:            array of TLMDString;
begin
  doc := Component as TLMDEditDocument;

  if AIsSyntax then
  begin
    coll := doc.SyntaxSchemes;
    capt := SLMDSedLoadSyntaxSchemes;
  end
  else
  begin
    coll := doc.ColorSchemes;
    capt := SLMDSedLoadColorSchemes;
  end;

  oldSyn   := doc.ActiveSyntaxScheme;
  oldColor := doc.ActiveColorScheme;
  folder   := LMDReadLastSchemesDir(AIsSyntax);

  dlg := TOpenDialog.Create(nil);
  try
    dlg.Options    := dlg.Options + [ofAllowMultiSelect];
    dlg.Title      := capt;
    dlg.InitialDir := folder;
    dlg.Filter     := 'Schemes|*.xml|Any files|*.*';

    if dlg.Execute and (dlg.Files.Count > 0) then
    begin
      SetLength(files, dlg.Files.Count);
      for i := 0 to High(files) do
        files[i] := dlg.Files[i];

      coll.LoadFromFiles(files);

      if doc.SyntaxSchemes.FindItem(oldSyn)<>nil then
        doc.ActiveSyntaxScheme := oldSyn;

      if doc.ColorSchemes.FindItem(oldColor)<>nil then
        doc.ActiveColorScheme := oldColor;

      LMDWriteLastSchemesDir(AIsSyntax, ExtractFilePath(dlg.Files[0]));
      Designer.Modified;
    end;
  finally
    dlg.Free;
  end;
end;

{ TLMDEditCommandListProperty }

procedure TLMDEditCommandListProperty.Edit;
var
  Cmds: TLMDEditCommandList;
begin
  Cmds := TLMDEditCommandList(Pointer(GetOrdValue));

  if LMDEditExecKeyBindingsDialog(Cmds.Parent) then
    SetOrdValue(Integer(Cmds));
end;

function TLMDEditCommandListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

{ TLMDCodePageProperty }

procedure TLMDCodePageProperty.CheckDescrs;
begin
  FSec.Acquire;
  try
    if EncDescrs=nil then
      EncDescrs := TLMDEncoding.GetDescriptions(true);
  finally
    FSec.Release;
  end;
end;

procedure TLMDCodePageProperty.AfterConstruction;
begin
  inherited;
  FSec := TCriticalSection.Create;
end;

destructor TLMDCodePageProperty.Destroy;
begin
  FSec.Free;
  inherited;
end;

function TLMDCodePageProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paRevertable];
end;

function TLMDCodePageProperty.GetValue: string;
var
  i, CP, found: Integer;
begin
  CheckDescrs;
  CP := StrToInt(inherited GetValue);

  found := -1;
  for i := 0 to Length(EncDescrs) - 1 do
    if EncDescrs[i].CodePage=CP then
    begin
      Found := i;
      Break;
    end;

  if found<>-1 then
    Result := EncDescrs[found].Names[0]
  else
    Result := inherited GetValue;
end;

procedure TLMDCodePageProperty.GetValues(Proc: TGetStrProc);
var
  i: Integer;
begin
  CheckDescrs;

  for i := 0 to Length(EncDescrs) - 1 do
    Proc(EncDescrs[i].Names[0]);
end;

procedure TLMDCodePageProperty.SetValue(const Value: string);
var
  i,j, found: Integer;
  Val, Name: string;
  CP: Integer;
begin
  CheckDescrs;

  Val := Trim(Value);
  found := -1;

  for i := 0 to Length(EncDescrs) - 1 do
    for j := 0 to Length(EncDescrs[i].Names) - 1 do
      if UpperCase(EncDescrs[i].Names[j])=UpperCase(Val) then
      begin
        found := i;
        Break
      end;

  if found<>-1 then
    Name := IntToStr(EncDescrs[found].CodePage)
  else
    Name := Val;

  try
    CP := StrToInt(Name);
    if not TLMDEncoding.IsEncodingValid(CP) then
      Raise ELMDEncodingError.CreateFmt(SLMDSedBadEncodingName, [Name]);

    inherited SetValue(Name);
  except
    On E: EConvertError Do
      if found<>-1 then
        Raise
      else
        Raise ELMDEncodingError.CreateFmt(SLMDSedBadEncodingName, [Name]);
  end;
end;

{ TLMDSyntaxSchemeDlgProperty }

function TLMDSyntaxSchemeDlgProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paRevertable];
end;

procedure TLMDSyntaxSchemeDlgProperty.GetValues(Proc: TGetStrProc);
var
  I:       Integer;
  Dlg:     TLMDEditSyntaxSchemeDialog;
  Doc:     TLMDEditDocument;
  Schemes: TLMDEditParserSchemeCollection;
begin
  Dlg := GetComponent(0) as TLMDEditSyntaxSchemeDialog;
  Doc := Dlg.Document;

  if Doc<>nil then
  begin
    Schemes := Doc.SyntaxSchemes;

    for I := 0 to Schemes.Count - 1 do
      Proc(Schemes[I].Name);
  end;
end;

procedure TLMDSyntaxSchemeDlgProperty.SetValue(const Value: string);
var
  Doc: TLMDEditDocument;
  Schemes: TLMDEditParserSchemeCollection;
  Dlg: TLMDEditSyntaxSchemeDialog;
begin
  Dlg := GetComponent(0) as TLMDEditSyntaxSchemeDialog;
  Doc := Dlg.Document;

  if Doc<>nil then
  begin
    Schemes := Doc.SyntaxSchemes;

    if (Value <> '') and (Schemes.FindItem(Value) = nil) then
      raise EPropertyError.Create(SLMDSedDocSyntaxSchemeNotFound+Value);
  end;

  inherited SetValue(Value);
end;

{ TLMDColorSchemeDlgProperty }

function TLMDColorSchemeDlgProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paRevertable];
end;

procedure TLMDColorSchemeDlgProperty.GetValues(Proc: TGetStrProc);
var
  I:       Integer;
  Dlg:     TLMDEditColorSchemeDialog;
  Doc:     TLMDEditDocument;
  Schemes: TLMDEditParserSchemeCollection;
begin
  Dlg := GetComponent(0) as TLMDEditColorSchemeDialog;
  Doc := Dlg.Document;

  if Doc<>nil then
  begin
    Schemes := Doc.ColorSchemes;

    for I := 0 to Schemes.Count - 1 do
      Proc(Schemes[I].Name);
  end;
end;

procedure TLMDColorSchemeDlgProperty.SetValue(const Value: string);
var
  Doc: TLMDEditDocument;
  Schemes: TLMDEditParserSchemeCollection;
  Dlg: TLMDEditColorSchemeDialog;
begin
  Dlg := GetComponent(0) as TLMDEditColorSchemeDialog;
  Doc := Dlg.Document;

  if Doc<>nil then
  begin
    Schemes := Doc.ColorSchemes;

    if (Value <> '') and (Schemes.FindItem(Value) = nil) then
      raise EPropertyError.Create(SLMDSedDocColorSchemeNotFound+Value);
  end;

  inherited SetValue(Value);
end;

initialization
  EncDescrs := nil;

end.

