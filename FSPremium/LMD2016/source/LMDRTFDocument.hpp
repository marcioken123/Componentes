// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFDocument.pas' rev: 31.00 (Windows)

#ifndef LmdrtfdocumentHPP
#define LmdrtfdocumentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfdocument
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFFontTableRecord;
class DELPHICLASS TLMDRTFFontTable;
class DELPHICLASS TLMDRTFFileTableRecord;
class DELPHICLASS TLMDRTFFileTable;
class DELPHICLASS TLMDRTFColorTableRecord;
class DELPHICLASS TLMDRTFColorTable;
class DELPHICLASS TLMDRTFBorder;
class DELPHICLASS TLMDRTFBorderDefs;
class DELPHICLASS TLMDRTFParaFormat;
class DELPHICLASS TLMDRTFStyleTableRecord;
class DELPHICLASS TLMDRTFStyleTable;
class DELPHICLASS TLMDRTFCharTextData;
class DELPHICLASS TLMDRTFCharTextPData;
class DELPHICLASS TLMDRTFCharTextDataItem;
class DELPHICLASS TLMDRTFCharTextDataItems;
class DELPHICLASS TLMDRTFCharText;
class DELPHICLASS TLMDRTFCharTexts;
class DELPHICLASS TLMDRTFPara;
class DELPHICLASS TLMDRTFTextPara;
class DELPHICLASS TLMDRTFRowPara;
class DELPHICLASS TLMDRTFParagraph;
class DELPHICLASS TLMDRTFParagraphs;
class DELPHICLASS TLMDRTFSection;
class DELPHICLASS TLMDRTFSections;
class DELPHICLASS TLMDRTFDocument;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDRTFFontFamily : unsigned char { ffUNDEF, ffNIL, ffROMAN, ffSWISS, ffMODERN, ffSCRIPT, ffDECOR, ffTECH, ffBIDI };

enum DECLSPEC_DENUM TLMDRTFEmbFontType : unsigned char { ftUNDEF, ftNIL, ftTRUETYPE };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFFontTableRecord : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FID;
	TLMDRTFFontFamily FFontFamily;
	int FCharset;
	int FFontPitch;
	bool FNontaggedName;
	int FCodePage;
	System::UnicodeString FFontName;
	System::UnicodeString FAltFontName;
	TLMDRTFEmbFontType FEmbFontType;
	int FEmbFontCodePage;
	System::UnicodeString FEmbFontFileName;
	System::UnicodeString FPanose;
	
public:
	__property TLMDRTFFontFamily FontFamily = {read=FFontFamily, write=FFontFamily, nodefault};
	__property int Charset = {read=FCharset, write=FCharset, nodefault};
	__property int FontPitch = {read=FFontPitch, write=FFontPitch, nodefault};
	__property bool NontaggedName = {read=FNontaggedName, write=FNontaggedName, nodefault};
	__property int CodePage = {read=FCodePage, write=FCodePage, nodefault};
	__property System::UnicodeString FontName = {read=FFontName, write=FFontName};
	__property System::UnicodeString AltFontName = {read=FAltFontName, write=FAltFontName};
	__property TLMDRTFEmbFontType EmbFontType = {read=FEmbFontType, write=FEmbFontType, nodefault};
	__property int EmbFontCodePage = {read=FEmbFontCodePage, write=FEmbFontCodePage, nodefault};
	__property System::UnicodeString EmbFontFileName = {read=FEmbFontFileName, write=FEmbFontFileName};
	__property System::UnicodeString Panose = {read=FPanose, write=FPanose};
	__property int ID = {read=FID, write=FID, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDRTFFontTableRecord(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDRTFFontTableRecord(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFFontTable : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRTFFontTableRecord* operator[](int index) { return this->Items[index]; }
	
__published:
	HIDESBASE TLMDRTFFontTableRecord* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDRTFFontTable(void);
	HIDESBASE TLMDRTFFontTableRecord* __fastcall Add(void);
	__property TLMDRTFFontTableRecord* Items[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRTFFontTable(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDRTFFileSource : unsigned char { fsUNDEF, fsVALIDMAC, fsVALIDDOS, fsVALIDNTFS, fsVALIDHPFS, fsNETWORK };

typedef System::Set<TLMDRTFFileSource, TLMDRTFFileSource::fsUNDEF, TLMDRTFFileSource::fsNETWORK> TLMDRTFFileSources;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFFileTableRecord : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FID;
	int FRelativePos;
	int FOsNum;
	TLMDRTFFileSources FFileSources;
	System::UnicodeString FFileName;
	
public:
	__property int ID = {read=FID, write=FID, nodefault};
	__property int RelativePos = {read=FRelativePos, write=FRelativePos, nodefault};
	__property int OsNum = {read=FOsNum, write=FOsNum, nodefault};
	__property TLMDRTFFileSources FileSources = {read=FFileSources, write=FFileSources, nodefault};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDRTFFileTableRecord(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDRTFFileTableRecord(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFFileTable : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRTFFileTableRecord* operator[](int index) { return this->Items[index]; }
	
private:
	HIDESBASE TLMDRTFFileTableRecord* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDRTFFileTable(void);
	HIDESBASE TLMDRTFFileTableRecord* __fastcall Add(void);
	__property TLMDRTFFileTableRecord* Items[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRTFFileTable(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFColorTableRecord : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FRed;
	int FGreen;
	int FBlue;
	
public:
	__property int Red = {read=FRed, write=FRed, nodefault};
	__property int Green = {read=FGreen, write=FGreen, nodefault};
	__property int Blue = {read=FBlue, write=FBlue, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDRTFColorTableRecord(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDRTFColorTableRecord(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFColorTable : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRTFColorTableRecord* operator[](int index) { return this->Items[index]; }
	
private:
	HIDESBASE TLMDRTFColorTableRecord* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDRTFColorTable(void);
	HIDESBASE TLMDRTFColorTableRecord* __fastcall Add(void);
	__property TLMDRTFColorTableRecord* Items[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRTFColorTable(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDRTFBRDRK : unsigned char { brdrUNDEF, brdrs, brdrth, brdrsh, brdrdb, brdrdot, brdrdash, brdrhair, brdrdashsm, brdrdashd, brdrdashdd, brdrtriple, brdrtnthsg, brdrthtnsg, brdrtnthtnsg, brdrtnthmg, brdrthtnmg, brdrtnthtnmg, brdrtnthlg, brdrthtnlg, brdrtnthtnlg, brdrwavy, brdrwavydb, brdrdashdotstr, brdremboss, brdrengrave };

typedef System::Set<TLMDRTFBRDRK, TLMDRTFBRDRK::brdrUNDEF, TLMDRTFBRDRK::brdrengrave> TLMDRTFBRDRKS;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFBorder : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDRTFBRDRKS FDrawKind;
	int FWidth;
	int FColor;
	int FSpacing;
	
public:
	__fastcall TLMDRTFBorder(void);
	__property TLMDRTFBRDRKS DrawKind = {read=FDrawKind, write=FDrawKind, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Color = {read=FColor, write=FColor, nodefault};
	__property int Spacing = {read=FSpacing, write=FSpacing, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFBorder(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFBorderDefs : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDRTFBorder* FTop;
	TLMDRTFBorder* FBottom;
	TLMDRTFBorder* FLeft;
	TLMDRTFBorder* FRight;
	TLMDRTFBorder* FBar;
	TLMDRTFBorder* FBox;
	TLMDRTFBorder* FIPB;
	
public:
	__fastcall TLMDRTFBorderDefs(void);
	__fastcall virtual ~TLMDRTFBorderDefs(void);
	__property TLMDRTFBorder* Top = {read=FTop, write=FTop};
	__property TLMDRTFBorder* Bottom = {read=FBottom, write=FBottom};
	__property TLMDRTFBorder* Left = {read=FLeft, write=FLeft};
	__property TLMDRTFBorder* Right = {read=FRight, write=FRight};
	__property TLMDRTFBorder* Bar = {read=FBar, write=FBar};
	__property TLMDRTFBorder* Box = {read=FBox, write=FBox};
	__property TLMDRTFBorder* IPB = {read=FIPB, write=FIPB};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDRTFParaAlignment : unsigned char { paUNDEF, paLeft, paRight, paCenter, paJustify };

enum DECLSPEC_DENUM TLMDRTFBiDi : unsigned char { bidiUNDEF, bidiRTL, bidiLTR };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFParaFormat : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FParDef;
	int FDesignatesParaStyle;
	int FHyphpar;
	bool FIntbl;
	bool FKeep;
	bool FNowidctl;
	bool FWidctl;
	bool FKeepn;
	int FLevel;
	bool FNoline;
	int FOutlinelevel;
	bool FPagebb;
	bool FSbys;
	TLMDRTFParaAlignment FAlignment;
	int FFirstLineIndentation;
	int FLeftLineIndentation;
	int FRightLineIndentation;
	int FBeforeSpacing;
	int FAfterSpacing;
	int FBetweenSpacing;
	int FLineSpacing;
	int FSubdocument;
	TLMDRTFBiDi FBiDi;
	int FAbsWidth;
	int FAbsHeight;
	bool Fphmrg;
	bool Fphpg;
	bool Fphcol;
	int Fposx;
	int Fposnegx;
	bool Fposxc;
	bool Fposxi;
	bool Fposxo;
	bool Fposxr;
	bool Fposxl;
	bool Fpvmrg;
	bool Fpvpg;
	bool Fpvpara;
	int Fposy;
	int Fposnegy;
	bool Fposyil;
	bool Fposyt;
	bool Fposyc;
	bool Fposyb;
	bool Fabslock;
	bool Fnowrap;
	int Fdxfrtext;
	int Fdfrmtxtx;
	int Fdfrmtxty;
	bool Foverlay;
	bool Fposyin;
	bool Fposyout;
	int Fdropcapli;
	int Fdropcapt;
	
public:
	__fastcall TLMDRTFParaFormat(void);
	__property bool ParDef = {read=FParDef, write=FParDef, nodefault};
	__property int DesignatesParaStyle = {read=FDesignatesParaStyle, write=FDesignatesParaStyle, nodefault};
	__property int Hyphpar = {read=FHyphpar, write=FHyphpar, nodefault};
	__property bool Intbl = {read=FIntbl, write=FIntbl, nodefault};
	__property bool Keep = {read=FKeep, write=FKeep, nodefault};
	__property bool Nowidctl = {read=FNowidctl, write=FNowidctl, nodefault};
	__property bool Widctl = {read=FWidctl, write=FWidctl, nodefault};
	__property bool Keepn = {read=FKeepn, write=FKeepn, nodefault};
	__property int Level = {read=FLevel, write=FLevel, nodefault};
	__property bool Noline = {read=FNoline, write=FNoline, nodefault};
	__property int Outlinelevel = {read=FOutlinelevel, write=FOutlinelevel, nodefault};
	__property bool Pagebb = {read=FPagebb, write=FPagebb, nodefault};
	__property bool Sbys = {read=FSbys, write=FSbys, nodefault};
	__property TLMDRTFParaAlignment Alignment = {read=FAlignment, write=FAlignment, nodefault};
	__property int FirstLineIndentation = {read=FFirstLineIndentation, write=FFirstLineIndentation, nodefault};
	__property int LeftLineIndentation = {read=FLeftLineIndentation, write=FLeftLineIndentation, nodefault};
	__property int RightLineIndentation = {read=FRightLineIndentation, write=FRightLineIndentation, nodefault};
	__property int BeforeSpacing = {read=FBeforeSpacing, write=FBeforeSpacing, nodefault};
	__property int AfterSpacing = {read=FAfterSpacing, write=FAfterSpacing, nodefault};
	__property int BetweenSpacing = {read=FBetweenSpacing, write=FBetweenSpacing, nodefault};
	__property int LineSpacing = {read=FLineSpacing, write=FLineSpacing, nodefault};
	__property int Subdocument = {read=FSubdocument, write=FSubdocument, nodefault};
	__property TLMDRTFBiDi BiDi = {read=FBiDi, write=FBiDi, nodefault};
	__property int AbsWidth = {read=FAbsWidth, write=FAbsWidth, nodefault};
	__property int AbsHeight = {read=FAbsHeight, write=FAbsHeight, nodefault};
	__property bool phmrg = {read=Fphmrg, write=Fphmrg, nodefault};
	__property bool phpg = {read=Fphpg, write=Fphpg, nodefault};
	__property bool phcol = {read=Fphcol, write=Fphcol, nodefault};
	__property int posx = {read=Fposx, write=Fposx, nodefault};
	__property int posnegx = {read=Fposnegx, write=Fposnegx, nodefault};
	__property bool posxc = {read=Fposxc, write=Fposxc, nodefault};
	__property bool posxi = {read=Fposxi, write=Fposxi, nodefault};
	__property bool posxo = {read=Fposxo, write=Fposxo, nodefault};
	__property bool posxr = {read=Fposxr, write=Fposxr, nodefault};
	__property bool posxl = {read=Fposxl, write=Fposxl, nodefault};
	__property bool pvmrg = {read=Fpvmrg, write=Fpvmrg, nodefault};
	__property bool pvpg = {read=Fpvpg, write=Fpvpg, nodefault};
	__property bool pvpara = {read=Fpvpara, write=Fpvpara, nodefault};
	__property int posy = {read=Fposy, write=Fposy, nodefault};
	__property int posnegy = {read=Fposnegy, write=Fposnegy, nodefault};
	__property bool posyil = {read=Fposyil, write=Fposyil, nodefault};
	__property bool posyt = {read=Fposyt, write=Fposyt, nodefault};
	__property bool posyc = {read=Fposyc, write=Fposyc, nodefault};
	__property bool posyb = {read=Fposyb, write=Fposyb, nodefault};
	__property bool abslock = {read=Fabslock, write=Fabslock, nodefault};
	__property bool nowrap = {read=Fnowrap, write=Fnowrap, nodefault};
	__property int dxfrtext = {read=Fdxfrtext, write=Fdxfrtext, nodefault};
	__property int dfrmtxtx = {read=Fdfrmtxtx, write=Fdfrmtxtx, nodefault};
	__property int dfrmtxty = {read=Fdfrmtxty, write=Fdfrmtxty, nodefault};
	__property bool overlay = {read=Foverlay, write=Foverlay, nodefault};
	__property bool posyin = {read=Fposyin, write=Fposyin, nodefault};
	__property bool posyout = {read=Fposyout, write=Fposyout, nodefault};
	__property int dropcapli = {read=Fdropcapli, write=Fdropcapli, nodefault};
	__property int dropcapt = {read=Fdropcapt, write=Fdropcapt, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFParaFormat(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM Lmdrtfdocument__01 : unsigned char { ssUNDEF, ssShift, ssAlt, ssCtrl };

typedef System::Set<Lmdrtfdocument__01, Lmdrtfdocument__01::ssUNDEF, Lmdrtfdocument__01::ssCtrl> TLMDRTFShiftState;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFStyleTableRecord : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FDesignatesParaStyle;
	int FDesignatesCharStyle;
	int FDesignatesSecStyle;
	TLMDRTFShiftState FKeyShiftState;
	int FKeyNumber;
	System::UnicodeString FKeyName;
	bool FAdditive;
	int FBaseStyle;
	int FNextStyle;
	System::UnicodeString FStyleName;
	TLMDRTFBorderDefs* FBorderDefs;
	TLMDRTFParaFormat* FParaFormat;
	
public:
	__fastcall virtual TLMDRTFStyleTableRecord(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDRTFStyleTableRecord(void);
	__property int DesignatesParaStyle = {read=FDesignatesParaStyle, write=FDesignatesParaStyle, nodefault};
	__property int DesignatesCharStyle = {read=FDesignatesCharStyle, write=FDesignatesCharStyle, nodefault};
	__property int DesignatesSecStyle = {read=FDesignatesSecStyle, write=FDesignatesSecStyle, nodefault};
	__property TLMDRTFShiftState KeyShiftState = {read=FKeyShiftState, write=FKeyShiftState, nodefault};
	__property int KeyNumber = {read=FKeyNumber, write=FKeyNumber, nodefault};
	__property System::UnicodeString KeyName = {read=FKeyName, write=FKeyName};
	__property bool Additive = {read=FAdditive, write=FAdditive, nodefault};
	__property int BaseStyle = {read=FBaseStyle, write=FBaseStyle, nodefault};
	__property int NextStyle = {read=FNextStyle, write=FNextStyle, nodefault};
	__property System::UnicodeString StyleName = {read=FStyleName, write=FStyleName};
	__property TLMDRTFBorderDefs* BorderDefs = {read=FBorderDefs};
	__property TLMDRTFParaFormat* ParaFormat = {read=FParaFormat};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFStyleTable : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRTFStyleTableRecord* operator[](int index) { return this->Items[index]; }
	
private:
	HIDESBASE TLMDRTFStyleTableRecord* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDRTFStyleTable(void);
	HIDESBASE TLMDRTFStyleTableRecord* __fastcall Add(void);
	__property TLMDRTFStyleTableRecord* Items[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRTFStyleTable(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDRTFCharTextDataType : unsigned char { cttPDATA };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFCharTextData : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDRTFCharTextDataType FDataType;
	
public:
	__property TLMDRTFCharTextDataType DataType = {read=FDataType, write=FDataType, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDRTFCharTextData(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFCharTextData(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFCharTextPData : public TLMDRTFCharTextData
{
	typedef TLMDRTFCharTextData inherited;
	
private:
	System::UnicodeString FData;
	
public:
	__fastcall TLMDRTFCharTextPData(const System::UnicodeString aData);
	__property System::UnicodeString Data = {read=FData, write=FData};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFCharTextPData(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFCharTextDataItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDRTFCharTextData* FData;
	
public:
	__fastcall virtual TLMDRTFCharTextDataItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDRTFCharTextDataItem(void);
	__property TLMDRTFCharTextData* Data = {read=FData};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFCharTextDataItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRTFCharTextData* operator[](int index) { return this->Items[index]; }
	
private:
	HIDESBASE TLMDRTFCharTextData* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDRTFCharTextDataItems(void);
	HIDESBASE TLMDRTFCharTextData* __fastcall Add(TLMDRTFCharTextData* aData);
	__property TLMDRTFCharTextData* Items[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRTFCharTextDataItems(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFCharText : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDRTFCharTextDataItems* FDataItems;
	
public:
	__fastcall virtual TLMDRTFCharText(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDRTFCharText(void);
	__property TLMDRTFCharTextDataItems* DataItems = {read=FDataItems};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFCharTexts : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRTFCharText* operator[](int index) { return this->Items[index]; }
	
private:
	HIDESBASE TLMDRTFCharText* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDRTFCharTexts(void);
	HIDESBASE TLMDRTFCharText* __fastcall Add(void);
	__property TLMDRTFCharText* Items[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRTFCharTexts(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDRTFParaType : unsigned char { ptTEXT, ptROW };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFPara : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDRTFParaType FParaType;
	
public:
	__property TLMDRTFParaType ParaType = {read=FParaType, write=FParaType, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDRTFPara(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFPara(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFTextPara : public TLMDRTFPara
{
	typedef TLMDRTFPara inherited;
	
private:
	TLMDRTFCharTexts* FCharTexts;
	
public:
	__fastcall TLMDRTFTextPara(void);
	__fastcall virtual ~TLMDRTFTextPara(void);
	__property TLMDRTFCharTexts* CharTexts = {read=FCharTexts};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFRowPara : public TLMDRTFPara
{
	typedef TLMDRTFPara inherited;
	
public:
	/* TObject.Create */ inline __fastcall TLMDRTFRowPara(void) : TLMDRTFPara() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFRowPara(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFParagraph : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDRTFPara* FData;
	
public:
	__fastcall virtual TLMDRTFParagraph(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDRTFParagraph(void);
	__property TLMDRTFPara* Data = {read=FData};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFParagraphs : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRTFPara* operator[](int index) { return this->Items[index]; }
	
private:
	HIDESBASE TLMDRTFPara* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDRTFParagraphs(void);
	HIDESBASE TLMDRTFPara* __fastcall Add(TLMDRTFPara* aData);
	__property TLMDRTFPara* Items[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRTFParagraphs(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFSection : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDRTFParagraphs* FParagraphs;
	
public:
	__fastcall virtual TLMDRTFSection(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDRTFSection(void);
	__property TLMDRTFParagraphs* Paragraphs = {read=FParagraphs};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFSections : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRTFSection* operator[](int index) { return this->Items[index]; }
	
private:
	HIDESBASE TLMDRTFSection* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDRTFSections(void);
	HIDESBASE TLMDRTFSection* __fastcall Add(void);
	__property TLMDRTFSection* Items[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRTFSections(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDRTFCharSet : unsigned char { csUNDEF, csANSI, csMAC, csPC, csPCA };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFDocument : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FVersion;
	TLMDRTFCharSet FCharSet;
	int FAnsiCodePage;
	int FDefaultFontNumber;
	int FBytePerUChar;
	TLMDRTFFontTable* FFontTable;
	TLMDRTFFileTable* FFileTable;
	TLMDRTFColorTable* FColorTable;
	TLMDRTFStyleTable* FStyleTable;
	TLMDRTFSections* FSections;
	
public:
	__fastcall TLMDRTFDocument(void);
	__fastcall virtual ~TLMDRTFDocument(void);
	void __fastcall Clear(void);
	__property int Version = {read=FVersion, write=FVersion, nodefault};
	__property TLMDRTFCharSet CharSet = {read=FCharSet, write=FCharSet, nodefault};
	__property int AnsiCodePage = {read=FAnsiCodePage, write=FAnsiCodePage, nodefault};
	__property int DefaultFontNumber = {read=FDefaultFontNumber, write=FDefaultFontNumber, nodefault};
	__property int BytePerUChar = {read=FBytePerUChar, write=FBytePerUChar, nodefault};
	__property TLMDRTFFontTable* FontTable = {read=FFontTable};
	__property TLMDRTFFileTable* FileTable = {read=FFileTable};
	__property TLMDRTFColorTable* ColorTable = {read=FColorTable};
	__property TLMDRTFStyleTable* StyleTable = {read=FStyleTable};
	__property TLMDRTFSections* Sections = {read=FSections};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
#define ctUNDEF L"UNDEF"
static const System::Int8 clUNDEF = System::Int8(-1);
static const bool cbUNDEF = false;
}	/* namespace Lmdrtfdocument */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFDOCUMENT)
using namespace Lmdrtfdocument;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfdocumentHPP
