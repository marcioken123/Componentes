// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctImporterUnitDoc.pas' rev: 31.00 (Windows)

#ifndef LmdsctimporterunitdocHPP
#define LmdsctimporterunitdocHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Math.hpp>
#include <LMDTypes.hpp>
#include <LMDHashTable.hpp>
#include <LMDXML.hpp>
#include <LMDSctImporterFileUtils.hpp>
#include <LMDSctImporterParser.hpp>
#include <LMDSctImporterTree.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctimporterunitdoc
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ILMDUnitDocNotifier;
class DELPHICLASS ILMDUnitDocSourceProvider;
class DELPHICLASS ILMDUnitDocEnvironment;
struct TLMDUnitDocNodeHint;
class DELPHICLASS TLMDUnitDocNodeData;
class DELPHICLASS TLMDUnitDocIterateContext;
struct TLMDUnitDocMessage;
class DELPHICLASS TLMDUnitDocument;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDUnitDocNotifier : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall Modified(TLMDUnitDocument* Sender) = 0 ;
	virtual void __fastcall AnalizeProgress(TLMDUnitDocument* Sender, int ADeclsCount, int AAnalizedCount) = 0 ;
	virtual bool __fastcall PreprocessUsedUnit(TLMDUnitDocument* Sender, const System::UnicodeString AUnitName, /* out */ System::UnicodeString &AUSUPath) = 0 ;
	virtual void __fastcall UsedElemReferenced(TLMDUnitDocument* Sender, const System::UnicodeString AUnitName, const System::UnicodeString AElemFullName) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDUnitDocNotifier(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDUnitDocNotifier(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDUnitDocSourceProvider : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetSource(void) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDUnitDocSourceProvider(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDUnitDocSourceProvider(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDUnitDocEnvironment : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall MakeStandardDefines(Lmdsctimporterparser::TLMDPasParser* AParser) = 0 ;
	virtual void __fastcall GetLibPaths(System::Classes::TStrings* AResult) = 0 ;
	virtual System::UnicodeString __fastcall GetVCLImportSubpath(void) = 0 ;
	virtual void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult) = 0 ;
	virtual void __fastcall GetNamespacePrefixes(System::Classes::TStrings* AResult) = 0 ;
	virtual bool __fastcall FindDirectiveConst(const System::UnicodeString AConstName, /* out */ System::Variant &AValue) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDUnitDocEnvironment(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDUnitDocEnvironment(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDUnitDocNodeHint
{
public:
	bool IsSpecified;
	System::UnicodeString ConstTypeRepl;
	bool OverloadChecked;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnitDocNodeData : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__fastcall TLMDUnitDocNodeData(void);
	Lmdsctimportertree::TLMDPasNamedNode* Node;
	System::UnicodeString FullName;
	bool Checked;
	System::UnicodeString ConstTypeRepl;
	TLMDUnitDocNodeHint Hint;
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUnitDocNodeData(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDUnitDocIterateProc)(TLMDUnitDocIterateContext* C, Lmdsctimportertree::TLMDPasNamedNode* ANode, void * AData);

class PASCALIMPLEMENTATION TLMDUnitDocIterateContext : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdsctimportertree::TLMDPasNamedNode* FNode;
	TLMDUnitDocIterateProc FProc;
	void __fastcall IterateNodes(Lmdsctimportertree::TLMDPasNamedNodes* ANodes, void * AData);
	
public:
	void __fastcall IterateChildren(void * AData);
public:
	/* TObject.Create */ inline __fastcall TLMDUnitDocIterateContext(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUnitDocIterateContext(void) { }
	
};


enum DECLSPEC_DENUM TLMDUnitDocMessageKind : unsigned char { mkUnknown, mkParseError, mkInfo, mkWarning, mkError };

struct DECLSPEC_DRECORD TLMDUnitDocMessage
{
public:
	TLMDUnitDocMessageKind Kind;
	System::UnicodeString Text;
	System::UnicodeString FileName;
	Lmdsctimportertree::TLMDPasNamedNode* Node;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnitDocument : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TLMDUnitDocMessage> _TLMDUnitDocument__1;
	
	
private:
	ILMDUnitDocEnvironment* FEnv;
	bool FParsed;
	Lmdsctimportertree::TLMDPasUnit* FParseTree;
	Lmdhashtable::TLMDHashTable* FDataItems;
	_TLMDUnitDocument__1 FMessages;
	int FMessageCount;
	System::Classes::TList* FNotifiers;
	Lmdsctimporterfileutils::TLMDFileHandler* FFileHandler;
	bool FIsSysLibDoc;
	bool FLastAnalizeSucceds;
	bool FIsLocked;
	int FAnalizedDeclsCount;
	ILMDUnitDocSourceProvider* FSourceProvider;
	bool FGenAdditionalInfo;
	System::UnicodeString __fastcall GetUnitPath(void);
	System::UnicodeString __fastcall GetWrapperUnitPath(void);
	System::UnicodeString __fastcall GetUSUPath(void);
	bool __fastcall GetNodeChecked(Lmdsctimportertree::TLMDPasNamedNode* ANode);
	void __fastcall SetNodeChecked(Lmdsctimportertree::TLMDPasNamedNode* ANode, bool AValue);
	System::UnicodeString __fastcall GetNodeFullName(Lmdsctimportertree::TLMDPasNamedNode* ANode);
	System::UnicodeString __fastcall GetNodeHint(Lmdsctimportertree::TLMDPasNamedNode* ANode);
	System::UnicodeString __fastcall GetConstTypeRepl(Lmdsctimportertree::TLMDPasConstDecl* ANode);
	void __fastcall SetConstTypeRepl(Lmdsctimportertree::TLMDPasConstDecl* ANode, const System::UnicodeString AValue);
	void __fastcall SetIsLocked(const bool Value);
	void __fastcall SetIsSysLibDoc(const bool Value);
	bool __fastcall FindDirectiveConstProc(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);
	int __fastcall GetMessageCount(void);
	TLMDUnitDocMessage __fastcall GetMessages(int Index);
	void __fastcall SaveItemProc(System::TObject* AItem, void * AUserData);
	void __fastcall SaveHintsProc(System::TObject* AItem, void * AUserData);
	void __fastcall ClearHintsProc(System::TObject* AItem);
	void __fastcall ApplyHintsProc(System::TObject* AItem);
	void __fastcall AssociateProc(TLMDUnitDocIterateContext* C, Lmdsctimportertree::TLMDPasNamedNode* ANode, void * AData);
	void __fastcall DissociateItemProc(System::TObject* AItem);
	void __fastcall UncheckErrorsProc(System::TObject* AItem);
	
protected:
	void __fastcall AnalizeProgress(void);
	bool __fastcall PreprocessUsedUnit(const System::UnicodeString AUnitName, /* out */ System::UnicodeString &AUSUPath);
	void __fastcall UsedElemReferenced(const System::UnicodeString AUnitName, const System::UnicodeString AElemFullName);
	void __fastcall AddMessage(const TLMDUnitDocMessage &M);
	void __fastcall ClearMessages(void);
	void __fastcall FreeParseTree(void);
	bool __fastcall DoParse(void);
	bool __fastcall DoAnalize(void);
	void __fastcall DoGenerate(void);
	void __fastcall DoApplyHint(TLMDUnitDocNodeData* AItem);
	System::UnicodeString __fastcall LoadSourceFromFile(const System::UnicodeString AFilePath);
	System::UnicodeString __fastcall GetSource(void);
	void __fastcall LoadState(void);
	void __fastcall SaveState(void);
	void __fastcall SaveAsUsedUnit(void);
	TLMDUnitDocNodeData* __fastcall FindDataItem(const System::UnicodeString AFullName);
	TLMDUnitDocNodeData* __fastcall GetNodeData(Lmdsctimportertree::TLMDPasNamedNode* ANode);
	void __fastcall DissociateData(void);
	void __fastcall AssociateData(void);
	
public:
	__fastcall TLMDUnitDocument(const System::UnicodeString AUnitFilePath, ILMDUnitDocEnvironment* AEnv, ILMDUnitDocSourceProvider* ASourceProvider, bool AMakeAnalize);
	__fastcall virtual ~TLMDUnitDocument(void);
	void __fastcall Reload(bool AMakeAnalize = true);
	void __fastcall Save(void);
	void __fastcall Renamed(const System::UnicodeString ANewUnitPath);
	void __fastcall MarkModified(void);
	bool __fastcall Parse(void);
	bool __fastcall Analize(bool GenWrapperFile);
	Lmdsctimportertree::TLMDPasNamedNode* __fastcall FindNode(const System::UnicodeString AFullName);
	void __fastcall UncheckNodesWithErrors(void);
	void __fastcall MarkUnparsed(void);
	void __fastcall Iterate(TLMDUnitDocIterateProc AProc, void * AData);
	void __fastcall SaveHints(const Lmdxml::_di_ILMDXmlDocument AXml);
	void __fastcall LoadHints(const Lmdxml::_di_ILMDXmlDocument AXml);
	void __fastcall ApplyHint(Lmdsctimportertree::TLMDPasNamedNode* ANode);
	void __fastcall ApplyAllHints(void);
	void __fastcall AddNotifier(ILMDUnitDocNotifier* ANotifier);
	void __fastcall RemoveNotifier(ILMDUnitDocNotifier* ANotifier);
	void __fastcall GetStandardWrapperUsedUnits(System::Classes::TStrings* AResult);
	__property Lmdsctimporterfileutils::TLMDFileHandler* FileHandler = {read=FFileHandler};
	__property System::UnicodeString UnitPath = {read=GetUnitPath};
	__property System::UnicodeString WrapperUnitPath = {read=GetWrapperUnitPath};
	__property System::UnicodeString USUPath = {read=GetUSUPath};
	__property bool Parsed = {read=FParsed, nodefault};
	__property Lmdsctimportertree::TLMDPasUnit* ParseTree = {read=FParseTree};
	__property bool NodeChecked[Lmdsctimportertree::TLMDPasNamedNode* ANode] = {read=GetNodeChecked, write=SetNodeChecked};
	__property System::UnicodeString NodeFullName[Lmdsctimportertree::TLMDPasNamedNode* ANode] = {read=GetNodeFullName};
	__property System::UnicodeString NodeHint[Lmdsctimportertree::TLMDPasNamedNode* ANode] = {read=GetNodeHint};
	__property System::UnicodeString ConstTypeRepl[Lmdsctimportertree::TLMDPasConstDecl* ANode] = {read=GetConstTypeRepl, write=SetConstTypeRepl};
	__property bool IsSysLibDoc = {read=FIsSysLibDoc, write=SetIsSysLibDoc, nodefault};
	__property bool IsLocked = {read=FIsLocked, write=SetIsLocked, nodefault};
	__property bool GenAdditionalInfo = {read=FGenAdditionalInfo, write=FGenAdditionalInfo, nodefault};
	__property TLMDUnitDocMessage Messages[int Index] = {read=GetMessages};
	__property int MessageCount = {read=GetMessageCount, nodefault};
	__property bool LastAnalizeSucceds = {read=FLastAnalizeSucceds, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall SaveStringToStream(System::Classes::TStream* AStream, System::UnicodeString AValue);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LoadStringFromStream(System::Classes::TStream* AStream);
}	/* namespace Lmdsctimporterunitdoc */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTIMPORTERUNITDOC)
using namespace Lmdsctimporterunitdoc;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctimporterunitdocHPP
