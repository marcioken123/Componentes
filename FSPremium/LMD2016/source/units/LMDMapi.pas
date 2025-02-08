unit LMDMapi;
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

LMDMapi unit (RM)
--------------------
Simple MAPI email component (Send only)

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, Windows, LMDWebBase;

type

  { **************************ELMDMapiError**************************** }
  ELMDMapiError = class(Exception)
    ErrorCode: integer;
  end;
  TLMDMapiError = procedure(Sender: TObject; iErrorCode: integer) of object;

  TLMDMAPIOption=(moUseDefaultProfile, moCreateNewSession, moLogonUI, moShowDialog,
                  moNoSTMPIdent, moNoAddressField);
  TLMDMAPIOptions=set of TLMDMAPIOption;

const
  def_MAPIOptions=[moUseDefaultProfile, moShowDialog];

type
  { **************************TLMDMapiSendMail**************************** }
  TLMDMapiSendMail = class(TLMDWebComponent)
  private
    FAttachment,
    FBccRecipient,
    FCcRecipient,
    FToRecipient,
    FMessageBody: TStrings;
    FMessageID,
    FSubject,
    FProfile,
    FPassword{,
    FProfileName}: AnsiString;
    FSessionID: ULong;
    FResolve:Boolean;
    FOnStartSaveMail,
    FOnEndSaveMail,
    FOnStartLogoff,
    FOnStartSendMail,
    FOnStartLogon,
    FOnEndLogoff,
    FOnEndLogon,
    FOnEndSendMail: TNotifyEvent;
    FOnError: TLMDMapiError;
    FLastError: integer;
    FOptions:TLMDMAPIOptions;
    procedure SetStrings(index: integer; aValue: TStrings);
    function GetStrings(index: integer): TStrings;
    function GetDefaultProfile: AnsiString;
    procedure ReadBool(Reader:TReader);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure DoEndLogon; virtual;
    procedure DoEndLogoff; virtual;
    procedure DoEndSaveMail; virtual;
    procedure DoEndSendMail; virtual;
    procedure DoError(iErrorCode: integer);
    procedure DoStartLogon; virtual;
    procedure DoStartLogoff; virtual;
    procedure DoStartSaveMail; virtual;
    procedure DoStartSendMail; virtual;
    procedure Execute(Save: boolean; HWND:Ulong);
    function GetFlags:LongInt;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LogOn;
    procedure LogOff;
    procedure SaveMail;overload;
    procedure SaveMail(HWND:ULong);overload;
    procedure SendMail;overload;
    procedure SendMail(HWND:ULong);overload;
    procedure Reset;
    property LastError: integer read FLastError default 0;
    property MessageID: AnsiString read FMessageID;
    property Password: AnsiString read FPassword write FPassword;
    property Profile: AnsiString read FProfile write FProfile;
    property DefaultProfile: AnsiString read GetDefaultProfile;
  published
    property Attachment: TStrings index 0 read GetStrings write SetStrings;
    property BccRecipient: TStrings index 1 read GetStrings write SetStrings;
    property CcRecipient: TStrings index 2 read GetStrings write SetStrings;
    property MessageBody: TStrings index 3 read GetStrings write SetStrings;
    property ToRecipient: TStrings index 4 read GetStrings write SetStrings;
    property Options:TLMDMapiOptions read FOptions write FOptions default def_MAPIOptions;
    property Subject: AnsiString read FSubject write FSubject;
    //property ResolveRecipient:Boolean read FResolve write FResolve;
    property OnError: TLMDMapiError read FOnError write FOnError;
    property OnEndLogon: TNotifyEvent read FOnEndLogon write FOnEndLogon;
    property OnEndLogoff: TNotifyEvent read FOnEndLogoff write FOnEndLogoff;
    property OnEndSaveMail: TNotifyEvent read FOnEndSaveMail write FOnEndSaveMail;
    property OnEndSendMail: TNotifyEvent read FOnEndSendMail write FOnEndSendMail;
    property OnStartLogon: TNotifyEvent read FOnStartLogon write FOnStartLogon;
    property OnStartLogoff: TNotifyEvent read FOnStartLogoff write FOnStartLogoff;
    property OnStartSaveMail: TNotifyEvent read FOnStartSaveMail write FOnStartSaveMail;
    property OnStartSendMail: TNotifyEvent read FOnStartSendMail write FOnStartSendMail;
  end;

implementation

uses
{$IFDEF LMD_DEBUGTRACE}
  Dialogs,
{$ENDIF}

  MAPI, Registry, Controls, Forms;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

{************************** TLMDMAPISendMail **********************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDMapiSendMail.SetStrings(index: integer; aValue: TStrings);
begin
  case index of
    0: FAttachment.Assign(aValue);
    1: FBccRecipient.Assign(aValue);
    2: FCcRecipient.Assign(aValue);
    3: FMessageBody.Assign(aValue);
    4: FToRecipient.Assign(aValue);
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDMapiSendMail.GetStrings(index: integer): TStrings;
begin
  case index of
    0: Result:= FAttachment;
    1: Result:= FBccRecipient;
    2: Result:= FCcRecipient;
    3: Result:= FMessageBody;
    4: Result:= FToRecipient;
  else
    Result:= nil;
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDMapiSendMail.GetFlags:LongInt;
begin
  result:=0;
  if moCreateNewSession in FOptions then result:=result or MAPI_NEW_SESSION;
  if moLogonUI in FOptions then result:=result or MAPI_LOGON_UI;
end;

{-----------------------------------------------------------------------------}
function TLMDMapiSendMail.GetDefaultProfile: AnsiString;
const
  regpathNT='Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles';
  regpath9X='Software\Microsoft\Windows Messaging Subsystem\Profiles';
  regkey='DefaultProfile';
var
  reg: TRegistry;
  tmp:String;
begin
  result := '';
  if SysUtils.Win32PlatForm=VER_PLATFORM_WIN32_NT then
    tmp:=regpathNT
  else
    tmp:=regpath9X;
  reg:=TRegistry.Create;
  try
    reg.RootKey:=HKEY_CURRENT_USER;
    if reg.OpenkeyReadOnly(tmp) and reg.ValueExists(regkey) then
      result := AnsiString(reg.ReadString(regkey));
  finally
    reg.free;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.ReadBool(Reader:TReader);
begin
  if Reader.ReadBoolean then
    Include(FOptions, moShowDialog);
end;
{---------------------------- Protected ---------------------------------------}
procedure TLMDMapiSendMail.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer) ;
  Filer.DefineProperty('ShowDialog', ReadBool, nil, false);
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.DoEndLogon;
begin
  if Assigned(FOnEndLogon) then FOnEndLogon(self);
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.DoEndLogoff;
begin
  if Assigned(FOnEndLogoff) then FOnEndLogoff(self);
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.DoStartLogon;
begin
  if Assigned(FOnStartLogon) then FOnStartLogon(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDMapiSendMail.DoStartLogoff;
begin
  if Assigned(FOnStartLogoff) then FOnStartLogoff(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDMapiSendMail.DoStartSaveMail;
begin
  if Assigned(FOnStartSaveMail) then FOnStartSaveMail(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDMapiSendMail.DoError;
begin
  if Assigned(FOnError) then FOnError(self, iErrorCode);
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.DoEndSaveMail;
begin
  if Assigned(FOnEndSaveMail) then FOnEndSaveMail(self);
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.DoEndSendMail;
begin
  if Assigned(FOnEndSendMail) then FOnEndSendMail(self);
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.DoStartSendMail;
begin
  if Assigned(FOnStartSendMail) then FOnStartSendMail(self);
end;

{-----------------------------------------------------------------------------}

function MakeStrPtr(const Str: String): PAnsiChar;
begin
  if  Str = ''  then
    Result := nil
  else
    Result := StrNew(PAnsiChar(AnsiString(Str)));
end;

procedure FreeStrPtr(P: PAnsiChar);
begin
  if  Assigned(P) then
    StrDispose(P);
end;

procedure TLMDMapiSendMail.Execute(Save: boolean; HWND:ULong);

var
  Recipients: array of TMapiRecipDesc;
  iRecipients: integer;

  procedure CopyList(sList: TStrings; rc: cardinal);
  var
    i: integer;
    Addr: AnsiString;
  begin
    if  Assigned(sList) then
    for i := 0 to sList.Count - 1 do
      with  Recipients[iRecipients] do
        begin
          ulReserved:= 0;
          ulRecipClass:= rc;
          lpszAddress := nil;
          if moNoAddressField in FOptions then   // for MS Exchange compatibility
            Addr := ''
          else
          if moNoSTMPIdent in FOptions then
            Addr := AnsiString(sList[i])
          else
            Addr := 'SMTP:' + AnsiString(sList[i]);

          lpszName := MakeStrPtr(sList[i]);
          //name = name of user, MAPI mail client will try to find someone matching this name
          //outlook does lookup the emails, too. netscape not ....
          //address will work in anyway ...

          lpszAddress := MakeStrPtr(string(Addr));
          ulEIDSize:= 0;
          lpEntryID:= nil;
          Inc(iRecipients);
        end;
  end;
var
  MapiMessage: TMapiMessage;
  Attachments: array of TMapiFileDesc;
  i: integer;
  Flags: longint;
  pMessageId: PAnsiChar;
  lo: boolean;
  MaxAttachments: Cardinal;
  MaxRecipients: Cardinal;
begin
  LMDWebClearData(MapiMessage, SizeOf(TMapiMessage), 0);
  MapiMessage.nRecipCount := FToRecipient.Count + FCcRecipient.Count + FBccRecipient.Count;
  MapiMessage.nFileCount := FAttachment.Count;
  MaxAttachments := $FFFF div SizeOf(TMAPIFileDesc);
  MaxRecipients := $FFFF div SizeOf(TMAPIRecipDesc);
  //Do some checks in advance...
  if MapiMessage.nRecipCount > MaxRecipients then
    begin
      DoError(MAPI_E_TOO_MANY_RECIPIENTS);
      exit;
    end;

  if MapiMessage.nFileCount > MaxAttachments then
    begin
      DoError(MAPI_E_TOO_MANY_FILES);
      exit;
    end;

  lo:= False;

  if FSessionID = 0 then
    begin
      LogOn;
      lo:= True;
    end;

  pMessageId := nil;

  Screen.Cursor:= crHourGlass;
    try
      // unused fields
      //===============
      MapiMessage.ulReserved:= 0;
      MapiMessage.lpszMessageType:= nil;
      MapiMessage.lpszDateReceived:= nil;
      MapiMessage.lpszConversationID:= nil;
      MapiMessage.lpOriginator := nil;
      MapiMessage.lpRecips := nil;
      MapiMessage.lpFiles := nil;
      MapiMessage.flFlags:= 0;

      //Subject
      MapiMessage.lpszSubject:= PAnsiChar(FSubject);
      //Body
      MapiMessage.lpszNoteText:= MakeStrPtr(FMessageBody.Text);

      //Sender
      MapiMessage.lpOriginator:=nil;

      if MapiMessage.nRecipCount > 0 then
        begin
          SetLength(Recipients, MapiMessage.nRecipCount);
          iRecipients := Low(Recipients);

          // Add first Recipients fields
          LMDWebClearData(Recipients[0], Length(Recipients) *
                  sizeof(Recipients[0]), 0);
          CopyList(FToRecipient, MAPI_TO);
          CopyList(FCcRecipient, MAPI_CC);
          CopyList(FBccRecipient, MAPI_BCC);

          MapiMessage.lpRecips:= @Recipients[0];

        end;

      // Attachments

      if MapiMessage.nFileCount > 0 then
        begin
          MapiMessage.lpFiles:= nil;
          if MapiMessage.nFileCount > 0 then
            begin
              SetLength(Attachments, MapiMessage.nFileCount);
              LMDWebClearData(Attachments[0], Length(Attachments) *
                  sizeof(Attachments[0]), 0);

              for i := 0 to FAttachment.Count - 1 do
                with  Attachments[i] do
                begin
                  lpszPathName:= MakeStrPtr(FAttachment[i]);
                  lpszFileName:= MakeStrPtr(ExtractFileName(FAttachment[i]));
                  ulReserved:= 0;
                  flFlags:= 0;
                  nPosition:= cardinal(-1);
                  lpFileType:= nil;
                end;

              MapiMessage.lpFiles:= @Attachments[0];

            end
        end;

      if Save then
        begin
          try

            {$ifdef LMDCOMP12}
            pMessageId := AnsiStrAlloc(520);
            {$else}
            pMessageId := StrAlloc(520);
            {$endif}
            if FMessageID <> '' then
              StrPCopy(pMessageId, FMessageID)
            else
              pMessageId[0]:= #0;

            DoStartSaveMail;
            FLastError:= MapiSaveMail(FSessionID, HWND, MapiMessage, 0, 0, {$IFDEF LMDCOMP12}PAnsiChar{$ENDIF}(pMessageId));
          finally

            StrDispose(pMessageId);

          end;

          if FLastError <> SUCCESS_SUCCESS then
            DoError(FLastError)
          else
            DoEndSaveMail;
        end
      else
        begin
          // MAPI_RECEIPT_REQUESTED;??

          //flags:=GetFlags;
          flags:=0;
          if (FToRecipient.Count = 0) or (moShowDialog in FOptions) then flags:=MAPI_Dialog;
          {if moUseDefaultProfile in FOptions then
            Flags:=Flags or MAPI_USE_DEFAULT;}
          DoStartSendMail();
          FLastError:= MapiSendMail(FSessionID, HWND, MapiMessage, Flags, 0);
          if FLastError <> SUCCESS_SUCCESS then
            DoError(FLastError)
          else
            DoEndSendMail;
        end;
    finally
      // LogOff automatically when SessionID was 0
      if lo then
        LogOff;

      Screen.Cursor:= crDefault;
      FreeStrPtr(MapiMessage.lpszNoteText);
      if MapiMessage.nRecipCount > 0 then
        begin
//          PRecipients:= Recipients;
          for i := Low(Recipients) to High(Recipients) do
            begin
              FreeStrPtr(Recipients[i].lpszAddress);
              FreeStrPtr(Recipients[i].lpszName);
            end;
        end;
      if MapiMessage.nFileCount > 0 then
        begin
          for i:= Low(Attachments) to High(Attachments) do
            begin
              FreeStrPtr(Attachments[i].lpszFileName);
            end;
        end;
    end;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDMapiSendMail.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAttachment:= TStringList.Create;
  FBccRecipient:= TStringList.Create;
  FCcRecipient:= TStringList.Create;
  FMessageBody:= TStringList.Create;
  FToRecipient:= TStringList.Create;
  FResolve:= True;
  FSessionID:= 0;
  FOptions:=def_MAPIOptions;
end;

{------------------------------------------------------------------------------}
destructor TLMDMapiSendMail.Destroy;
begin
  FAttachment.Free;
  FToRecipient.Free;
  FCcRecipient.Free;
  FBccRecipient.Free;
  FMessageBody.Free;
  inherited Destroy;
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.LogOn;
var
  FLastError: Integer;
  Flags: ULong;
begin

  DoStartLogon;

  flags:=GetFlags;
  if moUseDefaultProfile in FOptions then
    begin
      //Flags:= flags or MAPI_USE_DEFAULT;
      //FLastError:= MAPILOGON(0, nil, nil, Flags, 0, @FSessionID);

      FLastError:=MAPILOGON(0, PAnsiChar(GetDefaultProfile), nil, Flags, 0, @FSessionID);

    end
  else

    FLastError:=MAPILOGON(0, PAnsiChar(FProfile), PAnsiChar(FPassword), Flags, 0, @FSessionID);

  if FLastError<>SUCCESS_SUCCESS then

    FLastError:=MAPILOGON(0, nil, nil, Flags or MAPI_LOGON_UI, 0, @FSessionID);

  if FLastError = 0 then
    DoEndLogon
  else
    DoError(FLastError);
end;

{------------------------------------------------------------------------------}
procedure TLMDMapiSendMail.LogOff;
begin
  FLastError:= 0;
  if FSessionID <> 0 then
    begin
      DoStartLogoff;
      FLastError:= MAPILOGOFF(FSessionID, 0, 0, 0);
      FSessionID:= 0;
      if FLastError = 0 then
        DoEndLogoff
      else
        DoError(FLastError);
    end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.Reset;
begin
  try
    if FSessionID <> 0 then
      LogOff;
  except
  end;
  FAttachment.Clear;
  FToRecipient.Clear;
  FCcRecipient.Clear;
  FBccRecipient.Clear;
  FMessageBody.Clear;
  FSubject:= '';
  FLastError:= 0;
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.SaveMail;
begin
  Execute(True, Application.Handle);
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.SaveMail(HWND:ULong);
begin
  Execute(True, HWND);
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.SendMail;
begin
  Execute(False, Application.Handle);
end;

{-----------------------------------------------------------------------------}
procedure TLMDMapiSendMail.SendMail(HWND:ULong);
begin
  Execute(False, HWND);
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}
end.
