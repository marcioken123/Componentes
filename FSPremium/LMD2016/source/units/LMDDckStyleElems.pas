unit LMDDckStyleElems;
{$I LmdCmps.inc}

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

LMDDckStyleElems unit (YB)
--------------------------
Visual Styles elements for LMD-DockingPack.

Changes
-------

###############################################################################}

interface

uses
  Windows, Classes, Variants, Graphics, SysUtils, GraphUtil, StrUtils,
  Math, Controls, intfLMDBase, LMDUnicode, LMDTypes, LMDXML, LMDDckClass,
  LMDDckCst, LMDDckStyles;

type
  { *************************** TLMDSiteBackElem ***************************** }

  TLMDPanelBtnKind  = (pbMenu, pbPin, pbMaximize, pbClose);
  TLMDPanelBtnKinds = set of TLMDPanelBtnKind;

  TLMDSiteBackElem = class(TLMDStyleElem)
  private
    FDragContent:     Boolean;
    FAnimateDragRect: Boolean;
    FAnimateHotSpots: Boolean;
  public
    constructor Create(AStyle: TLMDDockStyle); override;
    function    GetBack(AIsFloating, AIdDoc: Boolean): TLMDElemState;
    procedure   GetAreas(const R: TRect; AIsFloating, AIdDoc: Boolean;
                         out AContent: TRect);
  published
    property Normal: TLMDElemState index 0 read GetState;
    property NormalContent: TLMDMargins index 0 read GetMargins;
    property Floating: TLMDElemState index 1 read GetState;
    property FloatingContent: TLMDMargins index 1 read GetMargins;
    property Doc: TLMDElemState index 2 read GetState;
    property DocContent: TLMDMargins index 2 read GetMargins;
    property DragContent: Boolean read FDragContent write FDragContent;
    property AnimateDragRect: Boolean read FAnimateDragRect write FAnimateDragRect;
    property AnimateHotSpots: Boolean read FAnimateHotSpots write FAnimateHotSpots;
    property DragRectBack: TColor index 0 read GetColor write SetColor;
    property DragRectBorder: TColor index 1 read GetColor write SetColor;
  end;

  { **************************** TLMDPinAreaBase ***************************** }

  TLMDPinAreaBase = class(TLMDStyleElem)
  private
    FSide:         TAlign;
    FSpacerSize:   Integer;
    FShowTabImage: Boolean;
  protected
    property SpacerWidth: Integer read FSpacerSize write FSpacerSize;
    property SpacerHeight: Integer read FSpacerSize write FSpacerSize;
  public
    function GetSize(AFont: TFont): Integer;
    function GetSpacerSize: Integer;
    function GetTab(AIsHot: Boolean): TLMDElemState;
    function GetTextColor(AIsHot: Boolean): TColor;
  published
    property Background: TLMDElemState index 0 read GetState;
    property Content: TLMDMargins index 0 read GetMargins;
    property NormalTab: TLMDElemState index 1 read GetState;
    property NormalTextColor: TColor index 0 read GetColor write SetColor;
    property HotTab: TLMDElemState index 2 read GetState;
    property HotTextColor: TColor index 1 read GetColor write SetColor;
    property TabContent: TLMDMargins index 1 read GetMargins;
    property ShowTabImage: Boolean read FShowTabImage write FShowTabImage;
    property Spacer: TLMDElemState index 3 read GetState;
  end;

  { ************************** TLMDLeftPinAreaElem *************************** }

  TLMDLeftPinAreaElem = class(TLMDPinAreaBase)
  published
    property SpacerHeight;
  end;

  { ************************** TLMDTopPinAreaElem **************************** }

  TLMDTopPinAreaElem = class(TLMDPinAreaBase)
  published
    property SpacerWidth;
  end;

  { ************************* TLMDRightPinAreaElem *************************** }

  TLMDRightPinAreaElem = class(TLMDPinAreaBase)
  published
    property SpacerHeight;
  end;

  { ************************* TLMDBottomPinAreaElem ************************** }

  TLMDBottomPinAreaElem = class(TLMDPinAreaBase)
  published
    property SpacerWidth;
  end;

  { **************************** TLMDPinPanelBase **************************** }

  TLMDPinPanelBase = class(TLMDStyleElem)
  private
    FSplitterSize: Integer;
    FSide:         TAlign;
  protected
    property SplitterWidth: Integer read FSplitterSize write FSplitterSize;
    property SplitterHeight: Integer read FSplitterSize write FSplitterSize;
  public
    procedure GetAreas(const R: TRect; out ASplitter, AContent: TRect);
  published
    property Background: TLMDElemState index 0 read GetState;
    property Splitter: TLMDElemState index 1 read GetState;
    property Content: TLMDMargins index 0 read GetMargins;
  end;

  { ************************** TLMDLeftPinPanelElem ************************** }

  TLMDLeftPinPanelElem = class(TLMDPinPanelBase)
  published
    property SplitterWidth;
  end;

  { *************************** TLMDTopPinPanelElem ************************** }

  TLMDTopPinPanelElem = class(TLMDPinPanelBase)
  published
    property SplitterHeight;
  end;

  { ************************** TLMDRightPinPanelElem ************************* }

  TLMDRightPinPanelElem = class(TLMDPinPanelBase)
  published
    property SplitterWidth;
  end;

  { ************************* TLMDBottomPinPanelElem ************************* }

  TLMDBottomPinPanelElem = class(TLMDPinPanelBase)
  published
    property SplitterHeight;
  end;

  { ***************************** TLMDSeqZoneBase **************************** }

  TLMDSeqZoneBase = class(TLMDStyleElem)
  private
    FSplitterSize: Integer;
  protected
    property SplitterWidth: Integer read FSplitterSize write FSplitterSize;
    property SplitterHeight: Integer read FSplitterSize write FSplitterSize;
  public
    function GetSplitterSize: Integer;
  published
    property Background: TLMDElemState index 0 read GetState;
    property Content: TLMDMargins index 0 read GetMargins;
    property Splitter: TLMDElemState index 1 read GetState;
  end;

  { **************************** TLMDHorzZoneElem **************************** }

  TLMDHorzZoneElem = class(TLMDSeqZoneBase)
  published
    property SplitterWidth;
  end;

  { **************************** TLMDVertZoneElem **************************** }

  TLMDVertZoneElem = class(TLMDSeqZoneBase)
  published
    property SplitterHeight;
  end;

  { **************************** TLMDTabedAreaBase *************************** }

  TLMDZoneTabState  = (ztsNormal, ztsSelected, ztsHot);
  TLMDTabedAreaPart = record
    IsActive: Boolean;
    Part:     (tapBack, tapTabArea, tapTab, tapSpacer);
    TabState: TLMDZoneTabState;
  end;

  TLMDTabedAreaColor = record
    IsActive: Boolean;
    TabState: TLMDZoneTabState;
  end;

  TLMDTabedAreaBase = class(TLMDStyleElem)
  private
    FSpacerWidth:  Integer;
    FShowTabImage: Boolean;
  protected
    function GetPart(const P: TLMDTabedAreaPart): TLMDElemState; virtual; abstract;
    function GetClr(const C: TLMDTabedAreaColor): TColor; virtual; abstract;
    function TabsAtTop: Boolean; virtual; abstract;
  public
    function  GetBack(AIsActive: Boolean): TLMDElemState;
    function  GetTabArea(AIsActive: Boolean): TLMDElemState;
    function  GetTab(AIsActive: Boolean; AState: TLMDZoneTabState): TLMDElemState;
    function  GetTextColor(AIsActive: Boolean; AState: TLMDZoneTabState): TColor;
    function  GetSpacer(AIsActive: Boolean): TLMDElemState;
    procedure GetAreas(const R: TRect; AFont: TFont; out AContent,
                       ATabArea: TRect);
  published
    property Content: TLMDMargins index 0 read GetMargins;
    property ContentClip: TLMDMargins index 1 read GetMargins;
    property TabAreaContent: TLMDMargins index 2 read GetMargins;
    property TabContent: TLMDMargins index 3 read GetMargins;
    property ShowTabImage: Boolean read FShowTabImage write FShowTabImage;
    property SelectedMargins: TLMDMargins index 4 read GetMargins;
    property SpacerWidth: Integer read FSpacerWidth write FSpacerWidth;
  end;

  { ************************** TLMDTabedAreaBtnBase ************************** }

  TLMDTabBtnKind  = (tbClose, tbLeft, tbRight, tbMenu);
  TLMDTabBtnKinds = set of TLMDTabBtnKind;

  TLMDTabBtnAreas       = array[TLMDTabBtnKind] of TRect;
  TLMDTabedAreaBtnState = set of (tbsAreaActive, tbsTabSelected,
                                  tbsTabHot, tbsHot, tbsHotDown);

  TLMDTabedAreaBtnBase = class(TLMDStyleElem)
  private
    FWidth:     Integer;
    FHeight:    Integer;
    FShowClose: Boolean;

    function DoGetArea(const AParent: TRect; AWidth, AHeight: Integer;
                       AMargins: TLMDMargins): TRect; overload;
    function DoGetArea(const AParent: TRect; AMargins: TLMDMargins): TRect; overload;
  public
    function  ShowButtons: TLMDTabBtnKinds; virtual; abstract;
    procedure GetCloseArea(const AParent: TRect; out AButton:
                           TRect); virtual; abstract;
    procedure GetGroupAreas(const AParent: TRect; AKinds: TLMDTabBtnKinds;
                            out AButtons: TLMDTabBtnAreas;
                            out AGroup: TRect); virtual; abstract;
    function  GetStates(AKind: TLMDTabBtnKind; AState:
                        TLMDTabedAreaBtnState): TLMDElemState; virtual; abstract;
  published
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property ShowClose: Boolean read FShowClose write FShowClose;
  end;

  { **************************** TLMDTabZoneElem ***************************** }

  TLMDTabZoneElem = class(TLMDTabedAreaBase)
  protected
    function GetPart(const P: TLMDTabedAreaPart): TLMDElemState; override;
    function GetClr(const C: TLMDTabedAreaColor): TColor; override;
    function TabsAtTop: Boolean; override;
  published
    property Background: TLMDElemState index 0 read GetState;
    property TabArea: TLMDElemState index 1 read GetState;
    property NormalTab: TLMDElemState index 2 read GetState;
    property NormalTextColor: TColor index 0 read GetColor write SetColor;
    property HotTab: TLMDElemState index 3 read GetState;
    property HotTextColor: TColor index 1 read GetColor write SetColor;
    property SelectedTab: TLMDElemState index 4 read GetState;
    property SelectedTextColor: TColor index 2 read GetColor write SetColor;
    property Spacer: TLMDElemState index 5 read GetState;
  end;

  { ************************* TLMDTabZoneButtonElem ************************** }

  TLMDTabZoneButtonElem = class(TLMDTabedAreaBtnBase)
  public
    function  ShowButtons: TLMDTabBtnKinds; override;
    procedure GetCloseArea(const AParent: TRect; out AButton: TRect); override;
    procedure GetGroupAreas(const AParent: TRect; AKinds: TLMDTabBtnKinds;
                            out AButtons: TLMDTabBtnAreas; out AGroup: TRect); override;
    function  GetStates(AKind: TLMDTabBtnKind; AState:
                        TLMDTabedAreaBtnState): TLMDElemState; override;
  published
    property NormalClose: TLMDElemState index 0 read GetState;
    property SelectedClose: TLMDElemState index 1 read GetState;
    property TabHotClose: TLMDElemState index 2 read GetState;
    property HotClose: TLMDElemState index 3 read GetState;
    property DownClose: TLMDElemState index 4 read GetState;
    property CloseMargins: TLMDMargins index 0 read GetMargins;
  end;

  { *************************** TLMDDocsZoneElem ***************************** }

  TLMDDocsZoneElem = class(TLMDTabedAreaBase)
  protected
    function GetPart(const P: TLMDTabedAreaPart): TLMDElemState; override;
    function GetClr(const C: TLMDTabedAreaColor): TColor; override;
    function TabsAtTop: Boolean; override;
  published
    property InactiveBack: TLMDElemState index 0 read GetState;
    property ActiveBack: TLMDElemState index 1 read GetState;
    property InactiveTabArea: TLMDElemState index 2 read GetState;
    property ActiveTabArea: TLMDElemState index 3 read GetState;
    property NormalTab: TLMDElemState index 4 read GetState;
    property NormalTextColor: TColor index 0 read GetColor write SetColor;
    property HotTab: TLMDElemState index 5 read GetState;
    property HotTextColor: TColor index 1 read GetColor write SetColor;
    property InactiveSelectedTab: TLMDElemState index 6 read GetState;
    property InactiveSelectedTextColor: TColor index 2 read GetColor write SetColor;
    property ActiveSelectedTab: TLMDElemState index 7 read GetState;
    property ActiveSelectedTextColor: TColor index 3 read GetColor write SetColor;
    property Spacer: TLMDElemState index 8 read GetState;
  end;

  { ************************ TLMDDocsZoneButtonElem ************************** }

  TLMDDocsZoneButtonElem = class(TLMDTabedAreaBtnBase)
  public
    function  ShowButtons: TLMDTabBtnKinds; override;
    procedure GetCloseArea(const AParent: TRect; out AButton: TRect); override;
    procedure GetGroupAreas(const AParent: TRect; AKinds: TLMDTabBtnKinds;
                            out AButtons: TLMDTabBtnAreas; out AGroup: TRect); override;
    function  GetStates(AKind: TLMDTabBtnKind; AState:
                        TLMDTabedAreaBtnState): TLMDElemState; override;
  published
    property InactiveClose: TLMDElemState index 0 read GetState;
    property InactiveSelectedClose: TLMDElemState index 1 read GetState;
    property ActiveClose: TLMDElemState index 2 read GetState;
    property ActiveSelectedClose: TLMDElemState index 3 read GetState;
    property TabHotClose: TLMDElemState index 4 read GetState;
    property HotClose: TLMDElemState index 5 read GetState;
    property DownClose: TLMDElemState index 6 read GetState;
    property CloseMargins: TLMDMargins index 0 read GetMargins;
    property InactiveLeft: TLMDElemState index 7 read GetState;
    property ActiveLeft: TLMDElemState index 8 read GetState;
    property HotLeft: TLMDElemState index 9 read GetState;
    property DownLeft: TLMDElemState index 10 read GetState;
    property InactiveRight: TLMDElemState index 11 read GetState;
    property ActiveRight: TLMDElemState index 12 read GetState;
    property HotRight: TLMDElemState index 13 read GetState;
    property DownRight: TLMDElemState index 14 read GetState;
    property InactiveMenu: TLMDElemState index 15 read GetState;
    property ActiveMenu: TLMDElemState index 16 read GetState;
    property HotMenu: TLMDElemState index 17 read GetState;
    property DownMenu: TLMDElemState index 18 read GetState;
    property GroupContent: TLMDMargins index 1 read GetMargins;
  end;

  { *************************** TLMDPanelZoneElem **************************** }

  TLMDPanelZoneElem = class(TLMDStyleElem)
  published
    property Background: TLMDElemState index 0 read GetState;
    property Content: TLMDMargins index 0 read GetMargins;
  end;

  { *************************** TLMDEmptyZoneElem **************************** }

  TLMDEmptyZoneElem = class(TLMDStyleElem)
  published
    property Background: TLMDElemState index 0 read GetState;
  end;

  { *************************** TLMDFrameBtnBase ***************************** }

  TLMDVertAlign     = (vaTop, vaCenter, vaBottom);
  TLMDFrameBtnState = set of (fbsActive, fbsPinned, fbsMaximized);

  TLMDButtonsData = record
    Kinds:   TLMDPanelBtnKinds;
    Group:   TRect;
    Buttons: array[TLMDPanelBtnKind] of TRect;
    Spacers: array[TLMDPanelBtnKind] of TRect;
    Hot:     TLMDPanelBtnKind;
    HotDown: Boolean;
  end;

  TLMDFrameBtnBase = class(TLMDStyleElem)
  private
    FWidth:          Integer;
    FHeight:         Integer;
    FSpacerWidth:    Integer;
    FGroupVertAlign: TLMDVertAlign;
  public
    procedure GetAreas(const AParent: TRect; AKinds: TLMDPanelBtnKinds;
                       var AData: TLMDButtonsData);
    function  GetStates(AKind: TLMDPanelBtnKind; const AData: TLMDButtonsData;
                        AState: TLMDFrameBtnState): TLMDElemState;
    procedure Draw(ACanvas: TCanvas; const AData: TLMDButtonsData;
                   AState: TLMDFrameBtnState);
  published
    property GroupBack: TLMDElemState index 0 read GetState;
    property GroupVertAlign: TLMDVertAlign read FGroupVertAlign write FGroupVertAlign;
    property GroupContent: TLMDMargins index 0 read GetMargins;
    property InactiveMenu: TLMDElemState index 1 read GetState;
    property ActiveMenu: TLMDElemState index 2 read GetState;
    property HotMenu: TLMDElemState index 3 read GetState;
    property DownMenu: TLMDElemState index 4 read GetState;
    property InactivePin: TLMDElemState index 5 read GetState;
    property ActivePin: TLMDElemState index 6 read GetState;
    property HotPin: TLMDElemState index 7 read GetState;
    property DownPin: TLMDElemState index 8 read GetState;
    property InactiveUnpin: TLMDElemState index 9 read GetState;
    property ActiveUnpin: TLMDElemState index 10 read GetState;
    property HotUnpin: TLMDElemState index 11 read GetState;
    property DownUnpin: TLMDElemState index 12 read GetState;
    property InactiveMaximize: TLMDElemState index 13 read GetState;
    property ActiveMaximize: TLMDElemState index 14 read GetState;
    property HotMaximize: TLMDElemState index 15 read GetState;
    property DownMaximize: TLMDElemState index 16 read GetState;
    property InactiveRestore: TLMDElemState index 17 read GetState;
    property ActiveRestore: TLMDElemState index 18 read GetState;
    property HotRestore: TLMDElemState index 19 read GetState;
    property DownRestore: TLMDElemState index 20 read GetState;
    property InactiveClose: TLMDElemState index 21 read GetState;
    property ActiveClose: TLMDElemState index 22 read GetState;
    property HotClose: TLMDElemState index 23 read GetState;
    property DownClose: TLMDElemState index 24 read GetState;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property Margins: TLMDMargins index 1 read GetMargins;
    property Spacer: TLMDElemState index 25 read GetState;
    property SpacerWidth: Integer read FSpacerWidth write FSpacerWidth;
  end;

  { ************************* TLMDPanelButtonElem **************************** }

  TLMDPanelButtonElem = class(TLMDFrameBtnBase);

  { **************************** TLMDPanelElem ******************************* }

  TLMDPanelElem = class(TLMDStyleElem)
  private
    FShowHeaderImage: Boolean;
  public
    procedure GetAreas(const R: TRect; AShowCaption: Boolean;
                       AFont: TFont; out ACaption, AContent: TRect);
    function  GetCaption(AIsActive: Boolean): TLMDElemState;
    function  GetTextColor(AIsActive: Boolean): TColor;
    function  GetFiller(AIsActive: Boolean): TLMDElemState;
  published
    property InactiveCaption: TLMDElemState index 0 read GetState;
    property InactiveTextColor: TColor index 0 read GetColor write SetColor;
    property InactiveFiller: TLMDElemState index 1 read GetState;
    property ActiveCaption: TLMDElemState index 2 read GetState;
    property ActiveTextColor: TColor index 1 read GetColor write SetColor;
    property ActiveFiller: TLMDElemState index 3 read GetState;
    property CaptionContent: TLMDMargins index 0 read GetMargins;
    property FillerMargins: TLMDMargins index 1 read GetMargins;
    property ShowHeaderImage: Boolean read FShowHeaderImage write FShowHeaderImage;
    property DefaultColor: TColor index 2 read GetColor write SetColor;
    property DefaultFontColor: TColor index 3 read GetColor write SetColor;
  end;

  { ************************** TLMDFloatFrameBase **************************** }

  TLMDFloatBorderKind = (fbNormal, fbTool, fbCustom);
  TLMDFloatFrameBase  = class(TLMDStyleElem)
  private
    FShowHeaderImage: Boolean;
    FBorderKind:      TLMDFloatBorderKind;
  public
    function  HasCaption: Boolean; virtual;
    procedure GetAreas(const R: TRect; AFont: TFont; out
                       ACaption, AFrameContent: TRect);
    function  GetFrame(AIsActive: Boolean): TLMDElemState;
    function  GetGlow(AIsActive: Boolean): TLMDElemState;
    function  GetCaption(AIsActive: Boolean): TLMDElemState;
    function  GetTextColor(AIsActive: Boolean): TColor;
    function  GetFiller(AIsActive: Boolean): TLMDElemState;
  protected
    property CaptionMargins: TLMDMargins index 0 read GetMargins;
    property InactiveCaption: TLMDElemState index 0 read GetState;
    property InactiveTextColor: TColor index 0 read GetColor write SetColor;
    property InactiveFiller: TLMDElemState index 1 read GetState;
    property ActiveCaption: TLMDElemState index 2 read GetState;
    property ActiveTextColor: TColor index 1 read GetColor write SetColor;
    property ActiveFiller: TLMDElemState index 3 read GetState;
    property CaptionContent: TLMDMargins index 1 read GetMargins;
    property FillerMargins: TLMDMargins index 2 read GetMargins;
    property ShowHeaderImage: Boolean read FShowHeaderImage write FShowHeaderImage;
  published
    property InactiveFrame: TLMDElemState index 4 read GetState;
    property ActiveFrame: TLMDElemState index 5 read GetState;
    property FrameContent: TLMDMargins index 3 read GetMargins;
    property InactiveGlow: TLMDElemState index 6 read GetState;
    property ActiveGlow: TLMDElemState index 7 read GetState;
    property GlowContent: TLMDMargins index 4 read GetMargins;
    property BorderKind: TLMDFloatBorderKind read FBorderKind write FBorderKind;
    property WindowRegion: TLMDElemState index 8 read GetState;
  end;

  { ************************* TLMDCaptionFrameBase *************************** }

  TLMDCaptionFrameBase = class(TLMDFloatFrameBase)
  public
    function  HasCaption: Boolean; override;
  published
    property CaptionMargins;
    property InactiveCaption;
    property InactiveTextColor;
    property InactiveFiller;
    property ActiveCaption;
    property ActiveTextColor;
    property ActiveFiller;
    property CaptionContent;
    property FillerMargins;
    property ShowHeaderImage;
  end;

  { *************************** TLMDPanelFormElem **************************** }

  TLMDPanelFormElem = class(TLMDFloatFrameBase);

  { *************************** TLMDGroupFormElem **************************** }

  TLMDGroupFormButtonElem  = class(TLMDFrameBtnBase);
  TLMDGroupFormElem        = class(TLMDCaptionFrameBase);

  { **************************** TLMDDocFormElem ***************************** }

  TLMDDocFormButtonElem = class(TLMDFrameBtnBase);
  TLMDDocFormElem       = class(TLMDCaptionFrameBase);

  { **************************** TLMDHotspotBase ***************************** }

  TLMDHotSpotKind   = (hsLeft, hsTop, hsRight, hsBottom, hsCenter);
  TLMDHotSpotKinds  = set of TLMDHotSpotKind;
  TLMDActiveArea    = (hsaSiteLeft, hsaSiteTop, hsaSiteRight, hsaSiteBottom,
                       hsaZoneLeft, hsaZoneTop, hsaZoneRight, hsaZoneBottom,
                       hsaDocsLeft, hsaDocsTop, hsaDocsRight, hsaDocsBottom,
                       hsaTabs, hsaSplitters, hsaTabAreas);
  TLMDActiveAreas   = set of TLMDActiveArea;
  TLMDHotSpotLayout = array[hsaSiteLeft..hsaTabs] of TRect;

  TLMDHotspotBase = class(TLMDStyleElem)
  private
    FWidth:  Integer;
    FHeight: Integer;
  public
    procedure GetAreas(out ALayout: TLMDHotSpotLayout); virtual; abstract;
    function  GetActiveArea(AEnabled: Boolean; AArea: TLMDActiveArea;
                            out AState: TLMDElemState): Boolean; virtual; abstract;
  published
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property Background: TLMDElemState index 0 read GetState;
  end;

  { ************************** TLMDSideHotspotBase *************************** }

  TLMDSideHotspotBase = class(TLMDHotspotBase)
  private
    FSide:    TAlign;
    procedure InitSide;
  public
    procedure GetAreas(out ALayout: TLMDHotSpotLayout); override;
    function  GetActiveArea(AEnabled: Boolean; AArea: TLMDActiveArea;
                            out AState: TLMDElemState): Boolean; override;
  published
    property Enabled: TLMDElemState index 1 read GetState;
    property Disabled: TLMDElemState index 2 read GetState;
  end;

  { ************************** TLMDSideHotspotElems ************************** }

  TLMDLeftHotspotElem   = class(TLMDSideHotspotBase);
  TLMDTopHotspotElem    = class(TLMDSideHotspotBase);
  TLMDRightHotspotElem  = class(TLMDSideHotspotBase);
  TLMDBottomHotspotElem = class(TLMDSideHotspotBase);

  { ************************** TLMDCrossHotspotBase *************************** }

  TLMDCrossHotspotBase = class(TLMDHotspotBase)
  public
    procedure GetAreas(out ALayout: TLMDHotSpotLayout); override;
    function  GetActiveArea(AEnabled: Boolean; AArea: TLMDActiveArea;
                            out AState: TLMDElemState): Boolean; override;
  published
    property EnabledLeft: TLMDElemState index 1 read GetState;
    property DisabledLeft: TLMDElemState index 2 read GetState;
    property LeftMargins: TLMDMargins index 0 read GetMargins;
    property EnabledTop: TLMDElemState index 3 read GetState;
    property DisabledTop: TLMDElemState index 4 read GetState;
    property TopMargins: TLMDMargins index 1 read GetMargins;
    property EnabledRight: TLMDElemState index 5 read GetState;
    property DisabledRight: TLMDElemState index 6 read GetState;
    property RightMargins: TLMDMargins index 2 read GetMargins;
    property EnabledBottom: TLMDElemState index 7 read GetState;
    property DisabledBottom: TLMDElemState index 8 read GetState;
    property BottomMargins: TLMDMargins index 3 read GetMargins;
    property EnabledLeftDoc: TLMDElemState index 9 read GetState;
    property DisabledLeftDoc: TLMDElemState index 10 read GetState;
    property LeftDocMargins: TLMDMargins index 4 read GetMargins;
    property EnabledTopDoc: TLMDElemState index 11 read GetState;
    property DisabledTopDoc: TLMDElemState index 12 read GetState;
    property TopDocMargins: TLMDMargins index 5 read GetMargins;
    property EnabledRightDoc: TLMDElemState index 13 read GetState;
    property DisabledRightDoc: TLMDElemState index 14 read GetState;
    property RightDocMargins: TLMDMargins index 6 read GetMargins;
    property EnabledBottomDoc: TLMDElemState index 15 read GetState;
    property DisabledBottomDoc: TLMDElemState index 16 read GetState;
    property BottomDocMargins: TLMDMargins index 7 read GetMargins;
    property EnabledTabs: TLMDElemState index 17 read GetState;
    property DisabledTabs: TLMDElemState index 18 read GetState;
    property TabsMargins: TLMDMargins index 8 read GetMargins;
  end;

  TLMDSmallCrossElem = class(TLMDCrossHotspotBase);
  TLMDBigCrossElem   = class(TLMDCrossHotspotBase);

  { ***************************** TLMDDockElems ****************************** }

  TLMDFloatFormKind = (ffPanel, ffGroup, ffDoc);

  TLMDDockElems = class(TLMDElemSet)
  private
    FSiteBack:         TLMDSiteBackElem;
    FPanel:            TLMDPanelElem;
    FPanelButton:      TLMDPanelButtonElem;
    FBottomPinArea:    TLMDBottomPinAreaElem;
    FTopPinArea:       TLMDTopPinAreaElem;
    FLeftPinArea:      TLMDLeftPinAreaElem;
    FRightPinArea:     TLMDRightPinAreaElem;
    FBottomPinPanel:   TLMDBottomPinPanelElem;
    FTopPinPanel:      TLMDTopPinPanelElem;
    FLeftPinPanel:     TLMDLeftPinPanelElem;
    FRightPinPanel:    TLMDRightPinPanelElem;
    FVertZone:         TLMDVertZoneElem;
    FHorzZone:         TLMDHorzZoneElem;
    FTabZone:          TLMDTabZoneElem;
    FTabZoneButton:    TLMDTabZoneButtonElem;
    FDocsZone:         TLMDDocsZoneElem;
    FDocsZoneButton:   TLMDDocsZoneButtonElem;
    FPanelZone:        TLMDPanelZoneElem;
    FEmptyZone:        TLMDEmptyZoneElem;
    FDocForm:          TLMDDocFormElem;
    FPanelForm:        TLMDPanelFormElem;
    FGroupForm:        TLMDGroupFormElem;
    FGroupFormButton:  TLMDGroupFormButtonElem;
    FDocFormButton:    TLMDDocFormButtonElem;
    FBottomHotspot:    TLMDBottomHotspotElem;
    FSmallCross:       TLMDSmallCrossElem;
    FBigCross:         TLMDBigCrossElem;
    FTopHotspot:       TLMDTopHotspotElem;
    FLeftHotspot:      TLMDLeftHotspotElem;
    FRightHotspot:     TLMDRightHotspotElem;

    procedure SetSiteBack(const Value: TLMDSiteBackElem);
  public
    function GetPinArea(ASide: TAlign): TLMDPinAreaBase;
    function GetPinPanel(ASide: TAlign): TLMDPinPanelBase;
    function GetSeqZone(AIsVert: Boolean): TLMDSeqZoneBase;
    function GetTabedArea(AIsDocHost: Boolean): TLMDTabedAreaBase;
    function GetTabedAreaButton(AIsDocHost: Boolean): TLMDTabedAreaBtnBase;
    function GetHotSpot(AKind: TLMDHotSpotKind; ANeedBigCross:
                        Boolean): TLMDHotspotBase;
    function GetForm(AKind: TLMDFloatFormKind): TLMDFloatFrameBase;
    function GetFormButton(AKind: TLMDFloatFormKind): TLMDFrameBtnBase;
  published
    property SiteBack: TLMDSiteBackElem read FSiteBack write SetSiteBack;
    property LeftPinArea: TLMDLeftPinAreaElem read FLeftPinArea write FLeftPinArea;
    property TopPinArea: TLMDTopPinAreaElem read FTopPinArea write FTopPinArea;
    property RightPinArea: TLMDRightPinAreaElem read FRightPinArea write FRightPinArea;
    property BottomPinArea: TLMDBottomPinAreaElem read FBottomPinArea write FBottomPinArea;
    property LeftPinPanel: TLMDLeftPinPanelElem read FLeftPinPanel write FLeftPinPanel;
    property TopPinPanel: TLMDTopPinPanelElem read FTopPinPanel write FTopPinPanel;
    property RightPinPanel: TLMDRightPinPanelElem read FRightPinPanel write FRightPinPanel;
    property BottomPinPanel: TLMDBottomPinPanelElem read FBottomPinPanel write FBottomPinPanel;
    property HorzZone: TLMDHorzZoneElem read FHorzZone write FHorzZone;
    property VertZone: TLMDVertZoneElem read FVertZone write FVertZone;
    property TabZone: TLMDTabZoneElem read FTabZone write FTabZone;
    property TabZoneButton: TLMDTabZoneButtonElem read FTabZoneButton write FTabZoneButton;
    property DocsZone: TLMDDocsZoneElem read FDocsZone write FDocsZone;
    property DocsZoneButton: TLMDDocsZoneButtonElem read FDocsZoneButton write FDocsZoneButton;
    property PanelZone: TLMDPanelZoneElem read FPanelZone write FPanelZone;
    property EmptyZone: TLMDEmptyZoneElem read FEmptyZone write FEmptyZone;
    property Panel: TLMDPanelElem read FPanel write FPanel;
    property PanelButton: TLMDPanelButtonElem read FPanelButton write FPanelButton;
    property PanelForm: TLMDPanelFormElem read FPanelForm write FPanelForm;
    property GroupForm: TLMDGroupFormElem read FGroupForm write FGroupForm;
    property GroupFormButton: TLMDGroupFormButtonElem read FGroupFormButton write FGroupFormButton;
    property DocForm: TLMDDocFormElem read FDocForm write FDocForm;
    property DocFormButton: TLMDDocFormButtonElem read FDocFormButton write FDocFormButton;
    property LeftHotspot: TLMDLeftHotspotElem read FLeftHotspot write FLeftHotspot;
    property TopHotspot: TLMDTopHotspotElem read FTopHotspot write FTopHotspot;
    property RightHotspot: TLMDRightHotspotElem read FRightHotspot write FRightHotspot;
    property BottomHotspot: TLMDBottomHotspotElem read FBottomHotspot write FBottomHotspot;
    property SmallCross: TLMDSmallCrossElem read FSmallCross write FSmallCross;
    property BigCross: TLMDBigCrossElem read FBigCross write FBigCross;
  end;

const
  pbNone  = TLMDPanelBtnKind(-1);
  tbNone  = TLMDTabBtnKind(-1);
  hsaNone = TLMDActiveArea(-1);

implementation

{$R lmddckstyles.res}

function GetTextHeight(AFont: TFont): Integer;
var
  dc: HDC;
  tm: TTextMetric;
begin
  dc := GetDC(0);
  SelectObject(dc, AFont.Handle);
  GetTextMetrics(dc, tm);
  ReleaseDC(0, dc);

  Result := tm.tmHeight;
end;

function NormalizeRect(const R: TRect): TRect;
begin
  with Result do
  begin
    Left := R.Left;
    Top  := R.Top;
    if R.Right >= R.Left then
      Right := R.Right
    else
      Right := R.Left;
    if R.Bottom >= R.Top then
      Bottom := R.Bottom
    else
      Bottom := R.Top;
  end;
end;

{ TLMDFrameBtnBase }

procedure TLMDFrameBtnBase.Draw(ACanvas: TCanvas;
  const AData: TLMDButtonsData; AState: TLMDFrameBtnState);
var
  b:   TLMDPanelBtnKind;
  bst: TLMDElemState;

  procedure DrawBtn(B: TLMDPanelBtnKind);
  begin
    bst := GetStates(B, AData, AState);
    bst.Draw(ACanvas, AData.Buttons[B]);
  end;

begin
  if AData.Kinds <> [] then
    GroupBack.Draw(ACanvas, AData.Group);

  for b := Low(TLMDPanelBtnKind) to High(TLMDPanelBtnKind) do
    if b in AData.Kinds then
    begin
      Spacer.Draw(ACanvas, AData.Spacers[b]);
      if b <> AData.Hot then
        DrawBtn(b);
    end;
  if (AData.Hot <> pbNone) and (AData.Hot in AData.Kinds) then
    DrawBtn(AData.Hot); // Hot od odwn sould be drawn topmost.
end;

procedure TLMDFrameBtnBase.GetAreas(const AParent: TRect;
  AKinds: TLMDPanelBtnKinds; var AData: TLMDButtonsData);
var
  b:        TLMDPanelBtnKind;
  bcnt:     Integer;
  slot:     TSize;
  csz, gsz: TSize;
  p:        TPoint;
  lspr:     PRect;
begin
  with AData do
  begin
    Kinds := AKinds;
    bcnt  := 0;

    for b := Low(TLMDPanelBtnKind) to High(TLMDPanelBtnKind) do
    begin
      if b in AKinds then
        Inc(bcnt);
    end;

    slot   := Margins.UnadjustSize(FWidth, FHeight);
    csz.cx := slot.cx * bcnt + FSpacerWidth * Max(bcnt - 1, 0);
    csz.cy := slot.cy;
    gsz    := GroupContent.UnadjustSize(csz);

    with Group do
    begin
      Group := AParent;
      Left  := Right - gsz.cx;

      case FGroupVertAlign of
        vaTop:    Bottom := Top + gsz.cy;
        vaBottom: Top    := Bottom - gsz.cy;
      else
        Top    := (AParent.Top + AParent.Bottom - gsz.cy) div 2;
        Bottom := Top + gsz.cy;
      end;
    end;

    p    := GroupContent.AdjustRect(Group).TopLeft;
    lspr := nil;

    for b := Low(TLMDPanelBtnKind) to High(TLMDPanelBtnKind) do
      if b in AKinds then
      begin
        Buttons[b] := Margins.AdjustRect(Bounds(p.X, p.Y, slot.cx, slot.cy));
        Spacers[b] := Bounds(p.X + slot.cx, p.Y, FSpacerWidth, slot.cy);

        Inc(p.X, slot.cx + FSpacerWidth);
        lspr := @Spacers[b];
      end;

    if lspr <> nil then
      lspr^ := Rect(0, 0, 0, 0);
  end;
end;

function TLMDFrameBtnBase.GetStates(AKind: TLMDPanelBtnKind;
  const AData: TLMDButtonsData; AState: TLMDFrameBtnState): TLMDElemState;
const
  STATE_INDEXES: array[TLMDPanelBtnKind, 0..7] of Integer = (
    //   Unpinned/Normal   |   Pinned/Maximized
    //I     A     H     D     I     A     H     D
    ( 1,    2,    3,    4,    1,    2,    3,    4),
    ( 5,    6,    7,    8,    9,   10,   11,   12),
    (13,   14,   15,   16,   17,   18,   19,   20),
    (21,   22,   23,   24,   21,   22,   23,   24)
  );
var
  idx: Integer;
begin
  idx := 0;

  if ((AKind = pbPin) and (fbsPinned in AState)) or
     ((AKind = pbMaximize) and (fbsMaximized in AState)) then
    Inc(idx, 4);
  if AKind = AData.Hot then
  begin
    if AData.HotDown then
      Inc(idx, 3)
    else
      Inc(idx, 2)
  end
  else if fbsActive in AState then
    Inc(idx);

  Result := GetState(STATE_INDEXES[AKind, idx]);
end;

{ TLMDFloatFrameBase }

procedure TLMDFloatFrameBase.GetAreas(const R: TRect;
  AFont: TFont; out ACaption, AFrameContent: TRect);
var
  hc:     Integer;
  fr, cr: TRect;
begin
  fr := FrameContent.AdjustRect(R);
  hc := GetTextHeight(AFont);
  if hc < 16 then
    hc := 16;
  hc := hc + CaptionContent.Top + CaptionContent.Bottom;

  if HasCaption then
  begin
    cr        := CaptionMargins.AdjustRect(fr);
    cr.Bottom := cr.Top + hc;
    fr.Top    := cr.Bottom;
  end
  else
    cr := Rect(0, 0, 0, 0);

  ACaption      := NormalizeRect(cr);
  AFrameContent := NormalizeRect(fr);
end;

function TLMDFloatFrameBase.GetCaption(AIsActive: Boolean): TLMDElemState;
begin
  if AIsActive then
    Result := ActiveCaption
  else
    Result := InactiveCaption;
end;

function TLMDFloatFrameBase.GetFiller(AIsActive: Boolean): TLMDElemState;
begin
  if AIsActive then
    Result := ActiveFiller
  else
    Result := InactiveFiller;
end;

function TLMDFloatFrameBase.GetFrame(AIsActive: Boolean): TLMDElemState;
begin
  if AIsActive then
    Result := ActiveFrame
  else
    Result := InactiveFrame;
end;

function TLMDFloatFrameBase.GetGlow(AIsActive: Boolean): TLMDElemState;
begin
  if AIsActive then
    Result := ActiveGlow
  else
    Result := InactiveGlow;
end;

function TLMDFloatFrameBase.GetTextColor(AIsActive: Boolean): TColor;
begin
  if AIsActive then
    Result := ActiveTextColor
  else
    Result := InactiveTextColor;
end;

function TLMDFloatFrameBase.HasCaption: Boolean;
begin
  Result := False;
end;

{ TLMDPinPanelBase }

procedure TLMDPinPanelBase.GetAreas(const R: TRect; out ASplitter,
  AContent: TRect);

  procedure InitSide;
  begin
    if Self is TLMDLeftPinPanelElem then
      FSide := alLeft
    else if Self is TLMDTopPinPanelElem then
      FSide := alTop
    else if Self is TLMDRightPinPanelElem then
      FSide := alRight
    else if Self is TLMDBottomPinPanelElem then
      FSide := alBottom
    else
      Assert(False);
  end;

label
  L;
begin
  ASplitter := R;
  AContent  := R;
L:
  case FSide of
    alNone:     begin
                  InitSide;
                  goto L;
                end;
    alTop:      begin
                  ASplitter.Top    := ASplitter.Bottom - FSplitterSize;
                  AContent.Bottom  := ASplitter.Top;
                end;
    alBottom:   begin
                  ASplitter.Bottom := ASplitter.Top + FSplitterSize;
                  AContent.Top     := ASplitter.Bottom;
                end;
    alLeft:     begin
                  ASplitter.Left   := ASplitter.Right - FSplitterSize;
                  AContent.Right   := ASplitter.Left;
                end;
    alRight:    begin
                  ASplitter.Right  := ASplitter.Left + FSplitterSize;
                  AContent.Left    := ASplitter.Right;
                end;
  else
    Assert(False);
  end;

  AContent := Content.AdjustRect(AContent);
end;

{ TLMDTabZoneElem }

function TLMDTabZoneElem.GetClr(const C: TLMDTabedAreaColor): TColor;
begin
  case C.TabState of
    ztsNormal:    Result := NormalTextColor;
    ztsSelected:  Result := SelectedTextColor;
    ztsHot:       Result := HotTextColor;
  else
    Assert(False);
    Result := clNone; // Initialize.
  end;
end;

function TLMDTabZoneElem.GetPart(const P: TLMDTabedAreaPart): TLMDElemState;
begin
  Result := nil; // Initialize.

  case P.Part of
    tapBack:    Result := Background;
    tapTabArea: Result := TabArea;
    tapTab:     case P.TabState of
                  ztsNormal:      Result := NormalTab;
                  ztsSelected:    Result := SelectedTab;
                  ztsHot:         Result := HotTab;
                else
                  Assert(False);
                end;
    tapSpacer:  Result := Spacer;
  else
    Assert(False);
  end;
end;

function TLMDTabZoneElem.TabsAtTop: Boolean;
begin
  Result := False;
end;

{ TLMDDocsZoneElem }

function TLMDDocsZoneElem.GetClr(const C: TLMDTabedAreaColor): TColor;
begin
  case C.TabState of
    ztsNormal:    Result := NormalTextColor;
    ztsSelected:  if C.IsActive then
                    Result := ActiveSelectedTextColor
                  else
                    Result := InactiveSelectedTextColor;
    ztsHot:       Result := HotTextColor;
  else
    Assert(False);
    Result := clNone; // Initialize.
  end;
end;

function TLMDDocsZoneElem.GetPart(const P: TLMDTabedAreaPart): TLMDElemState;
begin
  Result := nil; // Initialize.

  case P.Part of
    tapBack:    if P.IsActive then
                  Result := ActiveBack
                else
                  Result := InactiveBack;
    tapTabArea: if P.IsActive then
                  Result := ActiveTabArea
                else
                  Result := InactiveTabArea;
    tapTab:     begin
                  if P.IsActive then
                    case P.TabState of
                      ztsNormal:      Result := NormalTab;
                      ztsSelected:    Result := ActiveSelectedTab;
                      ztsHot:         Result := HotTab;
                    else
                      Assert(False);
                    end
                  else
                    case P.TabState of
                      ztsNormal:      Result := NormalTab;
                      ztsSelected:    Result := InactiveSelectedTab;
                      ztsHot:         Result := HotTab;
                    else
                      Assert(False);
                    end;
                end;
    tapSpacer:  Result := Spacer;
  else
    Assert(False);
  end;
end;

function TLMDDocsZoneElem.TabsAtTop: Boolean;
begin
  Result := True;
end;

{ TLMDTabedAreaBase }

procedure TLMDTabedAreaBase.GetAreas(const R: TRect; AFont: TFont;
  out AContent, ATabArea: TRect);
var
  cr: TRect;
  hc: Integer;
begin
  hc := GetTextHeight(AFont);
  if hc < 16 then
    hc := 16;
  hc := TabContent.UnadjustSize(0, hc).cy;
  hc := TabAreaContent.UnadjustSize(0, hc).cy;

  if TabsAtTop then
  begin
    ATabArea := Rect(R.Left, R.Top, R.Right, R.Top + hc);
    cr       := Rect(R.Left, R.Top + hc, R.Right, R.Bottom);
  end
  else
  begin
    ATabArea := Rect(R.Left, R.Bottom - hc, R.Right, R.Bottom);
    cr       := Rect(R.Left, R.Top, R.Right, R.Bottom - hc);
  end;

  AContent := Content.AdjustRect(cr);
end;

function TLMDTabedAreaBase.GetBack(AIsActive: Boolean): TLMDElemState;
var
  p: TLMDTabedAreaPart;
begin
  p.IsActive := AIsActive;
  p.Part     := tapBack;
  Result     := GetPart(p);
end;

function TLMDTabedAreaBase.GetSpacer(AIsActive: Boolean): TLMDElemState;
var
  p: TLMDTabedAreaPart;
begin
  p.IsActive := AIsActive;
  p.Part     := tapSpacer;
  Result     := GetPart(p);
end;

function TLMDTabedAreaBase.GetTab(AIsActive: Boolean;
  AState: TLMDZoneTabState): TLMDElemState;
var
  p: TLMDTabedAreaPart;
begin
  p.IsActive := AIsActive;
  p.Part     := tapTab;
  p.TabState := AState;
  Result     := GetPart(p);
end;

function TLMDTabedAreaBase.GetTabArea(AIsActive: Boolean): TLMDElemState;
var
  p: TLMDTabedAreaPart;
begin
  p.IsActive := AIsActive;
  p.Part     := tapTabArea;
  Result     := GetPart(p);
end;

function TLMDTabedAreaBase.GetTextColor(AIsActive: Boolean;
  AState: TLMDZoneTabState): TColor;
var
  c: TLMDTabedAreaColor;
begin
  c.IsActive := AIsActive;
  c.TabState := AState;
  Result     := GetClr(c);
end;

{ TLMDDockElems }

function TLMDDockElems.GetForm(AKind: TLMDFloatFormKind): TLMDFloatFrameBase;
begin
  case AKind of
    ffPanel: Result := PanelForm;
    ffGroup: Result := GroupForm;
    ffDoc:   Result := DocForm;
  else
    Assert(False);
    Result := nil; // Initialize.
  end;
end;

function TLMDDockElems.GetFormButton(
  AKind: TLMDFloatFormKind): TLMDFrameBtnBase;
begin
  case AKind of
    ffGroup: Result := GroupFormButton;
    ffDoc:   Result := DocFormButton;
  else
    Assert(False); // ffPanel.
    Result := nil; // Initialize.
  end;
end;

function TLMDDockElems.GetHotSpot(AKind: TLMDHotSpotKind;
  ANeedBigCross: Boolean): TLMDHotspotBase;
begin
  Result := nil; // Initialize.
  case AKind of
    hsLeft:   Result := LeftHotspot;
    hsTop:    Result := TopHotspot;
    hsRight:  Result := RightHotspot;
    hsBottom: Result := BottomHotspot;
    hsCenter: if ANeedBigCross then
                Result := BigCross
              else
                Result := SmallCross;
    else
      Assert(False);
  end;
end;

function TLMDDockElems.GetPinArea(ASide: TAlign): TLMDPinAreaBase;
begin
  case ASide of
    alLeft:   Result := FLeftPinArea;
    alTop:    Result := FTopPinArea;
    alRight:  Result := FRightPinArea;
    alBottom: Result := FBottomPinArea;
  else
    Assert(False);
    Result := nil; // Initialize.
  end;
end;

function TLMDDockElems.GetPinPanel(ASide: TAlign): TLMDPinPanelBase;
begin
  case ASide of
    alLeft:   Result := FLeftPinPanel;
    alTop:    Result := FTopPinPanel;
    alRight:  Result := FRightPinPanel;
    alBottom: Result := FBottomPinPanel;
  else
    Assert(False);
    Result := nil; // Initialize.
  end;
end;

function TLMDDockElems.GetSeqZone(AIsVert: Boolean): TLMDSeqZoneBase;
begin
  if AIsVert then
    Result := VertZone
  else
    Result := HorzZone;
end;

function TLMDDockElems.GetTabedArea(AIsDocHost: Boolean): TLMDTabedAreaBase;
begin
  if AIsDocHost then
    Result := DocsZone
  else
    Result := TabZone;
end;

function TLMDDockElems.GetTabedAreaButton(
  AIsDocHost: Boolean): TLMDTabedAreaBtnBase;
begin
  if AIsDocHost then
    Result := DocsZoneButton
  else
    Result := TabZoneButton;
end;

procedure TLMDDockElems.SetSiteBack(const Value: TLMDSiteBackElem);
begin
  FSiteBack := Value;
end;

{ TLMDPinAreaBase }

function TLMDPinAreaBase.GetSize(AFont: TFont): Integer;

  procedure InitSide;
  begin
    if Self is TLMDLeftPinAreaElem then
      FSide := alLeft
    else if Self is TLMDTopPinAreaElem then
      FSide := alTop
    else if Self is TLMDRightPinAreaElem then
      FSide := alRight
    else if Self is TLMDBottomPinAreaElem then
      FSide := alBottom
    else
      Assert(False);
  end;

label
  L;
var
  hc: Integer;
begin
  hc := GetTextHeight(AFont);
  if hc < 16 then
    hc := 16;
L:
  case FSide of
    alNone:     begin
                  InitSide;
                  goto L;
                end;
    alTop,
    alBottom:   begin
                  hc     := Content.UnadjustSize(0, hc).cy;
                  Result := TabContent.UnadjustSize(0, hc).cy;
                end;
    alLeft,
    alRight:    begin
                  hc     := Content.UnadjustSize(hc, 0).cx;
                  Result := TabContent.UnadjustSize(hc, 0).cx;
                end;
  else
    Assert(False);
    Result := 0; // Initialize.
  end;
end;

function TLMDPinAreaBase.GetSpacerSize: Integer;
begin
  Result := FSpacerSize;
end;

function TLMDPinAreaBase.GetTab(AIsHot: Boolean): TLMDElemState;
begin
  if AIsHot then
    Result := HotTab
  else
    Result := NormalTab;
end;

function TLMDPinAreaBase.GetTextColor(AIsHot: Boolean): TColor;
begin
  if AIsHot then
    Result := HotTextColor
  else
    Result := NormalTextColor;
end;

{ TLMDSeqZoneBase }

function TLMDSeqZoneBase.GetSplitterSize: Integer;
begin
  Result := FSplitterSize;
end;

{ TLMDSiteBackElem }

constructor TLMDSiteBackElem.Create(AStyle: TLMDDockStyle);
begin
  inherited;
  DragRectBack   := $00DF9D84;
  DragRectBorder := clWhite;
end;

procedure TLMDSiteBackElem.GetAreas(const R: TRect; AIsFloating,
  AIdDoc: Boolean; out AContent: TRect);
var
  c: TLMDMargins;
begin
  if AIdDoc then
    c := DocContent
  else if AIsFloating then
    c := FloatingContent
  else
    c := NormalContent;

  AContent := c.AdjustRect(R);
end;

function TLMDSiteBackElem.GetBack(AIsFloating,
  AIdDoc: Boolean): TLMDElemState;
begin
  if AIdDoc then
    Result := Doc
  else if AIsFloating then
    Result := Floating
  else
    Result := Normal;
end;

{ TLMDSideHotspotBase }

function TLMDSideHotspotBase.GetActiveArea(AEnabled: Boolean;
  AArea: TLMDActiveArea; out AState: TLMDElemState): Boolean;
label
  L;
var
  allowed: TLMDActiveArea;
begin
  Result := False;
L:
  case FSide of
    alNone:   begin
                InitSide;
                goto L;
              end;
    alLeft:   allowed := hsaSiteLeft;
    alTop:    allowed := hsaSiteTop;
    alRight:  allowed := hsaSiteRight;
    alBottom: allowed := hsaSiteBottom;
  else
    Assert(False);
    allowed := TLMDActiveArea(-1); // Initialize.
  end;

  if AArea = allowed then
  begin
    if AEnabled then
      AState := Enabled
    else
      AState := Disabled;
    Result := True;
  end;
end;

procedure TLMDSideHotspotBase.GetAreas(out ALayout: TLMDHotSpotLayout);
label
  L;
var
  cr: TRect;
begin
  cr := Bounds(0, 0, FWidth, FHeight);
  FillChar(ALayout, SizeOf(ALayout), 0);
L:
  case FSide of
    alNone:   begin
                InitSide;
                goto L;
              end;
    alLeft:   ALayout[hsaSiteLeft]   := cr;
    alTop:    ALayout[hsaSiteTop]    := cr;
    alRight:  ALayout[hsaSiteRight]  := cr;
    alBottom: ALayout[hsaSiteBottom] := cr;
  else
    Assert(False);
  end;
end;

procedure TLMDSideHotspotBase.InitSide;
begin
  if Self is TLMDLeftHotspotElem then
    FSide := alLeft
  else if Self is TLMDTopHotspotElem then
    FSide := alTop
  else if Self is TLMDRightHotspotElem then
    FSide := alRight
  else if Self is TLMDBottomHotspotElem then
    FSide := alBottom
  else
    Assert(False);
end;

{ TLMDCrossHotspotBase }

function TLMDCrossHotspotBase.GetActiveArea(AEnabled: Boolean;
  AArea: TLMDActiveArea; out AState: TLMDElemState): Boolean;
const
  INDEXES: array[TLMDActiveArea, Boolean] of Integer = (
    (-1, -1), // hsaSiteLeft
    (-1, -1), // hsaSiteTop
    (-1, -1), // hsaSiteRight
    (-1, -1), // hsaSiteBottom
    ( 2,  1), // hsaZoneLeft
    ( 4,  3), // hsaZoneTop
    ( 6,  5), // hsaZoneRight
    ( 8,  7), // hsaZoneBottom
    (10,  9), // hsaDocsLeft
    (12, 11), // hsaDocsTop
    (14, 13), // hsaDocsRight
    (16, 15), // hsaDocsBottom
    (18, 17), // hsaTabs
    (-1, -1), // hsaSplitters
    (-1, -1)  // hsaTabAreas
  );
var
  idx: Integer;
begin
  idx := INDEXES[AArea, AEnabled];
  if idx <> -1 then
  begin
    AState := GetState(idx);
    Result := True;
  end
  else
    Result := False;
end;

procedure TLMDCrossHotspotBase.GetAreas(out ALayout: TLMDHotSpotLayout);
const
  MARGINS: array[TLMDActiveArea] of Integer = (
    -1, // hsaSiteLeft
    -1, // hsaSiteTop
    -1, // hsaSiteRight
    -1, // hsaSiteBottom
     0, // hsaZoneLeft
     1, // hsaZoneTop
     2, // hsaZoneRight
     3, // hsaZoneBottom
     4, // hsaDocsLeft
     5, // hsaDocsTop
     6, // hsaDocsRight
     7, // hsaDocsBottom
     8, // hsaTabs
    -1, // hsaSplitters
    -1  // hsaTabAreas
  );
var
  cr:   TRect;
  a:    TLMDActiveArea;
  midx: Integer;
begin
  cr := Bounds(0, 0, FWidth, FHeight);
  for a := Low(ALayout) to High(ALayout) do
  begin
    midx := MARGINS[a];
    if midx <> -1 then
      ALayout[a] := GetMargins(midx).AdjustRect(cr)
    else
      ALayout[a] := Rect(0, 0, 0, 0);
  end;
end;

{ TLMDPanelElem }

procedure TLMDPanelElem.GetAreas(const R: TRect; AShowCaption: Boolean;
  AFont: TFont; out ACaption, AContent: TRect);
var
  hc:     Integer;
  fr, cr: TRect;
begin
  fr := R;
  hc := GetTextHeight(AFont);
  if hc < 16 then
    hc := 16;
  hc := hc + CaptionContent.Top + CaptionContent.Bottom;

  if AShowCaption then
  begin
    cr        := fr;
    cr.Bottom := cr.Top + hc;
    fr.Top    := cr.Bottom;
  end
  else
    cr := Rect(0, 0, 0, 0);

  ACaption := NormalizeRect(cr);
  AContent := NormalizeRect(fr);
end;

function TLMDPanelElem.GetCaption(AIsActive: Boolean): TLMDElemState;
begin
  if AIsActive then
    Result := ActiveCaption
  else
    Result := InactiveCaption;
end;

function TLMDPanelElem.GetFiller(AIsActive: Boolean): TLMDElemState;
begin
  if AIsActive then
    Result := ActiveFiller
  else
    Result := InactiveFiller;
end;

function TLMDPanelElem.GetTextColor(AIsActive: Boolean): TColor;
begin
  if AIsActive then
    Result := ActiveTextColor
  else
    Result := InactiveTextColor;
end;

{ TLMDCaptionFrameBase }

function TLMDCaptionFrameBase.HasCaption: Boolean;
begin
  Result := True;
end;

{ TLMDTabedAreaBtnBase }

function TLMDTabedAreaBtnBase.DoGetArea(const AParent: TRect;
  AMargins: TLMDMargins): TRect;
begin
  Result := DoGetArea(AParent, FWidth, FHeight, AMargins);
end;

function TLMDTabedAreaBtnBase.DoGetArea(const AParent: TRect; AWidth,
  AHeight: Integer; AMargins: TLMDMargins): TRect;
var
  sz: TSize;
  r:  TRect;
begin
  sz := AMargins.UnadjustSize(AWidth, AHeight);

  r.Left   := AParent.Right - sz.cx;
  r.Top    := (AParent.Top + AParent.Bottom - sz.cy) div 2;
  r.Right  := AParent.Right;
  r.Bottom := r.Top + sz.cy;

  Result := AMargins.AdjustRect(r);
end;

{ TLMDTabZoneButtonElem }

procedure TLMDTabZoneButtonElem.GetCloseArea(const AParent: TRect;
  out AButton: TRect);
begin
  AButton := DoGetArea(AParent, CloseMargins);
end;

procedure TLMDTabZoneButtonElem.GetGroupAreas(const AParent: TRect;
  AKinds: TLMDTabBtnKinds; out AButtons: TLMDTabBtnAreas; out AGroup: TRect);
begin
  Assert(AKinds = []);
  AGroup := Rect(0, 0, 0, 0);
end;

function TLMDTabZoneButtonElem.GetStates(AKind: TLMDTabBtnKind;
  AState: TLMDTabedAreaBtnState): TLMDElemState;
const
  STATE_INDEXES: array[TLMDTabBtnKind, 0..9] of Integer = (
    //         Inactive          |       Active
    //N     S    TH     H     D     N     S    TH     H     D
    ( 0,    1,    2,    3,    4,    0,    1,    2,    3,    4),
    (-1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1),
    (-1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1),
    (-1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1)
  );
var
  idx: Integer;
  st:  Integer;
begin
  idx := 0;

  if tbsAreaActive in AState then
    Inc(idx, 5);
  if tbsHot in AState then
  begin
    if tbsHotDown in AState then
      Inc(idx, 4)
    else
      Inc(idx, 3)
  end
  else if tbsTabSelected in AState then
    Inc(idx)
  else if tbsTabHot in AState then
    Inc(idx, 2);

  st := STATE_INDEXES[AKind, idx];
  if st <> -1 then
    Result := GetState(st)
  else
    Result := nil;
end;

function TLMDTabZoneButtonElem.ShowButtons: TLMDTabBtnKinds;
const
  CLOSE_BTN: array[Boolean] of TLMDTabBtnKinds = ([], [tbClose]);
begin
  Result := CLOSE_BTN[FShowClose];
end;

{ TLMDDocsZoneButtonElem }

procedure TLMDDocsZoneButtonElem.GetCloseArea(const AParent: TRect;
  out AButton: TRect);
begin
  AButton := DoGetArea(AParent, CloseMargins);
end;

procedure TLMDDocsZoneButtonElem.GetGroupAreas(const AParent: TRect;
  AKinds: TLMDTabBtnKinds; out AButtons: TLMDTabBtnAreas; out AGroup: TRect);
var
  i:      TLMDTabBtnKind;
  cnt, x: Integer;
  gcr:    TRect;
begin
  cnt := 0;

  for i := Low(TLMDTabBtnKind) to High(TLMDTabBtnKind) do
    if i in AKinds then
      Inc(cnt);

  if cnt > 0 then
  begin
    gcr := DoGetArea(AParent, FWidth * cnt, FHeight, GroupContent);
    x   := gcr.Left;

    for i := Low(TLMDTabBtnKind) to High(TLMDTabBtnKind) do
      if i in AKinds then
      begin
        AButtons[i] := Rect(x, gcr.Top, x + FWidth, gcr.Bottom);
        Inc(x, FWidth);
      end;

    AGroup := GroupContent.UnadjustRect(gcr);
  end
  else
    AGroup := Rect(0, 0, 0, 0);
end;

function TLMDDocsZoneButtonElem.GetStates(AKind: TLMDTabBtnKind;
  AState: TLMDTabedAreaBtnState): TLMDElemState;
const
  STATE_INDEXES: array[TLMDTabBtnKind, 0..9] of Integer = (
    //         Inactive          |       Active
    //N     S    TH     H     D     N     S    TH     H     D
    ( 0,    1,    4,    5,    6,    2,    3,    4,    5,    6),
    ( 7,    7,    7,    9,   10,    8,    8,    8,    9,   10),
    (11,   11,   11,   13,   14,   12,   12,   12,   13,   14),
    (15,   15,   15,   17,   18,   16,   16,   16,   17,   18)
  );
var
  idx: Integer;
  st:  Integer;
begin
  idx := 0;

  if tbsAreaActive in AState then
    Inc(idx, 5);
  if tbsHot in AState then
  begin
    if tbsHotDown in AState then
      Inc(idx, 4)
    else
      Inc(idx, 3)
  end
  else if tbsTabSelected in AState then
    Inc(idx)
  else if tbsTabHot in AState then
    Inc(idx, 2);

  st := STATE_INDEXES[AKind, idx];
  if st <> -1 then
    Result := GetState(st)
  else
    Result := nil;
end;

function TLMDDocsZoneButtonElem.ShowButtons: TLMDTabBtnKinds;
const
  CLOSE_BTN: array[Boolean] of TLMDTabBtnKinds = ([], [tbClose]);
begin
  Result := [tbMenu, tbLeft, tbRight] + CLOSE_BTN[FShowClose];
end;

initialization
  DockStyles.DefineElements(TLMDDockElems);
  DockStyles.Register('VS2005', 'LMD_VS2005_DOCKSTYLE');
  DockStyles.Register('VS2010', 'LMD_VS2010_DOCKSTYLE');
  DockStyles.Register('VS2012', 'LMD_VS2012_DOCKSTYLE', True);
  DockStyles.Register('VS2012Dark', 'LMD_VS2012DARK_DOCKSTYLE');
  DockStyles.Register('VS2012Blue', 'LMD_VS2012BLUE_DOCKSTYLE');
  DockStyles.Register('VCLStyle', 'LMD_VCLSTYLE_DOCKSTYLE');

end.
