unit ElFileUtils;
{$I lmdcmps.inc}
{###############################################################################

ElFileUtils unit
----------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Dialogs, Classes, Masks;

function GetWideCurrentDir: WideString;
function SetWideCurrentDir(const Dir: WideString): Boolean;
function CreateWideDir(const Dir: WideString): Boolean;
function RemoveWideDir(const Dir: WideString): Boolean;
function GetWideModuleName(Module: HMODULE): WideString;


Type

 TCallbackBuildFileListFromMasks = procedure(const Directory, FileName:String; FileHandle: THandle; var Ignore:Boolean; Data:{$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}; var Abort:Boolean);

function BuildFileListFromMasks(
  FileMasks, RecursiveDirectories, Directories:TStrings;
  IgnoreBadMasks:Boolean;
  CB:TCallbackBuildFileListFromMasks;
  Data:{$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}): TStrings;

function BuildFileListFromMasksThread(
  FileMasks, RecursiveDirectories, Directories:String;
  IgnoreBadMasks:Boolean;
  CB:TCallbackBuildFileListFromMasks;
  Data:{$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}): String;

function SelectFiles(Prompt : String; Filter : string; DefaultExt : string; InitialDir : string; AllowMultiSelect : boolean) : string;


implementation

uses
  {$ifdef CLR}
  System.Text,
  System.Threading,
  {$endif}
  LMDProcs,
  LMDUnicode;

function BuildFileListFromMasksThread(
  FileMasks, RecursiveDirectories, Directories:String;
  IgnoreBadMasks:Boolean;
  CB:TCallbackBuildFileListFromMasks;
  Data:{$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}
):String;
 var
   LFileMasks, LRecursiveDirectories, LDirectories, LResult:TStrings;
begin
  LFileMasks := TStringList.Create;
  LRecursiveDirectories := TStringList.Create;
  LDirectories := TStringList.Create;
  try
    LFileMasks.Text := FileMasks;
    LRecursiveDirectories.Text := RecursiveDirectories;
    LDirectories.Text := Directories;
    LResult := BuildFileListFromMasks(
      LFileMasks, LRecursiveDirectories, LDirectories,
      IgnoreBadMasks,  CB, Data
    );
    if Assigned(LResult) then
      Result := LResult.Text
    else
      SetLength(Result, 0);
  finally
    LFileMasks.Free;
    LRecursiveDirectories.Free;
    LDirectories.Free;
  end;
end;

function BuildFileListFromMasks(
  FileMasks, RecursiveDirectories, Directories:TStrings;
  IgnoreBadMasks:Boolean;
  CB:TCallbackBuildFileListFromMasks;
  Data:{$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}
):TStrings;
  var
    MaskList:TList;
    i :integer;
  procedure BuilMaskList;
    var
      i :integer;
      Mask:TMask;
      sMask:String;
  begin
    Mask := nil;
    try
    // Buil MaskList
    for i:= 0 to FileMasks.Count-1 do begin
      // check current mask:
      sMask := FileMasks[i];
      if Length(sMask)=0 then
        continue; // skip empty lines
      try
        Mask := TMask.Create(sMask);
      except
        if not IgnoreBadMasks then
          raise
        else
          continue; // ignore bad mask
      end;
      try
      // check syntax mask
        Mask.Matches('test');
      except
        on E:Exception do
        begin
          if not IgnoreBadMasks then
          begin
{$IFDEF CLR}
// ToDo Alex
{$ELSE}
            E.Message := ('ERROR in Mask "'+FileMasks[i]+'" is syntactically invalid:'+E.Message);
{$ENDIF}

            raise E;
          end
          else
            continue; // ignore bad mask
        end;
      end;
      MaskList.Add(Mask);
      Mask := nil;
    end;
    finally
      Mask.Free;
    end;
  end;//of: procedure BuilMaskList
  procedure LoopFilesCustom(StartDir: String; Recursive:Boolean);
   var
     Search :SysUtils.TSearchRec;
     Ignored, vAbort :Boolean;
     function MatchesByMaskList(Const Value:String):Boolean;
       var i:Integer;
     begin
       for i:=0 to MaskList.Count-1 do
       begin
         if TMask(MaskList[i]).Matches(Value) then
         begin
           Result := True;
            exit;
         end;
       end;
       Result := False;
     end;
  begin
    if Length(StartDir)=0 then
      exit;
    if StartDir[Length(StartDir)] <> '\' then
      StartDir := startdir + '\';
    if (SysUtils.FindFirst(StartDir + '*.*', faAnyFile, Search) = 0) then
    repeat
      if (Search.Name[1] <> '.' ) then
        if ((Search.Attr and faDirectory) > 0) then
        begin // Subdirectories:
          if Recursive then
            LoopFilesCustom(StartDir + Search.Name, Recursive);
        end
        else  // Files:
        begin
          //Ignored := not MatchesByMaskList(StartDir + Search.Name);
          Ignored := not MatchesByMaskList(Search.Name);
          if not Ignored then
          begin
            if Assigned(CB) then
            begin
              Ignored := False;
              vAbort := False;
              {$warnings off}// Symbol 'FindHandle' is specific to a platform
              CB(StartDir, Search.Name, Search.FindHandle, Ignored, Data, vAbort);
              {$warnings on}
              if vAbort then
                SysUtils.Abort;
            end;
            if not Ignored then
              Result.Add(StartDir + Search.Name);
            sleep(0);
          end;
        end;
    until FindNext(Search) <> 0;
    SysUtils.FindClose(Search);
  end;//of: function LoopFilesCustom
begin
  Result := TStringList.Create;
  try
    // check parameters
    if (FileMasks=nil)or(FileMasks.Count=0)or((RecursiveDirectories=nil)and(Directories=nil)) then
      exit;
    if Assigned(RecursiveDirectories) then
      i := RecursiveDirectories.Count
    else
      i:=0;
    if Assigned(Directories) then
      inc(i,Directories.Count);
    if i=0 then
      exit;
    MaskList := TList.Create;
    try
      BuilMaskList;
      if Assigned(RecursiveDirectories) then
      begin
        for i:=0 to RecursiveDirectories.Count-1 do
          LoopFilesCustom(RecursiveDirectories[i], True);
      end;
      if Assigned(Directories) then
      begin
        for i:=0 to Directories.Count-1 do
          LoopFilesCustom(Directories[i], False);
      end;
    finally
      for i:=MaskList.Count-1 downto 0 do
        TMask(MaskList[i]).Free;
      MaskList.Free;
    end;
  except
    on e:EAbort do
    begin
    end
    else
    begin
      Result.Free;
      Result := nil;
      raise;
    end;
  end;
end;

function GetWideCurrentDir: WideString;
{$IFDEF CLR}
var
  Buffer: StringBuilder;
begin
  Buffer := StringBuilder.Create(MAX_PATH);
  LMDWideSetString(Result, Buffer.ToString, 0, GetCurrentDirectoryW(MAX_PATH, Buffer));
end;
{$ELSE}
var
  Buffer: array[0..MAX_PATH - 1] of WideChar;
begin
  LMDWideSetString(Result, Buffer, GetCurrentDirectoryW(MAX_PATH, Buffer));
end;
{$ENDIF}

function SetWideCurrentDir(const Dir: WideString): Boolean;
{$IFDEF CLR}
// ToDo Alex   --> available on all systems? Shouldn't there be dynamic loading?
begin
  Result := SetCurrentDirectory(Int_RefW(Dir));
end;
{$ELSE}
begin
  Result := SetCurrentDirectoryW(PWideChar(Dir));
end;
{$ENDIF}

function CreateWideDir(const Dir: WideString): Boolean;
{$IFDEF CLR}
// ToDo Alex   --> available on all systems? Shouldn't there be dynamic loading?
begin
  Result := CreateDirectory(Int_RefW(Dir), nil);
end;
{$ELSE}
begin
  Result := CreateDirectoryW(PWideChar(Dir), nil);
end;
{$ENDIF}

function RemoveWideDir(const Dir: WideString): Boolean;
{$IFDEF CLR}
// ToDo Alex   --> available on all systems? Shouldn't there be dynamic loading?
begin
  Result := RemoveDirectoryW(Int_RefW(Dir));
end;
{$ELSE}
begin
  Result := RemoveDirectoryW(PWideChar(Dir));
end;
{$ENDIF}

function GetWideModuleName(Module: HMODULE): WideString;
{$IFDEF CLR}
// ToDo Alex   --> available on all systems? Shouldn't there be dynamic loading?
var
  ModName: StringBuilder;
begin
  ModName := StringBuilder.Create(MAX_PATH);
  LMDWideSetString(Result, ModName.ToString, 0, Windows.GetModuleFileNameW(Module, ModName, MAX_PATH));
end;
{$ELSE}
var
  ModName: array[0..MAX_PATH] of WideChar;
begin
  LMDWideSetString(Result, ModName, Windows.GetModuleFileNameW(Module, ModName, MAX_PATH));
end;
{$ENDIF}

function SelectFiles(Prompt : String; Filter : string; DefaultExt : string; InitialDir : string; AllowMultiSelect : boolean) : string;
var OpenDlg : TOpenDialog;
begin
  OpenDlg := TOpenDialog.Create(nil);
  OpenDlg.InitialDir := InitialDir;
  OpenDlg.DefaultExt := DefaultExt;
  OpenDlg.Title := Prompt;
  OpenDlg.Filter := Filter;
  OpenDlg.Options := [ofReadOnly, ofHideReadOnly, ofExtensionDifferent, ofFileMustExist,
    ofShareAware, ofNoTestFileCreate, ofEnableSizing];
  if AllowMultiSelect then
    OpenDlg.Options := OpenDlg.Options + [ofAllowMultiSelect];
  if OpenDlg.Execute then
  begin
    if AllowMultiSelect then
      result := OpenDlg.Files.Text
    else
      result := OpenDlg.FileName;
  end;
end;

end.
