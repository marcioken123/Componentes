unit LMDSctImporterUnitDoc;
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

LMDSctImporterUnitDoc unit (YB)
-------------------------------
LMD Script Pack Importer non-visual path of import  working document.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, Math, LMDTypes, LMDHashTable, LMDXML,
  LMDSctImporterFileUtils, LMDSctImporterParser, LMDSctImporterTree;

type
  TLMDUnitDocument = class;

  {************************ class ILMDUnitDocNotifier *************************}

  ILMDUnitDocNotifier = class
  public
    procedure Modified(Sender: TLMDUnitDocument); virtual; abstract;
    procedure AnalizeProgress(Sender: TLMDUnitDocument; ADeclsCount,
                              AAnalizedCount: Integer); virtual; abstract;
    function  PreprocessUsedUnit(Sender: TLMDUnitDocument; const AUnitName: string;
                                 out AUSUPath: string): Boolean; virtual; abstract;
    procedure UsedElemReferenced(Sender: TLMDUnitDocument; const AUnitName,
                                 AElemFullName: string); virtual; abstract;
  end;

  {********************* class ILMDUnitDocSourceProvider **********************}

  ILMDUnitDocSourceProvider = class
  protected
    function GetSource: string; virtual; abstract;
  end;

  {********************** class ILMDUnitDocEnvironment ************************}

  ILMDUnitDocEnvironment = class
  public
    procedure MakeStandardDefines(AParser: TLMDPasParser); virtual; abstract;
    procedure GetLibPaths(AResult: TStrings); virtual; abstract;
    function  GetVCLImportSubpath: string; virtual; abstract;
    procedure GetStandardWrapperUsedUnits(AResult: TStrings); virtual; abstract;
    procedure GetNamespacePrefixes(AResult: TStrings); virtual; abstract;
    function  FindDirectiveConst(const AConstName: string;
                                 out AValue: Variant): Boolean; virtual; abstract;
  end;

  {*********************** class TLMDUnitDocNodeData **************************}

  TLMDUnitDocNodeHint = record
    IsSpecified:     Boolean;
    ConstTypeRepl:   string;
    OverloadChecked: Boolean;
  end;

  TLMDUnitDocNodeData = class
  public
    constructor Create;
  public
    Node:          TLMDPasNamedNode;
    FullName:      string;
    Checked:       Boolean;
    ConstTypeRepl: string;
    Hint:          TLMDUnitDocNodeHint;
  end;

  {************************* class TLMDUnitDocument ***************************}

  TLMDUnitDocIterateContext = class;
  TLMDUnitDocIterateProc    = procedure(C: TLMDUnitDocIterateContext;
                                        ANode: TLMDPasNamedNode;
                                        AData: TLMDDataTag) of object;
  TLMDUnitDocIterateContext = class
  private
    FNode: TLMDPasNamedNode;
    FProc: TLMDUnitDocIterateProc;

    procedure IterateNodes(ANodes: TLMDPasNamedNodes;
                           AData: TLMDDataTag);
  public
    procedure IterateChildren(AData: TLMDDataTag);
  end;

  TLMDUnitDocMessageKind = (mkUnknown, mkParseError, mkInfo, mkWarning,
                            mkError);
  TLMDUnitDocMessage     = record
    Kind:     TLMDUnitDocMessageKind;
    Text:     string;
    FileName: string;
    Node:     TLMDPasNamedNode;
  end;

  TLMDUnitDocument = class
  private
    FEnv:                   ILMDUnitDocEnvironment;
    FParsed:                Boolean;
    FParseTree:             TLMDPasUnit;
    FDataItems:             TLMDHashTable;
    FMessages:              array of TLMDUnitDocMessage;
    FMessageCount:          Integer;
    FNotifiers:             TList;
    FFileHandler:           TLMDFileHandler;
    FIsSysLibDoc:           Boolean;
    FLastAnalizeSucceds:    Boolean;
    FIsLocked:              Boolean;
    FAnalizedDeclsCount:    Integer;
    FSourceProvider:        ILMDUnitDocSourceProvider;
    FGenAdditionalInfo:     Boolean;

    function  GetUnitPath: string;
    function  GetWrapperUnitPath: string;
    function  GetUSUPath: string;
    function  GetNodeChecked(ANode: TLMDPasNamedNode): Boolean;
    procedure SetNodeChecked(ANode: TLMDPasNamedNode; AValue: Boolean);
    function  GetNodeFullName(ANode: TLMDPasNamedNode): string;
    function  GetNodeHint(ANode: TLMDPasNamedNode): string;
    function  GetConstTypeRepl(ANode: TLMDPasConstDecl): string;
    procedure SetConstTypeRepl(ANode: TLMDPasConstDecl; const AValue: string);
    procedure SetIsLocked(const Value: Boolean);
    procedure SetIsSysLibDoc(const Value: Boolean);
    function  FindDirectiveConstProc(const AConstName: string;
                                     out AValue: Variant): Boolean;
    function  GetMessageCount: Integer;
    function  GetMessages(Index: Integer): TLMDUnitDocMessage;
    procedure SaveItemProc(AItem: TObject; AUserData: TLMDDataTag);
    procedure SaveHintsProc(AItem: TObject; AUserData: TLMDDataTag);
    procedure ClearHintsProc(AItem: TObject);
    procedure ApplyHintsProc(AItem: TObject);
    procedure AssociateProc(C: TLMDUnitDocIterateContext;
                            ANode: TLMDPasNamedNode; AData: TLMDDataTag);
    procedure DissociateItemProc(AItem: TObject);
    procedure UncheckErrorsProc(AItem: TObject);
  protected
    procedure AnalizeProgress;                                    // Called by
    function  PreprocessUsedUnit(const AUnitName: string;         // analyzer.
                                 out AUSUPath: string): Boolean;  //
    procedure UsedElemReferenced(const AUnitName,                 //
                                 AElemFullName: string);          //
    procedure AddMessage(const M: TLMDUnitDocMessage);            //
    procedure ClearMessages;                                      //

    procedure FreeParseTree;
    function  DoParse: Boolean;
    function  DoAnalize: Boolean;
    procedure DoGenerate;
    procedure DoApplyHint(AItem: TLMDUnitDocNodeData);

    function  LoadSourceFromFile(const AFilePath: string): string;
    function  GetSource: string;

    procedure LoadState;
    procedure SaveState;
    procedure SaveAsUsedUnit;

    function  FindDataItem(const AFullName: string): TLMDUnitDocNodeData;
    function  GetNodeData(ANode: TLMDPasNamedNode): TLMDUnitDocNodeData;

    procedure DissociateData;
    procedure AssociateData;
  public
    constructor Create(const AUnitFilePath: string;
                       AEnv: ILMDUnitDocEnvironment;
                       ASourceProvider: ILMDUnitDocSourceProvider = nil;
                       AMakeAnalize: Boolean = True);
    destructor Destroy; override;

    procedure Reload(AMakeAnalize: Boolean = True);
    procedure Save;
    procedure Renamed(const ANewUnitPath: string);
    procedure MarkModified;

    function  Parse: Boolean;
    function  Analize(GenWrapperFile: Boolean): Boolean;
    function  FindNode(const AFullName: string): TLMDPasNamedNode;
    procedure UncheckNodesWithErrors;
    procedure MarkUnparsed;
    procedure Iterate(AProc: TLMDUnitDocIterateProc; AData: TLMDDataTag);

    procedure SaveHints(const AXml: ILMDXmlDocument);
    procedure LoadHints(const AXml: ILMDXmlDocument);
    procedure ApplyHint(ANode: TLMDPasNamedNode);
    procedure ApplyAllHints;

    procedure AddNotifier(ANotifier: ILMDUnitDocNotifier);
    procedure RemoveNotifier(ANotifier: ILMDUnitDocNotifier);

    procedure GetStandardWrapperUsedUnits(AResult: TStrings);

    property FileHandler: TLMDFileHandler read FFileHandler;
    property UnitPath: string read GetUnitPath;
    property WrapperUnitPath: string read GetWrapperUnitPath;
    property USUPath: string read GetUSUPath;

    property Parsed: Boolean read FParsed;
    property ParseTree: TLMDPasUnit read FParseTree;
    property NodeChecked[ANode: TLMDPasNamedNode]: Boolean read GetNodeChecked write SetNodeChecked;
    property NodeFullName[ANode: TLMDPasNamedNode]: string read GetNodeFullName;
    property NodeHint[ANode: TLMDPasNamedNode]: string read GetNodeHint;
    property ConstTypeRepl[ANode: TLMDPasConstDecl]: string read GetConstTypeRepl write SetConstTypeRepl;

    property IsSysLibDoc: Boolean read FIsSysLibDoc write SetIsSysLibDoc;
    property IsLocked: Boolean read FIsLocked write SetIsLocked;
    property GenAdditionalInfo: Boolean read FGenAdditionalInfo write FGenAdditionalInfo;

    property Messages[Index: Integer]: TLMDUnitDocMessage read GetMessages;
    property MessageCount: Integer read GetMessageCount;
    property LastAnalizeSucceds: Boolean read FLastAnalizeSucceds;
  end;

procedure SaveStringToStream(AStream: TStream; AValue: string);
function  LoadStringFromStream(AStream: TStream): string;

implementation

uses
  LMDSctCst, LMDSctImporterCompiler;

{ ---------------------------------------------------------------------------- }

type
  TDataItemsTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
    class function OnUpdate(AItem: TObject): TLMDHashUpdateAction; override;
  end;

const
  STATE_FILE_MAGIC_NUM:   Longint = $ABCDEF; // Random format signature.
  STATE_FILE_CUR_VERSION: Longint = 5;

{ ---------------------------------------------------------------------------- }

procedure SaveStringToStream(AStream: TStream; AValue: string);
var
  len: Longint;
  i: Integer;
  b: Byte;
begin
  len := Length(AValue);
  AStream.Write(len, SizeOf(Longint));

  for i := 0 to len - 1 do
  begin
    b := Byte(AValue[i + 1]);
    AStream.Write(b, 1);
  end;
end;

{ ---------------------------------------------------------------------------- }

function LoadStringFromStream(AStream: TStream): string;
var
  len: Longint;
  i: Integer;
  b: Byte;
begin
  AStream.Read(len, SizeOf(Longint));
  SetLength(Result, len);

  for i := 0 to len - 1 do
  begin
    AStream.Read(b, 1);
    Result[i + 1] := Char(b);
  end;
end;

{************************* class TLMDUnitDocNodeData **************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDUnitDocNodeData.Create;
begin
  inherited;
  Checked := True;
end;

{************************** class TLMDUnitDocument ****************************}
{ ---------------------------------- private --------------------------------- }

function TLMDUnitDocument.GetWrapperUnitPath: string;
begin
  Result := FFileHandler.GetWrapperUnitSavePath(FIsSysLibDoc);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.Iterate(AProc: TLMDUnitDocIterateProc;
  AData: TLMDDataTag);
var
  ctx: TLMDUnitDocIterateContext;
begin
  ctx := TLMDUnitDocIterateContext.Create;
  try
    ctx.FNode := FParseTree;
    ctx.FProc := AProc;
    ctx.IterateChildren(AData);
  finally
    ctx.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.SetIsLocked(const Value: Boolean);
begin
  if FIsLocked <> Value then
  begin
    FIsLocked := Value;
    MarkModified;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.SetIsSysLibDoc(const Value: Boolean);
begin
  if FIsSysLibDoc <> Value then
  begin
    FIsSysLibDoc := Value;
    MarkModified;
  end;
end;
                                                         
{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.GetUnitPath: string;
begin
  Result := FFileHandler.UnitPath;
end;

function TLMDUnitDocument.GetUSUPath: string;
begin
  Result := FFileHandler.GetUSUSavePath(FIsSysLibDoc);
end;

{ --------------------------------- protected -------------------------------- }

procedure TLMDUnitDocument.AnalizeProgress;
var
  i: Integer;
begin
  Inc(FAnalizedDeclsCount);

  for i := 0 to FNotifiers.Count - 1 do
    ILMDUnitDocNotifier(FNotifiers[i]).AnalizeProgress(Self, ParseTree.
                                                       Declarations.Count,
                                                       FAnalizedDeclsCount);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.ApplyAllHints;
begin
  Assert(FParsed, 'Document is not parsed.');

  FDataItems.GetAll(ApplyHintsProc);
  MarkModified;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.ApplyHint(ANode: TLMDPasNamedNode);
var
  itm: TLMDUnitDocNodeData;
begin
  Assert(FParsed, 'Document is not parsed.');

  itm := GetNodeData(ANode);
  if itm <> nil then
  begin
    DoApplyHint(itm);
    MarkModified;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.ApplyHintsProc(AItem: TObject);
var
  item: TLMDUnitDocNodeData;
begin
  item := TLMDUnitDocNodeData(AItem);
  DoApplyHint(item);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.FreeParseTree;
begin
  DissociateData;

  if FParseTree <> nil then
  begin
    FParseTree.Free;
    FParseTree := nil;
  end;
end;
                                                                    
{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.DoParse: Boolean;
var
  pr: TLMDPasParser;
  m:  TLMDUnitDocMessage;
begin
  Result := True;
  pr     := TLMDPasParser.Create(FFileHandler, FindDirectiveConstProc);
  try
    FEnv.GetLibPaths(FFileHandler.LibPaths); // Update library paths.
    FEnv.MakeStandardDefines(pr);
    try
      FParseTree := pr.Parse(GetSource);
      AssociateData;
    except
      on e: Exception do
      begin
        m.Kind     := mkParseError;
        m.Text     := e.Message;
        m.FileName := ExtractFileName(UnitPath);
        m.Node     := nil;

        AddMessage(m);
        Result := False;
      end;
    end;
  finally
    pr.Free;
  end;
end;
                                                                      
{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.DoAnalize: Boolean;
var
  analizer: TLMDPasAnalizer;
begin
  analizer := TLMDPasAnalizer.Create(Self);
  try
    FEnv.GetLibPaths(FFileHandler.LibPaths); // Update library paths.
    FEnv.GetNamespacePrefixes(FFileHandler.NamespacePrefixes);

    FAnalizedDeclsCount := 0;
    Result              := analizer.Analize;
  finally
    analizer.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.DoApplyHint(AItem: TLMDUnitDocNodeData);
begin
  if (AItem <> nil) and (AItem.Node <> nil) and AItem.Hint.IsSpecified then
    case AItem.Node.GetNodeKind of
      tnkConstDecl:   AItem.ConstTypeRepl := AItem.Hint.ConstTypeRepl;
      tnkProcHeading: AItem.Checked := AItem.Hint.OverloadChecked;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.DoGenerate;
var
  generator: TLMDPasWrapperGenerator;
begin
  generator := TLMDPasWrapperGenerator.Create(Self);
  try
    FEnv.GetLibPaths(FFileHandler.LibPaths); // Update library paths.

    generator.Generate;
    generator.SaveToFile(GetWrapperUnitPath);
  finally
    generator.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.LoadHints(const AXml: ILMDXmlDocument);
var
  cstId:   Integer;
  ovdId:   Integer;
  nameId:  Integer;
  typeId:  Integer;
  chkdId:  Integer;
  nds:     ILMDXmlNodeList;
  i:       Integer;
  elem:    ILMDXmlElement;
  fullnm:  TLMDString;
  hint:    TLMDUnitDocNodeHint;
  itm:     TLMDUnitDocNodeData;
begin
  Assert(FParsed, 'Document is not parsed.');
  FDataItems.GetAll(ClearHintsProc);

  cstId  := AXml.NameTable.GetID('constant'); // Performance optimization.
  ovdId  := AXml.NameTable.GetID('overload'); //
  nameId := AXml.NameTable.GetID('name');     //
  typeId := AXml.NameTable.GetID('type');     //
  chkdId := AXml.NameTable.GetID('checked');  //
  nds    := AXml.DocumentElement.ChildNodes;

  for i := 0 to nds.Count - 1 do
    if nds[i].NodeType = LMD_NODE_ELEMENT then
    begin
      elem             := nds[i].AsElement;
      fullnm           := '';
      hint.IsSpecified := False;

      if elem.NodeNameID = cstId then
      begin
        fullnm             := elem.GetAttr(nameId);
        hint.IsSpecified   := True;
        hint.ConstTypeRepl := elem.GetAttr(typeId);
      end
      else if elem.NodeNameID = ovdId then
      begin
        fullnm               := elem.GetAttr(nameId);
        hint.IsSpecified     := True;
        hint.OverloadChecked := elem.GetBoolAttr(chkdId);
      end;

      itm := FindDataItem(fullnm);
      if itm <> nil then
        itm.Hint := hint;
    end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.LoadSourceFromFile(const AFilePath: string): string;
var
  srs: TStrings;
begin
  srs := TStringList.Create;
  try
    srs.LoadFromFile(AFilePath);
    Result := srs.Text;
  finally
    srs.Free;
  end;
end;
                                                          
{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.GetSource: string;
var
  spath: string;
begin
  if FFileHandler.FindStub(spath) then // If stub exists, use stub
                                       // instead of original unit.
    Result := LoadSourceFromFile(spath)
  else
  begin
    if FSourceProvider <> nil then
      Result := FSourceProvider.GetSource
    else
      Result := LoadSourceFromFile(GetUnitPath);
  end;
end;
                                                               
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.LoadState;
var
  i:      Integer;
  filenm: string;
  stream: TStream;
  cnt:    Longint;
  item:   TLMDUnitDocNodeData;
  magic:  Longint;
  vers:   Longint;
  dummy:  Integer;
begin
  if not FFileHandler.FindUIMFile(filenm) then // No saved state found.
    Exit;
    
  stream := TFileStream.Create(filenm, fmOpenRead);
  try
    { Load header }

    stream.Read(magic, sizeof(Longint));
    if magic <> STATE_FILE_MAGIC_NUM then
      raise ELMDInvalidFileFormat.Create(SLMDDocInvalidFileFormat);

    stream.Read(vers, sizeof(Longint));
    if vers > STATE_FILE_CUR_VERSION then
      raise ELMDInvalidFileFormat.Create(SLMDDocUnsuppFileVers);

    { Load data items }

    stream.Read(cnt, SizeOf(Longint));

    for i := 0 to cnt - 1 do
    begin
      item := TLMDUnitDocNodeData.Create;
      try
        item.FullName := LoadStringFromStream(stream);
        stream.Read(item.Checked, SizeOf(Boolean));
        if vers >= 2 then
          item.ConstTypeRepl := LoadStringFromStream(stream);

        FDataItems.Add(item);
      except
        item.Free;
        raise;
      end;
    end;

    { Load options }

    stream.Read(FIsSysLibDoc, SizeOf(Boolean));
    if vers >= 3 then
      stream.Read(FIsLocked, SizeOf(Boolean));
    if vers = 4 then
      stream.Read(dummy, SizeOf(dummy));
  finally
    stream.Free;
  end;
end;
                                                           
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.SaveState;
var
  filenm: string;
  stream: TStream;
  cnt:    Longint;
begin
  filenm := FFileHandler.GetUIMSavePath(FIsSysLibDoc);
  stream := TFileStream.Create(filenm, fmCreate);
  try
    { Save header }

    stream.Write(STATE_FILE_MAGIC_NUM, sizeof(Longint));
    stream.Write(STATE_FILE_CUR_VERSION, sizeof(Longint));

    { Save data items }

    cnt := FDataItems.Count;
    stream.Write(cnt, SizeOf(Longint));

    FDataItems.GetAll(SaveItemProc, stream);

    { Save options }

    stream.Write(FIsSysLibDoc, SizeOf(Boolean));
    stream.Write(FIsLocked, SizeOf(Boolean));
  finally
    stream.Free;
  end;
end;
                                                                
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.SaveAsUsedUnit;
var
  filenm: string;
  writer: TLMDUsedUnitWriter;
begin
  filenm := FFileHandler.GetUSUSavePath(FIsSysLibDoc);
  writer := TLMDUsedUnitWriter.Create(Self);
  try
    writer.SaveToFile(filenm);
  finally
    writer.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.SaveItemProc(AItem: TObject;
  AUserData: TLMDDataTag);
var
  item:   TLMDUnitDocNodeData;
  stream: TStream;
begin
  item   := TLMDUnitDocNodeData(AItem);
  stream := TStream(AUserData);

  SaveStringToStream(stream, item.FullName);
  stream.Write(item.Checked, SizeOf(Boolean));
  SaveStringToStream(stream, item.ConstTypeRepl);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.ClearHintsProc(AItem: TObject);
var
  item: TLMDUnitDocNodeData;
begin
  item := TLMDUnitDocNodeData(AItem);
  item.Hint.IsSpecified     := False;
  item.Hint.ConstTypeRepl   := '';
  item.Hint.OverloadChecked := False;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.ClearMessages;
begin
  FMessageCount := 0;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.FindDataItem(
  const AFullName: string): TLMDUnitDocNodeData;
var
  key: string;
begin
  key    := UpperCase(AFullName);
  Result := TLMDUnitDocNodeData(FDataItems.Find(key));
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.GetNodeData(
  ANode: TLMDPasNamedNode): TLMDUnitDocNodeData;
begin
  if ANode = nil then
    Result := nil
  else
    Result := TLMDUnitDocNodeData(ANode.D_Data);
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.GetNodeFullName(ANode: TLMDPasNamedNode): string;
var
  dt: TLMDUnitDocNodeData;
begin
  dt := GetNodeData(ANode);

  if dt <> nil then
    Result := dt.FullName
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.GetNodeHint(ANode: TLMDPasNamedNode): string;
var
  dt: TLMDUnitDocNodeData;
begin
  Result := '';
  dt     := GetNodeData(ANode);

  if (dt <> nil) and dt.Hint.IsSpecified then
    case ANode.GetNodeKind of
      tnkConstDecl:   Result := dt.Hint.ConstTypeRepl;
      tnkProcHeading: if dt.Hint.OverloadChecked then
                        Result := 'Checked';

    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.DissociateData;
begin
  FDataItems.GetAll(DissociateItemProc);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.DissociateItemProc(AItem: TObject);
var
  item: TLMDUnitDocNodeData;
begin
  item := TLMDUnitDocNodeData(AItem);

  if item.Node <> nil then
  begin
    item.Node.D_Data := nil;
    item.Node        := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.AssociateData;
var
  s: string;
begin
  s := '';
  Iterate(AssociateProc, @s);
  FDataItems.Update; // Remove unassociated (with Node = nil).
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.AssociateProc(C: TLMDUnitDocIterateContext;
  ANode: TLMDPasNamedNode; AData: TLMDDataTag);
var
  fn:   string;
  item: TLMDUnitDocNodeData;
  proc: TLMDPasProcHeading;
begin
  fn := string(AData^);

  if (ANode is TLMDPasProcHeading) and
     TLMDPasProcHeading(ANode).IsOverload then
  begin
    proc := TLMDPasProcHeading(ANode);
    if proc.Body <> ppbNormal then
      fn := fn + '#';
    fn := fn + '(' + proc.Parameters.Signature + ')';
  end
  else
  begin
    if fn <> '' then
      fn := fn + '.';
    fn := fn + ANode.Name;
  end;

  item := FindDataItem(fn);

  if item = nil then
  begin
    item          := TLMDUnitDocNodeData.Create;
    item.FullName := fn;
    FDataItems.Add(item);
  end;

  item.Node    := ANode;
  ANode.D_Data := item;

  C.IterateChildren(@fn);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDUnitDocument.Create(const AUnitFilePath: string;
  AEnv: ILMDUnitDocEnvironment; ASourceProvider: ILMDUnitDocSourceProvider;
  AMakeAnalize: Boolean);
begin
  inherited Create;
  FEnv               := AEnv;
  FDataItems         := TLMDHashTable.Create(TDataItemsTraits, True);
  FNotifiers         := TList.Create;
  FFileHandler       := TLMDFileHandler.Create(AUnitFilePath);
  FSourceProvider    := ASourceProvider;
  FGenAdditionalInfo := True;

  FEnv.GetLibPaths(FFileHandler.LibPaths);
  FFileHandler.VCLImportSubpath := FEnv.GetVCLImportSubpath;
  Reload(AMakeAnalize);
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDUnitDocument.Destroy;
begin
  FreeParseTree;
  FDataItems.Free;
  FNotifiers.Free;
  FFileHandler.Free;
  inherited;
end;
                                                       
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.Reload(AMakeAnalize: Boolean);
begin
  FreeParseTree;
  ClearMessages;
  FParsed := False;

  LoadState;
  if AMakeAnalize then
  begin
    if Parse then
      Analize(False);
  end;
end;
                                                          
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.Save;
begin
  SaveState;
end;
                                                          
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.Renamed(const ANewUnitPath: string);
begin
  FFileHandler.UnitPath := ANewUnitPath;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.Parse: Boolean;
begin
  FreeParseTree;
  ClearMessages;
  FParsed := DoParse;
  Result  := FParsed;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.PreprocessUsedUnit(const AUnitName: string;
  out AUSUPath: string): Boolean;
var
  i: Integer;
begin
  for i := 0 to FNotifiers.Count - 1 do
  begin
    if ILMDUnitDocNotifier(FNotifiers[i]).PreprocessUsedUnit(Self, AUnitName,
                                                             AUSUPath) then
    begin
      Result := True;
      Exit;
    end;
  end;

  Result := False;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.Analize(GenWrapperFile: Boolean): Boolean;
begin
  Assert(FParsed, 'Document is not parsed.');
  
  ClearMessages;
  FLastAnalizeSucceds := DoAnalize;

  if FLastAnalizeSucceds then
  begin
    SaveAsUsedUnit;
    if GenWrapperFile then
      DoGenerate;
  end;

  Result := FLastAnalizeSucceds;
end;
                                                            
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.UncheckErrorsProc(AItem: TObject);
var
  item: TLMDUnitDocNodeData;
begin
  item := TLMDUnitDocNodeData(AItem);
  if (item.Node <> nil) and (item.Node.C_SupportKind <> skYes) then
    item.Checked := False;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.UncheckNodesWithErrors;
begin
  FDataItems.GetAll(UncheckErrorsProc);
  MarkModified;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.UsedElemReferenced(const AUnitName,
  AElemFullName: string);
var
  i: Integer;
begin
  for i := 0 to FNotifiers.Count - 1 do
    ILMDUnitDocNotifier(FNotifiers[i]).UsedElemReferenced(Self, AUnitName,
                                                          AElemFullName);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.MarkUnparsed;
begin
  FreeParseTree;
  ClearMessages;
  FParsed := False;
end;
                                                         
{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.GetNodeChecked(ANode: TLMDPasNamedNode): Boolean;
begin
  if not FParsed then
  begin
    Result := False;
    Exit;
  end;

  Result := GetNodeData(ANode).Checked;
end;
                                                        
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.SetNodeChecked(ANode: TLMDPasNamedNode;
  AValue: Boolean);
begin
  if not FParsed then
    Exit;

  if GetNodeData(ANode).Checked <> AValue then
  begin
    GetNodeData(ANode).Checked := AValue;
    MarkModified;
  end;
end;
                                                          
{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.GetConstTypeRepl(ANode: TLMDPasConstDecl): string;
begin
  if not FParsed then
  begin
    Result := '';
    Exit;
  end;

  Result := GetNodeData(ANode).ConstTypeRepl;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.GetMessageCount: Integer;
begin
  Result := FMessageCount;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.GetMessages(Index: Integer): TLMDUnitDocMessage;
begin
  Result := FMessages[Index];
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.SetConstTypeRepl(ANode: TLMDPasConstDecl;
  const AValue: string);
begin
  if not FParsed then
    Exit;

  if GetNodeData(ANode).ConstTypeRepl <> AValue then
  begin
    GetNodeData(ANode).ConstTypeRepl := AValue;
    MarkModified;
  end;
end;
                                                       
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.MarkModified;
var
  i: Integer;
begin
  for i := 0 to FNotifiers.Count - 1 do
    ILMDUnitDocNotifier(FNotifiers[i]).Modified(Self);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.SaveHints(const AXml: ILMDXmlDocument);
begin
  Assert(FParsed, 'Document is not parsed.');
  FDataItems.GetAll(SaveHintsProc, TLMDDataTag(AXml.DocumentElement));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.SaveHintsProc(AItem: TObject;
  AUserData: TLMDDataTag);
var
  item: TLMDUnitDocNodeData;
  elem: ILMDXmlElement;
  s:    string;
  cst:  TLMDPasConstDecl;
  proc: TLMDPasProcHeading;
begin
  item := TLMDUnitDocNodeData(AItem);
  if item.Node = nil then
    Exit;

  case item.Node.GetNodeKind of
    tnkConstDecl:
    begin
      cst := TLMDPasConstDecl(item.Node);
      s   := ConstTypeRepl[cst];

      if s <> '' then
      begin
        elem := ILMDXmlElement(AUserData).AppendElement('constant');
        elem.SetAttr('name', item.FullName);
        elem.SetAttr('type', s);
      end;
    end;
    tnkProcHeading:
    begin
      proc := TLMDPasProcHeading(item.Node);

      if proc.IsOverload then
      begin
        elem := ILMDXmlElement(AUserData).AppendElement('overload');
        elem.SetAttr    ('name', item.FullName);
        elem.SetBoolAttr('checked', NodeChecked[proc]);
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.AddMessage(const M: TLMDUnitDocMessage);
begin
  if Length(FMessages) = FMessageCount then // Grow.
    SetLength(FMessages, Max(FMessageCount * 2, 4));

  FMessages[FMessageCount] := M;
  Inc(FMessageCount);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.AddNotifier(ANotifier: ILMDUnitDocNotifier);
begin
  if FNotifiers.IndexOf(ANotifier) = -1 then
    FNotifiers.Add(ANotifier);
end;                                               

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.RemoveNotifier(ANotifier: ILMDUnitDocNotifier);
begin
  if ANotifier <> nil then
    FNotifiers.Remove(ANotifier);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocument.GetStandardWrapperUsedUnits(AResult: TStrings);
begin
  FEnv.GetStandardWrapperUsedUnits(AResult);
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.FindDirectiveConstProc(const AConstName: string;
  out AValue: Variant): Boolean;
begin
  Result := FEnv.FindDirectiveConst(AConstName, AValue);
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitDocument.FindNode(const AFullName: string): TLMDPasNamedNode;
var
  itm: TLMDUnitDocNodeData;
begin
  itm := FindDataItem(AFullName);
  if itm <> nil then
    Result := itm.Node
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }

class function TDataItemsTraits.Compare(const AKey; AItem: TObject): Boolean;
begin
  Result := SameText(TLMDUnitDocNodeData(AItem).FullName, string(AKey));
end;

{ ---------------------------------------------------------------------------- }

class function TDataItemsTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := MakeHashK(TLMDUnitDocNodeData(AItem).FullName);
end;

{ ---------------------------------------------------------------------------- }

class function TDataItemsTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.StrHash(UpperCase(string(AKey)));
end;

{ ---------------------------------------------------------------------------- }

class function TDataItemsTraits.OnUpdate(AItem: TObject): TLMDHashUpdateAction;
begin
  if TLMDUnitDocNodeData(AItem).Node = nil then
    Result := uaDelete
  else
    Result := uaNothing;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitDocIterateContext.IterateChildren(AData: TLMDDataTag);
var
  unit_: TLMDPasUnit;
  tp:    TLMDPasType;
  group: TLMDPasOverloadGroup;
begin
  case FNode.GetNodeKind of
    tnkUnit:
    begin
      unit_ := TLMDPasUnit(FNode);
      IterateNodes(unit_.Uses_, AData);
      IterateNodes(unit_.Declarations, AData);
    end;
    tnkTypeDecl:
    begin
      tp := TLMDPasTypeDecl(FNode).Type_;
      case tp.GetNodeKind of
        tnkClassType:     IterateNodes(TLMDPasClassType(tp).Members, AData);
        tnkRecordType:    IterateNodes(TLMDPasRecordType(tp).Members, AData);
        tnkInterfaceType: IterateNodes(TLMDPasInterfaceType(tp).Members, AData);
      end;
    end;
    tnkOverloadGroup:
    begin
      group := TLMDPasOverloadGroup(FNode);
      IterateNodes(group.Procs, AData);
    end;
  end;
end;

procedure TLMDUnitDocIterateContext.IterateNodes(
  ANodes: TLMDPasNamedNodes; AData: TLMDDataTag);
var
  i: Integer;
begin
  for i := 0 to ANodes.Count - 1 do
  begin
    FNode := ANodes[i];
    FProc(Self, FNode, AData);
  end;
end;

end.
