unit LMDThemesGradientThemeBase;
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

LMDThemesGradientThemeBase unit (VB)
----------------------------------

Contains base gradient theme renderer class,
which can implement Office2007-like gradient themes

Changes
-------
Release 10.0 (January 2009)
- Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Windows,
  UxTheme, Themes, Graphics, TypInfo,
  LMDTypes, LMDClass,  LMDXML, LMDThemes,
  LMDGraph, LMDThemesCommonTypes, LMDFillers, LMDFigures, LMDGradientFrames;

type
  TLMDGradientTheme = (gtOffice2007, gtCustom, gtUnknown);

const
  cGradientThemeNames : array[TLMDGradientTheme] of string = ('Office2007', 'Custom', 'Unknown');
  cStandardFillRenderMode = 4;

  cStandardFrameRenderMode = 84;
  cRM_OuterBorderAntiALiasing = 4;
  cRM_InnerSpaceAntiALiasing = 16;
  cRM_InnerBorderAntiALiasing = 64;
  cRM_OuterBorderSoftEdge = 8;
  cRM_InnerSpaceSoftEdge = 32;
  cRM_InnerBorderSoftEdge = 128;

const
  cAllColors = 256;

type
  TLMDGradientFillPart = (gfpMain, gfpDeco1, gfpDeco2, gfpDeco3, gfpDeco4);
  TLMDGradientFillParts = set of TLMDGradientFillPart;

const
  cGradientFillAllParts = [gfpMain, gfpDeco1, gfpDeco2, gfpDeco3, gfpDeco4];

  //gflpRenderMode
  //bits 0..1: 0 - standard, 1 - sketch, 2 and 3 - reserved
  //bit  2 - antialiasing for gfpMain
  //bits 3..6 - antialiasing gfpDeco1..gfpDeco4
  //----------------bits 7654 3210
  //standard value is 4: 0000 0010
type
  TLMDGradientThemeFillParam = (gflpRenderMode);

  //gfrpRenderMode
  //bits 0..1: 0 - standard, 1 - sketch, 2 and 3 - reserved
  //bit 2: outerborder antialiasing flag - 4
  //bit 3: outerborder soft edge flag   - 8
  //bit 4: innerspace antialiasing flag  - 16
  //bit 5: innerspace soft edge flag    - 32
  //bit 6: innerborder antialiasing flag - 64
  //bit 7: innerborder soft edge flag   - 128
  //---------------- bits  7654 3210
  //standard value is 84:  0101 0100
  TLMDGradientThemeFrameParam =
    ( gfrpRenderMode, gfrpOuterBorderSides, gfrpInnerBorderSides,
      gfrpOuterBorderEdgeWidth, gfrpInnerBorderEdgeWidth,
      gfrpSpaceEdgeWidth,
      gfrpOuterBorderWidth, gfrpInnerBorderWidth,
      gfrpOuterBorderGap, gfrpInnerBorderGap,
      gfrpTopSpaceWidth, gfrpRightSpaceWidth,
      gfrpBottomSpaceWidth, gfrpLeftSpaceWidth,
      gfrpCutValueUsage,
      gfrpOuterBorderInnerCutType, gfrpOuterBorderOuterCutType,
      gfrpOuterBorderInnerCutX, gfrpOuterBorderInnerCutY,
      gfrpOuterBorderOuterCutX, gfrpOuterBorderOuterCutY,
      gfrpOuterBorderInnerCutXValueType, gfrpOuterBorderInnerCutYValueType,
      gfrpOuterBorderOuterCutXValueType, gfrpOuterBorderOuterCutYValueType,
      gfrpInnerSpaceInnerCutType, gfrpInnerSpaceOuterCutType,
      gfrpInnerSpaceInnerCutX, gfrpInnerSpaceInnerCutY,
      gfrpInnerSpaceOuterCutX, gfrpInnerSpaceOuterCutY,
      gfrpInnerSpaceInnerCutXValueType, gfrpInnerSpaceInnerCutYValueType,
      gfrpInnerSpaceOuterCutXValueType, gfrpInnerSpaceOuterCutYValueType,
      gfrpInnerBorderOuterCutType, gfrpInnerBorderInnerCutType,
      gfrpInnerBorderOuterCutX, gfrpInnerBorderOuterCutY,
      gfrpInnerBorderInnerCutX, gfrpInnerBorderInnerCutY,
      gfrpInnerBorderOuterCutXValueType, gfrpInnerBorderOuterCutYValueType,
      gfrpInnerBorderInnerCutXValueType, gfrpInnerBorderInnerCutYValueType);

type
  TLMDGradientThemeFillParams =  array[TLMDGradientThemeFillParam] of byte;
  TLMDGradientThemeFrameParams = array[TLMDGradientThemeFrameParam] of byte;


type
  TLMDGradientThemeFillDescriptor = record
    Params: TLMDGradientThemeFillParams;
    Fillers: array[TLMDGradientFillPart] of TLMDFiller;
  end;

type
  TLMDGradientThemeFrameDescriptor = record
    Params: TLMDGradientThemeFrameParams;
    Fillers: array[TLMDGradientSimpleFramePartKind] of TLMDFiller;
  end;

type
  TLMDGradientThemeTextDescriptor = record
    Params: LOGFONTW;
    Color: TColor;
  end;

type
  TLMDGradientThemeFillData = array[0..255] of TLMDGradientThemeFillDescriptor;
  PLMDGradientThemeFillData = ^TLMDGradientThemeFillData;
  TLMDGradientThemeFrameData = array[0..255] of TLMDGradientThemeFrameDescriptor;
  PLMDGradientThemeFrameData = ^TLMDGradientThemeFrameData;

  TLMDGradientThemeTextData = array[0..255] of TLMDGradientThemeTextDescriptor;
  PLMDGradientThemeTextData = ^TLMDGradientThemeTextData;

type
  TLMDBaseGradientThemeRenderer = class(TLMDThemeRenderer)
  private
    FEnabled: boolean;
    FTheme: TLMDGradientTheme;
    FThemeName: string;
    FColorScheme: TLMDColorScheme;
    FColorSchemeName: string;
    FIsUpdating: boolean;

    FGradientArrowFiller: array[TLMDDirection, TLMDThemedButtonState] of TLMDFiller;

    FSimpleArrowColors: array[boolean] of TColor;
    FSimpleArrowShadowColors: array[boolean] of TColor;

    FCheckMarkFill: array[boolean] of TLMDGradientThemeFillDescriptor;
    FRadioBtnCheckMarkFill: array[boolean] of TLMDGradientThemeFillDescriptor;
    FMixedMarkFill: array[boolean] of TLMDGradientThemeFillDescriptor;

    FButtonFill:  array[TThemedButton] of TLMDGradientThemeFillDescriptor;
    FButtonFrame: array[TThemedButton] of TLMDGradientThemeFrameDescriptor;

    //FMenuItemFill:  array[TThemedMenu] of TLMDGradientThemeFillDescriptor;
    //FMenuItemFrame: array[TThemedMenu] of TLMDGradientThemeFrameDescriptor;

    FToolbarFill:  array[TThemedToolBar] of TLMDGradientThemeFillDescriptor;
    FToolbarFrame: array[TThemedToolBar] of TLMDGradientThemeFrameDescriptor;

    FComboboxFill:  array[TThemedComboBox] of TLMDGradientThemeFillDescriptor;
    FComboboxFrame: array[TThemedComboBox] of TLMDGradientThemeFrameDescriptor;

    FEditFill:  array[TThemedEdit] of TLMDGradientThemeFillDescriptor;
    FEditFrame: array[TThemedEdit] of TLMDGradientThemeFrameDescriptor;

    FSpinBtnFill:  array[TThemedSpin] of TLMDGradientThemeFillDescriptor;
    FSpinBtnFrame: array[TThemedSpin] of TLMDGradientThemeFrameDescriptor;

    FScrollBarFill:  array[TThemedScrollBar] of TLMDGradientThemeFillDescriptor;
    FScrollBarFrame: array[TThemedScrollBar] of TLMDGradientThemeFrameDescriptor;

    FTabFill:  array[TThemedTab] of TLMDGradientThemeFillDescriptor;
    FTabFrame: array[TThemedTab] of TLMDGradientThemeFrameDescriptor;
    FTabText:  array[TThemedTab] of TLMDGradientThemeTextDescriptor;

    FProgressFill:  array[TThemedProgress] of TLMDGradientThemeFillDescriptor;
    FProgressFrame: array[TThemedProgress] of TLMDGradientThemeFrameDescriptor;

    FHeaderFill:  array[TThemedHeader] of TLMDGradientThemeFillDescriptor;
    FHeaderFrame: array[TThemedHeader] of TLMDGradientThemeFrameDescriptor;

    FTreeViewFrame: array[TThemedTreeView] of TLMDGradientThemeFrameDescriptor;

    FTrackBarFill:  array[TThemedTrackBar] of TLMDGradientThemeFillDescriptor;
    FTrackBarFrame: array[TThemedTrackBar] of TLMDGradientThemeFrameDescriptor;

    FStatusBarFill:  array[TThemedStatus] of TLMDGradientThemeFillDescriptor;
    FStatusBarFrame: array[TThemedStatus] of TLMDGradientThemeFrameDescriptor;

    //FExplorerBarFill: array[TThemedExplorerBar] of TLMDGradientThemeFillDescriptor;

    FEnabledTextColor,
    FDisabledTextColor: TColor;
    //--- end of color settings fields section --->

    //This array allows to access colors for all elements via one cycle
    FMetaData: TLMDThemeElementMetaData;

    //This list contains all registered metadata (one entry - TThemedElement is registered by default)
    FMetaDataPool: TStringList;

    //Fillers
    FFillerToolBox: TStringList;

    //Frames
    FRFrame: TLMDGradientRectFrame;
    FCFrame: TLMDGradientCircleFrame;

    //Figures
    FRoundRectangle: TLMDRoundRectangle;
    FCCRectangle: TLMDCustomCutRectangle;
    FCircle: TLMDCircle;
    FRectangle: TLMDRectangle;
    FLine1, FLine2: TLMDLine;

    //Bitmap Cache
    FBmpCache: TStringList;

    FPixelFormat: TPixelFormat;

    //XML doc
    FXmlDoc: ILMDXmlDocument;

    FModified: boolean;
    FUseCache: boolean;

    FOnDrawElement: TLMDThemesOnDrawElement;
    FOnDrawCheckMark: TLMDThemesOnDrawCheckMarkEvent;
    FOnDrawScrollThumbGripper: TLMDThemesOnDrawScrollThumbGripperEvent;
    FOnDrawArrow: TLMDThemesOnDrawArrowEvent;
    FOnDrawGradientArrow: TLMDThemesOnDrawGradientArrowEvent;
    FOnDrawPlus: TLMDThemesOnDrawSimpleSignEvent;
    FOnDrawMinus: TLMDThemesOnDrawSimpleSignEvent;
    FOnDrawCross: TLMDThemesOnDrawSimpleSignEvent;

    FSuppressUpdate: boolean;

    procedure SetColorSchemeName(const Value: string);
    procedure FinalizeFrameFillers(aFrame: TLMDBaseGradientFrame; aFrameDescriptor: TLMDGradientThemeFrameDescriptor);

    //<--- property setters and getters section -----
    function GetDisabledTextColor: TColor;
    function GetEnabledTextColor: TColor;
    procedure SetDisabledTextColor(const Value: TColor);
    procedure SetEnabledTextColor(const Value: TColor);
    function GetMetaData(
      Element: TThemedElement): TLMDThemeDetailMetaData;

    function GetButtonFillFiller(index: TThemedButton;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetButtonFillParam(index: TThemedButton;
      param: TLMDGradientThemeFillParam): byte;
    function GetButtonFrameFiller(index: TThemedButton;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetButtonFrameParam(index: TThemedButton;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetButtonFillFiller(index: TThemedButton;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetButtonFillParam(index: TThemedButton;
      param: TLMDGradientThemeFillParam;
      const Value: byte);
    procedure SetButtonFrameFiller(index: TThemedButton;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetButtonFrameParam(index: TThemedButton;
      param: TLMDGradientThemeFrameParam;
      const Value: byte);
    function GetButtonFill(
      index: TThemedButton): TLMDGradientThemeFillDescriptor;
    function GetButtonFrame(
      index: TThemedButton): TLMDGradientThemeFrameDescriptor;
    procedure SetButtonFill(index: TThemedButton;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetButtonFrame(index: TThemedButton;
      const Value: TLMDGradientThemeFrameDescriptor);
    function GetComboBoxFill(
      index: TThemedComboBox): TLMDGradientThemeFillDescriptor;
    function GetComboBoxFillFiller(index: TThemedComboBox;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetComboBoxFillParam(index: TThemedComboBox;
      param: TLMDGradientThemeFillParam): byte;
    function GetComboBoxFrame(
      index: TThemedComboBox): TLMDGradientThemeFrameDescriptor;
    function GetComboBoxFrameFiller(index: TThemedComboBox;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetComboBoxFrameParam(index: TThemedComboBox;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetComboBoxFill(index: TThemedComboBox;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetComboBoxFillFiller(index: TThemedComboBox;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetComboBoxFillParam(index: TThemedComboBox;
      param: TLMDGradientThemeFillParam; const Value: byte);
    procedure SetComboBoxFrame(index: TThemedComboBox;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetComboBoxFrameFiller(index: TThemedComboBox;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetComboBoxFrameParam(index: TThemedComboBox;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    function GetEditFill(
      index: TThemedEdit): TLMDGradientThemeFillDescriptor;
    function GetEditFillFiller(index: TThemedEdit;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetEditFillParam(index: TThemedEdit;
      param: TLMDGradientThemeFillParam): byte;
    function GetEditFrame(
      index: TThemedEdit): TLMDGradientThemeFrameDescriptor;
    function GetEditFrameFiller(index: TThemedEdit;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetEditFrameParam(index: TThemedEdit;
      param: TLMDGradientThemeFrameParam): byte;
    function GetSpinBtnFill(
      index: TThemedSpin): TLMDGradientThemeFillDescriptor;
    function GetSpinBtnFillFiller(index: TThemedSpin;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetSpinBtnFillParam(index: TThemedSpin;
      param: TLMDGradientThemeFillParam): byte;
    function GetSpinBtnFrame(
      index: TThemedSpin): TLMDGradientThemeFrameDescriptor;
    function GetSpinBtnFrameFiller(index: TThemedSpin;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetSpinBtnFrameParam(index: TThemedSpin;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetEditFill(index: TThemedEdit;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetEditFillFiller(index: TThemedEdit;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetEditFillParam(index: TThemedEdit;
      param: TLMDGradientThemeFillParam; const Value: byte);
    procedure SetEditFrame(index: TThemedEdit;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetEditFrameFiller(index: TThemedEdit;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetEditFrameParam(index: TThemedEdit;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    procedure SetSpinBtnFill(index: TThemedSpin;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetSpinBtnFillFiller(index: TThemedSpin;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetSpinBtnFillParam(index: TThemedSpin;
      param: TLMDGradientThemeFillParam; const Value: byte);
    procedure SetSpinBtnFrame(index: TThemedSpin;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetSpinBtnFrameFiller(index: TThemedSpin;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetSpinBtnFrameParam(index: TThemedSpin;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    function GetToolbarFill(
      index: TThemedToolbar): TLMDGradientThemeFillDescriptor;
    function GetToolbarFillFiller(index: TThemedToolbar;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetToolbarFillParam(index: TThemedToolbar;
      param: TLMDGradientThemeFillParam): byte;
    function GetToolbarFrame(
      index: TThemedToolbar): TLMDGradientThemeFrameDescriptor;
    function GetToolbarFrameFiller(index: TThemedToolbar;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetToolbarFrameParam(index: TThemedToolbar;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetToolbarFill(index: TThemedToolbar;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetToolbarFillFiller(index: TThemedToolbar;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetToolbarFillParam(index: TThemedToolbar;
      param: TLMDGradientThemeFillParam; const Value: byte);
    procedure SetToolbarFrame(index: TThemedToolbar;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetToolbarFrameFiller(index: TThemedToolbar;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetToolbarFrameParam(index: TThemedToolbar;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    function GetScrollBarFill(
      index: TThemedScrollBar): TLMDGradientThemeFillDescriptor;
    function GetScrollBarFillFiller(index: TThemedScrollBar;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetScrollBarFillParam(index: TThemedScrollBar;
      param: TLMDGradientThemeFillParam): byte;
    function GetScrollBarFrame(
      index: TThemedScrollBar): TLMDGradientThemeFrameDescriptor;
    function GetScrollBarFrameFiller(index: TThemedScrollBar;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetScrollBarFrameParam(index: TThemedScrollBar;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetScrollBarFill(index: TThemedScrollBar;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetScrollBarFillFiller(index: TThemedScrollBar;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetScrollBarFillParam(index: TThemedScrollBar;
      param: TLMDGradientThemeFillParam; const Value: byte);
    procedure SetScrollBarFrame(index: TThemedScrollBar;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetScrollBarFrameFiller(index: TThemedScrollBar;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetScrollBarFrameParam(index: TThemedScrollBar;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    function GetTabFill(
      index: TThemedTab): TLMDGradientThemeFillDescriptor;
    function GetTabFillFiller(index: TThemedTab;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetTabFillParam(index: TThemedTab;
      param: TLMDGradientThemeFillParam): byte;
    function GetTabFrame(
      index: TThemedTab): TLMDGradientThemeFrameDescriptor;
    function GetTabFrameFiller(index: TThemedTab;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetTabFrameParam(index: TThemedTab;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetTabFill(index: TThemedTab;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetTabFillFiller(index: TThemedTab;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetTabFillParam(index: TThemedTab;
      param: TLMDGradientThemeFillParam; const Value: byte);
    procedure SetTabFrame(index: TThemedTab;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetTabFrameFiller(index: TThemedTab;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetTabFrameParam(index: TThemedTab;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    function GetProgressFill(
      index: TThemedProgress): TLMDGradientThemeFillDescriptor;
    function GetProgressFillFiller(index: TThemedProgress;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetProgressFillParam(index: TThemedProgress;
      param: TLMDGradientThemeFillParam): byte;
    function GetProgressFrame(
      index: TThemedProgress): TLMDGradientThemeFrameDescriptor;
    function GetProgressFrameFiller(index: TThemedProgress;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetProgressFrameParam(index: TThemedProgress;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetProgressFill(index: TThemedProgress;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetProgressFillFiller(index: TThemedProgress;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetProgressFillParam(index: TThemedProgress;
      param: TLMDGradientThemeFillParam; const Value: byte);
    procedure SetProgressFrame(index: TThemedProgress;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetProgressFrameFiller(index: TThemedProgress;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetProgressFrameParam(index: TThemedProgress;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    function GetHeaderFill(
      index: TThemedHeader): TLMDGradientThemeFillDescriptor;
    function GetHeaderFillFiller(index: TThemedHeader;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetHeaderFillParam(index: TThemedHeader;
      param: TLMDGradientThemeFillParam): byte;
    function GetHeaderFrame(
      index: TThemedHeader): TLMDGradientThemeFrameDescriptor;
    function GetHeaderFrameFiller(index: TThemedHeader;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetHeaderFrameParam(index: TThemedHeader;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetHeaderFill(index: TThemedHeader;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetHeaderFillFiller(index: TThemedHeader;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetHeaderFillParam(index: TThemedHeader;
      param: TLMDGradientThemeFillParam; const Value: byte);
    procedure SetHeaderFrame(index: TThemedHeader;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetHeaderFrameFiller(index: TThemedHeader;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetHeaderFrameParam(index: TThemedHeader;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    function GetTrackBarFill(
      index: TThemedTrackBar): TLMDGradientThemeFillDescriptor;
    function GetTrackBarFillFiller(index: TThemedTrackBar;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetTrackBarFillParam(index: TThemedTrackBar;
      param: TLMDGradientThemeFillParam): byte;
    function GetTrackBarFrame(
      index: TThemedTrackBar): TLMDGradientThemeFrameDescriptor;
    function GetTrackBarFrameFiller(index: TThemedTrackBar;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetTrackBarFrameParam(index: TThemedTrackBar;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetTrackBarFill(index: TThemedTrackBar;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetTrackBarFillFiller(index: TThemedTrackBar;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetTrackBarFillParam(index: TThemedTrackBar;
      param: TLMDGradientThemeFillParam; const Value: byte);
    procedure SetTrackBarFrame(index: TThemedTrackBar;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetTrackBarFrameFiller(index: TThemedTrackBar;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetTrackBarFrameParam(index: TThemedTrackBar;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    function GetStatusBarFill(
      index: TThemedStatus): TLMDGradientThemeFillDescriptor;
    function GetStatusBarFillFiller(index: TThemedStatus;
      flp: TLMDGradientFillPart): TLMDFiller;
    function GetStatusBarFillParam(index: TThemedStatus;
      param: TLMDGradientThemeFillParam): byte;
    function GetStatusBarFrame(
      index: TThemedStatus): TLMDGradientThemeFrameDescriptor;
    function GetStatusBarFrameFiller(index: TThemedStatus;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetStatusBarFrameParam(index: TThemedStatus;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetStatusBarFill(index: TThemedStatus;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetStatusBarFillFiller(index: TThemedStatus;
      flp: TLMDGradientFillPart; const Value: TLMDFiller);
    procedure SetStatusBarFillParam(index: TThemedStatus;
      param: TLMDGradientThemeFillParam; const Value: byte);
    procedure SetStatusBarFrame(index: TThemedStatus;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetStatusBarFrameFiller(index: TThemedStatus;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetStatusBarFrameParam(index: TThemedStatus;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    function GetTreeViewFrame(
      index: TThemedTreeview): TLMDGradientThemeFrameDescriptor;
    function GetTreeViewFrameFiller(index: TThemedTreeview;
      frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
    function GetTreeViewFrameParam(index: TThemedTreeview;
      param: TLMDGradientThemeFrameParam): byte;
    procedure SetTreeViewFrame(index: TThemedTreeview;
      const Value: TLMDGradientThemeFrameDescriptor);
    procedure SetTreeViewFrameFiller(index: TThemedTreeview;
      frp: TLMDGradientSimpleFramePartKind; const Value: TLMDFiller);
    procedure SetTreeViewFrameParam(index: TThemedTreeview;
      param: TLMDGradientThemeFrameParam; const Value: byte);
    function GetGradientArrowFiller(index: TLMDDirection;
      btns: TLMDThemedButtonState): TLMDFiller;
    procedure SetGradientArrowFiller(index: TLMDDirection;
      btns: TLMDThemedButtonState; const Value: TLMDFiller);
    function GetCheckMarkFill(
      index: boolean): TLMDGradientThemeFillDescriptor;
    function GetMixedMarkFill(
      index: boolean): TLMDGradientThemeFillDescriptor;
    function GetRadioBtnCheckMarkFill(
      index: boolean): TLMDGradientThemeFillDescriptor;
    function GetSimpleArrowColors(index: boolean): TColor;
    function GetSimpleArrowShadowColors(index: boolean): TColor;
    procedure SetCheckMarkFill(index: boolean;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetMixedMarkFill(index: boolean;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetRadioBtnCheckMarkFill(index: boolean;
      const Value: TLMDGradientThemeFillDescriptor);
    procedure SetSimpleArrowColors(index: boolean; const Value: TColor);
    procedure SetSimpleArrowShadowColors(index: boolean;
      const Value: TColor);
    procedure SetPixelFormat(const Value: TPixelFormat);
    function GetSuppressUpdate: boolean;
    procedure SetSuppressUpdate(const Value: boolean);
    function GetUseCache: boolean;
    procedure SetUseCache(const Value: boolean);
    //--- end of property setters and getters section ----->
  protected
    FController: TLMDThemesControllerBase;

    procedure DrawGradientFramedFigure(DC: HDC; Bmp: TBitmap; aBoundsRect: TRect; var aContentsRect: TRect; ClipRect: TLMDRectPtr; aFrameD: TLMDGradientThemeFrameDescriptor; aFillD: TLMDGradientThemeFillDescriptor; aFrame: TLMDBaseGradientFrame; aFigure: TLMDFigure; aPixelFormat: TPixelFormat = pf24bit); virtual;
    procedure DrawSimpleFrame(DC: HDC; Bmp: TBitmap; aBoundsRect: TRect; var aContentsRect: TRect;  ClipRect: TLMDRectPtr; aFrameD: TLMDGradientThemeFrameDescriptor); virtual;

    procedure DrawArrow(DC: HDC; ARect: TRect; ADir: TLMDDirection; aDrawShadow: boolean; aEnabled: boolean); virtual;
    procedure DrawGradientArrow(DC: HDC; ARect: TRect; ADir: TLMDDirection; aState: TLMDThemedButtonState); virtual;
    procedure DrawCross(DC: HDC; ARect: TRect; aDrawShadow: boolean); virtual;
    procedure DrawMinus(DC: HDC; ARect: TRect; aFrameColor, AFillColor1, aFillColor2, aShadowColor:TColor; aDrawShadow: boolean); virtual;
    procedure DrawPlus(DC: HDC; ARect: TRect; aFrameColor, AFillColor1, aFillColor2, aShadowColor:TColor; aDrawShadow: boolean); virtual;
    procedure DrawCheckMark(DC: HDC; ARect: TRect; acb: TThemedButton); virtual;
    procedure DrawScrollThumbGripper(DC: HDC; aRect: TRect; Detail: TThemedScrollBar); virtual;
    procedure DoUpdateTheme; virtual;

    procedure SetRectFrameParams(aDstFrame: TLMDGradientRectFrame; aParams: TLMDGradientThemeFrameParams);
    procedure SetFillerParams(aDestFiller, aSrcFiller: TLMDFiller; aRect: TRect); virtual;
    function PrepareFillerFrom(const aSrcFiller: TLMDFiller; aCreateNew: boolean = false): TLMDFiller;
    function PrepareFiller(aSrcFiller: TLMDFiller; aRect: TRect): TLMDFiller;
    function Signature(Details: TThemedElementDetails; aRect:TRect): string;

    procedure ReadFillDescriptorFromXML(var
               aFillD: TLMDGradientThemeFillDescriptor; aDetailNode: ILMDXMLElement);
    procedure ReadFrameDescriptorFromXML(var
                aFrameD: TLMDGradientThemeFrameDescriptor; aDetailNode: ILMDXMLElement);
    procedure ReadTextDescriptorFromXML(var
                aTextD: TLMDGradientThemeTextDescriptor; aDetailNode: ILMDXMLElement);
    procedure WriteFillDescriptorToXML(aFillD: TLMDGradientThemeFillDescriptor; aDetail: ILMDXMLElement);
    procedure WriteFrameDescriptorToXML(aFrameD: TLMDGradientThemeFrameDescriptor; aDetail: ILMDXMLElement);
    procedure WriteTextDescriptorToXML(aTextD: TLMDGradientThemeTextDescriptor; aDetail: ILMDXMLElement);
    procedure WriteFillerToXML(aFiller: TLMDFiller; aNode: ILMDXMLElement; AttrName:string = ''; AttrValue: string = '');
    function  ReadFillerFromXML(aNode: ILMDXMLElement): TLMDFiller;

    function GetEnabled: boolean; override;
    procedure SetEnabled(aValue: boolean); override;
    function GetActiveThemeName: TLMDString; override;
    function GetActiveColorSchemeName: TLMDString; override;

  public
    procedure ClearCache;
    procedure CloneDescriptor(var aFldDest, aFldSrc: TLMDGradientThemeFillDescriptor); overload;
    procedure CloneDescriptor(var aFrdDest, aFrdSrc: TLMDGradientThemeFrameDescriptor); overload;
    procedure ClearDescriptorFillers(var aFld: TLMDGradientThemeFillDescriptor); overload;
    procedure ClearDescriptorFillers(var aFrd: TLMDGradientThemeFrameDescriptor); overload;

    constructor Create; override;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate(aDoApply: boolean = true);
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

    //procedure DrawElement(DC: HDC; aDetailTypeInfo: PTypeInfo; aDetail: integer;  const R: TRect; ClipRect: TLMDRectPtr = LMDNullRectPtr);

    procedure DrawThemeParentBackground(Wnd: HWnd; DC: HDC; ARect: TLMDRectPtr); override;

    function DrawThemeEdge(DC: HDC; aElement: TThemedElement; iPartId, iStateId: Integer; const pDestRect: TRect; uEdge, uFlags: UINT; pContentRect: TLMDRectPtr): boolean; overload; override;
    function DrawThemeText(DC: HDC; Detail: TThemedElement; iPartId, iStateId: Integer; Text: TLMDString; CharCount: Integer; dwTextFlags, dwTextFlags2: DWORD; const ARect: TRect): boolean; override;
    //--- end of theme renderer common methods section --->

    procedure RegisterMetaData(aElementTypeInfo: PTypeInfo; aMetaData: Pointer);

    procedure ChangeBrightness(aPercent: integer; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aFillParts: TLMDGradientFillParts = cGradientFillAllParts; aFrameParts: TLMDGradientSimpleFramePartKinds = cGradientSFrameAllParts; aIndex: integer = -1);
    procedure ReplaceColor(aOldColor, aNewColor: TColor; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aFillParts: TLMDGradientFillParts = cGradientFillAllParts; aFrameParts: TLMDGradientSimpleFramePartKinds = cGradientSFrameAllParts; aIndex: integer = -1);
    procedure SetNewColor(aNewColor: TColor; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aFillParts: TLMDGradientFillParts = cGradientFillAllParts; aFrameParts: TLMDGradientSimpleFramePartKinds = cGradientSFrameAllParts; aIndex: integer = 0);

    function SaveColorSchemeToXML(aXmlDoc: ILMDXMLDocument; aColorScheme: TLMDString): boolean; virtual;
    function SaveColorSchemeToStream(aStream: TStream; aColorScheme: TLMDString): boolean; virtual;
    function SaveColorSchemeToFile(aFileName: TLMDString; aColorScheme: TLMDString): boolean;

    function SaveThemeToStream(aStream: TStream): boolean;
    function SaveThemeToFile(aFileName: TLMDString): boolean;

    function LoadColorSchemeFromXML(aXmlDoc: ILMDXMLDocument; aColorScheme: TLMDString; aDoApply: boolean = true): boolean; virtual;
    function LoadThemeFromStream(aStream: TStream; aColorScheme: TLMDString = ''; aDoApply: boolean = true): boolean; virtual;
    function LoadThemeFromFile(aFile: TLMDString; aColorScheme: TLMDString = ''; aDoApply: boolean = true): boolean;

    function ReloadFromInternalXML: boolean;

    property SuppressUpdate: boolean read GetSuppressUpdate write SetSuppressUpdate default false;

    property Theme: TLMDGradientTheme read FTheme;
    property ThemeName: string read FThemeName;
    property ColorScheme: TLMDColorScheme read FColorScheme;
    property ColorSchemeName: string read FColorSchemeName write SetColorSchemeName;

    property EnabledTextColor: TColor read GetEnabledTextColor write SetEnabledTextColor;
    property DisabledTextColor: TColor read GetDisabledTextColor write SetDisabledTextColor;

    property MetaData[Element: TThemedElement]: TLMDThemeDetailMetaData read GetMetaData;

    property ButtonFill[index: TThemedButton]: TLMDGradientThemeFillDescriptor read GetButtonFill write SetButtonFill;
    property ButtonFrame[index: TThemedButton]: TLMDGradientThemeFrameDescriptor read GetButtonFrame write SetButtonFrame;
    property ButtonFillParam[index: TThemedButton; param: TLMDGradientThemeFillParam]: byte read GetButtonFillParam write SetButtonFillParam;
    property ButtonFrameParam[index: TThemedButton; param: TLMDGradientThemeFrameParam]: byte read GetButtonFrameParam write SetButtonFrameParam;
    property ButtonFillFiller[index: TThemedButton; flp: TLMDGradientFillPart]: TLMDFiller read GetButtonFillFiller write SetButtonFillFiller;
    property ButtonFrameFiller[index: TThemedButton; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetButtonFrameFiller write SetButtonFrameFiller;

    property ToolbarFill[index: TThemedToolbar]: TLMDGradientThemeFillDescriptor read GetToolbarFill write SetToolbarFill;
    property ToolbarFrame[index: TThemedToolbar]: TLMDGradientThemeFrameDescriptor read GetToolbarFrame write SetToolbarFrame;
    property ToolbarFillParam[index: TThemedToolbar; param: TLMDGradientThemeFillParam]: byte read GetToolbarFillParam write SetToolbarFillParam;
    property ToolbarFrameParam[index: TThemedToolbar; param: TLMDGradientThemeFrameParam]: byte read GetToolbarFrameParam write SetToolbarFrameParam;
    property ToolbarFillFiller[index: TThemedToolbar; flp: TLMDGradientFillPart]: TLMDFiller read GetToolbarFillFiller write SetToolbarFillFiller;
    property ToolbarFrameFiller[index: TThemedToolbar; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetToolbarFrameFiller write SetToolbarFrameFiller;

    property ComboBoxFill[index: TThemedComboBox]: TLMDGradientThemeFillDescriptor read GetComboBoxFill write SetComboBoxFill;
    property ComboBoxFrame[index: TThemedComboBox]: TLMDGradientThemeFrameDescriptor read GetComboBoxFrame write SetComboBoxFrame;
    property ComboBoxFillParam[index: TThemedComboBox; param: TLMDGradientThemeFillParam]: byte read GetComboBoxFillParam write SetComboBoxFillParam;
    property ComboBoxFrameParam[index: TThemedComboBox; param: TLMDGradientThemeFrameParam]: byte read GetComboBoxFrameParam write SetComboBoxFrameParam;
    property ComboBoxFillFiller[index: TThemedComboBox; flp: TLMDGradientFillPart]: TLMDFiller read GetComboBoxFillFiller write SetComboBoxFillFiller;
    property ComboBoxFrameFiller[index: TThemedComboBox; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetComboBoxFrameFiller write SetComboBoxFrameFiller;

    property EditFill[index: TThemedEdit]: TLMDGradientThemeFillDescriptor read GetEditFill write SetEditFill;
    property EditFrame[index: TThemedEdit]: TLMDGradientThemeFrameDescriptor read GetEditFrame write SetEditFrame;
    property EditFillParam[index: TThemedEdit; param: TLMDGradientThemeFillParam]: byte read GetEditFillParam write SetEditFillParam;
    property EditFrameParam[index: TThemedEdit; param: TLMDGradientThemeFrameParam]: byte read GetEditFrameParam write SetEditFrameParam;
    property EditFillFiller[index: TThemedEdit; flp: TLMDGradientFillPart]: TLMDFiller read GetEditFillFiller write SetEditFillFiller;
    property EditFrameFiller[index: TThemedEdit; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetEditFrameFiller write SetEditFrameFiller;

    property SpinBtnFill[index: TThemedSpin]: TLMDGradientThemeFillDescriptor read GetSpinBtnFill write SetSpinBtnFill;
    property SpinBtnFrame[index: TThemedSpin]: TLMDGradientThemeFrameDescriptor read GetSpinBtnFrame write SetSpinBtnFrame;
    property SpinBtnFillParam[index: TThemedSpin; param: TLMDGradientThemeFillParam]: byte read GetSpinBtnFillParam write SetSpinBtnFillParam;
    property SpinBtnFrameParam[index: TThemedSpin; param: TLMDGradientThemeFrameParam]: byte read GetSpinBtnFrameParam write SetSpinBtnFrameParam;
    property SpinBtnFillFiller[index: TThemedSpin; flp: TLMDGradientFillPart]: TLMDFiller read GetSpinBtnFillFiller write SetSpinBtnFillFiller;
    property SpinBtnFrameFiller[index: TThemedSpin; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetSpinBtnFrameFiller write SetSpinBtnFrameFiller;

    property ScrollBarFill[index: TThemedScrollBar]: TLMDGradientThemeFillDescriptor read GetScrollBarFill write SetScrollBarFill;
    property ScrollBarFrame[index: TThemedScrollBar]: TLMDGradientThemeFrameDescriptor read GetScrollBarFrame write SetScrollBarFrame;
    property ScrollBarFillParam[index: TThemedScrollBar; param: TLMDGradientThemeFillParam]: byte read GetScrollBarFillParam write SetScrollBarFillParam;
    property ScrollBarFrameParam[index: TThemedScrollBar; param: TLMDGradientThemeFrameParam]: byte read GetScrollBarFrameParam write SetScrollBarFrameParam;
    property ScrollBarFillFiller[index: TThemedScrollBar; flp: TLMDGradientFillPart]: TLMDFiller read GetScrollBarFillFiller write SetScrollBarFillFiller;
    property ScrollBarFrameFiller[index: TThemedScrollBar; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetScrollBarFrameFiller write SetScrollBarFrameFiller;

    property TabFill[index: TThemedTab]: TLMDGradientThemeFillDescriptor read GetTabFill write SetTabFill;
    property TabFrame[index: TThemedTab]: TLMDGradientThemeFrameDescriptor read GetTabFrame write SetTabFrame;
    property TabFillParam[index: TThemedTab; param: TLMDGradientThemeFillParam]: byte read GetTabFillParam write SetTabFillParam;
    property TabFrameParam[index: TThemedTab; param: TLMDGradientThemeFrameParam]: byte read GetTabFrameParam write SetTabFrameParam;
    property TabFillFiller[index: TThemedTab; flp: TLMDGradientFillPart]: TLMDFiller read GetTabFillFiller write SetTabFillFiller;
    property TabFrameFiller[index: TThemedTab; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetTabFrameFiller write SetTabFrameFiller;

    property ProgressFill[index: TThemedProgress]: TLMDGradientThemeFillDescriptor read GetProgressFill write SetProgressFill;
    property ProgressFrame[index: TThemedProgress]: TLMDGradientThemeFrameDescriptor read GetProgressFrame write SetProgressFrame;
    property ProgressFillParam[index: TThemedProgress; param: TLMDGradientThemeFillParam]: byte read GetProgressFillParam write SetProgressFillParam;
    property ProgressFrameParam[index: TThemedProgress; param: TLMDGradientThemeFrameParam]: byte read GetProgressFrameParam write SetProgressFrameParam;
    property ProgressFillFiller[index: TThemedProgress; flp: TLMDGradientFillPart]: TLMDFiller read GetProgressFillFiller write SetProgressFillFiller;
    property ProgressFrameFiller[index: TThemedProgress; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetProgressFrameFiller write SetProgressFrameFiller;

    property HeaderFill[index: TThemedHeader]: TLMDGradientThemeFillDescriptor read GetHeaderFill write SetHeaderFill;
    property HeaderFrame[index: TThemedHeader]: TLMDGradientThemeFrameDescriptor read GetHeaderFrame write SetHeaderFrame;
    property HeaderFillParam[index: TThemedHeader; param: TLMDGradientThemeFillParam]: byte read GetHeaderFillParam write SetHeaderFillParam;
    property HeaderFrameParam[index: TThemedHeader; param: TLMDGradientThemeFrameParam]: byte read GetHeaderFrameParam write SetHeaderFrameParam;
    property HeaderFillFiller[index: TThemedHeader; flp: TLMDGradientFillPart]: TLMDFiller read GetHeaderFillFiller write SetHeaderFillFiller;
    property HeaderFrameFiller[index: TThemedHeader; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetHeaderFrameFiller write SetHeaderFrameFiller;

    property TrackBarFill[index: TThemedTrackBar]: TLMDGradientThemeFillDescriptor read GetTrackBarFill write SetTrackBarFill;
    property TrackBarFrame[index: TThemedTrackBar]: TLMDGradientThemeFrameDescriptor read GetTrackBarFrame write SetTrackBarFrame;
    property TrackBarFillParam[index: TThemedTrackBar; param: TLMDGradientThemeFillParam]: byte read GetTrackBarFillParam write SetTrackBarFillParam;
    property TrackBarFrameParam[index: TThemedTrackBar; param: TLMDGradientThemeFrameParam]: byte read GetTrackBarFrameParam write SetTrackBarFrameParam;
    property TrackBarFillFiller[index: TThemedTrackBar; flp: TLMDGradientFillPart]: TLMDFiller read GetTrackBarFillFiller write SetTrackBarFillFiller;
    property TrackBarFrameFiller[index: TThemedTrackBar; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetTrackBarFrameFiller write SetTrackBarFrameFiller;

    property StatusBarFill[index: TThemedStatus]: TLMDGradientThemeFillDescriptor read GetStatusBarFill write SetStatusBarFill;
    property StatusBarFrame[index: TThemedStatus]: TLMDGradientThemeFrameDescriptor read GetStatusBarFrame write SetStatusBarFrame;
    property StatusBarFillParam[index: TThemedStatus; param: TLMDGradientThemeFillParam]: byte read GetStatusBarFillParam write SetStatusBarFillParam;
    property StatusBarFrameParam[index: TThemedStatus; param: TLMDGradientThemeFrameParam]: byte read GetStatusBarFrameParam write SetStatusBarFrameParam;
    property StatusBarFillFiller[index: TThemedStatus; flp: TLMDGradientFillPart]: TLMDFiller read GetStatusBarFillFiller write SetStatusBarFillFiller;
    property StatusBarFrameFiller[index: TThemedStatus; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetStatusBarFrameFiller write SetStatusBarFrameFiller;

    property TreeViewFrame[index: TThemedTreeview]: TLMDGradientThemeFrameDescriptor read GetTreeViewFrame write SetTreeViewFrame;
    property TreeViewFrameParam[index: TThemedTreeview; param: TLMDGradientThemeFrameParam]: byte read GetTreeViewFrameParam write SetTreeViewFrameParam;
    property TreeViewFrameFiller[index: TThemedTreeview; frp: TLMDGradientSimpleFramePartKind]: TLMDFiller read GetTreeViewFrameFiller write SetTreeViewFrameFiller;

    property GradientArrowFiller[index: TLMDDirection; btns: TLMDThemedButtonState]: TLMDFiller read GetGradientArrowFiller write SetGradientArrowFiller;
    property SimpleArrowColors[index: boolean]: TColor read GetSimpleArrowColors write SetSimpleArrowColors;
    property SimpleArrowShadowColors[index: boolean]: TColor read GetSimpleArrowShadowColors write SetSimpleArrowShadowColors;

    property CheckMarkFill[index: boolean]: TLMDGradientThemeFillDescriptor read GetCheckMarkFill write SetCheckMarkFill;
    property RadioBtnCheckMarkFill[index: boolean]: TLMDGradientThemeFillDescriptor read GetRadioBtnCheckMarkFill write SetRadioBtnCheckMarkFill;
    property MixedMarkFill[index: boolean]: TLMDGradientThemeFillDescriptor read GetMixedMarkFill write SetMixedMarkFill;

    property PixelFormat: TPixelFormat read FPixelFormat write SetPixelFormat default pf24bit;
    property XMLDoc:ILMDXmlDocument read FXMLDoc;
    property Modified: boolean read FModified;
    property UseCache: boolean read GetUseCache write SetUseCache default true;

    property OnDrawElement: TLMDThemesOnDrawElement read FOnDrawElement write FOnDrawElement;
    property OnDrawCheckMark: TLMDThemesOnDrawCheckMarkEvent read FOnDrawCheckMark write FOnDrawCheckMark;
    property OnDrawScrollThumbGripper: TLMDThemesOnDrawScrollThumbGripperEvent read FOnDrawScrollThumbGripper write FOnDrawScrollThumbGripper;
    property OnDrawArrow: TLMDThemesOnDrawArrowEvent read FOnDrawArrow write FOnDrawArrow;
    property OnDrawGradientArrow: TLMDThemesOnDrawGradientArrowEvent read FOnDrawGradientArrow write FOnDrawGradientArrow;
    property OnDrawPlus: TLMDThemesOnDrawSimpleSignEvent read FOnDrawPlus write FOnDrawPlus;
    property OnDrawMinus: TLMDThemesOnDrawSimpleSignEvent read FOnDrawMinus write FOnDrawMinus;
    property OnDrawCross: TLMDThemesOnDrawSimpleSignEvent read FOnDrawCross write FOnDrawCross;
    
  end;


implementation


uses
  Math, Messages, LMDRTLXConst, LMDDebugUnit, LMDSysIn, LMDStrings, LMDThemesConst, LMDProcs, LMDGraphUtils, LMDCabSupport;

{-----------------TLMDBaseGradientThemeRenderer -----------------------------}
function TLMDBaseGradientThemeRenderer.GetDisabledTextColor: TColor;
begin
  result := FDisabledTextColor;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetEnabledTextColor: TColor;
begin
  result := FEnabledTextColor;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetDisabledTextColor(
  const Value: TColor);
begin
  if Value <> DisabledTextColor then
    begin
      FDisabledTextColor := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetEnabledTextColor(
  const Value: TColor);
begin
  if Value <> EnabledTextColor then
    begin
      FEnabledTextColor := Value;
      DoUpdateTheme;
    end;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawArrow(DC: HDC; ARect: TRect; ADir: TLMDDirection; aDrawShadow: boolean; aEnabled: boolean);
var
  dx, dy, x, y: integer;
  lPen, lOldPen: HPEN;
  lExit: boolean;


 procedure Draw(ax, ay: integer; aColor: TColor);
 begin
   lPen := CreatePen(PS_SOLID, 1, aColor);
   lOldPen := SelectObject(DC, lPen);
   case ADir of
     tdDown:
       begin
         MoveToEx(DC, ax - 2, ay - 1, nil);
         LineTo(DC, ax + 3, ay - 1);
         MoveToEx(DC, ax - 1, ay, nil);
         LineTo(DC, ax + 2, ay);
         MoveToEx(DC, ax, ay, nil);
         LineTo(DC, ax, ay + 2);
       end;
     tdUp:
       begin
         MoveToEx(DC, ax - 2, ay + 1, nil);
         LineTo(DC, ax + 3, ay + 1);
         MoveToEx(DC, ax - 1, ay, nil);
         LineTo(DC, ax + 2, ay);
         MoveToEx(DC, ax, ay, nil);
         LineTo(DC, ax, ay - 2);
       end;
     tdLeft:
       begin
         MoveToEx(DC, ax + 1, ay - 2, nil);
         LineTo(DC, ax + 1, ay + 3);
         MoveToEx(DC, ax, ay - 1, nil);
         LineTo(DC, ax, ay + 2);
         MoveToEx(DC, ax, ay, nil);
         LineTo(DC, ax - 2, ay);
       end;
     tdRight:
       begin
         MoveToEx(DC, ax - 1, ay - 2, nil);
         LineTo(DC, ax - 1, ay + 3);
         MoveToEx(DC, ax, ay - 1, nil);
         LineTo(DC, ax, ay + 2);
         MoveToEx(DC, ax, ay, nil);
         LineTo(DC, ax + 2, ay);
       end;
   end;
   SelectObject(DC, lOldPen);
   DeleteObject(lPen);
 end;

begin
  lExit := false;
  if Assigned(FOnDrawArrow) then
    FOnDrawArrow(Self, DC, aRect, aDir, aDrawShadow, aEnabled, lExit);
  if not lExit then
  begin
    LMDAdjustRect(ARect, 1, 1);
    dx := 0;
    dy := 0;
    x := (ARect.Right + ARect.Left) div 2;
    y := (ARect.Bottom + ARect.Top) div 2 - 1;
    if aDrawShadow then
      begin
        case ADir of
          tdDown:
            begin
              dx := 0;
              dy := 1;
            end;
          tdUp:
            begin
              dx := 0;
              dy := -1;
            end;
          tdLeft:
            begin
              dx := -1;
              dy := 0;
            end;
          tdRight:
            begin
              dx := 1;
              dy := 0;
            end;
          end;
        Draw(x + dx, y + dy, FSimpleArrowShadowColors[aEnabled]);
      end;
    Draw(x, y, FSimpleArrowColors[aEnabled]);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawCross(DC: HDC; ARect: TRect; aDrawShadow: boolean);
var
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawCross) then
    FOnDrawCross(Self, DC, aRect, aDrawShadow, lExit);
  if not lExit then
  begin
  //
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawCheckMark(DC: HDC; ARect: TRect; acb: TThemedButton);
var
  lUf: TLMDUnionFigure;
  lFiller, lTmpFiller: TLMDFiller;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawCheckMark) then
    FOnDrawCheckMark(Self, DC, aRect, acb, lExit);
  if not lExit then
  begin
    if acb in [tbCheckBoxCheckedNormal..tbCheckBoxCheckedDisabled] then
    begin
      //LMDAdjustRect(ARect, 1, 1);
      lUf := TLMDUnionFigure.Create;
      lUF.AntiAliasing := true;
      FLine1.Width := 1;
      FLine1.PointFrom := Point(aRect.Left+1, (aRect.Top+aRect.Bottom) div 2);
      FLine1.PointTo := Point((aRect.Left + aRect.Right) div 2, aRect.Bottom );
      lUf.Add(FLine1);
      FLine2.Width := 1;
      FLine2.PointFrom := Point((aRect.Left + aRect.Right) div 2-1, aRect.Bottom);
      FLine2.PointTo := Point(aRect.Right, aRect.Top - 2);
      lUf.Add(FLine2);
      lUf.Filler := FCheckMarkFill[acb <> tbCheckBoxCheckedDisabled].Fillers[gfpMain];
      lUf.Draw(DC, FPixelFormat);
      lUf.Free;
    end;
    if acb in [tbCheckBoxMixedNormal..tbCheckBoxMixedDisabled] then
    begin
      FRectangle.Filler := FMixedMarkFill[acb <> tbCheckBoxMixedDisabled].Fillers[gfpMain];
      FRectangle.Rectangle(aRect);
      FRectangle.Draw(DC, FPixelFormat);
    end;
    if acb in [tbRadioButtonCheckedNormal..tbRadioButtonCheckedDisabled] then
    begin
      lFiller := FRadioBtnCheckMarkFill[acb <> tbRadioButtonCheckedDisabled].Fillers[gfpMain];
      lTmpFiller := PrepareFillerFrom(lFiller);
      with FCircle do
        begin
          Filler := lTmpFiller;
          Center := LMDMiddlePoint(aRect.TopLeft, aRect.BottomRight);
          Radius := Center.X - aRect.Left;
          if lFiller is TLMDSolidFiller then
            Filler := lFiller
          else
            SetFillerParams(Filler, lFiller, aRect);
          Draw(DC, FPixelFormat);
        end;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawPlus(DC: HDC; ARect: TRect; aFrameColor, AFillColor1, aFillColor2, aShadowColor:TColor; aDrawShadow: boolean);
var
  x, y: integer;
  lOldPen, lPen: HPEN;
  lExit: boolean;

  procedure DrawFill(aFillColor1, aFillColor2: TColor; aPartFlag: byte);
    begin
      if ((aPartFlag and 1) = 1) then
        begin
          lPen := CreatePen(PS_SOLID, 1, aFillColor1);
          lOldPen := SelectObject(DC, lPen);

          MoveToEx(DC, x, y, nil);
          LineTo(DC, x + 8, y);
          MoveToEx(DC, x + 3, y, nil);
          LineTo(DC, x + 3, y - 4);
          MoveToEx(DC, x + 4, y, nil);
          LineTo(DC, x + 4, y - 4);

          SelectObject(DC, lOldPen);
          DeleteObject(lPen);
        end;
      if ((aPartFlag and 2) = 2) then
        begin
          lPen := CreatePen(PS_SOLID, 1, aFillColor2);
          lOldPen := SelectObject(DC, lPen);
          if (aPartFlag = 2) then
            begin
              MoveToEx(DC, x, y, nil);
              LineTo(DC, x + 8, y);
            end;
          MoveToEx(DC, x, y + 1, nil);
          LineTo(DC, x + 8, y + 1);
          MoveToEx(DC, x + 3, y + 1, nil);
          LineTo(DC, x + 3, y + 5);
          MoveToEx(DC, x + 4, y + 1, nil);
          LineTo(DC, x + 4, y + 5);
          SelectObject(DC, lOldPen);
          DeleteObject(lPen);
        end;
    end;

  procedure DrawFrame;
    begin
      lPen := CreatePen(PS_SOLID, 1, aFrameColor);
      lOldPen := SelectObject(DC, lPen);

      MoveToEx(DC, x, y, nil);
      LineTo(DC, x + 3, y);
      LineTo(DC, x + 3, y - 3);
      LineTo(DC, x + 6, y - 3);
      LineTo(DC, x + 6, y);
      LineTo(DC, x + 9, y);
      LineTo(DC, x + 9, y + 3);
      LineTo(DC, x + 6, y + 3);
      LineTo(DC, x + 6, y + 6);
      LineTo(DC, x + 3, y + 6);
      LineTo(DC, x + 3, y + 3);
      LineTo(DC, x , y + 3);
      LineTo(DC, x, y);

      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end;

begin
  lExit := false;
  if Assigned(FOnDrawMinus) then
    FOnDrawPlus(Self, DC, aRect, aDrawShadow, lExit);
  if not lExit then
  begin
    LMDAdjustRect(ARect, 1, 1);
    x := ARect.Left + 3;
    y := ARect.Top + 7;
    if aDrawShadow then
      DrawFill(aShadowColor, aShadowColor, 2);

    x := ARect.Left + 1;
    y := ARect.Top + 5;
    DrawFill(aFillColor1, aFillColor2, 3);

    x := ARect.Left;
    y := ARect.Top + 4;
    DrawFrame;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawMinus(DC: HDC; ARect: TRect; aFrameColor, AFillColor1, aFillColor2, aShadowColor:TColor; aDrawShadow: boolean);
var
  x, y: integer;
  lOldPen, lPen: HPEN;
  lExit: boolean;

  procedure DrawFill(aFillColor1, aFillColor2: TColor);
    begin
      lPen := CreatePen(PS_SOLID, 1, aFillColor1);
      lOldPen := SelectObject(DC, lPen);

      MoveToEx(DC, x, y, nil);
      LineTo(DC, x + 8, y);

      SelectObject(DC, lOldPen);
      DeleteObject(lPen);

      lPen := CreatePen(PS_SOLID, 1, aFillColor2);
      lOldPen := SelectObject(DC, lPen);
      MoveToEx(DC, x, y + 1, nil);
      LineTo(DC, x + 8, y + 1);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end;

  procedure DrawFrame;
    begin
      lPen := CreatePen(PS_SOLID, 1, aFrameColor);
      lOldPen := SelectObject(DC, lPen);

      MoveToEx(DC, x, y, nil);
      LineTo(DC, x + 9, y);
      LineTo(DC, x + 9, y + 3);
      LineTo(DC, x, y + 3);
      LineTo(DC, x, y);

      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end;

begin
  lExit := false;
  if Assigned(FOnDrawMinus) then
    FOnDrawMinus(Self, DC, aRect, aDrawShadow, lExit);
  if not lExit then
  begin
    LMDAdjustRect(ARect, 1, 1);

    x := ARect.Left + 3;
    y := ARect.Top + 7;
    if aDrawShadow then
      DrawFill(aShadowColor, aShadowColor);

    x := ARect.Left + 1;
    y := ARect.Top + 5;
    DrawFill(aFillColor1, aFillColor2);

    x := ARect.Left;
    y := ARect.Top + 4;
    DrawFrame;
  end;
end;


{------------------------- Public ---------------------------------------------}
constructor TLMDBaseGradientThemeRenderer.Create;
var
  te: TThemedElement;
begin
  inherited;

  FOnDrawElement := nil;
  FOnDrawCheckMark := nil;
  FOnDrawScrollThumbGripper := nil;
  FOnDrawArrow := nil;
  FOnDrawGradientArrow := nil;
  FOnDrawPlus := nil;
  FOnDrawMinus := nil;
  FOnDrawCross := nil;

  FSuppressUpdate := false;
  FUseCache := true;
  FEnabled := true;
  FPixelFormat := pf24bit;
  FIsUpdating := false;
  FBmpCache := TStringList.Create;
  FBmpCache.Sorted := true;

  FRFrame := TLMDGradientRectFrame.Create;
  FCFrame := TLMDGradientCircleFrame.Create;
  FRoundRectangle := TLMDRoundRectangle.Create;
  FCCRectangle := TLMDCustomCutRectangle.Create;
  FCircle := TLMDCircle.Create;
  FRectangle := TLMDRoundRectangle.Create;
  FLine1 := TLMDLine.Create;
  FLine2 := TLMDLine.Create;

  FFillerToolBox := TStringList.Create;
  FFillerToolBox.AddObject(TLMDSolidFiller.ClassName, TLMDSolidFiller.Create);
  FFillerToolBox.AddObject(TLMDVerticalGradient.ClassName, TLMDVerticalGradient.Create);
  FFillerToolBox.AddObject(TLMDHorizontalGradient.ClassName, TLMDHorizontalGradient.Create);
  FFillerToolBox.AddObject(TLMDEllipseFiller.ClassName, TLMDEllipseFiller.Create);
  FFillerToolBox.AddObject(TLMDCompositeFiller.ClassName, TLMDCompositeFiller.Create);
  FFillerToolBox.AddObject(TLMDMixedFiller.ClassName, TLMDMixedFiller.Create);
  FFillerToolBox.AddObject(TLMDRoundFiller.ClassName, TLMDRoundFiller.Create);
  FFillerToolBox.AddObject(TLMDRectangleFiller.ClassName, TLMDRectangleFiller.Create);
  FFillerToolBox.AddObject(TLMDLineFiller.ClassName, TLMDLineFiller.Create);

  FMetaDataPool := TStringList.Create;
  with FMetaData do
  begin
    ElementTypeInfo := TypeInfo(TThemedElement);
    SetLength(DetailData, GetTypeData(ElementTypeInfo)^.MaxValue - GetTypeData(ElementTypeInfo)^.MinValue + 1);

    for te := low(TThemedElement) to high(TThemedElement) do
      with DetailData[ord(te)] do
        begin
          DetailTypeInfo := nil;
          FillData := nil;
          FrameData := nil;
          AuxData := nil;
        end;

    DetailData[ord(teButton)].DetailTypeInfo := TypeInfo(TThemedButton);
    DetailData[ord(teButton)].FillData := @FButtonFill;
    DetailData[ord(teButton)].FrameData := @FButtonFrame;

    DetailData[ord(teComboBox)].DetailTypeInfo := TypeInfo(TThemedComboBox);
    DetailData[ord(teComboBox)].FillData := @FComboboxFill;
    DetailData[ord(teComboBox)].FrameData := @FComboboxFrame;

    DetailData[ord(teEdit)].DetailTypeInfo := TypeInfo(TThemedEdit);
    DetailData[ord(teEdit)].FillData := @FEditFill;
    DetailData[ord(teEdit)].FrameData := @FEditFrame;

    DetailData[ord(teHeader)].DetailTypeInfo := TypeInfo(TThemedHeader);
    DetailData[ord(teHeader)].FillData := @FHeaderFill;
    DetailData[ord(teHeader)].FrameData := @FHeaderFrame;

    DetailData[ord(teProgress)].DetailTypeInfo := TypeInfo(TThemedProgress);
    DetailData[ord(teProgress)].FillData := @FProgressFill;
    DetailData[ord(teProgress)].FrameData := @FProgressFrame;

    DetailData[ord(teScrollBar)].DetailTypeInfo := TypeInfo(TThemedScrollBar);
    DetailData[ord(teScrollBar)].FillData := @FScrollBarFill;
    DetailData[ord(teScrollBar)].FrameData := @FScrollBarFrame;

    DetailData[ord(teSpin)].DetailTypeInfo := TypeInfo(TThemedSpin);
    DetailData[ord(teSpin)].FillData := @FSpinBtnFill;
    DetailData[ord(teSpin)].FrameData := @FSpinBtnFrame;

    DetailData[ord(teTab)].DetailTypeInfo := TypeInfo(TThemedTab);
    DetailData[ord(teTab)].FillData := @FTabFill;
    DetailData[ord(teTab)].FrameData := @FTabFrame;
    DetailData[ord(teTab)].TextData := @FTabText;

    DetailData[ord(teToolbar)].DetailTypeInfo := TypeInfo(TThemedToolbar);
    DetailData[ord(teToolbar)].FillData := @FToolbarFill;
    DetailData[ord(teToolbar)].FrameData := @FToolbarFrame;

    DetailData[ord(teTrackbar)].DetailTypeInfo := TypeInfo(TThemedTrackBar);
    DetailData[ord(teTrackbar)].FillData := @FTrackbarFill;
    DetailData[ord(teTrackbar)].FrameData := @FTrackbarFrame;

    DetailData[ord(teStatus)].DetailTypeInfo := TypeInfo(TThemedStatus);
    DetailData[ord(teStatus)].FillData := @FStatusBarFill;
    DetailData[ord(teStatus)].FrameData := @FStatusBarFrame;

    DetailData[ord(teTreeView)].DetailTypeInfo := TypeInfo(TThemedTreeview);
    DetailData[ord(teTreeView)].FillData := nil;
    DetailData[ord(teTreeView)].FrameData := @FTreeViewFrame;
  end;

  RegisterMetaData(TypeInfo(TThemedElement), @FMetaData);
end;

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.ActivateDefaultTheme(AColorScheme: string = ''; aDoApply: boolean = true):boolean;
var
  ltb: TThemedButton;
  ltcb: TThemedCombobox;
  lte: TThemedEdit;
  ltbr: TThemedToolBar;
  lts: TThemedSpin;
  lsb: TThemedScrollBar;

  pfld: PLMDGradientThemeFillData;
  pfrd: PLMDGradientThemeFrameData;
  flpm: TLMDGradientThemeFillParam;
  frpm: TLMDGradientThemeFrameParam;

  flp: TLMDGradientFillPart;
  frp: TLMDGradientSimpleFramePartKind;

  lf: TLMDFiller;
  mf: TLMDMixedFiller;

  te: TThemedElement;
  i: integer;
  b: byte;
  btns: TLMDThemedButtonState;
  ldir : TLMDDirection;
begin
  DeactivateTheme;
  FColorScheme := csUnknown;

  FThemeName := cGradientThemeNames[gtOffice2007];
  if AColorScheme = '' then
    AColorScheme := 'Blue';

  if SameText(AColorScheme, CBuiltInColorSchemes[csBlue]) then
    FColorScheme := csBlue;
  if SameText(AColorScheme, CBuiltInColorSchemes[csMetallic]) then
    FColorScheme := csMetallic;
  if SameText(AColorScheme, CBuiltInColorSchemes[csBlack]) then
    FColorScheme := csBlack;
  if SameText(AColorScheme, CBuiltInColorSchemes[csHomestead]) then
    FColorScheme := csHomestead;
  if SameText(AColorScheme, CBuiltInColorSchemes[csVistaBasic]) then
    FColorScheme := csVistaBasic;

  if FColorScheme = csUnknown then
    FColorSchemeName := aColorScheme
  else
    FColorSchemeName := CBuiltInColorSchemes[FColorScheme];

  //initialize fill and frame params
  for te := low(TThemedElement) to high(TThemedElement) do
    if (FMetaData.DetailData[ord(te)].DetailTypeInfo <> nil) then
    begin
      pfld := PLMDGradientThemeFillData(FMetaData.DetailData[ord(te)].FillData);
      pfrd := PLMDGradientThemeFrameData(FMetaData.DetailData[ord(te)].FrameData);
      for i := GetTypeData(FMetaData.DetailData[ord(te)].DetailTypeInfo)^.MinValue to GetTypeData(FMetaData.DetailData[ord(te)].DetailTypeInfo)^.MaxValue do
        begin
          if pfld <> nil then
            begin
              for flpm := low(TLMDGradientThemeFillParam) to high(TLMDGradientThemeFillParam) do
                pfld^[i].Params[flpm] := 0;
              pfld^[i].Params[gflpRenderMode] := cStandardFillRenderMode;
              for flp := low(TLMDGradientFillPart) to high(TLMDGradientFillPart) do
                pfld^[i].Fillers[flp] := nil;
            end;

          if pfrd <> nil then
            begin
              for frpm := low(TLMDGradientThemeFrameParam) to high(TLMDGradientThemeFrameParam) do
                pfrd^[i].Params[frpm] := 0;
              pfrd^[i].Params[gfrpRenderMode] := cStandardFrameRenderMode;
              for frp := low(TLMDGradientSimpleFramePartKind) to high(TLMDGradientSimpleFramePartKind) do
                pfrd^[i].Fillers[frp] := nil;

              with pfrd^[i] do
                begin
                  Params[gfrpRenderMode] := cStandardFrameRenderMode;

                  Params[gfrpOuterBorderSides] := LMDFrameSidesToByte(AllFrameSides);
                  Params[gfrpInnerBorderSides] := LMDFrameSidesToByte(AllFrameSides);

                  Params[gfrpOuterBorderWidth] := 1;
                  Params[gfrpInnerBorderWidth] := 1;
                  Params[gfrpCutValueUsage] := ord(cvuXOnly);

                  Params[gfrpOuterBorderOuterCutX] := 2;
                  Params[gfrpOuterBorderInnerCutX] := 2;
                  Params[gfrpOuterBorderInnerCutXValueType] := ord(vtAbsolute);
                  Params[gfrpOuterBorderOuterCutXValueType] := ord(vtAbsolute);

                  Params[gfrpInnerSpaceOuterCutX] := 1;
                  Params[gfrpInnerSpaceInnerCutX] := 1;
                  Params[gfrpInnerSpaceInnerCutXValueType] := ord(vtAbsolute);
                  Params[gfrpInnerSpaceOuterCutXValueType] := ord(vtAbsolute);

                  Params[gfrpInnerBorderOuterCutX] := 1;
                  Params[gfrpInnerBorderInnerCutX] := 1;
                  Params[gfrpInnerBorderOuterCutXValueType] := ord(vtAbsolute);
                  Params[gfrpInnerBorderInnerCutXValueType] := ord(vtAbsolute);

                  Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(cRoundCutCorners);
                  Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(cRoundCutCorners);
                  Params[gfrpInnerSpaceOuterCutType] := LMDCornerCutToByte(cRoundCutCorners);
                  Params[gfrpInnerSpaceInnerCutType] := LMDCornerCutToByte(cRoundCutCorners);
                  Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(cRoundCutCorners);
                  Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(cRoundCutCorners);
                end;
            end;
        end;
      end;

  FSimpleArrowColors[true] := $00B17D56;
  if FColorScheme in [csMetallic, csBlack] then
    FSimpleArrowColors[true] := $007C7C7C;

  FSimpleArrowShadowColors[true] := $00CBF8FF;
  FSimpleArrowColors[false] := $00E7E3E7;
  FSimpleArrowShadowColors[false] := $00EEE7DD;

  for btns := low(TLMDThemedButtonState) to high(TLMDThemedButtonState) do
    for ldir := low(TLMDDirection) to high(TLMDDirection) do
      FGradientArrowFiller[ldir, btns] := nil;

  FGradientArrowFiller[tdLeft, btnsNormal] := TLMDHorizontalGradient.Create;
  FGradientArrowFiller[tdLeft, btnsNormal].ColorCount := 2;

  FGradientArrowFiller[tdLeft, btnsNormal].FixedColors[0] := $00A67E6E;
  FGradientArrowFiller[tdLeft, btnsNormal].FixedColors[1] := $00634B42;
  if FColorScheme in [csBlack] then
    begin
      FGradientArrowFiller[tdLeft, btnsNormal].FixedColors[0] := $00CACACA;
      FGradientArrowFiller[tdLeft, btnsNormal].FixedColors[1] := $00797979;
    end;

  FGradientArrowFiller[tdRight, btnsNormal] := TLMDHorizontalGradient.Create;
  FGradientArrowFiller[tdRight, btnsNormal].ColorCount := 2;
  FGradientArrowFiller[tdRight, btnsNormal].FixedColors[0] := $00634B42;
  FGradientArrowFiller[tdRight, btnsNormal].FixedColors[1] := $00A67E6E;
  if FColorScheme in [csBlack] then
    begin
      FGradientArrowFiller[tdRight, btnsNormal].FixedColors[0] := $00CACACA;
      FGradientArrowFiller[tdRight, btnsNormal].FixedColors[1] := $008D8D8D;
    end;

  FGradientArrowFiller[tdUp, btnsNormal] := TLMDVerticalGradient.Create;
  FGradientArrowFiller[tdDown, btnsNormal] := TLMDVerticalGradient.Create;
  FGradientArrowFiller[tdUp, btnsNormal].CopyColorsAndAlphaFrom(FGradientArrowFiller[tdLeft, btnsNormal]);
  FGradientArrowFiller[tdDown, btnsNormal].CopyColorsAndAlphaFrom(FGradientArrowFiller[tdRight, btnsNormal]);

  FGradientArrowFiller[tdLeft, btnsDisabled] := TLMDHorizontalGradient.Create;
  FGradientArrowFiller[tdRight, btnsDisabled] := TLMDHorizontalGradient.Create;
  FGradientArrowFiller[tdUp, btnsDisabled] := TLMDVerticalGradient.Create;
  FGradientArrowFiller[tdDown, btnsDisabled] := TLMDVerticalGradient.Create;
  FGradientArrowFiller[tdLeft, btnsDisabled].ColorCount := 2;
  FGradientArrowFiller[tdLeft, btnsDisabled].FixedColors[0] := $00E5DAD0;
  FGradientArrowFiller[tdLeft, btnsDisabled].FixedColors[1] := $00B7B7B7;
  FGradientArrowFiller[tdRight, btnsDisabled].ColorCount := 2;
  FGradientArrowFiller[tdRight, btnsDisabled].FixedColors[0] := $00E5DAD0;
  FGradientArrowFiller[tdRight, btnsDisabled].FixedColors[1] := $00B7B7B7;
  FGradientArrowFiller[tdUp, btnsDisabled].CopyColorsAndAlphaFrom(FGradientArrowFiller[tdLeft, btnsDisabled]);
  FGradientArrowFiller[tdDown, btnsDisabled].CopyColorsAndAlphaFrom(FGradientArrowFiller[tdRight, btnsDisabled]);

  //---------------- teEdit --------------------------------------------------//
  for lte := low(TThemedEdit) to high(TThemedEdit) do
    begin
      //FEditFrame[lte].Params[gfrpInnerBorderWidth] := 0;
      //FEditFrame[lte].Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(cRectCorners);
      if lte in [teEditDontCare, teEditRoot, teEditTextNormal, teEditTextDisabled, teEditTextReadOnly, teEditTextAssist] then
        begin
          with FEditFill[lte] do
            begin
              Fillers[gfpMain] := TLMDSolidFiller.Create;
              TLMDSolidFiller(Fillers[gfpMain]).Color := $00FBF2EA;
              if FColorScheme in [csMetallic, csBlack] then
                TLMDSolidFiller(Fillers[gfpMain]).Color :=  $00ECEAE8;
            end;
          with FEditFrame[lte] do
            begin
              Fillers[sfpOuterBorder] := TLMDSolidFiller.Create;
              TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00DEC1AB;
              if FColorScheme in [csMetallic, csBlack] then
                TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00B8B1A9;
              Fillers[sfpInnerBorder] := TLMDSolidFiller.Create;
              TLMDSolidFiller(Fillers[sfpInnerBorder]).Color := clWhite;
            end;
        end;
      if lte in [teEditTextHot, teEditTextSelected, teEditTextFocused, teEditCaret] then
        begin
          with FEditFill[lte] do
            begin
              Fillers[gfpMain] := TLMDSolidFiller.Create;
              TLMDSolidFiller(Fillers[gfpMain]).Color := clWhite;
            end;
          with FEditFrame[lte] do
            begin
              Fillers[sfpOuterBorder] := TLMDSolidFiller.Create;
              TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00FDEFE4;
              if FColorScheme in [csMetallic, csBlack] then
                TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00B8B1A9;
              Fillers[sfpInnerBorder] := TLMDSolidFiller.Create;
              TLMDSolidFiller(Fillers[sfpInnerBorder]).Color := clWhite;
            end;
        end;
    end;
  //------------End of teEdit section-----------------------------------------//

  //---------------- teButton: PushButton ------------------------------------//
  with FButtonFill[tbPushButtonNormal] do
    begin
      Fillers[gfpMain] := TLMDCompositeFiller.Create;
      Fillers[gfpMain].UseRelativeUnits := true;
      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00F8E0CE;
        csMetallic:
          lf.FixedColors[0] := $00F3F3F1;
        csBlack:
          lf.FixedColors[0] := $00DFDED6;
      end;
      case FColorScheme of
        csBlue:
          lf.FixedColors[1] := $00F8E0CE;
        csMetallic:
          lf.FixedColors[1] := $00F2F2F0;
        csBlack:
          lf.FixedColors[1] := $00E4E2DC;
      end;

      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);
      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00F5D3B9;
        csMetallic:
          lf.FixedColors[0] := $00EEEAE7;
        csBlack:
          lf.FixedColors[0] := $00D7D5CE;
      end;

      case FColorScheme of
        csBlue:
          lf.FixedColors[1] := $00F7E4D5;
        csMetallic:
          lf.FixedColors[1] := $00F8F7F6;
        csBlack:
          lf.FixedColors[1] := $00E7E5E0;
      end;
      lf.FixedAlpha[0] := 0;
      lf.FixedAlpha[1] := 0;
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0,0,100,50);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(0,50,100,100);
    end;
  with FButtonFrame[tbPushButtonNormal] do
    begin
      lf := TLMDSolidFiller.Create;
      TLMDSolidFiller(lf).Color := $00AA9787;
      Fillers[sfpOuterBorder] := lf;
      lf := TLMDSolidFiller.Create;
      TLMDSolidFiller(lf).Color := $00F9F5F1;
      Fillers[sfpInnerBorder] := lf;
    end;

  with FButtonFill[tbPushButtonHot] do
    begin
      Fillers[gfpMain] := TLMDCompositeFiller.Create;
      Fillers[gfpMain].UseRelativeUnits := true;
      lf := TLMDVerticalGradient.Create;
      lf.StartColor := $00E4FEFF;
      lf.EndColor := $00A2E7FF;
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);
      lf := TLMDEllipseFiller.Create;
      TLMDEllipseFiller(lf).BasePoint := Point(50, 100);
      TLMDEllipseFiller(lf).Axis1 := 120;
      TLMDEllipseFiller(lf).Axis2 := 100;
      TLMDEllipseFiller(lf).FirstAxisDirection := Point(1,0);
      lf.StartColor := $00AEEBFF;
      lf.EndColor := $0067D7FF;
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);

      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0,0,100,50);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(0,50,100,100);
    end;

  with FButtonFrame[tbPushButtonHot] do
    begin
      lf := TLMDSolidFiller.Create;
      TLMDSolidFiller(lf).Color := $0000DBFF;
      Fillers[sfpOuterBorder] := lf;
      lf := TLMDSolidFiller.Create;
      TLMDSolidFiller(lf).Color := $00EBF5FF;
      Fillers[sfpInnerBorder] := lf;
    end;

  with FButtonFill[tbPushButtonPressed] do
    begin
      Fillers[gfpMain] := TLMDCompositeFiller.Create;
      Fillers[gfpMain].UseRelativeUnits := true;
      lf := TLMDVerticalGradient.Create;
      lf.StartColor := $00ADD7FF;
      lf.EndColor := $0063B2FF;

      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);
      lf := TLMDEllipseFiller.Create;
      TLMDEllipseFiller(lf).BasePoint := Point(50, 100);
      TLMDEllipseFiller(lf).Axis1 := 100;
      TLMDEllipseFiller(lf).Axis2 := 100;
      TLMDEllipseFiller(lf).FirstAxisDirection := Point(100, 0);

      lf.StartColor := $00B5F3FF;
      lf.EndColor := $00319EFF;

      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);

      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0,0,100,50);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(0,50,100,100);
    end;

  with FButtonFrame[tbPushButtonPressed] do
    begin
      Params[gfrpInnerBorderWidth] := 1;
      lf := TLMDSolidFiller.Create;
      TLMDSolidFiller(lf).Color := $007BAAC6;
      Fillers[sfpOuterBorder] := lf;

      lf := TLMDVerticalGradient.Create;
      lf.UseRelativeUnits := true;
      TLMDVerticalGradient(lf).StartColor := $009CCFDE;
      TLMDVerticalGradient(lf).EndColor := $00B5F3FF;
      Fillers[sfpInnerBorder] := lf;
    end;

  with FButtonFill[tbPushButtonDefaulted] do
    begin
      Fillers[gfpMain] := TLMDCompositeFiller.Create;
      Fillers[gfpMain].UseRelativeUnits := true;
      lf := TLMDVerticalGradient.Create;
      lf.StartColor := $00DCFCFF;
      lf.EndColor := $007CC2EC;
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);
      lf := TLMDVerticalGradient.Create;
      lf.StartColor := $005BACDC;
      lf.EndColor := $00BEF7FF;
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);

      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0,0,100,50);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(0,50,100,100);
    end;

  with FButtonFrame[tbPushButtonDefaulted] do
    begin
      lf := TLMDSolidFiller.Create;
      TLMDSolidFiller(lf).Color := $00B17F3C;
      Fillers[sfpOuterBorder] := lf;
      lf := TLMDSolidFiller.Create;
      TLMDSolidFiller(lf).Color := $00FFD42E;
      Fillers[sfpInnerBorder] := lf;
    end;

  with FButtonFill[tbPushButtonDisabled] do
    begin
      lf := TLMDSolidFiller.Create;
      TLMDSolidFiller(lf).Color := $00F4F4F4;
      Fillers[gfpMain] := lf;
    end;

  with FButtonFrame[tbPushButtonDisabled] do
    begin
      lf := TLMDSolidFiller.Create;
      TLMDSolidFiller(lf).Color := $00B2B5AD;
      Fillers[sfpOuterBorder] := lf;
      lf := TLMDSolidFiller.Create;
      TLMDSolidFiller(lf).Color := $00FCFCFC;
      Fillers[sfpInnerBorder] := lf;
    end;
  //------------End of teButton: PushButton section---------------------------//

  //---------------- teButton: CheckBox --------------------------------------//
  for ltb := tbCheckBoxUncheckedNormal to tbCheckBoxMixedDisabled do
    begin
      with FButtonFrame[ltb] do
        begin
          Fillers[sfpOuterBorder] := TLMDSolidFiller.Create;
          Fillers[sfpInnerSpace] := TLMDSolidFiller.Create;;

          lf := TLMDLineFiller.Create;
          lf.ColorCount := 2;
          lf.BasePoint := Point(0,0);
          lf.VectorN := Point(100, 100);
          lf.VectorT := Point(100, -100);
          lf.UseRelativeUnits := true;
          Fillers[sfpInnerBorder] := lf;

          Params[gfrpTopSpaceWidth] := 1;
          Params[gfrpRightSpaceWidth] := 1;
          Params[gfrpBottomSpaceWidth] := 1;
          Params[gfrpLeftSpaceWidth] := 1;

          Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(cRectCorners);
          Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(cRectCorners);
          Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(cRectCorners);
          Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(cRectCorners);
        end;
      with FButtonFill[ltb] do
        begin
          lf := TLMDLineFiller.Create;
          lf.UseRelativeUnits := true;
          lf.BasePoint := Point(0,0);
          lf.VectorN := Point(60, 60);
          lf.VectorT := Point(60, -60);
          Fillers[gfpMain] := lf;
        end;
    end;

  with FButtonFill[tbCheckBoxUncheckedNormal] do
    begin
      Fillers[gfpMain].ColorCount := 2;
      Fillers[gfpMain].FixedColors[0] := $00D5CFCA;
      Fillers[gfpMain].FixedColors[1] := $00F6F6F6;
    end;
  with FButtonFrame[tbCheckBoxUncheckedNormal] do
    begin
      case FColorScheme of
        csBlue:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00DEC1AB;
        csMetallic:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00A09D9B;
        csBlack:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00848484;
      end;
      TLMDSolidFiller(Fillers[sfpInnerSpace]).Color := $00F4F4F4;
      Fillers[sfpInnerBorder].FixedColors[0] := $00B9ACA2;
      Fillers[sfpInnerBorder].FixedColors[1] := $00EAE6E4;
    end;

  with FButtonFill[tbCheckBoxUncheckedHot] do
    begin
      Fillers[gfpMain].ColorCount := 2;
      Fillers[gfpMain].FixedColors[0] := $00ADE7FF;
      Fillers[gfpMain].FixedColors[1] := $00E7FBFF;
    end;
  with FButtonFrame[tbCheckBoxUncheckedHot] do
    begin
      TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00A57552;
      TLMDSolidFiller(Fillers[sfpInnerSpace]).Color := $00FFEBDE;
      Fillers[sfpInnerBorder].FixedColors[0] := $007BD7FF;
      Fillers[sfpInnerBorder].FixedColors[1] := $00CEF3FF;
    end;

  with FButtonFill[tbCheckBoxUncheckedPressed] do
    begin
      Fillers[gfpMain].ColorCount := 2;
      Fillers[gfpMain].FixedColors[0] := $0067D0FF;
      Fillers[gfpMain].FixedColors[1] := $00D5F4FF;
    end;
  with FButtonFrame[tbCheckBoxUncheckedPressed] do
    begin
      case FColorScheme of
        csBlue:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00A37755;
        csMetallic:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00A09D9B;
        csBlack:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00848484;
      end;

      TLMDSolidFiller(Fillers[sfpInnerSpace]).Color := $00F5D8C1;
      Fillers[sfpInnerBorder].FixedColors[0] := $002689F2;
      Fillers[sfpInnerBorder].FixedColors[1] := $00AFD5FA;
    end;

  with FButtonFill[tbCheckBoxUncheckedDisabled] do
    begin
      Fillers[gfpMain].ColorCount := 2;
      Fillers[gfpMain].FixedColors[0] := $00F7F3EF;
      Fillers[gfpMain].FixedColors[1] := $00FFFBFF;
    end;
  with FButtonFrame[tbCheckBoxUncheckedDisabled] do
    begin
      TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00B5B2AD;
      TLMDSolidFiller(Fillers[sfpInnerSpace]).Color := $00FFFFFF;
      Fillers[sfpInnerBorder].FixedColors[0] := $00E7E3E7;
      Fillers[sfpInnerBorder].FixedColors[1] := $00F7F3F7;
    end;

   CloneDescriptor(FButtonFill[tbCheckBoxCheckedPressed], FButtonFill[tbCheckBoxUnCheckedPressed]);
   CloneDescriptor(FButtonFrame[tbCheckBoxCheckedPressed], FButtonFrame[tbCheckBoxUnCheckedPressed]);

   CloneDescriptor(FButtonFill[tbCheckBoxCheckedHot], FButtonFill[tbCheckBoxUnCheckedHot]);
   CloneDescriptor(FButtonFrame[tbCheckBoxCheckedHot], FButtonFrame[tbCheckBoxUnCheckedHot]);

   CloneDescriptor(FButtonFill[tbCheckBoxCheckedNormal], FButtonFill[tbCheckBoxUnCheckedNormal]);
   CloneDescriptor(FButtonFrame[tbCheckBoxCheckedNormal], FButtonFrame[tbCheckBoxUnCheckedNormal]);

   CloneDescriptor(FButtonFill[tbCheckBoxMixedNormal], FButtonFill[tbCheckBoxUnCheckedNormal]);
   CloneDescriptor(FButtonFrame[tbCheckBoxMixedNormal], FButtonFrame[tbCheckBoxUnCheckedNormal]);

   CloneDescriptor(FButtonFill[tbCheckBoxCheckedDisabled], FButtonFill[tbCheckBoxUncheckedDisabled]);
   CloneDescriptor(FButtonFrame[tbCheckBoxCheckedDisabled], FButtonFrame[tbCheckBoxUncheckedDisabled]);

   CloneDescriptor(FButtonFill[tbCheckBoxMixedPressed], FButtonFill[tbCheckBoxUnCheckedPressed]);
   CloneDescriptor(FButtonFrame[tbCheckBoxMixedPressed], FButtonFrame[tbCheckBoxUnCheckedPressed]);

   CloneDescriptor(FButtonFill[tbCheckBoxMixedDisabled], FButtonFill[tbCheckBoxUncheckedDisabled]);
   CloneDescriptor(FButtonFrame[tbCheckBoxMixedDisabled], FButtonFrame[tbCheckBoxUnCheckedDisabled]);

   FCheckMarkFill[false].Fillers[gfpMain] := TLMDSolidFiller.Create;
   TLMDSolidFiller(FCheckMarkFill[false].Fillers[gfpMain]).Color := $00D1BFB0;
   TLMDSolidFiller(FCheckMarkFill[false].Fillers[gfpMain]).FixedAlpha[0] := 0;
   FCheckMarkFill[true].Fillers[gfpMain] := TLMDSolidFiller.Create;

   TLMDSolidFiller(FCheckMarkFill[true].Fillers[gfpMain]).FixedAlpha[0] := 0;
   case FColorScheme of
     csBlue:
       TLMDSolidFiller(FCheckMarkFill[true].Fillers[gfpMain]).Color := $00956A49;
     csMetallic:
       TLMDSolidFiller(FCheckMarkFill[true].Fillers[gfpMain]).Color := $008B8A89;
     csBlack:
       TLMDSolidFiller(FCheckMarkFill[true].Fillers[gfpMain]).Color := $00535353;
   end;

   CloneDescriptor(FMixedMarkFill[false], FCheckMarkFill[false]);
   CloneDescriptor(FMixedMarkFill[true], FCheckMarkFill[true]);
  //-------------end of teButton: CheckBox section ---------------------------//

  //---------------- teButton: RadionButton ----------------------------------//
  for ltb := tbRadioButtonUncheckedNormal to tbRadioButtonCheckedDisabled do
    begin
      with FButtonFrame[ltb] do
        begin
          Fillers[sfpOuterBorder] := TLMDSolidFiller.Create;
          Fillers[sfpInnerSpace] := TLMDSolidFiller.Create;;

          lf := TLMDLineFiller.Create;
          lf.ColorCount := 2;
          lf.BasePoint := Point(0, 0);
          lf.VectorN := Point(100, 100);
          lf.VectorT := Point(100, -100);
          lf.UseRelativeUnits := true;
          Fillers[sfpInnerBorder] := lf;

          Params[gfrpTopSpaceWidth] := 1;
          Params[gfrpRightSpaceWidth] := 1;
          Params[gfrpBottomSpaceWidth] := 1;
          Params[gfrpLeftSpaceWidth] := 1;
        end;
      if not (ltb in [tbRadioButtonCheckedNormal]) then
        with FButtonFill[ltb] do
          begin
            lf := TLMDRoundFiller.Create;
            lf.UseRelativeUnits := true;
            TLMDRoundFiller(lf).BasePoint := Point(20, 20);
            TLMDRoundFiller(lf).Radius := 100;
            Fillers[gfpMain] := lf;
          end;
    end;

  with FButtonFill[tbRadioButtonUncheckedNormal] do
    begin
      Fillers[gfpMain].ColorCount := 2;
      Fillers[gfpMain].FixedColors[0] := $00D5CFCA;
      Fillers[gfpMain].FixedColors[1] := $00F6F6F6;
    end;
  with FButtonFrame[tbRadioButtonUncheckedNormal] do
    begin
      case FColorScheme of
        csBlue:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00DEC1AB;
        csMetallic:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00A09D9B;
        csBlack:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00848484;
      end;
      TLMDSolidFiller(Fillers[sfpInnerSpace]).Color := $00F4F4F4;
      Fillers[sfpInnerBorder].FixedColors[0] := $00B9ACA2;
      Fillers[sfpInnerBorder].FixedColors[1] := $00EAE6E4;
    end;

  with FButtonFrame[tbRadioButtonCheckedNormal] do
    begin
      Fillers[sfpOuterBorder].FixedColors[0] := FButtonFrame[tbRadioButtonUnCheckedNormal].Fillers[sfpOuterBorder].FixedColors[0];
      TLMDSolidFiller(Fillers[sfpInnerSpace]).Color := $00F4F4F4;
      Fillers[sfpInnerBorder].FixedColors[0] := $00B9ACA2;
      Fillers[sfpInnerBorder].FixedColors[1] := $00B9ACA2;
    end;

  with FButtonFill[tbRadioButtonUncheckedHot] do
    begin
      Fillers[gfpMain].ColorCount := 2;
      Fillers[gfpMain].FixedColors[0] := $00ADE7FF;
      Fillers[gfpMain].FixedColors[1] := $00E7FBFF;
    end;
  with FButtonFrame[tbRadioButtonUncheckedHot] do
    begin
      TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00A57552;
      TLMDSolidFiller(Fillers[sfpInnerSpace]).Color := $00FFEBDE;
      Fillers[sfpInnerBorder].FixedColors[0] := $007BD7FF;
      Fillers[sfpInnerBorder].FixedColors[1] := $00CEF3FF;
    end;

  with FButtonFill[tbRadioButtonUncheckedPressed] do
    begin
      Fillers[gfpMain].ColorCount := 2;
      Fillers[gfpMain].FixedColors[0] := $0067D0FF;
      Fillers[gfpMain].FixedColors[1] := $00D5F4FF;
    end;
  with FButtonFrame[tbRadioButtonUncheckedPressed] do
    begin
      TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00A37755;
      TLMDSolidFiller(Fillers[sfpInnerSpace]).Color := $00F5D8C1;
      Fillers[sfpInnerBorder].FixedColors[0] := $002689F2;
      Fillers[sfpInnerBorder].FixedColors[1] := $00AFD5FA;
    end;

  with FButtonFill[tbRadioButtonUncheckedDisabled] do
    begin
      Fillers[gfpMain].ColorCount := 2;
      Fillers[gfpMain].FixedColors[0] := $00F7F3EF;
      Fillers[gfpMain].FixedColors[1] := $00FFFBFF;
    end;
  with FButtonFrame[tbRadioButtonUncheckedDisabled] do
    begin
      TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00B5B2AD;
      TLMDSolidFiller(Fillers[sfpInnerSpace]).Color := $00FFFFFF;
      Fillers[sfpInnerBorder].FixedColors[0] := $00E7E3E7;
      Fillers[sfpInnerBorder].FixedColors[1] := $00F7F3F7;
    end;

   CloneDescriptor(FButtonFill[tbRadioButtonCheckedPressed], FButtonFill[tbRadioButtonUnCheckedPressed]);
   CloneDescriptor(FButtonFrame[tbRadioButtonCheckedPressed], FButtonFrame[tbRadioButtonUnCheckedPressed]);
   CloneDescriptor(FButtonFill[tbRadioButtonCheckedHot], FButtonFill[tbRadioButtonUnCheckedHot]);
   CloneDescriptor(FButtonFrame[tbRadioButtonCheckedHot], FButtonFrame[tbRadioButtonUnCheckedHot]);
   CloneDescriptor(FButtonFill[tbRadioButtonCheckedDisabled], FButtonFill[tbRadioButtonUncheckedDisabled]);
   CloneDescriptor(FButtonFrame[tbRadioButtonCheckedDisabled], FButtonFrame[tbRadioButtonUncheckedDisabled]);

   FRadioBtnCheckMarkFill[false].Fillers[gfpMain] := TLMDRoundFiller.Create;
   FRadioBtnCheckMarkFill[false].Fillers[gfpMain].UseRelativeUnits := true;
   FRadioBtnCheckMarkFill[false].Fillers[gfpMain].BasePoint := Point(30,30);
   TLMDRoundFiller(FRadioBtnCheckMarkFill[false].Fillers[gfpMain]).Radius := 90;
   FRadioBtnCheckMarkFill[false].Fillers[gfpMain].FixedColors[0] := clWhite;
   FRadioBtnCheckMarkFill[false].Fillers[gfpMain].FixedColors[1] := $00B5B2AD;

   FRadioBtnCheckMarkFill[true].Fillers[gfpMain] := TLMDRoundFiller.Create;
   FRadioBtnCheckMarkFill[true].Fillers[gfpMain].UseRelativeUnits := true;
   FRadioBtnCheckMarkFill[true].Fillers[gfpMain].BasePoint := Point(30,30);
   TLMDRoundFiller(FRadioBtnCheckMarkFill[true].Fillers[gfpMain]).Radius := 90;
   FRadioBtnCheckMarkFill[true].Fillers[gfpMain].FixedColors[0] := clWhite;
   FRadioBtnCheckMarkFill[true].Fillers[gfpMain].FixedColors[1] := clGreen;
  //-------------end of teButton: RadionButton section -----------------------//

  //----------------------- teButton: GroupBox -------------------------------//
  with FButtonFrame[tbGroupBoxNormal] do
    begin
      Fillers[sfpOuterBorder] := TLMDSolidFiller.Create;
      case FCOlorScheme of
        csBlue:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00DEC1D0;
        csMetallic:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00BEBEBE;
        csBlack:
          TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $008B8A89;
      end;
      Fillers[sfpInnerBorder] := TLMDVerticalGradient.Create;
      Fillers[sfpInnerBorder].UseRelativeUnits := true;
      Fillers[sfpInnerBorder].ColorCount := 2;
      Fillers[sfpInnerBorder].FixedColors[0] := $00F7F0EA;
      Fillers[sfpInnerBorder].FixedColors[1] := $00EFD8C0;
    end;
  CloneDescriptor(FButtonFrame[tbGroupBoxDisabled], FButtonFrame[tbGroupBoxNormal]);
  with FButtonFrame[tbGroupBoxDisabled] do
    begin
      TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00E7E3E7;
      Fillers[sfpInnerBorder].FixedColors[0] := $00F7F3EF;
      Fillers[sfpInnerBorder].FixedColors[1] := $00FFFBFF;
    end;
  //----------------------- End of teButton: GroupBox Section ----------------//

  //------------------------ teCombobox --------------------------------------//
  CloneDescriptor(FComboBoxFrame[tcComboBoxRoot], FEditFrame[teEditRoot]);
  CloneDescriptor(FComboBoxFill[tcComboBoxRoot], FEditFill[teEditRoot]);

  CloneDescriptor(FComboBoxFrame[tcComboBoxDontCare], FEditFrame[teEditDontCare]);
  CloneDescriptor(FComboBoxFill[tcComboBoxDontCare], FEditFill[teEditDontCare]);

  FComboBoxFrame[tcComboBoxRoot].Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(cRectCorners);
  FComboBoxFrame[tcComboBoxRoot].Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(cRectCorners);
  FComboBoxFrame[tcComboBoxDontCare].Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(cRectCorners);
  FComboBoxFrame[tcComboBoxDontCare].Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(cRectCorners);

  for ltb := tbPushButtonNormal to tbPushButtonDisabled do
    begin
      ltcb := TThemedComboBox(ord(tcDropDownButtonNormal) + ord(ltb) - ord(tbPushButtonNormal));
      CloneDescriptor(FComboBoxFrame[ltcb], FButtonFrame[ltb]);
      if ltb <> tbPushButtonNormal then
        CloneDescriptor(FComboBoxFill[ltcb], FButtonFill[ltb]);
      FComboBoxFrame[ltcb].Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(cRectCorners);
      FComboBoxFrame[ltcb].Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(cRectCorners);
      FComboBoxFrame[ltcb].Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(cRectCorners);
      FComboBoxFrame[ltcb].Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(cRectCorners);
    end;

  FComboBoxFrame[tcDropDownButtonNormal].Fillers[sfpOuterBorder].FixedColors[0] := FComboBoxFrame[tcComboBoxDontCare].Fillers[sfpOuterBorder].FixedColors[0];
  FComboBoxFrame[tcDropDownButtonNormal].Fillers[sfpInnerBorder].FixedColors[0] := clWhite;
  FComboBoxFrame[tcDropDownButtonNormal].Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsTop, fsRight, fsBottom]);
  FComboBoxFrame[tcDropDownButtonNormal].Params[gfrpInnerBorderSides] := LMDFrameSidesToByte([fsTop, fsRight, fsBottom]);

  FComboBoxFrame[tcDropDownButtonDisabled].Fillers[sfpOuterBorder].FixedColors[0] := $00E7E3E7;
  FComboBoxFrame[tcDropDownButtonDisabled].Fillers[sfpInnerBorder].FixedColors[0] := clWhite;
  //FComboBoxFrame[tcDropDownButtonDisabled].Params[gfrpOuterBorderWidth] := 0;

  FComboBoxFrame[tcDropDownButtonHot].Fillers[sfpOuterBorder].FixedColors[0] := FComboBoxFrame[tcComboBoxDontCare].Fillers[sfpOuterBorder].FixedColors[0];
  FComboBoxFill[tcComboBoxRoot].Fillers[gfpMain].FixedColors[0] := clWhite;
  //----------------------- End of teComboBox Section ------------------------//

  //------------------------ teProgress --------------------------------------//
  with FProgressFill[tpBar] do
    begin
      lf := TLMDVerticalGradient.Create;
      lf.UseRelativeUnits := true;
      TLMDVerticalGradient(lf).Height := 100;
      lf.ColorCount := 2;
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00D5CBC6;
            lf.FixedColors[1] := $00EDE4E0;
          end;
        csMetallic:
          begin
            lf.FixedColors[0] := $00D5CBC6;
            lf.FixedColors[1] := $00EDE4E0;
          end;
        csBlack:
          begin
            lf.FixedColors[0] := $008B8987;
            lf.FixedColors[1] := $00979897;
          end;
      end;
      Fillers[gfpMain] := lf;
    end;
  with FProgressFrame[tpBar] do
    begin
      Params[gfrpOuterBorderWidth] := 1;
      Params[gfrpInnerBorderWidth] := 1;
      Params[gfrpOuterBorderOuterCutX] := 1;
      Params[gfrpOuterBorderOuterCutY] := 1;

      Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(cRoundCutCorners);
      Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(cRoundCutCorners);
      Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(cRoundCutCorners);
      Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(cRoundCutCorners);

      Fillers[sfpOuterBorder] := TLMDSolidFiller.Create;
      Fillers[sfpInnerBorder] := TLMDSolidFiller.Create;

      case FColorScheme of
        csBlue:
          begin
            TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00FFFBF8;
            TLMDSolidFiller(Fillers[sfpInnerBorder]).Color := $00CC976E;
          end;
        csMetallic:
          begin
            TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00FFFBF8;
            TLMDSolidFiller(Fillers[sfpInnerBorder]).Color := $00868686;
          end;
        csBlack:
          begin
            TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00E6E6E6;
            TLMDSolidFiller(Fillers[sfpInnerBorder]).Color := $00626262;
          end;
      end;
    end;

  with FProgressFill[tpBarVert] do
    begin
      lf := TLMDHorizontalGradient.Create;
      lf.UseRelativeUnits := true;
      TLMDHorizontalGradient(lf).Height := 100;
      lf.CopyColorsAndAlphaFrom(FProgressFill[tpBar].Fillers[gfpMain]);
      Fillers[gfpMain] := lf;
    end;
  with FProgressFrame[tpBarVert] do
    begin
      Params[gfrpOuterBorderWidth] := 1;
      Params[gfrpInnerBorderWidth] := 1;
      Params[gfrpOuterBorderOuterCutX] := 1;
      Params[gfrpOuterBorderOuterCutY] := 1;
      Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(cRoundCutCorners);
      Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(cRoundCutCorners);
      Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(cRoundCutCorners);
      Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(cRoundCutCorners);

      Fillers[sfpOuterBorder] := TLMDSolidFiller.Create;
      Fillers[sfpOuterBorder].CopyColorsAndAlphaFrom(FProgressFrame[tpBar].Fillers[sfpOuterBorder]);
      Fillers[sfpInnerBorder] := TLMDSolidFiller.Create;
      Fillers[sfpInnerBorder].CopyColorsAndAlphaFrom(FProgressFrame[tpBar].Fillers[sfpInnerBorder]);
    end;

  with FProgressFill[tpChunk] do
    begin
      Fillers[gfpMain] := TLMDMixedFiller.Create;
      mf := TLMDMixedFiller(Fillers[gfpMain]);
      mf.Add(TLMDCompositeFiller.Create);
      mf.Add(TLMDHorizontalGradient.Create);
      mf.Weight[0] := 255;
      mf.Weight[1] := 255;
      Fillers[gfpMain].UseRelativeUnits := true;
      mf.Item[0].UseRelativeUnits := true;
      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      lf.FixedColors[0] := $0081C7AC;
      lf.FixedColors[1] := $004AAE87;
      TLMDCompositeFiller(mf.Item[0]).Add(lf);

      lf := TLMDSolidFiller.Create;
      lf.FixedColors[0] := $00228E63;
      lf.FixedAlpha[0] := 0;
      TLMDCompositeFiller(mf.Item[0]).Add(lf);

      TLMDCompositeFiller(mf.Item[0]).FillerRect[0] := Rect(0,0,100,50);
      TLMDCompositeFiller(mf.Item[0]).FillerRect[1] := Rect(0,50,100,100);

      TLMDHorizontalGradient(mf.Item[1]).FixedColors[0] := clGreen;
      TLMDHorizontalGradient(mf.Item[1]).FixedColors[1] := $00AAFFFF;
      TLMDHorizontalGradient(mf.Item[1]).Height := 100;
    end;
  with FProgressFrame[tpChunk] do
    begin
      Params[gfrpOuterBorderWidth] := 0;
      Params[gfrpInnerBorderWidth] := 0;
      Params[gfrpTopSpaceWidth] := 1;
      Params[gfrpRightSpaceWidth] := 1;
      Params[gfrpLeftSpaceWidth] := 1;
      Params[gfrpBottomSpaceWidth] := 1;

      lf := TLMDHorizontalGradient.Create;
      lf.ColorCount := 2;
      lf.UseRelativeUnits := true;
      Fillers[sfpInnerSpace] := lf;
      lf.FixedColors[0] := $00C4E4D7;
      lf.FixedColors[1] := clWhite;
    end;

  with FProgressFill[tpChunkVert] do
    begin
      Fillers[gfpMain] := TLMDMixedFiller.Create;
      mf := TLMDMixedFiller(Fillers[gfpMain]);
      mf.Add(TLMDCompositeFiller.Create);
      mf.Add(TLMDVerticalGradient.Create);
      mf.Weight[0] := 255;
      mf.Weight[1] := 255;
      Fillers[gfpMain].UseRelativeUnits := true;
      mf.Item[0].UseRelativeUnits := true;
      lf := TLMDHorizontalGradient.Create;
      lf.ColorCount := 2;
      lf.FixedColors[0] := $0081C7AC;
      lf.FixedColors[1] := $004AAE87;
      TLMDCompositeFiller(mf.Item[0]).Add(lf);

      lf := TLMDSolidFiller.Create;
      lf.FixedColors[0] := $00228E63;
      lf.FixedAlpha[0] := 0;
      TLMDCompositeFiller(mf.Item[0]).Add(lf);

      TLMDCompositeFiller(mf.Item[0]).FillerRect[0] := Rect(0,0,50,100);
      TLMDCompositeFiller(mf.Item[0]).FillerRect[1] := Rect(50,0,100,100);

      TLMDVerticalGradient(mf.Item[1]).FixedColors[0] := clGreen;
      TLMDVerticalGradient(mf.Item[1]).FixedColors[1] := $00AAFFFF;
      TLMDVerticalGradient(mf.Item[1]).Height := 100;
    end;
  with FProgressFrame[tpChunkVert] do
    begin
      Params[gfrpOuterBorderWidth] := 0;
      Params[gfrpInnerBorderWidth] := 0;
      Params[gfrpTopSpaceWidth] := 1;
      Params[gfrpRightSpaceWidth] := 1;
      Params[gfrpLeftSpaceWidth] := 1;
      Params[gfrpBottomSpaceWidth] := 1;

      lf := TLMDHorizontalGradient.Create;
      lf.ColorCount := 2;
      lf.UseRelativeUnits := true;
      Fillers[sfpInnerSpace] := lf;
      lf.FixedColors[0] := $00C4E4D7;
      lf.FixedColors[1] := clWhite;
    end;
  //----------------------- End of teProgress Section ------------------------//

  //------------------------ teTrackBar --------------------------------------//
  with FTrackBarFill[ttbThumbBottomNormal] do
    begin
      Params[gflpRenderMode] := 0;
      lf := TLMDRectangleFiller.Create;
      lf.UseRelativeUnits := true;
      TLMDRectangleFiller(lf).BasePoint := Point(50,50);
      TLMDRectangleFiller(lf).VectorN := Point(70,0);
      TLMDRectangleFiller(lf).VectorT := Point(0,70);
      lf.ColorCount := 2;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00ECC1A0;
        csMetallic, csBlack:
          lf.FixedColors[0] := $00BEBAB8;
      end;
      case FColorScheme of
        csBlue:
          lf.FixedColors[1] := $00E6FDF0;
        csMetallic, csBlack:
          lf.FixedColors[1] := $00FBFAFA;
      end;

      Fillers[gfpMain] := lf;
      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00A2836C; //darker line
        csMetallic, csBlack:
          lf.FixedColors[0] := $004B4B4B;
      end;

      Fillers[gfpDeco1] := lf;

      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00F6E8E3; //lighter line
        csMetallic, csBlack:
          lf.FixedColors[0] := $00F2F2F2;
      end;

      Fillers[gfpDeco2] := lf;
    end;
  with FTrackBarFrame[ttbThumbBottomNormal] do
    begin
      Params[gfrpRenderMode] := 0;
      Params[gfrpOuterBorderWidth] := 1;
      Params[gfrpInnerBorderWidth] := 1;
      Params[gfrpCutValueUsage] := ord(cvuMin);

      Params[gfrpOuterBorderOuterCutXValueType] := ord(vtPercent);
      Params[gfrpOuterBorderInnerCutXValueType] := ord(vtPercent);
      Params[gfrpInnerBorderOuterCutXValueType] := ord(vtPercent);
      Params[gfrpInnerBorderInnerCutXValueType] := ord(vtPercent);
      Params[gfrpOuterBorderOuterCutX] := 40;
      Params[gfrpOuterBorderInnerCutX] := 50;
      Params[gfrpInnerBorderOuterCutX] := 50;
      Params[gfrpInnerBorderInnerCutX] := 60;
      Params[gfrpOuterBorderOuterCutYValueType] := ord(vtPercent);
      Params[gfrpOuterBorderInnerCutYValueType] := ord(vtPercent);
      Params[gfrpInnerBorderOuterCutYValueType] := ord(vtPercent);
      Params[gfrpInnerBorderInnerCutYValueType] := ord(vtPercent);
      Params[gfrpOuterBorderOuterCutY] := 40;
      Params[gfrpOuterBorderInnerCutY] := 50;
      Params[gfrpInnerBorderOuterCutY] := 50;
      Params[gfrpInnerBorderInnerCutY] := 60;

      Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctLine, ctLine));
      Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctLine, ctLine));
      Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctLine, ctLine));
      Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctLine, ctLine));

      Fillers[sfpOuterBorder] := TLMDVerticalGradient.Create;
      Fillers[sfpOuterBorder].ColorCount := 2;
      Fillers[sfpOuterBorder].FixedColors[0] := $00F8E2D1;
      Fillers[sfpOuterBorder].FixedColors[1] := $00FBF2EA;
      Fillers[sfpInnerBorder] := TLMDSolidFiller.Create;

      case FColorScheme of
        csBlue:
          Fillers[sfpInnerBorder].FixedColors[0] := $00A26E46;
        csMetallic:
          Fillers[sfpInnerBorder].FixedColors[0] := $004B4B4B;
        csBlack:
          Fillers[sfpInnerBorder].FixedColors[0] := $004B4B4B;
      end;

    end;
    CloneDescriptor(FTrackBarFrame[ttbThumbBottomHot], FTrackBarFrame[ttbThumbBottomNormal]);
    FTrackBarFrame[ttbThumbBottomHot].Fillers[sfpOuterBorder].FixedColors[0] := $008BDCF9;
    FTrackBarFrame[ttbThumbBottomHot].Fillers[sfpOuterBorder].FixedColors[1] := $00E8FAFE;

    CloneDescriptor(FTrackBarFill[ttbThumbBottomHot], FTrackBarFill[ttbThumbBottomNormal]);
    FTrackBarFill[ttbThumbBottomHot].Fillers[gfpMain].FixedColors[0] := $0035C2F4;
    FTrackBarFill[ttbThumbBottomHot].Fillers[gfpMain].FixedColors[1] := $00BCEBFC;

    CloneDescriptor(FTrackBarFrame[ttbThumbTopNormal], FTrackBarFrame[ttbThumbBottomNormal]);
    CloneDescriptor(FTrackBarFill[ttbThumbTopNormal], FTrackBarFill[ttbThumbBottomNormal]);
    CloneDescriptor(FTrackBarFrame[ttbThumbTopHot], FTrackBarFrame[ttbThumbBottomHot]);
    CloneDescriptor(FTrackBarFill[ttbThumbTopHot], FTrackBarFill[ttbThumbBottomHot]);
    with FTrackBarFrame[ttbThumbTopNormal] do
      begin
        Fillers[sfpOuterBorder].FixedColors[0] := $00FBF2EA;
        Fillers[sfpOuterBorder].FixedColors[1] := $00F8E2D1;

        Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctLine, ctNone, ctNone));
        Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctLine, ctNone, ctNone));
        Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctLine, ctNone, ctNone));
        Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctLine, ctNone, ctNone));
      end;
    with FTrackBarFrame[ttbThumbTopHot] do
      begin
        Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctLine, ctNone, ctNone));
        Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctLine, ctNone, ctNone));
        Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctLine, ctNone, ctNone));
        Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctLine, ctNone, ctNone));
      end;

    CloneDescriptor(FTrackBarFrame[ttbThumbLeftNormal], FTrackBarFrame[ttbThumbBottomNormal]);
    CloneDescriptor(FTrackBarFill[ttbThumbLeftNormal], FTrackBarFill[ttbThumbBottomNormal]);
    CloneDescriptor(FTrackBarFrame[ttbThumbLeftHot], FTrackBarFrame[ttbThumbBottomHot]);
    CloneDescriptor(FTrackBarFill[ttbThumbLeftHot], FTrackBarFill[ttbThumbBottomHot]);
    with FTrackBarFrame[ttbThumbLeftNormal] do
      begin
        Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctNone, ctNone, ctLine));
        Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctNone, ctNone, ctLine));
        Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctNone, ctNone, ctLine));
        Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctNone, ctNone, ctLine));
      end;
    with FTrackBarFrame[ttbThumbLeftHot] do
      begin
        Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctNone, ctNone, ctLine));
        Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctNone, ctNone, ctLine));
        Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctNone, ctNone, ctLine));
        Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctLine, ctNone, ctNone, ctLine));
      end;

    CloneDescriptor(FTrackBarFrame[ttbThumbRightNormal], FTrackBarFrame[ttbThumbBottomNormal]);
    CloneDescriptor(FTrackBarFill[ttbThumbRightNormal], FTrackBarFill[ttbThumbBottomNormal]);
    CloneDescriptor(FTrackBarFrame[ttbThumbRightHot], FTrackBarFrame[ttbThumbBottomHot]);
    CloneDescriptor(FTrackBarFill[ttbThumbRightHot], FTrackBarFill[ttbThumbBottomHot]);
    with FTrackBarFrame[ttbThumbRightNormal] do
      begin
        Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctLine, ctLine, ctNone));
        Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctLine, ctLine, ctNone));
        Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctLine, ctLine, ctNone));
        Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctLine, ctLine, ctNone));
      end;
    with FTrackBarFrame[ttbThumbRightHot] do
      begin
        Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctLine, ctLine, ctNone));
        Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctLine, ctLine, ctNone));
        Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctLine, ctLine, ctNone));
        Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctLine, ctLine, ctNone));
      end;

  CloneDescriptor(FTrackBarFrame[ttbTrack], FButtonFrame[tbPushButtonNormal]);
  CloneDescriptor(FTrackBarFrame[ttbTrackVert], FButtonFrame[tbPushButtonNormal]);
  with FTrackBarFrame[ttbTrack] do
    begin
      Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
      Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
      Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
      Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
    end;
  with FTrackBarFrame[ttbTrackVert] do
    begin
      Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
      Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
      Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
      Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
    end;
  //----------------------- End of teTrackBar Section ------------------------//

  //------------------------ teHeader ----------------------------------------//
  with FHeaderFill[thHeaderItemNormal] do
    begin
      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00FDFCF9;
            lf.FixedColors[1] := $00E9DBD3;
          end;
        csMetallic:
          begin
            lf.FixedColors[0] := $00F3F3F1;
            lf.FixedColors[1] := $00CAC9C8;
          end;
        csBlack:
          begin
            lf.FixedColors[0] := $00F8F8F8;
            lf.FixedColors[1] := $00DEDEDE;
          end;
      end;
      Fillers[gfpMain] := lf;
    end;
  with FHeaderFrame[thHeaderItemNormal] do
    begin
      Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
      Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
      Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
      Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctNone, ctNone, ctNone, ctNone));
      Params[gfrpOuterBorderWidth] := 1;
      Params[gfrpInnerBorderWidth] := 0;
      Params[gfrpTopSpaceWidth] := 0;
      Params[gfrpRightSpaceWidth] := 0;
      Params[gfrpLeftSpaceWidth] := 0;
      Params[gfrpBottomSpaceWidth] := 0;

      lf := TLMDSolidFiller.Create;
      lf.FixedColors[0] := $00CEB69E;
      Fillers[sfpOuterBorder] := lf;
      Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsRight, fsBottom]);
    end;
  CloneDescriptor(FHeaderFill[thHeaderItemHot], FHeaderFill[thHeaderItemNormal]);
  CloneDescriptor(FHeaderFrame[thHeaderItemHot], FHeaderFrame[thHeaderItemNormal]);

  with FHeaderFill[thHeaderItemHot] do
    case FColorScheme of
      csBlue:
        begin
          Fillers[gfpMain].FixedColors[0] := $00FDFCF9;
          Fillers[gfpMain].FixedColors[1] := $00D2C5BC;
          FHeaderFrame[thHeaderItemHot].Fillers[sfpOuterBorder].FixedColors[0] := $00B79F87;
        end;
      csMetallic:
        begin
          Fillers[gfpMain].FixedColors[0] := $00D0D0D0;
          Fillers[gfpMain].FixedColors[1] := $00A6A6A6;
          FHeaderFrame[thHeaderItemHot].Fillers[sfpOuterBorder].FixedColors[0] := $00A9A3D9;
        end;
      csBlack:
        begin
          Fillers[gfpMain].FixedColors[0] := $00E0E0E0;
          Fillers[gfpMain].FixedColors[1] := $00C5C5C5;
          FHeaderFrame[thHeaderItemHot].Fillers[sfpOuterBorder].FixedColors[0] := $00B6B6B6;
        end;
    end;

  CloneDescriptor(FHeaderFill[thHeaderItemPressed], FHeaderFill[thHeaderItemNormal]);
  CloneDescriptor(FHeaderFrame[thHeaderItemPressed], FHeaderFrame[thHeaderItemNormal]);

  with FHeaderFill[thHeaderItemPressed] do
    case FColorScheme of
      csBlue:
        begin
          Fillers[gfpMain].FixedColors[0] := $00E4E2DF;
          Fillers[gfpMain].FixedColors[1] := $00D2C6BD;
          FHeaderFrame[thHeaderItemPressed].Fillers[sfpOuterBorder].FixedColors[0] := $00FFFFFF;
        end;
      csMetallic:
        begin
          Fillers[gfpMain].FixedColors[0] := $00D0D0D0;
          Fillers[gfpMain].FixedColors[1] := $00A6A6A6;
          FHeaderFrame[thHeaderItemPressed].Fillers[sfpOuterBorder].FixedColors[0] := $00FFFFFF;
        end;
      csBlack:
        begin
          Fillers[gfpMain].FixedColors[0] := $00E0E0E0;
          Fillers[gfpMain].FixedColors[1] := $00C4C4C4;
          FHeaderFrame[thHeaderItemPressed].Fillers[sfpOuterBorder].FixedColors[0] := $00FFFFFF;
        end;
    end;
  //------------------------ End of teHeader Section -------------------------//

  //------------------------ teTreeView --------------------------------------//
  CloneDescriptor(FTreeViewFrame[ttTreeviewDontCare], FEditFrame[teEditTextNormal]);
  FTreeViewFrame[ttTreeviewDontCare].Params[gfrpInnerBorderWidth] := 0;
  FTreeViewFrame[ttTreeviewDontCare].Params[gfrpOuterBorderOuterCutType] := 0;
  FTreeViewFrame[ttTreeviewDontCare].Params[gfrpInnerBorderOuterCutType] := 0;
  //------------------------ End of teTreeView Section -----------------------//

  //------------------------ teStatusBar -------------------------------------//
  FStatusBarFill[tsGripper].Fillers[gfpMain] := TLMDSolidFiller.Create;
  FStatusBarFill[tsGripper].Fillers[gfpMain].FixedColors[0] := $00805D45;
  FStatusBarFill[tsGripper].Fillers[gfpDeco1] := TLMDSolidFiller.Create;
  FStatusBarFill[tsGripper].Fillers[gfpDeco1].FixedColors[0] := $00E8C9B1;

  CloneDescriptor(FStatusBarFill[tsPane], FButtonFill[tbPushButtonNormal]);
  with FStatusBarFill[tsPane] do
    begin
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0, 0, 100, 30);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(0, 30, 100, 100);
      lf := TLMDVerticalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[0]);
      //                   dark         light
      lf.FixedColors[0] := $00F8DCC5; //$00F9E6D7;
      lf.FixedColors[1] := $00F7CAA9; //$00F8DCC7;
      lf := TLMDVerticalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[1]);
      lf.FixedColors[0] := $00EAB690; //$00F5D0B3;
      lf.FixedColors[1] := $00C29574; //$00F7E5D7;
    end;
  CloneDescriptor(FStatusBarFrame[tsPane], FButtonFrame[tbPushButtonNormal]);
  FStatusBarFrame[tsPane].Params[gfrpOuterBorderOuterCutType] := 0;
  FStatusBarFrame[tsPane].Params[gfrpOuterBorderInnerCutType] := 0;
  FStatusBarFrame[tsPane].Params[gfrpInnerBorderOuterCutType] := 0;
  FStatusBarFrame[tsPane].Params[gfrpInnerBorderInnerCutType] := 0;
  FStatusBarFrame[tsPane].Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsTop, fsLeft]);
  FStatusBarFrame[tsPane].Params[gfrpInnerBorderWidth] := 1;
  FStatusBarFrame[tsPane].Params[gfrpInnerBorderSides] := LMDFrameSidesToByte([fsLeft]);
  FStatusBarFrame[tsPane].Fillers[sfpOuterBorder].FixedColors[0] := $00B07D56;
  FStatusBarFrame[tsPane].Fillers[sfpInnerBorder].FixedColors[0] := $00F3DCCA;
  //------------------------ End of teStatusBar Section ----------------------//


  //------------------------ teScrollBar -------------------------------------//
  CloneDescriptor(FScrollBarFill[tsThumbBtnHorzNormal], FButtonFill[tbPushButtonNormal]);

  for lsb := tsThumbBtnHorzNormal to tsUpperTrackVertDisabled do
    with FScrollBarFrame[lsb] do
      begin
        Params[gfrpInnerSpaceInnerCutType] := 0;
        Params[gfrpInnerSpaceOuterCutType] := 0;
        Params[gfrpInnerBorderOuterCutType] := 0;
        Params[gfrpInnerBorderInnerCutType] := 0;
        Params[gfrpOuterBorderOuterCutX] := 1;
        Params[gfrpOuterBorderInnerCutX] := 1;
        Params[gfrpTopSpaceWidth] := 1;
        Params[gfrpRightSpaceWidth] := 1;
        Params[gfrpBottomSpaceWidth] := 1;
        Params[gfrpLeftSpaceWidth] := 1;
        if FColorScheme in [csMetallic, csBlack] then
          Params[gfrpInnerBorderWidth] := 0;
      end;

  //------------------ teScrollBar: tsThumbBtnHorz* --------------------------//
  with FScrollBarFill[tsThumbBtnHorzNormal] do
    begin
      lf := TLMDVerticalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[0]);
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00F3EFEE;
            lf.FixedColors[1] := $00EDE3DD;
          end;
        csMetallic, csBlack:
          begin
            lf.FixedColors[0] := $00FBFAFA;
            lf.FixedColors[1] := $00F1F0F0;
          end;
      end;
      lf := TLMDVerticalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[1]);
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00E0D2C6;
            lf.FixedColors[1] := $00CEBAAA;
          end;
        csMetallic, csBlack:
          begin
            lf.FixedColors[0] := $00E4E2E2;
            lf.FixedColors[1] := $00CCC9C8;
          end;
      end;
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0,0,100,45);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(0,45,100,100);
    end;
  with FScrollBarFrame[tsThumbBtnHorzNormal] do
    begin
      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $008F6855;
        csMetallic:
          lf.FixedColors[0] := $0074716E;
        csBlack:
          lf.FixedColors[0] := $002C2C2C;
      end;
      Fillers[sfpOuterBorder] := lf;
      lf := TLMDVerticalGradient.Create;
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00F8F4F3;
            lf.FixedColors[1] := $00CABCB0;
          end;
        csMetallic, csBlack:
          begin
            lf.FixedColors[0] := $00FBFAFA;
            lf.FixedColors[1] := $00F1F0F0;
          end;
      end;
      Fillers[sfpInnerSpace] := lf;
      lf := TLMDVerticalGradient.Create;
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00F2EFEC;
            lf.FixedColors[1] := $00C3AE9C;
          end;
        {csMetallic, csBlack:
          begin
            lf.FixedColors[0] := $00FBFAFA;
            lf.FixedColors[1] := $00F1F0F0;
          end;}
      end;
      Fillers[sfpInnerBorder] := lf;
    end;
  CloneDescriptor(FScrollBarFrame[tsThumbBtnHorzHot], FScrollBarFrame[tsThumbBtnHorzNormal]);
  CloneDescriptor(FScrollBarFill[tsThumbBtnHorzHot], FScrollBarFill[tsThumbBtnHorzNormal]);
  with FScrollBarFrame[tsThumbBtnHorzHot] do
    begin
      lf := TLMDSolidFiller(Fillers[sfpOuterBorder]);
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00B06E3C;
        csMetallic:
          lf.FixedColors[0] := $0074716E;
        csBlack:
          lf.FixedColors[0] := $002C2C2C;
      end;
      lf := TLMDVerticalGradient(Fillers[sfpInnerSpace]);
      lf.FixedColors[0] := $00EBE9E9;
      lf.FixedColors[1] := $00FFFDFC;
      lf := TLMDVerticalGradient(Fillers[sfpInnerBorder]);
      lf.FixedColors[0] := $00EAD1BF;
      lf.FixedColors[1] := $00FAE4D3;
    end;
  with FScrollBarFill[tsThumbBtnHorzHot] do
    begin
      lf := TLMDVerticalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[0]);
      lf.FixedColors[0] := $00EFD6C2;
      lf.FixedColors[1] := $00FADFCA;
      lf := TLMDVerticalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[1]);
      lf.FixedColors[0] := $00F6CBAA;
      lf.FixedColors[1] := $00F9DDC7;
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0,0,100,40);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(0,40,100,100);
    end;
  CloneDescriptor(FScrollBarFrame[tsThumbBtnHorzPressed], FScrollBarFrame[tsThumbBtnHorzHot]);
  CloneDescriptor(FScrollBarFill[tsThumbBtnHorzPressed], FScrollBarFill[tsThumbBtnHorzHot]);
  with FScrollBarFrame[tsThumbBtnHorzPressed] do
    begin
      lf := TLMDSolidFiller(Fillers[sfpOuterBorder]);
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $008A4917;
        csMetallic:
          lf.FixedColors[0] := $0074716E;
        csBlack:
          lf.FixedColors[0] := $002C2C2C;
      end;
      lf := TLMDVerticalGradient(Fillers[sfpInnerSpace]);
      lf.FixedColors[0] := $00E7D3C2;
      lf.FixedColors[1] := $00FBEBDD;
      lf := TLMDVerticalGradient(Fillers[sfpInnerBorder]);
      lf.FixedColors[0] := $00E5BB9C;
      lf.FixedColors[1] := $00F7D1B4;
    end;
  with FScrollBarFill[tsThumbBtnHorzPressed] do
    begin
      lf := TLMDVerticalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[0]);
      lf.FixedColors[0] := $00EBC09F;
      lf.FixedColors[1] := $00F6C7A4;
      lf := TLMDVerticalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[1]);
      lf.FixedColors[0] := $00F0A66E;
      lf.FixedColors[1] := $00F5C5A0;
    end;
  //------------------ teScrollBar: end of tsThumbHorz* ----------------------//

  //------------------ teScrollBar: tsThumbVert* -----------------------------//
  with FScrollBarFill[tsThumbBtnVertNormal] do
    begin
      Fillers[gfpMain] := TLMDCompositeFiller.Create;
      Fillers[gfpMain].UseRelativeUnits := true;
      lf := TLMDHorizontalGradient.Create;
      lf.CopyColorsAndAlphaFrom(TLMDCompositeFiller(FScrollBarFill[tsThumbBtnHorzNormal].Fillers[gfpMain]).Item[0]);
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);
      lf := TLMDHorizontalGradient.Create;
      lf.CopyColorsAndAlphaFrom(TLMDCompositeFiller(FScrollBarFill[tsThumbBtnHorzNormal].Fillers[gfpMain]).Item[1]);
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0,0,45,100);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(45,0,100,100);
    end;
  with FScrollBarFrame[tsThumbBtnVertNormal] do
    begin
      lf := TLMDSolidFiller.Create;
      lf.FixedColors[0] := FScrollBarFrame[tsThumbBtnHorzNormal].Fillers[sfpOuterBorder].FixedColors[0];
      Fillers[sfpOuterBorder] := lf;
      lf := TLMDHorizontalGradient.Create;
      lf.CopyColorsAndAlphaFrom(FScrollBarFrame[tsThumbBtnHorzNormal].Fillers[sfpInnerSpace]);
      Fillers[sfpInnerSpace] := lf;
      lf := TLMDHorizontalGradient.Create;
      lf.CopyColorsAndAlphaFrom(FScrollBarFrame[tsThumbBtnHorzNormal].Fillers[sfpInnerBorder]);
      Fillers[sfpInnerBorder] := lf;
    end;

  CloneDescriptor(FScrollBarFrame[tsThumbBtnVertHot], FScrollBarFrame[tsThumbBtnVertNormal]);
  CloneDescriptor(FScrollBarFill[tsThumbBtnVertHot], FScrollBarFill[tsThumbBtnVertNormal]);
  with FScrollBarFrame[tsThumbBtnVertHot] do
    begin
      lf := TLMDSolidFiller(Fillers[sfpOuterBorder]);
      lf.FixedColors[0] := FScrollBarFrame[tsThumbBtnHorzHot].Fillers[sfpOuterBorder].FixedColors[0];
      lf := TLMDHorizontalGradient(Fillers[sfpInnerSpace]);
      lf.CopyColorsAndAlphaFrom(FScrollBarFrame[tsThumbBtnHorzHot].Fillers[sfpInnerSpace]);
      lf := TLMDHorizontalGradient(Fillers[sfpInnerBorder]);
      lf.CopyColorsAndAlphaFrom(FScrollBarFrame[tsThumbBtnHorzHot].Fillers[sfpInnerBorder]);
    end;
  with FScrollBarFill[tsThumbBtnVertHot] do
    begin
      lf := TLMDHorizontalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[0]);
      lf.CopyColorsAndAlphaFrom(TLMDCompositeFiller(FScrollBarFill[tsThumbBtnHorzHot].Fillers[gfpMain]).Item[0]);
      lf := TLMDHorizontalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[1]);
      lf.CopyColorsAndAlphaFrom(TLMDCompositeFiller(FScrollBarFill[tsThumbBtnHorzHot].Fillers[gfpMain]).Item[1]);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0,0,40,100);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(40,0,100,100);
    end;

  CloneDescriptor(FScrollBarFrame[tsThumbBtnVertPressed], FScrollBarFrame[tsThumbBtnVertHot]);
  CloneDescriptor(FScrollBarFill[tsThumbBtnVertPressed], FScrollBarFill[tsThumbBtnVertHot]);
  with FScrollBarFrame[tsThumbBtnVertPressed] do
    begin
      lf := TLMDSolidFiller(Fillers[sfpOuterBorder]);
      lf.FixedColors[0] := FScrollBarFrame[tsThumbBtnHorzPressed].Fillers[sfpOuterBorder].FixedColors[0];
      lf := TLMDHorizontalGradient(Fillers[sfpInnerSpace]);
      lf.CopyColorsAndAlphaFrom(FScrollBarFrame[tsThumbBtnHorzPressed].Fillers[sfpInnerSpace]);
      lf := TLMDHorizontalGradient(Fillers[sfpInnerBorder]);
      lf.CopyColorsAndAlphaFrom(FScrollBarFrame[tsThumbBtnHorzPressed].Fillers[sfpInnerBorder]);
    end;
  with FScrollBarFill[tsThumbBtnVertPressed] do
    begin
      lf := TLMDHorizontalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[0]);
      lf.CopyColorsAndAlphaFrom(TLMDCompositeFiller(FScrollBarFill[tsThumbBtnHorzPressed].Fillers[gfpMain]).Item[0]);
      lf := TLMDHorizontalGradient(TLMDCompositeFiller(Fillers[gfpMain]).Item[1]);
      lf.CopyColorsAndAlphaFrom(TLMDCompositeFiller(FScrollBarFill[tsThumbBtnHorzPressed].Fillers[gfpMain]).Item[1]);
    end;
  //------------------ teScrollBar: end of tsThumbVert* ----------------------//

  //------------------ teScrollBar: ts*Track* --------------------------------//
  with FScrollBarFill[tsLowerTrackHorzNormal] do
    begin
      Fillers[gfpMain] := TLMDCompositeFiller.Create;
      Fillers[gfpMain].UseRelativeUnits := true;

      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00BA9273;
            lf.FixedColors[1] := $00C29878;
          end;
        csMetallic:
          begin
            lf.FixedColors[0] := $008F8B88;
            lf.FixedColors[1] := $009A9592;
          end;
        csBlack:
          begin
            lf.FixedColors[0] := $003D3D3D;
            lf.FixedColors[1] := $003F3F3F;
          end;
      end;
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);

      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00C29878;
        csMetallic:
          lf.FixedColors[0] := $009E9A97;
        csBlack:
          lf.FixedColors[0] := $00404040;
      end;
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);

      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00C29878;
            lf.FixedColors[1] := $00C8A284;
          end;
        csMetallic:
          begin
            lf.FixedColors[0] := $00A9A5A2;
            lf.FixedColors[1] := $00C9C6C5;
          end;
        csBlack:
          begin
            lf.FixedColors[0] := $00474747;
            lf.FixedColors[1] := $00878787;
          end;
      end;
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0,0,100,20);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(0,20,100,80);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[2] := Rect(0,80,100,100);
    end;
  with FScrollBarFrame[tsLowerTrackHorzNormal] do
    begin
      Params[gfrpOuterBorderOuterCutType] := 0;
      Params[gfrpOuterBorderInnerCutType] := 0;
      Params[gfrpInnerBorderWidth] := 0;
      Params[gfrpTopSpaceWidth] := 0;
      Params[gfrpRightSpaceWidth] := 0;
      Params[gfrpBottomSpaceWidth] := 0;
      Params[gfrpLeftSpaceWidth] := 0;
      Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsTop, fsBottom]);

      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $008F6856;
        csMetallic:
          lf.FixedColors[0] := $0074716E;
        csBlack:
          lf.FixedColors[0] := $002C2C2C;
      end;

      Fillers[sfpOuterBorder] := lf;
    end;

  CloneDescriptor(FScrollBarFill[tsArrowBtnLeftNormal], FScrollBarFill[tsLowerTrackHorzNormal]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnLeftNormal], FScrollBarFrame[tsLowerTrackHorzNormal]);
  FScrollBarFrame[tsArrowBtnLeftNormal].Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsLeft, fsTop, fsBottom]);

  CloneDescriptor(FScrollBarFill[tsArrowBtnRightNormal], FScrollBarFill[tsLowerTrackHorzNormal]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnRightNormal], FScrollBarFrame[tsLowerTrackHorzNormal]);
  FScrollBarFrame[tsArrowBtnRightNormal].Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsTop, fsBottom, fsRight]);

  with FScrollBarFill[tsLowerTrackVertNormal] do
    begin
      Fillers[gfpMain] := TLMDCompositeFiller.Create;
      Fillers[gfpMain].UseRelativeUnits := true;

      lf := TLMDHorizontalGradient.Create;
      lf.CopyColorsAndAlphaFrom(TLMDCompositeFiller(FScrollBarFill[tsLowerTrackHorzNormal].Fillers[gfpMain]).Item[0]);
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);

      lf := TLMDSolidFiller.Create;
      lf.CopyColorsAndAlphaFrom(TLMDCompositeFiller(FScrollBarFill[tsLowerTrackHorzNormal].Fillers[gfpMain]).Item[1]);
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);

      lf := TLMDHorizontalGradient.Create;
      lf.CopyColorsAndAlphaFrom(TLMDCompositeFiller(FScrollBarFill[tsLowerTrackHorzNormal].Fillers[gfpMain]).Item[2]);
      TLMDCompositeFiller(Fillers[gfpMain]).Add(lf);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[0] := Rect(0,0,20,100);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[1] := Rect(20,0,80,100);
      TLMDCompositeFiller(Fillers[gfpMain]).FillerRect[2] := Rect(80,0,100,100);
    end;
  CloneDescriptor(FScrollBarFrame[tsLowerTrackVertNormal], FScrollBarFrame[tsLowerTrackHorzNormal]);
  FScrollBarFrame[tsLowerTrackVertNormal].Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsLeft, fsRight]);

  CloneDescriptor(FScrollBarFill[tsUpperTrackHorzNormal], FScrollBarFill[tsLowerTrackHorzNormal]);
  CloneDescriptor(FScrollBarFrame[tsUpperTrackHorzNormal], FScrollBarFrame[tsLowerTrackHorzNormal]);
  CloneDescriptor(FScrollBarFill[tsUpperTrackVertNormal], FScrollBarFill[tsLowerTrackVertNormal]);
  CloneDescriptor(FScrollBarFrame[tsUpperTrackVertNormal], FScrollBarFrame[tsLowerTrackVertNormal]);

  CloneDescriptor(FScrollBarFill[tsLowerTrackHorzHot], FScrollBarFill[tsLowerTrackHorzNormal]);
  CloneDescriptor(FScrollBarFrame[tsLowerTrackHorzHot], FScrollBarFrame[tsLowerTrackHorzNormal]);
  CloneDescriptor(FScrollBarFill[tsUpperTrackHorzHot], FScrollBarFill[tsUpperTrackHorzNormal]);
  CloneDescriptor(FScrollBarFrame[tsUpperTrackHorzHot], FScrollBarFrame[tsUpperTrackHorzNormal]);

  CloneDescriptor(FScrollBarFill[tsLowerTrackVertHot], FScrollBarFill[tsLowerTrackVertNormal]);
  CloneDescriptor(FScrollBarFrame[tsLowerTrackVertHot], FScrollBarFrame[tsLowerTrackVertNormal]);
  CloneDescriptor(FScrollBarFill[tsUpperTrackVertHot], FScrollBarFill[tsUpperTrackVertNormal]);
  CloneDescriptor(FScrollBarFrame[tsUpperTrackVertHot], FScrollBarFrame[tsUpperTrackVertNormal]);

  CloneDescriptor(FScrollBarFill[tsLowerTrackVertPressed], FScrollBarFill[tsLowerTrackVertNormal]);
  CloneDescriptor(FScrollBarFrame[tsLowerTrackVertPressed], FScrollBarFrame[tsLowerTrackVertNormal]);
  CloneDescriptor(FScrollBarFill[tsUpperTrackVertPressed], FScrollBarFill[tsUpperTrackVertNormal]);
  CloneDescriptor(FScrollBarFrame[tsUpperTrackVertPressed], FScrollBarFrame[tsUpperTrackVertNormal]);

  CloneDescriptor(FScrollBarFill[tsLowerTrackHorzPressed], FScrollBarFill[tsLowerTrackHorzNormal]);
  CloneDescriptor(FScrollBarFrame[tsLowerTrackHorzPressed], FScrollBarFrame[tsLowerTrackHorzNormal]);
  CloneDescriptor(FScrollBarFill[tsUpperTrackHorzPressed], FScrollBarFill[tsUpperTrackHorzNormal]);
  CloneDescriptor(FScrollBarFrame[tsUpperTrackHorzPressed], FScrollBarFrame[tsUpperTrackHorzNormal]);

  FScrollBarFill[tsUpperTrackHorzHot].Fillers[gfpMain].ChangeColorBrightness(25);
  FScrollBarFill[tsLowerTrackHorzHot].Fillers[gfpMain].ChangeColorBrightness(25);
  FScrollBarFill[tsUpperTrackVertHot].Fillers[gfpMain].ChangeColorBrightness(25);
  FScrollBarFill[tsLowerTrackVertHot].Fillers[gfpMain].ChangeColorBrightness(25);

  FScrollBarFill[tsUpperTrackHorzPressed].Fillers[gfpMain].ChangeColorBrightness(15);
  FScrollBarFill[tsLowerTrackHorzPressed].Fillers[gfpMain].ChangeColorBrightness(15);
  FScrollBarFill[tsUpperTrackVertPressed].Fillers[gfpMain].ChangeColorBrightness(15);
  FScrollBarFill[tsLowerTrackVertPressed].Fillers[gfpMain].ChangeColorBrightness(15);

  CloneDescriptor(FScrollBarFill[tsArrowBtnUpNormal], FScrollBarFill[tsLowerTrackVertNormal]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnUpNormal], FScrollBarFrame[tsLowerTrackVertNormal]);
  FScrollBarFrame[tsArrowBtnUpNormal].Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsLeft, fsTop, fsRight]);
  CloneDescriptor(FScrollBarFill[tsArrowBtnDownNormal], FScrollBarFill[tsLowerTrackVertNormal]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnDownNormal], FScrollBarFrame[tsLowerTrackVertNormal]);
  FScrollBarFrame[tsArrowBtnDownNormal].Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsLeft, fsBottom, fsRight]);

  with FScrollBarFill[tsArrowBtnLeftHot] do
    begin
      Fillers[gfpMain] := TLMDMixedFiller.Create;
      mf := TLMDMixedFiller(Fillers[gfpMain]);
      mf.Add(TLMDCompositeFiller.Create);
      mf.Add(TLMDLineFiller.Create);
      mf.Weight[0] := 255;
      mf.Weight[1] := 255;
      Fillers[gfpMain].UseRelativeUnits := true;
      mf.Item[0].UseRelativeUnits := true;
      //upper btnfill part
      lf := TLMDSolidFiller.Create;
      lf.FixedColors[0] := $00FAE4D3;
      TLMDCompositeFiller(mf.Item[0]).Add(lf);
      //lower btnfill part
      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      lf.FixedColors[0] := $00DAB497;
      lf.FixedColors[1] := $00FAE1CD;
      TLMDCompositeFiller(mf.Item[0]).Add(lf);

      TLMDCompositeFiller(mf.Item[0]).FillerRect[0] := Rect(0,0,100,45);
      TLMDCompositeFiller(mf.Item[0]).FillerRect[1] := Rect(0,45,100,100);

      TLMDLineFiller(mf.Item[1]).FixedColors[0] := $00FF7F2A;
      TLMDLineFiller(mf.Item[1]).FixedColors[1] := clWhite;
      TLMDLineFiller(mf.Item[1]).BasePoint := Point(0, 100);
      TLMDLineFiller(mf.Item[1]).VectorN := Point(100, -100);
      TLMDLineFiller(mf.Item[1]).VectorT := Point(-100, 100);
    end;
  with FScrollBarFrame[tsArrowBtnLeftHot] do
    begin
      Params[gfrpOuterBorderWidth] := 1;
      Params[gfrpInnerBorderWidth] := 1;
      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $008F6856;
        csMetallic:
          lf.FixedColors[0] := $0074716E;
        csBlack:
          lf.FixedColors[0] := $002C2C2C;
      end;
      Fillers[sfpOuterBorder] := lf;
      lf := TLMDHorizontalGradient.Create;
      lf.ColorCount := 2;
      lf.UseRelativeUnits := true;
      Fillers[sfpInnerBorder] := lf;
      lf.FixedColors[0] := $00EBE9E9;
      lf.FixedColors[1] := $00FFFDFC;
      Params[gfrpOuterBorderOuterCutX] := 1;
      Params[gfrpOuterBorderInnerCutX] := 1;
      Params[gfrpInnerBorderOuterCutX] := 1;
      Params[gfrpInnerBorderOuterCutType] := 0;
      Params[gfrpInnerBorderInnerCutType] := 0;
    end;
  CloneDescriptor(FScrollBarFill[tsArrowBtnRightHot], FScrollBarFill[tsArrowBtnLeftHot]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnRightHot], FScrollBarFrame[tsArrowBtnLeftHot]);

  CloneDescriptor(FScrollBarFill[tsArrowBtnLeftPressed], FScrollBarFill[tsArrowBtnLeftHot]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnLeftPressed], FScrollBarFrame[tsArrowBtnLeftHot]);
  with FScrollBarFill[tsArrowBtnLeftPressed] do
    begin
      mf := TLMDMixedFiller(Fillers[gfpMain]);
      lf := TLMDCompositeFiller(mf.Item[0]);
      TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00FBE8D9;
      TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00EEC2A0;
      TLMDLineFiller(mf.Item[1]).FixedColors[0] := $00D35C00;
    end;
  with FScrollBarFrame[tsArrowBtnLeftPressed] do
    begin
      Fillers[sfpInnerBorder].FixedColors[0] := $00D9B89D;
      Fillers[sfpInnerBorder].FixedColors[1] := $00EEC2A0;
    end;
  CloneDescriptor(FScrollBarFill[tsArrowBtnRightPressed], FScrollBarFill[tsArrowBtnLeftPressed]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnRightPressed], FScrollBarFrame[tsArrowBtnLeftPressed]);

  with FScrollBarFill[tsArrowBtnUpHot] do
    begin
      Fillers[gfpMain] := TLMDMixedFiller.Create;
      mf := TLMDMixedFiller(Fillers[gfpMain]);
      mf.Add(TLMDCompositeFiller.Create);
      mf.Add(TLMDLineFiller.Create);
      mf.Weight[0] := 255;
      mf.Weight[1] := 255;
      Fillers[gfpMain].UseRelativeUnits := true;
      mf.Item[0].UseRelativeUnits := true;
      //upper btnfill part
      lf := TLMDSolidFiller.Create;
      lf.FixedColors[0] := $00FAE4D3;
      TLMDCompositeFiller(mf.Item[0]).Add(lf);
      //lower btnfill part
      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      lf.FixedColors[0] := $00DAB497;
      lf.FixedColors[1] := $00FAE1CD;
      TLMDCompositeFiller(mf.Item[0]).Add(lf);

      TLMDCompositeFiller(mf.Item[0]).FillerRect[0] := Rect(0, 0, 45, 100);
      TLMDCompositeFiller(mf.Item[0]).FillerRect[1] := Rect(45,0, 100,100);

      TLMDLineFiller(mf.Item[1]).FixedColors[0] := $00FF7F2A;
      TLMDLineFiller(mf.Item[1]).FixedColors[1] := clWhite;
      TLMDLineFiller(mf.Item[1]).BasePoint := Point(100, 100);
      TLMDLineFiller(mf.Item[1]).VectorN := Point(-100, -100);
      TLMDLineFiller(mf.Item[1]).VectorT := Point(-100, 100);
    end;
  with FScrollBarFrame[tsArrowBtnUpHot] do
    begin
      Params[gfrpOuterBorderWidth] := 1;
      Params[gfrpInnerBorderWidth] := 1;

      lf := TLMDSolidFiller.Create;
      lf.CopyColorsAndAlphaFrom(FScrollBarFrame[tsArrowBtnLeftHot].Fillers[sfpOuterBorder]);
      Fillers[sfpOuterBorder] := lf;

      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      lf.UseRelativeUnits := true;
      Fillers[sfpInnerBorder] := lf;
      lf.CopyColorsAndAlphaFrom(FScrollBarFrame[tsArrowBtnLeftHot].Fillers[sfpInnerBorder]);
      Params[gfrpOuterBorderOuterCutX] := 1;
      Params[gfrpOuterBorderInnerCutX] := 1;
      Params[gfrpInnerBorderOuterCutX] := 1;
      Params[gfrpInnerBorderOuterCutType] := 0;
      Params[gfrpInnerBorderInnerCutType] := 0;
    end;
  CloneDescriptor(FScrollBarFill[tsArrowBtnDownHot], FScrollBarFill[tsArrowBtnUpHot]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnDownHot], FScrollBarFrame[tsArrowBtnUpHot]);

  CloneDescriptor(FScrollBarFill[tsArrowBtnUpPressed], FScrollBarFill[tsArrowBtnUpHot]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnUpPressed], FScrollBarFrame[tsArrowBtnUpHot]);
  with FScrollBarFill[tsArrowBtnUpPressed] do
    begin
      mf := TLMDMixedFiller(Fillers[gfpMain]);
      lf := TLMDCompositeFiller(mf.Item[0]);
      TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00FBE8D9;
      TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00EEC2A0;
      TLMDLineFiller(mf.Item[1]).FixedColors[0] := $00D35C00;
    end;
  with FScrollBarFrame[tsArrowBtnUpPressed] do
    begin
      Fillers[sfpInnerBorder].FixedColors[0] := $00D9B89D;
      Fillers[sfpInnerBorder].FixedColors[1] := $00EEC2A0;
    end;
  CloneDescriptor(FScrollBarFill[tsArrowBtnDownPressed], FScrollBarFill[tsArrowBtnUpPressed]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnDownPressed], FScrollBarFrame[tsArrowBtnUpPressed]);

  CloneDescriptor(FScrollBarFill[tsArrowBtnLeftDisabled], FScrollBarFill[tsArrowBtnLeftNormal]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnLeftDisabled], FScrollBarFrame[tsArrowBtnLeftNormal]);
  CloneDescriptor(FScrollBarFill[tsArrowBtnRightDisabled], FScrollBarFill[tsArrowBtnRightNormal]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnRightDisabled], FScrollBarFrame[tsArrowBtnRightNormal]);

  CloneDescriptor(FScrollBarFill[tsArrowBtnUpDisabled], FScrollBarFill[tsArrowBtnUpNormal]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnUpDisabled], FScrollBarFrame[tsArrowBtnUpNormal]);
  CloneDescriptor(FScrollBarFill[tsArrowBtnDownDisabled], FScrollBarFill[tsArrowBtnDownNormal]);
  CloneDescriptor(FScrollBarFrame[tsArrowBtnDownDisabled], FScrollBarFrame[tsArrowBtnDownNormal]);
  //------------------------ End of teScrollBar Section ----------------------//

  //------------------------------ teSpin ------------------------------------//
  CloneDescriptor(FSpinBtnFill[tsUpNormal], FButtonFill[tbPushButtonNormal]);
  CloneDescriptor(FSpinBtnFill[tsUpHot], FButtonFill[tbPushButtonHot]);
  CloneDescriptor(FSpinBtnFill[tsUpPressed], FButtonFill[tbPushButtonPressed]);
  CloneDescriptor(FSpinBtnFill[tsUpDisabled], FButtonFill[tbPushButtonDisabled]);

  CloneDescriptor(FSpinBtnFill[tsDownNormal], FButtonFill[tbPushButtonNormal]);
  CloneDescriptor(FSpinBtnFill[tsDownHot], FButtonFill[tbPushButtonHot]);
  CloneDescriptor(FSpinBtnFill[tsDownPressed], FButtonFill[tbPushButtonPressed]);
  CloneDescriptor(FSpinBtnFill[tsDownDisabled], FButtonFill[tbPushButtonDisabled]);

  for lts := low(TThemedSpin) to high(TThemedSpin) do
    begin
      FSpinBtnFrame[lts].Params[gfrpOuterBorderOuterCutType] := 0;
      FSpinBtnFrame[lts].Params[gfrpOuterBorderInnerCutType] := 0;
      FSpinBtnFrame[lts].Params[gfrpInnerBorderInnerCutType] := 0;
      FSpinBtnFrame[lts].Params[gfrpInnerBorderInnerCutType] := 0;
    end;
  //--------------------------------------------------------------------------//

  //------------------------------ teTab -------------------------------------//
  case FColorScheme of
    csBlue:
      FTabText[ttTopTabItemSelected].Color := $008B4215;
    csMetallic:
      FTabText[ttTopTabItemSelected].Color := $005C534C;
    csBlack:
      FTabText[ttTopTabItemSelected].Color := clBlack;
  end;

  case FColorScheme of
    csBlue:
      FTabText[ttTopTabItemNormal].Color := $008B4215;
    csMetallic:
      FTabText[ttTopTabItemNormal].Color := $005C534C;
    csBlack:
      FTabText[ttTopTabItemNormal].Color := clWhite;
  end;

  case FColorScheme of
    csBlue:
      FTabText[ttTopTabItemHot].Color := $008B4215;
    csMetallic:
      FTabText[ttTopTabItemHot].Color := $005C534C;
    csBlack:
      FTabText[ttTopTabItemHot].Color := clWhite;
  end;

  case FColorScheme of
    csBlue:
      FTabText[ttTopTabItemDisabled].Color := $008D8D8D;
    csMetallic:
      FTabText[ttTopTabItemDisabled].Color := $008D8D8D;
    csBlack:
      FTabText[ttTopTabItemDisabled].Color := $008D8D8D;
  end;

  with FTabFill[ttTopTabItemSelected] do
    begin
      lf := TLMDVerticalGradient.Create;
      lf.UseRelativeUnits := true;
      TLMDVerticalGradient(lf).Height := 100;
      lf.ColorCount := 2;
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00FEF5ED;
            lf.FixedColors[1] := $00F5E8DE;
          end;
        csMetallic:
          begin
            lf.FixedColors[0] := $00FAF7F2;
            lf.FixedColors[1] := $00F1E9E5;
          end;
        csBlack:
          begin
            lf.FixedColors[0] := $00F1F0EF;
            lf.FixedColors[1] := $00DAD3CF;
          end;
      end;
      Fillers[gfpMain] := lf;
    end;
  with FTabFrame[ttTopTabItemSelected] do
    begin
      Params[gfrpTopSpaceWidth] := 1;
      Params[gfrpLeftSpaceWidth] := 1;
      Params[gfrpRightSpaceWidth] := 1;
      Params[gfrpBottomSpaceWidth] := 0;

      Params[gfrpOuterBorderOuterCutX] := 3;
      Params[gfrpOuterBorderInnerCutX] := 3;

      Params[gfrpInnerSpaceOuterCutX] := 4;
      Params[gfrpInnerSpaceInnerCutX] := 4;

      Params[gfrpInnerBorderOuterCutX] := 1;
      Params[gfrpInnerBorderInnerCutX] := 1;

      Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctLine, ctLine));
      Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));
      Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));
      Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));
      Params[gfrpInnerSpaceOuterCutType] :=  LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));
      Params[gfrpInnerSpaceInnerCutType] :=  LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));

      Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsLeft, fsTop, fsRight]);
      Params[gfrpInnerBorderSides] := LMDFrameSidesToByte([fsLeft, fsTop, fsRight]);

      Fillers[sfpOuterBorder] := TLMDSolidFiller.Create;
      Fillers[sfpInnerBorder] := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          begin
            TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00E3B28D;
            TLMDSolidFiller(Fillers[sfpInnerBorder]).Color := $00FFFAF7;
          end;
        csMetallic:
          begin
            TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $00BEBEBE;
            TLMDSolidFiller(Fillers[sfpInnerBorder]).Color := $00F7F3F0;
          end;
        csBlack:
          begin
            TLMDSolidFiller(Fillers[sfpOuterBorder]).Color := $008B8A89;
            TLMDSolidFiller(Fillers[sfpInnerBorder]).Color := $00F2F2F1;
          end;
      end;
      lf := TLMDVerticalGradient.Create;
      lf.UseRelativeUnits := true;
      TLMDVerticalGradient(lf).Height := 100;
      lf.ColorCount := 2;
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00FFF9F4;
            lf.FixedColors[1] := $00FFFBCD;
          end;
        csMetallic:
          begin
            lf.FixedColors[0] := $00FCFAEC;
            lf.FixedColors[1] := $00FFFABF;
          end;
        csBlack:
          begin
            lf.FixedColors[0] := $00FFF9F4;
            lf.FixedColors[1] := $00FFFBCD;
          end;
      end;
      Fillers[sfpInnerSpace] := lf;
    end;
  with FTabFill[ttTopTabItemHot] do
    begin
      Fillers[gfpMain] := TLMDMixedFiller.Create;
      mf := TLMDMixedFiller(Fillers[gfpMain]);
      mf.Add(TLMDCompositeFiller.Create);
      mf.Add(TLMDEllipseFiller.Create);

      Fillers[gfpMain].UseRelativeUnits := true;
      mf.Item[0].UseRelativeUnits := true;

      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      case FColorScheme of
         csBlue:
           begin
             lf.FixedColors[0] := $00FEDDC4;
             lf.FixedColors[1] := clWhite;
           end;
         csMetallic:
           begin
             lf.FixedColors[0] := $00DFD7D3;
             lf.FixedColors[1] := $00ECE8E5;
           end;
         csBlack:
           begin
             lf.FixedColors[0] := $00959696;
             lf.FixedColors[1] := $00677277;
           end;
      end;
      TLMDCompositeFiller(mf.Item[0]).Add(lf);

      lf := TLMDVerticalGradient.Create;
      lf.ColorCount := 2;
      case FColorScheme of
         csBlue:
           begin
             lf.FixedColors[0] := $00FEDDC4;
             lf.FixedColors[1] := clWhite;
           end;
         csMetallic:
           begin
             lf.FixedColors[0] := $00DFD7D3;
             lf.FixedColors[1] := clWhite;
           end;
         csBlack:
           begin
             lf.FixedColors[0] := $005E6E74;
             lf.FixedColors[1] := $00959696;
           end;
      end;
      TLMDCompositeFiller(mf.Item[0]).Add(lf);

      TLMDCompositeFiller(mf.Item[0]).FillerRect[0] := Rect(0,0,100,45);
      TLMDCompositeFiller(mf.Item[0]).FillerRect[1] := Rect(0,45,100,100);

      lf := TLMDEllipseFiller(mf.Item[1]);
      lf.UseRelativeUnits := true;
      TLMDEllipseFiller(lf).BasePoint := Point(50, 0);
      TLMDEllipseFiller(lf).Axis1 :=80;
      TLMDEllipseFiller(lf).Axis2 := 100;
      TLMDEllipseFiller(lf).FirstAxisDirection := Point(1, 0);

      mf.Weight[0] := 255;
      mf.Weight[1] := 255;

      lf.ColorCount := 2;
      case FColorScheme of
         csBlue:
           begin
             lf.FixedColors[0] := $00FEDDC4;
             lf.FixedColors[1] := $0098D1E3;
           end;
         csMetallic:
           begin
             lf.FixedColors[0] := $00DFD7D3;
             lf.FixedColors[1] := $009ED7F8;
           end;
         csBlack:
           begin
             TLMDEllipseFiller(lf).BasePoint := Point(50, 100);
             TLMDEllipseFiller(lf).Axis1 := 80;
             TLMDEllipseFiller(lf).Axis2 := 60;
             lf.FixedColors[0] := $0017CFFF;
             lf.FixedColors[1] := $005E6E74;
             mf.Weight[0] := 200;
           end;
      end;
    end;
  with FTabFrame[ttTopTabItemHot] do
    begin
      Params[gfrpTopSpaceWidth] := 0;
      Params[gfrpLeftSpaceWidth] := 0;
      Params[gfrpRightSpaceWidth] := 0;
      Params[gfrpBottomSpaceWidth] := 0;
      Params[gfrpOuterBorderOuterCutX] := 3;
      Params[gfrpOuterBorderInnerCutX] := 3;
      Params[gfrpInnerSpaceOuterCutX] := 4;
      Params[gfrpInnerSpaceInnerCutX] := 4;
      Params[gfrpInnerBorderOuterCutX] := 2;
      Params[gfrpInnerBorderInnerCutX] := 2;

      Params[gfrpOuterBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));
      Params[gfrpOuterBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));
      Params[gfrpInnerBorderOuterCutType] := LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));
      Params[gfrpInnerBorderInnerCutType] := LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));
      Params[gfrpInnerSpaceOuterCutType] :=  LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));
      Params[gfrpInnerSpaceInnerCutType] :=  LMDCornerCutToByte(LMDCornerCut(ctRound, ctRound, ctNone, ctNone));

      Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsLeft, fsTop, fsRight]);
      Params[gfrpInnerBorderSides] := LMDFrameSidesToByte([fsLeft, fsTop, fsRight]);

      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00EBBE9C;
        csMetallic:
          lf.FixedColors[0] := $00C1BEBD;
        csBlack:
          lf.FixedColors[0] := $00535353;
      end;
      Fillers[sfpOuterBorder] := lf;

      lf := TLMDVerticalGradient.Create;
      lf.UseRelativeUnits := true;
      TLMDVerticalGradient(lf).Height := 100;
      lf.ColorCount := 2;
      case FColorScheme of
        csBlue:
          begin
            lf.FixedColors[0] := $00FDEDE0;
            lf.FixedColors[1] := $00FFF6EF;
          end;
        csMetallic:
          begin
            lf.FixedColors[0] := $00FDEDE0;
            lf.FixedColors[1] := $00FFF6EF;
          end;
        csBlack:
          begin
            lf.FixedColors[0] := $00DAD3CF;
            lf.FixedColors[1] := $00898989;
          end;
      end;
      Fillers[sfpInnerBorder] := lf;
    end;

  with FTabFill[ttTabRoot] do
    begin
      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00FFDBBF;
        csMetallic:
          lf.FixedColors[0] := $00DDD4D0;
        csBlack:
          lf.FixedColors[0] := $00535353;
      end;
      Fillers[gfpMain] := lf;
    end;
  CloneDescriptor(FTabFill[ttTabDontCare], FTabFill[ttTabRoot]);
  CloneDescriptor(FTabFill[ttBody], FTabFill[ttTabRoot]);

  with FTabFill[ttPane] do
    begin
      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00F6E8DE;
        csMetallic:
          lf.FixedColors[0] := $00F1E9E5;
        csBlack:
          lf.FixedColors[0] := $00DAD3CF;
      end;
      Fillers[gfpMain] := lf;
    end;

  with FTabFrame[ttPane] do
    begin
      Params[gfrpOuterBorderOuterCutType] := 0;
      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00E3B28D;
        csMetallic:
          lf.FixedColors[0] := $00BEBEBE;
        csBlack:
          lf.FixedColors[0] := $008B8A89;
      end;
      Fillers[sfpOuterBorder] := lf;
      lf := TLMDSolidFiller.Create;
      case FColorScheme of
        csBlue:
          lf.FixedColors[0] := $00FFFAF7;
        csMetallic:
          lf.FixedColors[0] := $00FAFAFA;
        csBlack:
          lf.FixedColors[0] := $00FEFEFE;
      end;
      Fillers[sfpInnerBorder] := lf;
    end;
  //------------------------ End of teTab Section ----------------------------//

  //------------------------ teToolbar ---------------------------------------//
  FToolBarFill[ttbToolBarDontCare].Fillers[gfpMain] := TLMDSolidFiller.Create;
  case FColorScheme of
    csBlue:
      FToolBarFill[ttbToolBarDontCare].Fillers[gfpMain].FixedColors[0] := $00F6E8DE;
    csMetallic:
      FToolBarFill[ttbToolBarDontCare].Fillers[gfpMain].FixedColors[0] := $00DDD4D0;
    csBlack:
      FToolBarFill[ttbToolBarDontCare].Fillers[gfpMain].FixedColors[0] := $00535353;
    end;

  lf := TLMDCompositeFiller.Create;
  TLMDCompositeFiller(lf).UseRelativeUnits := true;
  TLMDCompositeFiller(lf).Add(TLMDVerticalGradient.Create);
  TLMDCompositeFiller(lf).Add(TLMDVerticalGradient.Create);
  TLMDCompositeFiller(lf).Add(TLMDVerticalGradient.Create);
  TLMDCompositeFiller(lf).Item[0].ColorCount := 2;
  TLMDCompositeFiller(lf).Item[1].ColorCount := 2;
  TLMDCompositeFiller(lf).Item[2].ColorCount := 2;
  case FColorScheme of
    csBlue:
      begin
        TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00F4E6DB;
        TLMDCompositeFiller(lf).Item[0].FixedColors[1] := $00EFDDCF;
        TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00EDD9C9;
        TLMDCompositeFiller(lf).Item[1].FixedColors[1] := $00F5E7D7;
        TLMDCompositeFiller(lf).Item[2].FixedColors[0] := $00F5E7D7;
        TLMDCompositeFiller(lf).Item[2].FixedColors[1] := $00FFF2E7;
      end;
    csMetallic:
      begin
        TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00F9F5F3;
        TLMDCompositeFiller(lf).Item[0].FixedColors[1] := $00EEE6E1;
        TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00E7DBD5;
        TLMDCompositeFiller(lf).Item[1].FixedColors[1] := $00F7F7F0;
        TLMDCompositeFiller(lf).Item[2].FixedColors[0] := $00F7F8F0;
        TLMDCompositeFiller(lf).Item[2].FixedColors[1] := $00F9F9F9;
      end;
    csBlack:
      begin
        TLMDCompositeFiller(lf).Item[0].FixedColors[0] := $00E0DBD7;
        TLMDCompositeFiller(lf).Item[0].FixedColors[1] := $00CFC6C1;
        TLMDCompositeFiller(lf).Item[1].FixedColors[0] := $00C5BBB4;
        TLMDCompositeFiller(lf).Item[1].FixedColors[1] := $00EAEAE3;
        TLMDCompositeFiller(lf).Item[2].FixedColors[0] := $00EFEFE7;
        TLMDCompositeFiller(lf).Item[2].FixedColors[1] := $00EBEBEB;
      end;

  end;

  TLMDCompositeFiller(lf).FillerRect[0] := Rect(0,0,100,20);
  TLMDCompositeFiller(lf).FillerRect[1] := Rect(0,20,100,70);
  TLMDCompositeFiller(lf).FillerRect[2] := Rect(0,70,100,100);
  FToolBarFill[ttbToolBarRoot].Fillers[gfpMain] := lf;
  CloneDescriptor(FToolBarFrame[ttbToolBarRoot], FButtonFrame[tbPushButtonNormal]);
  FToolBarFrame[ttbToolBarRoot].Fillers[sfpOuterBorder].FixedColors[0] := $00E3B28D;

  CloneDescriptor(FToolBarFrame[ttbSeparatorNormal], FButtonFrame[tbPushButtonNormal]);
  CloneDescriptor(FToolBarFrame[ttbSeparatorVertNormal], FButtonFrame[tbPushButtonNormal]);
  for frpm := low(TLMDGradientThemeFrameParam) to  high(TLMDGradientThemeFrameParam) do
    if frpm in [gfrpOuterBorderOuterCutType, gfrpOuterBorderInnerCutType,
                gfrpInnerBorderOuterCutType, gfrpInnerBorderInnerCutType,
                gfrpInnerSpaceOuterCutType,  gfrpInnerSpaceInnerCutType] then
      begin
        FToolBarFrame[ttbSeparatorNormal].Params[frpm] := 0;
        FToolBarFrame[ttbSeparatorVertNormal].Params[frpm] := 0;
      end;

  FToolBarFrame[ttbSeparatorNormal].Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsLeft]);
  FToolBarFrame[ttbSeparatorNormal].Params[gfrpInnerBorderSides] := LMDFrameSidesToByte([fsLeft]);
  FToolBarFrame[ttbSeparatorVertNormal].Params[gfrpOuterBorderSides] := LMDFrameSidesToByte([fsTop]);
  FToolBarFrame[ttbSeparatorVertNormal].Params[gfrpInnerBorderSides] := LMDFrameSidesToByte([fsTop]);

  for ltbr := ttbButtonHot to ttbButtonDisabled do
    begin
      CloneDescriptor(FToolBarFill[ltbr], FButtonFill[TThemedButton(ord(ltbr) - ord(ttbButtonNormal) + ord(tbPushButtonNormal))]);
      CloneDescriptor(FToolBarFrame[ltbr], FButtonFrame[TThemedButton(ord(ltbr) - ord(ttbButtonNormal) + ord(tbPushButtonNormal))]);
    end;

  for ltbr := ttbDropDownButtonNormal to ttbDropDownButtonDisabled do
    begin
      CloneDescriptor(FToolBarFill[ltbr], FButtonFill[TThemedButton(ord(ltbr) - ord(ttbDropDownButtonNormal) + ord(tbPushButtonNormal))]);
      CloneDescriptor(FToolBarFrame[ltbr], FButtonFrame[TThemedButton(ord(ltbr) - ord(ttbDropDownButtonNormal) + ord(tbPushButtonNormal))]);
    end;

  b := LMDCornerCutToByte(LMDCornerCut(ctRound, ctNone, ctNone, ctRound));
  for ltbr := ttbSplitButtonHot to ttbSplitButtonDisabled do
    begin
      CloneDescriptor(FToolBarFill[ltbr], FButtonFill[TThemedButton(ord(ltbr) - ord(ttbSplitButtonNormal) + ord(tbPushButtonNormal))]);
      CloneDescriptor(FToolBarFrame[ltbr], FButtonFrame[TThemedButton(ord(ltbr) - ord(ttbSplitButtonNormal) + ord(tbPushButtonNormal))]);
      for frpm := low(TLMDGradientThemeFrameParam) to  high(TLMDGradientThemeFrameParam) do
        if frpm in [gfrpOuterBorderOuterCutType, gfrpOuterBorderInnerCutType,
                    gfrpInnerBorderOuterCutType, gfrpInnerBorderInnerCutType,
                    gfrpInnerSpaceOuterCutType,  gfrpInnerSpaceInnerCutType] then
          FToolBarFrame[ltbr].Params[frpm] := b;
    end;

  b := LMDCornerCutToByte(LMDCornerCut(ctNone, ctRound, ctRound, ctNone));
  for ltbr := ttbSplitButtonDropDownHot to ttbSplitButtonDropDownDisabled do
    begin
      CloneDescriptor(FToolBarFill[ltbr], FButtonFill[TThemedButton(ord(ltbr) - ord(ttbSplitButtonDropDownNormal) + ord(tbPushButtonNormal))]);
      CloneDescriptor(FToolBarFrame[ltbr], FButtonFrame[TThemedButton(ord(ltbr) - ord(ttbSplitButtonDropDownNormal) + ord(tbPushButtonNormal))]);
      for frpm := low(TLMDGradientThemeFrameParam) to  high(TLMDGradientThemeFrameParam) do
        if frpm in [gfrpOuterBorderOuterCutType, gfrpOuterBorderInnerCutType,
                    gfrpInnerBorderOuterCutType, gfrpInnerBorderInnerCutType,
                    gfrpInnerSpaceOuterCutType,  gfrpInnerSpaceInnerCutType] then
          FToolBarFrame[ltbr].Params[frpm] := b;
    end;
  //------------------------ End of teToolbar Section ------------------------//

  result := true;
  FEnabled := true;
  if ADoApply then
    LMDThemeServices.ApplyThemeChange;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.ActivateColorScheme(AColorScheme: string; ADoApply: boolean = true): boolean;
begin
  FModified := false;
  if FXmlDoc = nil then
    Result := ActivateDefaultTheme(AColorScheme, ADoApply)
  else
    Result := LoadColorSchemeFromXML(FXmlDoc, aColorScheme, aDoApply);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.ActivateTheme(AFileName: string;
  AColorScheme: String): boolean;
begin
  result := false;
  if SameText(AFileName, cGradientThemeNames[gtOffice2007]) then
    begin
      FTheme := gtOffice2007;
      result := ActivateDefaultTheme(AColorScheme);
    end
  else
    if FileExists(AFileName) then
      begin
        FTheme := gtCustom;
        result := LoadThemeFromFile(AFileName, AColorScheme);
      end
    else
      FTheme := gtUnknown;
  if FTheme <> gtCustom then
    FThemeName := cGradientThemeNames[FTheme];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.ContentRect(DC: HDC;
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
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedStatus; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedStatus; const R: TRect; ClipRect: TLMDRectPtr);
var
  lR, LR2: TRect;
  x, y, i, j: integer;
  lBrush1, lBrush2, lOldBrush: HBRUSH;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedStatus), ord(teStatus), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
    lR := R;
    if Detail = tsGripperPane then
      InflateRect(lR, 0, -1);
    if Detail in [tsGripper] then
      LMDAdjustRect(lR, -2, -2);
    if Detail in [tsPane] then
      LMDAdjustRect(lR, -1, -1);
    if Detail = tsGripper then
      begin
        InflateRect(lR, -1, -1);
        OffsetRect(lR, -1, 0);

        if FStatusBarFill[tsGripper].Fillers[gfpMain] <> nil then
          lBrush1 := CreateSolidBrush(FStatusBarFill[tsGripper].Fillers[gfpMain].FixedColors[0])
        else
          lBrush1 := CreateSolidBrush($00805D45);
        if FStatusBarFill[tsGripper].Fillers[gfpDeco1] <> nil then
          lBrush2 := CreateSolidBrush(FStatusBarFill[tsGripper].Fillers[gfpDeco1].FixedColors[0])
        else
          lBrush2 := CreateSolidBrush($00E8C9B1);
        lOldBrush := SelectObject(DC, lBrush1);
        for i := 0 to 2 do
          for j := i to 2 do
            begin
              x := lR.Right - i * 4;
              y := lR.Bottom - 8 + j * 4;
              FillRect(DC, Rect(x + 1, y + 1, x + 3, y + 3), lBrush2);
              FillRect(DC, Rect(x, y, x + 2, y + 2), lBrush1);
            end;
        SelectObject(DC, lOldBrush);
        DeleteObject(lBrush1);
        DeleteObject(lBrush2);
      end
    else
      DrawGradientFramedFigure(DC, nil, LR, LR2, ClipRect, FStatusBarFrame[Detail], FStatusBarFill[Detail], FRFrame, FCCRectangle, FPixelFormat);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedScrollBar; const R: TRect; ClipRect: TLMDRectPtr);
var
  w, l, h: integer;
  lR, lR2: TRect;
  p: TPoint;
  bs: TLMDThemedButtonState;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedScrollBar), ord(teScrollbar), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
    lR := r;
    LMDAdjustRect(lR, -1, -1);
    DrawGradientFramedFigure(DC, nil, LR, LR2, ClipRect, FScrollBarFrame[Detail], FScrollBarFill[Detail], FRFrame, FCCRectangle, FPixelFormat);

    if Detail in [tsArrowBtnLeftNormal, tsArrowBtnRightNormal, tsArrowBtnUpNormal, tsArrowBtnDownNormal,
                  tsArrowBtnLeftDisabled, tsArrowBtnRightDisabled, tsArrowBtnUpDisabled, tsArrowBtnDownDisabled] then
      InflateRect(lR2, -1, -1);

    InflateRect(lR2, -2, -2);
    w := lR2.Right - lR2.Left;
    h := lR2.Bottom - lR2.Top;
    l := min(w, h) div 4;
    p := LMDMiddlePoint(lR2.TopLeft, lR2.BottomRight);
    if Detail in [tsArrowBtnUpNormal..tsArrowBtnDownDisabled] then
      lR2 := Rect(p.X - l * 2, p.Y - l, p.X + l * 2, p.Y + l);
    if Detail in [tsArrowBtnLeftNormal..tsArrowBtnRightDisabled] then
      lR2 := Rect(p.X - l, p.Y - l * 2, p.X + l, p.Y + l * 2);
    bs := btnsNormal;

    if Detail in [tsArrowBtnLeftDisabled, tsArrowBtnRightDisabled, tsArrowBtnUpDisabled, tsArrowBtnDownDisabled] then
      bs := btnsDisabled;

    case Detail of
      tsArrowBtnUpNormal..tsArrowBtnUpDisabled:
        DrawGradientArrow(DC, lR2, tdUp, bs);
      tsArrowBtnDownNormal..tsArrowBtnDownDisabled:
        DrawGradientArrow(DC, lR2, tdDown, bs);
      tsArrowBtnLeftNormal..tsArrowBtnLeftDisabled:
        DrawGradientArrow(DC, lR2, tdLeft, bs);
      tsArrowBtnRightNormal..tsArrowBtnRightDisabled:
        DrawGradientArrow(DC, lR2, tdRight, bs);
    end;

    DrawScrollThumbGripper(DC, lR2, Detail);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC; Detail: TThemedSpin;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC; Detail: TThemedSpin;
  const R: TRect; ClipRect: TLMDRectPtr);
var
  lR, lR2: TRect;
  lts_base: TThemedSpin;
  lExit, lEnabled: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedSpin), ord(teSpin), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
    lR := R;
    InflateRect(LR, 1 , 1);
    LMDAdjustRect(LR, -1, 0);
    if Detail in [tsDownNormal, tsDownHot, tsDownPressed, tsDownDisabled] then
      LMDAdjustRect(LR, 0, -1);
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
    DrawGradientFramedFigure(DC, nil, LR, LR2, ClipRect, FSpinBtnFrame[Detail], FSpinBtnFill[Detail], FRFrame, FCCRectangle, FPixelFormat);
    lEnabled := not (Detail in [tsUpDisabled, tsDownDisabled, tsUpHorzDisabled, tsDownHorzDisabled]);
    case lts_base of
      tsUpNormal: DrawArrow(DC, R, tdUp, false, lEnabled);
      tsDownNormal: DrawArrow(DC, R, tdDown, false, lEnabled);
      tsUpHorzNormal: DrawArrow(DC, R, tdRight, false, lEnabled);
      tsDownHorzNormal: DrawArrow(DC, R, tdLeft, false, lEnabled);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC; Detail: TThemedTab;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedToolTip; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedToolTip; const R: TRect; ClipRect: TLMDRectPtr);
begin
  raise Exception.CreateFmt(IDS_LMDTHEMES_ELEMENTNOTSUPPORTED, ['TThemedToolTip', GetThemeRendererName]);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedToolBar; const R: TRect; ClipRect: TLMDRectPtr);
var
  lR, lR2: TRect;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedToolBar), ord(teToolbar), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
    lR := R;
    LMDAdjustRect(lR, -1, -1);

    if Detail in [ttbSplitButtonNormal..ttbSplitButtonCheckedHot] then
      lR.Right := lR.Right + 1;

    if Detail in  [ttbSeparatorNormal..ttbSeparatorCheckedHot] then
      Detail := ttbSeparatorNormal;

    if Detail in  [ttbSeparatorVertNormal..ttbSeparatorVertCheckedHot] then
      Detail := ttbSeparatorVertNormal;

    DrawGradientFramedFigure(DC, nil, LR, LR2, ClipRect, FToolBarFrame[Detail], FToolBarFill[Detail], FRFrame, FCCRectangle, FPixelFormat);

    if Detail in [ttbDropDownButtonNormal..ttbDropDownButtonPressed, ttbSplitButtonDropDownNormal..ttbSplitButtonDropDownPressed] then
      DrawArrow(DC, lR, tdDown, true, true);
    if Detail in [ttbDropDownButtonDisabled, ttbSplitButtonDropDownDisabled] then
      DrawArrow(DC, lR, tdDown, true, false);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC; Detail: TThemedTab;
  const R: TRect; ClipRect: TLMDRectPtr);
var
  LR, LR2: TRect;
  lBrush: HBRUSH;
  i: integer;

  s: string;
  bmp: TBitmap;
  lDetails: TThemedElementDetails;
  lDC: HDC;
  lExit, lUseCache: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedTab), ord(teTab), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
    if Detail = ttTopTabItemNormal then
    begin
      if FTabFill[ttPane].Fillers[gfpMain] <> nil then
        lBrush := CreateSolidBrush(FTabFill[ttTabRoot].Fillers[gfpMain].FixedColors[0])
      else
        lBrush := CreateSolidBrush($00F6E8DE);
      FillRect(DC, R, lBrush);
      DeleteObject(lBrush);
      exit;
    end;

    lR := R;

    LMDAdjustRect(lR, -1, 0);

    lUseCache := (Detail <> ttPane) and UseCache;

    if lUseCache then
      begin
        lDetails := ThemeServices.GetElementDetails(Detail);
        s := Signature(lDetails, R);
        i := FBmpCache.IndexOf(s);
        if i >= 0 then
        begin
          Bmp := TBitmap(FBmpCache.Objects[i]);
          BitBlt(DC, r.Left, r.Top, Bmp.Width, Bmp.Height, bmp.Canvas.Handle, 0, 0, SRCCOPY);
          exit;
        end
        else
          begin
            Bmp := TBitmap.Create;
            Bmp.PixelFormat := FPixelFormat;
            {$IFDEF LMDCOMP12}
            Bmp.AlphaFormat := afDefined;
            {$ENDIF}
            Bmp.Width := r.Right - r.Left + 1;
            Bmp.Height := r.Bottom - r.Top + 1;
            BitBlt(bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, DC, r.Left, r.Top, SRCCOPY);
            i := FBmpCache.Add(s);
            FBmpCache.Objects[i] := Bmp;
          end;
          OffsetRect(LR, -LR.Left, -LR.Top);
          lDC := bmp.Canvas.Handle;
      end
    else
      begin
        lDC := DC;
        bmp := nil;
      end;

    if Detail = ttPane then
      begin
        DrawSimpleFrame(lDC, nil, lR, lR2, ClipRect, FTabFrame[Detail]);
        if FTabFill[Detail].Fillers[gfpMain] <> nil then
          lBrush := CreateSolidBrush(FTabFill[Detail].Fillers[gfpMain].FixedColors[0])
        else
          lBrush := CreateSolidBrush(clSkyBlue);
        FillRect(lDC, lR2, lBrush);
        DeleteObject(lBrush);
      end
    else
      if Detail in [ttTopTabItemHot..ttTopTabItemFocused] then
        DrawGradientFramedFigure(lDc, Bmp, LR, LR2, ClipRect, FTabFrame[Detail], FTabFill[Detail], FRFrame, FCCRectangle, FPixelFormat);

    if lUseCache then
      BitBlt(DC, r.Left, r.Top, Bmp.Width, Bmp.Height, bmp.Canvas.Handle, 0, 0, SRCCOPY);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedToolBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedComboBox; const R: TRect; ClipRect: TLMDRectPtr);
var
  LR, LR2: TRect;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedComboBox), ord(teComboBox), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
    LR := R;
    LMDAdjustRect(LR, -1, -1);
    if (Detail <= tcComboBoxRoot) then
      begin
        DrawGradientFramedFigure(DC, nil, LR, LR2, ClipRect, FComboBoxFrame[Detail], FComboBoxFill[Detail], FRFrame, FCCRectangle, FPixelFormat);
        exit;
      end;
    if (Detail > tcComboBoxRoot)then
      InflateRect(LR, 1, 1);
    DrawGradientFramedFigure(DC, nil, LR, LR2, ClipRect, FComboBoxFrame[Detail], FComboBoxFill[Detail], FRFrame, FCCRectangle, FPixelFormat);
    DrawArrow(DC, LR, tdDown, Detail <> tcDropDownButtonNormal, Detail <> tcDropDownButtonDisabled);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC; Detail: TThemedEdit;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedComboBox; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedButton; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedButton; const R: TRect; ClipRect: TLMDRectPtr);
var
  LR, LR2: TRect;
  i: integer;

  s: string;
  bmp: TBitmap;
  lDetails: TThemedElementDetails;
  lDC: HDC;
  lExit, lUseCache: boolean;

begin
  //Note: LMDSpeedButton.ButtonStyle must be ubsWin40Ext
  if IsRectEmpty(R) then
    exit;
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedButton), ord(teButton), ord(Detail), R, ClipRect, lExit);

  if not lExit then
  begin
   LR := R;
    lUseCache := false;//not (Detail in [tbRadioButtonUncheckedNormal..tbGroupBoxDisabled]);

    if lUseCache then
    begin
      lDetails := ThemeServices.GetElementDetails(Detail);
      s := Signature(lDetails, R);
      i := FBmpCache.IndexOf(s);
      if i >= 0 then
      begin
        Bmp := TBitmap(FBmpCache.Objects[i]);
        BitBlt(DC, r.Left, r.Top, Bmp.Width, Bmp.Height, bmp.Canvas.Handle, 0, 0, SRCCOPY);
        exit;
      end
      else
        begin
          Bmp := TBitmap.Create;
          Bmp.PixelFormat := FPixelFormat;
          {$IFDEF LMDCOMP12}
          Bmp.AlphaFormat := afDefined;
          {$ENDIF}
          Bmp.Width := r.Right - r.Left + 1;
          Bmp.Height := r.Bottom - r.Top + 1;
          BitBlt(bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, DC, r.Left, r.Top, SRCCOPY);
          i := FBmpCache.Add(s);
          FBmpCache.Objects[i] := Bmp;
        end;

        OffsetRect(LR, -LR.Left, -LR.Top);
        lDC := bmp.Canvas.Handle;
    end
    else
    begin
      lDC := DC;
      bmp := nil;
    end;

    if Detail in [tbButtonDontCare, tbButtonRoot, tbPushButtonNormal,
                  tbPushButtonHot, tbPushButtonPressed,
                 tbPushButtonDisabled, tbPushButtonDefaulted] then
      InflateRect(LR, -1 , -1);

    Dec(lr.Right, 1);
    Dec(lr.Bottom, 1);

    if Detail in [tbRadioButtonUncheckedNormal..tbRadioButtonCheckedDisabled] then
      DrawGradientFramedFigure(lDC, nil, LR, LR2, ClipRect, FButtonFrame[Detail], FButtonFill[Detail], FCFrame, FCircle, FPixelFormat);

    if Detail in [tbPushButtonNormal..tbPushButtonDefaulted, tbCheckBoxUncheckedNormal..tbCheckBoxMixedDisabled] then
      DrawGradientFramedFigure(lDC, nil, LR, LR2, ClipRect, FButtonFrame[Detail], FButtonFill[Detail], FRFrame, FCCRectangle, FPixelFormat);

    if Detail in [tbGroupBoxNormal, tbGroupBoxDisabled] then
      begin
        case 2{FButtonFrame[Detail].Params[gfrpRenderMode]} of
          1: DrawGradientFramedFigure(lDC, Bmp, LR, LR2, ClipRect, FButtonFrame[Detail], FButtonFill[Detail], FRFrame, FCCRectangle, FPixelFormat);
          2: DrawSimpleFrame(lDC, Bmp, LR, LR2, ClipRect, FButtonFrame[Detail]);
        end;
      end;

    if Detail in [tbRadioButtonCheckedNormal..tbRadioButtonCheckedDisabled, tbCheckBoxCheckedNormal..tbCheckBoxMixedDisabled] then
      DrawCheckMark(lDC, LR2, Detail);

    if lUseCache then
      BitBlt(DC, r.Left, r.Top, Bmp.Width, Bmp.Height, bmp.Canvas.Handle, 0, 0, SRCCOPY);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC; Detail: TThemedEdit;
  const R: TRect; ClipRect: TLMDRectPtr);
var
  LR, LR2: TRect;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedEdit), ord(teEdit), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
    LR := R;
    LMDAdjustRect(LR, -1, -1);
    DrawGradientFramedFigure(DC, nil, LR, LR2, ClipRect, FEditFrame[Detail], FEditFill[Detail], FRFrame, FCCRectangle, FPixelFormat);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedProgress; const R: TRect; ClipRect: TLMDRectPtr);
var
  LR, LR2: TRect;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedProgress), ord(teProgress), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
   LR := R;
    //InflateRect(LR, 1, 1);
    LMDAdjustRect(LR, -1, -1);

    if Detail = tpChunk then
      LMDAdjustRect(LR, -1, 0);
    if Detail = tpChunkVert then
      LMDAdjustRect(LR, 0, -1);
    if Detail in [tpChunk] then
      begin
        InflateRect(LR, -1, -2);
        LR.Left := LR.Left + 1;
        if LR.Left >= LR.Right then
          exit;
      end;
    if Detail in [tpChunkVert] then
      begin
        InflateRect(LR, -2, -1);
        LR.Top := LR.Top + 1;
        if LR.Top >= LR.Bottom then
          exit;
      end;
    if Detail in [tpBar..tpChunkVert] then
      DrawGradientFramedFigure(DC, nil, LR, LR2, ClipRect, FProgressFrame[Detail], FProgressFill[Detail], FRFrame, FCCRectangle, FPixelFormat);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedScrollBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedProgress; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedExplorerBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedExplorerBar; const R: TRect; ClipRect: TLMDRectPtr);
begin
  raise Exception.CreateFmt(IDS_LMDTHEMES_ELEMENTNOTSUPPORTED, ['TThemedExplorerBar', GetThemeRendererName]);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTrackBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedHeader; const R: TRect; ClipRect: TLMDRectPtr);
var
  lR, lR2 : TRect;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedHeader), ord(teHeader), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
    lR := R;
    LMDAdjustRect(lR, -1, -1);
    DrawGradientFramedFigure(DC, nil, LR, LR2, ClipRect, FHeaderFrame[Detail], FHeaderFill[Detail], FRFrame, FCCRectangle, FPixelFormat);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedHeader; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTreeview; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
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
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTreeview; const R: TRect; ClipRect: TLMDRectPtr);
var
  lR, lR2: TRect;
begin
  lR := R;
  case Detail of
    ttTreeviewDontCare:
      DrawSimpleFrame(DC, nil, lR, LR2, ClipRect, FTreeViewFrame[ttTreeviewDontCare]);
    ttGlyphOpened:
      DrawMinus(DC, lR, $00F0E2D5, $00766555, $00745D4B, $00C9BEB6, true);
    ttGlyphClosed:
      DrawPlus(DC, lR, $00F0E2D5, $00766555, $00745D4B, $00C9BEB6, true);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedWindow; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTrackBar; const R: TRect; ClipRect: TLMDRectPtr);
var
  lPen, lOldPen: HPEN;
  x1, x2, y1, y2, d, dx, dy, dy1, dx1: integer;
  lR, LR2: TRect;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedTrackBar), ord(teTrackBar), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
    x1 := 0; y1 := 0;
    x2 := 0; y2 := 0;
    lR := R;
    InflateRect(lR, -1, -1);
    if Detail in [ttbThumbLeftNormal..ttbThumbRightDisabled] then
      begin
        InflateRect(lR, -1, 0);
        if (lR.Bottom - lR.Top) mod 2 <> 0 then
          Dec(lR.Bottom);
      end;
    if Detail in [ttbThumbBottomNormal..ttbThumbTopDisabled] then
      begin
        InflateRect(lR, 0, -1);
        if (lR.Right - lR.Left) mod 2 <> 0 then
          begin
            Inc(lR.Right);
            OffsetRect(lR, -1, 0);
          end;
       end;
    DrawGradientFramedFigure(DC, nil, LR, LR2, ClipRect, FTrackBarFrame[Detail], FTrackBarFill[Detail], FRFrame, FCCRectangle, FPixelFormat);

    dx := 1;
    dy := 0;
    dx1 := 0;
    dy1 := 0;
    if Detail in [ttbThumbBottomNormal..ttbThumbTopDisabled] then
      begin
        x1 := (LR2.Left + LR2.Right) div 2;
        x2 := x1;
        d := (LR2.Bottom - LR2.Top) div 4;
        y1 := LR2.Top + d;
        y2 := LR2.Bottom - d;
        if Detail in [ttbThumbTopNormal, ttbThumbTopHot, ttbThumbTopPressed, ttbThumbTopFocused, ttbThumbTopDisabled] then
          dy1 := d div 2;
      end;
    if Detail in [ttbThumbLeftNormal..ttbThumbRightDisabled] then
      begin
        y1 := (LR2.Bottom + LR2.Top) div 2;
        y2 := y1;
        d := (LR2.Right - LR2.Left) div 4;
        x1 := LR2.Left + d;
        x2 := LR2.Right - d;
        dx := 0;
        dy := 1;
        if Detail in [ttbThumbRightNormal..ttbThumbRightDisabled] then
          dx1 := 0
        else
          dx1 := d div 2;
      end;
    if FTrackBarFill[Detail].Fillers[gfpDeco1] <> nil then
      begin
        lPen := CreatePen(PS_SOLID, 1, TLMDSolidFiller(FTrackBarFill[Detail].Fillers[gfpDeco1]).FixedColors[0]);
        lOldPen := SelectObject(DC, lPen);
        MoveToEx(DC, x1 + dx1, y1 + dy1, nil);
        LineTo(DC, x2 + dx1, y2 + dy1);
        SelectObject(DC, lOldPen);
        DeleteObject(lPen);
      end;
    if FTrackBarFill[Detail].Fillers[gfpDeco2] <> nil then
      begin
        lPen := CreatePen(PS_SOLID, 1, TLMDSolidFiller(FTrackBarFill[Detail].Fillers[gfpDeco2]).FixedColors[0]);
        lOldPen := SelectObject(DC, lPen);
        MoveToEx(DC, x1 + dx + dx1, y1 + dy + dy1, nil);
        LineTo(DC, x2 + dx +dx1, y2 + dy + dy1);
        SelectObject(DC, lOldPen);
        DeleteObject(lPen);
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedWindow; const R: TRect; ClipRect: TLMDRectPtr);
var
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawElement) then
    FOnDrawElement(Self, DC, TypeInfo(TThemedElement), TypeInfo(TThemedWindow), ord(teWindow), ord(Detail), R, ClipRect, lExit);
  if not lExit then
  begin
    //
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedListview; const R: TRect; ClipRect: TLMDRectPtr);
begin
  raise Exception.CreateFmt(IDS_LMDTHEMES_ELEMENTNOTSUPPORTED, ['TThemedListview', GetThemeRendererName]);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedListview; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.DrawThemeEdge(DC: HDC;
  aElement: TThemedElement; iPartId, iStateId: Integer;
  const pDestRect: TRect; uEdge, uFlags: UINT;
  pContentRect: TLMDRectPtr): boolean;
var
  lElemDetails: TThemedElementDetails;
  lDetailOrd: integer;
  pfrd: PLMDGradientThemeFrameData;
  lColor: TColor;
  LCanvas: TCanvas;
begin
  result := false;
  if FMetaData.DetailData[ord(aElement)].FrameData = nil then
    exit;
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

  pfrd := PLMDGradientThemeFrameData(FMetaData.DetailData[ord(aElement)].FrameData);
  lColor := pfrd^[lDetailOrd].Fillers[sfpOuterBorder].FixedColors[0];

  LCanvas := TCanvas.Create;
  LCanvas.Handle := DC;
  LCanvas.Pen.Color := lColor;
  LCanvas.Pen.Style := psSolid;
  with LCanvas, pDestRect do
  begin
    if (BF_TOP and uFlags) = BF_TOP then
    begin
      MoveTo(Left, Top);
      LineTo(Right, Top);
    end;
    if (BF_BOTTOM and uFlags) = BF_BOTTOM then
    begin
      MoveTo(Left, Bottom - 1);
      LineTo(Right, Bottom - 1);
    end;
    if (BF_LEFT and uFlags) = BF_LEFT then
    begin
      MoveTo(Left, Top);
      LineTo(Left, Bottom);
    end;
    if (BF_RIGHT and uFlags) = BF_RIGHT then
    begin
      MoveTo(Right - 1, Top);
      LineTo(Right - 1, Bottom);
    end;
  end;
  LCanvas.Handle := 0;
  LCanvas.Free;
  result := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawThemeParentBackground(Wnd: HWnd;
  DC: HDC; ARect: TLMDRectPtr);
begin
  LMDDrawParentBackground(Wnd, DC, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.DrawThemeText(DC: HDC;
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
function TLMDBaseGradientThemeRenderer.GetThemeBackgroundExtent(DC: HDC;
  Detail: TThemedElement; iPartID, iStateID: integer; ContentRect: TRect;
  var ExtentRect: TRect): boolean;
begin
  result := false;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetThemeColor(AElement: TThemedElement;
  iPartId, iStateId, iPropId: Integer): COLORREF;
var
  lElemDetails: TThemedElementDetails;
  lDetailOrd: integer;
  lFillData: PLMDGradientThemeFillData;
  lFrameData : PLMDGradientThemeFrameData;
  lTextData: PLMDGradientThemeTextData;
  ln: integer;
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
        lTextData := Metadata[aElement].TextData;
        if lTextData = nil then
          begin
            if iStateId = PBS_DISABLED then
              result := FDisabledTextColor
            else
              result := FEnabledTextColor;
          end
        else
          begin
            result := lTextData^[lDetailOrd].Color;
          end;
      end;
    TMT_BORDERCOLOR, TMT_EDGELIGHTCOLOR:
      begin
        if FMetaData.DetailData[ord(aElement)].FrameData <> nil then
          begin
            lFrameData := PLMDGradientThemeFrameData(FMetaData.DetailData[ord(aElement)].FrameData);
            result := lFrameData^[lDetailOrd].Fillers[sfpOuterBorder].FixedColors[0];
          end;
      end;
    TMT_FILLCOLOR, TMT_GRADIENTCOLOR1, TMT_GRADIENTCOLOR2:
      begin
        if FMetaData.DetailData[ord(aElement)].FillData <> nil then
          begin
            lFillData := FMetaData.DetailData[ord(aElement)].FillData;
            if lFillData^[lDetailOrd].Fillers[gfpMain] <> nil then
              begin
                ln := lFillData^[lDetailOrd].Fillers[gfpMain].ColorCount - 1;
                if ln - 1 < 0 then
                  ln := 0;
                if iPropId = TMT_GRADIENTCOLOR2 then
                  result := lFillData^[lDetailOrd].Fillers[gfpMain].FixedColors[ln]
                else
                  result := lFillData^[lDetailOrd].Fillers[gfpMain].FixedColors[0];
              end;
          end;
      end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetThemeFont(DC: HDC;
  Detail: TThemedElement; iPartId, iStateId, iPropId: Integer;
  var font: LOGFONTW): Boolean;
var
  pTextData: PLMDGradientThemeTextData;
  lDetails: TThemedElementDetails;
  lDetailOrd: integer;
begin
  pTextData := PLMDGradientThemeTextData(MetaData[Detail].TextData);
  if pTextData <> nil then
    begin
      lDetails.Element := Detail;
      lDetails.Part := iPartId;
      lDetails.State:= iStateId;
      lDetailOrd := LMDThemeServices.GetDetailOrd(lDetails);
      font := pTextData^[lDetailOrd].Params;
      result := true;
    end
  else
    result := false;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetThemePartSize(DC: HDC;
  Detail: TThemedElement; iPartId, iStateId: Integer;
  var size: TSize): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetThemeSysColor(Detail: TThemedElement;
  ColorID: integer): ColorRef;
begin
  result := clNone;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetThemeSysSize(Detail: TThemedElement;
  iSizeId: Integer): Integer;
begin
  if (Detail = teComboBox) and (iSizeId >= 2) then
    result := 17
  else
    result := -1;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetThemeTextExtent(DC: HDC;
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
function TLMDBaseGradientThemeRenderer.GetEnabled: boolean;
begin
  result := FEnabled;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DoUpdateTheme;
begin
  if not SuppressUpdate then
  begin
    FTheme := gtCustom;
    FModified := true;
    if not FIsUpdating then
      begin
        ClearCache;
        LMDThemeServices.ApplyThemeChange;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.BeginUpdate;
begin
  if not SuppressUpdate then
    FIsUpdating := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.EndUpdate(aDoApply: boolean = true);
begin
  if FIsUpdating then
    begin
      FIsUpdating := false;
      if aDoApply then
        LMDThemeServices.ApplyThemeChange;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.LoadColorSchemeFromXML(
  aXmlDoc: ILMDXMLDocument; aColorScheme: TLMDString; aDoApply: boolean = true): boolean;
var
  lColorSchemeSection: ILMDXMLElement;
  lGlobals, lElement, lElements, lElement1, lElement2, lElement3: ILMDXMLElement;
  lDetail: ILMDXMLElement;

  te: TThemedElement;
  i: integer;
  pFillData: PLMDGradientThemeFillData;
  pFrameData: PLMDGradientThemeFrameData;
  pTextData: PLMDGradientThemeTextData;

  state: boolean;
  btns: TLMDThemedButtonState;
  ldir: TLMDDirection;
begin
  DeactivateTheme;
  result := false;
  if aXmlDoc = nil then
    exit;
  try
    try
      FThemeName := string(aXmlDoc.DocumentElement.GetAttr('Name', ''));
      lColorSchemeSection := aXmlDoc.DocumentElement.FindElement('ColorScheme', 'Name', aColorScheme);
      if lColorSchemeSection = nil then
        if aXmlDoc.DocumentElement.ChildNodes <> nil then
          lColorSchemeSection := aXmlDoc.DocumentElement.ChildNodes.Item[0].AsElement;
      if lColorSchemeSection = nil then
        exit;
      FColorSchemeName := lColorSchemeSection.GetAttr('Name', 'Unknown');
      BeginUpdate;
      lGlobals := lColorSchemeSection.FindElement('Globals', '', '');
      if lGLobals <> nil then
        begin
          lElement := lGlobals.FindElement('Text', '', '');
          if lElement <> nil then
            begin
              lElements := lElement.FindElement('Colors', '', '');
              if lElements <> nil then
                begin
                  lElement := lElements.FindElement('Color', 'State', '0');
                  if lElement <> nil then
                    DisabledTextColor := StringToColor(lElement.GetAttr('Value', 'clNone'));
                  lElement := lElements.FindElement('Color', 'State', '1');
                  if lElement <> nil then
                    EnabledTextColor := StringToColor(lElement.GetAttr('Value', 'clNone'));
                end;
            end;

          lElements := lGlobals.FindElement('SimpleArrow', '', '');
          if lElements <> nil then
            begin
              lElement1 := lElements.FindElement('FillColors', '', '');
              if lElement1 <> nil then
                for state := false to true do
                  begin
                    lElement2 := lElement1.FindElement('Color', 'State', inttostr(ord(state)));
                    if lElement2 <> nil then
                      FSimpleArrowColors[state] := StringToColor(lElement2.GetAttr('Value', 'clNone'));
                  end;
              lElement1 := lElements.FindElement('ShadowColors', '', '');
              if lElement1 <> nil then
                for state := false to true do
                  begin
                    lElement2 := lElement1.FindElement('Color', 'State', inttostr(ord(state)));
                    if lElement2 <> nil then
                      FSimpleArrowShadowColors[state] := StringToColor(lElement2.GetAttr('Value', 'clNone'));
                  end;
            end;
          for btns := low(TLMDThemedButtonState) to high(TLMDThemedButtonState) do
            begin
              lElements := lGlobals.FindElement('GradientArrows', 'State', getEnumName(typeInfo(TLMDThemedButtonState), ord(btns)));
              if lElements <> nil then
                for ldir := low(TLMDDirection) to high(TLMDDirection) do
                  begin
                    lElement1 := lElements.FindElement('GradientArrow', 'Direction', getEnumName(typeInfo(TLMDDirection), ord(ldir)));
                    if lElement1 <> nil then
                      begin
                        lElement2 := lElement1.FindElement('Filler', '', '');
                        if lElement2 <> nil then
                          FGradientArrowFiller[ldir, btns] := ReadFillerFromXML(lElement2);
                      end;
                  end;
            end;
          for state := false to true do
            begin
              lElements := lGlobals.FindElement('CheckMarkFill', 'State', inttostr(ord(state)));
              if lElements <> nil then
                begin
                  lElement := lElements.FindElement('FillDescriptor', '', '');
                  if lElement <> nil then
                    ReadFillDescriptorFromXML(FCheckMarkFill[state], lElement);
                end;
            end;
          for state := false to true do
            begin
              lElements := lGlobals.FindElement('MixedMarkFill', 'State', inttostr(ord(state)));
              if lElements <> nil then
                begin
                  lElement := lElements.FindElement('FillDescriptor', '', '');
                  if lElement <> nil then
                    ReadFillDescriptorFromXML(FMixedMarkFill[state], lElement);
                end;
            end;
          for state := false to true do
            begin
              lElements := lGlobals.FindElement('RadioBtnCheckMarkFill', 'State', inttostr(ord(state)));
              if lElements <> nil then
                begin
                  lElement := lElements.FindElement('FillDescriptor', '', '');
                  if lElement <> nil then
                    ReadFillDescriptorFromXML(FRadioBtnCheckMarkFill[state], lElement);
                end;
            end;
        end;

      for te := low(TThemedElement) to high(TThemedElement) do
        if FMetaData.DetailData[ord(te)].DetailTypeInfo <> nil then
          begin
            lElement := lColorSchemeSection.FindElement('ThemedElement', 'Name', getEnumName(typeInfo(TThemedElement), ord(te)));
            if lElement = nil then
              continue;
            for i  := GetTypeData(FMetaData.DetailData[ord(te)].DetailTypeInfo)^.MinValue to GetTypeData(FMetaData.DetailData[ord(te)].DetailTypeInfo)^.MaxValue do
              begin
                lDetail := lElement.FindElement('Detail', 'Name', getEnumName(FMetaData.DetailData[ord(te)].DetailTypeInfo, i));
                if lDetail <> nil then
                  begin
                    pFillData := PLMDGradientThemeFillData(FMetaData.DetailData[ord(te)].FillData);
                    pFrameData := PLMDGradientThemeFrameData(FMetaData.DetailData[ord(te)].FrameData);
                    pTextData := PLMDGradientThemeTextData(FMetaData.DetailData[ord(te)].TextData);
                    lElement1 := lDetail.FindElement('FillDescriptor', '', '');
                    if (pFillData <> nil) and (lElement1 <> nil) then
                      ReadFillDescriptorFromXML(pFillData^[i], lElement1);
                    lElement2 := lDetail.FindElement('FrameDescriptor', '', '');
                    if (pFrameData <> nil) and (lElement2 <> nil) then
                      ReadFrameDescriptorFromXML(pFrameData^[i], lElement2);
                    lElement3 := lDetail.FindElement('TextDescriptor', '', '');
                    if lElement3 <> nil then
                      ReadTextDescriptorFromXML(pTextData^[i], lElement3);
                  end;
              end;
          end;
      result := true;
    except
      result := false;
    end;
  finally
    FEnabled := result;
    EndUpdate(aDoApply);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.LoadThemeFromStream(aStream: TStream; aColorScheme: TLMDString = ''; aDoApply: boolean = true): boolean;
begin
  if FXmlDoc <> nil then
    begin
      FXmlDoc.RemoveAllChilds;
      FXmlDoc.RemoveAllAttrs;
      FXmlDoc := nil;
    end;
  FXmlDoc := LMDCreateXmlDocument('Theme', '1.0', '', nil, False);
  FXmlDoc.Load(aStream);
  result := LoadColorSchemeFromXML(FXmlDoc, aColorScheme, aDoApply);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.SaveColorSchemeToXML(aXmlDoc: ILMDXMLDocument; aColorScheme: TLMDString): boolean;
var
  lXmlDoc: ILMDXmlDocument;
  lColorSchemeSection: ILMDXMLElement;
  lElement: ILMDXMLElement;
  lElements: ILMDXMLElement;
  lGlobals: ILMDXMLElement;
  lDetail: ILMDXMLElement;
  lParamsNode, lParamNode: ILMDXMLElement;
  te: TThemedElement;
  i: integer;
  pFillData: PLMDGradientThemeFillData;
  pFrameData: PLMDGradientThemeFrameData;
  pTextData: PLMDGradientThemeTextData;

  state: boolean;
  ldir: TLMDDirection;
  lbtns: TLMDThemedButtonState;
begin
  if (aXmlDoc = nil) or (aColorScheme = '') then
    begin
      result := false;
      exit;
    end;

  //lXmlDoc := LMDCreateXmlDocument('Theme', '1.0', '', nil, False);
  lXmlDoc := aXmlDoc;

  //lXmlDoc.DocumentElement.SetAttr('Type', 'LMD Gradient Theme');
  //lXmlDoc.DocumentElement.SetAttr('Name', aThemeName);
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
  lElement := lElement.AppendElement('Colors');
  lParamNode := lElement.AppendElement('Color');
  lParamNode.SetAttr('State', '0');
  lParamNode.SetAttr('Value', ColorToString(DisabledTextColor));
  lParamNode := lElement.AppendElement('Color');
  lParamNode.SetAttr('State', '1');
  lParamNode.SetAttr('Value', ColorToString(EnabledTextColor));


  lElement := lGlobals.AppendElement('SimpleArrow');
  lParamsNode := lElement.AppendElement('FillColors');
  for state := false to true do
    begin
      lParamNode := lParamsNode.AppendElement('Color');
      lParamNode.SetAttr('State', inttostr(ord(state)));
      lParamNode.SetAttr('Value', ColorToString(FSimpleArrowColors[state]));
    end;
  lParamsNode := lElement.AppendElement('ShadowColors');
  for state := false to true do
    begin
      lParamNode := lParamsNode.AppendElement('Color');
      lParamNode.SetAttr('State', inttostr(ord(state)));
      lParamNode.SetAttr('Value', ColorToString(FSimpleArrowShadowColors[state]));
    end;

  for lbtns := low(TLMDThemedButtonState) to high(TLMDThemedButtonState) do
    begin
      lElements := lGlobals.AppendElement('GradientArrows');
      lElements.SetAttr('State', getEnumName(TypeInfo(TLMDThemedButtonState), ord(lbtns)));
      for ldir := low(TLMDDirection) to high(TLMDDirection) do
       if FGradientArrowFiller[ldir, lbtns] <> nil then
         begin
           lElement := lElements.AppendElement('GradientArrow');
           lElement.SetAttr('Direction', getEnumName(TypeInfo(TLMDDirection), ord(ldir)));
           WriteFillerToXML(FGradientArrowFiller[ldir, lbtns], lElement);
         end;
    end;

  for state := false to true do
    begin
      lElement := lGlobals.AppendElement('CheckMarkFill');
      lElement.SetAttr('State', inttostr(ord(state)));
      WriteFillDescriptorToXML(FCheckMarkFill[state], lElement);
    end;

  for state := false to true do
    begin
      lElement := lGlobals.AppendElement('MixedMarkFill');
      lElement.SetAttr('State', inttostr(ord(state)));
      WriteFillDescriptorToXML(FMixedMarkFill[state], lElement);
    end;

  for state := false to true do
    begin
      lElement := lGlobals.AppendElement('RadioBtnCheckMarkFill');
      lElement.SetAttr('State', inttostr(ord(state)));
      WriteFillDescriptorToXML(FRadioBtnCheckMarkFill[state], lElement);
    end;

  for te := low(TThemedElement) to high(TThemedElement) do
    with FMetaData.DetailData[ord(te)] do
    if DetailTypeInfo <> nil then
      begin
        lElement := lColorSchemeSection.AppendElement('ThemedElement');
        lElement.SetAttr('Name',  getEnumName(typeInfo(TThemedElement), ord(te)));
        for i  := GetTypeData(DetailTypeInfo)^.MinValue to GetTypeData(DetailTypeInfo)^.MaxValue do
          begin
            lDetail := lElement.AppendElement('Detail');
            lDetail.SetAttr('Name', getEnumName(DetailTypeInfo, i));
            pFillData := PLMDGradientThemeFillData(FillData);
            pFrameData := PLMDGradientThemeFrameData(FrameData);
            pTextData := PLMDGradientThemeTextData(TextData);
            if pFillData <> nil then
              WriteFillDescriptorToXML(pFillData^[i], lDetail);
            if pFrameData <> nil then
              WriteFrameDescriptorToXML(pFrameData^[i], lDetail);
            if pTextData <> nil then
              WriteTextDescriptorToXML(pTextData^[i], lDetail);
          end;
      end;
  FModified := false;
  result := true;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.SaveColorSchemeToStream(aStream: TStream; aColorScheme: TLMDString): boolean;
begin
  result := false;
  if aStream.Size > 0 then
    try
      FXmlDoc.Load(aStream);
    except
    end;
  if SaveColorSchemeToXML(FXmlDoc, aColorScheme) then
    begin
      aStream.Seek(0, soBeginning);
      FXmlDoc.Save(aStream);
      result := true;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.SaveColorSchemeToFile(aFileName: TLMDString; aColorScheme: TLMDString): boolean;
var
  lStream: TMemoryStream;
begin
  try
    lStream := TMemoryStream.Create;
    if FileExists(aFileName) then
      lStream.LoadFromFile(aFileName);
    SaveColorSchemeToStream(lStream, aColorScheme);
    lStream.SaveToFile(aFileName);
    lStream.Free;
    result := true;
  except
    result := false;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.LoadThemeFromFile(aFile: TLMDString; aColorScheme: TLMDString = ''; aDoApply: boolean = true): boolean;
var
  lStream: TMemoryStream;
  lIsCabFile: boolean;
  lFile, lTmpPath: string;
  lSL: TStringList;
  i, j: integer;
begin
  lIsCabFile := false;
  if Pos('.xml', aFile) > 0 then
    lFile := aFile
  else
    if Pos('.cab', aFile) > 0 then
      begin
        lIsCabFile := true;
        lTmpPath := LMDSITempPath;
        lSl := TStringList.Create;
        try
          LMDCabGetFileList(AnsiString(aFile),  lSl);
          j := -1;
          if lSl.Count > 0 then
            for i := 0 to lSl.Count -1 do
              if Pos('.xml', lSL[i]) > 0 then
                begin
                  j := i;
                  break;
                end;
          if j = - 1 then
            LMDDebug(Format(SLMDInvalidThemeFileName, [String(aFile)]))
          else
            if not LMDCABExtractFile(AnsiString(aFile), AnsiString(lTmpPath), AnsiString(lSl[j])) then
              LMDDebug(Format(SLMDInvalidThemeFileName, [String(aFile)]))
            else
              lFile := lTmpPath + lSl[j];
        finally
          lSl.Clear;
          lSl.Free;
        end
      end;

  lStream := TMemoryStream.Create;
  try
    try
      lStream.LoadFromFile(lFile);
      result := LoadThemeFromStream(lStream, aColorScheme, aDoApply);
    except
      result := false;
    end;
  finally
    lStream.Free;
    if lIsCabFile then
      DeleteFileA(PAnsiChar(AnsiString(lFile)));
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.ChangeBrightness(aPercent: integer; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aFillParts: TLMDGradientFillParts = cGradientFillAllParts; aFrameParts: TLMDGradientSimpleFramePartKinds = cGradientSFrameAllParts; aIndex: integer = -1);
var
  te: TThemedElement;
  i: integer;
  pFillData: PLMDGradientThemeFillData;
  pFrameData: PLMDGradientThemeFrameData;
  lDetailName: string;
  frp: TLMDGradientSimpleFramePartKind;
  flp: TLMDGradientFillPart;
begin
  if (aIndex < -1) or (aIndex > 255) then
    exit;
  BeginUpdate;
  for te := low(TThemedElement) to high(TThemedElement) do
    with FMetaData.DetailData[ord(te)] do
      if (DetailTypeInfo <> nil) and ((aElements = []) or (te in aElements)) then
        for i  := GetTypeData(DetailTypeInfo)^.MinValue to GetTypeData(DetailTypeInfo)^.MaxValue do
        begin
          lDetailName := getEnumName(DetailTypeInfo, i);
          if LMDCheckWildCardMask(aDetailNameMask, lDetailName) then
            begin
              pFillData := PLMDGradientThemeFillData(FillData);
              pFrameData := PLMDGradientThemeFrameData(FrameData);
              if pFillData <> nil then
                for flp := low(TLMDGradientFillPart) to high(TLMDGradientFillPart) do
                  if (flp in aFillParts) and (pFillData^[i].Fillers[flp] <> nil) then
                    pFillData^[i].Fillers[flp].ChangeColorBrightness(aPercent, aIndex);
              if pFrameData <> nil then
                for frp := low(TLMDGradientSimpleFramePartKind) to high(TLMDGradientSimpleFramePartKind) do
                  if (frp in aFrameParts) and (pFrameData^[i].Fillers[frp] <> nil) then
                    pFrameData^[i].Fillers[frp].ChangeColorBrightness(aPercent, aIndex);
          end;
        end;

  for i := 0 to 1 do
    begin
      for flp := low(TLMDGradientFillPart) to high(TLMDGradientFillPart) do
       if (flp in aFillParts) then
         begin
           if (FCheckMarkFill[boolean(i)].Fillers[flp] <> nil) then
             FCheckMarkFill[boolean(i)].Fillers[flp].ChangeColorBrightness(aPercent, aIndex);
           if (FRadioBtnCheckMarkFill[boolean(i)].Fillers[flp] <> nil) then
             FRadioBtnCheckMarkFill[boolean(i)].Fillers[flp].ChangeColorBrightness(aPercent, aIndex);
           if (FMixedMarkFill[boolean(i)].Fillers[flp] <> nil) then
              FMixedMarkFill[boolean(i)].Fillers[flp].ChangeColorBrightness(aPercent, aIndex);
         end;
    end;

  ClearCache;
  EndUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.ReplaceColor(aOldColor, aNewColor: TColor; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aFillParts: TLMDGradientFillParts = cGradientFillAllParts; aFrameParts: TLMDGradientSimpleFramePartKinds = cGradientSFrameAllParts; aIndex: integer = -1);
var
  te: TThemedElement;
  i: integer;
  pFillData: PLMDGradientThemeFillData;
  pFrameData: PLMDGradientThemeFrameData;
  lDetailName: string;
  frp: TLMDGradientSimpleFramePartKind;
  flp: TLMDGradientFillPart;
begin
  if (aIndex < -1) or (aIndex > 255) then
    exit;
  BeginUpdate;
  for te := low(TThemedElement) to high(TThemedElement) do
    with FMetaData.DetailData[ord(te)] do
      if (DetailTypeInfo <> nil) and ((aElements = []) or (te in aElements)) then
        for i  := GetTypeData(DetailTypeInfo)^.MinValue to GetTypeData(DetailTypeInfo)^.MaxValue do
        begin
          lDetailName := getEnumName(DetailTypeInfo, i);
          if LMDCheckWildCardMask(aDetailNameMask, lDetailName) then
          begin
            pFillData := PLMDGradientThemeFillData(FillData);
            pFrameData := PLMDGradientThemeFrameData(FrameData);
            if pFillData <> nil then
              for flp := low(TLMDGradientFillPart) to high(TLMDGradientFillPart) do
                if (flp in aFillParts) and (pFillData^[i].Fillers[flp] <> nil) then
                  pFillData^[i].Fillers[flp].ReplaceColor(aOldColor, aNewColor, aIndex);
            if pFrameData <> nil then
              for frp := low(TLMDGradientSimpleFramePartKind) to high(TLMDGradientSimpleFramePartKind) do
                if (frp in aFrameParts) and (pFrameData^[i].Fillers[frp] <> nil) then
                  pFrameData^[i].Fillers[frp].ReplaceColor(aOldColor, aNewColor, aIndex);
          end;
        end;
  ClearCache;
  EndUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetNewColor(aNewColor: TColor; aElements: TThemedElementSet = []; aDetailNameMask: string = ''; aFillParts: TLMDGradientFillParts = cGradientFillAllParts; aFrameParts: TLMDGradientSimpleFramePartKinds = cGradientSFrameAllParts; aIndex: integer = 0);
var
  te: TThemedElement;
  i: integer;
  pFillData: PLMDGradientThemeFillData;
  pFrameData: PLMDGradientThemeFrameData;
  lDetailName: string;
  frp: TLMDGradientSimpleFramePartKind;
  flp: TLMDGradientFillPart;
begin
  if (aIndex < -1) or (aIndex > 255) then
    exit;
  BeginUpdate;
  for te := low(TThemedElement) to high(TThemedElement) do
    with FMetaData.DetailData[ord(te)] do
      if (DetailTypeInfo <> nil) and ((aElements = []) or (te in aElements)) then
        for i  := GetTypeData(DetailTypeInfo)^.MinValue to GetTypeData(DetailTypeInfo)^.MaxValue do
        begin
          lDetailName := getEnumName(DetailTypeInfo, i);
          if LMDCheckWildCardMask(aDetailNameMask, lDetailName) then
            begin
              pFillData := PLMDGradientThemeFillData(FillData);
              pFrameData := PLMDGradientThemeFrameData(FrameData);
              if pFillData <> nil then
                for flp := low(TLMDGradientFillPart) to high(TLMDGradientFillPart) do
                  if (flp in aFillParts) and (pFillData^[i].Fillers[flp] <> nil) then
                    pFillData^[i].Fillers[flp].SetNewColor(aNewColor, aIndex);
              if pFrameData <> nil then
                for frp := low(TLMDGradientSimpleFramePartKind) to high(TLMDGradientSimpleFramePartKind) do
                  if (frp in aFrameParts) and (pFrameData^[i].Fillers[frp] <> nil) then
                    pFrameData^[i].Fillers[frp].SetNewColor(aNewColor, aIndex);
          end;
        end;
  ClearCache;
  EndUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetColorSchemeName(
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
function TLMDBaseGradientThemeRenderer.GetMetaData(
  Element: TThemedElement): TLMDThemeDetailMetaData;
begin
  result := FMetaData.DetailData[ord(Element)];
end;

{------------------------------------------------------------------------------}
destructor TLMDBaseGradientThemeRenderer.Destroy;
var
  i: integer;
begin
  DeactivateTheme;

  FRFrame.Free;
  FCFrame.Free;
  FRoundRectangle.Free;
  FCircle.Free;
  FCCRectangle.Free;
  FRectangle.Free;
  FLine1.Free;
  FLine2.Free;

  for i := 0 to FFillerToolBox.Count - 1 do
    TLMDFiller(FFillerToolBox.Objects[i]).Free;

  FBmpCache.Free;

  FFillerToolBox.Clear;
  FFillerToolBox.Free;

  FMetaDataPool.Clear;
  FMetaDataPool.Free;
  FMetaData.DetailData := nil;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetFillerParams(aDestFiller,
  aSrcFiller: TLMDFiller; aRect: TRect);
var
  i: integer;
  FR, RR: TRect;
begin
  if (aSrcFiller = nil) or (aDestFiller = nil) then
    exit;
  if aSrcFiller is TLMDMixedFiller then
    with TLMDMixedFiller(aSrcFiller) do
      for i := 0 to Count - 1 do
        SetFillerParams(TLMDMixedFiller(aDestFiller).Item[i], Item[i], aRect)
  else
    begin
      if aSrcFiller is TLMDCompositeFiller then
        with TLMDCompositeFiller(aSrcFiller) do
          for i := 0 to Count - 1 do
            begin
              RR := FillerRect[i];
              FR := LMDRelativeRect(aRect, RR);
              TLMDCompositeFiller(aDestFiller).FillerRect[i] := FR;
              SetFillerParams(TLMDCompositeFiller(aDestFiller).Item[i], Item[i], FR);
            end
      else
        begin
          aDestFiller.BasePoint := LMDRelativePoint(aRect, aSrcFiller.BasePoint);
          if aDestFiller is TLMDLineFiller then
            begin
              RR := aRect;
              OffsetRect(RR, -aRect.Left, -aRect.Top);
              TLMDLineFiller(aDestFiller).VectorN := LMDRelativePoint(RR, aSrcFiller.VectorN);
              TLMDLineFiller(aDestFiller).VectorT := Point(TLMDLineFiller(aDestFiller).VectorN.X, -TLMDLineFiller(aDestFiller).VectorN.Y);
            end;
          if aDestFiller is TLMDVerticalGradient then
            TLMDVerticalGradient(aDestFiller).Height := aRect.Bottom - aRect.Top;
          if aDestFiller is TLMDHorizontalGradient then
            TLMDHorizontalGradient(aDestFiller).Height := aRect.Right - aRect.Left;
          if aDestFiller is TLMDRectangleFiller then
            begin
              TLMDRectangleFiller(aDestFiller).BasePoint := LMDRelativePoint(aRect, aSrcFiller.BasePoint) ;//LMDMiddlePoint(aRect.TopLeft, aRect.BottomRight);
              TLMDRectangleFiller(aDestFiller).VectorN := Point(muldiv( (aRect.Right - aRect.Left), TLMDRectangleFiller(aSrcFiller).VectorN.X, 100) , muldiv( (aRect.Right - aRect.Left), TLMDRectangleFiller(aSrcFiller).VectorN.Y, 100));
              TLMDRectangleFiller(aDestFiller).VectorT := Point(muldiv( (aRect.Bottom - aRect.Top), TLMDRectangleFiller(aSrcFiller).VectorT.X, 100), muldiv( (aRect.Bottom - aRect.Top), TLMDRectangleFiller(aSrcFiller).VectorT.Y, 100));
            end;
          if aDestFiller is TLMDRoundFiller then
            begin
              TLMDRoundFiller(aDestFiller).BasePoint := LMDRelativePoint(aRect, aSrcFiller.BasePoint);
              TLMDRoundFiller(aDestFiller).Radius := muldiv((aRect.Right - aRect.Left), TLMDRoundFiller(aSrcFiller).Radius, 100);
            end
          else
            if aDestFiller is TLMDEllipseFiller then
              begin
                TLMDEllipseFiller(aDestFiller).BasePoint := LMDRelativePoint(aRect, aSrcFiller.BasePoint);
                TLMDEllipseFiller(aDestFiller).FirstAxisDirection := TLMDEllipseFiller(aSrcFiller).FirstAxisDirection;
                TLMDEllipseFiller(aDestFiller).Axis1 := muldiv (aRect.Right - aRect.Left, TLMDEllipseFiller(aSrcFiller).Axis1, 100);
                TLMDEllipseFiller(aDestFiller).Axis2 := muldiv (aRect.Bottom - aRect.Top, TLMDEllipseFiller(aSrcFiller).Axis2, 100);
              end;
      end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.PrepareFillerFrom(const aSrcFiller: TLMDFiller; aCreateNew: boolean = false): TLMDFiller;
begin
  if aSrcFiller = nil then
    result := nil
  else
    begin
      if aCreateNew then
        result := aSrcFiller.Clone
      else
        begin
          result := TLMDFiller(FFillerToolBox.Objects[FFillerToolBox.IndexOf(aSrcFiller.ClassName)]);
          aSrcFiller.AssignTo(result);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DeactivateTheme;
var
  te: TThemedElement;
  i: integer;
  pfld: PLMDGradientThemeFillData;
  pfrd: PLMDGradientThemeFrameData;
  btns: TLMDThemedButtonState;
  ldir: TLMDDirection;
  st: boolean;
begin
  for btns := low(TLMDThemedButtonState) to high(TLMDThemedButtonState) do
    for ldir := low(TLMDDirection) to high(TLMDDirection) do
      if FGradientArrowFiller[ldir, btns] <> nil then
         FreeAndNil(FGradientArrowFiller[ldir, btns]);

   for st := false to true do
     begin
       ClearDescriptorFillers(FCheckMarkFill[st]);
       ClearDescriptorFillers(FRadioBtnCheckMarkFill[st]);
       ClearDescriptorFillers(FMixedMarkFill[st]);
     end;

  for te := low(TThemedElement) to high(TThemedElement) do
    with FMetaData.DetailData[ord(te)] do
      if (DetailTypeInfo <> nil) then
        begin
          pfld := PLMDGradientThemeFillData(FillData);
          pfrd := PLMDGradientThemeFrameData(FrameData);
          for i := GetTypeData(DetailTypeInfo)^.MinValue to GetTypeData(DetailTypeInfo)^.MaxValue do
            begin
              if pfld <> nil then
                ClearDescriptorFillers(pfld^[i]);
              if pfrd <> nil then
                ClearDescriptorFillers(pfrd^[i]);
            end;
        end;

  ClearCache;
  FEnabled := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetRectFrameParams(
  aDstFrame:  TLMDGradientRectFrame; aParams: TLMDGradientThemeFrameParams);
begin
  with aDstFrame do
    begin
      OuterBorderSides := LMDByteToFrameSides(aParams[gfrpOuterBorderSides]);
      InnerBorderSides := LMDByteToFrameSides(aParams[gfrpInnerBorderSides]);
      with OuterBorder do
        begin
          EdgeWidth := aParams[gfrpOuterBorderEdgeWidth];
          Width := aParams[gfrpOuterBorderWidth];
          OuterCutType := LMDByteToCornerCut(aParams[gfrpOuterBorderOuterCutType]);
          InnerCutType := LMDByteToCornerCut(aParams[gfrpOuterBorderInnerCutType]);
          OuterCutXValueType := TLMDValueType(aParams[gfrpOuterBorderOuterCutXValueType]);
          InnerCutXValueType := TLMDValueType(aParams[gfrpOuterBorderInnerCutXValueType]);
          OuterCutX := aParams[gfrpOuterBorderOuterCutX];
          InnerCutX := aParams[gfrpOuterBorderInnerCutX];
          OuterCutY := aParams[gfrpOuterBorderOuterCutY];
          InnerCutY := aParams[gfrpOuterBorderInnerCutY];
          OuterCutYValueType := TLMDValueType(aParams[gfrpOuterBorderOuterCutYValueType]);
          InnerCutYValueType := TLMDValueType(aParams[gfrpOuterBorderInnerCutYValueType]);
        end;

      with InnerBorder do
        begin
          EdgeWidth := aParams[gfrpInnerBorderEdgeWidth];
          Width := aParams[gfrpInnerBorderWidth];
          OuterCutType := LMDByteToCornerCut(aParams[gfrpInnerBorderOuterCutType]);
          InnerCutType := LMDByteToCornerCut(aParams[gfrpInnerBorderInnerCutType]);
          OuterCutXValueType := TLMDValueType(aParams[gfrpInnerBorderOuterCutXValueType]);
          InnerCutXValueType := TLMDValueType(aParams[gfrpInnerBorderInnerCutXValueType]);
          OuterCutX := aParams[gfrpInnerBorderOuterCutX];
          InnerCutX := aParams[gfrpInnerBorderInnerCutX];
          OuterCutY := aParams[gfrpInnerBorderOuterCutY];
          InnerCutY := aParams[gfrpInnerBorderInnerCutY];
          OuterCutYValueType := TLMDValueType(aParams[gfrpInnerBorderOuterCutYValueType]);
          InnerCutYValueType := TLMDValueType(aParams[gfrpInnerBorderInnerCutYValueType]);
        end;

      with InnerSpace do
      begin
        EdgeWidth := aParams[gfrpSpaceEdgeWidth];
        Width := 0;
        OuterCutType := LMDByteToCornerCut(aParams[gfrpInnerSpaceOuterCutType]);
        InnerCutType := LMDByteToCornerCut(aParams[gfrpInnerSpaceInnerCutType]);
        OuterCutXValueType := TLMDValueType(aParams[gfrpInnerSpaceOuterCutXValueType]);
        InnerCutXValueType := TLMDValueType(aParams[gfrpInnerSpaceInnerCutXValueType]);
        OuterCutX := aParams[gfrpInnerSpaceOuterCutX];
        InnerCutX := aParams[gfrpInnerSpaceInnerCutX];
        OuterCutY := aParams[gfrpInnerSpaceOuterCutY];
        InnerCutY := aParams[gfrpInnerSpaceInnerCutY];
        OuterCutYValueType := TLMDValueType(aParams[gfrpInnerSpaceOuterCutYValueType]);
        InnerCutYValueType := TLMDValueType(aParams[gfrpInnerSpaceInnerCutYValueType]);
      end;

      InnerBorderGap := aParams[gfrpInnerBorderGap];
      OuterBorderGap := aParams[gfrpOuterBorderGap];
      TopSpaceWidth := aParams[gfrpTopSpaceWidth];
      RightSpaceWidth := aParams[gfrpRightSpaceWidth];
      BottomSpaceWidth := aParams[gfrpBottomSpaceWidth];
      LeftSpaceWidth := aParams[gfrpLeftSpaceWidth];
      CutValueUsage := TLMDCutValueUsage(aParams[gfrpCutValueUsage]);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.PrepareFiller(aSrcFiller: TLMDFiller; aRect: TRect): TLMDFiller;
begin
  if (aSrcFiller <> nil) and aSrcFiller.UseRelativeUnits then
    begin
      result := PrepareFillerFrom(aSrcFiller, true);
      SetFillerParams(result, aSrcFiller, aRect);
    end
  else
    result := aSrcFiller;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.FinalizeFrameFillers(
  aFrame: TLMDBaseGradientFrame; aFrameDescriptor: TLMDGradientThemeFrameDescriptor);
begin
  with aFrame do
  begin
    with OuterBorder do
      if (Filler <> aFrameDescriptor.Fillers[sfpOuterBorder]) and (Filler <> nil) then
        begin
          Filler.Free;
          Filler := nil;
        end;
    with InnerBorder do
      if (Filler <> aFrameDescriptor.Fillers[sfpInnerBorder]) and (Filler <> nil) then
        begin
          Filler.Free;
          Filler := nil;
        end;
    with InnerSpace do
      if (Filler <> aFrameDescriptor.Fillers[sfpInnerSpace]) and (Filler <> nil) then
        begin
          Filler.Free;
          Filler := nil;
        end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.Signature(Details: TThemedElementDetails; aRect: TRect): string;
begin
  result := inttostr(aRect.Right - aRect.Left) + '.' + inttostr(aRect.Bottom - aRect.Top) + '.' + inttostr(ord(Details.Element)) +'.' + inttostr(ord(Details.Part)) +'.' + inttostr(ord(Details.State));
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawGradientFramedFigure(DC: HDC; Bmp: TBitmap; aBoundsRect: TRect; var aContentsRect: TRect;
  ClipRect: TLMDRectPtr; aFrameD: TLMDGradientThemeFrameDescriptor; aFillD: TLMDGradientThemeFillDescriptor; aFrame: TLMDBaseGradientFrame; aFigure: TLMDFigure; aPixelFormat: TPixelFormat = pf24bit);
var
  lR2, lCR: TRect;
  lOldClpRgn, lRgn: HRGN;
  lFiller, lTmpFiller: TLMDFiller;
  cc: TLMDCornerCut;
  lrc: TLMDRectangleCorner;
  lgfp: TLMDGradientFillPart;
  i, cx, cy: integer;
  lc: TColor;
begin
  if IsRectEmpty(aBoundsRect) then
    exit;

  lRgn := 0;
  lOldClpRgn := 0;

  if ClipRect <> LMDNullRectPtr then
    begin
      lCr := ClipRect^;
      lRgn := CreateRectRgn(lCr.Left, lCr.Top, lCr.Right, lCr.Bottom);
      lOldClpRgn := SelectClipRgn(DC, lRGn);
    end;

  aFrame.OuterBorder.AntiAliasing := (aFrameD.Params[gfrpRenderMode] and cRM_OuterBorderAntiALiasing) = cRM_OuterBorderAntiALiasing;
  aFrame.InnerBorder.AntiAliasing := (aFrameD.Params[gfrpRenderMode] and cRM_InnerBorderAntiALiasing) = cRM_InnerBorderAntiALiasing;
  aFrame.InnerSpace.AntiAliasing := (aFrameD.Params[gfrpRenderMode] and cRM_InnerSpaceAntiALiasing) = cRM_InnerSpaceAntiALiasing;

  aFrame.OuterBorder.SoftEdge := (aFrameD.Params[gfrpRenderMode] and cRM_OuterBorderSoftEdge) = cRM_OuterBorderSoftEdge;
  aFrame.InnerBorder.SoftEdge := (aFrameD.Params[gfrpRenderMode] and cRM_InnerBorderSoftEdge) = cRM_InnerBorderSoftEdge;
  aFrame.InnerSpace.SoftEdge := (aFrameD.Params[gfrpRenderMode] and cRM_InnerSpaceSoftEdge) = cRM_InnerSpaceSoftEdge;

  //All frame's dimensions must be set first
  if aFrame is TLMDGradientRectFrame then
    SetRectFrameParams(TLMDGradientRectFrame(aFrame), aFrameD.Params);

  if aFrame is TLMDGradientCircleFrame then
    with TLMDGradientCircleFrame(aFrame) do
      begin
        OuterBorder.Width := aFrameD.Params[gfrpOuterBorderWidth];
        InnerBorder.Width := aFrameD.Params[gfrpInnerBorderWidth];
        SpaceWidth := aFrameD.Params[gfrpTopSpaceWidth];;
      end;

  with aFrame do
    begin
      //Then contents rect must be set
      aContentsRect := CalcContentsRect(aBoundsRect);
      ContentsRect := aContentsRect;
      //Then fillers must be prepared
      OuterBorder.Filler := PrepareFiller(aFrameD.Fillers[sfpOuterBorder], BoundsRect);
      InnerBorder.Filler := PrepareFiller(aFrameD.Fillers[sfpInnerBorder], InnerBorderRect);
      InnerSpace.Filler := PrepareFiller(aFrameD.Fillers[sfpInnerSpace], OuterBorderRect);
    end;

  lgfp := gfpMain;

  lFiller := aFillD.Fillers[lgfp];
  if (lFiller <> nil) then
    begin
      //Chooses a filler of the same class from the FToolBoxFiller list and
      //copies its params in lTmpFiller
      if ((aFillD.Params[gflpRenderMode] and 3) = 0) then
        lTmpFiller := PrepareFillerFrom(lFiller)
      else
        begin
          lTmpFiller := TLMDSolidFiller(FFillerToolBox.Objects[0]);
          lc := clNone;
          if not(lFiller is TLMDContainerFiller) then
            lc := lFiller.FixedColors[0]
          else
            for i := 0 to TLMDContainerFiller(lFiller).Count - 1 do
              if not (TLMDContainerFiller(lFiller).Item[i] is TLMDContainerFiller) then
                begin
                  lc := TLMDContainerFiller(lFiller).Item[i].FixedColors[0];
                  break;
                end;
          lTmpFiller.FixedColors[0] := lc;
        end;

      //note for composite fillers:
      //1) set filler
      //2) set rectangle for figure
      //3) set item rects and other params
      with aFigure do
        begin
          Filler := lTmpFiller;
          BorderWidth := 0;
          lR2 := aContentsRect;

          if aFigure is TLMDCustomCutRectangle then
            with TLMDCustomCutRectangle(aFigure) do
              begin
                cc := LMDByteToCornerCut(aFrameD.Params[gfrpInnerBorderInnerCutType]);
                for lrc := low(TLMDRectangleCorner) to high(TLMDRectangleCorner) do
                  CornerCut[lrc] := cc[lrc];
                with aFrameD do
                  LMDCalcCutValues(cx, cy,
                    Params[gfrpInnerBorderInnerCutX],
                    Params[gfrpInnerBorderInnerCutY],
                    TLMDValueType(Params[gfrpInnerBorderInnerCutXValueType]),
                    TLMDValueType(Params[gfrpInnerBorderInnerCutYValueType]),
                    TLMDCutValueUsage(Params[gfrpCutValueUsage]),
                    aContentsRect);
                CutX := cx;
                CutY := cy;
                with TLMDGradientRectFrame(aFrame) do
                  begin
                    if not (fsLeft in OuterBorderSides) then
                      lR2.Left := lR2.Left - OuterBorder.Width;
                    if not (fsLeft in InnerBorderSides) then
                      lR2.Left := lR2.Left - InnerBorder.Width - LeftSpaceWidth;
                    if not (fsTop in OuterBorderSides) then
                      lR2.Top := lR2.Top - OuterBorder.Width;
                    if not (fsTop in InnerBorderSides) then
                      lR2.Top := lR2.Top - InnerBorder.Width - TopSpaceWidth;
                    if not (fsRight in OuterBorderSides) then
                      lR2.Right := lR2.Right + OuterBorder.Width;
                    if not (fsRight in InnerBorderSides) then
                      lR2.Right := lR2.Right + InnerBorder.Width + RightSpaceWidth;
                    if not (fsBottom in OuterBorderSides) then
                      lR2.Bottom := lR2.Bottom + OuterBorder.Width;
                    if not (fsBottom in InnerBorderSides) then
                      lR2.Bottom := lR2.Bottom + InnerBorder.Width + BottomSpaceWidth;
                  end;
                Rectangle(lR2);
              end
          else
            if aFigure is TLMDCircle then
              with TLMDCircle(aFigure) do
                begin
                  Center := TLMDGradientCircleFrame(aFrame).ContentsCenter;
                  Radius := TLMDGradientCircleFrame(aFrame).ContentsRadius;
                end;

          //This takes non-color params (BasePoint, VectorN, VectorT etc) from
          //lFiller and calculates them into Filler params relatively to LR2 rect
          //e.g. if BasePoint = (10,10) then it will be 10% of LR2's width and
          //10% of LR2's height taken from LR2.TopLeft
          if Filler.UseRelativeUnits then
            SetFillerParams(Filler, lFiller, lR2);

          AntiAliasing := (aFillD.Params[gflpRenderMode] and 4) = 4;

          if DC <> 0 then
            Draw(DC, aPixelFormat);
          if Bmp <> nil then
            Draw(Bmp, aPixelFormat);
        end;
    end;

  if DC <> 0 then
     aFrame.Draw(DC, aContentsRect, aPixelFormat);
  if Bmp <> nil then
     aFrame.Draw(Bmp, aContentsRect, aPixelFormat);

  FinalizeFrameFillers(aFrame, aFrameD);

  if ClipRect <> LMDNullRectPtr then
    begin
      SelectClipRgn(DC, lOldClpRgn);
      DeleteObject(lRgn);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.CloneDescriptor(var aFldDest,
  aFldSrc: TLMDGradientThemeFillDescriptor);
var
  flp: TLMDGradientFillPart;
begin
  for flp := low(TLMDGradientFillPart) to high(TLMDGradientFillPart) do
    begin
      if aFldDest.Fillers[flp] <> nil then
        begin
          aFldDest.Fillers[flp].Free;
          aFldDest.Fillers[flp] := nil;
        end;
      if aFldSrc.Fillers[flp] <> nil then
        aFldDest.Fillers[flp] := aFldSrc.Fillers[flp].Clone
      else
        aFldDest.Fillers[flp] := nil;
    end;
  aFldDest.Params := aFldSrc.Params;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.CloneDescriptor(var aFrdDest,
  aFrdSrc: TLMDGradientThemeFrameDescriptor);
var
  frp: TLMDGradientSimpleFramePartKind;
begin
  for frp := low(TLMDGradientSimpleFramePartKind) to high(TLMDGradientSimpleFramePartKind) do
    begin
      if aFrdDest.Fillers[frp] <> nil then
        begin
          aFrdDest.Fillers[frp].Free;
          aFrdDest.Fillers[frp] := nil;
        end;
      if aFrdSrc.Fillers[frp] <> nil then
        aFrdDest.Fillers[frp] := aFrdSrc.Fillers[frp].Clone
      else
        aFrdDest.Fillers[frp] := nil;
    end;
  aFrdDest.Params := aFrdSrc.Params;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawSimpleFrame(DC: HDC;
  Bmp: TBitmap; aBoundsRect: TRect; var aContentsRect: TRect;
  ClipRect: TLMDRectPtr; aFrameD: TLMDGradientThemeFrameDescriptor);

  procedure DrawTo(aDC: HDC);
  var
    loldpen, lpen: HPEN;
    cl: TColor;
  begin
    if aFrameD.Fillers[sfpOuterBorder] <> nil then
      cl := aFrameD.Fillers[sfpOuterBorder].FixedColors[0]
    else
      cl := clGray;
    lpen := CreatePen(PS_SOLID, 1, cl);
    lOldPen := SelectObject(DC, lPen);
    if (aFrameD.Params[gfrpOuterBorderOuterCutType] = 0) or (aFrameD.Params[gfrpOuterBorderOuterCutX] = 0) then
      Rectangle(DC, aBoundsRect.Left, aBoundsRect.Top, aBoundsRect.Right, aBoundsRect.Bottom)
    else
      RoundRect(DC, aBoundsRect.Left, aBoundsRect.Top, aBoundsRect.Right, aBoundsRect.Bottom, aFrameD.Params[gfrpOuterBorderOuterCutX] + 3, aFrameD.Params[gfrpOuterBorderOuterCutX] + 3);
    SelectObject(DC, lOldPen);
    DeleteObject(lPen);

    if aFrameD.Fillers[sfpOuterBorder] <> nil then
      cl := aFrameD.Fillers[sfpInnerBorder].FixedColors[0]
    else
      cl := clWhite;
    lpen := CreatePen(PS_SOLID, 1, cl);
    lOldPen := SelectObject(DC, lPen);
    InflateRect(aBoundsRect, -1, -1);
    if (aFrameD.Params[gfrpOuterBorderOuterCutType] = 0) or (aFrameD.Params[gfrpOuterBorderOuterCutX] = 0) then
      Rectangle(DC, aBoundsRect.Left, aBoundsRect.Top, aBoundsRect.Right, aBoundsRect.Bottom)
    else
      RoundRect(DC, aBoundsRect.Left, aBoundsRect.Top, aBoundsRect.Right, aBoundsRect.Bottom, aFrameD.Params[gfrpOuterBorderOuterCutX], aFrameD.Params[gfrpOuterBorderOuterCutX]);
    SelectObject(DC, lOldPen);
    DeleteObject(lPen);
  end;

begin
  aContentsRect := aBoundsRect;
  InflateRect(aContentsRect, -2, -2);
  if DC <>0 then
    DrawTo(DC);
  if Bmp <> nil then
    DrawTo(Bmp.Canvas.Handle);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawGradientArrow(DC: HDC;
  ARect: TRect; ADir: TLMDDirection; aState: TLMDThemedButtonState);
var
  w, h: integer;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawGradientArrow) then
    FOnDrawGradientArrow(Self, DC, aRect, aDir, aState, lExit);
  if not lExit then
  begin
    w := aRect.Right - aRect.Left;
    h := aRect.Bottom - aRect.Top;
    if aDir in [tdDown, tdUp] then
      begin
        FCCRectangle.CutX := h;
        FCCRectangle.CutY := h;
      end
    else
      begin
        FCCRectangle.CutX := w;
        FCCRectangle.CutY := w;
      end;
    case ADir of
      tdDown:
        begin
          FCCRectangle.CornerCut[rcTopLeft] := ctNone;
          FCCRectangle.CornerCut[rcTopRight] := ctNone;
          FCCRectangle.CornerCut[rcBottomLeft] := ctLine;
          FCCRectangle.CornerCut[rcBottomRight] := ctLine;
        end;
      tdUp:
        begin
          FCCRectangle.CornerCut[rcTopLeft] := ctLine;
          FCCRectangle.CornerCut[rcTopRight] := ctLine;
          FCCRectangle.CornerCut[rcBottomLeft] := ctNone;
          FCCRectangle.CornerCut[rcBottomRight] := ctNone;
        end;
      tdLeft:
        begin
          FCCRectangle.CornerCut[rcTopLeft] := ctLine;
          FCCRectangle.CornerCut[rcTopRight] := ctNone;
          FCCRectangle.CornerCut[rcBottomLeft] := ctLine;
          FCCRectangle.CornerCut[rcBottomRight] := ctNone;
        end;
      tdRight:
        begin
          FCCRectangle.CornerCut[rcTopLeft] := ctNone;
          FCCRectangle.CornerCut[rcTopRight] := ctLine;
          FCCRectangle.CornerCut[rcBottomLeft] := ctNone;
          FCCRectangle.CornerCut[rcBottomRight] := ctLine;
        end;
      end;
    FCCRectangle.Filler := FGradientArrowFiller[aDir, aState];
    FCCRectangle.Rectangle(aRect);
    //FCCRectangle.Filler := FGradientArrowFiller[aDir, aState];
    FCCRectangle.BorderWidth := 0;
    FCCRectangle.AntiAliasing := false;
    if FCCRectangle.Filler <> nil then
      FCCRectangle.Draw(DC, FPixelFormat);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.WriteFillerToXML(
  aFiller: TLMDFiller; aNode: ILMDXMLElement; AttrName:string = ''; AttrValue: string = '');
var
  i: integer;
  lNode, lColorsNode, lColorNode, lParamNode, lItemNode, lRectNode: ILMDXMLElement;
  nothvg: boolean;
begin
  if (aNode = nil) or (aFiller = nil) then
    exit;
  lNode := aNode.AppendElement('Filler');
  lNode.SetAttr('Class', aFiller.ClassName);
  nothvg := true;

  if (AttrName <> '') then
    lNode.SetAttr(AttrName, AttrValue);

  if aFiller.UseRelativeUnits then
    begin
      lParamNode := lNode.AppendElement('UseRelativeUnits');
      lParamNode.SetAttr('Value', inttostr(ord(aFiller.UseRelativeUnits)));
    end;

  if not (aFiller is TLMDContainerFiller) then
    begin
      if aFiller is TLMDSolidFiller then
        begin
          lColorNode := lNode.AppendElement('Color0');
          lColorNode.SetAttr('Value', ColorToString(aFiller.FixedColors[0]));
          if aFiller.FixedAlpha[0] <> 255 then
            lColorNode.SetAttr('Alpha', IntToStr(aFiller.FixedAlpha[0]));
        end
      else
        begin
          if (aFiller is TLMDVerticalGradient) or (aFiller is TLMDHorizontalGradient) then
            nothvg := false
          else
            begin
              lParamNode := lNode.AppendElement('BasePoint');
              lParamNode.SetAttr('X', inttostr(aFiller.BasePoint.X));
              lParamNode.SetAttr('Y', inttostr(aFiller.BasePoint.Y));
            end;

          if (aFiller is TLMDVerticalGradient) then
            begin
              //no params to store
            end
          else
            if (aFiller is TLMDHorizontalGradient) then
              begin
                //no params to store
              end
            else
              if aFiller is TLMDRoundFiller then
                begin
                  lParamNode := lNode.AppendElement('Radius');
                  lParamNode.SetAttr('Value', inttostr(TLMDRoundFiller(aFiller).Radius));
                end
              else
                if aFiller is TLMDEllipseFiller then
                  begin
                    lParamNode := lNode.AppendElement('Axis1');
                    lParamNode.SetAttr('Value', inttostr(TLMDEllipseFiller(aFiller).Axis1));
                    lParamNode := lNode.AppendElement('Axis2');
                    lParamNode.SetAttr('Value', inttostr(TLMDEllipseFiller(aFiller).Axis2));
                    lParamNode := lNode.AppendElement('FirstAxisDirection');
                    lParamNode.SetAttr('X', inttostr(TLMDEllipseFiller(aFiller).FirstAxisDirection.X));
                    lParamNode.SetAttr('Y', inttostr(TLMDEllipseFiller(aFiller).FirstAxisDirection.Y));
                  end
                else
                  if nothvg then
                    begin
                      lParamNode := lNode.AppendElement('VectorN');
                      lParamNode.SetAttr('X', inttostr(aFiller.VectorN.X));
                      lParamNode.SetAttr('Y', inttostr(aFiller.VectorN.Y));

                      lParamNode := lNode.AppendElement('VectorT');
                      lParamNode.SetAttr('X', inttostr(aFiller.VectorT.X));
                      lParamNode.SetAttr('Y', inttostr(aFiller.VectorT.Y));
                    end;

          lColorsNode := lNode.AppendElement('Colors');
          lColorsNode.SetAttr('ColorCount', inttostr(aFiller.ColorCount));

          for i := 0 to aFiller.ColorCount - 1 do
            begin
              lColorNode := lColorsNode.AppendElement('Color'+inttostr(i));
              lColorNode.SetAttr('Value', ColorToString(aFiller.FixedColors[i]));
              if aFiller.FixedAlpha[i] <> 255 then
                lColorNode.SetAttr('Alpha', IntToStr(aFiller.FixedAlpha[i]));
            end;
        end;
    end
  else
    begin
      lNode.SetAttr('ItemCount', inttostr(TLMDContainerFiller(aFiller).Count));
      with TLMDContainerFiller(aFiller) do
        for i := 0 to Count - 1 do
          begin
            lItemNode := lNode.AppendElement('Item');
            lItemNode.SetAttr('Index', InttoStr(i));
            if aFiller is TLMDMixedFiller then
              begin
                lItemNode.SetAttr('Weight', IntToStr(TLMDMixedFiller(aFiller).Weight[i]));
              end;
            if aFiller is TLMDCompositeFiller then
              begin
                lRectNode := lItemNode.AppendElement('FillerRect');
                lRectNode.SetAttr('Left', inttostr(TLMDCompositeFiller(aFiller).FillerRect[i].Left));
                lRectNode.SetAttr('Top', inttostr(TLMDCompositeFiller(aFiller).FillerRect[i].Top));
                lRectNode.SetAttr('Right', inttostr(TLMDCompositeFiller(aFiller).FillerRect[i].Right));
                lRectNode.SetAttr('Bottom', inttostr(TLMDCompositeFiller(aFiller).FillerRect[i].Bottom));
              end;
            WriteFillerToXML(TLMDContainerFiller(aFiller).Item[i], lItemNode)
          end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.ReadFillerFromXML(
  aNode: ILMDXMLElement): TLMDFiller;
var
  i, c: integer;
  lColorsNode, lColorNode, lParamNode, lItemNode, lFillerNode: ILMDXMLElement;
  lVal, lclassname: string;
  nothvg: boolean;
  R: TRect;
begin
  result := nil;
  if (aNode = nil) then
    exit;
  lclassname := aNode.GetAttr('Class', '');
  if lclassname = '' then
    begin
      result := nil;
      exit;
    end;

  i := FFillerToolBox.IndexOf(lclassname);
  if i < 0 then
    begin
      result := nil;
      exit;
    end;

  result := TLMDFiller(FFillerToolBox.Objects[i]).Clone(false);

  if result is TLMDContainerFiller then
    TLMDContainerFiller(result).Clear(true);

  nothvg := true;

  lParamNode := aNode.FindElement('UseRelativeUnits', '', '');
  if lParamNode <> nil then
    result.UseRelativeUnits := boolean(lParamNode.GetIntAttr('Value'))
  else
    result.UseRelativeUnits := false;

  if not (result is TLMDContainerFiller) then
    begin
      if result is TLMDSolidFiller then
        begin
          lColorNode := aNode.FindElement('Color0', '', '');
          if lColorNode <> nil then
            begin
              lval := lColorNode.GetAttr('Value', 'clNone');
              result.FixedColors[0] := stringtocolor(lval);
              result.FixedAlpha[0] := lColorNode.GetIntAttr('Alpha', 255);
            end;
        end
      else
        begin
          if (result is TLMDVerticalGradient) or (result is TLMDHorizontalGradient) then
            nothvg := false
          else
            begin
              lParamNode := aNode.FindElement('BasePoint', '', '');
              if lParamNode <> nil then
                result.BasePoint := Point(lParamNode.GetIntAttr('X'), lParamNode.GetIntAttr('Y'));
            end;

          if result is TLMDRoundFiller then
            begin
              lParamNode := aNode.FindElement('Radius', '', '');
              if lParamNode <> nil then
                TLMDRoundFiller(result).Radius := lParamNode.GetIntAttr('Value');
            end
          else
            if result is TLMDEllipseFiller then
              begin
                lParamNode := aNode.FindElement('Axis1', '', '');
                if lParamNode <> nil then
                  TLMDEllipseFiller(result).Axis1 := lParamNode.GetIntAttr('Value');
                lParamNode := aNode.FindElement('Axis2', '', '');
                if lParamNode <> nil then
                  TLMDEllipseFiller(result).Axis2 := lParamNode.GetIntAttr('Value');
                lParamNode := aNode.FindElement('FirstAxisDirection', '', '');
                if lParamNode <> nil then
                  TLMDEllipseFiller(result).FirstAxisDirection := Point(lParamNode.GetIntAttr('X'), lParamNode.GetIntAttr('Y')) ;
              end
            else
              if nothvg then
                begin
                  lParamNode := aNode.FindElement('VectorN', '', '');
                  if lParamNode <> nil then
                    TLMDEllipseFiller(result).VectorN := Point(lParamNode.GetIntAttr('X'), lParamNode.GetIntAttr('Y')) ;
                  lParamNode := aNode.FindElement('VectorT', '', '');
                  if lParamNode <> nil then
                    TLMDEllipseFiller(result).VectorT := Point(lParamNode.GetIntAttr('X'), lParamNode.GetIntAttr('Y')) ;
                end;

          lColorsNode := aNode.FindElement('Colors', '', '');
          if lColorsNode <> nil then
            begin
              result.ColorCount := lColorsNode.GetIntAttr('ColorCount');

              for i := 0 to result.ColorCount - 1 do
                begin
                  lColorNode := lColorsNode.FindElement('Color'+inttostr(i), '', '');
                  if lColorNode <> nil then
                    begin
                      lval := lColorNode.GetAttr('Value', 'clNone');
                      result.FixedColors[i] := stringtocolor(lval);
                      result.FixedAlpha[i] := lColorNode.GetIntAttr('Alpha', 255);
                    end
                end
            end
        end
    end
  else
    begin
      c := aNode.GetIntAttr('ItemCount');
      with TLMDContainerFiller(result) do
        for i := 0 to c - 1 do
          begin
            lItemNode := aNode.FindElement('Item', 'Index', inttostr(i));
            if lItemNode = nil then
              continue;

            lFillerNode := lItemNode.FindElement('Filler', '', '');
            if lFillerNode <> nil then
              TLMDContainerFiller(result).Add(ReadFillerFromXML(lFillerNode));

            if result is TLMDMixedFiller then
              TLMDMixedFiller(result).Weight[i] := lItemNode.GetIntAttr('Weight', 255);
            if result is TLMDCompositeFiller then
              begin
                lParamNode := lItemNode.FindElement('FillerRect', '', '');
                if lParamNode <> nil then
                  begin
                    R.Left := lParamNode.GetIntAttr('Left');
                    R.Right := lParamNode.GetIntAttr('Right');
                    R.Top := lParamNode.GetIntAttr('Top');
                    R.Bottom := lParamNode.GetIntAttr('Bottom');
                    TLMDCompositeFiller(result).FillerRect[i] := R;
                  end;
              end;
          end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.WriteFillDescriptorToXML(
  aFillD: TLMDGradientThemeFillDescriptor; aDetail: ILMDXMLElement);
var
  lFillDNode, lFillersNode, lParamsNode, lParamNode: ILMDXMLElement;
  lflp: TLMDGradientThemeFillParam;
  gfp: TLMDGradientFillPart;
  s: string;
begin
  lFillDNode := aDetail.AppendElement('FillDescriptor');
  lParamsNode := lFillDNode.AppendElement('Params');
  for lflp := low(TLMDGradientThemeFillParam) to high(TLMDGradientThemeFillParam) do
    if aFillD.Params[lflp] <> 0 then
      begin
        s := getEnumName(TypeInfo(TLMDGradientThemeFillParam), ord(lflp));
        lParamNode := lParamsNode.AppendElement(s);
        lParamNode.SetAttr('Value', inttostr(aFillD.Params[lflp]));
      end;
  lFillersNode := lFillDNode.AppendElement('Fillers');
  for gfp := low(TLMDGradientFillPart) to high(TLMDGradientFillPart) do
    if aFillD.Fillers[gfp] <> nil then
      WriteFillerToXML(aFillD.Fillers[gfp], lFillersNode, 'Part', getEnumName(typeInfo(TLMDGradientFillPart), ord(gfp)));
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.WriteFrameDescriptorToXML(
  aFrameD: TLMDGradientThemeFrameDescriptor; aDetail: ILMDXMLElement);
var
  lFrameDNode, lFillersNode, lParamsNode, lParamNode: ILMDXMLElement;
  lfrp: TLMDGradientThemeFrameParam;
  gfrp: TLMDGradientSimpleFramePartKind;
  s: string;
begin
  lFrameDNode := aDetail.AppendElement('FrameDescriptor');
  lParamsNode := lFrameDNode.AppendElement('Params');
  for lfrp := low(TLMDGradientThemeFrameParam) to high(TLMDGradientThemeFrameParam) do
    if aFrameD.Params[lfrp] <> 0 then
      begin
        s := getEnumName(TypeInfo(TLMDGradientThemeFrameParam), ord(lfrp));
        lParamNode := lParamsNode.AppendElement(s);
        lParamNode.SetAttr('Value', inttostr(aFrameD.Params[lfrp]));
      end;
  lFillersNode := lFrameDNode.AppendElement('Fillers');
  for gfrp := low(TLMDGradientSimpleFramePartKind) to high(TLMDGradientSimpleFramePartKind) do
    if aFrameD.Fillers[gfrp] <> nil then
      WriteFillerToXML(aFrameD.Fillers[gfrp], lFillersNode, 'Part', getEnumName(typeInfo(TLMDGradientSimpleFramePartKind), ord(gfrp)));
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.WriteTextDescriptorToXML(
  aTextD: TLMDGradientThemeTextDescriptor; aDetail: ILMDXMLElement);
var
  lTextDNode, lFontNode, lColorNode: ILMDXMLElement;
begin
  lTextDNode := aDetail.AppendElement('TextDescriptor');
  lFontNode := lTextDNode.AppendElement('Font');
  lColorNode := lTextDNode.AppendElement('Color');
  lColorNode.SetAttr('Value', ColorToString(aTextD.Color));
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.ReadFillDescriptorFromXML(var
  aFillD: TLMDGradientThemeFillDescriptor; aDetailNode: ILMDXMLElement);
var
  lFillersNode, lFillerNode, lParamsNode, lParamNode: ILMDXMLElement;
  lflp: TLMDGradientThemeFillParam;
  gfp: TLMDGradientFillPart;
  s: string;
begin
  lParamsNode := aDetailNode.FindElement('Params', '', '');
  if lParamsNode <> nil then
    for lflp := low(TLMDGradientThemeFillParam) to high(TLMDGradientThemeFillParam) do
      begin
        s := getEnumName(TypeInfo(TLMDGradientThemeFillParam), ord(lflp));
        lParamNode := lParamsNode.FindElement(s, '', '');
        if lParamNode <> nil then
          aFillD.Params[lflp] := lParamNode.GetIntAttr('Value')
        else
          aFillD.Params[lflp] := 0;
      end;
  lFillersNode := aDetailNode.FindElement('Fillers', '', '');
  if lFillersNode <> nil then
    for gfp := low(TLMDGradientFillPart) to high(TLMDGradientFillPart) do
      begin
        s := getEnumName(TypeInfo(TLMDGradientFillPart), ord(gfp));
        lFillerNode := lFillersNode.FindElement('Filler', 'Part', s);
        if lFillerNode <> nil then
          aFillD.Fillers[gfp] := ReadFillerFromXML(lFillerNode);
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.ReadFrameDescriptorFromXML(var
  aFrameD: TLMDGradientThemeFrameDescriptor; aDetailNode: ILMDXMLElement);
var
  lFillerNode, lFillersNode, lParamsNode, lParamNode: ILMDXMLElement;
  lfrp: TLMDGradientThemeFrameParam;
  gfrp: TLMDGradientSimpleFramePartKind;
  s: string;
begin
  lParamsNode := aDetailNode.FindElement('Params', '', '');
  if lParamsNode <> nil then
    for lfrp := low(TLMDGradientThemeFrameParam) to high(TLMDGradientThemeFrameParam) do
      begin
        s := getEnumName(TypeInfo(TLMDGradientThemeFrameParam), ord(lfrp));
        lParamNode := lParamsNode.FindElement(s, '', '');
        if lParamNode <> nil then
          aFrameD.Params[lfrp] := lParamNode.GetIntAttr('Value')
        else
          aFrameD.Params[lfrp] := 0;
      end;
  lFillersNode := aDetailNode.FindElement('Fillers', '', '');
  if lFillersNode <> nil then
    for gfrp := low(TLMDGradientSimpleFramePartKind) to high(TLMDGradientSimpleFramePartKind) do
      begin
        s := getEnumName(TypeInfo(TLMDGradientSimpleFramePartKind), ord(gfrp));
        lFillerNode := lFillersNode.FindElement('Filler', 'Part', s);
        if lFillerNode <> nil then
          aFrameD.Fillers[gfrp] := ReadFillerFromXML(lFillerNode);
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.ReadTextDescriptorFromXML(var
  aTextD: TLMDGradientThemeTextDescriptor; aDetailNode: ILMDXMLElement);
var
  lFontNode, lColorNode: ILMDXMLElement;
begin
  lFontNode := aDetailNode.FindElement('Params', '', '');
  if lFontNode <> nil then
    begin
      //TODO
    end;
  lColorNode := aDetailNode.FindElement('Color', '', '');
  if lColorNode <> nil then
    aTextD.Color := StringToColor(lColorNode.GetAttr('Value', 'clNone'));
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.ClearDescriptorFillers(var aFld:
  TLMDGradientThemeFillDescriptor);
var
  flp: TLMDGradientFillPart;
begin
  for flp := low(TLMDGradientFillPart) to high(TLMDGradientFillPart) do
    if aFld.Fillers[flp] <> nil then
      FreeAndNil(aFld.Fillers[flp]);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.ClearCache;
var
  i: integer;
begin
  for i := 0 to FBmpCache.Count - 1 do
    FBmpCache.Objects[i].Free;
  FBmpCache.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.ClearDescriptorFillers(var aFrd:
  TLMDGradientThemeFrameDescriptor);
var
  frp: TLMDGradientSimpleFramePartKind;
begin
  for frp := low(TLMDGradientSimpleFramePartKind) to high(TLMDGradientSimpleFramePartKind) do
    if aFrd.Fillers[frp] <> nil then
      FreeAndNil(aFrd.Fillers[frp]);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetButtonFillFiller(
  index: TThemedButton; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FButtonFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetButtonFillParam(
  index: TThemedButton;
  param: TLMDGradientThemeFillParam): byte;
begin
  result := FButtonFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetButtonFrameFiller(
  index: TThemedButton; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FButtonFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetButtonFrameParam(
  index: TThemedButton;
  param: TLMDGradientThemeFrameParam): byte;
begin
  result := FButtonFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetButtonFillFiller(
  index: TThemedButton; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FButtonFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetButtonFillParam(
  index: TThemedButton; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FButtonFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetButtonFrameFiller(
  index: TThemedButton; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FButtonFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetButtonFrameParam(
  index: TThemedButton; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FButtonFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetButtonFill(
  index: TThemedButton): TLMDGradientThemeFillDescriptor;
begin
  result := FButtonFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetButtonFrame(
  index: TThemedButton): TLMDGradientThemeFrameDescriptor;
begin
  result := FButtonFrame[index];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetButtonFill(index: TThemedButton;
  const Value: TLMDGradientThemeFillDescriptor);
begin
  FButtonFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetButtonFrame(
  index: TThemedButton; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FButtonFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetComboBoxFill(
  index: TThemedComboBox): TLMDGradientThemeFillDescriptor;
begin
  result := FComboBoxFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetComboBoxFillFiller(
  index: TThemedComboBox; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FComboBoxFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetComboBoxFillParam(
  index: TThemedComboBox; param: TLMDGradientThemeFillParam): byte;
begin
  result := FComboBoxFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetComboBoxFrame(
  index: TThemedComboBox): TLMDGradientThemeFrameDescriptor;
begin
  result := FComboBoxFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetComboBoxFrameFiller(
  index: TThemedComboBox; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FComboBoxFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetComboBoxFrameParam(
  index: TThemedComboBox; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FComboBoxFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetComboBoxFill(
  index: TThemedComboBox; const Value: TLMDGradientThemeFillDescriptor);
begin
  FComboBoxFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetComboBoxFillFiller(
  index: TThemedComboBox; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FComboBoxFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetComboBoxFillParam(
  index: TThemedComboBox; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FComboBoxFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetComboBoxFrame(
  index: TThemedComboBox; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FComboBoxFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetComboBoxFrameFiller(
  index: TThemedComboBox; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FComboBoxFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetComboBoxFrameParam(
  index: TThemedComboBox; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FComboBoxFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetEditFill(
  index: TThemedEdit): TLMDGradientThemeFillDescriptor;
begin
  result := FEditFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetEditFillFiller(
  index: TThemedEdit; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FEditFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetEditFillParam(
  index: TThemedEdit; param: TLMDGradientThemeFillParam): byte;
begin
  result := FEditFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetEditFrame(
  index: TThemedEdit): TLMDGradientThemeFrameDescriptor;
begin
  result := FEditFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetEditFrameFiller(
  index: TThemedEdit; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FEditFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetEditFrameParam(
  index: TThemedEdit; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FEditFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetEditFill(
  index: TThemedEdit; const Value: TLMDGradientThemeFillDescriptor);
begin
  FEditFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetEditFillFiller(
  index: TThemedEdit; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FEditFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetEditFillParam(
  index: TThemedEdit; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FEditFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetEditFrame(
  index: TThemedEdit; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FEditFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetEditFrameFiller(
  index: TThemedEdit; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FEditFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetEditFrameParam(
  index: TThemedEdit; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FEditFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetSpinBtnFill(
  index: TThemedSpin): TLMDGradientThemeFillDescriptor;
begin
  result := FSpinBtnFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetSpinBtnFillFiller(
  index: TThemedSpin; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FSpinBtnFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetSpinBtnFillParam(
  index: TThemedSpin; param: TLMDGradientThemeFillParam): byte;
begin
  result := FSpinBtnFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetSpinBtnFrame(
  index: TThemedSpin): TLMDGradientThemeFrameDescriptor;
begin
  result := FSpinBtnFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetSpinBtnFrameFiller(
  index: TThemedSpin; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FSpinBtnFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetSpinBtnFrameParam(
  index: TThemedSpin; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FSpinBtnFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetSpinBtnFill(
  index: TThemedSpin; const Value: TLMDGradientThemeFillDescriptor);
begin
  FSpinBtnFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetSpinBtnFillFiller(
  index: TThemedSpin; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FSpinBtnFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetSpinBtnFillParam(
  index: TThemedSpin; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FSpinBtnFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetSpinBtnFrame(
  index: TThemedSpin; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FSpinBtnFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetSpinBtnFrameFiller(
  index: TThemedSpin; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FSpinBtnFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetSpinBtnFrameParam(
  index: TThemedSpin; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FSpinBtnFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetToolbarFill(
  index: TThemedToolbar): TLMDGradientThemeFillDescriptor;
begin
  result := FToolbarFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetToolbarFillFiller(
  index: TThemedToolbar; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FToolbarFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetToolbarFillParam(
  index: TThemedToolbar; param: TLMDGradientThemeFillParam): byte;
begin
  result := FToolbarFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetToolbarFrame(
  index: TThemedToolbar): TLMDGradientThemeFrameDescriptor;
begin
  result := FToolbarFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetToolbarFrameFiller(
  index: TThemedToolbar; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FToolbarFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetToolbarFrameParam(
  index: TThemedToolbar; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FToolbarFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetToolbarFill(
  index: TThemedToolbar; const Value: TLMDGradientThemeFillDescriptor);
begin
  FToolbarFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetToolbarFillFiller(
  index: TThemedToolbar; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FToolbarFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetToolbarFillParam(
  index: TThemedToolbar; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FToolbarFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetToolbarFrame(
  index: TThemedToolbar; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FToolbarFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetToolbarFrameFiller(
  index: TThemedToolbar; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FToolbarFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetToolbarFrameParam(
  index: TThemedToolbar; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FToolbarFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetScrollBarFill(
  index: TThemedScrollBar): TLMDGradientThemeFillDescriptor;
begin
  result := FScrollBarFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetScrollBarFillFiller(
  index: TThemedScrollBar; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FScrollBarFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetScrollBarFillParam(
  index: TThemedScrollBar; param: TLMDGradientThemeFillParam): byte;
begin
  result := FScrollBarFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetScrollBarFrame(
  index: TThemedScrollBar): TLMDGradientThemeFrameDescriptor;
begin
  result := FScrollBarFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetScrollBarFrameFiller(
  index: TThemedScrollBar; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FScrollBarFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetScrollBarFrameParam(
  index: TThemedScrollBar; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FScrollBarFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetScrollBarFill(
  index: TThemedScrollBar; const Value: TLMDGradientThemeFillDescriptor);
begin
  FScrollBarFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetScrollBarFillFiller(
  index: TThemedScrollBar; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FScrollBarFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetScrollBarFillParam(
  index: TThemedScrollBar; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FScrollBarFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetScrollBarFrame(
  index: TThemedScrollBar; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FScrollBarFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetScrollBarFrameFiller(
  index: TThemedScrollBar; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FScrollBarFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetScrollBarFrameParam(
  index: TThemedScrollBar; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FScrollBarFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTabFill(
  index: TThemedTab): TLMDGradientThemeFillDescriptor;
begin
  result := FTabFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTabFillFiller(
  index: TThemedTab; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FTabFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTabFillParam(
  index: TThemedTab; param: TLMDGradientThemeFillParam): byte;
begin
  result := FTabFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTabFrame(
  index: TThemedTab): TLMDGradientThemeFrameDescriptor;
begin
  result := FTabFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTabFrameFiller(
  index: TThemedTab; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FTabFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTabFrameParam(
  index: TThemedTab; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FTabFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTabFill(
  index: TThemedTab; const Value: TLMDGradientThemeFillDescriptor);
begin
  FTabFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTabFillFiller(
  index: TThemedTab; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FTabFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTabFillParam(
  index: TThemedTab; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FTabFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTabFrame(
  index: TThemedTab; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FTabFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTabFrameFiller(
  index: TThemedTab; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FTabFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTabFrameParam(
  index: TThemedTab; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FTabFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetProgressFill(
  index: TThemedProgress): TLMDGradientThemeFillDescriptor;
begin
  result := FProgressFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetProgressFillFiller(
  index: TThemedProgress; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FProgressFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetProgressFillParam(
  index: TThemedProgress; param: TLMDGradientThemeFillParam): byte;
begin
  result := FProgressFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetProgressFrame(
  index: TThemedProgress): TLMDGradientThemeFrameDescriptor;
begin
  result := FProgressFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetProgressFrameFiller(
  index: TThemedProgress; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FProgressFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetProgressFrameParam(
  index: TThemedProgress; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FProgressFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetPixelFormat(
  const Value: TPixelFormat);
begin
  if FPixelFormat <> Value then
    begin
      if FPixelFormat in [pf24bit, pf32bit] then
        begin
          FPixelFormat := Value;
          if not FIsUpdating and not SuppressUpdate then
            begin
              ClearCache;
              LMDThemeServices.ApplyThemeChange;
            end;
        end
      else
        raise Exception.Create('Pixel format must be pf24bit or pf32bit!');
    end;
end;

procedure TLMDBaseGradientThemeRenderer.SetProgressFill(
  index: TThemedProgress; const Value: TLMDGradientThemeFillDescriptor);
begin
  FProgressFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetProgressFillFiller(
  index: TThemedProgress; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FProgressFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetProgressFillParam(
  index: TThemedProgress; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FProgressFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetProgressFrame(
  index: TThemedProgress; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FProgressFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetProgressFrameFiller(
  index: TThemedProgress; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FProgressFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetProgressFrameParam(
  index: TThemedProgress; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FProgressFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetHeaderFill(
  index: TThemedHeader): TLMDGradientThemeFillDescriptor;
begin
  result := FHeaderFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetHeaderFillFiller(
  index: TThemedHeader; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FHeaderFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetHeaderFillParam(
  index: TThemedHeader; param: TLMDGradientThemeFillParam): byte;
begin
  result := FHeaderFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetHeaderFrame(
  index: TThemedHeader): TLMDGradientThemeFrameDescriptor;
begin
  result := FHeaderFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetHeaderFrameFiller(
  index: TThemedHeader; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FHeaderFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetHeaderFrameParam(
  index: TThemedHeader; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FHeaderFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetHeaderFill(
  index: TThemedHeader; const Value: TLMDGradientThemeFillDescriptor);
begin
  FHeaderFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetHeaderFillFiller(
  index: TThemedHeader; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FHeaderFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetHeaderFillParam(
  index: TThemedHeader; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FHeaderFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetHeaderFrame(
  index: TThemedHeader; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FHeaderFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetHeaderFrameFiller(
  index: TThemedHeader; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FHeaderFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetHeaderFrameParam(
  index: TThemedHeader; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FHeaderFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTrackBarFill(
  index: TThemedTrackBar): TLMDGradientThemeFillDescriptor;
begin
  result := FTrackBarFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTrackBarFillFiller(
  index: TThemedTrackBar; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FTrackBarFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTrackBarFillParam(
  index: TThemedTrackBar; param: TLMDGradientThemeFillParam): byte;
begin
  result := FTrackBarFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTrackBarFrame(
  index: TThemedTrackBar): TLMDGradientThemeFrameDescriptor;
begin
  result := FTrackBarFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTrackBarFrameFiller(
  index: TThemedTrackBar; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FTrackBarFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTrackBarFrameParam(
  index: TThemedTrackBar; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FTrackBarFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTrackBarFill(
  index: TThemedTrackBar; const Value: TLMDGradientThemeFillDescriptor);
begin
  FTrackBarFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTrackBarFillFiller(
  index: TThemedTrackBar; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FTrackBarFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTrackBarFillParam(
  index: TThemedTrackBar; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FTrackBarFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTrackBarFrame(
  index: TThemedTrackBar; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FTrackBarFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTrackBarFrameFiller(
  index: TThemedTrackBar; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FTrackBarFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTrackBarFrameParam(
  index: TThemedTrackBar; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FTrackBarFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetStatusBarFill(
  index: TThemedStatus): TLMDGradientThemeFillDescriptor;
begin
  result := FStatusBarFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetStatusBarFillFiller(
  index: TThemedStatus; flp: TLMDGradientFillPart): TLMDFiller;
begin
  result := FStatusBarFill[index].Fillers[flp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetStatusBarFillParam(
  index: TThemedStatus; param: TLMDGradientThemeFillParam): byte;
begin
  result := FStatusBarFill[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetStatusBarFrame(
  index: TThemedStatus): TLMDGradientThemeFrameDescriptor;
begin
  result := FStatusBarFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetStatusBarFrameFiller(
  index: TThemedStatus; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FStatusBarFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetStatusBarFrameParam(
  index: TThemedStatus; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FStatusBarFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetSuppressUpdate: boolean;
begin
  result := FSuppressUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetStatusBarFill(
  index: TThemedStatus; const Value: TLMDGradientThemeFillDescriptor);
begin
  FStatusBarFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetStatusBarFillFiller(
  index: TThemedStatus; flp: TLMDGradientFillPart;
  const Value: TLMDFiller);
begin
  FStatusBarFill[index].Fillers[flp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetStatusBarFillParam(
  index: TThemedStatus; param: TLMDGradientThemeFillParam;
  const Value: byte);
begin
  FStatusBarFill[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetStatusBarFrame(
  index: TThemedStatus; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FStatusBarFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetStatusBarFrameFiller(
  index: TThemedStatus; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FStatusBarFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetStatusBarFrameParam(
  index: TThemedStatus; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FStatusBarFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetSuppressUpdate(
  const Value: boolean);
begin
  FSuppressUpdate := Value;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTreeviewFrame(
  index: TThemedTreeview): TLMDGradientThemeFrameDescriptor;
begin
  result := FTreeviewFrame[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTreeviewFrameFiller(
  index: TThemedTreeview; frp: TLMDGradientSimpleFramePartKind): TLMDFiller;
begin
  result := FTreeviewFrame[index].Fillers[frp];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetTreeviewFrameParam(
  index: TThemedTreeview; param: TLMDGradientThemeFrameParam): byte;
begin
  result := FTreeviewFrame[index].Params[param];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetUseCache: boolean;
begin
   result := FUseCache;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTreeviewFrame(
  index: TThemedTreeview; const Value: TLMDGradientThemeFrameDescriptor);
begin
  FTreeviewFrame[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTreeviewFrameFiller(
  index: TThemedTreeview; frp: TLMDGradientSimpleFramePartKind;
  const Value: TLMDFiller);
begin
  FTreeviewFrame[index].Fillers[frp] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetTreeviewFrameParam(
  index: TThemedTreeview; param: TLMDGradientThemeFrameParam;
  const Value: byte);
begin
  FTreeviewFrame[index].Params[param] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetUseCache(const Value: boolean);
begin
  FUseCache := value;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetGradientArrowFiller(
  index: TLMDDirection; btns: TLMDThemedButtonState): TLMDFiller;
begin
  result := FGradientArrowFiller[index, btns];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetGradientArrowFiller(
  index: TLMDDirection; btns: TLMDThemedButtonState; const Value: TLMDFiller);
begin
  FGradientArrowFiller[index, btns] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetCheckMarkFill(
  index: boolean): TLMDGradientThemeFillDescriptor;
begin
  result := FCheckMarkFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetMixedMarkFill(
  index: boolean): TLMDGradientThemeFillDescriptor;
begin
  result := FMixedMarkFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetRadioBtnCheckMarkFill(
  index: boolean): TLMDGradientThemeFillDescriptor;
begin
  result := FRadioBtnCheckMarkFill[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetSimpleArrowColors(
  index: boolean): TColor;
begin
  result := FSimpleArrowColors[index];
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetSimpleArrowShadowColors(
  index: boolean): TColor;
begin
  result := FSimpleArrowShadowColors[index];
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetCheckMarkFill(index: boolean;
  const Value: TLMDGradientThemeFillDescriptor);
begin
  FCheckMarkFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetMixedMarkFill(index: boolean;
  const Value: TLMDGradientThemeFillDescriptor);
begin
  FMixedMarkFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetRadioBtnCheckMarkFill(
  index: boolean; const Value: TLMDGradientThemeFillDescriptor);
begin
  FRadioBtnCheckMarkFill[index] := Value;
  DoUpdateTheme;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetSimpleArrowColors(
  index: boolean; const Value: TColor);
begin
  FSimpleArrowColors[index] := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetSimpleArrowShadowColors(
  index: boolean; const Value: TColor);
begin
  FSimpleArrowShadowColors[index] := Value;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.ReloadFromInternalXML: boolean;
begin
  result := LoadColorSchemeFromXML(FXmlDoc, '');
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.SaveThemeToStream(
  aStream: TStream): boolean;
begin
  try
    if FXmlDoc <> nil then
      begin
        FXmlDoc.Save(aStream);
        result := true;
      end
    else
      result := false;
  except
    result := false;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.SaveThemeToFile(aFileName: TLMDString): boolean;
begin
  try
    if FXmlDoc <> nil then
      begin
        FXmlDoc.Save(aFileName);
        result := true;
      end
    else
      result := false;
  except
    result := false;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.RegisterMetaData(
  aElementTypeInfo: PTypeInfo; aMetaData: Pointer);
begin
  FMetaDataPool.AddObject(string(aElementTypeInfo.Name), aMetaData);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.SetEnabled(aValue: boolean);
begin
  if aValue then
  begin
    if FThemeName <> '' then
      FEnabled := ActivateTheme(FThemeName, FColorSchemeName)
    else
      FEnabled := ActivateDefaultTheme;
  end
  else
    DeactivateTheme;
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetActiveColorSchemeName: TLMDString;
begin
  result := TLMDString(FColorSchemeName);
end;

{------------------------------------------------------------------------------}
function TLMDBaseGradientThemeRenderer.GetActiveThemeName: TLMDString;
begin
  result := TLMDString(FThemeName);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseGradientThemeRenderer.DrawScrollThumbGripper(DC: HDC;
  aRect: TRect; Detail: TThemedScrollBar);
var
  lPen1, lPen2, lOldPen: HPEN;
  p: TPoint;
  i: integer;
  lExit: boolean;
begin
  lExit := false;
  if Assigned(FOnDrawScrollThumbGripper) then
    FOnDrawScrollThumbGripper(Self, DC, aRect, Detail, lExit);
  if not lExit then
  begin
    if Detail in [tsThumbBtnHorzNormal..tsThumbBtnVertDisabled] then
    begin
      lPen1 := CreatePen(PS_SOLID, 1, $00908781);
      lPen2 := CreatePen(PS_SOLID, 1, $00E5DAD0);
      lOldPen := SelectObject(DC, lPen1);
      p := LMDMiddlePoint(aRect.TopLeft, aRect.BottomRight);
      for i := 0 to 3 do
        if Detail in [tsThumbBtnHorzNormal..tsThumbBtnHorzDisabled] then
          begin
            SelectObject(DC, lPen1);
            MoveToEx(DC, p.X + 2*i - 4, p.Y - 3, nil);
            LineTo(DC, p.X + 2*i - 4, p.Y + 4);
            SelectObject(DC, lPen2);
            MoveToEx(DC, p.X + 2*i + 1 - 4, p.Y - 2, nil);
            LineTo(DC, p.X + 2*i - 3, p.Y + 5);
          end
        else
          if Detail in [tsThumbBtnVertNormal..tsThumbBtnVertDisabled] then
            begin
              SelectObject(DC, lPen1);
              MoveToEx(DC, p.X - 3, p.Y + 2*i - 4, nil);
              LineTo(DC, p.X + 4, p.Y + 2*i - 4);
              SelectObject(DC, lPen2);
              MoveToEx(DC, p.X - 2, p.Y + 2*i  - 3, nil);
              LineTo(DC, p.X + 5, p.Y + 2*i - 3);
            end;
      SelectObject(DC, lOldPen);
      DeleteObject(lPen1);
      DeleteObject(lPen2);
    end;
  end;  
end;

end.
