unit LMDRTFInt;
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

LMDRTFInt unit (RM)
-------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, ActiveX, RichEdit, Forms,
  OleCtnrs, OleDlg, 
  LMDRTFRichEdit;

// Constants for enum tomOpenFlags
type

  tomOpenFlags = TOleEnum;

const
  tomRTF = $00000001;
  tomText = $00000002;
  tomHTML = $00000003;
  tomWordDocument = $00000004;
  tomCreateNew = $00000010;
  tomCreateAlways = $00000020;
  tomOpenExisting = $00000030;
  tomOpenAlways = $00000040;
  tomTruncateExisting = $00000050;
  tomReadOnly = $00000100;
  tomShareDenyRead = $00000200;
  tomShareDenyWrite = $00000400;
  tomPasteFile = $00001000;

// Constants for enum tomLineSpacingRules
type
  tomLineSpacingRules = TOleEnum;

const
  tomLineSpaceSingle = $00000000;
  tomLineSpace1pt5 = $00000001;
  tomLineSpaceDouble = $00000002;
  tomLineSpaceAtLeast = $00000003;
  tomLineSpaceExactly = $00000004;
  tomLineSpaceMultiple = $00000005;

// Constants for enum tomAlign
type
  tomAlign = TOleEnum;

const
  tomAlignLeft = $00000000;
  tomAlignCenter = $00000001;
  tomAlignRight = $00000002;
  tomAlignJustify = $00000003;
  tomAlignDecimal = $00000003;
  tomAlignBar = $00000004;

// Constants for enum tomSelection
type
  tomSelection = TOleEnum;

const
  tomNoSelection = $00000000;
  tomSelectionIP = $00000001;
  tomSelectionNormal = $00000002;
  tomSelectionFrame = $00000003;
  tomSelectionColumn = $00000004;
  tomSelectionRow = $00000005;
  tomSelectionBlock = $00000006;
  tomSelectionInlineShape = $00000007;
  tomSelectionShape = $00000008;

// Constants for enum tomBool
type
  tomBool = TOleEnum;

const
  tomFalse = $00000000;
  tomTrue = $FFFFFFFF;
  tomToggle = $FF676982;

// Constants for enum tomColor
type
  tomColor = TOleEnum;

const
  tomAutoColor = $FF676983;

// Constants for enum tomResetFlags
type
  tomResetFlags = TOleEnum;

const
  tomDefault = $FF676984;
  tomUndefined = $FF676981;

// Constants for enum tomMove
type
  tomMove = TOleEnum;

const
  tomBackward = $C0000001;
  tomForward = $3FFFFFFF;

// Constants for enum tomExtend
type
  tomExtend = TOleEnum;

const
  tomMove_ = $00000000;
  tomExtend_ = $00000001;

// Constants for enum tomSelectionFlags
type
  tomSelectionFlags = TOleEnum;

const
  tomSelStartActive = $00000001;
  tomSelAtEOL = $00000002;
  tomSelOvertype = $00000004;
  tomSelActive = $00000008;
  tomSelReplace = $00000010;

// Constants for enum tomStartEnd
type
  tomStartEnd = TOleEnum;

const
  tomEnd = $00000000;
  tomStart = $00000020;

// Constants for enum tomCollapse
type
  tomCollapse = TOleEnum;

const
  tomCollapseEnd = $00000000;
  tomCollapseStart = $00000001;

// Constants for enum tomUnderline
type
  tomUnderline = TOleEnum;

const
  tomNone = $00000000;
  tomSingle = $00000001;
  tomWords = $00000002;
  tomDouble = $00000003;
  tomDotted = $00000004;

// Constants for enum tomTabSpace
type
  tomTabSpace = TOleEnum;

const
  tomSpaces = $00000000;
  tomDots = $00000001;
  tomDashes = $00000002;
  tomLines = $00000003;

// Constants for enum tomTabs
type
  tomTabs = TOleEnum;

const
  tomTabBack = $FFFFFFFD;
  tomTabNext = $FFFFFFFE;
  tomTabHere = $FFFFFFFF;

// Constants for enum tomList
type
  tomList = TOleEnum;

const
  tomListNone = $00000000;
  tomListBullet = $00000001;
  tomListNumberAsArabic = $00000002;
  tomListNumberAsLCLetter = $00000003;
  tomListNumberAsUCLetter = $00000004;
  tomListNumberAsLCRoman = $00000005;
  tomListNumberAsUCRoman = $00000006;
  tomListNumberAsSequence = $00000007;
  tomListParentheses = $00010000;
  tomListPeriod = $00020000;
  tomListPlain = $00030000;

// Constants for enum tomUnits
type
  tomUnits = TOleEnum;

const
  tomCharacter = $00000001;
  tomWord = $00000002;
  tomSentence = $00000003;
  tomParagraph = $00000004;
  tomLine = $00000005;
  tomStory = $00000006;
  tomScreen = $00000007;
  tomSection = $00000008;
  tomColumn = $00000009;
  tomRow = $0000000A;
  tomWindow = $0000000B;
  tomCell = $0000000C;
  tomCharFormat = $0000000D;
  tomParaFormat = $0000000E;
  tomTable = $0000000F;
  tomObject = $00000010;

// Constants for enum tomFindFlags
type
  tomFindFlags = TOleEnum;

const
  tomMatchWord = $00000002;
  tomMatchCase = $00000004;
  tomMatchPattern = $00000008;

// Constants for enum tomStories
type
  tomStories = TOleEnum;

const
  tomUnknownStory = $00000000;
  tomMainTextStory = $00000001;
  tomFootnotesStory = $00000002;
  tomEndnotesStory = $00000003;
  tomCommentsStory = $00000004;
  tomTextFrameStory = $00000005;
  tomEvenPagesHeaderStory = $00000006;
  tomPrimaryHeaderStory = $00000007;
  tomEvenPagesFooterStory = $00000008;
  tomPrimaryFooterStory = $00000009;
  tomFirstPageHeaderStory = $0000000A;
  tomFirstPageFooterStory = $0000000B;

// Constants for enum tomAnimation
type
  tomAnimation = TOleEnum;

const
  tomNoAnimation = $00000000;
  tomLasVegasLights = $00000001;
  tomBlinkingBackground = $00000002;
  tomSparkleText = $00000003;
  tomMarchingBlackAnts = $00000004;
  tomMarchingRedAnts = $00000005;
  tomShimmer = $00000006;
  tomWipeDown = $00000007;
  tomWipeRight = $00000008;
  tomAnimationMax = $00000008;

// Constants for enum tomCase
type
  tomCase = TOleEnum;

const
  tomLowerCase = $00000000;
  tomUpperCase = $00000001;
  tomTitleCase = $00000002;
  tomSentenceCase = $00000004;
  tomToggleCase = $00000005;

{ Structure passed to GetObject and InsertObject }

type
  _ReObject = record
    cbStruct: DWORD; { Size of structure                }
    cp: ULONG; { Character position of object     }
    clsid: TCLSID; { Class ID of object               }
    poleobj: IOleObject; { OLE object interface             }
    pstg: IStorage; { Associated storage interface     }
    polesite: IOleClientSite; { Associated client site interface }
    sizel: TSize; { Size of object (may be 0,0)      }
    dvAspect: Longint; { Display aspect to use            }
    dwFlags: DWORD; { Object status flags              }
    dwUser: DWORD; { Dword for user's use             }
  end;
  TReObject = _ReObject;

const

  EM_GETSCROLLPOS   = WM_USER + 221;
  EM_SETSCROLLPOS   = WM_USER + 222;
  // Change fontsize in current selection by wParam
  EM_SETFONTSIZE    = WM_USER + 223;

  EM_GETZOOM        = WM_USER + 224;
  EM_SETZOOM        = WM_USER + 225;

{ Flags to specify which interfaces should be returned in the structure above }

  REO_GETOBJ_NO_INTERFACES = $00000000;
  REO_GETOBJ_POLEOBJ = $00000001;
  REO_GETOBJ_PSTG = $00000002;
  REO_GETOBJ_POLESITE = $00000004;
  REO_GETOBJ_ALL_INTERFACES = $00000007;

{ Place object at selection }

  REO_CP_SELECTION = ULONG(-1);

{ Use character position to specify object instead of index }

  REO_IOB_SELECTION = ULONG(-1);
  REO_IOB_USE_CP = ULONG(-2);

{ Object flags }

  REO_NULL = $00000000; { No flags                         }
  REO_READWRITEMASK = $0000003F; { Mask out RO bits                 }
  REO_DONTNEEDPALETTE = $00000020; { Object doesn't need palette      }
  REO_BLANK = $00000010; { Object is blank                  }
  REO_DYNAMICSIZE = $00000008; { Object defines size always       }
  REO_INVERTEDSELECT = $00000004; { Object drawn all inverted if sel }
  REO_BELOWBASELINE = $00000002; { Object sits below the baseline   }
  REO_RESIZABLE = $00000001; { Object may be resized            }
  REO_LINK = $80000000; { Object is a link (RO)            }
  REO_STATIC = $40000000; { Object is static (RO)            }
  REO_SELECTED = $08000000; { Object selected (RO)             }
  REO_OPEN = $04000000; { Object open in its server (RO)   }
  REO_INPLACEACTIVE = $02000000; { Object in place active (RO)      }
  REO_HILITED = $01000000; { Object is to be hilited (RO)     }
  REO_LINKAVAILABLE = $00800000; { Link believed available (RO)     }
  REO_GETMETAFILE = $00400000; { Object requires metafile (RO)    }

{ Flags for IRichEditOle.GetClipboardData,   }
{ IRichEditOleCallback.GetClipboardData and  }
{ IRichEditOleCallback.QueryAcceptData       }

  RECO_PASTE = $00000000; { paste from clipboard  }
  RECO_DROP = $00000001; { drop                  }
  RECO_COPY = $00000002; { copy to the clipboard }
  RECO_CUT = $00000003; { cut to the clipboard  }
  RECO_DRAG = $00000004; { drag                  }

{ RichEdit GUIDs }

  IID_IRichEditOle: TGUID = '{00020D00-0000-0000-C000-000000000046}';
  IID_IRichEditOleCallback: TGUID = '{00020D03-0000-0000-C000-000000000046}';

  IID_ITextDocument: TGUID = '{8CC497C0-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextRange: TGUID = '{8CC497C2-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextSelection: TGUID = '{8CC497C1-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextFont: TGUID = '{8CC497C3-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextPara: TGUID = '{8CC497C4-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextStoryRanges: TGUID = '{8CC497C5-A1DF-11CE-8098-00AA0047BE5D}';

type

{$WARNINGS OFF}
  ITextDocumentDisp = dispinterface;
  ITextRangeDisp = dispinterface;
  ITextSelectionDisp = dispinterface;
  ITextFontDisp = dispinterface;
  ITextParaDisp = dispinterface;
  ITextStoryRangesDisp = dispinterface;
  ITextRange = interface;
  ITextSelection = interface;
  ITextFont = interface;
  ITextPara = interface;
  ITextStoryRanges = interface;
{$WARNINGS ON}

// *********************************************************************//
// Interface: ITextFont
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C3-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextFont = interface(IDispatch)
    ['{8CC497C3-A1DF-11CE-8098-00AA0047BE5D}']

    function  Get_Duplicate: ITextFont; safecall;
    procedure Set_Duplicate(const ppFont: ITextFont); safecall;
    function  CanChange: Integer; safecall;
    function  IsEqual(const pFont: ITextFont): Integer; safecall;
    procedure Reset(Value: Integer); safecall;
    function  Get_Style: Integer; safecall;
    procedure Set_Style(pValue: Integer); safecall;
    function  Get_AllCaps: Integer; safecall;
    procedure Set_AllCaps(pValue: Integer); safecall;
    function  Get_Animation: Integer; safecall;
    procedure Set_Animation(pValue: Integer); safecall;
    function  Get_BackColor: Integer; safecall;
    procedure Set_BackColor(pValue: Integer); safecall;
    function  Get_Bold: Integer; safecall;
    procedure Set_Bold(pValue: Integer); safecall;
    function  Get_Emboss: Integer; safecall;
    procedure Set_Emboss(pValue: Integer); safecall;
    function  Get_ForeColor: Integer; safecall;
    procedure Set_ForeColor(pValue: Integer); safecall;
    function  Get_Hidden: Integer; safecall;
    procedure Set_Hidden(pValue: Integer); safecall;
    function  Get_Engrave: Integer; safecall;
    procedure Set_Engrave(pValue: Integer); safecall;
    function  Get_Italic: Integer; safecall;
    procedure Set_Italic(pValue: Integer); safecall;
    function  Get_Kerning: Single; safecall;
    procedure Set_Kerning(pValue: Single); safecall;
    function  Get_LanguageID: Integer; safecall;
    procedure Set_LanguageID(pValue: Integer); safecall;
    function  Get_Name: WideString; safecall;
    procedure Set_Name(const pbstr: WideString); safecall;
    function  Get_Outline: Integer; safecall;
    procedure Set_Outline(pValue: Integer); safecall;
    function  Get_position: Single; safecall;
    procedure Set_position(pValue: Single); safecall;
    function  Get_Protected_: Integer; safecall;
    procedure Set_Protected_(pValue: Integer); safecall;
    function  Get_Shadow: Integer; safecall;
    procedure Set_Shadow(pValue: Integer); safecall;
    function  Get_SIZE: Single; safecall;
    procedure Set_SIZE(pValue: Single); safecall;
    function  Get_SmallCaps: Integer; safecall;
    procedure Set_SmallCaps(pValue: Integer); safecall;
    function  Get_Spacing: Single; safecall;
    procedure Set_Spacing(pValue: Single); safecall;
    function  Get_StrikeThrough: Integer; safecall;
    procedure Set_StrikeThrough(pValue: Integer); safecall;
    function  Get_Subscript: Integer; safecall;
    procedure Set_Subscript(pValue: Integer); safecall;
    function  Get_Superscript: Integer; safecall;
    procedure Set_Superscript(pValue: Integer); safecall;
    function  Get_Underline: Integer; safecall;
    procedure Set_Underline(pValue: Integer); safecall;
    function  Get_Weight: Integer; safecall;
    procedure Set_Weight(pValue: Integer); safecall;

    property Duplicate: ITextFont read get_Duplicate write set_Duplicate;
    property Style: Integer read get_Style write set_Style;
    property AllCaps: Integer read get_AllCaps write set_AllCaps;
    property Animation: Integer read get_Animation write set_Animation;
    property BackColor: Integer read get_BackColor write set_BackColor;
    property Bold: Integer read get_Bold write set_Bold;
    property Emboss: Integer read get_Emboss write set_Emboss;
    property ForeColor: Integer read get_ForeColor write set_ForeColor;
    property Hidden: Integer read get_Hidden write set_Hidden;
    property Engrave: Integer read get_Engrave write set_Engrave;
    property Italic: Integer read get_Italic write set_Italic;
    property Kerning: Single read get_Kerning write set_Kerning;
    property LanguageID: Integer read get_LanguageID write set_LanguageID;
    property Name: WideString read get_Name write set_Name;
    property Outline: Integer read get_Outline write set_Outline;
    property Position: Single read get_position write set_Position;
    property Protected_: Integer read get_Protected_ write set_Protected_;
    property Shadow: Integer read get_Shadow write set_Shadow;
    property SIZE: Single read get_SIZE write set_SIZE;
    property SmallCaps: Integer read get_SmallCaps write set_SmallCaps;
    property Spacing: Single read get_Spacing write set_Spacing;
    property StrikeThrough: Integer read get_StrikeThrough write set_StrikeThrough;
    property Subscript: Integer read get_Subscript write set_Subscript;
    property Superscript: Integer read get_Superscript write set_Superscript;
    property Underline: Integer read get_Underline write set_Underline;
    property Weight: Integer read get_Weight write set_Weight;
  end;

// *********************************************************************//
// Interface: ITextPara
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C4-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextPara = interface(IDispatch)
    ['{8CC497C4-A1DF-11CE-8098-00AA0047BE5D}']

    function  Get_Duplicate: ITextPara; safecall;
    procedure Set_Duplicate(const ppPara: ITextPara); safecall;
    function  CanChange: Integer; safecall;
    function  IsEqual(const pPara: ITextPara): Integer; safecall;
    procedure Reset(Value: Integer); safecall;
    function  Get_Style: Integer; safecall;
    procedure Set_Style(pValue: Integer); safecall;
    function  Get_Alignment: Integer; safecall;
    procedure Set_Alignment(pValue: Integer); safecall;
    function  Get_Hyphenation: Integer; safecall;
    procedure Set_Hyphenation(pValue: Integer); safecall;
    function  Get_FirstLineIndent: Single; safecall;
    function  Get_KeepTogether: Integer; safecall;
    procedure Set_KeepTogether(pValue: Integer); safecall;
    function  Get_KeepWithNext: Integer; safecall;
    procedure Set_KeepWithNext(pValue: Integer); safecall;
    function  Get_LeftIndent: Single; safecall;
    function  Get_LineSpacing: Single; safecall;
    function  Get_LineSpacingRule: Integer; safecall;
    function  Get_ListAlignment: Integer; safecall;
    procedure Set_ListAlignment(pValue: Integer); safecall;
    function  Get_ListLevelIndex: Integer; safecall;
    procedure Set_ListLevelIndex(pValue: Integer); safecall;
    function  Get_ListStart: Integer; safecall;
    procedure Set_ListStart(pValue: Integer); safecall;
    function  Get_ListTab: Single; safecall;
    procedure Set_ListTab(pValue: Single); safecall;
    function  Get_ListType: Integer; safecall;
    procedure Set_ListType(pValue: Integer); safecall;
    function  Get_NoLineNumber: Integer; safecall;
    procedure Set_NoLineNumber(pValue: Integer); safecall;
    function  Get_PageBreakBefore: Integer; safecall;
    procedure Set_PageBreakBefore(pValue: Integer); safecall;
    function  Get_RightIndent: Single; safecall;
    procedure Set_RightIndent(pValue: Single); safecall;
    procedure SetIndents(StartIndent: Single; LeftIndent: Single; RightIndent: Single); safecall;
    procedure SetLineSpacing(LineSpacingRule: Integer; LineSpacing: Single); safecall;
    function  Get_SpaceAfter: Single; safecall;
    procedure Set_SpaceAfter(pValue: Single); safecall;
    function  Get_SpaceBefore: Single; safecall;
    procedure Set_SpaceBefore(pValue: Single); safecall;
    function  Get_WidowControl: Integer; safecall;
    procedure Set_WidowControl(pValue: Integer); safecall;
    function  Get_TabCount: Integer; safecall;
    procedure AddTab(tbPos: Single; tbAlign: Integer; tbLeader: Integer); safecall;
    procedure ClearAllTabs; safecall;
    procedure DeleteTab(tbPos: Single); safecall;
    procedure GetTab(iTab: Integer; out ptbPos: Single; out ptbAlign: Integer;
                     out ptbLeader: Integer); safecall;

    property Duplicate: ITextPara read get_Duplicate write set_Duplicate;
    property Style: Integer read get_Style write set_Style;
    property Alignment: Integer read get_Alignment write set_Alignment;
    property Hyphenation: Integer read get_Hyphenation write set_Hyphenation;
    property FirstLineIndent: Single read get_FirstLineIndent;
    property KeepTogether: Integer read get_KeepTogether write set_KeepTogether;
    property KeepWithNext: Integer read get_KeepWithNext write set_KeepWithNext;
    property LeftIndent: Single read get_LeftIndent;
    property LineSpacing: Single read get_LineSpacing;
    property LineSpacingRule: Integer read get_LineSpacingRule;
    property ListAlignment: Integer read get_ListAlignment write set_ListAlignment;
    property ListLevelIndex: Integer read get_ListLevelIndex write set_ListLevelIndex;
    property ListStart: Integer read get_ListStart write set_ListStart;
    property ListTab: Single read get_ListTab write set_ListTab;
    property ListType: Integer read get_ListType write set_ListType;
    property NoLineNumber: Integer read get_NoLineNumber write set_NoLineNumber;
    property PageBreakBefore: Integer read get_PageBreakBefore write set_PageBreakBefore;
    property RightIndent: Single read get_RightIndent write set_RightIndent;
    property SpaceAfter: Single read get_SpaceAfter write set_SpaceAfter;
    property SpaceBefore: Single read get_SpaceBefore write set_SpaceBefore;
    property WidowControl: Integer read get_WidowControl write set_WidowControl;
    property TabCount: Integer read get_TabCount;
  end;

// *********************************************************************//
// Interface: ITextRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C2-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextRange = interface(IDispatch)
    ['{8CC497C2-A1DF-11CE-8098-00AA0047BE5D}']

    function  Get_Text: WideString; safecall;
    procedure Set_Text(const pbstr: WideString); safecall;
    function  Get_CHAR: Integer; safecall;
    procedure Set_CHAR(pch: Integer); safecall;
    function  Get_Duplicate: ITextRange; safecall;
    function  Get_FormattedText: ITextRange; safecall;
    procedure Set_FormattedText(const ppRange: ITextRange); safecall;
    function  Get_Start: Integer; safecall;
    procedure Set_Start(pcpFirst: Integer); safecall;
    function  Get_end_: Integer; safecall;
    procedure Set_end_(pcpLim: Integer); safecall;
    function  Get_Font: ITextFont; safecall;
    procedure Set_Font(const pFont: ITextFont); safecall;
    function  Get_Para: ITextPara; safecall;
    procedure Set_Para(const pPara: ITextPara); safecall;
    function  Get_StoryLength: Integer; safecall;
    function  Get_StoryType: Integer; safecall;
    procedure Collapse(bStart: Integer); safecall;
    function  Expand(Unit_: Integer): Integer; safecall;
    function  GetIndex(Unit_: Integer): Integer; safecall;
    procedure SetIndex(Unit_: Integer; index: Integer; Extend: Integer); safecall;
    procedure SetRange(cpActive: Integer; cpOther: Integer); safecall;
    function  InRange(const pRange: ITextRange): Integer; safecall;
    function  InStory(const pRange: ITextRange): Integer; safecall;
    function  IsEqual(const pRange: ITextRange): Integer; safecall;
    procedure Select; safecall;
    function  StartOf(Unit_: Integer; Extend: Integer): Integer; safecall;
    function  EndOf(Unit_: Integer; Extend: Integer): Integer; safecall;
//    function  Move(Unit_: Integer; Count: Integer; pDelta: Pointer = nil): Integer; safecall;
    function  Move(Unit_: Integer; Count: Integer): Integer; safecall;
    function  MoveStart(Unit_: Integer; Count: Integer): Integer; safecall;
    function  MoveEnd(Unit_: Integer; Count: Integer): Integer; safecall;
    function  MoveWhile(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function  MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function  MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function  MoveUntil(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function  MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function  MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function  FindText(const bstr: WideString; cch: Integer; flags: Integer): Integer; safecall;
    function  FindTextStart(const bstr: WideString; cch: Integer; flags: Integer): Integer; safecall;
    function  FindTextEnd(const bstr: WideString; cch: Integer; flags: Integer): Integer; safecall;
    function  Delete(Unit_: Integer; Count: Integer): Integer; safecall;
    procedure Cut(out pVar: OleVariant); safecall;
    procedure Copy(out pVar: OleVariant); safecall;
    procedure Paste(var pVar: OleVariant; Format: Integer); safecall;
    function  CanPaste(var pVar: OleVariant; Format: Integer): Integer; safecall;
    function  CanEdit: Integer; safecall;
    procedure ChangeCase(type_: Integer); safecall;
    procedure GetPoint(type_: Integer; out px: Integer; out py: Integer); safecall;
    procedure SetPoint(x: Integer; y: Integer; type_: Integer; Extend: Integer); safecall;
    procedure ScrollIntoView(Value: Integer); safecall;
    function GetEmbeddedObject: IUnknown; safecall;

    property Text: WideString read get_Text write set_Text;
    property CHAR: Integer read get_CHAR write set_CHAR;
    property Duplicate: ITextRange read get_Duplicate;
    property FormattedText: ITextRange read get_FormattedText write set_FormattedText;
    property Start: Integer read get_Start write set_Start;
    property end_: Integer read get_end_ write set_end_;
    property Font: ITextFont read get_Font write set_Font;
    property Para: ITextPara read get_Para write set_Para;
    property StoryLength: Integer read get_StoryLength;
    property StoryType: Integer read get_StoryType;
  end;

// *********************************************************************//
// Interface: ITextSelection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C1-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextSelection = interface(ITextRange)
    ['{8CC497C1-A1DF-11CE-8098-00AA0047BE5D}']

    function  Get_flags: Integer; safecall;
    procedure Set_flags(pFlags: Integer); safecall;
    function  Get_type_: Integer; safecall;
    function  MoveLeft(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function  MoveRight(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function  MoveUp(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function  MoveDown(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function  HomeKey(Unit_: Integer; Extend: Integer): Integer; safecall;
    function  EndKey(Unit_: Integer; Extend: Integer): Integer; safecall;
    procedure TypeText(const bstr: WideString); safecall;

    property flags: Integer read get_flags write set_flags;
    property type_: Integer read get_type_;
  end;

// *********************************************************************//
// Interface: ITextStoryRanges
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C5-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextStoryRanges = interface(IDispatch)
    ['{8CC497C5-A1DF-11CE-8098-00AA0047BE5D}']

    function _NewEnum: OleVariant; safecall;
    function Item(index: Integer): ITextRange; safecall;
    function Get_Count: Integer; safecall;

    property Count: Integer read get_Count;
  end;

// *********************************************************************//
// Interface: ITextDocument
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C0-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextDocument = interface(IDispatch)
    ['{8CC497C0-A1DF-11CE-8098-00AA0047BE5D}']

    function  Get_Name: WideString; safecall;
    function  Get_Selection: ITextSelection; safecall;
    function  Get_StoryCount: Integer; safecall;
    function  Get_StoryRanges: ITextStoryRanges; safecall;
    function  Get_Saved: Integer; safecall;
    procedure Set_Saved(pValue: Integer); safecall;
    function  Get_DefaultTabStop: Single; safecall;
    procedure Set_DefaultTabStop(pValue: Single); safecall;
    procedure New; safecall;
    procedure Open(var pVar: OleVariant; flags: tomOpenFlags; CodePage: Integer); safecall;
    procedure Save(var pVar: OleVariant; flags: tomOpenFlags; CodePage: Integer); safecall;
    function  Freeze: Integer; safecall;
    function  Unfreeze: Integer; safecall;
    procedure BeginEditCollection; safecall;
    procedure EndEditCollection; safecall;
    function  Undo(Count: Integer): Integer; safecall;
    function  Redo(Count: Integer): Integer; safecall;
    function  Range(cp1: Integer; cp2: Integer): ITextRange; safecall;
    function  RangeFromPoint(x: Integer; y: Integer): ITextRange; safecall;

    property Name: WideString read Get_Name;
    property Selection: ITextSelection read get_Selection;
    property StoryCount: Integer read get_StoryCount;
    property StoryRanges: ITextStoryRanges read get_StoryRanges;
    property Saved: Integer read get_Saved write set_Saved;
    property DefaultTabStop: Single read get_DefaultTabStop write set_DefaultTabStop;
  end;

// *********************************************************************//
// DispIntf:  ITextDocumentDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C0-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextDocumentDisp = dispinterface
    ['{8CC497C0-A1DF-11CE-8098-00AA0047BE5D}']

  property Name: WideString readonly dispid 0;
    property Selection: ITextSelection readonly dispid 1;
    property StoryCount: Integer readonly dispid 2;
    property StoryRanges: ITextStoryRanges readonly dispid 3;
    property Saved: Integer dispid 4;
    property DefaultTabStop: Single dispid 5;
    procedure New; dispid 6;
    procedure Open(var pVar: OleVariant; flags: tomOpenFlags; CodePage: Integer); dispid 7;
    procedure Save(var pVar: OleVariant; flags: tomOpenFlags; CodePage: Integer); dispid 8;
    function  Freeze: Integer; dispid 9;
    function  Unfreeze: Integer; dispid 10;
    procedure BeginEditCollection; dispid 11;
    procedure EndEditCollection; dispid 12;
    function  Undo(Count: Integer): Integer; dispid 13;
    function  Redo(Count: Integer): Integer; dispid 14;
    function  Range(cp1: Integer; cp2: Integer): ITextRange; dispid 15;
    function  RangeFromPoint(x: Integer; y: Integer): ITextRange; dispid 16;
  end;

// *********************************************************************//
// DispIntf:  ITextRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C2-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextRangeDisp = dispinterface
    ['{8CC497C2-A1DF-11CE-8098-00AA0047BE5D}']

  property Text: WideString dispid 0;
    property CHAR: Integer dispid 513;
    property Duplicate: ITextRange readonly dispid 514;
    property FormattedText: ITextRange dispid 515;
    property Start: Integer dispid 516;
    property end_: Integer dispid 517;
    property Font: ITextFont dispid 518;
    property Para: ITextPara dispid 519;
    property StoryLength: Integer readonly dispid 520;
    property StoryType: Integer readonly dispid 521;
    procedure Collapse(bStart: Integer); dispid 528;
    function  Expand(Unit_: Integer): Integer; dispid 529;
    function  GetIndex(Unit_: Integer): Integer; dispid 530;
    procedure SetIndex(Unit_: Integer; index: Integer; Extend: Integer); dispid 531;
    procedure SetRange(cpActive: Integer; cpOther: Integer); dispid 532;
    function  InRange(const pRange: ITextRange): Integer; dispid 533;
    function  InStory(const pRange: ITextRange): Integer; dispid 534;
    function  IsEqual(const pRange: ITextRange): Integer; dispid 535;
    procedure Select; dispid 536;
    function  StartOf(Unit_: Integer; Extend: Integer): Integer; dispid 537;
    function  EndOf(Unit_: Integer; Extend: Integer): Integer; dispid 544;
    function  Move(Unit_: Integer; Count: Integer): Integer; dispid 545;
    function  MoveStart(Unit_: Integer; Count: Integer): Integer; dispid 546;
    function  MoveEnd(Unit_: Integer; Count: Integer): Integer; dispid 547;
    function  MoveWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 548;
    function  MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 549;
    function  MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 550;
    function  MoveUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 551;
    function  MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 552;
    function  MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 553;
    function  FindText(const bstr: WideString; cch: Integer; flags: Integer): Integer; dispid 560;
    function  FindTextStart(const bstr: WideString; cch: Integer; flags: Integer): Integer; dispid 561;
    function  FindTextEnd(const bstr: WideString; cch: Integer; flags: Integer): Integer; dispid 562;
    function  Delete(Unit_: Integer; Count: Integer): Integer; dispid 563;
    procedure Cut(out pVar: OleVariant); dispid 564;
    procedure Copy(out pVar: OleVariant); dispid 565;
    procedure Paste(var pVar: OleVariant; Format: Integer); dispid 566;
    function  CanPaste(var pVar: OleVariant; Format: Integer): Integer; dispid 567;
    function  CanEdit: Integer; dispid 568;
    procedure ChangeCase(type_: Integer); dispid 569;
    procedure GetPoint(type_: Integer; out px: Integer; out py: Integer); dispid 576;
    procedure SetPoint(x: Integer; y: Integer; type_: Integer; Extend: Integer); dispid 577;
    procedure ScrollIntoView(Value: Integer); dispid 578;
    function  GetEmbeddedObject: IUnknown; dispid 579;
  end;

// *********************************************************************//
// DispIntf:  ITextSelectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C1-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextSelectionDisp = dispinterface
    ['{8CC497C1-A1DF-11CE-8098-00AA0047BE5D}']

  property flags: Integer dispid 257;
    property type_: Integer readonly dispid 258;
    function  MoveLeft(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 259;
    function  MoveRight(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 260;
    function  MoveUp(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 261;
    function  MoveDown(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 262;
    function  HomeKey(Unit_: Integer; Extend: Integer): Integer; dispid 263;
    function  EndKey(Unit_: Integer; Extend: Integer): Integer; dispid 264;
    procedure TypeText(const bstr: WideString); dispid 265;
    property Text: WideString dispid 0;
    property CHAR: Integer dispid 513;
    property Duplicate: ITextRange readonly dispid 514;
    property FormattedText: ITextRange dispid 515;
    property Start: Integer dispid 516;
    property end_: Integer dispid 517;
    property Font: ITextFont dispid 518;
    property Para: ITextPara dispid 519;
    property StoryLength: Integer readonly dispid 520;
    property StoryType: Integer readonly dispid 521;
    procedure Collapse(bStart: Integer); dispid 528;
    function  Expand(Unit_: Integer): Integer; dispid 529;
    function  GetIndex(Unit_: Integer): Integer; dispid 530;
    procedure SetIndex(Unit_: Integer; index: Integer; Extend: Integer); dispid 531;
    procedure SetRange(cpActive: Integer; cpOther: Integer); dispid 532;
    function  InRange(const pRange: ITextRange): Integer; dispid 533;
    function  InStory(const pRange: ITextRange): Integer; dispid 534;
    function  IsEqual(const pRange: ITextRange): Integer; dispid 535;
    procedure Select; dispid 536;
    function  StartOf(Unit_: Integer; Extend: Integer): Integer; dispid 537;
    function  EndOf(Unit_: Integer; Extend: Integer): Integer; dispid 544;
    function  Move(Unit_: Integer; Count: Integer): Integer; dispid 545;
    function  MoveStart(Unit_: Integer; Count: Integer): Integer; dispid 546;
    function  MoveEnd(Unit_: Integer; Count: Integer): Integer; dispid 547;
    function  MoveWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 548;
    function  MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 549;
    function  MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 550;
    function  MoveUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 551;
    function  MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 552;
    function  MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 553;
    function  FindText(const bstr: WideString; cch: Integer; flags: Integer): Integer; dispid 560;
    function  FindTextStart(const bstr: WideString; cch: Integer; flags: Integer): Integer; dispid 561;
    function  FindTextEnd(const bstr: WideString; cch: Integer; flags: Integer): Integer; dispid 562;
    function  Delete(Unit_: Integer; Count: Integer): Integer; dispid 563;
    procedure Cut(out pVar: OleVariant); dispid 564;
    procedure Copy(out pVar: OleVariant); dispid 565;
    procedure Paste(var pVar: OleVariant; Format: Integer); dispid 566;
    function  CanPaste(var pVar: OleVariant; Format: Integer): Integer; dispid 567;
    function  CanEdit: Integer; dispid 568;
    procedure ChangeCase(type_: Integer); dispid 569;
    procedure GetPoint(type_: Integer; out px: Integer; out py: Integer); dispid 576;
    procedure SetPoint(x: Integer; y: Integer; type_: Integer; Extend: Integer); dispid 577;
    procedure ScrollIntoView(Value: Integer); dispid 578;
    function  GetEmbeddedObject: IUnknown; dispid 579;
  end;

// *********************************************************************//
// DispIntf:  ITextFontDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C3-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextFontDisp = dispinterface
    ['{8CC497C3-A1DF-11CE-8098-00AA0047BE5D}']
    property Duplicate: ITextFont dispid 0;
    function  CanChange: Integer; dispid 769;
    function  IsEqual(const pFont: ITextFont): Integer; dispid 770;
    procedure Reset(Value: Integer); dispid 771;
    property Style: Integer dispid 772;
    property AllCaps: Integer dispid 773;
    property Animation: Integer dispid 774;
    property BackColor: Integer dispid 775;
    property Bold: Integer dispid 776;
    property Emboss: Integer dispid 777;
    property ForeColor: Integer dispid 784;
    property Hidden: Integer dispid 785;
    property Engrave: Integer dispid 786;
    property Italic: Integer dispid 787;
    property Kerning: Single dispid 788;
    property LanguageID: Integer dispid 789;
    property Name: WideString dispid 790;
    property Outline: Integer dispid 791;
    property position: Single dispid 792;
    property Protected_: Integer dispid 793;
    property Shadow: Integer dispid 800;
    property SIZE: Single dispid 801;
    property SmallCaps: Integer dispid 802;
    property Spacing: Single dispid 803;
    property StrikeThrough: Integer dispid 804;
    property Subscript: Integer dispid 805;
    property Superscript: Integer dispid 806;
    property Underline: Integer dispid 807;
    property Weight: Integer dispid 808;
  end;

// *********************************************************************//
// DispIntf:  ITextParaDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C4-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextParaDisp = dispinterface
    ['{8CC497C4-A1DF-11CE-8098-00AA0047BE5D}']
    property Duplicate: ITextPara dispid 0;
    function  CanChange: Integer; dispid 1025;
    function  IsEqual(const pPara: ITextPara): Integer; dispid 1026;
    procedure Reset(Value: Integer); dispid 1027;
    property Style: Integer dispid 1028;
    property Alignment: Integer dispid 1029;
    property Hyphenation: Integer dispid 1030;
    property FirstLineIndent: Single readonly dispid 1031;
    property KeepTogether: Integer dispid 1032;
    property KeepWithNext: Integer dispid 1033;
    property LeftIndent: Single readonly dispid 1040;
    property LineSpacing: Single readonly dispid 1041;
    property LineSpacingRule: Integer readonly dispid 1042;
    property ListAlignment: Integer dispid 1043;
    property ListLevelIndex: Integer dispid 1044;
    property ListStart: Integer dispid 1045;
    property ListTab: Single dispid 1046;
    property ListType: Integer dispid 1047;
    property NoLineNumber: Integer dispid 1048;
    property PageBreakBefore: Integer dispid 1049;
    property RightIndent: Single dispid 1056;
    procedure SetIndents(StartIndent: Single; LeftIndent: Single; RightIndent: Single); dispid 1057;
    procedure SetLineSpacing(LineSpacingRule: Integer; LineSpacing: Single); dispid 1058;
    property SpaceAfter: Single dispid 1059;
    property SpaceBefore: Single dispid 1060;
    property WidowControl: Integer dispid 1061;
    property TabCount: Integer readonly dispid 1062;
    procedure AddTab(tbPos: Single; tbAlign: Integer; tbLeader: Integer); dispid 1063;
    procedure ClearAllTabs; dispid 1064;
    procedure DeleteTab(tbPos: Single); dispid 1065;
    procedure GetTab(iTab: Integer; out ptbPos: Single; out ptbAlign: Integer;
                     out ptbLeader: Integer); dispid 1072;
  end;

// *********************************************************************//
// DispIntf:  ITextStoryRangesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C5-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//

  ITextStoryRangesDisp = dispinterface
    ['{8CC497C5-A1DF-11CE-8098-00AA0047BE5D}']
    function  _NewEnum: OleVariant; dispid -4;
    function  Item(index: Integer): ITextRange; dispid 0;
    property Count: Integer readonly dispid 2;
  end;

{ ************************** IRichEditOle  ************************** }
{
 *  Purpose:
 *    Interface used by the client of RichEdit to perform OLE-related
 *    operations.
 *
 *    The methods herein may just want to be regular Windows messages.
}

  IRichEditOle = interface(IUnknown)
    ['{00020d00-0000-0000-c000-000000000046}']

    function GetClientSite(out clientSite: IOleClientSite): HResult; stdcall;
    function GetObjectCount: HResult; stdcall;
    function GetLinkCount: HResult; stdcall;
    function GetObject(iob: Longint; out reobject: TReObject;
      dwFlags: DWORD): HResult; stdcall;
    function InsertObject(var reobject: TReObject): HResult; stdcall;

    function ConvertObject(iob: Longint; rclsidNew: TIID;
      lpstrUserTypeNew: LPCSTR): HResult; stdcall;
    function ActivateAs(rclsid: TIID; rclsidAs: TIID): HResult; stdcall;
    function SetHostNames(lpstrContainerApp: LPCSTR;
      lpstrContainerObj: LPCSTR): HResult; stdcall;

    function SetLinkAvailable(iob: Longint; fAvailable: BOOL): HResult; stdcall;
    function SetDvaspect(iob: Longint; dvaspect: DWORD): HResult; stdcall;
    function HandsOffStorage(iob: Longint): HResult; stdcall;

    function SaveCompleted(iob: Longint; const stg: IStorage): HResult; stdcall;
    function InPlaceDeactivate: HResult; stdcall;
    function ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall;
    function GetClipboardData(var chrg: TCharRange; reco: DWORD;
      out dataobj: IDataObject): HResult; stdcall;
    function ImportDataObject(dataobj: IDataObject; cf: TClipFormat;
      hMetaPict: HGLOBAL): HResult; stdcall;

  end;

{ ************************** IRichEditOleCallback ************************* }
{
 *  IRichEditOleCallback
 *
 *  Purpose:
 *    Interface used by the RichEdit to get OLE-related stuff from the
 *    application using RichEdit.
}

  IRichEditOleCallback = interface(IUnknown)
    ['{00020d03-0000-0000-c000-000000000046}']

  function GetNewStorage(out stg: IStorage): HResult; stdcall;
    function GetInPlaceContext(out Frame: IOleInPlaceFrame; out Doc: IOleInPlaceUIWindow;
      lpFrameInfo: POleInPlaceFrameInfo): HResult; stdcall;
    function ShowContainerUI(fShow: BOOL): HResult; stdcall;
    function QueryInsertObject(const clsid: TCLSID; const stg: IStorage;
      cp: Longint): HResult; stdcall;
    function DeleteObject(const oleobj: IOleObject): HResult; stdcall;
    function QueryAcceptData(const dataobj: IDataObject;
      var cfFormat: TClipFormat; reco: DWORD; fReally: BOOL;
      hMetaPict: HGLOBAL): HResult; stdcall;
    function ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall;
    function GetClipboardData(const chrg: TCharRange; reco: DWORD;
      out dataobj: IDataObject): HResult; stdcall;
    function GetDragDropEffect(fDrag: BOOL; grfKeyState: DWORD;
      var dwEffect: DWORD): HResult; stdcall;
    function GetContextMenu(seltype: Word; const oleobj: IOleObject;
      const chrg: TCharRange; out menu: HMENU): HResult; stdcall;
  end;

{ ************************** TLMDRichEditOleCallback  ************************** }
  TLMDRichEditOleCallback = class(TInterfacedObject, IRichEditOleCallback)
  private
    FDocForm   : IVCLFrameForm;
    FFrameForm : IVCLFrameForm;
    FAccelTable: HAccel;
    FAccelCount: Integer;
    FAutoScroll: Boolean;
    procedure CreateAccelTable;
    procedure DestroyAccelTable;
    procedure AssignFrame;
  private
//    FRefCount: Longint;
    FRichEdit: TLMDCustomRichEdit;
  public
    constructor Create(RichEdit: TLMDCustomRichEdit);
    destructor Destroy; override;
//    function QueryInterface(const iid: TGUID; out Obj): HResult; stdcall;
//    function _AddRef: Longint; stdcall;
//    function _Release: Longint; stdcall;
  function GetNewStorage(out stg: IStorage): HResult; stdcall;
    function GetInPlaceContext(out Frame: IOleInPlaceFrame;
      out Doc: IOleInPlaceUIWindow;
      lpFrameInfo: POleInPlaceFrameInfo): HResult; stdcall;
    function ShowContainerUI(fShow: BOOL): HResult; stdcall;
    function QueryInsertObject(const clsid: TCLSID; const stg: IStorage;
      cp: Longint): HResult; stdcall;
    function DeleteObject(const oleobj: IOleObject): HResult; stdcall;
    function QueryAcceptData(const dataobj: IDataObject; var cfFormat:
      TClipFormat;
      reco: DWORD; fReally: BOOL; hMetaPict: HGLOBAL): HResult; stdcall;
    function ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall;
    function GetDragDropEffect(fDrag: BOOL; grfKeyState: DWORD;
      var dwEffect: DWORD): HResult; stdcall;
    function GetClipboardData(const chrg: TCharRange; reco: DWORD;
      out dataobj: IDataObject): HResult; stdcall;
    function GetContextMenu(seltype: Word; const oleobj: IOleObject;
      const chrg: TCharRange; out menu: HMENU): HResult; stdcall;
  property DocForm: IVCLFrameForm read FDocForm;
    property FrameForm: IVCLFrameForm read FFrameForm;
  end;

{ ************************** TOleUIObjInfo  ************************** }
{ TOleUIObjInfo - helper interface for Object Properties dialog }

  TOleUIObjInfo = class(TInterfacedObject, IOleUIObjInfo)
  private
    FRichEdit: TLMDCustomRichEdit;
    FReObject: TReObject;
  public
    constructor Create(RichEdit: TLMDCustomRichEdit; ReObject: TReObject);
    function GetObjectInfo(dwObject: Longint;
      var dwObjSize: Longint; var lpszLabel: PChar;
      var lpszType: PChar; var lpszShortType: PChar;
      var lpszLocation: PChar): HResult; stdcall;
    function GetConvertInfo(dwObject: Longint; var ClassID: TCLSID;
      var wFormat: Word; var ConvertDefaultClassID: TCLSID;
      var lpClsidExclude: PCLSID; var cClsidExclude: Longint): HResult; stdcall;
    function ConvertObject(dwObject: Longint;
      const clsidNew: TCLSID): HResult; stdcall;
    function GetViewInfo(dwObject: Longint; var hMetaPict: HGlobal;
      var dvAspect: Longint; var nCurrentScale: Integer): HResult; stdcall;
    function SetViewInfo(dwObject: Longint; hMetaPict: HGlobal;
      dvAspect: Longint; nCurrentScale: Integer;
      bRelativeToOrig: BOOL): HResult; stdcall;
  end;

{ ************************** TOleUILinkInfo  ************************** }
{ TOleUILinkInfo - helper interface for Object Properties dialog }

  IOleUILinkInfo = interface(IOleUILinkContainer)
  ['{00000000-0000-0000-0000-000000000000}']  //!!!
    function GetLastUpdate(dwLink: Longint; var LastUpdate: TFileTime): HResult; stdcall;
  end;

  TOleUILinkInfo = class(TInterfacedObject, IOleUILinkInfo)
  private
    FReObject: TReObject;
    FRichEdit: TLMDCustomRichEdit;
    FOleLink: IOleLink;
  public
    constructor Create(RichEdit: TLMDCustomRichEdit; ReObject: TReObject);
    function GetNextLink(dwLink: Longint): Longint; stdcall;
    function SetLinkUpdateOptions(dwLink: Longint;
      dwUpdateOpt: Longint): HResult; stdcall;
    function GetLinkUpdateOptions(dwLink: Longint;
      var dwUpdateOpt: Longint): HResult; stdcall;
    function SetLinkSource(dwLink: Longint; pszDisplayName: PChar;
      lenFileName: Longint; var chEaten: Longint;
      fValidateSource: BOOL): HResult; stdcall;
    function GetLinkSource(dwLink: Longint; var pszDisplayName: PChar;
      var lenFileName: Longint; var pszFullLinkType: PChar;
      var pszShortLinkType: PChar; var fSourceAvailable: BOOL;
      var fIsSelected: BOOL): HResult; stdcall;
    function OpenLinkSource(dwLink: Longint): HResult; stdcall;
    function UpdateLink(dwLink: Longint; fErrorMessage: BOOL;
      fErrorAction: BOOL): HResult; stdcall;
    function CancelLink(dwLink: Longint): HResult; stdcall;
    function GetLastUpdate(dwLink: Longint;
      var LastUpdate: TFileTime): HResult; stdcall;
  end;

function IsFormMDIChild(Form: TCustomForm): Boolean;

procedure CreateStorage(var Storage: IStorage);

function OleSetDrawAspect(OleObject: IOleObject; Iconic: Boolean;
  IconMetaPict: HGlobal; var DrawAspect: Longint): HResult;

function GetFullNameStr(OleObject: IOleObject): string;

implementation
uses
  ComObj, OleConst,
  Menus, SysUtils;

{ ------------------------------------------------------------------------- }

function GetVCLFrameForm(Form: TCustomForm): IVCLFrameForm;
begin
  if Form.OleFormObject = nil then TOleForm.Create(Form);
  Result:= Form.OleFormObject as IVCLFrameForm;
end;

{ ------------------------------------------------------------------------- }

function IsFormMDIChild(Form: TCustomForm): Boolean;
begin
  Result:= (Form is TForm) and (TForm(Form).FormStyle = fsMDIChild);
end;

{ ------------------------------------------------------------------------- }

function CoAllocCStr(const S: string): PChar;
begin
  Result:= StrCopy(CoTaskMemAlloc(Length(S) + 1), PChar(S));
end;

{ ------------------------------------------------------------------------- }

function WStrToString(P: PWideChar): string;
begin
  Result:= '';
  if P <> nil then
    begin
      Result:= WideCharToString(P);
      CoTaskMemFree(P);
    end;
end;

{ ------------------------------------------------------------------------- }

function GetFullNameStr(OleObject: IOleObject): string;
var
  P: PWideChar;
begin
  OleObject.GetUserType(USERCLASSTYPE_FULL, P);
  Result:= WStrToString(P);
end;

{ ------------------------------------------------------------------------- }

function GetShortNameStr(OleObject: IOleObject): string;
var
  P: PWideChar;
begin
  OleObject.GetUserType(USERCLASSTYPE_SHORT, P);
  Result:= WStrToString(P);
end;

{ ------------------------------------------------------------------------- }

function GetDisplayNameStr(OleLink: IOleLink): string;
var
  P: PWideChar;
begin
  OleLink.GetSourceDisplayName(P);
  Result:= WStrToString(P);
end;

{ ------------------------------------------------------------------------- }

function WStrLen(Str: PWideChar): Integer;
begin
  Result:= 0;
  while Str[Result] <> #0 do
    Inc(Result);
end;

{ ------------------------------------------------------------------------- }

function GetIconMetaPict(OleObject: IOleObject; DrawAspect: Longint): HGlobal;
var
  DataObject: IDataObject;
  FormatEtc: TFormatEtc;
  Medium: TStgMedium;
  ClassID: TCLSID;
begin
  Result:= 0;
  if DrawAspect = DVASPECT_ICON then
    begin
    OleObject.QueryInterface(IDataObject, DataObject);
      if DataObject <> nil then
        begin
    FormatEtc.cfFormat:= CF_METAFILEPICT;
          FormatEtc.ptd:= nil;
          FormatEtc.dwAspect:= DVASPECT_ICON;
          FormatEtc.lIndex:= -1;
          FormatEtc.tymed:= TYMED_MFPICT;
          if Succeeded(DataObject.GetData(FormatEtc, Medium)) then
            Result:= Medium.hMetaFilePict;
          DataObject:= nil;
        end;
    end;
  if Result = 0 then
    begin
      OleCheck(OleObject.GetUserClassID(ClassID));
      Result := OleGetIconOfClass(ClassID, nil, True);
    end;
end;

{ ------------------------------------------------------------------------- }

function OleSetDrawAspect(OleObject: IOleObject; Iconic: Boolean;
  IconMetaPict: HGlobal; var DrawAspect: Longint): HResult;
var
  OleCache: IOleCache;
  EnumStatData: IEnumStatData;
  OldAspect, AdviseFlags, Connection: Longint;
  TempMetaPict: HGlobal;
  FormatEtc: TFormatEtc;
  Medium: TStgMedium;
  ClassID: TCLSID;

  StatData: TStatData;

begin
  Result:= S_OK;
  OldAspect:= DrawAspect;
  if Iconic then
    begin
      DrawAspect:= DVASPECT_ICON;
      AdviseFlags:= ADVF_NODATA;
    end
  else
    begin
      DrawAspect:= DVASPECT_CONTENT;
      AdviseFlags:= ADVF_PRIMEFIRST;
    end;
  if (DrawAspect <> OldAspect) or (DrawAspect = DVASPECT_ICON) then
    begin
    Result := OleObject.QueryInterface(IOleCache, OleCache);
    if Succeeded(Result) then
      try
        if DrawAspect <> OldAspect then
          begin
        { Setup new cache with the new aspect }
          FillChar(FormatEtc, SizeOf(FormatEtc), 0);
          FormatEtc.dwAspect:= DrawAspect;
            FormatEtc.lIndex:= -1;
            Result := OleCache.Cache(FormatEtc, AdviseFlags, Connection);
          end;

        if Succeeded(Result) and (DrawAspect = DVASPECT_ICON) then
          begin
            TempMetaPict:= 0;
            if IconMetaPict = 0 then
              begin
                if Succeeded(OleObject.GetUserClassID(ClassID)) then
                  begin
                    TempMetaPict:= OleGetIconOfClass(ClassID, nil, True);
                    IconMetaPict:= TempMetaPict;
                  end;
              end;
            try
              FormatEtc.cfFormat:= CF_METAFILEPICT;
              FormatEtc.ptd:= nil;
              FormatEtc.dwAspect:= DVASPECT_ICON;
              FormatEtc.lIndex:= -1;
              FormatEtc.tymed:= TYMED_MFPICT;
              Medium.tymed:= TYMED_MFPICT;
              Medium.hMetaFilePict:= IconMetaPict;
              Medium.unkForRelease:= nil;
              Result:= OleCache.SetData(FormatEtc, Medium, False);
            finally
              DestroyMetaPict(TempMetaPict);
            end;
          end;
        if Succeeded(Result) and (DrawAspect <> OldAspect) then
          begin
        { remove any existing caches that are set up for the old display aspect }
            OleCache.EnumCache(EnumStatData);
            if EnumStatData <> nil then
            try
            while EnumStatData.Next(1, StatData, nil) = 0 do
                if StatData.formatetc.dwAspect = OldAspect then
                  OleCache.Uncache(StatData.dwConnection);
            finally
              EnumStatData:= nil;
            end;
          end;
      finally
        OleCache:= nil;
      end;
      if Succeeded(Result) and (DrawAspect <> DVASPECT_ICON) then
        OleObject.Update;
    end;
end;

{ ------------------------------------------------------------------------- }
function OleStdGetFirstMoniker(Moniker: IMoniker): IMoniker;
var
  Mksys: Longint;
  EnumMoniker: 
               IEnumMoniker;
               begin
  Result := nil;
  if Moniker <> nil then
    begin
    if (Moniker.IsSystemMoniker(Mksys) = 0) and
    (Mksys = MKSYS_GENERICCOMPOSITE) then
        begin
        if Moniker.Enum(True, EnumMoniker) <> 0 then Exit;
            EnumMoniker.Next(1, Result, nil);
        EnumMoniker:= nil;
        end
      else
        begin
          Result:= Moniker;
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

function OleStdGetLenFilePrefixOfMoniker(Moniker: IMoniker): Integer;
var
  MkFirst: IMoniker;

  BindCtx: IBindCtx;

  Mksys: Integer;
  P: PWideChar;
begin
  Result:= 0;
  if Moniker <> nil then
    begin
      MkFirst:= OleStdGetFirstMoniker(Moniker);
      if MkFirst <> nil then
        begin
        if (MkFirst.IsSystemMoniker(Mksys) = 0) and
            (Mksys = MKSYS_FILEMONIKER) then
            begin
        if CreateBindCtx(0, BindCtx) = 0 then
                begin
                if (MkFirst.GetDisplayName(BindCtx, nil, P) = 0) and (P <> nil)
                then
                    begin
                    Result := WStrLen(P);
                      CoTaskMemFree(P);
                    end;
                  BindCtx:= nil;
                end;
            end;
          MkFirst:= nil;
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure CreateStorage(var Storage: IStorage);
var
  LockBytes: ILockBytes;
begin
  CreateILockBytesOnHGlobal(0, True, LockBytes);
  try
    OleCheck(StgCreateDocfileOnILockBytes(LockBytes, STGM_READWRITE
      or STGM_SHARE_EXCLUSIVE or STGM_CREATE, 0, Storage));
  finally
    LockBytes:= nil;
  end;
end;

{ *********************** TLMDRichEditOleCallback  ************************ }
{ ------------------------------------------------------------------------- }
constructor TLMDRichEditOleCallback.Create(RichEdit: TLMDCustomRichEdit);
begin
  inherited Create;
  FRichEdit:= RichEdit;
end;

{ ------------------------------------------------------------------------- }

destructor TLMDRichEditOleCallback.Destroy;
begin
  DestroyAccelTable;
  FFrameForm:= nil;
  FDocForm:= nil;
  inherited Destroy;
end;

{ ------------------------------------------------------------------------- }

{function TLMDRichEditOleCallback.QueryInterface(const iid: TGUID; out Obj):
HResult;
begin
  if GetInterface(iid, Obj) then
    Result:= S_OK
  else
    Result:= E_NOINTERFACE;
end;}

{ ------------------------------------------------------------------------- }

{function TLMDRichEditOleCallback._AddRef: Longint;
begin
  Inc(FRefCount);
  Result:= FRefCount;
end;}

{ ------------------------------------------------------------------------- }

{function TLMDRichEditOleCallback._Release: Longint;
begin
  Dec(FRefCount);
  Result:= FRefCount;
end;}

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditOleCallback.CreateAccelTable;
var
  Menu: TMainMenu;
begin
  if (FAccelTable = 0) and Assigned(FFrameForm) then
    begin
      Menu:= FFrameForm.Form.Menu;
      if Menu <> nil then
        Menu.GetOle2AcceleratorTable(FAccelTable, FAccelCount, [0, 2, 4]);
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditOleCallback.DestroyAccelTable;
begin
  if FAccelTable <> 0 then
    begin
      DestroyAcceleratorTable(FAccelTable);
      FAccelTable:= 0;
      FAccelCount:= 0;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichEditOleCallback.AssignFrame;
begin
  if (GetParentForm(FRichEdit) <> nil) and not Assigned(FFrameForm) and
    FRichEdit.AllowInPlace then
    begin
    // ToDo
      FDocForm:= GetVCLFrameForm(ValidParentForm(FRichEdit));
      FFrameForm:= FDocForm;
      if IsFormMDIChild(FDocForm.Form) then
        FFrameForm:= GetVCLFrameForm(Application.MainForm);
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditOleCallback.GetNewStorage(out stg: IStorage): HResult;
begin
  try
    CreateStorage(stg);
    Result:= S_OK;
  except
    Result:= E_OUTOFMEMORY;
  end;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditOleCallback.GetInPlaceContext(
  out Frame: IOleInPlaceFrame; out Doc: IOleInPlaceUIWindow;
  lpFrameInfo: POleInPlaceFrameInfo): HResult;

begin
  AssignFrame;
  if Assigned(FFrameForm) and FRichEdit.AllowInPlace then
    begin
      Frame:= FFrameForm;
      Doc:= FDocForm;
      CreateAccelTable;
    with lpFrameInfo^ do
    begin
          fMDIApp:= False;
          FFrameForm.GetWindow(hWndFrame);
          hAccel:= FAccelTable;
          cAccelEntries:= FAccelCount;
        end;
    Result:= S_OK;
    end
  else
    Result:= E_NOTIMPL;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditOleCallback.QueryInsertObject(const clsid: TCLSID; const
  stg: IStorage; cp: Longint): HResult;
begin
  Result:= NOERROR
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditOleCallback.DeleteObject(const oleobj: IOleObject):
HResult;
begin
  if Assigned(oleobj) then oleobj.Close(OLECLOSE_NOSAVE);
  Result:= NOERROR;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditOleCallback.QueryAcceptData(const dataobj: IDataObject;
  var cfFormat: TClipFormat; reco: DWORD; fReally: BOOL;
  hMetaPict: HGLOBAL): HResult;
begin
  Result:= S_OK;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditOleCallback.ContextSensitiveHelp(fEnterMode: BOOL):
HResult;
begin
  Result:= NOERROR;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditOleCallback.GetClipboardData(const chrg: TCharRange; reco:
  DWORD;
  out dataobj: IDataObject): HResult;
begin
  Result:= E_NOTIMPL;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditOleCallback.GetDragDropEffect(fDrag: BOOL; grfKeyState:
  DWORD;
  var dwEffect: DWORD): HResult;
begin
  Result:= E_NOTIMPL;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditOleCallback.GetContextMenu(seltype: Word;
  const oleobj: IOleObject; const chrg: TCharRange;
  out menu: HMENU): HResult;
begin
  Result:= E_NOTIMPL;
end;

{ ------------------------------------------------------------------------- }

function TLMDRichEditOleCallback.ShowContainerUI(fShow: BOOL): HResult;
begin
  if not fShow then AssignFrame;
  if Assigned(FFrameForm) then
    begin
      if fShow then
        begin
          FFrameForm.SetMenu(0, 0, 0);
          FFrameForm.ClearBorderSpace;
          FRichEdit.SetUIActive(False);
          DestroyAccelTable;
          TForm(FFrameForm.Form).AutoScroll:= FAutoScroll;
          FFrameForm:= nil;
          FDocForm:= nil;
        end
      else
        begin
          FAutoScroll:= TForm(FFrameForm.Form).AutoScroll;
          TForm(FFrameForm.Form).AutoScroll:= False;
          FRichEdit.SetUIActive(True);
        end;
      Result:= S_OK;
    end
  else
    Result:= E_NOTIMPL;
end;

{ **************************** TOleUIObjInfo  ***************************** }
{ ------------------------------------------------------------------------- }

constructor TOleUIObjInfo.Create(RichEdit: TLMDCustomRichEdit;
  ReObject: TReObject);
begin
  inherited Create;
  FRichEdit:= RichEdit;
  FReObject:= ReObject;
end;

{ ------------------------------------------------------------------------- }

function TOleUIObjInfo.GetObjectInfo(dwObject: Longint;
  var dwObjSize: Longint; var lpszLabel: PChar;
  var lpszType: PChar; var lpszShortType: PChar;
  var lpszLocation: PChar): HResult;
begin
  if @dwObjSize <> nil then
    dwObjSize:= -1 { Unknown size };
  if @lpszLabel <> nil then
    lpszLabel:= CoAllocCStr(GetFullNameStr(FReObject.poleobj));
  if @lpszType <> nil then
    lpszType:= CoAllocCStr(GetFullNameStr(FReObject.poleobj));
  if @lpszShortType <> nil then
    lpszShortType:= CoAllocCStr(GetShortNameStr(FReObject.poleobj));
  if (@lpszLocation <> nil) then
    begin
      if Trim(FRichEdit.Title) <> '' then
        lpszLocation:= CoAllocCStr(Format('%s - %s',
          [FRichEdit.Title, Application.Title]))
      else
        lpszLocation:= CoAllocCStr(Application.Title);
    end;
  Result:= S_OK;
end;

{ ------------------------------------------------------------------------- }

function TOleUIObjInfo.GetConvertInfo(dwObject: Longint; var ClassID: TCLSID;
  var wFormat: Word; var ConvertDefaultClassID: TCLSID;
  var lpClsidExclude: PCLSID; var cClsidExclude: Longint): HResult;
begin
  FReObject.poleobj.GetUserClassID(ClassID);
  Result:= S_OK;
end;

{ ------------------------------------------------------------------------- }

function TOleUIObjInfo.ConvertObject(dwObject: Longint;
  const clsidNew: TCLSID): HResult;
begin
  Result:= E_NOTIMPL
end;

{ ------------------------------------------------------------------------- }

function TOleUIObjInfo.GetViewInfo(dwObject: Longint; var hMetaPict: HGlobal;
  var dvAspect: Longint; var nCurrentScale: Integer): HResult;
begin

  if @hMetaPict <> nil then
    hMetaPict:= GetIconMetaPict(FReObject.poleobj, FReObject.dvAspect);
  if @dvAspect <> nil then dvAspect:= FReObject.dvAspect;
  if @nCurrentScale <> nil then nCurrentScale:= 0;

  Result:= S_OK;
end;

{ ------------------------------------------------------------------------- }

function TOleUIObjInfo.SetViewInfo(dwObject: Longint; hMetaPict: HGlobal;
  dvAspect: Longint; nCurrentScale: Integer;
  bRelativeToOrig: BOOL): HResult;
var
  Iconic: Boolean;
begin
  if Assigned(FRichEdit.RichEditOle) then
    begin
      case dvAspect of
        DVASPECT_CONTENT:
          Iconic:= False;
        DVASPECT_ICON:
          Iconic:= True;
      else
        Iconic:= FReObject.dvAspect = DVASPECT_ICON;
      end;
      IRichEditOle(FRichEdit.RichEditOle).InPlaceDeactivate;
      Result:= OleSetDrawAspect(FReObject.poleobj, Iconic, hMetaPict,
        FReObject.dvAspect);
      if Succeeded(Result) then
        IRichEditOle(FRichEdit.RichEditOle).SetDvaspect(Longint(REO_IOB_SELECTION), FReObject.dvAspect);
    end
  else
    Result:= E_NOTIMPL;
end;

{ ------------------------------------------------------------------------- }

procedure LinkError(const Ident: string);
begin

  Application.MessageBox(PChar(Ident), PChar(SLinkProperties),
    MB_OK or MB_ICONSTOP);

end;

{ ------------------------------------------------------------------------- }

constructor TOleUILinkInfo.Create(RichEdit: TLMDCustomRichEdit;
  ReObject: TReObject);
begin
  inherited Create;
  FReObject:= ReObject;
  FRichEdit:= RichEdit;
  OleCheck(FReObject.poleobj.QueryInterface(IOleLink, FOleLink));
end;

{ ------------------------------------------------------------------------- }

function TOleUILinkInfo.GetNextLink(dwLink: Longint): Longint;
begin
  if dwLink = 0 then
    Result:= Longint(FRichEdit)
  else
    Result:= 0;
end;

{ ------------------------------------------------------------------------- }

function TOleUILinkInfo.SetLinkUpdateOptions(dwLink: Longint;
  dwUpdateOpt: Longint): HResult;
begin
  Result:= FOleLink.SetUpdateOptions(dwUpdateOpt);
  if Succeeded(Result) then FRichEdit.Modified:= True;
end;

{ ------------------------------------------------------------------------- }

function TOleUILinkInfo.GetLinkUpdateOptions(dwLink: Longint;
  var dwUpdateOpt: Longint): HResult;
begin
  Result:= FOleLink.GetUpdateOptions(dwUpdateOpt)
end;

{ ------------------------------------------------------------------------- }

function TOleUILinkInfo.SetLinkSource(dwLink: Longint; pszDisplayName: PChar;
  lenFileName: Longint; var chEaten: Longint;
  fValidateSource: BOOL): HResult;
var
  DisplayName: string;
  Buffer: array[0..255] of WideChar;
begin
  Result:= E_FAIL;
  if fValidateSource then
    begin
      DisplayName:= pszDisplayName;
      if Succeeded(FOleLink.SetSourceDisplayName(StringToWideChar(DisplayName,
        Buffer, SizeOf(Buffer) div 2))) then
        begin
          chEaten:= Length(DisplayName);
          try
            OleCheck(FReObject.poleobj.Update);
          except
            Application.HandleException(FRichEdit);
          end;
          Result:= S_OK;
        end;
    end
  else
    LinkError(SInvalidLinkSource);
end;

{ ------------------------------------------------------------------------- }

function TOleUILinkInfo.GetLinkSource(dwLink: Longint; var pszDisplayName:
  PChar;
  var lenFileName: Longint; var pszFullLinkType: PChar;
  var pszShortLinkType: PChar; var fSourceAvailable: BOOL;
  var fIsSelected: BOOL): HResult;
var
  Moniker: IMoniker;
begin
  if @pszDisplayName <> nil then
    pszDisplayName:= CoAllocCStr(GetDisplayNameStr(FOleLink));
  if @lenFileName <> nil then
    begin
      lenFileName:= 0;
      FOleLink.GetSourceMoniker(Moniker);
      if Moniker <> nil then
        begin
          lenFileName:= OleStdGetLenFilePrefixOfMoniker(Moniker);
          Moniker:= nil;
        end;
    end;
  if @pszFullLinkType <> nil then
    pszFullLinkType:= CoAllocCStr(GetFullNameStr(FReObject.poleobj));
  if @pszShortLinkType <> nil then
    pszShortLinkType:= CoAllocCStr(GetShortNameStr(FReObject.poleobj));
  Result:= S_OK;
end;

{ ------------------------------------------------------------------------- }

function TOleUILinkInfo.OpenLinkSource(dwLink: Longint): HResult;
begin
  try
    OleCheck(FReObject.poleobj.DoVerb(OLEIVERB_SHOW, nil, FReObject.polesite,
      0, FRichEdit.Handle, FRichEdit.ClientRect));
  except
    Application.HandleException(FRichEdit);
  end;
  Result:= S_OK;
end;

{ ------------------------------------------------------------------------- }

function TOleUILinkInfo.UpdateLink(dwLink: Longint; fErrorMessage: BOOL;
  fErrorAction: BOOL): HResult;
begin
  try
    OleCheck(FReObject.poleobj.Update);
  except
    Application.HandleException(FRichEdit);
  end;
  Result:= S_OK;
end;

{ ------------------------------------------------------------------------- }

function TOleUILinkInfo.CancelLink(dwLink: Longint): HResult;
begin
  LinkError(SCannotBreakLink);
  Result:= E_NOTIMPL;
end;

{ ------------------------------------------------------------------------- }

function TOleUILinkInfo.GetLastUpdate(dwLink: Longint;
  var LastUpdate: TFileTime): HResult;
begin
  Result:= S_OK;
end;

end.
