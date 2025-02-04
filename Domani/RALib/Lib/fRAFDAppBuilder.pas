{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       description : form designer for external dfm-pas-files

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit fRAFDAppBuilder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, ExtCtrls, RARegAuto, Buttons,
  DsgnIntf, ToolIntf, ExptIntf, RAFDDesigner, RARTTI, fRAFDEditor,
  RAFDCompat;

type

  TRAAppBuilder = class;

  TRAFDAppBuilder = class(TForm)
    MainMenu1: TMainMenu;
    FileMenu: TMenuItem;
    FileExitItem: TMenuItem;
    N2: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileNewItem: TMenuItem;
    Bevel1: TBevel;
    RegAuto1: TRegAuto;
    OpenDialog1: TOpenDialog;
    FileCloseItem: TMenuItem;
    pnlToolbar: TPanel;
    FileSaveAllItem: TMenuItem;
    SaveDialog1: TSaveDialog;
    FileCloseAllItem: TMenuItem;
    ViewsMenu: TMenuItem;
    ViewAlignItem: TMenuItem;
    ViewObjInspItem: TMenuItem;
    EditMenu: TMenuItem;
    EditDeleteItem: TMenuItem;
    N1: TMenuItem;
    ViewPaletteItem: TMenuItem;
    pnlButtons: TPanel;
    bSwapSourceForm: TSpeedButton;
    bSaveAll: TSpeedButton;
    bOpen: TSpeedButton;
    Splitter1: TSplitter;
    bRunForm: TSpeedButton;
    FileNewFormItem: TMenuItem;
    bRunReportPreview: TSpeedButton;
    raPref: TRegAuto;
    N3: TMenuItem;
    ViewSwapSourceFormItem: TMenuItem;
    ComponentMenu: TMenuItem;
    RunMenu: TMenuItem;
    RunFormItem: TMenuItem;
    RunReportPreviewItem: TMenuItem;
    ViewWindowListItem: TMenuItem;
    SearchMenu: TMenuItem;
    ToolsMenu: TMenuItem;
    ProjectMenu: TMenuItem;
    ProjectAddItem: TMenuItem;
    ViewPrjSourceItem: TMenuItem;
    ToolsOptionsItem: TMenuItem;
    HelpMenu: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
    ViewPrjMngrItem: TMenuItem;
    raProject: TRegAuto;
    procedure FileOpenItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FileCloseItemClick(Sender: TObject);
    procedure FileSaveItemClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FileSaveAllItemClick(Sender: TObject);
    procedure FileSaveAsItemClick(Sender: TObject);
    procedure FileCloseAllItemClick(Sender: TObject);
    procedure FileExitItemClick(Sender: TObject);
    procedure ViewAlignItemClick(Sender: TObject);
    procedure ViewObjInspItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bSwapSourceFormClick(Sender: TObject);
    procedure EditDeleteItemClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ViewPaletteItemClick(Sender: TObject);
    procedure ViewsMenuClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure bRunFormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FileNewFormItemClick(Sender: TObject);
    procedure bRunReportPreviewClick(Sender: TObject);
    procedure ViewPrjSourceItemClick(Sender: TObject);
    procedure FileNewItemClick(Sender: TObject);
    procedure EditCopyItemClick(Sender: TObject);
    procedure EditPasteItemClick(Sender: TObject);
    procedure RegAuto1AfterSave(Sender: TObject);
    procedure RegAuto1AfterLoad(Sender: TObject);
    procedure ViewPrjMngrItemClick(Sender: TObject);
    procedure raProjectBeforeSave(Sender: TObject);
    procedure raProjectBeforeLoad(Sender: TObject);
  private
    { Private declarations }
    FDs: TList;
    Editors: TList;
    Palette: TControl;
    Selection: TComponentList;
    RAAppBuilder: TRAAppBuilder;
    Capt, Capt1: string;
    procedure FileCloseQuery(Sender: TObject);
    procedure EditorActivate(Sender: TObject);
    procedure FDActivate(Sender: TObject);
    procedure FDDestroy(Sender: TObject);
    procedure FDChange(Sender: TObject);
    procedure FDSelectionChange(Sender: TObject);
    procedure EditorLoadFile(Sender: TRAFDEditWindow; var FileName: TFileName;
      var FullFileName: TFileName; var Source: string; var Done: Boolean);
    procedure EditorSaveFile(Sender: TFileEditor; var FileName: TFileName;
      Text: string; var Done: Boolean);
    procedure EditorSaveFileAs(Sender: TFileEditor; var FileName: TFileName;
      Text: string; var Done: Boolean);
    procedure WMGetMinMaxInfo(var M : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure LoadLocale;
    procedure LoadPackages;
    procedure LoadExperts;
    function GetForm: TForm;
    function GetSelections(Selection: TComponentList): TComponentList;
    procedure ClearSelection;
    procedure UpdateExpertMenu;
    procedure ExpertClick(Sender: TObject);
    procedure ProjectOpened(Sender: TObject);
    procedure ProjectClosed(Sender: TObject);
  public
    { Public declarations }
    procedure Execute;
    procedure OpenFile(const FileName: TFileName);
    procedure CheckActiveEditWindow;
    procedure UpdateState;
    procedure NewDesigner(const dfmFileName: TFileName; Editor: TFileEditor);
  end;

  TAppBuilder = class(TRAFDAppBuilder);

  TRAAppBuilder = class(TComponent)
  private
    FOnPackagesLoaded: TNotifyEvent;
    FRunning: Boolean;
    FIniFile: string;
    procedure Done;
    procedure SetBaseRegistryKey(Value: string);
    function GetBaseRegistryKey: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateAppBuilderWindow;
    procedure Execute;
    property OnPackagesLoaded: TNotifyEvent read FOnPackagesLoaded write FOnPackagesLoaded;
    property BaseRegistryKey: string read GetBaseRegistryKey write SetBaseRegistryKey;
    property IniFile: string read FIniFile write FIniFile;
  end;

var
  AppBuilder: TAppBuilder;

  LastActiveWindow: TForm;

//  Debug: Boolean = True;
  RAFDDebug: Boolean = False;

implementation

uses RAUtils, iMTracer, RAFD, RAFDIDE,
  fRAFDAlignPalette, fRAFDPropertyInspector, fRAFDPalette,
  fRAFDProjectManager, fRAFDNewItem;


{$R *.DFM}


procedure TRAFDAppBuilder.FormCreate(Sender: TObject);
begin
  Name := 'AppBuilder';
  FDs := TList.Create;
  Editors := TList.Create;
  Palette := fRAFDPalette.GetControl;
  Palette.Parent := pnlToolbar;
  Palette.Visible := False;
  ViewPaletteItemClick(nil);
  RegAuto1.RegPath := BaseRegKey;
  fRAFDProjectManager.Create;
  ProjectManager.OnProjectOpen := ProjectOpened;
  ProjectManager.OnProjectClose := ProjectClosed;
  Capt := Caption;
  Capt1 := Capt;
end;

procedure TRAFDAppBuilder.Execute;
var
  SS: TStringList;
begin
  DefaultIcon := Icon;
  Environment.Restore(RegAuto1);
  raPref.IniFile := ChangeFileExt(Application.ExeName, '.ini');
 // Application.Icon := Icon;
  SS := TStringList.Create;
  try
    raPref.ReadWholeSection('Experts', Ss);
    fRAFDPropertyInspector.SetTranslates(SS);
  finally { wrap up }
    SS.Free;
  end;    { try/finally }
  LoadLocale;
  LoadExperts;
  LoadPackages;
  UpdateExpertMenu;
  UpdateState;
end;

procedure TRAFDAppBuilder.FormDestroy(Sender: TObject);
var
  i: integer;
  FD: TRAFormDesigner;
begin
 // IDEUnloadPackages;

  fRAFDPalette.Close;
  fRAFDProjectManager.Close;
  Palette := nil;
  for i := 0 to FDs.Count - 1 do    { Iterate }
  begin
    FD := TRAFormDesigner(FDs[i]);
  	FD.OnActivate := nil;
  	FD.OnFormActivate := nil;
  	FD.OnDestroy := nil;
  	FD.OnChange := nil;
  	FD.OnSelectionChange := nil;
   // FD.Free;
  end;    { for }
  FDs.Free;
  Editors.Free;
  Selection.Free;
  AppBuilder := nil;
  if Assigned(RAAppBuilder) then RAAppBuilder.Done;
end;

procedure TRAFDAppBuilder.FileOpenItemClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    OpenFile(OpenDialog1.FileName);
end;

procedure TRAFDAppBuilder.CheckActiveEditWindow;
begin
	if ActiveEditWindow = nil then
	begin
		ActiveEditWindow := TEditWindow.Create(Application);
		ActiveEditWindow.OnLoadFile := EditorLoadFile;
		ActiveEditWindow.OnSaveFile := EditorSaveFile;
		ActiveEditWindow.OnSaveFileAs := EditorSaveFileAs;
		ActiveEditWindow.OnChangeStatus := FDChange;
		Editors.Add(ActiveEditWindow);
		ActiveEditWindow.OnFileCloseQuery := FileCloseQuery;
		ActiveEditWindow.OnActivate := EditorActivate;
		ActiveEditWindow.OnDestroy := FDDestroy;
	end;
end;    { CheckActiveEditWindow }

procedure TRAFDAppBuilder.OpenFile(const FileName: TFileName);
var
  dfmFileName: TFileName;
  Cancel: Boolean;
begin
  if Assigned(RAToolServices) then
  begin
    Cancel := False;
    RAToolServices.FileNotification(fnFileOpening, FileName, Cancel);
    if Cancel then Exit;
  end;

  if Cmp(ExtractFileExt(FileName), '.dpr') then
    ProjectManager.OpenProject(FileName)
  else
  begin
  	CheckActiveEditWindow;
  	if not ActiveEditWindow.OpenFile(FileName, False) then
  		Error('Can''t open file');
    Application.BringToFront;
    ActiveFileEditor.Activate;
  	if Cmp(ExtractFileExt(FileName), '.pas') then
  	begin
  		dfmFileName := ChangeFileExt(FileName, '.dfm');
  		if FileExists(dfmFileName) then
      begin
        try
          NewDesigner(dfmFileName, ActiveFileEditor);
        except
          on E: Exception do
          begin
            ActiveFileEditor.Designer := nil;
            E.Message := Format(ResStr(deResBase + deErrorCreatingForm,
              'Error creating form'#13'%s'), [E.Message]);
            raise;
          end;
        end;
      end;
      LastActiveWindow := Screen.ActiveForm as TForm;
  	end;
    if Assigned(RAToolServices) then
      RAToolServices.FileNotification(fnFileOpened, FileName, Cancel);
  end;
  UpdateState;
end;

procedure TRAFDAppBuilder.ProjectOpened(Sender: TObject);
begin
  ViewPrjMngrItem.Enabled := True;
  raProject.Load;
 { call Load to all other designer windows }
 //..
end;

procedure TRAFDAppBuilder.ProjectClosed(Sender: TObject);
begin
  ViewPrjMngrItem.Enabled := False;
  raProject.Save;
 { call save to all other designer windows }
 //..
end;

procedure TRAFDAppBuilder.FileCloseQuery(Sender: TObject);
var
  Cancel: Boolean;
begin
  if (Sender as TFileEditor).IsProjectFile then
  begin
    ProjectManager.SourceClosing;
    Exit;
  end;
  if (Sender as TFileEditor).Modified then
    case MessageDlg(Format(ResStr(deResBase + deFileChanged, ''),
       [ExtractFileName((Sender as TFileEditor).FileName)]),
       mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        if not (Sender as TFileEditor).Save then Abort;
      mrNo:
       { nothing } ; 
      mrCancel:
        Abort;
    end;    { case }
  if Assigned(RAToolServices) then
  begin
    Cancel := False;
   { RAToolServices.FileNotification(fnFileClosing,
      (Sender as TFileEditor).FileName, Cancel); }
    if Cancel then Abort;
  end;
end;

procedure TRAFDAppBuilder.FileNewFormItemClick(Sender: TObject);
var
  FileName: TFileName;
begin
  CheckActiveEditWindow;
  FileName := ActiveEditWindow.FileNew;
	NewDesigner('', ActiveFileEditor);
end;

procedure TRAFDAppBuilder.NewDesigner(const dfmFileName: TFileName;
  Editor: TFileEditor);
var
  FD: TRAFormDesigner;
begin
	FD := TRAFormDesigner.Create(dfmFileName, Editor);
	FD.OnActivate := FDActivate;
	FD.OnFormActivate := EditorActivate;
	FD.OnDestroy := FDDestroy;
	FD.OnChange := FDChange;
	FD.OnSelectionChange := FDSelectionChange;
	FDs.Add(FD);
	UpdateState;
	FD.Form.Show;
end;    { MakeDesigner }

procedure TRAFDAppBuilder.EditorLoadFile(Sender: TRAFDEditWindow;
  var FileName: TFileName; var FullFileName: TFileName;
  var Source: string; var Done: Boolean);
var
  FileStream: TFileStream;
  StringStream: TStringStream;
begin
  if FileName = '' then
  begin
   { gen new file name }
    FileName := 'Unit1.pas';
    FullFileName := FileName;
    Done := True;
    ResSaveToString(hInstance, 'pas', 'unit1', Source);
  end
  else if Cmp(ExtractFileExt(FileName), '.dfm') then
  begin
    FullFileName := AddPath(FileName, ExePath);
    FileStream := TFileStream.Create(FullFileName, fmOpenRead);
    StringStream := TStringStream.Create('');
    try
      ObjectResourceToText(FileStream, StringStream);
      Source := StringStream.DataString;
      Done := True;
    finally { wrap up }
      FileStream.Free;
      StringStream.Free;
    end;    { try/finally }
  end
  else
  begin
    FullFileName := AddPath(FileName, ExePath);
    if FileExists(FullFileName) then
    begin
      Source := LoadTextFile(FullFileName);
      Done := True;
    end;
  end;
  UpdateState;
end;

procedure TRAFDAppBuilder.EditorSaveFile(Sender: TFileEditor;
  var FileName: TFileName; Text: string; var Done: Boolean);
var
  FileStream: TFileStream;
  StringStream: TStringStream;
  FN: TFileName;
  BakFileName: TFileName;
begin
  BakFileName := ChangeFileExt(FileName, '.bak');
  DeleteFile(BakFileName);
  RenameFile(FileName, BakFileName);
  FN := GenTempFileName('');
  try
    if Cmp(ExtractFileExt(FileName), '.dfm') then
    begin
      FileStream := TFileStream.Create(FN, fmOpenWrite or fmCreate);
      StringStream := TStringStream.Create(Text);
      try
        ObjectTextToResource(StringStream, FileStream);
      finally { wrap up }
        FileStream.Free;
        StringStream.Free;
      end;    { try/finally }
    end
    else
      SaveTextFile(FN, Text);
		RenameFile(FN, FileName);
		DeleteFile(BakFileName);
    Done := True;
  except
    DeleteFile(FileName);
    DeleteFile(FN);
    RenameFile(BakFileName, FileName);
    raise;
  end;
  UpdateState;
end;

procedure TRAFDAppBuilder.EditorSaveFileAs(Sender: TFileEditor;
  var FileName: TFileName; Text: string; var Done: Boolean);
begin
  SaveDialog1.FileName := FileName;
  if SaveDialog1.Execute then
  begin
    FileName := SaveDialog1.FileName;
    if Cmp(ExtractFileExt(FileName), '.pas') then
      Sender.RenameUnit(ChangeFileExt(ExtractFileName(FileName), ''));
    SaveTextFile(FileName, Text);
    Done := True;
  end;
  OpenDialog1.FileName := SaveDialog1.FileName;
end;

procedure TRAFDAppBuilder.FileCloseItemClick(Sender: TObject);
begin
  if ActiveFileEditor <> nil then
  begin
    FileCloseQuery(ActiveFileEditor);
    ActiveFileEditor.Check4Save;
    ActiveFileEditor.Close;
  end;
end;

procedure TRAFDAppBuilder.FileCloseAllItemClick(Sender: TObject);
begin
  if Assigned(ActiveEditWindow) then
    ActiveEditWindow.Close;
  ProjectManager.CloseProject;
  UpdateState;
end;

procedure TRAFDAppBuilder.FileSaveItemClick(Sender: TObject);
begin
  if ActiveFileEditor <> nil then
  begin
    ActiveFileEditor.Save;
    UpdateState;
  end;
end;

procedure TRAFDAppBuilder.FileSaveAllItemClick(Sender: TObject);
var
  i, j: integer;
begin
  for i := 0 to Editors.Count - 1 do
    with TRAFDEditWindow(Editors[i]) do
      for j := 0 to EditorCount - 1 do
        if Editors[j].Modified2 then
          Editors[j].Save;
  UpdateState;
end;

procedure TRAFDAppBuilder.FileSaveAsItemClick(Sender: TObject);
begin
  if ActiveFileEditor <> nil then
  begin
    ActiveFileEditor.SaveAs;
    UpdateState;
  end;
end;

procedure TRAFDAppBuilder.FileExitItemClick(Sender: TObject);
begin
  Close;
end;

procedure TRAFDAppBuilder.UpdateState;
var
  i: integer;
  M: Boolean;
 // FComponentList: TComponentList;
begin
//  Exit;
(*  if ActiveDesigner <> nil then
  begin
    pnlFileName.Caption := ExtractFileName(ActiveDesigner.FileName);
    if ActiveDesigner.Changed then
      pnlChanged.Caption := 'Changed' else
      pnlChanged.Caption := '';
    ListBox1.Items.Clear;
    FComponentList := TComponentList.Create;
    try
      ActiveDesigner.GetSelections(FComponentList);
      for i := 0 to FComponentList.Count - 1 do
        ListBox1.Items.Add(ActiveDesigner.GetObjectName(FComponentList[i])+
          ': ' + FComponentList[i].ClassName);
    finally { wrap up }
      FComponentList.Free;
    end;    { try/finally }
  end
  else
  begin
    pnlFileName.Caption := LoadStr(deNoFormSelected);
  end;
*)

  M := False;
  for i := 0 to Editors.Count - 1 do    { Iterate }
    if TRAFDEditWindow(Editors[i]).Changed then
		begin
			M := True;
			Break;
		end;

  FileSaveAllItem.Enabled := M;
  bSaveAll.Enabled := M;
  FileSaveAsItem.Enabled := ActiveFileEditor <> nil;
  FileCloseItem.Enabled := ActiveFileEditor <> nil;
	FileSaveItem.Enabled := (ActiveFileEditor <> nil) and
		(ActiveFileEditor.Modified or
    ((ActiveFileEditor.Designer <> nil) {and
     (ActiveFileEditor.Designer as TRAFormDesigner).Changed}));
 {!!!!!!!!!!!!!!!!}
 
  FileCloseAllItem.Enabled := (Editors.Count > 0) or
    ProjectManager.IsProjectOpen;
  ViewPrjSourceItem.Enabled := ProjectManager.IsProjectOpen;
  ViewSwapSourceFormItem.Enabled := Assigned(ActiveFileEditor) and
    Assigned(ActiveFileEditor.Designer);
  bSwapSourceForm.Enabled := ViewSwapSourceFormItem.Enabled;
  RunFormItem.Enabled := ViewSwapSourceFormItem.Enabled;
  RunReportPreviewItem.Enabled := RunFormItem.Enabled;
  bRunForm.Enabled := RunFormItem.Enabled;
  bRunReportPreview.Enabled := RunReportPreviewItem.Enabled;
  if ProjectManager.ProjName > '' then
    Capt := Capt1 + ' - ' + ProjectManager.ProjName else
    Capt := Capt1;
	Caption := Capt;
end;    { UpdateState }

procedure TRAFDAppBuilder.FDActivate(Sender: TObject);
begin
  FDSelectionChange(nil);
end;

procedure TRAFDAppBuilder.ClearSelection;
begin
  Selection.Free;
  Selection := TComponentList.Create;
end;    { ClearSelection }

procedure TRAFDAppBuilder.FDChange(Sender: TObject);
begin
  UpdateState;
  if Sender is TRAFormDesigner then
  begin
		fRAFDPropertyInspector.UpdatePropValues(ActiveDesigner,
			GetForm, Selection);
  end;
end;

procedure TRAFDAppBuilder.FDSelectionChange(Sender: TObject);
begin
  UpdateState;
	ClearSelection;
	fRAFDPropertyInspector.UpdatePropList(ActiveDesigner,
		GetForm, GetSelections(Selection));
end;

procedure TRAFDAppBuilder.ViewObjInspItemClick(Sender: TObject);
begin
	fRAFDPropertyInspector.Show;
  FDSelectionChange(ActiveDesigner);
end;

function TRAFDAppBuilder.GetForm: TForm;
begin
	if ActiveDesigner <> nil then
		Result := ActiveDesigner.Form as TForm else
    Result := nil;
end;

function TRAFDAppBuilder.GetSelections(Selection: TComponentList)
  : TComponentList;
begin
  Result := Selection;
	if ActiveDesigner <> nil then
		ActiveDesigner.GetSelections(Selection);
end;

procedure TRAFDAppBuilder.EditorActivate(Sender: TObject);
begin
  LastActiveWindow := Sender as TForm
end;

procedure TRAFDAppBuilder.FDDestroy(Sender: TObject);
begin
  if Sender is TRAFormDesigner then
    FDs.Remove(Sender)
  else if Sender is TRAFDEditWindow then
    Editors.Remove(Sender);
  UpdateState;
end;

procedure TRAFDAppBuilder.FormDblClick(Sender: TObject);
{var
  H: THandle;
  DC: HDC;}
begin
{  H := FindWindow('ProgMan', 'Program Manager');
  if H > 0 then
  begin
    Caption := 'Found!';
    DC := GetWindowDC(H);
    with TCanvas.Create do
      try
        Handle := DC;
        Brush.Color := clRed;
        FillRect(Bounds(0, 0, 100, 100));
      finally
        Handle := 0;
        Free;
        UpdateWindow(H);
      end;
  end; }
end;

procedure TRAFDAppBuilder.Button2Click(Sender: TObject);
begin
  if ActiveDesigner <> nil then
  begin
    ActiveDesigner.SaveToFile('C:\Temp\fTestForm3');
    UpdateState;
  end;
end;

procedure TRAFDAppBuilder.Button3Click(Sender: TObject);
begin
  OpenFile('E:\Test\RAFormDesigner\forms\fTestForm3.pas');
end;

procedure TRAFDAppBuilder.ViewAlignItemClick(Sender: TObject);
begin
  fRAFDAlignPalette.Show;
end;

procedure TRAFDAppBuilder.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IDECloseDesignWindows;
  ProjectManager.CloseProject;
  if Assigned(ActiveEditWindow) then
    ActiveEditWindow.Close;
  IDETerminateExperts;
 // IDEUnloadExperts;
 // IDEUnloadPackages;
 // ActiveDesigner := nil;
end;

procedure TRAFDAppBuilder.bSwapSourceFormClick(Sender: TObject);
begin
  if (ActiveFileEditor <> nil) and (ActiveFileEditor.Designer <> nil) then
  begin
    if LastActiveWindow is TRAFDEditWindow then
    begin
      ShowWindow(ActiveFileEditor.Designer.Form.Handle, SW_SHOW);
      ActiveFileEditor.Designer.Form.Visible := True;
      if IsIconic(ActiveFileEditor.Designer.Form.Handle) then
        OpenIcon(ActiveFileEditor.Designer.Form.Handle);
      ActiveFileEditor.Designer.Form.SetFocus;
    end
    else
    begin
      if ActiveFileEditor.Form.WindowState = wsMinimized then
        ActiveFileEditor.Form.WindowState := wsNormal;
      ActiveFileEditor.SetFocus;
    end;
  end;
end;

procedure TRAFDAppBuilder.EditDeleteItemClick(Sender: TObject);
begin
  if (ActiveDesigner <> nil) and (Screen.ActiveForm = ActiveDesigner.Form) then
    ActiveDesigner.DeleteSelection;
end;

procedure TRAFDAppBuilder.EditCopyItemClick(Sender: TObject);
begin
  if (ActiveDesigner <> nil) and (Screen.ActiveForm = ActiveDesigner.Form) then
    ActiveDesigner.CopySelection;
end;

procedure TRAFDAppBuilder.EditPasteItemClick(Sender: TObject);
begin
  if (ActiveDesigner <> nil) and (Screen.ActiveForm = ActiveDesigner.Form) then
    ActiveDesigner.PasteSelection;
end;

procedure TRAFDAppBuilder.ViewPaletteItemClick(Sender: TObject);
begin
  if Palette.Visible then
  begin
    Palette.Visible := False;
    pnlToolbar.Height := Pixels(Self, 34);
  end
  else
  begin
    Palette.Left := Splitter1.Left + 4;
    Palette.Visible := True;
    pnlToolbar.Height := Pixels(Self, 56);
    Palette.Top := 2;
  end;
  Splitter1.Visible := Palette.Visible;
  if not RAFDDebug then
    ClientHeight := pnlToolbar.BoundsRect.Bottom;
  Resize;
end;

procedure TRAFDAppBuilder.RegAuto1AfterSave(Sender: TObject);
begin
  (Sender as TRegAuto).WriteBool(Name, 'PaletteVisible', Palette.Visible);
end;

procedure TRAFDAppBuilder.RegAuto1AfterLoad(Sender: TObject);
begin
  Palette.Visible := not (Sender as TRegAuto).ReadBool(Name, 'PaletteVisible', Palette.Visible);
  ViewPaletteItemClick(nil);
end;

procedure TRAFDAppBuilder.raProjectBeforeSave(Sender: TObject);
begin
  if Assigned(ProjectManager) then
    raProject.IniFile := ProjectManager.raProject.IniFile;
end;

procedure TRAFDAppBuilder.raProjectBeforeLoad(Sender: TObject);
begin
  if Assigned(ProjectManager) then
    raProject.IniFile := ProjectManager.raProject.IniFile;
end;

procedure TRAFDAppBuilder.ViewPrjSourceItemClick(Sender: TObject);
begin
  if Assigned(ProjectManager) then
    ProjectManager.ShowSource;
end;

procedure TRAFDAppBuilder.ViewPrjMngrItemClick(Sender: TObject);
begin
  if Assigned(ProjectManager) then
    ProjectManager.Show;
end;

procedure TRAFDAppBuilder.FormShow(Sender: TObject);
begin
  if not RAFDDebug then
    ClientHeight := pnlToolbar.BoundsRect.Bottom;
end;

procedure TRAFDAppBuilder.FormResize(Sender: TObject);
begin
  if Palette = nil then Exit;
  Palette.Left := Splitter1.Left + 4;
  Palette.Width := pnlToolbar.Width - Palette.Left;
end;

procedure TRAFDAppBuilder.Splitter1Moved(Sender: TObject);
begin
  Palette.Left := Splitter1.Left + 4;
  Palette.Width := pnlToolbar.Width - Palette.Left;
end;

procedure TRAFDAppBuilder.ViewsMenuClick(Sender: TObject);
begin
  ViewPaletteItem.Checked := Palette.Visible;
end;

procedure TRAFDAppBuilder.WMGetMinMaxInfo(var M : TWMGetMinMaxInfo);
begin
  inherited;
  if RAFDDebug then Exit;
  if Visible then
  begin
    M.MinMaxInfo^.ptMinTrackSize.Y := Height - ClientHeight + pnlToolbar.BoundsRect.Bottom;
    M.MinMaxInfo^.ptMaxTrackSize.Y := M.MinMaxInfo^.ptMinTrackSize.Y;
    M.MinMaxInfo^.ptMinTrackSize.X := 80;
  end;
end;

(*
procedure DynamicRAI2RunFormModal(const FileName: TFileName);
begin
	RAI2Fm.RAI2RunFormModal(FileName);
end;    { DynamicRAI2RunFormModal }
*)

const
 {$IFDEF RA_D3}
  PackageFileName = 'rai3.dpl';
  ALLPackageFileName = 'raia3.dpl';
 {$ENDIF}
 {$IFDEF RA_D4}
  PackageFileName = 'rai4.bpl';
  ALLPackageFileName = 'raia4.bpl';
 {$ENDIF}
 {$IFDEF RA_D5}
  PackageFileName = 'rai5.bpl';
  ALLPackageFileName = 'raia5.bpl';
 {$ENDIF}

{ run form using RAI3.dpl package }
procedure DynamicRAI2RunFormModal(const FileName: TFileName);
var
  Pak, ALLPak: HModule;
  Proc: procedure;
type
  TRAI2RunFormModal = function (const FileName: TFileName): TModalResult;
begin
  Pak := 0;
  ALLPak := 0;
  try
    Pak := LoadPackage(PackageFileName);
  except
    RAFDErrorN(deRAI2NotFound, PackageFileName);
  end;
  try
    ALLPak := LoadPackage(ALLPackageFileName);
  except
    RAFDErrorN(deRAI2NotFound, ALLPackageFileName);
  end;
  try
   {$IFDEF RA_D3}
  	Proc := GetProcAddress(ALLPak, ('RAI2_all.RAI2_all@00000000'));
   {$ELSE}
  	Proc := GetProcAddress(ALLPak, ('@Rai2_all@initialization$qqrv'));
   {$ENDIF}
  	if not Assigned(Proc) then
      RAFDErrorN(deRAI2FuncNotFound, ALLPackageFileName);
 		Proc;
   {$IFDEF RA_D3}
  	Proc := GetProcAddress(Pak, ('RAI2Fm.RAI2RunFormModal@A8853D1A'));
   {$ELSE}
  	Proc := GetProcAddress(Pak, ('@Rai2fm@RAI2RunFormModal$qqrx17System@AnsiString'));
   {$ENDIF}
  	if not Assigned(Proc) then
      RAFDErrorN(deRAI2FuncNotFound, PackageFileName);
 		TRAI2RunFormModal(Proc)(FileName);
  finally { wrap up }
    UnloadPackage(ALLPak);
    UnloadPackage(Pak);
  end;    { try/finally }
end;    { DynamicRAI2RunFormModal }

{ run report using RAI3.dpl package }
procedure DynamicRAI2RunReportPreview(const FileName: TFileName);
var
  Pak, ALLPak: HModule;
  Proc: procedure;
type
  TRAI2RunReportPreview = procedure (const FileName: TFileName);
begin
  Pak := 0;
  ALLPak := 0;
  try
    Pak := LoadPackage(PackageFileName);
  except
    RAFDErrorN(deRAI2NotFound, PackageFileName);
  end;
  try
    ALLPak := LoadPackage(ALLPackageFileName);
  except
    RAFDErrorN(deRAI2NotFound, ALLPackageFileName);
  end;
  try
   {$IFDEF RA_D3}
  	Proc := GetProcAddress(ALLPak, ('RAI2_all.RAI2_all@00000000'));
   {$ELSE}
  	Proc := GetProcAddress(ALLPak, ('@Rai2_all@initialization$qqrv'));
   {$ENDIF}
  	if not Assigned(Proc) then
      RAFDErrorN(deRAI2FuncNotFound, ALLPackageFileName);
 		Proc;
   {$IFDEF RA_D3}
  	Proc := GetProcAddress(ALLPak, ('RAI2_Quickrpt.RAI2RunReportPreview@D425663E'));
   {$ELSE}
  	Proc := GetProcAddress(ALLPak, ('@Rai2_quickrpt@RAI2RunReportPreview$qqrx17System@AnsiString'));
   {$ENDIF}
  	if not Assigned(Proc) then
      RAFDErrorN(deRAI2FuncNotFound, ALLPackageFileName);
 		TRAI2RunReportPreview(Proc)(FileName);
  finally { wrap up }
    UnloadPackage(ALLPak);
    UnloadPackage(Pak);
  end;    { try/finally }
end;    { DynamicRAI2RunFormModal }

procedure TRAFDAppBuilder.bRunFormClick(Sender: TObject);
var
  Capt: string;
begin
  if (ActiveFileEditor = nil) or (ActiveFileEditor.Designer = nil) then Exit;
  Capt := Caption;
  Caption := Capt + ' - [Running]';
  ShowWindow(ActiveFileEditor.Designer.Form.Handle, SW_HIDE);
  try
    DynamicRAI2RunFormModal(ActiveFileEditor.FileName);
  finally { wrap up }
    ShowWindow(ActiveFileEditor.Designer.Form.Handle, SW_SHOWNOACTIVATE);
    Caption := Capt;
  end;    { try/finally }
end;

procedure TRAFDAppBuilder.bRunReportPreviewClick(Sender: TObject);
var
  Capt: string;
begin
  if (ActiveFileEditor = nil) or (ActiveFileEditor.Designer = nil) then Exit;
  Capt := Caption;
  Caption := Capt + ' - [Running]';
  ShowWindow(ActiveFileEditor.Designer.Form.Handle, SW_HIDE);
  try
    DynamicRAI2RunReportPreview(ActiveFileEditor.FileName);
  finally { wrap up }
    ShowWindow(ActiveFileEditor.Designer.Form.Handle, SW_SHOWNOACTIVATE);
    Caption := Capt;
  end;    { try/finally }
end;

procedure TRAFDAppBuilder.LoadLocale;

  procedure Item(MenuItem: TMenuItem; const ID: Integer);
  begin
    MenuItem.Caption := ResStr(ID, MenuItem.Caption);
  end;   

  procedure Button(SpeedButton: TSpeedButton; const ID: Integer);
  begin
    SpeedButton.Hint := ResStr(ID, SpeedButton.Hint);
  end;

begin
  Item(FileMenu        , deFileMenu        );
  Item(FileNewItem     , deFileNewItem     );
  Item(FileNewFormItem , deFileNewFormItem );
  Item(FileOpenItem    , deFileOpenItem    );
  Item(FileSaveItem    , deFileSaveItem    );
  Item(FileSaveAsItem  , deFileSaveAsItem  );
  Item(FileSaveAllItem , deFileSaveAllItem );
  Item(FileCloseItem   , deFileCloseItem   );
  Item(FileCloseAllItem, deFileCloseAllItem);
  Item(FileExitItem    , deFileExitItem    );
  Item(EditMenu        , deEditMenu        );
  Item(EditCopyItem    , deEditCopyItem    );
  Item(EditPasteItem   , deEditPasteItem   );
  Item(EditDeleteItem  , deEditDeleteItem  );
  Item(ViewsMenu       , deViewsMenu       );
  Item(ViewObjInspItem , deViewObjInspItem );
  Item(ViewAlignItem   , deViewAlignItem   );
  Item(ViewPaletteItem , deViewPaletteItem );
  Item(ViewSwapSourceFormItem , deViewSwapSourceFormItem );
  Item(ViewWindowListItem     , deViewWindowListItem     );
  Item(RunMenu                , deRunMenu                );
  Item(RunFormItem            , deRunFormItem            );
  Item(RunReportPreviewItem   , deRunReportPreviewItem   );
  Item(ComponentMenu          , deComponentMenu          );
  Item(SearchMenu             , deSearchMenu             );
  Item(ProjectMenu            , deProjectMenu            );
  Item(ViewPrjSourceItem      , deViewPrjSourceItem      );
  Item(ToolsMenu              , deToolsMenu              );
  Item(ToolsOptionsItem       , deToolsOptionsItem       );
  Item(HelpMenu               , deHelpMenu               );

  Button(bOpen             , deOpenHint             );
  Button(bSaveAll          , deSaveAllHint          );
  Button(bSwapSourceForm   , deSwapSourceFormHint   );
  Button(bRunForm          , deRunFormHint          );
  Button(bRunReportPreview , deRunReportPreviewHint );
end;    { LoadLocale }

procedure TRAFDAppBuilder.FileNewItemClick(Sender: TObject);
begin
  fRAFDNewItem.Show;
end;


{************************** Dynamic package loading **************************}

procedure TRAFDAppBuilder.LoadPackages;
var
  i: integer;
  Ss: TStrings;
begin
  Ss := TStringList.Create;
  try
    raPref.ReadWholeSection('Packages', Ss);
    for i := 0 to Ss.Count - 1 do    { Iterate }
      if (Trim(Ss[i]) <> '') and (Ss[i][1] <> ';') then
        try
          IDELoadPackage(Trim(Ss[i]));
          Application.ProcessMessages;
        except
          on E: Exception do
            Application.ShowException(E);
        end;
  finally { wrap up }
    Ss.Free;
    ActiveModule := hInstance;
  end;    { try/finally }
  if Assigned(RAAppBuilder) and Assigned(RAAppBuilder.FOnPackagesLoaded) then
    RAAppBuilder.FOnPackagesLoaded(RAAppBuilder);
 // InitCompLib;
  fRAFDPalette.UpdatePalette;
end;    { LoadPackages }

{########################## Dynamic package loading ##########################}

procedure TRAFDAppBuilder.LoadExperts;
var
  i: integer;
  Ss: TStrings;
begin
  Ss := TStringList.Create;
  try
    raPref.ReadWholeSection('Experts', Ss);
    for i := 0 to Ss.Count - 1 do
      if (Trim(Ss[i]) <> '') and (Ss[i][1] <> ';') then
        try
          IDELoadExpert(Trim(Ss[i]));
          Application.ProcessMessages;
        except
          on E: Exception do
          begin
            E.Message := Format(ResStr(deResBase + deLoadExpertFail, ''),
              [Ss[i], E.Message]);
            Application.ShowException(E);
          end;
        end;
  finally { wrap up }
  //  Ss.Clear;
    Ss.Free;
  end;    { try/finally }
end;    { LoadExperts }


procedure TRAFDAppBuilder.Button6Click(Sender: TObject);
begin
  IDEUnloadPackages;
end;

procedure TRAFDAppBuilder.UpdateExpertMenu;
var
  Expert: TIExpert;
  ExpertList: TList;
  i: integer;
  MenuItem: TMenuItem;
begin
  ExpertList := RAFDIDE.GetExpertList;
  for i := 0 to ExpertList.Count - 1 do
  begin
    Expert := TExpertRec(ExpertList[i]).Expert;
    if Assigned(Expert) and (Expert.GetStyle = esStandard) then
    begin
      MenuItem := NewItem(Expert.GetMenuText, 0, False, True, ExpertClick, 0, '');
      MenuItem.Tag := Integer(Expert);
      HelpMenu.Add(MenuItem);
    end;
  end;    { for }
end;    { UpdateExpertMenu }

procedure TRAFDAppBuilder.ExpertClick(Sender: TObject);
begin
  TIExpert((Sender as TMenuItem).Tag).Execute;
end;    { ExpertClick }

{************************** TRAAppBuilder ******************************}
constructor TRAAppBuilder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;    { Create }

destructor TRAAppBuilder.Destroy;
begin
  AppBuilder.Free;
  inherited Destroy;
end;    { Destroy }

procedure TRAAppBuilder.CreateAppBuilderWindow;
begin
  Application.CreateForm(TAppBuilder, AppBuilder);
  AppBuilder.RAAppBuilder := Self;
end;    { CreateAppBuilderWindow }

procedure TRAAppBuilder.Execute;
begin
  FRunning := True;
  if AppBuilder = nil then
    CreateAppBuilderWindow;
  AppBuilder.raPref.IniFile := FIniFile;
  AppBuilder.Execute;
 // FMainForm.Show;
end;

procedure TRAAppBuilder.Done;
begin
  FRunning := False;
end;

procedure TRAAppBuilder.SetBaseRegistryKey(Value: string);
begin
  if Assigned(RAToolServices) then
    RAToolServices.SetBaseRegistryKey(Value);
end;

function TRAAppBuilder.GetBaseRegistryKey: string;
begin
  if Assigned(RAToolServices) then
    Result := RAToolServices.GetBaseRegistryKey else
    Result := DefaultRegistryKey;
end;









end.
