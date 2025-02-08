// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSedParser.pas' rev: 31.00 (Windows)

#ifndef LmdsedparserHPP
#define LmdsedparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDSedDocument.hpp>
#include <LMDHashTable.hpp>
#include <LMDXML.hpp>
#include <LMDRegExpr.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsedparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDEditParserError;
class DELPHICLASS ELMDSyntaxSchemeLoadError;
class DELPHICLASS ELMDColorSchemeLoadError;
class DELPHICLASS TLMDEditParser;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDEditParserError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDEditParserError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDEditParserError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDEditParserError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDEditParserError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDEditParserError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDEditParserError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDEditParserError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDEditParserError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDEditParserError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDEditParserError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDEditParserError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDEditParserError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDEditParserError(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDSyntaxSchemeLoadError : public ELMDEditParserError
{
	typedef ELMDEditParserError inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDSyntaxSchemeLoadError(const System::UnicodeString Msg) : ELMDEditParserError(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDSyntaxSchemeLoadError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : ELMDEditParserError(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDSyntaxSchemeLoadError(NativeUInt Ident)/* overload */ : ELMDEditParserError(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDSyntaxSchemeLoadError(System::PResStringRec ResStringRec)/* overload */ : ELMDEditParserError(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDSyntaxSchemeLoadError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : ELMDEditParserError(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDSyntaxSchemeLoadError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : ELMDEditParserError(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDSyntaxSchemeLoadError(const System::UnicodeString Msg, int AHelpContext) : ELMDEditParserError(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDSyntaxSchemeLoadError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : ELMDEditParserError(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDSyntaxSchemeLoadError(NativeUInt Ident, int AHelpContext)/* overload */ : ELMDEditParserError(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDSyntaxSchemeLoadError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : ELMDEditParserError(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDSyntaxSchemeLoadError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : ELMDEditParserError(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDSyntaxSchemeLoadError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : ELMDEditParserError(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDSyntaxSchemeLoadError(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDColorSchemeLoadError : public ELMDEditParserError
{
	typedef ELMDEditParserError inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDColorSchemeLoadError(const System::UnicodeString Msg) : ELMDEditParserError(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDColorSchemeLoadError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : ELMDEditParserError(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDColorSchemeLoadError(NativeUInt Ident)/* overload */ : ELMDEditParserError(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDColorSchemeLoadError(System::PResStringRec ResStringRec)/* overload */ : ELMDEditParserError(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDColorSchemeLoadError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : ELMDEditParserError(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDColorSchemeLoadError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : ELMDEditParserError(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDColorSchemeLoadError(const System::UnicodeString Msg, int AHelpContext) : ELMDEditParserError(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDColorSchemeLoadError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : ELMDEditParserError(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDColorSchemeLoadError(NativeUInt Ident, int AHelpContext)/* overload */ : ELMDEditParserError(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDColorSchemeLoadError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : ELMDEditParserError(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDColorSchemeLoadError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : ELMDEditParserError(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDColorSchemeLoadError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : ELMDEditParserError(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDColorSchemeLoadError(void) { }
	
};

#pragma pack(pop)

typedef Lmdtypes::TLMDString __fastcall (__closure *TLMDEditParserSchemeLoader)(const Lmdtypes::TLMDString ASchemeName);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditParser : public Lmdseddocument::TLMDEditParserBase
{
	typedef Lmdseddocument::TLMDEditParserBase inherited;
	
private:
	System::TObject* FImpl;
	Lmdtypes::TLMDString __fastcall GetSchemesDir(void);
	Lmdtypes::TLMDString __fastcall GetAttrsDir(void);
	void __fastcall SetSchemesDir(Lmdtypes::TLMDString ADir);
	void __fastcall SetAttrsDir(Lmdtypes::TLMDString ADir);
	
protected:
	virtual void __fastcall SetDocument(Lmdseddocument::TLMDEditDocument* ADoc);
	
public:
	__fastcall TLMDEditParser(void);
	__fastcall virtual ~TLMDEditParser(void);
	void __fastcall UnloadSchemes(void);
	void __fastcall LoadSchemeDoc(const Lmdtypes::TLMDString ADocName, const Lmdtypes::TLMDString AttrsDocName);
	void __fastcall SetSchemeLoaders(TLMDEditParserSchemeLoader ASyntaxLoader, TLMDEditParserSchemeLoader AColorLoader);
	virtual void __fastcall MarkTokens(int ALine, Lmdseddocument::TLMDTokenHandler* const AHandler);
	virtual Lmdseddocument::TLMDEditParsedLine* __fastcall GetParsedLine(int ALine);
	virtual void __fastcall LineChanged(int ALine);
	virtual void __fastcall LinesChangedFrom(int AStart);
	virtual void __fastcall Refresh(void);
	virtual int __fastcall GetParentLine(int ALine);
	virtual int __fastcall GetFoldEnd(int ALineStart);
	virtual int __fastcall GetFoldStart(int ALineEnd);
	virtual bool __fastcall IsFoldStart(int ALine);
	virtual bool __fastcall IsFoldEnd(int ALine);
	virtual void __fastcall EnsureLineParsed(int ALine);
	virtual Lmdtypes::TLMDIntArray __fastcall GetAllTokenIDs(const Lmdtypes::TLMDString ATokenName);
	virtual void __fastcall SetMaxLineLengthToParse(int AValue);
	__property Lmdtypes::TLMDString SchemesDir = {read=GetSchemesDir, write=SetSchemesDir};
	__property Lmdtypes::TLMDString AttrsDir = {read=GetAttrsDir, write=SetAttrsDir};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDDecodeTokenXML(const Lmdxml::_di_ILMDXmlNode ANode, Lmdseddocument::TLMDEditAttributes &Attrs, Lmdtypes::TLMDString &AName);
}	/* namespace Lmdsedparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEDPARSER)
using namespace Lmdsedparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsedparserHPP
