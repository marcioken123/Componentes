unit LMDScrsv;
{$I lmdcmps.inc}

interface

uses
  Windows, registry, SysUtils, Messages, Classes, Graphics, Controls, Forms, Extctrls,
  LMDClass, LMDWndProcComponent;

type

  TLMDScreenSaverMode=(sscfgNoParent, sscfgParent, ssfullView, ssPreview, ssCheckPassword);
  {sscfgNoParent:    Configuration without parent Window, no parameters
   sscfgParent:      Configuration with parent window, /c, -c or c
   ssfullView:       Show screensaver                  /s, -s or s
   ssPreview:        Small Window Preview              /p -p or p (or l)  + WindowHandle, Win95 only
   ssCheckPassWord:  Win95 -> PassWord                 /a -a or a, Win95 only}

  TLMDPWCheckEvent= Procedure(Sender:TObject; var CanClose:Boolean) of Object;

  TLMDScreenSaver = class(TLMDWndProcComponent)
  private
    FBitmap:TBitmap;
    FColor:TColor;
    FNowClose,
    FSaveBack:Boolean;
    FPosition:TPoint;
    FTitle:String;
    FIniFile:TRegIniFile;
    FSection:String;
    FOnSetupDlg:TNotifyEvent;
    FOnSaverStart:TNotifyEvent;
    FOnSaverEnd:TNotifyEvent;

    {neu, Version 2}
    FEnabled:Boolean;
    FMode:TLMDScreenSaverMode;
    FWndHandle:HWND;

    procedure PrevInit;
    procedure ChangePassWord;

    procedure SaveBack;
    {function SaverClose:Boolean;}
    procedure SaverInit;
    procedure ParseArgs;
    procedure Quit;
  protected
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage);override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    function SaverClose:Boolean;
    property Inifile:TRegIniFile read FIniFile;
    property Section:String read FSection;

    {new}
    property Bitmap:TBitmap read FBitmap;
    property Mode:TLMDScreenSaverMode read FMode;

    function ShowDialog(aForm:TForm):Integer;
  published
    Property About;
    Property Color:TColor read FColor write FColor default clBlack;
    Property SaveBackground:Boolean read FSaveBack write FSaveBack default false;
    Property Title:String read FTitle write FTitle;

    property OnSetupDlg:TNotifyEvent read FOnSetupDlg write FOnSetupDlg;
    property OnSaverStart:TNotifyEvent read FOnSaverStart write FOnSaverStart;
    property OnSaverEnd:TNotifyEvent read FOnSaverEnd write FOnSaverEnd;
  end;

implementation
uses
  lmdsysin, lmdprocs;

const
  regEntry='Control Panel\Desktop';

{************************* Class TLMDScreenSaver ******************************}
{------------------------------------------------------------------------------}
procedure TLMDScreenSaver.ChangePassWord;
var
  hmpr:THandle;
  fp:function(regKey:PChar;Wnd:HWnd;res1,res2:Integer):Integer;stdcall;
begin
  hmpr:=LoadLibrary(mpr);
  if hmpr<>0 then
    try
      fp:=GetProcAddress(hmpr,'PwdChangePasswordA');
      if Assigned(fp) then fp('SCRSAVE', FWndHandle, 0,0);
    finally
      FreeLibrary(hmpr);
    end;
  Quit;
end;

{------------------------------------------------------------------------------}
procedure TLMDScreenSaver.PrevInit;
var
  dRect:TRect;
begin
  if GetWindowRect(FWndHandle, dRect) then
    with TForm(owner) do
      begin
        Tag:=GetForeGroundWindow;
        if FSaveBack then SaveBack;
        SetParent(Application.Handle, FWNDHandle);
        SetParent(Handle, FWNDHandle);
        SetWindowLong(Handle, GWL_STYLE, WS_CHILD or WS_DISABLED);

        with dRect do
          SetBounds(0,0, Right-Left, Bottom-Top);
        Color:=FColor;
        Show;
        SetForeGroundWindow(HWND(Tag));
        if Assigned(FOnSaverStart) then FOnSaverStart(Self);
      end
  else
    Quit;
end;

{------------------------------------------------------------------------------}
function TLMDScreenSaver.SaverClose:Boolean;
var
  CanClose:Boolean;
  ini:TRegistry;
  cpl:THandle;
  fp:function(pform:THandle):Boolean;stdcall;

  begin
   result:=False;
   FEnabled:=False;

   SetWindowPos(TForm(Owner).Handle, HWND_NOTOPMOST, 0,0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
   FNowClose:=True;
   CanClose:=true;

   if not LMDSIWindowsNT then
     begin
       ini:=TRegistry.Create;
       with ini do
         try
           RootKey:=HKEY_CURRENT_USER;
           if OpenKey(regEntry, false) and (ReadInteger('ScreenSaveUsePassword')<>0) then
             begin
               ShowCursor(True);
               cpl:=LoadLibrary('PASSWORD.CPL');
               if cpl<>0 then
                 try
                   fp:=GetProcAddress(cpl,'VerifyScreenSavePwd');
                   CanClose:=fp(TForm(owner).Handle);
                 finally
                   FreeLibrary (cpl);
                 end;
              end;
         finally
           ini.Free;
         end;
     end;

   if not CanClose then
     begin
       SetWindowPos(TForm(Owner).Handle, HWND_TOPMOST, 0,0,0,0, SWP_NOMOVE or SWP_NOSIZE);
       FPosition:=Point(-5,-5);
       while Showcursor(false)>-1 do;
       FEnabled:=True;
       FNowClose:=False;
       exit;
     end;

  result:=True;
  if Assigned(FOnSaverEnd) then FOnSaverEnd(Self);


  TForm(owner).Perform(WM_Close,0,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDScreenSaver.SaveBack;
var
  FCanvas:TCanvas;
  DC:HDC;
begin
  FCanvas:=TCanvas.Create;
  DC:=GetDC(0);
  try
    FCanvas.Handle:=DC;
    with FBitmap do
      begin
        Width:=Screen.Width;
        Height:=Screen.Height;
        Canvas.CopyRect(Rect(0,0,Width,Height), FCanvas, Rect(0,0,Width,Height));
      end;
  finally
    ReleaseDC(0, DC);
    FCanvas.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScreenSaver.SaverInit;
var
  tmp:Integer;
begin
  if FSaveBack then SaveBack;

  with TForm(owner) do
    begin
      Color:=FColor;
      SetWindowPos(Handle, HWND_TOPMOST, 0,0, Screen.Width, Screen.Height, SWP_SHOWWINDOW);
    end;

  if Assigned(FOnSaverStart) then FOnSaverStart(Self);
  while Showcursor(false)>-1 do;

  if not LMDSIOLDWINDOWSNT then
    SystemParametersInfo(SPI_SCREENSAVERRUNNING, 0, @tmp,0);

  FPosition:=Point(-5,-5);
  FEnabled:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDScreenSaver.ParseArgs;
var
  totest:Char;

begin
  FMode:=sscfgNoParent;
  if ParamCount=0 then
    exit
  else
    begin
      if Length(ParamStr(1))=2 then
        totest:=UpperCase(Paramstr(1))[2]
      else
        totest:=UpperCase(ParamStr(1))[1];
      case totest of
        'C':begin
              FMode:=sscfgParent;
              FWndHandle:=GetForeGroundWindow;
            end;
        'S':begin
              FMode:=ssFullView;
              FWndHandle:=GetForeGroundWindow;
            end;
        'P', 'L':if StrToInt(ParamStr(2))>0 then
              begin
                FMode:=ssPreview;
                if Paramstr(2)<>'' then FWndHandle:=StrToInt(ParamStr(2));
              end;
        'A':begin
              FMode:=ssCheckPassword;
              if ParamStr(2)<>'' then FWndHandle:=StrToInt(ParamStr(2));
            end;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScreenSaver.Quit;
begin
  Application.Terminate;
  Application.ProcessMessages;
  Halt;
end;

{----------------------------  Protected --------------------------------------}
procedure TLMDScreenSaver.Loaded;

begin
   inherited Loaded;
   if not (csDesigning in ComponentState) then
     begin
       FSection:='SCRNSAVE: ';
       if FTitle='' then
         FSection:=FSection+Application.Title
       else
         begin
           FSection:=FSection+FTitle;
           Application.Title:=FTitle;
         end;
       ParseArgs;
       case FMode of
         ssFullView:SaverInit;
         ssPreview:PrevInit;
         ssCheckPassWord:if not LMDSIWindowsNT then ChangePassWord;
       else
         begin
           TForm(owner).SetBounds(0,0,0,0);
           if Assigned(FOnSetupDlg) then FOnSetupDlg(Self);
           Quit;
         end;
       end
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDScreenSaver.WndProc(var Message: TMessage);
begin
   if not FEnabled then
     begin
       CallPrevWndProc(Message);    
       exit;
     end;

   with TMessage(Message) do
      case Msg of
        WM_SYSCOMMAND:
          with TWMSysCommand(Message) do
            if (cmdType=SC_SCREENSAVE) or (cmdType=SC_CLOSE) then
              result:=1
            else
              inherited WndProc(Message);
        WM_SETCURSOR:result:=1;
        WM_NCACTIVATE,
        WM_ACTIVATE,
        WM_ACTIVATEAPP:
          if Boolean(wParam)=False then SaverClose else inherited WndProc(Message);
        WM_LBUTTONDOWN,
        WM_MBUTTONDOWN,
        WM_RBUTTONDOWN:
          if ((FPosition.X=-5) and (FPosition.Y=-5)) or not SaverClose then inherited WndProc(Message);
        WM_KEYDOWN,
        WM_SYSKEYDOWN:
          if FNowClose then Tmessage(Message).Result:=1
          else
            if ((FPosition.X=-5) and (FPosition.Y=-5)) or
              not SaverClose then inherited WndProc(Message);
        WM_MOUSEMOVE:
          with TWMMouseMove(Message) do
            begin
              if (FPosition.X=-5) and (FPosition.Y=-5) then
                FPosition:=Point(Pos.X, Pos.Y)
              else
                if (Abs(FPosition.X-Pos.X)>3) or (Abs(FPosition.Y-Pos.Y)>3) then
                  begin
                    SaverClose;
                    exit;
                  end;
              inherited WndProc(Message);
            end;
      else
        CallPrevWndProc(Message);    
      end;
end;

{------------------------------  Public ---------------------------------------}
constructor TLMDScreenSaver.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, False) then
      raise ELMDOneInstError.Create(self.ClassName,0);

  FNowClose:=False;
  FBitmap:=TBitmap.Create;
  FColor:=clBlack;

  FIniFile:=TRegIniFile.Create(regEntry);

  FEnabled:=False;
  with TForm(owner) do
    begin
      Borderstyle:=bsNone;
      FormStyle:=fsNormal;
      Bordericons:=[];
      {Visible:=False;}
    end;

end;

{------------------------------------------------------------------------------}
Destructor TLMDScreenSaver.Destroy;
var
  tmp:Integer;
begin

  if FMode=ssPreview then
    if Assigned(FOnSaverEnd) then FOnSaverEnd(self);

  if FMode=ssFullView then
    begin
      ShowCursor(True);
      if not LMDSIOLDWINDOWSNT then
        SystemParametersInfo(SPI_SCREENSAVERRUNNING, Word(False), @tmp,0);
      SetForeGroundWindow(FWNDHandle);
    end;

  FIniFile.Free;
  FBitmap.Free;

  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDScreenSaver.ShowDialog(aForm:TForm):Integer;
begin
  if FMode in [sscfgParent, sscfgNoParent] then
    begin
      EnableWindow(FWNDHandle, False);
      result:=aForm.ShowModal;
      EnableWindow(FWNDHandle, True);
    end
  else
    result:=aForm.ShowModal;
end;

{------------------------------------------------------------------------------}
function IsIDERunning:Boolean;
var
  tmp:String;
begin
  tmp := UpperCase(ExtractFileName(Application.ExeName));
  result := (tmp = 'BCB.EXE') or (tmp = 'DELPHI32.EXE') or (tmp = 'BDS.EXE');
end;

initialization
  if not (IsLibrary or IsIDERunning) then
    begin
      SetWindowLong(Application.Handle, GWL_STYLE, WS_DISABLED);
      Application.ShowMainForm:=False;
    end;
end.
