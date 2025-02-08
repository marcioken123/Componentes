// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLParser.pas' rev: 31.00 (Windows)

#ifndef LmdhtmlparserHPP
#define LmdhtmlparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDParser.hpp>
#include <LMDExtParser.hpp>
#include <LMDLex.hpp>
#include <LMDHTMLLex.hpp>
#include <LMDText.hpp>
#include <LMDTable.hpp>
#include <LMDEmbdControl.hpp>
#include <LMDTree.hpp>
#include <LMDHiddenText.hpp>
#include <LMDDTD.hpp>
#include <LMDHTMLSTYLE.hpp>
#include <LMDEntryPoint.hpp>
#include <LMDRule.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmlparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHTMLParser;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHTMLParser : public Lmdextparser::TLMDExtParser
{
	typedef Lmdextparser::TLMDExtParser inherited;
	
private:
	Lmddtd::TLMDDTD* FDTD;
	Lmdhtmlstyle::TLMDHTMLStyle* FStyle;
	int FHiddenModeRef;
	System::Uitypes::TColor __fastcall StrToColor(const System::UnicodeString aColor);
	System::UnicodeString __fastcall StrToFontSize(const System::UnicodeString aValue);
	System::UnicodeString __fastcall ReplaceSpecialChars(const System::UnicodeString aText);
	void __fastcall StoreHiddenText(Lmdtext::TLMDParsedTextList* aParsedText);
	void __fastcall ChopAndNil(Lmdtext::TLMDParsedTextList* &aParsedText);
	void __fastcall OpenHiddenArea(void);
	void __fastcall CloseHiddenArea(void);
	bool __fastcall IsPCDATA(void);
	void __fastcall Process_Hidden(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessDOCTYPE(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTITLE(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessBASE(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessPCDATA(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessHTML(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessHEAD(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessBODY(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessSCRIPT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessSTYLE(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessMETA(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessLINK(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessOBJECT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessINS(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessDEL(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessP(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessH_n(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage, int FontSize);
	void __fastcall ProcessH1(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessH2(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessH3(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessH4(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessH5(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessH6(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessUL(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessOL(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessLI(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessLI_1(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessPRE(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessNOSCRIPT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessHR(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessFontStyle(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage, System::Uitypes::TFontStyle FontStyle);
	void __fastcall ProcessI(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessB(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessBIG(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessSMALL(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessSUNKEN(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessRAISED(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessPCOLOR(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessFONT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessEM(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessSTRONG(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessDFN(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessCODE(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessSAMP(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessKBD(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessVAR(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessCITE(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessABBR(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessACRONYM(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessADDRESS(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessBLOCKQUOTE(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessPARAM(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessDL(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessDT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessDIV(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessCENTER(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessIMG(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessSUB(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessSUP(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessA(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessBR(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessSPAN(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessQ(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessMAP(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessAREA(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessFORM(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessINPUT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTEXTAREA(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessLABEL(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessBUTTON(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessSELECT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessOPTGROUP(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessOPTION(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessFIELDSET(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTABLE(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessCAPTION(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTHEAD(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTFOOT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTBODY(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessCOLGROUP(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessCOL(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTR(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTH(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTD(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessCONTROL(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessTREE(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessITEM(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessREPEAT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessDD(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessBDO(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessLEGEND(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessPLAIN(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessS(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessU(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessBASEFONT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ProcessCLOSEBASEFONT(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall ExceptionHandler(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall Nothing(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall EH_BODY(Lmdtext::TLMDParsedTextList* &aParsedText, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall FillDTD(Lmddtd::TLMDDTD* aDTD);
	bool __fastcall CheckTokenAsTagAttr(const System::UnicodeString aName, System::UnicodeString &aRes);
	
protected:
	virtual Lmdlex::TLMDLexClass __fastcall GetLexClass(void);
	
public:
	__fastcall virtual TLMDHTMLParser(void);
	__fastcall virtual ~TLMDHTMLParser(void);
	virtual Lmdtext::TLMDParsedTextList* __fastcall Parse(System::Classes::TStream* aStream, Lmdtext::TLMDGraphicErrorEvent aGraphicErrorEvent, Lmdtext::TLMDGetVariableEvent aGetVariable, Lmdtext::TLMDEmbdControlEvent aEmbdControlCreated, Lmdtext::TLMDRepeatEvent aRepeatEvent);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhtmlparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLPARSER)
using namespace Lmdhtmlparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmlparserHPP
