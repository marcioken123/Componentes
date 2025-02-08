// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSedDocument.pas' rev: 31.00 (Windows)

#ifndef LmdseddocumentHPP
#define LmdseddocumentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Windows.hpp>
#include <System.Types.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDUnicodeEncodings.hpp>
#include <LMDSedUtils.hpp>
#include <LMDHashTable.hpp>
#include <LMDArrayUtils.hpp>
#include <LMDRegExpr.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdseddocument
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDEditDocError;
__interface ILMDMark;
typedef System::DelphiInterface<ILMDMark> _di_ILMDMark;
__interface ILMDMarkers;
typedef System::DelphiInterface<ILMDMarkers> _di_ILMDMarkers;
class DELPHICLASS TLMDEditFindReplaceState;
struct TLMDEditAttributes;
struct TLMDEditParsedToken;
class DELPHICLASS TLMDTokenHandler;
class DELPHICLASS TLMDEditParsedLine;
class DELPHICLASS TLMDEditParserBase;
class DELPHICLASS TLMDDocumentListener;
class DELPHICLASS TLMDDocUndoInfo;
class DELPHICLASS TLMDDocumentInternal;
class DELPHICLASS TLMDEditParserSchemeStrings;
class DELPHICLASS TLMDEditParserSchemeCollectionItem;
class DELPHICLASS TLMDEditParserSchemeCollection;
class DELPHICLASS TLMDEditDocument;
class DELPHICLASS TLMDRegexCharSeqSource;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDEditDocError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDEditDocError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDEditDocError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDEditDocError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDEditDocError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDEditDocError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDEditDocError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDEditDocError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDEditDocError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDEditDocError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDEditDocError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDEditDocError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDEditDocError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDEditDocError(void) { }
	
};

#pragma pack(pop)

__interface  INTERFACE_UUID("{D57D8C11-2B83-4A2D-8091-400AE49E7C1A}") ILMDMark  : public System::IInterface 
{
	virtual int __fastcall get_Pos(void) = 0 ;
	virtual void __fastcall set_Name(Lmdtypes::TLMDString AName) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall get_Name(void) = 0 ;
	virtual void * __fastcall get_Data(void) = 0 ;
	virtual void __fastcall set_Data(void * AData) = 0 ;
	virtual bool __fastcall get_IsValid(void) = 0 ;
	virtual int __fastcall get_Line(void) = 0 ;
	virtual int __fastcall get_Column(void) = 0 ;
	virtual _di_ILMDMarkers __fastcall get_Collection(void) = 0 ;
	virtual void __fastcall NotifyDataChanged(void) = 0 ;
	virtual void __fastcall DeleteFromCollection(void) = 0 ;
	__property int Pos = {read=get_Pos};
	__property Lmdtypes::TLMDString Name = {read=get_Name, write=set_Name};
	__property void * Data = {read=get_Data, write=set_Data};
	__property bool IsValid = {read=get_IsValid};
	__property int Line = {read=get_Line};
	__property int Column = {read=get_Column};
	__property _di_ILMDMarkers Collection = {read=get_Collection};
};

enum DECLSPEC_DENUM TLMDBreakpointKind : unsigned char { mkBreakActive, mkBreakDisabled, mkBreakInactive };

enum DECLSPEC_DENUM TLMDDebugFrameKind : unsigned char { fkFrame, fkFrameTop, fkFrameActive };

typedef _di_ILMDMark ILMDLineMark _DEPRECATED_ATTRIBUTE0 ;

typedef _di_ILMDMarkers ILMDLineMarkers _DEPRECATED_ATTRIBUTE0 ;

typedef TLMDBreakpointKind TLMDLineMarkKind _DEPRECATED_ATTRIBUTE0 ;

typedef System::DynamicArray<_di_ILMDMark> TLMDMarkArray;

typedef TLMDMarkArray TLMDLineMarkArray _DEPRECATED_ATTRIBUTE0 ;

typedef void __fastcall (__closure *TLMDMarkEnumFunction)(_di_ILMDMark AMark, void * AData, bool &StopHere);

__interface  INTERFACE_UUID("{7D9A6443-8CC7-42A5-95EB-84E56884B838}") ILMDMarkers  : public System::IInterface 
{
	virtual TLMDMarkArray __fastcall GetMarksBySegment(int AStart, int ACount) = 0 ;
	virtual int __fastcall GetMarksCountByLines(int AStartLine, int ACount) = 0 ;
	virtual TLMDMarkArray __fastcall GetMarksByLines(int AStartLine, int ACount) = 0 ;
	virtual _di_ILMDMark __fastcall GetLastLineMark(int ALine) = 0 ;
	virtual _di_ILMDMark __fastcall CreateMarkAtLine(int ALine) = 0 ;
	virtual _di_ILMDMark __fastcall CreateMarkAtCol(int ALine, int AColumn) = 0 ;
	virtual _di_ILMDMark __fastcall CreateMarkAtOffset(int AOffset) = 0 ;
	virtual void __fastcall DeleteMark(const _di_ILMDMark AMark) = 0 ;
	virtual void __fastcall DeleteMarksAtLine(int ALine) = 0 ;
	virtual void __fastcall DeleteLastMarkAtLine(int ALine) = 0 ;
	virtual void __fastcall Clear(void) = 0 ;
	virtual int __fastcall get_Count(void) = 0 ;
	__property int Count = {read=get_Count};
	virtual _di_ILMDMark __fastcall Marks(int AIndex) = 0 ;
	virtual _di_ILMDMark __fastcall FindByName(const Lmdtypes::TLMDString AName) = 0 ;
	virtual _di_ILMDMark __fastcall EnumMarkers(TLMDMarkEnumFunction AEnumerator, void * AData = (void *)(0x0)) = 0 ;
	virtual _di_ILMDMark __fastcall EnumMarkersByLines(int AStartLine, int ACount, TLMDMarkEnumFunction AEnumerator, void * AData = (void *)(0x0)) = 0 ;
	virtual _di_ILMDMark __fastcall EnumMarkersByOffset(int AStartOffset, int ACount, TLMDMarkEnumFunction AEnumerator, void * AData = (void *)(0x0)) = 0 ;
};

enum DECLSPEC_DENUM TLMDEditSearchOption : unsigned char { soCaseSensitive, soRegexp, soRegexpSubstitute, soWholeWords, soConfirmReplace };

typedef System::Set<TLMDEditSearchOption, TLMDEditSearchOption::soCaseSensitive, TLMDEditSearchOption::soConfirmReplace> TLMDEditSearchOptions;

enum DECLSPEC_DENUM TLMDEditSearchDirection : unsigned char { sdForward, sdBackward };

enum DECLSPEC_DENUM TLMDEditReplaceAction : unsigned char { raReplaceAuto, raReplacedByCallback, raGoNext, raCancel };

typedef void __fastcall (__closure *TLMDEditReplaceEvent)(System::TObject* Sender, TLMDEditFindReplaceState* const AState, int &ReplacedCount, TLMDEditReplaceAction &Action);

class PASCALIMPLEMENTATION TLMDEditFindReplaceState : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	__fastcall TLMDEditFindReplaceState(void);
	
public:
	Lmdsedutils::TLMDSegment FoundSegment;
	Lmdregexpr::TLMDRegExp* FoundRegex;
	int Start;
	_di_ILMDMark EndM;
	Lmdtypes::TLMDString Pattern;
	Lmdtypes::TLMDString Replacement;
	TLMDEditSearchOptions Options;
	TLMDEditSearchDirection Direction;
	TLMDEditReplaceAction LastReplaceAction;
	TLMDEditReplaceEvent OnReplace;
	System::TObject* Internal;
	__fastcall virtual ~TLMDEditFindReplaceState(void);
};


enum DECLSPEC_DENUM TLMDEditAttributesSetEnum : unsigned char { asBackgroundColor, asTextColor, asFontStyle, asCustomAttributes };

typedef System::Set<TLMDEditAttributesSetEnum, TLMDEditAttributesSetEnum::asBackgroundColor, TLMDEditAttributesSetEnum::asCustomAttributes> TLMDEditAttributesSet;

struct DECLSPEC_DRECORD TLMDEditAttributes
{
public:
	Lmdstrings::TLMDStringHashTable* CustomAttributes;
	System::Uitypes::TColor BackgroundColor;
	System::Uitypes::TColor TextColor;
	System::Uitypes::TFontStyles FontStyle;
	TLMDEditAttributesSet AttributesSet;
};


struct DECLSPEC_DRECORD TLMDEditParsedToken
{
public:
	Lmdsedutils::TLMDSegment Seg;
	TLMDEditAttributes Attrs;
	int TokenID;
};


typedef System::DynamicArray<TLMDEditParsedToken> TLMDEditParsedTokenArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTokenHandler : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall HandleToken(const Lmdsedutils::TLMDSegment &ASeg, int ATokenID, const TLMDEditAttributes &Attributes) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDTokenHandler(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDTokenHandler(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditParsedLine : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual int __fastcall TokenCount(void) = 0 ;
	virtual int __fastcall GetTokenIdx(int ACol) = 0 ;
	virtual int __fastcall GetTokens(int AStart, int ACount, TLMDEditParsedTokenArray &Arr) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDEditParsedLine(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEditParsedLine(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditParserBase : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TLMDEditDocument* FDoc;
	int FMaxLineLengthToParse;
	virtual void __fastcall SetDocument(TLMDEditDocument* ADoc);
	
public:
	__fastcall TLMDEditParserBase(void);
	__fastcall virtual ~TLMDEditParserBase(void);
	virtual TLMDEditDocument* __fastcall GetDocument(void);
	virtual int __fastcall GetFoldLevel(int ALine);
	virtual int __fastcall GetParentLine(int ALine);
	virtual int __fastcall GetFoldEnd(int ALineStart);
	virtual int __fastcall GetFoldStart(int ALineEnd);
	virtual bool __fastcall IsFoldStart(int ALine);
	virtual bool __fastcall IsFoldEnd(int ALine);
	virtual void __fastcall EnsureLineParsed(int ALine);
	__property int MaxLineLengthToParse = {read=FMaxLineLengthToParse, nodefault};
	virtual void __fastcall SetMaxLineLengthToParse(int AValue);
	virtual void __fastcall MarkTokens(int ALine, TLMDTokenHandler* const AHandler);
	virtual TLMDEditParsedLine* __fastcall GetParsedLine(int ALine);
	virtual void __fastcall LineChanged(int ALine);
	virtual void __fastcall LinesChangedFrom(int AStart);
	virtual void __fastcall Refresh(void);
	virtual Lmdtypes::TLMDIntArray __fastcall GetAllTokenIDs(const Lmdtypes::TLMDString ATokenName);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocumentListener : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall BeforeRefresh(void);
	virtual void __fastcall AfterRefresh(void);
	virtual void __fastcall BeforeSettingsRefresh(void);
	virtual void __fastcall AfterSettingsRefresh(void);
	virtual void __fastcall BeforeMarkChange(void);
	virtual void __fastcall MarksDeleting(_di_ILMDMarkers AMarkers, const TLMDMarkArray AMarks);
	virtual void __fastcall MarkCreated(_di_ILMDMarkers AMarkers, const _di_ILMDMark AMark);
	virtual void __fastcall MarkSettingsChanged(_di_ILMDMarkers AMarkers, const _di_ILMDMark AMark);
	virtual void __fastcall AfterMarkChange(void);
	virtual void __fastcall BeforeInsert(int AStart, int ALength);
	virtual void __fastcall AfterInsert(int AStart, int ALength);
	virtual void __fastcall BeforeDelete(int AStart, int ALength);
	virtual void __fastcall AfterDelete(int AStart, int ALength);
	virtual void __fastcall BeforeCompoundEdit(bool AFreezeOnCompoundEdit);
	virtual void __fastcall AfterCompoundEdit(bool AFreezeOnCompoundEdit);
	virtual void __fastcall DoUserEventAfterDocChange(void);
	virtual void __fastcall DocumentDestroing(void);
public:
	/* TObject.Create */ inline __fastcall TLMDDocumentListener(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDocumentListener(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocUndoInfo : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual bool __fastcall Merge(TLMDDocUndoInfo* ANewInfo);
	virtual TLMDDocUndoInfo* __fastcall Clone(void) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDDocUndoInfo(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDocUndoInfo(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocumentInternal : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDEditDocument* FDoc;
	
public:
	__fastcall TLMDDocumentInternal(TLMDEditDocument* ADoc);
	bool __fastcall GetCanRedo(int AAuthorID);
	bool __fastcall GetCanUndo(int AAuthorID);
	void __fastcall Undo(int AAuthorID, TLMDDocUndoInfo* ANewInfo, TLMDDocUndoInfo* &OldInfo);
	void __fastcall Redo(int AAuthorID, TLMDDocUndoInfo* ANewInfo, TLMDDocUndoInfo* &OldInfo);
	void __fastcall InsertSeg(int AIdx, const Lmdsedutils::TLMDSegment &ASeg, int AAuthorID, TLMDDocUndoInfo* AOldInfo, bool ADoFreeSeg);
	void __fastcall InsertStr(int AIdx, const Lmdtypes::TLMDString AStr, int AAuthorID, TLMDDocUndoInfo* AOldInfo);
	void __fastcall Delete(int AStart, int ACount, int AAuthorID, TLMDDocUndoInfo* AOldInfo);
	void __fastcall ReplaceSeg(int AStart, int ACount, const Lmdsedutils::TLMDSegment &ASeg, int AAuthorID, TLMDDocUndoInfo* AOldInfo);
	void __fastcall ReplaceStr(int AStart, int ACount, const Lmdtypes::TLMDString AStr, int AAuthorID, TLMDDocUndoInfo* AOldInfo);
	void __fastcall PushCustomAction(int AAuthorID, TLMDDocUndoInfo* AOldInfo);
	void __fastcall BeginCompoundAction(int AAuthorID, TLMDDocUndoInfo* AOldInfo, bool AFreezeViews);
	int __fastcall GetNextAuthorID(void);
	void __fastcall LockMarkers(void);
	void __fastcall LockChanges(void);
	void __fastcall UnlockMarkers(void);
	void __fastcall UnlockChanges(void);
	void __fastcall AddListener(TLMDDocumentListener* const ALst);
	void __fastcall RemoveListener(TLMDDocumentListener* const ALst);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDocumentInternal(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDEditParserSchemeStrings : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
private:
	TLMDEditParserSchemeCollectionItem* FParent;
	
public:
	__fastcall TLMDEditParserSchemeStrings(TLMDEditParserSchemeCollectionItem* AParent);
	__property TLMDEditParserSchemeCollectionItem* Parent = {read=FParent, write=FParent};
public:
	/* TStringList.Destroy */ inline __fastcall virtual ~TLMDEditParserSchemeStrings(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditParserSchemeCollectionItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDEditParserSchemeStrings* FScheme;
	System::UnicodeString FName;
	void __fastcall SetScheme(TLMDEditParserSchemeStrings* AScheme);
	void __fastcall SetName(const System::UnicodeString AName);
	void __fastcall SchemeChange(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TLMDEditParserSchemeCollectionItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDEditParserSchemeCollectionItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property TLMDEditParserSchemeStrings* Scheme = {read=FScheme, write=SetScheme};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditParserSchemeCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDEditParserSchemeCollectionItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDEditDocument* FParent;
	void __fastcall CheckSetSchemeName(const System::UnicodeString AName);
	HIDESBASE TLMDEditParserSchemeCollectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDEditParserSchemeCollectionItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDEditParserSchemeCollection(TLMDEditDocument* AParent);
	void __fastcall LoadFromFiles(const Lmdtypes::TLMDString *AFiles, const int AFiles_High);
	void __fastcall LoadFromDirectory(System::UnicodeString ADir, System::UnicodeString AFileExt);
	TLMDEditParserSchemeCollectionItem* __fastcall FindItem(const Lmdtypes::TLMDString AName);
	HIDESBASE TLMDEditParserSchemeCollectionItem* __fastcall Add(void);
	HIDESBASE TLMDEditParserSchemeCollectionItem* __fastcall Insert(int Index);
	__property TLMDEditParserSchemeCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TLMDEditDocument* Parent = {read=FParent, write=FParent};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDEditParserSchemeCollection(void) { }
	
};

#pragma pack(pop)

typedef Lmdtypes::TLMDString TLMDSyntaxSchemeRef;

typedef Lmdtypes::TLMDString TLMDColorSchemeRef;

typedef int TLMDCodePageRef;

enum DECLSPEC_DENUM TLMDLineSeparator : unsigned char { lsCR, lsLF, lsCRLF };

typedef void __fastcall (__closure *TLMDMarkEvent)(TLMDEditDocument* Sender, _di_ILMDMarkers ACollection, const _di_ILMDMark AMark);

enum DECLSPEC_DENUM TLMDDocStatusChange : unsigned char { dcInsert, dcDelete, dcCompoundChange, dcMarkersCreated, dcMarkSettingsChanged, dcMarkersDeleted, dcCodePagePropsChanged, dcModifiedPropertyChanged };

typedef System::Set<TLMDDocStatusChange, TLMDDocStatusChange::dcInsert, TLMDDocStatusChange::dcModifiedPropertyChanged> TLMDDocStatusChanges;

typedef void __fastcall (__closure *TLMDDocChangedEvent)(TLMDEditDocument* Sender, TLMDDocStatusChanges AChanges);

typedef void __fastcall (__closure *TLMDDocLinesChanged)(TLMDEditDocument* Sender, int AFirstLine, int ACount);

class PASCALIMPLEMENTATION TLMDEditDocument : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	int FLastAuthorID;
	TLMDLineSeparator FLineSeparator;
	Lmdtypes::TLMDString FLineSeparatorStr;
	System::TObject* FStorage;
	System::TObject* FStorageLst;
	System::TObject* FLineManager;
	System::TObject* FUndoManager;
	TLMDDocumentInternal* FInternal;
	System::TObject* FMarkManager;
	_di_ILMDMarkers FBookmarks;
	_di_ILMDMarkers FBreakpoints;
	_di_ILMDMarkers FDebugFrameLines;
	System::Classes::TStrings* FLines;
	TLMDEditParserSchemeCollection* FSyntaxSchemes;
	TLMDEditParserSchemeCollection* FColorSchemes;
	TLMDSyntaxSchemeRef FSyntaxScheme;
	TLMDColorSchemeRef FColorScheme;
	System::Classes::TList* FListeners;
	System::Classes::TList* FCustomListeners;
	TLMDEditParserBase* FParser;
	int FCompoundEditCnt;
	bool FInUndo;
	bool FReadOnly;
	int FChangesLockCnt;
	int FMarkersLockCnt;
	TLMDDocStatusChanges FChanges;
	Lmdtypes::TLMDString FWordSeparators;
	Lmdtypes::TLMDString FFullWordSeparators;
	int FDelayedEventLock;
	TLMDMarkEvent FOnMarkDeleting;
	TLMDMarkEvent FOnMarkCreating;
	TLMDDocChangedEvent FOnDocChanged;
	bool FModified;
	bool FModifiedFixed;
	int FUndoCountNoMod;
	bool FInConstructor;
	Lmdunicodeencodings::TLMDEncoding* FEncoding;
	bool FCodePageUsePreamble;
	TLMDDocLinesChanged FOnLinesChanged;
	bool __fastcall GetCanRedo(int AAuthorID);
	bool __fastcall GetCanUndo(int AAuthorID);
	void __fastcall UndoLow(int AAuthorID, TLMDDocUndoInfo* ANewInfo, TLMDDocUndoInfo* &OldInfo);
	void __fastcall RedoLow(int AAuthorID, TLMDDocUndoInfo* ANewInfo, TLMDDocUndoInfo* &OldInfo);
	bool __fastcall InsideCRLF_LF(int AOffset);
	bool __fastcall InsideCRLF_CR(int AOffset);
	void __fastcall InsertSegLow(int AStart, const Lmdsedutils::TLMDSegment &ASeg, int AAuthorID, TLMDDocUndoInfo* AOldInfo, bool ADoFreeSeg);
	void __fastcall InsertStrLow(int AStart, Lmdtypes::TLMDString AStr, int AAuthorID, TLMDDocUndoInfo* AOldInfo);
	void __fastcall DeleteLow(int AStart, int ACount, int AAuthorID, TLMDDocUndoInfo* AOldInfo);
	void __fastcall ReplaceSegLow(int AStart, int ACount, const Lmdsedutils::TLMDSegment &ASeg, int AAuthorID, TLMDDocUndoInfo* AOldInfo);
	void __fastcall ReplaceStrLow(int AStart, int ACount, const Lmdtypes::TLMDString AStr, int AAuthorID, TLMDDocUndoInfo* AOldInfo);
	void __fastcall PushCustomAction(int AAuthorID, TLMDDocUndoInfo* AOldInfo);
	void __fastcall BeginCompoundAction(int AAuthorID, TLMDDocUndoInfo* AOldInfo, bool AFreezeViews);
	int __fastcall GetNextAuthorID(void);
	void __fastcall LockMarkers(void);
	void __fastcall LockChanges(void);
	void __fastcall UnlockMarkers(void);
	void __fastcall UnlockChanges(void);
	Lmdtypes::TLMDString __fastcall LoadSyntaxFromColl(const Lmdtypes::TLMDString ASchemeName);
	Lmdtypes::TLMDString __fastcall LoadColorFromColl(const Lmdtypes::TLMDString ASchemeName);
	void __fastcall FireBeforeRefresh(void);
	void __fastcall FireAfterRefresh(void);
	void __fastcall FireBeforeSettingsRefresh(void);
	void __fastcall FireAfterSettingsRefresh(void);
	TLMDDocumentListener* __fastcall GetLst(int i);
	TLMDDocumentListener* __fastcall GetCustLst(int i);
	void __fastcall FireDestroing(void);
	void __fastcall DoBeforeMarkChange(void);
	void __fastcall DoAfterMarkChange(void);
	void __fastcall FireMarksDeleting(_di_ILMDMarkers AMarkers, TLMDMarkArray AMarks);
	void __fastcall FireMarkCreated(_di_ILMDMarkers AMarkers, _di_ILMDMark AMark);
	void __fastcall FireMarkSettingsChanged(_di_ILMDMarkers AMarkers, _di_ILMDMark AMark);
	void __fastcall FireBeforeInsert(int AStart, int ACount);
	void __fastcall FireAfterInsert(int AStart, int ACount);
	void __fastcall FireBeforeDelete(int AStart, int ACount);
	void __fastcall FireAfterDelete(int AStart, int ACount);
	void __fastcall FireBeforeCompoundEdit(bool AFreezeViews);
	void __fastcall FireAfterCompoundEdit(bool AFreezeViews);
	void __fastcall FireParser(int AFirstLine, int ACount);
	void __fastcall CheckSyntaxSchemeName(Lmdtypes::TLMDString ASchemeName);
	void __fastcall CheckColorSchemeName(Lmdtypes::TLMDString ASchemeName);
	void __fastcall CheckLoadingSyntaxSchemeName(Lmdtypes::TLMDString ASchemeName);
	void __fastcall CheckLoadingColorSchemeName(Lmdtypes::TLMDString ASchemeName);
	void __fastcall CheckNotUpdating(void);
	void __fastcall CheckChangesLock(void);
	void __fastcall CheckReadOnly(void);
	void __fastcall CheckMarkersLock(void);
	void __fastcall CheckCanUndoRedo(bool AUndo, int AAuthorID);
	void __fastcall CheckInCompoundEdit(void);
	void __fastcall CheckCustomMarkersValid(System::_di_IInterface AMarkers);
	void __fastcall CheckSegValid(const Lmdsedutils::TLMDSegment &ASeg);
	void __fastcall CheckOffset(int AOffset);
	void __fastcall CheckSearchOffset(int AOffset);
	void __fastcall CheckInsOffset(int AOffset);
	void __fastcall CheckLineIdx(int ALine);
	void __fastcall CheckLineIdxCol(int ALine, int AColumn);
	void __fastcall SetUndoLimit(int ALimit);
	int __fastcall GetUndoLimit(void);
	void __fastcall SetWordSeparators(const Lmdtypes::TLMDString ASep);
	void __fastcall SetLineSeparator(TLMDLineSeparator ASep);
	void __fastcall SetSyntaxSchemes(TLMDEditParserSchemeCollection* ASchemes);
	void __fastcall SetColorSchemes(TLMDEditParserSchemeCollection* ASchemes);
	void __fastcall UpdateActiveSchemes(void);
	void __fastcall AllSchemesChanged(void);
	void __fastcall SchemeChanged(TLMDEditParserSchemeCollectionItem* AScheme);
	void __fastcall SetActiveSyntaxScheme(TLMDSyntaxSchemeRef ASchemeName);
	void __fastcall SetActiveColorScheme(TLMDColorSchemeRef ASchemeName);
	void __fastcall SetLines(System::Classes::TStrings* ALines);
	int __fastcall GetMaxLineLengthToParse(void);
	void __fastcall SetMaxLineLengthToParse(int AValue);
	void __fastcall RefreshWithSettings(void);
	void __fastcall StorageBeforeRefresh(void);
	void __fastcall StorageAfterRefresh(void);
	Lmdsedutils::TLMDSegment __fastcall GetLine(int ALine);
	Lmdtypes::TLMDString __fastcall GetLineStr(int ALine);
	bool __fastcall IsWordSeparatorsStored(void);
	Lmdtypes::TLMDString __fastcall GetSep(const Lmdtypes::TLMDString ASep);
	int __fastcall FindNearWordStart(int AOffset, int AMaxCount, bool ABackward, bool AAllowOffset, const Lmdtypes::TLMDString ASeparators);
	int __fastcall FindNearWordEnd(int AOffset, int AMaxCount, bool ABackward, bool AAllowOffset, const Lmdtypes::TLMDString ASeparators);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	void __fastcall SetParser(TLMDEditParserBase* const AParser);
	Lmdsedutils::TLMDCharSeq* __fastcall GetChars(void);
	int __fastcall GetCharsCount(void);
	int __fastcall GetLinesCount(void);
	bool __fastcall GetCanUndoProp(void);
	bool __fastcall GetCanRedoProp(void);
	bool __fastcall GetInsideCompoundEdit(void);
	void __fastcall SetReadOnly(bool AReadOnly);
	TLMDCodePageRef __fastcall GetCodePage(void);
	void __fastcall SetCodePage(const TLMDCodePageRef Value);
	System::UnicodeString __fastcall GetCodePageName(void);
	void __fastcall SetCodePageName(const System::UnicodeString Value);
	void __fastcall SetCodePageUsePreamble(const bool Value);
	void __fastcall ResetChanges(void);
	void __fastcall ResetModified(void);
	void __fastcall SetModFixed(void);
	void __fastcall SetModifiedByChange(void);
	void __fastcall SetModifiedByUndoRedo(void);
	void __fastcall SetUndoCountNoMod(void);
	bool __fastcall GetModified(void);
	void __fastcall SetModified(const bool Value);
	void __fastcall AddInternalListener(TLMDDocumentListener* const ALst);
	void __fastcall RemoveInternalListener(TLMDDocumentListener* const ALst);
	bool __fastcall FindPatternNextLow(int ANewStart, TLMDEditFindReplaceState* AState, bool AFirstTime);
	bool __fastcall ReplacePatternNextLow(int ANewStart, TLMDEditFindReplaceState* AState, bool AFirstTime);
	TLMDMarkEvent __fastcall GetOnLineMarkCreating _DEPRECATED_ATTRIBUTE0 (void);
	TLMDMarkEvent __fastcall GetOnLineMarkDeleting _DEPRECATED_ATTRIBUTE0 (void);
	
protected:
	TLMDDocumentInternal* __fastcall GetInternal(void);
	virtual void __fastcall DoLinesChanged(int AFirstLine, int ACount);
	
public:
	__fastcall virtual TLMDEditDocument(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDEditDocument(void);
	Lmdtypes::TLMDString __fastcall GetFullWordSeparators(void);
	__property Lmdtypes::TLMDString LineSeparatorStr = {read=FLineSeparatorStr};
	__property Lmdsedutils::TLMDCharSeq* Chars = {read=GetChars};
	__property int CharsCount = {read=GetCharsCount, nodefault};
	__property int LinesCount = {read=GetLinesCount, nodefault};
	__property Lmdsedutils::TLMDSegment LineSegments[int ALine] = {read=GetLine};
	TLMDEditParserBase* __fastcall GetParser(void);
	__property _di_ILMDMarkers Bookmarks = {read=FBookmarks};
	__property _di_ILMDMarkers Breakpoints = {read=FBreakpoints};
	__property _di_ILMDMarkers DebugFrameLines = {read=FDebugFrameLines};
	TLMDBreakpointKind __fastcall GetBreakpointKind(const _di_ILMDMark ABreak);
	void __fastcall SetBreakpointKind(const _di_ILMDMark ABreak, TLMDBreakpointKind AKind);
	TLMDDebugFrameKind __fastcall GetDebugFrameKind(const _di_ILMDMark AFrameMark);
	void __fastcall SetDebugFrameKind(const _di_ILMDMark AFrameMark, TLMDDebugFrameKind AKind);
	_di_ILMDMarkers __fastcall CreateCustomMarkers(bool AKeepMarks, bool ALineBound, bool AProduceEvents);
	_di_ILMDMarkers __fastcall CreateCustomLineMarkers _DEPRECATED_ATTRIBUTE0 (bool AKeepMarks, bool AProduceEvents);
	void __fastcall DetachCustomMarkers(_di_ILMDMarkers AMarkers);
	void __fastcall BeginCompoundEdit(bool AFreezeViews = true);
	void __fastcall EndCompoundEdit(bool AFreezeViews = true);
	__property bool InsideCompoundEdit = {read=GetInsideCompoundEdit, nodefault};
	void __fastcall InsertSeg(int AStart, const Lmdsedutils::TLMDSegment &ASeg);
	void __fastcall ReplaceSeg(int AStart, int ACount, const Lmdsedutils::TLMDSegment &ASeg);
	HIDESBASE void __fastcall Insert(int AStart, const Lmdtypes::TLMDString AStr);
	void __fastcall InsertLine(int ALine, const Lmdtypes::TLMDString AStr);
	void __fastcall AppendLine(const Lmdtypes::TLMDString AStr);
	void __fastcall Replace(int AStart, int ACount, const Lmdtypes::TLMDString AStr);
	void __fastcall Delete(int AStart, int ACount);
	void __fastcall DeleteLine(int ALine);
	int __fastcall GetLineByOffset(int AOffset);
	Lmdsedutils::TLMDSegment __fastcall GetLineWithCr(int ALine);
	bool __fastcall GetLineEndKind(int ALine, /* out */ TLMDLineSeparator &Res);
	void __fastcall Clear(void);
	void __fastcall ClearNoUndo(void);
	void __fastcall Undo(void);
	void __fastcall Redo(void);
	void __fastcall ClearUndo(void);
	__property bool CanUndo = {read=GetCanUndoProp, nodefault};
	__property bool CanRedo = {read=GetCanRedoProp, nodefault};
	__property bool Modified = {read=GetModified, write=SetModified, nodefault};
	__property System::UnicodeString CodePageName = {read=GetCodePageName, write=SetCodePageName};
	Lmdsedutils::TLMDSegment __fastcall FindNextWord(int AOffset, int AMaxCount, const Lmdtypes::TLMDString ASeparators = Lmdtypes::TLMDString());
	Lmdsedutils::TLMDSegment __fastcall FindPrevWord(int AOffset, int AMaxCount, const Lmdtypes::TLMDString ASeparators = Lmdtypes::TLMDString());
	int __fastcall FindNextWordStart(int AOffset, int AMaxCount, const Lmdtypes::TLMDString ASeparators = Lmdtypes::TLMDString());
	int __fastcall FindPrevWordStart(int AOffset, int AMaxCount, const Lmdtypes::TLMDString ASeparators = Lmdtypes::TLMDString());
	int __fastcall FindNextWordEnd(int AOffset, int AMaxCount, const Lmdtypes::TLMDString ASeparators = Lmdtypes::TLMDString());
	int __fastcall FindPrevWordEnd(int AOffset, int AMaxCount, const Lmdtypes::TLMDString ASeparators = Lmdtypes::TLMDString());
	Lmdsedutils::TLMDSegment __fastcall FindNearWord(int AOffset, int AMaxCount, bool ABackward, const Lmdtypes::TLMDString ASeparators = Lmdtypes::TLMDString());
	TLMDEditFindReplaceState* __fastcall FindPatternFirst(int AOffset, const Lmdtypes::TLMDString APattern)/* overload */;
	TLMDEditFindReplaceState* __fastcall FindPatternFirst(int AOffset, const Lmdtypes::TLMDString APattern, TLMDEditSearchOptions AOpts)/* overload */;
	TLMDEditFindReplaceState* __fastcall FindPatternFirst(int AOffset, int AMaxCount, const Lmdtypes::TLMDString APattern, TLMDEditSearchOptions AOpts)/* overload */;
	TLMDEditFindReplaceState* __fastcall FindPatternFirst(int AOffset, int AMaxCount, const Lmdtypes::TLMDString APattern, TLMDEditSearchOptions AOpts, TLMDEditSearchDirection ADirection)/* overload */;
	bool __fastcall FindPatternNext(int ANewStart, TLMDEditFindReplaceState* AState)/* overload */;
	bool __fastcall FindPatternNext(TLMDEditFindReplaceState* AState)/* overload */;
	void __fastcall FindPatternClose(TLMDEditFindReplaceState* AState);
	TLMDEditFindReplaceState* __fastcall ReplacePatternFirst(int AOffset, const Lmdtypes::TLMDString APattern, const Lmdtypes::TLMDString AReplacement, TLMDEditSearchOptions AOpts)/* overload */;
	TLMDEditFindReplaceState* __fastcall ReplacePatternFirst(int AOffset, int AMaxCount, const Lmdtypes::TLMDString APattern, const Lmdtypes::TLMDString AReplacement, TLMDEditSearchOptions AOpts)/* overload */;
	TLMDEditFindReplaceState* __fastcall ReplacePatternFirst(int AOffset, int AMaxCount, const Lmdtypes::TLMDString APattern, const Lmdtypes::TLMDString AReplacement, TLMDEditSearchOptions AOpts, TLMDEditSearchDirection ADirection)/* overload */;
	TLMDEditFindReplaceState* __fastcall ReplacePatternFirst(int AOffset, int AMaxCount, const Lmdtypes::TLMDString APattern, const Lmdtypes::TLMDString AReplacement, TLMDEditSearchOptions AOpts, TLMDEditSearchDirection ADirection, TLMDEditReplaceEvent AReplaceCallback)/* overload */;
	bool __fastcall ReplacePatternNext(TLMDEditFindReplaceState* AState)/* overload */;
	bool __fastcall ReplacePatternNext(int ANewStart, TLMDEditFindReplaceState* AState)/* overload */;
	void __fastcall ReplacePatternClose(TLMDEditFindReplaceState* AState);
	TLMDEditFindReplaceState* __fastcall ReplacePatternAll(const Lmdtypes::TLMDString APattern, const Lmdtypes::TLMDString AReplacement)/* overload */;
	TLMDEditFindReplaceState* __fastcall ReplacePatternAll(const Lmdtypes::TLMDString APattern, const Lmdtypes::TLMDString AReplacement, TLMDEditSearchOptions AOpts)/* overload */;
	TLMDEditFindReplaceState* __fastcall ReplacePatternAll(int AOffset, const Lmdtypes::TLMDString APattern, const Lmdtypes::TLMDString AReplacement)/* overload */;
	TLMDEditFindReplaceState* __fastcall ReplacePatternAll(int AOffset, const Lmdtypes::TLMDString APattern, const Lmdtypes::TLMDString AReplacement, TLMDEditSearchOptions AOpts)/* overload */;
	TLMDEditFindReplaceState* __fastcall ReplacePatternAll(int AOffset, int AMaxCount, const Lmdtypes::TLMDString APattern, const Lmdtypes::TLMDString AReplacement, TLMDEditSearchOptions AOpts)/* overload */;
	TLMDEditFindReplaceState* __fastcall ReplacePatternAll(int AOffset, int AMaxCount, const Lmdtypes::TLMDString APattern, const Lmdtypes::TLMDString AReplacement, TLMDEditSearchOptions AOpts, TLMDEditSearchDirection ADirection, TLMDEditReplaceEvent AReplaceCallback)/* overload */;
	void __fastcall LoadFromFile(const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall LoadFromFile(const Lmdtypes::TLMDString AFileName, int ACodePage)/* overload */;
	void __fastcall LoadFromFile(const Lmdtypes::TLMDString AFileName, int ADefaultCodePage, bool AUnicodeAutodetect)/* overload */;
	void __fastcall LoadFromStream(System::Classes::TStream* Stream)/* overload */;
	void __fastcall LoadFromStream(System::Classes::TStream* Stream, int ACodePage)/* overload */;
	void __fastcall LoadFromStream(System::Classes::TStream* Stream, int ADefaultCodePage, bool AUnicodeAutodetect)/* overload */;
	void __fastcall SaveToFile(const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SaveToFile(const Lmdtypes::TLMDString AFileName, int ACodePage)/* overload */;
	void __fastcall SaveToFile(const Lmdtypes::TLMDString AFileName, int ACodePage, bool AUsePreamble)/* overload */;
	void __fastcall SaveToStream(System::Classes::TStream* AStream)/* overload */;
	void __fastcall SaveToStream(System::Classes::TStream* AStream, int ACodePage)/* overload */;
	void __fastcall SaveToStream(System::Classes::TStream* AStream, int ACodePage, bool AUsePreamble)/* overload */;
	void __fastcall AddListener(TLMDDocumentListener* const ALst);
	void __fastcall RemoveListener(TLMDDocumentListener* const ALst);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(bool AWithEvent = true);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
	__property TLMDCodePageRef CodePage = {read=GetCodePage, write=SetCodePage, default=0};
	__property bool CodePageUsePreamble = {read=FCodePageUsePreamble, write=SetCodePageUsePreamble, default=0};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property int UndoLimit = {read=GetUndoLimit, write=SetUndoLimit, default=1024};
	__property Lmdtypes::TLMDString WordSeparators = {read=FWordSeparators, write=SetWordSeparators, stored=IsWordSeparatorsStored};
	__property TLMDLineSeparator LineSeparator = {read=FLineSeparator, write=SetLineSeparator, default=2};
	__property TLMDEditParserSchemeCollection* SyntaxSchemes = {read=FSyntaxSchemes, write=SetSyntaxSchemes};
	__property TLMDEditParserSchemeCollection* ColorSchemes = {read=FColorSchemes, write=SetColorSchemes};
	__property TLMDSyntaxSchemeRef ActiveSyntaxScheme = {read=FSyntaxScheme, write=SetActiveSyntaxScheme};
	__property TLMDColorSchemeRef ActiveColorScheme = {read=FColorScheme, write=SetActiveColorScheme};
	__property int MaxLineLengthToParse = {read=GetMaxLineLengthToParse, write=SetMaxLineLengthToParse, default=1000};
	__property TLMDMarkEvent OnMarkDeleting = {read=FOnMarkDeleting, write=FOnMarkDeleting};
	__property TLMDMarkEvent OnMarkCreating = {read=FOnMarkCreating, write=FOnMarkCreating};
	__property TLMDMarkEvent OnLineMarkDeleting = {read=GetOnLineMarkDeleting, write=FOnMarkDeleting};
	__property TLMDMarkEvent OnLineMarkCreating = {read=GetOnLineMarkCreating, write=FOnMarkCreating};
	__property TLMDDocLinesChanged OnLinesChanged = {read=FOnLinesChanged, write=FOnLinesChanged};
	__property TLMDDocChangedEvent OnDocChanged = {read=FOnDocChanged, write=FOnDocChanged};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRegexCharSeqSource : public Lmdregexpr::TLMDRegexSource
{
	typedef Lmdregexpr::TLMDRegexSource inherited;
	
protected:
	Lmdsedutils::TLMDCharSeq* FSeq;
	virtual void __fastcall FillBuffer(void);
	
public:
	virtual void __fastcall ResetBuffer(void);
	__fastcall TLMDRegexCharSeqSource(Lmdsedutils::TLMDCharSeq* const ASeq);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRegexCharSeqSource(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Word LMDDefaultUndoLimit = System::Word(0x400);
static const System::Word MAX_LINE_LENGTH_TO_PARSE = System::Word(0x3e8);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDDefaultWordSeparators(void);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDAllLineSeparators(void);
}	/* namespace Lmdseddocument */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEDDOCUMENT)
using namespace Lmdseddocument;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdseddocumentHPP
