unit LMDSendKeys;
{$I lmdcmps.Inc}

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

LMDSendKeys unit (RM)
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, LMDTypes, LMDCustomComponent;

type
  TLMDSendKeyMode = (kmhold, kmDown, kmUp);

  TLMDSendKeys = class(TLMDCustomComponent)
  private
    FHandle,
    FProcess   : THandle;
    FLast,
    FCaption   : String;
    FFilename  : String;
    FActivateBeforeKey,
    FAutoActivate,
    FException : Boolean;

  protected
  public
    constructor Create (aOwner : TComponent); override;
    destructor  Destroy; override;
    procedure SendKeys(s:String;wait:Boolean=false);
    procedure SendFile (filename : String;wait:Boolean=false);
    function AppActivate(s:String=''):Boolean;
    function Shell(s:string):Boolean;
    function ShellTerminate:Boolean;

    property Caption:String read FCaption;
    property Process:THandle read FProcess;
    property FileName:String read FFilename;
    property WndHandle:THandle read FHandle write FHandle;
  published
    property About;
    property AutoActivate   : Boolean read FAutoActivate write FAutoActivate default false;
    property ActivateBeforeKey : Boolean read FActivateBeforeKey write FActivateBeforeKey default false;
    property RaiseException : Boolean read FException write FException default false;
  end;

implementation

uses

  SysUtils,
  Messages,
  LMDProcs,
  shellapi;
(*
SendString ::= input { input}
input ::= char | specialChar | '{' chars [repeat] '}'
char ::= 'A'..'Z', ....
specialChar ::= '+' | '^' | % | '('
chars ::= extchar { extchar }
extChar := char | specialChar | '{'
repeat ::= digit { digit }
*)

var
  LMDWND:Hwnd;

const
  SpecialKeys: set of byte=[VK_Left, VK_Right, VK_Up, VK_Down, VK_Home,VK_End,
                            VK_Prior,VK_Next, VK_Insert,VK_Delete];

{-------------------------- helper --------------------------------------------}

function LMDEnumerateWindows(hWnd: HWND; lParam: LPARAM): BOOL;stdcall;
var
   tmp:array[0..255] of char;  // this holds the window text
begin
   result:=True;
   if (GetWindowText(hWnd, tmp, 255)=0) then exit;
   if AnsiStrComp(tmp, PChar(lparam))=0 then
     begin
       result:=false;
       LMDWND:=hwnd;
     end;
end;

{***************************** Public *****************************************}
{------------------------------------------------------------------------------}
function TLMDSendKeys.AppActivate(s:String):Boolean;

  function Show(wnd:THandle):Boolean;
  begin
    result:=false;
    if wnd=0 then exit;
    SendMessage(wnd, WM_SYSCOMMAND, SC_HOTKEY, wnd);
    SendMessage(wnd, WM_SYSCOMMAND, SC_RESTORE, wnd);
    // RM 03-July-01
    SetForegroundWindow(wnd);
    result:=true;
  end;

begin
  //let's store the last activated window for property AutoActivate
  FLast := s;
  if FProcess<>0 then
    result:=show(Fhandle)
  else
    begin
      LMDWND:=FindWindow(nil,Int_Ref(s));
      If (LMDWND=0) then
        begin

          EnumWindows(@LMDEnumerateWindows, TLMDPtrInt(PChar(s)));

        end;
      result:=show(LMDWND);
    end;
end;

{------------------------------------------------------------------------------}

function TLMDSendKeys.Shell(s:String):Boolean;
var

  buffer:array[0..500] of char;

//  StartUpInfo: TStartUpInfo;        // holds startup information
//  ProcessInfo: TProcessInformation; // holds process information
  SHI : TShellExecuteInfo;
begin
  result:=false;
  FCaption:='';
  FFilename:='';
  FHandle:=0;
  FProcess:=0;

  if s='' then exit;

  FindExecutable(PChar(s),nil,@Buffer);
  s:=StrPas(buffer);

  if s='' then exit;

  ZeroMemory(@SHI, SizeOf(SHI));
  SHI.cbSize := SizeOf(SHI);

  SHI.fMask := SEE_MASK_NOCLOSEPROCESS;
  SHI.nShow := SW_SHOWNORMAL;
  SHI.lpIDList := nil;
  SHI.lpFile := Int_Ref(s);
  SHI.lpVerb := Int_Ref('open');

  Result := ShellExecuteEx(@SHI);

  if  (SHI.hProcess = 0) or (SHI.hProcess = INVALID_HANDLE_VALUE)  then
    exit;

  FProcess := SHI.hProcess;

(*
  FindExecutable(PChar(s),nil,@Buffer);
  s:=StrPas(buffer);

  {initialize the startup info structure}
  FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
  StartupInfo.cb := SizeOf(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_SHOWNORMAL;

  result:=CreateProcess(int_Ref(s),nil, nil, nil, false, NORMAL_PRIORITY_CLASS,
      int_Ref(''), int_Ref(''), StartupInfo, ProcessInfo);
  if not result then exit;

  FProcess:=ProcessInfo.HProcess;
*)
  //Wait until application is loaded
  WaitForInputIdle(FProcess, infinite);

  if result then
    begin
      FHandle:=GetForeGroundWindow;
      FFilename:=s;
      GetWindowText(FHandle, buffer, 500);

      GetWindowText(FHandle, buffer, 500);
      FCaption:=StrPas(buffer);

    end;
end;

{------------------------------------------------------------------------------}
function TLMDSendKeys.ShellTerminate:Boolean;
var
  ExitCode: DWORD;

begin
  result:=false;
  if FProcess<>0 then
    begin
      TerminateProcess(FProcess, 10);
      GetExitCodeProcess(FProcess, ExitCode);
      if ExitCode<>STILL_ACTIVE then
        begin
          CloseHandle(FProcess);
          FCaption:='';
          FHandle:=0;
          FProcess:=0;
          FFileName:='';
          Result:=True;
        end;
    end;
end;

{------------------------------------------------------------------------------}
constructor TLMDSendKeys.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FAutoActivate := false;
  FActivateBeforeKey := false;
  FException := false;
  FLast := '';
end;

{------------------------------------------------------------------------------}
destructor  TLMDSendKeys.Destroy;
begin
  if  FProcess <> 0 then
    CloseHandle(FProcess);
  inherited ;
end;

{------------------------------------------------------------------------------}
procedure TLMDSendKeys.SendKeys(s:String;wait:Boolean);
var
  ch : Char;
  ss : TShiftState;
  keepShift : Boolean;
  keyToSend : Word;
  rep : Integer;

  procedure getChar;
  begin

    ch := s[1];

    delete (s, 1, 1);
  end;

  function getSpecial : Integer;
  var
    sp : String;
  begin
    result := -1;
    sp := '';
    while not (AnsiChar(ch) in ['}',' ']) do
      begin
        getChar;
        if not (AnsiChar(ch) in ['}',' ']) then
          sp := sp + ch;
      end;
    sp := AnsiUpperCase (sp);

    if (sp = 'BACKSPACE') or (sp = 'BKSP') or (sp = 'BS') then
      result := VK_BACK;
    if (sp = 'BREAK') then
      result := VK_PAUSE;
    if (sp ='SNAPSHOT') then
      result := VK_SNAPSHOT;
    if (sp = 'DELETE') or (sp = 'DEL') then
      result := VK_DELETE;
    if (sp = 'DOWN') then
      result := VK_DOWN;
    if (sp = 'UP') then
      result := VK_UP;
    if (sp = 'LEFT') then
      result := VK_LEFT;
    if (sp = 'RIGHT') then
      result := VK_RIGHT;
    if (sp = 'CAPSLOCK') then
      result := VK_CAPITAL;
    if (sp = 'END') then
      result := VK_END;
    if (sp = 'ENTER') then
      result := VK_RETURN;
    if (sp = 'ESC') then
      result := VK_ESCAPE;
    if (sp = 'HELP') then
      result := VK_HELP;
    if (sp = 'HOME') then
      result := VK_HOME;
    if (sp = 'INSERT') or (sp = 'INS') then
      result := VK_INSERT;
    if (sp = 'NUMLOCK') then
      result := VK_NUMLOCK;
    if (sp = 'PGDN') then
      result := VK_NEXT;
    if (sp = 'PGUP') then
      result := VK_PRIOR;
    if (sp = 'PRTSC') then
      result := VK_PRINT;
    if (sp = 'SCROLLOCK') then
      result := VK_SCROLL;
    if (sp = 'TAB') then
       result := VK_TAB;
    if (sp = 'SPACE') then
       result := VK_SPACE;
    if (sp = 'F1') then
      result := VK_F1;
    if (sp = 'F2') then
      result := VK_F2;
    if (sp = 'F3') then
      result := VK_F3;
    if (sp = 'F4') then
      result := VK_F4;
    if (sp = 'F5') then
      result := VK_F5;
    if (sp = 'F6') then
      result := VK_F6;
    if (sp = 'F7') then
      result := VK_F7;
    if (sp = 'F8') then
      result := VK_F8;
    if (sp = 'F9') then
      result := VK_F9;
    if (sp = 'F10') then
      result := VK_F10;
    if (sp = 'F11') then
      result := VK_F11;
    if (sp = 'F12') then
      result := VK_F12;
    if (sp = 'F13') then
      result := VK_F13;
    if (sp = 'F14') then
      result := VK_F14;
    if (sp = 'F15') then
      result := VK_F15;
    if (sp = 'F16') then
      result := VK_F16;
    if (sp = '^') then
      result := VkKeyScan('^');
    if (sp = '%') then
      result := VkKeyScan('%');
    if (sp = '+') then
      result := VkKeyScan('+');
    if (sp = '(') then
      result := VkKeyScan('(');
    if (sp = ')') then
      result := VkKeyScan(')');
    if (sp = '{') then
      result := VkKeyScan('{');
    if result = -1 then //any other char (e.g. {i 10} repeats i 10 times
      result := VkKeyScan(sp[1]);
    if ch = ' ' then
      begin //next must be an integer
        sp := '';
        while ch <> '}' do
          begin
            while ch <> '}' do
              begin
                getChar;
                if ch <> '}' then
                  sp := sp + ch;
              end;
            try
              rep := StrToInt (sp) - 1;
            except
              if FException then
                raise Exception.Create('Invalid Integer identifier!');
            end;
          end;
      end;
  end;

  //Make Keystroke
  procedure MakeKeyStroke(key:byte; mode:TLMDSendkeyMode);

    procedure CreateEvent(VKey, ScanCode:Byte;Flags:Longint);
    var
      tmp:TMsg;
    begin
      keybd_event(VKey, ScanCode, Flags,0);
      If Wait then
        While (PeekMessage(tmp,0,WM_KEYFIRST, WM_KEYLAST, PM_REMOVE)) do
          begin
            TranslateMessage(tmp);
            DispatchMessage(tmp);
          end;
    end;

  var
    flag:LongInt;
    Scancode:Byte;
  begin
    flag:=0;
    // Verhalten bei NumLock?

    ScanCode:=LoByte(MapVirtualKey(Key,0));
    if key in SpecialKeys then flag:=KEYEVENTF_EXTENDEDKEY;

    if mode in [kmDown, kmHold] then
      CreateEvent(key,Scancode,flag);

    if mode in [kmDown, kmUp] then
      CreateEvent(key,ScanCode,flag or KEYEVENTF_KEYUP);
  end;

  procedure SendKey(key:Word; mode:TLMDSendkeyMode; rep:Integer);
  var
    i:Integer;
  begin
    //scenario: many keys to send to app, user yould deactivate target prog
    //activate it again before sending key
    if FActivateBeforeKey then
      AppActivate (FLast);

    if (key=$FFFF) then
      If FException then
        raise Exception.Create('Invalid key identifier')
      else
        exit;
    if HiByte(Key) AND 1=1 then MakeKeyStroke(VK_SHIFT, kmHold);
    if HiByte(Key) AND 2=2 then MakeKeyStroke(VK_CONTROL, kmHold);
    if HiByte(Key) AND 4=4  then MakeKeyStroke(VK_MENU, kmHold);
    for i:=0 to rep do MakeKeyStroke(key, mode);
    if HiByte(Key) AND 1=1 then MakeKeyStroke(VK_SHIFT, kmUp);
    if HiByte(Key) AND 2=2 then MakeKeyStroke(VK_CONTROL, kmUp);
    if HiByte(Key) AND 4=4  then MakeKeyStroke(VK_MENU, kmUp);
  end;

  procedure ResetMainKeys;
  begin
    if not KeepShift then
      begin
        If ssShift in ss then MakeKeyStroke(VK_SHIFT, kmUp);
        If ssCtrl in ss then MakeKeyStroke(VK_CONTROL, kmUp);
        If ssAlt in ss then MakeKeyStroke(VK_MENU, kmUp);
        ss:=[];
      end;
  end;

begin
  //let's try to auto activate the app -> it must be activated with
  //activate app before, or must be created with this component's shell function
  if FAutoActivate then
    AppActivate (FLast);
  ss := [];
  keepshift:=false;
  while s <> '' do
    begin
      rep := 0;
      getChar;
      case ch of
        '{' : begin
                keyToSend := getSpecial;
                SendKey(keyToSend, kmdown, rep);
              end;
        '~' : begin
                ResetMainKeys;
                MakeKeyStroke(VK_RETURN,kmdown);
              end;
        '^' : begin
                include (ss, ssCtrl);
                MakeKeyStroke (VK_CONTROL, kmhold);
              end;
        '+' : begin
                include (ss, ssShift);
                MakeKeyStroke(VK_SHIFT, kmhold);
              end;
        '%' : begin
                include (ss, ssAlt);
                MakeKeyStroke(VK_MENU, kmhold);
              end;
        '(' : begin
                keepShift := true;
              end;
        ')' : if keepShift then
                begin
                  keepShift := false;
                  ResetMainKeys;
                 end
              else
                SendKey(VkKeyScan(')'), kmdown, 0);
      else
        begin
          keyToSend := VkKeyScan(ch);
          SendKey(keyToSend, kmdown, 0);
        end;
      end;
    end;
  keepshift:=false;
  ResetMainKeys;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSendKeys.SendFile (filename : String; wait : Boolean);
var
  f : TFileStream;
  s : String;

begin
  //create file to read from
  f := TFileStream.Create (filename, fmOpenRead or fmShareDenyWrite);
  try

    //set size of data(cahr) buffer
    SetLength (s, f.size);
    //read data
    f.Read (s, f.Size);

  finally
    //free file
    f.Free;
  end;
  //send data
  SendKeys (s, wait);
end;

end.
