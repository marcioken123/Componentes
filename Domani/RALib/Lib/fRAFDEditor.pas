{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       form        : TRAFDEditWindow
       description : text file editor

       programer   : black(nbs)
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib.htm
************************************************************}

{$INCLUDE RA.INC}

unit fRAFDEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, ComCtrls,
  StdCtrls, Dialogs, RARegAuto, Menus, Forms,
  {$IFDEF RA_D4H} ImgList, {$ENDIF RA_D4H}
  RAEditor, RAHLEditor, RAHint, IParser,
  RAFDIDE, DsgnIntf, TypInfo, EditIntf, RAFDCompat;

const

  WM_RESETFOCUS = wm_User + $100 + 1;            

type

  TRAFDEditWindow = class;

  TFileEditor = class(TRAHLEditor)
  private
    FExecBegX, FExecBegY, FExecEndX, FExecEndY : integer;
    FStackBegX, FStackBegY, FStackEndX, FStackEndY : integer;
    FErrY : integer;
   // XX, YY : integer;
    FDesigner: TFormDesigner;
    FFileName: TFileName;
    Tab: TTabSheet;
    FForm: TRAFDEditWindow;
    UnitName : string;
    Parser: TIParser;
    IsNewFile: Boolean;
    dfm: Boolean;
    FModuleInterface: TIRAModuleInterface;
    FIsProjectFile: Boolean;
    ParserText: string;
    function FindMethod(const Name: string): Integer;
    function FindMethodDecl(const Name: string): Integer;
    procedure FindFormDecl(var Line: Integer);
    procedure FindMethodSection(var Line: Integer);
    procedure FindUnitEnd(var Line: Integer);
    procedure FindToken(const Token: string);
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure ChangeAttr(Line, ColBeg, ColEnd : integer); override;
    procedure GutterPaint(Canvas : TCanvas); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure ShowPoint(PosBeg, PosEnd : integer; var BegX, BegY, EndX, EndY : integer);
    procedure TextModified(Pos : integer; Action : TModifiedAction; Text : string); override;
    procedure Changed; override;
    procedure StatusChanged; override;
    procedure ExtensionChanged;
    function GetReservedWord(const Token: string; var Reserved: Boolean)
      : Boolean; override;
    function UserReservedWords: boolean; override;
    procedure UpdateSettings;
    procedure SetParser(const S: string);
    procedure InitParser;
    procedure ReplaceToken(const NewToken: string);
  public
    constructor CreateF(AOwner : TComponent; ATab: TTabSheet;
      AFileName : TFileName; Source : string);
    destructor Destroy; override;
    function Save: Boolean;
    function SaveAs: Boolean;
    procedure Close;
    procedure Check4Save;
    function Modified2: Boolean;
    procedure ShowExecutionPoint(PosBeg, PosEnd : integer);
    procedure ShowCallStackPoint(PosBeg, PosEnd : integer);
    procedure ShowErrorPoint(ErrPos : integer);
    procedure ShowBreakPoint(PosBeg, PosEnd : integer);
    function BPIndex(PBeg, PEnd : integer) : integer;
    procedure pmEditorPopup;
    procedure TogleBreakPoint;
    procedure Activate;
    property Designer: TFormDesigner read FDesigner write FDesigner;
    property FileName: TFileName read FFileName;
    property Form: TRAFDEditWindow read FForm;
  public { source modifiers for designer requests }
    procedure CreateComponent(Component: TComponent; const NewName: string);
    procedure DeleteComponent(Component: TComponent);
    procedure RenameComponent(Component: TComponent; const NewName: string);
    procedure RenameForm(const CurName, NewName: string);
    procedure RenameUnit(const NewName: string);
    procedure ShowMethod(const Name: string);
    function MethodExists(const Name: string): Boolean;
    procedure RenameMethod(const CurName, NewName: string);
    procedure GetMethods(TypeData: PTypeData; Proc: TGetStrProc);
    function CreateMethod(const Name: string; TypeData: PTypeData): TMethod;
  private { TStrings property editor support }
    IsStrings: Boolean;
    StringsComponent: TPersistent;
    Strings: TStrings;
    FormFileEditor: TFileEditor;
    procedure WMResetFocus(var Message: TMessage); message WM_RESETFOCUS;
    procedure SavePropValue;
    procedure DeleteStrings(AComponent: TComponent);
  public { TStrings property editor support }
    procedure EditStrings(AInstance: TPersistent; AStrings: TSTrings;
      APropInfo: PPropInfo; ACurrentValue: TStrings);
    function ActivateStrings(AInstance: TPersistent; AStrings: TSTrings;
      APropInfo: PPropInfo): Boolean;
  public
    procedure SetModuleInterface(AModuleInterface: TIRAModuleInterface);
    property ModuleInterface: TIRAModuleInterface read FModuleInterface;
    property IsProjectFile: Boolean read FIsProjectFile write FIsProjectFile;
  end;

  TLoadFile = procedure (Sender: TRAFDEditWindow; var FileName: TFileName;
    var FullFileName: TFileName; var Text: string; var Done: Boolean) of object;
  TSaveFile = procedure (Sender: TFileEditor; var FileName: TFileName;
    Text: string; var Done: Boolean) of object;

  TRAFDEditWindow = class(TForm)
    RegAuto: TRegAuto;
    StatusBar: TStatusBar;
    EditorLocalMenu: TPopupMenu;
    ecClosePage: TMenuItem;
    ecOpenFileAtCursor: TMenuItem;
    OpenFileDlg: TOpenDialog;
    Images: TImageList;
    RAHint1: TRAHint;
    miTogleBreakPoint: TMenuItem;
    N1: TMenuItem;
    ecReadOnlyItem: TMenuItem;
    miAddWatch: TMenuItem;
    miEvaluateModify: TMenuItem;
    LargeGutterImages: TImageList;
    lblFont: TLabel;
    Label1: TLabel;
    procedure ecClosePageClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure RegAutoAfterLoad(Sender: TObject);
    procedure RegAutoAfterSave(Sender: TObject);
    procedure ecOpenFileAtCursorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditorLocalMenuPopup(Sender: TObject);
    procedure miTogleBreakPointClick(Sender: TObject);
    procedure ecReadOnlyItemClick(Sender: TObject);
    procedure miEvaluateModifyClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    TabControl: TPageControl;
    FOnChangeStatus: TNotifyEvent;
    FOnLoadFile: TLoadFile;
    FOnSaveFile: TSaveFile;
    FOnSaveFileAs: TSaveFile;
    FOnFileCloseQuery: TNotifyEvent;
    FOnActivate: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
    Closing: Boolean;
    function GetEditor(index : integer): TFileEditor;
    procedure UpdateStatus;
    function iFileOpen(lFileName : TFileName) : boolean;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMGetMinMaxInfo(var M : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    function MakeTab(const UnitFullName: TFileName; const Source: string): TFileEditor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ActiveEditor : TFileEditor;
    function OpenFile(lUnitName : string; ShowOpenDialog : boolean) : boolean;
    function FileNew: TFileName;
    procedure OpenNewFile(const FileName : TFileName);
    procedure DeleteAllErrorPoint;
    procedure ShowBreakPoint(index : integer);
    function EditorCount : integer;
    function Changed: Boolean;
    property Editors[index : integer] : TFileEditor read GetEditor;
    property OnChangeStatus: TNotifyEvent read FOnChangeStatus write FOnChangeStatus;
    property OnLoadFile: TLoadFile read FOnLoadFile write FOnLoadFile;
    property OnSaveFile: TSaveFile read FOnSaveFile write FOnSaveFile;
    property OnSaveFileAs: TSaveFile read FOnSaveFileAs write FOnSaveFileAs;
    property OnFileCloseQuery: TNotifyEvent read FOnFileCloseQuery write FOnFileCloseQuery;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
  end;

  TEditWindow = class(TRAFDEditWindow);

var
  ActiveFileEditor: TFileEditor;
  ActiveEditWindow: TRAFDEditWindow;

implementation

uses RAUtils, iMTracer, RAConst, RAFD, RAFDDesigner, fRAFDProjectManager;

{$R *.DFM}

const
  ISExt = '.pas';

  clDontChange = High(TColor);

  { image indexes }
  imExecute = 0;
  imError   = 1;
  imStack   = 2;
  imBreak   = 3;

type
  TTabControl = class(TPageControl);  

{************************ TRAFDEditWindow ***********************}
constructor TRAFDEditWindow.Create(AOwner: TComponent);
begin
  ODS('TRAFDEditWindow.Create');
  inherited Create(AOwner);
  Name := 'EditWindow';
  RegAuto.RegPath := BaseRegKey;
  ActiveEditWindow := Self;
  TabControl := TTabControl.Create(Self);
  TabControl.Parent := Self;
  TabControl.Name := 'TabControl';
//  TabControl.Caption := 'TabControl';
  TabControl.OnChange := TabControlChange;
  TabControl.TabStop := False;
  TabControl.PopupMenu := EditorLocalMenu;
  RegAuto.Load;
end;    { Create }

destructor TRAFDEditWindow.Destroy;
begin
  ODS('TRAFDEditWindow.Destroy');
  ActiveEditWindow := FindFormByClass(ClassInfo) as TRAFDEditWindow;
  if Assigned(FOnDestroy) then FOnDestroy(Self);
  inherited Destroy;
end;

procedure TRAFDEditWindow.FormDestroy(Sender: TObject);
begin
  RegAuto.Save;
end;

function TRAFDEditWindow.iFileOpen(lFileName : TFileName) : boolean;
var
  i : integer;
  Source : string;
  UnitFullName: TFileName;
  D : boolean;
  IsNewFile: Boolean;
begin
  Result := false;
  IsNewFile := lFileName = '';
	{если файл уже открыт, то активизировать его страницу}
	for i := 0 to EditorCount-1 do
		if Editors[i].FileName = lFileName then
		begin
			TabControl.ActivePage := Editors[i].Parent as TTabSheet;
			Result := true;
			exit;
		end;
  {иначе создать страницу}
  D := False;
  FOnLoadFile(Self, lFileName, UnitFullName, Source, D);
  if D then
  begin
    MakeTab(UnitFullName, Source);
  	if IsNewFile then
  	begin
  		ActiveFileEditor.IsNewFile := IsNewFile;
  		ActiveFileEditor.Modified := True;
  	end;
    Result := true;
  end;
end;

function TRAFDEditWindow.MakeTab(const UnitFullName: TFileName;
  const Source: string): TFileEditor;
var
  Tab : TTabSheet;
begin
	Tab := TTabSheet.Create(TabControl);
	Tab.PageControl := TabControl;
	Tab.Parent := TabControl;
	Result := TFileEditor.CreateF(Self, Tab, UnitFullName, Source);
  Result.ExtensionChanged;
	TabControl.ActivePage := Tab;
	TabControlChange(TabControl);
	Visible := true;
  ActiveFileEditor := Result;
end;    { MakeTab }

function TRAFDEditWindow.OpenFile(lUnitName : string; ShowOpenDialog : boolean)
  : Boolean;
var
  FN : TFileName;
begin
  Result := iFileOpen(lUnitName);
  if not Result and ShowOpenDialog then
  begin
    FN := lUnitName + ISExt;
    OpenFileDlg.FileName := FN;
    if OpenFileDlg.Execute then iFileOpen(OpenFileDlg.FileName);
  end;
end;

function TRAFDEditWindow.FileNew: TFileName;
begin
  iFileOpen('');
  Result := ActiveEditor.FileName;
end;

procedure TRAFDEditWindow.OpenNewFile(const FileName : TFileName);
begin
  iFileOpen('');
  ActiveEditor.FFileName := FileName;
end;

function TRAFDEditWindow.EditorCount : integer;
begin
  Result := TabControl.PageCount;
end;

function TRAFDEditWindow.GetEditor(index : integer) : TFileEditor;
begin
  Result := TabControl.Pages[index].Controls[0] as TFileEditor;
end;

function TRAFDEditWindow.ActiveEditor : TFileEditor;
begin
  if TabControl.ActivePage <> nil then
    Result := TabControl.ActivePage.Controls[0] as TFileEditor else
    Result := nil;
end;

function TRAFDEditWindow.Changed: Boolean;
var
  i: integer;
begin
  Result := True;
  for i := 0 to EditorCount - 1 do
    if Editors[i].Modified2 then Exit;
  Result := False;
end;

procedure TRAFDEditWindow.ecClosePageClick(Sender: TObject);
begin
  if ActiveEditor <> nil then
  begin
    ActiveFileEditor.Check4Save;
    ActiveEditor.Close;
  end;
end;

procedure TRAFDEditWindow.TabControlChange(Sender: TObject);
begin
  if Closing then Exit;
  ActiveFileEditor := ActiveEditor;
  if TabControl.PageCount = 0 then
    Close
  else
  if ActiveFileEditor <> nil then
    UpdateStatus;
end;

procedure TRAFDEditWindow.UpdateStatus;
const
  Modi : array[boolean] of string[10] = ('', 'Modify');
  Modes : array[boolean] of string[10] = ('Overwrite', 'Insert');
{var
  AllModified : boolean;
  i : integer;}
begin
  if ActiveEditor = nil then Exit;
  Caption := ExtractRelativePath(ExtractFilePath(ProjectManager.GetProjectName),
    ActiveEditor.FileName);
  with StatusBar, ActiveEditor do
  begin
    Panels[0].Text := IntToStr(CaretY) + ':' + IntToStr(CaretX);
    Panels[1].Text := Modi[Modified];
    if ReadOnly then Panels[2].Text := 'Read only'
    else Panels[2].Text := Modes[InsertMode];
  end;
  if Assigned(FOnChangeStatus) then FOnChangeStatus(Self);

{  Main.sbSave.Enabled := ActiveTab.Modified;
  AllModified := false;
  for i := 0 to TabsCount-1 do
    if Tabs[i].Modified then begin
      AllModified := true;
      break
    end;
  Main.sbSaveAll.Enabled := AllModified;
  Main.miFileSaveAll.Enabled := Main.sbSaveAll.Enabled;
  Main.miFileSave.Enabled := Main.sbSave.Enabled;
  Main.ButtonsEnabled(true); }
end;

procedure TRAFDEditWindow.RegAutoAfterLoad(Sender: TObject);
{var
  i : integer;
  FN : TFileName; }
begin
 { for i := 0 to RegAuto.ReadInteger('Editor\OpenFiles', 'Count', 0)-1 do
    iFileOpen(RegAuto.ReadString('Editor\OpenFiles', 'File'+IntToStr(i), ''));
  if ActiveEditor <> nil then FN := ActiveEditor.FileName else FN := '';
  FN := RegAuto.ReadString('Editor\OpenFiles', 'ActiveFile', FN);
  for i := 0 to EditorCount-1 do
    if Editors[i].FileName = FN then
      TabControl.ActivePage := Editors[i].Owner as TTabSheet; }
end;

procedure TRAFDEditWindow.RegAutoAfterSave(Sender: TObject);
var
  i : integer;
begin
  RegAuto.EraseSection(Name + '\OpenFiles');
  RegAuto.WriteInteger(Name + '\OpenFiles', 'Count', EditorCount);
  for i := 0 to EditorCount-1 do
    RegAuto.WriteString(Name + '\OpenFiles', 'File'+IntToStr(i),
      Editors[i].FileName);
  if ActiveEditor <> nil then
    RegAuto.WriteString(Name + '\OpenFiles', 'ActiveFile',
      ActiveEditor.FileName);
end;

procedure TRAFDEditWindow.ecOpenFileAtCursorClick(Sender: TObject);
begin
  with ActiveEditor do
    OpenFile(GetWordOnPos(Lines.Text, SelStart), true);
end;

procedure TRAFDEditWindow.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i : integer;
begin
  Closing := True;
  RegAuto.Save;
  for i := 0 to TabControl.PageCount-1 do
    Editors[i].Check4Save;
  Hide;
  while TabControl.PageCount > 0 do
    Editors[0].Close;
  if Assigned(FOnChangeStatus) then FOnChangeStatus(Self);
  Action := caFree;
end;

procedure TRAFDEditWindow.FormResize(Sender: TObject);
begin
  TabControl.Top := 0;
  TabControl.Left := 0;
  TabControl.Width := ClientWidth;
  TabControl.Height := ClientHeight - StatusBar.Height;
end;

procedure TRAFDEditWindow.EditorLocalMenuPopup(Sender: TObject);
begin
  if ActiveEditor <> nil then
    ActiveEditor.pmEditorPopup;
end;

procedure TRAFDEditWindow.miTogleBreakPointClick(Sender: TObject);
begin
  if ActiveEditor <> nil then
    ActiveEditor.TogleBreakPoint;
end;

procedure TRAFDEditWindow.DeleteAllErrorPoint;
var
  i : integer;
begin
  for i := 0 to EditorCount-1 do
    Editors[i].ShowErrorPoint(-1);
end;

procedure TRAFDEditWindow.ShowBreakPoint(index : integer);
begin
//  with Main.InterObj.IDebugObject.BreakPoints[index] do
//    if OpenFile(UnitName, false) then
//      ActiveTab.FileEditor.ShowBreakPoint(PosBeg, PosEnd);
end;

procedure TRAFDEditWindow.ecReadOnlyItemClick(Sender: TObject);
begin
  if ActiveEditor <> nil then begin
    ecReadOnlyItem.Checked := not ecReadOnlyItem.Checked;
    ActiveEditor.ReadOnly := ecReadOnlyItem.Checked;
  end;
end;

procedure TRAFDEditWindow.miEvaluateModifyClick(Sender: TObject);
begin
{  Console.memMess.SelStart := Length(Console.memMess.Text);
  Console.Visible := true;
  Console.memMess.SetFocus; }
end;

procedure TRAFDEditWindow.WMGetMinMaxInfo(var M : TWMGetMinMaxInfo);
begin
  inherited;
  if Visible then begin
    M.MinMaxInfo^.ptMinTrackSize.Y := 200;
    M.MinMaxInfo^.ptMinTrackSize.X := 200;
  end;
end;

procedure TRAFDEditWindow.FormActivate(Sender: TObject);
begin
  if Assigned(FOnActivate) then FOnActivate(Self);
end;


{************************ TFileEditor ***********************}

constructor TFileEditor.CreateF(AOwner : TComponent; ATab: TTabSheet;
  AFileName : TFileName; Source : string);
begin
  ODS('TFileEditor.Create');
  inherited Create(AOwner);
  FExecBegY := -1;
  FStackBegY := -1;
  FErrY := -1;
  FForm := AOwner as TRAFDEditWindow;
	Color := clWhite;
  Tab := ATab;
  Parser := TIParser.Create;
  Align := alClient;
  Parent := Tab;
  BoundsRect := Parent.ClientRect;
	Lines.Text := Source;
 	GutterWidth := 16;
 	Font := FForm.lblFont.Font;
	ScrollBars := ssBoth;
	TabStop := False;
  LongTokens := True;
  FFileName := AFileName;
  UnitName := ExtractFileName(FileName);
  if Cmp(ExtractFileExt(UnitName), ISExt) then
    UnitName := ChangeFileExt(UnitName, '');
  Tab.Caption := UnitName;
  UpdateSettings;
end;

destructor TFileEditor.Destroy;
begin
  ODS('TFileEditor.Destroy');
  ActiveFileEditor := nil;
  Parser.Free;
  if Assigned(FModuleInterface) then
    FModuleInterface.Release;
  inherited Destroy;
end;    { Destroy }

procedure TFileEditor.UpdateSettings;
begin
  Font.Name          := Environment.FontName          ;
  Font.Size          := Environment.FontSize          ;
  Font.Color         := Environment.FontColor         ;
  Font.Charset       := Environment.FontCharset       ;
  DoubleClickLine    := Environment.DoubleClickLine   ;
  KeepTrailingBlanks := Environment.KeepTrailingBlanks;
  AutoIndent         := Environment.AutoIndent        ;
  SmartTab           := Environment.SmartTab          ;
  BackspaceUnindents := Environment.BackspaceUnindents;
  CursorBeyondEOF    := Environment.CursorBeyondEOF   ;
  ExtensionChanged;
end;    { UpdateSettings }

function TFileEditor.Modified2: Boolean;
begin
  Result := Modified or ((Designer <> nil) and
    (Designer as TRAFormDesigner).Changed);
end;

function TFileEditor.Save: Boolean;
begin
  if IsNewFile then begin Result := SaveAs; Exit; end;
  if IsStrings then begin SavePropValue; Result := True; Exit; end;
  Result := False;
  if Assigned(ModuleInterface) then
    ModuleInterface.Notify(ncBeforeSave);
  if Assigned(FForm.FOnSaveFile) then
    FForm.FOnSaveFile(Self, FFileName, Lines.Text, Result);
  if Result then
  begin
    Modified := false;
    if Designer <> nil then
      with (Designer as TRAFormDesigner) do
        if Changed then Save;
    IsNewFile := False;
    FForm.UpdateStatus;
    if Assigned(ModuleInterface) then
      ModuleInterface.Notify(ncAfterSave);
  end;
end;

function TFileEditor.SaveAs: Boolean;
begin
	Result := False;
  if Assigned(ModuleInterface) then
    ModuleInterface.Notify(ncBeforeSave);
	if Assigned(FForm.FOnSaveFileAs) then
		FForm.FOnSaveFileAs(Self, FFileName, Lines.Text, Result);
	if Result then
	begin
    ExtensionChanged;
		Modified := false;
		UnitName := ExtractFileName(FileName);
		if Cmp(ExtractFileExt(UnitName), ISExt) then
			UnitName := ChangeFileExt(UnitName, '');
		Tab.Caption := UnitName;
		if Designer <> nil then
			(Designer as TRAFormDesigner).SaveToFile(ChangeFileExt(FileName, '.dfm'));
		FForm.TabControlChange(nil);
		IsNewFile := False;
    IsStrings := False;
    FormFileEditor := nil;
		FForm.UpdateStatus;
    if Assigned(ModuleInterface) then
      ModuleInterface.Notify(ncAfterSave);
	end;
end;

procedure TFileEditor.Check4Save;
var
  i: integer;
begin
  //Проверить изменен ли файл
  if Assigned(FForm.FOnFileCloseQuery) then
    FForm.FOnFileCloseQuery(Self);
 { check Strings editors, assotiated with this form file }
  for i := 0 to Form.EditorCount - 1 do
    if (Form.Editors[i] <> Self) and
       (Form.Editors[i].FormFileEditor = Self) then
      Form.Editors[i].Check4Save;

  FForm.TabControlChange(nil);
end;

procedure TFileEditor.Close;
var
  i: integer;
  F : TRAFDEditWindow;
begin
  if Assigned(ModuleInterface) and not IsProjectFile then
  begin
    ModuleInterface.Notify(ncEditorSelected);
    ModuleInterface.Notify(ncModuleDeleted);
  end;
 { close Strings editors, assotiated with this form file }
  i := 0;
  while i <= Form.EditorCount - 1 do
    if (Form.Editors[i] <> Self) and
       (Form.Editors[i].FormFileEditor = Self) then
      Form.Editors[i].Close
    else
      inc(i);

 // Modified := False;
  FForm.TabControl.ActivePage := FForm.TabControl.FindNextPage(Tab, false, true);
  if Assigned(FDesigner) then
    (FDesigner as TRAFormDesigner).FileEditorClosed;
  if FForm.TabControl.PageCount <= 1 then
   { prevent displaying empty editor form, later it will be freed }
    FForm.Hide;
  Parent := nil;
  Tab.Free;
  F := FForm;
  Free;
  F.TabControlChange(nil);
end;

procedure TFileEditor.Changed;
begin
  inherited Changed;
  if Assigned(FForm.FOnChangeStatus) then FForm.FOnChangeStatus(FForm);
  if Assigned(ModuleInterface) then
    ModuleInterface.Notify(ncEditorModified);
end;

procedure TFileEditor.StatusChanged;
begin
  inherited StatusChanged;
  FForm.UpdateStatus;
end;

procedure TFileEditor.ExtensionChanged;
var
  Ext: string;
begin
  if Environment.SytaxHighlighting then
  begin
    Ext := ExtractFileExt(FileName);
    dfm := False;
    if Cmp(Ext, '.pas') or Cmp(Ext, '.dpr') or Cmp(Ext, '.inc') or
       Cmp(Ext, '.int') or Cmp(Ext, '.dpk') then
      HighLighter := hlPascal
    else if Cmp(Ext, '.sql') then
      HighLighter := hlSQL
    else if Cmp(Ext, '.cpp') or Cmp(Ext, '.hpp') or
       Cmp(Ext, '.c') or Cmp(Ext, '.h') then
      HighLighter := hlCBuilder
    else if Cmp(Ext, '.dfm') then
    begin
      HighLighter := hlPascal;
      dfm := True;
    end
    else
      HighLighter := hlNone;
  end
  else
    HighLighter := hlNone;
end;    { ExtensionChanged }

function TFileEditor.GetReservedWord(const Token: string;
  var Reserved: Boolean): Boolean;
const
  DfmReservedWords = ' object end ';
begin
  ODS('GetReservedWord');
  if dfm then
    Reserved := Pos(' ' + Token + ' ', DfmReservedWords) > 0;
  Result := Reserved;
end;

function TFileEditor.UserReservedWords: boolean;
begin
  Result := dfm;
end;

procedure TFileEditor.SetParser(const S: string);
begin
  Parser.pcProgram := PChar(S);
  Parser.PCPos := Parser.pcProgram;
end;    {  }

procedure TFileEditor.SetModuleInterface(AModuleInterface: TIRAModuleInterface);
begin
  FModuleInterface := AModuleInterface;
  if Assigned(FModuleInterface) then
    FModuleInterface.AddRef;
end;

procedure TFileEditor.ShowPoint(PosBeg, PosEnd : integer; var BegX, BegY, EndX, EndY : integer);
var
  OldBegY, OldEndY ,iR : integer;
begin
  FErrY := -1;
  OldBegY := BegY; OldEndY := EndY;
  CaretFromPos(PosBeg, BegX, BegY);
  CaretFromPos(PosEnd+1, EndX, EndY);
  if (BegY < 0) and (OldBegY < 0) then exit;
  if (BegY > -1) and (BegY < TopRow) or (BegY > LastVisibleRow)
  then SetLeftTop(LeftCol, BegY - VisibleRowCount div 2);
  {Нужно ещё в бочок сдвигать...}
  {оптимизировано}
  for iR := OldBegY to OldEndY do PaintLine(iR, -1, -1);
  if BegY < OldBegY then OldBegY := BegY else OldBegY := OldEndY+1;
  if EndY > OldEndY then OldEndY := EndY else OldEndY := OldBegY-1;
  for iR := OldBegY to OldEndY do PaintLine(iR, -1, -1);
  {подрисовать на Gutter'е}
  Gutter.Paint;
end;

procedure TFileEditor.ShowExecutionPoint(PosBeg, PosEnd : integer);
begin
  ShowPoint(PosBeg, PosEnd, FExecBegX, FExecBegY, FExecEndX, FExecEndY);
end;

procedure TFileEditor.ShowCallStackPoint(PosBeg, PosEnd : integer);
begin
  ShowPoint(PosBeg, PosEnd, FStackBegX, FStackBegY, FStackEndX, FStackEndY);
end;

procedure TFileEditor.ShowBreakPoint(PosBeg, PosEnd : integer);
var
  BegX, BegY, v3, v4 : integer;
begin
  ShowPoint(PosBeg, PosEnd, BegX, BegY, v3, v4);
  CaretFromPos(PosBeg, BegX, BegY);
  SetCaret(BegX, BegY);
  SetFocus;
end;

procedure TFileEditor.ShowErrorPoint(ErrPos : integer);
var
  X, Y : integer;
begin
  CaretFromPos(ErrPos, X, Y);
  FErrY := Y;
  if (Y > -1) and (Y < TopRow) or (Y > LastVisibleRow)
  then SetLeftTop(LeftCol, Y - VisibleRowCount div 2);
  {Нужно ещё в бочок сдвигать...}
  if (Y > -1) then SetCaret(X, Y);
  {подрисовать на Gutter'е}
  Gutter.Paint;
end;

procedure TFileEditor.ChangeAttr(Line, ColBeg, ColEnd : integer);

  procedure Change(BegX, BegY, EndX, EndY : integer; clFC, clBC : TColor);

    procedure DoChange(const iBeg, iEnd : integer);
    var i : integer;
    begin
      for i := iBeg to iEnd do begin
        if clFC <> clDontChange then LineAttrs[i+1].FC := clFC;
        if clBC <> clDontChange then LineAttrs[i+1].BC := clBC;
      end;
    end;

  begin
    if (Line = BegY) and (Line = EndY) then DoChange(BegX, EndX-1)
    else begin
      if Line = BegY then DoChange(BegX, BegX + VisibleColCount);
      if (Line > BegY) and (Line < EndY) then DoChange(ColBeg, ColEnd);
      if Line = EndY then DoChange(ColBeg, EndX-1);
    end;
  end;
//var
//  i, BegX, BegY, EndX, EndY : integer;
begin
 {Show BreakPoints}
//  with Main.InterObj.IDebugObject do
//    for i := 0 to BreakPoints.Count-1 do with BreakPoints[i] do begin
//      if Cmp(PChar((Owner as TTab).UnitName), PChar(UnitName))
//      then begin
//        CaretFromPos(PosBeg, BegX, BegY);
//        CaretFromPos(PosEnd, EndX, EndY);
//        Change(BegX, BegY, EndX, EndY, FclBreakFC, FclBreakBC);
//      end;
//    end;
 {ShowExecutionPoint}
//  Change(FExecBegX, FExecBegY, FExecEndX, FExecEndY, FclExecFC, FclExecBC);
 {ShowCallStackPoint}
//  Change(FStackBegX, FStackBegY, FStackEndX, FStackEndY, FclStackFC, FclStackBC);
end;

procedure TFileEditor.GutterPaint(Canvas : TCanvas);
  procedure Draw(Y, ImageIndex : integer);
  var
    Ro : integer;
    R : TRect;
  begin
    if Y <> -1 then begin
      Ro := Y - TopRow;
      R := CalcCellRect(0, Ro);
      FForm.Images.Draw(Canvas, GutterWidth -GutterRightMargin -
        FForm.Images.Width{R.Left}, R.Top +
        (CellRect.Height - FForm.Images.Height) div 2 +1, ImageIndex);
    end;
  end;
//var
//  i, v, BegY : integer;
begin
  {показать значок точки останова...}
//  with Main.InterObj.IDebugObject do
//    for i := 0 to BreakPoints.Count-1 do with BreakPoints[i] do begin
//      if Cmp(PChar((Owner as TTab).UnitName), PChar(UnitName))
//      then begin
//        CaretFromPos(PosBeg, v, BegY);
//        if (BegY <> FExecBegY) and (BegY <> FStackBegY) then
//          Draw(BegY, imBreak);
//      end;
//    end;
  if FErrY <> -1 then Draw(FErrY, imError);
  if FStackBegY <> -1 then Draw(FStackBegY, imStack);
  if FExecBegY <> -1 then Draw(FExecBegY, imExecute);
end;

procedure TFileEditor.MouseMove(Shift: TShiftState; X, Y: Integer);
//var
//  P : integer;
//  W, W1 : string;
//  R : TRect;
begin
  inherited MouseMove(Shift, X, Y);
//  XX := X; YY := Y;
//  {$IFDEF DEBUG}
//  Tracer.Writeln(IntToStr(X)+', '+IntToStr(Y));
//  {$ENDIF}
//  P := PosFromMouse(X, Y);
//  if P = -1 then exit;
//  W := GetWordOnPos(Lines.Text, P);
//  if Main.InterObj.IDebugObject.EvaluateModify(W, W1, dfHint) then begin
//    R := ClientRect;
//    OffsetRect(R, ClientOrigin.X, ClientOrigin.Y);
//    (Owner as TTab).FForm.RAHint1.ActivateHint(R, W+' = '+W1);
//  end;
end;

procedure TRAFDEditWindow.WMSize(var Message: TWMSize);
begin
  inherited;
 { if ActiveTab <> nil then
    if Message.SizeType = SIZE_MAXIMIZED then
      ActiveTab.FileEditor.Paint
    else if Message.SizeType = SIZE_MINIMIZED then
      ActiveTab.FileEditor.NeedRepaint := true; }
end;

function TFileEditor.BPIndex(PBeg, PEnd : integer) : integer;
//var
//  i : integer;
begin
  Result := -1;
//  with Main.InterObj.IDebugObject do
//    for i := 0 to BreakPoints.Count-1 do with BreakPoints[i] do begin
//      if Cmp(PChar((Owner as TTab).UnitName), PChar(UnitName)) and
//       ((PosBeg <= PBeg) and (PEnd <= PosEnd))
//      then begin Result := i; exit end;
//    end;
end;

procedure TFileEditor.pmEditorPopup;
var
  P : integer;
begin
  P := PosFromCaret(CaretX, CaretY);
  FForm.miTogleBreakPoint.Enabled := P <> -1;
  if (P = -1) or (BPIndex(P, P) = -1) then
    FForm.miTogleBreakPoint.Caption := 'Add &breakpoint' else
    FForm.miTogleBreakPoint.Caption := 'Remove &breakpoint';
  FForm.ecReadOnlyItem.Checked := ReadOnly;
end;

procedure TFileEditor.TogleBreakPoint;
//var
//  P, PBeg, PEnd, Ind, iR : integer;
//  BegY, EndY : integer;
//  BP : TBreakPoint;
begin
//  P := PosFromCaret(CaretX, CaretY);
//  Ind := BPIndex(P, P);
//  if Ind = -1 then begin
//    ProgGetBlockByPos(iString(Lines.Text), P, PBeg, PEnd);
//    if (PBeg = -1) or (PEnd = -1) then exit;
//    BP := TBreakPoint.Create;
//    BP.UnitName := (Owner as TTab).UnitName;
//    BP.PosBeg := PBeg;
//    BP.PosEnd := PEnd;
//    Main.InterObj.IDebugObject.BreakPoints.Add(BP);
//  end else
//    with Main.InterObj.IDebugObject do begin
//      PBeg := BreakPoints[Ind].PosBeg;
//      PEnd := BreakPoints[Ind].PosEnd;
//      BreakPoints.Delete(Ind);
//    end;
//  CaretFromPos(PBeg, iR, BegY);
//  CaretFromPos(PEnd, iR, EndY);
//  PaintCaret(false);
//  for iR := BegY to EndY do PaintLine(iR, -1, -1);
//  PaintCaret(true);
//  {подрисовать на Gutter'е}
//  Gutter.Paint;
//  BreakPoints.UpdateBreakPoints;
end;

procedure TFileEditor.TextModified(Pos : integer; Action : TModifiedAction; Text : string);
//var
//  i : integer;
//  Modi : boolean;
begin
  inherited TextModified(Pos, Action, Text);
//  Modi := false;
  {сдвигаем все точки останова}
//  with Main.InterObj.IDebugObject do
//    for i := 0 to BreakPoints.Count-1 do with BreakPoints[i] do
//      if Cmp(PChar((Owner as TTab).UnitName), PChar(UnitName)) then
//        if Action = maInsert then begin
//          if PosBeg >= Pos then begin
//            inc(PosBeg, Length(Text));
//            inc(PosEnd, Length(Text));
//            Modi := true;
//          end else
//          if (PosBeg < Pos) and (Pos <= PosEnd) then begin
//            inc(PosEnd, Length(Text));
//            Modi := true;
//          end
//        end else {Action = maDelete}
//          if PosBeg >= Pos then begin
//            dec(PosBeg, Length(Text));
//            dec(PosEnd, Length(Text));
//            Modi := true;
//          end else
//          if (PosBeg < Pos) and (Pos <= PosEnd) then begin
//            dec(PosEnd, Length(Text));
//            Modi := true;
//          end;
// {!!!!}
//  if Modi then begin
//    BreakPoints.UpdateBreakPoints;
//   // NeedRepaint := true;
//    Invalidate;//Repaint;
//  end;
end;



{----------------------------------------------------------}
{----------------- Source manipulation --------------------}
{----------------------------------------------------------}
{  not very smart:                                         }
{    comments and non-standard indent styles not responsed }
{  to do this we must use TIParser                         }
{    may be in next release ...                            }
{----------------------------------------------------------}

procedure TFileEditor.InitParser;
begin
  ParserText := Lines.Text;
  SetParser(ParserText);
end;    { InitParser }

procedure TFileEditor.ReplaceToken(const NewToken: string);
var
  BegPos: Integer;
  EndPos: Integer;
begin
  BegPos := Parser.PosBeg[0];
  EndPos := Parser.PosEnd[0];
  ParserText := Copy(ParserText, 1, BegPos) + NewToken +
    Copy(ParserText, EndPos + 1, Length(ParserText));
  Parser.PCProgram := PChar(ParserText);
  Parser.PCPos := Parser.PCProgram + BegPos + Length(NewToken);
end;    { ReplaceToken }

procedure TFileEditor.FindFormDecl(var Line: Integer);
var
  FormDeclaration: string;
begin
  FormDeclaration := 'T' + Designer.Form.Name + ' = class(' +
    Designer.Form.ClassParent.ClassName + ')';
  Line := 0;
  while Line < Lines.Count do
    if Cmp(Trim(Lines[Line]), FormDeclaration) then
      Exit else
      inc(Line);
  Error('Form declaration not found');
end;    { FormDeclPos }

procedure TFileEditor.FindMethodSection(var Line: Integer);
var
  Token: string;
begin
  while Line < Lines.Count do
  begin
    SetParser(Lines[Line]);
		Token := Parser.Token;
    if Cmp(Token, 'procedure') or Cmp(Token, 'function') or
       Cmp(Token, 'end') or Cmp(Token, 'private') or Cmp(Token, 'protected') or
       Cmp(Token, 'public') or Cmp(Token, 'published') then
      Break else
      inc(Line);
    if Cmp(Token, 'implementation') then
      Error('Error in form declaration');
  end;
end;    { FormDeclPos }

procedure TFileEditor.FindUnitEnd(var Line: Integer);
begin
  while Line < Lines.Count do
    if ANSIStrLIComp(PChar(Lines[Line]), 'end.', 4) = 0 then
      Exit else
      inc(Line);
  Error('Unit end not found');
end;    { FindUnitEnd }

procedure TFileEditor.FindToken(const Token: string);
begin
  while not Cmp(Parser.Token, Token) do ;
end;    { FindToken }

procedure TFileEditor.RenameForm(const CurName, NewName: string);
var
  Token: string;
  CurNameClass, NewNameClass: string;
begin
  InitParser;
  CurNameClass := 'T' + CurName;
  NewNameClass := 'T' + NewName;
  Token := Parser.Token;
  while Token <> '' do
  begin
    if Cmp(Token, CurNameClass) then
    begin
      ReplaceToken(NewNameClass);
    end
    else if Cmp(Token, CurName) then
    begin
      ReplaceToken(NewName);
    end;
    Token := Parser.Token;
  end;
  SetLockText(ParserText);
  TextAllChanged;
  CantUndo; { !!! }
end;    { RenameForm }

procedure TFileEditor.RenameUnit(const NewName: string);
var
  Token: string;
begin
  InitParser;
  Token := Parser.Token;
  while Token <> '' do
  begin
    if Cmp(Token, 'unit') then
    begin
      Parser.Token;
      ReplaceToken(NewName);
      SetLockText(ParserText);
      TextAllChanged;
      CantUndo; { !!! }
      Exit;
    end;
    Token := Parser.Token;
  end;    { while }
end;    { RenameUnit }

{ create component declaration in source }
procedure TFileEditor.CreateComponent(Component: TComponent; const NewName: string);
var
  Declaration: string;
  Line: Integer;
  CY, T1: Integer;
begin
  CY := CaretY;
  T1 := TopRow;
  Declaration := '    ' + NewName + ': ' + Component.ClassName + ';';
  FindFormDecl(Line);
  inc(Line);
  BeginUpdate;
  try
    Lines.Insert(Line, Declaration);
    if T1 > Line then
    begin
      SetLeftTop(LeftCol, T1 + 1);
      CaretY := CY + 1;
    end;
  finally { wrap up }
    EndUpdate;
  end;    { try/finally }
end;

{ delete component declaration from source }
procedure TFileEditor.DeleteComponent(Component: TComponent);
var
  Declaration: string;
  Line: Integer;
  CY, T1: Integer;
begin
  DeleteStrings(Component);
  CY := CaretY;
  T1 := TopRow;
  Declaration := Component.Name + ': ' + Component.ClassName + ';';
  FindFormDecl(Line);
  while Line < Lines.Count do
    if Cmp(Trim(Lines[Line]), Declaration) then
    begin
      BeginUpdate;
      try
        Lines.Delete(Line);
        if T1 > Line then
        begin
          SetLeftTop(LeftCol, T1 - 1);
          CaretY := CY - 1;
        end;
      finally { wrap up }
        EndUpdate;
      end;    { try/finally }
      Break;
    end else
      inc(Line);
end;

{ rename component declaration in source }
procedure TFileEditor.RenameComponent(Component: TComponent; const NewName: string);
var
  Declaration: string;
  NewDeclaration: string;
  Line: Integer;
begin
  Declaration := Component.Name + ': ' + Component.ClassName + ';';
  NewDeclaration := '    ' + NewName + ': ' + Component.ClassName + ';';
  FindFormDecl(Line);
  while Line < Lines.Count do
    if Cmp(Trim(Lines[Line]), Declaration) then
    begin
      Lines[Line] := NewDeclaration;
      Break;
    end else
      inc(Line);
end;

{ find method in source }
function TFileEditor.FindMethod(const Name: string): Integer;
var
  Declaration: string;
  Line: Integer;
  S: string;
begin
  Result := -1;
  Declaration := 'T' + Designer.Form.Name + '.' + Name;
  Line := 0;
  while Line < Lines.Count do
  begin
    S := Lines[Line];
    if ( (ANSIStrLIComp(PChar(S), PChar('procedure ' + Declaration),
         Length('procedure ' + Declaration)) = 0) and
         (Length(S) > Length('procedure ' + Declaration)) and
         not (S[Length('procedure ' + Declaration) + 1] in StIdSymbols) ) or
       ( (ANSIStrLIComp(PChar(S), PChar('function ' + Declaration),
         Length('procedure ' + Declaration)) = 0) and
         (Length(S) > Length('function ' + Declaration)) and
         not (S[Length('function ' + Declaration) + 1] in StIdSymbols) ) then
    begin
      Result := Line;
      Exit;
    end
    else
      inc(Line);
  end;
end;

{ find method declaration in form declaration }
function TFileEditor.FindMethodDecl(const Name: string): Integer;
var
  Line: Integer;
  Token: string;
begin
  Result := -1;
  FindFormDecl(Line);
  if Line = -1 then
    RAFDError(deFormDeclNotFound);
  while Line < Lines.Count do
  begin
    SetParser(Lines[Line]);
    Token := Parser.Token;
    if Cmp(Token, 'end') then Exit;
    if Cmp(Token, 'procedure') or Cmp(Token, 'function') then
    begin
      Token := Parser.Token;
      if Cmp(Token, Name) then
      begin
        Result := Line;
        Exit;
      end;
    end;
    inc(Line);
  end;
end;


{ show method in source }
procedure TFileEditor.ShowMethod(const Name: string);
var
  Line: Integer;
begin
  Activate;
  Line := FindMethod(Name);
  if Line > -1 then
  begin
    SetLeftTop(LeftCol, Line);
    while Line < Lines.Count do
    	if Cmp(TrimRight(Lines[Line]), 'begin') then
    		Break else
    		inc(Line);
    CaretY := Line + 1;
    SelLength := 0;
    SetFocus;
    Invalidate;
  end;
end;

function TFileEditor.MethodExists(const Name: string): Boolean;
begin
  Result := FindMethod(Name) > -1;
end;

{ rename method in source }
procedure TFileEditor.RenameMethod(const CurName, NewName: string);
var
  Impl, Decl: Integer;
  SImpl, SDecl: string;
  Token: string;
begin
  Activate;
  Impl := FindMethod(CurName);
  if Impl = -1 then
    RAFDErrorN(deCantRenameMethod, CurName);
	SImpl := Lines[Impl];
	SetParser(SImpl);
	Parser.Token; { skip "procedure" or "function" word }
	Parser.Token; { skip class name }
	Token := Parser.Token; { skip "." }
	if Token <> '.' then
		RAFDErrorN(deCantRenameMethod, CurName);
	Token := Parser.Token; { method name }
	SImpl := Copy(SImpl, 1, Parser.PosBeg[0]) + NewName +
		Copy(SImpl, Parser.PosEnd[0] + 1, Length(SImpl));

  Decl := FindMethodDecl(CurName);
  if Decl = -1 then
    RAFDErrorN(deCantRenameMethod, CurName);
	SDecl := Lines[Decl];
	SetParser(SDecl);
	Parser.Token; { skip "procedure" or "function" word }
	Token := Parser.Token; { method name }
  if not Cmp(Token, CurName) then
    RAFDErrorN(deCantRenameMethod, CurName);
	SDecl := Copy(SDecl, 1, Parser.PosBeg[0]) + NewName +
		Copy(SDecl, Parser.PosEnd[0] + 1, Length(SDecl));

  Lines[Impl] := SImpl;
  Lines[Decl] := SDecl;
end;

{ parameter list not checked }
procedure TFileEditor.GetMethods(TypeData: PTypeData; Proc: TGetStrProc);
var
  Declaration: string;
  Line: Integer;
  S: string;
  Token: string;
begin
  { !!!! DEBUG VERSION !!!! }
  Declaration := 'T' + Designer.Form.Name + '.';
  SetParser(Lines.Text);
  FindToken('implementation');
  Line := 0;
  while Line < Lines.Count do
  begin
    S := Lines[Line];
    if (ANSIStrLIComp(PChar(S), PChar('procedure ' + Declaration),
         Length('procedure ' + Declaration)) = 0) or
       (ANSIStrLIComp(PChar(S), PChar('function ' + Declaration),
         Length('procedure ' + Declaration)) = 0) then
    begin
      Parser.pcPos := Parser.pcProgram +
        PosFromCaret(Length('procedure ' + Declaration), Line);
      Token := Parser.Token;
      if IsIdentifer(Token) then
        Proc(Token);
    end;
    inc(Line);
  end;
end;

{ CreateMethod - create method in source }
function TFileEditor.CreateMethod(const Name: string; TypeData: PTypeData)
  : TMethod;
var
  Declaration: string;
  Params: string;

  procedure MakeParams;
  var
    P: PChar;
    i: integer;
    ParamName, ParamType: string;
  begin
    case TypeData^.MethodKind of
      mkProcedure:
        Declaration := 'procedure ';
      mkFunction:
        Declaration := 'function ';
    end;
    Params := '';
    P := TypeData^.ParamList;
    for i := 1 to TypeData^.ParamCount do    { Iterate }
    begin
      inc(P); // skip #8 char
     // ParamName := ShortString(P^);
      SetString(ParamName, P + 1, Integer(P[0]));
      inc(P, Length(ParamName) + 1);
      SetString(ParamType, P + 1, Integer(P[0]));
      inc(P, Length(ParamType) + 1);
      Params := ConcatSep(Params, ParamName + ': ' + ParamType, '; ');
    end;    { for }
    if Params <> '' then
      Params := '(' + Params + ')';
  end;    { MakeParams }

var
  MLine, ELine: Integer;
  ImplDeclaration: string;
begin
  Activate;
  { !!!! DEBUG VERSION !!!! }
  if Trim(Name) = '' then Exit;

  FindFormDecl(MLine);
  FindMethodSection(MLine);
  ELine := MLine;
  FindUnitEnd(ELine);
  MakeParams;
  Declaration := '    procedure ' + Name + Params + ';';
  ImplDeclaration := 'procedure T' + Designer.Form.Name + '.' + Name +
    Params + ';';
  BeginUpdate;
  try
    Lines.Insert(MLine, Declaration);
    inc(ELine);
    Lines.Insert(ELine, '');
    Lines.Insert(ELine, 'end;');
    Lines.Insert(ELine, '');
    Lines.Insert(ELine, 'begin');
    Lines.Insert(ELine, ImplDeclaration);
		SetLeftTop(LeftCol, ELine);
		CaretY := ELine;
    CaretX := 0;
  finally { wrap up }
    EndUpdate;
  end;    { try/finally }
end;

{ strings edit support }

procedure TFileEditor.EditStrings(AInstance: TPersistent; AStrings: TSTrings;
  APropInfo: PPropInfo; ACurrentValue: TStrings);
var
  Editor: TFileEditor;
begin
  Editor := Form.MakeTab(Designer.Form.Name + '.' +
    Designer.GetObjectName(AInstance) + '.' + APropInfo^.Name, ACurrentValue.Text);
  Editor.IsStrings := True;
  Editor.StringsComponent := AInstance;
  Editor.Strings := AStrings;
  Editor.FormFileEditor := Self;
  PostMessage(Editor.Handle, WM_RESETFOCUS, 0, 0);
end;    { EditStrings }

function TFileEditor.ActivateStrings(AInstance: TPersistent; AStrings: TSTrings;
  APropInfo: PPropInfo): Boolean;
var
  i: integer;
begin
 { check Strings editors, assotiated with this form file }
  for i := 0 to Form.EditorCount - 1 do
    if (Form.Editors[i] <> Self) and
       (Form.Editors[i].FormFileEditor = Self) and
       (Form.Editors[i].Strings = AStrings) then
    begin
      PostMessage(Form.Editors[i].Handle, WM_RESETFOCUS, 0, 0);
      Result := True;
      Exit;
    end;
  Result := False;
end;    { EditStrings }

procedure TFileEditor.SavePropValue;
begin
  Strings.Assign(Lines);
  Modified := False;
end;    { SavePropValue }

procedure TFileEditor.WMResetFocus(var Message: TMessage);
begin
  Activate;
end;    { WMResetFocus }

procedure TFileEditor.Activate;
begin
//  ODS('TFileEditor.Activate');
  Form.TabControl.ActivePage := Tab;
  Form.UpdateStatus;
  if Form.WindowState = wsMinimized then
    Form.WindowState := wsNormal;
  SetFocus;
end;

procedure TFileEditor.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if Assigned(ModuleInterface) then
    ModuleInterface.Notify(ncEditorSelected);
end;

procedure TFileEditor.DeleteStrings(AComponent: TComponent);
var
  i: integer;
begin
 { check Strings editors, assotiated with this form file }
	i := 0;
	while i <= Form.EditorCount - 1 do
		if (Form.Editors[i] <> Self) and
			 (Form.Editors[i].FormFileEditor = Self) and
			 (Form.Editors[i].StringsComponent = AComponent) then
		begin
			Form.Editors[i].Modified := False;
			Form.Editors[i].Close;
		end
		else
			inc(i);
end;



procedure TRAFDEditWindow.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//
end;

procedure TRAFDEditWindow.FormKeyPress(Sender: TObject; var Key: Char);
begin
//
end;

end.
