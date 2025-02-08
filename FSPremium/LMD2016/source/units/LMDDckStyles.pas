unit LMDDckStyles;
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

LMDDckStyles unit (YB)
----------------------
Visual Styles sub-system for LMD-DockingPack.

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, Classes, Variants, Graphics, SysUtils, Controls, Forms,
  GraphUtil, StrUtils, TypInfo, Math, RTLConsts, Themes, Registry, intfLMDBase,
  LMDUnicode, LMDTypes, LMDHashTable, LMDStrings, LMDXML, LMDDckClass, LMDDckCst;

type
  ELMDDockStyles      = class(Exception);
  TLMDDockStyles      = class;
  TLMDDockStyle       = class;
  TLMDStateLayer      = class;
  TLMDStateLayerClass = class of TLMDStateLayer;
  TLMDBuffer          = class;
  TLMDElemState       = class;
  TLMDStyleElem       = class;
  TLMDStyleElemClass  = class of TLMDStyleElem;
  TLMDElemSet         = class;
  TLMDElemSetClass    = class of TLMDElemSet;

  { ********************************* Common ********************************* }

  TLMDEnumPropProc = procedure(AProp: TLMDPropInfo; AData: Pointer) of object;

  {$M+}
  TLMDStyleObject = class(TObject) // RTTI enabled.
  public
    class procedure EnumProps(AProc: TLMDEnumPropProc; AData: Pointer);
  end;
  {$M-}

  TLMDValType    = (vtString, vtNode);
  TLMDNodeGetter = function: ILMDXmlElement of object;

  TLMDValueObject = class(TLMDStyleObject)
  protected
    function Write(var V): TLMDValType; virtual; abstract;
    function Read(AType: TLMDValType; const V): Boolean; virtual; abstract;
  end;

  TLMDMargins = class(TLMDValueObject)
  private
    FNext:   TLMDMargins;
    FRight:  Integer;
    FBottom: Integer;
    FTop:    Integer;
    FLeft:   Integer;

    function  GetAsString: TLMDString;
    procedure SetAsString(const Value: TLMDString);
  protected
    function Write(var V): TLMDValType; override;
    function Read(AType: TLMDValType; const V): Boolean; override;
  public
    function AdjustRect(const R: TRect): TRect;
    function AdjustSize(const R: TRect): TSize; overload;
    function AdjustSize(ASize: TSize): TSize; overload;
    function AdjustSize(AWidth, AHeight: Integer): TSize; overload;
    function UnadjustRect(const R: TRect): TRect;
    function UnadjustSize(const R: TRect): TSize; overload;
    function UnadjustSize(ASize: TSize): TSize; overload;
    function UnadjustSize(AWidth, AHeight: Integer): TSize; overload;
    function IsEqualTo(M: TLMDMargins): Boolean;
    property AsString: TLMDString read GetAsString write SetAsString;
    property Left: Integer read FLeft write FLeft;
    property Top: Integer read FTop write FTop;
    property Right: Integer read FRight write FRight;
    property Bottom: Integer read FBottom write FBottom;
  end;

  TLMDRegion = class(TLMDValueObject)
  private
    FRect:    TRect;
    function  GetInt(const Index: Integer): Integer;
    procedure SetInt(const Index, Value: Integer);
  protected
    function Write(var V): TLMDValType; override;
    function Read(AType: TLMDValType; const V): Boolean; override;
  public
    function IsEmpty: Boolean;
    property Rect: TRect read FRect write FRect;
    property Left: Integer index 0 read GetInt write SetInt;
    property Top: Integer index 1 read GetInt write SetInt;
    property Right: Integer index 2 read GetInt write SetInt;
    property Bottom: Integer index 3 read GetInt write SetInt;
    property Width: Integer index 4 read GetInt;
    property Height: Integer index 5 read GetInt;
  end;

  { ******************************** TLMDColor ******************************* }

  ELMDColor = class(Exception);

  ILMDColor = interface
    function Get: TColor;
  end;

  TLMDColorVal = record
    Simple:  TColor;
    Complex: ILMDColor;
  end;

  TLMDEnumProc = procedure(AData: Pointer; const AName: TLMDString;
                           AValue: Integer) of object;

  TLMDColorToken = (ctIdent, ctInteger, ctOpenRound, ctCloseRound, ctComma,
                    ctEof);
  TLMDTokenData = record
    S: TLMDString;
    I: Integer;
  end;

  TLMDColor = class(TInterfacedObject, ILMDColor)
  private
    FByteCode: array of Byte;

    {$IFDEF LMDCOMP16}
    function  GetDetails(AElem: TThemedElement;
                         APart: Integer): TThemedElementDetails;
    class procedure GetEnumNames(AEnum: PTypeInfo; AProc: TLMDEnumProc;
                                 AData: Pointer);
    {$ENDIF}
    function  Grow(ASize: Integer): PByte;
    procedure EmitByte(V: Byte);
    procedure EmitInt(V: Integer);
    procedure Emit(const V; ASize: Integer);
    procedure Compile(var P: PLMDChar);
    function  Interpret(var P: PByte): TColor;
    function  IsSimple(out C: TColor): Boolean;

    class procedure AddIdent(const KI);
    {$IFDEF LMDCOMP16}
    class procedure AddStyleColor(AData: Pointer; const AName: TLMDString;
                                  AValue: Integer);
    class procedure AddFontColor(AData: Pointer; const AName: TLMDString;
                                 AValue: Integer);
    class procedure AddElemPart(AData: Pointer; const AName: TLMDString;
                                AValue: Integer);
    class procedure AddElemColor(AData: Pointer; const AName: TLMDString;
                                 AValue: Integer);
    class procedure AddElemParts(AElem: TThemedElement; AParts: PTypeInfo);
    {$ENDIF}
    class procedure AddHighlight;
    class procedure AddShadow;
    class procedure AddBlend;
    class procedure AddAccent;
    class procedure AddAccentText;
    class procedure InitKnownIdents;
    class function  TryGetKnownIdent(const S: TLMDString; out KI): Boolean;

    class procedure SyntaxError;
    class function  MakeInteger(S, E: PLMDChar): Integer;
    class function  NextToken(var P: PLMDChar;
                              var AData: TLMDTokenData): TLMDColorToken;
    class procedure CheckAndSkip(var P: PLMDChar; AToken: TLMDColorToken); overload;
    class procedure CheckAndSkip(var P: PLMDChar; AToken: TLMDColorToken;
                                 var AData: TLMDTokenData); overload;
  protected
    { ILMDColor }
    function Get: TColor; overload;
  public
    class function  Make(C: TColor): TLMDColorVal; overload;
    {$IFDEF LMDCOMP16}
    class function  Make(C: TStyleColor): TLMDColorVal; overload;
    class function  Make(C: TStyleFont): TLMDColorVal; overload;
    class function  Make(AElem: TThemedElement; APart: Integer;
                         C: TElementColor): TLMDColorVal; overload;
    {$ENDIF}
    class function  Parse(const S: TLMDString): TLMDColorVal;

    class function  Get(const C: TLMDColorVal): TColor; overload;
    class procedure BeginSetProp(const C: TLMDColorVal; out V: TColor); overload;
    class procedure BeginSetProp(const S: TLMDString; out V: TColor); overload;
    class procedure PropSetter(var C: TLMDColorVal; V: TColor);
    class procedure EndSetProp;
  end;

  { ******************************* TLMDBuffer ******************************* }

  PLMDPixels = ^TLMDPixels;
  TLMDPixels = array[0..1024] of DWORD;

  TLMDBufferCanvas = class(TCanvas)
  private
    FDC:       HDC;
    FDefDIB:   HBITMAP;
    FSelected: TLMDBuffer;
    function   GetDC: HDC;
    procedure  FreeDC;
  protected
    procedure DoSelect;
    procedure CreateHandle; override;
  public
    constructor Create; overload;
    constructor Create(ABuffer: TLMDBuffer); overload;
    destructor  Destroy; override;

    procedure  Select(ABuffer: TLMDBuffer);
    property   Selected: TLMDBuffer read FSelected;
    property   DC: HDC read GetDC; // Allows to get DC only, without
                                   // initializing standard TCanvas
                                   // features (handle, brush, pen).
  end;

  TLMDBufferFormat = (bf24bit, bf32bit);

  TLMDBuffer = class
  private
    FFormat:     TLMDBufferFormat;
    FWidth:      Integer;
    FHeight:     Integer;
    FSelectedIn: TLMDBufferCanvas;
    FDefCanvas:  TLMDBufferCanvas; // Lazy inited.
    FDIB:        HBITMAP;
    FData:       PLMDPixels;
    FOldSize:    Integer;

    procedure RecreateDIB;
    procedure FinalizeDIB;
    procedure AdjustStatistic;
  protected
    function GetCanvas: TCanvas; virtual;
  public
    constructor Create(AFormat: TLMDBufferFormat = bf32bit); overload;
    constructor Create(AWidth, AHeight: Integer;
                       AFormat: TLMDBufferFormat = bf32bit); overload;
    destructor Destroy; override;

    class procedure BeginDraw(ACanvas: TCanvas; const R: TRect);
    class procedure EndDraw;
    class function  Allocated: Integer;
    class function  MaxAllocated: Integer;

    procedure Resize(AWidth, AHeight: Integer);
    function  ScanLine(ALine: Integer): PLMDPixels;
    property  Format: TLMDBufferFormat read FFormat;
    property  Width: Integer read FWidth;
    property  Height: Integer read FHeight;
    property  DIB: HBITMAP read FDIB;
    property  Data: PLMDPixels read FData;
    property  Canvas: TCanvas read GetCanvas;
  end;

  { ***************************** TLMDStateLayer ***************************** }

  TLMDRegionOpacity = (roEmpty, roTranslucent, roOpaque);
  TLMDDrawMode      = (dmBlt, dmBlend);

  TLMDGetStateClassProc = procedure(AClass: TLMDStateLayerClass;
                                    AData: Pointer) of object;

  TLMDGetStateClassData = record
    SType:  TLMDString;
    Result: TLMDStateLayerClass;
  end;

  TLMDStateLayer = class(TLMDStyleObject)
  private
    FNext:    TLMDStateLayer;
    FState:   TLMDElemState;
    FId:      Integer;
    FOpacity: TLMDRegionOpacity;
    FUpdated: Boolean;

    function  LayerTypeFilter(const AName: TLMDString): Boolean;
    procedure Write(const ANode: ILMDXmlElement);
    procedure Read(const ANode: ILMDXmlElement);

    class procedure GetClassProc(AClass: TLMDStateLayerClass;
                                 AData: Pointer);
  protected
    procedure InvaidateDrawInfo; virtual;
    function  UpdateDrawInfo: TLMDRegionOpacity; virtual; abstract;
    procedure Draw(C: TCanvas; const R: TRect;
                   AMode: TLMDDrawMode); virtual; abstract;
    function  GetMaster: TLMDBuffer;
    function  GetBitmap: TBitmap; // Non-premultiplied original
                                  // bitmap is required for recoloring.
    function  MasterOpacity(const R: TRect): TLMDRegionOpacity;
    procedure FillEmptyRect(C: TCanvas; const R: TRect);
  public
    constructor Create(AState: TLMDElemState); virtual;
    destructor Destroy; override;

    class function  GetType: TLMDString;
    class function  GetClass(const AType: TLMDString): TLMDStateLayerClass;
    class procedure GetLayerClasses(AData: Pointer; AProc: TLMDGetStateClassProc);

    property State: TLMDElemState read FState;
    property Id: Integer read FId;
  end;

  TLMDEmptyLayer = class(TLMDStateLayer)
  protected
    function  UpdateDrawInfo: TLMDRegionOpacity; override;
    procedure Draw(C: TCanvas; const R: TRect; AMode: TLMDDrawMode); override;
  end;

  TLMDColorLayer = class(TLMDStateLayer)
  private
    FColor:   TLMDColorVal;
    FAlpha:   Byte;
    FPattern: TLMDBuffer;
    FBrush:   HBRUSH;

    function  GetColor: TColor;
    procedure SetColor(const Value: TColor);
  protected
    function  UpdateDrawInfo: TLMDRegionOpacity; override;
    procedure Draw(C: TCanvas; const R: TRect; AMode: TLMDDrawMode); override;
  public
    constructor Create(AState: TLMDElemState); override;
    destructor Destroy; override;
  published
    property Color: TColor read GetColor write SetColor;
    property Alpha: Byte read FAlpha write FAlpha;
  end;

  TLMDStretchZone  = 0..8;
  TLMDStretchZones = set of TLMDStretchZone;

  TLMDStretchSizes = record
    case Integer of
      0: (CX: array[0..2] of Integer;
          CY: array[0..2] of Integer);
      1: (LM, X1, RM: Integer;
          TM, Y1, BM: Integer);
  end;

  TLMDRegionLayerBase = class(TLMDStateLayer)
  private
    FRegion:      TLMDRegion;
    FRecolored:   TLMDBuffer;
    FRecolorFrom: TLMDColorVal;
    FRecolorTo:   TLMDColorVal;

    function  GetRecolorFrom: TColor;
    procedure SetRecolorFrom(const Value: TColor);
    function  GetRecolorTo: TColor;
    procedure SetRecolorTo(const Value: TColor);
  protected
    procedure InvaidateDrawInfo; override;
    function  Recolor(AFrom, ATo: TColor): TLMDBuffer;
    function  RecoloredCanvas: TCanvas;
  public
    constructor Create(AState: TLMDElemState); override;
    destructor Destroy; override;
  published
    property Region: TLMDRegion read FRegion;
    property RecolorFrom: TColor read GetRecolorFrom write SetRecolorFrom;
    property RecolorTo: TColor read GetRecolorTo write SetRecolorTo;
  end;

  TLMDStretchLayer = class(TLMDRegionLayerBase)
  private
    FStretchMargins: TLMDMargins;
    FSrcSizes:       TLMDStretchSizes;
    FZnOpacity:      array[TLMDStretchZone] of TLMDRegionOpacity;
  protected
    function  UpdateDrawInfo: TLMDRegionOpacity; override;
    function  GetSizes(AWidth, AHeight, LM, TM,
                       RM, BM: Integer): TLMDStretchSizes;
    procedure Draw(C: TCanvas; const R: TRect; AMode: TLMDDrawMode); override;
  public
    constructor Create(AState: TLMDElemState); override;
    destructor Destroy; override;
  published
    property StretchMargins: TLMDMargins read FStretchMargins;
  end;

  TLMDCenterLayer = class(TLMDRegionLayerBase)
  protected
    function  UpdateDrawInfo: TLMDRegionOpacity; override;
    procedure Draw(C: TCanvas; const R: TRect; AMode: TLMDDrawMode); override;
  end;

  TLMDTileLayer = class(TLMDRegionLayerBase)
  private
    FPattern: TLMDBuffer;
    FBrush:   HBRUSH;
  protected
    function  UpdateDrawInfo: TLMDRegionOpacity; override;
    procedure Draw(C: TCanvas; const R: TRect; AMode: TLMDDrawMode); override;
  public
    constructor Create(AState: TLMDElemState); override;
    destructor Destroy; override;
  end;

  TLMDMyLayer = class(TLMDStateLayer)
  protected
    function  UpdateDrawInfo: TLMDRegionOpacity; override;
    procedure Draw(C: TCanvas; const R: TRect; AMode: TLMDDrawMode); override;
  end;

  { ****************************** TLMDElemState ***************************** }

  TLMDLayerFilter = function(L: TLMDStateLayer;
                             AData: Pointer): Boolean of object;

  TLMDElemState = class(TLMDValueObject)
  private
    FNext:   TLMDElemState;
    FElem:   TLMDStyleElem;
    FId:     Integer;
    FLayers: TLMDStateLayer;

    function  GetStyle: TLMDDockStyle;
    function  GetLayerCount: Integer;
    function  GetLayers(AIndex: Integer): TLMDStateLayer;
    function  GetFirst: TLMDStateLayer;
    function  GetLast: TLMDStateLayer;
    procedure InsertLayer(AItem: TLMDStateLayer; AIndex: Integer);
    procedure RemoveLayer(AItem: TLMDStateLayer);
    function  RegionFromBuffer(B: TLMDBuffer; const R: TRect): HRGN;
    procedure DoDraw(C: TCanvas; AMode: TLMDDrawMode; const R: TRect;
                     L: TLMDStateLayer = nil);
    procedure InvaidateDrawInfo;
  protected
    function Write(var V): TLMDValType; override;
    function Read(AType: TLMDValType; const V): Boolean; override;
  public
    constructor Create(AElem: TLMDStyleElem);
    destructor Destroy; override;

    function  Opacity: TLMDRegionOpacity;
    procedure Draw(ACanvas: TCanvas; const R: TRect);
    procedure DrawLayer(ACanvas: TCanvas; const R: TRect; // Slow; for designer
                        L: TLMDStateLayer);               // use only.
    function  MakeRegion(const R: TRect): HRGN;
    procedure Clear;
    function  Add(AClass: TLMDStateLayerClass): TLMDStateLayer;
    procedure AddLayers(AStream: TStream);
    procedure MoveLayer(AFrom, ATo: Integer);
    function  LayerById(AId: Integer): TLMDStateLayer;
    procedure LayersToStream(AStream: TStream; AFilter: TLMDLayerFilter;
                             AData: Pointer);
    property  Id: Integer read FId;
    property  LayerCount: Integer read GetLayerCount;
    property  Layers[AIndex: Integer]: TLMDStateLayer read GetLayers; default;
    property  First: TLMDStateLayer read GetFirst;
    property  Last: TLMDStateLayer read GetLast;
    property  Elem: TLMDStyleElem read FElem;
    property  Style: TLMDDockStyle read GetStyle;
  end;

  { ****************************** TLMDStyleElem ***************************** }

  TLMDStyleColor = class
  private
    FNext:  TLMDStyleColor;
    FColor: TLMDColorVal;
  end;

  TLMDStyleElem = class(TLMDStyleObject)
  private
    FStyle:   TLMDDockStyle;
    FStates:  TLMDElemState;
    FMargins: TLMDMargins;
    FColors:  TLMDStyleColor;

    procedure InvalidateDrawInfo;
    function  GetColorItem(AIndex: Integer): TLMDStyleColor;
  protected
    procedure Write(const ANode: ILMDXmlElement); virtual;
    procedure Read(const ANode: ILMDXmlElement); virtual;
    function  GetState(const Index: Integer): TLMDElemState;
    function  GetMargins(const Index: Integer): TLMDMargins;
    function  GetColor(const Index: Integer): TColor;
    procedure SetColor(const Index: Integer; Value: TColor);
  public
    constructor Create(AStyle: TLMDDockStyle); virtual;
    destructor Destroy; override;

    class function GetName: TLMDString; virtual;
    property       Style: TLMDDockStyle read FStyle;
  end;

  { ****************************** TLMDElemSet ******************************* }

  TLMDElemSetChange  = (escProps, escBitmap, escReloaded);
  TLMDElemSetChanges = set of TLMDElemSetChange;
  TLMDElemSetChanged = procedure(Sender: TObject; AChanges:
                                 TLMDElemSetChanges) of object;

  TLMDElemSet = class(TLMDStyleObject)
  private
    FStyle:    TLMDDockStyle;
    FOnChange: TLMDElemSetChanged;

    procedure SetStyle(const Value: TLMDDockStyle);
    procedure AssignElemProc(AProp: TLMDPropInfo; AData: Pointer);
    procedure AssignElems;
  protected
    procedure Changed(AChanges: TLMDElemSetChanges); virtual;
  public
    constructor Create; overload;
    constructor Create(AStyle: TLMDDockStyle); overload;
    property    Style: TLMDDockStyle read FStyle write SetStyle;
    property    OnChange: TLMDElemSetChanged read FOnChange write FOnChange;
  published
    // property MyElem1: TMyElem1;
    // property MyElem2: TMyElem2;
    // ...
  end;

  { **************************** TLMDStyleSource ***************************** }

  TLMDStyleDataKind   = (sdkXml, sdkBmp);
  TLMDStyleSourceProc = procedure(AKind: TLMDStyleDataKind;
                                  AStream: TStream) of object;

  TLMDStyleSource = class
  protected
    procedure Read(AProc: TLMDStyleSourceProc); virtual; abstract;
    procedure Write(AProc: TLMDStyleSourceProc); virtual; abstract;
  end;

  TLMDFileSource = class(TLMDStyleSource)
  private
    FFileName: TLMDString;
    procedure  CallProc(AKind: TLMDStyleDataKind; AMode: Word;
                        AProc: TLMDStyleSourceProc);
  protected
    procedure Read(AProc: TLMDStyleSourceProc); override;
    procedure Write(AProc: TLMDStyleSourceProc); override;
  public
    constructor Create(const AFileName: TLMDString);
    property    FileName: TLMDString read FFileName;
  end;

  TLMDResourceSource = class(TLMDStyleSource)
  private
    FResName: TLMDString;
    procedure CallProc(AKind: TLMDStyleDataKind;
                       AProc: TLMDStyleSourceProc);
  protected
    procedure Read(AProc: TLMDStyleSourceProc); override;
    procedure Write(AProc: TLMDStyleSourceProc); override;
  public
    constructor Create(const AResName: TLMDString);
    property    ResName: TLMDString read FResName;
  end;

  { ***************************** TLMDDockStyle ****************************** }

  TLMDDockStyleState = set of (dssLoading, dssValid, dssReloaded,
                               dssBitmapChanged);
  TLMDStyleName      = type TLMDString;

  TLMDDockStyle = class
  private
    FState:        TLMDDockStyleState;
    FStyles:       TLMDDockStyles;
    FName:         TLMDStyleName;
    FLazy:         TLMDStyleSource;  // Data for lazy initialization.
    FOwnLazy:      Boolean;          //
    FXml:          ILMDXmlDocument;
    FBitmap:       TBitmap;          // Original bitmap in a non-premultiplied
                                     // format. Used for saving the style.
    FMaster:       TLMDBuffer;
    FElems:        TList;
    FElemSets:     TList;

    procedure ClearElems;
    procedure InvalidateDrawInfo;
    function  CreateElemNode(AElem: TLMDStyleElem): ILMDXmlElement;
    procedure InsertElemSet(AElemSet: TLMDElemSet);
    procedure RemoveElemSet(AElemSet: TLMDElemSet);
    procedure ReassignSetsElems;
    procedure UpdateMaster;
    procedure BitmapChanged(Sender: TObject);
    procedure SaveProc(AKind: TLMDStyleDataKind; AStream: TStream);
    procedure LoadProc(AKind: TLMDStyleDataKind; AStream: TStream);
    procedure SetBitmap(const Value: TBitmap);
  public
    constructor Create(AStyles: TLMDDockStyles; const AName: TLMDStyleName);
    constructor CreateLazy(AStyles: TLMDDockStyles; const AName: TLMDStyleName;
                           ASource: TLMDStyleSource; AOwnSource: Boolean);
    destructor Destroy; override;

    { Changed method need to be called manually, after any changes to
      the style, including changes of element properties or style bitmap.
      This is designed so to simplify style elements development. }

    function  GetMaster: TLMDBuffer;
    function  GetElem(AClass: TLMDStyleElemClass): TLMDStyleElem;
    procedure Changed;
    procedure Save(ASource: TLMDStyleSource);
    procedure Load(ASource: TLMDStyleSource);
    procedure SaveToFile(const AFileName: TLMDString);
    procedure LoadFromFile(const AFileName: TLMDString);
    procedure LoadFromResource(const AResName: TLMDString);
    property  Name: TLMDStyleName read FName;
    property  Bitmap: TBitmap read FBitmap write SetBitmap;
  end;

  { **************************** TLMDDockStyles ****************************** }

  TLMDRegisteredSource = class
  private
    FStyles:    TLMDDockStyles;
    FName:      TLMDStyleName;
    FIsDefault: Boolean;
    FSource:    TLMDStyleSource;
  public
    constructor Create(AStyles: TLMDDockStyles; const AName: TLMDStyleName;
                       AIsDefault: Boolean; ASource: TLMDStyleSource);
    destructor Destroy; override;

    property Name: TLMDStyleName read FName;
    property IsDefault: Boolean read FIsDefault;
    property Source: TLMDStyleSource read FSource;
  end;

  TLMDDockStyles = class
  private
    FStyles:       TList;
    FRegSources:   TList;
    FDefaultStyle: TLMDDockStyle;
    FDefinedSets:  TList;   // List of TLMDElemSetClass.
    FDefinedElems: TList;   // List of TLMDStyleElemClass.
    FNextId:       Integer;
    FBitmapCache:  TObject;

    procedure InsertStyle(AStyle: TLMDDockStyle);
    procedure RemoveStyle(AStyle: TLMDDockStyle);
    procedure InsertRegSource(ASource: TLMDRegisteredSource);
    procedure RemoveRegSource(ASource: TLMDRegisteredSource);
    function  TryGetElemClass(const AName: TLMDString;
                              out AClass: TLMDStyleElemClass): Boolean;
    procedure DefineElemProc(AProp: TLMDPropInfo; AData: Pointer);
    function  EnsureLazyInit(AStyle: TLMDDockStyle): TLMDDockStyle;
    function  GetNextId: Integer;
    function  GetCount: Integer;
    function  GetStyle(AIndex: Integer): TLMDDockStyle;
    function  GetDefaultStyle: TLMDDockStyle;
    function  GetRegSourceCount: Integer;
    function  GetRegSources(Index: Integer): TLMDRegisteredSource;
    function  GetDefaultRegSource: TLMDRegisteredSource;
  protected
    {$IFDEF LMDCOMP16}
    procedure VCLStyleChanged;
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;

    procedure Register(const AName: TLMDStyleName; AResName: TLMDString;
                       ADefault: Boolean = False);
    procedure DefineElements(AElementSet: TLMDElemSetClass);

    procedure Changed;
    function  Add(const AName: TLMDStyleName): TLMDDockStyle; overload;
    function  Add(const AName: TLMDStyleName; ASource:
                  TLMDStyleSource): TLMDDockStyle; overload;
    procedure AddLazy(const AName: TLMDStyleName; ASource: TLMDStyleSource;
                      AOwnSource: Boolean);
    function  TryGetByName(const AName: TLMDStyleName;
                           out AStyle: TLMDDockStyle): Boolean;
    function  GetByName(const AName: TLMDStyleName): TLMDDockStyle;
    property  Count: Integer read GetCount;
    property  DefaultStyle: TLMDDockStyle read GetDefaultStyle;
    property  Style[AIndex: Integer]: TLMDDockStyle read GetStyle; default;
    property  RegSourceCount: Integer read GetRegSourceCount;
    property  RegSources[Index: Integer]: TLMDRegisteredSource read GetRegSources;
    property  DefaultRegSource: TLMDRegisteredSource read GetDefaultRegSource;
  end;

  TLMDColorProc = procedure(var C: TColor);

var
  DockStyles:      TLMDDockStyles;
  OnGetAccent:     TLMDColorProc;
  OnGetAccentText: TLMDColorProc;

function  LMDAccent: TColor;
function  LMDAccentText: TColor;
function  LMDBlend(ABase, C: TColor; Alpha: Integer): TColor;
function  LMDHighlight(C: TColor; Amount: Integer): TColor;
function  LMDShadow(C: TColor; Amount: Integer): TColor;

implementation

type
  {$IFDEF LMDCOMP16}
  PThemedElement = ^TThemedElement;
  PStyleColor    = ^TStyleColor;
  PStyleFont     = ^TStyleFont;
  PElementColor  = ^TElementColor;
  {$ENDIF}

  TKnownIdentKind = ({$IFDEF LMDCOMP16} kikStyleColor, kikFontColor,
                     kikElemPart, kikElemColor,{$ENDIF} kikHighlight,
                     kikShadow, kikBlend, kikAccent, kikAccText);
  TKnownIdent = record
    Key:  TLMDString; // Lower cased.
    Kind: TKnownIdentKind;
    {$IFDEF LMDCOMP16}
    case TKnownIdentKind of
      kikStyleColor: (StyleColor: TStyleColor);
      kikFontColor:  (FontColor: TStyleFont);
      kikElemPart:   (Elem: TThemedElement; Part: Integer);
      kikElemColor:  (ElemColor: TElementColor);
    {$ENDIF}
  end;

  TKnownIdentItem = class
  public
    Value: TKnownIdent;
  end;

  TKnownIdentTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

  PSetProp = ^TSetProp;
  TSetProp = record
    Val:  TLMDColorVal;
    Next: PSetProp;
  end;

  TFilterProc = function(const AName: TLMDString): Boolean of object;

  TWriteData = class
  private
    FInstance: TObject;
    FNode:     ILMDXmlElement;
    FPropName: TLMDString;
  public
    constructor Create(AInstance: TObject; const ANode: ILMDXmlElement);
    function    NodeGetter: ILMDXmlElement;
    property    Instance: TObject read FInstance;
    property    Node: ILMDXmlElement read FNode;
    property    PropName: TLMDString read FPropName write FPropName;
  end;

  TReadData = class
  private
    FNode: ILMDXmlElement;
  public
    function NodeGetter: ILMDXmlElement;
    property Node: ILMDXmlElement read FNode write FNode;
  end;

  TXmlUtils = class
  private
    class function  GetObjectProp(AInstance: TObject;
                                  AProp: TLMDPropInfo): TLMDValueObject;
    class procedure WritePropProc(AProp: TLMDPropInfo; AData: Pointer);
    class procedure AddToListProc(AProp: TLMDPropInfo; AData: Pointer);
  public
    class function  ValToStr(AType: TLMDValType; const V): TLMDString;
    class function  ParseInts(const V: TLMDString; ABuffSize: Integer;
                              ABuff: PInteger): Integer;
    class procedure WriteProps(AInstance: TLMDStyleObject;
                               const ANode: ILMDXmlElement);
    class procedure ReadProps(AInstance: TLMDStyleObject;
                              const ANode: ILMDXmlElement;
                              AFilter: TFilterProc);
  end;

  TCanvasList = class
  private
    FItems: TList;
    FWnd:   HWND;

    procedure InsertItem(ACanvas: TLMDBufferCanvas);
    procedure RemoveItem(ACanvas: TLMDBufferCanvas);
    procedure WndProc(var Msg: TMessage);
  protected
    procedure FreeContexts;
  public
    constructor Create;
    destructor  Destroy; override;
  end;

  TBitmapCache = class;

  TCacheItem = class(TLMDBuffer)
  private
    FCache:  TBitmapCache;
    FNext:   TCacheItem;
    FTicks:  Cardinal;
    FId:     Integer;
    FDrawnW: Integer;
    FDrawnH: Integer;
  protected
    function GetCanvas: TCanvas; override;
  public
    constructor Create(ACache: TBitmapCache); overload;
    constructor Create(ACache: TBitmapCache; AWidth, AHeight:
                       Integer; AFormat: TLMDBufferFormat); overload;
  end;

  TBufferState = (bsRedraw, bsOk);

  TBitmapCache = class
  private
    FItems:   TCacheItem;
    FLastGC:  Cardinal;
    FCanvas:  TLMDBufferCanvas;
    procedure RunGC;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    function  GetBuffer(AId, AWidth, AHeight: Integer; AFormat:
                        TLMDBufferFormat; out B: TLMDBuffer): TBufferState;
  end;

  TBufDrawData = class
  private
    FNext:    TBufDrawData;
    FInited:  Boolean;
    FCanvas:  TCanvas;
    FR:       TRect;
    FOldDC:   HDC;
    FBuffer:  TLMDBuffer;
    FBufDC:   TLMDBufferCanvas;

    procedure InitCanvas;
    procedure RestoreCanvas;
  public
    constructor Create(ACanvas: TCanvas; const R: TRect);
    destructor  Destroy; override;
    procedure   Flush; // Can be called only once.
  end;

const
  BC_INVALID    = 0; // Args: No args.
  BC_SIMPLEVAL  = 1; // Args: V: TColor.
  BC_STYLECLR   = 2; // Args: C: TStyleColor.
  BC_STYLEFNT   = 3; // Args: C: TStyleFont.
  BC_ELEMCLR    = 4; // Args: E: TThemedElement; Part: Integer;
                     //       C: TElementColor.
  BC_HIGHLIGHT  = 5; // Args: C: <Expression>; Luminance: Integer.
  BC_SHADOW     = 6; // Args: C: <Expression>; Luminance: Integer.
  BC_BLEND      = 7; // Args: C1, C2: <Expression>; Alpha: Integer.
  BC_ACCENT     = 8; // Args: No args.
  BC_ACCTEXT    = 9; // Args: No args.

  LAYERTYPE     = 'LayerType';
  DRAW_OPACITY: array[TLMDDrawMode,  TLMDRegionOpacity] of TLMDRegionOpacity =
  (
    (roEmpty, roOpaque,      roOpaque), // dmBlt
    (roEmpty, roTranslucent, roOpaque)  // dmBlend
  );
  BFUNC:        BLENDFUNCTION = (
    BlendOp:              AC_SRC_OVER;
    BlendFlags:           0;
    SourceConstantAlpha:  255;
    AlphaFormat:          AC_SRC_ALPHA
  );

var
  KnownIdents:  TLMDHashTable; // Lazy inited.
  FirstSetProp: PSetProp;
  BufDraws:     TBufDrawData;  // Linked list.
  BufBytes:     Integer;
  BufMax:       Integer;
  CanvasList:   TCanvasList;
  {$IFDEF LMDCOMP16}
  LastVCLStyle: TLMDString;
  {$ENDIF}

function LMDAccent: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    if StyleServices.Name = 'Carbon' then
      Result := LMDShadow(StyleServices.GetStyleColor(scWindow), 10)
    else if StyleServices.Name = 'Metro Green' then
      Result := $B0CC96
    else
      Result := StyleServices.GetStyleColor(scButtonFocused);
  end
  else
  {$ENDIF}
    Result := clHighlight;

  if Assigned(OnGetAccent) then
    OnGetAccent(Result);
end;

function LMDAccentText: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    if StyleServices.Name = 'Metro Green' then
      Result := StyleServices.GetStyleFontColor(sfWindowTextNormal)
    else
      Result := StyleServices.GetStyleFontColor(sfButtonTextFocused);
  end
  else
  {$ENDIF}
    Result := clHighlightText;

  if Assigned(OnGetAccentText) then
    OnGetAccentText(Result);
end;

function LMDBlend(ABase, C: TColor; Alpha: Integer): TColor;
var
  bq, cq: TRGBQuad;
  rq:     TRGBQuad;
  alp:    Double;
begin
  bq  := TRGBQuad(ColorToRGB(ABase));
  cq  := TRGBQuad(ColorToRGB(C));
  alp := Alpha / 100;

  if alp > 1 then
    alp := 1
  else if alp < 0 then
    alp := 0;

  rq.rgbBlue     := Round(bq.rgbBlue * (1 - alp) + cq.rgbBlue * alp);
  rq.rgbGreen    := Round(bq.rgbGreen * (1 - alp) + cq.rgbGreen * alp);
  rq.rgbRed      := Round(bq.rgbRed * (1 - alp) + cq.rgbRed * alp);
  rq.rgbReserved := Round(bq.rgbReserved * (1 - alp) + cq.rgbReserved * alp);

  Result := TColor(rq);
end;

function LMDHighlight(C: TColor; Amount: Integer): TColor;
begin
  Result := GetHighLightColor(C{$IFDEF LMDCOMP7}, Amount{$ENDIF});
end;

function LMDShadow(C: TColor; Amount: Integer): TColor;
begin
  Result := GetShadowColor(C{$IFDEF LMDCOMP7}, -Amount{$ENDIF});
end;

{ TLMDColorImpl }

{$IFDEF LMDCOMP16}
class function TLMDColor.Make(C: TStyleColor): TLMDColorVal;
var
  impl: TLMDColor;
begin
  impl := TLMDColor.Create;
  try
    impl.EmitByte(BC_STYLECLR);
    impl.Emit(C, SizeOf(TStyleColor));

    Result.Simple  := 0;
    Result.Complex := impl;
  except
    impl.Free;
    raise;
  end;
end;
{$ENDIF}

class function TLMDColor.Make(C: TColor): TLMDColorVal;
begin
  Result.Simple  := C;
  Result.Complex := nil;
end;

{$IFDEF LMDCOMP16}
class function TLMDColor.Make(C: TStyleFont): TLMDColorVal;
var
  impl: TLMDColor;
begin
  impl := TLMDColor.Create;
  try
    impl.EmitByte(BC_STYLEFNT);
    impl.Emit(C, SizeOf(TStyleFont));

    Result.Simple  := 0;
    Result.Complex := impl;
  except
    impl.Free;
    raise;
  end;
end;
{$ENDIF}

class procedure TLMDColor.AddAccent;
var
  ki: TKnownIdent;
begin
  ki.Key  := 'accent'; // Lower cased.
  ki.Kind := kikAccent;
  AddIdent(ki);
end;

class procedure TLMDColor.AddAccentText;
var
  ki: TKnownIdent;
begin
  ki.Key  := 'accenttext'; // Lower cased.
  ki.Kind := kikAccText;
  AddIdent(ki);
end;

class procedure TLMDColor.AddBlend;
var
  ki: TKnownIdent;
begin
  ki.Key  := 'blend'; // Lower cased.
  ki.Kind := kikBlend;
  AddIdent(ki);
end;

{$IFDEF LMDCOMP16}
class procedure TLMDColor.AddElemColor(AData: Pointer; const AName: TLMDString;
  AValue: Integer);
var
  ki: TKnownIdent;
  s: TLMDString;
begin
  s := LowerCase(AName);     // Since these identifiers are used as
  if Pos('ec', s) = 1 then   // function names, we'll remove 'ec'
    s := Copy(s, 3, MaxInt); // prefixes for convenience.

  ki.Key        := s;
  ki.Kind       := kikElemColor;
  ki.ElemColor  := TElementColor(AValue);
  AddIdent(ki);
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
class procedure TLMDColor.AddElemPart(AData: Pointer; const AName: TLMDString;
  AValue: Integer);
var
  ki: TKnownIdent;
begin
  ki.Key  := LowerCase(AName);
  ki.Kind := kikElemPart;
  ki.Elem := TThemedElement(AData^);
  ki.Part := AValue;
  AddIdent(ki);
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
class procedure TLMDColor.AddElemParts(AElem: TThemedElement;
  AParts: PTypeInfo);
begin
  GetEnumNames(AParts, AddElemPart, @AElem);
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
class procedure TLMDColor.AddFontColor(AData: Pointer; const AName: TLMDString;
  AValue: Integer);
var
  ki: TKnownIdent;
begin
  ki.Key       := LowerCase(AName);
  ki.Kind      := kikFontColor;
  ki.FontColor := TStyleFont(AValue);
  AddIdent(ki);
end;
{$ENDIF}

class procedure TLMDColor.AddHighlight;
var
  ki: TKnownIdent;
begin
  ki.Key  := 'highlight'; // Lower cased.
  ki.Kind := kikHighlight;
  AddIdent(ki);
end;

class procedure TLMDColor.AddIdent(const KI);
var
  itm: TKnownIdentItem;
begin
  itm := TKnownIdentItem.Create;
  try
    itm.Value := TKnownIdent(KI);
    if KnownIdents = nil then
      KnownIdents := TLMDHashTable.Create(TKnownIdentTraits, True);
    KnownIdents.Add(itm);
  except
    itm.Free;
    raise;
  end;
end;

class procedure TLMDColor.AddShadow;
var
  ki: TKnownIdent;
begin
  ki.Key  := 'shadow'; // Lower cased.
  ki.Kind := kikShadow;
  AddIdent(ki);
end;

{$IFDEF LMDCOMP16}
class procedure TLMDColor.AddStyleColor(AData: Pointer; const AName: TLMDString;
  AValue: Integer);
var
  ki: TKnownIdent;
begin
  ki.Key        := LowerCase(AName);
  ki.Kind       := kikStyleColor;
  ki.StyleColor := TStyleColor(AValue);
  AddIdent(ki);
end;
{$ENDIF}

class procedure TLMDColor.BeginSetProp(const S: TLMDString; out V: TColor);
begin
  BeginSetProp(Parse(S), V);
end;

class procedure TLMDColor.BeginSetProp(const C: TLMDColorVal; out V: TColor);
var
  sp: PSetProp;
begin
  New(sp);
  sp.Val       := C;
  sp.Next      := FirstSetProp;
  FirstSetProp := sp;

  V := Get(sp.Val);
end;

class procedure TLMDColor.CheckAndSkip(var P: PLMDChar;
  AToken: TLMDColorToken);
var
  dt: TLMDTokenData;
begin
  if NextToken(P, dt) <> AToken then
    SyntaxError;
end;

class procedure TLMDColor.CheckAndSkip(var P: PLMDChar;
  AToken: TLMDColorToken; var AData: TLMDTokenData);
begin
  if NextToken(P, AData) <> AToken then
    SyntaxError;
end;

procedure TLMDColor.Compile(var P: PLMDChar);
label
  L;
var
  dt:   TLMDTokenData;
  ki:   TKnownIdent;
  {$IFDEF LMDCOMP16}
  prt:  TKnownIdent;
  {$ENDIF}
  proc: TIdentToInt;
begin
  case NextToken(P, dt) of
    ctInteger:  begin
                  EmitByte(BC_SIMPLEVAL);
                  Emit(TColor(dt.I), SizeOf(TColor));
                end;
    ctIdent:    begin
                  if TryGetKnownIdent(dt.S, ki) then
                  begin
                    case ki.Kind of
                      {$IFDEF LMDCOMP16}
                      kikStyleColor:  begin
                                        EmitByte(BC_STYLECLR);
                                        Emit(ki.StyleColor, SizeOf(TStyleColor));
                                      end;
                      kikFontColor:   begin
                                        EmitByte(BC_STYLEFNT);
                                        Emit(ki.FontColor, SizeOf(TStyleFont));
                                      end;
                      kikElemColor:   begin
                                        CheckAndSkip(P, ctOpenRound);
                                        if (NextToken(P, dt) <> ctIdent) or
                                           not TryGetKnownIdent(dt.S, prt) or
                                           (prt.Kind <> kikElemPart) then
                                          SyntaxError;
                                        CheckAndSkip(P, ctCloseRound);

                                        EmitByte(BC_ELEMCLR);
                                        Emit(prt.Elem, SizeOf(TThemedElement));
                                        EmitInt(prt.Part);
                                        Emit(ki.ElemColor, SizeOf(TElementColor));
                                      end;
                      {$ENDIF}
                      kikHighlight:   begin
                                        EmitByte(BC_HIGHLIGHT);
                                        goto L;
                                      end;
                      kikShadow:      begin
                                        EmitByte(BC_SHADOW);
                                      L:
                                        CheckAndSkip(P, ctOpenRound);
                                        Compile(P);
                                        case NextToken(P, dt) of
                                          ctCloseRound:
                                            dt.I := 10;
                                          ctComma:
                                          begin
                                            CheckAndSkip(P, ctInteger, dt);
                                            CheckAndSkip(P, ctCloseRound);
                                          end;
                                        else
                                          SyntaxError;
                                        end;
                                        EmitInt(dt.I);
                                      end;
                       kikBlend:      begin
                                        EmitByte(BC_BLEND);
                                        CheckAndSkip(P, ctOpenRound);
                                        Compile(P);
                                        CheckAndSkip(P, ctComma);
                                        Compile(P);
                                        CheckAndSkip(P, ctComma);
                                        if NextToken(P, dt) <> ctInteger then
                                          SyntaxError;
                                        EmitInt(dt.I);
                                        CheckAndSkip(P, ctCloseRound);
                                      end;
                       kikAccent:     EmitByte(BC_ACCENT);
                       kikAccText:    EmitByte(BC_ACCTEXT);
                    else
                      SyntaxError;
                    end;
                  end
                  else
                  begin
                    proc := FindIdentToInt(TypeInfo(TColor));
                    if not Assigned(proc) or not proc(dt.S, dt.I) then
                      SyntaxError;

                    EmitByte(BC_SIMPLEVAL);
                    Emit(TColor(dt.I), SizeOf(TColor));
                  end;
                end;
  else
    SyntaxError;
  end;
end;

procedure TLMDColor.Emit(const V; ASize: Integer);
begin
  Move(V, Grow(ASize)^, ASize);
end;

procedure TLMDColor.EmitByte(V: Byte);
begin
  Grow(SizeOf(Byte))^ := V;
end;

procedure TLMDColor.EmitInt(V: Integer);
begin
  PInteger(Grow(SizeOf(Integer)))^ := V;
end;

class procedure TLMDColor.EndSetProp;
var
  sp: PSetProp;
begin
  sp := FirstSetProp;
  if sp <> nil then
  begin
    FirstSetProp := sp.Next;
    Dispose(sp);
  end;
end;

function TLMDColor.Get: TColor;
var
  p: PByte;
begin
  if Length(FByteCode) = 0 then
    Result := clBlack
  else
  begin
    p      := @FByteCode[0];
    Result := Interpret(p);
  end;
end;

class function TLMDColor.Get(const C: TLMDColorVal): TColor;
begin
  if C.Complex <> nil then
    Result := C.Complex.Get
  else
    Result := C.Simple;
end;

{$IFDEF LMDCOMP16}
function TLMDColor.GetDetails(AElem: TThemedElement;
  APart: Integer): TThemedElementDetails;
var
  stl: TCustomStyleServices;
begin
  stl := StyleServices;

  case AElem of
    teButton:             Result := stl.GetElementDetails(TThemedButton(APart));
    teClock:              Result := stl.GetElementDetails(TThemedClock(APart));
    teComboBox:           Result := stl.GetElementDetails(TThemedComboBox(APart));
    teDatePicker:         Result := stl.GetElementDetails(TThemedDatePicker(APart));
    teEdit:               Result := stl.GetElementDetails(TThemedEdit(APart));
    teExplorerBar:        Result := stl.GetElementDetails(TThemedExplorerBar(APart));
    teFlyOut:             Result := stl.GetElementDetails(TThemedFlyOut(APart));
    teHeader:             Result := stl.GetElementDetails(TThemedHeader(APart));
    teLink:               Result := stl.GetElementDetails(TThemedLink(APart));
    teListView:           Result := stl.GetElementDetails(TThemedListview(APart));
    teMenu:               Result := stl.GetElementDetails(TThemedMenu(APart));
    teMenuBand:           Result := stl.GetElementDetails(TThemedMenuBand(APart));
    teMonthCal:           Result := stl.GetElementDetails(TThemedMonthCal(APart));
    teNavigation:         Result := stl.GetElementDetails(TThemedNavigation(APart));
    tePage:               Result := stl.GetElementDetails(TThemedPage(APart));
    teProgress:           Result := stl.GetElementDetails(TThemedProgress(APart));
    teRebar:              Result := stl.GetElementDetails(TThemedRebar(APart));
    teScrollBar:          Result := stl.GetElementDetails(TThemedScrollBar(APart));
    teSpin:               Result := stl.GetElementDetails(TThemedSpin(APart));
    teStartPanel:         Result := stl.GetElementDetails(TThemedStartPanel(APart));
    teStatus:             Result := stl.GetElementDetails(TThemedStatus(APart));
    teTab:                Result := stl.GetElementDetails(TThemedTab(APart));
    teTaskBand:           Result := stl.GetElementDetails(TThemedTaskBand(APart));
    teTaskBar:            Result := stl.GetElementDetails(TThemedTaskBar(APart));
    teTaskDialog:         Result := stl.GetElementDetails(TThemedTaskDialog(APart));
    teTextStyle:          Result := stl.GetElementDetails(TThemedTextStyle(APart));
    teToolBar:            Result := stl.GetElementDetails(TThemedToolBar(APart));
    teToolTip:            Result := stl.GetElementDetails(TThemedToolTip(APart));
    teTrackBar:           Result := stl.GetElementDetails(TThemedTrackBar(APart));
    teTrayNotify:         Result := stl.GetElementDetails(TThemedTrayNotify(APart));
    teTreeview:           Result := stl.GetElementDetails(TThemedTreeview(APart));
    teWindow:             Result := stl.GetElementDetails(TThemedWindow(APart));
    teCategoryButtons:    Result := stl.GetElementDetails(TThemedCategoryButtons(APart));
    teCategoryPanelGroup: Result := stl.GetElementDetails(TThemedCategoryPanelGroup(APart));
    teCheckListBox:       Result := stl.GetElementDetails(TThemedCheckListBox(APart));
    teControlBar:         Result := stl.GetElementDetails(TThemedControlBar(APart));
    teDataNavButtons:     Result := stl.GetElementDetails(TThemedDataNavButtons(APart));
    teGrid:               Result := stl.GetElementDetails(TThemedGrid(APart));
    teHint:               Result := stl.GetElementDetails(TThemedHint(APart));
    tePanel:              Result := stl.GetElementDetails(TThemedPanel(APart));
    teTabSet:             Result := stl.GetElementDetails(TThemedTabSet(APart));
    teTextLabel:          Result := stl.GetElementDetails(TThemedTextLabel(APart));
  else
    Assert(False);
  end;
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
class procedure TLMDColor.GetEnumNames(AEnum: PTypeInfo;
  AProc: TLMDEnumProc; AData: Pointer);
var
  i:    Integer;
  tpdt: PTypeData;
begin
  tpdt := GetTypeData(AEnum);
  for i := tpdt.MinValue to tpdt.MaxValue do
    AProc(AData, GetEnumName(AEnum, i), i);
end;
{$ENDIF}

function TLMDColor.Grow(ASize: Integer): PByte;
var
  old: Integer;
begin
  old := Length(FByteCode);
  SetLength(FByteCode, old + ASize);
  Result := @FByteCode[old];
end;

class procedure TLMDColor.InitKnownIdents;
begin
  AddHighlight;
  AddShadow;
  AddBlend;
  AddAccent;
  AddAccentText;

  {$IFDEF LMDCOMP16}
  GetEnumNames(TypeInfo(TStyleColor), AddStyleColor, nil);
  GetEnumNames(TypeInfo(TStyleFont), AddFontColor, nil);
  GetEnumNames(TypeInfo(TElementColor), AddElemColor, nil);

  AddElemParts(teButton, TypeInfo(TThemedButton));
  AddElemParts(teClock, TypeInfo(TThemedClock));
  AddElemParts(teComboBox, TypeInfo(TThemedComboBox));
  AddElemParts(teDatePicker, TypeInfo(TThemedDatePicker));
  AddElemParts(teEdit, TypeInfo(TThemedEdit));
  AddElemParts(teExplorerBar, TypeInfo(TThemedExplorerBar));
  AddElemParts(teFlyOut, TypeInfo(TThemedFlyOut));
  AddElemParts(teHeader, TypeInfo(TThemedHeader));
  AddElemParts(teLink, TypeInfo(TThemedLink));
  AddElemParts(teListView, TypeInfo(TThemedListview));
  AddElemParts(teMenu, TypeInfo(TThemedMenu));
  AddElemParts(teMenuBand, TypeInfo(TThemedMenuBand));
  AddElemParts(teMonthCal, TypeInfo(TThemedMonthCal));
  AddElemParts(teNavigation, TypeInfo(TThemedNavigation));
  AddElemParts(tePage, TypeInfo(TThemedPage));
  AddElemParts(teProgress, TypeInfo(TThemedProgress));
  AddElemParts(teRebar, TypeInfo(TThemedRebar));
  AddElemParts(teScrollBar, TypeInfo(TThemedScrollBar));
  AddElemParts(teSpin, TypeInfo(TThemedSpin));
  AddElemParts(teStartPanel, TypeInfo(TThemedStartPanel));
  AddElemParts(teStatus, TypeInfo(TThemedStatus));
  AddElemParts(teTab, TypeInfo(TThemedTab));
  AddElemParts(teTaskBand, TypeInfo(TThemedTaskBand));
  AddElemParts(teTaskBar, TypeInfo(TThemedTaskBar));
  AddElemParts(teTaskDialog, TypeInfo(TThemedTaskDialog));
  AddElemParts(teTextStyle, TypeInfo(TThemedTextStyle));
  AddElemParts(teToolBar, TypeInfo(TThemedToolBar));
  AddElemParts(teToolTip, TypeInfo(TThemedToolTip));
  AddElemParts(teTrackBar, TypeInfo(TThemedTrackBar));
  AddElemParts(teTrayNotify, TypeInfo(TThemedTrayNotify));
  AddElemParts(teTreeview, TypeInfo(TThemedTreeview));
  AddElemParts(teWindow, TypeInfo(TThemedWindow));
  AddElemParts(teCategoryButtons, TypeInfo(TThemedCategoryButtons));
  AddElemParts(teCategoryPanelGroup, TypeInfo(TThemedCategoryPanelGroup));
  AddElemParts(teCheckListBox, TypeInfo(TThemedCheckListBox));
  AddElemParts(teControlBar, TypeInfo(TThemedControlBar));
  AddElemParts(teDataNavButtons, TypeInfo(TThemedDataNavButtons));
  AddElemParts(teGrid, TypeInfo(TThemedGrid));
  AddElemParts(teHint, TypeInfo(TThemedHint));
  AddElemParts(tePanel, TypeInfo(TThemedPanel));
  AddElemParts(teTabSet, TypeInfo(TThemedTabSet));
  AddElemParts(teTextLabel, TypeInfo(TThemedTextLabel));
  {$ENDIF}
end;

function TLMDColor.Interpret(var P: PByte): TColor;
type
  PSimpleVal = ^TSimpleVal;
  TSimpleVal = packed record
    BC: Byte;
    C:  TColor;
  end;
  {$IFDEF LMDCOMP16}
  PStyleClr = ^TStyleClr;
  TStyleClr = packed record
    BC: Byte;
    C:  TStyleColor;
  end;
  PFontClr = ^TFontClr;
  TFontClr = packed record
    BC: Byte;
    C:  TStyleFont;
  end;
  PElemClr = ^TElemClr;
  TElemClr = packed record
    BC:    Byte;
    E:     TThemedElement;
    Part:  Integer;
    C:     TElementColor;
  end;
  {$ENDIF}
var
  {$IFDEF LMDCOMP16}
  dtls: TThemedElementDetails;
  {$ENDIF}
  clr:  TColor;
  clr2: TColor;
begin
  case P^ of
    BC_SIMPLEVAL: begin
                    Result := PSimpleVal(P).C;
                    Inc(P, SizeOf(TSimpleVal));
                  end;
    {$IFDEF LMDCOMP16}
    BC_STYLECLR:  begin
                    Result := StyleServices.GetStyleColor(PStyleClr(P).C);
                    Inc(P, SizeOf(TStyleClr));
                  end;
    BC_STYLEFNT:  begin
                    Result := StyleServices.GetStyleFontColor(PFontClr(P).C);
                    Inc(P, SizeOf(TFontClr));
                  end;
    BC_ELEMCLR:   begin
                    dtls := GetDetails(PElemClr(P).E, PElemClr(P).Part);
                    if not StyleServices.GetElementColor(dtls, PElemClr(P).C,
                                                         Result) then
                      Result := clRed;
                    Inc(P, SizeOf(TElemClr));
                  end;
    {$ENDIF}
    BC_HIGHLIGHT: begin
                    Inc(P);
                    clr    := Interpret(P);
                    Result := LMDHighlight(clr, PInteger(P)^);
                    Inc(P, SizeOf(Integer));
                  end;
    BC_SHADOW:    begin
                    Inc(P);
                    clr    := Interpret(P);
                    Result := LMDShadow(clr, PInteger(P)^);
                    Inc(P, SizeOf(Integer));
                  end;
    BC_BLEND:     begin
                    Inc(P);
                    clr    := Interpret(P);
                    clr2   := Interpret(P);
                    Result := LMDBlend(clr, clr2, PInteger(P)^);
                    Inc(P, SizeOf(Integer));
                  end;
    BC_ACCENT:    begin
                    Inc(P);
                    Result := LMDAccent;
                  end;
    BC_ACCTEXT:   begin
                    Inc(P);
                    Result := LMDAccentText;
                  end;
  else
    Assert(False);
    Result := clNone; // Initialize.
  end;
end;

{$IFDEF LMDCOMP16}
class function TLMDColor.Make(AElem: TThemedElement;
  APart: Integer; C: TElementColor): TLMDColorVal;
var
  impl: TLMDColor;
begin
  impl := TLMDColor.Create;
  try
    impl.EmitByte(BC_ELEMCLR);
    impl.Emit(AElem, SizeOf(TThemedElement));
    impl.EmitInt(APart);
    impl.Emit(C, SizeOf(TElementColor));

    Result.Simple  := 0;
    Result.Complex := impl;
  except
    impl.Free;
    raise;
  end;
end;
{$ENDIF}

class function TLMDColor.MakeInteger(S, E: PLMDChar): Integer;
var
  sv: TLMDString;
begin
  SetString(sv, S, E - S);
  Result := StrToInt(sv);
end;

class function TLMDColor.NextToken(var P: PLMDChar;
  var AData: TLMDTokenData): TLMDColorToken;
var
  s: PLMDChar;
begin
  while {$IFDEF LMDCOMP12}(Ord(P^) <= 255) and{$ENDIF} // Skip blanks.
        (AnsiChar(P^) in [#1..#32]) do                 //
    Inc(P);                                            //

  case P^ of
    'a'..'z',
    'A'..'Z': begin
                s := P;
                Inc(P);
                while {$IFDEF LMDCOMP12}(Ord(P^) <= 255) and{$ENDIF}
                      (AnsiChar(P^) in ['a'..'z', 'A'..'Z', '0'..'9']) do
                  Inc(P);

                SetString(AData.S, s, P - s);
                Result := ctIdent;
              end;
    '0'..'9': begin
                s := P;
                Inc(P);
                while {$IFDEF LMDCOMP12}(Ord(P^) <= 255) and{$ENDIF}
                      (AnsiChar(P^) in ['0'..'9']) do
                  Inc(P);

                AData.I := MakeInteger(s, P);
                Result  := ctInteger;
              end;
    '-':      begin
                Inc(P);
                s := P;
                while {$IFDEF LMDCOMP12}(Ord(P^) <= 255) and{$ENDIF}
                      (AnsiChar(P^) in ['0'..'9']) do
                  Inc(P);
                if s = p then
                  SyntaxError;

                AData.I := -MakeInteger(s, P);
                Result  := ctInteger;
              end;
    '$':      begin
                s := P;
                Inc(P);
                while {$IFDEF LMDCOMP12}(Ord(P^) <= 255) and{$ENDIF}
                      (AnsiChar(P^) in ['0'..'9', 'a'..'f', 'A'..'F']) do
                  Inc(P);

                AData.I := MakeInteger(s, P);
                Result  := ctInteger;
              end;
    '(':      begin
                Inc(P);
                Result := ctOpenRound;
              end;
    ')':      begin
                Inc(P);
                Result := ctCloseRound;
              end;
    ',':      begin
                Inc(P);
                Result := ctComma;
              end;
    #0:       Result := ctEof; // No Inc(P) here.
  else
    SyntaxError;
    Result := ctEof; // Initialize.
  end;
end;

class function TLMDColor.Parse(const S: TLMDString): TLMDColorVal;
var
  impl: TLMDColor;
  p:    PLMDChar;
begin
  impl := TLMDColor.Create;
  try
    SetLength(impl.FByteCode, 0);

    if S = '' then
      SyntaxError;
    p := @S[1];

    impl.Compile(p);
    impl.CheckAndSkip(p, ctEof);

    if impl.IsSimple(Result.Simple) then
    begin
      Result.Complex := nil;
      impl.Free;
    end
    else
    begin
      Result.Simple  := 0;
      Result.Complex := impl;
    end;
  except
    impl.Free;
    raise;
  end;
end;

class procedure TLMDColor.PropSetter(var C: TLMDColorVal; V: TColor);
begin
  if FirstSetProp <> nil then
    C := FirstSetProp.Val
  else
    C := TLMDColor.Make(V);
end;

class procedure TLMDColor.SyntaxError;
begin
  raise ELMDColor.Create('Invalid color syntax');
end;

class function TLMDColor.TryGetKnownIdent(
  const S: TLMDString; out KI): Boolean;
var
  key: TLMDString;
  itm: TKnownIdentItem;
begin
  if KnownIdents <> nil then
  begin
    key := LowerCase(S);
    itm := TKnownIdentItem(KnownIdents.Find(key));
  end
  else
    itm := nil;

  if itm <> nil then
  begin
    TKnownIdent(KI) := itm.Value;
    Result          := True;
  end
  else
    Result := False;
end;

function TLMDColor.IsSimple(out C: TColor): Boolean;
begin
  if (Length(FByteCode) = (1 + SizeOf(TColor))) and
     (FByteCode[0] = BC_SIMPLEVAL) then
  begin
    C      := PColor(@FByteCode[1])^;
    Result := True;
  end
  else
    Result := False;
end;

procedure GDICheck(AResult: Boolean); overload;
begin
  if not AResult then
    RaiseLastOSError;
end;

procedure GDICheck(AResult: HGDIOBJ); overload;
begin
  if (AResult = 0) or (AResult = HGDI_ERROR) then
    GDICheck(False);
end;

{ TLMDStyleElem }

constructor TLMDStyleElem.Create(AStyle: TLMDDockStyle);
begin
  inherited Create;
  FStyle := AStyle;
end;

destructor TLMDStyleElem.Destroy;
var
  st: TLMDElemState;
  mr: TLMDMargins;
  cl: TLMDStyleColor;
begin
  while FStates <> nil do
  begin
    st      := FStates;
    FStates := FStates.FNext;
    st.Free;
  end;

  while FMargins <> nil do
  begin
    mr       := FMargins;
    FMargins := FMargins.FNext;
    mr.Free;
  end;

  while FColors <> nil do
  begin
    cl      := FColors;
    FColors := FColors.FNext;
    cl.Free;
  end;

  inherited;
end;

function TLMDStyleElem.GetState(const Index: Integer): TLMDElemState;
var
  cur: ^TLMDElemState;
  idx:  Integer;
begin
  Assert(Index >= 0);

  cur := @FStates;
  idx := 0;

  while True do
  begin
    if cur^ = nil then
      cur^ := TLMDElemState.Create(Self);
    if idx = Index then
      Break; // while
    cur := @cur.FNext;
    Inc(idx);
  end;

  Result := cur^;
end;

procedure TLMDStyleElem.Read(const ANode: ILMDXmlElement);
begin
  TXmlUtils.ReadProps(Self, ANode, nil);
end;

procedure TLMDStyleElem.SetColor(const Index: Integer; Value: TColor);
var
  itm: TLMDStyleColor;
begin
  itm    := GetColorItem(Index);
  TLMDColor.PropSetter(itm.FColor, Value);
end;

procedure TLMDStyleElem.InvalidateDrawInfo;
var
  st: TLMDElemState;
begin
  st := FStates;
  while st <> nil do
  begin
    st.InvaidateDrawInfo;
    st := st.FNext;
  end;
end;

function TLMDStyleElem.GetColor(const Index: Integer): TColor;
var
  itm: TLMDStyleColor;
begin
  itm    := GetColorItem(Index);
  Result := TLMDColor.Get(itm.FColor);
end;

function TLMDStyleElem.GetColorItem(AIndex: Integer): TLMDStyleColor;
var
  cur: ^TLMDStyleColor;
  idx:  Integer;
begin
  Assert(AIndex >= 0);

  cur := @FColors;
  idx := 0;

  while True do
  begin
    if cur^ = nil then
      cur^ := TLMDStyleColor.Create;
    if idx = AIndex then
      Break; // while
    cur := @cur.FNext;
    Inc(idx);
  end;

  Result := cur^;
end;

function TLMDStyleElem.GetMargins(const Index: Integer): TLMDMargins;
var
  cur: ^TLMDMargins;
  idx:  Integer;
begin
  Assert(Index >= 0);

  cur := @FMargins;
  idx := 0;

  while True do
  begin
    if cur^ = nil then
      cur^ := TLMDMargins.Create;
    if idx = Index then
      Break; // while
    cur := @cur.FNext;
    Inc(idx);
  end;

  Result := cur^;
end;

class function TLMDStyleElem.GetName: TLMDString;
const
  PREFIX = '.TLMD';
  SUFFIX = 'ELEM.';
begin
  Result := Format('.%s.', [ClassName]);
  Result := StringReplace(Result, PREFIX, '.', [rfIgnoreCase]);
  Result := StringReplace(Result, SUFFIX, '.', [rfIgnoreCase]);
  Result := StringReplace(Result, '.', '', [rfReplaceAll]);
end;

procedure TLMDStyleElem.Write(const ANode: ILMDXmlElement);
begin
  TXmlUtils.WriteProps(Self, ANode);
end;

{ TLMDDockStyle }

procedure TLMDDockStyle.BitmapChanged(Sender: TObject);
begin
  Include(FState, dssBitmapChanged);
end;

procedure TLMDDockStyle.Changed;
var
  i:   Integer;
  chs: TLMDElemSetChanges;
begin
  InvalidateDrawInfo;
  if dssBitmapChanged in FState then // Performance optimization.
    UpdateMaster;
  TBitmapCache(FStyles.FBitmapCache).Clear;

  chs := [escProps];
  if dssBitmapChanged in FState then
    Include(chs, escBitmap);
  if dssReloaded in FState then
    Include(chs, escReloaded);

  for i := 0 to FElemSets.Count - 1 do
    TLMDElemSet(FElemSets[i]).Changed(chs);
  FState := FState - [dssReloaded, dssBitmapChanged];
end;

procedure TLMDDockStyle.ClearElems;
var
  i: Integer;
begin
  for i := 0 to FElems.Count - 1 do
    TObject(FElems[i]).Free;
  FElems.Clear;
end;

constructor TLMDDockStyle.Create(AStyles: TLMDDockStyles;
  const AName: TLMDStyleName);
begin
  inherited Create;
  FName            := AName;
  FXml             := LMDCreateXmlDocument('Style');
  FBitmap          := TBitmap.Create;
  FBitmap.OnChange := BitmapChanged;
  FMaster          := TLMDBuffer.Create;
  FElems           := TList.Create;
  FElemSets        := TList.Create;

  AStyles.InsertStyle(Self);
end;

destructor TLMDDockStyle.Destroy;
begin
  if FStyles <> nil then
    FStyles.RemoveStyle(Self);
  if FOwnLazy then
    FLazy.Free;
  ClearElems;
  FElems.Free;
  FElemSets.Free;
  FBitmap.Free;
  FMaster.Free;
  inherited;
end;

function TLMDDockStyle.CreateElemNode(AElem: TLMDStyleElem): ILMDXmlElement;
begin
  Result := FXml.DocumentElement.AppendElement(AElem.GetName);
  AElem.Write(Result);
end;

constructor TLMDDockStyle.CreateLazy(AStyles: TLMDDockStyles;
  const AName: TLMDStyleName; ASource: TLMDStyleSource;
  AOwnSource: Boolean);
begin
  Create(AStyles, AName);
  FLazy    := ASource;
  FOwnLazy := AOwnSource;
end;

function TLMDDockStyle.GetElem(AClass: TLMDStyleElemClass): TLMDStyleElem;
var
  i:  Integer;
  nd: ILMDXmlElement;
begin
  for i := 0 to FElems.Count - 1 do
  begin
    Result := TLMDStyleElem(FElems[i]);
    if Result.ClassType = AClass then
      Exit;
  end;

  Result := AClass.Create(Self);
  try
    nd := FXml.DocumentElement.FindElement(Result.GetName, '', '');
    if nd <> nil then
    begin
      Result.Read(nd);
      nd.ParentNode.RemoveChild(nd);
    end;
    FElems.Add(Result);
  except
    Result.Free;
    raise;
  end;
end;

function TLMDDockStyle.GetMaster: TLMDBuffer;
begin
  Result := FMaster;
end;

procedure TLMDDockStyle.InsertElemSet(AElemSet: TLMDElemSet);
var
  cls:   TClass;
  dsets: TList;
begin
  cls   := AElemSet.ClassType;
  dsets := DockStyles.FDefinedSets;

  while (cls <> nil) and (dsets.IndexOf(cls) = -1) do
    cls := cls.ClassParent;

  if cls = nil then
    raise ELMDDockStyles.CreateFmt('Element set %s is not defined. Element ' +
                                   'set classes should be registered using ' +
                                   'DockStyles.DefineElements method call in ' +
                                   'its unit initialization clause.',
                                   [AElemSet.ClassType.ClassName]);

  FElemSets.Add(AElemSet);
  AElemSet.FStyle := Self;
end;

procedure TLMDDockStyle.Load(ASource: TLMDStyleSource);
begin
  FState := FState + [dssLoading] - [dssValid];
  try
    ClearElems;
    ASource.Read(LoadProc);
    UpdateMaster;
    ReassignSetsElems;
    FState := FState + [dssValid, dssReloaded];
  finally
    Exclude(FState, dssLoading);
    if not (dssValid in FState) then
      ReassignSetsElems; // Reset elems.
  end;
end;

procedure TLMDDockStyle.LoadFromFile(const AFileName: TLMDString);
var
  src: TLMDStyleSource;
begin
  src := TLMDFileSource.Create(AFileName);
  try
    Load(src);
  finally
    src.Free;
  end;
end;

procedure TLMDDockStyle.LoadFromResource(const AResName: TLMDString);
var
  src: TLMDStyleSource;
begin
  src := TLMDResourceSource.Create(AResName);
  try
    Load(src);
  finally
    src.Free;
  end;
end;

procedure TLMDDockStyle.LoadProc(AKind: TLMDStyleDataKind; AStream: TStream);
begin
  case AKind of
    sdkXml: FXml.Load(AStream);
    sdkBmp: FBitmap.LoadFromStream(AStream);
  else
    Assert(False);
  end;
end;

procedure TLMDDockStyle.ReassignSetsElems;
var
  i: Integer;
begin
  for i := 0 to FElemSets.Count - 1 do
    TLMDElemSet(FElemSets[i]).AssignElems;
end;

procedure TLMDDockStyle.RemoveElemSet(AElemSet: TLMDElemSet);
begin
  FElemSets.Remove(AElemSet);
  AElemSet.FStyle := nil;
end;

procedure TLMDDockStyle.InvalidateDrawInfo;
var
  i: Integer;
begin
  for i := 0 to FElems.Count - 1 do
    TLMDStyleElem(FElems[i]).InvalidateDrawInfo;
end;

procedure TLMDDockStyle.Save(ASource: TLMDStyleSource);
var
  i:     Integer;
  nd:    ILMDXmlElement;
  nodes: TList;
  elc:   TLMDStyleElemClass;
begin
  nodes := TList.Create;
  try
    for i := 0 to DockStyles.FDefinedElems.Count - 1 do
    begin
      elc := TLMDStyleElemClass(DockStyles.FDefinedElems[i]);
      nd  := CreateElemNode(GetElem(elc)); // Ensure XML node.
      nodes.Add(Pointer(nd));
    end;
    ASource.Write(SaveProc);
  finally
    for i := 0 to nodes.Count - 1 do
    begin
      nd := ILMDXmlElement(nodes[i]);
      nd.ParentNode.RemoveChild(nd);
    end;
    nodes.Free;
  end;
end;

procedure TLMDDockStyle.SaveProc(AKind: TLMDStyleDataKind; AStream: TStream);
begin
  case AKind of
    sdkXml: FXml.Save(AStream);
    sdkBmp: FBitmap.SaveToStream(AStream);
  else
    Assert(False);
  end;
end;

procedure TLMDDockStyle.SaveToFile(const AFileName: TLMDString);
var
  src: TLMDStyleSource;
begin
  src := TLMDFileSource.Create(AFileName);
  try
    Save(src);
  finally
    src.Free;
  end;
end;

procedure TLMDDockStyle.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;

procedure TLMDDockStyle.UpdateMaster;
type
  TPixel = packed record
    R: Byte;
    G: Byte;
    B: Byte;
    A: Byte;
  end;
var
  i:     Integer;
  w, h:  Integer;
  alpha: Boolean;
begin
  alpha := (FBitmap.PixelFormat = pf32bit);
  w     := FBitmap.Width;
  h     := FBitmap.Height;

  FMaster.Resize(w, h);
  BitBlt(FMaster.Canvas.Handle, 0, 0, w, h,
         FBitmap.Canvas.Handle, 0, 0, SRCCOPY);
  GDIFlush;

  { Premultiply }

  for i := 0 to w * h - 1 do
    with TPixel(FMaster.Data[i]) do
      if alpha then
      begin
        R := MulDiv(R, A, 255);
        G := MulDiv(G, A, 255);
        B := MulDiv(B, A, 255);
      end
      else
        A := 255;
end;

{ TLMDDockStyles }

function TLMDDockStyles.Add(
  const AName: TLMDStyleName): TLMDDockStyle;
begin
  Result := TLMDDockStyle.Create(Self, AName);
end;

function TLMDDockStyles.Add(const AName: TLMDStyleName;
  ASource: TLMDStyleSource): TLMDDockStyle;
begin
  Result := TLMDDockStyle.Create(Self, AName);
  try
    Result.Load(ASource);
  except
    Result.Free;
    raise;
  end;
end;

procedure TLMDDockStyles.AddLazy(const AName: TLMDStyleName;
  ASource: TLMDStyleSource; AOwnSource: Boolean);
begin
  TLMDDockStyle.CreateLazy(Self, AName, ASource, AOwnSource);
end;

procedure TLMDDockStyles.Changed;
var
  i: Integer;
  st: TLMDDockStyle;
begin
  for i := 0 to FStyles.Count - 1 do
  begin
    st := TLMDDockStyle(FStyles[i]);
    if st.FLazy = nil then // If already inited.
      st.Changed;
  end;
end;

constructor TLMDDockStyles.Create;
begin
  inherited Create;
  FStyles       := TList.Create;
  FRegSources   := TList.Create;
  FDefinedSets  := TList.Create;
  FDefinedElems := TList.Create;
  FBitmapCache  := TBitmapCache.Create;
end;

procedure TLMDDockStyles.DefineElements(AElementSet: TLMDElemSetClass);
begin
  if FDefinedSets.IndexOf(AElementSet) = -1 then
  begin
    AElementSet.EnumProps(DefineElemProc, nil);
    FDefinedSets.Add(AElementSet);
  end;
end;

procedure TLMDDockStyles.DefineElemProc(AProp: TLMDPropInfo; AData: Pointer);
var
  tp:    TLMDTypeInfo;
  cls:   TClass;
  found: TLMDStyleElemClass;
begin
  tp := AProp.PropType^;
  if tp.Kind <> tkClass then
    Exit; // Ignore prop.

  cls := GetTypeData(tp).ClassType;
  if not cls.InheritsFrom(TLMDStyleElem) then
    Exit; // Ignore prop.

  if TryGetElemClass(TLMDStyleElemClass(cls).GetName, found) then
  begin
    if cls <> found then
      raise ELMDDockStyles.CreateFmt('Duplicate element name %s.',
                                     [found.GetName]);
  end
  else
    FDefinedElems.Add(cls);
end;

destructor TLMDDockStyles.Destroy;
begin
  while Count > 0 do
    Style[0].Free;
  while RegSourceCount > 0 do
    RegSources[0].Free;
  FStyles.Free;
  FRegSources.Free;
  FDefinedElems.Free;
  FDefinedSets.Free;
  FBitmapCache.Free;
  inherited;
end;

function TLMDDockStyles.EnsureLazyInit(AStyle: TLMDDockStyle): TLMDDockStyle;
begin
  if AStyle.FLazy <> nil then
  begin
    AStyle.Load(AStyle.FLazy);
    if AStyle.FOwnLazy then
      AStyle.FLazy.Free;
    AStyle.FLazy := nil;
  end;
  Result := AStyle;
end;

function TLMDDockStyles.TryGetByName(const AName: TLMDStyleName;
  out AStyle: TLMDDockStyle): Boolean;
var
  i:  Integer;
  st: TLMDDockStyle;
begin
  for i := 0 to FStyles.Count - 1 do
  begin
    st := TLMDDockStyle(FStyles[i]);
    if LMDSameText(AName, st.Name) then
    begin
      AStyle := EnsureLazyInit(st);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function TLMDDockStyles.TryGetElemClass(const AName: TLMDString;
  out AClass: TLMDStyleElemClass): Boolean;
var
  i:   Integer;
  elc: TLMDStyleElemClass;
begin
  for i := 0 to FDefinedElems.Count - 1 do
  begin
    elc := TLMDStyleElemClass(FDefinedElems[i]);
    if LMDSameText(elc.GetName, AName) then
    begin
      AClass := elc;
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

{$IFDEF LMDCOMP16}
procedure TLMDDockStyles.VCLStyleChanged;
var
  i:  Integer;
  nm: string;
begin
  nm := StyleServices.Name;
  if LastVCLStyle <> nm then
  begin
    for i := 0 to FStyles.Count - 1 do
      TLMDDockStyle(FStyles[i]).Changed;
    LastVCLStyle := nm;
  end;
end;
{$ENDIF}

function TLMDDockStyles.GetByName(
  const AName: TLMDStyleName): TLMDDockStyle;
begin
  if not TryGetByName(AName, Result) then
    raise ELMDDockStyles.CreateFmt('Style "%s" is not found', [AName]);
end;

function TLMDDockStyles.GetCount: Integer;
begin
  Result := FStyles.Count;
end;

function TLMDDockStyles.GetDefaultRegSource: TLMDRegisteredSource;
var
  i:  Integer;
  rs: TLMDRegisteredSource;
begin
  for i := 0 to FRegSources.Count - 1 do
  begin
    rs := TLMDRegisteredSource(FRegSources[i]);
    if rs.IsDefault then
    begin
      Result := rs;
      Exit;
    end;
  end;

  raise ELMDDockStyles.Create('No default style has been registered.');
end;

function TLMDDockStyles.GetDefaultStyle: TLMDDockStyle;
begin
  if FDefaultStyle = nil then
    raise ELMDDockStyles.Create('Default style is not registred.');
  Result := EnsureLazyInit(FDefaultStyle);
end;

function TLMDDockStyles.GetNextId: Integer;
begin
  Inc(FNextId);
  Result := FNextId;
end;

function TLMDDockStyles.GetRegSourceCount: Integer;
begin
  Result := FRegSources.Count;
end;

function TLMDDockStyles.GetRegSources(Index: Integer): TLMDRegisteredSource;
begin
  Result := TLMDRegisteredSource(FRegSources[Index]);
end;

function TLMDDockStyles.GetStyle(AIndex: Integer): TLMDDockStyle;
begin
  Result := EnsureLazyInit(TLMDDockStyle(FStyles[AIndex]));
end;

procedure TLMDDockStyles.InsertRegSource(ASource: TLMDRegisteredSource);
begin
  FRegSources.Add(ASource);
  ASource.FStyles := Self;
end;

procedure TLMDDockStyles.InsertStyle(AStyle: TLMDDockStyle);
begin
  FStyles.Add(AStyle);
  AStyle.FStyles := Self;
end;

procedure TLMDDockStyles.Register(const AName: TLMDStyleName;
  AResName: TLMDString; ADefault: Boolean);
var
  src:  TLMDResourceSource;
  rsrc: TLMDRegisteredSource;
  st:   TLMDDockStyle;
begin
  if ADefault and (FDefaultStyle <> nil) then
    raise ELMDDockStyles.Create('Duplicate default style.');

  src  := TLMDResourceSource.Create(AResName);
  rsrc := TLMDRegisteredSource.Create(Self, AName, ADefault, src);
  st   := TLMDDockStyle.CreateLazy(Self, AName, rsrc.Source, False);

  if ADefault then
    FDefaultStyle := st;
end;

procedure TLMDDockStyles.RemoveRegSource(ASource: TLMDRegisteredSource);
begin
  FRegSources.Remove(ASource);
  ASource.FStyles := nil;
end;

procedure TLMDDockStyles.RemoveStyle(AStyle: TLMDDockStyle);
begin
  FStyles.Remove(AStyle);
  AStyle.FStyles := nil;
end;

{ TLMDElemState }

function TLMDElemState.Add(AClass: TLMDStateLayerClass): TLMDStateLayer;
begin
  Result := AClass.Create(Self);
end;

procedure TLMDElemState.InsertLayer(AItem: TLMDStateLayer;
  AIndex: Integer);
var
  nxt: ^TLMDStateLayer;
  idx: Integer;
begin
  nxt := @FLayers;
  idx := 0;

  while (idx < AIndex) and (nxt^ <> nil) do
  begin
    nxt := @nxt.FNext;
    Inc(idx);
  end;

  AItem.FNext  := nxt^;
  nxt^         := AItem;
  AItem.FState := Self;
end;

procedure TLMDElemState.AddLayers(AStream: TStream);
var
  i:    Integer;
  xml:  ILMDXmlDocument;
  root: ILMDXmlElement;
  nd:   ILMDXmlElement;

  procedure ReadLayer(const N: ILMDXmlElement);
  var
    lr: TLMDStateLayer;
  begin
    lr := TLMDStateLayer.GetClass(N.GetAttr(LAYERTYPE)).Create(Self);
    try
      lr.Read(N);
    except
      lr.Free;
      raise;
    end;
  end;

begin
  xml  := LMDLoadXmlDocument(AStream);
  root := xml.DocumentElement;

  for i := 0 to root.ChildNodes.Count - 1 do
  begin
    nd := root.ChildNodes[i].AsElement;
    ReadLayer(nd);
  end;
end;

procedure TLMDElemState.Clear;
begin
  while FLayers <> nil do
    FLayers.Free;
end;

constructor TLMDElemState.Create(AElem: TLMDStyleElem);
begin
  inherited Create;
  FElem := AElem;
  FId   := DockStyles.GetNextId;
end;

destructor TLMDElemState.Destroy;
begin
  Clear;
  inherited;
end;

procedure TLMDElemState.Draw(ACanvas: TCanvas; const R: TRect);
const
  DRAW_MODE:   array[TLMDRegionOpacity] of TLMDDrawMode = (
    dmBlend, // roEmpty
    dmBlend, // roTranslucent
    dmBlt    // roOpaque
  );
  BUF_FORMAT:  array[TLMDRegionOpacity] of TLMDBufferFormat = (
    bf32bit, // roEmpty
    bf32bit, // roTranslucent
    bf24bit  // roOpaque
  );
  BIG_BITMAP = 5000; // This value is very tricky; it affect both: performance
                     // and memory usage. Value is determined by profiling, do
                     // not change it.
var
  wdth:  Integer;
  hght:  Integer;
  cache: TBitmapCache;
  b:     TLMDBuffer;
  opac:  TLMDRegionOpacity;
begin
  cache := TBitmapCache(DockStyles.FBitmapCache);
  opac  := Opacity;
  wdth  := R.Right - R.Left;
  hght  := R.Bottom - R.Top;

  if (opac <> roEmpty) and (wdth > 0) and (hght > 0) then
  begin
    if wdth * hght > BIG_BITMAP then // Do not cache big bitmaps.
      DoDraw(ACanvas, DRAW_MODE[opac], R)
    else
    begin
      if cache.GetBuffer(FId, wdth, hght, BUF_FORMAT[opac], b) = bsRedraw then
        DoDraw(b.Canvas, dmBlt, Rect(0, 0, wdth, hght));

      case opac of
        roTranslucent: AlphaBlend(ACanvas.Handle, R.Left, R.Top, wdth, hght,
                                  b.Canvas.Handle, 0, 0, wdth, hght, BFUNC);
        roOpaque:      BitBlt(ACanvas.Handle, R.Left, R.Top, wdth, hght,
                              b.Canvas.Handle, 0, 0, SRCCOPY);
      end;
    end;
  end;
end;

procedure TLMDElemState.DrawLayer(ACanvas: TCanvas; const R: TRect;
  L: TLMDStateLayer);
const
  DRAW_MODE:   array[TLMDRegionOpacity] of TLMDDrawMode = (
    dmBlend, // roEmpty
    dmBlend, // roTranslucent
    dmBlt    // roOpaque
  );
var
  wdth:  Integer;
  hght:  Integer;
  opac:  TLMDRegionOpacity;
begin
  opac  := Opacity; // Update draw info.
  wdth  := R.Right - R.Left;
  hght  := R.Bottom - R.Top;

  if (opac <> roEmpty) and (wdth > 0) and (hght > 0) then
    L.Draw(ACanvas, R, DRAW_MODE[L.FOpacity]);
end;

procedure TLMDElemState.DoDraw(C: TCanvas; AMode: TLMDDrawMode;
  const R: TRect; L: TLMDStateLayer);
var
  lr:   TLMDStateLayer;
  mode: TLMDDrawMode;
begin
  mode := AMode;
  lr   := FLayers;

  while lr <> nil do
  begin
    if ((L = nil) or (lr = L)) and (lr.FOpacity <> roEmpty) then
    begin
      lr.Draw(C, R, mode);
      mode := dmBlend;
    end;
    lr := lr.FNext;
  end;
end;

function TLMDElemState.GetFirst: TLMDStateLayer;
begin
  Result := FLayers;
end;

function TLMDElemState.GetLast: TLMDStateLayer;
begin
  Result := FLayers;

  if Result <> nil then
  begin
    while (Result.FNext <> nil) do
      Result := Result.FNext;
  end;
end;

function TLMDElemState.GetLayerCount: Integer;
var
  cur: TLMDStateLayer;
begin
  Result := 0;
  cur    := FLayers;

  while cur <> nil do
  begin
    Inc(Result);
    cur := cur.FNext;
  end;
end;

function TLMDElemState.GetLayers(AIndex: Integer): TLMDStateLayer;
var
  idx: Integer;
begin
  idx    := AIndex;
  Result := FLayers;

  while Result <> nil do
  begin
    if idx = 0 then
      Exit;
    Dec(idx);
    Result := Result.FNext;
  end;

  TList.Error(@SListIndexError, AIndex);
end;

function TLMDElemState.GetStyle: TLMDDockStyle;
begin
  Result := FElem.FStyle;
end;

function TLMDElemState.MakeRegion(const R: TRect): HRGN;
type
  TPixels = array[0..0] of DWORD;
  PRects  = ^TRects;
  TRects  = array[0..0] of TRect;
label
  L;
var
  wdth, hght: Integer;
  cache:      TBitmapCache;
  opac:       TLMDRegionOpacity;
  b:          TLMDBuffer;
begin
  cache := TBitmapCache(DockStyles.FBitmapCache);
  opac  := Opacity;
  wdth  := R.Right - R.Left;
  hght  := R.Bottom - R.Top;

  if (opac = roTranslucent) and (wdth > 0) and (hght > 0) then
  begin
    if cache.GetBuffer(FId, wdth, hght, bf32bit, b) = bsRedraw then
    begin
      DoDraw(b.Canvas, dmBlt, Rect(0, 0, wdth, hght));
      GDIFlush;
    end;
    Result := RegionFromBuffer(b, R);
  end
  else
    Result := 0;
end;

procedure TLMDElemState.MoveLayer(AFrom, ATo: Integer);
var
  lr: TLMDStateLayer;
begin
  if AFrom = ATo then
    Exit;

  lr := Layers[AFrom];
  RemoveLayer(lr);
  InsertLayer(lr, ATo);
end;

function TLMDElemState.Opacity: TLMDRegionOpacity;
const
  COMBINED_OPACITY: array[TLMDRegionOpacity,
                          TLMDRegionOpacity] of TLMDRegionOpacity =
  (
    // roEmpty          roTranslucent     roOpaque
    (  roEmpty,         roTranslucent,    roOpaque), // roEmpty
    (  roTranslucent,   roTranslucent,    roOpaque), // roTranslucent
    (  roOpaque,        roOpaque,         roOpaque)  // roOpaque
  );
var
  lr: TLMDStateLayer;
begin
  lr     := FLayers;
  Result := roEmpty;

  while lr <> nil do
  begin
    if not lr.FUpdated then
    begin
      lr.FOpacity := lr.UpdateDrawInfo;
      lr.FUpdated := True;
    end;
    Result := COMBINED_OPACITY[Result, lr.FOpacity];
    lr := lr.FNext;
  end;
end;

function TLMDElemState.Read(AType: TLMDValType; const V): Boolean;
var
  i:  Integer;
  nd: ILMDXmlElement;

  procedure ReadLayer(const N: ILMDXmlElement);
  var
    L: TLMDStateLayer;
  begin
    L := TLMDStateLayer.GetClass(N.GetAttr(LAYERTYPE)).Create(Self);
    try
      L.Read(N);
    except
      L.Free;
      raise;
    end;
  end;

begin
  if AType = vtNode then
  begin
    nd := TLMDNodeGetter(V);
    Clear;

    if nd.AttrExists(LAYERTYPE) then
      ReadLayer(nd)
    else
    begin
      for i := 0 to nd.ChildNodes.Count - 1 do
        ReadLayer(nd.ChildNodes[i].AsElement);
    end;

    Result := True;
  end
  else
    Result := False;
end;

function TLMDElemState.RegionFromBuffer(B: TLMDBuffer;
  const R: TRect): HRGN;
type
  PRects  = ^TRects;
  TRects  = array[0..0] of TRect;
label
  L;
var
  wdth, hght: Integer;
  x, y, lft:  Integer;
  ln:         PLMDPixels;
  dt:         PRgnData;
  cnt, cap:   Integer;
  rrn:        HRGN;
begin
  Assert(B.Format = bf32bit);

  wdth := R.Right - R.Left;
  hght := R.Bottom - R.Top;
  dt   := nil;
  try
    cap := 0;
    cnt := 0;

    for y := 0 to hght - 1 do
    begin
      ln := B.ScanLine(y);
      x  := 0;
    L:
      while (x <> wdth) and (ln[x] <> 0) do
        Inc(x);
      lft := x;

      if x < wdth then
      begin
        repeat
          Inc(x);
        until (x >= wdth) or (ln[x] <> 0);

        if cnt = cap then
        begin
          cap := Max(16, cap * 2);
          ReallocMem(dt, SizeOf(RGNDATAHEADER) + cap * SizeOf(TRect));
        end;

        with PRects(@dt.Buffer)[cnt] do
        begin
          Left   := lft;
          Right  := x;
          Top    := y;
          Bottom := y + 1;
        end;
        Inc(cnt);

        if x < wdth then
          goto L;
      end;
    end;

    if dt <> nil then
    begin
      dt.rdh.dwSize   := SizeOf(RGNDATAHEADER);
      dt.rdh.iType    := RDH_RECTANGLES;
      dt.rdh.nCount   := cnt;
      dt.rdh.nRgnSize := 0;
      dt.rdh.rcBound  := Rect(0, 0, 0, 0);

      Result := ExtCreateRegion(nil, SizeOf(RGNDATAHEADER) +
                                cnt * SizeOf(TRect), dt^);
      rrn    := CreateRectRgnIndirect(R);
      CombineRgn(Result, rrn, Result, RGN_DIFF);
      DeleteObject(rrn);
    end
    else
      Result := 0;
  finally
    FreeMem(dt);
  end;
end;

procedure TLMDElemState.RemoveLayer(AItem: TLMDStateLayer);
var
  lr: ^TLMDStateLayer;
begin
  lr := @FLayers;

  while lr^ <> AItem do
  begin
    if lr^ = nil then
      Exit;
    lr := @lr.FNext;
  end;

  lr^          := AItem.FNext;
  AItem.FState := nil;
end;

procedure TLMDElemState.InvaidateDrawInfo;
var
  lr: TLMDStateLayer;
begin
  lr := FLayers;
  while lr <> nil do
  begin
    lr.InvaidateDrawInfo;
    lr := lr.FNext;
  end;
end;

function TLMDElemState.LayerById(AId: Integer): TLMDStateLayer;
var
  lr: TLMDStateLayer;
begin
  lr := FLayers;
  while lr <> nil do
  begin
    if lr.FId = AId then
    begin
      Result := lr;
      Exit;
    end;
    lr := lr.FNext;
  end;
  Result := nil;
end;

procedure TLMDElemState.LayersToStream(AStream: TStream;
  AFilter: TLMDLayerFilter; AData: Pointer);
var
  xml: ILMDXmlDocument;
  lr:  TLMDStateLayer;
  nd:  ILMDXmlElement;
begin
  xml := LMDCreateXmlDocument('Layers');
  lr  := FLayers;

  while lr <> nil do
  begin
    if not Assigned(AFilter) or AFilter(lr, AData) then
    begin
      nd := xml.DocumentElement.AppendElement('Layer');

      nd.SetAttr(LAYERTYPE, lr.GetType);
      lr.Write(nd);
    end;
    lr := lr.FNext;
  end;

  xml.Save(AStream);
end;

function TLMDElemState.Write(var V): TLMDValType;
var
  cur: TLMDStateLayer;
  nd:  ILMDXmlElement;

  procedure WriteLayer(const ANode: ILMDXmlElement; L: TLMDStateLayer);
  begin
    ANode.SetAttr(LAYERTYPE, L.GetType);
    L.Write(ANode);
  end;

begin
  Result := vtNode;
  nd     := TLMDNodeGetter(V);

  if (FLayers <> nil) and (FLayers.FNext = nil) then // Count = 1
    WriteLayer(nd, FLayers)
  else
  begin
    cur := FLayers;
    while cur <> nil do
    begin
      WriteLayer(nd.AppendElement('Layer'), cur);
      cur := cur.FNext;
    end;
  end;
end;

{ TLMDStateLayer }

constructor TLMDStateLayer.Create(AState: TLMDElemState);
begin
  inherited Create;
  FId := DockStyles.GetNextId;
  AState.InsertLayer(Self, MaxInt);
end;

destructor TLMDStateLayer.Destroy;
begin
  if FState <> nil then
    FState.RemoveLayer(Self);
  inherited;
end;

procedure TLMDStateLayer.FillEmptyRect(C: TCanvas;
  const R: TRect);
begin
  C.Brush.Color := clBlack; // Make fully
  C.FillRect(R);            // transparent.
end;

function TLMDStateLayer.LayerTypeFilter(const AName: TLMDString): Boolean;
begin
  Result := LMDSameText(AName, LAYERTYPE);
end;

class function TLMDStateLayer.GetClass(
  const AType: TLMDString): TLMDStateLayerClass;
var
  dt: TLMDGetStateClassData;
begin
  dt.SType  := AType;
  dt.Result := nil;

  GetLayerClasses(@dt, GetClassProc);
  if dt.Result = nil then
    raise ELMDDockStyles.CreateFmt('Unknown state layer type: %s.', [AType]);
  Result := dt.Result;
end;

class procedure TLMDStateLayer.GetClassProc(AClass: TLMDStateLayerClass;
  AData: Pointer);
begin
  if LMDSameText(TLMDGetStateClassData(AData^).SType, AClass.GetType) then
    TLMDGetStateClassData(AData^).Result := AClass;
end;

class procedure TLMDStateLayer.GetLayerClasses(AData: Pointer;
  AProc: TLMDGetStateClassProc);
const
  KNOWN_CLASSES: array [0..5] of TLMDStateLayerClass = (
    TLMDEmptyLayer,
    TLMDColorLayer,
    TLMDStretchLayer,
    TLMDCenterLayer,
    TLMDTileLayer,
    TLMDMyLayer //!!!!
  );
var
  i: Integer;
begin
  for i := 0 to High(KNOWN_CLASSES) do
    AProc(KNOWN_CLASSES[i], AData);
end;

class function TLMDStateLayer.GetType: TLMDString;
const
  PREFIX = '.TLMD';
  SUFFIX = 'LAYER.';
begin
  Result := Format('.%s.', [ClassName]);
  Result := StringReplace(Result, PREFIX, '.', [rfIgnoreCase]);
  Result := StringReplace(Result, SUFFIX, '.', [rfIgnoreCase]);
  Result := StringReplace(Result, '.', '', [rfReplaceAll]);
end;

procedure TLMDStateLayer.InvaidateDrawInfo;
begin
  FUpdated := False;
end;

function TLMDStateLayer.MasterOpacity(const R: TRect): TLMDRegionOpacity;
const
  ALPHA_MASK = $FF000000;
var
  b:     TLMDBuffer;
  x, y:  Integer;
  ln:    PLMDPixels;
  empty: Boolean;
  opaq:  Boolean;
begin
  b     := GetMaster;
  empty := True;
  opaq  := True;

  for y := R.Top to R.Bottom - 1 do
  begin
    ln := b.ScanLine(y);

    for x := R.Left to R.Right - 1 do
    begin
      if (ln[x] and ALPHA_MASK) <> ALPHA_MASK then
        opaq := False;
      if (ln[x] and ALPHA_MASK) <> 0 then
        empty := False;
    end;
  end;

  if empty then
    Result := roEmpty
  else if opaq then
    Result := roOpaque
  else
    Result := roTranslucent;
end;

function TLMDStateLayer.GetMaster: TLMDBuffer;
begin
  Result := FState.FElem.FStyle.FMaster;
end;

function TLMDStateLayer.GetBitmap: TBitmap;
begin
  Result := FState.FElem.FStyle.FBitmap;
end;

procedure TLMDStateLayer.Read(const ANode: ILMDXmlElement);
begin
  TXmlUtils.ReadProps(Self, ANode, LayerTypeFilter);
end;

procedure TLMDStateLayer.Write(const ANode: ILMDXmlElement);
begin
  TXmlUtils.WriteProps(Self, ANode);
end;

{ TLMDElemSet }

procedure TLMDElemSet.Changed(AChanges: TLMDElemSetChanges);
begin
  if Assigned(FOnChange) then
    FOnChange(Self, AChanges);
end;

constructor TLMDElemSet.Create(AStyle: TLMDDockStyle);
begin
  inherited Create;
  Style := AStyle;
end;

constructor TLMDElemSet.Create;
begin
  Create(nil); // Will set default style.
end;

procedure TLMDElemSet.AssignElemProc(AProp: TLMDPropInfo; AData: Pointer);
var
  tp:   TLMDTypeInfo;
  cls:  TClass;
  elem: TLMDStyleElem;
begin
  tp := AProp.PropType^;

  if tp.Kind <> tkClass then
    Exit; // Ignore prop.

  cls := GetTypeData(tp).ClassType;
  if not cls.InheritsFrom(TLMDStyleElem) then
    Exit; // Ignore prop.

  if (FStyle <> nil) and (FStyle.FState * [dssLoading,
                          dssValid] <> []) then
    elem := FStyle.GetElem(TLMDStyleElemClass(cls))
  else
    elem := nil;

  SetOrdProp(Self, AProp, TLMDPtrInt(elem));
end;

procedure TLMDElemSet.AssignElems;
begin
  EnumProps(AssignElemProc, nil);
end;

procedure TLMDElemSet.SetStyle(const Value: TLMDDockStyle);
const
  ALL_CHANGES = [Low(TLMDElemSetChange)..High(TLMDElemSetChange)];
var
  st: TLMDDockStyle;
begin
  if Value <> nil then
    st := Value
  else
    st := DockStyles.DefaultStyle;

  if FStyle <> st then
  begin
    if FStyle <> nil then
      FStyle.RemoveElemSet(Self);
    if st <> nil then
      st.InsertElemSet(Self);
    AssignElems;
    Changed(ALL_CHANGES);
  end;
end;

{ TXmlUtils }

class procedure TXmlUtils.AddToListProc(AProp: TLMDPropInfo; AData: Pointer);
begin
  TList(AData).Add(AProp);
end;

class function TXmlUtils.GetObjectProp(AInstance: TObject;
  AProp: TLMDPropInfo): TLMDValueObject;
var
  tp:  TLMDTypeInfo;
  cls: TClass;
begin
  tp  := AProp.PropType^;
  cls := GetTypeData(tp).ClassType;

  if not cls.InheritsFrom(TLMDValueObject) then
    raise ELMDDockStyles.CreateFmt('%s.%s: Unsupported object property ' +
                                   'type %s', [AInstance.ClassName, AProp.Name,
                                   tp.Name]);
  Result := TLMDValueObject(GetOrdProp(AInstance, AProp));
end;

class function TXmlUtils.ParseInts(const V: TLMDString;
  ABuffSize: Integer; ABuff: PInteger): Integer;
var
  s: TStrings;
  i: Integer;
begin
  s := TStringList.Create;
  try
    s.Delimiter     := ',';
    s.DelimitedText := V;

    if (s.Count = 0) or (s.Count > ABuffSize) then
      Result := 0
    else
    begin
      for i := 0 to s.Count - 1 do
      begin
        ABuff^ := StrToInt(LMDTrim(s[i]));
        Inc(ABuff);
      end;
      Result := s.Count;
    end;
  finally
    s.Free;
  end;
end;

class procedure TXmlUtils.ReadProps(AInstance: TLMDStyleObject;
  const ANode: ILMDXmlElement; AFilter: TFilterProc);
var
  plist: TList;
  i:     Integer;
  aval:  TLMDString;
  rddt:  TReadData;
  ndgtr: TLMDNodeGetter;

  function PropByName(const AName: TLMDString): TLMDPropInfo;
  var
    i: Integer;
  begin
    for i := 0 to plist.Count - 1 do
    begin
      Result := TLMDPropInfo(plist[i]);
      if LMDSameText(TLMDString(Result.Name), AName) then
        Exit;
    end;
    raise ELMDDockStyles.Create('Property not found.');
  end;

  procedure ReadProp(const AName: TLMDString; AType: TLMDValType; const V);
  var
    tp:   TLMDTypeInfo;
    s:    TLMDString;
    iv:   Integer;
    obj:  TLMDValueObject;
    prop: TLMDPropInfo;
    proc: TIdentToInt;
    clr:  TColor;
  begin
    if Assigned(AFilter) and AFilter(TLMDString(AName)) then
      Exit;

    try
      prop := PropByName(AName);
      tp   := prop.PropType^;

      case tp.Kind of
        tkString,
        tkLString,
        tkWString
        {$IFDEF LMDCOMP12}
        ,tkUString
        {$ENDIF}:       begin
                          s := ValToStr(AType, V);
                          SetStrProp(AInstance, prop, s);
                        end;
        tkInteger:      begin
                          s := ValToStr(AType, V);

                          if tp = TypeInfo(TColor) then
                          begin
                            TLMDColor.BeginSetProp(s, clr);
                            try
                              iv := clr;
                              SetOrdProp(AInstance, prop, iv);
                            finally
                              TLMDColor.EndSetProp;
                            end;
                          end
                          else
                          begin
                            proc := FindIdentToInt(tp);
                            if not Assigned(proc) or not proc(s, iv) then
                              iv := StrToInt(s);
                            SetOrdProp(AInstance, prop, iv);
                          end;
                        end;
        tkInt64:        begin
                          s := ValToStr(AType, V);
                          SetInt64Prop(AInstance, prop, StrToInt64(s));
                        end;
        tkFloat:        begin
                          s := ValToStr(AType, V);
                          SetFloatProp(AInstance, prop, StrToFloat(s));
                        end;
        tkEnumeration:  begin
                          s  := ValToStr(AType, V);
                          iv := GetEnumValue(tp, s);
                          if iv = -1 then
                            iv := StrToInt(s);
                          SetOrdProp(AInstance, prop, iv);
                        end;
        tkClass:        begin
                          obj := GetObjectProp(AInstance, prop);
                          if not obj.Read(AType, V) then
                            raise ELMDDockStyles.Create('Invalid value');
                        end;
      else
        raise ELMDDockStyles.CreateFmt('%s.%s: Property type is not ' +
                                       'supported.', [AInstance.ClassName,
                                       prop.Name]);
      end;
    except
      on E: Exception do
      begin
        E.Message := Format('%s.%s: %s', [AInstance.ClassName,
                                          AName, E.Message]);
        raise;
      end;
    end;
  end;

begin
  plist := TList.Create;
  rddt  := TReadData.Create;
  try
    AInstance.EnumProps(AddToListProc, plist);

    for i := 0 to ANode.AttrCount - 1 do
    begin
      aval := ANode.AttrValues[i];
      ReadProp(ANode.AttrNames[i], vtString, aval);
    end;

    for i := 0 to ANode.ChildNodes.Count - 1 do
    begin
      rddt.Node := ANode.ChildNodes[i].AsElement;
      ndgtr     := rddt.NodeGetter;
      ReadProp(rddt.Node.NodeName, vtNode, ndgtr);
    end;
  finally
    rddt.Free;
    plist.Free;
  end;
end;

class function TXmlUtils.ValToStr(AType: TLMDValType; const V): TLMDString;
begin
  if AType = vtString then
    Result := TLMDString(V)
  else
    Result := TLMDNodeGetter(V).Text;
end;

class procedure TXmlUtils.WritePropProc(AProp: TLMDPropInfo; AData: Pointer);
var
  tp:    TLMDTypeInfo;
  s:     TLMDString;
  obj:   TLMDValueObject;
  wrdt:  TWriteData;
  proc:  TIntToIdent;
  iv:    Integer;
  ident: string;

  procedure WriteStr(const V: TLMDString);
  begin
    wrdt.Node.SetAttr(TLMDString(AProp.Name), V);
  end;

  procedure WriteObj(const V: TLMDValueObject);
  var
    ng: TLMDNodeGetter;
    s:  TLMDString;
  begin
    ng            := wrdt.NodeGetter;
    wrdt.PropName := TLMDString(AProp.Name);

    if V.Write(ng) = vtString then
    begin
      Pointer(s) := Pointer(@ng); // Move releasing
                                  // responsibility.
      WriteStr(s);
    end;
  end;

begin
  wrdt := AData;
  tp   := AProp.PropType^;

  case tp.Kind of
    tkString,
    tkLString,
    tkWString
    {$IFDEF LMDCOMP12}
    ,tkUString
    {$ENDIF}:       begin
                      s := GetStrProp(wrdt.Instance, AProp);
                      WriteStr(s);
                    end;
    tkInteger:      begin
                      proc := FindIntToIdent(tp);
                      iv   := GetOrdProp(wrdt.Instance, AProp);

                      if Assigned(proc) and proc(iv, ident) then
                        s := TLMDString(ident)
                      else if tp = TypeInfo(TColor) then
                        s := '$' + IntToHex(iv, 8)
                      else
                        s := IntToStr(GetOrdProp(wrdt.Instance, AProp));
                      WriteStr(s);
                    end;
    tkInt64:        begin
                      s := IntToStr(GetInt64Prop(wrdt.Instance, AProp));
                      WriteStr(s);
                    end;
    tkFloat:        begin
                      s := FloatToStr(GetFloatProp(wrdt.Instance, AProp));
                      WriteStr(s);
                    end;
    tkEnumeration:  begin
                      s := GetEnumName(tp, GetOrdProp(wrdt.Instance, AProp));
                      WriteStr(s);
                    end;
    tkClass:        begin
                      obj := GetObjectProp(wrdt.Instance, AProp);
                      WriteObj(obj);
                    end;
  else
    raise ELMDDockStyles.CreateFmt('%s.%s: Property type is not supported.',
                                   [wrdt.Instance.ClassName, AProp.Name]);
  end;
end;

class procedure TXmlUtils.WriteProps(AInstance: TLMDStyleObject;
  const ANode: ILMDXmlElement);
var
  wrdt: TWriteData;
begin
  wrdt := TWriteData.Create(AInstance, ANode);
  try
    AInstance.EnumProps(WritePropProc, wrdt);
  finally
    wrdt.Free;
  end;
end;

{ TLMDColorLayer }

constructor TLMDColorLayer.Create(AState: TLMDElemState);
begin
  inherited Create(AState);
  FAlpha   := 255;
  FPattern := TLMDBuffer.Create;
end;

destructor TLMDColorLayer.Destroy;
begin
  FPattern.Free;
  if FBrush <> 0 then
    GDICheck(DeleteObject(FBrush));
  inherited;
end;

procedure TLMDColorLayer.Draw(C: TCanvas; const R: TRect;
  AMode: TLMDDrawMode);
var
  dc: HDC;
begin
  case DRAW_OPACITY[AMode, FOpacity] of
    roTranslucent:  begin
                      AlphaBlend(C.Handle, R.Left, R.Top, R.Right - R.Left,
                                 R.Bottom - R.Top, FPattern.Canvas.Handle,
                                 0, 0, FPattern.Width, FPattern.Height,
                                 BFUNC);
                    end;
    roOpaque:       begin
                      dc := C.Handle;
                      FillRect(dc, R, FBrush);
                    end;
  end;
end;

function TLMDColorLayer.GetColor: TColor;
begin
  Result := TLMDColor.Get(FColor);
end;

procedure TLMDColorLayer.SetColor(const Value: TColor);
begin
  TLMDColor.PropSetter(FColor, Value);
end;

function TLMDColorLayer.UpdateDrawInfo: TLMDRegionOpacity;
type
  TRGB = record
    R, G, B: Byte;
    A:       Byte;
  end;
const
  OPACITY: array[Boolean] of TLMDRegionOpacity = (roTranslucent, roOpaque);
  SIZE     = 16; // Do not change. Value is
                 // optimized in profiler.
var
  rgb:  DWORD;
  px:   RGBQUAD;
  x, y: Integer;
  ln:   PLMDPixels;
  lb:   LOGBRUSH;
begin
  FPattern.Resize(SIZE, SIZE);

  rgb := ColorToRGB(Color);

  px.rgbRed      := Round(TRGB(rgb).R * (FAlpha / 255));
  px.rgbGreen    := Round(TRGB(rgb).G * (FAlpha / 255));
  px.rgbBlue     := Round(TRGB(rgb).B * (FAlpha / 255));
  px.rgbReserved := FAlpha;

  for y := 0 to SIZE - 1 do
  begin
    ln := FPattern.ScanLine(y);
    for x := 0 to SIZE - 1 do
      RGBQUAD(ln[x]) := px;
  end;

  lb.lbStyle := BS_PATTERN;
  lb.lbColor := 0;
  lb.lbHatch := FPattern.DIB;

  if FBrush <> 0 then
    GDICheck(DeleteObject(FBrush));
  FBrush := CreateBrushIndirect(lb); // Do NOT assign this handle to Delphi
                                     // TBrush. NEVER :). It takes ownership
                                     // over brush and pattern DIB handles.
  Result := OPACITY[FAlpha = 255];
end;

{ TBitmapCache }

procedure TBitmapCache.Clear;
var
  itm: TCacheItem;
begin
  while FItems <> nil do
  begin
    itm    := FItems;
    FItems := FItems.FNext;
    itm.Free;
  end;
end;

constructor TBitmapCache.Create;
begin
  inherited Create;
  FCanvas := TLMDBufferCanvas.Create;
end;

destructor TBitmapCache.Destroy;
begin
  Clear;
  FCanvas.Free;
  inherited;
end;

function TBitmapCache.GetBuffer(AId, AWidth, AHeight: Integer;
  AFormat: TLMDBufferFormat; out B: TLMDBuffer): TBufferState;
var
  itm: TCacheItem;
  sz:  TSize;

  function GetAllocSize: TSize;
  begin
    Result.cx := AWidth + AWidth div 8;
    Result.cy := AHeight + AHeight div 8;
  end;

begin
  itm := FItems;

  while (itm <> nil) and (itm.FId <> AId) do
    itm := itm.FNext;

  if itm = nil then
  begin
    RunGC;
    sz  := GetAllocSize;
    itm := TCacheItem.Create(Self, sz.cx, sz.cy, AFormat);
    try
      itm.FId   := AId;
      itm.FNext := FItems;
      FItems    := itm;
    except
      itm.Free;
      raise;
    end;
  end;

  if (itm.FDrawnW = AWidth) and (itm.FDrawnH = AHeight) then
    Result := bsOk
  else
  begin
    if (itm.Width < AWidth) or (itm.Height < AHeight) then
    begin
      sz := GetAllocSize;;
      itm.Resize(sz.cx, sz.cy);
    end;

    itm.FDrawnW := AWidth;
    itm.FDrawnH := AHeight;
    Result      := bsRedraw;
  end;

  itm.FTicks := GetTickCount;
  B          := itm;
end;

procedure TBitmapCache.RunGC;
const
  TIMEOUT = 500;
var
  cur: ^TCacheItem;
  itm:  TCacheItem;
  tcks: Cardinal;
begin
  cur  := @FItems;
  tcks := GetTickCount;

  if tcks < FLastGC + TIMEOUT then
    Exit;

  while cur^ <> nil do
  begin
    if tcks > cur.FTicks + TIMEOUT then
    begin
      itm  := cur^;
      cur^ := cur.FNext;
      itm.Free;
    end
    else
      cur := @cur.FNext;
  end;

  FLastGC := tcks;
end;

{ TLMDFileSource }

procedure TLMDFileSource.CallProc(AKind: TLMDStyleDataKind;
  AMode: Word; AProc: TLMDStyleSourceProc);
const
  FILE_EXTS: array[TLMDStyleDataKind] of string = ('.xml', '.bmp');
var
  s: TFileStream;
begin
  s := TFileStream.Create(ChangeFileExt(FFileName,
                          FILE_EXTS[AKind]), AMode);
  try
    AProc(AKind, s);
  finally
    s.Free;
  end;
end;

constructor TLMDFileSource.Create(const AFileName: TLMDString);
begin
  inherited Create;
  FFileName := AFileName;
end;

procedure TLMDFileSource.Read(AProc: TLMDStyleSourceProc);
begin
  CallProc(sdkXml, fmOpenRead, AProc);
  CallProc(sdkBmp, fmOpenRead, AProc);
end;

procedure TLMDFileSource.Write(AProc: TLMDStyleSourceProc);
begin
  CallProc(sdkXml, fmCreate, AProc);
  CallProc(sdkBmp, fmCreate, AProc);
end;

{ TLMDStretchLayer }

constructor TLMDStretchLayer.Create(AState: TLMDElemState);
begin
  inherited;
  FStretchMargins := TLMDMargins.Create;
end;

destructor TLMDStretchLayer.Destroy;
begin
  FStretchMargins.Free;
  inherited;
end;

procedure TLMDStretchLayer.Draw(C: TCanvas; const R: TRect;
  AMode: TLMDDrawMode);
var
  src, dst: TLMDStretchSizes;
  zn:       TLMDStretchZone;
  sr, dr:   TRect;
begin
  src := FSrcSizes;
  dst := GetSizes(R.Right - R.Left, R.Bottom - R.Top,
                  src.LM, src.TM, src.RM, src.BM);

  for zn := 0 to 8 do
  begin
    case zn of
      0:  begin
            sr := Bounds(FRegion.Left, FRegion.Top, dst.CX[0], dst.CY[0]);
            dr := Bounds(R.Left, R.Top, dst.CX[0], dst.CY[0]);
          end;
      1:  begin
            sr := Bounds(FRegion.Left + src.CX[0], FRegion.Top, src.CX[1],
                         dst.CY[0]);
            dr := Bounds(R.Left + dst.CX[0], R.Top, dst.CX[1], dst.CY[0]);
          end;
      2:  begin
            sr := Bounds(FRegion.Left + src.CX[0] + src.CX[1], FRegion.Top,
                         dst.CX[2], dst.CY[0]);
            dr := Bounds(R.Left + dst.CX[0] + dst.CX[1], R.Top, dst.CX[2],
                         dst.CY[0]);
          end;
      3:  begin
            sr := Bounds(FRegion.Left, FRegion.Top + src.CY[0], dst.CX[0],
                         src.CY[1]);
            dr := Bounds(R.Left, R.Top + dst.CY[0], dst.CX[0], dst.CY[1]);
          end;
      4:  begin
            sr := Bounds(FRegion.Left + src.CX[0], FRegion.Top + src.CY[0],
                         src.CX[1], src.CY[1]);
            dr := Bounds(R.Left + dst.CX[0], R.Top + dst.CY[0], dst.CX[1],
                         dst.CY[1]);
          end;
      5:  begin
            sr := Bounds(FRegion.Left + src.CX[0] + src.CX[1], FRegion.Top +
                         src.CY[0], dst.CX[2], src.CY[1]);
            dr := Bounds(R.Left + dst.CX[0] + dst.CX[1], R.Top + dst.CY[0],
                         dst.CX[2], dst.CY[1]);
          end;
      6:  begin
            sr := Bounds(FRegion.Left, FRegion.Top + src.CY[0] + src.CY[1],
                         dst.CX[0], dst.CY[2]);
            dr := Bounds(R.Left, R.Top + dst.CY[0] + dst.CY[1], dst.CX[0],
                         dst.CY[2]);
          end;
      7:  begin
            sr := Bounds(FRegion.Left + src.CX[0], FRegion.Top + src.CY[0] +
                         src.CY[1], src.CX[1], dst.CY[2]);
            dr := Bounds(R.Left + dst.CX[0], R.Top + dst.CY[0] + dst.CY[1],
                         dst.CX[1], dst.CY[2]);
          end;
      8:  begin
            sr := Bounds(FRegion.Left + src.CX[0] + src.CX[1], FRegion.Top +
                         src.CY[0] + src.CY[1], dst.CX[2], dst.CY[2]);
            dr := Bounds(R.Left + dst.CX[0] + dst.CX[1], R.Top + dst.CY[0] +
                         dst.CY[1], dst.CX[2], dst.CY[2]);
          end;
    else
      Assert(False);
    end;

    case DRAW_OPACITY[AMode, FZnOpacity[zn]] of
      roEmpty:        begin
                        if AMode = dmBlt then
                          FillEmptyRect(C, dr);
                      end;
      roTranslucent:  begin
                        SetStretchBltMode(C.Handle, COLORONCOLOR);
                        AlphaBlend(C.Handle, dr.Left, dr.Top,
                                   dr.Right - dr.Left, dr.Bottom - dr.Top,
                                   RecoloredCanvas.Handle, sr.Left, sr.Top,
                                   sr.Right - sr.Left, sr.Bottom - sr.Top,
                                   BFUNC);
                      end;
      roOpaque:       begin
                        SetStretchBltMode(C.Handle, COLORONCOLOR);
                        StretchBlt(C.Handle, dr.Left, dr.Top,
                                   dr.Right - dr.Left, dr.Bottom - dr.Top,
                                   RecoloredCanvas.Handle, sr.Left, sr.Top,
                                   sr.Right - sr.Left, sr.Bottom - sr.Top,
                                   SRCCOPY);
                      end;
    end;
  end;
end;

function TLMDStretchLayer.GetSizes(AWidth, AHeight,
  LM, TM, RM, BM: Integer): TLMDStretchSizes;

  function GetSize(AValue: Integer; var AMax: Integer): Integer;
  begin
    if AValue <= AMax then
      Result := AValue
    else
      Result := AMax;
    Dec(AMax, Result);
  end;

var
  curw, curh: Integer;
begin
  curw         := AWidth;
  Result.CX[0] := GetSize(LM, curw);
  Result.CX[2] := GetSize(RM, curw);
  Result.CX[1] := curw;

  curh         := AHeight;
  Result.CY[0] := GetSize(TM, curh);
  Result.CY[2] := GetSize(BM, curh);
  Result.CY[1] := curh;
end;

function TLMDStretchLayer.UpdateDrawInfo: TLMDRegionOpacity;
const
  COMBINED_OPACITY: array[TLMDRegionOpacity,
                          TLMDRegionOpacity] of TLMDRegionOpacity =
  (
    // roEmpty          roTranslucent     roOpaque
    (  roEmpty,         roTranslucent,    roTranslucent), // roEmpty
    (  roTranslucent,   roTranslucent,    roTranslucent), // roTranslucent
    (  roTranslucent,   roTranslucent,    roOpaque)       // roOpaque
  );
var
  src: TLMDStretchSizes;
  zn:  TLMDStretchZone;
  r:   TRect;
begin
  FSrcSizes := GetSizes(FRegion.Width, FRegion.Height,
                        FStretchMargins.Left, FStretchMargins.Top,
                        FStretchMargins.Right, FStretchMargins.Bottom);
  Result    := roEmpty;
  src       := FSrcSizes;

  for zn := 0 to 8 do
  begin
    case zn of
      0:  r := Bounds(FRegion.Left, FRegion.Top, src.CX[0], src.CY[0]);
      1:  r := Bounds(FRegion.Left + src.CX[0], FRegion.Top, src.CX[1],
                      src.CY[0]);
      2:  r := Bounds(FRegion.Left + src.CX[0] + src.CX[1], FRegion.Top,
                      src.CX[2], src.CY[0]);
      3:  r := Bounds(FRegion.Left, FRegion.Top + src.CY[0], src.CX[0],
                      src.CY[1]);
      4:  r := Bounds(FRegion.Left + src.CX[0], FRegion.Top + src.CY[0],
                      src.CX[1], src.CY[1]);
      5:  r := Bounds(FRegion.Left + src.CX[0] + src.CX[1], FRegion.Top +
                      src.CY[0], src.CX[2], src.CY[1]);
      6:  r := Bounds(FRegion.Left, FRegion.Top + src.CY[0] + src.CY[1],
                      src.CX[0], src.CY[2]);
      7:  r := Bounds(FRegion.Left + src.CX[0], FRegion.Top + src.CY[0] +
                      src.CY[1], src.CX[1], src.CY[2]);
      8:  r := Bounds(FRegion.Left + src.CX[0] + src.CX[1], FRegion.Top +
                      src.CY[0] + src.CY[1], src.CX[2], src.CY[2]);
    else
      Assert(False);
    end;

    FZnOpacity[zn] := MasterOpacity(r);
    Result         := COMBINED_OPACITY[Result, FZnOpacity[zn]];
  end;
end;

{ TLMDTileLayer }

constructor TLMDTileLayer.Create(AState: TLMDElemState);
begin
  inherited;
  FPattern := TLMDBuffer.Create;
end;

destructor TLMDTileLayer.Destroy;
begin
  FPattern.Free;
  if FBrush <> 0 then
    GDICheck(DeleteObject(FBrush));
  inherited;
end;

procedure TLMDTileLayer.Draw(C: TCanvas; const R: TRect;
  AMode: TLMDDrawMode);
var
  sw, sh: Integer;
  dw, dh: Integer;
  x, y:   Integer;
  dc:     HDC;
begin
  case DRAW_OPACITY[AMode, FOpacity] of
    roTranslucent:  begin
                      sw := FPattern.Width;
                      sh := FPattern.Height;

                      if (sw > 0) and (sh > 0) then
                      begin
                        x := R.Left;
                        y := R.Top;

                        while y < R.Bottom do
                        begin
                          while x < R.Right do
                          begin
                            dw := Min(sw, R.Right - x);
                            dh := Min(sh, R.Bottom - y);
                            AlphaBlend(C.Handle, x, y, dw, dh,
                                       FPattern.Canvas.Handle,
                                       0, 0, dw, dh, BFUNC);
                            Inc(x, sw);
                          end;

                          Inc(y, sh);
                          x := R.Left;
                        end;
                      end;
                    end;
    roOpaque:       begin
                      dc := C.Handle;
                      FillRect(dc, R, FBrush);
                    end;
  end;
end;

function TLMDTileLayer.UpdateDrawInfo: TLMDRegionOpacity;
const
  MIN_SIZE: array[TLMDRegionOpacity] of Integer = (
    0, 128, 16); // Do not change. Values are optimized in profiler.
var
  sr:     TRect;
  sw, sh: Integer;
  dw, dh: Integer;
  x, y:   Integer;
  opaq:   TLMDRegionOpacity;
  lb:     LOGBRUSH;
begin
  sr   := FRegion.Rect;
  sw   := FRegion.Right - FRegion.Left;
  sh   := FRegion.Bottom - FRegion.Top;
  opaq := MasterOpacity(FRegion.Rect);

  if (sw > 0) and (sh > 0) then
  begin
    dw := 0;
    dh := 0;
    while dw < MIN_SIZE[opaq] do
      Inc(dw, sw);
    while dh < MIN_SIZE[opaq] do
      Inc(dh, sh);

    FPattern.Resize(dw, dh);
    FillEmptyRect(FPattern.Canvas, Rect(0, 0, dw, dh));

    x := 0;
    y := 0;

    while y < dh do
    begin
      while x < dw do
      begin
        AlphaBlend(FPattern.Canvas.Handle, x, y, sw, sh,
                   RecoloredCanvas.Handle, sr.Left, sr.Top,
                   sw, sh, BFUNC);
        Inc(x, sw);
      end;

      Inc(y, sh);
      x := 0;
    end;
  end;

  lb.lbStyle := BS_PATTERN;
  lb.lbColor := 0;
  lb.lbHatch := FPattern.DIB;

  if FBrush <> 0 then
    GDICheck(DeleteObject(FBrush));
  FBrush := CreateBrushIndirect(lb); // Do NOT assign this handle to Delphi
                                     // TBrush. NEVER :). It takes ownership
                                     // over brush and pattern DIB handles.
  Result := opaq;
end;

{ TLMDEmptyLayer }

procedure TLMDEmptyLayer.Draw(C: TCanvas; const R: TRect;
  AMode: TLMDDrawMode);
begin
  // Do nothing.
end;

function TLMDEmptyLayer.UpdateDrawInfo: TLMDRegionOpacity;
begin
  Result := roEmpty;
end;

{ TReadData }

function TReadData.NodeGetter: ILMDXmlElement;
begin
  Result := FNode;
end;

{ TWriteData }

constructor TWriteData.Create(AInstance: TObject; const ANode: ILMDXmlElement);
begin
  inherited Create;
  FInstance := AInstance;
  FNode     := ANode;
end;

function TWriteData.NodeGetter: ILMDXmlElement;
begin
  Result := FNode.AppendElement(FPropName);
end;

{ TLMDMargins }

function TLMDMargins.AdjustRect(const R: TRect): TRect;
begin
  with Result do
  begin
    Left   := R.Left + FLeft;
    Top    := R.Top + FTop;
    Right  := R.Right - FRight;
    Bottom := R.Bottom - FBottom;

    if Right < Left then
      Right := Left;
    if Bottom < Top then
      Bottom := Top;
  end;
end;

function TLMDMargins.AdjustSize(const R: TRect): TSize;
begin
  Result := AdjustSize(R.Right - R.Left, R.Bottom - R.Top);
end;

function TLMDMargins.AdjustSize(AWidth, AHeight: Integer): TSize;
begin
  with Result do
  begin
    cx := AWidth - FLeft - FRight;
    cy := AHeight - FTop - FBottom;

    if cx < 0 then
      cx := 0;
    if cy < 0 then
      cy := 0;
  end;
end;

function TLMDMargins.GetAsString: TLMDString;
begin
  if (FTop = FLeft) and (FRight = FLeft) and (FBottom = FLeft) then
    Result := IntToStr(FLeft)
  else
    Result := Format('%d,%d,%d,%d', [FLeft, FTop, FRight, FBottom]);
end;

function TLMDMargins.IsEqualTo(M: TLMDMargins): Boolean;
begin
  Result := (Left = M.Left) and (Top = M.Top) and
            (Right = M.Right) and (Bottom = M.Bottom);
end;

function TLMDMargins.AdjustSize(ASize: TSize): TSize;
begin
  Result := AdjustSize(ASize.cx, ASize.cy);
end;

function TLMDMargins.Read(AType: TLMDValType; const V): Boolean;
begin
  if AType = vtString then
  begin
    AsString := TLMDString(V);
    Result   := True;
  end
  else
    Result := False;
end;

procedure TLMDMargins.SetAsString(const Value: TLMDString);
var
  buf: array[0..3] of Integer;
begin
  case TXmlUtils.ParseInts(Value, 4, @buf) of
    1:  begin
          FLeft   := buf[0];
          FTop    := buf[0];
          FRight  := buf[0];
          FBottom := buf[0];
        end;
    4:  begin
          FLeft   := buf[0];
          FTop    := buf[1];
          FRight  := buf[2];
          FBottom := buf[3];
        end;
  else
    raise ELMDDockStyles.Create('Invalid value');
  end;
end;

function TLMDMargins.UnadjustRect(const R: TRect): TRect;
begin
  with Result do
  begin
    Left   := R.Left - FLeft;
    Top    := R.Top - FTop;
    Right  := R.Right + FRight;
    Bottom := R.Bottom + FBottom;

    if Right < Left then
      Right := Left;
    if Bottom < Top then
      Bottom := Top;
  end;
end;

function TLMDMargins.UnadjustSize(ASize: TSize): TSize;
begin
  Result := UnadjustSize(ASize.cx, ASize.cy);
end;

function TLMDMargins.UnadjustSize(const R: TRect): TSize;
begin
  Result := UnadjustSize(R.Right - R.Left, R.Bottom - R.Top);
end;

function TLMDMargins.UnadjustSize(AWidth, AHeight: Integer): TSize;
begin
  with Result do
  begin
    cx := AWidth + FLeft + FRight;
    cy := AHeight + FTop + FBottom;

    if cx < 0 then
      cx := 0;
    if cy < 0 then
      cy := 0;
  end;
end;

function TLMDMargins.Write(var V): TLMDValType;
begin
  Pointer(V)    := nil;
  TLMDString(V) := AsString;
  Result        := vtString;
end;

{ TLMDRegion }

function TLMDRegion.GetInt(const Index: Integer): Integer;
begin
  case Index of
    0: Result := FRect.Left;
    1: Result := FRect.Top;
    2: Result := FRect.Right;
    3: Result := FRect.Bottom;
    4: Result := FRect.Right - FRect.Left;
    5: Result := FRect.Bottom - FRect.Top;
  else
    Result := -1; // Initialize.
    Assert(False);
  end;
end;

function TLMDRegion.IsEmpty: Boolean;
begin
  Result := IsRectEmpty(FRect);
end;

function TLMDRegion.Read(AType: TLMDValType; const V): Boolean;
var
  buf: array[0..3] of Integer;
begin
  if AType = vtString then
  begin
    if TXmlUtils.ParseInts(TLMDString(V), 4, @buf) = 4 then
    begin
      FRect.Left   := buf[0];
      FRect.Top    := buf[1];
      FRect.Right  := buf[2];
      FRect.Bottom := buf[3];
    end
    else
      raise ELMDDockStyles.Create('Invalid value');
    Result := True;
  end
  else
    Result := False;
end;

procedure TLMDRegion.SetInt(const Index, Value: Integer);
begin
  case Index of
    0: FRect.Left   := Value;
    1: FRect.Top    := Value;
    2: FRect.Right  := Value;
    3: FRect.Bottom := Value;
  else
    Assert(False);
  end;
end;

function TLMDRegion.Write(var V): TLMDValType;
begin
  Pointer(V)    := nil;
  TLMDString(V) := Format('%d,%d,%d,%d', [FRect.Left, FRect.Top,
                                          FRect.Right, FRect.Bottom]);
  Result        := vtString;
end;

{ TLMDCenterLayer }

procedure TLMDCenterLayer.Draw(C: TCanvas; const R: TRect;
  AMode: TLMDDrawMode);
var
  sr:     TRect;
  sw, sh: Integer;
  x, y:   Integer;
begin
  sr := FRegion.Rect;
  sw := FRegion.Right - FRegion.Left;
  sh := FRegion.Bottom - FRegion.Top;
  x  := (R.Left + R.Right - sw) div 2;
  y  := (R.Top + R.Bottom - sh) div 2;

  case DRAW_OPACITY[AMode, FOpacity] of
    roTranslucent:  begin
                      AlphaBlend(C.Handle, x, y, sw, sh, RecoloredCanvas.
                                 Handle, sr.Left, sr.Top, sw, sh, BFUNC);
                    end;
    roOpaque:       begin
                      if (AMode = dmBlt) and ((R.Right - R.Left) * (R.Bottom -
                                              R.Top) > sw * sh) then
                        FillEmptyRect(C, R);
                      BitBlt(C.Handle, x, y, sw, sh, RecoloredCanvas.
                             Handle, sr.Left, sr.Top, SRCCOPY);
                    end;
  end;
end;

function TLMDCenterLayer.UpdateDrawInfo: TLMDRegionOpacity;
begin
  Result := MasterOpacity(FRegion.Rect);
  if Result = roOpaque then  // Center layer fills only the
    Result := roTranslucent; // center of the provided rect.
end;

{ TLMDResourceSource }

procedure TLMDResourceSource.CallProc(AKind: TLMDStyleDataKind;
  AProc: TLMDStyleSourceProc);
const
  RES_SUFFIX: array[TLMDStyleDataKind] of string = ('_XML', '_BMP');
var
  s: TStream;
begin
  s := TResourceStream.Create(HInstance, FResName + RES_SUFFIX[AKind],
                              RT_RCDATA);
  try
    AProc(AKind, s);
  finally
    s.Free;
  end;
end;

constructor TLMDResourceSource.Create(const AResName: TLMDString);
begin
  inherited Create;
  FResName := AResName;
end;

procedure TLMDResourceSource.Read(AProc: TLMDStyleSourceProc);
begin
  CallProc(sdkXml, AProc);
  CallProc(sdkBmp, AProc);
end;

procedure TLMDResourceSource.Write(AProc: TLMDStyleSourceProc);
begin
  raise ELMDDockStyles.Create('Can''t write to a read-only resource ' +
                              'style source.');
end;

{ TLMDBuffer }

procedure TLMDBuffer.AdjustStatistic;
var
  sz: Integer;
begin
  sz       := FWidth * FHeight * SizeOf(DWORD);
  BufBytes := BufBytes - FOldSize + sz;
  if BufMax < BufBytes then
    BufMax := BufBytes;
  FOldSize := sz;
end;

class function TLMDBuffer.Allocated: Integer;
begin
  Result := BufBytes;
end;

class procedure TLMDBuffer.BeginDraw(ACanvas: TCanvas; const R: TRect);
var
  dt: TBufDrawData;
begin
  dt       := TBufDrawData.Create(ACanvas, R);
  dt.FNext := BufDraws;
  BufDraws := dt;
end;

constructor TLMDBuffer.Create(AFormat: TLMDBufferFormat);
begin
  Create(0, 0, AFormat);
end;

function TLMDBuffer.GetCanvas: TCanvas;
begin
  if FDefCanvas = nil then
    FDefCanvas := TLMDBufferCanvas.Create(Self);
  Result := FDefCanvas;
end;

class function TLMDBuffer.MaxAllocated: Integer;
begin
  Result := BufMax;
end;

constructor TLMDBuffer.Create(AWidth, AHeight: Integer;
  AFormat: TLMDBufferFormat);
begin
  inherited Create;
  FFormat := AFormat;
  FWidth  := AWidth;
  FHeight := AHeight;
  RecreateDIB;
end;

destructor TLMDBuffer.Destroy;
begin
  FinalizeDIB;
  FDefCanvas.Free;
  inherited;
end;

class procedure TLMDBuffer.EndDraw;
var
  dt: TBufDrawData;
begin
  dt := BufDraws;

  if dt = nil then
    raise ELMDDockStyles.Create('Incorrect buffered draw nesting.');
  dt.Flush;

  BufDraws := dt.FNext;
  dt.Free;
end;

procedure TLMDBuffer.FinalizeDIB;
begin
  if FSelectedIn <> nil then
    FSelectedIn.Select(nil);
  GDICheck(DeleteObject(FDIB));
  Dec(BufBytes, FOldSize);
end;

procedure TLMDBuffer.RecreateDIB;
const
  BITCOUNT: array[TLMDBufferFormat] of Word = (24, 32);
var
  old: HBITMAP;
  nfo: BITMAPINFO;
begin
  with nfo.bmiHeader do
  begin
    biSize        := SizeOf(BITMAPINFOHEADER);
    biWidth       := Max(FWidth, 1);
    biHeight      := -Max(FHeight, 1); // Top-down DIB.
    biPlanes      := 1;
    biBitCount    := BITCOUNT[FFormat];
    biCompression := BI_RGB;
  end;

  old  := FDIB;
  FDIB := CreateDIBSection(0, nfo, DIB_RGB_COLORS, Pointer(FData), 0, 0);
  GDICheck(FDIB);

  if FSelectedIn <> nil then
    FSelectedIn.DoSelect;
  if old <> 0 then
    GDICheck(DeleteObject(old));
  AdjustStatistic;
end;

function TLMDBuffer.ScanLine(ALine: Integer): PLMDPixels;
begin
  Result := @PLMDPixels(FData)[ALine * FWidth];
end;

procedure TLMDBuffer.Resize(AWidth, AHeight: Integer);
begin
  if (FWidth <> AWidth) or (FHeight <> AHeight) then
  begin
    FWidth  := AWidth;
    FHeight := AHeight;
    RecreateDIB;
  end;
end;

{ TLMDBufferCanvas }

constructor TLMDBufferCanvas.Create;
begin
  Create(nil);
end;

constructor TLMDBufferCanvas.Create(ABuffer: TLMDBuffer);
begin
  inherited Create;
  Select(ABuffer);
  CanvasList.InsertItem(Self);
end;

procedure TLMDBufferCanvas.CreateHandle;
begin
  Handle := GetDC;
end;

destructor TLMDBufferCanvas.Destroy;
begin
  Select(nil);
  FreeDC;
  CanvasList.RemoveItem(Self);
  inherited;
end;

procedure TLMDBufferCanvas.DoSelect;
var
  old: HBITMAP;
begin
  if FDC <> 0 then
  begin
    if FSelected <> nil then
    begin
      old := SelectObject(FDC, FSelected.DIB);
      GDICheck(old);

      if FDefDIB = 0 then // Save only original old DIB.
        FDefDIB := old;   //
    end
    else if FDefDIB <> 0 then
    begin
      GDICheck(SelectObject(FDC, FDefDIB));
      FDefDIB := 0;
    end;
  end;
end;

procedure TLMDBufferCanvas.FreeDC;
begin
  if FDC <> 0 then
  begin
    Handle  := 0;
    GDICheck(DeleteDC(FDC));
    FDC     := 0;
    FDefDIB := 0;
  end;
end;

function TLMDBufferCanvas.GetDC: HDC;
begin
  if FDC = 0 then
  begin
    FDC     := CreateCompatibleDC(0);
    FDefDIB := 0;
    DoSelect;
  end;
  Result := FDC;
end;

procedure TLMDBufferCanvas.Select(ABuffer: TLMDBuffer);
begin
  if FSelected <> ABuffer then
  begin
    if (ABuffer <> nil) and (ABuffer.FSelectedIn <> nil) then
      raise ELMDDockStyles.Create('Buffer is already selected in ' +
                                  'another canvas.');

    if FSelected <> nil then
      FSelected.FSelectedIn := nil;
    FSelected := ABuffer;
    if FSelected <> nil then
      FSelected.FSelectedIn := Self;
    DoSelect;
  end;
end;

{ TCacheItem }

constructor TCacheItem.Create(ACache: TBitmapCache);
begin
  inherited Create;
  FCache := ACache;
end;

constructor TCacheItem.Create(ACache: TBitmapCache; AWidth,
  AHeight: Integer; AFormat: TLMDBufferFormat);
begin
  inherited Create(AWidth, AHeight, AFormat);
  FCache := ACache;
end;

function TCacheItem.GetCanvas: TCanvas;
begin
  FCache.FCanvas.Select(Self);
  Result := FCache.FCanvas;
end;

{ TBufDrawData }

procedure TBufDrawData.Flush;
var
  x, y: Integer;
  w, h: Integer;
begin
  Assert(FInited);
  RestoreCanvas;

  x := FR.Left; // Source origin should be equal to dest origin,
  y := FR.Top;  // because buffer DC viewport origin is still
                // offset.
  w := FR.Right - FR.Left;
  h := FR.Bottom - FR.Top;

  BitBlt(FCanvas.Handle, x, y, w, h,
         FBufDC.DC, x, y, SRCCOPY);
end;

constructor TBufDrawData.Create(ACanvas: TCanvas; const R: TRect);
begin
  inherited Create;
  FCanvas := ACanvas;
  FR      := R;
  FBuffer := TLMDBuffer.Create(R.Right - R.Left,
                               R.Bottom - R.Top,
                               bf24bit);
  FBufDC  := TLMDBufferCanvas.Create(FBuffer);
  InitCanvas;
end;

destructor TBufDrawData.Destroy;
begin
  RestoreCanvas;
  FBufDC.Free;
  FBuffer.Free;
  inherited;
end;

procedure TBufDrawData.InitCanvas;
var
  dc: HDC;
begin
  dc := FBufDC.DC;
  SetWindowOrgEx(dc, FR.Left, FR.Top, nil);

  if FCanvas.HandleAllocated then // Don't force canvas to update
    FOldDC := FCanvas.Handle;     // its state immediately.
  FCanvas.Handle := dc;

  FCanvas.Lock;
  FInited := True;
end;

procedure TBufDrawData.RestoreCanvas;
begin
  if FInited then
  begin
    FCanvas.Handle := FOldDC; // We have to reset canvas handle,
                              // even if olf DC is zero.
    FInited        := False;
    FCanvas.Unlock;
  end;
end;

{ TCanvasList }

constructor TCanvasList.Create;
begin
  inherited Create;
  FItems := TList.Create;
  FWnd   := AllocateHWnd(WndProc);
//  WTSRegisterSessionNotification(FWnd, NOTIFY_FOR_THIS_SESSION);
end;

destructor TCanvasList.Destroy;
begin
//  WTSUnRegisterSessionNotification(FWnd);
  DeallocateHWnd(FWnd);
  FItems.Free;
  inherited;
end;

procedure TCanvasList.FreeContexts;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TLMDBufferCanvas(FItems[i]).FreeDC;
end;

procedure TCanvasList.InsertItem(ACanvas: TLMDBufferCanvas);
begin
  FItems.Add(ACanvas);
end;

procedure TCanvasList.RemoveItem(ACanvas: TLMDBufferCanvas);
begin
  FItems.Remove(ACanvas);
end;

procedure TCanvasList.WndProc(var Msg: TMessage);
begin
//  try
//    if Msg.Msg = WM_WTSSESSION_CHANGE then
//    begin
//      FreeContexts; // On XP device contexts becomes invalid after (possibly
//                    // long) session lock, so we should destroy them.
//      Msg.Result := 0;
//    end
//    else
//      Msg.Result := DefWindowProc(FWnd, Msg.Msg, Msg.WParam,
//                                  Msg.LParam);
//  except
//    Application.HandleException(Self);
//  end;
end;

{ TLMDStyleObject }

class procedure TLMDStyleObject.EnumProps(AProc: TLMDEnumPropProc;
  AData: Pointer);
var
  i, pcnt: Integer;
  props:   TLMDPropList;
  tpnfo:   Pointer;
begin
  tpnfo := ClassInfo;
  pcnt  := GetPropList(tpnfo, tkAny, nil);

  GetMem(props, pcnt * SizeOf(Pointer));
  try
    GetPropList(tpnfo, tkAny, props, False);
    for i := 0 to pcnt - 1 do
      AProc(props[i], AData);
  finally
    FreeMem(props);
  end;
end;

{ TLMDRegisteredSource }

constructor TLMDRegisteredSource.Create(AStyles: TLMDDockStyles;
  const AName: TLMDStyleName; AIsDefault: Boolean; ASource: TLMDStyleSource);
begin
  inherited Create;
  FName      := AName;
  FIsDefault := AIsDefault;
  FSource    := ASource;
  AStyles.InsertRegSource(Self);
end;

destructor TLMDRegisteredSource.Destroy;
begin
  if FStyles <> nil then
    FStyles.RemoveRegSource(Self);
  FSource.Free;
  inherited;
end;

{ TLMDMyLayer }

procedure TLMDMyLayer.Draw(C: TCanvas; const R: TRect; AMode: TLMDDrawMode);
begin
  C.Brush.Color := clRed;
  C.FillRect(R);
end;

function TLMDMyLayer.UpdateDrawInfo: TLMDRegionOpacity;
begin
  Result := roTranslucent;
end;

{ TLMDRegionLayerBase }

constructor TLMDRegionLayerBase.Create(AState: TLMDElemState);
begin
  inherited;
  FRegion      := TLMDRegion.Create;
  FRecolorFrom := TLMDColor.Make(clBlack);
  FRecolorTo   := TLMDColor.Make(clNone);
end;

destructor TLMDRegionLayerBase.Destroy;
begin
  FRegion.Free;
  FRecolored.Free;
  inherited;
end;

function TLMDRegionLayerBase.GetRecolorFrom: TColor;
begin
  Result := TLMDColor.Get(FRecolorFrom);
end;

function TLMDRegionLayerBase.GetRecolorTo: TColor;
begin
  Result := TLMDColor.Get(FRecolorTo);
end;

procedure TLMDRegionLayerBase.InvaidateDrawInfo;
begin
  inherited;
  FreeAndNil(FRecolored);
end;

function TLMDRegionLayerBase.Recolor(AFrom, ATo: TColor): TLMDBuffer;
type
  TPixel = packed record
    R: Byte;
    G: Byte;
    B: Byte;
    A: Byte;
  end;
const
  ALPHA_MASK = $FF000000;
var
  alpha: Boolean;
  w, h:  Integer;
  i:     Integer;
  cfrom: DWORD;
  cto:   DWORD;
begin
  alpha  := (GetBitmap.PixelFormat = pf32bit);
  w      := FRegion.Width;
  h      := FRegion.Height;
  Result := TLMDBuffer.Create(w, h);
  try
    BitBlt(Result.Canvas.Handle, 0, 0, w, h,
           GetBitmap.Canvas.Handle, FRegion.Left,
           FRegion.Top, SRCCOPY);
    GDIFlush;

    { Recolor }

    cfrom := ColorToRGB(AFrom);
    cfrom := ((cfrom and $000000FF) shl 16) or
             (cfrom and $0000FF00) or
             ((cfrom and $00FF0000) shr 16);
    cto   := ColorToRGB(ATo);
    cto   := ((cto and $000000FF) shl 16) or
             (cto and $0000FF00) or
             ((cto and $00FF0000) shr 16);

    for i := 0 to w * h - 1 do
    begin
      if (Result.Data[i] and not ALPHA_MASK) = cfrom then
        Result.Data[i] := cto or (Result.Data[i] and ALPHA_MASK);
    end;

    { Premultiply }

    for i := 0 to w * h - 1 do
      with TPixel(Result.Data[i]) do
        if alpha then
        begin
          R := MulDiv(R, A, 255);
          G := MulDiv(G, A, 255);
          B := MulDiv(B, A, 255);
        end
        else
          A := 255;

    { Change origin }

    SetWindowOrgEx(Result.Canvas.Handle, FRegion.Left,
                   FRegion.Top, nil);
  except
    Result.Free;
    raise;
  end;
end;

function TLMDRegionLayerBase.RecoloredCanvas: TCanvas;
begin
  if RecolorTo <> clNone then
  begin
    if FRecolored = nil then
      FRecolored := Recolor(RecolorFrom, RecolorTo);
    Result := FRecolored.Canvas
  end
  else
    Result := GetMaster.Canvas;
end;

procedure TLMDRegionLayerBase.SetRecolorFrom(const Value: TColor);
begin
  TLMDColor.PropSetter(FRecolorFrom, Value);
end;

procedure TLMDRegionLayerBase.SetRecolorTo(const Value: TColor);
begin
  TLMDColor.PropSetter(FRecolorTo, Value);
end;

{ TKnownIdentTraits }

class function TKnownIdentTraits.Compare(const AKey; AItem: TObject): Boolean;
begin
  Result := (TLMDString(AKey) = TKnownIdentItem(AItem).Value.Key);
end;

class function TKnownIdentTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := MakeHashK(TKnownIdentItem(AItem).Value.Key);
end;

class function TKnownIdentTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.StrHash(TLMDString(AKey));
end;

initialization
  TLMDColor.InitKnownIdents;
  CanvasList := TCanvasList.Create;
  DockStyles := TLMDDockStyles.Create;

finalization
  DockStyles.Free;
  DockStyles := nil;
  CanvasList.Free;
  KnownIdents.Free;

end.
