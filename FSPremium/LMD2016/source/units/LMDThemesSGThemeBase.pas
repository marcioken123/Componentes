unit LMDThemesSGThemeBase;
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

LMDThemesBaseSGThemeRenderer unit (VB)
----------------------------------

Contains base simple gradient theme renderer class,
which implements simple gradient themes

Changes
-------
Release 10.0 (January 2009)
- Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Windows,
  UxTheme, Themes, Graphics, TypInfo,
  LMDTypes, LMDClass,  LMDThemes, LMDGraph, LMDGradient, LMDThemesCommonTypes;

type
  TLMDSimpleGradientTheme = (sgtOffice2003, sgtCustom, sgtUnknown);

const
  CSimpleGradientThemeNames : array[TLMDSimpleGradientTheme] of string = ('Office2003', 'Custom', 'Unknown');

type
  TLMDSimpleGradientSettings = record
    CountType: TLMDGradientColorCountType;
    FixedNumber: Integer;
    CalcDivizor : Integer;
    GradientStyle: TLMDGradientStyle;
  end;

type
  TLMDBaseSGThemeRenderer = class(TLMDThemeRenderer)
  private
    FEnabled: boolean;
    FTheme: TLMDSimpleGradientTheme;
    FThemeName: string;
    FColorScheme: TLMDColorScheme;
    FColorSchemeName: string;
    FIsUpdating: boolean;

    //--- color settings fields section --->
    FBtnFillColors: array[TThemedButton, TLMDColorIndex] of TColor;
    FBtnFrameColors: array[TThemedButton] of TColor;
    FMenuItemFrameColors: array[TThemedMenu] of TColor;
    FToolbarFillColors: array[TThemedToolBar, TLMDColorIndex] of TColor;
    FToolbarFrameColors: array[TThemedToolBar]  of TColor;
    FEnabledTextColor,
    FDisabledTextColor: TColor;
    FComboboxColors:  array[TThemedComboBox, TLMDColorIndex] of TColor;
    FComboboxFrameColors:  array[TThemedComboBox] of TColor;
    FEditFillColors: array[TThemedEdit, TLMDColorIndex] of TColor;
    FEditFrameColors: array[TThemedEdit] of TColor;
    FSpinBtnFillColors: array[TThemedSpin, TLMDColorIndex] of TColor;
    FSpinBtnFrameColors: array[TThemedSpin] of TColor;
    FScrollBarFillColors: array[TThemedScrollBar, TLMDColorIndex] of TColor;
    FScrollBarFrameColors: array[TThemedScrollBar] of TColor;
    FTabColors: array[TThemedTab, TLMDColorIndex] of TColor;
    FProgressColors: array[TThemedProgress, TLMDColorIndex] of TColor;
    FProgressFrameColors: array[TThemedProgress] of TColor;
    FHeaderColors: array[TThemedHeader, TLMDColorIndex] of TColor;
    FHeaderFrameColors: array[TThemedHeader] of TColor;
    FTrackBarFillColors: array[TThemedTrackBar, TLMDColorIndex] of TColor;
    FTrackBarFrameColors: array[TThemedTrackBar] of TColor;
    FStatusBarFillColors: array[TThemedStatus, TLMDColorIndex] of TColor;
    FStatusBarFrameColors: array[TThemedStatus] of TColor;
    FExplorerBarFillColors: array[TThemedExplorerBar, TLMDColorIndex] of TColor;

    //--- end of color settings fields section --->

    //<-- this array allows to access colors for all elements via once cycle
    FMetaData: array[TThemedElement] of TLMDThemeDetailMetaData;
    //-->


    FGradientSettings: array[TThemedElement] of TLMDSimpleGradientSettings;

    FOnDrawCheckMark: TLMDThemesOnDrawCheckMarkEvent;
    FOnDrawRadioBtn: TLMDThemesOnDrawCheckMarkEvent;
    FOnDrawScrollThumbGripper: TLMDThemesOnDrawScrollThumbGripperEvent;
    FOnDrawArrow: TLMDThemesOnDrawArrowEvent;
    FOnDrawGradientArrow: TLMDThemesOnDrawGradientArrowEvent;
    FOnDrawPlus: TLMDThemesOnDrawSimpleSignEvent;
    FOnDrawMinus: TLMDThemesOnDrawSimpleSignEvent;
    FOnDrawCross: TLMDThemesOnDrawSimpleSignEvent;

    //<--- property setters and getters section -----
    function GetBtnFillColors(Element: TThemedButton;
      ColorIndex: TLMDColorIndex): TColor;
    procedure SetBtnFillColors(Element: TThemedButton;
      ColorIndex: TLMDColorIndex; const Value: TColor);
    function GetBtnFrameColors(Element: TThemedButton): TColor;
    procedure SetBtnFrameColors(Element: TThemedButton;
      const Value: TColor);
    function GetMenuItemFrameColors(Element: TThemedMenu): TColor;
    procedure SetMenuItemFrameColors(Element: TThemedMenu;
      const Value: TColor);
    function GetComboboxColors(Element: TThemedComboBox;
      ColorIndex: TLMDColorIndex): TColor;
    function GetComboboxFrameColors(Element: TThemedComboBox): TColor;
    function GetEditFillColors(Element: TThemedEdit;
      ColorIndex: TLMDColorIndex): TColor;
    function GetEditFrameColors(Element: TThemedEdit): TColor;
    function GetToolbarFillColors(Element: TThemedToolBar; ColorIndex: TLMDColorIndex): TColor;
    procedure SetComboboxColors(Element: TThemedComboBox;
      ColorIndex: TLMDColorIndex; const Value: TColor);
    procedure SetComboboxFrameColors(Element: TThemedComboBox;
      const Value: TColor);
    procedure SetEditFillColors(Element: TThemedEdit;
      ColorIndex: TLMDColorIndex; const Value: TColor);
    procedure SetEditFrameColors(Element: TThemedEdit;
      const Value: TColor);
    procedure SetToolbarFillColors(Element: TThemedToolBar; ColorIndex: TLMDColorIndex;
      const Value: TColor);
    procedure SetToolbarFrameColors(Element: TThemedToolBar; const Value: TColor);
    function GetToolbarFrameColors(Element: TThemedToolBar): TColor;
    function GetGradientSettings(
      Element: TThemedElement): TLMDSimpleGradientSettings;
    function GetProgressColors(Element: TThemedProgress;
      ColorIndex: TLMDColorIndex): TColor;
    function GetProgressFrameColors(Element: TThemedProgress): TColor;
    function GetSpinBtnFillColors(Element: TThemedSpin;
      ColorIndex: TLMDColorIndex): TColor;
    function GetSpinBtnFrameColors(Element: TThemedSpin): TColor;
    procedure SetSpinBtnFrameColors(Element: TThemedSpin;
      const Value: TColor);
    function GetTabColors(Element: TThemedTab;
      ColorIndex: TLMDColorIndex): TColor;
    procedure SetGradientSettings(Element: TThemedElement;
      const Value: TLMDSimpleGradientSettings);
    procedure SetProgressColors(Element: TThemedProgress;
      ColorIndex: TLMDColorIndex; const Value: TColor);
    procedure SetProgressFrameColors(Element: TThemedProgress;
      const Value: TColor);
    procedure SetSpinBtnFillColors(Element: TThemedSpin;
      ColorIndex: TLMDColorIndex; const Value: TColor);
    procedure SetTabColors(Element: TThemedTab; ColorIndex: TLMDColorIndex;
      const Value: TColor);
    function GetDisabledTextColor: TColor;
    function GetEnabledTextColor: TColor;
    procedure SetDisabledTextColor(const Value: TColor);
    procedure SetEnabledTextColor(const Value: TColor);
    function GetScrollBarFillColors(Element: TThemedScrollBar;
      ColorIndex: TLMDColorIndex): TColor;
    procedure SetScrollBarFillColors(Element: TThemedScrollBar;
      ColorIndex: TLMDColorIndex; const Value: TColor);
    function GetScrollBarFrameColors(Element: TThemedScrollBar): TColor;
    procedure SetScrollBarFrameColors(Element: TThemedScrollBar;
      const Value: TColor);
    function GetHeaderColors(Element: TThemedHeader;
      ColorIndex: TLMDColorIndex): TColor;
    procedure SetHeaderColors(Element: TThemedHeader;
      ColorIndex: TLMDColorIndex; const Value: TColor);
    function GetHeaderFrameColors(Element: TThemedHeader): TColor;
    procedure SetHeaderFrameColors(Element: TThemedHeader; const Value: TColor);
    function GetTrackBarFillColors(Element: TThemedTrackBar;
      ColorIndex: TLMDColorIndex): TColor;
    function GetTrackBarFrameColors(Element: TThemedTrackBar): TColor;
    procedure SetTrackBarFillColors(Element: TThemedTrackBar;
      ColorIndex: TLMDColorIndex; const Value: TColor);
    procedure SetTrackBarFrameColors(Element: TThemedTrackBar;
      const Value: TColor);
    procedure SetColorSchemeName(const Value: string);
    function GetStatusBarFillColors(Element: TThemedStatus;
      ColorIndex: TLMDColorIndex): TColor;
    procedure SetStatusBarFillColors(Element: TThemedStatus;
      ColorIndex: TLMDColorIndex; const Value: TColor);
    function GetStatusBarFrameColors(Element: TThemedStatus): TColor;
    procedure SetStatusBarFrameColors(Element: TThemedStatus;
      const Value: TColor);
    function GetExplorerBarFillColors(Element: TThemedExplorerBar;
      ColorIndex: TLMDColorIndex): TColor;
    procedure SetExplorerBarFillColors(Element: TThemedExplorerBar;
      ColorIndex: TLMDColorIndex; const Value: TColor);
    function GetMetaData(
      Element: TThemedElement): TLMDThemeDetailMetaData;
    //--- end of property setters and getters section ----->
  protected
    FController: TLMDThemesControllerBase;

    procedure DrawArrow(DC: HDC; ARect: TRect; ADir: TLMDDirection); virtual;
    procedure DrawCross(DC: HDC; ARect: TRect); virtual;
    procedure DrawMinus(DC: HDC; ARect: TRect; aColor:TColor); virtual;
    procedure DrawPlus(DC: HDC; ARect: TRect; aColor:TColor); virtual;
    procedure DrawCheckMark(DC: HDC; ARect: TRect; acb: TThemedButton); virtual;
    procedure DrawRadioBtn(DC: HDC; ARect: TRect; arb: TThemedButton); virtual;
    procedure DrawScrollThumbGripper(DC: HDC; aRect: TRect; Detail: TThemedScrollBar); virtual;

    procedure DrawGradientFramedRect(DC: HDC; R: TRect; ClipRect: TLMDRectPtr; AStartFillColor, AEndFillColor, AFrameColor: TColor; AGradientStyle: TLMDGradientStyle; AFlags: Word; AFrame: TLMDFrameSides = [fsLeft, fsRight, fsTop, fsBottom]); virtual;

    procedure DoUpdateTheme; virtual;
    function GetEnabled: boolean; override;
    procedure SetEnabled(aValue: boolean); override;
  public
    constructor Create; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    //<--- theme renderer common methods section ---
    function ActivateColorScheme(AColorScheme: string; ADoApply: boolean = true): boolean; override;
    function ActivateDefaultTheme(AColorScheme: string = ''; aDoApply: boolean = true):boolean; override;
    function ActivateTheme(AFileName: string; AColorScheme: string = 'Blue'): boolean; override;
    procedure DeactivateTheme; override;

    function ContentRect(DC: HDC; Details: TThemedElementDetails; BoundingRect: TRect): TRect; override;

    function GetThemeBackgroundExtent(DC: HDC; Detail: TThemedElement; iPartID, iStateID: integer; ContentRect: TRect; var ExtentRect: TRect): boolean; override;
    function GetThemeColor(AElement: TThemedElement; iPartId, iStateId, iPropId: Integer): COLORREF; override;
    function GetThemeFont(DC: HDC; Detail: TThemedElement; iPartId, iStateId, iPropId:Integer; var font: LOGFONTW): Boolean; override;
    function GetThemePartSize(DC: HDC; Detail: TThemedElement; iPartId, iStateId:Integer; var size: TSize): Boolean; override;

    function GetThemeSysColor(Detail: TThemedElement; ColorID: integer): ColorRef; override;
    function GetThemeSysSize(Detail: TThemedElement; iSizeId: Integer): Integer; override;
    function GetThemeTextExtent(DC: HDC; Detail: TThemedElement; iPartId, iStateId: Integer; Text: TLMDString; CharCount: Integer; dwTextFlags: DWORD; BoundingRect: TLMDRectPtr; var ExtentRect: TRect): boolean; override;

    function GetActiveThemeName: TLMDString; override;
    function GetActiveColorSchemeName: TLMDString; override;

    procedure DrawElement(DC: HDC; Detail: TThemedButton; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedButton; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedComboBox; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedComboBox; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedEdit; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedEdit; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedExplorerBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedExplorerBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedProgress; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedProgress; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedScrollBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedScrollBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedSpin; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedSpin; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedStatus; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedStatus; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTab; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTab; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedToolBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedToolBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedToolTip; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedToolTip; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTrackBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTrackBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedWindow; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedWindow; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedListview; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedListview; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedHeader; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedHeader; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTreeview; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTreeview; const R: TRect; ClipRect: TLMDRectPtr); overload; override;

    procedure DrawElement(DC: HDC; Details: TThemedElementDetails; const R: TRect; ClipRect: TLMDRectPtr = LMDNullRectPtr); overload; override;

    procedure DrawThemeParentBackground(Wnd: HWnd; DC: HDC; ARect: TLMDRectPtr); override;

    function DrawThemeEdge(DC: HDC; aElement: TThemedElement; iPartId, iStateId: Integer; const pDestRect: TRect; uEdge, uFlags: UINT; pContentRect: TLMDRectPtr): boolean; overload; override;
    function DrawThemeText(DC: HDC; Detail: TThemedElement; iPartId, iStateId: Integer; Text: TLMDString; CharCount: Integer; dwTextFlags, dwTextFlags2: DWORD; const ARect: TRect): boolean; override;
    //--- end of theme renderer common methods section --->

    procedure ChangeBrightness(aPercent: integer; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aIndices: TLMDColorIndexSet = [ciStart, ciEnd]; aChangeFrameColors: boolean = true);
    procedure ReplaceColor(aOldColor, aNewColor: TColor; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aIndices: TLMDColorIndexSet = [ciStart, ciEnd]; aDetailProps: TLMDDetailPropKindSet = CAllDetailPropKinds);
    procedure SetNewColor(aNewColor: TColor; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aIndices: TLMDColorIndexSet = [ciStart, ciEnd]; aDetailProps: TLMDDetailPropKindSet = CAllDetailPropKinds);

    function SaveThemeToStream(aStream: TStream; aThemeName: TLMDString = ''; aColorScheme: TLMDString = ''): boolean; virtual;
    function LoadThemeFromStream(aStream: TStream; aColorScheme: TLMDString = ''): boolean; virtual;
    procedure SaveThemeToFile(aFileName: TLMDString; aThemeName: TLMDString = ''; aColorScheme: TLMDString = '');
    function LoadThemeFromFile(aFile: TLMDString; aColorScheme: TLMDString = ''): boolean;

    property Theme: TLMDSimpleGradientTheme read FTheme;
    property ThemeName: string read FThemeName;
    property ColorScheme: TLMDColorScheme read FColorScheme;
    property ColorSchemeName: string read FColorSchemeName write SetColorSchemeName;

    property BtnFillColors[Element: TThemedButton; ColorIndex: TLMDColorIndex]:TColor  read GetBtnFillColors write SetBtnFillColors;
    property BtnFrameColors[Element: TThemedButton]: TColor read GetBtnFrameColors write SetBtnFrameColors;
    property EnabledTextColor: TColor read GetEnabledTextColor write SetEnabledTextColor;
    property DisabledTextColor: TColor read GetDisabledTextColor write SetDisabledTextColor;
    property HeaderColors[Element: TThemedHeader; ColorIndex: TLMDColorIndex]:TColor  read GetHeaderColors write SetHeaderColors;
    property HeaderFrameColors[Element: TThemedHeader]: TColor read GetHeaderFrameColors write SetHeaderFrameColors;

    property MenuItemFrameColors[Element: TThemedMenu]: TColor read GetMenuItemFrameColors write SetMenuItemFrameColors;
    property ToolbarFillColors[Element: TThemedToolBar; ColorIndex: TLMDColorIndex]: TColor  read GetToolbarFillColors write SetToolbarFillColors;
    property ToolbarFrameColors[Element: TThemedToolBar]: TColor read GetToolbarFrameColors write SetToolbarFrameColors;
    property ComboboxColors[Element: TThemedComboBox; ColorIndex:TLMDColorIndex]: TColor read GetComboboxColors write SetComboboxColors;
    property ComboboxFrameColors[Element: TThemedComboBox]: TColor read GetComboboxFrameColors write SetComboboxFrameColors;
    property EditFillColors[Element: TThemedEdit; ColorIndex: TLMDColorIndex]: TColor read GetEditFillColors write SetEditFillColors;
    property EditFrameColors[Element: TThemedEdit]: TColor read GetEditFrameColors write SetEditFrameColors;

    property ExplorerBarFillColors[Element: TThemedExplorerBar; ColorIndex: TLMDColorIndex]: TColor read GetExplorerBarFillColors write SetExplorerBarFillColors;

    property MetaData[Element: TThemedElement]: TLMDThemeDetailMetaData read GetMetaData;

    property SpinBtnFillColors[Element: TThemedSpin; ColorIndex: TLMDColorIndex]: TColor read GetSpinBtnFillColors write SetSpinBtnFillColors;
    property SpinBtnFrameColors[Element: TThemedSpin]: TColor read GetSpinBtnFrameColors write SetSpinBtnFrameColors;
    property ScrollBarFillColors[Element: TThemedScrollBar; ColorIndex: TLMDColorIndex]: TColor read GetScrollBarFillColors write SetScrollBarFillColors;
    property ScrollBarFrameColors[Element: TThemedScrollBar]: TColor read GetScrollBarFrameColors write SetScrollBarFrameColors;
    property StatusBarFillColors[Element: TThemedStatus; ColorIndex: TLMDColorIndex]: TColor read GetStatusBarFillColors write SetStatusBarFillColors;
    property StatusBarFrameColors[Element: TThemedStatus]: TColor read GetStatusBarFrameColors write SetStatusBarFrameColors;
    property TabColors[Element: TThemedTab; ColorIndex: TLMDColorIndex]: TColor read GetTabColors write SetTabColors;
    property ProgressColors[Element: TThemedProgress; ColorIndex: TLMDColorIndex]: TColor read GetProgressColors write SetProgressColors;
    property ProgressFrameColors[Element: TThemedProgress]: TColor read GetProgressFrameColors write SetProgressFrameColors;
    property TrackBarFillColors[Element: TThemedTrackBar; ColorIndex: TLMDColorIndex]: TColor read GetTrackBarFillColors write SetTrackBarFillColors;
    property TrackBarFrameColors[Element: TThemedTrackBar]: TColor read GetTrackBarFrameColors write SetTrackBarFrameColors;
    property GradientSettings[Element: TThemedElement]: TLMDSimpleGradientSettings read GetGradientSettings write SetGradientSettings;

    property OnDrawCheckMark: TLMDThemesOnDrawCheckMarkEvent read FOnDrawCheckMark write FOnDrawCheckMark;
    property OnDrawRadioBtn: TLMDThemesOnDrawCheckMarkEvent read FOnDrawRadioBtn write FOnDrawRadioBtn;    
    property OnDrawScrollThumbGripper: TLMDThemesOnDrawScrollThumbGripperEvent read FOnDrawScrollThumbGripper write FOnDrawScrollThumbGripper;
    property OnDrawArrow: TLMDThemesOnDrawArrowEvent read FOnDrawArrow write FOnDrawArrow;
    property OnDrawGradientArrow: TLMDThemesOnDrawGradientArrowEvent read FOnDrawGradientArrow write FOnDrawGradientArrow;
    property OnDrawPlus: TLMDThemesOnDrawSimpleSignEvent read FOnDrawPlus write FOnDrawPlus;
    property OnDrawMinus: TLMDThemesOnDrawSimpleSignEvent read FOnDrawMinus write FOnDrawMinus;
    property OnDrawCross: TLMDThemesOnDrawSimpleSignEvent read FOnDrawCross write FOnDrawCross;
  end;

implementation

uses
  Math, LMDStrings, LMDXML, LMDThemesConst, LMDProcs, LMDGraphUtils;

{------------------------ TLMDBaseSGThemeRenderer -----------------------------}
{----------------------------- Private ----------------------------------------}
function TLMDBaseSGThemeRenderer.GetBtnFillColors(Element: TThemedButton;
  ColorIndex: TLMDColorIndex): TColor;
begin
  result := FBtnFillColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetBtnFillColors(Element: TThemedButton;
  ColorIndex: TLMDColorIndex; const Value: TColor);
begin
  if Value <> FBtnFillColors[Element, ColorIndex] then
    begin
      FBtnFillColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetBtnFrameColors(
  Element: TThemedButton): TColor;
begin
  result := FBtnFrameColors[Element];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetBtnFrameColors(
  Element: TThemedButton; const Value: TColor);
begin
  if Value <> FBtnFrameColors[Element] then
    begin
      FBtnFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetMenuItemFrameColors(
  Element: TThemedMenu): TColor;
begin
  result := FMenuItemFrameColors[Element];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetMenuItemFrameColors(
  Element: TThemedMenu; const Value: TColor);
begin
  if Value <> FMenuItemFrameColors[Element] then
    begin
      FMenuItemFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetComboboxColors(
  Element: TThemedComboBox; ColorIndex: TLMDColorIndex): TColor;
begin
  result := FComboboxColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetComboboxFrameColors(
  Element: TThemedComboBox): TColor;
begin
  result := FComboboxFrameColors[Element];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetEditFillColors(
  Element: TThemedEdit; ColorIndex: TLMDColorIndex): TColor;
begin
  result := FEditFillColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetEditFrameColors(
  Element: TThemedEdit): TColor;
begin
  result := FEditFrameColors[Element];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetToolbarFillColors(Element: TThemedToolBar;
  ColorIndex: TLMDColorIndex): TColor;
begin
  result := FToolbarFillColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetComboboxColors(
  Element: TThemedComboBox; ColorIndex: TLMDColorIndex;
  const Value: TColor);
begin
  if Value <> FComboboxColors[Element, ColorIndex] then
    begin
      FComboboxColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetComboboxFrameColors(
  Element: TThemedComboBox; const Value: TColor);
begin
  if Value <> FComboboxFrameColors[Element] then
    begin
      FComboboxFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetEditFillColors(
  Element: TThemedEdit; ColorIndex: TLMDColorIndex; const Value: TColor);
begin
  if Value <> FEditFillColors[Element, ColorIndex] then
    begin
      FEditFillColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetEditFrameColors(
  Element: TThemedEdit; const Value: TColor);
begin
  if Value <> FEditFrameColors[Element] then
    begin
      FEditFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetToolbarFillColors(Element: TThemedToolBar;
  ColorIndex: TLMDColorIndex; const Value: TColor);
begin
  if Value <> FToolbarFillColors[Element, ColorIndex] then
    begin
      FToolbarFillColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetToolbarFrameColors(Element: TThemedToolBar; const Value: TColor);
begin
  if Value <> FToolbarFrameColors[Element] then
    begin
      FToolbarFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetToolbarFrameColors(Element: TThemedToolBar): TColor;
begin
  result := FToolbarFrameColors[Element];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetGradientSettings(
  Element: TThemedElement): TLMDSimpleGradientSettings;
begin
  result := FGradientSettings[Element];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetHeaderColors(Element: TThemedHeader;
  ColorIndex: TLMDColorIndex): TColor;
begin
  result := FHeaderColors[Element, ColorIndex];
end;


{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetHeaderFrameColors(
  Element: TThemedHeader): TColor;
begin
  result := FHeaderFrameColors[Element];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetProgressColors(
  Element: TThemedProgress; ColorIndex: TLMDColorIndex): TColor;
begin
  result := FProgressColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetProgressFrameColors(
  Element: TThemedProgress): TColor;
begin
  result := FProgressFrameColors[Element];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetSpinBtnFillColors(
  Element: TThemedSpin; ColorIndex: TLMDColorIndex): TColor;
begin
  result :=  FSpinBtnFillColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetTabColors(Element: TThemedTab;
  ColorIndex: TLMDColorIndex): TColor;
begin
  result :=  FTabColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetGradientSettings(
  Element: TThemedElement; const Value: TLMDSimpleGradientSettings);
begin
  if (Value.CountType <> FGradientSettings[Element].CountType) or
     (Value.FixedNumber <> FGradientSettings[Element].FixedNumber) or
     (Value.CalcDivizor <> FGradientSettings[Element].CalcDivizor) or
     (Value.GradientStyle <> FGradientSettings[Element].GradientStyle) then
    begin
      FGradientSettings[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetHeaderColors(
  Element: TThemedHeader; ColorIndex: TLMDColorIndex; const Value: TColor);
begin
  if Value <> FHeaderColors[Element, ColorIndex] then
    begin
      FHeaderColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetHeaderFrameColors(
  Element: TThemedHeader; const Value: TColor);
begin
  if Value <> FHeaderFrameColors[Element] then
    begin
      FHeaderFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetProgressColors(
  Element: TThemedProgress; ColorIndex: TLMDColorIndex;
  const Value: TColor);
begin
  if Value <> FProgressColors[Element, ColorIndex] then
    begin
      FProgressColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetProgressFrameColors(
  Element: TThemedProgress; const Value: TColor);
begin
  if Value <> FProgressFrameColors[Element] then
    begin
      FProgressFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetSpinBtnFillColors(
  Element: TThemedSpin; ColorIndex: TLMDColorIndex; const Value: TColor);
begin
  if Value <> FSpinBtnFillColors[Element, ColorIndex] then
    begin
      FSpinBtnFillColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetSpinBtnFrameColors(
  Element: TThemedSpin): TColor;
begin
  result := FSpinBtnFrameColors[Element];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetSpinBtnFrameColors(
  Element: TThemedSpin; const Value: TColor);
begin
  if Value <> FSpinBtnFrameColors[Element] then
    begin
      FSpinBtnFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetTabColors(Element: TThemedTab;
  ColorIndex: TLMDColorIndex; const Value: TColor);
begin
  if Value <> FTabColors[Element, ColorIndex] then
    begin
      FTabColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetDisabledTextColor: TColor;
begin
  result := FDisabledTextColor;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetEnabledTextColor: TColor;
begin
  result := FEnabledTextColor;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetExplorerBarFillColors(
  Element: TThemedExplorerBar; ColorIndex: TLMDColorIndex): TColor;
begin
  result := FExplorerBarFillColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetDisabledTextColor(
  const Value: TColor);
begin
  if Value <> DisabledTextColor then
    begin
      FDisabledTextColor := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetEnabledTextColor(
  const Value: TColor);
begin
  if Value <> EnabledTextColor then
    begin
      FEnabledTextColor := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetExplorerBarFillColors(
  Element: TThemedExplorerBar; ColorIndex: TLMDColorIndex; const Value: TColor);
begin
  if Value <> FExplorerBarFillColors[Element, ColorIndex] then
    begin
      FExplorerBarFillColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetTrackBarFillColors(
  Element: TThemedTrackBar; ColorIndex: TLMDColorIndex): TColor;
begin
  result := FTrackBarFillColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetTrackBarFrameColors(
  Element: TThemedTrackBar): TColor;
begin
  result := FTrackBarFrameColors[Element];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetTrackBarFillColors(
  Element: TThemedTrackBar; ColorIndex: TLMDColorIndex;
  const Value: TColor);
begin
  if Value <> FTrackBarFillColors[Element, ColorIndex] then
    begin
      FTrackBarFillColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetTrackBarFrameColors(
  Element: TThemedTrackBar; const Value: TColor);
begin
  if Value <> FTrackBarFrameColors[Element] then
    begin
      FTrackBarFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawArrow(DC: HDC; ARect: TRect; ADir: TLMDDirection);
var
  x, y: integer;
 lPen, lOldPen: HPEN;
begin
  LMDAdjustRect(ARect, 1, 1);

  x := (ARect.Right + ARect.Left) div 2;
  y := (ARect.Bottom + ARect.Top) div 2 - 1;
  lPen := CreatePen(PS_SOLID, 1, FBtnFrameColors[tbPushButtonHot]);
  lOldPen := SelectObject(DC, lPen);
  case ADir of
    tdDown:
      begin
        MoveToEx(DC, x - 2, y - 1, nil);
        LineTo(DC, x + 3, y - 1);
        MoveToEx(DC, x - 1, y, nil);
        LineTo(DC, x + 2, y);
        MoveToEx(DC, x, y, nil);
        LineTo(DC, x, y + 2);
      end;
    tdUp:
      begin
        MoveToEx(DC, x - 2, y + 1, nil);
        LineTo(DC, x + 3, y + 1);
        MoveToEx(DC, x - 1, y, nil);
        LineTo(DC, x + 2, y);
        MoveToEx(DC, x, y, nil);
        LineTo(DC, x, y - 2);
      end;
    tdLeft:
      begin
        MoveToEx(DC, x + 1, y - 2, nil);
        LineTo(DC, x + 1, y + 3);
        MoveToEx(DC, x, y - 1, nil);
        LineTo(DC, x, y + 2);
        MoveToEx(DC, x, y, nil);
        LineTo(DC, x - 2, y);
      end;
    tdRight:
      begin
        MoveToEx(DC, x - 1, y - 2, nil);
        LineTo(DC, x - 1, y + 3);
        MoveToEx(DC, x, y - 1, nil);
        LineTo(DC, x, y + 2);
        MoveToEx(DC, x, y, nil);
        LineTo(DC, x + 2, y);
      end;
  end;
  SelectObject(DC, lOldPen);
  DeleteObject(lPen);  
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawCross(DC: HDC; ARect: TRect);
var
  x, y: integer;
  lOldPen, lPen: HPEN;
  procedure Draw;
    begin
      MoveToEx(DC, x - 3, y - 3, nil);
      LineTo(DC, x + 4, y + 4);
      MoveToEx(DC, x - 3, y + 3, nil);
      LineTo(DC, x + 4, y - 4);
    end;
begin
  LMDAdjustRect(ARect, 1, 1);
  x := (ARect.Right + ARect.Left) div 2 - 1;
  y := (ARect.Bottom + ARect.Top) div 2;
  lPen := CreatePen(PS_SOLID, 1, FBtnFrameColors[tbPushButtonHot]);
  lOldPen := SelectObject(DC, lPen);
  Draw;
  inc(x);
  Draw;
  SelectObject(DC, lOldPen);
  DeleteObject(lPen);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawCheckMark(DC: HDC; ARect: TRect; acb: TThemedButton);
var
  X, Y: Integer;
  lBrush : HBRUSH;
  lPen, lOldPen: HPEN;
  lExit: boolean;
  procedure Draw;
    begin
      lPen := CreatePen(PS_SOLID, 1, FBtnFrameColors[acb]);
      lOldPen := SelectObject(DC, lPen);
      MoveToEx(DC,x, y, nil);
      LineTo(DC,x + 2, y + 2);
      MoveToEx(DC, x + 2, y + 2, nil);
      LineTo(DC, x + 7, y - 3);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end;
begin
  lExit := false;
  if Assigned(FOnDrawCheckMark) then
    FOnDrawCheckMark(Self, DC, aRect, acb, lExit);
  if not lExit then
  begin
    LMDAdjustRect(ARect, 1, 1);
    if acb in [tbCheckBoxCheckedNormal..tbCheckBoxCheckedDisabled] then
      begin
        X := (ARect.Right + ARect.Left) div 2 - 4;
        Y := (ARect.Bottom + ARect.Top) div 2 - 1;
        Draw;
        inc(y);
        Draw;
      end;
    if acb in [tbCheckBoxMixedNormal..tbCheckBoxMixedDisabled] then
      begin
        InflateRect(ARect, -3, -3);
        LMDAdjustRect(ARect, -1, -1);
        lBrush := CreateSolidBrush(FBtnFrameColors[acb]);
        FillRect(DC, ARect, lBrush);
        DeleteObject(lBrush);
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawMinus(DC: HDC; ARect: TRect; aColor:TColor);
var
  x, y: integer;
  lOldPen, lPen: HPEN;
  procedure Draw;
    begin
      MoveToEx(DC, x - 2, y, nil);
      LineTo(DC, x + 4, y);
      MoveToEx(DC, x - 2, y + 1, nil);
      LineTo(DC, x + 4, y + 1);
    end;
begin
  LMDAdjustRect(ARect, 1, 1);
  x := (ARect.Right + ARect.Left) div 2 - 1;
  y := (ARect.Bottom + ARect.Top) div 2;
  lPen := CreatePen(PS_SOLID, 1, aColor);
  lOldPen := SelectObject(DC, lPen);
  Draw;
  SelectObject(DC, lOldPen);
  DeleteObject(lPen);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawPlus(DC: HDC; ARect: TRect; aColor:TColor);
var
  x, y: integer;
  lOldPen, lPen: HPEN;
  procedure Draw;
    begin
      MoveToEx(DC, x - 2, y, nil);
      LineTo(DC, x + 4, y);
      MoveToEx(DC, x - 2, y + 1, nil);
      LineTo(DC, x + 4, y + 1);

      MoveToEx(DC, x, y + 3, nil);
      LineTo(DC, x, y - 3);
      MoveToEx(DC, x+1, y + 3, nil);
      LineTo(DC, x+1, y - 3);
    end;
begin
  LMDAdjustRect(ARect, 1, 1);
  x := (ARect.Right + ARect.Left) div 2 - 1;
  y := (ARect.Bottom + ARect.Top) div 2 - 1;
  lPen := CreatePen(PS_SOLID, 1, FBtnFrameColors[tbPushButtonHot]);
  lOldPen := SelectObject(DC, lPen);
  Draw;
  SelectObject(DC, lOldPen);
  DeleteObject(lPen);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawRadioBtn(DC: HDC; ARect: TRect; arb: TThemedButton);
var
  x, y, d1, d2: Integer;
  LR: TRect;
  lOldBrush, lBrush: HBRUSH;
  lPen, lOldPen: HPEN;
  LPoints: array[0..7] of TPoint;
  lExit: boolean;

begin
  lExit := false;
  if Assigned(FOnDrawCheckMark) then
    FOnDrawRadioBtn(Self, DC, aRect, arb, lExit);
  if not lExit then
  begin
    LMDAdjustRect(ARect, 1, 1);
    LR := ARect;
    LMDAdjustRect(LR, -1, -1);

    lBrush := CreateSolidBrush(FBtnFillColors[arb, ciStart]);
    lPen := CreatePen(PS_SOLID, 1, FBtnFrameColors[arb]);
    x := (LR.Right + LR.Left) div 2;
    y := (LR.Bottom + LR.Top) div 2;
    d1 := 6;
    d2 := 2;
    lOldBrush := SelectObject(DC, lBrush);
    lOldPen := SelectObject(DC, lPen);
    LPoints[0] := LMDPoint(x-d1, y-d2);
    LPoints[1] := LMDPoint(x-d2, y-d1);
    LPoints[2] := LMDPoint(x+d2, y-d1);
    LPoints[3] := LMDPoint(x+d1, y-d2);
    LPoints[4] := LMDPoint(x+d1, y+d2);
    LPoints[5] := LMDPoint(x+d2, y+d1);
    LPoints[6] := LMDPoint(x-d2, y+d1);
    LPoints[7] := LMDPoint(x-d1, y+d2);

    Polygon(DC, LPoints, High(LPoints) + 1);
    SelectObject(DC, lOldBrush);
    DeleteObject(lBrush);

    LR.Left := (ARect.Right + ARect.Left) div 2  - 3;
    LR.Right := LR.Left + 5;
    LR.Top := (ARect.Bottom + ARect.Top) div 2 - 3;
    LR.Bottom := LR.Top + 5;

    if arb in [tbRadioButtonCheckedNormal, tbRadioButtonCheckedHot, tbRadioButtonCheckedPressed, tbRadioButtonCheckedDisabled] then
      begin
        lBrush := CreateSolidBrush(FBtnFrameColors[arb]);
        lOldBrush := SelectObject(DC, lBrush);
        Ellipse(DC, LR.Left, LR.Top, LR.Right, LR.Bottom);
        SelectObject(DC, lOldBrush);
        DeleteObject(lBrush);
      end;

    SelectObject(DC, lOldPen);
    DeleteObject(lPen);
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDBaseSGThemeRenderer.Create;
var
  te: TThemedElement;
begin
  inherited;
  FEnabled := true;
  FIsUpdating := false;

  for te := low(TThemedElement) to high(TThemedElement) do
    with FMetaData[te] do
      begin
        DetailTypeInfo := nil;
        FillData := nil;
        FrameData := nil;
      end;

  FMetaData[teButton].DetailTypeInfo := TypeInfo(TThemedButton);
  FMetaData[teButton].FillData := @FBtnFillColors;
  FMetaData[teButton].FrameData := @FBtnFrameColors;

  FMetaData[teComboBox].DetailTypeInfo := TypeInfo(TThemedComboBox);
  FMetaData[teComboBox].FillData := @FComboboxColors;
  FMetaData[teComboBox].FrameData := @FComboboxFrameColors;

  FMetaData[teEdit].DetailTypeInfo := TypeInfo(TThemedEdit);
  FMetaData[teEdit].FillData := @FEditFillColors;
  FMetaData[teEdit].FrameData := @FEditFrameColors;

  FMetaData[teHeader].DetailTypeInfo := TypeInfo(TThemedHeader);
  FMetaData[teHeader].FillData := @FHeaderColors;
  FMetaData[teHeader].FrameData := @FHeaderFrameColors;

  FMetaData[teProgress].DetailTypeInfo := TypeInfo(TThemedProgress);
  FMetaData[teProgress].FillData := @FProgressColors;
  FMetaData[teProgress].FrameData := @FProgressFrameColors;

  FMetaData[teScrollBar].DetailTypeInfo := TypeInfo(TThemedScrollBar);
  FMetaData[teScrollBar].FillData := @FScrollBarFillColors;
  FMetaData[teScrollBar].FrameData := @FScrollBarFrameColors;

  FMetaData[teSpin].DetailTypeInfo := TypeInfo(TThemedSpin);
  FMetaData[teSpin].FillData := @FSpinBtnFillColors;
  FMetaData[teSpin].FrameData := @FSpinBtnFrameColors;

  FMetaData[teTab].DetailTypeInfo := TypeInfo(TThemedTab);
  FMetaData[teTab].FillData := @FTabColors;

  FMetaData[teToolbar].DetailTypeInfo := TypeInfo(TThemedToolbar);
  FMetaData[teToolbar].FillData := @FToolbarFillColors;
  FMetaData[teToolbar].FrameData := @FToolbarFrameColors;

  FMetaData[teTrackbar].DetailTypeInfo := TypeInfo(TThemedTrackBar);
  FMetaData[teTrackbar].FillData := @FTrackbarFillColors;
  FMetaData[teTrackbar].FrameData := @FTrackbarFrameColors;

  FMetaData[teStatus].DetailTypeInfo := TypeInfo(TThemedStatus);
  FMetaData[teStatus].FillData := @FStatusBarFillColors;
  FMetaData[teStatus].FrameData := @FStatusBarFrameColors;
end;

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.ActivateColorScheme(
  AColorScheme: string; ADoApply: boolean = true): boolean;
var
  ltb: TThemedButton;
  ltmi: TThemedMenu;
  ltcb: TThemedCombobox;
  lte: TThemedEdit;
  ltt: TThemedTab;
  ltbr: TThemedToolBar;
  lts: TThemedSpin;
  lpb: TThemedProgress;
  lsb: TThemedScrollBar;
  lth : TThemedHeader;
  ltrb: TThemedTrackBar;
  lcolorindex: TLMDColorIndex;
  lcolorindex2: TLMDColorIndex;
  ltst: TThemedStatus;
  te: TThemedElement;
  lc: TColor;
  i: integer;
begin
  FColorScheme := csUnknown;
  if SameText(AColorScheme, CBuiltInColorSchemes[csBlue]) then
    FColorScheme := csBlue;
  if SameText(AColorScheme, CBuiltInColorSchemes[csMetallic]) then
      FColorScheme := csMetallic;
  if SameText(AColorScheme, CBuiltInColorSchemes[csHomestead]) then
    FColorScheme := csHomestead;
  if SameText(AColorScheme, CBuiltInColorSchemes[csVistaBasic]) then
    FColorScheme := csVistaBasic;

  if FColorScheme = csUnknown then
    FColorSchemeName := aColorScheme
  else
    FColorSchemeName := CBuiltInColorSchemes[FColorScheme];

  for te := low(TThemedElement) to high(TThemedElement) do
    begin
      FGradientSettings[te].CountType := gccCalculated;
      FGradientSettings[te].CalcDivizor := 2;
      FGradientSettings[te].FixedNumber := 16;
      FGradientSettings[te].GradientStyle := gstVertical;
    end;

  for ltb := low(TThemedButton) to high(TThemedButton) do
    begin
      for lcolorindex := low(TLMDColorIndex) to high(TLMDColorIndex) do
        FBtnFillColors[ltb, lcolorindex] := clNone;
      FBtnFrameColors[ltb] := clNone;
    end;

  for ltmi := low(TThemedMenu) to high(TThemedMenu) do
    FMenuItemFrameColors[ltmi] := clNone;

  if FColorScheme in [csBlue, csMetallic, csHomestead] then
    begin
      FBtnFillColors[tbPushButtonPressed, ciStart] := $4E91FE;
      FBtnFillColors[tbPushButtonPressed, ciEnd] := $8ED3FF;
      FBtnFillColors[tbPushButtonHot, ciStart] := $CCF4FF;
      FBtnFillColors[tbPushButtonHot, ciEnd] := $91D0FF;
    end;

  //button fill colors
  case FColorScheme of
    csBlue:
      begin
        FBtnFillColors[tbPushButtonNormal, ciStart] := $FEECDD;
        FBtnFillColors[tbPushButtonNormal, ciEnd] := $E2A981;
      end;
    csMetallic:
      begin
        FBtnFillColors[tbPushButtonNormal, ciStart] := $FAF4F3;
        FBtnFillColors[tbPushButtonNormal, ciEnd] := $B59799;
      end;
    csHomestead:
      begin
        FBtnFillColors[tbPushButtonNormal, ciStart] := $DEF7F4;
        FBtnFillColors[tbPushButtonNormal, ciEnd] := $91C6B7;
      end;
    csVistaBasic:
      begin
        FBtnFillColors[tbPushButtonNormal, ciStart] := $F0F0F0;
        FBtnFillColors[tbPushButtonNormal, ciEnd] := $E9E9E9;
        FBtnFillColors[tbPushButtonPressed, ciStart] := 16511713;
        FBtnFillColors[tbPushButtonPressed, ciEnd] := 14662002;
        FBtnFillColors[tbPushButtonHot, ciStart] := 16643816;
        FBtnFillColors[tbPushButtonHot, ciEnd] := 16178089;
      end;
    csUnknown:
      begin
        FBtnFillColors[tbButtonRoot, ciStart] := $ECE9D8;
        FBtnFillColors[tbButtonRoot, ciEnd] := $ECE9D8;

        FBtnFillColors[tbPushButtonNormal, ciStart] := $ECE9D8;
        FBtnFillColors[tbPushButtonNormal, ciEnd] := $ECE9D8;

        FBtnFillColors[tbPushButtonPressed, ciStart] := clHighlight;
        FBtnFillColors[tbPushButtonPressed, ciEnd] := clHighlight;
        FBtnFillColors[tbPushButtonHot, ciStart] := clHighlight;
        FBtnFillColors[tbPushButtonHot, ciEnd] := clHighlight;
        //Selected Hot
        //FBtnFillColors[tbPushButtonDefaulted, ciStart] := clHighlight;
        //FBtnFillColors[tbPushButtonDefaulted, ciEnd] := clHighlight;
      end;
  end;

  //menu item frame colors
  case FColorScheme of
    csBlue:
      for ltmi := low(TThemedMenu) to high(TThemedMenu) do
        FMenuItemFrameColors[ltmi] := $800000;
    csMetallic:
      for ltmi := low(TThemedMenu) to high(TThemedMenu) do
        FMenuItemFrameColors[ltmi] := $6F4B4B;
    csHomeStead:
      for ltmi := low(TThemedMenu) to high(TThemedMenu) do
        FMenuItemFrameColors[ltmi] := $385D3F;
    csVistabasic:
      for ltmi := low(TThemedMenu) to high(TThemedMenu) do
        FMenuItemFrameColors[ltmi] := $86787D;
    csUnknown:
      for ltmi := low(TThemedMenu) to high(TThemedMenu) do
        FMenuItemFrameColors[ltmi] := clHighlight;
  end;

  //button frame colors
  for ltb := low(TThemedButton) to high(TThemedButton) do
    if not (ltb in [tbPushButtonNormal, tbPushButtonDisabled]) then
       FBtnFrameColors[ltb] := FMenuItemFrameColors[tmMenuItemNormal];

  //checkbox and radiobutton colors
  for ltb := tbRadioButtonUncheckedNormal to tbCheckBoxMixedDisabled do
    begin
      FBtnFillColors[ltb, ciStart] := clWhite;
      FBtnFillColors[ltb, ciEnd] := clWhite;
      if ltb in [tbRadioButtonUncheckedHot, tbRadioButtonCheckedHot,
                 tbCheckBoxUncheckedHot, tbCheckBoxCheckedHot,
                 tbCheckBoxMixedHot] then
        begin
          FBtnFillColors[ltb, ciStart] := FBtnFillColors[tbPushButtonHot, ciStart];
          FBtnFillColors[ltb, ciEnd] := FBtnFillColors[tbPushButtonHot, ciEnd];
        end;
      if ltb in [tbRadioButtonUncheckedPressed, tbRadioButtonCheckedPressed,
                 tbCheckBoxUncheckedPressed, tbCheckBoxCheckedPressed,
                 tbCheckBoxMixedPressed] then
        begin
          FBtnFillColors[ltb, ciStart] := FBtnFillColors[tbPushButtonPressed, ciStart];
          FBtnFillColors[ltb, ciEnd] := FBtnFillColors[tbPushButtonPressed, ciStart];
        end;
      if ltb in [tbRadioButtonCheckedNormal,
                 tbCheckBoxCheckedNormal,
                 tbCheckBoxMixedNormal] then
        begin
          FBtnFillColors[ltb, ciStart] := FBtnFillColors[tbPushButtonPressed, ciEnd];
          FBtnFillColors[ltb, ciEnd] := FBtnFillColors[tbPushButtonPressed, ciEnd];
        end;
      if ltb in [tbRadioButtonUncheckedDisabled, tbRadioButtonCheckedDisabled, tbCheckBoxUncheckedDisabled,
                 tbCheckBoxCheckedDisabled, tbCheckBoxMixedDisabled] then
        begin
          FBtnFillColors[ltb, ciStart] := $E8E8E8;//$ECE9D8;
          FBtnFillColors[ltb, ciEnd] := $E8E8ED8;//$ECE9D8;
          FBtnFrameColors[ltb] := $99ACA8;
        end;
    end;

  //initialize edit colors
  for lte := low(TThemedEdit) to high(TThemedEdit) do
    begin
      for lcolorindex := ciStart to ciEnd do
        begin
          FEditFillColors[lte, lcolorindex] := clWhite;
        end;
      FEditFrameColors[lte] := FMenuItemFrameColors[tmMenuItemNormal];
    end;

  //toolbar colors, enabled/disabled text colors, pagecontrol colors
  if FColorScheme <> csUnknown then
    FDisabledTextColor := $8D8D8D
  else
    FDisabledTextColor := clGray;

  for ltbr :=low(TThemedToolBar) to high(TThemedToolBar) do
  begin
    if ltbr = ttbButtonNormal then
      begin
        FToolbarFillColors[ltbr, ciStart] := clNone;
        FToolbarFillColors[ltbr, ciEnd] := clNone;
        FToolbarFrameColors[ltbr] := clNone;
        FToolbarFrameColors[ltbr] := clNone;
        continue;
      end;

    if ltbr in [ttbToolBarDontCare,ttbToolBarRoot] then
       FToolbarFrameColors[ltbr] := clNone
    else
      case FColorScheme of
        csBlue:
          FToolbarFrameColors[ltbr] := $9C613B;
        csMetallic:
          FToolbarFrameColors[ltbr] := $947C7C;
        csHomeStead:
           FToolbarFrameColors[ltbr] := $588060;
       csVistaBasic:
          FToolbarFrameColors[ltbr] := $CACACA;
        csUnknown:
          FToolbarFrameColors[ltbr] := $ECE9D8;
      end;

    i := 0;
    if ltbr in [ttbButtonNormal..ttbButtonDisabled,
                ttbDropDownButtonNormal..ttbDropDownButtonDisabled,
                ttbSplitButtonNormal..ttbSplitButtonDisabled,
                ttbSplitButtonDropDownNormal..ttbSplitButtonDropDownDisabled] then
      begin
        if (ltbr in [ttbButtonNormal..ttbButtonDisabled]) then
           i := ord(ttbButtonNormal);
        if (ltbr in [ttbDropDownButtonNormal..ttbDropDownButtonDisabled]) then
           i := ord(ttbDropDownButtonNormal);
        if (ltbr in [ttbSplitButtonNormal..ttbSplitButtonDisabled]) then
           i := ord(ttbSplitButtonNormal);
        if (ltbr in [ttbSplitButtonDropDownNormal..ttbSplitButtonDropDownDisabled]) then
           i := ord(ttbSplitButtonDropDownNormal);
        //FToolbarFrameColors[ltbr] := FBtnFrameColors[TThemedButton(ord(ltbr) - i + ord(tbPushButtonNormal))];
        if ltbr in [ttbButtonNormal, ttbDropDownButtonNormal, ttbSplitButtonNormal, ttbSplitButtonDropDownNormal] then
          begin
            FToolbarFillColors[ltbr, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciEnd];
            FToolbarFillColors[ltbr, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciStart];
          end
        else
          begin
            FToolbarFillColors[ltbr, ciStart] := FBtnFillColors[TThemedButton(ord(ltbr) - i + ord(tbPushButtonNormal)), ciStart];
            FToolbarFillColors[ltbr, ciEnd] := FBtnFillColors[TThemedButton(ord(ltbr) - i + ord(tbPushButtonNormal)), ciEnd];
          end;
      end
    else
      case FColorScheme of
        csBlue:
          begin
            FToolbarFillColors[ltbr, ciStart] := $FEECDD;
            FToolbarFillColors[ltbr, ciEnd] := $E2A981;
            FEnabledTextColor := $962D00;
            FDisabledTextColor := $8D8D8D;
          end;
        csMetallic:
          begin
            FToolbarFillColors[ltbr, ciStart] := $FAF4F3;
            FToolbarFillColors[ltbr, ciEnd] := $B59799;
            FEnabledTextColor := $947C7C;
          end;
        csHomeStead:
          begin
            FToolbarFillColors[ltbr, ciStart] := $DEF7F4;
            FToolbarFillColors[ltbr, ciEnd] := $91C6B7;
            FEnabledTextColor := $5E8D75;
          end;
        csVistaBasic:
          begin
            FToolbarFillColors[ltbr, ciStart] := $F0F0F0;
            FToolbarFillColors[ltbr, ciEnd] := $E9E9E9;
            FEnabledTextColor := $86787D;
          end;
        csUnknown:
          begin
            FToolbarFillColors[ltbr, ciStart] := $ECE9D8;
            FToolbarFillColors[ltbr, ciEnd] := $ECE9D8;
            FEnabledTextColor := clBlack;
          end;
      end;
  end;
  for ltt := low(TThemedTab) to high(TThemedTab) do
    begin
      FTabColors[ltt, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciEnd];
      FTabColors[ltt, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciStart];
      if ltt in [ttTopTabItemLeftEdgeNormal{, ttTopTabItemLeftEdgeHot, ttTopTabItemLeftEdgeSelected, ttTopTabItemLeftEdgeDisabled, ttTopTabItemLeftEdgeFocused,
                 ttTopTabItemRightEdgeNormal, ttTopTabItemRightEdgeHot, ttTopTabItemRightEdgeSelected, ttTopTabItemRightEdgeDisabled, ttTopTabItemRightEdgeFocused,
                 ttTopTabItemBothEdgeNormal, ttTopTabItemBothEdgeHot, ttTopTabItemBothEdgeSelected, ttTopTabItemBothEdgeDisabled, ttTopTabItemBothEdgeFocused}] then
        begin
          FTabColors[ltt, ciStart] := FBtnFrameColors[tbPushButtonHot];
          FTabColors[ltt, ciEnd] := FBtnFrameColors[tbPushButtonHot];
        end;
    end;

  FTabColors[ttPane, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciEnd];
  FTabColors[ttPane, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciEnd];

  FTabColors[ttTopTabItemHot, ciStart] := FBtnFillColors[tbPushButtonHot, ciStart];
  FTabColors[ttTopTabItemHot, ciEnd] := FBtnFillColors[tbPushButtonHot, ciEnd];

  FTabColors[ttTopTabItemSelected, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciStart];
  FTabColors[ttTopTabItemSelected, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciEnd];

  //combobox colors
  for ltcb := low(TThemedComboBox) to high(TThemedComboBox) do
    begin
      for lcolorindex := low(TLMDColorIndex) to high(TLMDColorIndex) do
        if ltcb <= tcComboBoxRoot then
          FComboboxColors[ltcb, lcolorindex] := clWhite
        else
          FComboboxColors[ltcb, lcolorindex] := FBtnFillColors[TThemedButton(ord(ltcb)), lcolorindex];
      if ltcb in [{tcComboBoxDontCare, tcComboBoxRoot,} tcDropDownButtonHot,  tcDropDownButtonPressed] then
        FComboboxFrameColors[ltcb] := FBtnFrameColors[tbPushButtonHot]
      else
        FComboboxFrameColors[ltcb] := clWhite;
    end;

  FComboboxColors[tcDropDownButtonNormal, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciStart];
  FComboboxColors[tcDropDownButtonNormal, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciEnd];

  //<-- spinbutton colors
  for lts := low(TThemedSpin) to high(TThemedSpin) do
    for lcolorindex := low(TLMDColorIndex) to high(TLMDColorIndex) do
      FSpinBtnFillColors[lts, lcolorindex] := clNone;

  for ltb := tbPushButtonNormal to tbPushButtonPressed do
    begin
      for lcolorindex := low(TLMDColorIndex) to high(TLMDColorIndex) do
        begin
          FSpinBtnFillColors[TThemedSpin(ord(tsUpNormal) + ord(ltb) - ord(tbPushButtonNormal)), lcolorindex] := FBtnFillColors[ltb, lcolorindex];
          FSpinBtnFillColors[TThemedSpin(ord(tsDownNormal) + ord(ltb) - ord(tbPushButtonNormal)), lcolorindex] := FBtnFillColors[ltb, lcolorindex];
          FSpinBtnFillColors[TThemedSpin(ord(tsUpHorzNormal) + ord(ltb) - ord(tbPushButtonNormal)), lcolorindex] := FBtnFillColors[ltb, lcolorindex];
          FSpinBtnFillColors[TThemedSpin(ord(tsDownHorzNormal) + ord(ltb) - ord(tbPushButtonNormal)), lcolorindex] := FBtnFillColors[ltb, lcolorindex];
        end;
      FSpinBtnFrameColors[TThemedSpin(ord(tsUpNormal) + ord(ltb) - ord(tbPushButtonNormal))] := FBtnFrameColors[ltb];
      FSpinBtnFrameColors[TThemedSpin(ord(tsDownNormal) + ord(ltb) - ord(tbPushButtonNormal))] := FBtnFrameColors[ltb];
    end;
  //-->

  //<-- scrollbar colors
  for lsb := low(TThemedScrollBar) to high(TThemedScrollBar) do
    for lcolorindex := low(TLMDColorIndex) to high(TLMDColorIndex) do
      if lsb in [tsArrowBtnUpDisabled, tsArrowBtnDownDisabled, tsArrowBtnLeftDisabled, tsArrowBtnRightDisabled] then
        FScrollBarFillColors[lsb, lcolorindex] := $E8E8E8
      else
        FScrollBarFillColors[lsb, lcolorindex] := clNone;

  for ltb := tbPushButtonNormal to tbPushButtonPressed do
    begin
    for lcolorindex := low(TLMDColorIndex) to high(TLMDColorIndex) do
      begin
        if ltb = tbPushButtonNormal then
          lc := FToolbarFillColors[ttbToolBarRoot, ciEnd]
        else
          lc := FBtnFillColors[ltb, lcolorindex];
        FScrollBarFillColors[TThemedScrollBar(ord(tsArrowBtnUpNormal) + ord(ltb) - ord(tbPushButtonNormal)), lcolorindex] := lc;
        FScrollBarFillColors[TThemedScrollBar(ord(tsArrowBtnDownNormal) + ord(ltb) - ord(tbPushButtonNormal)), TLMDColorIndex(ord(high(TLMDColorIndex)) - ord(lcolorindex))] := lc;
        FScrollBarFillColors[TThemedScrollBar(ord(tsArrowBtnLeftNormal) + ord(ltb) - ord(tbPushButtonNormal)), lcolorindex] := lc;
        FScrollBarFillColors[TThemedScrollBar(ord(tsArrowBtnRightNormal) + ord(ltb) - ord(tbPushButtonNormal)), TLMDColorIndex(ord(high(TLMDColorIndex)) - ord(lcolorindex))] := lc;
      end;
        FScrollBarFillColors[TThemedScrollBar(ord(tsThumbBtnHorzNormal) + ord(ltb) - ord(tbPushButtonNormal)), ciStart] := lc;
        FScrollBarFillColors[TThemedScrollBar(ord(tsThumbBtnVertNormal) + ord(ltb) - ord(tbPushButtonNormal)), ciStart] := lc;
        FScrollBarFillColors[TThemedScrollBar(ord(tsThumbBtnHorzNormal) + ord(ltb) - ord(tbPushButtonNormal)), ciEnd] := lc;
        FScrollBarFillColors[TThemedScrollBar(ord(tsThumbBtnVertNormal) + ord(ltb) - ord(tbPushButtonNormal)), ciEnd] := lc;
      end;
  for lsb := tsLowerTrackHorzNormal to tsUpperTrackVertDisabled do
    if lsb in [tsLowerTrackHorzHot, tsUpperTrackHorzHot, tsLowerTrackVertHot, tsUpperTrackVertHot] then
      begin
        FScrollBarFillColors[lsb, ciStart] := LMDColorLighter(FToolbarFillColors[ttbToolBarRoot, ciStart], 50);
        FScrollBarFillColors[lsb, ciEnd] := LMDColorLighter(FToolbarFillColors[ttbToolBarRoot, ciStart], 50);
      end
    else
      begin
        FScrollBarFillColors[lsb, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciStart];
        FScrollBarFillColors[lsb, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciStart];
      end;
  for lsb := low(TThemedScrollBar) to high(TThemedScrollBar) do
    FScrollBarFrameColors[lsb] := FBtnFrameColors[tbPushButtonHot];
  //-->

  //<-- Progressbar Colors
  for lpb := low(TThemedProgress) to high(TThemedProgress) do
    begin
      FProgressFrameColors[lpb] := FBtnFrameColors[tbPushButtonHot];
      for lcolorindex := low(TLMDColorIndex) to high(TLMDColorIndex) do
         FProgressColors[lpb, lcolorindex] := clWhite;
    end;

  FProgressColors[tpChunk, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciStart];
  FProgressColors[tpChunk, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciEnd];
  FProgressFrameColors[tpChunk] := FBtnFrameColors[tbPushButtonHot];

  FProgressColors[tpChunkVert, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciStart];
  FProgressColors[tpChunkVert, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciEnd];
  FProgressFrameColors[tpChunkVert] := FBtnFrameColors[tbPushButtonHot];
  //-->

  //<-- Header colors
  for lth := thHeaderDontCare to thHeaderSortArrowSortedDown do
    begin
      for lcolorindex := low(TLMDColorIndex) to high(TLMDColorIndex) do
        FHeaderColors[lth, lcolorindex] := clNone;
      FHeaderFrameColors[lth] := FBtnFrameColors[tbPushButtonHot];
    end;
  FHeaderColors[thHeaderItemNormal, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciStart];
  FHeaderColors[thHeaderItemNormal, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciEnd];
  FHeaderColors[thHeaderItemHot, ciStart] := FBtnFillColors[tbPushButtonHot, ciStart];
  FHeaderColors[thHeaderItemHot, ciEnd] := FBtnFillColors[tbPushButtonHot, ciEnd];
  FHeaderColors[thHeaderItemPressed, ciStart] := FBtnFillColors[tbPushButtonPressed, ciStart];
  FHeaderColors[thHeaderItemPressed, ciEnd] := FBtnFillColors[tbPushButtonPressed, ciEnd];

  FHeaderColors[thHeaderSortArrowSortedUp, ciStart] := FHeaderFrameColors[thHeaderItemNormal];
  FHeaderColors[thHeaderSortArrowSortedUp, ciEnd] := FHeaderFrameColors[thHeaderItemNormal];
  FHeaderColors[thHeaderSortArrowSortedDown, ciStart] := FHeaderFrameColors[thHeaderItemNormal];
  FHeaderColors[thHeaderSortArrowSortedDown, ciEnd] := FHeaderFrameColors[thHeaderItemNormal];
  //-->

  //<-- TrackBar colors
  for ltrb := low(ttbTrackBarDontCare) to high(ttbThumbRightDisabled) do
    begin
      for lcolorindex := low(TLMDColorIndex) to high(TLMDColorIndex) do
        begin
          FTrackBarFillColors[ltrb, lcolorindex] := clNone;
          if ltrb in [ttbThumbTics, ttbThumbTicsVert] then
            FTrackBarFillColors[ltrb, lcolorindex] := FMenuItemFrameColors[tmMenuItemNormal];
        end;
      if ltrb in [ttbThumbNormal, ttbThumbBottomNormal, ttbThumbTopNormal, ttbThumbVertNormal, ttbThumbLeftNormal, ttbThumbRightNormal] then
        begin
          FTrackBarFillColors[ltrb, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciStart];
          FTrackBarFillColors[ltrb, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciEnd];
        end;
      if ltrb in [ttbThumbTopNormal, ttbThumbLeftNormal] then
        begin
          FTrackBarFillColors[ltrb, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciEnd];
          FTrackBarFillColors[ltrb, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciStart];
        end;
    end;
  FTrackBarFillColors[ttbTrack, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciStart];
  FTrackBarFillColors[ttbTrack, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciEnd];
  FTrackBarFillColors[ttbTrackVert, ciStart] := FToolbarFillColors[ttbToolBarRoot, ciEnd];
  FTrackBarFillColors[ttbTrackVert, ciEnd] := FToolbarFillColors[ttbToolBarRoot, ciStart];

  for ltrb := ttbThumbHot to ttbThumbDisabled do
    for lcolorindex := low(TLMDColorIndex) to high(TLMDColorIndex) do
      begin
        if ltrb = ttbThumbFocused then
          ltb := tbPushButtonPressed
        else
          if ltrb = ttbThumbDisabled then
            ltb := tbPushButtonDisabled
          else
            ltb := TThemedButton(ord(tbPushButtonHot) + ord(ltrb) - ord(ttbThumbHot));

        if lcolorindex = ciStart then
          lcolorindex2 := ciEnd
        else
          lcolorindex2 := ciStart;

        FTrackBarFillColors[ltrb, lcolorindex] := FBtnFillColors[ltb, lcolorindex];
        FTrackBarFillColors[TThemedTrackBar(ord(ttbThumbBottomHot) + ord(ltrb) - ord(ttbThumbHot)), lcolorindex] := FBtnFillColors[ltb, lcolorindex];
        FTrackBarFillColors[TThemedTrackBar(ord(ttbThumbTopHot) + ord(ltrb) - ord(ttbThumbHot)), lcolorindex] := FBtnFillColors[ltb, lcolorindex2];
        FTrackBarFillColors[TThemedTrackBar(ord(ttbThumbVertHot) + ord(ltrb) - ord(ttbThumbHot)), lcolorindex] := FBtnFillColors[ltb, lcolorindex];
        FTrackBarFillColors[TThemedTrackBar(ord(ttbThumbLeftHot) + ord(ltrb) - ord(ttbThumbHot)), lcolorindex] := FBtnFillColors[ltb, lcolorindex2];
        FTrackBarFillColors[TThemedTrackBar(ord(ttbThumbRightHot) + ord(ltrb) - ord(ttbThumbHot)), lcolorindex] := FBtnFillColors[ltb, lcolorindex];
      end;
  //-- TrackBar colors -->

  //<-- StatusBar colors
  for ltst := tsStatusDontCare to tsGripper do
    begin
      FStatusBarFillColors[ltst, ciStart] := ToolBarFillColors[ttbToolBarRoot, ciStart];
      FStatusBarFillColors[ltst, ciEnd] := ToolBarFillColors[ttbToolBarRoot, ciEnd];      
    end;

  //-->

  result := true;
  FEnabled := true;
  if ADoApply then
    LMDThemeServices.ApplyThemeChange;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.ActivateDefaultTheme(AColorScheme: string;
  aDoApply: boolean): boolean;
begin
  result := ActivateTheme('Office2003', 'Blue');
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.ActivateTheme(AFileName: string;
  AColorScheme: String): boolean;
begin
  result := false;
  if SameText(AFileName, CSimpleGradientThemeNames[sgtOffice2003]) then
    begin
      FTheme := sgtOffice2003;
      result := ActivateColorScheme(AColorScheme);
    end
  else
    if FileExists(AFileName) then
      begin
        FTheme := sgtCustom;
        result := LoadThemeFromFile(AFileName, AColorScheme);
      end
    else
      FTheme := sgtUnknown;
  if FTheme <> sgtCustom then
    FThemeName := CSimpleGradientThemeNames[FTheme];
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.ContentRect(DC: HDC;
  Details: TThemedElementDetails; BoundingRect: TRect): TRect;
var
  scb: TThemedScrollBar;
begin
  result := BoundingRect;
  if Details.Element in [teEdit, teTab] then
    InflateRect(result, -1, -1);

  if Details.Element = teScrollBar then
    begin
      scb := TThemedScrollBar(LMDThemeServices.GetDetailOrd(Details));
      if scb in [tsGripperHorzNormal..tsGripperVertDisabled] then
        InflateRect(result, -4, -4);
    end;

  //has no effect
  //if (Details.Element = teCombobox) and (Details.Part <> CP_DROPDOWNBUTTON) then
  //  InflateRect(result, 1, 1);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedStatus; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedStatus; const R: TRect; ClipRect: TLMDRectPtr);
var
  lR: TRect;
  i, j: integer;
  lPen, lOldPen: HPEN;
  lCr: TLMDRectPtr;
begin
  lR := R;
  lCr := ClipRect;

  if Detail <> tsGripperPane then
    begin
      InflateRect(lR, 0, -1);
      if ClipRect <> LMDNullRectPtr then
        InflateRect(lCR^, 0, -1);
    end;

  if Detail = tsGripper then
    begin
      InflateRect(lR, -1, -1);
      OffsetRect(lR, -1, 0);
      lPen := CreatePen(PS_SOLID, 1, FStatusBarFrameColors[Detail]);
      lOldPen := SelectObject(DC, lPen);
      for i := 0 to 4 do
        for j := 0 to i do
          begin
            MoveToEx(DC, lR.Right - 8 + i * 2, lR.Bottom - j * 2, nil);
            LineTo(DC, lR.Right - 8 + i * 2, lR.Bottom - j * 2 - 1);
          end;
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end
  else
    DrawGradientFramedRect(DC, lR, lCr, FStatusBarFillColors[Detail, ciStart], FStatusBarFillColors[Detail, ciEnd], FStatusBarFrameColors[Detail], gstVertical, 0, [])
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedScrollBar; const R: TRect; ClipRect: TLMDRectPtr);
var
  gs: TLMDGradientStyle;
  lr: TRect;
begin
  lr := r;
  //LMDAdjustRect(lr, 1, 1);
  //lr.right := lr.right + 1;
  if Detail in [tsArrowBtnUpNormal..tsArrowBtnDownDisabled, tsLowerTrackHorzNormal..tsUpperTrackHorzDisabled] then
    gs := gstVertical
  else
    if Detail in [tsArrowBtnLeftNormal..tsArrowBtnRightDisabled,tsLowerTrackVertNormal..tsUpperTrackVertDisabled] then
      gs := gstHorizontal
    else
      gs := FGradientSettings[teScrollBar].GradientStyle;

  if not (Detail in [tsGripperHorzNormal, tsGripperHorzHot, tsGripperHorzPressed, tsGripperHorzDisabled,
    tsGripperVertNormal, tsGripperVertHot, tsGripperVertPressed, tsGripperVertDisabled]) then
    //any part except grip on the thumb button
    begin
      //lR :=R;
      //lr.Bottom := lr.Bottom + 1;
      DrawGradientFramedRect(DC, lR, ClipRect, FScrollBarFillColors[Detail, ciStart], FScrollBarFillColors[Detail, ciEnd], FScrollBarFrameColors[Detail], gs, 0, AllFrameSides)
    end
  else
    //grip
    begin
      DrawScrollThumbGripper(DC, R, Detail);
    end;

  case Detail of
    tsArrowBtnUpNormal..tsArrowBtnUpDisabled:
      DrawArrow(DC, R, tdUp);
    tsArrowBtnDownNormal..tsArrowBtnDownDisabled:
      DrawArrow(DC, R, tdDown);
    tsArrowBtnLeftNormal..tsArrowBtnLeftDisabled:
      DrawArrow(DC, R, tdLeft);
    tsArrowBtnRightNormal..tsArrowBtnRightDisabled:
      DrawArrow(DC, R, tdRight);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC; Detail: TThemedSpin;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC; Detail: TThemedSpin;
  const R: TRect; ClipRect: TLMDRectPtr);
var
  LR: TRect;
  lts_base: TThemedSpin;
  lCr: TLMDRectPtr;
begin
  LR := R;
  InflateRect(LR, -1 , -1);
  lCr := ClipRect;
  if ClipRect <> LMDNullRectPtr then
    InflateRect(lCR^, -1, -1);

  lts_base := Detail;
  if Detail in [tsUpNormal, tsUpHot, tsUpPressed, tsUpDisabled]  then
    lts_base := tsUpNormal
  else
    if Detail in [tsDownNormal, tsDownHot, tsDownPressed, tsDownDisabled]  then
      lts_base := tsDownNormal
    else
      if Detail in [tsUpHorzNormal, tsUpHorzHot, tsUpHorzPressed, tsUpHorzDisabled]  then
        lts_base := tsUpHorzNormal
      else
        if Detail in [tsDownHorzNormal, tsDownHorzHot, tsDownHorzPressed, tsDownHorzDisabled]  then
          lts_base := tsDownHorzNormal;
  DrawGradientFramedRect(DC, LR, ClipRect, FSpinBtnFillColors[Detail, ciStart], FSpinBtnFillColors[Detail, ciEnd], FSpinBtnFrameColors[Detail], FGradientSettings[teSpin].GradientStyle, 0, AllFrameSides);
  case lts_base of
    tsUpNormal: DrawArrow(DC, R, tdUp);
    tsDownNormal: DrawArrow(DC, R, tdDown);
    tsUpHorzNormal: DrawArrow(DC, R, tdRight);
    tsDownHorzNormal: DrawArrow(DC, R, tdLeft);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC; Detail: TThemedTab;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedToolTip; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedToolTip; const R: TRect; ClipRect: TLMDRectPtr);
begin
  raise Exception.CreateFmt(IDS_LMDTHEMES_ELEMENTNOTSUPPORTED, ['TThemedToolTip', GetThemeRendererName]);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedToolBar; const R: TRect; ClipRect: TLMDRectPtr);
var
  lR: TRect;
  lFs: TLMDFrameSides;
  lPen, lOldPen: HPEN;
begin
  lR := R;

  lFs := AllFrameSides;
  if Detail in [ttbDropDownButtonHot..ttbDropDownButtonCheckedHot] then
    lFs := lFs - [fsLeft];
  if Detail in [ttbSplitButtonNormal..ttbSplitButtonCheckedHot] then
    begin
      lFs  := lFs - [fsRight];
      lR.Right := lR.Right + 1;
    end;
  if Detail in [ttbSplitButtonDropDownNormal..ttbSplitButtonDropDownCheckedHot] then
    lFs  := lFs - [fsLeft];

  if Detail in  [ttbSeparatorNormal..ttbSeparatorCheckedHot] then
    begin
      lPen := CreatePen(PS_SOLID, 1, FToolbarFillColors[Detail, ciEnd]);
      lOldPen := SelectObject(DC, lPen);
      MoveToEx(DC, lR.Left, lR.Top, nil);
      LineTo(DC, lR.Left, lR.Bottom);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
      lPen := CreatePen(PS_SOLID, 1, FToolbarFillColors[Detail, ciStart]);
      lOldPen := SelectObject(DC, lPen);
      MoveToEx(DC, lR.Left + 1, lR.Top, nil);
      LineTo(DC, lR.Left + 1, lR.Bottom);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end
  else
  if Detail in  [ttbSeparatorVertNormal..ttbSeparatorVertCheckedHot] then
    begin
      lPen := CreatePen(PS_SOLID, 1, FToolbarFillColors[Detail, ciEnd]);
      lOldPen := SelectObject(DC, lPen);
      MoveToEx(DC, lR.Left, lR.Top, nil);
      LineTo(DC, lR.Right, lR.Top);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
      lPen := CreatePen(PS_SOLID, 1, FToolbarFillColors[Detail, ciStart]);
      lOldPen := SelectObject(DC, lPen);
      MoveToEx(DC, lR.Left, lR.Top + 1, nil);
      LineTo(DC, lR.Right, lR.Top + 1);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end
  else
    DrawGradientFramedRect(DC, lR, ClipRect, FToolbarFillColors[Detail, ciStart], FToolbarFillColors[Detail, ciEnd], FToolbarFrameColors[Detail], FGradientSettings[teToolBar].GradientStyle, DSF_CLIPRECT, lFs);
  if Detail in [ttbDropDownButtonNormal..ttbDropDownButtonDisabled] then
    DrawArrow(DC, lR, tdDown);
  if Detail in [ttbSplitButtonDropDownNormal..ttbSplitButtonDropDownCheckedHot] then
    DrawArrow(DC, lR, tdDown);

end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC; Detail: TThemedTab;
  const R: TRect; ClipRect: TLMDRectPtr);
var
  lFs :TLMDFrameSides;
  LR: TRect;
begin
  lFs := AllFrameSides;
  case Detail of
    ttTopTabItemSelected, ttTopTabItemNormal, ttTopTabItemHot: lFs := lFs - [fsBottom];
  end;
  LR := R;
  if Detail in [ttTopTabItemNormal, ttTopTabItemHot] then
    LR.Right := LR.Right + 1;
  if Detail = ttTopTabItemSelected then
    LR.Bottom := LR.Bottom - 1;
  DrawGradientFramedRect(DC, LR, ClipRect, FTabColors[Detail, ciStart], FTabColors[Detail, ciEnd], FTabColors[ttTopTabItemLeftEdgeNormal, ciStart], FGradientSettings[teTab].GradientStyle, DSF_CLIPRECT, lFs);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedToolBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedComboBox; const R: TRect; ClipRect: TLMDRectPtr);
var
  LR: TRect;
begin
  LR := R;
  FillRect(DC, R, HBRUSH(FComboboxColors[tcComboBoxRoot, ciStart]));
  if (Detail <= tcComboBoxRoot) then
  begin
    if (Detail = tcComboBoxRoot) then
      DrawGradientFramedRect(DC, R, ClipRect, clNone, clNone, FComboboxFrameColors[tcDropDownButtonHot], FGradientSettings[teComboBox].GradientStyle, 0)
    else
      DrawGradientFramedRect(DC, R, ClipRect, clNone, clNone, FComboboxFrameColors[tcDropDownButtonNormal], FGradientSettings[teComboBox].GradientStyle, 0);
    exit;
  end;
  if Detail > tcComboBoxRoot then
    InflateRect(LR, 1, 1);
  DrawGradientFramedRect(DC, LR, ClipRect, FComboboxColors[Detail, ciStart], FComboboxColors[Detail, ciEnd], FComboboxFrameColors[Detail], FGradientSettings[teComboBox].GradientStyle, 0, AllFrameSides);
  DrawArrow(DC, LR, tdDown);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC; Detail: TThemedEdit;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedComboBox; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedButton; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedButton; const R: TRect; ClipRect: TLMDRectPtr);
var
  LR: TRect;
  lCr: TLMDRectPtr;
begin
  //Note: LMDSpeedButton.ButtonStyle must be ubsWin40Ext
  LR := R;
  lCr := ClipRect;
  if Detail in [tbButtonDontCare, tbButtonRoot, tbPushButtonNormal,
                tbPushButtonHot, tbPushButtonPressed,
               tbPushButtonDisabled, tbPushButtonDefaulted] then
    begin
      InflateRect(LR, -1 , -1);
      if lCr <> LMDNullRectPtr then
        InflateRect(lCR^, -1 , -1);
    end;

  if not (Detail in [tbRadioButtonUncheckedNormal..tbRadioButtonCheckedDisabled]) then
    DrawGradientFramedRect(DC, LR, lCr, FBtnFillColors[Detail, ciStart], FBtnFillColors[Detail, ciEnd], FBtnFrameColors[Detail], FGradientSettings[teButton].GradientStyle, 0);
  if Detail in [tbCheckBoxCheckedNormal..tbCheckBoxMixedDisabled] then
    DrawCheckMark(DC, LR, Detail);
  if Detail in [tbRadioButtonUncheckedNormal..tbRadioButtonCheckedDisabled] then
    DrawRadioBtn(DC, LR, Detail);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC; Detail: TThemedEdit;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  DrawGradientFramedRect(DC, R, ClipRect, FEditFillColors[Detail, ciStart], FEditFillColors[Detail, ciEnd], FEditFrameColors[Detail], FGradientSettings[teEdit].GradientStyle, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedProgress; const R: TRect; ClipRect: TLMDRectPtr);
var
  SR, LR: TRect;
  W, lW, c, i: integer;
begin
  LR := R;
  W := 10;
  if Detail in [tpChunk] then
    begin
      InflateRect(LR, -1, -2);
      if LR.Left >= LR.Right then
        exit;
      DrawGradientFramedRect(DC, LR, ClipRect, FProgressColors[Detail, ciStart], FProgressColors[Detail, ciEnd], clNone, gstHorizontal, 0);
      lW := (LR.Right - LR.Left) mod W;
      c := (LR.Right - LR.Left) div W;
      SR.Top := LR.Top;
      SR.Bottom := LR.Bottom;
      for i := 0 to c - 1 do
        begin
          SR.Left := LR.Left + W*i + 1;
          SR.Right := SR.Left + W - 1;
          DrawGradientFramedRect(DC, SR, ClipRect, clNone, clNone, FProgressFrameColors[Detail], gstVertical, 0);
        end;
      if lW <> 0 then
        begin
          SR.Left := LR.Left + W*c + 1;
          SR.Right := SR.Left + lW - 1;
          DrawGradientFramedRect(DC, SR, ClipRect, clNone, clNone, FProgressFrameColors[Detail], gstVertical, 0);
        end;
    end
  else
    if Detail in [tpChunkVert] then
      begin
        InflateRect(LR, -2, -1);
        if LR.Top >= LR.Bottom then
          exit;
        DrawGradientFramedRect(DC, LR, ClipRect, FProgressColors[Detail, ciStart], FProgressColors[Detail, ciEnd], clNone, gstVertical, 0);
        lW := (LR.Bottom - LR.Top) mod W;
        c := (LR.Bottom - LR.Top) div W;
        SR.Left := LR.Left;
        SR.Right := LR.Right;
        for i := 0 to c - 1 do
          begin
            SR.Top := LR.Top + W*i + 1;
            SR.Bottom := SR.Top + W - 1;
            DrawGradientFramedRect(DC, SR, ClipRect, clNone, clNone, FProgressFrameColors[Detail], gstHorizontal, 0);
          end;
        if lW <> 0 then
          begin
            SR.Top := LR.Top + W*c + 1;
            SR.Bottom := SR.Top + lW - 1;
            DrawGradientFramedRect(DC, SR, ClipRect, clNone, clNone, FProgressFrameColors[Detail], gstHorizontal, 0);
          end;
      end
    else
      DrawGradientFramedRect(DC, LR, ClipRect, FProgressColors[Detail, ciStart], FProgressColors[Detail, ciEnd], FProgressFrameColors[Detail], gstVertical, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedScrollBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedProgress; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedExplorerBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedExplorerBar; const R: TRect; ClipRect: TLMDRectPtr);
begin
  raise Exception.CreateFmt(IDS_LMDTHEMES_ELEMENTNOTSUPPORTED, ['TThemedExplorerBar', GetThemeRendererName]);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTrackBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedHeader; const R: TRect; ClipRect: TLMDRectPtr);
var
  lRect : TRect;
begin
  lRect := R;
  DrawGradientFramedRect(DC, lRect, ClipRect, FHeaderColors[Detail, ciStart], FHeaderColors[Detail, ciEnd],
    FHeaderFrameColors[Detail], FGradientSettings[teHeader].GradientStyle, 0, [fsRight, fsBottom])
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedHeader; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTreeview; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Details: TThemedElementDetails; const R: TRect; ClipRect: TLMDRectPtr);
begin
  with Details do
    case Element of
      teButton:
        DrawElement(DC, TThemedButton(LMDThemeServices.GetDetailOrd(Details)), R);
      teClock:;
      teComboBox:
        DrawElement(DC, TThemedCombobox(LMDThemeServices.GetDetailOrd(Details)), R);
      teEdit:
        DrawElement(DC, TThemedEdit(LMDThemeServices.GetDetailOrd(Details)), R);
      teExplorerBar:;
      teHeader:
        DrawElement(DC, TThemedHeader(LMDThemeServices.GetDetailOrd(Details)), R);
      teListView:;
      teMenu:;
      tePage:;
        //DrawElement(DC, LMDThemeServices.GetDetailOrd(Details)), R);

      teProgress:
        DrawElement(DC, TThemedProgress(LMDThemeServices.GetDetailOrd(Details)), R);
      teRebar:;
      teScrollBar:
        DrawElement(DC, TThemedScrollbar(LMDThemeServices.GetDetailOrd(Details)), R);
      teSpin:
        DrawElement(DC, TThemedSpin(LMDThemeServices.GetDetailOrd(Details)), R);
      teStartPanel:;
      teStatus:
        DrawElement(DC, TThemedStatus(LMDThemeServices.GetDetailOrd(Details)), R);
      teTab:
        DrawElement(DC, TThemedTab(LMDThemeServices.GetDetailOrd(Details)), R);
      teTaskBand:;
      teTaskBar:;
      teToolBar:
        DrawElement(DC, TThemedToolBar(LMDThemeServices.GetDetailOrd(Details)), R);
      teToolTip:;
      teTrackBar:
        DrawElement(DC, TThemedTrackBar(LMDThemeServices.GetDetailOrd(Details)), R);
      teTrayNotify:;
      teTreeview:
        DrawElement(DC, TThemedTreeView(LMDThemeServices.GetDetailOrd(Details)), R);
      teWindow:
        begin
          if Part = WP_SMALLCLOSEBUTTON then
            DrawElement(DC, TThemedWindow(LMDThemeServices.GetDetailOrd(Details)), R);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTreeview; const R: TRect; ClipRect: TLMDRectPtr);
begin
  case Detail of
    ttTreeviewDontCare:
      DrawGradientFramedRect(DC, R, ClipRect, FEditFillColors[teEditTextNormal, ciStart], FEditFillColors[teEditTextNormal, ciStart], FBtnFrameColors[tbPushButtonHot], gstVertical, 0, [fsLeft, fsRight, fsTop, fsBottom]);
    ttGlyphOpened:
      DrawMinus(DC, R, FBtnFrameColors[tbPushButtonHot]);
    ttGlyphClosed:
      DrawPlus(DC, R, FBtnFrameColors[tbPushButtonHot]);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedWindow; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTrackBar; const R: TRect; ClipRect: TLMDRectPtr);
var
  gs: TLMDGradientStyle;
  lfs:  TLMDFrameSides;
  lEdge: integer;
  lPen, lOldPen: HPEN;
  lBrush, lOldBrush: HBRUSH;
  lRect: TRect;
  lP: array[0..4] of TPoint;
  lColor: TColor;
begin
  lRect := R;
  lEdge := 0;
  if Detail in [ttbThumbLeftNormal..ttbThumbRightDisabled] then
    begin
      InflateRect(lRect, -1, -1);
      if (lRect.Bottom - lRect.Top) mod 2 <> 0 then
        Dec(lRect.Bottom);
      ledge := (lRect.Bottom - lRect.Top) div 2;
    end;
  if Detail in [ttbThumbBottomNormal..ttbThumbTopDisabled] then
    begin
      InflateRect(lRect, -1, -1);
      if (lRect.Right - lRect.Left) mod 2 <> 0 then
        begin
          Inc(lRect.Right);
          OffsetRect(lRect, -1, 0);
        end;
      lEdge := (lRect.Right - lRect.Left) div 2;
    end;
  lfs := [fsLeft, fsRight, fsTop, fsBottom];

  gs := gstVertical;

  if Detail in [ttbTrack,
                ttbThumbNormal..ttbThumbDisabled,
                //ttbThumbVertNormal..ttbThumbVertDisabled,
                ttbThumbLeftNormal..ttbThumbLeftDisabled,
                ttbThumbRightNormal..ttbThumbRightDisabled] then
    gs := gstHorizontal;

  lColor := FTrackBarFillColors[Detail, ciEnd];
  if Detail in [ttbThumbBottomNormal..ttbThumbBottomDisabled] then
    begin
      lfs := lfs - [fsBottom];
      Dec(lRect.Bottom, ledge);
      lP[0] := Point(lRect.Left, lRect.Bottom);
      lP[1] := Point(lRect.Left + lEdge, lRect.Bottom + lEdge);
      lP[2] := Point(lRect.Right, lRect.Bottom);
      lP[3] := Point(lRect.Right, lRect.Top);
      lP[4] := Point(lRect.Left, lRect.Top);
    end;
  if Detail in [ttbThumbRightNormal..ttbThumbRightDisabled] then
    begin
      lfs := lfs - [fsRight];
      Dec(lRect.Right, ledge);
      lP[0] := Point(lRect.Right, lRect.Top);
      lP[1] := Point(lRect.Right + lEdge, lRect.Top + lEdge);
      lP[2] := Point(lRect.Right, lRect.Bottom);
      lP[3] := Point(lRect.Left, lRect.Bottom);
      lP[4] := Point(lRect.Left, lRect.Top);
    end;
  if Detail in [ttbThumbTopNormal..ttbThumbTopDisabled] then
    begin
      lfs := lfs - [fsTop];
      Inc(lRect.Top, ledge);
      lP[0] := Point(lRect.Left, lRect.Top);
      lP[1] := Point(lRect.Left + lEdge, lRect.Top - lEdge);
      lP[2] := Point(lRect.Right, lRect.Top);
      lP[3] := Point(lRect.Right, lRect.Bottom);
      lP[4] := Point(lRect.Left, lRect.Bottom);
      lColor := FTrackBarFillColors[Detail, ciStart];
    end;
  if Detail in [ttbThumbLeftNormal..ttbThumbLeftDisabled] then
    begin
      lfs := lfs - [fsLeft];
      Inc(lRect.Left, ledge);
      lP[0] := Point(lRect.Left, lRect.Bottom);
      lP[1] := Point(lRect.Left - lEdge, lRect.Bottom - lEdge);
      lP[2] := Point(lRect.Left, lRect.Top);
      lP[3] := Point(lRect.Right, lRect.Top);
      lP[4] := Point(lRect.Right, lRect.Bottom);
      lColor := FTrackBarFillColors[Detail, ciStart];
    end;

  if Detail in [ttbThumbBottomNormal..ttbThumbTopDisabled, ttbThumbLeftNormal..ttbThumbRightDisabled] then
    begin
      lPen := CreatePen(PS_SOLID, 1, FTrackBarFrameColors[Detail]);
      lOldPen := SelectObject(DC, lPen);
      lBrush := CreateSolidBrush(lColor);
      lOldBrush := SelectObject(DC, lBrush);
      Polygon(DC, lP, 5);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
      SelectObject(DC, lOldBrush);
      DeleteObject(lBrush);
      Inc(lRect.Left);
      Inc(lRect.Top);
      DrawGradientFramedRect(DC, lRect, ClipRect, FTrackBarFillColors[Detail, ciStart], FTrackBarFillColors[Detail, ciEnd], FTrackBarFrameColors[Detail], gs, 0, []);
    end
  else
    DrawGradientFramedRect(DC, lRect, ClipRect, FTrackBarFillColors[Detail, ciStart], FTrackBarFillColors[Detail, ciEnd], FTrackBarFrameColors[Detail], gs, 0, lfs);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedWindow; const R: TRect; ClipRect: TLMDRectPtr);
var
 ltb: TThemedButton;
 LR: TRect;
begin
  if Detail in [twSmallCloseButtonNormal, twSmallCloseButtonHot, twSmallCloseButtonPushed, twSmallCloseButtonDisabled] then
    begin
      ltb := TThemedButton(ord(Detail) - ord(twSmallCloseButtonNormal) + ord(tbPushButtonNormal));
      LR := R;
      InflateRect(LR, -1 , -1);
      DrawGradientFramedRect(DC, LR, ClipRect, FBtnFillColors[ltb, ciStart], FBtnFillColors[ltb, ciEnd], FBtnFrameColors[ltb], FGradientSettings[teWindow].GradientStyle, 0);
      DrawCross(DC, LR);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedListview; const R: TRect; ClipRect: TLMDRectPtr);
begin
  raise Exception.CreateFmt(IDS_LMDTHEMES_ELEMENTNOTSUPPORTED, ['TThemedListview', GetThemeRendererName]);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedListview; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.DrawThemeEdge(DC: HDC;
  aElement: TThemedElement; iPartId, iStateId: Integer;
  const pDestRect: TRect; uEdge, uFlags: UINT;
  pContentRect: TLMDRectPtr): boolean;
var
  lElemDetails: TThemedElementDetails;
  lDetailOrd: integer;
  lFrameData : Pointer;
  lFrameSides: TLMDFrameSides;
begin
  result := false;
  if FMetaData[aElement].FrameData = nil then
    exit;
  lFrameData := FMetaData[aElement].FrameData;
  with lElemDetails do
    begin
      Element := aElement;
      Part := iPartId;
      State := iStateId;
    end;
  //<-- ttmPlatform behaviour (uncomment for test)
  //ThemeServices.DrawEdge(DC, lElemDetails, pDestRect,uEdge, uFlags, pContentRect);
  //-->
  lDetailOrd := LMDThemeServices.GetDetailOrd(lElemDetails);
  lFrameSides := [];
  if (BF_TOP and uFlags) = BF_TOP then
    lFrameSides := lFrameSides + [fsTop];
  if (BF_BOTTOM and uFlags) = BF_BOTTOM then
    lFrameSides := lFrameSides + [fsBottom];
  if (BF_LEFT and uFlags) = BF_LEFT then
    lFrameSides := lFrameSides + [fsLeft];
  if (BF_RIGHT and uFlags) = BF_RIGHT then
    lFrameSides := lFrameSides + [fsRight];
  DrawGradientFramedRect(DC, pDestRect, LMDNullRectPtr, clNone, clNone, TLMDColorsData(lFrameData^)[lDetailOrd], gstVertical, 0, lFrameSides);
  result := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawThemeParentBackground(Wnd: HWnd;
  DC: HDC; ARect: TLMDRectPtr);
begin
  LMDDrawParentBackground(Wnd, DC, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.DrawThemeText(DC: HDC;
  Detail: TThemedElement; iPartId, iStateId: Integer; Text: TLMDString;
  CharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
  const ARect: TRect): boolean;
var
  lColor: TColor;
  R: TRect;
begin
  R := ARect;
  result := true;
  if (Text = '') or (CharCount = 0) then
    exit;
  if iStateId = 4 then
    lColor := DisabledTextColor
  else
    lColor := EnabledTextColor;
  SetTextColor(DC, lColor);
  SetBkMode(DC, TRANSPARENT);
  {$IFDEF LMD_UNICODE}
  result := DrawTextW(DC, PWideChar(Text), CharCount, R, dwTextFlags) <> 0;
  {$ELSE}
  result := DrawText(DC, PChar(Text), CharCount, R, dwTextFlags) <> 0;  
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetThemeBackgroundExtent(DC: HDC;
  Detail: TThemedElement; iPartID, iStateID: integer; ContentRect: TRect;
  var ExtentRect: TRect): boolean;
begin
  result := false;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetThemeColor(AElement: TThemedElement;
  iPartId, iStateId, iPropId: Integer): COLORREF;
var
  lElemDetails: TThemedElementDetails;
  lDetailOrd: integer;
  lFillData: Pointer;
  lFrameData : Pointer;
begin
  result := clNone;
  with lElemDetails do
    begin
      Element := AElement;
      Part := iPartId;
      State := iStateId;
    end;
  lDetailOrd := LMDThemeServices.GetDetailOrd(lElemDetails);
  case iPropID of
    TMT_TEXTCOLOR:
      begin
        if iStateId = PBS_DISABLED then
          result := FDisabledTextColor
        else
          result := FEnabledTextColor;
      end;
    TMT_BORDERCOLOR, TMT_EDGELIGHTCOLOR:
      begin
        if FMetaData[AElement].FrameData <> nil then
          begin
            lFrameData := FMetaData[AElement].FrameData;
            result := TLMDColorsData(lFrameData^)[lDetailOrd];
          end;
      end;
    TMT_FILLCOLOR, TMT_GRADIENTCOLOR1, TMT_GRADIENTCOLOR2:
      begin
        if FMetaData[AElement].FillData <> nil then
          begin
            lFillData := FMetaData[AElement].FillData;
            if iPropId = TMT_GRADIENTCOLOR2 then
              result := TLMDGradientColorsData(lFillData^)[lDetailOrd, ciEnd]
            else
              result := TLMDGradientColorsData(lFillData^)[lDetailOrd, ciStart];
          end;
      end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetThemeFont(DC: HDC;
  Detail: TThemedElement; iPartId, iStateId, iPropId: Integer;
  var font: LOGFONTW): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetThemePartSize(DC: HDC;
  Detail: TThemedElement; iPartId, iStateId: Integer;
  var size: TSize): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetThemeSysColor(Detail: TThemedElement;
  ColorID: integer): ColorRef;
begin
  result := clNone;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetThemeSysSize(Detail: TThemedElement;
  iSizeId: Integer): Integer;
begin
  result := -1;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetThemeTextExtent(DC: HDC;
  Detail: TThemedElement; iPartId, iStateId: Integer; Text: TLMDString;
  CharCount: Integer; dwTextFlags: DWORD; BoundingRect: TLMDRectPtr;
  var ExtentRect: TRect): boolean;
begin

  if BoundingRect = nil then
    ExtentREct := Rect(0,0,0,0)
  else
    ExtentRect := BoundingRect^;

  dwTextFlags := dwTextFlags or DT_CALCRECT;
  {$IFDEF LMD_UNICODE}
  result := DrawTextW(DC, PWideChar(Text), CharCount, ExtentRect, dwTextFlags) <> 0;
  {$ELSE}
  result := DrawText(DC, PChar(Text), CharCount, ExtentRect, dwTextFlags) <> 0;
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetEnabled: boolean;
begin
  result := FEnabled;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawGradientFramedRect(DC: HDC;
  R: TRect; ClipRect: TLMDRectPtr; AStartFillColor, AEndFillColor, AFrameColor: TColor; AGradientStyle: TLMDGradientStyle; AFlags: Word; AFrame: TLMDFrameSides = [fsLeft, fsRight, fsTop, fsBottom]);
var
  lw, lh, gbase, cc: integer;
  lPen, lOldPen: HPEN;
  lBrush: HBRUSH;
  LR: TRect;

  lCr: TRect;
  lOldClpRgn, lRgn: HRGN;
begin
  lw := R.Right - R.Left + 1;
  lh := R.Bottom - R.Top + 1;

  lCr := LR;
  lRgn := 0;
  lOldClpRgn := 0;

  if ClipRect <>  LMDNullRectPtr then
    begin
      lCr := ClipRect^;
      lRgn := CreateRectRgn(lCr.Left, lCr.Top, lCr.Right, lCr.Bottom);
      lOldClpRgn := SelectClipRgn(DC, lRGn);
    end;

  if (AStartFillColor = AEndFillColor) and
    (AStartFillColor <> clNone) then
    begin
      lBrush := CreateSolidBrush(AStartFillColor);
      LR := R;
      InflateRect(LR, -1, -1);
      FillRect(DC, LR, lBrush);
      DeleteObject(lBrush);
    end
  else
    if not ((AStartFillColor = clNone) and
            (AEndFillColor = clNone)) then
       begin
         case AGradientStyle of
           gstVertical: gbase := lh;
           gstHorizontal: gbase := lw;
           else
             gbase := (lw + lh) div 2;
         end;
         if FGradientSettings[teButton].CountType = gccCalculated then
           cc := gbase div FGradientSettings[teButton].CalcDivizor
         else
           cc := FGradientSettings[teButton].FixedNumber;
         LMDGradientPaint(DC, R, AStartFillColor, AEndFillColor, cc, aGradientStyle, AFlags, 0);
       end;
  if (AFrameColor <> clNone) then
    begin
      lPen := CreatePen(PS_SOLID, 1, AFrameColor);
      lOldPen := SelectObject(DC, lPen);
      if fsLeft in AFrame then
        begin
          MoveToEx(DC, R.Left, R.Top, nil);
          LineTo(DC, R.Left, R.Bottom);
        end;
      if fsTop in AFrame then
        begin
          MoveToEx(DC, R.Left, R.Top, nil);
          LineTo(DC, R.Right - 1, R.Top);
        end;
      if fsRight in AFrame then
        begin
          MoveToEx(DC, R.Right - 1, R.Top, nil);
          LineTo(DC, R.Right - 1, R.Bottom);
        end;
      if fsBottom in AFrame then
        begin
          MoveToEx(DC, R.Left, R.Bottom - 1, nil);
          LineTo(DC, R.Right, R.Bottom - 1);
        end;
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end;

  if ClipRect <>  LMDNullRectPtr then
    begin
      SelectClipRgn(DC, lOldClpRgn);
      DeleteObject(lRgn);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DoUpdateTheme;
begin
  FTheme := sgtCustom;
  if not FIsUpdating then
    LMDThemeServices.ApplyThemeChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.BeginUpdate;
begin
  FIsUpdating := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.EndUpdate;
begin
  if FIsUpdating then
    begin
      FIsUpdating := false;
      LMDThemeServices.ApplyThemeChange;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetScrollBarFillColors(
  Element: TThemedScrollBar; ColorIndex: TLMDColorIndex): TColor;
begin
  result := FScrollBarFillColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetScrollBarFillColors(
  Element: TThemedScrollBar; ColorIndex: TLMDColorIndex;
  const Value: TColor);
begin
  if Value <> FScrollBarFillColors[Element, ColorIndex] then
    begin
      FScrollBarFillColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetScrollBarFrameColors(
  Element: TThemedScrollBar): TColor;
begin
  result := FScrollBarFrameColors[Element];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetScrollBarFrameColors(
  Element: TThemedScrollBar; const Value: TColor);
begin
  if Value <> FScrollBarFrameColors[Element] then
    begin
      FScrollBarFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetStatusBarFillColors(
  Element: TThemedStatus; ColorIndex: TLMDColorIndex): TColor;
begin
  result := FStatusBarFillColors[Element, ColorIndex];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetStatusBarFillColors(
  Element: TThemedStatus; ColorIndex: TLMDColorIndex; const Value: TColor);
begin
  if Value <> FStatusBarFillColors[Element, ColorIndex] then
    begin
      FStatusBarFillColors[Element, ColorIndex] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetStatusBarFrameColors(
  Element: TThemedStatus): TColor;
begin
  result := FStatusBarFrameColors[Element];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetStatusBarFrameColors(
  Element: TThemedStatus; const Value: TColor);
begin
  if Value <> FStatusBarFrameColors[Element] then
    begin
      FStatusBarFrameColors[Element] := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.LoadThemeFromStream(aStream: TStream; aColorScheme: TLMDString): boolean;
var
  lXmlDoc: ILMDXmlDocument;
  lColorSchemeSection: ILMDXMLElement;
  lGlobals, lElement: ILMDXMLElement;
  lDetail: ILMDXMLElement;
  te: TThemedElement;
  lFillData: Pointer;
  lFrameData: Pointer;
  i: integer;
  lgs: TLMDSimpleGradientSettings;
begin
  result := false;
  try
    try
      lXmlDoc := LMDCreateXmlDocument('Theme', '1.0', '', nil, False);
      lXmlDoc.Load(aStream);
      FThemeName := string(lXmlDoc.DocumentElement.GetVarAttr('Name', ''));
      lColorSchemeSection := lXmlDoc.DocumentElement.FindElement('ColorScheme', 'Name', aColorScheme);
      if lColorSchemeSection = nil then
        if lXmlDoc.DocumentElement.ChildNodes <> nil then
          lColorSchemeSection := lXmlDoc.DocumentElement.ChildNodes.Item[0].AsElement;
      if lColorSchemeSection = nil then
        exit;
      FColorSchemeName := lColorSchemeSection.GetVarAttr('Name', 'Unknown');
      BeginUpdate;
      lGlobals := lColorSchemeSection.FindElement('Globals', '', '');
      if lGLobals <> nil then
        begin
          lElement := lGlobals.FindElement('Text', 'Name', 'EnabledTextColor');
          if lElement <> nil then
            EnabledTextColor := StringToColor(lElement.GetVarAttr('Value', 'clNone'));
          lElement := lGlobals.FindElement('Text', 'Name', 'DisabledTextColor');
          if lElement <> nil then
            DisabledTextColor := StringToColor(lElement.GetVarAttr('Value', 'clNone'));
        end;
      for te := low(TThemedElement) to high(TThemedElement) do
        if FMetaData[te].DetailTypeInfo <> nil then
          begin
            lElement := lColorSchemeSection.FindElement('ThemedElement', 'Name', getEnumName(typeInfo(TThemedElement), ord(te)));
            if lElement = nil then
              continue;
            lgs.CountType := TLMDGradientColorCountType(lElement.GetIntAttr('CountType', 0));
            lgs.FixedNumber := Cardinal(lElement.GetIntAttr('FixedNumber', 16));
            lgs.CalcDivizor := Cardinal(lElement.GetIntAttr('CalcDivizor', 2));
            lgs.GradientStyle := TLMDGradientStyle(lElement.GetIntAttr('GradientStyle', 1));
            GradientSettings[te] := lgs;
            for i  := GetTypeData(FMetaData[te].DetailTypeInfo)^.MinValue to GetTypeData(FMetaData[te].DetailTypeInfo)^.MaxValue do
              begin
                lDetail := lElement.FindElement('Detail', 'Name', getEnumName(FMetaData[te].DetailTypeInfo, i));
                if FMetaData[te].FillData <> nil then
                  begin
                    lFillData := FMetaData[te].FillData;
                    TLMDGradientColorsData(lFillData^)[i, ciStart] := StringToColor(lDetail.GetVarAttr('StartFillColor', 'clNone'));
                    TLMDGradientColorsData(lFillData^)[i, ciEnd] := StringToColor(lDetail.GetVarAttr('EndFillColor', 'clNone'));
                  end;
                if FMetaData[te].FrameData <> nil then
                  begin
                    lFrameData := FMetaData[te].FrameData;
                    TLMDColorsData(lFrameData^)[i] := StringToColor(lDetail.GetVarAttr('FrameColor', 'clNone'));
                  end;
              end;
          end;
      result := true;
    except
      result := false;
    end;
  finally
    FEnabled := true;
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.SaveThemeToStream(aStream: TStream; aThemeName: TLMDString = ''; aColorScheme: TLMDString = ''): boolean;
var
  lXmlDoc: ILMDXmlDocument;
  lColorSchemeSection: ILMDXMLElement;
  lElement: ILMDXMLElement;
  lGlobals: ILMDXMLElement;
  lDetail: ILMDXMLElement;
  te: TThemedElement;
  i: integer;
  lFillData: Pointer;
  lFrameData: Pointer;
begin
  lXmlDoc := LMDCreateXmlDocument('Theme', '1.0', '', nil, False);
  if aStream.Size > 0 then
    try
      lXmlDoc.Load(aStream);
    except
    end;
  lXmlDoc.DocumentElement.SetAttr('Type', 'LMD Simple Gradient Theme');
  lXmlDoc.DocumentElement.SetAttr('Name', aThemeName);
  lColorSchemeSection := lXmlDoc.DocumentElement.FindElement('ColorScheme', 'Name', aColorScheme);

  if lColorSchemeSection = nil then
    lColorSchemeSection := lXmlDoc.DocumentElement.AppendElement('ColorScheme')
  else
    begin
      lColorSchemeSection.RemoveAllChilds;
      lColorSchemeSection.RemoveAllAttrs;
    end;  

  lColorSchemeSection.SetAttr('Name', aColorScheme);
  lGlobals := lColorSchemeSection.AppendElement('Globals');
  lElement := lGlobals.AppendElement('Text');
  lElement.SetAttr('Name', 'EnabledTextColor');
  lElement.SetAttr('Value', ColorToString(EnabledTextColor));
  lElement := lGlobals.AppendElement('Text');
  lElement.SetAttr('Name', 'DisabledTextColor');
  lElement.SetAttr('Value', ColorToString(DisabledTextColor));
  for te := low(TThemedElement) to high(TThemedElement) do
    if FMetaData[te].DetailTypeInfo <> nil then
      begin
        lElement := lColorSchemeSection.AppendElement('ThemedElement');
        lElement.SetAttr('Name',  getEnumName(typeInfo(TThemedElement), ord(te)));
        lElement.SetAttr('CountType', inttostr(ord(GradientSettings[te].CountType)));
        lElement.SetAttr('FixedNumber', inttostr(GradientSettings[te].FixedNumber));
        lElement.SetAttr('CalcDivizor', inttostr(GradientSettings[te].CalcDivizor));
        lElement.SetAttr('GradientStyle',  inttostr(ord(GradientSettings[te].GradientStyle)));
        for i  := GetTypeData(FMetaData[te].DetailTypeInfo)^.MinValue to GetTypeData(FMetaData[te].DetailTypeInfo)^.MaxValue do
          begin
            lDetail := lElement.AppendElement('Detail');
            lDetail.SetAttr('Name', getEnumName( FMetaData[te].DetailTypeInfo, i));
            if FMetaData[te].FillData <> nil then
              begin
                lFillData := FMetaData[te].FillData;
                lDetail.SetAttr('StartFillColor', ColorToString(TLMDGradientColorsData(lFillData^)[i, ciStart]));
                lDetail.SetAttr('EndFillColor', ColorToString(TLMDGradientColorsData(lFillData^)[i, ciEnd]));
              end;
            if FMetaData[te].FrameData <> nil then
              begin
                lFrameData := FMetaData[te].FrameData;
                lDetail.SetAttr('FrameColor', ColorToString(TLMDColorsData(lFrameData^)[i]));
              end;
          end;
      end;
  aStream.Seek(0, soBeginning);
  lXmlDoc.Save(aStream);
  result := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SaveThemeToFile(aFileName: TLMDString; aThemeName: TLMDString = ''; aColorScheme: TLMDString = '');
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;
  if FileExists(aFileName) then
    lStream.LoadFromFile(aFileName);
  SaveThemeToStream(lStream, aThemeName, aColorScheme);
  lStream.SaveToFile(aFileName);
  lStream.Free;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.LoadThemeFromFile(aFile: TLMDString; aColorScheme: TLMDString = ''): boolean;
var
  lStream: TMemoryStream;
begin
  lStream := TMemoryStream.Create;
  try
    try
      lStream.LoadFromFile(aFile);
      result := LoadThemeFromStream(lStream, aColorScheme);
    except
      result := false;
    end;
  finally
    lStream.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.ChangeBrightness(aPercent: integer; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aIndices: TLMDColorIndexSet = [ciStart, ciEnd]; aChangeFrameColors: boolean = true);
var
  te: TThemedElement;
  i: integer;
  lColor: TColor;
  lFillData: Pointer;
  lFrameData : Pointer;
  lIndex: TLMDColorIndex;
  lDetailName: string;
begin
  if aIndices = [] then
    exit;
  BeginUpdate;
  for te := low(TThemedElement) to high(TThemedElement) do
    if (FMetaData[te].DetailTypeInfo <> nil) and ((aElements = []) or (te in aElements)) then
       for i  := GetTypeData(FMetaData[te].DetailTypeInfo)^.MinValue to GetTypeData(FMetaData[te].DetailTypeInfo)^.MaxValue do
       begin
         lDetailName := getEnumName( FMetaData[te].DetailTypeInfo, i);
         if LMDCheckWildCardMask(aDetailNameMask, lDetailName) then
         begin
           if FMetaData[te].FillData <> nil then
             for lIndex := ciStart to ciEnd do
               if lIndex in aIndices then
                 begin
                   lFillData := FMetaData[te].FillData;
                   lColor := TLMDGradientColorsData(lFillData^)[i, lIndex];
                   if lColor <> clNone then
                     begin
                       if aPercent > 0 then
                         TLMDGradientColorsData(lFillData^)[i, lIndex] := LMDColorLighter(lColor, aPercent)
                       else
                         TLMDGradientColorsData(lFillData^)[i, lIndex] := LMDColorDarker(lColor, -aPercent);
                     end;
                 end;
           if aChangeFrameColors and (FMetaData[te].FrameData <> nil) then
             begin
               lFrameData := FMetaData[te].FrameData;
               lColor := TLMDColorsData(lFrameData^)[i];
               if lColor <> clNone then
                 begin
                   if aPercent > 0 then
                     TLMDColorsData(lFrameData^)[i] := LMDColorLighter(lColor, aPercent)
                   else
                     TLMDColorsData(lFrameData^)[i] := LMDColorDarker(lColor, -aPercent);
                 end;
             end;
         end;
       end;
  EndUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.ReplaceColor(aOldColor, aNewColor: TColor; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aIndices: TLMDColorIndexSet = [ciStart, ciEnd]; aDetailProps: TLMDDetailPropKindSet = CAllDetailPropKinds);
var
  te: TThemedElement;
  i: integer;
  lColor: TColor;
  lFillData: Pointer;
  lFrameData : Pointer;
  lIndex: TLMDColorIndex;
  lDetailName: string;
begin
  if aIndices = [] then
    exit;
  if aDetailProps  = [] then
    exit;    
  BeginUpdate;
  for te := low(TThemedElement) to high(TThemedElement) do
    if (FMetaData[te].DetailTypeInfo <> nil) and ((aElements = []) or (te in aElements)) then
       for i  := GetTypeData(FMetaData[te].DetailTypeInfo)^.MinValue to GetTypeData(FMetaData[te].DetailTypeInfo)^.MaxValue do
         begin
           lDetailName := getEnumName( FMetaData[te].DetailTypeInfo, i);
           if LMDCheckWildCardMask(aDetailNameMask, lDetailName) then
             begin
               if (dpkFill in aDetailProps) and (FMetaData[te].FillData <> nil) then
                 for lIndex := ciStart to ciEnd do
                   if lIndex in aIndices then
                     begin
                       lFillData := FMetaData[te].FillData;
                       lColor := TLMDGradientColorsData(lFillData^)[i, lIndex];
                       if lColor = aOldColor then
                         TLMDGradientColorsData(lFillData^)[i, lIndex] := aNewColor;
                     end;
               if (dpkFrame in aDetailProps) and (FMetaData[te].FrameData <> nil) then
                 begin
                   lFrameData := FMetaData[te].FrameData;
                   lColor := TLMDColorsData(lFrameData^)[i];
                   if lColor = aOldColor then
                     TLMDColorsData(lFrameData^)[i] := aNewColor;
                 end;
             end;
         end;
  if (dpkDisabledText in aDetailProps) and (FDisabledTextColor = aOldColor) then
    FDisabledTextColor := aNewColor;
  if (dpkEnabledText in aDetailProps) and (FEnabledTextColor = aOldColor) then
    FEnabledTextColor := aNewColor;
  EndUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetNewColor(aNewColor: TColor;
  aElements: TThemedElementSet; aDetailNameMask: string;
  aIndices: TLMDColorIndexSet; aDetailProps: TLMDDetailPropKindSet);
var
  te: TThemedElement;
  i: integer;
  lFillData: Pointer;
  lFrameData : Pointer;
  lIndex: TLMDColorIndex;
  lDetailName: string;
begin
  if aIndices = [] then
    exit;
  if aDetailProps  = [] then
    exit;
  BeginUpdate;
  for te := low(TThemedElement) to high(TThemedElement) do
    if (FMetaData[te].DetailTypeInfo <> nil) and ((aElements = []) or (te in aElements)) then
       for i  := GetTypeData(FMetaData[te].DetailTypeInfo)^.MinValue to GetTypeData(FMetaData[te].DetailTypeInfo)^.MaxValue do
         begin
           lDetailName := getEnumName( FMetaData[te].DetailTypeInfo, i);
           if LMDCheckWildCardMask(aDetailNameMask, lDetailName) then
             begin
               if (dpkFill in aDetailProps) and (FMetaData[te].FillData <> nil) then
                 for lIndex := ciStart to ciEnd do
                   if lIndex in aIndices then
                     begin
                       lFillData := FMetaData[te].FillData;
                       TLMDGradientColorsData(lFillData^)[i, lIndex] := aNewColor;
                     end;
               if (dpkFrame in aDetailProps) and (FMetaData[te].FrameData <> nil) then
                 begin
                   lFrameData := FMetaData[te].FrameData;
                   TLMDColorsData(lFrameData^)[i] := aNewColor;
                 end;
             end;
         end;
  if (dpkDisabledText in aDetailProps) then
    FDisabledTextColor := aNewColor;
  if (dpkEnabledText in aDetailProps) then
    FEnabledTextColor := aNewColor;
  EndUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetColorSchemeName(
  const Value: string);
var
  lcs: TLMDColorScheme;
begin
  FColorSchemeName := Value;
  FColorScheme := csCustom;
  for lcs := csBlue to csCustom do
    begin
      if Value = CBuiltInColorSchemes[lcs] then
        FColorScheme := lcs;
      break;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetMetaData(
  Element: TThemedElement): TLMDThemeDetailMetaData;
begin
  result := FMetaData[Element];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DeactivateTheme;
begin
  FEnabled := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.SetEnabled(aValue: boolean);
begin
  if aValue then
    FEnabled := ActivateTheme(FThemeName, FColorSchemeName)
  else
    DeactivateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetActiveColorSchemeName: TLMDString;
begin
  result := ThemeName;
end;

{------------------------------------------------------------------------------}
function TLMDBaseSGThemeRenderer.GetActiveThemeName: TLMDString;
begin
  result := ColorSchemeName;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseSGThemeRenderer.DrawScrollThumbGripper(DC: HDC;
  aRect: TRect; Detail: TThemedScrollBar);
var
  lPen, lOldPen: HPEN;
  height, width, x, y, n, i: integer;
  R: TRect;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawScrollThumbGripper) then
    FOnDrawScrollThumbGripper(Self, DC, aRect, Detail, lExit);
  if not lExit then
  begin
    R := aRect;
    lPen := CreatePen(PS_SOLID, 1, FScrollBarFrameColors[Detail]);
    lOldPen := SelectObject(DC, lPen);
    height := Abs(R.Top - R.Bottom);
    width := Abs(R.Right - R.Left);
    n := trunc( min(width, height) / 2);
    for i := 0 to n do
      case Detail of
        tsGripperHorzNormal..tsGripperHorzDisabled:
           begin
             x := (R.Left + R.Right - height) div 2 + i * 2;
             MoveToEx(DC, x, R.Top, nil);
             LineTo(DC, x, R.Bottom);
           end;
        tsGripperVertNormal..tsGripperVertDisabled:
           begin
             y := (R.Top + R.Bottom - width) div 2 + i * 2;
             MoveToEx(DC, R.Left, y, nil);
             LineTo(DC, R.Right, y);
           end;
      end;
    SelectObject(DC, lOldPen);
    DeleteObject(lPen);
  end;
end;

end.
