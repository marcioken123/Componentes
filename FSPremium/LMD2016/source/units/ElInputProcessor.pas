unit ElInputProcessor;
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

ElInputProcessor unit
---------------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  LMDUnicodeStrings,
  SysUtils,
  Messages,
  Windows,
  Graphics,
  Dialogs,
  Forms,
  Imm,
  Classes,
  LMDTypes,
  LMDSysIn,
  LMDStrings,
  LMDUnicode,
  LMDObjectList;

type
  TElEditCharCase = (eecNormal, eecUpperCase, eecLowerCase);
  TIMECompositionStringProc = function(hImc: HIMC; dWord1: DWORD; lpBuf: pointer; dwBufLen: DWORD): Longint; stdcall;
  {$IFDEF LMD_UNICODE}
  TElDeadChar = class(TObject)
  private
    FAuxChar: WideChar;
    FBaseChar: WideChar;
    FDeadChar: WideChar;
  protected
    procedure SetAuxChar(const Value: WideChar);
    procedure SetBaseChar(const Value: WideChar);
    procedure SetDeadChar(const Value: WideChar);
  public
    constructor Create(const ABaseChar, AAuxChar, ADeadChar: WideChar);
    property AuxChar: WideChar read FAuxChar;
    property BaseChar: WideChar read FBaseChar;
    property DeadChar: WideChar read FDeadChar;
  end;

  TElDeadCharList = class(TLMDObjectList)
  private
    function GetDeadCharByIndex(index: integer): WideChar;
    function GetAuxCharByIndex(index: integer): WideChar;
    function GetBaseCharByIndex(index: integer): WideChar;
  public
    constructor Create;
    procedure AddDeadChar(AElDeadChar: TElDeadChar);
    function GetDeadChar(ABaseChar, AAuxChar: WideChar): WideChar;
    property DeadChars[index: integer]: WideChar read GetDeadCharByIndex;
    property BaseChars[index: integer]: WideChar read GetBaseCharByIndex;
    property AuxChars[index: integer]: WideChar read GetAuxCharByIndex;
  end;
  {$ENDIF LMD_UNICODE}

  TElKeyboardInputProcessor = class(TObject)
  protected
    FCharCase: TElEditCharCase;
    FCDead: Integer;
    FDeadChar: WideChar;
    {$IFDEF LMD_UNICODE}
    FDeadCharList: TElDeadCharList;
    {$ENDIF LMD_UNICODE}
    FHandle: THandle;
    FResultStr: TLMDString;
    procedure SetCharCase(Value: TElEditCharCase); virtual;
    procedure SetResultStr(Value: TLMDString); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    {$ifdef LMD_UNICODE}
    procedure WMDeadChar(Msg: TWMDeadChar); virtual;
    procedure WMImeComposition(Msg: TMessage); virtual;
    {$endif}
    procedure WMKeyDown(Msg: TWMKeyDown); virtual;
    procedure WMChar(Msg: TWMChar); virtual;
    function HandleAllocated: boolean;
    property CharCase: TElEditCharCase read FCharCase write SetCharCase default eecNormal;
    property Handle: THandle read FHandle write FHandle;
    property ResultStr: TLMDString read FResultStr write SetResultStr;
  end;

  TElKeyboardInput = class(TElKeyboardInputProcessor)
  protected
    FText: TLMDString;
    procedure SetCharCase(Value: TElEditCharCase); override;
    procedure SetResultStr(Value: TLMDString); override;
    property ResultStr: TLMDString read FResultStr write SetResultStr;
  public
    constructor Create;
    destructor Destroy; override;
    function IsRepeatSymbolString: boolean;
    procedure WMKeyDown(Msg: TWMKeyDown); override;
    procedure Reset;
    property Text: TLMDString read FText;
  end;

  TSearchTextTimeoutThread = class (TThread)
  private
    CriticalSection : TRTLCriticalSection;
    fKeepAlive : Boolean;
    FIncrementalSearchTimeout : integer;
    procedure SetKeepAlive (KeepAlive : Boolean);
    function GetKeepAlive : Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy ;override;

    property IncrementalSearchTimeout : integer read FIncrementalSearchTimeout write FIncrementalSearchTimeout;
    property KeepAlive : Boolean read GetKeepAlive write SetKeepAlive default False;
  end;

{$ifdef LMD_UNICODE}

type
  ToUnicodeProc = function(wVirtKey, wScanCode: UINT; const KeyState: TKeyboardState;
                            var pwszBuff; cchBuff: Integer; wFlags: UINT): Integer; stdcall;

function KeyToUnicode(const Key: AnsiString): WideString;
{$endif}

implementation

{$ifdef LMD_UNICODE}

var
  ToUnicode : ToUnicodeProc;

function KeyToUnicode(const Key: AnsiString): WideString;
var KeyboardCodePage: integer;
    Buf: String;
    LenBuf: Integer;
    LenRes: integer;
    Locale: LCID;
    // const LOCALE_IDEFAULTANSICODEPAGE     = $00001004;
begin
  // Get right locale
  Locale := GetKeyboardLayout(0) and $FFFF;
  LenBuf := GetLocaleInfo(Locale, LOCALE_IDEFAULTANSICODEPAGE, nil, 0);
  SetLength(Buf, LenBuf);
  GetLocaleInfo(Locale, LOCALE_IDEFAULTANSICODEPAGE, PChar(Buf), LenBuf);
  KeyboardCodePage := StrToIntDef(Buf, GetACP);

  // Get length of result string
  LenRes := MultiByteToWideChar(KeyboardCodePage, MB_PRECOMPOSED or MB_USEGLYPHCHARS, PAnsiChar(Key),
    Length(Key), nil, 0);
  SetLength(Result, LenRes);

  MultiByteToWideChar(KeyboardCodePage, MB_PRECOMPOSED or MB_USEGLYPHCHARS, PAnsiChar(Key),
    Length(Key), PWideChar(Result), LenRes);
  end;
{$endif}

{
******************************* TElKeyboardInput *******************************
}

constructor TElKeyboardInput.Create;
begin
  inherited;
  FText := '';
end;

destructor TElKeyboardInput.Destroy;
begin
  inherited;
end;

procedure TElKeyboardInput.Reset;
begin
  FText := '';
end;

procedure TElKeyboardInput.WMKeyDown(Msg: TWMKeyDown);
var
  {$ifdef LMD_UNICODE}
  S: WideString;
  {$else}
  S: String;
  {$endif}

begin
  inherited WMKeyDown(Msg);
  if (Msg.CharCode = 8) and (FText <> '') then
  begin
    S := FText;
    {$ifdef LMD_UNICODE}
    LMDWideDelete(S, Length(S), 1);
    {$else}
    System.Delete(S, Length(S), 1);
    {$endif}
    FText := S;
  end;
end;

procedure TElKeyboardInput.SetCharCase(Value: TElEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    if FCharCase <> eecNormal then
    begin
      {$ifndef LMD_UNICODE}
      if FCharCase = eecUppercase then
        FText := Uppercase(FText)
      else
        FText := Lowercase(FText);
      {$else}
      if FCharCase = eecUppercase then
        FText := LMDWideUppercase(FText)
      else
        FText := LMDWideLowercase(FText);
      {$endif}
    end;
  end;
end;

procedure TElKeyboardInput.SetResultStr(Value: TLMDString);
begin
  inherited;
  FText := FText + ResultStr;
end;

{
************************** TElKeyboardInputProcessor ***************************
}
constructor TElKeyboardInputProcessor.Create;
begin
  inherited Create; // dummy code
  FResultStr := '';
  FDeadChar := #0;
  FCDead := 0;
  {$ifdef LMD_UNICODE}
  ToUnicode := GetProcAddress(GetModuleHandle('USER32'), 'ToUnicode');
  FDeadCharList := TElDeadCharList.Create;
  {$endif}
end;

destructor TElKeyboardInputProcessor.Destroy;
begin
  {$ifdef LMD_UNICODE}
  FDeadCharList.free;
  {$endif}
  inherited;
end;

procedure TElKeyboardInputProcessor.SetCharCase(Value: TElEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    if FCharCase <> eecNormal then
    begin
      {$ifndef LMD_UNICODE}
      if FCharCase = eecUppercase then
        FResultStr := Uppercase(FResultStr)
      else
        FResultStr := Lowercase(FResultStr);
      {$else}
      if FCharCase = eecUppercase then
        FResultStr := LMDWideUppercase(FResultStr)
      else
        FResultStr := LMDWideLowercase(FResultStr);
      {$endif}
    end;
  end;
end;

procedure TElKeyboardInputProcessor.SetResultStr(Value: TLMDString);
begin
  FResultStr := Value;
end;

{$ifdef LMD_UNICODE}
procedure TElKeyboardInputProcessor.WMDeadChar(Msg : TWMDeadChar);
begin
  FDeadChar := WideChar(Msg.CharCode);
  Msg.Result := 0;
end;

{$HINTS OFF}
procedure TElKeyboardInputProcessor.WMImeComposition(Msg: TMessage);
var
  IMC: HIMC;
  S: AnsiString;
  SNT: WideString;
  Size: Integer;
  StrEnd: PWideChar;
  ImmGetCompositionStringW: TIMECompositionStringProc;
  begin
  // Input of word is finished?
  if (HandleAllocated) then
    if ((Msg.LParam and GCS_RESULTSTR) <> 0) then
    begin
      IMC := ImmGetContext(Handle);
      if IMC <> 0 then
      begin
        // NT, 2000, XP?
        if LMDSIWindowsNTUp then
        begin
          try
            SNT := '';
            if GetModuleHandle('IMM32') <> 0 then
            begin
              ImmGetCompositionStringW := GetProcAddress(GetModuleHandle('IMM32'), 'ImmGetCompositionStringW');
              if @ImmGetCompositionStringW <> nil then
              begin
                Size := ImmGetCompositionStringW(IMC, GCS_RESULTSTR, nil, 0);
                SetLength(SNT, Size);
                LMDFillWideChar(PWideChar(SNT)^, Size, #0);
                ImmGetCompositionStringW(IMC, GCS_RESULTSTR, PWideChar(SNT), Size);
                end;
            end;
          finally
            ImmReleaseContext(Handle, IMC);
          end;
          // remove null symbols
          StrEnd := LMDWideStrScan(PWideChar(SNT), WideChar(#0));
          if StrEnd <> nil then
            SetLength(SNT, StrEnd - PWideChar(SNT));
          end
        else
        begin
          // IME support for Win95-98
          // Unfortunately, should properly work not for all versions
          // (you'll get a line of '?')
          S := '';
          try
            Size := ImmGetCompositionStringA(IMC, GCS_RESULTSTR, nil, 0);
            SetLength(s, Size);
            ImmGetCompositionStringA(IMC, GCS_RESULTSTR, PAnsiChar(s), Size);
            finally
            ImmReleaseContext(Handle, IMC);
          end;
          SNT := KeyToUnicode(s);
        end;

        if FCharCase = eecUppercase then
          SNT := LMDWideUppercase(SNT)
        else
        if FCharCase = eecLowercase then
          SNT := LMDWideLowercase(SNT);

        ResultStr := SNT;
      end;
    end;
end;
{$HINTS ON}
{$endif}

procedure TElKeyboardInputProcessor.WMKeyDown(Msg : TWMKeyDown);
{$ifdef LMD_UNICODE}
var KeyState: TKeyboardState;
    s : WideString;
    s1 : WideString;
    Len : Integer;
    //FAdd: Integer;
    ACharCode : integer;
    {.............................................................}
    function IsSpecialLanguage: Boolean;
    var Language: Integer;
    begin
      Language := (GetKeyboardLayout(0) and $FFFF);
      Result := (Language = $0439) {or  // Hindi
                (Language = $0404) or  // Chinese (Taiwan)
                (Language = $0804) or  //Chinese (PRC)
                (Language = $0c04) or  //Chinese (Hong Kong)
                (Language = $1004)};    //Chinese (Singapore)

    end;
{$endif}

begin
  {$ifdef LMD_UNICODE}
  if LMDSIWindowsNTUp {and IsSpecialLanguage } then
  begin
      // Manual translation of key codes to Unicode
      // if Msg.CharCode in [ord('A')..ord('Z'),ord('0')..ord('9'),187..192,220] then
    if not (Msg.CharCode in [8, 9, 13, 27]) then
    begin
      SetLength(s, 5);
      if GetKeyboardState(KeyState) and ((KeyState[VK_CONTROL] and $80)=0) then
      begin
        ACharCode := Msg.CharCode;
        Len := ToUnicode(ACharCode, Msg.KeyData, KeyState, PWideChar(s)^, 5, 0);
        if Len > 1 then
        begin
          SetLength(s, Len);
          if (FDeadChar <> #0) then
          begin
            if FCDead >= 1 then
            begin
              ResultStr := s;
              SendMessage(Handle, WM_CHAR, Word(FDeadChar), 0);
              FDeadChar := #0;
              FCDead := 0;
            end
            else
              Inc(FCDead);
          end
          else
            ResultStr := s;
        end
        else
        // Dead Char Support
        if (FDeadChar <> #0) and (Len = 1) then
        begin
          ResultStr := FDeadCharList.GetDeadChar(s[1], FDeadChar);
          if ResultStr = WideChar(0) then
          begin
            s1 := s;
            SetLength(s1, 2);
            s1[2] := s1[1];
            s1[1] := WideChar(FDeadChar);
            ResultStr := s1;
          end;
          FDeadChar := #0;
        end
        else
        if Len > 0 then
        begin
          SetLength(s, Len);
          ResultStr := s;
          end;
      end;
    end;
  end
  else
  {$endif}
    WMChar(Msg);
end;

procedure TElKeyboardInputProcessor.WMChar(Msg: TWMChar);
var
  LC: Char;
begin
  inherited;
  LC := Char(Msg.CharCode);
  {$ifdef LMD_UNICODE}
  if not (Msg.CharCode in [VK_BACK, VK_RETURN, VK_ESCAPE, VK_TAB, 127, 0]) then
    ResultStr := LMDWMCharToUnicode(LC);
  {$else}
    ResultStr := LC;
  {$endif}
end;

function TElKeyboardInputProcessor.HandleAllocated: boolean;
begin
  Result := (FHandle <> 0);
end;

constructor TSearchTextTimeoutThread.Create ;
begin
  inherited Create (True) ;
  InitializeCriticalSection(CriticalSection);
  fKeepAlive := False;
  FreeOnTerminate := True;
end ;

destructor TSearchTextTimeoutThread.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited Destroy;
end ;

procedure TSearchTextTimeoutThread.Execute ;
begin
  while not Terminated do
  begin
    Sleep(FIncrementalSearchTimeout);
    if not KeepAlive then
      break;
    KeepAlive := False
  end
end;

function TSearchTextTimeoutThread.GetKeepAlive : Boolean ;
begin
  EnterCriticalSection(CriticalSection);
  try
    Result := fKeepAlive;
  finally
    LeaveCriticalSection(CriticalSection);
    end
end;

procedure TSearchTextTimeoutThread.SetKeepAlive (KeepAlive : Boolean) ;
begin
  EnterCriticalSection(CriticalSection);
  try
    fKeepAlive := KeepAlive;
  finally
    LeaveCriticalSection(CriticalSection);
    end
end;

{$IFDEF LMD_UNICODE}
{ TElDeadChar }

constructor TElDeadChar.Create(const ABaseChar, AAuxChar, ADeadChar: WideChar);
begin
  inherited Create;
  FBaseChar := ABaseChar;
  FAuxChar := AAuxChar;
  FDeadChar := ADeadChar;
end;

procedure TElDeadChar.SetAuxChar(const Value: WideChar);
begin
  FAuxChar := Value;
end;

procedure TElDeadChar.SetBaseChar(const Value: WideChar);
begin
  FBaseChar := Value;
end;

procedure TElDeadChar.SetDeadChar(const Value: WideChar);
begin
  FDeadChar := Value;
end;

{ TElDeadCharList }

procedure TElDeadCharList.AddDeadChar(AElDeadChar: TElDeadChar);
begin
  Add(AElDeadChar);
end;

constructor TElDeadCharList.Create;
begin
  inherited;
  AutoClearObjects := true;
  Add(TElDeadChar.Create('A', #096, widechar($00C0)));
  Add(TElDeadChar.Create('A', #180, widechar($00C1)));
  Add(TElDeadChar.Create('A', #094, widechar($00C2)));
  Add(TElDeadChar.Create('A', #126, widechar($00C3)));
  Add(TElDeadChar.Create('A', #168, widechar($00C4)));
  Add(TElDeadChar.Create('A', #161, widechar($00C5)));
  Add(TElDeadChar.Create('A', #059, widechar($00C6)));
  Add(TElDeadChar.Create('A', #058, widechar($00C6)));
  Add(TElDeadChar.Create('A', #176, widechar($00C7)));
  Add(TElDeadChar.Create('A', #039, widechar($00C1)));
  Add(TElDeadChar.Create('a', #096, widechar($00E0)));
  Add(TElDeadChar.Create('a', #180, widechar($00E1)));
  Add(TElDeadChar.Create('a', #094, widechar($00E2)));
  Add(TElDeadChar.Create('a', #126, widechar($00E3)));
  Add(TElDeadChar.Create('a', #168, widechar($00E4)));
  Add(TElDeadChar.Create('a', #161, widechar($00E5)));
  Add(TElDeadChar.Create('a', #059, widechar($00E6)));
  Add(TElDeadChar.Create('a', #058, widechar($00E6)));
  Add(TElDeadChar.Create('a', #176, widechar($00E7)));
  Add(TElDeadChar.Create('a', #039, widechar($00E1)));
  Add(TElDeadChar.Create('C', #161, widechar($010C)));
  Add(TElDeadChar.Create('C', #059, widechar($0108)));
  Add(TElDeadChar.Create('C', #058, widechar($0108)));
  Add(TElDeadChar.Create('C', #039, widechar($00C7)));
  Add(TElDeadChar.Create('c', #161, widechar($010D)));
  Add(TElDeadChar.Create('c', #059, widechar($0109)));
  Add(TElDeadChar.Create('c', #058, widechar($0109)));
  Add(TElDeadChar.Create('c', #039, widechar($00E7)));
  Add(TElDeadChar.Create('D', #161, widechar($010E)));
  Add(TElDeadChar.Create('d', #161, widechar($010F)));
  Add(TElDeadChar.Create('E', #096, widechar($00C8)));
  Add(TElDeadChar.Create('E', #180, widechar($00C9)));
  Add(TElDeadChar.Create('E', #094, widechar($00CA)));
  Add(TElDeadChar.Create('E', #168, widechar($00CB)));
  Add(TElDeadChar.Create('E', #161, widechar($0114)));
  Add(TElDeadChar.Create('E', #059, widechar($00CE)));
  Add(TElDeadChar.Create('E', #058, widechar($00CE)));
  Add(TElDeadChar.Create('E', #176, widechar($00CF)));
  Add(TElDeadChar.Create('E', #039, widechar($00C9)));
  Add(TElDeadChar.Create('e', #096, widechar($00E8)));
  Add(TElDeadChar.Create('e', #180, widechar($00E9)));
  Add(TElDeadChar.Create('e', #094, widechar($00EA)));
  Add(TElDeadChar.Create('e', #168, widechar($00EB)));
  Add(TElDeadChar.Create('e', #161, widechar($0115)));
  Add(TElDeadChar.Create('e', #059, widechar($00EE)));
  Add(TElDeadChar.Create('e', #058, widechar($00EE)));
  Add(TElDeadChar.Create('e', #176, widechar($00EF)));
  Add(TElDeadChar.Create('e', #039, widechar($00E9)));
  Add(TElDeadChar.Create('G', #059, widechar($011C)));
  Add(TElDeadChar.Create('G', #058, widechar($011C)));
  Add(TElDeadChar.Create('g', #059, widechar($011D)));
  Add(TElDeadChar.Create('g', #058, widechar($011D)));
  Add(TElDeadChar.Create('H', #059, widechar($0124)));
  Add(TElDeadChar.Create('H', #058, widechar($0124)));
  Add(TElDeadChar.Create('h', #059, widechar($0125)));
  Add(TElDeadChar.Create('h', #058, widechar($0125)));
  Add(TElDeadChar.Create('I', #096, widechar($00CC)));
  Add(TElDeadChar.Create('I', #180, widechar($00CD)));
  Add(TElDeadChar.Create('I', #094, widechar($00CE)));
  Add(TElDeadChar.Create('I', #168, widechar($00CF)));
  Add(TElDeadChar.Create('I', #161, widechar($00D1)));
  Add(TElDeadChar.Create('I', #059, widechar($00D2)));
  Add(TElDeadChar.Create('I', #058, widechar($00D2)));
  Add(TElDeadChar.Create('I', #176, widechar($00D3)));
  Add(TElDeadChar.Create('I', #039, widechar($00CD)));
  Add(TElDeadChar.Create('i', #096, widechar($00EC)));
  Add(TElDeadChar.Create('i', #180, widechar($00ED)));
  Add(TElDeadChar.Create('i', #094, widechar($00EE)));
  Add(TElDeadChar.Create('i', #168, widechar($00EF)));
  Add(TElDeadChar.Create('i', #161, widechar($00F1)));
  Add(TElDeadChar.Create('i', #059, widechar($00F2)));
  Add(TElDeadChar.Create('i', #058, widechar($00F2)));
  Add(TElDeadChar.Create('i', #176, widechar($00F3)));
  Add(TElDeadChar.Create('i', #039, widechar($00ED)));
  Add(TElDeadChar.Create('J', #059, widechar($0134)));
  Add(TElDeadChar.Create('J', #058, widechar($0134)));
  Add(TElDeadChar.Create('j', #059, widechar($0135)));
  Add(TElDeadChar.Create('j', #058, widechar($0135)));
  Add(TElDeadChar.Create('L', #161, widechar($013D)));
  Add(TElDeadChar.Create('l', #161, widechar($013E)));
  Add(TElDeadChar.Create('N', #161, widechar($0147)));
  Add(TElDeadChar.Create('n', #161, widechar($0148)));
  Add(TElDeadChar.Create('O', #096, widechar($00D2)));
  Add(TElDeadChar.Create('O', #180, widechar($00D3)));
  Add(TElDeadChar.Create('O', #094, widechar($00D4)));
  Add(TElDeadChar.Create('O', #126, widechar($00D5)));
  Add(TElDeadChar.Create('O', #168, widechar($00D6)));
  Add(TElDeadChar.Create('O', #161, widechar($00D7)));
  Add(TElDeadChar.Create('O', #059, widechar($00D8)));
  Add(TElDeadChar.Create('O', #058, widechar($00D8)));
  Add(TElDeadChar.Create('O', #176, widechar($00D9)));
  Add(TElDeadChar.Create('O', #039, widechar($00D3)));
  Add(TElDeadChar.Create('o', #096, widechar($00F2)));
  Add(TElDeadChar.Create('o', #180, widechar($00F3)));
  Add(TElDeadChar.Create('o', #094, widechar($00F4)));
  Add(TElDeadChar.Create('o', #126, widechar($00F5)));
  Add(TElDeadChar.Create('o', #168, widechar($00F6)));
  Add(TElDeadChar.Create('o', #161, widechar($00F7)));
  Add(TElDeadChar.Create('o', #059, widechar($00F8)));
  Add(TElDeadChar.Create('o', #058, widechar($00F8)));
  Add(TElDeadChar.Create('o', #176, widechar($00F9)));
  Add(TElDeadChar.Create('o', #039, widechar($00F3)));
  Add(TElDeadChar.Create('R', #161, widechar($0158)));
  Add(TElDeadChar.Create('r', #161, widechar($0159)));
  Add(TElDeadChar.Create('S', #161, widechar($0160)));
  Add(TElDeadChar.Create('S', #059, widechar($015C)));
  Add(TElDeadChar.Create('S', #058, widechar($015C)));
  Add(TElDeadChar.Create('s', #161, widechar($0161)));
  Add(TElDeadChar.Create('s', #059, widechar($015D)));
  Add(TElDeadChar.Create('s', #058, widechar($015D)));
  Add(TElDeadChar.Create('T', #161, widechar($0164)));
  Add(TElDeadChar.Create('t', #161, widechar($0165)));
  Add(TElDeadChar.Create('U', #096, widechar($00D9)));
  Add(TElDeadChar.Create('U', #180, widechar($00DA)));
  Add(TElDeadChar.Create('U', #094, widechar($00DB)));
  Add(TElDeadChar.Create('U', #168, widechar($00DC)));
  Add(TElDeadChar.Create('U', #161, widechar($00DE)));
  Add(TElDeadChar.Create('U', #059, widechar($016C)));
  Add(TElDeadChar.Create('U', #058, widechar($016C)));
  Add(TElDeadChar.Create('U', #176, widechar($016E)));
  Add(TElDeadChar.Create('U', #039, widechar($00DA)));
  Add(TElDeadChar.Create('U', #034, widechar($00DC)));
  Add(TElDeadChar.Create('u', #096, widechar($00F9)));
  Add(TElDeadChar.Create('u', #180, widechar($00FA)));
  Add(TElDeadChar.Create('u', #094, widechar($00FB)));
  Add(TElDeadChar.Create('u', #168, widechar($00FC)));
  Add(TElDeadChar.Create('u', #161, widechar($00FE)));
  Add(TElDeadChar.Create('u', #059, widechar($016D)));
  Add(TElDeadChar.Create('u', #058, widechar($016D)));
  Add(TElDeadChar.Create('u', #176, widechar($016F)));
  Add(TElDeadChar.Create('u', #039, widechar($00FA)));
  Add(TElDeadChar.Create('u', #034, widechar($00FC)));
  Add(TElDeadChar.Create('Y', #180, widechar($00DD)));
  Add(TElDeadChar.Create('Y', #039, widechar($00DD)));
  Add(TElDeadChar.Create('y', #180, widechar($00FD)));
  Add(TElDeadChar.Create('y', #039, widechar($00FD)));
  Add(TElDeadChar.Create('Z', #161, widechar($017D)));
  Add(TElDeadChar.Create('z', #161, widechar($017E)));
  Add(TElDeadChar.Create(#$0391, #$0384, WideChar($0386)));
  Add(TElDeadChar.Create(#$0395, #$0384, WideChar($0388)));
  Add(TElDeadChar.Create(#$0397, #$0384, WideChar($0389)));
  Add(TElDeadChar.Create(#$0399, #$0384, WideChar($038A)));
  Add(TElDeadChar.Create(#$039F, #$0384, WideChar($038C)));
  Add(TElDeadChar.Create(#$03A5, #$0384, WideChar($038E)));
  Add(TElDeadChar.Create(#$03A9, #$0384, WideChar($038F)));

  Add(TElDeadChar.Create(#$03B1, #$0384, WideChar($03AC)));
  Add(TElDeadChar.Create(#$03B5, #$0384, WideChar($03AD)));
  Add(TElDeadChar.Create(#$03B7, #$0384, WideChar($03AE)));
  Add(TElDeadChar.Create(#$03B9, #$0384, WideChar($03AF)));
  Add(TElDeadChar.Create(#$03BF, #$0384, WideChar($03CC)));
  Add(TElDeadChar.Create(#$03C5, #$0384, WideChar($03CD)));
  Add(TElDeadChar.Create(#$03C9, #$0384, WideChar($03CE)));
  // dialytika tonos, not working yet
  Add(TElDeadChar.Create(#$03B9, #126, WideChar($0390)));
  Add(TElDeadChar.Create(#$03C5, #126, WideChar($03B0)));
  // dialytika
  Add(TElDeadChar.Create(#$03B9, #$A8, WideChar($03CA)));
  Add(TElDeadChar.Create(#$03C5, #$A8, WideChar($03CB)));
end;

function TElDeadCharList.GetAuxCharByIndex(index: integer): WideChar;
begin
  result := #0;
  if count > 0 then
    if (index >= 0) and (index < count) then
      result := TElDeadChar(Items[index]).AuxChar;
end;

function TElDeadCharList.GetBaseCharByIndex(index: integer): WideChar;
begin
  result := #0;
  if count > 0 then
    if (index >= 0) and (index < count) then
      result := TElDeadChar(Items[index]).BaseChar;
end;

function TElDeadCharList.GetDeadChar(ABaseChar, AAuxChar: WideChar): widechar;
var
  i: integer;
begin
  Result := WideChar(0);
  for i := 0 to count - 1 do
  begin
    if (TElDeadChar(items[i]).BaseChar = ABaseChar) and
      (TElDeadChar(items[i]).AuxChar = AAuxChar) then
    begin
      Result := TElDeadChar(items[i]).DeadChar;
      break;
    end;
  end
end;

function TElDeadCharList.GetDeadCharByIndex(index: integer): widechar;
begin
  result := widechar(0);
  if count > 0 then
    if (index >= 0) and (index < count) then
      result := TElDeadChar(Items[index]).DeadChar;
end;
{$ENDIF LMD_UNICODE}

function TElKeyboardInput.IsRepeatSymbolString: boolean;
var
  i: integer;
begin
  Result := True;
  for i := 1 to Length(Text) do
    if Text[1] <> Text[i] then
    begin
      Result := False;
      break;
    end;
end;

end.
