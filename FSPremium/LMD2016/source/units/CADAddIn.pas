unit CADAddIn;
{$I lmddlgcmps.inc}

interface

procedure Register;

implementation

uses
    Menus
  , Windows
  , ActnList
  , Classes
  , SysUtils
  , ToolsAPI
  , CADForm
  , Dialogs
  , ExtCtrls
  , JSDialogs
  , Registry
  ;

type
  TCADAddIn = class(TNotifierObject, IOTAKeyboardBinding)
  private
    FAction: TAction;
    FMenuItem: TMenuItem;
    procedure ConstructADialogHandler(Sender: TObject);
    procedure ConstructADialogUpdateHandler(Sender: TObject);
    procedure InsertCode(aSettings: TDlgSettings);
    procedure Binding(const Context: IOTAKeyContext; KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
  public
    constructor Create;
    destructor Destroy; override;
    class function Install: TCADAddIn;
    procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);
    function GetBindingType: TBindingType;
    function GetDisplayName: string;
    function GetName: string;
  end;

var
  FCADAddIn: TCADAddIn;
  _Index: Integer;

procedure Register;
begin
  FCADAddIn := TCADAddIn.Install;
end;

{ TCADAddIn }

procedure TCADAddIn.Binding(const Context: IOTAKeyContext; KeyCode: TShortcut;
  var BindingResult: TKeyBindingResult);
begin
  ConstructADialogHandler(FAction);
  BindingResult := krHandled;
end;

procedure TCADAddIn.BindKeyboard(const BindingServices: IOTAKeyBindingServices);
begin
  BindingServices.AddKeyBinding([FAction.ShortCut], Binding, nil, 7, '', FMenuItem.Name);
end;

procedure TCADAddIn.ConstructADialogHandler(Sender: TObject);
var
  lSettings: TDlgSettings;
begin
  lSettings := TDlgSettings.Create;
  try
    if TfrmCAD.Execute(lSettings) then
      InsertCode(lSettings);
  finally
    lSettings.Free;
  end;
end;

function SameFileName(const S1, S2: string): Boolean;
begin
  Result := (CompareText(S1, S2) = 0);
end;

function GetFileEditorForModule(Module: IOTAModule; Index: Integer): IOTAEditor;
begin
  if Module <> nil then
    Result := Module.GetModuleFileEditor(Index)
  else
    Result := nil;
end;

function GetSourceEditorFromModule(Module: IOTAModule; const FileName: string): IOTASourceEditor;
var
  I: Integer;
  LEditor: IOTAEditor;
  LSrcEditor: IOTASourceEditor;
begin
  Result := nil;
  if Module <> nil then
  begin
    for I := 0 to Module.GetModuleFileCount - 1 do
    begin
      LEditor := GetFileEditorForModule(Module, I);
      if (LEditor <> nil) and Supports(LEditor, IOTASourceEditor, LSrcEditor) then
      begin
        if (LSrcEditor <> nil) then
        begin
          if (FileName = '') or SameFileName(LSrcEditor.FileName, FileName) then
          begin
            Result := LSrcEditor;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function GetTopMostEditBuffer: IOTAEditBuffer;
var
  LServices: IOTAEditorServices;
begin
  LServices := (BorlandIDEServices as IOTAEditorServices);
  if LServices <> nil then
    Result := LServices.TopBuffer
  else
    Result := nil;
end;

function GetCurrentModule: IOTAModule;
var
  LServices: IOTAModuleServices;
begin
  LServices := BorlandIDEServices as IOTAModuleServices;
  if LServices <> nil then
    Result := LServices.CurrentModule
  else
    Result := nil;
end;

function GetCurrentSourceEditor: IOTASourceEditor;
var
  LEditBuffer: IOTAEditBuffer;
begin
  Result := nil;
  LEditBuffer := GetTopMostEditBuffer;
  if (LEditBuffer <> nil) and (LEditBuffer.FileName <> '') then
    Result := GetSourceEditorFromModule(GetCurrentModule, LEditBuffer.FileName);
  if Result = nil then
    Result := GetSourceEditorFromModule(GetCurrentModule, '');
end;

procedure TCADAddIn.ConstructADialogUpdateHandler(Sender: TObject);
var
  lSrc: IOTASourceEditor;
  {$IFNDEF DELPHI5}
  lMod: IOTAModule;
  {$ENDIF DELPHI5}
begin
  {$IFNDEF DELPHI5}
  lMod := (BorlandIDEServices as IOTAModuleServices).CurrentModule;
  TAction(Sender).Enabled := (lMod <> nil) and (lMod.CurrentEditor <> nil) and
    (Supports(lMod.CurrentEditor, IOTASourceEditor, lSrc));
  {$ELSE}
  TAction(Sender).Enabled := Supports(GetCurrentSourceEditor, IOTASourceEditor, lSrc);
  {$ENDIF DELPHI5}
end;

var
  FShortCut: string;

{$IFNDEF BDS}

type
  TDummyClass = class
  public
    class procedure OldTimerTimer(Sender: TObject);
  end;
  
var
  FOldTimer: TTimer;
  FCreatedMenuItem: TMenuItem;

procedure InstallMenuItem(AMenuItem: TMenuItem; AAction: TAction);
var
  lItem: TMenuItem;
  i: Integer;
  lIdx: Integer;
  lMainMenu: TMainMenu;

  function FindMenuIndex(AMainMenu: TMainMenu; const ACaption: string): integer;
  var
    j: integer;
  begin
    result := -1;
    for j := 0 to AMainMenu.Items.Count -1 do
    begin
      if StripHotKey(AMainMenu.Items[j].Caption) = ACaption then
      begin
        result := AMainMenu.Items[j].MenuIndex;
        break;
      end;
    end;
  end;

begin
  lMainMenu := (BorlandIDEServices as INTAServices).MainMenu;
  lIdx := FindMenuIndex(lMainMenu, 'Tools');
  if lIdx = -1 then
  begin
    ShowErrorMessage('Menu &Tools Not found');
    Exit;
  end;
  lItem := lMainMenu.Items[lIdx];
  lIdx := -1;
  for i := 0 to lItem.Count - 1 do
  begin
    if (lItem.Items[i] <> nil) and
      (SameText(StripHotkey(lItem.Items[i].Caption), 'Repository...')) then
    begin
      lIdx := i + 1; // add it in after Forms...
      break
    end;
  end;

  if (lIdx = -1) or (lIdx >= lItem.Count) then
    lIdx := lItem.Count - 1; // add at the end of the menu if Forms... isn't found

  AMenuItem.Action := AAction;

  try
    lItem.Insert(lIdx, AMenuItem);
  except
    lItem.Insert(0, AMenuItem);
  end;

  FCreatedMenuItem := AMenuItem;
  
  FOldTimer := TTimer.Create(nil);
  FOldTimer.OnTimer := TDummyClass.OldTimerTimer;
  FOldTimer.Interval := 2000;
  FOldTimer.Enabled := True;
end;

class procedure TDummyClass.OldTimerTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  FCreatedMenuItem.ShortCut := TextToShortCut(FShortCut);
end;

{$ENDIF BDS}

constructor TCADAddIn.Create;
var
  lOwner: TComponent;
  LRegistry: TRegistry;
  LShortCut: string;
  LShortCutValue: Word;
  LRegKey: string;
begin
  lOwner := (BorlandIDEServices as INTAServices).MainMenu;
  FAction := TAction.Create(lOwner);
  FAction.Caption := 'Construct A Dialog';
  FAction.Category := 'Tools';

  LShortCut := 'Ctrl+Alt+D';

  LRegKey := (BorlandIDEServices as IOTAServices).GetBaseRegistryKey + '\LMD Innovative\LMD DialogPack\';

  LRegistry := TRegistry.Create;
  try
    LRegistry.RootKey := HKEY_CURRENT_USER;
    if LRegistry.OpenKey(LRegKey, True) then
    begin
      if LRegistry.ValueExists('ems') then
      begin
        try
          LShortCut := LRegistry.ReadString('ems');
        except
          // failed to read key
          LShortCut := 'Ctrl+Alt+D';
        end;
      end
      else
        LRegistry.WriteString('ems', LShortCut);
    end;
  finally
    LRegistry.Free;
  end;

  try
    LShortCutValue := TextToShortCut(LShortCut);
    FShortCut := LShortCut;
  except
    FShortCut := 'Ctrl+Alt+D';
    LShortCutValue := TextToShortCut(FShortCut);
  end;

  FAction.ShortCut := LShortCutValue;
  FAction.OnExecute := ConstructADialogHandler;
  FAction.OnUpdate := ConstructADialogUpdateHandler;
  FAction.Name := 'JSConstructADialogActn';
  FMenuItem := TMenuItem.Create(lOwner);
  FMenuItem.Name := 'JSConstructADialogItem';
  FMenuItem.Action := FAction;

  {$IFDEF BDS}
  try
    (BorlandIDEServices as INTAServices).AddActionMenu('IDEToolsItem', FAction, FMenuItem);
  except
    try
      (BorlandIDEServices as INTAServices).AddActionMenu('mnuPatternOrganizer', FAction, FMenuItem);
    except
      try
        (BorlandIDEServices as INTAServices).AddActionMenu('ToolsMenu', FAction, FMenuItem, True, True);
      except
        ShowErrorMessage('Unable to locate a suitable menu item to attach Construct A Dialog to. Please contact support (mail@lmdsupport.com) for further assistance');
      end;
    end;
  end;
  {$ELSE}
  InstallMenuItem(FMenuItem, FAction);
  {$ENDIF BDS}

  // key binding

  _Index := (BorlandIDEServices as IOTAKeyboardServices).AddKeyboardBinding(Self);

end;

destructor TCADAddIn.Destroy;
begin
  FreeAndNil(FAction);
  FreeAndNil(FMenuItem);
  if _Index > -1 then
    (BorlandIDEServices as IOTAKeyboardServices).RemoveKeyboardBinding(_Index);
  inherited;
end;

function TCADAddIn.GetBindingType: TBindingType;
begin
  Result := btPartial;
end;

function TCADAddIn.GetDisplayName: string;
begin
  Result := 'LMD DialogPack';
end;

function TCADAddIn.GetName: string;
begin
  Result := 'LMD Innovative - LMD DialogPack';
end;

procedure TCADAddIn.InsertCode(aSettings: TDlgSettings);
var
  lSrc: IOTASourceEditor;
  lMod: IOTAModule;
  lWrite: IOTAEditWriter;
  lView: IOTAEditView;
  lCharPos: TOTACharPos;
  lEditPos: TOTAEditPos;
  {$IFDEF DELPHI2009}
  Utf8Source: UTF8String;
  {$ENDIF DELPHI2009}
begin
  lMod := (BorlandIDEServices as IOTAModuleServices).CurrentModule;
  {$IFNDEF DELPHI5}
  if (lMod <> nil) and (lMod.CurrentEditor <> nil) and
    (Supports(lMod.CurrentEditor, IOTASourceEditor, lSrc)) then
  {$ELSE}
  if Supports(GetCurrentSourceEditor, IOTASourceEditor, lSrc) then
  {$ENDIF DELPHI5}
  begin
    lView := lSrc.EditViews[0];
    lWrite := lSrc.CreateUndoableWriter;
    lEditPos := lView.CursorPos;
    lView.ConvertPos(True, lEditPos, lCharPos);
    lWrite.CopyTo(lView.CharPosToPos(lCharPos));
    {$IFNDEF DELPHI5}
      {$IFDEF DELPHI2009}
      Utf8Source := Utf8Encode(aSettings.ToString);
      lWrite.Insert(PAnsiChar(Utf8Source));
      {$ELSE}
      lWrite.Insert(PChar(AnsiToUtf8(aSettings.ToString)));
      {$ENDIF DELPHI2009}
    {$ELSE}
    lWrite.Insert(PChar((aSettings.ToString)));
    {$ENDIF DELPHI5}
    lView.MoveViewToCursor;
    lView.Paint;
  end;
end;

class function TCADAddIn.Install: TCADAddIn;
begin
  result := TCADAddIn.Create;
end;

initialization
  FCADAddIn := nil;

finalization
  {$IFNDEF BDS}
  FOldTimer.Free;
  {$ENDIF BDS}
  
end.
