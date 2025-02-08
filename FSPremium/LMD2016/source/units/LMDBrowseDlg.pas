unit LMDBrowseDlg;
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

LMDBrowseDlg unit (RM)
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Forms, SHLObj, LMDClass,
  LMDCustomComponent, LMDShUtils;

const
  LMD_MAX_STATUSPATH=40;

type
  TLMDBrowseDlgOption=(doBrowseForComputer, doBrowseForPrinter, doDontGoBelowDomain,
                       doReturnFileSysAncestors, doReturnFileSysDirs,
                       doStatusText, doShowFiles, doAllowEdit, doShowPath,
                       doEnableOK, doNewGUI, doNewGUINoNewFolderBtn);

  TLMDBrowseDlgOptions=set of TLMDBrowseDlgOption;

  TLMDSystemFolders=(
    bfoDesktop,bfoDesktopExpanded,bfoPrograms,bfoControlPanel,
    bfoPrinters,bfoPersonal,bfoFavorites,bfoStartup,bfoRecent,
    bfoSendto,bfoRecycleBin,bfoStartMenu,bfoDesktopDirectory,bfoMyComputer,
    bfoNetwork,bfoNetworkNeighborhood,bfoInternet,bfoFonts,bfoTemplates,
    bfoCommonStartMenu, bfoCommonPrograms, bfoCommonStartup,
    bfoCommonDesktopDirectory, bfoAppData, bfoPrintHood,
    // 5.0
    bfoAltStartup, bfoCommonAltstartup, bfoCommonFavorites, bfoInternetChache,
    bfoCookies, bfoHistory,
    // 7.04
    bfoProfile, bfoConnections, bfoCommonMusic, bfoCommonPictures, bfoCommonVideos,
    bfoCDBurnArea, bfpProfiles
    );

  TLMDBrowseDlgSelectionChangeEvent=procedure(Sender:TObject; DialogHandle:Hwnd;
                                              path:string; item:PItemIDList) of object;

  TLMDBrowseDlgEditValidateEvent=procedure(Sender:TObject; path:string;
                                           var Cancel: boolean) of object;

  TLMDBrowseDlg=class(TLMDCustomComponent)
  private
    FPath,
    FDisplayName,
    FCaption,
    FCaptionTitle,
    FStatusText: String;
    FHandle: HWnd;
    FOnInit:TNotifyEvent;
    FOnValidate:TLMDBrowseDlgEditValidateEvent;
    FOnSelectionChanged: TLMDBrowseDlgSelectionChangeEvent;
    FDlgPosRel: TLMDDlgPosRel;
    FOptions:TLMDBrowseDlgOptions;
    FPosition:TLMDDlgPosition;
    FStartFolder:TLMDSystemFolders;
    FSelected:PItemIDList;
    procedure SetPath(const aValue:String);
    procedure SetStatusText(const aValue:string);
    procedure SetSelected(aValue:PItemIDList);

  protected
    procedure DoInit;
    procedure DoSelectionChange(aValue:PItemIDList);
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    function ConvertPathToItemIDList(const aPath:String; ItemIDList: PItemIDList):Boolean;
    procedure EnableOKButton(aValue:Boolean);
    function ExecuteEnh(Main:TCustomForm):Boolean;
    function Execute:Boolean;

    property SelectedItemID:PItemIDList read FSelected write SetSelected;
    property SelectedName:String read FDisplayName;
  published
    property About;
    property CaptionTitle:String read FCaptionTitle write FCaptionTitle;
    property Caption:String read FCaption write FCaption;
    property StartFolder:TLMDSystemFolders read FStartFolder write FStartFolder default bfoDesktopExpanded;
    property Options:TLMDBrowseDlgOptions read FOptions write FOptions default [doReturnFileSysDirs, doShowPath];
    property SelectedFolder:String read FPath write SetPath; // stored false;
    property Position:TLMDDlgPosition read FPosition write FPosition default bpCenter;
    property RelatePos:TLMDDlgPosRel read FDlgPosRel write FDlgPosRel default brActiveWindow;
    property StatusText:String read FStatusText write SetStatusText;
    property OnInit:TNotifyEvent read FOnInit write FOnInit;
    property OnSelectionChanged:TLMDBrowseDlgSelectionChangeEvent read FOnSelectionChanged write FOnSelectionChanged;
    property OnValidate:TLMDBrowseDlgEditValidateEvent read FOnValidate write FOnValidate;
  end;

implementation

uses

  ShellApi,
  ComObj,
  ActiveX,
  SysUtils,
  Messages,
  FileCtrl, //DirectoryExists
  LMDProcs,
  LMDUtils;

{------------------ CallBack Procedure for BrowseFolderDialog -----------------}

function BrowseCallback(hWnd: HWND; uMsg: UINT; lParam: LPARAM; lpData: LPARAM):Integer;stdcall;
var
  cancel:Boolean;
begin
  result:=0;
  if TObject(lpdata) is TLMDBrowseDlg then
    with TLMDBrowseDlg(lpdata) do
      case uMsg of
        BFFM_INITIALIZED:
          begin
            FHandle:=HWnd;
            DoInit;
          end;
        BFFM_SELCHANGED:
          DoSelectionChange(PItemIDList(lParam));
        BFFM_VALIDATEFAILED:
          begin
            Cancel:=false;
            if Assigned(FOnValidate) then OnValidate(TLMDBrowseDlg(lpdata), string(lParam),Cancel);
            result:=Ord(Cancel=True);
          end;
        end;
end;

{*************************** Class TLMDBrowseDlg *****************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDBrowseDlg.SetStatusText(const aValue:String);
begin
  if aValue<>FStatusText then
    begin
      FStatusText:=aValue;
      if FHandle<>0 then

        SendMessage(FHandle, BFFM_SETSTATUSTEXT, 0, LPARAM(FStatusText));

    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBrowseDlg.SetPath(const aValue:String);
begin
  if aValue<>FPath then
    begin
      FPath:=aValue;
      if FHandle<>0 then

        SendMessage(FHandle, BFFM_SETSELECTION, WPARAM(True), LPARAM(FPath));

    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBrowseDlg.SetSelected(aValue:PItemIDList);
begin
  SendMessage(FHandle, BFFM_SETSELECTION, Ord(False), LPARAM(aValue));
end;

{------------------------------ Protected -------------------------------------}
procedure TLMDBrowseDlg.DoInit;
var
  aRect:TRect;
begin

  //window title
  if FCaptionTitle<>'' then

    SendMessage(FHandle, WM_SETTEXT, 0, LPARAM(FCaptionTitle));

  //StatusText
  if FStatusText <> '' then

    SendMessage(FHandle, BFFM_SETSTATUSTEXT, 0, LParam(FStatusText));

  //Restore Path
  if FPath<>'' then

    SendMessage(FHandle, BFFM_SETSELECTION, WPARAM(True), LPARAM(FPath));

  //OK-Button
  SendMessage(FHandle, BFFM_ENABLEOK, 0, LPARAM(doEnableOK in FOptions));

  if csDesigning in ComponentState then
    aRect:=LMDDlgGetTargetRect(brScreenWorkArea)
  else
    aRect:=LMDDlgGetTargetRect(FDlgPosRel);

  LMDPositionWindow(FHandle, aRect, FPosition, false);

  if Assigned(FOnInit) then FOnInit(Self);
end;

{------------------------------------------------------------------------------}
function  LMDSHGetPathFromIDList(aValue: PItemIDList): string;
var

  Buf: array[0..MAX_PATH] of Char;

begin

  SHGetPathFromIDList(aValue, @Buf);
  Result := Trim(string(Buf));

end;

{------------------------------------------------------------------------------}
procedure TLMDBrowseDlg.DoSelectionChange(aValue:PItemIDList);
var
  PathName: string;
begin
  if (doShowPath in FOptions) or Assigned(FOnSelectionChanged) then
    begin
      PathName := LMDSHGetPathFromIDList(aValue);
      if doShowPath in FOptions then
        begin
          StatusText:=LMDShrunkFileName(PathName, LMD_MAX_STATUSPATH);
        end;
      if Assigned(FOnSelectionChanged) then
        FOnSelectionChanged(Self, FHandle, PathName, aValue);
    end;
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDBrowseDlg.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FOptions:=[doReturnFileSysDirs, doShowPath];
  FStartFolder:=bfoDesktopExpanded;
  FPosition:=bpCenter;
  FDlgPosRel:=brActiveWindow;
  FSelected:=nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDBrowseDlg.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDBrowseDlg.ConvertPathToItemIDList(const aPath:String; ItemIDList: PItemIDList):Boolean;
var
  shi:IShellFolder;
  v1, v2:ULONG;
begin
  result:=False;
  if SHGetDesktopFolder(shi) = NOERROR then
    try
      if DirectoryExists(aPath) then
        begin

          shi.ParseDisplayName(0,nil,StringToOleStr(aPath), v1,ItemIDList,v2);

          result:=true;
        end;
    finally
      shi := nil;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBrowseDlg.EnableOKButton(aValue:Boolean);
begin
  SendMessage(FHandle, BFFM_ENABLEOK, 0, LPARAM(aValue));
end;

{------------------------------------------------------------------------------}
function TLMDBrowseDlg.ExecuteEnh(Main:TCustomForm):Boolean;
const
  {$IFNDEF LMDCOMP9}
  BIF_NEWDIALOGSTYLE=$0040;
  BIF_NONEWFOLDERBUTTON = $200;
  {$ENDIF}
  FOLDERS:array[TLMDSystemFolders] of Integer=
         (CSIDL_DESKTOP, $FEFE, CSIDL_PROGRAMS, CSIDL_CONTROLS, CSIDL_PRINTERS, CSIDL_PERSONAL,
          CSIDL_FAVORITES, CSIDL_STARTUP, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_BITBUCKET,
          CSIDL_STARTMENU, CSIDL_DESKTOPDIRECTORY, CSIDL_DRIVES, CSIDL_NETWORK, CSIDL_NETHOOD,
          $0001, //CSIDL_INTERNET
          CSIDL_FONTS, CSIDL_TEMPLATES, CSIDL_COMMON_STARTMENU, CSIDL_COMMON_PROGRAMS,
          CSIDL_COMMON_STARTUP, CSIDL_COMMON_DESKTOPDIRECTORY, CSIDL_APPDATA, CSIDL_PRINTHOOD,
          $001d,$001e,$001f,$0020, $0021, $0022, $0028, $0031, $0035, $0036, $0037, $003b, $003e);

  FLAGS:array[TLMDBrowseDlgOption] of WORD=
          (BIF_BROWSEFORCOMPUTER,BIF_BROWSEFORPRINTER,BIF_DONTGOBELOWDOMAIN,
           BIF_RETURNFSANCESTORS, BIF_RETURNONLYFSDIRS,BIF_STATUSTEXT,
           BIF_BROWSEINCLUDEFILES, BIF_EDITBOX,0,0, BIF_NEWDIALOGSTYLE, BIF_NONEWFOLDERBUTTON);

var
  i:TLMDBrowseDlgOption;
  IDList: PItemIDList;
  BrowseInfo: TBrowseInfo;
  PathName: string;//array[0..MAX_PATH] of char;
  DisplayName: array[0..MAX_PATH] of char;
  CoInitResult: HRESULT;
  WindowList: Pointer;
  OldErrorMode: Cardinal;
begin
  DisplayName:='';
  {initialize the browse information structure}
  if not Assigned(main) then
    BrowseInfo.hwndOwner:=0
  else
    BrowseInfo.hwndOwner:=Main.Handle;

  SHGetSpecialFolderLocation(FHandle, Folders[FStartFolder], BrowseInfo.pidlRoot);
  BrowseInfo.lpfn:=BrowseCallback;

  BrowseInfo.lParam:=LParam(Self);
  BrowseInfo.lpszTitle:=PChar(FCaption);
  DisplayName[0] := #0;
  BrowseInfo.pszDisplayName:=DisplayName;

  IDList:=nil;
  BrowseInfo.ulFlags:=0;
  for i:=Low(TLMDBrowseDlgOption) to High(TLMDBrowseDlgOption) do
    if TLMDBrowseDlgOption(i) in FOptions then
      BrowseInfo.ulFlags:=BrowseInfo.ulFlags or Flags[TLMDBrowseDlgOption(i)];

  if doAllowEdit in FOptions then
    BrowseInfo.ulFlags := BrowseInfo.ulFlags or BIF_VALIDATE;

  try
    if doNewGUI in FOptions then
      begin
        CoInitResult := CoInitializeEx(nil, COINIT_APARTMENTTHREADED);
        if CoInitResult = RPC_E_CHANGED_MODE then
          begin
            BrowseInfo.ulFlags := BrowseInfo.ulFlags and not BIF_NEWDIALOGSTYLE;
            BrowseInfo.ulFlags := BrowseInfo.ulFlags and not BIF_NONEWFOLDERBUTTON;
          end;
      end;

    WindowList := DisableTaskWindows(0);
    OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
    try
      IDList:=SHBrowseForFolder(BrowseInfo);
    finally
      SetErrorMode(OldErrorMode);
      EnableTaskWindows(WindowList);
    end;

    {retrieve the path from the item identifier list that was returned}
    PathName := LMDSHGetPathFromIDList(IDList);
  finally
    if doNewGUI in FOptions then
      CoUninitialize;
    FHandle:=0;
    Result:=IDList<> nil;
  end;

  if result then
    begin
      FPath := PathName;

      FDisplayName := BrowseInfo.pszDisplayName;

    end;

end;

{------------------------------------------------------------------------------}
function TLMDBrowseDlg.Execute:Boolean;
begin
  if Assigned(Owner) and (Owner.InheritsFrom(TCustomForm)) then
    result:=ExecuteEnh(TCustomForm(Owner))
  else
    result:=ExecuteEnh(Application.MainForm)
end;

end.
