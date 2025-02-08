unit LMDThemesWindowsXP;
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

LMDThemesWindowsXP unit (VB)
----------------------------
TWindowsXPThemeManager, TWindowsXPThemeMetrics, TWindowsXPTheme,
TWindowsXPThemePart

ToDo
----

Changes
-------
Release 8.0 (XX 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, Graphics, CommCtrl, Types, UxTheme,
  LMDTypes,
  LMDRtlxConst, LMDIniCtrl, LMDDebugUnit, LMDThemesEngine, LMDThemesMain,
  LMDThemesGeneral, LMDThemesWindowsXPConsts, LMDThemesWindowsXPTypes,
  LMDThemesWindowsXPUtils, LMDThemes;

type
  //EWindowsXPThemeError = class(EThemeError);

  TWindowsXPTheme = class;

  TWindowsXPThemePart = class(TThemePart)
  private
    FBoolProps: array [0..XPBoolPropCount - 1] of boolean;
    FColorProps: array [0..XPColorPropCount - 1] of TColor;
    FIntProps: array [0..XPIntPropCount - 1] of integer;
    FMarginsProps: array [0..XPMarginsPropCount - 1] of TMargins;
    FPointProps: array [0..XPPointPropCount - 1] of TPoint;
    FSizeProps: array [0..XPSizePropCount - 1] of TXPSize;
    FStrProps: array [0..XPStrPropCount - 1] of string;
    FSection: string;

    FBgType: TXPBgType;
    FBorderType: TXPBorderType;
    FContentAlignment: TXPContentAlignment;
    FFillType: TXPFillType;
    FGlyphType: TXPGlyphType;
    FHAlign: TXPHAlign;
    FIconEffect: TXPIconEffect;
    FImageLayout: TXPImageLayout;
    FImageSelect: TXPImageSelect;
    FOffsetType: TXPOffsetType;
    FSizingType: TXPSizingType;
    FTextShadowType: TXPShadowType;
    FTrueSizeScalingType: TXPImageSelect;
    FVAlign: TXPVAlign;

    FProps: TBits;

    function GetAvailable(Index: integer): boolean;
    function GetBgType: TXPBgType;
    function GetBoolProp(Tag: integer): boolean;
    function GetBorderType: TXPBorderType;
    function GetColorProp(Tag: integer): TColor;
    function GetContentAligment: TXPContentAlignment;
    function GetDefined(Index: integer): boolean;
    function GetFillType: TXPFillType;
    function GetGlyphType: TXPGlyphType;
    function GetHAlign: TXPHAlign;
    function GetIconEffect: TXPIconEffect;
    function GetImageLayout: TXPImageLayout;
    function GetImageSelect: TXPImageSelect;
    function GetIntProp(Tag: integer): integer;
    function GetMarginsProp(Tag: integer): TXPMargins;
    function GetOffsetType: TXPOffsetType;
    function GetPointProp(Tag: integer): TPoint;
    function GetSizeProp(Tag: integer): TXPSize;
    function GetSizingType: TXPSizingType;
    function GetStrProp(Tag: integer): string;
    function GetTextShadowType: TXPShadowType;
    function GetTrueSizeScalingType: TXPImageSelect;
    function GetVAlign: TXPVAlign;
    procedure SetDefined(Index: integer; const Value: boolean);
  protected
    FGlyphImage: TBitmap;
    FImage: TBitmap;
    FImage1: TBitmap;
    FImage2: TBitmap;
    FImage3: TBitmap;
    FImage4: TBitmap;
    FImage5: TBitmap;
    FGlyphRects: TXPRectArray;
    FImageRects: TXPRectArray;
    FImage1Rects: TXPRectArray;
    FImage2Rects: TXPRectArray;
    FImage3Rects: TXPRectArray;
    FImage4Rects: TXPRectArray;
    FImage5Rects: TXPRectArray;

    procedure DivideImage(Image: TBitmap; Count: integer; var Rects: TXPRectArray); virtual;
    procedure DivideImages; virtual;
    procedure DrawBorderFillBackground(DC: HDC; StateID: integer;
      const R: TRect; ClipRect: PRect); virtual;
    procedure DrawGradientBackground(DC: HDC; StateID: integer;
      R: TRect; ClipRect: PRect; Vertical: boolean); virtual;
    procedure DrawImageFileBackground(DC: HDC; StateID: integer;
      const R: TRect; ClipRect: PRect); virtual;
    procedure DrawImageGlyph(DC: HDC; StateID: integer; R: TRect;
      ClipRect: PRect); virtual;
    procedure DrawSolidBackground(DC: HDC; StateID: integer;
      const R: TRect; ClipRect: PRect); virtual;
    procedure DrawStretchedImage(DC: HDC; DstRect: TRect; ClipRect: PRect;
      Image: TBitmap; SrcRect: TRect; TransparentColor: TColor);
    procedure DrawTiledImage(DC: HDC; DstRect: TRect; ClipRect: PRect;
      Image: TBitmap; SrcRect: TRect; TransparentColor: TColor);
    procedure DrawTrueSizedImage(DC: HDC; DstRect: TRect; ClipRect: PRect;
      Image: TBitmap; SrcRect: TRect; TransparentColor: TColor);
    function GetStateRectIndex(StateID: integer): integer; virtual;
    procedure ParseScheme(const Scheme: TLMDIniCtrl; Section: string); virtual;
    procedure SelectImage(DC: HDC; R: TRect; SelectType: TXPImageSelect;
      var Image: TBitmap; var Rects: PXPRectArray); virtual;
    procedure SetupInternals; virtual;

    function ImageByIndex(index: integer): TBitmap;
    function RectsArrayByIndex(index: integer): PXPRectArray;
  public
    constructor Create(Theme: TWindowsXPTheme; Parent: TWindowsXPThemePart;
      ASection: string); reintroduce; virtual;
    destructor Destroy; override;
    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); override;
    procedure DrawThemeEdge(DC: HDC; StateID: integer; const DestRect: TRect;
      Edge: cardinal; Flags: cardinal; ContentRect: PRect); override;
    procedure DrawThemeIcon(DC: HDC; StateID: integer; const Rect: TRect;
      ImageList: THandle; ImageIndex: integer); override;
    procedure DrawThemeText(DC: HDC; StateID: integer; Text: PLMDChar;
      CharCount: integer;  TextFlags: cardinal; TextFlags2: cardinal;
      const ARect: TRect); override;
    procedure GetThemeBackgroundContentRect(DC: HDC; StateID: integer;
      const BoundingRect: TRect; out ContentRect: TRect); override;
    procedure GetThemeBackgroundExtent(DC: HDC; StateID: integer;
      const ContentRect: TRect; out ExtentRect: TRect); override;
    procedure GetThemeBackgroundRegion(DC: HDC; StateID: integer;
      const Rect: TRect; out Region: HRgn); override;

    procedure GetThemeBool(StateID: integer; PropID: integer;
      out Value: boolean); override;
    procedure GetThemeColor(StateID: integer; PropID: integer;
      out Color: ColorRef); override;
    procedure GetThemeEnumValue(StateID: integer; PropID: integer;
      out Value: integer); override;
    procedure GetThemeFilename(StateID: integer; PropID: integer;
      ThemeFileName: PWideChar; MaxNameChars: integer); override;
    procedure GetThemeFont(DC: HDC; StateID: integer; PropID: integer;
      var Font: TLogFontW); override;
    procedure GetThemeInt(StateID: integer; PropID: integer;
      out Value: integer); override;
    procedure GetThemeIntList(StateID: integer; PropID: integer;
      out List: TThemeIntList); override;
    procedure GetThemeMargins(DC: HDC; StateID: integer;
      PropID: integer;  var Margins: TMargins); override;
    procedure GetThemeMetric(DC: HDC; StateID: integer; PropID: integer;
      out Value: integer); override;
    procedure GetThemePartSize(DC: HDC; StateID: integer; Rect: PRect;
      SizeType: TThemeSize; out Size: TSize); override;
    procedure GetThemePosition(StateID: integer; PropID: integer;
      out Point: TPoint); override;
    procedure GetThemePropertyOrigin(StateID: integer; PropID: integer;
      var Origin: integer); override;
    procedure GetThemeRect(StateID: integer; PropID: integer;
      out Rect: TRect); override;
    procedure GetThemeString(StateID: integer; PropID: integer;
      Buffer: PWideChar; MaxBufferChars: integer); override;

    procedure GetThemeTextExtent(DC: HDC; StateID: integer;
      Text: PLMDChar; CharCount: integer; TextFlags: cardinal;
      BoundingRect: PRect; out ExtentRect: TRect); override;
    procedure GetThemeTextMetrics(DC: HDC; StateID: integer;
      out Metrics: TTextMetricW); override;
    procedure HitTestThemeBackground(DC: HDC; StateID: integer;
      Options: cardinal; const Rect: TRect; Region: HRgn; Test: TPoint;
      out HitTestCode: word); override;
    function IsThemeBackgroundPartiallyTransparent(StateID: integer): boolean; override;
    function IsThemePartStateDefined(StateID: integer): boolean; override;

    function GetSection: string; override;

    property Available[Index: integer]: boolean read GetAvailable;
    property Defined[Index: integer]: boolean read GetDefined write SetDefined;

    property BgType: TXPBgType read GetBgType;
    property BoolProp[Tag: integer]: boolean read GetBoolProp;
    property BorderType: TXPBorderType read GetBorderType;
    property ColorProp[Tag: integer]: TColor read GetColorProp;
    property ContentAlignment: TXPContentAlignment read GetContentAligment;
    property FillType: TXPFillType read GetFillType;
    property GlyphType: TXPGlyphType read GetGlyphType;
    property HAlign: TXPHAlign read GetHAlign;
    property IconEffect: TXPIconEffect read GetIconEffect;
    property ImageLayout: TXPImageLayout read GetImageLayout;
    property ImageSelect: TXPImageSelect read GetImageSelect;
    property IntProp[Tag: integer]: integer read GetIntProp;
    property MarginsProp[Tag: integer]: TXPMargins read GetMarginsProp;
    property OffsetType: TXPOffsetType read GetOffsetType;
    property PointProp[Tag: integer]: TPoint read GetPointProp;
    property SizeProp[Tag: integer]: TXPSize read GetSizeProp;
    property SizingType: TXPSizingType read GetSizingType;
    property StrProp[Tag: integer]: string read GetStrProp;
    property TextShadowType: TXPShadowType read GetTextShadowType;
    property TrueSizeScalingType: TXPImageSelect read GetTrueSizeScalingType;
    property VAlign: TXPVAlign read GetVAlign;
  end;

  TWindowsXPTheme = class(TTheme)
  public
    function GetThemeSysBool(BoolID: integer): boolean; override;
    function GetThemeSysColor(ColorID: integer): ColorRef; override;
    function GetThemeSysColorBrush(ColorID: integer): HBrush; override;
    function GetThemeSysFont(FontID: integer; out Font: LogFontW): HResult; override;
    function GetThemeSysInt(IntID: integer; out Value: integer): HResult; override;
    function GetThemeSysSize(SizeID: integer): integer; override;
    procedure GetThemeSysString(StringID: integer;  Value: PWideChar; MaxStringChars: integer); override;
  end;

  TWindowsXPThemeMetrics = class
  private
    FBools: array [TMT_FIRSTBOOL..TMT_LASTBOOL] of boolean;
    FBoolsDefined: array [TMT_FIRSTBOOL..TMT_LASTBOOL] of boolean;
    FBrushes: array [TMT_FIRSTCOLOR..TMT_LASTCOLOR] of HBrush;
    FBrushesDefined: array [TMT_FIRSTCOLOR..TMT_LASTCOLOR] of boolean;
    FColors: array [TMT_FIRSTCOLOR..TMT_LASTCOLOR] of ColorRef;
    FColorsDefined: array [TMT_FIRSTCOLOR..TMT_LASTCOLOR] of boolean;
    FFonts: array [TMT_FIRSTFONT..TMT_LASTFONT] of LogFont;
    FFontsDefined: array [TMT_FIRSTFONT..TMT_LASTFONT] of boolean;
    FInts: array [TMT_FIRSTINT..TMT_LASTINT] of integer;
    FIntsDefined: array [TMT_FIRSTINT..TMT_LASTINT] of boolean;
    FSizes: array [TMT_FIRSTSIZE..TMT_LASTSIZE] of integer;
    FSizesDefined: array [TMT_FIRSTSIZE..TMT_LASTSIZE] of boolean;
    FStrings: array [TMT_FIRSTSTRING..TMT_LASTSTRING] of string;
    FStringsDefined: array [TMT_FIRSTSTRING..TMT_LASTSTRING] of boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ClearMetrics;
    procedure ParseMetrics(const Scheme: TLMDIniCtrl);

    function GetBool(BoolID: integer): boolean;
    function GetColor(ColorID: integer): ColorRef;
    function GetColorBrush(ColorID: integer): HBrush;
    function GetFont(FontID: integer): LogFont;
    function GetInt(IntID: integer): integer;
    function GetSize(SizeID: integer): integer;
    function GetString(StringID: integer): string;
  end;

  TWindowsXPThemeGlobalsPart = class(TWindowsXPThemePart)
  public
    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); override;
    procedure GetThemeBackgroundContentRect(DC: HDC; StateID: integer;
      const BoundingRect: TRect; out ContentRect: TRect); override;
    procedure GetThemeBackgroundExtent(DC: HDC; StateID: integer;
      const ContentRect: TRect; out ExtentRect: TRect); override;
    procedure HitTestThemeBackground(DC: HDC; StateID: integer;
      Options: cardinal; const Rect: TRect; Region: HRgn; Test: TPoint;
      out HitTestCode: word); override;
    function IsThemeBackgroundPartiallyTransparent(StateID: integer): boolean; override;
    function IsThemePartStateDefined(StateID: integer): boolean; override;
  end;

  TWindowsXPThemeGlobals = class(TWindowsXPTheme)
  private
    FPartID: integer;
  protected
    function FindPart(PartID: integer): TThemePart; override;
  public
    constructor Create(Manager: TThemeManager); override;
    property PartID: integer read FPartID;
  end;

  TWindowsXPThemeManager = class(TThemeManager)
  private
    FFileHandle: HInst;
    FDelFileName: string;
    FMetrics: TWindowsXPThemeMetrics;
    FSchemeIni: TLMDIniCtrl;
    FThemesIni: TLMDIniCtrl;
  protected
    function CreateTheme(ThemeName: WideString): TTheme; override;
    function GetDisplayName: WideString; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Open(FileName: WideString); override;
    procedure Close; override;

    procedure Activate(ColorScheme: WideString); override;
    procedure ChangeColorScheme(ColorScheme: WideString); override;
    procedure Deactivate; override;

    function GetColorSchemeDisplayName(SchemeName: WideString): WideString; override;

    procedure GetThemeDocumentationProperty(ThemeName: PWideChar;
      PropertyName: PWideChar; Value: PWideChar; MaxValueChars: integer); override;
    function GetThemeSysColor(Theme: TThemeHandle; ColorID: integer): ColorRef; override;
    function GetThemeSysColorBrush(Theme: TThemeHandle; ColorID: integer): HBrush; override;
    function ThemeManagerHandle: TThemeManagerHandle; override;

    property FileHandle: HInst read FFileHandle;
  end;

implementation

uses
  LMDThemesGraphics,
  LMDUnicode,
  LMDGraphUtils,
  LMDStrings,
  LMDThemesWindowsXPParts;

{$warnings off}
{---------------------- TWindowsXPThemeManager --------------------------------}
procedure TWindowsXPThemeManager.Activate(ColorScheme: WideString);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeManager.ChangeColorScheme(ColorScheme: WideString);
var
  Files: TLMDMemoryStrings;
  Resource: TResourceStream;
  WS: WideString;
  Index, FontSizes: integer;
  Stream: TStringStream;
  //S: String;
  begin
  Index := -1;
  if FColorSchemes.Count > 0 then
    Index := FColorSchemes.IndexOf(ColorScheme);
  if (Length(ColorScheme) = 0) then
    begin
      if FColorSchemes.Count > 0 then
        begin
          ColorScheme := FColorSchemes[0];
          Index := 0;
        end
      else
        begin
          LMDDebug(Format(SLMDUnknownThemeColorScheme, [String(ColorScheme)]));
          exit;
        end;
    end
  else
    if (Length(ColorScheme) > 0) and (Index < 0) then
      raise Exception.Create(Format(SLMDUnknownThemeColorScheme, [String(ColorScheme)]));
  Files := TLMDMemoryStrings.Create;
  try
    // loading color schemes' file names
    Resource := TResourceStream.CreateFromID(FFileHandle, 1, 'FILERESNAMES');
    try
      SetLength(WS, Resource.Size div 2);
      Resource.ReadBuffer(WS[1], Resource.Size);
      finally
      Resource.Free;
    end;
    // parsing color schemes' file names
    LMDParseToStrList(WS, #0, Files);
    //remove last empty string parsed from last two zeroes (#0#0)
    with Files do
      if Count > 1 then
        if Files[Count - 1] = '' then
          Delete(Files.Count - 1);
    SetLength(WS, 0);
    if Files.Count = 0 then
      LMDDebug(SLMDWinXPThemeNoSchemeSection);
    // loading font sizes names
    Resource := TResourceStream.CreateFromID(FFileHandle, 1, 'SIZENAMES');
    try
      SetLength(WS, Resource.Size div 2);
      Resource.ReadBuffer(WS[1], Resource.Size);
      finally
      Resource.Free;
    end;
    // calculating number of font sizes
    //FontSizes := 0;
    FontSizes := LMDWideCount(WS, #0); //vb check!!!
    SetLength(WS, 0);

    // calculating index of color scheme's file name
    Index := Index * FontSizes;
    if Index >= Files.Count then
      LMDDebug(SLMDWinXPThemeNoSchemeSection);
    // loading color scheme ini-file
    Resource := TResourceStream.Create(FFileHandle, Files[Index], 'TEXTFILE');
    try
      SetLength(WS, Resource.Size div 2);
      Resource.ReadBuffer(WS[1], Resource.Size);
      //S := WS;            //check to remove it
      //SetLength(WS, 0);
    finally
      Resource.Free;
    end;
    Stream := TStringStream.Create(WS);
    SetLength(WS, 0);
    try
      FSchemeIni.MemIniFile.LoadFromStream(Stream);
      FSchemeIni.MemIniFile.Normalize(';');
    finally
      Stream.Free;
    end;
  finally
    Files.Free;
  end;
  ClearThemes;
  FMetrics.ParseMetrics(FSchemeIni);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeManager.Close;
begin
  if Assigned(FSchemeIni) then
    FSchemeIni.Clear;
  if Assigned(FThemesIni) then
    FThemesIni.Clear;
  if FFileHandle <> 0 then
    begin
      FreeLibrary(FFileHandle);
      FFileHandle := 0;
    end;
  inherited;    
end;

{------------------------------------------------------------------------------}
constructor TWindowsXPThemeManager.Create;
begin
  inherited;
  FFileHandle := 0;
  FDelFileName := '';
  FMetrics := TWindowsXPThemeMetrics.Create;
  FSchemeIni := TLMDIniCtrl.Create(nil);
  FSchemeIni.Target := itMemIniFile;
  FThemesIni := TLMDIniCtrl.Create(nil);
  FThemesIni.Target := itMemIniFile;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeManager.CreateTheme(ThemeName: WideString): TTheme;
var
  S: string;
begin
  S := UpperCase(ThemeName);
  //if StrLComp(PChar(S), 'GLOBALS', 7) = 0 then
  if Copy(S,1,7) = 'GLOBALS' then
    Result := TWindowsXPThemeGlobals.Create(Self)
  else
  //if StrLComp(PChar(S), 'BUTTON', 6) = 0 then
  if Copy(S,1,6) = 'BUTTON' then
    Result := TWindowsXPThemeButton.Create(Self)
  else
  //if StrLComp(PChar(S), 'COMBOBOX', 8) = 0 then
  if Copy(S,1,8) = 'COMBOBOX' then
    Result := TWindowsXPThemeComboBox.Create(Self)
  else
  //if StrLComp(PChar(S), 'EDIT', 4) = 0 then
  if Copy(S,1,4) = 'EDIT' then
    Result := TWindowsXPThemeEdit.Create(Self)
  else
  //if StrLComp(PChar(S), 'EXPLORERBAR', 11) = 0 then
  if Copy(S,1,11) = 'EXPLORERBAR' then
    Result := TWindowsXPThemeExplorerBar.Create(Self)
  else
  //if StrLComp(PChar(S), 'HEADER', 6) = 0 then
  if Copy(S,1,6) = 'HEADER' then
    Result := TWindowsXPThemeHeader.Create(Self)
  else
  //if StrLComp(PChar(S), 'LISTVIEW', 8) = 0 then
  if Copy(S,1,8) = 'LISTVIEW' then
    Result := TWindowsXPThemeListView.Create(Self)
  else
  //if StrLComp(PChar(S), 'PROGRESS', 8) = 0 then
  if Copy(S,1,8) = 'PROGRESS' then
    Result := TWindowsXPThemeProgress.Create(Self)
  else
  //if StrLComp(PChar(S), 'SCROLLBAR', 9) = 0 then
  if Copy(S,1,9) = 'SCROLLBAR' then
    Result := TWindowsXPThemeScrollBar.Create(Self)
  else
  //if StrLComp(PChar(S), 'SPIN', 4) = 0 then
  if Copy(S,1,4) = 'SPIN' then
    Result := TWindowsXPThemeSpin.Create(Self)
  else
  //if StrLComp(PChar(S), 'STATUS', 6) = 0 then
  if Copy(S,1,6) = 'STATUS' then
    Result := TWindowsXPThemeStatus.Create(Self)
  else
  //if StrLComp(PChar(S), 'TAB', 3) = 0 then
  if Copy(S,1,3) = 'TAB' then
    Result := TWindowsXPThemeTab.Create(Self)
  else
  //if StrLComp(PChar(S), 'TOOLBAR', 7) = 0 then
  if Copy(S,1,7) = 'TOOLBAR' then
    Result := TWindowsXPThemeToolbar.Create(Self)
  else
  //if StrLComp(PChar(S), 'TRACKBAR', 8) = 0 then
  if Copy(S,1,8) = 'TRACKBAR' then
    Result := TWindowsXPThemeTrackBar.Create(Self)
  else
  //if StrLComp(PChar(S), 'TREEVIEW', 8) = 0 then
  if Copy(S,1,8) = 'TREEVIEW' then
    Result := TWindowsXPThemeTreeView.Create(Self)
  else
  //if StrLComp(PChar(S), 'WINDOW', 6) = 0 then
  if Copy(S,1,6) = 'WINDOW' then
    Result := TWindowsXPThemeWindow.Create(Self)
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeManager.Deactivate;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
destructor TWindowsXPThemeManager.Destroy;
begin
  FreeAndNil(FThemesIni);
  FreeAndNil(FSchemeIni);
  FreeAndNil(FMetrics);
  inherited;  
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeManager.GetColorSchemeDisplayName(
  SchemeName: WideString): WideString;
var
  Name: string;
begin
  Name := FThemesIni.ReadString(trim('ColorScheme.' + SchemeName), 'DisplayName', '');
  Result := Trim(Name);
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeManager.GetDisplayName: WideString;
begin
  if FThemesIni.ValueExists('Documentation', 'DisplayName') then
    Result := FThemesIni.ReadString('Documentation', 'DisplayName', '')
  else
    LMDDebug(SLMDWinXPThemeNoDisplayName);
end;

{------------------------------------------------------------------------------}

procedure TWindowsXPThemeManager.GetThemeDocumentationProperty(ThemeName: PWideChar;
  PropertyName: PWideChar; Value: PWideChar; MaxValueChars: integer);

var
  WS: WideString;
begin
  if (Value = nil) or (MaxValueChars = 0) then
    LMDDebug(SLMDWinXPThemeInvalidParameter);
  if FThemesIni.ValueExists('Documentation', WideString(PropertyName)) then
  begin
    WS := FThemesIni.ReadString('Documentation', WideString(PropertyName), '');
    LMDWideStrLCopy(Value, PWideChar(WS), MaxValueChars);
  end
  else
    LMDDebug(Format(SLMDWinXPThemeNoDocProp, [String(PropertyName)]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeManager.GetThemeSysColor(Theme: TThemeHandle;
  ColorID: integer): ColorRef;
begin
  if Theme = 0 then
    Result := FMetrics.GetColor(ColorID)
  else
    Result := inherited GetThemeSysColor(Theme, ColorID);
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeManager.GetThemeSysColorBrush(Theme: TThemeHandle;
  ColorID: integer): HBrush;
begin
  if Theme = 0 then
    Result := FMetrics.GetColorBrush(ColorID)
  else
    Result := inherited GetThemeSysColorBrush(Theme, ColorID);
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeManager.Open(FileName: WideString);
var
  Resource: TResourceStream;
  Stream: TStringStream;
  S: String;
  WS: WideString;
  //P: PWideChar;
begin
  inherited;
  //<-- CAB Support
  if FIsCabFile then
    if (FUnpackedFileName = '') then
      begin
        LMDDebug(Format(SLMDInvalidThemeFileName, [String(FileName)]));
        exit;
      end
    else
      S := FUnpackedFileName
  else
    S := FileName;
  // -- end of CAB Support code -->
  FFileHandle := LoadLibraryEx(PChar(S), 0, LOAD_LIBRARY_AS_DATAFILE);
  if FFileHandle = 0 then
    begin
      LMDDebug(Format(SLMDInvalidThemeFileName, [String(FileName)]));
      exit;
    end;
  try
    Resource := TResourceStream.Create(FFileHandle, 'THEMES_INI', 'TEXTFILE');
    try
      SetLength(WS, Resource.Size div 2);
      Resource.ReadBuffer(WS[1], Resource.Size);
      Stream := TStringStream.Create(WS);
      try
        FThemesIni.MemIniFile.LoadFromStream(Stream);
        FThemesIni.MemIniFile.Normalize(';')
      finally
        Stream.Free;
      end;
    finally
      Resource.Free;
    end;
    FColorSchemes.Clear;
    Resource := TResourceStream.CreateFromID(FFileHandle, 1, 'COLORNAMES');
    try
      if Resource.Size > 0 then
      begin
        SetLength(WS, Resource.Size div 2);
        Resource.ReadBuffer(WS[1], Resource.Size);
        LMDParseToStrList(WS, #0, FColorSchemes);//vb check
        //remove last empty string parsed from last two zeroes (#0#0)
        with FColorSchemes do
          if Count > 1 then
            if FColorSchemes[Count - 1] = '' then
              Delete(FColorSchemes.Count - 1);
      end;
    finally
      Resource.Free;
    end;
  except
    LMDDebug(Format(SLMDThemeFileParseFailed, [String(FileName)]));
    Close;
  end;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeManager.ThemeManagerHandle: TThemeManagerHandle;
begin
  result := TThemeManagerHandle(self);
  end;

{------------------- TWindowsXPThemeMetrics -----------------------------------}
procedure TWindowsXPThemeMetrics.ClearMetrics;
var
  I: integer;
begin
  for I := TMT_FIRSTCOLOR to TMT_LASTCOLOR do
    if FBrushesDefined[I] then
    begin
      DeleteObject(FBrushes[I]);
      FBrushesDefined[I] := False;
      FBrushes[I] := 0;
    end;
  //for I := low(FStrings) to High(FStrings) do //vb???
  //  SetLength(FStrings[I], 0);
end;

{------------------------------------------------------------------------------}
constructor TWindowsXPThemeMetrics.Create;
var
  I: integer;
begin
  inherited;
  for I := TMT_FIRSTBOOL to TMT_LASTBOOL do
  begin
    FBools[I] := False;
    FBoolsDefined[I] := False;
  end;
  for I := TMT_FIRSTCOLOR to TMT_LASTCOLOR do
  begin
    FBrushes[I] := 0;
    FBrushesDefined[I] := False;
    FColors[I] := 0;
    FColorsDefined[I] := False;
  end;
  for I := TMT_FIRSTFONT to TMT_LASTFONT do
  begin
    FillChar(FFonts[I], SizeOf(FFonts[I]), 0);
    FFontsDefined[I] := False;
  end;
  for I := TMT_FIRSTINT to TMT_LASTINT do
  begin
    FInts[I] := 0;
    FIntsDefined[I] := False;
  end;
  for I := TMT_FIRSTSiZE to TMT_LASTSIZE do
  begin
    FSizes[I] := 0;
    FSizesDefined[I] := False;
  end;
  for I := TMT_FIRSTSTRING to TMT_LASTSTRING do
  begin
    FStrings[I] := '';
    FStringsDefined[I] := False;
  end;
end;

{------------------------------------------------------------------------------}
destructor TWindowsXPThemeMetrics.Destroy;
begin
  ClearMetrics;
  inherited;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeMetrics.GetBool(BoolID: integer): boolean;
begin
  Result := False;
  if (BoolID >= Low(FBoolsDefined)) and (BoolID <= High(FBoolsDefined))
    and FBoolsDefined[BoolID] then
    Result := FBools[BoolID]
  else
    LMDDebug(Format(SLMDWinXPThemeNoMetricsProp, [BoolID]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeMetrics.GetColor(ColorID: integer): ColorRef;
begin
  if (ColorID>=Low(FColorsDefined)) and (ColorID < High(FColorsDefined)) and FColorsDefined[ColorID] then
    Result := FColors[ColorID]
  else
  begin
    // try to convert constant COLOR_* to TMT_*
    if (ColorID>=Low(FColorsDefined) - 1601) and (ColorID < High(FColorsDefined) - 1601) and FColorsDefined[ColorID + 1601] then
      Result := FColors[ColorID + 1601]
    else
    begin
      LMDDebug(Format(SLMDWinXPThemeNoMetricsProp, [ColorID]));
      Result := $FFFFFFFF;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeMetrics.GetColorBrush(ColorID: integer): HBrush;
begin
  if (ColorID >= Low(FColorsDefined)) and (ColorID < High(FColorsDefined)) then
  begin
    if FBrushesDefined[ColorID] then
      Result := FBrushes[ColorID]
    else
    if FColorsDefined[ColorID] then
    begin
      Result := CreateSolidBrush(FColors[ColorID]);
      FBrushes[ColorID] := Result;
      FBrushesDefined[ColorID] := True;
    end
    else
      Result := 0;
  end
  else
  begin
    LMDDebug(Format(SLMDWinXPThemeNoMetricsProp, [ColorID]));
    Result := 0;
  end;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeMetrics.GetFont(FontID: integer): LogFont;
begin
  if (FontID >= Low(FFontsDefined)) and (FontID <= High(FFontsDefined))
    and FFontsDefined[FontID] then
    Result := FFonts[FontID]
  else
    LMDDebug(Format(SLMDWinXPThemeNoMetricsProp, [FontID]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeMetrics.GetInt(IntID: integer): integer;
begin
  if (IntID >= Low(FIntsDefined)) and (IntID <= High(FIntsDefined))
    and FIntsDefined[IntID] then
    Result := FInts[IntID]
  else
    LMDDebug(Format(SLMDWinXPThemeNoMetricsProp, [IntID]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeMetrics.GetSize(SizeID: integer): integer;
begin
  Result := 0;
  if (SizeID >= Low(FSizesDefined)) and (SizeID <= High(FSizesDefined))
    and FSizesDefined[SizeID] then
    Result := FSizes[SizeID]
  else
    LMDDebug(Format(SLMDWinXPThemeNoMetricsProp, [SizeID]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeMetrics.GetString(StringID: integer): string;
begin
  if (StringID >= Low(FStringsDefined)) and (StringID <= High(FStringsDefined))
    and FStringsDefined[StringID] then
    Result := FStrings[StringID]
  else
    LMDDebug(Format(SLMDWinXPThemeNoMetricsProp, [StringID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeMetrics.ParseMetrics(const Scheme: TLMDIniCtrl);
const
  BoolNames: array [TMT_FIRSTBOOL..TMT_LASTBOOL] of string = ('FlatMenus');
  ColorNames: array [TMT_FIRSTCOLOR..TMT_LASTCOLOR] of string = (
    'ScrollBar', 'Background', 'ActiveCaption', 'InactiveCaption', 'Menu',
    'Window', 'WindowFrame', 'MenuText', 'WindowText', 'CaptionText',
    'ActiveBorder', 'InactiveBorder', 'AppWorkspace', 'Highlight',
    'HighlightText', 'BtnFace', 'BtnShadow', 'GrayText', 'BtnText',
    'InactiveCaptionText', 'BtnHighlight', 'DkShadow3D', 'Light3D',
    'InfoText', 'InfoBk', 'ButtonAlternateFace', 'HotTracking',
    'GradientActiveCaption', 'GradientInactiveCaption', 'MenuHilight',
    'MenuBar'
  );
  FontNames: array [TMT_FIRSTFONT..TMT_LASTFONT] of string = (
    'CaptionFont', 'SmallCaptionFont', 'MenuFont',
    'StatusFont', 'MsgBoxFont', 'IconTitleFont', 'Heading1Font', 'Heading2Font', 'BodyFont' 
  );
  IntNames: array [TMT_FIRSTINT..TMT_LASTINT] of string = (
    'DpiX', 'DpiY', 'MinColorDepth'
  );
  SizeNames: array [TMT_FIRSTSIZE..TMT_LASTSIZE] of string = (
    'BorderWidth', 'ScrollbarWidth', 'ScrollbarHeight', 'CaptionBarWidth',
    'CaptionBarHeight', 'SMCaptionBarWidth', 'SMCaptionBarHeight',
    'MenuBarWidth', 'MenuBarHeight', 'PaddedBorderWidth'
  );
  StringNames: array [TMT_FIRSTSTRING..TMT_LASTSTRING] of string = (
    'CssName', 'XmlName', 'LastUpdated', 'Alias'
  );
var
  I: integer;
  S: string;
  XPFont: TXPFont;
  DC: HDC;
  DPI: integer;
begin
  ClearMetrics;
  for I := TMT_FIRSTBOOL to TMT_LASTBOOL do
  begin
    FBoolsDefined[I] := Scheme.ValueExists('SysMetrics', BoolNames[I]);
    if FBoolsDefined[I] then
      begin
        S := Scheme.ReadString('SysMetrics', BoolNames[I], '');
        FBools[I] := StrToBoolean(S, False);
      end
  end;
  for I := TMT_FIRSTCOLOR to TMT_LASTCOLOR do
  begin
    FColorsDefined[I] := Scheme.ValueExists('SysMetrics', ColorNames[I]);
    if FColorsDefined[I] then
      begin
        S := Scheme.ReadString('SysMetrics', ColorNames[I], '');
        FColors[I] := StrToColor(S, clBlack);
      end
  end;
  DC := GetDC(0);
  DPI := GetDeviceCaps(DC, LOGPIXELSY);
  ReleaseDC(0, DC);
  for I := TMT_FIRSTFONT to TMT_LASTFONT do
  begin
    FFontsDefined[I] := Scheme.ValueExists('SysMetrics', FontNames[I]);
    if FFontsDefined[I] then
    begin
      FillChar(XPFont, SizeOf(XPFont), 0);
      S := Scheme.ReadString('SysMetrics', FontNames[I], '');
      if StrToFont(S, XPFont) then
      begin
        FFonts[I].lfHeight := -MulDiv(XPFont.Size, DPI, 72);
        FFonts[I].lfWidth := 0;
        FFonts[I].lfEscapement := 0;
        FFonts[I].lfOrientation := 0;
        if fsBold in XPFont.Style then
          FFonts[I].lfWeight := FW_BOLD
        else
          FFonts[I].lfWeight := FW_NORMAL;
        FFonts[I].lfItalic := Byte(fsItalic in XPFont.Style);
        FFonts[I].lfUnderline := 0;
        FFonts[I].lfStrikeOut := 0;
        FFonts[I].lfCharSet := DEFAULT_CHARSET;
        FFonts[I].lfOutPrecision := OUT_DEFAULT_PRECIS;
        FFonts[I].lfClipPrecision := CLIP_DEFAULT_PRECIS;
        FFonts[I].lfQuality := DEFAULT_QUALITY;
        FFonts[I].lfPitchAndFamily := DEFAULT_PITCH;
        StrLCopy(FFonts[I].lfFaceName, @XPFont.Name[1], 32);
        end
      else
        FFontsDefined[I] := False;
    end;
  end;
  for I := TMT_FIRSTINT to TMT_LASTINT do
  begin
    FIntsDefined[I] := Scheme.ValueExists('SysMetrics', IntNames[I]);
    if FIntsDefined[I] then
      FInts[I] := Scheme.ReadInteger('SysMetrics', IntNames[I], 0);
  end;
  for I := TMT_FIRSTSIZE to TMT_LASTSIZE do
  begin
    FSizesDefined[I] := Scheme.ValueExists('SysMetrics', SizeNames[I]);
    if FSizesDefined[I] then
      FSizes[I] := Scheme.ReadInteger('SysMetrics', SizeNames[I], 0);
  end;
  for I := TMT_FIRSTSTRING to TMT_LASTSTRING do
  begin
    FStringsDefined[I] := Scheme.ValueExists('SysMetrics', StringNames[I]);
    if FStringsDefined[I] then
      FStrings[I] := Scheme.ReadString('SysMetrics', StringNames[I], '');
  end;
end;

{-------------------- TWindowsXPTheme -----------------------------------------}
function TWindowsXPTheme.GetThemeSysBool(BoolID: integer): boolean;
begin
  if Manager <> nil then
    Result := TWindowsXPThemeManager(Manager).FMetrics.GetBool(BoolID)
  else
    Result := inherited GetThemeSysBool(BoolID);
end;

{------------------------------------------------------------------------------}
function TWindowsXPTheme.GetThemeSysColor(ColorID: integer): ColorRef;
begin
  if Manager <> nil then
    Result := TWindowsXPThemeManager(Manager).FMetrics.GetColor(ColorID)
  else
    Result := inherited GetThemeSysColor(ColorID);
end;

function TWindowsXPTheme.GetThemeSysColorBrush(ColorID: integer): HBrush;
begin
  if Manager <> nil then
    Result := TWindowsXPThemeManager(Manager).FMetrics.GetColorBrush(ColorID)
  else
    Result := inherited GetThemeSysColorBrush(ColorID);
end;

{------------------------------------------------------------------------------}
function TWindowsXPTheme.GetThemeSysFont(FontID: integer; out Font: LogFontW): HResult;
var
  LFont: LogFont;
  WS: WideString;
  begin
  if Manager <> nil then
  begin
    LFont := TWindowsXPThemeManager(Manager).FMetrics.GetFont(FontID);
    Move(LFont, Font, SizeOf(LFont));
    WS := LFont.lfFaceName;
    LMDWideStrLCopy(Font.lfFaceName, PWideChar(WS), 32);
  end
  else
    Result := inherited GetThemeSysFont(FontID, Font);
end;

{------------------------------------------------------------------------------}
function TWindowsXPTheme.GetThemeSysInt(IntID: integer;
  out Value: integer): HResult;
begin
  Result := S_OK;
  if Manager <> nil then
    Value := TWindowsXPThemeManager(Manager).FMetrics.GetInt(IntID)
  else
    Result := inherited GetThemeSysInt(IntID, Value);
end;

{------------------------------------------------------------------------------}
function TWindowsXPTheme.GetThemeSysSize(SizeID: integer): integer;
begin
  if Manager <> nil then
    Result := TWindowsXPThemeManager(Manager).FMetrics.GetSize(SizeID)
  else
    Result := inherited GetThemeSysSize(SizeID);
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPTheme.GetThemeSysString(StringID: integer;
  Value: PWideChar; MaxStringChars: integer);
begin
  inherited;
end;

{----------------- TWindowsXPThemePart ----------------------------------------}
constructor TWindowsXPThemePart.Create(Theme: TWindowsXPTheme;
  Parent: TWindowsXPThemePart; ASection: string);
var
  Manager: TWindowsXPThemeManager;
begin
  inherited Create(Theme, Parent);
  FSection := ASection;
  FProps := TBits.Create;
  FProps.Size := TPP_LAST_PROP_TAG - TPP_FIRST_PROP_TAG + 1;
  FGlyphImage := nil;
  FImage := nil;
  FImage1 := nil;
  FImage2 := nil;
  FImage3 := nil;
  FImage4 := nil;
  FImage5 := nil;
  SetLength(FGlyphRects, 0);
  SetLength(FImageRects, 0);
  SetLength(FImage1Rects, 0);
  SetLength(FImage2Rects, 0);
  SetLength(FImage3Rects, 0);
  SetLength(FImage4Rects, 0);
  SetLength(FImage5Rects, 0);
  Manager := TWindowsXPThemeManager(Theme.Manager);
  if Manager <> nil then
    ParseScheme(Manager.FSchemeIni, ASection);
end;

{------------------------------------------------------------------------------}
destructor TWindowsXPThemePart.Destroy;
begin
  FreeAndNil(FGlyphImage);
  FreeAndNil(FImage);
  FreeAndNil(FImage1);
  FreeAndNil(FImage2);
  FreeAndNil(FImage3);
  FreeAndNil(FImage4);
  FreeAndNil(FImage5);
  SetLength(FGlyphRects, 0);
  SetLength(FImageRects, 0);
  SetLength(FImage1Rects, 0);
  SetLength(FImage2Rects, 0);
  SetLength(FImage3Rects, 0);
  SetLength(FImage4Rects, 0);
  SetLength(FImage5Rects, 0);
  FreeAndNil(FProps);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DivideImage(Image: TBitmap; Count: integer;
  var Rects: TXPRectArray);
var
  Layout: TXPImageLayout;
  H, W, I: integer;
begin
  if Available[TPP_IMAGE_LAYOUT] then
    Layout := ImageLayout
  else
    Layout := ilHorizontal;

  H := Image.Height;
  W := Image.Width;
  SetLength(Rects, Count);
  if Layout = ilHorizontal then
    begin
      W := Image.Width div Count;
      for I := 0 to Count - 1 do
        Rects[I] := Rect(W * I, 0, W * (I + 1), H);
    end
  else
    begin
      H := Image.Height div Count;
      for I := 0 to Count - 1 do
        Rects[I] := Rect(0, H * I, W, H * (I + 1));
    end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DivideImages;
var
  Count: integer;
begin
  if Available[TPP_IMAGE_COUNT] then
    Count := IntProp[TPP_IMAGE_COUNT]
  else
    Count := 1;
  if Count = 0 then
    begin
      LMDDebug(Format(SLMDInvalidImageCount, [Count]));
      Count := 1;
    end;
  if FGlyphImage <> nil then
    DivideImage(FGlyphImage, Count, FGlyphRects);
  if FImage <> nil then
    DivideImage(FImage, Count, FImageRects);
  if FImage1 <> nil then
    DivideImage(FImage1, Count, FImage1Rects);
  if FImage2 <> nil then
    DivideImage(FImage2, Count, FImage2Rects);
  if FImage3 <> nil then
    DivideImage(FImage3, Count, FImage3Rects);
  if FImage4 <> nil then
    DivideImage(FImage4, Count, FImage4Rects);
  if FImage5 <> nil then
    DivideImage(FImage5, Count, FImage5Rects);
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawBorderFillBackground(DC: HDC;
  StateID: integer; const R: TRect; ClipRect: PRect);
begin
  if Available[TPP_FILL_TYPE] then
    case FillType of
      ftSolid:
        DrawSolidBackground(DC, StateID, R, ClipRect);
      ftVertGradient:
        DrawGradientBackground(DC, StateID, R, ClipRect, True);
      ftHorzGradient:
        DrawGradientBackground(DC, StateID, R, ClipRect, False);
    end
  else
    DrawSolidBackground(DC, StateID, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawGradientBackground(DC: HDC;
  StateID: integer; R: TRect; ClipRect: PRect; Vertical: boolean);
var
  I: integer;
  RBeg, RDif, Rc: integer;
  GBeg, GDif, Gc: integer;
  BBeg, BDif, Bc : integer;
  Brush, OldBrush: HBrush;
  R1: TRect;
  StartColor, EndColor: TColor;
  Steps: integer;
begin
  if not Available[TPP_GRADIENT_COLOR1] or not Available[TPP_GRADIENT_COLOR2] then
    exit;
  StartColor := ColorProp[TPP_GRADIENT_COLOR1];
  EndColor := ColorProp[TPP_GRADIENT_COLOR2];
  if not Available[TPP_GRADIENT_RATIO1] or not Available[TPP_GRADIENT_RATIO2] then
    if Vertical then
      Steps := R.Bottom - R.Top
    else
      Steps := R.Right - R.Left
  else
    Steps := Abs(IntProp[TPP_GRADIENT_RATIO2] - IntProp[TPP_GRADIENT_RATIO1]);
  if StartColor = EndColor then
  begin
    Brush := CreateSolidBrush(ColorToRGB(StartColor));
    FillRect(DC, R, Brush);
    DeleteObject(Brush);
  end
  else
  begin
    RBeg := GetRValue(ColorToRGB(StartColor));
    GBeg := GetGValue(ColorToRGB(StartColor));
    BBeg := GetBValue(ColorToRGB(StartColor));
    RDif := GetRValue(ColorToRGB(EndColor)) - RBeg;
    GDif := GetGValue(ColorToRGB(EndColor)) - GBeg;
    BDif := GetBValue(ColorToRGB(EndColor)) - BBeg;
    R1 := R;
    for I := 0 to Steps - 1 do // Iterate
    begin
      if Vertical then
      begin
        R1.Top := R.Top + MulDiv(I, R.Bottom - R.Top, Steps);
        R1.Bottom := R.Top + MulDiv(I + 1, R.Bottom - R.Top, Steps);
      end else
      begin
        R1.Left := R.Left + MulDiv(I, R.Right - R.Left, Steps);
        R1.Right := R.Left + MulDiv(I + 1, R.Right - R.Left, Steps);
      end;

      Rc := RBeg + MulDiv(I, RDif, Steps - 1);
      Gc := GBeg + MulDiv(I, GDif, Steps - 1);
      Bc := BBeg + MulDiv(I, BDif, Steps - 1);

      Brush := CreateSolidBrush(RGB(Rc, Gc, Bc));
      OldBrush := SelectObject(DC, Brush);
      PatBlt(DC, R1.Left, R1.Top, R1.Right - R1.Left, R1.Bottom - R1.Top, PATCOPY);
      SelectObject(DC, OldBrush);
      DeleteObject(Brush);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawImageFileBackground(DC: HDC;
  StateID: integer; const R: TRect; ClipRect: PRect);
var
  Image: TBitmap;
  Rects: PXPRectArray;
  Sizing: TXPSizingType;
  Index: integer;
  Color: TColor;
begin
  Image := nil;
  Rects := nil;
  if Available[TPP_IMAGE_FILE] then
  begin
    Image := FImage;
    Rects := @FImageRects;
  end
  else
  if Available[TPP_IMAGE_SELECT] then
  begin
    SelectImage(DC, R, ImageSelect, Image, Rects);
  end;

  if (Image = nil) or (Rects = nil) or (Length(Rects^) = 0) then
    exit;

  Index := GetStateRectIndex(StateID);
  if Index >= Length(Rects^) then
    Index := 0;

  if Available[TPP_SIZING_TYPE] then
    Sizing := SizingType
  else
    Sizing := stStretch;
  if (Available[TPP_TRANSPARENT] and BoolProp[TPP_TRANSPARENT]) or
      Available[TPP_TRANSPARENT_COLOR] then
  begin
    if Available[TPP_TRANSPARENT_COLOR] then
      Color := ColorProp[TPP_TRANSPARENT_COLOR]
    else
      Color := RGB(255, 0, 255);
  end
  else
    Color := RGB(255, 0, 255);

  case Sizing of
    stStretch : DrawStretchedImage(DC, R, ClipRect, Image, Rects^[Index], Color);
    stTrueSize: DrawTrueSizedImage(DC, R, ClipRect, Image, Rects^[Index], Color);
    stTile    : DrawTiledImage(DC, R, ClipRect, Image, Rects^[Index], Color);
  end;
  end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawImageGlyph(DC: HDC; StateID: integer;
  R: TRect; ClipRect: PRect);
var
  Image: TBitmap;
  Rects: PXPRectArray;
  Index: integer;
  Color: TColor;
  Margins: TXPMargins;
  SrcR: TRect;
  Horz: TXPHAlign;
  Vert: TXPVAlign;
begin
  Image := nil;
  Rects := nil;
  if Available[TPP_GLYPH_IMAGE_FILE] then
  begin
    Image := FGlyphImage;
    Rects := @FGlyphRects;
  end
  else
  if Available[TPP_IMAGE_SELECT] then
  begin
    if Available[TPP_CONTENT_MARGINS] then
    begin
      Margins := MarginsProp[TPP_CONTENT_MARGINS];
      Inc(R.Left, Margins.cxLeftWidth);
      Inc(R.Top, Margins.cyTopHeight);
      Dec(R.Right, Margins.cxRightWidth);
      Dec(R.Bottom, Margins.cyBottomHeight);
    end;
    SelectImage(DC, R, ImageSelect, Image, Rects);
  end;

  if (Image = nil) or (Rects = nil) or (Length(Rects^) = 0) then
    exit;

  Index := GetStateRectIndex(StateID);
  if Index >= Length(Rects^) then
    Index := 0;

  if (Available[TPP_GLYPH_TRANSPARENT] and BoolProp[TPP_GLYPH_TRANSPARENT]) or
      Available[TPP_TRANSPARENT_COLOR] then
  begin
    if Available[TPP_TRANSPARENT_COLOR] then
      Color := ColorProp[TPP_TRANSPARENT_COLOR]
    else
      Color := RGB(255, 0, 255);
  end
  else
    Color := clNone;

  SrcR := Rects^[Index];
  if (R.Right - R.Left > SrcR.Right - SrcR.Left) then
  begin
    if Available[TPP_HALIGN] then
      Horz := HAlign
    else
      Horz := haCenter;
    if Horz = haCenter then
      Inc(R.Left, ((R.Right - R.Left) - (SrcR.Right - SrcR.Left)) div 2)
    else
    if Horz = haRight then
      R.Left := R.Right - (SrcR.Right - SrcR.Left);
  end;
  if (R.Bottom - R.Top > SrcR.Bottom - SrcR.Top) then
  begin
    if Available[TPP_VALIGN] then
      Vert := VAlign
    else
      Vert := vaCenter;
    if Vert = vaCenter then
      Inc(R.Top, ((R.Bottom - R.Top) - (SrcR.Bottom - SrcR.Top)) div 2)
    else
    if Vert = vaBottom then
      R.Top := R.Bottom - (SrcR.Bottom - SrcR.Top);
  end;

  if LMDIsAlphaEmpty(Image) then
  begin
    DrawRect(DC, R.Left, R.Top, Image.Canvas.Handle, SrcR.Left,
      SrcR.Top, SrcR.Right - SrcR.Left, SrcR.Bottom - SrcR.Top, Color)
  end
  else begin
    AlphaDrawRect(DC, R.Left, R.Top, Image.Canvas.Handle, SrcR.Left, SrcR.Top,
      SrcR.Right - SrcR.Left, SrcR.Bottom - SrcR.Top);
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawSolidBackground(DC: HDC;
  StateID: integer; const R: TRect; ClipRect: PRect);
var
  Border, Fill: TColor;
  Size: integer;
  Pen: HPen;
  Brush: HBrush;
  BrushProps: TLogBrush;
begin
  if Available[TPP_BORDER_SIZE] then
    Size := IntProp[TPP_BORDER_SIZE]
  else
    Size := 1;
  if Available[TPP_BORDER_COLOR] then
    Border := ColorProp[TPP_BORDER_COLOR]
  else
    Border := clNone;
  case StateID of
    ETS_READONLY:
      begin
      if LMDThemeEngine.ReadOnlyColorMode in [scmTheme, scmNoChange] then
        begin
          if Available[TPP_FILL_COLOR] then
            Fill := ColorProp[TPP_FILL_COLOR]
          else
            Fill := clNone;
        end
      else
        Fill := LMDThemeEngine.CustomReadOnlyColor;
      end;
    ETS_DISABLED:
      begin
      if LMDThemeEngine.DisabledColorMode in [scmTheme, scmNoChange] then
        begin
          if Available[TPP_FILL_COLOR] then
            Fill := ColorProp[TPP_FILL_COLOR]
          else
            Fill := clNone;
        end
      else
        Fill := LMDThemeEngine.CustomDisabledColor;
      end
    else
      begin
      if Available[TPP_FILL_COLOR] then
        Fill := ColorProp[TPP_FILL_COLOR]
      else
        Fill := clNone;
      end;
  end;

  if Available[TPP_BORDER_ONLY] and BoolProp[TPP_BORDER_ONLY] then
    Fill := clNone;
  if (Border = clNone) or (Size = 0) then
    Pen := 0
  else
    Pen := CreatePen(PS_SOLID, Size, Border);
  Pen := SelectObject(DC, Pen);
  if Fill = clNone then
  begin
    BrushProps.lbStyle := BS_NULL;
    BrushProps.lbColor := 0;
    BrushProps.lbHatch := 0;
    Brush := CreateBrushIndirect(BrushProps);
  end
  else
    Brush := CreateSolidBrush(Fill);
  Brush := SelectObject(DC, Brush);
  if Available[TPP_BORDER_TYPE] then
  begin
    case BorderType of
      btRect     : Rectangle(DC, R.Left, R.Top, R.Right, R.Bottom);
      btRoundRect: begin
                     if Available[TPP_ROUND_CORNER_HEIGHT] and
                        Available[TPP_ROUND_CORNER_WIDTH] then
                     begin
                       RoundRect(DC, R.Left, R.Top, R.Right, R.Bottom,
                         IntProp[TPP_ROUND_CORNER_WIDTH], IntProp[TPP_ROUND_CORNER_HEIGHT]);
                     end
                     else
                       Rectangle(DC, R.Left, R.Top, R.Right, R.Bottom);
                   end;
      btEllipse  : Ellipse(DC, R.Left, R.Top, R.Right, R.Bottom);
    end;
  end
  else
  begin
    if Pen = 0 then
    begin
      Brush := SelectObject(DC, Brush);
      FillRect(DC, R, Brush);
      Brush := SelectObject(DC, Brush);
    end
    else
      Rectangle(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  Brush := SelectObject(DC, Brush);
  if Brush <> 0 then
    DeleteObject(Brush);
  Pen := SelectObject(DC, Pen);
  if Pen <> 0 then
    DeleteObject(Pen);
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawStretchedImage(DC: HDC; DstRect: TRect;
  ClipRect: PRect; Image: TBitmap; SrcRect: TRect; TransparentColor: TColor);
var
  Margins: TXPMargins;
  h, w: integer;
begin
  if Available[TPP_SIZING_MARGINS] then
    Margins := MarginsProp[TPP_SIZING_MARGINS]
  else
    with Margins do
      begin
        cxLeftWidth := 0;
        cxRightWidth := 0;
        cyTopHeight := 0;
        cyBottomHeight := 0;
      end;

  w := (SrcRect.Right - SrcRect.Left);
  h := (SrcRect.Bottom - SrcRect.Top);

  with Margins do
    begin
      if cxLeftWidth + cxRightWidth >= w then
        begin
          cxLeftWidth := 0;
          cxRightWidth := 0;
        end;
      if cyTopHeight + cyBottomHeight >= h then
        begin
          Margins.cyTopHeight := 0;
          Margins.cyBottomHeight := 0;
        end;
    end;

  if LMDIsAlphaEmpty(Image) then
  begin
    StretchRect(DC, DstRect.Left, DstRect.Top, DstRect.Right - DstRect.Left,
      DstRect.Bottom - DstRect.Top, Image.Canvas.Handle, SrcRect.Left,
      SrcRect.Top, SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top,
      Margins.cxLeftWidth, Margins.cyTopHeight, Margins.cxRightWidth, Margins.cyBottomHeight,
      TransparentColor, Available[TPP_BORDER_ONLY] and BoolProp[TPP_BORDER_ONLY])
  end
  else begin
    AlphaStretchRect(DC, DstRect.Left, DstRect.Top, DstRect.Right - DstRect.Left,
      DstRect.Bottom - DstRect.Top, Image.Canvas.Handle, SrcRect.Left,
      SrcRect.Top, SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top,
      Margins.cxLeftWidth, Margins.cyTopHeight, Margins.cxRightWidth, Margins.cyBottomHeight,
      Available[TPP_BORDER_ONLY] and BoolProp[TPP_BORDER_ONLY])
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
var
  lCr: TRect;
//  lOldClpRgn, lRgn: HRGN;
begin
  lCr := Rect;
//  lRgn := 0;
//  lOldClpRgn := 0;

{  if ClipRect <>  LMDNullRectPtr then
    begin
      lCr := ClipRect^;
      lRgn := CreateRectRgn(lCr.Left, lCr.Top, lCr.Right, lCr.Bottom);
      lOldClpRgn := SelectClipRgn(DC, lRGn);
    end;    }

  if Available[TPP_BG_TYPE] then
  begin
    case BgType of
      bgBorderFill: DrawBorderFillBackground(DC, StateID, Rect, ClipRect);
      bgImageFile : DrawImageFileBackground(DC, StateID, Rect, ClipRect);
    end;
  end;
  if Available[TPP_GLYPH_TYPE] then
  begin
    case GlyphType of
      gtImageGlyph: DrawImageGlyph(DC, StateID, Rect, ClipRect);
      gtFontGlyph : ;
    end;
  end;

 { if ClipRect <>  LMDNullRectPtr then
    begin
      SelectClipRgn(DC, lOldClpRgn);
      DeleteObject(lRgn);
    end;}
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawThemeEdge(DC: HDC; StateID: integer;
  const DestRect: TRect; Edge, Flags: cardinal;  ContentRect: PRect);
var
  Rect: TRect;
begin
  Rect := DestRect;
  DrawEdge(DC, Rect, Edge, Flags);
  if (ContentRect <> nil) and (Flags and BF_ADJUST <> 0) then
    ContentRect^ := Rect;
  end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawThemeIcon(DC: HDC; StateID: integer;
  const Rect: TRect; ImageList: THandle; ImageIndex: integer);
begin
  ImageList_Draw(ImageList, ImageIndex, DC, Rect.Left, Rect.Top, ILD_NORMAL);
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawThemeText(DC: HDC; StateID: integer;
  Text: PLMDChar; CharCount: integer; TextFlags, TextFlags2: cardinal;
  const ARect: TRect);
var
  Color: cardinal;
  Rect: TRect;
begin
  Rect := ARect;
  if (Text = nil) or (CharCount = 0) then
    exit;
  if Available[TPP_TEXT_COLOR] then
    begin
      Color := ColorProp[TPP_TEXT_COLOR];
      SetTextColor(DC, Color);
    end;
  SetBkMode(DC, TRANSPARENT);
  {with Rect do
    begin
      inc(Left);
      inc(Top);
    end;}
  {$IFDEF LMD_UNICODE}
  DrawTextW(DC, Text, CharCount, Rect, TextFlags);
  {$ELSE}
  DrawText(DC, Text, CharCount, Rect, TextFlags);
  {$ENDIF}  
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawTiledImage(DC: HDC; DstRect: TRect;
  ClipRect: PRect; Image: TBitmap; SrcRect: TRect; TransparentColor: TColor);
var
  Margins: TXPMargins;
begin
  if Available[TPP_SIZING_MARGINS] then
    Margins := MarginsProp[TPP_SIZING_MARGINS]
  else
    with Margins do
      begin
        cxLeftWidth := 0;
        cxRightWidth := 0;
        cyTopHeight := 0;
        cyBottomHeight := 0;
      end;

  if LMDIsAlphaEmpty(Image) then
  begin
    TileRect(DC, DstRect.Left, DstRect.Top, DstRect.Right - DstRect.Left,
      DstRect.Bottom - DstRect.Top, Image.Canvas.Handle, SrcRect.Left,
      SrcRect.Top, SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top,
      Margins.cxLeftWidth, Margins.cyTopHeight, Margins.cxRightWidth, Margins.cyBottomHeight,
      TransparentColor, Available[TPP_BORDER_ONLY] and BoolProp[TPP_BORDER_ONLY])
  end
  else begin
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.DrawTrueSizedImage(DC: HDC; DstRect: TRect;
  ClipRect: PRect; Image: TBitmap; SrcRect: TRect;
  TransparentColor: TColor);
var
  Horz: TXPHAlign;
  Vert: TXPVAlign;
begin
  if (DstRect.Right - DstRect.Left > SrcRect.Right - SrcRect.Left) then
  begin
    if Available[TPP_HALIGN] then
      Horz := HAlign
    else
      Horz := haCenter;
    if Horz = haCenter then
      Inc(DstRect.Left, ((DstRect.Right - DstRect.Left) - (SrcRect.Right - SrcRect.Left)) div 2)
    else
    if Horz = haRight then
      DstRect.Left := DstRect.Right - (SrcRect.Right - SrcRect.Left);
  end;
  if (DstRect.Bottom - DstRect.Top > SrcRect.Bottom - SrcRect.Top) then
  begin
    if Available[TPP_VALIGN] then
      Vert := VAlign
    else
      Vert := vaCenter;
    if Vert = vaCenter then
      Inc(DstRect.Top, ((DstRect.Bottom - DstRect.Top) - (SrcRect.Bottom - SrcRect.Top)) div 2)
    else
    if Vert = vaBottom then
      DstRect.Top := DstRect.Bottom - (SrcRect.Bottom - SrcRect.Top);
  end;

  if LMDIsAlphaEmpty(Image) then
  begin
    DrawRect(DC, DstRect.Left, DstRect.Top, Image.Canvas.Handle, SrcRect.Left,
      SrcRect.Top, SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top,
      TransparentColor);
  end
  else begin
    AlphaDrawRect(DC, DstRect.Left, DstRect.Top, Image.Canvas.Handle, SrcRect.Left,
      SrcRect.Top, SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top);
  end;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetAvailable(Index: integer): boolean;
begin
  try
    if FProps <> nil then
      Result := FProps.Bits[Index]
    else
      Result := False;
  except
    Result := False;
  end;
  if not Result and (Parent <> nil) then
    Result := TWindowsXPThemePart(Parent).Available[Index];
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetBgType: TXPBgType;
begin
  if Defined[TPP_BG_TYPE] then
    Result := FBgType
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).BgType
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_BGTYPE]))
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetBoolProp(Tag: integer): boolean;
var
  Index, I: integer;
begin
  Result := false;
  Index := -1;
  for I := 0 to XPBoolPropCount - 1 do
    if XPBoolPropTags[I] = Tag then
    begin
      Index := I;
      break;
    end;
  if Index < 0 then
    begin
      LMDDebug(SLMDWinXPThemeInvalidParameter);
      exit;
    end;
  if Defined[Tag] then
    Result := FBoolProps[Index]
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).BoolProp[Tag]
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [XPBoolPropIDs[Index]]))
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetBorderType: TXPBorderType;
begin
  if Defined[TPP_BORDER_TYPE] then
    Result := FBorderType
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).BorderType
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_BORDERTYPE]))
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetColorProp(Tag: integer): TColor;
var
  Index, I: integer;
begin
  Result := clNone;
  Index := -1;
  for I := 0 to XPColorPropCount - 1 do
    if XPColorPropTags[I] = Tag then
    begin
      Index := I;
      break;
    end;
  if Index < 0 then
    begin
      LMDDebug(SLMDWinXPThemeInvalidParameter);
      exit;
    end;
  if Defined[Tag] then
    Result := FColorProps[Index]
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).ColorProp[Tag]
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [XPColorPropIDs[Index]]))
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetContentAligment: TXPContentAlignment;
begin
  if Defined[TPP_CONTENT_ALIGNMENT] then
    Result := FContentAlignment
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).ContentAlignment
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_CONTENTALIGNMENT]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetDefined(Index: integer): boolean;
begin
  if (Index >= 0) and (Index < FProps.Size) then
    Result := FProps.Bits[Index]
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetFillType: TXPFillType;
begin
  if Defined[TPP_FILL_TYPE] then
    Result := FFillType
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).FillType
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_FILLTYPE]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetGlyphType: TXPGlyphType;
begin
  if Defined[TPP_GLYPH_TYPE] then
    Result := FGlyphType
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).GlyphType
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_GLYPHTYPE]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetHAlign: TXPHAlign;
begin
  if Defined[TPP_HALIGN] then
    Result := FHAlign
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).HAlign
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_HALIGN]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetIconEffect: TXPIconEffect;
begin
  if Defined[TPP_ICON_EFFECT] then
    Result := FIconEffect
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).IconEffect
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_ICONEFFECT]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetImageLayout: TXPImageLayout;
begin
  if Defined[TPP_IMAGE_LAYOUT] then
    Result := FImageLayout
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).ImageLayout
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_IMAGELAYOUT]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetImageSelect: TXPImageSelect;
begin
  if Defined[TPP_IMAGE_SELECT] then
    Result := FImageSelect
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).ImageSelect
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_IMAGESELECTTYPE]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetIntProp(Tag: integer): integer;
var
  Index, I: integer;
begin
  Result := 0;
  Index := -1;
  for I := 0 to XPIntPropCount - 1 do
    if XPIntPropTags[I] = Tag then
    begin
      Index := I;
      break;
    end;
  if Index < 0 then
    begin
      LMDDebug(SLMDWinXPThemeInvalidParameter);
      exit;
    end;
  if Defined[Tag] then
    Result := FIntProps[Index]
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).IntProp[Tag]
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [XPIntPropIDs[Index]]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetMarginsProp(Tag: integer): TXPMargins;
var
  Index, I: integer;
begin
  Index := -1;
  for I := 0 to XPMarginsPropCount - 1 do
    if XPMarginsPropTags[I] = Tag then
    begin
      Index := I;
      break;
    end;
  if Index < 0 then
    begin
      LMDDebug(SLMDWinXPThemeInvalidParameter);
      exit;
    end;
  if Defined[Tag] then
    Result := FMarginsProps[Index]
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).MarginsProp[Tag]
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [XPMarginsPropIDs[Index]]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetOffsetType: TXPOffsetType;
begin
  if Defined[TPP_OFFSET_TYPE] then
    Result := FOffsetType
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).OffsetType
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_OFFSETTYPE]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetPointProp(Tag: integer): TPoint;
var
  Index, I: integer;
begin
  Index := -1;
  for I := 0 to XPPointPropCount - 1 do
    if XPPointPropTags[I] = Tag then
    begin
      Index := I;
      break;
    end;
  if Index < 0 then
    begin
      LMDDebug(SLMDWinXPThemeInvalidParameter);
      exit;
    end;  
  if Defined[Tag] then
    Result := FPointProps[Index]
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).PointProp[Tag]
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [XPPointPropIDs[Index]]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetSizeProp(Tag: integer): TXPSize;
var
  Index, I: integer;
begin
  Index := -1;
  for I := 0 to XPSizePropCount - 1 do
    if XPSizePropTags[I] = Tag then
    begin
      Index := I;
      break;
    end;
  if Index < 0 then
    begin
      LMDDebug(SLMDWinXPThemeInvalidParameter);
      exit;
    end;
  if Defined[Tag] then
    Result := FSizeProps[Index]
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).SizeProp[Tag]
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [XPSizePropIDs[Index]]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetSizingType: TXPSizingType;
begin
  if Defined[TPP_SIZING_TYPE] then
    Result := FSizingType
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).SizingType
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_SIZINGTYPE]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetStateRectIndex(StateID: integer): integer;
begin
  Result := 0;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetStrProp(Tag: integer): string;
var
  Index, I: integer;
begin
  Result := '';
  Index := -1;
  for I := 0 to XPStrPropCount - 1 do
    if XPStrPropTags[I] = Tag then
    begin
      Index := I;
      break;
    end;
  if Index < 0 then
    begin
      LMDDebug(SLMDWinXPThemeInvalidParameter);
      exit;
    end;
  if Defined[Tag] then
    Result := FStrProps[Index]
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).StrProp[Tag]
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [XPStrPropIDs[Index]]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetTextShadowType: TXPShadowType;
begin
  if Defined[TPP_TEXT_SHADOW_TYPE] then
    Result := FTextShadowType
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).TextShadowType
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_TEXTSHADOWTYPE]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeBackgroundContentRect(DC: HDC;
  StateID: integer; const BoundingRect: TRect; out ContentRect: TRect);
var
  Margins: TXPMargins;
  LBorder: Integer;
begin
  ContentRect := BoundingRect;
  if Defined[TPP_BORDER_SIZE] then
  begin
    LBorder := GetIntProp(TPP_BORDER_SIZE);
    Inc(ContentRect.Left, LBorder);
    Inc(ContentRect.Top, LBorder);
    Dec(ContentRect.Right, LBorder);
    Dec(ContentRect.Bottom, LBorder);
  end;
  if Defined[TPP_CONTENT_MARGINS] then
  begin
    Margins := MarginsProp[TPP_CONTENT_MARGINS];
    Inc(ContentRect.Left, Margins.cxLeftWidth);
    Inc(ContentRect.Top, Margins.cyTopHeight);
    Dec(ContentRect.Right, Margins.cxRightWidth);
    Dec(ContentRect.Bottom, Margins.cyBottomHeight);
  end
  else
    if Defined[TPP_SIZING_MARGINS] then
    begin
      Margins := MarginsProp[TPP_SIZING_MARGINS];
      Inc(ContentRect.Left, Margins.cxLeftWidth);
      Inc(ContentRect.Top, Margins.cyTopHeight);
      Dec(ContentRect.Right, Margins.cxRightWidth);
      Dec(ContentRect.Bottom, Margins.cyBottomHeight);
    end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeBackgroundExtent(DC: HDC;
  StateID: integer; const ContentRect: TRect; out ExtentRect: TRect);
var
  Margins: TXPMargins;
begin
  ExtentRect := ContentRect;
  if Defined[TPP_CONTENT_MARGINS] then
  begin
    Margins := MarginsProp[TPP_CONTENT_MARGINS];
    Dec(ExtentRect.Left, Margins.cxLeftWidth);
    Dec(ExtentRect.Top, Margins.cyTopHeight);
    Inc(ExtentRect.Right, Margins.cxRightWidth);
    Inc(ExtentRect.Bottom, Margins.cyBottomHeight);
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeBackgroundRegion(DC: HDC;
  StateID: integer; const Rect: TRect; out Region: HRgn);
begin
  CreateRectRgn(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeBool(StateID, PropID: integer;
  out Value: boolean);
var
  I: integer;
begin
  for I := 0 to XPBoolPropCount - 1 do
    if (XPBoolPropIDs[I] = PropID) then
    begin
      if Defined[XPBoolPropTags[I]] then
      begin
        Value := FBoolProps[I];
        exit;
      end
      else
        LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
    end;
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeColor(StateID, PropID: integer;
  out Color: ColorRef);
var
  I: integer;
begin
  for I := 0 to XPColorPropCount - 1 do
    if (XPColorPropIDs[I] = PropID) then
    begin
      if Defined[XPColorPropTags[I]] then
      begin
        Color := FColorProps[I];
        exit;
      end
      else
        LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]))
    end;
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeEnumValue(StateID, PropID: integer;
  out Value: integer);
begin
  case PropID of
    TMT_BGTYPE:
      if Defined[TPP_BG_TYPE] then
      begin
        Value := Integer(FBgType);
        exit;
      end;
    TMT_BORDERTYPE:
      if Defined[TPP_BORDER_TYPE] then
      begin
        Value := Integer(FBorderType);
        exit;
      end;
    TMT_FILLTYPE:
      if Defined[TPP_FILL_TYPE] then
      begin
        Value := Integer(FFillType);
        exit;
      end;
    TMT_SIZINGTYPE:
      if Defined[TPP_SIZING_TYPE] then
      begin
        Value := Integer(FSizingType);
        exit;
      end;
    TMT_HALIGN:
      if Defined[TPP_HALIGN] then
      begin
        Value := Integer(FHAlign);
        exit;
      end;
    TMT_CONTENTALIGNMENT:
      if Defined[TPP_CONTENT_ALIGNMENT] then
      begin
        Value := Integer(FContentAlignment);
        exit;
      end;
    TMT_VALIGN:
      if Defined[TPP_VALIGN] then
      begin
        Value := Integer(FVAlign);
        exit;
      end;
    TMT_OFFSETTYPE:
      if Defined[TPP_OFFSET_TYPE] then
      begin
        Value := Integer(FOffsetType);
        exit;
      end;
    TMT_ICONEFFECT:
      if Defined[TPP_ICON_EFFECT] then
      begin
        Value := Integer(FIconEffect);
        exit;
      end;
    TMT_TEXTSHADOWTYPE:
      if Defined[TPP_TEXT_SHADOW_TYPE] then
      begin
        Value := Integer(FTextShadowType);
        exit;
      end;
    TMT_IMAGELAYOUT:
      if Defined[TPP_IMAGE_LAYOUT] then
      begin
        Value := Integer(FImageLayout);
        exit;
      end;
    TMT_GLYPHTYPE:
      if Defined[TPP_GLYPH_TYPE] then
      begin
        Value := Integer(FGlyphType);
        exit;
      end;
    TMT_IMAGESELECTTYPE:
      if Defined[TPP_IMAGE_SELECT] then
      begin
        Value := Integer(FImageSelect);
        exit;
      end;
    TMT_TRUESIZESCALINGTYPE:
      if Defined[TPP_TRUESIZE_SCALING_TYPE] then
      begin
        Value := Integer(FTrueSizeScalingType);
        exit;
      end;
  end;
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeFilename(StateID, PropID: integer;
  ThemeFileName: PWideChar; MaxNameChars: integer);
var
  WS: WideString;
  I: integer;
begin
  if (ThemeFileName = nil) or (MaxNameChars = 0) then
    LMDDebug(SLMDWinXPThemeInvalidParameter);
  case PropID of
    TMT_IMAGEFILE, TMT_IMAGEFILE1, TMT_IMAGEFILE2,
    TMT_IMAGEFILE3, TMT_IMAGEFILE4, TMT_IMAGEFILE5,
    TMT_STOCKIMAGEFILE, TMT_GLYPHIMAGEFILE:
      begin
        for I := 0 to XPStrPropCount - 1 do
          if XPStrPropIDs[I] = PropID then
            if Defined[XPStrPropTags[I]] then
            begin
              WS := FStrProps[I];
              LMDWideStrLCopy(ThemeFileName, PWideChar(WS), MaxNameChars);
              exit;
            end;
        LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
      end;
  else LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeFont(DC: HDC; StateID,
  PropID: integer; var Font: TLogFontW);
begin
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeInt(StateID, PropID: integer;
  out Value: integer);
var
  I: integer;
begin
  for I := 0 to XPIntPropCount - 1 do
    if (XPIntPropIDs[I] = PropID) then
    begin
      if Defined[XPIntPropTags[I]] then
        Value := FIntProps[I]
      else
        LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
    end;
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeIntList(StateID, PropID: integer;
  out List: TThemeIntList);
begin
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeMargins(DC: HDC; StateID,
  PropID: integer; var Margins: TMargins);
var
  I: integer;
begin
  for I := 0 to XPMarginsPropCount - 1 do
    if (XPMarginsPropIDs[I] = PropID) then
    begin
      if Defined[XPMarginsPropTags[I]] then
        Margins := TMargins(FMarginsProps[I])
      else
        LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
    end;
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeMetric(DC: HDC; StateID,
  PropID: integer; out Value: integer);
begin
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemePartSize(DC: HDC; StateID: integer;
  Rect: PRect; SizeType: TThemeSize; out Size: TSize);
var
  Image: TBitmap;
  Rects: PXPRectArray;
  Margins: TXPMargins;
  Sizing: TXPSizingType;
  Index: integer;
begin
  Size.cX := 0;
  Size.cY := 0;
  case SizeType of
    TS_MIN:
      begin
        if Available[TPP_BG_TYPE] then
        begin
          if BgType = bgImageFile then
          begin
            Image := nil;
            Rects := nil;
            if Available[TPP_IMAGE_FILE] then
            begin
              Image := FImage;
              Rects := @FImageRects;
            end
            else
            if Available[TPP_IMAGE_SELECT] then
            begin
              if Rect = nil then
                SelectImage(DC, Classes.Rect(0, 0, 0, 0), ImageSelect, Image, Rects)
              else
              SelectImage(DC, Rect^, ImageSelect, Image, Rects);
            end;
            if (Image <> nil) and (Rects <> nil) then
            begin
              if Available[TPP_SIZING_TYPE] then
                Sizing := SizingType
              else
                Sizing := stStretch;
              if (Sizing = stStretch) or (Sizing = stTile) then
              begin
                if Available[TPP_SIZING_MARGINS] then
                begin
                  Margins := MarginsProp[TPP_SIZING_MARGINS];
                  Size.cX := Size.cX + Margins.cxLeftWidth + Margins.cyTopHeight;
                  Size.cY := Size.cY + Margins.cyTopHeight + Margins.cyBottomHeight;
                end;
              end
              else
              begin
                Index := GetStateRectIndex(StateID);
                if Index < Length(Rects^) then
                  begin
                    Size.cX := Size.cX + Rects^[Index].Right - Rects^[Index].Left;
                    Size.cY := Size.cY + Rects^[Index].Bottom - Rects^[Index].Top;
                  end;
                end;
            end;
          end;
        end;
        if Available[TPP_GLYPH_TYPE] then
        begin
          if Available[TPP_CONTENT_MARGINS] then
          begin
            Margins := MarginsProp[TPP_CONTENT_MARGINS];
            Size.cX := Size.cX + Margins.cxLeftWidth + Margins.cyTopHeight;
            Size.cY := Size.cY + Margins.cyTopHeight + Margins.cyBottomHeight;
          end;
          if GlyphType = gtImageGlyph then
          begin
            Image := nil;
            Rects := nil;
            if Available[TPP_GLYPH_IMAGE_FILE] then
            begin
              Image := FImage;
              Rects := @FImageRects;
            end
            else
            if Available[TPP_IMAGE_SELECT] then
            begin
              if Rect = nil then
                SelectImage(DC, Classes.Rect(0, 0, 0, 0), ImageSelect, Image, Rects)
              else
              SelectImage(DC, Rect^, ImageSelect, Image, Rects);
            end;
            if (Image <> nil) and (Rects <> nil) then
            begin
              Index := GetStateRectIndex(StateID);
              if Index < Length(Rects^) then
                begin
                  Size.cX := Size.cX + Rects^[Index].Right - Rects^[Index].Left;
                  Size.cY := Size.cY + Rects^[Index].Bottom - Rects^[Index].Top;
                end;
              end;
          end;
        end;
      end;
    TS_TRUE:
      begin
        if Available[TPP_BG_TYPE] then
        begin
          if BgType = bgImageFile then
          begin
            Image := nil;
            Rects := nil;
            if Available[TPP_IMAGE_FILE] then
            begin
              Image := FImage;
              Rects := @FImageRects;
            end
            else
            if Available[TPP_IMAGE_SELECT] then
            begin
              if Rect = nil then
                SelectImage(DC, Classes.Rect(0, 0, 0, 0), ImageSelect, Image, Rects)
              else
              SelectImage(DC, Rect^, ImageSelect, Image, Rects);
            end;
            if (Image <> nil) and (Rects <> nil) then
            begin
              Index := GetStateRectIndex(StateID);
              if Index < Length(Rects^) then
              begin
                Size.cX := Rects^[Index].Right - Rects^[Index].Left;
                Size.cY := Rects^[Index].Bottom - Rects^[Index].Top;
              end;
              end;
          end;
        end
        else
        if Available[TPP_GLYPH_TYPE] then
        begin
          if GlyphType = gtImageGlyph then
          begin
            Image := nil;
            Rects := nil;
            if Available[TPP_GLYPH_IMAGE_FILE] then
            begin
              Image := FImage;
              Rects := @FImageRects;
            end
            else
            if Available[TPP_IMAGE_SELECT] then
            begin
              if Rect = nil then
                SelectImage(DC, Classes.Rect(0, 0, 0, 0), ImageSelect, Image, Rects)
              else
              SelectImage(DC, Rect^, ImageSelect, Image, Rects);
            end;
            if (Image <> nil) and (Rects <> nil) then
            begin
              Index := GetStateRectIndex(StateID);
              if Index < Length(Rects^) then
                begin
                  Size.cX := Rects^[Index].Right - Rects^[Index].Left;
                  Size.cY := Rects^[Index].Bottom - Rects^[Index].Top;
                end;
              end;
          end;
        end;
      end;
    TS_DRAW:
      begin
        if Rect <> nil then
        begin
          Size.cX := Rect.Right - Rect.Left;
          Size.cY := Rect.Bottom - Rect.Top;
        end;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemePosition(StateID, PropID: integer;
  out Point: TPoint);
var
  I: integer;
begin
  for I := 0 to XPPointPropCount - 1 do
    if (XPPointPropIDs[I] = PropID) then
    begin
      if Defined[XPPointPropTags[I]] then
      begin
        Point := FPointProps[I];
        exit;
      end
      else
        LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
    end;
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemePropertyOrigin(StateID,
  PropID: integer; var Origin: integer);
begin
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeRect(StateID, PropID: integer;
  out Rect: TRect);
begin
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeString(StateID, PropID: integer;
  Buffer: PWideChar; MaxBufferChars: integer);
var
  WS: WideString;
  I: integer;
begin
  if (Buffer = nil) or (MaxBufferChars = 0) then
    LMDDebug(SLMDWinXPThemeInvalidParameter);
  for I := 0 to XPStrPropCount - 1 do
    if XPStrPropIDs[I] = PropID then
      if Defined[XPStrPropTags[I]] then
      begin
        WS := FStrProps[I];
        LMDWideStrLCopy(Buffer, PWideChar(WS), MaxBufferChars);
        exit;
      end;
  LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [PropID]));
end;

{------------------------------------------------------------------------------}

procedure TWindowsXPThemePart.GetThemeTextExtent(DC: HDC; StateID: integer;
  Text: PLMDChar; CharCount: integer; TextFlags: cardinal;
  BoundingRect: PRect; out ExtentRect: TRect);

begin

  if BoundingRect = nil then
    ExtentRect := Rect(0,0,0,0)
  else
    ExtentRect := BoundingRect^;

  TextFlags := TextFlags or DT_CALCRECT;
  {$IFDEF LMD_UNICODE}
  DrawTextW(DC, Text, CharCount, ExtentRect, TextFlags);
  {$ELSE}
  DrawText(DC, Text, CharCount, ExtentRect, TextFlags);  
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.GetThemeTextMetrics(DC: HDC;
  StateID: integer; out Metrics: TTextMetricW);
begin
  LMDDebug(SLMDWinXPThemeTextMetricFailed);
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetTrueSizeScalingType: TXPImageSelect;
begin
  if Defined[TPP_TRUESIZE_SCALING_TYPE] then
    Result := FTrueSizeScalingType
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).TrueSizeScalingType
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_TRUESIZESCALINGTYPE]));
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetVAlign: TXPVAlign;
begin
  if Defined[TPP_VALIGN] then
    Result := FVAlign
  else
  if Parent <> nil then
    Result := TWindowsXPThemePart(Parent).VAlign
  else
    LMDDebug(Format(SLMDWinXPThemeNoSchemeProp, [TMT_VALIGN]));
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.HitTestThemeBackground(DC: HDC;
  StateID: integer; Options: cardinal; const Rect: TRect; Region: HRgn;
  Test: TPoint; out HitTestCode: word);
begin
  if PtInRect(Rect, Test) then
    HitTestCode := HTCLIENT
  else
    HitTestCode := HTNOWHERE;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.ImageByIndex(index: integer): TBitmap;
begin
  result := nil;
  case index of
    1: result := FImage1;
    2: result := FImage2;
    3: result := FImage3;
    4: result := FImage4;
    5: result := FImage5;
  end;
end;

function TWindowsXPThemePart.IsThemeBackgroundPartiallyTransparent(StateID: integer): boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.IsThemePartStateDefined(StateID: integer): boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.ParseScheme(const Scheme: TLMDIniCtrl; Section: string);
var
  I: integer;
  S: string;
begin
  if Scheme.SectionExists(Section) then
  begin
    for I := Low(FBoolProps) to High(FBoolProps) do
    begin
      if Scheme.ValueExists(Section, XPBoolPropNames[I]) then
      begin
        S := Scheme.ReadString(Section, XPBoolPropNames[I], '');
        FBoolProps[I] := StrToBoolean(S, False);
        Defined[XPBoolPropTags[I]] := True;
      end;
    end;
    for I := Low(FColorProps) to High(FColorProps) do
    begin
      if Scheme.ValueExists(Section, XPColorPropNames[I]) then
      begin
        S := Scheme.ReadString(Section, XPColorPropNames[I], '');
        FColorProps[I] := StrToColor(S, clBlack);
        Defined[XPColorPropTags[I]] := True;
      end;
    end;
    for I := Low(FIntProps) to High(FIntProps) do
    begin
      if Scheme.ValueExists(Section, XPIntPropNames[I]) then
      begin
        FIntProps[I] := Scheme.ReadInteger(Section, XPIntPropNames[I], 0);
        Defined[XPIntPropTags[I]] := True;
      end;
    end;
    for I := Low(FMarginsProps) to High(FMarginsProps) do
    begin
      if Scheme.ValueExists(Section, XPMarginsPropNames[I]) then
      begin
        S := Scheme.ReadString(Section, XPMarginsPropNames[I], '');
        FMarginsProps[I] := StrToMargins(S, XPMargins(0, 0, 0, 0));
        Defined[XPMarginsPropTags[I]] := True;
      end;
    end;
    for I := Low(FPointProps) to High(FPointProps) do
    begin
      if Scheme.ValueExists(Section, XPPointPropNames[I]) then
      begin
        FPointProps[I] := Scheme.ReadPoint(Section, XPPointPropNames[I], Point(0, 0));
        Defined[XPPointPropTags[I]] := True;
      end;
    end;
    for I := Low(FSizeProps) to High(FSizeProps) do
    begin
      if Scheme.ValueExists(Section, XPSizePropNames[I]) then
      begin
        S := Scheme.ReadString(Section, XPSizePropNames[I], '');
        FSizeProps[I] := StrToSize(S, XPSize(0, 0));
        Defined[XPSizePropTags[I]] := True;
      end;
    end;
    for I := Low(FStrProps) to High(FStrProps) do
    begin
      if Scheme.ValueExists(Section, XPStrPropNames[I]) then
      begin
        FStrProps[I] := Scheme.ReadString(Section, XPStrPropNames[I], '');
        Defined[XPStrPropTags[I]] := True;
      end;
    end;
    if Scheme.ValueExists(Section, 'BgType') then
    begin
      S := Scheme.ReadString(Section, 'BgType', '');
      FBgType := StrToBgType(S, bgNone);
      Defined[TPP_BG_TYPE] := True;
    end;
    if Scheme.ValueExists(Section, 'BorderType') then
    begin
      S := Scheme.ReadString(Section, 'BorderType', '');
      FBorderType := StrToBorderType(S, btNone);
      Defined[TPP_BORDER_TYPE] := True;
    end;
    if Scheme.ValueExists(Section, 'ContentAlignment') then
    begin
      S := Scheme.ReadString(Section, 'ContentAlignment', '');
      FContentAlignment := StrToContentAlignment(S, caLeft);
      Defined[TPP_CONTENT_ALIGNMENT] := True;
    end;
    if Scheme.ValueExists(Section, 'FillType') then
    begin
      S := Scheme.ReadString(Section, 'FillType', '');
      FFillType := StrToFillType(S, ftNone);
      Defined[TPP_FILL_TYPE] := True;
    end;
    if Scheme.ValueExists(Section, 'GlyphType') then
    begin
      S := Scheme.ReadString(Section, 'GlyphType', '');
      FGlyphType := StrToGlyphType(S, gtNone);
      Defined[TPP_GLYPH_TYPE] := True;
    end;
    if Scheme.ValueExists(Section, 'HAlign') then
    begin
      S := Scheme.ReadString(Section, 'HAlign', '');
      FHAlign := StrToHAlign(S, haLeft);
      Defined[TPP_HALIGN] := True;
    end;
    if Scheme.ValueExists(Section, 'IconEffect') then
    begin
      S := Scheme.ReadString(Section, 'IconEffect', '');
      FIconEffect := StrToIconEffect(S, ieNone);
      Defined[TPP_ICON_EFFECT] := True;
    end;
    if Scheme.ValueExists(Section, 'ImageLayout') then
    begin
      S := Scheme.ReadString(Section, 'ImageLayout', '');
      FImageLayout := StrToImageLayout(S, ilHorizontal);
      Defined[TPP_IMAGE_LAYOUT] := True;
    end;
    if Scheme.ValueExists(Section, 'ImageSelectType') then
    begin
      S := Scheme.ReadString(Section, 'ImageSelectType', '');
      FImageSelect := StrToImageSelect(S, isNone);
      Defined[TPP_IMAGE_SELECT] := True;
    end;
    if Scheme.ValueExists(Section, 'OffsetType') then
    begin
      S := Scheme.ReadString(Section, 'OffsetType', '');
      FOffsetType := StrToOffsetType(S, otTopLeft);
      Defined[TPP_OFFSET_TYPE] := True;
    end;
    if Scheme.ValueExists(Section, 'SizingType') then
    begin
      S := Scheme.ReadString(Section, 'SizingType', '');
      FSizingType := StrToSizingType(S, stStretch);
      Defined[TPP_SIZING_TYPE] := True;
    end;
    if Scheme.ValueExists(Section, 'TextShadowType') then
    begin
      S := Scheme.ReadString(Section, 'TextShadowType', '');
      FTextShadowType := StrToShadowType(S, stNone);
      Defined[TPP_TEXT_SHADOW_TYPE] := True;
    end;
    if Scheme.ValueExists(Section, 'TrueSizeScalingType') then
    begin
      S := Scheme.ReadString(Section, 'TrueSizeScalingType', '');
      FTrueSizeScalingType := StrToImageSelect(S, isNone);
      Defined[TPP_TRUESIZE_SCALING_TYPE] := True;
    end;
    if Scheme.ValueExists(Section, 'VAlign') then
    begin
      S := Scheme.ReadString(Section, 'VAlign', '');
      FVAlign := StrToVAlign(S, vaTop);
      Defined[TPP_VALIGN] := True;
    end;
  end;
  SetupInternals;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.RectsArrayByIndex(
  index: integer): PXPRectArray;
begin
  result := nil;
  case index of
    1: result := @FImage1Rects;
    2: result := @FImage2Rects;
    3: result := @FImage3Rects;
    4: result := @FImage4Rects;
    5: result := @FImage5Rects;
  end;
  end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePart.GetSection: string;
begin
  result := FSection;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.SelectImage(DC: HDC; R: TRect;
  SelectType: TXPImageSelect; var Image: TBitmap; var Rects: PXPRectArray);
var
  XDpi, YDpi, Dpi: integer;
  c, X, Y: integer;
  Size: TXPSize;
  LImageSelect: TXPImageSelect;
  i: cardinal;
begin
  LImageSelect := ImageSelect;
  case LImageSelect of
    isDPI : begin
              XDpi := GetDeviceCaps(DC, LOGPIXELSX);
              YDpi := GetDeviceCaps(DC, LOGPIXELSY);
              if XDpi < YDpi then
                Dpi := XDpi
              else
                Dpi := YDpi;
              c := 5;
              for i:= TPP_MIN_DPI5 downto TPP_MIN_DPI1 do
                begin
                  if Available[i] and (ImageByIndex(c) <> nil) then
                    begin
                      if Dpi >= IntProp[i] then
                        begin
                          Image := ImageByIndex(c);
                          Rects := RectsArrayByIndex(c);
                          break;
                        end;
                    end;
                  dec(c);
                  if (c < 1) then
                    break;
                end;
              if (c < 1) then
                begin
                  c := 5;
                  repeat
                    Image := ImageByIndex(c);
                    Rects := RectsArrayByIndex(c);
                    dec(c);
                  until (Image <> nil) or (c < 1);
                end;
            end;
    isSize: begin
              X := R.Right - R.Left;
              Y := R.Bottom - R.Top;
              c := 5;
              for i:= TPP_MIN_SIZE5 downto TPP_MIN_SIZE1 do
                begin
                  if Available[i] and (ImageByIndex(c) <> nil) then
                    begin
                      Size := SizeProp[i];
                      if (X >= Size.cX) and (Y >= Size.cY) then
                        begin
                          Image := ImageByIndex(c);
                          Rects := RectsArrayByIndex(c);
                          break;
                        end;
                    end;
                  dec(c);
                  if (c < 1) then
                    break;
                end;
              if (c < 1) then
                begin
                  c := 3;
                  repeat
                    Image := ImageByIndex(c);
                    Rects := RectsArrayByIndex(c);
                    dec(c);
                  until (Image <> nil) or (c < 1);
                end;

            end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.SetDefined(Index: integer;
  const Value: boolean);
begin
  if (Index >= 0) and (Index < FProps.Size) then
    FProps.Bits[Index] := Value;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePart.SetupInternals;
var
  Manager: TWindowsXPThemeManager;
  FName: string;
begin
  Manager := TWindowsXPThemeManager(Theme.Manager);
  if Manager <> nil then
  begin
    if Available[TPP_GLYPH_IMAGE_FILE] then
    begin
      FGlyphImage := TBitmap.Create;
      try
        FName := StrProp[TPP_GLYPH_IMAGE_FILE];
        if FName <> '' then
          begin
            FGlyphImage.LoadFromResourceName(Manager.FileHandle,
              NormalizeFileName(FName));
            FixAlphaImage(FGlyphImage);
          end;
      except
        FreeAndNil(FGlyphImage);
      end;
    end;
    if Available[TPP_IMAGE_FILE] then
    begin
      FImage := TBitmap.Create;
      try
        FName := StrProp[TPP_IMAGE_FILE];
        if FName <> '' then
          begin
            FImage.LoadFromResourceName(Manager.FileHandle,
              NormalizeFileName(FName));
            FixAlphaImage(FImage);
          end;
      except
        FreeAndNil(FImage);
      end;
    end;
    if Available[TPP_IMAGE_FILE1] then
    begin
      FImage1 := TBitmap.Create;
      try
        FName := StrProp[TPP_IMAGE_FILE1];
        if FName <> '' then
          begin
            FImage1.LoadFromResourceName(Manager.FileHandle,
              NormalizeFileName(FName));
            FixAlphaImage(FImage1);
          end;
      except
        FreeAndNil(FImage1);
      end;
    end;
    if Available[TPP_IMAGE_FILE2] then
    begin
      FImage2 := TBitmap.Create;
      try
        FName := StrProp[TPP_IMAGE_FILE2];
        if FName <> '' then
          begin
            FImage2.LoadFromResourceName(Manager.FileHandle,
              NormalizeFileName(FName));
            FixAlphaImage(FImage2);
          end;
      except
        FreeAndNil(FImage2);
      end;
    end;
    if Available[TPP_IMAGE_FILE3] then
    begin
      FImage3 := TBitmap.Create;
      try
        FName := StrProp[TPP_IMAGE_FILE3];
        if FName <> '' then
          begin
            FImage3.LoadFromResourceName(Manager.FileHandle,
              NormalizeFileName(FName));
            FixAlphaImage(FImage3);
          end;
      except
        FreeAndNil(FImage3);
      end;
    end;
    if Available[TPP_IMAGE_FILE4] then
    begin
      FImage4 := TBitmap.Create;
      try
        FName := StrProp[TPP_IMAGE_FILE4];
        if FName <> '' then
          begin
            FImage4.LoadFromResourceName(Manager.FileHandle,
              NormalizeFileName(FName));
            FixAlphaImage(FImage4);
          end;
      except
        FreeAndNil(FImage4);
      end;
    end;
    if Available[TPP_IMAGE_FILE5] then
    begin
      FImage5 := TBitmap.Create;
      try
        FName := StrProp[TPP_IMAGE_FILE5];
        if FName <> '' then
          begin
            FImage5.LoadFromResourceName(Manager.FileHandle,
              NormalizeFileName(FName));
            FixAlphaImage(FImage5);
          end;
      except
        FreeAndNil(FImage5);
      end;
    end;
    DivideImages;
  end;
end;

{---------------------- TWindowsXPThemeGlobals --------------------------------}
constructor TWindowsXPThemeGlobals.Create(Manager: TThemeManager);
var
  Part: TWindowsXPThemePart;
begin
  inherited;
  Part := TWindowsXPThemeGlobalsPart.Create(Self, nil, 'Globals');
  AddPart(0, Part);
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeGlobals.FindPart(PartID: integer): TThemePart;
begin
  if (PartID = 0) or (PartID = GP_BORDER) or (PartID = GP_LINEHORZ) or
     (PartID = GP_LINEVERT) then
  begin
    FPartID := PartID;
    Result := inherited FindPart(0)
  end
  else
    Result := nil;
end;

{----------------------- TWindowsXPThemeGlobalsPart ---------------------------}
procedure TWindowsXPThemeGlobalsPart.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
var
  Brush: HBrush;
begin
  Brush := GetThemeSysColorBrush(0, COLOR_BTNFACE);
  if Brush <> 0 then
    FillRect(DC, Rect, Brush);
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeGlobalsPart.GetThemeBackgroundContentRect(DC: HDC;
  StateID: integer; const BoundingRect: TRect; out ContentRect: TRect);
var
  Edge, Flags: integer;
begin
  if TWindowsXPThemeGlobals(Theme).PartID = 0 then
    ContentRect := BoundingRect
  else
  begin
    Edge := 0;
    Flags := 0;
    if TWindowsXPThemeGlobals(Theme).PartID = GP_LINEHORZ then
      Flags := BF_TOP
    else
    if TWindowsXPThemeGlobals(Theme).PartID = GP_LINEVERT then
      Flags := BF_LEFT
    else
    if TWindowsXPThemeGlobals(Theme).PartID = GP_BORDER then
      Flags := BF_RECT;
    Flags := Flags or BF_ADJUST;
    if StateID = BSS_FLAT then
    begin
      Edge := BDR_RAISEDOUTER;
      Flags := Flags or BF_FLAT;
    end
    else
    if StateID = BSS_RAISED then
      Edge := BDR_RAISED
    else
    if StateID = BSS_SUNKEN then
      Edge := BDR_SUNKEN;
    ContentRect := BoundingRect;
    DrawEdge(DC, ContentRect, Edge, Flags);
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeGlobalsPart.GetThemeBackgroundExtent(DC: HDC;
  StateID: integer; const ContentRect: TRect; out ExtentRect: TRect);
var
  Edge, Flags: integer;
  R: TRect;
begin
  if TWindowsXPThemeGlobals(Theme).PartID = 0 then
    ExtentRect := ContentRect
  else
  begin
    Edge := 0;
    Flags := 0;
    if TWindowsXPThemeGlobals(Theme).PartID = GP_LINEHORZ then
      Flags := BF_TOP
    else
    if TWindowsXPThemeGlobals(Theme).PartID = GP_LINEVERT then
      Flags := BF_LEFT
    else
    if TWindowsXPThemeGlobals(Theme).PartID = GP_BORDER then
      Flags := BF_RECT;
    Flags := Flags or BF_ADJUST;
    if StateID = BSS_FLAT then
    begin
      Edge := BDR_RAISEDOUTER;
      Flags := Flags or BF_FLAT;
    end
    else
    if StateID = BSS_RAISED then
      Edge := BDR_RAISED
    else
    if StateID = BSS_SUNKEN then
      Edge := BDR_SUNKEN;
    R := ContentRect;
    DrawEdge(DC, R, Edge, Flags);
    ExtentRect := ContentRect;
    if R.Left > ContentRect.Left then
      ExtentRect.Left := ExtentRect.Left - Abs(ContentRect.Left - R.Left);
    if R.Top > ContentRect.Top then
      ExtentRect.Top := ExtentRect.Top - Abs(ContentRect.Top - R.Top);
    if R.Right < ContentRect.Right then
      ExtentRect.Right := ExtentRect.Right + Abs(ContentRect.Right - R.Right);
    if R.Bottom < ContentRect.Bottom then
      ExtentRect.Bottom := ExtentRect.Bottom + Abs(ContentRect.Bottom - R.Bottom);
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeGlobalsPart.HitTestThemeBackground(DC: HDC;
  StateID: integer; Options: cardinal; const Rect: TRect; Region: HRgn;
  Test: TPoint; out HitTestCode: word);
begin
  HitTestCode := HTCLIENT;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeGlobalsPart.IsThemeBackgroundPartiallyTransparent(
  StateID: integer): boolean;
begin
  if TWindowsXPThemeGlobals(Theme).PartID = 0 then
    Result := False
  else
    Result := True;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeGlobalsPart.IsThemePartStateDefined(
  StateID: integer): boolean;
begin
  case TWindowsXPThemeGlobals(Theme).PartID of
    0:
      Result := (StateID = 1);
    GP_LINEHORZ:
      Result := ((StateID >= LVS_FLAT) and (StateID <= LVS_SUNKEN));
    GP_LINEVERT:
      Result := ((StateID >= LHS_FLAT) and (StateID <= LHS_SUNKEN));
    GP_BORDER:
      Result := ((StateID >= BSS_FLAT) and (StateID <= BSS_SUNKEN));
  else
    Result := False;
  end;
end;
{$warnings on}

end.
