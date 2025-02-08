// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIterator.pas' rev: 31.00 (Windows)

#ifndef LmditeratorHPP
#define LmditeratorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDText.hpp>
#include <LMDTable.hpp>
#include <LMDTree.hpp>
#include <LMDEmbdControl.hpp>
#include <LMDHiddenText.hpp>
#include <LMDTextBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmditerator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDIterator;
class DELPHICLASS TLMDImageIterator;
class DELPHICLASS TLMDListIterator;
class DELPHICLASS TLMDListItemIterator;
class DELPHICLASS TLMDParagraphIterator;
class DELPHICLASS TLMDTableIterator;
class DELPHICLASS TLMDTreeIterator;
class DELPHICLASS TLMDEmbdControlIterator;
class DELPHICLASS TLMDTextIterator;
class DELPHICLASS TLMDHiddenTextIterator;
class DELPHICLASS TLMDContainerIterator;
class DELPHICLASS TLMDTextBoxIterator;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TLMDIteratorClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIterator : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdtext::TLMDParsedTextList* FDataTree;
	Lmdtext::TLMDBaseText* FCurrentData;
	bool FEof;
	bool FBof;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	__fastcall TLMDIterator(Lmdtext::TLMDParsedTextList* AData);
	virtual Lmdtext::TLMDBaseText* __fastcall Current(void);
	bool __fastcall IsEmpty(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual void __fastcall Prev(void);
	virtual void __fastcall Last(void);
	__property bool Eof = {read=FEof, nodefault};
	__property bool Bof = {read=FBof, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDImageIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdtext::TLMDImage* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDImageIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDImageIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDListIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdtext::TLMDParseList* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDListIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDListIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDListItemIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdtext::TLMDParseListItem* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDListItemIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDListItemIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParagraphIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdtext::TLMDParagraph* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDParagraphIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDParagraphIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTableIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdtable::TLMDTable* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDTableIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDTableIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTreeIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdtree::TLMDTree* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDTreeIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDTreeIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEmbdControlIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdembdcontrol::TLMDEmbdControl* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDEmbdControlIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEmbdControlIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTextIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdtext::TLMDText* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDTextIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDTextIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHiddenTextIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdhiddentext::TLMDHiddenText* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDHiddenTextIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDHiddenTextIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDContainerIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdtext::TLMDParsedTextList* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDContainerIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDContainerIterator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTextBoxIterator : public TLMDIterator
{
	typedef TLMDIterator inherited;
	
protected:
	virtual bool __fastcall IsThis(Lmdtext::TLMDBaseText* AItem);
	
public:
	HIDESBASE Lmdtextbox::TLMDTextBox* __fastcall Current(void);
public:
	/* TLMDIterator.Create */ inline __fastcall TLMDTextBoxIterator(Lmdtext::TLMDParsedTextList* AData) : TLMDIterator(AData) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDTextBoxIterator(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmditerator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDITERATOR)
using namespace Lmditerator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmditeratorHPP
