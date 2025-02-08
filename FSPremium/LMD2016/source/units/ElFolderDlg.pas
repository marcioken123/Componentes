unit ElFolderDlg;
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

ElFolderDlg unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Forms, Controls, SysUtils, Classes, Messages, ActiveX,
  Types, MultiMon, ShlObj, StdCtrls, Dialogs, Menus, ElPopBtn,
  ElShellUtils, ElVCLUtils, LMDTypes, intfLMDBase, LMDUnicode, LMDSysIn;

type

  TBrowseForFolderOption = (bfoFileSysDirsOnly, bfoDontGoBelowDomain,
      bfoStatusText, bfoFileSysAncestors, bfoBrowseForComputer,
       bfBrowseForPrinter, bfoBrowseIncludeFiles, bfoShowPath, bfoNewDialogStyle, bfoAllowEdit);

  TBrowseForFolderOptions = set of TBrowseForFolderOption;

  TFolderDialogPosition = (fdpDefault, fdpScreenCenter, fdpDesktopCenter, fdpMainFormCenter, fdpOwnerFormCenter);

  TElFolderDialog = class (TCommonDialog, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FXDefWndProc: Pointer;
    ObjInstance : Pointer;
    FBrowseInfoW: TBrowseInfoW;
    FBrowseInfo: TBrowseInfoA;
    FCustBtn: TElPopupButton;
    FCustomButtonCaption: TLMDString;
    FDialogTitle: TLMDString;
    FDisplayNameAnsi: array[0..MAX_PATH] of AnsiChar;
    FDisplayNameUni: array[0..MAX_PATH] of WideChar;
    FFolderUni: WideString;
    FFolderAnsi: AnsiString;
    FFolderPIDL: PItemIDList;
    FHandle: Integer;
    FOnChange: TNotifyEvent;
    FOnCustomButtonClick: TNotifyEvent;
    FOptions: TBrowseForFolderOptions;
    FParent: TWinControl;
    FRootFolder: TShellFolders;
    FShowCustomButton: Boolean;
    JustInit : boolean;
    OriginalSelect : boolean;
    FVisible: Boolean;
    FEnableCustomButton: Boolean;
    function GetFolder: TLMDString;
    function GetParent: TWinControl;
    procedure SetFolder(const Value: TLMDString);
    procedure SetParent(Value: TWinControl);
    procedure SetRootFolder(Value: TShellFolders);
    procedure SetEnableCustomButton(const Value: Boolean);
  protected
    FCustomRootFolder: TLMDString;
    FStatusText: TLMDString;
    FPrompt: TLMDString;
    FPosition: TFolderDialogPosition;
    function  Perform(Msg: Cardinal; WParam, LParam: Longint): LongInt;
    procedure SetStatusText(const Value: TLMDString);
    public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure DefaultHandler(var Message); override;
    // ToDo Alex  --> virtual in base class, must be (senseful) overriden
  function Execute: Boolean; override;
  function ExecuteModal: Boolean;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure SetSelectionPIDL(PIDL : PItemIDList);
    procedure WinInitialized(Param : Integer);
    procedure WinSelChanged(Param : Integer);
    function getLMDPackage:TLMDPackageID;
    property Handle: Integer read FHandle;
    property SelectionPIDL : PItemIDList read FFolderPIDL;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Parent: TWinControl read GetParent write SetParent stored false;
    property DialogTitle: TLMDString read FDialogTitle write FDialogTitle;
    property CustomButtonCaption: TLMDString read FCustomButtonCaption write FCustomButtonCaption;
    property Folder: TLMDString read GetFolder write SetFolder;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnCustomButtonClick: TNotifyEvent read FOnCustomButtonClick write FOnCustomButtonClick;
    property Options: TBrowseForFolderOptions read FOptions write FOptions default [];
    property RootFolder: TShellFolders read FRootFolder write SetRootFolder default sfoDesktopExpanded;
    property ShowCustomButton: Boolean read FShowCustomButton write FShowCustomButton default false;
    property CustomRootFolder: TLMDString read FCustomRootFolder write FCustomRootFolder;
    property StatusText: TLMDString read FStatusText write SetStatusText;
    property Prompt: TLMDString read FPrompt write FPrompt;
    property Position: TFolderDialogPosition read FPosition write FPosition default fdpDefault;
    property EnableCustomButton: Boolean read FEnableCustomButton write SetEnableCustomButton default true;
  end;

implementation

uses
  LMDProcs;

var
  DialogBaseUnits: packed record
    X, Y: word;
  end;

function BrowseCallback(wnd : HWND; msg : integer; LParam, lpData : Integer): Integer; stdcall;

begin
  with TObject(lpData) as TElFolderDialog do
  case msg of
    BFFM_INITIALIZED:
      begin
        FHandle := Wnd;
        FXDefWndProc := pointer(SetWindowLong(FHandle, GWL_WNDPROC, TLMDPtrInt(ObjInstance)));
        WinInitialized(wnd);
      end;
    BFFM_SELCHANGED:
      if not JustInit then
         WinSelChanged(lParam);
    end;
  result := 0;
end;

{:
}
{
******************************* TElFolderDialog ********************************
}

constructor TElFolderDialog.Create(AOwner : TComponent);
begin
  inherited;
  ObjInstance := MakeObjectInstance(WndProc);
  FEnableCustomButton := True;
end;

destructor TElFolderDialog.Destroy;
begin
  if Handle <> 0 then
     Perform(WM_SYSCOMMAND, SC_CLOSE, 0); { just to be sure }
  if Assigned(ObjInstance) then
    FreeObjectInstance(ObjInstance);
  if FFolderPIDL <> nil then
     FreeIDList(FFolderPIDL);

  inherited Destroy;
end;

function TElFolderDialog.ExecuteModal: Boolean;
var
  WinList: Pointer;
begin
  WinList := DisableTaskWindows(0);
   try
     result := Execute;
   finally
     EnableTaskWindows(WinList);
   end;
end;

function TElFolderDialog.Execute: Boolean;
 { EK : this was in code and brings to "declaration os 'execute' differs from previous declaration" in win32
  function TElFolderDialog.Execute(ParentWnd: HWND): Boolean;
  begin
  end;
  }
var
  P: PItemIDList;
  I: Integer;
  SaveFolder : string;

  const
    BIF_NEWDIALOGSTYLE = $0040;

  const
    BROWSEFLAGS: array[TBrowseForFolderOption] of Cardinal =
      (BIF_RETURNONLYFSDIRS, BIF_DONTGOBELOWDOMAIN, BIF_STATUSTEXT,
       BIF_RETURNFSANCESTORS, BIF_BROWSEFORCOMPUTER, BIF_BROWSEFORPRINTER,
       BIF_BROWSEINCLUDEFILES, 0, BIF_NEWDIALOGSTYLE, BIF_EDITBOX);

begin
  if not FVisible then
  begin
    SaveFolder := Folder;
    if LMDSIWindowsNTUp then
    begin
      FillChar(FBrowseInfoW, sizeof(FBrowseInfoW), 0);
      //if Parent <> nil then
      FBrowseInfoW.hwndOwner := Application.Handle;//GetDesktopWindow; //Parent.Handle;
      FBrowseInfoW.pszDisplayName := FDisplayNameUni;
      FBrowseInfoW.lpszTitle := Int_refW(FPrompt);
      FBrowseInfoW.LParam := TLMDPtrUInt(Self);
      FBrowseInfoW.lpfn := @BrowseCallback;
      FBrowseInfoW.pidlRoot := GetFolderPIDL2(FRootFolder, CustomRootFolder);
      for i := 0 to Ord(bfoAllowEdit) do
        if TBrowseForFolderOption(i) in FOptions then
           FBrowseInfoW.ulFlags := FBrowseInfoW.ulFlags or BROWSEFLAGS[TBrowseForFolderOption(i)];
    end
    else
    begin
      FillChar(FBrowseInfo, sizeof(FBrowseInfo), 0);
      //if Parent <> nil then
      FBrowseInfo.hwndOwner := Application.Handle;//GetDesktopWindow; //Parent.Handle;
      FBrowseInfo.pszDisplayName := FDisplayNameAnsi;
      FBrowseInfo.lpszTitle := Int_ref(AnsiString(FPrompt));
      FBrowseInfo.LParam := TLMDPtrUInt(Self);
      FBrowseInfo.lpfn := @BrowseCallback;
      FBrowseInfo.pidlRoot := GetFolderPIDL2(FRootFolder, CustomRootFolder);

      for i := 0 to Ord(bfoAllowEdit) do
        if TBrowseForFolderOption(i) in FOptions then
           FBrowseInfo.ulFlags := FBrowseInfo.ulFlags or BROWSEFLAGS[TBrowseForFolderOption(i)];
    end;
    JustInit := true;
    OriginalSelect := true;
    FVisible := true;

    CoInitializeEx(nil, COINIT_APARTMENTTHREADED);

    if LMDSIWindowsNTUp then
      P := SHBrowseForFolderW(FBrowseInfoW)
    else
      P := SHBrowseForFolderA(FBrowseInfo);

    CoUninitialize();
    FVisible := false;
    FHandle := 0;
    result := P <> nil;
    if FCustBtn <> nil then
    begin
      FCustBtn.Free;
      FCustBtn := nil;
    end;
    if Result then
    begin
      if (bfoBrowseForComputer in Options) then
      begin
        if LMDSIWindowsNTUp then
          Folder := LMDWideStrPas(FDisplayNameUni)
        else
          Folder := TLMDString(StrPas(FDisplayNameAnsi));

      if P <> nil then
         FreeIDList(P);
      end
      else
      begin
        SetSelectionPIDL(P);
      end;
    end
    else
    begin
      Folder := SaveFolder;
    end;
  end
  else
  begin
    SetFocus(Handle);
    Result := P <> nil;
  end;
end;

function TElFolderDialog.GetFolder: TLMDString;
begin
  if Assigned(FFolderPIDL) then
    GetPathFromPIDL(FFolderPIDL, Result)
  else
    if LMDSIWindowsNTUp then
      Result := TLMDString(FFolderUni)
    else
      Result := TLMDString(FFolderAnsi);
end;

function TElFolderDialog.GetParent: TWinControl;
begin
  {
  if FParent = nil then
  begin
    if Assigned(Owner) and (Owner is TWinControl) then
       Parent := Owner as TWinControl
    else
       if Assigned(Application.MainForm) then
          Parent := Application.MainForm;
  end;
  }
  result := nil;
end;

procedure TElFolderDialog.Notification(AComponent : TComponent; Operation :
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FParent) and (Operation = opRemove) then
    Parent := nil;
end;

procedure TElFolderDialog.SetEnableCustomButton(const Value: Boolean);
begin
  FEnableCustomButton := Value;
end;

procedure TElFolderDialog.SetFolder(const Value: TLMDString);
begin
  if LMDSIWindowsNTUp then
    FFolderUni := TLMDString(Value)
  else
    FFolderAnsi := AnsiString(Value);
  SetSelectionPIDL(GETPIDLFromPath(Value));
end;

procedure TElFolderDialog.SetParent(Value: TWinControl);
begin
  (*
  if FParent <> Value then
  begin

    if FParent <> nil then
      if not (csDestroying in FParent.ComponentState) then
        FParent.RemoveFreeNotification(Self);

    FParent := Value;
    if FParent <> nil then
      FParent.FreeNotification(Self);
  end;
  *)
end;

procedure TElFolderDialog.SetRootFolder(Value: TShellFolders);
begin
  FRootFolder := Value;
end;

procedure TElFolderDialog.SetSelectionPIDL(PIDL : PItemIDList);
begin
  WinSelChanged(Integer(PIDL));
  if PIDL <> nil then
    FreeIDList(PIDL);
  //if Handle <> 0 then
    //Perform(BFFM_SETSELECTION, integer(FALSE), integer(PIDL));
end;

procedure TElFolderDialog.DefaultHandler(var Message);
begin
  if FHandle <> 0 then
    with TMessage(Message) do
      Result := CallWindowProc(FXDefWndProc, FHandle, Msg, WParam, LParam)
  else
    inherited DefaultHandler(Message);
end;

function TElFolderDialog.Perform(Msg: Cardinal; WParam, LParam: Longint): Longint;
var
  Message: TMessage;
begin
  Message.Msg := Msg;
  Message.WParam := WParam;
  Message.LParam := LParam;
  Message.Result := 0;
  if Self <> nil then WndProc(Message);
  Result := Message.Result;
end;

procedure TElFolderDialog.WinInitialized(Param : Integer);
var
  //s: String;
  R: TRect;
  P1, P2: TPoint;
  TreeRect, OkBtnRect, DlgRect: TRect;
  FClientWidth, FClientHeight: Integer;
  APIDL : PItemIDList;
  X, Y, Width, Height : integer;
  CenterForm: TCustomForm;

  procedure RecalcRect(var R : TRect);
  begin
    with R do
    begin
      Right := ((Right + Left) * DialogBaseUnits.X) div 4;
      Bottom:= ((Bottom + Top) * DialogBaseUnits.Y) div 8;
      Left  := (Left * DialogBaseUnits.X) div 4;
      Top   := (Top * DialogBaseUnits.Y) div 8;
    end;
  end;

  function ScaledX(X : integer): Integer;
  begin
    result := 1 + ((X * FClientWidth) div (DlgRect.Right - DlgRect.Left));
  end;

  function ScaledY(Y : integer): Integer;
  begin
    Result:= 1 + ((Y * FClientHeight) div (DlgRect.Bottom - DlgRect.Top));
  end;

begin
  JustInit := false;

  SetWindowText(Param, Int_ref(FDialogTitle));
  SetStatusText(FStatusText);

  if ShowCustomButton then
  begin
    Windows.GetClientRect(Param, R);
    FClientWidth := R.Right;
    FClientHeight:= R.Bottom;
    DlgRect := Rect(46, 21, 212, 188);
    RecalcRect(DlgRect);
    TreeRect := Rect(7,42,197,112);
    RecalcRect(TreeRect);
    OkBtnRect := Rect(100, 166, 50, 14);
    RecalcRect(OkBtnRect);
    FCustBtn := TElPopupButton.Create(nil);
    FCustBtn.ParentWindow := Param;
    FCustBtn.Caption := CustomButtonCaption;
    FCustBtn.OnClick := OnCustomButtonClick;
//    FCustBtn.ControlStyle := FCustBtn.ControlStyle + [csClickEvents];
    P1.X := ScaledX(TreeRect.Left)+1;
    P1.Y := ScaledY(OkBtnRect.Top)-1;
    P2.X := ScaledX(OkBtnRect.Right - OkBtnRect.Left)+1;
    P2.Y := ScaledY(OkBtnRect.Bottom - OkBtnRect.Top)-1;
    FCustBtn.SetBounds(P1.X, P1.Y, P2.X, P2.Y);
    FCustBtn.Enabled := FEnableCustomButton;
  end;
  APIDL := ClonePIDL(FFolderPIDL);
  SetSelectionPIDL(APIDL);
  // FreeIDList(APIDL);
  GetWindowRect(Param, R);
  Width := R.Right - R.Left;
  Height := R.Bottom - R.Top;
  case Position of
    fdpScreenCenter:
      begin
        X := (Screen.Width - Width) div 2;
        Y := (Screen.Height - Height) div 2;
        if X < 0 then X := 0;
        if Y < 0 then Y := 0;
        SetWindowPos(Param, 0, X, Y, Width, Height, SWP_NOZORDER or SWP_NOACTIVATE);
      end;
    fdpDesktopCenter:
      begin
        X := (Screen.DesktopWidth - Width) div 2;
        Y := (Screen.DesktopHeight - Height) div 2;
        if X < 0 then X := 0;
        if Y < 0 then Y := 0;
        SetWindowPos(Param, 0, X, Y, Width, Height, SWP_NOZORDER or SWP_NOACTIVATE);
      end;
    fdpMainFormCenter,
    fdpOwnerFormCenter:
      begin
        CenterForm := Application.MainForm;
        if (Position = fdpOwnerFormCenter) and (Owner is TCustomForm) then
          CenterForm := TCustomForm(Owner);
        if Assigned(CenterForm) then
        begin
          X := ((CenterForm.Width - Width) div 2) + CenterForm.Left;
          Y := ((CenterForm.Height - Height) div 2) + CenterForm.Top;
        end else
        begin
          X := (Screen.Width - Width) div 2;
          Y := (Screen.Height - Height) div 2;
        end;
        if X < 0 then X := 0;
        if Y < 0 then Y := 0;
        SetWindowPos(Param, 0, X, Y, Width, Height, SWP_NOZORDER or SWP_NOACTIVATE);
      end;
  end;
end;

procedure TElFolderDialog.WinSelChanged(Param : Integer);
var
  S: TLMDString;
begin
  FreeIDList(FFolderPIDL);
  FFolderPIDL := nil;
  if Param <> 0 then
  begin
    FFolderPIDL := ClonePIDL(PItemIDList(Param));

    GetPathFromPIDL(FFolderPIDL, S);

    if (S = '') and (bfoBrowseForComputer in Options) then
      if LMDSIWindowsNTUp then
        FFolderUni := LMDWideStrPas(FDisplayNameUni)
      else
        FFolderAnsi := StrPas(FDisplayNameAnsi);
    (*
    if Length(S) > 0 then
      SendMessage(Handle, BFFM_SETSELECTION, Ord(true), Integer(PChar(S)))
    else
    *)
    if OriginalSelect then
    begin
      SendMessage(Handle, BFFM_SETSELECTION, Ord(false), Integer(FFolderPIDL));
      OriginalSelect := false;
    end;
    if bfoShowPath in Options then
    begin
      if LMDSIWindowsNTUp then
        SendMessage(FHandle, BFFM_SETSTATUSTEXTW, 0, DWORD(PWideChar(FFolderUni)))
      else
        SendMessage(FHandle, BFFM_SETSTATUSTEXT, 0, DWORD(PAnsiChar(FFolderAnsi)));
    end;
    if Assigned(FOnChange) then FOnChange(Self);
    if Assigned(FCustBtn) then
      FCustBtn.Enabled := FEnableCustomButton;
  end;
end;

procedure TElFolderDialog.SetStatusText(const Value: TLMDString);
begin
  FStatusText := Value;
  if FVisible and (FHandle <> 0) then
    if LMDSIWindowsNTUp then
      SendMessage(FHandle, BFFM_SETSTATUSTEXTW, 0, DWORD(PWideChar(Value)))
    else
      SendMessage(FHandle, BFFM_SETSTATUSTEXT, 0, DWORD(PAnsiChar(AnsiString(Value))));
end;

function TElFolderDialog.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

initialization
  longint(DialogBaseUnits) := GetDialogBaseUnits;
end.
