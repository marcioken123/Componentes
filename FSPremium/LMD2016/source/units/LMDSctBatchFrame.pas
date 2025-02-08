unit LMDSctBatchFrame;
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

LMDSctBatchForm unit (YB)
-------------------------
LMD Script Pack Importer batch import form.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls, LMDXML, LMDSctDialects,
  LMDSctImporterFileUtils, LMDSctImporterTree, LMDSctImporterUnitDoc;

type
  {**************************** class TLMDBatchForm ***************************}

  TLMDBatchFrame = class;

  TLMDUnitDocNotifier = class(ILMDUnitDocNotifier)
  private
    FFrame: TLMDBatchFrame;
  public
    constructor Create(AFrame: TLMDBatchFrame);

    procedure Modified(Sender: TLMDUnitDocument); override;
    procedure AnalizeProgress(Sender: TLMDUnitDocument; ADeclsCount,
                              AAnalizedCount: Integer); override;
    function  PreprocessUsedUnit(Sender: TLMDUnitDocument; const AUnitName: string;
                                 out AUSUPath: string): Boolean; override;
    procedure UsedElemReferenced(Sender: TLMDUnitDocument; const AUnitName,
                                 AElemFullName: string); override;
  end;

  TUnitItem = class
  public
    destructor Destroy; override;
  public
    UnitName:     string;
    Supplemental: Boolean;
    Handled:      Boolean;
    Doc:          TLMDUnitDocument;
  end;

  ILMDBatchFrameTraits = interface
    function  UseExternalMessageView: Boolean;
    procedure UnitNotFound(const AUnitName: string);
    procedure HintsSaved(const AFilePath: string);
    procedure BeginImporting;
    procedure BeginUnitImport(ADocument: TLMDUnitDocument);
    procedure EndUnitImport(ADocument: TLMDUnitDocument; ASucceded: Boolean);
    procedure EndImporting(const ADocuments: array of TLMDUnitDocument;
                           ASucceded: Boolean);
  end;

  TLMDBatchFrame = class(TFrame)
    ErrorsSplitter: TSplitter;
    ErrorsPanel: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    UnitsMemo: TMemo;
    Button1: TButton;
    Button2: TButton;
    PsreOnly: TCheckBox;
    UncheckErrors: TCheckBox;
    StatusBar: TStatusBar;
    OpenDialog1: TOpenDialog;
    ErrorsPageControls: TPageControl;
    TabSheet1: TTabSheet;
    ErrorList: TMemo;
    TabSheet2: TTabSheet;
    InfoMemo: TMemo;
    SaveHint: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure InfoMemoKeyDown(Sender: TObject; var Key: Word;
                              Shift: TShiftState);
  private
    FTraits:       ILMDBatchFrameTraits;
    FUnitList:     TList;
    FLibPaths:     TStrings;
    FDialect:      TLMDIDEDialect;
    FNotifier:     ILMDUnitDocNotifier;
    FSucceded:     Boolean;

    procedure SetTraits(const Value: ILMDBatchFrameTraits);
    procedure AddMessage(const AUnitName, AMsg: string);
    procedure ClearUnitList;
    function  FindUnitItem(const AUnitName: string): TUnitItem; overload;
    function  FindUnitItem(const ADocument: TLMDUnitDocument): TUnitItem; overload;

    function  FindUnitPath(const AUnitName: string): string;
    function  ProcessUsedUnit(Sender: TLMDUnitDocument; const AUnitName: string;
                              out AUSUPath: string): Boolean;
    procedure UsedElemReferenced(Sender: TLMDUnitDocument; const AUnitName,
                                 AElemFullName: string);
    function  ImportUnit(AItem: TUnitItem; out AUSUPath: string): Boolean;
    procedure ReportDocMessages(AItem: TUnitItem);
    procedure ProcessSupplemental(AItem: TUnitItem);
    procedure Run;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    property    Traits: ILMDBatchFrameTraits read FTraits write SetTraits;
  end;

implementation

{$R *.dfm}

{**************************** class TLMDBatchFrame ****************************}
{ -------------------------------- published --------------------------------- }

procedure TLMDBatchFrame.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    UnitsMemo.Lines.LoadFromFile(OpenDialog1.FileName);
end;
           
{ ---------------------------------------------------------------------------- }

procedure TLMDBatchFrame.Button2Click(Sender: TObject);
begin
  Run;
end;

{ --------------------------------- private ---------------------------------- }

procedure TLMDBatchFrame.ReportDocMessages(AItem: TUnitItem);
const
  MSG_KIND: array[TLMDUnitDocMessageKind] of string = ('',
                                                       '[Parse Error] ',
                                                       '[Info] ',
                                                       '[Warning] ',
                                                       '[Error] ');
var
  i: Integer;
  m: TLMDUnitDocMessage;
  s: string;
begin
  if (FTraits <> nil) and FTraits.UseExternalMessageView then
    Exit;

  ErrorList.Lines.BeginUpdate;
  InfoMemo.Lines.BeginUpdate;
  try
    for i := 0 to AItem.Doc.MessageCount - 1 do
    begin
      m := AItem.Doc.Messages[i];
      s := Format('%s%s', [MSG_KIND[m.Kind], m.Text]);

      if m.Kind = mkInfo then
        InfoMemo.Lines.Add(AItem.UnitName + ': ' + s)
      else
        AddMessage(AItem.UnitName, s);
    end;
  finally
    InfoMemo.Lines.EndUpdate;
    ErrorList.Lines.EndUpdate;
  end;
end;

procedure TLMDBatchFrame.Run;
var
  i:     Integer;
  uname: string;
  s:     string;
  itm:   TUnitItem;
  suppl: Boolean;
  docs:  array of TLMDUnitDocument;
  dcnt:  Integer;
  hints: ILMDXmlDocument;
  hntfn: string;
begin
  ClearUnitList;
  ErrorList.Clear;
  InfoMemo.Clear;
  FDialect.GetLibPaths(FLibPaths);

  if FTraits <> nil then
    FTraits.BeginImporting;
  try
    FSucceded := True;

    { Create unit list }

    for i := 0 to UnitsMemo.Lines.Count - 1 do
    begin
      suppl := False;
      uname := Trim(UnitsMemo.Lines[i]);

      if (uname <> '') and (uname[Length(uname)] = '-') then
      begin
        suppl := True;
        uname := Copy(uname, 1, Length(uname) - 1);
      end;

      if uname = '' then
        Continue; // for

      itm              := TUnitItem.Create;
      itm.UnitName     := uname;
      itm.Supplemental := suppl;
      itm.Handled      := False;

      FUnitList.Add(itm);
    end;

    { First pass }

    for i:= 0 to FUnitList.Count - 1 do
    begin
      itm := TUnitItem(FUnitList[i]);
      if not itm.Handled then
      begin
        ImportUnit(itm, s);
      end;
    end;

    { Supplemental pass }

    if UncheckErrors.Checked then
    begin
      for i := 0 to FUnitList.Count - 1 do
      begin
        itm         := TUnitItem(FUnitList[i]);
        itm.Handled := False;

        if itm.Supplemental and (itm.Doc <> nil) then
        begin
          ProcessSupplemental(itm);
          itm.Doc.Save;
        end;
      end;

      UncheckErrors.Checked := False;
      for i := 0 to FUnitList.Count - 1 do
      begin
        itm := TUnitItem(FUnitList[i]);
        if not itm.Handled then
          ImportUnit(itm, s);
      end;
    end;

    if SaveHint.Checked then
    begin
      hints := LMDCreateXmlDocument('declarations', '1.0', 'utf-8');

      for i := 0 to FUnitList.Count - 1 do
      begin
        itm := TUnitItem(FUnitList[i]);
        if (itm.Doc <> nil) and itm.Doc.Parsed then
          itm.Doc.SaveHints(hints);
      end;

      hntfn := TLMDFileHandler.GetVCLHintFileName;
      hints.Save(hntfn);
      if FTraits <> nil then
        FTraits.HintsSaved(hntfn);

      SaveHint.Checked := False;
    end;
  finally
    if FTraits <> nil then
    begin
      SetLength(docs, FUnitList.Count);
      dcnt := 0;

      for i := 0 to FUnitList.Count - 1 do
        if TUnitItem(FUnitList[i]).Doc <> nil then
        begin
          docs[dcnt] := TUnitItem(FUnitList[i]).Doc;
          Inc(dcnt);
        end;

      SetLength(docs, dcnt);
      FTraits.EndImporting(docs, FSucceded);
    end;
  end;

  StatusBar.SimpleText := '';
end;

procedure TLMDBatchFrame.SetTraits(const Value: ILMDBatchFrameTraits);
begin
  if FTraits <> Value then
  begin
    FTraits := Value;

    if not (csDestroying in ComponentState) then
    begin
      ErrorList.Clear;
      ErrorsPanel.Visible    := (FTraits = nil) or
                                not FTraits.UseExternalMessageView;
      ErrorsSplitter.Visible := ErrorsPanel.Visible;
      StatusBar.Visible      := ErrorsPanel.Visible;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchFrame.UsedElemReferenced(Sender: TLMDUnitDocument;
  const AUnitName, AElemFullName: string);
var
  sndr, used: TUnitItem;
  nd:         TLMDPasNamedNode;
begin
  if UncheckErrors.Checked then
  begin
    sndr := FindUnitItem(Sender);
    used := FindUnitItem(AUnitName);

    if (sndr <> nil) and not sndr.Supplemental and
       (used <> nil) and used.Supplemental and
       (used.Doc <> nil) then
    begin
      nd := used.Doc.FindNode(AElemFullName);
      if nd <> nil then
        nd.V_Data := TObject(1); // Mark as required.
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchFrame.ImportUnit(AItem: TUnitItem;
  out AUSUPath: string): Boolean;
const
  RES_MSG: array[Boolean, Boolean] of string =
  (
    ('[Fatal error] Unit importing failed.',
     '[Ok] Unit imported succesfully.'),
    ('[Fatal error] Unit parsing failed.',
     '[Ok] Unit parsed succesfully.')
  );
  MSG_KIND: array[TLMDUnitDocMessageKind] of string = ('',
                                                       '[Parse Error] ',
                                                       '[Info] ',
                                                       '[Warning] ',
                                                       '[Error] ');
var
  path: string;
begin
  Assert(not AItem.Handled); // Prevent recursive uses.
  AItem.Handled := True;     //
  Result        := False;

  StatusBar.SimpleText := 'Importing unit: ' + AItem.UnitName;
  StatusBar.Update;

  if AItem.Doc = nil then
  begin
    path := FindUnitPath(AItem.UnitName);

    if not FileExists(path) then
    begin
      if FTraits <> nil then
        FTraits.UnitNotFound(AItem.UnitName);
      AddMessage(AItem.UnitName, '[Fatal error] File not found.');

      FSucceded := False;
      Exit;
    end;

    AItem.Doc                   := TLMDUnitDocument.Create(path, FDialect,
                                                           nil, False);
    AItem.Doc.IsSysLibDoc       := True;
    AItem.Doc.GenAdditionalInfo := not AItem.Supplemental;
    AItem.Doc.AddNotifier(FNotifier);
  end;

  if FTraits <> nil then
    FTraits.BeginUnitImport(AItem.Doc);
  try
    Result := AItem.Doc.Parse;

    if Result and not PsreOnly.Checked then
    begin
      if UncheckErrors.Checked then
      begin
        while not AItem.Doc.Analize(True) do
          AItem.Doc.UncheckNodesWithErrors;
        AItem.Doc.Save;
        Result := True;
      end
      else
        Result := AItem.Doc.Analize(True);

      AUSUPath := AItem.Doc.USUPath;
    end;
  finally
    if FTraits <> nil then
      FTraits.EndUnitImport(AItem.Doc, Result);
  end;

  FSucceded := FSucceded and Result;
  AddMessage(AItem.UnitName, RES_MSG[PsreOnly.Checked, Result]);

  ReportDocMessages(AItem);
  Update;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchFrame.InfoMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Ord('A')) and (ssCtrl in Shift) then
    InfoMemo.SelectAll;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchFrame.ProcessSupplemental(AItem: TUnitItem);
var
  i:     Integer;
  decls: TLMDPasNamedNodes;

  procedure _ProcessDecl(D: TLMDPasNamedNode); forward;
  procedure _ProcessType(T: TLMDPasType); forward;

  procedure _ProcessMembers(MRS: TLMDPasNamedNodes);
  var
    i, j: Integer;
    m:    TLMDPasNamedNode;
    proc: TLMDPasProcHeading;
    prop: TLMDPasProperty;
  begin
    for i := 0 to MRS.Count - 1 do
    begin
      m := MRS[i];
      if not AItem.Doc.NodeChecked[m] then
        Continue; // for

      case m.GetNodeKind of
        tnkConstDecl:       begin
                              if TLMDPasConstDecl(m).Type_ <> nil then
                                _ProcessType(TLMDPasConstDecl(m).Type_);
                            end;
        tnkTypeDecl:        _ProcessType(TLMDPasTypeDecl(m).Type_);
        tnkVarDecl:         _ProcessType(TLMDPasVarDecl(m).Type_);
        tnkProcHeading:     begin
                              proc := TLMDPasProcHeading(m);
                              for j := 0 to proc.Parameters.Count - 1 do
                              begin
                                if proc.Parameters[j].Type_ <> nil then
                                  _ProcessType(proc.Parameters[j].Type_);
                              end;
                              if proc.ReturnType <> nil then
                                _ProcessType(proc.ReturnType);
                            end;
        tnkProperty:        begin
                              prop := TLMDPasProperty(m);
                              for j := 0 to prop.Parameters.Count - 1 do
                              begin
                                if prop.Parameters[j].Type_ <> nil then
                                  _ProcessType(prop.Parameters[j].Type_);
                              end;
                              _ProcessType(prop.Type_);
                            end;
      end;
    end;
  end;

  procedure _ProcessType(T: TLMDPasType);
  var
    i:  Integer;
    d:  TLMDPasNamedNode;
    pt: TLMDPasProcType;
  begin
    case T.GetNodeKind of
      tnkTypeId:          begin
                            d := decls.Find(TLMDPasTypeId(T).QualName);
                            if (d <> nil) and (d.V_Data = nil) then
                            begin
                              d.V_Data := TObject(1);
                              _ProcessDecl(d);
                            end;
                          end;
      tnkRecordType:      _ProcessMembers(TLMDPasRecordType(T).Members);
      tnkClassType:       _ProcessMembers(TLMDPasClassType(T).Members);
      tnkInterfaceType:   _ProcessMembers(TLMDPasInterfaceType(T).Members);
      tnkProcType:        begin
                            pt := TLMDPasProcType(T);
                            for i := 0 to pt.Parameters.Count - 1 do
                            begin
                              if pt.Parameters[i].Type_ <> nil then
                                _ProcessType(pt.Parameters[i].Type_);
                            end;
                            if pt.ReturnType <> nil then
                              _ProcessType(pt.ReturnType);
                          end;
      tnkClassRefType:    _ProcessType(TLMDPasClassRefType(T).BaseType);
      tnkSetType:         _ProcessType(TLMDPasSetType(T).BaseType);
    end;
  end;

  procedure _ProcessDecl(D: TLMDPasNamedNode);
  begin
    if D is TLMDPasTypeDecl then
      _ProcessType(TLMDPasTypeDecl(D).Type_);
  end;

  procedure _UncheckMembers(D: TLMDPasNamedNode);
  var
    i:   Integer;
    tp:  TLMDPasType;
    mrs: TLMDPasNamedNodes;
  begin
    if not (D is TLMDPasTypeDecl) then
      Exit;
    tp := TLMDPasTypeDecl(D).Type_;

    case tp.GetNodeKind of
      tnkRecordType:      mrs := TLMDPasRecordType(tp).Members;
      tnkClassType:       mrs := TLMDPasClassType(tp).Members;
      tnkInterfaceType:   mrs := TLMDPasInterfaceType(tp).Members;
    else
      Exit;
    end;

    for i := 0 to mrs.Count - 1 do
      AItem.Doc.NodeChecked[mrs[i]] := False;
  end;

begin
  decls := AItem.Doc.ParseTree.Declarations;

  for i := 0 to decls.Count - 1 do
  begin
    if (decls[i].V_Data <> nil) and AItem.Doc.NodeChecked[decls[i]] then
      _ProcessDecl(decls[i]);
  end;

  for i := 0 to decls.Count - 1 do
  begin
    if decls[i].V_Data = nil then
    begin
      AItem.Doc.NodeChecked[decls[i]] := False;
      _UncheckMembers(decls[i]);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchFrame.ProcessUsedUnit(Sender: TLMDUnitDocument;
  const AUnitName: string; out AUSUPath: string): Boolean;
var
  itm: TUnitItem;
begin
  Result := False;
  itm    := FindUnitItem(AUnitName);

  if (itm <> nil) and not itm.Handled then
    Result := ImportUnit(itm, AUSUPath);
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchFrame.FindUnitItem(const AUnitName: string): TUnitItem;
var
  i: Integer;
begin
  for i := 0 to FUnitList.Count - 1 do
    if SameText(TUnitItem(FUnitList[i]).UnitName, AUnitName) then
    begin
      Result := TUnitItem(FUnitList[i]);
      Exit;
    end;

  Result := nil;
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchFrame.FindUnitItem(
  const ADocument: TLMDUnitDocument): TUnitItem;
var
  i: Integer;
begin
  for i := 0 to FUnitList.Count - 1 do
    if TUnitItem(FUnitList[i]).Doc = ADocument then
    begin
      Result := TUnitItem(FUnitList[i]);
      Exit;
    end;

  Result := nil;
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchFrame.FindUnitPath(
  const AUnitName: string): string;

  function _MakeFilename(const APath, AFileName: string): string;
  begin
    if APath = '' then
      Result := AFileName
    else
      Result := IncludeTrailingPathDelimiter(APath) + AFileName;
  end;

var
  i:     Integer;
  fname: string;
begin
  for i := 0 to FLibPaths.Count - 1 do
  begin
    fname := _MakeFilename(FLibPaths[i], AUnitName + '.pas');

    if FileExists(fname) then
    begin
      Result := fname;
      Exit;
    end;
  end;

  Result := '';
end;
             
{ ---------------------------------------------------------------------------- }

procedure TLMDBatchFrame.AddMessage(const AUnitName, AMsg: string);
begin
  if (FTraits = nil) or not FTraits.UseExternalMessageView then
    ErrorList.Lines.Add(AUnitName + ': ' + AMsg);
end;

{ ---------------------------------- public ---------------------------------- }

procedure TLMDBatchFrame.ClearUnitList;
var
  i: Integer;
begin
  for i := 0 to FUnitList.Count - 1 do
    TObject(FUnitList[i]).Free;
  FUnitList.Clear;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDBatchFrame.Create(AOwner: TComponent);
begin
  inherited;
  FUnitList := TList.Create;
  FLibPaths := TStringList.Create;
  FNotifier := TLMDUnitDocNotifier.Create(Self);
  FDialect  := TLMDIDEDialectProvider.GetDialect;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDBatchFrame.Destroy;
begin
  ClearUnitList;
  FUnitList.Free;
  FLibPaths.Free;
  FNotifier.Free;
  inherited;
end;
             
{ ---------------------------------------------------------------------------- }

{ TLMDUnitDocNotifier }

procedure TLMDUnitDocNotifier.AnalizeProgress(Sender: TLMDUnitDocument;
  ADeclsCount, AAnalizedCount: Integer);
begin
  // Do nothing.
end;

constructor TLMDUnitDocNotifier.Create(AFrame: TLMDBatchFrame);
begin
  inherited Create;
  FFrame := AFrame;
end;

procedure TLMDUnitDocNotifier.Modified(Sender: TLMDUnitDocument);
begin
  // Do nothing.
end;

function TLMDUnitDocNotifier.PreprocessUsedUnit(Sender: TLMDUnitDocument;
  const AUnitName: string; out AUSUPath: string): Boolean;
begin
  Result := FFrame.ProcessUsedUnit(Sender, AUnitName, AUSUPath);
end;

procedure TLMDUnitDocNotifier.UsedElemReferenced(Sender: TLMDUnitDocument;
  const AUnitName, AElemFullName: string);
begin
  FFrame.UsedElemReferenced(Sender, AUnitName, AElemFullName);
end;

{ TUnitItem }

destructor TUnitItem.Destroy;
begin
  Doc.Free;
  inherited;
end;

end.
