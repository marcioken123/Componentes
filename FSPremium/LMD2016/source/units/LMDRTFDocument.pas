unit LMDRTFDocument;
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

LMDRTFDocument unit (VO)
------------------------

RTF document structures and types 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  classes;
const
  ctUNDEF = 'UNDEF';
  clUNDEF = -1;
  cbUNDEF = False;
  type

  {****************************************************************************}
  TLMDRTFFontFamily = (ffUNDEF, ffNIL, ffROMAN, ffSWISS, ffMODERN, ffSCRIPT, ffDECOR, ffTECH, ffBIDI);
  TLMDRTFEmbFontType = (ftUNDEF, ftNIL, ftTRUETYPE);

  TLMDRTFFontTableRecord = class(TCollectionItem)
  private
    FID : LongInt;
    FFontFamily : TLMDRTFFontFamily;
    FCharset : LongInt;
    FFontPitch : LongInt;
    FNontaggedName : boolean;
    FCodePage : LongInt;
    FFontName : string;
    FAltFontName : string;
    FEmbFontType : TLMDRTFEmbFontType;
    FEmbFontCodePage : LongInt;
    FEmbFontFileName : string;
    FPanose : string;
  public
    property FontFamily : TLMDRTFFontFamily read FFontFamily write FFontFamily;
    property Charset : LongInt read FCharset write FCharset;
    property FontPitch : LongInt read FFontPitch write FFontPitch;
    property NontaggedName : boolean read FNontaggedName write FNontaggedName;
    property CodePage : LongInt read FCodePage write FCodePage;
    property FontName : string read FFontName write FFontName;
    property AltFontName : string read FAltFontName write FAltFontName;
    property EmbFontType : TLMDRTFEmbFontType read FEmbFontType write FEmbFontType;
    property EmbFontCodePage : LongInt read FEmbFontCodePage write FEmbFontCodePage;
    property EmbFontFileName : string read FEmbFontFileName write FEmbFontFileName;
    property Panose : string read FPanose write FPanose;
    property ID : LongInt read FID write FID;
  end;

  {****************************************************************************}
  TLMDRTFFontTable = class(TCollection)
    function GetItem(index : integer) : TLMDRTFFontTableRecord;
  public
    constructor Create;
    function Add : TLMDRTFFontTableRecord;
    property Items[index : integer] : TLMDRTFFontTableRecord read GetItem; default;
  end;

  {****************************************************************************}
  TLMDRTFFileSource = (fsUNDEF, fsVALIDMAC, fsVALIDDOS, fsVALIDNTFS, fsVALIDHPFS, fsNETWORK);
  TLMDRTFFileSources = set of TLMDRTFFileSource;

  TLMDRTFFileTableRecord = class (TCollectionItem)
  private
    FID : LongInt;
    FRelativePos : LongInt;
    FOsNum : LongInt;
    FFileSources : TLMDRTFFileSources;
    FFileName : string;
  public
    property ID : LongInt read FID write FID;
    property RelativePos : LongInt read FRelativePos write FRelativePos;
    property OsNum : LongInt read FOsNum write FOsNum;
    property FileSources : TLMDRTFFileSources read FFileSources write FFileSources;
    property FileName : string read FFileName write FFileName;
  end;

  {****************************************************************************}
  TLMDRTFFileTable = class(TCollection)
  private
    function GetItem(index : integer) : TLMDRTFFileTableRecord;
  public
    constructor Create;
    function Add : TLMDRTFFileTableRecord;
    property Items[index : integer] : TLMDRTFFileTableRecord read GetItem; default;
  end;

  {****************************************************************************}
  TLMDRTFColorTableRecord = class (TCollectionItem)
  private
    FRed : integer;
    FGreen : integer;
    FBlue : integer;
  public
    property Red : integer read FRed write FRed;
    property Green : integer read FGreen write FGreen;
    property Blue : integer read FBlue write FBlue;
  end;

  {****************************************************************************}
  TLMDRTFColorTable = class(TCollection)
  private
    function GetItem(index : integer) : TLMDRTFColorTableRecord;
  public
    constructor Create;
    function Add : TLMDRTFColorTableRecord;
    property Items[index : integer] : TLMDRTFColorTableRecord read GetItem; default;
  end;

  {****************************************************************************}
  TLMDRTFBRDRK = (brdrUNDEF, brdrs, brdrth, brdrsh, brdrdb, brdrdot, brdrdash, brdrhair, brdrdashsm,
        brdrdashd, brdrdashdd, brdrtriple, brdrtnthsg, brdrthtnsg, brdrtnthtnsg, brdrtnthmg, brdrthtnmg,
        brdrtnthtnmg, brdrtnthlg, brdrthtnlg, brdrtnthtnlg, brdrwavy, brdrwavydb, brdrdashdotstr, brdremboss, brdrengrave);
  TLMDRTFBRDRKS = set of TLMDRTFBRDRK;

  TLMDRTFBorder = class
  private
    FDrawKind : TLMDRTFBRDRKS;
    FWidth : LongInt;
    FColor : LongInt;
    FSpacing : LongInt;
  public
    constructor Create;
    property DrawKind : TLMDRTFBRDRKS read FDrawKind write FDrawKind;
    property Width : LongInt read FWidth write FWidth;
    property Color : LongInt read FColor write FColor;
    property Spacing : LongInt read FSpacing write FSpacing;
  end;

  {****************************************************************************}
  TLMDRTFBorderDefs = class
  private
    FTop : TLMDRTFBorder;
    FBottom : TLMDRTFBorder;
    FLeft : TLMDRTFBorder;
    FRight : TLMDRTFBorder;
    FBar : TLMDRTFBorder;
    FBox : TLMDRTFBorder;
    FIPB : TLMDRTFBorder;
  public
    constructor Create;
    destructor Destroy; override;
    property Top : TLMDRTFBorder read FTop write FTop;
    property Bottom : TLMDRTFBorder read FBottom write FBottom;
    property Left : TLMDRTFBorder read FLeft write FLeft;
    property Right : TLMDRTFBorder read FRight write FRight;
    property Bar : TLMDRTFBorder read FBar write FBar;
    property Box : TLMDRTFBorder read FBox write FBox;
    property IPB : TLMDRTFBorder read FIPB write FIPB;
  end;

  {****************************************************************************}
  TLMDRTFParaAlignment = (paUNDEF, paLeft, paRight, paCenter, paJustify);
  TLMDRTFBiDi = (bidiUNDEF, bidiRTL, bidiLTR);
  TLMDRTFParaFormat = class
  private
    FParDef : boolean;
    FDesignatesParaStyle : LongInt;
    FHyphpar : LongInt;
    FIntbl : boolean;
    FKeep : boolean;
    FNowidctl : boolean;
    FWidctl : boolean;
    FKeepn : boolean;
    FLevel : LongInt;
    FNoline : boolean;
    FOutlinelevel : LongInt;
    FPagebb : boolean;
    FSbys : boolean;
    FAlignment : TLMDRTFParaAlignment;
    FFirstLineIndentation : LongInt;
    FLeftLineIndentation : LongInt;
    FRightLineIndentation : LongInt;
    FBeforeSpacing : LongInt;
    FAfterSpacing : LongInt;
    FBetweenSpacing : LongInt;
    FLineSpacing : LongInt;
    FSubdocument : LongInt;
    FBiDi : TLMDRTFBiDi;
    FAbsWidth : LongInt;
    FAbsHeight : LongInt;
    Fphmrg : boolean;
    Fphpg : boolean;
    Fphcol : boolean;
    Fposx : LongInt;
    Fposnegx : LongInt;
    Fposxc : boolean;
    Fposxi : boolean;
    Fposxo : boolean;
    Fposxr : boolean;
    Fposxl : boolean;
    Fpvmrg : boolean;
    Fpvpg : boolean;
    Fpvpara : boolean;
    Fposy : LongInt;
    Fposnegy : LongInt;
    Fposyil : boolean;
    Fposyt : boolean;
    Fposyc : boolean;
    Fposyb : boolean;
    Fabslock : boolean;
    Fnowrap : boolean;
    Fdxfrtext : LongInt;
    Fdfrmtxtx : LongInt;
    Fdfrmtxty : LongInt;
    Foverlay : boolean;
    Fposyin : boolean;
    Fposyout : boolean;
    Fdropcapli : LongInt;
    Fdropcapt : LongInt;
  public
    constructor Create;
    property ParDef : boolean read FParDef write FParDef;
    property DesignatesParaStyle : LongInt read FDesignatesParaStyle write FDesignatesParaStyle;
    property Hyphpar : LongInt read FHyphpar write FHyphpar;
    property Intbl : boolean read FIntbl write FIntbl;
    property Keep : boolean read FKeep write FKeep;
    property Nowidctl : boolean read FNowidctl write FNowidctl;
    property Widctl : boolean read FWidctl write FWidctl;
    property Keepn : boolean read FKeepn write FKeepn;
    property Level : LongInt read FLevel write FLevel;
    property Noline : boolean read FNoline write FNoline;
    property Outlinelevel : LongInt read FOutlinelevel write FOutlinelevel;
    property Pagebb : boolean read FPagebb write FPagebb;
    property Sbys : boolean read FSbys write FSbys;
    property Alignment : TLMDRTFParaAlignment read FAlignment write FAlignment;
    property FirstLineIndentation : LongInt read FFirstLineIndentation write FFirstLineIndentation;
    property LeftLineIndentation : LongInt read FLeftLineIndentation write FLeftLineIndentation;
    property RightLineIndentation : LongInt read FRightLineIndentation write FRightLineIndentation;
    property BeforeSpacing : LongInt read FBeforeSpacing write FBeforeSpacing;
    property AfterSpacing : LongInt read FAfterSpacing write FAfterSpacing;
    property BetweenSpacing : LongInt read FBetweenSpacing write FBetweenSpacing;
    property LineSpacing : LongInt read FLineSpacing write FLineSpacing;
    property Subdocument : LongInt read FSubdocument write FSubdocument;
    property BiDi : TLMDRTFBiDi read FBiDi write FBiDi;
    property AbsWidth : LongInt read FAbsWidth write FAbsWidth;
    property AbsHeight : LongInt read FAbsHeight write FAbsHeight;
    property phmrg : boolean read Fphmrg write Fphmrg;
    property phpg : boolean read Fphpg write Fphpg;
    property phcol : boolean read Fphcol write Fphcol;
    property posx : LongInt read Fposx write Fposx;
    property posnegx : LongInt read Fposnegx write Fposnegx;
    property posxc : boolean read Fposxc write Fposxc;
    property posxi : boolean read Fposxi write Fposxi;
    property posxo : boolean read Fposxo write Fposxo;
    property posxr : boolean read Fposxr write Fposxr;
    property posxl : boolean read Fposxl write Fposxl;
    property pvmrg : boolean read Fpvmrg write Fpvmrg;
    property pvpg : boolean read Fpvpg write Fpvpg;
    property pvpara : boolean read Fpvpara write Fpvpara;
    property posy : LongInt read Fposy write Fposy;
    property posnegy : LongInt read Fposnegy write Fposnegy;
    property posyil : boolean read Fposyil write Fposyil;
    property posyt : boolean read Fposyt write Fposyt;
    property posyc : boolean read Fposyc write Fposyc;
    property posyb : boolean read Fposyb write Fposyb;
    property abslock : boolean read Fabslock write Fabslock;
    property nowrap : boolean read Fnowrap write Fnowrap;
    property dxfrtext : LongInt read Fdxfrtext write Fdxfrtext;
    property dfrmtxtx : LongInt read Fdfrmtxtx write Fdfrmtxtx;
    property dfrmtxty : LongInt read Fdfrmtxty write Fdfrmtxty;
    property overlay : boolean read Foverlay write Foverlay;
    property posyin : boolean read Fposyin write Fposyin;
    property posyout : boolean read Fposyout write Fposyout;
    property dropcapli : LongInt read Fdropcapli write Fdropcapli;
    property dropcapt : LongInt read Fdropcapt write Fdropcapt;
  end;

  {****************************************************************************}
  TLMDRTFShiftState = set of (ssUNDEF, ssShift, ssAlt, ssCtrl);
  TLMDRTFStyleTableRecord = class (TCollectionItem)
  private
    FDesignatesParaStyle : LongInt;
    FDesignatesCharStyle : LongInt;
    FDesignatesSecStyle : LongInt;
    FKeyShiftState : TLMDRTFShiftState;
    FKeyNumber : LongInt;
    FKeyName : string;
    FAdditive : boolean;
    FBaseStyle : LongInt;
    FNextStyle : LongInt;
    FStyleName : string;
    FBorderDefs : TLMDRTFBorderDefs;
    FParaFormat : TLMDRTFParaFormat;
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    property DesignatesParaStyle : LongInt read FDesignatesParaStyle write FDesignatesParaStyle;
    property DesignatesCharStyle : LongInt read FDesignatesCharStyle write FDesignatesCharStyle;
    property DesignatesSecStyle : LongInt read FDesignatesSecStyle write FDesignatesSecStyle;
    property KeyShiftState : TLMDRTFShiftState read FKeyShiftState write FKeyShiftState;
    property KeyNumber : LongInt read FKeyNumber write FKeyNumber;
    property KeyName : string read FKeyName write FKeyName;
    property Additive : boolean read FAdditive write FAdditive;
    property BaseStyle : LongInt read FBaseStyle write FBaseStyle;
    property NextStyle : LongInt read FNextStyle write FNextStyle;
    property StyleName : string read FStyleName write FStyleName;
    property BorderDefs : TLMDRTFBorderDefs read FBorderDefs;
    property ParaFormat : TLMDRTFParaFormat read FParaFormat;
  end;

  {****************************************************************************}
  TLMDRTFStyleTable = class(TCollection)
  private
    function GetItem(index : integer) : TLMDRTFStyleTableRecord;
  public
    constructor Create;
    function Add : TLMDRTFStyleTableRecord;
    property Items[index : integer] : TLMDRTFStyleTableRecord read GetItem; default;
  end;

  {****************************************************************************}
  TLMDRTFCharTextDataType = (cttPDATA);

  TLMDRTFCharTextData = class
  private
    FDataType : TLMDRTFCharTextDataType;
  public
    property DataType : TLMDRTFCharTextDataType read FDataType write FDataType;
  end;

  {****************************************************************************}
  TLMDRTFCharTextPData = class(TLMDRTFCharTextData)
  private
    FData : string;
  public
    constructor Create(const aData : string);
    property Data : string read FData write FData;
  end;

  {****************************************************************************}
  TLMDRTFCharTextDataItem = class(TCollectionItem)
  private
    FData : TLMDRTFCharTextData;
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    property Data : TLMDRTFCharTextData read FData;
  end;

  {****************************************************************************}
  TLMDRTFCharTextDataItems = class(TCollection)
  private
    function GetItem(index : integer) : TLMDRTFCharTextData;
  public
    constructor Create;
    function Add(aData : TLMDRTFCharTextData) : TLMDRTFCharTextData;
    property Items[index : integer] : TLMDRTFCharTextData read GetItem; default;
  end;

  {****************************************************************************}
  TLMDRTFCharText = class(TCollectionItem)
  private
    FDataItems : TLMDRTFCharTextDataItems;
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    property DataItems : TLMDRTFCharTextDataItems read FDataItems;
  end;

  {****************************************************************************}
  TLMDRTFCharTexts = class(TCollection)
  private
    function GetItem(index : integer) : TLMDRTFCharText;
  public
    constructor Create;
    function Add : TLMDRTFCharText;
    property Items[index : integer] : TLMDRTFCharText read GetItem; default;
  end;

  {****************************************************************************}
  TLMDRTFParaType = (ptTEXT, ptROW);

  TLMDRTFPara = class
  private
    FParaType : TLMDRTFParaType;
  public
    property ParaType : TLMDRTFParaType read FParaType write FParaType;
  end;

  {****************************************************************************}
  TLMDRTFTextPara = class(TLMDRTFPara)
  private
    FCharTexts : TLMDRTFCharTexts;
  public
    constructor Create;
    destructor Destroy; override;
    property CharTexts : TLMDRTFCharTexts read FCharTexts;
  end;

  {****************************************************************************}
  TLMDRTFRowPara = class(TLMDRTFPara)
  private
  public
  end;

  {****************************************************************************}
  TLMDRTFParagraph = class(TCollectionItem)
  private
    FData : TLMDRTFPara;
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    property Data : TLMDRTFPara read FData;
  end;

  {****************************************************************************}
  TLMDRTFParagraphs = class(TCollection)
  private
    function GetItem(index : integer) : TLMDRTFPara;
  public
    constructor Create;
    function Add(aData : TLMDRTFPara) : TLMDRTFPara;
    property Items[index : integer] : TLMDRTFPara read GetItem; default;
  end;

  {****************************************************************************}
  TLMDRTFSection = class(TCollectionItem)
  private
    FParagraphs : TLMDRTFParagraphs;
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    property Paragraphs : TLMDRTFParagraphs read FParagraphs;
  end;

  {****************************************************************************}
  TLMDRTFSections = class(TCollection)
  private
    function GetItem(index : integer) : TLMDRTFSection;
  public
    constructor Create;
    function Add : TLMDRTFSection;
    property Items[index : integer] : TLMDRTFSection read GetItem; default;
  end;

  {****************************************************************************}
  TLMDRTFCharSet = (csUNDEF, csANSI, csMAC, csPC, csPCA);

  TLMDRTFDocument = class
  private
    FVersion : integer;
    FCharSet : TLMDRTFCharSet;
    FAnsiCodePage : LongInt;
    FDefaultFontNumber : LongInt;
    FBytePerUChar : integer;
    FFontTable : TLMDRTFFontTable;
    FFileTable : TLMDRTFFileTable;
    FColorTable : TLMDRTFColorTable;
    FStyleTable : TLMDRTFStyleTable;
    FSections : TLMDRTFSections;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property Version : integer read FVersion write FVersion;
    property CharSet : TLMDRTFCharSet read FCharSet write FCharSet;
    property AnsiCodePage : LongInt read FAnsiCodePage write FAnsiCodePage;
    property DefaultFontNumber : LongInt read FDefaultFontNumber write FDefaultFontNumber;
    property BytePerUChar : integer read FBytePerUChar write FBytePerUChar;
    property FontTable : TLMDRTFFontTable read FFontTable;
    property FileTable : TLMDRTFFileTable read FFileTable;
    property ColorTable : TLMDRTFColorTable read FColorTable;
    property StyleTable : TLMDRTFStyleTable read FStyleTable;
    property Sections : TLMDRTFSections read FSections;
  end;

implementation

{** TLMDRTFFontTable **********************************************************}
{-- private -------------------------------------------------------------------}
function TLMDRTFFontTable.GetItem(index : integer) : TLMDRTFFontTableRecord;
begin result := TLMDRTFFontTableRecord(inherited GetItem(index)); end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFFontTable.Create;
begin inherited Create(TLMDRTFFontTableRecord); end;

{------------------------------------------------------------------------------}
function TLMDRTFFontTable.Add : TLMDRTFFontTableRecord;
begin
  result := TLMDRTFFontTableRecord(inherited Add);
  with result do
    begin
      FontFamily := ffUNDEF;
      Charset := clUNDEF;
      FontPitch := clUNDEF;
      NontaggedName := cbUNDEF;
      CodePage := clUNDEF;
      FontName := ctUNDEF;
      AltFontName := ctUNDEF;
      EmbFontType := ftUNDEF;
      EmbFontCodePage := clUNDEF;
      EmbFontFileName := ctUNDEF;
      FPanose := ctUNDEF;
      FID := clUNDEF;
    end;
end;

{** TLMDRTFFileTable **********************************************************}
{-- private -------------------------------------------------------------------}
function TLMDRTFFileTable.GetItem(index : integer) : TLMDRTFFileTableRecord;
begin result := TLMDRTFFileTableRecord(inherited GetItem(index)); end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFFileTable.Create;
begin inherited Create(TLMDRTFFileTableRecord); end;

{------------------------------------------------------------------------------}
function TLMDRTFFileTable.Add : TLMDRTFFileTableRecord;
begin
  result := TLMDRTFFileTableRecord(inherited Add);
  with result do
    begin
      ID := clUNDEF;
      RelativePos := clUNDEF;
      OsNum := clUNDEF;
      FileSources := [];
      FileName := ctUNDEF;
    end;
end;

{** TLMDRTFColorTable *********************************************************}
{-- private -------------------------------------------------------------------}
function TLMDRTFColorTable.GetItem(index : integer) : TLMDRTFColorTableRecord;
begin result := TLMDRTFColorTableRecord(inherited GetItem(index)); end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFColorTable.Create;
begin inherited Create(TLMDRTFColorTableRecord); end;

{------------------------------------------------------------------------------}
function TLMDRTFColorTable.Add : TLMDRTFColorTableRecord;
begin
  result := TLMDRTFColorTableRecord(inherited Add);
  with result do
    begin
      Red := clUNDEF;
      Green := clUNDEF;
      Blue := clUNDEF;
    end;
end;

{** TLMDRTFBorder *************************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFBorder.Create;
begin
  inherited;
  FDrawKind := [];
  FWidth := clUNDEF;
  FColor := clUNDEF;
  FSpacing := clUNDEF;
end;

{** TLMDRTFBorderDefs *********************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFBorderDefs.Create;
begin
  inherited;
  FTop := TLMDRTFBorder.Create;
  FBottom := TLMDRTFBorder.Create;
  FLeft := TLMDRTFBorder.Create;
  FRight := TLMDRTFBorder.Create;
  FBar := TLMDRTFBorder.Create;
  FBox := TLMDRTFBorder.Create;
  FIPB := TLMDRTFBorder.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFBorderDefs.Destroy;
begin
  FTop.Free;
  FBottom.Free;
  FLeft.Free;
  FRight.Free;
  FBar.Free;
  FBox.Free;
  FIPB.Free;
  inherited;
end;

{** TLMDRTFParaFormat *********************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFParaFormat.Create;
begin
  inherited;
    FParDef := cbUNDEF;
    FDesignatesParaStyle := clUNDEF;
    FHyphpar := clUNDEF;
    FIntbl := cbUNDEF;
    FKeep := cbUNDEF;
    FNowidctl := cbUNDEF;
    FWidctl := cbUNDEF;
    FKeepn := cbUNDEF;
    FLevel := clUNDEF;
    FNoline := cbUNDEF;
    FOutlinelevel := clUNDEF;
    FPagebb := cbUNDEF;
    FSbys := cbUNDEF;
    FAlignment := paUNDEF;
    FFirstLineIndentation := clUNDEF;
    FLeftLineIndentation := clUNDEF;
    FRightLineIndentation := clUNDEF;
    FBeforeSpacing := clUNDEF;
    FAfterSpacing := clUNDEF;
    FBetweenSpacing := clUNDEF;
    FLineSpacing := clUNDEF;
    FSubdocument := clUNDEF;
    FBiDi := bidiUNDEF;
    FAbsWidth := clUNDEF;
    FAbsHeight := clUNDEF;
    Fphmrg := cbUNDEF;
    Fphpg := cbUNDEF;
    Fphcol := cbUNDEF;
    Fposx := clUNDEF;
    Fposnegx := clUNDEF;
    Fposxc := cbUNDEF;
    Fposxi := cbUNDEF;
    Fposxo := cbUNDEF;
    Fposxr := cbUNDEF;
    Fposxl := cbUNDEF;
    Fpvmrg := cbUNDEF;
    Fpvpg := cbUNDEF;
    Fpvpara := cbUNDEF;
    Fposy := clUNDEF;
    Fposnegy := clUNDEF;
    Fposyil := cbUNDEF;
    Fposyt := cbUNDEF;
    Fposyc := cbUNDEF;
    Fposyb := cbUNDEF;
    Fabslock := cbUNDEF;
    Fnowrap := cbUNDEF;
    Fdxfrtext := clUNDEF;
    Fdfrmtxtx := clUNDEF;
    Fdfrmtxty := clUNDEF;
    Foverlay := cbUNDEF;
    Fposyin := cbUNDEF;
    Fposyout := cbUNDEF;
    Fdropcapli := clUNDEF;
    Fdropcapt := clUNDEF;
end;

{** TLMDRTFStyleTableRecord ***************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFStyleTableRecord.Create(Collection : TCollection);
begin
  inherited;
  FBorderDefs := TLMDRTFBorderDefs.Create;
  FParaFormat := TLMDRTFParaFormat.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFStyleTableRecord.Destroy;
begin
  FBorderDefs.Free;
  FParaFormat.Free;
  inherited;
end;

{** TLMDRTFStyleTable *********************************************************}
{-- private -------------------------------------------------------------------}
function TLMDRTFStyleTable.GetItem(index : integer) : TLMDRTFStyleTableRecord;
begin result := TLMDRTFStyleTableRecord(inherited GetItem(index)); end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFStyleTable.Create;
begin inherited Create(TLMDRTFStyleTableRecord); end;

{------------------------------------------------------------------------------}
function TLMDRTFStyleTable.Add : TLMDRTFStyleTableRecord;
begin
  result := TLMDRTFStyleTableRecord(inherited Add);
  with result do
    begin
      FDesignatesParaStyle := clUNDEF;
      FDesignatesCharStyle := clUNDEF;
      FDesignatesSecStyle := clUNDEF;
      FKeyShiftState := [];
      FKeyNumber := clUNDEF;
      FKeyName := ctUNDEF;
      FAdditive := cbUNDEF;
      FBaseStyle := clUNDEF;
      FNextStyle := clUNDEF;
      FStyleName := ctUNDEF;
    end;
end;

{** TLMDRTFCharTextPData ***********************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFCharTextPData.Create(const aData : string);
begin
  inherited Create;
  FDataType := cttPDATA;
  FData := aData;
end;

{** TLMDRTFCharTextDataItem ***************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFCharTextDataItem.Create(Collection : TCollection);
begin
  inherited;
  FData := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFCharTextDataItem.Destroy;
begin
  if assigned(FData) then FData.Free;
  inherited;
end;

{** TLMDRTFCharTextDataItems **************************************************}
{-- private -------------------------------------------------------------------}
function TLMDRTFCharTextDataItems.GetItem(index : integer) : TLMDRTFCharTextData;
var
  item : TLMDRTFCharTextDataItem;
begin
  item := TLMDRTFCharTextDataItem(inherited GetItem(index));
  result := item.Data
end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFCharTextDataItems.Create;
begin inherited Create(TLMDRTFCharTextDataItem); end;

{------------------------------------------------------------------------------}
function TLMDRTFCharTextDataItems.Add(aData : TLMDRTFCharTextData) : TLMDRTFCharTextData;
var
  item : TLMDRTFCharTextDataItem;
begin
  item := TLMDRTFCharTextDataItem(inherited Add);
  item.FData := aData;
  result := aData;
end;

{** TLMDRTFCharText ***********************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFCharText.Create(Collection : TCollection);
begin
  inherited;
  FDataItems := TLMDRTFCharTextDataItems.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFCharText.Destroy;
begin
  FDataItems.Free;
  inherited;
end;

{** TLMDRTFCharTexts **********************************************************}
{-- private -------------------------------------------------------------------}
function TLMDRTFCharTexts.GetItem(index : integer) : TLMDRTFCharText;
begin result := TLMDRTFCharText(inherited GetItem(index)); end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFCharTexts.Create;
begin inherited Create(TLMDRTFCharText); end;

{------------------------------------------------------------------------------}
function TLMDRTFCharTexts.Add : TLMDRTFCharText;
begin result := TLMDRTFCharText(inherited Add); end;

{** TLMDRTFTextPara ***********************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFTextPara.Create;
begin
  inherited Create;
  FParaType := ptTEXT;
  FCharTexts := TLMDRTFCharTexts.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFTextPara.Destroy;
begin
  FCharTexts.Free;
  inherited;
end;

{** TLMDRTFParagraph **********************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFParagraph.Create(Collection : TCollection);
begin
  inherited;
  FData := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFParagraph.Destroy;
begin
  if assigned(FData) then FData.Free;
  inherited;
end;

{** TLMDRTFParagraphs *********************************************************}
{-- private -------------------------------------------------------------------}
function TLMDRTFParagraphs.GetItem(index : integer) : TLMDRTFPara;
var
  item : TLMDRTFParagraph;
begin
  item := TLMDRTFParagraph(inherited GetItem(index));
  result := item.Data;
end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFParagraphs.Create;
begin inherited Create(TLMDRTFParagraph); end;

{------------------------------------------------------------------------------}
function TLMDRTFParagraphs.Add(aData : TLMDRTFPara) : TLMDRTFPara;
var
  item : TLMDRTFParagraph;
begin
  item := TLMDRTFParagraph(inherited Add);
  item.FData := aData;
  result := aData;
end;

{** TLMDRTFSection ************************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFSection.Create(Collection : TCollection);
begin
  inherited;
  FParagraphs := TLMDRTFParagraphs.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFSection.Destroy;
begin
  FParagraphs.Free;
  inherited;
end;

{** TLMDRTFSections ***********************************************************}
{-- private -------------------------------------------------------------------}
function TLMDRTFSections.GetItem(index : integer) : TLMDRTFSection;
begin result := TLMDRTFSection(inherited GetItem(index)); end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFSections.Create;
begin inherited Create(TLMDRTFSection); end;

{------------------------------------------------------------------------------}
function TLMDRTFSections.Add : TLMDRTFSection;
begin result := TLMDRTFSection(inherited Add); end;

{** TLMDRTFDocument ***********************************************************}
{-- private -------------------------------------------------------------------}
{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFDocument.Create;
begin
  inherited;
  FFontTable := TLMDRTFFontTable.Create;
  FFileTable := TLMDRTFFileTable.Create;
  FColorTable := TLMDRTFColorTable.Create;
  FStyleTable := TLMDRTFStyleTable.Create;
  FSections := TLMDRTFSections.Create;
  Clear;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFDocument.Destroy;
begin
  FFontTable.Free;
  FFileTable.Free;
  FColorTable.Free;
  FStyleTable.Free;
  FSections.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFDocument.Clear;
begin
  FVersion := clUNDEF;
  FCharSet := csUNDEF;
  FAnsiCodePage := clUNDEF;
  FDefaultFontNumber := clUNDEF;
  FBytePerUChar := clUNDEF;
  FFontTable.Clear;
  FFileTable.Clear;
  FColorTable.Clear;
  FStyleTable.Clear;
  FSections.Clear;
end;

end.
