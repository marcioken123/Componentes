unit LMDShDlg;
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

LMDShDlg unit (DS)
------------------------
Contains shell dialogs components.


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Forms, Classes, Graphics, Dialogs, SysUtils, ShlObj,
  LMDShBase, LMDShMisc, LMDShUtils;

type

{ ************************ class TLMDShellAboutDialog ************************ }
  TLMDShellAboutDialog = class(TLMDShellBaseDialog)
  private
    FCaption: String;
    FOtherText: String;
    FProduct: String;
    FIcon: TIcon;
    function StoreIcon: Boolean;
    procedure SetIcon(Value: TIcon);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(aHWND: HWND=0): Boolean;override;
  published
    property Caption: String read FCaption write FCaption;
    property Icon: TIcon read FIcon write SetIcon stored  StoreIcon;
    property Product: String read FProduct write FProduct;
    property Text: String read FOtherText write FOtherText;
  end;

  TLMDShellCustomBaseDialog = class(TLMDShellBaseDialog)
  private
    fShellDLL: HMODULE;
  protected
//    function int_GetProcAddress(const Name: string): FARPROC; overload;
    function int_GetProcAddress(Index: integer): FARPROC; overload;
    function int_Execute(aHWND: HWND=0): Boolean; virtual;
  public
    function Execute(aHWND: HWND=0): Boolean; override;
  end;
{ ********************* class TLMDShellFormatDriveDialog ********************* }
  TLMDShellFormatResult = (frFormatSucceeded, frFormatCancelled,
    frDriveNotFormatable, frFormatError);

  TLMDShellFormatOption = (forDefaultQuickFormat, forDefaultSysOnly,
    forRememberLast, forSuppressPrompt);
  TLMDShellFormatOptions = set of TLMDShellFormatOption;

  TLMDShellFormatDriveDialog = class(TLMDShellBaseDialog)
  private
    FResult: TLMDShellFormatResult;
    FLastFormatID: UINT;
    FDriveToFormat: Char;
    FOptions: TLMDShellFormatOptions;
    procedure SetDrive(Value: Char);
  public
    constructor Create( aOwner: TComponent); override;
    function Execute(aHWND:HWND=0):Boolean;override;
    property LastFormatResult: TLMDShellFormatResult read FResult;
  published
    property Options: TLMDShellFormatOptions read FOptions write FOptions
      default [forRememberLast, forSuppressPrompt];
    property DriveToFormat: Char read FDriveToFormat write SetDrive;
  end;

{ ********************** class TLMDShellPickIconDialog *********************** }
  TLMDShellPickIconDialog = class(TLMDShellCustomBaseDialog)//TLMDShellBaseDialog)
  private
    FIconIndex: DWORD;
    FIcon: TIcon;
    FFileName: TFileName;
    function GetIcon: TIcon;
  protected
    function int_Execute(aHWND:HWND=0):Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
//    function Execute(aHWND:HWND=0):Boolean;override;
    property Icon: TIcon read GetIcon;
  published
    property FileName: TFileName read FFileName write FFileName;
    property IconIndex: DWORD read FIconIndex  write FIconIndex  default 0;
  end;

{ *********************** class TLMDShellRunFileDialog *********************** }
  TLMDShellRunFileOption = ( rfNoBrowseButton, rfNoDefaultPick,
    rfCalculateWorkPath, rfNoEditLabel, rfNoSeparateMemory);
  TLMDShellRunFileOptions = set of TLMDShellRunFileOption;

  TLMDShellRunFileAction = (raRun, raCancel, raRetry);

  TLMDShellRunFileValidateEvent = procedure(Sender: TObject; TheFile: TFileName;
    TheWorkPath: TFileName; Visible: Boolean;
    var Action: TLMDShellRunFileAction) of object;

  TLMDShellRunFileDialog = class(TLMDShellCustomBaseDialog)//TLMDShellBaseDialog)
  private
    FCaption :String;
    FDescription: String;
    FIcon: TIcon;
    FMessageWindow: HWND;
    FOptions: TLMDShellRunFileOptions;
    FWorkingPath: TFileName;
    FOnValidate: TLMDShellRunFileValidateEvent;
    procedure SetIcon(Value: TIcon);
    function StoreIcon: Boolean;
    procedure HandleMessage(var aMessage: TMessage);
  protected
    procedure DoValidate(TheFile: TFileName; TheWorkPath: TFileName;
      Visible: Boolean; var Action: TLMDShellRunFileAction); virtual;
    function int_Execute(aHWND: HWND = 0): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
//    function Execute(aHWND:HWND=0):Boolean;override;
  published
    property Caption: String read FCaption write FCaption;
    property Description: String  read FDescription write FDescription;
    property Icon: TIcon read FIcon write SetIcon stored StoreIcon;
    property Options: TLMDShellRunFileOptions read FOptions write FOptions default [];
    property WorkingPath: TFileName read FWorkingPath write FWorkingPath;
    property OnValidate: TLMDShellRunFileValidateEvent read FOnValidate write FOnValidate;
  end;

{ *********************** class TLMDShellRestartDialog *********************** }
  TLMDShellRestartOption = (roLogoff, roShutdown, roReboot, roRestartWindows,
    roRebootSystem, roExitAndExecApp);
  TLMDShellRestartOptions = set of TLMDShellRestartOption;

  TLMDShellRestartDialog = class(TLMDShellCustomBaseDialog)//TLMDShellBaseDialog)
  private
    FReason:        String;
    FRestartOption: TLMDShellRestartOption;
  protected
    function int_Execute(aHWND: HWND = 0): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
  published
    property Reason: String read FReason write FReason;
    property RestartOption: TLMDShellRestartOption read FRestartOption write
      FRestartOption  default roRestartWindows;
  end;

{ ************************* class TLMDShellFindDialog ************************ }
  TLMDShellFindMode = (fmFiles, fmComputer);

  TLMDShellFindDialog = class(TLMDShellCustomBaseDialog)//TLMDShellBaseDialog)
  private
    FSearchFileName: TFileName;
    FRootShellFolder: PItemIDList;
    FMode: TLMDShellFindMode;
    FRootFolder: TLMDRoot;
    FOldStyle:Boolean;
    procedure SetRootFolder(Value: TLMDRoot);
    procedure LoadCustomFolder(Reader: TReader);
    procedure LoadSystemFolder(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function int_Execute(aHWND: HWND = 0): Boolean; override;
    function int_FindComputer: Boolean;
    function int_FindFiles: Boolean;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function FindComputer: Boolean; virtual;
    function FindFiles: Boolean; virtual;
//    function Execute(aHWND:HWND=0):Boolean;override;
    function ExecuteEx(Mode: TLMDShellFindMode; aHWND: HWND = 0): Boolean;
    property RootShellFolder: PItemIDList read FRootShellFolder;
  published
    property SearchFileName: TFileName read FSearchFileName write FSearchFileName;
    property RootFolder: TLMDRoot read FRootFolder write SetRootFolder;
    property Mode: TLMDShellFindMode read FMode write FMode default fmFiles;
    property OldStyle:Boolean read FOldStyle write FOldStyle default false;
  end;

{ ********************** class TLMDShellSysBrowseDialog ********************** }
  TLMDShellBrowseFilter = (bfBrowseForAnything, bfBrowseForComputers,
    bfBrowseForDirectories, bfBrowseForFileAncestors, bfBrowseForPrinters);
  TLMDShellBrowseFilters= set of TLMDShellBrowseFilter;

  TLMDShellBrowseOKState = (osDefaultState, osEnableOK, osDisableOK);
  TLMDShellBrowseOKStates = set of TLMDShellBrowseOKState;

  TLMDShellBrowseOption = (boExpandDomains, boStatusText, boShowFiles,
                           boAllowEdit, boShowPath, boEnableOk,
                           boNewGUI, boNewGUINoNewFolderBtn);
  TLMDShellBrowseOptions=set of TLMDShellBrowseOption;

  TLMDShellBrowseChangeEvent = procedure(Sender: TObject; var Path: String;
                                        var StatusText: String; var OKState: TLMDShellBrowseOKState) of object;
  TLMDShellBrowseInitEvent = procedure(Sender: TObject; DialogHandle: HWND) of object;
  TLMDShellBrowseValidateEvent = procedure(Sender: TObject; Path: string; var Cancel: boolean) of object;

  TLMDShellSysBrowseDialog = class(TLMDShellBaseDialog)
  private
    FCaption: String;
    FDescription: String;
    FDisplayName: String;
    FInstructionText: String;
    FStatusText: String;
    FFilter: TLMDShellBrowseFilter;
    FDialogHandle: HWND;
    FImageIndex: DWORD;
    FImageLarge: TBitmap;
    FImageSmall: TBitmap;
    FOnChange: TLMDShellBrowseChangeEvent;
    FOnInitialize: TLMDShellBrowseInitEvent;
    FOnValidate: TLMDShellBrowseValidateEvent;
    FSelectedPath: TFileName;
    FOptions: TLMDShellBrowseOptions;
    FRootShellFolder: PItemIDList;
    FRootFolder: TLMDRoot;
    procedure SetCaption(const aValue:String);
    procedure SetStatusText(const aValue:String);
    function GetImage(Index: Integer): TBitmap;
    procedure SetRootFolder(Value: TLMDRoot);
    procedure LoadCustomFolder(Reader: TReader);
    procedure LoadSystemFolder(Reader: TReader);

  protected
    procedure DoChange(DialogHandle: HWND; PIDL: PItemIDList); dynamic;
    procedure DoInit(DialogHandle: HWND); dynamic;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy;override;
    function Execute(aHWND:HWND=0):Boolean;override;
    property Description: String read FDescription;
    property DisplayName: String read FDisplayName;
    property ImageIndex: DWORD read FImageIndex;
    property ImageLarge: TBitmap index 1 read GetImage;
    property ImageSmall: TBitmap index 2 read GetImage;
    property RootShellFolder: PItemIDList read FRootShellFolder;
  published
    property Caption: String read FCaption write SetCaption;
    property RootFolder: TLMDRoot read FRootFolder write SetRootFolder;
    property Filter: TLMDShellBrowseFilter read FFilter write FFilter default bfBrowseForDirectories;
    property InstructionText: String read FInstructionText write FInstructionText;
    property Options: TLMDShellBrowseOptions read FOptions write FOptions default [boShowPath];
    property SelectedPath: TFilename read FSelectedPath write FSelectedPath stored false;
    property StatusText: String read FStatusText write SetStatusText;
    property OnChange: TLMDShellBrowseChangeEvent read FOnChange write FOnChange;
    property OnInitialize: TLMDShellBrowseInitEvent read FOnInitialize write FOnInitialize;
    property OnValidate: TLMDShellBrowseValidateEvent read FOnValidate write FOnValidate;
  end;

{ ****************** class TLMDShellObjectPropertiesDialog ******************* }
  TLMDShellObjectType = (soPathObject, soPrinterObject);
  TLMDShellObjectTypes = set of TLMDShellObjectType;

  TLMDShellObjectPropertiesDialog = class(TLMDShellCustomBaseDialog)//TLMDShellBaseDialog)
  private
    FInitialTab: String;
    FObjectName: TFileName;
    FObjectType: TLMDShellObjectType;
  protected
    function int_Execute(aHWND:HWND=0):Boolean;override;
  public
    constructor Create(aOwner: TComponent); override;
  published
    property InitialTab: String read FInitialTab write FInitialTab;
    property ObjectName: TFileName read FObjectName write FObjectName;
    property ObjectType: TLMDShellObjectType read FObjectType write FObjectType
      default soPathObject;
  end;

{ ********************* class TLMDShellCustomIEDialog ************************ }
  TLMDShellCustomIEDialog = class(TLMDShellBaseDialog)
  private
    FHandle:THandle;
  public
    function Available: Boolean; virtual;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
  end;

{ ******************* class TLMDShellAddFavoritesDialog ********************** }
  TLMDShellAddFavoritesDialog = class(TLMDShellCustomIEDialog)
  private

    FMethod: function(Wnd: HWND; szPath: PChar; cszPath: Integer;
      szTitle: PChar; cszTitle: Integer; pidlFavorites: PItemIDList): BOOL;
      stdcall;

    FDisplayName: string;
    FDirectory: string;
  public
    function Available: Boolean; override;
    function Execute(aHWND:HWND=0):Boolean;override;
    constructor Create(AOwner: TComponent); override;
  published
    property DisplayName: string read FDisplayName write FDisplayName;
    property Directory: string read FDirectory write FDirectory;
  end;

{ ********************* class TLMDShellFavoritesDialog *********************** }
  TLMDShellFavoritesDialog = class(TLMDShellCustomIEDialog)
  private

    FMethod: function (Wnd: HWND; szPath: PChar): UINT; stdcall;

    FDirectory: string;
  public
    function Available: Boolean; override;
    function Execute(aHWND:HWND=0):Boolean;override;
    constructor Create(AOwner:TComponent);override;
  published
    property Directory: string read FDirectory write FDirectory;
  end;

  { *********************** class TLMDShellAppletLoader ************************ }
  TLMDShellCPL=(cplControlPanel, cplCustomCPL, cplAppWizSystemComponents,
    cplAppWizAddNewSoftware, cplAppWizAddRemove, cplDateTime,
    cplDisplayBackground, cplDisplayScreenSaver, cplDisplayAppearance,
    cplDisplaySettings, cplAccess, cplMouse, cplKeyboard, cplInternetGeneral,
    cplInternetSecurity, cplInternetContent, cplInternetConnection,
    cplInternetExtented, cplMMSounds, cplMMHardware, cplModem, cplIntlGeneral,
    cplIntlNumbers, cplIntlCurrency, cplIntlTime, cplIntlDate, cplIntlInput,
    cplJoystick, cplNetwork, cplSystem);

  TLMDShellAppletLoader = class(TLMDShellBaseDialog)
  private
    FApplet: TLMDShellCPL;
    FCustom: String;
  public
    function Execute(aHWND:HWND=0):Boolean;override;
  published
    property Applet: TLMDShellCPL read FApplet write FApplet;
    property Custom: String read FCustom write FCustom;
  end;

{ ******************* class TLMDShellNetConnectionDialog ********************* }
  TLMDShellNetResourceType=(nrDiskResource, nrPrintResource);

  TLMDShellNetConnectionDialog = class(TLMDShellCustomBaseDialog)//TLMDShellBaseDialog)
  private
    FResourceName: String;
    FResourceType: TLMDShellNetResourceType;
  protected
    function int_Execute(aHWND:HWND=0):Boolean;override;
  public
    function DisconnectDrive(aHWND:HWND=0): Boolean;
  published
    property ResourceType: TLMDShellNetResourceType read FResourceType write FResourceType;
    property ResourceName: String read FResourceName write FResourceName;
  end;

  {--------- Public default methods  for previous components --------------------}

  function  LMDShellAboutDialog:Boolean;
  procedure LMDShellExitWindowsDialog;
  function  LMDShellFindFilesDialog: LongBool;
  function  LMDShellFindComputerDialog: LongBool;
  function  LMDShellObjectPropertiesDialog(aObjectName:TFileName=''; aObjectType: TLMDShellObjectType=soPathObject; aInitialTab: String=''): Boolean;
  function  LMDShellRestartDialog(const aReason: String): Boolean;
  function  LMDShellOutOfMemoryDialog: Integer;
  procedure LMDShellDiskFullDialog(Drive:Char);

  // LMD ShellPack 2.0
  function LMDShellCopyDiskDialog:Boolean;
  function LMDShellOpenWithDialog(const aFile:String=''):Boolean;

implementation

uses
  Controls, ComObj, ComCtrls, ShellApi, Consts, TypInfo, ActiveX, FileCtrl, Variants,
  LMDShConsts, LMDShPIDL, LMDProcs, LMDStrings;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

const
  Shell32                           = 'shell32.dll';

function PidlToName(aPIDL : PItemIDList; aFlags : DWORD) : string;
var
  StrRet : TStrRetEx;
begin
//  Result := '';

  FillChar(StrRet, SizeOf(StrRet), 0);

  LMDDesktopFolder.GetDisplayNameOf(aPIDL, aFlags, StrRet);
  //Result := String(LMDStrRetToStringEx(aPIDL, StrRet));
  Result := LMDStrRetToStr(aPIDL, StrRet);
end;

{ TLMDShellAboutDialog }
{********************* class TLMDShellAboutDialog *****************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDShellAboutDialog.SetIcon(Value: TIcon);
begin
  FIcon.Assign(Value);
end;

{------------------------------------------------------------------------------}
function TLMDShellAboutDialog.StoreIcon: Boolean;
begin
  Result:= not FIcon.Empty;
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDShellAboutDialog.Create(aOwner: TComponent);
begin
  inherited;
  FIcon:= TIcon.Create;
  FCaption:= '';
  FOtherText:= '';
  FProduct:= '';
end;

{------------------------------------------------------------------------------}
destructor TLMDShellAboutDialog.Destroy;
begin
  FIcon.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDShellAboutDialog.Execute;
var
  tmpi: THandle;
  tmp: String;
begin
  tmp:= '';
  if FCaption <> '' then
    tmp:= FCaption
  else
    tmp:= IDShell_About;
  tmp:= tmp + '#';
  if FProduct = '' then
    tmp:= tmp + Application.Title
  else
    tmp:= tmp + FProduct;
  If FIcon.Empty then
    tmpi:= Application.Icon.Handle
  else
    tmpi:= FIcon.Handle;
  Result:= ShellAbout(GetOwnerHandle(aHWND), Int_Ref(tmp), Int_Ref(FOtherText), tmpi) <> 0;
end;

{********************* class TLMDShellCustomBaseDialog ***********************}

function TLMDShellCustomBaseDialog.Execute(aHWND: HWND=0): Boolean;
begin
  Result := False;
  fShellDLL := LoadLibrary(Int_Ref(Shell32));

  if  fShellDLL <> 0  then
  begin
    try
      Result := int_Execute(aHWND);
    finally
      FreeLibrary(fShellDLL);
      fShellDLL := 0;
    end;
  end;
end;
{
function TLMDShellCustomBaseDialog.int_GetProcAddress(const Name: string; var Entry: FARPROC): Boolean;
begin
  Result := False;

  if  fShellDLL <> 0  then
end;
}
//function TLMDShellCustomBaseDialog.GetProcAddress(Index: integer; var Entry: FARPROC): Boolean;
function TLMDShellCustomBaseDialog.int_GetProcAddress(Index: integer): FARPROC;
begin
  if  fShellDLL <> 0  then
    Result := GetProcAddress(fShellDLL, Int_Ref(Index))
  else
    Result := nil;
end;

function TLMDShellCustomBaseDialog.int_Execute(aHWND: HWND=0): Boolean;
begin
  Result := False;
end;

{ TLMDShellFormatDriveDialog }
{********************* class TLMDShellFormatDriveDialog ***********************}
const
  // Format Options
  SHFMT_ID_DEFAULT = $FFFF;
  SHFMT_OPT_FULL    = $0001;
  SHFMT_OPT_SYSONLY = $0002;

  // Error Codes
  SHFMT_ERROR    = $FFFFFFFF;
  SHFMT_CANCEL   = $FFFFFFFE;
  SHFMT_NOFORMAT = $FFFFFFFD;

{------------------------------------------------------------------------------}
function LMDFormatResultConstToEnum(FormatResult: UINT): TLMDShellFormatResult;
begin
  case FormatResult of
    SHFMT_CANCEL:  Result:=frFormatCancelled;
    SHFMT_NOFORMAT:Result:=frDriveNotFormatable;
    SHFMT_ERROR:   Result:=frFormatError;
  else
    Result:=frFormatSucceeded;
  end;
end;

{----------------------------- Private ----------------------------------------}
procedure TLMDShellFormatDriveDialog.SetDrive(Value: Char);
begin
  Value:=UpCase(Value);
  if (Value <> FDriveToFormat) and (AnsiChar(Value) in ['A'..'Z']) then
    FDriveToFormat:= Value;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDShellFormatDriveDialog.Create(aOwner: TComponent);
begin
  inherited;
  FOptions:= [forRememberLast, forSuppressPrompt];
  FDriveToFormat:='A';
  FLastFormatID:= SHFMT_ID_DEFAULT;
end;

{------------------------------------------------------------------------------}

function TLMDShellFormatDriveDialog.Execute;
type

  LMDSHFormatDrive = function(Owner: HWND; Drive: UINT; FormatID: UINT; OptionFlags: UINT): DWORD; stdcall;

var
  ShellDLL:    HMODULE;
  SHFormatDrive:LMDSHFormatDrive;
  oldErrorMode, LocalLastFormatID, LocalOptionFlags:  UINT;
  FormatResult: DWORD;
begin
  Result:=false;

  ShellDLL:= LoadLibrary(Int_Ref(Shell32));
  try
    SHFormatDrive:=GetProcAddress(ShellDLL, Int_Ref('SHFormatDrive'));
    if not Assigned(SHFormatDrive) then exit;
    if forRememberLast in FOptions then
      LocalLastFormatID:= LOWORD(FLastFormatID)
    else
      LocalLastFormatID:= SHFMT_ID_DEFAULT;

    LocalOptionFlags := 0;
    // check QuickFormat?
    if forDefaultQuickFormat in FOptions then
      begin
        if (Win32Platform = VER_PLATFORM_WIN32_NT) then
          LocalOptionFlags:= LocalOptionFlags or SHFMT_OPT_FULL;
      end
    else
      if (Win32Platform <> VER_PLATFORM_WIN32_NT) then
        LocalOptionFlags:= LocalOptionFlags or SHFMT_OPT_FULL;

    // Copy systemfiles only?
    if (forDefaultSysOnly in FOptions) and
      (Win32Platform <> VER_PLATFORM_WIN32_NT)
    then
      LocalOptionFlags:= LocalOptionFlags or SHFMT_OPT_SYSONLY;

    oldErrorMode := SetErrorMode(0);
    try
      if forSuppressPrompt in FOptions then
        SetErrorMode(oldErrorMode or SEM_FAILCRITICALERRORS)
      else
        SetErrorMode(oldErrorMode and not SEM_FAILCRITICALERRORS);
      FormatResult:= SHFormatDrive
          (GetOwnerHandle(aHWND),
              Ord(DriveToFormat) - 65, LocalLastFormatID, LocalOptionFlags);
    finally
      SetErrorMode(OldErrorMode);
    end;

    FResult:= LMDFormatResultConstToEnum(FormatResult);
    Result:= FResult = frFormatSucceeded;
    if Result then
      FLastFormatID:= FormatResult;
  finally
    FreeLibrary(ShellDLL);
  end;
end;

{ TLMDShellPickIconDialog }
{********************* class TLMDShellPickIconDialog **************************}
{----------------------------- Private ----------------------------------------}
function TLMDShellPickIconDialog.GetIcon: TIcon;
var
  Handle1, Handle2: HICON;
begin
  Handle1 := 0;
  Handle2 := 0;
  ExtractIconEx(Int_Ref(FFileName), FIconIndex, Handle1, Handle2, 1);
  FIcon.Handle:= Handle1;
  Result:= FIcon;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDShellPickIconDialog.Create(aOwner: TComponent);
begin
  inherited;
  FIcon:= TIcon.Create;
  FFileName:= '';
  FIconIndex:= 0;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellPickIconDialog.Destroy;
begin
  FIcon.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDShellPickIconDialog.int_Execute;
type

  LMDPickIconDlg =function(Owner: HWND; FileName: Pointer; MaxFileNameChars: DWORD; var IconIndex: DWORD): LongBool; stdcall;

var
  PickIconDlg: LMDPickIconDlg;

  wFileName: array[0..MAX_PATH] of WideChar;

{function  PickIconDlg(Owner: HWND; FileName: Pointer; MaxFileNameChars: DWORD;
  var IconIndex: DWORD): LongBool; stdcall; external Shell32 index 62;}

begin
  Result:=false;

  PickIconDlg := int_GetProcAddress(62);

  if not Assigned(PickIconDlg) then exit;

  if (Win32Platform = VER_PLATFORM_WIN32_NT) then
    begin

      StringToWideChar(FileName, wFileName, MAX_PATH);
      Result:= PickIconDlg(GetOwnerHandle(aHWND), PWideString(@wFileName),
          MAX_PATH, FIconIndex);
      if Result then
        FileName:= wFileName;

    end
  else
    begin

      Result:= PickIconDlg(GetOwnerHandle(aHWND), Int_Ref(FileName), MAX_PATH,
        FIconIndex);

    end;
end;

{ TLMDShellRunFileDialog }
{****************** class TLMDShellRunFileDialog ******************************}
const
  RFF_NOBROWSE      = $01;   {Removes the browse button}
  RFF_NODEFAULT     = $02;   {No default item selected}
  RFF_CALCDIRECTORY = $04;   {Determines the work directory from the file name.}
  RFF_NOLABEL       = $08;   {Removes the edit box label}
  RFF_NOSEPARATEMEM = $20;   {Removes the Separate Memory Space check box}

  RF_OK             = $00;  {Allow the application to run}
  RF_CANCEL         = $01;  {Cancel the operation and close the dialog}
  RF_RETRY          = $02;  {Cancel the operation, but leave the dialog open}

  RFN_VALIDATE  = -510;

type

  PNM_RunFileDlg = ^TNM_RunFileDlg;
  TNM_RunFileDlg = packed record
    hdr:         TNMHdr;
    lpFile:      Pointer;
    lpDirectory: Pointer;
    nShow:       LongBool;
  end;

{------------------------------------------------------------------------------}
function RunFileActionEnumToConst(RunFileAction: TLMDShellRunFileAction): UINT;
begin
  case (RunFileAction) of
    raRun:    Result:= RF_OK;
    raCancel: Result:= RF_CANCEL;
    raRetry:  Result:= RF_RETRY;
    else      Result:= RF_OK;
  end;
end;

{------------------------------------------------------------------------------}
function RunFileOptionEnumToConst(RunFileOption: TLMDShellRunFileOption): UINT;
begin
  case (RunFileOption) of
    rfNoBrowseButton:    Result:= RFF_NOBROWSE;
    rfNoDefaultPick:     Result:= RFF_NODEFAULT;
    rfCalculateWorkPath: Result:= RFF_CALCDIRECTORY;
    rfNoEditLabel:       Result:= RFF_NOLABEL;
    rfNoSeparateMemory:  Result:= RFF_NOSEPARATEMEM;
    else                 Result:= 0;
  end; {case}
end;

{----------------------------- Private ----------------------------------------}
procedure TLMDShellRunFileDialog.SetIcon(Value: TIcon);
begin
  FIcon.Assign(Value);
end;

{------------------------------------------------------------------------------}
function TLMDShellRunFileDialog.StoreIcon: Boolean;
begin
  Result:= not FIcon.Empty;
end;

{------------------------------------------------------------------------------}

procedure TLMDShellRunFileDialog.HandleMessage(var aMessage: TMessage);
var
  FileToRun, WorkPath: String;
  RunAction: TLMDShellRunFileAction;
begin
  if aMessage.Msg = WM_NOTIFY then
    if PNMHdr(aMessage.LParam).code = RFN_VALIDATE then
      begin
        FileToRun:= '';
        if (PNM_RunFileDlg(aMessage.LParam).lpFile <> nil) then
          if (Win32Platform = VER_PLATFORM_WIN32_NT) then
            FileToRun:= WideString(PNM_RunFileDlg(aMessage.LParam).lpFile)
          else
            FileToRun:= String(PNM_RunFileDlg(aMessage.LParam).lpFile);

        WorkPath:= '';
        if (PNM_RunFileDlg(aMessage.LParam).lpDirectory <> nil) then
          if (Win32Platform=VER_PLATFORM_WIN32_NT) then
            WorkPath:= WideString(PNM_RunFileDlg(aMessage.LParam).lpDirectory)
          else
            FileToRun:= String(PNM_RunFileDlg(aMessage.LParam).lpDirectory);
        RunAction:= raRun;
        DoValidate(FileToRun, WorkPath, PNM_RunFileDlg(aMessage.LParam).nShow, RunAction);
        aMessage.Result:= RunFileActionEnumToConst(RunAction);
        Exit;
      end;
  aMessage.Result:= DefWindowProc(FMessageWindow, aMessage.Msg, aMessage.wParam,
    aMessage.lParam);
end;

{---------------------------- Protected ---------------------------------------}
procedure TLMDShellRunFileDialog.DoValidate(TheFile,
  TheWorkPath: TFileName; Visible: Boolean;
  var Action: TLMDShellRunFileAction);
begin
  if Assigned(FOnValidate) then
    FOnValidate(Self, TheFile, TheWorkPath, Visible, Action);
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDShellRunFileDialog.Create(aOwner: TComponent);
begin
  inherited;
  FCaption:= '';
  FDescription:= '';
  FWorkingPath:= '';
  FOnValidate:= nil;
  FOptions:=[];
  FIcon:= TIcon.Create;
  FMessageWindow:= AllocateHWnd(HandleMessage);
end;

{------------------------------------------------------------------------------}
destructor TLMDShellRunFileDialog.Destroy;
begin
  DeallocateHWnd(FMessageWindow);
  FIcon.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDShellRunFileDialog.int_Execute;
type

  LMDRunFileDlg = procedure(Owner: HWND; IconHandle: HICON; WorkPath: Pointer;Caption: Pointer; Description: Pointer; Flags: UINT); stdcall;

var
  RunFileDlg: LMDRunFileDlg;
  wCaption, wDescription, wWorkPath: WideString;
  Option: TLMDShellRunFileOption;
  OptionFlags: UINT;
  FWND:HWND;
begin
  Result := False;

  RunFileDlg := int_GetProcAddress(61);
  if not Assigned(RunFileDlg) then exit;

  if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      wCaption:= FCaption;
      wDescription:= FDescription;
      wWorkPath:= FWorkingPath;
    end;

    OptionFlags:= 0;
    for Option:= rfNoBrowseButton to rfNoSeparateMemory do
      if Option in FOptions then
        OptionFlags:= OptionFlags or RunFileOptionEnumToConst(Option);

  if Assigned(FOnValidate) then
    FWnd:=FMessageWindow
  else
    FWnd:=GetOwnerHandle(aHWND);

  if Win32Platform = VER_PLATFORM_WIN32_NT then
    RunFileDlg(FWND, FIcon.Handle, PWideChar(wWorkPath),
      PWideChar(wCaption), PWideChar(wDescription), OptionFlags)
  else
    RunFileDlg(FWND, FIcon.Handle, Int_Ref(WorkingPath), Int_Ref(Caption),
      Int_Ref(Description), OptionFlags);

  Result := True;
end;

{ TLMDShellRestartDialog }
{****************** class TLMDShellRestartDialog ******************************}
const
  EW_RESTARTWINDOWS = $42;
  EW_REBOOTSYSTEM   = $43;
  EW_EXITANDEXECAPP = $44;
{------------------------------------------------------------------------------}
function RestartOptionEnumToConst(RestartOption: TLMDShellRestartOption): UINT;
begin
  case RestartOption of
    roLogoff:         Result:= EWX_LOGOFF;
    roShutdown:       Result:= EWX_SHUTDOWN;
    roReboot:         Result:= EWX_REBOOT;
    roRestartWindows: Result:= EW_RESTARTWINDOWS;
    roRebootSystem:   Result:= EW_REBOOTSYSTEM;
    roExitAndExecApp: Result:= EW_EXITANDEXECAPP;
    else              Result:= 0;
  end;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDShellRestartDialog.Create(aOwner: TComponent);
begin
  inherited;
  FReason:= '';
  FRestartOption:= roRestartWindows;
end;

{------------------------------------------------------------------------------}

function TLMDShellRestartDialog.int_Execute;
type

  LMDRestartDialog = function(Owner: HWND; Reason: Pointer; Flags: UINT): DWORD; stdcall;

var
//  ShellDLL:    HMODULE;
  RestartDialog:LMDRestartDialog;

  wReason: WideString;

begin
  Result:=false;
  RestartDialog := int_GetProcAddress(59);
  if not Assigned(RestartDialog) then exit;

  if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      wReason:= FReason + ' ';
      Result:= RestartDialog(GetOwnerHandle(aHWND), PWideChar(wReason),
        RestartOptionEnumToConst(FRestartOption)) = IDYES
    end
  else
    Result:= RestartDialog(GetOwnerHandle(aHWND), Int_Ref(FReason + ' '),
      RestartOptionEnumToConst(FRestartOption)) = IDYES

end;

{ TLMDShellFindDialog }
{****************** class TLMDShellFindDialog *********************************}
{----------------------------- Private ----------------------------------------}
procedure TLMDShellFindDialog.SetRootFolder(Value: TLMDRoot);
var
  NewPIDL: PItemIDList;
  RootIdx       : integer;
  Ok: Boolean;
begin
  if not LMDAnsiSameText(FRootFolder, Value) then
    begin
      Ok := False;
      RootIdx := GetEnumValue(TypeInfo(TLMDRootFolder), Value);
      if RootIdx >= 0 then
        begin
          NewPIDL:=LMDGetRootFolderID(TLMDSystemFolder(RootIdx));
          Ok := Assigned(NewPIDL);
        end
      else
        if Length(Value) > 0 then
          begin
            if Value[Length(Value)] = ':' then Value:= Value + '\';
            Ok := LMDPathToPidl(Value, NewPIDL{, nil});
          end;
      if  not Ok then
        begin
          raise Exception.CreateFmt( sErrorSettingPath, [Value]);
        end;
      FRootFolder:= Value;
      if Assigned(FRootShellFolder) then
        LMDShPIDLFree(FRootShellFolder);
      FRootShellFolder := NewPIDL;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFindDialog.LoadCustomFolder(Reader: TReader);
begin
  RootFolder:= Reader.ReadString;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellFindDialog.LoadSystemFolder(Reader: TReader);
var
  i: Integer;
begin
  i:= GetEnumValue(TypeInfo(TLMDSystemFolder), Reader.ReadIdent);
  if i <= Ord(High(TLMDRootFolder)) then
    RootFolder:= GetEnumName(TypeInfo(TLMDRootFolder), i);
end;

{----------------------------- protected --------------------------------------}
procedure TLMDShellFindDialog.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('SystemFolder', LoadSystemFolder, nil, false);
  Filer.DefineProperty('CustomFolder', LoadCustomFolder, nil, false);
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDShellFindDialog.Create(aOwner: TComponent);
begin
  inherited;
  FSearchFileName:= '';
  FRootShellFolder:= nil;
  RootFolder:= sRFDesktop;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellFindDialog.Destroy;
begin
  if assigned(FRootShellFolder) then LMDShPIDLFree(FRootShellFolder);
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDShellFindDialog.int_Execute(aHWND: HWND = 0): Boolean;
begin
 if FMode = fmFiles then
   Result:= int_FindFiles
 else
   Result:= int_FindComputer;
end;

function TLMDShellFindDialog.ExecuteEx(Mode: TLMDShellFindMode; aHWND: HWND = 0): Boolean;
var
  OldMode: TLMDShellFindMode;
begin
  OldMode := self.Mode;
  try
    self.Mode := Mode;
    Result := Execute(aHWND);
  finally
    self.Mode := OldMode;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDShellFindDialog.FindComputer: Boolean;
begin
  Result := ExecuteEx(fmComputer);
end;

function TLMDShellFindDialog.int_FindComputer: Boolean;
type

  LMDSHFindComputer = function(Reserved1: PItemIDList; Reserved2: PItemIDList): LongBool; stdcall;

var
  SHFindComputer: LMDSHFindComputer;
begin
  Result:=false;
  SHFindComputer := int_GetProcAddress(90); // Was 91

  if not Assigned(SHFindComputer) then exit;

  Result:= SHFindComputer(nil, nil);

end;
{------------------------------------------------------------------------------}

function TLMDShellFindDialog.FindFiles: Boolean;
begin
  Result := ExecuteEx(fmFiles);
end;

function TLMDShellFindDialog.int_FindFiles: Boolean;
{function SHFindFiles(Root: PItemIDList; SavedSearchFile: PItemIDList): LongBool; stdcall; external Shell32 index 90;}
type

  LMDSHFindFiles=function(Root: PItemIDList; SavedSearchFile: PItemIDList): LongBool; stdcall;

var
  SHFindFiles: LMDSHFindFiles;
  SearchFile: PItemIDList;

  IShell: OleVariant;

begin
  Result:= false;

  if not FOldStyle and (GetComCtlVersion > ComCtlVersionIE4) and (FSearchFileName = '') then
    try
      IShell:= CreateOLEObject('Shell.Application');
      IShell.FindFiles;
      Result:= true;
      Exit;
    except
      Result:= false;
    end;

  if Result = false then
    begin
      SHFindFiles := int_GetProcAddress(90);  //  was 91
      if not Assigned(SHFindFiles) then exit;

      if FSearchFileName = '' then
        SearchFile := nil
      else
        SearchFile := LMDPathToPidl(FSearchFileName);

      Result:= SHFindFiles(FRootShellFolder, SearchFile);

    end;
end;

{****************** class TLMDShellSysBroweDialog *****************************}

function BrowseForFolderCallback(DialogHandle: HWND; MessageID: UINT;
            PIDL: LPARAM; ComponentPointer: LPARAM): Integer; stdcall;
var
  Cancel: Boolean;
begin
  Result:= 0;
  if ComponentPointer <> 0 then
    with TLMDShellSysBrowseDialog(ComponentPointer) do
      case MessageID of
        BFFM_INITIALIZED: DoInit(DialogHandle);
        BFFM_SELCHANGED: DoChange(DialogHandle, PItemIDList(PIDL));
        BFFM_VALIDATEFAILED:
          if  PIDL <> 0 then
          begin
            Cancel:= false;
            if Assigned(FOnValidate) then
              FOnValidate(TLMDShellSysBrowseDialog(ComponentPointer),
                string(PIDL), Cancel);
            Result:= Ord(Cancel = True);
          end;
       end;
end;

{----------------------------- Private ----------------------------------------}
procedure TLMDShellSysBrowseDialog.SetCaption(const aValue: String);
begin
  if FDialogHandle <> 0 then
    SetWindowText(FDialogHandle, Int_Ref(aValue));
  FCaption:= aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellSysBrowseDialog.SetStatusText(const aValue:String);
begin
  if FDialogHandle <> 0 then
    begin

      PostMessage(FDialogHandle, BFFM_SETSTATUSTEXT, 0, DWORD(PChar(aValue)));

    end;

  FStatusText := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellSysBrowseDialog.SetRootFolder(Value: TLMDRoot);
var
  NewPIDL: PItemIDList;
  RootIdx       : integer;
  Ok: Boolean;
begin
  if not LMDAnsiSameText(FRootFolder, Value) then
    begin
      Ok := False;
      RootIdx := GetEnumValue(TypeInfo(TLMDRootFolder), Value);
      if RootIdx >= 0 then
        begin
          NewPIDL:=LMDGetRootFolderID(TLMDSystemFolder(RootIdx));
          Ok := Assigned(NewPIDL);
        end
      else
        if Length(Value) > 0 then
          begin
            if Value[Length(Value)] = ':' then Value:= Value + '\';
            Ok := LMDPathToPidl(Value, NewPIDL{, nil});
          end;
      if  not OK  then
        begin
          raise Exception.CreateFmt(sErrorSettingPath, [Value]);
        end;
      FRootFolder:= Value;
      if Assigned(FRootShellFolder) then
        LMDShPIDLFree(FRootShellFolder);
      FRootShellFolder := NewPIDL;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellSysBrowseDialog.GetImage(Index: Integer): TBitmap;
var
  Flags:DWORD;
  Unused: TSHFileInfo;
begin
  Result:= nil;
  with TImageList.Create(Self) do
    try
      case Index of
        1: begin
            Result:= FImageLarge;
            Flags:= SHGFI_SYSICONINDEX or SHGFI_LARGEICON;
          end;
        2:begin
            Result:= FImageSmall;
            Flags:= SHGFI_SYSICONINDEX or SHGFI_SMALLICON;
          end;
      else
        Exit;
      end;
      Handle:= SHGetFileInfo('C:\', 0, Unused, SizeOf(Unused), Flags);
      ShareImages:= true;
      GetBitmap(ImageIndex, Result);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellSysBrowseDialog.LoadCustomFolder(Reader: TReader);
begin
  RootFolder:= Reader.ReadString;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellSysBrowseDialog.LoadSystemFolder(Reader: TReader);
var
  i: Integer;
begin
  i:= GetEnumValue(TypeInfo(TLMDSystemFolder), Reader.ReadIdent);
  if i <= Ord(High(TLMDRootFolder)) then
    RootFolder:= GetEnumName(TypeInfo(TLMDRootFolder), i);
end;

{----------------------------- Protected --------------------------------------}
procedure TLMDShellSysBrowseDialog.DoChange(DialogHandle: HWND; PIDL: PItemIDList);
var
  NewPath, oldPath, NewStatusText: String;
  FileInfo: TSHFileInfo;
  NewOKState: TLMDShellBrowseOKState;
  PathName: string;

//  PathName: array[0..MAX_PATH] of Char;

begin
  if Assigned(FOnChange) then
    begin
      LMDSHGetFileInfo(PIDL,
            SHGFI_PIDL or SHGFI_DISPLAYNAME or SHGFI_TYPENAME or SHGFI_ICON, FileInfo);

       FDescription:= FileInfo.szTypeName;
       FDisplayName:= FileInfo.szDisplayName;
       FImageIndex:= FileInfo.iIcon;
       oldPath:= PIDLToName(PIDL, SHGDN_FORPARSING);
       NewPath:= oldPath;
       NewStatusText:= FStatusText;
       NewOKState:= osDefaultState;
       FOnChange(Self, NewPath, NewStatusText, NewOKState);

       if (NewPath <> '') and (NewPath <> oldPath) then

         PostMessage(FDialogHandle, BFFM_SETSELECTION, LPARAM(True),
           LPARAM(PChar(NewPath)));

       StatusText:= NewStatusText;

       case NewOKState of
         osEnableOK:  PostMessage(FDialogHandle, BFFM_ENABLEOK, 0,
           LPARAM(True));
         osDisableOK: PostMessage(FDialogHandle, BFFM_ENABLEOK, 0,
           LPARAM(False));
       end;
     end
  else
    if boShowPath in FOptions then
      begin
        PathName := LMDPidlToPath(PIDL);

        SendMessage(DialogHandle, BFFM_SETSTATUSTEXT, 0, LPARAM(PChar(PathName)));

      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellSysBrowseDialog.DoInit(DialogHandle: HWND);
begin
  FDialogHandle:= DialogHandle;
  if FCaption <> '' then
    SetCaption(FCaption)
  else
    SetWindowText(DialogHandle, Int_Ref(sBrowseForFolder));
  SetStatusText(FStatusText);

  if FSelectedPath <> '' then

    SendMessage(FDialogHandle, BFFM_SETSELECTION, WPARAM(True), LPARAM(FSelectedPath));

  SendMessage(FDialogHandle, BFFM_ENABLEOK, 0, LPARAM(boEnableOK in FOptions));

  if Assigned(OnInitialize) then
    FOnInitialize(Self, FDialogHandle);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellSysBrowseDialog.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('SystemFolder', LoadSystemFolder, nil, false);
  Filer.DefineProperty('CustomFolder', LoadCustomFolder, nil, false);
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDShellSysBrowseDialog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FCaption:= '';
  FDialogHandle:= 0;
  FDisplayName:='';
  FFilter:= bfBrowseForDirectories;
  FImageIndex:= 0;
  FStatusText:= '';
  FImageLarge:= TBitmap.Create;
  FImageSmall:= TBitmap.Create;
  FOptions:= [boShowPath];
  FRootShellFolder:= nil;
  FRootFolder:= sRFDesktop;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellSysBrowseDialog.Destroy;
begin
  FImageLarge.Free;
  FImageSmall.Free;
  if assigned(FRootShellFolder) then LMDShPIDLFree(FRootShellFolder);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDShellSysBrowseDialog.Execute;
const
  BIF_EDITBOX=$0010;
  BIF_VALIDATE=$0020;
  {$IFNDEF LMDCOMP9}
  BIF_NEWDIALOGSTYLE=$0040;
  BIF_NONEWFOLDERBUTTON = $200;
  {$ENDIF}
var
  BrowseInfo:TBrowseInfo;
  FinalPIDL:PItemIDList;
  NameBuffer:array[0..MAX_PATH] of Char;
  CoInitResult: HRESULT;
  WindowList: Pointer;
  OldErrorMode: Cardinal;
begin
  //FSelectedPath:= '';
  FinalPIDL:=nil;
  BrowseInfo.hwndOwner:= GetOwnerHandle(aHWND);

  BrowseInfo.pidlRoot:= nil;

  NameBuffer[0]:= #0;
  BrowseInfo.pszDisplayName := NameBuffer;
  BrowseInfo.lParam:= DWORD(Self);

  BrowseInfo.lpszTitle:= Int_Ref(FInstructionText);
  BrowseInfo.ulFlags:= 0;
  BrowseInfo.lpfn:= BrowseForFolderCallback;
  BrowseInfo.iImage:= 0;

  BrowseInfo.pidlRoot := LMDCopyPIDL(FRootShellFolder);

  // Flags
  case FFilter of
    bfBrowseForComputers:
      BrowseInfo.ulFlags:= BrowseInfo.ulFlags or BIF_BROWSEFORCOMPUTER;
    bfBrowseForDirectories:
      BrowseInfo.ulFlags:= BrowseInfo.ulFlags or BIF_RETURNONLYFSDIRS;
    bfBrowseForFileAncestors:
      BrowseInfo.ulFlags:= BrowseInfo.ulFlags or BIF_RETURNFSANCESTORS;
    bfBrowseForPrinters:
      BrowseInfo.ulFlags:= BrowseInfo.ulFlags or BIF_BROWSEFORPRINTER;
  end;

  if not (boExpandDomains in FOptions) then
    BrowseInfo.ulFlags:=BrowseInfo.ulFlags or BIF_DONTGOBELOWDOMAIN;
  if (boStatusText in FOptions) or (boShowPath in FOptions) then
    BrowseInfo.ulFlags:= BrowseInfo.ulFlags or BIF_STATUSTEXT;
  if boAllowEdit in FOptions then
    BrowseInfo.ulFlags:=BrowseInfo.ulFlags or BIF_VALIDATE or BIF_EDITBOX;
  if boShowFiles in FOptions then
    BrowseInfo.ulFlags:=BrowseInfo.ulFlags or BIF_BROWSEINCLUDEFILES;

  //BrowseInfo.pszDisplayName:=PChar(FSelectedPath);

  try
    if boNewGUI in FOptions then
      begin
        CoInitResult := CoInitializeEx(nil, COINIT_APARTMENTTHREADED);
        if not (CoInitResult = RPC_E_CHANGED_MODE) then
          begin
            BrowseInfo.ulFlags := BrowseInfo.ulFlags or BIF_NEWDIALOGSTYLE;
            if boNewGUINoNewFolderBtn in FOptions then
              BrowseInfo.ulFlags:=BrowseInfo.ulFlags or BIF_NONEWFOLDERBUTTON;
          end;
      end;

    WindowList := DisableTaskWindows(0);
    OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
    try
      FinalPIDL:=SHBrowseForFolder(BrowseInfo);
    finally
      SetErrorMode(OldErrorMode);
      EnableTaskWindows(WindowList);
    end;

    {retrieve the path from the item identifier list that was returned}
    FSelectedPath:= PIDLToName(FinalPIDL, SHGDN_FORPARSING);
  finally
    if boNewGUI in FOptions then
      CoUninitialize;
    Result := (FinalPIDL <> nil);
  end;

  FDialogHandle:= 0;
  LMDShPIDLFree(FinalPIDL);
  LMDShPIDLFree(BrowseInfo.pidlRoot);

end;

{ TLMDShellObjectPropertiesDialog }
{************** class TLMDShellObjectPropertiesDialog *************************}
const {SHObjectProperties Flags}
  OPF_PRINTERNAME = $01;
  OPF_PATHNAME    = $02;

{------------------------------------------------------------------------------}
function ShellObjectTypeEnumToConst(ShellObjectType: TLMDShellObjectType): UINT;
begin
  case ShellObjectType of
    soPathObject:Result:=OPF_PATHNAME;
    soPrinterObject: Result := OPF_PRINTERNAME;
  else
    Result := 0;
  end;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDShellObjectPropertiesDialog.Create(aOwner:TComponent);
begin
  inherited;
  FInitialTab:= '';
  FObjectName:= '';
  FObjectType:= soPathObject;
end;

{------------------------------------------------------------------------------}

function TLMDShellObjectPropertiesDialog.int_Execute;
type

  LMDSHObjectProperties = function(Owner: HWND; Flags: UINT; ObjectName: Pointer;
                                 InitialTabName: Pointer): LongBool; stdcall;

var
  SHObjectProperties:LMDSHObjectProperties;
var
  wObjectName: WIdeString;
  wTabName: WideString;
begin
  Result:=false;

  SHObjectProperties := int_GetProcAddress(178);
  if not Assigned(SHObjectProperties) then exit;

  if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      wObjectName:= FObjectName;
      wTabName:= FInitialTab;

      Result:= SHObjectProperties(GetOwnerHandle(aHWND),
                                  ShellObjectTypeEnumToConst(FObjectType),
                                  PWideChar(wObjectName), PWideChar(wTabName));

    end
  else

    Result:= SHObjectProperties(GetOwnerHandle(aHWND),
                                ShellObjectTypeEnumToConst(FObjectType),
                                Int_Ref(FObjectName), Int_Ref(FInitialTab));

end;

{ TLMDShellCustomIEDialog }
{********************** TLMDShellCustomIEDialog *******************************}
{--------------------------- public -------------------------------------------}
function TLMDShellCustomIEDialog.Available: Boolean;
begin
  Result:= FHandle <> 0;
end;

{------------------------------------------------------------------------------}
constructor TLMDShellCustomIEDialog.Create(AOwner: TComponent);
begin
  inherited;
  FHandle:= LoadLibrary('shdocvw.dll');
end;

{------------------------------------------------------------------------------}
destructor TLMDShellCustomIEDialog.Destroy;
begin
  if Available then
    FreeLibrary(FHandle);
  inherited;
end;

{********************** TLMDShellAddFavoritesDialog ***************************}
{--------------------------- public -------------------------------------------}

constructor TLMDShellAddFavoritesDialog.Create(AOwner:TComponent);
begin
  inherited;
  if inherited Available then

    FMethod:= GetProcAddress(FHandle, 'DoAddToFavDlg')

  else
    FMethod:= nil;
end;

{------------------------------------------------------------------------------}
function TLMDShellAddFavoritesDialog.Available:boolean;
begin
  Result:= inherited Available and Assigned(FMethod);
end;
{------------------------------------------------------------------------------}
function TLMDShellAddFavoritesDialog.Execute;
var
  PIDL:PItemIDList;

  DN, FN:array[0..MAX_PATH] of char;

begin
  Result:=FALSE;
  if Available then
    begin
      PIDL := nil;
      if FDirectory=''then
        SHGetSpecialFolderLocation(GetOwnerHandle(aHWND), CSIDL_FAVORITES, PIDL)
      else
        PIDL := LMDGetIDFromPath(FDirectory);
      if PIDL <> nil then
      begin

        ZeroMemory(@DN,SizeOf(DN));
        if FDisplayName <> '' then Move(FDisplayName[1],DN,Length(FDisplayName));
        ZeroMemory(@FN,SizeOf(FN));
        if FDirectory <> '' then Move(FDirectory[1],FN,Length(FDirectory));

        Result:=FMethod(GetOwnerHandle(aHWND), PChar(@FN), MAX_PATH, PChar(@DN),
                        MAX_PATH, PIDL);
        LMDDisposePIDL(PIDL);

        if  Result  then
          begin
            FDirectory:=ExtractFileDir(PChar(@FN));
            FDisplayName:=PChar(@DN);
          end;

      end;
    end;
end;

{*********************** TLMDShellFavoritesDialog *****************************}
{--------------------------- public -------------------------------------------}

constructor TLMDShellFavoritesDialog.Create(AOwner:TComponent);
begin
  inherited;
  if inherited Available then

    FMethod:= GetProcAddress(FHandle, 'DoOrganizeFavDlg')

  else
    Fmethod:= nil;
end;

{------------------------------------------------------------------------------}
function TLMDShellFavoritesDialog.Available: Boolean;
begin
  Result:= inherited Available and Assigned(FMethod);
end;

{------------------------------------------------------------------------------}
function TLMDShellFavoritesDialog.Execute(aHWND:HWND=0):Boolean;
begin
  Result:= false;
  if Available then
    Result := (FMethod(GetOwnerHandle(aHWND), Int_Ref(FDirectory)) = S_OK);
end;

{************** class TLMDShellAppletLoader ***********************************}
const LMDShellCPL: array[TLMDShellCPL] of string =
   ('', '',
    'appwiz.cpl,@0,1',
    'appwiz.cpl,@0,2',
    'appwiz.cpl',
    'timedate.cpl',
    'desk.cpl,,0',
    'desk.cpl,,1',
    'desk.cpl,,2',
    'desk.cpl,,3',
    'access.cpl',
    'main.cpl,@0',
    'main.cpl,@1',
    'inetcpl.cpl,,0',
    'inetcpl.cpl,,1',
    'inetcpl.cpl,,2',
    'inetcpl.cpl,,3',
    'inetcpl.cpl,,5',
    'mmsys.cpl,,1',
    'mmsys.cpl,,2',
    'modem.cpl',
    'intl.cpl,,0',
    'intl.cpl,,1',
    'intl.cpl,,2',
    'intl.cpl,,3',
    'intl.cpl,,4',
    'intl.cpl,,5',
    'joy.cpl',
    'ncpa.cpl',
    'sysdm.cpl'
     );

{----------------------------- Public -----------------------------------------}
function TLMDShellAppletLoader.Execute;
var
  tmp: String;
begin
  tmp:='shell32.dll,Control_RunDLL ';
  if FApplet = cplCustomCPL then
    tmp:= tmp + FCustom
  else tmp:= tmp + LMDShellCPL[FApplet];
  Result:= ShellExecute(GetOwnerHandle(aHWND), 'open', 'rundll32.exe', Int_Ref(tmp),
    nil, SW_NORMAL) > 32;
end;

{ ******************* class TLMDShellNetConnectionDialog ********************* }
{--------------------------- public -------------------------------------------}
function TLMDShellNetConnectionDialog.DisconnectDrive;
begin
  Result:=WNetDisconnectDialog(GetOwnerHandle(aHwnd), RESOURCETYPE_DISK)=S_OK;
end;

function TLMDShellNetConnectionDialog.int_Execute;
const
  rt: array [TLMDShellNetResourceType] of DWORD = (RESOURCETYPE_DISK, RESOURCETYPE_PRINT);
type

  LMDShNetConnectionDialog = function(Owner: HWND; ResourceName: Pointer;
                    ResourceType: DWORD): DWORD; stdcall;

var
  ShNetConnectionDialog:LMDShNetConnectionDialog;

  wResourceName: WideString;

begin
  Result:=false;
  ShNetConnectionDialog := int_GetProcAddress(160);
  if not Assigned(ShNetConnectionDialog) then exit;

  if ResourceName = '' then
    Result:= Succeeded(ShNetConnectionDialog(GetOwnerHandle(aHWND), nil, rt[FResourceType]))
  else
    if Win32Platform = VER_PLATFORM_WIN32_NT then
      begin
        wResourceName:= ResourceName;
        Result:= Succeeded(ShNetConnectionDialog(GetOwnerHandle(aHWND), PWideChar(wResourceName), rt[FResourceType]));
      end
    else
      Result:= Succeeded(ShNetConnectionDialog(GetOwnerHandle(aHWND), Int_Ref(ResourceName), rt[FResourceType]));

end;

{************** Public Routines ***********************************************}
{------------------------------------------------------------------------------}
function LMDShellAboutDialog: Boolean;
begin
  with TLMDShellAboutDialog.Create(Application) do
    try
      Product:=Application.Name;
      Result:=Execute;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
function LMDShellRestartDialog(const aReason:String): Boolean;
begin
  with TLMDShellRestartDialog.Create(nil) do
    try
      Reason:=aReason;
      Result:=Execute;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
function  LMDShellObjectPropertiesDialog(aObjectName:TFileName=''; aObjectType: TLMDShellObjectType=soPathObject; aInitialTab: String=''): Boolean;
begin
  with TLMDShellObjectPropertiesDialog.Create(nil) do
    try
      ObjectName:=aObjectName;
      ObjectType:=aObjectType;
      InitialTab:=aInitialTab;
      Result:=Execute;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
function LMDShellFindFilesDialog:LongBool;
begin
  with TLMDShellFindDialog.Create(nil) do
    try
      Result:=FindFiles;
    finally
      Free
    end;
end;

{------------------------------------------------------------------------------}
function LMDShellFindComputerDialog: LongBool;
begin
  with TLMDShellFindDialog.Create(nil) do
    try
      Result:=FindComputer;
    finally
      Free
    end;
end;

{------------------------------------------------------------------------------}

procedure LMDShellExitWindowsDialog;
type

  TExitWindowsDialog = procedure(Owner: HWND); stdcall;

var
  ShellDLL:    HMODULE;
  ExitWindowsDialog: TExitWindowsDialog;
begin
  ShellDLL:= LoadLibrary(Int_Ref(Shell32));
  try
    ExitWindowsDialog:= GetProcAddress(ShellDLL, Int_Ref(60));
    if Assigned(ExitWindowsDialog) then

      ExitWindowsDialog(Application.Handle);

  finally
    FreeLibrary(ShellDLL);
  end;
end;

{------------------------------------------------------------------------------}

function LMDShellOutOfMemoryDialog: Integer;
type

  TLMDSHOutOfMemoryMessageBox = function(Owner: HWND; Caption: Pointer;
                                        Style: UINT):Integer; stdcall;

var
  ShellDLL:    HMODULE;
  SHOutOfMemoryMessageBox: TLMDSHOutOfMemoryMessageBox;
begin
  Result := 0;
  ShellDLL:= LoadLibrary(Int_Ref(Shell32));
  try
    SHOutOfMemoryMessageBox:= GetProcAddress(ShellDLL, Int_Ref(126));
    if Assigned(SHOutOfMemoryMessageBox) then

      Result := SHOutOfMemoryMessageBox(Application.Handle, nil, MB_OK or MB_ICONHAND);

  finally
    FreeLibrary(ShellDLL);
  end;
end;

{------------------------------------------------------------------------------}

procedure LMDShellDiskFullDialog(Drive: Char);
type

  LMDSHHandleDiskFull = procedure(Owner: HWND; uDrive: UINT); stdcall;

var
  ShellDLL:    HMODULE;
  SHHandleDiskFull: LMDSHHandleDiskFull;
begin
  if not (AnsiChar(UpCase(Drive)) in ['A'..'Z']) then
    exit;

  ShellDLL:= LoadLibrary(Int_Ref(Shell32));
  try
    SHHandleDiskFull:= GetProcAddress(ShellDLL, Int_Ref(185));
    if Assigned(SHHandleDiskFull) then

      SHHandleDiskFull(Application.Handle, Ord(UpCase(Drive)) - Ord('A'));

  finally
    FreeLibrary(ShellDLL);
  end;
end;

{------------------------------------------------------------------------------}
function LMDShellCopyDiskDialog:Boolean;
begin
  Result:=WinExec('Rundll32.exe diskcopy.dll,DiskCopyRunDll', SW_SHOW)>31
end;

{------------------------------------------------------------------------------}
function LMDShellOpenWithDialog(const aFile:String):Boolean;
begin
  Result := ShellExecute(0, 'open', 'rundll32.exe', int_Ref(Format('shell32.dll,OpenAs_RunDLL %s', [aFile])), int_Ref(''), 0) > 32;
//  Result := WinExec(PAnsiChar(Int_Ref(
//    Format('Rundll32.exe shell32.dll,OpenAs_RunDLL "%s"', [aFile]))), SW_SHOW)>32;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}
end.
