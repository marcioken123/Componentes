unit LMDPrinter;
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

LMDPrinter unit (RS)
-----------------------------------
Port of ElPrinter for shared printing support in LMD-2007

Notes
-----

Changes
-------
* Not released yet

###############################################################################}

interface

uses
  Windows, Printers, Graphics, Classes, SysUtils, Math, WinSpool, Dialogs,
  Types, Contnrs, ComCtrls, Forms,
  LMDCustomComponent, LMDTypes, LMDObject;

type
    //Exceptions for the higher-level PrintPack-related errors
    ELMDPrintPackError = class(Exception);

    TLMDPrinterBase = class;
    TLMDPrinter = class;

    //Helper class for TLMDPrinter etc.
    TLMDDoubleRect = record
      Left, Top, Right, Bottom: Double;
    end;

    {-------------------- TLMDPageMargins ---------------------------------------}
    TLMDPageMargins = class(TPersistent)
    private
      FLeft:    Double;
      FTop:     Double;
      FBottom:  Double;
      FRight:   Double;

      FPrinter: TLMDPrinterBase;

      function  GetAsRect: TLMDDoubleRect;
      procedure SetAsRect(AValue: TLMDDoubleRect);
      procedure CheckMarginsRect(AValue: TLMDDoubleRect);

      procedure Reset;

      function IsMarginBottomStored: Boolean;
      function IsMarginLeftStored: Boolean;
      function IsMarginRightStored: Boolean;
      function IsMarginTopStored: Boolean;

      procedure SetBottom(const Value: Double);
      procedure SetLeft(const Value: Double);
      procedure SetRight(const Value: Double);
      procedure SetTop(const Value: Double);

      procedure ReadMarginsZero(Reader: TReader);
      procedure WriteMarginsZero(Writer: TWriter);
    protected
      procedure DefineProperties(Filer: TFiler); override;

    public
      constructor Create(APrinter: TLMDPrinterBase);
      procedure   Assign(AValue: TPersistent); override;
      property    MarginRect: TLMDDoubleRect read GetAsRect write SetAsRect;
    published
      property Left:   Double read FLeft  write SetLeft
                              stored IsMarginLeftStored;
      property Right:  Double read FRight  write SetRight
                              stored IsMarginRightStored;
      property Top:    Double read FTop    write SetTop
                              stored IsMarginTopStored;
      property Bottom: Double read FBottom write SetBottom
                              stored IsMarginBottomStored;
    end;

    TLMDPageTemplateBlock = class(TPersistent)
    private
      FPrinter: TLMDPrinterBase;

      FVars: TLMDStrings;

      FFakeForm: TForm;
      FSaveRichEdit: TRichEdit;
      FRichEdit: TRichEdit;
      FVisible: Boolean;

      FTemplProxy: TStrings;

      procedure Reset;
      procedure SetTemplate(const ATemplate: TStrings);
      function  GetTemplate: TStrings;

      function PixToTwips(APix: Integer; AHoriz: Boolean): Integer;
      procedure ExpandTemplates;

      function CalkHeight(ACanvas: TCanvas;
                          AMaxRect: TRect): Integer;

      procedure DrawTo(ACanvas: TCanvas; ARect: TRect);
      procedure SetVisible(const Value: Boolean);
      procedure SetVars(const Value: TLMDStrings);

      property Variables: TLMDStrings read FVars write SetVars;
    public
      constructor Create(APrinter: TLMDPrinterBase);
      destructor Destroy; override;

      procedure Assign(AValue: TPersistent); override;
      procedure AssignLines(AValue: TStrings);
      procedure AssignLinesTo(AValue: TStrings);

      property  Printer: TLMDPrinterBase read FPrinter;
    published
      property Visible: Boolean read FVisible write SetVisible default True;
      property Template: TStrings read GetTemplate write SetTemplate;
    end;

    TLMDPrintOperationRange = (orSelection, orAll);

    TLMDPrintRendererBase = class
    public
      procedure PreparePages(APageWidth, APageHeight: Integer;
                             ACanvas: TCanvas); virtual; abstract;
      procedure FinalizePages; virtual; abstract;
      function  GetPagesCount(ARange: TLMDPrintOperationRange): Integer; virtual; abstract;
      procedure DrawPage(ARange: TLMDPrintOperationRange; ANum: Integer;
                         APoint: TPoint; ACanvas: TCanvas); virtual; abstract;
    end;

    TLMDPrinterInfo = record
      Orientation: TPrinterOrientation;
      PageWidthFullUnits:   Double;
      PageHeightFullUnits:  Double;

      MinMarginsUnits:  TLMDDoubleRect;

      PageWidthFullPixels:   Integer;
      PageHeightFullPixels:  Integer;

      MinMarginsPixels:  TRect;

      PixPerUnitX: Double;
      PixPerUnitY: Double;

      SystemUnits: TLMDMeasureUnits;
    end;

    TLMDPrinterChangeKind = (pcUnits, pcPrintableArea, pcPrinterSettings);
    TLMDPrinterChangeKinds = set of TLMDPrinterChangeKind;

    TLMDPrinterListener = class
    public
      procedure Refresh(AChanges: TLMDPrinterChangeKinds); virtual; abstract;
    end;

    TLMDPrinterHelper = class
    protected
      procedure SetPageMargins(const AValue: TLMDDoubleRect); virtual; abstract;
      function  GetPageMargins: TLMDDoubleRect; virtual; abstract;
    public
      procedure AddListener(ALst: TLMDPrinterListener); virtual; abstract;
      procedure RemoveListener(ALst: TLMDPrinterListener); virtual; abstract;

      procedure ExecPrintSetupDlg;  virtual; abstract;
      procedure ExecPageSetupDlg;  virtual; abstract;
      procedure ExecPrintDlg;  virtual; abstract;

      function GetPrinter: TLMDPrinterBase; virtual; abstract;

      property Margins: TLMDDoubleRect  read GetPageMargins write SetPageMargins;

      procedure PrintPages(ARange: TLMDPrintOperationRange;
                           AStart, ACount: Integer); virtual; abstract;

      function GetPagesCount(ARange: TLMDPrintOperationRange): Integer; virtual;
                                                                     abstract;

      procedure DrawPage(ARange: TLMDPrintOperationRange; APage: Integer;
                         ACanvas: TCanvas; ARect: TRect); virtual; abstract;

      procedure SavePage(ARange: TLMDPrintOperationRange; APage: Integer;
                         AFileName: TLMDString); virtual; abstract;
    end;

    {******************* Object TLMDPrinter ***********************************}
    TLMDPrinterBase = class(TLMDCustomComponent)
    protected
      FSysPrinter:  TPrinter;
      FPrinterInfo:  TLMDPrinterInfo;

      FRealUnits: TLMDMeasureUnits;
      FUnits:     TLMDMeasureUnits;

      FTitle: TLMDString;
      // --

      FPrintableWidthUnits:  Double;
      FPrintableHeightUnits: Double;

      FPrintableWidthPixels:  Integer;
      FPrintableHeightPixels: Integer;

      FListeners:   Contnrs.TObjectList;
      // ---

      FChanges: TLMDPrinterChangeKinds;

      function  IsPrinterValid: Boolean;

      procedure CheckPrinterValid;
      procedure CheckActive;
      procedure CheckNotActive;
      procedure CheckUnits(AUnits: TLMDMeasureUnits);
      procedure CheckUpdating;
      procedure CheckNotUpdating;
      procedure RaiseNotImplemented;

      function  CalkRealUnits(AUnits, ASystemUnits: TLMDMeasureUnits): TLMDMeasureUnits;

      procedure SetUnits(const AValue: TLMDMeasureUnits);

      procedure SetTitle(const ATitle: TLMDString);

      function  GetMinMarginsPixels: TRect;
      function  GetMinMarginsUnits: TLMDDoubleRect;

      function GetOrientation: TPrinterOrientation;

      function  GetPixPerUnitX: Double;
      function  GetPixPerUnitY: Double;

      function  GetPrintInfoPixels(const AIndex: Integer): Integer;
      function  GetPrintInfoUnits(const AIndex: Integer): Double;

      function GetDefaultMarginRect: TLMDDoubleRect;

      procedure AddSettingsChanges(AChanges: TLMDPrinterChangeKinds);

      procedure FireSettingsChanged;
      procedure FireBeforePage;
      procedure FireAfterPage;

      //
      procedure UpdatePrinterInfo;
      procedure PrinterSettingsChanged(AChanges: TLMDPrinterChangeKinds);
      procedure RecalkPrintable;

      //Base class calls it when physical printer has been changed
      procedure ResetOnPrinterChanges(AChanges: TLMDPrinterChangeKinds); virtual;
      //Ancestor calls it when some of its parts has changed
      procedure PrintableSettingsChanged; virtual;
      function  GetPageMargins: TLMDDoubleRect; virtual;

    protected
      procedure Change; override;
    public
      constructor Create(AOwner :TComponent); override;
      destructor  Destroy; override;

      ///
      ///  Printer info
      ///
      // returns current units (e.g. in AutoMode)

      function  GetDefaultPrinterInfo(AUnits: TLMDMeasureUnits): TLMDPrinterInfo;
      function  GetPrinterInfo(AUnits: TLMDMeasureUnits): TLMDPrinterInfo;
      function  GetSysPrinter: TPrinter;

      property RealUnits:   TLMDMeasureUnits read FRealUnits;

      property PageWidthFullUnits:  Double index 0 read GetPrintInfoUnits;
      property PageHeightFullUnits: Double index 1 read GetPrintInfoUnits;

      property PageWidthPrintableUnits:  Double index 2 read GetPrintInfoUnits;
      property PageHeightPrintableUnits: Double index 3 read GetPrintInfoUnits;

      property MinMarginsUnits: TLMDDoubleRect read GetMinMarginsUnits;

      property PageWidthFullPixels:  Integer index 0 read GetPrintInfoPixels;
      property PageHeightFullPixels: Integer index 1 read GetPrintInfoPixels;

      property PageWidthPrintablePixels:  Integer index 2 read GetPrintInfoPixels;
      property PageHeightPrintablePixels: Integer index 3 read GetPrintInfoPixels;

      property MinMarginsPixels: TRect read GetMinMarginsPixels;

      property PixPerUnitX: Double read GetPixPerUnitX;
      property PixPerUnitY: Double read GetPixPerUnitY;

      property Orientation: TPrinterOrientation read GetOrientation;

      ///
      ///  Conversion
      ///

      function  UnitsToPixelsRect(ARect: TLMDDoubleRect): TRect;
      function  PixelsToUnitsRect(ARect: TRect): TLMDDoubleRect;

      function  UnitsToPixelsX(AUnits: Double): Integer;
      function  PixelsToUnitsX(APixels: Integer): Double;

      function  UnitsToPixelsY(AUnits: Double): Integer;
      function  PixelsToUnitsY(APixels: Integer): Double;

      function  UnitsToUnits(AWhatUnitsFrom, AWhatUnitsTo: TLMDMeasureUnits;
                             AUnits: Double): Double;

      function  UnitsToUnitsRect(AWhatUnitsFrom, AWhatUnitsTo: TLMDMeasureUnits;
                                 AUnits: TLMDDoubleRect): TLMDDoubleRect;

      ///
      /// Other
      ///
      procedure AddListener(ALst: TLMDPrinterListener);
      procedure RemoveListener(ALst: TLMDPrinterListener);

      ///
      ///  Low-level
      ///

      //Caller must free hDevMode and hDevNames after using those
      procedure SetPrinter(hDevMode: HGLOBAL; hDevNames: HGLOBAL);

      //Caller must free hDevMode and hDevNames after using those
      procedure GetPrinter(var hDevMode: HGLOBAL; var hDevNames: HGLOBAL);
    published
      property About;

      property Units:   TLMDMeasureUnits  read FUnits write SetUnits
                                          default unMillimeters;

      property Title: TLMDString read FTitle write SetTitle;

      property OnChange;
    end;

    TLMDPrinter = class(TLMDPrinterBase)
    private
      FPageMargins: TLMDPageMargins;
      FHeader:      TLMDPageTemplateBlock;
      FFooter:      TLMDPageTemplateBlock;

      FHelper:      TLMDPrinterHelper;

      FPagesPrepared: Boolean;
      FDocStarted: Boolean;
      FPagesCount: Integer;
      FSelectedPagesCount: Integer;
      FContentRect: TRect;
      FRenderer: TLMDPrintRendererBase;
      FMetafile: TMetafile;

      FCurrentPage: Integer;
      FHeadH, FFootH: Integer;
      FFrameRect: TRect;
      FOldUnits: TLMDMeasureUnits;

      FOldSysPrinter: TPrinter;

      procedure CheckPagesPrepared;
      procedure CheckPagesNotPrepared;
      procedure CheckDocStarted;
      procedure CheckDocFinished;
      procedure CheckPagesRange(AOpRange: TLMDPrintOperationRange;
                                AStart, ACount: Integer);

      procedure SetPageMargins(const AValue: TLMDPageMargins);
      procedure SetFooter(const AValue: TLMDPageTemplateBlock);
      procedure SetHeader(const AValue: TLMDPageTemplateBlock);
      procedure FillVars(ATemplate: TLMDPageTemplateBlock);
      procedure PreparePrintVars;
      procedure FreePrintVars;

    protected
      procedure ResetOnPrinterChanges(AChanges: TLMDPrinterChangeKinds); override;
      procedure PrintableSettingsChanged; override;

      function  GetPageMargins: TLMDDoubleRect; override;
    public
      constructor Create(AOwner :TComponent); override;
      destructor  Destroy; override;

      ////
      procedure PreparePages(ARenderer: TLMDPrintRendererBase);
      procedure FinalizePages;

      procedure BeginDoc;
      procedure EndDoc;

      procedure PrintPages(ARange: TLMDPrintOperationRange;
                           AStart, ACount: Integer);

      ////
      function  GetPagesCount(ARange: TLMDPrintOperationRange): Integer;
      procedure DrawPage(ARange: TLMDPrintOperationRange; APage: Integer;
                         ACanvas: TCanvas; ARect: TRect);
      procedure SavePage(ARange: TLMDPrintOperationRange; APage: Integer;
                         AFileName: TLMDString);

      ///
      /// dialogs
      ///
      procedure ExecPreviewDlg;
      function  ExecPrintSetupDlg: Boolean;
      function  ExecPageSetupDlg: Boolean;
      function  ExecPrintDlg: Boolean;

      property PrinterHelper: TLMDPrinterHelper read FHelper;
    published
      property Margins: TLMDPageMargins   read FPageMargins write SetPageMargins;

      property Header:  TLMDPageTemplateBlock read FHeader write SetHeader;

      property Footer:  TLMDPageTemplateBlock read FFooter write SetFooter;
    end;

    function LMDPrintIsMetricLocale: Boolean;

    procedure LMDPrintCheckMarginsRect(AMargins: TLMDDoubleRect;
                                       APrinter: TLMDPrinterBase);

function LMDDoubleRect(ALeft, ARight, ATop, ABottom: Double): TLMDDoubleRect;
implementation
uses
  CommDlg,
  LMDProcs,
  LMDPrintPreviewDlg, LMDPrintPageDialog, LMDPrintConst, RichEdit,
  LMDStrings, LMDStringList, LMDConversion,
  LMDUnicodeStrings;

  {$R LMDPrintPack.res}

const DefaultMarginMM = 20;
var DefaultMarginInch: Double;

type

TPrinterHelper = class(TLMDPrinterHelper)
private
  FPrinter: TLMDPrinter;
protected
  procedure SetPageMargins(const AValue: TLMDDoubleRect); override;
  function  GetPageMargins: TLMDDoubleRect; override;
public
  constructor Create(APrinter: TLMDPrinter);

  procedure AddListener(ALst: TLMDPrinterListener); override;
  procedure RemoveListener(ALst: TLMDPrinterListener); override;

  procedure ExecPrintSetupDlg;  override;
  procedure ExecPageSetupDlg;  override;
  procedure ExecPrintDlg;  override;

  function GetPrinter: TLMDPrinterBase; override;

  procedure PrintPages(ARange: TLMDPrintOperationRange;
                       AStart, ACount: Integer); override;

  function GetPagesCount(ARange: TLMDPrintOperationRange): Integer; override;

  procedure DrawPage(ARange: TLMDPrintOperationRange; APage: Integer;
                     ACanvas: TCanvas; ARect: TRect); override;

  procedure SavePage(ARange: TLMDPrintOperationRange; APage: Integer;
                     AFileName: TLMDString); override;
end;

type
  TStringsAccess    = class(TStrings);

TTemplStringsProxy = class(TStrings)
private
  FOrigin: TStrings;

  procedure LoadData(Stream: TStream);
  procedure SaveData(Stream: TStream);
protected
  function  Get(Index: Integer): string; override;
  procedure Put(Index: Integer; const S: string); override;
  function  GetCount: Integer; override;
  function  GetObject(Index: Integer): TObject; override;
  procedure PutObject(Index: Integer; AObject: TObject); override;
  procedure SetUpdateState(Updating: Boolean); override;

  procedure DefineProperties(Filer: TFiler); override;

public
  constructor Create(AOrigin: TStrings);

  procedure Clear; override;
  procedure Delete(Index: Integer); override;
  procedure Insert(Index: Integer; const S: string); override;

  procedure LoadFromStream(Stream: TStream); override;
  procedure SaveToStream(Stream: TStream); override;
end;
{------------------------------------------------------------------------------}

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
    Result:= 0;
end;

{------------------------------------------------------------------------------}

function LMDPrintIsMetricLocale: Boolean;
var
  Buffer: Array[0..1] of Char;
  Res: Char;
begin
  if GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IMEASURE, Buffer, 2) > 0
  then
    Res := Buffer[0]
  else
    Res := '0';

  Result := Res = '0';
end;

{------------------------------------------------------------------------------}

procedure LMDPrintCheckMarginsRect(AMargins: TLMDDoubleRect;
                                   APrinter: TLMDPrinterBase);
var
    Bad: Boolean;
begin
  Bad := (AMargins.Left   < APrinter.MinMarginsUnits.Left)  or
         (AMargins.Right  < APrinter.MinMarginsUnits.Right) or
         (AMargins.Top    < APrinter.MinMarginsUnits.Top)   or
         (AMargins.Bottom < APrinter.MinMarginsUnits.Bottom);

  Bad := Bad or
         ((APrinter.PageWidthFullUnits  - AMargins.Right)  <= AMargins.Left )   or
         ((APrinter.PageWidthFullUnits  - AMargins.Left)   <= AMargins.Right )  or
         ((APrinter.PageHeightFullUnits - AMargins.Top)    <= AMargins.Bottom ) or
         ((APrinter.PageHeightFullUnits - AMargins.Bottom) <= AMargins.Top );

  if Bad then
    raise ELMDPrintPackError.Create(SLMDPrintBadMarginsValue);
end;
{------------------------------------------------------------------------------}

function LMDDoubleRect(ALeft, ARight, ATop, ABottom: Double): TLMDDoubleRect;
begin
  Result.Left   := ALeft;
  Result.Right  := ARight;
  Result.Top    := ATop;
  Result.Bottom := ABottom;
end;

procedure AssignRich(Rich1, Rich2: TStrings);
var
  st: TMemoryStream;
begin
  st := TMemoryStream.Create;
  try
    Rich2.SaveToStream(st);

    st.Position := 0;
    Rich1.LoadFromStream(st);
  finally
    st.Free;
  end;
end;

{ TLMDPageMargins }

procedure TLMDPageMargins.Assign(AValue: TPersistent);
begin
  if AValue=self then
    Exit;

  if AValue is TLMDPageMargins then
    SetAsRect(TLMDPageMargins(AValue).GetAsRect)
  else
    inherited;
end;

procedure TLMDPageMargins.CheckMarginsRect(AValue: TLMDDoubleRect);
begin
  LMDPrintCheckMarginsRect(AValue, FPrinter);
end;

constructor TLMDPageMargins.Create(APrinter: TLMDPrinterBase);
begin
  inherited Create;

  if APrinter=nil then
    raise ELMDPrintPackError.Create(SLMDPrintTryManualMarginsCreate);

  FPrinter := APrinter;

  Reset;
end;

procedure TLMDPageMargins.DefineProperties(Filer: TFiler);
var
    HasData: Boolean;
begin
  HasData := (FLeft=0) or (FRight=0) or (FTop=0) or (FBottom=0);

  Filer.DefineProperty('MarginsZero', ReadMarginsZero, WriteMarginsZero, HasData);
end;

function TLMDPageMargins.GetAsRect: TLMDDoubleRect;
begin
  Result.Left   := FLeft;
  Result.Right  := FRight;
  Result.Top    := FTop;
  Result.Bottom := FBottom;
end;

function TLMDPageMargins.IsMarginBottomStored: Boolean;
var
    R: TLMDDoubleRect;
begin
  R := FPrinter.GetDefaultMarginRect;

  Result := FBottom<>R.Bottom;
end;

function TLMDPageMargins.IsMarginLeftStored: Boolean;
var
    R: TLMDDoubleRect;
begin
  R := FPrinter.GetDefaultMarginRect;

  Result := FLeft<>R.Left;
end;

function TLMDPageMargins.IsMarginRightStored: Boolean;
var
    R: TLMDDoubleRect;
begin
  R := FPrinter.GetDefaultMarginRect;

  Result := FRight<>R.Right;
end;

function TLMDPageMargins.IsMarginTopStored: Boolean;
var
    R: TLMDDoubleRect;
begin
  R := FPrinter.GetDefaultMarginRect;

  Result := FTop<>R.Top;
end;

procedure TLMDPageMargins.ReadMarginsZero(Reader: TReader);
var
    s: string;
begin
  s := LowerCase(Reader.ReadString);

  if Pos('left', s)<>0 then
    FLeft := 0;

  if Pos('right', s)<>0 then
    FRight := 0;

  if Pos('top', s)<>0 then
    FTop := 0;

  if Pos('bottom', s)<>0 then
    FBottom := 0;
end;

procedure TLMDPageMargins.Reset;
var
    R: TLMDDoubleRect;
begin
  R := FPrinter.GetDefaultMarginRect;

  FLeft   := R.Left;
  FTop    := R.Top;
  FBottom := R.Bottom;
  FRight  := R.Right;
end;

procedure TLMDPageMargins.SetAsRect(AValue: TLMDDoubleRect);
begin
  AValue.Left := Max(AValue.Left, FPrinter.MinMarginsUnits.Left);
  AValue.Right := Max(AValue.Right, FPrinter.MinMarginsUnits.Right);
  AValue.Top := Max(AValue.Top, FPrinter.MinMarginsUnits.Top);
  AValue.Bottom := Max(AValue.Bottom, FPrinter.MinMarginsUnits.Bottom);

  CheckMarginsRect(AValue);

  FLeft   := AValue.Left;
  FRight  := AValue.Right;
  FTop    := AValue.Top;
  FBottom := AValue.Bottom;

  FPrinter.PrintableSettingsChanged;
end;

procedure TLMDPageMargins.SetBottom(const Value: Double);
begin
  SetAsRect(LMDDoubleRect(FLeft, FRight, FTop, Value));
end;

procedure TLMDPageMargins.SetLeft(const Value: Double);
begin
  SetAsRect(LMDDoubleRect(Value, FRight, FTop, FBottom));
end;

procedure TLMDPageMargins.SetRight(const Value: Double);
begin
  SetAsRect(LMDDoubleRect(FLeft, Value, FTop, FBottom));
end;

procedure TLMDPageMargins.SetTop(const Value: Double);
begin
  SetAsRect(LMDDoubleRect(FLeft, FRight, Value, FBottom));
end;

procedure TLMDPageMargins.WriteMarginsZero(Writer: TWriter);
var
    s: string;
begin
  s := '';

  if FLeft=0 then
    s := s + 'left';

  if FRight=0 then
  begin
    if s<>'' then
      s := s + ',right'
    else
      s := s + 'right';
  end;

  if FTop=0 then
  begin
    if s<>'' then
      s := s + ',top'
    else
      s := s + 'top';
  end;

  if FBottom=0 then
  begin
    if s<>'' then
      s := s + ',bottom'
    else
      s := s + 'bottom';
  end;

  s := '['+s+']';

  Writer.WriteString(s);
end;

{ TLMDPageTemplateBlock }

procedure TLMDPageTemplateBlock.Assign(AValue: TPersistent);
var
    Src: TLMDPageTemplateBlock;
begin
  if AValue is TLMDPageTemplateBlock then
  begin
    Src := TLMDPageTemplateBlock(AValue);

    AssignRich(FSaveRichEdit.Lines, Src.FSaveRichEdit.Lines);
    FVisible := TLMDPageTemplateBlock(AValue).FVisible;

    FPrinter.PrintableSettingsChanged;
  end
  else
    inherited;
end;

procedure TLMDPageTemplateBlock.AssignLines(AValue: TStrings);
begin
  if AValue<>FSaveRichEdit.Lines then
  begin
    AssignRich(FSaveRichEdit.Lines, AValue);

    FPrinter.PrintableSettingsChanged;
  end;
end;

procedure TLMDPageTemplateBlock.AssignLinesTo(AValue: TStrings);
begin
  if AValue<>FSaveRichEdit.Lines then
    AssignRich(AValue, FSaveRichEdit.Lines);
end;

function TLMDPageTemplateBlock.CalkHeight(ACanvas: TCanvas;
                                          AMaxRect: TRect): Integer;
var
    Range: TFormatRange;
    Units: Double;
begin
  if FVisible and (FSaveRichEdit.Lines.Text<>'') then
  begin
    ExpandTemplates;

    FillChar(Range, SizeOf(TFormatRange), 0);
    Range.hdc := ACanvas.Handle;
    Range.hdcTarget := Range.hdc;

    Range.rcPage := Rect(PixToTwips(AMaxRect.Left, true),
                         PixToTwips(AMaxRect.Top, false),
                         PixToTwips(AMaxRect.Right, true),
                         PixToTwips(AMaxRect.Bottom, false));

    Range.rc := Range.rcPage;

    Range.chrg.cpMin := 0;
    Range.chrg.cpMax := -1;

    FRichEdit.Perform(EM_FORMATRANGE, 0, LPARAM(@Range));
    Units := FPrinter.UnitsToUnits(unInches, FPrinter.RealUnits,
                                   (Range.rc.Bottom - Range.rc.Top) / 1440 );

    Result := FPrinter.UnitsToPixelsY(Units) +
              Round((AMaxRect.Bottom - AMaxRect.Top) / 200);

    FRichEdit.Perform(EM_FORMATRANGE, 0, 0);
  end
  else
    Result := 0;
end;

constructor TLMDPageTemplateBlock.Create(APrinter: TLMDPrinterBase);
begin
  inherited Create;

  if APrinter=nil then
    raise ELMDPrintPackError.Create(SLMDPrintTryManualMarginsCreate);
  FPrinter := APrinter;

  FFakeForm := TForm.Create(nil);
  FFakeForm.Visible := false;

  FRichEdit := TRichEdit.Create(FFakeForm);
  FRichEdit.Parent := FFakeForm;

  FSaveRichEdit := TRichEdit.Create(FFakeForm);
  FSaveRichEdit.Parent := FFakeForm;

  FTemplProxy := TTemplStringsProxy.Create(FSaveRichEdit.Lines);

  FVisible := true;

  FVars := TLMDMemoryStrings.Create;

  Reset;
end;

destructor TLMDPageTemplateBlock.Destroy;
begin
  FFakeForm.Free;
  FVars.Free;
  FTemplProxy.Free;

  inherited;
end;

procedure TLMDPageTemplateBlock.DrawTo(ACanvas: TCanvas; ARect: TRect);
var
    Range: TFormatRange;
begin
  if FVisible then
  begin
    ExpandTemplates;

    FillChar(Range, SizeOf(TFormatRange), 0);
    Range.hdc := ACanvas.Handle;
    Range.hdcTarget := Range.hdc;

    Range.rc := Rect(PixToTwips(ARect.Left, true),
                     PixToTwips(ARect.Top, false),
                     PixToTwips(ARect.Right, true),
                     PixToTwips(ARect.Bottom, false));

    Range.rcPage := Range.rc;

    Range.chrg.cpMin := 0;
    Range.chrg.cpMax := FRichEdit.GetTextLen;

    FRichEdit.Perform(EM_FORMATRANGE, 1, LPARAM(@Range));
    FRichEdit.Perform(EM_FORMATRANGE, 0, 0);
  end;
end;

procedure TLMDPageTemplateBlock.ExpandTemplates;

function GetStr: TLMDString;
var
    ms: TMemoryStream;
    lms: TLMDMemoryStrings;
begin
  ms := TMemoryStream.Create;
  try
    FSaveRichEdit.Lines.SaveToStream(ms);

    lms := TLMDMemoryStrings.Create;
    try
      ms.Position := 0;
      lms.LoadFromStream(ms);
      Result := lms.Text;
    finally
      lms.Free;
    end;
  finally
    ms.Free;
  end;
end;

procedure SetStr(const AStr: TLMDString);
var
    ms: TMemoryStream;
    lms: TLMDMemoryStrings;
begin
  ms := TMemoryStream.Create;
  try
    lms := TLMDMemoryStrings.Create;
    try
      lms.Text := AStr;
      lms.SaveToStream(ms);

      ms.Position := 0;
      FRichEdit.Lines.LoadFromStream(ms);
    finally
      lms.Free;
    end;
  finally
    ms.Free;
  end;
end;

var
    i: Integer;
    Rtf, Name, Val: TLMDString;
begin
  FRichEdit.Lines.Clear;
  Rtf := GetStr;

  for i:=0 to FVars.Count-1 do
  begin
    Name := FVars.Names[i];
    Val := LMDReplaceStr(FVars.Values[Name], '\', '\\');

    Rtf := LMDReplaceStr(Rtf, LMDUpperCase(Name), Val);
  end;

  SetStr(Rtf);
end;

function TLMDPageTemplateBlock.GetTemplate: TStrings;
begin
  Result := FTemplProxy;
end;

function TLMDPageTemplateBlock.PixToTwips(APix: Integer;
  AHoriz: Boolean): Integer;
var
    Units: Double;
begin
  if AHoriz then
    Units := FPrinter.PixelsToUnitsX(APix)
  else
    Units := FPrinter.PixelsToUnitsY(APix);

  Result := Round( FPrinter.UnitsToUnits(FPrinter.RealUnits,
                                         unInches, Units) * 1440);
end;

procedure TLMDPageTemplateBlock.Reset;
begin
end;

procedure TLMDPageTemplateBlock.SetTemplate(const ATemplate: TStrings);
begin
  if FTemplProxy<>ATemplate then
  begin
    AssignRich(FTemplProxy, ATemplate);

    FPrinter.PrintableSettingsChanged;
  end;
end;

procedure TLMDPrinterBase.AddListener(ALst: TLMDPrinterListener);
begin
  if FListeners.IndexOf(ALst)<>-1 then
    raise ELMDPrintPackError.Create(SLMDPrintDuplicateListener);

  FListeners.Add(ALst);
end;

procedure TLMDPrinterBase.AddSettingsChanges(AChanges: TLMDPrinterChangeKinds);
begin

end;

function TLMDPrinterBase.CalkRealUnits(AUnits, ASystemUnits: TLMDMeasureUnits): TLMDMeasureUnits;
begin
  CheckUnits(AUnits);

  if AUnits=unAuto then
    Result := ASystemUnits
  else
    Result := AUnits;
end;

procedure TLMDPrinterBase.Change;
begin
  if not IsUpdating then
  begin
    FireSettingsChanged;
    FChanges := [];

    inherited;
  end;
end;
procedure TLMDPrinterBase.CheckActive;
begin

end;

procedure TLMDPrinterBase.CheckNotActive;
begin

end;

procedure TLMDPrinterBase.CheckNotUpdating;
begin

end;

procedure TLMDPrinterBase.CheckPrinterValid;
begin
  if not IsPrinterValid then
     raise ELMDPrintPackError.Create(SLMDPrintInvalidSystemPrinter);
end;

procedure TLMDPrinterBase.CheckUnits(AUnits: TLMDMeasureUnits);
begin
  case AUnits of
    unInches, unMillimeters, unAuto: ;
  else
     raise ELMDPrintPackError.Create(SLMDPrintBadUnitsSyntem);
  end;
end;

procedure TLMDPrinterBase.CheckUpdating;
begin

end;

constructor TLMDPrinterBase.Create(AOwner: TComponent);
begin
  inherited;

  FUnits  := unMillimeters;
  FRealUnits := FUnits;

  FTitle := '';

  FListeners := Contnrs.TObjectList.Create(false);

  FSysPrinter := TPrinter.Create;

  FChanges := [];

  UpdatePrinterInfo;
end;

destructor TLMDPrinterBase.Destroy;
begin
  FListeners.Free;

  FSysPrinter.Free;

  inherited;
end;

procedure TLMDPrinterBase.FireAfterPage;
begin

end;

procedure TLMDPrinterBase.FireBeforePage;
begin

end;

procedure TLMDPrinterBase.FireSettingsChanged;
var
    i: Integer;
begin
  if IsUpdating then
    Exit;

  for i := 0 to FListeners.Count-1 do
    TLMDPrinterListener(FListeners[i]).Refresh(FChanges);
end;

function TLMDPrinterBase.GetDefaultPrinterInfo(AUnits: TLMDMeasureUnits): TLMDPrinterInfo;
function Units(MM: Integer): Double;
begin
  Result := UnitsToUnits(unMillimeters, AUnits, MM);
end;

begin
  CheckUnits(AUnits);

  Result.SystemUnits := unMillimeters;

  if AUnits=unAuto then
    AUnits := Result.SystemUnits;

  Result.Orientation := poPortrait;
  //A4: 210 x 297
  Result.PageWidthFullUnits  := Units(210);
  Result.PageHeightFullUnits := Units(297);

  Result.MinMarginsUnits.Left   := Units(20);
  Result.MinMarginsUnits.Right  := Units(20);
  Result.MinMarginsUnits.Top    := Units(10);
  Result.MinMarginsUnits.Bottom := Units(10);

  Result.PixPerUnitX := 300 / UnitsToUnits(unInches, AUnits, 1);
  Result.PixPerUnitY := 300 / UnitsToUnits(unInches, AUnits, 1);

  Result.PageWidthFullPixels := Round(Result.PageWidthFullUnits *
                                      Result.PixPerUnitX);

  Result.PageHeightFullPixels := Round(Result.PageWidthFullUnits *
                                       Result.PixPerUnitY);

  Result.MinMarginsPixels.Left   := Round(Result.MinMarginsUnits.Left *
                                          Result.PixPerUnitX);
  Result.MinMarginsPixels.Right  := Round(Result.MinMarginsUnits.Right *
                                          Result.PixPerUnitX);

  Result.MinMarginsPixels.Top    := Round(Result.MinMarginsUnits.Top *
                                          Result.PixPerUnitY);
  Result.MinMarginsPixels.Bottom := Round(Result.MinMarginsUnits.Bottom *
                                          Result.PixPerUnitY);
end;

function TLMDPrinterBase.GetMinMarginsPixels: TRect;
begin
  Result := FPrinterInfo.MinMarginsPixels;
end;

function TLMDPrinterBase.GetMinMarginsUnits: TLMDDoubleRect;
begin
  Result := FPrinterInfo.MinMarginsUnits;
end;

function TLMDPrinterBase.GetOrientation: TPrinterOrientation;
begin
  Result := FPrinterInfo.Orientation;
end;

function TLMDPrinterBase.GetPageMargins: TLMDDoubleRect;
begin
  Result := FPrinterInfo.MinMarginsUnits;
end;

function TLMDPrinterBase.GetPixPerUnitX: Double;
begin
  Result := FPrinterInfo.PixPerUnitX;
end;

function TLMDPrinterBase.GetPixPerUnitY: Double;
begin
  Result := FPrinterInfo.PixPerUnitY;
end;

function TLMDPrinterBase.GetPrinterInfo(AUnits: TLMDMeasureUnits): TLMDPrinterInfo;

const RoundF = 100.0;
var
    Res: TLMDPrinterInfo;

begin
  CheckUnits(AUnits);
  CheckPrinterValid;

  if LMDPrintIsMetricLocale then
    Res.SystemUnits := unMillimeters  // metric
  else
    Res.SystemUnits := unInches;  // U.S.

  if AUnits=unAuto then
    AUnits := Res.SystemUnits;

  Res.Orientation := FSysPrinter.Orientation;
  Res.PixPerUnitX := GetDeviceCaps(FSysPrinter.Handle, LogPixelsX);
  Res.PixPerUnitY := GetDeviceCaps(FSysPrinter.Handle, LogPixelsY);

  if AUnits = unMillimeters then
  begin
    Res.PixPerUnitX := Res.PixPerUnitX / MillimetersPerInch;
    Res.PixPerUnitY := Res.PixPerUnitY / MillimetersPerInch;
  end;

  Res.PageWidthFullPixels  := GetDeviceCaps(FSysPrinter.Handle, Windows.HORZRES);//pix
  Res.PageHeightFullPixels := GetDeviceCaps(FSysPrinter.Handle, Windows.VERTRES);

  Res.MinMarginsPixels.Left   := GetDeviceCaps(FSysPrinter.Handle, Windows.PhysicalOffsetX);
  Res.MinMarginsPixels.Top    := GetDeviceCaps(FSysPrinter.Handle, Windows.PhysicalOffsetY);

  Res.MinMarginsPixels.Right  := GetDeviceCaps(FSysPrinter.Handle,
                                               Windows.PHYSICALWIDTH) -
                                 Res.PageWidthFullPixels -
                                 Res.MinMarginsPixels.Left;

  Res.MinMarginsPixels.Bottom  := GetDeviceCaps(FSysPrinter.Handle,
                                                Windows.PHYSICALHEIGHT) -
                                  Res.PageHeightFullPixels -
                                  Res.MinMarginsPixels.Top;

  Res.MinMarginsPixels.Left := Max(0, Res.MinMarginsPixels.Left);
  Res.MinMarginsPixels.Right := Max(0, Res.MinMarginsPixels.Right);
  Res.MinMarginsPixels.Top := Max(0, Res.MinMarginsPixels.Top);
  Res.MinMarginsPixels.Bottom := Max(0, Res.MinMarginsPixels.Bottom);


  Res.PageWidthFullUnits := Round(RoundF * Res.PageWidthFullPixels /
                                  Res.PixPerUnitX) / RoundF;

  Res.PageHeightFullUnits := Round(RoundF * Res.PageHeightFullPixels /
                                   Res.PixPerUnitY) / RoundF;

  Res.MinMarginsUnits.Left := Round(RoundF * Res.MinMarginsPixels.Left /
                                    Res.PixPerUnitX) / RoundF;

  Res.MinMarginsUnits.Top := Round(RoundF * Res.MinMarginsPixels.Top /
                                   Res.PixPerUnitY) / RoundF;

  Res.MinMarginsUnits.Right := Round(RoundF * Res.MinMarginsPixels.Right /
                                     Res.PixPerUnitX) / RoundF;

  Res.MinMarginsUnits.Bottom := Round(RoundF * Res.MinMarginsPixels.Bottom /
                                      Res.PixPerUnitY) / RoundF;

  Result := Res;
end;

function TLMDPrinterBase.GetPrintInfoPixels(const AIndex: Integer): Integer;
begin
  Result := -1;

  case AIndex of
    0: Result := FPrinterInfo.PageWidthFullPixels;
    1: Result := FPrinterInfo.PageHeightFullPixels;
    2: Result := FPrintableWidthPixels;
    3: Result := FPrintableHeightPixels;
  else
    Assert(false);
  end;
end;

function TLMDPrinterBase.GetPrintInfoUnits(const AIndex: Integer): Double;
begin
  Result := -1;

  case AIndex of
    0: Result := FPrinterInfo.PageWidthFullUnits;
    1: Result := FPrinterInfo.PageHeightFullUnits;
    2: Result := FPrintableWidthUnits;
    3: Result := FPrintableHeightUnits;
  else
    Assert(false);
  end;
end;

function TLMDPrinterBase.GetSysPrinter: TPrinter;
begin
  Result := FSysPrinter;
end;

function TLMDPrinterBase.IsPrinterValid: Boolean;
begin
  Result := (FSysPrinter.Printers.Count > 0) and
            (FSysPrinter.PrinterIndex <> -1);

  if Result then
  begin
    try
      FSysPrinter.Copies;
      FSysPrinter.Orientation;
      FSysPrinter.Handle;
    except
      //Bad printer detected!
      //TLMDPrinterBase.IsPrinterValid will return false!
      on E: EPrinter do
        Result := false;
    end;
  end;
end;

function TLMDPrinterBase.PixelsToUnitsRect(ARect: TRect): TLMDDoubleRect;
begin
  Result.Left   := PixelsToUnitsX(ARect.Left);
  Result.Right  := PixelsToUnitsX(ARect.Right);
  Result.Top    := PixelsToUnitsY(ARect.Top);
  Result.Bottom := PixelsToUnitsY(ARect.Bottom);
end;

function TLMDPrinterBase.PixelsToUnitsX(APixels: Integer): Double;
begin
  Result := APixels / PixPerUnitX;
end;

function TLMDPrinterBase.PixelsToUnitsY(APixels: Integer): Double;
begin
  Result := APixels / PixPerUnitY;
end;

procedure TLMDPrinterBase.PrintableSettingsChanged;
begin
  RecalkPrintable;
  AddSettingsChanges([pcPrintableArea]);
  Change;
end;

procedure TLMDPrinterBase.RaiseNotImplemented;
begin
  raise ELMDPrintPackError.Create(SLMDPrintMethodNotImplemeted);
end;

procedure TLMDPrinterBase.RecalkPrintable;
var M: TLMDDoubleRect;
begin
  M := GetPageMargins;
  FPrintableWidthUnits  := FPrinterInfo.PageWidthFullUnits - M.Left - M.Right;
  FPrintableHeightUnits := FPrinterInfo.PageHeightFullUnits - M.Top - M.Bottom;

  FPrintableWidthPixels := UnitsToPixelsX(FPrintableWidthUnits);
  FPrintableHeightPixels := UnitsToPixelsX(FPrintableHeightUnits);
end;

procedure TLMDPrinterBase.RemoveListener(ALst: TLMDPrinterListener);
begin
  if FListeners.IndexOf(ALst)=-1 then
    raise ELMDPrintPackError.Create(SLMDPrintListenerNotFound);

  FListeners.Delete(FListeners.IndexOf(ALst));
end;

procedure TLMDPrinterBase.ResetOnPrinterChanges(AChanges: TLMDPrinterChangeKinds);
begin

end;

procedure TLMDPrinterBase.PrinterSettingsChanged(AChanges: TLMDPrinterChangeKinds);
begin
  BeginUpdate;

  try
    UpdatePrinterInfo;

    ResetOnPrinterChanges(AChanges);

    RecalkPrintable;

    AddSettingsChanges(AChanges);
  finally
    EndUpdate;
  end;
end;

function TLMDPrinterBase.GetDefaultMarginRect: TLMDDoubleRect;
var
    Def: Double;
begin
  Def := 0;

  case FRealUnits of
    unMillimeters: Def := DefaultMarginMM;
    unInches: Def := DefaultMarginInch;
  else
    Assert(false);
  end;

  Result := FPrinterInfo.MinMarginsUnits;

  if FPrinterInfo.PageWidthFullUnits > Def*4 then
  begin
    Result.Left := Def;
    Result.Right := Def;
  end;

  if FPrinterInfo.PageHeightFullUnits > Def*4 then
  begin
    Result.Top := Def;
    Result.Bottom := Def;
  end;
end;

procedure TLMDPrinterBase.GetPrinter(var hDevMode: HGLOBAL;
                                     var hDevNames: HGLOBAL);

var
  Device, Driver, Port: array[0..255] of char;
  DevNames: PDevNames;
  DevMode: THandle;
  DeviceNames: HGLOBAL;
  Offset: PChar;
  ChSz: Cardinal;
begin
  CheckPrinterValid;

  FSysPrinter.GetPrinter(Device, Driver, Port, DevMode);

  hDevNames := 0;
  hDevMode := 0;

  if DevMode <> 0 then
  begin
    ChSz := SizeOf(char);

    DeviceNames := GlobalAlloc(GHND, SizeOf(TDevNames) +
                                     (StrLen(Device) + 1 +
                                      StrLen(Driver) + 1 +
                                      StrLen(Port)   + 1)*ChSz);

    DevNames := PDevNames(GlobalLock(DeviceNames));

    try
      Offset := PChar(DevNames) + (SizeOf(TDevNames) div ChSz);

      with DevNames^ do
      begin
        wDriverOffset := Offset - PChar(DevNames);
        Offset := StrECopy(Offset, Driver) + 1;

        wDeviceOffset := Offset - PChar(DevNames);
        Offset := StrECopy(Offset, Device) + 1;

        wOutputOffset := Offset - PChar(DevNames);

        StrCopy(Offset, Port);

        wDefault := 0;
      end;
    finally
      GlobalUnlock(hDevNames);
    end;

    hDevMode := CopyData(DevMode);
    hDevNames := DeviceNames;
  end;
end;

procedure TLMDPrinterBase.SetPrinter(hDevMode: HGLOBAL; hDevNames: HGLOBAL);

var
  DevNames: PDevNames;
begin
  CheckPrinterValid;

  BeginUpdate;

  try
    DevNames := PDevNames(GlobalLock(hDevNames));
    try
      with DevNames^ do
        FSysPrinter.SetPrinter(PChar(DevNames) + wDeviceOffset,
                               PChar(DevNames) + wDriverOffset,
                               PChar(DevNames) + wOutputOffset,
                               CopyData(hDevMode));
    finally
      GlobalUnlock(hDevNames);
    end;

    PrinterSettingsChanged([pcPrintableArea, pcPrinterSettings]);
  finally
    EndUpdate;
  end;
end;

procedure TLMDPrinterBase.SetTitle(const ATitle: TLMDString);
begin
  if ATitle=FTitle then
    Exit;

  FTitle := ATitle;

  PrintableSettingsChanged;
end;

procedure TLMDPrinterBase.SetUnits(const AValue: TLMDMeasureUnits);
begin
  if AValue=FUnits then
    Exit;

  BeginUpdate;
  try
    CheckUnits(AValue);

    FUnits := AValue;
    FRealUnits := CalkRealUnits(FUnits, FPrinterInfo.SystemUnits);

    PrinterSettingsChanged([pcUnits]);
  finally
    EndUpdate;
  end;
end;

function TLMDPrinterBase.UnitsToPixelsRect(ARect: TLMDDoubleRect): TRect;
begin
  Result.Left   := UnitsToPixelsX(ARect.Left);
  Result.Right  := UnitsToPixelsX(ARect.Right);
  Result.Top    := UnitsToPixelsY(ARect.Top);
  Result.Bottom := UnitsToPixelsY(ARect.Bottom);
end;

function TLMDPrinterBase.UnitsToPixelsX(AUnits: Double): Integer;
begin
  Result := Round(AUnits * PixPerUnitX);
end;

function TLMDPrinterBase.UnitsToPixelsY(AUnits: Double): Integer;
begin
  Result := Round(AUnits * PixPerUnitY);
end;

function TLMDPrinterBase.UnitsToUnits(AWhatUnitsFrom,
  AWhatUnitsTo: TLMDMeasureUnits; AUnits: Double): Double;
var RealFrom, RealTo: TLMDMeasureUnits;
begin
  CheckUnits(AWhatUnitsFrom);
  CheckUnits(AWhatUnitsTo);

  RealFrom := CalkRealUnits(AWhatUnitsFrom, FPrinterInfo.SystemUnits);
  RealTo := CalkRealUnits(AWhatUnitsTo, FPrinterInfo.SystemUnits);

  if RealFrom=RealTo then
    Result := AUnits
  else if RealFrom=unMillimeters then
    Result := AUnits / MillimetersPerInch
  else
    Result := AUnits * MillimetersPerInch;
end;

function TLMDPrinterBase.UnitsToUnitsRect(AWhatUnitsFrom,
  AWhatUnitsTo: TLMDMeasureUnits; AUnits: TLMDDoubleRect): TLMDDoubleRect;
begin
  Result.Left   := UnitsToUnits(AWhatUnitsFrom, AWhatUnitsTo, AUnits.Left);
  Result.Right  := UnitsToUnits(AWhatUnitsFrom, AWhatUnitsTo, AUnits.Right);
  Result.Top    := UnitsToUnits(AWhatUnitsFrom, AWhatUnitsTo, AUnits.Top);
  Result.Bottom := UnitsToUnits(AWhatUnitsFrom, AWhatUnitsTo, AUnits.Bottom)
end;

procedure TLMDPrinterBase.UpdatePrinterInfo;
begin
  if IsPrinterValid then
    FPrinterInfo := GetPrinterInfo(FUnits)
  else
    FPrinterInfo := GetDefaultPrinterInfo(FUnits);

  FRealUnits := CalkRealUnits(FUnits, FPrinterInfo.SystemUnits);

  FPrintableWidthUnits  := -1;
  FPrintableHeightUnits := -1;

  FPrintableWidthPixels := -1;
  FPrintableHeightPixels := -1;
end;

procedure TLMDPageTemplateBlock.SetVars(const Value: TLMDStrings);
begin
  if Value<>FVars then
    FVars.Assign(Value);
end;

procedure TLMDPageTemplateBlock.SetVisible(const Value: Boolean);
begin
  FVisible := Value;

  FPrinter.PrintableSettingsChanged;
end;

{ TLMDPrinter }

procedure TLMDPrinter.CheckPagesNotPrepared;
begin
  if FPagesPrepared then
    raise ELMDPrintPackError.Create(SLMDPrintPrinterPagesNotFinalized);
end;

procedure TLMDPrinter.CheckPagesPrepared;
begin
  if not FPagesPrepared then
    raise ELMDPrintPackError.Create(SLMDPrintPrinterPagesNotPrepared);
end;

constructor TLMDPrinter.Create(AOwner: TComponent);
begin
  inherited;

  FOldSysPrinter := nil;
  FPageMargins := TLMDPageMargins.Create(self);
  FHeader      := TLMDPageTemplateBlock.Create(self);
  FFooter      := TLMDPageTemplateBlock.Create(self);

  FHelper := TPrinterHelper.Create(self);

  FMetafile := nil;

  FPagesPrepared := false;
  FDocStarted := false;

  FPagesCount := 0;
  FSelectedPagesCount := 0;

  FOldUnits := FRealUnits;
  RecalkPrintable;
end;

destructor TLMDPrinter.Destroy;
begin
  FHelper.Free;

  FPageMargins.Free;
  FHeader.Free;
  FFooter.Free;

  FMetafile.Free;

  inherited;
end;

procedure TLMDPrinter.DrawPage(ARange: TLMDPrintOperationRange; APage: Integer;
                               ACanvas: TCanvas; ARect: TRect);
var
    MetaCanvas: TMetafileCanvas;
    MR, ContRect: TRect;
begin
  CheckPrinterValid;
  CheckPagesPrepared;

  FMetafile.Clear;

  MetaCanvas := TMetafileCanvas.Create(FMetafile, FSysPrinter.Handle);
  try
    MetaCanvas.Font.PixelsPerInch := GetDeviceCaps(FSysPrinter.Handle, LOGPIXELSY);

    FCurrentPage := APage;
    FillVars(FHeader);
    FillVars(FFooter);

    MR := UnitsToPixelsRect(Margins.GetAsRect);

    MetaCanvas.Brush.Style := bsSolid;
    MetaCanvas.Brush.Color := clWhite;
    MetaCanvas.FillRect(Rect(0, 0,
                             PageWidthFullPixels,
                             PageHeightFullPixels));

    ContRect := Rect(FFrameRect.Left, FFrameRect.Top,
                     FFrameRect.Right, FFrameRect.Top + FHeadH);

    FHeader.DrawTo(MetaCanvas, ContRect);

    ContRect := Rect(FFrameRect.Left, FFrameRect.Top + FHeadH,
                     FFrameRect.Right, FFrameRect.Bottom - FFootH);

    FRenderer.DrawPage(ARange, APage, ContRect.TopLeft, MetaCanvas);

    ContRect := Rect(FFrameRect.Left, FFrameRect.Bottom - FFootH,
                     FFrameRect.Right, FFrameRect.Bottom);

    FFooter.DrawTo(MetaCanvas, ContRect);
  finally
    MetaCanvas.Free;
  end;

  ACanvas.StretchDraw(ARect, FMetafile);
end;

procedure TLMDPrinter.FinalizePages;
begin
  CheckPrinterValid;
  CheckPagesPrepared;

  FreePrintVars;

  FRenderer := nil;

  FPagesPrepared := false;
  Printers.SetPrinter(FOldSysPrinter);

  FOldSysPrinter := nil;
end;

procedure TLMDPrinter.FreePrintVars;
begin
  if FRenderer<>nil then
    FRenderer.FinalizePages;

  FreeAndNil(FMetafile);
  FPagesCount := 0;
  FSelectedPagesCount := 0;
end;

function TLMDPrinter.GetPageMargins: TLMDDoubleRect;
begin
  Result := FPageMargins.GetAsRect;
end;

function TLMDPrinter.GetPagesCount(ARange: TLMDPrintOperationRange): Integer;
begin
  CheckPrinterValid;
  CheckPagesPrepared;

  case ARange of
    orAll: Result := FPagesCount;
    orSelection: Result := FSelectedPagesCount;
  else
    Assert(false);
    Result := -1;
  end;
end;

procedure TLMDPrinter.PreparePages(ARenderer: TLMDPrintRendererBase);
begin
  CheckPrinterValid;
  CheckPagesNotPrepared;

  Assert(ARenderer<>nil);
  FRenderer := ARenderer;

  PreparePrintVars;

  FPagesPrepared := true;

  FOldSysPrinter := Printers.SetPrinter(FSysPrinter);
end;

procedure TLMDPrinter.PreparePrintVars;
var
    MetaCanvas: TMetafileCanvas;
    Dpi: Integer;
    MR: TRect;
begin
  FContentRect.Left := UnitsToPixelsX(FPageMargins.Left);
  FContentRect.Right := FContentRect.Left + PageWidthPrintablePixels;

  FContentRect.Top := UnitsToPixelsX(FPageMargins.Top);
  FContentRect.Bottom := FContentRect.Top + PageHeightPrintablePixels;

  FCurrentPage := 10000;
  FillVars(FHeader);
  FillVars(FFooter);
  FCurrentPage := 0;

  if FRenderer<>nil then
  begin
    FMetafile := TMetafile.Create;
    try
    FMetafile.Height := PageHeightFullPixels;
    FMetafile.Width := PageWidthFullPixels;

    MetaCanvas := TMetafileCanvas.Create(FMetafile, FSysPrinter.Handle);

    try
        Dpi := GetDeviceCaps(FSysPrinter.Handle, LOGPIXELSY);
      MetaCanvas.Font.PixelsPerInch := Dpi;

      MR := UnitsToPixelsRect(Margins.GetAsRect);

      FFrameRect := Rect(MR.Left, MR.Top,
                         PageWidthFullPixels - MR.Right,
                         PageHeightFullPixels - MR.Bottom);

      FHeadH := FHeader.CalkHeight(MetaCanvas, FFrameRect);
      FFootH := FFooter.CalkHeight(MetaCanvas, FFrameRect);

      FHeadH := Min(PageHeightPrintablePixels div 4, FHeadH);
      FFootH := Min(PageHeightPrintablePixels div 4, FFootH);

      FRenderer.PreparePages(PageWidthPrintablePixels,
                             PageHeightPrintablePixels - FHeadH - FFootH,
                             MetaCanvas);
    finally
      MetaCanvas.Free;
    end;

    FPagesCount := FRenderer.GetPagesCount(orAll);
    FSelectedPagesCount := FRenderer.GetPagesCount(orSelection);
    except
      on Exception do
        FreeAndNil(FMetafile);
    end;
  end
  else
  begin
    FPagesCount := 0;
    FSelectedPagesCount := 0;
  end;
end;

procedure TLMDPrinter.PrintableSettingsChanged;
begin
  BeginUpdate;
  try
    FreePrintVars;
    RecalkPrintable;
    PreparePrintVars;

    AddSettingsChanges([pcPrintableArea]);

    inherited;
  finally
    EndUpdate;
  end;
end;

procedure TLMDPrinter.PrintPages(ARange: TLMDPrintOperationRange;
                                 AStart, ACount: Integer);
var
    i: Integer;
    DoDocSt: Boolean;
begin
  CheckPrinterValid;
  CheckPagesPrepared;
  CheckPagesRange(ARange, AStart, ACount);

  DoDocSt := not FDocStarted;

  if DoDocSt then
    BeginDoc;

  try
    for i:=AStart to AStart+ACount-1 do
    begin
      DrawPage(ARange, i, FSysPrinter.Canvas,
               Rect(0, 0, PageWidthFullPixels, PageHeightFullPixels));

      if i<>AStart+ACount-1 then
        FSysPrinter.NewPage;
    end;
  finally
    if DoDocSt then
      EndDoc;
  end;
end;

procedure TLMDPrinter.ResetOnPrinterChanges(AChanges: TLMDPrinterChangeKinds);
var
    Old: TLMDMeasureUnits;
    R: TLMDDoubleRect;
    F, Def, Def2: Double;

procedure Convert(var Val: Double);
begin
  if Val<>Def then
    Val := Round(F*UnitsToUnits(Old, RealUnits, Val))/F
  else
    Val := Def2;
end;

begin
  BeginUpdate;
  try
    UpdatePrinterInfo;

    FHeader.Reset;
    FFooter.Reset;

    if (AChanges=[pcUnits]) and (FOldUnits<>FRealUnits) then
    begin
      Old := FOldUnits;
      FOldUnits := FUnits;

      F := 0; Def := 0; Def2 := 0;
      case FRealUnits of
        unMillimeters:
        begin
          F := 10; Def := DefaultMarginInch; Def2 := DefaultMarginMM;
        end;
        unInches:
        begin
          F:= 100;
          Def := DefaultMarginMM; Def2 := DefaultMarginInch;
        end;
      else
        Assert(false);
      end;

      R := FPageMargins.GetAsRect;

      Convert(R.Left);
      Convert(R.Right);
      Convert(R.Top);
      Convert(R.Bottom);

      FPageMargins.SetAsRect(R);
    end
    else
      FPageMargins.Reset;

    RecalkPrintable;

    FreePrintVars;
    PreparePrintVars;
  finally
    EndUpdate;
  end;
end;

procedure TLMDPrinter.SetFooter(const AValue: TLMDPageTemplateBlock);
begin
  if FFooter<>AValue then
    FFooter.Assign(AValue);
end;

procedure TLMDPrinter.SetHeader(const AValue: TLMDPageTemplateBlock);
begin
  if FHeader<>AValue then
    FHeader.Assign(AValue);
end;

procedure TLMDPrinter.SetPageMargins(const AValue: TLMDPageMargins);
begin
  if FPageMargins<>AValue then
    FPageMargins.Assign(AValue);
end;

function TLMDPrinter.ExecPageSetupDlg: Boolean;
var
    Dlg: TLMDPrintPageSetupDialog;
    Ok: Boolean;
begin
  CheckPrinterValid;

  Dlg := TLMDPrintPageSetupDialog.Create(nil);
  BeginUpdate;

  try
    Dlg.Printer := self;
    Dlg.Margins := Margins.GetAsRect;
    Dlg.HeaderTemplate := Header.Template;
    Dlg.FooterTemplate := Footer.Template;

    Ok := Dlg.Execute;

    if Ok then
    begin
      AddSettingsChanges([pcPrinterSettings]);

      Margins.SetAsRect(Dlg.Margins);
      Header.Template := Dlg.HeaderTemplate;
      Footer.Template := Dlg.FooterTemplate;
    end;

    Result := Ok;
  finally
    Dlg.Free;
    EndUpdate;
  end;
end;

procedure TLMDPrinter.ExecPreviewDlg;
begin
  CheckPrinterValid;
  CheckPagesPrepared;

  LMDPrintExecPreviewDlg(FHelper);
end;

function  TLMDPrinter.ExecPrintDlg: Boolean;
var
    Dlg: TLMDPrintDialog;
    Start, Count: Integer;
begin
  CheckPrinterValid;
  CheckPagesPrepared;
  CheckDocFinished;

  Dlg := TLMDPrintDialog.Create(nil);

  try
    Dlg.Printer := self;

    Dlg.Options := Dlg.Options +
                   [poPrintToFile, poPageNums, poSelection, poWarning];

    if FRenderer.GetPagesCount(orSelection)=0 then
      Dlg.Options := Dlg.Options - [poSelection];

    Dlg.MinPage := 1;
    Dlg.MaxPage := GetPagesCount(orAll);
    Dlg.FromPage := 1;
    Dlg.ToPage := GetPagesCount(orAll);

    Result := Dlg.Execute;
    if Result then
    begin
      Start := Dlg.FromPage-1;
      Count := Dlg.ToPage - Start;

      BeginDoc;
      try
        case Dlg.PrintRange of
          prPageNums: PrintPages(orAll, Start, Count);
          prAllPages: PrintPages(orAll, 0, GetPagesCount(orAll));
          prSelection: PrintPages(orSelection, 0, GetPagesCount(orSelection));
        else
          Assert(false);
        end;
      finally
        EndDoc;
      end;
    end;
  finally
    Dlg.Free;
  end;
end;

function TLMDPrinter.ExecPrintSetupDlg: Boolean;
begin
  CheckPrinterValid;

  BeginUpdate;
  try
    with TLMDPrinterSetupDialog.Create(nil) do
    try
      Printer := self;

      Result := Execute;
      if Result then
        PrinterSettingsChanged([pcPrinterSettings, pcPrintableArea]);
    finally
      Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TLMDPrinter.CheckPagesRange(AOpRange: TLMDPrintOperationRange;
                                      AStart, ACount: Integer);
begin
  CheckPagesPrepared;

  if (AStart<0) or (AStart>=GetPagesCount(AOpRange)) or
     (ACount<=0) or (AStart+ACount > GetPagesCount(AOpRange))
  then
    raise ELMDPrintPackError.CreateFmt(SLMDPrintPrinterBadPagesRange,
                                     [AStart, AStart+ACount-1,
                                      GetPagesCount(AOpRange)]);
end;

procedure TLMDPrinter.BeginDoc;
begin
  CheckPrinterValid;
  CheckPagesPrepared;
  CheckDocFinished;

  FSysPrinter.BeginDoc;
  FDocStarted := true;
end;

procedure TLMDPrinter.EndDoc;
begin
  CheckPrinterValid;
  CheckPagesPrepared;
  CheckDocStarted;

  FSysPrinter.EndDoc;

  FDocStarted := false;
end;

procedure TLMDPrinter.CheckDocStarted;
begin
  if not FDocStarted then
    raise ELMDPrintPackError.Create(SLMDPrintPrinterDocNotStarted);
end;

procedure TLMDPrinter.CheckDocFinished;
begin
  if FDocStarted then
    raise ELMDPrintPackError.Create(SLMDPrintPrinterDocNotFinished);
end;

procedure TLMDPrinter.SavePage(ARange: TLMDPrintOperationRange; APage: Integer;
                               AFileName: TLMDString);
var
    Mf: TMetafile;
    MfC: TMetafileCanvas;
begin
  CheckPrinterValid;
  CheckPagesPrepared;
  CheckPagesRange(ARange, APage, 1);

  Mf := TMetafile.Create;

  try
    Mf.Width := PageWidthFullPixels;
    Mf.Height := PageHeightFullPixels;

    MfC := TMetafileCanvas.Create(Mf, FSysPrinter.Handle);
    try
      DrawPage(ARange, APage, MfC, Rect(0, 0, PageWidthFullPixels,
                                        PageHeightFullPixels));
    finally
      MfC.Free;
    end;

    Mf.SaveToFile(AFileName);
  finally
    Mf.Free;
  end;
end;

procedure TLMDPrinter.FillVars(ATemplate: TLMDPageTemplateBlock);
begin
  ATemplate.Variables.Clear;

  ATemplate.Variables.Add('[Page]='+IntToStr(FCurrentPage+1));
  ATemplate.Variables.Add('[PagesCount]='+IntToStr(FPagesCount));
  ATemplate.Variables.Add('[Title]='+Title);
  ATemplate.Variables.Add('[Date]='+DateToStr(Date));
  ATemplate.Variables.Add('[DateTime]='+DateToStr(Now)+' ' + TimeToStr(Now));
end;

{ TPrinterHelper }

procedure TPrinterHelper.AddListener(ALst: TLMDPrinterListener);
begin
  FPrinter.AddListener(ALst);
end;

constructor TPrinterHelper.Create(APrinter: TLMDPrinter);
begin
  inherited Create;

  Assert(APrinter<>nil);

  FPrinter := APrinter;
end;

procedure TPrinterHelper.DrawPage(ARange: TLMDPrintOperationRange;
                                  APage: Integer; ACanvas: TCanvas;
                                  ARect: TRect);
begin
  FPrinter.DrawPage(ARange, APage, ACanvas, ARect);
end;

function TPrinterHelper.GetPageMargins: TLMDDoubleRect;
begin
  Result := FPrinter.Margins.GetAsRect;
end;

function TPrinterHelper.GetPrinter: TLMDPrinterBase;
begin
  Result := FPrinter;
end;

function TPrinterHelper.GetPagesCount(ARange: TLMDPrintOperationRange): Integer;
begin
  Result := FPrinter.GetPagesCount(ARange);
end;

procedure TPrinterHelper.PrintPages(ARange: TLMDPrintOperationRange;
                                    AStart, ACount: Integer);
begin
  FPrinter.PrintPages(ARange, AStart, ACount);
end;

procedure TPrinterHelper.RemoveListener(ALst: TLMDPrinterListener);
begin
  FPrinter.RemoveListener(ALst);
end;

procedure TPrinterHelper.SetPageMargins(const AValue: TLMDDoubleRect);
begin
  FPrinter.Margins.SetAsRect(AValue);
end;

procedure TPrinterHelper.ExecPageSetupDlg;
begin
  FPrinter.ExecPageSetupDlg;
end;

procedure TPrinterHelper.ExecPrintDlg;
begin
  FPrinter.ExecPrintDlg;
end;

procedure TPrinterHelper.ExecPrintSetupDlg;
begin
  FPrinter.ExecPrintSetupDlg;
end;

procedure TPrinterHelper.SavePage(ARange: TLMDPrintOperationRange;
                                  APage: Integer; AFileName: TLMDString);
begin
  FPrinter.SavePage(ARange, APage, AFileName);
end;

{ TTemplStringsProxy }

procedure TTemplStringsProxy.Clear;
begin
  FOrigin.Clear;
end;

constructor TTemplStringsProxy.Create(AOrigin: TStrings);
begin
  inherited Create;

  FOrigin := AOrigin;
end;

procedure TTemplStringsProxy.DefineProperties(Filer: TFiler);
var
    HasData: Boolean;
begin
  HasData := LMDTrim(Text)<>'';

  Filer.DefineBinaryProperty('StringsData', LoadData, SaveData, HasData);
end;

procedure TTemplStringsProxy.Delete(Index: Integer);
begin
  FOrigin.Delete(Index);
end;

function TTemplStringsProxy.Get(Index: Integer): string;
begin
  Result := FOrigin[Index];
end;

function TTemplStringsProxy.GetCount: Integer;
begin
  Result := FOrigin.Count;
end;

function TTemplStringsProxy.GetObject(Index: Integer): TObject;
begin
  Result := FOrigin.Objects[Index];
end;

procedure TTemplStringsProxy.Insert(Index: Integer; const S: string);
begin
  FOrigin.Insert(Index, S);
end;

procedure TTemplStringsProxy.LoadData(Stream: TStream);
begin
  FOrigin.LoadFromStream(Stream);
end;

procedure TTemplStringsProxy.LoadFromStream(Stream: TStream);
begin
  FOrigin.LoadFromStream(Stream);
end;

procedure TTemplStringsProxy.Put(Index: Integer; const S: string);
begin
  FOrigin[Index] := S;
end;

procedure TTemplStringsProxy.PutObject(Index: Integer; AObject: TObject);
begin
  FOrigin.Objects[Index] := AObject;
end;

procedure TTemplStringsProxy.SaveData(Stream: TStream);
begin
  FOrigin.SaveToStream(Stream);
end;

procedure TTemplStringsProxy.SaveToStream(Stream: TStream);
begin
  FOrigin.SaveToStream(Stream);
end;

procedure TTemplStringsProxy.SetUpdateState(Updating: Boolean);
begin
  TStringsAccess(FOrigin).SetUpdateState(Updating);
  end;

initialization

  DefaultMarginInch := Round(100* DefaultMarginMM / MillimetersPerInch ) / 100;

end.
