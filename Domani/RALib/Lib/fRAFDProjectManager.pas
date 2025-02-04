{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       description : Project Manager

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib.htm
************************************************************}

{$INCLUDE RA.INC}

unit fRAFDProjectManager;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, ExtCtrls,
  ToolIntf, EditIntf, VirtIntf, ExptIntf, fRAFDEditor, IParser, RARegAuto,
  RAFDCompat;

type

  TRAFDProjectManager = class(TForm)
    Panel2: TPanel;
    FileHeader: THeaderControl;
    FileList: TListBox;
    StatusBar: TStatusBar;
    ProjManPopup: TPopupMenu;
    SaveProject1: TMenuItem;
    SaveAsTemplateItem: TMenuItem;
    N2: TMenuItem;
    NewUnit1: TMenuItem;
    NewForm1: TMenuItem;
    AddfileItem: TMenuItem;
    RemoveFileItem: TMenuItem;
    N1: TMenuItem;
    PrjUnitItem: TMenuItem;
    PrjFormItem: TMenuItem;
    EditProject1: TMenuItem;
    N3: TMenuItem;
    Options1: TMenuItem;
    UpdateItem: TMenuItem;
    LocalMenuItem: TMenuItem;
    ZoomWindowItem: TMenuItem;
    raProject: TRegAuto;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FileListDblClick(Sender: TObject);
  private
    FProjectName: string;
    FProgramName: string;
    FUnits: TStrings;
    FFileEditor: TFileEditor;
    FProjectSource: string;
    FModuleInterface: TIModuleInterface;
    Parser: TIParser;
    FOnProjectOpen: TNotifyEvent;
    FOnProjectClose: TNotifyEvent;
    procedure ReadProjectInfo;
  public
    procedure OpenProject(const FileName: TFileName);
    procedure CloseProject;
    procedure ShowSource;
    procedure SourceClosing;
    function IsProjectOpen: boolean;
    function ProjName: string;
    function GetProjectName: string;
    function GetUnitCount: Integer;
    function GetUnitName(Index: Integer): string;
    function EnumProjectUnits(EnumProc: TProjectEnumProc; Param: Pointer): Boolean;
    function GetFormCount: Integer;
    function GetFormName(Index: Integer): string;
    procedure SetModuleInterface(AModuleInterface: TIModuleInterface);
    function GetNewModuleName(var UnitIdent, FileName: string): Boolean;
    function GetNewModuleAndClassName(const Prefix: string; var UnitIdent,
      ClassName, FileName: string): Boolean;
    function CreateModule(const ModuleName: string;
      Source, Form: TIStream; CreateFlags: TCreateModuleFlags): Boolean;
    function ProjectCreate(ProjectCreator: TIProjectCreator;
      CreateFlags: TCreateProjectFlags): TIModuleInterface;
    function ModuleCreate(ModuleCreator: TIModuleCreator;
      CreateFlags: TCreateModuleFlags): TIModuleInterface;
    property FileEditor: TFileEditor read FFileEditor;
    property ModuleInterface: TIModuleInterface read FModuleInterface;
    property OnProjectOpen: TNotifyEvent read FOnProjectOpen write FOnProjectOpen;
    property OnProjectClose: TNotifyEvent read FOnProjectClose write FOnProjectClose;
  end;

  procedure Create;
  procedure Close;

var
  ProjectManager: TRAFDProjectManager;

implementation

uses RAUtils, iMTracer, RAFD, RAFDIDE, fRAFDAppBuilder;

{$R *.dfm}

procedure Create;
begin
  ProjectManager := FindFormByClass(TRAFDProjectManager) as TRAFDProjectManager;
  if ProjectManager = nil then
    ProjectManager := TRAFDProjectManager.Create(Application);
end;    { Create }

procedure Close;
var
  Form: TForm;
begin
  Form := FindFormByClass(TRAFDProjectManager);
  if Form <> nil then
    Form.Free;
end;

procedure TRAFDProjectManager.FormCreate(Sender: TObject);
begin
  FUnits := TStringList.Create;
  Parser := TIParser.Create;
end;

procedure TRAFDProjectManager.FormDestroy(Sender: TObject);
begin
  ProjectManager := nil;
  FUnits.Free;
  Parser.Free;
end;

function TRAFDProjectManager.ProjName: string;
begin
  Result := ChangeFileExt(ExtractFileName(FProjectName), '');
end;

function TRAFDProjectManager.GetProjectName: string;
begin
  Result := FProjectName;
end;

procedure TRAFDProjectManager.OpenProject(const FileName: TFileName);
var
  Cancel: Boolean;
begin
  ODS('ProjectManager.OpenProject');
  CloseProject;
  if Assigned(ActiveEditWindow) then
    ActiveEditWindow.Close;
  if Assigned(RAToolServices) then
  begin
    Cancel := False;
    RAToolServices.FileNotification(fnProjectOpening, FileName, Cancel);
    if Cancel then Abort;
  end;
  FProjectName := FileName;
  raProject.IniFile := ChangeFileExt(FProjectName, '.dsk');
  raProject.Load;
  FProjectSource := LoadTextFile(FProjectName);
  ReadProjectInfo;
  if Assigned(RAToolServices) then
    RAToolServices.FileNotification(fnProjectOpened, FileName, Cancel);
  if Assigned(FOnProjectOpen) then FOnProjectOpen(Self);
end;

procedure TRAFDProjectManager.CloseProject;
var
  Cancel: Boolean;
begin
  if FProjectName = '' then Exit;
  ODS('ProjectManager.CloseProject');
  raProject.IniFile := ChangeFileExt(FProjectName, '.dsk');
  raProject.Save;
  if Assigned(RAToolServices) then
  begin
    Cancel := False;
    RAToolServices.FileNotification(fnProjectClosing, FProjectName, Cancel);
    if Cancel then Abort;
  end;
  if Assigned(ActiveEditWindow) then
    ActiveEditWindow.Close;
  FProjectName := '';
  Hide;
  FUnits.Clear;
  if Assigned(FOnProjectClose) then FOnProjectClose(Self);
end;

procedure TRAFDProjectManager.ReadProjectInfo;
var
  ProjectPath: TFileName;
  Token, UnitName, UnitFileName: string;
begin
  FUnits.Clear;
  ProjectPath := ExtractFilePath(FProjectName);
  Parser.pcProgram := PChar(FProjectSource);
  Parser.PCPos := Parser.pcProgram;
  Token := Parser.Token;
  if not Cmp(Token, 'program') then
    RAFDErrorN2(deClauseIncorrect, FProjectName, 'program');
  FProgramName := Parser.Token;
  if not Cmp(Parser.Token, ';') then
    RAFDErrorN2(deClauseIncorrect, FProjectName, 'program');
  if not Cmp(Parser.Token, 'uses') then
    RAFDErrorN2(deClauseIncorrect, FProjectName, 'uses');
  while True do
  begin
    UnitName := Parser.Token;
    UnitFileName := ProjectPath + UnitName + '.pas';
    if not IsIdentifer(UnitName) then
      RAFDErrorN2(deClauseIncorrect, FProjectName, 'uses');
    Token := Parser.Token;
    if Token = 'in' then
    begin
      UnitFileName := ProjectPath + GetStringValue(Parser.Token);
      Token := Parser.Token;
      FUnits.Add(UnitFileName);
    end;
    if Token = ',' then
     { Ok! }
    else if Token = ';' then
      Break
    else
      RAFDErrorN2(deClauseIncorrect, FProjectName, 'uses');
  end;
  FileList.Items.Assign(FUnits);
end;    { ReadProjectInfo }

function TRAFDProjectManager.GetUnitCount: Integer;
begin
  Result := FUnits.Count;
end;

function TRAFDProjectManager.GetUnitName(Index: Integer): string;
begin
  if (Index > -1) and (Index < FUnits.Count) then
    Result := FUnits[Index] else
    Result := '';
end;

function TRAFDProjectManager.EnumProjectUnits(EnumProc: TProjectEnumProc;
  Param: Pointer): Boolean;
var
  i: integer;
  FormName: string;
begin
  for i := 0 to FUnits.Count - 1 do    { Iterate }
  begin
    FormName := '';
    EnumProc(Param, FUnits[i], ChangeFileExt(ExtractFileName(FUnits[i]), ''),
      FormName);
  end;    { for }
  Result := True;
end;

function TRAFDProjectManager.GetFormCount: Integer;
begin
  { !!! NOT COMPLETE !!! }
  Result := 0;
end;

function TRAFDProjectManager.GetFormName(Index: Integer): string;
begin
  { !!! NOT COMPLETE !!! }
  Result := '';
end;

procedure TRAFDProjectManager.ShowSource;
begin
  if FProjectName = '' then Exit;
  if not Assigned(FileEditor) then
  begin
    AppBuilder.CheckActiveEditWindow;
    if not ActiveEditWindow.OpenFile(FProjectName, False) then
  		Error('Can''t open file');
    FFileEditor := ActiveFileEditor;
    FFileEditor.IsProjectFile := True;
    FFileEditor.SetModuleInterface(ModuleInterface as TIRAModuleInterface);
  end;
  FFileEditor.Activate;
end;    { ShowSource }

procedure TRAFDProjectManager.SourceClosing;
begin
  if Assigned(FileEditor) then
  begin
    FProjectSource := FileEditor.Lines.Text;
    FFileEditor := nil;
  end;
end;    { CloseSource }

procedure TRAFDProjectManager.SetModuleInterface(AModuleInterface: TIModuleInterface);
begin
  FModuleInterface := AModuleInterface;
end;

function TRAFDProjectManager.IsProjectOpen: boolean;
begin
  Result := FProjectName <> '';
end;

function TRAFDProjectManager.GetNewModuleName(var UnitIdent, FileName: string)
  : Boolean;
var
  ClassName: string;
begin
  Result := GetNewModuleAndClassName('', UnitIdent, ClassName, FileName);
end;

function TRAFDProjectManager.GetNewModuleAndClassName(const Prefix: string;
  var UnitIdent, ClassName, FileName: string): Boolean;
begin
 { !!! NOT COMPLETE !!! }
  UnitIdent := 'Unit1';
  FileName := ExtractFilePath(FProjectName) + UnitIdent + '.pas';
  ClassName := 'Form1';
  Result := True;
end;

function TRAFDProjectManager.CreateModule(const ModuleName: string;
	Source, Form: TIStream; CreateFlags: TCreateModuleFlags): Boolean;
var
  TmpFile: string;
  TmpStream1: TStringStream;
  TmpStream2: TStringStream;
  FileStream: TFileStream;
  Buffer: string;
  P: Integer;
begin
  AppBuilder.CheckActiveEditWindow;
 { read source }
  ActiveEditWindow.OpenNewFile(ModuleName);
  SetLength(Buffer, 4096); P := 4096;
  while P = 4096 do
  begin
   {$IFDEF RA_D3}
    P := Source.Read(Buffer[Length(Buffer) + 1 - 4096], 4096);
   {$ELSE}
    NotImplemented('CreateModule');
   {$ENDIF}
    SetLength(Buffer, Length(Buffer) + P);
  end;    { while }
  ActiveFileEditor.Lines.Text := Buffer;
 { read form }
  SetLength(Buffer, 4096); P := 4096;
  while P = 4096 do
  begin
   {$IFDEF RA_D3}
    P := Form.Read(Buffer[Length(Buffer) + 1 - 4096], 4096);
   {$ELSE}
    NotImplemented('CreateModule');
   {$ENDIF}
    SetLength(Buffer, Length(Buffer) + P);
  end;    { while }
  TmpFile := GenTempFileNameExt('', '.dfm');
	TmpStream1 := TStringStream.Create(Buffer);
	TmpStream2 := TStringStream.Create('');
  try
   { i don't know why creating form directly from Form stream sometimes
     raises error, but converting-reconvering solve this problem }

    ObjectResourceToText(TmpStream1, TmpStream2);
		TmpStream1.Position := 0; TmpStream2.Position := 0;
		ObjectTextToResource(TmpStream2, TmpStream1);
    FileStream := TFileStream.Create(TmpFile, fmOpenWrite or fmCreate);
    try
  		FileStream.CopyFrom(TmpStream1, 0);
    finally
  		FileStream.Free;
    end;
  	AppBuilder.NewDesigner(TmpFile, ActiveFileEditor);
  finally
		TmpStream1.Free;
		TmpStream2.Free;
    DeleteFile(TmpFile);
  end;    { try/finally }
  AppBuilder.UpdateState;
  Result := True;
end;

function TRAFDProjectManager.ProjectCreate(ProjectCreator: TIProjectCreator;
	CreateFlags: TCreateProjectFlags): TIModuleInterface;
begin
  Result := nil;
end;

function TRAFDProjectManager.ModuleCreate(ModuleCreator: TIModuleCreator;
	CreateFlags: TCreateModuleFlags): TIModuleInterface;
begin
  Result := nil;
end;

procedure TRAFDProjectManager.FileListDblClick(Sender: TObject);
begin
  if (FileList.ItemIndex > - 1) and Assigned(ToolServices) then
    ToolServices.OpenFile(FileList.Items[FileList.ItemIndex]);
end;

end.
