unit LMDDlgEx;
{$I lmdcmps.INC}
{$J+} // Writeable Constants on

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

LMDDlgEx unit
---------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Messages, Controls, Forms, Graphics, Shlobj, Dialogs, ActiveX,
  LMDBase, LMDTypes, LMDShUtils;

const
  MaxCustomColors = 16;

type
  TLMDFilterString = string;
  TLMDFileName = string;
  {------------------ TLMDFormCommonDialog ------------------------------------}

  TDialogFunc = function(var DialogData): Bool; stdcall;

  TLMDFormCommonDialog = class(TGraphicControl)
  private
    FAbout: TLMDAboutVar;
    FCtl3D: Boolean;
    //    FDefWndProc: Pointer;
    //    FDefWndProc: Pointer;
    FDefWndProc: TFarProc;
    FHelpContext: THelpContext;
    FHandle: HWnd;
    FDialogHandle: HWnd;
    FObjectInstance: Pointer;
    FDialogTemplateHandle: THandle;
    FFormClientWidth, FFormClientHeight,
      FFormWidth, FFormHeight: Integer;
    FDialogShowing: boolean;
    FForm: TForm;
    FOldFormParent: TWinControl;
    FOldFormParentHandle: HWND;
    FOldFormBorderStyle: TFormBorderStyle;
    FOldFormWndProc: TWndMethod;
    FUpdateFFormRect: boolean;
    FOldDialogWndProc: TFarProc; //Pointer;
    FSkipMessages: boolean;
    FTitle: string;
    FDesignBMPName: string;
    FDesignCaption: string;

    FOkButtonCaption: string;
    FCancelButtonCaption: string;
    FHelpButtonCaption: string;

    FOnHelp: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;

    function GetDialogTemplateHandle: THandle; virtual; // VB
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    procedure WMInitDialog(var Message: TWMInitDialog); message WM_INITDIALOG;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
    procedure WMGETMINMAXINFO(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure SetHeight(Value: Integer); virtual;
    procedure SetWidth(Value: Integer); virtual;
    procedure SetClientHeight(Value: Integer); virtual;
    procedure SetClientWidth(Value: Integer); virtual;
    procedure SetLeft(Value: Integer); virtual;
    procedure SetTop(Value: Integer); virtual;
    procedure SetForm(Form: TForm);

    function GetWidth: Integer;
    function GetHeight: Integer;
    function GetClientWidth: Integer;
    function GetClientHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;

    procedure SetOkButtonCaption(const Value: string);
    procedure SetCancelButtonCaption(const Value: string);
    procedure SetHelpButtonCaption(const Value: string);

    protected
    FParentWasRescaled: boolean;
    FDlgBaseUnits: Integer;
    function GetDlgBaseUnits: Integer;
    procedure RescaleParent;
    procedure ValidateBounds; virtual; abstract;
    procedure Paint; override;
    function GetStaticRect: TRect; virtual;
    procedure WndProc(var Message: TMessage); override;
    function MessageHook(var Msg: TMessage): Boolean; virtual;

    function TaskModalDialog(DialogFunc: TDialogFunc; var DialogData): Integer;
      virtual;

    //    function TaskModalDialog(DialogFunc: Pointer; var DialogData): Integer; virtual;
    procedure NewFormProc(var Message: TMessage);
    procedure DoClose; virtual;
    procedure DoShow; virtual;
    procedure DoHelp; virtual;

    property DialogTemplateHandle: THandle read GetDialogTemplateHandle;
    property Form: TForm read FForm write SetForm;
    property OldFormWndProc: TWndMethod read FOldFormWndProc;
    property OldDialogWndProc: TFarProc read FOldDialogWndProc;
    (*
        property OldDialogWndProc:pointer read FOldDialogWndProc;
    *)
    property OnHelp: TNotifyEvent read FOnHelp write FOnHelp;

  published
    property DlgBaseUnits: Integer read GetDlgBaseUnits write FDlgBaseUnits;
  public
    function Execute: Boolean; virtual; abstract;
    property FormHeight: Integer read GetHeight write SetHeight;
    property FormWidth: Integer read GetWidth write SetWidth;
    property FormClientHeight: Integer read GetClientHeight write SetClientHeight;
    property FormClientWidth: Integer read GetClientWidth write SetClientWidth;
    property FormLeft: Integer read GetLeft write SetLeft;
    property FormTop: Integer read GetTop write SetTop;
    procedure DefaultHandler(var Message); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Handle: HWnd read FHandle;
    property DialogHandle: HWnd read FDialogHandle;
    property DialogShowing: boolean read FDialogShowing;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
    property OkButtonCaption: string read FOkButtonCaption write SetOkButtonCaption;
    property CancelButtonCaption: string read FCancelButtonCaption write SetCancelButtonCaption;
    property HelpButtonCaption: string read FHelpButtonCaption write SetHelpButtonCaption;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property Ctl3D: Boolean read FCtl3D write FCtl3D default True;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property Title: string read FTitle write FTitle;
  end;

  {------------------ TLMDFormOpenDialog  -------------------------------------}
  TLMDFormOpenOption = (ofReadOnly, ofOverwritePrompt, ofHideReadOnly,
    ofNoChangeDir, ofShowHelp, ofNoValidate, ofAllowMultiSelect,
    ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofCreatePrompt,
    ofShareAware, ofNoReadOnlyReturn, ofNoTestFileCreate, ofNoNetworkButton,
    ofNoLongNames, ofNoDereferenceLinks);
  TLMDFormOpenOptions = set of TLMDFormOpenOption;

  TLMDFileEditStyle = (fsEdit, fsComboBox);

  TLMDVisibleControls = (ccOkButton, ccCancelButton, ccHelpButton,
    ccFolderCombo,
    ccFileNameEdit, ccFileTypeComboBox, ccReadOnlyCheckBox,
    ccLookInLabel, ccFileNameLabel, ccFileTypeLabel);
  TLMDVisibleControlsSet = set of TLMDVisibleControls;

const
  DefaultVisibleControls = [ccOkButton, ccCancelButton, ccHelpButton,
    ccFolderCombo,
    ccFileNameEdit, ccFileTypeComboBox, ccReadOnlyCheckBox,
    ccLookInLabel, ccFileNameLabel, ccFileTypeLabel];

type
  TLMDFormOpenDialog = class(TLMDFormCommonDialog)
  private
    FHistoryList: TStrings;
    FOptions: TLMDFormOpenOptions;
    FFilter: TLMDFilterString;
    FFilterIndex: Integer;
    FCurrentFilterIndex: Integer;
    FInitialDir: string;
    FDefaultExt: string;
    FFileName: TLMDFileName;
    FFiles: TStrings;
    FFileEditStyle: TLMDFileEditStyle;
    FVisibleControls: TLMDVisibleControlsSet;

    FOnSelectionChange: TNotifyEvent;
    FOnFolderChange: TNotifyEvent;
    FOnTypeChange: TNotifyEvent;
    FOnFileOk: TCloseQueryEvent;
    FOnShareViolation: TNotifyEvent;

    //5.05
    FOptionsEx: TOpenOptionsEx;
    function GetDialogTemplateHandle: THandle; override;
    function GetFileName: string;
    function GetFilterIndex: Integer;
    function GetFiles: TStrings;
    procedure ReadFileEditStyle(Reader: TReader);
    procedure SetHistoryList(Value: TStrings);
    procedure SetInitialDir(const Value: string);
    procedure SetDefaultExt(const Value: string);

  protected
    procedure ValidateBounds; override;
    procedure DefineProperties(Filer: TFiler); override;

    function DoExecute(Func: TDialogFunc): Bool;
    //    function DoExecute(Func: Pointer): Bool;

    procedure SetVisibleControls(Controls: TLMDVisibleControlsSet);
    function GetDirectory: string;
    procedure UpdateFiles;
    function GetToolBarHandle: HWND;
    procedure DoShow; override;
    procedure DoSelectionChange; virtual;
    procedure DoFolderChange; virtual;
    procedure DoTypeChange; virtual;
    function DoFileOk: Boolean; virtual;
    procedure DoShareViolation;

    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
    //simulate mouse click on
    //"Up One Level","Create New Folder","List","Details"
    //button respectively. Use with caution: it's undocumented!
    procedure ToolBarButtonClick(N: Integer);
    //Show (Value=true) or hide (Value=false) Common Dialog's toolbar
    //Undocumented too :(
    procedure ShowToolBar(Value: boolean);
    property FileEditStyle: TLMDFileEditStyle read FFileEditStyle write
      FFileEditStyle;
    property Files: TStrings read GetFiles;
    property Directory: string read GetDirectory;
    property HistoryList: TStrings read FHistoryList write SetHistoryList;
    property DialogHandle;
    property DialogShowing;
  published
    property Ctl3D; //: Boolean read FCtl3D write FCtl3D default True;
    property DefaultExt: string read FDefaultExt write SetDefaultExt;
    property FileName: TLMDFileName read GetFileName write FFileName;
    property Filter: TLMDFilterString read FFilter write FFilter;
    property FilterIndex: Integer read GetFilterIndex write FFilterIndex default
      1;
    property InitialDir: string read FInitialDir write SetInitialDir;
    property Options: TLMDFormOpenOptions read FOptions write FOptions default
      [ofHideReadOnly];
    property VisibleControls: TLMDVisibleControlsSet read FVisibleControls write
      SetVisibleControls
      default DefaultVisibleControls;
    property HelpContext;
    property OnFolderChange: TNotifyEvent read FOnFolderChange write
      FOnFolderChange;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write
      FOnSelectionChange;
    property OnTypeChange: TNotifyEvent read FOnTypeChange write FOnTypeChange;
    property OnFileOK: TCloseQueryEvent read FOnFileOK write FOnFileOK;
    property OnHelp;
    property OnShareViolation: TNotifyEvent read FOnShareViolation write
      FOnShareViolation;
    // --> Reserved for LMD-Tools 6.0
    property OptionsEx: TOpenOptionsEx read FOptionsEx write FOptionsEx default [ofExNoPlacesBar];
  end;

  {------------------ TLMDFormSaveDialog  -------------------------------------}
  TLMDFormSaveDialog = class(TLMDFormOpenDialog)
  protected
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  {------------------ TLMDFormColorDialog  ------------------------------------}
  TLMDFormColorDialogOption = (cdShowHelp, cdSolidColor, cdAnyColor);
  TLMDFormColorDialogOptions = set of TLMDFormColorDialogOption;

  TLMDCustomColors = array[0..MaxCustomColors - 1] of Longint;

  TLMDFormColorDialog = class(TLMDFormCommonDialog)
  private
    FOnColorChange: TNotifyEvent;
    FColor: TColor;
    FOptions: TLMDFormColorDialogOptions;
    FCustomColors: TStrings;
    procedure SetCustomColors(Value: TStrings);
    function GetColor: TColor;
    procedure SetColor(Value: TColor);
    procedure UpdateColor;

  protected
    procedure DoShow; override;
    procedure ValidateBounds; override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
  published
    property Color: TColor read GetColor write SetColor default clBlack;
    property Ctl3D default False;
    property CustomColors: TStrings read FCustomColors write SetCustomColors;
    property Options: TLMDFormColorDialogOptions read FOptions write FOptions
      default [];

    property OnColorChange: TNotifyEvent read FOnColorChange write
      FOnColorChange;
  end;

  {------------------ TLMDFormFontDialog --------------------------------------}
  TLMDFormFontDialogOption = (fdAnsiOnly, fdTrueTypeOnly, fdEffects,
    fdFixedPitchOnly, fdForceFontExist, fdNoFaceSel, fdNoOEMFonts,
    fdNoSimulations, fdNoSizeSel, fdNoStyleSel, fdNoVectorFonts,
    fdShowHelp, fdWysiwyg, fdLimitSize, fdScalableOnly, fdApplyButton);
  TLMDFormFontDialogOptions = set of TLMDFormFontDialogOption;

  TLMDFormFontDialogDevice = (fdScreen, fdPrinter, fdBoth);
  TLMDFormDialogApplyEvent = procedure(Sender: TObject) of object;

  TLMDFormFontDialog = class(TLMDFormCommonDialog)
  private
    FFont: TFont;
    FSampleCaption: string;
    FDevice: TLMDFormFontDialogDevice;
    FOptions: TLMDFormFontDialogOptions;
    FOnApply: TLMDFormDialogApplyEvent;
    FOnFontChange: TNotifyEvent;
    FMinFontSize: Integer;
    FMaxFontSize: Integer;
    procedure DoApply(Wnd: HWND);
    procedure SetFont(Value: TFont);
    procedure UpdateFromLogFont(const LogFont: TLogFont);

  protected
    procedure Apply(Wnd: HWND); virtual;
    procedure WndProc(var Message: TMessage); override;
    procedure ValidateBounds; override;
    procedure SetSampleCaption(Value: string);
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
  published
    property Font: TFont read FFont write SetFont;
    property Device: TLMDFormFontDialogDevice read FDevice write FDevice default
      fdScreen;
    property MinFontSize: Integer read FMinFontSize write FMinFontSize;
    property MaxFontSize: Integer read FMaxFontSize write FMaxFontSize;
    property SampleCaption: string read FSampleCaption write SetSampleCaption;
    property Options: TLMDFormFontDialogOptions read FOptions write FOptions
      default [fdEffects];
    property OnApply: TLMDFormDialogApplyEvent read FOnApply write FOnApply;
    property OnFontChange: TNotifyEvent read FOnFontChange write FOnFontChange;
  end;

  {------------------ TLMDFormPageSetupDialog  --------------------------------}
  TLMDPageSetupOption = (poDefaultMinMargins, poDisableMargins,
    poDisableOrientation,
    poDisablePagePainting, poDisablePaper, poDisablePrinter, poNoWarning,
    poShowHelp);
  TLMDPageSetupOptions = set of TLMDPageSetupOption;

  TLMDPaperType = (ptPaper, ptEnvelope);
  TLMDPaperOrientation = (poPortrait, poLandscape);
  TLMDPrinterType = (ptDotMatrix, ptHPPCL);
  TLMDPaintWhat = (pwFullPage, pwMinimumMargins, pwMargins,
    pwGreekText, pwEnvStamp, pwYAFullPage);

  TLMDMeasurements = (pmMillimeters, pmInches);

  TLMDPaintPageEvent = function(Sender: TObject; PaintWhat: TLMDPaintWhat;
    Canvas: TCanvas; Rect: TRect): boolean of object;

  //Set ShowPrinters to false if you handled "Printer..." button click yourself
  //for example by showing your own list of printers,
  //if true, default printer list will be shown
  TLMDOnPrinterClickEvent = procedure(Sender: TObject; var ShowPrinters: boolean)
    of object;

  TLMDFormPageSetupDialog = class(TLMDFormCommonDialog)
  private
    FOptions: TLMDPageSetupOptions;
    FPaperSize: TPoint;
    FMinimumMargins: TRect;
    FMargins: TRect;
    FMeasurements: TLMDMeasurements;
    FOnPrinter: TLMDOnPrinterClickEvent;
    FOnPaintPage: TLMDPaintPageEvent;

    function DoPrinter: boolean;
    //    function DoExecute(Func: Pointer): boolean;
    function DoExecute(Func: TDialogFunc): boolean;
    protected
    function Printer: boolean; virtual;
    procedure ValidateBounds; override;
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: boolean; override;
    procedure RedrawPage;
    property PaperSize: TPoint read FPaperSize write FPaperSize;
    property MinimumMargins: TRect read FMinimumMargins write FMinimumMargins;
    property Margins: TRect read FMargins write FMargins;
  published
    property Options: TLMDPageSetupOptions read FOptions write FOptions default
      [poDefaultMinMargins, poShowHelp];
    property Measurements: TLMDMeasurements read FMeasurements write
      FMeasurements default pmInches;
    property OnPrinter: TLMDOnPrinterClickEvent read FOnPrinter write
      FOnPrinter;
    property OnPaintPage: TLMDPaintPageEvent read FOnPaintPage write
      FOnPaintPage;
  end;

  {------------------ TLMDFormPrinterSetupDialog  -----------------------------}
  TLMDFormPrinterSetupDialog = class(TLMDFormCommonDialog)
  protected
    procedure ValidateBounds; override;
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  {------------------ TLMDFormPrinterCommDialog  ------------------------------}
  TLMDPrintRange = (prAllPages, prSelection, prPageNums);
  TLMDPrintDialogOption = (poPrintToFile, poPageNums, poSelection, poWarning,
    poHelp, poDisablePrintToFile);
  TLMDPrintDialogOptions = set of TLMDPrintDialogOption;

  TLMDFormPrintCommDialog = class(TLMDFormCommonDialog)
  private
    FFromPage: Integer;
    FToPage: Integer;
    FCollate: Boolean;
    FOptions: TLMDPrintDialogOptions;
    FPrintToFile: Boolean;
    FPrintRange: TLMDPrintRange;
    FMinPage: Integer;
    FMaxPage: Integer;
    FCopies: Integer;
  protected
    procedure SetNumCopies(Value: Integer);
    procedure ValidateBounds; override;
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  published
    property Collate: Boolean read FCollate write FCollate default False;
    property Copies: Integer read FCopies write SetNumCopies default 0;
    property FromPage: Integer read FFromPage write FFromPage default 0;
    property MinPage: Integer read FMinPage write FMinPage default 0;
    property MaxPage: Integer read FMaxPage write FMaxPage default 0;
    property Options: TLMDPrintDialogOptions read FOptions write FOptions default
      [];
    property PrintToFile: Boolean read FPrintToFile write FPrintToFile default
      False;
    property PrintRange: TLMDPrintRange read FPrintRange write FPrintRange
      default prAllPages;
    property ToPage: Integer read FToPage write FToPage default 0;
  end;

  {------------------ TLMDFormFolderDialog  -----------------------------------}
  TLMDFormFolderDialogOption = (bfFileSysDirsOnly, bfDontGoBelowDomain,
    bfStatusText,
    bfFileSysAncestors, bfBrowseForComputer, bfBrowseForPrinter,
    bfShowPathInStatusArea);

  TLMDFormFolderDialogOptions = set of TLMDFormFolderDialogOption;

  TLMDFormShellFolder = (sfoDesktopExpanded, sfoDesktop, sfoPrograms,
    sfoControlPanel,
    sfoPrinters, sfoPersonal, sfoFavorites, sfoStartup, sfoRecent,
    sfoSendto, sfoRecycleBin, sfoStartMenu, sfoDesktopDirectory, sfoMyComputer,
    sfoNetwork, sfoNetworkNeighborhood, sfoFonts, sfoTemplates,
    sfoCommonStartMenu, sfoCommonPrograms, sfoCommonStartup,
    sfoCommonDesktopDirectory, sfoAppData, sfoPrintHood);

  TLMDFormFolderDialog = class(TLMDFormCommonDialog)
  private
    FOptions: TLMDFormFolderDialogOptions;
    FRootIDList: PItemIDList; // corresponds with RootFolder
    FSelectionIDList: PItemIDList; // dlg result; relative to FRootIDList
    FDirectory, FSelectionPath: string;
    FRootFolder: TLMDFormShellFolder;
    FImageIndex: Integer;
    FDisplayName: string;
    FStatusText: string;
    FTitle: string;
    FOnChange: TNotifyEvent;
    procedure SetSelectionPath(Value: string);
    function GetDirectory: string;
    procedure SetDirectory(Value: string);
    procedure SetRootFolder(Value: TLMDFormShellFolder);
    procedure SetSelectionPIDL(Value: PItemIDList);
    procedure SetOptions(Value: TLMDFormFolderDialogOptions);
    procedure SetStatusText(const Value: string);
    procedure SetTitle(Value: string);
  protected
    procedure ValidateBounds; override;
    procedure ReplaceSelection(PIDL: PItemIDList);
    procedure DoShow; override;
    procedure WndProc(var Message: TMessage); override;
    procedure BFFMInitialized(Param: WPARAM);
    procedure BFFMSelChanged(Param: WPARAM);
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
    procedure EnableOK(const Value: Boolean);
    property DisplayName: string read FDisplayName;
    property SelectionPath: string read FSelectionPath write SetSelectionPath;
    property Directory: string read GetDirectory write SetDirectory;
    property SelectionPIDL: PItemIDList read FSelectionIDList write
      SetSelectionPIDL;
    property RootPIDL: PItemIDList read FRootIDList;
    property StatusText: string read FStatusText write SetStatusText;
  published
    property Title: string read FTitle write SetTitle;
    property RootFolder: TLMDFormShellFolder read FRootFolder write SetRootFolder
      default sfoDesktopExpanded;
    property Options: TLMDFormFolderDialogOptions read FOptions write SetOptions
      default [bfFileSysDirsOnly, bfStatusText, bfShowPathInStatusArea];
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  {------------------ TLMDFormOLEDialog  --------------------------------------}
  TLMDFormOLEDialog = class(TLMDFormCommonDialog)
  private
    FErrorCode: Integer;
  protected
    procedure DoShow; override;
  public
    function ErrorCodeAsStr: string; virtual;
    property ErrorCode: Integer read FErrorCode;
  end;

  {------------------ TLMDFormChangeIconDialog  -------------------------------}
  TLMDChangeIconSelect = (cisDefault, cisCurrent, cisFromFile);

  TLMDFormChangeIconDialog = class(TLMDFormOLEDialog)
  private
    FSelection: TLMDChangeIconSelect;
    FShowHelp: boolean;
    FUseIconEXE: boolean;
    FMetafile: TMetafile;
    FClsID: TClsID;
    FEXEName: string;
    procedure SetMetafile(const Value: TMetafile);
  protected
    procedure ValidateBounds; override;
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
    function ErrorCodeAsStr: string; override;
    property Metafile: TMetafile read FMetafile write SetMetafile;
    property ClsID: TClsID read FClsId write FclsId;
  published
    property Selection: TLMDChangeIconSelect read FSelection write FSelection;
    property ShowHelp: boolean read FShowHelp write FShowHelp;
    property UseIconEXE: boolean read FUseIconEXE write FUseIconEXE;
    property EXEName: string read FEXEName write FEXEName;
  end;

  {------------------ TLMDInsertObjectDialog  ---------------------------------}
  TLMDInsertObjectOption = (iofShowHelp, iofCheckLink, iofCheckDisplayAsIcon,
    iofCreateNewObject, iofCreateFileObject,
    iofCreateLinkObject, iofDisableLink,
    iofVerifyServerExists, iofDisableDisplayAsIcon,
    iofHideChangeIcon, iofShowInsertControl);
  TLMDInsertObjectOptions = set of TLMDInsertObjectOption;

  TLMDIOSelectedOption = (iosCreateNew, iosCreateFromFile, iosCreateControl);

  TLMDFormInsertObjectDialog = class(TLMDFormOLEDialog)
  private
    FOptions: TLMDInsertObjectOptions;
    FSelected: TLMDIOSelectedOption;
    FClsId: TCLSID;
    FFileName: string;
    FExcludeList: TList;
    FIID: TIID;
    FOLERender: Integer;
    FFormatEtc: TFormatEtc;
    FIOLEClientSite: IOLEClientSite;
    FIStorage: IStorage;
    FObject: Pointer;
    FSC: SCode;
    FMetafile: TMetafile;
  protected
    procedure ValidateBounds; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ErrorCodeAsStr: string; override;
    function Execute: Boolean; override;
    property ClsID: TCLSID read FClsId;
    property FileName: string read FFileName;
    property ExcludeList: TList read FExcludeList;
    property IID: TIID read FIID write FIID;
    property OleRender: Integer read FOleRender write FOleRender;
    property FormatEtc: TFormatEtc read FFormatEtc write FFormatEtc;
    property IOLECLientSite: IOLEClientSite read FIOLEClientSite write
      FIOLEClientSite;
    property IStorage: IStorage read FIStorage write FIStorage;
    property PObject: Pointer read FObject;
    property SC: SCode read FSC;
    property Metafile: TMetafile read FMetafile;
  published
    property Options: TLMDInsertObjectOptions read FOPtions write FOptions;
    property Selected: TLMDIOSelectedOption read FSelected write FSelected;
  end;

  // 5.05
const
  OFNEXNOPLACESBAR = 1;

implementation

uses
  OLEDlg,
  Types, SysUtils, Dlgs, CommDlg, Consts, Printers,
  LMDMain, LMDSysIn, LMDUtils, LMDProcs, LMDStrings;

//dirty cheating class :)
type
  TCheatControl = class(TControl)
    procedure Cheat_UpdateBoundsRect(Control: TControl; R: TRect);
  end;

procedure TCheatControl.Cheat_UpdateBoundsRect(Control: TControl; R: TRect);
begin
  Self := TCheatControl(Control); //don't try this at home!
  Self.UpdateBoundsRect(R);
end;

const
  //Numbers of the common dialog  static buttons
  cdbUpOneLevel = 1;
  cdbCreateNewFolder = 2;
  cdbList = 3;
  cdbDetails = 4;

  { Private globals }
var

  BMPScaleX: single = 1.0;
  BMPScaleY: single = 1.0;

  FOpenDialogWidth: Integer = 410;
  FOpenDialogHeight: Integer = 280;
  FFontDialogWidth: Integer = 395;
  FFontDialogHeight: Integer = 319;
  FColorDialogWidth: Integer = 447;
  FColorDialogHeight: Integer = 299;
  FPrintDialogWidth: Integer = 432;
  FPrintDialogHeight: Integer = 302;
  FPrinterSetupDialogWidth: Integer = 432;
  FPrinterSetupDialogHeight: Integer = 289;
  FPageSetupDialogWidth: Integer = 360;
  FPageSetupDialogHeight: Integer = 390;
  FFolderDialogWidth: Integer = 318;
  FFolderDialogHeight: Integer = 306;

  FChangeIconDialogWidth: Integer = 386;
  FChangeIconDialogHeight: Integer = 249;
  FInsertObjectDialogWidth: Integer = 440;
  FInsertObjectDialogHeight: Integer = 244;

var
  CreationControl: TLMDFormCommonDialog = nil;
  HelpMsg: Integer;
  HookCtl3D: Boolean;

  { Center the given window on the screen }

procedure CenterWindow(Wnd: HWnd);
var
  Rect: TRect;
begin
  GetWindowRect(Wnd, Rect);
  SetWindowPos(Wnd, 0,
    (GetSystemMetrics(SM_CXSCREEN) - Rect.Right + Rect.Left) div 2,
    (GetSystemMetrics(SM_CYSCREEN) - Rect.Bottom + Rect.Top) div 3,
    0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

{ Generic dialog hook. Centers the dialog on the screen in response to
  the WM_INITDIALOG message }

function DialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM;
  LParam: LPARAM): {$IFDEF LMDCOMP16}NativeUInt{$ELSE}UINT{$ENDIF}; stdcall;
begin
  Result := 0;
  case Msg of
    WM_INITDIALOG:
      begin
        CenterWindow(Wnd);
        CreationControl.FHandle := Wnd;
        CreationControl.FDialogHandle := GetParent(Wnd);

        CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
          TLMDPtrInt(CreationControl.FObjectInstance)));

        CallWindowProc(CreationControl.FObjectInstance, Wnd,
                       Msg, WParam, LParam);
        CreationControl := nil;
      end;
//    WM_DESTROY:
  end;
end;

{ TLMDFormCommonDialog }

function  TLMDFormCommonDialog.GetDialogTemplateHandle: THandle;
begin
  Result := 0;
end;

constructor TLMDFormCommonDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDlgBaseUnits := GetDialogBaseUnits;
  FCtl3D := True;
  FObjectInstance := Classes.MakeObjectInstance(WndProc);
  FDialogTemplateHandle := 0;
  Width := 100;
  Height := 100;
  Top := 0;
  Left := 0;
  if csDesigning in ComponentState then
    Visible := true
  else
    Visible := false;
  {Visible:=true;}
  FDialogShowing := false;
  FHandle := 0;
  FDialogHandle := 0;
  FForm := nil;
  FOldFormParent := nil;
  FOldFormParentHandle := 0;
  FOldFormWndProc := nil;
  FUpdateFFormRect := false;
  FSkipMessages := false;
  FDesignBMPName := '';
  OkButtonCaption := '&Ok';
  HelpButtonCaption := '&Help';
  CancelButtonCaption := 'Cancel';
  FDesignCaption := '  At run time, Windows will'#13#10 +
    ' place controls in this area.';
end;

destructor TLMDFormCommonDialog.Destroy;
begin
  if Assigned(FObjectInstance) then
    Classes.FreeObjectInstance(FObjectInstance);
  if FDialogTemplateHandle <> 0 then
    GlobalFree(FDialogTemplateHandle);
  inherited Destroy;
end;

function TLMDFormCommonDialog.GetDlgBaseUnits: Integer;
begin
  Result := GetDialogBaseUnits;
end;

procedure TLMDFormCommonDialog.RescaleParent;

  procedure RescaleControl(Control: TControl; cx, cy: single);
  var
    i, l, t, w, h: Integer;
  begin
    l := round(cx * Control.Left);
    t := round(cy * Control.Top);
    w := round(cx * Control.Width);
    h := round(cy * Control.Height);
    Control.SetBounds(l, t, w, h);
    if (Control is TWinControl) then
      for i := 0 to TWinControl(Control).ControlCount - 1 do
        RescaleControl(TWinControl(Control).Controls[i], cx, cy);
  end;

var
  sx, sy: single;
  BU: Integer;
  xbu, ybu, old_xbu, old_ybu: word;
begin
  if (not (csDesigning in ComponentState)) and
    (not FParentWasRescaled) and
    (FForm <> nil) then
  begin
    BU := GetDialogBaseUnits;
    xbu := BU and $FFFF;
    ybu := BU shr 16;
    old_xbu := FDlgBaseUnits and $FFFF;
    old_ybu := FDlgBaseUnits shr 16;
    if FForm.Scaled then
    begin
      if old_xbu = xbu then
        sx := 1.0
      else
        if old_xbu < xbu then
          sx := 1.1
        else
          sx := 0.9;
      sy := 1.0;
    end
    else
    begin
      //sx:=xbu/old_xbu*1.1;
      if old_xbu = xbu then
        sx := 1.0
      else
        if old_xbu < xbu then
          sx := xbu / old_xbu * 1.1
        else
          sx := xbu / old_xbu * 0.9;
      sy := ybu / old_ybu;
    end;
    RescaleControl(FForm, sx, sy);
    FParentWasRescaled := true;
  end;
end;

procedure TLMDFormCommonDialog.SetOkButtonCaption(const Value: string);
begin
  if FDialogHandle <> 0 then
    SendMessage(GetDlgItem(FDialogHandle, IDOK), WM_SETTEXT, 0,
                LPARAM(PChar(Value)));
  FOkButtonCaption := Value;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormCommonDialog.SetCancelButtonCaption(const Value: string);
begin
  if FDialogHandle <> 0 then
  begin
    SendMessage(GetDlgItem(FDialogHandle, IDCANCEL), WM_SETTEXT, 0,
                LPARAM(PChar(Value)));
  end;
  FCancelButtonCaption := Value;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormCommonDialog.SetHelpButtonCaption(const Value: string);
begin
  if FDialogHandle <> 0 then
    SendMessage(GetDlgItem(FDialogHandle, pshHelp), WM_SETTEXT, 0,
                LPARAM(PChar(Value)));
  FHelpButtonCaption := Value;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormCommonDialog.Paint;
var
  r, r2: TRect;
  h: Integer;
  BMP: TBitmap;
begin
  if csDesigning in ComponentState then
  begin
    ValidateBounds;
    //R:=Rect(0,0,round(BMPScaleX*Width-1),round(BMPScaleX*Height-1));
    R := Rect(0, 0, Width - 1, Height - 1);
    BMP := TBitmap.Create;
    try
      //this resource is present only at design time in the dsdialog.dcr file
      BMP.LoadFromResourceName(HInstance, FDesignBMPName);
      except
    end;
    if not BMP.Empty then
    begin
      //Canvas.Draw((Self.Width-BMP.Width) div 2,(Self.Height-BMP.Height) div 2,BMP);
      Canvas.StretchDraw(R, BMP);
    end
    else //No bitmap resource :(
      with Canvas do
      begin
        if Parent <> nil then
        begin
          Brush.Color := clGray;
          FillRect(R);
        end;
        Pen.Color := clWhite;
        MoveTo(0, Height - 1);
        LineTo(0, 0);
        LineTo(Width - 1, 0);
        Pen.Color := clBlack;
        LineTo(Width - 1, Height - 1);
        LineTo(0, Height - 1);
        Font.Name := 'MS Sans Serif';
        Font.Size := 12;
        Font.Color := clLime;
        R2 := R;
        h := DrawText(Canvas.Handle, int_Ref(FDesignCaption),
          Length(FDesignCaption),
          R2, DT_CALCRECT or DT_LEFT or DT_NOPREFIX or DT_CENTER);
        R2 := Rect(R2.Left + 80, R.Top + (((R2.Bottom - R2.Top) - h) div 2) +
          100,
          R2.Right + 80, R.Bottom - (((R2.Bottom - R2.Top) - h) div 2) + 100);
        DrawText(Canvas.Handle, int_Ref(FDesignCaption), Length(FDesignCaption),
          R2, DT_LEFT or DT_NOPREFIX or DT_CENTER);

      end;
    BMP.Destroy;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDFormCommonDialog.GetStaticRect: TRect;
begin
  if FHandle <> 0 then
  begin
    GetWindowRect(GetDlgItem(FHandle, stc32), Result);
    MapWindowPoints(0, FHandle, Result, 2);
  end
  else
    Result := Rect(0, 0, 0, 0);
end;

{------------------------------------------------------------------------------}

procedure TLMDFormCommonDialog.SetHeight(Value: Integer);
var
  r: TRect;
begin
  if FDialogHandle <> 0 then
  begin
    GetWindowRect(FDialogHandle, R);
    SetWindowPos(FDialogHandle, 0, 0, 0, R.Right - R.Left, Value, SWP_NOMOVE or
      SWP_NOZORDER);
    GetWindowRect(FDialogHandle, R);
    if FHandle <> FDialogHandle then
    begin
      Windows.GetClientRect(FDialogHandle, R);
      SetWindowPos(FHandle, 0, 0, 0, R.Right - R.Left, R.Bottom - R.Top,
        SWP_NOMOVE or SWP_NOZORDER);
    end;
  end;
  FFormHeight := Value;
  FFormClientHeight := FormClientHeight;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormCommonDialog.SetWidth(Value: Integer);
var
  r: TRect;
begin
  if FDialogHandle <> 0 then
  begin
    GetWindowRect(FDialogHandle, R);
    SetWindowPos(FDialogHandle, 0, 0, 0, Value, R.Bottom - R.Top, SWP_NOMOVE or
      SWP_NOZORDER);
    if FHandle <> FDialogHandle then
    begin
      Windows.GetClientRect(FDialogHandle, R);
      SetWindowPos(FHandle, 0, 0, 0, R.Right - R.Left, R.Bottom - R.Top,
        SWP_NOMOVE or SWP_NOZORDER);
    end;
  end;
  FFormWidth := Value;
  FFormClientWidth := FormClientWidth;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormCommonDialog.SetClientHeight(Value: Integer);
var
  r1, r2: TRect;
begin
  if FDialogHandle <> 0 then
  begin
    Windows.GetWindowRect(FDialogHandle, R1);
    Windows.GetClientRect(FDialogHandle, R2);
    SetWindowPos(FDialogHandle, 0, 0, 0, R1.Right - R1.Left, (R1.Bottom - R1.Top)
      + (Value - (R2.Bottom - R2.Top)), SWP_NOMOVE or SWP_NOZORDER);
    if FHandle <> FDialogHandle then
    begin
      Windows.GetClientRect(FDialogHandle, R1);
      SetWindowPos(FHandle, 0, 0, 0, R1.Right - R1.Left, R1.Bottom - R1.Top,
        SWP_NOMOVE or SWP_NOZORDER);
    end;
  end;
  FFormClientHeight := Value;
  FFormHeight := FormHeight;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormCommonDialog.SetClientWidth(Value: Integer);
var
  r1, r2: TRect;
begin
  if FDialogHandle <> 0 then
  begin
    Windows.GetWindowRect(FDialogHandle, R1);
    Windows.GetClientRect(FDialogHandle, R2);
    SetWindowPos(FDialogHandle, 0, 0, 0, (R1.Right - R1.Left) + (Value -
      abs(R2.Right - R2.Left)),
      R1.Bottom - R1.Top, SWP_NOMOVE or SWP_NOZORDER);
    if FHandle <> FDialogHandle then
    begin
      Windows.GetClientRect(FDialogHandle, R1);
      SetWindowPos(FHandle, 0, 0, 0, R1.Right - R1.Left, R1.Bottom - R1.Top,
        SWP_NOMOVE or SWP_NOZORDER);
    end;
  end;
  FFormClientWidth := Value;
  FFormWidth := FormWidth;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormCommonDialog.SetLeft(Value: Integer);
var
  r: TRect;
begin
  if FHandle <> 0 then
  begin
    GetWindowRect(FDialogHandle, R);
    MoveWindow(FDialogHandle, Value, R.Top, abs(R.Right - R.Left), abs(R.Top -
      R.Bottom), TRUE);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormCommonDialog.SetTop(Value: Integer);
var
  r: TREct;
begin
  if FHandle <> 0 then
  begin
    GetWindowRect(FDialogHandle, R);
    MoveWindow(FDialogHandle, R.Left, Value, abs(R.Right - R.Left), abs(R.Top -
      R.Bottom), TRUE);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormCommonDialog.SetForm(Form: TForm);
begin
  FForm := Form;
  {FForm.BorderStyle:=bsNone;}
end;

{------------------------------------------------------------------------------}

function TLMDFormCommonDialog.GetWidth: Integer;
var
  r: TRect;
begin
  if FHandle <> 0 then
  begin
    GetWindowRect(FDialogHandle, R);
    Result := R.Right - R.Left;
  end
  else
    Result := FFormWidth;
end;

{------------------------------------------------------------------------------}

function TLMDFormCommonDialog.GetHeight: Integer;
var
  r: TRect;
begin
  if FHandle <> 0 then
  begin
    GetWindowRect(FDialogHandle, R);
    Result := R.Bottom - R.Top;
  end
  else
    Result := FFormHeight;
end;

{------------------------------------------------------------------------------}

function TLMDFormCommonDialog.GetClientWidth: Integer;
var
  r: TRect;
begin
  if FHandle <> 0 then
  begin
    Windows.GetClientRect(FDialogHandle, R);
    Result := R.Right - R.Left;
  end
  else
    Result := FFormClientWidth;
end;

{------------------------------------------------------------------------------}

function TLMDFormCommonDialog.GetClientHeight: Integer;
var
  r: TRect;
begin
  if FHandle <> 0 then
  begin
    Windows.GetClientRect(FDialogHandle, R);
    Result := R.Bottom - R.Top;
  end
  else
    Result := FFormClientHeight;
end;

function TLMDFormCommonDialog.GetLeft: Integer;
var
  R: TRect;
begin
  if FHandle <> 0 then
  begin
    GetWindowRect(FDialogHandle, R);
    Result := R.Left;
  end
  else
    Result := 0;
end;

function TLMDFormCommonDialog.GetTop: Integer;
var
  R: TRect;
begin
  if FHandle <> 0 then
  begin
    GetWindowRect(FDialogHandle, R);
    Result := R.Top;
  end
  else
    Result := 0;
end;

function TLMDFormCommonDialog.MessageHook(var Msg: TMessage): Boolean;
begin
  Result := False;
  if (Integer(Msg.Msg) = HelpMsg) and (FHelpContext <> 0) then
  begin
    Application.HelpContext(FHelpContext);
    Result := True;
  end;
end;

procedure TLMDFormCommonDialog.DefaultHandler(var Message);

begin
  if FHandle <> 0 then
  with TMessage(Message) do
      Result := CallWindowProc(FDefWndProc, FHandle, Msg, WParam, lParam)
  else
    inherited DefaultHandler(Message);
end;

procedure TLMDFormCommonDialog.WndProc(var Message: TMessage);
begin
  if (Message.Msg = WM_NOTIFY) then
    case (POFNotify(Message.LParam)^.hdr.code) of
      CDN_INITDONE:
        begin
          //FormClientWidth:=FFormClientWidth;
          //FormClientHeight:=FFormClientHeight;
          //CenterWindow(FDialogHandle);
          DoShow;
        end;
    end;
  {$ifdef LMDX64}
  if (Message.Msg = WM_COMMAND) and (Int64Rec(Message.WParam).Lo = pshHelp) and
    (Int64Rec(Message.WParam).Hi = BN_CLICKED) then
  {$else}
  if (Message.Msg = WM_COMMAND) and (LongRec(Message.WParam).Lo = pshHelp) and
    (LongRec(Message.WParam).Hi = BN_CLICKED) then
  {$endif}
  begin
    DoHelp;
  end;
  if (Message.Msg = WM_PAINT) then
  begin
    DefaultHandler(Message);
  end;
  if (Message.Msg = WM_WINDOWPOSCHANGING) and
    (csDesigning in ComponentState) then
    with TWindowPos(Pointer(Message.lParam)^) do
    begin
      cx := Self.Width;
      cy := Self.Height;
    end;
  if (Message.Msg = WM_WINDOWPOSCHANGED) then
  begin
    message.Result := 1;
  end;
  inherited WndProc(Message);
end;

procedure TLMDFormCommonDialog.WMDestroy(var Message: TWMDestroy);
begin
  DoClose;
end;

procedure TLMDFormCommonDialog.WMInitDialog(var Message: TWMInitDialog);
begin
  { Called only by non-explorer style dialogs }
  DoShow;
  { Prevent any further processing }
  Message.Result := 0;
end;

procedure TLMDFormCommonDialog.WMNCDestroy(var Message: TWMNCDestroy);
begin
  inherited;
  FHandle := 0;
  FDialogHandle := 0;
end;

procedure TLMDFormCommonDialog.WMGETMINMAXINFO(var Message: TWMGetMinMaxInfo);
//var
//  S: TPoint;
//  Temp: TMinMaxInfo;
begin
//  with TMINMAXINFO(Pointer(Message.lParam)^) do
//  begin
//    S.X := Self.Width;
//    S.Y := Self.Height;
//    ptMaxSize := S;
//    ptMinTrackSize := S;
//    ptMaxTrackSize := S;
//  end;
  Message.Result := 0;
end;

//function TLMDFormCommonDialog.TaskModalDialog(DialogFunc: Pointer; var DialogData): Integer;

function TLMDFormCommonDialog.TaskModalDialog(DialogFunc: TDialogFunc; var
  DialogData): Integer;
//type
//  TDialogFunc = function(var DialogData): Bool stdcall;
var
  ActiveWindow: HWnd;
  WindowList: TObject; //Pointer;
begin
  ActiveWindow := GetActiveWindow;
  WindowList := DisableTaskWindows(0);
  try
    Application.HookMainWindow(MessageHook);
    try
      CreationControl := Self;
      //prepare the slave form,
      //parent handle will be set in DoShow, since Common Dlg. is not shown yet
      if FForm <> nil then
      begin
        FForm.Visible := false;
        FForm.Left := -2000; //move it off-screen
        FForm.Top := -2000;
        if FForm.BorderStyle <> bsNone then
        begin
          FForm.Width := FForm.ClientWidth;
          FForm.Height := FForm.ClientHeight;
          FForm.BorderStyle := bsNone;
        end;
        FForm.Visible := true; //make it visible off the screen
      end;
      Result := Integer(TDialogFunc(DialogFunc)(DialogData));
    finally
      Application.UnhookMainWindow(MessageHook);
      //restore the slave form
      //parent handle was restored in DoClose
      if FForm <> nil then
        FForm.Visible := false;
    end;
  finally
    EnableTaskWindows(WindowList);
    SetActiveWindow(ActiveWindow);
  end;
end;

const
  StrCommonDialogOldProc = 'DS.StrCommonDialogOldProc';

function NewDialogProc(Handle: HWND; Msg: UINT;
  wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  p: Pointer;
  CF: TCheatControl;
begin
  Result := 0;
  p := Pointer(GetProp(Handle, StrCommonDialogOldProc));
  //p points to TLMDFormCommonDialog instance
  if p <> nil then
  begin
    case Msg of
      WM_WINDOWPOSCHANGED:
        begin
          CF := TCheatControl.Create(nil);
          with TLMDFormCommonDialog(p) do
            CF.Cheat_UpdateBoundsRect(FForm, Rect(FormLeft, FormTop, FormLeft +
              FormWidth, FormTop + FormHeight));
          CF.Free;
        end;
      WM_CLOSE:
        //Close the common dialog too
        begin
          TLMDFormCommonDialog(p).Form.Visible := false;
        end;
    end;
    Result := CallWindowProc(TLMDFormCommonDialog(p).OldDialogWndProc, Handle,
      Msg, wParam, lParam);
  end;
end;

//Overwrite some default FForm behavior

procedure TLMDFormCommonDialog.NewFormProc(var Message: TMessage);
var
  w, h, l, t: Integer;
  CF: TCheatControl;
  R: TRect;
  WPC: TWMWindowPosChanging;

  WindowPos: PWindowPos;

begin
  with Message do
  begin
    case Msg of
      WM_WINDOWPOSCHANGING:
        if (not FUpdateFFormRect) then
        begin

          WPC := TWMWindowPosChanging(Message);

          WindowPos := WPC.WindowPos;
          w := WindowPos.cx;
          h := WindowPos.cy;
          l := WindowPos.x;
          t := WindowPos.y;
          if FForm.WindowState <> wsNormal then
          begin
            FForm.WindowState := wsNormal;
            GetWindowRect(FDialogHandle, R);
            WindowPos.cx := R.Right - R.Right;
            WindowPos.cy := R.Bottom - R.Top;
            WindowPos.x := R.Left;
            WindowPos.y := R.Top;
            Result := 1;

            Exit;
          end
          else
          begin
            //Adjust common dialog's size and position
            if ((WindowPos.flags and SWP_NOSIZE) = 0) then
            begin
              FormWidth := w;
              FormHeight := h;
            end;
            if ((WindowPos.flags and SWP_NOMOVE) = 0) then
            begin
              FormLeft := l;
              FormTop := t;
            end;
            FUpdateFFormRect := true;
            //FForm's properties will be updated in WM_WINDOWPOSCHANGED
          //LockWindowUpdate(FDialogHandle);
          end;
        end;
      WM_WINDOWPOSCHANGED:
        //synchronize change in position
        if FUpdateFFormRect then
        begin
          FOldFormWndProc(Message);
          CF := TCheatControl.Create(nil);
          FForm.SetBounds(0, 0, FormClientWidth, FormClientHeight);
          CF.Cheat_UpdateBoundsRect(FForm, Rect(FormLeft, FormTop, FormLeft +
            FormWidth, FormTop + FormHeight));
          CF.Free;
          FUpdateFFormRect := false;
          //LockWindowUpdate(0);
          Exit;
        end;
      WM_CLOSE:
        //Close the common dialog too
        begin
          Result := SendMessage(FDialogHandle, WM_CLOSE, wParam, lParam);
        end;
      WM_SHOWWINDOW:
        //When hiding the window, close the common dialog too
        begin
          if wParam = 0 then
            Result := SendMessage(FDialogHandle, WM_CLOSE, wParam, lParam);
        end;
      WM_SETTEXT:
        //When FForms's caption changes, change the common dialog caption too
        begin

          FTitle := PChar(lParam);

          Result := SendMessage(FDialogHandle, WM_SETTEXT, wParam, lParam);
        end;
      CM_RECREATEWND:
        //Private VCL message: FForm needs to be recreated when some properties
        //(such as BorderStyle, BorderIcons, Control3D style, Position) change.
        //Don't let it do it!
        begin
          Result := 0;
          Exit;
        end;
      CM_VISIBLECHANGED:
        begin
          if (not FForm.Visible) and (not FSkipMessages) then
          begin
            FSkipMessages := true;
            FForm.Visible := true;
            FSkipMessages := false;
            Result := 1;
            PostMessage(FDialogHandle, WM_CLOSE, wParam, lParam);
          end;
        end;
      WM_GETTEXT:
        //When Windows needs caption of the FForm, return Common Dialog caption
        begin
          Result := SendMessage(FDialogHandle, WM_GETTEXT, wParam, lParam);
          Exit;
        end;
      WM_MOUSEMOVE, WM_LBUTTONDOWN, WM_LBUTTONUP,
        WM_LBUTTONDBLCLK, WM_RBUTTONDOWN, WM_RBUTTONUP, WM_RBUTTONDBLCLK,
        WM_MBUTTONDOWN, WM_MBUTTONUP, WM_MBUTTONDBLCLK:
        //Some static controls do depent on these (Color Dlg for one)
        Result := Integer(PostMessage(FDialogHandle, Msg, wParam, lParam));
    end;
    //call an old window proc
    FOldFormWndProc(Message);
  end;
end;

procedure TLMDFormCommonDialog.DoClose;
begin
  if FForm <> nil then
  begin
    FForm.WindowProc := FOldFormWndProc;
    FForm.Left := -2000;
    FForm.Top := -2000;
    FForm.Visible := false;
    FForm.ParentWindow := FOldFormParentHandle;
    FForm.Parent := FOldFormParent;
    FOldFormParentHandle := 0;
    FOldFormParent := nil;
    SetWindowLong(FDialogHandle, GWL_WNDPROC, TLMDPtrInt(FOldDialogWndProc));
    RemoveProp(FDialogHandle, StrCommonDialogOldProc);
    FOldFormWndProc := nil;
    FForm.BorderStyle := FOldFormBorderStyle;
    FForm.ClientWidth := FFormClientWidth;
    FForm.ClientHeight := FFormClientHeight;
    FForm.Realign;
  end;
  if Assigned(FOnClose) then
    FOnClose(Self);
  FDialogShowing := false;
end;

procedure TLMDFormCommonDialog.DoShow;
begin
  if FForm <> nil then
  begin
    FDialogShowing := true;
    FormClientWidth := FForm.ClientWidth;
    FormClientHeight := FForm.ClientHeight;
    FOldFormBorderStyle := FForm.BorderStyle;
    FForm.BorderStyle := bsNone;
    FOldFormParent := FForm.Parent;
    FOldFormParentHandle := FForm.ParentWindow;
    FForm.Parent := nil;
    FForm.ParentWindow := FHandle;
    FForm.Left := 0;
    FForm.Top := 0;
    SetWindowPos(FForm.Handle, HWND_BOTTOM, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);

    SendMessage(FDialogHandle, WM_SETTEXT, 0, LPARAM(PChar(FForm.Caption)));
    //Set dialog's caption

    {ic:=SendMessage(FForm.Handle,WM_GETICON,0,0);
    SendMessage(FDialogHandle,WM_SETICON,0,ic);}
    //subclass the FForm window proc to trace some messages
    FOldFormWndProc := FForm.WindowProc;
    FForm.WindowProc := NewFormProc;

    FOldDialogWndProc := TFarProc(GetWindowLong(FDialogHandle, GWL_WNDPROC));
    //Subclass common dialog window proc

    SetWindowLong(FDialogHandle, GWL_WNDPROC, TLMDPtrInt(@NewDialogProc));
    SetProp(FDialogHandle, StrCommonDialogOldProc, THandle(Self));

    //Fix a common dialog bug: hangs when windows tries to find the next tab-order control
    //Similar to q149501 (Microsoft Knowledge DB)
    SetWindowLong(Self.FHandle, GWL_EXSTYLE, GetWindowLong(Self.FHandle,
      GWL_EXSTYLE) or WS_EX_CONTROLPARENT);
    //Do the same with the FForm (in case the WS_EX_CONTROLPARENT bit was cleared)
    SetWindowLong(FForm.Handle, GWL_EXSTYLE, GetWindowLong(FForm.Handle,
      GWL_EXSTYLE) or WS_EX_CONTROLPARENT);
    OkButtonCaption := OkButtonCaption;
    HelpButtonCaption := HelpButtonCaption;
    CancelButtonCaption := CancelButtonCaption;
  end;
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

procedure TLMDFormCommonDialog.DoHelp;
begin
  if Assigned(FOnHelp) then
    FOnHelp(Self);
end;

{ Open and Save dialog routines }

function ExplorerHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM):
  {$IFDEF LMDCOMP16}NativeUInt{$ELSE}UINT{$ENDIF}; stdcall;
begin
  Result := 0;
  if Msg = WM_INITDIALOG then
  begin
    CreationControl.FHandle := Wnd;
    CreationControl.FDialogHandle := GetParent(Wnd);
    CreationControl.FDefWndProc := TFarProc(SetWindowLong(Wnd, GWL_WNDPROC,
      TLMDPtrInt(CreationControl.FObjectInstance)));
    CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
    CreationControl := nil;
    Result := 0;
  end
  else
    if (Msg = WM_NOTIFY) and (POFNotify(LParam).hdr.code = CDN_INITDONE) then
    begin
      CenterWindow(GetWindowLong(Wnd, GWL_HWNDPARENT));
      Result := 0;
    end
    else
      if (Msg = wm_windowposchanged) then
      begin
        //Result := 1;
      end
end;

{ TLMDFormOpenDialog }

constructor TLMDFormOpenDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptionsEx := [ofExNoPlacesBar];
  FHistoryList := TStringList.Create;
  FOptions := [ofHideReadOnly];
  FFiles := TStringList.Create;
  FFiles.QuoteChar:='"';
  FFiles.Delimiter:=Chr(32);
  FFilterIndex := 1;
  FFileEditStyle := fsEdit;
  Self.Width := FOpenDialogWidth;
  Self.Height := FOpenDialogHeight;
  FormWidth := Self.Width + 235;
  FormHeight := Self.Height;
  FVisibleControls := DefaultVisibleControls;
  OkButtonCaption := '&Open';
  HelpButtonCaption := '&Help';
  CancelButtonCaption := 'Cancel';
  FDesignBMPName := 'TLMDFORMCOMMONDIALOG.DESIGN.BITMAP';
  FDesignCaption := '  At run time, Windows will'#13#10 +
    ' place controls in this area.'#13#10 +
    #13#10 +
    'Drag the component to any place'#13#10 +
    '  on the form you see fit.'#13#10;
end;

destructor TLMDFormOpenDialog.Destroy;
begin
  FFiles.Free;
  FHistoryList.Free;
  inherited Destroy;
end;

procedure TLMDFormOpenDialog.ValidateBounds;
begin
  if (Width <> FOpenDialogWidth) then
    Width := FOpenDialogWidth;
  if (Height <> FOpenDialogHeight) then
    Height := FOpenDialogHeight;
end;

procedure TLMDFormOpenDialog.WndProc(var Message: TMessage);
var
  Index: Integer;
  OFN: POFNotify;
  OFileName: POpenFileName;
begin
  Message.Result := 0;
  { If not ofOldStyleDialog then DoShow on CDN_INITDONE, not WM_INITDIALOG }
  if (Message.Msg = WM_INITDIALOG) {and not (ofOldStyleDialog in Options)} then
    Exit
  else
    if (Message.Msg = WM_NOTIFY) then
    begin

      OFN := POFNotify(Message.LParam);

      case OFN.Hdr.code of
        CDN_SELCHANGE:
          DoSelectionChange;
        CDN_FOLDERCHANGE:
          DoFolderChange;
        CDN_FILEOK:
          begin
            Message.Result := Integer(not DoFileOk);
            Exit;
          end;
        CDN_HELP:
          DoHelp;
        CDN_SHAREVIOLATION:
          DoShareViolation;
        CDN_TYPECHANGE:
          begin
            OFileName := OFN.lpOFN;
            Index := OFileName.nFilterIndex;

            if Index <> FCurrentFilterIndex then
            begin
              FCurrentFilterIndex := Index;
              DoTypeChange;
            end;
          end;
      end;
    end;
  inherited WndProc(Message);
end;

procedure TLMDFormOpenDialog.SetVisibleControls(Controls:
  TLMDVisibleControlsSet);

  procedure ShowControl(ID: Integer; Visible: boolean);
  var
    cmd: Integer;
  begin
    if Visible then
      cmd := SW_SHOW
    else
      cmd := SW_HIDE;
    ShowWindow(GetDlgItem(FDialogHandle, ID), cmd);
  end;

begin
  if FHandle <> 0 then
  begin
    ShowControl(IDOK, ccOkButton in Controls);
    ShowControl(IDCANCEL, ccCancelButton in Controls);
    ShowControl(pshHelp, ccHelpButton in Controls);
    ShowControl(cmb2, ccFolderCombo in Controls);
    ShowControl(edt1, ccFileNameEdit in Controls);
    ShowControl(cmb1, ccFileTypeComboBox in Controls);
    ShowControl(chx1, ccReadOnlyCheckBox in Controls);
    ShowControl(stc4, ccLookInLabel in Controls);
    ShowControl(stc3, ccFileNameLabel in Controls);
    ShowControl(stc2, ccFileTypeLabel in Controls);
  end;
  FVisibleControls := Controls;
end;

function TLMDFormOpenDialog.GetDirectory: string;
begin
  SetLength(Result, 256);
  SendMessage(FDialogHandle, CDM_GETFOLDERPATH, 255, LPARAM(PChar(Result)));
  SetLength(Result, Length(PChar(Result)));
end;

procedure TLMDFormOpenDialog.UpdateFiles;
const
  LMaxLen: Integer = High(Word) - 16;
var
  i:Integer;
  tmp, Dir: string;
  LLen: Integer;
begin
  if ofAllowMultiSelect in FOptions then
  begin
    FFiles.Clear;
    LLen := SendMessage(FDialogHandle, CDM_GETSPEC, 0, 0);
    SetLength(Dir, LLen);
    SendMessage(FDialogHandle, CDM_GETSPEC, Length(DIR), LPARAM(PChar(DIR)));
    tmp := GetDirectory;
    if LLen = 1 then
      FFiles.Add(tmp)
    else
    begin
      tmp := LMDSlashAdd(tmp);
      FFiles.DelimitedText:=ExtractFileName(Dir);
      for i:=0 to FFiles.Count-1 do
        FFiles[i]:=tmp + FFiles[i];
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TLMDFormOpenDialog.DoShow;
var
  Vis: TLMDVisibleControlsSet;
begin
  inherited DoShow;
  //Refresh controls
  Vis := VisibleControls;
  VisibleControls := [];
  VisibleControls := Vis;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormOpenDialog.DoSelectionChange;
begin
  UpdateFiles;
  if Assigned(FOnSelectionChange) then
    FOnSelectionChange(Self);
end;

{------------------------------------------------------------------------------}

procedure TLMDFormOpenDialog.DoFolderChange;
begin
  if Assigned(FOnFolderChange) then
    FOnFolderChange(Self);
end;

{------------------------------------------------------------------------------}

procedure TLMDFormOpenDialog.DoTypeChange;
begin
  if Assigned(FOnTypeChange) then
    FOnTypeChange(Self);
end;

{------------------------------------------------------------------------------}

function TLMDFormOpenDialog.DoFileOk: boolean;
begin
  Result := true;
  if Assigned(FOnFileOk) then
    FOnFileOk(Self, Result);
end;

{------------------------------------------------------------------------------}

procedure TLMDFormOpenDialog.DoShareViolation;
begin
  if Assigned(FOnShareViolation) then
    FOnShareViolation(Self);
end;

{------------------------------------------------------------------------------}

procedure TLMDFormOpenDialog.ReadFileEditStyle(Reader: TReader);
begin
  { Ignore FileEditStyle }
  Reader.ReadIdent;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormOpenDialog.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('FileEditStyle', ReadFileEditStyle, nil, False);
end;

{------------------------------------------------------------------------------}
function TLMDFormOpenDialog.DoExecute(Func: TDialogFunc): Bool;
//function TLMDFormOpenDialog.DoExecute(Func: Pointer): Bool;
const
  MultiSelectBufferSize = 8192;
  OpenOptions: array[TLMDFOrmOpenOption] of Longint = (
    OFN_READONLY, OFN_OVERWRITEPROMPT, OFN_HIDEREADONLY,
    OFN_NOCHANGEDIR, OFN_SHOWHELP, OFN_NOVALIDATE, OFN_ALLOWMULTISELECT,
    OFN_EXTENSIONDIFFERENT, OFN_PATHMUSTEXIST, OFN_FILEMUSTEXIST,
    OFN_CREATEPROMPT, OFN_SHAREAWARE, OFN_NOREADONLYRETURN,
    OFN_NOTESTFILECREATE, OFN_NONETWORKBUTTON, OFN_NOLONGNAMES,
    OFN_NODEREFERENCELINKS);

  OpenOptionsEx: array[TOpenOptionEx] of DWORD = (OFNEXNOPLACESBAR);

var
  Option: TLMDFormOpenOption;
  OptionEx: TOpenOptionEx;
  OpenFilename: TOpenFileName;
  Separator: Char;

  function AllocFilterStr(const S: string): string;
  var
    P: PChar;
    begin
    Result := '';
    if S <> '' then
    begin
      Result := S + #0; // double null terminators
      P := AnsiStrScan(PChar(Result), '|');
      while P <> nil do
      begin
        P^ := #0;
        Inc(P);
        P := AnsiStrScan(P, '|');
        end;
    end;
  end;

  function ExtractFileName(P: PChar; var S: string): PChar;
  begin
    Result := AnsiStrScan(P, Separator);
    if (Result = nil) or (Result='') then
    begin
      S := P;
      Result := StrEnd(P);
    end
    else
    begin
      SetString(S, P, Result - P);
      Inc(Result);
    end;
  end;
  procedure ExtractFileNames(P: PChar);
  var
    DirName, FileName: String;
  begin
    p := ExtractFileName(P, DirName);
    p := ExtractFileName(P, FileName);
    if FileName = '' then
      FFiles.Add(DirName)
    else
    begin
      if AnsiLastChar(DirName)^ <> '\' then
        DirName := DirName + '\';
      repeat
        if (FileName[1] <> '\') and ((Length(FileName) <= 3) or (FileName[2] <>
          ':') or (FileName[3] <> '\')) then
          FileName := DirName + FileName;
        FFiles.Add(FileName);
        P := ExtractFileName(P, FileName);
      until FileName = '';
    end;
  end;
  var
  TempFilename,
  TempFilter, TempExt: string;

begin
  FForm := TForm(GetParentForm(Self));
  RescaleParent;
  Separator := #0;
  if (ofAllowMultiSelect in FOptions) and (not NewStyleControls) then
    Separator := ' ';
  FillChar(OpenFileName, SizeOf(OpenFileName), 0);
  with OpenFilename do
  begin
    if LMDSIWindows2000 or LMDSIWindowsME or LMDSIWindowsXP or LMDSIWindowsVista then
    begin
      // 5.05 Test, Rework for higher Delphi versions
      if ofExNoPlacesBar in FOptionsEx then
      begin
        lStructSize := SizeOf(TOpenFilename) -
          (SizeOf(DWORD) shl 1) - SizeOf(Pointer);
      end
      else
      begin
        lStructSize := SizeOf(TOpenFilename);
        FlagsEx := 0;
        for OptionEx := Low(OptionEx) to High(OptionEx) do
          if OptionEx in FOptionsEx then
            FlagsEx := FlagsEx or OpenOptionsEx[OptionEx];
      end;
    end
    else
      lStructSize := SizeOf(TOpenFilename) - (SizeOf(DWORD) shl 1) - SizeOf(Pointer);

    hInstance := DialogTemplateHandle;
    Flags := Flags or OFN_ENABLETEMPLATEHANDLE;
    TempFilter := AllocFilterStr(FFilter);

    lpstrFilter := PChar(TempFilter);
    nFilterIndex := FFilterIndex;
    FCurrentFilterIndex := FFilterIndex;
    if ofAllowMultiSelect in FOptions then
      nMaxFile := MultiSelectBufferSize
    else
      nMaxFile := MAX_PATH;
    SetLength(TempFilename, nMaxFile + 2);
      lpstrFile := PChar(TempFilename);
      FillChar(lpstrFile^, nMaxFile + 2, 0);
      StrLCopy(lpstrFile, PChar(FFileName), nMaxFile);
      lpstrInitialDir := PChar(FInitialDir);
      lpstrTitle := PChar(FTitle);
      HookCtl3D := FCtl3D;

      Flags := OFN_ENABLEHOOK;
      for Option := Low(Option) to High(Option) do
        if Option in FOptions then
          Flags := Integer(Flags) or OpenOptions[Option];

      if NewStyleControls then
        Flags := Flags xor OFN_EXPLORER
      else
        Flags := Flags and not OFN_EXPLORER;
      TempExt := FDefaultExt;
      if (TempExt = '') and (Flags and OFN_EXPLORER = 0) then
      begin
        TempExt := ExtractFileExt(FFilename);
        Delete(TempExt, 1, 1);
      end;

      if TempExt <> '' then
        lpstrDefExt := PChar(TempExt);
        if not NewStyleControls then
        lpfnHook := DialogHook
      else
        lpfnHook := ExplorerHook;

      Flags := Flags or OFN_ENABLETEMPLATEHANDLE;
      lpTemplateName := nil;
      hWndOwner := Application.Handle;
      Result := Bool(TaskModalDialog(Func, OpenFileName));
      if Result then
        begin
          if ofAllowMultiSelect in FOptions then
            begin
              ExtractFileNames(lpstrFile);
              if FFiles.Count=0 then
                FFileName:=''
              else
                FFileName := FFiles[0];
            end
          else
            begin
              FFiles.Clear;
              ExtractFileName(lpstrFile, FFileName);
              FFiles.Add(FFileName);
            end;
        if (Flags and OFN_EXTENSIONDIFFERENT) <> 0 then
          Include(FOptions, ofExtensionDifferent)
        else
          Exclude(FOptions, ofExtensionDifferent);
        if (Flags and OFN_READONLY) <> 0 then
          Include(FOptions, ofReadOnly)
        else
          Exclude(FOptions, ofReadOnly);
        FFilterIndex := nFilterIndex;
      end;
   end;
end;

{------------------------------------------------------------------------------}

function TLMDFormOpenDialog.GetDialogTemplateHandle: THandle;

const
  NULL: word = 0;
  FFFF: word = $FFFF;
  ID_STATIC: word = $82;
  DummyLong: Integer = 0;

var
  Stream: TMemoryStream;
  DlgTemp: TDLGTemplate;
  ItemTemp: TDlgItemTemplate;
  p: Pointer;
  allign_l: Integer;
  BaseUnits: longint;
begin
  Stream := nil;
  if FDialogTemplateHandle <> 0 then
    GlobalFree(FDialogTemplateHandle);
  try
    BaseUnits := GetDialogBaseUnits;
    Stream := TMemoryStream.Create;
    //dialog template
    with DLGTemp do
    begin
      Style := WS_CHILD or WS_CLIPSIBLINGS and (not DS_SETFONT);
      dwExtendedStyle := 0;
      cdit := 1;
      x := 0;
      y := 0;
      //all coordinates are specified in dialog units (see GetDialogBaseUnits())
      cx := round((FFormClientWidth + 2 * GetSystemMetrics(SM_CXEDGE)) * 4 /
        (BaseUnits and $0000FFFF));
      cy := round((FFormClientHeight + GetSystemMetrics(SM_CYCAPTION) + 2 *
        GetSystemMetrics(SM_CYEDGE)) * 8 /
        ((BaseUnits and $FFFF0000) / $FFFF));
    end;
    //Write dialog template

    Stream.Write(DLGTemp, SizeOf(DLGTemp));

    //No menu
    Stream.Write(NULL, SizeOf(NULL));
    //No window class
    Stream.Write(NULL, SizeOf(NULL));
    //No title
    Stream.Write(NULL, SizeOf(NULL));
    //Allign subsequent records on 4 byte boundary
    allign_l := (Stream.Position mod 4);
    Stream.Write(DummyLong, allign_l);
    //Magic dialog item
    with ItemTemp do
    begin
      Style := SS_LEFT or WS_CHILD or WS_GROUP and (not WS_VISIBLE);
      dwExtendedStyle := 0;
      x := round(Left * 4 /
        (BaseUnits and $0000FFFF));
      y := round(Top * 8 /
        ((BaseUnits and $FFFF0000) / $FFFF));
      cx := round(Width * 4 /
        (BaseUnits and $0000FFFF));
      cy := round(Height * 8 /
        ((BaseUnits and $FFFF0000) / $FFFF));
      id := 1119; //magic id
    end;

    Stream.Write(ItemTemp, SizeOf(ItemTemp));

    Stream.Write(FFFF, SizeOf(FFFF));
    Stream.Write(ID_STATIC, SizeOf(ID_STATIC));
    Stream.Write(NULL, SizeOf(NULL));
    Stream.Write(NULL, SizeOf(NULL));
    Stream.Write(NULL, SizeOf(NULL));

    Result := GlobalAlloc(GMEM_FIXED, Stream.Size); //Must be GMEM_FIXED !!!
    p := GlobalLock(Result);

    Move(Stream.Memory^, p^, Stream.Size);

    GlobalUnlock(Result);
    FDialogTemplateHandle := Result;
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDFormOpenDialog.GetFileName: string;
var

  Path: array[0..MAX_PATH] of Char;

begin
  if NewStyleControls and (FHandle <> 0) then
  begin

    SendMessage(FDialogHandle, CDM_GETFILEPATH, SizeOf(Path), LPARAM(@Path));
    Result := StrPas(Path);

    //first "
    if Pos('"', Result) <> 0 then
      Delete(Result, Pos('"', Result), 1);
    //second "
    if Pos('"', Result) <> 0 then
      Delete(Result, Pos('"', Result), length(Result) - Pos('"', Result) + 1);
  end
  else
    Result := FFileName;
end;

{------------------------------------------------------------------------------}

function TLMDFormOpenDialog.GetFilterIndex: Integer;
begin
  if FHandle <> 0 then
    Result := FCurrentFilterIndex
  else
    Result := FFilterIndex;
end;

{------------------------------------------------------------------------------}

function TLMDFormOpenDialog.GetFiles: TStrings;
begin
  Result := FFiles;
end;

{------------------------------------------------------------------------------}

procedure TLMDFormOpenDialog.SetHistoryList(Value: TStrings);
begin
  FHistoryList.Assign(Value);
end;

{------------------------------------------------------------------------------}

procedure TLMDFormOpenDialog.SetInitialDir(const Value: string);
var
  L: Integer;
begin
  L := Length(Value);
  if (L > 1) and IsPathDelimiter(Value, L)
    and not IsDelimiter(':', Value, L - 1) then
    Dec(L);
  FInitialDir := Copy(Value, 1, L);
end;

{------------------------------------------------------------------------------}

procedure TLMDFormOpenDialog.SetDefaultExt(const Value: string);
begin
  if Value <> FDefaultExt then
  begin
    FDefaultExt := Value;
    if FHandle <> 0 then
      SendMessage(FDialogHandle, CDM_SETDEFEXT, 0, LPARAM(PChar(Value)));
  end;
end;

{------------------------------------------------------------------------------}

function TLMDFormOpenDialog.Execute: Boolean;
begin
  Result := DoExecute(@GetOpenFileName);
end;

function EnumFunc(Handle: HWND; data: {$IFDEF LMDCOMP11}DWORD_PTR
  {$ELSE}Longint{$ENDIF}): LONGBOOL; stdcall;
var
  st: string;
begin
  Result := TRUE;

  SetLength(st, 255);
  GetClassName(Handle, PChar(st), 254);
  SetLength(st, Length(PChar(st)));

  if UpperCase(st) = 'TOOLBARWINDOW32' then
  begin
    THandle(Pointer(data)^) := Handle;
    Result := FALSE;
  end;
end;

function TLMDFormOpenDialog.GetToolBarHandle: HWND;
begin
  Result := 0;
  if FHandle <> 0 then
    EnumChildWindows(FDialogHandle, @EnumFunc, LPARAM(@Result));
end;

procedure TLMDFormOpenDialog.ToolBarButtonClick(N: Integer);
var
  R2: TRect;
  x, y: Integer;
  h: HWND;
begin
  h := GetToolBarHandle;
  Windows.GetClientRect(h, R2);
  x := R2.Left + round((N - 0.5) * ((R2.Right - R2.Left) div 4));
  y := ((R2.Top + R2.Bottom) div 2);
  PostMessage(h, WM_MOUSEMOVE, 0, x or (y shl 16));
  PostMessage(h, WM_LBUTTONDOWN, MK_LBUTTON, x or (y shl 16));
  PostMessage(h, WM_LBUTTONUP, 0, x or (y shl 16));
end;

procedure TLMDFormOpenDialog.ShowToolBar(Value: boolean);
var
  cmd: Integer;
  h: HWND;
begin
  if Value then
    cmd := SW_SHOW
  else
    cmd := SW_HIDE;
  h := GetToolBarHandle;
  if h <> 0 then
    ShowWindow(h, cmd);
end;

{ TSaveDialog }

constructor TLMDFormSaveDialog.Create(AOwner: TComponent);
begin
  inherited;
  //OkButtonCaption:='&Save';
end;

function TLMDFormSaveDialog.Execute: Boolean;
begin
  Result := DoExecute(@GetSaveFileName);
end;

{ TLMDFormColorDialog }

const
  WM_MYSETRGBVALUE: Integer = WM_USER;

  WM_MYCOLORCHANGEDSTRING: PChar = 'DS.MYCOLORCHANGEDMESSAGE';

  WM_MYCOLORCHANGED: Integer = WM_USER;

function ColorHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM;
  LParam: LPARAM): {$IFDEF LMDCOMP16}NativeUInt{$ELSE}UINT{$ENDIF}; stdcall;
begin
  {$ifdef LMDX64}
  if (Msg = WM_COMMAND) and (Int64Rec(WParam).Hi = EN_UPDATE) and
    ((Int64Rec(WParam).Lo = 706) or (Int64Rec(WParam).Lo = 707) or
    (Int64Rec(WParam).Lo = 708)) then
  {$else}
  if (Msg = WM_COMMAND) and (LongRec(WParam).Hi = EN_UPDATE) and
    ((LongRec(WParam).Lo = 706) or (LongRec(WParam).Lo = 707) or
    (LongRec(WParam).Lo = 708)) then
  {$endif}
    PostMessage(Wnd, WM_MYCOLORCHANGED, 0, 0);
  Result := DialogHook(Wnd, Msg, WParam, LParam);
end;

procedure TLMDFormColorDialog.UpdateColor;
var
  ch_red, ch_green, ch_blue: string;
  red, green, blue: byte;
  code1, code2, code3: Integer;
begin
  if FHandle <> 0 then
  begin
    SetLength(ch_red, 10);
    SetLength(ch_green, 10);
    SetLength(ch_blue, 10);

    GetDlgItemText(FHandle, 706, PChar(ch_red), 10);
    GetDlgItemText(FHandle, 707, PChar(ch_green), 10);
    GetDlgItemText(FHandle, 708, PChar(ch_blue), 10);

    val(ch_red, red, code1);
    val(ch_green, green, code2);
    val(ch_blue, blue, code3);
    if (code1 = 0) and (code2 = 0) and (code3 = 0) then
      FColor := red or (Integer(green) shl 8) or (Integer(blue) shl 16);
  end;
end;

procedure TLMDFormColorDialog.WndProc(var Message: TMessage);
var
  M: TMSG;
begin
  if (Integer(Message.Msg) = WM_MYCOLORCHANGED) then
  begin
    while PeekMessage(M, FHandle, WM_MYCOLORCHANGED, WM_MYCOLORCHANGED, PM_REMOVE) do ;
    UpdateColor;
    try
      if Assigned(OnColorChange) then
        OnColorChange(Self);
    except
    end;
  end
  else
    inherited;
end;

procedure TLMDFormColorDialog.DoShow;
begin
  FDialogHandle := FHandle;
  ShowWindow(GetDlgItem(FHandle, 719), SW_HIDE);
  ShowWindow(GetDlgItem(FHandle, 713), SW_HIDE);
  inherited;
end;

constructor TLMDFormColorDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColor := clBlack;
  FCustomColors := TStringList.Create;
  Self.Width := FColorDialogWidth;
  Self.Height := FColorDialogHeight;
  FDesignBMPName := 'TLMDFORMCOLORDIALOG.DESIGN.BITMAP';
  WM_MYSETRGBVALUE := RegisterWindowMessage(SETRGBSTRING);
  WM_MYCOLORCHANGED := RegisterWindowMessage(WM_MYCOLORCHANGEDSTRING);
end;

destructor TLMDFormColorDialog.Destroy;
begin
  FCustomColors.Free;
  inherited Destroy;
end;

procedure TLMDFormColorDialog.ValidateBounds;
begin
  if (Width <> FColorDialogWidth) then
    Width := FColorDialogWidth;
  if (Height <> FColorDialogHeight) then
    Height := FColorDialogHeight;
  Left := 0;
  Top := 0;
end;

function TLMDFormColorDialog.GetColor: TColor;
begin
  Result := FColor;
end;

procedure TLMDFormColorDialog.SetColor(Value: TColor);
begin
  if FHandle <> 0 then
    SendMessage(FHandle, WM_MYSETRGBVALUE, 0, Value);
  FColor := Value;
end;

function TLMDFormColorDialog.Execute: Boolean;
const
  DialogOptions: array[TLMDFormColorDialogOption] of LongInt = (
    CC_SHOWHELP, CC_SOLIDCOLOR, CC_ANYCOLOR);
var
  ChooseColorRec: TChooseColor;
  Option: TLMDFormColorDialogOption;

  CustomColorsArray: TLMDCustomColors;

  ColorPrefix, ColorTags: string;

  procedure GetCustomColorsArray;
  var
    I: Integer;
  begin
    for I := 0 to MaxCustomColors - 1 do
      FCustomColors.Values[ColorPrefix + ColorTags[I + 1]] :=
        Format('%.6x', [CustomColorsArray[I]]);
  end;

  procedure SetCustomColorsArray;
  var
    Value: string;
    I: Integer;
  begin
    for I := 0 to MaxCustomColors - 1 do
    begin
      Value := FCustomColors.Values[ColorPrefix + ColorTags[I + 1]];
      if Value <> '' then

        CustomColorsArray[I] := StrToInt('$' + Value)
      else
        CustomColorsArray[I] := -1;

    end;
  end;

begin
  FForm := TForm(GetParentForm(Self));
  RescaleParent;
  ColorPrefix := SColorPrefix;
  ColorTags := SColorTags;

  with ChooseColorRec do
  begin
    SetCustomColorsArray;

    lStructSize := SizeOf(ChooseColorRec);
    hInstance := SysInit.HInstance;

    rgbResult := ColorToRGB(FColor);

    lpCustColors := @CustomColorsArray;

    lCustData := 0;
    Flags := CC_RGBINIT or CC_ENABLEHOOK or CC_FULLOPEN;
    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        Flags := Integer(Flags) or DialogOptions[Option];
    HookCtl3D := FCtl3D;
    lpfnHook := ColorHook;
    lpTemplateName := nil;
    hWndOwner := Application.Handle;

    Result := bool(TaskModalDialog(@ChooseColor, ChooseColorRec));
    if Result then
    begin
      FColor := rgbResult;
      GetCustomColorsArray;
    end;

  end;
end;

procedure TLMDFormColorDialog.SetCustomColors(Value: TStrings);
begin
  FCustomColors.Assign(Value);
end;

{ TLMDFormFontDialog }

var
  FontDialog: TLMDFormFontDialog;

const
  WM_MYFONTCHANGED: Integer = WM_USER;

function FontDialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM;
  LParam: LPARAM): {$IFDEF LMDCOMP16}NativeUInt{$ELSE}UINT{$ENDIF}; stdcall;
begin
  {$ifdef LMDX64}
  if (Msg = WM_COMMAND) and (Int64Rec(WParam).Lo = psh3) and
    (Int64Rec(WParam).Hi = BN_CLICKED) then
  {$else}
  if (Msg = WM_COMMAND) and (LongRec(WParam).Lo = psh3) and
    (LongRec(WParam).Hi = BN_CLICKED) then
  {$endif}

  begin
    FontDialog.DoApply(Wnd);
    Result := 1;
  end
  else
    Result := DialogHook(Wnd, Msg, wParam, lParam);
  if Msg = WM_INITDIALOG then
    CenterWindow(Wnd);
end;

constructor TLMDFormFontDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFont := TFont.Create;
  FSampleCaption := 'AaBbYyZz';
  FOptions := [fdEffects];
  Self.Width := FFontDialogWidth;
  Self.Height := FFontDialogHeight;
  FDesignBMPName := 'TLMDFORMFONTDIALOG.DESIGN.BITMAP';
  WM_MYFONTCHANGED := RegisterWindowMessage('DS.FORM_FONT_DIALOG_FONT_CHANGED');
end;

destructor TLMDFormFontDialog.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TLMDFormFontDialog.ValidateBounds;
begin
  if (Width <> FFontDialogWidth) then
    Width := FFontDialogWidth;
  if (Height <> FFontDialogHeight) then
    Height := FFontDialogHeight;
  Left := 0;
  Top := 0;
end;

procedure TLMDFormFontDialog.SetSampleCaption(Value: string);
var
  R: TRect;
begin
  if FHandle <> 0 then
  begin

    SetDlgItemText(FHandle, stc5, PChar(Value));

    GetWindowRect(GetDlgItem(FHandle, stc5), R);
    Windows.ScreenToClient(FHandle, R.TopLeft);
    Windows.ScreenToClient(FHandle, R.BottomRight);
    LMDInvalidateRect(FHandle, R, FALSE);
  end;
  FSampleCaption := Value;
end;

procedure TLMDFormFontDialog.WndProc(var Message: TMessage);
const
  IDCOLORCMB = $473;
var
  LogFont: TLogFont;
begin
  if (Message.Msg = WM_COMMAND) and ((Message.WParamHi = CBN_SELENDOK) and
    ((Message.WParamLo = cmb1) or (Message.WParamLo = cmb2) or
    (Message.WParamLo = cmb3) or (Message.WParamLo = cmb4) or
    (Message.WParamLo = cmb5))
    or (Message.WParamLo = chx1) or (Message.WParamLo = chx2)) then
  begin
    //Cannot do processing now, let Microsoft do the work first
    //Just post the message, process it later when everything is done.
    PostMessage(FHandle, WM_MYFONTCHANGED, 0, 0);
  end;
  if (Integer(Message.Msg) = WM_MYFONTCHANGED) then //now process it
  begin
    SendMessage(FHandle, WM_CHOOSEFONT_GETLOGFONT, 0, LPARAM(@LogFont));
    UpdateFromLogFont(LogFont);
    if Assigned(FOnFontChange) then
      FOnFontChange(Self);
  end;
  inherited WndProc(Message);
end;

procedure TLMDFormFontDialog.Apply(Wnd: HWND);
begin
  if Assigned(FOnApply) then
    FOnApply(Self);
end;

procedure TLMDFormFontDialog.DoApply(Wnd: HWND);
var
  LogFont: TLogFont;
begin
  SendMessage(Wnd, WM_CHOOSEFONT_GETLOGFONT, 0, LPARAM(@LogFont));
  UpdateFromLogFont(LogFont);
  try
    Apply(Wnd);
  except
    Application.HandleException(Self);
  end;
end;

function TLMDFormFontDialog.Execute: Boolean;
const
  FontOptions: array[TLMDFormFontDialogOption] of Longint = (
    CF_ANSIONLY, CF_TTONLY, CF_EFFECTS, CF_FIXEDPITCHONLY, CF_FORCEFONTEXIST,
    CF_NOFACESEL, CF_NOOEMFONTS, CF_NOSIMULATIONS, CF_NOSIZESEL,
    CF_NOSTYLESEL, CF_NOVECTORFONTS, CF_SHOWHELP, CF_WYSIWYG, CF_LIMITSIZE,
    CF_SCALABLEONLY, CF_APPLY);
  Devices: array[TLMDFormFontDialogDevice] of Longint = (
    CF_SCREENFONTS, CF_PRINTERFONTS, CF_BOTH);
var
  ChooseFontRec: TChooseFont;
  LogFont: TLogFont;
  Option: TLMDFormFontDialogOption;
  SaveFontDialog: TLMDFormFontDialog;
  OriginalFaceName: string;
begin
  FForm := TForm(GetParentForm(Self));
  RescaleParent;
  with ChooseFontRec do
  begin
    lStructSize := SizeOf(ChooseFontRec);
    hDC := 0;
    if FDevice <> fdScreen then
      hDC := Printer.Handle;
    lpLogFont := @LogFont;
    GetObject(Font.Handle, SizeOf(LogFont), @LogFont);
    OriginalFaceName := LogFont.lfFaceName;
    Flags := Devices[FDevice] or (CF_INITTOLOGFONTSTRUCT or CF_ENABLEHOOK);
    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        Flags := Integer(Flags) or FontOptions[Option];
    Flags := Flags or CF_APPLY;
    rgbColors := Font.Color;
    lCustData := 0;
    HookCtl3D := Ctl3D;
    lpfnHook := FontDialogHook;
    nSizeMin := FMinFontSize;
    nSizeMax := FMaxFontSize;
    if nSizeMin > nSizeMax then
      Flags := Flags and (not CF_LIMITSIZE);
    hWndOwner := Application.Handle;
    SaveFontDialog := FontDialog;
    FontDialog := Self;
    Result := bool(TaskModalDialog(@ChooseFont, ChooseFontRec));
    FontDialog := SaveFontDialog;
    if Result then
    begin
      UpdateFromLogFont(LogFont);
      Font.Color := rgbColors;
    end;
    end;
end;

procedure TLMDFormFontDialog.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  if Assigned(FOnFontChange) then
    FOnFontChange(Self);
end;

procedure TLMDFormFontDialog.UpdateFromLogFont(const LogFont: TLogFont);
const
  IDCOLORCMB = $473;
var
  I: Integer;
  Style: TFontStyles;
begin
  with LogFont do
  begin
    Font.Name := LogFont.lfFaceName;
    Font.Height := LogFont.lfHeight;
    Font.Charset := TFontCharset(LogFont.lfCharSet);
    Style := [];
    with LogFont do
    begin
      if lfWeight > FW_REGULAR then
        Include(Style, fsBold);
      if lfItalic <> 0 then
        Include(Style, fsItalic);
      if lfUnderline <> 0 then
        Include(Style, fsUnderline);
      if lfStrikeOut <> 0 then
        Include(Style, fsStrikeOut);
    end;
    Font.Style := Style;
    I := SendDlgItemMessage(FHandle, IDCOLORCMB, CB_GETCURSEL, 0, 0);
    if I <> CB_ERR then
      Font.Color := SendDlgItemMessage(FHandle, IDCOLORCMB, CB_GETITEMDATA, I,
        0);
  end;
end;

procedure TLMDFormFontDialog.DoShow;
begin
  FDialogHandle := FHandle;
  SetSampleCaption(FSampleCaption);
  inherited;
end;

{TLMDFormPageSetupDialog}

var
  PageSetupDialogTMP: TLMDFormPageSetupDialog;

const
  PAGESETUPPAINTHOOKSTRING: PChar = 'DS.PAGESETUPPAINTHOOKSTRING';
  function PageSetupHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM;
                         LParam: LPARAM): {$IFDEF LMDCOMP16}NativeUInt
                         {$ELSE}UINT{$ENDIF}; stdcall;

const
  PagePaintWhat: array[WM_PSD_FULLPAGERECT..
  WM_PSD_YAFULLPAGERECT] of TLMDPaintWhat = (
    pwFullPage, pwMinimumMargins, pwMargins,
    pwGreekText, pwEnvStamp, pwYAFullPage
    );
  PRINTER_MASK = $00000002;
  ORIENT_MASK = $00000004;
  PAPER_MASK = $00000008;
var
  PaintRect: TRect;
  PaintCanvas: TCanvas;
  PageSetupDialog: TLMDFormPageSetupDialog;

begin
  PageSetupDialog := Pointer(GetProp(Wnd, PAGESETUPPAINTHOOKSTRING));
  if PageSetupDialog = nil then
    PageSetupDialog := PageSetupDialogTMP;
  if PageSetupDialog <> nil then
  begin
    {$ifdef LMDX64}
    if (Msg = WM_COMMAND) and (Int64Rec(WParam).Lo = $402) and
      (Int64Rec(WParam).Hi = BN_CLICKED) then
    {$else}
    if (Msg = WM_COMMAND) and (LongRec(WParam).Lo = $402) and
      (LongRec(WParam).Hi = BN_CLICKED) then
    {$endif}
    begin
      Result := ord(not PageSetupDialog.DoPrinter);
    end
    else
      case Msg of
        WM_PSD_PAGESETUPDLG:
          begin
            if LParam <> 0 then
            begin
              with TPageSetupDlg(Pointer(LParam)^) do
              begin
                PageSetupDialog.FPaperSize := ptPaperSize;
                PageSetupDialog.FMargins := rtMargin;
                PageSetupDialog.FMinimumMargins := rtMinMargin;
                if (Flags and PSD_INHUNDREDTHSOFMILLIMETERS) <> 0 then
                  PageSetupDialog.FMeasurements := pmMillimeters
                else
                  PageSetupDialog.FMeasurements := pmInches;
              end;
            end;
            Result := 0;
          end;
        WM_PSD_FULLPAGERECT,
          WM_PSD_MINMARGINRECT,
          WM_PSD_MARGINRECT,
          WM_PSD_GREEKTEXTRECT,
          WM_PSD_ENVSTAMPRECT,
          WM_PSD_YAFULLPAGERECT:
          begin
            if LParam <> 0 then
              PaintRect := PRect(LParam)^
              else
              PaintRect := Rect(0, 0, 0, 0);
            PaintCanvas := TCanvas.Create;
            PaintCanvas.Handle := HDC(WParam);
            if assigned(PageSetupDialog.FOnPaintPage) then
            try
              Result := Ord(PageSetupDialog.FOnPaintPage(PageSetupDialog,
                PagePaintWhat[Msg], PaintCanvas, PaintRect));
            finally
              PaintCanvas.Free;
            end
            else
              Result := DialogHook(Wnd, Msg, wParam, lParam)
          end
      else
        Result := DialogHook(Wnd, Msg, wParam, lParam);
      end;
  end
  else
    Result := DialogHook(Wnd, Msg, wParam, lParam);
end;

procedure TLMDFormPageSetupDialog.DoShow;
begin
  FDialogHandle := FHandle;
  SetProp(FDialogHandle, PAGESETUPPAINTHOOKSTRING, TLMDPtrUInt(Self));
  inherited;
  CenterWindow(FDialogHandle);
end;

constructor TLMDFormPageSetupDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := [poDefaultMinMargins, poShowHelp];
  FOnPrinter := nil;
  FOnPaintPage := nil;
  FPaperSize := Point(0, 0);
  FMinimumMargins := Rect(0, 0, 0, 0);
  FMargins := Rect(1000, 1000, 1000, 1000);
  FMeasurements := pmInches;
  HelpMsg := RegisterWindowMessage(HelpMsgString);
  Self.Width := FPageSetupDialogWidth;
  Self.Height := FPageSetupDialogHeight;
  FDesignBMPName := 'TLMDFORMPAGESETUPDIALOG.DESIGN.BITMAP';
end;

destructor TLMDFormPageSetupDialog.Destroy;
begin
  inherited Destroy;
end;

procedure TLMDFormPageSetupDialog.ValidateBounds;
begin
  if (Width <> FPageSetupDialogWidth) then
    Width := FPageSetupDialogWidth;
  if (Height <> FPageSetupDialogHeight) then
    Height := FPageSetupDialogHeight;
  Left := 0;
  Top := 0;
end;

procedure GetPrinter(var DeviceMode, DeviceNames: THandle);
var
  Device, Driver, Port: array[0..79] of char;
  DevNames: PDevNames;
  Offset: PChar;
  begin
  Printer.GetPrinter(Device, Driver, Port, DeviceMode);
  if DeviceMode <> 0 then
  begin
    DeviceNames := GlobalAlloc(GHND, SizeOf(TDevNames) +
      StrLen(Device) + StrLen(Driver) + StrLen(Port) + 3);
    DevNames := PDevNames(GlobalLock(DeviceNames));
    try
      Offset := PChar(DevNames) + SizeOf(TDevnames);
      with DevNames^ do
      begin
        wDriverOffset := TLMDPtrInt(Offset) - TLMDPtrInt(DevNames);
        Offset := StrECopy(Offset, Driver) + 1;
        wDeviceOffset := TLMDPtrInt(Offset) - TLMDPtrInt(DevNames);
        Offset := StrECopy(Offset, Device) + 1;
        wOutputOffset := TLMDPtrInt(Offset) - TLMDPtrInt(DevNames);

        StrCopy(Offset, Port);
      end;
    finally
      GlobalUnlock(DeviceNames);
    end;
    end;
end;

procedure SetPrinter(DeviceMode, DeviceNames: THandle);
var
  DevNames: PDevNames;
  begin
  DevNames := PDevNames(GlobalLock(DeviceNames));
  try
    with DevNames^ do
      Printer.SetPrinter(PChar(DevNames) + wDeviceOffset,
        PChar(DevNames) + wDriverOffset,
        PChar(DevNames) + wOutputOffset, DeviceMode);
  finally
    GlobalUnlock(DeviceNames);
    GlobalFree(DeviceNames);
  end;
  end;

function CopyData(Handle: THandle): THandle;
var
  Src, Dest: PChar;
  Size: Integer;
begin
  if Handle <> 0 then
  begin
    Size := GlobalSize(Handle);
    Result := GlobalAlloc(GHND, Size);
    if Result <> 0 then
    try
      Src := GlobalLock(Handle);
      Dest := GlobalLock(Result);
      if (Src <> nil) and (Dest <> nil) then
        Move(Src^, Dest^, Size);
      finally
      GlobalUnlock(Handle);
      GlobalUnlock(Result);
    end
  end
  else
    Result := 0;
end;

function TLMDFormPageSetupDialog.DoExecute(Func: TDialogFunc): boolean;
const
  PageSetupOptions: array[TLMDPageSetupOption] of DWORD = (
    PSD_DEFAULTMINMARGINS, PSD_DISABLEMARGINS, PSD_DISABLEORIENTATION,
    PSD_DISABLEPAGEPAINTING, PSD_DISABLEPAPER, PSD_DISABLEPRINTER,
    PSD_NOWARNING, PSD_SHOWHELP
    );
  PageSetupMeasurements: array[TLMDMeasurements] of DWORD = (
    PSD_INHUNDREDTHSOFMILLIMETERS, PSD_INTHOUSANDTHSOFINCHES
    );
var
  Option: TLMDPageSetupOption;
  PageSetup: TPageSetupDlg;
  DevHandle: THandle;
  OldPaperSize: TPoint;
  OldMargin, OldMinMargin: TRect;
  OldMeasurements: TLMDMeasurements;
begin
  PageSetupDialogTMP := Self;
  FForm := TForm(GetParentForm(Self));
  RescaleParent;
  FillChar(PageSetup, SizeOf(PageSetup), 0);
  with PageSetup do
  try
    lStructSize := SizeOf(TPageSetupDlg);
    hInstance := SysInit.HInstance;
    Flags := PSD_MARGINS;

    Flags := Flags or PSD_ENABLEPAGESETUPHOOK;
    lpfnPageSetupHook := PageSetupHook;

    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        Flags := Flags or PageSetupOptions[Option];
    Flags := Flags or PSD_ENABLEPAGEPAINTHOOK or
      PageSetupMeasurements[FMeasurements];
    lpfnPagePaintHook := PageSetupHook;
    if assigned(FOnPaintPage) then
    begin
      Flags := Flags or PSD_DISABLEPAGEPAINTING;
    end;

    hWndOwner := Application.Handle;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    HookCtl3D := Ctl3D;
    lCustData := 0;
    ptPaperSize := FPaperSize;
    rtMinMargin := FMinimumMargins;
    rtMargin := FMargins;

    OldPaperSize := FPaperSize;
    OldMargin := FMargins;
    OldMinMargin := FMinimumMargins;
    OldMeasurements := FMeasurements;

    Result := bool(TaskModalDialog(Func, PageSetup));
    if Result then
    begin
      FPaperSize := ptPaperSize;
      FMinimumMargins := rtMinMargin;
      FMargins := rtMargin;
      SetPrinter(hDevMode, hDevNames);
    end
    else
    begin
      FPaperSize := OldPaperSize;
      FMargins := OldMargin;
      FMinimumMargins := OldMinMargin;
      FMeasurements := OldMeasurements;
      if hDevMode <> 0 then
        GlobalFree(hDevMode);
      if hDevNames <> 0 then
        GlobalFree(hDevNames);
    end;
  finally
  end;
end;

function TLMDFormPageSetupDialog.Execute: boolean;
begin
  Result := DoExecute(@PageSetupDlg);
end;

procedure TLMDFormPageSetupDialog.RedrawPage;
var
  R: TRect;
begin
  R := Rect(Left, Top, Left + Width, Top + Height);
  LMDInvalidateRect(FHandle, R, FALSE);
end;

function TLMDFormPageSetupDialog.Printer: boolean;
begin
  Result := true;
  if Assigned(FOnPrinter) then
    FOnPrinter(Self, Result);
end;

function TLMDFormPageSetupDialog.DoPrinter: boolean;
begin
  try
    Result := Printer;
  except
    Result := FALSE;
    Application.HandleException(Self);
  end;
end;

{******************* TPrinterSetupDialog ***********************}

procedure TLMDFormPrinterSetupDialog.ValidateBounds;
begin
  if (Width <> FPrinterSetupDialogWidth) then
    Width := FPrinterSetupDialogWidth;
  if (Height <> FPrinterSetupDialogHeight) then
    Height := FPrinterSetupDialogHeight;
  Left := 0;
  Top := 0;
end;

procedure TLMDFormPrinterSetupDialog.DoShow;
begin
  FDialogHandle := FHandle;
  inherited;
  CenterWindow(FDialogHandle);
end;

constructor TLMDFormPrinterSetupDialog.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width := FPageSetupDialogWidth;
  Self.Height := FPageSetupDialogHeight;
  FDesignBMPName := 'TLMDFORMPRINTERSETUPDIALOG.DESIGN.BITMAP';
end;

function TLMDFormPrinterSetupDialog.Execute: Boolean;
var
  PrintDlgRec: TPrintDlg;
  DevHandle: THandle;
begin
  FForm := TForm(GetParentForm(Self));
  RescaleParent;
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  with PrintDlgRec do
  begin
    lStructSize := SizeOf(PrintDlgRec);
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PD_ENABLESETUPHOOK or PD_PRINTSETUP;
    HookCtl3D := Ctl3D;
    lpfnSetupHook := DialogHook;
    hWndOwner := Application.Handle;
    Result := bool(TaskModalDialog(@PrintDlg, PrintDlgRec));
    if Result then
      SetPrinter(hDevMode, hDevNames)
    else
    begin
      if hDevMode <> 0 then
        GlobalFree(hDevMode);
      if hDevNames <> 0 then
        GlobalFree(hDevNames);
    end;
  end;
end;

{************* TFormPrintCommDialog ************************}

procedure TLMDFormPrintCommDialog.ValidateBounds;
begin
  if (Width <> FPrintDialogWidth) then
    Width := FPrintDialogWidth;
  if (Height <> FPrintDialogHeight) then
    Height := FPrintDialogHeight;
  Left := 0;
  Top := 0;
end;

procedure TLMDFormPrintCommDialog.DoShow;
begin
  FDialogHandle := FHandle;
  inherited;
  CenterWindow(FDialogHandle);
end;

constructor TLMDFormPrintCommDialog.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width := FPrintDialogWidth;
  Self.Height := FPrintDialogHeight;
  FDesignBMPName := 'TLMDFORMPrintCommDialog.DESIGN.BITMAP';
end;

procedure TLMDFormPrintCommDialog.SetNumCopies(Value: Integer);
begin
  FCopies := Value;
  Printer.Copies := Value;
end;

function TLMDFormPrintCommDialog.Execute: Boolean;
const
  PrintRanges: array[TLMDPrintRange] of Integer =
  (PD_ALLPAGES, PD_SELECTION, PD_PAGENUMS);
var
  PrintDlgRec: TPrintDlg;
  DevHandle: THandle;
begin
  FForm := TForm(GetParentForm(Self));
  RescaleParent;
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  with PrintDlgRec do
  begin
    lStructSize := SizeOf(PrintDlgRec);
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PrintRanges[FPrintRange] or (PD_ENABLEPRINTHOOK or
      PD_ENABLESETUPHOOK);
    if FCollate then
      Inc(Flags, PD_COLLATE);
    if not (poPrintToFile in FOptions) then
      Inc(Flags, PD_HIDEPRINTTOFILE);
    if not (poPageNums in FOptions) then
      Inc(Flags, PD_NOPAGENUMS);
    if not (poSelection in FOptions) then
      Inc(Flags, PD_NOSELECTION);
    if poDisablePrintToFile in FOptions then
      Inc(Flags, PD_DISABLEPRINTTOFILE);
    if FPrintToFile then
      Inc(Flags, PD_PRINTTOFILE);
    if poHelp in FOptions then
      Inc(Flags, PD_SHOWHELP);
    if not (poWarning in FOptions) then
      Inc(Flags, PD_NOWARNING);
    nFromPage := FFromPage;
    nToPage := FToPage;
    nMinPage := FMinPage;
    nMaxPage := FMaxPage;
    HookCtl3D := Ctl3D;
    lpfnPrintHook := DialogHook;
    lpfnSetupHook := DialogHook;
    hWndOwner := Application.Handle;
    Result := bool(TaskModalDialog(@PrintDlg, PrintDlgRec));
    if Result then
    begin
      SetPrinter(hDevMode, hDevNames);
      FCollate := Flags and PD_COLLATE <> 0;
      FPrintToFile := Flags and PD_PRINTTOFILE <> 0;
      if Flags and PD_SELECTION <> 0 then
        FPrintRange := prSelection
      else
        if Flags and PD_PAGENUMS <> 0 then
          FPrintRange := prPageNums
        else
          FPrintRange := prAllPages;
      FFromPage := nFromPage;
      FToPage := nToPage;
      if nCopies = 1 then
        Copies := Printer.Copies
      else
        Copies := nCopies;
    end
    else
    begin
      if hDevMode <> 0 then
        GlobalFree(hDevMode);
      if hDevNames <> 0 then
        GlobalFree(hDevNames);
    end;
  end;
end;

//**************************  TFormFolderDialog *********************
const
  WM_UPDATEBOUNDS: Integer = WM_USER;

procedure FreeIDList(var PIDL: PItemIDList);
begin
  CoTaskMemFree(PIDL);
  PIDL := nil
end;

function GetPathFromIDList(const ItemIDList: PItemIDList; var Path: string): boolean;

begin
  SetLength(Path, MAX_PATH);
  Result := SHGetPathFromIDList(ItemIDList, PChar(Path));
  if Result then
    SetLength(Path, Strlen(PChar(Path)));
  if not Result then
    Path := '';
end;

const
  ID_BFF_TREEVIEW = $3741;

function CBBrowseForFolder(Wnd: HWND; Msg: UINT;
  wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  p: Pointer;
begin
  Result := 0;
  DialogHook(Wnd, Msg, WParam, LParam);
  case Msg of
    BFFM_INITIALIZED:
    begin
      DialogHook(Wnd, WM_INITDIALOG, wParam, lParam);
      CenterWindow(Wnd);
      ShowWindow(Wnd, SW_SHOW);
    end;
    BFFM_SELCHANGED:
    begin
      p := Pointer(GetProp(Wnd, StrCommonDialogOldProc));
      if p = nil then
        Exit;
      TLMDFormFolderDialog(p).BFFMSelChanged(wParam);
    end;
  end;
end;

procedure TLMDFormFolderDialog.ValidateBounds;
begin
  if (Width <> FFolderDialogWidth) then
    Width := FFolderDialogWidth;
  if (Height <> FFolderDialogHeight) then
    Height := FFolderDialogHeight;
end;

procedure TLMDFormFolderDialog.ReplaceSelection(PIDL: PItemIDList);
begin
  FSelectionIDList := PIDL;
  FSelectionPath := '';
  if Assigned(PIDL) then
    GetPathFromIDList(FSelectionIDList, FSelectionPath);
end;

function TLMDFormFolderDialog.Execute: Boolean;
const
  BROWSE_FLAG_MAP: array[TLMDFormFolderDialogOption] of Integer =
  (BIF_RETURNONLYFSDIRS, BIF_DONTGOBELOWDOMAIN, BIF_STATUSTEXT,
    BIF_RETURNFSANCESTORS, BIF_BROWSEFORCOMPUTER, BIF_BROWSEFORPRINTER, 0);
var
  i: Integer;
  DispName: string;
  BrowseInfo: TBrowseInfo;
begin
  FForm := TForm(GetParentForm(Self));
  RescaleParent;
  FillChar(BrowseInfo, sizeof(BrowseInfo), 0);
  with BrowseInfo do
  begin
    hwndOwner := Application.Handle;

    DispName := '';
    SetLength(DispName, MAX_PATH);
    pszDisplayName := PChar(DispName);
    if length(FForm.Caption) <> 0 then
      lpszTitle := PChar(FTitle);
    for i := 0 to ord(bfBrowseForPrinter) do
      if TLMDFormFolderDialogOption(i) in FOptions then
        ulFlags := Integer(ulFlags) or
          BROWSE_FLAG_MAP[TLMDFormFolderDialogOption(i)];

    lpfn := @CBBrowseForFolder;
    lParam := Windows.LPARAM(Self);
    pidlRoot := FRootIDList;

    FreeIDList(FSelectionIDList);
    FSelectionPath := '';
    ReplaceSelection(PItemIDList(TaskModalDialog(@SHBrowseForFolder, BrowseInfo)));
    Result := FSelectionIDList <> nil;
    if Result then
    begin
      FImageIndex := iImage;
      SetLength(DispName, StrLen(PChar(DispName)));
      FDisplayName := DispName;
      FDirectory := SelectionPath;
    end;
    end; // with BrowseInfo
end;

procedure TLMDFormFolderDialog.SetSelectionPath(Value: string);
begin
  Perform(BFFM_SETSELECTION, WPARAM(TRUE), LPARAM(PChar(Value)));
end;

procedure TLMDFormFolderDialog.DoShow;
begin
  FDialogHandle := FHandle;
  inherited;
end;

procedure TLMDFormFolderDialog.WndProc(var Message: TMessage);
begin
  inherited;
end;

constructor TLMDFormFolderDialog.Create(AOwner: TComponent);
begin
  inherited;
  Width := FFolderDialogWidth;
  Height := FFolderDialogHeight;
  WM_UPDATEBOUNDS := RegisterWindowMessage('DS.UPDATE.BOUND');
  RootFolder := sfoDesktopExpanded;
  FOptions := [bfFileSysDirsOnly, bfStatusText, bfShowPathInStatusArea];

  FRootIDList := nil;
  FSelectionIDList := nil;
  FDirectory := '';
  FSelectionPath := '';
  FImageIndex := -1;
  FDisplayName := '';
  FStatusText := '';
  FTitle := '';
  FDesignBMPName := 'TLMDFORMFOLDERDIALOG.DESIGN.BITMAP';
end;

procedure TLMDFormFolderDialog.SetRootFolder(Value: TLMDFormShellFolder);
const
  SH_FOLDERS_MAP: array[TLMDFormShellFolder] of Integer =
  (-1 {foDesktopExpanded}, CSIDL_DESKTOP,
    CSIDL_PROGRAMS, CSIDL_CONTROLS, CSIDL_PRINTERS, CSIDL_PERSONAL,
    CSIDL_FAVORITES,
    CSIDL_STARTUP, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_BITBUCKET, CSIDL_STARTMENU,
    CSIDL_DESKTOPDIRECTORY, CSIDL_DRIVES, CSIDL_NETWORK, CSIDL_NETHOOD,
    CSIDL_FONTS,
    CSIDL_TEMPLATES,
    CSIDL_COMMON_STARTMENU, CSIDL_COMMON_PROGRAMS, CSIDL_COMMON_STARTUP,
    CSIDL_COMMON_DESKTOPDIRECTORY, CSIDL_APPDATA, CSIDL_PRINTHOOD);
var
  Folder: Integer;
begin
  FreeIDList(FSelectionIDList);
  FreeIDList(FRootIDList);
  FRootFolder := Value;
  Folder := SH_FOLDERS_MAP[FRootFolder];
  if Folder <> -1 then
    if SHGetSpecialFolderLocation(Application.Handle, Folder, FRootIDList) <> 0 then
      FRootIDList := nil;
end;

procedure TLMDFormFolderDialog.SetSelectionPIDL(Value: PItemIDList);
begin
  Perform(BFFM_SETSELECTION, WPARAM(FALSE), LPARAM(Value));
end;

procedure TLMDFormFolderDialog.EnableOK(const Value: Boolean);
begin
  Perform(BFFM_ENABLEOK, 0, LPARAM(Value));
end;

procedure TLMDFormFolderDialog.SetOptions(Value: TLMDFormFolderDialogOptions);
var
  NV: TLMDFormFolderDialogOptions;
begin
  NV := Value;
  if (bfBrowseForComputer in NV) and not (bfBrowseForComputer in FOptions) then
  begin
    RootFolder := sfoNetwork;
    NV := NV - [bfFileSysDirsOnly, bfFileSysAncestors, bfBrowseForPrinter]
  end
  else
    if (bfBrowseForPrinter in NV) and not (bfBrowseForPrinter in FOptions) then
      NV := NV - [bfFileSysDirsOnly, bfFileSysAncestors,
        bfBrowseForComputer, bfDontGoBelowDomain];
  FOptions := NV;
  if bfShowPathInStatusArea in FOptions then
    Include(FOptions, bfStatusText);
end;

function TLMDFormFolderDialog.GetDirectory: string;
begin
  if FHandle <> 0 then
    Result := FSelectionPath
  else
    Result := FDirectory;
end;

procedure TLMDFormFolderDialog.SetDirectory(Value: string);
begin
  if FHandle <> 0 then
    SetSelectionPath(Value)
  else
    FDirectory := Value
end;

procedure TLMDFormFolderDialog.BFFMInitialized(Param: WPARAM);
begin
  SelectionPath := FDirectory;
end;

procedure TLMDFormFolderDialog.BFFMSelChanged(Param: WPARAM);
var
  ValidPath: Boolean;
begin
  ReplaceSelection(PItemIDList(Param));
  ValidPath := Length(FSelectionPath) <> 0;
  if bfFileSysDirsOnly in FOptions then
    EnableOK(ValidPath);
  if ValidPath then
  begin
    if bfShowPathInStatusArea in FOptions then
      SetStatusText(FSelectionPath);
    if Assigned(FOnChange) then
    try
      FOnChange(Self)
    except
    end;
  end
  else if [bfFileSysDirsOnly, bfShowPathInStatusArea] * FOptions <> [] then
  begin
    Perform(BFFM_SETSTATUSTEXT, 0, LPARAM(PChar(FSelectionPath)));
  end;
end;

procedure TLMDFormFolderDialog.SetStatusText(const Value: string);
begin
  FStatusText := Value;
  if FHandle <> 0 then
    Perform(BFFM_SETSTATUSTEXT, 0, LPARAM(PChar(Value)));
end;

const
  ID_BFF_TITLE = $3742;

procedure TLMDFormFolderDialog.SetTitle(Value: string);
begin
  FTitle := Value;
  if FHandle <> 0 then
    SendMessage(GetDlgItem(FHandle, ID_BFF_TITLE),
                WM_SETTEXT, 0, LPARAM(PChar(Value)));
end;

//*********************  TLMDFormOLEDialog **********************

procedure TLMDFormOLEDialog.DoShow;
begin
  FDialogHandle := FHandle;
  inherited;
  CenterWindow(FDialogHandle);
end;

function TLMDFormOLEDialog.ErrorCodeAsStr: string;
begin
  Result := '';
  case FErrorCode of
    OLEUI_FALSE: Result := 'Unknown failure.';
    OLEUI_OK: Result := 'The user pressed the OK button.';
    OLEUI_CANCEL: Result := 'The user pressed the Cancel button.';
    OLEUI_ERR_STRUCTURENULL: Result :=
      'The pointer to an OLEUIXXX structure passed into the function was NULL.';
    OLEUI_ERR_STRUCTUREINVALID: Result :=
      'Insufficient permissions for read or write access to an OLEUIXXX structure.';
    OLEUI_ERR_CBSTRUCTINCORRECT: Result := 'The cbstruct value is incorrect.';
    OLEUI_ERR_HWNDOWNERINVALID: Result := 'The hWndOwner value is invalid.';
    OLEUI_ERR_LPSZCAPTIONINVALID: Result := 'The lpszCaption value is invalid.';
    OLEUI_ERR_LPFNHOOKINVALID: Result := 'The lpfnHook value is invalid.';
    OLEUI_ERR_HINSTANCEINVALID: Result := 'The hInstance value is invalid.';
    OLEUI_ERR_LPSZTEMPLATEINVALID: Result :=
      'The lpszTemplate value is invalid.';
    OLEUI_ERR_HRESOURCEINVALID: Result := 'The hResource value is invalid.';
    OLEUI_ERR_FINDTEMPLATEFAILURE: Result :=
      'Unable to find the dialog template.';
    OLEUI_ERR_LOADTEMPLATEFAILURE: Result :=
      'Unable to load the dialog template.';
    OLEUI_ERR_DIALOGFAILURE: Result := 'Dialog initialization failed.';
    OLEUI_ERR_LOCALMEMALLOC: Result :=
      'A call to LocalAlloc or the standard IMalloc allocator failed.';
    OLEUI_ERR_GLOBALMEMALLOC: Result :=
      'A call to GlobalAlloc or the standard IMalloc allocator failed.';
    OLEUI_ERR_LOADSTRING: Result :=
      'Unable to LoadString localized resources from the library.';
    OLEUI_ERR_OLEMEMALLOC: Result :=
      'A call to the standard IMalloc allocator failed.';
  end;
end;
//*********************  TFormChangeIconDialog **********************

constructor TLMDFormChangeIconDialog.Create(AOwner: TComponent);
begin
  inherited;
  FSelection := cisCurrent;
  FShowHelp := true;
  FUseIconEXE := false;
  FMetafile := TMetafile.Create;
  FillChar(FClsID, SizeOf(FClsID), 0);
  FEXEName := '';
  Width := FChangeIconDialogWidth;
  Height := FChangeIconDialogHeight;
  FDesignBMPName := 'TLMDFORMChangeIconDialog.DESIGN.BITMAP';
  FErrorCode := OLEUI_SUCCESS;
end;

destructor TLMDFormChangeIconDialog.Destroy;
begin
  FMetafile.Free;
  inherited;
end;

procedure TLMDFormChangeIconDialog.DoShow;
begin
  inherited;
  //A workaround. Does anybody know why dialog shows garbage without this line?
  SendMessage(GetDlgItem(FDialogHandle, IDC_CI_FROMFILEEDIT), WM_SETTEXT, 0,
              LPARAM(PChar(FEXEName)));
end;

function TLMDFormChangeIconDialog.ErrorCodeAsStr: string;
begin
  Result := inherited ErrorCodeAsStr;
  if Result = '' then
    case FErrorCode of
      OLEUI_CIERR_MUSTHAVECLSID: Result :=
        'The clsid member was not the current CLSID.';
      OLEUI_CIERR_MUSTHAVECURRENTMETAFILE: Result :=
        'The hMetaPict member was not the current metafile.';
      OLEUI_CIERR_SZICONEXEINVALID: Result :=
        'The szIconExe value was invalid.';
    end;
end;

function TLMDFormChangeIconDialog.Execute: Boolean;
var
  Struct: TOLEUIChangeIcon;
  BufSize: Integer;
  Buffer: Pointer;
  pMF: ^TMetaFilePict;
  MetaFilePict: TMetaFilePict;
  H: THandle;
begin
  FForm := TForm(GetParentForm(Self));
  RescaleParent;
  FillChar(Struct, SizeOf(Struct), 0);
  with Struct do
  begin
    cbStruct := SizeOf(Struct);
    if FShowHelp then
      dwFlags := CIF_SHOWHELP;
    if FUseIconEXE then
      dwFlags := dwFlags or CIF_USEICONEXE;
    case FSelection of
      cisDefault: dwFlags := dwFlags or CIF_SELECTDEFAULT;
      cisCurrent: dwFlags := dwFlags or CIF_SELECTCURRENT;
      cisFromFile: dwFlags := dwFlags or CIF_SELECTFROMFILE;
    end;
    lpfnHook := @DialogHook;
    hWndOwner := Application.Handle;
    if FForm.Caption = '' then
      lpszCaption := ' ' //don't use "Change icon" if caption is nil
    else
      lpszCaption := PChar(FForm.Caption); // PChar
    hMetaPict := FMetafile.Handle;
    clsId := FClsID;
    //FEXEName:='c:\demo.exe';
    if length(FEXEName) > 0 then
      Move(FEXEName[1], szIconExe, length(FEXEName));
    cchIconExe := length(FEXEName);
    FErrorCode := TaskModalDialog(@OLEUIChangeIcon, Struct);
    Result := FErrorCode = OLEUI_OK;
    if (dwFlags and CIF_SELECTDEFAULT) <> 0 then
      FSelection := cisDefault
    else
      if (dwFlags and CIF_SELECTCURRENT) <> 0 then
        FSelection := cisCurrent
      else
        if (dwFlags and CIF_SELECTFROMFILE) <> 0 then
          FSelection := cisFromFile;
    if hMetaPict <> 0 then
    begin
      pMF := GlobalLock(hMetaPict);
      if (pMF <> nil) and (pMF^.hMF <> 0) then
      begin
        BufSize := GetMetaFileBitsEx(pMF^.hMF, 0, nil);
        GetMem(Buffer, BufSize);
        GetMetaFileBitsEx(pMF^.hMF, BufSize, Buffer);
        with MetaFilePict do
        begin
          mm := pMF^.mm;
          xExt := pMF^.xExt;
          yExt := pMF^.yExt;
        end;
        H := SetWinMetaFileBits(BufSize, Buffer, 0, MetaFilePict);
        FMetaFile.Handle := H;
        FreeMem(Buffer, BufSize);
        DeleteMetaFile(pMF^.hMF);
      end;
      GlobalUnlock(hMetaPict);
      GlobalFree(hMetaPict);
    end;
  end;
end;

procedure TLMDFormChangeIconDialog.ValidateBounds;
begin
  if (Width <> FChangeIconDialogWidth) then
    Width := FChangeIconDialogWidth;
  if (Height <> FChangeIconDialogHeight) then
    Height := FChangeIconDialogHeight;
  Left := 0;
  Top := 0;
end;

procedure TLMDFormChangeIconDialog.SetMetafile(const Value: TMetafile);
begin
  FMetafile.Assign(Value);
end;

//************************** TFormInsertObjectDialog **************************

constructor TLMDFormInsertObjectDialog.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := [iofShowHelp, iofVerifyServerExists, iofShowInsertControl];
  FSelected := iosCreateNew;
  FFileName := '';
  FExcludeList := TList.Create;
  FMetafile := TMetafile.Create;
  Width := FInsertObjectDialogWidth;
  Height := FInsertObjectDialogHeight;
  FDesignBMPName := 'TLMDFORMInsertObjectDialog.DESIGN.BITMAP';
  FErrorCode := OLEUI_SUCCESS;
end;

destructor TLMDFormInsertObjectDialog.Destroy;
begin
  FExcludeList.Free;
  FMetafile.Free;
  inherited;
end;

procedure TLMDFormInsertObjectDialog.ValidateBounds;
begin
  if (Width <> FInsertObjectDialogWidth) then
    Width := FInsertObjectDialogWidth;
  if (Height <> FInsertObjectDialogHeight) then
    Height := FInsertObjectDialogHeight;
  Left := 0;
  Top := 0;
end;

function TLMDFormInsertObjectDialog.ErrorCodeAsStr: string;
begin
  Result := inherited ErrorCodeAsStr;
  if Result = '' then
    case FErrorCode of
      OLEUI_IOERR_LPSZFILEINVALID: Result :=
        'The lpszFile value is invalid or user has insufficient write access permissions.';
      OLEUI_IOERR_LPFORMATETCINVALID: Result :=
        'The lpFormatEtc value is invalid. This member identifies the desired format.';
      OLEUI_IOERR_PPVOBJINVALID: Result := 'The ppvOjb value is invalid.';
      OLEUI_IOERR_LPIOLECLIENTSITEINVALID: Result :=
        'The lpIOleClientSite value is invalid.';
      OLEUI_IOERR_LPISTORAGEINVALID: Result :=
        'The lpIStorage value is invalid.';
      OLEUI_IOERR_SCODEHASERROR: Result :=
        'The sc member of lpIO has additional error information.';
      OLEUI_IOERR_LPCLSIDEXCLUDEINVALID: Result :=
        'The lpClsidExclude value is invalid.';
      OLEUI_IOERR_CCHFILEINVALID: Result :=
        'The cchFile or lpszFile value is invalid.';
    end;
end;

function TLMDFormInsertObjectDialog.Execute: Boolean;
type
  PCLSIDArray = ^TCLSIDArray;
  TCLSIDArray = array[0..$FFFFFFF div SizeOf(TCLSID)] of TCLSID;
const
  InsertOptions: array[TLMDInsertObjectOption] of DWORD = (
    IOF_SHOWHELP, IOF_CHECKLINK, IOF_CHECKDISPLAYASICON,
    IOF_CREATENEWOBJECT, IOF_CREATEFILEOBJECT,
    IOF_CREATELINKOBJECT, IOF_DISABLELINK,
    IOF_VERIFYSERVERSEXIST, IOF_DISABLEDISPLAYASICON,
    IOF_HIDECHANGEICON, IOF_SHOWINSERTCONTROL);
var
  Struct: TOLEUIINSERTOBJECT;
  Option: TLMDInsertObjectOption;
  i, l: Integer;
  BufSize: Integer;
  Buffer: Pointer;
  pMF: ^TMetaFilePict;
  MetaFilePict: TMetaFilePict;
  H: THandle;
begin
  FForm := TForm(GetParentForm(Self));
  RescaleParent;
  FillChar(Struct, SizeOf(Struct), 0);
  with Struct do
  begin
    cbStruct := SizeOf(Struct);
    if FSelected = iosCreateNew then
      dwFlags := IOF_SELECTCREATENEW
    else
      if FSelected = iosCreateFromFile then
        dwFlags := IOF_SELECTCREATEFROMFILE
      else
        if FSelected = iosCreateControl then
          dwFlags := IOF_SELECTCREATECONTROL;
    for Option := Low(Option) to High(Option) do
      if Option in FOptions then
        DWORD(dwFlags) := DWORD(dwFlags) or InsertOptions[Option];
    hwndOwner := Application.Handle;
    lpfnHook := @DialogHook;
    if FForm.Caption = '' then
      lpszCaption := ' ' //don't use "Change icon" if caption is nil
    else
      lpszCaption := PChar(FForm.Caption);
    l := length(FFileName);
    SetLength(FFileName, MAX_PATH);
    if l < MAX_PATH then
      FFileName[l + 1] := #0;
    lpszFile := PChar(FFileName);
    cchFile := MAX_PATH;
    cClsidExclude := FExcludeList.Count;
    if cClsidExclude > 0 then
    begin
      GetMem(lpClsidExclude, SizeOf(TCLSID) * cClsidExclude);
      FEXcludeList.Pack;
      for i := 0 to FExcludeList.Count - 1 do
        PCLSIDArray(lpClsidExclude)^[i] := TCLSID(FExcludeList[i]^);
    end;
    iid := FIID;
    oleRender := FOLERender;
    lpFormatEtc := @FFormatEtc;
    lpIOLEClientSite := FIOLEClientSite;
    lpIStorage := FIStorage;
    ppvObj := FObject;
    FErrorCode := TaskModalDialog(@OLEUIInsertObject, Struct);
    Result := FErrorCode = OLEUI_OK;
    if hMetaPict <> 0 then
    begin
      pMF := GlobalLock(hMetaPict);
      if (pMF <> nil) and (pMF^.hMF <> 0) then
      begin
        BufSize := GetMetaFileBitsEx(pMF^.hMF, 0, nil);
        GetMem(Buffer, BufSize);
        GetMetaFileBitsEx(pMF^.hMF, BufSize, Buffer);
        with MetaFilePict do
        begin
          mm := pMF^.mm;
          xExt := pMF^.xExt;
          yExt := pMF^.yExt;
        end;
        H := SetWinMetaFileBits(BufSize, Buffer, 0, MetaFilePict);
        FMetaFile.Handle := H;
        FreeMem(Buffer, BufSize);
        DeleteMetaFile(pMF^.hMF);
      end;
      GlobalUnlock(hMetaPict);
      GlobalFree(hMetaPict);
    end;
    if cClsidExclude > 0 then
      FreeMem(lpClsidExclude, SizeOf(TCLSID) * cClsidExclude);
  end;
end;

var
  BU, xbu, ybu: Integer;

initialization
  BU := GetDialogBaseUnits;
  xbu := BU and $FFFF;
  ybu := BU shr 16;
  BMPScaleX := xbu / 8;
  BMPScaleY := ybu / 16;
  if BMPScaleX > 1 then
    BMPScaleX := 1.09 * BMPScaleX
  else
    if BMPScaleX < 1 then
      BMPScaleX := 0.91 * BMPScaleX;
  FOpenDialogWidth := round(BMPScaleX * 410);
  FOpenDialogHeight := round(BMPScaleY * 280);
  FFontDialogWidth := round(BMPScaleX * 395);
  FFontDialogHeight := round(BMPScaleY * 319);
  FColorDialogWidth := round(BMPScaleX * 447);
  FColorDialogHeight := round(BMPScaleY * 299);
  FPrintDialogWidth := round(BMPScaleX * 432);
  FPrintDialogHeight := round(BMPScaleY * 302);
  FPrinterSetupDialogWidth := round(BMPScaleX * 432);
  FPrinterSetupDialogHeight := round(BMPScaleY * 289);
  FPageSetupDialogWidth := round(BMPScaleX * 360);
  FPageSetupDialogHeight := round(BMPScaleY * 390);
  FFolderDialogWidth := round(BMPScaleX * 318);
  FFolderDialogHeight := round(BMPScaleY * 306);
  FChangeIconDialogWidth := round(BMPScaleX * 386);
  FChangeIconDialogHeight := round(BMPScaleY * 249);
  FInsertObjectDialogWidth := round(BMPScaleX * 440);
  FInsertObjectDialogHeight := round(BMPScaleY * 244);

finalization

end.
