// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFAnalyser.pas' rev: 31.00 (Windows)

#ifndef LmdrtfanalyserHPP
#define LmdrtfanalyserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDRTFTape.hpp>
#include <LMDRTFDocument.hpp>
#include <System.SyncObjs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfanalyser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFAnalyser;
class DELPHICLASS TLMDRTFGDSAnalyser;
class DELPHICLASS TLMDRTFFontTblAnalyser;
class DELPHICLASS TLMDRTFFileTblAnalyser;
class DELPHICLASS TLMDRTFColorTblAnalyser;
class DELPHICLASS TLMDRTFStyleTblAnalyser;
class DELPHICLASS TLMDRTFSectionAnalyser;
//-- type declarations -------------------------------------------------------
typedef bool *pboolean;

class PASCALIMPLEMENTATION TLMDRTFAnalyser : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	Lmdrtftape::TLMDRTFTape* FTape;
	Lmdrtfdocument::TLMDRTFDocument* FDocument;
	int FHeadPosition;
	Lmdrtftape::TLMDRTFTapeCell* FHeadValue;
	bool *FFinished;
	
protected:
	void __fastcall MoveNext(void);
	virtual void __fastcall Look(void) = 0 ;
	virtual void __fastcall Strip(void) = 0 ;
	__property Lmdrtftape::TLMDRTFTapeCell* Head = {read=FHeadValue};
	__property Lmdrtfdocument::TLMDRTFDocument* Document = {read=FDocument};
	
public:
	__fastcall virtual ~TLMDRTFAnalyser(void);
	__fastcall TLMDRTFAnalyser(Lmdrtftape::TLMDRTFTape* aTape, Lmdrtfdocument::TLMDRTFDocument* aDocument, pboolean aFinished);
	virtual void __fastcall Execute(void);
};


class PASCALIMPLEMENTATION TLMDRTFGDSAnalyser : public TLMDRTFAnalyser
{
	typedef TLMDRTFAnalyser inherited;
	
protected:
	virtual void __fastcall Look(void);
	virtual void __fastcall Strip(void);
public:
	/* TLMDRTFAnalyser.Destroy */ inline __fastcall virtual ~TLMDRTFGDSAnalyser(void) { }
	/* TLMDRTFAnalyser.Create */ inline __fastcall TLMDRTFGDSAnalyser(Lmdrtftape::TLMDRTFTape* aTape, Lmdrtfdocument::TLMDRTFDocument* aDocument, pboolean aFinished) : TLMDRTFAnalyser(aTape, aDocument, aFinished) { }
	
};


class PASCALIMPLEMENTATION TLMDRTFFontTblAnalyser : public TLMDRTFAnalyser
{
	typedef TLMDRTFAnalyser inherited;
	
protected:
	virtual void __fastcall Look(void);
	virtual void __fastcall Strip(void);
public:
	/* TLMDRTFAnalyser.Destroy */ inline __fastcall virtual ~TLMDRTFFontTblAnalyser(void) { }
	/* TLMDRTFAnalyser.Create */ inline __fastcall TLMDRTFFontTblAnalyser(Lmdrtftape::TLMDRTFTape* aTape, Lmdrtfdocument::TLMDRTFDocument* aDocument, pboolean aFinished) : TLMDRTFAnalyser(aTape, aDocument, aFinished) { }
	
};


class PASCALIMPLEMENTATION TLMDRTFFileTblAnalyser : public TLMDRTFAnalyser
{
	typedef TLMDRTFAnalyser inherited;
	
protected:
	virtual void __fastcall Look(void);
	virtual void __fastcall Strip(void);
public:
	/* TLMDRTFAnalyser.Destroy */ inline __fastcall virtual ~TLMDRTFFileTblAnalyser(void) { }
	/* TLMDRTFAnalyser.Create */ inline __fastcall TLMDRTFFileTblAnalyser(Lmdrtftape::TLMDRTFTape* aTape, Lmdrtfdocument::TLMDRTFDocument* aDocument, pboolean aFinished) : TLMDRTFAnalyser(aTape, aDocument, aFinished) { }
	
};


class PASCALIMPLEMENTATION TLMDRTFColorTblAnalyser : public TLMDRTFAnalyser
{
	typedef TLMDRTFAnalyser inherited;
	
protected:
	virtual void __fastcall Look(void);
	virtual void __fastcall Strip(void);
public:
	/* TLMDRTFAnalyser.Destroy */ inline __fastcall virtual ~TLMDRTFColorTblAnalyser(void) { }
	/* TLMDRTFAnalyser.Create */ inline __fastcall TLMDRTFColorTblAnalyser(Lmdrtftape::TLMDRTFTape* aTape, Lmdrtfdocument::TLMDRTFDocument* aDocument, pboolean aFinished) : TLMDRTFAnalyser(aTape, aDocument, aFinished) { }
	
};


class PASCALIMPLEMENTATION TLMDRTFStyleTblAnalyser : public TLMDRTFAnalyser
{
	typedef TLMDRTFAnalyser inherited;
	
protected:
	virtual void __fastcall Look(void);
	virtual void __fastcall Strip(void);
public:
	/* TLMDRTFAnalyser.Destroy */ inline __fastcall virtual ~TLMDRTFStyleTblAnalyser(void) { }
	/* TLMDRTFAnalyser.Create */ inline __fastcall TLMDRTFStyleTblAnalyser(Lmdrtftape::TLMDRTFTape* aTape, Lmdrtfdocument::TLMDRTFDocument* aDocument, pboolean aFinished) : TLMDRTFAnalyser(aTape, aDocument, aFinished) { }
	
};


class PASCALIMPLEMENTATION TLMDRTFSectionAnalyser : public TLMDRTFAnalyser
{
	typedef TLMDRTFAnalyser inherited;
	
protected:
	virtual void __fastcall Look(void);
	virtual void __fastcall Strip(void);
public:
	/* TLMDRTFAnalyser.Destroy */ inline __fastcall virtual ~TLMDRTFSectionAnalyser(void) { }
	/* TLMDRTFAnalyser.Create */ inline __fastcall TLMDRTFSectionAnalyser(Lmdrtftape::TLMDRTFTape* aTape, Lmdrtfdocument::TLMDRTFDocument* aDocument, pboolean aFinished) : TLMDRTFAnalyser(aTape, aDocument, aFinished) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfanalyser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFANALYSER)
using namespace Lmdrtfanalyser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfanalyserHPP
