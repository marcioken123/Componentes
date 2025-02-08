unit LMDSctEmbeddedView;
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

LMDSctEmbeddedView unit (YB)
----------------------------
LMD Script Pack Importer embedded view for newer Delphi versions.

Changes
-------
Release 5.0 (September 2011)
 - Initial Release

###############################################################################}

interface

{$IFDEF LMDCOMP14} // Whole unit is used only for Delphi2010 and up.

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, StdCtrls, ComCtrls, Dialogs, DesignIntf, ToolsApi, VCLEditors,
  LMDSctImporterTree, LMDSctImporterUnitDoc, LMDSctUnitFrame,
  LMDSctBatchFrame;

const
  VIEW_NAME = 'LMD-Script Import';

type
  {**************************** TLMDImportMessage *****************************}

  TLMDImportMessageGroup = class(TNotifierObject, IOTANotifier,
                                 IOTAMessageNotifier)
  protected
    procedure MessageGroupAdded(const Group: IOTAMessageGroup);
    procedure MessageGroupDeleted(const Group: IOTAMessageGroup);
  public
    class function  Get: IOTAMessageGroup;
    class procedure Remove;
  end;

  TLMDImportMessage = class(TInterfacedObject, IOTACustomMessage,
                            IOTACustomMessage50, IOTACustomMessage100)
  private
    FFilePath:     string;
    FNodeFullName: string;
    FLineText:     string;
  protected
    { IOTACustomMessage }

    function  GetColumnNumber: Integer;
    function  GetFileName: string;
    function  GetLineNumber: Integer;
    function  GetLineText: string;
    procedure ShowHelp;
    function  GetChildCount: Integer;
    function  GetChild(Index: Integer): IOTACustomMessage50;
    function  CanGotoSource(var DefaultHandling: Boolean): Boolean;
    procedure TrackSource(var DefaultHandling: Boolean);
    procedure GotoSource(var DefaultHandling: Boolean);
  public
    constructor Create(const AFilePath, ANodeFullName, S: string);

    class procedure ClearMessages;
    class procedure ShowMessageView;
    class procedure AddTitle(const S: string);
    class procedure AddText(const S: string);
    class procedure AddDocsMsgs(const ADocuments: array of TLMDUnitDocument);
  end;

  {************************* TLMDUnitEmbeddedView *****************************}

  TLMDUnitViewTraits = class(TComponent, ILMDUnitFrameTraits)
  private
    FViewObject: TCustomFrame;
    FContent:    TLMDUnitFrame;

    procedure SetContent(const Value: TLMDUnitFrame);
    procedure SetStatus(const S: string; AProgress: Integer = -1);
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    { ILMDUnitFrameTraits }

    procedure UpdateCaption;
    procedure OpenUsedUnit(const AUnitName: string);
    function  UseExternalMessageView: Boolean;
    procedure BeginImporting;
    procedure ImportingProgress(AProgress: Integer);
    procedure EndImporting(ASucceded: Boolean);
  public
    constructor Create(AViewObject: TCustomFrame); reintroduce;
    destructor  Destroy; override;
    property    Content: TLMDUnitFrame read FContent write SetContent;
  end;

  TLMDUnitEmbeddedView = class(TInterfacedObject, INTACustomEditorSubView)
  private
    function EditorFromContext(const AContext: IInterface): IOTASourceEditor;
    function GetFocusedEditor(AViewObject: TObject): TCustomEdit;
    function GetTraits(AViewObject: TFrame): TLMDUnitViewTraits;
  protected
    { INTACustomEditorSubView }

    procedure Display(const AContext: IInterface; AViewObject: TObject);
    function  EditAction(const AContext: IInterface; Action: TEditAction;
                         AViewObject: TObject): Boolean;
    function  GetFrameClass: TCustomFrameClass;
    procedure FrameCreated(AFrame: TCustomFrame);
    function  GetCanCloneView: Boolean;
    function  GetCaption: string;
    function  GetEditState(const AContext: IInterface;
                           AViewObject: TObject): TEditState;
    function  GetPriority: Integer;
    function  GetViewIdentifier: string;
    function  Handles(const AContext: IInterface): Boolean;
    procedure Hide(const AContext: IInterface; AViewObject: TObject);
    procedure ViewClosed(const AContext: IInterface; AViewObject: TObject);
  public
    class procedure Finalize;
  end;

  {************************* TLMDBatchEmbeddedView ****************************}

  TLMDBatchTraits = class(TComponent, ILMDBatchFrameTraits)
  private
    FFrame:   TLMDBatchFrame;
    procedure SetStatus(const S: string);
  protected
    { ILMDBatchFrameTraits }

    function  UseExternalMessageView: Boolean;
    procedure BeginImporting;
    procedure UnitNotFound(const AUnitName: string);
    procedure HintsSaved(const AFilePath: string);
    procedure BeginUnitImport(ADocument: TLMDUnitDocument);
    procedure EndUnitImport(ADocument: TLMDUnitDocument; ASucceded: Boolean);
    procedure EndImporting(const ADocuments: array of TLMDUnitDocument;
                           ASucceded: Boolean);
  public
    constructor Create(AFrame: TLMDBatchFrame); reintroduce;
  end;

  TLMDBatchEmbeddedView = class(TInterfacedObject, INTACustomEditorView,
                                INTACustomEditorViewStatusPanel)
  private
    function GetFocusedEditor: TCustomEdit;
  protected
    { INTACustomEditorView }

    function  GetCanCloneView: Boolean;
    function  CloneEditorView: INTACustomEditorView;
    function  GetCaption: string;
    function  GetEditorWindowCaption: string;
    function  GetViewIdentifier: string;
    function  GetEditState: TEditState;
    function  EditAction(Action: TEditAction): Boolean;
    procedure CloseAllCalled(var ShouldClose: Boolean);
    procedure SelectView;
    procedure DeselectView;
    function  GetFrameClass: TCustomFrameClass;
    procedure FrameCreated(AFrame: TCustomFrame);

    { INTACustomEditorViewStatusPanel }

    function  GetStatusPanelCount: Integer;
    procedure ConfigurePanel(StatusBar: TStatusbar; Panel: TStatusPanel);
    procedure DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
                        const Rect: TRect);
  public
    class procedure Finalize;
  end;

{$ENDIF}

implementation

{$IFDEF LMDCOMP14}

uses
  LMDSctExpertUnit;

const
  BatchViewId = 'LMDScriptPackBatchImportViewId';
  UnitViewId  = 'LMDScriptPackUnitImportSubviewId';

var
  TraitsList:    TList;
  MsgGroup:      IOTAMessageGroup;  // Lazy inited.
  GroupNotifier: Integer = -1;      //

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitEmbeddedView.Display(const AContext: IInterface;
  AViewObject: TObject);
var
  edtr:   IOTASourceEditor;
  untfrm: TLMDUnitFrame;
  traits: TLMDUnitViewTraits;
begin
  if AViewObject is TFrame then
  begin
    edtr := EditorFromContext(AContext);

    if edtr <> nil then
    begin
      traits := GetTraits(TFrame(AViewObject));
      untfrm := TLMDUnitFrame.GetWizard(edtr);

      traits.Content := untfrm;
      untfrm.Update;
      untfrm.QueryInitialParse;
    end
    else
    begin
      traits         := GetTraits(TFrame(AViewObject));
      traits.Content := nil;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.GetFocusedEditor(
  AViewObject: TObject): TCustomEdit;
var
  acvctl: TWinControl;
begin
  Result := nil;
  acvctl := Screen.ActiveControl;

  if acvctl is TCustomEdit then
    Result := TCustomEdit(acvctl);
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.EditAction(const AContext: IInterface;
  Action: TEditAction; AViewObject: TObject): Boolean;
var
  edtr: TCustomEdit;
begin
  edtr := GetFocusedEditor(AViewObject);

  if edtr <> nil then
    Result := EditActionFor(edtr, Action)
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.EditorFromContext(
  const AContext: IInterface): IOTASourceEditor;
var
  md: IOTAModule;
begin
  if AContext <> nil then
    (BorlandIDEServices as IOTAEditorViewServices).ContextToModule(AContext, md);
  Result := TLMDImporterExpert.EditorFromModule(md);
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDUnitEmbeddedView.Finalize;
begin
  while TraitsList.Count > 0 do
    TObject(TraitsList[0]).Free;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitEmbeddedView.FrameCreated(AFrame: TCustomFrame);
begin
  TLMDUnitViewTraits.Create(AFrame);
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.GetCanCloneView: Boolean;
begin
  Result := False;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.GetCaption: string;
begin
  Result := VIEW_NAME;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.GetEditState(const AContext: IInterface;
  AViewObject: TObject): TEditState;
var
  edtr: TCustomEdit;
begin
  edtr := GetFocusedEditor(AViewObject);

  if edtr <> nil then
    Result := GetEditStateFor(edtr)
  else
    Result := [];
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.GetFrameClass: TCustomFrameClass;
begin
  Result := TFrame;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.GetPriority: Integer;
begin
  Result := svpNormal;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.GetTraits(AViewObject: TFrame): TLMDUnitViewTraits;
var
  i: Integer;
begin
  Result := nil;

  for i := 0 to AViewObject.ComponentCount - 1 do
    if AViewObject.Components[i] is TLMDUnitViewTraits then
    begin
      Result := TLMDUnitViewTraits(AViewObject.Components[i]);
      Break; // for
    end;

  Assert(Result <> nil);
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.GetViewIdentifier: string;
begin
  Result := UnitViewId;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitEmbeddedView.Handles(const AContext: IInterface): Boolean;
var
  edtr: IOTASourceEditor;
begin
  edtr   := EditorFromContext(AContext);
  Result := (edtr <> nil) and (Pos('_LMDSW', UpperCase(edtr.FileName)) = 0);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitEmbeddedView.Hide(const AContext: IInterface;
  AViewObject: TObject);
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitEmbeddedView.ViewClosed(const AContext: IInterface;
  AViewObject: TObject);
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDImportMessage.AddDocsMsgs(
  const ADocuments: array of TLMDUnitDocument);
const
  MSG_KIND: array[TLMDUnitDocMessageKind] of string = ('',
                                                       '[LMDSI Parse Error] ',
                                                       '[LMDSI Info] ',
                                                       '[LMDSI Warning] ',
                                                       '[LMDSI Error] ');
  STATUS: array[Boolean] of string = ('Failed', 'Success');
var
  svc:     IOTAMessageServices;
  infopnt: Pointer;
  errfnd:  Boolean;
  s:       string;
  i, j:    Integer;
  m:       TLMDUnitDocMessage;
  doc:     TLMDUnitDocument;
begin
  svc     := BorlandIDEServices as IOTAMessageServices;
  errfnd  := False;
  infopnt := nil;

  for i := 0 to High(ADocuments) do
    if ADocuments[i] <> nil then
    begin
      doc := ADocuments[i];

      for j := 0 to doc.MessageCount - 1 do
        if doc.Messages[j].Kind <> mkInfo then
        begin
          m := doc.Messages[j];
          s := MSG_KIND[m.Kind] + m.FileName + ': ' + m.Text;

          svc.AddCustomMessage(TLMDImportMessage.Create(doc.UnitPath,
                               doc.NodeFullName[m.Node], s),
                               TLMDImportMessageGroup.Get);
          if not errfnd then
            svc.NextMessage(True);
          if m.Kind = mkError then
            errfnd := True;

          TLMDImportMessage.ShowMessageView;
        end;
    end;

  for i := 0 to High(ADocuments) do
    if ADocuments[i] <> nil then
    begin
      doc := ADocuments[i];

      for j := 0 to doc.MessageCount - 1 do
        if doc.Messages[j].Kind = mkInfo then
        begin
          m := doc.Messages[j];
          s := MSG_KIND[m.Kind] + m.FileName + ': ' + m.Text;

          if infopnt = nil then
            infopnt := svc.AddCustomMessagePtr(TLMDImportMessage.Create('', '',
                                               'Additional info'),
                                               TLMDImportMessageGroup.Get);

          svc.AddCustomMessage(TLMDImportMessage.Create(doc.UnitPath,
                               doc.NodeFullName[m.Node], s), infopnt);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDImportMessage.AddText(const S: string);
var
  svc: IOTAMessageServices;
begin
  svc := BorlandIDEServices as IOTAMessageServices;
  svc.AddCustomMessage(TLMDImportMessage.Create('', '', s),
                       TLMDImportMessageGroup.Get);
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDImportMessage.AddTitle(const S: string);
var
  svc: IOTAMessageServices;
begin
  svc := BorlandIDEServices as IOTAMessageServices;
  svc.AddTitleMessage(s, TLMDImportMessageGroup.Get);
end;

{ ---------------------------------------------------------------------------- }

function TLMDImportMessage.CanGotoSource(var DefaultHandling: Boolean): Boolean;
begin
  Result          := (FFilePath <> '');
  DefaultHandling := False;
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDImportMessage.ClearMessages;
var
  svc: IOTAMessageServices;
begin
  svc := BorlandIDEServices as IOTAMessageServices;
  svc.ClearMessageGroup(TLMDImportMessageGroup.Get);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDImportMessage.Create(const AFilePath, ANodeFullName,
  S: string);
begin
  inherited Create;
  FFilePath     := AFilePath;
  FNodeFullName := ANodeFullName;
  FLineText     := S;
end;

{ ---------------------------------------------------------------------------- }

function TLMDImportMessage.GetChild(Index: Integer): IOTACustomMessage50;
begin
  Result := nil;
end;

{ ---------------------------------------------------------------------------- }

function TLMDImportMessage.GetChildCount: Integer;
begin
  Result := 0;
end;

{ ---------------------------------------------------------------------------- }

function TLMDImportMessage.GetColumnNumber: Integer;
begin
  Result := 0; // Not used.
end;

{ ---------------------------------------------------------------------------- }

function TLMDImportMessage.GetFileName: string;
begin
  Result := ''; // Not used.
end;

{ ---------------------------------------------------------------------------- }

function TLMDImportMessage.GetLineNumber: Integer;
begin
  Result := 0; // Not used.
end;

{ ---------------------------------------------------------------------------- }

function TLMDImportMessage.GetLineText: string;
begin
  Result := FLineText;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDImportMessage.GotoSource(var DefaultHandling: Boolean);
var
  md:     IOTAModule;
  edtr:   IOTASourceEditor;
  i:      Integer;
  traits: TLMDUnitViewTraits;
  cont:   TLMDUnitFrame;
  nd:     TLMDPasNamedNode;
begin
  if FFilePath <> '' then
  begin
    DefaultHandling := False;
    traits          := nil;

    for i := 0 to TraitsList.Count - 1 do
    begin
      traits := TLMDUnitViewTraits(TraitsList[i]);
      cont   := traits.Content;

      if (cont <> nil) and SameText(cont.Document.UnitPath, FFilePath) then
        Break; // for
    end;

    if (traits = nil) or (traits.Content = nil) or
       not traits.Content.Showing then
    begin
      md := (BorlandIDEServices as IOTAModuleServices).OpenModule(FFilePath);

      if md <> nil then
      begin
        // I don't know how to show our custom
        // sub-view after opening the module.

        edtr := TLMDImporterExpert.EditorFromModule(md);
        if edtr <> nil then
          edtr.Show;
      end;
    end;

    if (traits <> nil) and (traits.Content <> nil) and
       (FNodeFullName <> '') then
    begin
      nd := traits.Content.Document.FindNode(FNodeFullName);
      if nd <> nil then
        traits.Content.Select(nd);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDImportMessage.ShowHelp;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDImportMessage.ShowMessageView;
var
  svc: IOTAMessageServices;
begin
  svc := BorlandIDEServices as IOTAMessageServices;
  svc.ShowMessageView(TLMDImportMessageGroup.Get);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDImportMessage.TrackSource(var DefaultHandling: Boolean);
begin
  GotoSource(DefaultHandling);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDImportMessageGroup.MessageGroupAdded(
  const Group: IOTAMessageGroup);
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDImportMessageGroup.MessageGroupDeleted(
  const Group: IOTAMessageGroup);
begin
  MsgGroup := nil; // Required. Otherwize, many IDE
                   // errors will occures.
end;

{ ---------------------------------------------------------------------------- }

class function TLMDImportMessageGroup.Get: IOTAMessageGroup;
var
  svc: IOTAMessageServices;
begin
  if MsgGroup = nil then
  begin
    svc := BorlandIDEServices as IOTAMessageServices;

    MsgGroup := svc.GetGroup('Build');
    if MsgGroup = nil then
      MsgGroup := svc.AddMessageGroup('Build');

    if GroupNotifier = -1 then
      GroupNotifier := svc.AddNotifier(TLMDImportMessageGroup.Create);
  end;

  Result := MsgGroup;
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDImportMessageGroup.Remove;
var
  svc: IOTAMessageServices;
begin
  if MsgGroup <> nil then
  begin
    svc := BorlandIDEServices as IOTAMessageServices;
    svc.ClearMessageGroup(MsgGroup);
    svc.RemoveMessageGroup(MsgGroup); // In case of distinct group we should
                                      // remove it, however, default "Build"
                                      // group is not removable at all, and
                                      // thus, will not be removed.
    if GroupNotifier <> -1 then
      svc.RemoveNotifier(GroupNotifier);

    MsgGroup      := nil;
    GroupNotifier := -1;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.BeginImporting;
begin
  TLMDImportMessage.ClearMessages;
  TLMDImportMessage.AddTitle('Importing ' + ExtractFileName(
                             FContent.Editor.FileName));
  SetStatus('Importing...', 0);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDUnitViewTraits.Create(AViewObject: TCustomFrame);
begin
  inherited Create(AViewObject); // Owned by AView frame.
  FViewObject := AViewObject;
  TraitsList.Add(Self);
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDUnitViewTraits.Destroy;
begin
  TraitsList.Remove(Self);
  Content := nil;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.EndImporting(ASucceded: Boolean);
const
  STATUS: array[Boolean] of string = ('Failed', 'Success');
begin
  TLMDImportMessage.AddDocsMsgs([FContent.Document]);
  TLMDImportMessage.AddTitle(STATUS[ASucceded]);
  if FContent.Document.MessageCount > 0 then
    TLMDImportMessage.ShowMessageView;

  SetStatus('Import ' + STATUS[ASucceded]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.ImportingProgress(AProgress: Integer);
begin
  SetStatus('Importing...', AProgress);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FContent) then
      Content := nil;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.OpenUsedUnit(const AUnitName: string);
var
  path: string;
  doc:  TLMDUnitDocument;
begin
  doc := FContent.Document;

  if doc.FileHandler.FindUsedPasFile(AUnitName, path) then
    (BorlandIDEServices as IOTAActionServices).OpenFile(path);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.SetContent(const Value: TLMDUnitFrame);
begin
  if FContent <> Value then
  begin
    if FContent <> nil then
    begin
      FContent.RemoveFreeNotification(Self);
      FContent.Parent  := nil;
      FContent.Visible := False;
      FContent.Traits  := nil;
    end;
    FContent := Value;
    if FContent <> nil then
    begin
      FContent.FreeNotification(Self);
      FContent.Traits  := Self;
      FContent.Align   := alClient;
      FContent.Visible := True;
      FContent.Parent  := FViewObject;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.SetStatus(const S: string; AProgress: Integer);
var
  i:    Integer;
  sb:   TStatusBar;
  step: Integer;
begin
  sb   := (BorlandIDEServices as INTAEditorServices).TopEditWindow.StatusBar;
  step := 0;

  for i := 0 to sb.Panels.Count - 1 do
    if sb.Panels[i].Style = psText then
    begin
      case step of
        0:  begin
              sb.Panels[i].Text := S;
              Inc(step);
            end;
        1:  begin
              if AProgress <> -1 then
                sb.Panels[i].Text := IntToStr(AProgress) + '%'
              else
                sb.Panels[i].Text := '';
              Inc(step);
            end;
      else
        sb.Panels[i].Text := '';
      end;
    end;

  sb.Update;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitViewTraits.UpdateCaption;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitViewTraits.UseExternalMessageView: Boolean;
begin
  Result := True;
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchEmbeddedView.CloneEditorView: INTACustomEditorView;
begin
  Result := nil; // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchEmbeddedView.CloseAllCalled(var ShouldClose: Boolean);
begin
  ShouldClose := True;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchEmbeddedView.ConfigurePanel(StatusBar: TStatusbar;
  Panel: TStatusPanel);
begin
  Panel.Width := 250;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchEmbeddedView.DeselectView;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchEmbeddedView.DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchEmbeddedView.EditAction(Action: TEditAction): Boolean;
var
  edtr: TCustomEdit;
begin
  edtr := GetFocusedEditor;

  if edtr <> nil then
    Result := EditActionFor(edtr, Action)
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDBatchEmbeddedView.Finalize;
var
  svc: IOTAEditorViewServices;
begin
  svc := (BorlandIDEServices as IOTAEditorViewServices);
  svc.UnregisterEditorView(BatchViewId);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchEmbeddedView.FrameCreated(AFrame: TCustomFrame);
var
  bfrm: TLMDBatchFrame;
begin
  bfrm        := TLMDBatchFrame(AFrame);
  bfrm.Traits := TLMDBatchTraits.Create(bfrm);
  bfrm.Name   := ''; // Required. Otherwise, duplicate
                     // name error will occur.
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchEmbeddedView.GetCanCloneView: Boolean;
begin
  Result := False;
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchEmbeddedView.GetCaption: string;
begin
  Result := 'LMD-ScriptPack Batch Import';
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchEmbeddedView.GetEditorWindowCaption: string;
begin
  Result := GetCaption;
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchEmbeddedView.GetEditState: TEditState;
var
  edtr: TCustomEdit;
begin
  edtr := GetFocusedEditor;

  if edtr <> nil then
    Result := GetEditStateFor(edtr)
  else
    Result := [];
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchEmbeddedView.GetFocusedEditor: TCustomEdit;
var
  acvctl: TWinControl;
begin
  Result := nil;
  acvctl := Screen.ActiveControl;

  if acvctl is TCustomEdit then
    Result := TCustomEdit(acvctl);
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchEmbeddedView.GetFrameClass: TCustomFrameClass;
begin
  Result := TLMDBatchFrame;
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchEmbeddedView.GetStatusPanelCount: Integer;
begin
  Result := 1;
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchEmbeddedView.GetViewIdentifier: string;
begin
  Result := BatchViewId;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchEmbeddedView.SelectView;
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchTraits.BeginImporting;
begin
  TLMDImportMessage.ClearMessages;
  TLMDImportMessage.AddTitle('Batch Importing');
  SetStatus('Importing...');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchTraits.BeginUnitImport(ADocument: TLMDUnitDocument);
begin
  SetStatus('Importing unit: ' + ExtractFileName(ADocument.UnitPath));
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDBatchTraits.Create(AFrame: TLMDBatchFrame);
begin
  inherited Create(AFrame); // Owner by batch frame.
  FFrame := AFrame;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchTraits.EndImporting(
  const ADocuments: array of TLMDUnitDocument; ASucceded: Boolean);
const
  STATUS: array[Boolean] of string = ('Failed', 'Success');
begin
  TLMDImportMessage.AddDocsMsgs(ADocuments);
  TLMDImportMessage.AddTitle(STATUS[ASucceded]);
  TLMDImportMessage.ShowMessageView;

  SetStatus('Import ' + STATUS[ASucceded]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchTraits.EndUnitImport(ADocument: TLMDUnitDocument;
  ASucceded: Boolean);
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchTraits.SetStatus(const S: string);
var
  sb: TStatusBar;
begin
  sb := (BorlandIDEServices as INTAEditorServices).TopEditWindow.StatusBar;

  if sb.Panels.Count > 0 then
  begin
    sb.Panels[0].Text := S;
    sb.Update;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchTraits.UnitNotFound(const AUnitName: string);
begin
  TLMDImportMessage.AddText('[LMDSI Fatal error] File not found: ' +
                            AUnitName);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBatchTraits.HintsSaved(const AFilePath: string);
begin
  TLMDImportMessage.AddText('[LMDSI] Hint file generated: ' +
                            AFilePath);
end;

{ ---------------------------------------------------------------------------- }

function TLMDBatchTraits.UseExternalMessageView: Boolean;
begin
  Result := True;
end;

{ ---------------------------------------------------------------------------- }

initialization
  TraitsList := TList.Create;

{ ---------------------------------------------------------------------------- }

finalization
  TLMDImportMessageGroup.Remove;
  TLMDUnitEmbeddedView.Finalize;
  TLMDBatchEmbeddedView.Finalize;
  FreeAndNil(TraitsList);

{$ENDIF}

end.
