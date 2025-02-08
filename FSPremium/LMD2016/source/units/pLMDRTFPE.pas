unit pLMDRTFPE;
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

pLMDRTFPE unit (RM)
-------------------
Property Editors for LMD RichPack.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Controls, Dialogs,
  ActnMan, ActnCtrls, DesignIntf, DesignEditors, VCLEditors, ActnMenus, ToolsAPI, ColnEdit,
  LMDRTFStorage, LMDRTFRichEdit, LMDRTFHyperTextStorage,
  LMDRTFSyntaxEdit, LMDRTFLabel;

type
  {-----------------  Class TRTFLinesProperty ---------------------------------}
  TRTFLinesProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  {-----------------  Class TRTFSyntaxDefsProperty ----------------------------}
  TRTFSyntaxDefsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  {-----------------  Class TRTFHyperTextLinesProperty  -----------------------}
  TRTFHyperTextLinesProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  {-----------------  Class TRTFStorageItemProperty ---------------------------}
  TRTFStorageItemProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    function GetValue:String; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue( const aValue: String); override;
  end;

  {-----------------  Class TRTFStorageItemsProperty  -------------------------}
  // ToDo
  TRTFStorageItemsProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;
  implementation

uses
  ActnList, Menus, TypInfo,
  StFilSys,
  pLMDRTFEditor, pLMDRTFHyperTextEditor, pLMDRTFSyntaxDefEditor, pLMDRTFRichEditor;
type

  {-----------------  Class TStringsModuleCreator -----------------------------}
  TStringsModuleCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  private
    FFileName: string;
    FStream: TStringStream;
    FAge: TDateTime;
  public
    constructor Create(const FileName: string; Stream: TStringStream; Age: TDateTime);
    destructor Destroy; override;
    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    { IOTAModuleCreator }
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
  function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
  function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
  function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
  procedure FormCreated(const FormEditor: IOTAFormEditor);
  end;

  TOTAFile = class(TInterfacedObject, IOTAFile)
  private
    FSource: string;
    FAge: TDateTime;
  public
    constructor Create(const ASource: string; AAge: TDateTime);
    { IOTAFile }
    function GetSource: string;
  function GetAge: TDateTime;
  end;
  //function TRTFLinesProperty.GetValue:String;
//begin Result:= '(TLMDRichText)' end;
{------------------------------------------------------------------------------}
function TRTFLinesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties]
end;

{------------------------------------------------------------------------------}

procedure TRTFLinesProperty.Edit;
var
  Ident: string;
  LComponent: TComponent;
  Module: IOTAModule;
  ModuleServices: IOTAModuleServices;
  PT, WW, AO: Boolean;
  Lines: TStrings;
begin
  WW := True;
  AO := True;

  ModuleServices:= BorlandIDEServices as IOTAModuleServices;

  LComponent:= TComponent(GetComponent(0));
  if (TObject(LComponent) is TComponent) and
    (LComponent.Owner = Self.Designer.GetRoot) then
  begin
    Ident := Self.Designer.GetRoot.Name + '.' +
      LComponent.Name + '.' + GetName;
    Module:= ModuleServices.FindModule(Ident);
  end
  else
  if (TObject(LComponent) is TLMDRichStorageItem) and
      (TLMDRichStorageItems((TObject(LComponent) as TLMDRichStorageItem).Collection).Storage.Owner =
     Self.Designer.GetRoot) then
  begin
    Ident:= Self.Designer.GetRoot.Name + '.' +
      TLMDRichStorageItems(TLMDRichStorageItem(TObject(LComponent)).Collection).Storage.Name +
      '.Items[' + IntToStr(TLMDRichStorageItem(TObject(LComponent)).Index) + '].' + GetName;
    Module:= ModuleServices.FindModule(Ident);
  end
  else
    Module := nil;

  if (Module <> nil) and (Module.GetModuleFileCount > 0) then
    Module.GetModuleFileEditor(0).Show
  else
    begin
      PT := False;

      if LComponent is TLMDCustomRichEdit then
        begin
          WW := TLMDCustomRichEdit(LComponent).WordWrap;
          AO := TLMDCustomRichEdit(LComponent).AllowObjects;
          PT := TLMDCustomRichEdit(LComponent).PlainText;
        end
      else
      if  LComponent is TLMDCustomRichLabel  then
        begin
          WW := TLMDCustomRichLabel(LComponent).WordWrap;
          AO := TLMDCustomRichLabel(LComponent).AllowObjects;
        end;

      Lines := TStrings(GetOrdValue);

      if PT then
        if TfrmLMDRichEditorForm.ExecuteEx(Ident, Lines) then
          Self.Designer.Modified
        else
      else
        if TfrmLMDRichEditorForm.ExecuteRTFStrings(Ident, Lines, WW, AO) then
          Self.Designer.Modified;
    end;
end;

{------------------------------------------------------------------------------}
function TRTFHyperTextLinesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties]
end;

{------------------------------------------------------------------------------}
procedure TRTFHyperTextLinesProperty.Edit;
var
  M: TMemoryStream;
  Stream: TStringStream;
  Age: TDateTime;
  Module: IOTAModule;
  ModuleServices: IOTAModuleServices;
  Editor: IOTAEditor;
  Ident: string;
  Component: TComponent;
begin
  M := nil;
  Stream := nil;
  Component := TComponent(GetComponent(0));

  ModuleServices:= BorlandIDEServices as IOTAModuleServices;

  if (Component is TComponent) and
    (Component.Owner = Self.Designer.GetRoot) then
  begin
    Ident := Self.Designer.GetRoot.Name + '.' +
      Component.Name + '.' + GetName;
    Module:= ModuleServices.FindModule(Ident);
  end
  else begin
    if (GetComponent(0) is TLMDRichHyperTextStorageItem) and
        (TLMDRichHyperTextStorageItems(TLMDRichHyperTextStorageItem(GetComponent(0)).Collection).Storage.Owner =
       Self.Designer.GetRoot) then
    begin
      Ident:= Self.Designer.GetRoot.Name + '.' +
        TLMDRichHyperTextStorageItems(TLMDRichHyperTextStorageItem(GetComponent(0)).Collection).Storage.Name +
        '.Items[' + IntToStr(TLMDRichHyperTextStorageItem(GetComponent(0)).Index) + '].' + GetName;
      Module:= ModuleServices.FindModule(Ident);
    end else Module := nil;
  end;

  if (Module <> nil) and (Module.GetModuleFileCount > 0) then
    Module.GetModuleFileEditor(0).Show
  else begin
    with TfrmLMDRTFHyperTextEditor.Create(nil) do
    try
      Caption:= Caption + ' - ' + Ident;
      M:= TMemoryStream.Create;
      if Component is TLMDCustomRichEdit then begin
         LMDRichEdit.PlainText:= TLMDCustomRichEdit(Component).PlainText;
         LMDRichEdit.WordWrap:= TLMDCustomRichEdit(Component).WordWrap;
         LMDRichEdit.Alignment:= TLMDCustomRichEdit(Component).Alignment;
         LMDRichEdit.MaxLength:= TLMDCustomRichEdit(Component).MaxLength;
         LMDRichEdit.Font:= TLMDCustomRichEdit(Component).Font;
      end;
      TStrings(GetOrdValue).SaveToStream( M);
      M.Position := 0;    //Seek( soFromBeginning, 0);
      LMDRichEdit.Lines.LoadFromStream( M);
      btnCodeEditor.Enabled := Component is TLMDCustomRichEdit;
      case ShowModal of
        mrOk: begin
           M.Clear;
           LMDRichEdit.Lines.SaveToStream( M);
           M.Position := 0;
           TStrings(GetOrdValue).LoadFromStream( M);
           Self.Designer.Modified;
        end;
        mrYes:
          begin
            StFilSys.Register;
            Stream := TStringStream.Create('');
            if  MessageDlg('Edit as RTF text?'+#13+#10+'Warning! if you select '+#39+'No'+#39+
                ', then all additional info will be removed!', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
               LMDRichEdit.Lines.SaveToStream(Stream)
            else
               Stream.Write(PChar(LMDRichEdit.Lines.Text)^, Length(LMDRichEdit.Lines.Text));
            Stream.Position := 0;
            Age:= Now;
  //          ModuleServices := BorlandIDEServices as IOTAModuleServices;
            Module:= ModuleServices.CreateModule(
              TStringsModuleCreator.Create(Ident, Stream, Age));
            if Module <> nil then begin
              Editor := Module.GetModuleFileEditor(0);
              if Editor <> nil then begin
                 Editor.MarkModified;
                 Editor.Show;
              end;
            end;
          end;
     end;
    finally
      Stream.Free;
      M.Free;
      Free;
    end;
  end;
end;

{ TRTFSyntaxDefsProperty }
{------------------------------------------------------------------------------}
procedure TRTFSyntaxDefsProperty.Edit;
var
  M: TStringStream;
begin
  with TfrmSyntaxDefEditor.Create( nil) do
  begin
    try
      M:= TStringStream.Create('');
      try
      TLMDCustomRichSyntaxEdit(GetComponent(0)).SyntaxDefinition.SaveToStream( M);
    M.Seek(soFromBeginning, 0);
    LMDSyntaxEdit1.Lines.LoadFromStream( M);
      if ShowModal = mrOK then begin
      M.Seek(soFromBeginning, 0);
      LMDSyntaxEdit1.Lines.SaveToStream( M);
      M.Seek(soFromBeginning, 0);
      TLMDCustomRichSyntaxEdit(GetComponent(0)).SyntaxDefinition.LoadFromStream( M);
      end;
      finally
        M.Free;
      end;
    finally
      Free;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TRTFSyntaxDefsProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= inherited GetAttributes + [paDialog];
end;

{------------------------------------------------------------------------------}
{ TRTFStorageItemProperty }
procedure TRTFStorageItemProperty.Edit;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
function TRTFStorageItemProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paValueList]
end;

{------------------------------------------------------------------------------}
function TRTFStorageItemProperty.GetValue: String;
begin
  result:= IntToStr( GetOrdValue);
end;

{------------------------------------------------------------------------------}
procedure TRTFStorageItemProperty.GetValues(Proc: TGetStrProc);
var
//  Collection: TCollection;
  I: LongInt;
  C: TPersistent;
  Storage: TLMDRichStorage;
begin
  inherited;
  C := GetComponent(0);
  if C is TLMDCustomRichEdit then
    Storage:= TLMDCustomRichEdit(C).RichStorage
  else if C is TLMDCustomRichLabel then
    Storage:= TLMDCustomRichLabel(C).RichStorage
  else
    Storage := nil;
{
  if C is TLMDCustomRichEdit and Assigned(then
    Collection:= TLMDCustomRichEdit(C).RichStorage.Items
  else if C is TLMDCustomRichLabel then
    Collection:= TLMDCustomRichLabel(C).RichStorage.Items
  else
    Exit;
}
  if  Assigned(Storage) then
    for I:= 0 to Storage.Items.Count - 1 do
      Proc( IntToStr(I) + ' - ' + Storage.Items[I].DisplayName);
end;

{------------------------------------------------------------------------------}
procedure TRTFStorageItemProperty.SetValue(const aValue: String);
var
  i, V: integer;
begin
  if  Trim(aValue) = '' then
    V := -1
  else
    begin
      i := Pos(' ', aValue);

      if  i > 0 then
        V := StrToInt(Copy(aValue, 1, i - 1))
      else
        V := StrToInt(aValue);
    end;

  SetOrdValue(V);

//   SetOrdValue( StrToInt( Copy( aValue, 1, Pos( ' ', aValue) - 1)));
end;

{------------------------------------------------------------------------------}
{ TRTFStorageItemsProperty }
{------------------------------------------------------------------------------}

type
  TLMDRTFStorageColEditor = class(TCollectionEditor)
    procedure SelectionUpdate(Sender: TObject);
  private
    FEditorAction: TAction;
    Prop: IProperty;
    procedure int_GetPropEditProc(const Prop: IProperty);
  protected
    procedure Loaded; override;
    procedure OpenEditor(Sender:TObject);
  public
  end;

{------------------------------------------------------------------------------}

procedure TLMDRTFStorageColEditor.Loaded;
var
  FItemMenu: TMenuItem;
begin
  inherited Loaded;

  ListView1.OnDblClick := OpenEditor;
  FEditorAction := TAction.Create(self);
  FEditorAction.Caption := 'Item Editor';
  FEditorAction.OnExecute := OpenEditor;
  FEditorAction.OnUpdate := SelectionUpdate;
  FItemMenu := TMenuItem.Create(PopupMenu1);
  FItemMenu.Action := FEditorAction;
  PopupMenu1.Items.Add(FItemMenu);
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFStorageColEditor.int_GetPropEditProc(const Prop: IProperty);
begin
  if  Assigned(Prop) and SameText(Prop.GetName, 'Lines') then
    self.Prop := Prop;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFStorageColEditor.OpenEditor(Sender:TObject);
var
  Itm: TCollectionItem;
  Components: IDesignerSelections;
begin
  if  (ListView1.Selected <> nil) then
    begin
      Prop := nil;
      Components := TDesignerSelections.Create;

      try
        Itm := Collection.Items[ListView1.Selected.Index];
        Components.Add(Itm);
        GetComponentProperties(Components, [tkClass], Designer, int_GetPropEditProc);
        Components := nil;

        if  Assigned(Prop)  then
          Prop.Edit;
      finally
        Prop := nil;
        Components := nil;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFStorageColEditor.SelectionUpdate(Sender: TObject);
begin
  inherited ;

  FEditorAction.Enabled := (ListView1.Selected <> nil);
end;

{------------------------------------------------------------------------------}

function TRTFStorageItemsProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TLMDRTFStorageColEditor;
end;

{------------------------------------------------------------------------------}
{ TStringsModuleCreator }
{------------------------------------------------------------------------------}
constructor TStringsModuleCreator.Create(const FileName: string; Stream: TStringStream;
  Age: TDateTime);
begin
  inherited Create;
  FFileName := FileName;
  FStream:= Stream;
  FAge:= Age;
end;

{------------------------------------------------------------------------------}
destructor TStringsModuleCreator.Destroy;
begin
  FStream.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TStringsModuleCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin
  { Nothing to do }
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetAncestorName: string;
begin
  Result := ''
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetCreatorType: string;
begin
  Result := sText;
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetExisting: Boolean;
begin
  Result:= False
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetFileSystem: string;
begin
  Result:= {sTStringsFileSystem;}'Delphi.TStringsFileSystem'
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetFormName: string;
begin
  Result:= ''
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetImplFileName: string;
begin
  Result:= FFileName
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetIntfFileName: string;
begin
  Result:= ''
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetMainForm: Boolean;
begin
  Result:= False
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetOwner: IOTAModule;
begin
  Result:= nil
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetShowForm: Boolean;
begin
  Result:= False
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetShowSource: Boolean;
begin
  Result:= True
end;

{------------------------------------------------------------------------------}
function TStringsModuleCreator.GetUnnamed: Boolean;
begin
  Result:= False
end;

{------------------------------------------------------------------------------}

function TStringsModuleCreator.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;

begin
  Result:= nil
end;

{------------------------------------------------------------------------------}

function TStringsModuleCreator.NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;

begin
  Result:= TOTAFile.Create(FStream.DataString, FAge)
end;

{------------------------------------------------------------------------------}

function TStringsModuleCreator.NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;

begin
  Result:= nil
end;

{ TOTAFile }
{------------------------------------------------------------------------------}
constructor TOTAFile.Create(const ASource: string; AAge: TDateTime);
begin
  inherited Create;
  FSource := ASource;
  FAge := AAge;
end;

{------------------------------------------------------------------------------}

function TOTAFile.GetAge: TDateTime;

begin
  Result := FAge;
end;

{------------------------------------------------------------------------------}
function TOTAFile.GetSource: string;
begin
  Result := FSource;
end;

end.
