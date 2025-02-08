unit LMDShLink;
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

LMDShLink unit (DS)
------------------------
Contains TLMDShellLink component, which allows operate with windows shorcuts.

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, Controls, ShlObj, ComObj, ActiveX, Menus,
  ComCtrls, LMDShFolder, lmdshbase;

type

{ ***************************** class TLMDShellLink ************************** }
  TLMDShellLinkShowCmd = (SW_SHOWNORMAL_, SW_SHOWMAXIMIZED_, SW_SHOWMINIMIZED_);

  TLMDShellLink = class(TLMDShellComponent)
  private
    dwPathFlags: DWORD;
    ISL: IShellLink;
    FIconIndex: Integer;
    FArguments: String;
    FIconLocation: String;
    FDescription: String;
    FWorkingDirectory: String;
    FPath: String;
    FHotKey: TShortCut;
    FShowCmd: TLMDShellLinkShowCmd;
    FFileName: TFileName;
    FIDList: PItemIDList;
    procedure SetArguments(const Value: String);
    procedure SetHotKey(const Value: TShortCut);
    procedure SetIconIndex(const Value: Integer);
    procedure SetShowCmd(const Value: TLMDShellLinkShowCmd);
    procedure SetWorkingDirectory(const Value: String);
    procedure SetFileName(const Value: TFileName);
    procedure SetPath(const Value: String);
    procedure Changed;
    procedure SetDescription(const Value: String);
    procedure SetIconLocation(const Value: String);
    procedure SetIDList(const Value: PItemIDList);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Load(szFileName: TFileName; dwMode: DWORD = STGM_READ): Boolean;
      overload;
    function Save(szFileName: TFileName): Boolean; overload;
    function Load: Boolean;overload;
    function Save: Boolean;overload;
    procedure Resolve(Wnd: HWND; fFlags: DWORD);
    procedure Reset;
    property IDList : PItemIDList read FIDList write SetIDList;
  published
    property  FileName: TFileName read FFileName write SetFileName;
    property  Path: String read FPath write SetPath;
    property  Description: String read FDescription write SetDescription;
    property  IconLocation: String read FIconLocation write SetIconLocation;
    property  IconIndex: Integer read FIconIndex write SetIconIndex default 0;
    property  Arguments: String read FArguments write SetArguments;
    property  HotKey: TShortCut read FHotKey write SetHotKey default 0;
    property  ShowCmd: TLMDShellLinkShowCmd read FShowCmd write SetShowCmd
      default SW_SHOWNORMAL_;
    property  WorkingDirectory: String read FWorkingDirectory
      write SetWorkingDirectory;
  end;

   // nice helper
  function LMDShellOpenDOSWindow(const usePath:String=''):Integer;

procedure LMDCreateShortCut(const FilePath, ShortCutPath, Description,
  IconLocation, Arguments, WorkingDirectory : string; IconIndex: Integer;
  HotKey: TShortCut; ShowCmd: TLMDShellLinkShowCmd); overload;

procedure LMDCreateShortCut(IDList: PItemIDList; const ShortCutPath, Description,
  IconLocation, Arguments, WorkingDirectory : string; IconIndex: Integer;
  HotKey: TShortCut; ShowCmd: TLMDShellLinkShowCmd); overload;

implementation

uses
  ShellApi, Forms,
  LMDShMisc, LMDProcs;

{ ************************* LMDShellOpenDOSWindow *****************************}
function LMDShellOpenDOSWindow(const usePath:String=''):Integer;
var
  tmp:String;
begin
  with TLMDShellLink.Create(nil) do
    try
      // separate between Windows and NT
       if (SysUtils.Win32PlatForm=VER_PLATFORM_WIN32_NT) then
         Path:='cmd.exe'
       else
         Path:='command.com';
      WorkingDirectory:=usePath;
      if Application.ExeName<>'' then
        tmp:=ExtractFilePath(Application.ExeName)+'startdos';
      Save(tmp+'.lnk');

      Result := ShellExecute(Application.Handle, int_Ref('open'), int_Ref(tmp),
            int_Ref(''), nil, SW_NORMAL);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDCreateShortCut(const FilePath, ShortCutPath, Description,
  IconLocation, Arguments, WorkingDirectory : string; IconIndex: Integer;
  HotKey: TShortCut; ShowCmd: TLMDShellLinkShowCmd);
var
  SC : TLMDShellLink;
begin
  SC := TLMDShellLink.Create(nil);
  SC.FileName := ExtractFileName(FilePath);
  SC.Path := ExtractFilePath(FilePath);
  SC.Description := Description;
  SC.IconLocation := IconLocation;
  SC.IconIndex := IconIndex;
  SC.Arguments := Arguments;
  SC.HotKey := HotKey;
  SC.ShowCmd := ShowCmd;
  SC.WorkingDirectory := WorkingDirectory;
  SC.Save(ShortCutPath);
  SC.Free;
end;

{------------------------------------------------------------------------------}
procedure LMDCreateShortCut(IDList: PItemIDList; const ShortCutPath, Description,
  IconLocation, Arguments, WorkingDirectory : string; IconIndex: Integer;
  HotKey: TShortCut; ShowCmd: TLMDShellLinkShowCmd);
var
  SC : TLMDShellLink;
begin
  SC := TLMDShellLink.Create(nil);
  SC.IDList := IDList;
  SC.Description := Description;
  SC.IconLocation := IconLocation;
  SC.IconIndex := IconIndex;
  SC.Arguments := Arguments;
  SC.HotKey := HotKey;
  SC.ShowCmd := ShowCmd;
  SC.WorkingDirectory := WorkingDirectory;
  SC.Free;
end;

{ TLMDShellLink }

{ ***************************** class TLMDShellLink ************************** }
function HotKeyToShortCut(Value: Longint): TShortCut;
var
  FModifiers : THKModifiers;
begin

  Byte(FModifiers) := LoWord(HiByte(Value));

  Result := LoWord(LoByte(Value));
  if hkShift in FModifiers then Inc(Result, scShift);
  if hkCtrl in FModifiers then Inc(Result, scCtrl);
  if hkAlt in FModifiers then Inc(Result, scAlt);
end;

{------------------------------------------------------------------------------}
function ShortCutToHotKey(Value: TShortCut):Word;
var
  FModifiers : THKModifiers;
begin
  Result := Value and not (scShift + scCtrl + scAlt);
  FModifiers := [];
  if Value and scShift <> 0 then Include(FModifiers, hkShift);
  if Value and scCtrl <> 0 then Include(FModifiers, hkCtrl);
  if Value and scAlt <> 0 then Include(FModifiers, hkAlt);
  Result := MakeWord(Result, Byte(FModifiers));
end;

{----------------------------- Private ----------------------------------------}
procedure TLMDShellLink.Changed;
begin
  if FileExists(FFileName) and (not (csLoading in ComponentState)) then
    Save(FFileName);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.SetArguments(const Value: String);
begin
  FArguments:= Value;
  Changed;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.SetDescription(const Value: String);
begin
  FDescription:= Value;
  Changed;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.SetFileName(const Value: TFileName);
begin
  FFileName:= Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.SetHotKey(const Value: TShortCut);
begin
  FHotKey := Value;
  Changed;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.SetIconIndex(const Value: Integer);
begin
  FIconIndex:= Value;
  Changed;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.SetIconLocation(const Value: String);
begin
  FIconLocation:= Value;
  Changed;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.SetIDList(const Value: PItemIDList);
begin
  FIDList := Value;
  Changed;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.SetPath(const Value: String);
begin
  FPath:= Value;
  Changed;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.SetShowCmd(const Value: TLMDShellLinkShowCmd);
begin
  FShowCmd:= Value;
  Changed;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.SetWorkingDirectory(const Value: String);
begin
  FWorkingDirectory:= Value;
  Changed;
end;

{------------------------------ Public ----------------------------------------}

constructor TLMDShellLink.Create(AOwner: TComponent);
begin
  inherited;
  Reset;
  FIDList := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellLink.Destroy;
begin
  ISL:= nil;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDShellLink.Load: Boolean;
begin
  Result:= Load(FFileName);
end;

{------------------------------------------------------------------------------}
function TLMDShellLink.Load(szFileName: TFileName; dwMode: DWORD = STGM_READ): Boolean;
const
  BufSize = 1024;
var

  Buff: array [0..BufSize] of Char;

  pfd: WIN32_FIND_DATA;
  iIndex: Integer;
  szTmp: WideString;
  wHotKey: WORD;
begin
  try
    szTmp:= szFileName;

    OleCheck((ISL As IPersistFile).Load(PWideChar(szTmp), dwMode));
    OleCheck(ISL.GetPath(Buff, SizeOf(Buff), pfd, dwPathFlags));
    FPath:= Buff;
    ISL.GetIconLocation(Buff, SizeOf(Buff), iIndex);
    FIconLocation:= Buff;
    FIconIndex:= iIndex;
    ISL.GetDescription(Buff, SizeOf(Buff));
    FDescription:= Buff;
    ISL.GetArguments(Buff, SizeOf(Buff));
    FArguments:= Buff;
    ISL.GetHotkey(wHotKey);
    FHotKey:=HotKeyToShortCut(wHotKey);
    ISL.GetWorkingDirectory(Buff,SizeOf(Buff));
    FWorkingDirectory:= Buff;

    ISL.GetShowCmd(iIndex);
    case iIndex of
      Windows.SW_SHOWNORMAL: FShowCmd:= SW_SHOWNORMAL_;
      Windows.SW_SHOWMINIMIZED: FShowCmd:= SW_SHOWMINIMIZED_;
      Windows.SW_SHOWMAXIMIZED: FShowCmd:= SW_SHOWMAXIMIZED_;
    end;
    Result:= True;
  except
    Result:= False;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShellLink.Save(szFileName: TFileName): Boolean;
var
  szTmp : WideString;
  wCmdShow : Integer;
begin
  try
    ISL.SetArguments(int_Ref(FArguments));
    ISL.SetDescription(int_Ref(FDescription));
    if assigned(FIDList) then ISL.SetIDList(FIDList)
    else ISL.SetPath(int_Ref(FPath));
    ISL.SetWorkingDirectory(int_Ref(FWorkingDirectory));
    ISL.SetHotkey(ShortCutToHotKey(FHotKey));
    ISL.SetIconLocation(int_Ref(FIconLocation),FIconIndex);
    case FShowCmd of
      SW_SHOWNORMAL_: wCmdShow:= Windows.SW_SHOWNORMAL;
      SW_SHOWMAXIMIZED_: wCmdShow:= Windows.SW_SHOWMAXIMIZED;
      SW_SHOWMINIMIZED_: wCmdShow:= Windows.SW_SHOWMINIMIZED;
    else
      wCmdShow := 0;
    end;
    ISL.SetShowCmd(wCmdShow);
    szTmp:= szFileName;
    OleCheck((ISL as IPersistFile).Save(int_RefW(szTmp), True));
    Result:= True;
  except
    Result:= False;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShellLink.Save: Boolean;
begin
  Result:= Save(FFileName);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.Resolve(Wnd: HWND; fFlags: DWORD);
begin
  OleCheck(ISL.Resolve(Wnd, fFlags));
end;

{------------------------------------------------------------------------------}
procedure TLMDShellLink.Reset;
const
  SID_IShellLink  = '{00021401-0000-0000-C000-000000000046}';
begin
  ISL:= nil;

  ISL:= CreateComObject(CLSID_ShellLink) as IShellLink;

  dwPathFlags:= SLGP_RAWPATH;
  FFilename:= '';
  FHotkey:= 0;
  FPath:= '';
  FDescription:= '';
  FIconLocation:= '';
  FIconIndex:= 0;
  FArguments:= '';
  FShowCMD:= SW_SHOWNORMAL_;
  FWorkingDirectory:= '';
end;

end.
