unit LMDSedDialogs;
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
>>>>>>> .r5452

LMDSedDialogs unit (VT)
------------------------
This unit contains dialog related classes for LMD SyntaxEdit packages.

Changes
-------
Release 1.22 (March 2008)
 - Initial Release

###############################################################################}

interface

uses
  Classes, CommDlg,  Controls, Dialogs, ComCtrls, Windows,
  intfLMDBase, LMDTypes,
  LMDSedDocument, LMDSedSchemeEditDialog, LMDSedFindDialog, LMDSedView;


type
  {************************* TLMDEditBaseDialog ******************************}
  TLMDEditBaseDialog = class(TCommonDialog, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FView:  TLMDCustomEditView;
    procedure SetView(const Value: TLMDCustomEditView);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    procedure CheckViewSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function getLMDPackage: TLMDPackageID;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property View: TLMDCustomEditView read FView write SetView;
  end;

  {************************* TLMDEditSearchDilog ******************************}

  TLMDEditFindDialog = class(TLMDEditBaseDialog)
  protected
    FLastResult: TLMDEditSearchResult;
    FOptions: TLMDEditSearchDlgOptions;
    FSearch:  TLMDMemoryStrings;

    function  GetDirection: TLMDEditSearchDirection;
    function  GetOptions: TLMDEditSearchOptions;
    function  GetSearches: TLMDStrings;
    function  GetStart: TLMDEditViewSearchStart;
    procedure SetDirection(AValue: TLMDEditSearchDirection);
    procedure SetOptions(AValue: TLMDEditSearchOptions);
    procedure SetSearches(AValue: TLMDStrings);
    procedure SetStart(AValue: TLMDEditViewSearchStart);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; override;
    {$ELSE}
    function Execute: Boolean; override;
    {$ENDIF}

    {$IFDEF LMDCOMP9}
    function ExecuteNext(ParentWnd: HWND): Boolean; virtual;
    {$ELSE}
    function ExecuteNext: Boolean; virtual;
    {$ENDIF}

    property LastResult: TLMDEditSearchResult read FLastResult;
  published
    property Options: TLMDEditSearchOptions read GetOptions
                                            write SetOptions
                                            default [];

    property Direction: TLMDEditSearchDirection read GetDirection
                                                write SetDirection
                                                default sdForward;

    property Start: TLMDEditViewSearchStart read GetStart
                                            write SetStart
                                            default ssCursor;

    property Searches: TLMDStrings read GetSearches
                                   write SetSearches;
  end;

  {*********************** TLMDEditReplaceDialog ****************************}

  TLMDEditReplaceDialog = class(TLMDEditFindDialog)
  protected
    FReplaces:  TLMDMemoryStrings;

    function  GetReplaces: TLMDStrings;
    procedure SetReplaces(AValue: TLMDStrings);

    function  GetReplaceAllBounds: TLMDEditViewReplaceAllBounds;
    procedure SetReplaceAllBounds(AValue: TLMDEditViewReplaceAllBounds);
    function  GetLastReplaces: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; override;
    {$ELSE}
    function Execute: Boolean; override;
    {$ENDIF}

    {$IFDEF LMDCOMP9}
    function ExecuteNext(ParentWnd: HWND): Boolean; override;
    {$ELSE}
    function ExecuteNext: Boolean; override;
    {$ENDIF}

    property LastReplacesNumber: Integer read GetLastReplaces;
  published
    property Replaces: TLMDStrings read GetReplaces
                                   write SetReplaces;

    property ReplaceAllBounds: TLMDEditViewReplaceAllBounds
                               read GetReplaceAllBounds
                               write SetReplaceAllBounds
                               default rbAllText;
  end;


  {*********************** TLMDEditKeybindingsDilog ***************************}

  TLMDEditKeybindingsDialog = class(TLMDEditBaseDialog)
  public
    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; override;
    {$ELSE}
    function Execute: Boolean; override;
    {$ENDIF}
  end;

  {************************ TLMDEditGotoLineDialog ****************************}

  TLMDEditGotoLineDialog = class(TLMDEditBaseDialog)
  public
    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; override;
    {$ELSE}
    function Execute: Boolean; override;
    {$ENDIF}
  end;

  {************************* TLMDEditBaseDialog ******************************}

  TLMDEditBaseSchemeDialog = class(TCommonDialog, ILMDComponent)
  protected
    FAbout: TLMDAboutVar;
    FDoc:  TLMDEditDocument;

    procedure CheckScheme(AName: TLMDString;
                          AKind: TLMDEditSchemeEditKind;
                          ForSetScheme: Boolean);

    procedure SetDoc(ADoc: TLMDEditDocument);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    procedure CheckDocSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    getLMDPackage: TLMDPackageID;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
    property Document: TLMDEditDocument read FDoc write SetDoc;
  end;

  {********************* TLMDEditColorSchemeDialog ****************************}

  TLMDEditColorSchemeDialog = class(TLMDEditBaseSchemeDialog)
  protected
    FScheme: TLMDColorSchemeRef;

    procedure SetScheme(AValue: TLMDColorSchemeRef);
  public
    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; override;
    {$ELSE}
    function Execute: Boolean; override;
    {$ENDIF}
  published
    property ColorScheme: TLMDColorSchemeRef read FScheme write SetScheme;
  end;

  {********************* TLMDEditColorSchemeDialog ****************************}

  TLMDEditSyntaxSchemeDialog = class(TLMDEditBaseSchemeDialog)
  protected
    FScheme: TLMDSyntaxSchemeRef;

    procedure SetScheme(AValue: TLMDSyntaxSchemeRef);
  public
    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; override;
    {$ELSE}
    function Execute: Boolean; override;
    {$ENDIF}
  published
    property SyntaxScheme: TLMDSyntaxSchemeRef read FScheme write SetScheme;
  end;

implementation

uses LMDSedGotoLineDialog, LMDSedKeyBindingsDialog, LMDSedColorSchemeDialog,
     LMDSedConst;

{ TLMDEditBaseDialog }

procedure TLMDEditBaseDialog.CheckViewSet;
begin
  if FView=nil then
    raise ELMDEditViewError.Create(SLMDSedDialogViewNotSet);
end;

constructor TLMDEditBaseDialog.Create(AOwner: TComponent);
begin
  inherited;
  FView := nil;
end;

destructor TLMDEditBaseDialog.Destroy;
begin
  SetView(nil);
  
  inherited;
end;

function TLMDEditBaseDialog.getLMDPackage: TLMDPackageID;
begin
  result := pi_LMD_SYNTAX;
end;

procedure TLMDEditBaseDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  if (Operation=opRemove) and (AComponent=FView) then
    SetView(nil);
end;

procedure TLMDEditBaseDialog.SetView(const Value: TLMDCustomEditView);
begin
  if Assigned(FView) then
    FView.RemoveFreeNotification(self);

  FView := Value;

  if Assigned(FView) then
    FView.FreeNotification(self);
end;

{ TLMDEditFindDialog }

constructor TLMDEditFindDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FOptions.ReplaceAllBounds := rbAllText;
  FOptions.Options := [];
  FOptions.Direction := sdForward;
  FOptions.Start := ssCursor;
  FOptions.LastNumberOfReplacements := 0;
  FOptions.WasReplaceAllChosen := false;
  FLastResult := srNotFound;

  FSearch := TLMDMemoryStrings.Create;
end;

destructor TLMDEditFindDialog.Destroy;
begin
  FSearch.Free;

  inherited;
end;

{$IFDEF LMDCOMP9}
function TLMDEditFindDialog.Execute(ParentWnd: HWND): Boolean;
{$ELSE}
function TLMDEditFindDialog.Execute: Boolean;
{$ENDIF}
var
    Res: TLMDEditSearchResult;
begin
  CheckViewSet;

  Res := LMDEditExecFindDialog(SLMDSedDialogFindCaption, FView, FOptions);

  Result := Res<>srNotFound;
  
  FLastResult := Res;
end;

{$IFDEF LMDCOMP9}
function TLMDEditFindDialog.ExecuteNext(ParentWnd: HWND): Boolean;
{$ELSE}
function TLMDEditFindDialog.ExecuteNext: Boolean;
{$ENDIF}
begin
  CheckViewSet;

  if FView.SearchState=stInSearch then
    Result := FView.SearchNext
  else
    raise ELMDEditViewError.Create(SLMDSedDialogFindBadState);
end;

function TLMDEditFindDialog.GetDirection: TLMDEditSearchDirection;
begin
  result := FOptions.Direction;
end;

function TLMDEditFindDialog.GetOptions: TLMDEditSearchOptions;
begin
  result := FOptions.Options;
end;

function TLMDEditFindDialog.GetSearches: TLMDStrings;
var
    i: Integer;
begin
  FSearch.Clear;

  for i := 0 to Length(FOptions.Searches) - 1 do
    FSearch.Add(FOptions.Searches[i]);

  result := FSearch;
end;

function TLMDEditFindDialog.GetStart: TLMDEditViewSearchStart;
begin
  Result := FOptions.Start;
end;

procedure TLMDEditFindDialog.SetDirection(AValue: TLMDEditSearchDirection);
begin
  FOptions.Direction := AValue;
end;

procedure TLMDEditFindDialog.SetOptions(AValue: TLMDEditSearchOptions);
begin
  FOptions.Options := AValue;
end;

procedure TLMDEditFindDialog.SetSearches(AValue: TLMDStrings);
var
    i: Integer;
begin
  SetLength(FOptions.Searches, AValue.Count);

  for i := 0 to AValue.Count - 1 do
    FOptions.Searches[i] := AValue[i];
end;

procedure TLMDEditFindDialog.SetStart(AValue: TLMDEditViewSearchStart);
begin
  FOptions.Start := AValue;
end;

{ TLMDEditReplaceDialog }

constructor TLMDEditReplaceDialog.Create(AOwner: TComponent);
begin
  inherited;

  FReplaces := TLMDMemoryStrings.Create;
  FOptions.LastNumberOfReplacements := 0;
end;

destructor TLMDEditReplaceDialog.Destroy;
begin
  FReplaces.Free;

  inherited;
end;

{$IFDEF LMDCOMP9}
function TLMDEditReplaceDialog.Execute(ParentWnd: HWND): Boolean;
{$ELSE}
function TLMDEditReplaceDialog.Execute: Boolean;
{$ENDIF}
var
    Res: TLMDEditSearchResult;
begin
  CheckViewSet;

  FOptions.LastNumberOfReplacements := 0;

  Res := LMDEditExecReplaceDialog(SLMDSedDialogReplaceCaption, FView, FOptions);

  Result := Res<>srNotFound;

  FLastResult := Res;
end;

{$IFDEF LMDCOMP9}
function TLMDEditReplaceDialog.ExecuteNext(ParentWnd: HWND): Boolean;
{$ELSE}
function TLMDEditReplaceDialog.ExecuteNext: Boolean;
{$ENDIF}
begin
  CheckViewSet;

  if FView.SearchState=stInReplace then
    Result := FView.ReplaceNext
  else
    raise ELMDEditViewError.Create(SLMDSedDialogReplaceBadState);
end;

function TLMDEditReplaceDialog.GetLastReplaces: Integer;
begin
  Result := FOptions.LastNumberOfReplacements;
end;

function TLMDEditReplaceDialog.GetReplaceAllBounds: TLMDEditViewReplaceAllBounds;
begin
  Result := FOptions.ReplaceAllBounds;
end;

function TLMDEditReplaceDialog.GetReplaces: TLMDStrings;
var
    i: Integer;
begin
  FReplaces.Clear;

  for i := 0 to Length(FOptions.Replaces) - 1 do
    FReplaces.Add(FOptions.Replaces[i]);

  result := FReplaces;
end;

procedure TLMDEditReplaceDialog.SetReplaceAllBounds(AValue: TLMDEditViewReplaceAllBounds);
begin
  FOptions.ReplaceAllBounds := AValue;
end;

procedure TLMDEditReplaceDialog.SetReplaces(AValue: TLMDStrings);
var
    i: Integer;
begin
  SetLength(FOptions.Replaces, AValue.Count);

  for i := 0 to AValue.Count - 1 do
    FOptions.Replaces[i] := AValue[i];
end;

{ TLMDEditKeybindingsDialog }

{$IFDEF LMDCOMP9}
function TLMDEditKeybindingsDialog.Execute(ParentWnd: HWND): Boolean;
{$ELSE}
function TLMDEditKeybindingsDialog.Execute: Boolean;
{$ENDIF}
begin
  CheckViewSet;

  Result := LMDEditExecKeyBindingsDialog(FView);
end;

{ TLMDEditGotoLineDialog }

{$IFDEF LMDCOMP9}
function TLMDEditGotoLineDialog.Execute(ParentWnd: HWND): Boolean;
{$ELSE}
function TLMDEditGotoLineDialog.Execute: Boolean;
{$ENDIF}
var
    Max, Res: Integer;
begin
  CheckViewSet;

  if FView.Document<>nil then
    Max := FView.Document.LinesCount
  else
    Max := 0;

  Result := LMDEditAskGoToLine(Max, Res);

  if Result then
    FView.GotoPhysLine(Res);
end;

{ TLMDEditColorSchemeDialog }

procedure TLMDEditBaseSchemeDialog.CheckDocSet;
begin
  if FDoc=nil then
    raise ELMDEditViewError.Create(SLMDSedDialogDocumentNotSet);
end;

procedure TLMDEditBaseSchemeDialog.CheckScheme(AName: TLMDString;
                                               AKind: TLMDEditSchemeEditKind;
                                               ForSetScheme: Boolean);
var
    Coll: TLMDEditParserSchemeCollection;
    Err: TLMDString;
begin
  if FDoc<>nil then
  begin
    Coll := nil;
    Err := '';

    case AKind of
      skSyntax:
      begin
        Coll := FDoc.SyntaxSchemes;
        Err  := SLMDSedDialogSyntaxSchemeNotFound;
      end;

      skColor:
      begin
        Coll := FDoc.ColorSchemes;
        Err  := SLMDSedDialogColorSchemeNotFound;
      end;
    else
      Assert(false);
    end;

    if AName='' then
    begin
      if not ForSetScheme then
        raise ELMDEditViewError.Create(SLMDSedDialogSchemeNotSet);
    end;

    if (AName<>'') and (Coll.FindItem(AName)=nil)  then
      raise ELMDEditViewError.CreateFmt(Err, [AName]);
  end;
end;

constructor TLMDEditBaseSchemeDialog.Create(AOwner: TComponent);
begin
  inherited;

  FDoc := nil;
end;

destructor TLMDEditBaseSchemeDialog.Destroy;
begin
  SetDoc(nil);

  inherited;
end;

function TLMDEditBaseSchemeDialog.getLMDPackage: TLMDPackageID;
begin
  result := pi_LMD_SYNTAX;
end;

procedure TLMDEditBaseSchemeDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  if (Operation=opRemove) and (AComponent=FDoc) then
    SetDoc(nil);
end;

procedure TLMDEditBaseSchemeDialog.SetDoc(ADoc: TLMDEditDocument);
begin
  if Assigned(FDoc) then
    FDoc.RemoveFreeNotification(self);

  FDoc := ADoc;

  if Assigned(FDoc) then
    FDoc.FreeNotification(self);
end;

{ TLMDEditColorSchemeDialog }

{$IFDEF LMDCOMP9}
function TLMDEditColorSchemeDialog.Execute(ParentWnd: HWND): Boolean;
{$ELSE}
function TLMDEditColorSchemeDialog.Execute: Boolean;
{$ENDIF}
begin
  CheckDocSet;
  CheckScheme(FScheme, skColor, false);

  Result := LMDEditExecColorSchemesDialog(FDoc, FScheme);
end;

procedure TLMDEditColorSchemeDialog.SetScheme(AValue: TLMDColorSchemeRef);
begin
  CheckScheme(AValue, skColor, true);

  FScheme := AValue;
end;

{ TLMDEditSyntaxSchemeDialog }

{$IFDEF LMDCOMP9}
function TLMDEditSyntaxSchemeDialog.Execute(ParentWnd: HWND): Boolean;
{$ELSE}
function TLMDEditSyntaxSchemeDialog.Execute: Boolean;
{$ENDIF}
var
    Scheme: TLMDEditParserSchemeCollectionItem;
begin
  CheckDocSet;
  CheckScheme(FScheme, skSyntax, false);

  Scheme := FDoc.SyntaxSchemes.FindItem(FScheme);
  Result := LMDEditExecSchemeXMLDialog(Scheme.Scheme, skSyntax);
end;

procedure TLMDEditSyntaxSchemeDialog.SetScheme(AValue: TLMDSyntaxSchemeRef);
begin
  CheckScheme(AValue, skSyntax, true);

  FScheme := AValue;
end;

end.
